Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDCC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73CE140666;
	Wed,  5 Feb 2025 11:46:11 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 2FA0640616
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:07 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKO+UfqVc5pMhOJSPaSaM2V+bCr/Lklby69dZfFvbd7tTNQjGej2WvLJ3NWchQXGRqQvViGWNFLnCnTjJGALHQbrs6rTXzjFy8RbEubrjT0aHNeXdGGe2Fj/xAlz0W/BDwgZ7XBhoNEbWBScLdz3CXBbd9pNJtijhjoOqcVukvPCCkvZRwqMElOfBqjRL/F/DqolprLwo+qnOTSC5EnzkVsAJl4gbypmfJDq6qws/fHEdxZoeF/75fhUHMCJEizF5lxN1jT8rhMz+J0n33OJMFdan5PX2uuQV/g8hrBtNWvCGGl5B2HrAiAFKEJidRA1yQffl9LwHTgrn7owFNtnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/BQ0YEzrJw4P0V7zVbt1jLjLyZINQ5awRiuF+vSqMM=;
 b=w0h4LG+f5y6GWzck5BF7Co4vfekpi3B5VR1EN1H4AQPOt6sRSV2vIoDpAm4IDClbx1gzfS0dDXzFsrZ/Uw6cBlY9wMf//o0L7RvfhuwitLOnNBZ00ILiSUjRDfewn9cFQSBz4nEWw7M3xcwlLduSINX2UIfx5SR3tHYoYaCEPcZX4mZsTpCKSzzS4JZt96lxmbT0a3pKPCQeyWI5F/qWoYUmNxykHiKQhDyV4zYUhBfbfBH+nBV642VQlSYLLs0PAmFFPY0j4bmizUylWP9xAn2Lo+RSRrTAIOO2OUb23Q1Abe7Wq8vKVWUe52G6N6gsyLQI9obyB/rXzmLpv7NqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/BQ0YEzrJw4P0V7zVbt1jLjLyZINQ5awRiuF+vSqMM=;
 b=R2Qpx4dKE3udntqT6C2R/J8k7HhRyKuW1+pdFVIdEKq0B5jekSg2hMyF6sqhoe8UEbQe7w9Ma6p381NX/8m+h1l2tRY3vZj0pDBcA1RThGxnOCcQsXZezaoCmBMZtLaU7WyMvOUQf1INSFNMPCY1a7+CD7V3z/TO9S/PrE1OFf0=
