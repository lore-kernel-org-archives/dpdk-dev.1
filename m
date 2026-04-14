Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D9F9D0F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 19:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7877D4028F;
	Tue, 14 Apr 2026 21:54:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 082344028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 21:54:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776196494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjgolNJonimu+HAuKZOBBfnr4DAmTDqnv7XtYLnoIn4=;
 b=ASRYlqAyaa1fbLygDjsiDhm6zsEbbBG+2YHEJQ25CTSW/1YHihKX0XVp9IV0Y4cC1v4U3S
 UzRZccmyklunBP/lE9lJKTlgfM/8tqxVJDcGpZpg5bwV0yhNalc78qkpf/kD/OrdatMFq7
 BFgwceI6+EeNhahRoTyhvwceChFqNmU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-hiNQmRe5NdejDMGS9VEINg-1; Tue,
 14 Apr 2026 15:54:49 -0400
X-MC-Unique: hiNQmRe5NdejDMGS9VEINg-1
X-Mimecast-MFC-AGG-ID: hiNQmRe5NdejDMGS9VEINg_1776196488
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B184C19560B1; Tue, 14 Apr 2026 19:54:48 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19E1719560B1; Tue, 14 Apr 2026 19:54:46 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 1/6] doc: add AGENTS.md for AI code review tools
In-Reply-To: <20260402194618.134002-2-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Thu, 2 Apr 2026 12:44:31 -0700")
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
 <20260402194618.134002-2-stephen@networkplumber.org>
Date: Tue, 14 Apr 2026 15:54:45 -0400
Message-ID: <f7tbjfl9v22.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nZCsqsksWkj8BR5Q6FdzroColuLTD5UeHl2qW6785lg_1776196488
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

> Provide structured guidelines for AI tools reviewing DPDK
> patches. Focuses on correctness bug detection (resource leaks,
> use-after-free, race conditions), C coding style, forbidden
> tokens, API conventions, and severity classifications.
>
> Mechanical checks already handled by checkpatches.sh (SPDX
> format, commit message formatting, tag ordering) are excluded
> to avoid redundant and potentially contradictory findings.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Hi Stephen,

I did some testing with this and the sonnet model looks like it costs
roughly 11 cents US per patch.  This seems acceptable for us, so I think
it's getting close enough to accept.

I am not a prompt optimization engineer, but I've been told by one that
we should try to avoid 'do not' type orders in favor of 'do' orders.
That's maybe a good second pass optimization, because we have a mix.  On
the plus side, there are also lots of examples of good behavior in here,
which I was also told is a good thing to include.

Given that,

Acked-by: Aaron Conole <aconole@redhat.com>

