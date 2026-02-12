Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EACEEA847
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 18:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C28DF4025F;
	Thu, 12 Feb 2026 19:18:11 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 9C94040041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 19:18:09 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4359a302794so101083f8f.1
 for <dev@dpdk.org>; Thu, 12 Feb 2026 10:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770920289;
 x=1771525089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9alKiTEh9FL5e+473m7qA3Qc0qWHn4CFPsiOoF0K3I=;
 b=Z1+drJI/QphTMwRbf2yoXY1lbVF2fLIpjbOmkBGqxlJPe0O+yDBQajsUlDgWP8m2iX
 5y7l4jMZrlmScKVEIAVDKqIl/R1Lw2ZmT3HfXQxKPTM/Yz4gMoMRaB640lwADgDwmkUT
 7VBw9HdwKa7I7HlHEFQMFmi+7YGUBH1oLHY8ANgv2PaQHbMTa6QustuBmpCPLVzwbwId
 qWfBorkRe09LPh4BNZ13XuJ4aRe1li5hboy3Br3q9KD4GbbVHt6iuP0UocPVsX5UP5+g
 ogxiREeNfT7yhZd8mhwtIaJhPSsJRkUU+VIs5vbgG/6bwYUewd8MYpAxIVEBxuc0q4iG
 lH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770920289; x=1771525089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e9alKiTEh9FL5e+473m7qA3Qc0qWHn4CFPsiOoF0K3I=;
 b=scu6e5vlFLxx1glVHh/QMMBwx/vgkbwmvDlObYXGB+Meq0Fl3LP2r3xLdGmhxFUVgf
 LeGwGbILtKkv/M0XtCbKBvqwhd0RqgIDPC9aVg7U4C/95fxNvio3Oviex9UOngslEpoA
 BrJhjiWsrz/lG3ZfYLYbJnnkSPd4J22NtOahOOxqkp92/BG+DUlM6LeEKKdkHxYLbqDw
 D5i6rHQ0wCVeOIVYPNWra2r4CQD9UUdzvCr9XD4S6M8h6gTFjYW0iKoQfisJ/CzeXDlL
 Jq7ml45q7aC9Wy98Pm+dg1JgHhcDflcQwb0HZyiEZDOHqu7oIf24pDUJvx+sfkXXDmOk
 n3YQ==
X-Gm-Message-State: AOJu0YxFkA4UlAJFHMjXnvNKs0lpXXNxQwsvMMzF4uSzGHeoJ+4R2CB3
 SsP1Dr1Mwu3OOHrPmUsmBT9aZlcBbF0lw5XLAOiWJudftXvS3Bbv0KIkzVQajnC3gyNILjjkHLx
 Ge39S
X-Gm-Gg: AZuq6aKVBIwo0c89wDLJa2lvV4luXFnDvlSDaCvj6rFF/o+GOe7RI2KeiPR+hkGKWje
 NVO2SevhRo3Jt5rJJcRHRFfm+aik0u3KWMWrPz1j7X6ckbSPFlkqXJic+9e6+i1vJ0dYdhfyzIf
 QXt0V1vlCJxPp0EPncIcb9sfhoFT9W64R3sBXdHFZLh/nASpZUVFwk9PRFvvYvQuPUFbKUI/mSa
 xdT9Uvk+kEJ6cG2ZkjpxsCsrUqVx9khLwm/ZLeK47gqRnUZWpKlXubguOjEFt623u14C85P+dmD
 FmEarzgvoGYJ4uaoZBcV++894s/g1/3Xte6RnDy9Xnsn4v9sZaYAHkdEBQmm98Gvt3K+v/7oVKa
 RgMwSCCaJkQ1f9oCZ/M2th2Gxw61MnoYIXFz00LHjRpJ60FzXNONHDUF6JcZO4ukkrO9+yxvlKJ
 5A/T256UMnmd0+xdLWmsShKCrastmClMCs3HU4YU/TDCKvXKNZDr8kSbjS0IsXEVHN
X-Received: by 2002:a05:6000:2887:b0:435:975a:131c with SMTP id
 ffacd0b85a97d-4378ad46189mr6458462f8f.36.1770920288723; 
 Thu, 12 Feb 2026 10:18:08 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfc54csm13052501f8f.25.2026.02.12.10.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 10:18:07 -0800 (PST)
Date: Thu, 12 Feb 2026 10:18:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v3 00/12] net/r8169: update driver with new HW support
 and fixes
