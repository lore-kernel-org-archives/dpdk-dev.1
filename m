Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0B01061B2B
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:11:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79BE340685;
	Tue, 31 Mar 2026 05:11:45 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6E3B6402D4
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:11:42 +0200 (CEST)
Received: from ar (unknown [42.177.178.249])
 by APP-03 (Coremail) with SMTP id rQCowACHqeBsO8tpdKliDA--.54905S2;
 Tue, 31 Mar 2026 11:11:40 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>
Subject: [PATCH v4 1/2] eal/riscv: set default SIMD bitwidth to 128
Date: Tue, 31 Mar 2026 11:10:58 +0800
Message-ID: <20260331031059.2621971-2-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
 <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHqeBsO8tpdKliDA--.54905S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWkXF1xAFyrWrWrWrWfZrb_yoWxZFg_Z3
 4xuFs7WF47GFsFvas8CFZ0kFW29F95Jw1DZr1rtr13u3WDKr15Gw10gr1xAF4a9r4DAw18
 Xr4Sqr9I9r1FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbwAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU9189UUUUU=
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRADAmnLGCqM8wAAs3
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

Enable vector code paths on RISC-V platforms with V extension.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/eal/riscv/include/rte_vect.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/riscv/include/rte_vect.h b/lib/eal/riscv/include/rte_vect.h
index a4357e266a..4d16082449 100644
--- a/lib/eal/riscv/include/rte_vect.h
+++ b/lib/eal/riscv/include/rte_vect.h
@@ -19,7 +19,7 @@
 extern "C" {
 #endif
 
-#define RTE_VECT_DEFAULT_SIMD_BITWIDTH RTE_VECT_SIMD_DISABLED
+#define RTE_VECT_DEFAULT_SIMD_BITWIDTH RTE_VECT_SIMD_128
 
 typedef int32_t		xmm_t __attribute__((vector_size(16)));
 
-- 
2.53.0

