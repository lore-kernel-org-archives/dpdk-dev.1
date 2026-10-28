Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38623606A324
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:40:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E00940689;
	Wed, 28 Oct 2026 11:40:23 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 62ABD40689;
 Wed, 28 Oct 2026 11:40:15 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184011t5c86e460
X-QQ-Originating-IP: ZlblS094kV7Hf7iezXYhHjz97NEDR8yhG1fOIkVu4sY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12647443068279752639
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 06/17] net/txgbe: set i2c sda hold time
Date: Wed, 28 Oct 2026 18:33:55 +0800
Message-ID: <7C0D7DD7DFE313D4+20261028103913.10188-7-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NMU4ExeBMtcD4+CnzH8vu40pEIcbpb1lVN6JyFecdv3cP6GtJoQvRmDJ
 //4zHnSjvCGBYuXN9up+6hRlCusqBYkKdEtNkIcM0bOd/w71mKfE04V9NFmyqyjPtYP60+0
 j338Bc60kqCRgqWqBdGwu0UlDhbTpVyPTXZs+grVtY0kgMfeiPsOra/JQi/mTO9t4hAmM4w
 Vk9qUKg883wap1G335dM4nONe5odH9kPW1G0D6MXjY2bCk02JkA1rKZ91jXKuoIDoI8elxI
 QF2uuS9roKt9BQjkXI5Vq29wQdt587kj0xkfoP3d7zi6IvklPPMD0Ztkc1tp5dfMlad+qR6
 6m6uXoiEdOojrphnIA46WZBqPEwp3KlkuKjYERaCupG9mdd9DzStAqekKTiXzyQCDTv5hbZ
 wm9HF0EMw9dDVsUv45YpTDKnJUFeUaTLDbocJaeNSP1fUtf6uz/92devdXsLy1nH9hIA2ju
 BII8PiEwSIBhbUO2U9H7PDF58h5A+hW9bvx7bYCFkjRTNLKrcMVxHeYlR4iFK4h2Aqs7lht
 yHSBe4AnR4XOJBXYTwYDi9LTOJq79n3C1Ma6lwQMTw7Vvr/4nHGK+m41sXtq8w4n/MdZBC+
 7SomEBnxXkc/w1Q8ctmmFI6hqTJCmYk7ubra/9JEYeAs6PsUKAuzISdvKl2q2p9OXxcdAJ/
 yVOVE8fc0y8h1//BX19QPVKUrEXUXdkGkn+RpXNqbbtHQncJVJXPIf3UsBis4ltpOoLa+CP
 TwGU94hscrroY5nhpoaeUUjndtLhNYRJ8sMIuULgBdEute6RQdi0wbRWmMsnwZVGenuecoU
 S0L4YONQ3799ONmLk1Z7tVnjgIwl+Lu1b0nnN63rdpr8wvYa8bx//xgjNMzNTx4fnj8aLsE
 zowSRg5VWo6AzSbG1a3lXvWiHjn/18ETD6p1w6zL5c0zaLVqp5W6MivRXO5EAHJCqs0AkYf
 hU0pzijgMno9Aq9uCc6bO4zzb1du0Te/55M9Bvs2f4Inl4IwZPsYgg4c53juQsodxqoC30C
 Kike9xVdtjxCLZppCWCkUHgWKVd0TseYpgcBsYT671ORfFf/YV8vlH/MCYPhDawl/+EiUNi
 qsvFAO9kASM2PfCLQfaneD9+IqdTMUkm0AhC4JD3k8N
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

