Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F60C02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BBB840672;
	Wed,  5 Feb 2025 11:46:17 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id B79754060F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:09 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2175.outbound.protection.outlook.com [104.47.51.175]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI7cmWxK/ysmVFEfIcssJ+gkmB1EizQO5Rvdda0qIl1HJz69InxfEYjCc5yuISDbwjmpwAy4zfv/43pSHXd7VyLlIgCUhGb3k2QmXIIymjR36ptjTr4YPrWZpPWtn/flfaPz6xatXX0ZmZ9U7eO+AWieJyU1Rm173ZfOhpIEwbRCWU57TtchbMrDZZksJK6DENnZjoPwAwci+xJWniYevvriORKKxnJ/eFMr6KBkS1kySaYcDu4KGcrWLVbTGFI+P/kgZxM8AbWk6KIPcsBIB8D8ky+0pkOuCmthzsnOl2qPqfWYbRsZLwiUIP2/rlkW17uS1kzEery+wcxLdpp+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T2x73jL5Qn5jvQnqyabfIRApLBkLX33/SAHRPkP808=;
 b=to0kct+PWLfEg6vDEuTEtShiWqYrZMDDf9LCdbPcxu8UlADJ+kfN2jXBsqV+8E6bWTI9oFkTO2BOjuHzkLz3xgSMvg/2CtgSI2vbD9bjLHhJQQ9ScTHm0zaFUS5I2B+s8dRczMYdA1Y3kXh0yY6r4TkSxZpaWEpYTpSiv3D9nNLZn30jJnMV1KcnR4rbF9aKXl4xSe91V+hUiFYVlIQNgZY/9fNGuo1+2BRimG6Vp/tlnV1sUkq7iVZMDBKuMPzm4OzhLWrUjVzQO4AS20jECTXDzXw2YNSmoA6zdsBXb+k0YeUUhKoEOCGucTjjrGDJB5B2kgMGU7JMT9CqLjKdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T2x73jL5Qn5jvQnqyabfIRApLBkLX33/SAHRPkP808=;
 b=g48nuGMmAPvjgjou0iWcifoW2vrqOIYnqMk9hbOMZMQuvHBYkkkPpzwf0wxF+s5XpI9YglEDdTzZ/RlMz6Sb9/GW4MYhw5HHpAcxNFaSFw9L5IReeSIe1APBAb8Mf+KoIqcr5/NGM4wIVJtWAX/1QcdQD0iuJXHVfhq6LtQC8CM=
