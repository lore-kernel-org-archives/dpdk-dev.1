Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B428606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 968D0406BC;
	Fri, 23 Oct 2026 13:08:03 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 1C80640647;
 Fri, 23 Oct 2026 13:07:59 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753677t7ee2b18a
X-QQ-Originating-IP: rTG/MsxFyaCpMbhmLks1KnRS9LX8kHcLB0wfYtWZUxk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:07:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9694675697278796311
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 05/17] net/txgbe: do not force reconfig on link retry
Date: Fri, 23 Oct 2026 19:03:43 +0800
Message-ID: <AF7D4CE901F72480+20261023110728.3975-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MZ9fszcLiRfaj97eAoeBOQW7heg0AAaOyidSHK5SOydnxuZfEx/2CBQP
 pCDxxt+ddCoeF3BXm74O7FObLZNWur/Lycvak2WHEBBq6R5hRWUvm3RQEsTvVeKmnKPPYx6
 uBm7XQuJh//JJZN0ZFV9PKH23BuLiNkYUFg4VwPKFfHoBojlC3plWf2h/KaTQBRa7M6/iVq
 EEIbeKsl7ndZbTITE3CdZC00tFxe9ma6fv6X65FGq+zpMYEIoM9tJVHJ0CmWZPG2kmWYvVn
 u1nHgBi+zQtykWhbd1Xy+RxZOkDQFLLNy0gCYU0NsmmzZyVqbQN+P6MPJKn1JzYtNTfHvlC
 qkUX/yqTy0UIoedcPcTuO8H/wyGO+ggak4OpBf836WqD+ck/mwsDWWYFBwXWY2ISc1ynbs7
 kuwIG3zVXB5A8Lq9qGBQO4m0AhaG27QcxrnqfEE9+b44/HilSvmKWt57dgOS+CifiUOOa/n
 oPOSYYMIuJHc+PXcWqJh7KZPCTr/fldx33pxqdbwnm7t4VCJM7clo6mn9rvQhZfnGhulWcl
 AXsPF9pXQmG6YzUpbbB8GDXcIqfX4BejUVh3DgA8Wvq7CtXFjY+ReN9FOOfzU80F03M1Kvt
 wh2RRdFzCo0n9I6ddZQ7f2ZkfjvtmOI+mAIKYhrANMlUeYaH3n3OA1tspxvoHSKrYxAltDi
 oibQCHBD3JLwR+60BGC5PKeoF9rNMX8YdeB2E94+CKII7CsFzAs8jH0VIxFNXEkFCv4xc+S
 Gc4chBt4/Aefkx1V1egFhf6B0bM+fDuFJjYJIRdCaZ4397PArbcOP4qHqHyEcCw+zVF0LFJ
 tqJZU5U1ejZ4gz3m/8oG5yTvcwkrZJaQ2GxA8G9Radu8RiO7Dglo275ZZJ8yMzu6G+SAeQs
 ZRx/QpCFeJzIN0Akgso6L+aus2qB9Sk5kgI5HXz9oJE1hD2DuOFwVX/cJdmvRZrqF91oa3u
 mQxA3jKu2fZ9IqIXMZmokrZ0fNAc7jWJmPTx8LVSTwCfzqYuupUaV1xK/7llWfwlM/vOsJv
 WBekM4baPZDnWfHbKOTOpHf8hz/hoXI37EWPH+F8i4WXWn/RhaWyaUBMQQCnnzy5cXymuZ6
 w==
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

