Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF14606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 107D140612;
	Wed, 25 Nov 2026 12:12:14 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 7F24C40374;
 Wed, 25 Nov 2026 12:12:09 +0100 (CET)
X-QQ-mid: esmtpsz17t1795605124tc8128adb
X-QQ-Originating-IP: C9YLjx8zdpMXN3AL9ov/C7DoPVX2vOJF2H15AWQULus=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.235.140.99])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Nov 2026 19:12:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11484980266981741526
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 2/2] net/ngbe: fix YT8531S-CA interrupt in combo mode
Date: Wed, 25 Nov 2026 19:11:05 +0800
Message-ID: <55290577737DDF3E+20261125111142.12226-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261125111142.12226-1-zaiyuwang@trustnetic.com>
References: <20261125111142.12226-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NQR8mRxMnur9KSSJplV/+qm85ngAdV/Rd98GqLyCG8pwFu6jErC7mewV
 I4xxGMKBixzaUHok/d+ETAoSJE/oD+D38EVBCUgPfAcwFAd61QgytpA7tGRMRITa5moVCA+
 b+fHCQUyuryXxgohEhfVblMtBm8hDATKUL121wUHZQEoGd1je8uFXZXYErsca9nr6dnb7od
 0TdwK2CXkz+apfU+bOpR8NKMrILP1xo9jc7w27UFYjkpdsQpcQCXieuhktmhZilzM7XGQE0
 4uR/iliZX2NoGn+EhDrfcOsWI+uMNnBhVrAsOT8Iicr2peuH+Zba3pjPRhUagWZY7cPSLLI
 yr38apsE0+JMF8xCKrvvWOUHvbNNIqJTAtWoIshvc27m7QaCj3tN+l3QrBg4MPea/cR9z5O
 x5iASr6MUC5a6p83Df8KO/ksu0ZR15FAsKfYVUEy2I3XBVWY0CCZSQm7sAMx1u+A4xVvk+v
 j0D4T1hRlO56k/xXpjiuP+EOcUk5J9TVwpT5WdVbSbyeefr0PXCZ4PngNR4Uk7RcGInrIGu
 ithDIqFtHOxJIe51xkiHOx9J1rHpXTdLgQqeQiQ61xJi+YBJJMLGOWL7fkMHRcwJmJnL7kb
 v9QQ960fRLS0gSkUNGthJE45gXC1lFtIML67u5+3+zsgm7ZIpsJ7jKPvw5zv0kEFPxcyWHc
 23CgkcXqeLi0VTzd5kOHG4MZCMbb2GLHkSUh1V9FfITzr3ritl0HZdubkwlauOYWNismu16
 RVSvYY9wK+cy35rH51QUADcLplcwm/OItkk/PRij1E9dxcs5v4yUbbOS7xBdu8Af4MuX9ya
 hS70MpwsnC2hy6CYjBP6tg030MpliCWbug3E9Ep0ZJlYrSTHekEPoFqR/QwQY+rwmUZdkrf
 ERUgRWU4Sch3f8uMf2J/V9Wxe0tNLdKtzOgIil7GvLH+901ylNDbbFBMBV/u7DpO+CMugJy
 fO3aBEOhhSR13x6uB1V7w86SlQfdYO12W83F1YJNgsCAJqKQ3mh/+Z77Fum6rhbIuQROqQr
 OFt4sVb5K3gGDrLcIenriMztWveayY6+5kO7jfrat4JEGI+64h
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

With a YT8531S-CA PHY in UTP_FIBER_TO_RGMII combo mode, the copper port
raises interrupts and links up, but the fiber side raises none and never
links up.

ngbe_init_phy_yt() enables the interrupts straight away, without the
extra configuration such a part needs. Apply that configuration first,
and skip it for parts that read 0x31 or 0x32 in YT_INTR.

Fixes: 79be49dd2d65 ("net/ngbe: add special config for YT8531SH-CA PHY")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_phy_yt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_phy_yt.c b/drivers/net/ngbe/base/ngbe_phy_yt.c
index ab0778d246..f9230266e9 100644
--- a/drivers/net/ngbe/base/ngbe_phy_yt.c
+++ b/drivers/net/ngbe/base/ngbe_phy_yt.c
@@ -100,8 +100,25 @@ s32 ngbe_write_phy_reg_sds_ext_yt(struct ngbe_hw *hw,
 
 s32 ngbe_init_phy_yt(struct ngbe_hw *hw)
 {
+	u16 value = 0;
+
 	rte_spinlock_init(&hw->phy_lock);
 
+	rte_spinlock_lock(&hw->phy_lock);
+	ngbe_write_phy_reg_ext_yt(hw, YT_SPEC_CONF, 0,
+				  YT_SPEC_CONF_8531SH_CA);
+	ngbe_write_phy_reg_ext_yt(hw, YT_SMI_PHY, 0, 0);
+	ngbe_read_phy_reg_mdi(hw, YT_INTR, 0, &value);
+
+	if (value != 0x31 && value != 0x32) {
+		ngbe_write_phy_reg_ext_yt(hw, 0xa071, 0, 0x9007);
+		ngbe_write_phy_reg_ext_yt(hw, 0x52, 0, 0x231d);
+		ngbe_write_phy_reg_ext_yt(hw, 0x51, 0, 0x04a9);
+		ngbe_write_phy_reg_ext_yt(hw, 0x57, 0, 0x274c);
+		ngbe_write_phy_reg_ext_yt(hw, YT_MISC, 0, 0x10d);
+	}
+	rte_spinlock_unlock(&hw->phy_lock);
+
 	if (hw->lsc) {
 		rte_spinlock_lock(&hw->phy_lock);
 		/* close sds area register */
-- 
2.55.0.windows.2

