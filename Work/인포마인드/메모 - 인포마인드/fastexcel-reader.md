---
date: 2024-03-12 16:55:11
created: 2024-03-12 16:52:30
categories:
- 인포마인드 / 메모 - 인포마인드
---

## fastexcel-reader

<br>

```
try (
        InputStream is = Files.newInputStream(Paths.get("C:/SourceTree/test/untitled/src/main/resources/test.xlsx"));
        ReadableWorkbook wb = new ReadableWorkbook(is)
) {
    Sheet sheet = wb.getFirstSheet();
    try (Stream<Row> rows = sheet.openStream()) {
        rows.forEach(r -> {
            System.out.println(r);
        });
    } catch (IOException e) {
        throw new RuntimeException(e);
    }
} catch (IOException e) {
    throw new RuntimeException(e);
}
```

<br>