Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1149E7E0DA
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:26:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B08964042C;
	Mon,  9 Feb 2026 20:26:32 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 4A599402F2
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:26:31 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so41278805e9.0
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770665191;
 x=1771269991; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pXS06NoAfPWm1AbGljFrIwz0pP9DK8G/nGdkQBipC8=;
 b=murAhZW7y3SG/JMyOzIMO6GH1plSGios3W4PJHf6ES2ax7y1meiiyDneqFRrLGEkNS
 JS17yfVfXjqykBGsAa0X0/1MioQGfu/sCs6969pMoShQu0Jw8jLDHGfPTmrOybKSnG8l
 wfNu1QIvmBtLdgOa73LVZTdPsHOBpXDrlQRfgc+quEwwCq5PfSAwXtK03d/kR2vv73aV
 xO7dcz9wA263M/Yen57gbqitBHqmsPP8g51/hD8otqAlXyBX5HfbBSu82ITAZJUi6Zmw
 CTl9HA4CKxEcUppkAbbHwPLvf17zPi/piefbjxa3d9Zr2XPqfuZP3l3Cca06dbCXhGHg
 dxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770665191; x=1771269991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7pXS06NoAfPWm1AbGljFrIwz0pP9DK8G/nGdkQBipC8=;
 b=nZC5tGiBJqNplaxhQaAKcnzm4izvD2lYoCz4WHNaFKc6lxwL8S/RSg+PA//CkKztBB
 lCV++iBL4m/wGfSo743zxwkjZGNyQXkmiVxy9Vwti7Kq7IDzZw1E7nFxy9vBDf8Uk3w2
 0n+tqa/bbNQYLg/bvQWZm9hw1nH7uLvs2XavdaqCNxY9yd0WvI8P6RISzwmCtHWerg0C
 c3q21/TB18TQu1LTWO8XCWXk+Vl8L+Y4S9YMICiHTXoGOPNzF7Jp/nOXQQ5BFfH9eJI8
 F5GY+zNjPBfNqsOZVdqYgAJ3l5wLXZVQ4sWCh4pW42cQtUC2sx6YwyyQJuPh20Oelh3i
 nCyw==
X-Gm-Message-State: AOJu0Yw0mQ1TImZEQzzrET9xvBeZcbRQoyy2JJ3wTICiNlMGKzgetdyM
 GoGq8WvGVJVYNSt0kOnQhR7GrKC1wmf+6SrzwrAlUMg87foPDZAcuwFdIxBUS5Y4uW7482ZKBA7
 o2JEw
X-Gm-Gg: AZuq6aLqRIZ3GXs9nvB0nb8cJhjZdl/4TEZ55obOkiS+4BkykAK91QcMfAJBEU37C8D
 ++E3+X+6iIUE6fKIxeI1cChZIPaPdD5idYNY0Bdn53ss3ywhkMZNS0OMgRdN1uhLwtDvqz7QnhD
 YvMYgIuqPbNdCsoI9rZgdcd0cFbEhAiVt0ghDeSoXzQriyXs7gfcj6Bik4it/0ToV7g6WKBz1kg
 j1idEX8NnwUUUWbEV+1+GdpXJFq/TCghpGFMj6GnKn4K15WKiF/chnois2jWTR0KlzYk8kDqM7m
 wey0bOgkPkVGn0nN73h7Z6hf0evIXNzMmAEbRouGvmXsvXhwyUeZFtAzLlDXbR5yNbXJ3QkAsrs
 9+dXzwf0Bs88xYjZXL0ti8CfvUC4uTnkuArIxOGmJA7sDQlRdvPI/qQLGzNLRRIGf+ryA1ufdAU
 NXFHq3CxmgWXf4r04v5v355d9FsP7rCqLrM5YQRQR1iAE5Zjk/KLGG
