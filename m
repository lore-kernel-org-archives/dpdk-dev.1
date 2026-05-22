Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9209CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 14:59:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4D8740672;
	Fri, 22 May 2026 16:59:15 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id C9B67406A2
 for <dev@dpdk.org>; Fri, 22 May 2026 16:59:12 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso4444619f8f.3
 for <dev@dpdk.org>; Fri, 22 May 2026 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779461952; x=1780066752; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sgfSafEcY2FkyaDsHPA1WZ2n9BzJ09ffIpBTXRSVMQ=;
 b=jVJFk0503ujZGhX50xrrDd+5TrPEZXTfw2/N+OkVkYuPDfsStMvcb4emGeHK1WwLvI
 46mxhH8GQlGBBrnh43xiI1EKJDk6yIEaRdsgbGohBVZ3hIEi0WLnRlzUv4rQdnxDuc7r
 JXdfbZiBWDTnP+V+Gss1qjV/Wjl2xlBwHqrbzMqQ+FLGZHdKE71Bpumd3UhCS6c22R+n
 nJ+QV5Huaf5OA55yS/5CkYqHvI4trsNDJ2+VoZaIB/77WOCn9HHkqxk31ZMA1EBxrhtG
 c+GfwwFytO0pPiRHMGnrXPVvYOa8YWrmbpCaVrUYgkr+xxbxJSF5BYwu3A++VjOCJq2P
 xA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779461952; x=1780066752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2sgfSafEcY2FkyaDsHPA1WZ2n9BzJ09ffIpBTXRSVMQ=;
 b=Wx2fcOUay5hg8QDEAVp5CCnWPuLxVoFOEvGLaxl0eHE7Oas6gEZPH3R3SYLDBUjoek
 lAcx7jckBAoWq7nV2Qt7YJq+dZDCll39o7aht+BophkYcp9YdPP48aDCBfuSVyVEXuHq
 SoysdwkBeHsoryedCyoVIG6/h3j+rhcbzVFtdykTzntmlJyMxfPC3x8tDUqBXhvJ7F7Y
 Dmj4ZvgMkDhcKDwOOzUEtov64FGIiJVUjkwrz5Bea3oE83d6bFqDwmNOSeCiVLip53sB
 ftgLSe0Kpppg19216UJctST1UyUrFDsomYbV4XSLCtNk7vkCDo7ICfBqL7YhDl5sSYLN
 AOOA==
X-Gm-Message-State: AOJu0YzWHTMFW0wQnNnYL4X+dbHOfm7fG2pqsN2rhRBc2VwCSv6qHrlp
 yDlkGsIxPhSaFt/3TUgZlmnIXbQNxWgKOEwNugPat1KL3dns7h0Q3Zqk
X-Gm-Gg: Acq92OEi9+H5uo8/GcCmWEOQxMIoAf7HMn/IhgMmd5zTl9RCNcOWsg/Xx41zT+gDh1P
 EVvGxGiy+Js6B0NMra2U1DjXQvzPkYNqxDexFjYzif6gfRpdOt5y3PMuhdObXPIwDiapR/n3aps
 TrkGGGULk2OLE4559JHjGl3SPQ1pzYj+HWqefxfVURomB3p3KKx5QjAMTp3BlFJPzkwFaNmTqYv
 INOzotiz8kSwpWgNIjK+gYbi1sRFnlL8zVfDuNVqXJXdssMyNWmVek1md9zgF+fH9aCotULkK+f
 c3NF5dD+wT7XG4MqTt7ojXR94fXlqYj9A+FZv68rHV2nOXXB7BZaSo1dBnMrtgbCBoY+wzs/RdX
 b7/LiVccHfiBQJhlXjgWBIlH/tZRMktAx/U9y7WmtMqD0IPtLIVAHa33Wva68OC6p2sRnPddr0M
 2WKD19mM20TgEwEom52x2xqI62zfbekhVPnFj54yK8vQyeTL0WysDzN4w=
X-Received: by 2002:a05:6000:2c11:b0:45d:b14b:23f0 with SMTP id
 ffacd0b85a97d-45eb38b8a19mr6515479f8f.15.1779461952198; 
 Fri, 22 May 2026 07:59:12 -0700 (PDT)
Received: from localhost.localdomain (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm4623979f8f.5.2026.05.22.07.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:59:11 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v1 5/5] fib6: speed up tbl8 reservation accounting
Date: Fri, 22 May 2026 16:58:54 +0200
Message-ID: <20260522145855.1748406-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522145855.1748406-1-maxime@leroys.fr>
References: <cover.1778146229.git.maxime@leroys.fr>
 <20260522145855.1748406-1-maxime@leroys.fr>
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

Replace the local count_empty_levels() helper, which issued up to 13
rte_rib6_get_nxt() calls each descending the binary tree from root,
with the new __rte_internal rte_rib6_count_empty_supernets(). The
latter descends once and consults the valid_descendants counter
maintained inside rte_rib6, answering all byte boundary questions
in O(tree depth) with O(1) work per boundary.

For a /128 ADD with ancestors at every byte boundary, this reduces
the worst-case query cost from 13 trie descents to 1.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 lib/fib/trie.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 44b90f72ff..b6ef626fd4 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -13,6 +13,7 @@
 
 #include <rte_rib6.h>
 #include <rte_fib6.h>
+#include <rib6_internal.h>
 #include "fib_log.h"
 #include "trie.h"
 
@@ -534,31 +535,6 @@ modify_dp(struct rte_trie_tbl *dp, struct rte_rib6 *rib,
 	return 0;
 }
 
-/*
- * Count byte boundaries between 24 and CEIL(depth, 8) where the
- * supernet of ip has no descendant in the RIB. This is the number of
- * new tbl8 levels an ADD of ip/depth would introduce, or the number
- * to free at DEL once the prefix has been removed from the RIB.
- *
- * A NULL answer at level L propagates upwards: narrower supernets at
- * L+8, L+16, ... are subsets of S_L and cannot contain descendants
- * either. The loop stops at the first NULL and tallies the remaining
- * boundaries in one shot.
- */
-static uint8_t
-count_empty_levels(struct rte_rib6 *rib, const struct rte_ipv6_addr *ip,
-	uint8_t depth)
-{
-	uint8_t level, top = RTE_ALIGN_CEIL(depth, 8);
-
-	for (level = 24; level < top; level += 8) {
-		if (rte_rib6_get_nxt(rib, ip, level, NULL,
-				RTE_RIB6_GET_NXT_COVER) == NULL)
-			return (top - level) >> 3;
-	}
-	return 0;
-}
-
 int
 trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop, int op)
@@ -596,7 +572,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 			return 0;
 		}
 
-		new_levels = count_empty_levels(rib, &ip_masked, depth);
+		new_levels = rte_rib6_count_empty_supernets(rib, &ip_masked, depth);
 		if (dp->rsvd_tbl8s + new_levels > dp->number_tbl8s)
 			return -ENOSPC;
 
@@ -635,7 +611,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 		if (ret != 0)
 			return ret;
 		rte_rib6_remove(rib, &ip_masked, depth);
-		dp->rsvd_tbl8s -= count_empty_levels(rib, &ip_masked, depth);
+		dp->rsvd_tbl8s -= rte_rib6_count_empty_supernets(rib, &ip_masked, depth);
 		return 0;
 	default:
 		break;
-- 
2.43.0

