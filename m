Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6876C021AA
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 12:07:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18E8340DDC;
	Fri, 21 Feb 2025 13:07:02 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by mails.dpdk.org (Postfix) with ESMTP id E899C402CC;
 Fri, 21 Feb 2025 13:06:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlyvAsUh4zCLZVqCMRt63jW0TfWWW2rupY+UiKD9cg3S1VTt5260hFATYQmCHrzpAdVqQu1DDht7PygV+sH121/dSa7PjQPDZOdUtCcwCqcXOIb7EqtavxSAGfBAPOGMXQjX+o2CXI1zTLsdeN0x65x8a52I7ne5iAsiVkW9dClB4+i/b2W4TmG9seJ54leQc9WH0UKUBNjsESkb9vezNpI2SfugzJ5cwBPZg+S/Qc+pI+jlCfglb9rq3M1xSlitgp6emwDdMUy+m8j6zuiwTyYlJz6umM+T1cZPnfJU16zgfJKCnZsGACf5aNBQDI+aSpQUGuoDg0zta4w8mYmr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvESj/3sCBCVcXN+Wk59EmlheiRzJR/xY4Bq45M6UrM=;
 b=SXz33UEhFh0rsf0on/MHuEi3WTDQkSaepkSiAaqC9BXCARr22JV8rUEm7qGouoG5oAKY+pbYblEXVCSXOda+rv7JcfhXVI7TJ1wslSa4tbIBOpvHoumXGALyyXksoDj2OJids4usS1B+/H1HaqAlZaJKT+BU69fZGi1KC/r7rJfM1FDzQzMPlYa/Ne8MhuvjFM5dBHLNNv2T0Sw/8h5m10rNO32Ev02s5wRWICC/u4l1C6RZFJIFqmV5oprtDl27GkAb6k6oTNVJKu7n1eirduBUo8ZpFJMMKvxi1GzXkG86KQFzPEyJxKxZbVuyx116Tp8pMz+ZrYpVgWHuGGDypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvESj/3sCBCVcXN+Wk59EmlheiRzJR/xY4Bq45M6UrM=;
 b=YPYQub2Zth3En1ScLLd1GWsd+MmmwNWZHwbcM5W/1DGkPccOp3cL3oYOIDEROODePjifSTgYeP9gMmyed4WssFFWYZiBjdKzaiFI9Of2NvymbZ5SMvEqM+uugDYCX+CjBn101Irm/8V2jTj2cDiTDzY0Nw7Mpr8BzfB2LZIDjcmz9ucYCY/qj5mtg4Avtbjk1IaPw7NESzJ5R1MThhrAGpvC2CN+lJ3zlX+MK5CRYl2O7/1UT2eYBc7HTPc8jmOsbRuYX19ABTo/dnX3sR3WXvta0ebN1L3BP+5l6FJwTzWg08IRy7yDqB4RH2lLM3a2E5xkhBmOhyBONeD5syNQxA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 12:06:57 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 12:06:56 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Alexander Kozyrev <akozyrev@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Raslan Darawsheh
 <rasland@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>
Subject: RE: [PATCH v2] net/mlx5/hws: fix fragmented ptype match
Thread-Topic: [PATCH v2] net/mlx5/hws: fix fragmented ptype match
Thread-Index: AQHbUi/780GFpjXQy0KBqb3PjzsqJLNSDbXA
Date: Fri, 21 Feb 2025 12:06:56 +0000
Message-ID: <CH3PR12MB84606AD42BE5AD8A924CCA36A4C72@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20241219160158.897255-1-akozyrev@nvidia.com>
 <20241219160553.897489-1-akozyrev@nvidia.com>
