Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA4C282D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 05:20:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2716402DD;
	Wed,  5 Mar 2025 06:20:19 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6E0B4400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 06:20:17 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253TLHm029259;
 Tue, 4 Mar 2025 21:20:16 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 456er1r570-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 21:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hauQ88tRZMYWnC27zMKDI/FOPiAIZhpQqt3sonNP4VvLuld5IWpEfnbouoR2ECy7cMsDEbF50wdmkTzG+Jhx3lYTCwCT2VAtZ3OOHC06LqYasJ+TAfnQAfIj6ZyRI7rQgUUNDsBVpaaCLP1DP021nyXSOwtyfqWgq3caCqCLgu5W91SsXwdMWmiDAK9u477ime6KI+O8gNWa0bQMksceHzJLtpfqcA9R/7Cp/PAz3CxtfF+nuJ/6xrEYqXW/fbL/4KOFem7Zj5XjGrD6jPrPbGAZ+k1tmmsDcIpdHvdRKoCxqQsAzHyhAOZdjRyP+pwVqVT4/zmJY7UGAE0jIgXRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a+ybbY3ORdZ2xpx5Kj321VnSiLkrscCSkUDlpQWTBU=;
 b=TvaVi7ozpnF948Ze2oaeT8yTBKqlcFFNEvetOZNl23b/QEtPk8Ty2kVp6ezxwVUpPHNyqeMEclRbn+R93yHjTJIRZZxETimyEIKRKtWBcMSWM3Qb0KS+nwKAjncyftbyvLGiRsv+z9TeT1ONtE5VIPQhzpEI6jsS3PVgSPdWQC0wPBpMBzS27ambVr6Mk/eOLD+rL07JNTXYv/SJrai4huAqNU06MK5z2AUStashOjwOALQaaMPhbydp0NgDDRixNEuxAGR5luljQwWmQsktQvMI5U3D33cXIPwLxwYNNdNlpT9rHYmBF5mBmhYHihFmEp9lKRkc4RTOhJX4boOcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a+ybbY3ORdZ2xpx5Kj321VnSiLkrscCSkUDlpQWTBU=;
 b=pwjXLC/mKGZLNBcDhmZBIKiicAXjlMnZvkOJA/K4f9hWlAmwCUz/n3yyneUNmyDOKZg0Sb+09ZN8QSq7aI6tSfY1qGjS4wswDg2tWvB+FYiJ18L+LAp/N9eDyGLAdbA7B0S0+igAxitrgZ/LrgfQNLvxFvu1T4Le44A/pk9Yd8E=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by PH0PR18MB4409.namprd18.prod.outlook.com (2603:10b6:510:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:20:14 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 05:20:14 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v4 5/5] trace: fix undefined behavior in
 register
Thread-Topic: [EXTERNAL] [PATCH v4 5/5] trace: fix undefined behavior in
 register
Thread-Index: AQHbjR+C7zDpjfQUUE2MKaQol6V7BLNkAicg
Date: Wed, 5 Mar 2025 05:20:14 +0000
Message-ID: <CO6PR18MB386044D9FC76FB057D6040FAB4CB2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250304160633.385185-1-david.marchand@redhat.com>
 <20250304160633.385185-6-david.marchand@redhat.com>
