Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3B8E9D800
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 20:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA9140285;
	Sun,  5 Apr 2026 22:07:43 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 1168040265
 for <dev@dpdk.org>; Sun,  5 Apr 2026 22:07:40 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso1579868a91.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775419659;
 x=1776024459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nofEexM1teS6pMvy9455GfoUx7R5GFPG4+9PQLfQfWo=;
 b=EeoCvpaeivYhyJ+rQTqbrXvSdSMNgoKtXhq6beWpiXe++JUpEL8XIvQFXCmHhbNu1e
 jG6wytchnsdffxYhc30Qc3gO+vxW2HWfBngwJ8lPR7Qu/QsencLxK7YbEPxPfqer0cZx
 lNSNp4KVmbTuZP8IxBcfQBIuGgI9B3dqbkQ/FmrfALUb6lW4M1bViE1y7iauWn1szMsi
 2O+MUBYjVPB8cxBGb5VNvfUQKC+FV11kwgHXoSRF541u/KfPgGf0T7KWy4gJMH8kO1VJ
 6j2/xNd+tWH2wruEYu+cIVezxoY/wyF/ZxSzDTZxmCb+2kVCA4Wuyxj6TKIgymk2vR29
 2qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775419659; x=1776024459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nofEexM1teS6pMvy9455GfoUx7R5GFPG4+9PQLfQfWo=;
 b=Emwq8Yq5pOrz/NiKN7YD3Sj24WjxKCFGwdpV9MnP55kHJxOuUGcE85wh9eOg17x52o
 V8Y2L//7LRPKipyJi/VAw+h98cSU4ao2Qk+CjCLOoLT/xS0Sy7XgUznWq/W/8jmc5dxY
 nMI+d/i0gqllN8LYNNjflXKFDKK5R6W0qX7nMy5pF90wN4NFDI8Jcz0t3v/6mOsCbxEv
 i50OzoMux7FM1gLqmGeSDe4lJG87nBEcFW6+q443iLDrT8+qnDWUjXubQY9Voozchj9q
 ix4KgxsH2cZGQg+RqDhr4p+HgkZkCHIstc5B1l4Vyg6dyxr6zpH1IKXVnc9HUlows/L8
 4EjQ==
X-Gm-Message-State: AOJu0YzuDHoW7xkGUoqnoNL5F1dXcwt+FVFDem2SxyGrjj7a3eUceemJ
 Qq/mlp0vQJZDyaJ9hCr10sPf9CVo9wB7qs1IRgJw6ej+uWqEBue4282Cho57wman9Ms=
X-Gm-Gg: AeBDievMB2uapnb1zyrdYwCos/cUwxlzf24bTzUXSUCXUU/Syxn+75ZvoE+vm+pNKbh
 Gx4xJ4MAMg3yvGoPOM6xoq4qnkV+IKgNi4qSh2V1My/p/iqjiFlv5U0ZIYtAUu+Ic1lu0BRMnUQ
 QVr7lc9bkIMlGAoAUqjIMqP7QI9ej6+AODQEXhZkROF9wWLu/5hXDRmI6SSRSmGUikwvwwz8AGW
 0gFFx1PlspifAK1xBzyNYk8grHAyjcuumHYJ2nbwcY4O22yZrQzwhtFrqA6K+oX3RsyooYNqFRs
 EXXM3O3ELHU7s2wBfPbSVOTlAPZzINM/Xz6sOjSCJ7uDdmw+KlHL4qNwHGfnJQPDtb6lqWuKIVv
 PxuyFMOoT0sYmmQHWYiYfn6SbZ2hlXia6C0+Y6jlWZS4P5nkeqGr1BJDJo5Kd9VG7UyPcxNPh1e
 TBh785qQ0MZ9rXKaM6v9Pn7Q3VkE8OdxsuIA0=
X-Received: by 2002:a17:903:17cb:b0:2b2:5a5a:4f2d with SMTP id
 d9443c01a7336-2b28176a472mr110716755ad.31.1775419658928; 
 Sun, 05 Apr 2026 13:07:38 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472d5e5sm142213235ad.15.2026.04.05.13.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 13:07:38 -0700 (PDT)
Date: Sun, 5 Apr 2026 13:07:30 -0700
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

