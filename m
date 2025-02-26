Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5DC021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 18:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30BC14029F;
	Wed, 26 Feb 2025 19:12:29 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by mails.dpdk.org (Postfix) with ESMTP id 6CFA14026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 19:12:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnLy+BgBteLCwc5pWZGJLSiHcB2ZYvflr8xUEuchDWJAuMvy9xk4lA3raaI38afpPjPxfnn/F/MELbvwajhjXxFzcbOhxf9SY5o6WSjt16Az/SikRyMFClbPtQSsclfVKKFLaT5Eq2XjbF+OcwyE/0QnhTLFXOeFyHF5BOqPJxGeMYtj5JXp2RNK1y5HkblI7GqjWXEqBM1fiPWTvT19TY03Vt6wQD35m4IIH4xK+9jaRGz3O+CzZclGFdyZEMLHduFAZl1+cEjPdoidvAHz6J4jsYAjDZByMKPJR8zW/xVlUPOmcneNvlZrdunQ0soud+2Gkln0yW4GCEaNA62p6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1dGc4aqvY2cdKE0Xp0apxAEXSkZuc3oaYX8lxYVyck=;
 b=Xu1t3RzUn9z2f5iPORXoiVz6JvJRSj9ZROZlvB4mHRyNQrVx3VBPuIBRIejl6PxdvM5ZLRvNrqtw39m46iismwlE+gwtaCCK7QOO+Ba0SYKkDEVI1zuLkJV1UZiOJAnarwHCgUdx/s/mW1vf+ey3JpMmnLxw9CEav7zxNxujukHT6K2Zh+1ttIHs0tXxY5g8duEQfZGKhBsmc1BzU0U5MYAG6Pu+8nJ6BMu4VulymirrDxIpKJbx7LhVUPN0SW9Y6Qkdp3nVloZU8ugCqeblV1i84QEfOHnvit0krI/MReemQ5x+SsYxL649aUjCr7/ZyAcWaKdArdQ5NpQY96/2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1dGc4aqvY2cdKE0Xp0apxAEXSkZuc3oaYX8lxYVyck=;
 b=mLE4S5rPWgeXnDLIlsCGfBmljwZi9+YO75FZcxNgj9/7pofH5fwrx7FFaCBhupz4SL1JPU1wNtjjMgIrFWAbNw7uDIN1OJrGCAj2ItjAtjvjJ6nWQydkdP/X+tBjZ8Hcbj4hPypVVpuFmWTIEDLRPw0r72Ha8qHIkK4mgzZRRXPpEMKKUCYA3eELfjdUFaR+X52KMMyI/DKmrCv7fqT3cnTDKMXfwcZUq0Dt+fIq21DL7JMESd1CcaIh7lRSMxGO9wDO6g2XANQcVWVs//eywvGnfnha3ujFU1XlVYDBrLGXS1N+LTHjlrJcTlawpYGeJBl5wu3c+kqsPnAZTYQ8eg==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 18:12:24 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 18:12:24 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Suanming Mou <suanmingm@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Alex
 Vesker <valex@nvidia.com>
Subject: RE: [PATCH v2 1/3] net/mlx5/hws: support jump FDB Rx
Thread-Topic: [PATCH v2 1/3] net/mlx5/hws: support jump FDB Rx
Thread-Index: AQHbiFcFV/wChBw5uEmk726hV/PjorNZ4yIA
Date: Wed, 26 Feb 2025 18:12:24 +0000
Message-ID: <PH7PR12MB690554728172A564EF0ECC54D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250225004527.2066812-1-suanmingm@nvidia.com>
 <20250226140119.2142352-1-suanmingm@nvidia.com>
 <20250226140119.2142352-2-suanmingm@nvidia.com>
