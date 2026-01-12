Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22388D25031
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 00:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00C474028F;
	Mon, 12 Jan 2026 01:50:26 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 611DD4013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 01:50:24 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so4355653f8f.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768179024;
 x=1768783824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=20+YnTL1ebLd+8fEdZxqhrIczvYzQE0zWivVAd4avhI=;
 b=KUBSL2dsLY4O5XXhfcNGS0XstJlP2SIHMV3R7HocW6ijJBzQsMFuHwROUV3guIiwm1
 +3hWtY/nWWrn/J+6kP6yFaY2TsdU7NtjLj5Sw4N66XIbxMQXTslz6gGXis0lfH9glVFb
 MkopJsRrX36agMS15RAfg9VCujG/O4zqCtKO+av4Zn2rcsEa+jgvanTxjsGyyrSKTGNw
 iilhbELcCTmxObuUqIDwR/9jO4pb1CmHKeMIchmuVSGAxx5WrFob47LjvGSF/PJXwexz
 wdwznrzC39VBLVaZyGwnaoSVn3+xEFpdoMXn+x35hCsJSoCkogVO0u13gDC8UesuzdOY
 qo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768179024; x=1768783824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=20+YnTL1ebLd+8fEdZxqhrIczvYzQE0zWivVAd4avhI=;
 b=H+qm3ZlRcTzqp9UBOZdI4RBk2wyN5BX9C7QCT17uKQoaUg51VW+19IqQTz8o1NGD/b
 RfLBcl1bJbkdiWyljYtxK0opvKh1Qdkk58BJ4rACA3N+4OQg9UKBo1J3VUA0OfL5nF1c
 eJiJCwbeWodV2o45B2QojENw9wnPnltZ0PygRmbtRquU1WwcqhcSBO3mbncFly697JQT
 eSOg1TfMLzAX9xGXm/cBR9fp7BX6l5zOdlh78v0X85cOCodu+G3bCSiZXC809ucAvsiw
 ym4kTa7eP5CkvSZ0VmTSRtoOdReTHIITUpVKZgxfBNjFxDc3kdfUiNyvSitSaob/HP3V
 Pn2Q==
X-Gm-Message-State: AOJu0YxJI75tWmwZtWdph3iXdkINZAQ/klpUonin0tO2zUwSMSds9q8U
 LNfvbhcwdq/wpZYBd+HF9n+uY9hXegM4fvLJvAToEgh/yBxZISJAWWrUfnS9iKZ3Gvcq7/yKHeX
 xrLW5
X-Gm-Gg: AY/fxX6iyv7XgUBqrEQI1vtGh3TKu89IsxjhiA7dxMhNCD3y+xNslpyKQatXXXGidB6
 w47CUNmQStTqs3Cg2qo5AjbX8tQOU3E7lxCf3EmPm1E7XbJX7FWNYHM0PjACJtu0HI09coAb8Le
 0el6tBCRNXh/9GDxvUfFcnn96k7xuAPreG/rwHZu5BIeHP4sxBDvmgUiysLXbKvELtV5T8SweER
 Agt5PCtkLmY7MA40mbJf3hTyTrkY5T1o4QOXV0GAjp1O2DYTe7oIH9cLOsYcsZ/ZpwDGJAbRinQ
 iREM/QOm07lHK+wOmSSsvIUs6D4uAFAZUgE1a7WCdHbxTKEONS8DL9QHBwsW+4mPets6U3IaIjY
 AgxSPTNMRktfzjPCMXC+S4zLK2AQJQA2icNgFGboF2BmXAdpcShx4yNkzMSb/qKfMO5CEUT0gZ5
 /d3FbG3982gs/eYH8QQfsjvswI/p1lyDzaFQWVHnUDzX9W5Fy6ZuUl
X-Google-Smtp-Source: AGHT+IEhZdd7uZ0r9VMWQVuhsP5fQE/JLfNzhuaSXBCwQAWa2p5KG1HAEzkFuCnItYSFp7DiJbAP7w==
X-Received: by 2002:a05:6000:208a:b0:42b:55a1:214f with SMTP id
 ffacd0b85a97d-432c3760cc9mr19352328f8f.21.1768179023340; 
 Sun, 11 Jan 2026 16:50:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm36133309f8f.19.2026.01.11.16.50.22
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 16:50:23 -0800 (PST)
Date: Sun, 11 Jan 2026 16:50:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v2 0/9] pcap: cleanup pcap PMD and add test
Message-ID: <20260111165018.1f4ced3d@phoenix.local>
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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

