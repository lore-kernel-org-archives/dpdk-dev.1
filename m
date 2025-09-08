Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46281CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC5324065A;
	Mon,  8 Sep 2025 13:05:19 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id ECEF840615
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:16 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022096.outbound.protection.outlook.com [52.101.66.96])
 by mx-outbound9-51.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz6lZkmu9xSz9F5kS7Mlf8ufCR503614WfQaxe24hY2dkAnCvvgPeWZb7FHj+KiDqKNm7pRoT/QQ6ujdD+WUckP4T2UHh3LxSs2741uq1YWicuvnY0G05SW58FXlPiiD+DgdyD2fbHnuwaJqjKf40Ro+zWfWo4ZNWwNeS3eeEVEh1Bray8BdikR+RX4ZIEyb/cWR7Nc7wNtV9s+rxJtIzuc+IA0dVGXqjUHsop5RkvJlISLAIWTPtHIAUGOJ9khVgVATzBD/htDObLLJ4C5NTyPPllOFqL+FLVHO6Mg2LwzO64SHdZr9FmT/8SNtShC57+++UJjLFniB8SszTEVtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kR9raPxD3m1Ck53ukdB+NYTBqU0Kj0YgMYFPg+Su9c=;
 b=v6FJWsVZe1G1pI/jzJ7AxJBWCyqYgwJc/nnq0R1jcTZ3QDe1xPTfh/wo9sEIOLUQSzVF4AXtppeBlwt3+yz4Mk7AE+zEltPDl+EtEsJIfZhV6iU+W02J1gTL1mEAQGJ8lgU5jb+1d0bYMNZDuuKQ2GDtNBB8kDzLuQwRIJFtVsdQFuXI2kuJ32gL1+JuW7Cbr90VeCZg7+MEk5mKzwopBl8WrEsowPzBWi9YFxViojKaoc+WA2GYU+6mMDYzvW4zor5JAKCqZWX/WgKZOsHOiwvpgxm2ZhhYmTZsQlBIprzhHTaVgKEtNbe+32z48RRRhtgbdZoSSDJJJI3F9qTfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kR9raPxD3m1Ck53ukdB+NYTBqU0Kj0YgMYFPg+Su9c=;
 b=BxsJelRD0enrKTuypY7E4rF91nlivJRQYlWQM9w95FvM3+nzxooVPOvf51eG8nRoO+9gFCIr4FOPDvMi/gJTbmtHWBXQ6VMawuTTJA5rW5j66uPG1hwdRkOSwmrmV6jlOivyWBuRCxUkd47BceqGsu5/0Rp1n0BGWPr1mwBw6C4=
