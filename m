Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B8FFCA18E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD20140664;
	Mon,  9 Mar 2026 22:18:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id DEC4240269
 for <dev@dpdk.org>; Mon,  9 Mar 2026 22:18:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773091110; x=1804627110;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gJm/ad99Q1iP6yhuzoFzp39LNx5ndEmvNtv9fgMBAPc=;
 b=j7ur5usDmpU6jSt7DXWoLIYb6r9gK8/MsTM0QvK+Ht12go1zDRcDH6JK
 xZ3zvoO4LyXTfhaVm9NuDuBJDJdzEHc9vz0kRtRWxD3WA7G8poArMfi2A
 QqsCqUmjLRobhJqJ4LbT+LewHaTh6t9bbMvxyI0scs+gspledjIpRit4m
 A7juBHIgIEeMpjkWDp7SkKOggsrcgT0HywO19j9CWRC1q4h30jKbfHwTN
 MaWa8R1E3270N5U3bAZZBIQMCLyHUnaP0MDi1kszbKsfH0NWEiAO2Posk
 K39xIeBLb0vm4NGnelfLICflMshlUsLEk4roVNlDvQdP8aoeeBrzl3Vok g==;
X-CSE-ConnectionGUID: 0dlpR7eNQtKxByX/r8N+/w==
X-CSE-MsgGUID: hxruFx3AStWPINJT7JYOBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74240942"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74240942"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 14:18:29 -0700
X-CSE-ConnectionGUID: TZsv9cZZQVCfvlqG7n+IPA==
X-CSE-MsgGUID: GuDWcOUNTuOjn2nx9b4GeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219015952"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 14:18:26 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v1 1/6] net/ice/base: update crash on invalid topology
Date: Tue, 10 Mar 2026 05:52:05 -0400
Message-ID: <20260310095218.703423-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310095218.703423-1-soumyadeep.hore@intel.com>
References: <20260310095218.703423-1-soumyadeep.hore@intel.com>
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

In some cases, after NVM update finish and triggers EMPR, FW will return
invalid information about Tx Scheduler topology
(in reply to ice_sched_query_res_alloc(), we end up with 0 as a number
children to allocate in 4th layer, then adding 5th layer nodes would
crash).

As in this scenario we need to reboot the platform anyway, it is safe to
just fail building the scheduler tree.

Add a warning, so we will be sure that this was the case.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/base/ice_sched.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_sched.c b/drivers/net/intel/ice/base/ice_sched.c
index be9393a7d6..3a0907eda7 100644
--- a/drivers/net/intel/ice/base/ice_sched.c
+++ b/drivers/net/intel/ice/base/ice_sched.c
@@ -174,6 +174,16 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
 		return ICE_ERR_PARAM;
 	}
 
+	/* After NVM update FW will(in some cases) not return proper
+	 * topology, bail out early in such cases
+	 * (as there is a need of platform reboot anyway).
+	 */
+	if (!parent->children) {
+		ice_debug(hw, ICE_DBG_SCHED, "Parent (teid = 0x%x) hasn't prepared to have children, aborting\n",
+			LE32_TO_CPU(info->parent_teid));
+		return ICE_ERR_PARAM;
+	}
+
 	/* query the current node information from FW before adding it
 	 * to the SW DB
 	 */
-- 
2.47.1

