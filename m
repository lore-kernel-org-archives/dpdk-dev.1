Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE89606FAFC
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cjir/6Y4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32C38402DC;
	Tue,  3 Nov 2026 12:06:49 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by mails.dpdk.org (Postfix) with ESMTPS id CED73402C9
 for <dev@dpdk.org>; Tue,  3 Nov 2026 12:06:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGR9W9Hl7kEusL7nlRhZj5bHj8tF44A/0AbbR+q64nM46dnOc9yBOg21bIME5w3Nfaa5A0zDnLM65kwJ13a2wvgzf95DN6BfmiUU7LikxFZtsN7zqnjQp2BPZGpa9XROJjHjhbC/sphZK5f60jTiZcpFLCzFKgk3QhNhvansasiF/2Yg7i7UkFyEDeJOLm2EuGj82zQ6/3sNoFvmW3K6te0W2pJvNitbnNfQrP8TjDjWQvhleEnsNbCD0DA0fj3rGpWUFHArebBM7+8Vh2yNrAYM8dPbkpYM5QivdS64lLj5qOOj8lt6OgWoZ0959L96rSTdh8xNQXmhn8VDVBI5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro0e5TSSr2LxjV/38YuSmdDpx1K6tY8/Z31P9pY7o6c=;
 b=nNiwZTf3JffwySW9+bLCMEwGpJ8FJzNOII1r9N7HZRQlkyxVN8dN1Na20gJaSVJw5oyPMvVrv6gNtXE4mYexzIWSv7unRpjNyAEl54RKWMdS4XEwh25M//4EhjSAzrDUK6WgMIC2Tqfmr+V0dwyGEdXlY8TA2FiCISexZLu6DJ7tPKzTiBicpnxLp5xQvLuPVDAdMFlVjX1KMODxL5drlpzTZ0BR8dMYZDjhAv67UEwxSFEwKwfiOv252M6dnIZk5WGKCGaQMkk4SBXogLK9vOLOGQTTzrLCbcf0duKFPqOW5c4NpmJcSQgmGW6BUc78zjP7XN+/7oT/WQiebzhHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro0e5TSSr2LxjV/38YuSmdDpx1K6tY8/Z31P9pY7o6c=;
 b=cjir/6Y4C1tdhEWk3z+BSzhi2uo54f/8tg6q52HB7pgUQrQsEfYmRa6hBl8dCZivocquIZscLP2A6z1StnZUZZu4J88JktFEXateSkZRPOKS5fVYwwteqb707dpId/4VbBRDnLphojPwJWU2pVTNIfQLvuDsIqOJeafsV9iPZDl6ZvNxIIyA56EPkrdGIQiOYZbMOBSU+l8vlMQapGknu8H/N8I6NLoVyOVK65YdPvlIs2xnYKGS1uv9ROj9nLZOSxZRyOrnxJ84KXA/uDWPKgOjLsPCE3+zgVlr1zz0Kn/olaTow8a2QbwDSrbBndjEaJmkgiyr96oSgv8ecbPF7g==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 11:04:40 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 11:04:39 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 0/2] net/mlx5: improvements to link status handling
Thread-Topic: [PATCH v2 0/2] net/mlx5: improvements to link status handling
Thread-Index: AQHdaJRFZz3oVraDCkGLaeaPlEiFVbcacVEAgACgYlA=
Date: Tue, 3 Nov 2026 11:04:39 +0000
Message-ID: <PH0PR12MB7077AFBC1E81E2E489F6CAE1A4692@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
 <20261030172843.2304296-1-dsosnowski@nvidia.com>
 <20261102090744.06c8be14@stephen-xps.local>
