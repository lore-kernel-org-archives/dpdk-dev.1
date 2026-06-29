Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F28C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:59:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7010840613;
	Mon, 29 Jun 2026 07:59:58 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
 by mails.dpdk.org (Postfix) with ESMTP id D1389400D7;
 Mon, 29 Jun 2026 07:59:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYkampmiAjaQLqfef4Cmp605lxR3FBdbP+vzL7vrdaEqHNBXgceU6TgOOlPIUNwXQC29T/Y1bCL6wvVOgJ+GJetYWMFupaZZCB7cDQ72iwXOi6xOQ+IBfGdyBo3G/asPi2DFzzjzB/A1FVHDE9E2tprfBtIzx5A/nyFc7/q5nmMf6AT4RkNc1l+W8zqUGmOeiMnAUtp0AF9gENhIFrwoOdHr0E41fJJRIGyERj+1sCQLpI5WrsqaRofTn+4QMnreTof8Uz1tH9BsfhZyvbU0/P6V0MdSmQMhrpPFq5A7syh3LKlD9oH1csNF6ScBQ68FPG7vntN0bUUyKzQeCjoYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=VFscxrvWkjruPf7iWd5kR+NBdj+2LjCWnmmZrZ8qWkssbTKjIAFkkkaqkGNe0osto9EJf0I3XRjp36K1baI03f0uEcZMgJwe7eX3ZTwMa5qQqcyTXDEfr8NvrMc2vSzIM0yIHS3yZArOZquBF2RhztpdPo//+syUt3WNDotu51tfqGALENm4O0THHS+MOCBEzAoaso+nbzFbMZJtJsuiO2lebcd83e2ThREp0JXqykHDfvRRyjg/bkKMVnHWEeAkf3m5hf43rgqqtHBuIW/R/XgRKG/HQBTAl37/ExYICZgNQRkjQa8c6NFtvhuo4ku3JLs9dBHEqAcWpNWhhSYtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=L6shElWjOL9A+4+E77NETGHB+9Pulxfk4/Znt/4eQLEM23WK+GXprJQIyFzWrwJn61y0tyDyxLCGYXyxE+ERNLDmfq8I61r52HmEhVapFc0jA/u8nMDOfK1ZP9oiTvtUOHSBTwDaRRb50VsUwROJ5KfhaExbi+JqIzwbIhMR2JC9kKOEatxD7Ej48lqdr/1FZFBimEwulgBNJ9ZFXp/o4NlBHO3TbDU720l1c3CneZgncbV2BVF+0XbRqvbVibQpX7zqcETN/igIuigdrXrGzUM3QwCGV5A38gXGZbvlfeBhlAxENFDOAnzJhxTFdsRWJamYBIm72yIv3Rgi/S1gRw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS8PR04MB8311.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 05:59:55 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 05:59:54 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Weijun Pan <wpan3636@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>,
 "stable@dpdk.org" <stable@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>, Weijun Pan
 <wpan36@wisc.edu>
Subject: RE: [PATCH v2] bus/fslmc: convert queue storage macros to inline
 functions
Thread-Topic: [PATCH v2] bus/fslmc: convert queue storage macros to inline
 functions
Thread-Index: AQHdBxKvxq58SX4wkECHL06EcBv7hbZVCsgw
Date: Mon, 29 Jun 2026 05:59:54 +0000
Message-ID: <GV1PR04MB10750A9D7EFCD56CF76670A4789E82@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260407141928.9426-1-wpan36@wisc.edu>
 <20260628152553.46342-1-wpan3636@gmail.com>
