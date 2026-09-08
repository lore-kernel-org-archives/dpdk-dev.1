Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974BCC79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5EAA40EDB;
	Tue,  8 Sep 2026 15:28:03 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 264E540E2F;
 Tue,  8 Sep 2026 15:27:59 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874077tc9424a16
X-QQ-Originating-IP: oiqRbXsiP4kz5SRDEE4OqXUogvFslTn0n/q9iC0qdH4=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:27:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3767135404722406814
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 05/15] net/txgbe: set i2c sda hold time
Date: Tue,  8 Sep 2026 21:25:50 +0800
Message-ID: <E22C2379EB207179+20260908132742.2661-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NDYgveYRMb2lUeU84W0B1kM6BYzyYW6CvmeUXOSjstDNTGBj3Ov2ZERK
 fPZLnxEDX5mw86txf2UTXhOAEoW1qnad7qslRQaentssNw32NfiDp+ASBzOZrzS7zPPhUB7
 dERJ86lkobYjtiKzskVwZr9tVhuC5EKNkk67UWA6PIOFbQIW7hYaX5i/rhF9DlFC4fnjTp2
 FIk2ZXdtMJo1BbGfayCVJZaULJKf92bOy953lZG7k2SUH0sWBNbo103JjiuHtWJBVgK1wSd
 4+Wkiui+SvTvKmXzjBI9qKVZatTYGWh3jw4qPAynGrPAXwcwX1wrZ/fiQDEHtwd2TBo+ED7
 nk4fRJ6JVSxn309L/Du+WhM2vpZiUfoP0NR5EcIi1Ss4wFF+NiBN1syghbPDibB7ImreezO
 itb4ho8QfVW6s/jHKL+L4VvKyyUpc1VRTC68QkyZ2P2A91GNat7+LmIMxJlbKmF+1nvqXXS
 WDTX7GLbRUxEqzof4+7Dc1PfwMmkR0SdB9iw62lswO5ZYPrmeQNJfp5qv3+HoRRPUYhrB4N
 wtkgeTrhKSx9w/c8H0nFKqwJAipbBFlpZ1JgJKHY3BFI+xacjG8zyf++QytYv+LrCk25g4i
 OiRjK08XjIpe9/aU8cHuVOPi1oaRicLtHKMk1+CnJ3MqMAKikM7O1JXsA4XDec8zinRDKmf
 bsQEMTcXXtMIfJqFWnpfy83J6s0sUqkj0Hj5aklDMzibaYtf+2ksd+plUjR/ywmKYZL7O4m
 OvmV0zL75fjV4LtI9GPlqQOCFBscJ6UZl5Lwa9ujU98VX3RKHM1e8ES/x1wXsBoMnieMGuL
 Hi65OctK3wuhdVezlY3b1gearDEsQwHZ4tcqs/Etm1/J5zs8/ofjpPgragf2n+zUE8sUBMh
 bEIS9AkpJlC1rrmZFW8jtlW0bvdDKrhrK38rQya4qsumF/yluW4ONGIgNx7SvmBCYhYzPLo
 P6X0EOi1tjLGZ4f+1el9AahPNEvVWOMjeK4uJJxM3CRmq+39vYOv7hVpUBSFDRLxYPcnjew
 NaE/zT/TvnWPXRirvvHziSKkFVzlDBR+ZJBSz6G5C79FhvZSQeZ/HHs2DvFPCRr6MSS8iDU
 mUhtBfW/BXriSp+KnDKf2eia1yN+tZaw72/KfSozXTRl81pLqkHBXxHvMnYL6fRdt/80W93
 NRqM
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

The data_in_hold_time measured on the oscilloscope does not meet the
hardware requirement, which can corrupt SFP EEPROM reads over I2C.

Set the I2C SDA hold time to 100 (0x64) I2C clock periods for both
RX and TX in txgbe_i2c_start().

Fixes: 00970f6398c8 ("net/txgbe: fix reading SFP module SFF-8472 data")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_phy.c  | 3 +++
 drivers/net/txgbe/base/txgbe_regs.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_phy.c b/drivers/net/txgbe/base/txgbe_phy.c
index 2fbe50e242..8b653f0aeb 100644
--- a/drivers/net/txgbe/base/txgbe_phy.c
+++ b/drivers/net/txgbe/base/txgbe_phy.c
@@ -1334,6 +1334,9 @@ static void txgbe_i2c_start(struct txgbe_hw *hw, u8 dev_addr)
 	wr32(hw, TXGBE_I2CSCLTMOUT, 0xFFFFFF);
 	wr32(hw, TXGBE_I2CSDATMOUT, 0xFFFFFF);
 
+	wr32m(hw, TXGBE_I2C_SDA_HOLD,
+		TXGBE_I2C_SDA_RX_HOLD | TXGBE_I2C_SDA_TX_HOLD, 0x640064);
+
 	wr32(hw, TXGBE_I2CICM, 0);
 	wr32(hw, TXGBE_I2CENA, 1);
 }
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index bf46a80862..b0042dc0d6 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1610,6 +1610,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_I2CSTAT_MST          ((1U << 5))
 #define TXGBE_I2CSCLTMOUT            0x0149AC
 #define TXGBE_I2CSDATMOUT            0x0149B0 /*I2C SDA Stuck at Low Timeout*/
+#define TXGBE_I2C_SDA_HOLD              0x1497C /* SDA hold time length reg */
+#define TXGBE_I2C_SDA_RX_HOLD           0xff0000 /* SDA rx hold time length reg */
+#define TXGBE_I2C_SDA_TX_HOLD           0xffff /* SDA tx hold time length reg */
 
 /* port cfg Registers */
 #define TXGBE_PORTSTAT                  0x014404
-- 
2.55.0.windows.2

