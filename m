Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4743DEF48CC
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 06:35:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBAA1402C0;
	Fri, 13 Feb 2026 07:35:45 +0100 (CET)
Received: from MA0PR01CU012.outbound.protection.outlook.com
 (mail-southindiaazon11021084.outbound.protection.outlook.com [40.107.57.84])
 by mails.dpdk.org (Postfix) with ESMTP id 0C0A4402B2;
 Fri, 13 Feb 2026 07:35:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0RC6aWqHzeJvuvJcnvlCbU/pu1G4HRCrBIvN+lyiYJ1tU2/SSv10Vro4yraacusMwEXwOHZt+GM5tJ6Z4naYKUc42b8TdOa1h1R7GtuifPDd58ZR2wcKbQcV/0aF021kVstg0KdBq/OfwjD0DGN6yBw2IvqwF7teXFBRaSwLNGCeqHA/WRbw/eU+t+kUo+pCcaEJ5cqjZYNsO4aYe77o/IBvnbLa6BreoZTtTlu6ddvYYGY+pBPhYdrRswH9aHF/bfcZHoQZfVbo+V/P8YPBTiCilrTeY5btchERBsiG/Sw93DNzMq1yLHgUu07uiQ/07y1FDsOu3+Q3/b5e+op7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy0K6mqrb38W5GvAxNpMFohV29DZvWlzzGEWImkNqS8=;
 b=T9K2NFTeFF3FjjJ6M+imsrlLaQQmuwZ/jEmlWinoL0R9Ywzg1BgPQG29Olp9dRTyoi8/Ti9Yhg5DqQX24FJEDNMXGoit/t8XYogOkOzRhlcLMTqeM73gch4YWxPvjhfkdyQNyFS/Ii0eMe4opvnbispUj0BmL9LLfvyFWihjzJ65+bKHCYSqtAvlUPYP3EB57sZwuaenet1GzzG0MhIkLEbCUcrXaS6VAJ5o0BRPb0FY2x2Z0eQs9DwRIbmgbkTl9rviop/VSICNdHKMndWfBklyBebS5d5/x2qIbRzN8o6ZYPfnuGfRL3IZwhWNuNA/MeKQUl+UJr92xp2Q2T/r/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iwave-global.com; dmarc=pass action=none
 header.from=iwave-global.com; dkim=pass header.d=iwave-global.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iwave-global.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cy0K6mqrb38W5GvAxNpMFohV29DZvWlzzGEWImkNqS8=;
 b=XwvQc1jSUSMhczJXoiV1BFDSvntDbnaruXZbIQRNPYOwbhiWfCwzgaafRojCEowWH+qLYs5lIZDj0YaXqwEuaWLjDbalR1cbfGalW/X39cvAtFbfVdgqKoXHh/ZEhyeUGx/5nvmEmOuBVT1c3TzQZED6IdD83xmFhbViE/xjBZ6ir0VuIQqSHo2+UPTQvlA0DSXr6pluWJ0tqndmONs0BCaM/tDbYCUMlpeZXqHxaAbU7l7FUW54iIE2HCnj0oB6TI76g+TZKbBYYZ71LqWyGujmG8Tiv51uA0/M0c7gyzOlG+O1mW5bCfF6y01/3jjxDAWleeEnWLDirdIopF4KGQ==
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ff::6)
 by PN4P287MB4722.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 06:35:32 +0000
