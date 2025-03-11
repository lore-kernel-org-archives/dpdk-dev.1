Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E9C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:35:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82FEF40263;
	Tue, 11 Mar 2025 08:35:51 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by mails.dpdk.org (Postfix) with ESMTP id 07F8340261;
 Tue, 11 Mar 2025 08:35:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWJnld+4RsJikId2K4/OuWDKbxvguZydBdTa3SDVNIiapaPNz6UXNekQlL1duFf6/ffLLTkNtq9BT3SObq+VF7fj+w2/sDQhvcEdsZMcOHuuDryUHw9TOFHC8wH/8h+Diwrd+RmgWxHBja6q+E4Y31QheVH7kWJ8hWS1x+M61iQ7aTghT8NFTnypZVF/73pEHyL6G9QuZ8d3KovgxnnhEdeep5RRrQElSn63YfSrYa2hoIOSyn1+w3N5fArgibIaciaUhth4eA4WvlZpBxb5N645sLWWZ3kzczotGN8BiHYxRW7DA1XylV4bJ4iyknOS34pMD+VgWiUegHon9c8ucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHIx5x0BSLagxsUyqDrqDq2X9B4qixqARGxELLISYbo=;
 b=uSr1WBPSUaxIp5FGnxGH2doXVsNbpC9mZxtmya87wN2A5W1TPwu9ITpnlX3pzaMPqJmjgn/mBfHSK12j4Y0y7zoQVdvU321ommRlyBHjjRMcv/vxI5ZFvmo19ZGocW3poerjEvc3V1sh+l29fZhoD36QlGjadf63Jckte60xzvvqPfPDqYfACg1q7I123G9CyiiWtPbyfCqWJDq4QinLictmcevB96fv/SoN7Q/0cKBSOCsPocJ3+Cd6JQI8FZOP4ljbitdW9RhbJfwoJww2naWQd9gHy/uywROJ3JUxk4idG2qwhjGIufk8VrLJSo67ODssAN56MwXTgezNTBeU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHIx5x0BSLagxsUyqDrqDq2X9B4qixqARGxELLISYbo=;
 b=OHhOnSVCD6Q6RQFR7Z//v341qUClc22fCdhyRLGtZ5xjRgjYDWEyoA+odyQMDAxwESmZN68lnT6gGtj+mXj0ivYdQZW5y/EunxNcWTaXTsZO9U8rm+fN4PPh4jMhh2lYqE0U+uli6JB1RnHgs28iVmbhLvQ90TZc8f25snmDI9qkY9ghm0cS/jgZ5DaF4IxXWnHy1y6Yc+EAag7VAHt0dtCZkyaEB0WuBnw3Pa3fKhTyWL6oKyYJQjN4KB9zVrPYdsc6aKI3S8TuvW0WObhwWhgfE5/XHrrg3w7wDkatXfgjJ2Xn3FF6ZWtaAg36Q0mLZEzgM3IIMoEl4Ofb7V/7Qg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:35:48 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:35:48 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix using wrong group ID for action translation
