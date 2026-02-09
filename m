Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD9BE81BCC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:17:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD6F2402B0;
	Mon,  9 Feb 2026 15:17:33 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013058.outbound.protection.outlook.com
 [40.93.201.58]) by mails.dpdk.org (Postfix) with ESMTP id A5CC24028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:17:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCPlSOI8az7T+ST5UqdrVZ8owlkSYUR7YsWrgKmKzNSI7PSnejJn1fPKbz8TpLRqCQi3xLkHC8nypd2S8iGMyYPKtVO5tIdR5OzgKfysdE9WRc7GTe81v/bxZXToZ5cvqFT+lj/96uDha9aam0XOEJiA1YG5+GejsRA19FLqJpL8Wcf2/xUS9CoQzxSdJO12MpZRMlcdLMh08OVYJYRXw5TtfnSdQRWvkcfoRVUOqr/1VanaYUp/KwdnHNMfbpNpXuouCR8NaoCmj0FlhVv+kYkgqKbyVo3WZWrPI2pqs3ZKpT7n34hWSzk6GTMqU1unje7TuXwatIp39XBzkQMi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QQmuVkw8CCInJ9NgXybSfucoMOkL3EkhT08oTBf6zQ=;
 b=FmIOALay+r/K98Xi656BJaXXWLclICk+NVWB6YUl/tRfchTqS25oBfwixH2YLYBMFld+yjBjVDvTY5cfBLRDDLXMAKqGC1IjHujXmesrszxCiw8PWXPJj0uGi5UQMAzuIAqTBLObWjANLzM7a6WI22VHf4mPKy5/pq7Pcuub3NmJyQxQfBuLEAEJi7FztpsjLOKxv/238K1Jj8tFRdVgNj5P2+F5vk+ExcFRuGvGfCPmFImw7KAwjbcbW+dkG8fS4wSmQt1f9npNAVZsJIpJq46BoXFzt2NhEaWvqSaLqfdElUCVToXBKICrk8dEtCW2zoHAq1qXR45cFhMJYqBVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QQmuVkw8CCInJ9NgXybSfucoMOkL3EkhT08oTBf6zQ=;
 b=Aj+Gm0Qy/13UAGwzqEjIvtLpo341vhvwG2mmVTeJOOUpCkVyKpY5jbSSesxVs3MxrRsaAHDjU+J9/e2I/mw9WTTx0bnPOIKp9+Q/upHtDQeFc88gxdu+pEed5yDnsYfyckEPWFt5YUmsr1gvIkOxHI8NybsUPzpSO1/pEvp1J2srlzSA+McDsHR+2Hs36AjurclZ4zTKr8tVPVtySbUDeXuHdyFajoPrXcfSXvVVQIhNM3T0Ts1QX4BigErRfW8LVYpBeUpo+8ftPp4iHCf0KGhP9u4liipyS2H006ATJisupRhF4qozTh2ppjHWVqS5vuqf+m30c5dlquDSSHxvXQ==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 14:17:28 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::3d3c:bcd3:d413:7f7b%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:17:28 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>
Subject: RE: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Thread-Topic: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Thread-Index: AQHcV5d2f5lwV3ChikmVEqm/sRDM67V0zcMAgAV6zZCAAKWcMA==
Date: Mon, 9 Feb 2026 14:17:27 +0000
Message-ID: <IA4PR12MB9763E82954C5054B794769EDD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
 <20260205084254.29f823c9@phoenix.local>
 <IA4PR12MB9763C7AB75A5B08D1FC30B0DD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
