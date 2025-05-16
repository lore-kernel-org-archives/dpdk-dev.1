Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B5C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 476B540615;
	Fri, 16 May 2025 22:45:44 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9820240395
 for <dev@dpdk.org>; Fri, 16 May 2025 22:45:42 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9D68A201DB23; Fri, 16 May 2025 13:45:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D68A201DB23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747428341;
 bh=y96JEcAhhCtnOL/gOnaVMFBEyJVXix2t628Yk96hXRw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W/gc8iDv3fq/Z2dW1RE7L3uf59n+eqOjKdWPwyzfdZvSbU+O8etngGZzqLhxwE88s
 1bTJOiiUXZg5pPu1cQ0/f6DzfbbpmQYLyt7rouICA1cuc4GkSp/aV68kPi+9sY9ieX
 tvsl87lhn+eJFXL2U3cNwUkZ811a1TElEFUpX2Kc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	vladimir.medvedkin@intel.com
Subject: [PATCH v5 1/2] lib/fib: remove warning about implicit 64-bit
 conversion
Date: Fri, 16 May 2025 13:45:34 -0700
Message-Id: <1747428335-3736-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
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
index 6c20057ac5..24a08b827d 100644
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
2.49.0.vfs.0.3

