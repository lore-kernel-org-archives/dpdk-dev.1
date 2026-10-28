Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCA606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N0zAWw5R
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1888740265;
	Wed, 28 Oct 2026 23:48:14 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 0D52F40264
 for <dev@dpdk.org>; Wed, 28 Oct 2026 23:48:11 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so659249a12.2
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793227690;
 x=1793832490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2ce0+z27LMqR+hsjq1uz6FxilaEj5/1MmjGGU2bVQ2w=;
 b=N0zAWw5RZHarCKRGjoDnqPxzJs4GpwL6Zw3LCfIPnI8H3HmshqMdbXUsXiD2IoFONb
 0MNrXqSU6jQwVjpl5YoHJlUjxG3NTSy8LDha/Ib3cfSSyhbFYhHtNU7ivmMeHuT0uNhH
 JV0hP2chj+rufbsiFHig7WzMORaTslWmdVbbm4Vso7ESjBTPboa6onnM8HTKWeqbWwaa
 lakAjE0GbsGxmtDUBxogI68ijITiM11mqg0L4fXKY0rMKcAiHPoI8MocCwSA82t/H6DL
 CkKg6TXwkrjeCDhz19hZiMFKZFAk/+4iEmFWKtFnO7mybTgFg4Hvo6NsHQCP9pIJw1Ls
 Aheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793227690; x=1793832490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ce0+z27LMqR+hsjq1uz6FxilaEj5/1MmjGGU2bVQ2w=;
 b=kxASfsgqjFiJZGa/CMchrxG8/bAWRgFPaaJ0MTMw6Kh/yug4YDpC8e5nu8YYvkVMAn
 vH/yT94xFx6fclJfvbgByWVFTJY5dJM59uhjJVAadru4JF4bICOXH6tklbMW/59Cue+q
 6x5KrJjYvPFiJGmD8ZxaBVOGab2mBuMSbdnWX2mcX6MBpZPiUo3gE/X08bBz8jlSwjbO
 tHl3BPvucu0ji7LrZ38yv//ZX5Zb93/6BkC/hsvjYGdskw72t+uXTGxvCtVj0jy/cySk
 eyTVhZIZFg7DSCh0hEOr4vMFIvKY9gJkS0VSH4Q2BwMQTYlwqEeEFoqcA/wPdHQYYMWg
 xolw==
X-Gm-Message-State: AFq9FYJwwVNvMXnPiHY8id/HLjGdMphngklecLbr5BpGS5AQsDGX31wi
 SKTjREDO1Un1SiN0TxYY1U1041zsnoEbTqJ5ThmyjljPisVnkYwVye+VzQ8NzaiiJqS+9Nh332S
 ozX0NkvY=
X-Gm-Gg: AYBFou3hjG9hRlTC3G+GZuMcRu4iFw/sFUTLrJ0mNHBVdDV2/7R4D7dGFF7Pu0N0I/c
 JTxGFt1WZECjzR2ex0yBWaUs8dBeQjNU18GCvKD1Njq6lzDoREbmlRV5ghDROLn1cpjwhYQLvMR
 +p9k6MB7h0x5Fu8qoWNTmeowX/1SiJuPj+d4sZsmqkTOnvK174m2Pq79H/OD+D7TstoIgMwXLi2
 akuqbIB0vpBHfi9Zv9Rr/9d5mrP/7v7HC2+rsPB+x9xpuTx4JihK6+W2XFc+l17GcBgc78GkAGy
 WCAtjD3H7/C82OMOgWb8KMcxBbUJRxPADJoCfwY2DHsty3jG5avAdgC7p4qVNTqeKmcD9xiOKyU
 25uZW5yQk3ta130EiEHWnZjqKJGfZM4MIjKwiB21I9/KAaf0/MPdwS8pYDsPcE4xjObl9hqfMsy
 gOpMdLlwV6i8vBhxyZOZCqeQBu+2I/dZxIb+MZr9SdXXpk3K/zwaYIshLYkY5SY4Armg2R4WF0A
 ChxLWhBbMADmaHl5H1jf3/Jm7c8dhjWEuqD3JbnDPclOn2FlVc4c82SfwifiRASm8ZG2f4Ea59H
 XhBFKJPc0RyoMHeqI+QCzmNH7+hGfHBTkjYxS+1JDzklMZ/dKCWR29FomN366wTDEYohnxwLxIO
 NIJy/lYCHcLGxww==
X-Received: by 2002:a17:90a:d00f:b0:3ac:83c1:2bd with SMTP id
 98e67ed59e1d1-3ae580d1a4fmr2896271a91.28.1793227690084; 
 Wed, 28 Oct 2026 15:48:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e806323sm1228103a91.9.2026.10.28.15.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 15:48:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH] net/af_packet: move size check to after vlan insert
Date: Wed, 28 Oct 2026 15:48:07 -0700
Message-ID: <20261028224807.1629044-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This fixes a corner case where vlan is insert and the resulting
packet exceeds the TPACKET_V2 ring slot size.

Reported-by: Anthropic OSS scanner
Fixes: 23deeebfcfa8 ("net/af_packet: support 802.1Q VLAN")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ef57719803..6bec12a735 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -318,12 +318,6 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	for (i = 0; i < nb_pkts; i++) {
 		mbuf = *bufs++;
 
-		/* drop oversized packets */
-		if (mbuf->pkt_len > pkt_q->frame_data_size) {
-			rte_pktmbuf_free(mbuf);
-			continue;
-		}
-
 		/* insert vlan info if necessary */
 		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
 			if (rte_vlan_insert(&mbuf)) {
@@ -332,6 +326,12 @@ eth_af_packet_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			}
 		}
 
+		/* drop oversized packets */
+		if (mbuf->pkt_len > pkt_q->frame_data_size) {
+			rte_pktmbuf_free(mbuf);
+			continue;
+		}
+
 		/* point at the next incoming frame */
 		if (!tx_ring_status_available(ppd->tp_status)) {
 			if (poll(&pfd, 1, -1) < 0)
-- 
2.53.0

