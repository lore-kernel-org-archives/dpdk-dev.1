Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEDCC369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:52:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2169B40DFD;
	Wed, 30 Apr 2025 15:49:44 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0FA8C40672
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:30 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2234.outbound.protection.outlook.com [104.47.51.234]) by
 mx-outbound23-207.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKKajxX9hmF8OaqSHK7CcIN1TqR7OHdOEOPKG+YJ043opB6p03RADUb9dy2wx3hMrS2633PssLP4BSt4FIFqeMDEQN74ekWdaRxLg2rLGxVXnyyotwyRIrypHV2jW/PgFNOEwOZ71hYHlTn+9lK9SR+WcTkYRv5g1RG6bovS3TX1xulYPHRvjPYKn9dReW+0qvCYOzO0pv44sS5SsUX5BbD7bk7bd2O9MbzJr5tu3zpZdVZyCVHjyM0Zpcl90zQvavKLEw2gGq9U3ICp1aTmhKPU890XHycCqj0+vJwJ4rN2jjQYSHIN2KdPFptJ1TtlnPX879k2HpACjF2pvtLXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZvemijjBgQMgWL1xH/EQumyCA1CPRvJ8uhru7dh4jQ=;
 b=AKarqReVI2Qg4QAbyQfILRB8Gdb0f2NFkowIJ+Sut4VRtyA0rRF3C/oEBGeH0XtDlKwFK1sLIrmX5yjQR8OIcizgKP6hryjhRaozjZohElocEx+HrlZlQwd2Q8wjsIfYckTLVrkXmXuLFP0EXVrMdNnHXfHCVdgPnWgQZvypfaPX4rLGgAdbgFF4d2tKNWuxhJ550a84p6b+dEhpbR+JM/9carL3HrtkLrLL/4TesJrdv/odawNNLBb2mpbvOVoxvlM3CaU073Ez2tYVitoMVnTiKhAXqo4eAQ06xU++FDIFjJWgcFGOdjgXhF7pWNaWQGhir4hAmIW58yfc+1i3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZvemijjBgQMgWL1xH/EQumyCA1CPRvJ8uhru7dh4jQ=;
 b=ZPVY2I6yHMtSj55h0l5u+bBob/pqUD1O/EYo3DT+wnfAEKE0AWDxFjXVzo6/XWFmPLDfIDHL1I4pwdxFGvIAjmx1itiD47BSD4D0qGkKj7KCEooPZq0hDV8lNs1mm0uC5T+Ir/027xd3MC6dTI/exMpe15JAH1OfYVGI9/rZruU=
Received: from AM9P193CA0023.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::28)
 by AM7P190MB0582.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:122::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 13:49:25 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::12) by AM9P193CA0023.outlook.office365.com
 (2603:10a6:20b:21e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:25 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 25/25] net/ntnic: fix operation with rte ring queue
