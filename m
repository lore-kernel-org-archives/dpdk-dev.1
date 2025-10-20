Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632A1CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:38:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62DD440E4D;
	Mon, 20 Oct 2025 18:36:57 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id F380540674
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:37 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023141.outbound.protection.outlook.com
 [40.107.159.141]) by mx-outbound47-33.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTYvfa4CDFkpewNOhliaQ6zP/opCS4ySo40LmfDXzG1I5ikN1gI9mnx9jbLViR7Fns1nG3zswKMMKlZF7N4HzAqK1/jcgngUNG5nAn9XsF1LaU64CUrhEDruqywIpGdoPBchQsA9IbPj2syYesBwvtBjav72dG4DfNqnjex/GT3T10bVMix+GDmU5iZ6irJYSYuCPSyVq3V5jb9AIBEAMyD7Bw0+9odMByiUFrbkNHpUSLmc1yUtjv1bkswsGFfINBoP4J+AfkKylawINTNQGCZQj1JFFMTxLzRBHVli/nEnwGKES7unDPAXxusNMLCkFH6lFzuFbxsrR+NTJ7Ls7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWmm8IJSpEknSBDuQLBuHiIF87VOIq8lAB6dpwAXBio=;
 b=MiP6a6vDF+0HcmJcqknDXxK93GWZIxsGeHyAKBFjABWXLAIMXwwapIl1mtGPt0VWFikQZ8tmrLwhWpIezesObEMqEI8HHsDpi/IlJkvZC66Z4cCVAPiJH4u77u8o7QSwmlSsHpR/icmNS3ViXXixMNKx8OpLkOzBodIbj3jdv8jq2X/S5mZZy/5h6OACx2Vo6M+ElPKIpaQi+FvZhK92uY8AYStVLIOY3VKl9yUEKYUQkmQ2oJwAXB9Zy5o8fo1LEC9cotv9UgCVAqQR5pK85WIlUvzwJtAub7Sa49Sy72QWZ+HPoaMbgresOf4jYP1xQjPNFwgniu4E/sPneIlglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWmm8IJSpEknSBDuQLBuHiIF87VOIq8lAB6dpwAXBio=;
 b=YiM1C+e1dPVh3HRmkISEMavEoNvvVTzXo1gPW2t0FPbCD9gxorghbHwXXgNwafkXXQI1wLyZy7EZ7nYva5/jigdVQHHgU/oPEf9dCoopCKtYDnF0VUby5xKiHJ43n7jr4H955eJFlMtQO1Uox9ror17cy3Ct9AkddbKgSEBkvsE=
