Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6BC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD9FA402E4;
	Wed,  5 Feb 2025 11:46:02 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 085C040270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:01 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlNdqjN3z1PMTdmKDFCf/OhQRWk7+AVmqZSozVJXVE7SvvVbiXSxczARS3T+/PgEtUawlBemt0GaUt2dpLupMkUk+UPzMrUAqm2HjtZL1exJPl/KN9EzYhgYukP/hoMWygjwHrTlFFilcubSzAkAwkY0PRc+zMxtRb2QKdTQ7tHPH0yo7GBLh3DZe6cnMxJF3DoQsZMUKLZIEZFwXXWt/k7y3J5ol7Ivy+Smo8J8HVdj2VaN84tVD5BIWgNXNlRaEBaH56pMvD0sODepUOOBZdHNmjaZFcOYqVJwISCiyDYzG9xeyqYtmuZhjuZ4F9mm689wmVKiW1ifVymNfFHMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIDWmYnPEWwG8gGVTVuoeXccAKULQbRmMDi2w5LpiRM=;
 b=A6fQI7rsbsqJmTC7t2ZQQ1sMYyvCr6AJporhgAjQoykrCEEVcEmI3tD54ErHGlQPWOylESzhDsNEYZxDLxNP7WTTp845hg/bINp7JTEVHJqoYdBf5FPvlmHROAo42Nxwyi1wGRpttxa6biPxNahAfecBwZL7/daWRo7kt6QPfvW2J76h8ff7XgJ9awHNtCQYZCrg38Hg0b+YpLW2UC/DHlsEK8XKWuFoI7Cw0HyQg/4M3Zgihcn14T9l/cPhKnAfmD8aSbPdiN+7M2BKWm7cdwlL49mpLXLAJGZuzRUkcyUl127eEOC0dUSPe9YQMU5hbmJB9RUMjhRsDRgLfI5eBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIDWmYnPEWwG8gGVTVuoeXccAKULQbRmMDi2w5LpiRM=;
 b=kWEuIIpcmGmyCLrCdUfEGJ4nd8liswBbc07NGgMdHswaivqESIfddmdQnz71x8Mmfgeud/U2VwJlM8F1HhUfml1VvI2VP4jm7ZoPqwiW1TPlk/VkhEbxVH3QW9HKw1C201p5fSASoN9HYnWZRC1ZS1zOmvPP9WO5DaXQFY3zqZI=
Received: from CWLP265CA0348.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::24)
 by DB9P190MB1195.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:45:58 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::20) by CWLP265CA0348.outlook.office365.com
 (2603:10a6:401:5a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 10:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:45:58
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>,
 Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 03/34] net/ntnic: add return code handling
