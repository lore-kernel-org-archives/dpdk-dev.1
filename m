Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144E1C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 16:27:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E767F40E19;
	Tue,  8 Sep 2026 18:27:44 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id C0DDF4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 18:27:42 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020093.outbound.protection.outlook.com [52.101.84.93])
 by mx-outbound19-157.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 08 Sep 2026 16:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmMC0oXeeQ6G3QYAOPgylCG0n+M0faXj4HbHV7mX9mm/SHpO9KTYbG488bJVwOIndgjY5ghtgATDUGekW5oAA088lvp9jI9cagRP7WwnfOuzjE9wTb/UhlcKtNAOtOpUa5DrCDyu+7qHoOT7McnRa2GGt6ulJ5pKCuMlvFrqho7eR55Scg/G4aIUdcUMK0Egi7vROgJHsO6u+BU/eIGqHYmJgF5+HK4J4YZq6K+i+hlKx+9DHUN/UlSj6oiJi/TEEuo+Bn3ZwGVkkQHwMGMKmJB/OJqqLq0GnUNW+5LNySLYka213mkrFbcwRHrR2zxbQYNG4kA6C35DI+CwoPv91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK927X1M+seEw6sXehutb6lG8o42fpfwNDIQrKR/qPA=;
 b=Q4PGJVRM5I5lxgNEMXydQn7h3Haxh5e0zVdQKpbJIaU9Wm3di9eSFVSuYA9yMuC5775RqH8VYB2rw7WJRqlURy7eLTTlR8xTU9etoITNpus16uVxluI2v9PgnzKUeY7IxaTzsVkJvhU2/pG31kTIhmDXS7G9PdfwTv5L0gUHLXUB8CuVECWyorE+gjcR3kWRHpXx6VenZYO8koxfd0mzLvcyBwdiNPCjrTX/aIXXoHl5x6FO1lfqkbEluagdK0UKOXpy+cHz2F1Wd2tzDSLd7oxWmvhDcMcvY6FeE6nFwSt78E+lcdHbdZbocKDpMNbSDhVFWbsz4h4nyEQVrD+jog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=networkplumber.org smtp.mailfrom=napatech.com; 
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK927X1M+seEw6sXehutb6lG8o42fpfwNDIQrKR/qPA=;
 b=c+VBCuzABBPox9CfxjfqO6XfbsdQrkvHdcsq10BX6lN18vN6PBeCFfduyaFj0RteoeqnCLB6SrD8WnGkrEiiWeogl/441JsdYZ9pERtvZIOs/T2hhB0RAy/PNNxd2XxGRCXri62Zrp8lS3Pf4YWB0UFvfa/QwjM9XxfQayVkh1c=
