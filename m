Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F26C44524
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 669B94028A;
	Thu, 23 Jul 2026 10:14:01 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by mails.dpdk.org (Postfix) with ESMTP id 2CD454027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:13:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqKd+g1XBt189SFhrB7Rl6ATBPqlpQHLsaFiQj+4DOw1ZB0wygwl+Z7vWW1SPl2Fal5q7Q+Nj73bawLjAGdq/hewnDpu2z8GYn06l1rUQfgBETbDyg5HH1K6QPzvJcJpx8cWDKpnCTfoEyibRTvsOXMsBbTTGJgVPrd7t5WxfMMW3/0RNakRuzr9bJFAbBDK/zahEVmENCbC19zx0U2UMDiDBmyiU6wJ1qbVxL/sAq4lP0jBKG8rANDag1FT5hU8tedbfs5nRnNty26V0y7FpwWTdol21fEgSswEyRunIz0UJvJbxlWI7Ny0Dq3ttAKr0QNfwDo7fsczS18WpSXE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kM2q/VWbnM3bEmnznfL9b0phMSgTSJJrrFnoQ0rjb4=;
 b=RMoOxQa73FCrlDKUrlHjm4xWhILKNA9vxMJH31Xa5838S/Z8IdqTKhS7ol22NWuHwxpEKaGl9c2MRrDM6GlK9rugYxBU192RvPVCXLcxQ7BlIgIHDT1Ur4YoRNHG06Zo//C3hyi312ZPW450bd+Qqpbkc5HRv6XiE7pEgfhr0JtV1B0qw0Tv6ojS99akAbNuJ6uOVunGochbKRZ5AB4c+/qg8OYHUcC9QKkyQJeCh1UJ5RfhOl9VVt6bTKHlIP1WAAglKIaGchdUdllUPYxepJQHhapFZLhnYUV6ut3ZEs4GHcf1nEEQIdWOmtUzfitx0878+pc37kBbRJlZ+83y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kM2q/VWbnM3bEmnznfL9b0phMSgTSJJrrFnoQ0rjb4=;
 b=HF0znQWZyf9YSd6xACRXD3YXEFjs3A4c9cdrBzmsXAovaDzkACsiIyDGIJ4d4+uDp/TWfuxx6h5XdEDLV4SOHiuAIh/Bgk2rywpQzqwwm8li/FLrBx9HQrXoFHL1pnwpODAh0B8smm1/5YzpI8aMcA8jBAJpg1qVpMUpb+hnD4M+GkPJJnMszePsPhQV4pxjf825Xl6lBLqreWU/Cu8uFfx46v2qGWylivXnGwqSFAvFXRdwXdzhI9Z/UOz6Wj0FRBaWIBp/k9JbB5K+0N734CGmlAy5JhXQtjciA+LbKjF2TVMyqIIOHrW8/Xmkehl3gpO130/LL+aQtJPdEV9/Yg==
