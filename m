Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A4C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C55454066D;
	Mon,  5 May 2025 09:14:41 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 56A8E406BB
 for <dev@dpdk.org>; Mon,  5 May 2025 09:14:40 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2110.outbound.protection.outlook.com [104.47.30.110]) by
 mx-outbound45-79.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htyOQ7r5PCN2EqGTTG1hLFoFKo+PwPQtfrPfO2+ZVbkVNv5/wLgiDnb4LfDQuMTKQAJR5w2mPihR9aW1UAO9xphrFSglOfOgJx+8KvDTAJUS6OzypcBMZpe6y1dCcQBeSZQMEbmwoxw9wmVzQZnxp2mMyrJd0G075SJ5BB9cL+TABrfN7HvqIDj8Q5QD3r148lLtX6+2cQ3AoL3vcTc3e/YRW0tMFdT0JznYfyhzLTNhRL6uNvHm3Q0tJ9EBzE2sQgelizQGS94NHD+05SRAXsRKUQ4qy1C50eDQPkvKFkos6OsRiCuH1siE6y6S3E61r+alHKHH/osAm1UnDsQKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etW9dNJfxx0MLUyRggMbhcnW8NwQrXMvzf5cg0nDbeE=;
 b=DZeamqq1X6Q1rH43yHZEVvmLmDu7ZSwPWwo69cmslXYrTp9mkwA5HnhWBGJBA0tMGblLC3LYzDaniyJ09H3n1lXBtJW67AJGzLWYmtMV7A23qNFnfbBWG9MVrfDRD687a/0V2Lt/4YN5BM3d+9qE83n7yXjh7qbtR/sCGdeGI5dLbGYBObpYGCNwQZeiWbdj/q2CB6E3UptTGeU41GK58huF/v04NPSDqr8I8VZjoxi6/Xv3CpS4oTP0BJaXxdDS6o/w2M300tPjyX+maC+RLD/D/Q5/+H32Ph7S0ZgJcjzFwclgeSW6iNMSgDOvf7Vykil7PAClE9O2utD/9EIjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etW9dNJfxx0MLUyRggMbhcnW8NwQrXMvzf5cg0nDbeE=;
 b=X2ezph8c74Q0cq+aTw6N/hKnW7mdkTclgiC5j1GXLqyDLXoszhDt75p9Ai3Qxhb5PjCy/sXWRd6UX8dpjc+L5iKr4/5M0cByDTjgicpeqWuyIjvq0Ma+itXTUjyhC1oO0W0+TZXL7uO/oD2uq/YD1OqgvQi3t4AUY6lU0R5ETrA=
