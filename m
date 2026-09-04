Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F3BC79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 16:25:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93D8842D9F;
	Fri,  4 Sep 2026 18:25:07 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 9940942D9F
 for <dev@dpdk.org>; Fri,  4 Sep 2026 18:25:06 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so1359400b3a.2
 for <dev@dpdk.org>; Fri, 04 Sep 2026 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788539106;
 x=1789143906; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mjT2g/dQfFd4LD1PjxoUrfrSOk917QT3uahR9q0l7I4=;
 b=X0Z1Xy0c7tvHH6AntpfJ9+iqGhlBMpVVkjOxMPP/XCC4lnxVTQogtDbP85cxYdNnE+
 Q+dWLPLIVcTNaMSO4/NxKs/NoGrARxqJEI7bmea+5ts/7HZn72nbaA+VEXLhc4TZL6cw
 +oBup43dgOLZwhI9SG9F0qH2acubOivxYnGEWitGCP7ZnP8tsP/b92ej81tcikAU89/n
 Bg6GJ14B/YZRiXpaGbBQYbMjiezLn1dVvk0O5jLvagpncfbtYyErIud2gcJfRnzUw/MB
 AdCLhd9Z3ufeP33Wd6clLWe9qy6FdI77z3+MmDQqzFEKQovG1TSEyh6m0IB5ibuxH3ZS
 40bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788539106; x=1789143906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mjT2g/dQfFd4LD1PjxoUrfrSOk917QT3uahR9q0l7I4=;
 b=g7Zd2fgvA55A8H+i1MHx62pEooEtZUUUgEC+r6UgBxyKejrYjriK+gKFHxx/0dO6N0
 RNF2y4X69MeZcWArXE7JON//9X3t2+N6joDxFH6iu5yB3WLw5+Oq9+1DBc0Nq5CuElm9
 TErPK7wpliim6Fje5pB1nX0+VXUFu20drckWF6o0lTfKxtbnrr36K7cIDeS9e8Ex00uP
 5JoH3qrji1SVWRMqvyvbPlEHNv3fwwJmbGnTKsZOV5lERy5mCwI9iQN5ym1J7ctSDV+A
 1CaYt/XkhQT/O2o7rVr20704nnboE4pQrp4tKwWJbhVYaH3Hzkp5V7fVl3Cm2MkU5mED
 PyDQ==
X-Gm-Message-State: AFuF++nYxaMy3AusfbpjCAuRhOMRdgjNKM/WGgEj7rneCWYalPpEsSoy
 Z3yd/8xcs/TXvngfj9MjbZCCvMxcBYEAJ5n7mCk8woMyn2dyW173hYqOlHLmtnKXwWzg1UQMtkC
 QdG51
X-Gm-Gg: AYBFou33EHMCjrAPXsQ0fwq3nQek9RQhj2hle/YanpBKqLo3sCtxeGU1QbU0rzYoqiM
 3CJ39odeD6uoJwO+nl182c+v/lQ7SGQY2Ta0rR7qe+VvWRJ4SCu/C+9cNnKVd2+4meAVpZriAdU
 +xWDhaflFj4DlhteXoQXODf9Od286UIqU18K3+V83he2T3Yr8W+b1psQFsbdLt4j0pok0RNHpG2
 2X4lFFdEy9zfMDcOrsTKOaEAcdc4VpIQIe5FKtWm8Tu+GKknHBFsLhd6A3HHHVUv53N98cNqBX7
 cMin3ihevWP9H0/JyRkBqA//E/eTZzpKlS/Yd5YQzYwY2WClJDbOb+VYkRle2aENYgv5ySDi4sZ
 BPYSmkzkv8ewY5nthKgFK+rMxO0ucWVngHhiy4VuF9xR9IoONHWmLWsJOfeiaStvZRJ/T8gz28G
 G3S4n3dgfWHitaUB3VwcfhFjtZAukRtKWdd0yos3r6co6DScbUz6v6quiNDQidmW0QfDftaOyPv
 p8b+XU3WQ/NSeS5Q/Qc5B97Pw8TvN6K5vVWd7o=
