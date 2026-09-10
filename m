Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4FDC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 15:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 562B840274;
	Thu, 10 Sep 2026 17:58:33 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 2BB1C4025F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 17:58:32 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fe517774so30718445ad.0
 for <dev@dpdk.org>; Thu, 10 Sep 2026 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789055911; x=1789660711; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gzKPJJclZlV0GqqBgXr/rUuekauoMKIvd8P0MdW1qwU=;
 b=QxeVwgOxc0l6kyWEJ5wlpSu9aNFKV+YDUwCuJsV35aSSLBDl4eHwyBjdjAHnJyobCd
 8YJq0cegOWVot7uPQCtEvdbRTGnZNzgpm4XCp4nRln2jNEUJvFKT+xah4hNbUQ++i8sx
 Mt2Er+ooaBykrddMBOzbO9OyQPJr7gmo7UrIWZaSigQMNtNZjfb0rFhxAJgZ7i3/Xo8d
 BFU9teC3hVeHr4oHVmbmMxNwS4QQIymSPao32EYhr746i0hU+TKP1IIqe/Ry9glr6Ez2
 3Tswc+av8e44P5Vumu6SCyQZaI7OCFmxlfHXmVD/HBnMdc0JxNCzeuOyLb2qPpVkCvFb
 drbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789055911; x=1789660711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gzKPJJclZlV0GqqBgXr/rUuekauoMKIvd8P0MdW1qwU=;
 b=Jacruy5RrBzpZFfrK2crH06XBd9NnRKIXEKJxdTaC3UrI3B+qFo9rfNtiLEte6vBvl
 zkFmkt1mXgaIPnNUIBhQov2xFy9vgZPVGCgI/w7D087334Mv7GcpyUuW5SixKZE/bGZy
 yjLxuFoipc/3oXg8wwt1f/18om8o7d5ZSWmxFfn5Ed4U5xmFx7Ex9Ay4S3arKHcifrH9
 aZzYIL0jiXkRLHQz1zxhly9A0rCyUUncploqbywxLRo3bum+yq5z6WujzLdXSujdgOm+
 ytjTHhLSWUK0WwPBDwmS+eFDMUaCs0/fpq3sMm7JCFNos2zXLHj12dm6SIBvWMIwmQWW
 jVew==
X-Gm-Message-State: AFuF++lN6tmIjWNGVyQd6OkmQs1o5aAJ0NBvvDeHIdJUE9Xx6TBhOT5j
 x5bWMRXS3FMGMeDsiCmg5WeofjvC4f+p94+eFV3K6hFboyYUPor6LcqJ
X-Gm-Gg: AYBFou0CP8DVAIquwU+7ck01rxJqdRabj8rNz8sYuDhjrD+c62GHJwdqF1hBICZSlRM
 ZVIvw+OPxjVzbRhJbH4A24L6q+oITj+mdZhv8lCkPD3W04khLWKMVKKrN9F2Le/PEZKMot9Qmh/
 PvZRQPZm02rLGmIn9tIyjs2DJ2hpKUs8+BLcA3scRl20aXYtx4IyaFz29Ugb1+6HJzkML5o/wQa
 UgZA2yWOLtsvoBNCadPOZNWPS0OWeK3JpAN8L5ro68ovaWV8VYozzB/pEz7f3jKhVUtNzrq+n4l
 KQVBRB7HAv9HV7/Bbtni/hzq55G7WnoMfQM0PngPGP+KLbR3a7r4wo45xKaaCSLxXAi13tPq8ni
 ZQl2cdqRMDBeUpdrohQtRNvBkcIJl80c5coOp1aZ1qJOabgVZFTYpXjsGbGQKg1jWK/ocSt1p3J
 vEMHTu+sXDByVBU2XyMIsQZpPbuJQFvusZZYN1wFyJIVtKpOWHMIwHF2X47citutpiybtk+HHML
 vpW
X-Received: by 2002:a17:902:ce10:b0:2db:3729:22de with SMTP id
 d9443c01a7336-2dd29e0ecddmr2692745ad.0.1789055910933; 
 Thu, 10 Sep 2026 08:58:30 -0700 (PDT)
Received: from fedora (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1483dbddsm89853125ad.12.2026.09.10.08.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:58:30 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH v2] net/ixgbe: add fdir_buffer_size devarg
Date: Thu, 10 Sep 2026 23:58:12 +0800
Message-ID: <20260910155812.127658-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908155858.126042-1-zhtfdev@gmail.com>
References: <20260908155858.126042-1-zhtfdev@gmail.com>
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

