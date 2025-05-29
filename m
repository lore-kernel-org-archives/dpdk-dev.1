Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F76C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:31:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F786402C1;
	Thu, 29 May 2025 14:31:49 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 8CBDA402C1
 for <dev@dpdk.org>; Thu, 29 May 2025 14:31:42 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112]) by
 mx-outbound45-249.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 29 May 2025 12:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNwOJcIdaZXGb8cqg8iM+w8OOEuTE4pVSrPk1sKG8/MdOOVniuCfBIDnrG6aYl+hM/9XwjqquV46A7Yaoj9aXewoVg/sWwEap98iLG1VmpnUrzsTaHMtz9Swp7Mgm3WvSBCKhppyehafZH01vSyIZrpSLCU/5f+GsYEAmpnzTw3ciy0kZQ57B5BTF1asqiiYviDshbk78fz3/p/sPGoD0os8sVgvwP5WnsTcZOw92yPQuVpWlHxUQzISqbJH9WkcdWxDDx9YXgICMrWauZkbt4A/B3mx6N9I3loh/ZlG1SjxWqicabzqzz+4qZFQpLvK76b1qpMM7UyjJRaaqJsZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ymZxHXfNPEnNoo2VZ7W2BBwvGscc7zSG36Tzp9YoD4=;
 b=KwOSabIeZtu9mVHZhjM5OoKvPd0mMYPfgnDQhz3TjpAs3iCoZBWbA8+rZ+XVL9zaUxc+9Zmu+1I35AoGJrF13cKDRL1D20QiAeIoA0PZpHcKTNAanlxZkauJHP23HbQqiq9PQn2eXQ92RPLjJ13YYTNV9PezWTcDhwSkZZqgNbp6HiSGQHTKz0HwP3adAYhmRbLtWUdCgdVHg+GEWnSwiehbfvQqK0kMu9hkk/K1t1rI7c1qgkJSZyDRr4vdKlba1razoWZK7blmMEb/X4PH5gUiLddXQ5hTv6YaWhnQnPcveG5/54aqE8utO9W0bUD/3dAj7W3yCg0SNZ06XGizHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ymZxHXfNPEnNoo2VZ7W2BBwvGscc7zSG36Tzp9YoD4=;
 b=BudA7PwT4C3NpQ6ILLLJnDChtR8JcBGNreuK1GCsGJtDsfVwq36oO5kvywByU+pPeTOxYbeGxYga7Vz/qiZ6hYJ8QJZXQL+kyCgbVhsMU2cG4pQI903b31qKL9txJBNAxJiejRjheTujWSRqGAa3Xswgp3d1JA7ipbRSzEdvYgY=
Received: from AS4P195CA0045.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::18)
 by PA6P190MB2053.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:3cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 29 May
 2025 12:31:08 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::a1) by AS4P195CA0045.outlook.office365.com
 (2603:10a6:20b:65a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Thu,
 29 May 2025 12:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server id 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025
 12:31:06 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v1 0/1] Memory hotplug fix