>  AGENTS.md | 2162 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 2162 insertions(+)
>  create mode 100644 AGENTS.md
>
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 0000000000..d49ed859f1
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,2162 @@
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
> +- `volatile` used instead of atomic operations for inter-thread shared v=
ariables
> +- `__atomic_load_n()`/`__atomic_store_n()`/`__atomic_*()` GCC built-ins =
instead of `rte_atomic_*_explicit()`
> +- `rte_smp_mb()`/`rte_smp_rmb()`/`rte_smp_wmb()` legacy barriers instead=
 of `rte_atomic_thread_fence()`
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
> +- Left shift of narrow unsigned (`uint8_t`/`uint16_t`) used as 64-bit va=
lue (sign extension via implicit `int` promotion)
> +- Variable assigned then overwritten before being read (dead store)
> +- Same variable used as loop counter in nested loops
> +- `memcpy`/`memcmp`/`memset` with same pointer for source and destinatio=
n (no-op or undefined)
> +- `rte_mbuf_raw_free_bulk()` called on mbufs that may originate from dif=
ferent mempools (Tx burst, ring dequeue)
> +- MTU confused with frame length (MTU is L3 payload; frame length =3D MT=
U + L2 overhead)
> +- Using `dev_conf.rxmode.mtu` after configure instead of `dev->data->mtu=
`
> +- Hardcoded Ethernet overhead instead of per-device calculation
> +- MTU set without enabling `RTE_ETH_RX_OFFLOAD_SCATTER` when frame size =
exceeds mbuf data room
> +- `mtu_set` callback rejects valid MTU when scatter Rx is already enable=
d
> +- Rx queue setup silently drops oversized packets instead of enabling sc=
atter or returning an error
> +- Rx function selection ignores `scattered_rx` flag or MTU-vs-mbuf-size =
check
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
> +This suppression rule applies to: naming conventions,
> +code style, and process compliance. It does NOT apply to
> +correctness bugs listed above. (SPDX/copyright format and
> +commit message formatting are handled by checkpatch and are
> +excluded from AI review entirely.)
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
> +- Do NOT comment on copyright years, SPDX format, or copyright holders -=
 not subject to AI review
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
> +- NEVER write "(Correction: ...)" - if you need to correct yourself, sim=
ply omit the item entirely
> +- Do NOT add vague suggestions like "should be verified" or "should be c=
hecked" - either it's wrong or don't mention it
> +- Do NOT flag something as an Error then say "which is correct" in the s=
ame item
> +- Do NOT say "no issue here" or "this is actually correct" - if there's =
no issue, do not include it in your review
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
> +- **`volatile` for inter-thread synchronization**: `volatile` does not
> +  provide atomicity or memory ordering between threads. Use
> +  `rte_atomic_load_explicit()`/`rte_atomic_store_explicit()` with
> +  appropriate `rte_memory_order_*` instead. See the Shared Variable
> +  Access section under Forbidden Tokens for details.
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
> +- **Left shift of narrow unsigned type sign-extends to 64-bit**: When
> +  a `uint8_t` or `uint16_t` value is left-shifted, C integer promotion
> +  converts it to `int` (signed 32-bit) before the shift. If the result
> +  has bit 31 set, implicit conversion to `uint64_t`, `size_t`, or use
> +  in pointer arithmetic sign-extends the upper 32 bits to all-1s,
> +  producing a wrong address or value. This is Coverity SIGN_EXTENSION.
> +  The fix is to cast the narrow operand to an unsigned type at least as
> +  wide as the target before shifting.
> +  ```c
> +  /* BAD - uint16_t promotes to signed int, bit 31 may set,
> +   * then sign-extends when converted to 64-bit for pointer math */
> +  uint16_t idx =3D get_index();
> +  void *addr =3D base + (idx << wqebb_shift);      /* SIGN_EXTENSION */
> +  uint64_t off =3D (uint64_t)(idx << shift);        /* too late: shift a=
lready in int */
> +
> +  /* BAD - uint8_t shift with result used as size_t */
> +  uint8_t page_order =3D get_order();
> +  size_t size =3D page_order << PAGE_SHIFT;          /* promotes to int =
first */
> +
> +  /* GOOD - cast before shift */
> +  void *addr =3D base + ((uint64_t)idx << wqebb_shift);
> +  uint64_t off =3D (uint64_t)idx << shift;
> +  size_t size =3D (size_t)page_order << PAGE_SHIFT;
> +
> +  /* GOOD - intermediate unsigned variable */
> +  uint32_t offset =3D (uint32_t)idx << wqebb_shift;  /* OK if result fit=
s 32 bits */
> +  ```
> +  Note: This is distinct from the `1 << n` pattern (where the literal
> +  `1` is the problem) and from the integer-multiply pattern (where
> +  the operation is `*` not `<<`). The mechanism is the same C integer
> +  promotion rule, but the code patterns and Coverity checker names
> +  differ. Only flag when the shift result is used in a context wider
> +  than 32 bits (64-bit assignment, pointer arithmetic, function
> +  argument expecting `uint64_t`/`size_t`). A shift whose result is
> +  stored in a `uint32_t` or narrower variable is not affected.
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
> +- **`rte_mbuf_raw_free_bulk()` on mixed-pool mbuf arrays**: Tx burst fun=
ctions
> +  and ring/queue dequeue paths receive mbufs that may originate from dif=
ferent
> +  mempools (applications are free to send mbufs from any pool).
> +  `rte_mbuf_raw_free_bulk()` takes an explicit mempool parameter and cal=
ls
> +  `rte_mempool_put_bulk()` directly =E2=80=94 ALL mbufs in the array mus=
t come from
> +  that single pool. If mbufs come from different pools, they are returne=
d to
> +  the wrong pool, corrupting pool accounting and causing hard-to-debug f=
ailures.
> +  Note: `rte_pktmbuf_free_bulk()` is safe for mixed pools =E2=80=94 it b=
atches mbufs
> +  by pool internally and flushes whenever the pool changes.
> +  ```c
> +  /* BAD - assumes all mbufs are from the same pool */
> +  /* (in tx_burst completion or ring dequeue error path) */
> +  rte_mbuf_raw_free_bulk(mp, mbufs, nb_mbufs);
> +
> +  /* GOOD - rte_pktmbuf_free_bulk handles mixed pools correctly */
> +  rte_pktmbuf_free_bulk(mbufs, nb_mbufs);
> +
> +  /* GOOD - free individually (each mbuf returned to its own pool) */
> +  for (i =3D 0; i < nb_mbufs; i++)
> +      rte_pktmbuf_free(mbufs[i]);
> +  ```
> +  This applies to any path that frees mbufs submitted by the application=
:
> +  Tx completion, Tx error cleanup, and ring/queue drain paths.
> +  `rte_mbuf_raw_free_bulk()` is an optimization for the fast-free case
> +  (`RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE`) where the application guarantees
> +  all mbufs come from a single pool with refcnt=3D1.
> +- **MTU confused with Ethernet frame length**: Maximum Transmission Unit
> +  (MTU) is the maximum L3 payload size (e.g., 1500 bytes for standard
> +  Ethernet). The maximum Ethernet *frame length* includes L2 overhead:
> +  Ethernet header (14 bytes) + optional VLAN tags (4 bytes each) + CRC
> +  (4 bytes). The overhead varies per device depending on supported
> +  encapsulations (VLAN, QinQ, etc.). Confusing MTU with frame length
> +  produces off-by-14-to-22-byte errors in packet size limits, buffer
> +  sizing, and scattered Rx decisions.
> +
> +  **VLAN tag accounting:** The outer VLAN tag is L2 overhead and does
> +  NOT count toward MTU (matching Linux and FreeBSD). A 1522-byte
> +  single-tagged frame is valid at MTU 1500. However, in QinQ the
> +  inner (customer) tag DOES consume MTU =E2=80=94 it is part of the cust=
omer
> +  frame. So QinQ with MTU 1500 allows only 1496 bytes of L3 payload
> +  unless the port MTU is raised to 1504.
> +
> +  **Using `rxmode.mtu` after configure:** After `rte_eth_dev_configure()=
`
> +  completes, the canonical MTU is stored in `dev->data->mtu`. The
> +  `dev->data->dev_conf.rxmode.mtu` field is the user's *request* and
> +  must not be read after configure =E2=80=94 it becomes stale if
> +  `rte_eth_dev_set_mtu()` is called later. Both configure and set_mtu
> +  write to `dev->data->mtu`; PMDs should always read from there.
> +
> +  **Overhead calculation:** Do not hardcode a single overhead constant.
> +  Use the device's own overhead calculation (typically available via
> +  `dev_info.max_rx_pktlen - dev_info.max_mtu` or an internal
> +  `eth_overhead` field). Different devices support different
> +  encapsulations, so the overhead is not a universal constant.
> +
> +  **Scattered Rx decision:** PMDs compare maximum frame length
> +  (MTU + per-device overhead) against Rx buffer size to decide
> +  whether scattered Rx is needed. Comparing raw MTU against buffer
> +  size is wrong =E2=80=94 it underestimates the actual frame size by the
> +  overhead.
> +  ```c
> +  /* BAD - MTU used where frame length is needed */
> +  if (dev->data->mtu > rxq->buf_size)
> +      enable_scattered_rx();
> +
> +  /* BAD - hardcoded overhead, wrong for QinQ-capable devices */
> +  #define ETHER_OVERHEAD 18  /* may be 22 or 26 for VLAN/QinQ */
> +  max_frame =3D mtu + ETHER_OVERHEAD;
> +
> +  /* BAD - reading rxmode.mtu after configure (stale if set_mtu called) =
*/
> +  static int
> +  mydrv_rx_queue_setup(...) {
> +      mtu =3D dev->data->dev_conf.rxmode.mtu;  /* WRONG - may be stale *=
/
> +      ...
> +  }
> +
> +  /* GOOD - use dev->data->mtu, the canonical post-configure value */
> +  static int
> +  mydrv_rx_queue_setup(...) {
> +      uint16_t mtu =3D dev->data->mtu;
> +      ...
> +  }
> +
> +  /* GOOD - use per-device overhead for frame length calculation */
> +  uint32_t frame_overhead =3D dev_info.max_rx_pktlen - dev_info.max_mtu;
> +  uint32_t max_frame_len =3D dev->data->mtu + frame_overhead;
> +  if (max_frame_len > rxq->buf_size)
> +      enable_scattered_rx();
> +
> +  /* GOOD - device-specific overhead constant derived from capabilities =
*/
> +  static uint32_t
> +  mydrv_eth_overhead(struct rte_eth_dev *dev) {
> +      uint32_t overhead =3D RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN;
> +      if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN)
> +          overhead +=3D RTE_VLAN_HLEN;
> +      if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_QINQ)
> +          overhead +=3D RTE_VLAN_HLEN;
> +      return overhead;
> +  }
> +  ```
> +  Note: In `rte_eth_dev_configure()` itself, reading `rxmode.mtu` is
> +  correct =E2=80=94 that is where the user's request is consumed and wri=
tten
> +  to `dev->data->mtu`. Only flag reads of `rxmode.mtu` *outside*
> +  configure (queue setup, start, link update, MTU set, etc.).
> +- **Missing scatter Rx for large MTU**: When the configured MTU
> +  produces a frame size (MTU + Ethernet overhead) larger than the mbuf
> +  data buffer size (`rte_pktmbuf_data_room_size(mp) - RTE_PKTMBUF_HEADRO=
OM`),
> +  the PMD MUST either enable scatter Rx (multi-segment receive) or rejec=
t
> +  the configuration. Silently accepting the MTU and then truncating or
> +  dropping oversized packets is a correctness bug.
> +  ```c
> +  /* BAD - accepts MTU but will truncate packets that don't fit */
> +  static int
> +  mydrv_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
> +  {
> +      /* No check against mbuf size or scatter capability */
> +      dev->data->mtu =3D mtu;
> +      return 0;
> +  }
> +
> +  /* BAD - rejects valid MTU even though scatter is enabled */
> +  if (frame_size > mbuf_data_size)
> +      return -EINVAL;  /* wrong: should allow if scatter is on */
> +
> +  /* GOOD - check scatter and mbuf size */
> +  if (!dev->data->scattered_rx &&
> +      frame_size > dev->data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM)
> +      return -EINVAL;
> +
> +  /* GOOD - auto-enable scatter when needed */
> +  if (frame_size > mbuf_data_size) {
> +      if (!(dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_SCATTER))
> +          return -EINVAL;
> +      dev->data->dev_conf.rxmode.offloads |=3D
> +          RTE_ETH_RX_OFFLOAD_SCATTER;
> +      dev->data->scattered_rx =3D 1;
> +  }
> +  ```
> +  Key relationships:
> +  - `dev_info.max_rx_pktlen`: maximum frame the hardware can receive
> +  - `dev_info.max_mtu`: maximum MTU =3D `max_rx_pktlen` - overhead
> +  - `dev_info.min_rx_bufsize`: minimum Rx buffer the HW requires
> +  - `dev_info.max_rx_bufsize`: maximum single-descriptor buffer size
> +  - `mbuf data size =3D rte_pktmbuf_data_room_size(mp) - RTE_PKTMBUF_HEA=
DROOM`
> +  - When scatter is off: frame length must fit in a single mbuf
> +  - When scatter is on: frame length can span multiple mbufs;
> +    the PMD selects a scattered Rx function
> +
> +  This pattern should be checked in three places:
> +  1. `dev_configure()` -- validate MTU against mbuf size / scatter
> +  2. `rx_queue_setup()` -- select scattered vs non-scattered Rx path
> +  3. `mtu_set()` -- runtime MTU change must re-validate
> +- **Rx queue function selection ignoring scatter**: When a PMD has
> +  separate fast-path Rx functions for scalar (single-segment) and
> +  scattered (multi-segment) modes, it must select the scattered
> +  variant whenever `dev->data->scattered_rx` is set OR when the
> +  configured frame length exceeds the single mbuf data size.
> +  Failing to do so causes the scalar Rx function to silently drop
> +  or corrupt multi-segment packets.
> +  ```c
> +  /* BAD - only checks offload flag, ignores actual need */
> +  if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER)
> +      rx_func =3D mydrv_recv_scattered;
> +  else
> +      rx_func =3D mydrv_recv_single;  /* will drop oversized pkts */
> +
> +  /* GOOD - check both the flag and the size */
> +  mbuf_size =3D rte_pktmbuf_data_room_size(rxq->mp) -
> +              RTE_PKTMBUF_HEADROOM;
> +  max_pkt =3D dev->data->mtu + overhead;
> +  if ((rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER) ||
> +      max_pkt > mbuf_size) {
> +      dev->data->scattered_rx =3D 1;
> +      rx_func =3D mydrv_recv_scattered;
> +  } else {
> +      rx_func =3D mydrv_recv_single;
> +  }
> +  ```
> +
> +### Architecture & Patterns
> +- Code that violates existing patterns in the code base
> +- Missing error handling
> +- Code that is not safe against signals
> +- **Environment variables used for driver configuration instead of devar=
gs**:
> +  Drivers must use DPDK device arguments (`devargs`) for runtime
> +  configuration, not environment variables. Devargs are preferred becaus=
e
> +  they are obviously device-specific rather than having global impact,
> +  some launch methods strip all environment variables, and devargs can
> +  be associated on a per-device basis rather than per-device-type.
> +  Use `rte_kvargs_parse()` on the devargs string instead.
> +  ```c
> +  /* BAD - environment variable for driver tuning */
> +  val =3D getenv("MYDRV_RX_BURST_SIZE");
> +  if (val !=3D NULL)
> +      burst =3D atoi(val);
> +
> +  /* GOOD - devargs parsed at probe time */
> +  static const char * const valid_args[] =3D { "rx_burst_size", NULL };
> +  kvlist =3D rte_kvargs_parse(devargs->args, valid_args);
> +  rte_kvargs_process(kvlist, "rx_burst_size", &parse_uint, &burst);
> +  ```
> +  Note: `getenv()` in EAL itself or in test/example code is acceptable.
> +  This rule applies to libraries under `lib/` and drivers under `drivers=
/`.
> +
> +### New Library API Design
> +
> +When a patch adds a new library under `lib/`, review API design in
> +addition to correctness and style.
> +
> +**API boundary.** A library should be a compiler, not a framework.
> +The model is `rte_acl`: create a context, feed input, get structured
> +output, caller decides what to do with it. No callbacks needed. If
> +the library requires callers to implement a callback table to
> +function, the boundary is wrong =E2=80=94 the library is asking the call=
er
> +to be its backend.
> +
> +**Callback structs** (Warning / Error). Any function-pointer struct
> +in an installed header is an ABI break waiting to happen. Adding or
> +reordering a member breaks all consumers.
> +- Prefer a single callback parameter over an ops table.
> +- \>5 callbacks: **Warning** =E2=80=94 likely needs redesign.
> +- \>20 callbacks: **Error** =E2=80=94 this is an app plugin API, not a l=
ibrary.
> +- All callbacks must have Doxygen (contract, return values, ownership).
> +- Void-returning callbacks for failable operations swallow errors =E2=80=
=94
> +  flag as **Error**.
> +- Callbacks serving app-specific needs (e.g. `verbose_level_get`)
> +  indicate wrong code was extracted into the library.
> +
> +**Extensible structures.** Prefer TLV / tagged-array patterns over
> +enum + union, following `rte_flow_item` and `rte_flow_action` as
> +the model. Type tag + pointer to type-specific data allows adding
> +types without ABI breaks. Flag as **Warning**:
> +- Large enums (100+) consumers must switch on.
> +- Unions that grow with every new feature.
> +- Ask: "What changes when a feature is added next release?" If
> +  "add an enum value and union arm" =E2=80=94 should be TLV.
> +
> +**Installed headers.** If it's in `headers` or `indirect_headers`
> +in meson.build, it's public API. Don't call it "private." If truly
> +internal, don't install it.
> +
> +**Global state.** Prefer handle-based APIs (`create`/`destroy`)
> +over singletons. `rte_acl` allows multiple independent classifier
> +instances; new libraries should do the same.
> +
> +**Output ownership.** Prefer caller-allocated or library-allocated-
> +caller-freed over internal static buffers. If static buffers are
> +used, document lifetime and ensure Doxygen examples don't show
> +stale-pointer usage.
> +
> +---
> +
> +## C Coding Style
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
> +- `cripple` -> Use: impacted, degraded, restricted, immobilized
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
> +Prefer `bool` (from `<stdbool.h>`) over `int` for variables,
> +parameters, and return values that are purely true/false. Using
> +`bool` makes intent explicit, enables compiler diagnostics for
> +misuse, and is self-documenting.
> +
> +```c
> +/* Bad - int used as boolean flag */
> +int verbose =3D 0;
> +int is_enabled =3D 1;
> +
> +int
> +check_valid(struct item *item)
> +{
> +=09if (item->flags & ITEM_VALID)
> +=09=09return 1;
> +=09return 0;
> +}
> +
> +/* Good - bool communicates intent */
> +bool verbose =3D false;
> +bool is_enabled =3D true;
> +
> +bool
> +check_valid(struct item *item)
> +{
> +=09return item->flags & ITEM_VALID;
> +}
> +```
> +
> +**Guidelines:**
> +- Use `bool` for variables that only hold true/false values
> +- Use `bool` return type for predicate functions (functions that
> +  answer a yes/no question, often named `is_*`, `has_*`, `can_*`)
> +- Use `true`/`false` rather than `1`/`0` for boolean assignments
> +- Boolean variables and parameters should not use explicit
> +  comparison: `if (verbose)` is correct, not `if (verbose =3D=3D true)`
> +- `int` is still appropriate when a value can be negative, is an
> +  error code, or carries more than two states
> +
> +**Structure fields:**
> +- `bool` occupies 1 byte. In packed or cache-critical structures,
> +  consider using a bitfield or flags word instead
> +- For configuration structures and non-hot-path data, `bool` is
> +  preferred over `int` for flag fields
> +
> +```c
> +/* Bad - int flags waste space and obscure intent */
> +struct port_config {
> +=09int promiscuous;     /* 0 or 1 */
> +=09int link_up;         /* 0 or 1 */
> +=09int autoneg;         /* 0 or 1 */
> +=09uint16_t mtu;
> +};
> +
> +/* Good - bool for flag fields */
> +struct port_config {
> +=09bool promiscuous;
> +=09bool link_up;
> +=09bool autoneg;
> +=09uint16_t mtu;
> +};
> +
> +/* Also good - bitfield for cache-critical structures */
> +struct fast_path_config {
> +=09uint32_t flags;      /* bitmask of CONFIG_F_* */
> +=09/* ... hot-path fields ... */
> +};
> +```
> +
> +**Do NOT flag:**
> +- `int` return type for functions that return error codes (0 for
> +  success, negative for error) =E2=80=94 these are NOT boolean
> +- `int` used for tri-state or multi-state values
> +- `int` flags in existing code where changing the type would be a
> +  large, unrelated refactor
> +- Bitfield or flags-word approaches in performance-critical
> +  structures
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
> +### Non-const Function Pointer Arrays
> +
> +Arrays of function pointers (ops tables, dispatch tables, callback array=
s)
> +should be declared `const` when their contents are fixed at compile time=
.
> +A non-`const` function pointer array can be overwritten by bugs or explo=
its,
> +and prevents the compiler from placing the table in read-only memory.
> +
> +```c
> +/* Bad - mutable when it doesn't need to be */
> +static rte_rx_burst_t rx_functions[] =3D {
> +=09rx_burst_scalar,
> +=09rx_burst_vec_avx2,
> +=09rx_burst_vec_avx512,
> +};
> +
> +/* Good - immutable dispatch table */
> +static const rte_rx_burst_t rx_functions[] =3D {
> +=09rx_burst_scalar,
> +=09rx_burst_vec_avx2,
> +=09rx_burst_vec_avx512,
> +};
> +```
> +
> +**Exceptions** (do NOT flag):
> +- Arrays modified at runtime for CPU feature detection or capability pro=
bing
> +  (e.g., selecting a burst function based on `rte_cpu_get_flag_enabled()=
`)
> +- Arrays containing mutable state (e.g., entries that are linked into li=
sts)
> +- Arrays populated dynamically via registration APIs
> +- `dev_ops` or similar structures assigned per-device at init time
> +
> +Only flag when the array is fully initialized at declaration with consta=
nt
> +values and never modified thereafter.
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
> +| `getenv()` | `rte_kvargs_parse()` / devargs | drivers/ (allowed in EAL=
, examples/, app/test/) |
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
> +#### Shared Variable Access: volatile vs Atomics
> +
> +Variables shared between threads or between a thread and a signal
> +handler **must** use atomic operations. The C `volatile` keyword is
> +NOT a substitute for atomics =E2=80=94 it prevents compiler optimization
> +of accesses but provides no atomicity guarantees and no memory
> +ordering between threads. On some architectures, `volatile` reads
> +and writes may tear on unaligned or multi-word values.
> +
> +DPDK provides C11 atomic wrappers that are portable across all
> +supported compilers and architectures. Always use these for shared
> +state.
> +
> +**Reading shared variables:**
> +
> +```c
> +/* BAD - volatile provides no atomicity or ordering guarantee */
> +volatile int stop_flag;
> +if (stop_flag)           /* data race, compiler/CPU can reorder */
> +    return;
> +
> +/* BAD - direct access to shared variable without atomic */
> +if (shared->running)     /* undefined behavior if another thread writes =
*/
> +    process();
> +
> +/* GOOD - DPDK C11 atomic wrapper */
> +if (rte_atomic_load_explicit(&shared->stop_flag, rte_memory_order_acquir=
e))
> +    return;
> +
> +/* GOOD - relaxed is fine for statistics or polling a flag where
> + * you don't need to synchronize other memory accesses */
> +count =3D rte_atomic_load_explicit(&shared->count, rte_memory_order_rela=
xed);
> +```
> +
> +**Writing shared variables:**
> +
> +```c
> +/* BAD - volatile write */
> +volatile int *flag =3D &shared->ready;
> +*flag =3D 1;
> +
> +/* GOOD - atomic store with appropriate ordering */
> +rte_atomic_store_explicit(&shared->ready, 1, rte_memory_order_release);
> +```
> +
> +**Read-modify-write operations:**
> +
> +```c
> +/* BAD - not atomic even with volatile */
> +volatile uint64_t *counter =3D &stats->packets;
> +*counter +=3D nb_rx;       /* TOCTOU: load, add, store is 3 operations *=
/
> +
> +/* GOOD - atomic add */
> +rte_atomic_fetch_add_explicit(&stats->packets, nb_rx,
> +    rte_memory_order_relaxed);
> +```
> +
> +#### Forbidden Atomic APIs in New Code
> +
> +New code **must not** use GCC/Clang `__atomic_*` built-ins or the
> +legacy DPDK `rte_smp_*mb()` barriers. These are deprecated and
> +will be removed. Use the DPDK C11 atomic wrappers instead.
> +
> +**GCC/Clang `__atomic_*` built-ins =E2=80=94 do not use:**
> +
> +```c
> +/* BAD - GCC built-in, not portable, not DPDK API */
> +val =3D __atomic_load_n(&shared->count, __ATOMIC_RELAXED);
> +__atomic_store_n(&shared->flag, 1, __ATOMIC_RELEASE);
> +__atomic_fetch_add(&shared->counter, 1, __ATOMIC_RELAXED);
> +__atomic_compare_exchange_n(&shared->state, &expected, desired,
> +    0, __ATOMIC_ACQ_REL, __ATOMIC_ACQUIRE);
> +__atomic_thread_fence(__ATOMIC_SEQ_CST);
> +
> +/* GOOD - DPDK C11 atomic wrappers */
> +val =3D rte_atomic_load_explicit(&shared->count, rte_memory_order_relaxe=
d);
> +rte_atomic_store_explicit(&shared->flag, 1, rte_memory_order_release);
> +rte_atomic_fetch_add_explicit(&shared->counter, 1, rte_memory_order_rela=
xed);
> +rte_atomic_compare_exchange_strong_explicit(&shared->state, &expected, d=
esired,
> +    rte_memory_order_acq_rel, rte_memory_order_acquire);
> +rte_atomic_thread_fence(rte_memory_order_seq_cst);
> +```
> +
> +Similarly, do not use `__sync_*` built-ins (`__sync_fetch_and_add`,
> +`__sync_bool_compare_and_swap`, etc.) =E2=80=94 these are the older GCC
> +atomics with implicit full barriers and are even less appropriate
> +than `__atomic_*`.
> +
> +**Legacy DPDK barriers =E2=80=94 do not use:**
> +
> +```c
> +/* BAD - legacy DPDK barriers, deprecated */
> +rte_smp_mb();            /* full memory barrier */
> +rte_smp_rmb();           /* read memory barrier */
> +rte_smp_wmb();           /* write memory barrier */
> +
> +/* GOOD - C11 fence with explicit ordering */
> +rte_atomic_thread_fence(rte_memory_order_seq_cst);   /* replaces rte_smp=
_mb() */
> +rte_atomic_thread_fence(rte_memory_order_acquire);    /* replaces rte_sm=
p_rmb() */
> +rte_atomic_thread_fence(rte_memory_order_release);    /* replaces rte_sm=
p_wmb() */
> +
> +/* BETTER - use ordering on the atomic operation itself when possible */
> +val =3D rte_atomic_load_explicit(&shared->flag, rte_memory_order_acquire=
);
> +rte_atomic_store_explicit(&shared->flag, 1, rte_memory_order_release);
> +```
> +
> +The legacy `rte_atomic16/32/64_*()` type-specific functions (e.g.,
> +`rte_atomic32_inc()`, `rte_atomic64_read()`) are also deprecated.
> +Use `rte_atomic_fetch_add_explicit()`, `rte_atomic_load_explicit()`,
> +etc. with standard C integer types.
> +
> +| Deprecated API | Replacement |
> +|----------------|-------------|
> +| `__atomic_load_n()` | `rte_atomic_load_explicit()` |
> +| `__atomic_store_n()` | `rte_atomic_store_explicit()` |
> +| `__atomic_fetch_add()` | `rte_atomic_fetch_add_explicit()` |
> +| `__atomic_compare_exchange_n()` | `rte_atomic_compare_exchange_strong_=
explicit()` |
> +| `__atomic_thread_fence()` | `rte_atomic_thread_fence()` |
> +| `__ATOMIC_RELAXED` | `rte_memory_order_relaxed` |
> +| `__ATOMIC_ACQUIRE` | `rte_memory_order_acquire` |
> +| `__ATOMIC_RELEASE` | `rte_memory_order_release` |
> +| `__ATOMIC_ACQ_REL` | `rte_memory_order_acq_rel` |
> +| `__ATOMIC_SEQ_CST` | `rte_memory_order_seq_cst` |
> +| `rte_smp_mb()` | `rte_atomic_thread_fence(rte_memory_order_seq_cst)` |
> +| `rte_smp_rmb()` | `rte_atomic_thread_fence(rte_memory_order_acquire)` =
|
> +| `rte_smp_wmb()` | `rte_atomic_thread_fence(rte_memory_order_release)` =
|
> +| `rte_atomic32_inc(&v)` | `rte_atomic_fetch_add_explicit(&v, 1, rte_mem=
ory_order_relaxed)` |
> +| `rte_atomic64_read(&v)` | `rte_atomic_load_explicit(&v, rte_memory_ord=
er_relaxed)` |
> +
> +#### Memory Ordering Guide
> +
> +Use the weakest ordering that is correct. Stronger ordering
> +constrains hardware and compiler optimization unnecessarily.
> +
> +| DPDK Ordering | When to Use |
> +|---------------|-------------|
> +| `rte_memory_order_relaxed` | Statistics counters, polling flags where =
no other data depends on the value. Most common for simple counters. |
> +| `rte_memory_order_acquire` | **Load** side of a flag/pointer that guar=
ds access to other shared data. Ensures subsequent reads see data published=
 by the releasing thread. |
