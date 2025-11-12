Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE12CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 08:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 113F44026A;
	Wed, 12 Nov 2025 09:38:22 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010056.outbound.protection.outlook.com [52.101.201.56])
 by mails.dpdk.org (Postfix) with ESMTP id 29AB64014F
 for <dev@dpdk.org>; Wed, 12 Nov 2025 09:38:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8KkA/Ippz7XJEpFZiIF5N/H/j6VawmkVeXXDXujjjd1/8RIMmiJ5dntCzV3OgW2n9zYScDsPJkhA8MJHwg4PD/igzLgnsLun6DjZ5UZsCTxJQdlWJXR5L0DMD2Q5M+LRjF7QyyK6KyBEkcibNLde75PIJvTsR+DNjpbW0mI2EZLYq+7sEKiRtY4VvHUnstbWLVNPjl62sJrcM0l99ECPKD4OI2GwFu/57s24FH4Er0nDrzJku0kt2RoHPH1lduzVa0I4n1de8pZG/Gfq64eixq9tl6dmxkPL3FkIJJev+Ls1mn8j3bK3R+1Y8Bd4Ptnc2uFGTgaH0gC8WUjAhjeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmfTxQip7+O9gsr7lYp7OAXhTrK6OwxatNHYbvR8XLQ=;
 b=BYdZfVY9DqWfi/R77dGYbZOaKjBZzAYPf3G2ZaCbstv/il9bl0zVlJxEru7RD0qguAcMV/6TerZTp5F97rXyZKm4kpwv/nc+JJLwqAfTntaq4ZRtE8exDuoZth1G17rWtocyl07/CgYeDeTzBwJPHxaYtADmpKMPFvpdRNYyrCPw9cViIJoWdBUQw53tsu+aSGWbsRZmy20mLj62wgFCYIm86yGUW00X+IdEYtIBDAm3LXMMvbX4ENxKFoKGTms4jywGommroCLJXEd8M5bCIJIXum0lc1hplByePR4j01sXvJHnmPWDi5oRIynEKa5GjyXOUSAYZ5a9dLPyR934vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmfTxQip7+O9gsr7lYp7OAXhTrK6OwxatNHYbvR8XLQ=;
 b=rccqb0J0T8LDM7l6g3l1jAJz/dk8vDvSosEe7K45AJAfQpTzsQsfpt7FqLJoSHdFhm4tnVsz3yzlrRkinqtIw81T+pt3KBSBOvApKoQ0B83l4j/7hNGxbTjjYvE6RlrSR3/+pLE7hyDQ8520zJDiEnmgVQ5g8Hdwl8P9TLeu+OnoiXuAjceRd0x6yXq4/Hk1sWv6FGH0Ch3zmL3Ch8xoN+dNGurGLcKDbBVYjwEAIeov4VQPvjR/YKNPKmU98KD5G+5Hznz3z6+rRo1QWbgugUmWVPh4lN4yvIVUC77GgGBElANN5bku4cbZEDXGR0BadSb5ikjZ2M5oOU/oVVkU6Q==
