Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC2C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C408F40651;
	Tue, 30 Jun 2026 13:40:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6B3384064F
 for <dev@dpdk.org>; Tue, 30 Jun 2026 13:40:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782819622; x=1814355622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+6qgp2T1rydua/pCZROu348zWndWtb2eV2XrYTiB1Gs=;
 b=UjmdhqjcTS/3OxEyv0k+4tmwjdL8/QxD8RI/1f7IER5UUCKclT/CpmVk
 lfNX5ymLzNsj4v7XTy6JxY8Qym6YeL0nxlQ58LAqlFwhNpyx979W41dAm
 93aXg6P0UY43vyo56oSQvg6QljTegLN+ZdUr+J3jR7YxGdeLKgFBABo66
 Vi4UwlOFEvEAW7yFL7IweGvC0RIghw9hQEo/05EqHVHmfRl9i0ZtTQ1Yv
 VHDgzY/UljOxBTJqCH4n15i9yMd1Jdx+vEFXtha0fVm9SYTOxuMFF2T84
 ylBj6+0Sb1NmpMZJ9MsMCN4X5r8ib7vQX8Yzqc384pAVSc6L5VjKIGXBf Q==;
X-CSE-ConnectionGUID: F/ii7qrITBOnhxH7EoewHA==
X-CSE-MsgGUID: a9JRotTIQsu4StmI85wJqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82643727"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="82643727"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 04:40:22 -0700
X-CSE-ConnectionGUID: JoqwlvnvRF2T1FkQueszUw==
X-CSE-MsgGUID: LDN3N2jNRoe9pkdd67vUuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="245891141"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa009.fm.intel.com with ESMTP; 30 Jun 2026 04:40:20 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, marek.kasiewicz@intel.com,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v3 2/6] net/iavf: allow runtime queue rate limit configuration
Date: Tue, 30 Jun 2026 08:06:52 -0400
Message-ID: <20260630120657.1046588-3-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630120657.1046588-1-dawid.wesierski@intel.com>
References: <20260618144442.312844-8-dawid.wesierski@intel.com>
 <20260630120657.1046588-1-dawid.wesierski@intel.com>
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

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

