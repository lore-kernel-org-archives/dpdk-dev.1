Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E25AD46BE5
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2DA44026F;
	Wed, 28 Jan 2026 18:52:36 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 707894003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:52:35 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so122883f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769622755;
 x=1770227555; darn=dpdk.org; 
 h=mime-version:content-transfer-encoding:references:in-reply-to
 :subject:to:from:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=0bkj4HwH27cJyrtPsgVwKS1LwlMu1Bq0NPY63D9/cU4=;
 b=C4OE+c25SUnbWlCDZwal0e24bzNA82JOnLC7W+ttpxkFnmrk4qUTQsG6EZmr3sPDMt
 KsBv0jkdsTGyk5lUBEwyX+kxslrRY8dWQG5yQ0qt21Rd9AANaYCJsSUPLkyjq3D9yIvs
 wWcj7GSI75rWJmUsWHEdqJ4Br3BlUxKwgQ/xqB7qsL+++pAEIk+XGTdbMz9mOQde6WYh
 wjeGmJ9q1d9F/w5wwPyttSahoeVEEtXkJ1pzyUlnFmdNm+3JJLZVkM9ARGMqaUGJ1V4M
 M6QF3z4th6OeuJz7yrngflA0tAumZvPRnXpy7QsFy6qdvQOH1cwqpc4PMGpLWs6SEMsh
 72ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769622755; x=1770227555;
 h=mime-version:content-transfer-encoding:references:in-reply-to
 :subject:to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0bkj4HwH27cJyrtPsgVwKS1LwlMu1Bq0NPY63D9/cU4=;
 b=Tso9JSliXOavO3w8x3nwz0+TxfQw2+rxwFl44TKvHeogXCn9ZFmnH+vQt4xr0Jlvn8
 5K9zqncnu8Vqaz/PZEKa9CysjGrFDGSOt5RMBf80XtW530hy553+gjVD3MtKp7YCRu+v
 I9ERTvobUvBoUxs4ZmloR7nIgnLmE1nJvxJED0Xq4wNVvvptQ/faRkmalol1UyjF3WIs
 qX3FZYIwP/ZD0dYb+pqIFwP+KmEcLdcxUcKwaPVKYDQ9rPJcRsNDecJ4wfizFO2JpQjX
 YoMINZWln1erKSw49Ff7/1d86vTMgqxTDzMTSgqBK8b0oozfd15LG2jLpPmlSPZbdHyS
 +4JA==
X-Gm-Message-State: AOJu0YycQ4WLIAcVNx8HaFgt0sy71wBfRUi/HQiIYKEGlHbfAXyXUAoD
 7oW9cKZM39fV0i4YP64Iu02MDh3b27JPEjzpIvHGoAjv4TcY/AUpe99mAczjw3IUO1Lu+mLi8nJ
 +fm9g
X-Gm-Gg: AZuq6aI0J1lynEXhdXBUVU6JQukYE2TFvx+qX+bUNwOUG89/RL2aHv1X6vfxue/3U6u
 y2aJasLVCw8zCb5XCjDV8Cr0mFo/cn4tX6FpBPR68gsc4i60FpEVXbDzETwRSw7FeyHneYecz7w
 67f0swmxVyplIH1/XuEzbnSywBGfQRGumKK10OLHiff9qhCzmcgNrOzflR2WTedoCHvXu+vJgCF
 KJwUXNdMflxIrKp0Y2GXV5Ltmooj12Z/pRkNkHPlsmc+Mc8KU0ThE652bPMEU/Jw0pmJaOYC6XU
 ESZnVc8rlGl/aOhhrcsuGz6VV2fH3DfaJotSkV1mUPMyjOGN4JMHUai4stcYH6DXLpYomzX+hPf
 6YvC8sVL41pQM29WJb7ld4W3+9jKEgydGBTbjtTteD0xR2N1uGMs0cX1sQyJYz4QdqJRnCBZOmq
 IfIaiUYTo2MpUZGwQDEklhAY1pFnf6nvApPWjMs8NHqmCMS5XAoXaV