After public fdir_conf was removed from rte_eth_conf, the private
pballoc field stays at the 64K default. Add a probe-time devarg so
applications can select 128K or 256K Flow Director table size.

Reject Flow Director with DCB in ixgbe_fdir_configure(), since FDIR
steals Rx packet buffer space that DCB also uses.

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
v2:
* rename fdir_pballoc to fdir_buffer_size
* reject Flow Director when DCB is enabled in ixgbe_fdir_configure()
* document the DCB limitation as an RST note
* keep the original indent of ixgbe_parse_devargs

 doc/guides/nics/ixgbe.rst              | 26 ++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 55 ++++++++++++++++++++++----
 drivers/net/intel/ixgbe/ixgbe_ethdev.h |  2 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 13 +++++-
 drivers/net/intel/ixgbe/ixgbe_flow.c   |  7 +++-
 6 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index f075ef6f6f..340a54478d 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -164,6 +164,32 @@ be passed as part of EAL arguments. For example,
   This option informs the driver that in this case, SDP3 is not to be
   used as a check for link up by testing for laser on/off.
 
+PF Runtime Options
+^^^^^^^^^^^^^^^^^^
+
+The following ``devargs`` option can be enabled at probe time.
+It must be passed as part of EAL arguments. For example,
+
+.. code-block:: console
+
+   dpdk-testpmd -a 81:00.0,fdir_buffer_size=256k -- -i
+
+- ``fdir_buffer_size`` (default **64k**)
+
+  Memory allocated from the Rx packet buffer for Flow Director filters.
+  Valid values are ``64k``, ``128k`` and ``256k``.
+
+  Larger values increase the number of hardware filter entries
+  (perfect mode: 2K / 4K / 8K; signature mode: 8K / 16K / 32K)
+  and reduce Rx packet buffer space by the same amount.
+  On 82599 the Rx packet buffer is 512KB, so ``256k`` takes half of it.
+
+  This value is read only at probe time. Changing it requires restarting
+  the process with a new EAL argument.
+
+.. note::
+   The driver rejects Flow Director when DCB is enabled.
+
 VF Runtime Options
 ^^^^^^^^^^^^^^^^^^
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..2d9d32fe0b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel ixgbe driver.**
+
+  Added ``fdir_buffer_size`` devarg to select the Flow Director table size
+  (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..771223275c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -128,9 +128,11 @@
 #define IXGBE_DMATXCTL_VT_MASK                 0xFFFF0000
 
 #define IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE	"fiber_sdp3_no_tx_disable"
+#define IXGBE_DEVARG_FDIR_BUFFER_SIZE		"fdir_buffer_size"
 
 static const char * const ixgbe_valid_arguments[] = {
 	IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
+	IXGBE_DEVARG_FDIR_BUFFER_SIZE,
 	NULL
 };
 
@@ -1054,19 +1056,44 @@ ixgbe_swfw_lock_reset(struct ixgbe_hw *hw)
 	ixgbe_release_swfw_semaphore(hw, mask);
 }
 
-static void
+static int
+devarg_handle_fdir_buffer_size(const char *key, const char *value,
+			       void *extra_args)
+{
+	enum rte_eth_fdir_pballoc_type *pballoc = extra_args;
+
+	if (value == NULL || extra_args == NULL)
+		return -EINVAL;
+
+	if (strcmp(value, "64k") == 0)
+		*pballoc = RTE_ETH_FDIR_PBALLOC_64K;
+	else if (strcmp(value, "128k") == 0)
+		*pballoc = RTE_ETH_FDIR_PBALLOC_128K;
+	else if (strcmp(value, "256k") == 0)
+		*pballoc = RTE_ETH_FDIR_PBALLOC_256K;
+	else {
+		PMD_INIT_LOG(ERR, "invalid %s='%s', use 64k, 128k or 256k", key, value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
 ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 		      struct rte_devargs *devargs)
 {
 	struct rte_kvargs *kvlist;
 	uint16_t sdp3_no_tx_disable;
+	enum rte_eth_fdir_pballoc_type pballoc;
+	int ret = 0;
 
 	if (devargs == NULL)
-		return;
+		return 0;
 
 	kvlist = rte_kvargs_parse(devargs->args, ixgbe_valid_arguments);
 	if (kvlist == NULL)
-		return;
+		return 0;
 
 	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE) == 1 &&
 	    rte_kvargs_process(kvlist, IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
@@ -1074,7 +1101,17 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 	    sdp3_no_tx_disable == 1)
 		adapter->sdp3_no_tx_disable = 1;
 
+	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FDIR_BUFFER_SIZE) != 0) {
+		if (rte_kvargs_process(kvlist, IXGBE_DEVARG_FDIR_BUFFER_SIZE,
+				       devarg_handle_fdir_buffer_size,
+				       &pballoc) != 0)
+			ret = -EINVAL;
+		else
+			adapter->fdir_conf.pballoc = pballoc;
+	}
+
 	rte_kvargs_free(kvlist);
