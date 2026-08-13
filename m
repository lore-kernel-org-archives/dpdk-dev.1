Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D1C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F8FC42D35;
	Thu, 13 Aug 2026 20:04:17 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE2742D89
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:15 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2caced6038eso1237635ad.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644254;
 x=1787249054; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q2L/tlKQ9ZUN3ps9/EoqdJRE/TFwkDU3ZjKlWThVP4Q=;
 b=GiNVXbSlRvINKIekC4g+sfh7oTWRGcIbmtatF+rrQfOp3D2/ju20r7zzCVUqA6Z1CS
 ds9oFRDcQDiNLOclqkYOWjQtQYlRqUk8cYAs9eE8f3K75NJgAcYcmoCu2q7mf+qkImUa
 ID5Bz+0rK3eV8m/75pAk7gXakLa6Ttzvr1vF/4uS6sUCQRVXy+6c03B/LBh2CqxNzXE0
 pFNUDBX7khrotSga8W2C/qyTYWU3JdPYWDh079ljCk0uJj2f8NwSUZkCp2gefQbBUFgQ
 okT1z0hY95dK0y/vb0GDsY/nR8YEcU8Cmi1iuX0Yo/nmZ6NOTnulrKHSG6XZcczmP51d
 6ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644254; x=1787249054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q2L/tlKQ9ZUN3ps9/EoqdJRE/TFwkDU3ZjKlWThVP4Q=;
 b=oxfPbmXh4r/kBNp5khy6p4WJOQvUtk9sp0sYN/EZLybtWFJhAhGEBlCU8VuCEtvQNZ
 spr5oXuai9d2fEdgihvamNsX/SvYcobkxLYGMR+3+bG/mg+K3MtBU9HXf/dSW0an+sdm
 knPFSqCslcaZqH9mbj5QPDWLonmSZSKAMKeKom/bsdGEFRrHggxt5LHfZxSR3n3mYZrz
 vsEXkBsh6iMzNhOd6PeXnFCglszl6CtEDk/B+NaggDgw3RxuKiu6Sh+t5MIew07ENdxE
 o1rYp0WBcq/rjdmQOTnX3s9nBeoeuyVMBXQQ2Eo5SVmUXNLimO0Xe7oAIQy9G5WV0DFI
 jDRg==
X-Gm-Message-State: AOJu0YwywOzwaN6UXHrNtK9sr07R/HRVvInrfpGE8ly0AhA8E6dZbgCF
 HaKIp6xaAgrdfSSjL8WIiI/ujhttiYJjq2yUn9PFWeTyq20hIg3yuxXnVwPATMxnT/K2d9lcRzP
 Cjcii
X-Gm-Gg: AR+sD13RicYaop3AcGISMQIfcW7EHdAvRqwumWLYysnjqv3jdoEeEEn5MnW8pWg2gXR
 kaIM2UknrzSKJaTCs2Mxf9wfci7wuxAP9FGzwbPzInC62mbRDb/B5UoImH+2O+9Sl8ZCyFfqIpE
 +1xJgdHw0s1Lt8BkrGIoZmxrVx0D31iPOc9snyjli3rZPSk1/hcSLttjaVmnAsNjMiTcumdIKmc
 kTzaT1JI9OAz8NvN0fdcCML7Kd9U2j7rGjgpoVl3kwggkvvMq9vBUdEMgCMx61mQ1oB+elXdnJ9
 jnaH6d7DBmuy31kxxNPlovmizdTklsK+WpLa0BO1gYJuw4B5YAdiqurTnei0au0dFqB+9JUpmxV
 07XyOf3EfS86wkDSTyAtVbjPULksLPVoEQ5bq1hmKnnkzngoi6iqAvAKOm4zq27IJNd25vWzxsM
 VWM0ykGIZtwMCv3nlOuFj6Qpo3vEEa4J/8uZB/TpapnbBAa+O5mGORonvACATjkW6jCag8Px0TI
 8cHh/EAqEAdUMWUibCFJr21O8E=
X-Received: by 2002:a17:903:22cb:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2d37f72fad4mr86386585ad.9.1786644254041; 
 Thu, 13 Aug 2026 11:04:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 01/16] net/virtio: remove unused queue stats mapping
Date: Thu, 13 Aug 2026 10:55:00 -0700
Message-ID: <20260813180402.622784-2-stephen@networkplumber.org>
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

