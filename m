Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216C606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=omicronenergy.com header.i=@omicronenergy.com header.a=rsa-sha256 header.s=selector2 header.b=rsocqhME
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 861F8402B2;
	Wed, 25 Nov 2026 13:49:35 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023085.outbound.protection.outlook.com [52.101.72.85])
 by mails.dpdk.org (Postfix) with ESMTPS id 378FB4027A;
 Wed, 25 Nov 2026 13:49:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dttbrnBSyGBzF5xFJfOkfOME/x8pHOHO8qG3P/cDQvafu9XuPxyHXn88ROW1Qj+oAncDgH38o7edybEzIuafwJm0GsuJNi1Vf40Z1M7dCQGjcC7bRN3g6uTFoG7jGr3uj+EDqUqgDQapttsS0JWNjxBdt/CWFIH6QbljM9QchmrIei84D5ozUR3AdVf4HhCoCarRec1rVO1Pvr/J57WEvBjPm1ZRcMkAuP+DfHMdtvt3R4OuG4wwsr1Cns2g0PP9irrd8SJMUK8AzndYjQGg3pQG9ghYk2et+QaaEDYMZNAoa/ZZxDHvmmoU3L1Vtggt+AqmqigLWUmRUVFnXDK3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss3ZLdBLLzEgH6MFy13n4/3kjKYkIeb0UKb94miPWOs=;
 b=VTeczg+VHkfhbadjnah4DxN2Y+ixBgGe5NxQ3G4CJClYiIOTT293Lawe+UDlzLF2RaYN0D8H/x9AuW8YYrKqkv+58JOxNzdxs63k75HALKfq8W0l7pZr8HWa7301PEAdikJoEFU0U18MymXBUkW6v2lx06ESQBCuaJAKLMddczSXcr7pKvagMruGGZIGlZfz90CD5YOdUYz260lHB91F4JS4DeY1CIN2xduOBMdih2ajGbFGrPHVdLp65ekqtcapgLfnTMyv77zHJd6WjtM+D6jA3CWH32FF1hLGC0xdxz6U6JipF0XCORWtRfopHYpNsT5oiupSzvoGVj68eG+HVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=omicronenergy.com; dmarc=pass action=none
 header.from=omicronenergy.com; dkim=pass header.d=omicronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ss3ZLdBLLzEgH6MFy13n4/3kjKYkIeb0UKb94miPWOs=;
 b=rsocqhMENQPDPAYPecz81y5IQAA07xuQI94I6ue+DFoBR4dOnCsnnSNwopDttZ/5otGwZwiz43eMloqgp1NHF94vDavF9MpBDizV7JdA/g5XqnPP7VY45ZNHhjiZEA6H77E/13k3VypI+iJ3xHI9c7+F18v57cR0oJSM/i+elNgcepEEaeuUUZYTYPr46cP/Hj5PfUeEcHVC66HQG5iYe8cecc2Wgq9RUY5GEjt2e8oadF0c0fJ30k9FTAJMa2ojP+BjuLl/Aap3nAQjx8t3xp46cgg9sZxCBBFbc9kfa4GgCtXCccbMx9D4GIbbbdDt+pxGjkNhT04OoYcs9oySMg==