Date: Wed,  5 Feb 2025 11:45:12 +0100
Message-ID: <20250205104548.1533554-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9P190MB1195:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e62554d8-4fa7-4374-9e56-08dd45d24683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bpC4SsoRPn7BfE+drVJdC9odxKFh/io+tHUSgDvhOK7deeLB02ADw0xizCVF?=
 =?us-ascii?Q?40WQNp9uxMffSUrijFvs+5WR7MWVXKJIxf/Sn5ubnxFSUAzaMDodIw2cX21a?=
 =?us-ascii?Q?H0vZ5husnxmA8E6vRnzhYmb66x5/XmklxfJxGPs0f6MP24qG8Cxbo4nJ38Nt?=
 =?us-ascii?Q?F2lDeS7KtWq6+Ijl0mPg4YwPQZWRcCSqyP4YengTJDjzKBw0q6q1F/IYra1Z?=
 =?us-ascii?Q?t8wHyQlU4Ha0dNywCKEF/kEnNm5v2eLZSqLvlDcgGCYkLV7Zx4UN51OB2/Pu?=
 =?us-ascii?Q?MsCsWaWtea0NnD+Cl2aZPrTLZXeCXNZoikan7L55kIUyPP69cYt2jmpr6ib+?=
 =?us-ascii?Q?XhnLbk2J/oWTvM8zzv3HA7DNtCBVuOZvxlKOmP3nR6GV9cMLI/b7tPB0BKJz?=
 =?us-ascii?Q?FV5k6XoLfKIznmIFQAip4WZLW7hc2RCrYmAm8Jr3Eku4trIDlLcbZFtWym8T?=
 =?us-ascii?Q?bAJKQnhTzHHgxCnaoP9UaUS1T7RMOnGvWfs7YYCCB/Jl3gjQVK6YSd2DyM9J?=
 =?us-ascii?Q?oBwElyQ4i5Q6ZjKMlP+NbMFHb/mabWimypuHX1jm6L75CCLb1JdzmrOWBosC?=
 =?us-ascii?Q?aQvAw0xoBXfWwkXswerjDBBP7qfvbh7A2tolpWWPvvU65GkiwAFWSmelTQa0?=
 =?us-ascii?Q?O1Ii9v4vp+/Oj1DpUdMrFY2xJRF3RkavwI01QwFe+b6Nk6VQsVfMNoP0ml/S?=
 =?us-ascii?Q?5jJm4RQosUeLoaTYD3iBJeotunL9rLARB+Wq8S7txtk1S3iSBEgxB81HRn1V?=
 =?us-ascii?Q?9Kyd+dJvYwOJVxxtgN20nQykSYIS6vpulfk6tf6J6a80ngQi6c7LK259AXNk?=
 =?us-ascii?Q?h65UISeUKXhzZlJ0viT+sWkXx8iz6g7psLuzBpzHJt7/R0m9sQTQofOTXead?=
 =?us-ascii?Q?rI3MPEmsiTgVbW56ywLMt7G63ZWpq6BijEloVQA69npZTrMDx1kdTeMK/CaJ?=
 =?us-ascii?Q?CTMKl3yDURHffpMvxJjoF9LdMsgTVJ/L8THO48JizWsUT3mTYPDNb1hK0hJl?=
 =?us-ascii?Q?lidi0/Qz+RUGou90ZcCf8cNU1Cih3EqkUKQPEKSVQq3MDrHgW0ASFutV7wt2?=
 =?us-ascii?Q?hijqVbfm6SGWjDR1qpmcfc0aXnmhnbwWq9AkxRUDDc/6ulG1mZ61FXQQG8Rd?=
 =?us-ascii?Q?zpqeT8xKoksLuzp/OJMHINjrMK3N+2rF7MAazrcl0BYjEHCR1PULR78cn7PN?=
 =?us-ascii?Q?+LAv+hGAPhT/SrozWkmJNESmAzNzbT9HFoUTeV4Ym56B5STS6LrPJw67XuGa?=
 =?us-ascii?Q?w9sNoJK/oevkRoCYUJvVNooigqYTPAHKRhOQxs7bjIGNIphXSHJ+XjjYImK6?=
 =?us-ascii?Q?dzbjiCOGZJQhYgOanfyPEAmCSIpRovP6PHJpBJ8IhVzXlLHJ60FWgOSNIeab?=
 =?us-ascii?Q?PuqKbtkLwvu1JVKUtpql/9RiaUpQmX4hFJFpJnPPnWYBz0gu3EkTchSulDOp?=
 =?us-ascii?Q?cpAnhtpA7um7OemiNNDeyZ1zXyZulAC/sJOcbeN1Oem5SrxWnp7+idBSv7g2?=
 =?us-ascii?Q?C0oxXVR1GjGIqbM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fkskWk+gNRFYr82o5UqSQY2t5nNVzCP7NYX93zC7xRB61Xq6PoKSCBvQFkznyCSwXJgYxtrglGKkz0Fo/7Y7xcDQUrOoSYK9r9V2A8CYlOI4Ym6HVMaCvKw0LLqZbzuRO4+RTpt5J1uuhos48XNrr6Fvhp5OeMmzQH2iWtWzk/1LD1kYPNcpomZhcaAp+rUgp/2HicrnV1UlhvoF1PQna3cZ+xmPM0+yKulRkoDAfWPdY6WgC8AM/C21JqnBSccqYgbmpqUQ28omR1CEe53QPUZYDmwPWPN84q6I4BFLfA4dBCSeoazG0IhQrZQxJcl65k2JdG9+m11pHENXCGIoFPyGS+LbXPsBZy1GPnf+fO97UBnZDEbgbQTJTa6CO4xL9uqGyqD+YGZZ3SWau17Uw4YECdqIqUlbwlfHQGtXNWBu2pcbeK2x4jcLutYUIIKDXJ68JG/MRO8PnEzeeeexcI1vmwuzYoYto9UfjsVcznh5P1IgaXJCZHWghdbfH/kyV+V9VcojGYuvPU+niMyW9lbjUv5+eaOzHhOiBhnhkBXN3YmZw82nX8OWmqjHG43TJqXUVa135sTdfBQ+NpapCvoxOKD92PZ2Iu9HkiO2wQWflJWhJiAUagFKb+3OICCdug5xyLjP/J023jp0JCSsCw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:45:58.3239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62554d8-4fa7-4374-9e56-08dd45d24683
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1195
X-BESS-ID: 1738752360-306009-7767-585-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmxoZAVgZQMNk0xdDEwMjM0s
 TU2NTUOMnI0NjEINUgzcDA0tzUyCBRqTYWAGZnMSRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan23-248.eu-central-1b.ess.aws.cudaops.com]
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

CID: 448984, 448982, 448975, 448969, 448968, 448967
API usage errors  (BAD_COMPARE).

Add memcmp return value checking.

Coverity issue: 448984
Fixes: 6e8b7f11205f ("net/ntnic: add categorizer (CAT) FPGA module")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
v2
* replace return with break for macro DO_COMPARE_INDEXS
---
 drivers/net/ntnic/include/hw_mod_backend.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index f91a3ed058..544962751a 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -114,10 +114,10 @@ enum {
 		typeof(be_module_reg) *temp_be_module = &(be_module_reg);                     \
 		typeof(idx) tmp_idx = (idx);                                                  \
 		typeof(cmp_idx) tmp_cmp_idx = (cmp_idx);                                      \
-		if ((unsigned int)(tmp_idx) != (unsigned int)(tmp_cmp_idx)) {                     \
-			(void)memcmp(temp_be_module + tmp_idx, &temp_be_module[tmp_cmp_idx],      \
-				     sizeof(type));                                               \
-		}                                                                                 \
+		if ((unsigned int)(tmp_idx) != (unsigned int)(tmp_cmp_idx))                     \
+			if (memcmp(temp_be_module + tmp_idx, &temp_be_module[tmp_cmp_idx], \
+				sizeof(type)) == 0) \
+				break;                                              \
 	} while (0)
 
 static inline int is_non_zero(const void *addr, size_t n)
-- 
2.45.0

