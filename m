Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A48A104891F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 22:52:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4139C4060F;
	Fri, 27 Feb 2026 23:52:39 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3AA4E402C6
 for <dev@dpdk.org>; Fri, 27 Feb 2026 23:52:37 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cbc593a67aso195838585a.2
 for <dev@dpdk.org>; Fri, 27 Feb 2026 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772232756;
 x=1772837556; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrDzXY2m2uMH70d/6UC1cIIBwGVmF01mE9/XPkVo1Cc=;
 b=APmXz1Xidw/Wm0tJEF+ISnrqhZyKZkX8cPMIHr/URPK6MVJgbXE7N8lU26/08GVkVO
 fIMIVsEcnf5josYEnUCOGNS23qnOLUTh297myjf3++PGgQZE5b80tLR1U6acA9ihXO55
 bzx2j289qDz1rhcUJlUNEIJc0gt+QHN1JqzjUypDmLcTkiwZCTkaSZYnum3h2u2tra1L
 yeQmXQVQ5y6SAfq42eWLbTSalMwl1fl6nT51s2xYjwJ4E1kYA0Fj4Wf8P3liIlLbUUMP
 tP8c5mQn2FRtBqfsSXNacJ3sovcXsIZCQUiZbpo2LO1nYag9uUmVqFJPbGu2HW0B3ReQ
 dcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232756; x=1772837556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CrDzXY2m2uMH70d/6UC1cIIBwGVmF01mE9/XPkVo1Cc=;
 b=WsWsiBnGND+6ncNFAelH5h4nvCEcanXHq0mMrEDNpLclu4qw5Kmw4Y1rCc5hmWE12Q
 FgIUEf6euz7ygj1VuMYFlzYBu7+IS7ohRX184eUCgkEXXAaDZILdfAJaX+3oTu6rDpDI
 PJBTgwLAJHWNN+QcfzuyQGiULJGx8mhINguO4+/bpMo7opej3oAV8vXMPGysMw0dr7nn
 T5cWq93ufeqpbpMsGXWk5Ts79LWiKygHSpZMW1bQAyEzlkCWPEeofhRGwiOcrOZAePFf
 fVNLMwWyg0nTCaH6kTJY2SqMH6K/4JDT4Rq57ef1ODkYKtat3evqxTe5XewKr0KeHVAU
 GHpA==
X-Gm-Message-State: AOJu0Yz2wwvqunJgeCarE68TwpziCbhTY8NzIjVh67EoWEsuBPVQRwqH
 iHwoRZC8oboDqQSCIiQ3JGb6uYG++Ac6WPtIZ+0T0unBZnRGz+AvBrZsYmf6LLIlxhw=
X-Gm-Gg: ATEYQzwEB+LbNyL3/HCR5UVboxwUUfZIp7gnnuRNxET3Hl2yID5+QAVYuzn6+hvFY9G
 E0ybNIHwSBFPfbv7nWL9NjBa/ghNhULdvGVsS6g2xlKTlfWLzUlfuP7AyCILlfRUQ/R/xQ3Y2j/
 6T9is2qhLNE70xd4VcFpi8/W55ee29/Be7u2RQCObFfLPhNO740zFXJfwrS4z2VdMMscvh5NTSa
 sa54i5YzdTb1TULwxXp7SJSeoWxxDBNssleplq528fhhn4lIxdRVDhzFmhUO1EnUAgpj+yDGrX8
 Yh92+ku9Zdf+LyQwGga+grDahH85ZGIXgf4flkaSiyPnnBPr75T4nC4gA2Y57k9++ohFfQQqyUe
 imcFyYwelvyXIi+IJCSf27l32Q+pvmS3MA5VOxcRbpl2lzVllM6qqkY88rQA+Ce8cDR5n9BJvRR
 V/M05uDPMHddYxbQrHvfzvN+BneLqiPnPiMTVGw4swM/4RNzzLh6Fbi3Uqpm0nSBx0
X-Received: by 2002:a05:620a:4511:b0:8c6:b19a:5a46 with SMTP id
 af79cd13be357-8cbc8df6f03mr586264785a.47.1772232756396; 
 Fri, 27 Feb 2026 14:52:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf658f70sm562939085a.7.2026.02.27.14.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 14:52:36 -0800 (PST)
