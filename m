Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83DEC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 02:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83F5C40616;
	Mon, 17 Aug 2026 04:53:55 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9A32C402C4
 for <dev@dpdk.org>; Mon, 17 Aug 2026 04:53:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADHn_O5d4JqAwjkBQ--.21980S9;
 Mon, 17 Aug 2026 10:53:48 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 07/13] net/sxe2: validate IPsec key length against maximum
 limit
Date: Mon, 17 Aug 2026 10:53:33 +0800
Message-ID: <20260817025339.2792682-8-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
References: <20260817025339.2792682-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHn_O5d4JqAwjkBQ--.21980S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18JrW3Gw17uFy5Wr4kWFg_yoW8Gr18pr
 48WF1ruF15G3W5Xw4rXa1SgFyYg347WrykC39Iy3WfJFyDA34UCrs8KFyFkw1UArsxXF1S
 yw47ArW3Gwsxtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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

Add validation check in sxe2_security_valid_key to ensure source key
length does not exceed SXE2_IPSEC_MAX_KEY_LEN. This prevents potential
buffer overflows when processing security keys that are longer than
the supported maximum length.

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

