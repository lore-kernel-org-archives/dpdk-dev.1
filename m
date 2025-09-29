Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C1CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 17:34:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7479440670;
	Mon, 29 Sep 2025 19:34:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 9E9424066C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 19:34:17 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TATxqx018280;
 Mon, 29 Sep 2025 17:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=oMiaSxI2rGqsnYabenTw8w4w
 2b6xc6S9NSgIHu/0kEY=; b=n/pWsN6WuO8Ld4ubOScm/SfGC3h3jD6m5ZpFMXmL
 YNgoreWlLv9VLskR+SJqYOOVLO2Fdx4cbHOchsr8MPQYMAuM2+eFjKxstQ+gh/OV
 yRYkmn/HAVWSLvKnT+roeo/EoDZOoYmt9jRHffhkq58RKjSuJpqjVcuhScNm/luM
 KwSkxRURaCBbH68HUA/hc7O7eNC3o3N3WWigr1lY8n4EOL68aT8sZt52bB6iUKV5
 WblUkcoUL1A5D4QKmOh//qLp5/TA/osb1QN6Q/BkyU4Z+6XyAAgBoVOjjRYnlhGj
 2TX3F4R8Ak297CJ0bOupwL+IFAYXmc7/besbBD5L/NlNKg==
Received: from dm2pr04cu003.outbound.protection.outlook.com
 (mail-dm2pr04cu00300.outbound.protection.outlook.com [40.93.13.56])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59mxh7a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 17:34:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+wdCs1hChGDbl/b11X0EuBSbUm4Sh3IASEdKNzP0tUIiZvhPE+6G9GbrRYhmNfru2hXQAdvc+a+sw+5F0EeUuO275woZB0Oi01376aQWzFXFngqQ8GoUS/wm6Xd+b+exFK7GlVd8W4Xn7okzMWU2LraR3fWSral51TkLQgeraqfKIQT3fObj4h4jSQC0l517ASaoRgK9iXrna8STy11eqgrftVmMFoBcnIKQEj80QPNQXDVnp/xdiV+G7SQGgrpNorWRhPkmRglFk0SDNNwN3tvxVFKrnrqbVq1qpCZywGa2al4WLQuH8vpvZqr1Dj3U4xQig3U+yo2YKF+wlyOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMiaSxI2rGqsnYabenTw8w4w2b6xc6S9NSgIHu/0kEY=;
 b=NrZkGyKHjHba+pqEwQ/RxOHbR7D0PMQn1FgLmoU1Yy2Q87opYL236FzkoHbr1t81+5UxtLvGABIciXvKOpwQE/eVSqZtSsKhyPyNo+wH1yFBWdMSZTSaYM8LuB1kV6KmW/NSKpcF4xXUgEZPei7KyN4+b+P70aypt+CtKE9oW/mAHKJyKpyqMpF0tMMuyZSCpDe9UDeDSegVRjsHmMR6taWFT+TW75ckHMMjhZqbF8+IxSNuczBwUBcON/0tIjpgPwdw7WO28/RihSs3lQ5BROhDrp9zzdXLGGt30YStsSxYtXlRJvuPq60eDkjocMq93CSd5GxzfLiNSzEh/L6+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 (2603:10b6:208:509::11) by DS0PR02MB9298.namprd02.prod.outlook.com
 (2603:10b6:8:150::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 29 Sep
 2025 17:34:05 +0000
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::cd70:509e:2d07:38ce]) by IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::cd70:509e:2d07:38ce%3]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 17:34:05 +0000
From: Dylan Schneider <schneide@qti.qualcomm.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Thread-Topic: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Thread-Index: AQHcF6J26lHMqqBU8EmRqu1W+Sdf5LSkwxKAgAIv3YCAA6w7DA==
Date: Mon, 29 Sep 2025 17:34:05 +0000
Message-ID: <IA3PR02MB107715904EC92CDED61931E37E91BA@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250827153852.1066521-1-schneide@qti.qualcomm.com>
 <20250827223216.1337749-1-schneide@qti.qualcomm.com>
 <20250925170447.2ae8d5bf@hermes.local> <3296173.BjyWNHgNrj@thomas>
