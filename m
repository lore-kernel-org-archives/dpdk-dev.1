Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD6ACAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:39:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF34A4067B;
	Wed,  1 Oct 2025 09:39:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 53EEF400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:39:50 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UNUWgT026872
 for <dev@dpdk.org>; Wed, 1 Oct 2025 00:39:49 -0700
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021082.outbound.protection.outlook.com [52.101.52.82])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49grx0s5uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 01 Oct 2025 00:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaOPe/uCbGO6dn2mq7XtrF0KDAG7F2VdWrGNHqXIni8VDSfyKrSbZvR8jYKBpUbl0hNKhfz9SPmOz2Y2kmRT8QsdmXJBUYilW772gdjnGtszlNTQt9xzPSsEBsvDvPmRTx9I1kx6JizrvuYRzDAV/wV+GfpuS4xGARhLOgaSe7Fk22pX0f/fVXzTrVbILr8HXO1+fbAWmy5kns6zP8gq7YY3Ip1EZQbiqgNBJK2Wgunjb1iUl6/ooOAicVcatEbkW8ETmvsLJzUsvET6i26/16sBsty6k7b6YsRhee3DmDtcdz6uWWKY0ibdNq1NTcHVawnm7J3jQV+7LD7ce5OVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC7l9t5BoLoccdu5CRpTupM1PE1pEFHePnDZ4WDToZY=;
 b=okjIL9zQrI5xEwS0giTVlU29RccDZSd3WTqvyL1ZTQCC1decQ/8kdbErBfXULpxv0C4aYEcrZUGL58KkSdM3n6t6D/4Qzw6nQZ5FaComnarR5r57sKyTUfzo728w1takcwLaXnl1PsoeV4euT0bLNAw6SWUVTuhGLDQniSp8yyg16RLit9GPw657+eaw8BgJP26ux6KhUz/KBXx0WtwPfpJHKspdzKh1hCirLv2NQ7cxKgOMNMDaTyn6e7p6U6Wrd3DDivQLcfYEGDfWX63ZkdQbTzXlPM8euEiPGQpIb4q4TMa3IkPF+QrrrUshQeJDTjIjyuP95lN8TVi3L5w75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC7l9t5BoLoccdu5CRpTupM1PE1pEFHePnDZ4WDToZY=;
 b=A5BCISTLWC3j8FxXBbHYKAovAtvE/kybaUbS1MSqI8MHKE9eSYaopTRsS6KtiRXRX+9Kjt0KAL+BZ5xUxRLMk0TgAr1Ppl/s1vxDpp5wPpLw5YJ3m3SiCnuPX6B/Y4zfWPfCjkYYYmk+XJ/pRmZf/HbyYSXwnXVNvjIMPSC5txo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM6PR18MB3538.namprd18.prod.outlook.com (2603:10b6:5:2a3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 07:39:46 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:39:46 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Aakash Sasidharan
 <asasidharan@marvell.com>,
 Nithinsen Kaithakadan <nkaithakadan@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>, Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 00/10] fixes and improvements to cnxk crypto PMD
