Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987ACCC6B2D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:40:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51DBC40B9A;
	Wed, 14 Oct 2026 20:39:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4F73F40A67
 for <dev@dpdk.org>; Wed, 14 Oct 2026 20:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003178; x=1823539178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0vwQaarOVhzfHayv4Rwm0MuEpzs2g+jDDLcJ2gVhYgk=;
 b=WgYg7OtaG8pCEW7phb0Q1PEB4yIOGZz4hqYBDukQ+6H6Knol5u3dYkvV
 G+6EOhLV9QYphf5le7Y4biNVFxCyJNwdJD/ZM3L1fEtIWvYgeqWnmFpuo
 jk2SV2t8060JzoSf7TBww+RSQ332rsZ8pqQnJcb2WQ9VGytk17uzVv1Li
 +dAXa/YGPTgU2Ffx9De4ZB+jhV/OEoH0eUkWyT1Jn+pQYExF32Jpn65tA
 Ey6Qw+/ROGU5vLnA8MKHryk5+UUdfBPyvmQGiDcpOqYiMg2wBoYbWWV74
 j3QotrXdYOJBPiBTvbYIdayt14S0oqiQB97Rp1NwRDNvqr34ikDMM7rbQ w==;
X-CSE-ConnectionGUID: I6Cq0l56R6SDz1GiF8mvVQ==
X-CSE-MsgGUID: ugUxBOPnQliLJ1DQqB9k5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753378"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753378"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:34 -0700
X-CSE-ConnectionGUID: nIYux8rbSJ21tosiEBCQzQ==
X-CSE-MsgGUID: GAwHn73BQtm50VRL+uzs9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419907"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:34 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com
Subject: [RFC PATCH v2 6/7] fib: split DIR24-8 table update from the FIB
 wrapper
Date: Wed, 14 Oct 2026 18:39:20 +0000
Message-ID: <20261014183921.495158-7-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
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

Move the body of dir24_8_modify() into dir24_8_modify_dp(), taking the
dataplane table and the RIB directly, and expose it in the internal
header so that another dataplane can drive a DIR24_8 table.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/dir24_8.c | 34 +++++++++++++++++++++-------------
 lib/fib/dir24_8.h |  4 ++++
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 9b14693320..48be1c0617 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -465,26 +465,15 @@ modify_fib(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
 }
 
 int
-dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
-	uint64_t next_hop, int op)
+dir24_8_modify_dp(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
+	uint8_t depth, uint64_t next_hop, int op)
 {
-	struct dir24_8_tbl *dp;
-	struct rte_rib *rib;
 	struct rte_rib_node *tmp = NULL;
 	struct rte_rib_node *node;
 	struct rte_rib_node *parent;
 	int ret = 0;
 	uint64_t par_nh, node_nh;
 
-	RTE_SET_USED(vrf_id);
-
-	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
-		return -EINVAL;
-
-	dp = rte_fib_get_dp(fib);
-	rib = rte_fib_get_rib(fib);
-	RTE_ASSERT((dp != NULL) && (rib != NULL));
-
 	if (next_hop > get_max_nh(dp->nh_sz))
 		return -EINVAL;
 
@@ -557,6 +546,25 @@ dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
 	return -EINVAL;
 }
 
+int
+dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
+	uint64_t next_hop, int op)
+{
+	struct dir24_8_tbl *dp;
+	struct rte_rib *rib;
+
+	RTE_SET_USED(vrf_id);
+
+	if ((fib == NULL) || (depth > RTE_FIB_MAXDEPTH))
+		return -EINVAL;
+
+	dp = rte_fib_get_dp(fib);
+	rib = rte_fib_get_rib(fib);
+	RTE_ASSERT((dp != NULL) && (rib != NULL));
+
+	return dir24_8_modify_dp(dp, rib, ip, depth, next_hop, op);
+}
+
 void *
 dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 {
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index 88c47072d9..99e8be660e 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -308,6 +308,10 @@ int
 dir24_8_modify(struct rte_fib *fib, uint16_t vrf_id, uint32_t ip, uint8_t depth,
 	uint64_t next_hop, int op);
 
+int
+dir24_8_modify_dp(struct dir24_8_tbl *dp, struct rte_rib *rib, uint32_t ip,
+	uint8_t depth, uint64_t next_hop, int op);
+
 int
 dir24_8_rcu_qsbr_add(struct dir24_8_tbl *dp, struct rte_fib_rcu_config *cfg,
 	const char *name);
-- 
2.43.0

