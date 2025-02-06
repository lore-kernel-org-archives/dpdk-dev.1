Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D558C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:34:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1868A406BB;
	Thu,  6 Feb 2025 02:33:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1CCE64042C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:38 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A82CF20BCAF2; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A82CF20BCAF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805616;
 bh=N4vguHG6PEsLbIgbNHV9UMQLsOxnQR/SrPuum4VvO50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SSJilCxCLJU1XVRzKCtv7w+aCMNrxdBUNZ0k0OnYDtAg850Hxm9zqGskMpA46TYWd
 GKeBwr33nOiNa7um2do6krANchHyTjHRq5ORVtIDfnvxa1kbRGsx+2L7ZJF0NBd21i
 N6vqVqt8LsVBpdVBmtIK5brXGLG+bo6/dN8I9gY8=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v22 05/27] hash: remove use of VLAs for Windows built code
Date: Wed,  5 Feb 2025 17:33:08 -0800
Message-Id: <1738805610-17507-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Konstantin Ananyev <konstantin.ananyev@huawei.com>

1) ./lib/hash/rte_cuckoo_hash.c:2362:9
    : warning: ISO C90 forbids variable length array ‘positions’
2) ../lib/hash/rte_cuckoo_hash.c:2478:9
    : warning: ISO C90 forbids variable length array ‘positions’

Both rte_hash_lookup_bulk_data() and
rte_hash_lookup_with_hash_bulk_data() expect
@num_keys <= RTE_HASH_LOOKUP_BULK_MAX.
So, for both cases it should be safe to replace VLA with fixed size
array.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/hash/rte_cuckoo_hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 9575e8aa0c..fc93182efe 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -2418,7 +2418,7 @@ rte_hash_lookup_bulk_data(const struct rte_hash *h, const void **keys,
 			(num_keys > RTE_HASH_LOOKUP_BULK_MAX) ||
 			(hit_mask == NULL)), -EINVAL);
 
-	int32_t positions[num_keys];
+	int32_t positions[RTE_HASH_LOOKUP_BULK_MAX];
 
 	__rte_hash_lookup_bulk(h, keys, num_keys, positions, hit_mask, data);
 
@@ -2534,7 +2534,7 @@ rte_hash_lookup_with_hash_bulk_data(const struct rte_hash *h,
 			(num_keys > RTE_HASH_LOOKUP_BULK_MAX) ||
 			(hit_mask == NULL)), -EINVAL);
 
-	int32_t positions[num_keys];
+	int32_t positions[RTE_HASH_LOOKUP_BULK_MAX];
 
 	__rte_hash_lookup_with_hash_bulk(h, keys, sig, num_keys,
 			positions, hit_mask, data);
-- 
2.47.2.vfs.0.1

