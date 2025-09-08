Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3113BCAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 14:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E9A540A77;
	Mon,  8 Sep 2025 16:18:02 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 61D4440656
 for <dev@dpdk.org>; Mon,  8 Sep 2025 16:17:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022141.outbound.protection.outlook.com
 [52.101.66.141]) by mx-outbound45-224.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 14:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOdt8UvOXttmuQ/st7YrGA/NPr6vFYLfwIYaTmrSm42Yd8Xxp460ChrUjArafUzP+GTdPxglXUJ6/S0hV57Ru7PbKlIwQju0cvS68anxbuZ+r2rvPDGVuIjNQxogrsILmQSFm+4WJM94/z+h17TI8eL4zrfSorPtLJLX7ryQAvN7S30u0KdiLnFaqSIoYb2cmuOC5WH/Up36p2apEAd075qNMV2etVaUSKdxv3tkW3DfYfqc5Ica5yAiwBqDwU3eH35Gp8mM1Tu1IqxMyPIgcjrPQBALdMmcLEdJHWRfD33uKakc33YktU5OKdyIg56O/EuHzpsp4gwfVtmiWCprkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kR9raPxD3m1Ck53ukdB+NYTBqU0Kj0YgMYFPg+Su9c=;
 b=I27526K53C2wmvCsSdeJ7UBFQ1KKRpx1in6usf45Vt64qfY7f8tnY7TlJyG9V/uhaaVTS00Ld9jRJgoE4zqlaJRMTyhrevN7mg6FxjELqEXHtLlEHDNFvg5Bb3ANU6H4dG3MCqFUJOJKKZkFvA8mAxOtJmJitNreaefayVw20bSi6EEMRTIQ0jFtFy6Mrv1abuZpQQSro1WoP+rUA6ORoadLUZvtq2AU4fGkFcyAeMCb/lH5zGV54KWTCgWPW/oaTpYOsWxfE9Hiv1yMzGEr7ntkX3r/i1T+COpjQp4YmzhTa2UqlC3PghNV9mkpCren1s+5YJ0ZIBquLXdEpUmtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kR9raPxD3m1Ck53ukdB+NYTBqU0Kj0YgMYFPg+Su9c=;
 b=W5nPpFgVDrqfLR/eYcPkgl0k8/PRR4LHMvAf87l8CKyd0n+NYCzsgZehOww1FnY+7//krbF2fm3dYN64AVnWHTu7dRmQPPvYJcG6ZONgjhgOw31HN69qYubO0qUymxF6ekFK8R/WEfAk8ZNfctKUaZAtcO8wiHK3tBYh6raUsTk=