In-Reply-To: <20260628152553.46342-1-wpan3636@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|AS8PR04MB8311:EE_
x-ms-office365-filtering-correlation-id: ab72e88a-639e-4d61-50b8-08ded5a3a466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: tCJTKtDnuWatgAQaIbBtKsNYEroVIGgprrCkZLtuYORngTWwUQ5aJXpPxnFOcH14QbRUq6mDV1KhHiQ735F7cr/EjXrkxX5Rsfc63ZnCNJqD21AowSpxqLzyfRCwSp2y3fWhTpc77v7Q0oiKmjJ1mTK7X02Hhm+PUPBbwWdfVs2JkVc41rJGFUOKj3g2GE3P5iH2NiJJLf+jVX9JoTidqr17QoZPlL4g+JvglzfwGaom+X0bor6G08uptdat6D2/gFwBsSUbkBD3wkxZQ1kRAT/6m89rKm8xN8ACU5Pkils+MrMWN2wD/xVlAWQTFrgHMQOzM3t0GgWui+6lWP8DY48S0vrGLa68bkQK7f0zhcvW8VkZdaROc3Hho9VMyDDv4KzIjdTSOFmEShACTE5EOyL1iYhDECPJAdkAfeh2Ut8eVv8tloFa0WINoDB/uxOLtNZWW9Tr+syYQoBs5f1qwN5gsfRPxUI8lYYGc6LjA47/FqrF57gw30xd0rW6399t4ZYPUix6uMuNnPgSdRMcULx5/SLH/jG3emvLuNvEloq2+8NBFPBpdLq542YYDBsMJQj5P2UKiVBwsXZanJa4/xrDSXUKj7R98hLNoqLsFYlXOW91Pa1K8PIaMLbNtJhz1q3Fu8wbYrdSwG/tZpNYgpibMzAF6ViaxGVqWxxft0L8wez7ASS86sZwBEjypwbnzLglFxmYN86H38juhSQV2ETlQj0932al6m/XktFS3+I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CU0dr6/7QZ0Yxh3WYnP5uXz0yh4SAl+dsw2KNwSLruVaiC1LIUazmTMNoPkT?=
 =?us-ascii?Q?CO55Tt7A7bH03B+WEHUHzGQGquDVN+9VRxn16lCQ46R8y9ib2+chXYQUPO2o?=
 =?us-ascii?Q?JoGjv+h1h6SA4JkeB8fzxz6/XL5vRfh/fo61QqLKuyTqpDWmGA2kL+dMADy6?=
 =?us-ascii?Q?PGCRvuIpBtdJIFWuagwpEmXp4LThlb0fjtNaus/onof09YJSg/ciqJ90IUeW?=
 =?us-ascii?Q?Z+Vper68XDWNdO+FmHnochH18Xvpj/ATVxYZ9+zl6VYWZc8LPscLeK1yNlF+?=
 =?us-ascii?Q?1gZhRSZdEeKyG42OFGsBXYWhPUCBrW6Q1DkS2mmh3j7ZQHRp3PVHB3fCPPE+?=
 =?us-ascii?Q?rnAZaD80tPnSt62CG6lA10uUzWfe8rcMTZzhxGQ0Q5FiLJBbCW1qQsbWT0ZV?=
 =?us-ascii?Q?iWgco+PDCqaPFcjQrnU3ZRcDUnS/qdUiw0c05CvdrVyBwtN4HRvONUll7dZs?=
 =?us-ascii?Q?14u4Q6hwrrkiwoBUecWe7l1MUdAhLzlULEXY1zlaVN3owQ1MpMhXfwm15igo?=
 =?us-ascii?Q?KxOFJ93d3Ki91+vr/uRaRQSwiDPkkIX8TUXp/cwp/ZpUtVZA+b55wHtyqOSf?=
 =?us-ascii?Q?SeKlUxfp6sr3V6LrZstYD6s1WhyPla1iqrKA2LBJ01MpDJjiTQWni+svMhCP?=
 =?us-ascii?Q?1EdzCHHamw1b5crnvD8UV6VhQTJaWfZZ4y/YUPgakGmozsmG6X/SNsUqg96k?=
 =?us-ascii?Q?XVkHLjDHpFvxDeA85mArdF50YBBe4xIclL4LCAd3KJHrYmQX8xnj9EQ4BAWj?=
 =?us-ascii?Q?4vVnuJwW++fojlF3HAJ0GK+DNcg4xoIXz3Urz988lOCk0O2oPtmTlk3BLdEF?=
 =?us-ascii?Q?7GhReW7oClmDJROAgpYEUCjMkJ4HuWgAvojKJ9GWoWHcHz3F5kSIf0sAbM0t?=
 =?us-ascii?Q?51cvZhJyCdrDp1i5KYXpPJL39ebLmplVPN5d5tR85MJ4XDA+cJoYbscNuqe6?=
 =?us-ascii?Q?PNzedAaH5IDY8ZLzV8FK+Hta4uKxsoudfOIg2HJIghgw5iMOXLol7WYygsHl?=
 =?us-ascii?Q?ObD5syCQ7a2lrthLFKAXxXoEnB4Oog+EwubxxiYdSsM5RU1RE5zH+BSz9rZt?=
 =?us-ascii?Q?Tyu4myc/6XFvRaWG93MQpuT097cGDra/VbiP7IrEUSqful+eibrir/GzsMSu?=
 =?us-ascii?Q?lDZmSPN+vg9NEUJUXeuUbw1kdWA+HuVj6z/hh/mcUVr8DxWX2FMqBkpD89Xy?=
 =?us-ascii?Q?jHWFwPo2tFCcwrSJSMSjyPgEpvFTMT7TRW9pXSeYFrZXJDXEeNp/Govzzxxh?=
 =?us-ascii?Q?G8VDG58oqHneFlIUXPH5RNXhYDQqtylPUkPAz15/1L9U/NFylFb+HadSFI/n?=
 =?us-ascii?Q?iCSOcgn5Fyx/vgqHQgzVHtICn1iOJZdq/Yed1eHL0acUfeB/lw3AOWt4O5wE?=
 =?us-ascii?Q?cnXyd7tSLEZO+ZzgtARtJTos6vQfOfxEs3w8Ekbq6DN7iMaLnElLX3zVez2m?=
 =?us-ascii?Q?BJIv9IySVtg3VcSANLL/WgN4F4Zsn18MV8aH0pV0ncGT/03sjzDS1pnrE4II?=
 =?us-ascii?Q?E4/sTLr+DHWwKRFftqvX53sLGt8ye+4pjlSk8UJjri8IGUTcznBu9bGay/FU?=
 =?us-ascii?Q?N6DxulUZhZyz7vy6h4De0oowjK9+SYPjYHVogLWmselWxSPTWKPikd5I3Xc5?=
 =?us-ascii?Q?D+XUJOsFxzeEW6emEEKejfvsc1cCFdqTl0GMRsZU0W4cla+6JaHl5tfEwW9v?=
 =?us-ascii?Q?4Tk0kVbnXqPpGs7CNGCuuOzc8dgIk4cAatVVHxqexf4lxlGUF2HzgdV4ydEO?=
 =?us-ascii?Q?KIszdBXuBQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab72e88a-639e-4d61-50b8-08ded5a3a466
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 05:59:54.7165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRevdrEd28GtnU6QzVv0auSZIn6NHdwE9Dh5rHa8/wcZ/RAQ8RYwsx+nL/c/MVzuxnHyI+eCwJhCwVoaP/Iy7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8311
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
