Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC33D4A5F4
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 03:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F21440E35;
	Fri, 16 Jan 2026 04:11:03 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by mails.dpdk.org (Postfix) with ESMTP id A0F7D4014F;
 Fri, 16 Jan 2026 04:11:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSDrJomgbyoHCTFg4bV9NKhNuHFioFfE7U0LQdfqX0+Ci3MtLRvmDcfISi2MFgM4tX+lp+f1d9SaOsBoEJ0AhQ7GmvFliFAxiCSnXoY0TAG/PUV88R5wy8dlK8l2/ORmhoUyWs+C45roDDXMiqQFqeRtYMcMlkagR1lpqVTC+c5JE4rMblApkcUSfRn01GndOM1kbJ2/R0xdz+JcKP/GMlEYlzO3fIWYELnIX4dDSK6ju5Yvljxl1ssHdptykGRTQc5H3zVTLeTc+U03i2piW5epu79nm1O5HtHGrQ3nCYpr2oieON2Q1DF6D42Y/mC6kpt3P5PcXSuHqYyeUBCb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byCaHG4E4kB3jwEiyZU1wUZujXrYrz31LYTdxah3IhI=;
 b=NgAAmwrd4p0WMAqsXNn4Fmnf2ZuMVZRkbQbgJ2z3eHYtQfxHv3vJSdnaY9Go6Lu72jkVtMw51a4vlkf3KsNZxm6fvZ/O/WyRQm/da1STZQAQnDRTgrvPfyKGUeT4YjqXAG/GE/RI3ieCrEzcBSB79ewPpv5Wy0Q5FFnQ5lTk7M4eNRshgXMFVKu2x9dd7xnQWR+fPCcWVsGguIGqwIQ7DILGhyenTWaI0Kkf8+7HIZx6/1uOSxMFH20Zs0YHJLK9JGxJ8q/WqY6xGKzoBHrXj+Kw8Y2CqDvw9MVO6Uy+gG6/HaWWdVzGHBwskWHWEUIIIgTLYbpoAYOgp/HJry9Few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byCaHG4E4kB3jwEiyZU1wUZujXrYrz31LYTdxah3IhI=;
 b=OpQCvJQA6XbAlDszH2P+uuoe3CjgUD2iv4yYjOjtEsCxLnRWPc3YQ0h0V2wv+RZY/oiCUxKyHbo+TLZ/wlBncP/g7Ww/08XoaKm2xaWPekSfLSBuS7VWL+wt+DGlINCHvvZAEjAnrt3gpyww1PFXL8Q4+GXYpPl//K46Y5Lph+nma9jZUOItfowAwyJ3Do9T0DmuWyxvH8tt3HDMrbjAY5aaSXebZVNaQkYNdPqA/8ptvB7d8v+hwd8Uc4m5bOJe/vThYlCYciKP2sJO3GIdCyq7OOhYypfb/AdbsRkTPaVvLNNAiqoZHt5GGC7il3JbuTidwMK0SdG1ta5tbl6ekw==