Received: from DU6P191CA0068.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::20)
 by BESP190MB2328.EURP190.PROD.OUTLOOK.COM (2603:10a6:b10:e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 16:27:37 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::c) by DU6P191CA0068.outlook.office365.com
 (2603:10a6:10:53e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 16:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server id 15.21.382.8 via Frontend Transport; Tue, 8 Sep 2026 16:27:36
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: stephen@networkplumber.org,
	mko-plv@napatech.com,
	ckm@napatech.com
Cc: dev@dpdk.org
Subject: [PATCH v1 0/3]  net/ntnic: fix virt queue data in BSS
Date: Tue,  8 Sep 2026 18:27:21 +0200
Message-ID: <20260908162724.463767-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|BESP190MB2328:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fc5a9251-de6c-45e5-9f85-08df0dc6180b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZU36eFDI8Lm0V/dSP4pJBFhxeWXVRVM8BSCW6/6CXY0K0sBpD4bWBthT5DW4Yh5GQejYyaz+CChipV5inIAk6EgBjJ8q3s/gt5rQY/3+AyVv+vp9nZGXCP2rHRR6I1Cg2fOnZRnc+B5NHvegWyZGxRa9vwMGdhBUvzc4IrqjbHtYJZXHW2eaBt4pWLnc5UVGlKP3NVr6n590EltZlmgspalAHvL8AQ3iED3lyu2VzKMi4BI9fOS07N2gjt4R9QxQ+Tp+69PgaZpDWzuJys4YS/5GjSpHDYDR9ioTrykyVR+FwFOyMGrWHSCkgp0WCIPlVKJcw52vq1ZOtEF0TjlFkJBw1pUSNi/VfiA9YncSNzIRr8gQ47zEkYPsWCZNL1CTAm457S41xl+V97mVXONsHDE9OE3pim6DFkBPQtEPRKV7vP0ogimTfyiaRWjl20/zzGcoQFKZAsLbMjg6dz/C29SWXnVvUEE4hJktrfsu2yRmQ/eNIuNPx7EYwzLTATxfJI/rTmdQ8JyW32Y5Kfqq6TLTzD6u8y+dFVWghbTxXnxb/ZHxBKvEKp9Ug9xNagYPjT0lX2mXaTW84jTdv86vbnZ2OAMmtsrzNuSKTXYeb97zUQbp+H/flFpN9LKUbJXzAqoSMYUH6zBOrGhAO/1UCVoGNXHoXa5pBVYPrj66CYZbPcn8vTQroK7sHlTbXF5WUfbE3UDZjqc1d796Y36ymg==
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8VBXRl4j67nd/eIHDow3RFv0wX9PDdVbp7yFYQgDadE8BOoBXIstVlW4p9HOvmEdPDejCKRMpmvR3BYLr8unmB4UDC9ADXFdew52g63LSwnZafWgjKFvpsh+tCWBeaGSQlfo87uBKY+Hm1SfA6eWjmQdeN+WFyBoADalbU0Lxr9pG+K97pTveWMpvIHRek7B6/AstIgEg084bGD+mFl3qzoBWtO39tWcQKe8mAB4+rCK40Xp0ktOXBuu1lmrq8efNxQXVAft3QIDOCC64JC6vfGjpCwBXwnnY0mqEuM/qkgrSbx75az4FlO1+LMR9sS7tw5kgjoU0daFU66aB1wJ051zgKmEy3uGK+LOPo/lGTg7kEf7E86qqX8B8nGCQhSprZMOKeyigXuL2/SZfjvg1QgvAQ8atQErmcLF/WeOZjPrttwD+vHiw1MR3BerRr45
X-Exchange-RoutingPolicyChecked: wjiSqtRc/G0CXDJUdXAH+97WHLzkiZs0wfVIpwoDSId1JpnusWP+luObtfT0QE/fKUDMIjaKPcxpMy9PK+Vr8P3ypg8zqRRsWs+DADx08gUiiY4dJu3qsm2JCchC4ZMyO+LgWCdxKCnNcIE4OPj/l14Et6bNHAxn9mPQaJGmjCmbgzD1LW486dVn4Uinl8Nh1r8jv5DvLcp5Ur1Q7glyfIcJmynuu+zch1DvlKn+Uxy8spNnSOOCkgJtOidrz+Jro5ob1W2aEeAotwKo57KjTg7NQuzvP5DQ3PTFcyM6/y5/wWy2y9wrHBis5LNfZza45Xz5J/txGzkPh69sXyLxDw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TYKRSbrL9K78D5swX1GzP4IMYJ8E3N4Mrr8c2EYeK/PHRlb74uSQZTpOe3gzbpVboOXUFwOni+KAW5m8TFxJ/476gpeBdM0Zo8vAxJrpkDLwtbMQO+lfCCFO3GwUpVfbdESmHDM3+w3eIgrrL79y4pD+/tDqarzWkTDjTXlZbjapppHEFq7+u76n0gabp3/KF/jbl0/HxIA2Fs+mnXmPdYDDM2El6hrP7ecSy6TDEKb8m5vDNXipiFWvznUemti7grwKjCZQi3AspPuswMjEGEICx+ueZu0KQSJt8S6BR0t9Is0wTa+O0d21x4VeVZLGX1VA+7PeREsW88agOLKFSSawiw4Fpebb3IIVHefkLYBZOw2v48oi5z7PiBotkOCFpBwinehcQSsLJAaqCEgCtOpeKfFeZHF1Y35XNH4J1GanOXgpY2ZE/Aov6X/LeNJTyBquDpb5rHiIcTa3BbVPqk0suGkCaoThsX/H6HEzp7hl/Xo3EUja2J0kD0tMhji0HHdSwg9HIqyzHaG0HXa9lfR9eLmorMSeO8w3iEgnUBdd+Dos4V2d1z/TGvpaZbdUbE2iyaLvvu+/eCsCWM/pDj8BvkYBbjWHfKrUUs0p034HRKK6ppn9em3Rb5/Fko03rvs7YQTHsXkC4Gh/Q4vEZw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:27:36.6764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5a9251-de6c-45e5-9f85-08df0dc6180b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP190MB2328
X-BESS-ID: 1788884860-305021-8203-3240-1
X-BESS-VER: 2019.1_20260902.2230
X-BESS-Apparent-Source-IP: 52.101.84.93
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWxpZAVgZQMNnYMDXF3DTR0N
 DQMjnZ3MDc2MI4ycTMzMzc0MDIINVYqTYWAB6UNzpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.275977 [from 
 cloudscan14-121.eu-central-1a.ess.aws.cudaops.com]
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

This series addresses the bug report "ntnic: virt queue data in BSS"
(Bugzilla ID: 1975). The report lists five problems with keeping the
virt queue state in static arrays; each is addressed as follows.

- BSS memory is slower than hugepages because of TLB overhead, which
  can cause performance loss in the hot path.
  The per-queue state, and the copy of the packet buffer descriptors
  indexed on every burst, are now allocated from the EAL heap.

- Hard coding the size wastes space.
  The 128-entry Rx and Tx arrays are gone; one object is allocated
  per configured queue and freed when the queue is released.

- Data in BSS is not visible to a secondary process.
  The state now lives in EAL memory. The PMD still does not support
  primary/secondary operation, but this no longer stands in the way.

- NUMA aware allocation was not possible.
  Both allocations are made with rte_zmalloc_socket() on the NUMA
  node of the adapter, next to the rings and buffers they describe.

- Cache alignment.
  The queue object is cache line aligned and no longer shares a line
  with a neighboring queue.

Patch 1 drops two never-called setup ops so that only the managed
setup and release paths own the queue state. Patch 2 makes a failed
hardware setup visible to the caller, which patch 3 relies on to free
the queue object on failure. Patch 3 is the fix itself; it also fixes
a leak of the descriptor copy on queue re-setup and an ignored
allocation failure that led to a NULL dereference in the burst
functions.

Serhii Iliushyk (3):
  net/ntnic: remove unused unmanaged virt queue setup ops
  net/ntnic: check virt queue hardware setup result
  net/ntnic: fix virt queue data in BSS

 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 334 +++++++++++-------
 drivers/net/ntnic/ntnic_ethdev.c              |  52 ++-
 drivers/net/ntnic/ntnic_mod_reg.h             |  30 --
 3 files changed, 245 insertions(+), 171 deletions(-)

-- 
2.45.0

