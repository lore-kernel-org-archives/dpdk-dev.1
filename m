Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5EEC021BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 14:11:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC9F142E97;
	Tue, 25 Feb 2025 15:11:38 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 95018427C5
 for <dev@dpdk.org>; Tue, 25 Feb 2025 15:11:37 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PBGopP030861;
 Tue, 25 Feb 2025 06:11:36 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 451cuqradv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 06:11:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWVo2kCLFuupENb5hruRuTMORtZXwDxMO+2SC/SlJTds+LU6L9amI65IlVbL91JwNsZ9pRWtyoMJKQ9DBT2OS77nRs8eGYjyPk+DsjrWf7iypdFKKsj+hat5Mx2y4128qqbvXCv+RTuo4/qZ2RAJUX8Y8vbf0qqtZoegS5Rv1wmmchE/lPfJAo9epAvNO+ycebw/aRak5bjAzNn8IHxc1SXiCcmPwD8m5rUeH30hWWY6Wa0vxAS95AmtvzcFlLTJkHKtDjBrOX9eImJ78mvHOco1blRGbxI7K4dCtBQUX1zVgTsqDoJ6e5hZUGsxpW4K83U5YRRMTME9WXV37XFkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJfYWXng13TbrSkftamx5bUeRpqS+4nTZxy2Yg63Tzg=;
 b=Lyu3G/2NywUG78u95w13p5KD1Y3pgQ/s4A4LVD+j5+u/KtlXOwn+0V9y2FpxFW2Bndn5uDKdfn17qGHpy5IFuu7musY0tnUweFD2ofOvRLWBy+iIfhnoPRev/Efhk5vKeI7K6x19X0RoPfqb57V4cwGgHYVAy7rjLptl92MT+ENADiO/u0ESyn6Y4dkJyJEqyi2fQZuke/+ULcs93TVYcBaYq42jriNkq3Qa0oFzDZf3v7UCRnSsJg56u2yerIjeqyrndWdHQVaaIZdoqy/keDzS4XLgMeMProke/+a9dVrTdNbz8je8PmlAQ7MVfZAGovQ9CWfLk49lpDMuCW4mMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJfYWXng13TbrSkftamx5bUeRpqS+4nTZxy2Yg63Tzg=;
 b=AlbMh+Y84PonPx+4Fj0vA12znpQavKSAGHqsk9HtxP3+c0PUmS5ywfm85d9gwwaU2Qje3SQm3Pl4ZHCnnRZVfN9NPDbkSWPYrrlpoZ0zof+UyDfWDBD6Gf9rL5TqKSVBIQnkfipclASAkuVrgqj8o33gH08hUVUfW8mrRhRob2A=