Received: from DU7P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::35)
 by VE1P190MB0863.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 07:13:26 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::da) by DU7P191CA0010.outlook.office365.com
 (2603:10a6:10:54e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:26
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 20/26] net/ntnic: rework array usage
Date: Mon,  5 May 2025 09:13:00 +0200
Message-ID: <20250505071309.586015-21-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|VE1P190MB0863:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6af0c836-7db8-49d6-ec03-08dd8ba45489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHDKOkdAD0IDGtOjqxdJrCYwCIyRG4yd9gkWrMprxwgIk7xflep0bb4Kwjg5?=
 =?us-ascii?Q?REqZ+96rEF554Lbz2vM8nsYkWRj7iYkGfpKasCSwLltRPXSYVvFkSYS9YdsI?=
 =?us-ascii?Q?WhFQuKh8VEgWlrBmioTEM8AaYEZXlYQV4xLysMrxf/6658Zcj9wUt5SRvCMZ?=
 =?us-ascii?Q?wrjga4/lotRQYVY1qTVimaa6IVr4MhiHF6CIaXfW9FS6RCME10fh3PnBWf+y?=
 =?us-ascii?Q?tggqy60eM9cMDiFsb1xdCdIJIPZs7WmtLINJwdNjDoJpnbmmqet8qkvB9KZ2?=
 =?us-ascii?Q?QgZucEUJyDKT/MbxzkiWl/S4UqCrdJXAShOjyOyjp/+TJIlaXoMICCvzLM77?=
 =?us-ascii?Q?zfyYnn/PDjEMoaWQl1xmUoXQI8xJYtF4MucA00qwIw10XZqUYC3pwDNdMKtS?=
 =?us-ascii?Q?swngSBWkxaIsJ9t5jPhqjQOkeZBcDN4Oh2HOOneR7DxtvbzKiIxDS4Nx1vMD?=
 =?us-ascii?Q?CkkPvhklVd3TWz8ZKiz8LpjezofBpBX4cWq9aNuHOkeInEwAH3kA4J8fT71F?=
 =?us-ascii?Q?6ZzJ/FoRnszy720zdR9I0/gRrCvPe2XVxs7N/bV279lCRzW0OhxkVR50kiv+?=
 =?us-ascii?Q?oRpWUTrIVbPB0yMZxLJaQTywkBm+yjYUif30+elmNbZNsZaYEq1PsYrVU1zt?=
 =?us-ascii?Q?fvQWHpMHw7g6zBkjX0mQ+J1T+egTJzleKk0ENZLEDyQ+7ZTq8+u5x5AjjpoS?=
 =?us-ascii?Q?YQ7J1k+8k2riVYfzYJ/mYMKOIoXvmtj+5GeXHlbNUOygKUSyCrupOZET5QJ2?=
 =?us-ascii?Q?mIz+QIByqyodle1pfWPCHLJ8xp+FWsbgBKkkr1kVvMqD2AIjoXQubgHcPN85?=
 =?us-ascii?Q?EO/MIe5YRysVKxwuURU1yM0eurtQfYGpISsqosKkg0sdBYLVG+CnPZrzSHFK?=
 =?us-ascii?Q?ojyW6r3an9CDCR9SCGEG8Q2H/KCPBC7bEZSpMvJTMt1aHJI52i2fQLBYh94R?=
 =?us-ascii?Q?a7w4MnZUgFmDbvyTQEuJW16Z3y4Z3gvjSk+7z/TWrLgXrHF2l7GZ5/Macq6W?=
 =?us-ascii?Q?VBfQX0/tZaxeb7KqFJLT90N86BkdetWCxBSFj6gbfZQ0rgcN6MB19waDn5Ae?=
 =?us-ascii?Q?JKOgEqaQuw9NSX0asRQ99BWGyhnNFIKiWvA+/nXSt00KeGsV3LdE5C2x29Ea?=
 =?us-ascii?Q?lfeCrdHRubJj8dHL289PiAnnsMC/3SZZAtJXMdzABJDSbnYOuBEHJuydb2qh?=
 =?us-ascii?Q?G/+QitZua8/aV7l7OWntHGWJy56gf5xyj4kPCk7OpDXOJ5nAq/YcxU3w/MAN?=
 =?us-ascii?Q?bp/IaBFVwy/btyEMufFfnlGBM6TxJLCyGQvmEp2ac1GriS8oQtfyIoOtDd0n?=
 =?us-ascii?Q?uFI27TEmDvVZMD0J+PObLguqwfflSeCo+zR/F4puFY+lZpALtxwhyeB3nVd7?=
 =?us-ascii?Q?k0KpRf/7hz4bBegfwrYUEWbzSFdzipj9/vIqQC8/2lEjuBlwa+KiH/aRnXBg?=
 =?us-ascii?Q?xSM0Ot1iZdIIcI1f6nDwHr6eg5GTPW7wT0qJbrDJbU7QbJtUBfbrqKapbx8B?=
 =?us-ascii?Q?BO8TcIMVn8ZyoVIvdeg05Q9HPdKtL2oAFLTT?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SCYj+94WSP7sIoC0PIY+/8cZRgJfKmlDgSltXuMkV8OEgAtFIKtMAM0nJSEydjyY5K0obEkrfsjfjmZRCpZ4NeWefoQm2PErFLoDN7bblqhpn4YgiTpdUIyeNmgTq4HG2/MXqvoGKFv1GUWaWJbTYqiouuUMPZC2aY1LulR3o0baSo+Eur2LREAFtbBHwaxoePkGGV/OenbJjYUYAwOCcQJpeoNKD8SVBHQktgPdLw7LwRK7ItRETTTmiMtk87r3V606x/8JnwXHVjauCaVwXVgu3pDwGe/UfA4HYJSMqLPkygaf+qN6tpac6qQ/X2+Q2J1r+lWQiJUwHHkcx9jTPwFXqixeycx2OTPpv1F2RWP73ok4nUhnveQDJWCJKBM+x3/QZkEe2kj+MPMZesfWz0J0b1H459yIQDzzLoOQb01f/EOqm0zrVlqFmy9ATm5s+U+equ/miOoA3V9pumtP5kK2Gb0pQBzLFbBtC0+ehlGx/OkpfIEZqLcGQQa8GzEnMqpWpUaME+YIT7uwZ6N7mG46FRfbP0bETvN1pYIhfF5ZqZ3ch2gA9pIaXByhaJS9oWtuLpvHfbpmLY9d9K0s7AY9NFLQ6EfFN6kt5b+aU9exth5+HrqoVC9sm8H9Q0mabyQc6AgRKxNdgT3fymD1Pg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:26.3764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af0c836-7db8-49d6-ec03-08dd8ba45489
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0863
X-BESS-ID: 1746429209-311599-7747-358-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.30.110
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGZqZAVgZQ0MAsJdUo2TDJON
 HEEMQwMTEzTrawMDdPsrRIMkkyUKqNBQCSyK0cQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan23-84.eu-central-1b.ess.aws.cudaops.com]
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

Array usage made more explicitly, avoid pointer arithmetic.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c   | 8 ++++----
 drivers/net/ntnic/ntnic_ethdev.c                          | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 6d1d01d265..75a7504510 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -908,10 +908,10 @@ static void *_common_ptp_nim_state_machine(void *data)
 				RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
 				NT_LOG(DBG, NTNIC,
 					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
-					drv->mp_port_id_str[i], nim_ctx->nim_id,
-					nthw_nim_id_to_text(nim_ctx->nim_id),
-					(unsigned int)new_state.br, nim_ctx->vendor_name,
-					nim_ctx->prod_no, nim_ctx->serial_no);
+					drv->mp_port_id_str[i], nim_ctx[i].nim_id,
+					nthw_nim_id_to_text(nim_ctx[i].nim_id),
+					(unsigned int)new_state.br, nim_ctx[i].vendor_name,
+					nim_ctx[i].prod_no, nim_ctx[i].serial_no);
 				link_state[i].lh_nim_absent = false;
 				NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
 					drv->mp_port_id_str[i]);
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d9088db4c0..fa43067adf 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -379,7 +379,7 @@ static __rte_always_inline int copy_virtqueue_to_mbuf(struct rte_mbuf *mbuf,
 	 * 1. virtqueue packets may be segmented
 	 * 2. the mbuf size may be too small and may need to be segmented
 	 */
-	char *data = (char *)hw_recv->addr + SG_HDR_SIZE;
+	char *data = (char *)hw_recv[src_pkt].addr + SG_HDR_SIZE;
 	char *dst = (char *)mbuf->buf_addr + RTE_PKTMBUF_HEADROOM;
 
 	/* set packet length */
-- 
2.47.1

