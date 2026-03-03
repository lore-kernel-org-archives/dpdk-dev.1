Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B095CEB3641
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 01:01:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B436402AB;
	Tue,  3 Mar 2026 02:01:14 +0100 (CET)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52]) by mails.dpdk.org (Postfix) with ESMTP id 8265940289
 for <dev@dpdk.org>; Tue,  3 Mar 2026 02:01:12 +0100 (CET)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-64ad9238d8fso4873494d50.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 17:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772499672; cv=none;
 d=google.com; s=arc-20240605;
 b=D883mUUPLev6EISUxB7tOK6+wJjYKraPbR7aTDxHeUcUFa2vcFw32TYy5aCFoFJ8y8
 OdMmoIjNdknWf/JVFBOjqrojyfDP3BUQJN9Q3uATIqo0tH+2UAM8x1kzh6QEcrM9A9gt
 ukG+16yzrKZFCyfRpOhSF8N0wdvopQL/tfuIPiz7XL6de8Q15DRxySgSLQsbOTTxl4C8
 hDUp2JPy7psnIwWvLLBMJAdX+/oCscqbDZYVzvu1kPYa4HcL/Rt1R6G/0ZGxcWxXFiX9
 HaAf4NSuSufOY31+ks+0X2g/nqDqd7F6SlbaTOHmXESTistcuwRqb0yFbNN4mcO/A0cr
 qW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L3XJ5Zy0JWpEZOgS5gFoWy3h1IP4zdGncQ/9A6zjptg=;
 fh=0E6rhHenMJTx7iCVaVeG4mOH4i93OFLcPVvmIeKwsk8=;
 b=ESjDAjXIc3FUkP9McxVEeKUmpnYw6wR/EYOK4RY3QmytW6EfAVspVXrVFQmSP42bAD
 EUtL773CTcdOcjjYuOmLucQcW6dJnRCd6tQbu4PGPtkBnhlofGFCSbdtfKEhIQqlLvjb
 gLdbX53luHpcIMN0KXiMgG9n8/0yWCDCDeu/a7aNe5bxf5XLN1plZFZTHmo0OJiSiOyK
 yHVaEwHZ9PFFemExdJxmVPAIRTURZllDS2BX0EaH1E81vYdFzu5/mF/SQsuCBlIyvvkI
 9715XfObrVu6v9CFXitZb41RDEZxWrF+V/oR9oUeQeMPDTPWmQ8KsQDHb60hQyg74X1L
 BCzg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772499672; x=1773104472; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L3XJ5Zy0JWpEZOgS5gFoWy3h1IP4zdGncQ/9A6zjptg=;
 b=NvP/MW8Qw6E5nZgJ2mjvulCIfFUm1B97JBSkVoNSOuX7dudHQQNv5K1nUnwnseA4eF
 p+x+SyR3nxoYklSYhOd8aT48GDPFXskt8gc3BneTwIAPFJ75xslPr3rXzBlR/bKgQUqG
 IiFnLe3UVPwU3klZoaQK4jVK7hjjyQ3bWHEO2tN0ysPmQMEermolv5i0mbiZ3DmqxF7t
 T8c5UGBOHTFSKE9dV3hn3tcVTySVbvk4ksvARKY5qXU4kjI8pbXXM0jyX6eIi+xbbydV
 djd8wcmu0VnuwcXoYjXs5twbkmDn6xd6PJfLE+cV0xytyiJCK8CJEWPFcdAnWIXSE3vu
 K5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772499672; x=1773104472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3XJ5Zy0JWpEZOgS5gFoWy3h1IP4zdGncQ/9A6zjptg=;
 b=wTx4FWNMEmBLE6Koy2eS4DpUrK7h8kaxM2wjSHG5HlJ12s1PTEGrU//g/7pwlpkX+g
 c24zhETNLFnsyYhGdkic7VvydcmDERdoTtACcWq+kstjMOP3VwJNeEHw6U3LzzSH0hx6
 BqNCKp62gRFaBzQX9hCI9ZyEKx2ihEFxRBWrXptHeERA1J1CMHaVWcWzHPQqKfzuVMs3
 Ttx3v7HSbDja6f3uc+jh/HwmvqWg44/88gb9jEC8wnR1uasRWi7nqSDdL8LNkiwq5768
 xDR2QEm34tEj+ok/x6ta/r3eAnC9O8LxZ75bddY16pH0RILv3XZy7Q01Gywfxf6+MzNJ
 p/qA==
X-Gm-Message-State: AOJu0YwTX6WnHxtIHTJuCGbpKr/gu7C96u2dku1jlpU678g/Hwoo8ZWa
 Eo8NEStBbrhBrN34mI/jFGE2x2G3o8h00J4JWdlMV6RbDLC8DwGL7G8Q7tQGAREwuK06zJUK9Q2
 RyJCOEFET1XQt9u0ivw/AZWRP4YBKQcL4x2zjescd
