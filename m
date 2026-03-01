Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B021DFD0053
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 05:01:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CFD7402AA;
	Sun,  1 Mar 2026 06:01:02 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11022095.outbound.protection.outlook.com [52.101.43.95])
 by mails.dpdk.org (Postfix) with ESMTP id A4A2640297;
 Sun,  1 Mar 2026 06:01:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk6U8lfO6Io1hxj0W83U3SpvQdkh78mjn/2I270oMn2FgQnkeafHOM2i9Y+I1rm/5K7YYioZ7cSHCeU2UO+davJMtIg43hcOq1dl4kmqkNQ4LQjH7YRTNjKv2JWaM2cRkv8olp+YM9h7q0DZhsChdIE2NBm9QqdvLxdYexErQCVUaF1eL82+jpBYZm2QJZKRe5EO1Wpkr6TBbNd+JequwdHeTXQ/irLMiadx4PL7sWE7KaGJnZyOoJgBDUX/kHIApvcRc+ahCq31MayyGWRR4cYi+5u7Jz6z+XfXvo54YOghU68VM6P8FVjBFoYCupQiCn4TvihzRY9QQx9IVts6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/8xjg/BeCGs9WzGgLILCUQYFR8JZBe+38m91LSDOQo=;
 b=hBl9i0VdS5WToS7UvCOO6jAKkRN0LGhod0fNFXve2XPOfOPAK8rcXZ+ccWDosgH/0uICKKCah+geWyCflLnM3TSOjm+JvsQvWVQcMZ58+PfCbmWWPa7CocFzVYx+Fv7DzhuZHUAurslNVTW3p3NTJivAlQya7Bgvk2H6M9kc7c/usduLzcwvO9hfs/mLgjFatuly0DcE69EeUsVGF7ytVGyal6YEcDJpd9V4kuyjyRfWRoXypGRqB0em8ai0WtaFB7ltSy8q2hZfhjHHRTRMq0K2dqA15mN1Efg2xzcuaAHWyFUbeVIjm3pBIVcocF3/epDjAtyZdaO/EJ7vWgWD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/8xjg/BeCGs9WzGgLILCUQYFR8JZBe+38m91LSDOQo=;
 b=Bvnohyv2LTmfH9ZlVSytBqDhYghqqvklIZ0p3B2r8WzhlP/CtwjrwUUEauy1SQ5tnO9gEfyvXZGfuYZgrLuB2F+t0GzPQ307azPRsVIpuatqYgx23MlZ9okO6AhQXv70pPSRNdrLauTLih53pc0My6lI9RIWf1w5oxa33bjXxz0=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DM4PR21MB3370.namprd21.prod.outlook.com (2603:10b6:8:6e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.9; Sun, 1 Mar 2026 05:00:55 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%5]) with mapi id 15.20.9678.009; Sun, 1 Mar 2026
 05:00:48 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Wei Hu <weh@microsoft.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 0/7] multi-process and VF hotplug fixes
Thread-Topic: [EXTERNAL] Re: [PATCH v5 0/7] multi-process and VF hotplug fixes
Thread-Index: AQHcp4y7Yj452+HcVk2GmU8JkxJh2rWYWT+AgADIWcA=
Date: Sun, 1 Mar 2026 05:00:48 +0000
Message-ID: <DS3PR21MB57358192489D715C2A22E4A9CE71A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260227015928.14338-1-longli@microsoft.com>
 <20260228090335.222ffa79@phoenix.local>
