Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5CFC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 01:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D156402CE;
	Thu, 20 Aug 2026 03:39:58 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11022074.outbound.protection.outlook.com
 [40.107.200.74])
 by mails.dpdk.org (Postfix) with ESMTP id 4DB124014F;
 Thu, 20 Aug 2026 03:39:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCdhnzf4XTQlERCO0WJXin6bPQeLw2G1AxqILA1I1US+2vpsFivihkN6Oc/zDdcBhm7HAv9HI0/164awCVVUS90rNihRLF//SRB5ZIm5n5GKx9zkE0K8xXj2jT87Vr/t9mRHsKQyp6m8il6isjVrwTf4j3ugnJBvzUkf2zXVvGQJiWLPUOnLSKvr8Ia+/tkcAcmdB8TpoXBv1xMyPJJmwcETyuGGGGqSaFqNVAj9nTYpnj4pkShg2YYIZq0pacJBL5UxT/695ccdmhZMtmTKNvX8/xijoMICQRSD+ZajtMYKZe6Vk2I7C0g2Lc0sIN3N0iBYlpcEzjSaxS+iYpmRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiVjNxTQxMTab6ceqHMrcJSjuthuHdBT/kxV74GAguc=;
 b=RboFGKc2wU6NSee8lPMSHngoUf5n8bE37kv2IlTLoUS6J9H7B9nijOQBSCbWg1gIMRTJBSxe/GJbEKyesc6U2WxaSFHkqHVOAbPuTOxTOVgB2ARZGTIu+ewe6JWR3isb2PtpanZAciJMFgvRXHScL4Uo9823k19gXvjypLxl1aL956DBV/IYpvOrOvZlZxZbAYYZ6jXFPr1IsoFmzqYBM7sHSBUiHg477GJgl23nvRJzllvkXv1/oKL/KODc+siv04O3HP475Dn/am4P5dIkTMbcRqNdV1eP0HU6XQpopnHRZsX9NMUnuCxUi9QKuFM6T0jL3UCxgQEt5yNPldy+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiVjNxTQxMTab6ceqHMrcJSjuthuHdBT/kxV74GAguc=;
 b=MzibMmHo8XRMVNCe1Q29AZXlyr9IoNFDTz4qJaESY6OzxD4lHhUZ/Dcmyb2Tn5aOdFLCN4NOg4nyjNgtNcHqAQjSRs/vNNYYn4KH6R2yuCl6rZkcfltbYzMUTXZFvBXAftkjUa+eRvB56TvLY+Cg29Py0zp2bYv5cj4RhFfnZFU=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6633.namprd21.prod.outlook.com (2603:10b6:806:4a4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.0; Thu, 20 Aug
 2026 01:39:53 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.008; Thu, 20 Aug 2026
 01:39:52 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Randy Tice <rtice@cisco.com>,
 Jianfeng Tan <jianfeng.tan@intel.com>, Jeff Guo <jia.guo@intel.com>
Subject: RE: [EXTERNAL] [PATCH v5 2/4] eal/linux: increase uevent socket buffer
Thread-Topic: [EXTERNAL] [PATCH v5 2/4] eal/linux: increase uevent socket
 buffer
Thread-Index: AQHdMA53Tp9/uHNmgU+3e3WKQw7wubamKVEw
Date: Thu, 20 Aug 2026 01:39:52 +0000
Message-ID: <SA1PR21MB668341E922C0DA368BF3267DCEA42@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260817201602.120526-1-rtice@cisco.com>
 <20260819191036.679330-1-stephen@networkplumber.org>
 <20260819191036.679330-3-stephen@networkplumber.org>
In-Reply-To: <20260819191036.679330-3-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b125290d-f29e-4da7-a530-4fef3ea440c1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-20T01:39:17Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6633:EE_
x-ms-office365-filtering-correlation-id: 3446bc7d-7e5e-4071-6367-08defe5bee64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|56012099006|4143699003|7146999003|11063799006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YGsHYDcG69LKJUuHYfA12yFNhbe/J/1dObo9vQZdJdmHS2KkN0Q5m4tKQhF3sItNaBLnIHv+pY/PIYD53Jr0K3Unmz2sGHxmULz2gjS1KYGiUULM57eiUG49brsRf0RNs39IuebT5Ev7PXYSoGeiggORLEVyJ9jRtIXfSXjCsp8+MCnT+BlvB5uJ5Pn1khkvzKDyrA3eXv7LftYE94l09dfmBeCAPX1z9/PZneMi+Oh9bjhQHav8ZH8Ws2XGoA/J+FaVWDnYKQvWLxcZ6DjxZHuRdhvas0fmgJZE39zxh2iAX3T9nSsCpJwpWIlT00ctsbYsY8tmh7vaC4Q8LNYW1CnpZHpdFi5DmbGi4gKLNE+H68qVWN71dwtLFtNXgI/lj2tf3iaZmaHJL6CNL/Dq538OSzruTkCfhdwjQ7pze+sCJIg5UsXQDTCkWUoQWNmmAeMpxqAguZyOr2vEMnmcPkREmlG3V79LoI2k0P5GIW6ZAHt/9wR4JY227GmrQNv6QMYQ7NM1vew1wSgkMEx68N3ajRVHRUHKl4WFZ9LE/24dMqKMpWOWhZ1Pi5/8DV5k54MmkQT6gM3v/3CAHTR7MpDOINohLYbTPa+oiuMa/1ixc3XCWb8NHVcfCGsgPWcbPO3XkadRMO3buV3ynJ0CERJ7N1UvVo/mjd4Ua0CcFrl/ri2XflJO3OFsGaq2ok1DxNNQtO52G5bzgBJR0Je1BD55pm/u+kGYSFJOL742nCE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(56012099006)(4143699003)(7146999003)(11063799006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rWc0AmwN3QOs74DY8jEX38i/QTYENClQ0hM2d0yIAB89iLw7khX0k3Cuv3i5?=
 =?us-ascii?Q?ecklpfCkLJLxStlqRNpPN0bKAkOrvPdEXbwZIT0rcWYSyjuGsBEhEiAvqaiJ?=
 =?us-ascii?Q?lgz8IDXopwlwv+/tQ1GkfxdwdsbdOBQCLVvSjtLJFG5fqm+Y3qHSljL9zkKh?=
 =?us-ascii?Q?U/D5Cl4ngXZNmQn0q3IX7VSGVmckmA9v152clhi1NySgrbDin+PJrjSq8BT4?=
 =?us-ascii?Q?prXdLD/lhHaIJGlbk+JWfOQvX/6VOMP0EYZKxpFFvKHA7+gRxPVkCoS4PpIn?=
 =?us-ascii?Q?+B4K+lrEzTpCVGSlG6DW/KE4r72JZ5vpHY9wXw5LkR8RZ7UpbzcRzDKGSRba?=
 =?us-ascii?Q?ZiqHFp1rqHeKloD2tYYCJqzFDK7ltEXmjNqHz/hvOeoWpVp+zG7GyoLPcpIA?=
 =?us-ascii?Q?ZKExsm5ePb9g+1i/e/Zq3grQo5VlL3O9X8QEAQhp3Ui8cZhiMAdRUx1Y8SQj?=
 =?us-ascii?Q?iTq0H4UYvcEa7bG+ZNe1Esr9OGB83hkKmjd0UYs3rJL2aUFgEZLF8m133Lv6?=
 =?us-ascii?Q?MiySmMQyFYyn/g2ex10JH+Bskf2V9QSyxvR0VJnUIyGGyF6b1W60wWH5uvD4?=
 =?us-ascii?Q?HCS5wFy7Khb940a3J1p/tqkdrgYY2z+Bnp+5ED3hNBTkulfPst61whu940ee?=
 =?us-ascii?Q?rB/XP9PCBR7Mw9PPWktZ3oOIdjT3qzyPC6P0kZJjquqQ/oVc8pDNaacsCXfg?=
 =?us-ascii?Q?c5aWmIXXVrA+R+5X66x9bRjusbcmkjqI8dYt/oY20buuHE04N/Q/rnKiUNx8?=
 =?us-ascii?Q?499KYF2F2ShuVRl8Yy+38RNXyViAVjt3lLLoCCDEV3YzjrM3z+PJvjZLtZNm?=
 =?us-ascii?Q?JReTJXzEZJTi/GIEu0aeBfPw5TLwNWCP1LSOs3Sj3MTROGG5h95qSYVUNqrj?=
 =?us-ascii?Q?kTibZZYuAByYcQ0hrELLd2zKkzth63rwFZcx2p0dVM0QZuih6IFpM/Ep6am/?=
 =?us-ascii?Q?Ft8pgpzYKE9NDybW/bcoHaGcxP8EisIvp1+GzOLWH7plfuWYL/xvr+qQA/So?=
 =?us-ascii?Q?Eei/U7awj8CdkdZnk144YY1BuHBqswf4O6h5gDShACfiKPfpiGY+oOyZMQI+?=
 =?us-ascii?Q?quxbi2h82bLnLOXkOFHl+hTiaMubyiObvHnvvdAs5SRGgv+Ijzc0U78O4Dm3?=
 =?us-ascii?Q?s+xzpfUR+8qUXuLyDwRonBWbkPXNfwqGPAA4Emc4k1jeRJE4IVlvkNaAnDXO?=
 =?us-ascii?Q?nlc76DY01CThV4RCWGDAgeM/FKvhxUSqkm83I0ViSIJRiZjBoCVr9nA1Doo3?=
 =?us-ascii?Q?GuFakO3Z59yPhMnsuWEpadmRdKY22qnU4llqljCQ1dt+JQRLTjM+evxNcQXH?=
 =?us-ascii?Q?xu00uQRRpIpo2My/zj6L354cEy14uwFrDZJzYFd2hz2H6vOUXPtK4eKWtLqz?=
 =?us-ascii?Q?ujG+cOaqQuL11ACDsWtcFnPYFYioIAqRTbFd19oKuCBbXrwaWAcWzCr2tiXa?=
 =?us-ascii?Q?GwKDUFLPKIvMsK9sJ7ZcZfcI6mDoWzSujfgXaNC3rzl7Xr+Nhvkjdtc8q8VD?=
 =?us-ascii?Q?QqxQRTZPeFrotCl5ZSkTtlB4nVHtKLSmUuoWhsG5VUIDxB491nqfgcOewwWM?=
 =?us-ascii?Q?MNvZ7rX93GIIFpcLXF3nDSXno5PmAWSU/4W/95vLAn+TCWAhQeJ4eGoGXppC?=
 =?us-ascii?Q?UF2qWbm6iyToZHyVDaObEXf0qA8e4LKpozUiksTaosUfUO7JAW47XTlSI50i?=
 =?us-ascii?Q?AIHutGxPcDzHnSJ349bp4Ytvx06lWr6+Q2zdOBlb9wyg41Rp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3446bc7d-7e5e-4071-6367-08defe5bee64
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 01:39:52.7692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GvRQF1AbWpzxlEytzCO1+zKAQeHIzwUBKtBftkZUwt+DgQw1kuKUPzv7uuJ7lR8c3fgXkv1tpEres1fehZ+lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6633
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

> The kernel netlink socket into DPDK can get overrun if DPDK interrupt thr=
ead is
> not keeping up. To reduce the possibility increase the socket receive buf=
fer to
> 4M.
>=20
> Fixes: 0d0f478d0483 ("eal/linux: add uevent parse and process")
> Cc: stable@dpdk.org
>=20
> Reported-by: Randy Tice <rtice@cisco.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  lib/eal/linux/eal_dev.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c index
> 666967667f..fb5c8bf070 100644
> --- a/lib/eal/linux/eal_dev.c
> +++ b/lib/eal/linux/eal_dev.c
> @@ -32,6 +32,9 @@ static bool hotplug_handle;
>  /* Listen only to messages from kernel (not libudev) */  #define
> EAL_UEV_GROUP_KERNEL 1
>=20
> +/* Large uevent buffer */
> +#define EAL_UEV_MSG_RCVBUF (4 * 1024 * 1024)
> +
>  /*
>   * spinlock for device hot-unplug failure handling. If it try to access =
bus or
>   * device, such as handle sigbus on bus or handle memory failure for dev=
ice
> @@ -103,6 +106,29 @@ static int cmp_dev_name(const struct rte_device
> *dev,
>  	return strcmp(dev->name, name);
>  }
>=20
> +/*
> + * To avoid losing uevents increase the netlink receive buffer size,
> + * and override the kernel clamp value if necessary.
> + */
> +static int
> +dev_uev_set_rcvbuf(int fd, int n)
> +{
> +	int ret, val;
> +	socklen_t len =3D sizeof(val);
> +
> +	ret =3D setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &n, sizeof(n));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* kernel may have clamped our request */
> +	ret =3D getsockopt(fd, SOL_SOCKET, SO_RCVBUF, &val, &len);
> +	if (ret >=3D 0 && len =3D=3D sizeof(val) && val =3D=3D n * 2)
> +		return 0; /* request worked */
> +
> +	/* try again to override kernel restriction */
> +	return setsockopt(fd, SOL_SOCKET, SO_RCVBUFFORCE, &n, sizeof(n)); }
> +
>  static int
>  dev_uev_socket_fd_create(void)
>  {
> @@ -127,6 +153,9 @@ dev_uev_socket_fd_create(void)
>  		goto err;
>  	}
>=20
> +	if (dev_uev_set_rcvbuf(fd, EAL_UEV_MSG_RCVBUF) < 0)
> +		EAL_LOG(NOTICE, "Failed to set rcvbuf.");
> +
>  	if (rte_intr_fd_set(intr_handle, fd))
>  		goto err;
>=20
> --
> 2.53.0