Message-ID: <20260212101800.241a2d34@phoenix.local>
In-Reply-To: <20260212055902.139958-1-howard_wang@realsil.com.cn>
References: <20260212055902.139958-1-howard_wang@realsil.com.cn>
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

On Thu, 12 Feb 2026 13:58:50 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> This patch set updates the r8169 pmd driver to include support for new
> Realtek hardware revisions and provides several bug fixes and improvement=
s.
>=20
> The main changes include:
>=20
> 1. New Hardware Support:
>    - Add support for RTL8125K, RTL9151 and RTL8168KD.
>=20
> 2. Bug Fixes:
>    - Fix a bug related to RTL8168KB.
>    - Fix a potential NULL pointer dereference in rtl8168fp_ops.
>    - Fix the incorrect link status reported when binding the PMD after
>      the NIC has been initialized by the vendor driver.
>=20
> 3. Configuration & Optimization:
>    - Update hardware configurations for 8125, 8126, and 8127 series.
>    - Adjust jumbo frame size limits for non-1G cards.
>    - Tune RX descriptor fetch number for 8126 and 8127 to improve perform=
ance.
>    - Remove support for legacy CFG_METHOD_69.
>=20
> Howard Wang (12):
>   net/r8169: fix crash in RTL8168FP init
>   net/r8169: optimize Rx descriptor fetch number
>   net/r8169: add support for RTL8168KD
>   net/r8169: update hardware configurations for 8127
>   net/r8169: adjust jumbo frame size limit for non-1G cards
>   net/r8169: remove support for CFG_METHOD_69
>   net/r8169: update hardware configurations for 8126
>   net/r8169: update hardware configurations for 8125
>   net/r8169: add support for RTL9151
>   net/r8169: add support for RTL8125K
>   net/r8169: fix one bug about RTL8168KB
>   net/r8169: ensure the old mapping is used
>=20
>  drivers/net/r8169/base/rtl8125a_mcu.c  |  128 +--
>  drivers/net/r8169/base/rtl8125b_mcu.c  |   56 +-
>  drivers/net/r8169/base/rtl8125bp_mcu.c |   17 +-
>  drivers/net/r8169/base/rtl8125cp.c     |   36 +
>  drivers/net/r8169/base/rtl8125cp_mcu.c |   87 +-
>  drivers/net/r8169/base/rtl8125cp_mcu.h |    1 +
>  drivers/net/r8169/base/rtl8125d.c      |   31 +-
>  drivers/net/r8169/base/rtl8125d_mcu.c  |  605 +++++++----
>  drivers/net/r8169/base/rtl8125d_mcu.h  |    1 +
>  drivers/net/r8169/base/rtl8126a.c      |   32 +-
>  drivers/net/r8169/base/rtl8126a_mcu.c  |  689 +-----------
>  drivers/net/r8169/base/rtl8126a_mcu.h  |    2 -
>  drivers/net/r8169/base/rtl8127.c       |   15 +-
>  drivers/net/r8169/base/rtl8127_mcu.c   | 1332 +++++++++++++++++-------
>  drivers/net/r8169/base/rtl8168fp.c     |    1 +
>  drivers/net/r8169/base/rtl8168fp.h     |    1 +
>  drivers/net/r8169/base/rtl8168fp_mcu.c |    6 +
>  drivers/net/r8169/base/rtl9151a.c      |   87 ++
>  drivers/net/r8169/base/rtl9151a.h      |   10 +
>  drivers/net/r8169/base/rtl9151a_mcu.c  |   53 +
>  drivers/net/r8169/meson.build          |    2 +
>  drivers/net/r8169/r8169_compat.h       |   10 +-
>  drivers/net/r8169/r8169_ethdev.c       |   36 +-
>  drivers/net/r8169/r8169_ethdev.h       |    3 +
>  drivers/net/r8169/r8169_fiber.c        |   15 +-
>  drivers/net/r8169/r8169_hw.c           |  239 +++--
>  drivers/net/r8169/r8169_hw.h           |   11 +-
>  drivers/net/r8169/r8169_phy.c          |   54 +-
>  drivers/net/r8169/r8169_rxtx.c         |    1 -
>  29 files changed, 2058 insertions(+), 1503 deletions(-)
>  create mode 100644 drivers/net/r8169/base/rtl9151a.c
>  create mode 100644 drivers/net/r8169/base/rtl9151a.h
>  create mode 100644 drivers/net/r8169/base/rtl9151a_mcu.c
>=20


