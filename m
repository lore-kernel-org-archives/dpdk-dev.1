Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26273606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9512640658;
	Fri, 23 Oct 2026 13:07:57 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 8A8E740647;
 Fri, 23 Oct 2026 13:07:54 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1792753671t56eb4f58
X-QQ-Originating-IP: Iu7iMiiYExIyROQPr4Iq/p7qP2gd6LwgYxkAs1t3E3U=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 23 Oct 2026 19:07:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13839157148048913207
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v10 03/17] net/txgbe: fix E56 PHY configuration error
Date: Fri, 23 Oct 2026 19:03:41 +0800
Message-ID: <345B619856F3EA11+20261023110728.3975-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261023110728.3975-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261023110728.3975-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OGboe+HajEar+h45/EFKVhTRhtVh+GqDyZNfWsBLg8mZ3LiEFko1YdSy
 F9pRfPX29gtFmGlb3v5vWZcvEimA8P9zm61Q8OyPgj360k97Z8HUIyvXwva+MLzTnncRRxe
 aflGKXiEcor5cPCO89DP6W8KaFJv7cRNW/LMg7Op11MmAxC3bUTpRr+53ooSOEUjZofHBuF
 6Kx0ndbkcj79slfxu7rhTiTZMKIiZsfDkR9sYJ1AB/4u2fsTs9HKQheRN3XvCD6wCc7kfrO
 8pAIoX7bg4WgFbDIf307uyKDJgwz94Ig+3pJf45I0fmlbUbeDBMWuJj1YWyF85Oy0iyTsjW
 no6cZowSCvB5ExWV8WAFjDdxMMWnZ6NfYJeRW5neWOElf7hiSjp1iSq56HTtRdoob5IuOen
 kyPTl044aTj97jXOve3IzFXyyIHJ8M043bhA2CFxPHJVdkRh07Vk1XJVed7kNFySCGO9r7C
 De+mBXhTS+BQav8mh4gn9gGVUKFX8Ln495fhNyk2uf4uOnCH6mgGfPsfBUgHc//RMq5fUl7
 UXwfibUPogftn3fFzinSWJ8NKuleJHOC8atdu+ouDhVSj+2OKWO0NQJrwxTuKTzOjBfQMms
 mF69ZyHSgAkiUeKfMoCdtXSpoi1ij5NbWz1jpXWmihxwhafjvyeIZBSpKm1XImnOFSE1A6G
 UPsi+a3E6UvcHxVcujGEU6gBRx7s/UYRvC7ZESy04hyUtuLSD2LSxV06C0WY7Fr4z8sVD24
 XzQJD4lVuOvHPW3SJ8tNgxSD5Jp5tOKqAvV8xw2laQkN8/qRp6QsNuEwFfJowG+AqQR0n18
 Fdy3szLltm9GaKM29CLN6W55+2inYEmFLAo/ejkjI7Q1Gwa/1SZwKJ6xwttlZw9Nr3+Cg/6
 hW3I8xeyV3GDwTOTPIuU7hAHZTL7Y6luKLRYzHzpwWE/cdQ/BZWaJxBYiYD32FGoWQgVXj0
 SuQicu3S2eQ6BVowPOLfJAfWWD1r+h2UPK5tmEKrGuBGc6SlZWcf20RJvub5yDKwyby5DHa
 OsPr2KFlj5gTzd9XbyTq3ysc9jnUwuC/MLcStf29AXrGFA9cde6zGnUpv2G0ndkYw5oII2g
 E+M6c29QWAlospff3qdmhQ=
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


