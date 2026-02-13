Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C78EDF17D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 16:53:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23CB8402C0;
	Fri, 13 Feb 2026 17:53:51 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 1C116402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 17:53:49 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso8670305e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 08:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771001629;
 x=1771606429; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bhziddk7Y3wIgkXRe8l0lJMIT2Zx1eHkM2MKfYIvvXs=;
 b=YOxwCW09aKOc9OljTs8CSk0dpTO/USGiaYE3gIsU+SQohajrxHDxIRUFj9leVDoMSb
 NMjkkTqr0A5WJlFBaBJZfXfBttwWvm5XTuEFTkWshIJEYEuguAkXtXIQKngH959a5Vni
 ypvxUgnUv0+KGNlFwKT3L9foTamZ+qhnwj8fvDUh9d37JAxZVPXhPo+hKv0jazOf4TKH
 UnW/3MFxG7y1TnW55KQ4PWE4Srjg6Ze4wtqaG+iC+wlJ1LsWUPWSc+o9HJ0qLXxTBK5F
 5qmN1TBpmYojNicNLirfAY99gbfVpwveEyrOQvX3tdOm/Xgt7tPOGLtKEcpO3p5+e8Ir
 FR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771001629; x=1771606429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bhziddk7Y3wIgkXRe8l0lJMIT2Zx1eHkM2MKfYIvvXs=;
 b=ey15q244/Xh05j1DuRf+7RqazV3+yXJvYNYLzcLbZnKz6tZG8giWg6DKCdppT9j+ao
 Q22getnEyaGYWOqAarr2JeqP4RA9jGHoHR3dLvFrG4lYuojRmgTVnL/lDqUFhDosWbBS
 qNBAwaS5ouiIyTepl6AR0CI6AUVt2oRRrQK/EBuEm8mg+bybKg4P+VtfGiGNYAXji33C
 hsehWkNLy4RAo9hzrNINE//DAKKdQZTui19RcrLFuvtSKWjNVdjmYbDbibjz1y11bU2F
 g1jrzH+r2vB/vEs/YHhoj7mTeq4cfniseZOH1ymFoGwsBOJgs1fuOVRnG/A+9EuUUN41
 eONA==
X-Gm-Message-State: AOJu0YzKGfoOEy4vCr80K4KFI4JYRFRavmYOvMW0Zf9hcuDS00Phbt1Y
 oLnjGxCxtnXPVQ/wfKxeoqleigSTe3k+hgseJc+/nRiu/Mb9qk/a+hfOADbcEgDlc8KDuGFzMiO
 ZStGW
X-Gm-Gg: AZuq6aLb/vox/V3ivMozxXa4Qg0YfyywtafVf4qQqFWOo9XE6pTm0xkcQhjgMcxmuRh
 nCd5lPuVsmGoQIAzMHqBKsTzkf2AdwBDYbqr+2SPZVaCVtTN2UssuYX8Xz6vtuL5dnf5rTJZXl7
 GBMZ41+5KP+VBk+SJlNnTwzn9R+1GzGrJza1lZboEGu4cQdXsnm+/RxfH9OTozeQEcc0VjE0o4u
 vnLjexKpHJ8GNM5oEPerzvz3KI4rfpDiL9w1oNWz96vqIuIe8u+NpE66wcNQ5UL8nzT6mFcbEu7
 mwbYQwzjH4EsDdOp/8h60ErU37iAD3uOJtutweb8lZVDQ4xTXpkFIItx1bwtYa7EgV6YK6OB+BQ
 TV1bR01em4b9X6cxH3sVaVKPsG7bsYGnEq0Pms83NBYvTBFZjFyqWyxMWfZrrd4A4ab9RQXwccb
 9eSWYjsHOgqg0IyA1lRxFj9Pk6Opw/mSjwhQ79QVXEOnsRdEVvxHHezjmZw0wtPrR2L52vA/lZZ
 h8=
X-Received: by 2002:a05:600c:818c:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-48373a5d230mr37714865e9.19.1771001629239; 
 Fri, 13 Feb 2026 08:53:49 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836ff00332sm70790015e9.2.2026.02.13.08.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 08:53:48 -0800 (PST)
Date: Fri, 13 Feb 2026 08:53:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v4 00/13] net/r8169: driver updates and new hardware
 support
Message-ID: <20260213085341.66ff7d83@phoenix.local>
In-Reply-To: <20260213032018.175753-1-howard_wang@realsil.com.cn>
References: <20260213032018.175753-1-howard_wang@realsil.com.cn>
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

On Fri, 13 Feb 2026 11:20:05 +0800
Howard Wang <howard_wang@realsil.com.cn> wrote:

