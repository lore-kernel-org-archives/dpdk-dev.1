Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41C8CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:40:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6FE1402D8;
	Wed, 22 Oct 2025 18:40:38 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id F3C4A4025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:40:36 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023140.outbound.protection.outlook.com [52.101.72.140])
 by mx-outbound16-13.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 22 Oct 2025 16:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flSIi5Hr+AgSZDbEh5qfQbEG4m1NYC65F5EyOYnL8kEO55mj2TL8Y7OmWGdfbZ6g6QI4n/3HwQaja/TagAv2hHK2PCYKLfyH8CLrSJwj8kNGRI+gKUktjcsRRNPtHPt98ZgQ64ZvBf5N7GisAfUVz3ponUoZ/Auc+ccol52cPJzl0IBWXj5Jq//itHcLCQnNIPyMpBZoLsoYliYryDN9T/X0MuU/8rtRfQa3FhXUk79Prm1rfe+/yrdwLjuZvSXL8r+YRjgqG/FXxUU/GXYXoA4N31SPUhsShQwL5u6pItqHopSmFbZhMHNSvgiap5neNL5acEpNFUqoL9DoMMFR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEN561boACkxI/2hGZEztd4QJIS/YpGIsPXPA1F7duk=;
 b=crDy6AiYrllTWG+eWHMNx9jvZcnEZ3iLeb6PZR5HxVlmzlT9I1Om3k5CUQlG2Xn5FQwy1uAV5PlXVaiQ51YxF55rq7dR2+dNpB4npNsIeH5JHmPiJhdzBKh1XVc3uBroGdT4DHYMzWhvdMhCMWeV6YwkMxXDETGfBh+JA7rEeFBdAig4t+w3C2XbgKDpfJi9CG8RAnmCsp2Sbal8yGd9izv1mnrHQtTfBSKx9po6wJJI+Ii79lqajkVJhJWhwmsP9R6za1eh8xJgoalKEpxjJ0+yWXb0+FkmKZZ+PEfHBSJF8vG0G6iX8U4YLBIRoH+jnqdPdifpVReRfTSg/rByPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEN561boACkxI/2hGZEztd4QJIS/YpGIsPXPA1F7duk=;
 b=Ay71LXD1WQKZ+yz6QCPAlpHKQ1lUV7XNCE4Wz2don494VuUl1cXMLEcgN3hDEVkv0ILnNZzVWZFOiGRoiRDIh7xJJdF+Ad+17AOlZ5uQaGYd6+rI/KlRg70QHunx5t4sU++6wmHYQGQEG/d4b8f4uGxL/tS7sB3zaVn4eULupO4=
