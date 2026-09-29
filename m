Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7FBCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1277B42D7F;
	Tue, 29 Sep 2026 15:06:37 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 9ADDC42D68;
 Tue, 29 Sep 2026 15:06:33 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687190t11ef76e7
X-QQ-Originating-IP: Sr8n7FI7C8rP098/67Qicyqscpx5gIJMEUzMHeWoc4M=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8283983593625139848
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v6 07/15] net/txgbe: fix link speed display info for 10G mode
Date: Tue, 29 Sep 2026 21:04:38 +0800
Message-ID: <CE7ACE49875AA905+20260929130611.4871-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929130611.4871-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NJp+Y8qdnDqcppG2EmYs36VgwNZiszzok2c5azctpMDL/Cg9MiehrYOU
 kmnKesl++rGR8BcY4f4Hr2q9qCiWmLeaPH/OnH4jmWLw0uTRtSZZrs/hqUvsZPiN35DW6h0
 vpSRRManhh3ASYXDao7J9OZ8sXzonHBOEH6UnUkflNxhpuk71NQr68M8F4Inl3i+D7N5VcA
 I/jXJi+Ssn+3YRoFFU0QgpajfV5+i9lhYdB8KAiWxbdOiOC18na/taMQmMlH48ADiVQXKHD
 ulLKK1BNMsNGgivfZfH9hATLjIWezNUuG3spcSttAk9JTRve5nj2GF0o1927CE2k33bOAj3
 rUgVBhuje3yKLvaT9X9LZQ47Bhn6lxuq7sewTLl2wnKzKczRQ3PkF7+KDgdLZ52mkoqWwux
 DFkgEXFl3/hzfqEDPFdfWrCdx4wahTJ1fBooarEhCMGu9WCbJ4ZjSil/O/xPtfoNXGK7HTO
 EkU7qD2WzW9TMp/Df/E7sJB97l75dOtNQQpjXmso42kekRYkVFJaL+GBPhLiNEhsN6e7d1s
 tq1RX2v52BeQ/pHHZ3TW1UODyyoHCD3EaIvQ9RRKrHhs8z7TSSHNga6G/w7u0DSyA2RG0/d
 PGaIsvZNmaYuYJ4Z8eFJIXbLJccywb3dL4WpWPKVEC6YewwLX1VkcHi8NUPEeBSEEK8Y12M
 4lTvrAyz9CnIv38QJyB8Qkiyalur4L+D6y876m96UOA0cNNI3mAMY2yYj0p5vtbmamh8Mhw
 BqdVcDKfNuFBXO+pTmCszJK9OhlnoIByS0oSvhm3QEyXLLCJBXE2cABOAjqRKDvcZoNTrM8
 pGGIUFqTud5FVtg+HRNc/hH957aCX3McxZmtu10VVLxiPbIzmMvxpYVCp7bbEHZqgXK59dL
 bzzOHSm66F80uiFSmzfZv5cMRda1Z4hrBh5tHoQkwG1dOHxGpzicjR2OupdmP1yZoBrlVrF
 6bT6pVtv4ilPq0juMsviugeogAs4HnqzPqS16yQCc5G1ebc0n7MaRY+ray5xdEqxRekBfi9
 zj0BxMH4xKputfcJ94SSGk8L5A2VIpTsiTxXR7QMdc98wI326RwHEVEjya6V+aGXYpD/Agv
 hSSike/4qTSQC6E/vmImvepweD+pCouSh98GrdgNVXhjZuE5l4x5LJjOAJo3+uRFg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

When an AML40 port links up at 10G, DPDK reports the speed as 100M
instead of 10G. The 10G link status bit is not recognized in
txgbe_check_mac_link_aml40(), so any non-40G speed falls through to
the default case (UNKNOWN) which is then reported as 100M.

Add the 10G port status bit recognition, so a 10G link is reported
as 10G.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..d812adac69 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -85,6 +85,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
 	} else {
 		*speed = TXGBE_LINK_SPEED_UNKNOWN;
 	}
-- 
2.55.0.windows.2

