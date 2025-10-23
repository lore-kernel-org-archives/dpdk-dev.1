Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEED1CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33A7440648;
	Thu, 23 Oct 2025 14:15:06 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id B4B8F402E1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:15:03 +0200 (CEST)
X-QQ-mid: esmtpgz12t1761221696tba4f20a1
X-QQ-Originating-IP: WnP0CIc1MkdfxCPXb831UyenPMjn5yGi4m9v2ScfLn0=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 20:14:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8686274265172762791
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 5/6] net/txgbe: add check link for Amber-Lite VF
Date: Thu, 23 Oct 2025 20:13:54 +0800
Message-Id: <20251023121356.21944-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
References: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: ONMinSPvVgZR81OpIoV91FrHQJsLIFK3SoUalpu14xSG1Ju3oQGZpzQX
 6V/97048w4mScRvY7HqbB+p6vTih65FgA4yphLDybbbOywlM7SFDdZxQjHiWNR38SLNG1Ix
 15idhPqm7e2W6tVg+R0jDyjADWpXYI2oTUNSKPZYu/Fmoc1aQOmYefcmLx5xuM5tfcuG0c3
 4Xi7DWb2STNHdHXwyo4719m1ab7DFz6HlkalBecnWgmNmHg9J30KEa7dZyDjuEYEPtHqWq6
 qBILvUM+1BljhKocGsfTmIuL+wXssLIqQ77JTNUk7KnZ6iiGWFJH5i4bzz/zF1tYGWQk4Hc
 7gQloKFqypmtJ7hw0mzto60WWqijWfiEBfBpdC8fjcXsrKzycCig5v1+oKJWtKmB+swPQuV
 Nh7N3H7FuNd8czFyoVmmMpVavklwuUG6XTERhHgYG1FcAJi1VWW55wA2xOzt4CPOQEtLPCO
 9X+PnxAMPZdwN+oU9WHAJPBOpMUKbvrGOiKiCgxkiLQoYiB/xpzvHFKJw5UObL9cnlkHeNv
 vKwc1OeDihr8uym8epcURqPK2Efib6ovhKVKZRMiB4O3chYEumQ5mJj/uxDorDEUloFQMdq
 TeyCnwgbop9pDdzBckZKkg2Q0mIU9nD9iuagfmUH/TOYqhTVqV0VFWb38dTEFM0aC5dM0XV
 iCwgOwVtOhNmklgIJXWW7gQERsBOjns0B/EN62zFkY1l70TKDKds+BmyI+KT9W82RQ6jcvp
 AugJoVCWeMO7H9xu145Ijz/z/eo9FcO9OY/D5F1Hwb6eZrwn+LfIJGGMLd7TmEBkyEoPtV6
 hVZq/CRaditqe42HDo9XdCrmhtp80z/VqhH0SrlMharYdLenfwG+SQzJk/j9S1eW3L0EOV2
 8wzemY1egKlLO2ZKzvhGFq+dMAaaj/U5o33JAHjXHD5hDQF285zkpzfMYXSBOVTcsYuXerM
 eChtJmB+e2o9Wf3xQ++6avEvzIdztUc0M6rYkvoc2yDYqbujRm5AOAeHOovLBts0DPZphim
 YnsThSrAgKH+c+lSUlXZOgSDftVTTC3X0BU/gp5lf2o7whjWpaKC86aUA23kcVAfSnkUi/J
 qOXdHPbSw06/yaUKG8WBAc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Enhanced the VF's check mac link implementation to provide accurate
