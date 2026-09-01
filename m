Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF4C624A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 03:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7F6540BA0;
	Tue,  1 Sep 2026 05:07:58 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 2788A40616
 for <dev@dpdk.org>; Tue,  1 Sep 2026 05:07:56 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADH9kCLQZZqY_khBw--.58257S2;
 Tue, 01 Sep 2026 11:07:55 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v8 27/49] net/sxe2: enable FDIR on all Rx queues
Date: Tue,  1 Sep 2026 11:07:55 +0800
Message-ID: <20260901030755.3685063-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
References: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADH9kCLQZZqY_khBw--.58257S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWkGFyruF1xWr17XrWUArb_yoWDurg_W3
 y5XF9xJrW5Cr1YkF4UKrW3Xrykt3W8Z3WkZ39aqrWSvr1fAr4fAr1kXrZakwsFga17CrZr
 AF4DW3WrGw45GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbckFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
 WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
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

sxe2_flow_init() always sets fnav_inited, so enable FDIR on every Rx
queue during queue init by setting rxq->fnav_enable.  FDIR/FNAV
flags are required for flow rules and ACL statistics, so every Rx
queue must have them enabled.  This makes the fnav blocks in the
vectorized Rx paths live on all queues.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_queue.c b/drivers/net/sxe2/sxe2_queue.c
index afb2681b72..3aaa14c685 100644
--- a/drivers/net/sxe2/sxe2_queue.c
+++ b/drivers/net/sxe2/sxe2_queue.c
@@ -39,6 +39,8 @@ int32_t sxe2_queues_init(struct rte_eth_dev *dev)
 		rxq->rx_buf_len = RTE_MIN(rxq->rx_buf_len, SXE2_RX_MAX_DATA_BUF_SIZE);
 		if (frame_size > rxq->rx_buf_len)
 			dev->data->scattered_rx = 1;
+		if (adapter->flow_ctxt.fnav_inited)
+			rxq->fnav_enable = true;
 	}
 
 	adapter->ptp_ctxt.mbuf_rx_ts_offset = -1;
-- 
2.52.0

