Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F107AEDA693
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8059340E8A;
	Tue,  3 Mar 2026 17:17:11 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by mails.dpdk.org (Postfix) with ESMTP id 79D8A40268;
 Tue,  3 Mar 2026 17:17:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvXV9b+W8APnF9Bi2kS0rzhAp9+PZMzaBW/HuwHFFZ1PP7pcHUoywAsWsAlX14y51ZkA3atQInUpN7bxUo/4g6r/+VJYmSJiJQRXT5BybXijNOuS4EtSev5LdMSSBYqvQYaeV5KHHjqCbi9hrPBfoU5b6SfZG+3ZiQBUZczJthpP3vycmrNhKo+sS64fwQkSjC7Ty8AUnXEWhzIImH6bKeKiiGRB2USsU9j+Cfeh/yhhhoa5dThasWwRWseG8iGqjW6X+C/YlbjkFW5pUxh/dFhk5EtPkW/MTYyfANtU9R28TbZWF7AnIJZJ1SlAawiV7wu84Y00h2d21KYiTTB8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk1vyNss5NskIZig+Ky0GGdSORs7/ntG4DvVm0/HjHM=;
 b=I+cE4Ee8s+mwI0h61PjhAIohyl5CG7bccfO7UA3qdSHngbKgbMZH55v719IuutlBWtv3OFQ2Hmxv6647n03kvR6xlgYLN+8nVXdSXxDbyRmpIkdQwUjuzu5PIuOXU3HvrvuETX/qp5b8b1SWJZI9M9ruVL6Bry4IKKT/6kalWfavVsUl/Fe5j7ok/T8nt6tQORiIk4yvuc2DH5mBx3oVryHeeHkwjoXx4R5KjZ6hgV2Q6aoaphb0OGpy5d4lbibCVB5RsSQKQCEKDpgHiHpB1+WjStAnniC6hQJRGW02P/VdmVrJJz4vvsghUZSIw0jE6NK98FrKkxrWqJ5ngsgiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk1vyNss5NskIZig+Ky0GGdSORs7/ntG4DvVm0/HjHM=;
 b=VgjlJddA9piwwPxI7KsrOsz561OwQxPm2AWULEqQ1VmyE8oQDI0T5Gd51ug3R5Iy7V4IQE2mz7GYuecRbtbfDC4EAPkDlXugpgSmHCcA9/pulIVV+/vapm+fbKpGJOmMnEgrpXlc4yKdW6JVJHd0c3/xCGQQDxXE6tg+NJcZtuJzAxweZ/rGO+KpC9NamudI0cWuWyIXprq+u+t0iLPGbQ6d8aYp7vfnB6/WAQ/8DADlI2bISJMrKtIUFgbXjHLSczOl9RFdVq+i49C/vbr8IsRua1u6UI3iufJWPS/FrK8b6m/4lxK9l3CN7lLYgekIADnEy1/eqh8dgaiEWHcGHA==
Received: from DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) by
 SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 16:16:59 +0000
