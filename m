Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BBBC19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 15:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCC1340E3A;
	Fri,  7 Mar 2025 16:55:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id DF64540E39
 for <dev@dpdk.org>; Fri,  7 Mar 2025 16:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741362907; x=1772898907;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wN8v9DgkP4yWZtW1I7uk/G3PxqrgrPfWbVNro+s+B7A=;
 b=c/ax10GlMhpQsepa522vhwz7Xl5T4UHuD83GvyNEyMmlM1h/TqucvuW4
 G7IqspOPnvOnlXhtoSD48N3hd2ENd4pkY/SjjYYcbi5B5C859tr8ALhP0
 a0/WIb0hjbvdmWoDxfCXyKlnm/9nigpcqD+18biMcE+hsvvfk71mXrkgt
 AvK/Thl+nUCyglCI4AxR3lm5Q53yn4S4ubRn8ornOe2m4TqY+S9jTOJAu
 Yn7nyveR+3LSXjtq2Y6yzk5XG55SmSZC0YyavGR5KvJJtz/TF+sWWe0Gw
 7WAWxHvw+GXRDndUfUJKmpAux0Kk5edRKuV+b64rYZDA20pSTZAdyiDtc Q==;
X-CSE-ConnectionGUID: s3X1Y0d7R0qErmCXRxpCmw==
X-CSE-MsgGUID: YEIyYfLATnewLl5dJuIq5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53802957"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; d="scan'208";a="53802957"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 07:55:05 -0800
X-CSE-ConnectionGUID: nbFIAkgDS7K332I8krAFiw==
X-CSE-MsgGUID: H6fQMc9KQf2utnAjAeCHsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; d="scan'208";a="119108475"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 07:55:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 07:55:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 07:55:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 07:55:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7jOP/K5CUms7Ov5ObOKQRx7GcTS6MdtOmWvce9sAVb68fCfJJEmFjsL0XdyQ//OkSTIuTTduCJ8SoB2OgyDmm/YRBOJ6YWj+UZuXnQl+1RVtJGM/fQtgjtu/5LFAnn1J7U6vaICoIuvIdRtVzuQtIeBAR6olWd6kOUZF8sNhQjzuLN2EKKmeAmoeujaXl5ofuht526Tjb/DQpZ+9LnvjbSCJ8IU9WfZtFCtnOFum8y/DnZ9ISuS41qanycznpPX55YP2jDwE15ejA6xuxxkAmlzkR2BUl1a3hiFHccAdhQQ5+YS8eRpnFLr/yg2gUOZ6aWSK9z+7cdSu4yjVQV7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsRs6sTY5KunkhifxGOM635Dcw9Z2Wx9fjxl+9Hqn+o=;
 b=JIDCjEqtEN+CSf1qv/LZgHOzA/NCrHjuYGHgixcYXehfzv6Fi203txlkS0IJ5KlCOzZQDCpG+0OkZ/TTRx6Q6Z9a5Cz8IZELhKDEzEGbsq6SeUkXARxx7krsiGd4jEKRy2l5So1mIaaXbBYz36f2f6uQiCznp8Bfknx3UhaVtYs5/vQCB+Q6bElHgqKc6gxXAM5F6P8JrY+VIuI7Xhds3l+7q550EL5gOJU9wrQzCDg/ZXJE3cePC3Qr9D3CxYBjPB821i25ZBA7SMkk07y3gzl4dItxTJAlmRUJkBjUtYAdHgFYzOp8uvp944kltT/JiJ2XupzRUUUVqJaRDzgSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 15:54:33 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 15:54:33 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "mkashani@nvidia.com"
 <mkashani@nvidia.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
