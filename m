Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B787AC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C5FD40611;
	Wed,  5 Feb 2025 11:46:05 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id AC104402DF
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:02 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yttqx4+oXMq+jjlPTOq/ZFEF7Vtz02yIp4OURxJEu70bIG4WUu2dCzTsHf4QVYwxjhhWKP1kn6l48y2gbrNI2o0jToxuJUqL7WHee/ARiTTZxeZ/zceaRoOfyEEfV2pj9tfLbJ7bY1IHhxhmS/lgP4CH34B0S7tNi9tvVhxUbKcZ4kMgRUEvAQZCaitpPB5pVXpU1nn4A8Zx7+AkmyTmnKgwwLKYuWktb4m+sBsB9GhOKZg4sxBwVijQUM91+xyGsSEaDsRQVPQuzFlVjKRMRSMWDCbFHB4tDO1vz2ncCmd6SUfIFwTBo13wTQ1NQQQEDPFMzqLiqHUIo+ULqXHtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkNidEHEOTLd84GD9ArcbZWOvIXiuZEOEV2ZnDIP+/c=;
 b=JIWH4WFX1U2gRwkf0NAHXaPaGths87DpGmuakEsLQ+EfzjwoksKzD7BIJeUjhFr7ahpC5BEGfssCpxD4HSwXFaa75rnjT7qXI/s+iuLXa+2OLKRRTROvdN9fkIKOOz3uSqZx6qEmstPtgoUksVjfnRlQUOzGzxCyKlqr8XOAGBhp+Mx7KnTvBDC7iDVntIljSl2ctGrSV5Dn1vqzkha36l4bq5Z3YX2AF1/NcPNo7WxXzyZtj8jmHyWXn2UBT8ps2UtQTsYkAqeeixvJAnyhlL4u+wngUOZUMlJijJ8nPIMrTcIXuSt0/WeFspUCx+J/DC3s0zjkoDl+5CsP/+TLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkNidEHEOTLd84GD9ArcbZWOvIXiuZEOEV2ZnDIP+/c=;
 b=fSYqejPSiFvBzNLA2T3iJ3N/W6rP4lKq96/pqZ8L7U2PWEuXDZ0AwO4LNC3lb8B3GIP3i7xVjamUq3A9PX427w9anBqqGq6ObLoOj9HiaRrAKqY2Bhi6l5IbqWsMb0Mbnsc2B1X3iPqh/IyDCvdEswM5E6gkBbeue4YKbnlLX8Q=
Received: from CWLP265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::15)
 by PAWP190MB2189.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:468::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:00 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::b9) by CWLP265CA0339.outlook.office365.com
 (2603:10a6:401:5a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Wed,
 5 Feb 2025 10:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:45:59
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>,
 Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 04/34] net/ntnic: add array index verification
