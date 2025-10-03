Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB521CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 07:27:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A00044025D;
	Fri,  3 Oct 2025 09:27:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BAF0440151
 for <dev@dpdk.org>; Fri,  3 Oct 2025 09:27:25 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592NVMmk024177;
 Fri, 3 Oct 2025 00:27:25 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020111.outbound.protection.outlook.com [52.101.201.111])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49j34f8q26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 00:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDTPwTp7kHTVlzelsQyab5jei4F9HYXYJ4TgdomgZ2gnHeb2e8SAYYtftIC/bTnCKivDqSCpt0DFH7kX6lMMRepaaQOA/Tj5dEzb4wNIh/b8FsriF8RPWyY/Wse8zlBakUvEdw8myv18pmV3yn8QdJ3GzJpb4lfMfbwWde6TgS3ShYKYlulfP9TB0cp1dbruAKHn2p52N4CLXMj0Wniushj/7fh+O0dLRlMzH9Kw+5JosNcFnptVEeVpb7x6OHZRrPY2ySkaTxtnppRbGGew4Y3049n+8bUFy0/LbAwVzAUtzWo+jwM7mV4W9nEeIn6ezutwV1Z1icy3f3CTLZMpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIJpR/VKjtW6tQ4hoYoAJY8ZuLVZUtiEPmy/vxsMV94=;
 b=TI1+AwEbDYpPYdacZWra9cfB04WBtrWsX+PWh+Ho8NVK9bYAZwI/T6wll0q+ul7uJiBkuE0WIDpDpR8eXVToAQC9E4U1XZViJpHJIMLx5VdUyaaLYJJsEEqkj7YwAw8VsdNouWUfIuF4wQ4n8ITVgcoq2mUvYeuRhy0DeMjyOdqviq9VGATuZ1QgQEymupvxOXRiMEqkpc23cr+EyNxSjBGc6v/XXQh6A878EeBQo97phILPiDmrtQJPYuJp2QzZq3hvFbY0f0m+thWDLW+wPDGZLShw6v2cUUjKHlwKRQG/y3A6wba2mpi3cKpwzRBl8MYePAjQb2MYs3rWUXq2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIJpR/VKjtW6tQ4hoYoAJY8ZuLVZUtiEPmy/vxsMV94=;
 b=tdsc4fDTX2ONp0DOjMM5VTZ5HyIBblBU2aycPHkDx8FVNDfanzDbk6mVdDBm92dOPZ48hC39HU1KRK+PujPfbqE+cV+5h6s4l8pbDXJHA9P6uwwPkKs8yOfi6Bq2+mmSQy1rdPUY+hSlvmY9yMa9T/qyrV97jTKH+Hsx2M2MmS4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA6PR18MB6245.namprd18.prod.outlook.com (2603:10b6:806:41e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 07:27:19 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 07:27:19 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Topic: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Index: AQHcLW8JfD0SxlFEYU+4aNhxCrmYZ7SsJZ6ggAL1TACAAPe2wA==
Date: Fri, 3 Oct 2025 07:27:19 +0000
Message-ID: <CO6PR18MB4484895AFF0D3C3932D83C70D8E4A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484EEAC621E731A4E5E64C8D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB97957A1B0CF42BF92F77941689E7A@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB97957A1B0CF42BF92F77941689E7A@SJ2PR02MB9795.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA6PR18MB6245:EE_
x-ms-office365-filtering-correlation-id: 4c7dd110-c24e-43d0-dccf-08de024e492b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?SHG/1IMkfGarcTk3PopKYjgk67mdwjjHxfJCFldtYS+fVfGWv50j8lG+sT77?=
 =?us-ascii?Q?3b3Sfybg8tHwMBSu+ZtRJ8iimRT6Niii3mxYT8aEWd64Za3/cugC0aSQ0C5K?=
 =?us-ascii?Q?eHwnjh+v2TvyCwbNZV7j3f4kQTUbApbv75ocaKszuKyIXos3lMSXgaKo7zd+?=
 =?us-ascii?Q?98AlzGBasCYBdf2BOYcI2cSXzgCBDpi0swFkOZZaYLGCDSpOu4Ee7O1pMsSf?=
 =?us-ascii?Q?3+o/8x7dMZNfJIxzaRNa107uWfLtBBWlCeFkc81jgWkLg14PmpMl5bgqBfIV?=
 =?us-ascii?Q?b17nPwBDBM8TZIwrbG4w5rCa3bHbnooLVd81y7BEtUHQ+/Oj08aXj7DX8hfl?=
 =?us-ascii?Q?e/nSHbPr+UMsgyksw3f+d04++0mDGu5zE1X144WW4cQxEVFQXF2FFrhRl+IF?=
 =?us-ascii?Q?HjyMr5rLfT4mtPD70VfaRBpX14V0uF1ZcaZJlE0yu/9vzicLTcGNEoOQ39C8?=
 =?us-ascii?Q?3/XwuMGAHjf/f1sHHlQlpIIN2Y85Y8wPwa2HA0YOADGUKQVbARjeVfmM/WZu?=
 =?us-ascii?Q?0hbp5pDcTluWaf+KPwgLnurV/zBNvelvzjv+WB6y19x53CmeQ/OfGUxyVogi?=
 =?us-ascii?Q?Epcg4Slyn0r3RblyDVaj+7AqYBwZh3UCYCYgXFdnBoYR1UqHHePmSTJ7no4p?=
 =?us-ascii?Q?Rq40gPE4Opp4Znpz4tU+hGdtJpIFvHRKmEbH8s5CwsLTiARgUQc3qsi/Ewm8?=
 =?us-ascii?Q?9JgY0rXiP7BeOS6oaLbmKJ2zDolWsEpzfrZbaMMITpKdB8Q0x/0M6Im0sX3p?=
 =?us-ascii?Q?h7EmE+j8cGDt249shyacvyBJ7n0mLHRnpzcb7aTZF85l3u5X+iKy50MPLtqu?=
 =?us-ascii?Q?7uqCR4t5BfeB9HIUQy4xdhHvTqOyZRDsskRKSbglNPu47X/N4SUI/jUDHgoB?=
 =?us-ascii?Q?9/WICw+VgbMOHAubYSILvXDSbvWE2L0cduDEqlRGqE3Y4fgsg/0NmAoKjg9z?=
 =?us-ascii?Q?fh+Mz0cTtv51456kFbsWdbt7kJJ3Y60DxgL298R02gwi5ZB9Mf/zxaCet6x2?=
 =?us-ascii?Q?ma239T6NCaxsZVgW6Z8UqsSMfJOPW4fu/z5J3oMZQCrOKYZQ/EayOyKq8UDy?=
 =?us-ascii?Q?oVPN1ssFPtIEQjANsqvNas5ARtVtkbt4v3FOt6VGmzT+v6r0WePMpPDHz+WH?=
 =?us-ascii?Q?l8WPnA9uUuwbND3DsPJ/YkLwdbuO1v4erh39EBJ2hCXj6gBgJIYb1en2he85?=
 =?us-ascii?Q?qpiubnUJJ350gROfwRxVBc9NCXZMlAppClqVzdqQ0lD45bBSntn5zsXKd80q?=
 =?us-ascii?Q?7zcwYqzKWxtK13jrGwMpFfcOuns2In835sEVTt7jkX2RdsNCxkwm3NTlV061?=
 =?us-ascii?Q?29Glnbmmhmm/Y04I1jBHMEE0mXdspPqy+Qxb59Et80mOpwH2kvCDTwz1HRFi?=
 =?us-ascii?Q?kT/q+J221n+Yqf6OlMmjbvjVwR+KIK9r/yjltrFjdd0KnPj1FT8f1QTG9ox7?=
 =?us-ascii?Q?RfdFRTW/XrlRJDkjLJA76/uD2kt9DXrsZuJ2Vf0bNMvG1OnAosZohaq6jq+C?=
 =?us-ascii?Q?305AeZD1O5Pl4s1XrdKQywl9XXEteOzHkhQm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iZha50h6PrTRmXb8nTQhXJPFB30K0RPSR5+4VmGzQ3MEmTLph6wTF4kcXgQG?=
 =?us-ascii?Q?KyPWnmMU77ys7OzpeSbcFFq64Dp4ud6mIsn18aX1xfO6djkMmKFkfzfU2WiK?=
 =?us-ascii?Q?APUQBOpwTFnc/ESaLwKGhGu09Jico3c+vdoIhNTzw6U+w6EA45m7BGbYkMVC?=
 =?us-ascii?Q?+YxiCvhRjRUkKAionyc5gZ0Cc7TzvvtVsSoHtmFqC8yErBhHOOiY1dqczDn0?=
 =?us-ascii?Q?7ppY3kMWxyInbH1dA2hVAm81GbKwxlnFyHVeziIDFLp3TxCYC2078k8GCB1c?=
 =?us-ascii?Q?mT55BHAZGR9cLUUgNmwr2aEx8+YRMTuewX41A6al8Cb/tuP4Jziyba+unQwG?=
 =?us-ascii?Q?iO6K9052D4fC5mhVPyFAeMQCGIqdm7ptR2wgADkSl+mGNCg3ExvgzYCA1K7u?=
 =?us-ascii?Q?qsCzyQqy3yZvd0Jj3jegJ4gkKympCt5jWHEIbwJhm5GOycJMXK/CGKDxDTac?=
 =?us-ascii?Q?pJX3zewXUa9cOZAYU/J2nUDsw7UVZYbda1K6xeS0WTQ7DR2fVe2xFIQiUe9r?=
 =?us-ascii?Q?qZXDWV1xzh3v8iy7EaqsUk8H281jDnA3UaEWDKBNwq41M0rRySqtXxTKsxCO?=
 =?us-ascii?Q?Zj30VPsEud5czjHVDzb8U0udgIzv8v9n+Hjws3zbd8kuDqBUGf7hnh+7+JX9?=
 =?us-ascii?Q?JKn0381EYDPrqMrXvD6eZyMIs65p293gBGvd1V6smB8K6P8PcEgM405zxdPF?=
 =?us-ascii?Q?aBXNjl9IsielK96X3hvooZF5paZJeklSWgf7TPnihOsLbXaiSyOPI+PpHbKR?=
 =?us-ascii?Q?PgfroVA6fxBoQpz/qzy21EEjMUWCPp4UNzAU0XgqH7g1rbyp0jHna5wl18NT?=
 =?us-ascii?Q?jzTuFi5f2lvjCsmUVYDEesFXElY+rZqerpiJdn4i1tpJnuBw52WfN/ghOW7D?=
 =?us-ascii?Q?+8E3AfH69cLSlu37h3p+xubyUnQ+XWV70lVWKcHWqh/gwNOmiFjVg83cBPUo?=
 =?us-ascii?Q?XCYD52qELHBmf57csFwqog6v4hK7uUlY0s6+STx74E3orUDHiuDwYLatx3dk?=
 =?us-ascii?Q?luLoWZClOxwnPs/wgIRgPkI8BHaUqtqKyhrF1gAyMAcBkgXGXdyT0MB3cTnY?=
 =?us-ascii?Q?Lzwd9TMBJU8++yExHTfszG+xpJTRsuBntJqcMcYvl2aUyT+WAg1NhhEhNln/?=
 =?us-ascii?Q?4I486mllYY8sk+TUIyJfMlae8NR2hqjlLGIEXpSp+zF0+BDbqRf+KMVDy3/j?=
 =?us-ascii?Q?VgtPj2M8X+flwTSX4B4L9XWWtszlfHZLnGc0fGsriN8ZSikuPBuUOMbPBZYE?=
 =?us-ascii?Q?UvPRnZqlFq9r6hgIG+HdPDF1/W5bCiSXDUX8xUpXx4geMEvn2J1ROO6t/pm3?=
 =?us-ascii?Q?fEy0nUrnwq++cynD9fcui+GvyWq+Q1vigEu5Yu8d37IeoJCeVEzuB+Ox1ZEf?=
 =?us-ascii?Q?Bvpt1sXKKHWWommXyYk8TgiUpvpa04Dji7bhyyXBwufVRWxpinbabOB0GR6T?=
 =?us-ascii?Q?OSC/BOzm74EGsv/SBHJ+MnMxARbce4fmz2x92eRAqiusAzX9IVO3y8G0QECd?=
 =?us-ascii?Q?7dfvNk+SfKHVmv7smfATR5yHoDEZM6PfnkK2OxbNDolYfg6c4dg5wjFIpLWJ?=
 =?us-ascii?Q?YxBuUsXuMnmjfT+ti+o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7dd110-c24e-43d0-dccf-08de024e492b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 07:27:19.1319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0pzjwaai7j3lbnjyaMluXkBDwEncSNtkIHASg9Q3sfYZMvVwYKsMFbe5/QpMHv4hkS2Xp26C17lrmnoOw82Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6245
X-Proofpoint-GUID: yfMN-DimzRCiM81QEJifICBwgIzeAlEj
X-Proofpoint-ORIG-GUID: yfMN-DimzRCiM81QEJifICBwgIzeAlEj
X-Authority-Analysis: v=2.4 cv=d7z4CBjE c=1 sm=1 tr=0 ts=68df7adc cx=c_pps
 a=oMcH3klX4F/By2Lov16jbg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=cIEaM6W1IpyOXxSnGN0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDIwNiBTYWx0ZWRfX7XMa+D6SOo7p
 kUzyP6Yi46XowF0bYh/q3wnvET6WB4lic5/IbBgSIFMyMSORIeePl8scTKLUtrT9bE6QtvcR+jr
 KwXWR4QjIlaQqxDB5u3/POWMvmxWTwJ9amEMa1Qb6y89FXW53SZAbXA8w6dahJ06KFCT6BV929W
 1TUE/X+cCQJpPJ/loKqALzHlKcsIwAN3g7jiM6AtYF2CO96/39N8G4MZYrepXpBwGlBIknqMYts
 Z3XDMo6BvzKuvc4GMpCxuC3vsWvnopl+RGzgrz5pOsNsa1C8aIcjny5GcUm/XRWLCKtz2LCTCN9
 WFY9K6B/EEwWPeWaoTkM342bv8osqrbYkx7tSXI7betn8l6dYgmIcPZ0fwqssIKU28z6CXUuhFq
 sTKsjcn1JonMaRcHIAhfBcNshr/VUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_01,2025-10-02_03,2025-03-28_01
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

> Sorry for the various series I pushed. I attempted in reply to but it see=
med to
> create a new series. If I am making changes to one commit in a series, do=
 I need
> to resend all commits with an updated version? In such a case do I reply =
to the
> series or the specific change I am updating?
Yes reply to the series. And all patches need to be resent.=20

>=20
> Regarding the comments on adding UDC as a new algo: UDC uses raw deflate =
and
> is not a separate algo in itself. Support for pre defined dictionaries is=
 already
> supported by zlib and is not UDC specific per se.
>=20
In that case also, these new params in xform should be part of alg specific=
 params - rte_comp_deflate_params.

Please note: we need to close the RC1 by 5th Oct. Please send the rework as=
ap.

Thanks.