X-Gm-Gg: ATEYQzxDd+MR2wXmVSw3mlAVdrUhmYtLDcqFTdwf+7NVopUZkMXWUtsWIauUNNMGJxH
 6EhgYD/5PgPi3t9FYOM56d9/s0KL50kkEZxm/NEF9QlM9XPLACcTKCW53aI+74umGhfZ/4k7uGm
 NuobXG0uYAFJWmEVgfNZtxpWN74RSPilkOrIqqnTp1JJsvTP9E8eanA9HgS7Vj/n/yO8qePpBWh
 fhE/G2WJVxVG0SUWArRD9/Ps+njjUJwKGrBQF56dO6TN4qDh88mpg5RSyKFAQyKX6SADGzdpkID
 5UBnTCTYWOM7aQ2j2NHbGpmp2jI2ua+Evtngdw==
X-Received: by 2002:a53:cc45:0:b0:64c:9fcf:2ad6 with SMTP id
 956f58d0204a3-64cc2303a81mr9039697d50.74.1772499670810; Mon, 02 Mar 2026
 17:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20260227195126.3545607-1-jtranoleary@google.com>
 <20260227145233.002b87e1@phoenix.local>
In-Reply-To: <20260227145233.002b87e1@phoenix.local>
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
Date: Mon, 2 Mar 2026 17:00:59 -0800
X-Gm-Features: AaiRm52ayHFOj5H4iAkFpAVX8j4AIpdPjq5iYYIWCgrkQ5I9Z4BPMXM1t-nmATA
Message-ID: <CAAESxLK38Jiv1ef3-eLeRaSg=09k+pXw_pYZLTYfvixxWmP1GA@mail.gmail.com>
Subject: Re: [PATCH 0/4] net/gve: add flow steering support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: multipart/alternative; boundary="0000000000003fcf4e064c143d2d"
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

--0000000000003fcf4e064c143d2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the notes, I've addressed the issues as follows and submitted a
v2 revision.

[Patch 3/4]

1. Updated copyright header in `gve_flow_rule.h`.

[Patch 4/4]

0. Similar to patch 3, updated the copyright header in `gve_flow_rule.c`.
1. Fixed the memory leak in rule flush by freeing the bitmap on flush
failure. This preserves the invariant where `gve_get_flow_subsystem_okay`
is true if and only if the flow ID bitmap and flow rule tail queue are
initialized.
2. Added a `mutexattr_t` with `PTHREAD_PROCESS_SHARED` to the flow mutex
initialization.
3. Changed the aforementioned instances of `(!pointer)` and a few others to
use `pointer =3D=3D NULL`.
4. Retained the use of `rte_zmalloc` for both `struct gve_flow` and
`priv->avail_flow_rule_bmp_mem` because this memory is shared between
processes.
5. Retained memory barriers in case we call the flag checks from
non-critical paths in the future.
6. Updated the documentation to use a definition list for supported
protocols, and made minor formatting adjustments to make the definition
list look more natural in the flow steering subsection.