In-Reply-To: <IA4PR12MB9763C7AB75A5B08D1FC30B0DD065A@IA4PR12MB9763.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|IA1PR12MB9738:EE_
x-ms-office365-filtering-correlation-id: 9c11d5e6-6f9c-4b4a-1063-08de67e5f479
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?aRiFj9vCWh8J/TKgknlZbL8s6fWRugUb9KXNxOz8UewzuMmCvh3+tKZHwcXG?=
 =?us-ascii?Q?4A/AekHB6xSIt4aiAiEb9Ht0OGj4LiqvHeXAWcI+8ZNwO3kOrF8l7tjJJ8eG?=
 =?us-ascii?Q?M5cKlZjmbf1lalU2KYBfv6dTUV7V/FcbgE0lDJVhzFTbdjmmktyhy6V+f1mh?=
 =?us-ascii?Q?iM3b8z68itK1aCyT32gPRaURGw/SIq8Dr+CS+G2ATGhycMOxIO9G+nJXCkFB?=
 =?us-ascii?Q?1m+NOlCKQ/yfAa+m6kyfQGR8p39OvTEf0fPgjwIRDJV4ZQPJzesnKwjx/bqf?=
 =?us-ascii?Q?5peBAH3qIt84IwPirk7sfBOKrlGyuIhem62TUdfdblmBb25sonTAHRsCAOgo?=
 =?us-ascii?Q?RUPXIPPhmFkaCPwmLKGW85hKgWihOBT1mPXIzK4j4w1apmr22ktvkRAUUaOI?=
 =?us-ascii?Q?krHy1MDnec7EThMN/MbRAtZoGX9eZ6b3J+Kyf64oeRXYLE/lzensdlv6Xo/D?=
 =?us-ascii?Q?rntswBeZVbgYE86MkRVqZAKpF6RXcenjy76RygD0iQDTr7O9G5wYPa3tPVfB?=
 =?us-ascii?Q?sKhBIrZWDkbb0wOM2fi9v5IZ056DRjyrl1aQzMTymMsC7UK9jKVq1HD7uZfV?=
 =?us-ascii?Q?Q89Q3OxcZoxBSEcvvXxgFsXi0L9kg72Nv9Nsb/f1SsDbddQntepGsFNFnnCN?=
 =?us-ascii?Q?yjffOQ/FTXnh0L5ctBaGZXcDxGZq67vXbEGaPoFrDwdhkSynKN1vfMwj4+6h?=
 =?us-ascii?Q?rLbAhOtD0GCWUJtbdpyfbu6T4wv+MlRGjgkoVeKyE8hEE0TUVj34mmUAHf6v?=
 =?us-ascii?Q?IsUwct1sN6gAR5TBiR6qXuB6mn/dLUHmcXlKVfh4ueoLqtKB5ICOo4bg8cAR?=
 =?us-ascii?Q?5imgAOlkKAIj5/JuCRuqmF62YS4qiXrC+7jL8h0cmGBTEGEzSrcylf9udt4D?=
 =?us-ascii?Q?cVrgspI9RETkn2ckPMFxcheZp0qCTN80a1uKjOnyXXxlasV1PjZqV2MqUOyp?=
 =?us-ascii?Q?XCmBDxaKO/u77h/vzQPVjxcWZuuoP6K1F/G/3bh3Q3laOd6r6dSiZGlieCFU?=
 =?us-ascii?Q?QHXZMXo+WOVG1rdFbWe33dXSNdLRYBpdRzFZGruTM+4C0UWiXxXdiTO0xKzU?=
 =?us-ascii?Q?S6+DZwtHNS2CBmPCdHKEbtoczod5P2jefabj9vaFUYQvqqEI6z8Nyo1wSjeJ?=
 =?us-ascii?Q?8+8IRbXBnTW5XpFW7q9qEqXhc+TYCBjsms3/CJxoYjBY4fpC+NdnqWUFAQ+2?=
 =?us-ascii?Q?RRvCKB2VNeykAgvAxDvowC5V3ukRIXIyUFoZD9+zFe76NAAEo84QoTJsv7/z?=
 =?us-ascii?Q?6cay3XsiXxFc2g4Wu4i0mf3S8AnTgeNzNN4dmJfUwMOD0ZaFe+TsSNbVXIZq?=
 =?us-ascii?Q?qto/XuS8xrGTFNoDppRHb1DHhUFUc4E6lGwPMYsp8hkUJNMIWTdrMhUZjCHV?=
 =?us-ascii?Q?y5gaaodixaSByvTxw0QjGtoPGpOxcN0nScB6t+UdYElBk3WeSVZ1+6RLRk18?=
 =?us-ascii?Q?dmnwBj8cG1nQFdcpU3eZzav71dhAzJ1/sZdVhqeBz8xsdD0SVyEaOUiYU0rg?=
 =?us-ascii?Q?BXM1LChVSzxFOwKwjmv3aWyvUpEW9KFQmqvCgXS1I51Vaxvrd2OaEoBfdkm0?=
 =?us-ascii?Q?yMQwsNhAFolEwZirxKGQETdZKE7XK0QBrG67E/tvc+LIk6hAle1xF7xfygeU?=
 =?us-ascii?Q?k2D5NhhC81iZ7bOWZZ9VyUQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TXBd2scG6xOGrY+TU9gWVukVfnGxWPsrSyMHo4JxCg31ExfnZrRN6NiUae88?=
 =?us-ascii?Q?Oz4asVJC+F+IqO88bsUpVxvNWGzBApC3EvAgzXVMQzYDJ8POLZubWGEUNHpv?=
 =?us-ascii?Q?xdMphzQq0ULq6vxEo37EcgKoNGGsT9VTkvB8tExvFPAxwpKMnb96vCxdOh6p?=
 =?us-ascii?Q?C6fvercdjNbvP/RtBkYBkgMsu3Uh1VDlQ8L37UOCvuavah2gzQEv3m3rwFef?=
 =?us-ascii?Q?t0Tf1vG3XGewfEtegLtvyqDjhs/HvU7MOfxzu+cMV0luh+oZ6zU6Q28Ql6c2?=
 =?us-ascii?Q?ChhdLeibUAWDUuNe4/fDk9PsgU4ExABvhpNfu0PiC/c2G5cQoY/UuLeI2IQT?=
 =?us-ascii?Q?TlnKjX+7RPvqdhFypxeqTwgdBiqXC2m/4lsbRT6tsheTBMVcudZZsrm32OfP?=
 =?us-ascii?Q?GJnbsm95dCfWdSXhBSnIPL8PSI/tbvfNnag6+kWDAjhzIBNBHp7jTbyIwHjH?=
 =?us-ascii?Q?I2me+i3yfKAO3J5y0JJBtEj/EixsvNH0eQm4lDgs3q5zlvjs12RhJCA+/zdv?=
 =?us-ascii?Q?2GcPPkHfvBM2kJZF9lXyc7EaUFTkd6FNIZ0v6clIsDCBQoIb0cgCJiO/Zfux?=
 =?us-ascii?Q?gmMyzKoLr/H/nzTtkdCMe8pnPEDpWdot+MMaPqOMQfZnxFWwi6C7eMkOuVxW?=
 =?us-ascii?Q?9BjcSbp1+/K/J2DXRIUKJw2FOSzP3CfDWUlHjJebDhxhCNeWM17hYEyz2DJR?=
 =?us-ascii?Q?3GnF4p6+V10mXwiaN21ATlkUfoIvpVe6Hx9Et48Q5Ot/3dqlJMM9RUtgX809?=
 =?us-ascii?Q?dWaJZdoKCjQuIQTlI5e4NsMDRD/NjPmWK3dJQIRtLGniwxvybEnvatnb0gA7?=
 =?us-ascii?Q?9Pld52mNTiX2kwo0aLkC3vO2ZDp8uerPZdgRNG+HaiGwlGyv69GppCo4enni?=
 =?us-ascii?Q?s11l79QzqgrkS9KlK2+tYaY5Q2lqdo5N1ew35dZwJce8Cr8qAnyLg40Qvu2p?=
 =?us-ascii?Q?LvKULeynH/P3869OJvIfbCM/rLwdw4zdglCZYj4ZRlug/BMz4+cEbl2t+Eai?=
 =?us-ascii?Q?DQcxDwqsOB4SN01gwFk2C/VzdzW3p+q7bxUoNgT0yE5TVGS05bgudMtUbFeM?=
 =?us-ascii?Q?XY0BL8NQUeWw1PB9y5/3ej3Nkd/TOONtHtL2Jp010aXWu2HAye7HL+acXx6i?=
 =?us-ascii?Q?P7wIWRohR1DWsjZWORAQCqlXoYE6ZG8KbCxh8auxP7ylq9E5m9YCHY4D2znH?=
 =?us-ascii?Q?0cnsGNDPuouPijU7D/ODEOaA1sJySkJA5HWKHsu3YfANBinqPwxi/mYxWfCp?=
 =?us-ascii?Q?3ROh0s3X3ApY1puYeeQfjmuQcLRAH4kbYyb3uXKPIUVw8nN5gjexkFqcQSz5?=
 =?us-ascii?Q?D9aI4mZSukcFVn+vxehGmpVv3UvFCFceQVFDtbfR0oX7ROWHNyzanutVS+zU?=
 =?us-ascii?Q?qDbvgX4cUNYbgwOn9BeNnenLswvPJCUOq7Hrvx0U3Ea0+TU5WKFpSuzDn8TF?=
 =?us-ascii?Q?A55lMwIDaLNl7OVurhv95YVPbkajy2CpxU/7WseRKVxrUAMM8XqmFgnCWrZU?=
 =?us-ascii?Q?aOL7Ikvn0ZL8KyDdi4WhXQfg/Qaks6rzC41VP0zqTEYdKPiNGrwqtL2ca+8d?=
 =?us-ascii?Q?0Ikq90J5KgTakDVygHdePH/rYRRzBfBtyLGNtUyNH5vknpxWw1chl15WyyJG?=
 =?us-ascii?Q?loEH33nNsObeC/sS6PsPcpEKWMSeMLTBAKriyBI7EqcQMSMsGJKDAvCMKw2I?=
 =?us-ascii?Q?bj+ymEgx8YpwSBFWX+pj6qZXahO2pHGYTvXiCPY1JIpVSubu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c11d5e6-6f9c-4b4a-1063-08de67e5f479
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 14:17:27.9674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awSwgcmlkx+v0AZp4DnhCPwXTHV9Jv6/aXqJFF4TsceJiUbQ52cmSkjFocD+ycSDJH0RjC0gA8pi3WRy99eE1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
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

