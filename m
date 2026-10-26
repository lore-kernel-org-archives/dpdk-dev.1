Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9873606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FA6040A77;
	Mon, 26 Oct 2026 13:27:14 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTPS id 450924066C;
 Mon, 26 Oct 2026 13:27:07 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017621teec01f69
X-QQ-Originating-IP: HUdD1pAR69qmqvzsjzfcS4SAc4lYjrZjXP3pIG4tcHg=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7649044886171835497
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 07/17] net/txgbe: fix link speed display info for 10G mode
Date: Mon, 26 Oct 2026 20:21:53 +0800
Message-ID: <520ED63888888F66+20261026122638.9198-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MVitSRkz/FOobEQAeK6rGYdvVh6BxiligQO9MiiVVUbZn6uo/uEyvkG9
 g7DEaaedyn+gwUvb7rfcC9MlMl8sGiU19hqdDw8UVQX+n1sNqAKauFoPHP7yfG6UsJPgIUz
 VuBt8EWdKdaMZnsG4yMa0XKZt3UNkdEDpCW8XC957JUh8rUYej+tsj6ugrvq2wxXXXKOsth
 8eOxQuyIc/suqrDksVyI6Vq1hcCF3On0hrqPaSFoslF3rdTcsYIhZmBe65N++r9ISk+q97V
 +ovSbIn+HOyuW20vPVR8GIyDGGgtMIOUjJwMLhPEIBVCLun8Og5RnTJSjXZW5UsoN1u0BEv
 hxKfAbJSwirrFwtLFIjhUgq5BGLeSN+bRwM9xiRmtIYjry8zHKgFzFp0ca2e2hkvxqveU/Y
 lInxu5lYtGoRO84/gC3d9lMMT8rioioH4fMu3vO/5io9NuLzDwpH44AeREhc76TPzyfMfDM
 d5loJHEhv/KgugQV81UbEe2624sGO3DpoZ+HO0PoVObKoGbAjStBYRA5jmjZwVIJHHSM1G1
 wTzUWEBPVyYrUgb0P8pIGngtT/vpPGlMRNabf7QDR1hWA1MVm0ECjKA7WvvyD0lqUECRrjp
 a6UWUIqT6YqH2FbmAJ94rMyBdNrqfA/FilwXMNrx5y2VXveISQHNlldaxGuZvvRqJVc5UCy
 AYD16lZ53ju3yBgbIP0/j/pD4GTwHAlFsGJP/5R0cQE4cRA6bvMlz2QVPoUT9bnOhMtOHd9
 iJBJ6/UDMYHRo7M7I8LIbdCMX5v26wH4UY59w/LfGyBhTkQj2e62daQNeekaFlRrSqbUXPo
 W5sfsKI5OtGe+K7IkLT6ZYCxPagcuTapVrUW97fiW2c1JZV38TFDzZmabSEPZl/lpXMhlvJ
 qsMW8XcA6m6iET0Ngc3fKb0OIle0IfjFQQE1fZ2vNJ1WWsRkshdjhLgjY7duwEUJi7RXZrL
 U4jYsLHVHKtaxK01CJUDSw0mQHj+QRMI8I7hVy8cFXx3bvXzUXg7co3fVDoqhvZviLcnFIJ
 EIjf/Hr7nOLrPpcQiuYymnOJFLlOM+HSd4UenRNISG+6CmFAUetiYyDoNRWDXqbUz3PlIGu
 j8DD+Y/FXfF/ICa5rVtskUAix4NxGA/TXKTxzcG740E
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

