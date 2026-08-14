Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4493C5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:19:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3D084014F;
	Fri, 14 Aug 2026 22:19:57 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 9708B4013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:19:56 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1652830a91.0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738796;
 x=1787343596; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q2L/tlKQ9ZUN3ps9/EoqdJRE/TFwkDU3ZjKlWThVP4Q=;
 b=DGGFhCUCqoPbvG6pFqQd3xxw/vK4GqUeI1o3XSSa2FuoBV5L0smwX7EIgudv0wbilW
 Oh4VjGpT1whWRfbnhktLH2iI2R3lLZMokn65IkM/xVXzZ9DnlNIizZ4Y1qNgamRFjRGQ
 CVl+fZ7Tu601QBzH+GKLWKxA2TQeyXkGH0u3mtAVd5isZZbjH17a3RfuDIWc90AhIja5
 ZtI7By+YgK/zYm1XlV6XLVZevXtwdtUi1Js20urdY32x4dWAhhWtUi7JgvVtR5N+ZWAX
 23j86CZKAQ8qv4JqQAq3PgsTdy75i7k+21gjUCWUAjqv5su77dhGWbg5586WkAz1s9Y8
 vMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738796; x=1787343596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q2L/tlKQ9ZUN3ps9/EoqdJRE/TFwkDU3ZjKlWThVP4Q=;
 b=Yj9Jqbztg+JUzBD+YPSuaSpiPJ4/3WiYjpM2akoRhTC9BjmvfIrZp/6V0lryfyNQIa
 nvF4L4Snp8Rn2F5524RDnpGKW2LVwjIA8BmMeJVGNS6GxmQePsSYZAOBSyOzr9dKVUZW
 fbqt1Kvwa1GSZo7NHYvgTJ6258683fFgzvRUU8r0ZSdDVHJcAGMVePs7Edtg95C8MdQM
 kjueQVWqlwZbiCVjDx6Vz/b1B/ljUpMajW7uua+cZWbj7vOF57ctpzoc0j8yVn/YtGnJ
 eGzCYv0gFe+94lLIYZhoXBgjZRUUIRgOBNd1D+nuydC0HBWp2GIUCwufnxJjWBtA/fQy
 Ng+A==
X-Gm-Message-State: AOJu0YwqZOx4DzqWXr5KhN7O3CLEGhDyT+UlqcBivyHe6zvWU4EGPdss
 tI3myMXDyfFvA4OyI0OI6jr8m8dQbSR+GLruH57cYvG00mezwDGxXYkErk7ywbuKP+MA+efUdop
 M/EYX
X-Gm-Gg: AR+sD12qgqUC9bEitO334eGT41mX/9xEX5UUjU65u6rLf5XwCw6FAda/4cECBeKBhi3
 +dJF8mPoNpg+35gcCaqWOWm6JU5bK+QH/sjpx5LzaZagIHGFfVHgJ0XYStbIAgjVsCEFh5Ia++6
 RoplFtRroVXqEo37wdB9/hhtW3hbJzRG/5dD0x1ZN6ECS1u941QZXhfDvXPtkhQQL0hQ9k/yhU+
 hCd701GV/buxirlqqcBUR/jo2rcYmkTfwkPYYiKvLotD2k6QFU0YwU6KW5MsoJ5pc/fivVG/zjU
 5cfQu1Ya0BI1p4IIggiwNpZUUlSl95naSlaA+BSKNFqUUvwsVV71dGFCrMmCYvvo4qm/cwGwPzp
 2b+s+ghV8KO0Dui7bedNObC2eFAO/m2tGw+h0yZBsjqMcJI+HUZxcczmQ3SJKrFgdwl+JoB29Pa
 BqS3prFZrJQNsynSA68/ZNJ/pUfDq5uzmy9VVgdRT4AxDKu5F2qY6c+LFtQSGSoA+rtpSRytvYj
 KKFYTXqEa0/HAfYqNs0ZekOD1s=
X-Received: by 2002:a17:90b:4a8c:b0:381:bc4c:da56 with SMTP id
 98e67ed59e1d1-3933b95158dmr8226705a91.19.1786738795721; 
 Fri, 14 Aug 2026 13:19:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:19:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v4 01/16] net/virtio: remove unused queue stats mapping
Date: Fri, 14 Aug 2026 12:45:57 -0700
Message-ID: <20260814194757.329424-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

