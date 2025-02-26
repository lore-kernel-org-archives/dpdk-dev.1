Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB06DC021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 18:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D91D64029F;
	Wed, 26 Feb 2025 19:14:02 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by mails.dpdk.org (Postfix) with ESMTP id B195D4026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 19:14:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0d4yUwV/fr0hZlhSJFFk2QK9xXeh/sukurMhZsfu5y/lP9sdStRSfxuxK062TSAI2B7PC6VWDUxYkRfRO0WluoTbUCfinBsPQECLYPEnuSUl+xBiP5s3Hq021jjSrgDuqLJ5rA8TvGGF3K/mzLAUQERo9bwxN/L0nHqB7cs/68x8VtOvXWO0beWYcIp6sGAeUDyXImseeSCdBukNeJ4uWCH456JBmvHtseVXcSeITeDJy6+rQR+bLgIWApPsO2DESqdkiBPJ93I3ipI/Ndn1aa3xM43ZHFHLjPywS7qKtpEFU5YGgNsgLME3omd6EM414Si2hJ3wOamsXNQWWG5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsuR6l30F56hELoPeRmYp9slvgKH+42ODlA16tU7LKg=;
 b=nN3ZiBS78JCglr2WwoDJYcBrg0JPH25/rHj0AblkLrjvzDsGrnfvGI2f2/Y0Xs1ngRdikUDGZ1qLa6FC6Vy1dIfyEVXOjWMMZ1wc1ndsmFvkE0xKkD7rpWAJ7py4RRZpZf7T6dYMZQD1iG2+Xo1973KN45GtjQTLeckCWnZgzGkz1tUuEtkcknlcM/QSpAPRZzbBLB4lD8UcAJoksWxqkfCF7pYGPZUa7cHFsd0+JnMcDNmHBTWZRkFlUzosXaJmF9/7U62u8r4gWl5rxPTyWlx7OZ9u/sQaPyQdzqTPGGwP55q3BjGd8LbqZtPW9KjAtOCI17j+NMVl2ygdz4m22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsuR6l30F56hELoPeRmYp9slvgKH+42ODlA16tU7LKg=;
 b=VaErYZ3tQqs6ZtMb5xB7+2/5dFuNsZ1X6AekNMPv0ymsPdLr+mCWczLk0prKsiJDY/SyPPz7rA1oZbaBOYuw2b/Qh9ca/sTYRgQBshg8KSOGlEQ+lAQWNlgzIqC5WlKti90ekRCGmhMouUulNfpiE2vVVtbJ/SNyDADDDT+z73MW6OwBI/fAoOxodBMUJFhSgwOiY00mEkPDt6QF3oBlrgbKnEyBYZPRkcdQ3ft3vLJPWTM7GBx1kPjiVATRqV09ff6yoSTwKwKbdFWzggGh9pH0xM3mi6Mcb13Azzwpbr/Gf7fFm6V901QOq8UzK102FixQxOZwNnOhPHWf0CNCMw==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 18:13:59 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::33b4:19c2:2281:b662%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 18:13:59 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH v3 0/3] net/mlx5: support jump FDB Rx
Thread-Topic: [PATCH v3 0/3] net/mlx5: support jump FDB Rx
Thread-Index: AQHbiGg3oOL2bO2j1Uay0GNhGRDtHbNZ44mA
Date: Wed, 26 Feb 2025 18:13:58 +0000
Message-ID: <PH7PR12MB6905715DA471B495E7800E89D0C22@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250226140119.2142352-1-suanmingm@nvidia.com>
 <20250226160425.78147-1-dsosnowski@nvidia.com>
