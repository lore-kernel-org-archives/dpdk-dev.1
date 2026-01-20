Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D89AD2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 687B240E3A;
	Tue, 20 Jan 2026 15:56:44 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 34A5840E32
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:56:43 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b86ed375d37so716141566b.3
 for <dev@dpdk.org>; Tue, 20 Jan 2026 06:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768921002;
 x=1769525802; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/D3uSFibFvAo8Gge2OwTQGFbmvLTbLNBEtzh/C8uazY=;
 b=nFYPoh0pkM71TNlwGSndGZ2va+2jIVeb8oWHPejTCLrqzlb7idy0xKT8r4+3DgfkzL
 oiaUleOcyQgF1+t/uuI2T9JgmpQjIzkPFIfLB429u116haaVat9fVybWUNHysVrQG7p3
 GmLrt4yiKKn4jDQuNH0E0ptqJDpEFG2i0Wt4+8Vm8tuBH2ii8XJPJQMcPYmGwksC8mxE
 vpo+pJg0WpbPeVUReXl0mDgUKU96lLGwjismFZWRU2umxZkOBB5mQsfuBKlz+J+VdLvV
 OJdZ8af6KhjpvvgIiOKklq/Zp69i0IMcsV/u6k3klfE6aWCUbiwLNl8m90AUQNiMow9P
 ArJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768921002; x=1769525802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/D3uSFibFvAo8Gge2OwTQGFbmvLTbLNBEtzh/C8uazY=;
 b=bHvU2BKIIYw0Lu3OTGUt+TM+4/wOmeQWs6WwVvw8LqSYu5S1GxaXOekhUMQIIcaUZD
 NoOqgncFhaSas1dt1XhlVdR+R5uzttJUPgTX/pHoe4lc5AodrHV6HdbdykGmMPYUVrZK
 hxMjSkLZ+pmWy83/GHqoDt030U7Oqv3/qITlF4aN1e1hJyEnEsR3J5csKJByrojtMCpE
 dYBJ6V12HYSRi2lUqZoDu+NAzPxKbiNuHcsHVDUJPqHd3tSb1zGb5ZfzKD66iJXlOutj
 Q1wvWkhF0pkdeZGIGqvCJiyBpZqXhWEsRtmy/vTo81kc346JPEL+0SfQlviqoOj1bInN
 HEkw==
X-Gm-Message-State: AOJu0YxNCdC+ebnpJADVhVGedYzjkOXr3cI5j0uZU0xifgN/m8Ufcm/K
 793u9mX9+t+FJxTcSd7Pdpqx8ivxi6ZpzdOoDeYeOeT+nSfjccyE48jgOjjGXjVSwDE=
X-Gm-Gg: AZuq6aKUi+/IlvOcMNYu2f+57t7CelQWaXLqYCwC4Ig4sMPJ2ykvB2mvkHl85FYjX4v
 PnoThhLhj9wJu0bKSwr85eEdE2/6pRTgq2FLGCgmZIFv93m41C/QK5eIO1nyJWU4+d3iDA1O+WT
 AdljJ5UHt5wkcyD0ETVdX7AfnlYckSyosCBWTn33b4dtTjx00aUBl1U3gFhjo2TR9ruXj+eKILo
 os62U1Is59v/4vILBSl2PVrR41ZbSDMjtKVjAtD7ktfse+U9lfXxMl22B5NEVB2OK2PTkJuCnFt
 NQLRQJt0X5x/rRCdy1pPPAcZLzm2585FU5JuapBPxVWDmsI7RCielCGyUNcvvmM/4i8sus50Fae
 FFi6aLPQHAN56hM2UkF6pQhelOvkzzq6VAeCu1x5jUM/0MDlWCoga4XTasF7Zik4QTcCyEfuvEH
 dFduPadP1miDnZF22IXZjrI08b8oHMXw7JprNQHvV1GhaRRut9+y64
X-Received: by 2002:a17:907:60c9:b0:b76:f57f:a2c3 with SMTP id
 a640c23a62f3a-b88003e0b9dmr225639366b.12.1768921002060; 
 Tue, 20 Jan 2026 06:56:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a43679sm1408554066b.70.2026.01.20.06.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:56:41 -0800 (PST)
Date: Tue, 20 Jan 2026 06:56:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, rajesh3.kumar@intel.com,
 aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com
Subject: Re: [PATCH v2 0/4] Enable PTP feature for MEV
Message-ID: <20260120065635.0d1de928@phoenix.local>
In-Reply-To: <20251028060758.233929-1-soumyadeep.hore@intel.com>
References: <20251024120840.420016-5-soumyadeep.hore@intel.com>
 <20251028060758.233929-1-soumyadeep.hore@intel.com>
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