> +| `rte_memory_order_release` | **Store** side of a flag/pointer that pub=
lishes shared data. Ensures all prior writes are visible to a thread that d=
oes an acquire load. |
> +| `rte_memory_order_acq_rel` | Read-modify-write operations (e.g., `fetc=
h_add`) that both consume and publish shared state in one operation. |
> +| `rte_memory_order_seq_cst` | Rarely needed. Only when multiple indepen=
dent atomic variables must be observed in a globally consistent total order=
. Avoid unless required. |
> +
> +**Common pattern =E2=80=94 producer/consumer flag:**
> +
> +```c
> +/* Producer thread: fill buffer, then signal ready */
> +fill_buffer(buf, data, len);
> +rte_atomic_store_explicit(&shared->ready, 1, rte_memory_order_release);
> +
> +/* Consumer thread: wait for flag, then read buffer */
> +while (!rte_atomic_load_explicit(&shared->ready, rte_memory_order_acquir=
e))
> +    rte_pause();
> +process_buffer(buf, len);  /* guaranteed to see producer's writes */
> +```
> +
> +**Common pattern =E2=80=94 statistics counter (no ordering needed):**
> +
> +```c
> +rte_atomic_fetch_add_explicit(&port_stats->rx_packets, nb_rx,
> +    rte_memory_order_relaxed);
> +```
> +
> +#### Standalone Fences
> +
> +Prefer ordering on the atomic operation itself (acquire load,
> +release store) over standalone fences. Standalone fences
> +(`rte_atomic_thread_fence()`) are a blunt instrument that
> +orders ALL memory accesses around the fence, not just the
> +atomic variable you care about.
> +
> +```c
> +/* Acceptable but less precise - standalone fence */
> +rte_atomic_store_explicit(&shared->flag, 1, rte_memory_order_relaxed);
> +rte_atomic_thread_fence(rte_memory_order_release);
> +
> +/* Preferred - ordering on the operation itself */
> +rte_atomic_store_explicit(&shared->flag, 1, rte_memory_order_release);
> +```
> +
> +Standalone fences are appropriate when synchronizing multiple
> +non-atomic writes (e.g., filling a structure before publishing
> +a pointer to it) where annotating each write individually is
> +impractical.
> +
> +#### When volatile Is Still Acceptable
> +
> +`volatile` remains correct for:
> +- Memory-mapped I/O registers (hardware MMIO)
> +- Variables shared with signal handlers in single-threaded contexts
> +- Interaction with `setjmp`/`longjmp`
> +
> +`volatile` is NOT correct for:
> +- Any variable accessed by multiple threads
> +- Polling flags between lcores
> +- Statistics counters updated from multiple threads
> +- Flags set by one thread and read by another
> +
> +**Do NOT flag** `volatile` used for MMIO or hardware register access
> +(common in drivers under `drivers/*/base/`).
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
> +### Commit Message and License
> +
> +Checked by `devtools/checkpatches.sh` -- not duplicated here.
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
> +- [ ] Left shifts of `uint8_t`/`uint16_t` cast to unsigned target width =
before shift when result is 64-bit
> +- [ ] No unconditional variable overwrites before read
> +- [ ] Nested loops use distinct counter variables
> +- [ ] No `memcpy`/`memcmp` with identical source and destination pointer=
s
> +- [ ] `rte_mbuf_raw_free_bulk()` not used on mixed-pool mbuf arrays (Tx =
paths, ring dequeue, error paths)
> +- [ ] MTU not confused with frame length (MTU =3D L3 payload, frame =3D =
MTU + L2 overhead)
> +- [ ] PMDs read `dev->data->mtu` after configure, not `dev_conf.rxmode.m=
tu`
> +- [ ] Ethernet overhead not hardcoded -- derived from device capabilitie=
s
> +- [ ] Scatter Rx enabled or error returned when frame length exceeds sin=
gle mbuf data size
> +- [ ] `mtu_set` allows large MTU when scatter Rx is active; re-selects R=
x burst function
> +- [ ] Rx queue setup selects scattered Rx function when frame length exc=
eeds mbuf
> +- [ ] Static function pointer arrays declared `const` when contents are =
compile-time fixed
> +- [ ] `bool` used for pure true/false variables, parameters, and predica=
te return types
> +- [ ] Shared variables use `rte_atomic_*_explicit()`, not `volatile` or =
bare access
> +- [ ] No `__atomic_*()` GCC built-ins or `__ATOMIC_*` ordering constants=
 (use `rte_atomic_*_explicit()` and `rte_memory_order_*`)