In-Reply-To: <20250226160425.78147-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|SN7PR12MB7023:EE_
x-ms-office365-filtering-correlation-id: 8272a9ad-919a-498c-222e-08dd5691573d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S8jJ5kTv4QwvlnFqskP/CTXFPi6UMPEFOhqltT4WXEVXvwIXS73vLWqk53nV?=
 =?us-ascii?Q?0frSY/RwxksyntydigKm3ZXVUY24rJdi/Wf0SiVhfO02KY2Re4IteuE/fD2w?=
 =?us-ascii?Q?FZDoZj0dQzF5x1LIFr+NGWbIq788mxuTfiajyFWRX10CQEuhRNyq8FtRtIT3?=
 =?us-ascii?Q?66duaMpBhBXY7O/zewKXFi/4Mx7N0p62+HZ9CUVzuBBFkWlOf2LiYQSZ2va/?=
 =?us-ascii?Q?G5LmaK1S5P3CAD6VED5p/keTEZYT8FndEedf6iWT/rkY7AWtzqt7dYw20yIP?=
 =?us-ascii?Q?rRfm1eL8laL8Q8T3rM9zOGv+Lacm8EAWBYoMcs49N/cNEiGvMZ59Bbrq+Mn+?=
 =?us-ascii?Q?oALexkx5NyPOttBQdE6E3sr6QRYoMnPOfK9OB4IItMqyArGV4fpJpOcZdhgU?=
 =?us-ascii?Q?+15bR+J3CilIAm1+Uw+4Sjo3s8K2fUV9BQ8emwsWJaTdNVh1Th+wOwcXZ7FQ?=
 =?us-ascii?Q?gZVm93Fj/0DpK5Tqj6Vt1h74gnw19NPfXDwBszxSl8zlmR2S9U9PJCceMklx?=
 =?us-ascii?Q?S7S6iBsIJ+O5Qw9EgeWL72oi+qNuN7PX0PukirlOaEBJ0gC96pGIcn+MAiTl?=
 =?us-ascii?Q?YWloIwiEU7MEAXljrgP/WvCraeUwlP5/eFC0Hc+nJCvAr4p1nvvzleschaKg?=
 =?us-ascii?Q?SCB+ZmEHUL72gC2DQMlQEm8XKKKGocyI3DxWl/hJdFUG+M0ps/ZjCITcDYAx?=
 =?us-ascii?Q?rcNKE7aeXfMS6vLum0go122ju5O+4rTkt15plaaY1PRhW88cVQfXAdJ1e3pF?=
 =?us-ascii?Q?y9XHC+XGb17yTW/qjIxSKBEiqoM6j921q/ya6Jz0ObyAGC8bJAGx0X32IIgI?=
 =?us-ascii?Q?m+CSXNc0Q8SG4J5SDYwEhyUewC8DHdFw99KzGVMvr03l71fUI53j3j7mlycd?=
 =?us-ascii?Q?jFxRY4GMATay5cmRn/d/+BjXNLdzTTClkkXbDxuYTt9uGRT9DTEc/U5qXPaX?=
 =?us-ascii?Q?sgQff91WlE6iWD6CPD2N7c3mRkCm1/g6kLdGxVQORUerarWWWXl7s/rYvhb3?=
 =?us-ascii?Q?Xj9sdHDbFKoHc24Lu+xuem+D9Wp6gtLRQkf9oQ/92jb70M08gAW9T8VI3ZS7?=
 =?us-ascii?Q?79qBhE9HwwgwHj4jRxEXF4miOgBwncKm7TOaDt0ZG0hB8/0pU7dV0JGE8RCm?=
 =?us-ascii?Q?CbAJBN566UpkYuk8gjZoVus6Mx2WlxgkIjbColFaWtyk/O6tlsSzHyTJC06W?=
 =?us-ascii?Q?bvdKeE0PiYrkr3x3MlWHvmAhhilaAmnTBjMJqQFaqkTK7EavpDDGRT9icGiw?=
 =?us-ascii?Q?MDfci4kePYaPy4QHvwV/qg83BCb5u7R5RhdIneD6cQU6L/rJLv1XeZgXUPN+?=
 =?us-ascii?Q?8xmIJBTan7YHYIQAgCGbhdHBf6bmDhSUMiBZgPDzFe84On0sZhkfylNp8+JH?=
 =?us-ascii?Q?O9Ho4CMzcFSsscDTC99braPyT9F3fC6bxWfx0K4q2lSRyooMC80Rb3qeVxYJ?=
 =?us-ascii?Q?cpJ64VR4GHJ9xaO9ET3/mgR3r3zlijwI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gu8w+adSZDsU25Nqe4RNTbaPX91h7ZnQFfOykslr9xGRkYn6S2eN5bniYchR?=
 =?us-ascii?Q?XXFAY/nMuflbX9rMPddRA/fdTzYGJ9ryjb8nadGO6G9m/vHDzyvxT4Nom2ok?=
 =?us-ascii?Q?b/atrQS6xoCuDMGQZfHoYrbOsFS8zTC0V1bS8QpWzxsDQrwF+pz5Ip0b8jE5?=
 =?us-ascii?Q?NIVBEdJ4vhJlzzONd8URLjGG2nocj1fJTjG87hX6S2RQ9N5J0Fg65fchTGdJ?=
 =?us-ascii?Q?v7lovNqaYFeslpP2deMZYHRfGoJbmLPzoHS5S1pQ11hdo8YpYIfqd6YXaX11?=
 =?us-ascii?Q?TrjQ09g2vdwkPjwtxlJICajCgyjwjnXEOnlZ7q1mXkgu3rl1nsTDBdy8DI12?=
 =?us-ascii?Q?K5moYQRawfqfx+nU8uivoUuuJKMWXyDGt4OWwsZZShFnY8f6SAXeH+GLpt9n?=
 =?us-ascii?Q?QOpo02Vd7nZR2zTVQD/6mF4yvxVA84L14T2QfIQAw04KhIGfs38Kj+t8BpAh?=
 =?us-ascii?Q?nFe8evTWfl842MEPdexlYhuZAd6Sq6320yutzW2ANZCcn1yH5jjS+ocZqO81?=
 =?us-ascii?Q?ID8nKuyls96lUtjDVWEEc61hmzOvjGWpkgsNrMRVpqHIgVwAkAuU6MXAsBcy?=
 =?us-ascii?Q?b1IUTRvijMp1H7byUCjkgiI3Gs8p350G+WCsHSWT8Xz3AHmIle4474ziSXCw?=
 =?us-ascii?Q?e5eVXaiDWKjFc2VKlB0QDKnvdujqJusbc5IPLcsyJNMn1xC59KOqaO3c3egk?=
 =?us-ascii?Q?gdZySNIpLH+DCL4xfoNH0+7h7o/+zbftfMBsOQeeqBTuV/RAQDvBDGJavbo3?=
 =?us-ascii?Q?aONdpjjpdpiXVAaEL/CudpHPsD0oDHeYC/1ZKN79GM9SkqSYjORPNvrwRO5v?=
 =?us-ascii?Q?abOQhbhtYWQ7WLm7uZrdI32rqVi4+wU5ybx9i19Lx5lLPbcd2XCEr1U+BcSz?=
 =?us-ascii?Q?Q4zN2gtSAbqLs/DSr8SB/Whg5Vnu7e84RM7wb/+bYjH9xKcFB80BA6gs1TA1?=
 =?us-ascii?Q?0Co11cge2w5Z6TIyra+4DC16eFF1T7M/TDtaW/rvNS/dYv3uvokHHfyjIU3R?=
 =?us-ascii?Q?ToaOuJeZ7hgkDEYdOz1pF56JRdP5YopomaOpHPjFFSTFVnBhEBEXh57UQtPK?=
 =?us-ascii?Q?zmxIB03ZwlvrZXjYivXYiDvxDbZVeqAV8vddW5hL6Y5MBXHypEI0Vcd6+cvc?=
 =?us-ascii?Q?GpptR+z12QDkVwA7s09KxqnzeM+VffzoPv+hL8Mijj+wVtaV6FQBWCrsHx74?=
 =?us-ascii?Q?jUBd/IU8OS0mHVvE7fuPtC8r5rGwW2hqVNHZzLzsxEg8AgtebdFDE09xUA7h?=
 =?us-ascii?Q?rW0VsLGkoKmTAlwulSKaYrA82q8E0fLdxTUx35fgZMqKlpGyzQDdWvqvYN2L?=
 =?us-ascii?Q?yyHF12Zvz99c0NUW6bmyLGi2hkTbtxj6ocQ5ky8oBfIbjgmUDpNY+NVNm7WZ?=
 =?us-ascii?Q?RM+3zjWs8sqT/FwXu16aCxfZp883WF/mdds7+R5LCDLIznlbkFyQ+NLBGkGy?=
 =?us-ascii?Q?j1lb/zrag/tp7qFzHS1l2W6Pvx6jNLN6ASbPd0mdyqzUDQ6LxnaPWcI/xvJB?=
 =?us-ascii?Q?9EIaINHn39oqvObqOdMbk+opCGNABH7SmqGD4pMOHc1IC1Nu2jv038fFH5NE?=
 =?us-ascii?Q?xhglSrExEQS4tbZSeZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8272a9ad-919a-498c-222e-08dd5691573d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 18:13:58.9928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Il/IlYfq3zV77Y+tGO0+MzKj5uojE5rru5Y8DMAdsCOuodZUPSrlRzFqJ3eoC704Imoz+oNqYB6LkYEp25gMw==
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

