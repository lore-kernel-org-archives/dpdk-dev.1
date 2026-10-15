Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F1CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37F5240A73;
	Thu, 15 Oct 2026 11:17:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9F16D40A67;
 Thu, 15 Oct 2026 11:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792055859; x=1823591859;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zb+N+4I+e2aVrKSq2xyAJhzkPBeHPyPXYmr1MsyoYOg=;
 b=SYF0X8bhYqU533zavzC8UjLsCfKjgRdxijjNjhzvWy3jj1qtDZ550ihO
 xYyd7egyc3nm0HC3gjzJl3loaZNjxMA2qd4vWiWMskYtFsR1yxAhVUa49
 FGMt/e+LTHhJuGvvxOtk77W+vixtKW3HovPBetPyhx+vVl7NRuSWTJytV
 J3zVlUQ6QUc3bvvlFH24g3479L1n+vC0OR3A1vcui4FqpE4QFdx6e7LUg
 kjEd34RewHS0xLT/u22dvAifN9xuKwfBzvXx0s1BwuOnjr3glQALAANwr
 nUcEyWhnhIOXwyG58ZkOnxBevn1emS4kzw9yCu85TtmCmA2/c9CmE+qGR g==;
X-CSE-ConnectionGUID: loL9D3MrQPms2i7EbUBpuA==
X-CSE-MsgGUID: zZ3x8WY1Qmi48Q/Vy9ML5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="808487"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="808487"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:17:38 -0700
X-CSE-ConnectionGUID: 7u6ITGVQRgunEl/u0VZO3g==
X-CSE-MsgGUID: /GJ+4L2VQWGVQy9ORmsYmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2000396"
Received: from pae-31.iind.intel.com ([10.49.105.72])
 by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2026 02:17:37 -0700
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: grive@u256.net, stephen@networkplumber.org, stable@dpdk.org,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>
Subject: [PATCH v3 6/6] net/failsafe: detect sub-device removal via device
 event
Date: Thu, 15 Oct 2026 16:19:27 +0000
Message-Id: <20261015161927.194886-7-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015161927.194886-1-sandeep.penigalapati@intel.com>
References: <20261014221604.128677-1-sandeep.penigalapati@intel.com>
 <20261015161927.194886-1-sandeep.penigalapati@intel.com>
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

Fail-safe relied on the removal (RMV) interrupt to learn that a
sub-device disappeared. A sub-device that does not support the RMV
interrupt (for example a VFIO device whose removal is only reported by
the bus as a device event on the release request) was never detected,
so traffic was not failed over to the other sub-device.

Register a bus device-event callback for such sub-devices and run the
existing removal handling from it. For VFIO devices the bus delivers
the event automatically; UIO-bound devices additionally require
rte_dev_event_monitor_start() and rte_dev_hotplug_handle_enable() to be
enabled by the application.

The callback is registered and unregistered by the primary process
only: struct sub_device lives in shared memory, so in a secondary
process the registration flag would read as already set and sdev->dev
would point into the primary address space. A secondary learns of the
removal through the shared sub-device state checked on every burst.

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
v2:
- Clarified secondary-process detection in a comment.
v3:
- Split the Rx/Tx burst fix into its own patch (5/6).
- Simplified failsafe_dev_event_callback() and documented the VFIO/UIO
  device-event monitoring requirements.

 drivers/net/failsafe/failsafe_ether.c   | 26 +++++++++++++++++++++++++
 drivers/net/failsafe/failsafe_ops.c     | 19 ++++++++++++++++++
 drivers/net/failsafe/failsafe_private.h |  5 +++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/net/failsafe/failsafe_ether.c b/drivers/net/failsafe/failsafe_ether.c
index 2c183ea29a..307f2abfa5 100644
--- a/drivers/net/failsafe/failsafe_ether.c
+++ b/drivers/net/failsafe/failsafe_ether.c
@@ -385,6 +385,22 @@ failsafe_eth_dev_unregister_callbacks(struct sub_device *sdev)
 			     " %d", SUB_ID(sdev));
 		sdev->lsc_callback = 0;
 	}
