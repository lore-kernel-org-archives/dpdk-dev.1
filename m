Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B44606A330
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F8784060C;
	Tue, 27 Oct 2026 12:42:38 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTPS id DE38D400D5;
 Tue, 27 Oct 2026 12:42:34 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101349t4793629a
X-QQ-Originating-IP: t6KBBJ+KcO+qWaQ+Ko2kiOb6jbXVonCUDvBTs2VJ+lg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12888587346072829179
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 05/17] net/txgbe: do not force reconfig on link retry
Date: Tue, 27 Oct 2026 19:38:21 +0800
Message-ID: <ACAF4DED64E0E17F+20261027114218.9724-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MAV4M+M/KN870vzaw7jhB+lF/ZR7gObnW2zplLwwo56rqHsPScm2xjis
 rjlPwiL6Q/FbmUNU2HvFRE+oEepqHV7iro/ssbz8JLmTWwTY1QzcjccTi9oEtSu9gXdfWoZ
 R/UKrsD/yur0AgPkZ8lUlS+BxwZ885CAY4llEd72L2HqZuT1W/oJcYnLj8XdnnnktNl3nMg
 qA1i3LSYzeRpZaTb/lxrhndm/HPd7u9WjsGKSI/sTZbsb6758ChX2xdFtdEf7fxs3dAUEX/
 Sa14h+v/tr3arK2eWkRr5IHfJdUYEc/5VW7QrMPLLZlbtZkt4IVwql3HWKKmJkgq0TsKLBL
 kEfEoYw//HM+lovpZDlLy0fePfPuX+MrCsosRcjfNzMAHTT7jhIB7lxsYAURHDEVditwDFS
 wSVSNCc3GOFbPuoM3GHm9RSmrt7VVY9cQmrrBLPRiM0KY0R4oB+JVvtflvYudvPeqM6Wkgo
 pbaCsPKJO3q8k/w39lefWmrRCp+upVcusF5kHHUaVXlcrSbf1bTG/i4JHJ+pgM90gGsjrOE
 v9+iAc9Ox4Mdmt4yi4WRoMOcIofVMU1GDiKID90ptrl9N7Y83iWi9lHATWyaPbGYTcMYcXI
 Gi3CNRot3wnYBdu9Havsa3HPKsYz1o+FIJVKN/q8NpOt7SNgG+ZfA1acFdtiIxaxCDs25JO
 KMJgxACXXRaU/U01EsnP//dvXmKo3QzucYWA2X7kwtj6Hr2hejzFlPd9DxZvVrQ7RJANBjH
 YJXRqzZfXSZPBY4aoqiaD7BbMaVtbvX15W9W5dXsD0rYleSuKVLZ+zYiDNPolq0RYXe5lfP
 VhJDe3qTjuGuQltZoXlnFGMT6ZdbUbUCduSNdZoZCTdbnwkiZOQW1WEjW1qBUugXkPj4HyW
 s6g5L9GQFHTM5IcqRBAscWsMN6AAp9mMMv9C2bvY2PYNyU6w3dxizYDlpfYMuMJdVzMfOuH
 nzc7VtQJiqQXOj0uGe5yVFmKaq/WJYyM0vUkQ//dPIrFtgGIARUTTyyZdPecz/nA0Ri1MZX
 dvCjREgjWzdRLex0IvDMPo0YVYdumcbFhrIE14YSxprWAMCix7iS68lUrEt7VUQLFdJOEY3
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