On Tue, 28 Oct 2025 02:07:54 -0400
Soumyadeep Hore <soumyadeep.hore@intel.com> wrote:

> Enabling basic PTP feature in IDPF PMD using virtchnl messages.
>=20
> ---
> v2:
> - Fixed essential checkpatch warnings
> ---
> Milena Olech (1):
>   net/idpf: add a new API for PTP support
>=20
> Soumyadeep Hore (3):
>   net/idpf: add PTP virtchnl2 support
>   net/intel: add support for Precision Time Protocol
>   doc: add PTP IDPF documentation
>=20
>  doc/guides/nics/idpf.rst                      |  16 +
>  drivers/net/intel/common/tx.h                 |   1 +
>  drivers/net/intel/idpf/base/virtchnl2.h       | 324 ++++++---
>  drivers/net/intel/idpf/idpf_common_device.h   |   4 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 186 +++--
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |  10 +
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |  34 +-
>  drivers/net/intel/idpf/idpf_ethdev.c          | 275 ++++++++
>  drivers/net/intel/idpf/idpf_ptp.c             | 646 ++++++++++++++++++
>  drivers/net/intel/idpf/idpf_ptp.h             | 227 ++++++
>  drivers/net/intel/idpf/meson.build            |   1 +
>  11 files changed, 1562 insertions(+), 162 deletions(-)
>  create mode 100644 drivers/net/intel/idpf/idpf_ptp.c
>  create mode 100644 drivers/net/intel/idpf/idpf_ptp.h
>=20

Lots more issues found by automated patch review


## DPDK Patch Review: PTP Support for IDPF Driver (v4)

**Series:** [PATCH v4 1-4/4] PTP support for IDPF =20
**Submitter:** Soumyadeep Hore

---

### Summary

This 4-patch series adds Precision Time Protocol (PTP) support to the IDPF =
driver, including virtchnl2 API definitions, mailbox message handling, time=
sync ethdev operations, and documentation.

---

### Patch 1/4: `net/idpf: add a new API for PTP support`

**Commit Message:**
- =E2=9C=85 Subject line 39 chars (=E2=89=A460)
- =E2=9C=85 Lowercase after colon
- =E2=9C=85 Correct prefix `net/idpf:`
- =E2=9C=85 No trailing period
- =E2=9C=85 Has two Signed-off-by tags in correct order

**Code Issues:**
- =E2=9C=85 This is base code in `drivers/net/intel/idpf/base/` which may u=
se different conventions per AGENTS.md exception for base directories

---

### Patch 2/4: `net/idpf: add PTP virtchnl2 support`

**Commit Message:**
- =E2=9C=85 Subject line 37 chars (=E2=89=A460) =20
- =E2=9C=85 Imperative mood, lowercase, no period
- =E2=9C=85 Has Signed-off-by

**License (SPDX):**
- =E2=9C=85 `idpf_ptp.c` and `idpf_ptp.h` have proper SPDX-License-Identifi=
er: BSD-3-Clause
- =E2=9A=A0=EF=B8=8F **Warning:** Copyright dates `2001-2025` seem incorrec=
t=E2=80=94IDPF is relatively recent technology

**Code Style Issues:**

| Severity | Location | Issue |
|----------|----------|-------|
| Warning | `idpf_ptp.c:762` | Unnecessary initialization: `int err =3D 0;`=
 is assigned before use |
| Warning | `idpf_ptp.c:916,983,1013,1044` | Multiple unnecessary `int err =
=3D 0;` initializations |
| Warning | `idpf_ptp.h:1327` | `#include "rte_time.h"` should be `<rte_tim=
e.h>` for DPDK system headers |
| Warning | `idpf_ptp.h:1340-1388` | Mixed comment styles: some use `/* str=
uct` (missing `@`), others use proper `/**` Doxygen |
| Warning | `idpf_ptp.h:1481-1486` | Bitfield syntax `:2` and `:6` on enum=
=E2=80=94may have portability concerns |
| Warning | Multiple | Implicit NULL comparisons (`if (!ptr)`) instead of e=
xplicit `if (ptr =3D=3D NULL)` |

**Potential Bug:**
```c
// idpf_ptp.c:779-791
recv_ptp_caps_msg =3D rte_zmalloc(NULL, sizeof(struct virtchnl2_ptp_get_cap=
s), 0);
...
recv_ptp_caps_msg =3D (struct virtchnl2_ptp_get_caps *)args.out_buffer;
```
=E2=9A=A0=EF=B8=8F **Memory leak:** The originally allocated `recv_ptp_caps=
_msg` at line 779 is overwritten at line 791, leaking memory. The `free_mem=
` label at line 879 frees `args.out_buffer`, not the original allocation.

---

### Patch 3/4: `net/intel: add support for Precision Time Protocol`