Received: from CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 08:13:55 +0000
Received: from CY8PR12MB8213.namprd12.prod.outlook.com
 ([fe80::fd94:2b57:9d34:eb51]) by CY8PR12MB8213.namprd12.prod.outlook.com
 ([fe80::fd94:2b57:9d34:eb51%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:13:55 +0000
From: Wael Abualrub <waela@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, Ali
 Alnubani <alialnu@nvidia.com>
Subject: DPDK release candidate 26.07-rc4 testing report
Thread-Topic: DPDK release candidate 26.07-rc4 testing report
Thread-Index: AQHdGns0tAwaU2DiSUqCWFf+0v1WHQ==
Date: Thu, 23 Jul 2026 08:13:55 +0000
Message-ID: <CY8PR12MB821328D1F1E697312A477990D6C02@CY8PR12MB8213.namprd12.prod.outlook.com>
References: <kvNGsDZ2SLOK2WFaq05qOA@monjalon.net>
In-Reply-To: <kvNGsDZ2SLOK2WFaq05qOA@monjalon.net>
Accept-Language: en-US, ar-SA
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8213:EE_|MW4PR12MB7167:EE_
x-ms-office365-filtering-correlation-id: 3433d38b-6384-4395-16f3-08dee89256c7
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|8096899003|13003099007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: dgt16VrVqjSYosmXAvutYGL9HQyL6CWN7rcM0ZSUB11OQ9Gx5yrXbfrihRNj6sRuee78SloOTYqDnOFC6untL6n0KacnVjHAKiMChe0QknHAAkguHIB13dpeNbMcsyuVfshdlHGKsqzd4q3Sd8mUkYAH5gLrZlosp59JtFWSxMncF41Ra2El70Y+M8azwqC8y7AqrIUrHEL8t5Nx9C9mDc99ithuvUQWK09YqvrLOegG7acjDcYmoR64mycl7/7an/zadhIwYMTSIoeikgsEHOhIH6mqhXJjfB2bLTukpYwO5Xc9w4Zey/UkyfIjp/TWSLeoggZaXwgaqiMzjppBBjlODHWPTURbqWuRjH302wnV5Ctf0VEY6eGzDc7F4bq8lT7KrjJh2zgK/SfxXQYHyfpaEiGrGW+OA0RgfKw3wo/03Ti3hc+pHydoP7SAAx6zJlVZiwguZ3eHSMepYDSCWb7KaOcBLrU2ARvDdLb5HH3PYKTUl1nQTkzyRLMZVq3YO0t09+Z0VQsURPgxinv4IBlM4B8+LrLOBn5Vb/q7h5aG7XNXyvQ4Ot0+ApmcQr2fiIO+dgoIzZ1L5PP/Dkeo6uPARUps7tMACU4WOowYt4hhlQ8p/zstQstzG5jYoiLPv2xFC5a6seKXh8nPGHPE2Q+Hr2Nq9L6kIwLWpanpExlYiPZHkI6cssedc4o5VDCSs9s1sjGovLKQ7jxM5ElZpgKPkXz4Ri8aMU0tfV+Gz1E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8213.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(8096899003)(13003099007)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?ICIuNyErTbXXOVzs7Gyc9sERzEnJkDig6fDvru9AUoNdyJ7+uLNJAvPL?=
 =?Windows-1252?Q?CUSzNfLIyQzREjLPKNM0L1V980YcoB+iK+nf1dZl73flnQHWvoRrk7GD?=
 =?Windows-1252?Q?fKWO40wgmblRwvmJe1A3bnt24nQMN1j2vdAszGCf+8SyGLn2LnER6mGj?=
 =?Windows-1252?Q?eXktz2G3wDfUSMp6kBBunWbvwS3ywoJoNKyHc4VSgEgXvtLFvI66Vsd4?=
 =?Windows-1252?Q?05u7yDcQt98E3DnOJD5j2OIEHouWM8e2BgPRcKjEpKxbvS1ScAj6priz?=
 =?Windows-1252?Q?7xtI3V2G03inb0NG7eSaXxTRZq2vh1vrBxVlmW8paPVuzifjCPL8u6db?=
 =?Windows-1252?Q?dRoIl1n2xvtkraSHHRgWOTPNcut5qn0sO+GM275P1Yn8cIWucUWLvqpA?=
 =?Windows-1252?Q?xrZRS2IMMveFJ4R+nXbpr1G707n6ChGRF0/o+FCzZwDbz33KQQwYH8a8?=
 =?Windows-1252?Q?luu5Nid0S6i0vmwhHmoz4jFkusq9Oqtdi7W6YWlGbAODH9iXMZGfZS49?=
 =?Windows-1252?Q?uPRkBcz5LvA/fUftEoLanmGKPJWt+bJocaXD+gGCsorLCsJWGlekCeLF?=
 =?Windows-1252?Q?CiTycYp9ZKMWkUgsHiqYhbxyrFGMa6El39D/ZGVxXlTxkANigTZwoPmi?=
 =?Windows-1252?Q?wI/uTtkw+DHOu4hyM78wAjJPSJ/ccT9Ocmq6mIFQUhT4i4sn++CBv1aA?=
 =?Windows-1252?Q?leNzS9XSGn+5xV89vqCaHAjo47VndIBzwHsVZw0K3TC9+b/vqlJViEpy?=
 =?Windows-1252?Q?1bK7AxOJ3yyMBHswqUduEcCgXmrpvX0EPEBoo/q19jTm0o8NUJCgM8Rb?=
 =?Windows-1252?Q?DDVrue/+bVSVEOt6vLUrui8hM40ilY3lurg2shyomQZQ5Fy1otZgK9PG?=
 =?Windows-1252?Q?F/luwpxNZEMf97Mwfeurjg/f1ZmRxGHgQbhDkkGOLLr1QlyZdX5CDbho?=
 =?Windows-1252?Q?D0hJZ9ZwtrdazZpzA6YNFuO6f49VBGptuA2nxqmhjQiKJ59fa7v88GD0?=
 =?Windows-1252?Q?LqQ9tt7zdgBA4Bs5flXy9lwTp1QaxcSvCEoi6zAA6mQS5/ZFMB6totyB?=
 =?Windows-1252?Q?QwVDaSpOxr6Z0o0yCothQF8/O/Dq+QNp7xXie6OjpVuoV3TNb+VxAoD1?=
 =?Windows-1252?Q?sNz7+mculNV+bjEgId536miuhfKAJAZ+0E1mNUHW9qJtjF1Q9/hta1oB?=
 =?Windows-1252?Q?O23luGYLATmWDksH8wQFygsqKGB6y863QvvkFxtMYzztQPO0jJmrKuF8?=
 =?Windows-1252?Q?204ay6CHnwUO2wlqzlLJf6NfNnQL/QFx9ys+Oq0HAKc+DjEOeftJplO1?=
 =?Windows-1252?Q?JMQH1imJ+q7no6IvLew0GDsdcmY3qdB5wM1iGocGMUtTCm99sa+2fLoI?=
 =?Windows-1252?Q?sE1OCeNpMVWIvhxm9DZD7XsGWL0dipS93hsHFMNr2A8SK9lQCkiP88A7?=
 =?Windows-1252?Q?jvF02o5/qIORx1W6ih8D3fD1I5aUCBE+fFNc8ExGOmFU/l2T8Oa+swDt?=
 =?Windows-1252?Q?G6VMcfOp6VWFEQKE1dZdS8t3bVTsNfJPfNTChMQkXyREsNrlOlzpMKe0?=
 =?Windows-1252?Q?JD1o1255Qocbu79ZQipdZzQiwTKQAK+hcvgV4y14E4u85tJS59l+RCHY?=
 =?Windows-1252?Q?DZyUEWnaFEI3LTDDFMtG9C20LEYfO3Bj+IXc5yQJHeUJw8HsBERkL+Zq?=
 =?Windows-1252?Q?gbPgyqoq5cOONxNL2HQmU+DIP7JwpLA+b6ixWvlvRvfjgjfH/rfoIIO4?=
 =?Windows-1252?Q?TKnyzoFRKhy1Uyh5Shlo2jqyBLQKa6WVMwHMgr2phaO0vnXFUJ2e1W/V?=
 =?Windows-1252?Q?iYUNCZ7aLP4i55RBPbbqT40fJDVIIHOqPbwPec5YTRAKS6ls9UPcQuDC?=
 =?Windows-1252?Q?vno8AKH/2ga9DA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB821328D1F1E697312A477990D6C02CY8PR12MB8213namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3433d38b-6384-4395-16f3-08dee89256c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 08:13:55.1303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5M4k61ncfZY9u50I2unLLHeIkizEhXcjCw2lP0ZSM0qba3iJemcty9Gg54rrYHY+5Aj7K2KLR5jPz0+qpaRog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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

--_000_CY8PR12MB821328D1F1E697312A477990D6C02CY8PR12MB8213namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi

> -----Original Message=97=97
> From: Thomas Monjalon thomas@monjalon.net<mailto:thomas@monjalon.net>
> Sent: Sunday, 19 July 2026 at 12:53
> To: announce@dpdk.org<mailto:announce@dpdk.org> announce@dpdk.org<mailto:=
announce@dpdk.org>
> Subject: DPDK release candidate 26.07-rc4

> A new DPDK release candidate is ready for testing:
> https://git.dpdk.org/dpdk/tag/?id=3Dv26.07-rc4

> There are 48 new patches in this snapshot.

> Release notes:
> https://doc.dpdk.org/guides/rel_notes/release_26_07.html

> Please test and report issues on bugs.dpdk.org.

> You may share some release validation results
> by replying to this message at dev@dpdk.org<mailto:dev@dpdk.org>
> and by adding tested hardware in the release notes.

> Only release notes changes are expected at this stage.
> There are some deprecation notices pending for review.

> This release cycle should be closed in few days.

> Thank you everyone.

The following is a list of tests that we ran on NVIDIA hardware this releas=
e:


Note: all tests are passed, and no critical issues were found.


- Basic functionality:

   Send and receive multiple types of traffic.

- testpmd xstats counter test.

- testpmd timestamp test.

- Changing/checking link status through testpmd.

- RTE flow tests:

        https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offlo=
ads

- RSS testing.

- VLAN filtering, stripping and insertion tests.

- Checksum and TSO tests.

- ptype reporting.

- link status interrupt using the example application link_status_interrupt=
 tests.

- Interrupt mode using l3fwd-power example application tests.

- Multi process testing using multi process example applications.

- Hardware LRO tests.

- Buffer Split.

- Tx scheduling.


We don't see new issues caused by changes in this release.

Kindest Regards,
Wael Abualrub




--_000_CY8PR12MB821328D1F1E697312A477990D6C02CY8PR12MB8213namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 11pt; color: rgb(0, 0, 0);">
Hi </div>
<div id=3D"mail-editor-reference-message-container" style=3D"color: inherit=
; background-color: inherit;">
<p class=3D"isSelectedEnd" style=3D"direction: ltr; text-align: left; text-=
indent: 0px;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; -----Original Me=
ssage</span><span style=3D"font-size: 14.666667px;">=97=97</span><br>
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; From: Thomas Mon=
jalon </span>
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0); text-transform: none;"=
><a href=3D"mailto:thomas@monjalon.net" data-outlook-id=3D"61fce69b-2cd7-41=
aa-9ed4-7e395f64e908" style=3D"color: rgb(0, 0, 0); margin-top: 0px; margin=
-bottom: 0px;">thomas@monjalon.net</a></span><br>
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; Sent: Sunday, 19=
 July 2026 at 12:53</span><br>
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; To: </span><span=
 style=3D"font-size: 11pt; color: rgb(0, 0, 0); text-transform: none;"><a h=
ref=3D"mailto:announce@dpdk.org" data-outlook-id=3D"6be14792-e469-43e1-a8ab=
-5cf7b5d6ee78" style=3D"color: rgb(0, 0, 0); margin-top: 0px; margin-bottom=
: 0px;">announce@dpdk.org</a></span><span style=3D"font-size: 11pt; color: =
rgb(0, 0, 0);">&nbsp;</span><span style=3D"font-size: 11pt; color: rgb(0, 0=
, 0); text-transform: none;"><a href=3D"mailto:announce@dpdk.org" data-outl=
ook-id=3D"a12e111d-481c-46e6-b2ea-40d22435f917" style=3D"color: rgb(0, 0, 0=
); margin-top: 0px; margin-bottom: 0px;">announce@dpdk.org</a></span><br>
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; Subject: DPDK re=
lease candidate 26.07-rc4</span></p>
<p class=3D"isSelectedEnd" style=3D"direction: ltr; text-align: left; text-=
indent: 0px;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; A new DPDK relea=
se candidate is ready for testing:<br>
&gt; <a href=3D"https://git.dpdk.org/dpdk/tag/?id=3Dv26.07-rc4" data-outloo=
k-id=3D"70277262-38a6-4800-b481-e238ac17a9f0" style=3D"margin-top: 0px; mar=
gin-bottom: 0px;">
https://git.dpdk.org/dpdk/tag/?id=3Dv26.07-rc4</a></span></p>
<p class=3D"isSelectedEnd" style=3D"text-align: left; text-indent: 0px; tex=
t-transform: none;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; There are 48 new=
 patches in this snapshot.</span></p>