In-Reply-To: <20261102090744.06c8be14@stephen-xps.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|PH0PR12MB8173:EE_
x-ms-office365-filtering-correlation-id: aa3bf7f5-5cd7-4712-845d-08df399a415f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|261022075727099003|261026140227099003|261021123027099003|261026121527099003|261009223027099003|261028144727099003|261022105027099003|56012099006|38070700021;
x-microsoft-antispam-message-info: +je7NBafqNRZXEuee9UWhBXB+xPtW8qUQNwOf4BXDTtFsYPej6ceAMIlZXb2B6Ov707cSxG9xEz7x95TkQEJsllO9oVNDP4T+aU3VmUwjAzh+2WTJ5oYdb3Oy3Nh7XVQ3vP5YWPWkBFD/ED7dRwp1ydC+OJzSiWLCZYC6ff6Qj7YPnbH40J1BzItFYVwTOJI4c+SIBMNXSXbT7Cmubq8MpTgpTCaDf1LSXwNxwxBWJsIe7f/WU9MtKH6pQZrsKxLZWhgS3ggD3daU4q9TfMT1UeEFYdYPl49GWVlImqKfMfXNgT6MsyBl0l/SPW6GDMbO37ZqnvwoEmmSZHKuXIvC0uhjO49rmkXYLPOngZJs3nr01VaWwnLuDgIAbKJoUl6S0Tlgk5eZhKJtvIrkN3OxjUESJ9x79/2iLseilZFw7pzTJQAIl+ugBbf7NzyQL3mwue0Xp4VjmY+e0VVMEbrBOI2XTJ2in67tO9Ep62jxx4hA3hZlINvY0RRdvuGLqMoZJnXPbil00zkKYAFLkGjVGHoi/qkIfTcdH7NIsGDSK2/oeptQ6PiK2GdXeGa9liIDo82L9nCBKlvUTkEUIn/ewbpc/BMQ0JSlUf4ljKqk+n1hVtfcsqZbSAYTn433SuCVlm5SKtyNcQ7bSzzNJs0Pwvt3neTzDlkj72Omce0fZKVyQsDoczVP51464W1Z3NA/SxpxIbFeYahFyIYm6idPvJY/qqvKkQY7r6qCj04u3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(261022075727099003)(261026140227099003)(261021123027099003)(261026121527099003)(261009223027099003)(261028144727099003)(261022105027099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ymSdUPTf0hHI3238kmnApQiSDBnvaYhtEXuPSr+uzoCsCquybtk4yVLQJaht?=
 =?us-ascii?Q?AoxD9ntthk1svlwX2521wI0iYgC4/nTQuBr0zVwgL3KtGMzY5iKr/eyLBUSh?=
 =?us-ascii?Q?BTwUuMngOBlCaExcd8IdB+8MmtrU7H/K158SNNeWGFfTqAxltF1B1NgN+a5P?=
 =?us-ascii?Q?k1EBhwB/2OXNstqAYFvQBPTUNa9dFO3gqFJL3xkbKyVShsxulaoKZKKhiv2W?=
 =?us-ascii?Q?a4pOf9FYVTY+BcaKVB4vvZGEZjcDHoZvproVzJjcQTB8Hn7/+iCUbPUbfWMY?=
 =?us-ascii?Q?4C9TE/YuFPebnVC4LxMBa+CT0rXm1RChXzTwUx2ZHG7neUjNzBeof2ruZ0Da?=
 =?us-ascii?Q?uGfcx1Hr4tkbgfqLdU48HAL9BIhBrVHOpclQ7SzkfEmpQEBAkXYCIb087oZz?=
 =?us-ascii?Q?OKYrPSVexqMEiJMHmzqn/7dqSAAeTS+TItUjgyG2/PK5Z8pnXr1Q2u70rGUa?=
 =?us-ascii?Q?NjeYBRuiv374kXHXiQDcI8bgYZAdeCuMBM8kPVYgF2NdT6EfU62f0NaPcvhG?=
 =?us-ascii?Q?VHlBqvdiIAc5Pv8AV1jqRjSX/t2vIrkUsE42RuCgpgh0m1SB0I2zS7V4ekfu?=
 =?us-ascii?Q?45nCHxq16x73NGeasRv9557sxyu9Qrvi4maaLEm/hgihZCtuZjxY70QPL3v1?=
 =?us-ascii?Q?Tcwzrq597/GnUWtjQU9HouWLlMkm5omjxHMnMnGQItxJ3FBxqsoUaS/XOsgI?=
 =?us-ascii?Q?hqJfPjEGD17CpvlLEyQ6fC3B3DytzYYt0pSXit59WJib+5AdsXvr7HA4HnTM?=
 =?us-ascii?Q?zDfif/rXqt8vkCM8bP3UYZ8rQWlHSnsGl92yOJTDo+IjZpjH7CmoL9zrAlAj?=
 =?us-ascii?Q?o2RnrFHO4pkPvuu9rr5ZZC9su4gYFpalPb1m47MHR97N0p96Atb1ajXiWgik?=
 =?us-ascii?Q?Z026/rMPwCfw/FIU1EADAcvMEQMtk/pgnU9ZgfdcynWhs15+jJtXr+f9bNHl?=
 =?us-ascii?Q?Tjs3loo9HHsYpRpJ/sxL61Kq60C/q8iEpm1jJItJ3FYAa6HSKyUz0eZ4Vfyz?=
 =?us-ascii?Q?ywfxDd1sF4H5RO271v7FhIxPmrFcZ2VAZYiixwk2jMLWkzPDIByVlL5leF/7?=
 =?us-ascii?Q?zs3RRtc1Y5ipZhAFxfMNTaj6qhaBkIEwPClUsG/z3rvEzGfRFdaUEYFPiORN?=
 =?us-ascii?Q?Di/GcQL571YdvqFCOwffi+kjCUvdrXGz3+3WUP/169j6475eRb4eU0gbTInf?=
 =?us-ascii?Q?Cm3Da1OZdMV3wTOp7gHg0O1aWNgulxSYgoAjtc9wnF5AcONnyoRwa0bgHJWy?=
 =?us-ascii?Q?pZEiTQtjMtOnEvKMlqc2nTcVCHi80coVKGpPOgiW9eSqC1UNXDANxLp9DPjf?=
 =?us-ascii?Q?RwQeJ0TApcGAiKVNnEIK2dGpEfWxTX3D2Lz6DuUPFuOHyPgme++6nmnxesy0?=
 =?us-ascii?Q?ihz8liM80W/LC9tkTzGSif5xeM0bkk94nzKkKk8sw0sZ62is14prEQGOgslx?=
 =?us-ascii?Q?sA98TcorcfdmO0hWtcCBKN83+Ps6tTTZHzURgjQ2F9PVhpj1J2F0sPgYxVBj?=
 =?us-ascii?Q?OpdlT5MtdlX1yiz5Wj1E4DkZ7CpNT0UQqse4PWTpa+uNReV4JjD1m3INzSRT?=
 =?us-ascii?Q?8nuN/pSUKoRAT2csZafSttlJlQqomSxXCuvCT5+iA9O72LmOB9NzvXTPhR9u?=
 =?us-ascii?Q?gXpFTOP9VeoBbtihLijsztlD6/NnP9eDlPKkanRs3b6FSErodGQ6LiOpu78M?=
 =?us-ascii?Q?6hR/afIv3kDzFDpz77fl4ybFzbd9fANiEy2J8gcd2c02sHi08J90iGrxEEX3?=
 =?us-ascii?Q?ytxUVsBwPw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3bf7f5-5cd7-4712-845d-08df399a415f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 11:04:39.3864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9T2riGn//v5n53x0PCiJDs3aPVO6BAwO4QqnKljCTD98hDP90G8STuK4JsGta5AS25KraaFniyj/A4AFv5YNng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, November 2, 2026 9:08 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>;
> dev@dpdk.org
> Subject: Re: [PATCH v2 0/2] net/mlx5: improvements to link status handlin=
g
>=20
> On Fri, 30 Oct 2026 18:28:41 +0100
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
>=20
> > This series is a result of splitting patch:
> > https://patches.dpdk.org/project/dpdk/patch/20261026160400.1290443-1-
> d
> > sosnowski@nvidia.com/
> >
> > Patch 1 - Fix for mlx5 link update function to query current link
> > carrier status, bypassing the delay introduced by linkwatch in Linux ke=
rnel.
> >
> > Patch 2 - Move to link status polling, in place of relying on netlink
> > events which can be delayed by linkwatch for up to 1s.
>=20
> Instead of polling is there a way to get the lsc directly from devx or ib=
v on
> mlx5? That would work around the issue and avoid the overhead.

From DevX, unfortunately no.

In ibv there are 2 options:

- IBV_EVENT_PORT_ACTIVE/ERR - generated on up/down respectively;
  On ethernet devices, these are generated from netdev carrier state, so th=
ey are
  subjected to the same linkwatch delay.

- IBV_EVENT_DEVICE_SPEED_CHANGE - generated on up and down;
  Is generated immediately on FW event reception.
  It is available from Linux kernel v7.0 and rdma-core v62.0.

IBV_EVENT_DEVICE_SPEED_CHANGE would be ideal here,
but there's no good way to discover whether currently running kernel suppor=
ts it.

Theoretically, this event was added alongside ibv_query_port_speed() IB ver=
b.
Following logic could be implemented (for DPDK compiled with recent rdma-co=
re)

- Call ibv_query_port_speed()
- If error:
    - start listening on device speed change async event
    - on event: query link status of DPDK ports on that device
- else if ENOTSUP:
    - start link status poll loop

>=20
> Long term, it would be good if kernel had sysctl to set linkwatch per int=
erface
> but it doesn't