Received: from AS8PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:20b:311::20)
 by GV1P190MB2228.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 14:17:51 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::84) by AS8PR05CA0015.outlook.office365.com
 (2603:10a6:20b:311::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 14:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 14:17:51
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 6/7] net/ntnic: add warning about service cores
Date: Mon,  8 Sep 2025 16:17:38 +0200
Message-ID: <20250908141740.1312268-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908141740.1312268-1-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|GV1P190MB2228:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 878e9342-1f9e-4b1d-1c28-08ddeee27eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J7UcZTEH2V/DlbghgMEW/amR1I873tGjEKcJ+UORH7TNWnsb4Xh9uBzmiioz?=
 =?us-ascii?Q?PNJLfcOX2YVqW1SFqGFL39aYXuqmMr9d7PBWv9HpQDicilriA+xHFbl6o2KZ?=
 =?us-ascii?Q?mKKUrUu0XtS3QQEl/mcXMWXxByZJ1HCeAn+oGv+YpnORAmU7qry6BuozOpOM?=
 =?us-ascii?Q?H7SXmqiMXc9UkdZiXmrMes++h2MwI+ENngem/5QmcyWDOtsKfglgwiYvMCLG?=
 =?us-ascii?Q?Yw/hOnSbD3G5/WoDtdw6ti3lVfSrrNBvmW2nB3fAsP+ocqE0Yzhyhgt833uv?=
 =?us-ascii?Q?PTs2/3K/OWVP14SJOGnTHk7rpa0nXVvgHVBTiG/CDTfu8szxuKMxLYkhsNb5?=
 =?us-ascii?Q?Tq4nn91DXzIZFn/Kx6xSKLsGJjqNCUFxYlEWWVm8Y78Fjyd38Hdf/2CJq5jZ?=
 =?us-ascii?Q?RSsZFEwasl0SI+qQS7BGr9LgEeiF8evqa+qw37JlAIQIxnngGQc/ZPzfRFty?=
 =?us-ascii?Q?Zbtt5kjSnocgUCUEJvC5wD17EboVLvYJzMTVaHqMvlwp1bCQxH4SuInlFSBc?=
 =?us-ascii?Q?hkAEyQb+tqV65EUgB9LATRlpPBTvDFs67L1AueBta6t0kZaSp9eWwWsNcI2s?=
 =?us-ascii?Q?t2veOLhtYdYCx++Sq+PBpgDI4hbk/rpbVi20hdwaNur90eOjWzdCfdIfpAPd?=
 =?us-ascii?Q?mxCHdm5MnEesl93WpOrNtNt687pRIweN37Kpf5TlG+NWVs/LZfEtElcnV9C6?=
 =?us-ascii?Q?gRbwL2xjBwS70o9n27gzvCAbHt0dC5EAN/p/tFiak/rLdKEzYX8dZ69X4j1F?=
 =?us-ascii?Q?9GQyQDXLEt0G3D06sZLWXjGSvIYRjty3EBa1UnQ6vkXB6WcFlHLaO4GV1gkk?=
 =?us-ascii?Q?dY0oFiTweJNVU2I+aZHk63JIYICvLzUcUaz7zau2TCDRJrydIQw0i+TxpGEC?=
 =?us-ascii?Q?j/7gIEeLIN0T59UaYm5zn2ImoHuBfGtyA7HtfOiIoSmPmO1dQpIwQfyvZI8b?=
 =?us-ascii?Q?8xBxJhOTkCOEmpkYIILcdxnpyHCheq27Y1B+XLQ4zHgx6LHAQsQkbFI3GZty?=
 =?us-ascii?Q?aBOv3Tz/1vo74aSXFVsJfwjX242LFDZdzRqq7OAX3etdGG4n2H4CpjZkbdCT?=
 =?us-ascii?Q?lkW7SnnK69H5rbYgzInlTnv/EIGUOD2TWgu9TThXfOb7PTLedeHb3MA6s9Xj?=
 =?us-ascii?Q?8Pq3SIkhPjiTh0FXftkFbXLDSEII4qQgflk7s6VhS+ohSYapriN+ZsC2d3qQ?=
 =?us-ascii?Q?OEh1wsl0/ODbfwi4dYIc9JQLCGXCf8B+W/bHtqmu9Bwhn6mhSjdYMzgveVRr?=
 =?us-ascii?Q?fS40ZpkFo9NaI08XwjBt8lfSEE/aEVW3zNf2OMIsk/7RmB/D8nHzmGyFC5QW?=
 =?us-ascii?Q?lqp/qMZoY0Jz4ltNr8/YYDp2/zXgoQqjRK5d2cXWOocMLAAK8efRfwWJXDpO?=
 =?us-ascii?Q?hB8Om/vrGPCMnOJ6Lq/QIg7mwoFokwj0aPZr1uNbi9FgdTHvEwgHOWAFiTaG?=
 =?us-ascii?Q?aPO+8+UD93KVDJ3Cpoo82vZiAi13gFRW80Y0dj3pjvyrAGms9JgzdHsCruEN?=
 =?us-ascii?Q?mBTiG+Kwf05h0sL5KsLsRT1d+AXL2ItXmEWU?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vWhZ9ESaLkkVBQ3OhqSeZCslxZtfAszTqb6J9ySt5L9Hh2cseOCeogQcyV8xjjNj/7Rp2/drMJbOMu/kiUWdneaSThp5ZxeJHgrCnwoFUTOAT2Ck4M+oMmdGbbF11UQd2qvZwk82mmWYmlbLw4Y/z4e/hgGh7gpwE+fk+5XqWrGEjU65PGOG8eoZXbHqen30NbtyS2m0v+ZAvPfsY6B8sIEQm9oqj9J1LsA4FmDSRAUviFLVN6WlwRg0HxFSGBxv200Wam97o+4sqvtGxJH30FAJfvqFCQ/OsoEx+WonXvc6ykWndPFHEllb3uppVLQA2S14KuuqF2xL7myjGvfFEiwTnw6Il4ouDXRMR6TGtpnR/IYXIokVERPyyu24/On5MySI0HsobRzNaWEvqjHOXO29JpS0HTK9zlq2eA4FGc34+ci9qbAYYGDtvRnTC0tXT+eFEROI8SSkR/7eLGqYMFzFBcRAHqtoy1C4NepvR+YI9boTEqYKfaajTcRy6LI7t3p3gXN3VG6yusIfQElICxmsI0ox1gk3vmipgMhC0xk7TnDFOyqNHsJQWQ8+kzvw6j1giOh04wbVhjpu9VdPiUpth/ADzAmxpwV+qX83+6/maRxEyZyOJlRwicPducQCkZQNHI/HMRmjwKlTjvmNew==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:17:51.1605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 878e9342-1f9e-4b1d-1c28-08ddeee27eba
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB2228
X-BESS-ID: 1757341074-311744-22018-3572-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.141
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmFkBGBlDMyDwp2TjRyMIgMS
 XRMC3Z0NIgyczC0iw5KdEiycDIIlWpNhYAh5XvIEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267336 [from 
 cloudscan20-182.eu-central-1b.ess.aws.cudaops.com]
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
index 7ec1c94a14..664112f67e 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2607,6 +2607,14 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
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

