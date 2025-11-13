Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF0ECEB2E6
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 17:01:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87D47402CD;
	Sat, 15 Nov 2025 18:01:37 +0100 (CET)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazon11021131.outbound.protection.outlook.com [40.107.57.131])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE9840151;
 Thu, 13 Nov 2025 14:22:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqbSIk1nUO/eVHfoSvHY8+E9ekrAMgAOF1Z1/F8JNKUulhUwUoLeZclELVgrV/eVJS6jWOXyJjeiWDXgz9QbIbHSSV/yX/Qo5r62xmGq0sMDlQsjQ6YTBNyyZeCGCFIWnqPF1M1djx5nFYceAlfHdnOaA2754h/zQN9dYLsb3R6FrT41XRlgw1X0TvTnLwcVTSexc/JtXiDIK40TS2BOCUvHSmpReX7YYpJwVrdongYI3TQKOD+4MgrH3wy7Z0ox/rEw6QRsm2xuyJWlT/pK7YRAL/3LfsGI9x9mpro9gCktIO0RKyW+DmWdAk4jMn1DNsXgSyqwnlFTxFGO2sKhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ggB9miBwCJ67RK9cTG5WWSlPNNdyXmqJ2+Nz3Ajk0w=;
 b=qLVtOw1QfxaB5U9U6mUA67l4Ij9MrBUpvDYiaSMuwpVdpkx/l4yFYRkgm0J6cmI1eIfHWDE1ILhbRnHiSK63wnAGBKqGOo04UgFY33uESQ+fCg9rbV2igJffQxXD+QAsBx3NBzhksRogJTf2WVs/93Z6qerxIBJdnCY6jt0eET4OxGAXLL7+pSKRtUueAePFnERHQtOtSLd+AUbOG82YQTp5za7wA4ucA5rRn5qS0MONuAheXAZ1EC9dMTmVqYqRFCymIPFqY8Uxq0bM2h5tuC/6zS6yTXbvvlwqTtsZ9JjfhSmgVaAyMPN5ID9+z0VEs5G+2shDqa8vRYdegCkkzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ggB9miBwCJ67RK9cTG5WWSlPNNdyXmqJ2+Nz3Ajk0w=;
 b=i9R+h4+m7CcV/2s0bOCYpfib5cpqZMiTsgHciuKwyLj2P60SYjlT3w84WUiS4g2f/aWL7NmYyhHPuxdrYxu7/4FXivw0WStBGVPX+bvZ9kgJ0pzMOAZRbaJEQkOWF+kxSOk3zUT0Zf/VmVoX+8dsRXzfFMvfA7Tx1Ep8YCUXKmGaAn8g/m9znRXOzR/9BXFYCVUlPlwzIwbJHCgtL6po+nuV3WC+kT9jR9m7Vk/qh5U4Ak9hdzAapqs4SplC/dbF46kAJ0uPcDjYGZJEdFePyFsxCb61PxmWZkFbITrtgOnkeIltAeGdICULMCDJPcFDNqyFhy+yw6NWN26G4RYSWw==
Received: from PN3P287MB0273.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d2::13)
 by MA0P287MB0377.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 13:22:39 +0000
