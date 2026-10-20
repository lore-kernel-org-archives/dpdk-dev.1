Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359B606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i18SmhMh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DA914068A;
	Tue, 20 Oct 2026 17:21:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5CA9740679
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792509689; x=1824045689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rde9TPO3Hhm1qexmocHQ8dFbHak553wy9YV5NdJuwWk=;
 b=i18SmhMhKUObV7gfej14jV+0ydXkNuQO9K44gy+AfXMTUe1VT8Ai1b8t
 BoP3JtWTf04x0HHoDNuHl5FdXwxQGqtaJVNc83529zqaEU0nj28pT3/jF
 kkoT3cCuW/dNzcMUAwy7KRz/LPwXDeIwwRlIpGAQosKIxJIyGFSdWu6HI
 ueWEMX3LhQCtU5TuvFIHlkYCN90FdKk5yY1b10+5YoKSF+4fWW97okPap
 GMbHKK4i1vZDazI5grTiwIkIjsYtMKvCoD3dGH65JyIShBYDysMOwFzAb
 lejrvcvcNJL7yvCm7LXFpav2tF7v5EB+OOB5aSWXDANsl6U77JbHwVekH Q==;
X-CSE-ConnectionGUID: BrSlSdl+QmWdg+Ck9sDprA==
X-CSE-MsgGUID: EN1uXE3sQ6SP2FCdEp3wGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1226844"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1226844"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 08:21:29 -0700
X-CSE-ConnectionGUID: Xj90X6EkTYie3DokYjfJMQ==
X-CSE-MsgGUID: J3c0syKiToKEiaI8S49s9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3240942"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by orviesa010.jf.intel.com with ESMTP; 20 Oct 2026 08:21:25 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com
Subject: [PATCH v2 1/3] net/iavf: fix invalid free of queue TC map
Date: Tue, 20 Oct 2026 15:22:10 +0000
Message-ID: <62e9fda7ef2214728abedd028d677505f464e6e7.1792504817.git.dawid.wesierski@intel.com>
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

iavf_hierarchy_commit() allocates the queue TC map with calloc(), and
it frees the previous map with free(old_qtc_map) after a successful
commit. A later change added rte_free(vf->qtc_map) in front of that
free(), because it was written for a tree that still leaked the map.

After the first commit, rte_free() gets a pointer from the libc
heap, and free() then releases the same pointer a second time.
rte_free() reads a malloc_elem header in the bytes in front of the
pointer. It usually logs "Invalid memory" and returns, but the result
depends on the contents of the libc heap.

Remove the rte_free() call. free(old_qtc_map) releases the old map.

The same change also added rte_free(vf->qtc_map) to iavf_uninit_vf(),
after the free(vf->qtc_map) that already releases the map and sets the
pointer to NULL. That call has no effect, but it is the wrong allocator
for this pointer. Remove it too.

Fixes: f6e33f09f766 ("net/iavf: disable runtime queue setup when rate limiting")

Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v2:
- Also remove rte_free(vf->qtc_map) in iavf_uninit_vf() (Bruce).
- Add Acked-by.
 drivers/net/intel/iavf/iavf_ethdev.c | 8 --------
 drivers/net/intel/iavf/iavf_tm.c     | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 7f1ad3d88c..9e0e13d499 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2794,14 +2794,6 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
 	rte_free(vf->proto_xtr);
 	vf->proto_xtr = NULL;
 
-	/*
-	 * Drop the committed queue/TC bandwidth mapping so a subsequent
-	 * iavf_init_vf() (e.g. after a device reset) starts with runtime
-	 * Rx/Tx queue setup available again (see iavf_dev_info_get()).
-	 */
-	rte_free(vf->qtc_map);
-	vf->qtc_map = NULL;
-
 	rte_free(vf->rss_lut);
 	vf->rss_lut = NULL;
 	rte_free(vf->rss_key);
diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index fc84bf7e6b..603da09bb5 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -913,7 +913,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
 		goto fail_clear;
 
 	/* replace the previously committed mapping, if any */
-	rte_free(vf->qtc_map);
 	vf->qtc_map = qtc_map;
 	free(old_qtc_map);
 	if (adapter->stopped == 1)
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

