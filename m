Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F45CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:37:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D370F40685;
	Mon, 20 Oct 2025 18:36:39 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 9006A402D3
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:33 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021093.outbound.protection.outlook.com
 [40.107.130.93]) by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ll5MEUt8lesY1KLR0ahirWxt6ru/IKHzvWxdyz/adfxBoHODh7mbQvW75GvqQuH8ESVxQ3zHWnJtN1IPiu9jR7OhHHZzMAr6iTK6kBCMeq4PPG30W3IlxtzF1V8DgYFzMXC6o+1r2/twU6vlHa3L1yG5jPUcrX5DOwCpE8s363wRzfbvOexJMYWWMWL+7LS/sZOV4TZyoVRn9baZSCb16n++oWkz1XpEvVX3M1tpRbOc5r/M3y/ah+x7HTBnXujE0oj867p4HB5vdBssupDsMH+RFCotujDB1Q4BVGFdl7qocytsVWQEn5qhF2P7D2mlWQKDK2EeEApwM0sNpHe5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk0MCj6cfR/LgQrPhGKDuyobgFt/I5PqnOqkbwqJ5WM=;
 b=U8TfzriteCFJKNGuVR5WvdCowILwNCoShOUYY4Gc6Ncjz580UXXl4Wnnxw9gygjifJeMIqBRy4Hf9rVb4uQnfyZNKSKpwa8zVsMim10e3BbtCzyQL8fxUx28VZ2AkTCso6tALWubaEwMwwd2rRfYlwT0rzwirc4dqsJCi/n7f3ZEy34veQwNsOjOadYprJ+rsODZYZsIEgttyDdYQFe3ZqsKDUaLgfQxCgMyd/gm4vSQsNMzfNcBlJb/RrfDU/wkBYP6iHd5AsPA3xZXqZwuVJ512QkxT6MO1yu4gYnJh92NKitp8UBlEaMtv/+Ga+xsUE0tfR/pLrR4SvGq5rY0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk0MCj6cfR/LgQrPhGKDuyobgFt/I5PqnOqkbwqJ5WM=;
 b=PxU48K+Rol5t4mUGo7KIHwHHc4VgziPlmkk4c0cdzzcO0Nfg9UX4EXwvvjUjCxTFbCQpA92EpAeAh4hxLqcNSaPS/cMi9e9MCUIDbuPivt8ovs5TMS5waE+p7xYMBje0dgRKz4SxNedushZUL1lyjS5seygpXQaBmhkAqhCsNVo=
