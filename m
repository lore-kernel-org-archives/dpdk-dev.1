Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA44C021A6
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 316C3406B8;
	Fri, 14 Feb 2025 18:42:43 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 211354067D
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:42:40 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so3489153a91.2
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739554959;
 x=1740159759; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R49RK+R6/J29trjJdjzPDF0wWVFMPFTuDlHNN5YMLM=;
 b=vA4fnMGys77XJyCC/bO6oZj4SQpnhJ7iBq9WZk8Y6PLeeM5bbeiT7ZXgED4Ey3J9Rq
 v7mqoXiqP/BaWnonFjzWmCiHgpTRCkurs/456Xm0ZGuDt9/rLjerPUERDWQ/n4gRFhhl
 /T9D2h6vgLe0FrALobbC6XF1Rx6xgv7BxIFMct8DxKiJnejmsSy9m8H5lkzxMPgJCUBu
 FFTKIde8EoApb/hBQamtgQ3kGnwUU0vwW2cd/7qxHLk4RRlcWFLy+X9UhkBS1zNfqJkB
 /nNcin7BT8MxfkwmnFOlGbJYkoZFJzpQoS4afkByrGSdBMyrzx7CrKw3AhAHvvN2Hyil
 Zt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739554959; x=1740159759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2R49RK+R6/J29trjJdjzPDF0wWVFMPFTuDlHNN5YMLM=;
 b=BBvivQwnRJVORJKC6ItCHiE4RNkJJs6oYftBCpnI4XIR4z+rfHDUKQMnCgCFK6Olvf
 FK4J408pso6DWng+2vHGWor1pbWJnkrvVu7DKMQosZlfFK1d2ZExcWGJy852JZ9DiR0Y
 bi0aoBzeJrxILwftFVJlrNO+eun23zSPM+rhoQBQeg4GsChHHnEDciy7/gaygewwM4t+
 akJVEy8lUMbKk/QQo7+88FNGT+aMqw5gVQaVXiWwxnM6wmjqSmWwqY+VT9KWOjd5mavW
 CiQCGIYkoj2CT3iAxaAfpT2uzdy2rXMl4fO8bX/u4RiU2G5J4V7yU890/dosly3anWGT
 xGIQ==
X-Gm-Message-State: AOJu0Yxqt6bC9UTK4hXL5EHWK+gU6736h5zIdg/ygqX2CzvJ7Vd6uqHA
 RaKL5ldVDtUFW9i/Pv9TMd6ZNFJ2bUmvdbcBOa5/KhxSlGO6ZydxF4hPMWZfU5FpRB8ANiYsq+u
 UnYA=
X-Gm-Gg: ASbGnct5otAs5Gmjk3+gqqJs6A7tv3r3vv5jRTeH6/42fEl3hB6JnqCqibbXhabJxo4
 9+Klto/YQcF+eFOjqvZRSVCMglH1tEiHJGOrMeLxjASTdNP6OLGoVkp5cV7Ynz3zKi53XyiNWD1
 YE2Jmn4+PD+trijE+1yTmZEdyTx1CaGLVPZeNfiXpzpp2kBsLheijLwTaPyvRX/6Tl7UPv+Ew25
 XhTSv2GnzHtPr2eMlqzLyk+R1/L7sTPtvjxfTXwk8Y4xZ2539v7HTv89RlZtz46FPysXNqaSQhA
 Y/miqLZVBWuLiUoybzPhtwYM2WOzMQMGel+1Q1W7uMvM2Th1JlmYm3G6hLtzbi2oQTEi
X-Google-Smtp-Source: AGHT+IEDL0wAgX558FOMscyDARcmpLgsN6UW15fa8DviP/RIuC8NYxOu46z1tkQ5ZIi+WfI7P+gcqA==
X-Received: by 2002:a17:90b:544c:b0:2ee:5691:774e with SMTP id
 98e67ed59e1d1-2fbf5baee14mr20257846a91.2.1739554959334; 
 Fri, 14 Feb 2025 09:42:39 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98f48eesm5449852a91.22.2025.02.14.09.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:42:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 4/6] net/dpaa2: remove unneeded deferred start check
Date: Fri, 14 Feb 2025 09:38:57 -0800
Message-ID: <20250214174224.79142-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214174224.79142-1-stephen@networkplumber.org>
References: <20241213214929.817688-1-stephen@networkplumber.org>
 <20250214174224.79142-1-stephen@networkplumber.org>
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

Already checked in ethdev now.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index a9bce854c3..8624bba0ce 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -726,13 +726,6 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 		DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
 	}
 
-	/* Rx deferred start is not supported */
-	if (rx_conf->rx_deferred_start) {
-		DPAA2_PMD_ERR("%s:Rx deferred start not supported",
-			dev->data->name);
-		return -EINVAL;
-	}
-
 	if (!priv->bp_list || priv->bp_list->mp != mb_pool) {
 		if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 			ret = rte_dpaa2_bpid_info_init(mb_pool);
@@ -889,13 +882,6 @@ dpaa2_dev_tx_queue_setup(struct rte_eth_dev *dev,
 
 	PMD_INIT_FUNC_TRACE();
 
-	/* Tx deferred start is not supported */
-	if (tx_conf->tx_deferred_start) {
-		DPAA2_PMD_ERR("%s:Tx deferred start not supported",
-			dev->data->name);
-		return -EINVAL;
-	}
-
 	dpaa2_q->nb_desc = UINT16_MAX;
 	dpaa2_q->offloads = tx_conf->offloads;
 
-- 
2.47.2

