Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A85BE9E315
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:38:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72AB9402D5;
	Wed, 11 Feb 2026 15:38:56 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by mails.dpdk.org (Postfix) with ESMTP id 80C9640297;
 Wed, 11 Feb 2026 15:38:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mL3iNsqASqit9xysg3zKtFho6KoOAvpGRvNH03BlTVY7ocAu+kbuBA5DHPazZXiDzuCqIi5yqJHcELIY2/kdHid/0vhp66DZ2CTdl0d2fz3MwCNzUJJ1avmoif5dLsgyek4N7H1hNG9xKlziBuY+bkpVGPfp/YM70/EWRSQ1XGT68m2DyH+XtyHyCfchDtulRaIeHAYMm9q+x6OouHK9ZANMOFL62DEEizLR7B8QSDv2OZEBcLLjdvccfjBsBPT5kQ8EuxgsV8R8zkH8p+xKlvgZizXBCUEYafpVJvOb9ol0BXj9Fu2I5kEVcxal61dD2ntvEpphNq9Caf6nmt6BMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMZSwpW16J1dqpdN/ebALv1K8Vd/pKNCsMVVpr6hn2A=;
 b=RywaMEpZNRlpVaSAjFztjDdntf0rl335t9l1SUrWOc8/OR/ykCMXgcQZmnS/V8S/6oFRXpsjzfAlAPqB+q55SPLnR33crhY9IpsDk/wmbpC1lE7N7i+TjpD4BL+Cw1gSi0XiFM8L5tCXZdH2Dc0derJf0rbo7xSuyXDUbLTuoXHCMMofSuHCjZ/rLJ7f85DU+lWOpfnrMeFFwdjgjfKnKRtdHtOOqet5DDEGqIxeyMX1TIiRPBiIBJO/rxI/bxqhkzj5fVZmZRBO9nk6x1oAYqMn4kgROedjpV0Od03VLf8RNMJD+6SxpvrToLpnByvFK4njTAJqAbbdxgcQrqzAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMZSwpW16J1dqpdN/ebALv1K8Vd/pKNCsMVVpr6hn2A=;
 b=SgaJeuthoQiU25CLwK/GIemNrriVyKN9V3sEVpj/AA4CqDixz+qDlo6rMGVz9KNm3El1eClRUVr4dISnl0A/8jCmvra8SSPD65XodcD10Oko9DK3pO7pmDtzH5RbWU3Jdt4fV8h2weWbTqx/mFfgi8lJ4GNV2L7fl0pIr2w+UURnADKi7kr54FBzmOiMTFcTG5qUGTiDsGnF00ZDtdPEwfTqYkw12D0B+4GCYhuoPfvcE7SE+fUxFMM8grT2tm41YQ+9uZ5ML1/ErRm3UGvkCHRZGFzc0AjYyqsdkfSWiTA9tsFvbi2JErD0KTAONDY60sjoz1wv0U9QecRe3oXiMg==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 14:38:48 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 14:38:48 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [PATCH 2/4] net/mlx5: fix default memzone requirements in HWS
Thread-Topic: [PATCH 2/4] net/mlx5: fix default memzone requirements in HWS
Thread-Index: AQHcg6VaM3IiJJG2h06/UqSdQoQQSbV9v+jw
Date: Wed, 11 Feb 2026 14:38:48 +0000
Message-ID: <IA4PR12MB9763A759C90A785344346BC0D063A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
 <20260112092439.14843-3-mkashani@nvidia.com>
