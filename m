Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF29CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 06:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27FD140611;
	Fri, 19 Sep 2025 08:52:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 78B05402B7;
 Fri, 19 Sep 2025 08:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758264726; x=1789800726;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3DMlylO5I6JHT/goL0NWQyW5xvr993apyWGF7vDo0D4=;
 b=B2Nhrzprczz7zTUTwEWJbaX9nbhJ0hw6sVplgZ+Zy6T2Qf6wuuy3PMxw
 n5VPYDIkp+BJEUgwSl7cvvZepniGvX6+Amyyf1dhkof/w96PwkR/dZkYS
 AhSpK4rvE0sf1uMGPMEB7xHi9hhSTct1II3F8bCR+zQibEc4k8SKXBdlT
 LrFm+RTuQfktJuGF+Jdsa4RiKdTGQbTHmU8/GoO/Ix0eHISlLQA0jvCTA
 /O2gRf/OBOY94SjuWJqkyQib0ox6s1XY1xeUD1G219wRbo4M9FAfvviW/
 x3vdPqXsMDb4t+vYFL9+nG/4XV7ZnIw/ZaA5u88ivW8XzGJCR0lsnXrwT Q==;
X-CSE-ConnectionGUID: TWdWuyXsQAeYV+lqq/IloA==
X-CSE-MsgGUID: hUhnG7HnSriHJ1YPjV2USg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60554135"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60554135"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 23:52:05 -0700
X-CSE-ConnectionGUID: uZj9Omj0TfCXsjmgQX/5wg==
X-CSE-MsgGUID: C22sShiLTiKBh7bk2s1scw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; d="scan'208";a="181031435"
Received: from unknown (HELO zhichao-dpdk..) ([10.239.252.103])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 23:52:03 -0700
From: Zhichao Zeng <zhichaox.zeng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Zhichao Zeng <zhichaox.zeng@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Shahaf Shuler <shahafs@nvidia.com>
Subject: [PATCH] examples/ip_reassembly: remove conflicting Tx offload
Date: Fri, 19 Sep 2025 15:12:13 +0800
Message-Id: <20250919071213.818567-1-zhichaox.zeng@intel.com>
X-Mailer: git-send-email 2.34.1
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

IP packet reassembly requires the MULTI_SEGS offload to be enabled in order
to handle fragmented packets across multiple memory segments. However, the
MBUF_FAST_FREE offload conflicts with MULTI_SEGS and cannot be enabled
simultaneously.

Remove the MBUF_FAST_FREE offload to avoid conflicts with MULTI_SEGS.

Fixes: 9df56e69ee3f ("examples/ip_reassembly: convert to new ethdev offloads API")
Cc: stable@dpdk.org

Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
---
 examples/ip_reassembly/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 17ae76d4ba..294fd38889 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -1093,9 +1093,6 @@ main(int argc, char **argv)
 		n_tx_queue = nb_lcores;
 		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
 			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
-		if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
-			local_port_conf.txmode.offloads |=
-				RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 
 		local_port_conf.rx_adv_conf.rss_conf.rss_hf &=
 			dev_info.flow_type_rss_offloads;
-- 
2.34.1