X-Received: by 2002:aa7:88c3:0:b0:848:4424:2b8e with SMTP id
 d2e1a72fcca58-861696788b3mr9117584b3a.3.1788539105128; 
 Fri, 04 Sep 2026 09:25:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8615203e041sm1405772b3a.17.2026.09.04.09.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:25:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v2 1/2] AGENTS: reduce false positives
Date: Fri,  4 Sep 2026 09:23:07 -0700
Message-ID: <20260904162454.218213-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904162454.218213-1-stephen@networkplumber.org>
References: <20260829171822.305500-1-stephen@networkplumber.org>
 <20260904162454.218213-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Revise the AGENTS.md file to reduce the number of false positives
from in CI reviews. The existing file will make up non-existent
functions and get confused about exposed API's.

The AI review should not be so verbose. If there is nothing
to say, say nothing at all. This should help reduce the cases
where patch review of something valid gets flagged as warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md | 278 ++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 239 insertions(+), 39 deletions(-)

diff --git a/AGENTS.md b/AGENTS.md
index 813584352b..7732b7f550 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -5,13 +5,16 @@
 
 ## CRITICAL INSTRUCTION - READ FIRST
 
-This document has two categories of review rules with different confidence thresholds:
+This document has two categories of review rules with different confidence thresholds,
+plus rules on evidence and scope that apply to both.
 
 ### 1. Correctness Bugs -- HIGHEST PRIORITY (report at >=50% confidence)
 
 **Always report potential correctness bugs.** These are the most valuable findings.
-When in doubt, report them with a note about your confidence level.
-A possible use-after-free or resource leak is worth mentioning even if you are not certain.
+When in doubt, report them -- subject to the evidence rule below.
+Uncertainty about code you have read is fine:
+a possible use-after-free or resource leak is worth mentioning even if you are not certain.
+Uncertainty about code you have not read is not a finding at all.
 
 Correctness bugs include:
 - Use-after-free (accessing memory after `free`/`rte_free`)
@@ -44,9 +47,93 @@ Correctness bugs include:
 - Rx queue setup silently drops oversized packets instead of enabling scatter or returning an error
 - Rx function selection ignores `scattered_rx` flag or MTU-vs-mbuf-size check
 
-**Do NOT self-censor correctness bugs.** If you identify a code path
-where a resource could leak or memory could be used after free, report it.
-Do not talk yourself out of it.
+**Do NOT self-censor correctness bugs.**
+If you identify a code path where a resource could leak or memory could be used after free,
+report it -- subject to the evidence rule below.
+Do not talk yourself out of a bug you can see.
+Do not talk yourself into one you cannot.
+
+### Evidence rule (applies to every finding)
+
+Every finding must rest on code you have actually read.
+"Read" means a line in the patch, or a file you opened with a tool.
+
+This document is used in two ways and the rule is the same in both.
+
+**Diff only** -- CI, `review-patch.py`, and any run without tool access.
+All you have read is the patch: added and removed lines, plus a few lines of context.
+You cannot see the rest of the file, other callers, or any other file in the tree,
+so any claim that depends on them cannot be made.
+
+**With tool access** -- CLI or agentic use, where you can clone the tree, apply the series,
+grep, and read whole files.
+Read them.
+Check the surrounding function, the callers, and the headers before you report.
+Tool access does not lower the bar; it widens what you are able to read,
+and therefore what you are expected to have read before filing a finding.
+
+In either mode:
+
+- Report a finding only if you can name the line that causes it and quote it verbatim.
+  For anything the patch introduces or changes, that line must be an added or changed line.
+  A note about surrounding code may rest on a line you read in the tree,
+  and is Info only -- see "Pre-existing code" below.
+- The line you quote must itself show the defect you claim.
+  If you claim a missing barrier before a read and the line you quote is a write,
+  the finding is wrong.
+  Delete it rather than reword the claim to fit the quote.
+- Never quote, paraphrase, or reconstruct code you have not read.
+  If you are writing a code block with line numbers you did not read, you are inventing it.
+  Delete the finding.
+- If a claim depends on code you have not read -- other callers, other files,
+  the rest of the function -- either go read it or omit the claim.
+  Do not file it with a caveat, do not call it a risk,
+  and do not ask the author to verify it on your behalf.
+- "presumably", "appears to be", "if this is", "potentially", "could be" used to hedge
+  *what the code says* mean you lack the evidence.
+  Get it or omit the finding.
+  A conditional about *runtime behaviour*, with the line in hand, is not a hedge
+  and is what a correctness finding looks like:
+  "this leaks if `rte_malloc()` returns NULL" is a finding, "this appears to allocate
+  somewhere" is not.
+  The test: would removing the qualifier require reading code you have not read?
+
+The >=50% bar for correctness bugs applies to your judgement about code you have read.
+It is not permission to speculate about code you have not.
+
+### Pre-existing code (applies to every finding)
+
+The unit of review is the patch.
+Code that appears only as diff context, or that you read in the tree but the patch does not touch,
+is not what this author is being asked to fix.
+A finding about such code must never be an Error or a Warning
+and must never withhold a Reviewed-by.
+
+Report it as Info, and say plainly that it is pre-existing and not introduced by this patch.
+This is worth doing: it puts the observation in front of the people working in that code
+so it can be picked up in a separate patch later.
+
+The evidence rule still applies in full.
+An Info note about surrounding code needs the same proof as any other finding:
+you must have read the code and be able to quote the line.
+"Pre-existing" is a lower severity, not a lower standard of evidence.
+
+### Hardening suggestions (applies to every finding)
+
+Validating a value supplied by a cooperating peer -- a PF driver, firmware,
+or the device's own descriptors -- is a hardening suggestion, not a bug.
+Report it as Info.
+
+It becomes a Warning or an Error only when the value crosses a trust boundary,
+or when it drives index, length, or state arithmetic:
+
+- Error: a buffer count from the PF used as a ring index or loop bound
+  without being checked against `nb_desc`
+- Info: clamping a residual length field that a well-behaved PF would never
+  get wrong, where an out-of-range value cannot escape the local computation
+
+"A misbehaving firmware could send garbage" is true of every field in every
+mailbox message.  On its own it is not a severity.
 
 ### 2. Style, Process, and Formatting -- suppress false positives
 
