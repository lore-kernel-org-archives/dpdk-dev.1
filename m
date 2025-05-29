Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F862C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:31:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 272E942709;
	Thu, 29 May 2025 14:31:50 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id A37054021F
 for <dev@dpdk.org>; Thu, 29 May 2025 14:31:39 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2099.outbound.protection.outlook.com [40.107.241.99]) by
 mx-outbound20-107.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 29 May 2025 12:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svwC6NuRKn2Ra2MdnHNdxYGP5ZtovEnMoSGBCRSUStyFVfAyWE5MAgcj+ix6KEo+4Hr42XvL+jowJtW3wfb5a8Ak9RW9dtr0GPMniubiG00an/K7jCzFpLf7zfJBBYvH+FE4+iEwjpPdMl4isAQTavRpcmHTSJD/YXl4xlUZHl2MCtE4m3whNm7sfZUNqu5+H9jYqdY3lObahxjK8dVJHumTJ2+VQGVKRF3es4o4SEOWdJod58XeUQylcUtpKaPycx9NpK9eUaKPBfwygh46KvhjFCrCBMmbi+eZb6gsejT/IPzOAGomTHEAV5gqKDn8PDXrmvYD8TQT+pJiLtbLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8wOghxBRELwvIrc/olDgzHJw2qPdQOOyeqMfmOqn7U=;
 b=RT9Vr5ditX4q6yzD4buFk78nyzp5f0viu7MEzMx41GqCG7GtjC1SFZfb3iYVnzF+yfMyYfMgLxveK9jwgjMk8vnkwpbFBf1kbr+aQ7ndd+hzlhsFUb85sMJefg9U35tSJO10PgGa8Zrzl5SyFeZoZwCMKIIKprXWkw38i1EzavKsiwGSpOdae3yTuLcd7VqiSdy8aG/pnfla0pjzd/q3KC4P/ia1/HakjYnCgUGoQx0KNq5yWrvdxelgGrNjqboP9r5QHG3rpAQdCD0sx3fWEMfbVimdInzWDVU2JoCxn/9VBh+zea40DZr68P/oyq5zzpCa/dnQlSnphFB7OZAWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8wOghxBRELwvIrc/olDgzHJw2qPdQOOyeqMfmOqn7U=;
 b=ZIcP3q19djgOy0kpFtFBkpauKIIBENpMdmPdmUmThpeaLp5wBdnABrDLolJihhN+5SAMtyKbM5+E0WLQrzMvoqcxoc3Hr2xEsITDklmVnkaUSTALQiKJEXf7/LArgVMiikZoZzWUZ5Rn6o5ICJ1/61+S/F6pOW1W2+g89aOs+m4=
Received: from AS4P195CA0040.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::28)
 by VI1P190MB0688.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 29 May
 2025 12:31:15 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::7c) by AS4P195CA0040.outlook.office365.com
 (2603:10a6:20b:65a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.21 via Frontend Transport; Thu,
 29 May 2025 12:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server id 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025
 12:31:14 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org, dev@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v1 1/1] vhost: handle virtqueue locking for memory hotplug
