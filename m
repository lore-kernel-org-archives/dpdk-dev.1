Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD09C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 14:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02D2E40DD0;
	Tue, 24 Jun 2025 16:00:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AF0334026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 16:00:47 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OCJrUr012209;
 Tue, 24 Jun 2025 07:00:47 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2124.outbound.protection.outlook.com [40.107.237.124])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47fux5g6k7-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 07:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyCsNbE/9p58v6VwoiEDApO3tdPUsy3X/9lV7hlzoCxPE50grcsJoNA+fvGfTe80ZWpLE5OtHOyzvbR5rmGkhW/BgxLkkNHe2Fb0ve55WWMsgju2Pt23EWl4AgA3dta3rOO78PKuLdOu5anJAh9D/H2Af0K9mBFZmON574xx01g5WCnyTiOyvmA41fQc02QDp0vLa+LSnmv0miNyQVWyhCzsXJE51KeMcwAu2TTG7B6/4JznZXNbiAsOXDAIXrnP5f1qkIkDE4JPxTi7jge0zZRwvqGJYnfBAdMXAcn/p/dp/vX1Z/vxw/FgwaxKiZthpKTu40eARhRfhhvP15vwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/bHTjJ2smmuZU0F7iFjhnzku89ZSOJahwCeZzI6paE=;
 b=F1W12nmaBn9+cl8Qp2N0Agz2LUkNwC6ustHDCGtwcMS2Z5PsTJpj2PNoDqVtTXqT6epnV7/sO6ZjzdTDp5YYLu6idxll02c47muDKvgCNlBsGvF+WJLTqMSc4EkAsPH/cCK0aNOSbdlvVmmdh2ma5LWf8aVWsO2zn/ACCq0+ZJMx+QYW9WMCGte0FGmLpaduAqASvsNbCIzs77WcMIMxCVlv5HMctQhwZx1yFrHoRuyc5HFiauBgeRDNVcLtj9uBcE5I/3E0rzXiz9789ahdJTx3zQ/w5XqAZptsNYjtisYHKfyDM/FOu29Vtp38M7zvNe9BE1u+qpCui3deySc08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/bHTjJ2smmuZU0F7iFjhnzku89ZSOJahwCeZzI6paE=;
 b=bewvH5qgkyMKiReM0TjQaiYL7g/oq9RFsJ5yLqiHLfa7PuBwq9mV66f+0vjWMl+O2aGaOXuJWsArWHuWl3aTthF5Q8rFL+3mePxJZJKC2FvMrj0E1WdiVa5D7FmLBcf6FbtwNzY2ql8GhJ1xhMasJejTX+6i5Cz4zHtPRmromRc=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6129.namprd18.prod.outlook.com (2603:10b6:408:27b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.23; Tue, 24 Jun 2025 14:00:40 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 14:00:39 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, "fanzhang.oss@gmail.com"
 <fanzhang.oss@gmail.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] app/test: update EdDSA test vector description
