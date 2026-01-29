Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F3D358E5
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 08:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71C81402BA;
	Thu, 29 Jan 2026 09:51:55 +0100 (CET)
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by mails.dpdk.org (Postfix) with ESMTP id DB4834026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 09:51:53 +0100 (CET)
Received: by mail-lj1-f195.google.com with SMTP id
 38308e7fff4ca-382fa66fa9dso5708851fa.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 00:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769676713; x=1770281513; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S58HVGt4RDbnmto6JQMC0SRmTG04vnXNcTK5E7+BkDE=;
 b=QBv1w3TCKr5jEILSaJRtHbNPvMjhG42rAV/mAY8/i+xAbM922b63NimAbfuig+L9sv
 XOpcmCV95F6LUyKvm4RQmJ1lQYqQPcvQcetYex0BGYj4P5DQcFqRc1GqL8lEo0o1ZW2Q
 PeSnDXlpvSbIpUq++raICXNeO8saazgEGGRuXf5CZRuMGMvJ497QaQGZ9jHYLS2P2PEj
 7MAIubRB/JWyQYmqr13cBgSXJIpQ8DTM16kASVqRj+iH9Z6aowXYzxgywsBAt9DA4TJD
 qVtPt67vBGgsLgSJXpBUnHmoazgZqrra7vFCcranSGwaBDzuoAYS+L0lLQTEMn4cwoSf
 XO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769676713; x=1770281513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S58HVGt4RDbnmto6JQMC0SRmTG04vnXNcTK5E7+BkDE=;
 b=RunwMjBBm1/Ui4uLIzbrMpCrVg6SpehjW+Y7z37fFVOBPyWYThSyC5svns2HEfcilj
 cfNW702ES3KeBiuBkeuNm+Bpjcep+IkBMw27QE8fA4YlXkORlsy5H1WkmTpVKBdEwc4W
 lnvqFkby2E/M9F9hRz/kFhqq8YRNDgXjhwRTJeosY407znp7Hv1OudwkPB2NcJwV09um
 TjPMrk7rCYf9WqOoUsfkTsSql7ra0M6ot8uYDaf84PnbU3Hu71yIt1cr9hu09SCKO+Oc
 is81df2f+eDID03VsAbYeYlL1mnx9BGml6X2EgZCcI1KAjZEFv40pOQy90xF/yeCIgNd
 HLdw==
X-Gm-Message-State: AOJu0YwYX6F7ohakU+C7cq88ZLdUuXQCgRPfn90e9VDMjsxlGB0d8Aaa
 QtQkp7RAgzPRA60OPMDCT6jzWNvGHGsQe28mdODtIAil1k4zjduvNSG6cNCvdVk2jU8CHQ==
X-Gm-Gg: AZuq6aLkqkxkKUTFqTMNSIVo8x8NXnyZsgzA3HXW5noSWRRi6vpBsiSe7EGrbzvJd0R
 ZA+3CD6BCA0a9wl0PbWX8+ZB66o7p1QUqcii4RYT68zy+r1NdHkpENHE+jFZY+Js9ytACxnoZL6
 SmKumclFjWzpI48679A/0DcOxcboqpJLmb/d4FJ9+cSLx5dIsuztEXkrFxYBBvU/08pEkrQcT0Q
 mTJSth7yZ9UEgM6Ylmn+FipajF70qMi2K9ed9s/NHeLpkPFLa6tC/OuAkPSyrcG198tQ9V7ph4B
 bWRibyzZt/WELjsMi+tuHr1fSVfMWpM6XXNaisUHy2bE+/NmVFen6gVAKSOBys9PBN2KkzKyaXt
 g9md5bvrD4CZBwxytket3iu8tY1odIcz/xxsdIE8iSp81QLJmW7T8hJ5tNte5sYFt0k5M5SrKUG
 ChYgbK34p+9l110hpo0Azo/RcRWT5GgIzSRjK7Hardvj9l/NqmGxiK
X-Received: by 2002:a05:651c:41d8:b0:385:c42a:1d3f with SMTP id
 38308e7fff4ca-3861c89b097mr36771121fa.28.1769676712835; 
 Thu, 29 Jan 2026 00:51:52 -0800 (PST)
Received: from dpi-G5-MF5.pulsar.kazdream.kz ([109.163.197.162])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38625c74bb2sm9046781fa.17.2026.01.29.00.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 00:51:52 -0800 (PST)
From: Zhanibek Bakin <zhanibek.bakin@gmail.com>
To: dev@dpdk.org
Cc: mtetsuyah@gmail.com, stephen@networkplumber.org,
 Zhanibek Bakin <zhanibek.bakin@gmail.com>, stable@dpdk.org
Subject: [PATCH] net/null: fix Tx statistics accumulation
Date: Thu, 29 Jan 2026 13:51:24 +0500
Message-ID: <20260129085125.96829-1-zhanibek.bakin@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The eth_stats_get() function incorrectly uses assignment (=) instead
of accumulation (+=) for opackets and obytes in the TX queue loop.
This causes only the last TX queue's statistics to be reported,
while the RX side correctly uses +=.

Fixes: 31326ce7f15 ("net/null: count all queues")
Cc: stable@dpdk.org

Signed-off-by: Zhanibek Bakin <zhanibek.bakin@gmail.com>
---
 drivers/net/null/rte_eth_null.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..7fba3a661b 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -345,8 +345,8 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		pkts = rte_atomic_load_explicit(&q->tx_pkts, rte_memory_order_relaxed);
 		bytes = rte_atomic_load_explicit(&q->tx_bytes, rte_memory_order_relaxed);
 
-		stats->opackets = pkts;
-		stats->obytes = bytes;
+		stats->opackets += pkts;
+		stats->obytes += bytes;
 
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[i] = pkts;
-- 
2.43.0

