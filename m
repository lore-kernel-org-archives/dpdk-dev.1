Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F11EA8535
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Mar 2026 16:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03443402C5;
	Sun,  8 Mar 2026 17:53:10 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by mails.dpdk.org (Postfix) with ESMTP id 0F288402C3
 for <dev@dpdk.org>; Sun,  8 Mar 2026 17:53:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia6Q/oM+VhiHGIVSeEzcQ3Yv0Mj5GsjuLM3jwOkowAd4uCZ6kRE44ulN7NERn1qjO6++UIyz+P5rGOd+TQm8IlOiW67wZfdZDshCg09NCu6G0kZNmhRf9FnbbjevuyGmP1/sbnnG+WilCujPfSQhZVezF6k9KRzfK1Q1T1gL7g/op3c+59IGFMq+DwaDWpMSUjRF67CmfNfQaGB9mpFVrKV1DreJFyX1Us9BxqKrMBOBcXQJOnuxLF55AowxdszBchIdBgKP+43N4OuXb+HQaQ1iIWJZ4pQhYdtuByyJxybY2qRk8OP8wAzANU4+6wXdz+Kg8ucSzhUswsd100iLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u26hnD/zpl9zwgDHPCXl0DGHJoLPTLyZE5wYM0Cv9kA=;
 b=PPtyZdawRW4BaUVCvUv0lyov4ubDr7ijYPbtIi/RFQBHQle5sJXGrB0YfA76pOxQVb5x0GCrE9q1raVVbRqaWemvGsLkyXE83npCO4NhaY6xkzxAi66LO5SUGQAMzeZFTw2v439X2+fCsM8JGrTFuSYcb3G3jVkSMzZC80LJE43gmN2B3MPYVjUYTu0h6dejPG5UsgpAGe438eiQtKhUNN2tP2UVmvq5xPL/1nnsgFogrr7cBb0cPi5Ec/Eiz6bUs9eItKKlQVE1N2NRGJ25bS000CRlPVHwDXD4t86hJAvoO7svuho6ITb3tnRY+ZxPjZ/g/OZTGPVUk0Syx0AHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u26hnD/zpl9zwgDHPCXl0DGHJoLPTLyZE5wYM0Cv9kA=;
 b=u9PeMJPWKp0N6DlHmibGj2KT+nYMeh+O4pw8LEQnXjrV9m1KeY5gIXCLCIXMoU/9EMXp0ZwYAMI1WU2eMmBQ/FhmQJfCX76lVzF/V5Ip19s5VIQzwlf32dxCWt+TnhcYeYgf2tGNlV/hsjhlwRWPE4M8Gv/mZVshKdGpba1tnpA=
Received: from DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Sun, 8 Mar
 2026 16:53:04 +0000
