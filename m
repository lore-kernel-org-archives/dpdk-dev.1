Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16750606D82B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NPTWyoyZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F16040DCB;
	Wed,  4 Nov 2026 10:55:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 211C74026E;
 Wed,  4 Nov 2026 10:55:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793786130; x=1825322130;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c8LCHEgvlrUKBDrd6M7u1iKPoNEtdJWeu68W3sGkL2A=;
 b=NPTWyoyZOIMEslquKURdpmPY0b1HvCsU+C6dz1at6d8dAkCKi8izfa4n
 lobMVk71vrX6Osld11bjRqgyanUIWnj4e9TXKjEtzyKePP47DIbYui8U8
 SacKyM3mjXWOnAw26egg1wUWnRXaYxVsyZusHOVzDeFcgvoDB+7t+M9gR
 ahLb9y1MVVFANX5aFRirdf0Rsn3bfCnaqigLvevkp0W4LT4jQKhluWxHy
 mUvLgHiGIzTXnIAtoxCeAcRIdDwMJd3nN2ryHLzRO1Ms+xAaWRqw6qLyn
 v1Y60w22SUNXZuT++Snn9DrhsZfYbgMOKQunVfihnO5G1HE8oXe/ZSXOR w==;
X-CSE-ConnectionGUID: udbj7mpkQT+U3naWLdB/tQ==
X-CSE-MsgGUID: yeV96hVFRfaekjj9ovqINA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2432705"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2432705"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 01:55:29 -0800
X-CSE-ConnectionGUID: XKSq0/RQT0Kikr0uRlXgcw==
X-CSE-MsgGUID: ticonjOZSayokgRD663VQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6699088"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa001.jf.intel.com with ESMTP; 04 Nov 2026 01:55:28 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v2 3/3] net/iavf: fix watchdog clearing reset state during
 recovery
Date: Wed,  4 Nov 2026 09:55:09 +0000
Message-ID: <20261104095510.10246-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104095510.10246-1-ciara.loftus@intel.com>
References: <20261104095510.10246-1-ciara.loftus@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the watchdog is kept armed across a PF reset, it can clear
vf_reset while the reset event is still queued or being handled, as
VFGEN_RSTAT toggles while the PF resets the VF. iavf_dev_close() then
skips re-enabling PCI bus mastering, which the VF reset cleared, so
VIRTCHNL_OP_VERSION never reaches the PF, iavf_dev_init() fails and the
port is left returning -EIO. Each toggle also posts a further reset
event, causing redundant recovery cycles.

Count reset events from before vf_reset is set until they have been
handled, and do not let the watchdog clear vf_reset while any are
outstanding.

Fixes: a0e296420a70 ("net/iavf: keep watchdog armed for the whole reset window")
Cc: stable@dpdk.org

Suggested-by: Declan Doherty <declan.doherty@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  4 ++-
 drivers/net/intel/iavf/iavf_ethdev.c | 16 +++++++---
 drivers/net/intel/iavf/iavf_vchnl.c  | 48 ++++++++++++++++++++--------
 3 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 8b826662c6..9cbbb5263a 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -290,6 +290,7 @@ struct iavf_info {
 	struct iavf_tm_conf tm_conf;
 
 	RTE_ATOMIC(bool)in_reset_recovery;
+	RTE_ATOMIC(uint32_t)reset_events_pending;
 	bool reset_pending;
 	bool pf_reset_in_progress;
 	bool start_pending;
@@ -454,9 +455,10 @@ struct iavf_cmd_info {
 
 int iavf_check_api_version(struct iavf_adapter *adapter);
 int iavf_get_vf_resource(struct iavf_adapter *adapter);
-void iavf_dev_event_post(struct rte_eth_dev *dev,
+int iavf_dev_event_post(struct rte_eth_dev *dev,
 		enum rte_eth_event_type event,
 		void *param, size_t param_alloc_size);
+void iavf_dev_reset_event_post(struct rte_eth_dev *dev);
 void iavf_dev_event_handler_fini(void);
 int iavf_dev_event_handler_init(void);
 void iavf_handle_virtchnl_msg(struct rte_eth_dev *dev);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 38bf2e502a..e57a018906 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -336,11 +336,14 @@ iavf_dev_watchdog(void *cb_arg)
 
 	/* If in reset then poll vfr_inprogress register for completion */
 	if (adapter->vf.vf_reset) {
+		/* pair with the release fence before vf_reset is set */
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 		vfr_inprogress = iavf_vfr_inprogress(hw);
 
-		if (!vfr_inprogress) {
-			PMD_DRV_LOG(INFO, "VF \"%s\" reset has completed",
-				dev->data->name);
+		if (!vfr_inprogress &&
+		    rte_atomic_load_explicit(&adapter->vf.reset_events_pending,
+				rte_memory_order_acquire) == 0) {
+			PMD_DRV_LOG(INFO, "VF \"%s\" reset has completed", dev->data->name);
 			adapter->vf.vf_reset = false;
 			iavf_set_no_poll(adapter, false);
 		}
@@ -354,12 +357,15 @@ iavf_dev_watchdog(void *cb_arg)
 				dev->data->name);
 
 			/* enter reset state with VFLR event */
+			rte_atomic_fetch_add_explicit(&adapter->vf.reset_events_pending, 1,
+					rte_memory_order_relaxed);
+			/* publish the count before vf_reset is visible */
+			rte_atomic_thread_fence(rte_memory_order_release);
 			adapter->vf.vf_reset = true;
 			iavf_set_no_poll(adapter, false);
 			adapter->vf.link_up = false;
 
-			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
-				NULL, 0);
+			iavf_dev_reset_event_post(dev);
 		}
 	}
 
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 34961fe654..cbbab242af 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -81,14 +81,17 @@ iavf_dev_event_handle(void *param __rte_unused)
 			TAILQ_REMOVE(&pending, pos, next);
 
 			struct iavf_adapter *adapter = pos->dev->data->dev_private;
-			if (pos->event == RTE_ETH_EVENT_INTR_RESET &&
-			    adapter->devargs.auto_reset) {
-				iavf_handle_hw_reset(pos->dev, false);
-				rte_free(pos);
-				continue;
+			if (pos->event == RTE_ETH_EVENT_INTR_RESET) {
+				if (adapter->devargs.auto_reset)
+					iavf_handle_hw_reset(pos->dev, false);
+				else
+					rte_eth_dev_callback_process(pos->dev, pos->event,
+									pos->param);
+				rte_atomic_fetch_sub_explicit(&adapter->vf.reset_events_pending, 1,
+						rte_memory_order_release);
+			} else {
+				rte_eth_dev_callback_process(pos->dev, pos->event, pos->param);
 			}
-
-			rte_eth_dev_callback_process(pos->dev, pos->event, pos->param);
 			rte_free(pos);
 		}
 	}
