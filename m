Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85811CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 14:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C0ED40E15;
	Mon, 28 Sep 2026 16:40:24 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61]) by mails.dpdk.org (Postfix) with ESMTP id 5967A40DDA
 for <dev@dpdk.org>; Mon, 28 Sep 2026 16:40:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhNF5gSvo4gMaGyd0uM6PtQ5KpHJUtLss2oJpGLI4u3WIOjSK48uJBqzlmbsjfxQG0bIVhRiFC48mf3CRjdXMEVTpIQk8smdS/6rsABL86/dTpH5y1kf71MRl+nY4XQTcfRySse98zjwIXrWvOvDUvxlM2GhCraeLv/pAaUl98Ke0xuX3MYTvbOa7KijDSm65JQzEnnK9BFRSCimqdwnqZRf+QEsN9CwBdRughSjgxX6WTgDV/ZmIxcW1oxaUSF7kA7iwNVs8PEZCZIPwl4+3lqwsY3owwaFELPqSG+DTde4mAfdp1vkQrevcToje6JJtqA0WVmho1TLATMkqtPwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PVXOSetNZHFD7f0sKPF18MIx4k5zgYpFrHUHe5nDnc=;
 b=LafRJfDcTjhzskomvSgarZf1Qa3A0fN+EEgp0iZW8HAbcFCbRFZs8BduR8ymKd28B5XLjU7Um47D3j93zHiZhlpyojtroO8op+Bb/sF0RPYLlNVETzr65dm/oUBghXYq0epnzHEJxZNg4tBhZ4qrQ2LiieTmeWZM0nfS4e5rp4dihPZJBAbl2ELWRFo5OB730yAM0JqYIwkRdMGvt5Gh38/r54JIsOCsb57eWr2r9l7VYLS07QlMT9To2BxVZTbcPZmgkoiLMW3C1cLnubw1mX9hjobX9EjkXRtFhp1mX/peFnoSSg3aJuVTgDNINoIx14hpy5FnEyBnR/gbDXIM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PVXOSetNZHFD7f0sKPF18MIx4k5zgYpFrHUHe5nDnc=;
 b=jwhYUyCgCD6VbEx+QkHvP8wC6GcBhF+JiFcJURK0XyeUshrUY48mLImO+ccN8g/HB/le0UbUQeCAolHG83t9Fp8QJos8h73JXZz/qNVNhwcgmgTchzzFW0DXrv4jKvJk4DGTomdSgdnfL5xn/KQgeKn3AQTP50ZMKwV2NyMKpTN0Pwz1jSGS0D8RJkDvBXf4nUgjXMsKP4g0oBWHFvNXX/uiqGAVborCLHt4FiIcwq0IIl9RECtp3szoYvUjlOG4VPuXd3NQWHg4Uwhj7cFy0u0nFENFgNGlMFnhnwLWxlSniyosewKrwHL6tNAwQgL9Qu8LrX8ALRw8kRM18rALSQ==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 14:40:17 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 14:40:15 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "rjarry@redhat.com" <rjarry@redhat.com>, "cfontain@redhat.com"
 <cfontain@redhat.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: RE: [PATCH v9 5/5] net/mlx5: accept more unicast MAC addresses
Thread-Topic: [PATCH v9 5/5] net/mlx5: accept more unicast MAC addresses
Thread-Index: AQHdS+9uDp5O3srmgE6DxIIbIyIuS7bjqQPw
Date: Mon, 28 Sep 2026 14:40:15 +0000
Message-ID: <PH0PR12MB7077C3A75D0F8874D9BF500EA48D2@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260924063836.355745-1-david.marchand@redhat.com>
 <20260924063836.355745-5-david.marchand@redhat.com>
