Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0B3CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB00940DF8;
	Thu, 18 Jun 2026 16:17:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 158DA40C35
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781792262; x=1813328262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p3WiKpjV57trgcSInouV2QcrpgjH5tApI7vNrHFG8lM=;
 b=mYIb2YlM8U74SYNPYnUyy2W57egTu3+I7T3OwWtYEqrUc32dxYlg1SFe
 Qwj88c4E5CJaR7x8dB7dU+jirR3Cfu7sS4PSopr2AwUWAnLCkj2KTvSSd
 fuIGg7Oj3yCF4Tiq8zzwyrpfPBrOV46eIYmTD6FcVa7c5i5sdmPIbWVdo
 N2h9hVOyHTTMvSfozsLx5no+Xa+BzdkzFdoKhj+I3Z6qkyvj9eBXBrpQV
 5GalUtybQcFDWY1xOIx1rkiuou4XlNJXEQ/mQDgaE+niU1goZVN7j7mHV
 woeCEANMbNB6d7i+nuQtacv2sdjuAyFKUOl0uhMe9TMhtQhFZN67EROfz g==;
X-CSE-ConnectionGUID: QptswZA3QsaGRF524Rew9Q==
X-CSE-MsgGUID: 80GQSDVhQa6SVQD+vZgenA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81736966"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="81736966"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:17:42 -0700
X-CSE-ConnectionGUID: cW+hp6lRQTGikYvLGy+72g==
X-CSE-MsgGUID: ssqnQs3oTAyCpjqiH7ixaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="248457626"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 07:17:41 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 3/7] net/iavf: allow runtime queue rate limit configuration
Date: Thu, 18 Jun 2026 10:44:38 -0400
Message-ID: <20260618144442.312844-4-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618144442.312844-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260618144442.312844-1-dawid.wesierski@intel.com>
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
 drivers/net/intel/iavf/iavf_tm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 1cf7bfb106..43d7a44337 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -804,8 +804,10 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 	int index = 0, node_committed = 0;
 	int i, ret_val = IAVF_SUCCESS;
 
-	/* check if port is stopped */
-	if (adapter->stopped != 1) {
+	/* check if port is stopped, except for setting queue bandwidth */
+	if (vf->tm_conf.nb_tc_node != 1 &&
+	    vf->qos_cap->num_elem != 1 &&
+	    adapter->stopped != 1) {
 		PMD_DRV_LOG(ERR, "Please stop port first");
 		ret_val = IAVF_ERR_NOT_READY;
 		goto err;
@@ -856,7 +858,7 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		q_tc_mapping->tc[tm_node->tc].req.queue_count++;
 
 		if (tm_node->shaper_profile) {
-			q_bw->cfg[node_committed].queue_id = node_committed;
+			q_bw->cfg[node_committed].queue_id = tm_node->id;
 			q_bw->cfg[node_committed].shaper.peak =
 			tm_node->shaper_profile->profile.peak.rate /
 			1000 * IAVF_BITS_PER_BYTE;
@@ -900,7 +902,8 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
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

