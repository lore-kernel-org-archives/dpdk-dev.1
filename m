Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344D4C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:50:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 430C34028E;
	Mon, 17 Aug 2026 08:50:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 56B384068A
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786949403; x=1818485403;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EH2v4o8fDPKSL4YVc2U1iSQngK1PnUlD/L5o2P//e6w=;
 b=Nm6LuT7qwae9oqAFF7VRvdoWudUFdQ9I9qoeO+sF1Qal9cfdickYjvDY
 6Z4iyx/BDlxc8kmMe+SapfuV38hK00lVJyDPqEwnYR+PI6HLhwIHncntg
 7TS87Y6K6ttrvPW00A4YNWgtgY/l9AD1z3I1FdES7NvBK61fAGll/EqWp
 8Uup0TAXr4HMSKTQWOhMGkI11S0v0jEM4mhjzXuIJqaC2RpQmmWiJ8MpB
 WJ5KDsbh2BWbmikhsDF4FsorOGRN5+sMdzSZuG9hMlhSb8JeBC52tjm4/
 0Ea1s1ci59lP86PIh9LLMUu2SJw1mI5yFGwj8dSiHiOXjpvecjFk4sfK2 w==;
X-CSE-ConnectionGUID: DsfsAw+LRCSVSNSrUcZNHA==
X-CSE-MsgGUID: lvDvnXcnTKOVpZXem07eJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91095605"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="91095605"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:50:02 -0700
X-CSE-ConnectionGUID: n5SrKkGsSYqdJgKktx6GFQ==
X-CSE-MsgGUID: BtohcvERRHWWcujw5O3kfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="262195995"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa008.fm.intel.com with ESMTP; 16 Aug 2026 23:50:00 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v3 6/7] net/iavf: keep watchdog armed for the whole reset
 window
Date: Mon, 17 Aug 2026 06:48:45 +0000
Message-Id: <2158af5afa7b7e8f63224b466151608e040140b2.1786948817.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786948817.git.anurag.mandal@intel.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
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

The device watchdog polls VFGEN_RSTAT to detect a VF reset and drives
the auto-reset recovery path.
It is disabled when a link-up event arrives, on the assumption that a
working link means no reset is in flight.
That assumption does not hold during recovery.

Keep the watchdog armed while vf->in_reset_recovery is set, and enable
it on VIRTCHNL_EVENT_RESET_IMPENDING, so it stays armed from the PF
reset notification until recovery completes.

Fixes: ece7d7eef04f ("net/iavf: fix duplicate VF reset during PF reset recovery")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index e04afe1d6a..3fa0496b89 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -260,7 +260,7 @@ iavf_handle_link_change_event(struct rte_eth_dev *dev,
 	 * (link is down or a VF reset is in progress); the watchdog drives
 	 * auto-reset recovery, so it must remain armed in those cases.
 	 */
-	if (vf->link_up && !vf->vf_reset)
+	if (vf->link_up && !vf->vf_reset && !vf->in_reset_recovery)
 		iavf_dev_watchdog_disable(adapter);
 	else
 		iavf_dev_watchdog_enable(adapter);
@@ -334,6 +334,7 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 			if (!vf->vf_reset) {
 				vf->vf_reset = true;
 				iavf_set_no_poll(adapter, false);
+				iavf_dev_watchdog_enable(adapter);
 				if (adapter->devargs.no_poll_on_link_down)
 					iavf_dev_tx_drain(vf->eth_dev);
 				iavf_dev_event_post(vf->eth_dev,
@@ -574,6 +575,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		if (!vf->vf_reset) {
 			vf->vf_reset = true;
 			iavf_set_no_poll(adapter, false);
+			iavf_dev_watchdog_enable(adapter);
 			if (adapter->devargs.no_poll_on_link_down)
 				iavf_dev_tx_drain(dev);
 			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
-- 
2.34.1