<p class=3D"isSelectedEnd" style=3D"text-align: left; text-indent: 0px; tex=
t-transform: none;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; Release notes:<b=
r>
&gt; <a href=3D"https://doc.dpdk.org/guides/rel_notes/release_26_07.html" d=
ata-outlook-id=3D"e6c4c842-177a-47e9-90e4-c870c0125ec9" style=3D"margin-top=
: 0px; margin-bottom: 0px;">
https://doc.dpdk.org/guides/rel_notes/release_26_07.html</a></span></p>
<p class=3D"isSelectedEnd" style=3D"text-align: left; text-indent: 0px; tex=
t-transform: none;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; Please test and =
report issues on bugs.dpdk.org.</span></p>
<p class=3D"isSelectedEnd" style=3D"text-align: left; text-indent: 0px; tex=
t-transform: none;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; You may share so=
me release validation results<br>
&gt; by replying to this message at <a href=3D"mailto:dev@dpdk.org" data-ou=
tlook-id=3D"f322ba03-33a6-48fa-8fc8-3887de39453c" style=3D"margin-top: 0px;=
 margin-bottom: 0px;">
dev@dpdk.org</a><br>
&gt; and by adding tested hardware in the release notes.</span></p>
<p class=3D"isSelectedEnd" style=3D"text-align: left; text-indent: 0px; tex=
t-transform: none;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; Only release not=
es changes are expected at this stage.<br>
&gt; There are some deprecation notices pending for review.</span></p>
<p class=3D"isSelectedEnd" style=3D"text-align: left; text-indent: 0px; tex=
t-transform: none;">
<span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; This release cyc=
le should be closed in few days.</span></p>
<p style=3D"text-align: left; text-indent: 0px; text-transform: none;"><spa=
n style=3D"font-size: 11pt; color: rgb(0, 0, 0);">&gt; Thank you everyone.<=
/span></p>
<p class=3D"PlainText" style=3D"direction: ltr; text-align: left; text-inde=
nt: 0px; line-height: normal; text-transform: none; margin: 0px;">
<span style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size:=
 11pt; color: rgb(0, 0, 0);">The following is a list of tests that we ran o=
