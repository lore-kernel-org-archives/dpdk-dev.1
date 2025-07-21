Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360BC87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 06:34:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1E7940281;
	Mon, 21 Jul 2025 08:34:35 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by mails.dpdk.org (Postfix) with ESMTP id 9E37B4026D
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:34:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtytHd1U/2BwedP55+7zifMMMvVZ8hD3o9Ae7uCp8Qr/DENQBcnPTEaPZTsaMWRmoFFMXONNiWYz7UUY8KDLTKo21aMt7Nt1QotpF7I+oGyGdmYVX7Dwpl8F5eQoLBzn+xzSpePiuKVjZrIYgnG45sgGxy4dlX1qrmigywYyyd1gxR8ND0bZMitK/xJB2kkH7Vk1RuiInHO/uAdrTlDJtnmvML28L/e0bfQVBixZSXfsEXb7FX0IcT5bkPq9qW7UKvcRrVrVph6Cxbpp59TL2OmeiH412pn1WJSwd0n8aGfuiZOvVmhqE1kUaHbKhrDUUYPnQSjs/05TosQuo2PC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYdZZ72h3bd9KMqifY5A/QFwzwi7J2bqNnmCwzmEPSw=;
 b=RvabIb32GSyQBtQM23nLgZAVM9n/3OhrOjRB1I3BHqTn/kEHBRUBP4/ojxv5uE65zactHESs+MSWW6F4D5MEJ3lO66CWmdtm/i5q752HlHcezWi2+2moGRep/wIIUGWXO6x116TKRhFYemcSm1LJQrdBt6yios6F40UsN0pPSRe3oVEEmri1CHZOavdqbpYmMKpJhjwh6yoJVCNyQc9HWSEviIlGdE/wYbq9N111/oSIYIkofRYhCHT+NgLqAI4uFdDL189L+TSOaWgdAiPlviymb+2PFE5SySj7DXVPqaPZisqsn/zbA7VZ4U4fZPe4Xo4eEaZ1tXovQC3xvJj3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYdZZ72h3bd9KMqifY5A/QFwzwi7J2bqNnmCwzmEPSw=;
 b=dSzLMGo3pLbbDHqtB7vlHS7mnpQr+kLunUA5fJUxR7H3u6aSqr0MyW5c2STP2RwppfuxpewWs8pqpljCTaVeHrybFViBD7teJ5XB5PWu2wgnrIXEc4Be2RaiOgHlhAc3vhq+u/R3TS61z+kuEeP5kk3jHLFlZ1GPcQcT+GOnxjKCUSoiC/8/zYdYIL+zDv5k+hj0oDRWOkCcVrav5YCegmCQW0Epq90vPDdw10g+UHe8FGxufXd1AtttY+KFTEfrBJoXHq0XsI9PUvljFVQLi2eC5j0iiiWC9LE8DEQs6r7ghsThY+6BrFJSMFHEXpyWJVfDyme6G+PZcLDkFW9YPA==
