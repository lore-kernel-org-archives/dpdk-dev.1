Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A7EC28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:30:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1FEA40261;
	Tue, 11 Mar 2025 08:30:52 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by mails.dpdk.org (Postfix) with ESMTP id 07BED400D7;
 Tue, 11 Mar 2025 08:30:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMg/QtTBuIz+w4u23Jh+BUgdT4fRr7FtNU4hmHPMAqan5rHTytMfnqShbS9S4lmdmyWrbKOni3uPwiH2ncF+0rTnXWvuqSWP1gyg+ovScHICMUxNHRKcqeGqEx9A/IjMzhDgWXuu8KifLxEskESijcLDJLdsEvVllCcsS5NFTJl/2uHwqyi5XYKWJ9xbW1P/nz4UXyAbWBbxad6yBRpkCWivfTZWnp86t8dBQ7lZIsaVE3M+PN97j2No4gXEkjqy5zxwqLjKH+ubj+6uP1rIa+fy9SAOyO6kyh7pfEAO9anxdbXvqKLXYoYpiWlfsc9WSN2noMnx8BHqD62+/G2ypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rEw5IDPglbTI0dYdwD1Euc9FFTpyFU5xWzanYEaA3Q=;
 b=A50Kja3yZc78UKKuo81zQ+/0Qy26gIoOh/z70hceCoSYka5Zf2u3BBUZW5fsFWYrfC/WwnSI8pIv0XLC1POA8GY6ETaltlhBD7C18VUkgQSnITUMTgrs6BlzQg1OCRMAErSu+HQSlKqp28ygziWQoX6uK5tq/rNluJ0h3ORC1j5EXD2aFWwLMbCiQtfhl5esRDf8gtwl3ycMXp4nY5nkSzp8nGrNh+8Bj6IpzLx7SC6bvBM+/DPVAHEKzcLDxqf6enFrvansWjQ3O4Px/xAwoAq7dcD0w398VDFAc2eW4eRJ8BuY1GF92yb/53YhopBwF4IbxUtJrZ3V8PvemnhzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rEw5IDPglbTI0dYdwD1Euc9FFTpyFU5xWzanYEaA3Q=;
 b=TcXyHqNeY7bsBpHyxn4zjbTfhWiIbNXN18cg+U9n0GfDDfq7/pD/jAAVRsouRL3hgZtW3atPIBev5wAcZ4syZsiVI5lxJ/hxYu+IRzMDBir3UgCa+xyZH0xh8ptCxV1QcNzJ8cbQ+ZOvEJz/1+0PdrW4BSlhAqLgviUR2FBvg1PMN9QHMVX2pedz6Af7MbLl4H4wVgaVNXUD5dXSTlkjPqMNbV14UQjBODkXLhN8Cr+XO9dLn2md4LiqI0OIw0msBGP9iLcdo68iNH9aHZNJRjavJQMV4gEA33Mr2SJ4E0nBZeqgGYPkiTMY1inbk19OV4JaEEaM4uoOxjXUj1SgjA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:30:48 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:30:48 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix LACP packets handling in isolated mode