Thread-Topic: [PATCH] app/test: update EdDSA test vector description
Thread-Index: AQHb3oiqtlgGOScRj06P26Oz2s/5pLQSY4Pw
Date: Tue, 24 Jun 2025 14:00:39 +0000
Message-ID: <CO6PR18MB44848E95940FA55E95D49616D878A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250616063350.2507803-1-ssarananaga@marvell.com>
In-Reply-To: <20250616063350.2507803-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6129:EE_
x-ms-office365-filtering-correlation-id: b772474a-30ed-4efd-0976-08ddb327809f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JSAuOWz0VWi51bi/yQ14BkSeW0qAHevVpWMhlNTGyMLeiTX+Vb1Iju3SBBUO?=
 =?us-ascii?Q?SYvcRhz/uOsathT0+x0vKxN+LG/Egmkr0RDASyvwcFnvwD/gtb8FHvi4pFoO?=
 =?us-ascii?Q?ynoJsUg4JfbP3t9NdjZglUjDXkZzdJeSjiywfSXOQjlLD10U2X+Kj5N0PcOq?=
 =?us-ascii?Q?018zbSMZWAmMulUTD776qLZsWkDTSwzmxZCj+NSmGcIc9Tw3cWA49ofz8JSr?=
 =?us-ascii?Q?i5VifXyXCCyCxai5A0Yz8KiO80mxz4mwpdm6IQDE/dgG7BXJyK1YWAxPHa84?=
 =?us-ascii?Q?Ab/rbmcm1ne5fji4xYA1G4GzdGVTiwXYSB169zYO/Ned4mi4OSL1rkje+qtQ?=
 =?us-ascii?Q?QxycKHbIMuT5yKGrmCiVwSVJ2RQZbh1dFtaVojritMldn8koa+n07JvHlgbi?=
 =?us-ascii?Q?YL12ja1CtAOemA1CtrqEyMih4GfgQCBi4EhNjZMSGtZ1EvHzHG+uBxJEqyEU?=
 =?us-ascii?Q?GLrlYdhxXyAoH2AJMkhyij3MCBsJ58Sst7Zr5hVIIMT6OJ1KtnEAF3juqFEr?=
 =?us-ascii?Q?KflcXIK/hlMkWGHTLMH/XQ55hfrf8iA9f932Flmqyz7tqoChVn+HdF+0uSdV?=
 =?us-ascii?Q?4rueBdsh6PfZErvK3Nb7NeECeY98LwpnjUzGfG1THWK8+EpjYlAdMOi6D4nO?=
 =?us-ascii?Q?UINMvKN2Y5g6HAdQ5EFeQjAFBR+pHpZZthcphdUS9dX6djKUC9oINCBb+usm?=
 =?us-ascii?Q?dB2LJUbx9MDhSeAtgi/KDcebk+93CiTaS2U9IfXiHwqLNzYhhUFOL105uAhk?=
 =?us-ascii?Q?QlUSX5VqHNxWkdJ1Veo0eaqtWTqz5NM9vSv5Ium/pQlBStOoFSBVUmrtRk7/?=
 =?us-ascii?Q?ou4jici0qdX2uf5bNys08TtADF9biMgjx7Jvo1nilplOy9hn/9/Tp+IIbFh4?=
 =?us-ascii?Q?RQqtHrK+tcOAzMVGnWYxnSidtWvEuLB5fVNjjRnwH0RJel6H58D26Bedftnb?=
 =?us-ascii?Q?SCu3t1/cxQxJaz2qLPJPiImTZlFBlRJEG6XMpn5BgzzRXfcjdGpNLiF2Hq+8?=
 =?us-ascii?Q?EX0DCTSvDjhVDXL5wqQLeFMIFT39cEQfSE4LyQ+aRdVnZhP18cKQS5+DoSxK?=
 =?us-ascii?Q?4vIUTvxcvTGQAOesjS+QafDQWfIlTRGFryhlcdKu74wwHKGNGPFd80RleluC?=
 =?us-ascii?Q?HyDBDX2FurWHRdOiYyMeqg2PHQMTRPuDQmiKEZFEzkbNj3KnWD+6YjzO2R2D?=
 =?us-ascii?Q?WqPo/ryjBlCKtHh63HDLPrClzHR+p+sziqg7CUKXPMacC3Ag9lf8tl43reWh?=
 =?us-ascii?Q?rEXu0srGWsu+sFCbtnDIlwZR69Uv5uXOEFBcSIvdshPThRTzCX6MPhoF2gjD?=
 =?us-ascii?Q?Wq543iVkgEqlrcziayizs4AFX5dJXVkmXuzYVFR7DwRmK2oJ4jNLsOwCP8ea?=
 =?us-ascii?Q?DjoHdLi5MqTrL7WzLl7anHCkNRcbw4MUVxrvkbfrWPzv5TKtxatgl8tnOSpD?=
 =?us-ascii?Q?ECxvPGhnvUW7YxkmzJK6q7YaivQR63i+X8YtLtC3G2spz+/KpOyPP0JSXs3U?=
 =?us-ascii?Q?DFp7dmgSYGG+dPs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M8cbk4MktWoB3PpaYcjGlUQYi9bwqyPcfTwS4vRZL+bAd3awQPqvwMKhffvO?=
 =?us-ascii?Q?QQ+urwYJRVitfGKhLneFF+YUxsUZQh/9BX2Dn+g8DMeIQ+Q6u7kPKBhaco67?=
 =?us-ascii?Q?azAPKkvqbvI5OSxtxoxzBNC943hQ+enpw3cKjx93LhPfXDiOtbXM17uRjebe?=
 =?us-ascii?Q?N2Q593mayUuYuGnnmLkFS45+35SWyIfmXY/8Jar4lnZD8lF8dUrimw/Ewh8s?=
 =?us-ascii?Q?CulSrhk5B7oTAFJmwKPjcaVyHmT+MJPZL/dke5ndsDglmshnkSZBRkTOjpLm?=
 =?us-ascii?Q?2Vg2BXTt4TNFABPlzESsGSye8xdfjrrv/N72Uso+Koz9Zeb12F9F53WGaVKU?=
 =?us-ascii?Q?dueNUB++egUtGdjeDXjt5Mcu/+qHv80DqAU1vhTos5innByn1Lt0PPpEhilr?=
 =?us-ascii?Q?NcdB+utMCSWNRWNrR0NrbIdMRoQ8FkKltLEpK+WMseNvdJCrV2RQ/QPAzfBP?=
 =?us-ascii?Q?KBGdkGM8alX2xYFBwYkoA/TNUtMYUk3xnFYZjLPYz5P0zUZTZfAUHe+EXLUE?=
 =?us-ascii?Q?VUAqx2bVy/56Y8pZO4D/tLqbYcwovOG1lNyL1coUW5LckutdiHyb7fnJxpbP?=
 =?us-ascii?Q?+JFfUG5+H2uED7yduMFKzs+QFPKB174P3LRRjwextzgaCw5Gm+FExcu/ieBW?=
 =?us-ascii?Q?msSwQQ/3kN0C0G3yvV/KhvbDC7L0D/v/qAYLZFsVcxCP8vXurVXxm7mBUgNC?=
 =?us-ascii?Q?YMV6ZjqHyg0+GVPpsNUgkGVJxv8cM1hZRyMVN8IW6UEHa0GI6vJ7LVw9cJWj?=
 =?us-ascii?Q?Pyo1Al7oDsvfD0Cmc9rp4VYVUHoCUbdGWsjmSBnKL2qsQVMOqJ+++ZMiLsgl?=
 =?us-ascii?Q?rf7q73kEwkU8cPclQMSICXwosineZQ+Kz5tKAAIgbqIjklZfqo3vhgKUAaMp?=
 =?us-ascii?Q?3lTV9mRkthti5Y4o4lEedsadpvLMAZyTbzQgClKAXwsbs07gyp7WQcyud7pX?=
 =?us-ascii?Q?58RElDak4KNUL7RRW5KVLaX1SgurwCUXx4+f/pafjpV1mAX7wc5mJnCEcvmn?=
 =?us-ascii?Q?dJXl7+x4COdex8hJFfTV+NT5mPhL11GSL6XRJHHsYUsRXQPKzWIkuyLVd+g1?=
 =?us-ascii?Q?LoKxOmYG2w78RVMkpVVAJFLE4x3UhuxL+idNrhrJZL2hEHXMS0oNQLjBOR7n?=
 =?us-ascii?Q?A7MH/LBUeKdZJ7Bf8Nn7pW9+ijlfvl32xYhtgiNmUAgnFL5G3MdzP1wxnkaA?=
 =?us-ascii?Q?Rql9iSmhJ1AyWqBDkpQSpy6z4CqZWccJGtSj8f4wk11SHTo+dkK5lskeo4vD?=
 =?us-ascii?Q?EJ4uznGr0x/u73/RNLBl1PvkpeHM3z9h4bx7iHX4JfeMe/M3CnRdMRv9VNl0?=
 =?us-ascii?Q?Dy7Dyudmch9O9z0VSUWlPi1CuMVnJVQtzAdM1pU1rJuBqSUQ68V6QT98jFg3?=
 =?us-ascii?Q?J0ldCgT+Cjw1yZgjvV4ots8erIr8VVkpBf7dSclyCyo4+AR5A2Waoo3oSwQl?=
 =?us-ascii?Q?HTiPcIQJJoe39d+s1l9zwgr2HNgpZf5uKKM52QLI2jhMpWAsfrQH1eAO2xOa?=
 =?us-ascii?Q?gSiebhmIh2ar2fL77GWhm7DBfcwp784APbArbXjuTReZtCHmuDaHFN/f3sYH?=
 =?us-ascii?Q?kmPiAR+38dAGTEElI3AMPgdCX4vH9mJKEzwgqF8o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b772474a-30ed-4efd-0976-08ddb327809f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 14:00:39.8961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y6Jf5284sBXVJVkI4AKBHGCm3EoAZkgd0cBXED2KtHaCvRTf63Qz5n7MXbuRZdDq4yqYvUM79RsazRVy7kuYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6129