In-Reply-To: <3296173.BjyWNHgNrj@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB10771:EE_|DS0PR02MB9298:EE_
x-ms-office365-filtering-correlation-id: bb2db7a7-ea25-49e0-f405-08ddff7e6359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Sg1rEKH1IKzzX99d9wC0Vx11eJEZaiHKy3Yzf8mmZAmw32M/UcG29xtkvla5?=
 =?us-ascii?Q?51N5/kfNpvoiEaYG+RkoU0/4mWnjiaM+lhPBYBVIfMTIOYwWyBIRtcBLRFNu?=
 =?us-ascii?Q?mEBPzKJXZzHDGBpHszh9uWimc2c5M99saQxaFFWpPuRg9qg2sEDNxbKeQbUj?=
 =?us-ascii?Q?X5KH7R6PXIJeIQZzSku1LOewsUB8GEAruRUm0+tCpW5V1fp+j83FYNIPed9Z?=
 =?us-ascii?Q?V70jHA7uWrIKspCXAqxjFYVBQ4lBXAN7w9foh9xyxxGtNnMY3XzF0TnFqDr3?=
 =?us-ascii?Q?aYM7EpTR0ZyI1BEWvXWOmpbihW+83hze5hiI3DyGioG5iPc0nN5+5d4hA2J6?=
 =?us-ascii?Q?VwPGYCcOkKQYyf2R0hHFxkHzJH9bmvHIzazavNZSBGJhouPcOxI/KmxV900E?=
 =?us-ascii?Q?GbWyilbPnA21/YoqLxaxiUD0o1r8t+3gVrfD5GC804brU3PNZDi0MbvDm2F1?=
 =?us-ascii?Q?nOvBLzR/Hjk1Ftgpn487ePtYbQS22TcjTm0DGsJL0GCXFjVULwx58/IbHs9T?=
 =?us-ascii?Q?J5TEHme7VcVr39xzv4gNPvfQjs60PMwIjJz0p+MJSJh6GMzztTfIlCw5Vm1W?=
 =?us-ascii?Q?jgCWyqhHtxX8uf5zHNvcF0y0VrMfGVkX8Kncd/Wt10nDhcpxewyAfOEsqzzx?=
 =?us-ascii?Q?CiF0uydHDmGcBkpoREvU837ESOAONSv9qaFdEeAL66bByR8I/1Z7Xvn1V6PB?=
 =?us-ascii?Q?AcW/bhc+0Q/bUQ4sRiI/vf38CHR+mfVdIauyDa8tpXdpmsYP6nn97LMDq5ai?=
 =?us-ascii?Q?FHa7fYbs6VLse1ZPXtqcEus9cTbX80g8WdRK5BLy9bDs/cTwaJIi+SNgODrJ?=
 =?us-ascii?Q?glnJ5G7e0K7oQSpkaDAofuNqUoq7e2+hqvx54ZVxtP9NHaVv5uskxKCvDtLT?=
 =?us-ascii?Q?cGl7sBGn9Ll3Y5Rf+lKVNGxIDpgIXTxoetopU21b7D/MqXzqzs7G7wnb2RAf?=
 =?us-ascii?Q?eYnmA8bAJOTn5mJ7+oPRKEoOm9+XcrPUxM7ac7Bc+xdcgzbG7h4tLcrW8hsc?=
 =?us-ascii?Q?tRMJBvSztJrnxhsMNCt00DIUyDutCz8UfQH2kKQu66i5CqON5cD/E6oV/eTz?=
 =?us-ascii?Q?AjhX1LONP3vFpDzKAlU+okP8JBFD2btSKY64H1mDOIoRPrdTln4SdV1zW/UI?=
 =?us-ascii?Q?hQwwV/CGobmIoHd52HuiRQpaARH6t7e9oDeB9qczlKwhQdnCJ7cm7Pey8+1p?=
 =?us-ascii?Q?CB1zXetHf/xhzDP1BuP7/dQUhMjtgbh9NSy1t659XXtLqc3a7TNTwkjNLRkY?=
 =?us-ascii?Q?sZwn+Nl1UOR5Cwt2YYS8RG4KnI1DrgcViIxZvGbxibZgaA4+w833Wgpw49FU?=
 =?us-ascii?Q?T1RwlwuZ97geU/3o3P0U+CVI9r2/wXZEJ08Gla6h6CeHTpZdciXzCeOYUpzS?=
 =?us-ascii?Q?ydYtDSvRrmir0h0sQFOvYjDlzt8LebKRIUXxd9FT3m/AGmL3P2SEgfqnt1r2?=
 =?us-ascii?Q?DCQd/YyCUBwDJtVNQ/0yTgbgi4RLXZ2wpC/qa+97PLWY+JKUJ/7yB/JZ+8pg?=
 =?us-ascii?Q?MOy/qP0pxUOBoyxtePTqwbOjR6amjeq1yw2A?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR02MB10771.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fQKYVKDRFdfcdrQE4y55sIOBzBBcwMH+NJR+GrN3+8AVSTrSFyJnIW74pODy?=
 =?us-ascii?Q?eESHtRRoxH6A/YgPeAkRTtjsMmGMVpR9IRvF//ewXdaZkMoYpgZ0YUexcVcP?=
 =?us-ascii?Q?I6m+ERErI3G3+Cmr78RcNsN20u/ofjL8eqRTd6nDbNM1yDmD+x3uW/IyoEjn?=
 =?us-ascii?Q?YZbnNy0XXs6LSfHRtCnhkujhrH8YrrKhMqCHim8F//G0nr/YgeDhQsJiSuvz?=
 =?us-ascii?Q?jFd994pDgRv+f9ld8PJk5jwDlg7Y+AnRcozXLNgY+bzfG5BQqIdKI6zyAMpO?=
 =?us-ascii?Q?mntgwqon12L22ZGX+AAIa+gZm6BZ9J9jZmX1gZqVAmfIVkwNTkAiwOZgbJtH?=
 =?us-ascii?Q?vqKcAgRbRoK1CWwrGyF1WVLYybLymVp5/Pni2bWF7kMHMa4mAulcw3Aou5OH?=
 =?us-ascii?Q?eJLMj78SmJrZuADsgBz2DlIpc/OG53N0Me2xwPHI9QWLxtUw+15NE/q3NMsF?=
 =?us-ascii?Q?qj4NdAqiAjDr8Xd5RfzgFg5Eg0BWfA6PqV3NRw5+kO6RUTpABb0sgjmZPwFD?=
 =?us-ascii?Q?pOxsGnhtPXyjsuzJoE57xWmAoUoG/46L6E2R6KUpjMqQJEVh3qAg/A5eGuPW?=
 =?us-ascii?Q?SeXy4hqgbm1yYMGK8Ni4LpeZlHF5OXBYqdyUY7kpEhhO/gtUCfCiOK48S4MS?=
 =?us-ascii?Q?E9ehUxx68BQxwkcTo8jPHOeYTVGX8N2St0PnUrbBfFnWksaA8nFCGYfNcjfX?=
 =?us-ascii?Q?i3sWEfk9fH60PJYOd6kVEtbWUbymH/0SIv/cV+ll0fcUmz452X2WBvRxOZAI?=
 =?us-ascii?Q?ryzZhwGQ2c5W2VJMgHNDUI/IMiIgtChLstnLO1Qs3pkIgpRq91JZlKRClgdY?=
 =?us-ascii?Q?RsY7GjmuMUIYnpkQi3lR7YiDBPHggcUvR/s0QsJFWzYS7C7wfRkDiHC+wjpX?=
 =?us-ascii?Q?jyNP+Z4BhsZ/Nd8IW4AAiRP/yvk4wK2FilAFf2DRfUOxVp970jCT4E6l2sCG?=
 =?us-ascii?Q?sGN9xPclh6O4Blwyfq2Hmliu2KSRuAxdK2FW3F2MsFPyWMJtcYCjjdUCrO/Y?=
 =?us-ascii?Q?9yRBLwz2SuqxdkZCqHEVKdlCKM8pL1hhKb5GJtoEtDBrdu6TlcvvuJ0/1Nw1?=
 =?us-ascii?Q?dbpds8tqZ15Jg3gD+OOgROEfX0dXmv592qWIa4gZa1rpv4h4X5SpKCKYe1at?=
 =?us-ascii?Q?gUiPNskaZk31dmgvIcONny/M3b8rtD1ThoTU0uZEcmTK0/Gnoy5z7Gu27j5E?=
 =?us-ascii?Q?8FDOVjvkVKPn3Er7JhGeOablguW7o4ggSlAQbEMJ5yumoQSwu2lL+YxcW7ex?=
 =?us-ascii?Q?BvF6+SA/TR8r9bkvq97SaZNStwahriQIx3aegxL6FUQUMg2fKlTj6bEwbFLg?=
 =?us-ascii?Q?MqbmQ8rVZAwHAfHGPFLyQftGig8hjw5sg9pQoi2oyFqQfeFNq7iPs3k9s50V?=
 =?us-ascii?Q?v0xbLqpRs6JUmGeKkUlR2nFsMz6Kj4ys3d/7WR4opec2wROOiC6ckDFl/XeA?=
 =?us-ascii?Q?62Bq/Ji7n4vw5FFNMjh2ctnqJCGidhB1lrjxdvRdQ0eVYhbCxRFmTTtrZT9S?=
 =?us-ascii?Q?DK/WCB/UqnwObWWDQ7y2KwKgCo8BFot53v7hUOI2GdW0XdNzj1kiMyrBnbx6?=
 =?us-ascii?Q?8OUGA+PfUE4aGwxklznugejIifJO1G4qa7ZM/E23?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR02MB107715904EC92CDED61931E37E91BAIA3PR02MB10771na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fKpjXmTXZzWJyg/6ZtPi/HOvqsd/h0CMoEX/pbIfr7TB4/PFWue64ShQL6q1SD4ieWNCbMo6Czy52GrwXQt0fk1a1A0qxrXgNV3ErocwDS209ThFaewuKYA7hD9SnFrZgYoqFPVp15XHAocSaPMjLfFZn8R5CP2IOAlTW6yC8hRSX0fd5yMOXupZmVJ5xMqn3Zj25WSSjWSL5k+cdTrqznCWWcFfjRfiloCUQQsXkJlFWaklrsOsGmGWHllStut4g46YSYt+qFShHaKf5To/P/WdjQupxDL09n5ePEy4OG8lrWQS2tkhMgfK04dzqqCSYnIOswEaAjKcg4mt9nX9b1//fDm+At8NNKhs2mVAefEu/w382IjUyRhPjuvn8uFs4UjWYYVUqjx4tRYJRUkpsHNbKE8Or2/iibeKufbaf7l9smsmerTG0+NZuV1RwsPqt0fLPbIigPl+/YBI9IK29CFWEVt8s+yoz2LvXDMPLno1CqY43wpHJp31ScLbhladvFqac4h+UAeHYy9sUri6nTte5kcctGOkgySKGRSYyKkPag0DiKGYtSQix7zAEZvbHMjl5wMgR+/wCtN3mTmIupLDdnuU+DQplZGABmu7mcfdTAuQbaaenWiow4u5hH5H
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB10771.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2db7a7-ea25-49e0-f405-08ddff7e6359
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 17:34:05.3768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLcvK/eq2XI/2gOkwg0mLpfcoKJPwULzeT4MOMo9Tk3rZoCSuPMW38WBbeDpAVKx/dcDLV7EqQON4ot6hQ9GRKgt5RRYxeH0XGamWEYmzmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9298
X-Proofpoint-GUID: _V7D8SddEZ00Qs-0W5Su2BXiKDuF1gzk
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68dac313 cx=c_pps
 a=wTW14iHPWsjxmVSX4jmdzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=bt5KbKNvAAAA:8 a=EUspDBNiAAAA:8 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8 a=jZVsG21pAAAA:8 a=I6DIexeO_gHqmB5WYdIA:9
 a=CjuIK1q_8ugA:10 a=q6VLsz5ahw6SoJkc:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-ORIG-GUID: _V7D8SddEZ00Qs-0W5Su2BXiKDuF1gzk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfXzH9lTRXscn69
 KtMpfDWUOinxafa07jO8CUaCwzudUelAgwy2bFt0Cnb3u2T1lp4q3eo3BVUThMPkx11SbX/ED7j
 YElCacDdYIGBvQUScHtrCIkcuXlxHKtMww5P85+M5yp+3RABRlGUMQwcC8GdokEr6Zc5QlEGr4D
 oO7VquabLQ29ZQ5Nf8cpSw1Pl1h7PLEwb1qWPuSnUwXpNzBSoxJEN70otRZPw7GEak9svBToavu
 LC5k/QK+Hc/GqPAw2zSoOQNPw+bVJWOt/VdNa+0qD7Y4B6ej5unpU1nVxRCes6MRiBOUzGNxu0H
 tsF4D9TBWQl4QYtZszyIhBgS99k+xuLfy78ljQvRgxIrESRNcLAkIrtnBwpTLLm0007tmO9RFu3
 2HDG4HYPiqtYbkDu7A39Xb9TXE9raw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001
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

