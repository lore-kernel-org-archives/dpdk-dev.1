Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA29C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:58:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEA0A40E0A;
	Wed, 26 Aug 2026 10:58:27 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5725540E0A
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:58:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjyrqo5qiulMBg--.32910S2;
 Wed, 26 Aug 2026 16:58:19 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 48/51] net/sxe2: fix device init and representor matching
 issues
Date: Wed, 26 Aug 2026 16:58:19 +0800
Message-ID: <20260826085819.993150-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjyrqo5qiulMBg--.32910S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1UKryDtryUZFy5ZrWUArb_yoW8Kw1xpF
 s3WFyfAFW8JFsFvw43Ca1xWF1UKw4fK3yxKrWag3WxGayDJr15AFyUtr1ayrnYyrW7X3sY
 yw17Zws5Ca4vkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
 xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r
 4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnwmRUUUUUU==
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

- sxe2_dev_init(): move the init_rss_err label above
  sxe2_security_uinit() so an RSS init failure still unwinds the
  security context instead of leaking it.
- sxe2_buffer_split_supported_hdr_ptypes_get(): exclude the trailing
  RTE_PTYPE_UNKNOWN terminator from no_of_elements so applications do
  not receive a bogus ptype entry.
- sxe2_switchdev_repr_match(): match the PF when the adapter's pf_num
  is among the requested ports instead of requiring every requested
  port to equal pf_num, which could never succeed with multiple ports.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 88fe43298a..f4e65852d4 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -986,7 +986,7 @@ sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 
 		RTE_PTYPE_UNKNOWN
 	};
-	*no_of_elements = RTE_DIM(ptypes);
+	*no_of_elements = RTE_DIM(ptypes) - 1;
 
 	return ptypes;
 }
@@ -2028,8 +2028,8 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 init_fc_state_err:
 	(void)sxe2_flow_uninit(dev);
 init_flow_err:
-	sxe2_security_uinit(dev);
 init_rss_err:
+	sxe2_security_uinit(dev);
 init_security_err:
 	sxe2_intr_uninit(dev);
 init_irq_err:
@@ -2198,12 +2198,14 @@ static bool sxe2_switchdev_repr_match(struct sxe2_adapter *adapter,
 	}
 
 	for (port_idx = 0; port_idx < req_eth_da->nb_ports; ++port_idx) {
-		if (adapter->switchdev_info.pf_num != req_eth_da->ports[port_idx]) {
-			PMD_DEV_LOG_DEBUG(adapter, DRV, "switchdev pf %u not match req pf %u",
-				adapter->switchdev_info.pf_num, req_eth_da->ports[port_idx]);
-			rte_errno = EBUSY;
-			return false;
-		}
+		if (adapter->switchdev_info.pf_num == req_eth_da->ports[port_idx])
+			break;
+	}
+	if (port_idx == req_eth_da->nb_ports) {
+		PMD_DEV_LOG_DEBUG(adapter, DRV, "switchdev pf %u not match req pf",
+			adapter->switchdev_info.pf_num);
+		rte_errno = EBUSY;
+		return false;
 	}
 
 	for (repr_idx = 0; repr_idx < req_eth_da->nb_representor_ports; ++repr_idx) {
-- 
2.52.0