@@ -95,8 +182,11 @@ than one that catches every style issue but misses the bug.
 - Check every `goto error` and early `return`: does it clean up everything allocated so far?
 - Look for use-after-free: after `free(p)`, is `p` accessed again?
 - Check that error codes are propagated, not silently dropped
-- Report at >=50% confidence; note uncertainty if appropriate
-- It is better to report a potential bug that turns out to be safe than to miss a real bug
+- Report at >=50% confidence about code you have read
+- Never substitute a confidence caveat for evidence:
+  if the reasoning depends on code you have not read, go read it or drop the finding
+- It is better to report a potential bug that turns out to be safe than to miss a real bug,
+  provided you can point to the line that causes it
 
 ### Style and process review guidelines
 - Only comment on style/process issues when you have HIGH CONFIDENCE (>80%) that an issue exists
@@ -129,6 +219,8 @@ than one that catches every style issue but misses the bug.
   Do not include a patch in your output just to say "no issues found"
   or to summarize what the patch does.
   Only include patches where you have actual findings to report.
+- Do NOT end the review with a summary section listing every patch in the series.
+  A clean patch must not appear anywhere in the output, including in a summary or status table.
 
 ## Priority Areas (Review These)
 
@@ -515,39 +607,52 @@ than one that catches every style issue but misses the bug.
 
 ### Cryptographic and Security Code
 
-Applies only when the patch touches crypto PMDs (drivers/crypto/),
-the security or ipsec libraries, or code handling key material, IVs,
-or authentication digests. Stays silent on all other patches.
+Applies only when the patch touches crypto PMDs (`drivers/crypto/`),
+the security or ipsec libraries,
+or code handling key material, IVs, or authentication digests.
+Stays silent on all other patches.
 
 - **Non-constant-time digest/tag comparison** (Error):
   When verifying an authentication tag, digest, MAC, or ICV --
   comparing a computed value against an attacker-supplied one to decide accept/reject --
