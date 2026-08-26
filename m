Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E172CC61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:56:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DCDA40A82;
	Wed, 26 Aug 2026 10:56:11 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 95DF540A6E
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:56:03 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXXDofqo5qM+FMBg--.45334S2;
 Wed, 26 Aug 2026 16:56:00 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 24/51] net/sxe2: probe all requested PF ports
Date: Wed, 26 Aug 2026 16:55:59 +0800
Message-ID: <20260826085559.991336-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXXDofqo5qM+FMBg--.45334S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Ww1kXFWfCr45Xr17trb_yoW8WF4kpa
 1kXFyFvFW5JF1a9w1Fva1rZFn3Ka10yrWUGrWjk34fJa4UJr18ZF1DKFn0v3WFkr9rJF1F
 yFW3JFyDW3ySgr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr
 0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzBT5UUUUU=
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

sxe2_eth_pmd_probe() always probes a single PF port (index 0) even
when multiple ports are requested in the device arguments, so
additional PF ports are never created.

Loop over eth_da.nb_ports and probe each requested port, falling
back to a single probe when no ports are specified.

Fixes: d8e4e075ac ("net/sxe2: add probing skeleton")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 1dd10cd515..8e3afd6eed 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2325,6 +2325,7 @@ static int32_t sxe2_eth_pmd_probe(struct sxe2_common_device *cdev,
 {
 	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
 	int32_t ret = 0;
+	uint16_t port;
 
 	ret = sxe2_parse_eth_devargs(cdev->dev, &eth_da);
 	if (ret != 0) {
@@ -2332,7 +2333,18 @@ static int32_t sxe2_eth_pmd_probe(struct sxe2_common_device *cdev,
 		goto l_end;
 	}
 
-	ret = sxe2_eth_pmd_probe_pf(cdev, &eth_da, 0, kvargs);
+	if (eth_da.nb_ports > 0) {
+		for (port = 0; port < eth_da.nb_ports; port++) {
+			ret = sxe2_eth_pmd_probe_pf(cdev, &eth_da, port, kvargs);
+			if (ret != 0) {
+				PMD_LOG_ERR(INIT, "sxe2 eth pmd probe failed, ret=%d", ret);
+				(void)sxe2_eth_pmd_remove(cdev);
+				goto l_end;
+			}
+		}
+	} else {
+		ret = sxe2_eth_pmd_probe_pf(cdev, &eth_da, 0, kvargs);
+	}
 
 l_end:
 	return ret;
-- 
2.52.0

