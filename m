Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30117C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 12:32:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52D6342670;
	Thu, 29 May 2025 14:32:51 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 76BBB4021F
 for <dev@dpdk.org>; Thu, 29 May 2025 14:32:42 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2101.outbound.protection.outlook.com [40.107.21.101]) by
 mx-outbound45-249.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 29 May 2025 12:32:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfobZ8qnOF/lq8QJeGNu7ftT+yrdD+H2xEQu8/7iz7i1JoHWDZUlWqazUHKL7NE5706uKU4Nj6Dpb+m5Wkm7Y8cjaCyDuA5X5LYwTyhfTuxf4UQ8Ua8PrmY9IkFhvIwidnJ/Qr1zrXWtwcmbJOKxTxkME2/dWAOK8Utu3x5BUie/k8vGJnhJ7hm7/NPW4LvH6+HA0hucwfCda/voksiOjSBN0+5aORTCtmRnMwXmebQUaIjFjTuMuwQ2sQ8idNaMbjkmGHAiFfDOTPRpWKJcwnadI3Jy+Sx6FeI2851hgD2baoZYwcPDRxoeu7SxNynssuJwraoy5qqcY/ctsOSsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ymZxHXfNPEnNoo2VZ7W2BBwvGscc7zSG36Tzp9YoD4=;
 b=WWimwFV926AzQdbL8LIW4KQKnMVGcl82/oBR+6kdonMXRdEx+1hL4N0gwJKwr9/vccmxzQtM0bLaFh6dXfCFgLUz5elyxZmL+ZxJvqmUNqVKjlhSauoDLd9FljfGLkJrHh4jY6RwCEKVZ71/5Y+J7CeyZIr7lflfG2EDYWzWroeFg5anHLVQ2gHX/SA/cXRLeTRzIHcGPx4h2OlLNNeUC2+uE9zhIz/gOEYj1znOSNJE1dbiaCP3M4uvpJ0M2HGjIQYu0pP05aZINRdScJD6aZYdEh5TUsOQyiIuVlY7csjqXEr7f0iX6D57ZGjUlvt7GdRAY2W7yCxMTQgmM9gQdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=monjalon.net smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ymZxHXfNPEnNoo2VZ7W2BBwvGscc7zSG36Tzp9YoD4=;
 b=Jc4yZuZrv9dUAJVQTNF7t4uhYRBmerILYe5AOo1jRPMoXURu9aD4IDNT+JhLdJe7gfzKE95M8J2woKAns/b6g0Z4P0c5S336kdyKkZvVou2gXzpw1/o3WDdXaJebqOaAr94od3RltCNWBsnxWyxp6AArf2316pXyRkC1W1Uux1c=
