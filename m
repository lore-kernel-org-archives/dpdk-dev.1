Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D4606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ericsson.com header.i=@ericsson.com header.a=rsa-sha256 header.s=selector2 header.b=J1vFmEWp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DF0040395;
	Wed, 25 Nov 2026 11:26:15 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
 by mails.dpdk.org (Postfix) with ESMTPS id 8200A4027A;
 Tue, 24 Nov 2026 16:24:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYHSum3Hj+Wu4tA3NfdVJFBftR39mg0bfhL1npDktmrNW4m6i+OOnpxOGJW+8d+PLKF3pj+tdSbslHZovNd+BMVMM+4eittiBD1VU/my5wlXlCipV53XB4LZUrlmWfEK/8lEHRg27h6IWudpwDTIQ+flYXCVDQEfBIZP3zizVsq5S7qHmheO3a2JQhn2NMavO0MxtfMlsioxh0S8oOlHzRzTNTM2ilug+6+4Hj0Z4KDRlsLH1u219RcXvGieSoPs9dXQd0wXVRhFK6h7NesnZ9gwz/CKG4BqiacXnu2D1claD2Klgqdu4bAdUPvJNFKRNUebXYHsVRno1ttlMJS96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNYBXvYtrMb4tVTIo8BnFJ3gQRsiiMZ8XK8rw+mjjY4=;
 b=S/2Kd8xoxy1VFAhOi06tPTZ+Dyqu1TV4ASunmkW+zH7IXmOPLCEKIAqgVZ83+i1px0sRYlEIWXjnHnyRAxzrn+aLju8K/VmSW42u/sJI6paezyDoGJG93MakV6bDf2o03VPZhv/i/Ztg02omiQ31AAsX7c4zli2Y0A9lZuXhsURn+b8sG19Vz3LKNf8JQlsTNgSbfQRtrKHMRQSJEupjy1zQE1yTtObOubEhak7P7PfOr5+YHewePvNjzigKpNSxuDMGUxT7X/PnQDvRkTye7GSfypn8lALckiTkBjRpu1frdQ2bgTGhNZqTD9W45pRdAHD/dGcY2EM7Qllo3qnZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNYBXvYtrMb4tVTIo8BnFJ3gQRsiiMZ8XK8rw+mjjY4=;
 b=J1vFmEWpgdJ8ycyjrnMMdEMhymVXwySBIVFoMAuOVAFkqC02XZx5vVMgepGd+YFOVujM1uHlTbfKxVNlunDGOwdxH5UcLyCcQuZpmSZ+4jw2tOJc1UQxWBFsJbXArt//jeVuQeuafZh7YJ3g1tysefVnt20PoNaFbaRqo6p6ZoXzuCw9wRsN7Mm3C+E2rvOx+5aqjRpvjvcifxjEO+5DLfr0ni8c1AIYPcCb/njHLSZdwdtxMAIb+mj+O1KjAifdtMpju7lb7GrEE2j6D82EY8xHChWAPGhZyuhNCd5ieNAAYAn9a0ReqiNI42hFLey3Pjng6s2+P0rYJhh+NN+yAQ==
