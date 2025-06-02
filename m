Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7050CC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71A684025E;
	Mon,  2 Jun 2025 10:43:03 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 667374025A
 for <dev@dpdk.org>; Mon,  2 Jun 2025 10:42:50 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2099.outbound.protection.outlook.com [40.107.241.99]) by
 mx-outbound10-159.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 02 Jun 2025 08:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qumi9Wo/B8Ul352Ikf8LLa7dLn1bjt6DN4bL5OOp3JsXQm+tNv5l4ppBDx2XAaIPiXRJLV0XZVGzgj64/xCli1k3enxJMhM2QvzUviMTw/RUwWmomxlmtWITKUIXc1noEaAuPbxhkYLMZpEsv0UPzXxk0G+QtGVW37CrzZtz0Av04XEbf3ThFlbzt7tWcMH80JAj39a+dhQ2fEDzOWCxqM8ONcaPsJoE1e1UGsnUPjXuQjcz1+axVUjjqAJorV5a2jPmrZaWjEU1/KTFS11YypJxB0rFHFdT8qd0DlevKZCSzWSKMZOQQQiKbPCuLE2kinm9Ma/edQKp0VTEu4LJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRyLG8IbDAhfi/B/VONYfApi52rZqfRJ5w2YgQigrJs=;
 b=mEv5yJTPripfD6o/gsvh+9aMQq2iWC6O3B/wU3l1CInUAn1xsEpzHkV3rsxVS8EAjuRn5Dvxu9Sn4kvVasOy+oxRTk7xItqrsnEEecgvBGatCpUBGiOluTvK7gyecOvL68jTkeNbjSlD0xxJpbKyd5ulVaK2czPlXLL/yWhzVctQmfk6FzLy3ZrjteF8rBKboF3k9Q3/ggaXkpvB3ZVjyCwHvH6FI8n/V92LdEqPy0VZ1N0zV98x/4ihFoudn8x7dCtqdCttA7V064nkSSUVdgOwsFsro4NiWJtkSSqmv2WvCeNcleJ46B7RY6yev6qfdcLjEQjgyWb1bdwiIW4r2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRyLG8IbDAhfi/B/VONYfApi52rZqfRJ5w2YgQigrJs=;
 b=FaC6jOZeOUOLL5nALpW3/zcGSz8+rKvDCFelZIq7UieHdyeRkzTgs1lSyrSU0CaQtaVjcoYHJ1AYwadTQEY9bO8cKJjjFeVfkkLoNXg+JdYExSvnCMBDlWMmeGqHxDZcehW/eeeLHefgyFctACL1Z/D6iHTg2x1qq011uD/shnQ=
Received: from DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) by DB8P190MB0779.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:123::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 08:40:33 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::28) by DUZPR01CA0351.outlook.office365.com
 (2603:10a6:10:4b8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29 via Frontend Transport; Mon,
 2 Jun 2025 08:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 08:40:32
 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org, dev@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 1/1] vhost: handle virtqueue locking for memory hotplug
