Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D5CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 12:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA2B0402E1;
	Thu, 23 Oct 2025 14:14:45 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id E9DE54060C
 for <dev@dpdk.org>; Thu, 23 Oct 2025 14:14:42 +0200 (CEST)
X-QQ-mid: esmtpgz12t1761221677tbfe729ce
X-QQ-Originating-IP: iMRc9yBPDhd0dkyQrqyAn7iFJdB8wm6pXvIEn5J9xP4=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.187.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Oct 2025 20:14:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12398237125250991598
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 2/6] net/txgbe: add flush operation for Amber-Lite NICs
Date: Thu, 23 Oct 2025 20:13:51 +0800
Message-Id: <20251023121356.21944-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
References: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MwqrwaLzgdebE8+yMTWcXeoOHSYCk6XCbzUthXyAzV3IK/pGy4h6bwMD
 gQHV1VYiUjmkIjT/jROItgszKlX09WHThbVHzzS2ThNrKbDLjsS9LOl/uNGPsySaMXmrdF7
 4CYUMHyc8JR2AO7dLj2xGEahjGZGtRafT+4/MwoEmmxkbJ7lBw4HMxMxjeefZBwOxNMA9+A
 pPJRUy1zy5MclL5nUSmEGxZxrxWzBvHo7DVbq5YXLgxIUag+BJ53TDubpUwya9l2P2moJs/
 F+VFXfBmC/Ncv3kX+QEZKOGYUMjlpZR/khvafPdZMV4IO8O6Wbasa7v1ZdTSVvHXO+vmUEN
 UewS/vr/mykzwI5E4AODfC9fOzlL/1u+J7iCQMVbRdXMSo76ZHMiwM/IZUHL0CJZlD7wUuv
 jsRIDVRQtF/doGtp3pycMuG37LpFh3lJ/awiHnhLVAAPi+CV5iF357RSQZiJTHj/lMF04vk
 IyA4fJaI/XtOk6BZ9u8kdbxiLvfGNxD/5WByQAvK0HXUrYgxII7nUWr+YvPZWfSpISUeVmy
 /1AVFbsdHSquq4JahaCgMALun9e98C4pSWnQwMeE6upWrdQtm67i9oFCKOtXqjfVjUDSQRX
 TGzKnN0aynSpoHSq1ydY7ndmy8LpXTYWq0Q5hBb2D/vywC8mRZ62QAV1/CChiq9L2svxfPv
 BAr8cZ168oGOobULaVqe+nSISlqQ2qyqsBvEIe9dj4B0ENgZ6biu8cuVBNAnmD9oTsJAbqQ
 seNBg8lxQIrBra9zmGAest+sw4YJCh8M8hOSa4zosUSJJqv0T4iZiFZqe++tfX92b7dOZFl
 KNoEbQ91/1rVbuvOUmOgKRQWrUYm23kSMepiAEOCNQ4Zu3NnH0rKT6BM59VAiugqaMouRwg
 RnafsjspRQXxWbY6hs9eLNXCduNHCiLAo94NMJIEcsWLYd41DNBL1kid8+3t6yA6eBz/3uy
 SPfN0D6XihrdKF3KCGSKk9GjteZcrvDJ35PWJJ914Z7gWrJAdZGs+tHW4a3Y7Rv5I42Nf00
 UQ1Bq6fx4mDvCClHZtYJpSA3cGBXl7OXEyMgqqOjAytY+GXROjoyfP/n31XUCkCj7jrcXwD
 kW5P3S0qHO8
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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

Add flush operation for AML NICs to ensure configuration takes effect.
The flush forces hardware to apply new settings right after driver
updates. Missing flush may cause potential negative impacts as
configurations could remain pending.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index f2e4994863..505e42a666 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1997,9 +1997,12 @@ static inline void txgbe_flush(struct txgbe_hw *hw)
 {
 	switch (hw->mac.type) {
 	case txgbe_mac_sp:
+	case txgbe_mac_aml:
+	case txgbe_mac_aml40:
 		rd32(hw, TXGBE_PWR);
 		break;
 	case txgbe_mac_sp_vf:
+	case txgbe_mac_aml_vf:
 		rd32(hw, TXGBE_VFSTATUS);
 		break;
 	default:
-- 
2.21.0.windows.1

