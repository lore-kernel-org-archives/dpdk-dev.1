Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1EBCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B724060A;
	Mon, 27 Oct 2025 04:16:09 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 27349402E9;
 Mon, 27 Oct 2025 04:16:05 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534961t723b4619
X-QQ-Originating-IP: n71Qw9/uquy+yAGPYRZy7p1X4xmLTxFkv//Wtgu+p/U=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16665371084642865939
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 06/19] net/ngbe: fix VF Rx buffer size in config register
Date: Mon, 27 Oct 2025 11:15:29 +0800
Message-Id: <20251027031542.10512-7-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NLyBhYFVFstxkqNHg7PqmrgtSr2+IXZ39aZpCPdyTYevkhILRoDupV2R
 l6P7KE59zeVc7z9LWkCAYl73MZUV3wWpkkMMw3/0+NgYwOasVLlbsZTLTL7lomr3YuCMBP0
 rJf97CNoZVSQVfdwt9Bup9Z2omz2puEUsjir3ZoOX9XQL48rO/BrlpxY1wZOlkr0SqPojn4
 O/RWZwDBgmpmUDxZlQwg8BvNDbtALZrhgsOjmIM5N+TYz6X1/TbaCBoC+uml6KoDFcu96Z5
 JxNJB6qk8lQP1j1Hqg0DrwOWbUDxFys0UEiC8GEiIfXCfk9lERAwifv6lbjouOPZzl5bepP
 144O+vDwEPxrtdIHoVDAqiO/PMD83uEQ85SsU/0dqGQeqianpivxF+QRq+4Z7Yy6xhSAJCs
 shPeHQnCvUyK+JjwB5rT7COT5wNXPG80EoFLnz+VRBUiLXE4Dn9JL/XjZgflrhvH3ZFhHb0
 XzmaZ4tJCgoDxnN3zNu3UwpKsGZBjvmSFj/6N/yzWOC5RMq4k+VFdvsJ+NnvwKTlatpFI+F
 ld5T2sFZ3UGJmOVOd5vqepg6+r/z8ZZvMzQ7gyv4llTUr/J/K+g8ibrTuXK11vvmxUldTGe
 RPOycslFCWrM2H0x8ZNfpplArNSmzVQjPouiP7YAxGC/D6FEdn1uubLdlVoSPvizVLtHp1V
 vyb00ldN7OIl4DAn6iRK00ahUWEbBO5wnpNWzdC+mZFqbaOs0yjYXx4dTn7l0LyzrMf4Q5s
 IdILH1jfSoOTvEDlFvU0Ns4xHgo/BWf+0JHz0FCLAdfYDKJ+S++wxxru2kBBDu5R52rhGKu
 OlHpwDVIjiZw6Mru3NZMuAG6gya01gxFKl7THmxeP1XSucCth981baTnS2+4aAoVFqIynvU
 ku+URzEKCqvL4HKKgN05Hoc4bKByqlsjM6YRf9J9+kaKW/3Jfc9wwMnb3z7XLLyC3QqPQwg
 VRF4zQWB/U7OaAP4v7Tu/tUS5ciIJuXoRRzNydGlMxVlNRnIaNBYl7CFbLZSeMSQSTR0r/P
 fL89XF/nXDRDSmuP23yk4Ljw4AYHivXtJccpH3/b+HqVXm+Wd0to7zM2S1SzM=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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

Refer to commit 8a3ef4b89e6d ("net/txgbe: fix Rx buffer size in
config register").

When round up buffer size to 1K, to configure the register, hardware
will receive packets exceeding the buffer size in scatter mode. It will
cause a segment fault in the receive function.

Fixes: 711a06e896ba ("net/ngbe: add datapath init for VF device")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/ngbe_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 03ada844bf..66d72c88df 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -3559,7 +3559,7 @@ ngbevf_dev_rx_init(struct rte_eth_dev *dev)
 		 */
 		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
 			RTE_PKTMBUF_HEADROOM);
-		buf_size = ROUND_UP(buf_size, 1 << 10);
+		buf_size = ROUND_DOWN(buf_size, 1 << 10);
 		srrctl |= NGBE_RXCFG_PKTLEN(buf_size);
 
 		/*
-- 
2.48.1