Received: from DU7P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::16)
 by AM0P190MB0594.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Thu, 29 May
 2025 12:32:30 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::f2) by DU7P251CA0023.outlook.office365.com
 (2603:10a6:10:551::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 29 May 2025 12:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server id 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025
 12:32:28 +0000
From: Danylo Vodopianov <dvo-plv@napatech.com>
To: thomas@monjalon.net, aman.deep.singh@intel.com, yuying.zhang@intel.com,
 orika@nvidia.com, mcoqueli@redhat.com, ckm@napatech.com,
 matan@mellanox.com, david.marchand@redhat.com, mko-plv@napatech.com,
 sil-plv@napatech.com
Cc: stephen@networkplumber.org,
	dev@dpdk.org
Subject: [PATCH v1 0/1] Memory hotplug fix
Date: Thu, 29 May 2025 14:32:25 +0200
Message-ID: <20250529123226.1875075-1-dvo-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|AM0P190MB0594:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a445b4a6-cd7f-4417-ec14-08dd9eace02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|921020|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XFbCi8LfWgvJ/11dtXLvgDVGxy2/jT9BOwtIboCcEqzs4QbONKt5fW4YsJCX?=
 =?us-ascii?Q?MpiOu504J6uyjy2RybYnCrwuzyBDP+GI4HBOWphXonrZZOhMq/bC+rPaU9bP?=
 =?us-ascii?Q?0LeBMwlOd8yFH/sFOP7NZAsKcNFr/Xu/f0hPfSpyl8vvDNs6TVDvRjYZ5Plh?=
 =?us-ascii?Q?/GHgX6muIjayywk4WK1KNzEl7KzPwjTBT75p5OG7z2W38ORIWGTqT5yKtpxC?=
 =?us-ascii?Q?ZAv3dxoVokOeztAPCwuChWgCsRc/vQ6Up+zNIkiViF78+BczCl2Ho/Fx4RUg?=
 =?us-ascii?Q?EQXn4cDeh60Lt+pjngBppToTMVRQqF5hiNjVszjp2eqRkb7v+JGxcNlJT7Iq?=
 =?us-ascii?Q?94FnlCUXP4sGrXp8lKL+6TGwAAfGVqvmHBhDUm8NhMC34mJL9g1toKppR5Br?=
 =?us-ascii?Q?tAt0niE4rVj/o6c4pfY9M6+VAYWkJZimgBYEvYjEz1cCZ0pBDoZDGlLMvPSX?=
 =?us-ascii?Q?XnIo7d+Y01mtdCCASSFW6O8PCV0FrOStuCA8eV2hDhBzCwDWcvpenEP9XGzc?=
 =?us-ascii?Q?fpfw+dReUzfebc1D8HpdKMUSQRLfSkWUKicJz3hIXlL+JK6g9BRqjGUbHPHF?=
 =?us-ascii?Q?xlhx3+DpQVEBczXQUKo993xG5vatBhV919lSYmD6/pHCTuEOIDnkTu2G7o7d?=
 =?us-ascii?Q?GhcgPy/JII886O8mUvpboDTiUmCppiWfUbFr914akxk+j55inpROqvigiJEw?=
 =?us-ascii?Q?XyBertcDQIdPTj4UlB7ZaaTwAtq5y3q7muhlsRkeIyz9ATaHYB78EAWO3wgj?=
 =?us-ascii?Q?OngyF4Suzt7qhoB9Mh71+D2aPkjljsrcro3t//bZ3uokysYfxEjRfj8aZBFV?=
 =?us-ascii?Q?Bj15nkZLDEBZVFXiUFqu/lLBzAlGijwo7MEII2gmrYWaZqUujntxW7eUdveh?=
 =?us-ascii?Q?XH58R1NfF97ARioFKso1jJG3gDSbNlG6aRimbrp9giufasWKRS0Eq3SPkoaW?=
 =?us-ascii?Q?EgYtrar5aq/Y1jSXrlnd4wcfWa+lT+tleHDNLNehac14vVewNG6o8PFXUd+R?=
 =?us-ascii?Q?oJQ/Y2kH43yQznaX7xSTrRFoStohTuAkm7WjXYcuFlc5RUf0c7bE45hUcSgM?=
 =?us-ascii?Q?kpoKld3CTYDqKxceA0MHpDT/4UVh4DuPtWADTLy9/9fCCuvPjYLhv5ZDDf8q?=
 =?us-ascii?Q?M1luLKLVTgVNbzZj78OT++Pw8b5cVl1ksAYsw4jmAVh7H1Hx7MMeLkO+qNFM?=
 =?us-ascii?Q?42j3sd5xY6HJ3SDPo3zlsPwdeIVB3vy0MrSPpJyGp3184AGe/S9sNT9JheNK?=
 =?us-ascii?Q?+0BRPbodb5Nozd9cA6c1ixtoqqx3ODnBJPiD8gXbGS+Hh4Qe0udvfvNLe/44?=
 =?us-ascii?Q?9NWoumeX1eoXdFuoOZTpPzH3fwpMJkIWz4JimqZcU9fRsdoXa2N2QzQOKEIA?=
 =?us-ascii?Q?aDXZ13TRcUAB5jfti080OWMLyw2rlM4pUtrnGAZF1y2d1Xc+77fn82ZB+J/f?=
 =?us-ascii?Q?f0pejGSR6g8ONpJV/pNFFLPbZBD174Gs1LQfU/DfKApO/zwJxM6zuwyqIVgn?=
 =?us-ascii?Q?nzJKpKQAfADi9sw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xwy6rFVcKDaPV2AE06qQhekZV4Q/Qb4rogvZM4ihmHIyPhJ1Oq6kxP52GdUlFroHBIpHZgK7h0gRU1fzTSFmjHgonNBSGKlMrL0QEflxWp9caJAGkwtpn57BORdYKAf21oEsv3uQyppcrojLoEiYDjpqqt7Hd9VmBgVtb7Svdbpd2kvSu9HLR+VCEzsXMwvkZz2AbTxufXmipTBq5ULszytLTj9d2SbRWODbZhB0EduX0PpCbPM1XDcMrx8yJpocc0GTeU2D+D4gApEiEQadFp72Iynhu84vdWmC8EixEn9jZ3ERDl5A5ozg2yMwXN1b91KWKIOp/cJb4e5OBavlBu2s4/NFGY9qqvsMcR/4lsM7+BVbtWUAmJVwHaxM8+2rfY4ZVYx+dxG7NAzQcDX17aiao2K6JV8pq/v+kozAo0K2bwwqZq/UWpwcrRNHkK1rjF+6bdwHoSj05KEE6mjjZo1Fk1ogo/YIVPBfFDW5HyUfaOphxj1Np6SiQEYPufWoQKaPbFpoEzi2VG50xfZTW0OHquFsOH974gF7DBZuclknk9ABmb04qQMCk0RyxGpSUqC5gwJw6COvB0830Ds/B/meiZWtIkRdiRIA8F5PrLoCNtaf4AgJvob4d9A9S6ZuE07pE3jssb/Bhmr1k7oG6o+xsb5g4SElYJ9E1FfMiBE=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:32:28.5911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a445b4a6-cd7f-4417-ec14-08dd9eace02b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0594
X-BESS-ID: 1748521952-311769-7757-13974-2
X-BESS-VER: 2019.1_20250527.1501
X-BESS-Apparent-Source-IP: 40.107.21.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGlqZAVgZQ0NzA0sg0ydLcON
 XC0NjIIM3QzMTYICXFINEgxSjZ3NxSqTYWADb48PpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264948 [from 
 cloudscan13-204.eu-central-1a.ess.aws.cudaops.com]
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

