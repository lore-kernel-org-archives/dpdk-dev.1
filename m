Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB28CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:32:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80BCD40674;
	Tue, 11 Nov 2025 12:32:04 +0100 (CET)
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
 by mails.dpdk.org (Postfix) with ESMTP id 0CE6F4065E
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:32:01 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.fJvT87k_1762860717 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 11 Nov 2025 19:31:58 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Alvin Wang <alvin.wang@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v2 1/4] net/nbl: change default Rx extension header size to 12
 bytes
Date: Tue, 11 Nov 2025 03:31:40 -0800
Message-Id: <20251111113144.3567291-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The default Rx extension header size is reduced from 16 bytes to 12 bytes.
This reduction saves PCIe bandwidth by decreasing packet overhead.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c     | 2 +-
 drivers/net/nbl/nbl_hw/nbl_resource.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 0381bb74ec..9d79215309 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -87,7 +87,7 @@ static int nbl_dev_txrx_start(struct rte_eth_dev *eth_dev)
 		param.local_queue_id = i + ring_mgt->queue_offset;
 		param.intr_en = 0;
 		param.intr_mask = 0;
-		param.half_offload_en = 1;
+		param.half_offload_en = 0;
 		param.extend_header = 1;
 		param.split = 0;
 		param.rxcsum = 1;
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index e5d184a2a0..aba0f8e0c1 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -107,8 +107,6 @@ union nbl_rx_extend_head {
 		u32 l4s_dec_ind :1;
 		u32 rsv2 :4;
 		u32 num_buffers :8;
-		/* DW3 */
-		u32 hash_value;
 	} leonis;
 	struct nbl_rx_ehdr_common {
 		u32 dw0;
-- 
2.34.1