Received: from AS4P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::19)
 by DU0P190MB1930.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:32 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::e3) by AS4P191CA0023.outlook.office365.com
 (2603:10a6:20b:5d9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:32
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v1 08/24] net/ntnic: fix potential format overflow
Date: Mon, 20 Oct 2025 18:35:59 +0200
Message-ID: <20251020163620.282312-9-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DU0P190MB1930:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 596c2d18-1ebf-47e4-02d7-08de0ff6d3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YFDrUS3hjWji67LOQwo9pQAaBVIOl+ljaHAaIT4BssiTPkBF+kAafyR1qJgu?=
 =?us-ascii?Q?2GyEeRngfywybK937KrOF/1hQBi5OcvyIgISaeMgoCC923fuo++o1uR3LgrX?=
 =?us-ascii?Q?rpjb0RGYOIUmzZUfuj9X+oFYEIqDTgiOBSBHkCoYDlzfV2jLw2P5PShFeCwQ?=
 =?us-ascii?Q?GolV/SGsJZTLhTyn5+cgHbfc8WQ8fNgt1eoAu/1/MCCpvluALinTMJzEYtMr?=
 =?us-ascii?Q?F3C2lJ+XR1WYDVxwmPxVZpiOcQO590yaBUDuRu5/IGfOQn9GVhAXnCZ5t6yR?=
 =?us-ascii?Q?qlHX6ZM9GVXI9EX14yisjDmNjxZmfmD9Fj4T8XsrKi+yHD86PXw/ZvZYrV7j?=
 =?us-ascii?Q?vb5nXbWYEqyb+b5J9kB9oD9HJtH6IForCgnMpfIadIsQ0z8Ui0+c8GeZPv12?=
 =?us-ascii?Q?pXqt4DqPpI9GzwopSzu9u8+wwp/u6Sp79D4J5H36pjAiRQ0T7N1524Ioj3Ra?=
 =?us-ascii?Q?OrjRSbveTbI1GwJxHMMQwtByFRi+AMH+Nx2gH/cVW3FZYsngIDRUIPiztZkP?=
 =?us-ascii?Q?h2iTb6OQ5mW3ToqhtbSbXmfWKvM/HxbNTfRCPhm1AiCxW8t77yxXvJXt7pQh?=
 =?us-ascii?Q?0DrrCzS0ww/vnmnTV06q2juRwuAsdNaKPDHJJ/LtQ3tuBBCM1HxUYO0rgOK/?=
 =?us-ascii?Q?lpb63tiv0juGdaNewqK3PTt1f4wbiDavxXnSz8NLWa9XuKIWVCDuV3OgC/u3?=
 =?us-ascii?Q?nlRwVnOVDyBE6wP4nl0u3v8AS0/+H3vuQUA75rGtOVLiAu2dOy2TrHm27O/G?=
 =?us-ascii?Q?MzwE8RkrK1hWKeKOhTUDcAEyUpHrLKTK23FWk0TT52pfJwKE6jvj1cRykfmu?=
 =?us-ascii?Q?Yovwd0D7dtXv+nF8WOhuJGS9vTOR0O+eG0XBlC4/w6A6Edu7Ig4Q8DWg0pu6?=
 =?us-ascii?Q?1S8Kr/Jt5dKFg5d/wOGPkS6QhxscHH0Xc7883jtX5I9/VMeb4zyjCGZSTdeX?=
 =?us-ascii?Q?ZcjA5Lw9ao996lVImSNn+JvtYlfZnsMvt67UuNkcVurxpc0BLV3LHoZJSIpR?=
 =?us-ascii?Q?EU95waCGPdzbq2tJrd84czsvDA9NbAuwbA94f3hDtC0fHjsd6/d4WFDOCHrD?=
 =?us-ascii?Q?ZX6SNr+1knMh1XArNhMjJqwiiOudpVGdCcqf4w4pdYC/S7kwxf1p12z15zPx?=
 =?us-ascii?Q?jRA2FmoC2xZDxeXERHKm1rnYhdOOi+z9ly7DCeSIwwmoSW8OSB3ho3q41oiA?=
 =?us-ascii?Q?bG4afZ1P16YXDHTGOtnp/8OYJ/GPcWCiCvGI4rG9+TzZdD0E+D9uLspqqP/X?=
 =?us-ascii?Q?miUAFZ+Jc+7sAYZCZ8OUJQ3QXVnHY4RoCow4jEs9caK6PdFXgEEZzWAiKy2i?=
 =?us-ascii?Q?mO3SU0O/hMzKy9lANWMuyZ7ox5rThaZT4oqbmohg3aU6IoDRVqX+TpjGLRuk?=
 =?us-ascii?Q?mzKi0Kp4zNzs7KWJ+6oTMXpmmlkQkv/+XCafE2w5TYgUHMcx8xsi7fs3n3gD?=
 =?us-ascii?Q?+RmKE6tHZZim7KWzqC4FjbRg93q+60+3ETuA+2j0NQEI4OnMnqIciEsALO9V?=
 =?us-ascii?Q?5rGdbhgcvPvUREcGFFVySwP7vUVUUoqt9t235p25FrfOGkRGDSTR3E9bVFsv?=
 =?us-ascii?Q?RcEUjhnO8m7ZQyeJ7fg=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8t0RoiDMXkvEa9spAHMLvDXVErjqTIsWSBF9B1pKJxUOeTrc3SbUsTdmbdoRuGN5m1BLR656VBuSitJuZEGw6/Rpk8n2x1zJFV/W46eVSJ/E1jlDmrP6iQEUNEIYiIenr2/JzMsJVkKJTWKZ5r5uhJNedWlSmSSZVhOmDbPBLfqPWq2hgxV4mjuV5mzpBFPO2cGMQS9/BtUcXWWIlrJcxDdt9ge1IMxxOuiZ7H2u382TwxHjwjTQdqno28ajpujGxcM9FX1dAkkWIb2vjA7iyh1u7CiSY81P7Q/yStnB3HLPF3IFDxBbPGQIQ7Vytj9W/3iTAHq6XngY8dphlZqkTKm+DKPqWIFgCIkV2U6lR3H6LHTi/L91m+jsX6EY+EWR6bV0mOkVtFA7KdppnNYnSGaZADJVESQCjxIajSbEid4Gh9Scup9f+W8c2POi/lmQ1PfVBMaCRLjxDcOBUtVWAcx0EK7wh4Qu4NwNAkvdEHQjvmaFM1GsUB2tEJRJNcsp66hUOi9iFwMxkWbV+H8OWTWnRpc7/nu382KHqcBypXC2N/sR1cgnZ1f+PWF2NGP3Q//j5hiSZWwS9kHuOa41KmVoep8ogBG4W+khlD1QCqL/FHAtR2fEb3dl59SAyLmxa5iwjbOnxOD1k6TxFJJHIFrES2zl/+ZsSVuhJApLwiQ=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:32.3099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596c2d18-1ebf-47e4-02d7-08de0ff6d3e2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1930
X-BESS-ID: 1760978195-312065-25067-118010-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.159.141
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGhsZAVgZQ0DjN0igpLcnAJD
 U5JdXYMjnZ0iwpzcw41dLQJCXRzMBYqTYWAPILKU5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-7.eu-central-1b.ess.aws.cudaops.com]
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

Use snprintf instead sprintf to avoid format overflow

Fixes: d3dc362770d9 ("net/ntnic: add adapter initialization")

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index a867e7b16d..58be82b2d2 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2613,7 +2613,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 	NT_LOG_DBGX(DBG, NTNIC, "PCI device deinitialization");
 
 	int i;
-	char name[32];
+	char name[RTE_ETH_NAME_MAX_LEN];
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 	ntdrv_4ga_t *p_ntdrv = &internals->p_drv->ntdrv;
@@ -2640,7 +2640,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 	}
 
 	for (i = 0; i < n_phy_ports; i++) {
-		sprintf(name, "ntnic%d", i);
+		snprintf(name, sizeof(name), "ntnic%d", i);
 		eth_dev = rte_eth_dev_allocated(name);
 		if (eth_dev == NULL)
 			continue; /* port already released */
-- 
2.45.0

