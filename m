Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCB2103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C8F40E1F;
	Wed, 25 Mar 2026 03:40:33 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 8A64140E09
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:29 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso421089eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406428;
 x=1775011228; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=wNZs0QfskKgyKwyR39mK38j97e+oDeJiXwD9tVFvvMwdtPILUZTWkd6RWc9CqPn6fD
 Yj/UvaFLizWAtdhoWNk7JZ9+KzzHdfWpV3xsH518Ye4RjN3ytRzMpcHZM22BYgvnqMtv
 sTInO1fnOAgAmiSxzGytHiuk8zzsbqllBam9UPBPNxbUzJxrzSn9GoMT/O7G1oZ2IOrH
 azp7wr33Tz2ia2f3HXsnbM9o1k2v7jTLV2v2wq+/ZvwJ9xcsjxxhhMiSpMyWaqMly57m
 4cREV50dAS7i1JMqww5VTgQp7pTGrEBvt+f3B1e0AWbcR8U1DO+mmeU1A8e+HDHcjodI
 7lIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406428; x=1775011228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=Sl2Wq7O650F06wyCvUUKfKUVyRhX+Z6/r36f/7NiKGjyQwmDGc2dpTFMuuSOhFUYF5
 +hMNCT95sLfMrHhLgSUS64wpxtC0h5M0QOEWl4yr1tNfJgH5T32ag2lqgVtNWH+e+TgG
 E1KwRfKUuDajSyvgtCVoZAaYQG0suUmnssmn+sfANKHNRoO0JVoad4yPIiACbhbqzQrD
 71V3nmqIz6GC7Kl6qxRrr94elWlDUliwEoXtqqgfXKWrs3wpcUOmhEl1kHPPf1qptpk1
 DSgLNF8y5GxIjAMErDVw8Ff5MpPZEi2MORd3VAdnJiepIx9a5R1iZMCNZEStNvQpkej5
 n5Pw==
X-Gm-Message-State: AOJu0YxkSYr5DNiwZFBC8DMFLPhwIpa5962JJWDXCNh1r33NXpYBmvXs
 iMasr5V9+q8s68LghbgnjMEkWM2Ex8wChg/QmDWpbfgzRoWQQA5jM1T1rPR1NxiK+3ku2Dj6s7y
 Tsh1q
X-Gm-Gg: ATEYQzyZR8rrqghxgaX+dsQnoLgrCOKtTZfzcaai+dHijooJMaHycrbaP0X34HvstVe
 DcxyeTx3WnC+r5zfKPgFtDfYKe3peoZ+fUBPwQLPzQO101gY0W9A8t4S81WLjuaRMFLtneL+LJL
 ONtvR4bsgHxe911C7ayKA8CBbm2adYFmVG6Rlq/GhqmJfw4cEjGBlfyt/BloT4/0tWBM0THXmrD
 MlOpBhjfKm+BiFczYDNC07IT7SfhxhE1OkMPFG1KLZhFbq6TNL9SYWOKu7skjeV+ygDdvWcKc10
 66AiJ/ZRheCLrr8kN6jmz0RvvCbxW33guCJ8cllADkhLtUlhnjLWbOjgQUjLO2n/K26N/2LAWXc
 kZslwabbEL4PE3oVmBlnP93a0VCJSbhqHwD1L2qrkOin8zzy2Ei1atCccJc229j0o+q/Ub7B6nX
 O6YwvnI/7Vt1dEBf64iPenUWhWheJphwvF
X-Received: by 2002:a05:7301:580b:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-2c15bd88fdbmr771948eec.14.1774406428519; 
 Tue, 24 Mar 2026 19:40:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v21 07/25] net/pcap: advertise Tx multi segment
Date: Tue, 24 Mar 2026 19:37:38 -0700
Message-ID: <20260325024018.1275209-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

The driver supports multi-segment transmit, but the did not set
the offload flag. Therefore applications would not know about
that capability.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 724b7a9038..ebc96fafe5 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -753,6 +753,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.53.0

