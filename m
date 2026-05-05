Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C636FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 06:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89B4B40662;
	Tue,  5 May 2026 08:22:46 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 0777E40270
 for <dev@dpdk.org>; Tue,  5 May 2026 08:22:44 +0200 (CEST)
Received: from ar (unknown [119.114.153.107])
 by APP-05 (Coremail) with SMTP id zQCowAAHlQiyjPlpO+RwDw--.15330S2;
 Tue, 05 May 2026 14:22:42 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>
Subject: [PATCH v5 1/2] eal/riscv: set default SIMD bitwidth to 128
Date: Tue,  5 May 2026 14:21:40 +0800
Message-ID: <20260505062142.575105-2-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
References: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHlQiyjPlpO+RwDw--.15330S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWkXF1xAFyrWrWrWrWfZrb_yoWxZFg_Z3
 48ZFs7WF47GFsFvas8CFZ0kFW29F95Jw1DZr1rtr13u3WDKr15Gw10gr1xAF4a9r4DAw18
 Xr4Sqr9I9r1FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbwkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
 W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb3rc3UUUUU==
X-Originating-IP: [119.114.153.107]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAYSAmn5R0iFiQAAsJ
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
2.54.0