On Fri, Feb 27, 2026 at 2:52=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Fri, 27 Feb 2026 19:51:22 +0000
> "Jasper Tran O'Leary" <jtranoleary@google.com> wrote:
>
> > This patch series adds flow steering support to the Google Virtual
> > Ethernet (gve) driver. This functionality allows traffic to be directed
> > to specific receive queues based on user-specified flow patterns.
> >
> > The series includes foundational support for extended admin queue
> > commands needed to handle flow rules, the specific adminqueue commands
> > for flow rule management, and the integration with the DPDK rte_flow
> > API. The series adds support flow matching on the following protocols:
> > IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.
> >
> > Patch Overview:
> >
> > 1. "net/gve: add flow steering device option" checks for and enables
> >    the flow steering capability in the device options during
> >    initialization.
> > 2. "net/gve: introduce extended adminq command" adds infrastructure
> >    for sending extended admin queue commands. These commands use a
> >    flexible buffer descriptor format required for flow rule management.
> > 3. "net/gve: add adminq commands for flow steering" implements the
> >    specific admin queue commands to add and remove flow rules on the
> >    device, including handling of rule IDs and parameters.
> > 4. "net/gve: add rte flow API integration" exposes the flow steering
> >    functionality via the DPDK rte_flow API. This includes strict
> >    pattern validation, rule parsing, and lifecycle management (create,
> >    destroy, flush). It ensures thread-safe access to the flow subsystem
> >    and proper resource cleanup during device reset.
> >
> > Jasper Tran O'Leary (2):
> >   net/gve: add adminq commands for flow steering
> >   net/gve: add rte flow API integration
> >
> > Vee Agarwal (2):
> >   net/gve: add flow steering device option
> >   net/gve: introduce extended adminq command
> >
> >  doc/guides/nics/features/gve.ini       |  12 +
> >  doc/guides/nics/gve.rst                |  20 +
> >  doc/guides/rel_notes/release_26_03.rst |   1 +
> >  drivers/net/gve/base/gve.h             |   3 +-
> >  drivers/net/gve/base/gve_adminq.c      | 118 ++++-
> >  drivers/net/gve/base/gve_adminq.h      |  57 +++
> >  drivers/net/gve/gve_ethdev.c           |  87 +++-
> >  drivers/net/gve/gve_ethdev.h           |  46 ++
> >  drivers/net/gve/gve_flow_rule.c        | 645 +++++++++++++++++++++++++
> >  drivers/net/gve/gve_flow_rule.h        |  64 +++
> >  drivers/net/gve/meson.build            |   1 +
> >  11 files changed, 1049 insertions(+), 5 deletions(-)
> >  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
> >  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h
> >
>
> There is a lot here, so sent AI to take a look.
>
> Summary:
> Error 1 =E2=80=94 Resource leak: If gve_flush_flow_rules fails and disabl=
es the
> flow subsystem via gve_clear_flow_subsystem_ok(), the bitmap memory
> (avail_flow_rule_bmp_mem) is never freed because both gve_dev_close and
> gve_dev_reset gate their teardown on gve_get_flow_subsystem_ok()
> returning true. The guard needs to check for allocated memory rather
> than subsystem state.
>
> Error 2 =E2=80=94 pthread_mutex_init with NULL attributes in shared memor=
y: The
> flow_rule_lock lives in dev_private (DPDK shared memory) but is
> initialized without PTHREAD_PROCESS_SHARED. This will cause undefined
> behavior with secondary processes. Switching to rte_spinlock_t would be
> the simplest fix since the critical sections are short (bitmap scan +
> TAILQ operations).
>
> Patches 1=E2=80=933 are clean. The overall structure and error handling i=
n patch 4
> is solid =E2=80=94 the allocation-before-lock pattern, bitmap rollback on=
 adminq