Thanks a lot, Dariusz.

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Thursday, February 27, 2025 12:04 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH v3 0/3] net/mlx5: support jump FDB Rx
>=20
> Before FW introduced the JUMP_FDB_RX action feature, jump from FDB Tx to
> Rx is not allowed. JUMP_FDB_RX feature introduces the internal loopback
> for Tx case and allow the REG C0 C1 B be preserved as well.
>=20
> This series adds the jump from FDB Tx to FDB Rx support and allows RSS
> action in FDB domain rule when jump FDB Rx is supported.
>=20
> v3:
> - Rebased on v2 of mlx5 Unified FDB patches (series 34723)
>=20
> Suanming Mou (3):
>   net/mlx5/hws: support jump FDB Rx
>   net/mlx5: add jump FDB Rx flag
>   net/mlx5: allow FDB RSS
>=20
>  doc/guides/nics/mlx5.rst              |  4 ++++
>  drivers/common/mlx5/mlx5_devx_cmds.c  |  8 +++++++
> drivers/common/mlx5/mlx5_devx_cmds.h  |  1 +
>  drivers/common/mlx5/mlx5_prm.h        |  9 +++++++-
>  drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++++++-----
> drivers/net/mlx5/hws/mlx5dr_action.h  |  4 ++++
>  drivers/net/mlx5/hws/mlx5dr_cmd.c     |  9 ++++++++
>  drivers/net/mlx5/hws/mlx5dr_cmd.h     |  2 ++
>  drivers/net/mlx5/hws/mlx5dr_context.c | 17 ++++++++++++++
> drivers/net/mlx5/hws/mlx5dr_context.h |  2 ++
>  drivers/net/mlx5/linux/mlx5_os.c      |  9 ++++++--
>  drivers/net/mlx5/mlx5.h               |  1 +
>  drivers/net/mlx5/mlx5_flow.c          |  4 ++--
>  drivers/net/mlx5/mlx5_flow_dv.c       | 32 ++++++++++++++-------------
>  drivers/net/mlx5/mlx5_flow_hw.c       | 28 ++++++++++++++++++-----
>  15 files changed, 125 insertions(+), 31 deletions(-)
>=20
> --
> 2.39.5

