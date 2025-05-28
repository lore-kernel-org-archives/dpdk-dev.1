Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ADC3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 12:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B705C40E16;
	Wed, 28 May 2025 14:50:52 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by mails.dpdk.org (Postfix) with ESMTP id 631AC40669
 for <dev@dpdk.org>; Wed, 28 May 2025 14:50:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMilmT5cFEkREP5lYHX89lfgXaUFOvRFnXuRBsuy4NworpfhcPasH0TamEOiC+hcsgHtD6Z5PBhT5Qx62TZu+F127bN4Gd78vbIJ8kDc2HjJ1JragJ61AoSIKjx4DqC62/EJHvABXaMVXbZwWEh9YoRBZfa/w96G+OvVFTdw6wSaTHIa2D8AE6s/RySOgZhXl7+YY/41Gu21av7fIaJqJXNAjr0eK3mQx1Jbsy1XlF+WOacB/9CROXWk0wcHhn4z2DwdARUta83MEd3EbYrYFRHnPWLXLhzVJgcBxFOtd2hlZkSSaq7y7n3pQKOCmLlfyLfZge9hl62vrSuchB9/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kllna28XRPl/OZPU+YES6VcJoljLXTUyJfu3y1E0U0=;
 b=rCvGTnDYXDIs1j3Gc8P6hUyLtUOEOW5l+8WrE5iGOLPjuxK8ML7M5fcw0yOk6ZKQKtv8udqahcJhLOswiwYqaUn4qsQG3yGf0tQ+ad7rdWmUIfgDziu0pXjoN8A0d1f8gPysyxd+wBLRjq04El3VCSSCyVFsewe4uCApjpAIdAsgwQ+/39QxhJpxGp7sMPUOXL/fiOaadqszel6MsalpLNrk4YKiCGO0rW7PiVNIyNK+BYHZLbUpAqoCdEOhkkt6E/ySdSN7u30t+KkeTGUDg06xXyDluaG3+JufwO+OnsPJH9aedPCGrX2i/NBrG4SAASb3Iek20YDMQN1X3JEHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kllna28XRPl/OZPU+YES6VcJoljLXTUyJfu3y1E0U0=;
 b=mU2/0o1dF1mrXU5FxbMfK3bDjEdX6wx+/u7zgqQ1Ihke6oV1V+CoKSm2wXUzR0FZLrZm1JaUtjWJg4ijQFJFn9X4HpLvlIyFhWfZpVgudozrxTJdnziYuf0cSJeSFrtS8D/uYpLCVA5wfe6DS9ut+lzJoZr8xe3/SBrgG80nY5VN/kABkNojmN+QizrVFYtXVyuZ1Y+zwE3Xvsfp3AYO0nyT3dtQcBt8o1+I2tLmFcxV0DhjMdJPyAwJlPJlcmSmXUfyaFW5uIhk9is4k0eC1uy5iCfPBEI8mO5T2g57Z+isctzsnjaJDrj7bV2d8LYeOSQQ7EFdu4EUZoUYE0fdBQ==
