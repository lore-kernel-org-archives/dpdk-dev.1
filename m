Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5D5CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 13:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5962340695;
	Fri, 16 Oct 2026 15:06:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9D21D4068E
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792155984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ukFR+j/uJ5V5CTt8/HsCPEw/xZ8kFj1tcR2uuexWP4=;
 b=M9618v6nwIFrcISVJCsDnFggCa8kCMkl+3G0VlF/RwAce2fKAhW/21Q0eLdtxRND9wbvQg
 I001kFvALM6S4QTe6jElHUtuqM6T6k1N4KMe9einetGOMQI7809M5a9ZJqTH6YLWsjn0TA
 L28tG3mhp2L03GqckII8tgDEZWUogWs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-npcRe6XCOtWDy9p8Y_i1Ug-1; Fri,
 16 Oct 2026 13:06:22 +0000
X-MC-Unique: npcRe6XCOtWDy9p8Y_i1Ug-1
X-Mimecast-MFC-AGG-ID: npcRe6XCOtWDy9p8Y_i1Ug_1792155981
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBE3918011ED; Fri, 16 Oct 2026 13:06:21 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CF22362; Fri, 16 Oct 2026 13:06:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 5/8] ethdev: check DCB availability
Date: Fri, 16 Oct 2026 15:05:51 +0200
Message-ID: <20261016130555.1685102-6-david.marchand@redhat.com>
In-Reply-To: <20261016130555.1685102-1-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xPi7GgLrxRzhKBFfbPNM6TlARBSYgGOR-LibSu4Tpp0_1792155981
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

Add DCB capability check in rte_eth_dev_configure() using
dev->dev_ops->get_dcb_info.

When NULL, reject Rx modes with RTE_ETH_MQ_RX_DCB_FLAG and
Tx modes RTE_ETH_MQ_TX_DCB and RTE_ETH_MQ_TX_VMDQ_DCB.
Remove redundant DCB checks from drivers.

Check that documentation is aligned with driver code.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 devtools/check-doc-vs-code.sh          | 14 +++++++++++++-
 doc/guides/rel_notes/release_26_11.rst | 11 ++++++++---
 drivers/net/intel/e1000/igb_ethdev.c   |  6 ------
 drivers/net/intel/fm10k/fm10k_ethdev.c |  5 -----
 lib/ethdev/rte_ethdev.c                | 16 ++++++++++++++++
 5 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/devtools/check-doc-vs-code.sh b/devtools/check-doc-vs-code.sh
index 7936f8b69f..81c9713f5a 100755
--- a/devtools/check-doc-vs-code.sh
+++ b/devtools/check-doc-vs-code.sh
@@ -77,6 +77,18 @@ check_mq_caps() # <driver>
 	[ -d $code ] || return 0
 	[ -f $doc ] || return 0
 
+	if all_docs_agree $1 "DCB"; then
+		if has_doc_feature "$doc" "DCB"; then
+			git grep -q '\.get_dcb_info[[:space:]]*=' -- "$code" ||
+				error "DCB documented but no get_dcb_info callback for $1"
+		else
+			! git grep -q '\.get_dcb_info[[:space:]]*=' -- "$code" ||
+				error "get_dcb_info callback but DCB not documented for $1"
+			! git grep -qE 'RTE_ETH_MQ_(RX|TX).*DCB' -- "$code" ||
+				error "DCB mq_mode referenced but DCB not documented for $1"
+		fi
+	fi
+
 	if all_docs_agree $1 "VMDq"; then
 		if has_doc_feature "$doc" "VMDq"; then
 			git grep -qE 'max_vmdq_pools[[:space:]]*=' -- "$code" ||
@@ -119,7 +131,7 @@ if has_code_change 'RTE_FLOW_.*_TYPE_' ||
 		check_rte_flow $driver
 	done
 fi
-if has_code_change 'max_vmdq_pools\|RTE_ETH_MQ_.*VMDQ' ||
+if has_code_change 'get_dcb_info\|max_vmdq_pools\|RTE_ETH_MQ_.*DCB\|RTE_ETH_MQ_.*VMDQ' ||
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