Thread-Topic: [PATCH] rust: support DPDK API
Thread-Index: AQHbjp0TZmxpO4GtBEmJszAY7GicS7NnxfbJ
Date: Fri, 7 Mar 2025 15:54:33 +0000
Message-ID: <PH8PR11MB6803599C6A152CD6B70465A7D7D52@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|PH0PR11MB4997:EE_
x-ms-office365-filtering-correlation-id: ab4599a7-fc4c-4445-aebc-08dd5d905acf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?prkXqC7CXfzNoJGh1VGM4K0AZDdL24XO668nvGRnMZnrPiXx3NS+MDS4Uk?=
 =?iso-8859-1?Q?se7MMAq4Is5yMDIZG5nGjvIvLYhVroHuBl8IBvd+DcMWzqr+m6jpwDwsOy?=
 =?iso-8859-1?Q?1IW2d6kuJ1D3YnD7aug85xjw6joVYat/fV3Ji3/l1AtTaXe3/s1PpUXgun?=
 =?iso-8859-1?Q?7+/N3szIuXzJVEGL6VRYaje/6K8iVAnsoefcYjkTARTU8Qq4xvTUeiBG42?=
 =?iso-8859-1?Q?p1cN6PZvfAC5+Hu1UC+0JSiU+B0zILHyaavW0POP1V4XuR2A1zZ7jLgPCz?=
 =?iso-8859-1?Q?+uBAmz5KB1IzEHFmjR1qM+x1lWuIyp03vqS2eu8uOx5BU1Qm28egjDe4rC?=
 =?iso-8859-1?Q?5b0/X/ZBTI0nljkLFqKuqKyBBSKYVh/bU03pR6KOahkmzGfFlFVy3jOUCe?=
 =?iso-8859-1?Q?W4RUWqmyon80j3Yn8S8/wSKF37ZWjKdXGr+YefaDrxCtK3twuFImwa6X2b?=
 =?iso-8859-1?Q?UNVn5Gi/VepJZTjN3O0P+RzZbfTkbBiNDN/eGGVmrO/P1XoGMKLmyX9hgx?=
 =?iso-8859-1?Q?DvwFL/ti5P/kQsH4L89LShLIq9WOZEh1A6yIIMma4hHNUA5JWnjhbRk3RM?=
 =?iso-8859-1?Q?KGMyeUE5ZGOhJh4Y6r6oa8sdbUiQk2zlYvdF3Z8d5DxdavTrsiKrLgdAiz?=
 =?iso-8859-1?Q?SQ92Zit5djhKWtPv781l8kUFqiKAPomeep1kvCixv3/eHK0UHJTha818y7?=
 =?iso-8859-1?Q?eY9c93bEDC9Y6DP1LgUjBpag/nsYrFrWJkxx/wc+PY7kX+w3QmIwwysfEn?=
 =?iso-8859-1?Q?J+L3hFr1xGGclAnSfacGHdA5vbgaF8po1Bqm6C+TE/veDa2Mv3G9ACEpev?=
 =?iso-8859-1?Q?hwn1sWRI3SWi0JNLIraOovOr8C254yReqOzhumSc1Z6lLfsD3yzVwO0HEC?=
 =?iso-8859-1?Q?rJUhd231048A/NjUsT+p34bTK7TlPJIm8IS0VBvb5d75/3YWv0EzEcGSKH?=
 =?iso-8859-1?Q?NYtGfVqbrUg4vLkgW/lzSlS6p3Gub9UrRoUrjF8ORKgT/C/wCneg5396QG?=
 =?iso-8859-1?Q?CYS5Ge4oD0ZrARh4/i16K2RW9hQDWGjaSc3myy7XJqStQmNbxpbfAAZnv6?=
 =?iso-8859-1?Q?g1RaY+I/k7kqxV7X27ZSXIZUMxWuhhozN9DsztFE9c3EZijfME2ljjCSg5?=
 =?iso-8859-1?Q?2aY73rzdj/ld/Kjl/5zABLCbLP5iYatR2d72blfpoxSWzftelDAUwC0Ddi?=
 =?iso-8859-1?Q?DH3XPgzgMZuOdk3eKo4kETsmBBPKroXYn/emIKnY+41mPUxzTAJjHMVEFM?=
 =?iso-8859-1?Q?gTB+hklwl70yNOBW12FbOT3bHzFvCkTzoEqF3GLhOhsI4owDPcp0d784/L?=
 =?iso-8859-1?Q?RgfRn4bFHv+WJVNX54ZxlVG9x7wLAMnb2q58DTOOYxSPbJ45dNjorU7ymr?=
 =?iso-8859-1?Q?0+9KCuv7vY2Ayk0iOYvBvABHpx2kQW6IQn8eL+lV+k2SGw9uxrVxcWtOlF?=
 =?iso-8859-1?Q?oBfMyTZI1nszWbqw9Yv2uJFxw39ZQAtX47tDRPnZbd1FKCcZG0jdNKy9GJ?=
 =?iso-8859-1?Q?DW0NJQ5/W4Naa/6kbtWFXG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GL4G1m2X7dwGbtclBMqJEY0hzRKaz3Hsw0iMORnwd+ynDIOUroH63IbmtI?=
 =?iso-8859-1?Q?TjETHDW9xWPCE6JYEfZiuKh/9DnW7JI9CIauYdAUdz95ZSuPRkv/Bl1hSm?=
 =?iso-8859-1?Q?P7MnTIwbnyk+MYAZ4bQPJ6TkoU6DcxieIvBzKo7N97jHwnJF5KqhuCLg6k?=
 =?iso-8859-1?Q?Wh1k0uiZnwz+EhPC2+ok5gxmPRsIEO7NevsyOHnKcx3IT6Vz9OKUPVI/+t?=
 =?iso-8859-1?Q?53PCKO6BK3hu8yni3QtRAqc4GiVWvpJcJKq/la8smza7WjicEGOvJNtOOM?=
 =?iso-8859-1?Q?Wb3GrtYN4jngtmakQFea/b/fUbZTFelG7hWGTKWBj0hj4zLmOwefYn8x2K?=
 =?iso-8859-1?Q?DJACgw3WQvPncCTlj2x2Aep+oxR+LjsFSa2jcRvA192meqJ4dlwnDgCFCl?=
 =?iso-8859-1?Q?yZUUODHzb2R7Jvf9FZ8MOM77qz6I1xIR0GyIODyEm8SrCREiySO2oc6UgZ?=
 =?iso-8859-1?Q?eDG7rhIyDUz2/WTxuDpbc6JPgtCu4iAq2YUGVCAfk4DTM2T4xu9Gi1TaCL?=
 =?iso-8859-1?Q?cRmScuRr25sumMf5QuAcPTVNJ3a1U0UkubDriSAb5wLjy97Qyi2agPFy/k?=
 =?iso-8859-1?Q?q7vSA5r2xBwHunyJy5fh/9mVRfvzBz/SaJUAOxujcBkQb+U4dbNbBAtxva?=
 =?iso-8859-1?Q?hv6rQfnMCh0vxdji15GWqqlOSMMu9o8X/i0PDehAGL9UW2pqdRfJrPhje7?=
 =?iso-8859-1?Q?bIeveT4gKcJe1nX4hzYIe0RIKxdwCdqikT0I08JWbxyaaFzxbf4LMEB91b?=
 =?iso-8859-1?Q?1cgn3URONzpr2oqtYu9TBQtGyW/LiI/947N0M/tZUpMYFW0iqTkfkVa1/5?=
 =?iso-8859-1?Q?YwnKnlQcKeBhwHf0mdEqI35tDCSsQVCk3SgmywVP9a7hm+VSxWT9fOZhkX?=
 =?iso-8859-1?Q?KLFBkCFi8HAzFXnod6cp6Uigv23MlecabmCy3xfaan4qk6GbKZtyxhX+Mc?=
 =?iso-8859-1?Q?PYDdWFikUaeeKlpyBJjn/NbfUm2AwxZ+MmYcAYPr89FOtQbkdL9OwFIUpB?=
 =?iso-8859-1?Q?Le68EFydxRbWgbO1SvzOXLXZX1RC4DV81IGTqG91zl3yBx1z/4nn/HlCiu?=
 =?iso-8859-1?Q?47XuUNAGsIzETma/DT74jxS8ZJVcdL/ZI4FN30TUox2VKXNxk5CMqBFiIE?=
 =?iso-8859-1?Q?U/pZfp+WvFh5lTMdEMNhfy0PZ9i2I4Tp8rrv5tOxNA0zsMuGMYn6Mv/Hq6?=
 =?iso-8859-1?Q?w8VRj/jk+bt/t37s1ai2rkdNmPwIhB/tc3mO/E/DwF7rlm/n/AHAvOOAnH?=
 =?iso-8859-1?Q?LjqA556xdnGHK1aodb3WZ7dtGUkA+SGPEt7XUUcWH9IuBwr51yp1E+AxXx?=
 =?iso-8859-1?Q?ZJsrR0f43jIlJbZlAMxeyxZNnK5mmnox6P+uRvV21Jw2XxFEWaOGuD31g4?=
 =?iso-8859-1?Q?CicM0kFfCDVpjKO5ukFdLUaroad070IqRPoodW87to27JKUzZ08t2u26LU?=
 =?iso-8859-1?Q?FX4r0D3vOK5TMU9YCmKs+wkdyfCoQkMS1siv4eX+/A3zDBHPlnZWwkoUq4?=
 =?iso-8859-1?Q?lG4Ppr5JiIsRjiuh5r2BaWitE0J6jBjl4uhSx/kwkzUQPyAiFf0TTJ6EXe?=
 =?iso-8859-1?Q?cL4PWIJNeHZHeFoNf99/lEIafjr35nMmX7JnNvrNZmzt2qoIXmlM/VfV4s?=
 =?iso-8859-1?Q?rY05qvzvOT7WnJoZ+2pG1m+5vvf0WXB0HM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4599a7-fc4c-4445-aebc-08dd5d905acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 15:54:33.6691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnDR6Myv4d9C6fWxY++BR053FEwJcdlq9+O8G3hzaXyhKsmBMkZaPCISn5G2hM6y5WdJKnvJPff5BknKFF8mjoWHbQA/Cj35XbLLlWA82fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
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

