Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E962C02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 034D5406B7;
	Wed,  5 Feb 2025 11:46:24 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id D01BD40672
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:15 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO+I8MkQvFeFr13sJJlu22CZhMStL0UgwpLE0WWfsmUzvgTq2SfhBaQcJ7VWXdgkjUgQfJpN4NZLhM3XKpSsUBY7WiPmJUvAoGsv+B1pLTxtxlUkHx2cfJRi/fKnLtUNFAfpcIYkTnvTamJpK304WQS0V0/ZcorJ55XeKazp9X+bJiSBpGYzvXiYaT01XlhMuLbgsIn23ptlSL36hnIZL36kzqFv8W8mTaKgrd3U83jj5Nv9tgZ+8Hf/NKyG2mkDDSXT8B0V//SDsWnUT4Gjgq6JftepOq2F3j9SWmGr9FVpaWgfPDYzcQgBiFN1j2G3XVbkdQJsvUezHY6y/jrGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGC4mB6h52LeL4T5Wn4sWsYC7JTlPOQ5v8M0/SHsbws=;
 b=cOk3gl8dZLurkxVxTGFBTNjYhAPme9dSjqt5WuAsAFDo1V+h9no0Pvzq2aIYdi+ZPlIzSsutWI1xReAuzgJb0zbNeozi3ckXy7/7DxUJZuazEEzYYLIFzz8DrI6mVIt4puh+skMrznQ/po8Ru4rY/M5JBx+jfZ7/Nbrh0qIV5poRNrDOUSzmvsr/cGx/pFMqJBvzpbHoIy4WlE5w2KPqdX8FNFmpOr0t8PDfKk2gRqo7FvJLAthEA4jCqTa5lIR9ALegPiNWxk5uDoP8S4XRN//4oL7cAO5g9G2VdUqgbuZjlfx575pXRKPvbW5ZlM97I6YgWfJhUjKOZxCsO/otaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGC4mB6h52LeL4T5Wn4sWsYC7JTlPOQ5v8M0/SHsbws=;
 b=aHkjADC+7rKzXvxRihezDAwgx32vPyrw14tXFnHwtj907oDsICdYOQYwXSZwpl1WR+iPF7EYIO/4svQdfRipzUJrJonx4HONFt6VKOtFD6FPRiOls3nrfOtVO/9BVwPnbIF0SWLLCyWmmjJrF69/djJpDWrs3QWsHOlunXpebUw=
