Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2486ACA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 16:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26C244281D;
	Wed, 30 Sep 2026 18:27:35 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 3CDFF402D9
 for <dev@dpdk.org>; Wed, 30 Sep 2026 18:27:34 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso2860884b3a.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790785653;
 x=1791390453; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=80LJEecIglUg8riJiKJAxzdmCMwKPK7gcLlNsXsiMdo=;
 b=uF4UG1NZ5F44KxbrD9GVOkagf+R+CnysEAJ/et9HiCZsZ9sfRl7BH1xoNQxGSgErv2
 MsNp4CY6JvjYzorer5C2OWE/bA6p5MtEwfQfmIWbkvgYIrWgzLVsYvHk/uhteXTuOHCv
 Fr2I6YNO7sKJ/bMQBOkmFaCePtkG2u/FquCEdIoAcbFQkb/HBFpSmi1So0eqKCBXVlWb
 epfbK/PWCAJjaEEOYDbEnUKeHW0noDZIQ3jmRp+R9L+zmvHfW4jyOE0YXbWn/lKUDPEx
 3O2mikZmNVX3sD0MXhNuRfP6TVmu5XRyUfFmYfoE8G0ChyUl42JACrHq+y58QpfBMWMR
 +tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790785653; x=1791390453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=80LJEecIglUg8riJiKJAxzdmCMwKPK7gcLlNsXsiMdo=;
 b=k+Q3nwXg3sSIEOdhyLzmBcAunaSNZy39pwoIsQfeMlTnte2s6Es8kh4aFzBUtaX3+X
 3o//2LXur00zeGRWMF5tkB4pE/Bbdq4/fm97DqocEfrt1tDwyaDkBSdTHeHWMCPiEK4h
 JFG+aab6sQiBl3mHE3Lzr6NlJvhIFmsNLT95kzq/lCrB94cEMWQtazlMeq0F+jPsO1Dg
 iXlZ0T8Nb6gk4crbynMz1vD1yEAahjk1fJMXZuuGCeGItQrrQ1vPD8hq/n5LoZ9v1mx+
 jwkFnUbDcV6DZCIUZcelUmnjYoxwd7lUbbLZAjZTSNtoEJKK5TwufcMt0D+aWd7HhqJo
 mmkg==
X-Gm-Message-State: AFuF++mmWfJyyWnucC0ss4MHRU+GSjrZp5fFO9b/mzUp1aVz/VT8IPUB
 jAen4qEQi7c885S7wCvZAtztbQnEGYliXbPmOfLsyomjEM89lYrgamMJivt1z9i1gqA=
X-Gm-Gg: AYBFou3Uf+W7LjtcgScyNaKte6B0sK5gNro2HHBlvjGD8UKNPFvhERiuRqZhBk4Kf4G
 oNKbdKy5G/fSn7+11OCw1eqZLDorET/LZWKjoGhQK8v1w7Tg5k3LoehpOq/LVFQpU6aXpkso5KL
 LEuztEAfAOtQutaseuwSIbLCdiJTXLcauQ4tkzlUR3EoZmtAYYA5wi1Gi2qo73h0Mf8w254xZ8S
 0PNKFBsCE0DN0z89GY9qpDvGD/Ab4BGFeXFdhWBwsKpJY0lLmvxnmYc2ddPSx+dFYcwdOJpeGJj
 Dgi8vPP8YfHECCehtRz3WyWtCZvfBzB2umOdy/VCAREtgfHh5HRpzH0dvK03VGAT4YnPmeBZacw
 yRZERZNm58RIjUWCx8C+I1ZaslebjSghbakGd9EDWSHWWuPWMvzSHny62gD+R0aWQF29ZntvmbI
 /ZFo93MEtVOtErpQaWyCsxTo+SmxWNTjeAZnv1Ay5Ivyueoay8z4OMFD721qHVoi+KbN0F2BPVm
 ef4S0Ouv4GQMgo7RZb1JYuMrrE/p7LgFCXii7BM
