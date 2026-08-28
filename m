Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B14C61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A55FC4068E;
	Fri, 28 Aug 2026 09:37:22 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1286140150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:37:19 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAD3+zmuOpFqtMhzBg--.9552S2;
 Fri, 28 Aug 2026 15:37:18 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 07/45] net/sxe2: initialize stats in representor device init
Date: Fri, 28 Aug 2026 15:37:17 +0800
Message-ID: <20260828073717.2247912-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3+zmuOpFqtMhzBg--.9552S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWfAr1rAw45ZFyUAr4rAFb_yoWkGFX_Cr
 1Yvr9xArW0k3W5tryI9r4rZryvkrWkXrn7CFZIqFWUZwsaq34xAw1FqF9Fgws7Wr13ArZr
 uF43Zw18Kw13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbc8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r
 4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU7ZXoDUUUU
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

