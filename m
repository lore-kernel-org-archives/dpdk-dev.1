Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8582CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:22:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 714FB427BC;
	Tue, 29 Sep 2026 13:22:03 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id C77D8427B1;
 Tue, 29 Sep 2026 13:21:54 +0200 (CEST)
X-QQ-mid: zesmtpgz6t1790680910t204f02c4
X-QQ-Originating-IP: roEyjtlaQ5htesNiWvUGQCouP4zpqDPGz5Yeca9gF5M=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 19:21:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16551055528901641998
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v5 08/15] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Tue, 29 Sep 2026 19:18:08 +0800
Message-ID: <25ABDF4FB7506115+20260929112119.4516-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260929112119.4516-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260929112119.4516-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MwVFx0zx1MnQDL9FDsBp9iEkPYQrsPoGEgwopE9dg2PtaYWniwX1j+YO
 mrkRbXDE2/h7Eo+SfKeQKoAgZ8oQT5wmhdDNLKLLjgxRvxd+j9KKTsSoVJnA4bjiore7iLM
 HqLJyGEm6lF+wR0R/zle2buurFCfLUaickuZxPvjlvdVjQrIGIu3bGtyVnpX3naVLC7qyPq
 G7MVpMzlsu6vozkacutHgPjE0oh107lazPar1gnz9PdWih4219wzeQLFg7QKcSVPuEmSPoh
 BHta5bH+TE7PHaAOazn0eLfWwXy0xPdaUp7ApYaoc8hZKBNcMUuQnoKR44ax1k4yoSWl+sg
 PfMxA8c6oKZrT70iHsgE50sRJ3w8vRS2wraJTUEDl4kmXBK+k/evaKnfo4lFRzLDdkYBg7O
 d42uxfhcALtWGPYnYfavzZvSOFqfu6526Y23AX7RC5pzFSL9PjLJ2NqY2CzkY6DiIsKV7bY
 RRfVopUFtUZF9OjTcVj3WxebNYTuDEVUEO8NQiYqhsmHDDnhSQiao79ekGWSnd6UDUvinkf
 3mb/zGH7jyMQWfA3APcVYRX7SDXxAr/ex2bPdemXwSJma2/5AjxVI5Ii5g33Jy3EBNLJ9Pz
 Zv90R0eAsXyftcv8KLnJgVaeUiEkY02WLbQk/pkDoS/WcpdoyvaTwJqKHe+ps8jmH2Fu0ZM
 q4zu1FZ6VLMbtMcMA7vSHv6z+a12ao5Ljj4Zv4c9cWqa2W01W10YihZgViKSRM81yJRFIx9
 s9YeQR7sHT0d17IZnjInXeIO4rzV1HUjGUScu6pUubopMhCfCeDvStyJK+oCUjUy5DPKhFA
 OsqsB4q3ptZohQQpJdY6aBiItdbyHFixnToFrre8r5XsRmMal764IWhONH4pjRavxRWF6eq
 A8m0tgmr6M00GTIJjbn4xLHntv30w9Ze20PTrg7kKbW5aA81qKh+E3WLBlD8HlIY9WowhK8
 Nj8R9u4n62w+BHvAF48gki5tsxVLVdZu5hu6lbjVkc51MU62OZwKQ/hTW/WfH06d24Et99R
 NbwDeOSWJvAvRfqIeiQ8YCClscmN5Pi/zyOmdXivvrA5n23X4lXJ8syNA0CkY3xMwHd7RMr
 Zk80zYgCnuA2WSE7Sl1zwA=
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

