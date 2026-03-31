Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F5D109B463
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:02:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB02840A77;
	Tue, 31 Mar 2026 15:02:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7491640A7D
 for <dev@dpdk.org>; Tue, 31 Mar 2026 15:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774962144; x=1806498144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Gqj02JQZwLRtk5HNdRd0RAzl9QMmGIBZhoR4+042/0=;
 b=KP1ulfia4O5nlaoTc1j650SNuHq6iVULWow9gQfmzbox5JDakelI7z/0
 YNhiiggklkzsp6iSi8mUCKna1l1U+aJLQpE15Efk39xeTTlGpkEr9UoCa
 8VY/T+iQxfviPJdeVCFZ/+CFjYIl0OAbIo6MfdtsMTIH8KmT0RU76aSHR
 9x4DVhhrGAmU//px9cXMI6Ds3tupnKN0uKAQG0pkKSTf/VGqoam670iwT
 FaE3eepVLUBGncg1N8k1tCk6S5HeJeaCgXZY9638gkcMrADNYsQxd7thd
 ziG7C9hRLFbgS7eRJJJch3k2uNeAG/RJlHMZTaT38McykswUM6m0pVHBi A==;
X-CSE-ConnectionGUID: k/24ACAcR9WTKZJoQKsTnA==
X-CSE-MsgGUID: QemwjrbWSnOJxT6x21WyjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75868428"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="75868428"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 06:02:23 -0700
X-CSE-ConnectionGUID: Q19KV+JlQU+nvuXPY9XH7g==
X-CSE-MsgGUID: isRDHhpbT++Ar369JMrpqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="223481791"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 31 Mar 2026 06:02:22 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 3/4] net/iavf: enable post-reset restoration of VF settings
Date: Tue, 31 Mar 2026 13:01:19 +0000
Message-ID: <20260331130120.2471971-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331130120.2471971-1-ciara.loftus@intel.com>
References: <20260331130120.2471971-1-ciara.loftus@intel.com>
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

When a VF is reset its settings are not restored. These settings include
unicast and multicast promiscuous states. Enable the ability to restore
these settings by introducing a new devarg "auto_reconfig" which accepts
values of zero to disable or one to enable. It is enabled by default.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/intel_vf.rst         |  4 +++
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 51 ++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index aec7f11b84..5fa2ddc9ea 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -104,6 +104,10 @@ IAVF PMD parameters
     transparently after a reset event, rather than relying on the application to do so. To disable
     this functionality, set the ``auto_reset`` devarg to zero: ``-a 18:01.0,auto_reset=0``
 
+``auto_reconfig``
+    Restore settings (unicast and multicast promiscuous states) on the VF after a reset event.
+    Enabled by default. To disable it: ``-a 18:01.0,auto_reconfig=0``
+
 ``no-poll-on-link-down``
     Stop polling Rx/Tx hardware queue when link is down. This is enabled by default because it is
     required when ``auto_reset`` is enabled which it is by default. To disable it, you must disable
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 403c61e2e8..02fa780e86 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -319,6 +319,7 @@ struct iavf_devargs {
 	uint16_t quanta_size;
 	uint32_t watchdog_period;
 	int auto_reset;
+	int auto_reconfig;
 	int no_poll_on_link_down;
 	uint64_t mbuf_check;
 };
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b5abfb1316..111bfa1934 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -41,6 +41,7 @@
 #define IAVF_QUANTA_SIZE_ARG       "quanta_size"
 #define IAVF_RESET_WATCHDOG_ARG    "watchdog_period"
 #define IAVF_ENABLE_AUTO_RESET_ARG "auto_reset"
+#define IAVF_ENABLE_AUTO_RECONFIG_ARG "auto_reconfig"
 #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
 uint64_t iavf_timestamp_dynflag;
@@ -52,6 +53,7 @@ static const char * const iavf_valid_args[] = {
 	IAVF_QUANTA_SIZE_ARG,
 	IAVF_RESET_WATCHDOG_ARG,
 	IAVF_ENABLE_AUTO_RESET_ARG,
+	IAVF_ENABLE_AUTO_RECONFIG_ARG,
 	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
 	IAVF_MBUF_CHECK_ARG,
 	NULL
@@ -2375,6 +2377,7 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 
 	ad->devargs.auto_reset = 1;
 	ad->devargs.no_poll_on_link_down = 1;
+	ad->devargs.auto_reconfig = 1;
 
 	if (!devargs)
 		return 0;
@@ -2437,6 +2440,11 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 		ad->devargs.no_poll_on_link_down = 1;
 	}
 
+	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_AUTO_RECONFIG_ARG,
+				 &parse_bool, &ad->devargs.auto_reconfig);
+	if (ret)
+		goto bail;
+
 bail:
 	rte_kvargs_free(kvlist);
 	return ret;
@@ -3101,6 +3109,34 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
 	return false;
 }
 
+static int
+iavf_post_reset_reconfig(struct rte_eth_dev *dev)
+{
+	int ret, status = 0;
+	bool allmulti = false, allunicast = false;
+	struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+
+	/* Restore pre-reset unicast promiscuous and multicast promiscuous states */
+	if (dev->data->promiscuous)
+		allunicast = true;
+	if (dev->data->all_multicast)
+		allmulti = true;
+	if (allmulti || allunicast) {
+		ret = iavf_config_promisc(adapter, allunicast, allmulti);
+		if (ret)
+			PMD_DRV_LOG(ERR, "Failed to restore unicast promiscuous mode (%s) "
+						"and multicast promiscuous mode (%s)",
+						allunicast ? "on" : "off", allmulti ? "on" : "off");
+		else
+			PMD_DRV_LOG(DEBUG, "Restored unicast promiscuous mode (%s) "
+						"and multicast promiscuous mode (%s)",
+						allunicast ? "on" : "off", allmulti ? "on" : "off");
+		status |= ret;
+	}
+
+	return status;
+}
+
 /*
  * Handle hardware reset
  */
@@ -3150,6 +3186,21 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 
 		dev->data->dev_started = 1;
 	}
+
+	/* Restore settings after the reset */
+	if (adapter->devargs.auto_reconfig) {
+		ret = iavf_post_reset_reconfig(dev);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "Failed to restore VF settings after reset");
+			goto error;
+		}
+	} else {
+		dev->data->promiscuous = 0;
+		dev->data->all_multicast = 0;
+		vf->promisc_unicast_enabled = false;
+		vf->promisc_multicast_enabled = false;
+	}
+
 	goto exit;
 
 error:
-- 
2.43.0