Received: from AS4P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::19)
 by AS4P190MB1973.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:515::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 16:40:21 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::df) by AS4P195CA0004.outlook.office365.com
 (2603:10a6:20b:5e2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Wed,
 22 Oct 2025 16:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 16:40:20
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org,
	thomas@monjalon.net
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 0/1] cleanup the guide for NTNIC PMD
Date: Wed, 22 Oct 2025 18:40:13 +0200
Message-ID: <20251022164015.507050-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <9256303.5OynTdThKG@thomas>
References: <9256303.5OynTdThKG@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|AS4P190MB1973:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9e3123aa-88e8-416b-36f9-08de1189b086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gyOTumX+y7u4xGe0CkSD2SGaYYztnbQMQzSzplUVezvPNfUXGLMb6Sms3wrp?=
 =?us-ascii?Q?qhHrNsrB+wnl6F5U2z0O67vPzu1QmU7a9Ldef4oXZba7eCeVDZb3wWr7S+71?=
 =?us-ascii?Q?CJLJ5cpSUvMG2ix+tqVeli+dfwPiyap0TFWqwyqX4DY3UziXvQRZqejmmzsE?=
 =?us-ascii?Q?fooyPxGnubCNKKYdpo/WRrTasnPa9/TvUqIlpSica61Kl3tFFwUNnIGRjZN9?=
 =?us-ascii?Q?varQiVr7D4LXW1ZcXRIafIzI9JmSMFAxytZ1B+JiB/JNjaCykh1X+lIGR24b?=
 =?us-ascii?Q?NBeSkXrYfVwXE5eR9zPnCyYQBHA6oAbeynm5EDfe3HnpmNaI4TDWMLX24RLF?=
 =?us-ascii?Q?NAJkYK81VFyseY3wam+ceIFnFpPDGbzoP7q3Dy7gppCXC/ey3WkOd9659ZXY?=
 =?us-ascii?Q?8kYaJihZsGLzlek1AIbYxhAzyGiGFU26K0uPawS+PGJjLekYCKNpaLdO8aEt?=
 =?us-ascii?Q?N9ME9hQ5dfSKYvqBWAcFOKF/Ni6xwoNLhkoYHM95wQz6U4Oy5b0m82pA4RBU?=
 =?us-ascii?Q?579pPGJ9Ccf3croW3h0J4uYUcSq/WONI6BHQzlFXLFt7JQA0Uk4nypTQ3AYj?=
 =?us-ascii?Q?HpSCCbfSfyp4WzKbNw4hBITXn8IGFBsrARE+40HGPsggiWv15PBd1TmEnQKW?=
 =?us-ascii?Q?EBfLLp4Ww83FIF1jfA1GD7ZjRQ0ithz3G59zXA9YGtKNy5KDWRdbjJqTRT5E?=
 =?us-ascii?Q?CuxGXsaACFMIdGPRdYLVXrPhIY0KIkcydLy+duOserFddPx8jsGtvORKk05t?=
 =?us-ascii?Q?D/KeegH7KEKSPRb3/lZI57rBywB61n7lMStW4G5D330YAUD4xwWd+V79IWRP?=
 =?us-ascii?Q?8lkQKE4Qfhq3HH9WzDLe7eoag+jtq8oS/ngoNnhad8Nblm5GphcXCuutZcrY?=
 =?us-ascii?Q?kSVfFMM5bN/qyDh8RBD2PIxGTWdLgnWWoSW4nBkSP/T3AFou0DUKnZa9IjjZ?=
 =?us-ascii?Q?KQoNWCq1r14w/ruUlxF4VoTbAXuYj3SICXl6sckVXp2kBinbiVwGlTOpSz3w?=
 =?us-ascii?Q?CRKfI6G7tndxZFxJh1yLlqRVX3yaekIHWJwyTylmMQtXIlpjFJMlyv2KoLn6?=
 =?us-ascii?Q?S6eI7d5lEvkwoi/M48bP1sX0ZXsAbDksi9kZiLBR3R169a/abGd5oqmAPdiF?=
 =?us-ascii?Q?vHtqW9p+v7YZnsII4GSgiNLpvpx3BTLeWChJZoqIio7tW7QqecorkC94OA9H?=
 =?us-ascii?Q?9EzTaRW6yvXUo4PncYaP1HN4rfMKjTcskbWjRaDLpUb4B+iX40PysYXuK9yz?=
 =?us-ascii?Q?+4uUSn6htYSJZly59IBQWkALODZamgH+dNTdrbjwSfLwifK66YzY+POGd52Y?=
 =?us-ascii?Q?5Bsosb2gjcsBM6liCHing86fzxuHCewKLmo4TkbdxbpBvPi/P/w7CQ0OUXmW?=
 =?us-ascii?Q?7XYH9HAiL4WZkube4k53tKWpXMczRE3BGZmR2Ak1lpUZTv/Yujfe2GxvHmod?=
 =?us-ascii?Q?XyDAh4FBeVRS1qwhGJqOk/bFa1bNYH54XMLMSTVtJ/gUrRii0xkqmorUiP43?=
 =?us-ascii?Q?9Ir4R5A/OMyBrNlnNGTqaRnlHWxUf1OjW0VnNQ4L/K3avNF0MsZ9ADU5XyuB?=
 =?us-ascii?Q?rFCdbPGeKOlrWN4ai24=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 503tVcvj89wE79UQKi3D87pNcPrxEdyKgicCgF1VVVLG5vmnL9wsQuSGR4HRqp7AwMDMTsoh7C/DUojWN9Z8ENSIr66dhI9z+iwcxtzGkhlAAS2yR7VwduFpTizG3NBdKyPj19lydd6BAjoJvcFdaKbIz72Pxm3f8DvrzeKWuoXuUPFcPiIDggMPXFVQ3LjMqSNR2A5S1LJnN++7vzPU1wLBlEtW30nzzdGNWhktNdwZF5Qv93DUkr/qV1Rks5aJusUgAtFoEnuXgdRD23v4MleOfBYA2Y1BE7qguelbW9HbHpk0axD5c7Tj2JasJYxN4fG+tHynSZsqGTDxUFYZpZt7mcKQkBI0qG/I3EMEOvQ4yD97wv6J+HkTQCwvy0WQWOcZWQ59OnCyyR2xoVI6DG5QB2tqLRvXWPMPCE9i9UvkGbuiP0dThDbkZnXUm3hg+GEQVjKhv0nu7zJ/62z26ibLTVEw2hUCNVh30XEXgaftryIK2jKphkML6yIT/dRdCIGw4f8eNdCCTCkaYRg/322wzQ5/3XYjBFxWtSOddVc1UEV2pY0GuqtDrVCpPNUxncl6gt/GdUSbgH/GdN8DrXpdxAoqBrcq7UgOVSRLgjMrX5g8pz9edZaA3kEWcvksWPyKVG53V0unNRCo17y5BisgadL/jz7G0uG3JIBK7BE=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 16:40:20.1658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3123aa-88e8-416b-36f9-08de1189b086
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1973
X-BESS-ID: 1761151233-304109-32377-21295-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.72.140
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGlkBGBlDMIM3QxDjZLMnEzD
 zN2NLC2NjEKDXVNDUtLTkt2TTJwFSpNhYAc/mGz0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268396 [from 
 cloudscan22-2.eu-central-1b.ess.aws.cudaops.com]
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

Hi Thomas,

I have made a quick cleanup of the NTNIC PMD guide.
Please take a look at the related patch.

Serhii Iliushyk (1):
  doc: refactoring the guide for NTNIC PMD

 doc/guides/nics/ntnic.rst | 262 ++++++++++++++++++++------------------
 1 file changed, 140 insertions(+), 122 deletions(-)

-- 
2.45.0

