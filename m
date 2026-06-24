Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F4CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 18:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CAF8402E5;
	Wed, 24 Jun 2026 20:58:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 47CB4402C6
 for <dev@dpdk.org>; Wed, 24 Jun 2026 20:58:23 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEgY5o4024710; Wed, 24 Jun 2026 11:58:22 -0700
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021090.outbound.protection.outlook.com [52.101.62.90])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eyfr7f1y4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 11:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyC9QKpPHhvMv26kc7KDNPr/Dk20UJw1CSnxdJFPx13MRraog2PSxKwFMiIj46gHDrzjK/htj3lZ0zsBeKnE3qOXyWpm4bxcLs9xHxC3jWN71ffEphzneskEdNmaJx6HZsYviQwJJLMPY9iyIF0lJLAyXs9ncnf6TXMh1dxBVVRP7vLfb7TOmXtr5/TqJtBldW2dkPilKJuVpJLj+xLMUSXFnA7ID+GhvGus7RXqi/aw9nD2K2exYfMDHvhbUtvsxQ08B3TFucGdVhP+WokRbtkfwt+DQCxjCgtMqqUa+pZbRib6Aa35jxZHF2pBzhSdvwsuDkFxgk9xA/n+UwrnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/8sU9RVlVm/o0CYdJQSYhcoUIqjbmaCT9zoogGkTkw=;
 b=e76oPbWSaOGUO2zSJbQJ9irky3U4fsY61jB2w/AtxJicu+qvHIsYcinSM5YqX7e/pCbZZiNcF2RjMxnuOfKkK/wiyDjiKDPqVckQE3MfeMkW+5xBlvR9dATl+0OeuqK7EUQV9zRolCQLCcwfESMxSYEGlPkVBFo2SHERzVy2K6jGG3fa/eJrk6CZH7iKnLRFrraLeu+YOXXMCXSAMRKOirmGAVF9On8x6w953FPpk/x2bmzJ7FkWLjXEh8oWjxCveD2a5kYVtoXBLW7r+fZnxZFDM/CTRgGDR7uuflANW1jR1Vb+X+iJk7f6UHO+phu1eKt9xTONgmhQ0XVvPPhXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/8sU9RVlVm/o0CYdJQSYhcoUIqjbmaCT9zoogGkTkw=;
 b=n6wNxo6CZ14ZoZoloZyc+sm47pQT+yoXlfMiyBZEDFxNHk53ow9vVdey7rAWbytYk3ugMrqB7IfvsbyQkCczTwsbcC/zf07SIlwfTYi9G63QUayIRKE5RqnmIL9rKb8SyRfFU3eQsPHYSsVDEsQhEjq3sdaOAqKwapjsjvOdNlg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM8PR18MB4486.namprd18.prod.outlook.com (2603:10b6:8:26::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Wed, 24 Jun 2026 18:58:20 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 18:58:20 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 0/3] update tests with CN20K support
