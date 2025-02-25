Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050BC021B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 16:31:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3592E40299;
	Tue, 25 Feb 2025 17:31:34 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by mails.dpdk.org (Postfix) with ESMTP id 2A3254025E
 for <dev@dpdk.org>; Tue, 25 Feb 2025 17:31:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxkUTMSKiQdkmudqwN2f/ptMGF23BmAL73+ifraw9asWAxLw9RNmD7NbK+S1A7WbUMypIAdy1WOKaPug1MCHnVdC7U+sbxDlmPvBrX1z8sAyG82iRQliiUifHpXKBe7jjJoXXr8r415Eya/97E39Y3/o0neq4L2H1ORzs5+K1TzAWiUDHZFkcjz9P/iNAIDOduPIOsAgsdd+uTq1qQcLEmTF0cSYsnbv+OwnWt11/wzmO5UvLflQQzqbOaMqE277cPWpphFY4g0v9jtXFK3GxDs5KMI59YLN5b7cxagvWL3LEqGeBo5wXqSzsFX538o5hMjgBdumDh+v21fxtzJ3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1UETveUZpvPaw/SjqS9hwOlQOZ6EfvF8AJ4WClIB8U=;
 b=PzZwP1mWeaGH0K938LtAhdHizZKJKje7bDc6mE7Enqwpi/mfU/TqE1zRdEeievVoa6FwmuIbE2RTJJDUNWS9mD0796pYXcvR+UHA3aZs/wdCpdnyYI+mTpkHlVAmMarvWiJh2p9M9wIkaKEO+T/+3AbphRxbXsyeO3B5Yj/UP/NhqXWmN+7GwfOJ0/pEQOWbviHtMPSU6aiF5/KFELPDuQfXBXiSRjvEacZ2gyTitixpHVfih4NzMm8NQFl2t7QbpE5/NvWA55D+U+sbFdRJl9a4j+YOKZB2vKMoZQdtiXzFICfMB5zTBc8n/A3SJ+XTJmDl/mkPj1Rg936sLz1rPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1UETveUZpvPaw/SjqS9hwOlQOZ6EfvF8AJ4WClIB8U=;
 b=OtIUpbFrgfJWWW4nrHS91x+ccJupTraPrCouHER2bLwdlo+nK1HzE7lxyYmoFFskt9BQbP9eC4qCP0JhUrfJNgqRnUH9kPsG02h2/Glxg7FqHveNgFdEYUO+7wNYLO1MttSslwp9jJtGHXw2OeAQ4qDCG3cEu+/QxSn+adWQXYvF/au5mMkSRFkU3Wilduc7O8tTq1Taqt2S+EFOYdVgWVjZmaiP318kcsarq7SpxH4pnOfUMz7kJvZO/ipyxaEcVTB2FF0yRoKsfxlUunCu3lXdtka/MnLWhwR0CYnyJ2E3dLAcFDlfh00+tdqHdnjWIJWwV1Tjn1PBIFEsXSv4Gw==