Date: Wed,  5 Feb 2025 11:45:13 +0100
Message-ID: <20250205104548.1533554-5-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PAWP190MB2189:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 36e8aae2-52d8-46bc-ab6f-08dd45d24712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NbiwjP/p/omgs7oGpkpQhxlDR/afPdlYvmBhbfBNCbFmd11FHXq9PAQiqAec?=
 =?us-ascii?Q?81iUxyrOwVFJD1hgrEFCApkCHI47QSC30D5GnQGZDsE7BTKmkcyYC2hiCJWa?=
 =?us-ascii?Q?0BHVYP4dh9YrDR1KuzFbGi4moloubB8VEMJt1KxoT44759CjhMSSnnDhauGf?=
 =?us-ascii?Q?s8dFy4IflqCuYouWDPT9Hh/YTfopypKhisXsn6pEV2uw80AaxfAqkIwXrhaB?=
 =?us-ascii?Q?XKPLUGBDnQsUvBP30DJtczNGefLccYr/K7I5mMYZ/rEKRxcM5+78Nzpdjby/?=
 =?us-ascii?Q?TnEsPF3yhcC4LqqnvWh7jKxX7ufispzf34VB/deOI1YYvm74y3/eHBHTjZIp?=
 =?us-ascii?Q?RyVvoqaz/YwUAm1N57Kr8IW2UsqN+kLt4D10vFqaWxeFIfJUmwIacyWkmc3w?=
 =?us-ascii?Q?KbLNwqEiR70x1YBZzTIY2wQiY/Ndr2tjBMkxn/r++/FpXyRAg1NfR4945f0z?=
 =?us-ascii?Q?F/aTAwlhNrvpWewKwPf3UXpayVI9kN1lnN1uU0pWUgyeckKeGtW1piS/ErKV?=
 =?us-ascii?Q?ItkutC8GiGIzPTQ0wc+6svTEssc+C1g+p5E3FFtaONTbLrUDMT32n80zngbV?=
 =?us-ascii?Q?azdwEIQxmULMjje/QqVf/FnZrdvbTUdhU0z7TnfpUtvNDnxmFl+f+qt/RNrn?=
 =?us-ascii?Q?lG9lXHZjI/SIXItRU6JrJcPO9YmMgU5po01A6C9L/KPT7vOSM/tq0sDndmfx?=
 =?us-ascii?Q?fuAqGqFtqjBILxv6UIS1gpyQLMP0Jd/hO5T7h6ALTP2g8xaq0JV0CKnYqGux?=
 =?us-ascii?Q?rR1f5U3zEB/N4AlIzp62sh2x3YEWrfRZOhpSo+1+Ctjtmrfm0qeyB/dyYlEj?=
 =?us-ascii?Q?p0+a8ESqxkf2aJmYi66Td5nv4EQciUSQSPfQ6iGKCoIgCd1DRV+l64WchGN4?=
 =?us-ascii?Q?e5EnbaE6zw+QkFrHCMqP0I6L/5VtBpTcKvame6J38VW7xaqTPiyufnDAfFgZ?=
 =?us-ascii?Q?QWqAKtk7nay7a7wrf4X9vWoCn0VtDb4tCsrohzoLpleRNKCoqTrsrMSOK9xr?=
 =?us-ascii?Q?PLBrxbcWBCG2xSIYSA7M30bRqOTmcBQnLdIau8XxDq6D4GUi/zesgmL4R5ig?=
 =?us-ascii?Q?doeegSFIuiYVCuntofetJIrLN5KYXu5XHBlfOzvuvMIFg9P5CPpaKZ+N4Gof?=
 =?us-ascii?Q?W32k2MKJ5nkoPn9v+/2RTXfTWnEemrioJcSDHWGsmWr61afUcLQm0c2dFs1Z?=
 =?us-ascii?Q?kKNJA4/XFurYMH34icJFAAo1n8nkDNQOR739RsNvT7qIwOd/Z7VMlrzYKSDw?=
 =?us-ascii?Q?hLi1/r2Ts/BOZIhd02TrxW+ivEI9Gdm+Sc2oJ+G13cQjx5e+86PBhI0egrRO?=
 =?us-ascii?Q?QgZ1ERQHkUMAOfX4aO2GiRL9gqbL1A03PRS8shm+6AU5JyPtI9O+BlhD7O89?=
 =?us-ascii?Q?BArxtwUbrHb90xhg/J50zFOovUtYUKWrVjMrmSln9OBQnjV6CojaXzTqHhJl?=
 =?us-ascii?Q?DiCRfc4g7bBbWfZrbSy5Lui11YsTc/D6wuYv0lJY8In8oSdskYVxc+Vq0ESE?=
 =?us-ascii?Q?CSzowIxSRjGifSk=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9qrt/dv3zASgcNvAjPNd3RKiUfw4LIDKOPuxkWBAPmtnPBuvHLwuVUuefAv/fjBmQ7W3gvbbZKQ9Gn64Eg5Htcke2YGRMpdkD4Bd3dcD0AWjDKJkVfasVRh8f7sAgO+f+Cj6O2LQdIDj0NLtIth0oh7qoZcEwvl9Tgxg6A3EhAlt9DHE7YSmI66eH6UMmZyY/qSHwFDA2/MJGL44ruKPV+weR01Fmckcy8mhW23+v0tDHEgi5CwAdvoPYq6QDteQQ7bxf+F43zJP38X6pl0AcoQpw++JmixyImg9GmcwFwSYjhAh8CoAqj3I3CtwWlb3FJo24mftml1uGobTBTSvj0dDGUxQfU13gxCxIqyPWMRQm4Lu45cyZjrOYUFcJgpK3+69gXhQaXqL6AHfj9TVv1NpChxYYPQLzoiYdsHLqFYX4N4m1N717B+qo4LmWiAmVYiU9j9UKkitulVpLFykExYOrrY5pYHCY/YIC91yEVdAwdCX8TfxfPMQRSqUFnWafHEXRWR6qe9YI//FUW59bQhoebBStS1YQPADBUkd0wtVYk1YD05ZMibOOLr6mol1LH3fVbLckJ6lAEyfq4u+RZgF8U5nlbfuUTJBJGaJq8cYTiXFIudHSydkHNIISRFyAhJqwSSNW2em+HhFgFcsNg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:45:59.2770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8aae2-52d8-46bc-ab6f-08dd45d24712
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP190MB2189
X-BESS-ID: 1738752361-306009-7769-589-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWpmZAVgZQMMncwMLS1DI5NT
 HRyNTCMNHQONk8xcjM0iIlOdkkKc1UqTYWALA9U/BBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan13-35.eu-central-1a.ess.aws.cudaops.com]
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

