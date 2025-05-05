Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86987C369C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8103040678;
	Mon,  5 May 2025 09:13:30 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id D2DA140676
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:28 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2107.outbound.protection.outlook.com [104.47.30.107]) by
 mx-outbound18-65.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTQx0IXF8HcsmQB6sLye3T9YyJ0clJMtQ95dTzn7FFRT7Dcc4hrWVNMB7BCXYKSURdSjuJtPyK90wwks8X36Yj4isV/cWjwsAmZ6QOrMB3B9Aw1JJwXmgQaUNvuz+tJfwq2xqR4MEcfxkaKfaZrEKDZCtvKaKripBBMbCXDCMS52ApiXsiBrwXRAfz/2BOIXGtRtWyMGaEkJK398cTJ+5oZJ2uti1JGvTlL7anPgjuPcTvGRyiPaEvPElxrQSNiCTLnFn7T0XLrfa3bLKHfXQadFZyOmcswT/NI/XmHsXqdH0wnknz6uenjA0dHrEXEKRFd/XunfdpMgIVifPZcCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJDXuO1SgS2YOg04uDgy4O0aNItobi58l4WakWyrug8=;
 b=aEM5IG2MifDBAI2cZvgitYTl+As5PQJpttv+A3C4KUGfqLUZu75T2CsxGYBhN+fuKFAHeKPvD50AUMzdD2vhBFojAhrARTj3n4ZqjH+zrX8lM6Q9Mma+F67Q5koyMs/t4TT4aWs6Vp72xtosJxf3Xnnt5vbjsS5bIuBiqzS5auGDku3z3DyXgEse9np9s7qunJjWkcdVA+BrA5HN2rvgMeUdVtdYy4k64dJ1s/mE9qJKuX3f5837P990hciaoM0jWU2c0Xo5uHrnVMEkr1iBPsR3QT7+QTTM3AVSNggjef7qUFrVXRFXysh6N5us8zisAP1njA7vP1KuQgftPA0Hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJDXuO1SgS2YOg04uDgy4O0aNItobi58l4WakWyrug8=;
 b=Ojp5yEwVyc8GUtmmgTi2UQtJzjS4ZKrU8M8b38k7QhFoAyakX+2QtP6N0HNuhzb713ebX2KPvY1RzR1HZC/W50nMj7Z/ccRfbz4OFxccOlNIMXwhxombz5W25jwYOms+O2H/CMRLnCGHZ+fsj0lmh3JC6Asz/QZx3XoRXNrU8FY=
