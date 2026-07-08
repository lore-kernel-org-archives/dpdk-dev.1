Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC65C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 18:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43D8640268;
	Wed,  8 Jul 2026 20:59:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 488C640265;
 Wed,  8 Jul 2026 20:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783537142; x=1815073142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9ACsL3qIuiKSXhktBWa1hUx9+akbS0HQVF3xLRudb8o=;
 b=ktaelXCyuGeRTT2oyjAKhP21C9hkmJsIziY6mm/kk4NGLTOy0v85kP/+
 DMz78XiWmHEdcgQuZ0JTq0j3aV9J1BwO5Uz/teUdidekJskCQhY7en5CU
 m7TKG0iqUbu3ei8ofyI3W9nVgBaD/dpvb1DjL09RIW5CRdLilTcU1zxQ6
 kDWIKGIjSAed+vKj9kUolCjaWTfrPN76HV7kla/2dTMJKX7ogHooCQK8b
 kK/E7uq7T91GKWWyQCpo2kLjFF44ltAKUkM2nk9HJV87lIwhgV6ss3qHG
 fk92Q39n2KedMMlkNqkGVBVN2W5mfDwm/8PYD7VRxNKWm0t/+JfxlZDil g==;
X-CSE-ConnectionGUID: UQV01/GWSt+bwF+3+Cp0Bw==
X-CSE-MsgGUID: Nwq0BLx6RW+zr1XXVqU8Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88126759"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="88126759"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 11:59:01 -0700
X-CSE-ConnectionGUID: xrYQf03KSh+TqcDUMzFeeQ==
X-CSE-MsgGUID: myZX4Ud5RjmaAZ6YI6LuDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="250371424"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa010.fm.intel.com with ESMTP; 08 Jul 2026 11:58:58 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org,
 Ye Chen <yex.chen@intel.com>
Subject: [PATCH v3] net/iavf: fix single VLAN strip in double VLAN mode
Date: Wed,  8 Jul 2026 18:58:47 +0000
Message-Id: <20260708185847.550732-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708093955.495637-1-anurag.mandal@intel.com>
References: <20260708093955.495637-1-anurag.mandal@intel.com>
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

In Double VLAN Mode (DVM) i.e. when RTE_ETH_RX_OFFLOAD_VLAN_EXTEND
is enabled iavf_config_vlan_strip_v2() only toggles the inner
VLAN strip setting (0x8100) for the RTE_ETH_RX_OFFLOAD_VLAN_STRIP
offload, while the outer VLAN strip is controlled independently
through the QinQ strip path.

However, in DVM, most hardwares place a single (non-QinQ) VLAN
tag in the outer position
As a result, when a single VLAN packet is received and the
application disables single VLAN tag stripping, only the inner
VLAN tag strip gets turned off and the outer VLAN tag strip
stays enabled.
Hence, the single VLAN tag still gets stripped.
This does not honor the application's request.

This patch fixes the aforesaid case.
When DVM and QinQ stripping are both enabled, also apply the strip
enable/disable to the outer VLAN so that single VLAN packets received
in double VLAN mode respect the single VLAN strip configuration.

Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Tested-by: Ye Chen <yex.chen@intel.com>
---
V3: Restricted to VLAN TPID 0x8100
V2: Spelling correction in commit message

 .mailmap                            | 1 +
 drivers/net/intel/iavf/iavf_vchnl.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/.mailmap b/.mailmap
index 05a55c0bd6..7ac425f800 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1893,6 +1893,7 @@ Yaron Illouz <yaroni@radcom.com>
 Yaroslav Brustinov <ybrustin@cisco.com>
 Yash Sharma <ysharma@marvell.com>
 Yasufumi Ogawa <ogawa.yasufumi@lab.ntt.co.jp> <yasufum.o@gmail.com>
+Ye Chen <yex.chen@intel.com>
 Yehor Malikov <yehor.malikov@solidigm.com>
 Yelena Krivosheev <yelena@marvell.com>
 Yerden Zhumabekov <e_zhumabekov@sts.kz> <yerden.zhumabekov@sts.kz>
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index cd6e8325fc..f8fffa7802 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -922,8 +922,13 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapter, bool enable)
 	uint32_t *ethertype;
 	int qinq = adapter->dev_data->dev_conf.rxmode.offloads &
 		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
+	bool strip_qinq = adapter->dev_data->dev_conf.rxmode.offloads &
+			  RTE_ETH_RX_OFFLOAD_QINQ_STRIP;
 	int ret;
 
+	if (qinq && strip_qinq && adapter->tpid == RTE_ETHER_TYPE_VLAN)
+		iavf_config_outer_vlan_strip_v2(adapter, enable);
+
 	stripping_caps = &vf->vlan_v2_caps.offloads.stripping_support;
 
 	/* When VLAN extend is disabled, Single VLAN mode which is Outer VLAN
-- 
2.34.1