Received: from CWLP265CA0347.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::23)
 by DB9P190MB1068.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:224::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:07 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::24) by CWLP265CA0347.outlook.office365.com
 (2603:10a6:401:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 10:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:07
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 13/34] net/ntnic: fix untrusted loop bound
Date: Wed,  5 Feb 2025 11:45:22 +0100
Message-ID: <20250205104548.1533554-14-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9P190MB1068:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b190f937-a88c-4f12-3858-08dd45d24bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RgG3vflCT8WqXqOwcsCuDlOFu1AamJkwkDP7fSPJmoY47i2rG7ysVvCilyR3?=
 =?us-ascii?Q?7W5wiGlROaRXBtpIHoPqDUUuJJaHoUAW/xkeSqpT5ucyqpXXKQK2okSfFJej?=
 =?us-ascii?Q?oRi86nhnv/LBpR6tBdXYQlUUKF0e26TjPBAgv26kWaFSqcgo0V9B6Dput1gc?=
 =?us-ascii?Q?59uGbKEMRs1DQxw4nEU4cAw+yi3nl4UjRb/D5BTOx7jTqE8oNYzRbr0wxQ3H?=
 =?us-ascii?Q?uc5QzVJuvOT4jYAQJUVhk/uamwFvEU82pFk9F8MgJITiG3Lgn4rNcDfIoBRs?=
 =?us-ascii?Q?L91KsEDbwW2qe9FV9bkD1J2/7oFENCrn9W49pBYW6TdsTQeipea/NanVO8lN?=
 =?us-ascii?Q?qHEiizYafN94ieqzDSAcvcRVmNi1fKRgqunzXvHHlByG1THsKO2z2kbNck8s?=
 =?us-ascii?Q?NutogNOZ0B+/H01JycYNZBViuozbeyu8+MEjF1eh+sSAKKMgf2IWA+GvjGsB?=
 =?us-ascii?Q?uBMg8hPTlIdiv3BN0CQxY2wmuat7nhbtpT/7IYI8jlzwnRIiDlJTPU0NqpAi?=
 =?us-ascii?Q?hy+DBnXTG7HkCVJ/L90Tg38PjJHTDTtlI+8uqE+/huB2Ppz1GpfeVSBxJS+M?=
 =?us-ascii?Q?B7PO4AmP7OYG2qBK57QEXHI4nEsoLUp+00qvCuUP1cuuGtE0vQ6MFuOLfAdR?=
 =?us-ascii?Q?iSPZLH6pcDckbXWfV7PO1ll16brI1P7gAxQbLmGNggxhILObnCuLVbQ/3k/3?=
 =?us-ascii?Q?1+9lPauY37qbVI6AIIZU0P+kjqxdpInocgfqMX15hU7+lcn1a3EqW9x7uDC+?=
 =?us-ascii?Q?H81Lqr8meMXpZpieuOgbuaiuUpHGkGlb2ZaqW0/2xzyqe7SJw6Gz6V+fkxdH?=
 =?us-ascii?Q?4ceTZLZqoNHbT/HI6meFYjGgltD5WMz7AX8GRCzG41lFUqTSek9wfkWIdGy4?=
 =?us-ascii?Q?yqxGDUKOAFrQrNUKkP0qeGBEqbBLOK/CMznCtJhHJcBO0cGC0cLzuT8VOH6K?=
 =?us-ascii?Q?4nUpbaGwdPWli/Rukc21qD0WCiN9GxgfI4lKPPHdytb3Z0r+zXSq4W29MVW1?=
 =?us-ascii?Q?I/1Ri2FBH9kx6GHB+FgHZZ75sDfC1qt3dYYYsFfKOoBdRnhdMYuyLTYsNA+8?=
 =?us-ascii?Q?uUlmmX46NSs1G1RirDUsxgJ9lov+IQtG2IockZuu+txml/RMTiVq2daVkLyU?=
 =?us-ascii?Q?A1sX1FWODjEWFPVy8yQvkNEF4DDjC49zTiBWAbivAZO0PerzszVWmaNdaGVR?=
 =?us-ascii?Q?tN97CUR64SaRqjKZM+aV3WuKiYFVC9y6T6MAzmhE4u4Mv8ENxJjFFymrB9++?=
 =?us-ascii?Q?S68iFAbsffMVxPZQVxurIYOwGPvo6Nj1HoFkQF0rbMyz5DG7qvLQGI/L9XjD?=
 =?us-ascii?Q?8cw/eWRp82vjQUncahwQb4M49qZAgIjuINYa5iTHG6Bavf7Kdj3KQtWf45mu?=
 =?us-ascii?Q?ejTnsJNqorWlLMScniyqSO0OPOVPSVqun3lYECFr5BPkUl9IuZliTe1e+h1J?=
 =?us-ascii?Q?9c9LKlK7hvt/VJp//IzK9nfl1XskrN0PszeaJjKLXH+CBN3CvhYkJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TEewlCiWJzhfI68KRU/ylwymt22AW0zjZRhPvB8QWAb9lZgsUzspoBUSaux8EgXxYOnAcoU/j+eiMlapOX3DeMcrWqDgJIGyviE8WWdjY1JKOVaRCALtkXvt1KsR3hXML25Rd1HXY6e2bQTSnQjwaJMFGkrcBPdcVHjUgtVOyrBIIgDcmBG25k9jaclC9nTvEMcrZYxqLQzPHbXmZRo1w6DAFg6HGuuD1YojaYhEhGlllJ7PkRKseWmd5yFo8ik4lmL6pjoj6js4MuDPDsGqvOt1SxWoC/AW3Qe+VsQpcyPBOFSFOjTMWIeySWnOisgAy1sJAyA5wYzO3AKxmfdD51BJF8w0CHWVsTebjoo+SLbkp0IDyJkgWDjnPYHKeHrCSmgoXAbsRGyAQ90OAhIW2gEGkgMUedPMdO3HNlvaCCkK2OsuNeFYYneAV7NmirVyhNe+B0mCEZerlvY6KKlZukNLRK53NDFN0leMr5yTvsYqRALTWA9+kCsKnjK5U3Ww1Gor9VsmV7Vckw5VzfU1CFpz592WAxEdMQyAdedBOlEOHEHDekG0fPpwrAK3G2G+sTcBbiayGDPNEJf8d5pSljYCZcsziJx6saSwPP3GpC02u3yzzpOAsSJxMxLuKv8jfRnnYPIGV7H63ROOI3uTBQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:07.2458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b190f937-a88c-4f12-3858-08dd45d24bd0
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1068
X-BESS-ID: 1738752368-311016-9613-501-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.175
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGlkZAVgZQ0MjYxMLSwNzSNC
 05yTDZPDEpxdLAINnQ3DI1KTU10dhIqTYWAM6eS69BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan19-16.eu-central-1b.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Replace while with if statement to avoid infinite loop
in case ther_type will be modified with extenral source.

Coverity issue: 448917
Fixes: c6821abf58e8 ("net/ntnic: add flow items GTP and actions raw encap/decap")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index e00b10ff82..b07e16c1d3 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -53,7 +53,7 @@ int interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_fl
 		goto interpret_end;
 
 	/* VLAN */
-	while (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+	if (ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
 		ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ) ||
 		ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ1)) {
 		if (size - pkti == 0)
-- 
2.45.0