> From: Gregory Etelson <getelson@nvidia.com>=0A=
> Sent: Thursday, March 6, 2025 1:37 PM=0A=
> To: dev@dpdk.org <dev@dpdk.org>=0A=
> Cc: getelson@nvidia.com <getelson@nvidia.com>; thomas@monjalon.net <thoma=
s@monjalon.net>; mkashani@nvidia.com <mkashani@nvidia.com>; Richardson, Bru=
ce <bruce.richardson@intel.com>=0A=
> Subject: [PATCH] rust: support DPDK API=0A=
=0A=
More in-depth review in this reply..=0A=
=0A=
> The patch converts include files with DPDK API to RUST and binds new=0A=
> RUST API files info dpdklib package.=0A=
> =0A=
> The RUST dpdklib files and DPDK libraries build from C sources=0A=
> allow creation of DPDK application in RUST.=0A=
> =0A=
> RUST DPDK application must specify the `dpdklib` package as=0A=
> dependency in Cargo.toml file.=0A=
> =0A=
> RUST `dpdklib` package is installed into=0A=
> MESON_INSTALL_DESTDIR_PREFIX/rust directory.=0A=
> =0A=
> Software requirements:=0A=
> - clang=0A=
> - RUST installation=0A=
> - bindgen-cli crate=0A=
> =0A=
> RUST dpdklib installation instructions:=0A=
> 1. Configure DPDK with `-Deanble_rust=3Dtrue`=0A=
> 2. Build and install DPDK. The installation procedure will create=0A=
>    MESON_INSTALL_DESTDIR_PREFIX/rust directory.=0A=
> 3. Update PKG_CONFIG_PATH to point to DPDK installation.=0A=
=0A=
I've tested these instructions, using the default prefix =3D "/usr/local"=
=0A=
This puts the rust files in "/usr/local/rust", so some tidy-up required.=0A=
Debugging (or "searching for the files" was difficult - perhaps a log of=0A=
the bindgen output from "rust-env.sh" would be helpful for 1st time setup?)=
=0A=
=0A=
=0A=
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>=0A=
> ---=0A=
>  buildtools/meson.build               |   4 +=0A=
>  buildtools/rust-env.sh               |  78 +++++++++++=0A=
>  examples/rust/helloworld/Cargo.lock  |  14 ++=0A=
>  examples/rust/helloworld/Cargo.toml  |   7 +=0A=
>  examples/rust/helloworld/build.rs    |  21 +++=0A=
>  examples/rust/helloworld/src/main.rs | 197 +++++++++++++++++++++++++++=
=0A=
>  meson_options.txt                    |   2 +=0A=
>  7 files changed, 323 insertions(+)=0A=
>  create mode 100755 buildtools/rust-env.sh=0A=
>  create mode 100644 examples/rust/helloworld/Cargo.lock=0A=
>  create mode 100644 examples/rust/helloworld/Cargo.toml=0A=
>  create mode 100644 examples/rust/helloworld/build.rs=0A=
>  create mode 100644 examples/rust/helloworld/src/main.rs=0A=
> =0A=
> diff --git a/buildtools/meson.build b/buildtools/meson.build=0A=
> index 4e2c1217a2..dd16567f51 100644=0A=
> --- a/buildtools/meson.build=0A=
> +++ b/buildtools/meson.build=0A=
> @@ -50,3 +50,7 @@ else=0A=
>      pmdinfo +=3D 'ar'=0A=
>      pmdinfogen +=3D 'elf'=0A=
>  endif=0A=
> +=0A=
> +if get_option('enable_rust')=0A=
> +    meson.add_install_script('rust-env.sh')=0A=
> +endif=0A=
> diff --git a/buildtools/rust-env.sh b/buildtools/rust-env.sh=0A=
> new file mode 100755=0A=
> index 0000000000..705bc0d95b=0A=
> --- /dev/null=0A=
> +++ b/buildtools/rust-env.sh=0A=
> @@ -0,0 +1,78 @@=0A=
> +#! /bin/sh=0A=
> +=0A=
> +# Convert DPDK API files into RUST.=0A=
> +# DPDK files selection is on demand.=0A=
> +#=0A=
> +# The coversion is done in 4 stages:=0A=
> +# 1. Preparation [Optional]=0A=
> +#    Due to the bindgen conversion utility limitations source file may n=
eed=0A=
> +#    manual adjustment.=0A=
> +# 2. Preprocessing [Mandatory]=0A=
> +#    Run preprocessor on a source file before conversion.=0A=
> +# 3. Conversion [Mandatory]=0A=
> +#    Convert preprocessed C file into RUST file=0A=
> +# 4. Post translation [Optional]=0A=
> +#    Manually fix translation.=0A=
> +=0A=
> +# DPDK files list=0A=
> +files=3D'=0A=
> +rte_build_config.h=0A=
> +rte_eal.h=0A=
> +rte_ethdev.h=0A=
> +rte_mbuf.h=0A=
> +rte_mbuf_core.h=0A=
> +rte_mempool.h=0A=
> +'=0A=
> +=0A=
> +rust_dir=3D"${MESON_INSTALL_DESTDIR_PREFIX}/rust"=0A=
=0A=
Here "rust_dir"=3D"/usr/local/rust" if the default prefix is used.=0A=
At least, a "dpdk" must be in there somewhere (we're not Rust itself after =
all!)=0A=
but also different systems put files in e.g: "/usr/local/lib/x86_64-linux-g=
nu/dpdk"=0A=
=0A=
Appending a "/rust" to the end of that is probably what was intended?=0A=
=0A=
=0A=
> +include_dir=3D"${MESON_INSTALL_DESTDIR_PREFIX}/include"=0A=
> +=0A=
> +if test -d "$rust_dir"; then=0A=
> +  rm -rf "$rust_dir"=0A=
> +fi=0A=
> +=0A=
> +mkdir -p "$rust_dir/src"=0A=
> +if ! test -d "$rust_dir"; then=0A=
> +  echo "failed to create Rust library $rust_dir"=0A=
> +  exit 255=0A=
> +fi=0A=
> +touch "$rust_dir/src/lib.rs"=0A=
> +=0A=
> +bindgen_opt=3D'--no-layout-tests --no-derive-debug'=0A=
> +bindgen_clang_opt=3D'-Wno-unused-command-line-argument'=0A=
> +=0A=
> +create_rust_lib ()=0A=
> +{=0A=
> +  base=3D$1=0A=
> +=0A=
> +  cp $include_dir/${base}.h /tmp/${base}.h=0A=
> +=0A=
> +# bindgen cannot process complex macro definitions=0A=
> +# manually simplify macros before conversion=0A=
> +  sed -i -e 's/RTE_BIT64(\([0-9]*\))/(1UL << \1)/g' /tmp/${base}.h=0A=
> +  sed -i -e 's/RTE_BIT32(\([0-9]*\))/(1U << \1)/g' /tmp/${base}.h=0A=
> +  sed -i -e 's/UINT64_C(\([0-9]*\))/\1/g' /tmp/${base}.h=0A=
> +=0A=
> +  # clang output has better integration with bindgen than GCC=0A=
> +  clang -E -dD -I$include_dir /tmp/${base}.h > /tmp/$base.i=0A=
=0A=
# Adding this helps debug the header conversion & output file locations=0A=
echo "writing Rust converted header to ${rust_dir}/src/${base}.rs"=0A=
=0A=
> +  bindgen $bindgen_opt --output $rust_dir/src/$base.rs /tmp/$base.i -- $=
bindgen_clang_opt=0A=
> +  rm -f /tmp/$base.i /tmp/$base.h=0A=
> +}=0A=
> +=0A=
> +for file in $files; do=0A=
> +  base=3D$(basename $file | cut -d. -f 1)=0A=
> +  create_rust_lib $base=0A=
> +  echo "pub mod $base;" >> "$rust_dir/src/lib.rs"=0A=
> +done=0A=
> +=0A=
> +=0A=
> +cat > "$rust_dir/Cargo.toml" <<EOF=0A=
> +[package]=0A=
> +name =3D "dpdklib"=0A=
> +version =3D "$(cat $MESON_SOURCE_ROOT/VERSION | sed 's/\.0\([1-9]\)/\.\1=
/')"=0A=
=0A=
Missing {} brackets around MESON_SOURCE_ROOT perhaps? Got an error on "/VER=
SION" not found.=0A=
=0A=
> +EOF=0A=
> +=0A=
> +# post conversion updates=0A=
> +# RUST does not accept aligned structures into packed structure.=0A=
> +# TODO: fix DPDK definitions.=0A=
> +sed -i 's/repr(align(2))/repr(packed(2))/g'  "$rust_dir/src/rte_ethdev.r=
s"=0A=
=0A=
Hmm, interesting, lets keep a TODO here, but as this changes the "allowable=
" or valid binary layouts,=0A=
it is potentially going to cause differences between C and Rust's interpret=
ation of the memory backing the structs.=0A=
TODO: investigate each struct individually, and determine if/what is really=
 required/correct.=0A=
