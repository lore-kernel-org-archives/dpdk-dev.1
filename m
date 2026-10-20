Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C93A606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YnNic0J5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 104E740689;
	Tue, 20 Oct 2026 17:21:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id ED01F40679;
 Tue, 20 Oct 2026 17:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509690; x=1824045690;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=53SDwVorbbwWKBgklA0cPykeGeleBvbnCJJ9hkn50z0=;
 b=YnNic0J5bHDM9GP43sbmj+7jPHhCD2X9ZyVhDJh2wNBHLdHi1Tu1DT+P
 tEfGCWWegQ2xRR7C61JkvY29lIfCibAzO6Wm4Il+/uerOWZSfcjBnX+WE
 SvceCEvOYEDsw6blb3Hc/qoLJqtza+5ddms7/Os9MtJjZCQTn7qf04TLO
 wgPCAeTiXCcLBdj/LDrWIOvBsiMkwa+gPX1vHVIJw3+buvfkTdWcWzTx3
 q3T2U8o95GtdhrFGPvxwOMmmXzqPrB8coyNidUDuUdEMrGr5RtqthJQMc
 RK25opH5E+G2vbkvpxqKVmaDuWeTujWhWMygPFaFEBf88AHUqh57MVkk5 A==;
X-CSE-ConnectionGUID: lRBN5fJlT5q0wmh6PtWxiA==
X-CSE-MsgGUID: ji57iSo/RV+3XsyoirGm/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226845"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226845"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:29 -0700
X-CSE-ConnectionGUID: lOdIqCO+S82x8zXqfjAuqQ==
X-CSE-MsgGUID: PJxbwAH1S+qE5dIxM9KTfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3240948"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:27 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com, stable@dpdk.org
Subject: [PATCH v2 2/3] net/iavf: fix bandwidth config of unshaped queues
Date: Tue, 20 Oct 2026 15:22:11 +0000
Message-ID: <c2447970c62fcb2136801bfcf06dd645b36f6f04.1792504817.git.dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504817.git.dawid.wesierski@intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
 <cover.1792504817.git.dawid.wesierski@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When configuring queue bandwidth via virtchnl in iavf_hierarchy_commit(),
an entry in the bandwidth configuration array is allocated for each queue
node. However, the driver only populated queue_id and tc for nodes that
had an active shaper profile.

Because the configuration buffer is zero-initialized with calloc(), any
unshaped queue node left its entry with queue_id 0, tc 0, and zero rate
limits. Consequently, the PF interpreted each unshaped queue entry as a
request to reset queue 0 to default bandwidth, leaving the actual target
queue untouched on the PF. Any previously configured rate limit on that
queue remained active, even across subsequent queue enables or process
restarts.

Fix this by setting queue_id and tc for every queue node, ensuring
unshaped queues properly send zeroed shaper rates for their own queue ID
so the PF restores their default bandwidth.

Fixes: 5779a8894d15 ("net/iavf: support queue rate limit configuration")
Cc: stable@dpdk.org

Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
- Commit message from Bruce Richardson. No code change.
- Add Acked-by.
 drivers/net/intel/iavf/iavf_tm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 603da09bb5..57075ee5b8 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -867,15 +867,15 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		}
 		q_tc_mapping->tc[tm_node->tc].req.queue_count++;
 
+		q_bw->cfg[node_committed].queue_id = tm_node->id;
+		q_bw->cfg[node_committed].tc = tm_node->tc;
 		if (tm_node->shaper_profile) {
-			q_bw->cfg[node_committed].queue_id = tm_node->id;
 			q_bw->cfg[node_committed].shaper.peak =
 			tm_node->shaper_profile->profile.peak.rate /
 			1000 * IAVF_BITS_PER_BYTE;
 			q_bw->cfg[node_committed].shaper.committed =
 			tm_node->shaper_profile->profile.committed.rate /
 			1000 * IAVF_BITS_PER_BYTE;
-			q_bw->cfg[node_committed].tc = tm_node->tc;
 		}
 
 		node_committed++;
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

