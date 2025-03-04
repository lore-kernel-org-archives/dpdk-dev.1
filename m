Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802DFC282D2
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 16:49:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6C024029A;
	Tue,  4 Mar 2025 17:48:59 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 167B340287
 for <dev@dpdk.org>; Tue,  4 Mar 2025 17:48:58 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5AE17210EAE2; Tue,  4 Mar 2025 08:48:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AE17210EAE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741106937;
 bh=UAWpryexxv/Moi7zB0TEaL8BixT57ms9obJm+syMAJA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=svAvG5g6RY+n0TmAszDC6oWyTbweOMtpi2zvlBydtJX2Am0JNaIQvtMzpJZUhCjzy
 q/vIKW6xrY7Qs0K3zJlPX6Z64fcl0WbK5qTj4I0DknvUtasXKslJEccDQlnt5lLdRh
 B8owa/PlY5kckUc4frcCyxAEb9G6b+3Qmli63ql4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	vladimir.medvedkin@intel.com
Subject: [PATCH v4] lib/fib: remove warning about implicit 64-bit conversion
Date: Tue,  4 Mar 2025 08:48:54 -0800
Message-Id: <1741106934-21512-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
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

MSVC issues the warning below:

../lib/fib/trie.c(341): warning C4334: '<<':
result of 32-bit shift implicitly converted to 64 bits
(was 64-bit shift intended?)

The fix is to cast (1) explicitly to uintptr_t since it is used
in pointer arithmetic.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/fib/trie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 4893f6c636..f077b65a28 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -338,7 +338,7 @@ write_edge(struct rte_trie_tbl *dp, const uint8_t *ip_part, uint64_t next_hop,
 		if (ret < 0)
 			return ret;
 		if (edge == LEDGE) {
-			write_to_dp((uint8_t *)p + (1 << dp->nh_sz),
+			write_to_dp(RTE_PTR_ADD(p, (uintptr_t)(1) << dp->nh_sz),
 				next_hop << 1, dp->nh_sz, UINT8_MAX - *ip_part);
 		} else {
 			write_to_dp(get_tbl_p_by_idx(dp->tbl8, tbl8_idx *
-- 
2.48.1.vfs.0.0

