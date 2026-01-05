Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41AAC79FA7
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 16:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9C14026F;
	Mon,  5 Jan 2026 17:52:36 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16]) by mails.dpdk.org (Postfix) with ESMTP id EDDBF40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 17:52:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2EhAz35IYUPXdCfaxREdHPf7pi7/zArJILvJNbYjHSymrc7T4c8LBxdBAlkGrDfmMzGWQf2UifEUHoTb6U1fDAJUehl269AXZ72QbNsmYWvvKI7RLjS+rPt+dcwIgv69wdOfSF618q0VXnlIWxGP+KTrVZEaLSZZEi+0QX6GbIrfVbCsuKL9dQIEuV7ygJtrh/0wyYHkBbRB9WanstRdzp+zsyFjyDEsSewpyIk8Kayzr4M+1mxvsckk1X/PIR6WvKYYu0MrDyvUKNEmNxIQ3EAbadGimfxj7l8bFH5fJ0wuvxqrMsHkVEIHbebMVFsOl8oRA1iZry3sxzuLfgcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=250NRgGdXcrMs1vGMQJEXGHn3/IuEBV/YN0n7XB2QkU=;
 b=N44wyy6nG3KA9iUAwEov5NSW4udEDbL6Ky8JsdiKT+gceQHTyn/qPffEQtSaqfcKEcdnPZLpZwE7R53excW7GYVvIf2QZ3ANcL9sgGAsmp/mSfEOugneKc6DCWID5qrFaKarQgAkDcptdIdEyPy9KPDeun+v5M3jt3a3Bp2IpEqMWTHDrtlqb4zJ0pa09UmyOnYPiaboLK7y5IWJfwmXGg+LjJ3PeXVs/5dWuxvByEZ5hu9fTNSosOndw8Rfm7ZLiuR5fJZrZrRmWN1pA+18958vI9m9txbRt5UnbpBSf4MtbPqJXD0jI0H0LdMYNXVVFhAaDuYpoZJlw4pzmPoxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oktetlabs.ru smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=250NRgGdXcrMs1vGMQJEXGHn3/IuEBV/YN0n7XB2QkU=;
 b=Uhs2njnS8Q5c/t+mKtnsOaJKKSRaDFSiz2FNJHAzExG9QLhuSzaTWFpQjufJGclMPFgRZYIa0/mmd2XGggPccLg/MHF2h/ATJ9MJTMA+3Kg8cLVL95q/rKG4b/bdfhBThcWpO2gOj32Ddqm64NUNdxKNzde4JNcKmJT6fQ2BwlDVWS8Xm9OhrekjONX9+PMHrRqvQk5XetABHlJUi5W4unjadqEXAnhyC5MdBy12+AiyDGwevf0aReNxIU/mZpNuztgMXSSntB1aALacr9QlQ7m5tc6MDIRdaLiItgmmnTJh+mTo7cCLDKUlA4RlvQYPTYnCdeav9MJ4hK15ijdWLg==