Received: from CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 08:38:18 +0000
Received: from CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::e839:c726:ff9f:706c]) by CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::e839:c726:ff9f:706c%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:38:12 +0000
From: Suanming Mou <suanmingm@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Roi Dayan <roid@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: RE: [PATCH 2/4] common/mlx5: release unused mempool entries
Thread-Topic: [PATCH 2/4] common/mlx5: release unused mempool entries
Thread-Index: AQHcU6fZ1TDWERf7Kkmb9JCz2PPEBLTut/og
Date: Wed, 12 Nov 2025 08:38:12 +0000
Message-ID: <CH2PR12MB954482294BCAD23174A31A56C1CCA@CH2PR12MB9544.namprd12.prod.outlook.com>
References: <20251112074131.8929-1-bingz@nvidia.com>
In-Reply-To: <20251112074131.8929-1-bingz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9544:EE_|DS2PR12MB9687:EE_
x-ms-office365-filtering-correlation-id: 5cbd580c-fd0d-4272-7c71-08de21c6d0f8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AgBVb3QaFWXZRE99XSY6QM8FVBDyAz14tJPqRHldpKmHxKakRl/0WX0yi778?=
 =?us-ascii?Q?4xEgMoHbQANNftKcxlVTuCilN8KS4nw2B9dEeA0NT6IrOZc1iroJfyCdsZo7?=
 =?us-ascii?Q?vvegzewgMsdki2lJU6BU7yGixPFtapMI5zkG/TK3GxjBAsrSYcRAMq9RPMZh?=
 =?us-ascii?Q?hQ3EduonGFO8mPG6c1CyxTySzRl6ApZIVyHJkmW3eimycONXdOmPKQBVQoMj?=
 =?us-ascii?Q?6FOfrbD/j2gwAHUJtk9uXA3Ucer2xZBXazl9LVjjgt8MUwwjhPTe6LL5cFjg?=
 =?us-ascii?Q?24SS9QLzKRCIv3he0EzuHjjWbim5TJBsz7v5KMflFkVOfsBnQaLKVATL6h7U?=
 =?us-ascii?Q?B+rldhyu0cf6G2MqhRjKfn4+0mwq32HIv38YAONzFRjhK9YE7zKKl96xMzXE?=
 =?us-ascii?Q?k5ozWqK7L+TCE1mJYfMrJE8zoivCsKO4XVUBt95DOxbQjImVUqG+G7sRbXYF?=
 =?us-ascii?Q?YPxiFuIIqRo5wDrK0GeqTD1ex77Cb7ZogCnZmNK9nyA73cNNkuVGVvJK+lJv?=
 =?us-ascii?Q?/C8wzTZhu0h+uLUiUcOUfMURuLmCLrfnZFZBzKkfl3c2GfVF/3P3Ce7G8Lge?=
 =?us-ascii?Q?78DxygfK22JwpGz7Na1SaSJrYM2BSlFQF7M/d7aLc+Rx/cHYJ7H4xRO4ZGBI?=
 =?us-ascii?Q?D9dgq6Qk4/c8FIkVT6VIe2I0zrm+51LeycWgi4CmlM/Mfg0kjWE/6dJKW0Qa?=
 =?us-ascii?Q?E4BUkngFg+46HNhRyKidnK5DtANXh3C2y1EqR5KuaxYVZVzmuyydMpxBW1TY?=
 =?us-ascii?Q?ABnaPUPS5T0wkH9ff3FqdwcjRMH/qQLsajxS5HhKk6NE2A6i3D3+nV9toAJ4?=
 =?us-ascii?Q?yXoM0XeuqK/CBeQvIYsB93h2DhwhiP2txZ/ilMVPDbOomNuhbW0/jCDpwi2/?=
 =?us-ascii?Q?V8dOSLFVmMooWxYrGilGzzaGUQN/AC/RiGPTbnFXZ+mHMetHpVz0c68oOcbq?=
 =?us-ascii?Q?PITpd9PM2FPbk2gh9YUwUO3pQfmrTOqw4TXoiQBCArtpvxZdPM7H8B5MH42k?=
 =?us-ascii?Q?dFnJ0Hbp9LYhEUC7Cbhy6xO34m6i5tSScF0Vsgcc3Gf3kPFeidClkgDCtxhc?=
 =?us-ascii?Q?wEIl5Als5O9y7YtFpkhwZ3ToxiY6nKeEefJZ4DF606tWH7zH/L4bxAg1mnx2?=
 =?us-ascii?Q?l0/R5p6uESolZ0ghv86RA0+WokPpHMPTgIMKQAdsvSQQ1eNFg48DdW7vLpEr?=
 =?us-ascii?Q?q4SbhlnawdoQol3rL3FAUJAuN9UEPKnlwpjClyDkTYUxHBhtdcT/wi0Kh1gL?=
 =?us-ascii?Q?fedw4YzZ3Pr4AcksJb7P+RTKuCZ/MvJjt0DnKRyXA79OmCHrY2G82E92qIpx?=
 =?us-ascii?Q?RyCgR4A6+e+kbhPn5ZEqr51IVBpMtcqW4p6jIsVf/hZbd2bL0z0fPlUa4Zus?=
 =?us-ascii?Q?5+BeE5vXRFbTLknWLKL0h8Fvh8PC42Zcm66XQrU7cqJjsQccte1HCiWyZYu/?=
 =?us-ascii?Q?19NpVkStbb6hSD91tdgHG9fQXNnYJNBN0Ll0m7OtNcHYUVcI2zS81KlP1LOV?=
 =?us-ascii?Q?EYqIR39bCsaXmcz7vh9A+ukunOSCnKSU+TUT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S0oDRIqCl7vIk4oEQmCEC226pDILyBkOStpkAYEd+fc0HgUT5fg1YYknkTsX?=
 =?us-ascii?Q?0MES5tj0kiTsh/zvATpJrsdKRt++hTiD34mEgLkDo4XSWMh6hXkREATbFxr8?=
 =?us-ascii?Q?6VqZVVM/YXawSin28bdnMGWWZ8MXKawTH/fB3eFEk9Bj2nFiYwYsjbfaeCr8?=
 =?us-ascii?Q?QTmUgJydhNYG6NE62O9fTWqoRHE/0R56rUTTuXR98rPkE6btSUlFcMbFSSPh?=
 =?us-ascii?Q?50wPDz28GSz6uOR7o5FZkOuolAfW7xsUhIeI2ahQ9vjUTML4pzTO3Hlin3ye?=
 =?us-ascii?Q?C8MG3jX+izakDyD+tClt4pTLxbYxdZWwFAk1s2+DbOAbrjSGu7N2voXrnKJp?=
 =?us-ascii?Q?YhWGl1ytYPKIy8kxt6kNyd8La095gdvfo0/T9WUYCyTZpquPbH9gbCZmXhu2?=
 =?us-ascii?Q?HxTXsWVdIbHCkHF+Ml01WiPTDfjS/sO0kDMrFYl5QKQsWttYFhAEDrdc7I7R?=
 =?us-ascii?Q?W+li2REJhT0ub5iFu5rS/2WqvDpQ8TJxEU7i2mkrHFifEV5K9cy4BWf+XuMU?=
 =?us-ascii?Q?cqBj2NSorQCxUYoUfYh66oNsdTW0R6KBtJ3djxAR4byNUqMdBXLDOsaChAe/?=
 =?us-ascii?Q?z6tXZ865ah3a5Hx4NhqlqfHjmo2/WXMwqavhW4UnrPv9e4bctMGIdkQ2jsVw?=
 =?us-ascii?Q?vBRFqLR1ZL47rvnwg0fMGajTFLJey+N64s5n+lw2V0j2nZSG/K3LcfEQSMDx?=
 =?us-ascii?Q?FrJxIDtMGAyegx9AmZimnp2BTSTm5drX2Lj8xWORtTGWtP5chRFcDMeojNPW?=
 =?us-ascii?Q?KrQAj3Z7U2qY/WgjdGjJpKwXEDPJsGX5QgPbUY3VnlPkTivMtLfC5cltfSsE?=
 =?us-ascii?Q?otaBthZ12JFtiotbOTlPiJYF1YuR6o3MDdzcPdIUiNJaDzrxn1MrE8eL09xM?=
 =?us-ascii?Q?djBbTeWT0CY1jh+wNdFDkkfO/dlEE7gXffzMCqQ/TwMbZr/C9llYlFXQ71ty?=
 =?us-ascii?Q?4ImcMIDGOx2VrXl5IOwakhsT2ApNcOP7UuL8Bgeiz2vkAD2K60sCvY+SszAz?=
 =?us-ascii?Q?Gh/NmUirP7i7V+soZrLG1zvpjH0ejdmkuw1/8C1MQ0dbgjt0ad+CjeVifuc3?=
 =?us-ascii?Q?nTRdJ8jXbsVMVuVGzS/ObKzY/Zff/Ty2LuU0gS7k3ow9SX9oGbmzMhT33dfB?=
 =?us-ascii?Q?xbCMts05/X5pLq5PN7mLey+pm7gDL/eKC7ztQjQQ92dRoaz2sU+sG6/SNKMX?=
 =?us-ascii?Q?tG9tMRSlZyuCsoGszR2nngHqX2WC6rjsRk3bF+qB0mH0s5yyq0WLcndT7NBz?=
 =?us-ascii?Q?PtKfDurXsFAuhF+hCUpcLovTXCA6oDaTWQ8Q6Iyy3oRq6YOYxQtv49Mt7egb?=
 =?us-ascii?Q?raJvh/9a8hOU9ly67+fUf9A6fRk5z839txxUxlkPPyBm0BsnSUW7m/7QlKeO?=
 =?us-ascii?Q?Rf765IefQyTQzoxVhJxxuli2nwYYkBvgaO5bxxYmKZNYySk22pLA/dUAqMWr?=
 =?us-ascii?Q?1a1QresopWJiDKj6B4V3EncZOA2/Q3yT3FwjvLt5e2MGHxaHT0WOG6suEA2o?=
 =?us-ascii?Q?n12zmMAcDE4MzCe8Ho/3g+3vTueg3TAD5m99rZrNlQB9sNYv07Cf3PF+FEt9?=
 =?us-ascii?Q?x1v/vEzLZbbTTbazTnO1xz6wOAC4ao+G0IdkP2mS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbd580c-fd0d-4272-7c71-08de21c6d0f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 08:38:12.6144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbVWNcxhJhcvEsxxnYPbW2r7lWmlONxi9krNuPzQVHL1OoX4/9KQhAs2qdFcztPDbn+2uGSpECsQ9Td2AuGJHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Wednesday, November 12, 2025 3:42 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>
> Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>;
> Matan Azrad <matan@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; Bing Zhao <bingz@nvidia.com>; Roi
> Dayan <roid@nvidia.com>; Gregory Etelson <getelson@nvidia.com>
> Subject: [PATCH 2/4] common/mlx5: release unused mempool entries
>=20
> From: Roi Dayan <roid@nvidia.com>
>=20
> When creating a new mempool but assigning a shared entries from a differe=
nt
> mempool need to release the newly unused allocated entries. Fix it.
>=20
> Fixes: 8947eebc999e ("common/mlx5: fix shared memory region ranges
> allocation")
> Cc: bingz@nvidia.com
>=20
> Signed-off-by: Roi Dayan <roid@nvidia.com>
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Suanming Mou <suanmingm@nvidia.com>
