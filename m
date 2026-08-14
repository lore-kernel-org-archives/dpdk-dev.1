Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572EBC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:23:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B7E540A72;
	Fri, 14 Aug 2026 14:22:27 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 75BF64025F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S14;
 Fri, 14 Aug 2026 20:22:14 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 12/13] net/sxe2: clean up structure definitions
Date: Fri, 14 Aug 2026 20:22:03 +0800
Message-ID: <20260814122204.2666045-13-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S14
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4xZw17Jw1xur18Xw13Arb_yoWrGF4kpF
 Z5W34YqF45tr42gF48Xr4xZryIgw4UC3yUAay3Xw4SyF1ftasrXFyUKr1rCa4rGrWUuw4S
 yrs3tF18Wa4rCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
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

This commit removes packed attributes and unused reserved fields
from structure definitions in the sxe2 driver header file.

- Remove packed attributes and rsv[2] field from sxe2_tm_res
  structure
- Remove packed attributes from sxe2_tm_info structure
- Remove packed attributes from sxe2_txq_map_info structure
- Remove packed attributes from sxe2_rxq_map_info structure
- Remove packed attributes from sxe2_queue_map_info structure
- Remove packed attributes from sxe2_drv_sfp_req structure
- Remove packed attributes from sxe2_drv_sfp_resp structure
- Remove unused rsv[3] field from sxe2_drv_link_info_resp
  structure

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_drv_cmd.h | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index aa56d9436a..34160b93cb 100644
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
@@ -526,24 +524,24 @@ struct __rte_aligned(4) __rte_packed_begin sxe2_drv_mac_stats_resp {
 	uint64_t prio_xon_2_xoff[SXE2_MAX_USER_PRIORITY];
 } __rte_packed_end;
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_txq_map_info {
+struct sxe2_txq_map_info {
 	uint32_t txq_lan_pkt_cnt;
 	uint32_t txq_lan_byte_cnt;
-} __rte_packed_end;
+};
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_rxq_map_info {
+struct sxe2_rxq_map_info {
 	uint64_t rxq_lan_in_pkt_cnt;
 	uint64_t rxq_lan_in_byte_cnt;
 	uint64_t rxq_fd_in_pkt_cnt;
 	uint64_t rxq_mng_in_pkt_cnt;
 	uint64_t rxq_mng_in_byte_cnt;
 	uint64_t rxq_mng_out_pkt_cnt;
-} __rte_packed_end;
+};
 
-struct __rte_aligned(4) __rte_packed_begin sxe2_queue_map_info {
+struct sxe2_queue_map_info {
 	struct sxe2_rxq_map_info rxq_stats_map_info[SXE2_RXQ_STATS_MAP_MAX_NUM];
 	struct sxe2_txq_map_info txq_stats_map_info[SXE2_TXQ_STATS_MAP_MAX_NUM];
-} __rte_packed_end;
+};
 
 struct __rte_aligned(4) __rte_packed_begin sxe2_drv_rx_map_req {
 	uint16_t queue_id;
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