Received: from DU7P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::20)
 by AS4P190MB1806.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:18 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::14) by DU7P191CA0001.outlook.office365.com
 (2603:10a6:10:54e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:17
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 07/26] net/ntnic: apply packing to the structure
Date: Mon,  5 May 2025 09:12:47 +0200
Message-ID: <20250505071309.586015-8-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|AS4P190MB1806:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5c499ed1-222e-4874-1f0a-08dd8ba44f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FB5X/gix+4tdzcRBmcWBR+M79v5dhjjPbw8pDBSuwkbK3ULl8iannAxcOT+O?=
 =?us-ascii?Q?KShfF0uVxit3tB6E8Wz48HcrryN0mQAhr/RGJGGzUS8Uqr3z8rG6YtUdiJZC?=
 =?us-ascii?Q?t9ECax4NGtaqrlWucEMXeJlquPsiYZF7qgbMOgxwfImy7R581qziS8at6WK3?=
 =?us-ascii?Q?yLPIwUfLJ6irbKqjF6WVPFHrWk3NsS8A0oRuivwA/Gu2rjRtW3ITlQ2P5qCw?=
 =?us-ascii?Q?0IIpRQ57TLhN1qJDge3F+UhTJRCmUB69cznzVlZr6i8F566dinJLMW3KZFpe?=
 =?us-ascii?Q?TwQx36Not7ETewGI1pkG4QqJjo/Mtw9A04CLptf0hEXsc4gA8VOxmax6Lc0Q?=
 =?us-ascii?Q?lzZR8IZvMbilUZSdVO/Ml4NhgC0bfDvqbhgak3tTUVotqOmWnNW1PjeiUf6h?=
 =?us-ascii?Q?x3/LrsEG6usfJXSn9xXYF9kIjemY3tymXMl1ZiHpmHDTAcpH8g5xG0A6/2z2?=
 =?us-ascii?Q?qk4MKIfKqajrjXVFqt5nJK0RTvBf/AfjaiYhNZEBYjgHWZ8SlnRz/gAvlLIc?=
 =?us-ascii?Q?JBp/0sq2l9L9cPmHHsj55aiNjk/p7e9ejp18RTPsCgjFHcrPUf3O3zJJYXDL?=
 =?us-ascii?Q?j/TQo1aVTSDz+rwrZFhell+7/wl3VbP0ahuJ0FRg8+6ko+mSx+rl22SLj6Yr?=
 =?us-ascii?Q?s/zcBBOtBvnV3qnh/745CemRPMvMoCLUoIkWqTq+fxhuJln6GH8DLWbs5+jT?=
 =?us-ascii?Q?q8k88bCdqXEXz83wpi4RzLr+Bz5SZ21cikIqHfz6w3Ef2TtuZ2qcVsPEYzyS?=
 =?us-ascii?Q?8jOovNU1iShsR8fXF/k8j0uTEeR67Y2Ml2mpV5X1Cp0RIDSQpE/MDcdAVcvl?=
 =?us-ascii?Q?ETxd+u4CjC3uAnqdxLV40hRcz9D7Fzgsr7aBoXcbvX5+ktxsUZR3SrFVCFgZ?=
 =?us-ascii?Q?A7tk7DDA5elvUp4jpRnW9pRMvn4/QQl4izT+1Rm5JO65JiMTuq9NAWHldZqx?=
 =?us-ascii?Q?Xzcjj7DOHfrMwS0wr5fAz4B/Pxj+BDrMO/tsKSH5Guc0dKbTHj1X23oA+Eq5?=
 =?us-ascii?Q?jMstqx82LMLBMf2k8tw7wccs1To5rAm/GVBUZNmtrRcMuyUI4Tu58ZJM0o5T?=
 =?us-ascii?Q?eDsc2MoxbhrV+MCJ9+5XXdPNay9vF/FryATsLFe7XFv/VkDSnEFqc577xO+2?=
 =?us-ascii?Q?vwijd8a+u9lDxL+PoKoTwM62X/GW6yb2qDuDyqqZe9twnzcRgGDaO+d56GbT?=
 =?us-ascii?Q?2vOiDo9LGSRaUFrzYYZhWGApK0wTjxbxTITvB8kFerfH3RmIOMWL4ixTzItP?=
 =?us-ascii?Q?6KwNaQNiIsezo680qfjR+4zlOqGqs0JOcX9HpmQOE/JnlOAy9L3D6Nz5hRPq?=
 =?us-ascii?Q?a968igfClWPseRY26YaTUKMedJg2kbjhtRV7rWdGj3/MgSqzd7qrqQRwEV4w?=
 =?us-ascii?Q?K9WuJlN8ZpSenu93jl6NAWPFk7a7GYEpxLUPpMT7rB9hyC3w9hg1VqGaweyn?=
 =?us-ascii?Q?6KLkhyFBsIh9rSactD+KNIJ8nD7Ldwx9EQhEAL1CQ9lLtw+du+GANFZC07Jx?=
 =?us-ascii?Q?GQ+nqJdhdX3KowM+Ztg/rCS8z8ky1MEfEat9?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MeCBNEkbCeNgjg/bga3CvrLWSx9tE5sQaYQ89FkytEymjk4z0Pr+a3aislgHmoZvOgB0x8ZSMeQXJn3tMaeIHIFeWZH+Dm6J5Ve6SlRW/P7FefrAegLyV9qFw5okkQEM2/lUZUb7QZJfl3Lqxf8ZUYr0OPIOU6N2HI1Pt1zahahQGL1rIk9jQzsTWHkGChwmbHY56Cc4jlOYJNn7fyX5TGuAlJyhGGrmuCvEIFqMNAccYIg+e9V8ZP3gidxk6WokSjCxAdJe9BP86t6QtCSxKf0ZlbJ9vn3NFmKmkdP7ZGsG8Qiv27+NY5BF7VfA5wiBVkCei2La1G+H8tOz99wI9JLHhc85lLpsJKa2Hix72WDLlnCZ7CDq/iJCAp3fHSPSYEKMNR0L4r3MWjS/vuPHu3ard8ZRpRzKZnlRRE4zyjePl8XxJc/PE222NcRirO2YmEgO49+oupW1hiEC4SJq9zrWL2h8jk+tpDbnQSD5a3ddpsqiFYtlRzXcKMba5x00BULCnIC3xAjDjtOtHKjgdXO5otCuwdwdqe/iWeNgE86KnG1jAxd7vxkvD8Ihi9zoKXFm+EDj5zbS3UKR8aMeSiHV6HIQtpcW7PpU/TcmuiRf0rsXkrlN8ZRoreoIVoZSURfaaAlY06oOA8QAMH3IjA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:17.7910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c499ed1-222e-4874-1f0a-08dd8ba44f68
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1806
X-BESS-ID: 1746429200-304673-7668-375-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.30.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmJkBGBlAsydzM0Mgo2czCIM
 0g0cw82SzNMCXJKM3ILMXE1DjRPFWpNhYAILkZ3EAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan14-166.eu-central-1a.ess.aws.cudaops.com]
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

The structure virtq_desc should not contain any paddings,
so it has been wrapped with __rte_packed_begin and __rte_packed_end macros.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/include/ntnic_virt_queue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/include/ntnic_virt_queue.h b/drivers/net/ntnic/include/ntnic_virt_queue.h
index b95efabf97..072365c946 100644
--- a/drivers/net/ntnic/include/ntnic_virt_queue.h
+++ b/drivers/net/ntnic/include/ntnic_virt_queue.h
@@ -34,7 +34,7 @@ struct nthw_virt_queue;
 /*
  * Split Ring virtq Descriptor
  */
-struct __rte_aligned(8) virtq_desc {
+struct __rte_packed_begin virtq_desc {
 	/* Address (guest-physical). */
 	uint64_t addr;
 	/* Length. */
@@ -43,7 +43,7 @@ struct __rte_aligned(8) virtq_desc {
 	uint16_t flags;
 	/* Next field if flags & NEXT */
 	uint16_t next;
-};
+} __rte_packed_end;
 
 
 /*
-- 
2.47.1

