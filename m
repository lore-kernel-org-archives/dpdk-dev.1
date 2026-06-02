Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B550CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A9B34060B;
	Tue,  2 Jun 2026 11:03:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 26FB840150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 11:02:59 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652037rU929924; Tue, 2 Jun 2026 02:02:58 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022114.outbound.protection.outlook.com
 [40.93.195.114])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxgb3gp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 02:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQSmsw1gXmHTVkVqCqN27nnFclgTntZZ+2zQ03oossUOzhjvmE/LcZ76NRaXFnxXNsz2+ldlhTW9YJCoIJnqGXngA//Blofe8mpSxXgxRnO1U8v7FD4UIK06VLG0lK+d5mf9xMDXVqq07IIlR+ZmUVx8oEb9+WMRDpDxjwQP1ec43q9h9yzgkt2VoP0Fl1izkV9um62cUAe7Q6TzYD8npYEyL3FeYp1zWICPN8uH2RT+il95AGkJ9Z2OKYmLCJu5TSfZ22i/+E4LgwypKmb67XoCVvatrMN5it5xLnEheJU1nV9/v3KnIbz+06ETuS3HW8IBzU/YeqEMY9K3JqCcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hgiS7N3GZ1UQixiBHobwZuFD5Gix3u3k0ynI3EBHLY=;
 b=q/TrJxVkmLBcVtOW8szK0yp1wC0+1vCJJ/vhqHN0EHSWYoSuFteZIaQ7lycKWpIHAlVOSV6aOL9hEHL7879Jv6Kul6NbQ6h3VuINUZDu+wG0EQVyTh0fEj78W+AzJ8LYXfEJmlszygotVP6kBM7VGAOR2r8lQ1UjCMrrHl2o47fF7zOk0Kon7KApDrc5XteXlV9XK0ETYunewe43MdiwHG6U++tv4XRQKU8iG7k6IYH3QHDNHIcr+I9YSnMeKxw+EOIEmNmqAf9HSFXNCEvneepoNIvFD51jUsKBH3cKvPwOwwvOQY4UmVsKCbIyrH1I7R7K/LRaACWhSHN25XZjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hgiS7N3GZ1UQixiBHobwZuFD5Gix3u3k0ynI3EBHLY=;
 b=SI/Hf4e7/ZB+9IxkCAbSSCdRqKhsWPBlToLdmkb2Ehjew2KwVRrGmAYHZb4PDL+VL2s5OSk1ggIAk+HLQnXn0Prh79ohraaaziOQRYyE+U1ZkNjBVQKI/chAbfvVYLKwlErpCH/eAu2K7I50fOJ2ewM1QQLEKN/9nz9LUklTryU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA3PR18MB5299.namprd18.prod.outlook.com (2603:10b6:806:2f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 09:02:55 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:02:54 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>
Subject: RE: [PATCH] app/crypto-perf: support ML DSA
Thread-Topic: [PATCH] app/crypto-perf: support ML DSA
Thread-Index: AQHc7nfbJeh2X5aQsUqR4VujJWOiyrYrAA4w
Date: Tue, 2 Jun 2026 09:02:54 +0000
Message-ID: <CO6PR18MB44842AF86C0A5838CA7CDCC6D8122@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260528075853.2206573-1-psenapati@marvell.com>
 <20260528075853.2206573-2-psenapati@marvell.com>
In-Reply-To: <20260528075853.2206573-2-psenapati@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA3PR18MB5299:EE_
x-ms-office365-filtering-correlation-id: 2949f3b0-f0a2-42e8-c901-08dec085bbe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|38070700021|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: sqONaPFDkTUDJCsbZEiyZYFuDAcsV/L1yR3tNtW4JbKLevTlxAcQlJ4P4M8aeR75HzYicvBVuEw8nwBt2J8pC9bjyo0ICqcc4SUO8orsrHuOY6A24DCqlqTcQBKdnaS/IvoItVhI6aZQJmVIm/M4H7Lb/6PZYBtR21V42qn9OuLnHVaY4aA/redlGfFI1eNzTYSEmHSJktDXgIjPUNPsEjeJkPUZ7m6DjfTgWTdgsAuIuv7Bt1/LH4lfvFLBA5KgN55edJx3nab4kNu9EurOzX9Ik1D7hUOh5MTqcfU79pVlHGehxkmIKBkHcca7CjEftqsh6swi4QjIWn77FmBkqDR0YD4JHvVE3/gSWFE14x8ipxCSDiu/WAQ5fZuEy34ZsSAdd/CTA42PQTVK3DAUhdONu6V9iwVFBHZFf4ClVNVirYiZIS0BDCKxJYTzfZgiOFisJ/DZGLFVDS1azi3QQ9xnp+Jr1bMCQ+01qtHpXeilPZ92of24CAMMQMUbtZxSRV92RBm35mIYJFVuWggGzWufHvioue1CKaNvWBg4Tmn7wo3UogWxP924GJXQlL51dANLx+E7UNOt32kGY4wzDrLFLmRp6F6QQBf4GmvpRE4ohZvSdI5xTIYDYxkyirAh/jjTAoaeZs9pvHOCVpFZV8wSbAomutuYufcLMjV7XPOoEgRReieSowJoBFHZZhH+mCvHwN3uBC/YrD7yDieZl3QMbO1QnzIPt1GsI4Uz2HJ+hTsm21jnbhLiPSHLjirq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gx3NoF4Tn2V/E4IcVePw15ldNv8V7d2cUX+p64XQfUN/w7fSiVNm3+2ZzgI0?=
 =?us-ascii?Q?A7VDtaIVPDoOBIfQLy+CNfsPLr8E4kt44IY1rHfaUwZHzimpn2OtwWQ/0MYC?=
 =?us-ascii?Q?Vc4IgAoF+mxYpxD1XMpuigVX4XDAbkx+IyCkzx2QKK7PLPf4CRdIIdleUasW?=
 =?us-ascii?Q?gf1EGbkfLCzaovf1U2yYYY/dY5gb3FrFJm/WzGi6Byezd4aJaXsVTIAvxfAm?=
 =?us-ascii?Q?Vs7kgPvPcPsFKl+tqs1UMyNYMALhwYMXg0FDY8VswLJSF+KZtbHCAJwiq3zc?=
 =?us-ascii?Q?44ZkxErQqqcPJ7daKRdQg7VBDit3GVkx5any3a8NR/ysIVoi13iz0U1e+INo?=
 =?us-ascii?Q?O2NL/Jbt6nw4b0Xd90hJgc0qvpGCLeTXNhtnbDaaMgxs3BnuI6pD5duDUGo0?=
 =?us-ascii?Q?oS0Su97rWkqG8YQn78txNOerlpj8F2F9gTX+x7RcyjLWT+br7q+OheX4naNI?=
 =?us-ascii?Q?3chE1cGYFMjDM2mnzrvlHANAXUz1M6/YfMOUvzKlkimB+lm9CciyQcyvrIbH?=
 =?us-ascii?Q?I7SSSVY4cXy8MCZPhEErLeeJCKlVvbovv6T7BrZ4s72JvNqq/RVfveFXA+HF?=
 =?us-ascii?Q?8VebFS7UgrbaXZU8NWYlauP4IcQYC+YY+s28eo5trXejSAS0NKtSkrAqqw6K?=
 =?us-ascii?Q?g+j/3l3hmJeBb5D6vCE+nrJI4aTyKuQscbR6SOZcvmwTWgzyPwgL8ELNrXRF?=
 =?us-ascii?Q?UJNgVEsN3NAs+ploqVbGrFjypsppWhXyhv6vJ3qUN9pjkXyf5ZZq0Gtlvok6?=
 =?us-ascii?Q?KjugLV55MTdyIxwYEi9KIfAwnJyR7zpj/Z6GHaJEk8JerMQA1g58KZwMpnXf?=
 =?us-ascii?Q?1fDi+4sd8LaJiEmOH9HouhOvHPuUFPqg5wUOYgZLMuVJn68bNwfHHeAG/m8z?=
 =?us-ascii?Q?RInbg/mv03WtrIlycNfWe6DZMa6ZcfaJcNezeud+A419hFDsweiGUf4A+jWy?=
 =?us-ascii?Q?mBndMcttgDQzQOOzwItzv1qu91dcUGo9vnjPymmwnGh3RuMhOKNlSyT37C63?=
 =?us-ascii?Q?PuHRm3epGKjXb6MRgBx6IKln5F0Sb/oE8V64Sfa9YeKArjlBUFm8T2FQ8Yal?=
 =?us-ascii?Q?7ZoJANF20a90KrOtVA5JJlnsWbtdc3VeYo3y3vcr3lOhch2W8IbmDJssWbwu?=
 =?us-ascii?Q?+fGe2eEPWWMN2d/F74rHRp/C77RMQAAerrjNbgpbnTitKPxtFiAI+7e9Vhrc?=
 =?us-ascii?Q?Voh0TiVwm23Xgb0lREFPpVJe6TAlpWCwecZsyiA7ZeGv3VTmPr3355Dk8kYI?=
 =?us-ascii?Q?2OkEXTHhe5JpkOCUgSMCC5KysAGNW7HtmFLAQAkUYYTvS329+MkwZRcL+8ev?=
 =?us-ascii?Q?fmIm4xzF+lqg2VdcEaukOUXzdE2TTpJ0L+IKjyYuV73wadjgfyyitgQZVZy9?=
 =?us-ascii?Q?ffDs0mfZogaSUJiVrxdxWkU1JtNj+Dw9R7uY1/aMJ/V9d0QNlmhoAUcqquyV?=
 =?us-ascii?Q?W6vW60GOJTFYkNXhtpslpHpOOtIwwopPxN6zfHu7C56EEEUf4U7OkEpEYzaJ?=
 =?us-ascii?Q?ygl3LVVpI9ujWQBf0RbKm3mJ6WTLticMhWHso0Qku63/i5aFVszku30jTTGn?=
 =?us-ascii?Q?r1v9N0SvrB6y+ZM9AcsjOJK1Jn9KgeteAUyhjb8NknlVSeoNLUzTu+uokexb?=
 =?us-ascii?Q?YoGNBQ4OInxTBUoPZUMcaDTgPuLP89mubLjsoM/FeSGSjaGMwJRyLSJ/W5wO?=
 =?us-ascii?Q?XG5p3S/uTetESph7qIM5DJdM+84y11eaXitDdYGUZJt6nY/l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OG0QD9xZTRIXSVUlfCvu4jTlnXNssKoEPgv8YTrYA05naSs3IiYNHZhjkPGddJWlgE3R5cxSnC3vQTYmPwz35BrIDxPxyK75Re+47DQ9RrqtjWocyUSxjuTZzIhuuZ2mXlLIbGcCtkBPfORuTnDy4CVncKn2vqlJ3eb1wyi7z6+3NNYMU1bw2ZKzfSU1+vq6NYXTGNi6yVGI/dHKEKweDFpns93dOoHI2kKEdd4N1w7CsKkRxUGgqQglDru08gm4GmxGIbwYcPo3FFl9vfM3faJHA9H7WBcwV0rL2dNkEr3K+N5loxb6SYAKami0eyYNU7e5igSIf4ARpKM8kdix5w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2949f3b0-f0a2-42e8-c901-08dec085bbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:02:54.8807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ihnzlUtbxAUSIFfdGaZJjWYhUOr7E7ijiaIQt6dz92TmeVNtABvnM5EwnOcPDm0cKuRyaF8b7gz26ilmUoicA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5299
X-Authority-Analysis: v=2.4 cv=V75NF+ni c=1 sm=1 tr=0 ts=6a1e9c42 cx=c_pps
 a=EUUFQbW0xDvYytXbvhUq/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=zPbZFmstQBdQPVF8-xgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4VrO82pHVmPG137XXCFiHP4I7hEmwfug
X-Proofpoint-GUID: 4VrO82pHVmPG137XXCFiHP4I7hEmwfug
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4MyBTYWx0ZWRfX/43+6ci4vtnP
 ViWzCXntZ9IhIJePGHoQgCOeG8mvWU4caD8t0fbLs9w6ryAxf79Ku3Kh55JIqUEsoMbDVYdWBL1
 YdFJBsQhSX+Fgcsp2JB27tnQe+jcriW3PRl4IxRGJ4+MUI5jSxEqt1o/M+bVtbkItVE5OBN363u
 e4bmxDPgy3p5Jl1ZdIs+pkYbnv17HrroFKFrMn/l8CxNhfUVT87bgMDGfHvMqxkQNdyL1/3fGSO
 gCbTyBMIysUxQilP5JklwDdDvDA4xShQIznTYh8lrOflnVMgrhkiM2zaQXQSO9kizO9XV8jMZd0
 S28JRwBox05GWn56Av02BCy9RGeO57h6JRPIHuMqShuGtUUhc0v4yamaKK4x/uGt29hDhhSO/wn
 0RQJjgvWUNy2I4NcFgDPDMSzsaaLS7nyfyW+L1Vy6ce2AEhdgUM1qTc38K2ksmZGTH/8HKXMvqI
 ZLnl1m4evr1Td22elJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
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

Please send this patch as a series with ML KEM support so that CI can run s=
uccessfully.