Better but AI review flagged some issues:

Most significant: Patch 4 has what looks like a real mask inversion bug
fix (&=3D (bits) =E2=86=92 &=3D ~(bits)) in two places in r8169_fiber.c for=
 RTL8127
SerDes configuration. The original code was AND'ing to keep only those
bits when it should have been clearing them before OR'ing in new
values. This fix is buried in a large hardware update patch with no
Fixes tag =E2=80=94 it should really be split out as a standalone bugfix.

Process: Patches 1, 11, and 12 all have Fixes: tags but are missing Cc: sta=
ble@dpdk.org.

Minor: Patches 11 and 12 have vague commit subjects, and patch 5's
jumbo frame size switch may be missing some newer CFG_METHODs that the
commit message implies should get 16K. The bulk of the series (MCU
firmware blobs, PHY register programming, new chip enablement) is
typical vendor driver code that looks structurally sound =E2=80=94 the patt=
erns
match existing chip support code consistently.

Full details:

# DPDK net/r8169 v3 Patch Series Review

**Series**: [PATCH v3 01/12] through [PATCH v3 12/12]
**Author**: Howard Wang <howard_wang@realsil.com.cn>
**Delegate**: stephen@networkplumber.org

---

## Series Overview

This 12-patch series for the Realtek r8169 PMD includes:

- **Bug fixes** (patches 1, 11, 12): NULL pointer crash fix for RTL8168FP, =
incorrect 2.5G classification of RTL8168KB, and stale interrupt mapping aft=
er vendor driver initialization.
- **New chip support** (patches 3, 9, 10): RTL8168KD (1G), RTL9151 (2.5G), =
RTL8125K (2.5G).
- **Hardware configuration updates** (patches 4, 7, 8): Updated MCU firmwar=
e, PHY config, and tuning for RTL8127, RTL8126, and RTL8125 family chips.
- **Optimization** (patch 2): Rx descriptor fetch number tuning for RTL8126=
/RTL8127.
- **Cleanup** (patches 5, 6): Remove test chip CFG_METHOD_69 and adjust jum=
bo frame size limits.

The series is largely vendor firmware/register programming updates =E2=80=
=94 the kind of code that's difficult to review for logical correctness wit=
hout hardware documentation, but can be reviewed for structural issues, err=
or handling, and process compliance.

---

## Findings

### Patch 1: net/r8169: fix crash in RTL8168FP init

**Error =E2=80=94 Missing `Cc: stable@dpdk.org`**: This patch has a `Fixes:=
` tag indicating it corrects a regression (NULL pointer dereference during =
init). It should include `Cc: stable@dpdk.org` for stable release backport =
consideration.

### Patch 4: net/r8169: update hardware configurations for 8127

