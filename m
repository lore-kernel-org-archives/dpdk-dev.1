Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C4A606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0B9A40A77;
	Fri, 23 Oct 2026 13:08:08 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id DCF0E40268;
 Fri, 23 Oct 2026 13:08:05 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753683t539bbf58
X-QQ-Originating-IP: QpbnzwkyetZ07IDnm180yUmRnhkR6UAVRutEtj5TRj4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:08:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2001751452877246669
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 07/17] net/txgbe: fix link speed display info for 10G mode
Date: Fri, 23 Oct 2026 19:03:45 +0800
Message-ID: <86BAE47CF944F0FC+20261023110728.3975-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NjmmThNX+15vFCpHFS0FJl7EaJCsQq4i9Yotg1dhvVMNjgvrnbcrzgAN
 H7teIUayPQDOb2Mp1JEkbjroCFLXHxPTLMOKhyUUsF4bE+09VXTueQkSZ8sMn8B2b/toWmu
 lmVsBYCFwrOe7NtSRsKJIcG7T9abBnnmmJE4PETTtYFDFZibuCtOEJkSOUo5JD4ISUD5ey8
 fgt/qKfvdmixP0RdqEIjuI09cmOdkD2tARjw52CiV/3TjyGGxZoZyc6GvGijc94W18SJJzP
 J7M/eAE8sVDj4K3MFhdCTI0wucqMruOTK0NU09sjKZBR1u/iZ+l2u7NRYcdPGcMYs6JJ26Q
 8USAxAekE/l6B8gWlEhnoR2sZH1yCNnC1nxOggVKoHHBiWnj8hcIHZxSHHslvcyD1FTqALW
 NeEMabQs9raN6i1YLT3gk90EZmLga9FyE45plMLAu52wNAEPkWloGt0IT8/TBTuHm0kwrlC
 aBYC/lSS0bSUvo9twwnSa+T6CnBEVUMG4SvIdb3bOApV4BQKb5NOPBYNTYinXA9RTH+6StB
 O/BRlG6mgWwURV/Womf/kveTfF0Yx3BHSf55VnCBOoSpbJIlo1RGSa+j7Ff5rgc00CYThOU
 CWEgpaouMGOSEVV65J7tzz+zuVgWeHj0SB/HOKfik54yp+PQ9yPqXAmcoc2rDrFKtjR2VJ8
 zVWHVjbdnPsPi7OME3WWP142zVTGL/H40Rf5jtwMMEL1toabDkUXi4GE1l7hZGV7Xno9kt/
 Ta6H0q9dEH8Z0v/iBXIroDU5XnaSlcRWGKx9st1sm5x6auu4BF97tdBI/xngrRv8N9KQmuO
 skE9EQa15m0rbyWeSk8HXU3ul/N/L+iQ64bTyaZAbb6/DYBLZET4loOQJSOD6hojo1trWwb
 6hmE1AfA0WCvoRVjfQGPqbP0IyM9VC/62gxTBz6BfeDkn56LqNzTRg/mGaeZQQewF3nSavn
 lemUteFovkPnebhcYTww2YtPKsxu1FJw493Jn9AztTd4kLVz9z/CODhZR4hEdZH9HKpKd5N
 q2AAezJdXk0IgRzE7DyJGZ+lg1nWirMaLrLlYA7Zw8To9qMTZS/g7PeN97gra8lFadRlRNT
 dck4mvqG2wqjczgaBEetZOqaeZr/0e104pgEhYSMHyh
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