Hi Stephen,

Since there is no UT for the flow API. Such application would require some =
design discussions, and it is too short for -rc1. Could we focus on the cha=
nge itself and try to close it? Thanks a lot.

> -----Original Message-----
> From: Bing Zhao <bingz@nvidia.com>
> Sent: Monday, February 9, 2026 12:24 PM
> To: Stephen Hemminger <stephen@networkplumber.org>
> Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>; Ori Kam <orika@nvidia.com>; Dariusz
> Sosnowski <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>;
> Matan Azrad <matan@nvidia.com>; NBU-Contact-Thomas Monjalon (EXTERNAL)
> <thomas@monjalon.net>
> Subject: RE: [PATCH 1/2] lib/ethdev: support inline calculating masked
> item value
>=20
> Sure. I will add some tests.
>=20
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Friday, February 6, 2026 12:43 AM
> > To: Bing Zhao <bingz@nvidia.com>
> > Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> > Darawsheh <rasland@nvidia.com>; Ori Kam <orika@nvidia.com>; Dariusz
> > Sosnowski <dsosnowski@nvidia.com>; Suanming Mou
> > <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>;
> > NBU-Contact-Thomas Monjalon (EXTERNAL) <thomas@monjalon.net>
> > Subject: Re: [PATCH 1/2] lib/ethdev: support inline calculating masked
> > item value
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, 17 Nov 2025 09:54:07 +0200
> > Bing Zhao <bingz@nvidia.com> wrote:
> >
> > > In the asynchronous API definition and some drivers, the
> > > rte_flow_item spec value may not be calculated by the driver due to
> > > the reason of speed of light rule insertion rate and sometimes the
> > > input parameters will be copied and changed internally.
> > >
> > > After copying, the spec and last will be protected by the keyword
> > > const and cannot be changed in the code itself. And also the driver
> > > needs some extra memory to do the calculation and extra conditions
> > > to understand the length of each item spec. This is not efficient.
> > >
> > > To solve the issue and support usage of the following fix, a new OP
> > > was introduced to calculate the spec and last values after applying
> > > the mask inline.
> > >
> > > Signed-off-by: Bing Zhao <bingz@nvidia.com>
> > > ---
> >
> > Looked at this patch again:
> >   1. No API/ABI breakage adding a single flow type is going
> >      to work great. rte_flow_conv_pattern is internal so changing is
> > no problem.
> >   2. No need for release note for single flow change.
> >
> >   3. Do need a test to cover the new code. I know rte_flow is way
> > under tested
> >      right now. Maybe a chance to use AI to generate a unit test for
> > rte_flow.
> >      This is important because it is a bug trap to add code that is
> > not covered.