-  plain memcmp leaks timing information.
-  Use rte_memeq_timingsafe() instead.
-  Return semantics differ from memcmp: memcmp returns 0 on equal,
-  rte_memeq_timingsafe() returns true on equal.
-  So `if (memcmp(tag, digest, len))` becomes
-  `if (!rte_memeq_timingsafe(tag, digest, len))`.
-  Do NOT flag memcmp on non-secret data: algorithm IDs, key lengths,
-  capability/feature structs, lookup keys.
+  plain `memcmp()` leaks timing information.
+  Use `rte_memeq_timingsafe()` instead.
+  Return semantics differ: `memcmp()` returns 0 on equal,
+  `rte_memeq_timingsafe()` returns true on equal.
+  So `if (memcmp(tag, digest, len))` becomes `if (!rte_memeq_timingsafe(tag, digest, len))`.
+  Do NOT flag `memcmp()` on non-secret data:
+  algorithm IDs, key lengths, capability/feature structs, lookup keys.
   Only flag comparisons that gate acceptance of attacker-influenced data.
 
 - **Sensitive material not zeroed before free** (Error):
-  Keys, expanded key schedules, HMAC ipad/opad, and session secrets
-  must be wiped, not merely freed -- a plain free leaves secrets in heap.
-  - rte_malloc/rte_zmalloc'd secret: use rte_free_sensitive() instead of rte_free()
-  - local/stack secret going out of scope: rte_memzero_explicit()
-    before return; plain memset() may be optimized away.
-  Do NOT flag buffers that never held secrets (descriptors, dev_info),
-  or memset the compiler cannot elide because the pointer escapes to free.
-
-- **Insecure RNG for keys/IVs** (Error):
-  rte_rand()/rand()/random() are not cryptographically secure;
-  do not use them to generate keys, IVs, or nonces in crypto/security code.
+  Keys, expanded key schedules, HMAC ipad/opad, and session secrets must be wiped,
+  not merely freed -- a plain free leaves secrets in the heap.
+  - `rte_malloc`/`rte_zmalloc`'d secret: use `rte_free_sensitive()` instead of `rte_free()`
+  - local or stack secret going out of scope: `rte_memzero_explicit()` before return;
+    plain `memset()` may be optimized away
+  Flag only where the patch itself allocates, copies, or frees the secret.
+  Do NOT flag buffers that never held secrets (descriptors, `dev_info`),
+  pre-existing free paths the patch does not touch,
+  or `memset()` the compiler cannot elide because the pointer escapes to `free()`.
+  `rte_memzero_explicit()` followed by a plain `rte_free()` is correct
+  and is not a missing `rte_free_sensitive()`.
+
+- **Non-cryptographic RNG for keys/IVs** (Error):
+  `rte_rand()` is seeded from system entropy (`getentropy()`, with RDSEED and TSC fallbacks),
+  but the generator itself is an LFSR and is linear:
+  an observer who sees enough output can recover the state and predict every later value.
+  Good seeding is not sufficient for key, IV, or nonce generation.
+  Use a cryptographic source instead:
+  the device's own entropy source or DRBG,
+  or `getrandom(2)` / `/dev/urandom` in the control path.
+  `rand()` and `random()` are weaker still and must not appear in crypto or security code.
+  Do NOT flag `rte_rand()` used for non-secret purposes:
+  hash seeds (`lib/ipsec/ipsec_sad.c` uses it for `hash_func_init_val`),
+  jitter, backoff, load balancing, or test data.
 
 Do NOT flag:
 - IV/nonce reuse -- a runtime property, not determinable from a patch.
-- memcmp on lengths, algorithm selectors, or non-secret config.
+- `memcmp()` on lengths, algorithm selectors, or non-secret config.
 
 ### Architecture & Patterns
 - Code that violates existing patterns in the code base
@@ -1585,6 +1690,25 @@ rte_foo_internal_helper(void)
 - Export macros go in `.c` files, not headers
 - The build system generates linker version maps automatically
 