In-Reply-To: <20260112092439.14843-3-mkashani@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|SJ2PR12MB8009:EE_
x-ms-office365-filtering-correlation-id: 8fe94b91-268b-493a-3b12-08de697b446b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rnuDhTPP8WnMKvv6UyvgrJSCXsfgnEK+g7bjsTIj9mwYnI6e4cZHYId24bzr?=
 =?us-ascii?Q?X3wL5QxBS9B7gZA00dOSYzrmfpm33L6l5FV8ugqfkhmChdlrOaTPkQMa+WIF?=
 =?us-ascii?Q?eCwCUyQbWqcB7mmzR6Fd9jfvpD7Ej0QthMO9hgKsWyvT1ult5urObXW7Mfg/?=
 =?us-ascii?Q?k9fQPxkD9rOkaf6Q4RltcVRzZTgRj/fsFZIzGU/CQdB+YV0PIt7x+iIr0uZ+?=
 =?us-ascii?Q?5O0I4xfcGA1cCVJT9vSw8zz/Z/m6TXKIOVwVXicsPzf3BMgunohalqtMnXDn?=
 =?us-ascii?Q?M5fjCYFVMz6lCMoOZl9TiDhhPAgJ+/gzXOO2BkUp5OM5Fkv0OzdMh2TtmleR?=
 =?us-ascii?Q?yyxL6JZcqA49mhWUxUtq78qrtf0kTjtSgRasBCpzt6cEQrWpPc3+ud1JhnMc?=
 =?us-ascii?Q?YbPIrdzXc1FVaIbey+996ioGFP9m71u6X1OE+IkDRDrolvqwns7+27o/bn39?=
 =?us-ascii?Q?ZsQqvw4waXZhzgLwxb894f5E7GCWVbjlRC1nkmaj0MDbfALopgrA0ihsKg1u?=
 =?us-ascii?Q?fY0CRw6hv+mh0Kw38CaFe65FPNxZKclrBvyJS0vneXWLn7wzrTiZ7CDc68YP?=
 =?us-ascii?Q?R8xhgUEjylwqbXcZzB65PwRxYL/Iq6sczt+82r+mzD3vd5UwP3fp1kYvQwjz?=
 =?us-ascii?Q?b9IJfFrwQgb8rpvYv6WaU1Muuq5CT0zsfgx8uim/qEcT3h6p+iBI4Cva2hgc?=
 =?us-ascii?Q?2w9WP2Pch2XYpGjN4rgbMLxwK5z/97Vz+eNLjKSfrFQ6D2iDmbq8wj/0Wp5L?=
 =?us-ascii?Q?Dv0G2BIprXCsbqG/h3OQRLqXF7ovzQH6sDkXNUHiBpud7iUYQgs/5oaQwL9H?=
 =?us-ascii?Q?Fxyqzik5ECIRbAkZVEK1Zqhk/huZo3E0vPw5c0WngEGPZptSRWKMICMb05pP?=
 =?us-ascii?Q?2ywHOJJ2C7uaaf7jVpS1WqOjfq5LWM0UtYUEjO33sgHU+2ylm+ajqoZwYoA/?=
 =?us-ascii?Q?lJ6A1+lN0VMETcqLifaGQShTWHcckPT5jyv0urJAhtB5B3pCYApnZfk5j1LY?=
 =?us-ascii?Q?0MJi85Jz3BuFXUNrA5buVldY1gKsUw8bR3UNIca2QAz3tuUAZ6qB2+g6t+BY?=
 =?us-ascii?Q?Xq2Qx5dFcsPMo+IeTRlxwVP7Z7ndzHtTZtmzTu1Rg7IU2zNXL+UD1Jh+4PpY?=
 =?us-ascii?Q?/mqW6bIYRSSSD6bv09ofaHN8Hvjaru9d5L4PYBgIuM/gD/XhSsrVajGCUoKh?=
 =?us-ascii?Q?KGsOUsaOVDxZVbcudyT9An+1bNAICTUzFHjfHsF6MXV5zT2lwZtrVh4hr/lr?=
 =?us-ascii?Q?F26MISNtbJ8ixseceKsxSe8DDjVY3pdwUmw45Dw6SU6ZOVpCiGvPud1EjKto?=
 =?us-ascii?Q?72+OIBy4k7Scc0+PDsEuMUaT13oC3HSGQqtRepQyzUQ/lmidRHpfDvT24E9i?=
 =?us-ascii?Q?vwIvJdXAP7qbEAUODpvK5ItjXEpyBCIHtUAY9F3NmscqOnKy4qADbZ68dnK7?=
 =?us-ascii?Q?kIXlyZHHlrO91dr5wiUnrzOI/sFUJOj4pB6SPK+USSJPOhH1SpU9BuLYwQ5v?=
 =?us-ascii?Q?9W2evlQw4T/GpD172TGt93Em67gJMX6GIq3IhGFrs0mtD5pjnAF/Yhe2weFl?=
 =?us-ascii?Q?EV+V2VzEC0/pYkk7oWkLQ9Fc7Yjt7bAMxlqA5zAhFJPC/RNXrKbvqmzogQYL?=
 =?us-ascii?Q?pkOL704ssWXodWwb7fP0lVE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pvx0MbOp+q26xV1Y7wb0LsmymRyiz90B5nZu9BOT4h6MWeu5vLrsiYuEqRWF?=
 =?us-ascii?Q?mweEJoEE//iVqEJzrnUM92XCbrGaLtBfEhork8ghSJu9TGxMXiXNMhmoOg7A?=
 =?us-ascii?Q?ckNl215Cc3Fw47Os+Y/HgYUgkwo1OI1GKU30Nra6u/IkLYDhXFcszmN3mzdI?=
 =?us-ascii?Q?D+9DzORLaWhlEP4WHw+xHxshcGGmJdOzFZYmRtwujySr84NVxS8ksIdbtuFP?=
 =?us-ascii?Q?waapfK9ECTu5BK01qDieFYitFSrWuNaMLBCJZqdLC2em0qZlDMdSOMSEJE08?=
 =?us-ascii?Q?NtzQyH7mLZoJHvygHc9XHurijoZz93fOuUl/OO24wfcDpyoQyEg947ixKUK7?=
 =?us-ascii?Q?9WNfqdMl7ImugkMrJsuuoj5FvApVffqODZgruWvSGTJCWnKRoWSP/wFgqvL+?=
 =?us-ascii?Q?jOvTd0mZQgwPwsL8eycuRdfZL0h84Cd4fZZQln47DyLuEGcY8qKEhSTjnpI0?=
 =?us-ascii?Q?NlmssAxzqrwoS5e65btO53gq53uD9MLJxRfEa8cC2cNk/R46vhXJW5Hp1oxu?=
 =?us-ascii?Q?KePwYhab7/yVfq67HBN0gaN3dNe/4K1bkBVhtBTdZB2l6ZTTYp+SujrEDY6n?=
 =?us-ascii?Q?bUEHtca+gunx2hw2h3iGAk5dPWaadZZfKCA+udngsIVuoLeN5BVXhTm/0AON?=
 =?us-ascii?Q?FHbiO/LJ4AEfhzNFD2w7OtJh/6+KpEqZxPz7dHwJu1RwyFyCYlSdL5PnaKDG?=
 =?us-ascii?Q?DZXFqc5uzbuo/8jcAWMZm4H6rwM0D2IvqdKuvUJYb8lqRkcJ+Xq73KO08XNp?=
 =?us-ascii?Q?zj/QZzvL9osQFB5w81DKkSIdCLJzca4P4a6F33kSFOttK7c8uHKUS5+Hv8an?=
 =?us-ascii?Q?bdHiUPWBkilHi07KantHhMgAudPmQW/68ZQxGAGN/5KAbgRTEKCbXxijSkcE?=
 =?us-ascii?Q?JCArdmXhTd5NSPUeC61YdNEDKOZLwNtopHmNI8IMzDY9Z5Nj+aPY2B1/Lujr?=
 =?us-ascii?Q?eL8ewtPMjfhJzb2+I01cH1pvGzGq5RJIDLG2+fgi2RcGp1a5xuEoOAyXC075?=
 =?us-ascii?Q?0+VOOjo9wgQlKHPtCV5K8ynVvtbFv1iwqcu4OPAiZOV3zCF/Rk0IdorezkWP?=
 =?us-ascii?Q?3g7bNuAzi59/XfTWFAc92dFq1j56PNzzscl849HldjBojsqaANAf9FklH+v9?=
 =?us-ascii?Q?/mSszNY+/w89L64GqLs2WhtzT89+lNMMjoMEbDGOGxatTu+GNuwE8exwVG2M?=
 =?us-ascii?Q?9ijTdQ70C7szTlow5TT/O5JPIlwuIE1DqvzR99DC2wstnY8EgoIGWQoFsD8u?=
 =?us-ascii?Q?Dj8fUxzS37n7UuYV38EIUw3sGLV+X7uLZ/jhsXN2AB9yvGkLe1GF2u9hFw7R?=
 =?us-ascii?Q?/hdMkCIo8bTuP4Nr73qOpwT08HeHvksRMDlqgBlCZ8ULsPf7ZTsFRpvM6fID?=
 =?us-ascii?Q?5Q1/+537YMK0VdF3tJxcJ9JbcSJK+y/r1wmhE0rPeMTOC7Rf/AufWNuyHI2u?=
 =?us-ascii?Q?g9ueWemwUfTU/izWMkw9VmKfr5hmmtPFWGdiZeFxAmsabTaACmHnL60ml/pK?=
 =?us-ascii?Q?pNkZyieec5cL093fyfoR3GgA6quFj5/JXb5ly08hNYloGOrl2J/WaonnWM5P?=
 =?us-ascii?Q?wmeqTVw0CD1KPeOlYPuT1txgXXe6Yjq4F89jArIjaiYDr+ApQtZ+8zh9Cj/e?=
 =?us-ascii?Q?yhj8MSZRRc1MN2WPxJKpTWUWYAPkoAhXCDOTLzdpJPEyq/Qtv3xerLylnruk?=
 =?us-ascii?Q?sc77wqh/Ghf+ialE8xya2/PVvjN2+iqd8g3tLsfNAU1jpJM50y1KecHhKXCP?=
 =?us-ascii?Q?kFpi789+QBiDY0DTsZa3lGqJ1gGQB8NmEwnwkxIY9lGQtPiDIdyZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe94b91-268b-493a-3b12-08de697b446b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 14:38:48.2407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: md28FIEoztnlxWzA2cPvE89emNWGqeNlPA5J3Q6qF/iZYzpyeuGspzk0GZe64pJ49Gdw0AWb3sTRQ6/9cbvoRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

