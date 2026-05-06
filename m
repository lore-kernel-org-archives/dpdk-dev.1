Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A05CD3436
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 12:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AE0440671;
	Wed,  6 May 2026 14:36:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2A6D64065E
 for <dev@dpdk.org>; Wed,  6 May 2026 14:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778070983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1idmdj5PZXc05oUZ8d+Jp+w9iwvlrhNE1Uw/+XQ+BC8=;
 b=YZUsd/5kX5bE2xrVPAnnJGGpyKSPpFMwcsfg6NymXECkvtl0uflOjQj85TW179uuhaHfzI
 +I84i19P4+BLW4z1Y/hzjvIDZ5I7Sk60bLJe2Ojk455iik6rTKLh76iKUhXM8FgFn2E/8/
 gcDXELyuflH2A2gY803fFQIAZQs5Vrk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-eReJeHN8NOarxlqfArJG2Q-1; Wed,
 06 May 2026 08:36:21 -0400
X-MC-Unique: eReJeHN8NOarxlqfArJG2Q-1
X-Mimecast-MFC-AGG-ID: eReJeHN8NOarxlqfArJG2Q_1778070980
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373181955D6A; Wed,  6 May 2026 12:36:20 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BBF51800374; Wed,  6 May 2026 12:36:18 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 3/5] ethdev: hide VMDq internal sizes
Date: Wed,  6 May 2026 14:35:51 +0200
Message-ID: <20260506123554.2524136-4-david.marchand@redhat.com>
In-Reply-To: <20260506123554.2524136-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260506123554.2524136-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9SQp9atRFWNH0YNDQGOEzfGy0Tu-bZqyi2u1jBveILc_1778070980
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

