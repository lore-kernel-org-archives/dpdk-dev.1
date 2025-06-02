Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5263BC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B8604025E;
	Mon,  2 Jun 2025 10:20:59 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id A174C4025A
 for <dev@dpdk.org>; Mon,  2 Jun 2025 10:20:48 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2118.outbound.protection.outlook.com [40.107.21.118]) by
 mx-outbound10-159.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 02 Jun 2025 08:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhEKOmGxi1vaeu9+406ecK31QAamxs0Vp8ANXSU8VbsMg64RRJacBn4uO27KKmmMHTWlGuDJWKvB+tE2ZqtlWWTLEMFgOSPX6ARAMTEm9whOyggAWealvtfNcTjDlns/CQN+4H33sj5A5R8IbUMVVZvIySaN7q8W9FxaCpdVPcxUrHEbw12Jcd7Mo66UkCaYNH6PSXceSwNjWvZSyEXvBQwbLwLiH6Zt0xfLysRHLJeo/6MkuHZOSgzW/YiXQFQCdiqgl2QiR+/O5fJSd6rl39YDa1Nhmsvp8qftKVN/D2xdcAoUZBOIl8IoHDAimkOrdoIplqfwOUl6GmYbfnT4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISb375JkhC3ItGWagH0lor36q3j1wbtphFd0243tBO0=;
 b=ZB22fqk0jlIoIHV1w0ibq9IOj3ZIfijC/ctNIz/x9ppsAzfwTKVX7bPIZe1lozB0HEAqLG7j0Rx3/1vQqboelJIB04x8hymc9qOUx0MHN+8MScfviabniz5h3b/7aCq4BNRGpgxovXdFhrj/nKDDUrzYJIrclTiEpqpRW6SGDl+3g0UNmQ1PSWE7r+e5CYF+RqcYToq4tUoZ9ABxtGUYUBW2pJdLMrX5IWhTdiSkQva1XCziQJCU2mNQZ3/kd6L7/aRFFtLatOAq0F/fGfQCxp3GTKUWnScKizbTRHQOdxDv7IF9I5fH+1tz65a8LXjjLz+CK60WWMHaS/jHNSxyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISb375JkhC3ItGWagH0lor36q3j1wbtphFd0243tBO0=;
 b=fRK/rOb9hMlvWK2PshqqwQxXC2UMUMsGNz0HfSi2XHyJk+0xlwZLBm8PZLL5PY481+ZS1PQmFMoMP80BH9TMoPAen+w0SHS2nWiTfTmq0Qzm6bvrbQSCblbx5Fcw8ji3PZVQZbC7uL5PLediM4PK96nEOhDjayXYhNcYy2OAMLs=
Received: from DUZPR01CA0127.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::13) by GVXP190MB2148.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:150:1db::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 2 Jun
 2025 08:19:40 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com (2603:10a6:10:4bc::4)
 by DUZPR01CA0127.outlook.office365.com (2603:10a6:10:4bc::13) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.32
 via Frontend Transport; Mon, 2 Jun 2025 08:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 08:19:39
 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org, dev@dpdk.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 1/1] vhost: handle virtqueue locking for memory hotplug
