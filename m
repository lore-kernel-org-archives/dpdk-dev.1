Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B75C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 11:36:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADC8340268;
	Wed,  8 Jul 2026 13:36:46 +0200 (CEST)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
 by mails.dpdk.org (Postfix) with ESMTP id 35C0B40041;
 Wed,  8 Jul 2026 10:15:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 5FC352C0B8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
 t=1783498511; bh=xJ2Bhcqng2UtVHy26paCDkWCB/vItwvW79lD/onPLcM=;
 h=From:To:CC:Subject:Date:From;
 b=txB+hv9k3/dJSVZXVgNhhZgJofXx/sM8aWdbiIW5aG1t9sBveVcRGPI9Y0l0UKURY
 dKSY5hxf+GAWuCl8n48fRXjiLtvTWplc4dI/2hdUmb/bfNR6htFMPiE90Mwt/H4ejM
 HvBLVx4kvV0DYLoOle9Mku8KrddlpSRKanPByTJE=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
 by mx0.infotecs.ru (Postfix) with ESMTP id 5FC352C0B8C;
 Wed,  8 Jul 2026 11:15:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 257D82C0B89
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
 by mx0.infotecs-nt (Postfix) with ESMTP id 257D82C0B89;
 Wed,  8 Jul 2026 11:15:11 +0300 (MSK)
From: Andrey Yudin <Andrey.Yudin@infotecs.ru>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin
 Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>, Andrey Yudin <Andrey.Yudin@infotecs.ru>, <stable@dpdk.org>
Subject: [PATCH] graph: fix xstats of cloned nodes
Date: Wed, 8 Jul 2026 11:14:19 +0300
Message-ID: <20260708081420.1100574-1-Andrey.Yudin@infotecs.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [11.0.19.41]
X-ClientProxiedBy: msk-exch-02.infotecs-nt (10.0.7.192) To
 msk-exch-02.infotecs-nt (10.0.7.192)
X-EXCLAIMER-MD-CONFIG: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: Andrey.Yudin@infotecs.ru
X-KSMG-AntiSpam-Info: LuaCore: 112 0.3.112
 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec, {Tracking_ml_letters},
 {Tracking_from_domain_doesnt_match_to}, infotecs.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204312 [Jul 08 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059,
 bases: 2026/07/08 05:05:00 #28416730
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
X-Mailman-Approved-At: Wed, 08 Jul 2026 13:36:45 +0200
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

When cloning a node with xstats enabled, xstat_desc entries are copied
into the rte_node_register structure, but the nb_xstats field is not.

As a result, the cloned node reports zero available xstats,
making xstats unusable.

Copy the nb_xstats field when cloning the node so that cloned nodes
preserve the xstats configuration of the original node.

Fixes: 070db97e017b ("graph: support node xstats")
Cc: stable@dpdk.org
Signed-off-by: Andrey Yudin <Andrey.Yudin@infotecs.ru>
---
 lib/graph/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/graph/node.c b/lib/graph/node.c
index 1fce3e6632..bb39c616de 100644
--- a/lib/graph/node.c
+++ b/lib/graph/node.c
@@ -208,6 +208,7 @@ node_clone(struct node *node, const char *name)
 			goto free;
 		}
 
+		reg->xstats->nb_xstats = node->xstats->nb_xstats;
 		for (i = 0; i < node->xstats->nb_xstats; i++)
 			if (rte_strscpy(reg->xstats->xstat_desc[i], node->xstats->xstat_desc[i],
 					RTE_NODE_XSTAT_DESC_SIZE) < 0)
-- 
2.47.3