> failure, and defense-in-depth validation in destroy are all well done.
> Long form:
> # Code Review: GVE Flow Steering Patch Series (4 patches)
>
> **Series**: `[PATCH 1/4]` through `[PATCH 4/4]`
> **Author**: Jasper Tran O'Leary / Vee Agarwal (Google)
> **Subject**: Add receive flow steering (RFS) support to the GVE driver
>
> ---
>
> ## Summary
>
> This series adds n-tuple flow steering to the GVE (Google Virtual
> Ethernet) driver via the `rte_flow` API. The implementation is cleanly
> structured across four patches: device option discovery (1/4), extended
> adminq infrastructure (2/4), flow rule adminq commands (3/4), and full
> rte_flow integration (4/4). The code quality is generally good with
> thorough validation, proper locking, and well-structured error handling.
>
> Two correctness issues were identified: a resource leak when the flow
> subsystem is disabled on error, and a missing `PTHREAD_PROCESS_SHARED`
> attribute on a mutex in shared memory.
>
> ---
>
> ## Patch 1/4: `net/gve: add flow steering device option`
>
> ### Errors
>
> None.
>
> ### Warnings
>
> None.
>
> This patch is clean. The device option parsing follows the established
> pattern for existing options (modify_ring, jumbo_frames), the byte-swap o=
f
> `max_flow_rules` is correct, and the zero-check on the big-endian value
> before byte-swap is valid (non-zero in any byte order is still non-zero).
>
> ---
>
> ## Patch 2/4: `net/gve: introduce extended adminq command`
>
> ### Errors
>
> None.
>
> ### Warnings
>
> None.
>
> The extended command mechanism is straightforward: allocate DMA memory fo=
r
> the inner command, copy the command in, set up the outer wrapper with the
> DMA address, execute, and free. The error path is correct =E2=80=94
> `gve_free_dma_mem` is called after `gve_adminq_execute_cmd` regardless of
> success or failure.
>
> ---
>
> ## Patch 3/4: `net/gve: add adminq commands for flow steering`
>
> ### Errors
>
> None.
>
> ### Warnings
>
> **1. `gve_flow_rule.h` copyright appears to be copied from an Intel drive=
r
> file.**
>
> ```c
> /* SPDX-License-Identifier: BSD-3-Clause
>  * Copyright(C) 2022 Intel Corporation
>  */
> ```
>
> This is a new file in the Google GVE driver. The Intel copyright and 2022
> date look like they were carried over from whichever file was used as a
> template. This should be updated to reflect the actual author.
>
> ---
>
> ## Patch 4/4: `net/gve: add rte flow API integration`
>
> This is the largest patch (815 lines added) and where the significant
> findings are.
>
> ### Errors
>
> **1. Resource leak: bitmap memory leaked when flow subsystem is disabled
> on error.**
>
> In `gve_flush_flow_rules`, if either `gve_free_flow_rules()` or
> `gve_flow_init_bmp()` fails, the code disables the subsystem:
>
> ```c
> gve_clear_flow_subsystem_ok(priv);
> ```
>
> However, in both `gve_dev_close` and `gve_dev_reset`, teardown is gated o=
n
> the flag:
>
> ```c
> if (gve_get_flow_subsystem_ok(priv))
>     gve_teardown_flow_subsystem(priv);
> ```
>
> If the subsystem was disabled by a failed flush,
> `gve_teardown_flow_subsystem` is never called, and
> `priv->avail_flow_rule_bmp_mem` is never freed. This is a memory leak.
>
> **Suggested fix**: Either (a) always call `gve_flow_free_bmp(priv)` in
> close/reset regardless of the flag, or (b) have the flush error path free
> the bitmap memory itself, or (c) unconditionally call teardown in
> close/reset:
>
> ```c
> /* In gve_dev_close / gve_dev_reset: */
> if (priv->avail_flow_rule_bmp_mem)
>     gve_teardown_flow_subsystem(priv);
> ```
>
> **2. `pthread_mutex_init` without `PTHREAD_PROCESS_SHARED` on a mutex in
> shared memory.**
>
> In `gve_dev_init`:
>
> ```c
> pthread_mutex_init(&priv->flow_rule_lock, NULL);
> ```
>
> `priv` is `dev->data->dev_private`, which is allocated in DPDK shared
> memory accessible by both primary and secondary processes. A pthread mute=
x
> in shared memory initialized with `NULL` attributes has undefined behavio=
r
> when used across processes. It may appear to work in testing but fail in
> production with secondary processes.
>
> **Suggested fix**: Either use `PTHREAD_PROCESS_SHARED`:
>
> ```c
> pthread_mutexattr_t attr;
> pthread_mutexattr_init(&attr);
> pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
> pthread_mutex_init(&priv->flow_rule_lock, &attr);
> pthread_mutexattr_destroy(&attr);
> ```
>
> Or switch to `rte_spinlock_t` which works correctly in shared memory
> without special initialization (appropriate here since the critical
> sections are short =E2=80=94 bitmap scan, TAILQ insert/remove):
>
> ```c
> rte_spinlock_t flow_rule_lock;
> /* ... */
> rte_spinlock_init(&priv->flow_rule_lock);
> ```
>
> ### Warnings
>
> **3. Implicit pointer comparisons throughout `gve_flow_rule.c`.**
>
> Several places use `!pointer` instead of `pointer =3D=3D NULL`:
>
> ```c
> if (!flow) {          /* line ~1641, ~1710 */
> if (!action->conf) {  /* line ~1510 */
> if (!attr) {          /* line ~1173 */
> if (!actions) {       /* line ~1498 */
> if (!pattern) {       /* line ~1329 */
> ```
>
> DPDK coding style requires explicit comparison with NULL for pointers. Th=
e
> idiomatic form is `if (flow =3D=3D NULL)`.
>
> **4. `rte_zmalloc` used for flow rule metadata that does not require
> hugepage memory.**
>
> The `gve_flow` structs (8 bytes: a `uint32_t` + TAILQ pointers) are
> allocated via `rte_zmalloc`. These are small control-plane structures not
> accessed by DMA and not requiring NUMA placement. Standard `malloc` would
> be more appropriate per DPDK guidelines and would not consume limited
> hugepage resources.
>
> Similarly, `priv->avail_flow_rule_bmp_mem` is allocated with
> `rte_zmalloc`. Since `rte_bitmap` may require specific alignment, this on=
e
> is more defensible, but worth considering whether standard allocation wou=
ld
> suffice.
>
> **5. Standalone `rte_atomic_thread_fence()` in flow subsystem flag
> accessors.**
>
> The `gve_get_flow_subsystem_ok` / `gve_set_flow_subsystem_ok` /
> `gve_clear_flow_subsystem_ok` functions use standalone fences with
> `rte_bit_relaxed_*` operations:
>
> ```c
> static inline bool
> gve_get_flow_subsystem_ok(struct gve_priv *priv)
> {
>     bool ret;
>     ret =3D !!rte_bit_relaxed_get32(GVE_PRIV_FLAGS_FLOW_SUBSYSTEM_OK,
>                                   &priv->state_flags);
>     rte_atomic_thread_fence(rte_memory_order_acquire);
>     return ret;
> }
> ```
>
> These follow the existing pattern for other state flags in the driver, so
> this is consistent. However, it's worth noting that in every call site in
> this patch, the flag is checked while holding `flow_rule_lock`, which
> already provides the necessary memory ordering. The fences are redundant =
in
> those paths (but harmless).
>
> **6. RST documentation uses simple bullet lists where definition lists
> would be cleaner.**
>
> In `doc/guides/nics/gve.rst`:
>
> ```rst
> Supported Patterns:
>   - IPv4/IPv6 source and destination addresses.
>   - TCP/UDP/SCTP source and destination ports.
>   - ESP/AH SPI.
> ```
>
> These term+list groupings would read better as RST definition lists. This
> is minor given the lists are short.
>
> ### Design Notes (Info)
>
> **Well-structured error handling in `gve_create_flow_rule`**: The
> allocation-before-lock pattern avoids holding the mutex during memory
> allocation, and the `free_flow_and_unlock` goto label correctly handles a=
ll
> error paths. The bitmap-set-on-error rollback in the adminq failure case =
is
> also correct.
>
> **`gve_destroy_flow_rule` double-validates flow state**: The function
> checks both the flow pointer for NULL and verifies `rule_id <
> max_flow_rules` before checking the bitmap. This defense-in-depth is good
> practice.
>
> **IPv6 word-reversal in `gve_parse_ipv6`**: The comment explaining the
> device's expected word order is clear and the implementation correctly
> reverses the 32-bit words. This is the kind of hardware-specific detail
> that benefits from the inline comment.
>
> ---
>
> ## Cross-Patch Observations
>
> The series is well-ordered: each patch builds incrementally and the
> dependencies flow naturally (device option =E2=86=92 extended command
> infrastructure =E2=86=92 flow rule commands =E2=86=92 rte_flow integratio=
n). The
> documentation, feature matrix, and release notes are all updated in patch
> 4/4 together with the code, which is correct per DPDK guidelines.
>
> The `Co-developed-by` / `Signed-off-by` tag sequences are correctly
> formatted per Linux kernel convention.
>

