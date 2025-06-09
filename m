Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D7DC61DB2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 09:23:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73FBF40661;
	Mon,  9 Jun 2025 11:23:23 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by mails.dpdk.org (Postfix) with ESMTP id 24FCC40658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 11:23:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vu2Y3uCJi+ppnJcM2x3CqP3X/kHfQh+Yy6zcRBgORqHm2gcWBUFhFJGv+4zINUJ5tdVS4aeXAsMmOIXl6d+rAe5iyXgJhJt4Swa/ovGQu9tajKajftaaN91hr9PgWpqOX/CFYB+Tx/nzpqj4QPZ8NRkSB9xmGSvZa/W5n8A4uAa0ntBFaHYp8MYuz/k288A/5QBgBwcreA8PEkmrl+BVTMA00fzk4OGdzq0IxulfNM4kakez+sjxWw5Ou4W4db3tFdHiWO+LHmDZRlKiAvluYT50dEpspanj/S9qSwF2TzUE302R1HZt7wATw3NXaSo9vlseZMrGclLrE/A2q5yLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U14SWvfYoWE+euxsda7+ykxolVZSGBhOQJ0sGS+k3Js=;
 b=r/0nR5eE95GQZ5PzxIy3kxBhnLysfGhxDdVud5yEkV8NMT3Le0vPCSLltOlrf2QVW55Y4So7AGTjsCu6I+FxnfTzMk7efDWy0yQClW08b3ZeUEUAj4P+t9Awa98XtRtukyRCN5GH7W8MayDIndrqJrRvo+PiJp8D5QQ4axKaghQqLyq+Ous0LhFCrw45GFtDFKcxh4Dk2abwcO10TD8RCs5L+tDEf+ipOq6F8vIlogPgTVrfitZhgGacnaMbLPmqb5r6W2kTHd+C5ylhHrpZd7zALGUbu3/BN0MmlF7i8NXHmL7ZDDLy7xXMwDIdPx/Y6rmDuma+KDGBEB5dmsX8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U14SWvfYoWE+euxsda7+ykxolVZSGBhOQJ0sGS+k3Js=;
 b=siRCfXycZYFeWae85zgD56mwj5yYgU5KeVQYmdUEY48FuyltjrR9G6H5tc0s9pnGiT7K4On2ua4CyOvW1udMoy54oY7wvc+Dnqc7G6oJCitPPG4NQHBU6ri3LH0JiL3Qq3TSXrOIRTY4Sj3ZFg+Xa/UpKNyhlBav4nLrPceYRAM=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 09:23:19 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 09:23:19 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [RFC] doc: change recommendation for installation of tools on
 Fedora
Thread-Topic: [RFC] doc: change recommendation for installation of tools on
 Fedora
