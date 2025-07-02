Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B35C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 07:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8175A40285;
	Wed,  2 Jul 2025 09:19:39 +0200 (CEST)
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com
 [52.119.213.150])
 by mails.dpdk.org (Postfix) with ESMTP id 613EE40269
 for <dev@dpdk.org>; Wed,  2 Jul 2025 09:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751440778; x=1782976778;
 h=from:cc:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=U2gDN+CXAByE+KbdWmo+w2fZrphRUuMY/0AyoIO6ymo=;
 b=Dm59xq1P4F727x9tJBG1y6SZCZWLUr0N17NivNHhrwVHUUkXsX6lsiyY
 vec94VpMfVwPZMoYt2wvkpV8oZA5FIzqbmB0vZAC63fJ1txxbc2PhSUKL
 Q9qM05H+H1GvqaKBSYLHIuqYayIA9lFWIb7LxlUUcbGYog78Imci3IFst
 RbEnL543eWn68S91M1E/ffz/FxYmXtaS01Cs73y4OCRBL5x0JPcLHhfKT
 8KfjVhhUYKBlzVVa5RnQ2BLyG4eUDHHGoSZvzm4sSPTOe1j0u5M2MCS3d
 EzoKZyKqoHfy5GNU029CmLyhtkukgBm8GxDhdam3Wvx5yw/igYusCL2O/ A==;
X-IronPort-AV: E=Sophos;i="6.16,281,1744070400"; d="scan'208";a="738370783"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:19:35 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.44.209:10435]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.21.214:2525]
 with esmtp (Farcaster)
 id 276c8d8c-2c3c-407e-a1b7-d1dfc91c2416; Wed, 2 Jul 2025 07:19:34 +0000 (UTC)
X-Farcaster-Flow-ID: 276c8d8c-2c3c-407e-a1b7-d1dfc91c2416
Received: from EX19EXOUEA002.ant.amazon.com (10.252.134.207) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Jul 2025 07:19:33 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.252.134.239)
 by EX19EXOUEA002.ant.amazon.com (10.252.134.207) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14
 via Frontend Transport; Wed, 2 Jul 2025 07:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRG6B8mVz/RDqQGBonByhe9u+yp9wSfq4x7V7kX8I1LpERnM+NHFQMIhJwxx++y28xcgySjlGAunynQbdN+r4niNtQMCNL1/X0sN8jupQ5yA6GhaZPLiX2mTUyVA9bURxZ2VQaPpIl2WvCV3K40IKu3FZgreBmHqfX9zLzjs+JvtA7NvOUB72QY9n+BHyS3WGutp0HSubSRdq9im+ieF2O4hc7Fuf5sAy6lkORjjdWT9xtiR60y4CjWLswQFvmifbJIef1ZMxtXXuFa0poFGbDwtVvNR71+883whckjGiictBj+retv2A09SFHUAT3vJpt+3iobowpCXXZyeLbcXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2gDN+CXAByE+KbdWmo+w2fZrphRUuMY/0AyoIO6ymo=;
 b=GeCtlM9ygeujPlQ9KLKDyUfBwD2pKUN6W1AoTxJIYAK7nvyy/nUPmtAsoC4wU+uUfPlWP8rnVg8fnWlPY0GE1kk6wlqTaTQa1uga/U99RaH6Rm5dxV/WxFIED52KK1jdzAxRYbABM1gqDvCfdPnXyUmjPsK6b65PcspnBkXCzvrGNOLxMX2EzKGPHgYcjZjWsTEwMCyaPl5bB9qXZfDhCoSxS8rBMZFwcyMWwEofXAhfS44i5dijMcvC7ried61TZYXJ5qk9DLIJ4hxwkJuxUCMGnmRK92qEpotSmQuQKYvRDW4zsN8FEgYa2HrsJRyA5ngFUVyOe+isP+ED8KCZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.onmicrosoft.com; s=selector2-amazon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2gDN+CXAByE+KbdWmo+w2fZrphRUuMY/0AyoIO6ymo=;
 b=tSk/NSMtXFVPoV1qdGU5rT+4FZXzi6dtpQrxrgcW4oMdEbH7f9JZiFDdaCa+9Sf94oS1KqBIHm2g6vGlVXTTCEG3ifK/+XkmiU480PG05vpkvevkF31sBwMazYONmrV95FbR94fjbiZduPo1ZuQrxFrcVzhnNEqpWVSKkzNIja0=
