Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7173AC021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 13:05:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2DD1402D2;
	Sun, 23 Feb 2025 14:05:06 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by mails.dpdk.org (Postfix) with ESMTP id 3BA7B402C2;
 Sun, 23 Feb 2025 14:05:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tcp46983X1RgcxddO1tUj/usAzgYKmGl+/TvoobSVwFRWHVEU6gSlB57Xsh70Zbh+MaFgC+25aiJcMGmhVOAeYhMYvPct0K6aliQ0ozfRwbebe9pIDqwfK4YNupbgSRJDUux3XFak9tWO2Xi2yeCBpG4NutrrW6DoUkWpQqbYtbnNMD/e+bDYltNsYti70pINIlb8xcMXDUjLYdTwZTRoMRtxDpLtXo3VCE18DWF11X/Ub2ejp7kPYOqFmuiQhKEVZoiNedmtWzdB0rp232DCD/vpELAH9EAcBZZYTzKsTvAFKG6m2w1asdroX54cgEmy5R6aaDGiIcedNB1Yn/nHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDkTjO4Vp36ITcB0sTy0KE8DjHrA8bYsa00Kjb+hklM=;
 b=w5mBVtbwf9wpUSZIMCDTFV3HkzLWMBow7h96GQOh4mXaAHHQO15hGDRC7rCO4v3SQu1H1YQ7ErlGNEk79A7VSZJGmR+bzb1mfN0ws6JoHncuSjK2rwwSl3o2skrjRogslDma4cgA4zbwTDQIbJ4xeZeANiiUC0erpMKr7W3r3eurNx6iYTfvy7WrqmcHxFhtFK+ay53JyXRZB3RR5uE9b3M4wtw65p75QRSFSSegiDyyYoCioMsP4nIXoLZB3pcjiZkbnL4N+AgA2m50LOAa/fdgzIg9bNxt9Zf/zVOgYi/Pn9pzlWkyRuUQtpMNybrha+48nsQCvzS8B96vDOE1Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDkTjO4Vp36ITcB0sTy0KE8DjHrA8bYsa00Kjb+hklM=;
 b=SVtKl1lyEgF0mdtEU0mEcWULl2bm72gG9M3ZXRBwEZEUIxv00VMGQtYX04gXIpY9dmnHJ7Cu48KQ8QqCYw9dsvtMKwzzH9iiP5bWQ+fknqwAObhU/g+c3OTKX/6jeNpkK/ooN6WSOlI12eX+9kDZNH5BVVwQvS53uE5sNHYhbekYQGISJ5kLehmZKf8PfLIdasqs9aiZuWnC02N4QpLCRhuAB+CAXrHGYAz0uTljQNAsqtlWOHp0dBKX4r41mciC+t8tqoYByr1iXx8EIXDSN0fUzpSSkjpXpMhCKplPtLlQTrSyC3t/Dlq8a9WvGonCnOt3ldb3JX2OQ5FTjFdhLg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 13:04:59 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 13:04:59 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Kevin Traynor <ktraynor@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, Ori Kam <orika@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix flow null ops seg fault