Thread-Index: AQHb2OsN6vfrlyJL6UqPG6LxoIR5ELP6jhEA
Date: Mon, 9 Jun 2025 09:23:19 +0000
Message-ID: <PH7PR12MB8596DCDF0F61E3A73CEDD5A2826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250609030306.17171-1-stephen@networkplumber.org>
In-Reply-To: <20250609030306.17171-1-stephen@networkplumber.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e322020a-f11e-4165-becb-bf6abf302732;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-09T09:22:07Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|IA0PR12MB8301:EE_
x-ms-office365-filtering-correlation-id: 5abf5798-0872-4c96-0c80-08dda73745c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?unCYPByESIWw3RwcpUan8QedKmdSMLK7fT4lmlbQ2PuXBPGZX9THuYmyRkCa?=
 =?us-ascii?Q?hZve//oejHbK4x4e+8NUyY6/0B/0mJRU8r4UDiOKey+zF4G5zMG71E3usNBS?=
 =?us-ascii?Q?kxVBzzQ4DAhaLrYBRHS6c8OvpzFZo0kaygNQ2VL/K+mU1baMfQkxci/vrNaW?=
 =?us-ascii?Q?cvJ3g8m+r9QUhTGsxooLgQGz8e0tjPLkYJZ8t5fGhqkU2IO3V9sIUqokA7tZ?=
 =?us-ascii?Q?abFHBImIIXohOfmdyUxEt1VjGEARwCjfLlD6/QaYeKsvm8gIA6SOadi0DV/v?=
 =?us-ascii?Q?fvu069DKpGyU78WKU4tjbtIdqtEG3UzSdcwR7UKmAk0br5oNM6Y1AXNifln6?=
 =?us-ascii?Q?MPXjLqSi3lsXCHynP5PwARzqJ/NHzQNwMzOK7rNZEvqSP0Dq6aiJwNlC0gH6?=
 =?us-ascii?Q?xVROicSFA5S9oiUOHRSQLfGHgzbE+P9e0xmd98wXmKqpr3Iohc40cXJ7uakt?=
 =?us-ascii?Q?kWc/eFq5Vp6beKILaKZ+A/IFBwQ9fZt+pOg+kUe6zm1gbQYLBQXEjM0hYCP1?=
 =?us-ascii?Q?7E+x+aR4nttsUgO6D5BCMWvIwi+MMO5xCvYuHNyRtQMjs4jXkPlyhqBFokm6?=
 =?us-ascii?Q?iZOjLNbW66p077rhJnVwBPm3QkcPMqdGIWslOK88ac819antfy0/hQ/6+rMd?=
 =?us-ascii?Q?Q5T6z1jgZcqljzW/5b2QumOpLQdPRjpTacAEpd9O3a4LDnOIL8UIlFzKGDLP?=
 =?us-ascii?Q?J8rBfPQQhjouU/XAq2MeyUZ9L5pIaOqcBa3e6QYOGYxaUz9/eeCJFN0GLiLp?=
 =?us-ascii?Q?hRf7mVb0Yv0UQt6YCi3x9DayJAG//bbx1X/8U+gxWYQwWkeoFhocK2AM/Tpz?=
 =?us-ascii?Q?a9wBassflBwWOmhwgMx3dmFr4VZ5G/WxyCQFkeQ54s/c0VICJLQIYnwQ+RdS?=
 =?us-ascii?Q?KyJ7rNMpNhy1AUpbiH8tMk9DAqLvGQEWwGT1fnzzPpAG+ciLcVbALB21VufN?=
 =?us-ascii?Q?H1ih8+urxpqnbOBKiZhe81LWHVh8NtD7vvwgHuieDNbDR4Hsg3Xwit50/HrF?=
 =?us-ascii?Q?1ZYObneefHGU11diGn39wsfbPnKTRespDJ4XqKIvgInu/7MybKeYgbtSYvV4?=
 =?us-ascii?Q?grr/Viu7hUVWXgV3e81lzfFGUHZlyLBr4rz1tOEBUkn0ibNwq3/J3sJzTDIC?=
 =?us-ascii?Q?Letk0GaS1M82XW8HWswZPV+4h8S3JTV6VUHfrdz90Wuu8NjINhak5Av0NKwg?=
 =?us-ascii?Q?ZoEbn2J2tldniYPilt7NJSVs67W17blXMvQSQ2aMQJQGHBdevCqz5Pe5Odd7?=
 =?us-ascii?Q?ZdzKn92qeBpa6zNN3W+85R3goHzjzAtR7+QlMSBZcZGOSErIZYY1CsUFO0KW?=
 =?us-ascii?Q?KFwaZdbhltXJJSdQchDM3oHSh2/sPeXeaeoO5rP9dBwo/z5zF48Bak6Ekj42?=
 =?us-ascii?Q?Fvh2lODqYUKUkeojkJsuK5NdSSR87c51GqUQAdC1Nk2CDys3oQHkmTfWPcv0?=
 =?us-ascii?Q?V7gzi6PEXZo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TmIODd6hVjdPdWpM09mEms51AaFM0Vz2t7Mj9VyT6hqwMYgrWTSBhkM4dy4+?=
 =?us-ascii?Q?O1C+YByw9CWvqpOpeDhvbw0eBpyTZuhQsdqQTTBSojNDfeaMhPHJ0Vm+yhx1?=
 =?us-ascii?Q?OKlt3CyGkxMjyY05RE17RsefC0Jlca19PohuWPOLpKJ9Z3ZIx6qb+4BR5GeZ?=
 =?us-ascii?Q?i73Nz9MNDnTK6WzSMThxvi/3CMmMhiU0ZoC25eEJP1FuWB6fETISKLj+5Dvl?=
 =?us-ascii?Q?BwotI3946NLgFwiDGPftKH2MHKQSjYlEtFE8cgOdoOrREmyYmyc1NjWq8/l2?=
 =?us-ascii?Q?fObpYCXDcEGtqb3pUBpKeJp3PiYU22opl11HixkrWf4r9BNLpq8tnj7qLirS?=
 =?us-ascii?Q?y4ECdL2q+QPrJRtWz/DleCD7B0Ak653mVL4QmrTCrdhdIW0ThHF9Ro77GbEf?=
 =?us-ascii?Q?JVg/WcoVJaxHZtjGnaELpKW+hmNIt9QLxoaD+f6xa6Z6bZ5VFpnCUJlDzZ6R?=
 =?us-ascii?Q?IVgHU8XcXhj3ZvtIx15RPQ9+nJJ7iQOXaRXHe2R/ksetjwEqIyHEgMfLeaSV?=
 =?us-ascii?Q?PunhW5S3twmSjdkMoCcVIa9IOAYuW2JoMIBOOGlGd93mTnQ7D1ZmgPDJGfCx?=
 =?us-ascii?Q?JMn0hxmdUVmsJDO8Gi1+w8Clfx5B64fRucx9HE9v0VnqUyvajjZ/xYYrzQ47?=
 =?us-ascii?Q?nPxAu9tX1RmkvNdYPHMfbOhdIBiYX2hVlosd0tk/BXzn2FyvgvzqQEtvtv/w?=
 =?us-ascii?Q?hLpZeh9hnUl/FKM7hIN/EkNur+QdHpbt7IFSLo4HcE3Qc17TK/d1D/XFP/z3?=
 =?us-ascii?Q?jdKGI7GxTYaxBWA2KuMQapKGeDtfhDGyum1nOnpEpNNuqbY60NVlkHeIoGeR?=
 =?us-ascii?Q?BlnVaBhOQDpYwE4quaWsXaNEfF6DvszZ4G/tu/gTwzLFvVomHRWraq9utWO4?=
 =?us-ascii?Q?fvDxqCUDdPksMzQpsjzyZzRKSFmeaLNbi7ap284AIrETEK7zERH1HY3KDH5j?=
 =?us-ascii?Q?vw9ei2JWnfs91EytbOAPr/fnHy/LNgYZb8mW+b3pdQoUBzxmW4yMomn7CE9V?=
 =?us-ascii?Q?+7yF53TyTcjxd3YFdb2SKFft9Z8mlKdsSnQ69i12Qj7sSeJb6ETAKw6sI5VQ?=
 =?us-ascii?Q?Dr0pPbZHAdvPO+hbmvYuj1Je1VP5sZi6E0/tMDYqWdvbedDlzdtvC4s/TkvN?=
 =?us-ascii?Q?IJNbnzpjzGgvTkTVI2W70xRxFmlyYHIj11O0tXsR2CGCPJKc+U7ixja1riXM?=
 =?us-ascii?Q?uw8C00huTdh5Gx/gr+XIIc+u0WxuC9klm4irJ1s1Wd3qX2yq3mYx37gO1okJ?=
 =?us-ascii?Q?m4qXVjwiMnPJOyq7P1WdIMJiX4RFCXVCNkbhUtzGPekrOJABmTNvUxLP1kW/?=
 =?us-ascii?Q?ZF/nqTJcvYgG/f0vvXaSXAR9qVhu5hgXRcgyz6taW7am3UlUh5zPdB86XmdS?=
 =?us-ascii?Q?k7usIeEdk6mNlChthe4lOWiO1d5zumwUnJyjOVClyz7PSxlb12ZY0JCnRSqC?=
 =?us-ascii?Q?hsdVMg1gwaDB+qbgPQyhSYJC9IddJ+SsjS7IHukMZLl8/H7wdesjjTnJ0iiA?=
 =?us-ascii?Q?wio25gr1/IgWrva+WWik/RC2+FDdxAo69orm53dJ4GgIB/ljywMjyFzFIjXA?=
 =?us-ascii?Q?R7k6n6LNY4cyLJ+oYUI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abf5798-0872-4c96-0c80-08dda73745c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 09:23:19.1165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gcww+NM3scvNjpSq4Yd9AbGodnaA95iGR/l5Cu2sTlF1IVkdGlKQCLvfP9T6xIlJoDIAAf1gLOwn10/ykJzFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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

