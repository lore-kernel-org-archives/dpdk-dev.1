Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035F9C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BF6640E4F;
	Tue,  8 Sep 2026 18:00:05 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 49FB44028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:00:04 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2db858d60e0so6318665ad.0
 for <dev@dpdk.org>; Tue, 08 Sep 2026 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788883203; x=1789488003; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D9oS/tQgMK+ocIJImA+k8QR5fDExprVFwQCem6Bz/pY=;
 b=F1cCJwYvgfa0Vdl0P2bFh08qOg/4b0bxq5yvBCKWHk8gh5YizO+Urpx+ftUCpdAieJ
 Y7uO6Eg5drVBYm0BSvVfloctf8uQjNv5Uzjr+aXKbIre0z7ngn5fPH8xBE80itP1JKBH
 ZmbOK1aFM/elEKGamu38ySiMgcA3lh/FTMxn0auiAmlaupP6VFL6LrE2pasOFn24RrCq
 JtEFT+aa9e9pheL9KTQLAkNNbPDlsPOT4tWdzEOf0gd/JBPZ7BelhSYLjwNgcV+SfNlH
 CppGlGjVb8Iv17uOyD76HfFYxGRsTaGdSM9kRdEjrhNyWcNxD9PPTnWebwBXaqgCUmIR
 VM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788883203; x=1789488003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D9oS/tQgMK+ocIJImA+k8QR5fDExprVFwQCem6Bz/pY=;
 b=XKrq1sF4xK04Aoo/CHEvCokbFD5xuGGMAGp+Wbrt/Zn8GQ0JZqL11VuRFh6XUAol0h
 enbtnK+gWHAZiszKmJSkLNh+h1DrYQkihiJux8eWqpdQRbyfsdetoBHpPKTAqt96/+iL
 yhY6Ld2qrHLrM9oNo9P4VZU08hcgoRD4W6BDl1UegzrUYBxgZwVDEKuuMr+9Qbo9kU+q
 PMS4pwlbiBQMeodUYlI6+v+ny4AlazBOjgZjYN1K8+VuEW2dVGpZC3EgWnKIfgk+NopC
 mlnPZxdVbdn3679KYa1bPQ5xdU89M9dxDAytqWdsG6sN0Yn8pIhz+txVa+VFjxJNvH/J
 xZXw==
X-Gm-Message-State: AFuF++lUiP1bJ0oaKnNOMrrmgu/gZev2b4/7bG0E9F7IWzPSPxQBWtii
 DJVZ8ONLY+oquAMB3BNbpqeIf+80lX7KzeSQTXg5S39um1Q8rkbXlycv
X-Gm-Gg: AYBFou38Ol4c2n9T0biOpgukyn8coJgmaFRi2fN5u6FrfkbrHQFUVR9BCQm/tv6Ehf6
 uss7sn7XLy57w954iUPOD6GFCBoV57xmV6xB9gJou9LxdkzL2X7rAib6qFtnuWIytIdpFf6rkdR
 qpK6AaHj4Av7cGJOgFn/QsF+AyedEGpchJ8RCwlDGruuHc46HNCm7cdeeADrKyr316185lPjySO
 jkHeqf8JuukDe8b2q9IoKeIbE1Yfxnbgd+2kcnWdBdMGO3bqmmg33b9/kYFIGHRQjnEy7lm71Nq
 tYHsTDYuNYcbKLG7615wemiMhuEhHS+yrJh9uLqYAIt7dlBBVhjr5Lb2O3TGmaG7Ee/ruB06dUl
 mp6hQZQXd8RR+i5Z1+AzcHb5EhydkZAlQNuh3fLE1whtqd4eTzodnqzoSzac1CWjnrvSbgARsxn
 qxAGiBw0EdrcAgKL1EMFLSNwDmG+AUwbna9OHqSxyJvxtkIKpJagyPl7ozWye4O3cwgA==
X-Received: by 2002:a17:902:db07:b0:2db:5ea1:8b04 with SMTP id
 d9443c01a7336-2db5ea18e2amr168981465ad.5.1788883203114; 
 Tue, 08 Sep 2026 09:00:03 -0700 (PDT)
Received: from fedora (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495acf7sm61571965ad.25.2026.09.08.09.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:00:02 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org,
	Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH] net/ixgbe: add FDIR pballoc devarg
Date: Tue,  8 Sep 2026 23:58:57 +0800
Message-ID: <20260908155858.126042-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Flow Director table memory is taken from the Rx packet buffer according
to fdir_conf.pballoc. After the legacy rte_eth_conf.fdir_conf API was
removed, pballoc stayed at the zero-initialized 64K default.

Parse fdir_pballoc=<64k|128k|256k> at probe time so applications that
need a larger table can opt in. The default remains 64K.

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 doc/guides/nics/ixgbe.rst              | 26 ++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 56 ++++++++++++++++++++++----
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index f075ef6f6f..18b685f441 100644
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
+   dpdk-testpmd -a 81:00.0,fdir_pballoc=256k -- -i
+
+- ``fdir_pballoc`` (default **64k**)
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
+  Using Flow Director together with DCB is not supported:
+  Flow Director rewrites Rx packet buffer sizing after DCB configuration.
+
 VF Runtime Options
 ^^^^^^^^^^^^^^^^^^
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bde..ba3669b9da 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel ixgbe driver.**
+
+  Added ``fdir_pballoc`` devarg to select the Flow Director table size
+  (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..fef596460c 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -128,9 +128,11 @@
 #define IXGBE_DMATXCTL_VT_MASK                 0xFFFF0000
 
 #define IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE	"fiber_sdp3_no_tx_disable"
+#define IXGBE_DEVARG_FDIR_PBALLOC		"fdir_pballoc"
 
 static const char * const ixgbe_valid_arguments[] = {
 	IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE,
+	IXGBE_DEVARG_FDIR_PBALLOC,
 	NULL
 };
 
@@ -1054,19 +1056,45 @@ ixgbe_swfw_lock_reset(struct ixgbe_hw *hw)
 	ixgbe_release_swfw_semaphore(hw, mask);
 }
 
-static void
+static int
+devarg_handle_fdir_pballoc(const char *key, const char *value, void *extra_args)
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
+		PMD_INIT_LOG(ERR,
+			     "invalid %s='%s', use 64k, 128k or 256k",
+			     key, value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
 ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
-		      struct rte_devargs *devargs)
+		    struct rte_devargs *devargs)
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
@@ -1074,7 +1102,17 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 	    sdp3_no_tx_disable == 1)
 		adapter->sdp3_no_tx_disable = 1;
 
+	if (rte_kvargs_count(kvlist, IXGBE_DEVARG_FDIR_PBALLOC) != 0) {
+		if (rte_kvargs_process(kvlist, IXGBE_DEVARG_FDIR_PBALLOC,
+				       devarg_handle_fdir_pballoc,
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
@@ -1141,8 +1179,11 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 
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
 
@@ -8665,7 +8706,8 @@ RTE_PMD_REGISTER_PCI(net_ixgbe, rte_ixgbe_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe, pci_id_ixgbe_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ixgbe,
-			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>");
+			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>"
+			      IXGBE_DEVARG_FDIR_PBALLOC "=<64k|128k|256k>");
 RTE_PMD_REGISTER_PCI(net_ixgbe_vf, rte_ixgbevf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe_vf, pci_id_ixgbevf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe_vf, "* igb_uio | vfio-pci");
-- 
2.55.0

