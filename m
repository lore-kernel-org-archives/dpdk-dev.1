Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9164606A87C
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:43:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8709440A8A;
	Tue, 27 Oct 2026 12:42:43 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTPS id CAED940A76;
 Tue, 27 Oct 2026 12:42:39 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101351t3f4c3392
X-QQ-Originating-IP: H79Qybq2kNUNbMo0GGlHJKPQ8wIj2Om1yerEjdacJHw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 656257286247664284
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 06/17] net/txgbe: set i2c sda hold time
Date: Tue, 27 Oct 2026 19:38:22 +0800
Message-ID: <7DAF91E2E06B1FD6+20261027114218.9724-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N3JEmmiQ3kG5MuVUyE4NV5JI7NYhAt7+mqvvo+2hPR0xIKyEPGFWZfdo
 ASNQLUVTaFC64G9iZqx9/7wZaNdByKWUurrvOAODm6J7RejfEskNMRo5Cx3ayOIHWS/hlXU
 bCmwZdjNjzdz8KEq4pAI2GAabPpIMNz8Hpp8jKPD/0vrbbUo9yOh34Kw6SkCD2n6L4qNYEF
 je5tU6uf5fb/FtMSW8/bxPnKpDIU09Ng6NWy0tlT6NeVJ3uhDDz5z218NwfeKUXRCGRVgMX
 30+xUGUk/hi+cK5JIYqv07uLutuKYgl180BpTLzzbVlktRaYO2a503ItE+2uJD1sXIshHyq
 Vd2pWQ7ypnlqWHpz8sR5uDw8FLu3tmM73/GtlOQLIwCeKXkdAh7yHyHHc/zOVxCQV5tIFqF
 KFJokLmGC1B1QMImzZx0JOUccSn7Cytwz9s9I+e7GrK4/qHZGZ29Zkdu1SDDNbTaPPJdFse
 Lbo5lVacnzAFS8949P/tAJSGRripbKrMs3+v5B0lb9vDYSIu3bDiHVwOkpnLDzOk65z4KEA
 Shp+IodwBIrmNv8F3s3S2rQmyzw0A1ZT19TpbAhm+6psbs9eJWxu8RdKJ8L4hYcgwAPGlNu
 FQV3ilyUf5f/hlDZ/eo6hhShXhFdLmJADNcF89tuovDXRUVuxWRuQQ9S5tPr0mMzVh3mqFh
 CpV0nk6Bsah1WHIjXfRza2VZ0dXiTGrSA+R67FJNK8MpbQK5eEVzgBgkZXYmqMxyDj3iMC+
 vEjxhyZXak44bAGY7TUMQNDGeqF5Y9E3e4RjH0GDFjzQ+WtObR/uAEmUWewE/jm3Bw9aBAo
 ztSZAOtG5qs9f0bE3oRCD7GU+pFu1VbO6YbFJtVx6k631/fIohcwz2h454J6E5Xd2+5sxYe
 RNyVoevkhwYcaX8MMg6luaET9hBKZZgDeMCSqL9egHw4UZ13vRcno2Rwa1xurtX5tu4tAYr
 dIN9kRf4u8vEUlcHovyetctgYuXZR/ye6stAYzPC8n+tqIITRPaXCs0T3S0vsDnT+vD2ZB/
 bvbbsQxSEHplAmo2rwlF9kZ1RXUmL4z5tr6Y/P7urb83cRT8pBfTduzhG4gE+Mu/EiARfCZ
 K+vcvL1YmxDu+Oi1mNGzHMIF+/RPmpN86BrbldMMQsO
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

