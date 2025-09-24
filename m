Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A126CAC5B1
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:42:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C8440A80;
	Wed, 24 Sep 2025 16:42:11 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id C9F98406A2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:02 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020118.outbound.protection.outlook.com [52.101.69.118])
 by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlxeQK/JA7jlcejEkjZMcTIquqfwwA6B9RPLq9ugruVqOoLkURNTDtfCOiSseMPSZaUaUC6mhk+3SXUzNAUhDMePt0MEpQFDVRqHb4tTHgRC/YVQV10HBB/5b6zOCz+iMrEBGjVcP7eO9Uvv3iP5pA+Q5tEYd9Sgg3bh38/UxezEGw2eoMby2Ewi3yIgSTOjsf5csh+ajLjNv5/ak8KP2luFyFbovGr7T+I3pS8u7P0gqqEhqssNQ9F9WpWGZsV+l3xpLdLt2T3VrtsNzJkfiQ4oW4frvgu2uajhUsp/HfihrfIXSaH2W935gq0z1Ijhu2JxejH5QqSUMmEkx4IzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk0MCj6cfR/LgQrPhGKDuyobgFt/I5PqnOqkbwqJ5WM=;
 b=Fl4eGbO6RCJagFNOiAfKYBmmQmQeHW/7jQ6nu0yd5p++mTXi7MVQDGEMtfHkhKtBYjk4Ixdf4Sr5kzCsvGn8UZ4OOh8XvHXLWDNJ/QDzpV3geFUY3DDkbaMhJ4m1PjiojcJ/3ClZeOnIeFj8WPeIuj2IOC4fjmUzx2L/TsR0txnkta+o557DhTQa3fDqquDJEI1p++5ckSaFr6O4QV750giUaptgi7PepJcH4wbF2M7ohBdsSywBFg3Viq/BYUYd/eEJ17VvVtDOeV8iWqAIZcHhtpUTlBUfOOdrvdKuCIdjmxgXG+mUgxn2f95rORPp7JWUQpNhNlX4PQmCdBUNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk0MCj6cfR/LgQrPhGKDuyobgFt/I5PqnOqkbwqJ5WM=;
 b=UxNtO+tE6VSfUxdDLcv/fsI4gWglohrklPFZZuafPqPPBpndEASKmAiVQFLIT9yX/8/6a0qhWMP3ZZDlh8tTTDiCAoJktaFDFEki5CGRRJ7JLRBwvJvMrLHsmDk2NFqsB601v0PRO3rwfJ9SQqbW2SxqucFbCjCOiVPH9C07828=
