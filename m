Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E9BC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:53:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9873C4068E;
	Fri,  3 Jul 2026 13:53:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8A44068A
 for <dev@dpdk.org>; Fri,  3 Jul 2026 13:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783079608; x=1814615608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8/7OSjf1kiJX/zOLFOYthahSbuBNs7HlkbQ1a/WcOr4=;
 b=BNtjr+G8to4Y+mNWHj8+35i/c16vHeKUJyCKAh14BriH34piVSgZXW9B
 /PdCIyggsiAgGMlIPjqGaloNDzgV36U+feHn/J8RU5iJI3ZbcdzFDo6t0
 f/6QzbQF+zZHq02w/wC3S0kxGwAGQ0q6ASckMZ0424fbznySV81ysqErT
 KA/MEHXEqv4t7U2wVBk9dn2UZ4aTN6IlDp32cLciNeou4cH7mjnO2dCpB
 RWmoLwqjTdOyLMvQC7uTzHgIsFJ0/bkR765iFvcbN68aQQG7XUjIkDPUG
 xqQ9D6nfGsWM4lB7BHNOmdTzhz+IjDqAaIRH7mDhHtNASB5Ocuw9VsW6T g==;
X-CSE-ConnectionGUID: 5yFvRJ/JTCC1VMbKejnakg==
X-CSE-MsgGUID: hV5S6TauSaqUuKmGhC/jeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101253805"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="101253805"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 04:53:27 -0700
X-CSE-ConnectionGUID: uqVVh/iNTvy6ZqFkD5Aj8Q==
X-CSE-MsgGUID: 2Y0fCGPUSDm+TOudOSnlEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="291240247"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa001.jf.intel.com with ESMTP; 03 Jul 2026 04:53:24 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v4 2/5] net/iavf: allow runtime queue rate limit configuration
Date: Fri,  3 Jul 2026 08:19:49 -0400
Message-ID: <20260703121952.1277387-3-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703121952.1277387-1-dawid.wesierski@intel.com>
References: <20260630120657.1046588-1-dawid.wesierski@intel.com>
 <20260703121952.1277387-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Allow per-queue bandwidth rate limiting to be configured without
stopping the port when only a single TC node and single QoS element
are involved. This enables dynamic session management where individual
queue pacing rates can be changed while other queues continue
transmitting.

Also fix the queue ID assignment in the bandwidth configuration to
use the actual TM node ID rather than a sequential counter index, and
only mark the TM hierarchy as committed when the port is stopped to
permit subsequent reconfiguration.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/iavf/iavf_tm.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 1cf7bfb106..e3492ec491 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -804,19 +804,25 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	int index = 0, node_committed = 0;
 	int i, ret_val = IAVF_SUCCESS;
 
-	/* check if port is stopped */
-	if (adapter->stopped != 1) {
-		PMD_DRV_LOG(ERR, "Please stop port first");
-		ret_val = IAVF_ERR_NOT_READY;
-		goto err;
-	}
-
 	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_QOS)) {
 		PMD_DRV_LOG(ERR, "VF queue tc mapping is not supported");
 		ret_val = IAVF_NOT_SUPPORTED;
 		goto fail_clear;
 	}
 
+	/*
+	 * Allow reconfiguration on a running port only when a single queue is
+	 * involved (single TC node and single QoS element); otherwise the port
+	 * must be stopped first. qos_cap is valid here because the
+	 * VIRTCHNL_VF_OFFLOAD_QOS capability was checked above.
+	 */
+	if ((vf->tm_conf.nb_tc_node != 1 || vf->qos_cap->num_elem != 1) &&
+	    adapter->stopped != 1) {
+		PMD_DRV_LOG(ERR, "Please stop port first");
+		ret_val = IAVF_ERR_NOT_READY;
+		goto err;
+	}
+
 	/* check if all TC nodes are set with VF vsi */
 	if (vf->tm_conf.nb_tc_node != vf->qos_cap->num_elem) {
 		PMD_DRV_LOG(ERR, "Does not set VF vsi nodes to all TCs");
@@ -856,7 +862,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		q_tc_mapping->tc[tm_node->tc].req.queue_count++;
 
 		if (tm_node->shaper_profile) {
-			q_bw->cfg[node_committed].queue_id = node_committed;
+			q_bw->cfg[node_committed].queue_id = tm_node->id;
 			q_bw->cfg[node_committed].shaper.peak =
 			tm_node->shaper_profile->profile.peak.rate /
 			1000 * IAVF_BITS_PER_BYTE;
@@ -900,7 +906,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	vf->qtc_map = qtc_map;
-	vf->tm_conf.committed = true;
+	if (adapter->stopped == 1)
+		vf->tm_conf.committed = true;
 	return ret_val;
 
 fail_clear:
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

