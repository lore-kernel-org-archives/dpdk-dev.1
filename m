Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74883606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:27:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB25C406B4;
	Mon, 26 Oct 2026 13:27:04 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTPS id 6B6FC4067C;
 Mon, 26 Oct 2026 13:27:00 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017616t87a32c94
X-QQ-Originating-IP: 2Mvf4nJvQ0YnT97xo+2zRWwCOXIcA/HAWqq83jtSRL8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11310143547835627393
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 05/17] net/txgbe: do not force reconfig on link retry
Date: Mon, 26 Oct 2026 20:21:51 +0800
Message-ID: <B019BC7CB653D341+20261026122638.9198-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NCjYbQ0FTrEVNI5lvHIiDmPaACpZBeztsvjOv1R0WjxPMB54nqHG5N55
 ELZUOnjLD0+1P4vPlzHLxfwDszRWRFHWxRYPcWzBpWf22V+85feAV1EfaZyQjZ1Zdbsw7MX
 Iq0hCEkdQyxUb8XEsM6HNtMSUcdmtEIo9+0O2nR/pOATOLgvEr4Ficz+KDWB6uQdKyJvN0n
 +l7CkagnOSgE/AiphR/fdmVg2fUYc08zSCoUYwS2kBlCp4V5oqL6pBFVV7LejOwnas8Crrg
 AobpFLn+mm9MFjksxU/bv4mGdvX5OiTN4SHupWZ2C56XRXm9DyqD2A+7drP0jxEegmse3KX
 NwK8ySfkWK9U0MHdposWAIj+r6P9rxJWSNo236HBDy0koNIiz+5XbMfYxb/W2Q3KSzHsCkI
 iL+po0oU4k4C1dnLSkFXnE/isFpuS1b6utSnj9NBTVzFdBzPMp8X2ldYwpA9MMIpPJ19QJD
 p/oncqbdDyku1vitrGe7ZATgQ1LHIQoQHNa/y8p/AFhYldcGe55kXjXFqeo7BEPA2sidotw
 uQgPaXmfHpVNZhp0i73TlTau2h0CDOLSV91vsrVzI4EB0mN3UtotNsfLLqoRl4//05TD/et
 FSp2CxzI2Ar+qDx8C5dwM7MsF3j2rNb9BZkLQVfTA5lce3eB0eC1bn083Q2xxvQ6VfS/YRy
 G4fbUrJZs+LtQ6zB4wgYs1tkvgg+Gvn5tokkeFi/d80L5NR9EFmiRsbBfb8rT1ewmgO4eRk
 Qtzt9gOeRdQWEWXIzhb249JKXnyRmUqMbpMOYSFYD0tWmT1S7/UT4vzke+5VBO+hxrynljc
 Qsu71ld6+jgD+rbZrKuRmFWfPvAtFjDbpm+Tky9SxdqrPlmWvdk/SxU/lMBFNBwIbkqoIOH
 EBZagpqYSWNRrozbkNuxljpuEBAjrnVdORr6rgreY9kBnFHV8H603K/MsFQbTxKy4U3l3yX
 znbFP0qiAAml1jBCbqTvLVbdl0pXhlD7Lr1weoYWVu+aIW19hfV93SHO7FzMaYdFwDevGyU
 wYtu5CNQvYVSmhXhFJAiSK9ahmWWi+i28O2jDiSEVfIot1k/QWj7Amgb2YyZGPJfjYH6kQj
 mMIzZhcQHDipJ+uWQk5dUU=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
in 10G mode. Derive need_restart from the current link and AN state so
retries recover an incomplete setup without reconfiguring an
established link.

Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml.c   | 5 ++++-
 drivers/net/txgbe/base/txgbe_aml40.c | 5 ++++-
 drivers/net/txgbe/txgbe_ethdev.c     | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
index ac80d85f08..7a0839a7d1 100644
--- a/drivers/net/txgbe/base/txgbe_aml.c
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -213,6 +213,7 @@ s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
 	s32 ret_status = 0;
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
+	bool need_restart;
 	int i;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
 	u32 value;
@@ -246,8 +247,10 @@ s32 txgbe_setup_phy_link_aml(struct txgbe_hw *hw,
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
+
+		need_restart = autoneg_wait_to_complete || !link_up || !hw->an_done;
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, need_restart);
 		rte_spinlock_unlock(&hw->phy_lock);
 		return 0;
 	}
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..892dddd373 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -148,6 +148,7 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 	s32 ret_status = 0;
 	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
 	bool link_up = false;
+	bool need_restart;
 	int i;
 	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
 	u32 value;
@@ -171,8 +172,10 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
 		if (link_up && hw->an_done && !autoneg_wait_to_complete)
 			return status;
+
+		need_restart = autoneg_wait_to_complete || !link_up || !hw->an_done;
 		rte_spinlock_lock(&hw->phy_lock);
-		txgbe_e56_set_phy_link_mode(hw, speed, autoneg_wait_to_complete);
+		txgbe_e56_set_phy_link_mode(hw, speed, need_restart);
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

