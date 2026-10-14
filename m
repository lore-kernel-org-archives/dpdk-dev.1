Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0883CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:23:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 051604064C;
	Wed, 14 Oct 2026 14:23:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 51CAC40612;
 Wed, 14 Oct 2026 14:23:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791980614; x=1823516614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6pDqAuzFIHWLkbc2yiA7eFvE9XG0GhYWcoy9D918tcw=;
 b=V2qRgmnIF/78QP5fUAuAom++fBGC042XI+vOOv4+uc7OgqiAmST0RWmf
 i1lgWQEXSt8yE6yKVPY4wbvKGO08deezDKPiKSphXvh8WKSFmGk2QAoMK
 6xGl4G7KUOVuFLnBbfUU64uYbZX1PJHL+4rZAyTLGh6GQWufTUXE6wgwF
 Qo0fJ/DdvSf32zgMOg8ltZ+3K/NixIoJUiQfm+mw5rNsiefxWCi3e/u++
 Bl9xSxMfpKagEv6T/YGbFRJZzaEUa/YTABydgZWjYRCNlu/g6iP5JgKH0
 o1lF0M4otASj4pmoD4mSs31xZsy9lYmJnicrXUEMXbrNZND+8hsjMDc6R Q==;
X-CSE-ConnectionGUID: TmWKo+8RSj2xSi+Qi1d70g==
X-CSE-MsgGUID: Ei4HwRfrQBqNhDqDhQHYqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="717299"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="717299"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:23:33 -0700
X-CSE-ConnectionGUID: 3mRasrOXSAKkDuY4DiGRjA==
X-CSE-MsgGUID: EOqBbimARNmLvX+LaxHFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1524779"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by fmviesa002.fm.intel.com with ESMTP; 14 Oct 2026 05:23:31 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com, stable@dpdk.org,
 Qi Zhang <qi.z.zhang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
 Ting Xu <ting.xu@intel.com>
Subject: [PATCH 2/3] net/iavf: fix bandwidth config of unshaped queues
Date: Wed, 14 Oct 2026 12:24:17 +0000
Message-ID: <20261014122419.631288-3-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014122419.631288-1-dawid.wesierski@intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
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

iavf_hierarchy_commit() sends one virtchnl_queue_bw entry for each queue
node, but it sets queue_id and tc only for a node that has a shaper
profile. The entry of a node without a profile keeps queue_id 0 and
tc 0. The PF then applies the default bandwidth to queue 0 once for
each such entry, and the queue that the node describes keeps its old
rate limit.

The ice PF keeps the queue rate limits of a VF and applies them again
at each queue enable, also for a later process on the same VF. Thus an
application cannot remove the rate limits of an earlier process with a
commit of queue nodes without shaper profiles.

Set queue_id and tc for each queue node. A node without a shaper
profile now gives the default bandwidth to its own queue.

Fixes: 5779a8894d15 ("net/iavf: support queue rate limit configuration")
Cc: stable@dpdk.org

Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
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