In-Reply-To: <20250304160633.385185-6-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|PH0PR18MB4409:EE_
x-ms-office365-filtering-correlation-id: 485ed331-3571-4a50-9464-08dd5ba568dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Fcu+XNgsEIpapP91QBSMBOd6mLvVyPIS6DkPfwakeX/O/yyVUNr+2GB90J0q?=
 =?us-ascii?Q?fCbXiUicqeMpqrLP/gR2Iq9+qNDz7irELRUzB2Q+X/3yKjHeCDvRC/QXfRTV?=
 =?us-ascii?Q?qrRYOnJDologknuGSh4IL9MCoksacOjGG77eqV/3G/2DFeNNzVtHoAR2HgKe?=
 =?us-ascii?Q?SB5Q5n546G4d/u2J0jo1NhYKe3fNtbKW578Ilp4TzUf5PeUfdNOAE5wtRYhA?=
 =?us-ascii?Q?33uZSRIrFoETTC9OZgmo04mXbJyX9wfXUzODs4bAeuFG+EzFunkFvt0knnbk?=
 =?us-ascii?Q?LtOhwOiB4KLe5nx6TE4GdGPe7HQ9HMWS94VlZ0jRFr1iPa6WBTHlbChjqRMA?=
 =?us-ascii?Q?rsxxVycPOh0JDN8zZhoE6QergKnKw0SU/chHsifELbq9ncm0ecPyotYvyt5f?=
 =?us-ascii?Q?bVwZhGQ8qLX7pCSRBxZuge0KnehpcKLnmxglOiEWpf/iCAu9ShXL2HX8iNCq?=
 =?us-ascii?Q?aThw2hY6M/uC61xJT0qJiqS9oMgTCNUzHoDSivX230uRsRBEuTxwDr8xdzzV?=
 =?us-ascii?Q?/ZrGA8zAo7a6XPoYTJEQrOOJjlX7iChKzNHa4p0jwVXN+ISbXhPgSbpRsChZ?=
 =?us-ascii?Q?3LuZNK5RcQVmjlikqQnoZsEPa882KBb6X0GOu5vWNvkfQAY7KDCfFapAEsYv?=
 =?us-ascii?Q?6b89ZWES81egGoOnmOW3YrYXcEKjiK/cxzgnpXeBzsPDyxILKP8GvBI/qAjL?=
 =?us-ascii?Q?E4mhoJCfHXF9AzLV+40LAPHrBDEgpHbJKceccOKZy1YyzkmJzAyyIh69Towm?=
 =?us-ascii?Q?PCQBcl9UG59W/qvyIAVTbsfYtm8abpST+p09M5rftMbtXkSGZ0Jc2jRDomDK?=
 =?us-ascii?Q?ElAhIlfxzoRFAqEBzZhguYc2ABiH+OZOMgACSoaECSMQ6tn98HZIY9eSzBvC?=
 =?us-ascii?Q?gaiuA8ihK0DIMj3k4ncC2JpGr/kO8NQ2tZ+wgIe9QsZ92E/xpnNoS8HQ+Aal?=
 =?us-ascii?Q?S8A7dm1rHqutqfhskYZrLK0hQlODD/NKxUgvwlKUgac43+MoUDar0/tKyh5c?=
 =?us-ascii?Q?6kvX1ADoRG6LhbuRF+CpmFTnNK2g0i7hMpV+1SuW+ACZeFuBlcBCb3Hx/ts5?=
 =?us-ascii?Q?kA2ceCImb5meS1CPQclkj6yidbdb4DWOAcRXuku8RI/w3AgVNroNorvMe8Gh?=
 =?us-ascii?Q?Lq0Z2psUMfC2ik+pxA1FkOU0qh3MQw7/xXTKpZtVG2SY2j4mKitllcuuq7P5?=
 =?us-ascii?Q?0jmJhDbghxao1Oe52lk5iPIR0Rt3YuUWIruTxLUyAzfLba1b+6Y/AlQH3Iou?=
 =?us-ascii?Q?uapy4F7mtU1kO2CWRT15uNSSdY16jbbAjLzMk4vu092a/0FNsiPRqLlIQHGa?=
 =?us-ascii?Q?v56DuPUfR2KLAmtypSrvxS5ESLBqqNUy6PYGAw/N28DBE369Xab9ddsmUlz+?=
 =?us-ascii?Q?43uxFJ6V9spWwgeZp1FymZshwBrfzh9vhHeD1wzNT8wvWoDBvMpwdoclrs4m?=
 =?us-ascii?Q?INmfk6b1sY0MnD7e1mqe3pgCzawnCRPf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sarqa/QsuPM8dVeJG2CkvYcyWCbBbB9F90YNzUBe8ldfntCyRrBkHpXfjfNK?=
 =?us-ascii?Q?5ggvVZIFjfh+1/UCm+C1gCY2P50pSeAQdv3gbLDtgEROOllT3QxkFaDQRsNm?=
 =?us-ascii?Q?UF+ix4qpORs7ZmbgevEDsxEQ/R2C54H3AOTSlUpVY4rtrJr8hch3RUsu1VOC?=
 =?us-ascii?Q?6xdiNN+zMKoPhBebzWOztOatjGx9U9gRycNyIZgYbNs8P2CchRsKlNxcPXYj?=
 =?us-ascii?Q?o1p9dW2sCxXHgO3zoH/crhLeHlUFV1cGEaLQjsA7Z5u8GMJEuNmo5zSUcFCt?=
 =?us-ascii?Q?34ZAi9ROVKlTEU+ptQRE9YcyWylSukjj7lRUdcY6i8nWMp/lQTKHG3tlUFQB?=
 =?us-ascii?Q?5C3wHjKPCdCG0rt7sr+fAeGN0IQAsrLUyJ5lwmhHG0jhuwqroPc6KiEwFeh+?=
 =?us-ascii?Q?tzlISR2NbGD1Jlu86mwG0VGkl7BitTXS6T4dGEv7NxsIdyj2fwX8txkTlYcQ?=
 =?us-ascii?Q?JXPKKIDYeZU6I+BI1aUeIIuJEl5ThYTWhzjvALznSRUrZY6wgJoxQjhJwHY9?=
 =?us-ascii?Q?hEu8Bo6QBHB15W4U2izhVbZ/xWYBKScucMntBQ9cy17hUNE2n2EIuNrLEqec?=
 =?us-ascii?Q?1zdMlU4Hzs2VWXH6epmLfLnWgiwU89dn36KcnmLFAu7EE071uMzRF4pL4acA?=
 =?us-ascii?Q?5vK2Ef4usuC7Jhz8XLAQm8Ca65NTQ117qpnKLLlJZmFNRIr0AuMK36aSUvDW?=
 =?us-ascii?Q?NAdSqbmTFWH5auu2G13Ar0BckLAluzVI27tzmpUX61FXzJMQc1aT2lCheJc/?=
 =?us-ascii?Q?7JHIlJLmp5nWkEaDyiwx6c57sgOvawdi/Qsvbsb1LXLC9wf6EGueOul/uMVy?=
 =?us-ascii?Q?HNhH0bVlvEPy19QJ/I+80ly6WrDd3zv2qnyQHX4iseIg4wLs8L1ERFELGeGi?=
 =?us-ascii?Q?DHjjKQU9ty65qnA5QL6kirki/nCks7of7vPYLSrUnlWKLDg6iP2v3EzHB++D?=
 =?us-ascii?Q?A8VGMzc89nxc19bzo8PpucMQr72cyb72P20J+M/hxw2iawUEH3s9zUxOlpLX?=
 =?us-ascii?Q?H8RpBedTT8o/ONdvEEFBFi33E52EKVlpOImxiEV7G4axPfqLgITk3XFauCjr?=
 =?us-ascii?Q?ClI+2dm9rN+1CAkjKzzpZ+r0c+1ppe2OV5ED4OkANLgwWKz3n2X311aV19Q+?=
 =?us-ascii?Q?CCbudTDwRMJNUdnEhRerqgZ57L/N7s1K45qQ1xSYuREyzqhAfcpDzFVh308c?=
 =?us-ascii?Q?lEhYtOlhh1dmfe6sK/s1UxN1YgMHUCVtJUjBaSW9B5oh+gUKDxVJqep8v7IO?=
 =?us-ascii?Q?DTLWUfM37Mdz/P7zFr2fvYWaJGulTDZLHGQ5IJziwFtNfoQfHcwrKVAcsqzZ?=
 =?us-ascii?Q?Xw2PxKuaCJmq53S+/TsA3rCl/FugdcLaCffBcD7nvo7V9LO/4aticZs9/WHn?=
 =?us-ascii?Q?4EwF5QD5RpPa9zyRaz8Lurt+JSvFHvskHmOtd235ITR6RQBir3gjWIVfYBj+?=
 =?us-ascii?Q?mV+2dSl3Ej1s9MBxrVIgWv+ltfc7CisTd7SQU/ld/Ai5L+qzmY+mOaL6YvQG?=
 =?us-ascii?Q?71lXeSyCI6fq0mUDvYiaRDCCqvtd/781J5gqView0MoM0lKe4WYO5AdAhRuQ?=
 =?us-ascii?Q?ylI7c0DoOQhdTQS39dw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ed331-3571-4a50-9464-08dd5ba568dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 05:20:14.3099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQr67YKOYJkQ8HX3QcMLHF0SBuPLPI2VfBgK/HKfFD9eDAnG7cM01rRS7SG6Y9rSLoHe96t/JzNJdL8UkQqwxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4409
