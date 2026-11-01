Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD403606A325
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 08:04:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE7F54027A;
	Sun,  1 Nov 2026 09:04:30 +0100 (CET)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTPS id D008640279
 for <dev@dpdk.org>; Sun,  1 Nov 2026 09:04:28 +0100 (CET)
Received: from ar (unknown [113.239.72.160])
 by APP-03 (Coremail) with SMTP id rQCowACXp5iJ8uZqxp0dAA--.24995S2;
 Sun, 01 Nov 2026 16:04:26 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 2/2] acl: inline the match checks into the RVV search loops
Date: Sun,  1 Nov 2026 01:04:23 -0700
Message-ID: <1dcea3d3b0b7fab108f3096a9585383d36417099.1793520104.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
References: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXp5iJ8uZqxp0dAA--.24995S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF48KrWxWr4UCF48Kw15Jwb_yoW8GF1rpa
 n5Gr13Gr48tFyS9ayUtr4kAF45Ga1Fy3y2k3Z8KwnIvFs8Jrn8WFyrK34UCF1a9rWrAay2
 qa1akw4Uu3ZxAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU9189UUUUU=
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAISAmrmtxJ4tQAAs6
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The match checks are called inside the search loops, between the
transitions; -O3 inlines them and is unchanged, at -O2 they are not.
Flatten the search functions so the loops hold no call.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/acl/acl_run_rvv.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/acl/acl_run_rvv.h b/lib/acl/acl_run_rvv.h
index 1d6fdff045..c4daf10224 100644
--- a/lib/acl/acl_run_rvv.h
+++ b/lib/acl/acl_run_rvv.h
@@ -182,9 +182,11 @@ transition_vec(vuint32m1_t v_next_input, const uint64_t *trans,
 }
 
 /*
- * Execute trie traversal with 8 traversals in parallel
+ * Execute trie traversal with 8 traversals in parallel.
+ * Flattened: a vector value live across a call is spilled, and the
+ * frame is then addressed through vlenb.
  */
-static inline int
+static inline __rte_flatten int
 search_rvv_8(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t total_packets, uint32_t categories)
 {
@@ -270,7 +272,7 @@ search_rvv_8(const struct rte_acl_ctx *ctx, const uint8_t **data,
 /*
  * Execute trie traversal with 4 traversals in parallel
  */
-static inline int
+static inline __rte_flatten int
 search_rvv_4(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t total_packets, uint32_t categories)
 {
-- 
2.56.0

