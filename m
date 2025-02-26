Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57245C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 16:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86CAA402D8;
	Wed, 26 Feb 2025 17:12:34 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by mails.dpdk.org (Postfix) with ESMTP id B04734029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 17:12:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBKa/ar5sNt1vjs3Qs7FjTqO5NnvicKc5vJWoxj0NMo0cSTQfFbpEf2Wdetsz4vhXay/u6z4IHeprY1mVuehqaiVj+j6WK7JWd1Jy79FFMlO8SMy/pXjcpQZfC8MSHTPlMVQv9cclYgFDIrCJmV/zOjHFajcscngQUAtUnJhYolw2kXOUxzT9NdE4V6w0b5FcAVjAkRiHuFh/p/G3yXnaMis57MqHu0Pu+Nv9VmUR3Z6UxWxjObRjEk/tkdTjqHJQ+CpwVvwOC4IM6lCtdZYPkdIuWn2oMMBhax8AxnuQFlQKv4tIPzRh9DIV1DhNn6CFwybAfEm5Her+wIebrNdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIzlVMVeuL91fXzJVIgvHrHhSLo8mlRz5IRufmPp7vU=;
 b=hhYt3oa5cbzhWYgVgn7tjvQ0ycfWpD77ASLJW/VfGprrYFgyvpWlWurHWAoe3X3NrEJMrqB5ljvSulOmiyq7tZCHh9843PrVrRq8wkYcvCSI/wcdA+pHDc8zgIL+dbXjVms1pMkaYRSR0JhqQ5EqvfMm8dBl7t70hot+uoYA3KjZ9IglCS8RalblHhcpibqQ7FYRn23VVVduV8vRDeH6JYtYuFzejKPiCFNXaIG+Ba9JXECvPMDbbi9tbZ0SnNMOTWr/QXICSUQPTxQUo0l8/aGl6Gq1TzkFsfYrGurTvNkB8XC08+vn4G00J7dRH6ZkXOo36DnddeGoqlpEOT1K8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIzlVMVeuL91fXzJVIgvHrHhSLo8mlRz5IRufmPp7vU=;
 b=URR7dySAtVJjABF+0PhvN0bJ1485g4HUMkmuMMGxAhE72z0xhk9lxfcHHBOeoTw/94it3sWkQbBHS54pQ6BHpqfJyCMB9zuP1omldSRHif5qsAfAmoViEZhZ2TkU1yAIlt56uWVZchAFNjOt4Pgpf5DJR7ZxaghMky9BNmHzAgjgtKnRSdzpuueG/iD8XCwX5vvWbsvPHQuA9qaTsMy0kWQZB9iWphs3CN7BJZPXbTjmtKS2doOflp3Oz7lwD5XSTevXdHbNNaMFVpwWpN75EMKGM7tzzwdvOvXLbG08RszIlezseSQOgwXKOiLNsGoWqKyQa4fZo0Ha5aFvOb7IzA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 16:12:29 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 16:12:29 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH V2 0/4] mlx5 unified fdb
