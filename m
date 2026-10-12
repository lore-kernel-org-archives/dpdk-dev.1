Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA36CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 11:06:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91BD3406B7;
	Mon, 12 Oct 2026 13:05:51 +0200 (CEST)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id E3AFA4065A;
 Mon, 12 Oct 2026 13:05:48 +0200 (CEST)
X-QQ-mid: zesmtpsz4t1791803146t2fa281e6
X-QQ-Originating-IP: q/RoKn03tBRBgt06htTfHoVJKc2zMo3AlWbC1x/tik4=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.198.217.6])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 12 Oct 2026 19:05:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14973373334832331621
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v8 08/16] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Mon, 12 Oct 2026 18:56:25 +0800
Message-ID: <EDABF4B3B363AF3B+20261012110518.1911-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261012110518.1911-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261012110518.1911-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MMLbtcJ1pEMpZ+Ti6CK7dFzjbFnJguGqLzKvFC6uypH3yNiyEqeHTFwQ
 p6jLc7EAYNn1lFcyNVL9zUVPQ7QNIb8NsE2OSLUYpgxg79S6IdW6IjfdrWqW2yemwPO3Jzt
 whaN4MfUe+Na1Xj3CNmDQYUOOuHrxGY7CmtH1fmA/GZVPAAhAqYhMsspmxCRuTVzyQHDFwK
 eS8UC+YsxJEa62VbrLwH+6SeTmWn+xfABys5yUebFzCmaeRIZ4Ltmf/vDxWXh6xpAReFr8o
 Hs/I15iha5onRJKaSjlvyBl9/kEpFX+uA3q6Q0yjo/SjWJ0SOAPAZzPSsMG1ILzqwgfXAz/
 k3tu2UIiVKbp24ilkkzIsKVNVw8lAKWu4McZStoPOy1RwwdPeJS0DNuRWMMEK/NZ/FZvLYm
 bOGizyUyJempu+kN071gfkd2khnF0U8zko9M/YFKXYP3wUjwjYdpAkjkdRQagem/D1o7CUU
 nx/lRGJ/2Fb509knd5+z8VVlpS138LjgRKB/XW53D7ZC4I3H2XNbl6QsiaosZJHqVnA0Nbv
 +toDRCPaenXQLsGPBlgqpEcM6FX43mPhG00EcPk05sVzk9qccqdlgs2s9cvn3xtCO8KBXGx
 GeBi1HpJaxIM6ZKRWfKzpcCRx2K2aL2oVDvMNXgkp7VIUWzQKdm6hX7zFnSZPNn/xDXUsbx
 YN2D6de2cqs3ZaJwj45wvQvrCtkpml/Dj1pfNICwYTPN9QpyF3Ic79VQZ2r84i/+0C0qzz1
 zVPNyXZVEDNXoTjFjlWf13Jyy4Ks/DCxqPa6tDep0+4/NR8UebYBXgmZgwQmmobY7+2fAOc
 aw9b/Q0AOkf1JYan+pNkhP/9DLYk9PByQ7y5xg0dCJuqso0MNbsp65QOfZkGaxfCqrzi9cX
 bh6kl6SzLUKB9Bttuz2GCHr8AJQ9cadaHs82lrXqL+KMFR3ofoyA63uF8RFuPikDdUuqAJ8
 VO3yfxMWZo4kuHQYk6t8gNmWgogQBz7zYJfiI+EMhUZhizlz7K1ddMLkjjM/NLI5ntT9mI1
 yYT9xaxewv4Ul3D/A6/pDM9XUgtl4OWasCBjI2NCRwz/JlPE9mxPoTidhTrVhRQ3TiEZZUl
 hoFwfvUr6SEvFiOi6AAK9uFQ73rFwDXTA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