Received: from BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:10:56 +0000
Received: from BN9PR12MB5098.namprd12.prod.outlook.com
 ([fe80::78ba:2665:1445:6730]) by BN9PR12MB5098.namprd12.prod.outlook.com
 ([fe80::78ba:2665:1445:6730%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 03:10:56 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH v2 2/3] vhost: fix descriptor chain bounds check in
 control queue
Thread-Topic: [PATCH v2 2/3] vhost: fix descriptor chain bounds check in
 control queue
Thread-Index: AQHchWtdu3St89aTsUGVfo1qephkPLVUIJMA
Date: Fri, 16 Jan 2026 03:10:56 +0000
Message-ID: <C31A9CAB-B090-4422-A567-C803D1B6DEE5@nvidia.com>
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
 <20260114153445.2751895-3-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-3-maxime.coquelin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5098:EE_|PH7PR12MB8014:EE_
x-ms-office365-filtering-correlation-id: 61ec9fbb-dcd4-4354-b69f-08de54acddd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?HsduPbsYPOkshFkDvIDPXRkfeInegrBSs8eQSX1iyNN8vHrAzYjzEhylwFI7?=
 =?us-ascii?Q?TY0sQxW6gkRCx/8tGHn6Abo2MX9Xi3LWDkOM17aqi5yU1MKYBqQuykIai3Wn?=
 =?us-ascii?Q?u9WW6+ndZNcH9LdBIp46EKCYzRFwj459paqw0ezKGKws5MkuKH8etPwbbW0F?=
 =?us-ascii?Q?WjijVug1h/satAAllrYWd5BXAXAycFUgEbTs0tcHE23ZZxk0upBbbLzLKX7y?=
 =?us-ascii?Q?eSOJsCbXwwKFMs0tYu+3lP8WVOXf8EiUPuxAPJDJzEe/jYcVdPmw7flirUka?=
 =?us-ascii?Q?bygs4Pb050n5r9xXNP652QoqxXmQWPoMjc7rzuAnk4XXQl5Ury3At1uJ9ICh?=
 =?us-ascii?Q?lehY3feu6c2p8AOBsISEqgIbNbIGJddZWkx6rzvaChB79Xsoz5V17hXzKQww?=
 =?us-ascii?Q?/j9iwefjcTmbXqlfmFWDspKnoWE1sP4sR3QAXYBCqrsGXDj19UoGOP2sXKMY?=
 =?us-ascii?Q?yP5PLD1DoG1aajRlk22Wb2lrkAUxXv8ZIdqEcBFtPkzsMQ0KopTYJbJm/AuP?=
 =?us-ascii?Q?T7CwJDZqjkuq1P/HrFC4Pk7gI878GP8XjVhQfj+QIMUkgha8xI3d6w2Vtg+x?=
 =?us-ascii?Q?x/8bMIZfCAqwbBYNVnLujEi9DC7YjgVWELHmLtoEPvqtJjz3DFTa/kvns+pA?=
 =?us-ascii?Q?CEQN5rhxazY/MwCLF6QEG4PJ+CUDQbVgG5tThAD9+2FrVQkpmG3HreSAu4Hv?=
 =?us-ascii?Q?JbKP31KdrpUCGz/RsG8vPnsRzCb8841iYb1VmECkGa+F+cM9iNKxBLcpG2Hb?=
 =?us-ascii?Q?F0WhcrYv4cnXW9V0ZfBW81ulBOOMmx241Aa1VcytxJ5iBrkZRULGulL8TXdP?=
 =?us-ascii?Q?Qd4vdII2Wrr+fpV8N/DGVJa9o37hWnS0s6PpgwBtHbQlj2P/K26qIuP1nDwt?=
 =?us-ascii?Q?Cf5+YfOnMiPRwhlZ/abGoSZp6rP81dX4+Y33ul0YwHRH9kTTouB1Zjn8mP2t?=
 =?us-ascii?Q?68X8OfaT58dHfhc1N9dtofHDSenOxIJaGRGQT5hmkY3Qs5CAeHvqHS3ece3p?=
 =?us-ascii?Q?ncApo5rtsp2ZT/bz/6WTWZ7NnckGf+9MVkdm+1ZW8+WYYLtkL+04EK1kmUuf?=
 =?us-ascii?Q?HFcy37rlg4eoVOU8t0+pBWjNy6TAjNxgD23UXKkl89HnRS0kjAdbr+AiHx1G?=
 =?us-ascii?Q?7QgGfZo6kT0mLbiv7yY7Kk1Ze/X4Ty4VJrs2qCkSYXafDOLwpzk2KO0VDY4a?=
 =?us-ascii?Q?FJIv2gPOaeAWOo99Omc+YB/ExC3ddX4Z8ECRbzGWvXn0yCD8QCnH4f3ic/dE?=
 =?us-ascii?Q?TWl0tEENHNw/mtd3XAKnx+sQtKvQPQB0JsLALxM+5zqQZnWKmstTLyJbGqRq?=
 =?us-ascii?Q?TuFb+nN8KYwZzYNc1E5Ui0/uYpNNu4se7aL21JK+9Wfs8Varwjn64G6TvEk7?=
 =?us-ascii?Q?2tSW1+weuTijlDRC7vhCBRflwHl9ysJJwjmZeI3rNIx5SSX06DgBjbJWTDbE?=
 =?us-ascii?Q?94K0dNMtSKCtngKdzRga6eMFnkujRxvIrNS+QUNhqq6rYT+qhEBwWu0uM67h?=
 =?us-ascii?Q?A47aMUj2rTbqONosobqcpU5JVdG8Fmp7g0i4yPl+ngOuvzZhN6yGRirY4dYt?=
 =?us-ascii?Q?wxK+O5sf/F/vF/kOfpb0cVyUderZqoyr8OmIfZd5en36n3LoADR8/oMlAbBi?=
 =?us-ascii?Q?vusgke4SVxNWZCL6jOy1TrI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5098.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qm6q7pCtcWnLBkegZHYHgZXVEqF4eql8znPUpLDVCIGIdbgQxHPRCkdIbeNa?=
 =?us-ascii?Q?59Rf1NBfL38zl8WhsBmOnLn4YuaQpgfFfK8L/YlJE4/VgeLfxK5/Waq7Yts8?=
 =?us-ascii?Q?THfA5UcR9avSCL/Ia/cNmNBinOIgw0shK4wiNCK2DsNy21nT7OMiG9RYSwXU?=
 =?us-ascii?Q?8JmOakzTgXphROKFuVUCBxlg29b12cGT/SGMt3PFbCFi3U8i2uU+zGaUJqFn?=
 =?us-ascii?Q?TjJWxNJopAZdg/KH7hljEDEg9+V8YAael8FKgjSAZH1yRzES8KXDYUlcEalp?=
 =?us-ascii?Q?ErWrpv0HN+3za78E8YmKPVglYcfHQkUkyXTeA8T8cFQR9fC56Fi22n13z1DL?=
 =?us-ascii?Q?5jiGuEHTOiBg9JzmueN8ymuEg7nnTrLK7QwWT8jeDAd7c2orFxNKlCx0wpSN?=
 =?us-ascii?Q?57j9HNWPGdXm4ibnP5Mo9F/nbCFxGsVpNQXuJPeddjhBVdvfTWuNxQHQ3NhV?=
 =?us-ascii?Q?zJ/nkSNOek/LfNoe18XPuECJAiXoqu1qTsMi/DG4VPHucFK+vgckjiJcl2Kg?=
 =?us-ascii?Q?ZPe2HRDsP4ZT6HdTwO0o4t9Lp8WQx+NYZf9ySeQetIFp/QmyjPfj7Y9CTzQa?=
 =?us-ascii?Q?QdSbJCcbSbEJMrcm1w0SMMFN4XAjwVIY7QOWLKRFUp89m1TV9ZrJS5fwV/lb?=
 =?us-ascii?Q?0UvWQyqRFmUYWH7PXNhTMvmLUCAF3t1jvGRuKi4Y5FibTtbQ93843DnkdfBV?=
 =?us-ascii?Q?XneTrBtgkFXXyVE5OwT4ZBfVx61dqE2W54hzC5aIm3gBCoBoKcqba6Tu3CN4?=
 =?us-ascii?Q?1FaEd2SViFqrjP9Qo2mD8BWUKlk9iUvrmGWbuuSRcGWYkyf+U4GVjOGtu1/t?=
 =?us-ascii?Q?HsShyDqcG31OJT27SJyG3/a/GpW935Gp2T4U/NlMqJ2b6pJdMIZSEbPJpUjs?=
 =?us-ascii?Q?vZyASIcoTtGfuF2W/xGTMXE5DuR9t27SwvOqH0U/9tWiXxdZwoFRzw64yuNy?=
 =?us-ascii?Q?zHBaOgsbXqtJFXx/rscM7KV2XzSI37LdQq0i3N+CLSwPntEpqEE4W/A2JFnU?=
 =?us-ascii?Q?rdJ+xGqsiTZEE/FKCaBZI/Aow5CIBui7jF9xOUT6In+HJ+6HAsr7uliec0tR?=
 =?us-ascii?Q?pHu0lIKyM0gOJyD0aTUC2/Ykzb+VYVOIRFNKA0dGpOgdaW5Oac8FPunYNz29?=
 =?us-ascii?Q?qVHnNaQpUMGnhHUtn++hpSgMQBowVsFpDt6MTbD02vh1GaYWfBD+ECuqRMjD?=
 =?us-ascii?Q?7GbGLLEsO2SKKPh/b4Xn52t4dlKWeqxHYhfazhaU8uYZzHrTUktuYhXsVKYs?=
 =?us-ascii?Q?+rf3R5Kt7rvC6E+Vpfw2P8ISnqeYRYy1ISpY8yC8mIYH4siypF1vc1jufU7G?=
 =?us-ascii?Q?/tp4Ybe3ZPwTlkg2rxj1iMoHX6NTLm8IWER6zpPztZIo1um/WgGW0Dwr2VWN?=
 =?us-ascii?Q?lvDvcIiijbe7yT+cyIYvQ93j610zLuztoFvWYRbRzM8ySlvmcw82K/I2S1QM?=
 =?us-ascii?Q?cAfqlTGd1Yz+X2m/VAfuSEdMO9DApN4CYxYFPhf32xqFd72tUelNRmF4kKfe?=
 =?us-ascii?Q?p/Ynla8nkAJAE4fqo2rzvcFeC5mg9K8hJy7mc1fqwJ3B41DLFHqZglE8MbJ1?=
 =?us-ascii?Q?JHKdI4wGE/lyVljhec4W570XsL6fl5LHM59ZhCH8s3H3Ul+56FUWhqRun08Q?=
 =?us-ascii?Q?jY5sS2NtRqny8uUzM4Wa3yneJQCxAfk0HFcdxoRVys0IIOSzvfsGvOU13RQW?=
 =?us-ascii?Q?A2JcI76dAxVSuZWw42FohR1GQDqbQBN39HiDGBSdJluSECsfBnyBx6mJxH7m?=
 =?us-ascii?Q?MZlhyIm4WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6D95EDE37A739408CCE1121C80954E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ec9fbb-dcd4-4354-b69f-08de54acddd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 03:10:56.5633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbSGtJbBWzHveiZvhJwPXQyQDiaPZpIWc5LmvPedUSjZH8XlDij1palENw8W+wHMsiiqfd+AHBmb8g26z3MYoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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



> On Jan 14, 2026, at 23:34, Maxime Coquelin <maxime.coquelin@redhat.com> w=
rote:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The virtio_net_ctrl_pop() function traverses descriptor chains from
> guest-controlled memory without validating that the descriptor index
> stays within bounds and without a counter to prevent infinite loops
> from circular chains.
>=20
> A malicious guest could craft descriptors with a next field pointing
> out of bounds causing memory corruption, or create circular descriptor
> chains causing an infinite loop and denial of service.
>=20
> Add bounds checking and a loop counter to both descriptor chain
> traversal loops, similar to the existing protection in virtio_net.c
> fill_vec_buf_split().
>=20
> Fixes: 474f4d7840ad ("vhost: add control virtqueue")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> lib/vhost/virtio_net_ctrl.c | 22 ++++++++++++++++++++--
> 1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/vhost/virtio_net_ctrl.c b/lib/vhost/virtio_net_ctrl.c
> index 603a8db728..b059fe1f02 100644
> --- a/lib/vhost/virtio_net_ctrl.c
> +++ b/lib/vhost/virtio_net_ctrl.c
> @@ -28,7 +28,7 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vhos=
t_virtqueue *cvq,
>                struct virtio_net_ctrl_elem *ctrl_elem)
>        __rte_requires_shared_capability(&cvq->iotlb_lock)
> {
> -       uint16_t avail_idx, desc_idx, n_descs =3D 0;
> +       uint16_t avail_idx, desc_idx, n_descs =3D 0, nr_descs, cnt =3D 0;
>        uint64_t desc_len, desc_addr, desc_iova, data_len =3D 0;
>        uint8_t *ctrl_req;
>        struct vring_desc *descs;
> @@ -59,12 +59,19 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct vh=
ost_virtqueue *cvq,
>                        goto err;
>                }
>=20
> +               nr_descs =3D desc_len / sizeof(struct vring_desc);
>                desc_idx =3D 0;
>        } else {
>                descs =3D cvq->desc;
> +               nr_descs =3D cvq->size;
>        }
>=20
>        while (1) {
> +               if (unlikely(desc_idx >=3D nr_descs || cnt++ >=3D nr_desc=
s)) {
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctrl =
descriptor chain");
> +                       goto err;
> +               }
> +
>                desc_len =3D descs[desc_idx].len;
>                desc_iova =3D descs[desc_idx].addr;
>=20
> @@ -142,12 +149,23 @@ virtio_net_ctrl_pop(struct virtio_net *dev, struct =
vhost_virtqueue *cvq,
>                        goto free_err;
>                }
>=20
> +               nr_descs =3D desc_len / sizeof(struct vring_desc);
>                desc_idx =3D 0;
>        } else {
>                descs =3D cvq->desc;
> +               nr_descs =3D cvq->size;
>        }
>=20
> -       while (!(descs[desc_idx].flags & VRING_DESC_F_WRITE)) {
> +       cnt =3D 0;
> +       while (1) {
> +               if (unlikely(desc_idx >=3D nr_descs || cnt++ >=3D nr_desc=
s)) {
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR, "Invalid ctrl =
descriptor chain");
> +                       goto free_err;
> +               }
> +
> +               if (descs[desc_idx].flags & VRING_DESC_F_WRITE)
> +                       break;
> +
>                desc_len =3D descs[desc_idx].len;
>                desc_iova =3D descs[desc_idx].addr;
>=20
> --
> 2.52.0
>=20

Reviewed-by: Chenbo Xia <chenbox@nvidia.com>

