Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB5BC0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 07:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD1DA40E16;
	Mon, 10 Feb 2025 08:55:30 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2093.outbound.protection.outlook.com [40.107.20.93])
 by mails.dpdk.org (Postfix) with ESMTP id AD299427B5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 10:08:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5PvrakO/MM0wPiRu6779IP8tHPVsVm4SE9wO/l/Mbk6XQWQE/aOUIoXIIB0rrp6qWAbA+4GSRQfRwH2w3ajPL8zZ8C2QSU3G/0vJsjdGcJ73Tr0FQ2uC/ieXm/0HH71W5gdXUDW8ZNMPWDl7lZrwhgVI15l8nrFldi2DvcVzcwBCFWBjA1RMf8+oP/TBUESP0Uo1uWOlr5TFg7bCwTdOwuJhNp4FeDTjpG+149XokGEm7Lej8YoYKyjG9aY9MGrHKOdPQFrKVVi6PuIldgnJW5zPsWq9zxu6FoDVj8JyW3rMbVr3JtOokaTOAEDeyRBMYjGsI4ma/m6EtkmgPvdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opmdhVs80hpbGYmmXddDRm8eyRCcuUsCfOVU/0groIY=;
 b=rcdYSwZSuHNmeGXhwdvYJ8O8TZ6EpKPzYnyx6k25QL6/6uoB7lN9o0j+iN7xh4KCA0dCQI4QBTQZh/GfzmF+t94cAPrJpPk9lD5vOVC0NZo0IYMP/eusBIGFsHksh+YH1euasj6Ccn9CFpn8tnBtGVhweq4Wd1b63SKMTGwgAVl9Nu/wsbsGs/zUm+rSwayJsJQVqtSRCF/Rei0T0iZuoFgzRyUWfPVRitkNf03uTf1SL3vXmxtD2azSw7dXoH1CKSVENgQqKFZvY51kHh+9FMrTcIyBI7AqfPczIdyqDD4q3ilowPDvTek1lrI23bY0T0dvSUDPSRL9UVjvScdu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=b-ulltech.com; dmarc=pass action=none
 header.from=b-ulltech.com; dkim=pass header.d=b-ulltech.com; arc=none
Received: from GV1P190MB2041.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:170::13)
 by DB9P190MB1770.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:324::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 09:07:58 +0000