@@ -96,7 +99,7 @@ iavf_dev_event_handle(void *param __rte_unused)
 	return 0;
 }
 
-void
+int
 iavf_dev_event_post(struct rte_eth_dev *dev,
 		enum rte_eth_event_type event,
 		void *param, size_t param_alloc_size)
@@ -105,7 +108,7 @@ iavf_dev_event_post(struct rte_eth_dev *dev,
 	char notify_byte = 0;
 	struct iavf_event_element *elem = rte_malloc(NULL, sizeof(*elem) + param_alloc_size, 0);
 	if (!elem)
-		return;
+		return -ENOMEM;
 
 	elem->dev = dev;
 	elem->event = event;
@@ -122,6 +125,18 @@ iavf_dev_event_post(struct rte_eth_dev *dev,
 
 	ssize_t nw = write(handler->fd[1], &notify_byte, 1);
 	RTE_SET_USED(nw);
+
+	return 0;
+}
+
+void
+iavf_dev_reset_event_post(struct rte_eth_dev *dev)
+{
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+
+	if (iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET, NULL, 0) != 0)
+		rte_atomic_fetch_sub_explicit(&vf->reset_events_pending, 1,
+				rte_memory_order_release);
 }
 
 int
@@ -332,14 +347,16 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 			 */
 			vf->link_up = false;
 			if (!vf->vf_reset) {
+				rte_atomic_fetch_add_explicit(&vf->reset_events_pending, 1,
+						rte_memory_order_relaxed);
+				/* publish the count before vf_reset is visible */
+				rte_atomic_thread_fence(rte_memory_order_release);
 				vf->vf_reset = true;
 				iavf_set_no_poll(adapter, false);
 				iavf_dev_watchdog_enable(adapter);
 				if (adapter->devargs.no_poll_on_link_down)
 					iavf_dev_tx_drain(dev);
-				iavf_dev_event_post(dev,
-					RTE_ETH_EVENT_INTR_RESET,
-					NULL, 0);
+				iavf_dev_reset_event_post(dev);
 			}
 			PMD_DRV_LOG(DEBUG, "VF is resetting");
 			break;
@@ -573,13 +590,16 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		PMD_DRV_LOG(DEBUG, "VIRTCHNL_EVENT_RESET_IMPENDING event");
 		vf->link_up = false;
 		if (!vf->vf_reset) {
+			rte_atomic_fetch_add_explicit(&vf->reset_events_pending, 1,
+					rte_memory_order_relaxed);
+			/* publish the count before vf_reset is visible */
+			rte_atomic_thread_fence(rte_memory_order_release);
 			vf->vf_reset = true;
 			iavf_set_no_poll(adapter, false);
 			iavf_dev_watchdog_enable(adapter);
 			if (adapter->devargs.no_poll_on_link_down)
 				iavf_dev_tx_drain(dev);
-			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
-				NULL, 0);
+			iavf_dev_reset_event_post(dev);
 		}
 		break;
 	case VIRTCHNL_EVENT_LINK_CHANGE:
-- 
2.43.0

