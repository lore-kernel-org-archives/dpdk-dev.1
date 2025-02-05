Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1290EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53E1840A7F;
	Wed,  5 Feb 2025 11:46:27 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id BFCC44067A
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:17 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2241.outbound.protection.outlook.com [104.47.51.241]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gA+xCksdvp8X0pnVMvRUJtL8bd7jz4lHjnpy4lU8+O5lBcenQQUWwiEegLL5lyB+Vc9WLNppBXmJh5SNpLYDks/v48fg+YLErhtEYZdmXKWqTWa2w1jIDMPrYCNvITghLxfMr8RNWU+1yzjaMGJ0DIL2Oaox1w6qIgzDBJYNiOM+45USixjdosjeq2u1Tku3NBlMPpt/irEmTbKuSXu6/Q7G6WgDIWTHUAdfymhTt1Xc15v4J1Lf05OJoSGJq5OqOwXoqYKKQzifmoAoRm7FCdCebo//CJT+xt18q9DGyitaY6nauouJi4bDzisUjMSJ3orgB000U2CsN+E7F6PxvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEUriyc16NGu+FPzZLOffrSF94Z9zxsFCA6OiEJKVTU=;
 b=fomX2NuG9OnjVunUgcHbc5QvHyubRIZ9/x1RN6+fh8b1dK9YrsQn5omVBv7Ob+cA5prfnb9h+hQxUCgKvgajM9PrsGl1XgFnvrJLaJ2lBnMkAoGluB4cBEhHxN6VTYyC8967Vj0dOwTc4fZEXw1hpS+/kLRpztqZf8sFTD7HWFiCQTnbgMY77I3hlxYK3bDSrx7U/GDY7cyhuOEKvYF7BYWSvigvCxQlpIF3AqO/NhY1Ip401KgbCwo82hWJi63k6V9xAraSDzuBIJKdENadyNfyizHf9egmbMeOzU3sjpUxS+qF7TD+FpatzmHcnxS7H54WY/RBvf+to0eybOM5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEUriyc16NGu+FPzZLOffrSF94Z9zxsFCA6OiEJKVTU=;
 b=feo6CEuQNyVhr38mSjoCGL5nixRRHHvycGwu981Gi5VbHYJeGY/d/M0bP5U/jDjsafSD3DNItN3rBItNS4bj/H17h5EWhDvgTd52E1j40B+e53lEM4sZwGnZ4zO8SPkPtpyQ/G9iul8JwmUgTcqADPhT+TwCXxZ818Tdw2L64Rg=
