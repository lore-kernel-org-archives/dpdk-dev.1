Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C699ECCD1AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 03:32:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 922FE40151;
	Thu, 23 Oct 2025 05:32:23 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 24BCB400D6
 for <dev@dpdk.org>; Thu, 23 Oct 2025 05:32:20 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1761190334tae69d13f
X-QQ-Originating-IP: GSdXTxuW/czxvqpHOoPpZauu/qbXUWgeZ5XslQLSV4s=
Received: from w-MS-7E16.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 11:32:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1685509925345953475
EX-QQ-RecipientCnt: 2
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] net/ngbe: support to identify centec sk21101 PHY
Date: Thu, 23 Oct 2025 11:32:07 +0800
Message-ID: <4BC1A3490B167701+20251023033207.62299-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: No4GWyI4cWt6ELlR6tgDaUm3ETu0Tm/wOBhpFKcvEvo1BaRzMPNCwq1b
 kif8enD9WsZ9OHY+AdaNEm7m/lJci/XdmNpDGhT1RCQC7GF3UYr30Tw06xBEYws/Tj5Hfv7
 8Wurjr+SalV6RQRKBks+DBPH8Bp4xFXggKOezdFjoSh1cpvCxnHaFz73Vr7uRksFJz/ZgT6
 KAlXsdKyoktCNog5duaiYv0kxFHV3wvrDkARzvsfiP40rVANkkwrOksixCjzHqtbH1ME/27
 HV832Ajlss3hi2poF8xIU9Uvy2qsQx3w/n+4s4QX3oWnWESJQBUYiH4LCigzQlNM3YkCH9l
 WfCp3+2yQe3qSLsU8WHEKbirkxt6saVBvkVkr7S4ErIFlURt2JSB9dkGyBcL5GDyDuxLue2
 CMXHqZPAe8NbZ98ln2Yyp1R+fJ7Z8Mm2ge8PaAwclv0tu3jK2WngvLAeV3TuRi8B3vulf+9
 lERqfub1DYepRmr3f4DImnaphcxB6u+sZs4RwOy3lvIa3+Av9UXd4CsjW2kVhFjvj23T28I
 Wx/I5ilsokVd+f1EF5T546euUCJxUbHLY4E8Ao7eEytW967Z2WqlOpZjEgdwtR2bKrO9wVY
 WMESmHijnaz0nFMXzbTUF9BU2gP4237ckWIkRnH2/zy2LZH6y/spPP6/3PRWzRVHjmco7YV
 fZYt9IIGrdRvtrtRh10C1tkIkYH96poG6A6R5zzvrYhuJqAH2y5rBDY1Q4zRplsY6xJ91iU
 UD6Bz+SnvbCjk6pGq+MuqVgTYuJ5u2PBdrfNY01RMMwMBs2x6JY0FcC1zhS0oX7M8a+5P8q
 FALsLi4S/E8vDUIyS+ael/5QsUv6l8/qT4O3sPtz4bK4uw5NrCX6/fJ6PSV7eotuVbiRiig
 wtnuWknM2DGDHmTSksechNw5fUAJYwudJEtktQS14IbWj4rN2rVcZSkQeocDP4nS5uTD32J
 4BCt/59d9YeWcFBcDhcnDK188pEIZaSKFcdWb/SJfjzAxOpviY7fPark6sTtJeFBYMYJ2ox
 5401hTSX6BSFjP3RtJx03z1vYswX4=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

Add centec sk21101 PHY ID into the list of identifiable PHY IDs.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_phy.c    | 1 +
 drivers/net/ngbe/base/ngbe_phy_yt.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_phy.c b/drivers/net/ngbe/base/ngbe_phy.c
index 6b5c1e47df..4109aa25ae 100644
--- a/drivers/net/ngbe/base/ngbe_phy.c
+++ b/drivers/net/ngbe/base/ngbe_phy.c
@@ -182,6 +182,7 @@ s32 ngbe_get_phy_type_from_id(struct ngbe_hw *hw)
 		break;
 	case NGBE_PHYID_YT8521:
 	case NGBE_PHYID_YT8531:
+	case NGBE_PHYID_SK21101:
 		if (hw->phy.media_type == ngbe_media_type_fiber)
 			hw->phy.type = ngbe_phy_yt8521s_sfi;
 		else
diff --git a/drivers/net/ngbe/base/ngbe_phy_yt.h b/drivers/net/ngbe/base/ngbe_phy_yt.h
index c45bec7ce7..5645af824f 100644
--- a/drivers/net/ngbe/base/ngbe_phy_yt.h
+++ b/drivers/net/ngbe/base/ngbe_phy_yt.h
@@ -9,6 +9,7 @@
 
 #define NGBE_PHYID_YT8521		0x00000110U
 #define NGBE_PHYID_YT8531		0x4F51E910U
+#define NGBE_PHYID_SK21101		0x00782010U
 
 /* Common EXT */
 #define YT_SMI_PHY			0xA000
-- 
2.48.1