+#### What Counts as ABI
+
+ABI concerns apply to symbols and types reachable from an installed header.
+A header is installed only if a meson.build lists it in `headers` or `indirect_headers`.
+
+Most drivers install nothing, but some do.
+`drivers/net/bonding/meson.build` installs `rte_eth_bond.h`,
+`drivers/net/intel/i40e/meson.build` installs `rte_pmd_i40e.h`,
+and bus/pci, bus/vdev and several baseband drivers install public headers as well.
+Check the driver's meson.build rather than assuming either way.
+
+A function declared only in a driver-private header,
+with no `RTE_EXPORT_*` annotation and no presence in an installed header, has no ABI.
+Removing it or changing its signature is not an ABI break,
+and speculation about unseen external callers is not a finding.
+
+This does not weaken the separate requirement that a *new* public function
+carry an `RTE_EXPORT_*` macro; a new public API without one is still a Warning.
+
 #### What NOT to Review
 
 - Do **NOT** flag missing `version.map` updates - maps are auto-generated
@@ -1678,9 +1802,9 @@ Checked by `devtools/checkpatches.sh` -- not duplicated here.
 - [ ] `bool` used for pure true/false variables, parameters, and predicate return types
 - [ ] Shared variables use `rte_atomic_*_explicit()`, not `volatile` or bare access
 - [ ] Memory ordering is the weakest correct choice (`relaxed` for counters, `acquire`/`release` for publish/consume)
-- [ ] Auth tag/digest comparisons use rte_memeq_timingsafe(), not memcmp
-- [ ] Key material zeroed before free (rte_free_sensitive / rte_memzero_explicit)
-- [ ] Keys/IVs/nonces not generated with rte_rand()/rand()/random()
+- [ ] Auth tag/digest comparisons use `rte_memeq_timingsafe()`, not `memcmp()`
+- [ ] Key material zeroed before free (`rte_free_sensitive()` / `rte_memzero_explicit()`)
+- [ ] Keys/IVs/nonces not generated with `rte_rand()`, `rand()`, or `random()`
 
 ### API Tags
 
@@ -1793,8 +1917,9 @@ devtools/get-maintainer.sh <patch-file>
 - `mtu_set` rejects valid MTU when scatter Rx is already enabled
 - Rx function selection ignores `scattered_rx` flag or MTU-vs-mbuf-size comparison
 - Non-constant-time comparison of auth tag/digest/MAC/ICV (timing side channel)
-- Key material or session secrets freed without zeroing (rte_free_sensitive/rte_memzero_explicit)
-- Non-cryptographic RNG (rte_rand/rand/random) used to generate keys, IVs, or nonces
+- Key material or session secrets freed without zeroing
+  (`rte_free_sensitive()` / `rte_memzero_explicit()`)
+- Non-cryptographic RNG (`rte_rand()`, `rand()`, `random()`) used to generate keys, IVs, or nonces
 
 *Process and format errors:*
 - Forbidden tokens in code
@@ -1857,6 +1982,18 @@ devtools/get-maintainer.sh <patch-file>
 - Cross-patch compilation dependencies - you cannot determine patch ordering correctness from review
 - Claims that a symbol "was removed in patch N" causing issues in patch M - assume author ordered correctly
 - Any speculation about whether patches will compile when applied in sequence
+- Any finding about code you have not read - reconstructed from diff context,
+  inferred from other patches, or assumed from a function name
+- Pre-existing problems in code the patch does not touch, as an Error or Warning
+  (report these as Info, labelled pre-existing)
+- ABI or "external callers" concerns for a function in a driver-private header
+  with no `RTE_EXPORT_*` annotation
+- `rte_rand()` used for hash seeds, jitter, backoff, load balancing, or test data
+- Data races *between* ethdev control-path callbacks -- `dev_configure`, `dev_start`,
+  `dev_stop`, `dev_close`, `rx_queue_setup`, `tx_queue_setup` and friends.
+  The ethdev API requires the application to serialise these, so a PMD does not need
+  to lock one against another.
+  Only control-path versus datapath races are findings.
 - Mutexes/locks in process-private memory (standard `malloc`, stack, static non-shared) - these don't need `PTHREAD_PROCESS_SHARED`
 - Use of `rte_spinlock_t` or `rte_rwlock_t` in shared memory (these work correctly without special init)
 - `volatile` used for MMIO/hardware register access in drivers (this is correct usage)
@@ -1875,6 +2012,8 @@ devtools/get-maintainer.sh <patch-file>
 - Minor style preferences
 - Optimization suggestions
 - Alternative approaches
