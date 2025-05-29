Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A19C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DFBE42789;
	Thu, 29 May 2025 14:32:58 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 163534021F
 for <dev@dpdk.org>; Thu, 29 May 2025 14:32:51 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2105.outbound.protection.outlook.com [40.107.21.105]) by
 mx-outbound45-249.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 29 May 2025 12:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA56/zqgYAv57VKYdpU3/sHLV498jvx2olcHcIEnpY7bJSZWMaKGMwlKgtxVB42rKN7RYKxFD1D/7MLUzpYJrTqgr4FHLg35PIf9rKXTUcAC/tR/7qojDuesSObDYRICC5OmJriy5ulHcCcIyGUklbxfHyUDmTw5HN3We9gMQPbPE3MyLEvwyhlODCHJXfh36osVsQnrYWkq5PVif0m5sB6ff+LPNDxcxaoyam/lWV/kuFJ9SZY17l85KB/mhfW6ANnxzpIHwRKhRbmtiUtzqTwL9PJI+DH906xuBFU2yuUFkbJWDnkDaU6eQ3OtQWyva0D+xseyFrtcVJfaqtLRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8wOghxBRELwvIrc/olDgzHJw2qPdQOOyeqMfmOqn7U=;
 b=QkUabyGu2ShxrBAwIR6+zJY0j9luMa256XgTEePwnkH7B1kgBGEgUUMMf2g7yK4O6DI43o3ALY4Y5ikcHGzvZ3AWc6fuxiPL7TGjPgwMPN7O7HEw5IATnWEglJXY4+InhG2ayKlmLQoxNu5X4BqBeyqQq/BX4yv3HJIYQaARkZzu1LJNxKjO6HnbiYLWJ62DI5mns6UlT2d+gtIjdtsRESPp3lZphOXD+9FfibQ+3IK+lCTT2Hab4CkT3VKIE6IOodcrbT3rtOBnrrubWbDp+6ghx3xkqgi7HHcvyN4i7qQurCWlf64VdeDTdWJPthFqc36Avc2VkiJO6mMaDWEb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8wOghxBRELwvIrc/olDgzHJw2qPdQOOyeqMfmOqn7U=;
 b=Bo+2HKktfkCkjOb71BJd/EPaSr0qBsdQiR7ZIp61Qx8nawSLIZb+AxYkeFFSZtkVbLOx5xTve4B1rK5nWGPA3RqJH6yk5JNnjDWVJfVsR0rVcoA2mImURoGSUf8H8aO286VTRlhb9XMwgzwDCb59Dikemx12C2+Uwgnfwv4v7FU=
Received: from DU7P251CA0020.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::22)
 by VE1P190MB0992.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 12:32:37 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::78) by DU7P251CA0020.outlook.office365.com
 (2603:10a6:10:551::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Thu,
 29 May 2025 12:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server id 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025
 12:32:34 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org, dev@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v1 1/1] vhost: handle virtqueue locking for memory hotplug
