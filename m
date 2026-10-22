Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09867606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4A0C40693;
	Thu, 22 Oct 2026 13:10:56 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 6DDBE40A82;
 Thu, 22 Oct 2026 13:10:52 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667447t7912379d
X-QQ-Originating-IP: 99yoTVQZERatZrEOjWxTndKqGO5dUUUcGq6oYO0jOaI=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4843577966528402815
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 07/16] net/txgbe: fix link speed display info for 10G mode
Date: Thu, 22 Oct 2026 19:03:13 +0800
Message-ID: <2723C1B897067C17+20261022111017.3605-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NjuDfT6zrIZcY+yqO9u4erchpgUx+FvFeQZHGI1pmF/pk2ceM9Wx6WS2
 qLoEaLDOWGxEMgWgxz37wzoldAvdxXNvtLQSK6u6okncWl+Zow0TJps3MhNjQU4v/9N+FBV
 +IlopE9HFJh8BNlkdvh1Pf7L36BD5oB/wEBYUvlmprxNmuZWTXk7WIH4rrKcKshUPyqoKPU
 yyDoniz+EX6jsk16+By6Gz0cqZnKYAtsuP3blOWxOv5vCA37RVdyPCpRtIqdsUApLirICGm
 kogJHeS7FVTBaaZ2kBX1pNCG5FnWvxMaCwaDWSCKiiavqSl2ycF1WUz6vhjoEsV8ok+IRgF
 lBUyYZSTKPJzcxnYwFkDDkY9iXANNTrUgr07r+jJDG9DZtzdZ8d/MUrdpqw4m/IKDZ3lBsc
 vBv0k9puRxlVIKkxWNo+chN/ptldUprmd99nblKxUmRfSr6qL05rStiM78hvCqBiWGcrLwt
 gOA7bNI/5ug9nFhBhgBRYd0GqP0j7pxCdL7BwUIG8Vvzxj70RGZFNchOHHf+UVY478p/AWn
 slJqWgVAEXmAXoZhJD08TIFO6Njkc6Tvk6KBdLxniUA4WoZWB7fpV5Rw6svmStbAYl3Jdwo
 yLbKCNphA/QycxU79HRKWEWRGabV9XZdE3gHZp/cvo+SauhBE+C6aHbdN0mcHChIAL1Q+kD
 i88NQV4xb+A+nHHWebtKZGowNHkJXmPr2xVLmUGyAYfVI7KMx5qtqoZuftRTEkaU0Puv/4U
 0S3tS5A8HVm9EawsoDUzwEljSjY+r8e9jtoUm6EOWu2TkKVEIh67VpiBcB5fVp3f7wb7aN7
 Gj/Z2beOxFv3TzQYhQPhPua093KbJGGmCIFIirlTP9zIg36695pDTJ4s5MAI2L+ePhpNWHP
 A7m9bB0RpC3sLWYUfG163Cf7pUi1AvkasD07a4UcZ6lj4vFFz+9z4/AyfIObKd8phxgs2wT
 euj0qro0NM9z8V3v8cYNkUAmnzj+wUPhH8WxZ8bsn0wrYLhK62IpLI3wmcfhmABja3GannI
 HzXYRzCTJ1sRxtYqn06OcnKPHfeTWYck/pIRNTh4p4+uJ6ibLk4EuMwwe+Ef4=
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
index 892dddd373..b52702b197 100644
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