X-Received: by 2002:a05:600c:8011:b0:480:39ad:3b7c with SMTP id
 5b1f17b1804b1-483201de61cmr202991965e9.16.1770665190506; 
 Mon, 09 Feb 2026 11:26:30 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209e740esm99678275e9.19.2026.02.09.11.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:26:30 -0800 (PST)
Date: Mon, 9 Feb 2026 11:26:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Howard Wang <howard_wang@realsil.com.cn>
Cc: <dev@dpdk.org>, <pro_nic_dpdk@realtek.com>
Subject: Re: [PATCH v1 00/12] net/r8169: update driver with new HW support
 and fixes
Message-ID: <20260209112625.1fac3b98@phoenix.local>
In-Reply-To: <20260209085502.26722-1-howard_wang@realsil.com.cn>
References: <20260209085502.26722-1-howard_wang@realsil.com.cn>
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

On Mon, 9 Feb 2026 16:54:50 +0800
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

Overall looks good but would like to see better commit messages.
I can generate them if necessary.

The part that concerns me is the lack of use of Fixes in patch 1 and 11.

The AI review summary is:

Correctness issues (highest value):

    Patch 4 has a significant bitmask logic change (&=3D =E2=86=92 &=3D ~) =
in the fiber SerDes configuration for both 1G and 10G caps. This is likely =
a bugfix but isn't called out in the commit message =E2=80=94 worth confirm=
ing with the submitter.
    Patch 3 removes the 0xF2/BIT_6 clearing from rtl_powerdown_pll for all =
8125-family chips. This was previously done on link-down but is now only do=
ne in hw_config. If the powerdown path needs this register cleared, it coul=
d be a regression.
    Patch 5 doesn't include CFG_METHOD_59/60/61 in the jumbo frame switch =
=E2=80=94 these new 2.5G chips fall through to the 9K default, which may be=
 unintended.

Process issues:

    Most patches lack commit message bodies (DPDK requires descriptions)
    Patches 1 and 11 are bugfixes without Fixes: tags or Cc: stable@dpdk.org
    Patches 9 and 10 add new device support without release notes updates
    Patch 6 removes an entire chip variant (CFG_METHOD_69) with no explanat=
ion

Longer AI full feedback:
# Review: [PATCH v1 01-12/12] net/r8169 updates

Series from Howard Wang <howard_wang@realsil.com.cn>

---

## Patch 01/12: net/r8169: fix NULL pointer dereference in rtl8168fp_ops

**Correctness =E2=80=94 Error (potential NULL pointer dereference fix)**

This patch adds the missing `.hw_phy_mcu_config` function pointer to the `r=
tl8168fp_ops` struct. If the caller invokes `hw->hw_ops.hw_phy_mcu_config(h=
w)` without this, it would dereference a NULL function pointer. The fix is =
correct =E2=80=94 adds the function pointer and provides a no-op implementa=
tion.

**Warning =E2=80=94 Missing commit body.** The commit has a Signed-off-by b=
ut no description of the problem being fixed. Since this is a bugfix (NULL =
pointer dereference), it should include a `Fixes:` tag referencing the comm=
it that introduced `rtl8168fp_ops` without this member, and `Cc: stable@dpd=
k.org` for backport consideration.

---

## Patch 02/12: net/r8169: tune RX desc fetch num for 8126 and 8127

**Warning =E2=80=94 Inconsistent define style.** The existing `Rx_Fetch_Num=
ber_8` is defined as `(1 << 30)` while the new defines `Rx_Fetch_Number_12`=
 and `Rx_Fetch_Number_20` use `BIT_30`, `BIT_29`, `BIT_31` macros. For cons=
istency within the same block of defines, one style should be used.

No correctness issues.

---

## Patch 03/12: net/r8169: add support for RTL8168KD

**Warning =E2=80=94 Missing commit body.** No description of the RTL8168KD =
or what CFG_METHOD_59 represents. A brief description would help reviewers.

