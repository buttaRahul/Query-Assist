# Query-Assist

Ask a database questions in plain English, typed or spoken, and get back the SQL query and its results.

```
"select all students with ssc marks greater than 30 and hsc marks greater than 60 and id greater than 5"
        ↓
SELECT * FROM student WHERE ssc > 30 AND hsc > 60 AND id > 5
```

This is an early, rule-based prototype of a natural-language-to-SQL system, built in 2023 before LLM-based text-to-SQL was common. Every step from the question to the query is explicit and inspectable, so you can see exactly why a question produced a given query.

## How it works

The question goes through a fixed NLP pipeline, with each stage in its own function in `QueryAssist.ipynb`:

1. **Input**: typed text, or speech captured from the microphone and transcribed with the `speech_recognition` library (type `speech` to switch to voice input).
2. **Tokenise and lemmatise**: NLTK tokenisation and TextBlob lemmatisation, then removal of domain-specific filler words ("record", "table", "marks", …).
3. **Map words to schema**: a synonym dictionary (`dict.py`) maps words to columns, keywords and operators. For example, "10th" maps to `ssc`, "fetch" or "show" to `SELECT`, "whose" or "with" to `WHERE`, "descending" to `DESC`.
4. **Resolve comparison logic**: "greater than", "less than" and "equal to" become `>`, `<` and `=`, with negation handled ("not greater than" becomes `<`). Number words are converted to digits with `word2number`.
5. **POS tagging**: NLTK part-of-speech tags separate attribute names from values and conditions.
6. **Slot filling**: keywords are assigned to query slots (`<action>`, `<attr_name>`, `<table_name>`, `<condition_name>`, `<condition>`, `<value>`, `<logic>`), split around the `WHERE` boundary.
7. **Query generation**: the slots are assembled into a SQL string, including multiple `AND`/`OR` conditions, `ORDER BY`, and aggregates such as `AVG`.
8. **Execution**: the query runs against MySQL and the results appear in a Tkinter table.

## Supported queries

- Selecting columns or all columns: "show all details of students…"
- One or more conditions joined with `AND` / `OR`
- Comparisons `>`, `<`, `=`, including negation
- Numbers written as digits or words ("thirty")
- Ascending and descending ordering
- Averages

## Limitations

- **Single schema.** The synonym dictionary is written for the bundled `student` table (`id`, `name`, `ssc`, `hsc`, `aggregate`). A new schema needs a new dictionary.
- **No joins or nested queries.** The grammar covers one table.
- **Brittle to phrasing outside the dictionary.** Rules don't generalise the way a learned model does. This is the main trade-off against neural text-to-SQL.

## Run it

```bash
pip install nltk textblob spacy word2number SpeechRecognition mysql-connector-python torchaudio
python -m nltk.downloader punkt wordnet averaged_perceptron_tagger
```

1. Create the database: `mysql -u root -p -e "CREATE DATABASE student1"`, then `mysql -u root -p student1 < student.sql`.
2. Set your MySQL credentials in the `dataBaseLink` cell of `QueryAssist.ipynb` (the defaults are local placeholders).
3. Run all cells. A window opens: type a question, or type `speech` and speak, then press the button.

Voice input needs a working microphone and internet access, since transcription uses Google's speech API.

## Files

| File | Contents |
|---|---|
| `QueryAssist.ipynb` | The full pipeline and the Tkinter UI |
| `dict.py` | Synonym dictionaries mapping words to SQL keywords, columns and operators |
| `student.sql` | Sample `student` table with data |
