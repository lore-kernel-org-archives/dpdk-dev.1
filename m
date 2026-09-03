Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E65C61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:58:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2377142D72;
	Thu,  3 Sep 2026 03:58:08 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 70E66427BC;
 Thu,  3 Sep 2026 03:58:05 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAHKkMr1Jhq5R1ABw--.39612S2;
 Thu, 03 Sep 2026 09:58:03 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 43/48] net/sxe2: align command structs with kernel layout
Date: Thu,  3 Sep 2026 09:58:03 +0800
Message-ID: <20260903015803.162406-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHKkMr1Jhq5R1ABw--.39612S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4DZF1xtFW5Ww1kKry8Xwb_yoW5tw4UpF
 Z5G34aqF45tr1jgF48Xr4xZrySg3yUA3yUXay7X34Sy3WftasrXryUKr1rCa4rK3yUuw4S
 yrsxKr4UJa4fCFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRiTmhD
 UUUUU==
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

- sxe2_drv_link_info_resp: drop rsv[3] padding (size unchanged)
- sxe2_tm_res: drop rsv[2] padding and packed attribute, reducing
  the TM command payload length from 4 to 2 bytes to match the
  historical kernel layout
- sxe2_tm_info: drop packed attribute, removing -Wpacked-not-aligned
  warnings
- sxe2_tm_add_mid_msg/sxe2_tm_add_queue_msg: drop packed attribute;
  the message sizes (16 and 20 bytes) are unchanged, but the tm info
  member moves to its naturally aligned offset (4 and 8)
- sxe2_drv_sfp_req/sxe2_drv_sfp_resp: drop packed attribute

Fixes: 9c894f75113f ("net/sxe2: support TM hierarchy and shaping")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_drv_cmd.h | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index 01fd813ed1..ee9d86dd4c 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -230,7 +230,6 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_vsi_info_get_resp {
 struct __rte_aligned(4) __rte_packed_begin sxe2_drv_link_info_resp {
 	uint32_t speed;
 	uint8_t status;
-	uint8_t rsv[3];
 } __rte_packed_end;
 
 struct __rte_aligned(4) __rte_packed_begin sxe2_switchdev_info {
@@ -348,31 +347,30 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_rss_hf_req {
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
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_tm_add_mid_msg {
+struct sxe2_tm_add_mid_msg {
 	uint16_t parent_teid;
 	uint8_t adj_lvl;
 	struct sxe2_tm_info info;
-} __rte_packed_end;
+};
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_tm_add_queue_msg {
+struct sxe2_tm_add_queue_msg {
 	uint16_t parent_teid;
 	uint16_t queue_id;
 	uint8_t adj_lvl;
 	struct sxe2_tm_info info;
-} __rte_packed_end;
+};
 
 struct __rte_aligned(4) __rte_packed_begin sxe2_drv_ipsec_capa_resq {
 	uint16_t tx_sa_cnt;
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

