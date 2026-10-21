Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA0606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OlPZuOsV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA64D40B9D;
	Wed, 21 Oct 2026 12:31:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C110E406A2
 for <dev@dpdk.org>; Wed, 21 Oct 2026 12:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792578679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLMVtzMOX+/w3w1n28G5qD+ffyMjK+zuZQqUH4+9ZjY=;
 b=OlPZuOsVvBV35fzFd31NEgNNfOJy0fWUZJFnMm606rDDh91bLw+6iI4VNYmFhBG2sxNDUE
 ivEGUDrKcqIQfY5m8yqYccHAHY3pY++uRVQDa8PswunbtRFG/KR91+K4127H907TryBEEv
 bDTsrEKM95+5DYN+grLwNUF8Wwd1R5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-RUFruD6VMia_FO5MGiF8fw-1; Wed,
 21 Oct 2026 10:31:10 +0000
X-MC-Unique: RUFruD6VMia_FO5MGiF8fw-1
X-Mimecast-MFC-AGG-ID: RUFruD6VMia_FO5MGiF8fw_1792578669
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1E3D180049D; Wed, 21 Oct 2026 10:31:08 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78E141956087; Wed, 21 Oct 2026 10:31:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 09/12] ethdev: check DCB availability
Date: Wed, 21 Oct 2026 12:30:23 +0200
Message-ID: <20261021103027.2050351-10-david.marchand@redhat.com>
In-Reply-To: <20261021103027.2050351-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xGXYcl0Wzxd4XfZUDSVGuDR9ECoF7jRQcPq-PQYdGsU_1792578669
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add DCB capability check in rte_eth_dev_configure() using
dev->dev_ops->get_dcb_info.

When NULL, reject Rx modes with RTE_ETH_MQ_RX_DCB_FLAG and
Tx modes RTE_ETH_MQ_TX_DCB and RTE_ETH_MQ_TX_VMDQ_DCB.
Remove redundant DCB checks from drivers.

Check that documentation is aligned with driver code.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/check-doc-vs-code.sh          |  4 +++-
 doc/guides/rel_notes/release_26_11.rst | 11 ++++++++---
 drivers/net/intel/e1000/igb_ethdev.c   |  6 ------
 drivers/net/intel/fm10k/fm10k_ethdev.c |  5 -----
 lib/ethdev/rte_ethdev.c                | 16 ++++++++++++++++
 5 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index eeb235ae61..d4e045ca2c 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -181,6 +181,8 @@ check_mq_caps() # <driver>
 	[ -d $code ] || return 0
 	[ -f $doc ] || return 0
 
+	check_mq_cap $1 "DCB" "get_dcb_info" '\.get_dcb_info[[:space:]]*=' \
+		'RTE_ETH_MQ_(RX|TX).*DCB'
 	check_mq_cap $1 "VMDq" "max_vmdq_pools" 'max_vmdq_pools[[:space:]]*=' \
 		'RTE_ETH_MQ_(RX|TX).*VMDQ'
 }
@@ -201,7 +203,7 @@ if has_code_change 'RTE_FLOW_.*_TYPE_' ||
 		check_rte_flow $driver
 	done
 fi
-if has_code_change 'max_vmdq_pools|RTE_ETH_MQ_.*VMDQ' ||
+if has_code_change 'get_dcb_info|max_vmdq_pools|RTE_ETH_MQ_.*DCB|RTE_ETH_MQ_.*VMDQ' ||
 		has_file_change 'doc/guides/nics/features'; then
 	for driver in $(changed_net_drivers); do
 		check_mq_caps $driver
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..9341769c32 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -424,11 +424,16 @@ API Changes
   * Removed the ``unused`` field.
   * Changed the ``objs`` array from fixed size to variable size.
 
+* ethdev: Updated multi-queue mode validation at port configuration time:
+
+  * DCB modes (Rx ``RTE_ETH_MQ_RX_DCB_FLAG``, Tx ``RTE_ETH_MQ_TX_DCB``/``RTE_ETH_MQ_TX_VMDQ_DCB``)
+    are rejected if the driver has no ``get_dcb_info`` callback.
+  * VMDq modes (Rx ``RTE_ETH_MQ_RX_VMDQ_FLAG``,
+    Tx ``RTE_ETH_MQ_TX_VMDQ_DCB``/``RTE_ETH_MQ_TX_VMDQ_ONLY``) are rejected
+    if the driver reports no VMDq pool.
+
 * ethdev: Updated VMDq related API.
 
-  * At port configuration time, the number of VMDq pools advertised by a driver
-    is now used to validate VMDq related Rx and Tx modes
-    (``RTE_ETH_MQ_RX_VMDQ_FLAG``, ``RTE_ETH_MQ_TX_VMDQ_DCB``, ``RTE_ETH_MQ_TX_VMDQ_ONLY``).
   * A check was added in ``rte_eth_dev_mac_addr_add`` to validate that
     the ``pool`` parameter is 0 when VMDq is not configured.
   * The ``RTE_ETH_NUM_RECEIVE_MAC_ADDR`` and ``RTE_ETH_VMDQ_NUM_UC_HASH_ARRAY`` macros
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 524c030be6..181af58169 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -1144,12 +1144,6 @@ igb_check_mq_mode(struct rte_eth_dev *dev)
 	uint16_t nb_rx_q = dev->data->nb_rx_queues;
 	uint16_t nb_tx_q = dev->data->nb_tx_queues;
 
-	if ((rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) ||
-	    tx_mq_mode == RTE_ETH_MQ_TX_DCB ||
-	    tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB) {
-		PMD_INIT_LOG(ERR, "DCB mode is not supported.");
-		return -EINVAL;
-	}
 	if (RTE_ETH_DEV_SRIOV(dev).active != 0) {
 		/* Check multi-queue mode.
 		 * To no break software we accept RTE_ETH_MQ_RX_NONE as this might
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 9b123c0b2c..5aa15a8dba 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -416,11 +416,6 @@ fm10k_check_mq_mode(struct rte_eth_dev *dev)
 
 	vmdq_conf = &dev->data->dev_conf.rx_adv_conf.vmdq_rx_conf;
 
-	if (rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
-		PMD_INIT_LOG(ERR, "DCB mode is not supported.");
-		return -EINVAL;
-	}
-
 	if (!(rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG))
 		return 0;
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f843e8808a..39a895c9e4 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1573,6 +1573,22 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
+	if (dev->dev_ops->get_dcb_info == NULL) {
+		if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) != 0) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support DCB rx mode",
+				port_id);
+			ret = -EINVAL;
+			goto rollback;
+		}
+		if (dev_conf->txmode.mq_mode == RTE_ETH_MQ_TX_DCB ||
+				dev_conf->txmode.mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB) {
+			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support DCB tx mode",
+				port_id);
+			ret = -EINVAL;
+			goto rollback;
+		}
+	}
+
 	if (dev_info.max_vmdq_pools == 0) {
 		if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) != 0) {
 			RTE_ETHDEV_LOG_LINE(ERR, "Ethdev port_id=%u does not support VMDq rx mode",
-- 
2.54.0

