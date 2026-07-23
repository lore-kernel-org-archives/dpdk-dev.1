Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55FC531CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D91F640691;
	Thu, 23 Jul 2026 22:29:44 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 45C7E40280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:41 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so874422a91.0
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838580;
 x=1785443380; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q2L/tlKQ9ZUN3ps9/EoqdJRE/TFwkDU3ZjKlWThVP4Q=;
 b=TTsbM7th3VX5/8qB4d+mq4UF+zjKwlC3e/cr9qmKyDRO26r59oPM4l3mkXuElFx0sv
 5vo4QWIfqWAYfj4jKkAM9ttxU1Y7y5uqMchnXQqrP83xdLlrkyJw8pZYVfv2ZxxBoXSq
 +Vuz9kzqzLbGdq9fUP1B8Tm9WCqi1pZ1j0xuV3HpD4wgNPoZrZk+MX7HxrcvP4S8R7/D
 3i+h8YG744ZSN77WTIyThK4JvqieNH8pydhNBwjiq7OrtoO+sKw7uSPTtrRlvugi8a7z
 /u71nb1Vtfd7P+tPTTWgihNqP1eNMMXKPFWDUMMilqk3WKLzguFB4f8pFxvQIIqgnRUD
 HGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838580; x=1785443380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q2L/tlKQ9ZUN3ps9/EoqdJRE/TFwkDU3ZjKlWThVP4Q=;
 b=UjAegblIZPC1oZaZTt4RrIhxUkAyZuXHeE1htt+oOwj5jiwG2FKd3sVo60ehTNr5gJ
 nlq18aPD9Td0JkBQSaufhytwDLyUhQYxw7bx+rWetUnBxSp8VIOTriB+3HjVsO+e277Y
 Voak7DQwvrqzHV6sVOok04U264zLe8CwAbYV00PwhO6+WCdyWbfiGCfN+mAGrGACSH1Q
 0WgV2S6fOfwnt5FFW/noX5tzyd4HZJQ03/X3ErajlynUceYxQUJRL61ENMSGgmU12G/T
 uW3rHzvXlNsEkvEBq+MAxaAKCG8zRonHkYVpgq5uBMF8eAvxS5cAEa0fcdj3HWymq5Sq
 OcaA==
X-Gm-Message-State: AOJu0YzznTnchKiNMLSgb2w43nRbP86F5WDY7AolZzeobuJu0K1DasmW
 BJdf3J83OMiifwwtZpk/JTaf4JRPiEb5z1DtOZr2gF/dVpI87jW1dRTDxH/IT9Y35j3PjmUTlg5
 DoUXi
X-Gm-Gg: AR+sD12Kyhc6kKyigOVc8Y+I84oLKz5jwXYbUuPhWcaYyIlvnbDCHoN7VFL3caLqc7c
 yLPnjIGMDUs+mswtJl6SMi2yZjfUkCVxLo/QqB/f5KkIAd8n7piOt2vNVyy7S4Vcct1FhSr3/iE
 Q5V94+XuBchds5+M9DThiW+Av7NstlquXR1oICxWMtNTwu/JeXpepEx1zYWsGcu/oNj414DLy70
 WPgyzH+CY2XSNwdPW4yKg9F/0zE39yv5Tv893jECWnWVRk9DTFKMhj9C2Tch0EI7VPdPrJNo3Sf
 mHDx8iUjQJr8D/0qU+g1LnLsk17GpdmxZjrdPihI1Qd+Azs600L6Pkk4iKaa2YksCiGMkwDjT7m
 rWg4TGyc9V8WoziQEsA8FQVVGiPzxg04NhtxXwuZ77YGHgWO3l/NIIsAmC3nIlDt38OUOq8sYMs
 oeID8dtHc80FXI0eWmzPr8XGaLH5aKdhGFhRxqZrr0
X-Received: by 2002:a17:90b:1d02:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-38ec648e1fdmr4689665a91.5.1784838580335; 
 Thu, 23 Jul 2026 13:29:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 1/9] net/virtio: remove unused queue stats mapping
Date: Thu, 23 Jul 2026 13:28:06 -0700
Message-ID: <20260723202936.378793-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
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

The queue_stats_mapping op in virtio looks like a vestige
from when it was needed to get per queue stats. That hasn't
been true since 25.11 release.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtio_ethdev.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index 9fd746b80f..0b2574bd02 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -90,12 +90,6 @@ static int virtio_intr_disable(struct rte_eth_dev *dev);
 static int virtio_get_monitor_addr(void *rx_queue,
 				struct rte_power_monitor_cond *pmc);
 
-static int virtio_dev_queue_stats_mapping_set(
-	struct rte_eth_dev *eth_dev,
-	uint16_t queue_id,
-	uint8_t stat_idx,
-	uint8_t is_rx);
-
 static void virtio_notify_peers(struct rte_eth_dev *dev);
 static void virtio_ack_link_announce(struct rte_eth_dev *dev);
 
@@ -672,8 +666,6 @@ static const struct eth_dev_ops virtio_eth_dev_ops = {
 	.rss_hash_conf_get       = virtio_dev_rss_hash_conf_get,
 	.reta_update             = virtio_dev_rss_reta_update,
 	.reta_query              = virtio_dev_rss_reta_query,
-	/* collect stats per queue */
-	.queue_stats_mapping_set = virtio_dev_queue_stats_mapping_set,
 	.vlan_filter_set         = virtio_vlan_filter_set,
 	.mac_addr_add            = virtio_mac_addr_add,
 	.mac_addr_remove         = virtio_mac_addr_remove,
@@ -693,8 +685,6 @@ const struct eth_dev_ops virtio_user_secondary_eth_dev_ops = {
 	.xstats_get_names        = virtio_dev_xstats_get_names,
 	.stats_reset             = virtio_dev_stats_reset,
 	.xstats_reset            = virtio_dev_stats_reset,
-	/* collect stats per queue */
-	.queue_stats_mapping_set = virtio_dev_queue_stats_mapping_set,
 };
 
 static void
@@ -2823,16 +2813,5 @@ virtio_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	return 0;
 }
 
-/*
- * It enables testpmd to collect per queue stats.
- */
-static int
-virtio_dev_queue_stats_mapping_set(__rte_unused struct rte_eth_dev *eth_dev,
-__rte_unused uint16_t queue_id, __rte_unused uint8_t stat_idx,
-__rte_unused uint8_t is_rx)
-{
-	return 0;
-}
-
 RTE_LOG_REGISTER_SUFFIX(virtio_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(virtio_logtype_driver, driver, NOTICE);
-- 
2.53.0

