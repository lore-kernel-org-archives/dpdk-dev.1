Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049ABE9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 14:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E754D40269;
	Wed, 18 Feb 2026 15:59:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D2A104014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 15:59:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771426770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xz22/t5Ux3d683dFFThNPRoySslViq2d5uK9qQmsk/0=;
 b=TkW5yYCalcWKlvBZS+IWer296bFxp1jKb9H8+KbdWsp8LSuFvD/HpXqR+qVYZEcVeaSkzK
 7uN3JK/f9szZiqDAla+sd01vzBiEFpqxE98evdZy1SKecDdY/AdQ2VS4hJEpx0w4S1+KSO
 j28HvR5OTRjb6T1lCBPXcLfxQkCaaJw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-MLY8kAnPNo6J_3Ej40tD9A-1; Wed,
 18 Feb 2026 09:59:26 -0500
X-MC-Unique: MLY8kAnPNo6J_3Ej40tD9A-1
X-Mimecast-MFC-AGG-ID: MLY8kAnPNo6J_3Ej40tD9A_1771426765
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B3581955EBB; Wed, 18 Feb 2026 14:59:25 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.80.88])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D130B1956095; Wed, 18 Feb 2026 14:59:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,  Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v9 1/6] doc: add AGENTS.md for AI code review tools
In-Reply-To: <20260213214107.234072-2-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Fri, 13 Feb 2026 13:39:06 -0800")
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260213214107.234072-1-stephen@networkplumber.org>
 <20260213214107.234072-2-stephen@networkplumber.org>
Date: Wed, 18 Feb 2026 09:59:21 -0500
Message-ID: <f7t7bsanlme.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3yh1b8EDPsMVwLMyvKtYqakRYkvDWWisR0ye7TC0XdY_1771426765
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Stephen Hemminger <stephen@networkplumber.org> writes:

> Add a reference document that enables AI code review tools to
> validate DPDK patches against project coding standards and
> submission requirements.
>
> The document consolidates guidelines from the DPDK contributor
> documentation, coding style guide, and validation scripts
> (check-git-log.sh, checkpatches.sh) into a single structured
> file. It covers SPDX license requirements, commit message
> formatting, C coding style rules, forbidden token restrictions,
> API tag placement, and severity levels aligned with existing
> validation tool output.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Hi Stephen,

Thanks for working on this - the AGENTS file here is quite
comprehensive, but I have some questions about it.

>  AGENTS.md | 1767 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1767 insertions(+)
>  create mode 100644 AGENTS.md
>
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 0000000000..a7fa39c863
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,1767 @@
> +# AGENTS.md - DPDK Code Review Guidelines for AI Tools
> +
> +## CRITICAL INSTRUCTION - READ FIRST
> +
> +This document has two categories of review rules with different
> +confidence thresholds:
> +
> +### 1. Correctness Bugs -- HIGHEST PRIORITY (report at >=3D50% confidenc=
e)
> +
> +**Always report potential correctness bugs.** These are the most
> +valuable findings. When in doubt, report them with a note about
> +your confidence level. A possible use-after-free or resource leak
> +is worth mentioning even if you are not certain.
> +
> +Correctness bugs include:
> +- Use-after-free (accessing memory after `free`/`rte_free`)
> +- Resource leaks on error paths (memory, file descriptors, locks)
> +- Double-free or double-close
> +- NULL pointer dereference
> +- Buffer overflows or out-of-bounds access
> +- Uninitialized variable use in a reachable code path
> +- Race conditions (unsynchronized shared state)
> +- Missing error checks on functions that can fail
> +- Error paths that skip cleanup (goto labels, missing free/close)
> +- Incorrect error propagation (wrong return value, lost errno)
> +- Logic errors in conditionals (wrong operator, inverted test)
> +- Integer overflow/truncation in size calculations
> +- Missing bounds checks on user-supplied sizes or indices
> +- `mmap()` return checked against `NULL` instead of `MAP_FAILED`
> +- Statistics accumulation using `=3D` instead of `+=3D`
> +- Integer multiply without widening cast losing upper bits (16=C3=9716, =
32=C3=9732, etc.)
> +- Unbounded descriptor chain traversal on guest/API-supplied data
> +- `1 << n` on 64-bit bitmask (must use `1ULL << n` or `RTE_BIT64()`)
> +- Variable assigned then overwritten before being read (dead store)
> +- Same variable used as loop counter in nested loops
> +- `memcpy`/`memcmp`/`memset` with same pointer for source and destinatio=
n (no-op or undefined)
> +
> +**Do NOT self-censor correctness bugs.** If you identify a code
> +path where a resource could leak or memory could be used after
> +free, report it. Do not talk yourself out of it.
> +
> +### 2. Style, Process, and Formatting -- suppress false positives
> +
> +**NEVER list a style/process item under "Errors" or "Warnings" if
> +you conclude it is correct.**
> +
> +Before outputting any style, formatting, or process error/warning,
> +verify it is actually wrong. If your analysis concludes with
> +phrases like "there's no issue here", "which is fine", "appears
> +correct", "is acceptable", or "this is actually correct" -- then
> +DO NOT INCLUDE IT IN YOUR OUTPUT AT ALL. Delete it. Omit it
> +entirely.
> +
> +This suppression rule applies to: SPDX/copyright format, commit
> +message formatting, tag ordering, line length, naming conventions,
> +code style, and process compliance. It does NOT apply to
> +correctness bugs listed above.
> +
> +---
> +
> +This document provides guidelines for AI-powered code review tools
> +when reviewing contributions to the Data Plane Development Kit
> +(DPDK). It is derived from the official DPDK contributor guidelines
> +and validation scripts.
> +
> +## Overview
> +
> +DPDK follows a development process modeled on the Linux Kernel. All
> +patches are reviewed publicly on the mailing list before being
> +merged. AI review tools should verify compliance with the standards
> +outlined below.
> +
> +## Review Philosophy
> +
> +**Correctness bugs are the primary goal of AI review.** Style and
> +formatting checks are secondary. A review that catches a
> +use-after-free but misses a style nit is far more valuable than
> +one that catches every style issue but misses the bug.
> +
> +**BEFORE OUTPUTTING YOUR REVIEW**: Re-read each item.
> +- For correctness bugs: keep them. If you have reasonable doubt
> +  that a code path is safe, report it.
> +- For style/process items: if ANY item contains phrases like "is
> +  fine", "no issue", "appears correct", "is acceptable",
> +  "actually correct" -- DELETE THAT ITEM. Do not include it.
> +
> +### Correctness review guidelines
> +- Trace error paths: for every function that allocates a resource
> +  or acquires a lock, verify that ALL error paths after that point
> +  release it
> +- Check every `goto error` and early `return`: does it clean up
> +  everything allocated so far?
> +- Look for use-after-free: after `free(p)`, is `p` accessed again?
> +- Check that error codes are propagated, not silently dropped
> +- Report at >=3D50% confidence; note uncertainty if appropriate
> +- It is better to report a potential bug that turns out to be safe
> +  than to miss a real bug
> +
> +### Style and process review guidelines
> +- Only comment on style/process issues when you have HIGH CONFIDENCE (>8=
0%) that an issue exists
> +- Be concise: one sentence per comment when possible
> +- Focus on actionable feedback, not observations
> +- When reviewing text, only comment on clarity issues if the text is gen=
uinely
> +  confusing or could lead to errors.
> +- Do NOT comment on copyright years unless outside valid range (2013 to =
current year)
> +- Do NOT report an issue then contradict yourself - if something is acce=
ptable, do not mention it at all
> +- Do NOT include items in Errors/Warnings that you then say are "accepta=
ble" or "correct"
> +- Do NOT mention things that are correct or "not an issue" - only report=
 actual problems
> +- Do NOT speculate about contributor circumstances (employment, company =
policies, etc.)
> +- Before adding any style item to your review, ask: "Is this actually wr=
ong?" If no, omit it entirely.
> +- VERIFY before reporting: For subject line length, COUNT the characters=
 first. If <=3D60, do not mention it.