[Public]

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, June 9, 2025 8:33 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [RFC] doc: change recommendation for installation of tools on Fe=
dora
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> The syntax changed with Fedora 41 and the old command is now:
> $ sudo dnf group install development-tools
>
> Not sure what is on RHEL 9 or later.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/howto/af_xdp_dp.rst    | 2 +-
>  doc/guides/linux_gsg/sys_reqs.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/guides/howto/af_xdp_dp.rst b/doc/guides/howto/af_xdp_dp.=
rst index
> 9da68e0bfa..b3681af2f7 100644
> --- a/doc/guides/howto/af_xdp_dp.rst
> +++ b/doc/guides/howto/af_xdp_dp.rst
> @@ -159,7 +159,7 @@ Build a DPDK container image (using Docker)
>            python3-pyelftools \
>            python38 \
>            iproute
> -      RUN dnf groupinstall -y 'Development Tools'
> +      RUN dnf group install -y development-tools
>
>        # Create DPDK dir and copy over sources
>        # Create DPDK dir and copy over sources diff --git
> a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
> index 4c9d0c55c0..c53e79f7d5 100644
> --- a/doc/guides/linux_gsg/sys_reqs.rst
> +++ b/doc/guides/linux_gsg/sys_reqs.rst
> @@ -31,7 +31,7 @@ Compilation of the DPDK
>      including standard atomics, for example: GCC (version 5.0+) or Clang=
 (version
> 3.6+),
>      and ``pkg-config`` or ``pkgconf`` to be used when building end-user =
binaries
> against DPDK.
>
> -    * For RHEL/Fedora systems these can be installed using ``dnf groupin=
stall
> "Development Tools"``
> +    * For RHEL/Fedora systems these can be installed using ``dnf group
> + install development-tools``

Reviewed-by: vipin.varghese@amd.com
https://discussion.fedoraproject.org/t/unable-to-find-development-tools-in-=
fedora-41/135154


>      * For Ubuntu/Debian systems these can be installed using ``apt insta=
ll build-
> essential``
>      * For Alpine Linux, ``apk add alpine-sdk bsd-compat-headers``
>
> --
> 2.47.2