Thread-Topic: [PATCH v2 0/3] update tests with CN20K support
Thread-Index: AQHdAsiagc2vfs3O3kWdM+QY7vCO6rZOESPA
Date: Wed, 24 Jun 2026 18:58:19 +0000
Message-ID: <CO6PR18MB4484FEED0BF25DD085F569FFD8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260623042723.89226-1-ktejasree@marvell.com>
In-Reply-To: <20260623042723.89226-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM8PR18MB4486:EE_
x-ms-office365-filtering-correlation-id: 712a4dee-4718-4548-dc2f-08ded2228ed1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: WXRd91ncSms1C2WCoUfEAMjdF0IzkQvziyVxC1Il0zaGRobkeWJ4qSQGs8sNErUQGgITluh+tSlhxkA0pQks2qUapEitRSHZx6G7AAr+gX/Foh+bEDhQHgRvV8xuS92hld4mUhfMyuM/4yqhuSXM+wExwhY8qAsTxxliO33ZQ2d9AWz8WiYTvZSRaIjGWVKaKfZhrX1NE5FShTR7naK1+dSgD7wwf3VqZ+n9nnl0jO0VqGN4Nvy/2LHj4wTTeot4y2MREnJHN3VqoEJfbraUbDTqmm7wFVk/epC9lQhg4N1o2lINLCDpGv6ki1bzMckhnHBDtkI0pv6zUglb/iZC70WKI0inMwfjbCbwaB+CoK+7t1P3p6s/IYq+gTLeuHJPU+YKUp7chu9AEd/sh53Lg44GVzF1kh7VpHVAa++7J41ZXAC9MAJsXIAdIi+rEpUJM9V60FYynQlMcT24FMUsqmwwut1ULFnV1CpHlgOkdUkAdaPjxhpSUmVK5Q/AI+aRFAzkaB1UktXVhzjKWDfrYIgmKClLwOrmtRAFQ7hsvQo/dy4Zt49BMrEbHwm2KWU6YXHN/XqEKQyiN7JQEcQFP9V+CUK4+NCCXrnOUhQ3HEIIzWh19TP2nOQzJ1QHBKZKJZmOdHUzLLCs9nrVwxrB0IsYh1/Gq18/NBwTmOQ8ECztD7Sk6M+CVlh7fPV41G7vAfTzDWnwMZyPzXgxm5DRAmePeJZONhKaUJaxnTHMe4A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VTYmz3v/OfynwOm70cgcmXnwRuW+c+jt4oy4KsEkS8qWMevZjK3KdGleKAEb?=
 =?us-ascii?Q?3O+C8C+es/E8dDkadfJRbLCY9/Z/zq2tCHA0pA3lnrUsCdb0L8K+SKJOT81v?=
 =?us-ascii?Q?JyV5eD8PIfBTelLsHxYb9w6++Knw0rX3UkrI6HTwsJrWGiI3slnpU8HYlezI?=
 =?us-ascii?Q?58aC6ZkxYNF6F9vuDyioSNcMyJHH7BDKhFnnVFWkm1qJMLzdgJdFamSIHvIW?=
 =?us-ascii?Q?RxM3Q79IPSfJbrgVMF91w6898MeK2UD8MaClLFoxQJnrnr0ThPMQU0o9xHbj?=
 =?us-ascii?Q?L/tczS7uYGr106qakIx8VhpoG3LSL8ycDNCTZT6Bi3z23NQqCPgcTayiQ8BP?=
 =?us-ascii?Q?inXe81OP5IWujWkc17A5CatD7/Zeup6zpKG0uNbaVqqsNlRAaVvKz0NE9HmS?=
 =?us-ascii?Q?+Zkm6YHl36Hz3sM2D5tgT0UziMCb2lm+/x46Snvi09/MlqnRE/Rv1m2t3Wf9?=
 =?us-ascii?Q?8bJ+P6GxISvDy5YdXNPNYZOsFnkC2Cp8XY96fy2cbB3ter8uj3S5mV9R39tN?=
 =?us-ascii?Q?sCE9okiZq8b9zZ+nyWaCLBmi3yd1rkejwBy6YRC8knMjNYp9VPEmYUN++agg?=
 =?us-ascii?Q?7E4GBzcinQJrAb+QXKFRvHG3VgdBWbCKAJfwFv6VmCjsKUBD6IdszgwGbnKy?=
 =?us-ascii?Q?Z2A3uqVsicEg8x/iOo7BNXZmgbtW/F6zCkniwvQluXb4dCxeht5hdX5x4RYN?=
 =?us-ascii?Q?lvq8AJhWNJ/5QLMk+TkJLUvJvYsh8tMWWRbDf9VTCn1JltwSwUu8KjqRdDVU?=
 =?us-ascii?Q?T+PQvjNPm+LbJF7PJSLqvAtPmwoQJREfBMGfFqBXxFGZ2DJQ3V3NelJ57Sdb?=
 =?us-ascii?Q?fSnT1HuayiSr6XzfhxgHFsLTK8eGF8EQ9TojSIEG/wYJZNWCBNqFmjqnFsCh?=
 =?us-ascii?Q?icoQ7fP9253UkInEYU3HtsL8Lovfh11KS5lxBuwe4v/1GzPtLtKXDociV1Ew?=
 =?us-ascii?Q?fQ+GPELiLcUoM3+zfdDioOXcebIxEMTrP53PfG9x3MqkRJQqyRFz116QQUHq?=
 =?us-ascii?Q?891fDfSbu128cQVPWWjADa5iKlR3jFz3toqORfE0SAoG2giaU/ZhooKu/ybB?=
 =?us-ascii?Q?OdMN3+SKxe9j5/3yBq2CQfYsBU1skHX2g1UcBLDY3nL5zPkrgQXSFbcS39XE?=
 =?us-ascii?Q?x14HNufK81GT2U8mkCzjOyDaMoWAXf5pqEaoKEJ+0GNoXGK55ths0QLf/TGa?=
 =?us-ascii?Q?sWOFuYsn985fi2jjahtYXhOc0ojBCRyaWxYUtva3fS7fV6y/aoyAaCn/K5mW?=
 =?us-ascii?Q?MnCqjKduGh34j1hhKsdUlH/4TSK4PnqEesBhHtqQaRAVW78Z/DKD3+FHnCOT?=
 =?us-ascii?Q?A1WCVQLDV4VEHH/OpMQttEQfgUlvG2zltNq90zPfOe+L54YpjRjRHSTP00Jk?=
 =?us-ascii?Q?NVT2prD6PZoYmLWhekVMLRXd/IG+Mq4I4yL9x2NRvzdDxAXU4FuvpiwgSbyH?=
 =?us-ascii?Q?Tb2TEent+xM8LRFhzbDnsMvHRz10ZZjT6BFlUsRNyZ3DZh9cPhPcelYxDIrA?=
 =?us-ascii?Q?InKAKV2K1ZQP7+n6NutW4MapIEawxuyqCfWqBWBnLHdd9rIGRmFDv5c4xtMF?=
 =?us-ascii?Q?HR7G7pCRqcAH/YgvFIpSRhpZH1nqtNzTD54doV/awAC6K3NVU9KQ8rU9O4kX?=
 =?us-ascii?Q?JSrbRCw7JHsKEMduChKNOFsArKTkO6VXXGhhQFF/LxZw91lrI4ZqQmGrogw1?=
 =?us-ascii?Q?qDTIzJMMX3iOOqJf/INJmDWt6rSbPVXJW/rHgCWoeNCwuor1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: np27cXM+Lrku/pU5fGKZ91ZA5WglhYgRBCNZkLC9DFRqTX3wYLiDQhusRH20j4bPWyq7df55T6aAHnLwu8YEmaBregEIaXf2B+jSjrAFuZJu066eXao9HiRmD+Z3p+pmtmnpynGw7gGC20pQBCOmSig2YRnPqWCsZTrqYsLyUbR0Z5E9iO3xa/tBDC8eZcHUt1zMj4GrLj+XdjZA45r21heGqmNRVFwR8bOfo33TAb/Kbqqwy+xE9mkqETQeBOic/y0NT7tDyFzOt56pW/4Jljb2f8sKlmau/La+mh888IJEdtXIbVFl5ZA7uGRAtvyDdHqQLbs9R3e9i5/liG1/4Q==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712a4dee-4718-4548-dc2f-08ded2228ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 18:58:19.9785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R7y1i0kXtprRVF0bv93JG5yCuG0GQW3ND/XyFA4Kgj+ucPTkk0apeNd5UcbGzlQQPyhD8EKvzn5DWjqO+66u4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4486
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE1OCBTYWx0ZWRfXwkSIomVJThaT
 sq8dL9b0jcjR91fNJISOmkz7RTNJ5ksNmFrK1njqJpPubdFtJ/cdXZ0lyE98jHLAWGNK1SPMzG0
 thwtdfM8QsdFWIPdzSAJ9zkaOhSFAsI=