Received: from CWLP265CA0342.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::18)
 by PRAP190MB1764.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:299::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:15 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::59) by CWLP265CA0342.outlook.office365.com
 (2603:10a6:401:5a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:15
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 21/34] net/ntnic: fix memory leak
Date: Wed,  5 Feb 2025 11:45:30 +0100
Message-ID: <20250205104548.1533554-22-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PRAP190MB1764:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9025d7d-96c9-4b32-4ebe-08dd45d25097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ielWfTXtcXbe+uXZo81JnaTHKuojrLvmbsdEOitpmPhvBuuV4t9Ru7Qjrc/D?=
 =?us-ascii?Q?j9x1zpy4vUK02OGSS81l1v3pEceE+JkUoxOHhc4qU8zTP/Z63rPUx1RnwNxL?=
 =?us-ascii?Q?RJOqFd6vpMM9wcw295DPRTvcA0I8veqWBdr0nY+PwIjLmBI7CtM98buCw6gT?=
 =?us-ascii?Q?8PTc4bs3s9fGfvgNYgiWBZGaj5e6FUL1qtW6FIQurSlfZFf7O4/B0E43PoPT?=
 =?us-ascii?Q?dKyTW3ZgenftHYGhx4Q9zEKxerSaeWpNYsNZLVDRwYZAjZjmG2qiVg3QFKaO?=
 =?us-ascii?Q?cImMXd/+wwi7NwzpHp/YEYZvX5gAHGKvgmMVvCHt5bj4ZTCSi2l3h++d82H6?=
 =?us-ascii?Q?yvhRPfDPmczM16itkdtwxu4wt2AuLjyTMmqVuojQ1UMmjdBgLuUhsK00YLTY?=
 =?us-ascii?Q?9zuK2rSRzqyymRScwwKGd1m5uN66u76Jmx8krzhXuv5dVvdZZwWy1KztP6tR?=
 =?us-ascii?Q?3OYrHnG3wzzphVEpd0+L15Y5mlkNV8lDPTGcsSziGldZdSK3hgZ7JRyeQse7?=
 =?us-ascii?Q?shtj+S/iVR/Ke6ruWjuo1FcVc9D88mu4u3G8qmKyJFm45SwsGpt4oJwUSJos?=
 =?us-ascii?Q?WM7PxFKRUJ+vABNmp7fJoY5sUJEtPu2EZZ1eFGkgJt7b3MTOmxy1XIkZ/kua?=
 =?us-ascii?Q?aQf7qeZQNRNY9jRlHBkZzB2gBJGd3lvrYxA4+sAVDZJm2QU9tJ8tJZ8DdpgH?=
 =?us-ascii?Q?pDvr3YVVUMg3YzamELXiP+3zaBhFTQHHewr0UFB6pxfra99thV0Qs+2DDQVD?=
 =?us-ascii?Q?0DkxAodLGoy9H+ubYRDiq6utANPOdA4ogD1jwmbQTzs34R/VGfBcHrlYe+iX?=
 =?us-ascii?Q?OTRRAaIDxNHTZ2pliJY1R1WB+VaeKU9ljHSlGtV98FF4HN6xFEYSOiWyGzpE?=
 =?us-ascii?Q?OI8ydF6aIwaZuKk+FHHbiN7p+FPXQUih/9neewJPbWGNahiRHwdrdPr1++Ct?=
 =?us-ascii?Q?KsqMEn6OXP/4y8Eb6eq+RbhCxKT3+feYgGGt2fLvTUH2NFBhVqihOU1xWS3i?=
 =?us-ascii?Q?LAPxvUpz64dCFDj0o29pepG/ibg7UjgcXs2VwLOtBRGJRZZqh0oGsSH1Pe80?=
 =?us-ascii?Q?P91r74t04nDEBes7K/t6Lop+GHfTsgXRLfqX5KH59b6kRH6dNtOcFJTGcn7l?=
 =?us-ascii?Q?NVYdzIzBkl5MODTzGM0elenJQfvzmm2kJS98IRACE0x4fWBfYKPVGuElo/mF?=
 =?us-ascii?Q?JUHywxH18i3TNHZzaSt4if/KvAZrOiQEzvISmO+vEC6AdcNDGaHLjb75AoRx?=
 =?us-ascii?Q?Qh4V8/iEoBTCPwlORz7aRefoMXNxvq181DlbPiAb5A2iDusGYPsVzN5DgiEP?=
 =?us-ascii?Q?M0LgHwP4tbHTVp10b8APtaHLVykg0pqeZaLape7n1Ak3g2K6Ln/jYn/TZv+W?=
 =?us-ascii?Q?Sa9G5JLZf/LJsQtsKjcq8VEU1MQGBlvwz1HxjHQ8+A48p/48qqoy8Ro1ar3K?=
 =?us-ascii?Q?nebLxHx4tyowiayS+/VRKsmahSxDolQlZ4MZsJJYMhe3enTK6FWA3WuI16ce?=
 =?us-ascii?Q?U5fowx+dTGGLgKw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: arnh7h3ULSs3lQepPdxpdvviXBKHIST/4xbEaYfU3dcnM/Mi8NLOW9HEAIYTwjSwzAFaON9iQfxtbPiOsoLdUFVSEKBDV0Z70nRn6oPKhl2RtTSM4hrJ7iFsFAufQy76lRLWg3JQTm9rClfkdmuMVi8PPUlse22QwIAGGll1S9BeBuUM9aWQ3fBlusm4uWlpd+FDRpFa6eRIeHXLuLECgnfbFz2Qs1T1yR/tU5z7wx3hScRjSC3PPMBm2UOxM2wpsx3OkNWPDiw3+HwUde4ancfJaF5eoOIqVjhAa5RDL0AwSaTMds7G6vJ0m7aiRUF+Q8UBAcFBuO4otkd7keMCDiNpBAvVWFaUCGTPgd/yMztNRTfd+/y7fKHJaeSnTuOWaDyFCk4UooxblzU6LWjUv3hG1p7ZLcB5a4ZZmyd7c5UVCad3aNdw5U9T5BOKl/XBhAZluXH/MOqkkmeOUNNnDvTuiJeF6XGUepKnEFY2dOh98l4QOMP2OoKPyCDyyaCAvS1FE6H+Kpj6omDNPjMK4DXEADaW8ffKyEAbSdTk2Xga+DePGRoItRs5svOcusaal1Su1FH2zvfYXYiDw/eYK6Iyn7aUrTVk5pIerSiWSw2sTcf4CXKujt/52CA44YRWszNbjHiVAyMoGljz61En8g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:15.2614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9025d7d-96c9-4b32-4ebe-08dd45d25097
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1764
X-BESS-ID: 1738752377-306009-7766-618-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.241
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpam5kBGBlDMyCjVxNjY1Nw8KS
 05OSnFwMjU3DgtLcXMKNHC2DTRIE2pNhYANE+BwkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan14-207.eu-central-1a.ess.aws.cudaops.com]
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

free for kvlist was added before return to avoid memory leak.

Coveriry issue: 446751
Fixes: fe91ade9f5db ("net/ntnic: add basic queue operations")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 6fcbb8fa9b..d1360cc925 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2089,6 +2089,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 				NT_LOG_DBGX(ERR, NTNIC,
 					"problem with command line arguments: res=%d",
 					res);
+				free(kvlist);
 				return -1;
 			}
 
@@ -2112,6 +2113,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 				NT_LOG_DBGX(ERR, NTNIC,
 					"problem with command line arguments: res=%d",
 					res);
+				free(kvlist);
 				return -1;
 			}
 
-- 
2.45.0

