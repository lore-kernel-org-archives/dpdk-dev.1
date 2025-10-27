Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C203CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC0B40A75;
	Mon, 27 Oct 2025 04:16:29 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 90B31402E8;
 Mon, 27 Oct 2025 04:16:25 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534982tcd7bcabe
X-QQ-Originating-IP: cw6zFup0+jZSsIpvKDtIUDECiovrLE92KKPig6yc/AQ=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13145983964850292375
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 17/19] net/txgbe: fix VF-PF message for ntuple flow filter
Date: Mon, 27 Oct 2025 11:15:40 +0800
Message-Id: <20251027031542.10512-18-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Me3hdGK5nWP4ObtnRzuUprO7yyRdoIZCFRfYWQBpMsCbGliLboa3RvHI
 kX1eUNbisxAb3zx6Y6uSPFAAXZq0bvTtjQOAC7HGI3/JpPsWJ5ClXUzc1ZqAOTT+AmGDbJQ
 eSBJSpkbjpIFlV2R2JqnnohlJ++29qeUimCPCIM/kf3e2355mIKIAnhSm5Wz3bQgBek4dOo
 1lPueASmCk2u3USa3WTXGhYBwHdr+VsPb2KmUrWqPcB2EM416cxCjIGx25fWPs4J5wcKBVb
 O6JhMF+eO5cxFn8+UdgqjE/QPHDXoBbEI3Nd0LjCisImwFLsK3V3BJvTQAULm9diGXSB6r1
 //Sz1SrjYwswggZ61MY3wT6GfHzH7z/oYBeuKTpebMG61O5DBAK86Jlsj4v/2kMnuzk0yn5
 LSP3JApLp43m2wQQ2bSN3zO31+OC1TXn8uk69CEyUNUA8mKfVbNBpkwBrFgd4A7TfrtIGh3
 7zbZzQTfsNJO+Wjz+OMWfA8ADryLYpaurvMh+be10hiptisTERG+on8BX1S4PSIRpyDWeSh
 OrlQkVDTcMZLRasd+l6GOEehw0RshPGfTSur0hynuyKyBfoolFPrgRJ+5ZzaDqpHwR978u1
 wfenynJmBkz8cfuehnm8msRwfJe9EoTQHW/yZZRo203SqorZz5fDEdOG2Eyl9ThiA159uUA
 fBB38xxGUJ0qNHn42HFis1VBlPhH2JHz6NmW+kNAfZbStIPzlF3KT3jpxZqSlvtv58Sk/xV
 2mFygmadZRfcTf0yEnc+zhpCKT/rDn6E8/NKxDbugAXizuag8PveODn2QiphDx3MRO4jR5f
 H2rrfqu6Z+wMZa567ZhBG9X0aTttbR1BzlHLXFtt1cjBdS/sPouzmEbt2QrRRq77MqeAn0W
 +TVY/qbYU4X2rs4/7NcOSGgRcnl+P0ZNePycdBLHfIagC4sqcutF0fgUPng6wQnGzD+8yEH
 qnVdQMwqw+9Ux4Mh/oeKtEcTHs4gWZFUMq9nv6hQyGVheh7BMIdtML3UAzXGCn3A8OZRDVa
 ozXP3x6R0sLmb4cxm+gce2OrDEppLBU0Ej+mskTpFdmzuyzkOQ3purIoxxju8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

VF-PF message box is only cleared for the first 4 bytes when add a
ntuple filter. This does not present any actual errors in usage, but
there is issue in the code.

Fixes: 065d64788cdc ("net/txgbe: support flow filter for VF")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev_vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 4be7c5d659..ae04054d02 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -168,7 +168,7 @@ txgbevf_inject_5tuple_filter(struct rte_eth_dev *dev,
 	uint32_t msg[TXGBEVF_5T_MAX];
 	int err;
 
-	memset(msg, 0, sizeof(*msg));
+	memset(msg, 0, sizeof(msg));
 
 	/* 0 means compare */
 	mask &= ~TXGBE_5TFCTL0_MPOOL;
-- 
2.48.1