=0A=
=0A=
> diff --git a/examples/rust/helloworld/Cargo.lock b/examples/rust/hellowor=
ld/Cargo.lock=0A=
> new file mode 100644=0A=
> index 0000000000..d18af80c66=0A=
> --- /dev/null=0A=
> +++ b/examples/rust/helloworld/Cargo.lock=0A=
> @@ -0,0 +1,14 @@=0A=
> +# This file is automatically @generated by Cargo.=0A=
> +# It is not intended for manual editing.=0A=
> +version =3D 4=0A=
> +=0A=
> +[[package]]=0A=
> +name =3D "dpdklib"=0A=
> +version =3D "25.3.0-rc1"=0A=
> +=0A=
> +[[package]]=0A=
> +name =3D "helloworld"=0A=
> +version =3D "0.1.0"=0A=
> +dependencies =3D [=0A=
> + "dpdklib",=0A=
> +]=0A=
> diff --git a/examples/rust/helloworld/Cargo.toml b/examples/rust/hellowor=
ld/Cargo.toml=0A=
> new file mode 100644=0A=
> index 0000000000..7f9a77968a=0A=
> --- /dev/null=0A=
> +++ b/examples/rust/helloworld/Cargo.toml=0A=
> @@ -0,0 +1,7 @@=0A=
> +[package]=0A=
> +name =3D "helloworld"=0A=
> +version =3D "0.1.0"=0A=
> +edition =3D "2024"=0A=
> +=0A=
> +[dependencies]=0A=
> +dpdklib =3D {path =3D "MESON_INSTALL_DESTDIR_PREFIX/rust"}=0A=
> \ No newline at end of file=0A=
=0A=
Above Cargo.toml looks normal. Perhaps we could suggest/provide a method wh=
ere=0A=
DPDK does not need to be "ninja install"-ed, but instead process a local di=
rectory?=0A=
That would likely make it easier to locally build/test Rust bindings.=0A=
=0A=
=0A=
> diff --git a/examples/rust/helloworld/build.rs b/examples/rust/helloworld=
/build.rs=0A=
> new file mode 100644=0A=
> index 0000000000..5c76188e18=0A=
> --- /dev/null=0A=
> +++ b/examples/rust/helloworld/build.rs=0A=
> @@ -0,0 +1,21 @@=0A=
> +use std::process::Command;=0A=
> +=0A=
> +pub fn main() {=0A=
> +    let mut pkgconfig =3D Command::new("pkg-config");=0A=
> +=0A=
> +    match pkgconfig.args(["--libs", "libdpdk"]).output() {=0A=
> +        Ok (output) =3D> {=0A=
> +            let stdout =3D String::from_utf8_lossy(&output.stdout).trim_=
end().to_string();=0A=
> +            for token in stdout.split_ascii_whitespace().filter(|s| !s.i=
s_empty()) {=0A=
> +                if token.starts_with("-L") {=0A=
> +                    println!("cargo::rustc-link-search=3Dnative=3D{}", &=
token[2..]);=0A=
> +                } else if token.starts_with("-l") {=0A=
> +                    println!("cargo::rustc-link-lib=3D{}", &token[2..]);=
=0A=
> +                }=0A=
> +            }=0A=
> +        }=0A=
> +        Err(error) =3D> {=0A=
> +            panic!("failed to read libdpdk package: {:?}", error);=0A=
> +        }=0A=
> +    }=0A=
> +}=0A=
=0A=
Could a simple "probe()" like below replace the more complex logic? I've li=
nked DPDK in the=0A=
past using this more boring method.. or is there a reason that the link-sea=
rch-native and=0A=
link-lib parts have to be handled manually? Doing a Command::new() is hacky=
, nice to remove it if possible!=0A=
=0A=
 if let Err(e) =3D pkg_config::Config::new().probe("libdpdk") {=0A=
    panic!("libdpdk probe failed: {e:?}");=0A=
 }=0A=
