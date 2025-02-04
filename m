Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B57C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 20:57:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E79D840609;
	Tue,  4 Feb 2025 21:57:29 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A0AA8400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 21:57:22 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2A84D210C317; Tue,  4 Feb 2025 12:57:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A84D210C317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738702641;
 bh=N4vguHG6PEsLbIgbNHV9UMQLsOxnQR/SrPuum4VvO50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N8y1ZNA+2JLCdF7DZNSuOwChx+iTk9lwlWh6etbZtMpEhC4rNHLDqVpMBwaFlRZlh
 bJ90xf2d7q/2Ul6eXXaSNvu936qVVfIzBQ/BrTRaU957co+Ug1mAkLRn8/AOShh7AI
 1w8WsLK4kUWluQIobs+BC+8AHaXGJxvWAmpjlEgE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v21 05/27] hash: remove use of VLAs for Windows built code
Date: Tue,  4 Feb 2025 12:56:56 -0800
Message-Id: <1738702638-22363-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
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

