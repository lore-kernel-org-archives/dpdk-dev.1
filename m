Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B394EB7ED0
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:56:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECD71402A9;
	Wed,  4 Mar 2026 12:56:45 +0100 (CET)
Received: from mgamail.intel.com (unknown [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 939BD4003C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 12:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772625405; x=1804161405;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/gF3MB5qXvKvkj1AbGwiKHto9cFWt+Tv6xUxWqCB1xA=;
 b=HCdur83+V9lbJUbpDKmsuUHZXnNY3WzPd0uQvxBr2z+8xLF0VD2fgC+J
 8bizaKGKa2vbPgZhVDHAsr2Fiyg3SpFVVL2XN11yTOcp07JrLwpOv8GqH
 iA48Y7KbO3vlEvm6/YW7JKG/rOZRjkbHqI92vTfCH0b6WXee9lVJrcP0z
 Iy5yp65Y2s/JsHEYlg5iJqE2h2XY9m66luFrCCgTzW+sm30TI09mZjWxI
 jTleOk8a5p8qwMLQDfp+06BljrwlqNWZOO/7D4qj9gdcVuzwKOsVVfWpj
 bXXqqekcsXCX+GXAdfOkfahohfalBBdhzMxidqJHwMXPJo8fR35tmrSf9 A==;
X-CSE-ConnectionGUID: nDZdjZjvRlmY1MJHM5BU4Q==
X-CSE-MsgGUID: 0JrYh1zdQECzRC+e4nwITQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73751437"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="73751437"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 03:56:38 -0800
X-CSE-ConnectionGUID: HRLowECFR5W2B25FCR0mRw==
X-CSE-MsgGUID: 2VDeUABqRWCpXPGIQOxNXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="218270918"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 03:56:38 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 03:56:37 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 03:56:37 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 03:56:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsRQn8Oml2E8gKvAnBCXWhU2iJJvvmWAwlz170Mbv9vC23VAWmJT9Ed1nn3mUCbtdZ6W1vBSA4HfFffIVCfYd3Z9w9VBS8uxOUPlaes0HSpan8GJDaqzqNsg9RBfvtKzHA98LeNKbM4KpVi69h72FMMWRRGxWTOmYnJypAKVwABc7o2GuOiNCjPIG6isBecwI4XQdI+l3G4aABY6bzW6LmnSw4wloYdfQWrBRV16XuRRx2nJjW31uvLBFEzVxo2FkA/Z1wkniZriLMuzSfYwS2gLb7OKudRjhN9WVIaS91lT8lsu+HcLk5v9YwsgsVSz88XpBFxpgGDbembv3sYtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hOyQo8eRgXpGSJbrxq5FyS8IjEU2lv7HZe8O0fgTcQ=;
 b=xb2SlnAKcfh70SKF6QCJFwJvL7LJnayn3LTGb63n9PwmZzET/AKt0+WF5FZHUxYUBrMyG9lYrJVmvVOdKBPSN+Y6J4eU14LOA3zAtP9KyDPkouygssft188oW2d75QkYTkfHq/ED4/iXP5wnm+ZSC5uXp4IyNygZelob//vEGKlAdum8B/c/LjKNQ/mDlbqb0dOnVTVkLoEXal61IkTfZvfIQ7okToadjxd6XsPH8/Rjl6nZBJd8H1c3z265WP7T0PmKCo13s+IG/9WIKDQe4pAdDbjgRuN3DKe7lKq0ulxVDlHafjMT9XILiB+51tkBdtytk4lJCMnSNf3hFV2iZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DS7PR11MB5992.namprd11.prod.outlook.com
 (2603:10b6:8:73::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 11:56:34 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::6d5e:e9cc:2957:6451%7]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 11:56:34 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH v4 2/2] net/ice: get link status updates via adminq message
Thread-Topic: [PATCH v4 2/2] net/ice: get link status updates via adminq
 message
Thread-Index: AQHcqyn3/GJc0pNKFkCvAew89PZvebWeRMIw
Date: Wed, 4 Mar 2026 11:56:34 +0000
Message-ID: <DM3PPF7D18F34A16B4734BA9FAC98EFE0288E7CA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260303162157.1634379-1-bruce.richardson@intel.com>
 <20260303162157.1634379-3-bruce.richardson@intel.com>
In-Reply-To: <20260303162157.1634379-3-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DS7PR11MB5992:EE_
x-ms-office365-filtering-correlation-id: a0eb1c5b-a22b-4607-7035-08de79e5155e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 9GqgsVp+tflg3pjO36S3n94L5Z2Dk1lwVH/rrakZd36UUxZCj90tIoH9rVHjnFMwSGd8xaUPXW/O+AXkDYXpvXSdIt1mhpDsoqOBf7tG8mu45VwtC6rEm79oSv4YHpFbpXrxxfH1UkO1jHTMNTzNN6EDLR07m4X3FCkvwPyB9eN/rFjFa3/bYZCbwZ3dHr8gNSjK/jT0COwPZfH3gmJb4owjqGf9+TTDuoek9PxbqPuqF5GT4yK1FoilpwBdhrEvLjJAYNP+VvPxvZn2Hoee3RAABS1fOKLiowKq3XxrpuDDlaeNnJ8i4LWdEmaaSc6v6qd2YRPU8WCMY6dkXoMPqLpIsK5kiQPHZQLQqKE/I9eSBXPJ7Q4HyokvSskk448glooj7Vk52rCmzTg4DQtk/s3a5wXtoMhLhFKYhXWh56GUP3uvEELioyNq4d7Eir2mvt3p/3iXeYo5KVjIt0ZhzyfKLhHgLiZ8Y3AwRzo+F4JZK37h8vJvO5j/RXFqyDkTNoyjV54jENF+hiimx/uqRBW+GTxbJQOkaHqf80vkxtqQisd9aoazuwPVHNmbtDTS8GYDKo2n+B/ycMqT6QA5gVX3m7m4ZUu3NQ9DojU9iKcOvYB12IL0iAoYATqxXwAM0/LCW72sLG8CNtKvvo25pBdm0Z8vcV6kXeSv432ShGFCGkZ379LW1dmmMiNg8zWUGXwo1VHeUsizWRzcEL/elD1LhygNgrDbB6aqM2mRo7ccTpZxuGD6d6UXQJK6EzfcC01imeqPMNDsm0FuuOHrwyr0rre7k0UXieumgRtUVAk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EE5YpXrBelzvUaGiqui9TEAt7DDrM+nkEC+YuFDwtoEF3q4beMnAplCZep0o?=
 =?us-ascii?Q?oZ7Hs+HYcSyE45l8iKPsnNPpax4ZlvxHjYDpTi2DWOmLaEh8yd4DW8c5c2nN?=
 =?us-ascii?Q?kIt5rKbFUWdCacCLW1RKyd4c8S2aWvSoOY8rc7ngBARF/xhAjc9UC9MVNzOi?=
 =?us-ascii?Q?ZQLMENJHHDPppjhNN7oBb+EuU6wwgl6E/VrPyE6S/2gA+y+WHaQNfufFuY9K?=
 =?us-ascii?Q?6YeE/TfW4SIjN5lpL9VN8Ynl/LxSzgkrV26PlS2GU/tCTCgetY/bAiS3KZFR?=
 =?us-ascii?Q?/NbSGtUL1Lwylu64ZvDrbOsgbkxkjl+V8NQiexmCy22j9gcXoEW+wj2kKz3o?=
 =?us-ascii?Q?pwPnlBb2njx66gSRNguB1n0++ePABKgqKVcpAblrxUa0Log7/0+tOJ93EQmq?=
 =?us-ascii?Q?ohPCInm3VMiepyDTdf/vo5bEHi9ggSpKuQwcIKmHz0+Z0VtM7u0PEGa10Rts?=
 =?us-ascii?Q?0jq8i4ltPtoN5THG4eqGs9netJW6PU69gSbd1qXUKZcymDC53QTcIwwzh4xA?=
 =?us-ascii?Q?rIVdcuHyt/0dxKiCx5bYqiBYsljRecARXK7tPBZPA/VrAYHyPq2TH9uFkn94?=
 =?us-ascii?Q?27cRHsJFbJwJNLq75LSVqbXRx5bbQqfrHoYVJFoWPvg2Eo1uN8ZSpF29j+eq?=
 =?us-ascii?Q?m1Af5tADMNos8Dl/wyUCfDKczxqlQnnHzkuJwkp+CQ4/LkDZxiFFauIoakfm?=
 =?us-ascii?Q?IdDHHbuwrK7io6by9cjbMqjdGAAUzgS0r5id0JsxNQFPdXoehMaT0Zk9CHPr?=
 =?us-ascii?Q?OsXhwQByWmB3LtHVup+Rg0nk6Bjt7PwSD8OZz3QlhWKaf7BKaEZ9nJKYlUv5?=
 =?us-ascii?Q?J3nZqD8mH2dSznoLSq9bUzc5P+ia6B19VcKD3ksh4dUhSEWINZoOQvR62QUN?=
 =?us-ascii?Q?W7BRkztP0eE9BlMMERwTsWR0lIcL6/iMIiOsNN8flOvJiJJ20/KLHlGl2zDN?=
 =?us-ascii?Q?pI4oKQP6qiay5zBSurt8/nujY7mJLulpyA7SIcwjaTxIR7GiAO9Kx1hQy5zg?=
 =?us-ascii?Q?jSHd9C0zb8mfrEiUiaZnkG33h/GyfZEHWxJVoOGy+9tU6AG8st1GpVXwRzl1?=
 =?us-ascii?Q?kR+y8UPdPHJSUOE1fJW5+iR49Jt6a1YRcEPKkQ6ffp4flvxA4ieX2KK1d+4M?=
 =?us-ascii?Q?M+MB+ifcnRaNCjINBjm0hoKXBBKGf+63lZ/pOzxUnoQFwp8O4LUit9K1G1k2?=
 =?us-ascii?Q?40ZZiOMOjYKxmuPJr2ksEz6MP1NN1o4XVTmCcnx5Z5PibcM6HGzSfVKcKfYN?=
 =?us-ascii?Q?YtGwTiMoxphy9qRmiZhp1VTfNur4A0NhUkIP9lkXkghlwuBbbROkEJiI9wNM?=
 =?us-ascii?Q?5vg7ER660ITUKOP6l/sMazL/XyyMWysS2nsECqyqTjB11a1EVh4Jh71KEdVh?=
 =?us-ascii?Q?H1IOig5+g9FPwy/vTHRddN25Lxl6X0F3he7uW1KRbBuP7vpd0LHib+p5ViH6?=
 =?us-ascii?Q?2tmEmf/eTSKm4C8TfzYK/6Tjtm/2oAwqVGqAzoqLUFS+UoemlcenMkNHCaQs?=
 =?us-ascii?Q?pd0JAQuh4tD7PkXdX8OX3udxJZaYbTlh1VQq6uPgKkJPojzV4FA/usKH9cEa?=
 =?us-ascii?Q?phBybbNtzuLIp3FEZqjapnYlfocQZWPmr5Z1xY6sXjdftw57pX8hJ5ehMI9G?=
 =?us-ascii?Q?stJeoKMHFIg5dwnfjcMrG/ge0iLmZ/ib4epacCpIXh+Hz28fOyMtxlVuRIvH?=
 =?us-ascii?Q?1HPpEwyh6ir3F2sESpSh96EZAUfRBOInlEa3XFYL4gZiW7zHtUN0ztcxepqI?=
 =?us-ascii?Q?mBqOVxLHug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rpob51Gn8WpATnY3Ib77eUGzEEbOzYQGv5DtWFrGTfrsKCTe54HJAVi3+sJFXhEnDNHzAfEYiAF9IBYluvVe1Q1X1/YzhNZgoJc1JVFyMXdkQ0s2jpcq3/aboPAs/YLYgS2NpJok3FCCUx/rbKnGluFqC7hF/up1jq+Q9I9MLCxv9liPax8K0DaepFqAArqXi6ETFKFB/1OTm+Phs/UYIZxyqhlDqNGUmwZIAsr1WUTUI+mRUYyZvIW0b6gNEqBkgkVszc5VK7HNBOd2E+NvIcA3DNZJLW2K7LPuYerB9F7RyG1z7z7acSf8zLJ6f6CZABZB0v6clxcEgtaBSQEA4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0eb1c5b-a22b-4607-7035-08de79e5155e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 11:56:34.5901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZD6J7TZeoA1dgwnDXzT2H8Hjvp6aS1yzW04WnehkMI9uy0v0EZLZ2aS4H5GSKq1t4uiMug5j++kl/5NjrxGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
X-OriginatorOrg: intel.com
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

> Subject: [PATCH v4 2/2] net/ice: get link status updates via adminq messa=
ge
>=20
> Rather than relying directly on an interrupt we get link status updates
> from the device firmware via adminq messages.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 48 ++++++++++--------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index a59ca2e047..8286816f06 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c

snip

>=20
>  static void
> @@ -4393,6 +4374,7 @@ ice_dev_start(struct rte_eth_dev *dev)
>  	struct ice_hw *hw =3D ICE_DEV_PRIVATE_TO_HW(dev->data-
> >dev_private);
>  	struct ice_pf *pf =3D ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
>  	struct ice_vsi *vsi =3D pf->main_vsi;
> +	struct rte_pci_device *pci_dev =3D ICE_DEV_TO_PCI(dev);
>  	struct ice_adapter *ad =3D
>  			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data-
> >dev_private);
>  	uint16_t nb_rxq =3D 0;
> @@ -4443,6 +4425,8 @@ ice_dev_start(struct rte_eth_dev *dev)
>  	if (ice_rxq_intr_setup(dev))
>  		return -EIO;
>=20
> +	rte_intr_enable(pci_dev->intr_handle);

Looks good to me.
I simulated link up/down and verified that the adminq messages were receive=
d as expected.

I'm wondering if the call to rte_intr_enable is needed here? It's already c=
alled in ice_rxq_intr_setup.

Other than that LGTM.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> +
>  	/* Enable receiving broadcast packets and transmitting packets */
>  	ice_set_bit(ICE_PROMISC_BCAST_RX, pmask);
>  	ice_set_bit(ICE_PROMISC_BCAST_TX, pmask);
> --
> 2.51.0

