Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD1CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 12:39:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EEE643703;
	Mon, 15 Jun 2026 14:39:53 +0200 (CEST)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazon11021099.outbound.protection.outlook.com [40.107.57.99])
 by mails.dpdk.org (Postfix) with ESMTP id 6AB15400D5
 for <dev@dpdk.org>; Mon, 15 Jun 2026 14:39:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMkWjYQDNV2mZXMPv5DHYyOonqqUCds/bosPB/pI+CMx9vSsY8cFZgqALao/2yhV6V4w3NOZfU3oH9NqKG8cg/au4lCt0WH0Z3+qhs6fr1sILLFPfPdrIPUTiVmND2qT/zV6s2Xzb8Zhx30Bf5Fv3P+qt5s2l1Mg/XYXY4arpKuTRuaNMPO/20TrrQdWEquE56QRWV7YrQVNgwIeUOFG7pyz3p2H0iAPlDJiHydVNGduPvmNq3AlFijV6sG5Bt0T0DxezL5BOe/AbcRBmJwq5Or61+GC4ZYW9hYVWbLFYPc/mJLI/sElBoPyWgKcz0HJqTtEjfL2vLzu200uVaM1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wc+CRAEDYQshrhjdJGq53sxmQPGMuJNsoO6IYS8utG8=;
 b=UZYvCHYvnmN7kmEXM/uSrXsrEjGX42vLs7ue9OKhJWcWZe1pxbtsqqmf3nWHb054w0atIVQha1IVP0YMh/qQce2z7c5oK7aDU+wXuJjIlB9btkhBh75/a0ItL5lnxkalacy4dXEMD14qlbaHe6tKQhT6hXcMo2hk4FE0KzXB+zCJry2apFAgDnnuCDXQL5Q/AWqUb0APc9MjBvd/2n1fc74Te1kl5JwpW3JYe/kXXCA4NIoaoXKm0sPl10kYho2pU23iIL7bHMAvFSu4uXaI2zZ3ZQdW4hMHZ44TG4Co4/XSBl1cUy1OR46+Flm81q/ne3/Wij2BiLsjIg09gsxaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amantyatech.com; dmarc=pass action=none
 header.from=amantyatech.com; dkim=pass header.d=amantyatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amantyatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc+CRAEDYQshrhjdJGq53sxmQPGMuJNsoO6IYS8utG8=;
 b=BR1by9tXF6HqI+V0Yn0DxAwchWrQ3ljVCNskuyTeed5o9F2S2DTxmR2dVMQ9VjGRtChWp4RoVm9k+OxCz5/NHXMTl3BiPSXGY9HK4ZDr3aVG4+NWL8JyeXVSgP4WNkcD1pS+OU1rl7HXn3frlxQBZDaSKOITjXzq3FMjb0xnHRQzW4KWJxG9C5xce8e4bkFQYtPP8XbWc5O+ZHeXz5mk3zIKDDs9GsI83u17dUb+NNuhWtcvMQn6ZFfNkpKcdohwa/uqyXGNDoukTtZziyV95aXOFUBJnLG0YlAElvby+Q4GtjQZvyYHDJvSFmlMWqIEnxPSlw087qRjhlvEaaC9gw==
Received: from PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2d9::9)
 by MA0PR01MB10141.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:39:49 +0000
Received: from PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e52a:de50:7de0:907c]) by PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e52a:de50:7de0:907c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:39:49 +0000
From: Samyak Jain <samyak.jain@amantyatech.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: Vikash kumar <vikash.kumar@amantyatech.com>, Ankur Bharadwaj
 <ankur.bharadwaj@amantyatech.com>
Subject: Question regarding duplicate fragment handling in DPDK IP reassembly
 library
Thread-Topic: Question regarding duplicate fragment handling in DPDK IP
 reassembly library
