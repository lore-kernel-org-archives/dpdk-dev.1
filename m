Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDE5CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 04:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27E0940671;
	Wed,  8 Oct 2025 06:35:49 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
 by mails.dpdk.org (Postfix) with ESMTP id 1DA474066E
 for <dev@dpdk.org>; Wed,  8 Oct 2025 06:35:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFvdZZpVSfjtgiTEKLIufTPeuhDywoxaexeVBZjgw/lXm7vcbyu3m6j6mfKJ0mZU7xolmwXwGC+730x+nWnzDsfZLqVLwyzXgJ6ZpR+XSPjcSQjYJ8TZ0u13jI6l1YqwScYU6vpyp8ZPsajGqFdQXyy0tJI2/Z/KEpydk+yKIWmDrtZhAsVv0VIsXkhNJXkjb24bjFfSa6tGaNYJ8MXlreHiZyif7se/OLV2cqAWsSwnulg8ZCl538fwPz0yQfsAf5EsUKFRE5adcvwwrS1vMCMFskFM3YQT+ZM/UihSc0vDDneijBLCO0q6vZ/E8HMxv144hp97UFODuggsC4zotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9aPcVSzrgRkhg+2y4j44YaJlogxmlNhn1RmuP+2zI8=;
 b=u7pv+yXoX9wBraCVrLi3a78ANfiB4zqSjVnV0veZjv+sSG+XdNZ69TggJVdRXQMlaNtGTlWt1W/8QKotr90NgfiZ9Jxwkbb4NQAL2Z2Q6jO4PQu6Bqj7jZ+mTKC1ChjgooJoHZbxD0BP+FMv1dpl8ptzZRqK3thJyOCfKrOqjOYsQn1JmEPq5g0i67wN+38FaL1tWj8+IiTUE+dVa63eEDMz60BZbK5V+dtwmyvu63aiNNTK64uPgeuifqAsEMK7Tw9bzhK6FKIStx6qxnC0jRu8zGDIlO4jl93uhH/aND/oZXJNuNgTH+YZBPfrdmjkOAOT3p6kONIbMrysz7meXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9aPcVSzrgRkhg+2y4j44YaJlogxmlNhn1RmuP+2zI8=;
 b=BxYtWxuZzXv5u2bUWc9rshWaLTcI8b2vxMWzNkPLhCAUWSONZMCRKfdKcvGMxtuqOGKQt/uOBrgDo49fO2fEh5Z8S7EJrtLTXooWYr90mg7CjemnjzMdIftfvGDpUky0H3kNUHIG6JhFJ4n7ZFBEoPVIPM+8k06ByUJ5t0nFwX4yrBMhUXgmY+ZrSNPLVW5PVO8Y0fTITApwAu8zvGRsio2SQoJg/ClUBFw/6fA7Y/AO8+JkcbUu1fXSDDRA3EptX/N1czOFNUQlOAaItcZpA+Lkcs9AR50MtM+ZcEsxFucjoqJJKcbCo4vtS986ifNwXtS39SjUWCXNK9rwUokGAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 04:35:45 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 04:35:45 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v2 5/5] net/dpaa: Fix coverity issue
