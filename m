Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0FEC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F5C2402D5;
	Mon,  2 Jun 2025 10:46:27 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 57A3C4025A
 for <dev@dpdk.org>; Mon,  2 Jun 2025 10:46:23 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2124.outbound.protection.outlook.com [40.107.103.124]) by
 mx-outbound42-219.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 02 Jun 2025 08:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQW3Pxop8/n1DSLz3CE7kEFAwNE2ESxAt2ZBbE5Uhl5sdWEyGf6arbvdhUdO0q8cjX/0QYX2sPEBt5faUHp2cW7vecCN+NknhAWLBcFSVnYQCujHIVyGPW/wLWh4c+1c0CAEKxSLDUWaMQDM6+Mp9CEBMo3jKfbP56w31YefVvahaQCn6e9FeVaiAFdfwjiNK0C6z61coxd/MEWtrW1UpIIgBnMzkFYr9Dou29Gck9epxsMqjJJZyNwPJCnzrHMJ1zYZ1EjtCdsV61+079fmcxLYxzLatN2wPx4XVNmPjAPNcb3zOV2bLN0azsNvsZslZsFYUwY+EoqfiUOqE1wjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc3+G14/fNLImHg80A51xx7QXxA0+BETK/Ik4gj5erg=;
 b=XiDESVaUyu+JQ8Jz7SXhCwceIbpo06h70x26ueeLTW6v+Ue5ev0MRYYQm/40EmTFRnQlR49o5b+5wVs4QZUqHcInYhI8ugwGAsp2ByqF5h/jB6kUfGv9aVcV/S52++MNB83i4mNLoLArrBjvWqbquhcoLZVoGvOD4bJgZFjbW4RNrCrAPCrWBMDrYgZBmBm4nlzw+7LMQBbXAwS70dgJCkg4qxaNhkBBJmQ+/3Hwg0IyZEgiMaFSYiOP9xIDbkg2feLY4wOTGZayXsVTto4xYnHDQdAartyk2NLM3LgGSxQgm1BYLk7n+WRoJWeQZIJ7m6AbprAtVcvVYjD401YHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc3+G14/fNLImHg80A51xx7QXxA0+BETK/Ik4gj5erg=;
 b=CasXO7O5zepTtiROJ29iTk9TmkukjtnxaV9IebEg4GJBx2FhGBNZ4Xnx8VVSKB9wByrpPUXVB7kZpWw6/wjjjpaH/IBtWbi2m6fQMAuQUtjJY4+Erp3s9giiLFuGQlIOFslKWOirMwRrp44u7mQVxw1JzKOygORMAUrDuYfAgEE=
Received: from DUZPR01CA0335.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::19) by DBAP190MB0949.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:1ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 08:40:30 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::df) by DUZPR01CA0335.outlook.office365.com
 (2603:10a6:10:4b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 2 Jun 2025 08:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 08:40:27
 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v3 0/1] Memory hotplug fix