Received: from DU2PR04CA0341.eurprd04.prod.outlook.com (2603:10a6:10:2b4::30)
 by DBAP190MB0840.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:05:14 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::3a) by DU2PR04CA0341.outlook.office365.com
 (2603:10a6:10:2b4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:05:14
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 6/7] net/ntnic: add warning about service cores
Date: Mon,  8 Sep 2025 13:04:44 +0200
Message-ID: <20250908110446.1071964-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|DBAP190MB0840:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7aacb8a6-60eb-42b8-06d7-08ddeec79674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+FPDHqFsOH0FH4Ok07JCsEc7nRmPVDUz/CpibW5rHUle0sGPyzLs0lBcVwGE?=
 =?us-ascii?Q?i0pGRMTNlmRja/pvlXmIXN65s/5Hmt7/F3FV2AZcLxn5oxqk6l7bCzVj5X3s?=
 =?us-ascii?Q?AO9SI8BmhfCCTIYiZlFhCE4rgUMbHGnpER1rE7ZLzV/yyX4UxO7QtgH1Oq6U?=
 =?us-ascii?Q?WLAUoobjVuKQ0oc/YqUn1AuaKoOFRgjeTzQXi2bkP41Cf0Hp6VsD0f1KUR3E?=
 =?us-ascii?Q?UO+gxDB0O8ODn8KsFwhvqwP7qTCXkaklerzJ1F12sD4QDMKhVmH2gclxASyH?=
 =?us-ascii?Q?u9pgbj0qUZd9cYCQDbBKi4ZvYe28iHxpEbm2QdsSQWXwoM6BqbEq+zTPRY5P?=
 =?us-ascii?Q?eEmMc4ocHBJI4BSREotEOqPDGDRtn4G8LjSrxS71KZtQPyZSX8b/HDKMU9ZK?=
 =?us-ascii?Q?B0qaG6MO9YRxTUYoJBk/UWxcLtmgkjzuKsx9ngrPozkiBHIp2xFYF1MLPGnq?=
 =?us-ascii?Q?lInQziqrJfUZRwNUdhElJr8Vxlaiwn9M/x7i2XJrhfpLG2aNW0VBaUWyO0Ou?=
 =?us-ascii?Q?Mzs322KbS++zNq4U+n99GLm++5h9EXHH3AoBKfIhzp4Y7vcQfqvg/1TMWMka?=
 =?us-ascii?Q?tsW3f7+p3fKTjbgI79u+S2ETSa7ULeKN6VBINz+4jOYAP1lftXdgRTrp5zUX?=
 =?us-ascii?Q?rFlBQ1P45CgJNjutf+oQJ0kFN/bouJS6QPmFFn5ryS5Q4/HFkJEL56HE1rbW?=
 =?us-ascii?Q?xWGrigNvblyrMVKv5YU6CPftF281cX8UW6/tuSbUxC+Z6w6c3SChoe8n71pM?=
 =?us-ascii?Q?M8XgHgv23UMiHqbzGKTyxTvLeLKP57++RuILPoDv0dzAUBMMbVaAqeC8BRGP?=
 =?us-ascii?Q?5AquC9Ub5l08AdPS2E8qXBcYyenk1g8RjMzAsBcXDhsnqEEk6sv6gOcgiGDT?=
 =?us-ascii?Q?vsG7Y1xleAj3CgCm3q4xqzQCIDaapgbgmE06GhbwH+cuNSRTylWhf10R6kBC?=
 =?us-ascii?Q?5Bd5+pf9ZUrp0Pr8cIKJlZW9DpPYN5D65DSj93ml10na2o5YIpN7V14R7eg7?=
 =?us-ascii?Q?/fCOpHjReeavD6phUohkJi/cOwFDtsElDFIqTavVDksREgc1VM8glGzwNyk1?=
 =?us-ascii?Q?benkf1wQ9WiVwNVZzTIqCI085H28luGOb0TjqzpNwdx+MzIeatddgr6oxvE7?=
 =?us-ascii?Q?GI9483U5L6HZBxRtbiPR/V+J9V5urn1r6b6/S5vS0nadWmG3kc4fMu1RT0kX?=
 =?us-ascii?Q?wXWdFD6iRbi8K0jyCd8Sn327pV2YU/o3sKCvKJpP4AvttLbrNkWc/mBcnSL6?=
 =?us-ascii?Q?YsthaGHB44hU50G0QdIP7sF7DXctnd7av+DX7jpgozxXQCWAJDcDuacjfG0o?=
 =?us-ascii?Q?S0hrBBd/RDrvRk2KJVOjT8wbcSUXL3Dxo9YcABfkPudeh6HxNwArHi0z9z8w?=
 =?us-ascii?Q?b+w1MzNElFpSDkr8edB5aFs/wM0H7W7JMIgLMS7Kc+T2gKrXvcPtUmye/8jU?=
 =?us-ascii?Q?7Am1cfTtxiJHJQBIo3fVL2dKnIM/B6ZcbMRkAuU2Hyaj7WfFLix4fwEk39d3?=
 =?us-ascii?Q?wE8iDphuIZ0CVl+uqZTw+5UWNmD+d9V26J8f?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2Xwt8jFfVM/KWEfhh8vNs3BnZUVW7AkkxjwWRTnSWm3h5cn6mrasHuGmuEu+qeaJKWJfKuA+aCpvILv1fGOMnhrS1j3btLf+vMQ5zyAnY4Kt3UYKrWrB6vWxud+FL4FWPsDC6RnLx10MOi1e0q73sZpBymLqOGV+YoCOEfKWTCYdZJ5ExiA7LeZcKURnt5qjbUWSK3iYm6MYMczVH4QfUA+lbU6xzmaXbHdBtBRcWiax2dnkGTwqkFMdFvezJJFOD0eocbOUuKFfOL0FMyLa/3sp0PhSC3wffBUNNy49wpXmyxbQ1pJefaMxJNWljeUalyxTxlX6NgteEpr1B2Rj1ttA2Y5gFcYRymEWYaNAssezCG8QNmPcumtIAHFEqrybYMRldYJUtnfcTQuc2nvngQ2/9qhQgB+odkmpfF8QS15m/nH2k+iJgNzvJ583Zq9IF84enBfuGKJ+D2LuT2WDRmBry9Be8nTq6tO+w9XHfraJHmtST8QLlgjBhTr03rVidRlxf8D8o0Vo9M04PQlE3c7o+gGfhNukTs+6EooyyenRAAYbXoURZgVjAJvGDVRQ+1Lh7Sl5U6FiHsbimOtSLSGbtTDnTIqBfVrY/hMsasvPD6bRKb+KjDzI3ZpbkGLKe6sGFvuzd/nLo4/Y7FdrDg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:14.5143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aacb8a6-60eb-42b8-06d7-08ddeec79674
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0840
X-BESS-ID: 1757329516-302355-7675-4103-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.96
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmFkBGBlDMyDwp2TjRyMIgMS
 XRMC3Z0NIgyczC0iw5KdEiycDIIlWpNhYAh5XvIEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan9-238.eu-central-1a.ess.aws.cudaops.com]
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

