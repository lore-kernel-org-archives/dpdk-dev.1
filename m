Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800DDC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 11:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 702D142ED0;
	Fri, 20 Jun 2025 13:27:34 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id A769B42EC5
 for <dev@dpdk.org>; Fri, 20 Jun 2025 13:27:32 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023114.outbound.protection.outlook.com
 [40.107.159.114]) by mx-outbound45-75.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 20 Jun 2025 11:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjyi0EGHOuFbmE2BSP+v6dFYiBgzVAKVUigjM43C0OprcyuFuqDcGn/Hsoui+BmHW821QxbmMMoAHPWzX1LW/r9j0w+u/pmK2pjRaaz6HOOh6RwuRYtxKjLsHhI5VrjDJu77WqhO9vqv6ACKiQCkJEU7cDr74omfdsF1gV8zINsDAboQz2u1je1ym+99j43zLdVZuKyLiJEpIu7IG08lyKCi713qVIQCYuwEuVixYjh6RyJfvMqiIFv49y/jMXqMvFmH6gqcZ1PIPiTrvivFFikRnRe71sS8LBSlT4w2P5Vhydr7R+ptn8jDciloXM7NR+0ZbUwLCEjb29HDXnlTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yL6Y+rVRj613FvzEw2rDp1fMnOEUhBYNIrsTc7K4e4=;
 b=qdn1hyt6wUcWylao0xUKRX/4UFIh0XUuMPH49oHjWoQpAPyJZyyr51AhwnT4rE78V8FJpYletO3Q9qWOAfdPoT8W/GLG6RsVVlzBcpOjYZX4JlDOJyAd8rPtMJ/kgG/wSxwdWEmabeURgikhFxqbn/JhxddYyi+lhPhoFiwyjRIkXpVtK2+fk2BENQ6VGPmP6I2nYu2XhBiie2VKuOkcpXvuIpGUZrwZ6WliRYP/Ov8XnOL+LPy9PoXWiTa2S2tRdIpHwKlVDEOuEpwysspRAmQR3c6ifeS7+tVKzpeLKaHNpJFfGhmE9yw6f1zMIFdA1LZdTptUKaoC46f13ELN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yL6Y+rVRj613FvzEw2rDp1fMnOEUhBYNIrsTc7K4e4=;
 b=KMceyIPfgh5HLm0p/MB7/TtpNoJIoo6NrIbtVE0vnsMBJnKdXX8sak+8TMw72sN32Iglr4fHOkAxsqVCnJJRtxnZI9Md9+6llO6QzotCgHhKlCVbNmEKv0XuoPv7ZyyETfsdJQ+8mD3HDej0ckDdoabau7m03FeGNbc5xgI4Tfs=
Received: from DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) by DB9P190MB1841.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:37c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 20 Jun
 2025 11:27:29 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::9d) by DUZPR01CA0007.outlook.office365.com
 (2603:10a6:10:3c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 11:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server id 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025
 11:27:27 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 0/4] net/ntnic: implement start,
 stop and deferred start for Rx/Tx queues
