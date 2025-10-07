Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B1BCCD185
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 15:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB579402DD;
	Tue,  7 Oct 2025 17:06:50 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 13B4B402D1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 17:06:45 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021084.outbound.protection.outlook.com [52.101.65.84])
 by mx-outbound41-139.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 07 Oct 2025 15:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBTzMHx0IGF5A3KRB5DWawM38dzZYK6CMU3RDpf/szWQaH98jku9wjfpuVCO/w0LZWpJvrYKA/fxbbUbx2IUbpivNL884EcA8wvhK+C/s2UgX6fcmlyWu+NgienI5GMW3wzsVznOvbXOewq4Pvp+NeH5p6oX1eTKKVu9ODEUYNl+vZaId317Z6aPlGBeONS36qGNa2vlftCOUUEMJj8+8oCzDaYS7AtomUc5pPJhKnHS050rzBlpvS5+2M3/7t8sIhe0vV7YddBOliG0xIQON/azgX6sqsM7p7/KVbp+PyyCvo9sKJfZnwq+EE2Go07IhV8WNwRf+qZ/iIEDONDmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRa94N9tKwhEL7/0M1MWf/a9Rmh/me4xQeYOWiiVAHo=;
 b=ofpLiOPHtBKQEtKVFP4/xAHW3SAtBJlUxp6gqM/Zfbd20mnU0puQV09yojIopwrxWlE08M3bXP4kOAbO6QBLcQVAeWFhJyv5FeNI8Xgn1IEpxyJC0z+jNx4dWsf7eY5diyaS/rhzTbMRxPVfozAz0ByBy0qGIrdFA5kaIfP1YHJebhym8HlrgnF3YSdwQD+Jdy50zPypEiFGuoEWoCtDx+pxajMgLEnQqXAC4tOE21B0qDAfY/yPJiOtV+6GNyxQXlG/1ko9BZrLSzwy3qC9445+kxH8fQMxuEwKpOGNXnG6bk1z+uQZuWR0sCeNFDzsDMvUS+ZRNzx4srwKQVKlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRa94N9tKwhEL7/0M1MWf/a9Rmh/me4xQeYOWiiVAHo=;
 b=YEuH5B386PJ4T9wyrinvqrCSBgHLemopY9ukGRbB6M3zyIEYtsHOLTY/BqYssp0JaqihsYmF4Z0syvSCh0bREESq7adTLsm/nqAIqlVgxUC7uKD5OapNX+O4jI3pr6SrJAjpf6/kgmDGb2+mE3yYfIvKDibGV5BQHRqMRoxu7JQ=