In-Reply-To: <20241219160553.897489-1-akozyrev@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|MN0PR12MB5715:EE_
x-ms-office365-filtering-correlation-id: 9dd1e596-7c21-45e1-c172-08dd52703ce6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lNx++wXfx+gdnpi3hnPHVVBosDT2J+NFL+xUre39ztcQ3Ki5sJRIsoPRAt1h?=
 =?us-ascii?Q?obcuzWrRCQDQgy8iUbYMd2/kTh8lQeNcBmADxs7+d5bE/X/gWsq8XGS05zQV?=
 =?us-ascii?Q?6lpiszQqrMe8e5SRcmNdHaxJni55Ik9mLGJQvsLP1nWZITgrIqe1yNXAYd6Y?=
 =?us-ascii?Q?RMuPlpZjqcNssKjF47yBM8J7kmh96bik5TY+d+kJcRpBSBR7/nUaTdS/XUME?=
 =?us-ascii?Q?Tsl8M0vhaQm4XVbLFPKgJqWuPjcseEwt5VXIKjcflVXmRAjfJeoe6dX7ksIn?=
 =?us-ascii?Q?ueGlTBkP+J2fv0sNIIBGxZFPvFiKrfk4EtJYwv1RjCkvggSfQ2+KPe/3o17Y?=
 =?us-ascii?Q?sWovMnrWErQwZaY1FsnKRn31680Cz2Rj5q8il3RSpUojiF+2gJE3fG+kl/Dm?=
 =?us-ascii?Q?orRy0gRGq2eEKRRUaLWW3uRFAGKR+jhae/tVnKIM6MfIoIkwvPcvSzNyZ3Fj?=
 =?us-ascii?Q?z1kupGytb84TWVF1bhoZlif5BB/9/KCKY0hU+pABBnOl7nDlSHY1R9/85Gi9?=
 =?us-ascii?Q?M+kPlGU2Y5fYHqVHtsSar8a0//cOdKy0aTyF0sQrGuJjoUURKdChG+zTdGnp?=
 =?us-ascii?Q?6+J+bhgOB9N9FqAe9Ryc4S0SpcP3z4ibhCwpIUwgGKdnCbyU51MwNdBJjNTz?=
 =?us-ascii?Q?ArL/yEf0C0rwgg7AZ+AndjE6sZo2onvXOTbZx1PAGUm5is7mQnIy6j3IRuhk?=
 =?us-ascii?Q?fdWifc+Y/2fxcAeVDFm7po00ZEiK7CgyM2uwkIl1zmTvCZTcAbWM+PtekDeN?=
 =?us-ascii?Q?9tDZVIcwAbO9ObBixJQZtpYYFPjkWH4ZcZAKu+Lq+i7Q9HxzBhDUsYZz7xdw?=
 =?us-ascii?Q?4PJPVGW7xNoa6pWe11MSdXp0Y46OhXNAGgr1UFel1bFyz8QoKhDEkmQrO0u8?=
 =?us-ascii?Q?ru4wiB7LcCvnvGBaFKiqSuDET8lQSRsPuiO6+qq33Y0eBebpGFFlfhc7FjxZ?=
 =?us-ascii?Q?0k82jP9vcZsP4wQY7KWyGvsZST0uxFMadZcf91vcaq4Wy0jYQN5Vgr7mesDM?=
 =?us-ascii?Q?4kuNJh8OpqdsukttDsjEux/18R6rQlbhc50wE+OZcCPP6kFC04TvXfQNftmb?=
 =?us-ascii?Q?co9+OW5qFS/ms1nwZ+QT8ZIZSnE6HLNJqL5HvivTz0+DT1Tt6R3edeNNy0Pq?=
 =?us-ascii?Q?FWlawyKpmUkKQsi9H5eRIaFkOWvGbtV5xPypLnQtopUH3qzflcTvpy5IP6Cj?=
 =?us-ascii?Q?Xv3tVmhxpqztRPxm2Dj7jmnkFWbT0MeuEaCNbIFoP3ZuNlS+BVlCAmQmvwTD?=
 =?us-ascii?Q?WQR0kwUJk7xAX+Bmkad4CknnK08Eltj467esqbp994isA28gCupqSMKq8vlX?=
 =?us-ascii?Q?ImvIND2ENlviTmwHI5ZAx9ugdiHRnfWPbEKjpGQ5XuR9I/9UmLmcHZJF3rC2?=
 =?us-ascii?Q?SqXBc8p1y7c+ntbgZzsowpo7ap6ozDvi1wv1MaYKaKIF+OVM49uVMpTr1YYP?=
 =?us-ascii?Q?zMxzh2mgBxXRAvSoaX2rgpcjHXmVeILr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wZb1vIkjCWUofWbpUvE8nEJwo4XxeoLiLAKRueMcaEz9GvmHjFsBxza5k0AZ?=
 =?us-ascii?Q?y9QQEAHtty4ZnkV6cM+hP6ihb6+cJThi+eP7FfW/zZ1TmsjCSHhfLgATMPH4?=
 =?us-ascii?Q?jhJ5WtVlA7gK2gAJriWuINMqUgiYkgdW6sytuT8nve7NGAKg4FuSdEcNS+lW?=
 =?us-ascii?Q?hErG6KFbz7BV/HW3Skuo3dkdVmHZhj7vTlD3pSqoE9x7HK2AnFB7JIqOS66O?=
 =?us-ascii?Q?65Vz3crbF57llgOPJKd6SAmFKKGrYXG9wMEpXw6UPyfsTeF7ENOojB15aHoW?=
 =?us-ascii?Q?HuyP9u8Qryfehf0B2ht1wR50VDI/ho17v19Nat03vF/lLJxJVik5cEe879pl?=
 =?us-ascii?Q?lxjHbnbYqllKzBVp90Bhsl7NSyXN+kCxe87uUfN600XZ6aXmPxTpTuvG9/VH?=
 =?us-ascii?Q?ULM2Oh92haYX+AHv/gtxz7Yeavv6e4Xzcy/zV2xMFDQ5lhVfIMnRqtqkKild?=
 =?us-ascii?Q?s+r49Hvz8D9e/E1n4tTcxVVK+sh/740ctDc3SoJGjvcGOJix32CEU5Vmx2mZ?=
 =?us-ascii?Q?HvQZ41vNfUPk8wQtZPA7D4ncijBhlr7qbDuDad6utwedRsO0ANqK/WfHXmz2?=
 =?us-ascii?Q?k36OXIrZOGWn8digWyB2RxhJHSrlyb4HwzvY2i3nMrq2A4I+17OFpgc32FRn?=
 =?us-ascii?Q?JnBCFheOHW8LeusRxsbRj4HOclRPjD+IKxwDjbRS/pwFkNYvjPoHoZCBpkaw?=
 =?us-ascii?Q?0II1EOi5bMtq6bBwBwjlsRqYtPClAIi9/3iKnzaZI0Z4iB0O6jsKiZeqGtjj?=
 =?us-ascii?Q?U3tVgzGpdsNlXvCZxSpQQNoO18OHEDmqTC2ldilNuNUlNT7oF2pyo2R90ZR/?=
 =?us-ascii?Q?WWCVv1Ituoi92F1bxuCklaxQgcpPTKMI8TNqtvIN4mpAUqhfd5o4QG7EAq09?=
 =?us-ascii?Q?avUlO86ri6DUlCcobn7Nyl0YLZICgj4C1VN9w62RFMl0hndmS/lDWUAbwwi5?=
 =?us-ascii?Q?3TeW3CEaqn/+njwJw1UndVdTpmOWysYXP/w0R1cYSpfM/+8j5+sa70z/2ezd?=
 =?us-ascii?Q?b68973sqo2ajFk43NWiMsj10d5CbdLYVcvMQasU5g3zE3s6+LWZxsniYNKIB?=
 =?us-ascii?Q?rciIeK/5pwgF5fna/dDj0qF9UumGSuM5ag+f+COd1HVD/F+cSBQ97hjZUCZo?=
 =?us-ascii?Q?OtwJ2tT+p5CE1JQgBtCAAwtBxvzjMhucG4UyO7ISQblnWGehOmga1nM328S7?=
 =?us-ascii?Q?rpCm3JfniKPuGKHB9Gg2eesSeZ51iL2/EP0wU/P0zmnqzzpDlUu0ZS7f5Nlk?=
 =?us-ascii?Q?+UhfKmkFlKnLYtdvx/wd/d9wx/JiGpPY7OKzQL8tER3vW/XC6SAm2q5zLEqc?=
 =?us-ascii?Q?fM4uvkOc4KtdGMAAY5hJHpCZ6FjUxhFgYoq4IIahICF2VZ6AiGaM/y/zp6vv?=
 =?us-ascii?Q?oGQrXKMsncAW0RXTQN0cDM0nnDeI+/ZLABsHNZta2XJnynu5ltaGIz1rKOCJ?=
 =?us-ascii?Q?h9f3Yc3hKTlDbwGQWFSxAHqR4i/vwYx+mxA9F+PNqC/GG0NMVMa2TsoEeV2p?=
 =?us-ascii?Q?Ym2O8J073bRweCOkBzSFMwMwoTmoA0NBk4hOK37XkPP29VPn3/TxVSlPvQPC?=
 =?us-ascii?Q?pqkDwsBeNVNAmHTV/WjhGBy9ajDtlZzRXgdpRpSD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd1e596-7c21-45e1-c172-08dd52703ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 12:06:56.7452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqlAKYSQfSaLIDPW3IyT6Ifd0IYcq3dnfq5CFjqtAOLvsLjX0aXEyqR1wHHXYpzdc42wl9PzvPMpW+iG6jdtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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
> From: Alexander Kozyrev <akozyrev@nvidia.com>
> Sent: Thursday, December 19, 2024 17:06
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Slava Ovsiien=
ko
> <viacheslavo@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>; Bing
> Zhao <bingz@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Michael
> Baum <michaelba@nvidia.com>
> Subject: [PATCH v2] net/mlx5/hws: fix fragmented ptype match
>=20
> Fragmented PTYPE matching requires setting the mask to the exact
> RTE_PTYPE_L4_FRAG value to avoid conflicts with other L4 types.
> Adding L2 or L3 types to the same mask should be allowed, but there is a =
check
> for the exact value for setting the definer.
> This prevents the fragmented packets from matching in case of L2/L3 mask =
is
> provided as well. Mask out L2/L3 types when setting L4_FRAG.
>=20
> Fixes: 761439a20f net/mlx5/hws: support fragmented packet type matching
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Alexander Kozyrev <akozyrev@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