Received: from GV1P190MB2041.EURP190.PROD.OUTLOOK.COM
 ([fe80::be7c:b426:4c2c:77c6]) by GV1P190MB2041.EURP190.PROD.OUTLOOK.COM
 ([fe80::be7c:b426:4c2c:77c6%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 09:07:57 +0000
From: "Denis  Davidoglu" <denis.davidoglu@b-ulltech.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>,
 =?windows-1254?Q?Volkan_Atl=FD?= <volkan.atli@b-ulltech.com>
Subject: [PATCH] net: support Arista L2 headers
Thread-Topic: [PATCH] net: support Arista L2 headers
Thread-Index: AQHbdxq5HJBJUV5MQE6/ElVdtdDZDrM3Tk4AgARBpCE=
Date: Fri, 7 Feb 2025 09:07:57 +0000
Message-ID: <GV1P190MB20415A820BF2090AE8151B2BA1F12@GV1P190MB2041.EURP190.PROD.OUTLOOK.COM>
References: <GV1P190MB20413FBFFA4FC719AC6E982EA1F42@GV1P190MB2041.EURP190.PROD.OUTLOOK.COM>
 <4092617.3daJWjYHZt@thomas>
In-Reply-To: <4092617.3daJWjYHZt@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=b-ulltech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P190MB2041:EE_|DB9P190MB1770:EE_
x-ms-office365-filtering-correlation-id: cfb7dc59-52b4-486b-df75-08dd4756e9f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?windows-1254?Q?Fjk0AKDlAxmnZS8B2VklmrBMF6ilO2pO26sPYp3VSl2VtetiKds7qfoJ?=
 =?windows-1254?Q?q29exFnLFMibl52fIgP2s7ynmQIGl+9I4tFnrltiVNkVvSUFOQEJOl7V?=
 =?windows-1254?Q?B23w0YofKY7SYQhD4kb2JpixdUPm+c/AmdcCdXoVRdC13uv/66vovA7N?=
 =?windows-1254?Q?Ptlkb6Ai4iAgqQefWV8IeWWYwHWMgZbBtcIbv2/S0TfKiSfyZJWSntX9?=
 =?windows-1254?Q?AsO/EaChMLAg9N8dj1PZrwCVOoGwNUwPZ49ZTvbku/UGecY6ICMKCN07?=
 =?windows-1254?Q?SG3uN9YTp70YFjlg1ElxSC4DeGqoR3ICQnfItKL77doTauJRdxl4/FVe?=
 =?windows-1254?Q?niqRT6aSkVGTzXTjZlTOQODcigs9zt4kS7Ws+HnLdBvzeK1Ap7LI/w2q?=
 =?windows-1254?Q?SxSHJFK1qy7GFge6z0tAsRFlNU21GGid0ifRuX3gtsSFiC/MeqQ8t7FF?=
 =?windows-1254?Q?MhjtKzaj6FBCXLd/kXBNiUlFGUQmV7chhYeJkZa6SEWTADrF7ZFA4BcN?=
 =?windows-1254?Q?AgUuelOAAvTncMPifRQu1h5ZAO0DDXxvUyftdQ0pjnTFAiEdlHT+ntyO?=
 =?windows-1254?Q?fz47eNBGJuNzSvkwt4GRGnbkp5KUHqp+eGu2FgXiSU24v+10h1zAZSfb?=
 =?windows-1254?Q?ufKUQ7qKA9INeE+moINpYKcP0VS/agC3A/ax9wyckl9sxL2UMBNDxD8A?=
 =?windows-1254?Q?q+Q5OB0jQHIiZuEzzSULCl9D8UtkvSYGLkeQLZX+cfgliUjO+6B23P5n?=
 =?windows-1254?Q?hWJKX1JkhfHZIDJp59/HXFm+GGX4hB8pGok0VuQjYvYGtkeFWhLWNS5F?=
 =?windows-1254?Q?nK5B8QvQPqPVV5/KINhlGdDyNzfGhsjTAVT6DqqvbBD6r/Bt7sDVgh5B?=
 =?windows-1254?Q?loUsU/7Y7t86OwCwquPlSAtuy4yxrvHypcEizvljY8TLh45zZ2fwa37a?=
 =?windows-1254?Q?oKuRyfQtkArbwpYYeng/JLWx7hdP9RVJuXKlpeECDxHSPJKU87EzkNm3?=
 =?windows-1254?Q?YKvnRfosBRAVMb4q/B3qMRQ/Ro9SzuitGW3HgbAaZEK3fD4SEEXxTEha?=
 =?windows-1254?Q?+IUfhHiHVgW2MShCfPqg3gmPIV6eBLO85JO+wfMGhi5xYwoMKiuNvC5F?=
 =?windows-1254?Q?sL93w7Pt5Z0pF18eWu6UWcaEqisx49N5N3IHtcMX+80Y+qOpT6jwMUF7?=
 =?windows-1254?Q?TqKgs3MvQoncvn1zxbltoc421jT49hTAhnSZL054xmeYnlexpl/qnkHW?=
 =?windows-1254?Q?BTMEoHKnWcLzi10Aeh8he0JjYW9Lo2PEndtiT763YCy2pEOQ1GmN564N?=
 =?windows-1254?Q?2fCmXfVQzzKY2d9JGCHlBOZOQMZ4Uu4isxQZNuxcEpR6RJFRz4G2BEp0?=
 =?windows-1254?Q?uWIUQ0NyksJdes0OSOsxsT10rK0XiLtgxocmDP0yoA+xJWezxq2kUcLV?=
 =?windows-1254?Q?VYhKljjE7kk6MNQjUhGP9abbCEXWh0m0NtsGyfXN2Ge86lMfgTWQ4BQ8?=
 =?windows-1254?Q?D8u19Wdt3g7pASsSRiYOON13OS7/+6cLHRN2KOEpef4az30rmfVip6ND?=
 =?windows-1254?Q?i4QPa5yE2Bz/454f?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1P190MB2041.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1254?Q?Xsb8t50Ya2kJyIgZ9kNgK47CF+43XuhS2aG6XNoX6o4g8dLYuYU8o3mI?=
 =?windows-1254?Q?08lZC/N3I54ixaLPW4Gn7ZKYGKJ07I/GFDS7WT30LVtaxCmpXHgkuOav?=
 =?windows-1254?Q?yYzjeHyErpRLH+cOWyjMYDGQNWoyP8OYXGjIR40KxdsX7ZnKjSKe1J1V?=
 =?windows-1254?Q?/LDIlFH5gFcAmGjcDhRhSsmRF7y6Hh41IvLPWP5fecvHf946+UFkllXF?=
 =?windows-1254?Q?ZjXakxJub4kiKaATDie8JmqH3xnu7a+mQ2MnqUWWBpy0xzuN9HkmNI+J?=
 =?windows-1254?Q?CogiaZZNI5mjpysva3E17EzuiTBtZ3cPJTTl1yjuhpiUOaLCbngL3u/r?=
 =?windows-1254?Q?yEoTqvVNe3qEzSgW5tzpDlMemse02o7oqPXWtiCXdJcxhLHaHyskiQvk?=
 =?windows-1254?Q?hTYLgedVYJf1GxWTT5juzk9SpTxZFfcfj/1cuPX0JFBAXNVf7Y4Gpzai?=
 =?windows-1254?Q?ocFlRF9AoTi40LRhWzlR00tQHS27729spc1VnX26J8B7UtksH+CoH6iy?=
 =?windows-1254?Q?a8AJBS/UsTDEr4aXoJPpYym9AgtW3Qr+PquXBg9wxdkrEHMrroxwJR0o?=
 =?windows-1254?Q?880l64arf8kEObFrgqAje7zIGPekMU9ZfPus3Y14/Sdx+fy+ui/adH5f?=
 =?windows-1254?Q?9b2juryuNUnf5onzw0QAf3606wmEON63hHv9NpPrG0nvOn6nH8mYGE+c?=
 =?windows-1254?Q?rQGyYbmMtXBN5Ou8+3LHvgdpmMOU1tO2twnNu0Q6GbMKhFWVjl6FJzg0?=
 =?windows-1254?Q?5CTQIvcYhjwGdBcGdM9ivuG2iu1XR+M8CHmBjW/fVHCcb6H1UFHAJOEw?=
 =?windows-1254?Q?v4fESEho72jiTLt0ZKCNi7zyWgFp5bYN10EuIR7oEutYeEw5q0bT88Ba?=
 =?windows-1254?Q?APXUBNvF1p+YHKCLQB2fs6qyyptoKMvThTkJuGGpF0HPdYwbVg49LzOp?=
 =?windows-1254?Q?Le56U/KWJLssDtbZ3lED9jUMII4GkoUYGXd9TsZu9y7K/5OSkJvoSW6S?=
 =?windows-1254?Q?62p9jP41/m1iVXm6gOKWlbfHW56GQQ6VsM+qC2GDkfFusy7QLts3QKh/?=
 =?windows-1254?Q?K7AS8C7cRjCC+eGQhW4ErNTZvIYdRzkjHAs8wENvZZS6+Tlp952YAUJ4?=
 =?windows-1254?Q?2SfEyuRtuRpfaNvqkppOe8Xna6mrVK6b9dBpTcoWfpnxEKPwvGO8VYk6?=
 =?windows-1254?Q?sJ+sQ9K8b2FhAevAl5Bt76b1fE9YzjB66KczNStrC6D0DHwCkHysiwLp?=
 =?windows-1254?Q?aUyigmcSzXNpYzZ2MH1p0JkMNwBionYVEBzP0lWl3wvFc04UvYxiY9BK?=
 =?windows-1254?Q?kUBX9MBFM5x59GdAzCCUVBn9OT805Ku6hgLyHa/VJHiAL/QM0aurWQGE?=
 =?windows-1254?Q?0OzGlgmknS/jQh/2hg5z8m9dPLZF+ehGB7UVslIj1WXTdM/pqfgxn4YG?=
 =?windows-1254?Q?7V9BhKGVl+I3luwIEZvagzr+28ecN6SQCZYAodjRP1iPda2+6EM1Vhv/?=
 =?windows-1254?Q?XPp7RhXpN14NxrjK4R5qXzDI9SdWI9f3smrjQUYZYoOzUaf16Slz2cU7?=
 =?windows-1254?Q?RrTo9R9vx/TbS5E3SIxIEGVIpUJNutbX1Ij9ob2M+7UpKPfmxH6El5Ni?=
 =?windows-1254?Q?VoPCR9MhCoclSd3RnuG2nuaTCbXl3Aft98NJJ6CTc4JylbiQib8yOo7x?=
 =?windows-1254?Q?xH6NvgAOBqB//T2XFzj8/RsAxJpw9T4L?=
Content-Type: text/plain; charset="windows-1254"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: b-ulltech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P190MB2041.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb7dc59-52b4-486b-df75-08dd4756e9f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:07:57.4195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db7d47da-267a-4c33-9093-c84879076293
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LU9tuKFEI5mOEu/VV2KxXdKPvM77qm4ihLHdEPgltEiYpF7Ghr0ABMRJx/OTujjJsBsIFBjJQvB/4oxi7dcHia6HkznbfoyjCR0GOQ0Bi+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1770
X-Mailman-Approved-At: Mon, 10 Feb 2025 08:55:29 +0100
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

From: Thomas Monjalon <thomas@monjalon.net>=0A=
> I'm not familiar with these headers.=0A=
> Are they standardized?=0A=
> Is there a RFC?=0A=
=0A=
Arista Vendor Specific Protocol is not publicly disclosed yet. However, Wir=
eshark already includes a dissector implementetation and its source code ca=
n serve for now as a reference:=0A=
https://gitlab.com/wireshark/wireshark/-/blob/master/epan/dissectors/packet=
-avsp.c=0A=
=0A=
> I'm not sure about adding vendor specific protocols.=0A=
> What should be the policy here?=0A=
=0A=
Given the large number of registered EtherType=99 assignments related to IE=
EE 802.3=99 (ISO/IEC 8802-3) standard, supporting vendor-specific protocols=
 should be considered. Though probably not in the way I organized it, mixin=
g RFC-standardized and proprietary protocols in the same files. ./lib/net c=
an have a new subdirectory for keeping them separate. =0A=
=0A=
Arista timestamp is particularly valuable for stock exchanges due to effici=
ency. The timestamp extension is already in use at German Eurex Exchange an=
d it needs to undergo PoC trials at Borsa =DDstanbul, which utilizes Nasdaq=
 infrastructure. Some parts of it rely on DPDK and this patch will be espec=
ially useful.=
