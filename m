Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C4C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:28:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA6A340FB5;
	Tue,  8 Sep 2026 15:28:08 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 0F17840E4A;
 Tue,  8 Sep 2026 15:28:05 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874082t0d7ccda7
X-QQ-Originating-IP: PAbgDkYUlOiXUDX2degpVvU6c4JeKMnyyS6dbX7NWbI=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:28:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8575881011940446042
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v3 07/15] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Tue,  8 Sep 2026 21:25:52 +0800
Message-ID: <3FB78EBFE00070FF+20260908132742.2661-8-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260908132742.2661-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20260908132742.2661-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OEky3n2B1ZWhg47i+Jgk5UGppc1c4JSm0DQMJdsygYf5MAZcRr9boFJW
 INC6VCsZzAVAj1Q4sXPrHR+lGl/Y8DXQfQMMm9oEX4lcNfCm3SCUjXxkVMKI4SPh4yPqVXs
 rE8KCJfIB7gUAO+f0/MYAQ/Ob/IxhvQFa800jtoMxiDpe2P9xm2IK/4MGOZ1EBZITXD/lsE
 oIoyo7qO4sskWtXtwrz75LvDbG35ZOklEEV/BvGtynjA8eDRXsgdMOR6NoeqgRrPA7XJE4P
 BJXoSPzPitDt1ZBsOV7JZ49KJzVJcDJo3LlRG9h+a6R2RFEs6xSPMpXEWAlwXBKsYd5GNPP
 Z/u3eEnxJP4wkL3AkuxiYTOF4Mn9xKWJpAeG0ToLtGu5tlXFd+xIFp4A1SUzow+dWp9F0gh
 Tf702+tsbmlD3g011+wTOnBmoMyZv2FbiliaoRFgiIkSOClLwfRXahBCmrFET6Q5dh89mZY
 NfYSpdPWI6pgKCCeEfx5xEacd8OfuuGLDXG1J082fgy8wVvQvgHmOCuZn1kCv6MZzJoXGUh
 UGkekaTuLrtuHSZcySVjBjNVjfK8UthVk94PEoQ2diJ0WiVRNYe5La7/sQefLs3qAO0yXzQ
 3y5qGb2eWEDCPa+Vc4QysM1Y2rSuC7E8s18v06I+1AWIvn12g8XKaObskyGsGcUGFmmEkRU
 m+GkzTNSjYjYzvuJ+WO3HA4C01E5NOX0ti0/G2J4rVFmiDRgoSG9v9pgce/rKKdcXNy6A80
 GoqD/ieXUljfM7lS7ZoLwt6ZeLyLmmHDZY7W+vXp3jfXgdoEFqZ1EgJa0eAZZnfwNDwAdtE
 U1pBjr3lLNuuBto9Z5+z2jjeneqkEC8p6A93X44m7ilNy4XwAFHLBUctxHlCPUNGcrqYc9R
 do7BJCyZ4MG9ZRrkhMHt+KsA0e6F5C1cUadNRrfy8aJHU9GJRdhcUQJoEQ/RXalXai/aCFu
 /tdEvEU7R0J1kKi0s382bjbSc+ZlYd/OOVVQOJKIDeraIJGdXmsL9XhJhOe0lUKyJkR+hwl
 Puhl0MuKZKTBpE29P/ErwmAeparwfe4vw+2W0xfc3u8jDZ3oEh24TQUt68OWwqrDqgc1aUZ
 BgRczOPZ9Z52HMO4Es0e882MdDu4wmT1F8X/f0wS9YWOv3pzJw7oUJvl7umCakonJCTwLPL
 EXW8
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