Received: from PH0PR18MB5167.namprd18.prod.outlook.com (2603:10b6:510:168::7)
 by DM3PPF465B07FD6.namprd18.prod.outlook.com (2603:10b6:f:fc00::69e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 14:11:33 +0000
Received: from PH0PR18MB5167.namprd18.prod.outlook.com
 ([fe80::fd38:dcb3:d404:a4b6]) by PH0PR18MB5167.namprd18.prod.outlook.com
 ([fe80::fd38:dcb3:d404:a4b6%3]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 14:11:33 +0000
From: Amit Prakash Shukla <amitprakashs@marvell.com>
To: Shiva Shankar Kommula <kshankar@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 Bhagavatula <pbhagavatula@marvell.com>
Subject: RE: [PATCH RFC 2/4] eventdev: refactor rte_event_dma_adapater_op calls
Thread-Topic: [PATCH RFC 2/4] eventdev: refactor rte_event_dma_adapater_op
 calls
Thread-Index: AQHbcltC7sdG+h41SUCa4506DdRgzbNYOXWg
Date: Tue, 25 Feb 2025 14:11:33 +0000
Message-ID: <PH0PR18MB5167F676BDF6C7B75B74073EC8C32@PH0PR18MB5167.namprd18.prod.outlook.com>
References: <20250129143649.3887989-1-kshankar@marvell.com>
 <20250129143649.3887989-2-kshankar@marvell.com>
In-Reply-To: <20250129143649.3887989-2-kshankar@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5167:EE_|DM3PPF465B07FD6:EE_
x-ms-office365-filtering-correlation-id: b11b2875-8fd3-4d2a-b87a-08dd55a64ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?em9jB+1oHqm8pjoOOoIcoF9XsIki9QFV6CgrbJsTcVuBsAo37EC210bxbe+E?=
 =?us-ascii?Q?94S4lNucCIVoOT7jfI/mUYC/9TO4x9euDBfSkKw2KNzzLY4uYQXiVa4JvOal?=
 =?us-ascii?Q?ebYM8wwjvnwIuDteYfP+djG84TPzqFoqhdtCb6/pHzdPk4hQhXqAvuDQ/a86?=
 =?us-ascii?Q?CwW3vol7OnkO+iELTUAq54YdZXHs/beRxMMDzrZaqQ8o6BZ4RNdBxJHJ1Rvm?=
 =?us-ascii?Q?n9VwVj5YyU52IkcUK5jbk6d/VzLSmvJRQDtDR+uZIBhiWhE/aRk91/tRXYCM?=
 =?us-ascii?Q?aN8kpYUDiz/G9IVW63AG0Avol9Rw7TBJcYJhQXMuuIXZ2uXB9IDts5vfg8Ga?=
 =?us-ascii?Q?JcKH7OJCU1OKC+rtJzSfLHh4b13Aqgltf45rNYx4+H+3CXmCAMvnmL/ii+xv?=
 =?us-ascii?Q?g7DcBfc19ZtLCxtezATTnebQzLBpABCe4dYfAoI42YSas5EpvFwnWLNCnYWm?=
 =?us-ascii?Q?+2xB8swXXyKbHLNd1ThvuZuUjgWDGR4cqZXRouH57hKTw2aw+oOWm1OWVCmc?=
 =?us-ascii?Q?T7315dIxHNEZgKU+Nw6Unh1hOsAP/wcahb6PlCsXJnd+m5reGQyWXhHXfkqA?=
 =?us-ascii?Q?PQFD2ud6zIrPVB9eIOoYQ28zleVJimP/6ttV4eN5sI9bOb94OwQV5zFzpQu4?=
 =?us-ascii?Q?Nd0pgrjy+ECGN8fB+2nZWccV6Y9F1KsOjbUrk7UZ/ejWu2fm/uOXtspHnH9f?=
 =?us-ascii?Q?vIegW0WHQ73XVDpv6G7dpWLX2bVCJvz0dew++2WtdMhPtU+GHs8SPEBwJrqH?=
 =?us-ascii?Q?j27191KZcBtSgxgX4aBL/Cgg0ioEC+N1SluQ7Je2hFbzW3Ojhi7/1v+PpJj2?=
 =?us-ascii?Q?4pI7bDtxkXEfqyoUYPYKqvGN0q1HosxoDbGgu47wuEfUM675h1kUC8q/BaBk?=
 =?us-ascii?Q?gvGrHNsJ6qjfNRX7czsWTRBQhCNF6mO6ek16xRRgjKQuUbtyNRNkUgA2X4e7?=
 =?us-ascii?Q?MRAwIMuJfojJbEGCyrovmDwDyHm+NOjEU4OpSQ25j0fgCZgReTrFi2KyCOu1?=
 =?us-ascii?Q?NDwXWmOhSr8jM0KG5Dk/2wYc1JpUjnb7cembq94Fn9F693hzv//JtOpJArxN?=
 =?us-ascii?Q?7mr2/uWeJeJ6mrBScNZih15iNZNqYInR+Zy6zVTCqWWY4Lkgsv4+2kgIau4M?=
 =?us-ascii?Q?3+LVPq25NPL+P8OVqvqkM3hiSt0BqvXtbQjHkOkyc97uE4wRcMYpD4XPBgcc?=
 =?us-ascii?Q?BmlO5chKIpGKu9xcHFaziGfptIBN/F5DNhMVz4pCldEh0GGd6DWmkOY8JvIO?=
 =?us-ascii?Q?Ih5DBjAIVIZ3Ix6B4UKpiESZiik3dNCoeS7zfKqDpUBgAaVVKUv9Y1RY0vcz?=
 =?us-ascii?Q?zVfrznWjxsAMDFsYl1Ak8Yn65MhZBxqOy61pbviK0cby/r+KXtjqXzdWOM+E?=
 =?us-ascii?Q?tHz/hCBeLMR+ZDACh37gh++C2CZZ9Az3kFlGfeq7vYoAvgYVUUbHJzjTk+D0?=
 =?us-ascii?Q?r2yFJGjHMqPgCp2WL/97usg6JdeBhA+U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB5167.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mzX5bxIuqZAV+UALD6q/9qo3Fy27Ym1dE4aNAvqBDM6upqx6/rp2b1ag+BH2?=
 =?us-ascii?Q?QpDstWrdOsahBZyI8vGgU+QOG3M1kXt7AGnsQ1sO3euYRfXSkrLNst8sIKLQ?=
 =?us-ascii?Q?tRP5+WnBq3M4mrqjPpnyNYhj0Q174ucfMzY7Rk3oBGrP/UY3CJbl7KV8ooDl?=
 =?us-ascii?Q?DRFFeViOTCta1IAAR9hOSsn5BteV4TxNEItYpzUJNR4MG2pGp6/huQ8IW+04?=
 =?us-ascii?Q?kJM2mHKaeqVk+QTn+x+ZKwkEzDkBOiXfm2wH+Cv+lwZOmTIkiSgnzSRxSCQG?=
 =?us-ascii?Q?C/xzdxOO9HhoHOxLtSjg6z0RoOL9+Ric3n3RBACIvxHtrrpDHfQndzKRVd13?=
 =?us-ascii?Q?RgRTf7Mx7rJGVmE6HSLEdo5k+x5yGDc+2UuVQuX+ejnwBBdFTbL+NeTUaFTX?=
 =?us-ascii?Q?z2ioWqzKkIo89wx1vivk0By2VFpOPaXWm+nhrs52soXeFq0vfKaQl+VQliTO?=
 =?us-ascii?Q?grWzN1V3OqNVBoXyHYzBRZhMGKNIMaLoy5vmNBig6UUnzTZQyrQ1gL+td641?=
 =?us-ascii?Q?TcTVAVoEPIJ4hapXIENmEatA+QNgnaCZ8ATFBLDcLYnQhpsxtwEJHCdluF3e?=
 =?us-ascii?Q?izu7m5lsToBFdne5c+mO2cgrszanrNp2lBA8MVjN/CcS+bfe23GHp9idi2h3?=
 =?us-ascii?Q?oyRMT8gXz3/UfPSQgP68isFODWOMGICUqmpbsj3OhbuHRgttRmUc959mF62Q?=
 =?us-ascii?Q?g3aRQKHK1BqUz8Jf6cWttQiUEC1hXH/XcW+Q3MQYd/T6wcQuLETzX+Y8FK8B?=
 =?us-ascii?Q?ULHP8BRC9pifY9vjf8BWo5RT0J7+29+nC83u8RBShPhi0Fb+WAW5Y2jqIdka?=
 =?us-ascii?Q?MfgevRcIy08B648HM5mOUU6WtXjdga6Yoke9q8sFXE8hbHG8oUHwGdNeevUo?=
 =?us-ascii?Q?HC22h/XdKntwqvtVek1lykcg0Z3ugz+eRrCSE6XOqq+if0EFD7iWgoAH+80K?=
 =?us-ascii?Q?rn7x8oXKCPQrxpF4oUi03/fnPMYbckgfjZRVDT3Ezyk2w5Sf94jiTfaGRfOO?=
 =?us-ascii?Q?O3akYhRILEO4qSWwFIdkCnSusRdSE/OoRFszBfqfHMUdfrrlGGufKLiUx/S1?=
 =?us-ascii?Q?tAJL4wierRzh7QC6uZ0C6s9djEfCu8QaYiBlh659j2AlTREx+HoKT63NVVpa?=
 =?us-ascii?Q?CDFRlSZ1Wze6JVhOBh1fMU0lZieT8yRGlvlwWzBNfT87aZeGjytGvPZS9sHB?=
 =?us-ascii?Q?0V9Myp2zRqTxcrfuX5Kerk/fzHQOmHJEFczP8NDFIpSwjJjdGAC64kH+l/0k?=
 =?us-ascii?Q?rMOgCyRBQ/Q0oaLJ7niof16ZXyMr+sPHHQ+QFq3XfiUkbydWS/ag8JgStU66?=
 =?us-ascii?Q?SyGAuXQuug7VKtFSOY6ygdJ9FQOpkWBxaQdJFKHaZPZOKzOhZdhOdK0yl8zI?=
 =?us-ascii?Q?HVsSA0AtLzKlfscR6x5v1Zx+WNuZ9WfMjUDpddksitse5obcxL5vrobfwNQf?=
 =?us-ascii?Q?BMbLmrDm77I90UmVNkoK0ClKvQNaljV06NSSXTX2+gG4tLKiQ0/2/sPYKWtA?=
 =?us-ascii?Q?bhEQgu715RBktoXIF+4wFl983uKcys+Kl5G+lr91yjGDDfJQxaQJMBRBx0qd?=
 =?us-ascii?Q?30jvfuQvhy3vh/b5FIjJ2UM2LnvafE4wLid+1k0J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5167.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11b2875-8fd3-4d2a-b87a-08dd55a64ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 14:11:33.2269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Rcw+BGgtbcNQF6yJGnOBi6yWObND34hu5frkeh0yHaaBSdQoNTLyRo4YWDkSxzILTMqd1l+jy9iJ31FydLQU/Rxe3/FxVm7mAjGNE90gEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF465B07FD6
X-Proofpoint-GUID: g6nDmj_gWXbzKPX4uobyE89oFYv31t6c
X-Proofpoint-ORIG-GUID: g6nDmj_gWXbzKPX4uobyE89oFYv31t6c
X-Authority-Analysis: v=2.4 cv=QNuSRhLL c=1 sm=1 tr=0 ts=67bdcf98 cx=c_pps
 a=ybfeQeV9t1qutTZukg5VSg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=i0EeH86SAAAA:8 a=8rWy6zfcAAAA:8 a=ae6P5qsXCPzXREf-m0wA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
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
> From: Kommula Shiva Shankar <kshankar@marvell.com>
> Sent: Wednesday, January 29, 2025 8:07 PM
> To: Jerin Jacob <jerinj@marvell.com>; Amit Prakash Shukla
> <amitprakashs@marvell.com>; Vamsi Krishna Attunuru
> <vattunuru@marvell.com>; fengchengwen@huawei.com; dev@dpdk.org
> Cc: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Pavan Nikhilesh
> Bhagavatula <pbhagavatula@marvell.com>
> Subject: [PATCH RFC 2/4] eventdev: refactor rte_event_dma_adapater_op
> calls
>=20
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Migrate all invocations of rte_event_dma_adapter_op API to rte_dma_op.
>=20
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> Change-Id: I56b6e61af72d119287b0d2ba6a9bbacc3ae808d6
> ---
>  app/test-eventdev/test_perf_common.c |  6 +--  app/test-
> eventdev/test_perf_common.h |  4 +-
>  app/test/test_event_dma_adapter.c    |  6 +--
>  drivers/dma/cnxk/cnxk_dmadev.c       |  2 +-
>  drivers/dma/cnxk/cnxk_dmadev_fp.c    | 12 +++---
>  lib/eventdev/rte_event_dma_adapter.c | 18 ++++-----
> lib/eventdev/rte_event_dma_adapter.h | 57 ----------------------------
>  7 files changed, 24 insertions(+), 81 deletions(-)
>=20

Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>

Thanks,
Amit Shukla

> diff --git a/app/test-eventdev/test_perf_common.c b/app/test-
> eventdev/test_perf_common.c
> index 627f07caa1..4e0109db52 100644
> --- a/app/test-eventdev/test_perf_common.c
> +++ b/app/test-eventdev/test_perf_common.c
> @@ -562,11 +562,11 @@ crypto_adapter_enq_op_fwd(struct prod_data *p)
> static inline void  dma_adapter_enq_op_fwd(struct prod_data *p)  {
> -	struct rte_event_dma_adapter_op *ops[BURST_SIZE] =3D {NULL};
> +	struct rte_dma_op *ops[BURST_SIZE] =3D {NULL};
>  	struct test_perf *t =3D p->t;
>  	const uint32_t nb_flows =3D t->nb_flows;
>  	const uint64_t nb_pkts =3D t->nb_pkts;
> -	struct rte_event_dma_adapter_op op;
> +	struct rte_dma_op op;
>  	struct rte_event evts[BURST_SIZE];
>  	const uint8_t dev_id =3D p->dev_id;
>  	struct evt_options *opt =3D t->opt;
> @@ -2114,7 +2114,7 @@ perf_mempool_setup(struct evt_test *test, struct
> evt_options *opt)
>  	} else if (opt->prod_type =3D=3D EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
>  		t->pool =3D rte_mempool_create(test->name,   /* mempool
> name */
>  					     opt->pool_sz, /* number of
> elements*/
> -					     sizeof(struct
> rte_event_dma_adapter_op) +
> +					     sizeof(struct rte_dma_op) +
>  						     (sizeof(struct rte_dma_sge)
> * 2),
>  					     cache_sz,		       /* cache
> size*/
>  					     0, NULL, NULL, NULL,      /* obj
> constructor */
> diff --git a/app/test-eventdev/test_perf_common.h b/app/test-
> eventdev/test_perf_common.h
> index d7333ad390..63078b0ee2 100644
> --- a/app/test-eventdev/test_perf_common.h
> +++ b/app/test-eventdev/test_perf_common.h
> @@ -139,7 +139,7 @@ perf_mark_fwd_latency(enum evt_prod_type
> prod_type, struct rte_event *const ev)
>  		}
>  		pe->timestamp =3D rte_get_timer_cycles();
>  	} else if (prod_type =3D=3D EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
> -		struct rte_event_dma_adapter_op *op =3D ev->event_ptr;
> +		struct rte_dma_op *op =3D ev->event_ptr;
>=20
>  		op->user_meta =3D rte_get_timer_cycles();
>  	} else {
> @@ -297,7 +297,7 @@ perf_process_last_stage_latency(struct rte_mempool
> *const pool, enum evt_prod_ty
>  		tstamp =3D pe->timestamp;
>  		rte_crypto_op_free(op);
>  	} else if (prod_type =3D=3D EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
> -		struct rte_event_dma_adapter_op *op =3D ev->event_ptr;
> +		struct rte_dma_op *op =3D ev->event_ptr;
>=20
>  		to_free_in_bulk =3D op;
>  		tstamp =3D op->user_meta;
> diff --git a/app/test/test_event_dma_adapter.c
> b/app/test/test_event_dma_adapter.c
> index 9988d4fc7b..7f72a4e81d 100644
> --- a/app/test/test_event_dma_adapter.c
> +++ b/app/test/test_event_dma_adapter.c
> @@ -234,7 +234,7 @@ test_op_forward_mode(void)  {
>  	struct rte_mbuf *src_mbuf[TEST_MAX_OP];
>  	struct rte_mbuf *dst_mbuf[TEST_MAX_OP];
> -	struct rte_event_dma_adapter_op *op;
> +	struct rte_dma_op *op;
>  	struct rte_event ev[TEST_MAX_OP];
>  	int ret, i;
>=20
> @@ -266,7 +266,7 @@ test_op_forward_mode(void)
>  		op->vchan =3D TEST_DMA_VCHAN_ID;
>  		op->event_meta =3D dma_response_info.event;
>=20
> -		/* Fill in event info and update event_ptr with
> rte_event_dma_adapter_op */
> +		/* Fill in event info and update event_ptr with rte_dma_op */
>  		memset(&ev[i], 0, sizeof(struct rte_event));
>  		ev[i].event =3D 0;
>  		ev[i].op =3D RTE_EVENT_OP_NEW;
> @@ -396,7 +396,7 @@ configure_dmadev(void)
>  						       rte_socket_id());
>  	RTE_TEST_ASSERT_NOT_NULL(params.dst_mbuf_pool, "Can't create
> DMA_DST_MBUFPOOL\n");
>=20
> -	elt_size =3D sizeof(struct rte_event_dma_adapter_op) + (sizeof(struct
> rte_dma_sge) * 2);
> +	elt_size =3D sizeof(struct rte_dma_op) + (sizeof(struct rte_dma_sge) *
> +2);
>  	params.op_mpool =3D rte_mempool_create("EVENT_DMA_OP_POOL",
> DMA_OP_POOL_SIZE, elt_size, 0,
>  					     0, NULL, NULL, NULL, NULL,
> rte_socket_id(), 0);
>  	RTE_TEST_ASSERT_NOT_NULL(params.op_mpool, "Can't create
> DMA_OP_POOL\n"); diff --git a/drivers/dma/cnxk/cnxk_dmadev.c
> b/drivers/dma/cnxk/cnxk_dmadev.c index e7be3767b2..60b3d28d65 100644
> --- a/drivers/dma/cnxk/cnxk_dmadev.c
> +++ b/drivers/dma/cnxk/cnxk_dmadev.c
> @@ -591,7 +591,7 @@ cnxk_dmadev_probe(struct rte_pci_driver *pci_drv
> __rte_unused, struct rte_pci_de
>  	rdpi =3D &dpivf->rdpi;
>=20
>  	rdpi->pci_dev =3D pci_dev;
> -	rc =3D roc_dpi_dev_init(rdpi, offsetof(struct
> rte_event_dma_adapter_op, impl_opaque));
> +	rc =3D roc_dpi_dev_init(rdpi, offsetof(struct rte_dma_op,
> impl_opaque));
>  	if (rc < 0)
>  		goto err_out_free;
>=20
> diff --git a/drivers/dma/cnxk/cnxk_dmadev_fp.c
> b/drivers/dma/cnxk/cnxk_dmadev_fp.c
> index 26591235c6..340c7601d7 100644
> --- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
> +++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
> @@ -453,7 +453,7 @@ uint16_t
>  cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t
> nb_events)  {
>  	const struct rte_dma_sge *src, *dst;
> -	struct rte_event_dma_adapter_op *op;
> +	struct rte_dma_op *op;
>  	struct cnxk_dpi_conf *dpi_conf;
>  	struct cnxk_dpi_vf_s *dpivf;
>  	struct cn10k_sso_hws *work;
> @@ -514,7 +514,7 @@ uint16_t
>  cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t
> nb_events)  {
>  	const struct rte_dma_sge *fptr, *lptr;
> -	struct rte_event_dma_adapter_op *op;
> +	struct rte_dma_op *op;
>  	struct cn9k_sso_hws_dual *work;
>  	struct cnxk_dpi_conf *dpi_conf;
>  	struct cnxk_dpi_vf_s *dpivf;
> @@ -530,7 +530,7 @@ cn9k_dma_adapter_dual_enqueue(void *ws, struct
> rte_event ev[], uint16_t nb_event
>  	for (count =3D 0; count < nb_events; count++) {
>  		op =3D ev[count].event_ptr;
>  		rsp_info =3D (struct rte_event *)((uint8_t *)op +
> -						sizeof(struct
> rte_event_dma_adapter_op));
> +						sizeof(struct rte_dma_op));
>  		dpivf =3D rte_dma_fp_objs[op->dma_dev_id].dev_private;
>  		dpi_conf =3D &dpivf->conf[op->vchan];
>=20
> @@ -586,7 +586,7 @@ uint16_t
>  cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t
> nb_events)  {
>  	const struct rte_dma_sge *fptr, *lptr;
> -	struct rte_event_dma_adapter_op *op;
> +	struct rte_dma_op *op;
>  	struct cnxk_dpi_conf *dpi_conf;
>  	struct cnxk_dpi_vf_s *dpivf;
>  	struct cn9k_sso_hws *work;
> @@ -654,11 +654,11 @@ cn9k_dma_adapter_enqueue(void *ws, struct
> rte_event ev[], uint16_t nb_events)  uintptr_t
> cnxk_dma_adapter_dequeue(uintptr_t get_work1)  {
> -	struct rte_event_dma_adapter_op *op;
> +	struct rte_dma_op *op;
>  	struct cnxk_dpi_conf *dpi_conf;
>  	struct cnxk_dpi_vf_s *dpivf;
>=20
> -	op =3D (struct rte_event_dma_adapter_op *)get_work1;
> +	op =3D (struct rte_dma_op *)get_work1;
>  	dpivf =3D rte_dma_fp_objs[op->dma_dev_id].dev_private;
>  	dpi_conf =3D &dpivf->conf[op->vchan];
>=20
> diff --git a/lib/eventdev/rte_event_dma_adapter.c
> b/lib/eventdev/rte_event_dma_adapter.c
> index ff2bc408c1..7baa46e0a3 100644
> --- a/lib/eventdev/rte_event_dma_adapter.c
> +++ b/lib/eventdev/rte_event_dma_adapter.c
> @@ -39,8 +39,8 @@ struct __rte_cache_aligned dma_ops_circular_buffer {
>  	/* Size of circular buffer */
>  	uint16_t size;
>=20
> -	/* Pointer to hold rte_event_dma_adapter_op for processing */
> -	struct rte_event_dma_adapter_op **op_buffer;
> +	/* Pointer to hold rte_dma_op for processing */
> +	struct rte_dma_op **op_buffer;
>  };
>=20
>  /* Vchan information */
> @@ -201,7 +201,7 @@ edma_circular_buffer_space_for_batch(struct
> dma_ops_circular_buffer *bufp)  static inline int
> edma_circular_buffer_init(const char *name, struct dma_ops_circular_buffe=
r
> *buf, uint16_t sz)  {
> -	buf->op_buffer =3D rte_zmalloc(name, sizeof(struct
> rte_event_dma_adapter_op *) * sz, 0);
> +	buf->op_buffer =3D rte_zmalloc(name, sizeof(struct rte_dma_op *) * sz,
> +0);
>  	if (buf->op_buffer =3D=3D NULL)
>  		return -ENOMEM;
>=20
> @@ -217,7 +217,7 @@ edma_circular_buffer_free(struct
> dma_ops_circular_buffer *buf)  }
>=20
>  static inline int
> -edma_circular_buffer_add(struct dma_ops_circular_buffer *bufp, struct
> rte_event_dma_adapter_op *op)
> +edma_circular_buffer_add(struct dma_ops_circular_buffer *bufp, struct
> +rte_dma_op *op)
>  {
>  	uint16_t *tail =3D &bufp->tail;
>=20
> @@ -235,7 +235,7 @@ edma_circular_buffer_flush_to_dma_dev(struct
> event_dma_adapter *adapter,
>  				      struct dma_ops_circular_buffer *bufp,
> uint8_t dma_dev_id,
>  				      uint16_t vchan, uint16_t
> *nb_ops_flushed)  {
> -	struct rte_event_dma_adapter_op *op;
> +	struct rte_dma_op *op;
>  	uint16_t *head =3D &bufp->head;
>  	uint16_t *tail =3D &bufp->tail;
>  	struct dma_vchan_info *tq;
> @@ -498,7 +498,7 @@ edma_enq_to_dma_dev(struct event_dma_adapter
> *adapter, struct rte_event *ev, uns  {
>  	struct rte_event_dma_adapter_stats *stats =3D &adapter->dma_stats;
>  	struct dma_vchan_info *vchan_qinfo =3D NULL;
> -	struct rte_event_dma_adapter_op *dma_op;
> +	struct rte_dma_op *dma_op;
>  	uint16_t vchan, nb_enqueued =3D 0;
>  	int16_t dma_dev_id;
>  	unsigned int i, n;
> @@ -641,7 +641,7 @@ edma_adapter_enq_run(struct event_dma_adapter
> *adapter, unsigned int max_enq)  #define
> DMA_ADAPTER_MAX_EV_ENQ_RETRIES 100
>=20
>  static inline uint16_t
> -edma_ops_enqueue_burst(struct event_dma_adapter *adapter, struct
> rte_event_dma_adapter_op **ops,
> +edma_ops_enqueue_burst(struct event_dma_adapter *adapter, struct
> +rte_dma_op **ops,
>  		       uint16_t num)
>  {
>  	struct rte_event_dma_adapter_stats *stats =3D &adapter->dma_stats;
> @@ -687,7 +687,7 @@ edma_circular_buffer_flush_to_evdev(struct
> event_dma_adapter *adapter,
>  				    struct dma_ops_circular_buffer *bufp,
>  				    uint16_t *enqueue_count)
>  {
> -	struct rte_event_dma_adapter_op **ops =3D bufp->op_buffer;
> +	struct rte_dma_op **ops =3D bufp->op_buffer;
>  	uint16_t n =3D 0, nb_ops_flushed;
>  	uint16_t *head =3D &bufp->head;
>  	uint16_t *tail =3D &bufp->tail;
> @@ -736,7 +736,7 @@ edma_adapter_deq_run(struct event_dma_adapter
> *adapter, unsigned int max_deq)
>  	struct rte_event_dma_adapter_stats *stats =3D &adapter->dma_stats;
>  	struct dma_vchan_info *vchan_info;
>  	struct dma_ops_circular_buffer *tq_buf;
> -	struct rte_event_dma_adapter_op *ops;
> +	struct rte_dma_op *ops;
>  	uint16_t n, nb_deq, nb_enqueued, i;
>  	struct dma_device_info *dev_info;
>  	uint16_t vchan, num_vchan;
> diff --git a/lib/eventdev/rte_event_dma_adapter.h
> b/lib/eventdev/rte_event_dma_adapter.h
> index 5c480b82ff..453754d13b 100644
> --- a/lib/eventdev/rte_event_dma_adapter.h
> +++ b/lib/eventdev/rte_event_dma_adapter.h
> @@ -151,63 +151,6 @@
>  extern "C" {
>  #endif
>=20
> -/**
> - * A structure used to hold event based DMA operation entry. All the
> information
> - * required for a DMA transfer shall be populated in "struct
> rte_event_dma_adapter_op"
> - * instance.
> - */
> -struct rte_event_dma_adapter_op {
> -	uint64_t flags;
> -	/**< Flags related to the operation.
> -	 * @see RTE_DMA_OP_FLAG_*
> -	 */
> -	struct rte_mempool *op_mp;
> -	/**< Mempool from which op is allocated. */
> -	enum rte_dma_status_code status;
> -	/**< Status code for this operation. */
> -	uint32_t rsvd;
> -	/**< Reserved for future use. */
> -	uint64_t impl_opaque[2];
> -	/**< Implementation-specific opaque data.
> -	 * An dma device implementation use this field to hold
> -	 * implementation specific values to share between dequeue and
> enqueue
> -	 * operations.
> -	 * The application should not modify this field.
> -	 */
> -	uint64_t user_meta;
> -	/**<  Memory to store user specific metadata.
> -	 * The dma device implementation should not modify this area.
> -	 */
> -	uint64_t event_meta;
> -	/**< Event metadata of DMA completion event.
> -	 * Used when
> RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND is not
> -	 * supported in OP_NEW mode.
> -	 * @see
> rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_NEW
> -	 * @see
> RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND
> -	 *
> -	 * Used when
> RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD is not
> -	 * supported in OP_FWD mode.
> -	 * @see
> rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
> -	 * @see RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD
> -	 *
> -	 * @see struct rte_event::event
> -	 */
> -	int16_t dma_dev_id;
> -	/**< DMA device ID to be used with OP_FORWARD mode.
> -	 * @see
> rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
> -	 */
> -	uint16_t vchan;
> -	/**< DMA vchan ID to be used with OP_FORWARD mode
> -	 * @see
> rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
> -	 */
> -	uint16_t nb_src;
> -	/**< Number of source segments. */
> -	uint16_t nb_dst;
> -	/**< Number of destination segments. */
> -	struct rte_dma_sge src_dst_seg[];
> -	/**< Source and destination segments. */
> -};
> -
>  /**
>   *  DMA event adapter mode
>   */
> --
> 2.43.0

