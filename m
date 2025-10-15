Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A7CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:09:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A5B1410D5;
	Wed, 15 Oct 2025 14:09:55 +0200 (CEST)
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.246.68.102]) by mails.dpdk.org (Postfix) with ESMTP id 08F5940273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760530194; x=1792066194;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=NKzslwMe/OZCTle6Rgn01zWjOUc4/IgN//BztuQExsI=;
 b=B+kE4xbygVkJWbvUe0IWlBtCojLYFRWBZWZoSlrU98nHR0jPB7DQhNTQ
 m/LLuD8pcXjp0d9po06AbgmIJ6N5MMc5URNwbNtm5n4XAb4S2S+NdDi9z
 y7Iu0ej8mHPVFHlmVgB9gGAScpR+BcyaT3eHTvmI+UE3KeFQtwUJ2+srL
 ghhGTc/PoJMWj6Jn1Tfj9Clp0WiWgcp70CoUAMT380+QaMf1m2skNDHes
 07PjVXLKJdBtfp4rh3+twL6vvef2cNeEBmeQdCnZkiHj/EZTggt2JGvdX
 WQMlzSJIRyu0ejT0WKVmpLuX3aJ9xtXtyY0pyjj4oSnvtU/I3NnymzkYL Q==;
X-CSE-ConnectionGUID: twDcHshLTCauU7UYMIqPiA==
X-CSE-MsgGUID: qsS28GY9Q5St+/UioKAQcw==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4931357"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:09:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:9143]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.168:2525]
 with esmtp (Farcaster)
 id 1f7ebd01-adfe-4e71-8e43-d8e1ba18b2c9; Wed, 15 Oct 2025 12:09:51 +0000 (UTC)
X-Farcaster-Flow-ID: 1f7ebd01-adfe-4e71-8e43-d8e1ba18b2c9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:09:51 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:09:49 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>
Subject: [PATCH v2 10/20] net/ena: style and comment changes
Date: Wed, 15 Oct 2025 15:09:39 +0300
Message-ID: <20251015120939.2681-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

This patch makes several changes to improve
the style and of the driver's code by adding
comment and line breaks.

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/ena_ethdev.c | 7 +++----
 drivers/net/ena/ena_ethdev.h | 1 -
 drivers/net/ena/ena_rss.c    | 2 ++
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index aaa4feb11b..3274ecfb46 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -31,6 +31,8 @@
 #define GET_L4_HDR_LEN(mbuf)					\
 	((rte_pktmbuf_mtod_offset(mbuf,	struct rte_tcp_hdr *,	\
 		mbuf->l3_len + mbuf->l2_len)->data_off) >> 4)
+
+/* return val clamped to the [min, max] range */
 #define CLAMP_VAL(val, min, max)					\
 	(RTE_MIN(RTE_MAX((val), (typeof(val))(min)), (typeof(val))(max)))
 
@@ -918,6 +920,7 @@ static inline void ena_indirect_table_release(struct ena_adapter *adapter)
 		adapter->indirect_table = NULL;
 	}
 }
+
 static int ena_close(struct rte_eth_dev *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
@@ -952,14 +955,10 @@ static int ena_close(struct rte_eth_dev *dev)
 	ena_indirect_table_release(adapter);
 	rte_free(adapter->drv_stats);
 	adapter->drv_stats = NULL;
-
 	ena_com_set_admin_running_state(ena_dev, false);
-
 	ena_com_rss_destroy(ena_dev);
-
 	ena_com_delete_debug_area(ena_dev);
 	ena_com_delete_host_info(ena_dev);
-
 	ena_com_abort_admin_commands(ena_dev);
 	ena_com_wait_for_abort_completion(ena_dev);
 	ena_com_admin_destroy(ena_dev);
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index 6a3b004653..3a66d79384 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -29,7 +29,6 @@
 #define ENA_RX_BUF_MIN_SIZE	1400
 #define ENA_DEFAULT_RING_SIZE	1024
 
-
 #define ENA_MIN_MTU		128
 
 #define ENA_MMIO_DISABLE_REG_READ	BIT(0)
diff --git a/drivers/net/ena/ena_rss.c b/drivers/net/ena/ena_rss.c
index 45578189b9..0af1879dc4 100644
--- a/drivers/net/ena/ena_rss.c
+++ b/drivers/net/ena/ena_rss.c
@@ -56,6 +56,7 @@ size_t ena_rss_get_indirection_table_size(struct ena_adapter *adapter)
 	adapter->indirect_table_size = (1UL << ena_dev->rss.tbl_log_size);
 	return adapter->indirect_table_size;
 }
+
 void ena_rss_key_fill(void *key, size_t size)
 {
 	static bool key_generated;
@@ -512,6 +513,7 @@ int ena_rss_configure(struct ena_adapter *adapter)
 	tbl_size = ena_rss_get_indirection_table_size(adapter);
 	if (!tbl_size)
 		return 0;
+
 	/* Restart the indirection table. The number of queues could change
 	 * between start/stop calls, so it must be reinitialized with default
 	 * values.
-- 
2.17.1

