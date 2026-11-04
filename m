Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAC606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kqzL3/nG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB16C40A84;
	Wed,  4 Nov 2026 12:32:07 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by mails.dpdk.org (Postfix) with ESMTPS id 5FED34025A;
 Wed,  4 Nov 2026 12:32:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thvLTBQfjgjtZt6mDNSvzSWq976xPJVEuvEGnGirjHq75zchg8HP4d8THB9urO5ZjRX2476yFBphFSmBevmpfkb+uKogun88feqDi6LWEEK7RaVo9+4Nt2s+Lgo27N5el8IYzyIaezIvVyCx97ZgQd+IP2dNKL5V0EBxjK7UBwhVXjqFNl95er+57L7Xx52jY6gaIRh4CYrGXqVbNFLPJVtYq/5iXGNlsCI3LP04osI2pwDktRhsbhuBTYum3OivmbCWpWocxcL98dZqle0zadF2DEm4nuWnYLal4iEXt57o3vQWk3V2VF8P216uv7k7HTHfPxTdqF8d33FM/42BeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALBAz7v8xivLIvnK9i6jvxKvXJNI8PiH2Xh8/6OxHWI=;
 b=SvWaNmdtn80gFSlzOqBvYdtybb5RNdteUOAwIP2G42cgEQAsXZG4ZCwMMswOhVfjeOQF4yl7PRy8zVv2ipcigRm4d3slRMvukDmWjQSuIHaNfSYDlheguZ2zKjJpdKcA/idXbpu/gHv8sL8lKljAsQEZvswsRgKd9TyevL16fllNIjc0mz3jbtlxa1cREmc1FZ4YvLd5ZdlVN1bVwmUy+JufsQYKwn9ar9en8ckc99sAaJMrunWxMsp0nMEpRASv+zW1RjePhtkJAqg+AVStz+aRw2pCjbL3hduY7edCPksNPi5MvOvSrYQZQiPoWd0qyvgiwdimq6yFsIpvNNXiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALBAz7v8xivLIvnK9i6jvxKvXJNI8PiH2Xh8/6OxHWI=;
 b=kqzL3/nGlU4cqc6Yvd6Ouwy+t9GpYWh7PrMuMYwq51nKEV93AOX0Tecoo4TpX1OxKBy3SaCP6Uj4cLbgF61gMvAcv9f1crGTMk2zcimrRBKZfbwHMNGP8Km1Y1xRi7ubjs4x25NTKblBA/Uw56OvMuWWePIo9dIXAGni3tao8SD4KQut45Ea5iO43zv+t9qtxVKxXKpgyv5gLnDLG2lh9cTWBwY7pi38beplXV19+bepiEEi6qQCOw3z5oXJWLgE7/dbGUXruz6PBB503jfwy0YDguFqdlLYBrAY8JjKbK0FQyu71Nickj9jPQI0ovGUvw6SwpGmb1W639hzdI4Hbw==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 11:32:01 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 11:32:01 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: RE: [PATCH] net/mlx5: fix HWS sample action table leak on quit
