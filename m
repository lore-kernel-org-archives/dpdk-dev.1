Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41708CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F4FC4028C;
	Tue,  4 Nov 2025 15:09:50 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0CB5340269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:09:48 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A4DieMN1520185; Tue, 4 Nov 2025 06:09:48 -0800
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020114.outbound.protection.outlook.com [52.101.85.114])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a765rt651-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Nov 2025 06:09:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXaDxTQak21v58kk4N6Gg6y2OLCBG/j65inhpUa3DABlNk1U1N0UlrjY6mCkjmQ7s8X6aRAlLezOFbHzLbGpaSY6XDloOxyKFQQ97uJiEFnpKlX57gBH0h1JXWsIzS07xegdxuOOspWMven03icmCeYOu2lJtynHiXgJ3hZC2AVh7kOeGN6duDTkyzo1wDogEjxz527YkUXibJNt+yKHhT6Ilxk1LgJsRnC5werwiQ4vQx5JGtZaDOMISlHjDDbQu+mvvODCxwzRyisPZE+q15KVfJ4HmlGO8WTpk8MvhiKRXERDdZfsFKyuKbIHf0Lxa6jOYyYOE0gZ8QrjqZoYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkmqI/rhJUXKHEkkoftTXVZCtyQH7XiPYbWFmp4o3qQ=;
 b=H1LhEEv5RL/Vs55JTHpZ7JHHcbxsu0oRlT6PEcSE1esaQvspZnGej++V74tGvBy8mdZPHyp8UBTgpmwSCOSzVN+JA4y5posp8EwiLfgLsNJISlIPaoBya3r13lAsKKng7bnReujYZuRpua84FuUY+Piocdx8KtgAE9vpbS/s4r20e5sZK1trSUScGeST1Hd3UjaTOdsjxbL45kEK2Xc/KGxWe4XNZGzInZKVbcaIx+XwhkJVJUIM5DQhX8BZZOMdtNDc+ZM1zXegnYE3BikInC/iw6tdYs9mWvI4Uxjbk0P+cP6+Cx3d04G7ArONlfxe3On3+uSKdTPDew1hZo6PNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkmqI/rhJUXKHEkkoftTXVZCtyQH7XiPYbWFmp4o3qQ=;
 b=BYoRSaAtxil56zREOEv1QQYHm7HV/2jeje+IM4D0+Y4VCsW34s7RfryVA9uudV/AKPU5Sj18kF30hzFuH2+UW9zxcC44RMZvsi4yEcG5QmRegx18jZNChOB2OPXy5Rt5PGymEopnIDyJLPz7OmcQLaBw29bgvOgpJTRm9BVrtBY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB6003.namprd18.prod.outlook.com (2603:10b6:408:230::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Tue, 4 Nov 2025 14:09:45 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:09:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: fix coverity issue
Thread-Topic: [EXTERNAL] [PATCH] app/compress-perf: fix coverity issue
Thread-Index: AQHcRRoH5cJ7/gDmTkOnj0Cc5qzWBLTinvUQ
Date: Tue, 4 Nov 2025 14:09:44 +0000
Message-ID: <CO6PR18MB4484342AD1BBFA1E06C73908D8C4A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251024191125.1728953-1-svaze@qti.qualcomm.com>
In-Reply-To: <20251024191125.1728953-1-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB6003:EE_
x-ms-office365-filtering-correlation-id: c55f15ee-c47d-4e8b-e1c0-08de1babce7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?CtaWloJoSzUbWkRPYmquR+kn3i09l+jLOhdqPPpuV+xtOS7a/DLiJe8p5VLP?=
 =?us-ascii?Q?rbJxeN2iiCtbFvJBgPeyc2g7mqmYr8ZBsQtSv9NURRJISIns04MNA3P71V4F?=
 =?us-ascii?Q?QNGhTuzT65FOsKDaMggAcAPCH8IKtdJi2dY9a3G9Xq0DDsWr4xeOyHbQpf+9?=
 =?us-ascii?Q?LrlOcl6hzH38baOfYa1Cf1ezwOUg5O3rz60S0YewO70BYfEzrTvMbH9/wn/E?=
 =?us-ascii?Q?Caajz8FWqLvu3M+LVNrtfNIWvFlajpoeVvwYXQoWyOg3nmxmDKCjhfwc/HJP?=
 =?us-ascii?Q?FEL21zDxjuyBdsDspHuu0JkI6aaFOnKWH3l11bUugLiWPu5kKOT/ESojoNNy?=
 =?us-ascii?Q?2cHHEQyExYXR8+7mnrdSI1ohwPPha3TKZ7D1s/1hF8+y2TTOGEDM0x3XPHxE?=
 =?us-ascii?Q?kHwecUf+eZ0lQgvubA2BznDieCcSGxD0lvXr5FPmgjVNTTUx5cOdxSbt47nh?=
 =?us-ascii?Q?d8cJynBzXQlPBfTwuKC2BuLYTOWbpIhY9v527veXIZ++G26kh+06Ohuzq3yG?=
 =?us-ascii?Q?0rOWwGRf4I6EwKNl8BfdY5cN8U7/22yzosvuluscVS96W8wvdMIctWDegjIx?=
 =?us-ascii?Q?qniCJVgVyRgz/3oFHylBskpD1bha+ONScdftIfAjlHBv4JxgmVhRHXM7Xdxa?=
 =?us-ascii?Q?blkqqbMGvmBIS5CACJEaGNlCytZjJxsyCFDPNAiiAshxvPDu/0eC2/zu3kry?=
 =?us-ascii?Q?4f705NTyXteLKxMR/T24Ijk1JuUPZA/3pYQnftHhvRCorncdnyS6pag5EUGO?=
 =?us-ascii?Q?6DvCxdOxLc6Ij1PZoa/60pYVdpun9YfZfcEH7Qc/Jih/na1r3nLl+euE2Zhx?=
 =?us-ascii?Q?TDEi9i2XZqiPlkGoM9jCzl6+xDbIMxXoucLuRenEOapb00fo1vopaEooa1vX?=
 =?us-ascii?Q?LnaPDbWYhuSqK4BaMuQP3S4nITB81sWDnkEmZFe5CKkD4ugEOEeg/kmXHCuG?=
 =?us-ascii?Q?y/km5A78p8g8mH2fEqzMGqKE+m2rE2b5NTVCooLjDuEVDg9kcL9RXXkB9yTq?=
 =?us-ascii?Q?88gkzom8gYQc6w2NDKtw4ARAc17oX+Bex2UWoh/Bd5bN6WrixKQRSkVvhnec?=
 =?us-ascii?Q?ZqI/05U9EzugXVmfm7qWNJ9UE0p28JEKN6ekVBi4ZPhNuiy9lNm2l80bp25s?=
 =?us-ascii?Q?H28HF7RxsVeWUU95+Tw7/A8g/rlkcekiSd5LZ3s7fuKQiZty3ApOkp5+Xpqz?=
 =?us-ascii?Q?/Lx24vp/oAV8I46ho/g1cvUwFxSTyLZTQmxdrDaBbsWOh2XhbLUpBo8abQpG?=
 =?us-ascii?Q?B3Zx2Z+9HOj6xZco2JxF0ETYIlNOWm10hBI8xhPaok+tFRDMoCIigGzHR78v?=
 =?us-ascii?Q?2cWof0TMVO4dwvH6YzovG4r0TYZ4vZYMwBlkzOIEq0ZxYkL/f9xDSUYicU4r?=
 =?us-ascii?Q?oDdqedi7yyzuz8YrS/y3pSPO3HZPENLe+T9QoueShP3RiJDzyp1qwLpRc5c4?=
 =?us-ascii?Q?Qs9+vONXIRYrVu5UJyJhqUh7lZHZA0TnqDUzdXNEBKd+B2nsAR/jXmtiIXy8?=
 =?us-ascii?Q?ExbYsFm4J1+SRvoUX3YBnUvk2SBYcRR1QWYD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GDqXYtC34uuX18e/hWsXd0F1j2SNwIBOebxa1qGi8hDre13nuMlXHG02CI2P?=
 =?us-ascii?Q?0LcIFMnLUeT/pEfLqsnPQKxeawfGwKELUwppJvZhZwQ/V49j79l82xLtX5Nu?=
 =?us-ascii?Q?EqVy3EFgIwKopfRSvI1rJnOuZnuJC4rk7xHdajC1ThzkInd/LjJ24REx6Ul9?=
 =?us-ascii?Q?aemmicjHo88/PTc0HIzL5teOOdQqYGMQ5voKGcZSi5o2FJ48e+Z3ZhABMynU?=
 =?us-ascii?Q?HkPfn6L6zBzHg+9wLGzYczkE5n1s7zb4cpsGFfhnRZgQDNhRhNxvMNXiOPbz?=
 =?us-ascii?Q?qR4UTPiUD4Xk/5U42sYJnDEkQLpJrSHNX9vNCFFbMjiQSAV6uqSBPQ5/dPL5?=
 =?us-ascii?Q?8B8nxcRnfW2BxdmprA6fk5u5j/GsBBe1JtleAQG40HG4rocG6mmcrRefNxlH?=
 =?us-ascii?Q?L2QeYeU4vhYPzJL99N37OwfGpw2URM1ujD4SBxb+dfuPxSC9s6mykp7ln02X?=
 =?us-ascii?Q?cUJw5HZrMFWuBxIBFsL81q2c72p+UM2zH1r11SSjzRcHhN4QX3QftNE/iRaq?=
 =?us-ascii?Q?Jo8997bH1zwnfxZKGp14B0f+sfkTgXc96MRz9zpZVRR0bs7MRcywmS78HxPU?=
 =?us-ascii?Q?2GarjUxjic7e0CAjxijWJpT3B9n9HLhhgtS5nz077qRAqGPqVSJOI3Pqye92?=
 =?us-ascii?Q?bYHxBVAIC8BnPttPUKhn1zlzpSHWh5uNhvFgBqPDcmLROnl4oC4l77ojkgI8?=
 =?us-ascii?Q?zu+uPbx62yrSQlGcw2Gb6a+OS7zPJiIAZoI58AD3B+YJbabrIzxaaZ9BK5eX?=
 =?us-ascii?Q?oThfMiko2HU5SV2puGmc327ehiU97SIAN4X5lPv2iz4kAtux+Jen8VjGLmvf?=
 =?us-ascii?Q?FkYPtDGwFxS0aR6KSfZENbbi13b5iqdgMCbaIeUAAGr+znWSROTTtx7LmIZx?=
 =?us-ascii?Q?5vLJ/c0VKAz7aW15K4JrYT8BYsuonmMDpOkVfIsYaZ/UyTxXjSkHnK2bGrNx?=
 =?us-ascii?Q?pKVDelv7aKl5I6ucIPCZHLQ0c5sk1OnS3Yi9fO1xWhOMsAvTgjWf+L75Q7LT?=
 =?us-ascii?Q?pLt80dpR112zd2zasS6G6/l2zgrYjVxf8e+2VZ4JUdbPU6oU/1F8lwB4K1qL?=
 =?us-ascii?Q?9ZFAa271eAcoFx+iwKhb8hv64PsT6W07T0FQFs+4ig1cml0pwT70mGU+ew5w?=
 =?us-ascii?Q?zYOlTo3JWDC2PCwT5Uk2qRxBug4ihe5WIfg8qpjP+RH0APAIdh6uuV1Zap+r?=
 =?us-ascii?Q?bHvBUiTLEW5uf2j7IA0JvDM0/TYxXDUXg1QaA65LYfg4Y03EnnRHOntFN32u?=
 =?us-ascii?Q?CUr8su7ojvT9exJSkxfza0UNBFqagzOXKa0nmG8XVGeU1cpdvTD/i1KMSJiP?=
 =?us-ascii?Q?hA+IQ1IHvn/5MEy8yDzL8CpGoc7C9F7j80W94CN/Kf+uv06bUXL07k/uLcme?=
 =?us-ascii?Q?nclb7wgMNdeYinZOM1BtD3U89N3M/ZYUwy3EoGZrX+nr/huKOpNmmq3wHiPO?=
 =?us-ascii?Q?fxp95+LOArvb6raMHbgTKgP9CA9udglnHdl0erPmgqoAjBO31zpubjhyj08l?=
 =?us-ascii?Q?h0VLA8GTRNumqTC8GdBdCQQ3GiCGmpZCt6muaGeZfnqJbj0SvLINZxPs+e7J?=
 =?us-ascii?Q?MeozxOn0DoEPUifMy6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f15ee-c47d-4e8b-e1c0-08de1babce7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 14:09:45.0278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3H4B1+sepsgoOVI/+4LqFEXkS36vPCm9fDWhfs9/TLoQMCuRy4UR2PAqhVe9rbzZJEL5ALjO6lvv5cbZyH26zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6003
X-Proofpoint-ORIG-GUID: KAv0D7U3FVCORZTvNADV9cYAxUWBuuy0
X-Proofpoint-GUID: KAv0D7U3FVCORZTvNADV9cYAxUWBuuy0
X-Authority-Analysis: v=2.4 cv=P4Q3RyAu c=1 sm=1 tr=0 ts=690a092c cx=c_pps
 a=0Uzpqe5Hikn09oORNzbshA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JkT75c-D3EfwopINXEkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDExOCBTYWx0ZWRfXza2ngyq5iY9R
 lhkrzoOEGIHINArPq1qgGV5AoUCv/Lk6UW0gCey3ZmlnQXpZ04nV4n9lq72vtvVVrkjdt/Az3j+
 /zf1/26wPRJsWEcU0hkfniM1gNN2TcCi76noBhC0WcaxKViZAfi3Jv7ENcbUBCzRoqDHcLulAzl
 nHD1wttuQPATsBsxnnCrESn1ubYqBPmISUyhgR0DSHZsqtiH+/fU/N9nch9+TU9nqIrWn2hfSM6
 Q+jFDgq5wsGHRDK/rOwFPZfUuG1C4I13Fd8biLd8KP9LD08F0G2+DKaCOv/a3xPgUz+AOxJTKE0
 +3bQu1M/uuR89fGf1lGQfhJptPk32qfr6FEAjwXojRn66JmygnqW+gv6XQE2NOrkhamtBAdimnv
 qHvu8o/7lWy1RGjQmF6hnRAxRBtkBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
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

> Removes possible assignment of a signed value
> to an unsigned parameter. Also makes dictionary
> an optional argument
>=20
> Coverity issue: 490944
> Fixes 568815516e88 (app/compress-perf: support dictionaries and PDCP
> checksum)
>=20
> Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>


DO NOT send same patches multiple times with same version.

Fixed fixes tag
Applied to dpdk-next-crypto
