Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77545C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:35:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6533E4042E;
	Mon, 31 Aug 2026 04:35:10 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 42BD1402E9
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:35:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABnckBX6JRq27+jBg--.24645S9;
 Mon, 31 Aug 2026 10:35:06 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>,
	stephen@networkplumber.org
Subject: [PATCH v7 07/47] net/sxe2: initialize stats in representor device init
Date: Mon, 31 Aug 2026 10:34:20 +0800
Message-ID: <20260831023500.3229289-8-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
 <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnckBX6JRq27+jBg--.24645S9
X-Coremail-Antispam: 1UD129KBjvdXoWrtFW5XFWxWr4kJFWxKw1xKrg_yoWDuFb_Cr
 1Yvr9xArW8C3W5tryI9r4rZryvkrWkXrn7GF9IqFW5Zwsaq34xAw40qF9Fgws7Wr13ArZr
 ua13Xw18Kw13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbT8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
 IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
 F7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
 A2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1l
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
 8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I
 8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
 xVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
 AFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
 cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
 4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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

Add sxe2_stats_init() call in sxe2_repr_dev_init to set up the
statistics infrastructure for representor devices, and add the
l_init_irq_ctxt_err error path to uninitialize the software irq
context if stats initialization fails.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev_repr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index f32318b731..c698baafe0 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -483,8 +483,16 @@ int32_t sxe2_repr_dev_init(struct rte_eth_dev *dev,
 		goto l_init_sw_err;
 	}
 
+	ret = sxe2_stats_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize stats, ret=[%d]", ret);
+		goto l_init_irq_ctxt_err;
+	}
+
 	goto l_end;
 
+l_init_irq_ctxt_err:
+	sxe2_sw_irq_ctxt_uninit(dev);
 l_init_sw_err:
 	sxe2_eth_uinit(dev);
 l_init_eth_err:
-- 
2.52.0