Date: Mon,  2 Jun 2025 10:40:24 +0200
Message-ID: <20250602084025.1881768-1-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250602081933.1881050-1-dvo-plv@napatech.com>
References: <20250602081933.1881050-1-dvo-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|DBAP190MB0949:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f3b3c614-668f-4321-16ba-08dda1b1207c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsgYsmzrtbA7X4vYFFdTrZpRScM+VMdoM012LcVum3Z4g9JzjtOIdnnDZ/g6?=
 =?us-ascii?Q?umaOA8q6Nn3v2fcth2tbDsUMX+W4f6qAhXe9vvxcx0aC7wQBt19rL4VAbgvo?=
 =?us-ascii?Q?MGNQ6pUCRqBFHfXn1gT9mvMJ/nfXWETLdNTvl/hY+i2Sfqm1Qze5PsGLktu2?=
 =?us-ascii?Q?c7JFzqquadT3jPx+dQUrmKwwETDp2yD4IZ9vK9HOiKHqzUUjDrJdb07w4TCL?=
 =?us-ascii?Q?w6++It6AoGILawGp+ifio6WHvebCAsY4ysWVmUouatwO2WQ/+5EeyQD53nhf?=
 =?us-ascii?Q?QrYUH+Jq/zEx+3oCfvcwsGCrynBQK3blN1gE/stIy8pWskhGH1tYdsCUHcZ0?=
 =?us-ascii?Q?xyLtibupiWqqhkf3uFaHITw3/6KABkTyRk1xKlvPAgUFVW75cOjptdBFa4l1?=
 =?us-ascii?Q?4tibnJFRoUxEz+hvnTclamhxMAnyFUOVcDzLmgCAwcYdOVmaHhrhixb1EBCb?=
 =?us-ascii?Q?1fXW2mMcaC2V2zTEju8GNmZ2QqxioinkEE92E6WjT021gh/XN+ls655/aSV3?=
 =?us-ascii?Q?qb+0Vm/2gYgkx6uzNNtIt/Ikl8Cemur/PXVPOvS5hHb9tjUMfFFuewSiqoZk?=
 =?us-ascii?Q?H8hvLg4rC2hKAtb2hWlQBaMa/sMGAUnPl3CY/tFh0Rt9c7nhK0KWH5F40pYf?=
 =?us-ascii?Q?xKinIfnT6jYzeOhhfcz+lZB748SBfMXIMTbydUu4aYYcbUu8DIwvG7IHSBOL?=
 =?us-ascii?Q?tx1vKvYoCMVjP8g/5W1FWH+jOV54VnLmTIFtict1PJgUaxIfH3GiOgzm90wh?=
 =?us-ascii?Q?eWcdeOgkqtLMxUZoyyz0PdqpkauGtJAIObS+Rebb09fimrl6xLZwXrk1n/Pw?=
 =?us-ascii?Q?trimtNM2YP0tMVL0uO+nBPTNxof/nyS1S2sS07hP0zg94GqmUbi6RZVLtj3u?=
 =?us-ascii?Q?R94mRgs/+23kUGDHmXHrKptKuMRCJgIbUSsM1N1HQwnKw8kW1Qop+DqZerY/?=
 =?us-ascii?Q?AOkOSRA5cxk5XM1nE6A2w/+CI8YalO9XJbppVcAiY1L2VHUcjosMyPaXYFoN?=
 =?us-ascii?Q?HYU7nLJLaaCt04oCMHkvxh8xE+THcpS9z7Eqx97zNzc/f+CLaPilG3j2b2p+?=
 =?us-ascii?Q?/ED/gEhPCfN3wwOHQ92LIbh8facr1HgA96qDjYwPnqB4Ya5RB/7xtlba4iuy?=
 =?us-ascii?Q?gdLeuXpbb4JHU5EPO+TGUj96SeH4uLSQpbgOnf7dU94dUCUzA6qSLEWKBEPe?=
 =?us-ascii?Q?oiCTYxSwj5rJ/F9Dj/tIruqoxO282aK1Dw4fL1Wr4kifsdk6Nhims64kQJQ+?=
 =?us-ascii?Q?YtpvLMp8v/GIcgITU6VsZhoI0URm3bIMEZQKlo/vFgEMg7k823nixfFc4Sqi?=
 =?us-ascii?Q?JnGpnIEFlRDRejzy8gJsCL25ztGXcPXjLm00baInexmhoHnd6BGaVQ0ab8P+?=
 =?us-ascii?Q?KIZGGO1QNxuTQvF9hsawFJz+40VMA2Bx46elPrKkpMww9dghZAO1iAVUWAG4?=
 =?us-ascii?Q?MhBCzeHPtfJsEdkoHa9vA36sTf+Kp8rwOVc4FlUHnRoycBeIMFiScCkvG1Rd?=
 =?us-ascii?Q?tFcGphI3+No6GD0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pPfBwWOuPNSG0vJE153ZysEK5Jh3h5RXdY880XAuAgVZQv6RGSgCVTBtUuXceOqCxx3CQQtF377vMz0+K/JqH01yyxdBV8DKKZNo3WqOKSBz5MwmSouxtM6ZnP/WMnIdme7YyNf6+L6SwrZzWskHX7IfyDJmQT23tT6Qyh/CkJtMmiCypQFqonrdaKNYSgTbT6/9Pto3BTKUn2GI+EXg4jFdHoZzimfh97v2YWCkUePBxqbAKS4RXHvd2BbsJPjB0XMHkGz8r9FQU0XN51rkNLhgYjn+aOZWsaasJMZM1aXmMNBD8IJn9gVh4MLw2NDFsaF4jZYNQeKUmcs75ZLXPUVzNTW+yzn615FLX/pRSlZ8RAl1IEffvhWmkxozS85wLWirdXuAk1w/kx4g0jnjAlLAuP/6MA+yDkKygKjXzB80vYUoxnIbWG0+9dCwdbi5b4ono94ZlpAfDtGSB3ncApeZvNg4CiGZ74NfD+Sxy51PIOtJ3MsHbZR6Jod0NTTwYi5tzQB7h0gMfRg+snxlwk5GyBV2nI59S+Q2uh/QPedCYhEclUGD+cR1IEzT4nQSL2/pYPihC6H6cPYg++9SQchqi8A0To76yiM7D6Qk0PH6FdVIBHhNz7n0WGTdNMFMxNEXguiyhmlkaPYsfl0Wog==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:40:27.9698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b3c614-668f-4321-16ba-08dda1b1207c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0949
X-BESS-ID: 1748853736-310971-7660-2524-1
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.103.124
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGlqZAVgZQMNksxdQgKcnczM
 DAyMzY2MjQNNHE1NLcODXNOC3JyMxAqTYWAKATvvVBAAAA
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
2.47.1