Date: Thu, 29 May 2025 14:32:26 +0200
Message-ID: <20250529123226.1875075-2-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250529123226.1875075-1-dvo-plv@napatech.com>
References: <20250529123226.1875075-1-dvo-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|VE1P190MB0992:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3cb08e9d-58c7-4819-9306-08dd9eace3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4gTMy8neEu3vhzn+jOK81p4/qH8fL+OaQ5HEieJ8irQICGz+Bv9hiEMr6rtC?=
 =?us-ascii?Q?J7rgXUHvpGYiDvOLihCqwHaAghEdjLINkdCt396GwFl7vB/nPbhG8bYSYxDT?=
 =?us-ascii?Q?x19FAc6aPPrvHcA5mwpOcTqqomFIS9zH3RP+DTuql763snUgdNkRX5qZQYi6?=
 =?us-ascii?Q?M+f+HYnRlaNWP4OzQQ6uc4uzAJm4nGzMeDu5IOMsighjI/i62GeFSErm1HIr?=
 =?us-ascii?Q?Ma+cCnmsSgsWlGIMlsTWoOl4QEDXnyXpvLABRt7xY1z0hvZsrBxaOZyegXwQ?=
 =?us-ascii?Q?NIE9zodqcgpGd5ArJOjOcegIlWRqVUtzWW43ZB82bHJKH0OEzGquZ/raQ4+w?=
 =?us-ascii?Q?c3UwsiouMRIB2mDubsxelM9cQ3t3XY1KNgLFThpEGGoC8S6kJxqNux6B0JQf?=
 =?us-ascii?Q?HU9KYqakCHm2CYKn/GEoAOmQkOEZhUM+K/v8oPzSbOqPi+iKXlelfVBRyJtA?=
 =?us-ascii?Q?GkJmu2haAk5Hi4mtjj4sSqPpknvvoyZdvq3pjV/wC6q9t+rRaNB9+bz3lCVS?=
 =?us-ascii?Q?yFc0JGqr7eVXFT4UdeYQ44X8gylOUUn5BO10mLvtkP2k0+48lgBygUqccCWr?=
 =?us-ascii?Q?0JR8DWrqtk/EYA3EF8E78zT5I7FtwwGc+m+BuY7Sq+eEXUar8/ixv9wLUgi1?=
 =?us-ascii?Q?c8jyLXrZ3brlms7EQADpKWwOTE7p7kwsSuC45X+rZdaGWhaYoKS7L5AQiMh3?=
 =?us-ascii?Q?kQ00AgtI5XYOE1GvHvOb0GK6nzhBs493g8OIS0HZ7ccMCPNylpKLTdI4/u8b?=
 =?us-ascii?Q?8aekPYZ9WVkEJQ5/PrDcynlEnymg6/UC/jYEfWHK8xmOP5BH1rfIMiqCGHno?=
 =?us-ascii?Q?tyXpfjKJcdGNEgcfLgnCqtw0/coxpWvWnzO6Pd1ms9mH8yHQchGps8bXAhkh?=
 =?us-ascii?Q?2m7zqsGGSrhC56SaKM70kaGFUmjjXxfqNqO3Byz5VM/w05vL1trhWRzBfMfB?=
 =?us-ascii?Q?vwlmQrdExqfwzRKGY+FFz7R0nOX2aIbdniAfR+czl9RyV4P5BtNOYakLLEXL?=
 =?us-ascii?Q?ZUO7UhVw5p+jNmdvWOKfUIhKy1q+E6JB9MhYezwKH4/M9pAWPkPxe5iSYraV?=
 =?us-ascii?Q?5nrNvyvI4Vbua/pwCndOeCtGr72ESjwitipel2havNcxLvlrwlh3vffROUNL?=
 =?us-ascii?Q?sIYvwDGL/ZzTuXq/zJeRagIOnTHwvKZahSk73tk/wqgWKcYwe4U4wGD8gV0W?=
 =?us-ascii?Q?nG3KbpQa8lxNmDAgVQgj0k84os83kMbZkEuQAaVtHwO+MteITFcNIu4Hep0e?=
 =?us-ascii?Q?rBWv2KfJSGa+Wyq0rRIKagazWieHg8krzXWyB67wwnf+ZVYLGg1GTU7xsWR4?=
 =?us-ascii?Q?BsOqmxUhwLNgbrse2+GVJ4W2109/N2pc9HWExKPgdkIkwzbbsJWoLi7JMHPq?=
 =?us-ascii?Q?0vCUvtFPo7/OQDVCZhGTbDPpIWKuoi+XAGRCv7Po00E82cmn4VCRKiIF9ZCN?=
 =?us-ascii?Q?3HhFFMluYRUpkTWR86n8e690pyEy++jUJoLguV9OmeWmiXe/JO6GoG8XhUMF?=
 =?us-ascii?Q?LPQoRi4QlmYCjziePNtNcX0x+QlLdcRH0H1wvjcSKj00V0CMpMIXlfmC3A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G62L7KqpAnhBmRuEc6eYUIeM8EjFdJAKYSmCtLdmimdaS2KFvRP8F5vswH8soxMZtED7QeLUZiBCAtPbPrXGgOPPfB2jhqTtxUbXc+WnKwmAxrGQvo1909IalI6cVSDxqpzv6mxTSTfYPpW+z+H7CC8OlLXiiBsR9mLrAoQiOKGIMpAR8mouDPymjeBwx5+qUVu4AqCuuEzP4YlF0FK/YzED/P7rI3MsInEjfyBcXElCvAsOJ6v+lSX2uk0LlBO7j9GpDYyF4K3b4U1qkVuuM8HdcVqPtNoo3YQda4u452nsh8W0f54Sv3sifHFGkJPwS6Q5T2cMvSaRbbUDPQ/vPtnIB1CJdvZp8bnTCjlkIQDBfnzb0rqAkibNT2bpW/X7Pc9H7KM7Re88X/m3uazYBLLsgokXaudf7CDzsfRg2i/6osmv5yYmvGzPRDE2Vl8G3iHXbjDvasr8GM9vzxrRiRH+rMRexbZjwNrEUd73clOt3AshLlQUAZ3c4cjuWO3Yx171S1yOciZdGsv3Q9UG+GVHMBtWxP8tNi7aVpZSAdB3fgXnaeIXTEXdtE5umuHtOK+E650e/bcLdLymW87DH5z79nzZC/Mdc89uSws6KhFSxccTfcr1FdPJJdTNa1WajghA+VCu8IxZRcPwswQTIFydYHhShUCcrTUneESU5Z4=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:32:34.6764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb08e9d-58c7-4819-9306-08dd9eace3d1
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0992
X-BESS-ID: 1748521960-311769-7760-13981-2
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.21.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGJhZAVgZQ0MgiLS3VIMXMMN
 XAINkwxcI8yTAxzSI5NSXJyMDMLNlEqTYWAPcx3jxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264948 [from 
 cloudscan20-255.eu-central-1b.ess.aws.cudaops.com]
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

For vDPA devices, virtqueues are not locked once the device has been
configured.
In the commit 5e8fcc60b59d
("vhost: enhance virtqueue access lock asserts"),
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
2.43.5

