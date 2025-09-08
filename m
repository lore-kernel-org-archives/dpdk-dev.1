Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC44CA1016
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 06:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A44BF40264;
	Mon,  8 Sep 2025 08:36:56 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by mails.dpdk.org (Postfix) with ESMTP id 4B538400EF
 for <dev@dpdk.org>; Mon,  8 Sep 2025 08:36:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7ntIGsBoUTSuBMMfS8yqVoAxkzY+OzaX36kmu4DfBRpYLEy372PoheUymfIo0e46dkUZKYStd5fcBV2adt0YSaPAeDXRpE0Usiw+uFXrZxzW1nTos8yUHRqwwl3cKzZNu1FKbpamaYNWXOPO26XrrUSbd3REcuaT8mUOePu+FzwZXiKJ2MUsYazZI9+WfjRZDfQgjHwkHLagFRtrn64mtSa3eAhXbGyYKZGWf7fdLP3YRrNRFOYaeGgOqQYC4iJGwBPzFEn9dUHCKu2c6azm+1JsYxdUT9Oz6daCNkJnCR4cf5nzxxJS0u9vCXzWxj4WqrnLtspeQd6pwMZ/kEtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnmQS8wVah9LUiw44uNK1WIoBqHYG4ftKtjSo34tCTQ=;
 b=k3+Bu3txa+wnIVUSUywG2gB+RE83jVDbr4uFoP/BTAJPiv4FZODOD/W0rZJXHBRkz8IIni7FQS+kt4y5sKUIjj6pipdGXAXm8DEJiwDMxTZ6qXO8kIgjjGYzxTUt9UNry0iBaieFgGu5AXT2Bxcj3hNbfLp78susJHt2j57ibOhBlUo3qWI5Nr7DfOEznOYkw7W7xPBQYKIfX8+dRGMRjKm7x9P1G5EI/y7pA9vzxjPCbiUZARFu4ZXdpFpgYwKo4LeUa5HpkDWj6o1RmjcWOuVAZ42QfNOBXX80+n6jmdHw5CIJauTMhZjylg9eboxxPmOL8IGQnYZjOML1PccR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnmQS8wVah9LUiw44uNK1WIoBqHYG4ftKtjSo34tCTQ=;
 b=Nor0MLX7fkY/ryfGspXLPdouBHBKZNFptUMpDCVAR880NenwoNBY3/qfH/NNEZ19uVAg2JGvnuNkqrjsrCg3xIQiFBQh0TSk6SX4tnR9Xn83aerFuoxiTEsdFEWJRvB5aYyB6/9Edb62wTn1OJ2w4dot3zV+yqFNJgpedHwA1Lq9OV6zOHw46MCwsA/Lxq1Ryb1PtkFYyfxLVl9zR3sKmf9WZzIPBGYh5VWBim855olXzR6Zcyl6HC6HKJfgsgJq82kBBumAES3KyJOWS/62uYKgmGA7/SD/bii4CmRsnFV3Nw8bkh+ZlE2wjo1cu7DUQRQIDdlTdpcQSCZDyyOf5g==
Received: from DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) by
 DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 06:36:51 +0000
