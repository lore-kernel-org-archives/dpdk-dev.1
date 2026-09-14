Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65343C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 08:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4CF340A70;
	Mon, 14 Sep 2026 10:17:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 71D14402DF
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789373874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hrp15elGg4t0W9bh9+PI9y5f58iX5vi+R9/NaTgVJUg=;
 b=VolhXTwh4g1MZ6p91dZm1a9FBOzt3P4eoA3/mRn2YRr31DQ6VdMU+SwUtQEGjhJKlDJ7B3
 9DRI0A9mybDqGiptvWjw/UDsjWE4vbSzXpTab3r7sPrc/nNhCuI6T0DxL8eRbTw10NTGs6
 o41Xho/8oQ+fRXAERsud6i7heuMvt5c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-Y_2UCPhkMzuc0tT3PHWiiw-1; Mon,
 14 Sep 2026 04:17:50 -0400
X-MC-Unique: Y_2UCPhkMzuc0tT3PHWiiw-1
X-Mimecast-MFC-AGG-ID: Y_2UCPhkMzuc0tT3PHWiiw_1789373869
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E94F180135A; Mon, 14 Sep 2026 08:17:49 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C83BE1956086; Mon, 14 Sep 2026 08:17:47 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com, anatoly.burakov@intel.com, rjarry@redhat.com,
 cfontain@redhat.com, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v7 4/4] net/iavf: accept up to 32k unicast MAC addresses
Date: Mon, 14 Sep 2026 10:17:25 +0200
Message-ID: <20260914081725.1097704-4-david.marchand@redhat.com>
In-Reply-To: <20260914081725.1097704-1-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cThN35sYePPWP05CGDuHewrY5Im36lM_0WM2pzZK-FY_1789373869
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

E810 hardware provides 32k switch lookups.
Thanks to this, it is possible to allow a lot more secondary mac
addresses than what is possible today.

In practice, the maximum number of macs available per port may be lower
and depends on usage by other (trusted?) VFs on the same PF.
There is no way to figure out this limit but to try adding a mac address
and get an error from the PF driver.

Mailbox exchanges are limited to IAVF_AQ_BUF_SZ, segment messages
accordingly.

Since unicast and multicast addresses arrays are sized with two
different constants, prefer RTE_DIM() whenever possible.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v6:
- reused helper added in previous commit,
- used RTE_DIM() instead of macro constants,

Changes since v5:
- separated from series that went in next-net,
- rebased,

Changes since v4:
- rebased,

Changes since v2:
- added an entry in release notes,
- removed unneeded temp variable,

Changes since v1:
- fixed buffer overflow on mailbox messages during port restart/VF reset,

---
 doc/guides/rel_notes/release_26_11.rst |  4 ++++
 drivers/net/intel/iavf/iavf.h          |  7 ++++---
 drivers/net/intel/iavf/iavf_ethdev.c   |  7 +++----
 drivers/net/intel/iavf/iavf_vchnl.c    | 10 ++++++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6c29513041..5a4c7d815d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,10 @@ New Features
   * Renamed the ``enable_ptype_lldp`` devarg to ``enable_lldp``.
     The old name is no longer accepted.
 
+  * Increased the maximum number of secondary unicast MAC addresses
+    from 64 to 32k.
+    This increases a VF port memory footprint by ~192kB.
+
 * **Updated Intel ixgbe driver.**
 
   Added ``fdir_buffer_size`` devarg to select the Flow Director table size
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 34b9b4ad94..f3f2b4ae51 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -32,7 +32,8 @@
 #define IAVF_IRQ_MAP_NUM_PER_BUF	 128
 #define IAVF_RXTX_QUEUE_CHUNKS_NUM	 2
 
-#define IAVF_NUM_MACADDR_MAX      64
+#define IAVF_UC_MACADDR_MAX      32768
+#define IAVF_MC_MACADDR_MAX      64
 
 #define IAVF_DEV_WATCHDOG_PERIOD     2000 /* microseconds, set 0 to disable*/
 
@@ -256,10 +257,10 @@ struct iavf_info {
 	uint32_t link_speed;
 
 	/* Unicast addrs */
-	struct rte_ether_addr mac_addrs[IAVF_NUM_MACADDR_MAX];
+	struct rte_ether_addr mac_addrs[IAVF_UC_MACADDR_MAX];
 
 	/* Multicast addrs */
-	struct rte_ether_addr mc_addrs[IAVF_NUM_MACADDR_MAX];
+	struct rte_ether_addr mc_addrs[IAVF_MC_MACADDR_MAX];
 	uint16_t mc_addrs_num;   /* Multicast mac addresses number */
 
 	struct iavf_vsi vsi;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index f7aeac8c83..2d055e6f5b 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -411,10 +411,9 @@ iavf_set_mc_addr_list(struct rte_eth_dev *dev,
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	int err, ret;
 
-	if (mc_addrs_num > IAVF_NUM_MACADDR_MAX) {
-		PMD_DRV_LOG(ERR,
-			    "can't add more than a limited number (%u) of addresses.",
-			    (uint32_t)IAVF_NUM_MACADDR_MAX);
+	if (mc_addrs_num > RTE_DIM(vf->mc_addrs)) {
+		PMD_DRV_LOG(ERR, "can't add more than a limited number (%u) of addresses.",
+			(unsigned int)RTE_DIM(vf->mc_addrs));
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index decfae3182..418a7e897e 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1712,8 +1712,8 @@ iavf_send_eth_addr_list(struct iavf_adapter *adapter, const char *caller,
 void
 iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add)
 {
+	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(IAVF_ETH_ADDR_PER_REQ)] = {0};
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
-	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(RTE_DIM(vf->mac_addrs))] = {0};
 	struct virtchnl_ether_addr_list *list;
 
 	list = (struct virtchnl_ether_addr_list *)cmd_buffer;
@@ -1730,6 +1730,12 @@ iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add)
 			memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr->addr_bytes));
 			vc_addr->type = VIRTCHNL_ETHER_ADDR_EXTRA;
 		}
+
+		if (list->num_elements == IAVF_ETH_ADDR_PER_REQ) {
+			if (iavf_send_eth_addr_list(adapter, __func__, list, add))
+				return;
+			list->num_elements = 0;
+		}
 	}
 
 	if (list->num_elements != 0)
@@ -2308,8 +2314,8 @@ iavf_add_del_mc_addr_list(struct iavf_adapter *adapter,
 			struct rte_ether_addr *mc_addrs,
 			uint32_t mc_addrs_num, bool add)
 {
-	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(IAVF_NUM_MACADDR_MAX)] = {0};
 	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
+	uint8_t cmd_buffer[IAVF_ETH_ADDR_CMD_SIZE(RTE_DIM(vf->mc_addrs))] = {0};
 	struct virtchnl_ether_addr_list *list;
 	uint32_t i;
 
-- 
2.54.0