Hi,

The code LGTM.
I am thinking that if the user wants to use HWS for up-to 1K SFs, we will s=
till reach such limitations or if the application try to create some rings =
per device. Maybe in the log we can tell the user try to use some API to re=
-configure the maximal memzones as a hint. WDYT?

> -----Original Message-----
> From: Maayan Kashani <mkashani@nvidia.com>
> Sent: Monday, January 12, 2026 5:25 PM
> To: dev@dpdk.org
> Cc: Maayan Kashani <mkashani@nvidia.com>; Raslan Darawsheh
> <rasland@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>;
> stable@dpdk.org; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Subject: [PATCH 2/4] net/mlx5: fix default memzone requirements in HWS
>=20
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
>=20
> Commit [1] has changed the default behavior of flow engine selection in
> mlx5 PMD to accommodate for new NIC generations.
> Whenever underlying device does not support SWS (e.g., ConnectX-9 or
> untrusted VFs/SFs) and device does support HWS, default flow engine would
> be HWS (dv_flow_en=3D2) which also supports sync flow API.
>=20
> This behavior change had consequence in memory usage whenever SFs are
> probed by DPDK. In default HWS configuration supporting sync flow API
> (i.e. without calling rte_flow_configure())
> mlx5 PMD allocated 4 rte_ring objects per port:
>=20
> - indir_iq and indir_cq - For handling indirect action completions.
> - flow_transfer_pending and flow_transfer_completed - For handling
>   template table resizing.
>=20
> This has not happened previously with SWS as default flow engine.
>=20
> Since a dedicated memzone is allocated for each rte_ring object, this lea=
d
> to exhaustion of default memzone limit on setups with ~1K SFs to probe.
> It resulted in the following error on port start:
>=20
>     EAL: memzone_reserve_aligned_thread_unsafe():
>         Number of requested memzone segments exceeds maximum 2560
>     RING: Cannot reserve memory
>     mlx5_net: Failed to start port 998 mlx5_core.sf.998:
>         fail to configure port
>=20
> Since template table resizing is allowed if and only if async flow API wa=
s
> configured, 2 of the aforementioned rings are never used in the default
> sync flow API configuration.
>=20
> This patch removes allocation of flow_transfer_pending and
> flow_transfer_completed rings in default sync flow API configuration of
> mlx5 PMD to reduce memzone usage and allow DPDK probing to succeed on
> setups with ~1K SFs to probe.
>=20
> [1] commit d1ac7b6c64d9
>     ("net/mlx5: update flow devargs handling for future HW")
>=20
> Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable
> reconfigure")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_flow_hw.c | 86 ++++++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> b/drivers/net/mlx5/mlx5_flow_hw.c index 98483abc7fc..1dada2e7cef 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -4483,6 +4483,9 @@ mlx5_hw_pull_flow_transfer_comp(struct rte_eth_dev
> *dev,
>  	struct mlx5_priv *priv =3D dev->data->dev_private;
>  	struct rte_ring *ring =3D priv->hw_q[queue].flow_transfer_completed;
>=20
> +	if (ring =3D=3D NULL)
> +		return 0;
> +
>  	size =3D RTE_MIN(rte_ring_count(ring), n_res);
>  	for (i =3D 0; i < size; i++) {
>  		res[i].status =3D RTE_FLOW_OP_SUCCESS;
> @@ -4714,8 +4717,9 @@ __flow_hw_push_action(struct rte_eth_dev *dev,
>  	struct mlx5_hw_q *hw_q =3D &priv->hw_q[queue];
>=20
>  	mlx5_hw_push_queue(hw_q->indir_iq, hw_q->indir_cq);
> -	mlx5_hw_push_queue(hw_q->flow_transfer_pending,
> -			   hw_q->flow_transfer_completed);
> +	if (hw_q->flow_transfer_pending !=3D NULL && hw_q-
> >flow_transfer_completed !=3D NULL)
> +		mlx5_hw_push_queue(hw_q->flow_transfer_pending,
> +				   hw_q->flow_transfer_completed);
>  	if (!priv->shared_host) {
>  		if (priv->hws_ctpool)
>  			mlx5_aso_push_wqe(priv->sh,
> @@ -11889,6 +11893,60 @@ mlx5_hwq_ring_create(uint16_t port_id, uint32_t
> queue, uint32_t size, const char
>  			       RING_F_SP_ENQ | RING_F_SC_DEQ |
> RING_F_EXACT_SZ);  }
>=20
> +static int
> +flow_hw_queue_setup_rings(struct rte_eth_dev *dev,
> +			  uint16_t queue,
> +			  uint32_t queue_size,
> +			  bool nt_mode)
> +{
> +	struct mlx5_priv *priv =3D dev->data->dev_private;
> +
> +	/* HWS queue info container must be already allocated. */
> +	MLX5_ASSERT(priv->hw_q !=3D NULL);
> +
> +	/* Notice ring name length is limited. */
> +	priv->hw_q[queue].indir_cq =3D mlx5_hwq_ring_create
> +		(dev->data->port_id, queue, queue_size, "indir_act_cq");
> +	if (!priv->hw_q[queue].indir_cq) {
> +		DRV_LOG(ERR, "port %u failed to allocate indir_act_cq ring for
> HWS",
> +			dev->data->port_id);
> +		return -ENOMEM;
> +	}
> +
> +	priv->hw_q[queue].indir_iq =3D mlx5_hwq_ring_create
> +		(dev->data->port_id, queue, queue_size, "indir_act_iq");
> +	if (!priv->hw_q[queue].indir_iq) {
> +		DRV_LOG(ERR, "port %u failed to allocate indir_act_iq ring for
> HWS",
> +			dev->data->port_id);
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * Sync flow API does not require rings used for table resize
> handling,
> +	 * because these rings are only used through async flow APIs.
> +	 */
> +	if (nt_mode)
> +		return 0;
> +
> +	priv->hw_q[queue].flow_transfer_pending =3D mlx5_hwq_ring_create
> +		(dev->data->port_id, queue, queue_size, "tx_pending");
> +	if (!priv->hw_q[queue].flow_transfer_pending) {
> +		DRV_LOG(ERR, "port %u failed to allocate tx_pending ring for
> HWS",
> +			dev->data->port_id);
> +		return -ENOMEM;
> +	}
> +
> +	priv->hw_q[queue].flow_transfer_completed =3D mlx5_hwq_ring_create
> +		(dev->data->port_id, queue, queue_size, "tx_done");
> +	if (!priv->hw_q[queue].flow_transfer_completed) {
> +		DRV_LOG(ERR, "port %u failed to allocate tx_done ring for
> HWS",
> +			dev->data->port_id);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  flow_hw_validate_attributes(const struct rte_flow_port_attr *port_attr,
>  			    uint16_t nb_queue,
> @@ -12057,22 +12115,8 @@ __flow_hw_configure(struct rte_eth_dev *dev,
>  		      &priv->hw_q[i].job[_queue_attr[i]->size];
>  		for (j =3D 0; j < _queue_attr[i]->size; j++)
>  			priv->hw_q[i].job[j] =3D &job[j];
> -		/* Notice ring name length is limited. */
> -		priv->hw_q[i].indir_cq =3D mlx5_hwq_ring_create
> -			(dev->data->port_id, i, _queue_attr[i]->size,
> "indir_act_cq");
> -		if (!priv->hw_q[i].indir_cq)
> -			goto err;
> -		priv->hw_q[i].indir_iq =3D mlx5_hwq_ring_create
> -			(dev->data->port_id, i, _queue_attr[i]->size,
> "indir_act_iq");
> -		if (!priv->hw_q[i].indir_iq)
> -			goto err;
> -		priv->hw_q[i].flow_transfer_pending =3D mlx5_hwq_ring_create
> -			(dev->data->port_id, i, _queue_attr[i]->size,
> "tx_pending");
> -		if (!priv->hw_q[i].flow_transfer_pending)
> -			goto err;
> -		priv->hw_q[i].flow_transfer_completed =3D mlx5_hwq_ring_create
> -			(dev->data->port_id, i, _queue_attr[i]->size,
> "tx_done");
> -		if (!priv->hw_q[i].flow_transfer_completed)
> +
> +		if (flow_hw_queue_setup_rings(dev, i, _queue_attr[i]->size,
> nt_mode)
> +< 0)
>  			goto err;
>  	}
>  	dr_ctx_attr.pd =3D priv->sh->cdev->pd;
> @@ -15440,6 +15484,12 @@ flow_hw_update_resized(struct rte_eth_dev *dev,
> uint32_t queue,
>  	};
>=20
>  	MLX5_ASSERT(hw_flow->flags &
> MLX5_FLOW_HW_FLOW_FLAG_MATCHER_SELECTOR);
> +	/*
> +	 * Update resized can be called only through async flow API.
> +	 * These rings are allocated if and only if async flow API was
> configured.
> +	 */
> +	MLX5_ASSERT(priv->hw_q[queue].flow_transfer_completed !=3D NULL);
> +	MLX5_ASSERT(priv->hw_q[queue].flow_transfer_pending !=3D NULL);
>  	/**
>  	 * mlx5dr_matcher_resize_rule_move() accepts original table matcher
> -
>  	 * the one that was used BEFORE table resize.
> --
> 2.21.0

Acked-by: Bing Zhao <bingz@nvidia.com>