--0000000000003fcf4e064c143d2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the notes, I&#39;ve addressed the issues as fol=
lows and submitted a v2 revision.<br><br>[Patch 3/4]<br><br>1. Updated copy=
right header in `gve_flow_rule.h`.<br><br>[Patch 4/4]<br><br>0. Similar to =
patch 3, updated the copyright header in `gve_flow_rule.c`.<br>1. Fixed the=
 memory leak in rule flush by freeing the bitmap on flush failure. This pre=
serves the invariant where `gve_get_flow_subsystem_okay` is true if and onl=
y if the flow ID bitmap and flow rule tail queue are initialized.<br>2. Add=
ed a `mutexattr_t` with `PTHREAD_PROCESS_SHARED` to the flow mutex initiali=
zation.<br>3. Changed the aforementioned instances of `(!pointer)` and a fe=
w others to use `pointer =3D=3D NULL`.<br>4. Retained the use of `rte_zmall=
oc` for both `struct gve_flow` and `priv-&gt;avail_flow_rule_bmp_mem` becau=
se this memory is shared between processes.<br>5. Retained memory barriers =
in case we call the flag checks from non-critical paths in the future.<br>6=
. Updated the documentation to use a definition list for supported protocol=
s, and made minor formatting adjustments to make the definition list look m=
ore natural in the flow steering subsection.<br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fr=
i, Feb 27, 2026 at 2:52=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:=
stephen@networkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 27 Feb 2026 1=
9:51:22 +0000<br>
&quot;Jasper Tran O&#39;Leary&quot; &lt;<a href=3D"mailto:jtranoleary@googl=
e.com" target=3D"_blank">jtranoleary@google.com</a>&gt; wrote:<br>
<br>
&gt; This patch series adds flow steering support to the Google Virtual<br>
&gt; Ethernet (gve) driver. This functionality allows traffic to be directe=
d<br>
&gt; to specific receive queues based on user-specified flow patterns.<br>
&gt; <br>
&gt; The series includes foundational support for extended admin queue<br>
&gt; commands needed to handle flow rules, the specific adminqueue commands=
<br>
&gt; for flow rule management, and the integration with the DPDK rte_flow<b=
r>
&gt; API. The series adds support flow matching on the following protocols:=
<br>
&gt; IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.<br>
&gt; <br>
&gt; Patch Overview:<br>
&gt; <br>
&gt; 1. &quot;net/gve: add flow steering device option&quot; checks for and=
 enables<br>
&gt;=C2=A0 =C2=A0 the flow steering capability in the device options during=
<br>
&gt;=C2=A0 =C2=A0 initialization.<br>
&gt; 2. &quot;net/gve: introduce extended adminq command&quot; adds infrast=
ructure<br>
&gt;=C2=A0 =C2=A0 for sending extended admin queue commands. These commands=
 use a<br>