Date: Fri, 27 Feb 2026 14:52:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/gve: add flow steering support
Message-ID: <20260227145233.002b87e1@phoenix.local>
In-Reply-To: <20260227195126.3545607-1-jtranoleary@google.com>
References: <20260227195126.3545607-1-jtranoleary@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 27 Feb 2026 19:51:22 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> This patch series adds flow steering support to the Google Virtual
> Ethernet (gve) driver. This functionality allows traffic to be directed
> to specific receive queues based on user-specified flow patterns.
>=20
> The series includes foundational support for extended admin queue
> commands needed to handle flow rules, the specific adminqueue commands
> for flow rule management, and the integration with the DPDK rte_flow
> API. The series adds support flow matching on the following protocols:
> IPv4, IPv6, TCP, UDP, SCTP, ESP, and AH.
>=20
> Patch Overview:
>=20
> 1. "net/gve: add flow steering device option" checks for and enables
>    the flow steering capability in the device options during
>    initialization.
> 2. "net/gve: introduce extended adminq command" adds infrastructure
>    for sending extended admin queue commands. These commands use a
>    flexible buffer descriptor format required for flow rule management.
> 3. "net/gve: add adminq commands for flow steering" implements the
>    specific admin queue commands to add and remove flow rules on the
>    device, including handling of rule IDs and parameters.
> 4. "net/gve: add rte flow API integration" exposes the flow steering
>    functionality via the DPDK rte_flow API. This includes strict
>    pattern validation, rule parsing, and lifecycle management (create,
>    destroy, flush). It ensures thread-safe access to the flow subsystem
>    and proper resource cleanup during device reset.
>=20
> Jasper Tran O'Leary (2):
>   net/gve: add adminq commands for flow steering
>   net/gve: add rte flow API integration
>=20
> Vee Agarwal (2):
>   net/gve: add flow steering device option
>   net/gve: introduce extended adminq command
>=20
>  doc/guides/nics/features/gve.ini       |  12 +
>  doc/guides/nics/gve.rst                |  20 +
>  doc/guides/rel_notes/release_26_03.rst |   1 +
>  drivers/net/gve/base/gve.h             |   3 +-
>  drivers/net/gve/base/gve_adminq.c      | 118 ++++-
>  drivers/net/gve/base/gve_adminq.h      |  57 +++
>  drivers/net/gve/gve_ethdev.c           |  87 +++-
>  drivers/net/gve/gve_ethdev.h           |  46 ++
>  drivers/net/gve/gve_flow_rule.c        | 645 +++++++++++++++++++++++++
>  drivers/net/gve/gve_flow_rule.h        |  64 +++
>  drivers/net/gve/meson.build            |   1 +
>  11 files changed, 1049 insertions(+), 5 deletions(-)
>  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c
>  create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h
>=20

There is a lot here, so sent AI to take a look.

Summary:
Error 1 =E2=80=94 Resource leak: If gve_flush_flow_rules fails and disables=
 the
flow subsystem via gve_clear_flow_subsystem_ok(), the bitmap memory
(avail_flow_rule_bmp_mem) is never freed because both gve_dev_close and
gve_dev_reset gate their teardown on gve_get_flow_subsystem_ok()
returning true. The guard needs to check for allocated memory rather
than subsystem state.

Error 2 =E2=80=94 pthread_mutex_init with NULL attributes in shared memory:=
 The
flow_rule_lock lives in dev_private (DPDK shared memory) but is
initialized without PTHREAD_PROCESS_SHARED. This will cause undefined
behavior with secondary processes. Switching to rte_spinlock_t would be
the simplest fix since the critical sections are short (bitmap scan +
TAILQ operations).

Patches 1=E2=80=933 are clean. The overall structure and error handling in =
patch 4 is solid =E2=80=94 the allocation-before-lock pattern, bitmap rollb=
ack on adminq failure, and defense-in-depth validation in destroy are all w=
ell done.
Long form:
# Code Review: GVE Flow Steering Patch Series (4 patches)