> +- [ ] No `rte_smp_mb()`/`rte_smp_rmb()`/`rte_smp_wmb()` (use `rte_atomic=
_thread_fence()`)
> +- [ ] Memory ordering is the weakest correct choice (`relaxed` for count=
ers, `acquire`/`release` for publish/consume)
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
> +- `volatile` used instead of atomics for inter-thread shared variables
> +- `__atomic_*()` GCC built-ins in new code (must use `rte_atomic_*_expli=
cit()`)
> +- `rte_smp_mb()`/`rte_smp_rmb()`/`rte_smp_wmb()` in new code (must use `=
rte_atomic_thread_fence()`)
> +- Error path that skips necessary cleanup
> +- `mmap()` return value checked against NULL instead of `MAP_FAILED`
> +- Statistics accumulation using `=3D` instead of `+=3D` (overwrite vs in=
crement)
> +- Integer multiply without widening cast losing upper bits (16=C3=9716, =
32=C3=9732, etc.)
> +- Unbounded descriptor chain traversal on guest/API-supplied indices
> +- `1 << n` used for 64-bit bitmask (undefined behavior if n >=3D 32)
> +- Left shift of `uint8_t`/`uint16_t` used in 64-bit context without wide=
ning cast (sign extension)
> +- Variable assigned then unconditionally overwritten before read
> +- Same variable used as counter in nested loops
> +- `memcpy`/`memcmp` with same pointer as both arguments (UB or no-op log=
ic error)
> +- `rte_mbuf_raw_free_bulk()` on mbuf array where mbufs may come from dif=
ferent pools (Tx burst, ring dequeue)
> +- MTU used where frame length is needed or vice versa (off by L2 overhea=
d)
> +- `dev_conf.rxmode.mtu` read after configure instead of `dev->data->mtu`=
 (stale value)