Date: Mon,  2 Jun 2025 10:40:25 +0200
Message-ID: <20250602084025.1881768-2-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250602084025.1881768-1-dvo-plv@napatech.com>
References: <20250602081933.1881050-1-dvo-plv@napatech.com>
 <20250602084025.1881768-1-dvo-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|DB8P190MB0779:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 627b103e-1730-4bea-5fd8-08dda1b12360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZRFbGHoR0/VqBqK6O18Hcuit0OMQdG+5EIjmRND62o7Mo39O8tVqXqog4u5a?=
 =?us-ascii?Q?qY1J8tjbqmn5JtAMJRcbL3Q1ZLYDyWcXk/YDWtNiiRM3fJ4dFE/Z4LWcXLEd?=
 =?us-ascii?Q?RU50nTQkdx96UlmUJvGCU4p1RkONQQo+HplxFOtmy346E/keJPBr+jIQU/o0?=
 =?us-ascii?Q?/SoaLH8Nu+pcpmcDhnIk3ZjBzQKW0r8yKObZLaXDvmj43Vu/vBgai0BbzD5l?=
 =?us-ascii?Q?BElhAHqvOUxQuwFMIjyjkBKBXc4ZIUTmckWfSLUmIRkR/S+FnJsuRI6fWiDD?=
 =?us-ascii?Q?qeo3VrmsgBsgsnH14LRITOLzvRkSTtdtdHDwfe01fnHmcb+whWYfPpPLWDxO?=
 =?us-ascii?Q?V/JX4qzh0FU2JhIpGl4iPwEGxis91gcHYFjGXfMFGJu0Zt+2fODCqOjDzCag?=
 =?us-ascii?Q?PLFan3zJ2+y4VzhvKzW0eyTnE1geyyQQ6g9AxnxoO4q7a8GSLVymoCL6kLDD?=
 =?us-ascii?Q?FBdGpXEb2v5eV40Xzbib2WZ+qMNU48cUTSzNHk9hNrySR7+CiKkkXp73tRWZ?=
 =?us-ascii?Q?wjS592xUaELDYdYOCFr8MnKO/vh3YvG7m5fIJ3hcY2X9SnyLxcIaZlUKxNnY?=
 =?us-ascii?Q?nqv2VCKaIdQf1Y7I8/tS8tp6QLKfGrZnxpsvU3uPtKwVCKIjyc0PCW7n7/W6?=
 =?us-ascii?Q?TJugTQqAt4P5UIvhUZOV4EHRR1Fl9JQd7sEYI3lc102pZ5SeL11IS6a3x9FS?=
 =?us-ascii?Q?oJwjbIUbOesqbGHj8d+YiGc44j/R1kBKVkmCLKN11n36LjqzW83M86aawiMp?=
 =?us-ascii?Q?ecbuvd1R9CfFdfIRZpibMXzdPOztRH7HUlja8CBSxeUytE5bojY2enQ6VSyF?=
 =?us-ascii?Q?aEWcvEkjd2P4g0u8+S/oP80tj8zRubq8r4gCkqw+kWUJ70mGOF1n9GasyDFx?=
 =?us-ascii?Q?XChjtaNW8ZKBPSIor+r6ogPKBP3GlJxv6+gXBxOMOus7BLAteNPiYFtWoSoC?=
 =?us-ascii?Q?SE6V0KNxmmu8A8ohBqt+0XW9RhC2zpqwAeIPz9WKQbxeib5piwW680yIbayl?=
 =?us-ascii?Q?63LNnkZuwrX71wF1wrE+DU1a7wW/k/KadT6l1r2cUtua/WshGlPNGxi0cARY?=
 =?us-ascii?Q?G8DeHqCqwjLE3253Ozi5/ttnJmNA741ZlALmzod5Ph1yqblzMrqC5T5EBeNI?=
 =?us-ascii?Q?YCdciv9FXXXuDrvM9m/3IaVcJVzertH9N2ebITRaB/i8DgqH+APRQh6xguWM?=
 =?us-ascii?Q?4BZXsN7K61ZTJDXotZjClTh5N4G27Lng3/DUSZsorKQS4kTeiHvMtTOHSM9Q?=
 =?us-ascii?Q?hxSR8ews1cY4rl5/azP9lj6ita47MBQFo2MmaOPabHPfSLUcyN+yS6lpPnEu?=
 =?us-ascii?Q?5SGAhhfRdsDy+x3CxpvkBThSi++NCyihJ0jOVwjILQnAZnosg7JxuPxsW3lO?=
 =?us-ascii?Q?5LY8q1sa0fSnQFH5QTNHlREU41Nz6Q6b3B0OvkBm7iteR5BopIEnmFfRJnTb?=
 =?us-ascii?Q?dXTfaHNcscG9sg9Ag1C478uC5YesaRUWFfKVUL6Fz9/k/Ag52l2J65vgraro?=
 =?us-ascii?Q?F4s7cfs1/TRHjS+Fs+VUHTW6T2VPRPMk5LaXScE7ktpddNoFOTOFKSqIEw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y2a1iMCoS3LXlcsSF4OtsT0EJPIbwtivuvktxfSxBLF54bZ5ZmfaxkdMhAkD+RDo98jHAQkVG7rzjBBhhzq9ciUYNvMVeQMwVomo1FcmfHl4wFqvq000cnKPZuq9RyZy5xLRSpwY+OdhxzfoL07ytGHyYOckK0PYLzuthGaLPxPE53J9gIckK80JK5pqpSRLFwzqk7+sx98tQv25n6yDKHdOW5FqqnatTp9Xt/rvWRQiijPDSL0PZAbe9og6hlFw8SxHpXeoGudGeS0vcie0MbUvatXGgQj7/Lxsrm/GxmtdpSMUjc45FfZLyij8BiXPNVqzK5+jgKgjavvBnHTu0zpdR839GtIOQmk1DbO0s4cC9NBOuqdXg5ahq7Za2kf1uBhU3ElDVo9jRYBSM/R7tPx2jQSKkY05Qv4yKyvBb8clMZB+PQnB2LkNf0G48O3akjV184g3aUu4FjcrsTqhtVUs7LZFqQmSRsHsyQaIwBj0ch4vLneaHCuFcmBD7q3pMPMoJuMIe2GjudU7UEenhy2MvztII4iipyMrkJwQdSRSdDoAQh8GzVf9Zd8ybDLHROIchMMtqMRI5Yy807Pxji+jHclxxfUs8baqYziq4hmmFEOPitHEMYM7flrGYBfdBeT60q/y/VcxnvEvZmd0SA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:40:32.7822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627b103e-1730-4bea-5fd8-08dda1b12360
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0779
X-BESS-ID: 1748853728-302719-7629-2440-1
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.241.99
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGJhZAVgZQ0CIp1TLR3Ngo2c
 TcyCzRLMkyMc0wzSItxcjIIMUw1cJIqTYWAHzkyGZBAAAA
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