Received: from PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
 ([fe80::38c6:bda2:131d:d3bd]) by PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
 ([fe80::38c6:bda2:131d:d3bd%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 13:22:38 +0000
From: Thenveer Poolakkanni <thenveer.poolakkanni@iwave-global.com>
To: "users@dpdk.org" <users@dpdk.org>, dev <dev@dpdk.org>
Subject: Testing DPDK with Mellanox (MLX) Driver on Windows 10
Thread-Topic: Testing DPDK with Mellanox (MLX) Driver on Windows 10
Thread-Index: AQHcVJ16vMrrkwoNlEm9jTjhxF6+Eg==
Date: Thu, 13 Nov 2025 13:22:38 +0000
Message-ID: <PN3P287MB0273437664D5972D9B84EA8BB7CDA@PN3P287MB0273.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB0273:EE_|MA0P287MB0377:EE_
x-ms-office365-filtering-correlation-id: dcecd945-c8f8-4e9e-3319-08de22b7b7b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?DgTrb1bUbuBMQEzDe36RmmSgDL3vPoHIYkXSuBLpSo0YIINU5p72Tbv3?=
 =?Windows-1252?Q?92XqVs7qdBxUjgyiufHVdlzd+aW9lBPsuBva57Jgz0mtXknWqGFSC4W+?=
 =?Windows-1252?Q?Ic0WDcEkFR5xHvguvcxdgvaJPnSU2rUSQvbU5+NOqZraPA0zDKehlSVI?=
 =?Windows-1252?Q?md7/EzeUTbtu0xbWysVQAFdhIeJQiUj6g/1oMRNTMu+KqBr6tUKKtp2K?=
 =?Windows-1252?Q?QPe+Bzk3p5SaHHiBP5JbMaLNQ5G+I5q1FSripkOV3KDUlfvguwwR3NQ5?=
 =?Windows-1252?Q?faKpmZkAaRfGEMYwd1c3MS3kc0Z/XbCQcuqzWS8uaH9NYaQ0dbnw66Y/?=
 =?Windows-1252?Q?DSsFG7Pjs/hugyBv8CO92AkReuLu4pbYWsi9R3RE+rDBEXMrvBA9LqBH?=
 =?Windows-1252?Q?fYmk0WxvJ1IuSMEbDTIyE+oEugUAHCV8cf5JMETyRLMatXEo6devaP7x?=
 =?Windows-1252?Q?7tMB64+Eqp8513xLSj3IL9R81UeOOOLWkErc45PArU+lgW1vwUEU116B?=
 =?Windows-1252?Q?yrmWDlaSph5jMh9CuS9ZwEvIfmiAU2YZrFYL4OLwMosTC5zkNNNvCjrp?=
 =?Windows-1252?Q?q3l99z+bSDbMbDMpnsK13gbOuOQUqRGlN9MvDYl/CtkbrV281hhZ0jWg?=
 =?Windows-1252?Q?S4TLZngutYKebzygwfOLGHIC6DyqjfXyKn/dO3eSOoYVVLjoVHvlOIOr?=
 =?Windows-1252?Q?yee/m7Upi1xfakOgLYVOyDwjc8XyaadZlJ3nYrhqr/CiIE3e/WbS9Gpf?=
 =?Windows-1252?Q?tgInsWSlNxwKpdNPDwPPmOR/WIqdF/0PUsxxof1gyo055hhcnaxkhNpF?=
 =?Windows-1252?Q?6a77wTs6yNA4Ld8eYxiM7YBuXbT9Sgr6WhT/QHBJYw7FKHGIefLaEnBq?=
 =?Windows-1252?Q?Lahc63W3+fbnEE29rz5wIVTYPMHMx5VDEe1eK5eLVsultiZXwzBaqkLo?=
 =?Windows-1252?Q?807J2KuriyD3ukVqG+Lqc+OwWneEdIKiw8fkaXgbm0xPUWzWtrzf0UXv?=
 =?Windows-1252?Q?HUv19I3QcQe0OSnsOhnTdHwK2cjCNcWASh+55PhvB9Yg878QjHLb2MqQ?=
 =?Windows-1252?Q?r8QCR00Dm9WDdJu4Nv3yI1VFJiEHJt0GVBx9odtLbOIphLbACigg4qym?=
 =?Windows-1252?Q?E9UfrFmBCkFPVYiwef+8/PuPYgZtIBJLtIHcVkQz+1nFzWUG5JaJEmEK?=
 =?Windows-1252?Q?mMVYfn3E6IvOI8orlnCWrtkdEqe9W3EG/Hww2pg00G7RHDNo+wzdS1T7?=
 =?Windows-1252?Q?5+ehAWWx2tNoHn2QfNTuJpayumI8EG1Sf3Yx67T9/NaR7AHv3+QIbtaD?=
 =?Windows-1252?Q?qbaA1wYlQMW5tQwgLeA3i5AOVKMCljpf/+ifbzuCfA6XjqoRMtJfYlJ6?=
 =?Windows-1252?Q?dsjuQlknNezadDQV2Jtb50/lt3E352L+1RC8XsQpEhz+PX4F+MfMIqbE?=
 =?Windows-1252?Q?qkO0whFFMeALGHcc5nOaTHJp3mAug1pYm4sQ+1SsSNpvdwdOBVOv9Ppa?=
 =?Windows-1252?Q?eS41LSo4TXBdvgYSZumkLMKK04xlVrKqTRP5e8w74bxQgFWOcIjGAfeZ?=
 =?Windows-1252?Q?UxO7qvqqIKsV/GUknzt2A1Eq+hXovu/XghlkB59mOiJArRlctF76wQoU?=
 =?Windows-1252?Q?NyO+pKFl9OKZQKaJI0KhZ31K?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN3P287MB0273.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Vu4HhEVYuHCOIGodI8kpSVq5iXdY0HtleGNBPlIJKALs5EPQyb6neFQC?=
 =?Windows-1252?Q?J7zI7WnCf5pgmAfgR2kWIMVYWCZ1ISOpO7TupMcUK/49DCgxaqtAN4h8?=
 =?Windows-1252?Q?3kd4s6oWu1x8zINjbjjsfb/kXrtV+6wTjnoc5WcGIOXnnw75z5mEeK9F?=
 =?Windows-1252?Q?Q1lLHXzVvaras+3B9+y2eBc+rVohFakN4oncKYrF3nNd+8wJ1/MeBsaT?=
 =?Windows-1252?Q?2SRevgZyNQDx4n8QeCj97+payXLmoeoNQKjoqEta6IQY9dTIjY8WgAsa?=
 =?Windows-1252?Q?pMm0pR58vmn1pmOqhNadpuygnGQzbB9Gxq946Ls8cIMHiJEBghkJLAHw?=
 =?Windows-1252?Q?1T+WW9SmPq5gwDnxy10KT1WAap4CZ3OfgPGA1CuIGkGnWE27RrBYe8XP?=
 =?Windows-1252?Q?qSvRnoCGaSM6vssfoR7nbQYk5r2LqZc87NI/KIEAMHJU1rS410xNN4u+?=
 =?Windows-1252?Q?2lOtraSZdkyWkj1sV3LHfS1LaxCf/aI8IeFNkjOmcOyQjDTvmcCENnqm?=
 =?Windows-1252?Q?XTPqgRBogTeheg6DeR5yXh1PZj5UN7I/EwzlNIXueAlPNjeSK7gQTC3R?=
 =?Windows-1252?Q?57kwzIpvZO3vLIHXecSZxP6A7ut+uojOw6Mb7gHDIlieoUh2JvRIGf6B?=
 =?Windows-1252?Q?hLj+CMGxI28y/VArGnwr/pIdCXa/T1saFsk2knCmliHEP2+lpod1WNwc?=
 =?Windows-1252?Q?y3SsOlI6OiVMYOcYv/f/4BzPtspzm6hRfx3EcEIB9Jy9462N0UNcYQSI?=
 =?Windows-1252?Q?tja2MX4IZ0bjnkbJopzvLpSPQZ5e061E4BKDuEep7p9li23RF8Q/bJoi?=
 =?Windows-1252?Q?prFd8zBuDPO01GZcoL3hUGuv0XY0QChhHGPjttfMb0rubh46P3ZcI6v3?=
 =?Windows-1252?Q?/G09Wt/t7NTKKTkHLHvXu+9U6QUxOXButiySIRpnV4wf+ESDeCwxrp20?=
 =?Windows-1252?Q?RDdBLBWJZmMOJvaKy+S5BFcWIyRrF+MoS7rcoUsnaRh8RGoh479o9t8i?=
 =?Windows-1252?Q?Wfv0RHelqFqVV3DU6gxMNNsBjZN9OX2X8SwTKw6055cDmOyyDFuF0ee2?=
 =?Windows-1252?Q?sIc/ZbAzB0TaWV/IfokGZh6QD97HX40oTG/i80vBAQfN69tksmL1TJVD?=
 =?Windows-1252?Q?xg4NDp1boDxrfKCs7fxgqvmSNl/SjNerqcTjRpB0pVAfygw9lYccQXu/?=
 =?Windows-1252?Q?KJaDtVYFzTlESB0jtuGOt9DV4+reG1qyuEIUA3rr3JzszQU8LM3vp18l?=
 =?Windows-1252?Q?MNSLKj4JPD965330pTQ6yljdOUUa9ZOYBIrxy6SP19nux/qyUuWug69B?=
 =?Windows-1252?Q?kVyEHYfD+VqIMz6J7QE++Vt3tL1JNSBs2CJeUrxeQBI5ER3pqP3glYae?=
 =?Windows-1252?Q?3ovLGnDluQkIw02HCn3a21P4QjztDNP3jH5wWZbVZSuytdQnjw1gScFx?=
 =?Windows-1252?Q?JYhzIlJ9U0iK/szowr/8GPifmnne3WXrWlWoDtnNPxbP+7LZ2uwDWCaB?=
 =?Windows-1252?Q?nYU//aMiMhR3rZ76jHVkIsX0/3ErY44FjdQkbJJc3snfdSS4RxLuO5T1?=
 =?Windows-1252?Q?iDGJCfLk4Ue3GU25UhJ/XZVzU7vvrEF7eHly3OhPGWGqEop/wcGfyg0i?=
 =?Windows-1252?Q?etGp1ZjSkt7gtnf+mnptFIQ1y//8ABe8rI6XVWKcGAIGnFT+etbXn/kf?=
 =?Windows-1252?Q?/CrjatvBFigFAjpM679on7Mknn7c0ldRp3FEsPu2/P1mG/fKW6uLcQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN3P287MB0273437664D5972D9B84EA8BB7CDAPN3P287MB0273INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB0273.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dcecd945-c8f8-4e9e-3319-08de22b7b7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 13:22:38.8823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+XuV6dqiG0A9a0SqZBI+QZCzG1wQbEFq+1FQDMleUE7wwpZUzJdgqfXYCFrjve1RXOGTuDjuk9lQvjPEHiteEIhtJk1GTORPgVcy+fXS68PUhPYJ2s0yQ4JnIR3D6tO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0377
X-Mailman-Approved-At: Sat, 15 Nov 2025 18:01:36 +0100
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

--_000_PN3P287MB0273437664D5972D9B84EA8BB7CDAPN3P287MB0273INDP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi team,
I=92ve set up DPDK on Windows 10 following the official guide:
https://doc.dpdk.org/guides-25.07/windows_gsg/index.html
The setup works fine, but I need to test DPDK with a Mellanox (MLX) driver.=
 Could you please confirm:

  1.
Is the Mellanox (MLX5) PMD supported on Windows 10?
  2.
If yes, what are the steps to bind the NIC and run DPDK applications?
  3.
Any specific WinOF2 or driver version requirements?

Kindly provide your guidance on these points.
Thank you for your time and support.
Regards,
Thenveer


--_000_PN3P287MB0273437664D5972D9B84EA8BB7CDAPN3P287MB0273INDP_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi team,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I=92ve set up DPDK on Windows 10 following the official guide:</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<a data-start=3D"223" data-end=3D"339" rel=3D"noopener" class=3D"decorated-=
link OWAAutoLink" id=3D"OWA60fe863f-eb6c-3777-f250-80c18428eed8" target=3D"=
_new" href=3D"https://doc.dpdk.org/guides-25.07/windows_gsg/index.html">htt=
ps://doc.dpdk.org/guides-25.07/windows_gsg/index.html</a></div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The setup works fine, but I need to test DPDK with a Mellanox (MLX) driver.=
 Could you please confirm:</div>
<ol data-start=3D"447" data-end=3D"635" start=3D"1">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation" c=
lass=3D"elementToProof">
Is the Mellanox (MLX5) PMD supported on Windows 10?</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">I=
f yes, what are the steps to bind the NIC and run DPDK applications?</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin-top: 1em; margin-bottom: 1em;" role=3D"presentation">A=
ny specific WinOF2 or driver version requirements?</div>
</li></ol>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: bla=
ck;" class=3D"elementToProof">
Kindly provide your guidance on these points.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 1em 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: bla=
ck;" class=3D"elementToProof">
Thank you for your time and support.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Regards,<br>
Thenveer&nbsp;</div>
<div class=3D"elementToProof"><br>
</div>
</body>
</html>

--_000_PN3P287MB0273437664D5972D9B84EA8BB7CDAPN3P287MB0273INDP_--