> +- MTU accepted without scatter Rx when frame size exceeds single mbuf ca=
pacity (silent truncation/drop)
> +- `mtu_set` rejects valid MTU when scatter Rx is already enabled
> +- Rx function selection ignores `scattered_rx` flag or MTU-vs-mbuf-size =
comparison
> +
> +*Process and format errors:*
> +- Forbidden tokens in code
> +- `__rte_experimental`/`__rte_internal` in .c files or not alone on line
> +- Compilation failures
> +- ABI breaks without proper versioning
> +- pthread mutex/cond/rwlock in shared memory without `PTHREAD_PROCESS_SH=
ARED`
> +
> +*API design errors (new libraries only):*
> +- Ops/callback struct with 20+ function pointers in an installed header
> +- Callback struct members with no Doxygen documentation
> +- Void-returning callbacks for failable operations (errors silently swal=
lowed)
> +
> +**Warning** (should fix):
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
> +- Ops/callback struct with >5 function pointers in an installed header (=
ABI risk)
> +- New API using fixed enum+union where TLV pattern would be more extensi=
ble
> +- Installed header labeled "private" or "internal" in meson.build
> +- New library using global singleton instead of handle-based API
> +- Static function pointer array not declared `const` when contents are c=
ompile-time constant
> +- `int` used instead of `bool` for variables or return values that are p=
urely true/false
> +- `rte_memory_order_seq_cst` used where weaker ordering (`relaxed`, `acq=
uire`/`release`) suffices
> +- Standalone `rte_atomic_thread_fence()` where ordering on the atomic op=
eration itself would be clearer
> +- `getenv()` used in a driver or library for runtime configuration inste=
ad of devargs
> +- Hardcoded Ethernet overhead constant instead of per-device overhead ca=
lculation
> +- PMD does not advertise `RTE_ETH_RX_OFFLOAD_SCATTER` in `rx_offload_cap=
a` but hardware supports multi-segment Rx
> +- PMD `dev_info` reports `max_rx_pktlen` or `max_mtu` inconsistent with =
each other or with the Ethernet overhead
> +- `mtu_set` callback does not re-select the Rx burst function after chan=
ging MTU
> +
> +**Do NOT flag** (common false positives):
> +- Missing `version.map` updates (maps are auto-generated from `RTE_EXPOR=
T_*` macros)
> +- Suggesting manual edits to any `version.map` file
> +- SPDX/copyright format, copyright years, copyright holders (not subject=
 to AI review)
