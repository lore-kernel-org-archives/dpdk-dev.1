Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F20606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:27:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DA71406BA;
	Mon, 26 Oct 2026 13:27:05 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTPS id B2F2540685;
 Mon, 26 Oct 2026 13:27:02 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017618tdb773a1b
X-QQ-Originating-IP: bty1TOGKPfUr8GUNVwqYJOycjam5zDv+O3J+VlOhDXg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6856373591760128043
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 06/17] net/txgbe: set i2c sda hold time
Date: Mon, 26 Oct 2026 20:21:52 +0800
Message-ID: <C8A89010BB97082E+20261026122638.9198-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MoCey8H5NsCihJXxy7VFgd9rsEUzMxpX2brEILHnqjinUqWOUEtGaOrI
 Y5PhD1F4LJv8XDFEhdMWjFSkpoOQA62RWL2RgI/mX3J57jzVvTl80H5nRiDU8XPn1pV+z4F
 eye2kD1P/1DuyeR4b8r9jqGSI2G0GLQ/iwdeL3r0IdElRNRiQi65cEGGkbLlYVMwjcMLmu5
 X3CROh5fyOQFmf2il0GURIdpcRKhmGadg+Sm1wrr3zHTg5FYZQ37i5e7wgtGWAwMzxqyugX
 iUtSecvGYo6d3Gnh1W4gJToj7VneCIaJEg1f39wo2sY0ITl/88XDSAeOngj4kGEFndmhcBf
 AMg/jQ1pK022VtK2Z82YODsPTTqMMpfB9gcprrJWvfAwFZ+F77cVucKWnFiR6Uw12tkRteu
 7+B7NLeUT0Os2jp0GpTGnjFCy7Oc3ilMpaejReExhSMrnT80n9qZMuAiqCFPoyG93dofpjM
 vp3NUetvwWMFA0co/gBaAk16eN/QCc7XNqfX9DEv5oZ6TAzAotDts6qjL7Xe1Y2+4byjd4o
 FcwR4eGZQT7js3m4jkXzkG9tsJVHLItEjWcIEt1Ga8/k8p0y+dadNS/jAQvJAi14iBiBxBR
 FkGowGxO6RgCr+iX0gfNaVvb+iG4KRp5Uv4F6JmjxX+SHTkSUQR7zDu2AtQ2LeJNSKD0ik6
 gtoMXzqOWJV6gVwAzNC4U2ohOWCdhw3aj98caXOVvYkizcySvoCwIaRj0okGbbXVBJbhEgj
 op24nS9vGG9hxDBqFAg3kokgkacwFx+i0+nF6E2W+MHLfqJSA+LJ6seI3hssa9SNfznqOW8
 qxfyxGCxOQgzHCPkBTjDkJ+oOlIs3nTBtYb1CmvbMjJ8/QDluOZ8BRJXhQh46QOJAq8Sl8K
 OtGfU0O7P1Bgb0MHE3AIlj7GPa7DYB+a9yHLnd/XiQGdx8RcWdo47vYs5LcKApjVvw8BhL1
 gmP6DOSwkvqMoDyFmLQLVbyPdb9+k6MXHnpKF9K1Mg17nGOhasYid1vMm8nuhhjPU5P4XRo
 VGft5YF5dXaZQjrBdJU6CSAPmATgGzV7qFuGn95L8GWMkT4qe0kIUwmBH5X3M6fVq2I9/he
 TDD8H2KL1Hi5+kiHbdrhn7QMlbshT7MLw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

