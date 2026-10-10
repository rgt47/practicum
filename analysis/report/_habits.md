1. **The compendium is the unit.** Code, data, environment, and
   document travel together, in one declared structure.
2. **Raw data are evidence; derived data are a build product.**
   Never edit what you received; regenerate everything else.
3. **Version control from day one.** Every change is a commit;
   tag what you submit.
4. **Pin the environment.** Snapshot writes the lockfile, restore
   reads it, and a container pins what the lockfile cannot.
5. **Pre-specify, then tag.** Write the analysis plan and tag it
   before you see the outcome.
6. **Count before and after every join.** Declare the
   relationship you expect and let the code refuse anything else.
7. **Convert late, validate early.** Keep types loose while
   reading and cleaning; check them hard before modeling.
8. **A bug that produces a plausible number is the expensive
   kind.** A bug that produces `NA` announces itself; write the
   assertion that makes the quiet one loud.
9. **Test the statistics, not the shape.** A test that only checks
   that a column exists passes on a wrong answer.
10. **Every number in the prose is computed.** Typed numbers drift
    from the analysis that produced them.
11. **Lead with the answer, and match the verb to the design.**
    Say what you found first; say 'is associated with' unless the
    design licenses 'causes'.
12. **Every model output is a hypothesis until verified.** Send a
    language model structure, not data, and check what it returns
    as you would check a junior colleague's work.
