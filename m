Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D61C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:20:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB87840691;
	Tue,  8 Sep 2026 16:20:35 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
 by mails.dpdk.org (Postfix) with ESMTP id AD3AF402DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:20:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM/rwxQJNrfrvsEFoVXDbw2rPiXGI7oPXSp3xulpaNtsP6xLUhYEi5RFEcPVPzcGI23cogWX9uvIfIWwCjrGRWP64vV6RGRHRJyrN/MJLus9wBK3MmfUhOy+N/ysgEun3Hn0+DU3jTbZoLVELxx7aWx9Bw/BYK3rhWCL2esb/SXz1rB5buo3hs5E4CF53Q0FkJm0zhmM8OIQXlvKVzeQDrdErQ54K7kcoIsTTNllSEcwPhcKj+leBRqfOio1IvQjYghyU2LIf9vXdOtHTT4jpn0iFuWClPisECzOHZ+b6wx6rObVaw1SNp2wfOt9tiKuuM7QvnUIBeV3GsMD3FPMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXNwXhsHOmLH4jIPu9iBeovKue2s99EB+3sE7zs4Ug4=;
 b=E8brM7ZJfJFKRFkrrn/69mFeNrB8DSKZVr606G2r45+wUOvR0GKNYFjJU4i1IZ+36Ro/jG4XjPclWWSDdOjsxu5zG0Q0v7onk8tSDO8yFfd+aVkQ8HNhPF1anchh1YrMMMgY7jn74KWTjYrDG0biRyfj9keErvpBGITl2+sY2s3k5nEuNDUKOjK5V8QKrOy2qmy03SGOVCuSZoIHIGlR4Nbkk4NxLJs6eVD1ZDogdgAK2iFv+xuow+RiWDkktQD4f1TQ4SMNWGyIo+C37Zby8u/oYAAow5lHChPr5f0xvTsdHcwEvsdpEjUk++Y7uFhwGQAaSFfsdiL79e0Zqfnzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXNwXhsHOmLH4jIPu9iBeovKue2s99EB+3sE7zs4Ug4=;
 b=kWH71koNlMEOfxCtTijLGzQvCKqE14KFxSDhy+KdV+diZ+KjIfEA+gIcgWr7J83grBkfuxb4ConygkywtDTgT2S7eDYQwJt2bnFQ+eyQMqazyVPbURSvVL2troDLvKF1pwX69MEO7hk89rgfzn3jF01XHucC7/1LySgiwRHM0R548hax+8Aok38SbHRZA1+S4W0oGP6R8NloXfoLXdrInamHu7VFxw6sNsSqWqbS2efEFHQyyr5u9bqD1o4Odd3J10sGKKdigP70RZL/x9U5AMZGU0t58w5LLuJvX+sVnNfpvcKemDKlRaaKiSq7K5V+i4NQyjNazJswmTqvjy93Vw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DB8PR04MB6921.eurprd04.prod.outlook.com
 (2603:10a6:10:119::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 14:20:32 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 14:20:31 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
Thread-Topic: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
Thread-Index: AQHdGqrBQQdTguvFZUapKxk3t1yEWbZ7JNnwgEH2qoCAB+lLSw==
Date: Tue, 8 Sep 2026 14:20:31 +0000
Message-ID: <GV1PR04MB10750F6665175D7DBA92489B289B12@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <GV1PR04MB10750F000EEB3E024D8BB456C89C02@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <CAJFAV8x3r8diykpB1wAGO06C6Q=nyz46PpxYVF4DOrqD82ysEQ@mail.gmail.com>
In-Reply-To: <CAJFAV8x3r8diykpB1wAGO06C6Q=nyz46PpxYVF4DOrqD82ysEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-08T14:20:30.466Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=1;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|DB8PR04MB6921:EE_
x-ms-office365-filtering-correlation-id: f6ebf860-487f-45c6-e48c-08df0db45731
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|1800799024|366016|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|8096899003;
x-microsoft-antispam-message-info: EoOqnjAG3wl2nGtLRpXvw7G6pN9nkFeBhZsYQ9h4S/kWtcWf//zOb9kTT6OwiXnwuoYPgE650C9G1ZdSOvcYKAhlowceU/ZxRmShH4NPppMYP6LsVXCkc3BfdOxY1R8TU83rGdLl6I2BnaPOS1FYefaOzBUkFxq1VfxkIzJAlPjQp/Gcyn+xAv4QAbiv6zft+LYgsmE3hKkCv8FPAVT2n3alAYcDnqi1WR7UpYLyZLuUsBE1N/k4POti3OFjBFA54BrKbRj7EZHlO2cHeB0RPh9zqs55wHz21yAAOmdxXPa4zi5MpCxb30Xbvy/kqRtFIYuZrJ4qFObC0jJ316Wb4Sp9cvNUHaN4xygG9KDpbXF+cfos4h37c02oiDWSEwvlBTu+iALSuVK9Jv8/yWar6eJCbx6fT+yi+r35WidwdgbNgktrGNv+tGqqPB7398x3Cqmaen0iJNeOR50gED1MPTrFvTZ8flGLR/nUa6uB1446vZ3nABUTCPfoKcPJaZ/wAPs4b8u9WB9VnG//X1qcS0zuwhO0p9zaIqm20QKLHXdhkG21AStNac6+iETBrmYZye+sXTodIvK8n6Axa9Tf3l3fbbM2nu9LJWchsBu3ylkQ99WIKjZTzF3PUdapwI3zb35tuBYDsji8X1yMYS2DQIY6lzD8/vrco/QW5Xx7Vqq88YJkXSSHOb0M6N0X3O1L5hbelx5Jc3pRy+bGGsN/dkDKWUheMszCuwZIKoUqaRQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qygHL92UT1qAAm4z8PrQT4um/gZvqRR67TTzzh/WiOfQGAKMwkuxpUa2py?=
 =?iso-8859-1?Q?X13AR1xNcOW7tV+nI7ku5/2IxgPNodLB07cZpMiC9AscpVIgHSnwubG8iZ?=
 =?iso-8859-1?Q?q2rJofpv4wOmj3qPhAR160zTWd0DeQyYA8tKqx7Ru0l+1IPsm6NXQJ0mE2?=
 =?iso-8859-1?Q?qydyz5PTDgCI3Go2xq3nBidgIdKQJg8yf2V/t5sNFTkeG8CLrRm13qSiBA?=
 =?iso-8859-1?Q?n519jMzMawrAnYjWgnGmsNcOHtOacGxk5JpV/8Z642UBandF7UK5gFxCQg?=
 =?iso-8859-1?Q?iU5ez+VgMFtGEICXBvFPDYiv+8xM7PqfRhRyOQfp73v7RWsHFCdxhayUFY?=
 =?iso-8859-1?Q?GhxQwCSMUkQ3qlA9jg1G34TUTVQcXtzBCiteuQhxPyXtcZTGoJriYR8sEI?=
 =?iso-8859-1?Q?oqn35ggLjoPeUJFnIIFV7WRq+LLr4de+jS4JyiPApM/s4SBia3HHZdC/9n?=
 =?iso-8859-1?Q?aJHWdC4Orfj+uQGjxFThlrU/I9d8Ppr8wWQFN32lR+44R5Bidx4YoQ08Y3?=
 =?iso-8859-1?Q?7Mnp7bYWQaHZLlNF0MnFgOyYIQfwpyNz1w1ySE5az7xXBMjPKAr8U4Z3XH?=
 =?iso-8859-1?Q?fNZaMuHXjSATbfMOqP47DHSqLlDCT3b7jVla4Wz4BJ2mVtuh2IwIsNCqgR?=
 =?iso-8859-1?Q?ZSC6OEne6C7eu1a/DooMzc/qopHSt4POomBFrLHk1DgFNXzuasBTuVBTWG?=
 =?iso-8859-1?Q?8pjdJB+1S0e+9S9xKBZOeo+NSYqVd3sJTcDHsn6bb3hZRe6HUJEoM0RseE?=
 =?iso-8859-1?Q?QrGaHogidKnknA+nh68tjmTfxYHzP1R1Aenl38YACHOpDsJoiI1MvNd5Bj?=
 =?iso-8859-1?Q?YCbogWRlTySFM+fUR4/RjxYl7VJuyUxq5mbpgIVxK/MM4/Xx5eYKN5eXo+?=
 =?iso-8859-1?Q?tqIF/OpEEeMPd3rK1QkBSwSNcA9/lMDIPS+FYDUJ4RUZpqKqQxNzCg40cV?=
 =?iso-8859-1?Q?HYzjIprmKj6pJxF2/+3Y5RGKPALFrKSWyKrZZmF2JmF0K7xXwEWf8/L40o?=
 =?iso-8859-1?Q?YrtKpLnqpJCkUYs+YORlOwHBqVkQEaib0kTEZhIf9XmC42lcsnplI2XeMj?=
 =?iso-8859-1?Q?oPcl1mS75K2MgDWFs8RjRUoZ2YIiGirtWoF7AFe1JYUq4FCWK5bd8W6F1D?=
 =?iso-8859-1?Q?su3SrJVYLbWs/4g1DocIYfD0q7Yo8GWIT/4AtCgk6ylNnDrxfIsF9q88Wa?=
 =?iso-8859-1?Q?UuarA03Fi9QQc4QaMizysZrqCMUEq8qNNnD3gcXYQXXoe03a7Bp73ABQos?=
 =?iso-8859-1?Q?wZjv+U1IyUf1yHDEAbgTJlX9sFHAUcUjDw4/vE+RW6OakLAaswLQF8H7Ja?=
 =?iso-8859-1?Q?bz9Wl7RVBc8jq0OY6binsqjg+RkrRjmld3kkvKDiroGtFEBahFEJ29/Rm2?=
 =?iso-8859-1?Q?ED/STozwNPyqblwhBDbjeVxpQWl1CNW2ObGl3agUmw5K4z8/4UMXZ7JtIv?=
 =?iso-8859-1?Q?G6FE85PVBd8m1rRf+YTAJFatQul5cmsNovWDbZOTeo342QmyS+jR3tZNoA?=
 =?iso-8859-1?Q?jHzNP/ljfGLO9MWRLbfk0twt/5If9XU6j2bmeYtySX1MXE5OEKTuQRFBOK?=
 =?iso-8859-1?Q?eNnu5ESKV/cWXoiCssaJXZyFC+7r+wVEHSfoXll2V8XNKONfCK8lbSk97s?=
 =?iso-8859-1?Q?GTZSYGIppsQd9J+nt6ak73VfsTAWhUeeyYwJeJWBC6eGb1tEWZPgQtwQkw?=
 =?iso-8859-1?Q?0/2RSKb5BPDuGa0OxollujWCqJY2Re6w8OdLWEGQW8PJeFmZcv9soMeHxy?=
 =?iso-8859-1?Q?b6XgGy5D0IJEQbZdSSgEumwkruFOVFsiijjkq/Ky98UXzcuAlVePJP3sy2?=
 =?iso-8859-1?Q?g2hGBT7UfA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_GV1PR04MB10750F6665175D7DBA92489B289B12GV1PR04MB10750eu_"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ebf860-487f-45c6-e48c-08df0db45731
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 14:20:31.7551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nL2htS3xyTRKJjxfJvs9WpljBmmSpsLCBH/Q6lVh5Ocfz/BtnBUXNQnIa8U59PDDWLLlS4wgfzeJBPAZwPPigQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6921
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

--_000_GV1PR04MB10750F6665175D7DBA92489B289B12GV1PR04MB10750eu_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: David Marchand <david.marchand@redhat.com>
Sent: Thursday, September 3, 2026 7:00 PM
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: Re: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP

On Thu, 23 Jul 2026 at 16:11, Hemant Agrawal <hemant.agrawal@nxp.com> wrote=
:
>
> HI David,
>         Thanks for the work. We will test it soon.

Any update?

We just completed sanity and a few quick tests. This patch set is not causi=
ng any regression.


--
David Marchand


NXP Confidential

--_000_GV1PR04MB10750F6665175D7DBA92489B289B12GV1PR04MB10750eu_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> David Marchand &lt;david.marchand@redhat.com&gt;<br>
<b>Sent:</b> Thursday, September 3, 2026 7:00 PM<br>
<b>To:</b> Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> Re: [RFC 00/11] Device unplug and bus cleanup refactoring f=
or NXP
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">On Thu, 23 Jul 2026 at 16:11, Hemant Agrawa=
l &lt;hemant.agrawal@nxp.com&gt; wrote:<br>
&gt;<br>
&gt; HI David,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for the work. W=
e will test it soon.<br>
<br>
Any update?</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
We just completed sanity and a few quick tests. This patch set is not causi=
ng any regression.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
<br>
--<br>
David Marchand<br>
<br>
</div>
<div><br>
<div style=3D"font-family: Calibri; text-align: center; color: rgb(0, 0, 0)=
; margin-left: 5pt; font-size: 10pt;">
NXP Confidential</div>
</div>
</body>
</html>

--_000_GV1PR04MB10750F6665175D7DBA92489B289B12GV1PR04MB10750eu_--