&gt;=C2=A0 =C2=A0 flexible buffer descriptor format required for flow rule =
management.<br>
&gt; 3. &quot;net/gve: add adminq commands for flow steering&quot; implemen=
ts the<br>
&gt;=C2=A0 =C2=A0 specific admin queue commands to add and remove flow rule=
s on the<br>
&gt;=C2=A0 =C2=A0 device, including handling of rule IDs and parameters.<br=
>
&gt; 4. &quot;net/gve: add rte flow API integration&quot; exposes the flow =
steering<br>
&gt;=C2=A0 =C2=A0 functionality via the DPDK rte_flow API. This includes st=
rict<br>
&gt;=C2=A0 =C2=A0 pattern validation, rule parsing, and lifecycle managemen=
t (create,<br>
&gt;=C2=A0 =C2=A0 destroy, flush). It ensures thread-safe access to the flo=
w subsystem<br>
&gt;=C2=A0 =C2=A0 and proper resource cleanup during device reset.<br>
&gt; <br>
&gt; Jasper Tran O&#39;Leary (2):<br>
&gt;=C2=A0 =C2=A0net/gve: add adminq commands for flow steering<br>
&gt;=C2=A0 =C2=A0net/gve: add rte flow API integration<br>
&gt; <br>
&gt; Vee Agarwal (2):<br>
&gt;=C2=A0 =C2=A0net/gve: add flow steering device option<br>
&gt;=C2=A0 =C2=A0net/gve: introduce extended adminq command<br>
&gt; <br>
&gt;=C2=A0 doc/guides/nics/features/gve.ini=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 12 +<br>
&gt;=C2=A0 doc/guides/nics/gve.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 20 +<br>
&gt;=C2=A0 doc/guides/rel_notes/release_26_03.rst |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/net/gve/base/gve.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +-<br>
&gt;=C2=A0 drivers/net/gve/base/gve_adminq.c=C2=A0 =C2=A0 =C2=A0 | 118 ++++=
-<br>
&gt;=C2=A0 drivers/net/gve/base/gve_adminq.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 57=
 +++<br>
&gt;=C2=A0 drivers/net/gve/gve_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 87 +++-<br>
&gt;=C2=A0 drivers/net/gve/gve_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 46 ++<br>
&gt;=C2=A0 drivers/net/gve/gve_flow_rule.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 645=
 +++++++++++++++++++++++++<br>
&gt;=C2=A0 drivers/net/gve/gve_flow_rule.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 64 +++<br>
&gt;=C2=A0 drivers/net/gve/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 11 files changed, 1049 insertions(+), 5 deletions(-)<br>
&gt;=C2=A0 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c<br>
&gt;=C2=A0 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h<br>
&gt; <br>
<br>
There is a lot here, so sent AI to take a look.<br>
<br>
Summary:<br>
Error 1 =E2=80=94 Resource leak: If gve_flush_flow_rules fails and disables=
 the<br>
flow subsystem via gve_clear_flow_subsystem_ok(), the bitmap memory<br>
(avail_flow_rule_bmp_mem) is never freed because both gve_dev_close and<br>
gve_dev_reset gate their teardown on gve_get_flow_subsystem_ok()<br>
returning true. The guard needs to check for allocated memory rather<br>
than subsystem state.<br>
<br>
Error 2 =E2=80=94 pthread_mutex_init with NULL attributes in shared memory:=
 The<br>
flow_rule_lock lives in dev_private (DPDK shared memory) but is<br>
initialized without PTHREAD_PROCESS_SHARED. This will cause undefined<br>
behavior with secondary processes. Switching to rte_spinlock_t would be<br>
the simplest fix since the critical sections are short (bitmap scan +<br>
TAILQ operations).<br>
<br>
Patches 1=E2=80=933 are clean. The overall structure and error handling in =
patch 4 is solid =E2=80=94 the allocation-before-lock pattern, bitmap rollb=
ack on adminq failure, and defense-in-depth validation in destroy are all w=
ell done.<br>
Long form:<br>
# Code Review: GVE Flow Steering Patch Series (4 patches)<br>
<br>
**Series**: `[PATCH 1/4]` through `[PATCH 4/4]`<br>
**Author**: Jasper Tran O&#39;Leary / Vee Agarwal (Google)<br>
**Subject**: Add receive flow steering (RFS) support to the GVE driver<br>
<br>
---<br>
<br>
## Summary<br>
<br>
This series adds n-tuple flow steering to the GVE (Google Virtual Ethernet)=
 driver via the `rte_flow` API. The implementation is cleanly structured ac=
ross four patches: device option discovery (1/4), extended adminq infrastru=
cture (2/4), flow rule adminq commands (3/4), and full rte_flow integration=
 (4/4). The code quality is generally good with thorough validation, proper=
 locking, and well-structured error handling.<br>
<br>
Two correctness issues were identified: a resource leak when the flow subsy=
stem is disabled on error, and a missing `PTHREAD_PROCESS_SHARED` attribute=
 on a mutex in shared memory.<br>