Date: Thu, 29 May 2025 14:31:02 +0200
Message-ID: <20250529123102.1875027-2-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250529123102.1875027-1-dvo-plv@napatech.com>
References: <20250529123102.1875027-1-dvo-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|VI1P190MB0688:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e490e3f8-c6b9-4a9d-6933-08dd9eacb41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/XPi00hxL2d4bD9IQPonUC6tfsw4wHcmf0eeAY3NzBzXBplpB55xBORpGvuk?=
 =?us-ascii?Q?gB1R6V0VOwE/KAiJQ6S0TYZ/KETH36X/L1VumcS8tE7yiz+WkPqhWc0ljA2f?=
 =?us-ascii?Q?aC0oOG/VeJwLNfHOUPGmZLH6D5U6+oZ+nm6Jpb1A2MS3pyhwxkidBX87mWAN?=
 =?us-ascii?Q?REq2fhiCirRjoFQKknSLZ8jrHd3eNnd3sHgoax2em5oysCdgNR8S+CsOwvUe?=
 =?us-ascii?Q?qas4kyIRII4qhCMPt4pYMhr9tx+SVp9vECzFE/LC+yFRv1SyHG+GbXBTZv4e?=
 =?us-ascii?Q?9WL8KJl5UrBAPGvjY9JfKi3k8KCA1/l/KU2FO5ZVCldqEiT55fVUX7VsbecG?=
 =?us-ascii?Q?7tRVN3v2FjeG9jwixh7PnfDNLdv9bXIANwZ85jDfLp1GCuG+/OgOITW9DOKw?=
 =?us-ascii?Q?5ZEnqMya441BPwYOhCRXYaN6YOMuck5iM85rM1VwGnvJwsQhszJPRcgZMTp1?=
 =?us-ascii?Q?G6n9rCMblaZirn4bri4fcj5oxufU16j10Fiy/Jj3NQeW0SYjVSpUFb2QTcvC?=
 =?us-ascii?Q?oF3MaxK85ovE7R2KxcAaH6Lz9XseSRHLM+BF8Rui9+venW5S6/raQuB0v3VZ?=
 =?us-ascii?Q?yHkMuSbLf6+nmdMIgAC1iYuuU4JxcOl5MRIBn6r0T/Qcc8TThpV0vm5vFylD?=
 =?us-ascii?Q?pfoHEIP/2Ob7Si5O6xk+9/7jh8qJvdrAT1sVQ6B4feRrxjcsnfnnfC8U+zzn?=
 =?us-ascii?Q?WRWI0DXTzte2TvvGp7H51GT2exIL3a3Iv6Rv7wbIVe0HI/eX4SK710wLYG8T?=
 =?us-ascii?Q?8fBF9GXbs5Wa2+RRvYvA7rgIq1jugydBqaJv14ubBdjMYkI6GpRwm7rkBe4K?=
 =?us-ascii?Q?Go3hiIOfLZPszRZvUewST/gC/AsrxfoLLX8FR5LLHzjf+LD5wKGc2tAJLIO0?=
 =?us-ascii?Q?5prUHmxPpAhjd89hXHdTK5NbXsd/4BGOxnBkgH51C6gZcONqoWLl7ukX0KkQ?=
 =?us-ascii?Q?Eq4Xn6WT6yctVYfHmZnpw2MsRnMpoeEc/Htl7If30I+ROjUemVnZlMY6/B0G?=
 =?us-ascii?Q?UE3dzZ6vwTrkp86mGyLYvgXVW5rJ5K6ruvZSfyFXjQm9EQsUQ6KznDMpwrvB?=
 =?us-ascii?Q?Uet0iWWl66OOApqbBt8B/81MNPygxxCqsyM/0f48vstHHp89WJDksRvzRv2X?=
 =?us-ascii?Q?h3V4i7fEmSvRCY1VTONSQ+SSUqAw1HMlRURFgo8tyFXbgNQfdF6oexUm3t6S?=
 =?us-ascii?Q?/gpsPqfFl/WaIo79WeReLc0Y8YPsPmG69c/kPj5zIsslQ9xw4gUFJiOM8oVo?=
 =?us-ascii?Q?Pt0Tpz87HZdJ8WyWVIjODfGAsXTo5gYoAi39+xRKjRAWZrKMCidBBHefJ9S+?=
 =?us-ascii?Q?rnWOk/a2htAp/nYQbv1f49iKuXYFYGLSQMLcf6yWVFtLRIqHkwmMdT42PhqC?=
 =?us-ascii?Q?Tfm3OvsY0BxaRb+ADTsZ5pcw8ad8xCRjteh9JTir+Zj5LmL2OFILDpNUpgMq?=
 =?us-ascii?Q?u5xk1ljpwJzYlRkv6Ke2guVNz2ugelu8kLmJX9hR2QtDSYUyGWrL+Oc6Ge9Y?=
 =?us-ascii?Q?vKGtF3GdLK1SN6skWUOT/UvLgqy1BG0XkCTkbwx4ZKmblLgM+gCLlxwoiQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ReIXj6nNIr23G6/7SjedETGNfHXmo7ftlDRkYLDojyyc/u0LUZE2oo564MTmrLyKAr5avpiUlIWzZslUwbkL42EzaO4MJaAU39GFGqwdpIEHJxNXdCsnZWACNz4e2TC7lVqA8Vk6ELsa/dcyhbDVw1C7zMRn6zsdV7JCVijKk52HBRl0t18S/LkZccdRsjATVoBiZ8afbilWvVbB3aYarRNhdj48DJXGjIrR29SoO0lyQ+J/2I7rYAqAalyxB+2bc75EHfpSjhHY2+bXbG1jlqHjpTkh1W8YYjOxUOIv8fyyCRhEf9lIzNdtu0saEV6vv6zBOD/nz2mUqAYGRG7IyzcE8Uys24sXdY6iu8XjjuLpL1aokjS/RiPEcHO66qSQT47L1sl3djYYk17Sob7aNIUQhn/rqGRRQkoFnhLEmjpHiC8SgeM8zqOgo1S45o8bAlO2cO+au+oHydK4wNZksEb0SgRNsvwDywuizkoKInuyVX4Vg4kJj7uq457OIIq98HoqGjSoNUOZN4NvORKYfZ8vRBqylTIPt6zY+xcP937U3UqqJcXIqYTcCjxDaVrgaUrQquvgOsKCWNzbBc7JvcXWSEsUr+0ApK/4zU+Hj7Qjvhy2SopTfqov/OgAO8oHtK8mJx6vaxqKTXbPJLtyhjAJEzKUGPXrA56xBRGFpTA=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:31:14.7346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e490e3f8-c6b9-4a9d-6933-08dd9eacb41a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0688
X-BESS-ID: 1748521889-305227-7656-15941-1
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.241.99
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGJhZAVgZQ0MgiLS3VIMXMMN
 XAINkwxcI8yTAxzSI5NSXJyMDMLNlEqTYWAPcx3jxBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264948 [from 
 cloudscan23-29.eu-central-1b.ess.aws.cudaops.com]
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

