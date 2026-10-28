Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D35606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:40:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB4B44064F;
	Wed, 28 Oct 2026 11:40:10 +0100 (CET)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTPS id 39F69402EE;
 Wed, 28 Oct 2026 11:40:08 +0100 (CET)
X-QQ-mid: esmtpgz13t1793184004td60f1543
X-QQ-Originating-IP: fFglRQYFZJAisnnvH7k6rP81+NDTuF/qz2hLF0mo4M0=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:40:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17339403806917698892
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v13 03/17] net/txgbe: fix E56 PHY configuration error
Date: Wed, 28 Oct 2026 18:33:52 +0800
Message-ID: <5F2C7A02D0864D4B+20261028103913.10188-4-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261028103913.10188-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MrK54zaStYC/E627pSQKwgJwMNEi1IHPNVylGCvuzfzRfUdaO2sNuKgN
 NBNjPpYUFDZRwjdZhUQfCN7IEuiVmaTJru8EkcuL2VPv9DNRFmtJjpZGXdfMNSRaFhVroUu
 oxI4BMkdCbK7gIFW7YHiowJYDECUy8VIj5EL1wMa4sEs+6ZA33gRf1kq7j1HEDYFlxAnAoj
 AmFm9pZQJ4fnbrcdIS8DDKl5Y/WoV6nTN+4DaB/NIEkevD8V/zo54XRsLIq/xWGIVCJYKWb
 XImDzqYZ3ogu0zwJ2UuL8IPKoqdtdsJgJlnJhX2JA3mn5OfZcSwijdKhOndB+o/kE1LzGZD
 X+G9SylYHc7uUsmlpSPoS50hexkQxJRnDfR/eJ2vvHLpLndLUNYfyuMnyO7201DRLGwpby5
 oi7E2Nf+o8WTiBwfsByz4x+BkVeYxXOMJAPMroDBo1Jh1jGbk2UrwEwHFmT8GDzK4KfuvSS
 20fBlyiPG4wSVw+Ra8TrhTqPu27QOEwkAukfGAZycFP7MAoUsTwWxVoi2go14I/OiD74BNX
 33QEUlVoOS6jCpNfVPEZMi9Ns0hWYVzD/+FMAzt09huZZyCLVVD84D5q80z4lOedoZHc4uV
 WTKNXU++Z/yRxRZvwqfjQDef5y6qgCAzTL3INL9E2Uv55gIb7vFneU+Ci+Y4VrBLKQgdvN0
 X27uZ7r3AZlNTdbG6ZAKmPLlPLeoJopVwtUQIST1WwAypATLWii1J4yFyc4KagQn9LvGi9J
 CASVVibxPnGA68EEj8kaQFVKyWzbad5QwnPj/2CPIM0qfL/wL+9ftGmkHSBAbieDM7RCvcz
 AEMG5VRn33L3WgRcTW0aREvu+Md3qKu6NM7sQSYN0L9XPD1NAZ1nNXFJMEXpJYD7XktcHgq
 +sUdXNpRQHQ3WP4jWpNeDLHLsFgRSYNHdv/LhMfNQCRk2uvw43XsIaPccMs7GnnLOdFeXjz
 qFy6pd9gbHja7JP2QqDAiMSEDLBojSNE+Ghm3nkS7XhlenZYXFr66r2LH+F6jYOO29HUwEt
 891+VGkTwI9wSRd330QOxFr4L73mEod/lhbh+CYpD4biCrkcjUnXcVJuAWBJa/AZJBTW2lJ
 wv9RVzxnG/ePFOAV/FjwN79WlPeXBpfiw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