Received: from DS0PR12MB8561.namprd12.prod.outlook.com
 ([fe80::9b96:73cf:f78:e41f]) by DS0PR12MB8561.namprd12.prod.outlook.com
 ([fe80::9b96:73cf:f78:e41f%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:36:51 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: "Minggang(Gavin) Li" <gavinl@nvidia.com>, Matan Azrad <matan@nvidia.com>, 
 Ori Kam <orika@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V4 1/2] net/mlx5: update how MAC address bit-fields are
 used
Thread-Topic: [PATCH V4 1/2] net/mlx5: update how MAC address bit-fields are
 used
Thread-Index: AQHcGMS78GgrTmUnSUWkH6MuiERjgLSI5EkQ
Date: Mon, 8 Sep 2025 06:36:51 +0000
Message-ID: <DS0PR12MB85613A5B9168391873AD79BFDF0CA@DS0PR12MB8561.namprd12.prod.outlook.com>
References: <20250825141322.974335-3-gavinl@nvidia.com>
 <20250829090830.1049176-1-gavinl@nvidia.com>
 <20250829090830.1049176-2-gavinl@nvidia.com>
In-Reply-To: <20250829090830.1049176-2-gavinl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8561:EE_|DS7PR12MB8083:EE_
x-ms-office365-filtering-correlation-id: 252f53c1-e875-4e29-9c63-08ddeea2183a
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KlF9RBYTV/s8nhmsRTgOuvUHdsfzRgcZq08VOsLO7OxHUjgYE/47i0ECIxdP?=
 =?us-ascii?Q?utuQI1ljG+6YQr93cGjINRTbap8GiN7/7kEI7PJDs94fWW/m+0njKTsuDR+8?=
 =?us-ascii?Q?D/dD0V+B4Km0lN/bwmCg6Gv58aRqP+DP/5DJEeAn5nw03zy6Oat2wdu2zFWe?=
 =?us-ascii?Q?+VfqN2I5+0p24TaDb0P5bNRN/YNrVkTvzu8qFzyKLENpBBB/s428QWwFF1SV?=
 =?us-ascii?Q?RY4INu+R738wMCz/Xw1AXUp3YcfX0MB0S6Aw+UuyBFk00XhLr5RKLDNwBste?=
 =?us-ascii?Q?moSO91WJTpAU+7/W1i5v0verUSXEOA2x/yFRmr61f3cyicYrPGoUNy/HD64T?=
 =?us-ascii?Q?E66GXhedTKVI6auVAmKeEBVwm5CGK5UDBD+SCyQgZDbkvjhsCSCFUaeGRVxD?=
 =?us-ascii?Q?s5Lr7EsowqMvImc9pALvvWLcgeFxZbb6be/uPJwb6EuaC93X71FnjgyR6v+S?=
 =?us-ascii?Q?0XeQym4HibKF3++Jphq0WIF5imokq8yRzDu3nBUwh2mz82eqD9TIpwtS03wP?=
 =?us-ascii?Q?za4thZ5jea+T6o5Fh5B/r37XDH6nm2690cwUja28zT7ju5C+5pAiWy+b7e3p?=
 =?us-ascii?Q?fozsZ2dS8j13jZpCp2nuAvJAc7ZqK2MKYg4MjZvNdoLYIc3owXAzcS8tkItM?=
 =?us-ascii?Q?8DWk4y8/bvIFZp1YRMMhCXVaGjQAnWUomMxag5ds0U+qgmfNEHGw6dkJehUQ?=
 =?us-ascii?Q?nmxr/o6IZ2qVt2fp/ZHx6XDqWgBKxhG7LCSWnPu4WHRchWP77xAMuHBKUgbr?=
 =?us-ascii?Q?YmboxhXWP4FoeEXIwAzatwJQEKp8o+z3Endjw9ewQTeVCVPmHut8oNB5ikln?=
 =?us-ascii?Q?9hq4er8pLU0uhEdrl+XQttbI8xm5kOJzhXmeo9sATWp7bBKcuGvgwGzIia/1?=
 =?us-ascii?Q?YP0RZPX1itU4JHkkiucryFLcLOcghYDgsbUrAMHqRPb/oq+bCnxgQ4L2i+FL?=
 =?us-ascii?Q?99p+plMAWATIfd/KSOgB16yomffZ/QmX4XYkYEgV5QSs+HQMM0kOkmZxUmS6?=
 =?us-ascii?Q?rulIWI5U+sndKOWzfcnKFWITdEVj4sAT5Tc4IhmqDlht1ec2C8xzyJR/fBUW?=
 =?us-ascii?Q?8UORpgF85Yd+yjwH9VLfoy99A+aYEGawnI+wRTWFk0KLkHMOoz5WVzC8MzLk?=
 =?us-ascii?Q?M/JQAXK63r/o4BSr+Okx5CJyMWg2pDMNi1vSzswxVs/qqeZvALmQizuFIuKA?=
 =?us-ascii?Q?JToQ0dh4Ch+d3oc8Q4SnZDWR84nllpPCcT3/qfhaPPibsPwHHZbQN/Lkr1IR?=
 =?us-ascii?Q?DiDp9Q9mZR93LxsWSHJeOc7YZnmhREr4TTTgrPPfTK+hKnaCWMCrUh2ilfRg?=
 =?us-ascii?Q?3VPoFvuGqamqnz2E4Ltd2hrZ9i+hf4umApJ0SNhqem35jbWnPiD7W/JPp0Yk?=
 =?us-ascii?Q?6MZj2MFCrfRbeofzxpAp31Jon7uFjYlNJ6AYlSHLqK1D6NAHuF8qo5TM/gYs?=
 =?us-ascii?Q?+5F1WQwa+DIUbpxb0N596Nc91mpZzCoDb4/yeNnBUuA1r4KKKE4vEOzIl84h?=
 =?us-ascii?Q?ZtlOmYWUaCeBDsY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wcgCF85TMVNhRtyXIQUgM8mN2fQoTGPZLj5fWcAo1mijhLOwfuJlwo5ljIn?=
 =?us-ascii?Q?f/AJMElvAaIbAaS7YxT1bG7ln0vFnr+pskfBT4QI5YQl5k0QX/47+1GnJFVs?=
 =?us-ascii?Q?eQzNLlDdowH8SlsMgySpM25cubNWgC6yi5VMvmWV7BKD8nYMjYM8O4p0n+gA?=
 =?us-ascii?Q?DdLHVvNVrtCT1jwBGr4KeaU8IECHSUSefd6SIprkESepl0q9oRxGVybH4Ifo?=
 =?us-ascii?Q?YWfzzVCyI1aBSln0Ui+qDi+kCqx2JElVMrjnTh+UnjlfHVSb+D2aq8tkQ5Fw?=
 =?us-ascii?Q?3xwydlNhqYuxRBMPFgNYnQa/HxUmX53HtCB1no1AkxOky9T6R7AENVDHZibZ?=
 =?us-ascii?Q?03FVJIZfsjq4v3qFxjPPSs0kpDw5agPR4DkAQ28Z3p9I3z5YyLXuwCm4i366?=
 =?us-ascii?Q?zHBZfVYdhW0wy1P11Pbk3aYIZqhrYPhOBwCBknDeK46pi38iGPp5gM2BcbRa?=
 =?us-ascii?Q?sDq7T0EZoskSmUrj87uI9spATT5NT//37kzK1hBFnSMLT1IwgvDvOCTyGc2J?=
 =?us-ascii?Q?/1nCRhoI1hbpIu0BNiTTzm5NPFjjW1JfqtW0qXWKW3oEcW++7JIyAqYnnbmj?=
 =?us-ascii?Q?VB//RU1Yc90UjyudPpT4tehy+ABTPl7il/rJJ5Nh1AY4OsCMQXf/8aPl2UhY?=
 =?us-ascii?Q?dmhzmASJ9eTXoxuoDcf7YIFKZPt9g1+WuD16pO8OVzLzwCYdl4OAh1Yp8L7R?=
 =?us-ascii?Q?Dsm8QDDtfFFA89T9hos8O4NcH3VlrYkn74wlbzWWEuPBkziGG4tnFJdZvWA5?=
 =?us-ascii?Q?YlyWDPtenAe5F66nmFtEH98iCskNZ2qtd+kNpYjCPqY6sg0JhYQ0NLgJp72P?=
 =?us-ascii?Q?V0s3g+Ic13zDI1YlkWQFXpCijXIBd7y6Nlik/NjPzR+m5T/j+rReTVuO/cUb?=
 =?us-ascii?Q?y0W2Go2S1mlqKt8bKLTNyc7oCHWcRP51Igj/rMs3Uf00J0S+rW3uc6qRp9TF?=
 =?us-ascii?Q?ytGjIAcUL+bNo7k1HYtAf35fPCk4zZOrTRkgZWLcBhXp5FK7x6O52Q2dCMPA?=
 =?us-ascii?Q?twI+S5g8lheCO23a0uC4osHfUb/sW9e9lG9sUwQzkoPBfDtI8MvH8QyZOrCx?=
 =?us-ascii?Q?3DEeMQ3x2b+hZ3/oWdra1CnIFj13/IzcE7jkltyhlv0K8GFYb5agHVpoWabh?=
 =?us-ascii?Q?n1bjgBCtkGO/dvIiBZ3N+oWoKN0qBDR1Shy7YUMwaJ4HBbRW9JpigpWKfO1h?=
 =?us-ascii?Q?zhBZe70VJydHp7TG+ObqMaIoh720s2Z9Fx5NGVskKrArTKWKigQKFjHSh/aJ?=
 =?us-ascii?Q?U/p2AVWQ+FXdh0mBKr2hF0/qi4IiBLnI7ht/sAiHZwzjFCX7ZleZk72aW9SM?=
 =?us-ascii?Q?pStNGjOOn1gi9UgrfWlwptFBMZxWmR9MStJ+Q5LYnIEz3NDkPfOzcc9qSBnO?=
 =?us-ascii?Q?HuHLN7dCeE0qSywHB4Y95HbHYMmGucOxglCBkCasDgy1GAbHmTmTer10dSln?=
 =?us-ascii?Q?vjxbvB98a7NkmSGXkAdIft7rg1n+fVsLg/bS+0bwX1LzvUfZKWIA1OjRFmsf?=
 =?us-ascii?Q?bram2YXFv3Sd2RYa6Oq+yV9mk02WISkiDBpGP69HxgUTKEviL49tPV6lXlXi?=
 =?us-ascii?Q?qDamxJP69oTLxnGfxuJK5jSPM6YeqBgAqWE/X1Ho?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252f53c1-e875-4e29-9c63-08ddeea2183a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 06:36:51.4465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aHlGBN0H7qBYLXqgm+HTWXQRTv0zvtPEJQPvr/6CeDgTNogwNFvfso3xV13gWjGR23Vk+ydhS+hHmxXJSqdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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
> From: Minggang(Gavin) Li <gavinl@nvidia.com>
> Sent: Friday, August 29, 2025 12:08 PM
> To: Matan Azrad <matan@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Ori Kam <orika@nvidia.com>; NBU-Contact-
> Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH V4 1/2] net/mlx5: update how MAC address bit-fields are
> used
>=20
> Previously, mac_own was a bit-field indicating the MAC addresses owned by
> the PMD, specifically marking those added to VFs by the PMD and allowing
> them to be flushed during exit.
>=20
> With this commit, the bit-field now applies to all MAC addresses added by=
 the
> PMD, including those for PF, VF, and SFs.
>=20
> This patch does not introduce any changes in behavior; it continues to fl=
ush
> only the MAC added for VF, just as before. It serves as preparation for
> addressing the multicast MAC address issue.
>=20
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
