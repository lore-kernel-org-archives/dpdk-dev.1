Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E1DC61DCB
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 17:18:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E02D4026D;
	Sat, 29 Aug 2026 19:18:32 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 7C9F14025A
 for <dev@dpdk.org>; Sat, 29 Aug 2026 19:18:31 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc1bcdb3c4cso1495099a12.2
 for <dev@dpdk.org>; Sat, 29 Aug 2026 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788023910;
 x=1788628710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aJ0J9P+Y/+M9UgM8Mg7bAgkmin9a2hBJdZTt0jncOtU=;
 b=WOs3BAu+5RLJkeV3DdyhrRYgK4zORav1neF2TOpfNHr4/lDnpzZ6xdqb6BuEU/fMt7
 2MfMj02DrSOyOeQL+h657ltS6RFcWpV2LlNOgJWW3ZAva1z1hNTG3ZWuOWYOpej5NxiR
 sPMDTnZ575IRdKxXKHS5ObdcyYMe1Ht/DTXCxYsYhZtq4LSwoh3TKRqWolKmSI76yl8L
 hyr3+2JMBPu3DQboQjxukrEIbzv7RuMQDWBFyKfKwNOuJtYUYHbCMPztokIH6AkTrPKH
 VU3dRJX9Oh+Sg0iAxujsrsQ+CLWmc3LZI3+zc7eyrES+jN0bN19SgYFklWmEyw0PvQZY
 dgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788023910; x=1788628710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJ0J9P+Y/+M9UgM8Mg7bAgkmin9a2hBJdZTt0jncOtU=;
 b=FTlCym4pnHhfblGMwWUA0y6QdEf5nTkI5FVmmXJ3u+I/6SQOVyq5sWTLfz6Re+YEL/
 VhaF9O3tYn85VtnDsdzf1dfAfRkK0ItRVDvTezXLLNxgoceNN0xRLKiqTS6ceeaNKAVi
 +5N8btrQRNsAa/RfHg91XujwiOAEeJBNAv5qL5xXKPe0Er2A46oAmHj9nEEP2htsGtQy
 YA0G1wEB5wmiVUkV+N2i6zSGo/GmkBqqLoICCjOoNVTk5Kwxpm/69sxeK2I5my4dhWmJ
 DJbPYAI9r1pNBxppEXgNNY48n62eAV0/ORpGAseT0py1MZtzuuhtUaEKwLoXfkkUkPu+
 EnmA==
X-Gm-Message-State: AFuF++mZrAyNLxyxIarqkQTTe8TSGLjvTxGCiM07M3/tXDOvX0ke9CdS
 q7krbw8A3bX7BXO82kGcTPo8oh1HiRkEQ6ZZVMwRJ6mvJPCGooJccVwhvfubfrrVyQNOUkWN8eh
 iQ89c
X-Gm-Gg: AYBFou0lRjna1Ep/My8EMP/tAdA7w03xjarjYQwqHNs3pdV8YJAOnChcf55VqRFIKln
 AyRTceIxP0af8pOYO9442S8GsopqDGh1Tk/buRElUw56zuLUGRMOvZFD1nJx1ix4CBP4JkWJ+21
 eGWBV55B2gwz6NnI1KTbBoQAn5eAFX/KMdXIjIiucK221yDiw7Y9iA49JD7hG6y/xrAoC0I7d6D
 +3WgPDjyxL5G9mgp01CgojjmkYGFdXayMAHvR3cU995kzATyPOKEJmmNg7Mwykeksf5LErv6eKz
 Hv4qUMuWZV54JL50nji7clbyyt2UWPcMr4nHH3AGAURc2lyEZ42u4C/qDJ+2TNjZO2nUVtmj8Y8
 I31BtrYvN9NK+t3qo0AnDTPGzUhqc6PZWAT5vrA1FxztigYzQB3g1LmjPOLvLSIwLd2C0rKA+gA
 xS5H4RcSng6czPBREV1xPbo+P4rPCvbj9Kfk0LbwKKqgp6B7Tfuwp78FN8pEOVY8lgbmOrC50DN
 05Oka2G5h4h/qulrdPqC4Yws/c=
X-Received: by 2002:a17:90b:4fc7:b0:395:bbfe:fc6f with SMTP id
 98e67ed59e1d1-396d0e26cb3mr26619617a91.3.1788023909945; 
 Sat, 29 Aug 2026 10:18:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fcfa3asm12271619a91.6.2026.08.29.10.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 10:18:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH] AGENTS: reduce false positives