> This patch series introduces several updates to the net/r8169 driver.
>=20
> The changes are categorized as follows:
>=20
> 1. Bug Fixes:
>    - Fix a crash during RTL8168FP initialization due to a missing functio=
n pointer.
>    - Fix incorrect bitwise logic for RTL8127 capabilities.
>    - Fix incorrect speed identification for RTL8168KB (it is a 1G device).
>    - Fix link status reporting issues regarding old mapping.
>=20
> 2. New Hardware Support:
>    - Add support for RTL8125K (2.5G).
>    - Add support for RTL9151 (2.5G).
>    - Add support for RTL8168KD (1G).
>=20
> 3. Hardware Configuration Updates:
>    - Update MCU and PHY configurations for RTL8125, RTL8126, and RTL8127 =
series
>      to match the latest hardware specifications.
>    - Optimize Rx descriptor fetch numbers for RTL8126 and RTL8127 to impr=
ove performance.
>    - Adjust jumbo frame size limits for non-1G cards.
>=20
> 4. Cleanup:
>    - Remove support for the unreleased test chip (CFG_METHOD_69) to simpl=
ify the code.
>=20
> Howard Wang (13):
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
>   net/r8169: fix bitmask logic for RTL8127
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


Looks good merged to next-net.
I will take the suggestion from AI for one patch
subject.

If interested here is the verbose AI review.

# DPDK net/r8169 Patchset v4 Review =E2=80=94 Deep Dive

**Series**: `[PATCH v4 01/13] net/r8169: ...` (13 patches)
**Author**: Howard Wang `<howard_wang@realsil.com.cn>`
**Date**: 2026-02-13

---

## Series Overview

This 13-patch series covers the Realtek r8169 PMD with a mix of bug fixes, =
new device support, hardware config updates, and code cleanup:

- **Bug fixes** (patches 1, 11, 12, 13): NULL pointer crash in RTL8168FP, i=
ncorrect RTL8168KB speed classification, stale link status after vendor dri=
ver init, and wrong bitmask logic in RTL8127 serdes.
- **New device support** (patches 3, 9, 10): RTL8168KD (1G), RTL9151 (2.5G)=
, RTL8125K (2.5G).
- **Hardware config updates** (patches 4, 7, 8): MCU patches for 8127, 8126=
, 8125 families.
- **Performance tuning** (patch 2): Rx descriptor fetch number optimization.
- **Jumbo frame adjustment** (patch 5): Per-device max frame sizes for non-=
1G cards.
- **Code removal** (patch 6): Drop CFG_METHOD_69 (test chip never released).

---

## Patches With Findings

### Patch 5: `net/r8169: adjust jumbo frame size limit for non-1G cards`

**Warning =E2=80=94 Missing CFG_METHOD_59 (RTL8168KD) in jumbo frame switch=
**

The switch statement in `rtl_dev_infos_get()` lists the 16K-capable non-1G =
devices:

```c
case CFG_METHOD_50: case CFG_METHOD_51: case CFG_METHOD_54:
case CFG_METHOD_55: case CFG_METHOD_56: case CFG_METHOD_57:
case CFG_METHOD_58: case CFG_METHOD_70: case CFG_METHOD_71:
case CFG_METHOD_91:
    dev_info->max_rx_pktlen =3D JUMBO_FRAME_16K;
```

CFG_METHOD_59 (RTL8168KD, added in patch 3) is absent. If it's a 1G device =
using the 8125D base code, it may still benefit from the 16K path, or it ma=
y intentionally fall through to the 9K default. Either way, this should be =
clarified =E2=80=94 the commit description says "For other non-1G cards, se=
t the max size to 16K" but RTL8168KD is a 1G card, so the 9K default may be=
 correct. Worth explicit confirmation.

---

### Patch 6: `net/r8169: remove support for CFG_METHOD_69`

**Warning =E2=80=94 Interaction with patch 2**

Patch 2 modifies the `CFG_METHOD_69` case in `hw_init_rxcfg_8126a()` to use=
 `Rx_Fetch_Number_20`, then patch 6 removes `CFG_METHOD_69` entirely includ=
ing that same code path. The patches should apply cleanly in sequence, but =
this creates churn =E2=80=94 patch 2's changes to the CFG_METHOD_69 path ar=
e immediately deleted by patch 6.

This is not a correctness bug, but as a reviewer observation: reordering pa=
tches 2 and 6 (remove first, then tune the remaining methods) would reduce =
noise in the series.

**Info =E2=80=94 `CFG_METHOD_69` mapping to `CFG_METHOD_DEFAULT`**

In `rtl_get_mac_version()`, the device ID `0x64800000` with `ic_version_id =
=3D=3D 0x00000000` is remapped from `CFG_METHOD_69` to `CFG_METHOD_DEFAULT`=
. This means any hardware that previously matched this ID will now be treat=
ed as an unknown chip. This is intentional per the commit message (test chi=
p not released), but worth noting that any such hardware in the field would=
 lose functionality.

---

### Patch 9: `net/r8169: add support for RTL9151`

**Error (Confidence ~60%) =E2=80=94 `RTE_ASSERT` followed by guard in `rtl8=
125_get_mac_version_v2()`**

```c
RTE_ASSERT(val32 !=3D UINT_MAX &&
           (val32 & RTL_R32(hw, TxConfig) & 0x7c800000) =3D=3D 0x7c800000);

if (val32 =3D=3D UINT_MAX)
    return;
```