Date: Wed, 30 Apr 2025 15:48:37 +0200
Message-ID: <20250430134840.402553-26-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM7P190MB0582:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d86786c9-0e62-4146-9318-08dd87edd1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?06b9ONEAZ7AVr1jTuuO8Z76lGYcKKkw2cRIxOWvEgNvB3UtBU14ehmUvV8eu?=
 =?us-ascii?Q?Mkz6Y9rjn7DFuxaawx8OLK+819b0cS+z26pOtXbOjAOHvMx5N8wdTOnSDF87?=
 =?us-ascii?Q?xPrLOzjgb6wWRRhavxZmUZ097RIecfHpsp5QNGAI+ZcqVNgj9ndajOq23z4n?=
 =?us-ascii?Q?FKevWLQ/Qot6B7La9ZQYzK3WYpno3mzOJTGpjmQeYiLKuIim/00KDgyWHMHD?=
 =?us-ascii?Q?PLxF0XonRM//4aGB6fGaJ0zFCD1J18Pv8RYheMzPm0hnl51dMJZqUNV0+B5P?=
 =?us-ascii?Q?v6zK2hRX9Mw14UPvuhRMCGgd4T9GGyQ/OxUtSRqh5RjP5hs4+esgpH3ANhqQ?=
 =?us-ascii?Q?xlQ8J198F7QgDX+OkywnGLZpzscUFpyfsBC4DTNXXT65PoQBxSi6NoyKHSrW?=
 =?us-ascii?Q?E0nE86C0PyHrCkK92Z9lF6Mi55o+Xsy5lXquTwb6KIuO4P+7i0q9KbpVjem6?=
 =?us-ascii?Q?eGnAY7Yz9GsquSOUPYkmJVy0kVjf9/jhaFTAYa4tzH18hA0XzRpBvL4vQ7ax?=
 =?us-ascii?Q?OWuIQ9/hGT57wQnd2oY9sjT0/qu1cB8ldttoAJrQIMMu+nddMClRZS2yAZzR?=
 =?us-ascii?Q?oAAEDmCcIP01ZvJM1qseXsDwlg4xBt4DqSPmF5xREt6pIRBgJJwcOXQadMOT?=
 =?us-ascii?Q?DnTE4WhQDljllHq6M1UU3CT2lUSPFQFA5p7TFRV3/NRdwsRx72ZCb61iZnNT?=
 =?us-ascii?Q?gk/DblwAQvT6A24NN+BnxsFZmXj33Az5YEm8tN3bVn1A6zcWBOwmyzIaIPjm?=
 =?us-ascii?Q?9hqW7mlhknjT72pULm7qoSulq3CzDBV/cS5g3aUe5E7vezt6QsfjMRZPdqmK?=
 =?us-ascii?Q?mraLJohAInIworXdDs+au+XzaxqUpEL0lIobYfD5X5mXITJ8bNADtl1p/HTK?=
 =?us-ascii?Q?Jg5mMDlzQyBYTLW9GcZXmFAJMpIrPJ/+wjMkOUFekbFa54lIITbm6RWPI0ep?=
 =?us-ascii?Q?V+Dcz/iYtojy76xAV3BcgVbC0ebyqdvQt6/dZILH1zaGrkq3exHRVGCASAkO?=
 =?us-ascii?Q?B7idMe9haUL6rsaFmJhR776cE6cnkTBeYVhA3UHO+nnALyGVU7RPe/h+hPLS?=
 =?us-ascii?Q?XU+h03lt93i51FQDbhiXYBj0Voaf/5JPmcsIRMexY0Tu6c9wRhvJuZJju5tO?=
 =?us-ascii?Q?nKY663EjWITwIaOKmgKqpB9NRZMlHN0U/WONT9jhBCt35N7KPy1J0jr2E5k0?=
 =?us-ascii?Q?w4pllKr4zpXqfg/ziJtDOBDoRlo+sxioDp6dgrmXw7Lxr+5G7JutNen8u5Xs?=
 =?us-ascii?Q?BUmcIMExa47LoifD41r8HpFk7vPW8CbR5KbAemmJEvOwvBsSX7E/VYHdfcnk?=
 =?us-ascii?Q?NCxpODkWdE1bSQBdG4KfjiwT9uKGMsM0/KINkq0cQ17mJvRyJ9d2gsGiMFcJ?=
 =?us-ascii?Q?llCl4mEx+7vUgvwVYMKNunsMZFLSRbDL7sK/z+VpkMS9pFjOOtzGuSDQoGAi?=
 =?us-ascii?Q?zkcnf0uEnkSGenSUci5BTBAZbZDRv483eUeq3WuQkPcdQembpkLRk0a+9hG3?=
 =?us-ascii?Q?XKJJvXg2mDFb1AMK4CwzxXaR1ZwtW2v0bGik?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xU9H/2aD0vQQn06COQLFQrwtJ3hY/+ZWgSb8KlcBs6wjkeh9VUcYepN7ki9OK4s1OAL2Y1a1QEBk3fvRJgORyhXSB1ra21RzGQNlZVyasWwnXGCNx0o/QQuESE/4ILroRdelLHnqyQxWoiSpLb4QCvJn5pu0rzS6g6Jzc3VbDB8/xDNP3QkaC3fF6i12NARgXx4PpqEcX0IluTj3TnffPjvxzr+mbmF7XH9u4f0Tw3aRVQZxbW5YUZhFavaYU9iP8Qr+0T8OznTGMbKWn7KIrf1V+/eILrhR63fvu5zbRnEhGyZrwmkHABmvVc0nIQ/Jitd8fG71OUthsRezwx/OFSlV70VdPKTe0iCJH/E3Oq3QIM65CQdtvbG7WbGncV74osiadmKewneKPIv7fxNuX51idHa6uHeiuc88wxHw9XDqkf3hY0d8X0ScCXbdGEcMH5zC77MJ5IjfybN30DeJIgpj9hIwr2/9/+DR/hTcMm3xlErxB7SRzzML+lN6JRgjEl3LdJzqgJh86n+2SOQbUsfReT13k88U31GTA73VyC3/7UUEASXDDUgW0Eld8MksqtcWkxnRMhKlrqFCUEqRt/k5CPkYb8F496Aqk+Hse84nnGNGYJrbQ6swu2q0zgLpKj4EUi80jWVz6716WxgN9w==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:25.3020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86786c9-0e62-4146-9318-08dd87edd1dd
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0582
X-BESS-ID: 1746020967-306095-7598-622-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.234
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmZkZAVgZQMM3QxNgoMcU42c
 g0McUs2dgy1TjZzCLZNNXcOMnQzDxFqTYWANvIwwxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan17-19.eu-central-1b.ess.aws.cudaops.com]
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

User should call rte_ring_dequeue_zc_elem_finish to complete the
dequeue operation. However this complete step if record absent.

This change rework queue read operation.

Fixes: 96c8249be53e ("net/ntnic: learn flow queue handling")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../profile_inline/flow_api_profile_inline.c         | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index d12bd5a4af..70f9d751c9 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -398,18 +398,14 @@ static uint32_t flm_lrn_update(struct flow_eth_dev *dev, uint32_t *inf_word_cnt,
 	uint32_t *sta_word_cnt)
 {
 	read_record r = flm_lrn_queue_get_read_buffer(flm_lrn_queue_arr);
+	uint32_t handled_records = 0;
 
 	if (r.num) {
-		uint32_t handled_records = 0;
-
-		if (hw_mod_flm_lrn_data_set_flush(&dev->ndev->be, HW_FLM_FLOW_LRN_DATA, r.p, r.num,
-			&handled_records, inf_word_cnt, sta_word_cnt)) {
+		if (hw_mod_flm_lrn_data_set_flush(&dev->ndev->be, HW_FLM_FLOW_LRN_DATA, r.p,
+			r.num, &handled_records, inf_word_cnt, sta_word_cnt))
 			NT_LOG(ERR, FILTER, "Flow programming failed");
-
-		} else if (handled_records > 0) {
-			flm_lrn_queue_release_read_buffer(flm_lrn_queue_arr, handled_records);
-		}
 	}
+	flm_lrn_queue_release_read_buffer(flm_lrn_queue_arr, handled_records);
 
 	return r.num;
 }
-- 
2.47.1

