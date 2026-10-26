Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E079606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 12:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20BDC40A87;
	Mon, 26 Oct 2026 13:27:09 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTPS id F2DC54066C;
 Mon, 26 Oct 2026 13:27:06 +0100 (CET)
X-QQ-mid: esmtpgz15t1793017623t37e758d4
X-QQ-Originating-IP: rilfxDCH2HrvUp1S//0LskI840yx7beHYjDASzb/F9s=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 26 Oct 2026 20:27:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17571139135478161960
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v11 08/17] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Mon, 26 Oct 2026 20:21:54 +0800
Message-ID: <78C829420B318BD8+20261026122638.9198-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261026122638.9198-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261026122638.9198-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OUyKUPM3d6L7Dh1E+IV+UwJu2Z6Mo2UbyHm4tgSeKwQTVksI9LBdK/1r
 d8x/eL62LVpB4M7FgGZZTKHCuenlvscOAV5VKBVS5GsuGgF/av961qTxPzsUhuK/ux19r0Y
 v6sI4Mke/cUsM73mE2rgceuUIiTb8Nc8byt8oowkVNLZDCTs1KUjphFD9jfC28tirfI/n1p
 JrcA2mxX3/NBPqb0yqeyU8pB1935BJyEDtI2SBS4+id+o8uA9m/kla0P4Txcw/rRtD9yEts
 b8VtXQNqBmzZYRmwMJwI5/P+CtGBnme13dJZeuM7M+Bm9swkMixxDKLtoxVkaOUk4GBfy9y
 4lXWuIiJEyq0y+d+w19iwvolQYrCFC3ihRiOSZefFu00+iA8cXzft4vU2+B4r87Gc694BWg
 e6wF3bmYLFdHyqCau8bc+AonTwhVA3V2l5jxlnPi0VhLsCQjS1Zhv6hIOHbtEj9mCTCdSsz
 E4adxbWg0NdeS51D5fU78U1HsvW/hzD1m8Ldk2P6Pbsapxj4XeWVUOky/SOD2VT71cw2f62
 0TkWFFVkzqq1DzBaePN3Dw8uDWRGv24aCEBmQRGoEZocfPunSRq2gameHE9KQEniT8vqsm7
 Wq4J/upLBPL1VAgRj8EwIcY56B4GCBiwmPKapyIhKStS3lJq/qh8+qU6J+BRM2Wrodnqxlu
 oiMYqgEWbP1+j7ZIFSS9yrx8TyyPD/sqlqdm8W1O2IGIvxlPgO7LoXHpom6a6D68bkVOOrb
 y0zTGWkX6AEK4KsfcznlHdzqJ+zNu+A6ie/Ecg051u6SP9TIg1EhJHl+7ysePRnVwAKT4JX
 eJ/SDOb/exGNZBVSY4BkSMAJwuKNIFNr3y/vkSWxPHfcOQhhmf7sRmXu3+MLu910lbXfYhn
 qAVFkQODQap/xXQPN7i/YVo2MzVh6Av64EEARatPAHR6APfthlPzxOenBhyR6Pq6t7hWW88
 wbD821fseoT5aJdOpyXlnjk4dZ68Y4+FCf0DpZ/x/y1DTlKEWyzQm0n0YJSmGoUX0LSb3R4
 Un9+C8BxV6e/oP3f2wcKiE6bCrvmOzjGBijzut8itzJEgmFhn3DW6V4IMLr+sbUrIbOYjgl
 BefAbVNJkvMFZUlF0wWIen+CEwHitl8Lg==
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

