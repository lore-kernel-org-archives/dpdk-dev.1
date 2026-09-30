Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27697CA5FBA
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BE2742DD6;
	Wed, 30 Sep 2026 12:21:08 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 89930427D0;
 Wed, 30 Sep 2026 12:21:04 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763660t1acc2d10
X-QQ-Originating-IP: KEWqKbVqyANs9UsJOv9of6QeY0FF89nKQR0uDnncjt8=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:20:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8671308627540726989
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v7 06/15] net/txgbe: set i2c sda hold time
Date: Wed, 30 Sep 2026 18:17:53 +0800
Message-ID: <80437E11F1F7D132+20260930102042.2214-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260930102042.2214-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MpvVxjO9l39x90hpHy+HvsIF1XPPQn8105ml7MWOYzB0dXpdctivWGVq
 lLSDs5GQyG2ZklwhdMkIAqO9hCeB+ZmX3fIymOA/tjMI4TEOx0B1Ibd4geUfn7OqXXEGdhw
 ghBP6R/qCyOEpw+XvPFZ5+iXJXRCHMc8ZYgDjioxpyQ2BxZJXQKdNbf1wUxsYZOCNw3jjkU
 32tp3i7rsz/ikpyY+bPLD6guf42XoF2gnhT/1H8LyxNfyYUBo1/yAUhdeqhZoz4+XDkYf7F
 u3nr/mQZcLpuJbZpIKHK65wi24FfwVMajvg7prYvFi4Uipfy6OMtEHpIYkI/OafZqHs6/Cp
 CJhwDccggCEjr9ZBBR9NbOgYJ69y7NUyD3x9ceFYgekWaQGegTTRT4Zfz1uVpMrG65vdMaE
 N5WTIkaImTa6KUdvw5NhSy2qSIGqPPYXYm4I1NVT0SNzJgWGOVoQhEK/7jiwbwbHS1BUi4K
 KLlFTHGu6biw2cMxh6u2ef8Y4Lpk/6HJl9X0c722kqz1mm96a7JX8Rp4dti0TCgJgesXlbj
 2HBuxzAsLB6Cpn16MWCopgLOc1RYjMwDLC9HMV21Nuw8BUIQ0jbXv+ipmTrO3TWrf+XlgqO
 oMCb5AikddNaXM5YpDStrkjtE1VGvGQPOXEslGZwkOVLpUgJHpmX7CKEQguQ5AjsSWj/wpX
 LCr4rpDyIBGGRmqiyyjp7m44cqZqDH3MLmYn7rqLVvGuLhTwOgDc3O5/3QGNgRUqF3r74W8
 aAQQw0UPAIuFnuvbahjaSqH47HidTmfV1aaax4umsvhRgh9kDWgM4shOAd+SsRezJJ7LCIz
 x3kBz8cQwaQiMTEwY3IX0xrCqBru4H41nkU1fX/9DU72qS69pPE5I3JYM7gqbGTmM+K6J51
 VoOWNFC35io6NSAkEorUppa32ioH/2l4B1dmhSVIwEG22sYp1u7ZOL2DOdFi7vqXRYnC63S
 8ze6P30ChZYStikY6JhO/R7Jns9775XaSngxFgifSWwUnlEqaAOtMOBLGlIARET+8hf6I0z
 g80qPMt/mV2INSqrUDhLdX0vLT0Dmz1ioU+9lajrzOqJESeavFRI45tWzhGxAbDSkDI6MK8
 RvIfTANiJayPGKDoylcN9g=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

