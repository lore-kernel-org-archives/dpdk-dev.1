Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7697AC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5D5C40B9A;
	Mon, 14 Sep 2026 13:49:30 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 9037540144;
 Mon, 14 Sep 2026 12:04:45 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789380285; h=from:subject:to:date:message-id;
 bh=mxtvrMaNI5+DTJ+j0xQOaRJA+QlnBKStyl9MpDMdkB0=;
 b=URGTIbTsBd1SjHVAAwr4FLD5B6/IVcoI182AcmkdP5Ml74hpmgNyfDgGbBLXgKk2BlHSQiSRpQc
 FpIDqDxG8syQcAthtz4aeAUt4mjlFC77XCvGmABKLjiph8KsB1c7R4uZ7GYwr1hQuAC0zqaBqOsT5
 2XsKOCP4g1twvoErSqzc/5X95+Fe6QLWDLhr5v9vKtxGUdMqWquk/xz7oJpWb2hP7spwVeVkapF8a
 ybmYym0CIwnRzHl7djGMwzzioZ89RowYFSdUpYy99JytHmfVVPCTNCjVms8d2N74T4NmzfZicIoAE
 +2I4zG71UIfDUwAczX2tjNXBggPakxIDMUWg==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 14 Sep
 2026 13:04:44 +0300
From: Artem Novikov <naa@amicon.ru>
To: <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <naa@amicon.ru>, <rrv@amicon.ru>,
 <lvc-project@linuxtesting.org>, <stable@dpdk.org>
Subject: [PATCH] net/intel/common: avoid field pointer arithmetic
Date: Mon, 14 Sep 2026 13:04:33 +0300
Message-ID: <20260914100433.53971-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.36.76]
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:49:28 +0200
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

The Rx rearm failure path assigns fake mbufs through rxp, but rxp is the
address of the mbuf field in a single software ring entry.

Use the software ring array for indexed access so pointer arithmetic is
done on struct ci_rx_entry instead of on the address of a field.

Fixes: 773cbaf2ad38 ("net/intel: avoid allocating from mempool directly")
Cc: stable@dpdk.org
Cc: bruce.richardson@intel.com

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/common/rx_vec_x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/rx_vec_x86.h b/drivers/net/intel/common/rx_vec_x86.h
index 8d497e7196..9670a21fa4 100644
--- a/drivers/net/intel/common/rx_vec_x86.h
+++ b/drivers/net/intel/common/rx_vec_x86.h
@@ -33,7 +33,7 @@ _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
 			const __m128i zero = _mm_setzero_si128();
 
 			for (i = 0; i < CI_VPMD_DESCS_PER_LOOP; i++) {
-				rxp[i] = &rxq->fake_mbuf;
+				rxq->sw_ring[rxq->rxrearm_start + i].mbuf = &rxq->fake_mbuf;
 				_mm_store_si128(RTE_CAST_PTR(__m128i *, &rxdp[i]), zero);
 			}
 		}
-- 
2.43.0