--_000_IA3PR02MB107715904EC92CDED61931E37E91BAIA3PR02MB10771na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Thomas,
In DPDK test cases, I agree that nothing other than Ethernet link types are=
 currently used. However, when using DPDK Rawdev, the protocol is not usual=
ly Ethernet. In my case, I am trying to create PCAP files based on custom P=
CI-e traffic. The DPDK pcapng library currently hardcodes the metadata to b=
e Ethernet, which cannot be read properly by Wireshark. Allowing the user t=
o specify the protocol link type, the user can ensure the pcapng metadata m=
atches the traffic data.
Dylan
________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Saturday, September 27, 2025 3:28 AM
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; J=
erin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; N=
ithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.c=
om>; Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interf=
ace block

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

26/09/2025 02:04, Stephen Hemminger:
> On Wed, 27 Aug 2025 16:32:15 -0600
> Schneide <schneide@qti.qualcomm.com> wrote:
>
> >
> > +* pcapng: Changed the API for adding interfaces to include a link type=
 argument.
> > +  The link type was previously hardcoded to the ethernet link type in =
the API.
> > +  This argument is added to ``rte_pcapng_add_interface``.
> > +  These functions are versioned to retain binary compatibility until t=
he next LTS release.
>
> Since link connector is now merged, and that wording might overlap and
> be confusing. Would be could to add reference to pcap-linktype.7 man
> page.