Received: from LO4P265CA0313.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:390::15)
 by BESPR07MB12170.eurprd07.prod.outlook.com (2603:10a6:b10:fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 15:24:26 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:600:390:cafe::36) by LO4P265CA0313.outlook.office365.com
 (2603:10a6:600:390::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 15:24:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 15:24:25 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 16:24:23 +0100
Received: from seliiuvd05597.seli.gic.ericsson.se
 (seliiuvd05597.seli.gic.ericsson.se [100.77.119.51])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id C88314020A84;
 Tue, 24 Nov 2026 16:24:22 +0100 (CET)
Received: by seliiuvd05597.seli.gic.ericsson.se (Postfix, from userid 121917)
 id 9345460DF5D3; Tue, 24 Nov 2026 16:24:22 +0100 (CET)
From: Changwoo Kang <changwoo.kang@ericsson.com>
To: <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, Changwoo Kang <changwoo.kang@ericsson.com>,
 <stable@dpdk.org>, Stefan Laesser <stefan.laesser@omicronenergy.com>
Subject: [PATCH] net/af_packet: fix drop count error check
Date: Tue, 24 Nov 2026 16:23:40 +0100
Message-ID: <20261124152340.3329809-1-changwoo.kang@ericsson.com>
X-Mailer: git-send-email 2.36.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C2:EE_|BESPR07MB12170:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1be86d-d261-485d-bbf1-08df4a3f065a
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003|10067099003|11063799006|56012099006|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: jAClNqk0Jbb5nazisXRRwQbh9ES3tl4st+0yZkQYefgIoc26325kx3KOBuQ5YN6gnXT7vh2NmmpHQzTvRxt2NQQ+lG1WUiEaovsoRcUVWDMv0IT+vbvPP7aL/MrtuYbpk20Zr0dQPdY6RS9haWl+kHGPM3xsvVhZoDxV2C4yPEaUMAB24JmWEbd5zYt2eNgElp6c2G9+FqZMGs3wBDOrMxxzSb9Izim//UVQMdLhfGyLUp8D9y/vnSBVFrT3HJ+JwUmQ0VxtJTdmfBOPG31YYlzMh3mzKFCc9PNiggzrEUX7DnmSvSRny2UyYwDh5Ck6iZrod1066IDzWgJBptwExUBsgatgx3H2WaWv9Ezx6RbNMaQlJFAlB/CrAi/dJ7nUc5NkhL3nrJxO23nbO3+gmH1pGhqMEc7wkBDeswft3/wXm5xI5ezXxgaobn+wO1MihmSqvRO6kguftZHCDXheszLOyBngwE8JADY0IFNqN88MCfxXpp2oEzAuXEz6mcHCyRkSmSfaMyDQhfm3r6i9/Qj31onrGTwkPcJUAoyDE+GQ1PCI7BpNPhgINZAxJfKP2FQAwiQC1F/fcr5fzjOJSJkKC52CabzC5uIQkGG11nn1Uk4F6yLjIcRHMGyXS97jpaRRWj6Bn5ffkEmFsCiLyVxV5PzoBmTT51hrwOrGauv2/e8nViPifMcUZbCwTrODASiAvyg020zmS3457kn5zw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5xip9frxz6hfUlDOTYZ1W7Fr0PaUU5sRJtHYPb32UIv7UYLZv7UZYn1KK1MbUWlxQF8EEtzWJgh/k7no1xyowkUujvnvvE7xBneGMYHKJJAUGp/zRFG6ffwXAXcwo9roRiOuPh3fQyJIg4r8Lvugtr/sHodIoYCpwWGH8K9YpitJ0XlSDyd4Ug50xaxwf/Vh+JopP8GfkYNtaPDRR/0aB1b5ksXRyKwA8clc7JaDasktAg7Svs+IDP+4l4jk299299nx65EwxhEjQ0n2BAMLUr2bH7fDOaIUngvkZ8EstEjd2P5eHy3cTt6d87JbwdKZKt57LBNAUrpUqlHexeW/Ww1phzj5N6jhsbTGsBeux7SsRf0vBep7wshcpX/5I1iYSb9t8QIcahYTnJlSELdjjUKY2lMcQMJj+AaRFIcOSy4lNM6Bs+tHrhYB2qLeGbRx
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 15:24:25.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1be86d-d261-485d-bbf1-08df4a3f065a
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB12170
X-Mailman-Approved-At: Wed, 25 Nov 2026 11:26:12 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

getsockopt() returns 0 on success and -1 on error, so the check
"< -1" is never true. On failure the function returned an
uninitialized value. Check for "< 0" instead.

Fixes: 6b3246245507 ("net/af_packet: provide packet drop stats")
Cc: stable@dpdk.org
Cc: Stefan Laesser <stefan.laesser@omicronenergy.com>

Signed-off-by: Changwoo Kang <changwoo.kang@ericsson.com>
---
 .mailmap                                  | 1 +
 drivers/net/af_packet/rte_eth_af_packet.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a0096fb97a..ed6e68cc1b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -264,6 +264,7 @@ Changchun Ouyang <changchun.ouyang@intel.com>
 Changpeng Liu <changpeng.liu@intel.com>
 Changqi Dingluo <dingluochangqi.ck@bytedance.com>
 Changqing Wu <changqingx.wu@intel.com>
+Changwoo Kang <changwoo.kang@ericsson.com>
 Chao Zhu <chaozhu@linux.vnet.ibm.com> <bjzhuc@cn.ibm.com>
 Chaoyong He <chaoyong.he@corigine.com>
 Charles Brett <cfb@hpe.com>
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index fbaea57615..ad71582aea 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -518,7 +518,7 @@ packet_drop_count(int sockfd)
 		return 0;
 
 	if (getsockopt(sockfd, SOL_PACKET, PACKET_STATISTICS, &pkt_stats,
-		&pkt_stats_len) < -1)
+		&pkt_stats_len) < 0)
 		return 0;
 
 	return pkt_stats.tp_drops;
-- 
2.36.0

