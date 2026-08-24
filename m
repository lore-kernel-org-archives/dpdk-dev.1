Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AEFC5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 11:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DB304068E;
	Mon, 24 Aug 2026 13:42:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6C5F54027C
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787571764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUBlIlelFsjyDF3JkO55WIOMIAkzJaHO1nMvZoNqpY4=;
 b=TUocEHPxihLO1/CwG0HFdwvSaF2ay1XqJY9DEG1wu3PNVuABLJI9jvGhmoEgp0japbBuKG
 rycBlFtfvOORcLpD7E5M4adPzboJD7kZwRDRVOtLpUDBaPUwh+Oth9jmolFTuI4WP7CO4r
 y3E57C8nL0eUW8qTOHhoRaXT+OLVeUU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-DM_n1qXHMRuwfx6a8ibMUA-1; Mon,
 24 Aug 2026 07:42:41 -0400
X-MC-Unique: DM_n1qXHMRuwfx6a8ibMUA-1
X-Mimecast-MFC-AGG-ID: DM_n1qXHMRuwfx6a8ibMUA_1787571761
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DA0E182A100; Mon, 24 Aug 2026 11:42:40 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82FDB1955DAA; Mon, 24 Aug 2026 11:42:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, cfontain@redhat.com,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v6 3/3] ethdev: hide VMDq internal sizes
Date: Mon, 24 Aug 2026 13:42:07 +0200
Message-ID: <20260824114207.312513-4-david.marchand@redhat.com>
In-Reply-To: <20260824114207.312513-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260824114207.312513-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kOCWZpteLnHZKaEkimVexPgF6DtwqK2omMad2Fo2A2Q_1787571761
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
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
Changes since v4:
- rebased,

Changes since v2:
- added an entry in release notes,

---
 doc/guides/rel_notes/release_26_11.rst | 3 +++
 lib/ethdev/ethdev_driver.h             | 8 +++++++-
 lib/ethdev/rte_ethdev.h                | 6 ------
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 40a301acf9..1d2de68715 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -100,6 +100,9 @@ API Changes
     ``RTE_ETH_MQ_TX_VMDQ_ONLY``).
   * A check was added in ``rte_eth_dev_mac_addr_add`` to validate that the ``pool`` parameter is 0
     when VMDq is not configured.
+  * The ``RTE_ETH_NUM_RECEIVE_MAC_ADDR`` and ``RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY`` macros are VMDq
+    related and are sizes of internal arrays in ethdev that only drivers need to care about.
+    Those macros are moved to the driver only ethdev API.
 
 
 ABI Changes
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..294f68504b 100644
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
index e2a5ba1549..bee47549cb 100644
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
2.54.0