Date: Sat, 29 Aug 2026 10:18:21 -0700
Message-ID: <20260829171822.305500-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Also, reflow the text on sentence boundaries instead of hard
limits at 70 cols.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md | 199 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 160 insertions(+), 39 deletions(-)

diff --git a/AGENTS.md b/AGENTS.md
index 813584352b..104d59ef91 100644
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
@@ -44,9 +47,65 @@ Correctness bugs include:
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
+- Report a finding only if you can name the added or changed line that causes it,
+  and quote that line verbatim from what you read.
+- Never quote, paraphrase, or reconstruct code you have not read.
+  If you are writing a code block with line numbers you did not read, you are inventing it.
+  Delete the finding.
+- If a claim depends on code you have not read -- other callers, other files,
+  the rest of the function -- either go read it or omit the claim.
+  Do not file it with a caveat, do not call it a risk,
+  and do not ask the author to verify it on your behalf.
+- "presumably", "appears to be", "if this is", "potentially", "could be" inside a finding
+  mean you lack the evidence.
+  Get the evidence or omit the finding.
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
 
 ### 2. Style, Process, and Formatting -- suppress false positives
 
@@ -95,8 +154,11 @@ than one that catches every style issue but misses the bug.
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
@@ -129,6 +191,8 @@ than one that catches every style issue but misses the bug.
   Do not include a patch in your output just to say "no issues found"
   or to summarize what the patch does.
   Only include patches where you have actual findings to report.
+- Do NOT end the review with a summary section listing every patch in the series.
+  A clean patch must not appear anywhere in the output, including in a summary or status table.
 
 ## Priority Areas (Review These)
 
@@ -515,39 +579,52 @@ than one that catches every style issue but misses the bug.
 
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
@@ -1585,6 +1662,25 @@ rte_foo_internal_helper(void)
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
@@ -1678,9 +1774,9 @@ Checked by `devtools/checkpatches.sh` -- not duplicated here.
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
 
@@ -1793,8 +1889,9 @@ devtools/get-maintainer.sh <patch-file>
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
@@ -1857,6 +1954,13 @@ devtools/get-maintainer.sh <patch-file>
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
 - Mutexes/locks in process-private memory (standard `malloc`, stack, static non-shared) - these don't need `PTHREAD_PROCESS_SHARED`
 - Use of `rte_spinlock_t` or `rte_rwlock_t` in shared memory (these work correctly without special init)
 - `volatile` used for MMIO/hardware register access in drivers (this is correct usage)
@@ -1875,6 +1979,8 @@ devtools/get-maintainer.sh <patch-file>
 - Minor style preferences
 - Optimization suggestions
 - Alternative approaches
+- Pre-existing bugs in surrounding code that the patch does not introduce,
+  labelled as pre-existing so whoever works on that code next can pick them up
 
 ---
 
@@ -1891,7 +1997,7 @@ Example: This could panic if the string is NULL.
 
 ## FINAL CHECK BEFORE SUBMITTING REVIEW
 
-Before outputting your review, do two separate passes:
+Before outputting your review, do three separate passes:
 
 ### Pass 1: Verify correctness bugs are included
 
@@ -1899,7 +2005,8 @@ Ask: "Did I trace every error path for resource leaks?
 Did I check for use-after-free?
 Did I verify error codes are propagated?"
 
-If you identified a potential correctness bug but talked yourself out of it, **add it back**.
+If you identified a potential correctness bug but talked yourself out of it, **add it back**,
+provided you can point to the line that causes it.
 It is better to report a possible bug than to miss a real one.
 
 ### Pass 2: Remove style/process false positives
@@ -1912,4 +2019,18 @@ It should not be in your output.
 An item that says "X is wrong... actually this is correct" is a FALSE POSITIVE and must be removed.
 This applies to style, format, and process items only.
 
-**If your Errors section would be empty after this check, that's fine -- it means the patches are good.**
+### Pass 3: Verify every finding has evidence
+
+For EACH remaining item, of any severity, ask:
+"Did I read the code this claims is broken, or did I reconstruct it?"
+
+If you cannot quote the added or changed line that causes the finding, DELETE IT.
+If the finding is hedged with "presumably", "appears to be", "potentially", or "could be",
+you did not have the evidence: DELETE IT.
+If the finding is about code the patch does not touch, demote it to Info
+and label it as pre-existing -- never an Error or a Warning.
+Demoting the severity does not excuse it from the checks above:
+an Info note you cannot quote a line for is still deleted.
+
+**If your Errors section would be empty after these checks, that's fine --
+it means the patches are good.**
-- 
2.53.0