Thread-Topic: [PATCH V2 0/4] mlx5 unified fdb
Thread-Index: AQHbiCn2H4z3pCMGuEKJnR/QK6VYPrNZwgDo
Date: Wed, 26 Feb 2025 16:12:29 +0000
Message-ID: <CH3PR12MB8460D282CC0E6F88B908AD85CFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
In-Reply-To: <20250226083846.4023622-1-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|MN2PR12MB4357:EE_
x-ms-office365-filtering-correlation-id: 9b17a53b-b765-4288-3d9a-08dd56805e92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?r6jE3RB/8nBb9xgpKRdruGqFgSMkHvaA4CoHGa/mzT0gIKTr7yFW9VHz9+?=
 =?iso-8859-1?Q?7FJdkxXaFPQlsKghekDAnvs7x9gQsRsdlFCUqHgG1mawRf8gCaRZYpPaN1?=
 =?iso-8859-1?Q?KrNlZUNd1HksVmUxzr3PQ9MGT9Val2vEuwirakrxCPqBZlg15l+9Mf5iTV?=
 =?iso-8859-1?Q?/e+LdHd8PzgYZqi+Aae8eJK+ExOEqMWtbO6PI9a6RB7oJV1hcwRNxZ16wu?=
 =?iso-8859-1?Q?lO28NTowN6Tp7WzrpTpwmfnPoqKvts4SisqqOvx2b2L8Xvx1ZippgOUW6D?=
 =?iso-8859-1?Q?eDJWTJbSV+elUK1epj+IIeLrV+Gq3NaQlADcjVg4rkLoREjQWlZA6geSwE?=
 =?iso-8859-1?Q?2tuPvOt3RMeT9cdx4KKS+v4vke2Ksu9QL8yw/x6BaxxrGHTxPwLqW3J6ww?=
 =?iso-8859-1?Q?754Yrtwi7NJdn2icp1b0IMIzi+OTLdOUt2QomYNWRT6T6meApIbnn3lypM?=
 =?iso-8859-1?Q?pscT2BFyZqRI89NxFKJ6zw/GgHoeQLMdSxCby1FDGpN3WCMkuY/NhyRnx3?=
 =?iso-8859-1?Q?eoarXcRXWGaN7vrB+ocMsin9eQ1SkGdcLxfDMsuWZkRLucAJvus7oUP4xk?=
 =?iso-8859-1?Q?BJV+qocfDlO8/2s46FtmtOT7Xxzqwszm3mld3844EXl+adXPjBMtl/86eL?=
 =?iso-8859-1?Q?m7zbixXy+Sn/mF04TvJfq6NUL1PJBKf/jCt6p7nyPPuzuS1qImCvqwuuVq?=
 =?iso-8859-1?Q?vb47+7jmaYCweQKrsk1Df7ntl+dnq4jskbOo4Ue4MCqoCwUHGDAzbX/mky?=
 =?iso-8859-1?Q?07bgyHC8CFsCthgELmnjkOb5r+sc9QdZJZQrSQI/O7SdF5IQY0wcd1SizT?=
 =?iso-8859-1?Q?kfukmQPq4FPrfR9LnqcZrUE/Yov95px+9QDJIuYAeOXZkSfm7fdgqoLpPd?=
 =?iso-8859-1?Q?fKO33GyJR9yi26yuJu9rYete7mThcmUtx5WgMolLc4Ie+vYIPQN38Viys1?=
 =?iso-8859-1?Q?kOpdcbxi1znwMJiALnLbJFkTXfsbx1O7rp5Jm1ugmmna9CwDl9KndE2mOI?=
 =?iso-8859-1?Q?WmQUGFys+sAIjlKSXyYZuw/HvuB8vk1WeAzk72LQcboomeEZzW6OqF1WkZ?=
 =?iso-8859-1?Q?8eLOHtsDR1roOmP8B3Rx0nW2JNZJS4c5qc4diD70GjxrbqjM1FBsJU3/9g?=
 =?iso-8859-1?Q?sti8Baw+/dAeoGrE5eMBWT5Jx5NTJZxworLTIntxvkW/BYOXeKaEqRMFbW?=
 =?iso-8859-1?Q?2jZpFDQRt3oJXou0mwpCHAVpXzk+9Syqw3KVcV3Xl4ga/cqYB7JGWd7V/3?=
 =?iso-8859-1?Q?oP7lR0TBSiY9Vp/ACDeAvLj39Fm1Qg6Nsa0qB6zQcFeeLRuDhM5R48gQPb?=
 =?iso-8859-1?Q?pxT6FngCMNq69hIYEfNqyh4wu09zurXyAp/RKFZdPwPEjhQqnZ5Lw0sOY8?=
 =?iso-8859-1?Q?/qjyJDSX+ZeE0KvDJsVimpsOdyuW5kfBh0j2NOwtabGhaTyxQeCDABqbgE?=
 =?iso-8859-1?Q?EXXI9vc6Ps99hedxfD7ffHWPZ21tY+970/9mlgvETLPQqsGzJz/wV3SnH5?=
 =?iso-8859-1?Q?CTNlvjnp4DqQAk9yr2n4fR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MkkhkOLIlxbizJy+btoabeqZQ67YJ1sC/z2eN2VGApcoxe878ueKlIX3gD?=
 =?iso-8859-1?Q?3xOJd/7WUS0jxvk1yaANHI+IlGhaUkIbTM1i0ujDj9Y9PJyR7/+//gWFFl?=
 =?iso-8859-1?Q?pc1+WH6LwvGXw4LVkfaFjiw0UEVZqBBs/sWecGKYFqHQbS2PN4s5j++QPw?=
 =?iso-8859-1?Q?19rf16XBAySh89pDa7PLC3Yr0irA4q6CwvRQLUH46LnDY6d+lu+pZP6V1E?=
 =?iso-8859-1?Q?6OdQL2Q98Z5aOMHsiEDrA9gRviAOxXSbKH/QB6GP2806m+ijNHPBWceDAg?=
 =?iso-8859-1?Q?VzF5ozLbykAU6Hpj02+TqTfkg0/udsy+bjnIYtMAwV5vbjG/hHMBDHLU0V?=
 =?iso-8859-1?Q?OIKggG0DJA/dluVmPX1E1bwNhsKev0aJPXrbebIgnKkMo6VliqpafLZflK?=
 =?iso-8859-1?Q?ruxT7hrbZbYjYO4enP+4mzWGPF1g4UQ1PcCB9U8izrjBMrdTObC4Js3eQ/?=
 =?iso-8859-1?Q?DukH2ykHeS+h80g8ikth6c1oYlKtY0aBTn+SmBIKIWGfMfFqbk7OvELOp/?=
 =?iso-8859-1?Q?Il8OaIRkJ1Sska29DpP/WJdtjKf43nfqJyXRFCX51F1dzZCONkOdsuZu9Z?=
 =?iso-8859-1?Q?VdtbQPrmMQBehPJOWYOQmeAHYYJTNv/rw8PIdZzCkSnhotN9rSktkIBOi5?=
 =?iso-8859-1?Q?1f1Snc/EFSGtD6M78auxXv/X6S9pfx5vDpAcSHsTeseO/8lS1z7dFfbLFs?=
 =?iso-8859-1?Q?bV9EYXSWt2SuFUdYIHzkFct/EQsjaoiLhjZbBPMiTLqiUEsX/7cPgKJamq?=
 =?iso-8859-1?Q?HgXgj8kQ++gQSbiuBZwrXmcGUriFOJEGfWkWd6FJahikG/D7MQBjsM+EoG?=
 =?iso-8859-1?Q?G8N0pR+gcKvnPa8SrjVuRX7B4f8FI0Uvqj4Psu1nMJecHtBapkPgkzlzgX?=
 =?iso-8859-1?Q?ngLptN8kViZstTDAdqconhLRlgDB8DzMD9EArL9Kt9JtojGz8wgG9PEKd+?=
 =?iso-8859-1?Q?6/++VIp4a6meE2Jt1Q4IVel9JvsgxqMzMMEvOyPIjkNxlqntZipC4Rslsy?=
 =?iso-8859-1?Q?rflpv9bkv4fZ191F69+6/ot15RwDdobfaljoA1bhpNA8b8vcQLK9VdfYNc?=
 =?iso-8859-1?Q?q8wbueYuMWAI4dFEzwlqM1LyJl8eY7zD/taT7LxiZKEsMrrUpnSkz2Nuoc?=
 =?iso-8859-1?Q?5veceaIntOG31P0/k8v9nnA8DKjDfhE0KSZ1WQoae9L2s6inUE6bGOjur8?=
 =?iso-8859-1?Q?J6yEpiXIb/o4eXUunOYCPvzlSWSw6r4Z8uxjQ70VuEJQ/tvo+K6gE2ruK5?=
 =?iso-8859-1?Q?AYIL/yvCA+Mr5N/ugz3DooZCPyBiszpyr+YWr1OAw4aNiCXTWuvBspBdsR?=
 =?iso-8859-1?Q?Q/CyjJF3VDpOYaxncoLTOMojM8WhVSZ0vkrwOBkiGae1OfT/OKw20yJDVj?=
 =?iso-8859-1?Q?Vdrriwo8CRUSLMU79+HxUUapvjRXIqGtqVKizwlojfSDOkMaQUfhWuBSRF?=
 =?iso-8859-1?Q?awkpEiY1IRiQ8ONYLm25xYeOrlF11hW1UKcdvzih2spH3MONgWJWLBYlIp?=
 =?iso-8859-1?Q?1qCeOgGbNk+84CaVoGQL541/ZE3a0XY5jg578ft28IrorRO3dUv5ZfMFpG?=
 =?iso-8859-1?Q?x1WW47QnzS4aOfxyeQ7tkV+WhNsVKNQyTlv+SoHjWhVRq4VmIMyGuIYkrx?=
 =?iso-8859-1?Q?8hcpxxUjUKUPEDtvGuf5HcsWc/4B8cDCqk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b17a53b-b765-4288-3d9a-08dd56805e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 16:12:29.8463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejuMwKbl40gGkQZ2RUc300t0jaa72jLFnUnVnDMyCUqOZMyr0GLDtpq8O4czNNm6znegg7KDOKVgB+k/jYCg2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
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

