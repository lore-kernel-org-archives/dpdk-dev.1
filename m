Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A17CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1EFA40670;
	Mon,  8 Jun 2026 18:14:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 079A34067E
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780935253; x=1812471253;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NwDb8ugumJ5KE5U6Fvr4FyXLSaxXJ70N2KtSeO5HndQ=;
 b=bzeUzb74ebmvl5mIfERPVl/xo1i1hdcCsBazSNDbuX+dxnvHlKtHX+35
 YvDBv0dpIAbqUz8o7FtDtrUJ//oI00Gy6IRtC5Oi7Iuj0yRG5BfrCGIdV
 91Xh+yiHMsYkQOm/77eiGymY/bdORkQJTa/HvVFUzYt4mo6M5e4xFMj10
 Th7cxua0XGewxNDFSKk23fT81uN53tDw9kYJokEx0vvBFj9ADyiLl/GKL
 rWaFjc2ncQFf98ghkXFrQXaYqMA08USKZ8ZpPzVq8Zhs++Q/BZ0vL+vGN
 HPjAEbv/OsOtktNpTx6USMbL3zQynBysUBJd6zUWFNWre562Y5WbF71KJ A==;
X-CSE-ConnectionGUID: qpMUi3lDTsqkfIbZIayWIA==
X-CSE-MsgGUID: uOxF8WIVTYe9m8SOD8318A==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80809544"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80809544"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:14:13 -0700
X-CSE-ConnectionGUID: 3uWv8LnBRdKULwBDlP56fg==
X-CSE-MsgGUID: 0sJ2BaU/QruV43I6mDKP3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245457437"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa008.jf.intel.com with ESMTP; 08 Jun 2026 09:14:11 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 2/7] net/iavf: allow runtime queue rate limit configuration
Date: Mon,  8 Jun 2026 12:40:54 -0400
Message-ID: <20260608164059.65420-3-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
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