I'm not sure it overlaps.
RTE_ETH_LINK_CONNECTOR is about Ethernet cables while
pcap link type will be simply Ethernet type.

This being said, I don't understand the immediate benefit of this commit.
Why pcap link type would not be always Ethernet in DPDK case?
I think the only benefit is for future if other link types are added.
Is there something else I'm missing?



--_000_IA3PR02MB107715904EC92CDED61931E37E91BAIA3PR02MB10771na_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
Hey Thomas,</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSF=
ontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, =
0, 0);" class=3D"elementToProof">
In DPDK test cases, I agree that nothing other than Ethernet link types are=
 currently used. However, when using DPDK Rawdev, the protocol is not usual=
ly Ethernet. In my case, I am trying to create PCAP files based on custom P=
CI-e traffic. The DPDK pcapng library
 currently hardcodes the metadata to be Ethernet, which cannot be read prop=
erly by Wireshark. Allowing the user to specify the protocol link type, the=
 user can ensure the pcapng metadata matches the traffic data.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Dylan</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thomas Monjalon &lt;t=
homas@monjalon.net&gt;<br>
<b>Sent:</b> Saturday, September 27, 2025 3:28 AM<br>
<b>To:</b> Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.patt=
an@intel.com&gt;; Jerin Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt=
;kirankumark@marvell.com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com=
&gt;; Zhirun Yan &lt;yanzhirun_163@163.com&gt;; Stephen Hemminger &lt;steph=
en@networkplumber.org&gt;<br>
<b>Subject:</b> Re: [PATCH v2] pcapng: allow any protocol link type for the=
 interface block</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARNING: This email originated from outside of Qua=
