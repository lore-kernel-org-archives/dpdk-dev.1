Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C26DCA5FE0
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76F6942E8C;
	Fri,  2 Oct 2026 21:44:11 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id 881C64003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 21:44:09 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:31a0:0:640:75ad:0])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id E53DC868A7;
 Fri, 02 Oct 2026 22:44:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id hhroUtamROs0-Tw3wPf85; 
 Fri, 02 Oct 2026 22:44:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790970248; bh=VLlDOMYoChVvUAVUF4p/T2JBTxv8tjZflutTpsGJwjg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qcGgo7p4/rK8UOj++5/eZGNIk35VNPLuCP2iEEL2a/0U3AivFFt7C6/4gF3xnFAR3
 NRchuCnpWKXAtEUoPjeRqX3fE/oPkl9A2K+pExhe3DmsohWGX8jE4rypO+B4LwYgvB
 u5MGgNOSS+y7K63Q9RtT2/Ky9jh4qjtuVe5SaTcc=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/3] net/i40e: make link state configurable on device start
Date: Fri,  2 Oct 2026 21:43:37 +0200
Message-ID: <f5d57ce8991bcd62a3e15b17ffcdfcc772a5767c.1790970122.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790970122.git.roma55592@yandex.ru>
References: <cover.1790970122.git.roma55592@yandex.ru>
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

The device start always applies the link configuration, which brings
the link up, so the port shows up on the link partner as soon as
the application starts it, even if the application wants to enable
it later, for example only after its configuration is applied.

Introduce the device argument link_state_on_start, as for the ice
driver:
1. up: bring the link up (default, unchanged behavior)
2. down: bring (or keep) the link down; the application brings it up
   later with rte_eth_dev_set_link_up(), which applies the link
   configuration.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 doc/guides/nics/i40e.rst               | 13 ++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 drivers/net/intel/i40e/i40e_ethdev.c   | 58 +++++++++++++++++++++++++-
 drivers/net/intel/i40e/i40e_ethdev.h   |  2 +
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 29234dbf0f..1242737611 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -193,6 +193,19 @@ Runtime Configuration
   * ``segment``: Check number of mbuf segments not exceed hw limitation.
   * ``offload``: Check any unsupported offload flag.
 
+- ``Link state on start`` (default ``up``)
+
+  The user can request that the link be kept down when the device is started,
+  so that the port does not show up on the link partner until the application
+  calls ``rte_eth_dev_set_link_up()``::
+
+    -a 84:00.0,link_state_on_start=<state>
+
+  Supported values for the ``<state>`` parameter:
+
+  * ``up``: Bring the link up.
+  * ``down``: Bring (or keep) the link down.
+
 QinQ Configuration
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a7fda78c5b..f5831a7e4e 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -74,6 +74,11 @@ New Features
     ``xdp_meta_rx_ts_valid_mask``.
   * Added ``read_clock`` operation to query the PTP hardware clock.
 
+* **Updated Intel i40e driver.**
+
+  * Added ``link_state_on_start`` devarg to keep the link down
+    when the device is started.
+
 * **Updated Intel iavf driver.**
 
   * Runtime Rx/Tx queue setup is now automatically disabled
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 5d6102cae7..bc5adffbbc 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -49,6 +49,7 @@
 #define ETH_I40E_QUEUE_NUM_PER_VF_ARG	"queue-num-per-vf"
 #define ETH_I40E_VF_MSG_CFG		"vf_msg_cfg"
 #define ETH_I40E_MBUF_CHECK_ARG       "mbuf_check"
+#define ETH_I40E_LINK_STATE_ON_START  "link_state_on_start"
 
 #define I40E_CLEAR_PXE_WAIT_MS     200
 #define I40E_VSI_TSR_QINQ_STRIP		0x4010
@@ -418,6 +419,7 @@ static const char *const valid_keys[] = {
 	ETH_I40E_QUEUE_NUM_PER_VF_ARG,
 	ETH_I40E_VF_MSG_CFG,
 	ETH_I40E_MBUF_CHECK_ARG,
+	ETH_I40E_LINK_STATE_ON_START,
 	NULL};
 
 static const struct rte_pci_id pci_id_i40e_map[] = {
@@ -1332,6 +1334,53 @@ i40e_support_multi_driver(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+i40e_parse_link_state_on_start_handler(const char *key, const char *value,
+				       void *opaque)
+{
+	bool *link_down = opaque;
+
+	if (value == NULL || link_down == NULL)
+		return -EINVAL;
+
+	if (strcmp(value, "down") == 0) {
+		*link_down = true;
+	} else if (strcmp(value, "up") == 0) {
+		*link_down = false;
+	} else {
+		PMD_DRV_LOG(WARNING, "%s: Invalid value \"%s\", "
+			    "should be \"down\" or \"up\"", key, value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+i40e_parse_link_state_on_start(struct rte_eth_dev *dev)
+{
+	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+	struct rte_kvargs *kvlist;
+	int ret;
+
+	/* Bring the link up on device start by default */
+	pf->link_down_on_start = false;
+
+	if (!dev->device->devargs)
+		return 0;
+
+	kvlist = rte_kvargs_parse(dev->device->devargs->args, valid_keys);
+	if (!kvlist)
+		return -EINVAL;
+
+	ret = rte_kvargs_process(kvlist, ETH_I40E_LINK_STATE_ON_START,
+				 i40e_parse_link_state_on_start_handler,
+				 &pf->link_down_on_start);
+
+	rte_kvargs_free(kvlist);
+	return ret;
+}
+
 static int
 i40e_aq_debug_write_global_register(struct i40e_hw *hw,
 				    uint32_t reg_addr, uint64_t reg_val,
@@ -1593,6 +1642,7 @@ eth_i40e_dev_init(struct rte_eth_dev *dev, void *init_params __rte_unused)
 	i40e_parse_mbuf_check(dev);
 	/* Check if need to support multi-driver */
 	i40e_support_multi_driver(dev);
+	i40e_parse_link_state_on_start(dev);
 
 	/* Make sure all is clean before doing PF reset */
 	i40e_clear_hw(hw);
@@ -2551,7 +2601,10 @@ i40e_dev_start(struct rte_eth_dev *dev)
 	}
 
 	/* Apply link configure */
-	ret = i40e_apply_link_speed(dev);
+	if (pf->link_down_on_start)
+		ret = i40e_dev_set_link_down(dev);
+	else
+		ret = i40e_apply_link_speed(dev);
 	if (I40E_SUCCESS != ret) {
 		PMD_DRV_LOG(ERR, "Fail to apply link setting");
 		goto tx_err;
@@ -12500,4 +12553,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_i40e,
 			      ETH_I40E_FLOATING_VEB_ARG "=1"
 			      ETH_I40E_FLOATING_VEB_LIST_ARG "=<string>"
 			      ETH_I40E_QUEUE_NUM_PER_VF_ARG "=1|2|4|8|16"
-			      ETH_I40E_SUPPORT_MULTI_DRIVER "=1");
+			      ETH_I40E_SUPPORT_MULTI_DRIVER "=1"
+			      ETH_I40E_LINK_STATE_ON_START "=<down|up>");
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 1e64a2d280..c4ddfab0be 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1203,6 +1203,8 @@ struct i40e_pf {
 	bool fw8_3gt;
 	/* MAC config needs re-applying when link first comes up */
 	bool mac_config_on_link_up;
+	/* Keep the link down on device start */
+	bool link_down_on_start;
 	/* true when interrupt path unavailable */
 	bool use_aq_polling;
 
-- 
2.47.3

