Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42493606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 11:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05BA8409FA;
	Thu, 22 Oct 2026 13:10:54 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 0511240A7F;
 Thu, 22 Oct 2026 13:10:51 +0200 (CEST)
X-QQ-mid: esmtpsz17t1792667449t37e5e383
X-QQ-Originating-IP: 1tU4Zx7+6he8M2Cq5n7tL0hlKPyGB5+9p9e2jxWu1Vw=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.205.193.71])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 22 Oct 2026 19:10:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6357936663772176703
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v9 08/16] net/txgbe: remove stale outer UDP checksum offload
 flag
Date: Thu, 22 Oct 2026 19:03:14 +0800
Message-ID: <DF3685B6CF839D2B+20261022111017.3605-9-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20261022111017.3605-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <20261022111017.3605-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mwn+ACeyUjDMMUHxIw2xKtf9o2LmsQNSCFBg3UMF61O7A2NBMjGObUM+
 mYWyE23ylMOzQOw4Jok1S3Gm2oHQBMfH6rUlIjIggAJN5lobrEWWvh26kmMVbxLUR3uLqrT
 SIsss6FZCglvCg5UcBz+jly1+zRxeMfWEEc8WK3lhWA837WV2EYHAIAVGprKbuu3ZxU2jpb
 +4cHbj/7kVenEyg0RDUZ8OePdFvy+HWzqvHv+/aUtsIv1+9pOeIcHQCDZ1ta2KCbcMMChCz
 ftbab/ohuQGjn+kVz8/g7vam6anCTSQGJVXQcHa4qf+ADd6WhgiKn3jE7XJUXkJxUOV2/a7
 yoHUJGSImc4boaNZIjIt3kbFSkoDJRceDMSfrjQGqX7V7PIfs0RhxGSyoClTGMotzw97atF
 JFS46DNBolRuLZIhX7VxGa1LfP9/+Al2CyckVRbQTk5LP0xf8CPKzncJV49ccLtobtHl/+C
 ck5yKeE14nzzEPQ7yJDjEyftZVvRpKkfpXxv3nf05ZQUENUxVo/qstsg/GS4mO8WWC2nbJg
 MhJNnq6RhOpTLq0nG071SJmsC/344pU9Gb3y/DFncxDWM8F3MnBtIuKUAu1dKsu+mo9xYTu
 5DLhh74fWhlPB8eyxbge7KG/QaAm/XyxkB9636Eq+s+YOZVqWUfAB91s1bYJTK0VdClQ/vh
 thLv9vti14HkrkPITNkh5sBj55WGfi77XLLL72UVa2qjvV1GIoBp2UcNYqoRcrJHHHoz9uy
 /Id+1lQXyNdi+Kg3nfkxS7UtAs9wxMDYgt56ntL22lWj5Yg8YZdipdRlECcZ/CutnMb198I
 DH3lKcltpbMhgJYGCm4l+2B5R9Dlq1KzYLpLw3qjBUFSBZHm43vyqkIul3U9spblsHmE8XP
 dNX7TtUPT+aY9S8KRJNdzCbaS1y8XrE9Y9QSkDm/Qtky3WZhOFDEd/KwDspOByc9UCT83ng
 4EeyLZkoQi6AjXPS5co949gnEK5EnmNPI40G79gn6/4yKArqJXabfImhu/gZ9H++XeZuSBn
 3kfqTi3SPsr+je3uHrgrJoVBAo7ICn5pd2gKK7OCv+lhmPbqh+rumYplDpyrerCuBVVYI5m
 RtCXWj1XP8iAnsWIEW1hUE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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