link rate information for newly supported Amber-Lite NICs VF.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h |  5 +++
 drivers/net/txgbe/base/txgbe_vf.c   | 48 +++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 638404bdff..95c585a025 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1305,6 +1305,11 @@ enum txgbe_5tuple_protocol {
 #define     TXGBE_VFSTATUS_BW_10G       LS(0x1, 1, 0x7)
 #define     TXGBE_VFSTATUS_BW_1G        LS(0x2, 1, 0x7)
 #define     TXGBE_VFSTATUS_BW_100M      LS(0x4, 1, 0x7)
+#define   TXGBE_VFSTATUS_BW_MASK_AML    MS(1, 0xF)
+#define     TXGBE_VFSTATUS_BW_AML_50G   LS(0x1, 1, 0xF)
+#define     TXGBE_VFSTATUS_BW_AML_40G   LS(0x2, 1, 0xF)
+#define     TXGBE_VFSTATUS_BW_AML_25G   LS(0x4, 1, 0xF)
+#define     TXGBE_VFSTATUS_BW_AML_10G   LS(0x8, 1, 0xF)
 #define   TXGBE_VFSTATUS_BUSY           MS(4, 0x1)
 #define   TXGBE_VFSTATUS_LANID          MS(8, 0x1)
 #define TXGBE_VFRST                     0x000008
diff --git a/drivers/net/txgbe/base/txgbe_vf.c b/drivers/net/txgbe/base/txgbe_vf.c
index efa32ca10a..bfaac3bfa4 100644
--- a/drivers/net/txgbe/base/txgbe_vf.c
+++ b/drivers/net/txgbe/base/txgbe_vf.c
@@ -492,24 +492,46 @@ s32 txgbe_check_mac_link_vf(struct txgbe_hw *hw, u32 *speed,
 	/* for SFP+ modules and DA cables it can take up to 500usecs
 	 * before the link status is correct
 	 */
-	if (mac->type == txgbe_mac_sp_vf && wait_to_complete) {
+	if ((mac->type == txgbe_mac_sp_vf ||
+	     mac->type == txgbe_mac_aml_vf) && wait_to_complete) {
 		if (po32m(hw, TXGBE_VFSTATUS, TXGBE_VFSTATUS_UP,
 			0, NULL, 5, 100))
 			goto out;
 	}
 
-	switch (links_reg & TXGBE_VFSTATUS_BW_MASK) {
-	case TXGBE_VFSTATUS_BW_10G:
-		*speed = TXGBE_LINK_SPEED_10GB_FULL;
-		break;
-	case TXGBE_VFSTATUS_BW_1G:
-		*speed = TXGBE_LINK_SPEED_1GB_FULL;
-		break;
-	case TXGBE_VFSTATUS_BW_100M:
-		*speed = TXGBE_LINK_SPEED_100M_FULL;
-		break;
-	default:
-		*speed = TXGBE_LINK_SPEED_UNKNOWN;
+	if (hw->mac.type == txgbe_mac_sp_vf) {
+		if (hw->device_id == TXGBE_DEV_ID_SP1000_VF ||
+		    hw->device_id == TXGBE_DEV_ID_WX1820_VF)
+			switch (links_reg & TXGBE_VFSTATUS_BW_MASK) {
+			case TXGBE_VFSTATUS_BW_10G:
+				*speed = TXGBE_LINK_SPEED_10GB_FULL;
+				break;
+			case TXGBE_VFSTATUS_BW_1G:
+				*speed = TXGBE_LINK_SPEED_1GB_FULL;
+				break;
+			case TXGBE_VFSTATUS_BW_100M:
+				*speed = TXGBE_LINK_SPEED_100M_FULL;
+				break;
+			default:
+				*speed = TXGBE_LINK_SPEED_UNKNOWN;
+			}
+	} else {
+		switch (links_reg & TXGBE_VFSTATUS_BW_MASK_AML) {
+		case TXGBE_VFSTATUS_BW_AML_10G:
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
+			break;
+		case TXGBE_VFSTATUS_BW_AML_25G:
+			*speed = TXGBE_LINK_SPEED_25GB_FULL;
+			break;
+		case TXGBE_VFSTATUS_BW_AML_40G:
+			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+			break;
+		case TXGBE_VFSTATUS_BW_AML_50G:
+			*speed = TXGBE_LINK_SPEED_50GB_FULL;
+			break;
+		default:
+			*speed = TXGBE_LINK_SPEED_UNKNOWN;
+		}
 	}
 
 	if (no_pflink_check) {
-- 
2.21.0.windows.1

