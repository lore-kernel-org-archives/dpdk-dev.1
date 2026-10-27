Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1F606A7F6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:43:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86E8340A76;
	Tue, 27 Oct 2026 12:42:42 +0100 (CET)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTPS id 9FA7F406BA;
 Tue, 27 Oct 2026 12:42:39 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101356ta31db9fc
X-QQ-Originating-IP: A4DWh7i+MWomkKbBmh9ZP+KMXE+k0N84CYjnsnuswxk=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2298930864543746168
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v12 08/17] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Tue, 27 Oct 2026 19:38:24 +0800
Message-ID: <2111DCF2108302B5+20261027114218.9724-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261027114218.9724-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NnmGsxoOL8VFy5M3ShpXbYuyineVGootYHM/7SHG6XKlF9HPLDzrt8WJ
 yNzjTjlumBy5YSo9bTg5CNsZAqngzGUsufKtGIb4u4+UzGR4cO9bdF5AbA0ttDx8zTfPzxv
 Ja2qS5PHOSURhFziZE5riUaAdi/yEWFlaTjXtlmUkwpGGEtnLW3nFxIbhHG9pevSdf+ZSor
 nte19zU5hMf1CT5y3h1WC/E4YXoH6qVD7K4ZOCim3Kq+S3hnAfqAfWB0trIRFG94tzuJJQQ
 Ts2bqnKV7XPTRSI/sCtoOGoyn/I3UlmBCUNm991wacQ22L9nbDNLBtL0234q+aaoPWXtrwG
 VXyxc78SVxC3eW9ElCBIY4ub1ZovPs151Fk72tJFT+WW21OLx/P2+DcWCEqoj9q4GqchDSC
 99uYqhGauQFgRHJM7OwhSXq7jCitIsTfmBx0VcGzneDiMmvMgJCZ6yA9UUazKDARjhzwBhJ
 PLTg1BB+666nXHE9PVr8CGS+ZtaTU/Uohe0LzU7/iH9UzuBPdwLyFQlULwZwA+ELFDMzD2V
 rUFYEQ9svhwmc38nH03es14CMJVKhayV4m8AxWEvEB6tS2wvmI9Lvek+wbXpWDjCEcPJGrH
 Q8KRnaMEBt+h3s+j1U3C9f7v8Qoo3HZVz+OXfma1CsiM5GBGx7vAwpbqAjRUkPJmn0WvA3a
 EbPWE+AVJzPJrQRzJctHTCzDe7fNYqqGezRBf6aqhj69zuyRTTfs9steTHBVBKErYinmLFj
 VGviuVNPjxx4x8juC0rsas1KJUZXDcayDwpJoZi5wirEmDsMX5+TgiL+5ObSz1Fh4P59dZM
 hlcL5De+iZnuRL8vUpkvxjpo8GzE3YKQwvh+gVL7o6ehiBC0aj0257kEA0aiHaqCJCcD3VI
 pEZzNRF34r49EWWGvhP87uzwITpCS2xNRi5Vt/QLckBx3JItphQmHLh0QugOPPCF2Ib/1xC
 SfSCSMAdhn1EZEokHx4V98i+TvhBiYZXogu9aNpDRtohaXlkoOQgaE44XCWSsYcon4+Xpmf
 IytCdn4LgjFaTr/YwTj5NRq/xQOiu+GZrY12Gz1ucHzouBJSg2OetN8ZIDQFky6j8P0M8L7
 5nP3iULq0341UAOpfSEoZQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

