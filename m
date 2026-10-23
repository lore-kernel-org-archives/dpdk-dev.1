Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A484606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=RQS86VqI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CCAC406B4;
	Fri, 23 Oct 2026 18:22:56 +0200 (CEST)
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
 by mails.dpdk.org (Postfix) with ESMTP id B4DCA40268;
 Fri, 23 Oct 2026 18:22:54 +0200 (CEST)
Received: from machine (unknown [37.228.233.148])
 by smtp03-ext2.udag.de (Postfix) with ESMTPA id DD9D4E03BE;
 Fri, 23 Oct 2026 18:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792772574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKOkS9TVM8neBG5RCm/+L52nOI6IONiDHzUeguf4LX4=;
 b=RQS86VqILjirCDFfLY6hQYD0bAjlXiazIVR05cNEjFtCtbD3R1BbrYz3/wIlWsiJ0u0u2U
 vh8GT5nGAHnWVQeG9GDsxL/FCTAScyVlk3DFZR1ZYVwl09oLHm63MNylEFDeCiNKY10qNE
 B+FXCNPwdCmD0irzYrPZIJVO9L6sAkraMWHY65M6PftjVl1u986MJZOLbOMOc1XDQpF0SL
 Itg/XzyMp6dRUZl8c/0k838U1DkCPamZTUlp9U3rj8h5QwrNyN1gcA4qLeKjOV/0DqmWNY
 Hgkc85SRkFaICGOg/5O86r8Luwgy2fd9WWeXO1Hiqt5yvCWoDDYbzafqw1NjzQ==
Authentication-Results: smtp03-ext2.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	tudor.cornea@gmail.com,
	stable@dpdk.org
Subject: [PATCH 1/2] net/af_packet: do not set rollover flag in rollover mode
Date: Fri, 23 Oct 2026 17:22:46 +0100
Message-ID: <20261023162247.276245-2-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023162247.276245-1-frank@dressler.pro>
References: <20261023162247.276245-1-frank@dressler.pro>
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_PRO_TLD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The kernel rejects fanout configurations in which both the rollover
mode and the rollover flag are set. Because the PMD always set the
flag, the mode never worked.

Fixes: d3bc77ab05a4 ("net/af_packet: allow changing fanout mode")
Cc: tudor.cornea@gmail.com
Cc: stable@dpdk.org

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ef57719803..870536a8b2 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -844,6 +844,8 @@ get_fanout_mode(const char *fanout_mode)
 	} else if (!strcmp(fanout_mode, "cpu")) {
 		load_balance |= PACKET_FANOUT_CPU;
 	} else if (!strcmp(fanout_mode, "rollover")) {
+		/* setting both is rejected by kernel */
+		load_balance &= ~PACKET_FANOUT_FLAG_ROLLOVER;
 		load_balance |= PACKET_FANOUT_ROLLOVER;
 	} else if (!strcmp(fanout_mode, "rnd")) {
 		load_balance |= PACKET_FANOUT_RND;
-- 
2.56.0