Received: from DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 16:31:31 +0000
Received: from DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a]) by DM4PR12MB8452.namprd12.prod.outlook.com
 ([fe80::b341:6309:cb1f:5b6a%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 16:31:31 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
CC: Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>, Hamdan Agbariya <hamdani@nvidia.com>
Subject: RE: [PATCH] net/mlx5: add eCPRI support
Thread-Topic: [PATCH] net/mlx5: add eCPRI support
Thread-Index: AQHbh57cnAkX/RuMrUaIBQqp6dIX2LNYNhtg
Date: Tue, 25 Feb 2025 16:31:30 +0000
Message-ID: <DM4PR12MB8452885ADFCF0B611782CD7EA4C32@DM4PR12MB8452.namprd12.prod.outlook.com>
References: <20250225160304.9865-1-bingz@nvidia.com>
In-Reply-To: <20250225160304.9865-1-bingz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8452:EE_|DM6PR12MB4058:EE_
x-ms-office365-filtering-correlation-id: aaafc679-6b4c-4262-f08c-08dd55b9dc4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Cb8ULa05Jq+fieHaD3vvCKnuLA9Y9Q4vp3Jv8wgyyrK4Ddm6d1UtXzpvitMm?=
 =?us-ascii?Q?tsgifXabe9Skdr7OBi3Rk8Lv4eNda2T7ZMXZ40psE3Ikpz/FZJEuoGDbaag5?=
 =?us-ascii?Q?lnOv71o+MbdBNOvaJFO3xwS5miVBpf3wKb5BNTznY9Shqa5oyhml6foea1ue?=
 =?us-ascii?Q?Q5Wp5esg6xDt3FiLzT3PDPwp7kTNMb9De8b9swTcFuCgsQpOKrJMn5B/p8VK?=
 =?us-ascii?Q?b24x/bWnCE+fBjhD63OHu0y8jz2KqQT0q5qSSHU80wBMDjDG57qIM0Kf8Cr3?=
 =?us-ascii?Q?vfTFgW7r1goz5hfdtqcg0mVe1ePjTs042Xrstm8tO7A/FSLgRGyAkBg1AavA?=
 =?us-ascii?Q?dihPYtvfswF1th0TfCO15DhIZX4Dpy6nV3z0/LEzF6jvKHNgfIf32CJ4vRHm?=
 =?us-ascii?Q?5VHSpG3G+GXWlpDKUa6g38E99ll7IZBcfZpzUXVtI/iFvgtMkovT3BVroBDx?=
 =?us-ascii?Q?YnKe4jCDLYZyo+0iucd77NggTMKvmgcZxc+VS+67zYXC1gHD3LNfC3wDqjB6?=
 =?us-ascii?Q?OR0y5Fo8He1NnM/dOj0a2Lmk4LfZxMmSeBVTns3hgfYSVsbDkmiUyOOm9ZYX?=
 =?us-ascii?Q?UtuFxO7ghZQSBs5n+7oFSWoKeSrEUbVG8O6ZwdfLGGPqiXuCVgC0SNdMlICE?=
 =?us-ascii?Q?u616QENzamJAM464ABJgGi8/saMx2uatGq0gNiGTCqCbwXlcNaKZ9Xz6hW58?=
 =?us-ascii?Q?bGuZH1RCJuPOmpZeG++Pv6HFYFmsRj7EuVZkM1H3UPa2FBWmS6m94+CWILul?=
 =?us-ascii?Q?MK3e5NXBBJbBXHWFGbKiKSlpgjM1bdBU6TNo0gAQ3QJbyfw58uWfCLonzAdj?=
 =?us-ascii?Q?YFz6Ug6fFM48wI0BnwwPmzdoTBlPD4dKkHZ/il85KA6UJ0NRlao58yTlMOyR?=
 =?us-ascii?Q?Ok+WJRmMHwv4gn6gJ3XinQRRQNvgw6nCARvfIaOCcwm8PQSGDtc3645oeldB?=
 =?us-ascii?Q?IJPQomotzHWrP0w/t1stQtxr2OlZCv+bj6F0b+kgJdeismxUhU4NFOXXk5j4?=
 =?us-ascii?Q?uem0AGZSfkA2nQMwZYJ3nRxL7ubf5fVruGgQqCIxeFbFmDhLgolUTR8Y4GzW?=
 =?us-ascii?Q?wU8vohcuo71reonxGu3Hjk77Fo86nG3CRpJAxX3ZH0Hhv4elLNrb7O1T1+fG?=
 =?us-ascii?Q?i164CTPqdrw49/x/1fBD/5Fd9ZeCfjCOyyhu4Jz5+7op7TvHCqXSd9phcdeh?=
 =?us-ascii?Q?5+xhWjGbKVoeLLv8fFeaPMU41gzQrzF059a9hYb9+U+fLgrdsi21NVEbzGai?=
 =?us-ascii?Q?JFhj+b3JHTRUhIbJ2j1rSvXNhn855jU5za/LHW8r1OP8j0A2tXQbCXV8rgUU?=
 =?us-ascii?Q?F8zawswE85skEFdpTYYJBUryvnNjpL5sZu9QMmFI1wNGAKUsPngeN5gijQpk?=
 =?us-ascii?Q?pHYs3VFxDSeU5Ee05jfNADcsyjTcWcLaA1j4IRtrmrszx/QCmwBAw1TJRJDB?=
 =?us-ascii?Q?hluOde9QsLIVWzlA62vXwc4a7BHR0Uq6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BmwbvuuBMeoZq29gv6j1I3qPN2AsJWy9T0X98JXgiyK6q3+Yq9onY3VGFBbD?=
 =?us-ascii?Q?eru5qsx1mhPNPbb02a9dbc60iONrgByH6yhG98oXy8xRAoUwOxy/WQusw5Je?=
 =?us-ascii?Q?Ac3FL8LfEMaJr5EGhJXYNjhFoiwh0Anf6AxVgPf/VlmwkhwGj55X556Gzmfb?=
 =?us-ascii?Q?jhILIzuq+onm+Fvr7GZBMgn45RNEWdZkwtYsNpf5x0q6UqVi2qk6qc0C/Yn9?=
 =?us-ascii?Q?M6UDpZ+g5V4v/uORh3tzw7DgBXq/Z9Ebi65ofbBSB1b8vhDxG3UI1tMZwr5K?=
 =?us-ascii?Q?iOe1wg9eUs9sqys/TVHNeMjqvUq0O3b76uBOr1OYfF656kpgJu6qqsS5k5B0?=
 =?us-ascii?Q?bh465nTd0PE7tYdcGCp5ZpKc9Pb0128MarITOiuMj1YbGYUsCfQHCpq00Sp7?=
 =?us-ascii?Q?4NgTasRhDpE+HTrM5m2ElkO8lSmOfs0r2dxM7v2NAFEhhB7XJcnXws0+vciu?=
 =?us-ascii?Q?05BonK3HNIHVpxt17WfWQCdfwLG1CfYE3TIcf7eMi+mwnDoZnhqRVRUna+li?=
 =?us-ascii?Q?ovjzJ694wsWaI/VFEI+i0Kj2J/e4OPsQfhdHnY+dgtKd0yMxeN+LJSrzrYw5?=
 =?us-ascii?Q?VYQAlBiUBAQEU02xx6LUAvPr1sVNHXvPpvM1RA+nCc1nX/Lly6FYzdM8jx6T?=
 =?us-ascii?Q?iHOqLbZsRQ1ILixvoo/SAEhc6BtYeKHfvPak08cDOdqAx1KgO98uQjI0BcES?=
 =?us-ascii?Q?ocOn2qxDSHXkFQr3BNv1myBbBGDnN8lttvUkrtuOoWmK1bzw3tviSRyDsWFP?=
 =?us-ascii?Q?M+2/KSzP2Ya0w/9CT/mDr1fThvuFGIV8zSG38fIWS05iRJjZYxuA5/PbGr5q?=
 =?us-ascii?Q?SloHTBXCxS7KvOOx5DTN1qMjO0G9VzgrSZ1jZwTBnYjWVGdLFzxmiGroJaMD?=
 =?us-ascii?Q?96grNhidauJ+yZcZ1q8D3MhfZhWaaN1oKC3dbfWgAF+D5fhispUyiO61B8LI?=
 =?us-ascii?Q?D2KNKabYNUQ09pA/TSXLY5XWDUDyBaH+69IddA28e1uxPXMmCOB07DwK27Hh?=
 =?us-ascii?Q?yOsHU7ln0hr6v/J3UOjWOGaoq2l8emIBx2vBk2nzEFqkXGTyk5Ps2iAMX4/l?=
 =?us-ascii?Q?NnQNlcFbPMs7Zj1gTZzz8s6OcWULeuL8u4BG0nu98PQqhHMAf+N2b3qu8/Fr?=
 =?us-ascii?Q?m18LzeCq7D/EjvPljEBkoQqIhWPS2rSIXDQ7qNy+NF16J8HQmxV0c7OKBsD0?=
 =?us-ascii?Q?rpqQGk1rHbP8asH1MlTlkzUq4chKx9FFmRUpX1Jo4xdsKn8Da182Srf7CRri?=
 =?us-ascii?Q?hnkU8PkMJNyNkXz2b+xD5kJ4RMBmyKgMNuvu5bFF2vXLDGb0uOHNDxbCt8OU?=
 =?us-ascii?Q?kyUi7WylDgRhhVKfAH130N6AaR4aIdLpRR32HHe/6lk7XaNts6Pd4Tcvzs3Q?=
 =?us-ascii?Q?3L4Cdb+D3dHWllGJLnTo/AJn3X2OlqbnWXsUs/5SirZHOVReS5T6O3BvQ5Sr?=
 =?us-ascii?Q?686V2dbi/P55oETYaYCtlxtFwSPBNbCM+DSAhzvhlW/vdL2GKUvG3v6Vw4WJ?=
 =?us-ascii?Q?lR3k61siWyO6+XzYIglOkWA8miNGGyJE2AD97gSbeboA5hLAPikIxtV5fidn?=
 =?us-ascii?Q?9+UXGBZQFktEZK55m+lVxl1w6VRuofeo8rr9J9ce?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaafc679-6b4c-4262-f08c-08dd55b9dc4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 16:31:30.9802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSM9/Nfl9R2w67rjA1uG1oU7nG3z5AFYWOj34avgdWYMjSsmRwXCVbPwwqEgAnCLNJr3w5rV4lIQ3kxaJvy4Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
> Sent: Tuesday, February 25, 2025 17:03
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>
> Cc: Ori Kam <orika@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>=
;
> Suanming Mou <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>;
> Hamdan Agbariya <hamdani@nvidia.com>
> Subject: [PATCH] net/mlx5: add eCPRI support
>=20
> Support eCPRI item matching over L2 (ETHER / VLAN) in HWS, both for templ=
ate
> API and backward compatibility API.
>=20
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
