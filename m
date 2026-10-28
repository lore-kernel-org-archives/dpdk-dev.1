Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D6606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:40:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07334406A2;
	Wed, 28 Oct 2026 11:40:24 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTPS id 8068E406FF;
 Wed, 28 Oct 2026 11:40:15 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184009t11b3b3c5
X-QQ-Originating-IP: KZlT44Roksc3LTCMyQ5rN/meiXjiG7Qu4dIHF3Jp7zU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7342653453248070877
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 05/17] net/txgbe: do not force reconfig on link retry
Date: Wed, 28 Oct 2026 18:33:54 +0800
Message-ID: <5B6566703762811E+20261028103913.10188-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MOfwHzgDpc8IqXj7UhWFvsY1ZvbECvMdYSVVa9rP8At9Rt7PTZ9fB5FU
 SMBuScDfNdZUAGNlL4jmCkRENIdqem//8JoLRrQs/0ZtAI73xaGh2S9BSTTLYW+xQmL8ORM
 fvSGIRliglgcQCXsG8ieIGtkIAYpDc0ScRKGfbdxds4Ax2AXzFGjgEpsvIkE5bHmkLf2aPZ
 iFDiAcNZ8f7b+nXr93rlKqvMQgD6L8HjxIJad4rJO9moJXviPZmzjAadYD4M4URLl+CutFV
 1PQe841ZG0BQl2S014PifdfPCyxUXyeAu+9Fkfi57aV6fVJkGeSiGfXp+cpb8IcyuafQjDn
 KK0xxqhIkzSt30+b5p41GZj9Srs/X2Nst9ReIMR0oBIZ4/4bKqpxHBC1IPrQ+b8jmvDPspJ
 BAjJrmm9WYcvk5PMwfKHqpbqTQi+PfznG86PMiIZbVcYzKCjYwAqRLFirr2xefaScSCAlhb
 8muPc5khZLtfoO35lrPzDGXzV8pkEWR5qdnFgqUuiUp/2et8JUdf9bFRgTel8cdIgGBQg0s
 Gq5wGfcCbB/mXn9jKlzacwvYqhF8TvTBFZTLNlvsTCuBKMg1HsYvzx9s4yYT/cZT+1bUZNM
 pgfPZYkhnWavKLM3NGe1Jz3xlNIMmXrV+Kj0mufH2sQC+hHzHGovdq8wFyRFGqbXQQuUVCH
 J5zyDJuo1o1GtR/8zWQGbuU2mvPnvlt6RJvqjXTRresJkppXu8xoRzsYdRZYgnP80k5IcT6
 Z+k0MZDxk3aeAJbhPE0zLPi5rHCpaE5nhM6+E3HwgA9abz7q8QbaZ68/wOXGaMnwC2GdU1a
 qYMWW9KBH8peDr8Q9jnd0yO/Gmm0d/EqtzKhH3VguMFyllGNRdAIGITMXrfmlv7xM8PTA0p
 Btx3O4DmCX83ZGcguA8WY8AztQT7TJR5BvOs3UZcMuSQlCo1NBXoP2DtqmVqPl2K472yx/N
 mD550ztu0dCewo36VIgI1gZK1vb+aubODqZEdx3xasyBYU/I2idSPwAYic4gqaZT0rML6dt
 6tmU3fKW3UVuCxSwvlzKK5l07mH1GXEQJPKsCH5zuswG7Xgzz7c16tZ2E9kWuWFKFZeH54R
 Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

The link alarm retry calls mac.setup_link() with
autoneg_wait_to_complete = false. On the AN73/xpcs path, this skips
reconfiguration once the link is up and AN is complete. Passing true
from the retry path instead resets an established AN73 link, which
then drops and may not recover after DAC hot-plug.

The setup flag is also passed to txgbe_e56_set_phy_link_mode() as its
need_restart argument. Passing false unchanged would make a retry a
no-op while the link is down or AN is incomplete if the PHY is already
in 10G mode. Pass true there: the early return above already covers an
established link, so every path that reaches this point needs the
restart.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 3 ++-
 drivers/net/txgbe/base/txgbe_aml40.c | 3 ++-
 drivers/net/txgbe/txgbe_ethdev.c     | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index ac80d85f08..de4db31cf8 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -246,8 +246,9 @@ s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
+
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, true);
 		rte_spinlock_unlock(&hw->phy_lock);
 		return 0;
 	}
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..ab7012608f 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -171,8 +171,9 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
+
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, true);
 		rte_spinlock_unlock(&hw->phy_lock);
 		return status;
 	}
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index f20e57125d..2f513e20b9 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3228,7 +3228,7 @@ txgbe_dev_setup_link_alarm_handler_aml(void *param)
 		return;
 	}
 
-	hw->mac.setup_link(hw, speed, true);
+	hw->mac.setup_link(hw, speed, false);
 
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
-- 
2.55.0.windows.2