X-Proofpoint-GUID: eSf54yIUjiw1bo_6gawNhA_EsUSjBmq8
X-Proofpoint-ORIG-GUID: eSf54yIUjiw1bo_6gawNhA_EsUSjBmq8
X-Authority-Analysis: v=2.4 cv=TrcchCXh c=1 sm=1 tr=0 ts=67c7df10 cx=c_pps
 a=mEL9+5ifO1KfKUNINL6WGg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8
 a=koqszod-scvw7nsmKYsA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-04_02,2024-11-22_01
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

> Registering a tracepoint handler was resulting so far in undefined behavi=
or at
> runtime.
>=20
> The RTE_TRACE_POINT_REGISTER() macro was casting the tracepoint handler
> (which expects arguments) to a void (*)(void).
> At runtime, calling this handler while registering resulted in reading th=
e
> current stack with no relation to this function prototype.
>=20
> Instead, declare an additional inline _register() handler for each tracep=
oint
> and make sure that the emitting macros in rte_trace_point_register.h only
> work on arguments name and type.
>=20
> The original tracepoint handler prototype is adjusted by adding a
> __rte_unused for each argument (since emitting macros do nothing with
> them).
> This last part introduces an implementation limit of 15 arguments.
>=20
> With this change in place, the workaround in dmadev tracepoints can be
> removed.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/dmadev/rte_dmadev_trace.h              | 12 ------
>  lib/dmadev/rte_dmadev_trace_fp.h           | 14 -------
>  lib/eal/include/rte_trace_point.h          |  4 ++
>  lib/eal/include/rte_trace_point_register.h | 44 +++++++++++++++++++---
>  4 files changed, 42 insertions(+), 32 deletions(-)
>=20
> diff --git a/lib/dmadev/rte_dmadev_trace.h
> b/lib/dmadev/rte_dmadev_trace.h index 1beb938168..1de92655f2 100644
> --- a/lib/dmadev/rte_dmadev_trace.h
> +++ b/lib/dmadev/rte_dmadev_trace.h
> @@ -22,10 +22,6 @@ extern "C" {
>  RTE_TRACE_POINT(
>  	rte_dma_trace_info_get,
>  	RTE_TRACE_POINT_ARGS(int16_t dev_id, struct rte_dma_info
> *dev_info), -#ifdef _RTE_TRACE_POINT_REGISTER_H_
> -	struct rte_dma_info __dev_info =3D {0};
> -	dev_info =3D &__dev_info;
> -#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
>  	rte_trace_point_emit_i16(dev_id);
>  	rte_trace_point_emit_string(dev_info->dev_name);
>  	rte_trace_point_emit_u64(dev_info->dev_capa);
> @@ -42,10 +38,6 @@ RTE_TRACE_POINT(
>  	rte_dma_trace_configure,
>  	RTE_TRACE_POINT_ARGS(int16_t dev_id, const struct rte_dma_conf
> *dev_conf,
>  			     int ret),
> -#ifdef _RTE_TRACE_POINT_REGISTER_H_
> -	const struct rte_dma_conf __dev_conf =3D {0};
> -	dev_conf =3D &__dev_conf;
> -#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
>  	rte_trace_point_emit_i16(dev_id);
>  	rte_trace_point_emit_u16(dev_conf->nb_vchans);
>  	rte_trace_point_emit_u16(dev_conf->priority);
> @@ -78,10 +70,6 @@ RTE_TRACE_POINT(
>  	rte_dma_trace_vchan_setup,
>  	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
>  			     const struct rte_dma_vchan_conf *conf, int ret), -
> #ifdef _RTE_TRACE_POINT_REGISTER_H_
> -	const struct rte_dma_vchan_conf __conf =3D {0};
> -	conf =3D &__conf;
> -#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
>  	rte_trace_point_emit_i16(dev_id);
>  	rte_trace_point_emit_u16(vchan);
>  	rte_trace_point_emit_int(conf->direction);
> diff --git a/lib/dmadev/rte_dmadev_trace_fp.h
> b/lib/dmadev/rte_dmadev_trace_fp.h
> index f2656c6726..a1374e78b7 100644
> --- a/lib/dmadev/rte_dmadev_trace_fp.h
> +++ b/lib/dmadev/rte_dmadev_trace_fp.h
> @@ -33,10 +33,6 @@ RTE_TRACE_POINT_FP(
>  	rte_dma_trace_vchan_status,
>  	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
>  			     enum rte_dma_vchan_status *status, int ret), -
> #ifdef _RTE_TRACE_POINT_REGISTER_H_
> -	enum rte_dma_vchan_status __status =3D 0;
> -	status =3D &__status;
> -#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
>  	rte_trace_point_emit_i16(dev_id);
>  	rte_trace_point_emit_u16(vchan);
>  	rte_trace_point_emit_int_ptr(status);
> @@ -100,12 +96,6 @@ RTE_TRACE_POINT_FP(
>  	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
>  			     const uint16_t nb_cpls, uint16_t *last_idx,
>  			     bool *has_error, uint16_t ret), -#ifdef
> _RTE_TRACE_POINT_REGISTER_H_
> -	uint16_t __last_idx =3D 0;
> -	bool __has_error =3D false;
> -	last_idx =3D &__last_idx;
> -	has_error =3D &__has_error;
> -#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
>  	rte_trace_point_emit_i16(dev_id);
>  	rte_trace_point_emit_u16(vchan);
>  	rte_trace_point_emit_u16(nb_cpls);
> @@ -119,10 +109,6 @@ RTE_TRACE_POINT_FP(
>  	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan,
>  			     const uint16_t nb_cpls, uint16_t *last_idx,
>  			     enum rte_dma_status_code *status, uint16_t ret), -
> #ifdef _RTE_TRACE_POINT_REGISTER_H_
> -	uint16_t __last_idx =3D 0;
> -	last_idx =3D &__last_idx;
> -#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
>  	rte_trace_point_emit_i16(dev_id);
>  	rte_trace_point_emit_u16(vchan);
>  	rte_trace_point_emit_u16(nb_cpls);
> diff --git a/lib/eal/include/rte_trace_point.h
> b/lib/eal/include/rte_trace_point.h
> index 84de233d59..8a317d31d2 100644
> --- a/lib/eal/include/rte_trace_point.h
> +++ b/lib/eal/include/rte_trace_point.h
> @@ -36,6 +36,8 @@ extern "C" {
>  /** The tracepoint object. */
>  typedef RTE_ATOMIC(uint64_t) rte_trace_point_t;
>=20
> +#ifndef _RTE_TRACE_POINT_REGISTER_H_
> +
>  /**
>   * Macro to define the tracepoint arguments in RTE_TRACE_POINT macro.
>=20
> @@ -53,6 +55,8 @@ _tp _args \
>  	__VA_ARGS__ \
>  }
>=20
> +#endif /* _RTE_TRACE_POINT_REGISTER_H_ */
> +
>  /**
>   * Create a tracepoint.
>   *
> diff --git a/lib/eal/include/rte_trace_point_register.h
> b/lib/eal/include/rte_trace_point_register.h
> index ac391eb28f..b036121959 100644
> --- a/lib/eal/include/rte_trace_point_register.h
> +++ b/lib/eal/include/rte_trace_point_register.h
> @@ -18,6 +18,43 @@ extern "C" {
>=20
>  RTE_DECLARE_PER_LCORE(volatile int, trace_point_sz);
>=20
> +#define
> RTE_TRACE_POINT_ARGS_COUNT_(_0,_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_1
> 2,_13,_14,_15,N, ...) \
> +	N
> +#define RTE_TRACE_POINT_ARGS_COUNT(...) \
> +
> +RTE_TRACE_POINT_ARGS_COUNT_(__VA_ARGS__,15,14,13,12,11,10,9,8,7,6,
> 5,4,3
> +,2,1,0)
> +
> +#define RTE_TRACE_POINT_ARGS_1(a) __rte_unused a #define
> +RTE_TRACE_POINT_ARGS_2(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_1(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_3(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_2(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_4(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_3(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_5(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_4(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_6(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_5(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_7(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_6(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_8(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_7(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_9(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_8(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_10(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_9(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_11(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_10(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_12(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_11(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_13(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_12(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_14(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_13(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_15(a, ...) __rte_unused a,
> +RTE_TRACE_POINT_ARGS_14(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS_FUNC(a) RTE_TRACE_POINT_ARGS_ ## a
> #define
> +RTE_TRACE_POINT_ARGS_EXPAND(...) __VA_ARGS__ #define
> +RTE_TRACE_POINT_ARGS_(N, ...) \
> +
> 	RTE_TRACE_POINT_ARGS_EXPAND(RTE_TRACE_POINT_ARGS_FUNC(
> N))(__VA_ARGS__)
> +#define RTE_TRACE_POINT_ARGS(...) \
> +	(RTE_TRACE_POINT_ARGS_(RTE_TRACE_POINT_ARGS_COUNT(0,
> __VA_ARGS__),
> +__VA_ARGS__))
> +
> +#define __RTE_TRACE_POINT(_mode, _tp, _args, ...) \ extern
> +rte_trace_point_t __##_tp; \ static __rte_always_inline void _tp _args
> +{ } \ static __rte_always_inline void \ _tp ## _register (void) \ { \
> +	__rte_trace_point_emit_header_##_mode(&__##_tp); \
> +	__VA_ARGS__ \
> +}
> +
>  #define RTE_TRACE_POINT_REGISTER(trace, name) \  rte_trace_point_t
> __rte_section("__rte_trace_point") __##trace; \  static const char
> __##trace##_name[] =3D RTE_STR(name); \ @@ -26,7 +63,7 @@
> RTE_INIT(trace##_init) \
>  	if (!rte_trace_feature_is_enabled()) \
>  		return; \
>  	__rte_trace_point_register(&__##trace, __##trace##_name, \
> -		(void (*)(void)) trace); \
> +		trace ## _register); \
>  }
>=20
>  #define __rte_trace_point_emit_header_generic(t) \ @@ -37,22 +74,17 @@
> RTE_INIT(trace##_init) \
>=20
>  #define __rte_trace_point_emit(name, in, type) \  do { \
> -	RTE_BUILD_BUG_ON(sizeof(type) !=3D sizeof(typeof(*in))); \
>  	__rte_trace_point_emit_field(sizeof(type), name, RTE_STR(type)); \  }
> while (0)
>=20
>  #define rte_trace_point_emit_string(in) \  do { \
> -	RTE_SET_USED(in); \
>=20
> 	__rte_trace_point_emit_field(__RTE_TRACE_EMIT_STRING_LEN_MAX
> , \
>  		RTE_STR(in)"[32]", "string_bounded_t"); \  } while (0)
>=20
>  #define rte_trace_point_emit_blob(in, len) \  do { \
> -	uint8_t size =3D len; \
> -	RTE_SET_USED(in); \
> -	RTE_SET_USED(size); \
>  	__rte_trace_point_emit_field(sizeof(uint8_t), \
>  		RTE_STR(in) "_size", \
>  		RTE_STR(uint8_t)); \
> --
> 2.48.1
Acked-by: Sunil Kumar Kori <skori@marvell.com>
