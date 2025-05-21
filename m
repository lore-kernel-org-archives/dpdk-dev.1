Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C2FC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 14:13:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52EC442D6A;
	Wed, 21 May 2025 16:13:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2AFE34028F
 for <dev@dpdk.org>; Wed, 21 May 2025 16:13:19 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDrVtx017321;
 Wed, 21 May 2025 07:13:18 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46rwfgj5uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 07:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlAoo9N4qe49vyrTJlTbzAQbSeXAv9wFbyEIUZp5OC8+VKE2Mt7GY7nhy642J5CYoBL+bux6lJ5VOfCXWjDqWbYm7bPHxpvny6Mk2yMMnbNr19FD0INqttsmvEUgwznqVoxnZJDjD0a+dpLb+xFxMuHpf13HjfOeZSuUxfcoHrrN3STKm2r0crW0njuOCtaBlH8Li7XpTz7SbM4YTczFL2EqYVNzTuVVvLwW+67g4/+F1up0M7aIRXDeVK/uRi1+4hlXZPAMzi+iojpFd6FU3agjw8aDtkCoLm0BYIsdpjP0IfmhwuYYgfoq9Z97bJpHQtfgqwJ0DGY2HrjKrSP8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBh/U9XB6dyxwaJSs1ris554Q3XmUJN/HEhEmRo0esM=;
 b=Ju1e3vjH0XjUmYbeCgEANsorLuhZUrsFfweSJgOWGTfivIl0sW9xXNn47UvnLPExPuj3J1oFAtkNidfCE9QPECZFzdGGZJRZxGIrMe0nJ0zcjJsL5Z5hbithgbqcO1WiZVuqQF5y4ZVPJ34Ar5qUSNaOKEQhiCrKpxpfx3ZiKQPiRhHPlGBi77qXI9lOZLkz9dOFNBBYXRFTbVT/Ey9RqRJcAwwHm+AaF3dI3HhEmN2jCN87zHfkPw1Yb1aec/fvLhbU7rUPpuYTdv7UMMqCefZnxksKyO3j3vllkH/ErTSVLw6+3l2BGoPi6VhfZd1+YuSyO6oqqv9J6aeFahc3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBh/U9XB6dyxwaJSs1ris554Q3XmUJN/HEhEmRo0esM=;
 b=Sj1n7n51vrM1sm1JWCmw24aIi04Xegy1/K2KOFkZsGc+2QYXgaW/FeoNo5thWMWPIstvjdkSgQuZS+OeptRXfUZzhXIh+jJuGAgLLDYzllmvpXwwtDRIXnpx/kTd05k5WLXu52XcA5x9shjGRra3MN/yksLJIjfl77ShKvye70s=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3467.namprd18.prod.outlook.com (2603:10b6:303:55::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.19; Wed, 21 May 2025 14:13:14 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 14:13:14 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>, Radu Nicolau
 <radu.nicolau@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: RE: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPsec
 packets
Thread-Topic: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPsec
 packets
Thread-Index: AQHbp43D0TENpgTQzU2FXJbD3p1/3LPdZaww
Date: Wed, 21 May 2025 14:13:14 +0000
Message-ID: <CO6PR18MB4484F4DA8E9DA78C78157093D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250407072155.1255817-1-rkudurumalla@marvell.com>
In-Reply-To: <20250407072155.1255817-1-rkudurumalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3467:EE_
x-ms-office365-filtering-correlation-id: 4038aa13-0924-4c1f-fcc9-08dd9871a027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3fUBYABep0f7uoskuNLs1kn65NryENuU4EcxIOPmHu272YO5QTtIsQD9zIAy?=
 =?us-ascii?Q?V4JzXgJBT8oadziZr/VLMwCI3gBttFl5uSzAPGyuAxC4wpFq6N5xsZM31VRi?=
 =?us-ascii?Q?Qs0a2a+3wHzWfb6jJjFfmzqchT3m2Pej9cQui0BGfnyj4aXyMfY7S7QegcRC?=
 =?us-ascii?Q?I0masHbMrHO2cY4nTXlGPV99FI6WJIXH8gIl5s9LWKjeZI5DWLfNJXFtRGzA?=
 =?us-ascii?Q?1OMZVVAaCftXkIyjo5oR9IAzoHsayHNACRwvVStLG4yn36zK9fuRmTOd0T93?=
 =?us-ascii?Q?z62idOQ8Jkx19uc2zx2AeZBzMr3q4vaw/X15SW5nrKeTa0DqnWcdXg2sRbPj?=
 =?us-ascii?Q?Q3UeEniekShf+pxN58VC2P4+VS1iQsdm8bval22o/jmjvpiV44cIFlsL18AS?=
 =?us-ascii?Q?0iNUUWLzx8a3hPa1/ybYaouySQ6F9yuUBrvXdJx0cdz5PlFTfBiAsQJlzd45?=
 =?us-ascii?Q?JHd3VrfLiOXuTzl0g9O3riJ1WIZ/jb/UjZD/a95Z+z5fuNkppGTC47I+jlSo?=
 =?us-ascii?Q?4lq3GrCWVKNgHnaqka01TY83ZOxIGNDZQOJdNxbrBh2sEVQRSXmAhQJ05SZm?=
 =?us-ascii?Q?1Brn18z5Oe+8E5nqI8UBw/ChVu309bmRifdv5GuAQYQbfcS0/A/7qacHtKeM?=
 =?us-ascii?Q?E0XY5I41g7r8AtpTUXEanWF3e44CAa1EEoxQPw3ABpmq/MsS0lCwM0NFaWYR?=
 =?us-ascii?Q?7IdnCFVmcYaOoft72E8OqRTPzC40pldW7RObd26e+lkiEYcpi4fv+bIfimhZ?=
 =?us-ascii?Q?5caKA1E34VJU6L099IZtpZr2pZSWLP9TG65m9VYOvPWvxq4Ua3sjSU5q1u15?=
 =?us-ascii?Q?WquhOF7MtWuMja30e4C/jD3d2TY5OvVOn4Llex/wqLumUyjndJvruyZFO4MV?=
 =?us-ascii?Q?D/AZkuFV3SvkErCnQudPo95I7XlU5DF/LXlbv4PHcNpQMxBS0SRVZgAyBuFg?=
 =?us-ascii?Q?WAo4RAwlpzC7tLe09V8BeH3T0nA0mleRqhzOwff9boAZdI1LeDBTfXbHpSVE?=
 =?us-ascii?Q?iDqOmcSKwAHUOm28H3HnVuD+ynzBdHBCgBg3HBCM1Y4as8A+4YYNwrc3JDE3?=
 =?us-ascii?Q?d5HznMYtRVH3g2q5LUd4LJiDhItZFvhUXHdaXlgKQKqBDHaseDXwxaV91BJA?=
 =?us-ascii?Q?TT8542F4MfdWHa3F3++73Q73lAz0cCCrVzpyfqO8An+6m3888dwPEnQSMKpl?=
 =?us-ascii?Q?DVNqE0MWcVHkgg0FYE2/HktOE2avPw9NSaMsiLh0r3oNSTxUwI+B299dqQr9?=
 =?us-ascii?Q?jmrpuz5bbXRrN1uujynJ9ZnNUh5taoGKK3ZveeYEEhjP58mPyUrzYhi0vdag?=
 =?us-ascii?Q?5x+4lyf60YOALvyuYN0DmsOD8+vTc9zUZiA0TKaCc08L0ryRqbAAVWtC6g5z?=
 =?us-ascii?Q?qyTAvxuimLeZ7K1C/Gnzcd9k2Wigibm1agXWsQEVssmrmjI4IYSsCcEolTdT?=
 =?us-ascii?Q?yzepD/6uBxPP6iY1+IgsnGVkPdZa0A7ty+o31vH3tEBPpcOXelUvKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r7gow3caQVFWto29SUN78WWw/vljHGUisnxrL4jq8bprlDKqNA/IaKbP9oGH?=
 =?us-ascii?Q?gwgLD40R95Lt1rnm7Gzvume5mBFKLr4oqhPs6vGexbsT6IWMDGtVLjOxhQWQ?=
 =?us-ascii?Q?hXitr4BBjP2aPOWrSdn+uCLzr0BWWivGRv7pHFoVDTNa90HOm56mhIcctllZ?=
 =?us-ascii?Q?9Dn+j85TzrX2+ujEbo9WdDDU+FiJxiPvmSxwMk/8KWwdnsuHAK9aumwAwqfz?=
 =?us-ascii?Q?bDcA7eGrzqHfYwBEoVrNderAkeMo/Tq8rFlhM30ioGkN3en2mmlTZokhj2j3?=
 =?us-ascii?Q?+Vagm/qtPtuzV5yozVv8TNfx1iZg4K1lcU5FQ3xqJzQZAPQxAlgdh3orczgB?=
 =?us-ascii?Q?Oj0mASZeB7BumlKL4PFR/otNVNYM9piUj50F1h8lelgaRAl+jGcs0R2Rwoqj?=
 =?us-ascii?Q?gg3QCDZ247cWjCA0wp4JYvJ2CplDpU1RsWsnJagbfBNav3x0024Jgq0Z43Xm?=
 =?us-ascii?Q?wqNJ8z85VDh8hbRj35axsUGGxUy5IIZNcR7GNzQHJTV3+GNQKmR1Rf8tfwUL?=
 =?us-ascii?Q?F+VbG/V3aWCQgvT9DWiMfQb5CKqBnGn1FHo8Wpu5IRZ5Bm1TJq5CLDgaX9gq?=
 =?us-ascii?Q?q9ehPswqrU3kb+gzpF8BP3cogoU+Cxog1cuxmIUUwJoaChBb0+73NS2IRm7y?=
 =?us-ascii?Q?WX1xsK39/0Ko7AdaaevzW0830I6g33jCYyShC5mvm/teq8RW1NspfKfAC+u1?=
 =?us-ascii?Q?aciFakaKDEPNlPhtBzr62Uwc00H0wQv7z5L34rCNhZGYipPrBSW3xceQNBW0?=
 =?us-ascii?Q?uJQ7AxeTdtzseqGupYgGbOvtSdQoLtbLfOeSA/nMFZ3idYh9uLIY7RQrNdLx?=
 =?us-ascii?Q?IHd+iBtwcDZC3/d5F8+P1oscwCYh0Z1fCqD0uDKtFib5brZeJS3oM8+T1jMh?=
 =?us-ascii?Q?4BIIhe1ALrX1heAdXV6VIdtk5JGO/fQpqJMJTLDA8hEHk84xBo1GwWHLX/bY?=
 =?us-ascii?Q?sB6LV/cWb9k4msXof4lA09Pi9X/yXXarDWd0ovG4Gcw1zAQa+m1iBSN8bOh4?=
 =?us-ascii?Q?fHkAX2LfSNbLJ/f2ADwS4g13ZWXwikPw58kEsNxPnzoiscQo0q2bZ5yyb2uA?=
 =?us-ascii?Q?3Vfrd3TnycwqtNUaLucmER8OnSZOcMbN492momQHpfOjUHshs3D7HJ4hRJF5?=
 =?us-ascii?Q?rIKBcJBKJi2nEyuxKrD+Te8ZhIQ9y/2COCjDYhk32tMNLJu6uvwfYpIUbCmz?=
 =?us-ascii?Q?Beid3rW+2hgq9P1H1Th6GUIY26EcufRyBJha55yojim+s0u/ajjz6UvUnnmq?=
 =?us-ascii?Q?52ojUWJRMTTrFIrv50sEQ2KJ4ahlLUXuLzgS7U2WnnNVl639piPN6sRAy4U2?=
 =?us-ascii?Q?6OfX+BehoaNBFbL80MOr/dMepmv6PJmWGa8BKiXiXAierYlXJ44Gn4KBcujW?=
 =?us-ascii?Q?4jONsfTAmXVzKGRuouDmFstPLVU1RsR6w9CZ26rBav2QepLgzglGvBNLmRXq?=
 =?us-ascii?Q?plm8Rv4ELHCVnZG+jZBA/W/HC+L0qIygTFGJqSys+UoilagNZiEYcSeDgXFq?=
 =?us-ascii?Q?C0SpcQnrTduU/NCzhd5/0XOUHL+4L/ku21CA4RQg4eY766rQ6PVZ7rKkUwpd?=
 =?us-ascii?Q?q0ohyAcmDHaAk5pAtVizamp7EcU0WMGdmfSqK9Lj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4038aa13-0924-4c1f-fcc9-08dd9871a027
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 14:13:14.1972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X67i3XvgDWD3EkqcTTOq5OmqYATW+WSwf1ExdLgZ28WnyaVavUjXq0MJ5S6xAVTw0zBt+LoyILK7gv3tSnY5wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3467
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzOCBTYWx0ZWRfX0vdRSOhx8f2d
 xjb6npQTTOfHz/G4XwibAcRzmfHIGXxkml92LTwfPcNSZ6QpBhqEQHKO25wibXKfTgmsp8SP/Io
 gK0uR+K2BAQfOToJeSlAA56fYcp2S/Zy7X/Bq4CxYwBeuvWNn/Z8CwlKJb5FSMxgFzNEyJ1lQAE
 SPn2KtWC11ag98pcWxDwnkYSF9gf4SsNQnnBWbNvsmI5I8u7GiNpZeINq2GLv1wAO4GJ7/aIsEM
 P0aHar+0UWzwIXI7wyfJv7YWJg1q0EMfEQEsoGutu1u7E1e81IJ0rTbl4TD1okN085dMuXGhLxS
 5G37M1RzOvsg6j/qqac1nvzt2etPpEMxC4kgzRTK9fiQfpclqX1n/jh9yC9BG9HszNvs6spQ9rv
 EG+/jKoRjUrN587P7wLQFWs4aYe5Nq4PHrAwO21cTyu+YAKQtJ0BPuUdSYIXFaWRA9TH/1T4
X-Proofpoint-GUID: oo6Wqg6cFpU7S7dN5URBOCN6Hamzr_Uo
X-Authority-Analysis: v=2.4 cv=T6OMT+KQ c=1 sm=1 tr=0 ts=682ddf7d cx=c_pps
 a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=iJPFo3SLCAAhLoZOI2sA:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: oo6Wqg6cFpU7S7dN5URBOCN6Hamzr_Uo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
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


> Subject: [PATCH 1/1] examples/ipsec-secgw: resolve segfault for IPsec pac=
kets
>=20
> launching ipsec-segw application in event vector mode
> after traffic has started results in segfault because
> we are receiving few IPSEC packet and application is trying
> to decrypt IPSEC packets using lookaside protocol.
> This contradicts inline event mode.This patch fixes the same
> by freeing IPSEC packets and processing only plain packets.

Please add a Fixme tag and cc stable@dpdk.org

>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---
>  examples/ipsec-secgw/ipsec_worker.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/examples/ipsec-secgw/ipsec_worker.c b/examples/ipsec-
> secgw/ipsec_worker.c
> index e0690fc8d9..04609964cd 100644
> --- a/examples/ipsec-secgw/ipsec_worker.c
> +++ b/examples/ipsec-secgw/ipsec_worker.c
> @@ -700,6 +700,9 @@ ipsec_ev_inbound_route_pkts(struct rte_event_vector
> *vec,
>  	struct rte_ipsec_session *sess;
>  	struct rte_mbuf *pkt;
>  	struct ipsec_sa *sa;
> +	uint8_t mask =3D (1UL << RTE_SECURITY_ACTION_TYPE_INLINE_CRYPTO)
> |
> +		       (1UL << RTE_SECURITY_ACTION_TYPE_INLINE_PROTOCOL);
> +
>=20
>  	j =3D ipsec_ev_route_ip_pkts(vec, rt, t);
>=20
> @@ -707,7 +710,7 @@ ipsec_ev_inbound_route_pkts(struct rte_event_vector
> *vec,
>  	for (i =3D 0; i < t->ipsec.num; i++) {
>  		pkt =3D t->ipsec.pkts[i];
>  		sa =3D ipsec_mask_saptr(t->ipsec.saptr[i]);
> -		if (unlikely(sa =3D=3D NULL)) {
> +		if (unlikely(sa =3D=3D NULL) || ((1UL << sa->sessions[0].type) &
> mask)) {
>  			free_pkts(&pkt, 1);
>  			continue;
>  		}
> --
> 2.25.1