Hi,=0A=
=0A=
From: Ophir Munk <ophirmu@nvidia.com>=0A=
Sent: Wednesday, February 26, 2025 10:38 AM=0A=
To: Dariusz Sosnowski; Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; M=
atan Azrad=0A=
Cc: dev@dpdk.org; Raslan Darawsheh=0A=
Subject: [PATCH V2 0/4] mlx5 unified fdb=0A=
=0A=
V1: initial version=0A=
V2: rebase + determine unified fdb based on FW capability=0A=
=0A=
Bing Zhao (1):=0A=
  net/mlx5: remove unneeded FDB flag on representor action=0A=
=0A=
Ophir Munk (3):=0A=
  common/mlx5: support FDB unified capability query=0A=
  net/mlx5: support FDB unified domain=0A=
  net/mlx5/hws: allow different types in miss validation=0A=
=0A=
 drivers/common/mlx5/mlx5_devx_cmds.c |   3 +=0A=
 drivers/common/mlx5/mlx5_devx_cmds.h |   1 +=0A=
 drivers/net/mlx5/hws/mlx5dr_table.c  |  18 +-=0A=
 drivers/net/mlx5/linux/mlx5_os.c     |  11 +=0A=
 drivers/net/mlx5/mlx5.h              |   8 +=0A=
 drivers/net/mlx5/mlx5_flow_hw.c      | 521 ++++++++++++++++++++++++-------=
----=0A=
 drivers/net/mlx5/mlx5_flow_meter.c   |  16 +-=0A=
 drivers/net/mlx5/mlx5_flow_quota.c   |   9 +-=0A=
 drivers/net/mlx5/mlx5_hws_cnt.c      |   9 +-=0A=
 9 files changed, 429 insertions(+), 167 deletions(-)=0A=
=0A=
--=0A=
2.8.4=0A=
=0A=
=0A=
rebased squashed second and third patch together,=0A=
series applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
