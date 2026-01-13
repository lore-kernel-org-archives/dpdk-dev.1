Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89ADD2F331
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AC0A402ED;
	Tue, 13 Jan 2026 16:21:47 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 1CFCA40276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:21:46 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b871cfb49e6so367124966b.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768317706;
 x=1768922506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqcJgAfhg2YNS9tLdC7ZPcwDnyzfwrkHRcrC7SCJiCU=;
 b=zV14WyY3EV/LxttVZz1xD1HA345WDNLLxoxjA0kSQHeVkmq+BZ8axLbou2njJykTpy
 dYRSSsG3ecvnW+h977+Ep5odASmCYYal93UBdDmFl80ABHY5DDf75DrZypJjiXZPWpmW
 T04JALpxDNxzSReNtaqyJQtOex6bwpzTgqufXiYV0zq/9WrYLPn1sxYZ+KpcXEFTeWFF
 q8tuFDxIBG+QlldegkG0mtjQoCQ9QsKyeovOoXTcbbozydMVpGMpWKkIItARlOZb9YvO
 xMuDAU9B2US7+XxPjuSQBGUhtEspNoAg7eftlK+rbh8Fz6MjcaxoabiXD1fiEJdkWfSU
 F9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768317706; x=1768922506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oqcJgAfhg2YNS9tLdC7ZPcwDnyzfwrkHRcrC7SCJiCU=;
 b=Xfzxh9raShBG5ag4sRiOgTvPRRfmlTFc1W/IcClfG/576KMR6O26xTWi0uy1RlQNE1
 D7qnyZqI1s9w6ji0AokEQUlbLeKs5AT+FiI+9G3Y68z5gSaemazUBebAgdWfw6xfk7wR
 1dFD3H+f8533w992lpWVBR6C26B69DcDhYPRLExxEdONBOoDIUhUG79PGTHiKqqtJ/Po
 wlAGB1EGZmzdHeuQYkxYWnPRcscSHNOLQinRBLp9G73iR08L0E7K37cYVslCouB/Kzr4
 RxzQsBXv0y9ELdWgxuXPQpd/s6vGaN2fZ+Bo4z5qSW++GhspR2jYshOhL8gNO4QYsFXB
 /hRQ==
X-Gm-Message-State: AOJu0YwB2dk8biYrlUeZJj6wL6LXGGVL8/P5HfwRh5ibJxqDlrarWKsX
 iVGPH8AvTwjz6Qjp35rxF8S1zAY1CMGlugdMrl3tU6sH4x5NFI7PtOkKSrj0C7oQJB4=
X-Gm-Gg: AY/fxX5CVFWCH6zkuwB5UJAh4674Z90Awuat+YdVWh0cJEdTu2Kokz5c7AbuZHZxy3G
 nMbls5BZz81pOwZ076oIPWoTanaE7l5PuVHY9aPdB8GQu6mVVIPDFdevAgfGCQffky/9h9ssxrL
 yZYyMzxpw18SUitjVV5Pb5+hdj3GvuNfFHumJrYbbsCfGVY++umB0BlbTV232dLjKODje1u/Tdo
 ZJbDbFXKr+l4ulKInfzXetC52QXiHKrbLw/zbItnQ4chtS5BdDI6NyGKHo9QeQGgVM7Jd/R/ImP
 8fmL2A4lJvkRnQQaH9j77LyAvFFWmmhwCmk7JAQouUNqlV59FyWm/giG4ydb/id6XWxRlnBoIdS
 UWl+hEZRrTtrRS6M2vjQlrJ9JA/4QHgcSWa9Do8vKUs6qp5d6aPzUiRqsaCQgXDirlyd9yvQ4H9
 5GauBw01fMrRlQpkh5FYrEQxSPP0pP8J0PLGSizoCQkDVfuuo+hfTn
X-Google-Smtp-Source: AGHT+IHqZoLtRiG3M5oMibXMmBGQevfkE9yPt/oMCjXRFe+EhLEahVksIn99ETJMhuX7iEplasv3Cg==
X-Received: by 2002:a17:906:f58d:b0:b87:1b23:cad3 with SMTP id
 a640c23a62f3a-b871b23cd09mr549720766b.9.1768317705404; 
 Tue, 13 Jan 2026 07:21:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a2bc6bbsm2265101866b.27.2026.01.13.07.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 07:21:44 -0800 (PST)
