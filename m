Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B49E9D82F
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 03:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A234026D;
	Mon,  6 Apr 2026 05:37:48 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 40B4840265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 05:37:47 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so2589455b3a.3
 for <dev@dpdk.org>; Sun, 05 Apr 2026 20:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775446666;
 x=1776051466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nofEexM1teS6pMvy9455GfoUx7R5GFPG4+9PQLfQfWo=;
 b=tKYomAA5LB7/5Uk3xY3bJHaeFOWPJk/3TzxfDPrqRL0ZAPPKUuG3eLIe6CLNsntdoT
 xaz1jh8yIOCKpoPXWnu/1OhEqcQjdfUUtmSqin4AlhP814KiR0GEou3yn6T87hwhaItQ
 mLIg5Vn2neZHhrqi5q1Oe3ZLeX8f7pJEdWWYVVwekWCkTHcgP4TpwFhE+17BDGY1IH6W
 vd6j3arLy0yv2dhm7wDL6fAeudZyJ2DjxlOShO8lUCA7bd1bD4tPHNMjkUAHxVKHpObl
 QcPWz19dffTgHbhuLhSY+fzxvJqCJKChpjdoY3C+oiVpsHnYKPnC0L8+WmFYGIWhBJRJ
 lX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775446666; x=1776051466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nofEexM1teS6pMvy9455GfoUx7R5GFPG4+9PQLfQfWo=;
 b=tTSCaBUnSXuuHwpCqKil44d8ENpV/6yTIrnFOSZEmQPStXTp/6cN5Jt/lFtEnBHsjz
 SBzgUHsYOULJOOyanV7WDpLT/yUBI3JWqo3R6FJtW1rKkg63DM3pAex/VKqq9CrDdqVr
 uhJdb1d7X4zhZXEvMzaSaRie91xJ0zsQpLJQ4QfPVsAOb96bZxUTZ4fcms1LHA7TtB3L
 0L/2Y6SIYFApfVLdolEc57BVUnn/AIVMBZrsBxEbcwMltC3i8FQtrBPYDxA95NzZ1sVa
 mzfIn08MrljNApxpw4zkTAiXrkO6wfME23M0In0hsvahSFKpApNeiTtoImdj8EhMw8Kf
 oG2Q==
X-Gm-Message-State: AOJu0YzWOr9fYxUel+Iav7f1S3YArnrCyZ3lHoqX6/vlqJOtI/mEoJq/
 F3lZQrp7nZO5RMVm1Ua0Aq4gdj56UrPgRsgw4S8Zl0mRzmynHlX91I2te27JlGHsEBs=
X-Gm-Gg: AeBDiesOM+7frzR+djFAfq1OkrqWP5isU7GQeEmfdw42o/3hOfa5F7zoEqYkQYMg5Ge
 st0Zsja01ifTprK4Jm0eO5ieMEUuBbae0PpeCrOJ8EVl8wzlDz6JPszecxQm7PhlTm10WZxwesi
 Q80WtKVRiuo6f9KwpBJQDaNinZUXrL0FEPdSIxw9jOagZDzMqrshrd7kdJPHVGPztfcH8CGZl6B
 s8uwh0KKxpo4NhtqC63cV3uIi8cWGdywmVT7BnkL5NkcAPlIwTPI1Mwon6Mc6nZR6rpsjttqVYI
 Gt2oLENCti7xbGO0NFC2/mEEuLJaCsPjCZFEniB/BpZDwWJ91qkdhVle3pVSmiWpWSXmqIghRfH
 SLxS27DUf4MHdV/Vxy4Ns6QFP40STRuEqrGI4oF+4Pj6+NcMctTy6BBJeyjxXnvYRxM3rlH5TpY
 CXtzSO6E8BsIwY/7kpUSzC0yhbQdVj8FQS5vs=
X-Received: by 2002:a05:6a20:9192:b0:398:759d:23e with SMTP id
 adf61e73a8af0-39f2efaf81dmr10987052637.32.1775446666114; 
 Sun, 05 Apr 2026 20:37:46 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b23c6asm16133035b3a.10.2026.04.05.20.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 20:37:45 -0700 (PDT)
Date: Sun, 5 Apr 2026 12:57:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v3] net/axgbe: mask unsupported PHY half-duplex modes
Message-ID: <20260405125722.5b936678@phoenix.local>
In-Reply-To: <20260402065450.1074-1-ashokkumar.natarajan@amd.com>
References: <20260401075831.568-1-ashokkumar.natarajan@amd.com>
 <20260402065450.1074-1-ashokkumar.natarajan@amd.com>
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
Message-ID: <20260405195722.a-yN6lD0q76f4f_C0w1SNjy191jmWhjLPxUaXA0Vzgo@z>

On Thu, 2 Apr 2026 12:24:49 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> The AXGBE MAC supports only full-duplex operation at all speeds.
> However, the PHY auto-negotiation configuration could advertise
> half-duplex modes, including 10BASE-T, 100BASE-TX, and 1000BASE-T,
> which are not supported by the MAC.
> 
> Update the Clause 22 and Clause 40 PHY advertisement handling to mask
> all half-duplex modes while preserving existing PHY, strap, and
> vendor-specific configuration using read-modify-write.
> 
> To maintain backward compatibility, full-duplex advertisement for
> 10/100 and 1000BASE-T is preserved by default when no explicit PHY
> advertising mask is provided.
> 
> This ensures IEEE 802.3 compliant PHY advertisement while avoiding
> regressions on platforms relying on PHY default configuration.
> 
> Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
> ---

AI review noticed possible issues with thsi.
Which may be an issue, or false positive.



> The AXGBE MAC supports only full-duplex operation at all speeds.
> However, the PHY auto-negotiation configuration could advertise
> half-duplex modes, including 10BASE-T, 100BASE-TX, and 1000BASE-T,
> which are not supported by the MAC.
> 
> Update the Clause 22 and Clause 40 PHY advertisement handling to mask
> all half-duplex modes while preserving existing PHY, strap, and
> vendor-specific configuration using read-modify-write.

The read-modify-write approach is good, and the Clause 22 / Clause 40
separation is clean.

> +	if (!adv) {
> +		advert |= ADVERTISE_10FULL | ADVERTISE_100FULL;
> +	} else {

The original code unconditionally sets ADVERTISE_PAUSE_CAP:

	advert |= ADVERTISE_FULL;
	advert |= ADVERTISE_PAUSE_CAP;

In the legacy path (adv == 0), the new code advertises 10/100 full-duplex
but drops pause advertisement. This is a behavioral regression for
platforms relying on the default configuration -- exactly the scenario the
commit message says should avoid regressions. The !adv block should also
set ADVERTISE_PAUSE_CAP to match the old behavior.

> +#define AXGBE_PHY_MII_CTRL1000_1000T_FULL	0x0200
> +#define AXGBE_PHY_MII_CTRL1000_1000T_HALF	0x0100

These are standard IEEE 802.3 Clause 40 bits. Since axgbe_phy.h already
mirrors the Linux MII defines for Clause 22, consider adding these as
ADVERTISE_1000FULL / ADVERTISE_1000HALF in the existing MII section for
consistency rather than under the M88E1512-specific block.

