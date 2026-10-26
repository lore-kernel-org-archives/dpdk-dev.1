Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64903606A31F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2181C40663;
	Mon, 26 Oct 2026 13:27:02 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTPS id 9358E402A3;
 Mon, 26 Oct 2026 13:26:57 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017611tbe9424a2
X-QQ-Originating-IP: ym8fqsmmBibv9z8dXUzuBimny4v/JX0rBW3prcAhu84=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:26:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17384804331859703571
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 03/17] net/txgbe: fix E56 PHY configuration error
Date: Mon, 26 Oct 2026 20:21:49 +0800
Message-ID: <61C17DCF3BF570CF+20261026122638.9198-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M3vv73qU6a4ugfXNK3/vcp/gBAk86Qk59U6F08c1kjKO1Y+X+0N0aelR
 I6djsA79YhW6GRIGetlwnk33h6JvVyXDHyC9EFG8st7ZWV0jgrIvyeBJUg1J2q1l45SUAQ+
 3gIXTiFyBEWJxXUyR2hINIP8hcQetFhdQdbYRsyrgljw4JWCLBkKkGbOmTaDfGfCxCofugG
 lYl6Ojs+li3YDS0e+fEknZ9jJTgfQ0LDweEo9YmYNse6yZhjg+ItEBwEIONl/+5aTVitAlC
 Qsp9V71GIm9/zA6+DAZu+EAG7phJkDUDTuiuMZ9+QIcM1WD60AddyD9wxhDKKXokKqkydQ0
 HemO0gfuXlXPx6L7VjFmgkM6ipDoNSJ7uAULKQI7x5jW/CJDgKybT3p1imWqNCXyaIWOCVP
 eYxYqglL6ElXrXCsz1kZEAqkSyPdjvf/047i5vuJFRD2g06R7QJM0YFlt7D66OuytZ+/A+n
 9GLXlcU1lejro62A9A1K+l6o7o0317a+YxKI6jIyvMfdRRQHeBOZowrXWVs4W6Lrm9Qo0Qy
 B1waxzOPn+n5Vo1xQ57PoPGrQIR9TV3PLIx7R7NKuO58/+PBEdxbTQo6m1BXlGV2DtkhgDz
 lmmKq45QJVJS2+Ti2QeOnsxtYIIf6qW9zsKltUnJGc+YUe87gzYRb9pBDgVIdQo02oKX1ve
 zbI+cRnkO6bTtQJ3iGnDsEyDtbYh7/iISAvKo4AlPcNo4mjZU04HPyrs2MMM/6XtxHNGGxw
 MSlseUzfhj1yDTVoL5mvT1MpGSnYymTorZvUw8bbdWbssQn7sHKKMPEal+vL09gq7E9f8B7
 3l9aErbnQV0d+o33DMFlMd/rLVNd+r9kY7IDnsw0QnHmcwpTtde3ZTU1tJXRLuAPofweGBw
 eSqr2fHStfC6Op/3Yrzb3+wg6GWXQb6CnxW+RbTtDX39smbkqXT9CH0MGhEzNps8kzXiRnH
 1d5ndTBbab2zCfZV6+oOwNrl/AFBJBkeQ1z1uvlB3qSve2azluJL7gZ8kYP0DvRUD6ZaTAz
 NRkO0+QT4OZ/QspGbmV7tOMwCrHOCcTMsmRCA2raLs/cPahGqIlW3V3hwBNKzsijczJeutZ
 w==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

The E56 PHY RXS ring equalizer/tap configuration is written to the
wrong bit field: set_fields_e56(&rdata, 9, 4, 0x366) targets the
unrelated lower bits, so the configured tap values are never applied
and the equalizer stays at its default setting, which can degrade
the received signal on both the 40G and 10G paths.

Fix the field range to (21, 12), so the equalizer/tap configuration
takes effect.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Fixes: 6104fd11086e ("net/txgbe: fix link stability for 25G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index cbcc05333e..c0e5cc3894 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -423,7 +423,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
 		rdata = rd32_ephy(hw, addr);
-		set_fields_e56(&rdata, 9, 4, 0x366);
+		set_fields_e56(&rdata, 21, 12, 0x366);
 		wr32_ephy(hw, addr, rdata);
 	}
 
@@ -1251,7 +1251,7 @@ txgbe_e56_cfg_10g(struct txgbe_hw *hw)
 
 	addr = E56PHY_RXS_RINGO_0_ADDR;
 	rdata = rd32_ephy(hw, addr);
-	set_fields_e56(&rdata, 9, 4, 0x366);
+	set_fields_e56(&rdata, 21, 12, 0x366);
 	wr32_ephy(hw, addr, rdata);
 
 	addr = E56PHY_PMD_CFG_3_ADDR;
-- 
2.55.0.windows.2