Received: from CWLP265CA0340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::16)
 by PA4P190MB1088.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:05 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::ea) by CWLP265CA0340.outlook.office365.com
 (2603:10a6:401:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:05
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 10/34] net/ntnic: fix potentially overflow
Date: Wed,  5 Feb 2025 11:45:19 +0100
Message-ID: <20250205104548.1533554-11-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PA4P190MB1088:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d13f5896-e5d1-4188-d186-08dd45d24a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9tdRsR3YlALdmQlarw/cEeJpk198EUHXHcQdeZkLAAuXnuLCDCtOMpLEHHEK?=
 =?us-ascii?Q?DxgpHnBA8oybMN5n335mpWwTivwkXCzx2OLNpTkvTPsNSTFCC6OhPGHUacxS?=
 =?us-ascii?Q?1rfOZO5OxPXdTmC/4AnJGiND+V728zXfXXmywrgLl9SxD5QpeMjqQZV29NPu?=
 =?us-ascii?Q?+A6YHGReN685CTWvpbN4tq/qmmCy5SqahlXaltpGGXHyS2cUFNcnufcBt7NK?=
 =?us-ascii?Q?LHEjPYwbKdP05LvaTKqmd27D2XFx+0WA1+8obg/o/QG22kIB+lecRFmN6Lez?=
 =?us-ascii?Q?40OEU2E+8spJkKC48zcex0Al0QSQc5IRrc3nGDUcW25c6D4KxOj7omsE6CZ0?=
 =?us-ascii?Q?vtMcUfuzTVzu7+0dQicWAdSIO5nJ5UckCMi2Eu8CDbVzv/Hev0tA/qd4zONw?=
 =?us-ascii?Q?RDAqmYe5QsfmgJ5prblTTjYS0suNk0TQMvbpUoko4KSzI1hYmPyTKYgQ3xSf?=
 =?us-ascii?Q?tJxdhngDiOwasuMwaretkcOsHYU9JZGfxZBw5imdmg0Tb5I3adOA2KrzHTzD?=
 =?us-ascii?Q?1aWUfA1vNLp6JtKkXC+u9Ye11gCe2RuJT1iCsU1X2EbvY2BrDEczSDPEtxVT?=
 =?us-ascii?Q?piUt/AYsZKYeLYBpLpuQ6jJbnuW4KK3sGyUNl+almaa2uCXdNr6eeThUAPll?=
 =?us-ascii?Q?5Y8ZAPhHKmyHJio0ek1Cnq95vbt6z52TXcKQOMFkeYp4/6p3anhcZuk0dls3?=
 =?us-ascii?Q?mCbYCoKmxtgVyW0rkaAvxiio4KR0+uNxCu99Lo7ly9kT2JDBazIlYv8RltnT?=
 =?us-ascii?Q?z/HkogrKP4xXmYJUOKJhXxa6yWt0BpzqmTq3k00j/R7RrpQ/eGymUm+A2Xs7?=
 =?us-ascii?Q?xFDL9CzT4OiT1Br9EU2BC5CIlLCoRxic9JeRo0lSulu3NeLwo+Cdkfnvgvrs?=
 =?us-ascii?Q?WkiOlEIKYbg3GeKkOdnYTXlGTbYb/hl8H7qn4eb3HF/X3tCw1IPVwtnZxw+P?=
 =?us-ascii?Q?rgEWT/T/QEvQAPRx3JF8S8W0x1B2rVB4U0EAAgi8Oyd2pTo4AFVVxX6aTIp5?=
 =?us-ascii?Q?YjT9EoSHfvksaayhW9n1ZuvbSYQxfjFotVjwJZB+LQZiv7NM08rLGxJR5dRF?=
 =?us-ascii?Q?bAYpZlTxFe5lTELtMMWKWHpbQZl1TyqA/jj9F20pZRgcWIUmndXFxw9PbsC/?=
 =?us-ascii?Q?eb6bZ5siA7SXC9CsM6yNrPaB2beDsqv6AeVTiReBhO7Xj0E5BRm4gFJEe5K5?=
 =?us-ascii?Q?EXSdDakD5W0+9KI8eK3vYriuISRU+8CdMd5w6rNbUdw2dFBoNqJ/70+qiF5P?=
 =?us-ascii?Q?w4T4xcr04LavuUAj5x8IUZR3IzHirSysHbryI1orV3gNIX6qPDSl7zJwISSr?=
 =?us-ascii?Q?MuzSj1qa/ixN9lr1i57qk4Fc1sfU7FOQOkrUW8TO3EM2khLwpkLcARExQuMz?=
 =?us-ascii?Q?kh/a9y4si2PJQfKc7qOSFbUQa6OplVbZJnlrpkUbqJDti77TXje2QlNiL8ch?=
 =?us-ascii?Q?aultNUPsS9nB5mxDlBnBII5yQDYQfdjBB7O2pTm2P3VpFggMhtg+7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PEvLgo/r3nzSxZTUDFF5L4suAkoY3tRrtEU6NCuvuVPGiqzNu8v5ZZZHsmsX8/1hKKxrzCd5Ru0+UkZjZ0r07RQBFkCu5lU9HGDzE1RjXPurMtcvbOdsxb8uZI62CMRX/EEDjXXSLWS2ecXjsn7uOxjgNJuQrYGneKK9AoiHz1OWuiMQ7qnPf/xqMdJ3KGHYEuYx7ZpcZsupTgPVBvmui07oZSsURzzQ22hhbgCCdyj87xzp9iiS8sRLcIbwByJzmIPTDYV4oor3Yd+dVKZeAPYjcC57LajQyrd3Fj61v6jHIve5Ozg4AWcY3FVTjqMzK5WS6AhpSsvQ2MkiCGJ2ETuVjeKlhhcWDrS9rNyAiSgDXZ17oq71ZaYIkcL04GmwBXDdh/QbLI5uJTfq4K9moUuk96NSUw2o9qXAkMXVfcqwmxoqZAkb5N2lC2hX3cl/cQdnf5YJjd6/Ghxg7BffG0w9UPMA7K6ZnhyvxAoyblKmJzTxNAE350miohGp57brOsY6AfeBCwHBea1cg2Qv56S81apxbrqDOks06Z/tnDKoOz8mmMeBoM4yfOCdoqcZU7n9bX5nnFnygoaQrfy1mbXzTd7Ljbuw+WyOk47KECjqozEMkeUoj0ImpffQw7O0EDIU69EXsdLbvhbgxt15tA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:05.0739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13f5896-e5d1-4188-d186-08dd45d24a84
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1088
X-BESS-ID: 1738752366-306009-7768-599-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGBmZAVgZQ0NzU0iQpOSXJKM
 kgNcXCKDEZBA3MDFPTLBJTDBLNlWpjAVBFCxpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan20-147.eu-central-1b.ess.aws.cudaops.com]
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

Issue with potentially overflow was fixed.

CID 448944: Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN)

Coverity issue: 448944
Fixes: 339ca124e659 ("net/ntnic: add flow action modify field")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 535047d246..a68c3ea702 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -1632,7 +1632,7 @@ static int interpret_flow_actions(const struct flow_eth_dev *dev,
 						return -1;
 					}
 
-					modify_field_use_flag = 1
+					modify_field_use_flag = (uint64_t)1
 						<< fd->modify_field[fd->modify_field_count].select;
 
 					if (modify_field_use_flag & modify_field_use_flags) {
-- 
2.45.0

