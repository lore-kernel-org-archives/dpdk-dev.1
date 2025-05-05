Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0325C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7474C4026C;
	Mon,  5 May 2025 14:14:55 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
 by mails.dpdk.org (Postfix) with ESMTP id 1B9A34025D
 for <dev@dpdk.org>; Mon,  5 May 2025 14:14:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lplNWRLXD+ep9Ci+IzcQMaGwLmXckeDMT7tkLqCNg6op2e2y1hBixx+NBHrZdQBXLqu+ROFzylmatZZrXEiVyEiNwGvRv8tyWmhcCrKaeMIZSsY8DEB+rdoprIhCIPBZ+LTntUFGsyLLYaBDh6/i6z4nw/lvnBG/PZWhkO2v3Dyae0tzewVlQsUPQQh/9vP8SvMUceo44I6B8Wuc0LTypLjLXInf4KasmLvP9mGteOvw3CnquZuW4s59EN65dym4TV10gikSHEY7zDW4AL4lrRbYjUflk+qHTEUYF10ZXlxDBsVLgkJ8xExG58ucpGYXYh0MbwHDaleZN1tV0zA9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6wfnZCF43ukpVwI9WOnbj4jCAExCKtFQJmsztdmi4Q=;
 b=Y7Uc3LkvOEy5tdiBdrMHR9daUD84gVN76QAQqgF3whJCsSjtoC5fLpCaZi4tGrJsqq5NshbgV6VbRM4e73WDilzrGS5PzKoWeb5OGij5iXBXOPUx1mGJjxc6gnw+yfBfjuRg7g6msI6otgJLu4MC3hKb/KFWOYQTfQyiOOo5D55z9N0AcF0K5MQfDuFl5KivTJhsHmRl1LkR59+NgIsa0s2SpWXvKICFbb7NxGmno5UjZ7WtlSUqNMOcIr5YbXApwvISEk4QjsuLjbE2zU1kJXxun7NabLyE3qjVpv1toS93ax38Pf4gy/m4TVu3zUzx7wq1M76qEfbjgUx1WOfBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cgstowernetworks.com; dmarc=pass action=none
 header.from=cgstowernetworks.com; dkim=pass header.d=cgstowernetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cgstowernetworks.onmicrosoft.com;
 s=selector2-cgstowernetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6wfnZCF43ukpVwI9WOnbj4jCAExCKtFQJmsztdmi4Q=;
 b=ZHW7baaRv2XnzXxpjDAtuGUodb5h893HPswOgxhCl3XKjoL4LqPzBifui6OvhB8t8RgyYyHmKLtk3krqj6eLxFj8c6AFxK5350/1A4wgaiSIjUZ7n6jFZ0OmW37cMIaCSIX6bikUfn362ucKhuGGgBU0hoyY7Bx6gMOo1oUT38k=
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com (2603:10a6:10:27b::22)
 by DU0PR09MB6299.eurprd09.prod.outlook.com (2603:10a6:10:416::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 5 May
 2025 12:14:51 +0000
Received: from DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc]) by DU2PR09MB5486.eurprd09.prod.outlook.com
 ([fe80::a8b7:d0b7:ce2a:24fc%4]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 12:14:51 +0000
From: Yogev Chaimovich <yogev@cgstowernetworks.com>
To: "dsosnowski@nvidia.com" <dsosnowski@nvidia.com>, "viacheslavo@nvidia.com"
 <viacheslavo@nvidia.com>, "bingz@nvidia.com" <bingz@nvidia.com>,
 "orika@nvidia.com" <orika@nvidia.com>, "suanmingm@nvidia.com"
 <suanmingm@nvidia.com>, "matan@nvidia.com" <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Yogev Chaimovich
 <yogev@cgstowernetworks.com>
Subject: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Topic: [PATCH] net/mlx5: fix transceiver warning when not exist
Thread-Index: AQHbvbYIS6Ux7qfBtUOA8dJvuvvxhQ==
Date: Mon, 5 May 2025 12:14:51 +0000
Message-ID: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cgstowernetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR09MB5486:EE_|DU0PR09MB6299:EE_
x-ms-office365-filtering-correlation-id: 07e60cca-2724-40fa-caa6-08dd8bce6fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|8096899003|4053099003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bRUFganDpAQNeP+Utusys6MsATOgL/JKeG0GaBCdBNrfgap/yFX5R3ZM4L?=
 =?iso-8859-1?Q?oVXWHujxmslHVjawdsgcbTe5ur1AAubFA9eSJ8jHR75UKC0+v2zrD3Xvtv?=
 =?iso-8859-1?Q?NnAjhn/ztr0Gyr12raB0IwjrT4J0Hi9ycDW6GSWX13yF/fztxbUnJETsmp?=
 =?iso-8859-1?Q?/jmkxgQxFN3h54d42xKcMU14jww7cE66Ea7N0nkOfbsr8xZu1vzBxF7lHY?=
 =?iso-8859-1?Q?utfupjWtblQOXrbQAM6m4c8R7NZW2zDsRZ9d+Wl+Cusn7pc4/R6BGdJogP?=
 =?iso-8859-1?Q?GorqF/uesdqk+hQYfeqfjjORP+MCk/UL1TgQkIstI6POGr9SCZmKu5Ieji?=
 =?iso-8859-1?Q?QCNe8oZlBCxLuhoDHD3XAgNtQAE4+VBeQ05S2kEytnMoAP4v+Yd/VGeUXg?=
 =?iso-8859-1?Q?Hzk4hopAvCiH1TSIyHE5oFtaEq7hJVRrqOYHIKLkQqaJyYgbGrlce2gLUZ?=
 =?iso-8859-1?Q?A3f9wvHpK537cjrc6iPuX9RrMY6laEkaNRVBCX2owK4B2kGp4IJuYqHX6/?=
 =?iso-8859-1?Q?hx15LGoBFG5OXZMIedtwguVCFZc+CydDlVL/2IfTX8d5JlEHF31hEL5eWt?=
 =?iso-8859-1?Q?QEuCxzGZrHALCgsvpOXfHKl1bQcRy1ml4xe1eYV5TjuuITkDQI9R+Rt+/b?=
 =?iso-8859-1?Q?FDttv7SVAkwj8m9o28bq971/zpDkA6caXycm7JVj2DMUUluxHfIRtXoki7?=
 =?iso-8859-1?Q?9LS6CrffEs1Kw5tWidJgFCLR76D6jpIuEe5aT92LDYU1rKKdENDpJxPzvo?=
 =?iso-8859-1?Q?oHGjtkrYTU/gnUPOy9wLptoipz9JXlqbqCJxUbtMecG0riUct880AHOvg/?=
 =?iso-8859-1?Q?UX3vnbdme0FtEKYNUlmyaSJS+DfXNRaQvpsjQdylP7/xJ2v/ZeWphFB2FB?=
 =?iso-8859-1?Q?/mJbh2GN/ZbGtzWBWipEl5uAnCxh8eKmawvDKXd6uI7s7CROlVSPuvb/o7?=
 =?iso-8859-1?Q?Bva2nlnRVI+UDSR69Gd2I0vBK6RLuIt3uG9CYR93l8hjpJ8KWCB2emf1Vk?=
 =?iso-8859-1?Q?7Dy3dp0QZAYgIBdIWlUO6FhXvKc0MKbddh0QNB+nrdUM4lydnBUXpRDiMb?=
 =?iso-8859-1?Q?csGJ1WT1bQffwy9sBaRgECvKeWdv7PzQo29IB6o/yBhoZxs+MPlG+YPUel?=
 =?iso-8859-1?Q?Y4jj9Zn1d2rkMR9HDBVdJxxX2bQ876PQmGCVj3vTbV/CXINchRiZTvFOLT?=
 =?iso-8859-1?Q?Msf1K4T20djDXv9itNU8OATt6ADBIudgxykGUEKdH6AY0S80VtaLgB/TVD?=
 =?iso-8859-1?Q?HD/3xvSu6p/Mq5gLV+wQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR09MB5486.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(8096899003)(4053099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u/+p4PPQ9cp+WS4MoHzyXlV4KYJZX1ueWPFxrZIxi0CBuAPYV4YAxvza+X?=
 =?iso-8859-1?Q?I0ALdibqfqOGE46b5btS6LfHYR2qsy0gJsvmytu5T1SpIk0m604FtHvO3V?=
 =?iso-8859-1?Q?4ixktSMd3e/FDgzHWa3plLPdjgg+XvsgCwuGhnnwpcIqoFioboxmDJ9LPp?=
 =?iso-8859-1?Q?1vfhI+7BVKa+wSuIQ92HpSN3TyDvJjYg0K8nbQhTzKuRWd8MMe36OcaIKU?=
 =?iso-8859-1?Q?Vmr13RYG+wWch/zEezQr0BlM9w68zlhgqa7csc+YxgIUJ6tyIDxaJaxUjq?=
 =?iso-8859-1?Q?SBXdt/cG+fn5AnW8oMG3syU/Kpk4oOAWwwQwUn++lKxi5lKgzWB4NHrCVB?=
 =?iso-8859-1?Q?dG8JN5mxrlCX1KIFEYrq2fSB9T9jtgj3XHNMVCugBZ1h9wvi5qfHlUdde+?=
 =?iso-8859-1?Q?9oWhL9ZZwAya03kKJIoOc2qN8O2JhltyhJAHK6AqsZqRqLUYaO6FQlj77s?=
 =?iso-8859-1?Q?w7aNCoL1peXHVpTWhswgFI2D8SOX1cvD1nILH1a0KpcbS0ko/dVpmx0nTK?=
 =?iso-8859-1?Q?0IQO9p1ruAzyV61mNMV9c8zF9tHkVpnOpd9YkMPArNvC4+rpoPdVmlML0h?=
 =?iso-8859-1?Q?UjyWW6ivkivZupQv69ALDj3MJOcucOzBrIi8aaPtL6Etl+KcT+ATwGM587?=
 =?iso-8859-1?Q?IC/4GqGhSvXNrcNa86oAfhFwtVPLZbvpE6LnGnkJSfxToJ+VFyS4XxcRZa?=
 =?iso-8859-1?Q?fM7uj6enr2M9b/kP0KAm78mRx9obdvY53CrcRziGx8UpRULeuMVQwuOpP6?=
 =?iso-8859-1?Q?fMX2FR6yuvAqWQlDuzCFEenwswKAsEYb2KiSh7Ri4DlGPReTNldksmEls8?=
 =?iso-8859-1?Q?0u7DwNm4LQ9FRhHFwkcGHEBCHQUadHj34y9tDRgoIPP6IpHkYTEPWri2JN?=
 =?iso-8859-1?Q?/B20pW6vuuIgDj3/vGdrt5s5rUof+cWOyHAVIf+RaOWrU4ErrqT6s+G/2W?=
 =?iso-8859-1?Q?mFBxwT3RkrhQ4b5nNDDuZA5rdTgpj7hFZpyIk23rPHAw7Jw5tWVUCS6AR9?=
 =?iso-8859-1?Q?NJJowJkn/RflSiWEiprxgY6m9Pp5HIl1lOIwE5RQPmc8nneL7vEeJKe6Xd?=
 =?iso-8859-1?Q?+zZjPd90hwhnfhCJyNlL7A3BJ0psd3LYI5NMC16+HuunpxZjmIDmyW/dYi?=
 =?iso-8859-1?Q?gyGkMeVjJz+7TKGuvFgsqj/RsxCtv9ZO7vof23y9Wv9eIPyWIxpXHdX0k6?=
 =?iso-8859-1?Q?vWJv0hyizX4+cjG6FmDChZSDrkIKi6+jdd96w3VQaJ2Z9P0jFwTucc9yqm?=
 =?iso-8859-1?Q?Xb0FvFhojlTwdcuQ13SAm9jRPZ+BK0LuCdPTVy/1YQ7YngaDWsbp4l7i3y?=
 =?iso-8859-1?Q?elpkMFlGAYzSTfACg6nsnQ6vUKcFmzNoYDSYGEWGroVSiYM5Rbw7LP8B8g?=
 =?iso-8859-1?Q?YnoPzbLaRle0ABVOFpm97KPEbUOv0lrpmAaPniYGok8R+O4OBDrX0H9G/o?=
 =?iso-8859-1?Q?PiDzFM8OD6LBqmED8FOQ3RSno+/DgTsLmMc2F0FShU2FQ32bkq1xMoEcGS?=
 =?iso-8859-1?Q?tHSB/2pu3GxW7ENg5+st2zglTSduR9m6i4+NzWj6ObkEi5CeOsbNxzPnqj?=
 =?iso-8859-1?Q?qaxOjJwV91CtoAu6UHc0k2wW5fiU/rSy3ztEIW3Lj2UjRVKR02eIW1wMCw?=
 =?iso-8859-1?Q?StpFR8dnP7DCS+urXbY7HfcM8vYQOTkI8/?=
Content-Type: multipart/mixed;
 boundary="_004_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_"
MIME-Version: 1.0
X-OriginatorOrg: cgstowernetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR09MB5486.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e60cca-2724-40fa-caa6-08dd8bce6fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 12:14:51.0888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fc9e9498-07e8-4b82-b4cf-365bba23cbbf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pADmTWY9eZKevEsiqmIPicnvjnnxzC/+Igut5278WDIMBOixdt1Nh0zK4SaeF7tnV1l3Tmc5Tt07znsda1iVsSSdin2i19M8mhG8y/e9BRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6299
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

--_004_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_
Content-Type: multipart/alternative;
	boundary="_000_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_"

--_000_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



--_000_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_
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
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_--

--_004_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_
Content-Type: application/octet-stream;
	name="0001-net-mlx5-fix-transceiver-warning-when-not-exist.patch"
Content-Description:  0001-net-mlx5-fix-transceiver-warning-when-not-exist.patch
Content-Disposition: attachment;
	filename="0001-net-mlx5-fix-transceiver-warning-when-not-exist.patch";
	size=1252; creation-date="Mon, 05 May 2025 12:09:02 GMT";
	modification-date="Mon, 05 May 2025 12:11:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZmU2NjYyOTFiYzUzMWI4OTYyMGNjMjhhN2I0NWZhMjA5NzAwZjM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB5b2dldiA8eW9nZXZAY2dzdG93ZXJuZXR3b3Jrcy5jb20+CkRh
dGU6IFN1biwgNCBNYXkgMjAyNSAyMzoxMTo0NiArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIG5ldC9t
bHg1OiBmaXggdHJhbnNjZWl2ZXIgd2FybmluZyB3aGVuIG5vdCBleGlzdAoKSW4gY2FzZSBubyB0
cmFuc2NlaXZlciBleGlzdCB3aGVuIHRyeWluZyB0byBnZXQgdGhlIHRyYW5zY2VpdmVyJ3MgaW5m
bwpUaGVyZSBzaG91bGQgbm90IGJlIGFuIGVycm9yIG1lc3NhZ2UgZnJvbSB0aGUgbGlicmFyeS4K
VGhlIGNhbGxlciBtYXkgcHJpbnQgYW4gYXBwcm9wcmlhdGUgZXJyb3IgbWVzc2FnZSB1c2luZyB0
aGUgcmVsZXZhbnQgcnRlX2Vycm5vIGlmIHJlcXVpcmVkLgoKU2lnbmVkLW9mZi1ieTogeW9nZXYg
PHlvZ2V2QGNnc3Rvd2VybmV0d29ya3MuY29tPgotLS0KIGRyaXZlcnMvbmV0L21seDUvbGludXgv
bWx4NV9ldGhkZXZfb3MuYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L21seDUvbGludXgv
bWx4NV9ldGhkZXZfb3MuYyBiL2RyaXZlcnMvbmV0L21seDUvbGludXgvbWx4NV9ldGhkZXZfb3Mu
YwppbmRleCBlMTkyZjY5OGQ4Li5iYTVmZDJkMjUzIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9t
bHg1L2xpbnV4L21seDVfZXRoZGV2X29zLmMKKysrIGIvZHJpdmVycy9uZXQvbWx4NS9saW51eC9t
bHg1X2V0aGRldl9vcy5jCkBAIC0xMjUzLDggKzEyNTMsMTAgQEAgbWx4NV9nZXRfbW9kdWxlX2lu
Zm8oc3RydWN0IHJ0ZV9ldGhfZGV2ICpkZXYsCiAJfQogCXJldCA9IG1seDVfaWZyZXEoZGV2LCBT
SU9DRVRIVE9PTCwgJmlmcik7CiAJaWYgKHJldCkgewotCQlEUlZfTE9HKFdBUk5JTkcsICJwb3J0
ICV1IGlvY3RsKFNJT0NFVEhUT09MKSBmYWlsZWQ6ICVzIiwKLQkJCWRldi0+ZGF0YS0+cG9ydF9p
ZCwgc3RyZXJyb3IocnRlX2Vycm5vKSk7CisJCWlmIChydGVfZXJybm8gIT0gRUlPKSB7CisJCQlE
UlZfTE9HKFdBUk5JTkcsICJwb3J0ICV1IGlvY3RsKFNJT0NFVEhUT09MKSBmYWlsZWQ6ICVzIiwK
KwkJCQlkZXYtPmRhdGEtPnBvcnRfaWQsIHN0cmVycm9yKHJ0ZV9lcnJubykpOworCQl9CiAJCXJl
dHVybiByZXQ7CiAJfQogCW1vZGluZm8tPnR5cGUgPSBpbmZvLnR5cGU7Ci0tIAoyLjM0LjEKCg==

--_004_DU2PR09MB5486574FE72A43A09A323DCDD68E2DU2PR09MB5486eurp_--
