Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E0606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA33406A2;
	Thu, 22 Oct 2026 13:10:51 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 2B5DE4069F;
 Thu, 22 Oct 2026 13:10:46 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667444tdf563614
X-QQ-Originating-IP: EL3wvAc/Sh1MhLT+oJR/q35kxVtwTySqpaTLCOQjxgI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9706215043981534942
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 06/16] net/txgbe: set i2c sda hold time
Date: Thu, 22 Oct 2026 19:03:12 +0800
Message-ID: <1FFA9E79ED307B76+20261022111017.3605-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NPQM67ymruT1w/kU5NwVAPk0S2nHglRLLnv+cRZRInGlJSAGfbRzuLjU
 0BPCrNe3q3CrdFgjKoGbd8w1T5LOkFEm/tXEZZXpSrpVmGpCjmMQ7MFH+JLq3Tp0N9ntZAg
 jLuQn1aoY5QYJP0TeN528g5g1uyIKZw4TFamv0ejYkROs6dVGzLtJrRcyLoS4T4RXO/tX2P
 Gn/DWu9/YpdVFZttezdN8reKKu+FcyJ92DEYVoaFG42ErA+m/K1WeQF78BQBTtvgFyHY1uy
 bwBGefVOoFRfGXL3lW7zNH2P0mC7xxRQN+uXAzZgr2Hl1t1SWCyJowGzpXUjdCnD/m5dQWm
 vRZ661VtZb64nKycIgkELoUDJzf4yqXWwY5fk49lxSzinomdu/I6uHoyjMC18fcMWL9zAO6
 auIkLjySnAtIj+p8zLbyf670HkGsziBPg6qUbqXat9ahNxDrLmRhoaJZG3ZoUa9KYvmoEhX
 YyiShS0A/SVBaeTgt8ynNsaEoVn3wsk8Uc16mlbbERcxxUNhsF8RerpqLDYkGXC2+8syHtQ
 tkGxeVIlXKektveEijV0yrm48yuurhuYBkcLig0hvgJ0fXVHvwtHu9hTNBvBOFnh3LX/Im+
 MP8JHvTbs2JbqmOKQrPxS3rH+wTu7v1W0bn58cZ6F0eGJWrZ6PGRpJsyXB+ZLSHwq6aQsZB
 +Y7YgKi66RlvuOyZZuyf/mYc++JafWGqwnSMe3LgrurGiYITXjW6C4CtQAS+QcuGP15IUic
 W4NJo/8J1gmfbL+Lz9pPRNaVaGXpBAnIfq2MKBBZ75bTVYkHJoH1R14bV+KTW8UiBWuXDp4
 vuzeh/Ak8PqjP9xMa4giO/BDh9QLl9OdMIbYRx560A3yl7+PQnIF3c+SqSNncVasaWBmpHL
 KPy1voiCwiiPP8Aq3saFQcpVcMirEwYw4mdOBGxwdi/JIjg3qveb8lcgaSlM1N5rlZuUa1A
 8icWI5K2b+dOVDll/4JrdecvyoPLWDfrqQWo8cIP1oKc/tKKvMmDfhskh/m2UYGxbrO+ypY
 VLGx7vLtN7Dm4FVV6Nr05m6NCGxfslDATWjsvvUaX0rKx+W0ppnKaFEs8/mXepZXoKHU/Ef
 1Hh38eE/K19SDRDagxY60A/N847o4kf3w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