Date: Fri, 20 Jun 2025 13:27:03 +0200
Message-ID: <20250620112707.294596-1-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|DB9P190MB1841:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d51ff59-6b32-48ba-f622-08ddafed7037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sqZaUGORPLeakkRXD01BMaBN8r8IN49Xgfbrs7ZsLQjvMOHs+cNzxXD8vy67?=
 =?us-ascii?Q?SCpixPeBvESRsYboz7J+oCzVComYnTM/S49z38L11iDmzXTIqTOrZ+fWC7WF?=
 =?us-ascii?Q?YAVfcb+tYZtxXgA7Ao5DmJWeUgVt9PCPZS18CfG1VbOQEyS3OjH9EF1qA1Kr?=
 =?us-ascii?Q?DDmhYwJsaF/7FDXLbcDx8VTY7Qd8o9/kEYu6YRmhR2J8NzPDTk5WEU9umqP0?=
 =?us-ascii?Q?0UBpwM+aWsC3dEdO07X5aasPdJubDa/h8OX9TmUvfzI/LKt2i+g3BPLffz18?=
 =?us-ascii?Q?0bi+34OuiJuDO9F58Y61CnoMRS02vz67nOxAZvjWXZGUVG1724Gw7m3hOUai?=
 =?us-ascii?Q?yZgYfswa5w/dIWF18Dx5nuDB5U/g0ObcgF36efcFHtxzqEd9WpSEHazYZUis?=
 =?us-ascii?Q?s5iYCTFxXeU7RNW7H+tWgxgCk0LbxrWbNYmQEgx/3JXXOnZf3IdUzEZ0QEFi?=
 =?us-ascii?Q?x6NrwgFutOfX+LFXHuYmmDxzpGTQYBkx/hwwIxgQ1AQtVL6tNrQjjYSh7/JC?=
 =?us-ascii?Q?Sp+QVM8ZbNABsdaGX+sKuAhDrLpC9GLdrRqifkVuu7IjNw91rHUPDgA0beID?=
 =?us-ascii?Q?cFfXoUkgBaXf3REkGWZTzux9V8LTztNENO7SqJwgbnlUpPymN/wgRIzxcWKU?=
 =?us-ascii?Q?EgXb/Ufa9MoltzbHws7Uwkk6RWLCn86p6/L551gkoXQGHMjjFtkLK8apFBCS?=
 =?us-ascii?Q?8W18oXfAoOCrmkQZ24i6y0zw3BiZXrCkS+WZFYH6pUsDvtgGaBN+w40k9WJW?=
 =?us-ascii?Q?zMz/jxQvyE3nEEM2uwqXNn+cmZwRFloGSBg+my4Tii4jT/XaCwITVPbLVzDN?=
 =?us-ascii?Q?YaLEnY5RNIh5QMFvNdwi9ZtLPyLd7fpZLCJoAbD7AcEsAbxNhVYwemWctjmq?=
 =?us-ascii?Q?bIHKBUgLfq0es4fM+HHwrNdoDdhsmV4g3vRZPRPpff09DUhCkCJwjjl23qVJ?=
 =?us-ascii?Q?cFQkEDUu41cF3k74qkWOSR23GDLPmj9kKbGxAIBNwFzj0SzzUtobigj2xn0w?=
 =?us-ascii?Q?giK9kM9mv5/KBdW2HyOsliZCNQaipSsSIkTqHHrotqP3ViHJ/7Uo3ofGdt0V?=
 =?us-ascii?Q?ucAjCDIw6j3xTaMCzrYYP1Cce+psBm2pnZhIzowg6Pvw7PZB19Di+TEMxE1U?=
 =?us-ascii?Q?jhpshhphZEZBEWgZB7XfyV6NNNkD51CWbtJAbkP9RChho8yuhXHSzXzUe1Vm?=
 =?us-ascii?Q?k4J6L4nAjW4+y8WKqm3aDtl4iw2FGBWwVFIaEvpD1pa079o3lfoeF2HZw4Ax?=
 =?us-ascii?Q?//fbuOEjFlFqGcREI+t4hY3m3WUBLKkGeewabMIv890tjoN2fdVPTEIiwCW9?=
 =?us-ascii?Q?4zIf/wuwPx/p+34ZK8FR8co8VTzIN+sdnrNqG068mGTxXN+VTohzK8nlgdAd?=
 =?us-ascii?Q?CqrmUbXVAGOlK2m2PfJLBTh236VJEvP3yRay5C0re/YaUI0/tJHeJEy7ubQy?=
 =?us-ascii?Q?LVha6koRGe+9MvKdjRTzRtAf5JYpNt1tM2v3fkL2jKLFmKFR99ywaTQCXVx7?=
 =?us-ascii?Q?GYcq2WWX1ixH+bBwKW4ocMgc0GCClJPDrOaV?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wBP1+bWHA+Gn9lphIwEQC+6xWyMYoggn96X3ME49wzYxbqnlS1QyfRpA829YLHT2/+sivxuPbbJ4SGc3InB5fo7L9GdNHsxmrNR4DEGr6ilpcKvHD+0dznTDNjyq5B2VvHVZoSQpuWsiZFMcPaOuOYcSRCmgU1DIVz6WIO9OjX6+EXYoW1j2LbqeRgCUZE8030KyRdBua2QxKnfV53uNUYIUIU16Coi0dMzbFAITynKdX02j5lWiK4ZHG9n0rPpvCKfcCEeTmp4+RI8irqzO0vZtvbkrGopRz28Yf+0FYyRpAV4fsK1baeosABVW3EO15EmrKVM8BeuW68DjTh37uF3U8H35PsWi9Tf3xQwY1waJ44HvlHB6/6ETAhIrGjcK9YHHpG7GFI9sw2ANLxo4EOYqlzuwG4ta6+GBfGHWON9iWu7rhcKn3AK/9EfYqnJgrmQOTpeAxG6Fe0JUQYttrLLiX2M741cXIc32aqds5wCFi9oB3Awyz3IQrCmdOZPD6ABZd+zTIPhLbxDZkfziqrpYYGZM+a9Vqbfrg6ysYlnrBdrErs1P58tW3Nlx0VmWSNMWWQuZvBZ/G3BT2JmTNs/GZssT6G3o0JvBR1c6yaQr+WQr244agn74RoYZPDvH/Xki9mS6Eh8uhdeHUjcNl3hSVIvLNjlLY0Jdo8t+c4g=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 11:27:27.9346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d51ff59-6b32-48ba-f622-08ddafed7037
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1841
X-BESS-ID: 1750418851-311595-7697-15910-1
X-BESS-VER: 2019.1_20250611.1405
X-BESS-Apparent-Source-IP: 40.107.159.114
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYGlkBGBlAszdDCxDwpycTcON
 nUxMTEMs0yxcLY0iI12cTcwtAk2UKpNhYAoX0aikAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265470 [from 
 cloudscan21-222.eu-central-1b.ess.aws.cudaops.com]
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

This patchset includes:
 
	* feature start/stop queues on HW layer.
	* feature deferred start for queues.
	* Improvement for memory mappings when IOMMU is unoptimized.
	* Improvement for logging

Oleksandr Kolomeiets (4):
  net/ntnic: implement start/stop for Rx/Tx queues
  net/ntnic: implement deferred start for Rx/Tx queues
  net/ntnic: unmap DMA during queue release
  net/ntnic: add warning when sending on a stopped queue

 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  58 +++++---
 drivers/net/ntnic/include/ntnic_dbs.h         |   2 +
 drivers/net/ntnic/include/ntos_drv.h          |   4 +-
 drivers/net/ntnic/nthw/dbs/nthw_dbs.c         |  20 +++
 drivers/net/ntnic/ntnic_ethdev.c              | 132 ++++++++++++++++--
 drivers/net/ntnic/ntnic_mod_reg.h             |  14 +-
 drivers/net/ntnic/ntnic_vfio.c                |   3 -
 7 files changed, 193 insertions(+), 40 deletions(-)

-- 
2.47.1

