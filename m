Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E3606A324
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 08:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8956140E15;
	Sun,  1 Nov 2026 09:04:32 +0100 (CET)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTPS id 157D040292
 for <dev@dpdk.org>; Sun,  1 Nov 2026 09:04:28 +0100 (CET)
Received: from ar (unknown [113.239.72.160])
 by APP-03 (Coremail) with SMTP id rQCowABHGZqJ8uZqvp0dAA--.24877S2;
 Sun, 01 Nov 2026 16:04:25 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 1/2] eal: add flatten function attribute
Date: Sun,  1 Nov 2026 01:04:22 -0700
Message-ID: <6951ce898ada42d43d1462c0543efcc47121a803.1793520104.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
References: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHGZqJ8uZqvp0dAA--.24877S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWruF1UGFWxCw4DWr1UGFg_yoW8Xw13pF
 ZrCryjgw1DJayIk34xAr1IqFWY9rs5Ga45AryUGr90vF98twn7Wr4DK34j9F1fZrW8KFnY
 qrZ8W3y3WryUZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUUUU=
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAMSAmrmtxI6UQACsf
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

Add __rte_flatten, which inlines every call a function makes into it,
where the callee's body is available.

__rte_always_inline marks the callee and inlines it at every call site.
Here the requirement is local to one caller, and the callees are shared
with paths that do not want inlining. Flatten applies at the boundary
that needs it.

A spill slot has a fixed offset on a fixed-width vector ISA. With RVV
its size depends on VLEN and is known only at run time, and once the
frame holds such a slot the rest of it is addressed through vlenb.
Inlining such calls is then worth the code growth.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/eal/include/rte_common.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index fed373f412..e32b6b13d6 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -547,6 +547,19 @@ static void __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
 #define __rte_noinline __attribute__((noinline))
 #endif
 
+/**
+ * Inline every call made by a function into it, where the callee's body
+ * is available, whatever the callee's own inline annotation.
+ *
+ * Useful where a call inside a hot loop is costly in itself,
+ * for example where values are held in registers that no call preserves.
+ */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __rte_flatten
+#else
+#define __rte_flatten __attribute__((flatten))
+#endif
+
 /**
  * Hint function in the hot path
  *
-- 
2.56.0

