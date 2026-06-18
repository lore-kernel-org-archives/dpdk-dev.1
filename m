Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAEFCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 17:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AECA240DD1;
	Thu, 18 Jun 2026 19:25:55 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id B54444064F
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:25:52 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-30bcf74e617so2655435eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781803552;
 x=1782408352; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saGYhgWranWP60SGiNJ+PHZPjrhWVe5axe4LCjqZxK0=;
 b=NwkXidkF8oY3s2WXSG7gkny+Jk37HVdZ0Ey2tX1uhPOxBMbe7F5x9Lcnt9YvOhGbBf
 6PirrajJOKwiEUThhRaQrSqmI1YioWVGukiZKBhLFMFhMJgjNLXV2ZbzY3CZDZ9/eSvU
 36tsKW4ggkO0Ni4PXWVSsWspN9nhuzyEEXEnhVww7x5hvVZ/WlXQ/YLHpmSLxKCTvH2q
 2dvYHBhCmGcSfGE24DndtbG0dBnawZWMjBJzqntOgzz6bjYUOVYRk4553aBgQXFmTa5w
 D2DG+G7ni9n0Y1Cs8tTRVy20OlwrleqAqq3H+Ne4PuCrCrrIfZu+pzWLTXg+Cp44hHSZ
 Umog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781803552; x=1782408352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=saGYhgWranWP60SGiNJ+PHZPjrhWVe5axe4LCjqZxK0=;
 b=HEPatTUjeK0bPW1FWEplPHPRx375361RZDnbEtuSIgT73WuIUtvQz2oln2nAdML+mN
 gDRZrF6VmYeJp9qJ39DJF52Pp3IElzt3x/EbIkThlTeaJJ5UPvPyUqgG5L8F+bSHLd3t
 V1GFSDkEW3uYu93ciTJPyY1ysQKl3X5R+F3FhxPQeLMBaWr+yDtw3mq7FHqZZLfpMzNH
 Ln9+1MJHpPUpsU/o5tVUSXPlTh4hQrvr5TrhizHR8TlbKQ12urvPq4DDo91D1i4Xkj7J
 02MSOCTf1blTC/55oblGqDYXA8YUlQexApHD0tzTtSoENBUZixyYExDp9Q9dqo9WmwTy
 bb8A==
X-Gm-Message-State: AOJu0YwPh6ZCZa7sh/EHr+kM4VDolM0TSfr8bIg51+eo72NK9Z0sMHUv
 luZnCaFQAzh+DRQfxEJpXfeyDDPekGm9Gn3oMq18d6UOEiJvQiVSi0znneCja+qV2VS1CUD/ABd
 rQXCp
X-Gm-Gg: AfdE7ckuPdqoIkId/etlkX7G17rN8Aa6TqX4ujdgaDZ77L4q4fKG6QjEoG/0yRNZMg4
 LVpTo8KNT6/lU1Gm1JRog2oCrtoKnE56ohOtUcexrxoCrCae/3jaPxMnDGlzUfTQEyW8i0+2SOV
 14OjD2rNSoWxWTWKHp5Mt3nl9Nbd6RXHVkiVp+i8rUXG/7mtMK21iEH8VGkSnEz5uU9RcMW2yqX
 Jx+rD56VmaszC3T8Zo56dHtESIOgyO7tH/CY/+iAJ6B/fFOXtQM9vErEM4pKa62nMK6Z4zT5Z1E
 0vUbil2LHxC466luehXcp7q/v2QqkoLNewvoiRvS1uGz31IB1gB4VEzhfnF2Nnan4SNx0P5B9fx
 gS31sSx2eZbuASrJcN7yg/AtbgpoQHtDb8zetEP9wS5cwDMNaGI73d3omgITKafsYJbjLaWD2gw
 iPHlzZYXaF4YlzL2WB/oJPw7OFNUUwZQ3rFgg1fQCSeqTNSAFNKzmWGZGDfkAcYw==
X-Received: by 2002:a05:7300:b593:b0:2c0:c5e4:605f with SMTP id
 5a478bee46e88-30c07207fabmr84522eec.24.1781803551778; 
 Thu, 18 Jun 2026 10:25:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c0670a1b4sm122443eec.8.2026.06.18.10.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 10:25:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v3 3/4] net/axgbe: destroy mutexes on device close
Date: Thu, 18 Jun 2026 10:21:58 -0700
Message-ID: <20260618172544.338758-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618172544.338758-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260618172544.338758-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Four pthread mutexes (xpcs_mutex, i2c_mutex, an_mutex, phy_mutex)
are initialized in eth_axgbe_dev_init() but never destroyed in
axgbe_dev_close(). This leaks kernel resources on every device
close/reopen cycle.

Add pthread_mutex_destroy() calls to the close path.

Fixes: 572890ef6625 ("net/axgbe: add structs for MAC init and reset")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 415fc6d739..a4b5e9425f 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2481,6 +2481,11 @@ axgbe_dev_close(struct rte_eth_dev *eth_dev)
 	/* Disable all interrupts in the hardware */
 	XP_IOWRITE(pdata, XP_INT_EN, 0x0);
 
+	pthread_mutex_destroy(&pdata->xpcs_mutex);
+	pthread_mutex_destroy(&pdata->i2c_mutex);
+	pthread_mutex_destroy(&pdata->an_mutex);
+	pthread_mutex_destroy(&pdata->phy_mutex);
+
 	return 0;
 }
 
-- 
2.53.0