Received: from CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19)
 by SJ2PR12MB8883.namprd12.prod.outlook.com (2603:10b6:a03:538::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 12:50:47 +0000
Received: from CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::e839:c726:ff9f:706c]) by CH2PR12MB9544.namprd12.prod.outlook.com
 ([fe80::e839:c726:ff9f:706c%3]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 12:50:46 +0000
From: Suanming Mou <suanmingm@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: Looks like a bug: operands are different enum types
 'ibv_flow_attr_type' and 'ibv_flow_flags'
Thread-Topic: Looks like a bug: operands are different enum types
 'ibv_flow_attr_type' and 'ibv_flow_flags'
Thread-Index: AQHbzz4ngzDzPWcLv02sCAhAeL7yz7Pn/xKQ
Date: Wed, 28 May 2025 12:50:46 +0000
Message-ID: <CH2PR12MB9544F9D1AF5EA779333D389EC167A@CH2PR12MB9544.namprd12.prod.outlook.com>
References: <20250527193256.GA6110@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250527193256.GA6110@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9544:EE_|SJ2PR12MB8883:EE_
x-ms-office365-filtering-correlation-id: b12a6c3b-bb4f-429c-5c6c-08dd9de6442c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iiQAyl/CjyqOGXJDYg4gLXTKGqBRVZGf5irS8HHrjZok+qMSc8sybUNuzph0?=
 =?us-ascii?Q?koKGkv5CH+F/X77MEs/6pkFTchvJwQj/g3UVv7aFEgJFOj/Iq9cYo2ePTEoX?=
 =?us-ascii?Q?O4VzG7EPXocAeYmhFqs1dj7BReFLSq/hFzkrAC2uBerR898q9+MgaE6O9Ngi?=
 =?us-ascii?Q?/lvLr0q9xWQMiAXdCOA68mET4EumlHG47pgDlXdVVJ9sqXNvitXTvEMn2XIz?=
 =?us-ascii?Q?aUUkJQM/EU/44ix89ma3FGiPEZcitHiNaXG8lZwStfosHC37K000pav/Y0Dh?=
 =?us-ascii?Q?MpyM5fYh/OGMQnIOFPOZGYN/8WNuhx7GFj+VZ4/eo8yGgTjs7NsdNI9X9ww3?=
 =?us-ascii?Q?kc5eTG8x4PE8/gA1gFxUQRaRLY1JyXpBbT1Ia5vxJ+lycN26Z5eG06is1+zG?=
 =?us-ascii?Q?4kvGvIYVjAdIVMq3vQlyvVEsjHfJy1hM8HV22muaWao622O3BjzK06g3P4CV?=
 =?us-ascii?Q?n0y0CA192jxnk7dvPcg5roSMKGFghprKosYzPnZ3uRZ6LoTNjjS5M7Me6Pm7?=
 =?us-ascii?Q?kVfDe13Zi0vfUMFHeoAPfA5pbazg3vJXUHdi6svrecCpp70UBWstpipAHSVW?=
 =?us-ascii?Q?wqs4YpoVidxFVMobUyRqBgUcARBlfYpta13NWMtIHEjaSUY9pSZ4CGjeLNbR?=
 =?us-ascii?Q?cVuP9iFusj+4zROSE75Mw1L+MPnb/o0O2pBNLp+oSiuuf6f/LtDbabcG7kmv?=
 =?us-ascii?Q?N9DGeItcnnhrUbYWvhdbNpbJnxvL8q0WAH4DGEEOd++hhbDL5rzLQxE9YWrJ?=
 =?us-ascii?Q?xudE6OFy1B7yqwsa4QTUd5EMSmYYGKZHkweeN2s1SCgdWPezluY1BCkYOChS?=
 =?us-ascii?Q?sqrfJWjsy3xCqyVPGWdR6rt31uodpd6gAvA3/hoOwIX3+PAV1jFVfHZG6uG4?=
 =?us-ascii?Q?kptcQFRa6RCJZWQMGFJezBpRtKrUP1msNqXl355+evS2HYyXZUefQsiy2XLi?=
 =?us-ascii?Q?kDnGnpdZI4z8P+RlJdci8wQzkkJAcrcMwkInxOJYAQN08bADLygoM7OGYcki?=
 =?us-ascii?Q?/V+wLuJOEZqCQRlVPBgn9NJ1+lXs42VTYEtZ0HY6A+0oKqykBL7ucwtslA0I?=
 =?us-ascii?Q?UmA0G/xkIVJFhfBydqn462pk7F8xq6Icl4F+RaMG6C22Q6goAw/b0qZLDD7c?=
 =?us-ascii?Q?c9tw8VV0ElcL1j3E5QEjZYaIUYu+UrJUPPM7Tn2XjwEpKp8+Xiisu6/RkTit?=
 =?us-ascii?Q?rJRtYMJmxMHvb+JEmyXqFL7NpiEpj08LKibSYcUIF9D2U+TGQyn/vrmW55/f?=
 =?us-ascii?Q?5aI0gPwnIYEN6QFe83g22S+1lPpoRhO4x+VFHdtHhElBkMmInszReCjCu28H?=
 =?us-ascii?Q?C16ZYqb6lfJFqeZYL9F3pmLGhrj8dR20816sVvKxXJjAaRqxpEsTRpLYM3nW?=
 =?us-ascii?Q?xpbkZ4LU/tQFBwxmLSzJRb8scPNjy5uYvlTAduOiwR1ghpIrbXVVuCPO5HHh?=
 =?us-ascii?Q?bPTmgAaD8DBvZ9eSWczPfomlTGk3qavXxtP3p8VwM+NIU2zMtKZXS7O44bkg?=
 =?us-ascii?Q?zdJpoa7XUySpE1Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iWr1qj0hnoPXBeRGC5MjtN8bPxUYlaOsRx4MYaXSsRGQDL//lE0SxBawf4ja?=
 =?us-ascii?Q?MNpTlrDEaA+2VJRZbz2ut0sjtdjaRTOyxQWRmNQVj+7AEFDX/sJ62MYQIBZq?=
 =?us-ascii?Q?d9iubWnQRdOXbAlFY5WcfMqYp2TCIu/mCGzDO8AzRfPxLv94SyRVkBFktdNq?=
 =?us-ascii?Q?KuIkI+xx/R4uaYzOVybgCTQ+B5Mp2YK+WQi8Lug+Izc10RaxPNZgCcfXtTAS?=
 =?us-ascii?Q?l05yheCpkzsbVahRPUCtCA8ljdj/2C43lbhqkYLbuwP+WSALochcRAeyeXwj?=
 =?us-ascii?Q?+fRqFMUZDWdaqlceO71iNmEH7P5qR+2vYkDwKZ7AgVUCBqTXSgexCcWuCJ1U?=
 =?us-ascii?Q?nOK1E7Kd0yKfGlN2Deu6Pi31/45tbxD91YMJQ2/D4A7VI/NmrDuV8lT8pd7d?=
 =?us-ascii?Q?Pb2qNomujJo7bKt+uaRVkPuwZqmCJLevte/uUSTMJm3EWWWoHdTqR4Bb9C/Q?=
 =?us-ascii?Q?s1oWfmTR291WXQHJMcwMkfBHyGTkldW9sKQXyQtHsVSh6ErNRfOxbUQAE4RD?=
 =?us-ascii?Q?Vt/3tJ1A5wHEBDme/h1z+rCaToFFSY4r4TMwqN675iCfPwOuytZyn0wLNETI?=
 =?us-ascii?Q?hOeL+4VCjSE9jMf7XtjmVrEp/qkfQdc1S3pQqokIs0q896xMsvmOPT3Gcb5k?=
 =?us-ascii?Q?sDsSzMxoQd37qDYuB4k9mBP3M3DY3VdLhbvfdwFJIGsl1UvzbYpGU8uKkQlD?=
 =?us-ascii?Q?WEgsk1AoI9B3p4mcCZl4rLHmkaZJAR5qbQnAwlv8zWRU86//wwx9FdC4hJ32?=
 =?us-ascii?Q?tTMd/i3980IaznGXpaSk5yiJZQsSqsl7M+KffmasBcVhISyiOPUU21PTfXWm?=
 =?us-ascii?Q?BlF5GwSkm18q1gdx8ZHVO5lADkFf03f4EGyChx3o0cJzpPwNNDSEYua3Ty2N?=
 =?us-ascii?Q?XkqMEYzv/3auXw6Cvto7vZOeeUtfaK/8kSWebJUJH53dFnNwosLzM2OW1hKM?=
 =?us-ascii?Q?kLji3MvzEugiKACVZw3tTDBI1ddx/OPsQF4HGbZO8Z1XnbpPnjSD53jmDF28?=
 =?us-ascii?Q?prkURo0dKnUDvs5hM8xTu+xjNWduWAiRaF3ViXdXOCaR/p4D/850omYpjKVW?=
 =?us-ascii?Q?bW8tiThbHEMVmxmwA5QTZWVfUGWbDuo11R0e46FyGPS+fAwEwlntnbrR36Bg?=
 =?us-ascii?Q?+fWW1woAAc7veJ0fhd+rznSkn0jnA3ccPA+Q810kU1B2v8cAz0sMruil1axv?=
 =?us-ascii?Q?+JeQ/UKrpzY04ziKw2uMw6Ruybrl+yVJi2B6SScbU+UgbNoeAzQt2DnMMRhF?=
 =?us-ascii?Q?47jpqK81jfGzYh9IDPN+eStaZ2qJuOhOSDM6bRx6x3VVX//rdxg4xuTanycc?=
 =?us-ascii?Q?BZlxElWPM48fs3BFL5oxN1soA6TtJ9/o/fKhmqnbMOeo38xqoypGsE1UdTCO?=
 =?us-ascii?Q?nY7v/JZGEeIfih2v0m2D3t+DoS1HbxRx8lpEqqa0UwNUb/lF+uZ3gX8yPGJi?=
 =?us-ascii?Q?syVldMTA/Npj6YlXd4G418aSDg7ihD5pWt7p0W498ZzAjb9Tl78TpGyQSUGC?=
 =?us-ascii?Q?D7KDE1iEfpV9GcLENbwSjTKTlc5fj0Yb8RGT144dIuniOBnBiug2i+rWqTtI?=
 =?us-ascii?Q?681wbj8Y68WrjnrEqizYLyhpTeD/EMYjRlmxAECx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12a6c3b-bb4f-429c-5c6c-08dd9de6442c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 12:50:46.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxWbaCKNiun8YzfVKoGcZB+DEvikynRLlmncdrHd7NX17izOIJEhtGLX6sJut+GJdmREcoXFctbkNQG9g0cEXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8883
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

Hi Andre,


> -----Original Message-----
> From: Andre Muezerie <andremue@linux.microsoft.com>
> Sent: Wednesday, May 28, 2025 3:33 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan
> Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org
> Subject: Looks like a bug: operands are different enum types
> 'ibv_flow_attr_type' and 'ibv_flow_flags'
>=20
> Hi Folks,
>=20
>=20
> Compiling with MSCS resulted in the warning below:
>=20
> ../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287: operands are
> different enum types 'ibv_flow_attr_type' and 'ibv_flow_flags'; use an ex=
plicit
> cast to silence this warning
>=20
> It looks like a legit bug. Here is the offending line:
>=20
> 	struct mlx5dv_flow_matcher_attr dv_attr =3D {
> 		.type =3D IBV_FLOW_ATTR_NORMAL |
> IBV_FLOW_ATTR_FLAGS_EGRESS,
>=20
> As the warning states, the constants in the bitwise operation belong to
> different enums, and these enums have overlaping values, which makes the
> bitwise operation very suspicious.
> On top of that, I see that struct mlx5dv_flow_matcher_attr has a field na=
med
> "flags" which accepts values from ibv_flow_flags:
>=20
> 	struct mlx5dv_flow_matcher_attr {
> 		enum ibv_flow_attr_type type;
> 		uint32_t flags; /* From enum ibv_flow_flags. */
>=20
> Could someone more familiar with the code take a look and make a fix if
> needed? My goal here is just to get the code to compile with MSVC without
> warnings. I can add a cast to remove the warning if this is indeed how th=
e
> code should be, but I don't want to do this unless I get confirmation tha=
t this
> would be the right course of action.

Yes, I think you are right. ` IBV_FLOW_ATTR_FLAGS_EGRESS ` should goes to f=
lags.
Thanks for the reporting.=20
Will first try to verify how it works even with the incorrect initializatio=
n.

>=20
> Thanks,
>=20
> Andre Muezerie