Date: Mon,  2 Jun 2025 10:19:33 +0200
Message-ID: <20250602081933.1881050-1-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250529123226.1875075-2-dvo-plv@napatech.com>
References: <20250529123226.1875075-2-dvo-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|GVXP190MB2148:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8349cc31-4f79-4525-2456-08dda1ae3853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fSq1HwyyMmCTNN8UIASXcgyneGeceXNcfPnaLLr6RTJ8r7gP1sNmO1K3I1Gv?=
 =?us-ascii?Q?Kgrm1LtW0L5TcG/hW4yQqLiMXn/BYCVF6tLFSnVF8omdu/Ba1cbCuyVKMfAE?=
 =?us-ascii?Q?BlBzyXzjKoTgcRf92AokbKfQpxbyNGttgqoVuddkhKb7J291FP8aRW5tBBLA?=
 =?us-ascii?Q?oASw8hrS2mHaSdXEKlXcEt78xkd9gFenmKlZtz9wKnS+jDm4J/6KDc3As2CG?=
 =?us-ascii?Q?2MaO4HSQ+6v2qNEDJGI0CeyIQbbESgoLwHTZ/ON8q5nYfg6nxVBs5HB8BExy?=
 =?us-ascii?Q?edXHBchxMstIuvAzNkN+K2QNoiU7D+82PHemDXJLvbGQlX3ouqwSTcLsVqTh?=
 =?us-ascii?Q?779/tZchtxd9Kkdj/zBFdg7wfpxN49vw88Or1AiyLDZKDHhAydvcHHL2Z8RA?=
 =?us-ascii?Q?h+8r2DRLzBl691XBLfHTNI+6TIsTHEBfX0AZjF51AYAfI4f/AalpNGqpxfmE?=
 =?us-ascii?Q?AVPRCKE5Y9Uxg1UAN8qBcwtjXOwMCjGnv+wJ6TQwlt4SJoOgtOS8e3ZrIkwt?=
 =?us-ascii?Q?2seacqzqstpgcQbor0TAxns6Z4Wa6jHbDu+6AyO6ms16uGN5QpqTUiAGhkyj?=
 =?us-ascii?Q?Y4dKV7ZZyzEtvNHjSiYBhxveFloP/QC0CVzX6eYoRl1+ioEP+JMhAMirYD1w?=
 =?us-ascii?Q?49iBnRHVJIrTOgJQBLVdNh3xev35Rm/NKRYyBvSAADRYT0/kOmrHOtuVW8Ih?=
 =?us-ascii?Q?cL5cZBRwNOZ/jRWC9gLiZGJIgs18qlrYoWMlrq/MMKA4KcMaRUvo5A15j0KB?=
 =?us-ascii?Q?SjWCnNjq1FvfPRYu0EqnRGw1FV0Xrf5JI8NjVs03vHFvWt9b+uAfJq2VJDsn?=
 =?us-ascii?Q?as2wZUPozh0sHmjkD9SQVcIOQxmGylvQDBaiXfkGE5qChHjlWcGSwG4pdlJ0?=
 =?us-ascii?Q?g7SL7tf6kawDf6wXdjt46ETaqmqeC/+3tj17ZutxCbSCGFbvd7wpo72tOZrU?=
 =?us-ascii?Q?IEgblYxZmcaDKCcqKxJRUnJ5J5K06aCuiZn/T0e3/qFyAFInxkk6a+zVBBaG?=
 =?us-ascii?Q?vdBAFRKcd5R37FfFz6NwoyX0ce9O5bc8ceuSA/rorDvAcFn9ULSIkpTLwmXG?=
 =?us-ascii?Q?/AnB1hBRRbUILzAQ3UPaXaxPjA+M5ARsM9xQoccPOKKcXlJctIAIS3/2753F?=
 =?us-ascii?Q?dhEt8ryH/fQj3XCxWT6sgkCdT5mgmoy/JaA+dHLp8e3rOILBAjShd6Dnproa?=
 =?us-ascii?Q?0j04zIWtG82ecYWh/oOpCQ0sRg28un4oUsm1jRAMvx+SOiknihyuyuSp2O2F?=
 =?us-ascii?Q?qimBfmIeQa5yuL3TKtYy/hjYEPZcu8uIeOZA73LvJG7OL1A06ds9dA6kahgs?=
 =?us-ascii?Q?QbrkRZmX+mBTK7fydqJ+NUvWPYxxrPFrUIdnu2miz/Fgr++trua+3Gt8p4V3?=
 =?us-ascii?Q?mpm3rK1DhxyRxgc3GmG2qAIdvx/juVOKWhXjDWXFDWzpL52S172w/wRZti4c?=
 =?us-ascii?Q?0Kj02guo6b7QSgpwBHeimruygrzAE4VOvmCiK++csrVVcHE1vdZjvNA4+c+Y?=
 =?us-ascii?Q?r/kxSgh7Ozz//SoXapecSOX2ZLBjHjeqT0YJS1kW4oTBCs+BJgIkdYrcTA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PzXOeZ3E+WOfsDfCwHq/g3+U7FCiPGVNZjkbKhwHm42bOTaITQsrj6U0x3KYhcbXkDC4dB6B81LerwrVFt3hnBSEjNtmEKyS+RpaORSD+cayZkYlQitNFh/vqjpkIF2pwy0CrprksBjQceeBkoqc1m/hrf6o/wm6DckyEXz4IE9IAzXwAnWq5SAuIconPfSmqpoBbjUTXAq9vnuOsc0H4lPcjwW+17LzlIDIHXQ888P2+d1k43DETEuZhyurweGSFE++SmG7KxpbrdcbctOkfL0GLyahBFrL5/XwzZBrmmS4puji3B9PQBKwNqtiF9b/XFQji4oprNYEixwD7GXCC0FtHIpRFvysUG/EiJNP1MHcSf2C6P5J/alH2X+vYsZwecoRLhRLniIgh39X9BBmFqjgdZ4fatAVDgeSqYsz+VSthvb9TLg+lrxJJDt0yJ1nAkzuqtYdIuVsk6VjOG77y8xYYWE6rBzZFn0rQXy7htxAR3GWkJAvLnlrTFZhcBa/Aqb0hqCxL4u7Y3WbLQXMz1wG7P9ghEIL+LSXqjboHW8aiAnCZUlj4rLThbEf1fHi2SOMD3RSCA6qF9J1/6FbMPyIy8mBBUQhxKAMaGAh0W0hgdXOrstYVCYYIPRX7e7TclpFzav2caenxTgTAJRcXw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:19:39.4310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8349cc31-4f79-4525-2456-08dda1ae3853
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2148
X-BESS-ID: 1748852412-302719-7635-1248-2
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.21.118
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGJhZAVgZQ0Mg4xdjYLCXFyN
 Qy2TgpOSnRAsgxTkpJMjVNMzUyM1eqjQUAnvMcQkEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265039 [from 
 cloudscan17-71.eu-central-1b.ess.aws.cudaops.com]
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
configured. In the commit
5e8fcc60b59d ("vhost: enhance virtqueue access lock asserts"),
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