On Thu,  8 Jan 2026 17:16:17 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> This is a set of enhancements and tests to the PCAP PMD.
> It started out when looking at the handling of timestamps
> then realized lots of other cleanups were needed here.
>=20
> v2 - review feedback
>    - consolidate patches
>=20
> Stephen Hemminger (9):
>   net/pcap: avoid using rte_malloc and rte_memcpy
>   net/pcap: support MTU set
>   net/pcap: use bool for flags
>   net/pcap: support Tx offloads
>   net/pcap: support nanosecond timestamp precision
>   net/pcap: remove global variables
>   net/pcap: avoid use of volatile
>   net/pcap: support MAC address set
>   test: add test for pcap PMD
>=20
>  app/test/meson.build                  |    2 +
>  app/test/test_pmd_pcap.c              | 1846 +++++++++++++++++++++++++
>  drivers/net/pcap/pcap_ethdev.c        |  353 +++--
>  drivers/net/pcap/pcap_osdep.h         |    2 +
>  drivers/net/pcap/pcap_osdep_freebsd.c |   60 +-
>  drivers/net/pcap/pcap_osdep_linux.c   |   51 +-
>  drivers/net/pcap/pcap_osdep_windows.c |    5 +
>  7 files changed, 2184 insertions(+), 135 deletions(-)
>  create mode 100644 app/test/test_pmd_pcap.c
>=20

Results of AI review with AGENTS.md are:


I'll start by reading the AGENTS.md file to understand the review criteria,=
 then examine the patch bundle.Let me view the middle sections of the patch=
 bundle to see all patches:Now I have a comprehensive view of the patch ser=
ies. Let me provide the review based on the AGENTS.md criteria:

---

## DPDK Patch Review: net/pcap Driver Changes (v2, 9 patches)

### Patch Series Overview

| # | Subject | Status |
|---|---------|--------|
| 1/9 | net/pcap: avoid using rte_malloc and rte_memcpy | =E2=9C=85 Clean |
| 2/9 | net/pcap: support MTU set | =E2=9A=A0=EF=B8=8F Minor issues |
| 3/9 | net/pcap: use bool for flags | =E2=9C=85 Clean |
| 4/9 | net/pcap: add VLAN insert offload | =E2=9C=85 Clean |
| 5/9 | net/pcap: support nanosecond timestamp precision | =E2=9C=85 Clean |
| 6/9 | net/pcap: localize variables | =E2=9C=85 Clean |
| 7/9 | net/pcap: avoid use of volatile | =E2=9C=85 Clean |
| 8/9 | net/pcap: support MAC address set | =E2=9A=A0=EF=B8=8F Minor issues=
 |
| 9/9 | test: add test for pcap PMD | =E2=9A=A0=EF=B8=8F Warnings |

---

### Detailed Review

#### **Patch 1/9: net/pcap: avoid using rte_malloc and rte_memcpy**

**Commit Message**: =E2=9C=85 Pass
- Subject line: 49 chars (=E2=89=A460 =E2=9C=93)
- Correct component prefix `net/pcap:`
- Imperative mood, lowercase, no trailing period
- Signed-off-by present

**Code Changes**: =E2=9C=85 Pass
- Simple, correct replacement of `rte_malloc`/`rte_free` with standard `mal=
loc`/`free`
- Removes unnecessary includes `<rte_malloc.h>` and `<rte_memcpy.h>`
- Appropriate for FreeBSD osdep code that doesn't need hugepage allocations

---

#### **Patch 2/9: net/pcap: support MTU set**

**Commit Message**: =E2=9C=85 Pass

**Code Review**: =E2=9A=A0=EF=B8=8F Warnings

1. **FreeBSD duplicate check** (line 489-491):
   ```c
   int s =3D socket(AF_INET, SOCK_DGRAM, 0);
   if (s < 0)
       return -errno;

   struct ifreq ifr =3D { 0 };
   if (s < 0)     // <-- Dead code: already checked above
       return -EINVAL;
   ```
   This is dead code - `s < 0` was already handled above. Remove the second=
 check.

2. **Double blank line** (lines 1009-1010): Style issue - extra blank line =
before `static const struct eth_dev_ops ops`.

3. **Warning (should fix)**: The FreeBSD `osdep_iface_mtu_set` function doe=
s not close the socket on all error paths before the duplicate check.

---

#### **Patch 3/9: net/pcap: use bool for flags**

**Commit Message**: =E2=9C=85 Pass

**Code Changes**: =E2=9C=85 Pass
- Good cleanup converting `unsigned int` and `int` flags to `bool`
- Adds `<stdbool.h>` header appropriately
- Consolidates `select_phy_mac` and `get_infinite_rx_arg` into unified `pro=
cess_bool_flag`
- Using `bool` for flags follows DPDK guidelines

---

#### **Patch 4/9: net/pcap: add VLAN insert offload**