Received: from DM4PR12MB5104.namprd12.prod.outlook.com
 ([fe80::26d8:9433:5e2b:5543]) by DM4PR12MB5104.namprd12.prod.outlook.com
 ([fe80::26d8:9433:5e2b:5543%5]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 16:53:03 +0000
From: "Ande, Venkat Kumar" <VenkatKumar.Ande@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "Sebastian, Selwin"
 <Selwin.Sebastian@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Thread-Topic: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access
Thread-Index: AQHcoPW8b58JddpWd0qpasAK/qBukbWh87OAgAMBGkA=
Date: Sun, 8 Mar 2026 16:53:03 +0000
Message-ID: <DM4PR12MB510450BA94595EF1D23106DD9E78A@DM4PR12MB5104.namprd12.prod.outlook.com>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260306105533.5e8b77ff@phoenix.local>
In-Reply-To: <20260306105533.5e8b77ff@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-08T16:48:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5104:EE_|PH0PR12MB7908:EE_
x-ms-office365-filtering-correlation-id: 6c5c4c7b-2125-49c5-72e8-08de7d332a37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: iJoaxLfBuSJxRxWWTjfLVZ0FuadaQ9gEaf+zc29LAILSYe+SrB3TR/ni4nl5lRojXFduwy17xgTt7p/iINHj0sHqdG3EZ3/Hr+WIypQAF42QT0uJ5/w9O9asuP+yti7Qcgz6YD/isHkhJVLgud1Zsc1iuGGacCRTTQRunB+wzmkql/u9QNPTmEleh5BgW/lN+JAYgPZ1oivul2EjklYVCjQDpdEMzFpgeu4eL0UNLL0+hmGNJDySB//DkZICncY8/V1yu5CRfDrQgQeqjSXYDJ237RqD7VK1A/otFsh6o9ln8ex33hxKsl5SMT7WsStnPdyUAreQng4lAGnhWWsMQ4bPJuSCzHuKTeheVWVcy8j+xMdzW3mWmkZpztiCiBpq6MLrcbCUmluEEXdiJuEFqHnpT2PhQ8inJdIGujMERFA5pu8aOtHAzPvjiSI+48SyztTX1UOAnQR3F3yHBXn9T9xLxPb57VEmuVObigNY+ZZ1rkKnzf8rJv2eWRxiZrgqdMj7k89uX1ucYlG3hN0MmcFgcPg6vMdvSMe5NrnpXni60Oc+vcA+pTI6RDR7Ye/kZOAtQYsUopTqLch47XmNrweB+8m0F5X2yFJXxf1tqKK9/CZrzSjrx9aQU98nReHQX3QMk4pxe7qyNkTTK9240tE6aQ838rQFZfI0Ux2GhqxReOR6GJBFwPZO+EwlG7fT0pXA4bP64jzei8ehG+/ZPtKhjhkm8GY58awsFSMRgQv4mmq7eu9s6iFPmjvmyFLlt6eKhAYXYCMwiWvcYARmlNn5ioFmD1PBqfxhSHS7698=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5104.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ia5tAMvBVbJRWcvX3Z8gUI0kuETMN+f6ouC8au7HXTbrWe+5cDyZ4zkgFff2?=
 =?us-ascii?Q?MkZ15S5pRoF89qGnOP8cu60jMxGlFqT4/E41Szrvdo7HQY3sxf49vTLHjlPh?=
 =?us-ascii?Q?OoQDEcdji07bLBpp6zr1SwuL7BMc7kjv/r9pFs+fRos2fiupulmU/lP+BmEI?=
 =?us-ascii?Q?XJpoGh2RsGmPTXRcev6Ekd2hlY31ARnpGozbrglF/E7fkD7cfZT5joLM2vev?=
 =?us-ascii?Q?dR6H7Mi4jkGmcnFDLOZpRMC+1L0Cvn4lXvIHRYhXZqX73ohXf7IpKaTikxL2?=
 =?us-ascii?Q?K7cjNyhKxcJ5MkTcBesBMiKJspS0jpiskvgnsM59cWOOvmoAE/fXwHRACCXD?=
 =?us-ascii?Q?bEWS6zq3olgiOjtuFvM/BKN5ON7B850s8M9Zt91tt1m9K8FAih3UBzyZ4UjR?=
 =?us-ascii?Q?8OgErmqrehvLTw3bbxqdUaM6Wzsp7ZlFx5XLB2X2j2/IZdXvDyt7WiybFV09?=
 =?us-ascii?Q?lJoOjgRw7sybSo1D7TQ0yetp1SVhiDgFZqX2M/q2UthuJ0emylV7cLyfNEeq?=
 =?us-ascii?Q?C3dEQzmWQ0rWUi35sOA8xt1Qj4l9zzyTsj9Rjc0AsFqfAw8iHD7S1DZOAidj?=
 =?us-ascii?Q?1o+41vbl48wvIwJO9i+Q/rl07IWvZFR6BsS3Ca9Veq0sn8GLhzCb7OVzGkuB?=
 =?us-ascii?Q?4DkEQY2hzBLtp/B2AvbrqLkyUvAS4/Cb6mLOvb7RTw0js9DMfTW7yfWIT6Ij?=
 =?us-ascii?Q?DNvGi56kkAAHfU+s5UE4zskTQrrrZFi1MlG9OshPEZDyVD4zSg2dz4fqOMmR?=
 =?us-ascii?Q?msavOf/Yn8MRZSIixw8yoQpaf+etdeRIf91vtpcttPHRFFxR6VNG5Hgs6Kgr?=
 =?us-ascii?Q?Qby0zYoJa3f3bZCjtNfUv189KxF6sZ8/nK6Ou7XC1Dxosj7vqrtkppeNORUx?=
 =?us-ascii?Q?5jR+XEpoqJHvAj6va/al0ZG0pbZRRf87ofA6IfD0n4UdtPlHqKt9wy9QpY9o?=
 =?us-ascii?Q?b625qcqYBGLh8Sf/ontUSMjmM7tVcfREyfxmFcvsk31gxDp7ELL6uUG4vSdv?=
 =?us-ascii?Q?RZw5/C917DkDAVxAuIbeKUdPUoeHLP+f7UEZWweGZK9YFAJ1aYRmmLP6B+e3?=
 =?us-ascii?Q?ADzNf2y690HvIAQaXZWKIe1lxsxIiDuSVcpou0T2w2CovL9k1a08iSR0DtSD?=
 =?us-ascii?Q?0vhX1VlufyE3VeWHrdslT9QSAsUlHYkXrYsWBgIR2E7DI7TsjMXkEOx9cRdx?=
 =?us-ascii?Q?RnqgqMM6LDaZtmPshFwwA2B15f61E+VEV6xD/VuY+o307FWjUmJiEZjjYMuT?=
 =?us-ascii?Q?GlIIWUPm0hCN3bXa0OkgY0qvNnQWSf6Aza2UM3DevJt6n4qt8HxqtldNslPi?=
 =?us-ascii?Q?puo9uqV/UzPQb4AU+WIk7PlZ0+/WTnG4r1qLAdCGxaP4Xxct46eJwbGY8yO/?=
 =?us-ascii?Q?9lYvPmxQAzb5v1fQklLpW+B+UBcRCTV8EJftki9N352XjZUPXOePzzof48Dr?=
 =?us-ascii?Q?LuyggPlgp5bM9Ib/zXrWOzdh+bHZFojHtXHi0QTvzzPhg2VSkD+D8EkUyCle?=
 =?us-ascii?Q?IJ2CyNie91WoAVEzfQT01eCcX7j57fH53HaXJ3AfQZU2YRk6tx5BAV0CcQci?=
 =?us-ascii?Q?0FQ3vxEaEVlSRi5XDtdwB+Xu2UBViFDwNyzF3V78OG9Sw+fTdQugUV7IrC5t?=
 =?us-ascii?Q?k0ycAMZucQf66YIt7eghlpRZh8uTCky2Lgos+3osYBoEcjz7ZZD2odKcQbyj?=
 =?us-ascii?Q?sygYzi2OYC5efmiqH4nLpInaOfROAIO4VvJ+dutXFwiZtujU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5104.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5c4c7b-2125-49c5-72e8-08de7d332a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2026 16:53:03.7815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3rgxxa6EnVOStc13FVjmQhYhsj0uJ4tqP1xmcWzbFfEw3bQ16kDbbVkmm4tC+0lJ8Pj0UZ/mIYssNLztwXnNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Stephen,


We are checking the patches and doing the verification on our AMD setup. We=
 will provide update on this. If possible, please share us the AI tool deta=
ils, which you are using and steps used that will help us for future patch =
submission and code review.


Regards,
Venkat

-----Original Message-----
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Saturday, March 7, 2026 12:26 AM
To: Sebastian, Selwin <Selwin.Sebastian@amd.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/4] net/axgbe: fix resource leaks and OOB access

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Wed, 18 Feb 2026 08:40:58 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Code review of the axgbe PMD identified several correctness bugs,
> primarily around resource management on error paths in device
> initialization and an out-of-bounds descriptor ring access.
>
> Patch 1 fixes multiple resource leak paths in eth_axgbe_dev_init():
>   - mac_addrs leaked when hash_mac_addrs allocation fails
>   - hash_mac_addrs leaked when phy_init() fails
>   - rte_intr_callback_register() return value unchecked
>   - DMA reset failure via hw_if.exit() logged but not propagated
>
> Patch 2 fixes wrapper_rx_desc_init() which only releases the current
> queue on mbuf allocation failure, leaking all mbufs from previously
> initialized queues.
>
> Patch 3 adds pthread_mutex_destroy() calls in axgbe_dev_close() for
> the four mutexes created during init.
>
> Patch 4 fixes an out-of-bounds read in both Rx and Tx descriptor
> status functions where desc[idx + offset] can exceed the ring size.
> The offset is now folded into the index before masking.
>
>
> Stephen Hemminger (4):
>   net/axgbe: fix resource leaks in device init error paths
>   net/axgbe: fix Rx queue leak on descriptor init failure
>   net/axgbe: destroy mutexes on device close
>   net/axgbe: fix descriptor status out-of-bounds access

Since these were code review generated fixes, still holding off for maintai=
ner of this driver to verify
