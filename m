Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFE1C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 20:22:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66F53427C1;
	Thu, 13 Aug 2026 22:22:40 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 by mails.dpdk.org (Postfix) with ESMTP id 4E3EB4026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 22:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=lkmS6CKqrhvef6kyutwXSaTvLjqtLkyv4a+m4m3+XPk=; b=RdrXX5+aYsOX
 MXsmb1DdXSj8wJg+qIBV1X4UsiIbwwX6ux/TC1VH4bKroxr4s3NuNMv9DwGOeXo4aBokY7knyLMVx
 ++vHOa1ZUIxN08liOF/Bd7xRyeeMZL74mweUNiWk1xvlXTp+CvTOkOiOT6FnhdS9PEq4HKTO/hhIJ
 rHwCdAcI1OvaZkxkIDNmShYpYKNSwDAJ8YK3FTgXt4S10L7gmSYw+S2OsQy7UFK/ogP0SC47yVcYO
 WVdyX41gxdg9ICR3qHQ+hYTqZ74gvgiTo5IIqkoC0eY5NWbOgWJUFUNYOp9qtZoC3nnbOpDJz+CNu
 ozexb0/IeSnSE8MIpDUxsg==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <eva.kurchatova@virtuozzo.com>) id 1wubup-001dUy-2O
 for dev@dpdk.org; Thu, 13 Aug 2026 22:22:36 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: dev@dpdk.org
Subject: [PATCH] net: fix cksum calculation for odd-sized segment
Date: Thu, 13 Aug 2026 23:22:35 +0300
Message-ID: <20260813202236.246588-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
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

The rte_raw_cksum_mbuf() performs rte_bswap16() on return value from
__rte_raw_cksum() for odd-sized segments. However, __rte_raw_cksum()
returns a 32-bit accumulator whose upper 16 bits may still contain
carries that must be folded. Truncating those upper bits by passing to
rte_bswap16() will produce an invalid checksum if they are non-zero.

This is surely a rare encounter in practice, as most NICs have hardware
checksum offloads, and even then encountering an odd-sized SG segment
is not common, but currently such a case would miscompute the checksum.

I found this issue by accident when comparing RVVM networking stack
packet checksuming to DPDK, and noticed that this looked incorrect.

Fix this by folding the odd-sized segment checksum before bswap16.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 lib/net/rte_cksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..391f998ee5 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -157,7 +157,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m, uint32_t off, uint32_t len,
 	for (;;) {
 		tmp = __rte_raw_cksum(buf, seglen, 0);
 		if (done & 1)
-			tmp = rte_bswap16((uint16_t)tmp);
+			tmp = rte_bswap16(__rte_raw_cksum_reduce(tmp));
 		sum += tmp;
 		done += seglen;
 		if (done == len)
-- 
2.55.0

