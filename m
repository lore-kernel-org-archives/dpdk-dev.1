Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF79606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4087540A70;
	Thu, 22 Oct 2026 13:10:48 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 475944064A;
 Thu, 22 Oct 2026 13:10:44 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667441te49885fe
X-QQ-Originating-IP: wUrm/WC28Ku0wogyxdSJN5PbYTxe17Mi4cWjyCgLd6E=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18416530044507834909
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 05/16] net/txgbe: do not force reconfig on link retry
Date: Thu, 22 Oct 2026 19:03:11 +0800
Message-ID: <E0E0F9AA83F3B6CC+20261022111017.3605-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M12MFmiBLnnlh+V4oR/kXmIg6naf/4ge7oFSGte4deAwbfWm3jkix6EI
 Kml/eQ6Yk4QfYDdvZ6F0tDEsBuK3pbeHXHwgOUeTzEjFsqd72hgILOUwcl/ZZb6c7X+y1LO
 2bVxmH8sto2Ej8ClKQRKKesKYjlWBmAqAr0znR6C1dYWZ8JR9wEx83WJ3rBfEx6T+t0LHzU
 x97He34OfMJTN+BatVkPx/tnT635WdlOvU5M3pb48yZiNr6Ks2HMOD+2GbsKMkRQJnp0Wx5
 EqkTc75VBRHYhIunQOVYJdKabtV9lgkLz0jBtDkHff7lVt7wNQKmm3kPvshc8UyKKliSpwj
 HB6OA6dLHA/THMr29cScxFC8qWuvoxgsKDkgnSGCKPl8au9QbcSv8htf5uo7zW7Zs5V0y16
 6xd8en3Ao6Gha5y3NYdYCqii+8ijQE5xQCkP4dl+yOj6BGZnaBsnOIAHB462a7rDskTPSIV
 Oe5ZMYM7pEfxsjDqezfkHNEGAz1tbIX8nSFkRAO9y3sRIkyWTM6ZvqqIK4jhK+Htl0Te1Y4
 dNxcl9XDxvktI7nYWsOYQiLaybNYcRnN8FhMc1clVfI1rmjuK5LJoghR329db4yRgHCGLOf
 55X16RlK26WjKYasFeuPJ+uxjXtwCgY5gR/Kyyi5TNSWcGpUyXMDkK5VAYZCq7n/DyyXgPf
 HMQ/Y7hj7wLs7Ml7uAQccYfZItjGp57ce8C3VgSreKo0e/vDyuLS7KzCO0OBDgfrEUq45ub
 +zfko5EReNZWb98DN+SJMWMLEUI2g+aW+wJpXywMzN2oUoLBAuCT1D+rXXgCV6XTrMWNMYn
 7ri8TwWnnf6nmjJ4BymGZI71Dfr4DqMtnKgRg5cRbIbDTpVdeoj0RhRGOF719HtxMn4hQKO
 DHKlnSDtowyChhsuliHZMQyGSvYQtM9wk6e0N6Ov1FR9NG3MlddfcBALtbbZ3oqIM5boq2T
 75+B4CT8sgGrun7dCIjOCkyOU09lvAvUbeP93NhxO/yfIT2zfvwK0CcFsh9dKNlQz2p0ekQ
 xUxt3DAMyLVacxBn7fuqYIVXTK5ZQM+Z5lwIWgR/4DgqyyMaC3W6L+Lm5XI8DBUPdEdvaR+
 A==
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