`RTE_ASSERT` is typically compiled out in release builds (`RTE_ASSERT` is a=
 no-op unless `RTE_ENABLE_ASSERT` is defined). The logic here defensively c=
hecks `val32 =3D=3D UINT_MAX` after the assert, which is good. However, if =
the assert fires in debug builds, it will abort before the graceful return =
path is reached. The assert also issues a second MMIO read (`RTL_R32(hw, Tx=
Config)`) inside the assert condition =E2=80=94 this read happens only in d=
ebug builds and has a side effect (MMIO access). This is unusual and potent=
ially confusing.

**Suggested fix**: Move the MMIO cross-check outside the assert or just use=
 a log warning:

```c
if (val32 =3D=3D UINT_MAX)
    return;

/* Verify TxConfig signature matches V2 register layout */
if ((val32 & RTL_R32(hw, TxConfig) & 0x7c800000) !=3D 0x7c800000) {
    PMD_INIT_LOG(WARNING, "TxConfigV2 signature mismatch");
    return;
}
```

**Warning =E2=80=94 Missing `CFG_METHOD_60` in `r8169_compat.h` enumeration=
**

Patch 9 adds `CFG_METHOD_60` in several places and `RTL9151A` to the chipse=
t enum, but the `CFG_METHOD_60` enum value itself needs to exist in `r8169_=
compat.h`. It's not shown in the diff. This may exist in the base code alre=
ady, or be added by a dependency =E2=80=94 cannot verify from the patch alo=
ne, so noting it for completeness.

**Warning =E2=80=94 Missing release notes for new device (RTL9151)**

Per AGENTS.md guidelines: "New drivers or subsystems must have release note=
s." The RTL9151 is a new device type being added to an existing driver. The=
re are no doc changes in this patch or the series. A release notes entry sh=
ould be added.

**Warning =E2=80=94 Missing `doc/guides/nics/features/r8169.ini` update**

If RTL9151 has different feature support than existing devices, the feature=
s matrix should be updated.

---

### Patch 10: `net/r8169: add support for RTL8125K`

**Warning =E2=80=94 `CFG_METHOD_61` shares RAM code version with `CFG_METHO=
D_57`**

```c
case CFG_METHOD_57:
case CFG_METHOD_59:
case CFG_METHOD_61:
    hw->sw_ram_code_ver =3D NIC_RAMCODE_VERSION_CFG_METHOD_57;
    break;
```

This is intentional (RTL8125K uses the same MCU firmware as RTL8125D rev 2)=
, but it means the ram code version define is named after a different chip =
method. This is just informational =E2=80=94 the code is correct.

**Warning =E2=80=94 Missing release notes for new device (RTL8125K)**

Same as patch 9 =E2=80=94 new device support should be noted in release not=
es.

---

### Patch 11: `net/r8169: fix one bug about RTL8168KB`

**Warning =E2=80=94 Subject line wording**

"fix one bug about RTL8168KB" is vague. A more descriptive subject like `ne=
t/r8169: fix RTL8168KB speed classification` would better communicate what =
the patch does.

---

### Patch 13: `net/r8169: fix bitmask logic for RTL8127`

**This is a genuine correctness bug fix =E2=80=94 good catch by the author.=
**

The original code:

```c
val &=3D (BIT_13 | BIT_12 | BIT_1 | BIT_0);  /* BUG: clears everything EXCE=
PT these bits */
val |=3D BIT_1;
```

The fix:

```c
val &=3D ~(BIT_13 | BIT_12 | BIT_1 | BIT_0);  /* Correct: clears these spec=
ific bits */
val |=3D BIT_1;
```

Without the `~`, the `&=3D` would mask the value to *only* keep bits 13, 12=
, 1, and 0, destroying all other bits in the register. With the fix, only t=
he targeted bits are cleared before setting BIT_1. This would have caused i=
ncorrect serdes capability configuration for RTL8127 1G and 10G modes. The =
fix is correct.

---

## Patches With No Issues

Patches 1, 2, 3, 4, 7, 8, 12 were reviewed and no issues requiring report w=
ere found. The bug fixes (1, 12) are straightforward and correct. The hardw=
are config updates (3, 4, 7, 8) follow established patterns in the driver. =
Patch 2's register constant definitions (`Rx_Fetch_Number_12`, `Rx_Fetch_Nu=
mber_20`) use existing macro patterns correctly.

---

## Summary

| Severity | Count | Details |
|----------|-------|---------|
| Error    | 1     | MMIO read inside `RTE_ASSERT` in patch 9 |
| Warning  | 5     | Missing release notes (9, 10), subject wording (11), C=
FG_METHOD_59 jumbo clarification (5), patch ordering churn (6) |
| Info     | 1     | CFG_METHOD_69 default remap (6) |

The series is overall well-structured. The high-value finding is patch 13's=
 bitmask fix which addresses a real hardware misconfiguration bug. The main=
 areas for improvement are documentation (release notes for new devices) an=
d minor commit message polish.