In-Reply-To: <20250226140119.2142352-2-suanmingm@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|SN7PR12MB7023:EE_
x-ms-office365-filtering-correlation-id: 43313d7f-e2e3-4180-704d-08dd56911ed6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GwBULkSZ7xgu0AtzDxoXjOLNHx2J4SbsbCl3oSCfhWOYMcS3oszh/L99zCAH?=
 =?us-ascii?Q?+GZfcm74eKhhXVP2qXyhguGJPRkdIrbhpDgj6VMBpCtY8fc43T3plPdC5x9Q?=
 =?us-ascii?Q?5tt6KJzru0oCkt0PaojJjXcHYoXGwvmhAaF7kJ8leqQdFWSwKLWxm5tjprvV?=
 =?us-ascii?Q?BEErvln3mB36ABqR+GgDbtNpP9bP23Sqyyn5sITvSTl/AV+edK6tcWb8nfvy?=
 =?us-ascii?Q?6m+v7CJwEIOCqfqCUswIDqGYLKm0fyIECp+BjVsIEpkgr7i6ygUDZwvrWQEX?=
 =?us-ascii?Q?ax056JNdj62+Tv8MQ8L52DBcHFTJyFGjnqMhqYLrWdYIq3tQWcr4n4io5dPk?=
 =?us-ascii?Q?5QRln9xUxTM25v2K5VgtGvvJOBOJ3M/5mdtH6q00SQiN+2w/7u3PSwSM9dQ6?=
 =?us-ascii?Q?UrwpDhOZb6XHKYannkM1R8WN0hP/8NvYJJeTknnD3k10DABhbiW4bZyINao/?=
 =?us-ascii?Q?mCGzo+BlIeZbC7gmsxdgO21S73WuTDxayZnADmKZe6qLSKDSjcTYLPo1bFHm?=
 =?us-ascii?Q?bg5gmJJKLj9WMfuNB5Nr9VuN7uVPfBDvEFjOGO757URSZ7ln1DPia9YzPkZ0?=
 =?us-ascii?Q?IsACewtNW+mhuld3/59zjMa9DLUAK8eGN5YdssBCS9u5ENhUqnHrv1Sqg2UA?=
 =?us-ascii?Q?T2DVAe3nKJ85eiKPhoClfgYZbYAqI74EOzYKjawdUHEK67n6se18gOsOzWMe?=
 =?us-ascii?Q?uYozj3KdIPXaVgAV9Dp672eWSR1opiEaYXJPfxJzDqGx53uR7lSVRlYPr6QM?=
 =?us-ascii?Q?RFPywwUzME+8ZS6LKZq1+OYYtb8DLeWPSBpKYMHdGa59VlPgMTnkZlcs3Zhn?=
 =?us-ascii?Q?x0n+YPXX8/GIn6HUU/M3pIIF1tmg+34fEAO6jgolb2femrElRcBxXTp1NU4j?=
 =?us-ascii?Q?KQblfFBtYP5ogfHe5hOJQ6qRVwuF4ZK2gPmO+KKKvVwL91Ya3DvBDoflDjQ5?=
 =?us-ascii?Q?BmQnxxftG3cF13x0vEi1+PJ2H6fpc3S6rGBBAIFaHK0AfYK5Z/GlktOF4SjA?=
 =?us-ascii?Q?YkI9d/cuw9I8xlCipJQ01wcV22MaNpugwNYaK4njQPWTfZdu/gkLubqokm8x?=
 =?us-ascii?Q?rwJW3t8ExZCVVRo7PBbB9g8fM2xABKsq4FDtZl0Oz8IrjKFKtyMas2gLkxuq?=
 =?us-ascii?Q?W5H9tAIPQ5VKroqsys5scb/4UvE7PEkL7DJTuukV/CsG25MSNiHmaYpGo/Zn?=
 =?us-ascii?Q?aOtBvwk6MtV4SH2UraXdG2a4S8gH8tVeez9r8D6cvv4kSvF7/uby9BqaPKqP?=
 =?us-ascii?Q?dKADlVNAXlYYdje4Y4mTjhqO0ezsZNu9m0L0MKUmdI2FRuVM0BJDWoK8x9G7?=
 =?us-ascii?Q?npl26NyZhMTgbjDvwbN8irTPFH1PWBDsw8kwTbK7UzcU1ff9ULHYzE+f4UwF?=
 =?us-ascii?Q?1dnVyDCho5X3OnC+AxJSScr8+UdGHmydA7RuR9CwgSCN55a04MPy3J5qqCvA?=
 =?us-ascii?Q?70BE03bOdcxx4NUX9SMVdcyTLMFi6Fca?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KhCn/qijSLp9x9dju1q2ZwLC9/Pf2kKLa919meJ7Yi0s5nMUSQaPObWuRgq0?=
 =?us-ascii?Q?Ndk9eo4JKfFkI6cZWoDWZAr9ulBu22U/9x5ThV8EGyp6SV+x8eSiRQU/Kf3s?=
 =?us-ascii?Q?lo3glN7SqjN5AMivBWwNUNHRhTQsSVVhRkNo+vcON2c3dHx8w0QdeA6/VgjZ?=
 =?us-ascii?Q?66YARm3YBWXrRQKNjtThV1NeEZ21iiaiC3qOPtR67xMiXN5OKlikY4M2DK0F?=
 =?us-ascii?Q?QN+TIJOY9h0oP3CNbF5/IlsYcturzc7IikYOmXmCd4NzX0ADivK5ZhvQskAL?=
 =?us-ascii?Q?Xi4US5LB4u4YhBcxMqrvyF84zszVaWOnG08f7qw039tXK2Z/H3+07yj4n2xX?=
 =?us-ascii?Q?Cj8i5rsMHV8/6RstJb+qeH1AgUX0x300zWXkgjsS5s4YEKi2rQRpByQSasyP?=
 =?us-ascii?Q?/7ej60ig4jr9nrbtaeTNP5YRZdvB29RNBq6ZPy6X5VxRFhmgDOSbpF6TTJEe?=
 =?us-ascii?Q?3ur6u4x4ftvnmOWNH5Owpi5zEHOferDbMGNEvLj+yPnnte0BqKdXGvro7NiA?=
 =?us-ascii?Q?Lktv8ja4ed5ddlp2nxFlCz/6v0ND5ZU6nYIBYaP70S9BVYSb2Of3vWa4UJPS?=
 =?us-ascii?Q?fngti4w2j8AvGkFnwB1oMa7FECSf18xpa5vwipFGEmn7vxuLqnHITGfo/CnT?=
 =?us-ascii?Q?MXn+tc6J2amO6wPqO5MGyhEnV4znRo1eZv3K0NbDYKc58azkdi8XEdSoU/n4?=
 =?us-ascii?Q?cwnwJ6S4OtLol03McoMHJQykAJDmv8ESJVThb+oKaUTqfG+FJuaDEtkGQQsF?=
 =?us-ascii?Q?slMoljrm6Uud4HeJILm183awkHUYoPi6PI3ctrNTsZzzO4xiIJByOkxU6OMh?=
 =?us-ascii?Q?Itq/BE7jhgpnBU1EXncIRdLAgJOovjwSMbw+gviYAwYXcKrd5H8hNp21WCef?=
 =?us-ascii?Q?0n1ugc+PREfcj59v5nybcxVIZ54NmY45Wrrgd2ppiLF87cnypWN3/OMb8CvK?=
 =?us-ascii?Q?yVkobDmrQPIMXIAU6LJzoTi0qRnQ9py1yU4AqX47DLFUpML3jjsfPFhyacPC?=
 =?us-ascii?Q?43v/1fgltW6V/Yg4+rBMB+o3pkDOULsLCxt9moG5wXy7CAqkjJEZhfgf3qes?=
 =?us-ascii?Q?O11WQAmnpj4YMMJkBGqVW6iurnWkRPAm1pTuan0b8TCJukZqz9f9iwC5sJcE?=
 =?us-ascii?Q?YwVyLMwDb/F1Q8jURywQStHOXiB1/D9UXGi/iGbdPsGc/ZDrqypcLejdUO5h?=
 =?us-ascii?Q?88f8y3qcukspdgZrlAkZ43kkm5szuphKnKtwOwZShif4Ll4QbRia+5k7xWZF?=
 =?us-ascii?Q?NRs/HTTDJ9Y9l5vGuaj20l6gqwR7v/H21xaxvbrYMoOSkZjyrkKqNgPVAxYt?=
 =?us-ascii?Q?CbAUGQOoPnxeztFtSk3kGR7DT3Ua15bT06JPJUvKclkJz3TfklsheFGWqsWr?=
 =?us-ascii?Q?YCm69oh+6MnD5gRq2V1sumJijsq5XYzZyLYIxprwxC9BFk/rB1nyCE6na9gl?=
 =?us-ascii?Q?79VzK3JPfQbxZWsuGLqMtD+7gxOPcoKy1YLU4yN3JOtyNljyTr+IVbnyekj0?=
 =?us-ascii?Q?sQWfab4gFX8LG0S2mYNhqgazhBIRHzucitJ5wVcLXHXivbq03cjF/Jlmbbt3?=
 =?us-ascii?Q?djbmfDqvgNPPWdTy4Pc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43313d7f-e2e3-4180-704d-08dd56911ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 18:12:24.3850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4k5OoumjkVFzydGepd5JMCs2diJuEcpvPv4T3epcN3Lni69Mblsl7cGlcMOkss4/NYANUvZEXM7CvpjeNrcDyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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