Received: from PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::16)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 16:52:27 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::9b) by PH7P223CA0021.outlook.office365.com
 (2603:10b6:510:338::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Mon, 5
 Jan 2026 16:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 16:52:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:52:03 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 5 Jan
 2026 08:51:59 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <getelson@nvidia.com>
CC: <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, <mkashani@nvidia.com>,
 <thomas@monjalon.net>, <viacheslavo@nvidia.com>, <matan@nvidia.com>,
 <stephen@networkplumber.org>
Subject: [RFC PATCH v2] ethdev: support selective Rx data
Date: Mon, 5 Jan 2026 18:51:43 +0200
Message-ID: <20260105165143.326426-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260104131301.196350-1-getelson@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fccdd61-5a2a-4a11-4b99-08de4c7acdee
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VQZxupD3tnJ0MnMvpHwxZpBlVXiNH2OQ9Rxa4JfyH7ZBj3Dcyx+4V/+gak0C?=
 =?us-ascii?Q?rpJv5iSxknPkzUYZghjWgOL7h7a6+LKhudq70l2ByCEqCnp7mQ1f3ETXpCJf?=
 =?us-ascii?Q?aGdlj6G6Wvj3x+MLCATVmI/IJ9uiIz6iAsUlE4XdG7tR2LBiDmsKijGXgerk?=
 =?us-ascii?Q?3HUc5tXDZyTXbSTTSYE3+21odYQsSBP/QjgaY5f95UWryfLdftTHLm+44669?=
 =?us-ascii?Q?dUcbO6d4mPL9jTWnOvpmWYkMWulSeQ89mcTewNdtOjgsdCauXuMx9LKl2uFX?=
 =?us-ascii?Q?0tLcgCABpiGIeMmQoJrm742C+aiS+RS6hvE/4xiVmfjWZsNj+zWQgg9TKWfB?=
 =?us-ascii?Q?n9V6PmqZwxcl6z/lH1OfuyOZnPNM0w5vve6QScB3xSoHC6eS+EuCqYLSt7CP?=
 =?us-ascii?Q?oP0B7pkihqw7at57pic7rt4hwh53XZtjFE139+7hPYJ8bkq81eOHwipcpy9I?=
 =?us-ascii?Q?p20O/JB7vVYab7VoXNVMZL1n+vmz8sLrPECk2avXiGUBLao6WWvcmLhJ15S9?=
 =?us-ascii?Q?t09yx5QIr8XJM5HG/1aROGylUHw3RtcJpouot0qELXSBom1Y4ORCykXEgoNg?=
 =?us-ascii?Q?5AYZXdd2FWg/Bsq1CRuSr0c7ZQjRw+XIPpEJr+vDP3w6fnj8Pz14c3MPKh7c?=
 =?us-ascii?Q?ZvzS8wFM9Z9ix71mckOLMgkXmXysdP8EoGGk1dQd/JX1nefgczRpyIskpWS1?=
 =?us-ascii?Q?FGHSQ8Cs2HTKi09aonmgOMWX+q7wZ9vlce5f/VGVFlrIo+a8SKSLvdMsBZtu?=
 =?us-ascii?Q?gMAZV8LceOzg2beGAEnlWQrTosjSFfXWDG+PTzsZFSPau3s0yHu2fBekJXmW?=
 =?us-ascii?Q?Nr7OmlIVOgOk0dfSsShRskBZisni/gutgAC0kml1U3u85hI16qSGiYWONEFH?=
 =?us-ascii?Q?/HjXi0CODS2OqRnu6Ew7N8hgr5wXvPiP9lgJ6GB/dtorGHz53NC82d6EqZJh?=
 =?us-ascii?Q?+UbeXLCrkcHe96q+qA70ropKIs8fRH/ueI5YCMkCSxIxJrBTysxpD6y4bP9X?=
 =?us-ascii?Q?nVqnSBj587CLKsxrBeFrdAuyfj2kIWjmql+vxXxWFGFKHgxYYGdM1QeuyeZF?=
 =?us-ascii?Q?/IQ0a0BreiqYfL8a8a8X5XSP9A5mA7xYsBmLH96AcG0jz8bIsB4LuAYRavDe?=
 =?us-ascii?Q?uV/S/3oK8CE1FOIWPU55KMAZvhzG5Ki0MZ/d1QOTTlZO8x4uq3+QbKcI2Gtm?=
 =?us-ascii?Q?lijwC91IOdmQ2iPvRfvHCgD7EZsH5ntbwea23AlFjLfSWrEDuvYAqbI+X7ex?=
 =?us-ascii?Q?n+r/EQheN9J1zD5xluzaPBQr6izsTLZN7uOqzCEkII43lNI6UqiSSB6ZmPK4?=
 =?us-ascii?Q?/X6eDT31nkm/IEeVm3kbG6c5kJx7vWGGwBszCgZzETv8D1tkkkq67ksTRCGi?=
 =?us-ascii?Q?nXBNs1W1r6JXRkk4IRFt6vlssIaynSm0MshGwUn8EZ8G3KJUVeIhzYOSJ9+e?=
 =?us-ascii?Q?SFutPXiQRMinU6ZpGT4iQMvXxOr0cFkAPUVj0yzRuLKfVbaCAZbr9qgDEo6L?=
 =?us-ascii?Q?go/XXQ18VfacNKuUCln0HImRGEs7d7FBuSjKbzThfmigtaYElagEW2cBfvGZ?=
 =?us-ascii?Q?J2k2SqYru9/ETQiw6Dg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 16:52:25.6489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fccdd61-5a2a-4a11-4b99-08de4c7acdee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
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

In some cases application does not need to receive entire packet
from port hardware.
If application could receive required Rx data only and safely discard
the rest of Rx packet data, that could improve port performance by
reducing PCI bandwidth and application memory consumption.

Selective Rx data allows application to receive
only pre-configured packet segments and discard the rest.
For example:
- Deliver the first N bytes only.
- Deliver the last N bytes only.
- Deliver N1 bytes from offest Off1 and N2 bytes from offset Off2.

Selective Rx data is implemented on-top of the existing Rx
BUFFER_SPLIT functionality:
- The rte_eth_rxseg_split will use the NULL mempool for data segments
that should be discarded.
- PMD will not create MBUF segments if no data was read.

For example: Deliver Ethernet header only

Rx queue segments configuration:
struct rte_eth_rxseg_split split[2] = {
    {
        .mp = <some mempool>,
        .length = sizeof(struct rte_ether_hdr)
    },
    {
        .mp = NULL, /* discard data */
        .length = <MTU>
    }
};

Received MBUF configuration:
mbuf[0].pkt_len = <original packet length>;
mbuf[0].data_len = sizeof(struct rte_ether_hdr);
mbuf[0].next = NULL; /* The next segment did not deliver data */

A PMD activates the selective Rx data capability by setting the
rte_eth_rxseg_capa.selective_read bit.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 lib/ethdev/rte_ethdev.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a66c2abbdb..bc456bb6d7 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1121,7 +1121,11 @@ struct rte_eth_txmode {
  *   The rest will be put into the last valid pool.
  */
 struct rte_eth_rxseg_split {
-	struct rte_mempool *mp; /**< Memory pool to allocate segment from. */
+	/**
+	 * Memory pool to allocate segment from.
+	 * NULL means skipped segment in selective Rx data. @see selective_read.
+	 */
+	struct rte_mempool *mp;
 	uint16_t length; /**< Segment data length, configures split point. */
 	uint16_t offset; /**< Data offset from beginning of mbuf data buffer. */
 	/**
@@ -1757,6 +1761,7 @@ struct rte_eth_rxseg_capa {
 	__extension__
 	uint32_t multi_pools:1; /**< Supports receiving to multiple pools.*/
 	uint32_t offset_allowed:1; /**< Supports buffer offsets. */
+	uint32_t selective_read:1; /**< Supports selective read. */
 	uint32_t offset_align_log2:4; /**< Required offset alignment. */
 	uint16_t max_nseg; /**< Maximum amount of segments to split. */
 	uint16_t reserved; /**< Reserved field. */
-- 
2.51.0