Date: Tue, 13 Jan 2026 07:21:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 0/9] net/sfc: SFN7xxx deprecation and Medford fixes
Message-ID: <20260113072139.073e7d74@phoenix.local>
In-Reply-To: <20251229213527.37907-1-ivan.malov@arknetworks.am>
References: <20251229213527.37907-1-ivan.malov@arknetworks.am>
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

On Tue, 30 Dec 2025 01:35:18 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The series provides various fixes, primarily for Medford4 support.
> It also fixes a legacy flow control bug; due to hardware constraints
> in the fix, SFN7xxx NICs are now marked as deprecated.
>=20
> Andy Moreton (1):
>   common/sfc_efx/base: count Rx TRUNC ERR as CRC errors on X4
>=20
> Ivan Malov (8):
>   doc: remove support for AMD Solarflare SFN7xxx family boards
>   common/sfc_efx/base: fix flow control setting on legacy MCDI
>   common/sfc_efx/base: fix indication of requestable FEC flags
>   common/sfc_efx/base: define mask for pause mode capabilities
>   net/sfc: avoid speed reset when setting FEC in started state
>   net/sfc: rework the capability check that is done on FEC set
>   net/sfc: drop AUTO from FEC capabilities and fix the comment
>   net/sfc: fix reporting status of autonegotiation to the user
>=20
>  doc/guides/nics/sfc_efx.rst            |  14 ---
>  doc/guides/rel_notes/release_26_03.rst |   4 +
>  drivers/common/sfc_efx/base/ef10_ev.c  |  41 +++++--
>  drivers/common/sfc_efx/base/ef10_mac.c |  35 ++++--
>  drivers/common/sfc_efx/base/ef10_nic.c |  57 +++++-----
>  drivers/common/sfc_efx/base/efx.h      |   1 +
>  drivers/common/sfc_efx/base/efx_np.c   |   2 +-
>  drivers/net/sfc/sfc.h                  |   2 +-
>  drivers/net/sfc/sfc_ethdev.c           | 141 +++++++++++++++----------
>  drivers/net/sfc/sfc_ev.c               |   7 +-
>  drivers/net/sfc/sfc_port.c             |   8 +-
>  drivers/net/sfc/sfc_repr.c             |   2 +-
>  12 files changed, 193 insertions(+), 121 deletions(-)
>=20

AI code review spotted one minor thing but was overall quite happy.

# DPDK Solarflare Driver Patch Series Review

**Patches Reviewed:** 0009-0017 (9 patches) =20
**Author:** Ivan Malov <ivan.malov@arknetworks.am> (with contribution from =
Andy Moreton) =20
**Review Date:** January 13, 2026

---

## Overall Assessment

This patch series is **generally well-prepared** and follows DPDK coding st=
andards. The patches address a mix of documentation updates, bug fixes in t=
he sfc_efx base library, and improvements to FEC/flow control handling in t=
he net/sfc driver. Most patches are suitable for merging with only minor ob=
servations.

---

## Patch-by-Patch Review

### Patch 0009: doc: remove support for AMD Solarflare SFN7xxx family boards

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 59 characters |
| Subject format | =E2=9C=85 Correct `doc:` prefix, lowercase |
| Body format | =E2=9C=85 Doesn't start with "It", proper wrapping |
| Signed-off-by | =E2=9C=85 Present |
| Release notes | =E2=9C=85 Updated in `release_26_03.rst` |

**Observations:** Clean documentation removal patch. Properly updates both =
the NIC guide and release notes.

---

### Patch 0010: common/sfc_efx/base: fix flow control setting on legacy MCDI

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 60 characters (at limit) |
| Subject format | =E2=9C=85 Correct prefix, lowercase |
| Fixes tag | =E2=9C=85 `e7cd430c864f` with correct format |
| Cc: stable | =E2=9C=85 Present |
| Tag order | =E2=9C=85 Fixes, Cc, blank line, Signed-off-by, Reviewed-by |

**Code Review:**
- Uses explicit comparison `!=3D B_FALSE` (line 46) =E2=80=94 acceptable, t=
hough `=3D=3D B_TRUE` might be slightly clearer
- Properly adds new fail label and updates error handling
- Switch statement formatting is correct

---