Received: from SN1PR18MB2351.namprd18.prod.outlook.com (2603:10b6:802:30::28)
 by CO6PR18MB4001.namprd18.prod.outlook.com (2603:10b6:5:34f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 07:19:31 +0000
Received: from SN1PR18MB2351.namprd18.prod.outlook.com
 ([fe80::bf35:e96a:c269:911]) by SN1PR18MB2351.namprd18.prod.outlook.com
 ([fe80::bf35:e96a:c269:911%5]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:19:31 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: RE: [PATCH 7/7] net/ena: upgrade driver version to 2.13.0
Thread-Topic: [PATCH 7/7] net/ena: upgrade driver version to 2.13.0
Thread-Index: AQHb6bB0cbhojH11PEuzygypEEAqcbQeb2tw
Date: Wed, 2 Jul 2025 07:19:31 +0000
Message-ID: <SN1PR18MB23511D49702C9A6C7DD50D18AF40A@SN1PR18MB2351.namprd18.prod.outlook.com>
References: <20250630111624.3677-1-shaibran@amazon.com>
In-Reply-To: <20250630111624.3677-1-shaibran@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR18MB2351:EE_|CO6PR18MB4001:EE_
x-ms-office365-filtering-correlation-id: e8e54414-321b-44d5-5dfd-08ddb938ca27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?91oadC8PSC97TvnOraIb2VKzP2uXy56X5nbgvA3XpjZHyhjBg5YGO6smuj5A?=
 =?us-ascii?Q?xP2wT2RfYCpcgsGP21n9XyjaRePYKQxU5qraFratJA95BpXH2ZTd6D1iq3ZV?=
 =?us-ascii?Q?6vCf8ncoSRKdByvRXvc0Jn+L+pLJ2aALEAZmjQFE/ZYwbLeYGiquPcoNjSqM?=
 =?us-ascii?Q?pygp7z63lg5azvcT1J5rw5FQqkFpM1wJhgzT2pexY0rb5UDhnZ7q6lZVJj/l?=
 =?us-ascii?Q?0OBfJuZQKaiocISGyV0uN7xj58Q740onZQSd/evIsoDbOZVBIBOCkZiYT0xu?=
 =?us-ascii?Q?iC6XawAbDTwQccMlQMDTiCUAx7k6MQQpGLrYdM7/9mOjCYDBBh3JAGSzpqp+?=
 =?us-ascii?Q?5fnkf0oDtulbBsfuFkPh7FKmlPSuVsuyALJ5d5smTEsqjs5zmQalIcvpE6S6?=
 =?us-ascii?Q?WOO5e5uhT9VCnlLnaqlZt6aHybAgk3j59baSENoD5Mq31BLjHZg3B1ZNnFHq?=
 =?us-ascii?Q?taSufQ4gIrqaB5cXSnE3z4QFdSo8jY0cAeCPXDNG3D+hK0xO0sKq52XqWILm?=
 =?us-ascii?Q?7SpYrTeiyGMMksv4cXO7S97+zM5SGtPTGQZlhOxwKtxct180eiKyqOMXyrQR?=
 =?us-ascii?Q?tdPmzWGh/nNPNLDdu+Y6hbUDlc/TsLFt/3+HyIL+M1MfcGrqlgUZa0Nv9HCW?=
 =?us-ascii?Q?K3vLNErAwdBko+QkU0lZci9ULdvEQJSVY1Cln8umrteeqlSZGbHqxXj8X5Ez?=
 =?us-ascii?Q?z3JXhF6RX0cUk+R0xTYlC6hhP2glC17gFUIjCNoXqE2RWABemkFlowDzCLk0?=
 =?us-ascii?Q?rvZad5HRKEebSV8WekGO/XUxQ1TPr61/Kue8e3zmeSmlVMNysiYt7rV4kAPL?=
 =?us-ascii?Q?yPWBG7tuZ57/zR1R+C2llDtcnLNISViEY5Y9bICdO+Vxtm4mTKZZks1QJJtv?=
 =?us-ascii?Q?EtBk3bEQAp67Hwr11N5/+nFRxMoJJCwGjkQOf0uhLPb6bSIxwJwrgpxW0d97?=
 =?us-ascii?Q?qEFQjGqBj12U6hHbF3nus7jMrEr8u/gB4uBpGVhL9JiAvtg420kzS0wLQdGR?=
 =?us-ascii?Q?q+UkdihnnVyLDS6zBCU35HpTepAFVh9Gm+Uv9wzPXdEeOi1ztDztFJ5oV0jk?=
 =?us-ascii?Q?a1gXWn1t9N4+fm6f7PCJ3wAtMRB/hlvfRinvjieaNQ9AkzBlMk/rUyANrxQz?=
 =?us-ascii?Q?LT4yNgMJW1A0heTyB49nFdGkQF16vmK0k80iHdbdzyKUIEG5YLge+N2b6jtj?=
 =?us-ascii?Q?xoB+AX4cTuqdEHf4OC8X22llcPueJnsXOMKPVbq0LYKNFhSWgKyovCye3SmE?=
 =?us-ascii?Q?GuEBynKGcnf4LgoKKDhNko/rhq29XAprX8Mp4XR0v7+DZk2iuHAijUNNiMlW?=
 =?us-ascii?Q?yKYSaSpARD9gqM3zkeCux1HVcBHojVKPyy5Pkj4rURVkAqKI00dz+jxTzaAU?=
 =?us-ascii?Q?yNHknl4quqM6j6LvOD/N9zkCYrnL2fu6pQKIu3jYJTn+s3dY/YlCeuTvpd2H?=
 =?us-ascii?Q?+iAsUrRajhE3MAXkVAw+3ddXbYE1vOvceMTlhpK/FXhIhqI0rjAi8Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR18MB2351.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SQLMGMgJk9iiLLeHjiqQiaUEVtFZzrMvJhKkhM4yaPavzZzuMOix0ZtG6Zaa?=
 =?us-ascii?Q?ZRWSNgqSQg9yoojPzZW05Hby5rrwjYnod2S5XQb/JZXFDvsprOAVo2kgc5gd?=
 =?us-ascii?Q?DG/+1jEj9EIqXq+26LGHUd2Q2ysHCzbC4OmSOFfMW3vqpOQ35+X5ihECC1eH?=
 =?us-ascii?Q?7/Xh5NRnDKVMu5ciy7MntphS/mdVmhrOyj2+KvSJc5tUDRNXF7NDCFLwOi0N?=
 =?us-ascii?Q?3xCBJ0ERYjXo105lWkNKOzkDoywAxP/2haIa6/V1QGNla4JfsyxgwSs+Mtko?=
 =?us-ascii?Q?zHoQoGBsAKsPb4SFcimxzHBoENs1vd2yXsh/oYJo7k0JyrvfYhbW8pvviazy?=
 =?us-ascii?Q?GFdB/0xwp1UW2t19nviH4TJ/WO+WG37rb/hbfFlxa79a2mrQY0+m6QaZdCty?=
 =?us-ascii?Q?oNhBgDCLjr5i0Ji5xwLHXMnqkHxYF6ezP8bdLRbRNkcB99/0h5I2VREjmcFh?=
 =?us-ascii?Q?tZIQGupJHabGEpI3lseiH6WOm0lylbm7avW42kAfMtqMaC9QWn1Y1bkousXy?=
 =?us-ascii?Q?6cGr4g9V4L6wXy21rKUfbsTdoV2o0A2mVsWyW79jws9uBcHtwZqQJi/AegOC?=
 =?us-ascii?Q?UzBligxzBYpxvBlVPenIGfvSTQWCBQAByHwiQeX6vC54p6LAIKti0E4P/JXk?=
 =?us-ascii?Q?ZTX9xQ7i/dsCXhWfg09NUZ009xJlLR3YD5HSiEju/+q1IlvxVBVIYpoVe0+7?=
 =?us-ascii?Q?aS8RMUn02YuJA6+Ym+t4aoq5ClJFvRrgKQXxR6uWxYbrKvywDgjqGuOV8rJJ?=
 =?us-ascii?Q?KXiiEnvIVynHzEO1rYwPDwctVjY1gPJE81KzWVl3ySgAdF2KY0iQuv0Dgfs5?=
 =?us-ascii?Q?MTrfq9Nc48UEJDUG1PXF7UiZZVkV4GD3R67QZSbJkdxrfyBXdpH8f7BfW4TB?=
 =?us-ascii?Q?jaYBU7vzW7s4HMWZK3z71mi6VDdCmDsspgwnVKiGYaTaqw866jZkrEMW6wKZ?=
 =?us-ascii?Q?kYAr+fGXlz40GNKwwA/GKkfEh2Hp4YTv8o6GEZ+tjquMYKseta0UOomPEpO5?=
 =?us-ascii?Q?cV9ViBZpS/4BEeMsVt/3oz1wVjnOlVfWZ/Cd6nLu+PtjsHOG2Vt8SSw5QLy0?=
 =?us-ascii?Q?m1wYvQxYHUJG3hzThQ2BPdJd0XVp8CqanAIJ3haCzgECjWu1Jj2IqHRy5yPA?=
 =?us-ascii?Q?Qu0Uu0mXWAseaRvqgAQGrISw0ArjkO5PJnTT3Uoe7hJJHgPp1oEW+JDfEgCE?=
 =?us-ascii?Q?IbcrHHyKbbH4K101XI9urwrH2dPeQSlahpvCH9p4p3VrPoAsfVAqnt2/azCr?=
 =?us-ascii?Q?1aSEm5s+288A+8XQch+MbO1lKrfrfg9cSvzqG/Dq7XyVgaTbPeZ2zgCrrrao?=
 =?us-ascii?Q?liacCicgaqtGcYXn1SrWODtzq/DvF+Ljr61e6TGAESP0BIvActVeScovyg1s?=
 =?us-ascii?Q?c7aRjPn2rMIceTVmmS0lPMTXqT+5SKngMtPc3cCkufwfwmdLt3Hvt25oac/k?=
 =?us-ascii?Q?VDRUIT56GGOgM+U+CMVR705RuBmyyxQkWwmGzLLHqsVTBZz3RDMA9nIKtVck?=
 =?us-ascii?Q?dv762M8uSXWtarf5sRXFX7FUfHNC4nMvsXxLtNVLilUrucCIgVk22QFPFbz6?=
 =?us-ascii?Q?M1oQVQk4UCkQz5jd46A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR18MB2351.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e54414-321b-44d5-5dfd-08ddb938ca27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 07:19:31.7125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FC2UhvHRAmnjLmasIgjQPkXRNyiDMLtY7trlq5n5ryQvLMepnOy0DltgSw/BHJ9vSQBOKfdh3siu1cKdmOj1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4001
X-OriginatorOrg: amazon.com
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

Recheck-request: iol-compile-amd64-testing

> -----Original Message-----
> From: Brandes, Shai <shaibran@amazon.com>
> Sent: Monday, June 30, 2025 2:16 PM
> To: stephen@networkplumber.org
> Cc: dev@dpdk.org; Brandes, Shai <shaibran@amazon.com>
> Subject: [PATCH 7/7] net/ena: upgrade driver version to 2.13.0
>=20
> Upgraded the driver version to 2.13.0.
>=20
> Signed-off-by: Shai Brandes <shaibran@amazon.com>
> Reviewed-by: Amit Bernstein <amitbern@amazon.com>
> Reviewed-by: Yosef Raisman <yraisman@amazon.com>
> ---
>  drivers/net/ena/ena_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
> index 04a698b58c..f5cf5c3811 100644
> --- a/drivers/net/ena/ena_ethdev.c
> +++ b/drivers/net/ena/ena_ethdev.c
> @@ -22,7 +22,7 @@
>  #include <ena_eth_io_defs.h>
>=20
>  #define DRV_MODULE_VER_MAJOR	2
> -#define DRV_MODULE_VER_MINOR	12
> +#define DRV_MODULE_VER_MINOR	13
>  #define DRV_MODULE_VER_SUBMINOR	0
>=20
>  #define __MERGE_64B_H_L(h, l) (((uint64_t)h << 32) | l)
> --
> 2.17.1

