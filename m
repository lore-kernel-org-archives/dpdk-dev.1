Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C607BC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5C104025E;
	Mon,  2 Jun 2025 10:53:30 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 854594025A
 for <dev@dpdk.org>; Mon,  2 Jun 2025 10:53:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2129.outbound.protection.outlook.com [40.107.20.129]) by
 mx-outbound10-159.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 02 Jun 2025 08:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdFplWEhPObNMhInaB2eHr5k+vbjqq9BIsQiJZ1XLjXoJZRX6VZEDttYHC2JoP+KsZQ+6/cDLTWGTvNF2vPgo1U+aLGLUTsIJXGqtkzZkzwABsIixsADPvRhMGO/UQkcxtIoBXx0HuPuy5uvsoItf4eGbbFXBzm+maP7IUtC5jA4nczSwPeRaaDn1htB9J8WX/JAjPl5db2zhqFYnm73V3j59Ygik/sfVyND1RC7hG/Z6qqHx5E471g+IsK/I/n/kFA/hqx7AwD+jzgf0PhwDdKWjuqFVNBBNr/cFJmTI7QoIniovwrE/hvMxL1vMOH87Kqd3FkOAMNQQTo8bse+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc3+G14/fNLImHg80A51xx7QXxA0+BETK/Ik4gj5erg=;
 b=TUShmMNMTNG1IPWhbV7wGgM2/hnTcE9BohBV1Vi9O+1oZq8aPH1wTVmR72115aubBEckW6q+UdWxxDvTvqv/KHR1cejmuEh0nOTbvyfY5qbzolDnWiX9SH+yVJEHQZUPAbPZFeXfmO/gu1ai7Ff7HLYrUb6djLRS9XJahhSLxDSZ0drYCB6O3gAsSZNBl9IfDtSBNpB8TbmrZx81OarPAvR28G39Xqm6EgM2+jrvvIXIkxHUBAKxs1rAGGA1h2YT5/FnolEtpS9QVGVN5BWWjfxRK9h9JLMh572AhLcDOaFH+Z9++/i7SDlVJTi2nXV/jOeC6OW4XmJHFDSS+7xidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc3+G14/fNLImHg80A51xx7QXxA0+BETK/Ik4gj5erg=;
 b=RmR1O8ich248ZoJQdU8qMzxrcu5VbmgK82sewI+7gNUBK5tJcW4kUpLDN+KyKL87V68Wd81ZpGUER4I9LJ9O2etycqb8l902ZrrYS7b4/Mw1gNgNnOjzuYB1gcYXeAOlC9q/nXXeAOm0l4ucKJwrQjZS/d0mtxNe8A1BGcYfqe4=
Received: from AM0PR02CA0107.eurprd02.prod.outlook.com (2603:10a6:208:154::48)
 by AM7P190MB0760.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:114::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 2 Jun
 2025 08:50:08 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:208:154:cafe::82) by AM0PR02CA0107.outlook.office365.com
 (2603:10a6:208:154::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Mon,
 2 Jun 2025 08:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server id 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 08:50:07
 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v4 0/1] Memory hotplug fix