+	return ret;
 }
 
 /*
@@ -1141,8 +1178,11 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 
 	/* NOTE: review for potential ordering optimization */
 	rte_atomic_store_explicit(&ad->link_thread_running, 0, rte_memory_order_seq_cst);
-	ixgbe_parse_devargs(eth_dev->data->dev_private,
-			    pci_dev->device.devargs);
+	ret = ixgbe_parse_devargs(eth_dev->data->dev_private,
+				  pci_dev->device.devargs);
+	if (ret != 0)
+		return ret;
+
 	rte_eth_copy_pci_info(eth_dev, pci_dev);
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
@@ -2726,7 +2766,7 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 	if (fdir_conf->mode != RTE_FDIR_MODE_NONE) {
 		struct ixgbe_hw_fdir_info *info =
 			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
-		err = ixgbe_fdir_configure(adapter, fdir_conf, &info->mask);
+		err = ixgbe_fdir_configure(dev, fdir_conf, &info->mask);
 		if (err)
 			goto error;
 	}
@@ -8665,7 +8705,8 @@ RTE_PMD_REGISTER_PCI(net_ixgbe, rte_ixgbe_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe, pci_id_ixgbe_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ixgbe,
-			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>");
+			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>"
+			      IXGBE_DEVARG_FDIR_BUFFER_SIZE "=<64k|128k|256k>");
 RTE_PMD_REGISTER_PCI(net_ixgbe_vf, rte_ixgbevf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe_vf, pci_id_ixgbevf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe_vf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..fd3236fda2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -705,7 +705,7 @@ void ixgbe_filterlist_flush(struct rte_eth_dev *dev);
 /*
  * Flow director function prototypes
  */
-int ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
+int ixgbe_fdir_configure(struct rte_eth_dev *dev,
 			 const struct rte_eth_fdir_conf *fdir_conf,
 			 const struct ixgbe_hw_fdir_mask *fdir_mask);
 int ixgbe_fdir_set_input_mask(struct ixgbe_adapter *adapter,
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b32dc54287..0159c5b3b7 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -555,10 +555,11 @@ ixgbe_set_fdir_flex_conf(struct ixgbe_adapter *adapter,
 }
 
 int
-ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
+ixgbe_fdir_configure(struct rte_eth_dev *dev,
 		const struct rte_eth_fdir_conf *fdir_conf,
 		const struct ixgbe_hw_fdir_mask *fdir_mask)
 {
+	struct ixgbe_adapter *adapter = dev->data->dev_private;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(adapter);
 	int err;
 	uint32_t fdirctrl, pbsize;
@@ -567,6 +568,16 @@ ixgbe_fdir_configure(struct ixgbe_adapter *adapter,
 
 	PMD_INIT_FUNC_TRACE();
 
+	switch (dev->data->dev_conf.rxmode.mq_mode) {
+	case RTE_ETH_MQ_RX_VMDQ_DCB:
+	case RTE_ETH_MQ_RX_DCB:
+	case RTE_ETH_MQ_RX_DCB_RSS:
+		PMD_INIT_LOG(ERR, "Flow Director is not supported with DCB");
+		return -ENOTSUP;
+	default:
+		break;
+	}
+
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 		hw->mac.type != ixgbe_mac_X540 &&
 		hw->mac.type != ixgbe_mac_X550 &&
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6868893d46..d7dee610d5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2637,7 +2637,12 @@ ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
 
 	/* Configure FDIR mode if this is the first filter */
 	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
-		ret = ixgbe_fdir_configure(adapter, &local_fdir_conf, &fdir_rule->mask);
+		ret = ixgbe_fdir_configure(dev, &local_fdir_conf,
+					   &fdir_rule->mask);
+		if (ret == -ENOTSUP)
+			return rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Flow Director is not supported with DCB");
 		if (ret) {
 			return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-- 
2.55.0