**Commit Message:**
- =E2=9A=A0=EF=B8=8F **Warning:** Subject uses "Precision Time Protocol" =
=E2=80=94 should be lowercase `precision time protocol` or abbreviated as `=
PTP` per case sensitivity rules
- =E2=9A=A0=EF=B8=8F **Warning:** Prefix `net/intel:` is generic=E2=80=94th=
e changes are specifically in `idpf`, not all Intel drivers
- =E2=9C=85 Has Signed-off-by

**Code Style Issues:**

| Severity | Location | Issue |
|----------|----------|-------|
| Error | `idpf_ethdev.c:2983` | `#include <math.h>` and use of `log2()` fu=
nction=E2=80=94requires libm linkage, non-standard for DPDK |
| Error | `idpf_ethdev.c:2181` | `log2(incval) + log2(ppm)` =E2=80=94 shoul=
d use DPDK's `rte_log2_u64()` or similar |
| Warning | `idpf_ptp.h:1524` | Indentation uses spaces instead of tabs (ha=
rd tabs required per AGENTS.md) |
| Warning | `idpf_common_rxtx.c:1201-1202` | Poor alignment and excessive w=
hitespace in assignment |
| Warning | `idpf_ethdev.c:2007,2217,2233` | Unnecessary `int ret =3D 0;` i=
nitializations |
| Warning | `idpf_ethdev.c:2066-2075` | Control flow issue: success path fa=
lls through to `err_ptp:` label |
| Warning | `idpf_ethdev.c:2097-2098` | Inconsistent parameter alignment in=
 function signature |
| Info | `idpf_common_rxtx.h:1954-1958` | `FIELD_PREP` macro=E2=80=94consid=
er if this should be shared or already exists in DPDK |

**Functional Concerns:**

1. **Scope:** Patch modifies `drivers/net/intel/common/tx.h` adding `latch_=
idx` to `ci_tx_queue`=E2=80=94this affects the common Intel driver structur=
e, not just IDPF.

2. **Error handling in `idpf_timesync_enable()`:**
   ```c
   err_ptp:
       if (ret !=3D 0) {
           rte_free(adapter->ptp);
           adapter->ptp =3D NULL;
       }
       return ret;
   ```
   On success, control still reaches this label but doesn't clean up partia=
l state if later operations fail.

3. **Division in hot path:** Lines 1733, 1839, 1889 compute `rte_get_timer_=
cycles() / (rte_get_timer_hz() / 1000)` in the receive path=E2=80=94this di=
vision could be precomputed.

---

### Patch 4/4: `doc: add PTP IDPF documentation`

**Commit Message:**
- =E2=9A=A0=EF=B8=8F **Error:** Body starts with "Updated" (past tense)=E2=
=80=94should use imperative mood: "Update"
- =E2=9A=A0=EF=B8=8F **Warning:** Prefix `doc:` is too generic=E2=80=94shou=
ld be `doc/guides/nics:` or similar
- =E2=9C=85 Subject line 32 chars (=E2=89=A460)
- =E2=9C=85 Has Signed-off-by

**Documentation Completeness:**
- =E2=9D=8C **Missing:** Release notes entry in `doc/guides/rel_notes/` (re=
quired per AGENTS.md for new features)
- =E2=9D=8C **Missing:** Update to `doc/guides/nics/features/idpf.ini` feat=
ure matrix (required per AGENTS.md)

**Content:**
- =E2=9C=85 Documentation matches the implementation
- =E2=9A=A0=EF=B8=8F "Synchronisation" uses British spelling=E2=80=94DPDK t=
ypically uses American English

---

### Overall Assessment

**Errors (must fix):**
1. Memory leak in `idpf_ptp_get_caps()`=20
2. Use of `<math.h>` and `log2()` function=E2=80=94should use DPDK equivale=
nts
3. Commit message body starts with past tense "Updated" (patch 4)
4. Missing release notes for new feature
5. Missing feature matrix update in `doc/guides/nics/features/`

**Warnings (should fix):**
1. Multiple unnecessary variable initializations (`int err =3D 0;`)
2. Implicit NULL/zero comparisons instead of explicit
3. Inconsistent include style (`"rte_time.h"` vs `<rte_time.h>`)
4. Copyright year range `2001-2025` seems incorrect
5. Mixed indentation (spaces vs tabs) in idpf_ptp.h
6. Subject case for "Precision Time Protocol"=20
7. Generic commit prefixes (`net/intel:`, `doc:`)
8. Division operation in Rx hot path could be optimized

**Info:**
1. `FIELD_PREP` macro added=E2=80=94verify this doesn't duplicate existing =
DPDK functionality
2. Patch 3 modifies common Intel tx.h=E2=80=94ensure other Intel drivers ar=
en't affected