**Warning =E2=80=94 Enum gap.** The patch changes `CFG_METHOD_91` from an a=
uto-incremented value to an explicit `=3D 91`, which creates a large gap be=
tween `CFG_METHOD_71` and `CFG_METHOD_91`. This is intentional (making room=
 for CFG_METHOD_59), but there's no `CFG_METHOD_59` added to the enum in th=
is patch. The implicit value of `CFG_METHOD_59` would be 72 (after CFG_METH=
OD_71), not 59. This works functionally since the enum values are just iden=
tifiers, but the naming is misleading =E2=80=94 `CFG_METHOD_59` has enum va=
lue 72. This seems to be an existing pattern in the driver, but worth notin=
g.

**Info =E2=80=94 Refactoring in `rtl_exit_realwow`.** The switch-case is re=
factored to use `rtl_is_8125()` helper. This simplifies the code and automa=
tically covers CFG_METHOD_59. Good change.

**Info =E2=80=94 Removed `BIT_6`/`BIT_7` write in `rtl_powerdown_pll`.** Th=
e block that wrote to registers 0xD0 and 0xF2 for the 8125-family methods w=
as removed. This is now handled in `rtl8125_hw_config` instead (the new DAS=
H if/else block). Verify this doesn't create a regression for the existing =
CFG_METHOD_48-58 path =E2=80=94 the `rtl8125_hw_config` changes apply 0xF2 =
BIT_6 handling for all hw_config paths, but `rtl_powerdown_pll` was called =
on link-down. If the 0xF2 BIT_6 clearing is only needed during powerdown an=
d not during hw_config, this could be a behavior change.

No obvious correctness bugs in the new CFG_METHOD_59 plumbing itself.

---

## Patch 04/12: net/r8169: update hardware configurations for 8127

**Error (potential correctness bug, ~60% confidence) =E2=80=94 Bitmask fix =
in `r8169_fiber.c`.**

The change from `val &=3D (BIT_13 | BIT_12 | BIT_1 | BIT_0)` to `val &=3D ~=
(BIT_13 | BIT_12 | BIT_1 | BIT_0)` is a significant logic change. The origi=
nal code was keeping ONLY bits 13, 12, 1, 0 and clearing everything else. T=
he new code clears bits 13, 12, 1, 0 and keeps everything else. This appear=
s in both `rtl8127_set_sds_phy_caps_1g_8127` and `rtl8127_set_sds_phy_caps_=
10g_8127`. If the original code was indeed the intended behavior, this is a=
 bug being fixed. If the original code was correct, this patch introduces a=
 bug. Given that this patch is titled "update hardware configurations" and =
this looks like a typical `&=3D` vs `&=3D ~` bugfix pattern, this is likely=
 an intentional fix. However, the commit message doesn't call this out. **R=
ecommend the commit body explicitly mention the bitmask correction as a bug=
fix.**

**Warning =E2=80=94 Very large MCU firmware blob update.** The PHY MCU RAM =
code for 8127a_1 is extensively rewritten (the diff shows hundreds of lines=
 of hex data changes). This is firmware data from the vendor so not much to=
 review in terms of code logic, but the sheer size of changes in a single p=
atch is notable.

No other correctness issues found in the firmware data handling =E2=80=94 t=
he `ARRAY_SIZE` pattern and write loops look correct.

---

## Patch 05/12: net/r8169: adjust jumbo frame size limit for non-1G cards

**Warning =E2=80=94 Missing CFG_METHOD_59 (RTL8168KD) and CFG_METHOD_69 (be=
ing removed in patch 6).** The new switch statement for `max_rx_pktlen` doe=
s not include `CFG_METHOD_59` (added in patch 3) or `CFG_METHOD_60`/`CFG_ME=
THOD_61` (added in patches 9/10). These will fall through to the `default` =
case and get `JUMBO_FRAME_9K`. Verify this is the intended behavior for RTL=
8168KD, RTL9151A, and RTL8125K =E2=80=94 the commit message says "non-1G ca=
rds" get 16K, but CFG_METHOD_59/60/61 are 2.5G-capable, suggesting they may=
 also need 16K.