Received: from DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3]) by DM4PR12MB6087.namprd12.prod.outlook.com
 ([fe80::3359:f44d:6814:3ec3%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:16:58 +0000
From: Slava Ovsiienko <viacheslavo@nvidia.com>
To: Kevin Traynor <ktraynor@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, "hkalra@marvell.com" <hkalra@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v4 3/3] net/mlx5: check devx disconnect/error interrupt
 events
Thread-Topic: [PATCH v4 3/3] net/mlx5: check devx disconnect/error interrupt
 events
Thread-Index: AQHcoa2LKoG2UMAb30Whls5ETPToC7WdDtLA
Date: Tue, 3 Mar 2026 16:16:57 +0000
Message-ID: <DM4PR12MB608705C468164E6B7FACE64BDF7FA@DM4PR12MB6087.namprd12.prod.outlook.com>
References: <20260128122055.192104-1-ktraynor@redhat.com>
 <20260219143852.200722-1-ktraynor@redhat.com>
 <20260219143852.200722-4-ktraynor@redhat.com>
In-Reply-To: <20260219143852.200722-4-ktraynor@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_|SA1PR12MB7366:EE_
x-ms-office365-filtering-correlation-id: a90a1c17-c341-4580-1d5e-08de79404b1c
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: ofQljYWtYwUkpURaCn8WQsheRP2Ooff5rD1rMaLReOXEUOG1i0cftjsD+e7WROAQGxEDw29QZq6IIiPhda7+0SuMJfdMRUolpR3hF9uF+odSkunKvRpXQtvPiVfiHzrfJY8rSDdTsdYZbwEnosbtVa2dveZsWVLO+kP8p5Kf6E1ymt321G8SCBfT18j2wxAoOwOqq+XqS6Zn2qo0eRsLjLWtaYOgpG2F39KMr9HCHozWjSeoUItCP6H4WELbp7piRtG0hwb6sumeWRR3QDmYKsFWfhxhOAy9bNd2hkDe6C/srZ4EArfcBuzohDpOmMC5y057Y5sW6cGyldA8Ljb5vzBbMrqx8Yd3KpToczoOWkVXYVQ/5Y3YPZ7r1b+BhZawk4i8CiJsp/WOIAddyPsIGGYWHXO2OqYmzdPeSsCw0LwEvhyK6ekrdv+uyb1DWJ8rECD/HB6soYV9nn/Oe/ePocvmFjWvdX7wxezojneIf/I+WNpe8k4i2k9zbQzDD35ewS3QqnATwyldGIkwJfEcqYDOd70UhpNAq3gDeZomHpCoED8Hq4RBF7lGvEiCCu9Zd8kBtwzS78/CVE1jrTdliZLKorZjXiDk5Vez5GeSQrBlR03gHs2RVkJGv++dj1cUlrFfX+ca8qv2dRVkH+3fhlS+j1rWo/4j8va6ER4qAHHKT43DE5u9GyuP8vum0WDdJulmxy+EUKDb0kbrXzgX2hvFZnea02RxMw4hc8H4xxjeEU6HTrERdvidSzH2vqt/NgcVnLMGsEzH7/rxOK959qlc7jhiUmD9GeiTUV1j2rs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6087.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4d6+yEiw2dFiePmtLJRkaxKYZZ8DqUpfjHttFuKiRLH1Gw3ULqnNPVcFoAMg?=
 =?us-ascii?Q?E3kG0VzqQxMsugN7eGj+wNzEcYlFol9nuk6APXCn2TuXZDkBDBHtpJgbXy3r?=
 =?us-ascii?Q?Rt8D4op2vGamuSuc6JS2pFer0/f+fmhlzK9TyjMBrrxYPl0x7iOPSuHXpFBb?=
 =?us-ascii?Q?q219w8tU7OwZjht4AVnPJuuT6g9tzeZnDi4nlR/+GIc1YCXN5oUi1Jfa+P0v?=
 =?us-ascii?Q?kN0h3u/1YQOKoCLQezfn0zr1zr6tUJVrL6cIrHZ45r3yfDwqP/uwyM3K0w3x?=
 =?us-ascii?Q?iGTk4dYGZLI4ew0LRrEj7WuJKiVk3VxYb+/adSuJwkU1cYepSJD8J5WRVB/D?=
 =?us-ascii?Q?nIe9UacY2z98i91kGs9WKVr4MwAxcgqqGIJ1jN17Igpqz7ZBLPt2IHbsoq8F?=
 =?us-ascii?Q?bAbVaIbiS4s4Tfnk0l17NwujGFyZKUZ5aCxgbmpWq0/tsfv4hZmhoyTNuO4A?=
 =?us-ascii?Q?XR4nZSiD6oBhkhHB4vqpIifBbq+WgC2Ei8Uej3Sh7USB0fubkJDCZObePSTp?=
 =?us-ascii?Q?eT7KYL6R3DTjwzm5iJw3/zpmNn8VPFehypuh90kAgpVgACKX6mxudMhiqez/?=
 =?us-ascii?Q?Obb58hoP/pl/s31K71Ih2WqFeiDWkHZ4gxNAQhohU3cjQGAIy8GsyBdXO7i/?=
 =?us-ascii?Q?e497nAW88jmWBr4MRyvB9qMcZM1Lcpv+aFedNabrZf31IR+rMs5K53puHXA+?=
 =?us-ascii?Q?yaxTbMxbX2SbscRcgimE4k/NZ9M+ZevJY7UWRndNrIA+oBPbRRPUSLiuUvsu?=
 =?us-ascii?Q?TYKuQW045LwmwqNNnfAGupBqt7lW3dm6U0WjvLi/ofkFPa0wWdwMmrJKTGOB?=
 =?us-ascii?Q?E1KNaASqRC3+R0BxqJE2brIA71F/j1ZfWZpsU1dYycL+mzJtfjPNL6yxGSPV?=
 =?us-ascii?Q?T+kc6O4AJ3Ny+NQd92nTOYAVSq5K8Ck6C1IpYjvqukJqC55NpQpCtTlW+KJD?=
 =?us-ascii?Q?kD3QBiX8FDQf96lKw79t0bEnWwVC5vxLJcXI9+9ODxRLmZdxkGbjSdX/+/O9?=
 =?us-ascii?Q?RnUpc5KwbkmuCh7IswRa8mF1eAhMBeqeeXvcR11IUzHfbcZctiy+gUqIWTXp?=
 =?us-ascii?Q?us5qR6lmXgep4N5VioL2wxPXfDpGzLZmAfeNOEdii6DTqR8adyQr86oJjRel?=
 =?us-ascii?Q?hB9tcMmOvMQzPt9js8z75uQ4mvkbjRDlzNwwy2gqX0E6z6tTMF/Et0zdI/r1?=
 =?us-ascii?Q?R2n7Wb5ue8XQnz5PDl5xkQxMJ0TaVrx7sNo3UkMUZXYho+ErwCeWUr71vD1o?=
 =?us-ascii?Q?YFwGzLY9qb0ckZwmLq2buCjOTv8hSY+HBO3+oM22k4dwNcDarBrIY2FytZ5M?=
 =?us-ascii?Q?LWP9zW4rZf6TcS7B+8uCdCioxhDsrMwoTgQeuzX0Wy6SR8iNBAHJ5C1OOhS2?=
 =?us-ascii?Q?MkeMciNFdWB7vTTNIKi38IRL6nzWSOjSYszWY6na+jHfFEbL7of/z/NEuOkE?=
 =?us-ascii?Q?RqsggszNuUv2jFzCou9dcPZbw5MwZhYQbUt4do5MUH8h7KMuDXU2IBSIsXjh?=
 =?us-ascii?Q?4C08eor9hewZTA01TCkHzIcgS42+WKoLd930TFbs3SCmPRhfC3dXF+CTOPwu?=
 =?us-ascii?Q?A/QJFHL2qSeybVUZU6EJ0l8wGaKeYpssZkWu/zZH8EWtLOOqx4ZtnV0U/p0e?=
 =?us-ascii?Q?zXyefygd3NnZ+D9TgloqUFG8qf8l2c7sechylL9K9mYBG/QqsI2oaHCQrsWW?=
 =?us-ascii?Q?0xYb3rbrK4xDdPtlR27Y0cXtwCns5WB01gsSMgv0O6rPLX2H8f8qBgacwORk?=
 =?us-ascii?Q?GJ/SWdL94A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90a1c17-c341-4580-1d5e-08de79404b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 16:16:57.7994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nds+zRN3zJsC+YPKyIcgfsh+6IY61DLviJLFagvduFokqR/l9xXz5JGBtJiNrEE1xOTS7YXFhdS81rsY3u70Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
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
> From: Kevin Traynor <ktraynor@redhat.com>
> Sent: Thursday, February 19, 2026 4:39 PM
> To: dev@dpdk.org
> Cc: NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>;
> david.marchand@redhat.com; Dariusz Sosnowski <dsosnowski@nvidia.com>;
> Slava Ovsiienko <viacheslavo@nvidia.com>; hkalra@marvell.com; Kevin
> Traynor <ktraynor@redhat.com>; stable@dpdk.org
> Subject: [PATCH v4 3/3] net/mlx5: check devx disconnect/error interrupt e=
vents
>=20
> A busy-loop may occur when there are disconnect/error events such as
> EPOLLERR, EPOLLHUP or EPOLLRDHUP on Linux for the devx interrupt fd.
>=20
> This may happen if the interrupt fd is deleted, if the device is unbound =
from
> mlx5_core kernel driver or if the device is removed by the mlx5 kernel dr=
iver as
> part of LAG setup.
>=20
> As the interrupt is not removed or condition reset, it causes an interrup=
t
> processing busy-loop, which leads to the dpdk-intr thread going to 100% C=
PU.
>=20
> e.g.
> epoll_wait
>    (6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}], 8, -=
1) =3D 1
> read(28, 0x7f1f5c7fc2f0, 40)
>    =3D -1 EAGAIN (Resource temporarily unavailable) epoll_wait
>    (6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}], 8, -=
1) =3D 1
> read(28, 0x7f1f5c7fc2f0, 40)
>    =3D -1 EAGAIN (Resource temporarily unavailable)
>=20
> In order to prevent a busy-loop use the eal API rte_intr_active_events() =
to get
> the interrupt events and check for disconnect/error.
>=20
> If there is a disconnect/error event, unregister the devx callback.
>=20
> Bugzilla ID: 1873
> Fixes: f15db67df09c ("net/mlx5: accelerate DV flow counter query")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