<br>
---<br>
<br>
## Patch 1/4: `net/gve: add flow steering device option`<br>
<br>
### Errors<br>
<br>
None.<br>
<br>
### Warnings<br>
<br>
None.<br>
<br>
This patch is clean. The device option parsing follows the established patt=
ern for existing options (modify_ring, jumbo_frames), the byte-swap of `max=
_flow_rules` is correct, and the zero-check on the big-endian value before =
byte-swap is valid (non-zero in any byte order is still non-zero).<br>
<br>
---<br>
<br>
## Patch 2/4: `net/gve: introduce extended adminq command`<br>
<br>
### Errors<br>
<br>
None.<br>
<br>
### Warnings<br>
<br>
None.<br>
<br>
The extended command mechanism is straightforward: allocate DMA memory for =
the inner command, copy the command in, set up the outer wrapper with the D=
MA address, execute, and free. The error path is correct =E2=80=94 `gve_fre=
e_dma_mem` is called after `gve_adminq_execute_cmd` regardless of success o=
r failure.<br>
<br>
---<br>
<br>
## Patch 3/4: `net/gve: add adminq commands for flow steering`<br>
<br>
### Errors<br>
<br>
None.<br>
<br>
### Warnings<br>
<br>
**1. `gve_flow_rule.h` copyright appears to be copied from an Intel driver =
file.**<br>
<br>
```c<br>
/* SPDX-License-Identifier: BSD-3-Clause<br>
=C2=A0* Copyright(C) 2022 Intel Corporation<br>
=C2=A0*/<br>
```<br>
<br>
This is a new file in the Google GVE driver. The Intel copyright and 2022 d=
ate look like they were carried over from whichever file was used as a temp=
late. This should be updated to reflect the actual author.<br>
<br>
---<br>
<br>
## Patch 4/4: `net/gve: add rte flow API integration`<br>
<br>
This is the largest patch (815 lines added) and where the significant findi=
ngs are.<br>
<br>
### Errors<br>
<br>
**1. Resource leak: bitmap memory leaked when flow subsystem is disabled on=
 error.**<br>
<br>
In `gve_flush_flow_rules`, if either `gve_free_flow_rules()` or `gve_flow_i=
nit_bmp()` fails, the code disables the subsystem:<br>
<br>
```c<br>
gve_clear_flow_subsystem_ok(priv);<br>
```<br>
<br>
However, in both `gve_dev_close` and `gve_dev_reset`, teardown is gated on =
the flag:<br>
<br>
```c<br>
if (gve_get_flow_subsystem_ok(priv))<br>
=C2=A0 =C2=A0 gve_teardown_flow_subsystem(priv);<br>
```<br>
<br>
If the subsystem was disabled by a failed flush, `gve_teardown_flow_subsyst=
em` is never called, and `priv-&gt;avail_flow_rule_bmp_mem` is never freed.=
 This is a memory leak.<br>
<br>
**Suggested fix**: Either (a) always call `gve_flow_free_bmp(priv)` in clos=
e/reset regardless of the flag, or (b) have the flush error path free the b=
itmap memory itself, or (c) unconditionally call teardown in close/reset:<b=
r>
<br>
```c<br>
/* In gve_dev_close / gve_dev_reset: */<br>
if (priv-&gt;avail_flow_rule_bmp_mem)<br>
=C2=A0 =C2=A0 gve_teardown_flow_subsystem(priv);<br>
```<br>
<br>
**2. `pthread_mutex_init` without `PTHREAD_PROCESS_SHARED` on a mutex in sh=
ared memory.**<br>
<br>
In `gve_dev_init`:<br>
<br>
```c<br>
pthread_mutex_init(&amp;priv-&gt;flow_rule_lock, NULL);<br>
```<br>
<br>
`priv` is `dev-&gt;data-&gt;dev_private`, which is allocated in DPDK shared=
 memory accessible by both primary and secondary processes. A pthread mutex=
 in shared memory initialized with `NULL` attributes has undefined behavior=
 when used across processes. It may appear to work in testing but fail in p=