Thread-Topic: [PATCH v3 00/10] fixes and improvements to cnxk crypto PMD
Thread-Index: AQHcMSWW2DTDDpyE/EO/VgcqJRwTBrSs6rbw
Date: Wed, 1 Oct 2025 07:39:45 +0000
Message-ID: <CO6PR18MB4484C4615158022AD8FA72C2D8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250929094353.1027744-1-ktejasree@marvell.com>
In-Reply-To: <20250929094353.1027744-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM6PR18MB3538:EE_
x-ms-office365-filtering-correlation-id: 783fd9cf-1710-426c-eb61-08de00bdb196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?51Ma2Lw0EON1JCWrK2bOv9MG+EJEUfOMklGWglkV6JLbjO6Z15+XpU0f5aUf?=
 =?us-ascii?Q?1RRDr7Vo/SL0TaoHJfkAm5ObA7rVtJk2wbmzan/6+JbUdEx23NJ9AaGdo3RK?=
 =?us-ascii?Q?lDu3AYcRhInFQS0I3uPgCfAWCszVRWUtIsCBIe/1puVvP6LT4h78CIwfSUR0?=
 =?us-ascii?Q?OnGgIiUHtDJ9eCcG/h7pBfp9xXpfKyZUnrqdu/ERvHGMSGVuUSoRNp8zcvDz?=
 =?us-ascii?Q?/1KTESCJMsWvurzWUy5ra6d+pBgGpKyO+T2W1PcPwYFKjaR6WSnPUZNf8kan?=
 =?us-ascii?Q?E/kdNCOUn8RzOArbywdWa5IEBjZ0cfSeXrGKxQ56h294ku5dpYlUywdp0jNy?=
 =?us-ascii?Q?TVXWCSGhz9JhsejW7Peuuluy5tB+NH5E2IdEb1nZAzhWvhN+WBhRhjNNc/Cr?=
 =?us-ascii?Q?PtkVHqsZ4yjjQNyO0me2FtxjicZZSdxMgpTwPftHiJbbTSexWjl7J//wXY01?=
 =?us-ascii?Q?1zlwvj3NJ+8pxGrID5zZijvsPvtwE4EXNUXeodXP8zwcQpjfFwDa1MEsUole?=
 =?us-ascii?Q?/TK5yRAcMEIX1ftGHEYlfwLrQDyPLcG5o2iG6Yi3hGBaC6F9OlJ+PiosHqs2?=
 =?us-ascii?Q?iyat51YZrlltBRWcnRIYft80YUgtzPQ6dXDpxNh7kUBSFkgMMUxjjSTfrDwu?=
 =?us-ascii?Q?1AZ9CPk6y5YOtyg6x3ARCL+xm1hf29eZNQRThl9LkK+ihHpBooevSFmljxKV?=
 =?us-ascii?Q?IMfIaAMHoPU0bdiJc33XqdQ2NUIdVZiconX+F3Dk0MsDD8y2LXLiqZ9rMQzD?=
 =?us-ascii?Q?aS9b7TW0khldXESh8HaqmLO0F2gMJoAjiwdZN1kZA8LPH8fE/FnKKYPMdzD9?=
 =?us-ascii?Q?j5PJNzCGjVLHR2lza4MRc/6glGeVAMIM1HqLCv8QFNJsH9HIXrpu3wMkxurC?=
 =?us-ascii?Q?oiRjmCLAZNWqbhBDcw5bBWC09YUPw5X0kWkwjp8Sgs8Z/lOLL1CqqtI/RT4Y?=
 =?us-ascii?Q?vJakH1TKwo60LhlrJPWCI1gLR7z0eLLpM8POUESdYwO/m61x0HwSiJ0rueNd?=
 =?us-ascii?Q?tJies1R9eOFgrFxLGkdiU0uXzDdBE4Sd0QZ+VmGLRB2ZjHLNuB2AYSHPKDDy?=
 =?us-ascii?Q?q+VZKFO8ikiSTirZdaut6v96xH9Vg/wHasxar4Kh4mzuJ8nzsAj5oiqfH5/g?=
 =?us-ascii?Q?cRzOy1KxlGBc8BR/xptLF7veC1kj3wFO1of2bGb4weCUwJPAq7OY4fw+yhJo?=
 =?us-ascii?Q?Wrm79dmdvXlv8ZZhUwNTay2UPck8a4jIQfRvyDlMvKgJpL9Zx4/C44FsKMeZ?=
 =?us-ascii?Q?shyq4M7zqs3hmcXTRqMXrw9Dy8gLJVtjX90g5ZxnRqlTVWg2nW84twHLIVvu?=
 =?us-ascii?Q?Wg1jqXvuw+L6qqYhKVeOU+F+2vX3svUcWOh+ZlCGkCIh55DR81CM8oMcdhVX?=
 =?us-ascii?Q?Mm2csg9l65PYhBN0Gopd3+MIM2QQwg63DULYvrhAvXDc001BjXuzttxQ/XtG?=
 =?us-ascii?Q?ZHgaxIbBiDylRUZsH9hMXU8HHgx74aZyt0MOm4m5jJHM05Xk0V2UqkjnCqAS?=
 =?us-ascii?Q?sh66Sd2BItoL1T4viTfuyYYw7bsVbwlEx4kT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g7ZYug5WxWJKvj1QI7NZPCNBXzEqylFWOrhv3upvTPIaLCYUN1Z2tx1wy+py?=
 =?us-ascii?Q?v2ie1D6dwq+Z485jtJodjbLrzSIbcOgnkGUEFWsL7FudVIqeKm4FVYrujcHT?=
 =?us-ascii?Q?DM4ujSbeJV4sVOqlqTz1KEHLTi8vFcbrY0QsuMLBFLec543s61dul7MPp5ZD?=
 =?us-ascii?Q?3vwVedMv5lkJ3GfU6QFQrwrpdlEBSVkdttCqK+Y6vte5ighAqZQaBvHZX1mH?=
 =?us-ascii?Q?qIBEJQcZ5qlzmRJ2TUVnMxq5UVTnRo3kgrf8W7ygPefD/pSWtSMhVP24VRH+?=
 =?us-ascii?Q?4ZIasMY/XL3m0uKSHUu98QkFn6//8h57mZ3E2EaPPXaSbRygO4LXsyaPTeVz?=
 =?us-ascii?Q?UP3JFm8klCLkawFZZmEKHctcePWXxOTclVuElw3906CziKDUY6ZXu1vG42U9?=
 =?us-ascii?Q?npigbt1TB+MEJJvf1LeL1PylUPIbMOMPLA1E4RxZUIsqgUPZlTzmRtUfZTwg?=
 =?us-ascii?Q?QwkTqP1gVF2amSz3PAor/qZVsXz+zOR0V65WJbh1iYzhkL1+t3HgLrQ1CDQL?=
 =?us-ascii?Q?NKgOALCt+hNVqkm9z/DGttaInHHEHZ36HleNnRlCHHJVdl+FFFUPGzqijtmV?=
 =?us-ascii?Q?UtIuXomj5DbmSDGlj2cxxePpimoMlmBD+Rk0JNSnR6+Ecmrou9spBt8COAxL?=
 =?us-ascii?Q?C7Z9dcpjPlt7iZO4LAbTNZMiHHk6UMTWSEPyl/ELjQ2zq8JwDi7eYck/sOM9?=
 =?us-ascii?Q?bU7XCSPYrYimHLPqGZ7fNs6AZ2nzqGYXYbimAnJAwRauO+15XeQbQnt7TUW2?=
 =?us-ascii?Q?rJZ3l29H346QlUTGvLWxw0l2ydXEhgKmi1nVaPgiUU52bNcIO4vhtbL96gPQ?=
 =?us-ascii?Q?GF3snqnucpPSsG/iTuc8cu4TeOUbgWaaMxFvdPX2pghkjyND0g4nfy3apYCy?=
 =?us-ascii?Q?+0gH7SQiScoanZ08rYfHxhDAJvTJfy6nzg6be0DCWZxkakK4Yuf7oqUualPa?=
 =?us-ascii?Q?N36FyF7ZGQ03Aa+LrLrURXbsHfvVn5T/cKJtKk7tdDMX36lLObuRbYqaE6om?=
 =?us-ascii?Q?b2AopFfG6JW55eojd8eJAaRn98sVuSURE3CpcBseB7ntazj9z8G+rTJacxtj?=
 =?us-ascii?Q?mS0UsV2yJGC8HfLBiZBukJgkXS0Tgbiy0KBhmtqEGBnVjXLA620cEBkNrvcM?=
 =?us-ascii?Q?XrZKkuIx1BAaFpGWmibSS2c99nf9FMTd9Ay8n8NokoT20k0K40HfLl9WC8NU?=
 =?us-ascii?Q?gbzY63JZERW2WeMUwxTq4iet3LwUhTZ0hqorZJu5p3m1UsJDG+hh0o4o3FQp?=
 =?us-ascii?Q?iNTCMXD5ZwSBqGnz7/BlKjgUylChkNRipd1KDrufi1EbZrsZQH7NUjiV3qzj?=
 =?us-ascii?Q?QmbJEVOxsV4UQ8prn0uYUTuLEDT4i17utNWpSsIx9ynVJfKRUk/Jb5qKiNtW?=
 =?us-ascii?Q?OnqvUzcYfjPHXcIsIQvEp6xkOS1qVdFadqM/tbbLQic9aVUgeXnxJaC3E0UQ?=
 =?us-ascii?Q?JDg4lbF4pYfXc1uC47m7C6kjxMWFZnb8bKc6hESrMzg6djKv936LAv4nVNvD?=
 =?us-ascii?Q?Q19U1FMMKh1DPw/ejSCqhpYoIiZ9hHymbGli4AUcwNcWDyHvanmulDEenMJA?=
 =?us-ascii?Q?l4KTj9tqeLE/wTzw4dQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783fd9cf-1710-426c-eb61-08de00bdb196
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:39:46.1155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zdAW9T2fmJeSaZ7q4TjDUcoUzXuxn3J5I/Z9ydXNa3M+CNZmojuf+yjyAvdskZKExF9isekNUMogl9EApF65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3538
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDIxMyBTYWx0ZWRfXysm++IY1acgV
 PJeSnguS2oTnFhWMfe99ey/gTx5RjKIXqVNf74WdgkV+7KRDiXCifR18dYnJW61C+Ee5Y3oZtt7
 KTRLPfHekzmGNSjpCQhth61KTeDnHSrPO4vg1wv4hJvsdi8otTu0rU75UPhvME8BqKZrlifIpVq
 fVZWPg2Xsiq3Up0OVWJK0B4QHrr2sIHHgytgnotYYz1K5qhx076RCOwonV8PBhmozVM+uZ+zIgg
 edzMjSkX2aZCJSBB5vaJnGMHOjb7VpFKXNE99FsUgFbvA6zgelvCGs8Em0b/3Yy9Qjb5BVwCd5+
 GJq0cIseB10PKDuH/YEDc2F4RsMFgiidXDU3s/uGSQNNj+Q5X0E/jjNf/yJZQhycMz+MSfAeFtA
 NdnTYgP1Ldv6n6/xbRvKFmOP+3FdAw==
X-Proofpoint-GUID: y2qgX_MIC-Uv9iJMxxYxY4rrlGi0HzVa
X-Proofpoint-ORIG-GUID: y2qgX_MIC-Uv9iJMxxYxY4rrlGi0HzVa
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=68dcdac5 cx=c_pps
 a=+c9WoxDyotZMqfRYVVLQHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=ZHfjPguN4BOC-0VTnL8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_01,2025-09-29_04,2025-03-28_01
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

>=20
> Adding fixes and improvements to cnxk crypto PMD.
>=20
> v3:
> - Removed redundant code
> - Added two patches for fixes.
>=20
Series applied to dpdk-next-crypto
Thanks