X-Received: by 2002:a05:6000:2410:b0:435:a2f8:1536 with SMTP id
 ffacd0b85a97d-435dd1c0ca3mr8693194f8f.43.1769622754829; 
 Wed, 28 Jan 2026 09:52:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e476dsm8898944f8f.4.2026.01.28.09.52.33
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:52:34 -0800 (PST)
Message-ID: <697a4ce2.df0a0220.a9380.da00@mx.google.com>
Date: Wed, 28 Jan 2026 09:52:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: [REVIEW] common/cnxk: fix duplicate branch compiler warning
In-Reply-To: <20260128060316.3967610-18-rbhansali@marvell.com>
References: <20260128060316.3967610-18-rbhansali@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

AI-generated review of bundle-1704-common-cnxk.mbox
Reviewed using Claude (claude-opus-4-5-20251101)

This is an automated review. Please verify all suggestions.

---

# DPDK Patch Review: bundle-1704-common-cnxk.mbox

## Overview
This is a patch series of 18 patches for DPDK common/cnxk and net/cnxk driver=
s, primarily dealing with inline IPsec improvements for CN20K platform.

---

## Patch 1/18: common/cnxk: fix engine capabilities fetch logic

### Commit Message
**Warning**: The commit message body lacks detail. The description "This patc=
h fixes the same" is vague and should explain what the actual fix is.

**Info**: The `Fixes:` tag is correctly formatted with 12-character SHA.

### Code Review
**Error**: In `cnxk_security.c`, lines 1400 and 1409 - The change from `ROC_I=
E_OT_SA_LIFE_UNIT_*` to `ROC_IE_OW_SA_LIFE_UNIT_*` macros appears correct for=
 the OW (cn20k) context.

**Error**: In `roc_nix_inl.c`, line 1231 - The loop condition change from `wh=
ile (lmt_status !=3D 0)` to `while (lmt_status =3D=3D 0)` is a significant lo=
gic change. The commit message should explain why the previous condition was =
wrong (it was causing an infinite loop as stated).

---

## Patch 2/18: common/cnxk: remove dependency on cryptodev for RXC

### Commit Message
**Info**: Good descriptive subject line.

### Code Review
**Info**: The code correctly moves the cryptodev check inside the `roc_model_=
is_cn10k()` block, allowing cn20k to proceed without this dependency.

---

## Patch 3/18: common/cnxk: support inbound pdb configuration

### Commit Message
**Info**: Subject and body are acceptable.

### Code Review
**Info**: Simple addition of `pdb_ena` field usage in mbox configuration.

---

## Patch 4/18: common/cnxk: update CPT RXC structures

### Commit Message
**Warning**: The subject says "update" but should be more specific about what=
 was updated (byte order/endianness handling).

### Code Review
**Info**: The structures are being reorganized with proper unions for differe=
nt platforms (cn10k vs generic). The byte order appears to be reversed in the=
 new `cpt_frag_info_s` compared to `cpt_cn10k_frag_info_s`.

---

## Patch 5/18: common/cnxk: update inline profile ID for cn20k

### Commit Message
**Info**: Acceptable.

### Code Review
**Info**: Correctly adds cn20k-specific profile ID handling.

---

## Patch 6/18: common/cnxk: update inline RQ mask

### Commit Message
**Info**: Acceptable.

### Code Review
**Warning**: Significant code removal - the `nix_inl_rq_mask_cfg` function re=
moves the SPB setup via `nix_rx_inl_lf_cfg` mbox call. This should be validat=
ed that it's not needed for cn20k.

---

## Patch 7/18: net/cnxk: avoid security flag for custom inbound SA

### Commit Message
**Info**: Good descriptive subject.

### Code Review
**Info**: Simple conditional change that looks correct.

---

## Patch 8/18: net/cnxk: add CPT code check for soft expiry

### Commit Message
**Info**: Acceptable.

### Code Review
**Info**: Adding `ROC_IE_OW_UCC_SUCCESS_SA_SOFTEXP_AGAIN` case is a valid add=
ition.

---

## Patch 9/18: net/cnxk: skip write SA for cn20k

### Commit Message
**Info**: Acceptable but could explain why write SA should be skipped.

### Code Review
**Info**: Simple flag change.

---

## Patch 10/18: net/cnxk: update NIX reassembly fast path