Date: Wed,  8 Oct 2025 10:05:19 +0530
Message-Id: <20251008043519.2461707-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008043519.2461707-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
 <20251008043519.2461707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 11bf3c05-697b-4d5e-a288-08de062425a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EiOIagYKpynUxem3LOTQaw7fEjH3GYWZK8nKzidxpBcbK0ZRO+H1JHL0U6OG?=
 =?us-ascii?Q?EBp13AUslYclezMaoDS551EVfOgLoxAFDf7OpcifTjgew9qc/lfB7hKBr+IY?=
 =?us-ascii?Q?6aLW6twqEVulaPjCyu88N8JVg4gA7CJ38UtMiWRzjufREabFwMTPqMDK9ihX?=
 =?us-ascii?Q?s8nyQvSnHsZD0SD3khTdpORrR1bkXi8rVDEM2ZtG2Hpe3IpZoa0Zx4tiEScO?=
 =?us-ascii?Q?3Hvuujr6amriTeZoSiBjHm1UX9bZwpEZm6KknOXo4qpBDpW+kcIaY8plTAUg?=
 =?us-ascii?Q?bdBu+JA3nRO8GTvkUWRBQFCjwPB0crSZyopLhjUEuWVAYT+BzY8OdRfbphJw?=
 =?us-ascii?Q?s6XWarGp+6jnaElwv95KLXnhnRWypZgCgo2zAn5fwlDUzqKHpDOte1VUuJnc?=
 =?us-ascii?Q?qSMsBnUnNv/c/yWxLz9D+fawdzq545E2kiVY2YVSppRVFRzt1U2U42P7LTyn?=
 =?us-ascii?Q?l8Zj2iilrrUTgRkYU6JoE3lFaGY1Phncna2MCXmIqm69Vr2lLgdbY95BEi7D?=
 =?us-ascii?Q?cpmxUoVzVCRwtgo4c/qSRo/05TS2wr0sbGTLQ0kO5xQumkcqGLzM4UCEIofW?=
 =?us-ascii?Q?NJncmNaAjorRK2XEPD6EB1oVsi5FIOuxjbqiOnLtWduxNMyBYxaZWxR+IehE?=
 =?us-ascii?Q?BbB8IPUs1eoKot3ecsJ69Tc/QqesorqII09Hr/ae39uwZfJdyxgFIPMnLMgv?=
 =?us-ascii?Q?CZGX3ToS9p3+TSuSytRyzwiWSKM8WR4ZHpjcXmogQn3c5w9jCGP2L14FYlQr?=
 =?us-ascii?Q?5qpEL1KA3Mnm93o1RT3drXsRTAoM8NMQsx+SbZ4Z5DHPeYQDFzABrrMyFBJM?=
 =?us-ascii?Q?kZtjFIAfAMzrZ9vEpaKcL53N07jQeP/CmLcyGZs642E8rlvT0wXV2fxRicK8?=
 =?us-ascii?Q?K6ExyI91o+ERU3QYZn4C/G3p0113S6wAJsMcuQlgoP1+gw6Gca8ZBmF//T6I?=
 =?us-ascii?Q?lehQm/zUgADu/hzyB08b2rJ/kRquGDvaS0aON+4Lwj4TQwbpOzzwRPOQAl2i?=
 =?us-ascii?Q?ErzZxlNB1P3Xvhvvt5IdrtlpzlgEPBQJu73OHbuLbj/LLzbNwc1LO/KOc+Qf?=
 =?us-ascii?Q?+PWYdj1auSy2QCIZ07sjzmkDFgaB2sNXP5XAnfcyIaeEYW0wUvGq+1NET4n5?=
 =?us-ascii?Q?3Q5jnYyxLgJLd4FUnSyb3+d+coDy92Rot18x1VT0naZvkyw+wjh2MKVCI8Y1?=
 =?us-ascii?Q?d/8nz+O3w301jBViQrflitFbQc1za/tXhPqgV8RIvjmJR4X/GrTnvikGbMJ0?=
 =?us-ascii?Q?qBepzEA3Wt0gciaqT+UEv57Nf62PLSeGcoxZBw2BkyOgyU68wMghPQlttezH?=
 =?us-ascii?Q?Lpqxys6WdzBIXKUBtWo+xtqdZ8KVM5kVtBPnf4et873coAiILwhvSsaDYGOD?=
 =?us-ascii?Q?w52wKNCFrQ/5u9aT5nXJUNJhYtDgcd7G7Fz19XS4bULnIvaL4fJ6qhDdP6em?=
 =?us-ascii?Q?6MfIG8VipmwdNPTySnllmxeVQ+7DnDh4QDICw7d9rfNegpQKgB4tthoHpTVR?=
 =?us-ascii?Q?jajpnZQAlc8ebk4I8oefAOsWkSjjdeKax8OU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4FHvo5E12l+RUp8B8rIWH1FtUA4m06NFX1mTsAXx63vWnuWxJvbyGUD9S1Hr?=
 =?us-ascii?Q?0oCFHQdFNcgwcYraW6qo3zcTDNL1eddnM2pkYn0ssxEr+lmMLEKyqMC8EZrF?=
 =?us-ascii?Q?7Rx+g7RAqxgX8vFVwoqUA1P1WJgC3INZCuXfalcspydHBpc4mZNBv1MlRau2?=
 =?us-ascii?Q?aUOGDK7vjpF4pwtKx6mddKD520Kz5u9D1zC43ApB9k3Ieyk07GDFx6uJcvGc?=
 =?us-ascii?Q?23fkLF2I+q+cqGHnVD8uY0CqB1Ah3sSrWs+ba5qizpChVHbVZ2LuqUs/Ru/x?=
 =?us-ascii?Q?0Xn6zrJdKb6XcQY+0acfNQGmVsw4r72Z+7ARuxLvFKK++lbHCMbbQvcU7nJm?=
 =?us-ascii?Q?L4Flha5yGJY6775z72OL4B/4un5876NTF4DhMQPWuQEHV/MdHhsU6gWcD8UJ?=
 =?us-ascii?Q?YWgTW/ohOBOaEl54W+O6up3hd1FxAgL5OMJeb5uYjheFId+kzcQ7LXT1Grkt?=
 =?us-ascii?Q?iNv8uTrdqtmDmbu21PFHZUd7tkMhs503MLqjASG4r8EDaD/ZEuhXtb0r/oaC?=
 =?us-ascii?Q?cd5r9ejOLHCIY9ZdxKclk9qyzVIWYyKGmn36hJvEWjIp9vgLnSb1NzJ+Fx7Z?=
 =?us-ascii?Q?b4rMVsyeHXEPEmh6oqjX0SZNgbg2pVM6S60IV/+BspwTbfXlxnr1nURhcVTD?=
 =?us-ascii?Q?zBGuq2VIGOhj6njq45PccPwF3dqAiu2zHG71e8fxyg2fkfDo0IkkzYwu3XVW?=
 =?us-ascii?Q?cYGkSQG/o496XLC3bC7WvicSJr366ad9Pl0jyQq3H5hZU9f0zXyUUzM0++a2?=
 =?us-ascii?Q?yXZ1e/BWUZlD41fEzW/JC9a8mDY+UhUspFyoPDjE2196+1KyuFTgRZPq6e+N?=
 =?us-ascii?Q?oGUCMpcTZ3RgzvKGRK5LKez/qucGwTqskWKEQ0rZsvjoGHVZ78NO1gBruls4?=
 =?us-ascii?Q?kKYFvXWwxOgYzqemtyDor251KNASxqSzwz17hyg1cXx9oMIgndTFISIFzeXD?=
 =?us-ascii?Q?c0V5VfrnHjDK2hKMq7gSMUS9CVHHKsg93r9UKFFQfCXphzvg7gFPY+xaL/HM?=
 =?us-ascii?Q?vBGgjcEyvXMTzQRQ0qMTViAE3X4GLH08gbDcnJJcHPyZ2bx6K/QJ6sJS8dIU?=
 =?us-ascii?Q?wegDn7fWK7aFxAkoBtM2Q+ARZWtP8sQhjuqTVjLj2u9o/E6mcm1kAAa6NQop?=
 =?us-ascii?Q?615pD5GhEAfbbgLM9uNUj2yaxxvPsEqGwN7hKjLh/FNCtdAMjLo6JDsZVa8l?=
 =?us-ascii?Q?bjkuRLuKDfqLiodFNwrEoWt6fRKqJMp/TZDDJMMDus0EDYYrKNPop4n0j557?=
 =?us-ascii?Q?8DpIMlMRlfnkhDox0v1OZNmkq0LqnH6MXHJTfnUUaboMMNQ3emdCxWZVWbv6?=
 =?us-ascii?Q?vPJMOhjYaWtl4fyrgvmIBj1jAebEroL4HeDpjBFYaVzMtjfTCruyVHi+dZwx?=
 =?us-ascii?Q?CTX+0G7YibN6lH6i7Yx6kXGQCwAIfdUZwZQ02RpdddzuP5m2nutNYXWjvHxJ?=
 =?us-ascii?Q?trHYStS6xMqabZ3euAU7ZQrp5yJqfIJL/gW5KrcvQ7wzFiBndr7SzLwOT1n3?=
 =?us-ascii?Q?jAL+SPC7P705BCBEduDjk4Kjt4h3qX+uN3PuyNcqj8RYsFPidvCWv4PCGj3N?=
 =?us-ascii?Q?s5XgERV6fhGtC5WpPkO+VvhBjHmFVUpgJmQcYfw8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bf3c05-697b-4d5e-a288-08de062425a3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 04:35:45.6507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4fokG9uD9wQYJE7t1toxxSW+HewmUB66S2oyn8oWtsRzowxqM7VaLmRJspM+Oio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

Fix Resource leak CID:362787 issue reported by external coverity tool.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 2a22b23c8f..417b9b6fbb 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2019,2021-2024 NXP
+ * Copyright 2017-2019,2021-2025 NXP
  */
 
 /* System headers */
@@ -889,9 +889,9 @@ int dpaa_fm_init(void)
 	/* FM PCD Enable */
 	ret = fm_pcd_enable(pcd_handle);
 	if (ret) {
-		fm_close(fman_handle);
-		fm_pcd_close(pcd_handle);
 		DPAA_PMD_ERR("fm_pcd_enable: Failed");
+		fm_pcd_close(pcd_handle);
+		fm_close(fman_handle);
 		return -1;
 	}
 
-- 
2.25.1