roduction with secondary processes.<br>
<br>
**Suggested fix**: Either use `PTHREAD_PROCESS_SHARED`:<br>
<br>
```c<br>
pthread_mutexattr_t attr;<br>
pthread_mutexattr_init(&amp;attr);<br>
pthread_mutexattr_setpshared(&amp;attr, PTHREAD_PROCESS_SHARED);<br>
pthread_mutex_init(&amp;priv-&gt;flow_rule_lock, &amp;attr);<br>
pthread_mutexattr_destroy(&amp;attr);<br>
```<br>
<br>
Or switch to `rte_spinlock_t` which works correctly in shared memory withou=
t special initialization (appropriate here since the critical sections are =
short =E2=80=94 bitmap scan, TAILQ insert/remove):<br>
<br>
```c<br>
rte_spinlock_t flow_rule_lock;<br>
/* ... */<br>
rte_spinlock_init(&amp;priv-&gt;flow_rule_lock);<br>
```<br>
<br>
### Warnings<br>
<br>
**3. Implicit pointer comparisons throughout `gve_flow_rule.c`.**<br>
<br>
Several places use `!pointer` instead of `pointer =3D=3D NULL`:<br>
<br>
```c<br>
if (!flow) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* line ~1641, ~1710 */<br>
if (!action-&gt;conf) {=C2=A0 /* line ~1510 */<br>
if (!attr) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* line ~1173 */<br>
if (!actions) {=C2=A0 =C2=A0 =C2=A0 =C2=A0/* line ~1498 */<br>
if (!pattern) {=C2=A0 =C2=A0 =C2=A0 =C2=A0/* line ~1329 */<br>
```<br>
<br>
DPDK coding style requires explicit comparison with NULL for pointers. The =
idiomatic form is `if (flow =3D=3D NULL)`.<br>
<br>
**4. `rte_zmalloc` used for flow rule metadata that does not require hugepa=
ge memory.**<br>
<br>
The `gve_flow` structs (8 bytes: a `uint32_t` + TAILQ pointers) are allocat=
ed via `rte_zmalloc`. These are small control-plane structures not accessed=
 by DMA and not requiring NUMA placement. Standard `malloc` would be more a=
ppropriate per DPDK guidelines and would not consume limited hugepage resou=
rces.<br>
<br>
Similarly, `priv-&gt;avail_flow_rule_bmp_mem` is allocated with `rte_zmallo=
c`. Since `rte_bitmap` may require specific alignment, this one is more def=
ensible, but worth considering whether standard allocation would suffice.<b=
r>
<br>
**5. Standalone `rte_atomic_thread_fence()` in flow subsystem flag accessor=
s.**<br>
<br>
The `gve_get_flow_subsystem_ok` / `gve_set_flow_subsystem_ok` / `gve_clear_=
flow_subsystem_ok` functions use standalone fences with `rte_bit_relaxed_*`=
 operations:<br>
<br>
```c<br>
static inline bool<br>
gve_get_flow_subsystem_ok(struct gve_priv *priv)<br>
{<br>
=C2=A0 =C2=A0 bool ret;<br>
=C2=A0 =C2=A0 ret =3D !!rte_bit_relaxed_get32(GVE_PRIV_FLAGS_FLOW_SUBSYSTEM=
_OK,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;priv-&gt;state_flags);<b=
r>
=C2=A0 =C2=A0 rte_atomic_thread_fence(rte_memory_order_acquire);<br>
=C2=A0 =C2=A0 return ret;<br>
}<br>
```<br>
<br>
These follow the existing pattern for other state flags in the driver, so t=
his is consistent. However, it&#39;s worth noting that in every call site i=
n this patch, the flag is checked while holding `flow_rule_lock`, which alr=
eady provides the necessary memory ordering. The fences are redundant in th=
ose paths (but harmless).<br>
<br>
**6. RST documentation uses simple bullet lists where definition lists woul=
d be cleaner.**<br>
<br>
In `doc/guides/nics/gve.rst`:<br>
<br>
```rst<br>
Supported Patterns:<br>
=C2=A0 - IPv4/IPv6 source and destination addresses.<br>
=C2=A0 - TCP/UDP/SCTP source and destination ports.<br>
=C2=A0 - ESP/AH SPI.<br>
```<br>
<br>
These term+list groupings would read better as RST definition lists. This i=
s minor given the lists are short.<br>
<br>
### Design Notes (Info)<br>
<br>
**Well-structured error handling in `gve_create_flow_rule`**: The allocatio=
n-before-lock pattern avoids holding the mutex during memory allocation, an=
d the `free_flow_and_unlock` goto label correctly handles all error paths. =
The bitmap-set-on-error rollback in the adminq failure case is also correct=
.<br>
<br>
**`gve_destroy_flow_rule` double-validates flow state**: The function check=
s both the flow pointer for NULL and verifies `rule_id &lt; max_flow_rules`=
 before checking the bitmap. This defense-in-depth is good practice.<br>
<br>
**IPv6 word-reversal in `gve_parse_ipv6`**: The comment explaining the devi=
ce&#39;s expected word order is clear and the implementation correctly reve=
rses the 32-bit words. This is the kind of hardware-specific detail that be=
nefits from the inline comment.<br>
<br>
---<br>
<br>
## Cross-Patch Observations<br>
<br>
The series is well-ordered: each patch builds incrementally and the depende=
ncies flow naturally (device option =E2=86=92 extended command infrastructu=
re =E2=86=92 flow rule commands =E2=86=92 rte_flow integration). The docume=
ntation, feature matrix, and release notes are all updated in patch 4/4 tog=
ether with the code, which is correct per DPDK guidelines.<br>
<br>
The `Co-developed-by` / `Signed-off-by` tag sequences are correctly formatt=
ed per Linux kernel convention.<br>
</blockquote></div>

--0000000000003fcf4e064c143d2d--