**Warning =E2=80=94 Bug fix embedded in a feature patch without Fixes tag**=
: This patch changes two mask operations from `val &=3D (BIT_13 | BIT_12 | =
BIT_1 | BIT_0)` to `val &=3D ~(BIT_13 | BIT_12 | BIT_1 | BIT_0)`. The origi=
nal code *keeps* only those bits (AND without NOT), while the new code *cle=
ars* those bits (AND with NOT). This is a significant behavioral change =E2=
=80=94 it looks like a bug fix (the original almost certainly should have b=
een clearing those bits before OR'ing in new values). This fix is buried in=
side a large hardware config update patch with no `Fixes:` tag. It should e=
ither be split into a separate fix patch with a proper `Fixes:` tag and `Cc=
: stable@dpdk.org`, or at least called out in the commit message.

The same `&=3D (bits)` to `&=3D ~(bits)` change appears at two sites in `r8=
169_fiber.c`:
- `rtl8127_set_sds_phy_caps_5g_8127()` (line 2364)
- `rtl8127_set_sds_phy_caps_10g_8127()` (line 2381)

### Patch 5: net/r8169: adjust jumbo frame size limit for non-1G cards

**Warning =E2=80=94 Missing CFG_METHOD_59, CFG_METHOD_60, CFG_METHOD_61 in =
jumbo frame switch**: The switch statement for `max_rx_pktlen` lists specif=
ic CFG_METHODs for 16K frames but omits CFG_METHOD_52, CFG_METHOD_53, CFG_M=
ETHOD_59 (RTL8168KD, added in patch 3), CFG_METHOD_60 (RTL9151, added in pa=
tch 9), and CFG_METHOD_61 (RTL8125K, added in patch 10). These later chips =
fall into the `default` case and get 9K. This may be intentional (perhaps t=
hese chips only support 9K jumbo frames), but the commit message says "For =
other non-1G cards, set the max size to 16K" which contradicts the code =E2=
=80=94 several 2.5G+ chips would still get the 9K default. Worth verifying =
intent.

### Patch 6: net/r8169: remove support for CFG_METHOD_69

**Warning =E2=80=94 Removal of CFG_METHOD_69 from `hw_init_rxcfg_8126a` lea=
ves an empty switch case fall-through**: After removing the `CFG_METHOD_69`=
 case, `CFG_METHOD_70` and `CFG_METHOD_71` still exist but the switch now s=
tarts with `CFG_METHOD_70`. Not a bug, just noting the cleanup is consisten=
t.

No issues with this patch.

### Patch 9: net/r8169: add support for RTL9151

**Warning =E2=80=94 Missing CFG_METHOD_60 in several locations in r8169_hw.=
c**: When patch 10 (RTL8125K, CFG_METHOD_61) is reviewed, it adds CFG_METHO=
D_61 alongside CFG_METHOD_60 in multiple switch/if blocks (`rtl_stop_all_re=
quest`, `rtl_wait_txrx_fifo_empty`, `rtl8125_set_rx_desc_type`, etc.). Chec=
king patch 9, CFG_METHOD_60 is *not* added to these same locations =E2=80=
=94 it appears that patch 10 handles adding CFG_METHOD_60 to those location=
s retroactively. Per review guidelines, I'm assuming the author ordered pat=
ches correctly and these compile in sequence, but it's worth confirming tha=
t CFG_METHOD_60 is handled in `rtl_stop_all_request`, `rtl_wait_txrx_fifo_e=
mpty`, and `rtl8125_set_rx_desc_type` after the full series is applied.

### Patch 10: net/r8169: add support for RTL8125K

**Info =E2=80=94 HwSuppCheckPhyDisableModeVer simplification**: The switch =
converting many explicit `CFG_METHOD_*` cases to a `default` for `HwSuppChe=
ckPhyDisableModeVer =3D 3` is a welcome simplification. However, this means=
 any future unrecognized CFG_METHOD will get version 3. This seems intentio=
nal and reasonable as a catch-all.

### Patch 11: net/r8169: fix one bug about RTL8168KB

**Error =E2=80=94 Missing `Cc: stable@dpdk.org`**: This patch has a `Fixes:=
` tag. The RTL8168KB was being incorrectly treated as a 2.5G device which c=
ould cause link negotiation issues. Should have `Cc: stable@dpdk.org`.

**Warning =E2=80=94 Commit subject**: "fix one bug about RTL8168KB" is vagu=
e. A more descriptive subject like `net/r8169: fix RTL8168KB speed classifi=
cation` would be clearer.

### Patch 12: net/r8169: ensure the old mapping is used

**Error =E2=80=94 Missing `Cc: stable@dpdk.org`**: This patch has a `Fixes:=
` tag correcting incorrect link status when taking over from the vendor ker=
nel driver. Should have `Cc: stable@dpdk.org`.

**Warning =E2=80=94 Commit message could be more descriptive**: "ensure the=
 old mapping is used" is somewhat opaque. The body explains it fixes incorr=
ect link status when binding after the vendor driver, but the subject line =
doesn't convey what "mapping" refers to (interrupt register mapping). Consi=
der something like `net/r8169: fix link status after vendor driver unbind`.

---

## Patches With No Issues Found

Patches 2, 3, 6, 7, 8 =E2=80=94 no issues identified.

---

## Summary

| Severity | Count | Details |
|----------|-------|---------|
| Error | 3 | Missing `Cc: stable@dpdk.org` on patches 1, 11, 12 (all have =
Fixes tags) |
| Warning | 4 | Bug fix buried in feature patch (patch 4); missing CFG_METH=
ODs in jumbo size (patch 5); vague commit subjects (patches 11, 12) |
| Info | 1 | Default case simplification in patch 10 |

The most technically significant finding is the `&=3D (bits)` =E2=86=92 `&=
=3D ~(bits)` fix in patch 4, which corrects what appears to be a real mask =
inversion bug in the fiber/SerDes configuration for RTL8127. This should id=
eally be a standalone fix with a Fixes tag rather than buried in a large ha=
rdware update.
