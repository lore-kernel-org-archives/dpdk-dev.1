Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9608C71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 16:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E972440287;
	Mon,  7 Jul 2025 18:41:51 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id EC39D4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 18:41:50 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so1834227b3a.3
 for <dev@dpdk.org>; Mon, 07 Jul 2025 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751906510;
 x=1752511310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08QNZD66oE1/6ahuCGTQlgUJdymdJF5huo7Ybl3yof4=;
 b=usfbU6MDlKtRlXCaU1I8gIZ4TsL8nALOy33MrrK7eOXpajQkxxtJeJjFQJfQhN7+wC
 iJibTRpkuwionKO2oH0woB9SmXmViG1qLWVUm3q+CLI6j94ZrCQkEqa9WF45Ar/StWeO
 veBZLRnn50xsSPJJKr0qRePU7ZvxNjfSNHf9IDPwiGIVRgWF12CyfK6Qn9LvDipWg5PW
 tXqGIle2zW//7Y8+aOftb9MBL68zZP1G4YZ0kD97L+NOzDoMs3QRcaW5BsBS2FkssWH2
 JsTR9dcoPTFPZlwA2F2SJbLECl5+Yp9REjrduxlxgP8KnbBYVws2HWUm5kcMljEtSJjJ
 zcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751906510; x=1752511310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08QNZD66oE1/6ahuCGTQlgUJdymdJF5huo7Ybl3yof4=;
 b=ODi2Rno9oh44QEl+5vaoyP8tPNW18baBnuOVVIb4M02gcrxC++c9nXM1x/HXQ1NSZK
 SHuP0kDSgAAmImuhy9xAdwT4K7VYuw2+sjv6+2go2ytUU/xJTocbPUi0maW1E57EKw2g
 D3gKXDWmvInFlQJosjrhQOuukJhxdHfPM2T33Ma674r8wT6c/wNDCX68kdnFAw5dpUBx
 lyaw4UnTKLOg2YMSDv5pTUhJPcmED2HvNkBkxiYOMIBb0XKg1sPI/uNyixQ3HZwLuICO
 pBdl0E4OTC4xsJ3jVpPh7TyWRJmm5GCzg4cpMK7Z/QGkTuPL07TKRG5Y3AV6f06mmhDZ
 8wSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHfK3Xeofjm4lNGCcr1VGDA243j2A4rfbCOayXfYUGo+1ajrHxUAd43BfwPV41ZuTq4zw=@dpdk.org
X-Gm-Message-State: AOJu0Yzg3lp4OeNb6g0ZLRqSjZfxNxoKwJuRXBP4QN/dmSEJnfmch4ZB
 hTgVaA4k3XJIxdBzhR7VAfS/vOq5+S5BGg977PFLpSA53wk89guSsYMPVw/87Vicm9Q=
X-Gm-Gg: ASbGnctLTKsPQaSwrVWKkPcyjHC4cPPAzeSZSNJq6V1KVvGDbERULCjqaUcID1qloq1
 N2KGtysLCJzDrD6iS8l/I6GAdF2mxBgfv3w3cXLbWfoqYd4hiCCtfTpjr1/XxNQsvbmK3pZqTt6
 SlZfmQh/uVukDjCcwmHJwkjG8YyTfzUOznvPrjht8dKBjklBfFvMBFqTW3rx/gK9QjSo2KRrzUp
 XcrYwYCvXnnJ5AClzNf61rHnPLLmtv8H1ENT9isC2Z2C1T1V4FFyd3tO3YF8T6FtN6GVM1fAUiZ
 b+bZVTBOcJJ12urlthFGOzBuO5s5xl3CJ1pqVy22WMFFrApYM3iZGoAePJ16EP2+Vq5G5+3oh8t
 DAItedwInB2p3jEeIgOheN+a0BTCZoqZhHTqGdJI=
X-Google-Smtp-Source: AGHT+IHcTpEiHz60mN3ri1NsrLvMlIkcvWcxpfheqyrXrW4EQ2ko9vo2GF9rtXrer2F5PRXrmShdng==
X-Received: by 2002:a05:6a00:2e91:b0:748:f1ba:9b0d with SMTP id
 d2e1a72fcca58-74ce8a8ddbbmr15705066b3a.11.1751906509830; 
 Mon, 07 Jul 2025 09:41:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74ce4180e47sm9723938b3a.103.2025.07.07.09.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 09:41:49 -0700 (PDT)
Date: Mon, 7 Jul 2025 09:41:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: madhuker.mythri@oracle.com
Cc: chas3@att.com, dev@dpdk.org, tomaszx.kulasek@intel.com
Subject: Re: [PATCH] net/bonding: avoid RSS reta update in flow-isolation mode
Message-ID: <20250707094147.6b33b994@hermes.local>
In-Reply-To: <20250704135031.5306-1-madhuker.mythri@oracle.com>
References: <20250704135031.5306-1-madhuker.mythri@oracle.com>
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

On Fri,  4 Jul 2025 19:20:31 +0530
madhuker.mythri@oracle.com wrote:

> From: Madhuker Mythri <madhuker.mythri@oracle.com>
> 
> In bonding PMD, member_start() function checks whether RSS(mq_mode) is
> enabled and then calling the RSS rte_eth_dev_rss_reta_update() API, which
> is returning error in-case of device configured in flow isolation-mode.
> When the device configured with flow isolation mode RSS reta update is not
> required and the API was not supported. For example in-case of mlx5 PMD,
> RSS reta update API was not supported, when the device is configured in
> flow isolation-mode.
> 
> So, added check to verify if the device is configured in flow-isolation
> mode, then do not call the rte_eth_dev_rss_reta_update() API.
> 
> Fixes: 734ce47f71e0 ("bonding: support RSS dynamic configuration")
> Cc: tomaszx.kulasek@intel.com
> 
> Signed-off-by: Madhuker Mythri <madhuker.mythri@oracle.com>

Applied to next-net.

Next time please use patch versions (ie [PATCH v2] etc) and thread
the followups to the original patch.

This is described in https://doc.dpdk.org/guides/contributing/patches.html#creating-patches

It helps tools like patchwork and with reviewers so that we know which
version supersedes.
