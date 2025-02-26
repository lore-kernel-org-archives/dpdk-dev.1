Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9547C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 190734029F;
	Wed, 26 Feb 2025 10:12:03 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by mails.dpdk.org (Postfix) with ESMTP id 281C34027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:12:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iu3XMtH6pSvEdEyBorDEdnzAU9Hho6YREo6KT8rnksZPs2x8aOrLWwmCQVMJSBVtMuSnUKGWzYugBLvJILDjcPB81PO+H+P9EJYq686lfChesvdkCZpDadM+zdKiPRZJcYMEm/EHG6Pd1URsUzYP8BkJcrAjL0ua9K1G71P+Jw/Snfqb/MnZpfhoyCufcwRwAocpgkQnieRWzAPAdigjRZhVNA+wam6p2gud73nvYFEmjubiLnNPENSW9VVD3hRa5/D1gqRvIisSsCl/Qf+xHZWj3UIK/0peSRmQGSMCUXtAyq5oO/Nh4EIgBmw/mVUfbXWbtqJQGJgF3XKIRlq8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4mRP5ynqcidByvtpBP/EwwHgeUSuKlS6SWjSjwVatQ=;
 b=WtqsOZNie1KGBpjZXVy1Q4FxMbuFLy417Q/ZEV5VjgxbmI016rTWrRSlxkD1sdbE40723rJBKZnUpZO0v45E57i7l6Wp6OJH6uZ7LqPAx3Dy574tHgMl5UDKXDDymqsPMWKvrMt2fAEpzP5ub2yQSiTT7QKVgGIe4zt0UUpAFyUPj5A425UzKieI0Ejjdtbq37ZQxgSq6ErAtmxCK0w6AofKc5PnJYvsfRPCpcdbqbR3zVyAsxJxtTyAm3lGSkl+SQlt1V5lfKLXsKP+V9RAS0wTly3HGeLjUpbD9To+LmEAgXwdI2DnYDbgQrWEqXow+gsz6Omque5QCI0lyH1kcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4mRP5ynqcidByvtpBP/EwwHgeUSuKlS6SWjSjwVatQ=;
 b=jCp6iHRgLw3RojL/EX4cwNPN+fgpYpKATVUp/x6BMuvpbSa7AElk4MRoOy4uJYM5dTHZemYzM+xpV4ecCV2l4IXF7i/jFp2J2OH+f3Ne5I0bJDxsVvY0IEnkDcflGVaHfawQBJO6HEbjdp7NW3d+V6w7bo+cBbo9xaE/VsgCOWcNVaFBVYBpE3paJCNFM27YEaYqFI/yLS6CvkXu2Er/+BcqLlYTEVxQz8cME2CvW77Lft0x1s18SDIyR5UQGOGk9ZRe4IRa0JV+yImnqQ55I89kcgeyF/6n8T2FDZVz/EU6EytrmwaL3RcD2ScmgjsKtCxli7FurZbROaEk4shcww==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:11:58 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 09:11:58 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Ori Kam <orika@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Hamdan
 Agbariya <hamdani@nvidia.com>
Subject: Re: [PATCH v3] net/mlx5: add eCPRI support
Thread-Topic: [PATCH v3] net/mlx5: add eCPRI support
Thread-Index: AQHbiB6RdjX+OhySu0m15MY/aU1v+LNZTKZW
Date: Wed, 26 Feb 2025 09:11:58 +0000
Message-ID: <CH3PR12MB846099AE6D1658C8102147B3CFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250226065023.12560-1-bingz@nvidia.com>
 <20250226071724.12769-1-bingz@nvidia.com>