### Commit Message
**Info**: Acceptable.

### Code Review
**Warning**: The function `nix_cqe_xtract_mseg` now has an `#if defined(RTE_A=
RCH_ARM64)` guard with an empty stub for non-ARM64. This may break functional=
ity on other architectures silently.

**Info**: The use of NEON intrinsics (`vreinterpret_u16_u64`, `vrev64_u16`, e=
tc.) is appropriate for ARM64 optimization.

---

## Patch 11/18: net/cnxk: update aura batch free

### Commit Message
**Info**: Subject could be more descriptive about what was updated (mask chan=
ge from 0x1 to 0x3).

### Code Review
**Info**: The mask change from `0x1` to `0x3` appears consistent across all o=
ccurrences.

---

## Patch 12/18: net/cnxk: update fastpath function for OOP

### Commit Message
**Info**: OOP should be expanded (Out-Of-Place) in the commit body for clarit=
y.

### Code Review
**Info**: Adds OOP (out-of-place) processing support. The `nix_sec_oop_proces=
s` function is well-implemented.

**Info**: The function correctly handles the alternate encrypted-decrypted po=
inter pattern in the gather list.

---

## Patch 13/18: event/cnxk: update fastpath function for OOP

### Commit Message
**Info**: Acceptable.

### Code Review
**Info**: Consistent OOP handling with the net/cnxk changes.

---

## Patch 14/18: common/cnxk: flow rule config for non-inplace

### Commit Message
**Info**: Acceptable.

### Code Review
**Info**: Adds `is_non_inp` flag handling in flow rules.

---

## Patch 15/18: net/cnxk: enable PDB in IPsec outbound path

### Commit Message
**Info**: PDB should be expanded in the commit body.

### Code Review
**Info**: Simple bit flag additions for PDB enablement.

---

## Patch 16/18: common/cnxk: initialize CPT LF for CQ config

### Commit Message
**Info**: Acceptable.

### Code Review
**Info**: Properly initializes CPT LF for CQ configurations with appropriate =
cleanup in the error path and fini function.

---

## Patch 17/18: common/cnxk: fix CPT CQ roll over handling

### Commit Message
**Info**: Good - includes proper `Fixes:` tag.

### Code Review
**Info**: The fix correctly handles ring rollover by tracking `cq_head` separ=
ately and using modulo arithmetic.

**Warning**: Line 102-103 adds error logging with `plt_err` but this could be=
 noisy in production. Consider using `plt_warn` or adding rate limiting.

---

## Patch 18/18: common/cnxk: fix duplicate branch compiler warning

### Commit Message
**Info**: Good - includes Bugzilla ID and proper `Fixes:` tags.

### Code Review
**Info**: The `PLT_STATIC_ASSERT` additions verify that SA sizes are equal ac=
ross platforms, which justifies using a common macro.

**Warning**: In `roc_nix_priv.h`, lines 26 and 29 - changing integer division=
 to floating point division (`100` to `100.0`) changes the type of the result=
. Verify this doesn't cause issues with consumers of these macros.

```c
#define NIX_CQ_LBP_THRESH_FRAC_REF1	(80 * 16 / 100.0)
#define NIX_CQ_LBP_THRESH_FRAC	(75 * 16 / 100.0)
```

---

## General Issues Across All Patches

### License Compliance
**Info**: All modified files appear to have proper SPDX license identifiers a=
lready present.

### Missing Items
**Warning**: No release notes updates found in this patch series despite API/=
behavior changes. Consider adding entries to `doc/guides/rel_notes/`.

**Warning**: Several patches lack `Cc: stable@dpdk.org` tag despite being bug=
 fixes (patches 1, 17, 18).

### Coding Style
**Info**: Code generally follows DPDK coding standards with proper indentatio=
n and naming conventions.

---

## Summary

| Severity | Count |
|----------|-------|
| Error | 0 |
| Warning | 8 |
| Info | Multiple |

The patch series is generally well-structured. Main concerns are:
1. Missing `Cc: stable@dpdk.org` on fix patches
2. Missing release notes
3. Some commit messages could be more descriptive
4. Floating point division change in macros should be verified