**Series**: `[PATCH 1/4]` through `[PATCH 4/4]`
**Author**: Jasper Tran O'Leary / Vee Agarwal (Google)
**Subject**: Add receive flow steering (RFS) support to the GVE driver

---

## Summary

This series adds n-tuple flow steering to the GVE (Google Virtual Ethernet)=
 driver via the `rte_flow` API. The implementation is cleanly structured ac=
ross four patches: device option discovery (1/4), extended adminq infrastru=
cture (2/4), flow rule adminq commands (3/4), and full rte_flow integration=
 (4/4). The code quality is generally good with thorough validation, proper=
 locking, and well-structured error handling.

Two correctness issues were identified: a resource leak when the flow subsy=
stem is disabled on error, and a missing `PTHREAD_PROCESS_SHARED` attribute=
 on a mutex in shared memory.

---

## Patch 1/4: `net/gve: add flow steering device option`

### Errors

None.

### Warnings

None.

This patch is clean. The device option parsing follows the established patt=
ern for existing options (modify_ring, jumbo_frames), the byte-swap of `max=
_flow_rules` is correct, and the zero-check on the big-endian value before =
byte-swap is valid (non-zero in any byte order is still non-zero).

---

## Patch 2/4: `net/gve: introduce extended adminq command`

### Errors

None.

### Warnings

None.

The extended command mechanism is straightforward: allocate DMA memory for =
the inner command, copy the command in, set up the outer wrapper with the D=
MA address, execute, and free. The error path is correct =E2=80=94 `gve_fre=
e_dma_mem` is called after `gve_adminq_execute_cmd` regardless of success o=
r failure.

---

## Patch 3/4: `net/gve: add adminq commands for flow steering`

### Errors

None.

### Warnings

**1. `gve_flow_rule.h` copyright appears to be copied from an Intel driver =
file.**

```c
/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(C) 2022 Intel Corporation
 */
```

This is a new file in the Google GVE driver. The Intel copyright and 2022 d=
ate look like they were carried over from whichever file was used as a temp=
late. This should be updated to reflect the actual author.

---

## Patch 4/4: `net/gve: add rte flow API integration`

This is the largest patch (815 lines added) and where the significant findi=
ngs are.

### Errors

**1. Resource leak: bitmap memory leaked when flow subsystem is disabled on=
 error.**

In `gve_flush_flow_rules`, if either `gve_free_flow_rules()` or `gve_flow_i=
nit_bmp()` fails, the code disables the subsystem:

```c
gve_clear_flow_subsystem_ok(priv);
```

However, in both `gve_dev_close` and `gve_dev_reset`, teardown is gated on =
the flag:

```c
if (gve_get_flow_subsystem_ok(priv))
    gve_teardown_flow_subsystem(priv);
```

If the subsystem was disabled by a failed flush, `gve_teardown_flow_subsyst=
em` is never called, and `priv->avail_flow_rule_bmp_mem` is never freed. Th=
is is a memory leak.

**Suggested fix**: Either (a) always call `gve_flow_free_bmp(priv)` in clos=
e/reset regardless of the flag, or (b) have the flush error path free the b=
itmap memory itself, or (c) unconditionally call teardown in close/reset:

```c
/* In gve_dev_close / gve_dev_reset: */
if (priv->avail_flow_rule_bmp_mem)
    gve_teardown_flow_subsystem(priv);
```

**2. `pthread_mutex_init` without `PTHREAD_PROCESS_SHARED` on a mutex in sh=
ared memory.**

In `gve_dev_init`:

```c
pthread_mutex_init(&priv->flow_rule_lock, NULL);
```

`priv` is `dev->data->dev_private`, which is allocated in DPDK shared memor=
y accessible by both primary and secondary processes. A pthread mutex in sh=
ared memory initialized with `NULL` attributes has undefined behavior when =
used across processes. It may appear to work in testing but fail in product=
ion with secondary processes.

**Suggested fix**: Either use `PTHREAD_PROCESS_SHARED`:

```c
pthread_mutexattr_t attr;
pthread_mutexattr_init(&attr);
pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
pthread_mutex_init(&priv->flow_rule_lock, &attr);
pthread_mutexattr_destroy(&attr);
```