Received: from PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::8024:3f32:d2cc:1309]) by PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
 ([fe80::8024:3f32:d2cc:1309%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 06:35:32 +0000
From: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
To: "users@dpdk.org" <users@dpdk.org>
CC: dev <dev@dpdk.org>, "yasu1976@gmail.com" <yasu1976@gmail.com>
Subject: Guidance Required to Improve Throughput on ConnectX-7 (1x400G) with
 DPDK v23.07
Thread-Topic: Guidance Required to Improve Throughput on ConnectX-7 (1x400G)
 with DPDK v23.07
Thread-Index: AQHcnLCS62jGM71/gkmd9SnnzdDRGw==
Date: Fri, 13 Feb 2026 06:35:32 +0000
Message-ID: <PN0P287MB25319528772B121E0E380747C561A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iwave-global.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2531:EE_|PN4P287MB4722:EE_
x-ms-office365-filtering-correlation-id: 3fdd242c-e36c-4913-1952-08de6aca166d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1bJCvo3Jd33+Do+1Tzasg+Cr/A2mwksWkFEp6+Rrua+Tgg1azwSOOwlu9F?=
 =?iso-8859-1?Q?wHkSaJCgoVPFD2iGG005vgZv+AI5u1TOgKLJW7r+Bm+7jz/+U3U6v0plCI?=
 =?iso-8859-1?Q?i++MLDKJs+xkXw1aiXLImJZy1MznkH/UXBqA1KHVIaAVFYc3YU/XJk6cz/?=
 =?iso-8859-1?Q?MBxzNpPmFp0UPpH+94c5TT8jApVBGjBK/tvM5pb4ebMzBieCL2hFLNjvbP?=
 =?iso-8859-1?Q?lr8uA6CyxGLVi7DIl4FrTcPUe0UfrJDF8UVd/hYAYOmWfWEqfs0z6todUZ?=
 =?iso-8859-1?Q?bKYHyDn80GiWd4ivnH6Chv5Iu9rcFQISb8BtXp4TzfeHjB6E7R7BQcFRXJ?=
 =?iso-8859-1?Q?FYL5RVBkAJEaQpRkp1bMjm45Ndi9rSmMY0m2mf8miLgdBCNuKkkhG7DzfI?=
 =?iso-8859-1?Q?Q1v23uSBD60ghpuVrI77R6sRx0zW2UMBUa8lNZNgBn1zp/kxuQnklHtahd?=
 =?iso-8859-1?Q?tj+26mSJcnEQiPUeQ8fb600b7MmeaFkk5iCFzFV33nrHimbmYydLCeSgn8?=
 =?iso-8859-1?Q?6PSkesqe4JFN+jPV6Atf2wpHqJeHrIHVXeBbGbaTTusb+X1+zSGcqcw/Vd?=
 =?iso-8859-1?Q?TwyHRlFyQhWXEF+tKgaHj3mXctPXLhQIeKgMzYVQm/gAlbRjvYoTDYGqw3?=
 =?iso-8859-1?Q?MLmzN81EAlPt8Ls16UUwve/5ZtMBH91KT2vDhLBJ5CKPYu5JkjZOsXxM9a?=
 =?iso-8859-1?Q?KQRq7DT9Cb0TWLz8BB3CPQ96aQVpB3CVyVykRm3BOs4zsnmwn6BREvKwoP?=
 =?iso-8859-1?Q?FIwy0XJYUpjYZHEr06xGBeUixHLb1NmcyDBANSw87bAOlvaUsxDe0SQPDs?=
 =?iso-8859-1?Q?W9CvHpNLhlxwtczITEAEhMMyaeeWcRwDgky6angM2xrSHeOYoFwDPQwMzO?=
 =?iso-8859-1?Q?2+wwhKS9+DgSdJyq2h/604mm1CFtIhrRI+xyPfQQsQSc+sbIhVpBCktB1l?=
 =?iso-8859-1?Q?fi6cO28Mref8aJ6LVQuxqalyjpMvZnRId35YC8fJQtmc+keX64lQxQItYt?=
 =?iso-8859-1?Q?clH4yeBDVcaliCSgkE5GNgSbdRsiAXnu1hz2IapEAsDtJMvdSGHZm28tui?=
 =?iso-8859-1?Q?8QgqP9HFjVxocbV7uOVOVLBUwjcTbMWdqfMM9s+2xqGDdC5sYqqoLhxMXk?=
 =?iso-8859-1?Q?nnd0Dxzf7hMEbeNcP3S4WWEv482HhICDruSowky8khoSb7HKUx5k5rbYvQ?=
 =?iso-8859-1?Q?eb8TfeyhiPo+vPFOD6Wmj5ECv1kYNSQWZtVVEJ5EiTP6iqjcPVjBx+2fVs?=
 =?iso-8859-1?Q?Gay54xkVORD3cFZhb6p4yKLuxondh/08x9xZygHkwwsQDJ+RfQGEvYOzfk?=
 =?iso-8859-1?Q?I7S3rrxYiiVAy+b5+llSWUAV7gxBYIzVo5J7BfI1Yo+PruWIF9LmjITsWA?=
 =?iso-8859-1?Q?x1qGiDEqGKvtsj7O0VJ7t7sVTVzIMebc7ZHuCqLoI4s1P1fKn+LQ8xuFf7?=
 =?iso-8859-1?Q?LXBhjlXrI2PAV3yBZ2/6oMecgpI0VDRsrUC0PUWcUBf93YI/10dnN+GnBr?=
 =?iso-8859-1?Q?dUkQ27Ttc/k6mqYU9WU+2OjmlOzZT+lE1CBrO2CszPBOnsw/4YpRYzUEtl?=
 =?iso-8859-1?Q?S8jCkVkJPbj6TorkPLjYuw+KB81wFQwlmh+KlcrThY4MFHzn+Bqazxom85?=
 =?iso-8859-1?Q?9Wq1TCrlv8cp4sxk/WgbMy0J2Aj2Xqwn0e8uIirF8htkPQvmaAB9NgqVqh?=
 =?iso-8859-1?Q?AZCd/r+5MiAiv1RH204=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PN0P287MB2531.INDP287.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(8096899003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0WIEchrC1UHO2VMP1pF+wFkC3qHk9ix9ieKQtCOWpHjDTI5/uj89uRn1yr?=
 =?iso-8859-1?Q?GWa4tWbfd5pWp4Pp+qm6/qVbOtZtOgQS8lqdWQnhKolnrk1WDVmOAEn5Wj?=
 =?iso-8859-1?Q?meHXsucW1oK9IHlwuxNroyHpISBSJsOWpN1/vE79LNNOYkOIQBlD4JIKsx?=
 =?iso-8859-1?Q?+n7OifatqLvcJoZwC3WUxfqNe/fRbw6HU4mvP8IgK1P+YaFOM/sJHdU3yR?=
 =?iso-8859-1?Q?T7KOq3Qv/EXYmB7WHfMnlSAPlgMbKgehJSrSCToQN6K1nY460GOZsmvGgh?=
 =?iso-8859-1?Q?Pcm9arPzCBFKNtDyrubt4bpAnO93NskfwQ+/UbbrZG4NvJm8kHSw8Xnp1Y?=
 =?iso-8859-1?Q?qTAdaZPGW0gKKGXMeLNhwJBlpME9yOyggJFVdFE97MheGCmLvGVMb/ym6K?=
 =?iso-8859-1?Q?Conxfiop3zo1isst2jx3+mA71dB8dJkIzSyiUkGOtXQvYtURVP6ptdE4Bp?=
 =?iso-8859-1?Q?GntZjWljGr+SxUczHuJTpfnu10f0R0mbwYrioFRbmXRaqYaHlaHCjszfci?=
 =?iso-8859-1?Q?7BlMgcTOGha+/12/es/KhZyOBAzyYydocFgRPIDztXGuLTMRVhUht6SWVM?=
 =?iso-8859-1?Q?jzryDu3/U/Cw5bH0cN5IJJeh6qTegRy4Mi/y3eFsw/KyT4HgOwecxEwJah?=
 =?iso-8859-1?Q?BqCbXj9qWTp8SxW4oa08di+3CbTTBr2wyc6lYYuI5EE+T9xox1kx3JbCnc?=
 =?iso-8859-1?Q?r24iLvCvfNd5BJ+oIErG8/bp/vaX1j2uiS9rllcEuwXFyv6iF8B6dTW88i?=
 =?iso-8859-1?Q?qt55h3OiYynTHjVrPiwdD2szOYnZP/q66sHMFgDEthxC5N18TzLvI2IjAg?=
 =?iso-8859-1?Q?lTUoFhMZKumGpD8gfNdSaVOWUddDLPdPitx7Vz9jvNqY3oItVqLQ7T+iZe?=
 =?iso-8859-1?Q?UDC/+hzGycFE/HFD8TCAwfNfAD5sh0/E2TSgMmWC0N1/HXpdmmTadz415l?=
 =?iso-8859-1?Q?JMWOk4qDT7BipZmgM2KGO1ofm9Xxp18ayg+rglxb6DBNFwJYU6rhtMfB4A?=
 =?iso-8859-1?Q?SaDjabZX4xQYgG6zFdkiXh5Xcqmp/FnfvrqUOy9ZgZ1bYG95QmHlGz8bjd?=
 =?iso-8859-1?Q?bXH/lf2rENS32sUjCxB+0Kq+GA6jyeRTI0zxBPvLMmcPpZz2+IBT56N2QI?=
 =?iso-8859-1?Q?aUWGoRvNtuXocXnrUrH1qwNfjjhaY2erGoep25OvRdUWTAjhZN9K/5S9uE?=
 =?iso-8859-1?Q?4frLfXdfL4HWt9D7g2PJj7laTLV+I5cNuK07slXhAwqCNfFE6GGH6CnL0Y?=
 =?iso-8859-1?Q?ZVx1fo+2OUQRzXou3CTmEd7NYaGorxdtdt9KDirPD0vHbtsIxuMcPWaY8r?=
 =?iso-8859-1?Q?R5BnWkAYNZ7XTd6rA7QFFwCbr1nyFhjFUg/8e8ES+7EtQVS7pkmyu6650V?=
 =?iso-8859-1?Q?CoQzF9dW4I0UmliOdT24tQkaKPRl15mfN1k78ZFIjzkBu51Za/QpThpVj1?=
 =?iso-8859-1?Q?yP19SUMWeBTTZQ8bvoNUcW2gKYS2sta/e45fUMUG1HzkuozVmd5ineE2oE?=
 =?iso-8859-1?Q?fx7+TPLULbCqJh79QZtDsT+nvp4NRz8rAv4uR1VCsBEN21ohuddGGtQLhv?=
 =?iso-8859-1?Q?43xvhvrcJb19K7dZ/y9TVDmVYkzKdHXTsNeXWswls7GlwDiCq1i37oxVnf?=
 =?iso-8859-1?Q?lATZxEXZvYWP+QUta7DYlD7PY2uayVmo6mHB3n2vrtXlrpCWgfaqTA6DKU?=
 =?iso-8859-1?Q?3/Rs1FQT+zpXxTdqX1X8UvAgii5EHOBBjN8moS2r04ennV+M2q0jzj9Le7?=
 =?iso-8859-1?Q?cJrOLOOgmFYKn4we/4GcG2mWM/qjrargTBPi1p+wi4LodKQ/8JXQc9wB3o?=
 =?iso-8859-1?Q?b0hnkmBabMon9l0bFVoJzJpDXmO3lRQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PN0P287MB25319528772B121E0E380747C561APN0P287MB2531INDP_"
MIME-Version: 1.0
X-OriginatorOrg: iwave-global.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2531.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdd242c-e36c-4913-1952-08de6aca166d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 06:35:32.5124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 507ae903-cc48-4d6e-bdb6-35278120a345
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+6KVZxWJCAm3dDm0N4iZnTFDwgyvM8uYVXUzHqWhZLBEft03fX9wfWX1HBd5nYdgNBsSJuFxYBY+ov+cL0SqqWQNuYae/lyMsucXUtChvAGVhc17qT8BYeTuoFCjZTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4P287MB4722
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

--_000_PN0P287MB25319528772B121E0E380747C561APN0P287MB2531INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Team,
I hope this message finds you well.
I am currently performing testing on ConnectX-7 with 1x400G hardware using =
DPDK v23.07. However, I am unable to achieve data transfer rates beyond 10 =
Gbps. While reviewing the DPDK mailing list, I came across your previous re=
sponses in the related discussion (https://mails.dpdk.org/archives/users/20=
24-July/007767.html), where you mentioned achieving throughput of around 25=
0 Gbps and above.
Could you kindly advise on the configuration changes or optimizations requi=
red to improve throughput in this setup?
For reference, I am using an OSFP loopback module for testing, where the sa=
me port is used for both transmission and reception (single-port loopback s=
etup).
CX-7 Firmware: 28.45.1200
CPU : Intel(R) Core(TM) i7-14700
Command used : sudo ./build/app/dpdk-testpmd -a 01:00.0 -- -i
I would greatly appreciate your guidance.
Thank you in advance, and I look forward to your response.
Thanks and regards,
Ayshathul Thuhara


--_000_PN0P287MB25319528772B121E0E380747C561APN0P287MB2531INDP_
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
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
Dear Team,</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
I hope this message finds you well.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
I am currently performing testing on ConnectX-7 with 1x400G hardware using =
DPDK v23.07. However, I am unable to achieve data transfer rates beyond 10 =
Gbps. While reviewing the DPDK mailing list, I came across your previous re=
sponses in the related discussion
 (<a data-end=3D"374" data-start=3D"315" rel=3D"noopener" class=3D"decorate=
d-link OWAAutoLink" id=3D"OWAe131b2f8-ca05-2ff3-d67e-40e6b9de2cd3" target=
=3D"_new" href=3D"https://mails.dpdk.org/archives/users/2024-July/007767.ht=
ml">https://mails.dpdk.org/archives/users/2024-July/007767.html</a>),
 where you mentioned achieving throughput of around 250 Gbps and above.</di=
v>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
Could you kindly advise on the configuration changes or optimizations requi=
red to improve throughput in this setup?</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
For reference, I am using an OSFP loopback module for testing, where the sa=
me port is used for both transmission and reception (single-port loopback s=
etup).</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
<b>CX-7 Firmware: 28.45.1200</b></div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<b>CPU : Intel(R) Core(TM) i7-14700</b></div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);" class=3D"elementToProof">
<b>Command used : sudo ./build/app/dpdk-testpmd -a 01:00.0 -- -i</b></div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
I would greatly appreciate your guidance.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
Thank you in advance, and I look forward to your response.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontServ=
ice&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0);">
Thanks and regards,<br>
Ayshathul Thuhara</div>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_PN0P287MB25319528772B121E0E380747C561APN0P287MB2531INDP_--
