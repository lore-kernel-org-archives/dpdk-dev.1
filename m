Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1500EC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:03:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF8C440A80;
	Fri,  6 Jun 2025 10:02:14 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 99DD440616;
 Fri,  6 Jun 2025 10:02:12 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196930t70a10978
X-QQ-Originating-IP: x/UBxMy90aJ05IgwczE9gahBgdg5+7YXMWXpSZ7ex94=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:02:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 920152005024094870
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 12/12] net/txgbe: add missing LRO flag in mbuf when LRO enabled
Date: Fri,  6 Jun 2025 16:01:17 +0800
Message-ID: <92848230FA6165DA+20250606080117.183198-13-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NBplAH1p/X/dk/3v635441BWYXpkdt6PxrYDwNoHGYvwvRTTSP4RciBU
 Kf89eqIDKo+ENFmryMVJQCoMGV0qGm2abIgEftUJheeZhnLlgcQ4k+ATHCgR/AoxyCF3+19
 U8sSikUdKK/T43ORb6P5Ko3yEmiFDd8VsLxYWvXHgc/dlU/HU3onmFZMwu1+DaoCKr4yk0e
 mK8f5PiGy1u13mY7Izfr8mZpQjSkXS7LcQ7X7K6zKVdOs61Sg9F0E5jFwdRzIsNBTt5Fcxo
 5VZdOr/3ltlFnB80HecGggLph++sK85fqer1a1YlU08yvWPEYjdwLQJ9sBMdRWv7KKZ/U/o
 RoePfZGdPagwCkaoclYVKYb6RkgcsapR1T0Cn31zcjvKwe/3LATCVkTze9yVeyPfVkWNm97
 Igf7A1cQLGFxS2ROahIVsCX4E7rnRdycNWBJeCb4cbPogL0TG6L6ds8+S0k+oVCcwzWK/G+
 dJCsn3MSVNVamAe6mO58N72SW+PS5+wCSMK0+wXBQONqTVlK26vpNMFbL7q0kjXJMVSgyzc
 ifiIFJ9/zB5mqQP86SrRNmFZ8Mxa+QyplO7wYS8SU8QFhPa2qTZu9wqokwNLcD4d6H807AF
 5NFfAPOnr+BpHfjcTv8CxctKaJho/DQYkESEW0TJ031ml5oXvKG7DKD1Htd2jiFYo17BDTr
 Hqpr1zC9A9Ej5iYNyz31jHo2GN6AMbMzPgCqQ5IekPv3/H7FD4k5OMW9uf7SMktAqoWT0hy
 QzTKoQCNL4/2bdNS55ZO2/IMLsmO7MJdqRDLz7VYZPoNHDg3LJUmaY5tGRedRob8RiUg3zH
 td0w31JFk3AV1paIN7mrPe59lIFmwnuG9rW6YVw1Q0l+5nEIV/1BxXqgZPzBt7wc5G+xr2r
 TudU7fuCgPU3DtTeIhTNgZMHmdj2NA9Wd3FiLA+/4ApD6lOBN4NqbRqBB3LBEWKhHgEWqS9
 PSkKkKbSkiqRYrchMwHt94fuvYEpFQnDfeH/X3qTJzsUHIi3qZTyLM+lS6qI4DBEhd7ZKdK
 yAMkN1WtSvHOdCcTXbrf2EB7cVyzLd1xrOoMZmymjyD2oRKq91
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

When LRO is enabled, the driver must set the LRO flag in received
aggregated packets to indicate LRO processing to upper-layer
applications. Add the missing LRO flag into the ol_flags field of mbuf
to fix it.

Fixes: 0e484278c85f ("net/txgbe: support Rx")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index a85d417ff6..e6f33739c4 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -1793,6 +1793,8 @@ txgbe_fill_cluster_head_buf(struct rte_mbuf *head, struct txgbe_rx_desc *desc,
 	pkt_flags = rx_desc_status_to_pkt_flags(staterr, rxq->vlan_flags);
 	pkt_flags |= rx_desc_error_to_pkt_flags(staterr);
 	pkt_flags |= txgbe_rxd_pkt_info_to_pkt_flags(pkt_info);
+	if (TXGBE_RXD_RSCCNT(desc->qw0.dw0))
+		pkt_flags |= RTE_MBUF_F_RX_LRO;
 	head->ol_flags = pkt_flags;
 	head->packet_type = txgbe_rxd_pkt_info_to_pkt_type(pkt_info,
 						rxq->pkt_type_mask);
-- 
2.48.1

