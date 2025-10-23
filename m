Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD4CCF9E2
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 08:24:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72778402D0;
	Thu, 23 Oct 2025 10:24:41 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id C10FE4025E
 for <dev@dpdk.org>; Thu, 23 Oct 2025 10:24:39 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-33d28dbced5so774343a91.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761207878; x=1761812678; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gEudl9ZbFfgRz+Isk9lTzOsKVgJKNtnvRO0UDnFZPTk=;
 b=Wsk58rbIaBfHKtWd90KtQfkM0dL34L0WhgtFbmcjQ7Vl0Ri0mJCh+Z0kRofY9t/Jca
 LuW3r+adhtXXvF4qORUbTO8TjSbiVIXSDSZmfVYRlphGemVhvFREIpwDcHYqTYdzLOSC
 bTJCIx43G/OgQr3WHyaXB/szs7qU0Qto7rxUiOOVEMGgAq1W30i65eT0VzhHcreB2unU
 pmutNsMGdiVCW10fEBeHRrDFZ80mhSMVC9D9qgbdkcx8gQpqJcxP1XprWSgZoJdajN9F
 R2OHM24pvq4o+em4JVRwmN84ybYFCnSuChthqUEO4r0JZLFd/97CLTWnb6Dg82/htiRW
 VSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761207878; x=1761812678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gEudl9ZbFfgRz+Isk9lTzOsKVgJKNtnvRO0UDnFZPTk=;
 b=ZnKNJoKRvb6YZk2gYJbSdcLwPXOdcPgSp9HyQ3TXt+NPQ/xw502RTHaWDi2Svv/vHf
 6tWl0jPh9iR1DAX+JqzzXT6QMw2t2mrrP0LfRw3S2Xh/Dz2dEOXItG7K5CjmdWICBoad
 oRAJY/TQWy98vVwvgRFTLuNKSJPZqys1uX67f2U3vUy4uuXGwLbhC5s/GO/lzpZxA2ND
 E4FbbafjK9fXG9YvyRp1irBj5Knqy5re93HOOvpezdGkufOp8A9fBUu3ZKv02Pj2TrNx
 2txfRw52uJxZwPIT6mMbOqiIFRJtL/hvOYlO3wTkRZhjIpKJtuQRZITNboGK9nK85Ldh
 Q2Ag==
X-Gm-Message-State: AOJu0YyZUg2s/6IVuD/4cydzbDV+ALx8jrEgPVQws9BIsJCSF4bhDx/+
 RuKg5Fc4T9tTRttBWZEJloPaRF8Teks3NB43CvWa0+Paaj46Vi+5Uniqto2qaw==
X-Gm-Gg: ASbGncvAIw5acI8gJMBoL647u2xykEyiqHC3d+sfF/tKme6hH6HCg3aJYHsjd9tfVvZ
 hcuHyqAGOozmwndrNVe9xeGAV35jNcbQm5nUT+6HdKItTAgZKMTOH4xquOfwWAAsplGI4WU1ls4
 hHgO6e4XpTiQYuA14PZmN5w/s5URXdr+ssjGhrppwIsNmboACqewMwpan182o2nO5y/F5SWG579
 DBagf1b2wyN08xLji9ffXyJdMNRFxDI76YdGFeyRl3f69zEFOqyQLooB/zMaP8KCDQ8gnDyD+5F
 POMTlRptC2ndwtWFl1KHG6Ko69F/waMABF9ixVXqmG3rndMRgHQ5y8W+MST6pbZjasu40+4VXlC
 +8qPkX98FNPELNv8TaYh3QfwuKLUjbM0g+TFEwN5cfn+aplXsKiOByljxuZRYqxPec/llZFkQ8d
 UuFaT5e1lviCIo77ZP5kEAC4f3OLb9XBZ4uIBBt0wWQ+cMKKbqvrAKfktQiw==
X-Google-Smtp-Source: AGHT+IFamXaFB577sD/YN5TG0MOsi1FghBypt+tsUEjiOZ+OJtCJ0Hkd1RJNsfn8dOpd2EHspfDP8Q==
X-Received: by 2002:a17:90b:5343:b0:32b:65e6:ec48 with SMTP id
 98e67ed59e1d1-33bcf84e1edmr32220901a91.8.1761207878399; 
 Thu, 23 Oct 2025 01:24:38 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com
 ([2402:e280:2162:53:690b:e114:2f06:4eff])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33e2247a359sm4976306a91.12.2025.10.23.01.24.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 01:24:37 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v3] net/vmxnet3: disable RSS for single queue configuration
 for ESX8.0+ versions
Date: Thu, 23 Oct 2025 13:54:28 +0530
Message-Id: <20251023082428.18664-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
References: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
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

It fixes the issue of v4 RSS configuration failure in
vmxnet3_v4_rss_configure() while writing to BAR register. It's very
specific to single queue configuration.

https://mails.dpdk.org/archives/users/2025-April/008236.html

Bugzilla ID:1789
Fixes: 52ec00f ("net/vmxnet3: fix RSS setting on v4")
Cc: stable@dpdk.org

v2:
 - Fixed typo in commit message
v3:
 - Checking if RSS is already enabled

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index f4cdb1bb31..a0306af86c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -534,6 +534,13 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* Disabling RSS for single queue pair */
+	if (dev->data->nb_rx_queues == 1 &&
+	    dev->data->dev_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_RSS) {
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+		PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
+	}
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
-- 
2.39.5 (Apple Git-154)

