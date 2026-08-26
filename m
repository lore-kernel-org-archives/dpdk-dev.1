Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464FFC5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93E2B406FF;
	Wed, 26 Aug 2026 10:55:40 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4D67A406FF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:55:38 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXnDoIqo5q999MBg--.28656S2;
 Wed, 26 Aug 2026 16:55:36 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 20/51] net/sxe2: fix null dereference in dev uninit
Date: Wed, 26 Aug 2026 16:55:35 +0800
Message-ID: <20260826085535.991110-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXnDoIqo5q999MBg--.28656S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1UAw4xCw48XFW5ZF45trb_yoW8Gr4DpF
 4xWa15tFyagF15Wa1rXa1xXF109F48t34UCrWYy34fCF93Xr97Ary3KFy5tr48GrZ7ZF1F
 vFy3Xr1kKrnIgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

sxe2_dev_uninit() calls rep_dev->dev_ops->dev_close() for each VF
representor without checking that dev_ops or dev_close is present,
which can crash when the representor device is not fully initialized.

Guard the call with NULL checks.

Fixes: 635084db5d ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 7e3eb6432c..575ad299f1 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2078,9 +2078,11 @@ static int32_t sxe2_dev_uninit(struct rte_eth_dev *dev)
 	for (i = 0; i < adapter->repr_ctxt.nb_repr_vf; i++) {
 		rep_dev = adapter->repr_ctxt.vf_rep_eth_dev[i];
 		if (rep_dev) {
-			ret = rep_dev->dev_ops->dev_close(rep_dev);
-			if (ret)
-				goto l_end;
+			if (rep_dev->dev_ops && rep_dev->dev_ops->dev_close) {
+				ret = rep_dev->dev_ops->dev_close(rep_dev);
+				if (ret)
+					goto l_end;
+			}
 			if (rep_dev->intr_handle)
 				rte_intr_instance_free(rep_dev->intr_handle);
 			ret = rte_eth_dev_release_port(rep_dev);
-- 
2.52.0

