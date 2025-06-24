Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3BAC77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44F0040B9D;
	Tue, 24 Jun 2025 15:55:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 900894026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:55:54 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OANfvH023818;
 Tue, 24 Jun 2025 06:55:53 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2108.outbound.protection.outlook.com [40.107.223.108])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47ft7h0bwt-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 06:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1RpVLm161Rqx/PG6Umc05N5CBy5txC0VCXzM1yvP2BDYQZkDNtR556wtwqHH3SNPt0t8QJZIvubkuSmhzgMlR8YWUUKkLbcmlsRkCwvyfC83zHrqEeoMAwLcGJCoByH7/tpKMgRBnCKiU0kLopQznckfynSya0BeelgjWhtIkXKneXd7G9RDenqHJBOQS40qhwWWkz5w9dkwP/d4D7GS4U8yMUrjkF3YAWT2RAVBcwMxfYq0jqET1p/UfI3o0tKvxCCgEjGSdd5XV7gwSlJG7fCwkfFu5AeGHYArCPmXxI+yB+1kMumIFJ8M5gKadO9kLwt7tzz58Q3GYGOCoxXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPyJjc4svMRXMMw8zdDXeIe+5ss0fU3/Hr+bvmTDwAA=;
 b=Shm7EWkWY62ppXkgxQyyebxW65e3OTXegPxgH+wkquiTUrmYR1Wtg5sSeFGALOid97cG3maOt9vNgS9d4Zn2ktw6b5kRLbmCvj3D9yIM2KYDVDbL3y2jhhSKHe9M2BsjfAnQCS20jQfOJCXEn51yZ05T1hPgsvwJjs0ApXGv2ZPEVo50jBnWXfTmOZWyKrAXohN3WfSsXouie9BvbM3nlfRB7NDMVw3kFDbApG5AcDwuitQyvK85ZNDUYnsRgKwYraHrZ0LF7rtjJ7wxXmYo7iQPEUfLo3xK6b4rmlQoYcgfNlQ/80slWbAetnJVThdP03BqK6C+joAs6q5CwZGTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPyJjc4svMRXMMw8zdDXeIe+5ss0fU3/Hr+bvmTDwAA=;
 b=uq4U0eirziWykrtVWhuKj9OtJCf7htkvSPkk4/VRx21suq7Sattn8INGfkKH//90xz07QGYNZe537bR36QidBctEJLe7V87F7tK47B3au5urjbi+8eDFzXnyBqZn7KZTSvS0eVGlHRPAQzd5y12vLDpolePr9IfNCoNks4a3s0I=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB6099.namprd18.prod.outlook.com (2603:10b6:408:231::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Tue, 24 Jun 2025 13:55:49 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:55:49 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>, Shally Verma
 <shallyv@marvell.com>, Ayuj Verma <ayverma@marvell.com>, Arkadiusz Kusztal
 <arkadiuszx.kusztal@intel.com>, Kanaka Durga Kotamarthy
 <kkotamarthy@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 3/3] test/crypto: fix RSA decrypt op validation
Thread-Topic: [PATCH 3/3] test/crypto: fix RSA decrypt op validation
Thread-Index: AQHb4bwVCyMYiBYtk06opj6qkBskD7QSW7ww
Date: Tue, 24 Jun 2025 13:55:49 +0000
Message-ID: <CO6PR18MB44848198BF181DAEA79ED6ADD878A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250620081921.2145-1-gmuthukrishn@marvell.com>
 <20250620081921.2145-3-gmuthukrishn@marvell.com>