CI found couple coverity problems which were fixed in this commit.

CID: 448983, 448980
Memory - corruptions  (OVERRUN)

Add check both indices within bounds before calling the macro

Coverity issue: 448983
Fixes: 6e8b7f11205f ("net/ntnic: add categorizer (CAT) FPGA module")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c    | 17 ++++++++++++++++-
 .../ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c    | 18 ++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
index 1750d09afb..cc8db2fae5 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
@@ -121,8 +121,23 @@ static int hw_mod_hsh_rcp_mod(struct flow_api_backend_s *be, enum hw_hsh_e field
 				INDEX_TOO_LARGE_LOG;
 				return INDEX_TOO_LARGE;
 			}
+			/* Size of the structure */
+			size_t element_size = sizeof(struct hsh_v5_rcp_s);
+			/* Size of the buffer */
+			size_t buffer_size = sizeof(be->hsh.v5.rcp);
 
-			DO_COMPARE_INDEXS(be->hsh.v5.rcp, struct hsh_v5_rcp_s, index, word_off);
+			/* Calculate the maximum valid index (number of elements in the buffer) */
+			size_t max_idx = buffer_size / element_size;
+
+			/* Check that both indices are within bounds before calling the macro */
+			if (index < max_idx && word_off < max_idx) {
+				DO_COMPARE_INDEXS(be->hsh.v5.rcp, struct hsh_v5_rcp_s, index,
+					word_off);
+
+			} else {
+				INDEX_TOO_LARGE_LOG;
+				return INDEX_TOO_LARGE;
+			}
 			break;
 
 		case HW_HSH_RCP_FIND:
diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
index 59285405ba..147a06ac2b 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c
@@ -131,8 +131,22 @@ static int hw_mod_pdb_rcp_mod(struct flow_api_backend_s *be, enum hw_pdb_e field
 				INDEX_TOO_LARGE_LOG;
 				return INDEX_TOO_LARGE;
 			}
-
-			DO_COMPARE_INDEXS(be->pdb.v9.rcp, struct pdb_v9_rcp_s, index, *value);
+			/* Size of the structure */
+			size_t element_size = sizeof(struct pdb_v9_rcp_s);
+			/* Size of the buffer */
+			size_t buffer_size = sizeof(be->pdb.v9.rcp);
+
+			/* Calculate the maximum valid index (number of elements in the buffer) */
+			size_t max_idx = buffer_size / element_size;
+
+			/* Check that both indices are within bounds before calling the macro */
+			if (index < max_idx && *value < max_idx) {
+				DO_COMPARE_INDEXS(be->pdb.v9.rcp, struct pdb_v9_rcp_s, index,
+					*value);
+			} else {
+				INDEX_TOO_LARGE_LOG;
+				return INDEX_TOO_LARGE;
+			}
 			break;
 
 		case HW_PDB_RCP_DESCRIPTOR:
-- 
2.45.0