> From: Suanming Mou <suanmingm@nvidia.com>
> Sent: Wednesday, February 26, 2025 10:01 PM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Alex Vesker
> <valex@nvidia.com>
> Subject: [PATCH v2 1/3] net/mlx5/hws: support jump FDB Rx
>=20
> Before FW introduced the JUMP_FDB_RX action feature, jump from FDB Tx to
> Rx is not allowed. JUMP_FDB_RX feature introduces the internal loopback
> for Tx case and allow the REG C0 C1 B be preserved as well.
>=20
> This commit adds the JUMP_FDB_RX cap bit check and use JUMP_FDB_RX instea=
d
> of FT for dest table FDB Rx case.
>=20
> Signed-off-by: Suanming Mou <suanmingm@nvidia.com>
> Signed-off-by: Alex Vesker <valex@nvidia.com>
> ---
>=20
> v2: fix line lengh.
>=20
> ---
>  drivers/common/mlx5/mlx5_prm.h        |  9 ++++++++-
>  drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++++++-----
> drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
>  drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 +++++++++
>  drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
>  drivers/net/mlx5/hws/mlx5dr_context.c | 17 +++++++++++++++++
> drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
>  7 files changed, 63 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/common/mlx5/mlx5_prm.h
> b/drivers/common/mlx5/mlx5_prm.h index 3fc3b0cd2a..84e3347794 100644
> --- a/drivers/common/mlx5/mlx5_prm.h
> +++ b/drivers/common/mlx5/mlx5_prm.h
> @@ -2466,7 +2466,8 @@ struct mlx5_ifc_wqe_based_flow_table_cap_bits {
>  	u8 reserved_at_60[0x8];
>  	u8 max_header_modify_pattern_length[0x8];
>  	u8 ste_format[0x10];
> -	u8 stc_action_type[0x80];
> +	u8 stc_action_type_63_0[0x40];
> +	u8 stc_action_type_127_64[0x40];
>  	u8 header_insert_type[0x10];
>  	u8 header_remove_type[0x10];
>  	u8 trivial_match_definer[0x20];
> @@ -3543,6 +3544,11 @@ enum mlx5_ifc_rtc_reparse_mode {
>  	MLX5_IFC_RTC_REPARSE_BY_STC =3D 0x2,
>  };
>=20
> +enum mlx5_ifc_stc_action_type_bit_index {
> +	MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX =3D 64,
> +	MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX =3D 71, };
> +
>  #define MLX5_IFC_RTC_LINEAR_LOOKUP_TBL_LOG_MAX 16
>=20
>  struct mlx5_ifc_rtc_bits {
> @@ -3621,6 +3627,7 @@ enum mlx5_ifc_stc_action_type {
>  	MLX5_IFC_STC_ACTION_TYPE_ALLOW =3D 0x84,
>  	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_VPORT =3D 0x85,
>  	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_UPLINK =3D 0x86,
> +	MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX =3D 0x87,
>  };
>=20
>  enum mlx5_ifc_stc_reparse_mode {
> diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c
> b/drivers/net/mlx5/hws/mlx5dr_action.c
> index b9452a3ebc..e21db5b327 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_action.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_action.c
> @@ -803,6 +803,9 @@ int mlx5dr_action_root_build_attr(struct
> mlx5dr_rule_action rule_actions[],
>=20
>  		switch (action->type) {
>  		case MLX5DR_ACTION_TYP_TBL:
> +			attr[i].type =3D MLX5DV_FLOW_ACTION_DEST_DEVX;
> +			attr[i].obj =3D action->dest_tbl.devx_obj->obj;
> +			break;
>  		case MLX5DR_ACTION_TYP_TIR:
>  			attr[i].type =3D MLX5DV_FLOW_ACTION_DEST_DEVX;
>  			attr[i].obj =3D action->devx_obj;
> @@ -1097,6 +1100,17 @@ static void mlx5dr_action_fill_stc_attr(struct
> mlx5dr_action *action,
>  		}
>  		break;
>  	case MLX5DR_ACTION_TYP_TBL:
> +		attr->action_offset =3D MLX5DR_ACTION_OFFSET_HIT;
> +		attr->dest_table_id =3D obj->id;
> +		/* Only for unified FDB Rx case */
> +		if (mlx5dr_context_cap_stc(action->ctx,
> +		    MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX)
> &&
> +		    action->dest_tbl.type =3D=3D MLX5DR_TABLE_TYPE_FDB_RX)
> +			attr->action_type =3D
> MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX;
> +		else
> +			attr->action_type =3D MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;
> +
> +		break;
>  	case MLX5DR_ACTION_TYP_DEST_ARRAY:
>  		attr->action_type =3D MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT;
>  		attr->action_offset =3D MLX5DR_ACTION_OFFSET_HIT; @@ -1419,17
> +1433,19 @@ mlx5dr_action_create_dest_table(struct mlx5dr_context *ctx,
>  	if (!action)
>  		return NULL;
>=20
> +	action->dest_tbl.type =3D tbl->type;
> +
>  	if (mlx5dr_action_is_root_flags(flags)) {
>  		if (mlx5dr_context_shared_gvmi_used(ctx))
> -			action->devx_obj =3D tbl->local_ft->obj;
> +			action->dest_tbl.devx_obj =3D tbl->local_ft;
>  		else
> -			action->devx_obj =3D tbl->ft->obj;
> +			action->dest_tbl.devx_obj =3D tbl->ft;
>  	} else {
> +		action->dest_tbl.devx_obj =3D tbl->ft;
> +
>  		ret =3D mlx5dr_action_create_stcs(action, tbl->ft);
>  		if (ret)
>  			goto free_action;
> -
> -		action->devx_dest.devx_obj =3D tbl->ft;
>  	}
>=20
>  	return action;
> @@ -2526,7 +2542,7 @@ mlx5dr_action_create_dest_array(struct
> mlx5dr_context *ctx,
>  			case MLX5DR_ACTION_TYP_TBL:
>  				dest_list[i].destination_type =3D
>  					MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
> -				dest_list[i].destination_id =3D dests[i].dest-
> >devx_dest.devx_obj->id;
> +				dest_list[i].destination_id =3D dests[i].dest-
> >dest_tbl.devx_obj->id;
>  				fte_attr.action_flags |=3D
> MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>  				fte_attr.ignore_flow_level =3D 1;
>  				break;
> diff --git a/drivers/net/mlx5/hws/mlx5dr_action.h
> b/drivers/net/mlx5/hws/mlx5dr_action.h
> index b779e578fd..a582e2abbe 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_action.h
> +++ b/drivers/net/mlx5/hws/mlx5dr_action.h
> @@ -226,6 +226,10 @@ struct mlx5dr_action {
>  				struct {
>  					struct mlx5dr_matcher *matcher;
>  				} jump_to_matcher;
> +				struct {
> +					struct mlx5dr_devx_obj *devx_obj;
> +					enum mlx5dr_table_type type;
> +				} dest_tbl;
>  			};
>  		};
>=20
> diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.c
> b/drivers/net/mlx5/hws/mlx5dr_cmd.c
> index f609135ccb..9dd01cd583 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_cmd.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_cmd.c
> @@ -466,6 +466,7 @@ mlx5dr_cmd_stc_modify_set_stc_param(struct
> mlx5dr_cmd_stc_modify_attr *stc_attr,
>  		MLX5_SET(stc_ste_param_tir, stc_param, tirn, stc_attr-
> >dest_tir_num);
>  		break;
>  	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FT:
> +	case MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_FLOW_TABLE_FDB_RX:
>  		MLX5_SET(stc_ste_param_table, stc_param, table_id, stc_attr-
> >dest_table_id);
>  		break;
>  	case MLX5_IFC_STC_ACTION_TYPE_ACC_MODIFY_LIST:
> @@ -1280,6 +1281,14 @@ int mlx5dr_cmd_query_caps(struct ibv_context *ctx,
>  		caps->fdb_unified_en =3D MLX5_GET(query_hca_cap_out, out,
>  						capability.wqe_based_flow_table_cap.
>  						fdb_unified_en);
> +
> +		caps->stc_action_type_63_0 =3D MLX5_GET64(query_hca_cap_out,
> +							out,
> +
> 	capability.wqe_based_flow_table_cap.stc_action_type_63_0);
> +
> +		caps->stc_action_type_127_64 =3D MLX5_GET64(query_hca_cap_out,
> +							  out,
> +
> 	capability.wqe_based_flow_table_cap.stc_action_type_127_64);
>  	}
>=20
>  	if (caps->eswitch_manager) {
> diff --git a/drivers/net/mlx5/hws/mlx5dr_cmd.h
> b/drivers/net/mlx5/hws/mlx5dr_cmd.h
> index 3c615b8925..eb9643c555 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_cmd.h
> +++ b/drivers/net/mlx5/hws/mlx5dr_cmd.h
> @@ -250,6 +250,8 @@ struct mlx5dr_cmd_query_caps {
>  	bool roce;
>  	uint16_t roce_max_src_udp_port;
>  	uint16_t roce_min_src_udp_port;
> +	uint64_t stc_action_type_63_0;
> +	uint64_t stc_action_type_127_64;
>  	bool fdb_unified_en;
>  };
>=20
> diff --git a/drivers/net/mlx5/hws/mlx5dr_context.c
> b/drivers/net/mlx5/hws/mlx5dr_context.c
> index 91d05f1f86..a854b83ad8 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_context.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_context.c
> @@ -140,6 +140,23 @@ static int mlx5dr_context_uninit_pd(struct
> mlx5dr_context *ctx)
>  	return 0;
>  }
>=20
> +bool mlx5dr_context_cap_stc(struct mlx5dr_context *ctx, uint32_t bit) {
> +	uint32_t test_bit =3D bit;
> +
> +	if (bit >=3D MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX)
> +		test_bit -=3D MLX5_IFC_STC_ACTION_TYPE_BIT_64_INDEX;
> +
> +	switch (bit) {
> +	case MLX5_IFC_STC_ACTION_TYPE_JUMP_FLOW_TABLE_FDB_RX_BIT_INDEX:
> +		return ctx->caps->stc_action_type_127_64 & (0x1ull <<
> test_bit);
> +	default:
> +		break;
> +	}
> +
> +	return false;
> +}
> +
>  static void mlx5dr_context_check_hws_supp(struct mlx5dr_context *ctx)  {
>  	struct mlx5dr_cmd_query_caps *caps =3D ctx->caps; diff --git
> a/drivers/net/mlx5/hws/mlx5dr_context.h
> b/drivers/net/mlx5/hws/mlx5dr_context.h
> index e89a093c77..deb7196e39 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_context.h
> +++ b/drivers/net/mlx5/hws/mlx5dr_context.h
> @@ -75,4 +75,6 @@ uint8_t mlx5dr_context_get_reparse_mode(struct
> mlx5dr_context *ctx);  void mlx5dr_context_set_pool_tbl_attr(struct
> mlx5dr_pool_attr *attr,
>  				      enum mlx5dr_table_type table_type);
>=20
> +bool mlx5dr_context_cap_stc(struct mlx5dr_context *ctx, uint32_t bit);
> +
>  #endif /* MLX5DR_CONTEXT_H_ */
> --
> 2.34.1

Acked-by: Bing Zhao <bingz@nvidia.com>