Date: Thu, 29 May 2025 14:31:01 +0200
Message-ID: <20250529123102.1875027-1-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|PA6P190MB2053:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 68843140-a998-400d-6908-08dd9eacaeea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CjcijzLN+tCVcpzLqNrhPoLlkyhHXaCqvKSsRMRrn8hXFmokgxfgTr8aZtTs?=
 =?us-ascii?Q?sfie4j6Dgedr8fR+MadxbTdBjY6E+vGJGzain+PyKNe41whULR6VHHV3gupG?=
 =?us-ascii?Q?cLqn8yOlzKPX4AswTP+ocrmgvSi/ibeHZbBH99/Y2i13eBb78E+rLTG++o7n?=
 =?us-ascii?Q?ZHTtlahaoh2SMDgGihom6Flqfu+QW02N6WsEwE0jPUGE6OEbRtlr//KZHDdm?=
 =?us-ascii?Q?DgLyP+a1xIUCeWSyTHoK6aKs+7OdEugg0n1f2ag34TNtp26Ko3m/eBQTUbEl?=
 =?us-ascii?Q?YKvGqmrS55tfDm/Su1ERgSf9I+jLQ3OEKdjm5OgmGE/M5dotRdOAJwI4A2Lv?=
 =?us-ascii?Q?z+kdMS8BMmvrdfNxiVnP1TBOG1/4ar3v9hOo2rOUpqCPq593QdGekCZCdFl3?=
 =?us-ascii?Q?yCKFFFy20F7chKMXjq/hsyXBKexUCWYXpOcq7BKBVyxB6nRr/2t6YgNKnw2h?=
 =?us-ascii?Q?/lO8tedfX06wbhdERA4g+VJG+n9aG2hzgyfbeJPU0oGTbhPNbfEitFbkebEK?=
 =?us-ascii?Q?RlTqnSCRE1KdXgqqACxFquaqr0F56bswZ5kdUqLLyPzhtfDmORdNGdk3XHX3?=
 =?us-ascii?Q?KW5FQ1/3WUEomrPiHrrUccXCriq5gS+j2IV5bUghUlsn07sGWR0wCZT7uj8E?=
 =?us-ascii?Q?CK/7qJ+FKU2Q2xQIeymCfvKTQnd4LWEVIiNkZScP+KuItlTmpA20VsiYEewi?=
 =?us-ascii?Q?1S/8M5F6c36EYniMxl4oml+u0o57QAQEvnMayaAMnObZPQmLEqvbImekbA0c?=
 =?us-ascii?Q?dx1Zam+ReRSCZKNst8/hONa4ET2q/sJ6MtjJTa3K/A3Tv0lVCtqWATjBEu98?=
 =?us-ascii?Q?nt69DGFjiAf7mYpz6HhXFWFmTGPQaZU4D4rDu8BUxf2uL0KbXMWYRlm2i01c?=
 =?us-ascii?Q?wHwo54t4udF6z4AIjajkcIWnTtfYs7olCXOn1ujpXV5vFEbyaEtFFArICufl?=
 =?us-ascii?Q?Wzd1auECr8Hrt8aT5RciLg1IvdvztzAP/eADADnuSi28vAGpu0CtVYRY5rhW?=
 =?us-ascii?Q?7Sx1pDdwM4EM4uZzKWr3mOoUg5FPHbb44YDl04BHhIIVgaA/iqHoM9FkTuMF?=
 =?us-ascii?Q?OBrxGo1YY0sVDtz+YZP1I02oGWDautxcZkBIoMWf1RmMi8aP1rXE+ssIsysh?=
 =?us-ascii?Q?nHNHenC6Tou4jE7mCy+91MMeJChssNY0ZXHT+Pzp7/w/YNGf0k+1RazWXoGg?=
 =?us-ascii?Q?JmYSiL5+0UcwwooW100s7iunalDB5Fy7NGfow9omwvQU0YMYbb9y3Ep/Rvl9?=
 =?us-ascii?Q?4u5q/nHflf3TJR24kA9k25IGHhQBEXk49SxlopmjhXMM6uxc9nLE8pG1GQbH?=
 =?us-ascii?Q?0iwcYVqdGC6sjAdm13AaSE9m8ygo8yKmYo+1Py8PAWJfNJ4I7lEMy0gPj54r?=
 =?us-ascii?Q?mVJdrV+eHFMX+8ueiJm+SY5lqwdkcaHAgmfKcSUN6Y4mdDsQwTtPCzBrUmr8?=
 =?us-ascii?Q?4YiZLeh3wDEGTaYMO6BT1no91ZaZT8VvBQykCUePpczbbC+i49PE5y7BzmGM?=
 =?us-ascii?Q?Q53NXYzOCKP28mo=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rhecf157Yyq3IodNx9JTfb3omWxJQV0Q7E9i1MXwF+Z2+PqxHKyzGMucnaJgvRdQ6aDLSfKxuGxBSChVv7fwdduNxhzVtoyX/m9xLw2hyZ3BsQxNZykJkz3amFmv+/M6vFEgZuLy70AYyaQpIyBCPS75pRsSC/JERG+XyPidIKSYpUc0A7Yum79H5iLLeI+Zt9mY0gk6DWvOeSdLIS1YuIlfexsofXKEGU/4p82WBIKrT/kcyxCasQT2gDzbIY05LtqUStTRtrcfq7LYpuDEm6gHWt8JckOOkzVZ/DW7pmF2UvkNR6+GQ6Z3KWYIwFhskXrqvWU0eTmnvVPWqo7Iad1Q6pkMGu0pJ2Ja5rtCRhDAfMyZ/OBnqOXS7rLwodybcnY7tiRNv2kj1DzEJkngjwhxvuDiqxN41iH949JSVfW/y1kIKSQ4FJvD7Yzj2qh0cWIEoncLiJXxwaTgrkJBmPrcHJ9W/kVd04o31yuFm9PrdSuV6Y9BqYe4vE2eyPP9Yk9/YmkbiFz+i6vFt/ueBv3WEpdwvmLPMpc1/GpLl4Mwn3HS8V3+U8UbvhkDG7aIA4Qc5pi2bYEYE+NEJPOYn5vkWToBa1lFrRgn+ZEXph0TWupjKGxZi9Pau5DO9LIr/nlBA9qIPmFKAmcZ9bBL9eHTSB9aDgNdOpCuOmoNAuI=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:31:06.0470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68843140-a998-400d-6908-08dd9eacaeea
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6P190MB2053
X-BESS-ID: 1748521901-311769-7760-13930-1
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.20.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGlqZAVgZQ0NzA0sg0ydLcON
 XC0NjIIM3QzMTYICXFINEgxSjZ3NxSqTYWADb48PpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264948 [from 
 cloudscan15-18.eu-central-1a.ess.aws.cudaops.com]
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

Hi everyone.
We detected an issue with the memory hotplug feature and virtio devices while working with vitrio
in DPDK.In general, the issue is around the user request VHOST_USER_SET_MEM_TABLE and
locking queues for this request
(https://git.dpdk.org/dpdk-stable/tree/lib/vhost/vhost_user.c#n1512)
When the vhost_user receives the request VHOST_USER_SET_MEM_TABLE, it locks queues only
when the flag lock_all_qps is true(it is always true), AND the flag
VIRTIO_DEV_VDPA_CONFIGURED is not set.
https://git.dpdk.org/dpdk-stable/tree/lib/vhost/vhost_user.c#n3181
In the case of a memory hot plug, the flag VIRTIO_DEV_VDPA_CONFIGURED is always set,
and due to this, the queues are never locked while they are expected to be locked.
https://git.dpdk.org/dpdk-stable/tree/lib/vhost/vhost_user.c#n1512.
The quick solution is to add the check for request type and do lock queues always
if we have request VHOST_USER_SET_MEM_TABLE. Something like this, in general
https://git.dpdk.org/dpdk-stable/tree/lib/vhost/vhost_user.c#n3179

 if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED) ||
 request == VHOST_USER_SET_MEM_TABLE) {
 ...

Danylo Vodopianov (1):
  vhost: handle virtqueue locking for memory hotplug

 lib/vhost/vhost_user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.5

