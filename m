Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79FAC5DF74
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:59:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F0E840693;
	Tue, 18 Aug 2026 06:58:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id BE2D6406A2
 for <dev@dpdk.org>; Tue, 18 Aug 2026 06:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787029130; x=1818565130;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k5QM/n16aCUE56yBJMEQHX61RXMuPMUzEVChuG0TiFQ=;
 b=UIJAW2GN6PUR2T95jZuC+Zl0gijiMbX3tX20I2/lT/FUi3bc64JWFAE1
 JdO96hjri438Or47PP872z3qGNhR2n2wLAfwDqjd51nrSf67sjlKVJcUJ
 o5vnnWM+SWwkJrtrfQmksOFEXr3lm2YO0OsfwpiFdCunT/gjXdIPfAlky
 vuNeQRQGoJahnTfykHV0vIuvInbEeJux6UX6PxQ4z9e+nqcVr9pH42Y7A
 GefjODDb5swEseOBh6zqxmW2QR9USeE0aJx6dpx19/USd6zMDQGcuWUvE
 oy6K0roE4TWZww1DPdiN3PCQQd3pQ6U06Ov81KqMKJBUKMIae7Hqs+e6P Q==;
X-CSE-ConnectionGUID: WNwaCGt7SHiBGzWRxjj2rg==
X-CSE-MsgGUID: PqdgEae6RtypqMRdPQVy7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87633022"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87633022"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 21:58:49 -0700
X-CSE-ConnectionGUID: IgfPJ2C6QySzBUJbl47RBg==
X-CSE-MsgGUID: eKUF5WCNTi+TaiqfJTfMwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="268611296"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa003.jf.intel.com with ESMTP; 17 Aug 2026 21:58:48 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 ciara.loftus@intel.com, Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v4 6/7] net/iavf: keep watchdog armed for the whole reset
 window
Date: Tue, 18 Aug 2026 04:57:31 +0000
Message-Id: <89d66fa48898f54de70a2d6bae2098def15b89a8.1787028683.git.anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787028683.git.anurag.mandal@intel.com>
References: <cover.1787028683.git.anurag.mandal@intel.com>
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
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_vchnl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 43b5f29cad..e3120c655d 100644
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
@@ -332,6 +332,7 @@ iavf_read_msg_from_pf(struct iavf_adapter *adapter, uint16_t buf_len,
 			if (!vf->vf_reset) {
 				vf->vf_reset = true;
 				iavf_set_no_poll(adapter, false);
+				iavf_dev_watchdog_enable(adapter);
 				if (adapter->devargs.no_poll_on_link_down)
 					iavf_dev_tx_drain(vf->eth_dev);
 				iavf_dev_event_post(vf->eth_dev,
@@ -572,6 +573,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev, uint8_t *msg,
 		if (!vf->vf_reset) {
 			vf->vf_reset = true;
 			iavf_set_no_poll(adapter, false);
+			iavf_dev_watchdog_enable(adapter);
 			if (adapter->devargs.no_poll_on_link_down)
 				iavf_dev_tx_drain(dev);
 			iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_RESET,
-- 
2.34.1

