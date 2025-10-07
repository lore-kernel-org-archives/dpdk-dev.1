Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A43CCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 10:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FAAC402B6;
	Tue,  7 Oct 2025 12:41:37 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3E59D402B1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 12:41:36 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5975g8dX010640;
 Tue, 7 Oct 2025 03:41:35 -0700
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020094.outbound.protection.outlook.com [52.101.61.94])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49mvxarggf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 03:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHDUCWW0vbjZNta8++V/TuSg5FiNzMaE15waUx02RxiUM7LmAHvzEG1ybeQSoY5q5bzmoEuWkXeSfEpPooijVymQOc6B8YNME7jYUiwBUkbSl6BehetaHPusB+BXQepNxJ1O8qHc6UHEbXI2tdWS+R8IB/WJVP9Q7J4vGaCubfdPhwwsQCGQuUzaj9M5CqULJeT7E/cxnoAHrOSoUJcbljB/isMvFKJQMuof4BEJr6bNUmS/jw7aNl2uWBxDMyGjuRyl8DtjAP6tnQQqtvR0W94Kkr3VVJc+fLuw1VCln77aF+cH1hBFgoyTDBkS2lBKk/EEndwp/0NlWRuyXm2l7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XK+B80LATMtftNpTGfroevfbjADcfudYkADuKSSMV5I=;
 b=PGVFaaGat0YPqoigCditlYg6Scr0jNDzweooF3mGwriEdDnfOIHXMuF5B0dDTYTKtzQxgEa5zJ6GuzJU8bMRn4mO+mCirIkv68vfYiyOazbxLIim6qzx5jsngceLSwoI1q92uHl0NvWm6XYG60DdJffx/xRkHSbyXVTn/lyw3uVGG/T4XpbOs90PBeRoI7IMRtX01qAzeQ/wT5frEIPTIWWYZ2w+r+j9Br7qH17dVqjwEqemndm1dB+YgwHdZfaJFO89vn/oKruKNDoX8uvQpm/HoVqTzdMT60LIxw+CUYGj7/qZ7EkZkfilsWUxjQyVY/5+KZt3VlEQgQ9OcUdc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XK+B80LATMtftNpTGfroevfbjADcfudYkADuKSSMV5I=;
 b=Xv7fk4gHPmi7V6Ocmyma1gcG8kD9nLNIb0j8VnDSq/e8/7NqyVm32ZlMAMZieHylAwKndGx2pOMFnlZvg1zz0K6K7RjPdhxggiI/Z2aCQcbO5xCx1r412+xZTB6jYnzgr+1tGMTPV2vv3tE2sJAkr69zpwzsE/rXjzQEO9Y1FGU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY1PR18MB5969.namprd18.prod.outlook.com (2603:10b6:a03:4a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 10:41:28 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 10:41:28 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Kai Ji <kai.ji@intel.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [PATCH v4 1/3] cryptodev: support PQC ML algorithms
Thread-Topic: [PATCH v4 1/3] cryptodev: support PQC ML algorithms
Thread-Index: AQHcNN48VNaUW/FZ5kqR2MGXMCDr37S2g++w
Date: Tue, 7 Oct 2025 10:41:28 +0000
Message-ID: <CO6PR18MB4484A9EB49B07CD8BAE415D5D8E0A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251001175658.2303-1-gmuthukrishn@marvell.com>
 <20251004032259.2707-1-gmuthukrishn@marvell.com>
 <20251004032259.2707-2-gmuthukrishn@marvell.com>
In-Reply-To: <20251004032259.2707-2-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY1PR18MB5969:EE_
x-ms-office365-filtering-correlation-id: 69b637e1-b809-4be9-e74e-08de058e123c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KhtjJmWpdeyBpLr3WDab0ey6Pyyr9XkgS22cOWgWCFRPIslNWzkEbnilB8oU?=
 =?us-ascii?Q?vvTFqLlJ3BuLYXoI3bZo3sssDsD0Mw35ZyojFrD1RveTKqPn7xrQeuuv9zcz?=
 =?us-ascii?Q?7niO6XcFNwz9b0JVlDsEm2ew/M9K6OF66TUNvSB7mXK0IH/acUNKv8cP6dd4?=
 =?us-ascii?Q?SzKmKnh5ZPDeY8GT5IecrX1oPilYVMpzDROm7eTwfVjRrV/axzVRyRq9tml8?=
 =?us-ascii?Q?2KWBL765tMj0D5CzkcVGkeqWcUNtSe8h3jOk1YSAG3gsdc/R43TLP2/c/yL+?=
 =?us-ascii?Q?1y2RfASEWpJh0s/SM6+dNBcAodbMBUuHagXOIaSRvPpUreh5A0hSMoqRAjna?=
 =?us-ascii?Q?b3I2FBxMCT/L0nlZQ3lnUToTSyTNPsiSppNEm+IdRGLQFg1Mx1AuXOAtemht?=
 =?us-ascii?Q?ptMWVnbmBdx9TDiEK55P3X5lEstUcAabN/LdgAS5O8rq2iH2eL7EQg01TG0s?=
 =?us-ascii?Q?dhsaKBKYbuIXGfIeFKl0v4LKmXLM4EkpV7SJRXer7OJpx+Y3yAhuIGT+toFR?=
 =?us-ascii?Q?SjgqNGmazzjX4Opt1nNsUNZejqGlHCfrwKLVlQR9/tmlA+pudqZrMYOiHjLX?=
 =?us-ascii?Q?FIq4RGqPwM0jOe/LUgL3tk1vZg+LDNYc4ocezYNbYo88l2TASYtejLplx8xB?=
 =?us-ascii?Q?E+INzV7v/x575XPZ8KUqGJ5pC+5IYpDxnMenZyUue+Qmv+1Nr87uDm18Y0T2?=
 =?us-ascii?Q?Z/u4D9NriwmSYq6hH7seMCCTsZLoe+PS5wLb5ecHgvfOqhvhGKZGGqpjODVb?=
 =?us-ascii?Q?gwsx/TywEM8dj4y3kXyu21RQ+16PH8NYng9sKcaC6QhQOcWc23lw+/gP7PyN?=
 =?us-ascii?Q?ul2C6eAS+tXzR0B8pg/A4koEkzV+LSv4WcZs+wS/N32kjQnz5dHeV5rd5a2m?=
 =?us-ascii?Q?FHNTeZXh/Bs9srjEpOu1Eon8RyMQXP7vA+wJZE9yf2jz0oOhcK9x4zuiWMib?=
 =?us-ascii?Q?TdYFxLdVYdnvXjvQTXjKMaXh2+4rwcZQka2bt1b/KGQL/4XClp7aQuJYHFD1?=
 =?us-ascii?Q?bL9pUXH25EOq6Btza6m9slL0130bOCRaYAnOAJl9pmKf0ScMqTs2BIRSZkQ2?=
 =?us-ascii?Q?58B/Fz7S1nGVOAEVjLHd8rnOjZmTyh/RAtxjGAhDprPomHYbo+/we3JmkUMk?=
 =?us-ascii?Q?WPAKAwrzQoMI8jSMBwe7PW1bpS0DCHImC+UIfXcmlM3xY4e1pqVT9p1ybC7V?=
 =?us-ascii?Q?qPwAYyYozzoiZ5aIwj/FKl7J8lugKq5dUBo1RMTydRbQGK5yB1iH/Pzkiznv?=
 =?us-ascii?Q?3zg0ZG9xl2RMrlgRtvMRUwGULNOkaFomPj3ZHlfndj57r/IMnWGyhFCtaFCE?=
 =?us-ascii?Q?kHHuVlt86CbhjHIGAZNZ9vq1cKkw+Ez73vFmqG2d5HUYeyUEU1cc+wsk3vwO?=
 =?us-ascii?Q?2uy7SpZzdf/cHttpMHoVMjEAP6fa9MaE9xkIXVYIrBmDOkiTyvdnsUwYxcqE?=
 =?us-ascii?Q?7F6URmSRv+6406Qt17p/sV2qxAO1p2Ht4T907wnVHVxD84p6aVTikWLCq3W9?=
 =?us-ascii?Q?wYqloIQ+umwo0hpWI1p5AMfneaE4ni/XOAA+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TNPVZzAKtdMzy7b/AMYMbF+BQcl86ZKj7I67MPd9GUSsEOh8kHfkIeustThD?=
 =?us-ascii?Q?RgFPrM85GsZ8hTSZVjcKccY0BrMJD1m6N+f/Xxxn1Gq8OiYcaIZSaJBlSJ/U?=
 =?us-ascii?Q?PTEIjx/uUV9vAj6nrKA2ebo1abDsvXMCEU0K5zuuc8XIEcWs6jFWIqLTXfnw?=
 =?us-ascii?Q?WQSdw/rkq7vfF/f9lI+3YO/HSiKqZSlBpc1DiF12PIh3TP6x++DLGcL72Wvp?=
 =?us-ascii?Q?wbii3b5/X5SxjrJXap1y3tOEnSwbqNanoqXTn12dh8J9NRNs2wUz/2kFbYOW?=
 =?us-ascii?Q?YVPmgPBzSrdb3eyMlkSFA/YZ/4PWH2cbWZbXmCOC0I1Pf+Nc6uVPRlTMyxiO?=
 =?us-ascii?Q?S8bHUwFS4ojc252NT641qQ66QOZr/kBehmTt4+BKYkpUOwq3T3bf6p2XRRcv?=
 =?us-ascii?Q?frGaoJrGHLYO3lN7mOE/BgtBsOBW5aDYVARi5Gy/Lp5uBMDkYiCP/lMLhBGo?=
 =?us-ascii?Q?0e7dPFTbHT7xhS6O1ldsrjP8cWZQ3BeokE3CaPm8KjRW7DCxkbdFEOchdmpN?=
 =?us-ascii?Q?0JxOoGg/Qy+F5qlMOpPGnMuxYbjhp1Mgc/m0duxIfs6Uclinf0GiPaRJWbt6?=
 =?us-ascii?Q?+Xiv4zgDHxI3+CtVVt3E7AcmCPLwqLEQ7gh5DE1emX6hWznLr9KJnHzlH1Gl?=
 =?us-ascii?Q?6NFfb020kQ0il1+j9r5pPe0K5XB9qqE4vCFAuCzwQoZZv3k/lA4r7yVsXMoW?=
 =?us-ascii?Q?rS78s2EkR9U/h7HRjbfEXdTc7d0/OkG0+gxs2QYKOqFGXz2GCTNKSpP4lSn/?=
 =?us-ascii?Q?391r/cPIquvXaFeC2PRvF1orNnAjJdVqQfg4zACQSO/B0xEahivpdNEFhabE?=
 =?us-ascii?Q?YoZNCfQ7nLeW+g6kUzEWZ3kyiGVVJrAIvxDVJK2+YdkskL05G0A4l+Dh9b2x?=
 =?us-ascii?Q?fujlMgcZNP6PdCiyklk2T7VeE5dsdhe2tDJ0BggcXFf4P9pkbApvjBcPbb9g?=
 =?us-ascii?Q?vzM/7J4IRpZnO9vaomWvRkJLOmFDdn4MxlRTGKhzYNW6co+Q8+tgf6lqUPGD?=
 =?us-ascii?Q?VcbNZOl4e4G4/WvrqqgRoQW/Y4LlVegtzsY2NXO5KLJ6NtI7lUq9twVCjZ3O?=
 =?us-ascii?Q?6HCGLB+qkLJjv3CpA+cpo74upL1cZAtnxweNgLnu1xwXhTadGPpwodt6TMS4?=
 =?us-ascii?Q?yzJgWcJyp9qDRwrk4IPPcUF23dK9YrTX9pTpjmgLNOks4ikWky+mPV2s7E0d?=
 =?us-ascii?Q?jsWqmAgP+ryvRe+o4/8V4Y+ATIbYnblqmj7wHZo25+SZAXExbUI9QkEa1w9k?=
 =?us-ascii?Q?GlpTnwjVjgCJYqAFE2eDv/WgIVyKUJebW4up8yU1C5LpmbaYLGUWkK1mzSzz?=
 =?us-ascii?Q?jhFx+LYRG86Kp/bVTMQjCQk7hUBmDOyqQZHrVdpiQBZ1hPPz80X8rK7KAQ2Y?=
 =?us-ascii?Q?d7/6pmykPtpHMYI5u/7TyGxCa4zX5mSTmHi6B0w1k1IA2fSlG+2U8nLGN/xI?=
 =?us-ascii?Q?pJAPvm69HdlTRiXdG99dyAgT+K/Tlfog8nFJ03nYtDGHwLQck06tX4M1CoVU?=
 =?us-ascii?Q?82MSv/xtzk/JW4YgnQQUdl39/puHwcTL9ftKQE1MtV1oQFNtCdeD+dvrdGLf?=
 =?us-ascii?Q?Sf52yrz4aYGsosiJrqIrQVtuqtMHHTPkw0JlE7re?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b637e1-b809-4be9-e74e-08de058e123c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 10:41:28.2624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSpO4AqfaRPF244GjzaQKiXcpHt8UiJCRa4JGtPZ4vjTvJ9QYyH57Xv13EOVSQKRushzhFcDu0qg4R8QcFWcbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5969
X-Authority-Analysis: v=2.4 cv=HesZjyE8 c=1 sm=1 tr=0 ts=68e4ee5f cx=c_pps
 a=gT821fuiKW6V8kp6mfQTHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=pQMbAqaBzZpdFd7-Me8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: 51uOIqfMqUBFuP3Juu-ii_prqKFFwb7n
X-Proofpoint-ORIG-GUID: 51uOIqfMqUBFuP3Juu-ii_prqKFFwb7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA0MyBTYWx0ZWRfX+XOiwRPXNNIA
 xDFoeKQB9RfWzhxO3hs9mhCAWd9xJYE+Ci7IBq0zS3UzPPAxm3RWjz8x1fz+/qPT0/Tolanh5pz
 0IuyGfWKDQK0OwlpiIOWOxJTnQMItuBNVKXL8stUC3oIzOm3x+TvbsMnxpQO4TMmF7BKVJ/Cgn3
 XmAN+GGTcmuKFo/wmDGL4fS6dlF6O8RvPLWLhYaUPLGV5cCMuKiv8wfQz9Dsz9CUp9f1jjlqWE+
 aS4gQV9i8ikMjErySS51mnsyVLL7SrB5EiMxw5orQuUFZW4bGZ2KBiH1J9VaxzLvOwy+02Dt0/A
 Sqwta5rnrkCjMbSCk0HWhwVLpbhT+rJLwH8t9h9JfhLXxBAXBk6ipxZdjJ5xsPN9WfO1JSspNcx
 7ArK0Q5A9B2tSOzAMOm2EBpt28wS6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
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



> -----Original Message-----
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Saturday, October 4, 2025 8:53 AM
> To: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Fan Zhang
> <fanzhang.oss@gmail.com>; Kai Ji <kai.ji@intel.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Gowrishankar Muthukrishnan
> <gmuthukrishn@marvell.com>
> Subject: [PATCH v4 1/3] cryptodev: support PQC ML algorithms
>=20
> Add support for PQC ML-KEM and ML-DSA algorithms.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
> v4:
>  - enum and var name changes
Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto

