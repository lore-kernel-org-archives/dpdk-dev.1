Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95211CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:11:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE4484065C;
	Mon, 22 Jun 2026 13:11:43 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id E61A44003C;
 Mon, 22 Jun 2026 13:11:39 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126697t432ba88d
X-QQ-Originating-IP: UXMV4YrU/j/rLKlD+Rk51VG1ljUPOWfouRjx616EX+o=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4766000454688221888
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 03/21] net/ngbe: add missing CDR config for YT PHY
Date: Mon, 22 Jun 2026 19:10:51 +0800
Message-Id: <20260622111111.21024-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NFYMAd71kXCpIhHg0Sjh+sO1XXbS9diP6lPVAGFuWmFNQReWgWQLMo9g
 FneNCKthyWYohPxxkqG1PL/AsljHKC/IIEjVjCOpjaH6Vbj2So/WgyYP24w5WSP3CoLCSgO
 NuDb/QB22Pn3emV4GIdOiCFcb3Ly6R57tZmh/J4DC9z3FySMMHC5ztENOvEE1pe2RHFpHXq
 Q0PQs/ywo7Eid7DuSsn4EqAOJif7IukfQ/XlbsqTzj72ksH35+F47gXXhHIgvyGTqeUsHGV
 qPRlo+88J1+jgrTKFmOPO2zpCOX7g4azCsV1oeYqUiqUL+dmMpnNabxNNOlAXfEBC6NKEWF
 8VSz3KkhNfLsPt8IRd/9n2OMU5UWT/n8uykr1Mm9VImrwozOP4GK5pxYSrxkcyBKgzOsDOE
 B2oIF2nQlTsZ4HSmFDAGT7y/u1NKVD/EBZWFrcTfgfiHssTmKrVHipR75GPIc0eAGIz1szc
 aCGSwzEDyg1EA/SexwEEJT6LA8vDNzF8lSPfKSY4hxh4IYIiYBPFvTmjdynKVHcFnfpz+cE
 rJIGJWE6T9fgi4+6aQ4byGaUKwF3JdAIaoHjTnfQi8OwWq3Pnd/aj6Y1rzIqkmLHo9NthPG
 TZcmfVbsvEg+jELWDc/FajN36h7hqOLx15QJHT//oX/ClzuHGcsyEtgyzPclm0i0+EHj4TB
 3qClgxDbFNiqqh5cWVnqTWlrPTkrAJE16gFtpniTPacSbIA2nMUfVDTVR9XUuzCTnmY+pVg
 m6GCIi/1UAIJndVGKS/9zEO7aCpn5txLio2u/WIGHBVA5ZxW6jcwYTukbFMnIlTOg10Rh1n
 +OX3zJW2v78GYrQ/vSJjFqdBMN2THNShVFYkoKwQ1Tghgpf58BE7qA43QlHloJ7ac2l2eng
 VqKYypMPGk4FVBnd/NNHpigTV534yeCnOene5rVgziXWfSW2+W1a+8ZOc8WJlKi2ymZlAb4
 JMecAUpIMdSWvmCuLEYDEWVrh0V6RkAdtOFI5lglnwxB0JYy+9l1Ku3GAnoweRl+T6fWwfR
 f/fOPKYYBufkJ6kgaQc58hvi2wZ941Z7ly0SihfpjNaOflNs87rUnpQgMOqatdoZmA6p8ic
 IhXQpSrvr15f1KcAiBn03OgMTB4YnLo3wzerOq2wXIy
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

According to the PHY vendor, when YT8531S operates in UTP-to-Fiber or
RGMII-to-Fiber mode with auto-negotiation disabled (Force mode),
additional CDR (Clock Data Recovery) configuration is required to
improve link connectivity. Without this config, link may be unstable
or fail to establish.

Fixes: f1268369403d ("net/ngbe: support autoneg on/off for external PHY SFI mode")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/ngbe/base/ngbe_phy_yt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ngbe/base/ngbe_phy_yt.c b/drivers/net/ngbe/base/ngbe_phy_yt.c
index d110fbc8b2..ab0778d246 100644
--- a/drivers/net/ngbe/base/ngbe_phy_yt.c
+++ b/drivers/net/ngbe/base/ngbe_phy_yt.c
@@ -264,6 +264,9 @@ s32 ngbe_setup_phy_link_yt(struct ngbe_hw *hw, u32 speed,
 			value = YT_BCR_RESET | YT_BCR_ANE | YT_BCR_RESTART_AN |
 				YT_BCR_DUPLEX | YT_BCR_SPEED_SELECT1;
 		} else {
+			/* force mode need to config cdr */
+			ngbe_write_phy_reg_sds_ext_yt(hw, 0x3, 0, 0x1434);
+			ngbe_write_phy_reg_sds_ext_yt(hw, 0xe, 0, 0x163);
 			value = YT_BCR_RESET | YT_BCR_DUPLEX;
 			if (speed & NGBE_LINK_SPEED_1GB_FULL)
 				value |= YT_BCR_SPEED_SELECT1;
-- 
2.21.0.windows.1