Thread-Topic: [PATCH] net/mlx5: fix flow null ops seg fault
Thread-Index: AQHbfsgNi568RzlMj0+quclr07GBqrNU6WpE
Date: Sun, 23 Feb 2025 13:04:59 +0000
Message-ID: <CH3PR12MB8460F361AD9E680026F5D6C9CFC12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250214100545.413991-1-ktraynor@redhat.com>
In-Reply-To: <20250214100545.413991-1-ktraynor@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH8PR12MB8432:EE_
x-ms-office365-filtering-correlation-id: 8650826e-bd98-41ec-61e7-08dd540aad68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?i80VefeWWEua9BbHblDRXM/ts9N9dfHiDPU9DdJDHrdMTGoaiAfEEfKjI8?=
 =?iso-8859-1?Q?ErGCF0b1Rpb+CfuuK8ZDKXnOAUXnYhPx5M1F9oSUhbGI2K8UM/3rMgnHsM?=
 =?iso-8859-1?Q?xjeiuGT+Bpq9brOtoU0BA+rFHIuvwZp4QJAuCnZ3YAY8jrf5sFGnYXAo0x?=
 =?iso-8859-1?Q?Uyap8yMkc7KgcP/2qiTRYsnEjz/wu0+anuuo0ypeNq4ZuIgjdmkKZFKdOL?=
 =?iso-8859-1?Q?oIQ7Hy2HI8pEZq+ocg5knPqL65As603R4VdodC/r8kKLR4uSYaU6Z0f3tK?=
 =?iso-8859-1?Q?4RNQJMR+E/bpeSmrkJYPbtHvzwWRjLQF8M03Lb6ANm/+pWMx8HacWY1DgM?=
 =?iso-8859-1?Q?Doay3Vm0tDTVotdcNo3Rs7HszRuZUNWY19paidIpngKtW2qc6qZ3iFVHfk?=
 =?iso-8859-1?Q?4FkZcIffoV0mLb7a12koBSYZk10Xe38iaMLGPlU6w5AqXSfvqfW98USsOr?=
 =?iso-8859-1?Q?nA5na+aeZOTiXLWdmvxpB3C2BphtiuACOaImR5nF1BwzwqmuVkTPw6gbXx?=
 =?iso-8859-1?Q?MEWjXFTvaochL2NmORk/hTCaHDStY+YmJ4T9lkJuJr72iSIVs/gHAgHWxw?=
 =?iso-8859-1?Q?x0+psgablbkVMUcTipCNiCLajp4l8rvKJ/J12ygd8NnUcs9MXdq9isqEdX?=
 =?iso-8859-1?Q?8V6dOnEBok31CX72SzjlIUEAZcSIyivMLSOEUTabIJCVSZ4fS4ykkchSz9?=
 =?iso-8859-1?Q?4TJIyy2Yz3l+SuGJ4Kf/hPBqB43tzxGMTkQCHoY7lfrqgR8ti9EGvpfSBG?=
 =?iso-8859-1?Q?tuMVYGjwpUK8gv1MuCqs1fgNdM2q96lSJx2O+img/2pGbB9LCYL9Ux9ogL?=
 =?iso-8859-1?Q?R5PBd9jsN1tb91TzWeJ8AQgL9VI4WluAQcdvKJRf1OwGV4bV8DDIdMrrZ9?=
 =?iso-8859-1?Q?V+6B2glB1KjNN7V/QmprCxsVxmUZx6el/yqVngBXf++wzSzR8aI6flS7Df?=
 =?iso-8859-1?Q?8W8Sli+dKLekpeJO4DlM6B9tq6e+rcbqhq6rjnVvwt0HQegpk4QqwKmuJr?=
 =?iso-8859-1?Q?t2ZaVQWeZjx0BSTYuHjTeqCC+UwzmNLzHZtkvDtMgujN6SRONzp6vHSJf9?=
 =?iso-8859-1?Q?esKhTd3mko6MAV15sHlpw1KJL5YD/wY6riMiU8EFb73n1XnepMJO4R3R01?=
 =?iso-8859-1?Q?mHhG83weKlgKRw2q6Zd7SamWp/LJIZMZsjFqyN0LDD/hsYdzvJC3/DhLe3?=
 =?iso-8859-1?Q?3Cotl1f1BsxEydzYLNOE8LnoI79v/f7il70KJG8bKZjrnG97ris/ufu/mc?=
 =?iso-8859-1?Q?Gfzw0XHFlRAFl1E4pto27bF3N6owqWdW/5Lu4kWkx5/jLM2UW9Gq7Uex9M?=
 =?iso-8859-1?Q?nSk/E5lAtHPuQ057z4H8Oyq61Mr0ZTLFtokrElwil7YBS5rLzuEsGSYSvi?=
 =?iso-8859-1?Q?ezBvtKP4c7PtiHdF/7Mt311rO1EJveICzCI4Ri0hElPhfXmd7/jW7pKuoV?=
 =?iso-8859-1?Q?C5B3+baQFon3RTiyknuEyIu59h1taIiBGW5QTrnW2q29Nlq7nmCxaT075B?=
 =?iso-8859-1?Q?VW5TRSu9B32Z15Bvj+XVSS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Eadf8DeqcjK2yYl7cEJ3oKz2F8v1QQqYSshWcGCt3Lphgh0o/QpeCWrL2V?=
 =?iso-8859-1?Q?03UExvM0GPlazn8qB/Xs7AH3A6KuVapK9Odt601BjAvorrFotbcOe5cOzL?=
 =?iso-8859-1?Q?AXWaPD63s23bsVPLzwDwUK0bt70L5semLslztfCx7B/LqIpVm3sB5/N5fo?=
 =?iso-8859-1?Q?U0S6bPbQGJl1AnSt48O7TWNuthldJ78PR7qsY8KWmzffu1zJYbzhL+ezIr?=
 =?iso-8859-1?Q?VEIMjAO1uNlVr868di7C7rezJ7iWFGWuD7xpqs15k7yUw624xjDQ6Tm6rF?=
 =?iso-8859-1?Q?u22ln5ZkpnrKAI1rWyBbAK4aqcfcxrN40ow/Ih5ynoMqdOg4GOaLmRfeYb?=
 =?iso-8859-1?Q?APspjeJtYaqo0uhyzebXOn4eVUi6hlDqmjI4NkbGgXvfELZRdWmXzdtSZl?=
 =?iso-8859-1?Q?bTF+WnddIlMuu36OwTz7P00VlneMLVBeZhWuN63qDZHUa0oM+UW4AoRUzA?=
 =?iso-8859-1?Q?1jueInP/+4uCU7N8S23iOB+QzGeJXUE7NLxQk1T82WSV3KJCVvO+ZARbJi?=
 =?iso-8859-1?Q?7tugQKNdOpPruz1K/YK2Vd8ry0aGDIACp/cKKSn4FbDNxrTMqu1p9KFHEb?=
 =?iso-8859-1?Q?gfPt4WqOugPpFGNYZL58jmbUASXCEaHP2meKFua4K1OiKZgG7Y5PLFVnMF?=
 =?iso-8859-1?Q?vtobK+4yx/VKo2ggrQQbrTansW3m4TLICAxhpExLpamsN1wEA7iA5QAu7c?=
 =?iso-8859-1?Q?mmG1aUY6Oo2Hk4fQvmRHLZ48PN/HGMSDSu7N709W/vT7v0VpEXIp4Obp8j?=
 =?iso-8859-1?Q?QEp1ra8HNuJUqxxhtLZMRuZd6zKG2z0vxfmFs8JUjZWNejVr/C5pR1s1f+?=
 =?iso-8859-1?Q?HbFTCBB/zNoK3FZ5KToaPDDzre0vnucGkJGHcVG5PdcI/KryCVXgK7gvXY?=
 =?iso-8859-1?Q?rDvJJiHrRWKFODE9JRQSlLcZcf5vt2IibZyK6U8e6ojT6pQFnrJrqrWGdh?=
 =?iso-8859-1?Q?BFm/ifT5k2irAFjqOjv6lDa3pSdvRlr65pZjuyltW0JiRM4OKdFCmJ+Ytr?=
 =?iso-8859-1?Q?Q5rdyzvbDX8U1dUA7R0SmbSmyDJXLcjtpQo83fPoPCUWC0hRfatGGIdCl9?=
 =?iso-8859-1?Q?vYxeN0kbhfA3v9BVCWAiKbZzDgGI2ngokLZcIN3ATq8HjFPT6icoTOwJEU?=
 =?iso-8859-1?Q?B8RQEqF5dsD/rfwrRyix8+HV5dprRu0rknCaPSoyLqzq4mrVytWwlNvROZ?=
 =?iso-8859-1?Q?jtA2wE8miOxgEWeWB9x7M/W5hzaCBIqHx+/YoiS0eR3luWeWElKnt0iclo?=
 =?iso-8859-1?Q?kDFrFIOa4dwMvBRtGj4t9cuSdfDhGUj0v4ZhoHWqiE9f7jjtFvJ7LggsWI?=
 =?iso-8859-1?Q?10L6yV8xYLCi9oijM8QuRqyknG5i1Ab8hEn8SPRSBxUmFY38eoXi0iZkBi?=
 =?iso-8859-1?Q?fJCVHTE+EVWCu0/euELCc6FYOPCz6pzaKlxHxON1gzbv+fbAh1u/MmHxW1?=
 =?iso-8859-1?Q?AdQZ8HFFjGZwfl+zYs8tthZi3s8UGUBZRrJNVuFlJ+OaYKwnUMtWzVvsUz?=
 =?iso-8859-1?Q?Kzx99O3K/d5jcT8/3TCF9Hm2XwQoF5a6PGNZlB4Wk+gIxQXNoRVR2YmMtP?=
 =?iso-8859-1?Q?kVx7vc4L00XSMfO4RYruiARfGRlBqy9JAGIg79TTFd/1zfVGZZzNAHKoUx?=
 =?iso-8859-1?Q?QaIpZifz0L0Dg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8650826e-bd98-41ec-61e7-08dd540aad68
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2025 13:04:59.1705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErSiNY1Rgv/Vni8xrxtG1LQ5RgFJdanZuRepX7xvFjnO1yAU7j398FVnutWyneb6PGgNCBNC2FUW98I3glN4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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
From: Kevin Traynor <ktraynor@redhat.com>=0A=
Sent: Friday, February 14, 2025 12:05 PM=0A=
To: dev@dpdk.org=0A=
Cc: Dariusz Sosnowski; Maayan Kashani; Raslan Darawsheh; Ori Kam; Kevin Tra=
ynor; stable@dpdk.org=0A=
Subject: [PATCH] net/mlx5: fix flow null ops seg fault=0A=
=0A=
flow null driver ops may get selected and try to call .list_create=0A=
causing a seg fault.=0A=
=0A=
Full details and back traces in bugzilla.=0A=
=0A=
Add a null ops implementation for .list_create.=0A=
=0A=
Bugzilla ID: 1661=0A=
Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")=
=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Kevin Traynor <ktraynor@redhat.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
