# Automatentafel Generator

Für das Modul Nachrichtencodierung habe ich hier einen PDF Generator erstellt, welcher abhängig von einigen Parametern eine leere Automatentafel als PDF erstellen kann.

Da ich keine gute LaTeX Library gefunden habe. Nutze ich folgende self-hosted API: https://github.com/chialab/math-api

### Parameter

- `binary_states`: Gibt die Anzahl der Speicher an. Die Anzahl der Zustände ermittelt sich dann mit ![](https://math.vercel.app?from=2^{n_\text{Speicher}}).
- `binary_inputs`: Die Anzahl der Input-Stellen. 2 Stellen würde zu ![](https://math.vercel.app?from=2^2=4) Eingangswerten führen.
- `binary_outputs`: Die Anzahl der Output-Stellen. 2 Stellen würde zu einem Ausgang ![](https://math.vercel.app?from=A_1) und ![](https://math.vercel.app?from=A_2)  führen.

### Beispiel

`binary_states = 2`
<br>
`binary_inputs = 1`
<br>
`binary_outputs = 1`
<br>

![Example](assets/example.svg)