Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D92C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 715B74067D;
	Wed, 26 Aug 2026 10:54:42 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id C7DB6402EA
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:54:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAAXGznNqY5q69xMBg--.37467S2;
 Wed, 26 Aug 2026 16:54:37 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 10/51] net/sxe2: validate IPsec key length against maximum
 limit
Date: Wed, 26 Aug 2026 16:54:37 +0800
Message-ID: <20260826085437.990548-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXGznNqY5q69xMBg--.37467S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18JrWxGw1rtryfJF4kXrb_yoW8Gw17pr
 4IgF1rZF15GF15Xw4rXa1SgFySga43Wr97C39Iy3WfXFyDA34jkrs8tFyFkw1DArsxWF1S
 yw47A3y5GwsIyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
 z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8iSdDUUUUU==
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add validation in sxe2_security_valid_key to ensure the source key
length does not exceed SXE2_IPSEC_MAX_KEY_LEN, preventing potential
buffer overflows when processing keys longer than the supported
maximum. Also clear the security context pointer after releasing the
security session during uninit.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ipsec.c    | 5 +++++
 drivers/net/sxe2/sxe2_security.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_ipsec.c b/drivers/net/sxe2/sxe2_ipsec.c
index e783a51b85..622fd1adfe 100644
--- a/drivers/net/sxe2/sxe2_ipsec.c
+++ b/drivers/net/sxe2/sxe2_ipsec.c
@@ -254,6 +254,11 @@ static bool sxe2_security_valid_key(uint16_t src_key, uint16_t max_key,
 		goto l_end;
 	}
 
+	if (src_key > SXE2_IPSEC_MAX_KEY_LEN) {
+		is_valid = false;
+		goto l_end;
+	}
+
 	is_valid = true;
 
 l_end:
diff --git a/drivers/net/sxe2/sxe2_security.c b/drivers/net/sxe2/sxe2_security.c
index bc59d1b880..8f31067942 100644
--- a/drivers/net/sxe2/sxe2_security.c
+++ b/drivers/net/sxe2/sxe2_security.c
@@ -326,6 +326,7 @@ void sxe2_security_uinit(struct rte_eth_dev *dev)
 	if (sctx != NULL) {
 		rte_free(sctx);
 		sctx = NULL;
+		dev->security_ctx = NULL;
 	}
 
 	sxe2_ipsec_uinit(adapter);
-- 
2.52.0