Date: Mon,  2 Jun 2025 10:50:04 +0200
Message-ID: <20250602085005.1882499-1-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250602084025.1881768-2-dvo-plv@napatech.com>
References: <20250602084025.1881768-2-dvo-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|AM7P190MB0760:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a3361f63-3efd-4a23-a84c-08dda1b27a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BvMNccBecfUrNrAu1DLUWDaz+FB2votQqZBhGXuFKhsXnYaAyR+SV6QmyUh/?=
 =?us-ascii?Q?qYtBCRpaKxt4u5Kz64NJDhGXEazoAy+FU8Zz0EvF0wgdrBV0g5H39KGtEWdY?=
 =?us-ascii?Q?tO2V0e2iEKzmeqOVUEQr+0k1jpRw6dwnoXnb5tBJfk37C2UjgAt6ddjj7IEg?=
 =?us-ascii?Q?rSLiD9+d3f1dX7hs6TluepQLRIVPYUHNACe8EOBqh0aJ2rROUu/wmLV6rVkx?=
 =?us-ascii?Q?bBvH++AXbMfXNsgZxUrWANshzqdVIKuZ3if3zKVkqKJiegNIINmGmDUu98cy?=
 =?us-ascii?Q?A+syNjX5QAs8XcSL6mpcYB1ZE4ibNlScKljklJwICqDpJrwi423gHBaK/FOO?=
 =?us-ascii?Q?Lk2ebdiM/GEzobRS7hDvTJ0Jk3FJuAObb+yGFvvqfcovWauXFyC3tMz9/nlv?=
 =?us-ascii?Q?PF4eO+6Cd6dBOmqligNsm9dHzzoDf5uZn5OS3RjNpY6tdBa2m1hcVtd4snr3?=
 =?us-ascii?Q?l4Fh2PBL22KQVduE8WbpU77pg7iU12dSjdiEc4pgMqLRMpxBkuQJ+xeaIAYM?=
 =?us-ascii?Q?bioFDf9iwkk+sCZDrlidKTepMtBX2o3X/d4WsM90vtrCJr1R5GZXPxFCoyW7?=
 =?us-ascii?Q?4bRFqTtZ+/XpEFsfL58zUee0bFsvC9BuCM3thoO3wJkDHx4dop4EIM/h5GTR?=
 =?us-ascii?Q?soYHLQkhXWXIPmTufKlW+V6vTdvFT4rMf0tRZGELR2LKyfQlQMfnA7RBORuF?=
 =?us-ascii?Q?mKIvzAd+no/JCN2Y6O6nywWB0KfbbJ7gtzkYH/eRkpB52UoCr4h6FpZjlirW?=
 =?us-ascii?Q?OaXAfgHrzXVaQQW4IV6q0RIAeQPr6x19PukR+HEAEGoRrV+U1Kj4sXLUhzB3?=
 =?us-ascii?Q?/TRZdSPhAhDjU+V6uoX0fby9LGsEOhVP2ZfqSL7qFAkskysbbGszyXvqtOJQ?=
 =?us-ascii?Q?2erUlxxpX7+Hd0WY4ULRcZqQ0Pj2nXLIJ/j+pT1UhyfCJoDnNSbp2y1eZNiL?=
 =?us-ascii?Q?+iet7kCxwkyUB4RnjlSe/OobMp1sBHlA0IG0HWcJgmWQKXr8D371TkHDNU/p?=
 =?us-ascii?Q?4JEj+/93az3c2I4rHBCT58kuwK68SbhL80kHpuobj2XenfRJ2tLuj6SPV49y?=
 =?us-ascii?Q?Cq+XBkaw/EFsrOQFqpfCkoUkt6Aus/9cSOmNJLGAaiDEAhdJdHClJctZPSL8?=
 =?us-ascii?Q?i6fmSGGuDeNTtynyTTJirfHgAYkr+xw+lV2vNAOmYkpqbi1quP5+luOvY2hG?=
 =?us-ascii?Q?2szxdo8giTcA109yAGGRcbkhoiXr/YhpBdfP6vJdgg19Ctj4dv6EqiHXkA/V?=
 =?us-ascii?Q?CaafvcB9AfRnYM0n0mdCFBrXYfn0jeZwfQhHHUurnQR7PNlxq63dQwetXA0Z?=
 =?us-ascii?Q?DiAwlXJjkqtO7NM64ZK+1bV/YcJNHWTF6B4u2hq9anPk1UI8SpVVvmC4EgW1?=
 =?us-ascii?Q?pYnxlV6jSRK2Pr3LkdW2TDS/VAJ9WIViLRlawB4QEw+/ZXX5eaOdx80zJxdw?=
 =?us-ascii?Q?i4vdiiUu6TcPLf+EN/mz5ARKrVyjrDIXyWrO9z3642gTd2LjqCGv1dv5zcV4?=
 =?us-ascii?Q?NIuWal8Uqo7uC7I=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H/C4QyTg4229i8LqxUmIFdrMJBJHIr41uvAGz3VPxOiTdpwg0sgIxb8NklmeJEa9fBwpHDs9m6e1hUXcsPpoOn/zkZZPXIUh5+LZJFyYTRUECSC79oRVnsXao8fbjIuWLZW/En/iOKPIYLiQwx8Xq5j3YSsYyHehRboapaI2T0+Kr8usHyr+TLKzMUL0Jymyus0Uxlxv0VvSTU/r5ItltAgnlSygKgJ+cCZnygPyQUCizW1F2+1YgGFDGafODHZn2rPEEf46kqzujsMVX9ahC/7ZBPfrj/1giV086XtT6CddvDURt38eSXHFRUPwr09N+Hdj3mll0FSF6Jlh658PFhz6NiqFOke/wIBO3FMHWzW19gufvvQXs+ra5cOj1Hx1ApidIZFLE+9W4G9ygkvNUJRRpmCXuJ5NzydNo/PQ8GzqwZZQdG1/eFNXoBd3yzajlLJDAr7F0LbNyW6xtRMMum8qYpP80jGkhz2+i9r2h2KhSjSwFG6U8XO8hQ5nb9dM8iKF029tKY3EGTdO/rH9lGb/WkTHCDjbBwx+uJFYBS49tz18j0lzG2pZjhbNoqaTaMqEwwKzSclzUyZopSJzTjxiKwHtJcvF5L8G8ImVWehT5vlfVxLYLrmLM9iF5paAumZVTbW8anWoodNkChN9JQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:50:07.8259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3361f63-3efd-4a23-a84c-08dda1b27a10
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0760
X-BESS-ID: 1748854210-302719-8816-2952-1
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.20.129
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGlqZAVgZQMNksxdQgKcnczM
 DAyMzY2MjQNNHE1NLcODXNOC3JyMxAqTYWAKATvvVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.265040 [from 
 cloudscan23-187.eu-central-1b.ess.aws.cudaops.com]
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
2.47.1