Thread-Index: AQHc/MPFstdlbQvKQkG909Ypsm9olA==
Date: Mon, 15 Jun 2026 12:39:48 +0000
Message-ID: <PN4PR01MB114326CC09306DA93ABA7C2ECEEE62@PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amantyatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN4PR01MB11432:EE_|MA0PR01MB10141:EE_
x-ms-office365-filtering-correlation-id: 08fcd1a1-6fe9-432c-76a6-08decadb3045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: W79aRAQeBcgJMA5orrg+aPU43sOb3u9C7IfWFo4FbkR7YGFrCctW+IqcThKYpmkPEoXhwE15yt/ohAopuYfdPgYrMlykkpXhtxF+vdUe8m/9xfUkl82F6ga4MWdUsFFOwXKNlLwSigyWBq/7nTouOIM5TQkdBuBvS1OZIGEtipqr9t4GSpMRzOo1QTvwdjfVwHZdm1iV5xyPx5wjzetj1k36fKp8ja+TG5jvj/u17QZrZxwODVMYGoHrf/jqBRz88vaBLCDlwVJX2q7NBK9dnqx2b3Z5qRBKMCfFyCWf5+5FbHiEoHof49DNGI32pEfRjEjDIzMzXWA6hsFheBeG0+0Ly3dCOo0UA+OMwRM3MEcCrq95UnidURsI2ZeMAKcGuPUcHuPSp/SuWa9UJfJtpOr8Y1rWAdEPRGIJb78mjDjYuzIj1Ty7drFLUNE5GEh7dasR76zwF+hMEl9xj35itT/NbTClcRQxO8oVthG13459gIdLb6rlgR1V++gCk5hSVE1VbIDjISGlwljm7EFz/iFpsCXcLafrIfYjzLagm3St5+SJkGJGIB+e5G53U4X0y0asuGlpuBWeYdl/JBK+0EcP3XLbdbQtQwdyf+R+loGlkq4rRMoOzK0w5MQIm2ghRhd/2vxuxlM3JyEN5tnp9ifzu3iyi6rcF7QjdI3D00RKfh6bx2ziK3FCwA9oveUc+Ntw0Gsvh9gt6zbmOMDaXZfLsIu4DjaFediafLy12qnBaZjakhG7kNdl1pdy6XH5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E4+r/1ZuldvnWAjwZvsU6fqx0A4WfA1BSvC1kHhZYBjqCUWp3SRG/hlnGM?=
 =?iso-8859-1?Q?2gLUUww9wswX6NrxJ4FD3IU6wIG+YwKrTJG8dzERm7Y4HcRT0EZ2bN4+L/?=
 =?iso-8859-1?Q?MS0IM1DuIoOGsQ1hImciGecfKjAnGc+HvuIquLYXdMTjQRm1W0h/Wip1KB?=
 =?iso-8859-1?Q?fjoV613950guJW6qdYgmuU3Q6V7oGH9aFPDnuwEXrjLQ6RpWjllWouvc01?=
 =?iso-8859-1?Q?LYW5vxYD9JRJrC3nfmhPFPhLvnQ+2/kIYfRAdWTVqFg/oyyso08L1aCQUE?=
 =?iso-8859-1?Q?N+xInB4pcj8X26PeIYVdEYEXSHsBRKBtYBzK+YMG8/areY2XH1qSQm+wRr?=
 =?iso-8859-1?Q?ECIHHy5lEpBs6ZGDzI8nNrbV6xdjPpRH1VR2LcLzLWpY6qy63gUjYY9VlO?=
 =?iso-8859-1?Q?FyuSSoX/kd+gQ1KqtreMDV3dmSK1ICw6DXrULYwRzlNE1M1PBE96I/ORfV?=
 =?iso-8859-1?Q?uy4SUZnsPf8EOnc3/LBdFje92b1GxvWIXwZy7eL0/VLC83egoDvBVbj+aO?=
 =?iso-8859-1?Q?ZFlwPwN8SnYBEwdIU1HiWV+n33mxvcw3YAMdrDebtm/3us4r/KdJNMNu/r?=
 =?iso-8859-1?Q?pxagpWUy9oZjHNn4vJw8bx3ruuQ8iQYLWQ7AgQqnXpRgSj9KZg6Q0gEkMY?=
 =?iso-8859-1?Q?dcCMDuOT72jHkMWe1kO/fNAtRaxJCYt4frAIEW73mSha6/Tgp0d9zLLChm?=
 =?iso-8859-1?Q?9psKGSJiXaCTwqUnVSGC1zVcqlzzDfqDS+JdyyuAZBJuKfBqofpU7wFk1W?=
 =?iso-8859-1?Q?DPQISNZp6n+s2Lww8vf4wdtOCAeL0tIvnYvyr0I/gM8uJnGZUH3yMSUagV?=
 =?iso-8859-1?Q?JRzo3cHfm5k1SWGKsZN92rVIIiotvhdvJBARtI6Mr90lJKX8yT6QaSN/xO?=
 =?iso-8859-1?Q?uRzIa3Luq8Fq9oTMtjINvvC8Zg4RHfdwgM1JigYbG6NLImZQ3pjNCyNCLS?=
 =?iso-8859-1?Q?ydcDXcdOSTCb4WAC5OGohrNuDBwNqllP0gxvQHXZnOSQCPncRYMj0uDxto?=
 =?iso-8859-1?Q?KuM3o7YCHnA7w2nb+Le39QYAP4VlIEUmBSAMxCG7UJVQE9ICgn+B1UBuJY?=
 =?iso-8859-1?Q?GYRvUtj59ZniWu9T3PJVzia+cEsUcC3TX9sFue0OntJV7LDCGUkWT8MnLb?=
 =?iso-8859-1?Q?vwy11AK1kjoz4UHWGp0Zx3lwi66o+iMdibooyCwOJonSub1pRk8visgvvc?=
 =?iso-8859-1?Q?HDpXmmRO7s5+u2o4IqYXsDFF9o6yHTfgNwCmEQyEvvBVh+AtNrJREEm7zG?=
 =?iso-8859-1?Q?7zJkc2Cno6yDkoKQZxn/7KpF7xmmsHNBKYSztr0yRrcYxUqYMz70SpzcxE?=
 =?iso-8859-1?Q?4XBexFc/ADQGAb4VxC5ESDCUyJUHF+6KRatbfc0O57YenV24WLY7IDqDsN?=
 =?iso-8859-1?Q?lGLWfFLMaP93B03I3VwXeT/6Wc//h4+l8HF+9sl5HzGFcMEs622bIWHbZU?=
 =?iso-8859-1?Q?QivQVy6EtWbs9UN3kCRBPnwwRssY261sLLnX0AVhKmwpGXavfP4v7oW8TV?=
 =?iso-8859-1?Q?8Vn+ClCedMV0yzIalql0PfB3Di4jcKzPJTV0fZ0cSSBqUJ/BbN39QUdou7?=
 =?iso-8859-1?Q?AV6Crv66NlOjzLmeeAATYDRbiVlvra+Es/OTI9E4ZyvIKFGZfLEneh9fPI?=
 =?iso-8859-1?Q?UzjtBHGPDciGSsFs5ap8AdcWMlG5bfiPXaTiO6XWbSeYNayCU/7to4LrUQ?=
 =?iso-8859-1?Q?0fv+S1+ENIMkyN+P5fZy5cxLMG/yG7uP7zgmFAzn9lQydzlSS9kgBDRdtt?=
 =?iso-8859-1?Q?6VB6r259CW5RoVEKRh1ZoS/6RAyLEHRKHE51eaCn5hfydZ2XMMWRl3iQXv?=
 =?iso-8859-1?Q?d72dt27j5w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN4PR01MB114326CC09306DA93ABA7C2ECEEE62PN4PR01MB11432IN_"