> +- NEVER write "(Correction: ...)" - if you need to correct yourself, sim=
ply omit the item entirely
> +- Do NOT add vague suggestions like "should be verified" or "should be c=
hecked" - either it's wrong or don't mention it
> +- Do NOT flag something as an Error then say "which is correct" in the s=
ame item
> +- Do NOT say "no issue here" or "this is actually correct" - if there's =
no issue, do not include it in your review
> +- Do NOT call the standard DPDK SPDX/copyright format "different style" =
- it is THE standard
> +- Do NOT analyze cross-patch dependencies or compilation order - you can=
not reliably determine this from patch review
> +- Do NOT claim a patch "would cause compilation failure" based on symbol=
s used in other patches in the series
> +- Review each patch individually for its own correctness; assume the pat=
ch author ordered them correctly
> +- When reviewing a patch series, OMIT patches that have no issues. Do no=
t include a patch in your output just to say "no issues found" or to summar=
ize what the patch does. Only include patches where you have actual finding=
s to report.
> +
> +## Priority Areas (Review These)
> +
> +### Security & Safety
> +- Unsafe code blocks without justification
> +- Command injection risks (shell commands, user input)
> +- Path traversal vulnerabilities
> +- Credential exposure or hard coded secrets
> +- Missing input validation on external data
> +- Improper error handling that could leak sensitive info
> +
> +### Correctness Issues
> +- Logic errors that could cause panics or incorrect behavior
> +- Buffer overflows
> +- Race conditions
> +- Resource leaks (files, connections, memory)
> +- Off-by-one errors or boundary conditions
> +- Incorrect error propagation
> +- **Use-after-free** (any access to memory after it has been freed)
> +- **Error path resource leaks**: For every allocation or fd open,
> +  trace each error path (`goto`, early `return`, conditional) to
> +  verify the resource is released. Common patterns to check:
> +  - `malloc`/`rte_malloc` followed by a failure that does `return -1`
> +    instead of `goto cleanup`
> +  - `open()`/`socket()` fd not closed on a later error
> +  - Lock acquired but not released on an error branch
> +  - Partially initialized structure where early fields are allocated
> +    but later allocation fails without freeing the early ones
> +- **Double-free / double-close**: resource freed in both a normal
> +  path and an error path, or fd closed but not set to -1 allowing
> +  a second close
> +- **Missing error checks**: functions that can fail (malloc, open,
> +  ioctl, etc.) whose return value is not checked
> +- Changes to API without release notes
> +- Changes to ABI on non-LTS release
> +- Usage of deprecated APIs when replacements exist
> +- Overly defensive code that adds unnecessary checks
> +- Unnecessary comments that just restate what the code already shows (re=
move them)
> +- **Process-shared synchronization errors** (pthread mutexes in shared m=
emory without `PTHREAD_PROCESS_SHARED`)
> +- **`mmap()` checked against NULL instead of `MAP_FAILED`**: `mmap()` re=
turns
> +  `MAP_FAILED` (i.e., `(void *)-1`) on failure, NOT `NULL`. Checking
> +  `=3D=3D NULL` or `!=3D NULL` will miss the error and use an invalid po=
inter.
> +  ```c
> +  /* BAD - mmap never returns NULL on failure */
> +  p =3D mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
> +  if (p =3D=3D NULL)       /* WRONG - will not catch MAP_FAILED */
> +      return -1;
> +
> +  /* GOOD */
> +  p =3D mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
> +  if (p =3D=3D MAP_FAILED)
> +      return -1;
> +  ```
> +- **Statistics accumulation using `=3D` instead of `+=3D`**: When accumu=
lating
> +  statistics (counters, byte totals, packet counts), using `=3D` overwri=
tes
> +  the running total with only the latest value. This silently produces
> +  wrong results.
> +  ```c
> +  /* BAD - overwrites instead of accumulating */
> +  stats->rx_packets =3D nb_rx;
> +  stats->rx_bytes =3D total_bytes;
> +
> +  /* GOOD - accumulates over time */
> +  stats->rx_packets +=3D nb_rx;
> +  stats->rx_bytes +=3D total_bytes;
> +  ```
> +  Note: `=3D` is correct for gauge-type values (e.g., queue depth, link
> +  status) and for initial assignment. Only flag when the context is
> +  clearly incremental accumulation (loop bodies, per-burst counters,
> +  callback tallies).
> +- **Integer multiply without widening cast**: When multiplying integers
> +  to produce a result wider than the operands (sizes, offsets, byte
> +  counts), the multiplication is performed at the operand width and
> +  the upper bits are silently lost before the assignment. This applies
> +  to any narrowing scenario: 16=C3=9716 assigned to a 32-bit variable,
> +  32=C3=9732 assigned to a 64-bit variable, etc.
> +  ```c
> +  /* BAD - 32=C3=9732 overflows before widening to 64 */
> +  uint64_t total_size =3D num_entries * entry_size;  /* both are uint32_=
t */
> +  size_t offset =3D ring->idx * ring->desc_size;     /* 32=C3=9732 =E2=
=86=92 truncated */
> +
> +  /* BAD - 16=C3=9716 overflows before widening to 32 */
> +  uint32_t byte_count =3D pkt_len * nb_segs;         /* both are uint16_=
t */
> +
> +  /* GOOD - widen before multiply */
> +  uint64_t total_size =3D (uint64_t)num_entries * entry_size;
> +  size_t offset =3D (size_t)ring->idx * ring->desc_size;
> +  uint32_t byte_count =3D (uint32_t)pkt_len * nb_segs;
> +  ```
> +- **Unbounded descriptor chain traversal**: When walking a chain of
> +  descriptors (virtio, DMA, NIC Rx/Tx rings) where the chain length
> +  or next-index comes from guest memory or an untrusted API caller,
> +  the traversal MUST have a bounds check or loop counter to prevent
> +  infinite loops or out-of-bounds access from malicious/corrupt data.
> +  ```c
> +  /* BAD - guest controls desc[idx].next with no bound */
> +  while (desc[idx].flags & VRING_DESC_F_NEXT) {
> +      idx =3D desc[idx].next;          /* guest-supplied, unbounded */
> +      process(desc[idx]);
> +  }
> +
> +  /* GOOD - cap iterations to descriptor ring size */
> +  for (i =3D 0; i < ring_size; i++) {
> +      if (!(desc[idx].flags & VRING_DESC_F_NEXT))
> +          break;
> +      idx =3D desc[idx].next;
> +      if (idx >=3D ring_size)          /* bounds check */
> +          return -EINVAL;
> +      process(desc[idx]);
> +  }
> +  ```
> +  This applies to any chain/linked-list traversal where indices or
> +  pointers originate from untrusted input (guest VMs, user-space
> +  callers, network packets).
> +- **Bitmask shift using `1` instead of `1ULL` on 64-bit masks**: The
> +  literal `1` is `int` (32 bits). Shifting it by 32 or more is
> +  undefined behavior; shifting it by less than 32 but assigning to a
> +  `uint64_t` silently zeroes the upper 32 bits. Use `1ULL << n`,
> +  `UINT64_C(1) << n`, or the DPDK `RTE_BIT64(n)` macro.
> +  ```c
> +  /* BAD - 1 is int, UB if n >=3D 32, wrong if result used as uint64_t *=
/
> +  uint64_t mask =3D 1 << bit_pos;
> +  if (features & (1 << VIRTIO_NET_F_MRG_RXBUF))  /* bit 15 OK, bit 32+ U=
B */
> +
> +  /* GOOD */
> +  uint64_t mask =3D UINT64_C(1) << bit_pos;
> +  uint64_t mask =3D 1ULL << bit_pos;
> +  uint64_t mask =3D RTE_BIT64(bit_pos);        /* preferred in DPDK */
> +  if (features & RTE_BIT64(VIRTIO_NET_F_MRG_RXBUF))
> +  ```
> +  Note: `1U << n` is acceptable when the mask is known to be 32-bit
> +  (e.g., `uint32_t` register fields with `n < 32`). Only flag when
> +  the result is stored in, compared against, or returned as a 64-bit
> +  type, or when `n` could be >=3D 32.
> +- **Variable overwrite before read (dead store)**: A variable is
> +  assigned a value that is unconditionally overwritten before it is
> +  ever read. This usually indicates a logic error (wrong variable
> +  name, missing `if`, copy-paste mistake) or at minimum is dead code.
> +  ```c
> +  /* BAD - first assignment is never read */
> +  ret =3D validate_input(cfg);
> +  ret =3D apply_config(cfg);     /* overwrites without checking first re=
t */
> +  if (ret !=3D 0)
> +      return ret;
> +
> +  /* GOOD - check each return value */
> +  ret =3D validate_input(cfg);
> +  if (ret !=3D 0)
> +      return ret;
> +  ret =3D apply_config(cfg);
> +  if (ret !=3D 0)
> +      return ret;
> +  ```
> +  Do NOT flag cases where the initial value is intentionally a default
> +  that may or may not be overwritten (e.g., `int ret =3D 0;` followed
> +  by a conditional assignment). Only flag unconditional overwrites
> +  where the first value can never be observed.
> +- **Shared loop counter in nested loops**: Using the same variable as
> +  the loop counter in both an outer and inner loop causes the outer
> +  loop to malfunction because the inner loop modifies its counter.
> +  ```c
> +  /* BAD - inner loop clobbers outer loop counter */
> +  int i;
> +  for (i =3D 0; i < nb_queues; i++) {
> +      setup_queue(i);
> +      for (i =3D 0; i < nb_descs; i++)    /* BUG: reuses i */
> +          init_desc(i);
> +  }
> +
> +  /* GOOD - distinct loop counters */
> +  for (int i =3D 0; i < nb_queues; i++) {
> +      setup_queue(i);
> +      for (int j =3D 0; j < nb_descs; j++)
> +          init_desc(j);
> +  }
> +  ```
> +- **`memcpy`/`memcmp`/`memset` self-argument (same pointer as both
> +  operands)**: Passing the same pointer as both source and destination
> +  to `memcpy()` is undefined behavior per C99. Passing the same
> +  pointer to both arguments of `memcmp()` is a no-op that always
> +  returns 0, indicating a logic error (usually a copy-paste mistake
> +  with the wrong variable name). The same applies to `rte_memcpy()`
> +  and `memmove()` with identical arguments.
> +  ```c
> +  /* BAD - memcpy with same src and dst is undefined behavior */
> +  memcpy(buf, buf, len);
> +  rte_memcpy(dst, dst, len);
> +
> +  /* BAD - memcmp with same pointer always returns 0 (logic error) */
> +  if (memcmp(key, key, KEY_LEN) =3D=3D 0)  /* always true, wrong variabl=
e? */
> +
> +  /* BAD - likely copy-paste: should be comparing two different MACs */
> +  if (memcmp(&eth->src_addr, &eth->src_addr, RTE_ETHER_ADDR_LEN) =3D=3D =
0)
> +
> +  /* GOOD - comparing two different things */
> +  memcpy(dst, src, len);
> +  if (memcmp(&eth->src_addr, &eth->dst_addr, RTE_ETHER_ADDR_LEN) =3D=3D =
0)
> +  ```
> +  This pattern almost always indicates a copy-paste bug where one of
> +  the arguments should be a different variable.
> +
> +### Architecture & Patterns
> +- Code that violates existing patterns in the code base
> +- Missing error handling
> +- Code that is not safe against signals
> +
> +---
> +