+	/*
+	 * The bus device-event callback is registered by the primary only
+	 * (hotplug is handled there). sub_device is shared memory, so in a
+	 * secondary the flag reads as set and sdev->dev holds the primary's
+	 * pointer; dereferencing it (rte_dev_name) would crash. Skip it.
+	 */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+	    sdev->dev_event_callback) {
+		ret = rte_dev_event_callback_unregister(rte_dev_name(sdev->dev),
+						failsafe_dev_event_callback,
+						sdev);
+		if (ret < 0)
+			WARN("Failed to unregister device event callback for"
+			     " sub_device %d", SUB_ID(sdev));
+		sdev->dev_event_callback = 0;
+	}
 }
 
 void
@@ -600,6 +616,16 @@ failsafe_eth_rmv_event_callback(uint16_t port_id __rte_unused,
 	return 0;
 }
 
+void
+failsafe_dev_event_callback(const char *device_name __rte_unused,
+			    enum rte_dev_event_type type,
+			    void *cb_arg)
+{
+	if (type == RTE_DEV_EVENT_REMOVE)
+		failsafe_eth_rmv_event_callback(0, RTE_ETH_EVENT_INTR_RMV,
+						cb_arg, NULL);
+}
+
 int
 failsafe_eth_lsc_event_callback(uint16_t port_id __rte_unused,
 				enum rte_eth_event_type event __rte_unused,
diff --git a/drivers/net/failsafe/failsafe_ops.c b/drivers/net/failsafe/failsafe_ops.c
index 56c7c884a1..5680451f21 100644
--- a/drivers/net/failsafe/failsafe_ops.c
+++ b/drivers/net/failsafe/failsafe_ops.c
@@ -82,6 +82,25 @@ fs_dev_configure(struct rte_eth_dev *dev)
 			else
 				sdev->rmv_callback = 1;
 		}
+		/*
+		 * Without RMV interrupts, a hot-unplug is only reported by the
+		 * bus (e.g. a VFIO device release request) as a device event.
+		 * Only the primary registers for it; a secondary learns of the
+		 * removal through the shared sub_device state checked by
+		 * fs_rx_unsafe()/fs_tx_unsafe() on every burst.
+		 */
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
+		    !rmv_interrupt && sdev->dev != NULL &&
+		    sdev->dev_event_callback == 0) {
+			ret = rte_dev_event_callback_register(rte_dev_name(sdev->dev),
+					failsafe_dev_event_callback,
+					sdev);
+			if (ret)
+				WARN("Failed to register device event callback for sub_device %d",
+				     SUB_ID(sdev));
+			else
+				sdev->dev_event_callback = 1;
+		}
 		dev->data->dev_conf.intr_conf.rmv = 0;
 		if (lsc_interrupt && sdev->lsc_callback == 0) {
 			ret = rte_eth_dev_callback_register(PORT_ID(sdev),
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index 0f14080394..a565ee2fbc 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -138,6 +138,8 @@ struct sub_device {
 	unsigned int rmv_callback:1;
 	/* LSC callback registration state */
 	unsigned int lsc_callback:1;
+	/* Bus device event (removal) callback registration state */
+	unsigned int dev_event_callback:1;
 };
 
 /*
@@ -239,6 +241,9 @@ int failsafe_eth_rmv_event_callback(uint16_t port_id,
 int failsafe_eth_lsc_event_callback(uint16_t port_id,
 				    enum rte_eth_event_type event,
 				    void *cb_arg, void *out);
+void failsafe_dev_event_callback(const char *device_name,
+				 enum rte_dev_event_type type,
+				 void *cb_arg);
 int failsafe_eth_new_event_callback(uint16_t port_id,
 				    enum rte_eth_event_type event,
 				    void *cb_arg, void *out);
-- 
2.34.1

