Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E82C61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:06:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B07740E13;
	Mon,  9 Jun 2025 09:05:43 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 1E40140DD2;
 Mon,  9 Jun 2025 09:05:36 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1749452733t6c12f6c6
X-QQ-Originating-IP: bz3st00Tdk3mEZvzUtv1h6DP5jL0FhVE1lS5JL2WzNY=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 09 Jun 2025 15:05:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4448260947187978154
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH v2 12/12] net/txgbe: add missing LRO flag in mbuf when LRO
 enabled
Date: Mon,  9 Jun 2025 15:04:54 +0800
Message-ID: <39236692534275AC+20250609070454.223387-13-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609070454.223387-1-jiawenwu@trustnetic.com>
References: <00DEAE896AFE0D2D+20250606080117.183198-1-jiawenwu@trustnetic.com>
 <20250609070454.223387-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NLq8blVtEno8Vy2tvktYmbzklm/73ZPiYZkbuS85ml+fz+xym30QI4iM
 +HazPMRFQsbkNWEnplngrCoYf5PA2aAGkf8IUEGvs8CPjU3astmnOMe41fR5GjFd2+J0zeU
 3Ib0sHco4GcvtvTQCvkD5bmbecw/h1OwVFa1V2+/wJJq/e2tgoTZQHDgJ5bCMJdE2SxdSys
 8PBAO1qJKm0pbdcx/WXuBCO32H19epJMe5FdL+xgtUEp/EzEc86cEAG2htBRGKUviDVfA4E
 a6or0PMSRm0gktMyIG303QAwFJWc4GE18gt9Oubwqza0wdTdiZp7ubHMwxViDy4YFdUKm8H
 7MwlKrZPEiFNKHpxWvIvmqVqKm86MusDvkOeC2ozir5ksGLhVpYtr3z2WrIQYzVSLLS62CB
 6UVqTcDIXJ9QxZNw/gkP/TigdvIEZl4gJ/l0yrBcqfzHd3jYyRV5VmQPiTs4sLsTByUvLPe
 G++nTTjazKiUjXe/53wBdu+RowE01btmnk6nsjPuX9ObkxQWY3YXJlGxtlYLUMJoS1OS7kB
 MYf8l3Sy6yI449O66ZZOkAY3nJo63WSj7HG38baFme8sP7G3K6uY820o57KGojhvU3jy7f7
 uM8f9QD0JGJILGuwb26Mvpj+gtYxw4c7yIhBsi8+zVWM3i0BPu+B0s0muE7oPcMNXcQ6hU1
 ENzQxD7ayCWyDB/biBbJVwbAW5k0yCfeMT33j8Od7vDxuMK67P+lLfYbKYDFp65WSmD+Qgq
 6v9xOUfisKUWbXDUPZsNcU1oIvxmVoAYEwA+N4bfV4DS5MM0nDVPF6J0jDJyAz6MNBvxHt3
 DdAO/88kY9KmXTBudn7da+lo2J4CpcDnVNqJnK2HkwFeY7oFCXXS21iqj2qxwPHr3Ke24I1
 9RjO9jpPnWQ2q13bpiLmQatwxz1lEokwk2Vhgttm2bUeV3wdWGhWrKa/8xE4YzY/YWu3Ax5
 cusrN679WqelUNum/FlnV6jmHFuB96vQBRIyGzrSlBkLvfqUrS3Usvun6OK3iY0AKi82a1a
 EbElP2BXmIgILrdkqYOG90aSMYJu3bt0tjz1+xHj/UIPLD6ns7MqeedXwaDJQ=
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