Received: from CWLP265CA0358.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::34)
 by DB9P190MB1067.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 10:46:12 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::26) by CWLP265CA0358.outlook.office365.com
 (2603:10a6:401:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:12
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 18/34] net/ntnic: remove unused code
Date: Wed,  5 Feb 2025 11:45:27 +0100
Message-ID: <20250205104548.1533554-19-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9P190MB1067:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8711f7c-7baf-4975-b392-08dd45d24eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QL6y+48c/DzOVgG1MfVfYRVu3ZjOpq7NS9itjHyR1U0dr3RvNSHaJKIOSATA?=
 =?us-ascii?Q?A46076UQWtUqp7UDsblIx81Xqz/ciExOHD8lzwIvGeRmjNApDKM74pfVbL/4?=
 =?us-ascii?Q?sHZPQYcAZeHMm1Li/R87MAGwpHXNXvn90PvUSitb6mwJapS5TVWLTm9ASAPk?=
 =?us-ascii?Q?KX6zK3FI6jd5lSbMZuRBAi46wrdl7X9t1r6SgVxgz3bcXq0sB5sFzXt+RRlP?=
 =?us-ascii?Q?j26sWOdPKxXPpToV7AylqmMv9Wi56KaB0rnzKZ4USmR5fX7NoOVDTg3gSuPB?=
 =?us-ascii?Q?aDNgwYM2r+/h0iMW4v4+wFAGwoHb5PmgEIlK8ciZANS1PxMOFdzf0RZSBTJP?=
 =?us-ascii?Q?kruOCaIfZVJnWcnPfTnq/8NDZJm0HvB7Xx1hss6AxpyQqEG9fqKj1LKiHOjT?=
 =?us-ascii?Q?91Awo9BDzRc0hAZMHdtDVmdS6oaziWqvH87/GVSyPRVRuo2cqChGtTlT6B+d?=
 =?us-ascii?Q?d+s8ELvgm3FFqpIa9f/4MgWWSG3XQEvHlx18SzB8iXPucIgwnMVux+qoPjaX?=
 =?us-ascii?Q?nNsHsVLDCrdNgjJdWy1c9ORO/CL2wMfwxf4zXHa4gKxj5tW14Zcs4Ou7m4J3?=
 =?us-ascii?Q?v3r1cBo+iM3T8/Laxmq54MigzKDiHCbX1BEXddG7s7A6yiqw1u8tivkiPdG2?=
 =?us-ascii?Q?bHhMstYB0mj8iwACcMzUr7z8RsfaixxEpkLb62beI6G16+TvomleJPmQ+lgk?=
 =?us-ascii?Q?TdN56d78DrMLZ67zSiS0ry7oLg1vmkHV7ZaJU4zL0ygDHlnXhXH9A26wJLmf?=
 =?us-ascii?Q?xi/SgRfDXa2jv9gm4ThPRlVhn3DpgHtZyXBO1nz4UwC9CJnxUvkn29/JyI08?=
 =?us-ascii?Q?62yrxWZebq7ONhA9ye8+uC47J0KhVQ+/Qp75guKtvtfT4KQSNufYhmCis6Vs?=
 =?us-ascii?Q?/pMH3JbaE/RWR/tVuPUnjd5/uSDy04lAgQylcVmK5/8llYqu9VK3fImxXjtw?=
 =?us-ascii?Q?q2mhJqo8swetCCX8sFM5/76Rj6Qo9pi96GVchoVlcVPqOOs00CKbc8t6ehNG?=
 =?us-ascii?Q?q7UjH7GJBRHA+R3XQ78dTNuIdSS/Nu5RQYepM1w7LrM4Ma5HAr8hTw2hwnXa?=
 =?us-ascii?Q?8snnsAOE25V3esHJ8PeWwMaaNMNVINBCER6gbciJW5X+FX/bqgYuSe6oHWz3?=
 =?us-ascii?Q?7MpIEOEoAGA8+BoTZYnAGu+F9gG0e8DdPXlKDn3YV3DBQg0OnRzNcxVyQxJM?=
 =?us-ascii?Q?TxsQfr8yNE0DbTXNyrbAP+KyY9FeXC0956K1Qb1Yxn72G67k/tyWBhLhixeU?=
 =?us-ascii?Q?0SimJvJOaqhrzJQ0pKHR8jTtXldvbK5ILFspAPsfIUtySE2atZKfCT+MXWSG?=
 =?us-ascii?Q?jciAaXf4A6eiV2yjjjnzeP+71zSiWtHvWY068konHIaAzceNN853c33aVm15?=
 =?us-ascii?Q?ChYAsvGRzCzfGHjtsp/2mBzmAivYzv3v+Z14Yx/fswc2MQDdpyQqm20UjRYN?=
 =?us-ascii?Q?8AKT1RiY04Tf0QEDY7moz7YUChKEmW5xrof2i8MoTMANlNwp+4SEag=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8dufIZB81AWoR2RyHgy/qD7z/5mCeI559t+SXQBhMAit6eF6oHQqUHrKMzHfytZhvOgyUsoeyljsScjGhfJChwg/lyY4V79+wUd53sI03SO6jXjIrt7iBanVd3Twoa3Ei9IWgQpGLaHyqQlPo6XQGYPZpvb1Pqnz3D2z789hsqOxkJ7V30RAdM/bFqFk+aAcJYZqxTKEevO8+AZq+f6aqaMF4UZvm/2VKocQ8WBGQwzlhfaYGnO9xxC/3LVjDmkIGSVcSauq0z8rDvvYmb0TqT5/K+GIJTL4a7MuSl6PWk6n7B+SHMZno6l8KDH+JktnI/t+5EGOTF4+Cq8mPeFKeSHUz5Tx0TBP7uCPddwYB0G3l8mSAQxSyjFpFOiDqOfxQnSKmLdM6aoDNffYNxIsAXKluBmvM1l8O5twSSOp1+eIGmQa/XOkIXbAijgnMdjwCF3Pj1WT5i+igS5pNNWSYRNueT4QDgz/WLBt+YN5MmVU8aZuEDpKMZjVLx1zT50loAOBHW/hjCcZxDG3iQ+H0+gTBrJgtJupRCHbh0RXBrPGCPZCP7h9W2ABwMwxdN8Lbn0rvAIW8T7u6/cHBKXuK9u0/GWFvIES+RpQybAUX5Q2rI4ESyRr3K3SUp5vScMe8JyCzgds8GfyFmws84i2jA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:12.1051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8711f7c-7baf-4975-b392-08dd45d24eb5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1067
X-BESS-ID: 1738752375-302364-7585-663-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYWZkBGBlAs0Tg52Sg5xdjIIs
 nA3CzZIsnSyCzZxNQwMdHQyMjQxFKpNhYAHPO+v0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan16-182.eu-central-1b.ess.aws.cudaops.com]
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

Unused code path in the condition irq_vector >= 0
because the condition irq_vector < 0 is already
established

Coverity issue: 446745
Fixes: 01e34ed9c756 ("net/ntnic: add availability monitor management")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index a2c9ef27f0..e1eccb647c 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -415,7 +415,7 @@ static struct nthw_virt_queue *nthw_setup_rx_virt_queue(nthw_dbs_t *p_nthw_dbs,
 	if (irq_vector < 0) {
 		if (set_rx_am_data(p_nthw_dbs, index, (uint64_t)avail_struct_phys_addr,
 				RX_AM_DISABLE, host_id, 0,
-				irq_vector >= 0 ? 1 : 0) != 0) {
+				0) != 0) {
 			return NULL;
 		}
 	}
-- 
2.45.0

