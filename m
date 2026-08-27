Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D87C61DBE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 02:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A350A40E39;
	Thu, 27 Aug 2026 04:40:34 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4319340DF6
 for <dev@dpdk.org>; Thu, 27 Aug 2026 04:40:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAAH3fCXo49qkJajBg--.51988S2;
 Thu, 27 Aug 2026 10:40:24 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v4 42/44] net/sxe2: align command structs with historical
 kernel layout
Date: Thu, 27 Aug 2026 10:40:23 +0800
Message-ID: <20260827024023.1432146-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
References: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAH3fCXo49qkJajBg--.51988S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4DXFy7Ww4rGr45Kw1DGFg_yoW5Ar4xpF
 ZxG34YqF45tr1jgF48Xr4fZFyFgrWDA3yUXay7Xw1Syas3tasrXryUKr1rCa4rK3yUuw1S
 yrs3Kr1UGayfCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jyQ6JUUUUU=
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

The sxe2_drv_cmd.h command structures must match the layout used by
historical SXE2 kernel versions so the same firmware command ABI is
shared. Several structures were declared with __rte_packed_begin/
__rte_packed_end and extra rsv padding that the kernel layout does
not have:

- sxe2_drv_link_info_resp: drop rsv[3] padding
- sxe2_tm_res: drop rsv[2] padding and packed attribute
- sxe2_tm_info: drop packed attribute
- sxe2_tm_add_mid_msg: drop packed attribute
- sxe2_tm_add_queue_msg: drop packed attribute
- sxe2_drv_sfp_req: drop packed attribute
- sxe2_drv_sfp_resp: drop packed attribute

Keep the structure members as-is so the command ABI is compatible
with the historical kernel driver.

Fixes: 9c894f75113f ("net/sxe2: support TM hierarchy and shaping")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_drv_cmd.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index cc71e2364e..5274b59a6a 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -230,7 +230,6 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_info_get_resp {
 struct __rte_aligned(4) __rte_packed_begin sxe2_drv_link_info_resp {
 	uint32_t speed;
 	uint8_t status;
-	uint8_t rsv[3];
 } __rte_packed_end;
 
 struct __rte_aligned(4) __rte_packed_begin sxe2_switchdev_info {
@@ -348,18 +347,17 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_rss_hf_req {
 	uint8_t rsv1[3];
 } __rte_packed_end;
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_tm_res {
+struct sxe2_tm_res {
 	uint16_t teid;
-	uint8_t rsv[2];
-} __rte_packed_end;
+};
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_tm_info {
+struct sxe2_tm_info {
 	uint32_t committed;
 	uint32_t peak;
 	uint8_t priority;
 	uint8_t reserve;
 	uint16_t weight;
-} __rte_packed_end;
+};
 
 struct __rte_aligned(4) __rte_packed_begin sxe2_tm_add_mid_msg {
 	uint16_t parent_teid;
@@ -633,7 +631,7 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_udp_tunnel_resp {
 	uint8_t rsv;
 } __rte_packed_end;
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_drv_sfp_req {
+struct sxe2_drv_sfp_req {
 	uint8_t is_wr;
 	uint8_t is_qsfp;
 	uint16_t bus_addr;
@@ -642,14 +640,14 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_sfp_req {
 	uint16_t data_len;
 	uint16_t rvd;
 	uint8_t data[];
-} __rte_packed_end;
+};
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_drv_sfp_resp {
+struct sxe2_drv_sfp_resp {
 	uint8_t is_wr;
 	uint8_t is_qsfp;
 	uint16_t data_len;
 	uint8_t data[];
-} __rte_packed_end;
+};
 
 enum sxe2_fc_type {
 	SXE2_FC_T_DIS = 0,
-- 
2.52.0