Received: from AS4P191CA0016.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::11)
 by AS1P190MB1776.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:31 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::34) by AS4P191CA0016.outlook.office365.com
 (2603:10a6:20b:5d9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:31
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 06/24] net/ntnic: add warning about service cores
Date: Mon, 20 Oct 2025 18:35:57 +0200
Message-ID: <20251020163620.282312-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AS1P190MB1776:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 695b6f19-5fce-438b-6f0c-08de0ff6d31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WF4TDX78Qnj9vKkwkaQMqjCbEk4fHMNbF1e+uQaHvujBysAeRxaHaaAXVrvI?=
 =?us-ascii?Q?PijtxKArQvfmMtnPPSSuoRHzsxn1v8ICdpd/2Lq0mRcI5XrdNmnOBA3q3HlU?=
 =?us-ascii?Q?mCmGD6lvR0UR/vc4yyfHDfMLbudkPhy4+D5Ilj+dnilztR8VSTudPFdGE8fP?=
 =?us-ascii?Q?6tjnL3kHyCqD7R6ysyxiXvkAUlVpalGbaTXE97Q1FEUOJNtSlWspnwhMGt2m?=
 =?us-ascii?Q?9NoMq+9k2ZQsLbFuB4E5VE9QeryL8REoa7P/02plWY3gxLA7KUxFwOSKCrD+?=
 =?us-ascii?Q?UsciHZduPuJBfVt4TZ0xp0mtZq/XkGKuOgtlfjQ4qhG4YA/UWtzlgkUyV8tn?=
 =?us-ascii?Q?zW6sOfSFtqlu6q8ekX2vwfdWrFQIOQyWUqmvpwDSpTCffzDwo/PyQSzn7U7m?=
 =?us-ascii?Q?i3u1I3VmIyxLMTiHm1/xrjEXVeo2PmR3YRL4ILQ9kYLiaY6ni13hAiSL9ZO2?=
 =?us-ascii?Q?c3j9H+hs6rRlbCSCamBtusn9xWkCJXiPBcd09jSKk/tE7kC7BbOFS9YpikTU?=
 =?us-ascii?Q?uCTI64XupYRZkTKnk3fhnc88WwF91C6hjrSFtrV6YRw4KEagkLSckccZLHR/?=
 =?us-ascii?Q?1DEXh+qYHdHrKcuU6isFrliI0/ZkQjzewIxVEBvJ9I1wtA2fQJMFbk1ijYzX?=
 =?us-ascii?Q?ufybW5APOSGYAKq83bO9e3GIVPSW9mRQl+jnbMFyhLUZwE2gfwnZQtY/X3DC?=
 =?us-ascii?Q?277ILsHMgjA7mW7OZLQNid+hZhOI+QLOps6Nk/hCZbhXuYL03xffHpsFNWYv?=
 =?us-ascii?Q?GDNaO0S2QZ8pvn0Y0EpvVOJpXQetjrIiwpGpTkUSd6uqqovYQZDWCR1MLe5O?=
 =?us-ascii?Q?h3QJMEhXzPNUbMR2vLQX8FdmaKESlJYIw9jwOTeFGFnr2meCDS6Tt9si7sff?=
 =?us-ascii?Q?7kqSSjkfHMSGkvRO3Feo/FyL/F2vtaWCw/v2hrs+V0Br3mtDhviH0b9RGL6m?=
 =?us-ascii?Q?Lf7SjU6P9hIkj06ZIxO69c4p0EMZte4Pf4H25r1IWseEjnx9gysKBBgSf+d0?=
 =?us-ascii?Q?Ted6bu/2rxSXxz4e+p9moErb9s+1i1Y23RNCdr5smQgzO/5BsiMyw2kjR1hG?=
 =?us-ascii?Q?Z3c6u5IW7sdnBSN33Kz4HByNAbk3fWjGHM3pSunwtNskONaS03+/b8w6HGuc?=
 =?us-ascii?Q?Lg5oG9O+icT3iEPKUXKQNsByWk4Fv8x3Gn7OjS1+hB96Lh7XTNn+U0YYQFri?=
 =?us-ascii?Q?zSuAgzyMBmxbsf+aERBVZFEO5TWWgFmfqF/LZb00UGo4IDOy7E09R+B6CZ9W?=
 =?us-ascii?Q?19+vU3XTS39ju1O3mTKCUatzo6LvPYZGsDbkFZ9zXwFMJa+EH2xS2+2R0G1J?=
 =?us-ascii?Q?T/WjMcMRxK1Ct7yVIkR3bVsrdH1AbGId/w+l/RMJRA0evIlHNSX79uGIDpHq?=
 =?us-ascii?Q?QsN9nZprdePOufp4ieNUQQW82KYHuTw0Rn5McyejSCGLKe3nupUeasyObqCD?=
 =?us-ascii?Q?qd8pgHvDB8bhvxuJbp/oDbDVyps6ty5LGE0YjTkOVfCgwEl7KDoUbaW4QBqt?=
 =?us-ascii?Q?CgxQe/mQmuWPJf5M+tW+9k+VZ4Cszc/psb5nbGZkYLRvShbPmGaRjdUNJ+wk?=
 =?us-ascii?Q?kRxmcliFgkFQQqvgkgE=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mxAtp8XSb8o2dXeioJhwj3YRaKtc5Z3FaYPEI8C8wEtJjJg+UTl1RAv32yeCCnR09V7LEEUfmaHrG+2Xxx6L1Sywol9xwj9kkkMY8qbc1Vezem2ArufHSxUb1S+afECRKf/4fWzekTEWkxh5QotgwGKAg4b0n+vojbFTYiFdWivQcq+AcULnB8yNOnUaBeTsyBRR6pu5d0/o5jgU/RlWKa5+O3FNAVh6ETUhArjr+njHN9D2WV9mhgUmH30JyMeGLeSbX1mWT+oQDKL66AY7fPvG7b37KrjbdqiTfdBFp0K5y1N9n6jZTiySH18uJecnasCS3NfuCzirpjKoXlUqQb6KPLum/9PV7JCkhNLf5N4UWx3obxMhCBDKjNEyXnZ8IqAFx+JPZ/QcxSJ8Ge1+ggtwp0pDZbq17QuylQgZUI09637Cke1QMTgrAqbBrQjymUwY4lQMTB6+rMUNWp0sHPIEsfyDzUdA/2OVQ2x21smMSH2sb5EVvN8c9eCJTJk/DWDeHT6F09cufpH0MVXpRzi2dgkgl3te9Rpax3zP++6NyIr2xM8WH9bAAe41Mp9nNyzWAB+nU8We6OP1RykS2YVbHV+jFblbYadb+niBvSXKjTT4G/3++Uxg3lBKTVJgwqHWYDBayiDwuqSxl4VSL1b1zsAF//dzTq4lqzx3Zps=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:31.0184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 695b6f19-5fce-438b-6f0c-08de0ff6d31a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1776
X-BESS-ID: 1760978192-303027-28480-63524-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.130.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmFkBGBlAs0dQ40TzZwtjALN
 HS3Dgp1dg4LdnE2MzSNM0iOSk12UypNhYAc+j8kkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan19-215.eu-central-1b.ess.aws.cudaops.com]
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
index d98c0289cc..40a8d2b2dc 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2608,6 +2608,14 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
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