X-Proofpoint-ORIG-GUID: fH8k3380nkrTfvlaPJZDDRBjZTUl6gPo
X-Authority-Analysis: v=2.4 cv=JeK8rVKV c=1 sm=1 tr=0 ts=685aaf8e cx=c_pps
 a=Bx4JecnaPChsX23rVfvkjQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=yn0K7mMhma4_TiNU2RUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: fH8k3380nkrTfvlaPJZDDRBjZTUl6gPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExOCBTYWx0ZWRfXyET9c7wXVCKy
 dm9XRc4Q/rVlyV4+mKpeMCzdS2NYP6bl2YyIg99KhljfJc/Irca+B8J8iNMHjhwCaHMkSDMrK8f
 61mUdt6xRIoIXT8TQ1ZA6Mitd00+wIujqsC5xQD7KPF9MzYlCmrzx2qgQSeGgZqVb2HtWgQzLRz
 YbSCtHQO7f9lreQ4SJhYQeC49azB5BjaIrrG5TyiGDcDmwCiO8iUJ/DTw076u+2woQVR5wIwd7p
 XuVIti0Yq5NDMkvbes3ReUhMR2JYYbEMoltEjNq+fiF97g40xzwI34nTubW3NNOzKxv/KZe2erx
 6HPpskmRKqEHyfzIW1DuefvZi5Tjhk8e6FT2jQmwy8TNEq8kfGWD/dwHge/bX9cX7GT1n4s7Gla
 AlwCB6b6+Q9osZpRk5jqluIRwhQrV0He/iR3zhBDNWd3VsVb7o0ubrAY9PuvRkv+uQeyd9a3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
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

Recheck-request: rebase=3Dmain, iol-compile-amd64-testing, iol-unit-amd64-t=
esting
