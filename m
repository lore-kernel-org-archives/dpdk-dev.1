Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2139DCD37B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 17:03:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A931940651;
	Sun, 10 May 2026 19:03:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2DCEE40651
 for <dev@dpdk.org>; Sun, 10 May 2026 19:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778432611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyyCne1NG+EFfr55zFbsC+/JVCO4k3koIVUYPU/EVG0=;
 b=CsOnuLGdJ51rpHNjnbd+nD8hR+WFRTz0k5drHMuoyBV/DUVrtFPXU41a+kihUyhqGGWmxy
 HL68bTZLn4I3OyQTxh89JVKT9xB3keLL5px0tjYEBkQcH9agzhnnYWDh2W9pge3Qa2uCQJ
 bA5obpribwqsZjwidzKJXf/+TuAFUzw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-KLbJ6bheN1-BLOwRorDP_w-1; Sun,
 10 May 2026 13:03:28 -0400
X-MC-Unique: KLbJ6bheN1-BLOwRorDP_w-1
X-Mimecast-MFC-AGG-ID: KLbJ6bheN1-BLOwRorDP_w_1778432607
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 818081956080; Sun, 10 May 2026 17:03:27 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.242])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 589D818004A3; Sun, 10 May 2026 17:03:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 3/5] ethdev: hide VMDq internal sizes
Date: Sun, 10 May 2026 19:03:03 +0200
Message-ID: <20260510170306.3406045-4-david.marchand@redhat.com>
In-Reply-To: <20260510170306.3406045-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260510170306.3406045-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hwhRlG9NoFq8iLY1yUOXz4tjVBhSOtw13gALMAq90tM_1778432607
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
Changes since v2:
- added an entry in release notes,

---
 doc/guides/rel_notes/release_26_07.rst | 3 +++
 lib/ethdev/ethdev_driver.h             | 8 +++++++-
 lib/ethdev/rte_ethdev.h                | 6 ------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 3d2e71102b..b425e6f8cd 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -99,6 +99,9 @@ API Changes
     ``RTE_ETH_MQ_TX_VMDQ_ONLY``).
   * A check was added in ``rte_eth_dev_mac_addr_add`` to validate that the ``pool`` parameter is 0
     when VMDq is not configured.
+  * The ``RTE_ETH_NUM_RECEIVE_MAC_ADDR`` and ``RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY`` macros are VMDq
+    related and are sizes of internal arrays in ethdev that only drivers need to care about.
+    Those macros are moved to the driver only ethdev API.
 
 
 ABI Changes
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
index 0d8e2d0236..27d2ddc0c1 100644
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

