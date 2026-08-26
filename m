Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A45AC61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C172640E24;
	Wed, 26 Aug 2026 10:58:36 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 410BB40DF6
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:58:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAB3fjy2qo5qHupMBg--.39431S2;
 Wed, 26 Aug 2026 16:58:31 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 50/51] net/sxe2: restore NULL check in vectorized Tx mbuf
 release
Date: Wed, 26 Aug 2026 16:58:30 +0800
Message-ID: <20260826085830.993430-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3fjy2qo5qHupMBg--.39431S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15Aw1UZF48Zr4ktFWDArb_yoW8Gw47pr
 s3Kr4UArn7XF4fGw4rtan8ZFn8GF90qrW5KFWIkwnayrn5JF1vqr4UtF48tr1kArZ3Zw1S
 vr4DGF48Ga1DArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkGb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
 xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26F
 4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr
 0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1l
 IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxWrXUUU
 UU=
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

sxe2_tx_queue_mbufs_release_vec() calls rte_pktmbuf_free_seg() on each
buffer entry without checking for NULL. rte_pktmbuf_free_seg() does not
tolerate NULL and dereferences its argument, so a stop/start cycle or
any unwritten slot in the release range can crash.

Restore the NULL check before freeing each mbuf.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_txrx_vec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_txrx_vec.c b/drivers/net/sxe2/sxe2_txrx_vec.c
index 05940c8cb5..7c5da33dd5 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec.c
@@ -183,15 +183,19 @@ static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq)
 
 	if (txq->next_use < i) {
 		for ( ; i < txq->ring_depth; ++i) {
-			rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
-			buffer_vec[i].mbuf = NULL;
+			if (buffer_vec[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
+				buffer_vec[i].mbuf = NULL;
+			}
 		}
 		i = 0;
 	}
 
 	for ( ; i < txq->next_use; ++i) {
-		rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
-		buffer_vec[i].mbuf = NULL;
+		if (buffer_vec[i].mbuf != NULL) {
+			rte_pktmbuf_free_seg(buffer_vec[i].mbuf);
+			buffer_vec[i].mbuf = NULL;
+		}
 	}
 }
 
-- 
2.52.0

