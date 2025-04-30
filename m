Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F6C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4F72402DB;
	Wed, 30 Apr 2025 15:49:20 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 536EB40279
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:15 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2107.outbound.protection.outlook.com [104.47.11.107]) by
 mx-outbound42-181.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYkqz7mKmS43arMh4CYNOxDsJGzltYVFU8m70Z5AZxJlZoSTKQAT7ugHN3iFFm3AtIAbHQ+SL0KGVEdi2GILtI9enDlhQzkQol4uJNbNuFVlzeuLJvli2dq5kScb/XyYVLn8kYrHwwwCzfKnaXMtU+uU27aSGGdtjdfWNVUi52J11R0FokzpHdbtacgtZdZi/KXsvrWYWmvLNABAndhMOHhb+9FCLRd4HUyatsvd+nYSXlpiP8D+oGMEWdB7U8RXo4wgpQG/CkgFGbHxY+yTwTStOLzpxuO+hZ1f7LS1GiXKpshXYCP9jSEILbxnI8vze9NftG4MwaUlD/tpmX4T9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIrISKNU4hn+swioLwqTypCJ7PpEMe2nz5PWPpIJKGo=;
 b=RDgg7peZ5EceQs1622erS4jinHhW3PAwDTtGm6Rso7lFCUaWfcgt+smbkNJbTdgTTg4G3AwHXCXp8E1M5z7SnJXnAsSwXj7O8LleT6JRRy2cAN1Pv59PnyOL/2crHf22JOtxKFyhAKnpsVjEcZpyQPWTmdSVsqph8UihXbgaWmv0Jv1D4aUnrXSNKFfN/iSYQgoPzhohhJoJd52QxQR3bFjN8YFy2vohYuR/rizFEZqHz4xq4bheSjsmt/x00NzTWnLZ5JnMrpQnoVd7cDd6wfV0YkiK6XcdnKbR5daNuLq0v7IZUYtyDtAZ+O9aAfQ2qKS+D1R9j8RROoN0sp2TKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIrISKNU4hn+swioLwqTypCJ7PpEMe2nz5PWPpIJKGo=;
 b=W8cp4Wv3KxBrdEn4q/wX6vWtWWivgboXJKGl0kE0Bv/118+t1xTFj7NOXtTLF1klJMEIaEeNIwbwVBCbFiqqDmytiHyLhfu03pnZIwnzOV6DKy+QyEnZERfktugbbAWF6bVW42LjW3YM2SwAfoFAnCDpmaoPCKJNaPN+aQayG9U=
Received: from AM9P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::28)
 by PA4P190MB1087.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:102::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:49:07 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::a4) by AM9P193CA0023.outlook.office365.com
 (2603:10a6:20b:21e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:07 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 02/25] net/ntnic: handle string truncations when using
 strlcpy