In-Reply-To: <20250620081921.2145-3-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB6099:EE_
x-ms-office365-filtering-correlation-id: 89117971-64f9-479e-68dd-08ddb326d347
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?srxQpbhMqESW+kR///lAlhDeyc1drQ5rewnNIhTcVg5FHxX3TaE6OntIMEvZ?=
 =?us-ascii?Q?KWvE+yG6BGAMyChjr03C1b+uTGzHRReZLs1sQguK1909RDMsfigd9j0MGqWG?=
 =?us-ascii?Q?kv2f/lbsJSnSffqqNDek9CLPpiBz1Xm2qXeec0w40Ihirau4C1dZ4lEuV+4g?=
 =?us-ascii?Q?OacWHq7BfvJlPTs3wEbebQccb2MalsfduB0HpYQAqsk8be/Wj/VwpWRIsjRp?=
 =?us-ascii?Q?tfLltNI9e2oE962JuWmrYWZ7bp8J7lG2LS/t8D7e1vNr5gMy7Jq2qfu4wLgZ?=
 =?us-ascii?Q?DdLAoGXDF+rOfLBk4VvctjGfJknI2VTlGbTgsiOmsmQEYhZzqXtW6GmN5gBl?=
 =?us-ascii?Q?dZR1yXGU1sQmCJr0GmpsZJ54fQKZM+xlcZ/CYlVuQJIY68R9LPlk4zjTn527?=
 =?us-ascii?Q?ZrWbprpGIVmHlO/BUlvcqKmJd0UVbZ8cUDQ0MvC9Ky9r/cfC7V6NP5oEmmr6?=
 =?us-ascii?Q?OsjaBvAibr53Hz1eolXbqpLAPZ3k/vaf8sP6GZlWDRbVnxjQmV6nHbWgy7RZ?=
 =?us-ascii?Q?UdGNNPRsdeU6+ivqCQSuFfX57VPEhhmV3UpZDzww9a7aeMP3gM+5wNC5P9BA?=
 =?us-ascii?Q?MH+lAfreLp8YnpTEFIiF9axPoiNgnVhf+xmxK0gVS/4W2LI/frDHVymhFy/e?=
 =?us-ascii?Q?t3AtHuGgI8HQJJ0DOZpPqvqlOuJqgzVwdS4qESRuuk8Nl3LPxLizPHBTnjNt?=
 =?us-ascii?Q?MdDdMRCSSS+vf2yu2CeKW4I5bmuev55V7MaXTq7Riagg0TSpU5iNFYledmCr?=
 =?us-ascii?Q?tAdN+Y7MMW73lS+trfjIHyiOUBkwoC1LVGO2pGyjiQvrSTpm7fYiOZXbSi08?=
 =?us-ascii?Q?FMK1ypfGw2wtJbTARNWXV2xm1Ybegh/0BY+DXSohK5n3RyXipgdRBpLcDGzI?=
 =?us-ascii?Q?eMHNWPy2ODqGdUT8JdySIlRkm2In4xCHNGAAeuke+poMQ4bB0ltgr+1nFqp7?=
 =?us-ascii?Q?Nvvfe/bIuDrrvlQGJsyWtzlozcAhmYVHwpOkEt72PNse8ozXzZDsYb2Fwaxt?=
 =?us-ascii?Q?M+4GekZqNsUYkO9219eGLfTi7lI8w2hXs3hsuAVsysjS9zgrc468g0uGv+7e?=
 =?us-ascii?Q?QwKpKGoCxAk7f09fKmuGDdDzu8oajaTgQoG19wei/oWPWtpjAp5WQTzMW4Zk?=
 =?us-ascii?Q?CxhdrPYzDDKW/ntCAVTsH38Rx8XKjVDK5qE1y6ANojA8JNcm2zvalwUGyPSZ?=
 =?us-ascii?Q?ReWtGu1O4TWW84gG3KNvpvieDefwtrETNNrFdVIo0n3xyRjBZt24ueCdoLwN?=
 =?us-ascii?Q?n8uN79sgjAKr1w2uxc0TpyHuEuPhk0a+qv6L9RNWON+bnViJsfhY/FJJcNAA?=
 =?us-ascii?Q?SRcLFwLkkhRe/p2gRIelru4iapEFOPn8mYMaUn1SuNV4NKOLoi3qmuRTev+C?=
 =?us-ascii?Q?fxFW86ELCajklJlFYq+8Y+P5jJGT8QMnIMGHACYPnP+vUglaaHO3xGVm5MGJ?=
 =?us-ascii?Q?tgHdjHwepxXUYcqPdphzIfU+aMlPl2AKqcYZmOODZkeO46dHL43TaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5DRwTmSrJ0OnqLOWnNUjHkSeXQQfZ6+c5+6A2EcjO5jJquqc8EpENDuH+JLk?=
 =?us-ascii?Q?9YidiA/X/E1Rgjpc2e5loa1iTKLM9Jo/r67SDWZSWOcYElkQXaeCLnpCtvvM?=
 =?us-ascii?Q?lbskatjn+7xpVPEm/3nV7vdY2P3NS/OgEQ4JnLBDAuYAUnROFf9VCXmXliBx?=
 =?us-ascii?Q?PGH5Xxuq+aa8djbk/gig+P4iDtAc9u8PxgYdYKZgPYpUNBN8thIDC80vpZRh?=
 =?us-ascii?Q?Xo/k4w/irDvhGpFJEXPVU96TJCkadKan45S2X15ADyuVIRP2sArq3w1mmzYj?=
 =?us-ascii?Q?HWILVb/fWMNeIh5Dsb3zDQQE7MY/b76LaoFv2rSgR3nWuUnivus9rHBoRXzV?=
 =?us-ascii?Q?Bc3f9mElffPaNPl9ff3udMFC+sbq6jtly9skx4WpF9+G27FxTDkYfSmpGEUq?=
 =?us-ascii?Q?LwfqK/RjoPHnoJSIKooSxgHxpg/T0ygfo91vkq22rDjSS6Qe4Ii74Y6ZCnG7?=
 =?us-ascii?Q?XEmJFXlgpRxUmpEvN+TwqjUyVkwIrk+NaHYLd/KFGK7ZdcV69pturU69VcQB?=
 =?us-ascii?Q?XP1NXrVFUKqI+aY8mjfKkxX4Ps1DKKoDblpkrWJPE7cEqxDB47G2qSX0ke1c?=
 =?us-ascii?Q?qgBZoo+LY5K+4xze4IZrOifnw7l1oBtOEREFbViummRhvas0Yfcnlvmoi5hV?=
 =?us-ascii?Q?aXXK+JwdvipKSa+eKohKHAYrDRCz5AM+9I1l25AWZb21GkhvSc0lGomZ7NEe?=
 =?us-ascii?Q?WU2stfLS0aHbcnIL1JnToklQ9lbK0cBq6dc0dmLucuEkaUrFiiPg9ISirZ9n?=
 =?us-ascii?Q?b8NEqsY2M3TcITZz7gC6BSdUIhlcZn/DKBRCZ9YyBu7C6IjN3G4Gj0Cupr2U?=
 =?us-ascii?Q?Sxe86KZ00oyPA9Vxs/4oidvCb+X9sOnXQ3wHyVb/AqKL6rpKqVZpY3yXuRmE?=
 =?us-ascii?Q?7bca+tM2ZV3mPi+5oFXASF2PrFNxtuApu1Yz0g2mi8q62K3KqLddRmBCe5mm?=
 =?us-ascii?Q?7kKL+apMa/GN6GZjHZfGtZBbJrxA/IhC4J9TmnnIBtZY/1gYoRrpnHv5OM27?=
 =?us-ascii?Q?HAsjLriwOGEGiLP6/npL4qSIaLzC2Fmmwbq65L7GgRqn0xEHjeijXdQhCjBC?=
 =?us-ascii?Q?qgP4769TXExYSEDcvBTyfOvCykeGaaCg7LqI+lVXdhPlQSz7rpbA4ukQWoBM?=
 =?us-ascii?Q?RDjFJqW2o3GoniDG864p92i6ciTjjeQfHugU8bKDf6Lz5FvdpNcCwXa1c6m8?=
 =?us-ascii?Q?pqN1vV24XaaYtJ9IVVVRUZkGeQdpmd0uNNRxwieEB0GEobQfzqkHTEbJuvCn?=
 =?us-ascii?Q?oyjeXz8Ycx0bT6eKPgyW5pYILR7JZeHKIQRE6dvL+xvdgkDAkJxGT53KnVjC?=
 =?us-ascii?Q?xX+fXhaL4myShls6tCPJ6da/SsXQ/JSXBh0cCaAASZgczO7s4JuWQmzn6j2c?=
 =?us-ascii?Q?CoYNPcBbnnSttzk+JQz+Qkpg+ac5zt+I8IZwyyWUsfTEUtfFUtYqo8gUeU/l?=
 =?us-ascii?Q?FzXpMSAcMJM8q7csPCrSrmUjnyNN4j9ZHuQNgXAB+3zX5Cqg/x3lLd4inQD2?=
 =?us-ascii?Q?hevKElgLajOwniQkVl0h2c7jco2YyJ7xOeVdiAbVTs9vb+DSZD/vWQ3+gm6V?=
 =?us-ascii?Q?v6x8K+Qfwk9GLSlnLEQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89117971-64f9-479e-68dd-08ddb326d347
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 13:55:49.0697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wB9b6HGl3NVIg0qVcHqhS5OPQY+yOiA4cQnECH3UR6vNNl+tfGRFKklEXgG0dN1cdjxppp92gm+liIwlpxoyhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6099
X-Proofpoint-GUID: Iyvc71lGOFWSf6Wih8NlhlAZhFPZYUZW
X-Proofpoint-ORIG-GUID: Iyvc71lGOFWSf6Wih8NlhlAZhFPZYUZW
X-Authority-Analysis: v=2.4 cv=Nr7Rc9dJ c=1 sm=1 tr=0 ts=685aae69 cx=c_pps
 a=A3LX+wu56ikakVX7ADtWTg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=hncNp9nqJ3euTpw7_SsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExNyBTYWx0ZWRfXzJJw4nSnQfYO
 BzjKfglch6VMGPX8xoMkYhzDDKMown6gsKj+FC0kyAnDAPr1pLr52I9rDVBYDrtFj24W4jVFmcW
 +onLlufj0XzJ2m6+aG5aRCURVXJm7jWcZ35SLOugg9mGc7TZPKQPG7uIyB8dDZwbpcvAuoxhebh
 leKXQAfGrecQuij6dwYPLDZw1lwKi9ADIdgGvKvIytmDha73Yquwi7TLaGEiIY5EAW6nAdMjequ
 oohHEMQhJ2i2KhEQh5QnYr2+z2P+KA5kRuWOJv581Mxh5aEsCnoNaop8Yv8YqarG+rtd1fdNfk3
 4gHNsx99Qg9TwDr1Om3Fx8cqRQQfS5eoh/8Z/TDfmm0EN+s3gTHi4QrFlV7R4jvAHTEYzL0HyPN
 HfFjWgJQjaiBsZ37Z2ayhGAyh9W3GfBo8E9LrEYqlTb7BxaXpHy6qKWCSux5kV9VJ4OEBDLO
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

Recheck-request: rebase=3Dmain, iol-unit-amd64-testing
