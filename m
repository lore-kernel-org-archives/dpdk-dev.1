Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A3CC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:22:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD4F4402D1;
	Fri, 14 Aug 2026 14:22:18 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id EF9D540285
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S9;
 Fri, 14 Aug 2026 20:22:13 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 07/13] net/sxe2: validate IPsec key length against maximum
 limit
Date: Fri, 14 Aug 2026 20:21:58 +0800
Message-ID: <20260814122204.2666045-8-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18JrW3Gw17uFy5Wr4kWFg_yoW8Gr18pr
 48WF1ruF15G3W5Xw4rXa1SgFyYg347WrykC39Iy3WfJFyDA34UCrs8KFyFkw1UArsxXF1S
 yw47ArW3Gwsxtr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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

