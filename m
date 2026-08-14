Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45131C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:56:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75EB5406A2;
	Fri, 14 Aug 2026 14:55:52 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 2D73A4067C;
 Fri, 14 Aug 2026 14:55:49 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 5C0C0E0B4D;
 Fri, 14 Aug 2026 16:55:48 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 5C0C0E0B4D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712149;
 bh=HKaCMR3mbXKqaUh97rZuqLcF1/YJpAfr1S3hV9qcoVA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m9cn41OyvbEtqDtXFAXnfofNkhWtmNZmkZnPi5Sk1M56IhbgqMguZ3VeYttV6qiB2
 WR5Pc3uZ2UDXORYWvOb93mq0h/pOkfy9oOS3eb2fZ/QDHPC0h09OliMkIyEhjGir2m
 mhHNnomCGOY2ErGnVSAZfraDuCVa2Ojwjsb5kyFEH3NohFjncGNTozCFM0v4Ya3D/W
 bm3zRV//NxYbOn4s0j5khsK1+p++tlYoAdnPFKWoqKLfOfwBBIw1JWdiOLfLNu/Uze
 fJx/QpHli++oXUhq1hBqtwCLvVpNAlWvG4bRFyDwSh03pErDqMt0GwIVwn7Iej32qT
 ZmPBJkhcikMhg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 2/3] net/sfc: drop wrong static qualifier from iterator
 variable
Date: Fri, 14 Aug 2026 16:55:44 +0400
Message-ID: <20260814125545.13343-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125545.13343-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125545.13343-1-ivan.malov@arknetworks.am>
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