MIME-Version: 1.0
X-OriginatorOrg: amantyatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN4PR01MB11432.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fcd1a1-6fe9-432c-76a6-08decadb3045
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 12:39:48.9655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d5b66d53-29b2-4452-ba0f-f8badcf5782d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nd2uAjIYylZvZ6BdsSH9xNUH5DfVdXl4mNeB0TF4jAFXOFGkR+wBLdSj90eRjM2205E60iUJBDmv5Og9WiiatKxyzNcZtzXsIzWK9wB6fyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB10141
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

--_000_PN4PR01MB114326CC09306DA93ABA7C2ECEEE62PN4PR01MB11432IN_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi DPDK Community,

I am using DPDK 25.11 and evaluating the IP reassembly library
(librte_ip_frag).

During testing, I observed that duplicate fragments appear to cause reassem=
bly failure and the fragment context gets invalidated.

I would like to know:

1. Is duplicate fragment handling intentionally unsupported in
   rte_ipv4_frag_reassemble_packet() / rte_ipv6_frag_reassemble_packet()?

2. Has there been any upstream discussion or patch to support
   duplicate fragments while still rejecting conflicting
   fragments?

3. Are there any recommended approaches for applications that need
   Linux-like duplicate fragment tolerance?

Any guidance would be appreciated.

Thanks & Regards,
Samyak Jain


--_000_PN4PR01MB114326CC09306DA93ABA7C2ECEEE62PN4PR01MB11432IN_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi DPDK Community,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I am using DPDK 25.11 and evaluating the IP reassembly library</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
(librte_ip_frag).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
During testing, I observed that duplicate fragments appear to cause reassem=
bly failure and the fragment context gets invalidated.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I would like to know:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
1. Is duplicate fragment handling intentionally unsupported in</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;rte_ipv4_frag_reassemble_packet() / rte_ipv6_frag_reassemble_p=
acket()?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
2. Has there been any upstream discussion or patch to support</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;duplicate fragments while still rejecting conflicting</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;fragments?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
3. Are there any recommended approaches for applications that need</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp;Linux-like duplicate fragment tolerance?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Any guidance would be appreciated.</div>
<div id=3D"Signature" class=3D"elementToProof">
<p class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em; m=
argin-left: 0px;">
<span style=3D"font-family: &quot;Aptos Mono&quot;, Aptos_EmbeddedFont, Apt=
os_MSFontService, monospace; font-size: 12pt; color: rgb(0, 0, 0);">Thanks =
&amp; Regards,<br>
Samyak Jain</span></p>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
</body>
</html>

--_000_PN4PR01MB114326CC09306DA93ABA7C2ECEEE62PN4PR01MB11432IN_--