=0A=
The build.rs file itself also needs a "rebuild if self changed" line:=0A=
  println!("cargo:rerun-if-changed=3Dbuild.rs");=0A=
=0A=
=0A=
> diff --git a/examples/rust/helloworld/src/main.rs b/examples/rust/hellowo=
rld/src/main.rs=0A=
> new file mode 100644=0A=
> index 0000000000..cf666aece6=0A=
> --- /dev/null=0A=
> +++ b/examples/rust/helloworld/src/main.rs=0A=
> @@ -0,0 +1,197 @@=0A=
> +/// Usage: helloworld -a <port 1 params> -a <port 2 params> ...=0A=
> +=0A=
> +use std::env;=0A=
> +use std::ffi::{CString};=0A=
> +use std::os::raw::{c_int, c_char};=0A=
> +use std::ffi::CStr;=0A=
> +=0A=
> +use dpdklib::rte_eal::{=0A=
> +    // Functions=0A=
> +    rte_eal_init,=0A=
> +    rte_eal_cleanup,=0A=
> +};=0A=
> +=0A=
> +use dpdklib::rte_ethdev::{=0A=
=0A=
As per first reply, I'd like to see the end-result safe-Rust namespacing be=
 shortened.=0A=
=0A=
This can be easily done by renaming the name=3D in Cargo.toml, and=0A=
removing the "rte_" prefix at bindgen output stage for each file.=0A=
dpdk::ethdev:: { RTE_ETH_NAME_MAX_LEN, ... };=0A=
=0A=
Perhaps its a good method to put the generated (unsafe, raw-C-bindings) in =
this=0A=
namespace, and build a safe crate (with the dpdk::ethdev::* namespacing) ov=
er it.=0A=
Thoughts?=0A=
=0A=
=0A=
> +    RTE_ETH_NAME_MAX_LEN,=0A=
> +    RTE_ETH_DEV_NO_OWNER,=0A=
> +    RTE_ETH_RSS_IP,=0A=
> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_RSS,=0A=
> +    rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS,=0A=
> +=0A=
> +    // Structures=0A=
> +    rte_eth_dev_info,=0A=
> +    rte_eth_conf,=0A=
> +    rte_eth_txconf,=0A=
> +    rte_eth_rxconf,=0A=
> +=0A=
> +    // Functions=0A=
> +    rte_eth_dev_get_name_by_port,=0A=
> +    rte_eth_find_next_owned_by,=0A=
> +    rte_eth_dev_info_get,=0A=
> +    rte_eth_dev_configure,=0A=
> +    rte_eth_tx_queue_setup,=0A=
> +    rte_eth_rx_queue_setup,=0A=
> +    rte_eth_dev_start,=0A=
> +};=0A=
> +=0A=
> +use dpdklib::rte_build_config::{=0A=
> +    RTE_MAX_ETHPORTS,=0A=
> +};=0A=
> +=0A=
> +use dpdklib::rte_mbuf::{=0A=
> +    rte_pktmbuf_pool_create,=0A=
> +};=0A=
> +=0A=
> +use dpdklib::rte_mbuf_core::{=0A=
> +    RTE_MBUF_DEFAULT_BUF_SIZE=0A=
> +};=0A=
> +=0A=
> +pub type DpdkPort =3D u16;=0A=
> +pub struct Port {=0A=
> +    pub port_id:DpdkPort,=0A=
> +    pub dev_info:rte_eth_dev_info,=0A=
> +    pub dev_conf:rte_eth_conf,=0A=
> +    pub rxq_num:u16,=0A=
> +    pub txq_num:u16,=0A=
> +}=0A=
> +=0A=
> +impl Port {=0A=
> +    unsafe fn new(id:DpdkPort) -> Self {=0A=
=0A=
This is where the first manual code is wrapping C concepts into Rust.=0A=
And the approach taken here is quite "C thinking", where it is possible=0A=
to misuse an API, and hence "unsafe" is used for many functions (more below=
)=0A=
and also for the C FFI function calls.=0A=
=0A=
I believe this part can be improved, and that there is big value in those i=
mprovements:=0A=
Today the code is "C but compiled by the Rust compiler", the programmer has=
 to use the APIs correctly.=0A=
=0A=
I'll send a patch in reply to this one for review, suggesting ways to impro=
ve.=0A=
Future code goal: "Rust checks code: invalid code will not compile, or prov=
ide a clean error at runtime."=0A=
=0A=
=0A=
=0A=
> +        Port {=0A=
> +            port_id:id,=0A=
> +            dev_info: unsafe {=0A=
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_dev_info> =
=3D ::std::mem::MaybeUninit::zeroed().assume_init();=0A=
> +                *uninit.as_ptr()=0A=
> +            },=0A=
> +            dev_conf: unsafe {=0A=
> +                let uninit: ::std::mem::MaybeUninit<rte_eth_conf> =3D ::=
std::mem::MaybeUninit::zeroed().assume_init();=0A=
> +                *uninit.as_ptr()=0A=
> +            },=0A=
> +            rxq_num:1,=0A=
> +            txq_num:1,=0A=
> +        }=0A=
> +    }=0A=
> +}=0A=
> +=0A=
> +pub unsafe fn iter_rte_eth_dev_owned_by(owner_id:u64) -> impl Iterator<I=
tem=3DDpdkPort> {=0A=
> +    let mut port_id:DpdkPort =3D 0 as DpdkPort;=0A=
> +    std::iter::from_fn(move || {=0A=
> +        let cur =3D port_id;=0A=
> +        port_id =3D unsafe {=0A=
> +            rte_eth_find_next_owned_by(cur, owner_id) as DpdkPort=0A=
> +        };=0A=
> +        if port_id =3D=3D RTE_MAX_ETHPORTS as DpdkPort {=0A=
> +            return None=0A=
> +        }=0A=
> +        if cur =3D=3D port_id { port_id +=3D 1 }=0A=
> +        Some(cur)=0A=
> +    })=0A=
> +}=0A=
> +=0A=
> +pub unsafe fn iter_rte_eth_dev() -> impl Iterator<Item=3DDpdkPort> {=0A=
> +    unsafe {=0A=
> +      iter_rte_eth_dev_owned_by(RTE_ETH_DEV_NO_OWNER as u64)=0A=
> +    }=0A=
> +}=0A=
=0A=
Cool - I like the egonomics idea of providing Iterator<DpdkPort>.=0A=
The implementation here is unsafe, which is unfortunate, we'd like to=0A=
ensure that all "end-user visible" Rust code is "safe Rust".=0A=
=0A=
=0A=
> +pub unsafe fn init_port_config(port: &mut Port) {=0A=
> +    let ret =3D unsafe {=0A=
> +        rte_eth_dev_info_get(port.port_id, &mut port.dev_info as *mut rt=
e_eth_dev_info)=0A=
> +    };=0A=
> +    if ret !=3D 0 {=0A=
> +        panic!("port-{}: failed to get dev info {ret}", port.port_id);=
=0A=
> +    }=0A=
> +=0A=
> +    port.dev_conf.rx_adv_conf.rss_conf.rss_key =3D std::ptr::null_mut();=
=0A=
> +    port.dev_conf.rx_adv_conf.rss_conf.rss_hf =3D if port.rxq_num > 1 {=
=0A=
> +        RTE_ETH_RSS_IP as u64 & port.dev_info.flow_type_rss_offloads=0A=
> +    } else {0};=0A=
> +=0A=
> +    if port.dev_conf.rx_adv_conf.rss_conf.rss_hf !=3D 0 {=0A=
> +        port.dev_conf.rxmode.mq_mode =3D=0A=
> +            rte_eth_rx_mq_mode_RTE_ETH_MQ_RX_VMDQ_DCB_RSS & rte_eth_rx_m=
q_mode_RTE_ETH_MQ_RX_RSS;=0A=
> +    }=0A=
> +}=0A=
> +=0A=
> +pub unsafe fn show_ports_summary(ports: &Vec<Port>) {=0A=
> +    let mut name_buf:[c_char;RTE_ETH_NAME_MAX_LEN as usize]=3D [0 as c_c=
har;RTE_ETH_NAME_MAX_LEN as usize];=0A=
> +    let title =3D format!("{:<4}    {:<32} {:<14}", "Port", "Name", "Dri=
ver");=0A=
> +    println!("{title}");=0A=
> +    ports.iter().for_each(|p| unsafe {=0A=
> +        let _rc =3D rte_eth_dev_get_name_by_port(p.port_id, name_buf.as_=
mut_ptr());=0A=
> +        let name =3D CStr::from_ptr(name_buf.as_ptr());=0A=
> +        let drv =3D CStr::from_ptr(p.dev_info.driver_name);=0A=
> +        let summary =3D format!("{:<4}    {:<32} {:<14}",=0A=
> +                              p.port_id, name.to_str().unwrap(), drv.to_=
str().unwrap());=0A=
> +        println!("{summary}");=0A=
> +    });=0A=
> +=0A=
> +}=0A=
=0A=
There are some interesting changes of thoughts in Rust vs C, in how applica=
tions actually=0A=
allocate or "own" data. The above show_ports_summary() function requires a =
&Vec<Port>.=0A=
That demands that the backing storage for Port is a Vec<Port>, and a (immut=
able) reference=0A=
is passed into this function. Hence the type is:=0A=
    summary(ports: &Vec<Port>)=0A=
=0A=
There is no reason to "demand" that the application stores Ports in a Vec. =
While common to store things=0A=
in Vec<T>, we have now demanded "more than required" from the application. =
In some situations=0A=
(perhaps not 100% relevant here, but..) like embedded systems, where dynami=
c allocation isn't available=0A=
there IS no Vec<T> available. In other application scenarios, perhaps a Has=
hMap is better.=0A=
=0A=
The best way to do this in Rust is to use the Iterator trait, which doesn't=
 require any specific=0A=
"backing storage" (e.g. linear-data for 'slice' or Vec, or HashMap per-item=
 allocated data, or ...).=0A=
Instead the Iterator trait allows the function itself to iterate of the "It=
em". Example:=0A=
=0A=
pub fn show_ports_summary_iterator<'a>(ports: impl Iterator<Item =3D &'a Po=
rt>) {=0A=
    ports.for_each(|p| { /* p is a &Port */);=0A=
}=0A=
=0A=
There should be no unsafe required for the above debug print, and no static=
ally sized C-string allocations.=0A=
Instead of fetching the port name via C function at print-time, the Port::n=
ew() function can cache the value=0A=
and convert it to a Rust String type - avoids unsafe {}, reduces scope of u=
nsafe variables in the program.=0A=
=0A=
=0A=
> +unsafe fn start_port(port:&mut Port) {=0A=
> +    let mut rc =3D unsafe {=0A=
> +      rte_eth_dev_configure(port.port_id, port.rxq_num, port.txq_num,=0A=
> +                            &port.dev_conf as *const rte_eth_conf)=0A=
> +    };=0A=
> +    if rc !=3D 0 { panic!("failed to configure port-{}: {rc}", port.port=
_id)}=0A=
> +    println!("port-{} configured", port.port_id);=0A=
> +=0A=
> +    rc =3D unsafe {=0A=
> +      rte_eth_tx_queue_setup(port.port_id, 0, 64, 0, 0 as *const rte_eth=
_txconf)=0A=
> +    };=0A=
> +    if rc !=3D 0 { panic!("port-{}: failed to configure TX queue 0 {rc}"=
, port.port_id)}=0A=
> +    println!("port-{} configured TX queue 0", port.port_id);=0A=
> +=0A=
> +    let mbuf_pool_name =3D CString::new(format!("mbuf pool port-{}", por=
t.port_id)).unwrap();=0A=
> +    let mbuf_pool : *mut dpdklib::rte_mbuf::rte_mempool =3D unsafe {=0A=
> +        rte_pktmbuf_pool_create(mbuf_pool_name.as_ptr(), 1024, 0, 0,=0A=
> +                                RTE_MBUF_DEFAULT_BUF_SIZE as u16, 0)=0A=
> +    };=0A=
> +    if mbuf_pool  =3D=3D 0 as *mut dpdklib::rte_mbuf::rte_mempool {=0A=
> +        panic!("port-{}: failed to allocate mempool {rc}", port.port_id)=
=0A=
> +    }=0A=
> +    println!("port-{} mempool ready", port.port_id);=0A=
> +=0A=
> +    let mut rxq_conf:rte_eth_rxconf =3D port.dev_info.default_rxconf.clo=
ne();=0A=
> +    rxq_conf.offloads =3D 0;=0A=
> +    rc =3D unsafe {=0A=
> +        rte_eth_rx_queue_setup(port.port_id, 0, 64, 0,=0A=
> +                               &mut rxq_conf as *mut rte_eth_rxconf,=0A=
> +                               mbuf_pool as *mut dpdklib::rte_ethdev::rt=
e_mempool)=0A=
> +    };=0A=
> +    if rc !=3D 0 { panic!("port-{}: failed to configure RX queue 0 {rc}"=
, port.port_id)}=0A=
> +    println!("port-{} configured RX queue 0", port.port_id);=0A=
> +    rc =3D unsafe {=0A=
> +        rte_eth_dev_start(port.port_id)=0A=
> +    };=0A=
> +    if rc !=3D 0 { panic!("failed to start port-{}: {rc}", port.port_id)=
}=0A=
> +    println!("port-{} started", port.port_id);=0A=
> +}=0A=
=0A=
Similar concepts around reworking "unsafe" away as above, future discussion=
.=0A=
=0A=
> +fn main() {=0A=
> +=0A=
> +    let mut argv: Vec<*mut c_char> =3D env::args()=0A=
> +        .map(|arg| CString::new(arg).unwrap().into_raw()).collect();=0A=
> +=0A=
> +    let rc =3D unsafe {=0A=
> +        rte_eal_init(env::args().len() as c_int, argv.as_mut_ptr())=0A=
> +    };=0A=
> +    if rc =3D=3D -1 {=0A=
> +        unsafe { rte_eal_cleanup(); }=0A=
> +    }=0A=
> +=0A=
> +    let mut ports:Vec<Port> =3D vec![];=0A=
> +    unsafe {=0A=
> +        for port_id in iter_rte_eth_dev()=0A=
> +            .take(dpdklib::rte_build_config::RTE_MAX_ETHPORTS as usize) =
{=0A=
> +            let mut port =3D Port::new(port_id);=0A=
> +            init_port_config(&mut port);=0A=
> +            println!("init port {port_id}");=0A=
> +            start_port(&mut port);=0A=
> +            ports.push(port);=0A=
> +        }=0A=
> +    }=0A=
> +=0A=
> +    unsafe { show_ports_summary(&ports); }=0A=
> +=0A=
> +    println!("Hello, world!");=0A=
> +}=0A=
=0A=
Overall, I'm very happy to see this patch, I want to ensure folks on list h=
ear that!=0A=
The unsafe {} around each block of "do something" is not idiomatic Rust - w=
e can improve that.=0A=
The summary_iterator() function above can be called like a normal function:=
=0A=
=0A=
show_ports_summary_iterator(ports.iter());=0A=
=0A=
=0A=
> diff --git a/meson_options.txt b/meson_options.txt=0A=
> index e49b2fc089..d37b9ba1dc 100644=0A=
> --- a/meson_options.txt=0A=
> +++ b/meson_options.txt=0A=
> @@ -60,3 +60,5 @@ option('tests', type: 'boolean', value: true, descripti=
on:=0A=
>         'build unit tests')=0A=
>  option('use_hpet', type: 'boolean', value: false, description:=0A=
>         'use HPET timer in EAL')=0A=
> +option('enable_rust', type: 'boolean', value: false, description:=0A=
> +       'enable RUST')=0A=
> --=0A=
> 2.45.2=0A=
=0A=
Great work, and looking forward to hearing about next-steps, and discussion=
 on the above feedback.=0A=
=0A=
Regards! (& thanks for reading till the end.. this turned into a long respo=
nse :) -Harry=0A=
=0A=
