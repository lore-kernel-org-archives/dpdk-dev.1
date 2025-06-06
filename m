Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54376C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6A324065B;
	Fri,  6 Jun 2025 10:01:54 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 7C7FE400EF;
 Fri,  6 Jun 2025 10:01:52 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196909t39dd3cce
X-QQ-Originating-IP: YVBLwCHLWPZYYhO/eNK4cmHOAYYHWGITf2n8n+cJcxM=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11447980262828416302
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 03/12] net/txgbe: fix reserved extra FDIR headroom
Date: Fri,  6 Jun 2025 16:01:08 +0800
Message-ID: <8D9A900CA63A7BF3+20250606080117.183198-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NUs1L0yK405kgaITn34gTgZs72p11Hl0vU0QlTfIh/x0h3LGGdXUOJwa
 BVftax7bpp4mvdkVWhJtNYXF+p6h7iM+F4/2D0fwOCFvkOjViwem5bM6/iXpvrW9JBLieX3
 KJiIEuff5gLWBjlhHQWfDun363TYV8DRsyoeNOQw3E/ywWo606hQirO8FK3vFDnszAmL2c6
 vcUOmHoyylIVjmdPEcgMhYmcI8IpkukSKc/mJqOctsWZBSwuTgxwZT24XFMRqdFV4hfpINs
 MDtiz5Q1p07MxRQDt3VaG/xRoIZH0DHJ/AEED7Ig3rcZfF6Iw4yZovYMvaTTg6+Wgkkz3tg
 uOwhKYU1qCFkuI+rdIS3/uYu7Pm1OTyVHfk0g+dwxT83Nsw2QNj6PVTqxH2wBqU/LntBLU+
 vYanRQrx2dabZIVNRYQCXxoPtRkBf0QRT9yfmrtoTcMGutPK3nN3uQ1f+2v6dWBWhZCuqaq
 QAWhMddjMEjQ/48Z3TdEfaX3pPQXp1biH5HDwWhW9mJbdAGqlSWIwN4hEyJ4K0izrO9ReJR
 MVFGhUXWBpi16nY1LBkSrU7mKKKx6NidHOd0R4g/cPhr6WixC4atNTTstVgX76UA45mGS9S
 zl5cyfH3fTIKzqAoG8QsK/zGdv30eGd0yaDpQtcwZkcPpPY0o4t/8vAQJmfaU5jR8grXV0d
 Q9T2x0C5Mjm02ff5umwXs6eBU+Kj2sgDrG366w5FMbfB8SIv6NS2AqGtb0OSRi/ODFI/X6k
 qIeFH8gO+L0x101ygjegg+kkEHTq5qvwqMwbevZnZutNQroqO+Ky/g00jw29ATSRa+cdUfO
 t2lAiCBCyQjHTxm5RDFD08B4JkOPz+2tXQDEYIwkpRNc/X6qlxAHTPMTVBAI5AU2oz3n1Md
 eZYYQAVkB2CjDLMWN/Q2wiL79lQUOFTbqyRd9aT05IberQSySRy/fdCbeMxyP2KIhgI9L23
 GYJr8vb4qxloAIFeKjOQU0+vsMdLqhIDz8BXUjG8amBe3TI5kmwUYNDSweqrfVkgXXFSsTj
 X0gXdze7py9V2Z7WtqbrnCvpU4+Upcpbs1xk2RgQ==
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

Remove redundant 256KB FDIR headroom reservation. FDIR headroom was
already allocated in txgbe_fdir_configure() when FDIR is enabled, the
second reservation resulted in 256KB less available RX packet buffer than
the theoretical size.

Fixes: 8bdc7882f376 ("net/txgbe: support DCB")
Cc: stable@dpdk.org

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index ae2ad87c83..76b9ee3c0a 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2106,9 +2106,7 @@ void txgbe_set_pba(struct txgbe_hw *hw, int num_pb, u32 headroom,
 	u32 rxpktsize, txpktsize, txpbthresh;
 
 	UNREFERENCED_PARAMETER(hw);
-
-	/* Reserve headroom */
-	pbsize -= headroom;
+	UNREFERENCED_PARAMETER(headroom);
 
 	if (!num_pb)
 		num_pb = 1;
-- 
2.48.1

