Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E90CA5FE2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98E5B40687;
	Mon,  5 Oct 2026 09:04:50 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 3BCF440290;
 Mon,  5 Oct 2026 09:04:48 +0200 (CEST)
Received: from ar (unknown [42.58.232.122])
 by APP-03 (Coremail) with SMTP id rQCowABHUT8OTMNq_7GoCQ--.11538S2;
 Mon, 05 Oct 2026 15:04:46 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>,
	stable@dpdk.org
Subject: [PATCH 1/2] fib: fix lookup in network order with RVV
Date: Mon,  5 Oct 2026 00:04:45 -0700
Message-ID: <9bd3137765e441c3e4d8ed8e7dddb6fb2cd8a1c3.1791183388.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791183388.git.sunyuechi@iscas.ac.cn>
References: <cover.1791183388.git.sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUT8OTMNq_7GoCQ--.11538S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr15Ar45Kr1xWryUZFyUAwb_yoWDGwbEga
 yxuF9rtr1UtF1S9w4UXF90qFyfur98Ca1xCrZFyr9agrWxJFZxu3W8trykZF93WFW5C34j
 qaya93sxCrnagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbwAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
 W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUUUU=
X-Originating-IP: [42.58.232.122]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBgMLAmrDIz1PJgAAsS
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

A FIB created with RTE_FIB_F_LOOKUP_NETWORK_ORDER was given the vector
lookup, which reads the addresses in host order. Leave such a FIB to
the scalar functions.

Fixes: f2ccf5fc334b ("fib: lookup with RISC-V vector extension")
Cc: stable@dpdk.org
Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/fib/dir24_8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 489d2ef427..c135285a65 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -94,8 +94,8 @@ get_vector_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
 		return NULL;
 	}
 #elif defined(RTE_RISCV_FEATURE_V)
-	RTE_SET_USED(be_addr);
-	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V) <= 0)
+	/* the vector functions take addresses in host order only */
+	if (be_addr || rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V) <= 0)
 		return NULL;
 	switch (nh_sz) {
 	case RTE_FIB_DIR24_8_1B:
-- 
2.56.0