Date: Wed, 30 Apr 2025 15:48:14 +0200
Message-ID: <20250430134840.402553-3-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|PA4P190MB1087:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35467d83-bb45-4a43-8d70-08dd87edc708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+MGCGy17WIhle/GLNUCnbQlUyuk+NTi2+KGVcjFDKjq7PZqi2DjmpIqwkUuJ?=
 =?us-ascii?Q?6sxeCgz9NpFssuvAXC/lN5nTbHNd4pCFCZbmHlzaIf1R0OixSZtf5erXMcSm?=
 =?us-ascii?Q?fNMvwvszwSiMtwY6zRa4MuzZeh156Tmh3IUOpVW5QYJEovi///PJG5SIt/0O?=
 =?us-ascii?Q?Dmz+nYyWAPt2lV2P2IppDze4FwZ8wcpRLPo1WvtK80Vcz5gBIks4OlshK4v+?=
 =?us-ascii?Q?0WgjxjRXJYaX5y6TfRndH9WOmGDkPN3Syf4dQMtSK0o/u8+sRUmuUyhPcXYL?=
 =?us-ascii?Q?h9Cz4IbNERmjzDIJQe1q7hiX0r1gz3YRrN2RGyy8VpyAveIkR19yOXAGkTyV?=
 =?us-ascii?Q?JJSCOh28dAkEOjX/XYqCL0/wot8SSuRL5YbqYYCRFl8mkMMuP9H/jMyaesgh?=
 =?us-ascii?Q?fDJeQGdUowmwEYyqv9cT58r9lp3IiwcWwGqhwcjhYkzHEFNEI/OzGfWTDdCW?=
 =?us-ascii?Q?KTIagdddzt/8A64Ie1cF3/TX+sLZj3G0VR+Jc0ogYjqkuuQpCmArfhW4Elr3?=
 =?us-ascii?Q?dZH6NGIEm5MbchjoktxPoH5XO47PGEKTJ/Ms6jdwsDxutxDW0ETGPEyZG3Xr?=
 =?us-ascii?Q?i+4NuLKf5EJhR3Nu5v1DC/P9xveGZ0OH9X1Ivj3Ydhoua2lhi3VYidHJIozu?=
 =?us-ascii?Q?ojAdVJslTDRX7q03/Qb6fCFVSpyHDGJR3x1jEb0j9xiN/SHXiZrVUy75iCaT?=
 =?us-ascii?Q?yyPnPXl/+bTnYNgSXbFpJ18i2zwAkRF61tjcMHCliVJxnotZgqoSOo6pnJaD?=
 =?us-ascii?Q?3FVbEJzMx95ARy0wzRwNltMuK3WPVVL8yA/XCh0Z1pmToa5C9pfJj3XpQcAn?=
 =?us-ascii?Q?yKqr4SfOC5bsJ+1L1tdm21W2ANp6e8nFijxvTlFnOz5EDcmaBqqyfYqqp4Nm?=
 =?us-ascii?Q?sKssg0XWOyckwfCiZ1Rx1H5zo2tUtzlPAtKxhnhkGs9ybvWtWE2799k9EVlN?=
 =?us-ascii?Q?uYelXmytlF2uQGif8ZsaMJaCTITDjPlxw6w1mGy5y3FXRVT64ZneiuxzGRQE?=
 =?us-ascii?Q?tPa9wMHVPm+rKlObAawJ6BJY9Z+wBkavnpRAYfX1TvwSphV7uyuv/fImGlwF?=
 =?us-ascii?Q?OjnL5yQ9TvgJ/dPABo+ymdjEtkk55hpywmGEsLCxd6fB56qfe0CRpF9RI4PC?=
 =?us-ascii?Q?yCcPDV/N/kKfm1SY5a0seKA5hVlBthE/zsHFOMR7rZlfVOcpzI5mdqVASqN6?=
 =?us-ascii?Q?zJPQSBeoJgYcNxHA0UAfeNkVZOUCnQuJ55+eUKDIGEqXY/qyJxHSjF++qrgN?=
 =?us-ascii?Q?KS9ShzSU0fPFkQFlK5qcPo8t6xkAY3ubHokh1yIXrwKJ9OAl6ws6F6k45WCB?=
 =?us-ascii?Q?Te0lImI1AdR3IzHl+RAhW50HJhfU5U163VWwVcOHg0Wl5qZ6rgu5ildJ/Kt2?=
 =?us-ascii?Q?ijBlXaTD5RC8mK7nRVa2GYUrKJcx4/YEwSU2ZbZz6c9hxrvAy7yA1Ta6MAli?=
 =?us-ascii?Q?v6BG9KiZw9CNTmZLb7f/nO9bHMeE8fImxXxiNGRJoMYAx8SPqjevSQnKqKyD?=
 =?us-ascii?Q?T6XVmgSMSsYGW6Ejp3BhDJ/jp2+2av7CeXMD?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zlLuKBKQWcmEWypMEYaVwi5oBGMdroflQ4UExm1M+L0OGkmn6uekg3VJotXyxbaDma8mXaBYqW7e9s3ys3dudsz6hzaJPnSiTtZQ40QuwYviK9qqTl1KH3SyLKPFTZC+jei+KQjE05OvAimT6ORpkbQuFMRCrEZwpS4UuzcLhKSfXKAKTwyj+kgxoCOUJxr31GNALplce+de21XT6i9YLJwtzJK48Yej12s1xbj5E7rbg3i02ol/jbeuAhEORC2eyc+eUnL0q7Qu3KHB0qFwCCMNOpgM7dlT5OR1djQYTJKP5/yZBecQWzU+DTc7ocrNl/JOCCXKxHM8KNGjbL6OiRKxStINqJt4MKsjVzLNCTXSMNaYU+6B8cBnO3mfSupWkeL8zEsjwZLGIs7B++7CBuAynPUe5ORZq2RX3RENLDOmUn6soxfVDtvF+VDWvdLlo0a8/lNiYZQUft8W7wmYhHW4PvsJnEpQHs+QzcZi+NA1NQyEpsxX+afCrpgAFEdPANYZ5ULEJWrQCHoUffzcrqIYi5oG81xqTCX5CdJHUzB2Tx96ywxsltTAA92Ie1cL5Osw8Pn9nPKIGtixN83HBD+0VOcYEdmOCbmqF4Cid5vX9efSvj150l0/niGU+kFs7q/UfXPiJZs8bbjnA8QBbw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:07.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35467d83-bb45-4a43-8d70-08dd87edc708
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1087
X-BESS-ID: 1746020949-310933-7999-567-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFmZAVgZQ0DzV0jjNIs0gMT
 Ex2djS0tzAwtDY2DLRIjExydDE2DBFqTYWAPVyNUtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan9-64.eu-central-1a.ess.aws.cudaops.com]
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

While strlcpy prevents out-of-bounds access,
it allows bugs to remain unnoticed.
If unexcepted truncation took place,
the respective warning message is emitted.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
index cf3271d5de..a26cf5a07a 100644
--- a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
+++ b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
@@ -758,7 +758,10 @@ static int nthw_xstats_get_names(nt4ga_stat_t *p_nt4ga_stat,
 		return nb_names;
 
 	for (i = 0; i < size && i < nb_names; i++) {
-		strlcpy(xstats_names[i].name, names[i].name, sizeof(xstats_names[i].name));
+		size_t written =
+			strlcpy(xstats_names[i].name, names[i].name, sizeof(xstats_names[i].name));
+		if (written >= sizeof(xstats_names[i].name))
+			NT_LOG(WRN, NTNIC, "xstats name %s truncated", names[i].name);
 		count++;
 	}
 
@@ -795,9 +798,11 @@ static int nthw_xstats_get_names_by_id(nt4ga_stat_t *p_nt4ga_stat,
 
 	for (i = 0; i < size; i++) {
 		if (ids[i] < nb_names) {
-			strlcpy(xstats_names[i].name,
+			size_t written = strlcpy(xstats_names[i].name,
 				names[ids[i]].name,
 				RTE_ETH_XSTATS_NAME_SIZE);
+			if (written >= RTE_ETH_XSTATS_NAME_SIZE)
+				NT_LOG(WRN, NTNIC, "xstats name %s truncated", names[ids[i]].name);
 		}
 
 		count++;
-- 
2.47.1

