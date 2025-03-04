Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5914BC282D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 21:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27E33402E5;
	Tue,  4 Mar 2025 22:53:45 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BB82E402E5
 for <dev@dpdk.org>; Tue,  4 Mar 2025 22:53:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CB36D210EAF5; Tue,  4 Mar 2025 13:53:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB36D210EAF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741125222;
 bh=uyUWWvdFSDhkGIeR6XjMHrVtnQQd4K31p8HSw1yhz9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Si+qOraHHId0T09aQq3sNWF2qInGvQc0TLXZpWpDHNQeIm9jVVaWCtXt2+Z/D300U
 HyRQbGrt4XQ4KmFy6XmiHPClsLTs0lkshlnT3lZJ+6OD06I1AWkZIfGZhAWDfa6cqM
 hzoyjkMbtOl3U5yiefhv1dGmxIcrhitDQznV+Oas=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: bruce.richardson@intel.com, dev@dpdk.org, sameh.gobriel@intel.com,
 vladimir.medvedkin@intel.com, yipeng1.wang@intel.com
Subject: [PATCH v2 1/2] lib/hash: initialize __m128i data type in a portable
 way
Date: Tue,  4 Mar 2025 13:53:18 -0800
Message-Id: <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
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

The mechanism used to initialize an __m128i data type in rte_thash.h is
non-portable and MSVC does not like it. It clearly is not doing what
is desired:

..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
    truncation from 'unsigned __int64' to 'char'
..\lib\hash\rte_thash.h(38): warning C4305: 'initializing':
    truncation from 'unsigned __int64' to 'char'

A more portable approach is to use compiler intrinsics to perform the
initialization. This patch uses a single compiler intrinsic to
initialize the data.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/hash/rte_thash.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/hash/rte_thash.h b/lib/hash/rte_thash.h
index 04f9f1875c..8bca430663 100644
--- a/lib/hash/rte_thash.h
+++ b/lib/hash/rte_thash.h
@@ -30,14 +30,6 @@
 extern "C" {
 #endif
 
-#ifdef RTE_ARCH_X86
-/* Byte swap mask used for converting IPv6 address
- * 4-byte chunks to CPU byte order
- */
-static const __m128i rte_thash_ipv6_bswap_mask = {
-		0x0405060700010203ULL, 0x0C0D0E0F08090A0BULL};
-#endif
-
 /**
  * length in dwords of input tuple to
  * calculate hash of ipv4 header only
@@ -159,6 +151,11 @@ rte_thash_load_v6_addrs(const struct rte_ipv6_hdr *orig,
 			union rte_thash_tuple *targ)
 {
 #ifdef RTE_ARCH_X86
+	/* Byte swap mask used for converting IPv6 address
+	 * 4-byte chunks to CPU byte order
+	 */
+	const __m128i rte_thash_ipv6_bswap_mask = _mm_set_epi64x(
+		0x0C0D0E0F08090A0BULL, 0x0405060700010203ULL);
 	__m128i ipv6 = _mm_loadu_si128((const __m128i *)&orig->src_addr);
 	*(__m128i *)&targ->v6.src_addr =
 			_mm_shuffle_epi8(ipv6, rte_thash_ipv6_bswap_mask);
-- 
2.48.1.vfs.0.0