Received: from AS4PR03MB8577.eurprd03.prod.outlook.com (2603:10a6:20b:584::21)
 by AS2PR03MB9537.eurprd03.prod.outlook.com (2603:10a6:20b:59a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 12:49:32 +0000
Received: from AS4PR03MB8577.eurprd03.prod.outlook.com
 ([fe80::bb02:20c8:cb25:5631]) by AS4PR03MB8577.eurprd03.prod.outlook.com
 ([fe80::bb02:20c8:cb25:5631%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 12:49:32 +0000
From: =?Windows-1252?Q?Stefan_L=E4sser?= <stefan.laesser@omicronenergy.com>
To: Changwoo Kang <changwoo.kang@ericsson.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/af_packet: fix drop count error check
Thread-Topic: [PATCH] net/af_packet: fix drop count error check
Thread-Index: AQHdfCfp37xtQzJmYUedXOnNrx/Yv7c+vCgw
Date: Wed, 25 Nov 2026 12:49:32 +0000
Message-ID: <AS4PR03MB85774FBF2B22DD20FC13C51796432@AS4PR03MB8577.eurprd03.prod.outlook.com>
References: <20261124152340.3329809-1-changwoo.kang@ericsson.com>
In-Reply-To: <20261124152340.3329809-1-changwoo.kang@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=omicronenergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR03MB8577:EE_|AS2PR03MB9537:EE_
x-ms-office365-filtering-correlation-id: adaca3fd-7baa-4aba-23c7-08df4af28d6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|10067099003|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|22082099003|18002099003;
x-microsoft-antispam-message-info: m/Rf+4gHTyWCGKbQHwpY/98tdy8d+2z7U1HVEAL+05tqIbVURNvRNT26wgyzkgASaTYwENm1B/LHigpaJgCdphU4ut44o2yxr5xMy5oWZ6mgLZ55vteFbtpJce3W3zEB+DNuLMVWBNnza2i7k4j8xIPdDG/LP7BiRLuAgmH1pw9KtiEnqyxzmuP3Kr/gdIz+2xbKgL73hqxvRDfa9fqJxXPsDXwxgbmWTpEnf7mr5yT5vd7VShZUeCTQMX6mA0lvJunkUSXm/jeT6SBEa3A8tvvyZgXjJPO+9YpQA6BQM2wehPhgpNWCRsdmlaUDu1poDly8ylM8X28Kgzov/3RmvQexveRgKGBMAPJwB0Zlw/h2/+Ju41T/X7d0ER/IKNyvGlf9YoYkQeUccjNxReVBhYqYAPnoGwPO3SZXryQaVXqY6fZr712/w8ItbuLCZQo5FVO6puHKUQE+gmN9pRasTWegdOevtEBOk0mwjPC42A0fJSSwnxyCePzgIm9WY15fizteisgxFXSwezDqrYJBiWKvdorR/UbxrA47xYitIkS1Tt7T0EGm0xKxlvdU0l3Nox0fQp99QrmnE+MvSqd9uBEl54va7d/UZMwJqQU0xB+aVHIYQuN8B5yOKsRmBp7mRu+89wgxvR/HIK0ikDHgwfMNAxjHmEBaEW5gFIsRlnW/YyPYo4ycXeVUaPkQFDGjuS9BmQNp/DtGYYXMmAWSZENACOFFNVLhrbyZw/onsZc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR03MB8577.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?KYt+s6T9U5v94Cs22JMQRlQ5MmuQvDwNoOJqoqxZ5hP3jvlHuda7HlpB?=
 =?Windows-1252?Q?hKYCNJT5DhZrO1PlumdBJVnEXaF36g1FU7z88BzxffLZgdT6+Sop8c32?=
 =?Windows-1252?Q?6yegvrXLS7kSvxOMAO/2VoXGom43CQ4XdyNEPlTi1GayStv4OHtjVnoJ?=
 =?Windows-1252?Q?nCYNU4ZPEd+e2jqSZU9XBIpFNDiotdTbxdqkH4DjWB2F00xgZZEGz40c?=
 =?Windows-1252?Q?kdAlCyBPvr3Ttm/f2WYMkcHx7oDRQvgrutwlZnbVSlVHefkaWlnK2Qyu?=
 =?Windows-1252?Q?qppQWvKLzO1N9yoRJR5L6FPzLMuQpcRLmjvM4oW+z683Zh62B+ZgbsiU?=
 =?Windows-1252?Q?BmnPBBtdzeS7xdPC6bRdgNDjmGXLi6r/XTlnGfpmd0Ii2pxU1K4bNbal?=
 =?Windows-1252?Q?H5S0EWWuAwX5yQbqNq6w6NVOEoxtfPF8RLCHEyCwKq1L0NTw11vddXOr?=
 =?Windows-1252?Q?Xk0M3VjQnQYCCczlvlTpJdWwIbNBeEisN5N0/LhMHNi1cIQW89AkREvX?=
 =?Windows-1252?Q?6/0P30lKTUb3673KztYs/Msze8vA4s2IMwCK0kX2l22IIWncadOcJRAq?=
 =?Windows-1252?Q?QGA4Ymum7ZfxGa8p6u25TATAd8j0GRVrlmJoZ5k6osCdZJNvV/Zr6abt?=
 =?Windows-1252?Q?hUbPcEauT/obJJqBo0WteZcwlqc2cmrKd2INcw88XHxMKOY8CGKv2XhP?=
 =?Windows-1252?Q?ogd4IFQnYAbgW+dRa1rhiB6dAP3ViE6Upo4L3iCkiDQ1x5DsVxAJOjxf?=
 =?Windows-1252?Q?DTCy94yJyxVQf8x6ZmbKYAA+SQiUbWmvKqUATZ0QPjGeK3UUS1OLFReY?=
 =?Windows-1252?Q?aKCshJuH/vumSKFqCCOe7xtdqOfNxzZwRdhD5NmHE9lnScQBPu63aFJ+?=
 =?Windows-1252?Q?ck8SYDuwuSV3TqdRb2QbLiPhExQMCKqldLseH1VxUUNIs+NMaZXT0lNm?=
 =?Windows-1252?Q?yEKbiUxpgBzcLkVxhEqoAWt5nlmqBlndFz6i157eIftWkR5v0lHJGrYS?=
 =?Windows-1252?Q?isNmK0fu/1GpVeO04D/T0DYybGUheOGPvJVIjODO2Xqp2g3eEWl7yt2+?=
 =?Windows-1252?Q?9MNAAvL33dwSMOJTJf+vLmrBPk6AlZ8hdYzJCDVjMpXXgsU7txxlhiJY?=
 =?Windows-1252?Q?q9rpPJy7+5Th7bXEzsJ7dkJ9O9YtNKo3lKVzMVtwl8pOaEPyzOMQ7wDC?=
 =?Windows-1252?Q?tUfPZ/4Dwy1Ru6Z+csuubtM9pv1B5+raGvT+wsrc1agIyy81+a1nHfyU?=
 =?Windows-1252?Q?4725lDUsNqdTIcf703q3ayuITqE9HxgcjkyJBI73/B7kH9swv8cSq/gs?=
 =?Windows-1252?Q?czjolNta5SlBLysCiW9+E3eHMzviGbl5abJ//hPM7cCWA3IuutXhssYm?=
 =?Windows-1252?Q?GdgyVrocUhFOI3LoeoaKjABUTu3UG7WuYElhEQagr9Lg34OckV64z/u6?=
 =?Windows-1252?Q?KDbpL+uJlGIZGLqfvAwKLgl2RThjBfgzUHKP1T0AO6sdBvoEzXXnoZc6?=
 =?Windows-1252?Q?zfsTDDwj0I43AxKiDUE0msreLuCgtGUt19mFpLJJjfsAvF20Qu7zYQCJ?=
 =?Windows-1252?Q?8wE+61e6YlSaCqu7X/xLv8FlKtHW78FLyoAho1vU1rifg2p4IK+/Bnis?=
 =?Windows-1252?Q?2JO4G8ZJCNB43rqLjjVq+nHUPHjxeCYMiYUad65iv85NZOFCCF0WVG6j?=
 =?Windows-1252?Q?DD4rEwbgQ9M5rjKm0fQrfIGK9YkgwGDaW9aLhbM/f6zTmUNNzAFTuKfG?=
 =?Windows-1252?Q?DPlcIRoSekMk7Q1PnYXYr28Vauy9Yole04vYej3yv1/7SJYOpUap4RmE?=
 =?Windows-1252?Q?9Z2zSBaV66mAhF4EvDIfrUa0haAosvIa2Ywuz/boyhs3VQSpBcQbilF6?=
 =?Windows-1252?Q?0Ym4+h9iAff6IgBPlf3/ckmKLedAty6gboM=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: omicronenergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR03MB8577.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaca3fd-7baa-4aba-23c7-08df4af28d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 12:49:32.4854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1357ca9e-a1a5-404b-bb16-554d5d05c5c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxmyTZJWRAE60VJcYCYpyNnuZ4OTJZGYgCtA+dKS3EngGE25xsrDo1g0mAE/bx7rTxM8ys0en/i6EyHCXOdjsAsSaD4PJ35yX/359g35yRBa8Mpi1I9WOrOKbCoFD9pL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9537
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yes, you are right with the return code of the getsockopt() function.
Your changes fix the error case handling.

> -----Original Message-----
> From: Changwoo Kang <changwoo.kang@ericsson.com>
> Sent: Tuesday, November 24, 2026 4:24 PM
> To: dev@dpdk.org
> Cc: Thomas Monjalon <thomas@monjalon.net>; Stephen Hemminger
> <stephen@networkplumber.org>; Changwoo Kang
> <changwoo.kang@ericsson.com>; stable@dpdk.org; Stefan L=E4sser
> <stefan.laesser@omicronenergy.com>
> Subject: [PATCH] net/af_packet: fix drop count error check
>=20
> [You don't often get email from changwoo.kang@ericsson.com. Learn why
> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> getsockopt() returns 0 on success and -1 on error, so the check "< -1" is=
 never
> true. On failure the function returned an uninitialized value. Check for =
"< 0"
> instead.
>=20
> Fixes: 6b3246245507 ("net/af_packet: provide packet drop stats")
> Cc: stable@dpdk.org
> Cc: Stefan Laesser <stefan.laesser@omicronenergy.com>
>=20
> Signed-off-by: Changwoo Kang <changwoo.kang@ericsson.com>
> ---
>  .mailmap                                  | 1 +
>  drivers/net/af_packet/rte_eth_af_packet.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index a0096fb97a..ed6e68cc1b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -264,6 +264,7 @@ Changchun Ouyang <changchun.ouyang@intel.com>
> Changpeng Liu <changpeng.liu@intel.com>  Changqi Dingluo
> <dingluochangqi.ck@bytedance.com>  Changqing Wu
> <changqingx.wu@intel.com>
> +Changwoo Kang <changwoo.kang@ericsson.com>
>  Chao Zhu <chaozhu@linux.vnet.ibm.com> <bjzhuc@cn.ibm.com>  Chaoyong
> He <chaoyong.he@corigine.com>  Charles Brett <cfb@hpe.com> diff --git
> a/drivers/net/af_packet/rte_eth_af_packet.c
> b/drivers/net/af_packet/rte_eth_af_packet.c
> index fbaea57615..ad71582aea 100644
> --- a/drivers/net/af_packet/rte_eth_af_packet.c
> +++ b/drivers/net/af_packet/rte_eth_af_packet.c
> @@ -518,7 +518,7 @@ packet_drop_count(int sockfd)
>                 return 0;
>=20
>         if (getsockopt(sockfd, SOL_PACKET, PACKET_STATISTICS, &pkt_stats,
> -               &pkt_stats_len) < -1)
> +               &pkt_stats_len) < 0)
>                 return 0;
>=20
>         return pkt_stats.tp_drops;
> --
> 2.36.0