Much of the following sections can be written as part of checkpatch,
which means we don't need to spend compute resources with the AI on it.
For example, telling the AI that source files need to begin with SPDX
identifiers, line lenghts, tag format order, tag parsing, etc.  The
downside is that if we ask the AI to *generate* code, then it won't
follow these rules; but when we ask AI to *review* the code, it takes
fewer tokens to submit and we can let the AI do the thing it really
shines at - recognizing subtle patterns, rather than stuff we can write
a python script to do.

I'm approaching this from the perspective of running CI using this
AGENTS.md file - but I might be wrong on the scope of this one, as it
may be intended for something else (like using some IDE integrated
extensions where that stuff can make sense to guide generation).

As for the CI reviewing part, napkin math for Anthropic API shows this
takes up about .30c / patch (~17k tok) we would submit, and that doesn't
include whatever the patch context is - so I think we would exhaust any
budget dedicated to this really early (probably within a few dozen
patches).

Maybe it's possible to split up the AGENTS.md file into stuff that's
good for review and stuff that's good for generation.  WDYT?

> +## Source License Requirements
> +
> +### SPDX License Identifiers
> +
> +Every source file must begin with an SPDX license identifier, followed
> +by the copyright notice, then a blank line before other content.
> +
> +- SPDX tag on first line (or second line for `#!` scripts)
> +- Copyright line immediately follows
> +- Blank line after copyright before any code/includes
> +- Core libraries and drivers use `BSD-3-Clause`
> +- Kernel components use `GPL-2.0`
> +- Dual-licensed code uses: `(BSD-3-Clause OR GPL-2.0)`
> +
> +```c
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2024 John Smith
> + */
> +
> +#include <stdio.h>
> +```
> +
> +For scripts:
> +```python
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2024 Jane Doe
> +
> +import sys
> +```
> +
> +**Do not include boilerplate license text** - the SPDX identifier is suf=
ficient.
> +
> +**Do NOT flag copyright years** - Copyright years reflect when code was =
written. Valid years range from 2013 (DPDK's first release) through the cur=
rent year. Only flag years outside this range (e.g., years before 2013 or f=
uture years beyond the current date).
> +
> +**Copyright holders can be individuals or organizations** - Both are equ=
ally valid. NEVER comment on, question, or speculate about copyright holder=
s. Do not mention employer policies, company resources, or suggest copyrigh=
t "should" be assigned differently. The copyright holder's choice is not su=
bject to review.
> +
> +**The following SPDX/copyright format is correct** - do NOT flag it or c=
omment on it:
> +```c
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Stephen Hemminger
> + */
> +```
> +This is the standard DPDK format. Do not say it is "different" or "unusu=
al" - it is correct.
> +Do not suggest the copyright year "should be verified" - if it's in the =
valid range (2013-current year), it's fine.
> +If SPDX is on line 1 and copyright follows, this is CORRECT - do not inc=
lude it in Errors.
> +
> +---
> +
> +## Commit Message Requirements
> +
> +### Subject Line (First Line)
> +
> +| Rule | Limit |
> +|------|-------|
> +| Maximum length | **60 characters** |
> +| Format | `component: lowercase description` |
> +| Case | Lowercase except acronyms |
> +| Mood | Imperative (instructions to codebase) |
> +| Punctuation | **No trailing period** |
> +
> +**Before flagging subject line length**: Actually count the characters. =
Only flag if >60. Do not flag then correct yourself.
> +
> +```
> +# Good examples
> +net/ixgbe: fix offload config option name
> +config: increase max queues per port
> +net/mlx5: add support for flow counters
> +app/testpmd: fix memory leak in flow create
> +
> +# Bad examples
> +Fixed the offload config option.    # past tense, has period, no prefix
> +net/ixgbe: Fix Offload Config       # uppercase after colon
> +ixgbe: fix something                # wrong prefix, should be net/ixgbe
> +lib/ethdev: add new feature         # wrong prefix, should be ethdev:
> +```
> +
> +#### Headline Format Errors (from check-git-log.sh)
> +
> +The following are flagged as errors:
> +- Tab characters in subject
> +- Leading or trailing spaces
> +- Trailing period (`.`)
> +- Punctuation marks: `, ; ! ? & |`
> +- Underscores after the colon (indicates code in subject)
> +- Missing colon separator
> +- No space after colon
> +- Space before colon
> +
> +#### Common Prefix Mistakes
> +
> +| Wrong | Correct |
> +|-------|---------|
> +| `ixgbe:` | `net/ixgbe:` |
> +| `lib/ethdev:` | `ethdev:` |
> +| `example:` | `examples/foo:` |
> +| `apps/` | `app/name:` |
> +| `app/test:` | `test:` |
> +| `testpmd:` | `app/testpmd:` |
> +| `test-pmd:` | `app/testpmd:` |
> +| `bond:` | `net/bonding:` |
> +
> +#### Case-Sensitive Terms (Commit Messages Only)
> +
> +These terms must use exact capitalization **in commit messages** (from `=
devtools/words-case.txt`):
> +- `Rx`, `Tx` (not `RX`, `TX`, `rx`, `tx`)
> +- `VF`, `PF` (not `vf`, `pf`)
> +- `MAC`, `VLAN`, `RSS`, `API`
> +- `Linux`, `Windows`, `FreeBSD`
> +- Check `devtools/words-case.txt` for complete list
> +
> +**Note**: These rules apply to commit messages only, NOT to code comment=
s or documentation.
> +
> +### Commit Body
> +
> +| Rule | Limit |
> +|------|-------|
> +| Line wrap | **75 characters** |
> +| Exception | `Fixes:` lines may exceed 75 chars |
> +
> +Body guidelines:
> +- Describe the issue being fixed or feature being added
> +- Provide enough context for reviewers
> +- **Do not start the commit message body with "It"**
> +- **Must end with** `Signed-off-by:` line (real name, not alias)
> +
> +### Fixes Tag
> +
> +When fixing regressions, use the `Fixes:` tag with a 12-character abbrev=
iated SHA:
> +
> +```
> +Fixes: abcdefgh1234 ("original commit subject")
> +```
> +
> +The hash must reference a commit in the current branch, and the subject =
must match exactly.
> +
> +**Do NOT flag Fixes tags** asking for verification that the commit "exis=
ts in the tree" or "cannot verify" - you cannot verify this from a patch re=
view. If the format is correct (12-char SHA, quoted subject), accept it. NE=
VER say "cannot verify this exists".
> +
> +**Finding maintainers**: Use `devtools/get-maintainer.sh` to identify th=
e current subsystem maintainer from the `MAINTAINERS` file, rather than CC'=
ing the original author:
> +
> +```bash
> +git send-email --to-cmd ./devtools/get-maintainer.sh --cc dev@dpdk.org 0=
00*.patch
> +```
> +
> +### Required Tags
> +
> +```
> +# For Coverity issues (required if "coverity" mentioned in body):
> +Coverity issue: 12345
> +
> +# For Bugzilla issues (required if "bugzilla" mentioned in body):
> +Bugzilla ID: 12345
> +
> +# For stable release backport candidates:
> +Cc: stable@dpdk.org
> +
> +# For patch dependencies (in commit notes after ---):
> +Depends-on: series-NNNNN ("Title of the series")
> +```
> +
> +### Tag Order
> +
> +Tags must appear in this order, with a blank line separating the two gro=
ups:
> +
> +**Group 1** (optional tags, no blank lines within this group):
> +- Coverity issue:
> +- Bugzilla ID:
> +- Fixes:
> +- Cc:
> +
> +**Blank line required here** (only if Group 1 tags are present)
> +
> +**Group 2** (no blank lines within this group):
> +- Reported-by:
> +- Suggested-by:
> +- Signed-off-by:
> +- Acked-by:
> +- Reviewed-by:
> +- Tested-by:
> +
> +**Correct examples:**
> +
> +Simple patch with no Group 1 tags (most common):
> +```
> +The info_get callback doesn't need to check its args
> +since already done by ethdev.
> +
> +Signed-off-by: John Smith <john@example.com>
> +```
> +
> +Patch with Fixes and Cc tags:
> +```
> +Fixes: c743e50c475f ("null: new poll mode driver")
> +Cc: stable@dpdk.org
> +
> +Signed-off-by: John Smith <john@example.com>
> +```
> +
> +Patch with only Fixes tag:
> +```
> +Fixes: abcd1234abcd ("component: original commit")
> +
> +Signed-off-by: Jane Doe <jane@example.com>
> +```
> +
> +**What is correct (do NOT flag):**
> +- Signed-off-by directly after commit body when there are no Group 1 tag=
s - this is CORRECT
> +- No blank line between `Fixes:` and `Cc:` - this is CORRECT
> +- Blank line between `Cc:` (or last tag in Group 1) and `Signed-off-by:`=
 - this is CORRECT
> +
> +**What is wrong (DO flag):**
> +- Missing blank line between Group 1 tags and Group 2 tags (when Group 1=
 tags exist)
> +
> +**Tag format**: `Tag-name: Full Name <email@domain.com>`
> +
> +---
> +
> +## C Coding Style
> +
> +### Line Length
> +
> +| Context | Limit |
> +|---------|-------|
> +| Source code | **100 characters** |
> +| Commit body | **75 characters** |
> +
> +### General Formatting
> +
> +- **Tab width**: 8 characters (hard tabs for indentation, spaces for ali=
gnment)
> +- **No trailing whitespace** on lines or at end of files
> +- Files must end with a new line
> +- Code style should be consistent within each file
> +
> +
> +### Comments
> +
> +```c
> +/* Most single-line comments look like this. */
> +
> +/*
> + * VERY important single-line comments look like this.
> + */
> +
> +/*
> + * Multi-line comments look like this. Make them real sentences. Fill
> + * them so they look like real paragraphs.
> + */
> +```
> +
> +### Header File Organization
> +
> +Include order (each group separated by blank line):
> +1. System/libc includes
> +2. DPDK EAL includes
> +3. DPDK misc library includes
> +4. Application-specific includes
> +
> +```c
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <rte_eal.h>
> +
> +#include <rte_ring.h>
> +#include <rte_mempool.h>
> +
> +#include "application.h"
> +```
> +
> +### Header Guards
> +
> +```c
> +#ifndef _FILE_H_
> +#define _FILE_H_
> +
> +/* Code */
> +
> +#endif /* _FILE_H_ */
> +```
> +
> +### Naming Conventions
> +
> +- **All external symbols** must have `RTE_` or `rte_` prefix
> +- **Macros**: ALL_UPPERCASE with `RTE_` prefix
> +- **Functions**: lowercase with underscores only (no CamelCase)
> +- **Variables**: lowercase with underscores only
> +- **Enum values**: ALL_UPPERCASE with `RTE_<ENUM>_` prefix
> +
> +**Exception**: Driver base directories (`drivers/*/base/`) may use diffe=
rent
> +naming conventions when sharing code across platforms or with upstream v=
endor code.
> +
> +#### Symbol Naming for Static Linking
> +
> +Drivers and libraries must not expose global variables that could
> +clash when statically linked with other DPDK components or
> +applications. Use consistent and unique prefixes for all exported
> +symbols to avoid namespace collisions.
> +
> +**Good practice**: Use a driver-specific or library-specific prefix for =
all global variables:
> +
> +```c
> +/* Good - virtio driver uses consistent "virtio_" prefix */
> +const struct virtio_ops virtio_legacy_ops =3D {
> +=09.read =3D virtio_legacy_read,
> +=09.write =3D virtio_legacy_write,
> +=09.configure =3D virtio_legacy_configure,
> +};
> +
> +const struct virtio_ops virtio_modern_ops =3D {
> +=09.read =3D virtio_modern_read,
> +=09.write =3D virtio_modern_write,
> +=09.configure =3D virtio_modern_configure,
> +};
> +
> +/* Good - mlx5 driver uses consistent "mlx5_" prefix */
> +struct mlx5_flow_driver_ops mlx5_flow_dv_ops;
> +```
> +
> +**Bad practice**: Generic names that may clash:
> +
> +```c
> +/* Bad - "ops" is too generic, will clash with other drivers */
> +const struct virtio_ops ops =3D { ... };
> +
> +/* Bad - "legacy_ops" could clash with other legacy implementations */
> +const struct virtio_ops legacy_ops =3D { ... };
> +
> +/* Bad - "driver_config" is not unique */
> +struct driver_config config;
> +```
> +
> +**Guidelines**:
> +- Prefix all global variables with the driver or library name (e.g., `vi=
rtio_`, `mlx5_`, `ixgbe_`)
> +- Prefix all global functions similarly unless they use the `rte_` names=
pace
> +- Internal static variables do not require prefixes as they have file sc=
ope
> +- Consider using the `RTE_` or `rte_` prefix only for symbols that are p=
art of the public DPDK API
> +
> +#### Prohibited Terminology
> +
> +Do not use non-inclusive naming including:
> +- `master/slave` -> Use: primary/secondary, controller/worker, leader/fo=
llower
> +- `blacklist/whitelist` -> Use: denylist/allowlist, blocklist/passlist
> +- `cripple` -> Use: impacted, degraded, restricted, immobolized
> +- `tribe` -> Use: team, squad
> +- `sanity check` -> Use: coherence check, test, verification
> +
> +
> +### Comparisons and Boolean Logic
> +
> +```c
> +/* Pointers - compare explicitly with NULL */
> +if (p =3D=3D NULL)      /* Good */
> +if (p !=3D NULL)      /* Good */
> +if (likely(p !=3D NULL))   /* Good - likely/unlikely don't change this *=
/
> +if (unlikely(p =3D=3D NULL)) /* Good - likely/unlikely don't change this=
 */
> +if (!p)             /* Bad - don't use ! on pointers */
> +
> +/* Integers - compare explicitly with zero */
> +if (a =3D=3D 0)         /* Good */
> +if (a !=3D 0)         /* Good */
> +if (errno !=3D 0)     /* Good - this IS explicit */
> +if (likely(a !=3D 0)) /* Good - likely/unlikely don't change this */
> +if (!a)             /* Bad - don't use ! on integers */
> +if (a)              /* Bad - implicit, should be a !=3D 0 */
> +
> +/* Characters - compare with character constant */
> +if (*p =3D=3D '\0')     /* Good */
> +
> +/* Booleans - direct test is acceptable */
> +if (flag)           /* Good for actual bool types */
> +if (!flag)          /* Good for actual bool types */
> +```
> +
> +**Explicit comparison** means using `=3D=3D` or `!=3D` operators (e.g., =
`x !=3D 0`, `p =3D=3D NULL`).
> +**Implicit comparison** means relying on truthiness without an operator =
(e.g., `if (x)`, `if (!p)`).
> +**Note**: `likely()` and `unlikely()` macros do NOT affect whether a com=
parison is explicit or implicit.
> +
> +### Boolean Usage
> +
> +- Using `bool` type is allowed
> +- Prefer `bool` over `int` when a variable or field is only used as a bo=
olean
> +- For structure fields, consider if the size/alignment impact is accepta=
ble
> +
> +### Indentation and Braces
> +
> +```c
> +/* Control statements - no braces for single statements */
> +if (val !=3D NULL)
> +=09val =3D realloc(val, newsize);
> +
> +/* Braces on same line as else */
> +if (test)
> +=09stmt;
> +else if (bar) {
> +=09stmt;
> +=09stmt;
> +} else
> +=09stmt;
> +
> +/* Switch statements - don't indent case */
> +switch (ch) {
> +case 'a':
> +=09aflag =3D 1;
> +=09/* FALLTHROUGH */
> +case 'b':
> +=09bflag =3D 1;
> +=09break;
> +default:
> +=09usage();
> +}
> +
> +/* Long conditions - double indent continuation */
> +if (really_long_variable_name_1 =3D=3D really_long_variable_name_2 &&
> +=09=09really_long_variable_name_3 =3D=3D really_long_variable_name_4)
> +=09stmt;
> +```
> +
> +### Variable Declarations
> +
> +- Prefer declaring variables inside the basic block where they are used
> +- Variables may be declared either at the start of the block, or at poin=
t of first use (C99 style)
> +- Both declaration styles are acceptable; consistency within a function =
is preferred
> +- Initialize variables only when a meaningful value exists at declaratio=
n time
> +- Use C99 designated initializers for structures
> +
> +```c
> +/* Good - declaration at start of block */
> +int ret;
> +ret =3D some_function();
> +
> +/* Also good - declaration at point of use (C99 style) */
> +for (int i =3D 0; i < count; i++)
> +=09process(i);
> +
> +/* Good - declaration in inner block where variable is used */
> +if (condition) {
> +=09int local_val =3D compute();
> +=09use(local_val);
> +}
> +
> +/* Bad - unnecessary initialization defeats compiler warnings */
> +int ret =3D 0;
> +ret =3D some_function();    /* Compiler won't warn if assignment removed=
 */
> +```
> +
> +### Function Format
> +
> +- Return type on its own line
> +- Opening brace on its own line
> +- Place an empty line between declarations and statements
> +
> +```c
> +static char *
> +function(int a1, int b1)
> +{
> +=09char *p;
> +
> +=09p =3D do_something(a1, b1);
> +=09return p;
> +}
> +```
> +
> +---
> +
> +## Unnecessary Code Patterns
> +
> +The following patterns add unnecessary code, hide bugs, or reduce perfor=
mance. Avoid them.
> +
> +### Unnecessary Variable Initialization
> +
> +Do not initialize variables that will be assigned before use. This defea=
ts the compiler's uninitialized variable warnings, hiding potential bugs.
> +
> +```c
> +/* Bad - initialization defeats -Wuninitialized */
> +int ret =3D 0;
> +if (condition)
> +=09ret =3D func_a();
> +else
> +=09ret =3D func_b();
> +
> +/* Good - compiler will warn if any path misses assignment */
> +int ret;
> +if (condition)
> +=09ret =3D func_a();
> +else
> +=09ret =3D func_b();
> +
> +/* Good - meaningful initial value */
> +int count =3D 0;
> +for (i =3D 0; i < n; i++)
> +=09if (test(i))
> +=09=09count++;
> +```
> +
> +### Unnecessary Casts of void *
> +
> +In C, `void *` converts implicitly to any pointer type. Casting the resu=
lt of `malloc()`, `calloc()`, `rte_malloc()`, or similar functions is unnec=
essary and can hide the error of a missing `#include <stdlib.h>`.
> +
> +```c
> +/* Bad - unnecessary cast */
> +struct foo *p =3D (struct foo *)malloc(sizeof(*p));
> +struct bar *q =3D (struct bar *)rte_malloc(NULL, sizeof(*q), 0);
> +
> +/* Good - no cast needed in C */
> +struct foo *p =3D malloc(sizeof(*p));
> +struct bar *q =3D rte_malloc(NULL, sizeof(*q), 0);
> +```
> +
> +Note: Casts are required in C++ but DPDK is a C project.
> +
> +### Zero-Length Arrays vs Variable-Length Arrays
> +
> +Zero-length arrays (`int arr[0]`) are a GCC extension. Use C99 flexible =
array members instead.
> +
> +```c
> +/* Bad - GCC extension */
> +struct msg {
> +=09int len;
> +=09char data[0];
> +};
> +
> +/* Good - C99 flexible array member */
> +struct msg {
> +=09int len;
> +=09char data[];
> +};
> +```
> +
> +### Unnecessary NULL Checks Before free()
> +
> +Functions like `free()`, `rte_free()`, and similar deallocation function=
s accept NULL pointers safely. Do not add redundant NULL checks.
> +
> +```c
> +/* Bad - unnecessary check */
> +if (ptr !=3D NULL)
> +=09free(ptr);
> +
> +if (rte_ptr !=3D NULL)
> +=09rte_free(rte_ptr);
> +
> +/* Good - free handles NULL */
> +free(ptr);
> +rte_free(rte_ptr);
> +```
> +
> +### memset Before free() (CWE-14)
> +
> +Do not call `memset()` to zero memory before freeing it. The compiler ma=
y optimize away the `memset()` as a dead store (CWE-14: Compiler Removal of=
 Code to Clear Buffers). For security-sensitive data, use `explicit_bzero()=
`, `rte_memset_sensitive()`, or `rte_free_sensitive()` which the compiler i=
s not permitted to eliminate.
> +
> +```c
> +/* Bad - compiler may eliminate memset */
> +memset(secret_key, 0, sizeof(secret_key));
> +free(secret_key);
> +
> +/* Good - for non-sensitive data, just free */
> +free(ptr);
> +
> +/* Good - explicit_bzero cannot be optimized away */
> +explicit_bzero(secret_key, sizeof(secret_key));
> +free(secret_key);
> +
> +/* Good - DPDK wrapper for clearing sensitive data */
> +rte_memset_sensitive(secret_key, 0, sizeof(secret_key));
> +free(secret_key);
> +
> +/* Good - for rte_malloc'd sensitive data, combined clear+free */
> +rte_free_sensitive(secret_key);
> +```
> +
> +### Appropriate Use of rte_malloc()
> +
> +`rte_malloc()` allocates from hugepage memory. Use it only when required=
:
> +
> +- Memory that will be accessed by DMA (NIC descriptors, packet buffers)
> +- Memory shared between primary and secondary DPDK processes
> +- Memory requiring specific NUMA node placement
> +
> +For general allocations, use standard `malloc()` which is faster and doe=
s not consume limited hugepage resources.
> +
> +```c
> +/* Bad - rte_malloc for ordinary data structure */
> +struct config *cfg =3D rte_malloc(NULL, sizeof(*cfg), 0);
> +
> +/* Good - standard malloc for control structures */
> +struct config *cfg =3D malloc(sizeof(*cfg));
> +
> +/* Good - rte_malloc for DMA-accessible memory */
> +struct rte_mbuf *mbufs =3D rte_malloc(NULL, n * sizeof(*mbufs), RTE_CACH=
E_LINE_SIZE);
> +```
> +
> +### Appropriate Use of rte_memcpy()
> +
> +`rte_memcpy()` is optimized for bulk data transfer in the fast path. For=
 general use, standard `memcpy()` is preferred because:
> +
> +- Modern compilers optimize `memcpy()` effectively
> +- `memcpy()` includes bounds checking with `_FORTIFY_SOURCE`
> +- `memcpy()` handles small fixed-size copies efficiently
> +
> +```c
> +/* Bad - rte_memcpy in control path */
> +rte_memcpy(&config, &default_config, sizeof(config));
> +
> +/* Good - standard memcpy for control path */
> +memcpy(&config, &default_config, sizeof(config));
> +
> +/* Good - rte_memcpy for packet data in fast path */
> +rte_memcpy(rte_pktmbuf_mtod(m, void *), payload, len);
> +```
> +
> +---
> +
> +## Forbidden Tokens
> +
> +### Functions
> +
> +| Forbidden | Preferred | Context |
> +|-----------|-----------|---------|
> +| `rte_panic()` | Return error codes | lib/, drivers/ |
> +| `rte_exit()` | Return error codes | lib/, drivers/ |
> +| `perror()` | `RTE_LOG()` with `strerror(errno)` | lib/, drivers/ (allo=
wed in examples/, app/test/) |
> +| `printf()` | `RTE_LOG()` | lib/, drivers/ (allowed in examples/, app/t=
est/) |
> +| `fprintf()` | `RTE_LOG()` | lib/, drivers/ (allowed in examples/, app/=
test/) |
> +
> +### Atomics and Memory Barriers
> +
> +| Forbidden | Preferred |
> +|-----------|-----------|
> +| `rte_atomic16/32/64_xxx()` | C11 atomics via `rte_atomic_xxx()` |
> +| `rte_smp_mb()` | `rte_atomic_thread_fence()` |
> +| `rte_smp_rmb()` | `rte_atomic_thread_fence()` |
> +| `rte_smp_wmb()` | `rte_atomic_thread_fence()` |
> +| `__sync_xxx()` | `rte_atomic_xxx()` |
> +| `__atomic_xxx()` | `rte_atomic_xxx()` |
> +| `__ATOMIC_RELAXED` etc. | `rte_memory_order_xxx` |
> +| `__rte_atomic_thread_fence()` | `rte_atomic_thread_fence()` |
> +
> +### Threading
> +
> +| Forbidden | Preferred |
> +|-----------|-----------|
> +| `pthread_create()` | `rte_thread_create()` |
> +| `pthread_join()` | `rte_thread_join()` |
> +| `pthread_detach()` | EAL thread functions |
> +| `pthread_setaffinity_np()` | `rte_thread_set_affinity()` |
> +| `rte_thread_set_name()` | `rte_thread_set_prefixed_name()` |
> +| `rte_thread_create_control()` | `rte_thread_create_internal_control()`=
 |
> +
> +### Process-Shared Synchronization
> +
> +When placing synchronization primitives in shared memory (memory accessi=
ble by multiple processes, such as DPDK primary/secondary processes or `mma=
p`'d regions), they **must** be initialized with process-shared attributes.=
 Failure to do so causes **undefined behavior** that may appear to work in =
testing but fail unpredictably in production.
> +
> +#### pthread Mutexes in Shared Memory
> +
> +**This is an error** - mutex in shared memory without `PTHREAD_PROCESS_S=
HARED`:
> +
> +```c
> +/* BAD - undefined behavior when used across processes */
> +struct shared_data {
> +=09pthread_mutex_t lock;
> +=09int counter;
> +};
> +
> +void init_shared(struct shared_data *shm) {
> +=09pthread_mutex_init(&shm->lock, NULL);  /* ERROR: missing pshared attr=
ibute */
> +}
> +```
> +
> +**Correct implementation**:
> +
> +```c
> +/* GOOD - properly initialized for cross-process use */
> +struct shared_data {
> +=09pthread_mutex_t lock;
> +=09int counter;
> +};
> +
> +int init_shared(struct shared_data *shm) {
> +=09pthread_mutexattr_t attr;
> +=09int ret;
> +
> +=09ret =3D pthread_mutexattr_init(&attr);
> +=09if (ret !=3D 0)
> +=09=09return -ret;
> +
> +=09ret =3D pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> +=09if (ret !=3D 0) {
> +=09=09pthread_mutexattr_destroy(&attr);
> +=09=09return -ret;
> +=09}
> +
> +=09ret =3D pthread_mutex_init(&shm->lock, &attr);
> +=09pthread_mutexattr_destroy(&attr);
> +
> +=09return -ret;
> +}
> +```
> +
> +#### pthread Condition Variables in Shared Memory
> +
> +Condition variables also require the process-shared attribute:
> +
> +```c
> +/* BAD - will not work correctly across processes */
> +pthread_cond_init(&shm->cond, NULL);
> +
> +/* GOOD */
> +pthread_condattr_t cattr;
> +pthread_condattr_init(&cattr);
> +pthread_condattr_setpshared(&cattr, PTHREAD_PROCESS_SHARED);
> +pthread_cond_init(&shm->cond, &cattr);
> +pthread_condattr_destroy(&cattr);
> +```
> +
> +#### pthread Read-Write Locks in Shared Memory
> +
> +```c
> +/* BAD */
> +pthread_rwlock_init(&shm->rwlock, NULL);
> +
> +/* GOOD */
> +pthread_rwlockattr_t rwattr;
> +pthread_rwlockattr_init(&rwattr);
> +pthread_rwlockattr_setpshared(&rwattr, PTHREAD_PROCESS_SHARED);
> +pthread_rwlock_init(&shm->rwlock, &rwattr);
> +pthread_rwlockattr_destroy(&rwattr);
> +```
> +
> +#### When to Flag This Issue
> +
> +Flag as an **Error** when ALL of the following are true:
> +1. A `pthread_mutex_t`, `pthread_cond_t`, `pthread_rwlock_t`, or `pthrea=
d_barrier_t` is initialized
> +2. The primitive is stored in shared memory (identified by context such =
as: structure in `rte_malloc`/`rte_memzone`, `mmap`'d memory, memory passed=
 to secondary processes, or structures documented as shared)
> +3. The initialization uses `NULL` attributes or attributes without `PTHR=
EAD_PROCESS_SHARED`
> +
> +**Do NOT flag** when:
> +- The mutex is in thread-local or process-private heap memory (`malloc`)
> +- The mutex is a local/static variable not in shared memory
> +- The code already uses `pthread_mutexattr_setpshared()` with `PTHREAD_P=
ROCESS_SHARED`
> +- The synchronization uses DPDK primitives (`rte_spinlock_t`, `rte_rwloc=
k_t`) which are designed for shared memory
> +
> +#### Preferred Alternatives
> +
> +For DPDK code, prefer DPDK's own synchronization primitives which are de=
signed for shared memory:
> +
> +| pthread Primitive | DPDK Alternative |
> +|-------------------|------------------|
> +| `pthread_mutex_t` | `rte_spinlock_t` (busy-wait) or properly initializ=
ed pthread mutex |
> +| `pthread_rwlock_t` | `rte_rwlock_t` |
> +| `pthread_spinlock_t` | `rte_spinlock_t` |
> +
> +Note: `rte_spinlock_t` and `rte_rwlock_t` work correctly in shared memor=
y without special initialization, but they are spinning locks unsuitable fo=
r long wait times.
> +
> +### Compiler Built-ins and Attributes
> +
> +| Forbidden | Preferred | Notes |
> +|-----------|-----------|-------|
> +| `__attribute__` | RTE macros in `rte_common.h` | Except in `lib/eal/in=
clude/rte_common.h` |
> +| `__alignof__` | C11 `alignof` | |
> +| `__typeof__` | `typeof` | |
> +| `__builtin_*` | EAL macros | Except in `lib/eal/` and `drivers/*/base/=
` |
> +| `__reserved` | Different name | Reserved in Windows headers |
> +| `#pragma` / `_Pragma` | Avoid | Except in `rte_common.h` |
> +
> +### Format Specifiers
> +
> +| Forbidden | Preferred |
> +|-----------|-----------|
> +| `%lld`, `%llu`, `%llx` | `%PRId64`, `%PRIu64`, `%PRIx64` |
> +
> +### Headers and Build
> +
> +| Forbidden | Preferred | Context |
> +|-----------|-----------|---------|
> +| `#include <linux/pci_regs.h>` | `#include <rte_pci.h>` | |
> +| `install_headers()` | Meson `headers` variable | meson.build |
> +| `-DALLOW_EXPERIMENTAL_API` | Not in lib/drivers/app | Build flags |
> +| `allow_experimental_apis` | Not in lib/drivers/app | Meson |
> +| `#undef XXX` | `// XXX is not set` | config/rte_config.h |
> +| Driver headers (`*_driver.h`, `*_pmd.h`) | Public API headers | app/, =
examples/ |
> +
> +### Testing
> +
> +| Forbidden | Preferred |
> +|-----------|-----------|
> +| `REGISTER_TEST_COMMAND` | `REGISTER_<suite_name>_TEST` |
> +
> +### Documentation
> +
> +| Forbidden | Preferred |
> +|-----------|-----------|
> +| `http://...dpdk.org` | `https://...dpdk.org` |
> +| `//doc.dpdk.org/guides/...` | `:ref:` or `:doc:` Sphinx references |
> +| `::  file.svg` | `::  file.*` (wildcard extension) |
> +
> +---
> +
> +## Deprecated API Usage
> +
> +New patches must not introduce usage of deprecated APIs, macros, or func=
tions.
> +Deprecated items are marked with `RTE_DEPRECATED` or documented in the
> +deprecation notices section of the release notes.
> +
> +### Rules for New Code
> +
> +- Do not call functions marked with `RTE_DEPRECATED` or `__rte_deprecate=
d`
> +- Do not use macros that have been superseded by newer alternatives
> +- Do not use data structures or enum values marked as deprecated
> +- Check `doc/guides/rel_notes/deprecation.rst` for planned deprecations
> +- When a deprecated API has a replacement, use the replacement
> +
> +### Deprecating APIs
> +
> +A patch may mark an API as deprecated provided:
> +
> +- No remaining usages exist in the current DPDK codebase
> +- The deprecation is documented in the release notes
> +- A migration path or replacement API is documented
> +- The `RTE_DEPRECATED` macro is used to generate compiler warnings
> +
> +```c
> +/* Marking a function as deprecated */
> +__rte_deprecated
> +int
> +rte_old_function(void);
> +
> +/* With a message pointing to the replacement */
> +__rte_deprecated_msg("use rte_new_function() instead")
> +int
> +rte_old_function(void);
> +```
> +
> +### Common Deprecated Patterns
> +
> +| Deprecated | Replacement | Notes |
> +|-----------|-------------|-------|
> +| `rte_atomic*_t` types | C11 atomics | Use `rte_atomic_xxx()` wrappers =
|
> +| `rte_smp_*mb()` barriers | `rte_atomic_thread_fence()` | See Atomics s=
ection |
> +| `pthread_*()` in portable code | `rte_thread_*()` | See Threading sect=
ion |
> +
> +When reviewing patches that add new code, flag any usage of deprecated A=
PIs
> +as requiring change to use the modern replacement.
> +
> +---
> +
> +## API Tag Requirements
> +
> +### `__rte_experimental`
> +
> +- Must appear **alone on the line** immediately preceding the return typ=
e
> +- Only allowed in **header files** (not `.c` files)
> +
> +```c
> +/* Correct */
> +__rte_experimental
> +int
> +rte_new_feature(void);
> +
> +/* Wrong - not alone on line */
> +__rte_experimental int rte_new_feature(void);
> +
> +/* Wrong - in .c file */
> +```
> +
> +### `__rte_internal`
> +
> +- Must appear **alone on the line** immediately preceding the return typ=
e
> +- Only allowed in **header files** (not `.c` files)
> +
> +```c
> +/* Correct */
> +__rte_internal
> +int
> +internal_function(void);
> +```
> +
> +### Alignment Attributes
> +
> +`__rte_aligned`, `__rte_cache_aligned`, `__rte_cache_min_aligned` may on=
ly be used with `struct` or `union` types:
> +
> +```c
> +/* Correct */
> +struct __rte_cache_aligned my_struct {
> +=09/* ... */
> +};
> +
> +/* Wrong */
> +int __rte_cache_aligned my_variable;
> +```
> +
> +### Packed Attributes
> +
> +- `__rte_packed_begin` must follow `struct`, `union`, or alignment attri=
butes
> +- `__rte_packed_begin` and `__rte_packed_end` must be used in pairs
> +- Cannot use `__rte_packed_begin` with `enum`
> +
> +```c
> +/* Correct */
> +struct __rte_packed_begin my_packed_struct {
> +=09/* ... */
> +} __rte_packed_end;
> +
> +/* Wrong - with enum */
> +enum __rte_packed_begin my_enum {
> +=09/* ... */
> +};
> +```
> +
> +---
> +
> +## Code Quality Requirements
> +
> +### Compilation
> +
> +- Each commit must compile independently (for `git bisect`)
> +- No forward dependencies within a patchset
> +- Test with multiple targets, compilers, and options
> +- Use `devtools/test-meson-builds.sh`
> +
> +**Note for AI reviewers**: You cannot verify compilation order or cross-=
patch dependencies from patch review alone. Do NOT flag patches claiming th=
ey "would fail to compile" based on symbols used in other patches in the se=
ries. Assume the patch author has ordered them correctly.
> +
> +### Testing
> +
> +- Add tests to `app/test` unit test framework
> +- New API functions must be used in `/app` test directory
> +- New device APIs require at least one driver implementation
> +
> +#### Functional Test Infrastructure
> +
> +Standalone functional tests should use the `TEST_ASSERT` macros and `uni=
t_test_suite_runner` infrastructure for consistency and proper integration =
with the DPDK test framework.
> +
> +```c
> +#include <rte_test.h>
> +
> +static int
> +test_feature_basic(void)
> +{
> +=09int ret;
> +
> +=09ret =3D rte_feature_init();
> +=09TEST_ASSERT_SUCCESS(ret, "Failed to initialize feature");
> +
> +=09ret =3D rte_feature_operation();
> +=09TEST_ASSERT_EQUAL(ret, 0, "Operation returned unexpected value");
> +
> +=09TEST_ASSERT_NOT_NULL(rte_feature_get_ptr(),
> +=09=09"Feature pointer should not be NULL");
> +
> +=09return TEST_SUCCESS;
> +}
> +
> +static struct unit_test_suite feature_testsuite =3D {
> +=09.suite_name =3D "feature_autotest",
> +=09.setup =3D test_feature_setup,
> +=09.teardown =3D test_feature_teardown,
> +=09.unit_test_cases =3D {
> +=09=09TEST_CASE(test_feature_basic),
> +=09=09TEST_CASE(test_feature_advanced),
> +=09=09TEST_CASES_END()
> +=09}
> +};
> +
> +static int
> +test_feature(void)
> +{
> +=09return unit_test_suite_runner(&feature_testsuite);
> +}
> +
> +REGISTER_FAST_TEST(feature_autotest, NOHUGE_OK, ASAN_OK, test_feature);
> +```
> +
> +The `REGISTER_FAST_TEST` macro parameters are:
> +- Test name (e.g., `feature_autotest`)
> +- `NOHUGE_OK` or `HUGEPAGES_REQUIRED` - whether test can run without hug=
epages
> +- `ASAN_OK` or `ASAN_FAILS` - whether test is compatible with Address Sa=
nitizer
> +- Test function name
> +
> +Common `TEST_ASSERT` macros:
> +- `TEST_ASSERT(cond, msg, ...)` - Assert condition is true
> +- `TEST_ASSERT_SUCCESS(val, msg, ...)` - Assert value equals 0
> +- `TEST_ASSERT_FAIL(val, msg, ...)` - Assert value is non-zero
> +- `TEST_ASSERT_EQUAL(a, b, msg, ...)` - Assert two values are equal
> +- `TEST_ASSERT_NOT_EQUAL(a, b, msg, ...)` - Assert two values differ
> +- `TEST_ASSERT_NULL(val, msg, ...)` - Assert value is NULL
> +- `TEST_ASSERT_NOT_NULL(val, msg, ...)` - Assert value is not NULL
> +
> +### Documentation
> +
> +- Add Doxygen comments for public APIs
> +- Update release notes in `doc/guides/rel_notes/` for important changes
> +- Code and documentation must be updated atomically in same patch
> +- Only update the **current release** notes file
> +- Documentation must match the code
> +- PMD features must match the features matrix in `doc/guides/nics/featur=
es/`
> +- Documentation must match device operations (see `doc/guides/nics/featu=
res.rst` for the mapping between features, `eth_dev_ops`, and related APIs)
> +- Release notes are NOT required for:
> +  - Test-only changes (unit tests, functional tests)
> +  - Internal APIs and helper functions (not exported to applications)
> +  - Internal implementation changes that don't affect public API
> +
> +### RST Documentation Style
> +
> +When reviewing `.rst` documentation files, prefer **definition lists**
> +over simple bullet lists where each item has a term and a description.
> +Definition lists produce better-structured HTML/PDF output and are
> +easier to scan.
> +
> +**When to suggest a definition list:**
> +- A bullet list where each item starts with a bold or emphasized term
> +  followed by a dash, colon, or long explanation
> +- Lists of options, parameters, configuration values, or features
> +  where each entry has a name and a description
> +- Glossary-style enumerations
> +
> +**When a simple list is fine (do NOT flag):**
> +- Short lists of items without descriptions (e.g., file names, steps)
> +- Lists where items are single phrases or sentences with no term/definit=
ion structure
> +- Enumerated steps in a procedure
> +
> +**RST definition list syntax:**
> +
> +```rst
> +term 1
> +   Description of term 1.
> +
> +term 2
> +   Description of term 2.
> +   Can span multiple lines.
> +```
> +
> +**Example =E2=80=94 flag this pattern:**
> +
> +```rst
> +* **error** - Fail with error (default)
> +* **truncate** - Truncate content to fit token limit
> +* **summary** - Request high-level summary review
> +```
> +
> +**Suggest rewriting as:**
> +
> +```rst
> +error
> +   Fail with error (default).
> +
> +truncate
> +   Truncate content to fit token limit.
> +
> +summary
> +   Request high-level summary review.
> +```
> +
> +This is a **Warning**-level suggestion, not an Error. Do not flag it
> +when the existing list structure is appropriate (see "when a simple
> +list is fine" above).
> +
> +### API and Driver Changes
> +
> +- New APIs must be marked as `__rte_experimental`
> +- New APIs must have hooks in `app/testpmd` and tests in the functional =
test suite
> +- Changes to existing APIs require release notes
> +- New drivers or subsystems must have release notes
> +- Internal APIs (used only within DPDK, not exported to applications) do=
 NOT require release notes
> +
> +### ABI Compatibility and Symbol Exports
> +
> +**IMPORTANT**: DPDK uses automatic symbol map generation. Do **NOT** rec=
ommend
> +manually editing `version.map` files - they are auto-generated from sour=
ce code
> +annotations.
> +
> +#### Symbol Export Macros
> +
> +New public functions must be annotated with export macros (defined in
> +`rte_export.h`). Place the macro on the line immediately before the func=
tion
> +definition in the `.c` file:
> +
> +```c
> +/* For stable ABI symbols */
> +RTE_EXPORT_SYMBOL(rte_foo_create)
> +int
> +rte_foo_create(struct rte_foo_config *config)
> +{
> +    /* ... */
> +}
> +
> +/* For experimental symbols (include version when first added) */
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_foo_new_feature, 25.03)
> +__rte_experimental
> +int
> +rte_foo_new_feature(void)
> +{
> +    /* ... */
> +}
> +
> +/* For internal symbols (shared between DPDK components only) */
> +RTE_EXPORT_INTERNAL_SYMBOL(rte_foo_internal_helper)
> +int
> +rte_foo_internal_helper(void)
> +{
> +    /* ... */
> +}
> +```
> +
> +#### Symbol Export Rules
> +
> +- `RTE_EXPORT_SYMBOL` - Use for stable ABI functions
> +- `RTE_EXPORT_EXPERIMENTAL_SYMBOL(name, ver)` - Use for new experimental=
 APIs
> +  (version is the DPDK release, e.g., `25.03`)
> +- `RTE_EXPORT_INTERNAL_SYMBOL` - Use for functions shared between DPDK l=
ibs/drivers
> +  but not part of public API
> +- Export macros go in `.c` files, not headers
> +- The build system generates linker version maps automatically
> +
> +#### What NOT to Review
> +
> +- Do **NOT** flag missing `version.map` updates - maps are auto-generate=
d
> +- Do **NOT** suggest adding symbols to `lib/*/version.map` files
> +
> +#### ABI Versioning for Changed Functions
> +
> +When changing the signature of an existing stable function, use versioni=
ng macros
> +from `rte_function_versioning.h`:
> +
> +- `RTE_VERSION_SYMBOL` - Create versioned symbol for backward compatibil=
ity
> +- `RTE_DEFAULT_SYMBOL` - Mark the new default version
> +
> +Follow ABI policy and versioning guidelines in the contributor documenta=
tion.
> +Enable ABI checks with `DPDK_ABI_REF_VERSION` environment variable.
> +
> +---
> +
> +## LTS (Long Term Stable) Release Review
> +
> +LTS releases are DPDK versions ending in `.11` (e.g., 23.11, 22.11,
> +21.11, 20.11, 19.11). When reviewing patches targeting an LTS branch,
> +apply stricter criteria:
> +
> +### LTS-Specific Rules
> +
> +- **Only bug fixes allowed** -- no new features
> +- **No new APIs** (experimental or stable)
> +- **ABI must remain unchanged** -- no symbol additions, removals,
> +  or signature changes
> +- Backported fixes should reference the original commit with a
> +  `Fixes:` tag
> +- Copyright years should reflect when the code was originally
> +  written
> +- Be conservative: reject changes that are not clearly bug fixes
> +
> +### What to Flag on LTS Branches
> +
> +**Error:**
> +- New feature code (new functions, new driver capabilities)
> +- New experimental or stable API additions
> +- ABI changes (new or removed symbols, changed function signatures)
> +- Changes that add new configuration options or parameters
> +
> +**Warning:**
> +- Large refactoring that goes beyond what is needed for a fix
> +- Missing `Fixes:` tag on a backported bug fix
> +- Missing `Cc: stable@dpdk.org`
> +
> +### When LTS Rules Apply
> +
> +LTS rules apply when the reviewer is told the target release is an
> +LTS version (via the `--release` option or equivalent). If no
> +release is specified, assume the patch targets the main development
> +branch where new features and APIs are allowed.
> +
> +---
> +
> +## Patch Validation Checklist
> +
> +### Commit Message
> +
> +- [ ] Subject line <=3D60 characters
> +- [ ] Subject is lowercase (except acronyms from words-case.txt)
> +- [ ] Correct component prefix (e.g., `net/ixgbe:` not `ixgbe:`)
> +- [ ] No `lib/` prefix for libraries
> +- [ ] Imperative mood, no trailing period
> +- [ ] No tabs, leading/trailing spaces, or punctuation marks
> +- [ ] Body wrapped at 75 characters
> +- [ ] Body does not start with "It"
> +- [ ] `Signed-off-by:` present with real name and valid email
> +- [ ] `Fixes:` tag present for bug fixes with 12-char SHA and exact subj=
ect
> +- [ ] `Coverity issue:` tag present if Coverity mentioned
> +- [ ] `Bugzilla ID:` tag present if Bugzilla mentioned
> +- [ ] `Cc: stable@dpdk.org` for stable backport candidates
> +- [ ] Tags in correct order with blank line separator
> +
> +### License
> +
> +- [ ] SPDX identifier on first line (or second for scripts)
> +- [ ] Copyright line follows SPDX
> +- [ ] Blank line after copyright before code
> +- [ ] Appropriate license for file type
> +
> +### Code Style
> +
> +- [ ] Lines <=3D100 characters
> +- [ ] Hard tabs for indentation, spaces for alignment
> +- [ ] No trailing whitespace
> +- [ ] Proper include order
> +- [ ] Header guards present
> +- [ ] `rte_`/`RTE_` prefix on external symbols
> +- [ ] Driver/library global variables use unique prefixes (e.g., `virtio=
_`, `mlx5_`)
> +- [ ] No prohibited terminology
> +- [ ] Proper brace style
> +- [ ] Function return type on own line
> +- [ ] Explicit comparisons: `=3D=3D NULL`, `=3D=3D 0`, `!=3D NULL`, `!=
=3D 0`
> +- [ ] No forbidden tokens (see table above)
> +- [ ] No unnecessary code patterns (see section above)
> +- [ ] No usage of deprecated APIs, macros, or functions
> +- [ ] Process-shared primitives in shared memory use `PTHREAD_PROCESS_SH=
ARED`
> +- [ ] `mmap()` return checked against `MAP_FAILED`, not `NULL`
> +- [ ] Statistics use `+=3D` not `=3D` for accumulation
> +- [ ] Integer multiplies widened before operation when result is 64-bit
> +- [ ] Descriptor chain traversals bounded by ring size or loop counter
> +- [ ] 64-bit bitmasks use `1ULL <<` or `RTE_BIT64()`, not `1 <<`
> +- [ ] No unconditional variable overwrites before read
> +- [ ] Nested loops use distinct counter variables
> +- [ ] No `memcpy`/`memcmp` with identical source and destination pointer=
s
> +- [ ] Sensitive data cleared with `explicit_bzero()`/`rte_free_sensitive=
()`, not `memset()`
> +
> +### API Tags
> +
> +- [ ] `__rte_experimental` alone on line, only in headers
> +- [ ] `__rte_internal` alone on line, only in headers
> +- [ ] Alignment attributes only on struct/union
> +- [ ] Packed attributes properly paired
> +- [ ] New public functions have `RTE_EXPORT_*` macro in `.c` file
> +- [ ] Experimental functions use `RTE_EXPORT_EXPERIMENTAL_SYMBOL(name, v=
ersion)`
> +
> +### Structure
> +
> +- [ ] Each commit compiles independently
> +- [ ] Code and docs updated together
> +- [ ] Documentation matches code behavior
> +- [ ] RST docs use definition lists for term/description patterns
> +- [ ] PMD features match `doc/guides/nics/features/` matrix
> +- [ ] Device operations match documentation (per `features.rst` mappings=
)
> +- [ ] Tests added/updated as needed
> +- [ ] Functional tests use TEST_ASSERT macros and unit_test_suite_runner
> +- [ ] New APIs marked as `__rte_experimental`
> +- [ ] New APIs have testpmd hooks and functional tests
> +- [ ] Current release notes updated for significant changes
> +- [ ] Release notes updated for API changes
> +- [ ] Release notes updated for new drivers or subsystems
> +
> +---
> +
> +## Meson Build Files
> +
> +### Style Requirements
> +
> +- 4-space indentation (no tabs)
> +- Line continuations double-indented
> +- Lists alphabetically ordered
> +- Short lists (<=3D3 items): single line, no trailing comma
> +- Long lists: one item per line, trailing comma on last item
> +- No strict line length limit for meson files; lines under 100 character=
s are acceptable
> +
> +```python
> +# Short list
> +sources =3D files('file1.c', 'file2.c')
> +
> +# Long list
> +headers =3D files(
> +=09'header1.h',
> +=09'header2.h',
> +=09'header3.h',
> +)
> +```
> +
> +---
> +
> +## Python Code
> +
> +- Must comply with formatting standards
> +- Use **`black`** for code formatting validation
> +- Line length acceptable up to 100 characters
> +
> +---
> +
> +## Validation Tools
> +
> +Run these before submitting:
> +
> +```bash
> +# Check commit messages
> +devtools/check-git-log.sh -n1
> +
> +# Check patch format and forbidden tokens
> +devtools/checkpatches.sh -n1
> +
> +# Check maintainers coverage
> +devtools/check-maintainers.sh
> +
> +# Build validation
> +devtools/test-meson-builds.sh
> +
> +# Find maintainers for your patch
> +devtools/get-maintainer.sh <patch-file>
> +```
> +
> +---
> +
> +## Severity Levels for AI Review
> +
> +**Error** (must fix):
> +
> +*Correctness bugs (highest value findings):*
> +- Use-after-free
> +- Resource leaks on error paths (memory, file descriptors, locks)
> +- Double-free or double-close
> +- NULL pointer dereference on reachable code path
> +- Buffer overflow or out-of-bounds access
> +- Missing error check on a function that can fail, leading to undefined =
behavior
> +- Race condition on shared mutable state without synchronization
> +- Error path that skips necessary cleanup
> +- `mmap()` return value checked against NULL instead of `MAP_FAILED`
> +- Statistics accumulation using `=3D` instead of `+=3D` (overwrite vs in=
crement)
> +- Integer multiply without widening cast losing upper bits (16=C3=9716, =
32=C3=9732, etc.)
> +- Unbounded descriptor chain traversal on guest/API-supplied indices
> +- `1 << n` used for 64-bit bitmask (undefined behavior if n >=3D 32)
> +- Variable assigned then unconditionally overwritten before read
> +- Same variable used as counter in nested loops
> +- `memcpy`/`memcmp` with same pointer as both arguments (UB or no-op log=
ic error)
> +
> +*Process and format errors:*
> +- Missing or malformed SPDX license
> +- Missing Signed-off-by
> +- Subject line over 60 characters
> +- Body lines over 75 characters
> +- Wrong tag order or format
> +- Missing required tags (Fixes, Coverity issue, Bugzilla ID)
> +- Forbidden tokens in code
> +- `__rte_experimental`/`__rte_internal` in .c files or not alone on line
> +- Compilation failures
> +- ABI breaks without proper versioning
> +- pthread mutex/cond/rwlock in shared memory without `PTHREAD_PROCESS_SH=
ARED`
> +
> +**Warning** (should fix):
> +- Subject line style issues (case, punctuation)
> +- Wrong component prefix
> +- Missing Cc: stable@dpdk.org for fixes
> +- Documentation gaps
> +- Documentation does not match code behavior
> +- PMD features missing from `doc/guides/nics/features/` matrix
> +- Device operations not documented per `features.rst` mappings
> +- Missing tests
> +- Functional tests not using TEST_ASSERT macros or unit_test_suite_runne=
r
> +- New API not marked as `__rte_experimental`
> +- New API without testpmd hooks or functional tests
> +- New public function missing `RTE_EXPORT_*` macro
> +- API changes without release notes
> +- New drivers or subsystems without release notes
> +- Implicit comparisons (`!ptr` instead of `ptr =3D=3D NULL`)
> +- Unnecessary variable initialization
> +- Unnecessary casts of `void *`
> +- Unnecessary NULL checks before free
> +- Inappropriate use of `rte_malloc()` or `rte_memcpy()`
> +- Use of `perror()`, `printf()`, `fprintf()` in libraries or drivers (al=
lowed in examples and test code)
> +- Driver/library global variables without unique prefixes (static linkin=
g clash risk)
> +- Usage of deprecated APIs, macros, or functions in new code
> +- RST documentation using bullet lists where definition lists would be m=
ore appropriate
> +
> +**Do NOT flag** (common false positives):
> +- Missing `version.map` updates (maps are auto-generated from `RTE_EXPOR=
T_*` macros)
> +- Suggesting manual edits to any `version.map` file
> +- Copyright years within valid range (2013 to current year)
> +- Copyright held by individuals (never speculate about employers, compan=
y policies, or who "should" hold copyright)
> +- SPDX/copyright format that matches the standard DPDK format (do not ca=
ll it "different" or "unusual")
> +- Meson file lines under 100 characters
> +- Case-sensitive term violations in code comments (words-case.txt applie=
s to commit messages only)
> +- Comparisons using `=3D=3D 0`, `!=3D 0`, `=3D=3D NULL`, `!=3D NULL` as =
"implicit" (these ARE explicit)
> +- Comparisons wrapped in `likely()` or `unlikely()` macros - these are s=
till explicit if using =3D=3D or !=3D
> +- Anything you determine is correct (do not mention non-issues or say "N=
o issue here")
> +- `REGISTER_FAST_TEST` using `NOHUGE_OK`/`ASAN_OK` macros (this is the c=
orrect current format)
> +- Tag ordering: Signed-off-by directly after commit body (when no Fixes/=
Cc tags) is CORRECT
> +- Tag ordering: no blank line between Fixes/Cc, blank line before Signed=
-off-by (when Fixes/Cc present) is CORRECT
> +- Missing release notes for test-only changes (unit tests do not require=
 release notes)
> +- Missing release notes for internal APIs or helper functions (only publ=
ic APIs need release notes)
> +- Subject lines that are within the 60 character limit (count first, do =
not guess)
> +- Any item you later correct with "(Correction: ...)" or "actually accep=
table" - just omit it
> +- Vague concerns ("should be verified", "should be checked") - if you're=
 not sure it's wrong, don't flag it
> +- Items where you say "which is correct" or "this is correct" - if it's =
correct, don't mention it at all
> +- Fixes tags with correct format (12-char SHA, quoted subject) - NEVER a=
sk for verification that commit exists
> +- Items where you conclude "no issue here" or "this is actually correct"=
 - omit these entirely
> +- Clean patches in a series - do not include a patch just to say "no iss=
ues" or describe what it does
> +- Cross-patch compilation dependencies - you cannot determine patch orde=
ring correctness from review
> +- Claims that a symbol "was removed in patch N" causing issues in patch =
M - assume author ordered correctly
> +- Any speculation about whether patches will compile when applied in seq=
uence
> +- Mutexes/locks in process-private memory (standard `malloc`, stack, sta=
tic non-shared) - these don't need `PTHREAD_PROCESS_SHARED`
> +- Use of `rte_spinlock_t` or `rte_rwlock_t` in shared memory (these work=
 correctly without special init)
> +
> +**Info** (consider):
> +- Minor style preferences
> +- Optimization suggestions
> +- Alternative approaches
> +
> +---
> +
> +# Response Format
> +
> +When you identify an issue:
> +1. **State the problem** (1 sentence)
> +2. **Why it matters** (1 sentence, only if not obvious)
> +3. **Suggested fix** (code snippet or specific action)
> +
> +Example:
> +This could panic if the string is NULL.
> +
> +---
> +
> +## FINAL CHECK BEFORE SUBMITTING REVIEW
> +
> +Before outputting your review, do two separate passes:
> +
> +### Pass 1: Verify correctness bugs are included
> +
> +Ask: "Did I trace every error path for resource leaks? Did I check
> +for use-after-free? Did I verify error codes are propagated?"
> +
> +If you identified a potential correctness bug but talked yourself
> +out of it, **add it back**. It is better to report a possible bug
> +than to miss a real one.
> +
> +### Pass 2: Remove style/process false positives
> +
> +For EACH style/process item, ask: "Did I conclude this is actually
> +fine/correct/acceptable/no issue?"
> +
> +If YES, DELETE THAT ITEM. It should not be in your output.
> +
> +An item that says "X is wrong... actually this is correct" is a
> +FALSE POSITIVE and must be removed. This applies to style, format,
> +and process items only.
> +
> +**If your Errors section would be empty after this check, that's
> +fine -- it means the patches are good.**