In-Reply-To: <20260924063836.355745-5-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|DM4PR12MB7624:EE_
x-ms-office365-filtering-correlation-id: e62d3374-c239-434c-74a4-08df1d6e6922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: Yt9LsqnT4UoMX10oGEkoKsviG5aZ+67kb3647zeVZJOpTwNp5xcNo2RYAJnX2nch/Hi7loGuQThVj4H5VFgzhzOjB5EflEkRHIgXgIlkFrWz/edZzX8VZMIeJJ6xF4mgY5IrmwLy50wcCmMWXA5tn+NEmCvzYHh585tsBV652xzZTS2KZmd4yyPl8thvuYd2scjmxPu8yQ8fZkVMewSBsXIL4MG4STNMXujK0rpjJgxqL34MVSd/+ayaPLnFrmVUCU/S0qC/opiPNUsEq16FCg+IZOZUCbHncHlyjMHkRIEurLpypB8nnHraQSo1SNokx1b5GTZYaSfFlCfL3V1zVPdkqA0q9z6gMmEH0k8UD5GXd7WJdyByaEmo51JhfsTgsSMCmFy0gw+9wP+9Rm6mmML3pNTU6mMXhm4g4EkRfCwLTELB6n5HCHemBvyHexccEnhg6UNFAKwcdZApyVOFRZyUGEWvkP7ZntG0E0ssHYpvxznMdhDMU3YOU1r9YANUXIPpKrdMudD+Yzcdycm3h8NjnpLh2/J3GIq2BwuFl10mRMKHgKII5uPTwIRJwBEIbwuJrSO6k3Nio415MXA8Z0M0hsPRCJ6p4giNkhR85crIGoX+EYKurVERBSrrtdPMIttBNW+wLyTYgJFJJrvfbb/zN7L+auHXGjCuObxTJ8oBb10NhOIcYAMxJoYQFzc9J9+RvjHKGOqBaAttCzMGlDY7xCn2CzpC6yQytjJfWVo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D6gnmkszubhbEKLyrJMNEcWXVmLKnukUbkW8II1ZXDLyKIvcXIPC3RKSyngQ?=
 =?us-ascii?Q?vb0W6wKQq4gvOHDjKLNL4e3PTa4wU91lQUkky5TcJwyWrzL9SgAqkgZbM12p?=
 =?us-ascii?Q?HyEpU+LvAvLOVMKQcKq3cZaTndZXBRgG+DIfz3gJ2fkuOWfQj7gR6fUFgKdD?=
 =?us-ascii?Q?0EOCVSiMdmh8pMXBWV51ZdggZxEY/MbDqm6T6/RxkBFxrgJzDzfxQtRVVOaQ?=
 =?us-ascii?Q?6uLEPF4x1xyx5l+STre60mUhWGV4Y2tXhxeZg72DIQIdJp+uON5VD64X8r0T?=
 =?us-ascii?Q?a1N4xwYxakobCCNCSwZxXw94xxkVZHYXQtzP13bj+Ppuc8YKQb301T6EiMN6?=
 =?us-ascii?Q?JOMufu83gB3qSrvEfQgUrOgG9rulWTlbS5nR05G+0DvVm2YPREUUPL8V5oiy?=
 =?us-ascii?Q?mLkgs4PwEMZ9Cb6bx2n/NdkJPGolC9qS2tdbwsv2YA1ZEzQo+e+sxohAGVFc?=
 =?us-ascii?Q?dEDeuWCamXOZRUV3GzTehFxQpcPn9t56mfRM0Bv9tqhUBmdXpi0nFvSx3f91?=
 =?us-ascii?Q?26D2lv5FTOUHgW2x6p1M64CUWQCdv6gD5Tx45bdvEzoSAUu6ekaAcqHYb5gB?=
 =?us-ascii?Q?zz6QhUhHPjSipAf7SkXjuHOMWeL18JhNSpDPJtSykIMtBdTLSTEnNdY4urUv?=
 =?us-ascii?Q?WqESvHuAIvx6bGlFskFpmuSljzPJ5V3HtCL3uj+BhIREMJT1IFPjbh/Bmx0v?=
 =?us-ascii?Q?va2vfciWIFy6aIT/MlUd4L9ttnssfnunbsz7QXOmzm6Mp0BAqipyibDayZwU?=
 =?us-ascii?Q?C5Ylx7CkRQo7YX63KxQP8ULDLTVaxeJUiIZvvKVllpIwfTASqJjX6uBN2Xj/?=
 =?us-ascii?Q?WhN0C7Dg3q8ahhPYnNeZCsGKgj6mA4yLitx9HKNNQ8/amJ70x6cep0Uio4br?=
 =?us-ascii?Q?uQBaWjJyMqXslF3qHeQeRD/s9a5kZGThRJLqWUOAdRj5eYc7F5UnZIAmKcr5?=
 =?us-ascii?Q?sQoo6sPFnL5GiEvUk8hx/p1LM1NasiDZssnT8f5DkQ3VVrDIkppz5ZnbYA9U?=
 =?us-ascii?Q?3j4W7HsUB/WTxxf8/e5khvYCI2BgfQ1ffeSY13WcGEC35t67OGXzapt1ifvw?=
 =?us-ascii?Q?5axmLE7HJHi/emKJF4OYlsVo4ZwaX0gc+4mMHf29WFZRWOuz6XupNKauz6Kw?=
 =?us-ascii?Q?EC0iYtVZxppxMnMIbxUAID4Kj9IsbMlIX8LzAjnQZdh0AMJ4ipLQ/ABCd0nM?=
 =?us-ascii?Q?ks2qMg/7K55+As1Zqcvc3EkvFjQemugybr8W2vbhk+HQz7GN9+HRR5pr23YS?=
 =?us-ascii?Q?ARBKIWUaMVhY5rCJu05+PLtXsMivtC3jzK5EaPnP/dtVeIsfyHQpFI7//lc3?=
 =?us-ascii?Q?J8nwRBGjN2rzZ3vSqPhKVhrD6ACSZzMZuGib520n/GCSmHUGEQPHMOU8ozMs?=
 =?us-ascii?Q?AiynXxVeaTb+RvedfiCdhFCdspLsg1FvqTSfjuA7FKTVvrf/V78N654oV6A9?=
 =?us-ascii?Q?ihdM1On7TRiVRXRP0c4UvpT5fuIm1MT1pdhb3gLlXpFp4hdnEBaBBbCILXha?=
 =?us-ascii?Q?w8OiOZhbk2YKTSNeGpwAn0ucG0z6pobRp9fHdqipwNFkVjHx5U6ZTO+npjLa?=
 =?us-ascii?Q?xJhuxBNdfrW+GGbTZxPbk5Nruf0D1sMHdMowyUAB5gif2dHlhcBIWsRatSw7?=
 =?us-ascii?Q?1rwaZC8EPqmJeSHIyYwPrYcljJyUM2lvK5bu9TTyUfPNzTzh242gGdA6S7xl?=
 =?us-ascii?Q?Jr5Taha3a18tPz6QQrAoV6Feb1Tw/cjUFAbZqbQc0C+eJyxXQsejHib3/1Gf?=
 =?us-ascii?Q?aH19hTWczw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62d3374-c239-434c-74a4-08df1d6e6922
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 14:40:15.6994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kA5rJyCw/WtWr18HZCuXoXG7nyOPgUOFOiZXuIpdhg+jddXu1IUTSlBfmPu1i1PpIL6ZFaZzXJFvRJOg36PW3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Thursday, September 24, 2026 8:39 AM
> To: dev@dpdk.org
> Cc: rjarry@redhat.com; cfontain@redhat.com; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing
> Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Subject: [PATCH v9 5/5] net/mlx5: accept more unicast MAC addresses
>=20
> Starting firmware version 22.49.1014, the number of mac addresses per VF =
is
> not capped to 128 anymore.
>=20
> The value can be increased via devlink:
> $ devlink dev param set pci/0000:3b:00.2 name max_macs value 4096 \
>         cmode driverinit
> $ devlink dev reload pci/0000:3b:00.2
>=20
> On the DPDK side, we must retrieve the maximum number of unicast and
> multicast addresses supported with a query to the firmware.
>=20
> Then, dynamically allocate the mac addresses arrays and report the limit
> instead of the previous hardcoded value.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