### Patch 0011: common/sfc_efx/base: fix indication of requestable FEC flags

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 59 characters |
| Fixes tag | =E2=9C=85 `a90549f527eb` present |
| Cc: stable | =E2=9C=85 Present |
| Tag order | =E2=9C=85 Correct |

**Code Review:**
- Refactors code to move FEC capability bits initialization to `ef10_nic_pr=
obe()`
- Clean removal of `goto skip_phy_props` pattern
- Uses explicit comparison `=3D=3D B_FALSE`

---

### Patch 0012: common/sfc_efx/base: define mask for pause mode capabilities

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 58 characters |
| Subject format | =E2=9C=85 Correct |
| Signed-off-by | =E2=9C=85 Present |

**Observations:** Simple macro addition. No Fixes tag is appropriate since =
this is a new feature/enhancement required by subsequent patches.

---

### Patch 0013: common/sfc_efx/base: count Rx TRUNC ERR as CRC errors on X4

**Status:** =E2=9A=A0=EF=B8=8F Minor Question

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 57 characters |
| Subject format | =E2=9C=85 Uses correct `Rx` capitalization |
| Signed-off-by | =E2=9C=85 Two signers (appropriate for co-authored work) |

**Observations:**
- **Question:** Should this have a `Fixes:` tag and `Cc: stable@dpdk.org`? =
The commit message describes a workaround for X4 hardware behavior, which c=
ould be considered a bug fix for X4 support. If the X4 family was added in =
a specific commit, a Fixes tag referencing that commit would be appropriate.
- Code correctly duplicates the X4-specific handling in both `ef10_ev_rx_pa=
cked_stream` and `ef10_ev_rx` functions

---

### Patch 0014: net/sfc: avoid speed reset when setting FEC in started state

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 58 characters |
| Fixes tag | =E2=9C=85 `5efa8fc1cfc0` present |
| Cc: stable | =E2=9C=85 Present |
| Dependencies | =E2=9C=85 Uses `EFX_PHY_CAP_PAUSE_MASK` from patch 0012 |

**Code Review:**
- Correctly preserves pause capabilities while updating FEC settings
- Proper dependency ordering within the series

---

### Patch 0015: net/sfc: rework the capability check that is done on FEC set

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 58 characters |
| Fixes tag | =E2=9C=85 `5efa8fc1cfc0` present |
| Cc: stable | =E2=9C=85 Present |
| New includes | =E2=9C=85 `<stdbool.h>` and `<rte_bitops.h>` added |

**Code Review:**
- Uses `bool` type appropriately
- `if (!supported)` at line 156 is acceptable for actual bool types per DPD=
K guidelines
- Uses `rte_popcount32()` =E2=80=94 good use of DPDK utility function
- Commit message includes helpful testpmd reproduction steps

---

### Patch 0016: net/sfc: drop AUTO from FEC capabilities and fix the comment

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 58 characters |
| Fixes tags | =E2=9C=85 Two Fixes tags (both appropriate) |
| Cc: stable | =E2=9C=85 Present |
| Tag order | =E2=9C=85 Correct |

**Observations:**=20
- Multiple Fixes tags are appropriate when a single patch addresses regress=
ions from multiple commits
- Updated comments improve code clarity

---

### Patch 0017: net/sfc: fix reporting status of autonegotiation to the user

**Status:** =E2=9C=85 Ready

| Check | Result |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=85 58 characters |
| Fixes tag | =E2=9C=85 `886f8d8a05bf` present |
| Cc: stable | =E2=9C=85 Present |

**Code Review:**
- Function signature change is propagated to all call sites
- Uses explicit comparison `!=3D 0` (good practice)
- Comment in `sfc_ev.c` appropriately documents a potential race condition =
and explains the trade-off

---

## Summary

| Severity | Count | Details |
|----------|-------|---------|
| **Error** | 0 | None found |
| **Warning** | 1 | Patch 0013 may benefit from Fixes/Cc:stable tags |
| **Info** | 0 | =E2=80=94 |

### Series Dependencies
The patches have proper internal dependencies:
- Patch 0014 depends on patch 0012 (`EFX_PHY_CAP_PAUSE_MASK`)
- The series should be applied in order

### Recommendation
**The series is suitable for merging.** Consider adding `Fixes:` and `Cc: s=
table@dpdk.org` tags to patch 0013 if X4 support was added in a prior relea=
se and this constitutes a fix for that support.
