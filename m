Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0E606A338
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AB6D40374;
	Wed, 25 Nov 2026 12:12:11 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 5D52040374;
 Wed, 25 Nov 2026 12:12:07 +0100 (CET)
X-QQ-mid: esmtpsz17t1795605121t996c9592
X-QQ-Originating-IP: mEBEDuQqZTRWmZ/GnR8+Jn8Fw3ONKTYuddOPGWSCi6k=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.235.140.99])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Nov 2026 19:12:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5006335640818521129
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 1/2] net/ngbe: mask unused internal PHY interrupts
Date: Wed, 25 Nov 2026 19:11:04 +0800
Message-ID: <AA0BB9361363251E+20261125111142.12226-2-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261125111142.12226-1-zaiyuwang@trustnetic.com>
References: <20261125111142.12226-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MGFZW3GBkY1bDuJzzawkvrd/4yMsujs3QkTv0rMwlp+GWLSbiDKyBSkY
 mci7Yzhn5YDwiDTTP7HlONgg9XIVsTx28kLjX/udtNpK+oJkLWWPP7l7SPaxej+CGfWTlE5
 qTYEaDdPtb4sKYeZNx6cN5TpFyNqasJT/Qmn3etVF961T15zxXQpk3qqE59KMj6F6ynoRxj
 oawuQsLglMDflHqM7PhHLHaeiJISTkdJ41gVV0Gn8xIE8sRwvD5ZV9jnNAtjMKptYddDGM5
 9bsji6hc/UXiuI5RVD0xnZK4cHklwZxvEpTsL0Azc/tK6rOftxAbJ4cO396Tv/LIFjpD1Kg
 ThV/mhj3VZqF+EILFnw7oupicc1gKDEUMj03xCZtuSBljYvJIEN4784MxsWlmwgy26Z2775
 6l+rY4utCDSI62/z5Da+nxuLnfYiOo2kV2vP1CivznpGVQaHzakINGQ5tKvaNjmgmn9t9AY
 cxF8jFHT3Y5hIYsdSZf2CFK6kxSYTW4N1WV9kvzjJgzkB/8YXGvQPuqTF5DkfM0IvDGqVhT
 3GIZr0HwYV7UftFdnNrq3ARa9Dp3sIyk74CeDC8HfChHvSfxB94CwIK6+E/4ZKYT/irQem2
 OnQQE+DTuE/F8WpGwULhwkv6b68Vzlm8VVK7vQIbOpLQvaPNMzApaWQhyHB2WAlhlGcbpCX
 sbvFHLtojehC3d8T2zqiwk6bYR72y387AmK7p7Vdq5a84f9gPhqm1eSIBQ5WhZQCMEgg0gR
 w0sVKpa3UFCMd5fI5GW6Gh4NzjNztJlcZ7PO0fLqEAvKg3Jm5rsvMU4iNUlI5+QWKDxMzPz
 Tic3niYaiblqfvK7rQpFIyT6P0PXfcJPZH6dfJX2fPfrLSCE7Z+PlhN7YaNXWwiS0pYYz42
 D2VDC+6SewtW8mXVczVT9Fz98hbdfjP+EMRvL9fl5A+ejZfEFSI7VgMEaZ7r11U2GPoQSY0
 ZeQNK6SOQKsTZFVzbj590/GQdA2DrUBicoFarLS13CifygNhg5bOQpbBOLfEscnTiFvSj1s
 3/Kir4iufGFvd2s8DZhQ7EeX9qrZhToJBkLEbiJw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

The internal PHY comes out of reset with every interrupt source enabled
in RTL_INER, and the driver rechecks the link on any PHY interrupt.

Link status change and autonegotiation complete are the only sources
the driver acts on, so enable those two and mask the rest.

Fixes: 3518df5774c7 ("net/ngbe: support device start/stop")
Fixes: 696a82117875 ("net/ngbe: redesign internal PHY init flow")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_phy_rtl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_phy_rtl.c b/drivers/net/ngbe/base/ngbe_phy_rtl.c
index 9312bd300b..74f0a37b25 100644
--- a/drivers/net/ngbe/base/ngbe_phy_rtl.c
+++ b/drivers/net/ngbe/base/ngbe_phy_rtl.c
@@ -178,6 +178,8 @@ s32 ngbe_init_phy_rtl(struct ngbe_hw *hw)
 	hw->phy.write_reg(hw, 0xd, 0x0, 0x4007);
 	hw->phy.write_reg(hw, 0xe, 0x0, 0x0000);
 
+	hw->phy.write_reg(hw, RTL_INER, 0xa42, RTL_INER_LSC | RTL_INER_ANC);
+
 	hw->init_phy = false;
 
 	return 0;
-- 
2.55.0.windows.2

