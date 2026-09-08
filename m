Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29327C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E81D40E38;
	Tue,  8 Sep 2026 14:41:07 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 06AAF40E38;
 Tue,  8 Sep 2026 14:41:04 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871260t7de389a7
X-QQ-Originating-IP: aGA/L9w2t51SHs7FLQ/rjsRL6MdibuD5UVJYTaqgtIM=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:40:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1291816259480024976
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 02/15] net/txgbe: fix e56 PHY configuration error
Date: Tue,  8 Sep 2026 20:38:47 +0800
Message-ID: <D58B3B6DBC863129+20260908124047.2284-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MwQdfXoP8nuzn/halX5c70ZQtdguuHcbLwmE/nQCuGxA0bg0mMPe5qfK
 jNStkjKiz/Dc6YC2hpzo+RJ7AgYO2bha54qLR5t/IIuWuTKj2nebO74JkCtlBX88Rlh5tfO
 1kq+2J+wlWcs3zKaBkwPFB5iLdS02LI6TUGeDRYvHy9w1uFtZtgoDNME4e6q4J+cKPogqPb
 dORvnwQUTYR/xK6OvCUA0uanCpSQm22Th32l/r/P5tfZAH2hnhpN7U3aSZYnGADG+cglQYG
 kHGXuBVRgqis/MeVPJbY1mfwmgoLzY64zzrM+XK97V+WyilSoJuL4LEzuwQaohR0ntMK3hN
 uFHrZi3ftDIpjopvR/oR70arTZXaHjnvx4hAfTgYV/CSTz+N49HdaNBQehRUJiMC58AB2mA
 52SKm1ksLg/szG13ib0s+MEOV1Y/otzZUvPpew5h2qsmIhrZ54nrLD+On09tWsrClUioU1r
 5JaVxxaNWBsAd9JHrquZm0Id4Z3dXaU4WyJ0MOmTmFgECLkKDjtD6N2QcnguLsJVUYX/PRQ
 je2C1w6h0GoWBEDBhBNoyX08aQKraWG0atfiOB4A6CZ6SUcDQC/VKSZDbK9ht7h7rSqNawT
 yPe8wnkS50Gd5wsAh1jmgEQ4+BZTKjBUu2rWPLJ0mG3p7m5uszzfdMhPp821z78rrvoDcZW
 91NX/QpRGV/jUC6dcTkCEvxz/V2Ktb3tyy0cM6V4i6kwbCeHEw9luln4clqipPx0gfK8MdA
 UHGNpY39NjnbLoBU7kta4oALqOP64EYdM1rNNMMtcjdesSsw+M79psLG0BB3s3HAXhKWzSS
 1XHh+5W5R51uOs5m/gV/XkRiJ09dFq33+VEwN5yTzbsBKO/LzP6I7OEjem1zpDnHlqxkT6R
 phC+5sgQaxHu1kKTr6O1Hj90HV3POahLpXukRVMG2VjbGOo+Gaxi1ho5IXLvE/q5d6aZPsb
 2UrfccQyNMjDqvPfx9YXT5fc8YqPrYRIx1W8M6NdWBKmIj2g9T7JlmrZp6OqXDXiU2gtYlJ
 hjB8E3Fh0zG2/DXwzC4V8nRpAvX3r6IFFceXE2jegi2J2972xAfpe6Ry0HRCc=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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

The e56 PHY RXS ring equalizer/tap configuration is written to the
wrong bit field: set_fields_e56(&rdata, 9, 4, 0x366) targets the
unrelated lower bits, so the configured tap values are never applied
and the equalizer stays at its default setting, which can degrade
the received signal on both the 40G and 10G paths.

Fix the field range to (21, 12), so the equalizer/tap configuration
takes effect.

Fixes: f7cfc21e9f75 ("net/txgbe: fix link stability for 40G NIC")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_e56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
index cbcc05333e..2711863f2c 100644
--- a/drivers/net/txgbe/base/txgbe_e56.c
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -423,7 +423,7 @@ u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
 
 		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
 		rdata = rd32_ephy(hw, addr);
-		set_fields_e56(&rdata, 9, 4, 0x366);
+		set_fields_e56(&rdata, 21, 12, 0x366);
 		wr32_ephy(hw, addr, rdata);
 	}
 
-- 
2.55.0.windows.2