Thread-Topic: [PATCH] net/mlx5: fix LACP packets handling in isolated mode
Thread-Index: AQHbiQFVfIU57y1x6UubaEhq0zgRp7NtnN/Y
Date: Tue, 11 Mar 2025 07:30:48 +0000
Message-ID: <CH3PR12MB8460E70287A6E37A71959F29CFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250227102045.89381-1-mkashani@nvidia.com>
In-Reply-To: <20250227102045.89381-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7940:EE_
x-ms-office365-filtering-correlation-id: d9abe93d-1a81-47a6-1cab-08dd606ea4cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?NDvto3Ct9Nwk1nLxZIL9rN5frBerBtxu20vvvKRL4x+XriNofYYJzC/Nyr?=
 =?iso-8859-1?Q?V214u6wMirRzC0iJ2+JJmX//AVEXUQ3HSykXVb2oCrKa/w0EsfP3Ru+PQ0?=
 =?iso-8859-1?Q?pDK0lZtEuuIRYV5SIIKJWaObtnQ3zTCnUJeOI3jQFfoqiQ5kWaLN0MBCiH?=
 =?iso-8859-1?Q?9odXrDdUiAYjY7y/2iY/Z/j9Dq4vr8DWOEwsg1ipPZ4cVBFqXQSf2APCRJ?=
 =?iso-8859-1?Q?7BviSX1qV1gAMzTZuL8ukZHTxq5rneOqL4TouhVSsf16GBHf/RANlZ28dF?=
 =?iso-8859-1?Q?MxINoczERHsRVLBFFpFBdx7BUibnTbQi1nLMEN/Opz/5nVK3Oa89tvWkn5?=
 =?iso-8859-1?Q?m+GhEMaNuCeo5YfnJkecxHsOobwo+RMTBPVU3VIPZmkoGN5jslcT+/LbZH?=
 =?iso-8859-1?Q?O5tP+wI4NcVpQLHYW8R4PmjjgmYhKsLwYsqbzyYzZ8bIu+HtegaBnvkvgV?=
 =?iso-8859-1?Q?F+Q8eQyE1NZMLP+EKPaWJYuDWRNunh6ZZPILV2Z8Vgz+JnpVGE7Ni6CvZK?=
 =?iso-8859-1?Q?ilTjMKbvUzlGCAiSulT+ApSUJ6YPV7J8DMfQC5xsxO4CyQYBUGp1FnN2Vx?=
 =?iso-8859-1?Q?XXHvqOPZl7N2hrrhdqY92Vzn490dfkI+yyMQz6g+buAMPpl08I9Rl/3gDN?=
 =?iso-8859-1?Q?7mMM/U4E5oreNgFDSJFaW12mXEs1ApE/UxtjB6vfh79DFkQQEaWIN3QfBC?=
 =?iso-8859-1?Q?QkalpwkYoFav4Yo2kCz+2lfBwEsvUhzwi07/UnhfsHx45YcwZl/7ZHoszS?=
 =?iso-8859-1?Q?a4w7HmxCn/2xB5VOg5G3zBghfifmMisKS+UGf6HUOUvrB4yssZP1SoUsCD?=
 =?iso-8859-1?Q?vYt4ehj1hkCr+OxRwLKASysdkar+65qqFSwdoNFp5IG5TR+XMcOr0p+L2F?=
 =?iso-8859-1?Q?KrmuemQzS5fNkJRVh64z17VWnF3bKPUVdY/rJ8V6Q84NFP8aCBqxOXGA2L?=
 =?iso-8859-1?Q?1oCGjG8WqodkGPT2QYudelWz1AMl9ItGbdOj2rDUcvs17uesZkSsWqMO+o?=
 =?iso-8859-1?Q?LgVBXi4c2f5tVZrfH2YAa9onB9Ut37CDfJEmOPTY5fTjGnSJRuV+Zamc6j?=
 =?iso-8859-1?Q?8ErM/NsOGkIQW3m+8Gm0+pxUcdDKMzws+hELLRJq63lWVRpzWekKIIs7Cj?=
 =?iso-8859-1?Q?/TlzC46/xJ9BnL6riC+Qr+7Ez+oCdIwlSgjqWHPTL0nAlr+cDHs4WZLovr?=
 =?iso-8859-1?Q?OfvpfNcqvJDVg3/e6MrMgWA7QEvK3aCYJlwudI9hsWBcqcG9ug6IufH4lI?=
 =?iso-8859-1?Q?l86IBZZWk54pBMmbDBhq59hGrnAlLFvt9nm8lTo956rSwwXo+AghERktc/?=
 =?iso-8859-1?Q?cmxhLcHTKahrhUEtUQprk1a6nqgxu0ojqdUnTNz3DB0BvB/89VvzymBbcK?=
 =?iso-8859-1?Q?0yyDWyG8DGEp0LoVqgEUvBrHXf71uRfYxdAGL+5nf8Qv7A+G8CMRCIYx8L?=
 =?iso-8859-1?Q?1Jbv2dS0L9xW+amqnz553IixMlrtc6vXF4IHVxW0CGsEP132uiv1nTS6Ei?=
 =?iso-8859-1?Q?yiwhoFC5vhEhnt3Kv+jD4x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gh+H9FKE+qnGjzA1Ekb8e5yd0swemTSGKjwipeabG90F+NSNUQgrTJMu+B?=
 =?iso-8859-1?Q?aZQB6W1hdSIS8ZMlz35w1YDN7CrBAHsJ3Eq4EuBVhpBlxA3Fsx+WnI9h2Q?=
 =?iso-8859-1?Q?iep14JrGZvhwkGRUxwf32yoQZafofkPjB2xCzvcSeWSosM7G65XRFnkxAy?=
 =?iso-8859-1?Q?TUcHbR/6fwCWQsZv5osQLRYaVcOZRwtt9k8jajtsEQMf74biA0T2bhAGbc?=
 =?iso-8859-1?Q?8DGb2c1zKQ0Or3kts9xgSqwZbSxFAKhmuLeNBtrJQ5kxds5HygFJjoxqcp?=
 =?iso-8859-1?Q?+h13Lvh8ROKlly+1788YY8dsGa7rFUid3RHovNhnk0RxWfirN6koy4jJaw?=
 =?iso-8859-1?Q?9BIvJZrMYQCs3RMqXvj2QuRVm/8YuRj6id3xiJ/MndfMDrenlfo/rA7m6p?=
 =?iso-8859-1?Q?JUJeD9aVkKbexMXhKUgtXfFv8HqpLWpcaFNydXxDtfP3+0g7bYWHIlduwy?=
 =?iso-8859-1?Q?6jxDOS7FmOWAnhwPT7Nbev6xnkQa9MX7Eg2sBT7AcZ5z4swICNDW9EAKmE?=
 =?iso-8859-1?Q?egLmmiOfjVB798OCRRh8hnrDQ6yYxA+riz9yk5wfcIiWXxjtMMAYG8stzJ?=
 =?iso-8859-1?Q?nIv4kq6nJ+4pT8fppzZkuuMo+3RAoUmp+7y/M4whUVNAHVaoUGLTETdmIq?=
 =?iso-8859-1?Q?kLA9zvnYfkb2V/oRCu5j5aT6G/ghO7RWPaOqteZxCl5EAOsZcJk8C8uJ9c?=
 =?iso-8859-1?Q?4qz39F+QQnyxYCBHQL8vKX87MaZ2yPC6o+hxbKcejJdoP9HhrC9ECz4IHO?=
 =?iso-8859-1?Q?DyuUlkuzHFu05AYbBK2GHpJ+z3pW5clb3sr74RTHfsp+I5CWN20pFtiTuV?=
 =?iso-8859-1?Q?s0zbl+y00EuAJrUwzFFdT6UbYRBLmhia0O5yx/9pXY/l45tn2IgDlIqCpg?=
 =?iso-8859-1?Q?vu3gPYssIadWE/er2Ihk3VDsk0Ru5xpiubRad07APfqAWPmSPI1pE7EuXO?=
 =?iso-8859-1?Q?oeQGs30y3rLkytzp6Je7LAUmNxp1qq8yuVUP47FdYjM2zoO8zmVQEZmDKB?=
 =?iso-8859-1?Q?Z3se7GRdTniIwNSQwpJrTJ+yGfhSEt5A6gy3gs2lGbXIAoxy3ZQ68cfGGZ?=
 =?iso-8859-1?Q?pgCgfBLdbMdVJybD4uZoc6hYeqTJW69NAglt4c4qACcyo4BMPSzShwloqd?=
 =?iso-8859-1?Q?T4itqcL9qHB32JAdm+shTN194gasAS5PuRQyMB2RoygiAWIwilaqj9SQx4?=
 =?iso-8859-1?Q?KbhGg3qzkFGf3HHFW0cHVlnawGbQXk03kzH0u8rBCBAHywF9psgQSHcbga?=
 =?iso-8859-1?Q?7LmrtfpzQmb62Cgaaoi8AxZzAVo46VYmwmrV218N1aMiQbE9Z/M724gwHp?=
 =?iso-8859-1?Q?k+mlUZqGvVeVdSTD/H4K5fhgv41pQ4tuKOVe1+NUbDg+lPPMPeBd3XEcn4?=
 =?iso-8859-1?Q?/ouNizpI/5tDF64pMJZxVPRj1DW/kZDFM+LIb9/oSc1IFU7X8q3yYJb1Tk?=
 =?iso-8859-1?Q?I7MHbFtMX0d87427diXmVOFJ3wPs+7nMnjS0HrRkU/ZfNmS8yHxKKOiKc3?=
 =?iso-8859-1?Q?oiuYKSwPXnoaBp/cix9qUXKgtcleBcWumJarue6sphXzoUMlMPFMf/EbRq?=
 =?iso-8859-1?Q?48Mw68N6jn/J4cAlw9n+5IMHokWtmo+g8juGKVXIe8lTQ6jSbkqiPCalKo?=
 =?iso-8859-1?Q?07UyWuSEoVQIA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9abe93d-1a81-47a6-1cab-08dd606ea4cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:30:48.3738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hzd9OMfl2jTPIlxYyXuf2wCB0gfe2efRMYnud3Sx7wzLKHmu4O2+GMwc7qeokNNe+iFWOWW1Z4fdQYRrYAxLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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
Sent: Thursday, February 27, 2025 12:20 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; S=
lava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad=0A=
Subject: [PATCH] net/mlx5: fix LACP packets handling in isolated mode=0A=
=0A=
In HWS(dv_flow_en=3D2) mode, in the routine that enables traffic,  isolated=
=0A=
mode check was before LACP default rules creation as opposed to=0A=
legacy mode handling.=0A=
=0A=
As a result, the LACP default rules were not created in HWS mode=0A=
and LACP packets arrived to testpmd.=0A=
The fix was to create the LACP default rules in isolated mode.=0A=
=0A=
Fixes: 87e4384d2662 ("net/mlx5: fix condition of LACP miss flow")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