---

## Patch 06/12: net/r8169: remove support for CFG_METHOD_69

**Warning =E2=80=94 Missing commit body.** No explanation for why CFG_METHO=
D_69 support is being removed. This is a significant change (removing an en=
tire chip variant). The commit should explain the rationale =E2=80=94 is th=
is hardware never released? Is it being superseded?

No correctness issues =E2=80=94 the removal is mechanical and consistent ac=
ross all files.

---

## Patch 07/12: net/r8169: update hardware configurations for 8126

**Warning =E2=80=94 Missing commit body.** Just has the Signed-off-by with =
no description.

The MCU patch code updates and PHY configuration additions look like standa=
rd firmware/register updates from the vendor. No correctness issues found.

---

## Patch 08/12: net/r8169: update hardware configurations for 8125

**Warning =E2=80=94 Missing commit body.** No description of what the hardw=
are configuration updates entail.

This is a very large patch touching multiple 8125 variants (8125A, 8125B, 8=
125BP, 8125CP, 8125D). The MCU firmware blobs are significantly reworked. T=
he code structure follows existing patterns.

No correctness issues found.

---

## Patch 09/12: net/r8169: add support for RTL9151

**Warning =E2=80=94 Missing commit body.** No description of the RTL9151 ch=
ip.

**Info =E2=80=94 New files created with correct SPDX headers.**

**Info =E2=80=94 Refactoring in `rtl_is_adv_eee_enabled` and `rtl_powerdown=
_pll`.** Similar to patch 3, range checks are replaced with `rtl_is_8125()`=
 helper calls. Good simplification that automatically covers new chip varia=
nts.

**Warning =E2=80=94 Missing release notes.** Adding a new driver/device (RT=
L9151) should have a corresponding release notes entry.

No correctness issues found.

---

## Patch 10/12: net/r8169: add support for RTL8125K

**Warning =E2=80=94 Missing commit body.**

**Warning =E2=80=94 Missing release notes for new device support.**

**Info =E2=80=94 `hw_mac_mcu_config_8125d` adds a `default: break;` case.**=
 This is good defensive coding for CFG_METHOD_61 which doesn't need MAC MCU=
 patch code.

No correctness issues.

---

## Patch 11/12: net/r8169: fix one bug about RTL8168KB

**Warning =E2=80=94 Vague commit message.** "fix one bug about RTL8168KB" d=
oesn't describe what the bug is. The patch removes RTL8168KB from a switch-=
case that presumably controlled some link setup behavior. The commit should=
 explain what was wrong and why removing RTL8168KB from this list fixes it.=
 Should include a `Fixes:` tag.

No correctness issues with the change itself.

---

## Patch 12/12: net/r8169: ensure the old mapping is used

**Warning =E2=80=94 Vague commit message.** "ensure the old mapping is used=
" doesn't explain what mapping, why the old one is preferred, or what goes =
wrong without this change. The register write clears BIT_0 of `INT_CFG0_812=
5`. Should include a `Fixes:` tag if this addresses a regression.

No correctness issues with the change itself.

---

## Series-Wide Issues

**Warning =E2=80=94 Multiple patches lack commit message bodies.** Patches =
1, 3, 4, 7, 8, 9, 10 have no commit body text (just Signed-off-by). DPDK gu=
idelines require a description of the change.

**Warning =E2=80=94 Patches 1 and 11 are bugfixes without `Fixes:` tags.** =
Both should reference the original commit that introduced the bug, and incl=
ude `Cc: stable@dpdk.org`.

**Warning =E2=80=94 No release notes update.** Patches 9 and 10 add new dev=
ice support (RTL9151A, RTL8125K) which should be mentioned in release notes.