lcomm. Please be wary of any links or attachments, and do not enable macros=
.<br>
<br>
26/09/2025 02:04, Stephen Hemminger:<br>
&gt; On Wed, 27 Aug 2025 16:32:15 -0600<br>
&gt; Schneide &lt;schneide@qti.qualcomm.com&gt; wrote:<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; +* pcapng: Changed the API for adding interfaces to include a lin=
k type argument.<br>
&gt; &gt; +&nbsp; The link type was previously hardcoded to the ethernet li=
nk type in the API.<br>
&gt; &gt; +&nbsp; This argument is added to ``rte_pcapng_add_interface``.<b=
r>
&gt; &gt; +&nbsp; These functions are versioned to retain binary compatibil=
ity until the next LTS release.<br>
&gt;<br>
&gt; Since link connector is now merged, and that wording might overlap and=
<br>
&gt; be confusing. Would be could to add reference to pcap-linktype.7 man<b=
r>
&gt; page.<br>
<br>
I'm not sure it overlaps.<br>
RTE_ETH_LINK_CONNECTOR is about Ethernet cables while<br>
pcap link type will be simply Ethernet type.<br>
<br>
This being said, I don't understand the immediate benefit of this commit.<b=
r>
Why pcap link type would not be always Ethernet in DPDK case?<br>
I think the only benefit is for future if other link types are added.<br>
Is there something else I'm missing?<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_IA3PR02MB107715904EC92CDED61931E37E91BAIA3PR02MB10771na_--