X-Proofpoint-ORIG-GUID: 0lvH9s-3MKz58A0tP3-5PcngQmBVSOJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE1OCBTYWx0ZWRfXwXZhm6NAvUML
 zOZl/qjWQ9TeGhF540veDn1gSNeP33JLDUNNoRmvTHux8OUZrf2zQAYdFUX+g1qJr1Qj+ISrikk
 bKJ0qLWvzxGSpCzr2XdBthQ6TqvcPhh2BjD7LU93/stpTBAidcvKPuGHpJjlV1yNvddr1reqY7V
 aBrGm2IuglJhCXNGn4pUaOpMnWWc+R6oBY4+QDVx+OHnHISkQ7TZ9Nu7p5eHsG5BWQ3B0jO4qig
 5NHjQG30k5/zsuuj787dhu8VjALUrFFURmft+4vs0J+386iDNeEffav6QyvgfaZJCADDLfFY2DI
 b1FKzWl0T0956fcBnJ310WPEupKm9ENeXk0fevFy8JRS1xRb+Eyhm6UA5/2r/7lB7+hzkIz5fvS
 VpPvuCb/a/0DfVVqhtMkBbVNeORW+Q==
X-Proofpoint-GUID: 0lvH9s-3MKz58A0tP3-5PcngQmBVSOJU
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3c28ce cx=c_pps
 a=pMj1vk9pV3S8wB1vsTRRtw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=pGLkceISAAAA:8 a=8rWy6zfcAAAA:8 a=UGqfY0imQdgysMWDtusA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
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
> From: Tejasree Kondoj <ktejasree@marvell.com>
> Sent: Tuesday, June 23, 2026 9:57 AM
> To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>
> Cc: Vidya Sagar Velumuri <vvelumuri@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>; dev@dpdk.org
> Subject: [PATCH v2 0/3] update tests with CN20K support
>=20
> Add CN20K sym/asym autotests and Rx-inject multi-segment unit test.
>=20
> v2:
> - Removed asym sessionless test patch
> - Fixed test names ordering
>=20
> Vidya Sagar Velumuri (3):
>   test/crypto: add asym autotest support for cn20k
>   test/crypto: add autotest support for cn20k
>   test/crypto: add unit test for Rx inject multi seg
>=20
>  app/test/test_cryptodev.c      | 42 +++++++++++++++++++++++++++++++++-
>  app/test/test_cryptodev.h      |  1 +
>  app/test/test_cryptodev_asym.c |  7 ++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
