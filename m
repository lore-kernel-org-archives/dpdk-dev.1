Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC7C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 18:05:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FED24113D;
	Tue,  3 Jun 2025 20:05:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9243240DCB
 for <dev@dpdk.org>; Tue,  3 Jun 2025 20:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748973921; x=1780509921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fh1JVHR+0ooGaasdf+qOC8OjTFUt7ClR8awfW/FfIrA=;
 b=Sem1tRY6UQLYwirwGhK/U9Kin4zmM+CPdev6G3jot+mPPFSN6SGeHv1e
 84DNKJfMhqVsxsy+cJH3zBkqsKtsNd+K3BLy53OMvg3J1kmR+GJ/lGTh2
 eCbCcK6RsRyp2koVJ/3HptHtKLrfzFGLHzM8Q9ZGQVWI1Yrmxr5DRK2hj
 eqi1hY3aSU/UCu4livX5kfmtncgjrSNBK/pBqIQAiQpKWumy3oNJYq87N
 rbunEnZtNUi6Oh1TNvmqxDjQxppUx8MtQF7iGo3pg5LPwO62psdrwk2WU
 yoz+gJgCCXJ3SP9SVRiXplYCxMJDGflZ9Z8uTm7Qdw1WI+pcVEwjUvoR2 w==;
X-CSE-ConnectionGUID: +yIhUvXHSseatufpw0AqWw==
X-CSE-MsgGUID: FZ8SzlpbQtClFgA4hDVEtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68463579"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68463579"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 11:05:21 -0700
X-CSE-ConnectionGUID: MmUIcLRNQqOt+aSkb0Vfpw==
X-CSE-MsgGUID: dy6TW7gvT2GDY51ODOGtCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="168110475"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2025 11:05:20 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v2 2/7] event/dlb2: changes to correctly validate COS ID
 arguments
Date: Tue,  3 Jun 2025 13:05:09 -0500
Message-Id: <20250603180514.3826917-3-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603180514.3826917-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250603180514.3826917-1-pravin.pathak@intel.com>
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

While providing port_cos as vdev/pf CLI argument, the port numbers should
take into account all ports (LDB and DIR) that are created by the
application and the same order should be provided for port_cos parameter.
This fix add checks to ensure that above is validated correctly.

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c      | 32 +++++++++++++++++++++++---------
 drivers/event/dlb2/dlb2_priv.h |  1 -
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index a0e673b96b..58eb27f495 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -194,10 +194,8 @@ dlb2_init_port_cos(struct dlb2_eventdev *dlb2, int *port_cos)
 	for (q = 0; q < DLB2_MAX_NUM_PORTS_ALL; q++) {
 		dlb2->ev_ports[q].cos_id = port_cos[q];
 		if (port_cos[q] != DLB2_COS_DEFAULT &&
-		    dlb2->cos_ports[port_cos[q]] < DLB2_MAX_NUM_LDB_PORTS_PER_COS) {
+		    dlb2->cos_ports[port_cos[q]] < DLB2_MAX_NUM_LDB_PORTS_PER_COS)
 			dlb2->cos_ports[port_cos[q]]++;
-			dlb2->max_cos_port = q;
-		}
 	}
 }
 
@@ -531,8 +529,8 @@ set_port_cos(const char *key __rte_unused,
 	     const char *value,
 	     void *opaque)
 {
+	int first, last, cos_id, i, ports_per_cos[DLB2_COS_NUM_VALS] = {0};
 	struct dlb2_port_cos *port_cos = opaque;
-	int first, last, cos_id, i;
 
 	if (value == NULL || opaque == NULL) {
 		DLB2_LOG_ERR("NULL pointer");
@@ -566,6 +564,14 @@ set_port_cos(const char *key __rte_unused,
 	for (i = first; i <= last; i++)
 		port_cos->cos_id[i] = cos_id; /* indexed by port */
 
+	for (i = 0; i < DLB2_MAX_NUM_PORTS_ALL; i++)
+		if (port_cos->cos_id[i] != DLB2_COS_DEFAULT &&
+			++ports_per_cos[port_cos->cos_id[i]] > DLB2_MAX_NUM_LDB_PORTS_PER_COS) {
+			DLB2_LOG_ERR("Error parsing ldb port cos_id devarg: More than 16 ports for "
+				"cos_id %d.", port_cos->cos_id[i]);
+			return -EINVAL;
+		}
+
 	return 0;
 }
 
@@ -866,9 +872,10 @@ dlb2_hw_create_sched_domain(struct dlb2_eventdev *dlb2,
 			    const struct dlb2_hw_rsrcs *resources_asked,
 			    uint8_t device_version)
 {
-	int ret = 0;
-	uint32_t cos_ports = 0;
+	uint32_t total_asked_ports;
 	struct dlb2_create_sched_domain_args *cfg;
+	uint32_t cos_ports = 0, max_cos_port = 0;
+	int ret = 0;
 
 	if (resources_asked == NULL) {
 		DLB2_LOG_ERR("dlb2: dlb2_create NULL parameter");
@@ -876,6 +883,8 @@ dlb2_hw_create_sched_domain(struct dlb2_eventdev *dlb2,
 		goto error_exit;
 	}
 
+	total_asked_ports = resources_asked->num_ldb_ports + resources_asked->num_dir_ports;
+
 	/* Map generic qm resources to dlb2 resources */
 	cfg = &handle->cfg.resources;
 
@@ -897,9 +906,14 @@ dlb2_hw_create_sched_domain(struct dlb2_eventdev *dlb2,
 	cos_ports = dlb2->cos_ports[0] + dlb2->cos_ports[1] +
 		    dlb2->cos_ports[2] + dlb2->cos_ports[3];
 
-	if (cos_ports > resources_asked->num_ldb_ports ||
-	    (cos_ports && dlb2->max_cos_port >= resources_asked->num_ldb_ports)) {
-		DLB2_LOG_ERR("dlb2: num_ldb_ports < cos_ports");
+	for (int i = 0; i < DLB2_MAX_NUM_PORTS_ALL; i++) {
+		if (dlb2->ev_ports[i].cos_id != DLB2_COS_DEFAULT)
+			max_cos_port = i;
+	}
+
+	if (cos_ports > resources_asked->num_ldb_ports || max_cos_port >= total_asked_ports) {
+		DLB2_LOG_ERR("dlb2: Insufficient num_ldb_ports=%d: cos_ports=%d max_cos_port=%d",
+			resources_asked->num_ldb_ports, cos_ports, max_cos_port);
 		ret = EINVAL;
 		goto error_exit;
 	}
diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 4dd7532519..285d427397 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -649,7 +649,6 @@ struct dlb2_eventdev {
 	};
 	uint32_t cos_ports[DLB2_COS_NUM_VALS]; /* total ldb ports in each class */
 	uint32_t cos_bw[DLB2_COS_NUM_VALS]; /* bandwidth per cos domain */
-	uint8_t max_cos_port; /* Max LDB port from any cos */
 	bool enable_cq_weight;
 };
 
-- 
2.25.1