Received: from AM8P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::18)
 by VI0P190MB2358.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Tue, 7 Oct
 2025 15:06:34 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::1b) by AM8P189CA0013.outlook.office365.com
 (2603:10a6:20b:218::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 15:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server id 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 15:06:32
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 maxime.coquelin@redhat.com, Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2] vhost: always lock all QPs if handlers request it
Date: Tue,  7 Oct 2025 17:06:30 +0200
Message-ID: <20251007150630.2895365-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007145617.2888818-1-sil-plv@napatech.com>
References: <20251007145617.2888818-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|VI0P190MB2358:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 58dbc83d-95e0-4e50-9feb-08de05b319f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cslkC2Myy9a5BxBE92szU1u6M7+B5A1LiU2DHNLlknKX/494CSboDvX7RTZO?=
 =?us-ascii?Q?4YlS/Z9QtXnmjPe2GRilmJQQ4SLJvsjAmaa1mN0QN1UBlvTwdYcuFayvucwp?=
 =?us-ascii?Q?FhOfgq+vkNgIqM4KB+zfnlz9QxDdyGhGIjK+TDY+mhDR8uMPqkOMUnB/5ttd?=
 =?us-ascii?Q?0Lq5uPS211mj4Usj1KlDcY4gYXnLt1SHjFYbqCBH3MHs8NTgf/xuwhKGKMa6?=
 =?us-ascii?Q?DB8WvbELinrrtB/qth07gHhp4V5reb/q1dxc6Slvett7pMvta/ebiEEuToKs?=
 =?us-ascii?Q?LQSqDIXNRLi7p8Nj7OOK1V3b5s/hwC7SnxiKAgxAF0xVX9yl+nagLXPw9W+U?=
 =?us-ascii?Q?DR1Y64yS1sqH5EhRM063vKdrmK3m4YLvoaY4pFxqOYUfgc33kzPzcnwcg5qd?=
 =?us-ascii?Q?rYlJdzGoxZLAEh2VoS+KqtXSc0+CE26zgxhFZhaYBLyprQuwdNmaUhFVXXRN?=
 =?us-ascii?Q?A2PkoVUtvnllelLatLBDWPkeE+0dIjuvNYJim4sTPgq5+JqcELQtJ+nPUim/?=
 =?us-ascii?Q?/e3H72PcL/9QfkLJJ8rbRMgAvyNuxb3Or3HOxEuXQ7fG0/5uWsQXFPKBM6KA?=
 =?us-ascii?Q?DsPtCHClkzKNa5/ThktjLs0DW7KPBMWSwZy27XBN6ZVILDGcTt4OmMrnFHDM?=
 =?us-ascii?Q?Wa5VuHBkgqqDw1Dal1yjnwjvUYdYAXu4+g/j/RGfdQNtYOty1xXB5dWWFOCC?=
 =?us-ascii?Q?eDecohHvj6vdhYZpuUTaRAJbz/I293EBzWZ2GbKkScT0PH0vVKcpkXi/oPoo?=
 =?us-ascii?Q?bxL2IhzYeInuRjEh4ZSX6PQOt4tf1RXER5Xw9ErzVM6tu/rVJrwJje2jrTRG?=
 =?us-ascii?Q?hh7dOMTzz85r9LrWrOp7aIDQ8V1mLOLjfxibakQL+ZlgzB3Sy0klRw+c6DRa?=
 =?us-ascii?Q?FQIdBX1a5a2hc0dmMp8J+2mhHerZv4ynhOmHFrQQvvXSV3xWszTBX3HJIVHG?=
 =?us-ascii?Q?74s5wGLY2rSVJKlkZb2PDbO/3f0jvIFpBVy8hqUHbb3gjNKyZfaGGuTu0i8c?=
 =?us-ascii?Q?eShUN7f7Iu2y+KHHeZoLp6ACKFQJSXD93RTCbY4zUzJoVKStemW1OS0SKatO?=
 =?us-ascii?Q?2+FyMFW2JKj+llHh2MEfE8mPxalTyKLwHU/hzBylq62E+y5Zo2Jn8rsLvRmI?=
 =?us-ascii?Q?LNaZWEwiu+/Tb5VXq9cJo5/6yR/LL3jthGLtVZmm549KOQlgkbwPulZz1E4a?=
 =?us-ascii?Q?4bXue6dGYJIFu7YHeCcQKZxS9h6VAbPl0fU1qkfnURilCM81XPX94bpxTFWX?=
 =?us-ascii?Q?Ddu1QhXXRQCiaa5C38vMZlvTvg142phMNVgVLIRggdmVTH0MttRVrfO4Ze27?=
 =?us-ascii?Q?NZQgyqMvdg6pZx3T2iH9SNJq5qb+ajDoDwvb7F+cPaHfXsPLEf6cAivNnDlr?=
 =?us-ascii?Q?Dt9oH0DnkPrx3zz1tbYr8/7gGNv/g5Vm9k7cqX4JhDf6gYz5WB3JJ68pyb/8?=
 =?us-ascii?Q?tmSz+nEh/WTcTyLl0Dm3rfRnQkFM0tES2c/Wx8xA8XzVfc4Tq6y8ST+wj6V4?=
 =?us-ascii?Q?37PXFhoSTW42BZQbByzC8W65BvTeQBYl28mBhSvlUZyZE6rUSeTQQiNYsKak?=
 =?us-ascii?Q?ZpxjRFVML/Y6XalSEdM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EbeNyc7lHChdqqvmYPqmO/WU8Tcf2UXpAkfApdwPvCrwOEujhYZaBjOoIJ/C+5iJW5hrlT+FaLuNvcdXgXi7eaK1Aot0EE1/Z05aFaHDLik7vaJy6ynUpcvOh2EVh2vtJ74U+/eI9sAkVSxG2AthJ4816OPVd6SbhidsJp5imw6LOYSxyOmcy6nWe6duMK0hDh4osSPhxxthxPaxsEKn/GBrGZXmy1R+xUSEV5wdMjyHhXBNGO23/nq2rfSD+3eDNTqPhyshsVu+6pWBw40zUD4a9mnvlAJ1XI0rxfhr/DCeSXci5I3C592Er/nq5e4ZqSKWbAmNGmpEKx9TG4STt239FmV9XPdiQvPQ3ZR6oU1TwBgaZxjC+0WoBJgWAKW6XgNfuCBKkRDysR3IB+iYIDWn2FcoQaQkTno8EAbdwlVERfaZNRWfCgwp/wytqsrTRIYbdGSBxiddA8d1tNfOklrZPzFqrLk4on88gik+LKknS51UszfXqxzKSZyGu/0XPuPU8WitkHJfho6VdiH+TfOd2r2nJT8m2KiNtaj4lY0x9hzYQlg6qU3OkiSQ+ShU5nFF2Er0sZ2hFYQ+lkLbl8XtIISO8X8W0rG2ySkffma+7AkYgUOTrDruLGPPcegNjvfLp6UVDj8An91gkJpGXw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:06:32.4851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dbc83d-95e0-4e50-9feb-08de05b319f6
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2358
X-BESS-ID: 1759849600-310635-7600-4337-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.65.84
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGFgZAVgZQ0NLYNNUoJTkpMc
 3CwAzESDNINDI1MLdMszRJSUlKU6qNBQBmgwwiQQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268036 [from 
 cloudscan12-200.eu-central-1a.ess.aws.cudaops.com]
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

The check for the VIRTIO_DEV_VDPA_CONFIGURED flag is not needed
since each handler has its own lock_all_qps flag
to indicate whether it needs all queue pairs.

Checking the VIRTIO_DEV_VDPA_CONFIGURED flag caused certain handlers
(for example, SET_MEM_TABLE for memory hot plug) to run without holding
the per-vq access_lock and trigger vq_assert_lock failures.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
v2
* fix typo in commit message
---
 lib/vhost/vhost_user.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..9288da9322 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3171,10 +3171,8 @@ vhost_user_msg_handler(int vid, int fd)
 	 * would cause a dead lock.
 	 */
 	if (msg_handler != NULL && msg_handler->lock_all_qps) {
-		if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
-			vhost_user_lock_all_queue_pairs(dev);
-			unlock_required = 1;
-		}
+		vhost_user_lock_all_queue_pairs(dev);
+		unlock_required = 1;
 	}
 
 	handled = false;
-- 
2.47.3

