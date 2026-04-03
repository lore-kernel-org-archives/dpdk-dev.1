Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D91E7E345
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 09:19:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C350840E37;
	Fri,  3 Apr 2026 11:19:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0CA0540E37
 for <dev@dpdk.org>; Fri,  3 Apr 2026 11:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775207945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1idmdj5PZXc05oUZ8d+Jp+w9iwvlrhNE1Uw/+XQ+BC8=;
 b=Wz7+JGayrhyqw3Cp6eyH9djvgE9xtRJtSvBZ8ppSO4nnGyNL3yPN5fIH+uUKqlnPC/22Zl
 BG2rxvO7QWJGqxCATw3SZK0OHWqLhP/zi4CFKoiOD1Rvi1IZZl6rKtOpwgEhakOlyc+uNV
 urBQhXtb0938lKnI/iL07cFXLnwZ/Nk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-ix4bKRXtOcaRxsBKFfmlgg-1; Fri,
 03 Apr 2026 05:19:02 -0400
X-MC-Unique: ix4bKRXtOcaRxsBKFfmlgg-1
X-Mimecast-MFC-AGG-ID: ix4bKRXtOcaRxsBKFfmlgg_1775207941
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 169C118005B3; Fri,  3 Apr 2026 09:19:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B8BD3000223; Fri,  3 Apr 2026 09:18:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 3/4] ethdev: hide VMDq internal sizes
Date: Fri,  3 Apr 2026 11:18:34 +0200
Message-ID: <20260403091836.1073484-4-david.marchand@redhat.com>
In-Reply-To: <20260403091836.1073484-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EjPti8GKmm0jYjuBbF-e0cQQuQV3NdPGpP5s_nOIn7I_1775207941
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Hide RTE_ETH_NUM_RECEIVE_MAC_ADDR and RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY
in the driver API as those (ambiguous) macros are only a driver concern.

In practice, this is only used by the bnxt and ixgbe (+ clones) drivers.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/ethdev/ethdev_driver.h | 8 +++++++-
 lib/ethdev/rte_ethdev.h    | 6 ------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 1255cd6f2c..a4e9cf5b90 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -119,6 +119,12 @@ struct __rte_cache_aligned rte_eth_dev {
 struct rte_eth_dev_sriov;
 struct rte_eth_dev_owner;
 
+/* Definitions used for receive MAC address */
+#define RTE_ETH_NUM_RECEIVE_MAC_ADDR   128 /**< Maximum nb. of receive mac addr. */
+
+/* Definitions used for unicast hash */
+#define RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY 128 /**< Maximum nb. of UC hash array. */
+
 /**
  * @internal
  * The data part, with no function pointers, associated with each Ethernet
@@ -153,7 +159,7 @@ struct __rte_cache_aligned rte_eth_dev_data {
 	 * The first entry (index zero) is the default address.
 	 */
 	struct rte_ether_addr *mac_addrs;
-	/** Bitmap associating MAC addresses to pools */
+	/** Bitmap associating MAC addresses to VMDq pools */
 	uint64_t mac_pool_sel[RTE_ETH_NUM_RECEIVE_MAC_ADDR];
 	/**
 	 * Device Ethernet MAC addresses of hash filtering.
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 62c72de0e5..6c1984e679 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -903,12 +903,6 @@ rte_eth_rss_hf_refine(uint64_t rss_hf)
 #define RTE_ETH_VLAN_ID_MAX          0x0FFF /**< VLAN ID is in lower 12 bits*/
 /**@}*/
 
-/* Definitions used for receive MAC address */
-#define RTE_ETH_NUM_RECEIVE_MAC_ADDR   128 /**< Maximum nb. of receive mac addr. */
-
-/* Definitions used for unicast hash */
-#define RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY 128 /**< Maximum nb. of UC hash array. */
-
 /**@{@name VMDq Rx mode
  * @see rte_eth_vmdq_rx_conf.rx_mode
  */
-- 
2.53.0