Received: from PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 06:34:31 +0000
Received: from PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::b57a:fddc:bf51:df98]) by PH7PR12MB6905.namprd12.prod.outlook.com
 ([fe80::b57a:fddc:bf51:df98%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 06:34:30 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH] net/mlx5: document IP fragment matching limitations
Thread-Topic: [PATCH] net/mlx5: document IP fragment matching limitations
Thread-Index: AQHb99pyux3xpBpcXkeqowvCX8nY9bQ8IprA
Date: Mon, 21 Jul 2025 06:34:30 +0000
Message-ID: <PH7PR12MB6905B257D633E5E0C07286B8D05DA@PH7PR12MB6905.namprd12.prod.outlook.com>
References: <20250718115156.1220403-1-dsosnowski@nvidia.com>
In-Reply-To: <20250718115156.1220403-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: stephen@networkplumber.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6905:EE_|CYYPR12MB8939:EE_
x-ms-office365-filtering-correlation-id: 22516429-fc23-43fc-ed5a-08ddc820a627
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bamJ929e5yb2h13yVyl3vnlBY6RaXpRiG1LodQgS0qHRjNV445hCBsZhMvPy?=
 =?us-ascii?Q?o/Lx4K6AhtL5tVWoClclp0jdDmmSWa9fQcWgKnsAUOEqVVzp4X45U5DzOIKT?=
 =?us-ascii?Q?KU/f0NMhfmtsEqA73qzoy5PHDH0aOvuPHWimQR+4QDuBlL7UEuD24Gd3LqOn?=
 =?us-ascii?Q?Tpq0mCs+cinO2sGRk2WzJOqnWTqBNo71/qfs0Ffcj2V5mlFyhNoc2vnusnBD?=
 =?us-ascii?Q?vFroQwRDqAFaSlEl6p1jXtBHU5wQPOFggcIGiYGfV+5ojdOL2oIw7sHJKs/n?=
 =?us-ascii?Q?q5J4jAEv5Tf/9dAF4h4EvPJhnLHXteG8s5pcY5AMDHhdc8MoriwKKRbwryv/?=
 =?us-ascii?Q?mGEjQpYDY5jIUOr3b7HPIMCLsJ80K2kE65g1cgKwgCRSo4K6ktLVvoo5HBC+?=
 =?us-ascii?Q?SKHBq7vhOBIVvHXa1XBrO/lQ6YaOSNukoZ++YFoQqrlg54uqo6Qz6OzQQUsu?=
 =?us-ascii?Q?yeVDSnxV1/ClNylpdEisIX3nU/A0tWwqxx6wY8LsWJlDVkLX2bo22WaOarlK?=
 =?us-ascii?Q?a/wc8jmZMA355FaC79Vsoj3wFCUklSuzECorw3l2ng6ZWvaP6IrCyJIksf2D?=
 =?us-ascii?Q?+yUy1eDqCsxa/zsesfjxQ/NoacEKTMqRsy8Qgqrk2DX33Yp89YM0QWeSr1yK?=
 =?us-ascii?Q?zlQRiPVfvxBw6ICeIspHwt2wltHsZW196NLj6OXlYT9dkZlfjHm7/yNWJAYs?=
 =?us-ascii?Q?pHsqrEvPyrVeQkE+GJgmpRguEALe2pbyDgvjT4UcGr+tk0FjvZQs8Kuv+Fvm?=
 =?us-ascii?Q?VDxpMz7FRyiXfv6RASPy7+WsHCCaSg6dDKQvVReoa2dT5S5wKexYvQiYq0la?=
 =?us-ascii?Q?h/gmTn5fFn8CZloWcvdgI+0oUP5XBU6bxYz0KVwyfP1s0Yvm+NukK5j5l++G?=
 =?us-ascii?Q?E01zb/1+iXEikTEAwVOLva8mlTMpg6KfjbNx+e+N/ksHtovWHBJQRkqJGryw?=
 =?us-ascii?Q?RnMS7Ia1DFn0IaNxaJupWvjHkCzMLt37cvPlT4ER37V6kcyRlGwtCag4k2X6?=
 =?us-ascii?Q?hIVF25lfraeCEP3QQa3W3WMYKMJQTBj+cSY80aP5Z0O0ln4hE8pQmenIQVvp?=
 =?us-ascii?Q?mpXK+Ab7QiidHxxCRAR2YS8SOLFojpF/ecCjrvfRODKVMP9V1er6jMwzS7n5?=
 =?us-ascii?Q?MnVEFZcwRpvB/jhlyuvUGYJhRkHr74XQ4Z5WROBlQIo0SsFLkLd4Pk4dnIbW?=
 =?us-ascii?Q?LR3iXT9nH3p/Pd4YR1nFItxOfLJEyeeIqT45NtUXXCmQsAmAmeHVYh9HjWXz?=
 =?us-ascii?Q?2OZAzkmwkyFI+jDrhp7VcYer0ky9rQJd2DL7/BRoH+C5iKK4fu4WfTEgZuiL?=
 =?us-ascii?Q?jIURefPsgr7mhOCCZC/rR+9k0aWm3eU+SmzGKXAqx+uvfzyXb6pFhcqMNrZl?=
 =?us-ascii?Q?ULPcCwMcO/3R89xw6lTfM6PfbwAHrmsjxYsBeZGO19DfQli0GqVTDy58R9HD?=
 =?us-ascii?Q?MixtBHnJAOECY67GSABeJc15LWh0e9itIAJjYpZRXBkL305PIXIa+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6905.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UP3feFQjXlKKBhhvLdQ5H+GvOAmuSWQmzq43iIhBOltkH6jlF3zYubjsflql?=
 =?us-ascii?Q?ikpjKf6pDVIUVsmNYSifS86u5FkZzPirgHmY6/Cv4B3ZOwyBnWko0ND2aPxU?=
 =?us-ascii?Q?vxZnmb5LadPauQeGG1S4Nzy505GUxVU05vmYm0jHquGIFyt7nxuTiPnh0OBC?=
 =?us-ascii?Q?cnuZHq0SiWyHvZZBIDT0vy/XmKTg5nwg0RpW1DCiSxQSWMGQ3yvsw3lJDIYk?=
 =?us-ascii?Q?5Ks7wiDHzg8Kh5occupDk1zu82SBKu7YKh7lntx3HKpFoPFEWKScqdMtkCsa?=
 =?us-ascii?Q?oeFrJKTdnfNnsOsm3bC8BgB+Hb5ubRZsPdITuj1IDHeXanE4Qk0nkVZeDBxb?=
 =?us-ascii?Q?VlIZSJLPKYlWdLCxKZhITT0IgqKTtVFyUamwgd4DlDr6Olx/WQt93Qf9lXfy?=
 =?us-ascii?Q?Bmi8L0rtNNboK4QkB6gzijjAwvQLwwn6tMizSxSN/EY+L9shnrJjnB2t6Wt0?=
 =?us-ascii?Q?xZTK1Q6gGhRYhDJ2uC8k+H6wpC0xzZe300CpxxMuqHm4HCQef6GYfu7vX2rD?=
 =?us-ascii?Q?eCjyQ4zv/VZ9O6vSfMiWZQf+SnbSHQ0anutRReJOK7LW9CwGTujJ3hCE51QJ?=
 =?us-ascii?Q?b6oVm88nNWsbuzkf6p9SiOHHlI5rseRSmkP5DBMD+HCDnk/ck4MR41b/PgBA?=
 =?us-ascii?Q?u+s/rzDXfjufx2bY9scATlr70O//rBNHLqOaJX6ZehrbmCqsIdNTEXxQTjnj?=
 =?us-ascii?Q?1BPRZMaB9t+wQiMJ8LEbTzH3lELzByq8vgIDMItKehjkhGRA52cCk8XnqewS?=
 =?us-ascii?Q?b+ESh9xd/4OmrVVCTZY6if+77i6o3jNFMH/3gS21lsq7ye+FQjzxVxrOXIw/?=
 =?us-ascii?Q?L8QaUWeUDVEYqcGSkNnV/gsqjExbGfnQowGe2srXiTobGPTiN0eNVmL2QFT+?=
 =?us-ascii?Q?OtvVIyoRRze9VHvA7in8LaFK29fe8gZjMoNvQuXMhQtkl3pTLRd1His80SrI?=
 =?us-ascii?Q?9HN6apoUBwggZgNFxqcFkGWgp6IzEXJHfIHMcDYjfuuGs/zQBg5ouRyyIKGO?=
 =?us-ascii?Q?ZtqA/dVNC4Ya+dyBUOx7VHJgzI45rQo4T5FRrfThnaC/p0d/Tkz0IuasSVzq?=
 =?us-ascii?Q?w/y/XPFuwwqb2IDXrQDA1oiCECUl8C2BcU1t6BwEejtrMFqLFZb0MhJoLDjs?=
 =?us-ascii?Q?cRMYPWFfYGUIL7pxGCZp8HG5e/AviGZkZV2TlO3nBViGpGKN1C0asEb9vn/S?=
 =?us-ascii?Q?6Qszd6XxEsEwU4I0Og1TrV45Cum8NZHSj2qbWoFA5chQ01mRfOtbt6Z70Lq9?=
 =?us-ascii?Q?AYx4a5o9kjhWzcdo/K+ACnZma6tILLRwS9WGCGRf0TmlwIntAyiDsVXJz/2V?=
 =?us-ascii?Q?OsVUIw3WAYIuOD28O9RK4xINbC9OMuAx2xdZQmmhVsaqdrN+mAkS8OJ+YykO?=
 =?us-ascii?Q?qhI/gu9hUmK8ZrammXVU36TpjAjF4AsaJLrwaZMkHQnPJEdBgncQx1lQLNml?=
 =?us-ascii?Q?5M1/oaHRmy2uVUz7lMt8QduMEtr8gQIYBEXq4VZuh2/apEk1IDDRI4ZS1YXT?=
 =?us-ascii?Q?5JEt/jnUrpt+hb+QxefPiXlJIx77hjEmuSXGwhdrrt75BCD0/Flya5CQ/Vv4?=
 =?us-ascii?Q?Mg0FO9CJeGpZb86pUaw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6905.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22516429-fc23-43fc-ed5a-08ddc820a627
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 06:34:30.8276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10+o4hxSSYNz5vpFmpQhKA1p0B1O56DIxRSmVGOSAnZKJq09Ces7jxRdB2FNLlCrHZ7TApfzurDL23giCwEyyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939
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

Hi,
@Stephen Hemminger, we don't know other NICs behavior. If all NICs behave t=
he same, maybe the limitation can be considered to move to the common part.

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Friday, July 18, 2025 7:52 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org; NBU-Contact-Thomas Monjalon (EXTERNAL)
> <thomas@monjalon.net>; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH] net/mlx5: document IP fragment matching limitations
>=20
> NVIDIA NICs do not support matching on packet headers appearing after IP
> header if the received packet is an IP fragment.
> This patch updates the relevant documentation.
>=20
> Bugzilla ID: 1417
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
> Depends-on: series-35735 ("rework mlx5 guide")
>=20
> FYI - I added Bugzilla ticket ID just for reference.
> Patch does not resolve the issue, just adds missing documentation for
> existing limitation.
>=20
>  doc/guides/nics/mlx5.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst index
> f29408eace..f58fea106a 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -3305,6 +3305,13 @@ Limitations
>=20
>  #. IP-in-IP is not supported with :ref:`HW steering <mlx5_hws>`.
>=20
> +#. Matching on packet headers appearing after an IP header is not
> supported
> +   if that packet is an IP fragment:
> +
> +   - For example: If a flow rule with pattern matching on L4 header
> contents is created,
> +     and the first IP fragment is received,
> +     then this IP fragment will miss on that flow rule.
> +
>=20
>  .. _mlx5_nat64:
>=20
> --
> 2.39.5


Acked-by: Bing Zhao <bingz@nvidia.com>

Thanks