Or switch to `rte_spinlock_t` which works correctly in shared memory withou=
t special initialization (appropriate here since the critical sections are =
short =E2=80=94 bitmap scan, TAILQ insert/remove):

```c
rte_spinlock_t flow_rule_lock;
/* ... */
rte_spinlock_init(&priv->flow_rule_lock);
```

### Warnings

**3. Implicit pointer comparisons throughout `gve_flow_rule.c`.**

Several places use `!pointer` instead of `pointer =3D=3D NULL`:

```c
if (!flow) {          /* line ~1641, ~1710 */
if (!action->conf) {  /* line ~1510 */
if (!attr) {          /* line ~1173 */
if (!actions) {       /* line ~1498 */
if (!pattern) {       /* line ~1329 */
```

DPDK coding style requires explicit comparison with NULL for pointers. The =
idiomatic form is `if (flow =3D=3D NULL)`.

**4. `rte_zmalloc` used for flow rule metadata that does not require hugepa=
ge memory.**

The `gve_flow` structs (8 bytes: a `uint32_t` + TAILQ pointers) are allocat=
ed via `rte_zmalloc`. These are small control-plane structures not accessed=
 by DMA and not requiring NUMA placement. Standard `malloc` would be more a=
ppropriate per DPDK guidelines and would not consume limited hugepage resou=
rces.

Similarly, `priv->avail_flow_rule_bmp_mem` is allocated with `rte_zmalloc`.=
 Since `rte_bitmap` may require specific alignment, this one is more defens=
ible, but worth considering whether standard allocation would suffice.

**5. Standalone `rte_atomic_thread_fence()` in flow subsystem flag accessor=
s.**

The `gve_get_flow_subsystem_ok` / `gve_set_flow_subsystem_ok` / `gve_clear_=
flow_subsystem_ok` functions use standalone fences with `rte_bit_relaxed_*`=
 operations:

```c
static inline bool
gve_get_flow_subsystem_ok(struct gve_priv *priv)
{
    bool ret;
    ret =3D !!rte_bit_relaxed_get32(GVE_PRIV_FLAGS_FLOW_SUBSYSTEM_OK,
                                  &priv->state_flags);
    rte_atomic_thread_fence(rte_memory_order_acquire);
    return ret;
}
```

These follow the existing pattern for other state flags in the driver, so t=
his is consistent. However, it's worth noting that in every call site in th=
is patch, the flag is checked while holding `flow_rule_lock`, which already=
 provides the necessary memory ordering. The fences are redundant in those =
paths (but harmless).

**6. RST documentation uses simple bullet lists where definition lists woul=
d be cleaner.**

In `doc/guides/nics/gve.rst`:

```rst
Supported Patterns:
  - IPv4/IPv6 source and destination addresses.
  - TCP/UDP/SCTP source and destination ports.
  - ESP/AH SPI.
```

These term+list groupings would read better as RST definition lists. This i=
s minor given the lists are short.

### Design Notes (Info)

**Well-structured error handling in `gve_create_flow_rule`**: The allocatio=
n-before-lock pattern avoids holding the mutex during memory allocation, an=
d the `free_flow_and_unlock` goto label correctly handles all error paths. =
The bitmap-set-on-error rollback in the adminq failure case is also correct.

**`gve_destroy_flow_rule` double-validates flow state**: The function check=
s both the flow pointer for NULL and verifies `rule_id < max_flow_rules` be=
fore checking the bitmap. This defense-in-depth is good practice.

**IPv6 word-reversal in `gve_parse_ipv6`**: The comment explaining the devi=
ce's expected word order is clear and the implementation correctly reverses=
 the 32-bit words. This is the kind of hardware-specific detail that benefi=
ts from the inline comment.

---

## Cross-Patch Observations

The series is well-ordered: each patch builds incrementally and the depende=
ncies flow naturally (device option =E2=86=92 extended command infrastructu=
re =E2=86=92 flow rule commands =E2=86=92 rte_flow integration). The docume=
ntation, feature matrix, and release notes are all updated in patch 4/4 tog=
ether with the code, which is correct per DPDK guidelines.

The `Co-developed-by` / `Signed-off-by` tag sequences are correctly formatt=
ed per Linux kernel convention.
