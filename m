Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DE7CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 07:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A79540281;
	Wed,  1 Oct 2025 09:45:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 062D14025F
 for <dev@dpdk.org>; Wed,  1 Oct 2025 09:45:03 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5916Oau9025887;
 Wed, 1 Oct 2025 00:45:03 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021108.outbound.protection.outlook.com [40.107.208.108])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49efefhcy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 00:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKQjoygiPKL1k8737VIYPC9/FooYtZlqEjbr+gVrxyTyoCGhpVT/+dk03QGu+oX6gz1pIRYKbqr73IA0GRuOEiIeVAbdd6qFJWnsItsBOU4JFKhL/a9dzYAMxKQ0x2gd/0LBV4m4V/87hqeg5yRbY0NClWWrwbgRKJNi5AQk3l1nkPKvRM+wOmOkjYVFjUZ2sBz1DGNZmP0UiuazgqHFTyuCfRsoscaJbQJ+XkpqkTcr4OyNJPo36gVJwmPv6vZn4n7XqtKUEq52rszKoPBVRo4n3m76BcwWyc3oYpN2Fe0KsnvBj4qXypOjBc1dW6DYTsdxm//dDHI8L/olkv6tXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhykx2VAruAoWJ5nH/AKbAv9S9rA5z/ntxSYZaAos5s=;
 b=uhVKSPmSFhqPf88BICXwN705JG9Pu/3nuAR8UGj9L/ZxN/2o8kqaBsLgW56Gsusok4kvrOqgPsu/lahx6eRLkAr6K4n1XwROoLouz5wi+2Yd1pRKZRt3s+HvEPU4LTGhexWO1wDt4tDqd81aqD1/+LXhjxJ0fXJwHI+wiKhqnaiV2lSpzcC6zZk+JBYPEmThTmHeuMpW/AsTA0EgWVdrVCSlXndM64wGs3mz56BFpgdyUxER3Wy+8AdPQEJBTNEe+//cfmpC7Rt3vf1q/U8nMW7iFG2EklX6Qyb7L8rirtbBOVhCShdDdTEVX7Kk4NHBlOL+EKwBJODykkGr7fAeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhykx2VAruAoWJ5nH/AKbAv9S9rA5z/ntxSYZaAos5s=;
 b=E4KzTRhYUYniAUGfxrMD5TdCXVHnMEYhXXkL4Z71QCMFYwXFsIJJDoBNfn80x+yQE/UmtCFAPhaiUTsAcfYWIDFYlDed7T0ZEuoeT70HA6MrsuV0BdAbC9qkyRa55U3xyZ/qcH+ez6DJ8injHk4MAJTsTiDbC4hP78D3QDOYJ8E=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF1E89B88DC.namprd18.prod.outlook.com (2603:10b6:518:1::c8a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 1 Oct
 2025 07:45:00 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 07:45:00 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>, 
 Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: RE: [PATCH 2/2] app/test-crypto-perf: fix other asym ops execution
 failure
Thread-Topic: [PATCH 2/2] app/test-crypto-perf: fix other asym ops execution
 failure
Thread-Index: AQHcElv2RMRByRVfL0mQfOkecbsx8rStKZvQ
Date: Wed, 1 Oct 2025 07:44:59 +0000
Message-ID: <CO6PR18MB44844C28015839A0A15152B6D8E6A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250821052440.3213146-1-ssarananaga@marvell.com>
 <20250821052440.3213146-3-ssarananaga@marvell.com>
In-Reply-To: <20250821052440.3213146-3-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF1E89B88DC:EE_
x-ms-office365-filtering-correlation-id: 56a25ab2-67b8-4481-292c-08de00be6cc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ug3GeJGbBGgWbGnyNJFpOCiGtwoG6TqKCUSQxSqgFKQ/b9UQ+91Wvz3gh+EV?=
 =?us-ascii?Q?wfDQI3VjoxthGlaVEp0EWjkaVjjoHN8Izb1G4hHJP3iEcuyLORquAeMwoFhZ?=
 =?us-ascii?Q?ybLF2MtUVPILQboseZRAaBo/S64ylNpQMKtoDBL43OcjyvqjiCBgoIOkV0zA?=
 =?us-ascii?Q?zuu6xkiATFd63STBwXL09hLY1H4+wqj8nRPKyUc7ZDoiTXC2SM7KY6C9sHbb?=
 =?us-ascii?Q?a+frLz6g+s4NZb++5qV6Ifc3zlye1sZS2XiWJ/5GxcXdEqHksJMO2l++hOUC?=
 =?us-ascii?Q?Sp8ww5gWt04NLAQdFhdME10K+Fy1j/+diCtGM5jNQAN66h9LdodTLXShF1nj?=
 =?us-ascii?Q?te34wT0u6zVSCZE+9Qr1cfYn3i2pMUu2YXhuuIaJ5Af04dVvqRA/mE40KVy8?=
 =?us-ascii?Q?jvRcAUaktaXO0vdUnQEa1y1PtIBWOsEugJe/ZHHfMmjigiuDud2zfQU/xnBb?=
 =?us-ascii?Q?3AJh+18JbTf8J53hVk6iqg2lvp8KEVF2j1Xzh2wlQqF2jontIK97IBCFfWyB?=
 =?us-ascii?Q?Czx68OYLFDf1ohW9ovkBIUY8f/PXnHHSE2XM1l6BKJM0+BTjhHN3i8+WBrvd?=
 =?us-ascii?Q?xh1SLKYjEjaIA5voKRPt546Ss7JVCvcxsoEny6m/Z4cQrvQ6F2R4x9nYFj2o?=
 =?us-ascii?Q?XDGenktBieNc+tkChEI/sbwD7AFTxKokIwVz0uDJOXKKWF+kqq+Lqvtc5wYv?=
 =?us-ascii?Q?GMWCdLCP5BrkpVnWF0LOlG2dcf0YNv6I63RodXyDACr2R23Nx9w/aMEz5uaM?=
 =?us-ascii?Q?DOehOxUcjBOP/2IH4lX5gKipy/yusZYYfJjNt82TVObQUmYbIjzxqJkzk5P7?=
 =?us-ascii?Q?VrUP88znJB5P4V8C2dJOgf+G7jXiaAgBcF5FcodoU41nhtFQThuL2NWdKy9f?=
 =?us-ascii?Q?Lw+0KfCUuBVUGa4+ZTkXqYaXlLW2BMZa4R0u+rgYahHuruMkHRqPQuYKuzx5?=
 =?us-ascii?Q?xpXr15BpNWFphhchyxavha+mYAFQCMebfD5SEjvHIq1Z2mR8fcnn0u56FZSn?=
 =?us-ascii?Q?pQZhXwBBE1at8t+yVBZUDqr9aoFGx5RlheZawl/OU+7CnjErmYx42m9cDNtR?=
 =?us-ascii?Q?lz8Hi7stM5q0uz5PtHzCGy2FXyepSqYnmyX6lxC7vCjSXDp2T1KVM92eCvUg?=
 =?us-ascii?Q?9Ky9Thy5/AuzWPV9QqVPS4V5YQ/SKDUYm+/bC6KzWd1wsMaF25/mETWC5eAs?=
 =?us-ascii?Q?nSIOhJQtGNV+SmF5CcqTyiG0lL/nseuciLU1taFpR6Be0XBBdapmVsZYesfm?=
 =?us-ascii?Q?C+T6u6Qv6zUegw6bw/SMDrrHzOFsVZDANUFGiM6/ikxARBHctDAsu2QoZUv4?=
 =?us-ascii?Q?fqrRBuNXgkydUasV2Wucc99ThbF2BQ7m+kLXd5fIr8PA8PTzAWXsKwxnPNpb?=
 =?us-ascii?Q?T/X3SeTaQaezQ3D7/58AV6BkqKJMOde6atFl9hEQqZUJIgTKC3WqGCkn5q9K?=
 =?us-ascii?Q?NVt3pTfHXzVdxui+SVMybX+5Hjy7fZYNu2OV05dCqkP9HHNm9PzH5mJGuX8B?=
 =?us-ascii?Q?EUm5wL9tvxg2UCoMymM3LU8qQkVkim9cserx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dBTBV0HN66LEJnmsb25tx2lCR14T1ptHhbZTYVulVv7JicqaN7qA/I4LicBP?=
 =?us-ascii?Q?RNzC458H19jz+zZeNvArnzyEdxAEpRHJopJQxd4BUC3mzCd1xFJznvbpUlfr?=
 =?us-ascii?Q?YxavH5HaezFNCAf6fpfie/JUOlgZmxgwQnPpRy6fAB+9OgpWf7u9IbymjjF/?=
 =?us-ascii?Q?8BuhPAQLSWUvvN9oYECfsF4psw4sk72DZyVH6LoxLk/rgbQtA9N521KdDE5T?=
 =?us-ascii?Q?gLwE7rytYAKEix6b7cleaI/tHN/WWn48hUQs3FTlErSSc4UEWEUO9IcL7y5C?=
 =?us-ascii?Q?4sECOgVw/xhw8vjonk+644Z18iyIy8xjNFM+ffVw0PvwE8yHEvIl/8kKDOsH?=
 =?us-ascii?Q?osgRFZxAHN1OOWQ9sPsgEG3ADBaywbQhabXSeB0lpeLvkRkoKVgsSlds33iZ?=
 =?us-ascii?Q?0eNPfdnrQP5Wah+tsRzVbxyHuUBz2BF0GqicefwNIinLc/+b6yS59F77N7Zk?=
 =?us-ascii?Q?e980WmfPKincHQ4xRS4Wi+9/XaKwN3K/IqtwxPTpIvvCEFFMvzSk5Sm0npba?=
 =?us-ascii?Q?mRvil7TUhhx+Fj2rnPApgedEkPv7HvwCXQ3mM+HNljl7Y8yqktHDnviJsfmT?=
 =?us-ascii?Q?oknUmLuxfjAkWKIOgmCB4XxmlxKm75hl1dwKFulc9x8qZGbbPQ7QVNC/IiNs?=
 =?us-ascii?Q?rBlscO0CwP4NlPsRShdY0Q5SauZMNLw8fQZNU/bOwr3Yvvm7k5gRSfMPhZ5B?=
 =?us-ascii?Q?4pzkhskmTDdAgtaryULLz+cCVon+Nv1JkNMztKQE6fiI0IFN2+2oGJ1uTSX9?=
 =?us-ascii?Q?+cVBneQdohlvMZrl8jCTQuZEHjbHAGXpZYiGSfUJJgGEOSet89Dj2aSL905+?=
 =?us-ascii?Q?okyIHNwQbx3cMQccaOR5L7sUCRDELudgocFT9L0J8SXtlcqmqzfWmX/A13qw?=
 =?us-ascii?Q?bm8EjUoc4kjILpyAjQgKn+LMOHuTnZHg02FgX0v99FOfNiFaTGXiX1ye2roh?=
 =?us-ascii?Q?8PfP0nRVnII4T/GiWgfSmsSUlmPdLYa4q0gTc5oOTg2oLGPY3YvqNO/cYLHZ?=
 =?us-ascii?Q?RV1nzevMA0W2fqJgtdgmvO44QE8vrNWibtyh6PynRxquzON3ZIyc8aPNoVYp?=
 =?us-ascii?Q?KEP2ujLtYRK5FwtWVlNGMOK9pIi0SRAN420FX8NjwX7GoPG/K2Y42EtqQ3D7?=
 =?us-ascii?Q?0OKcEJc71lj+0N/W4tngdIjmW0gcwqnenXTDKl/aeEdUUg3nSwPENzyow92Q?=
 =?us-ascii?Q?Gd4snCVvj1mpT5yUkB/+Vd/C0dJ6GyXPTV3+NHQEgHMAEt/KtUwe3hlg1zh1?=
 =?us-ascii?Q?F1M3HZiPt+e8ELJGQYO63fLs8MuBon6+4XX0N6BpJmBZpTJUJID3Hzv4V5it?=
 =?us-ascii?Q?OJ+4zQsUAPqbudZBnrL0huubz/UU629nZ3eRL1/UHpp+3LKotEXMVpSMSIG7?=
 =?us-ascii?Q?pgo9vLZgAaQZF1HVpBbKtdMIR9XZGe2MU2+9alWaMEWq93T1oZen7tJBdEcY?=
 =?us-ascii?Q?1jQvMtkt2fo7yk26ReqnFdu6oC2FDylhupBZJY5gfDlBt4ivxObZKujIAPSq?=
 =?us-ascii?Q?FUrUMnHIs/J9LTDYSEu6PvwcMmKU5Tw2RpYhfF8txfVklYbffOa5v3+phyn3?=
 =?us-ascii?Q?XFMWw/eKJ+5UC39SllE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a25ab2-67b8-4481-292c-08de00be6cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 07:45:00.0474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufqt5CrhO6dhsf8jcTs7WD7H81nmysL/VHeQlBqXmDNxctRzJTkrd8XEpInsPwF4vyIQS4DhG0ow2DHnlM6vyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1E89B88DC
X-Proofpoint-GUID: r-V9htktghozbfiY9Hjv3MIDu3u4ijr9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDExMyBTYWx0ZWRfX5b+ImiEp22Af
 MOzqU9efzE9k0fAW0lcURhXVVV67tg6mWK6xoaUJbAmWqUuEc1FPwQkslEb3vh7qIDeWhkyRKOU
 DC4lkRBZUAkQs+TzEGKaynMoiYcLzSTPlDmQ/KNquv8Y3LN8fqpBofO9dtz64ik/b1DsWen5LEi
 JzMsXTN4fx139F4N2rEWTqgRPYZAvzS3anGU0Y4DCoPEHvyrzKaIOZzzgce0LQXC7SsPKJBACOI
 HHxo4Mwnz6gQVzAOZT+vFkkCDGukAml4mV57Jhwuu0f4e/3YRocwqASDKA18jxfsA4DjH1+wAZc
 ztRyVUd5nb6bGuYIePjedgt+GIpKDQUm9/yqTgzqkS77zCcmVkptmMnBcQ/sBUjQ9Fzig4wnxrr
 jZGp0lTkg+mmDAMm0/h9MS2yMIG9Cg==
X-Authority-Analysis: v=2.4 cv=RorI7SmK c=1 sm=1 tr=0 ts=68dcdbff cx=c_pps
 a=8LTp2Tkxn6675DRQdBJ3aw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=MwiZqCfFw9TUdOt4udwA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: r-V9htktghozbfiY9Hjv3MIDu3u4ijr9
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



> -----Original Message-----
> From: Sucharitha Sarananaga <ssarananaga@marvell.com>
> Sent: Thursday, August 21, 2025 10:55 AM
> To: dev@dpdk.org
> Cc: Anoob Joseph <anoobj@marvell.com>; Akhil Goyal <gakhil@marvell.com>;
> kai.ji@intel.com; Sucharitha Sarananaga <ssarananaga@marvell.com>
> Subject: [PATCH 2/2] app/test-crypto-perf: fix other asym ops execution f=
ailure
>=20
> This patch addresses an issue where execution operations were failing
> despite the optype parameter being correctly configured. The failure
> occurring because it is executing rsa optype params check instead of
> configured optype and removed copying of sign data into temporary buffer.
>=20
> Fixes: e131b8e643fd ("app/crypto-perf: add RSA test vectors")
Cc: stable@dpdk.org

>=20
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Series applied to dpdk-next crypto
> ---
>  app/test-crypto-perf/cperf_ops.c             |   4 +-
>  app/test-crypto-perf/cperf_options_parsing.c | 156 ++++++++++---------
>  2 files changed, 81 insertions(+), 79 deletions(-)
>=20
> diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cper=
f_ops.c
> index 20fba60426..49ee1ae49c 100644
> --- a/app/test-crypto-perf/cperf_ops.c
> +++ b/app/test-crypto-perf/cperf_ops.c
> @@ -69,9 +69,7 @@ cperf_set_ops_asym_rsa(struct rte_crypto_op **ops,
>  			asym_op->rsa.message.data =3D crypto_buf;
>  			asym_op->rsa.message.length =3D options->rsa_data-
> >n.length;
>  		} else if (options->asym_op_type =3D=3D
> RTE_CRYPTO_ASYM_OP_VERIFY) {
> -			memcpy(crypto_buf, options->rsa_data->sign.data,
> -				options->rsa_data->sign.length);
> -			asym_op->rsa.sign.data =3D crypto_buf;
> +			asym_op->rsa.sign.data =3D options->rsa_data->sign.data;
>  			asym_op->rsa.sign.length =3D options->rsa_data-
> >sign.length;
>  			asym_op->rsa.message.data =3D rsa_plaintext.data;
>  			asym_op->rsa.message.length =3D rsa_plaintext.len;
> diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-cryp=
to-
> perf/cperf_options_parsing.c
> index 0c7c57ce42..dc36dc0f2d 100644
> --- a/app/test-crypto-perf/cperf_options_parsing.c
> +++ b/app/test-crypto-perf/cperf_options_parsing.c
> @@ -1358,6 +1358,40 @@ is_valid_chained_op(struct cperf_options *options)
>  	return false;
>  }
>=20
> +static int
> +cperf_rsa_options_check(struct cperf_options *options)
> +{
> +	if (options->rsa_keytype !=3D UINT8_MAX) {
> +		switch (options->rsa_keytype) {
> +		case RTE_RSA_KEY_TYPE_QT:
> +			if (options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_SIGN &&
> +				options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_DECRYPT) {
> +				RTE_LOG(ERR, USER1, "QT private key to be
> used in sign and decrypt op\n");
> +				return -EINVAL;
> +			}
> +			options->rsa_data =3D &rsa_qt_perf_data[0];
> +			break;
> +		case RTE_RSA_KEY_TYPE_EXP:
> +			if (options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_ENCRYPT &&
> +				options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_VERIFY) {
> +				RTE_LOG(ERR, USER1, "Exponent private key to
> be used in encrypt and verify op\n");
> +				return -EINVAL;
> +			}
> +			options->rsa_data =3D &rsa_exp_perf_data[0];
> +			break;
> +		default:
> +			RTE_LOG(ERR, USER1, "Invalid RSA key type
> specified\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_ENCRYPT) {
> +			RTE_LOG(ERR, USER1, "Public key to be used in encrypt
> op\n");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
>  int
>  cperf_options_check(struct cperf_options *options)
>  {
> @@ -1522,95 +1556,65 @@ cperf_options_check(struct cperf_options *options=
)
>  		}
>  	}
>=20
> -	if (options->rsa_keytype !=3D UINT8_MAX) {
> -		if (options->op_type !=3D CPERF_ASYM_RSA) {
> -			RTE_LOG(ERR, USER1, "Option rsa-priv-keytype should
> be used only with "
> -					" optype: rsa.\n");
> -			return -EINVAL;
> -		}
> -
> -		switch (options->rsa_keytype) {
> -		case RTE_RSA_KEY_TYPE_QT:
> -			if (options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_SIGN &&
> -			    options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_DECRYPT) {
> -				RTE_LOG(ERR, USER1, "QT private key to be
> used in sign and decrypt op\n");
> -				return -EINVAL;
> -			}
> -			options->rsa_data =3D &rsa_qt_perf_data[0];
> -			break;
> -		case RTE_RSA_KEY_TYPE_EXP:
> -			if (options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_ENCRYPT &&
> -			    options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_VERIFY) {
> -				RTE_LOG(ERR, USER1, "Exponent private key to
> be used in encrypt and verify op\n");
> -				return -EINVAL;
> -			}
> -			options->rsa_data =3D &rsa_exp_perf_data[0];
> -			break;
> -		default:
> -			RTE_LOG(ERR, USER1, "Invalid RSA key type
> specified\n");
> -			return -EINVAL;
> -		}
> -	} else {
> -		if (options->asym_op_type !=3D
> RTE_CRYPTO_ASYM_OP_ENCRYPT) {
> -			RTE_LOG(ERR, USER1, "Public key to be used in encrypt
> op\n");
> -			return -EINVAL;
> -		}
> -	}
>=20
> -	if (options->rsa_modlen) {
> -		if (options->op_type !=3D CPERF_ASYM_RSA) {
> -			RTE_LOG(ERR, USER1, "Option rsa-modlen should be
> used only with "
> -					" optype: rsa.\n");
> +	if (options->op_type =3D=3D CPERF_ASYM_RSA) {
> +		if (cperf_rsa_options_check(options) < 0) {
> +			RTE_LOG(ERR, USER1, "Invalid RSA options\n");
>  			return -EINVAL;
>  		}
>=20
> -		if (options->rsa_keytype =3D=3D RTE_RSA_KEY_TYPE_QT) {
> -			for (i =3D 0; i < (int)RTE_DIM(rsa_qt_perf_data); i++) {
> -				modlen =3D rsa_qt_perf_data[i].n.length * 8;
> -				if (options->rsa_modlen =3D=3D modlen) {
> -					options->rsa_data =3D
> -						(struct cperf_rsa_test_data
> *)&rsa_qt_perf_data[i];
> -					break;
> +		if (options->rsa_modlen) {
> +			if (options->rsa_keytype =3D=3D RTE_RSA_KEY_TYPE_QT) {
> +				for (i =3D 0; i < (int)RTE_DIM(rsa_qt_perf_data);
> i++) {
> +					modlen =3D rsa_qt_perf_data[i].n.length
> * 8;
> +					if (options->rsa_modlen =3D=3D modlen) {
> +						options->rsa_data =3D
> +							(struct
> cperf_rsa_test_data *)
> +							&rsa_qt_perf_data[i];
> +						break;
> +					}
>  				}
> -			}
>=20
> -			if (i =3D=3D (int)RTE_DIM(rsa_qt_perf_data)) {
> -				RTE_LOG(ERR, USER1,
> -					"Option rsa_modlen: %d is not
> supported for QT private key\n",
> -					options->rsa_modlen);
> +				if (i =3D=3D (int)RTE_DIM(rsa_qt_perf_data)) {
> +					RTE_LOG(ERR, USER1,
> +						"Option rsa_modlen: %d is not
> supported for QT private key\n",
> +						options->rsa_modlen);
>  					return -EINVAL;
> -			}
> -		} else if (options->rsa_keytype =3D=3D RTE_RSA_KEY_TYPE_EXP) {
> -			for (i =3D 0; i < (int)RTE_DIM(rsa_exp_perf_data); i++) {
> -				modlen =3D rsa_exp_perf_data[i].n.length * 8;
> -				if (options->rsa_modlen =3D=3D modlen) {
> -					options->rsa_data =3D
> -						(struct cperf_rsa_test_data
> *)&rsa_exp_perf_data[i];
> -					break;
>  				}
> -			}
> +			} else if (options->rsa_keytype =3D=3D
> RTE_RSA_KEY_TYPE_EXP) {
> +				for (i =3D 0; i < (int)RTE_DIM(rsa_exp_perf_data);
> i++) {
> +					modlen =3D rsa_exp_perf_data[i].n.length
> * 8;
> +					if (options->rsa_modlen =3D=3D modlen) {
> +						options->rsa_data =3D
> +							(struct
> cperf_rsa_test_data *)
> +
> 	&rsa_exp_perf_data[i];
> +						break;
> +					}
> +				}
>=20
> -			if (i =3D=3D (int)RTE_DIM(rsa_exp_perf_data)) {
> -				RTE_LOG(ERR, USER1,
> -					"Option rsa_modlen: %d is not
> supported for exponent private key\n",
> -					options->rsa_modlen);
> +				if (i =3D=3D (int)RTE_DIM(rsa_exp_perf_data)) {
> +					RTE_LOG(ERR, USER1,
> +						"Option rsa_modlen: %d is not
> supported for exponent private key\n",
> +						options->rsa_modlen);
>  					return -EINVAL;
> -			}
> -		} else {
> -			for (i =3D 0; i < (int)RTE_DIM(rsa_pub_perf_data); i++) {
> -				modlen =3D rsa_pub_perf_data[i].n.length * 8;
> -				if (options->rsa_modlen =3D=3D modlen) {
> -					options->rsa_data =3D
> -						(struct cperf_rsa_test_data
> *)&rsa_pub_perf_data[i];
> -					break;
>  				}
> -			}
> +			} else {
> +				for (i =3D 0; i < (int)RTE_DIM(rsa_pub_perf_data);
> i++) {
> +					modlen =3D rsa_pub_perf_data[i].n.length
> * 8;
> +					if (options->rsa_modlen =3D=3D modlen) {
> +						options->rsa_data =3D
> +							(struct
> cperf_rsa_test_data *)
> +
> 	&rsa_pub_perf_data[i];
> +						break;
> +					}
> +				}
>=20
> -			if (i =3D=3D (int)RTE_DIM(rsa_pub_perf_data)) {
> -				RTE_LOG(ERR, USER1,
> -					"Option rsa_modlen: %d is not
> supported for public key\n",
> -					options->rsa_modlen);
> +				if (i =3D=3D (int)RTE_DIM(rsa_pub_perf_data)) {
> +					RTE_LOG(ERR, USER1,
> +						"Option rsa_modlen: %d is not
> supported for public key\n",
> +						options->rsa_modlen);
>  					return -EINVAL;
> +				}
>  			}
>  		}
>  	}
> --
> 2.49.0

