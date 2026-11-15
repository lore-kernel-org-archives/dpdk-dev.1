Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E86606A31A
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aH9c/IvC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E07A04025A;
	Sun, 15 Nov 2026 16:03:36 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013025.outbound.protection.outlook.com
 [40.93.201.25])
 by mails.dpdk.org (Postfix) with ESMTPS id F3456400EF;
 Sun, 15 Nov 2026 16:03:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHTNg1z7nT1XEvUwW7qo8iCj6RGUIt+M0w+cQHPkwsrmNR25Z18Nd8VyDlGITLDcDX52+050xjmRataF5B/2P5e7hJ9lI8lIbu3ryWSPtWoQsvoyJJzZabJZA8Su424c9ARpCrUakZ2nyPUE8iTwFHVFtZ1IOBD+gljfe1rw8ljKcGaw8MGjEvllAEbMGenheqzkvcNFOIj9HBQaiPXJhPTTx//e3QcqvrZBCuB4r6zV13aHOyJ/gCsYCVvuiwj0wq+GkxN8YUBrHhq+a1XkqlchNne2xIt9XenXPW9jff0GYcEM4jQE3u5pMbn0REZQvPu3U3fyIfr2r7UCf3MgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzQgRIRUhkjcEWq9wQAm1cjH1SJCDi4GwuVFnMGjoZk=;
 b=ESFwWD399P1mW4q/18LqKD8SN7MbBebbkCNOjvCjqwZcWNu/CoOflBZnuO1PmzdrBZsphDD5ecPWrG7ZkN9xd8YgWYOUOhEMp1Zvivmn1c1goq5VVFVyoHspuxqQgVStg5gkDPSWiQH9z0PAFv12w/tP0IhXij9LyV8DfZpo1pJ+5yRHeJaZXf6O8Bcsa2wTtsA1Dog1ut1KDVku6IutrH0bu5M8M8JeeCKu2PI87qOip8B/tpfzCUYpnBw+XSkOaiRuP9g1yjln/qhL/OJY/L+tfueiWxZZ+XXqNzD0CwNTfflqDbpU5aWQxv4FTHatkAqfvzDsDvSE2RvkLcH2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzQgRIRUhkjcEWq9wQAm1cjH1SJCDi4GwuVFnMGjoZk=;
 b=aH9c/IvChPKbM+DJ+aRuTtSSm9oVwVwMHyDfM8wnI/eNBNyct0WQ9sTVm8DJiz/YBfbDFN4RJYSm1a5Ht1bmRXPSBodBiqrEAxYI2VNx2FLu1W1jvrWPehww2CKIoc7yjVDHTzENnHPs7wHprYUB8mkWNpn9dMrFK0tskd/8zgsk9p31xeZW6Y7R454WEwffIqL5/FIQ9CkPcIcPVxzn/BCyQauF6V7gJRP6iO1up/3qGQUeJ2I87c440W4MoeEmnA8KnteSdds9h98hZFGcgg8tUxl9ygEYL1HdDzxUk+UUjc6YeJI5wa8dNY6S88lQlBbYrLQ3X3YdOJf3IT9Iog==
