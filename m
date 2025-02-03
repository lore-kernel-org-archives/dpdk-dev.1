Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED67C02190
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E2340A71;
	Mon,  3 Feb 2025 05:06:59 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8777C40693
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:48 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 45C2E2037185; Sun,  2 Feb 2025 20:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45C2E2037185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555607;
 bh=v1DHxZV1C0sGKMHWBH1Ir4BACtxlCv2pTOINU5xG0Hs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m9uMiTfbDg02MCKw5cYvMW8Ahk2bG7XBWhPVPB9jIKZ4ECy0879x5bXthIGO1GXqM
 EbooLWqs4zo+bxWy3QZHF/TmJURvetaLusfknoKXi3KdSCmm5AvbAh65gtDg5l2kJ6
 z/WC0WQ2vokQiPCsTH2s4DktZy+FEiUs601lbdxI=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com
Subject: [PATCH v19 06/27] hash/thash: remove use of VLAs for Windows built
Date: Sun,  2 Feb 2025 20:06:09 -0800
Message-Id: <1738555590-12753-7-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
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

1) ./lib/hash/rte_thash.c:774:9
    : warning: ISO C90 forbids variable length array ‘tmp_tuple’

The tuple can exceed sizeof(union rte_thash_tuple), for example if any
tunneling header is used in the RSS hash calculation.

The longest RSS hash key currently supported is 52 bytes. Technically, the
longest tuple with such a key should be (52 - sizeof(uint32_t)), so this
can be used as a size of the tmp_tuple array.

Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/hash/rte_thash.c | 2 +-
 lib/hash/rte_thash.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index 336c228e64..fa78787143 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -761,7 +761,7 @@ rte_thash_adjust_tuple(struct rte_thash_ctx *ctx,
 	uint32_t desired_value,	unsigned int attempts,
 	rte_thash_check_tuple_t fn, void *userdata)
 {
-	uint32_t tmp_tuple[tuple_len / sizeof(uint32_t)];
+	uint32_t tmp_tuple[RTE_THASH_TUPLE_LEN_MAX];
 	unsigned int i, j, ret = 0;
 	uint32_t hash, adj_bits;
 	const uint8_t *hash_key;
diff --git a/lib/hash/rte_thash.h b/lib/hash/rte_thash.h
index c0af5968df..04f9f1875c 100644
--- a/lib/hash/rte_thash.h
+++ b/lib/hash/rte_thash.h
@@ -121,6 +121,13 @@ __rte_internal
 uint32_t
 thash_get_rand_poly(uint32_t poly_degree);
 
+/**
+ * Longest RSS hash key currently supported
+ */
+#define RTE_THASH_KEY_LEN_MAX	52
+
+#define RTE_THASH_TUPLE_LEN_MAX (RTE_THASH_KEY_LEN_MAX - sizeof(uint32_t))
+
 /**
  * Prepare special converted key to use with rte_softrss_be()
  * @param orig
-- 
2.47.2.vfs.0.1

