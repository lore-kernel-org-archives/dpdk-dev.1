Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAEDC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAA2742E78;
	Thu, 13 Aug 2026 20:05:06 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 7644E42E96
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:05:05 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so131650a91.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644304;
 x=1787249104; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IehSravqjWTjUhdjD95SSmcPASHMBFUi9+H9ZoDY/7A=;
 b=MNensZkwG2o99FaQPZmz3JYHyyjl4LurzmfHPCO0pnmvrhFoCiVZtNjYdntbt0pvb7
 fazAUQe+uhYFTxgrO7zKrpkAodmTF87P7pyB4C7PB+cVLDhJbyUn2XBWasADXfqPfZYs
 ONG2EbP+GoRI0wfMYieUIs+qvhCyU0jErUpUayymG1OAMtqxXrWVMe7Q2/in9UEsndfs
 9WbckaGIC73h8R16VtOS/Ty2F9uXCeMOzVmw59LzAubQci69I8edb1q58xH7NqSz4esj
 DX4qOfOiurDYNnO2JXTd/9v+/PusCXQtAX0/TWhKks7HlPlC38SDWKNN+8xpT3+Rxxk9
 lzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644304; x=1787249104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IehSravqjWTjUhdjD95SSmcPASHMBFUi9+H9ZoDY/7A=;
 b=P+A0c97zfK/rbhvrZpzGEHa8wOP5NQy+jJMMoF/B5AVyFFc8geLiUsnOb5RWe6EK4F
 HyUxrUH4aCcE7v6MqY9imcpcuhlGBZegxsUvo3gk0bP13JeUhpDBWgCn+54GQe6BjMVs
 2HbgiYiH+7TaTAJ7tuoo3SexJGgdm0YjKBzmHNp56bXz3Zrf1aWhtxtUU+vuIQ/0AYIm
 +JL8avuok4+/VUk4RDIL0JDfViBsNz3LcrRP4+MUHLUYB1kNQqPH2HQIJqqzByB0qmKt
 wRDLwSmXv/rE7Viq8XFM9rMQSgVcr4IhKGxUGI7OChActRw9LDexGRcvZNFBG72ce3M7
 FzAg==
X-Gm-Message-State: AOJu0YxibEy7vWIcJ9GMz+LBN4XhCIcETSAib7bZOqSPTMr1hsokLeLN
 1NGWtUIi+vKHaVyf6uzsJ8xZougAwS6SBfX2rawTM+GgCzm67nNSRFr43akhVAhikvUJ+LKTIPc
 SHHln
X-Gm-Gg: AR+sD13Vl1HC/0UcYWm/Q1saJ5s+N5038ticJF5z0J/GKx6sCeMyHo49hCykL3TalwQ
 UrmTAAzX0Qks83+dHqP7n6WgeZzTr+LnK4q0oA56n0is598lBDU3+VJ2HNSJa0KQ+xMWySsw++V
 Q3ril2qg0HMNFbvNLqtA8ReQFG5/lkYYo29TgdgTOhRPv5Z+LalYzrkuT1XhM6SRV8P9uPtCg5N
 QU4DobRQHRaSJNrA6ETN9ng2Ld6Oa6p4hzor+7GIyBm2TSdql580xslQG9lWmNtx/FwFwFwYn9F
 JzR5MfeC1Qw4Xaw3xhY/LAztqFfGed+ynPyXuv/tI6n7H1p0IRpji6GUL1mqXcVBOjekRzE1ZDu
 kt2yRxoCP9Q9Qkshapyg167pqj81dU7AhI9GJj7b5zykeDNmlorQ/+HF9v3FU0VtVTCwwq0D725
 6IpsT5SRJ8mAlNyuZapAvZPE57LvSqR+HwLjKAq3ELYt4uR77nGsGlUdB1nGihlzuh7NO9qlq3r
 v+BCkPAtMwNHcP/cCWi/N6GDd8=
X-Received: by 2002:a17:90b:2688:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-3931e25e5f9mr9018528a91.13.1786644304635; 
 Thu, 13 Aug 2026 11:05:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:05:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH v3 14/16] net/xsc: fix Tx errors added to Rx queue errors
Date: Thu, 13 Aug 2026 10:55:13 -0700
Message-ID: <20260813180402.622784-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

q_errors counts received packets dropped, and is reported as the
rx_qN_errors xstat. The Rx loop fills it correctly, then the Tx loop
adds the Tx error count, so rx_qN_errors reports both.

Tx errors are already counted in oerrors, so drop the assignment.

Fixes: c80ab1a551cc ("net/xsc: support basic statistics")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/xsc/xsc_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 39a67ff8cd..505f973d66 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -614,7 +614,6 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[idx] += txq->stats.tx_pkts;
 			qstats->q_obytes[idx] += txq->stats.tx_bytes;
-			qstats->q_errors[idx] += txq->stats.tx_errors;
 		}
 		stats->opackets += txq->stats.tx_pkts;
 		stats->obytes += txq->stats.tx_bytes;
-- 
2.53.0

