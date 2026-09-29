Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2946ECA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6514427C4;
	Tue, 29 Sep 2026 13:22:00 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id D769742788;
 Tue, 29 Sep 2026 13:21:52 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680908tc6236dea
X-QQ-Originating-IP: 7HXxXSFoZHAi+emzdyAqPh2/9EZFBhVLxzUEJp/cW98=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10993360434712900004
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 07/15] net/txgbe: fix link speed display info for 10G mode
Date: Tue, 29 Sep 2026 19:18:07 +0800
Message-ID: <A8AC74B2D995CA9D+20260929112119.4516-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NFUTM+rUdMf53xS6zzMOf22h6eeLPvT9nxB/gyC6nAHAzQtLU1Tc34xk
 bk5b4Lev+8OyaGGAgaFlmecJTDLum2KQABl9iuuGjUlpVtUGoRYPPR890SumhiT44MB03uB
 WbZtF20bxSAumWVysIGuu1aVmsAommLIEhAfd7aPaC78wV1LiOLQ2j/neLmwuqdKWaW1Kah
 u3rr2FuaslXBQNlAqtvZcXmrED1BoJGXFOFyLnjhqbA9VLm8DqncWCizjG28m//RnQkmCW4
 y80aLPKubEsdy89niPh1QPeakxzlI4LxVRYvoUjD56zrRuTKGYUIvsZ1vy7kbvU8rYVhk1W
 tkzLm3ZuaSiKS3BQx3+eIyk5nfyCuCGYalEmjLiFBR46TMQ1Rr73R4MNtfjo8d1AHJbVaph
 dWlqtUj5+frLeDD1NW+QLfYdbqu4HUm2Gu/YB+KuHlwCamCiqdJJYTZZskxqtn/wzr7lbPK
 Lx1/o6ibNcGbu9DBBHd0BOdzVYL34jhkjGFNmyzNDuxz0cV/z96A2KPrjRtmse+S/HkDn7z
 tvpbi2Rosnn+WMglKG64yESOB3GiApXvNxzfebUyvGHfqsm1fVRGyBTu3ipgRuMtaQVy0IB
 FlOL3hhMMGdcfa525WAIhkKT5aiVnWa5cBRqS1kthZaTkR7Rj/wKRz7at/CLCBITpH2hhpl
 n16NqVt7GR6sJcouiV2FBvrnWuWgZFlU95xdFkUxIvU/lC4L6UCGcwwwgjLJn6sB+5Y32P3
 9h73V1yiIS31gljNsnBW4C1QtI8TPurJ2X+fNMziF2LWVxaZgQp4GaHllyqgg4TjWkjzAUD
 3F+GSjR6A4i42y9VdzAFvCL88wWtFPpE5476mvNX6ACYUVmdCBbZpWu5CNrpZyHDhA1SkAB
 GK26sIBNo1MaEa1gnApQ9u9Ix2svJpzCiRSf4/neOeP4RM+wQjW1X0ze3j/c02r2UxHtkH8
 2cy80waZnVDuxENuF7CQ4Uulx5smIBRaiRhwcDENvJ1uEJKVI9PD3Hde6WJ3Zo9Fp4O3dVp
 H+3dLiVEWCP+lyzaZtMffD7xAo5y3XjLvSdfNsWR9JqeRk2pLF6+4X2s49ojq3rp4EpEIOx
 Qps5zgKk9qqmwxaDCS+01dt09MTqT7vfA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

When an AML40 port links up at 10G, DPDK reports the speed as 100M
instead of 10G. The 10G link status bit is not recognized in
txgbe_check_mac_link_aml40(), so any non-40G speed falls through to
the default case (UNKNOWN) which is then reported as 100M.

Add the 10G port status bit recognition, so a 10G link is reported
as 10G.

Fixes: abf042d32b39 ("net/txgbe: add Amber-Lite 25G/40G NICs")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 5fa7c6a243..d812adac69 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -85,6 +85,9 @@ s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
 		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
 			TXGBE_CFG_PORT_ST_AML_LINK_40G)
 			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
 	} else {
 		*speed = TXGBE_LINK_SPEED_UNKNOWN;
 	}
-- 
2.55.0.windows.2