In-Reply-To: <20260228090335.222ffa79@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eb296cbb-f035-458f-9544-b4298ebc8392;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-01T05:00:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DM4PR21MB3370:EE_
x-ms-office365-filtering-correlation-id: 927cf245-cf5c-4719-de84-08de774f80e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: eeumJxu0+2yhyzBbHHOyFuiGAYqxpZRn9kVJbqyxQ1X2VMkDVDdT5+jHbQi60rSjj6N4GQ29WXyvqAHPhMBNfA1k4b+U4EvSM+IGWyCEAVRGgpD8fGLjyEJZ/zTEWEw8H4/jcWJXiYLE/ur6J1aCPCC/adoj45Wv7xoDtQYjaTvxLuZvukujyv3jdo62qUjWDUCPdVDyU33dg3HzAOydoUQh9Vm83uCwQJRPJ1vw/VJlYrYTLpunVQNhyiXUpDYFofguO++EooLhl/TNOzopPPTKG7+y8EmkCX1wl9MPGTwu2CF8SFnRcgjo1CDKAIkSVaIKcGbt+ZSC+Gi1Egoak45sAWFaXL3FyWYYFQmFWKI7lRIYCkVd9UVATd1G9//wqv92pIhtAU41pUmEfd+ccChAI/scm3fcA7Jve8fhp3a8iUQZkQwthzWREdHC0cLSiYLU7xpmmRBav/eox/N97zBi2HS96jYpCINXpz1YUOQJV6dj/kAygiPoKb9u//b+sc9RHS7XLv2SfOF30pFF7/vUktIt9iyByOv/IS+O06qh0B/jVYui9hY4HOa63LUBmL+SLrH1AYoj+Um1SGqx0POTN+gTMjdchqaCGNsDVM26ibTIIutJ2jbo/6OsFtayzeCBJG+kOujYNjBXsNDnVKmwD3bzAFHmafjk3oA+j0XZ66n1CsaFUZWnBacQ9G+3K0Zj545DBA7IHvXs/gr7cgF3BWtQ1Xcj5xgWBCU/5waGRLaP+la36fE5sv4rJ8lDX3po5rBjYNV9iTQqZV1QsuHTkQe8mbdWfz+a09M+zeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LE+kQNO4zHHnrTGtN/JokL7BPhHmhIg77PXkl56DL7cx3R3lwOgNitdFveF+?=
 =?us-ascii?Q?Ok57Fwme/q8RhC7hCIn0uSS7xE2eMNHDLNijvJq9WH9ciODnpxaE9SxXylPG?=
 =?us-ascii?Q?k/3UEZ5KHd3SyOIGZc8Ysx/nk+O30c7bLf9cxYnNbJZY0NOPnPSlv7NAA5Go?=
 =?us-ascii?Q?d/9V5fvblYsT8WeaDsKdAmCilsHQhx87BaNz0YjDe7vTWEfy7UVisfwwwDCD?=
 =?us-ascii?Q?YOuZP0UAGp6VwrdNGwAGzh2mpmqt79AIInN5jl4LjBANORtLpQtYcM4jvQtw?=
 =?us-ascii?Q?gN6wrxrBKD//zeCpRjFU1A12CiYel5ABryn6AlBrzy/yemz8INm9GoQRt305?=
 =?us-ascii?Q?Z00CuBR+/41QIGqzxL7Mel37WrVzadbn32FE2kSpMjSpjy0MnRQH+iuRjkPQ?=
 =?us-ascii?Q?8/Xn7WeTeuLJFcOKvp8QkepDG5yC/YJHfkOMU8O+ukiyf3Aumq55LkVrljKd?=
 =?us-ascii?Q?k58P4jQO+HYJcj0RwyITg251IfvlO5rv9Rre6e0iGZ6gTXcix1fj/J7Kf8k5?=
 =?us-ascii?Q?zVWa4qGxuwyNu9TWzvIoqbLgJRRHtsKFQ90P3q+Ng/JZjrl1BStApu16N1TT?=
 =?us-ascii?Q?43D7GJ+336eqvMu8+InfvQ2XZoJ4ZqITwgeV6pC2IyYht52Xi2GUxd79oa9f?=
 =?us-ascii?Q?qNZLysLDfoLJAEb3cIaqU2VOfNz8Zi5agWDvHF0vX+BtpVO6WUQZSaUtT8bQ?=
 =?us-ascii?Q?dbI9Do7pccgnkMu/Nxi78lPkTSjL4+8WGmY53kPTJ64GXJ70d/NiIsZU4tmE?=
 =?us-ascii?Q?tC7GwI47P9CQRLmN3EbtjRl0KBRq4Zd8TvB9PtrSD6er7N/sk6Q/HFJ80voi?=
 =?us-ascii?Q?SXforaiqa+cA8c0+Uk6XwCYRJpHe4p2tp18cfPK3GlSctXMBYWtLk8jUuY1G?=
 =?us-ascii?Q?7U8khnRpXSRMVWBca9cTonHi23CAmbm6vn3e1LXBmwUx1qkH75nVLYvwUL2D?=
 =?us-ascii?Q?yR/HE2QUQQPaQMRhQNTAVZU+Mi6wPHHF+h2OZ5FlubAKzuTO6ktoz6zK9ajz?=
 =?us-ascii?Q?ntd3Y0jXataqnHCAGxPoss7hCQkHE/MsFzBWz38GiIpvhx16lwB6QKZw+UGW?=
 =?us-ascii?Q?IPrQLjFKfDNrw8kYTAtgLAq3ZtUrHqAJB3q59k3we5UwpFDCP8qnzPTEWkE+?=
 =?us-ascii?Q?gALuaol3kxrfwOfkxVMnSUmXjRj9+MjSXVU/Je2jo179Zj9KPk/gQd9Yz3X8?=
 =?us-ascii?Q?qImbzzNHglArX3FASXFM7VfTFq3AUWA4AvDbr/LbDRpxYkLfRAIhrnmIsK3G?=
 =?us-ascii?Q?f6SpaO6ioCS++C8AUg4TKi5/FG8PXL55TGJqy9U5EY50QEoGihHOVnvggay7?=
 =?us-ascii?Q?Yfw4LhxiMyMzDhxm+FxciSFa+Il90JxBHBNBZGdqIKHKhzXVJtYlDgLhqEhn?=
 =?us-ascii?Q?U/1WU5QtoruJKDFysZNSWKHfArf6HdW5B5aE+6OgtuMT56WCwE+9smRUNY9r?=
 =?us-ascii?Q?vQAayE2iDxO12pzJjLrJZzTjhH2mjXMWnG5OMzt8tQkZxnoHPQbYJoi3GTKk?=
 =?us-ascii?Q?AMtfqCw8DSMYHIzjQlASnsNdZjnL8Ic3lMx6bbtmepehC/dRSmN5yK0gLaaV?=
 =?us-ascii?Q?J0F+rVE/J10K26EfhAOXRe8vjIVTpM0aFGSrAd1fmMQ4etn8XbAYxRSQdYlb?=
 =?us-ascii?Q?6gSaNGDH5YlKn5HHPJ34XTP9OBN3DuMaIeBRObivpwqgceeagw1JMwOsJbcV?=
 =?us-ascii?Q?25c8QBMo+fGY2b52w6DfoLtvs1YfXVCXuxwD8+4wKmQ+BQYd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927cf245-cf5c-4719-de84-08de774f80e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2026 05:00:48.1471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKlsBk7WxE3xMbP+J1i3Eal2bT1i65mR7eQh5yZSeL1iKqvnRg3jtU+8EbfxHZATZ6m4NviSx97AoOmVW/tzMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3370
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Saturday, February 28, 2026 9:04 AM
> To: Long Li <longli@microsoft.com>
> Cc: dev@dpdk.org; Wei Hu <weh@microsoft.com>; stable@dpdk.org; Dariusz
> Sosnowski <dsosnowski@nvidia.com>; Viacheslav Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Subject: [EXTERNAL] Re: [PATCH v5 0/7] multi-process and VF hotplug fixes
>=20
> On Thu, 26 Feb 2026 17:59:20 -0800
> Long Li <longli@microsoft.com> wrote:
>=20
> > Fix several issues with VF hotplug and multi-process support in
> > netvsc, mana, mlx5, and mlx4 drivers:
> >
> > - Fix race conditions between VSP notifications and DPDK device events
> >   during VF add/remove, with proper locking of VF-related fields
> > - Add multi-process communication infrastructure for coordinating VF
> >   removal across primary and secondary processes
> > - Fix Protection Domain resource leak on device close in mana
> > - Fix devargs memory leak during VF hotplug in netvsc
> > - Fix fast-path ops (rte_eth_fp_ops) setup in secondary processes for
> >   mana, mlx5, and mlx4, ensuring burst function pointers are restored
> >   after STOP->START cycles
> >
> > v5:
> > - Patches 5,6,7: Also restore rte_eth_fp_ops burst function pointers
> >   (rx_pkt_burst, tx_pkt_burst) in START_RXTX handler, not just queue
> >   data pointers. Without this, after a STOP->START cycle the secondary
> >   process burst pointers remain set to dummy functions.
> >
> > v4:
> > - Patch 1: Check hn_vf_add() return value in netvsc_hotplug_retry
> > - Patch 1: Track fresh_attach to avoid tearing down original VF
> >   attachment when configure/start fails on an -EEXIST path
> > - Patch 2: Move counter decrement and netvsc_uninit_once() after device
> >   cleanup in eth_hn_remove() to prevent use-after-free of shared data
> > - Patch 2: Clear netvsc_shared_data on init failure paths to prevent
> >   dangling pointer
> >
> > v3:
> > - Fix review comments from v2
> >
> > v2:
> > - Initial rework of VF add/remove locking
> >
> > Long Li (7):
> >   net/netvsc: fix race conditions on VF add/remove events
> >   net/netvsc: add multi-process VF device removal support
> >   net/mana: fix PD resource leak on device close
> >   net/netvsc: fix devargs memory leak on hotplug
> >   net/mana: fix fast-path ops setup in secondary process
> >   net/mlx5: fix fast-path ops setup in secondary process
> >   net/mlx4: fix fast-path ops setup in secondary process
> >
> >  drivers/net/mana/mana.c             |  14 ++
> >  drivers/net/mana/mp.c               |   8 +
> >  drivers/net/mlx4/mlx4_mp.c          |   6 +
> >  drivers/net/mlx5/linux/mlx5_mp_os.c |   6 +
> >  drivers/net/netvsc/hn_ethdev.c      | 300 +++++++++++++++++++++++++++-
> >  drivers/net/netvsc/hn_nvs.h         |   6 +
> >  drivers/net/netvsc/hn_rxtx.c        |  40 ++--
> >  drivers/net/netvsc/hn_var.h         |   1 +
> >  drivers/net/netvsc/hn_vf.c          | 148 ++++++++------
> >  9 files changed, 437 insertions(+), 92 deletions(-)
>=20
> Applied to next-net.
> The SHA hashes of those fixes tags was off; fixed them by matching on the
> subject.
>=20
> Also fixed a couple checkpatch warnings for:
>=20
> CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
> #295: FILE: drivers/net/netvsc/hn_ethdev.c:1763:
> +			rte_atomic_fetch_add_explicit(

Thank you!

Long
