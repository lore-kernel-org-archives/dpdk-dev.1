Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BA0CA5FE0
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 19:44:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5107442EA3;
	Fri,  2 Oct 2026 21:44:13 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 5831342E4C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 21:44:10 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:31a0:0:640:75ad:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 71BC285EE1;
 Fri, 02 Oct 2026 22:44:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id hhroUtamROs0-2Eaa2dgV; 
 Fri, 02 Oct 2026 22:44:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790970249; bh=xrektiTtLozxfM2aG+rRwHA/voENZ9jpI0O+IOPO+HY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=NK8UlcJBWI3YRceuu8eZaFzkhN0SsaSKTqzxfflTuGjE+bKfAqe8ZR266ehKc636z
 9HHO84NviwntWkqmZOGcUJG0EtZpJhqabFk15oI+vvcpvDS2EYIPRYwU6yrmW2gRbh
 2LKfi4zjojMNVb56Aw6sMLg2WivQ71c3HNftFotY=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 3/3] net/ixgbe: make link state configurable on device start
Date: Fri,  2 Oct 2026 21:43:38 +0200
Message-ID: <06e601f4c79a25ea183559dfadfd8e6938f5bb04.1790970122.git.roma55592@yandex.ru>
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

The device start always turns on the laser or the copper PHY and
sets up the link, so the port shows up on the link partner as soon
as the application starts it, even if the application wants to
enable it later, for example only after its configuration is applied.

Introduce the device argument link_state_on_start, as for the ice
and i40e drivers:
1. up: bring the link up (default, unchanged behavior)
2. down: keep the laser off on fiber links and leave the port in the
   same state as after rte_eth_dev_set_link_down(); the application
   brings it up later with rte_eth_dev_set_link_up().

On copper links the PHY is still powered on to set up the link
and powered off right after it.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 doc/guides/nics/ixgbe.rst              | 13 ++++++++
 doc/guides/rel_notes/release_26_11.rst |  6 ++--
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 44 ++++++++++++++++++++++++--
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 ++
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index 1d14e292e2..dbf0c2c5e4 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -187,6 +187,19 @@ It must be passed as part of EAL arguments. For example,
   This value is read only at probe time.
   Changing it requires restarting the process with a new EAL argument.
 
+- ``link_state_on_start`` (default **up**)
+
+  The user can request that the link be kept down when the device is started,
+  so that the port does not show up on the link partner until the application
+  calls ``rte_eth_dev_set_link_up()``::
+
+    -a 81:00.0,link_state_on_start=<state>
+
+  Supported values for the ``<state>`` parameter:
+
+  * ``up``: Bring the link up.
+  * ``down``: Turn off the laser on fiber links or the PHY on copper links.
+
 .. note::
 
    The driver rejects Flow Director when DCB is enabled.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index f5831a7e4e..3aadcf94a1 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -100,8 +100,10 @@ New Features
 
 * **Updated Intel ixgbe driver.**
 
-  Added ``fdir_buffer_size`` devarg to select the Flow Director table size
-  (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
+  * Added ``fdir_buffer_size`` devarg to select the Flow Director table size
+    (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
+  * Added ``link_state_on_start`` devarg to keep the link down
+    when the device is started.
 
 * **Updated NXP DPAA2 ethernet driver.**
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 1745070e59..2adedaff8e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -130,10 +130,12 @@
 
 #define IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE	"fiber_sdp3_no_tx_disable"
 #define IXGBE_DEVARG_FDIR_BUFFER_SIZE		"fdir_buffer_size"
+#define IXGBE_DEVARG_LINK_STATE_ON_START	"link_state_on_start"
 
 static const char * const ixgbe_valid_arguments[] = {
 	IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
 	IXGBE_DEVARG_FDIR_BUFFER_SIZE,
+	IXGBE_DEVARG_LINK_STATE_ON_START,
 	NULL
 };
 
@@ -985,6 +987,27 @@ devarg_handle_fdir_buffer_size(const char *key, const char *value,
 	return 0;
 }
 
+static int
+devarg_handle_link_state_on_start(const char *key, const char *value,
+				  void *extra_args)
+{
+	bool *link_down = extra_args;
+
+	if (value == NULL || extra_args == NULL)
+		return -EINVAL;
+
+	if (strcmp(value, "down") == 0) {
+		*link_down = true;
+	} else if (strcmp(value, "up") == 0) {
+		*link_down = false;
+	} else {
+		PMD_INIT_LOG(ERR, "invalid %s='%s', use down or up", key, value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 		      struct rte_devargs *devargs)
@@ -1016,6 +1039,12 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 			adapter->fdir_conf.pballoc = pballoc;
 	}
 
+	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_LINK_STATE_ON_START) != 0 &&
+	    rte_kvargs_process(kvlist, IXGBE_DEVARG_LINK_STATE_ON_START,
+			       devarg_handle_link_state_on_start,
+			       &adapter->link_down_on_start) != 0)
+		ret = -EINVAL;
+
 	rte_kvargs_free(kvlist);
 	return ret;
 }
@@ -2720,8 +2749,11 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	}
 
 	if (hw->mac.ops.get_media_type(hw) == ixgbe_media_type_copper) {
-		/* Turn on the copper */
+		/* Turn on the copper, the PHY is needed to set up the link */
 		ixgbe_set_phy_power(hw, true);
+	} else if (adapter->link_down_on_start) {
+		/* Keep the laser off */
+		ixgbe_disable_tx_laser(hw);
 	} else {
 		/* Turn on the laser */
 		ixgbe_enable_tx_laser(hw);
@@ -2806,6 +2838,13 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	if (err)
 		goto error;
 
+	if (adapter->link_down_on_start) {
+		/* The link is brought up later by ixgbe_dev_set_link_up() */
+		err = ixgbe_dev_set_link_down(dev);
+		if (err)
+			goto error;
+	}
+
 skip_link_setup:
 
 	if (rte_intr_allow_others(intr_handle)) {
@@ -8661,7 +8700,8 @@ RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe, pci_id_ixgbe_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ixgbe,
 			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>"
-			      IXGBE_DEVARG_FDIR_BUFFER_SIZE "=<64k|128k|256k>");
+			      IXGBE_DEVARG_FDIR_BUFFER_SIZE "=<64k|128k|256k>"
+			      IXGBE_DEVARG_LINK_STATE_ON_START "=<down|up>");
 RTE_PMD_REGISTER_PCI(net_ixgbe_vf, rte_ixgbevf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe_vf, pci_id_ixgbevf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe_vf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 2e9d166e29..60206d00d5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -492,6 +492,8 @@ struct ixgbe_adapter {
 
 	/* Used for limiting SDP3 TX_DISABLE checks */
 	uint8_t sdp3_no_tx_disable;
+	/* Keep the link down on device start */
+	bool link_down_on_start;
 	uint16_t max_vfs;
 
 	/* Used for VF link sync with PF's physical and logical (by checking
-- 
2.47.3