Received: from CWLP123CA0238.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::19)
 by DU0P190MB2320.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:59a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 14:42:01 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::1a) by CWLP123CA0238.outlook.office365.com
 (2603:10a6:400:19f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:00
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 06/24] net/ntnic: add warning about service cores
Date: Wed, 24 Sep 2025 16:41:29 +0200
Message-ID: <20250924144152.53203-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DU0P190MB2320:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 111f910f-6ab8-4c55-9a66-08ddfb788570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8s9G/59yD42oGYRrupXc7/rt9CqxBXgd/A3fZSkAX8xlGG5xK2S6jRdaeC4X?=
 =?us-ascii?Q?0eDofFlYvGBJGtEeQo7eAHq7qS5unbzwZoqUvCH90AojWGHWeCEJKk7BKMLk?=
 =?us-ascii?Q?VHnh/Clyc6hu23cPTCQfLrl68iYKCVdoFtESuZz2BA7E6cyDOdV+5hEZjaxW?=
 =?us-ascii?Q?vT8O3I52y4HavHeDdNHyfoGz8NNdLBx/7yLPZXKQUxw7gWpAAElgEeJymYxj?=
 =?us-ascii?Q?97p9SrbSHG3pfhS7dQRPlbhdCGnPzW+rXotgE3sOnkRYGfUwWxYIMRqvRHD1?=
 =?us-ascii?Q?bn14Y2U3Sgrq73intF/bV+ssWHLj/auSOyw5vaeyd7yuZRJtVGwCK2zBb3nZ?=
 =?us-ascii?Q?HKp0ABgA/GXBqMN9vh3y8jK1NV+pR0mBU4OGDIFIeUIU8TkE3xG8pT7hRcCg?=
 =?us-ascii?Q?QreG2tNCWUeGij10/Ap6PA1nH0K1qdQmNqezLhCaBF49Dco6MAPfNiFd178s?=
 =?us-ascii?Q?1eDAq4T05Vh+fCZXFrcjwbwSf7iB3jTkntVTKb6AjaDWD4I0wsC6r1Hg8DZr?=
 =?us-ascii?Q?dZ8S/eO9AKlGPnpYVt7Je0X8GX3juCZjGWrYnUTGHyEDHu92xPt/3G2K4sy1?=
 =?us-ascii?Q?U4/6JA3ZPiTBJIU3wGC4Dh8euf7nAvue8L145CZTMxr5KT8cIhL18/AQyVsZ?=
 =?us-ascii?Q?nEpmyLcqQ2zqAzSgXzhuuEQbEMM8EigrU1EHLZxsZbGZF1aCYyeRxi0LczjS?=
 =?us-ascii?Q?A4VkgzwTE0uesNOQNNBpBXXXfOnwmhscLBPDpF9xFqhi0I8hKVf2EfelViCy?=
 =?us-ascii?Q?eRE38PCKR2zcZyQpXlyWPEpt6r3BnSnDToVN+3Tc4TLoGYTLcaGsrkcKxJl/?=
 =?us-ascii?Q?E4+wNEugyvvBzy0703cXk9qwPWo7RDxDIVmjc+bq5co97fa4/3k17h4TF+jn?=
 =?us-ascii?Q?0Oq+lkgZK6aYleW+BIis0AshH1DsUUzpnKwxrtk35kqHNDF3E3lJUSXqGfM8?=
 =?us-ascii?Q?9h3f6v2ejPuW2ysGUzH5MjWuGDlvqMLrRW6pc4Ltlnj+20wOorM/xfLY14gU?=
 =?us-ascii?Q?dW8zqIx/+HQNjFC2/Yp/kiw/q+wRhJG6NpRBSwYY05eVYqkJ9QmKUWGs4BlC?=
 =?us-ascii?Q?zi9f+s/XbQgIJhsACLgTr7tikvVUYHkHg27aOC61qkYn2dDdohDf5A9RabXH?=
 =?us-ascii?Q?4teLAGBS+IRkBeUyY1PgBgp+hVVI1uBbamu4NTIk/VAHaOoEzIFYivf/c3SM?=
 =?us-ascii?Q?f1c+H9ooW1dDGJHO/WE5KiPRtoMk8xXsRqrwj45rlvmIuX+60wotPlsI5Ko3?=
 =?us-ascii?Q?giCMbn8kV02lhOA4j+bCgbvlmlDZ7ahDrI5jvdSvMqgfcUpzrPGPRc8xnC5i?=
 =?us-ascii?Q?YqxjDKvBTLI/Plub6GXY2qDAhBF2jr5RiU2Czp/v9wDbN2N8dEXVnxca0yUR?=
 =?us-ascii?Q?LkXhxuiQOpONaCaW5AtSHNattBXocTSTlbEnnYP6Ybhg3iUS39CsOA23OlBH?=
 =?us-ascii?Q?2VvNlC3Zf0FyD9hDVf3Z9IuxoVE1FANchwZqFodABUq8dVEF4ga9W2jIddzM?=
 =?us-ascii?Q?jJb6HfF/ZoPvTumMf9+Lyn/mo5+JlbnTVJMd?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y5zhHKAQIi2IG7e/NUX1xcMzJJfizRj7G1tjfSQ0rpnYUYErGcFR01gOnghS8SSo3IGNsgV21izvEIYikQmX5EqdKSEHN0HNyZdMorE1Y3icdQEvWzt+4IX2u7RfbTG4t2X7N1y6ukyPt5+5x/vLnBEWTT0mvw1erMwOrErpy/lLYRfW75DJeiKl9wB4ZUnIE09myry7He3AGE+4YSTigPrgDDSbNd0p4S+XaMFljq0D3CBmd5ZtW0u23GIEgWVcoJuDv5Re1YGH/zP5razOLMR9JPb1L4MRewST22q3fJbcE/Re1fpI5LRu5oFerFwlu9ZRUA1PjrHczpE/5hj0DQ74Q91RnOm+Hj5+139y3e0RbjenTD16tAwi9VRaPasXoOQeucRNkbBMyw0A7p5WZFNDggQ4IZLFOFFTujKx/pfcv0pDRjZdBz9FKzU/K66SQ8RMADkHWKWL9gQq+NnmB2W12A9yUV6KyvjFFEhja7dlXd4YHi6+hPZZOQ/MFVLA9/d7lcuzbxp9q+9sIRQMOYk3SF03874ReLHv62jVj19aKOJ+fZZkC1PwgVXeoAODfwvNsCpcSVYgiU6azHTqNfF8FNx5QvW3XP5TY2Jq9goeQhhvvhLxItfuVognDJS9/v8wiZb5azhONZn6sXeqFg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:00.8862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 111f910f-6ab8-4c55-9a66-08ddfb788570
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB2320
X-BESS-ID: 1758724922-305664-7614-7975-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.118
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmFkBGBlAs0dQ40TzZwtjALN
 HS3Dgp1dg4LdnE2MzSNM0iOSk12UypNhYAc+j8kkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan19-153.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

This commit adds a warning message if the service cores are not available.
This warning notifies a user about potential issues with ntnic services.
There in no error because the service cores may be added
by application itself after the pcie_probe.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d98c0289cc..40a8d2b2dc 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2608,6 +2608,14 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		}
 	}
 
+	uint32_t cores[RTE_MAX_LCORE] = {0};
+	int32_t lcore_count = rte_service_lcore_list(cores, RTE_MAX_LCORE);
+
+	if (lcore_count <= 0) {
+		NT_LOG(WRN, NTNIC, "No service cores available. "
+			"Please check if all NTNIC services are started");
+	}
+
 	return 0;
 }
 
-- 
2.45.0