Thread-Topic: [PATCH] net/mlx5: fix HWS sample action table leak on quit
Thread-Index: AQHdLVdwdZRdwH4G/UekR5EdCVUuJbceRVHA
Date: Wed, 4 Nov 2026 11:32:01 +0000
Message-ID: <BN9PR12MB53388C896B3FB78A88652430D0682@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260816081525.166446-1-mkashani@nvidia.com>
In-Reply-To: <20260816081525.166446-1-mkashani@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|LV8PR12MB9620:EE_
x-ms-office365-filtering-correlation-id: 614c6045-772a-449b-e9e4-08df3a673e62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|261021121427099003|261021123027099003|261009223027099003|38070700021|11063799006|18002099003|22082099003|261102123227099003|10067099003|56012099006;
x-microsoft-antispam-message-info: w4WEWWvSbr2EdK1U2YzKO4YJmW64dVln5JyADrLwpQ9owaYS7YODNNZcwhzFNOPnczQpDPBSiqKNGVrbLUEAoSW9H1KXfLtFjplzy0wIlJ3RE7XLqUd2QRghUbfX/YPEn6GW2L0M0/oXMbl/qk7CBRqTVMFrqAPCxyLvogOKPFfUo0mHrYCOnyLMVTtn2Vx1PaSfOtGX/Pzgx5/No2OI76vafevPSt+tMaTvjeZXRftMCO8F1qdGQKyx0MYUBBmu1F5FT65RoonMH5CePmIdbcnUdyWGVlCkRjvaoyXxWSID2DHdGVADxA5RHgOC8AuHHkEyt9KHYU2K5yt7m53H/qYKZ7KLVVgJ8ugdRqlefHjWKp/Am+aqLYLWv2Y5D0pp0nz6B67ygmU+tooibSQtGEGg6MGVdOD0oqt1hwlbVFINw52eTAJYFG8MK0ufsyHegIrtWWQ4Ah7vOLRZe3hkxKQCLPEwl9gOVrsZZV5A2xRbD7gacPicCyTD+YHsvPZsXJPbu+Hcfym2Wg42A1FvGDrdgxIUt9NUHN0xqKJzaGjTnbMZrVz/iwrRsS+WlRt+2J20yAUygSPetWOejPqjR1PeAQrobkZU4msjJHIi1HJc2DIKSv+usivmnYfw3eA1ryK/qBMGF63EbMh1tOlosooZEQCM5aDILAnH5Rekw4dDOQc77AYV2q1Edmv2tzWEeUSgYzPZxgoUP2VE8LIwYpamYJSqjg7+8tCun9atMd4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261021121427099003)(261021123027099003)(261009223027099003)(38070700021)(11063799006)(18002099003)(22082099003)(261102123227099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4SpA5raXCqsoXRs6VIBfWF/y9VVeEfWN67yy2xLpsEWtN8Oul32U5OgWvTSs?=
 =?us-ascii?Q?5i88t+O0xDV8tY09KKjpR9+6VPpukeW5lHgzPJs5ThGzDdjAk/t3cMtDnsvo?=
 =?us-ascii?Q?JBl2JV/lbjbQOypbY6XTUphW6mXKt7UYqJb4iHche70BSZeFm9x4J0xqVaGk?=
 =?us-ascii?Q?MH4KAUce3bKOtb0OjOHuAjjKEZO4wwkYOQu2T6IgXKO7rhN2OzyjwzYRkAg4?=
 =?us-ascii?Q?GVa5QxfnH8kCGpxkj0ThVnDmW8eMfb0KV76Fpj710GhQTpZc+6f8JtcSeR52?=
 =?us-ascii?Q?2DT+r8wPzo9fWrnHi03vGZMWuBbbFlz0ic0JZin0dLbtc/32h78XgVi9doGl?=
 =?us-ascii?Q?A7JbbThT5HTR3c+m3u0ENOH5jQuoJPG3NRHvLYG+EHhqRjbDsHBZpCZh0dnm?=
 =?us-ascii?Q?uHmv499dEKsj9Fsa0ndD69TJnbRpAv9pp6bIydGg0cO5yMt1p7yQCeb65zDO?=
 =?us-ascii?Q?ec5/7NtIizAnNH4CAPETrFhdfWCVsC5URN8kBBQ0CD5r2BzLrMfOUukuhqB8?=
 =?us-ascii?Q?gYY1cqQ09dvm5pfwNbfhiLM4ItNI43gr9VhHWB8kxqgCosTQbT3ou6nryIvQ?=
 =?us-ascii?Q?RLnDSM6ge657pjrj5ppcNh+6sEJ24Gx+dplnvmvVp/YBLn3ESNmW/wXGT4v4?=
 =?us-ascii?Q?oWH6WLkNPgMrK+QX6FjPgJFMyRGQBIpqrE2F/5IecS/s930GG2Mi5dVv60z/?=
 =?us-ascii?Q?hcIkLJwi5rKG+QN0LRDElIUu4J52YaeV/cSUgwsrLhF1KNDzDfvOnDkKLRL8?=
 =?us-ascii?Q?STGAIiQz9uHrwJ1w69+4DwgnKioa994u1UwtMOZSg/N8bfccQ9lVwdtIly6I?=
 =?us-ascii?Q?TIjf2kRmfXLMxUIQUMh7tx3nJLLgYubzQvRsp1O19mg4grhXN45tIT2lof74?=
 =?us-ascii?Q?dELub8c74UUTcYuExtIU0UfNcnm1sxawu8HbJnSgZbyuYXX55EliiNrueD/K?=
 =?us-ascii?Q?UNJAL/mlg/ADRMsnd2uK8ICDm0tzN8+k39eU5R3dMGkCXJtKK5xWA/xomBC5?=
 =?us-ascii?Q?AlC/oIhUsGgT5Pkvai/SJkCWsL0Fs039jm4DWNLkgt1wyOMDSw/NZXxKefnS?=
 =?us-ascii?Q?91/xQuYbpqVU9IK1jKUtJj0d9vIyyjgVJuWNxWB+yzxGj7EhZLr55p8KwDcH?=
 =?us-ascii?Q?MboxsonzOwiaU2O1FsbeGIFniPfB/+E6DvX4N+TJ9MP/BFGv7AhdMVmc0wKk?=
 =?us-ascii?Q?DJv5Spv1eF5pPAGB9q87bdDG/M/SAuo92e824JFsP4O4CY9/vjbqmvIomyRy?=
 =?us-ascii?Q?YgsbJi6kBABNjBTwRX0JhGWAIylzOPOHlsn+EU9dL75dcMmglV5anIlZdtF9?=
 =?us-ascii?Q?gcr+Ydm3vhGYiJ6GX5uGCXnx3ZrUT9ruXbu4ELVI5/CZIcaBxw6rL4RtUmd1?=
 =?us-ascii?Q?/6MXoek0ri1trmCAKJ2gsWPJ29IjEqBm2QVpdetETrom59KC7gt/q548Nfj2?=
 =?us-ascii?Q?CJ5T9b43urkP/pqmlEcGE+hGWnMJnpi7W/s03ww9DHfU2ugCZktLisMECnun?=
 =?us-ascii?Q?uvtCk7xp+Um2kDbyVzpQNBdt3S10X1pKT6pkebjjZwuHE+a6LdXTIDjNjM/d?=
 =?us-ascii?Q?eMIw6p/4LyF492ZAqS0Oa8nX32ELgj2Lmj8JY1Dj0TNBtuUOgiS7K+MtWX7i?=
 =?us-ascii?Q?pBLEaYoD7wXV0FXmuBxnTDZAnWA/gUn9K1GEnZvV/KQKUL1sEKKBvs4Oj1gL?=
 =?us-ascii?Q?7lcEmaFcdkIvzbLNRCqeaIPRng6IG98PXzetgrS0nIFOdSU/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614c6045-772a-449b-e9e4-08df3a673e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 11:32:01.1508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFvuBDRVZnGHANC7b/Z5r5S0Pd+Lw56lBN+2MeOrHtR/3vD6GdQqRQFF/dDi1wRd/ZXToyBSNUn61yW73w7QcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> -----Original Message-----
> From: Maayan Kashani <mkashani@nvidia.com>
> Sent: Sunday, August 16, 2026 4:15 PM
> To: dev@dpdk.org
> Cc: Maayan Kashani <mkashani@nvidia.com>; Raslan Darawsheh
> <rasland@nvidia.com>; stable@dpdk.org; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing
> Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; Gregory Etelson
> <getelson@nvidia.com>
> Subject: [PATCH] net/mlx5: fix HWS sample action table leak on quit
>=20
> Destroy the composite dest_array mirror action before releasing its clone
> destinations. Releasing a JUMP clone can drop the last group table
> reference while the dest_array still points at that table, leaving the
> firmware flow table objects leaked on port close.
>=20
> Fixes: 3564e928c759 ("net/mlx5: support HWS flow mirror action")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>  drivers/net/mlx5/mlx5_flow_hw.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c
> b/drivers/net/mlx5/mlx5_flow_hw.c index 1cffdcc54df..9abd1770a9b 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -14629,10 +14629,18 @@ mlx5_hw_mirror_destroy(struct rte_eth_dev *dev,
> struct mlx5_mirror *mirror)
>  	uint32_t i;
>=20
>  	mlx5_indirect_list_remove_entry(&mirror->indirect);
> -	for (i =3D 0; i < mirror->clones_num; i++)
> -		mlx5_mirror_destroy_clone(dev, &mirror->clone[i]);
> +	/*
> +	 * The mirror action is a composite dest_array that references each
> +	 * clone destination (jump table or Rx queue). It must be destroyed
> +	 * before the clones so the underlying destinations are no longer
> +	 * referenced when they are released; otherwise releasing a clone
> can
> +	 * drop the last reference to a group table and destroy it while the
> +	 * dest_array still points at it, leaking the firmware flow table.
> +	 */
>  	if (mirror->mirror_action)
>  		mlx5dr_action_destroy(mirror->mirror_action);
> +	for (i =3D 0; i < mirror->clones_num; i++)
> +		mlx5_mirror_destroy_clone(dev, &mirror->clone[i]);
>  	mlx5_free(mirror);
>  }
>=20
> --
> 2.21.0

Acked-by: Bing Zhao <bingz@nvidia.com>