For vDPA devices, virtqueues are not locked once the device has been
configured. In the
commit 5e8fcc60b59d ("vhost: enhance virtqueue access lock asserts"),
the asserts were enhanced to trigger rte_panic functionality, preventing
access to virtqueues without locking. However, this change introduced
an issue where the memory hotplug mechanism, added in the commit
127f9c6f7b78 ("vhost: handle memory hotplug with vDPA devices"),
no longer works. Since it expects for all queues are locked.

During the initialization of a vDPA device, the driver sets the
VIRTIO_DEV_VDPA_CONFIGURED flag, which prevents the
vhost_user_lock_all_queue_pairs function from locking the
virtqueues. This leads to the error: the VIRTIO_DEV_VDPA_CONFIGURED
flag allows the use of the hotplug mechanism, but it fails
because the virtqueues are not locked, while it expects to be locked
for VHOST_USER_SET_MEM_TABLE in the table VHOST_MESSAGE_HANDLERS.

This patch addresses the issue by enhancing the conditional statement
to include a new condition. Specifically, when the device receives the
VHOST_USER_SET_MEM_TABLE request, the virtqueues are locked to update
the basic configurations and hotplug the guest memory.

This fix does not impact access lock when vDPA driver is configured
for other unnecessary message handlers.

Manual memory configuring with "--socket-mem" option allows to avoid
hotplug mechanism using.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 lib/vhost/vhost_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index ec950acf97..16d03e1033 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3178,7 +3178,13 @@ vhost_user_msg_handler(int vid, int fd)
 	 * would cause a dead lock.
 	 */
 	if (msg_handler != NULL && msg_handler->lock_all_qps) {
-		if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
+		/* Lock all queue pairs if the device is not configured for vDPA,
+		 * or if it is configured for vDPA but the request is VHOST_USER_SET_MEM_TABLE.
+		 * This ensures proper queue locking for memory table updates and guest
+		 * memory hotplug.
+		 */
+		if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) ||
+			request == VHOST_USER_SET_MEM_TABLE) {
 			vhost_user_lock_all_queue_pairs(dev);
 			unlock_required = 1;
 		}
-- 
2.47.1