+- Pre-existing bugs in surrounding code that the patch does not introduce,
+  labelled as pre-existing so whoever works on that code next can pick them up
 
 ---
 
@@ -1887,11 +2026,36 @@ When you identify an issue:
 
 Example: This could panic if the string is NULL.
 
+## Output Contract
+
+The review text is parsed by CI, and its severity sets the patchwork badge.
+Shape the output accordingly.
+
+- Include a severity section only when it has at least one finding.
+  Never emit an empty section with placeholder text --
+  no "Errors: none", no "## WARNINGS" followed by "None identified".
+  Empty sections are noise, and every new spelling of "nothing here"
+  is one more string the CI scanner has to recognise as filler.
+- Do not add an overall assessment, verdict, ACCEPT/REJECT line,
+  or a list of what the patch does well.
+  The absence of findings is the verdict.
+- Do not restate what the patch does.
+  The author wrote it and the maintainer has read it.
+- A finding is a conclusion, not a transcript of how you reached it.
+  No "Correction:", no "Re-checking:", no "Actually:",
+  no narration of what you investigated and discarded.
+  Do the tracing first, then write only what survived it.
+- If there are no findings at all, say so in one line and stop.
+- End the review with a single final line:
+  `Review-Result: CLEAN|WARNING|ERROR`
+  CLEAN means no Errors and no Warnings.
+  Info-only findings are still CLEAN.
+
 ---
 
 ## FINAL CHECK BEFORE SUBMITTING REVIEW
 
-Before outputting your review, do two separate passes:
+Before outputting your review, do three separate passes:
 
 ### Pass 1: Verify correctness bugs are included
 
@@ -1899,9 +2063,15 @@ Ask: "Did I trace every error path for resource leaks?
 Did I check for use-after-free?
 Did I verify error codes are propagated?"
 
-If you identified a potential correctness bug but talked yourself out of it, **add it back**.
+If you identified a potential correctness bug but talked yourself out of it, **add it back**,
+provided you can point to the line that causes it.
 It is better to report a possible bug than to miss a real one.
 
+This applies only to bugs you dropped *without checking*.
+A finding you disproved by reading the code -- you traced the path, or opened the file,
+and the code is correct -- is deleted, at any severity, and does not come back here.
+Disproven is not the same as low confidence.
+
 ### Pass 2: Remove style/process false positives
 
 For EACH style/process item, ask: "Did I conclude this is actually fine/correct/acceptable/no issue?"
@@ -1912,4 +2082,34 @@ It should not be in your output.
 An item that says "X is wrong... actually this is correct" is a FALSE POSITIVE and must be removed.
 This applies to style, format, and process items only.
 
-**If your Errors section would be empty after this check, that's fine -- it means the patches are good.**
+### Pass 3: Verify every finding has evidence
+
+For EACH remaining item, of any severity, apply these in order.
+
+1. **Is this about code the patch touches?**
+   If not, demote it to Info and label it as pre-existing.
+   It is never an Error or a Warning, and it never withholds a Reviewed-by.
+
+2. **Can I quote the line that causes it?**
+   An added or changed line for anything the patch introduces;
+   a line you opened in the tree for a pre-existing note.
+   If you cannot, DELETE IT.
+   Demoting to Info in step 1 does not lower this bar.
+
+3. **Does the quoted line show the defect I claim?**
+   If the quote and the claim are about different things, DELETE IT.
+
+4. **Am I hedging about what the code says?**
+   "presumably", "appears to be", "potentially", "could be" applied to the content
+   of the code mean you did not read it: DELETE IT.
+   A conditional about runtime behaviour, with the line quoted, stays.
+
+5. **Does my suggested fix use a current API?**
+   A fix that introduces a deprecated interface is worse than no fix.
+   `rte_smp_mb()`, `rte_smp_rmb()`, `rte_smp_wmb()` are deprecated --
+   use `rte_atomic_thread_fence()`.
+   The `rte_atomicNN_*` family is deprecated -- use `rte_atomic_*_explicit()`.
+   Neither produces a compiler warning, so check before you recommend.
+
+**If your Errors section would be empty after these checks, that's fine --
+it means the patches are good.**
-- 
2.53.0

