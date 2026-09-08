Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1FC79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B18C40E5E;
	Tue,  8 Sep 2026 14:41:19 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 67E2E40ED8;
 Tue,  8 Sep 2026 14:41:16 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871273t37554029
X-QQ-Originating-IP: 3ZO2adNxy27QJfhc+bRUdd/1zeJH0Af2jU96VS/mnww=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:41:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17986999348588030989
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2 07/15] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Tue,  8 Sep 2026 20:38:52 +0800
Message-ID: <093E7C299A75DD5B+20260908124047.2284-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908124047.2284-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908124047.2284-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MLQK/Qc97rZT1Q2IMZdzLruEzEcmxaYDYgLCAltYnFWdxWCh+g2XxuuI
 BZwQd8WEDjuesQPiWFf2+c1YitVt3yFp7Zb/N6pOIL8KYRXf0EF6IoJUtGN++xCvB9/IqdR
 W7zjEkWlxkYF9uBYeaQ/+ra+qm7StSJ5T7JggmxANBrBDBQhhAVDBVoK1InjJ4l2GNxE6P9
 GzVucsKhAvvD5k+Pbbfn24zgP1KPH+NymGPZpowE2mZh11Si+b4n3wi/e1HHlwyacRu2stE
 r3/CXKnuTJyOuIQPfdD0CJIOXyAlSaKhhVx3o2r9bQiqqHgYJIIe7xWu8UEax3XAJ34qgDs
 7TjbRaFiw4vWCiwH7B+VlIir6sTf1HF0Ch+bNbJpsViXWu1VcAfPVHJ276xBco2pd1/vt1h
 n4yXkse1TsBwW4YJ7+qnwwAgbppxkXbpwQxceDey9GcyTd5Yepb4bcYu66yNc4OQ4FoZYMF
 6BSyB6WUoF414RQ2VXQwfUgfUM1juHiCeKmxb76wtfm3VcIzgWgjHsSq3Z/Fun5Fj/zw8mB
 XeuvyCDB3AX3B7w/lBkh/82lkXvQblT6LGz/27k2eaa0LGRYtkuPiLPd5Ef2Ju3BN/j3Bio
 466Z3V130HOAgQcsLw4Jgq3WRcFAq9aeFVvAzo14gje0KCWwLT+F0amWZp52c2e29DYpjQE
 Fq6Ocyn06zlOubJvNByl2g9n48nSzR4AqDe1+0R3RwNxFG1goRzhTDBe+Sji6GV8t9N7+Cv
 puAEySQxI32nCGW+O/FW8aZWAq6G9Gsk/aNdQYIwn0QXb7XKl8fUSxRv/MhNoAo2VPGmjmR
 ZUtBa7yV6R+DmZoFkUz0pxsCr3EWrSTvNpDi9wT10g3lj5R2b0QoS0jjq5R2VcRGBAwRcqV
 nVp1No2lLmMdfD0NS6jrkcNqqHhdG5ISqE37rAb/y+FwXKrJ2oHZr+4whVKU/9me2YSRTOx
 5ejzhueuWZ9EBomdyZpEMSNgTd1BbTjEtjZdVtPvh3zIWFfkrtEn0uL6TmNzgAuO35vBzFY
 +jurOFwv5D01OjBHxgrtLLFnZxyHOd8psk7YojErC0DfJ7QNPxvh4z31jEY6TkNMtN8TgNZ
 Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

RTE_MBUF_F_TX_OUTER_UDP_CKSUM is no longer advertised in
dev_info->tx_offload_capa, but it is still listed in
TXGBE_TX_OFFLOAD_MASK. The two are now inconsistent: a packet
carrying the flag is accepted by the offload mask check although the
driver no longer handles it.

Drop the flag from TXGBE_TX_OFFLOAD_MASK so the advertised
capability and the accepted offload flags match.

Fixes: 25fe1c780d39 ("net/txgbe: remove outer UDP checksum capability")
Cc: stable@dpdk.org

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/txgbe_rxtx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 794ba041a4..a295666f9d 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -61,7 +61,6 @@ static const u64 TXGBE_TX_OFFLOAD_MASK = (RTE_MBUF_F_TX_IP_CKSUM |
 		RTE_MBUF_F_TX_UDP_SEG |
 		RTE_MBUF_F_TX_TUNNEL_MASK |
 		RTE_MBUF_F_TX_OUTER_IP_CKSUM |
-		RTE_MBUF_F_TX_OUTER_UDP_CKSUM |
 #ifdef RTE_LIB_SECURITY
 		RTE_MBUF_F_TX_SEC_OFFLOAD |
 #endif
-- 
2.55.0.windows.2

