Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5F8C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 12:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A681A40608;
	Mon, 26 May 2025 14:30:15 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B3DF9402ED
 for <dev@dpdk.org>; Mon, 26 May 2025 14:30:13 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q1D5Gf028978
 for <dev@dpdk.org>; Mon, 26 May 2025 05:30:12 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebh33v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 05:30:12 -0700 (PDT)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54QCUCHT018250
 for <dev@dpdk.org>; Mon, 26 May 2025 05:30:12 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2136.outbound.protection.outlook.com [40.107.100.136])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebh33h-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 May 2025 05:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kq0LfvjSj9OFCvPjveCMkrBShz5cOYXoF8ft+ZD9NBcsYBauH2hdRcfrlnH4I6tXccZmiY/LUnsYvwsA73fHYg9bObRlL7hXewccvgpg0CWoZzVaCTvFeFlX/QWx0adWirtQz0T6w/7NoUnZW3kluJYMqpafcp5m0TcIKRJgpzUuHfLE1TUrchA34utzCmS3oPX1c4ckfmn/p8KTap12sGwjpa0yl/QULFRdpm5CgVDTwduK9Y82G+b3VHQdEyvTfMPGDTO7AEUZbBMhYThrnNbQGjZqoMGGSc1eweBsGDZF6QU/Kfj7UYGIjn8sOv9O/XYBtHi3iL1hPEuzDwWQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6kk3KgyrwaW+zBH24l++4jEei1XVpKh4RSuWOz/70c=;
 b=FQE4kgm7XZavMU7Smn3BRuf/SQ7Y5koFAdGA9NY/uegfT84x9QgHLDpeK60S5xLPE56kx1j9WSWqKac83ye2ma1Vq1h6MAu6GBKW0TMiO5/AjqNL4HeLev5zrbHgdY+Fl5M+oInxJk/hESMrhZIR6x1jPlwBk4k7trTra6cNXcVCRUs9JMTCuaSZwp6SqvNDwWdSZWNWgPpi3G+90Vd2BOsy8oMeaJiN4TZ1gOY2r+UPtrRLEKRCcWhUBtnKOULxNXyu87DxwSTFAxxj4AMbP13PCcR0sWcZz+Xd7tRCjJAdR1ccoJFwWCuDyC4zLsLev1QXgxu2X64SxpwXYzI8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6kk3KgyrwaW+zBH24l++4jEei1XVpKh4RSuWOz/70c=;
 b=G14hVXGMsB/cyhkdMQIl1pfGeW8Zf0+dYQsztoe2y5kJNNVr6E3ml1AKlHMDgZcj+AK1cXQZTXfw488yg0JSHIClrprvIpxkIs4d+dp5OzFTc6GXIy7ZMXZCJuRW4Smo0lji76ksjoN9fznw3LdUAyWK6qevy5s6iFeySgefhAs=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CH3PR18MB5457.namprd18.prod.outlook.com (2603:10b6:610:157::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 12:30:01 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 12:30:01 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Sunil Kumar Kori <skori@marvell.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [EXTERNAL] [PATCH] ethdev: remove callback checks from fast path
Thread-Topic: [EXTERNAL] [PATCH] ethdev: remove callback checks from fast path
Thread-Index: AQHbuTIxxulHsQt9gEiHbmf0zxl3FLPlATcw
Date: Mon, 26 May 2025 12:30:01 +0000
Message-ID: <BY3PR18MB478583086BD73770A3819725C865A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250429181132.2544771-1-skori@marvell.com>
In-Reply-To: <20250429181132.2544771-1-skori@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CH3PR18MB5457:EE_
x-ms-office365-filtering-correlation-id: ae735a37-0940-4f9c-fcc2-08dd9c510927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S1lKeWRwL095RUtNb2ZNRU5WRUdaQ21kY0YxTnZtL2pET0l0NnZ6dWJFaHJs?=
 =?utf-8?B?TGdMcmN1NEZsTHQ4UldLK09uaUNDZ1dpajhIUURXUDQ0NTBmYlhoSEhadElS?=
 =?utf-8?B?b0FGUThPMzdORytXTytZUWFPeVZEYjkwUFo4YkJrcHlQSHR2bmhYRXhiVUZR?=
 =?utf-8?B?bkNRMXgzTkg3TENlcExtYm9JUjI1Uk15bE5EQlZOTi85akNDNS9oNWJaSllR?=
 =?utf-8?B?R3NienV2S2lsVGdyalAvTFJoNkJrdk0zZW1XaDBnZHZ5c1BFYVgwZWl6ZmpF?=
 =?utf-8?B?dSt5dlhsMWp4MTRnMTE1bkpuNVFZemJ5N0lMRlNPT3ZNSGVZbEtaS0cwd0dK?=
 =?utf-8?B?Q09iVGlMNXJjM2wyOTJXd3JiM0xhbmFNNGFnQWk5blFSbVN0Y0RsZlFNeWM2?=
 =?utf-8?B?T0xTN3dzWkp1Mzk1L3hqaEdVakVZckJ4bTZRS0pBS1dqd1pVQ3o1Y0RIRGNX?=
 =?utf-8?B?Z21UWjBSa2xXMEJERVRCMTFHQXgrR2VpSVVBM2dtOEFNNWJaSkdETGpRditO?=
 =?utf-8?B?YTBQenpsOXBIeG1zSnFwdXFKbFNXQ2xmclRKVGpuRTl4cGVHYWlvcDRvTWtv?=
 =?utf-8?B?T0hhbzdleng1Z0RVR2FDQVpwZ253TXBobUJUdTVwQ2V5MEx1M3M5bDZ6VHVE?=
 =?utf-8?B?cHJQa1JjUC90S2J2aWRLbGNQSDAveEpGTFdzUWlpS29BRnNLQ05Xc1RWcTZQ?=
 =?utf-8?B?bWxLN01NNGk1TU1obmo4Qm9NWFd3Z1lteEJET09YVmNkeHpTRlRYR0ROYlRv?=
 =?utf-8?B?WFBSMjlRT1Y3V3d0K2hYTUEvZUdyVEdTNnFGVmRqK2ZYZ0l5NFpKYmlzQXFC?=
 =?utf-8?B?emJEUytneXJ1aEQzY2t0MWdvUkxiRTErWnRQeVJJYVMwSEVNZW5xMFlIVE1E?=
 =?utf-8?B?TEpLVlBIVUUwYWROOGJ5Lzg2ZUpVS3pXeTROUFMxM1oyZ0VoQ1pyblZLbHRi?=
 =?utf-8?B?dUR6djhjdDVVRFF1RGpGWkVwWHpHYVdSTjlDelZ3VEF5NDVJelAvWmdjdXp5?=
 =?utf-8?B?bnhWRHZtWDNnMjBSV1AzbEFzOUJ5QUkzc2tyOUlNNll5YkNsNjVObVkrV0kv?=
 =?utf-8?B?VzQ3Y3VxNlEvM25mdXZkNGhKaW9BdTFoc1E2dmExZElvSnphSStLK1lLb3la?=
 =?utf-8?B?MnQ5SDZEZERPM2EvYmNhU1JDTmN1QkM1WXJjRzRHbHpFYTFJZ3VUWUw5R09t?=
 =?utf-8?B?N2trVlJmUis3cTNxMUFlM0dLOW5venYrUnB4TlB5NVZ4YXFkV0dQVUU5czc0?=
 =?utf-8?B?Vk5HbjhKZTBBT1Z0QkFhK2NvT0hNb29lZ3pKTjJoT05kenA3Nkg4d3pqTkk1?=
 =?utf-8?B?WmxtakFvS2dCeWNpMmo5T3hvVUw5RGtlNy9nZ0xWU0FnNTVYWVZHUXNaMlVN?=
 =?utf-8?B?MkN6SXg1MjhIOEVVTmNQVFhpd3BkNnJCQ1Vzd2J0NTRFM0ZEcWpCUWVoV296?=
 =?utf-8?B?dng3UkRGTjd3cU9HV01FckZWdk96dy9xT0Q3d1RaWUpTcUd6eVhEWURtSml5?=
 =?utf-8?B?eWxTTHdhT1hPYVhYem9HSWNseEpnZVBiSzVMeEFwSG5MZll3eDAva3pMOTdK?=
 =?utf-8?B?TTNaV3hFKzRtcnJDNG1XZEFXNVQrZWZHKzI3MFVvcnRpOFdkUm91enVmeVRY?=
 =?utf-8?B?bXRyaG0wZmpPZFppRjJYMzdtSVBzRGdYZ3JlemtILzdhQjRMVEYrTFYwcDY0?=
 =?utf-8?B?M1h2YnhwNFNXWDQrYWdzZWNSWmhBdjdWRFJVU2t1Wkc3djVlSGR6bjdtWENY?=
 =?utf-8?B?V3ZPU0MxWkhxb3g1enptQ1lnTmRvUTQrV3BLL1dpTW9CcG50bU5VWnhzK0RN?=
 =?utf-8?B?UVdBTHRwbXJyME9XVDVZcHlNenZyWlJYK3JUMWdQcEJRdkptQlYwZ1JMOTJW?=
 =?utf-8?B?MC8yVFNYdVFLVGlmYWRvVEphLzl4emlRUXR3WU02UWhidndHallwVm5nZVlx?=
 =?utf-8?Q?s40fYzVWvGErTb2+gwODPyB+25a1/dCV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEdsREdXTHY1Rk1BbU9vcHpWZE1GYkdwZCtrMnRzcG40Y21PNGZtZ2VZUHlC?=
 =?utf-8?B?SE9VNlo0ejRJQ0F2aWpaYVRUcnRsWWlpelJ4a2ZaR1BwVmNxM2lYNnlpalNG?=
 =?utf-8?B?dFlPT0h5WExTN25SaGxRVkdFVGdiSTJ4ZnBFOUdoaXEvZXRnTExDNENVTFVu?=
 =?utf-8?B?VUl5RWl0OE5FbEsrQzIyZEpxNlFjL0RKNGhmZkNPRXoxU1R0bWFmd3p6Z1RC?=
 =?utf-8?B?UDZrVE5XdVRNTkRwSUNPTCtYZ0NyNGZUdWVaYVhkQ0FLYUtKaGpTVG5aY00w?=
 =?utf-8?B?R01QWUNoNzBmc1NCRFdMYWVqQWlLUnZVNUJBdnBkNUVhaUxRYXpRWTJvUm5B?=
 =?utf-8?B?R2hpbDFGbDRnV24rSGZETXFjUFVhTnBJUzkvUHJjUURHOUFTclhWdmZTQy9J?=
 =?utf-8?B?OFRyd3BlYmRhdjNKNnhCUTVzbzdMcXIzY1VTUHhFazFhdmxQVWt4YmM0QVkw?=
 =?utf-8?B?YVhwVHVTZVVnVlR5QmZ6U3llVzNYMWlseFdmK1RJREg3SUpYcHEzdmk4bjkr?=
 =?utf-8?B?MEZPN3R1WEFWU3BjZE1kOUw2d0Y3OHFiYU9FZThqSDA2MTl4TU93YXo1dTg3?=
 =?utf-8?B?T0NkMVZhRWlHak83SWxtL1lmN3dDeUZETjhYdjE4MVdTdi9sZ2VoQVBvTFow?=
 =?utf-8?B?YmlYSERRZ2hTY2dSZDVzQ1dFbWxQYWhYMjJyRGtodlpmdHdzNDdwdzZWclVB?=
 =?utf-8?B?cEhQNEJOU2JsNGx5Wk9DSytyUy9LWHo4MG9RYm9DY2R1MldlazRMbjM1Lzdw?=
 =?utf-8?B?UmQ3S3NReGgyVU5MT0thSXVMODNxdUFTaW10ZlpGZUFMVnBNOE5RRWRseDVi?=
 =?utf-8?B?V3AzNG1aOXpOaUVMQ2xUQUt2QmxXTXFmWjFrYnJUdWs1ZWhTN1g3Rkk5Q00w?=
 =?utf-8?B?OGRKSTNuajM4cTBFM052SlpWK3NnSlA4YmU2WDRyVnVkMm1Kd2J2VEFFQUV1?=
 =?utf-8?B?aUNPV05wNTIzR3pMYWtJSnBIRm55STdZMGF2bEZlWHM1bE84RU5qY2NPVDFU?=
 =?utf-8?B?endpV0NFUnFWdTduRnZYYXhNcnQzZE9hQWNEQnBKMkNnYjRmNmprNDVZNTVw?=
 =?utf-8?B?ME9GNGh1ck5qVENWQTBma3lOT015Vit4Zzh6aU02OXA1eGwxZ1dpMFQyZGFD?=
 =?utf-8?B?cXJDVTRobDIwUXJiQkxJTVoyNjlkbUxXUU1vcWtlN3lsd0t5Tzg0L2FYSUVP?=
 =?utf-8?B?cDdheEpSRUEwNC8zc0NaVEJtbnhEcitZR3U4dWs5RGlUMFp0emdWd3YxSndX?=
 =?utf-8?B?SUdNOTYwM054bU1oME5FT2xaZ3kxOWlIRTRCcGJmb2k2V1hwSmdOQmtTd1Fy?=
 =?utf-8?B?N0ZxT1VoT3l5WlJseUpkNDA2TFFvTzZXRERqcHo2Ykt4bng2aFVmRnBtZHVU?=
 =?utf-8?B?cHloZ2g1VjIza01WbEI1amlkTm1CalMycWM4SUFTZkVkRjRhQVN6d2NtdlZ5?=
 =?utf-8?B?ekRJdld5UjkwYTNyQ3EzMm1JY1BhV3ZWcVNVMWUxalF2REJFNzQ5Y29jUHF3?=
 =?utf-8?B?T0ltb3RsZFYwdWloOEZnRUJnYXNBZEowUWx3ZTB3WHJzcVZVZ0l1Ukh0MjJ3?=
 =?utf-8?B?ekIzRVd1SlptOUR2dk94Z3hRTDBOR3pNTDV2aGRJWEF3bEVNOGYxL2dWd1Bs?=
 =?utf-8?B?UXlPN05nbGVTbTd6S3ZWc3VSZVNMQlRCZTFaYnlUVXgrdEI0emxjT29lUWYz?=
 =?utf-8?B?U3NkNDN6WFBDL3ExNGxjMVFwSlMraUNYcmZXWmg4SVhPUjdxVGlSb044VEZN?=
 =?utf-8?B?M3A1TmRGNVY0VkhKcTczelJDRUUwSTlLaEJidEtHKy9Ea2w3OXAxbDY3VXR6?=
 =?utf-8?B?enR0b2NWWCsveUxEUndmbmk5VWpTZTZ6SDBHcHAvV2pQTnoxWDFTSGU1WHZx?=
 =?utf-8?B?dFYyUG1HSFlYNjRwRW1TUDhZdVFBRlJOVnZ1eUtxQ3o4WVJ3MDIvS05scmVr?=
 =?utf-8?B?cDBnbGUwa1hkcWVnOU04Y2tVb25FMzlDMnEyb1g1TndwYTVJam8yaGxXYXc1?=
 =?utf-8?B?VkNwYVI1c0Q0ODVWSXZGTEFvUllWdzRPZ29ndXJqTER2SXliT2pMWFA1QUZx?=
 =?utf-8?B?eDBpOExmYnZjcEhTRXZKVXBZZkR2Z053UDIyaUV0dWZiVUJqWWhaSlpNRFpV?=
 =?utf-8?Q?J+X1dNB1LT4iR91lzoGKUtuFs?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae735a37-0940-4f9c-fcc2-08dd9c510927
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 12:30:01.6134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fG903qLw0XvbAsICzafuiOc8+R3pRsWKHty/v8GRwcEjk651qT2g6g2AIfYLR4L2Uee+tdSdCImnUIlX8+ZExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5457
X-Proofpoint-ORIG-GUID: JuLkxSe3mCP7D3vIGGNncfoglS8zFCdK
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68345ed4 cx=c_pps
 a=D0xTqnO8G3g1I/JDCPG9pA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=bt5KbKNvAAAA:8 a=zd2uoN0lAAAA:8 a=pK7X0mNQAAAA:8 a=RpNjiQI2AAAA:8
 a=vMbqGBKmtcKRF3aYLdYA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=5HA-qpC1VU4iIGLgRoNS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEwNiBTYWx0ZWRfX31F8pdGr3MAt
 YjQryLFX7iCSRv5T+bzLjHt8iMoOOC66lSAJ9a38/DgO0sxJP21li6rNUOYfOsnsL3GqMGRaJue
 ag1XXarWfFN0VJ/TEevpc8tjhzQ4eAEAH3wqKkR2sF6INe9cKGMRGxV8FS10325rKITWbmYDzRQ
 bFn9N/koyRL4nF4PWWTbzn2oiP/Z1sE908Eg0usnntLq9Kh+w9fBVZA/+gwDoyFajtDwcu5qlNX
 m2kzcV0HPW8ao6qXcMh9EBwS/2tpdMlqIr5Cf76ZpNOqvzIc0rgJ1yQkBLRQLJJcbFivf4gRYoV
 1+FvBqeafGZAKkyzl77kZYdxuHuZzWY8y0+UFJvI/nnSKt3gf4Ti23wesyBaxZvc8GMkkR2ZoPD
 HuQZ87W4ba/F4mku3c8vQMN0eHU/SolrVVsdclW4QHvzQSRNajGHRO6PIUJMhol47Qsr8kfQ
X-Proofpoint-GUID: 7iu_hGgv19GaDtdRpj24AgaTgrk8713R
X-Proofpoint-Banner-Trigger: inbound
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"
X-Proofpoint-Banner-Convert: 8bit mime entity
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_06,2025-05-26_01,2025-03-28_01
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

<!DOCTYPE html>
<!-- BaNnErBlUrFlE-BoDy-start -->
<!-- Preheader Text : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;height:0px;max-height:0p=
x;opacity:0;overflow:hidden;">
&gt; -----Original Message----- &gt; From: skori@=E2=80=8Amarvell.=E2=80=8A=
com &lt;skori@=E2=80=8Amarvell.=E2=80=8Acom&gt; &gt; Sent: Tuesday, April 2=
9, 2025 11:=E2=80=8A42 PM &gt; To: Thomas Monjalon &lt;thomas@=E2=80=8Amonj=
alon.=E2=80=8Anet&gt;; Ferruh Yigit &gt; &lt;ferruh.=E2=80=8Ayigit@=E2=80=
=8Aamd.=E2=80=8Acom&gt;; Andrew Rybchenko</div>
<!-- Preheader Text : END -->

<!-- Email Banner : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerStart</div>

<!--[if ((ie)|(mso))]>
  <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" width=3D"100%" st=
yle=3D"padding: 16px 0px 16px 0px; direction: ltr" lang=3D"en"><tr><td>
    <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"paddin=
g: 0px 10px 5px 6px; width: 100%; border-radius:4px; border-top:4px solid #=
8d8c8c;background-color:#D2D0D0;"><tr><td valign=3D"top">
      <table align=3D"left" border=3D"0" cellspacing=3D"0" cellpadding=3D"0=
" style=3D"padding: 4px 8px 4px 8px">
	<tr><td style=3D"color:#000000; font-family: 'Arial', sans-serif; font-wei=
ght:bold; font-size:14px; direction: ltr">
	  Prioritize security for external emails:
	</td></tr>
	<tr><td style=3D"color:#000000; font-weight:normal; font-family: 'Arial', =
sans-serif; font-size:12px; direction: ltr">
          Confirm sender and content safety before clicking links or openin=
g attachments
	</td></tr>

      </table>
      <![if ie]><br clear=3D"all"><![endif]>
      <table align=3D"right" border=3D"0" cellspacing=3D"0" cellpadding=3D"=
0" style=3D"padding: 4px 0px 4px 0px"><tr>
	<td style=3D"direction: ltr">&nbsp;&nbsp;<a target=3D"_blank" href=3D"http=
s://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!ui3X2N84rjX7-6H8OTxaz4=
hFS5GAnsUewThiEWIMl1SktpBqvQds4DSQNygCxIhXG9WO5uU2zEzcJ_jJFn4Uv1NBfVlohJijR=
41_8bELC66MmBDGhQ3kXkbTvEmYoLdGH0SLgOQ$" style=3D"mso-padding-alt: 7.5px; p=
adding: 7.5px; border-radius: 2px; border: 1.5px solid #666666; "><strong s=
tyle=3D"font-weight: normal; color: #000000; text-decoration: none; font-fa=
mily: 'Arial', sans-serif; font-size:14px; line-height: 40px; ">&nbsp;&nbsp=
;Report&nbsp;Suspicious&nbsp;&nbsp;</strong></a>&nbsp;&nbsp;&zwnj; </td>
      </tr></table>
    </td></tr></table>
  </td></tr></table>
<![endif]-->

<![if !((ie)|(mso))]>
  <div dir=3D"ltr" lang=3D"en" id=3D"pfptBannerrx63fg0" style=3D"all: rever=
t !important; display:block !important; text-align: left !important; margin=
:16px 0px 16px 0px !important; padding:8px 16px 8px 16px !important; border=
-radius: 4px !important; min-width: 200px !important; background-color: #D2=
D0D0 !important; background-color: #D2D0D0; border-top: 4px solid #8d8c8c !=
important; border-top: 4px solid #8d8c8c;">
    <div id=3D"pfptBannerrx63fg0" style=3D"all: unset !important; float:lef=
t !important; display:block !important; margin: 0px 0px 1px 0px !important;=
 max-width: 600px !important;">
      <div id=3D"pfptBannerrx63fg0" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-family: 'Arial'=
, sans-serif !important; font-family: 'Arial', sans-serif; font-weight:bold=
 !important; font-weight:bold; font-size:14px !important; line-height:18px =
!important; line-height:18px">
	Prioritize security for external emails:
      </div>
      <div id=3D"pfptBannerrx63fg0" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-weight:normal; =
font-family: 'Arial', sans-serif !important; font-family: 'Arial', sans-ser=
if; font-size:12px !important; line-height:18px !important; line-height:18p=
x; margin-top:2px !important;">
Confirm sender and content safety before clicking links or opening attachme=
nts
      </div>

    </div>
    <div id=3D"pfptBannerrx63fg0" style=3D"all: unset !important; float: ri=
ght !important; display: block !important; display: block; margin: 0px 0px =
0px 16px !important; text-align: right !important; width: fit-content !impo=
rtant;">
<a id=3D"pfptBannerrx63fg0" href=3D"https://us-phishalarm-ewt.proofpoint.co=
m/EWT/v1/CRVmXkqW!ui3X2N84rjX7-6H8OTxaz4hFS5GAnsUewThiEWIMl1SktpBqvQds4DSQN=
ygCxIhXG9WO5uU2zEzcJ_jJFn4Uv1NBfVlohJijR41_8bELC66MmBDGhQ3kXkbTvEmYoLdGH0SL=
gOQ$"
    style=3D"all: unset !important; display: inline-block !important; text-=
decoration: none">
    <div class=3D"pfptPrimaryButtonrx63fg0" style=3D"display: inline-block =
!important; display: inline-block; visibility: visible !important; opacity:=
 1 !important; color: #000000 !important; color: #000000; font-family: 'Ari=
al', sans-serif !important; font-family: 'Arial', sans-serif; font-size: 14=
px !important; font-weight: normal !important; text-decoration: none !impor=
tant; border-radius: 2px !important; padding: 7.5px 16px !important; margin=
: 3px 0 3px 16px !important; white-space: nowrap !important; width: fit-con=
tent !important;
	border: 1px solid #666666">
	Report&nbsp;Suspicious
    </div>
</a>
    </div>
    <div style=3D"clear: both !important; display: block !important; visibi=
lity: hidden !important; line-height: 0 !important; font-size: 0.01px !impo=
rtant; height: 0px">&nbsp;</div>
  </div>
<![endif]>

<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerEnd</div>
<!-- Email Banner : END -->

<!-- BaNnErBlUrFlE-BoDy-end -->
<html>
<head><!-- BaNnErBlUrFlE-HeAdEr-start -->
<style>
  #pfptBannerrx63fg0 { all: revert !important; display: block !important;=20
    visibility: visible !important; opacity: 1 !important;=20
    background-color: #D2D0D0 !important;=20
    max-width: none !important; max-height: none !important }
  .pfptPrimaryButtonrx63fg0:hover, .pfptPrimaryButtonrx63fg0:focus {
    background-color: #afaeae !important; }
  .pfptPrimaryButtonrx63fg0:active {
    background-color: #8d8c8c !important; }
</style>

<!-- BaNnErBlUrFlE-HeAdEr-end -->
</head><body><pre style=3D"font-family: sans-serif; font-size: 100%; white-=
space: pre-wrap; word-wrap: break-word">

&gt; -----Original Message-----
&gt; From: skori@marvell.com &lt;skori@marvell.com&gt;
&gt; Sent: Tuesday, April 29, 2025 11:42 PM
&gt; To: Thomas Monjalon &lt;thomas@monjalon.net&gt;; Ferruh Yigit
&gt; &lt;ferruh.yigit@amd.com&gt;; Andrew Rybchenko
&gt; &lt;andrew.rybchenko@oktetlabs.ru&gt;
&gt; Cc: dev@dpdk.org; Sunil Kumar Kori &lt;skori@marvell.com&gt;
&gt; Subject: [EXTERNAL] [PATCH] ethdev: remove callback checks from fast p=
ath
&gt;=20
&gt; From: Sunil Kumar Kori &lt;skori@=E2=80=8Amarvell.=E2=80=8Acom&gt; rte=
_eth_fp_ops contains ops for
&gt; fast path APIs. Each API validates availability of callback and then i=
nvoke it.
&gt; Removing these NULL checks instead using dummy callbacks. Signed-off-b=
y:
&gt; Sunil Kumar ZjQcmQRYFpfptBannerStart Prioritize security for external =
emails:
&gt; Confirm sender and content safety before clicking links or opening att=
achments
&gt; &lt;https://us-phishalarm-
&gt; ewt.proofpoint.com/EWT/v1/CRVmXkqW!ta3Z1f8UAnVatS-
&gt; duf16Ds5hp4nuuus0UNv0GRLoKGk6KzbJ62cMLHhvd3kJIBAKh3RoWS1_8sxE-
&gt; fhkSRumJQAQ4NQ$&gt;
&gt; Report Suspicious
&gt;=20
&gt; ZjQcmQRYFpfptBannerEnd
&gt; From: Sunil Kumar Kori &lt;skori@marvell.com&gt;
&gt;=20
&gt; rte_eth_fp_ops contains ops for fast path APIs. Each API validates ava=
ilability of
&gt; callback and then invoke it.
&gt;=20
&gt; Removing these NULL checks instead using dummy callbacks.
&gt;=20
&gt; Signed-off-by: Sunil Kumar Kori &lt;skori@marvell.com&gt;


Please check the CI issues.
https://patches.dpdk.org/project/dpdk/patch/20250512150732.65743-2-skori@ma=
rvell.com/


&gt; ---
&gt;  lib/ethdev/ethdev_driver.c | 47 ++++++++++++++++++++++
&gt; lib/ethdev/ethdev_driver.h | 82
&gt; ++++++++++++++++++++++++++++++++++++++
&gt;  lib/ethdev/ethdev_pci.h    | 19 +++++++++
&gt;  lib/ethdev/rte_ethdev.h    | 20 +---------
&gt;  4 files changed, 150 insertions(+), 18 deletions(-)
&gt;=20
&gt; diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c i=
ndex
&gt; ec0c1e1176..75073f98cf 100644
&gt; --- a/lib/ethdev/ethdev_driver.c
&gt; +++ b/lib/ethdev/ethdev_driver.c
&gt; @@ -847,6 +847,53 @@ rte_eth_pkt_burst_dummy(void *queue
&gt; __rte_unused,
&gt;  	return 0;
&gt;  }
&gt;=20
&gt; +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_tx_pkt_prepare_dummy)
&gt; +uint16_t
&gt; +rte_eth_tx_pkt_prepare_dummy(void *queue __rte_unused,
&gt; +		struct rte_mbuf **pkts __rte_unused,
&gt; +		uint16_t nb_pkts)
&gt; +{
&gt; +	return nb_pkts;
&gt; +}
&gt; +
&gt; +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_rx_queue_count_dummy)
&gt; +uint32_t
&gt; +rte_eth_rx_queue_count_dummy(void *queue __rte_unused) {
&gt; +	return -ENOTSUP;
&gt; +}
&gt; +
&gt; +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_tx_queue_count_dummy)
&gt; +int
&gt; +rte_eth_tx_queue_count_dummy(void *queue __rte_unused) {
&gt; +	return -ENOTSUP;
&gt; +}
&gt; +
&gt; +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_descriptor_status_dummy)
&gt; +int
&gt; +rte_eth_descriptor_status_dummy(void *queue __rte_unused,
&gt; +		uint16_t offset __rte_unused)
&gt; +{
&gt; +	return -ENOTSUP;
&gt; +}
&gt; +
&gt; +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_recycle_tx_mbufs_reuse_dummy)
&gt; +uint16_t
&gt; +rte_eth_recycle_tx_mbufs_reuse_dummy(void *queue __rte_unused,
&gt; +		struct rte_eth_recycle_rxq_info *recycle_rxq_info
&gt; __rte_unused) {
&gt; +	return 0;
&gt; +}
&gt; +
&gt; +RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_recycle_rx_descriptors_refill_dumm
&gt; y)
&gt; +void
&gt; +rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
&gt; +		uint16_t nb __rte_unused)
&gt; +{
&gt; +
&gt; +}
&gt; +
&gt;  RTE_EXPORT_INTERNAL_SYMBOL(rte_eth_representor_id_get)
&gt;  int
&gt;  rte_eth_representor_id_get(uint16_t port_id, diff --git
&gt; a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h index
&gt; 2b4d2ae9c3..ec00f16ed3 100644
&gt; --- a/lib/ethdev/ethdev_driver.h
&gt; +++ b/lib/ethdev/ethdev_driver.h
&gt; @@ -1874,6 +1874,88 @@ rte_eth_pkt_burst_dummy(void *queue
&gt; __rte_unused,
&gt;  		struct rte_mbuf **pkts __rte_unused,
&gt;  		uint16_t nb_pkts __rte_unused);
&gt;=20
&gt; +/**
&gt; + * @internal
&gt; + * Dummy DPDK callback for Tx packet prepare.
&gt; + *
&gt; + * @param queue
&gt; + *  Pointer to Tx queue
&gt; + * @param pkts
&gt; + *  Packet array
&gt; + * @param nb_pkts
&gt; + *  Number of packets in packet array
&gt; + */
&gt; +__rte_internal
&gt; +uint16_t
&gt; +rte_eth_tx_pkt_prepare_dummy(void *queue __rte_unused,
&gt; +		struct rte_mbuf **pkts __rte_unused,
&gt; +		uint16_t nb_pkts __rte_unused);
&gt; +
&gt; +/**
&gt; + * @internal
&gt; + * Dummy DPDK callback for Rx queue count.
&gt; + *
&gt; + * @param queue
&gt; + *  Pointer to Rx queue
&gt; + */
&gt; +__rte_internal
&gt; +uint32_t
&gt; +rte_eth_rx_queue_count_dummy(void *queue __rte_unused);
&gt; +
&gt; +/**
&gt; + * @internal
&gt; + * Dummy DPDK callback for Tx queue count.
&gt; + *
&gt; + * @param queue
&gt; + *  Pointer to Tx queue
&gt; + */
&gt; +__rte_internal
&gt; +int
&gt; +rte_eth_tx_queue_count_dummy(void *queue __rte_unused);
&gt; +
&gt; +/**
&gt; + * @internal
&gt; + * Dummy DPDK callback for descriptor status.
&gt; + *
&gt; + * @param queue
&gt; + *  Pointer to Rx/Tx queue
&gt; + * @param offset
&gt; + *  The offset of the descriptor starting from tail (0 is the next
&gt; + *  packet to be received by the driver).
&gt; + */
&gt; +__rte_internal
&gt; +int
&gt; +rte_eth_descriptor_status_dummy(void *queue __rte_unused,
&gt; +		uint16_t offset __rte_unused);
&gt; +
&gt; +/**
&gt; + * @internal
&gt; + * Dummy DPDK callback for recycle Tx mbufs reuse.
&gt; + *
&gt; + * @param queue
&gt; + *  Pointer to Tx queue
&gt; + * @param recycle_rxq_info
&gt; + *  Pointer to recycle Rx queue info
&gt; + */
&gt; +__rte_internal
&gt; +uint16_t
&gt; +rte_eth_recycle_tx_mbufs_reuse_dummy(void *queue __rte_unused,
&gt; +		struct rte_eth_recycle_rxq_info *recycle_rxq_info
&gt; __rte_unused);
&gt; +
&gt; +/**
&gt; + * @internal
&gt; + * Dummy DPDK callback Rx descriptor refill.
&gt; + *
&gt; + * @param queue
&gt; + *  Pointer Rx queue
&gt; + * @param offset
&gt; + *  number of descriptors to refill
&gt; + */
&gt; +__rte_internal
&gt; +void
&gt; +rte_eth_recycle_rx_descriptors_refill_dummy(void *queue __rte_unused,
&gt; +		uint16_t nb __rte_unused);
&gt; +
&gt;  /**
&gt;   * Allocate an unique switch domain identifier.
&gt;   *
&gt; diff --git a/lib/ethdev/ethdev_pci.h b/lib/ethdev/ethdev_pci.h index
&gt; 2229ffa252..1bd49ab822 100644
&gt; --- a/lib/ethdev/ethdev_pci.h
&gt; +++ b/lib/ethdev/ethdev_pci.h
&gt; @@ -16,6 +16,20 @@
&gt;  extern "C" {
&gt;  #endif
&gt;=20
&gt; +static inline void
&gt; +rte_eth_set_dummy_fops(struct rte_eth_dev *eth_dev) {
&gt; +	eth_dev-&gt;rx_pkt_burst =3D rte_eth_pkt_burst_dummy;
&gt; +	eth_dev-&gt;tx_pkt_burst =3D rte_eth_pkt_burst_dummy;
&gt; +	eth_dev-&gt;tx_pkt_prepare =3D rte_eth_tx_pkt_prepare_dummy;
&gt; +	eth_dev-&gt;rx_queue_count =3D rte_eth_rx_queue_count_dummy;
&gt; +	eth_dev-&gt;tx_queue_count =3D rte_eth_tx_queue_count_dummy;
&gt; +	eth_dev-&gt;rx_descriptor_status =3D rte_eth_descriptor_status_dummy;
&gt; +	eth_dev-&gt;tx_descriptor_status =3D rte_eth_descriptor_status_dummy;
&gt; +	eth_dev-&gt;recycle_tx_mbufs_reuse =3D
&gt; rte_eth_recycle_tx_mbufs_reuse_dummy;
&gt; +	eth_dev-&gt;recycle_rx_descriptors_refill =3D
&gt; +rte_eth_recycle_rx_descriptors_refill_dummy;
&gt; +}
&gt; +
&gt;  /**
&gt;   * Copy pci device info to the Ethernet device data.
&gt;   * Shared memory (eth_dev-&gt;data) only updated by primary process, =
so it is
&gt; safe @@ -147,6 +161,11 @@ rte_eth_dev_pci_generic_probe(struct
&gt; rte_pci_device *pci_dev,
&gt;  	if (!eth_dev)
&gt;  		return -ENOMEM;
&gt;=20
&gt; +	/* Update fast path ops with dummy callbacks. Driver will update
&gt; +	 * them with required callbacks in the init function.
&gt; +	 */
&gt; +	rte_eth_set_dummy_fops(eth_dev);
&gt; +
&gt;  	ret =3D dev_init(eth_dev);
&gt;  	if (ret)
&gt;  		rte_eth_dev_release_port(eth_dev);
&gt; diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h index
&gt; ea7f8c4a1a..aa67b69134 100644
&gt; --- a/lib/ethdev/rte_ethdev.h
&gt; +++ b/lib/ethdev/rte_ethdev.h
&gt; @@ -6399,8 +6399,6 @@ rte_eth_rx_queue_count(uint16_t port_id, uint16_t
&gt; queue_id)
&gt;  		return -EINVAL;
&gt;  #endif
&gt;=20
&gt; -	if (p-&gt;rx_queue_count =3D=3D NULL)
&gt; -		return -ENOTSUP;
&gt;  	return (int)p-&gt;rx_queue_count(qd);
&gt;  }
&gt;=20
&gt; @@ -6471,8 +6469,6 @@ rte_eth_rx_descriptor_status(uint16_t port_id,
&gt; uint16_t queue_id,
&gt;  	if (qd =3D=3D NULL)
&gt;  		return -ENODEV;
&gt;  #endif
&gt; -	if (p-&gt;rx_descriptor_status =3D=3D NULL)
&gt; -		return -ENOTSUP;
&gt;  	return p-&gt;rx_descriptor_status(qd, offset);  }
&gt;=20
&gt; @@ -6542,8 +6538,6 @@ static inline int
&gt; rte_eth_tx_descriptor_status(uint16_t port_id,
&gt;  	if (qd =3D=3D NULL)
&gt;  		return -ENODEV;
&gt;  #endif
&gt; -	if (p-&gt;tx_descriptor_status =3D=3D NULL)
&gt; -		return -ENOTSUP;
&gt;  	return p-&gt;tx_descriptor_status(qd, offset);  }
&gt;=20
&gt; @@ -6786,9 +6780,6 @@ rte_eth_tx_prepare(uint16_t port_id, uint16_t
&gt; queue_id,
&gt;  	}
&gt;  #endif
&gt;=20
&gt; -	if (!p-&gt;tx_pkt_prepare)
&gt; -		return nb_pkts;
&gt; -
&gt;  	return p-&gt;tx_pkt_prepare(qd, tx_pkts, nb_pkts);  }
&gt;=20
&gt; @@ -6985,8 +6976,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id,
&gt; uint16_t rx_queue_id,
&gt;  		return 0;
&gt;  	}
&gt;  #endif
&gt; -	if (p1-&gt;recycle_tx_mbufs_reuse =3D=3D NULL)
&gt; -		return 0;
&gt;=20
&gt;  #ifdef RTE_ETHDEV_DEBUG_RX
&gt;  	if (rx_port_id &gt;=3D RTE_MAX_ETHPORTS ||
&gt; @@ -7010,8 +6999,6 @@ rte_eth_recycle_mbufs(uint16_t rx_port_id,
&gt; uint16_t rx_queue_id,
&gt;  		return 0;
&gt;  	}
&gt;  #endif
&gt; -	if (p2-&gt;recycle_rx_descriptors_refill =3D=3D NULL)
&gt; -		return 0;
&gt;=20
&gt;  	/* Copy used *rte_mbuf* buffer pointers from Tx mbuf ring
&gt;  	 * into Rx mbuf ring.
&gt; @@ -7131,14 +7118,11 @@ rte_eth_tx_queue_count(uint16_t port_id,
&gt; uint16_t queue_id)
&gt;  		goto out;
&gt;  	}
&gt;  #endif
&gt; -	if (fops-&gt;tx_queue_count =3D=3D NULL) {
&gt; -		rc =3D -ENOTSUP;
&gt; -		goto out;
&gt; -	}
&gt; -
&gt;  	rc =3D fops-&gt;tx_queue_count(qd);
&gt;=20
&gt; +#ifdef RTE_ETHDEV_DEBUG_TX
&gt;  out:
&gt; +#endif
&gt;  	rte_eth_trace_tx_queue_count(port_id, queue_id, rc);
&gt;  	return rc;
&gt;  }
&gt; --
&gt; 2.43.0

</pre></body></html>