Thread-Topic: [PATCH] net/mlx5: fix using wrong group ID for action translation
Thread-Index: AQHbjEMfBRwxK9J/Kk+2mOEW+GqF6LNtl8i3
Date: Tue, 11 Mar 2025 07:35:47 +0000
Message-ID: <CH3PR12MB8460D5C87A6C6B5197897B5BCFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250303134920.72182-1-mkashani@nvidia.com>
In-Reply-To: <20250303134920.72182-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7456:EE_
x-ms-office365-filtering-correlation-id: 99d5d1d9-c687-459e-2649-08dd606f5765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TT5+xjMHEhuUZtEYLRSjiKe8YyDSenQcNbVqz96iQupmNUMXUrrj8oiWny?=
 =?iso-8859-1?Q?Y1hLB2n+xQrlzqfzxgVOOHZh7kXpMeIAUk7RJijZQ0y+iFYEcRauxK5kQK?=
 =?iso-8859-1?Q?RAbH6M1LMiZND2IMhG33KiC4twNd3Mev4uyOXfg76nduQXMqMMdIT+Qgxf?=
 =?iso-8859-1?Q?JKz3LshJeBxNBQS1NzwDwY8sCkfYPWTKb/w/v3aMi3b7mtf8fz2AbCjPmS?=
 =?iso-8859-1?Q?95lSLheoS0Xt9MgsyeFuOTdWx55acJBKXtgIFXKljUXfQwxGBcaKqrQinP?=
 =?iso-8859-1?Q?wlT5EwttuzQQx0xdBBGe2/XHSAdPmqXpN5FB/WvhNU+si+RcxotXxEaA8W?=
 =?iso-8859-1?Q?wYRhLH2Zz/riVohmmUGKUWEy1hEyfvbrccgybD/u1wFSt0d2t2/NzhWIxC?=
 =?iso-8859-1?Q?rX1cXSlvz3y1oM0XyNa2YEuZ38ouvjf418aA289isV4lQxqg8FlB/RAHlv?=
 =?iso-8859-1?Q?7/NW53f14TFfvWbnlnsj3cFV+w74a4glUmOwfGQeHhoJExjifetlXsvTCN?=
 =?iso-8859-1?Q?cbaLXAdcuSlqM8jTZaKSjm0DNZKVz2M/H+QmFv6M/9bKPG4BqmdfG9dK3a?=
 =?iso-8859-1?Q?AdYg0aWAzYUfr64XbOnx54oQThpjrJXuq4Iq/I+htJfzLxct62HVCnHGSm?=
 =?iso-8859-1?Q?SGCRhWvGdQPhNl1tDvo2hcuRVxJQvU/saUnQz/i1vST94S1uBkZZEsJoWl?=
 =?iso-8859-1?Q?ECOk4SoSiqC9Lt4fvkgVXehB0T0BvoqHGFbZzKonvcemkPX5DZkDRBuKuu?=
 =?iso-8859-1?Q?G58C2hxgQNi4Bou3BwVRbV3o+BKBqtjHNGgcWct3eNgp8OdGloe/5+2dit?=
 =?iso-8859-1?Q?A3FreVzjgYISSXRjTYO5lsIJZm9V/7UQq/nxA/Z9tjIXieoef4PE0/DqUn?=
 =?iso-8859-1?Q?g+TpmarZVNLquZ/rotEKk1P8se2NalGfkCxuyVKyEipa5qyMLc+nuKcOGB?=
 =?iso-8859-1?Q?Iwszy/XeAaYmVu6Zb/tTKRb7WqYJFNOSXIoTJUhu1jVtqxdR3jtdfeGNZq?=
 =?iso-8859-1?Q?TXyz8lVa5Mp0Eep3T9YTzjE7dXPEp3Prw8KdeNCsMqHrZnKQnLeqmNpGmz?=
 =?iso-8859-1?Q?LnU+8X/LjE22uEDqnwnU1ARL/m98q5JgrPuIk9ZsPL16BWQKA3x7E1mQTm?=
 =?iso-8859-1?Q?UwO2FbAZO1SKlUzw03wjP0QYRyD2IKaFeQ44GYpplhg5d+nIEbzqHmBdql?=
 =?iso-8859-1?Q?Rch4cDRhsuIQiw+Qp9B4t5qKTZWNPQezvQpyuMrXEzztvRIikP3pRt/1i+?=
 =?iso-8859-1?Q?GF3x5BSE/OUgp6FuW7TozHei3S1iU4xSBo4Z58nCZpJT7CCnfge/lJM2aH?=
 =?iso-8859-1?Q?/TtlifL/kCDT6BBxFaqPo8vai73ImmJq32OG15rA9w0+b9ssfyXnapZcTw?=
 =?iso-8859-1?Q?oTnw9sq+jtt/00WYerpLpLNJ2X2aBsQjfQ/UodX50Uo8QjXidEgZTGnAcC?=
 =?iso-8859-1?Q?X7opZLk7J8+YRgscc6DCsXGyXtL5urkUpPLY708yvhcuajR5Y2n7N9vlOK?=
 =?iso-8859-1?Q?fOZJ0E/AjNst6AobbL6Ryu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F4aOutdlN4pMAmPYRrZtphw76UMOiKfe+v+3cdLSu6WkKw3aILR6U7IbrM?=
 =?iso-8859-1?Q?hiU96tG6UG48IKQzHrNWhY2jLI1IBycep72E2/49Mr9xeUNo5KhAnxaQ8v?=
 =?iso-8859-1?Q?Z/bRzl4wKmomSBGhjR8XadwoT0BFs/32NLd5zLE0mbveghKvJeiPFArte3?=
 =?iso-8859-1?Q?BMZUfbm2WpmwuB3FqcGf/gXquzG2FS2C6BMK/3EYnKKu7VdW6jYqcJifFL?=
 =?iso-8859-1?Q?lRA+VM/ws4jycfZcTJLZUaNdblhTHzgPxeVfRrYWeDw9rai0PaqbEQmCsg?=
 =?iso-8859-1?Q?+3qH6P2O/38e8uoGEgBg48bmLXshkHJQIGWC0AUKXMmm3TXRaV4D49lgbg?=
 =?iso-8859-1?Q?DNrOeAyCr4B/Lgs0C2iqoo2p+p8QnOOmOdyGypqRQfC7vY4ISDT2A670eW?=
 =?iso-8859-1?Q?e1z49y7L5XtYkV1wXaTHWDW45SjxaBl+DPVtM/0EknKnCiJrly4uhYjKy8?=
 =?iso-8859-1?Q?dCXVlmhUEnjvyMsCY4dud71WzVe75UGSmZkRrgnQPQnWQkjB7WzHYcVuwU?=
 =?iso-8859-1?Q?jB4CruFb3EHV6WoLFV9zJyw5ILc6s4Sz6A0AOVX24VOnTYyWC3ANSF5e89?=
 =?iso-8859-1?Q?4ZETmELUSM0Xxk4TZKzLlgTMbTFaSjM45yEKoRiWo4woAfHwpjAaucuVca?=
 =?iso-8859-1?Q?39+BGYCLzDdRChhTERsyMWVP38h7AvlUpClEDsBqQRv5PdNzWHYhmreV2J?=
 =?iso-8859-1?Q?moLXURQle2LVm6iOkpsvNzygGmaInuDiaJAzpaMq57/n/+NBR88X70QE3o?=
 =?iso-8859-1?Q?S46KVBV2IV4bCEm5cBTdG4bAkrYPOV9yWbzuKcN0GnJ+Et1YsVUtOGnobM?=
 =?iso-8859-1?Q?XTDe3vNgzMUeqr/s9qAWZ+Mr835pdgdqwZbbSAdZ/TjjkUpV18G3SHn+Yf?=
 =?iso-8859-1?Q?haRIr9sNHnK+6L2WpEjYAJ9qh5brfdqJmkdhxyuiJ8a1zai1JkLqZI5XsW?=
 =?iso-8859-1?Q?ODj6g/tBg+kyFVaktWrl3DbpoAPSkReilTskJW+shYPtqUwWw6lAPi5hgO?=
 =?iso-8859-1?Q?I/ujEPJNs34K3dV6At8zHzp8pexaCoQqQm9RYmD/Qs2X9UR4Qu/s4uw1LX?=
 =?iso-8859-1?Q?eOLyIbFDtv3085k5s8lM11CPyste16DS5rc9kIqWzdFuH3PWTvBpZmH/cQ?=
 =?iso-8859-1?Q?sq8BkmGTGYR56yh4JqvvcY2oTU+AsfD8EJKwq2jpsFTDN9lQklMMILyWCy?=
 =?iso-8859-1?Q?LMCb4thZ8ZuRI7SoE3Vq7cGHpxSOCFB/zdRisKPOGwmqwxCDsYbTOAoioL?=
 =?iso-8859-1?Q?QOqPjz3wu7vfFJBv9ZQX78npYNjVUX2TBsvvzSQ0dX32ajXwge7pR7xnBz?=
 =?iso-8859-1?Q?1AZdJ8/KdtlpyMZG47pde23d4TSrAOEXOLOEOCNtUPLUY3q2CRdkaShrUO?=
 =?iso-8859-1?Q?WdVaDXv4To5chCM44ve4ysVW/lRu3wdb15EYQO2okBQbej8yJ7uc9Jt99V?=
 =?iso-8859-1?Q?IBl6eUSRwHkZzz77gy0iz4e3hTW+x5OgfyIbvF86PjusMWmdJih/W/Kl5q?=
 =?iso-8859-1?Q?hjxEPmVNMdletOU+iTh5UIflmCbY9Au79S5p5VcsmNOZj3UmPw5vuTJjQG?=
 =?iso-8859-1?Q?pFjanaoY8LmHjlzR849waN2Ro/nweu7/Nh9yq4rxgwaIUuIFMubOYcQuVB?=
 =?iso-8859-1?Q?+UKvlcOp5lw2Um/0AXyTDKiYqxE5LN3w7J?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d5d1d9-c687-459e-2649-08dd606f5765
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:35:47.9842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6a6OWEpru0WwYO9JV52vwRCARx8q8v3cr6nF/I0dBQ2YGO3jNnL4To0HEfbO/2oKZUIbNAjTuFTrRRfYUst6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

Hi,=0A=
=0A=
From: Maayan Kashani <mkashani@nvidia.com>=0A=
Sent: Monday, March 3, 2025 3:49 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; Bing Zhao; stable@=
dpdk.org; Slava Ovsiienko; Ori Kam; Suanming Mou; Matan Azrad=0A=
Subject: [PATCH] net/mlx5: fix using wrong group ID for action translation=
=0A=
=0A=
From: Bing Zhao <bingz@nvidia.com>=0A=
=0A=
In HWS non-template API, the actual group ID is calculated in the=0A=
flow_hw_translate_flow_actions(). This would be set into the dummy=0A=
template table for the following usage.=0A=
=0A=
Since __flow_hw_translate_actions_template() is also called for the=0A=
dummy action template and some fixed actions' translation. The actual=0A=
group ID is also needed to avoid the misuse of actions for 'root'=0A=
table. Only the 'group' in the attributes can be used in this=0A=
function. The actual group should be set explicitly before calling=0A=
it in the non-template API.=0A=
=0A=
Fixes: 27d171b88031 ("net/mlx5: abstract flow action and enable reconfigure=
")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Bing Zhao <bingz@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
