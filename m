Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663F606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lvIYsPwg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9121740144;
	Tue, 20 Oct 2026 15:22:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2C47640283;
 Tue, 20 Oct 2026 15:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792502520; x=1824038520;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yr6HLboPssT/9o9ggIQbnIMs13B0ncCNe1cl7vxGwpw=;
 b=lvIYsPwgc24xNWG56sd+WkwembYV/C7K8vnY2YivzJFugI/HLboBvGzx
 QCCiBX7R8R+U8E/UxGberjMCGN8A08l95LtjVjq4KHeqDmMj3VYrqkoSo
 R0VM8MTwXemaKF308dTg1YWDmPTgZMrxH1tmpOKq/4tvXDJSd5GgonQNx
 zw0s1kbAfA38pqvxJeyG+zH6kEomFf73ZB92RhU+0iWh9fHdqer7p9xz1
 YkXYfiCRj6TzIWQmDMtRDpchqH8Vv8Dm2Zkpb2tfCDCx0JyqHK2nh7y1/
 EOBIrnFXKKrRnGJ0lD1xFM9/qBPoNv2WL6IowF5spbe2sTr4BfMerxj5O A==;
X-CSE-ConnectionGUID: KlqeIZblQraOYLTiZKzAjQ==
X-CSE-MsgGUID: vSrWX1VISMeGBZodZkACkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1092340"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1092340"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:21:59 -0700
X-CSE-ConnectionGUID: Hjkf4HmMRjW6mAE8h1z1Dw==
X-CSE-MsgGUID: T9BQVjC9QEWOHpXiBBOFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4561253"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa012.fm.intel.com with ESMTP; 20 Oct 2026 06:21:57 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: maxime@leroys.fr,
	stable@dpdk.org
Subject: [PATCH 1/3] fib6: fix temporary tbl8 for byte-aligned prefixes
Date: Tue, 20 Oct 2026 13:21:53 +0000
Message-ID: <20261020132155.980174-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, `install_to_dp()` builds one tbl8 level more than a route
range needs when the range ends on a byte boundary. If the range
spans a whole table at its first uncommon byte, e.g. a /32 or a /40,
`build_common_root()` allocates a tbl8 one level too deep, all of
its entries get the same next hop and `recycle_root_path()` frees it
again. Below /24, an edge aligned on /24, e.g. of a /16, gets a tbl8 that
`write_edge()` fills and recycles at once.

These temporary tbl8s are not covered by `rsvd_tbl8s`, which counts
only the levels the route set keeps. With a nearly full pool, an add
that passed the reservation check runs out of tbl8s in the middle of the
install, the tbl8 already linked into the dataplane is leaked and a later
add that fits is refused. A /32 can not be added to a pool of one tbl8,
nor deleted from a full pool.

Fix it by not building these levels.

Bugzilla ID: 1970
Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
Cc: stable@dpdk.org

Reported-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 lib/fib/trie.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 187360d1c8..0ae669c689 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -410,20 +410,33 @@ install_to_dp(struct rte_trie_tbl *dp, const struct rte_ipv6_addr *ledge,
 			break;
 	}
 
+	/*
+	 * A range covering a whole tbl8 is a single entry one level up.
+	 * Write that entry rather than build a tbl8 only to recycle it.
+	 */
+	if (common_bytes >= TBL24_BYTES) {
+		for (i = common_bytes; i <= IPV6_MAX_IDX; i++) {
+			if (ledge->a[i] != 0 || redge.a[i] != UINT8_MAX)
+				break;
+		}
+		if (i > IPV6_MAX_IDX)
+			common_bytes--;
+	}
+
 	ret = build_common_root(dp, ledge, common_bytes, &common_root_tbl);
 	if (unlikely(ret != 0))
 		return ret;
 	/*first uncommon tbl8 byte idx*/
 	uint8_t first_tbl8_byte = RTE_MAX(common_bytes, TBL24_BYTES);
 
-	for (i = IPV6_MAX_IDX; i > first_tbl8_byte; i--) {
+	for (i = IPV6_MAX_IDX; i >= first_tbl8_byte + !(common_bytes < 3); i--) {
 		if (ledge->a[i] != 0)
 			break;
 	}
 
 	llen = i - first_tbl8_byte + (common_bytes < 3);
 
-	for (i = IPV6_MAX_IDX; i > first_tbl8_byte; i--) {
+	for (i = IPV6_MAX_IDX; i >= first_tbl8_byte + !(common_bytes < 3); i--) {
 		if (redge.a[i] != UINT8_MAX)
 			break;
 	}
-- 
2.43.0

