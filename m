Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91821CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 16:00:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F794402D0;
	Fri, 19 Sep 2025 18:00:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id B1D944028E
 for <dev@dpdk.org>; Fri, 19 Sep 2025 18:00:16 +0200 (CEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JFNKV1018036;
 Fri, 19 Sep 2025 16:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=g0n+C2N/g2C/M41gixGdnCIa
 Jc16n48GJSaoAG3irgY=; b=TgJ0UhrihkzWtbFVrHSf2QJtg03zf/2Rs8m/f/Ok
 3sNbNT5oPJJBEMlJfSpsEzEydOmLh8tu6zyNZ2S8ByJbc/4xOsP3v+P1osFd8Hu1
 /CsqOzdBs1xuqcpfjs8XPMMWwa/laG2CDaD/Ftlg11jAgJrxYJSETvFZ6NgNKIBA
 zLFsht/ipyqM12ie2SUQuAgVuyRGn3nuaVtHUQ2Nvt76/PxVAz/udgX7MwDgs9XU
 yOlEReg0rH+VzRL/2cI14pkKwdSSuxFmDiRQPQ5m2dzSEembNk+H3RyjBvMkdECc
 yuWKCiXlFs5PzmxHzQ4gPYgG3hJuLMmXuUMhypGWy1KJZg==
Received: from dm2pr04cu003.outbound.protection.outlook.com
 (mail-dm2pr04cu00307.outbound.protection.outlook.com [40.93.13.63])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982defjdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 16:00:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjLxLI7ZUEi27Ps0vfxKRww7JoNGT/7Bcb8vSfXTehTaI/eAuM5AUcrknZdr8saAirSaZ4oAUKKkjCrt5MB7zPzwsy+ub47ZxhuROq/D4q5yfdfUjFWIsWqssR7rFR1o4qG8vQCpu3GNxclPibnlPOXtTZhn3a5yzb1+Z2G+N1lS0y6B7qjprIwWjnArmc0YfvHgh+GjzYkH4uSSHOyirEgTGc4WjeklrrgnKmET7tXAOo0CA0vUdt/6YKYN4I4zMdksrwSaL2bbqJso4YBFkaRWqHvGSFfNc7aHEexGjoO6sOYNk7RedNooSGWLv5Tcj70nAKxS3UCrNVLtOAYHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0n+C2N/g2C/M41gixGdnCIaJc16n48GJSaoAG3irgY=;
 b=oyPySIdBKBzTQ91wjbr+X2mCgITUTN2LyB20qGRwSHzYIWx9NJOMdvV+GFkFBESkx1nsCXBcUppc8rDi0ym20d77Mpd3SUFnSWNnfWWPGGibyNwEY9/ZWRdLx9L3T8yfBhBX7C/0hR7+41FKWVVuOpAN1WQSDyqMRg0L8d4o88tEFxqzEVW8MnRbWJO+SpwBI3sZ5F9280ner/7r53T+FCMCDRJ+p0nBY8M3vc5StmkKC3B3xOfSsCryUisoP5hyzGrUuNoqSW6Gafx37mNpRBinZwtNGeccnI/jZpE2vOkomitdaVpeQdjT3W982dQLPHTV8nYq/WoI2X13Z4FaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by BN0PR02MB8159.namprd02.prod.outlook.com (2603:10b6:408:164::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 16:00:08 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb%4]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 16:00:08 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Akhil Goyal <gakhil@marvell.com>, Sunila Sahu <ssahu@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Topic: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Index: AQHb0L137i4Jy3qVq0eP0deo4bMumbPrrOgAgAeQrQCAFMAQgICSI2YngACEeoCAALNxVw==
Date: Fri, 19 Sep 2025 16:00:08 +0000
Message-ID: <SJ2PR02MB97954EB015631E1817D6E3628911A@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
 <20250604164134.776009-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484330DB3461425B5FD4AA7D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB9795F48C88D139220AF7B80A8916A@SJ2PR02MB9795.namprd02.prod.outlook.com>
 <CO6PR18MB4484973EF4D64751A206D8BED811A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484973EF4D64751A206D8BED811A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|BN0PR02MB8159:EE_
x-ms-office365-filtering-correlation-id: 8edea257-1818-45f6-4da7-08ddf7959b73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021|13003099007|8096899003;
x-microsoft-antispam-message-info: =?Windows-1252?Q?YfPFIn8S9exVJKiyINrVqyr609P7wDC8CkbMXWqt8PQL1CvVnmQZ7KDI?=
 =?Windows-1252?Q?IhG/QhyeokOzVQINyytLIKlopG+1TbPOy3FZEDOX/6btkuThTb9qSN2R?=
 =?Windows-1252?Q?lf9d/eCVbxyzOGnmUk/wp5uGxzPy6IIaTs7XoDqPBUmA22oFJkH9Tush?=
 =?Windows-1252?Q?I3AtsnbtHu5hXkMYLJQnwfkgMolupmlUa+sO75KWsvXaxiwCqIDsS9Iu?=
 =?Windows-1252?Q?Zi4epsBFvGwv/oCq70C7Ctk2UINkeB6ZyslsZsEk1KQeaTUbET/F8lDZ?=
 =?Windows-1252?Q?O/p+a3QOJpkadryd52qhG4wPuk3bWFQHlxPffBtSOulnjvnVdNZLs6kH?=
 =?Windows-1252?Q?JaCItT4b+RA6glT4vZZycxI+Bgnf/Hc3QeTecu/+fXJRkCSu/LIzC8vO?=
 =?Windows-1252?Q?IW834hxTvICUyhq/2/4kclt7UqsfeChVnA9HzqVthfSG8b1OOi1UzTjU?=
 =?Windows-1252?Q?Hld56jGw0q7j6tyhURuMihCOq9auoFgLpYdvOJOUdBKCbw3ROlC22QxX?=
 =?Windows-1252?Q?HqylZWTML9FzNPaAmeu2BsPpy88ME2n9Jp9XQGbnEM0EzVOcQSfVihg9?=
 =?Windows-1252?Q?9JVtxtSl+fRu+keaN5RuaThDBZkVqA4DgpJaeoq94nQqduLaD3Vp0uPQ?=
 =?Windows-1252?Q?+1ssC76jvlxyd+HqC6ElUfjkejoxxaFeGEdU7oEODcPQ9bF3adAw0tiT?=
 =?Windows-1252?Q?EE3SHKuKAIIpT7HXI/jp1n9q/BbeF6imEm32ole7ZiXNYMYWZX9dhKK3?=
 =?Windows-1252?Q?MKAhF6rORFY/v5s9nCylvQT8k73/0iwEXw8Wml7OmffCKyXHob2a1BiW?=
 =?Windows-1252?Q?2YeR1WBztTLcx0lyMdXXmrcpNaGIkVo2meQ80GaCOyitoZyRXnO6kLph?=
 =?Windows-1252?Q?DLCjB50eVkC5cEs3Jrt2rsTa6Q+LKGw0oqHwVzCEaSXADb6h/rJH9TmC?=
 =?Windows-1252?Q?33/J3eOo2U8FZW6Ls13CdqKhiKm1qcLTFd92uAPMPgekXJicrHNV6PND?=
 =?Windows-1252?Q?AjZy94LM2j8paKoL/ujcNXdOcEf1zWkSgmFrvlir0JDb1x280YmQyFZV?=
 =?Windows-1252?Q?cZzy7DrSpG2JHk170MEenoUMs9wBad5+8ZWb6A7u//NzTVJ1TsO8TvOZ?=
 =?Windows-1252?Q?39JDi+1xZBn2vdDN2Y7MYldQEbjKDGZVVLvaKBhaqmVPEPXRFWW5h7c3?=
 =?Windows-1252?Q?6quoG5FeFI3xizx2fHejeYmHOXZ1Wt+hwPMrFmXW8+8wcae897IfSy1u?=
 =?Windows-1252?Q?IAvZLxMKdihA5flQ0x44TsEan5NpRhnl2Fi/hrkgcFpCb3jJZDfKYLQ9?=
 =?Windows-1252?Q?XtlPAHz1H0dOvVWLEEkHAgNpl3LmELWk4SEHrocNHasFTrWTgIRfO+VM?=
 =?Windows-1252?Q?jofjjO1cKLaxTrUTGoAIwvUfn49JiJ/dwDPr+rwBM8oAvRL/uRJ+FsSq?=
 =?Windows-1252?Q?Eo/H3asjiPY7+6rlx/2zuzf3BpIIHaxpIr0ko0RJdBhmZoclhx8JzjgG?=
 =?Windows-1252?Q?LB/i/Epy9x+NK3h4H6wzNpAcoAwoWZqx7MOGGIxkUDHwpk4uKuc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?3MlZiY6N2PRaWOxYRpDmR+AlAKtcK2o4Zagv50TFmmj8/A/snpuIN6Qf?=
 =?Windows-1252?Q?/VSKeQw1ffaMGsTspdKYD0h1j9BQBAsJ0vbo3nLDKqx1NCUTl2krQO9R?=
 =?Windows-1252?Q?FuMjyV9oglH83PSI5YhRaM2DUXqPbIuPGRYPanr//F5JLMDKhYLh5WHy?=
 =?Windows-1252?Q?Pvtes57zl6xrXTmQLiMiMuyO6CfsrWxww5WLeRzSLth6rZrCgzW7Hk4l?=
 =?Windows-1252?Q?Ga5vGmGYm9DfDlYeKg0C+sHaoAYMLDm3ObaN3uqQl/ynvIMRtVLs1aoa?=
 =?Windows-1252?Q?253875gSwZk0piW4+9GT+nHmd/1N31HqLHny3A4dTuRBxIgbMQFhK+sd?=
 =?Windows-1252?Q?tFjef8FYdEbfN1ZmH/ziKA0gVvzuNktgozUStBvYvtrpVVSiyvJ4ZeRO?=
 =?Windows-1252?Q?7Zt4QIslFFMsPymGnmHLeXQOR1FHR9Fbi/kJi8eELMY/LfbYg9vBVKHj?=
 =?Windows-1252?Q?YXFTJmMFlSTFG/A6n04iPdeAlgQUApistJm5CtKCiscC+T4RCpOzbLES?=
 =?Windows-1252?Q?Isww3fLE4Mz/lZn61rP0nTrle/yJf0VcVHqLGcWdAWb/e6P6xq8QyJLB?=
 =?Windows-1252?Q?+tHxLmgWr6WDgb1zzIkZIyN4T58SSKJr/nVCVXTir8bWVxmE7zTCyzfE?=
 =?Windows-1252?Q?5AOsItTIXdwoei59CaQge876bV0zkGVFkJgR1LqgR9vJ45Hau5+ipubv?=
 =?Windows-1252?Q?R5MmKF3hyV8fVzjaQaxBKTEkUsMULVdr44R5lClDVoWNx0tuETaZ2AoJ?=
 =?Windows-1252?Q?S4yT8p0k8Vxy3c+jqE+C7jWgrFwow9pamTblcE+65+kT3RGwkKfsKsTt?=
 =?Windows-1252?Q?jcysBe4bZOLtte/Ar7pd9mK4hrm0mIH9SPtYWwPCPnzVu93fo6+rEYN2?=
 =?Windows-1252?Q?N3gMP/b6yRK1xm2eVqteaVpx05BM9APtsHjOpZXAxS2RyIlZVN57QBTn?=
 =?Windows-1252?Q?vnTVpHwBzGnd9dUptl+rZqHr7Oeq8ZKzVNFjW+TWD+LG/rgomi99uu56?=
 =?Windows-1252?Q?CH407NEU6st/TfgR47TIPKvylb7LcY7dbC/J/kzTxTenGFJ4R2FnLDjP?=
 =?Windows-1252?Q?uYRzzIBXvfMqX9a+8xK61LVQL9XR6bo6jBwlyUGbNKUjpsKeO7dA7W1D?=
 =?Windows-1252?Q?hCyDrL3XXEgqQrFopTvRK9JtVdeDQAIPlzBFhmj9SfbJalh3Ixl15IgI?=
 =?Windows-1252?Q?+mr0vJG3GB5VdYLzrmJkBHGysFUiw6l34MOzyPxkZaZT7ToP7zP+AkDn?=
 =?Windows-1252?Q?5IXH6DsnI5AhtMvlQSczGmuo7IpLz9ewXaY/QRuQheDy5H/hlG3S+m8j?=
 =?Windows-1252?Q?HBggGCA44x27wcKRTyOlqRJzpYf/TjGqky4T6Fy3lXy2Y69Rxo/i6Y97?=
 =?Windows-1252?Q?Nsl5mpqDhGY5nNzFDdOxGdPrfQZmWNRADfxz5AcmT55k4o9nyC+9oViV?=
 =?Windows-1252?Q?R+UAyOn16SSaiUakO/ShX3SML3Z6WAWfTq6FlhSZPVl0UK8GJ0jQX+IX?=
 =?Windows-1252?Q?VdP6NUPO5bb1OTUdJZBKkDcEslwKwM0wRJ/8ukWcnhJTXaLyrvOq7V8P?=
 =?Windows-1252?Q?MbfytNo23xIhSJ2D4jwjcmIHWGa3E/DFg8T4w7Zd7lfUqCN/yZC7d6Bd?=
 =?Windows-1252?Q?INLAYLjVqh09qsYH/lFBn9pTVb0dL3+IpvHuekX9Bxf02axDeknE0e2B?=
 =?Windows-1252?Q?KwQv+sb8GVoiPklN8qoTO/CfEpoq+tuV?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB97954EB015631E1817D6E3628911ASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xhBZbmRr9sHqz63vbIVmL+ViZ1qTy5KxyURJoR3itAVS6Xk4HlhXbdJs3UzTM9uWHiaXm839+KxWHYGmu0qn5l+39E4W2VY+Fx3ymk3me6ZiCvWT+Db/qceetn6/asn5YDSJN9/tOYuD4JpLPbFoi5PrKzk15XMZf72XQoMYNmkVV1WKJZuNee7CsFSX0lIHGtmu9OcYXXZ8BsMRkWNY1Lmm3AgypLG+CTOiJmqGO3iUKqF+TxcsJJnjyKWMdhyUCl03a+V5bh37HXZIhfQ1J4azKlreq5Q46FnN/I27gL1qfw4Ve9Esj2k4jYMcyFHPsPBJOK2ZKFrHnllY7r2TrgWk5S/GV//IiUgiQme9W7NRgU0W+Dd3TF3RDwDO2zLyWJC6CdUYTpZmnCyo+Sd8z4cgeZ7oHZ6nR3m+s6EVYBuP8drXgc1gvb89e9jTg+xBQFv+1QMSIPKU/BRGYx14MWJqkL89+sDiBDZXQIPi3tPm5m7osWkDrBmlUGmGFLLanS/sGZzm4sXgvI4aesCJoe2EFANJSLfzIUsTRVR6HtG0xQ2Bx8QkkX9z8upotU+4tWh7ZRaZitAGT4cRxoE2uzIVWGvuvF64EoOL3dHA8mUJuyV0kCqD8HqQxTkMr/75
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edea257-1818-45f6-4da7-08ddf7959b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 16:00:08.6097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/zwD2TfvFEUmYUDuZz1k/h/5xCBeXI9RZknmDG+j2Y7sV8Iw22Tv/eWmqYtz9hfeRzcyBRkudsHP4YdMn6YSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8159
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cd7e0f cx=c_pps
 a=uQIke+rNJ6n3KdoOHeeDKA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=17fqAxLdwc6iPGJxzboA:9 a=pILNOxqGKmIA:10 a=k13SdgfryrkA:10
 a=SIgY3DbvdLb7SMquqkUA:9 a=qQMCJL_FXYMnxAAu:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: UAKraKBx00XVIZvVZ3ix0xUCUNPQtfAG
X-Proofpoint-ORIG-GUID: UAKraKBx00XVIZvVZ3ix0xUCUNPQtfAG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX2PHG9j33k80d
 uIijw5uHQjTuSAFeUIaopJnJv079Cd3KrMENneWa792O6k3mq/5T8XLNErAmh+PUZB6kOnOODeC
 zPd0++Hafk7KGgMqr45YPktR2Te8NujW9bqjF8dbVHazz8Jn9q5YruD7I4GsgrwF/4mnHd4/0wf
 R3lZ69s0kkJB/aylZo/gWg7RVRKdFtf678cmaYwaTQVmm4Opa6FU63e2Csr1zsYgTEyNkVcBz4F
 ZaoXOvpF4fLLUNhTht0POFbGJXQvUHADlZl7v0dFvWve1DUIijep33yFKYP+3h3tVAW66iRUr5t
 vv3V8y2a8hSe/jVR0PcnRbwLaCWy1GYX8TKgqQK60iiR88jXoCYUXuJ/ONbEaytiMQz7/xYYRZx
 4Pwa3Y9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182
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

--_000_SJ2PR02MB97954EB015631E1817D6E3628911ASJ2PR02MB9795namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I don't see anything specific about creating and pushing a series : 9. Cont=
ributing Code to DPDK =97 Data Plane Development Kit 25.07.0 documentation<=
https://doc.dpdk.org/guides/contributing/patches.html>.

The only mention to a series above seems to use the depends-on tag.

Thanks
Sameer Vaze
________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: Thursday, September 18, 2025 11:08 PM
To: Sameer Vaze <svaze@qti.qualcomm.com>; Sunila Sahu <ssahu@marvell.com>; =
Fan Zhang <fanzhang.oss@gmail.com>; Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hi Sameer,
> Hey Akhil,
>
> I attempted to split the changes into multiple patches and added a depend=
s-on
> the second patch. But automation does not seem to be picking up the patch=
 as a
> dependency. Is there a process step I messed up:

When you have dependent patches, you should send them as a series.
Automation runs on the last patch in the series only.
Currently it is not handling depends-on tag. It is for reviewers for now.


>
>
> Patch 1: compress/zlib: support for dictionary and PDCP checksum - Patchw=
ork
> <https://patches.dpdk.org/project/dpdk/patch/20250918204411.1701035-1-sva=
ze@qti.qualcomm.com/>
> Patch 2 with depends-n: app/compress-perf: support dictionary files - Pat=
chwork
> <https://patches.dpdk.org/project/dpdk/patch/20250918210806.1709958-1-sva=
ze@qti.qualcomm.com/>
>
> Thanks
> Sameer Vaze
> ________________________________
>
> From: Akhil Goyal <gakhil@marvell.com>
> Sent: Tuesday, June 17, 2025 3:34 PM
> To: Sameer Vaze <svaze@qti.qualcomm.com>; Sunila Sahu
> <ssahu@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; Ashish Gupta
> <ashishg@marvell.com>
> Cc: dev@dpdk.org <dev@dpdk.org>
> Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary fil=
es
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>
> > compress/zlib: support PDCP checksum
> >
> > compress/zlib: support zlib dictionary
> >
> > compressdev: add PDCP checksum
> >
> > compressdev: support zlib dictionary
> >
> > Adds support to provide predefined dictionaries to zlib. Handles settin=
g
> > and getting of dictionaries using zlib apis. Also includes support to
> > read dictionary files
> >
> > Adds support for passing in and validationg 3GPP PDCP spec defined
> > checksums as defined under the Uplink Data Compression(UDC) feature.
> > Changes also include functions that do inflate or deflate specific
> > checksum operations.
> >
> > Introduces new members to compression api structures to allow setting
> > predefined dictionaries
> >
> > Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
>
> Seems like multiple patches are squashed into a single patch
>
> I see that this patch has ABI breaks.
> We need to defer this patch for next ABI break release.
> Please split the patch appropriately.
> First patch should define the library changes.
> And subsequently logically broken PMD patches
> Followed by application patches.
> Ensure each patch is compilable.
>
> Since this patch is breaking ABI/API,
> Please send a deprecation notice to be merged in this release and
> Implementation for next release.
>
> Also avoid unnecessary and irrelevant code changes.
>


--_000_SJ2PR02MB97954EB015631E1817D6E3628911ASJ2PR02MB9795namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I don't see anything specific about creating and pushing a series : <a clas=
s=3D"OWAAutoLink elementToProof" id=3D"LPlnkOWA61516d4a-7fbf-f91a-c39d-791c=
b61e936c" href=3D"https://doc.dpdk.org/guides/contributing/patches.html">
9. Contributing Code to DPDK =97 Data Plane Development Kit 25.07.0 documen=
tation</a>.&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
The only mention to a series above seems to use the depends-on tag.</div>
<div id=3D"Signature">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Akhil Goyal &lt;gakhi=
l@marvell.com&gt;<br>
<b>Sent:</b> Thursday, September 18, 2025 11:08 PM<br>
<b>To:</b> Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;; Sunila Sahu &lt;ssah=
u@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;; Ashish Gupta &=
lt;ashishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionar=
y files</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARNING: This email originated from outside of Qua=
lcomm. Please be wary of any links or attachments, and do not enable macros=
.<br>
<br>
Hi Sameer,<br>
&gt; Hey Akhil,<br>
&gt;<br>
&gt; I attempted to split the changes into multiple patches and added a dep=
ends-on<br>
&gt; the second patch. But automation does not seem to be picking up the pa=
tch as a<br>
&gt; dependency. Is there a process step I messed up:<br>
<br>
When you have dependent patches, you should send them as a series.<br>
Automation runs on the last patch in the series only.<br>
Currently it is not handling depends-on tag. It is for reviewers for now.<b=
r>
<br>
<br>
&gt;<br>
&gt;<br>
&gt; Patch 1: compress/zlib: support for dictionary and PDCP checksum - Pat=
chwork<br>
&gt; &lt;<a href=3D"https://patches.dpdk.org/project/dpdk/patch/20250918204=
411.1701035-1-svaze@qti.qualcomm.com/">https://patches.dpdk.org/project/dpd=
k/patch/20250918204411.1701035-1-svaze@qti.qualcomm.com/</a>&gt;<br>
&gt; Patch 2 with depends-n: app/compress-perf: support dictionary files - =
Patchwork<br>
&gt; &lt;<a href=3D"https://patches.dpdk.org/project/dpdk/patch/20250918210=
806.1709958-1-svaze@qti.qualcomm.com/">https://patches.dpdk.org/project/dpd=
k/patch/20250918210806.1709958-1-svaze@qti.qualcomm.com/</a>&gt;<br>
&gt;<br>
&gt; Thanks<br>
&gt; Sameer Vaze<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Akhil Goyal &lt;gakhil@marvell.com&gt;<br>
&gt; Sent: Tuesday, June 17, 2025 3:34 PM<br>
&gt; To: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;; Sunila Sahu<br>
&gt; &lt;ssahu@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;; A=
shish Gupta<br>
&gt; &lt;ashishg@marvell.com&gt;<br>
&gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
&gt; Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary =
files<br>
&gt;<br>
&gt; WARNING: This email originated from outside of Qualcomm. Please be war=
y of<br>
&gt; any links or attachments, and do not enable macros.<br>
&gt;<br>
&gt; &gt; compress/zlib: support PDCP checksum<br>
&gt; &gt;<br>
&gt; &gt; compress/zlib: support zlib dictionary<br>
&gt; &gt;<br>
&gt; &gt; compressdev: add PDCP checksum<br>
&gt; &gt;<br>
&gt; &gt; compressdev: support zlib dictionary<br>
&gt; &gt;<br>
&gt; &gt; Adds support to provide predefined dictionaries to zlib. Handles =
setting<br>
&gt; &gt; and getting of dictionaries using zlib apis. Also includes suppor=
t to<br>
&gt; &gt; read dictionary files<br>
&gt; &gt;<br>
&gt; &gt; Adds support for passing in and validationg 3GPP PDCP spec define=
d<br>
&gt; &gt; checksums as defined under the Uplink Data Compression(UDC) featu=
re.<br>
&gt; &gt; Changes also include functions that do inflate or deflate specifi=
c<br>
&gt; &gt; checksum operations.<br>
&gt; &gt;<br>
&gt; &gt; Introduces new members to compression api structures to allow set=
ting<br>
&gt; &gt; predefined dictionaries<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;<br>
&gt;<br>
&gt; Seems like multiple patches are squashed into a single patch<br>
&gt;<br>
&gt; I see that this patch has ABI breaks.<br>
&gt; We need to defer this patch for next ABI break release.<br>
&gt; Please split the patch appropriately.<br>
&gt; First patch should define the library changes.<br>
&gt; And subsequently logically broken PMD patches<br>
&gt; Followed by application patches.<br>
&gt; Ensure each patch is compilable.<br>
&gt;<br>
&gt; Since this patch is breaking ABI/API,<br>
&gt; Please send a deprecation notice to be merged in this release and<br>
&gt; Implementation for next release.<br>
&gt;<br>
&gt; Also avoid unnecessary and irrelevant code changes.<br>
&gt;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR02MB97954EB015631E1817D6E3628911ASJ2PR02MB9795namp_--
