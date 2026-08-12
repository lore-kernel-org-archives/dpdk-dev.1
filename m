Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D7C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB34F4270A;
	Wed, 12 Aug 2026 19:10:23 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 73EA740E12;
 Wed, 12 Aug 2026 19:10:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id AAB65E0AD0;
 Wed, 12 Aug 2026 21:10:20 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am AAB65E0AD0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554621;
 bh=HKaCMR3mbXKqaUh97rZuqLcF1/YJpAfr1S3hV9qcoVA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=23/bTCPJZMxIIHm6fA4EvdeC93tynGxpPET2pj661gBaCEgOx1Cmu9ywfrulji/RU
 IQ/1qe2FKsHZsKTVCgmeQn+gdgX4t0/DB21HAmWXRqebOi4O0ZmNwFiVAhoI4tcDUw
 2aqFN8Q/2vZDUDXeBscTDjR32pP1ZHOZ/7R78D2Q/XDnx2ozuhxmBXvYAq1mRuETCS
 0m1KB03llbb4ZrLpoWgwzTyx5q1+DNNQCMFvkafEFFAK++w+UsRmKj9iZ2b6WFm0mW
 SlvMLysskQHjPVS1C89aBC6niNaIjKOr/bO8NF3/PBYaq/qndojeyqN8xt8QKA7/Ts
 Hq0hDmTsPmz0A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v2 2/3] net/sfc: drop wrong static qualifier from iterator
 variable
Date: Wed, 12 Aug 2026 21:10:16 +0400
Message-ID: <20260812171017.8521-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812171017.8521-1-ivan.malov@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
 <20260812171017.8521-1-ivan.malov@arknetworks.am>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Obviously, this should be per interface state.
Static wrongly turns it into global state.

Fixes: 6da67e706dc9 ("net/sfc: rework flow action RSS support")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/net/sfc/sfc_flow_rss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/sfc/sfc_flow_rss.c b/drivers/net/sfc/sfc_flow_rss.c
index 8e2749833b..f19d6f00c5 100644
--- a/drivers/net/sfc/sfc_flow_rss.c
+++ b/drivers/net/sfc/sfc_flow_rss.c
@@ -202,7 +202,7 @@ sfc_flow_rss_ctx_reuse(struct sfc_adapter *sa,
 		       uint16_t sw_qid_min, const uint16_t *sw_qids)
 {
 	struct sfc_flow_rss *flow_rss = &sa->flow_rss;
-	static struct sfc_flow_rss_ctx *ctx;
+	struct sfc_flow_rss_ctx *ctx;
 
 	SFC_ASSERT(sfc_adapter_is_locked(sa));
 
-- 
2.47.3

