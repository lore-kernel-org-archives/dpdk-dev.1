Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267C606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:41:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 192A740A6D;
	Wed, 28 Oct 2026 11:40:26 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 9DEB440613;
 Wed, 28 Oct 2026 11:40:17 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184014t131fa74c
X-QQ-Originating-IP: 4hY4ttu0S0h75mbBuo1tXm/2lBPwSRLjFFUw9apuAjk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18200269728715611971
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 07/17] net/txgbe: fix link speed display info for 10G mode
Date: Wed, 28 Oct 2026 18:33:56 +0800
Message-ID: <9539EE11BBFF478F+20261028103913.10188-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NEJQrEAwC9KXgHExtFgMezt/ZLs1VZKMqm384KHPgO/vDEjKryfRfQNl
 v1vIM2JpqB3lx07dIbUVplkj/iR2HSMR7plz1gsDBbQrqbsLUiJW0Ffs2ydMLW8VBfAOcz8
 iEuRglE40m/nGUafMMwSvN9rJVLvasvG0FXeaBEjs10LMgUjUh6rzgV8S2IMouFQq9/TSI3
 Sabsh8W2yl/zXcvGz8L3qn4cQJrP+UDwMf5k1CjHybFQXHkJadOYO/F/32MGK0n+mqgtjXV
 SLdf/vq1ms1HNcYVOS2i7cX8XCxHpEe/6aK/GVF/w+Pr0b8LtLIcbmyAw3Ab91RjT25UEPY
 W8WNJuzs3EyyglPmUPJQRWcb8KnPIm69jPqyWaVy4zEG2kmWsU2FK48iopUdiQM5kAHLzHP
 LwZqXizkAuK7BII5gWNkiWw2W4IuFAhaQBKf/hFOxUHaDxcAeZbJNBnh4IqcO5lIu+DlRba
 br4g6E/JuwZ8mgo7VBZazgh5hvIrWxHAhrPUjUPXpeK7oWhoUPVLqB1LvrVVRqJXaqJb+1q
 fegR1KNqi44a6EEObS+Ra5la9/213yavdKVRUHRwzEUqooux7Uid+HSkHFaYRiiX87bl/OZ
 v8HWzyxCuXRjPF8UmBLN4CSV7jZEz5UfsbAm44yKcTvZrztdRSY/9KbDV6XTXOgc4f2bA+b
 FKlKu/MpeNDqf8xvoEWGvq6Rdybis120lQGDpCCp+27OrfHCUEuKxCKMVSNtkN/bfi/hLEf
 nNvArjlNKPO1iYBmDtKkxS74pi2Y/ExmAS0SFzFIUJffw8fN0KEyDiw0TRAmu/UCmdKlWrk
 u5yQAeK+vAzD7lP5BII7yVlfmFxjWqG6yWILOoAD/5zW+VWvOkW7WZGBHncAw4avrb3KlO7
 ETbpjYyxzh77GgiBMHD4vzJGLcOU/ZjmfbkagBwAdHRqxACO1cG+Wu5bO/OjggDnw70dOIk
 EJeCEE47td4/0+Pzzo20SwnnoUBdLw6DpPOzBHoGNaaaIOWHx0EWKso41TIisLBQIRcKGEd
 lnM7I8AGEc2ujJpi/mAXRyWKnYA773xCt9n1ABNfY4cxBOI6v55h78ubYMwcQ0r16iWDpbv
 OrFnoB2q4LVaagYbOIydPuj67UigIZVJkyCWBnrTKzzf1XCairun9uDfB1iuFM+vw==
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
index ab7012608f..4b63810b16 100644
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

