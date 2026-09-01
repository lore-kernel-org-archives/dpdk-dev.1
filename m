Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0901DC61DFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D702240B8D;
	Tue,  1 Sep 2026 05:07:17 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id DB1C14068A;
 Tue,  1 Sep 2026 05:07:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADXB0JhQZZqkfchBw--.58618S2;
 Tue, 01 Sep 2026 11:07:14 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v8 20/49] net/sxe2: fix null dereference in dev uninit
Date: Tue,  1 Sep 2026 11:07:13 +0800
Message-ID: <20260901030713.3684657-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
References: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADXB0JhQZZqkfchBw--.58618S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1UAw4xCw48XFW5ZF45trb_yoW8GryUpF
 4xWa15tFyagF15Wa1fXa1xXF109F48t34UCrWYy343uF93Xrn7Ary3GFyrtr48GrZ7ZF1F
 vFy7Zr1kKrnYgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUUUU=
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

Fixes: 635084db5d57 ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index fdff4ae10f..41ea67a607 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -2074,9 +2074,11 @@ static int32_t sxe2_dev_uninit(struct rte_eth_dev *dev)
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