In-Reply-To: <20250226071724.12769-1-bingz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CH2PR12MB9520:EE_
x-ms-office365-filtering-correlation-id: 4feaf8a8-f0ca-4a36-c867-08dd56459f6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?puQfGOgrVEkuyquf/OKeTIOw+g1lKSMnAWffBiSEqKq/brKMpZmPQ5aI8Z?=
 =?iso-8859-1?Q?ZLSajwOPQqIr8zLjXutykMm5y1aVN7Kr6Sd42UmE6gLvBKl1WJA/tRky0E?=
 =?iso-8859-1?Q?2GrZys01wB9j3cJWUkKm2Njgb/qWBJkmG6ICI0NyJ0nxgwXeL4bEc3Kd6p?=
 =?iso-8859-1?Q?kPCf09BgAzuKPjzMpOm3gOW2AqBjkSCca2tFmJe1FH3FguPs9g4m35KfIk?=
 =?iso-8859-1?Q?XsLiD9dl1wgPKCLOPbsbk8TnvSbr7cmvpkdI3A7l0pRhVDRfF17AH50xPN?=
 =?iso-8859-1?Q?rdXgn+U2pK7bKpRr7/+HtIqVDnypqjsJ3n0puM+ij//JWlKzn7pE8P+OM/?=
 =?iso-8859-1?Q?oiyHB39wLDoFofcFy7ebVWz1gfjHbOnyxKAJ0DnZQOmbQU2lQ/eCWELly+?=
 =?iso-8859-1?Q?WfgfIYIPGP6+YqQg0YgezPaV9wcGaf4+wvRqOBrm4cnwJ+fnT/SOhT6xag?=
 =?iso-8859-1?Q?v2EwhFjv9CB/WjjqhSs2aZZi7/XR9G5qtY71RWdK5ShY+lpBgWA1aRc2fp?=
 =?iso-8859-1?Q?M3d0DXKO5Yv+NH4gk6QdWvq3RZs43fitWNylVDDey+my51ExEz1q6VLyWw?=
 =?iso-8859-1?Q?mI+HP3fgozDY68AsMk7yaEal38FfCHFlS8qjohtxAm2rEQWhfYAY48mdnn?=
 =?iso-8859-1?Q?hIBgAhHH4oT/4Ku06ih6zzOJL7fCjRAIdBuq4/6oHZQVUjJtl9lTx6+9B9?=
 =?iso-8859-1?Q?axY5uOhaduwJkBmagu04l47/a4kkVoXlB/M6FYl5JS88Hbsk9WYVLhVBZd?=
 =?iso-8859-1?Q?jMDs0Op+pdysiyMej9QvWPaA6OYF1dCrpeRe1JQoEiSswJHZ+UD4QNc3s1?=
 =?iso-8859-1?Q?YFWSFYoPzsdgjEbQFoam0WfyKBpq215aQD3cajQ7H+du3EmBi0GQRo6NUs?=
 =?iso-8859-1?Q?41eLYja+h8Ytt3RAvz7ExKhSeiFjIXRbjidh8Ay4SclouDNp2FICgrJpmr?=
 =?iso-8859-1?Q?YYsuvERK4vwnW2lNjwLboZul3ArAa+5JuepLEgiY1eA2uRK3gNujRN/8/I?=
 =?iso-8859-1?Q?6CVggPttZnmsmvYEYHvOqFPEy4IzRsDu+ZNGisqyc1mv6dfL5VFQEGZvN4?=
 =?iso-8859-1?Q?aF/pyfaxsOauRHVlIYj05xOSOSVJE3qi6nwhz6uErmPhPeqSUa0LZg5z1d?=
 =?iso-8859-1?Q?LzAapblE79TY8gg6Mj7xL+LSNgqiQEPBgmceVQWNYGPiVwkrF8ZbmxUehw?=
 =?iso-8859-1?Q?GdvyJ1bwk95fpyOt0Npm6BZ673v45UYJebf9/8EEhraWKEQGh0XjmcxRkg?=
 =?iso-8859-1?Q?OJzfULs54pXnSdv9lUAnWCRQjMMFhBbeUWXeuHLOltwaxiJ/vTbV+TBSyd?=
 =?iso-8859-1?Q?vtxRilQDuAQKQg0qhbLLtdxk7CFMaUMQNPwJ7T41trMLnsIDLlMo66IjoL?=
 =?iso-8859-1?Q?Q9MHM/V1Y9v5ALlWG17QManZNxjukR8JbdqpeeO+PR6Eq7PoJnh3h92jpv?=
 =?iso-8859-1?Q?UBVPf4Mcv7FkOMDhDyJGnB+EE9J7wswbyXQWNQdKnVMFrbe7SJFt2qZJik?=
 =?iso-8859-1?Q?r8d2M9ejNN9vWZGLvgbV9r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D/vjf7PTpduhLS4IKZQJwk4u7ryLLKjMVZoirMeDrSN3+eTCda20Tw9our?=
 =?iso-8859-1?Q?DAM9KGAGO9Ky9djoDqjo1MfrfsaMBXpyQewpknE7nE/DL+4eQDxAJmgpqt?=
 =?iso-8859-1?Q?h5nSnFQyk4fCetmLAig9A8pp2geWhBPxMVdgWkNdoWPxNkTGq7eqKWt28m?=
 =?iso-8859-1?Q?pT1PQovw8YYTNJv8l9Jflmlzd6XVsbBr2zVsmlxHgC41EUNnSU3XPUQKSQ?=
 =?iso-8859-1?Q?0wrnusgNT4x0MJBFuRa7G+pyCACv7a84O9Vw+ejZvKJGoE5gwNDTnuKOXY?=
 =?iso-8859-1?Q?rRTL+AlbDq4j+UkWEVgYuwYhoRpmj6Zlw3SIVNDWIoXkeiNvIH/pl+hOyE?=
 =?iso-8859-1?Q?YAG04h9qSfIsQf6rzVEf06nMDym9HDYQJEEL5Ic//iAXk5K4yORPUmwMzM?=
 =?iso-8859-1?Q?Rk8mg9c44K2yO0fAFcAu25Pwp5Q403O/8VaT5BQE34p8v7hdv0ESao9xYe?=
 =?iso-8859-1?Q?VlPbNCCYjLbn9kC914lMuTDWcIaVBUk69ngqFpZjGomz7HaDMI2JJAmZWT?=
 =?iso-8859-1?Q?C+0NMXbFxPp7WeRNqWFQQgTRVe0sYvHJjjSxC3Np25bUR+9w9N/ITACKkr?=
 =?iso-8859-1?Q?ZY7fqsCIUuiRZmJjOK6IZXVhoo1E681nSypmFKhdorv0iUgt0vzgf4FfjX?=
 =?iso-8859-1?Q?8zmNWnFWtJTAPCU6VWJBcWhU7tCugpRgOr6S2dbdVTmKsHXfMxLZqz0Dz6?=
 =?iso-8859-1?Q?57ZG+gKQsfynyTagcyfg20QlrFZh0c5XGfkFets/Faa/bHMIY/Y/9n59MV?=
 =?iso-8859-1?Q?zrGcZtvrIhXHvEJ6BGcWOJi4kdUpXs+QnKQ7fDCBKc1AJYsY1xVnaaMy6F?=
 =?iso-8859-1?Q?6XMVH0XzFU0sbLyO97ZgIlHvD6GlUmMqjVHMCjE+9LVnPoo52fnc4VVEyN?=
 =?iso-8859-1?Q?XtgZIRwRR70LKh/F9nJ7w880Lnk1+sKjNPraaxWTT73QaIajwngn/97qUX?=
 =?iso-8859-1?Q?epaUHsestSNQyu2Gj+4BQWgTGu9KaKFgYH+HxsuvhFJGOxBWWXUDeeU2qx?=
 =?iso-8859-1?Q?onGoCH+PzxG+OwojqNpMKa6gTbvUAjbMtLMzzjNh657TGqcApb8rziejwd?=
 =?iso-8859-1?Q?vtbucqPrOlfbDVAAN4ApSXGXobv78glGiJo5JK+O4FKo6dAAzYn0lXMNQM?=
 =?iso-8859-1?Q?s1KqjqA3Pfk1kUwGP203aZ5gxx4SJCDQ1gUYFdDpGQJcipVFTaVpPf/gw8?=
 =?iso-8859-1?Q?SlY/81PUjOuqXB+1Y1aaikQFEUC6VzVcN32HE9ORJF0TmusNNVdGMYuCcj?=
 =?iso-8859-1?Q?IBPZcEH5cuVFhemUTIsUZgbfzm4wCo/qVAgWhHkp9ZWcxh55yXXRjU4Wzg?=
 =?iso-8859-1?Q?meVNhrdnKAbfMYh2OJNR6BOHUkbw4CjgMoSkqA27HGy81UuqqNxzLoJwbN?=
 =?iso-8859-1?Q?XE9X5qK+WmOEjzMJtSUrmLZpQ6jXXbabGKDKGJIqLafa+t9isOxPLhM3kI?=
 =?iso-8859-1?Q?fLsrBszpD0yeq43YGVxklw2460Ot3fJNR17d+u3dTW1w/BgRlaG2lPyZqR?=
 =?iso-8859-1?Q?/8QRqJQxgeMpGMfXW09//W/ZZw4k7nVn7gwZBedBNgZiAz14FhJDdysvg7?=
 =?iso-8859-1?Q?qZN4cvRjRrPc7h4dWdbJd9AQbhfGaJcGpsoF1cUBtbJGcXB9wKMY/F8HNO?=
 =?iso-8859-1?Q?bs4rI1nNuXA9M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feaf8a8-f0ca-4a36-c867-08dd56459f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 09:11:58.3531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ry8Ai344A2yvbg/sxaWcq6hgn6Ri3SipjFEtC2kEF1zWDcive6Hfcx3zwhIDm6AGLkGHqZbMSalK+BJ+vkEW5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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
From: Bing Zhao <bingz@nvidia.com>=0A=
Sent: Wednesday, February 26, 2025 9:17 AM=0A=
To: Slava Ovsiienko; dev@dpdk.org; Raslan Darawsheh=0A=
Cc: Ori Kam; Dariusz Sosnowski; Suanming Mou; Matan Azrad; Hamdan Agbariya=
=0A=
Subject: [PATCH v3] net/mlx5: add eCPRI support=0A=
=0A=
Support eCPRI item matching over L2 (ETHER / VLAN) in HWS, both for=0A=
template API and backward compatibility API.=0A=
=0A=
Signed-off-by: Bing Zhao <bingz@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
---=0A=
v2: fix the checkpatch warning of unneeded else=0A=
v3: fix single line if condition code style warning=0A=
---=0A=
 =0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
