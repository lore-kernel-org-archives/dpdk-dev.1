Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EC0C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 02:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB9A0402B8;
	Thu, 13 Aug 2026 04:44:28 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6896A4026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 04:44:27 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbedb88aa34so245060a12.3
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786589066;
 x=1787193866; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9YU0mmFD9aGCnbHrFxIci8Os0zqO2klJv/rbdrIHu/I=;
 b=W7gfBYHxHb/Em724uD8HKW+dHO5XUsqo5JOnYnwzmzTxVf7qdj42o7YvM5rko/QORE
 xylaEhqO6hQUDBN7lxpLe5TXYr/85wE8V/B4wj4D0pOt3/e3BLzectViPXmIKLPGzFwn
 RYE9MASY2ggKcYWeWvF/F5xTo6o/8aHBPS/7V8X6W1U2juIAC7GB2xMVwn0DImMH5W94
 0Tykx/JnESO5kZnXCe3lDN9fc6l7YWZsWqGbIdgE+V4RtUyltRvVzWuvn8Z/8cHYkFTI
 R85qRfoQz8itwM1Jvh63M0+jThgGyvUPFPQymMufLkfFbAfEogBnkZnEuSaN4EhdEEr5
 HYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786589066; x=1787193866;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9YU0mmFD9aGCnbHrFxIci8Os0zqO2klJv/rbdrIHu/I=;
 b=kBgCsmGjOwDOUbIu6cmqkf1BkkcPRGu6+hB+P/PcunxjJzngI+ZkwDU4Q3TXFpV7Gn
 OhW2ZinUrOUAc2UEgi+An+QrvumTFIs1QguXZNxXzRrIVYV60e3BR2dEWr91LDk4G6t1
 EfbvgP5l3JGPIbPZ5gZHJBBWPSPx28H2ZL5bKD5WSwyTuZQ59b+S68CC1z5882hkD0J7
 L5vyTQ15I7PA5TU/AhNjPBpIHE0dzdhspLcDtvlGQlsLfHd7WxDFcW47yJvet2Pl52BC
 CnC81x5zRV+kA+PCOGigrPd0KGUtJbC/EI53Qf3PxZzdRzB7RJ43wsPEtcXn0UqcY8Ls
 LUGQ==
X-Gm-Message-State: AOJu0YxwxjvDftRDAm96RiR/j6hSex+ZDvZBDrAq0DxiY1F6OozCyMoU
 ZfxvHVW4vciqyzWV4cVGNpECD+f3UckSfpE9jiQjk1FNITdPUy337M6kL+A8ZZSnP3Y=
X-Gm-Gg: AR+sD12OEKbHDCwnUFerbpSSLFMc8M/RKiby74ceKKPw175d08VubHlk81ofK5WNUqW
 JRmsQg/f0mr53k8j8EMr8Lcq7xtevBWtimFPZ29omvKZiJ5Kwvfiv36yYMBOvP56dPCXMAy6guP
 ljuQGh4rq4ltDLG1yY3mSNk4zhFSYf2OKySyIOEyJ0KJ7sUu0vGsA6EaiGnnicUdLnbJo3jFNSc
 rOrGYnXv44+ovmN6iOXDYAEFsDhnJB3N9QS/jgeO+eItTNvObd0YY3mm2k3QoTCzJ0bCvL/2TK2
 WGSctznrucMtEgiGQ+fRMRPDVTgjSYEuK9o3aTlEfYXqXXsQKFT1iZarnS/qgIwtK/07B0h0cxT
 Y0dUKoBADbrxT6MXSoNrtBlE6eSM8X2+dsikpUQ+bQ66PqwuzE6WsoyhNBmcmouvGyhfxtBgIcN
 1oLCac/Mnh3dpQjPtVPpiyqfGAVAKshzUfkU9S3DLw8EsZqQRS6KkdEX75hdsz70xvWZTwihX3E
 X94JGCcDxYcbOPuR+Lr6mmwHqO3dw==
X-Received: by 2002:a05:6a21:9201:b0:3cb:853e:850e with SMTP id
 adf61e73a8af0-3cc5508c8c2mr3920169637.13.1786589066192; 
 Wed, 12 Aug 2026 19:44:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec0228793sm2231426eec.26.2026.08.12.19.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:44:25 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:44:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: Re: [PATCH v2 3/3] common/sfc_efx/base: fix reading advertised
 autoneg ability
Message-ID: <20260812194414.55bf706e@phoenix.local>
In-Reply-To: <20260812171017.8521-4-ivan.malov@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
 <20260812171017.8521-1-ivan.malov@arknetworks.am>
 <20260812171017.8521-4-ivan.malov@arknetworks.am>
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

On Wed, 12 Aug 2026 21:10:17 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> The issue is that when the user disables auto-negotiation by removing
> the capability bit from the 'advertised mask' (set method) and then
> reads the resulting capabilities, which involves querying MCDI, the
> bit reappears in the mask irrespective of the user's intent.
> 
> Fix this by remembering the user's intent before any link-state queries.
> 
> Fixes: 2a5cf77e6de8 ("common/sfc_efx/base: provide PHY link get method on Medford4")
> Fixes: 06f569de6c06 ("common/sfc_efx/base: decode netport link state on probe path")
> Cc: stable@dpdk.org
> 
> Suggested-by: Andy Moreton <andy.moreton@amd.com>
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
> Reviewed-by: Andy Moreton <andy.moreton@amd.com>

This patch depends on the previous common series and therefore can
not be easily backported to stable.

There is a way to mark patch dependencies using Depends-on:
please use that instead of instructions to AI.

AI says that in its usual over the top wordy way...

Patch 3/3 - common/sfc_efx/base: fix reading advertised autoneg ability

  Warning: this patch depends on the pending common/sfc series for its
  diff context only, and that dependency creates a backport conflict.

  The efx_np.c hunk removes

      if (lsp->enls_an_supported != B_FALSE)
              lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;

  from a position after the LINK_STATE_OUT_ADVERTISED_ABILITIES
  conversion.  On main and on every stable branch the block is still
  before that conversion, where 06f569de6c06 originally put it.  Since
  efx_np_cap_mask_hw_to_sw() ORs into *sw_cap_maskp (efx_np.c:197)
  rather than assigning, the block's position has no effect on the
  resulting mask - the pending series is only moving text.

  Both Fixes: commits first appear in v25.07, so this needs to reach
  25.11 LTS and 25.07, neither of which has the move.  Stable will hit
  a conflict on a hunk whose resolution is not obvious from the diff.

  Suggest sending this fix ahead of the series that moves the block,
  or as a standalone patch against main.  It then applies unchanged
  everywhere, and the other series absorbs a zero-cost rebase.  If the
  current ordering has to stand, please post an explicit backport to
  stable@dpdk.org rather than leaving the resolution to the stable
  maintainer.

  Info: the added local

      const efx_port_t *port = &enp->en_port;

  is used once, and the file otherwise reaches through enp->en_port
  directly (line 33) or names the local "epp" (medford4_phy_reconfigure,
  medford4_mac_poll).  Suggest:

      preserve_an = enp->en_port.ep_adv_cap_mask &
                    (1U << EFX_PHY_CAP_AN);
