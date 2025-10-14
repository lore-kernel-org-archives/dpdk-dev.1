Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96401CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:18:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3529440685;
	Tue, 14 Oct 2025 12:17:49 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
 by mails.dpdk.org (Postfix) with ESMTP id DE27B40685;
 Tue, 14 Oct 2025 12:17:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cjn5ONoIZcKjxHoEud2wOqCNxtmnCkT/RwCi3zmc9w1T8bJmPlwQYCoVkHVN00lT7B8NP1bVNhYmDrTFfOynE36lvIMycLdxkVDknkQ3dFV+o1Y943Xyde2rSD1RER8tUrApBv4RrvJIG5khAI8m+qJ034YNO7vvdgEEAqmSHlvpBoT62J68PYaJ9tOFISGnD+pmpbhgjDreY5grjZY1aNvrUA3MrlxRWuprx5c8IvntxEFOoduE3xrymKXt+R2KOkEdf6rXuDWn3RnhvMfEw19Q/2dFgiwaE+1w30tuEPYvCzaDX+XzbpZB4ybQEXZeR9My1NS5JJcJWKOlU3FdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2LdG3dDSIDoHYuThSae42cKcTQzeIcXSb30wxISp5A=;
 b=y77SvHhemmq1B2apSrXREYKkHiRVv2j8V5Tqg0euTMEKGABvwPZVw2cDGJ2whOqwMfPkRssyo5qZ/NISUKZ9Kn9VbA1sjMjCVa2r4r8aEyuFlsGL7N6JxF24OCTxCtBIMUth8jnjkcCtVXzP3PnDeL3+htmz4jqyABXpwVsSGFEcWHdwQsv0oYgskXlhaTzL2SQymZj5PmdJ1xMhkwC0ibbetK749I0IyhL4eIrr7QimBXjDQ0ccjr5kzdjZ77WnEBj1mMp86D7PmM6QqE5549gpfWF/PHxw6ciuEgZUm8+yYhsbuMbs2/6uqSSBCyxLBQp/0bBgekode8ypQ1FOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2LdG3dDSIDoHYuThSae42cKcTQzeIcXSb30wxISp5A=;
 b=TAJx2e4n9zg35sG0OiRdvrws/lPibSef0Y2Jg8PWdcpdv2zqXcmbznnu0EK6fyrnWxMLkEZ9j4uZ8WFG3bovQdfyDQ3Uey8Muo+PhRimXDKVuvTbsn9Nlev2rllfU1eVadqgFP+K346ogl+Lg2KOlXWg7XOQC6XFTdKbD3BcFGeJWLa1H3uAXndFlxz9wYAasFlshlVVZ7bKPOGXIm1MN6b+Pl9iM2EwdFQNST33Kz98QBBCbXXrsJnFFjRT8qniCcVhTkRc7uL9i1j83IEbCGVQqN/8I00HdQjJfi2Sgi82N+bKqofXS3H2DKh6OUkSUdmODbY7rUBbmmGvHUuHqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by VI0PR04MB11746.eurprd04.prod.outlook.com (2603:10a6:800:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:17:44 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 10:17:44 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>,
	stable@dpdk.org
Subject: [PATCH v3 5/5] net/dpaa: fix resource leak coverity issue
Date: Tue, 14 Oct 2025 15:47:16 +0530
Message-Id: <20251014101716.2885563-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014101716.2885563-1-g.singh@nxp.com>
References: <20251008043519.2461707-1-g.singh@nxp.com>
 <20251014101716.2885563-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|VI0PR04MB11746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7444697c-cf2b-4a05-9478-08de0b0aea13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/ZbTfLwKv3gm3Jyck8R6k7CCAzRzuuxBUQiMpMnIvR+iK2bkHHDJe05O80eH?=
 =?us-ascii?Q?G4j/7bvpE85u6vFAPNAS0Pjs12eHFyYtdVDfwXlXcS3O4H7SUPFFxnYzwzMl?=
 =?us-ascii?Q?xI54DnMCf6hXOsjA6F8jMhy+nbIoIvGJXxXVf31xzGAV/3zEFt4X2jmunmmb?=
 =?us-ascii?Q?IeCZMXBwkJDe9iVzBH9OEds2zc6RI482+e6iEZ9uKefskagCh8Ap4V+j53LH?=
 =?us-ascii?Q?lAhT/fNfj9+nvsnMLYjPeGoeIIexJUqfJdJoQKUo+bjPrItCkAL68UEpdwvj?=
 =?us-ascii?Q?q1Egqb9bY7xduerYuypszHzxEJUmp8IeZzI8Oi6Xhyevq1upCW2J980AidLC?=
 =?us-ascii?Q?2qkuKgNGCkKwFXOSkCv4YSt1AhOJQAzyDEeqV02/X8alzbuL/SvnqMJ7GeL/?=
 =?us-ascii?Q?qvwWWMcBaur/e6WsQZPbzvejxt21wxK28Ot9o0wHX7+9pkzzw45DEEAOKozz?=
 =?us-ascii?Q?hnK2kkw1vjs4j7h7dbnVxb9YCiBGC92g5/x9BjyRcWcLF+7pIXhL7fz4RQmY?=
 =?us-ascii?Q?GlYYAP2S7/DmHfXuKvIBqtb0TU1ubY8e829vm1N+YXB9b/qfOKMAFfs9QICk?=
 =?us-ascii?Q?BZMRNnjvFy6FUa1gFqBspBiJgx7NCRuQju6nF43FX/8htpbca8gNrUW/gHK6?=
 =?us-ascii?Q?L+MqNAfvDu9XVqRjNyaScvEjoH6Kq+CFBvjlMTLPKMqjBF8d1Z+PR6pKcz4q?=
 =?us-ascii?Q?n9FtBSFavuTvyS/HbdHyDzTQQ3QAtJ5tSmoXqKgSL8K2Pk/EF9cp0yUV8iDn?=
 =?us-ascii?Q?onm1+SakVqp3S7h9ExfUMh85o5+DT11MB6sLKSCkpN5Y8cPXTsaXAZUY+tIR?=
 =?us-ascii?Q?Xp10fmptPECe/hrsbP/6YHGSzzBMDaqWl+J3n4WBkzbhEWwXz6YTWO7SQxuh?=
 =?us-ascii?Q?tYrgjyCqDXu7BmQmjs7LRhRPEsxuMEvRcUtC8rDb3Gc6i/J7smjyvUVTSZWh?=
 =?us-ascii?Q?pO2APQHugvYdmctHEfBUUp8tGsoVjoCMyBTL04k15kZE2py8pTf0dwLSFOi9?=
 =?us-ascii?Q?Hw1K6tL0sUuu0jg3qBnS+zJuCUK2k3cadnpVwdvlPQbQxqybAoPn5KU+Ub5B?=
 =?us-ascii?Q?iTix6KGQkfTm+V4RofcSEtoEjn1BoKJd4Y/vBCU0cP/DW44mMKKOGMujnNad?=
 =?us-ascii?Q?RlNmTR90Wxs/XRuloFvdHtgQwXiYc0H6CAbHz7C45yHPKcG0O7Y3amcFXe8p?=
 =?us-ascii?Q?cGxzTD3Hi3u+vfymkztns366/AG3ZJRB2lfrrAXJXkXeNOz1SEt3kn/a3NfA?=
 =?us-ascii?Q?3gy3j7Mb6QQb5BOyGHgzFsJPBOBjK7kmUhbr3Gq8s6lbqHnRA+Sre0sxqCFK?=
 =?us-ascii?Q?OQm3MyCMRbo8CAANw5nrqXbXjcU07Tw1oS+xYAE9KoEvqifi4n+Nwm8aAJ6Z?=
 =?us-ascii?Q?9YnkRazl3B2WJXuv2Z1lF9hA5P80D8R2XZ21U2A7VytSKnEErz/0+qhi0dp8?=
 =?us-ascii?Q?yiDoKSu/Ci/2+0+4THzhz3dR2Ifq7sHjHze/er+s5YEBwSxAOB7GBkW8aimr?=
 =?us-ascii?Q?g0lkUGWnmnK75lJC5gCoEmzY+Nwya63lm/dn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCC+K0oechNniGLCpFo1aEMG1UEXiBnO7lk+emgeL3dHPmOxYnGQtxWu7J8A?=
 =?us-ascii?Q?rKAdeVMRHDFf22M9SpnqEvU/FSWYoTdEzGKj0fifuG05MQEo6L4i9FzAS3A5?=
 =?us-ascii?Q?qIYLloduSTKnUIajWeKQ30ixZkPGg5L623Pf5TU5YqNm5N3h71IzV0ZSYkZw?=
 =?us-ascii?Q?kbn4EbEHjXRivsF6ushRGc34W91zw3QmchN81WcZKHh9IfCjREMrirUyjlr+?=
 =?us-ascii?Q?k2N7UBTDUuDPJ517zhUeP+mxEecnmXCIBOCbeYPl26kgu2iyVq1yM+IFxPSl?=
 =?us-ascii?Q?bmZuDqDmbtQ+MkgPMQfa+loHqVYQCxPdPFjH4J6sIKW9E2xHJO8U5jB6G4tD?=
 =?us-ascii?Q?zI2cNFAymcSZNZmHVyL7CfVysgDMZsAfHcFFwj9585EdRd+X5GZkwwQjTaxo?=
 =?us-ascii?Q?/C6nfdiaNKnEuJVgpnxKkN3JdpuyjitO25jMo7mWR246WRQifHf9uSbiY8j1?=
 =?us-ascii?Q?P7URswN/lcVsQfngVha3XWLuJMs4rIjmTcbu9EstbChkUwleo0jauBGU5z4Y?=
 =?us-ascii?Q?DrhLMYgKh2muuHFhUcgzQy5D1Gt0XoO366iSsuC2VxhqpEYmot3v/ekHZ44L?=
 =?us-ascii?Q?JSkQeLbYX9q8C+QkmFMjksN1+owOW0bPzJP/6BjjsuH64IktDsF22anpnWcB?=
 =?us-ascii?Q?iBm02AeU2f3b32I5mPsIzzvF3Q7Xx6Ei0g4q7xjO4IdaQ6uGB7HTZPvKvG5t?=
 =?us-ascii?Q?JPYz2qNELhPXlC/711NNFzh94pQiK/XIueH4uYte9HsUKJGwcbSA41RHd+gQ?=
 =?us-ascii?Q?YPN+U0FNPlem4uRK0k2+eDZS1lkXwbKuzi1P8HGhfq5OaDdc/TCVfwVmICZW?=
 =?us-ascii?Q?ezP6eXhRSMdaPnYaB0DvDqBYlUPXK4ZawF3pFRKXICjoTwd8iyrRFLcUhkiW?=
 =?us-ascii?Q?Dea/iztoBQ9nrssYIaRg/yTjUnaVP8bBzepkAuYaawEgkUl7EEDnxTU64H7m?=
 =?us-ascii?Q?HwShAJEBk/AW+qsvA/BCOyg6mNJziL7v+p2/H6ktPENxQuw5iJNDYSdVSOZ0?=
 =?us-ascii?Q?KojEUGLci3b1P6BlUHwnZvcmUqmLRMSvK7F2ZyASzl7qFv1l25eUn0fMs/yc?=
 =?us-ascii?Q?EwcTknVWpJXzqCUri3HvBk53GACtTok/XLGEibWHGQMm1BFMJ92C9OmCPMDj?=
 =?us-ascii?Q?keIAiJzvUfitYkrTbkLESBeyCJztDRf74AIZbmMKhiNUGnghXKIHF0B2du+9?=
 =?us-ascii?Q?3lkvMdfiQIpTWpfdo1XiAZ3smn0zMvk4ebBQ9kyG6cySW9yGwlO/2tbjynDI?=
 =?us-ascii?Q?aqakMy63zb2Ps5Hn5K77AhyO1MvxBLJ53UUybGfARj+FVbFClOAOWYe29eAW?=
 =?us-ascii?Q?0PKBLezNtKG0FUkrOo6MffIHEbrBuZOuwIyktfjOR15hin2npeeXQP5YGslu?=
 =?us-ascii?Q?vMdDACF2sg5qYCHh0PpyZLFqSEVtMrS1i+dnRp68U4BGazdX95M20blr/4d5?=
 =?us-ascii?Q?C2VpzskWiNp1hxw26ZN2enQNaC8HmTAJS08qRtU/Uhmo01+bAsUYPqaJsUcp?=
 =?us-ascii?Q?YP000Fg46k7zgCCJnGNuDz/YvtCYPr6c553/JEuujI62G18GnQu2/VI/NsLO?=
 =?us-ascii?Q?25ZACy/Ed5bz2NYHp5g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7444697c-cf2b-4a05-9478-08de0b0aea13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:17:44.1959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FtkpbVNECkxHh6VnBYbJ7mMA8Wc83Piamw7B+RTzDJ/SSUbHG1ENg+QT3tm8fLDd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11746
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

Fix CID:362787 issue. This patch correct the cleanup
order of PCD and FMan handles to prevent resource leaks.

Fixes: 4defbc8cbb6d ("net/dpaa: support FMCless mode")
Cc: sachin.saxena@nxp.com
Cc: stable@dpdk.org

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

