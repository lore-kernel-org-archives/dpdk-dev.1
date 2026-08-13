Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04082C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AD7942D9F;
	Thu, 13 Aug 2026 12:46:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9E80642DA6
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786618012; x=1818154012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZfC5nzFowoqjvIzD/P9ARO0g/zfvF35vs97B+nZmUkA=;
 b=kBBRhSXXyYq/mhwQ4NQ2saKbjJm23CDWxJWEUlbbcaF+sgDshef02GZl
 4f2oG03g7cXiHAOVq/SVNslRWd4LHi+J7vwtemXDSGAQ3OFz+p8N9X+57
 EqMepO9HRFZm1xDAxyybQ83uRya7ohDlCHYU3J1M1faym3bnx4AC5Ngdk
 xL8W6DQmD2jvJLo/DtjI8guRq3gXKGGI6yt30/QG2kczBi1XF1EtH31gg
 bRlXqTty2NMALyuSZU1irLVYkoY1EvVmJpIhDjbL5zvg2mUu3+zYHWwY/
 0Uspu7rqwnvkj8viviSy6uud4d7EH6FODM6OXp4R2kxR6bvl91DkrdP+Q A==;
X-CSE-ConnectionGUID: D0ALxUvhSXW6kBE7DhPqsg==
X-CSE-MsgGUID: zkdoK9faSxePc6fPPt1pXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="89709004"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="89709004"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 03:46:50 -0700
X-CSE-ConnectionGUID: XUwnaKXKRrKKEAfcxMjwRQ==
X-CSE-MsgGUID: SMUK6bi+TA227rnvtzKc6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="264491578"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 13 Aug 2026 03:46:49 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2 6/7] net/iavf: keep watchdog armed for the whole reset
 window
Date: Thu, 13 Aug 2026 10:45:34 +0000
Message-Id: <47bddd4ac155b60709dc4ebe78d255215f02637a.1786617159.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1786617159.git.anurag.mandal@intel.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
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

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index e04afe1d6a..3ceebce454 100644
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
@@ -574,6 +574,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		if (!vf->vf_reset) {
 			vf->vf_reset = true;
 			iavf_set_no_poll(adapter, false);
+			iavf_dev_watchdog_enable(adapter);
 			if (adapter->devargs.no_poll_on_link_down)
 				iavf_dev_tx_drain(dev);
 			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
-- 
2.34.1

