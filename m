Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E1606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB59C40696;
	Thu, 22 Oct 2026 13:10:46 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 7161A40264;
 Thu, 22 Oct 2026 13:10:41 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667439t7edc77d7
X-QQ-Originating-IP: c0RoOGX1J3j/IqTPLLt87XntYLUyUHKS46xX/avFvYw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18387672604930316937
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 04/16] net/txgbe: fix incorrect link state in 10G forced
 mode
Date: Thu, 22 Oct 2026 19:03:10 +0800
Message-ID: <6C3EFB3D5FCE6724+20261022111017.3605-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MM8y6imCdjo5UfnYudoAevFM00rTynWx7N+VOn6x3z6CWM/wAr18SOSY
 jwpsQOMZ6w7HFFQwyo3Gm/OR3Hj2oFxhiA+ICPsw7qRKH28eJa6WPT9/lO5JF5TsAvBUVPQ
 GhdUYEz2oZ5riaeA3Thyhg1jN0TeRXtDBuGkJ/yYdtctnYskDbWyJ+GlXeKBQPatrn2H3e2
 Cm3BMjy28Ac84Nv3/B6gwQz9JsjYkk6yED3Itp4+OAlA0JqWSJgiZROp+bnl8x8s1FWpKMg
 64dNGuvWHcB+iW3Y5WiuRMVo7ihees95NXXDXrNkzv6/psD60HPu8BiM/H1P7ElwC14XOyh
 aY2rknRe558hOkrvFqS4ZcRbyrXXahVet0AaRZLzY/uxAaDPgzt8UZ2J0MaKzehzbFKipaN
 IAur8FNsyEw01ByLVbzQChxH7nNBTuIfrsA8AubYv5u54kEI4k4O/tyypkIRoVRBn9V/CUO
 J+DRK88Lt6hVnA1XjJYewc+Lg1K5bG8HO6TisSEbPN6R3TcGGX0aypPpp24JWSUhWB9GUBP
 Ni7wFLMV1irhifNt+SpltGXIuQKTGPJyMoBZH/X7stvRkIPIhuh6UCuSxsnH+yZtU4z7zfB
 4sT7SMFkaytWJ9ISD31wMHjEBdhtRYRviLQbmVjJW0IkLwHMwd3iMhRwtvFnP7jKB1iyCPB
 pDz3nMCZCGwjdVjzAF+Eaqw5t/dertAaRUtkoyoTP+Zo6tS5kdqU7fk4BqyyXYeF1OWeuDM
 BaHKfHW+0GQMaR3bw8o1X5FX6/2uk2i6Oyg8uGZTJjZVmRxtakQVOCj3R6gb3X/qWTLLoO9
 UdPDmTt0KNl0DLEft9PFIyspsUw6JNNPhbcPhmpJBQFIltT5VK+5y/uMfQn1MDxVdrdSM1R
 RRACP8mTNbBqCeMfRCaXCd44TacnsCvrHoWUtpva/OB/dNi9xOddIaEMb0mXQS/wAHeoFdV
 3+sRf8fRdDN3Pw6VFU1MFxF0Cm+ER5FgA5au4vg6WJf3pAEHxFrGn52I7lBQ3CCuBsH7oZ3
 pL9skmoqUxraea+hW7EzQ3k2TRsCbtB3Kc0wNEs95CzHwnZF1Co64hQAAyhuKK0PyggpVcF
 WzyGJOhoDz3VdIvub8O6eI=
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

When an AML40 port is configured in 10G forced mode (auto_neg=0),
the hardware can link up but the driver keeps reporting link down
after a peer link failure: link_valid is cleared on timeout but
never restored when the peer recovers, so the link stays down until
the port is restarted.

Restore hw->link_valid = true in the success path of
txgbe_setup_phy_link_aml40(), symmetric to the 40G path. Handle
TXGBE_ERR_PHY_INIT_NOT_DONE before the timeout split and leave
link_valid untouched, matching the 25G path in
txgbe_setup_phy_link_aml(); the alarm retry then attempts the
setup again.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_aml40.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
index 7476759d4d..5fa7c6a243 100644
--- a/drivers/net/txgbe/base/txgbe_aml40.c
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -202,9 +202,18 @@ s32 txgbe_setup_phy_link_aml40(struct txgbe_hw *hw,
 
 	rte_spinlock_lock(&hw->phy_lock);
 	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+
+	/* The PHY did not come out of reset; leave link_valid alone and
+	 * let the retry in the alarm handler attempt the setup again.
+	 */
+	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
+		goto out;
+
 	if (ret_status == TXGBE_ERR_TIMEOUT)
 		hw->link_valid = false;
-	rte_spinlock_unlock(&hw->phy_lock);
+	else
+		hw->link_valid = true;
 
 	for (i = 0; i < 4; i++) {
 		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
-- 
2.55.0.windows.2