X-Received: by 2002:a05:6a00:ad03:b0:851:8bde:7873 with SMTP id
 d2e1a72fcca58-887477b0923mr1605855b3a.8.1790785653332; 
 Wed, 30 Sep 2026 09:27:33 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-887bc2bd404sm555303b3a.46.2026.09.30.09.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:27:33 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:27:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 0/2] ethdev: fix SFF-8472 external Rx power calibration
Message-ID: <20260930092731.444636b0@phoenix.local>
In-Reply-To: <20260929172210.1212967-1-roma55592@yandex.ru>
References: <20260929172210.1212967-1-roma55592@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 29 Sep 2026 19:22:08 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> The SFF-8472 decoder does not apply the external Rx power calibration
> as defined by the specification: the fourth order polynomial is reduced
> to RX_PWR(0) + x * (RX_PWR(1) + RX_PWR(2) + RX_PWR(3)) and RX_PWR(4)
> is never used. The code came from ethtool sfpdiag.c.
> 
> This was pointed out by Stephen during the review of the module EEPROM
> decoding series; this series is based on it (dpdk-next-net).
> 
> Patch 1 fixes the formula and is intended for stable.
> It also clamps the result to the 16-bit range, as the polynomial
> easily overflows it with unexpected coefficients and converting
> an out of range double to an integer is undefined behavior.
> Patch 2 adds a unit test with all coefficients set.
> 
> Note: the calibration formula 1 (Tx bias, Tx power, temperature,
> voltage) has the same out of range conversion issue; it is left
> for a separate patch.
> 
> Depends-on: series-39436 ("ethdev: add API to decode module EEPROM")
> 
> Roman Khromenok (2):
>   ethdev: fix SFF-8472 external Rx power calibration
>   test: check SFF-8472 external Rx power calibration
> 
>  app/test/test_ethdev_module_eeprom.c | 37 ++++++++++++++++++++++++++++
>  lib/ethdev/sff_8472.c                | 27 +++++++++++++-------
>  2 files changed, 55 insertions(+), 9 deletions(-)
> 

Looks ok as is, applied to next-net.

Detailed AI review had a bunch of feedback about range checking.

Review: [PATCH 0/2] ethdev: fix SFF-8472 external Rx power calibration

Patch 1 applies to main on its own and builds with -Dwerror=true, so
it backports as is. Patch 2 needs test_ethdev_module_eeprom.c from
the module EEPROM decoding API series.

The test input decodes to "0.1560 mW / -8.07 dBm" with the fix and
"0.0017 mW / -27.70 dBm" without it, so the test catches the bug.


Patch 1/2 ethdev: fix SFF-8472 external Rx power calibration

Info
- The final conversion truncates:

      sd->rx_power[i] = rx_power;

  Coefficients that are not exact in binary land just below the
  integer. RX_PWR(1) = 0.7 is stored as 0.69999999, so x = 1000
  decodes to 699 (0.0699 mW) instead of 700. rx_power is known
  positive in that branch, so round instead:

      sd->rx_power[i] = rx_power + 0.5;

  The UINT16_MAX check still holds, anything below 65535 rounds to
  at most 65535.

- Pre-existing, not introduced by this patch: formula 1 just above
  has the same out of range float to integer conversion the commit
  message describes.

      sd->bias_cur[i]    *= A2_OFFSET_TO_SLP(SFF_A2_CAL_TXI_SLP);

  The slope is a double up to 255.996, so a large reading leaves
  the uint16_t range. Same for tx_power and sfp_voltage, and for
  sfp_temp (int16_t) in both directions. Worth a follow up patch
  with the same clamping.


Patch 2/2 test: check SFF-8472 external Rx power calibration

Info
- The test covers the polynomial but neither clamp branch. Two more
  cases would cover them:

    x = 10, RX_PWR(1) = -1.0     -> "0.0000 mW / -inf dBm"
    x = 65535, RX_PWR(4) = 1.0   -> "6.5535 mW / 8.16 dBm"