> +- Commit message formatting (subject length, punctuation, tag order, cas=
e-sensitive terms) -- checked by checkpatch
> +- Meson file lines under 100 characters
> +- Comparisons using `=3D=3D 0`, `!=3D 0`, `=3D=3D NULL`, `!=3D NULL` as =
"implicit" (these ARE explicit)
> +- Comparisons wrapped in `likely()` or `unlikely()` macros - these are s=
till explicit if using =3D=3D or !=3D
> +- Anything you determine is correct (do not mention non-issues or say "N=
o issue here")
> +- `REGISTER_FAST_TEST` using `NOHUGE_OK`/`ASAN_OK` macros (this is the c=
orrect current format)
> +- Missing release notes for test-only changes (unit tests do not require=
 release notes)
> +- Missing release notes for internal APIs or helper functions (only publ=
ic APIs need release notes)
> +- Any item you later correct with "(Correction: ...)" or "actually accep=
table" - just omit it
> +- Vague concerns ("should be verified", "should be checked") - if you're=
 not sure it's wrong, don't flag it
> +- Items where you say "which is correct" or "this is correct" - if it's =
correct, don't mention it at all
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
> +- `volatile` used for MMIO/hardware register access in drivers (this is =
correct usage)
> +- Left shift of `uint8_t`/`uint16_t` where the result is stored in a `ui=
nt32_t` or narrower variable and not used in pointer arithmetic or 64-bit c=
ontext (sign extension cannot occur)
> +- `getenv()` used in EAL, examples, app/test, or build/config scripts (o=
nly flag in drivers/ and lib/)
> +- Reading `rxmode.mtu` inside `rte_eth_dev_configure()` implementation (=
that is where the user request is consumed)
> +- `=3D` assignment to MTU or frame length fields during initial setup (o=
nly flag stale reads of `rxmode.mtu` outside configure)
> +- PMDs that auto-enable scatter when MTU exceeds mbuf size (this is the =
correct pattern)
> +- Hardcoded `RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN` as overhead when the=
 PMD does not support VLAN and device info is consistent
> +- Tagged frames exceeding 1518 bytes at standard MTU =E2=80=94 a single-=
tagged frame of 1522 bytes is valid at MTU 1500 (the outer VLAN header is L=
2 overhead, not payload). Note: inner VLAN tags in QinQ *do* consume MTU; s=
ee the MTU section for details.
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