n NVIDIA hardware this release:</span></p>
<p style=3D"line-height: normal; margin: 0px; min-height: 15px;"><span styl=
e=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; col=
or: rgb(0, 0, 0);"><br>
</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>Note: all tests are passed, and no critical issues were found.</span></p>
<p style=3D"line-height: normal; margin: 0px; min-height: 15px;"><span styl=
e=3D"font-family: &quot;Helvetica Neue&quot;; font-size: 13px; color: rgb(0=
, 0, 0);"><br>
</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Basic functionality:</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>&nbsp;&nbsp; Send and receive multiple types of traffic.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- testpmd xstats counter test.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- testpmd timestamp test.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Changing/checking link status through testpmd.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- RTE flow tests:</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>&nbsp; &nbsp; &nbsp; &nbsp;
<a href=3D"https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-of=
floads" data-outlook-id=3D"cdcf3236-e239-41fd-9fb4-4f350e56804e" style=3D"m=
argin-top: 0px; margin-bottom: 0px;">
https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads</a><=
/span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- RSS testing.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- VLAN filtering, stripping and insertion tests.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Checksum and TSO tests.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- ptype reporting.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- link status interrupt using the example application link_status_interrup=
t tests.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Interrupt mode using l3fwd-power example application tests.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Multi process testing using multi process example applications.</span></=
p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Hardware LRO tests.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Buffer Split.</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>- Tx scheduling.</span></p>
<p style=3D"line-height: normal; margin: 0px; min-height: 15px;"><span styl=
e=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; col=
or: rgb(0, 0, 0);"><br>
</span></p>
<p style=3D"line-height: normal; margin: 0px;"><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"=
>We don't see new issues caused by changes in this release.</span></p>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 16px; color: r=
gb(0, 0, 0);">
<br>
<span style=3D"background-color: rgb(255, 255, 255);">Kindest Regards,</spa=
n><br>
<span style=3D"background-color: rgb(255, 255, 255);">Wael Abualrub</span><=
/div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);"><br>
<br>
</div>
<div class=3D"PlainText" style=3D"direction: ltr; font-size: 11pt;"><br>
</div>
</div>
</body>
</html>

--_000_CY8PR12MB821328D1F1E697312A477990D6C02CY8PR12MB8213namp_--