Received: from LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 15:03:31 +0000
Received: from LV3PR12MB9144.namprd12.prod.outlook.com
 ([fe80::cd16:6496:33ea:aa89]) by LV3PR12MB9144.namprd12.prod.outlook.com
 ([fe80::cd16:6496:33ea:aa89%6]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 15:03:31 +0000
From: Mujahed Mohammed <mballas@nvidia.com>
To: "aman.deep.singh@intel.com" <aman.deep.singh@intel.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Maayan
 Kashani <mkashani@nvidia.com>
Subject: [PATCH] app/testpmd: avoid mbuf pool memzone name collision
Thread-Topic: [PATCH] app/testpmd: avoid mbuf pool memzone name collision
Thread-Index: AQHddRJKEWlzsO9ye0msGXtbLHjsUA==
Date: Sun, 15 Nov 2026 15:03:30 +0000
Message-ID: <LV3PR12MB914444BAE4DA3B85B4179A4AD47D2@LV3PR12MB9144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9144:EE_|SA3PR12MB7831:EE_
x-ms-office365-filtering-correlation-id: b1ddbb9e-f08d-48f3-6d25-08df43299c91
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|6049299003|23010399003|376014|366016|1800799024|38070700021|10067099003|11063799006|56012099006|18002099003|4053099003|8096899003;
x-microsoft-antispam-message-info: U7pY2PE+X5++BUd+eYqwn1+pHQSr84axON6LjPJaHGhDmycpWE7fUkFKf4u7KhCu/lkxfrLXWuoXMedzI946LTo8jBf+ZTOiFdnvKJgOBZCT7AWWtE5jpvkKRRBPMpeKwjdPC1Ks1zgflAC7leRWefpEht5ZRej7di4FujZJ7TuU8mrEzGiMd5CqcB93MfMIgsQ+wKs195mtEAt4xcKj+TaUjhmE8oWqHBgZr/hhDc9Q7hHWVQZb2JSXxGinit7vtFyBHeNjksIK+G1yZPAGU8siONkGk40imvJUpJ7UZEVnEe6W8IuPlh9Dc7W2duPWRntOCPKVK4a8avWLiPWrh/w2ejqv5tlaj9ByCQckiukHx4TcXeRS+V+WxU5RgCRVw6WWBdouRfSNT9wyJwbbhkJ5ym6VNuomy+VQkOP55plsr1IRarTXum1lFktKBBKO5Z7aHq+cAkqJZMWhnvLDHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(18002099003)(4053099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EAjKTH+8+MlPdRgNZROljyNBmXEspj5JYo0DD0DshZ3cYqMa4/wIPkHqo7Ou?=
 =?us-ascii?Q?WcuzRsGYHXeeEvhzbGhruwhGJddF7I04E7W+eAEZmWiekXO7LjJQktXQ8y5L?=
 =?us-ascii?Q?HUgWLKXKWXO2xe7Aa2N7diwJi0pQXZfHnGbxseyKkHFF/4w0ErVIUaG+2mKV?=
 =?us-ascii?Q?To7OIl+3MgEmZmakdQnswHTbPLy+ZxERrMnUDMvXBKAD0TT9/oz9qtYtnB32?=
 =?us-ascii?Q?yWEJorsbP104638SJxSO94hH6jA7FSaeTQIMKUWZIIw594R8YMUJ2fEfRLUG?=
 =?us-ascii?Q?7u3dOcryat9R5LEubg1Zbi5kL1akxYfcBo/lnDkKJrUaZeRnEkM0qOaWnySE?=
 =?us-ascii?Q?JffiUNgdaD4AM9AuYIBRH9XqYScF/COu7Zr7c5zttClU9uwhP1Yp2fBbifxM?=
 =?us-ascii?Q?pjADJwtIZj7PaApTjTGFpt78j0TwDOH0jRNJqd2pY0sXXUItZHxgLZFaDv/4?=
 =?us-ascii?Q?zwJ5pULUL0BITAdkRkjl4S9sQ06TReU+MjrkBzYy4YZyxqQK7nyWhp8bIKoX?=
 =?us-ascii?Q?TCdIc0Jdcdb/Os80XUQlayDttpqZWQNRFD5ApgSRM0FsWOjXC3KuFmrhSpau?=
 =?us-ascii?Q?0aR2YlJ+8hFf3/UXwc/XUxb+BecSYGDZSppEKSoqpH8fa13jwRxBLt3VFics?=
 =?us-ascii?Q?LlDJk89ETCE7J3quOY54spXBKQpGnBgvZSGuWE4otWqkCMh4MpMXWpILN9SE?=
 =?us-ascii?Q?CHRc4FsyngdO2E3F2lT58KrqmqWSrzwV6SNo7e4MBk05uBiiIu/kwvtr5iAD?=
 =?us-ascii?Q?5O0pdku+Y3hBmu4FnWvJL3UaAtmCYweIGcBLsgwx8xI3ECj1pfwYnntg6PEj?=
 =?us-ascii?Q?tqadZWPAwkcPmnpiXefhN6jCcvRVDIgI3xg4wricvIm432LBynsGRZjCaZ7k?=
 =?us-ascii?Q?5A0XMtRi3Dx1iBhfd2AhWK4byhyUmJo8prlsIEAsuD7/EmRzu9AISfloeSo5?=
 =?us-ascii?Q?UFyFHpqh0T6JHdN9y62fyzhd7UMxiDZHU28zssYMjgCZHfh+a4UCM4TBXB/A?=
 =?us-ascii?Q?VkHtQTzlJADX3pcOM1tQcdYj9JhdXIP5RDcdv103oMWlVI0mloXmQFCj6Ggs?=
 =?us-ascii?Q?9nJWXKPpvysLIR0EVpfvtsUnMBOEEN4DEIr0n2A4VQG4baDnGXz+RXYxkksP?=
 =?us-ascii?Q?jHMp44Ubwq25PozfCA/aOLz7/dx7PXJ86AXJdBCYh8boZ1h6/HJVBooqxt8M?=
 =?us-ascii?Q?/QNqqH5MMvURIFznQHkLAyFSRgIDooARrOyk6SfdUofPpVmfYpVHho6ua7Wf?=
 =?us-ascii?Q?afeQHj9LVtUnnV9Hx4nJM56yUup9hMU9TyI6tR1XG87EOOq6TnL7ps/DGJd8?=
 =?us-ascii?Q?qgi+6M6Ye3Dum9As2gW9uyr/Hi8iI0s7zcQLz5UmE1Hr5wCGL7U4O5ys2igh?=
 =?us-ascii?Q?urtYhIaAu/pbZmH0qEaSf6vHCv/oT68XBuUOO9d/DTfAW8x0nqCDcBMKrGv4?=
 =?us-ascii?Q?eQNYRRyERk5op0Jr1A/Bncxka9QeoWHp8m57grhylyYiBdN1my7i7FBCHAXq?=
 =?us-ascii?Q?YA+XA34hNcffXriHSF4stLWqExm14v5ewBpRhgj3Pojw7PLCTkFEtbx9X0uK?=
 =?us-ascii?Q?3hz9UULoLbnXpvjPNgHvWVa+VxqC/EjABhbuyl5ZpmPEQhvpiA4mmalAKJ/w?=
 =?us-ascii?Q?jv5Az/kzDqtRzDakdIDMxRwMBNU7MO+iG2TKkcFlKp9ezcKe+9JiX4jf7SFN?=
 =?us-ascii?Q?7BVmZKdVHvehGT38hu1cWfQ/InwAl+qbxW5MHxT5iFQRyOAgUFNB8XXkO+Vt?=
 =?us-ascii?Q?S9obvJqDZg=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_004_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ddbb9e-f08d-48f3-6d25-08df43299c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2026 15:03:30.8956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13XrkPbIEvNEI8C5KxyHyvVQMIXSFt74y3tFLBZAyanRUX7dytjBTOVEDaMssAcbhstmy5Ds4LTPK2PyHhFfZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_004_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_
Content-Type: multipart/alternative;
	boundary="_000_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_"

--_000_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable




--_000_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"font-family: Aptos, Arial, Helvetica, sans-serif; font-size: =
12pt; color: rgb(0, 0, 0);" dir=3D"ltr">
<br>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"ltr">
<div style=3D"direction: ltr; font-family: Aptos, Arial, Helvetica, sans-se=
rif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</div>
</body>
</html>

--_000_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_--

--_004_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_
Content-Type: application/octet-stream;
	name="0001-app-testpmd-avoid-mbuf-pool-memzone-name-collision.patch"
Content-Description:  0001-app-testpmd-avoid-mbuf-pool-memzone-name-collision.patch
Content-Disposition: attachment;
	filename="0001-app-testpmd-avoid-mbuf-pool-memzone-name-collision.patch";
	size=1906; creation-date="Sun, 15 Nov 2026 15:02:12 GMT";
	modification-date="Sun, 15 Nov 2026 15:02:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4N2YxNWU2OTY3YmFlM2Q3ZDA2NjU5OGIxNzA2OTk1OGU0NmFlMThkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNdWphaGVkIE1vaGFtbWVkIDxtYmFsbGFzQG52aWRpYS5jb20+
CkRhdGU6IFdlZCwgMTEgTm92IDIwMjYgMTA6MTY6MzcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBh
cHAvdGVzdHBtZDogYXZvaWQgbWJ1ZiBwb29sIG1lbXpvbmUgbmFtZSBjb2xsaXNpb24KCkFkZGl0
aW9uYWwgbWJ1ZiBwb29scyBhcHBlbmQgYSBudW1lcmljIHNpemUgaW5kZXggdG8gdGhlIGJhc2Ug
cG9vbApuYW1lLiBNZW1wb29sIGJhY2tpbmcgY2h1bmtzIGFsc28gYXBwZW5kIGEgbnVtZXJpYyBj
aHVuayBpbmRleC4gSWYKdGhlIGJhc2UgcG9vbCBuZWVkcyBtdWx0aXBsZSBjaHVua3MsIGl0cyBj
aHVuayBuYW1lIGNhbiB0aGVyZWZvcmUKbWF0Y2ggdGhlIG1ldGFkYXRhIG1lbXpvbmUgbmFtZSBv
ZiBhbiBhZGRpdGlvbmFsIHBvb2wuCgpBZGQgYW4gcyBtYXJrZXIgYmVmb3JlIGFkZGl0aW9uYWwg
cG9vbCBzaXplIGluZGV4ZXMgdG8ga2VlcCB0aGUgdHdvCm5hbWVzcGFjZXMgZGlzdGluY3Qgd2hp
bGUgcmV0YWluaW5nIHRoZSBvcmlnaW5hbCBpbmRleC16ZXJvIHBvb2wKbmFtZS4KCkZpeGVzOiAy
NmNiYjQxOTFlOTEgKCJhcHAvdGVzdHBtZDogYWRkIG11bHRpcGxlIHBvb2xzIHBlciBjb3JlIGNy
ZWF0aW9uIikKCkNjOiBzdGFibGVAZHBkay5vcmcKClNpZ25lZC1vZmYtYnk6IE11amFoZWQgTW9o
YW1tZWQgPG1iYWxsYXNAbnZpZGlhLmNvbT4KLS0tCiAubWFpbG1hcCAgICAgICAgICAgICAgIHwg
MSArCiBhcHAvdGVzdC1wbWQvdGVzdHBtZC5oIHwgMyArKy0KIDIgZmlsZXMgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvLm1haWxtYXAgYi8ubWFp
bG1hcAppbmRleCBhNGFmNTE3MDA3Li5mYzc3NTBhMDA2IDEwMDY0NAotLS0gYS8ubWFpbG1hcAor
KysgYi8ubWFpbG1hcApAQCAtMTE4Myw2ICsxMTgzLDcgQEAgTW9ydGVuIEJyw7hydXAgPG1iQHNt
YXJ0c2hhcmVzeXN0ZW1zLmNvbT4KIE1vdGkgSGFpbW92c2t5IDxtb3RpaEBtZWxsYW5veC5jb20+
CiBNdWhhbW1hZCBBaG1hZCA8bXVoYW1tYWQuYWhtYWRAZW11bWJhLmNvbT4KIE11aGFtbWFkIEJp
bGFsIDxtLmJpbGFsQGVtdW1iYS5jb20+CitNdWphaGVkIE1vaGFtbWVkIDxtYmFsbGFzQG52aWRp
YS5jb20+CiBNdWtlc2ggRHVhIDxtdWtlc2guZHVhODFAZ21haWwuY29tPgogTXVrdWwgS2F0aXlh
ciA8bXVrdWxAdmVyc2EtbmV0d29ya3MuY29tPgogTXVycGh5IFlhbmcgPG11cnBoeXgueWFuZ0Bp
bnRlbC5jb20+CmRpZmYgLS1naXQgYS9hcHAvdGVzdC1wbWQvdGVzdHBtZC5oIGIvYXBwL3Rlc3Qt
cG1kL3Rlc3RwbWQuaAppbmRleCAyY2E0YWFmMDg2Li41NzM2ZTYwYTU3IDEwMDY0NAotLS0gYS9h
cHAvdGVzdC1wbWQvdGVzdHBtZC5oCisrKyBiL2FwcC90ZXN0LXBtZC90ZXN0cG1kLmgKQEAgLTg5
Myw4ICs4OTMsOSBAQCBtYnVmX3Bvb2xuYW1lX2J1aWxkKHVuc2lnbmVkIGludCBzb2NrX2lkLCBj
aGFyICptcF9uYW1lLAogCQlzbnByaW50ZihtcF9uYW1lLCBuYW1lX3NpemUsCiAJCQkgTUJVRl9Q
T09MX05BTUVfUEZYICJfJXUiLCBzb2NrX2lkKTsKIAllbHNlCisJCS8qIEtlZXAgcG9vbCBpbmRl
eGVzIGRpc3RpbmN0IGZyb20gbWVtcG9vbCBjaHVuayBzdWZmaXhlcy4gKi8KIAkJc25wcmludGYo
bXBfbmFtZSwgbmFtZV9zaXplLAotCQkJIE1CVUZfUE9PTF9OQU1FX1BGWCAiXyVodV8laHUiLCAo
dWludDE2X3Qpc29ja19pZCwgaWR4KTsKKwkJCSBNQlVGX1BPT0xfTkFNRV9QRlggIl8laHVfcyVo
dSIsICh1aW50MTZfdClzb2NrX2lkLCBpZHgpOwogfQogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBy
dGVfbWVtcG9vbCAqCi0tIAoyLjQzLjAKCg==

--_004_LV3PR12MB914444BAE4DA3B85B4179A4AD47D2LV3PR12MB9144namp_--