**Commit Message**: =E2=9C=85 Pass

**Code Changes**: =E2=9C=85 Pass
- Adds `<rte_vlan.h>` header
- Correctly adds VLAN insert capability to both TX paths
- Reports capability in `dev_info->tx_offload_capa`

---

#### **Patch 5/9: net/pcap: support nanosecond timestamp precision**

**Commit Message**: =E2=9C=85 Pass

**Code Changes**: =E2=9C=85 Pass
- Good use of `rte_reciprocal_u64` for efficient division
- Replaces `pcap_open_live` with `pcap_create`/`pcap_activate` pattern for =
more control
- Uses `pcap_open_offline_with_tstamp_precision` for nanosecond precision
- Adds `read_clock` op for timestamp synchronization
- Makes timestamp offloading configurable via `rxmode.offloads`

**Info**: Nice optimization using `rte_reciprocal_divide_u64` to avoid expe=
nsive division operations in the fast path.

---

#### **Patch 6/9: net/pcap: localize variables**

**Commit Message**: =E2=9C=85 Pass
- Has `Acked-by:` from reviewer =E2=9C=93

**Code Changes**: =E2=9C=85 Pass
- Moves `errbuf` to function-local scope
- Makes `iface_idx` static within function scope
- Good practice to reduce global state

---

#### **Patch 7/9: net/pcap: avoid use of volatile**

**Commit Message**: =E2=9C=85 Pass

**Code Changes**: =E2=9C=85 Pass
- Removes `volatile` keyword from statistics structures
- Changes `unsigned long` to `uint64_t` for consistency
- Rationale is sound: only one thread operates on a queue at a time in DPDK

---

#### **Patch 8/9: net/pcap: support MAC address set**

**Commit Message**: =E2=9C=85 Pass

**Code Review**: =E2=9A=A0=EF=B8=8F Warnings

1. **Double blank line** (lines 1709-1711): Extra blank line after `eth_dev=
_macaddr_set` function.

2. **Linux code changes** (line 1803-1809): The header reordering is correc=
t:
   ```c
   #include <string.h>
   #include <stdint.h>
   #include <unistd.h>
   #include <errno.h>
   #include <net/if.h>
   #include <net/if_arp.h>
   ```
   This follows proper include ordering (system headers first).

---

#### **Patch 9/9: test: add test for pcap PMD**

**Commit Message**: =E2=9C=85 Pass
- Subject `test:` prefix is correct for app/test

**Code Review**: =E2=9A=A0=EF=B8=8F Warnings

1. **SPDX/Copyright**: =E2=9C=85 Correct format:
   ```c
   /* SPDX-License-Identifier: BSD-3-Clause
    * Copyright(c) 2026 Stephen Hemminger
    */
   ```

2. **Include order issue** (lines 1977-1997): The `"test.h"` and `"packet_b=
urst_generator.h"` should come **after** system and DPDK includes, not befo=
re. The correct order per AGENTS.md is:
   - System/libc includes
   - DPDK EAL includes
   - DPDK misc library includes
   - Application-specific includes

   **Should be:**
   ```c
   #include <stdio.h>
   #include <stdlib.h>
   ...
   #include <rte_ethdev.h>
   ...
   #include "test.h"
   #include "packet_burst_generator.h"
   ```

3. **Meson.build style** (line 1955):
   ```python
   'test_pmd_pcap.c': ['net_pcap', 'ethdev',  'bus_vdev']  + packet_burst_g=
enerator_deps,
   ```
   Double space after `'ethdev',` - should be single space.

4. **Test registration** (line 3818): Uses `REGISTER_FAST_TEST` which is co=
rrect for the test framework.

5. **Line length**: All checked lines are within the 100-char limit =E2=9C=
=93

---

### Summary

| Severity | Count | Issues |
|----------|-------|--------|
| **Error** | 0 | None |
| **Warning** | 4 | Dead code in FreeBSD MTU (2/9), double blank lines (2/9=
, 8/9), include order in test (9/9), meson spacing (9/9) |
| **Info** | 1 | Good use of reciprocal divide optimization (5/9) |

### Recommendations

1. **Patch 2/9**: Remove the dead code check `if (s < 0)` on line 490 of `p=
cap_osdep_freebsd.c`

2. **Patch 2/9, 8/9**: Remove extra blank lines to maintain single blank li=
ne between functions

3. **Patch 9/9**: Reorder includes in `test_pmd_pcap.c` to place `"test.h"`=
 and `"packet_burst_generator.h"` after DPDK includes

4. **Patch 9/9**: Fix double space in `meson.build`

Overall, this is a well-structured patch series with good separation of con=
cerns. The issues are minor style/cleanup items that don't affect functiona=
lity.
