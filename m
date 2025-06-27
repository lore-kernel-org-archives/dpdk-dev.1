Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06138C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 06:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B571B40277;
	Fri, 27 Jun 2025 08:47:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 362A24026C
 for <dev@dpdk.org>; Fri, 27 Jun 2025 08:47:01 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R33561004487;
 Thu, 26 Jun 2025 23:47:00 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2119.outbound.protection.outlook.com [40.107.243.119])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hk26gf6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 23:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2x35JaWcrUYsVFQlRQ1ie8mY26LKaYLM71GXl2kWfUDesQSg/KLQ9dF9F0Q0sbV+NFW2lZVQf9XlQZRi3nHO5zcT1LtxIfma3YmCcneHI0cwfNI/5k4nokX24J044pUYSVwAQr16yq553tjwE9V+qh2DmhraQUf/jiGOvfWndnaADVLB/SFuVYgab0F7+mlV/UU6t6lGQoarB/kKxeDqfTMvdZEzALWpFrzOd9Qsuv8l25OiIL19FvSk3w0qaUYkzEkuVuutwqnEEmW39wIt78pgfSkQCbOr/Mgc9uGmAyGsoSRErxxra6o4knWK4IBTxHLxymfVlpu2C1gp+3rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFRvV/t2bF4WrOj2JaXXrKbSB0fBvOBVkbUmWK9ZQuY=;
 b=IkWU8fKhND624ZSjObm+eMeI7g3o6h1eo1hdXVI3Y+6siQd2Vav9kznBAhKd3b1CkumTdB5Ek8ldbqiiVIXgTkEikWAacjhqTP61oSsimtrhRuu7sHNeQdfHv9qcm3iikXo5m63pzajNyxaDU3yyKH6RGIq0dk3SDqWnYbeOPBjzF7ffRS1JAvJjTTqEJ4lhMciUQnEyemNlDsugx6NK+z6la+wyUuAnoMGmfJHS5OFQo3CDQ4y5iRS7jcJk7OxWu2/4u58AbViVhsdIAJTM5O9aRm1DGabHTmcxln5CmnOMCVk1YWLVIIvrZbd4BMzrJ6SYCzA3bMxf2IbiPubLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFRvV/t2bF4WrOj2JaXXrKbSB0fBvOBVkbUmWK9ZQuY=;
 b=aPVLZ0oYqaqZU8uQbOKk6KTuQjcEuxOMshFxeOlMstQGgUb1ZFC2tYZX9wh7bpXpd+kFHNZKuXFT5Ov+krPQ48JrCwhflJHREPek9fVu6ecKYV1+954zbVVcG5+meHF4MNdV7BckEtBeIFzs6sr0FS9TGSQoq65HnQmqvWi06io=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CO6PR18MB3988.namprd18.prod.outlook.com (2603:10b6:5:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 06:46:56 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc%3]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 06:46:55 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?= <mattias.ronnblom@ericsson.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, =?utf-8?B?TWF0dGlhcyBSw7ZubmJsb20=?=
 <hofors@lysator.liu.se>
Subject: RE: [EXTERNAL] [PATCH v2] eventdev: make flag types consistent with
 API
Thread-Topic: [EXTERNAL] [PATCH v2] eventdev: make flag types consistent with
 API
Thread-Index: AQHb5qdP9pWbvF4iVEaKejQo9BWN2LQWkOkA
Date: Fri, 27 Jun 2025 06:46:55 +0000
Message-ID: <BY3PR18MB4785386799B92AE5D763DB40C845A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250626135238.168921-1-mattias.ronnblom@ericsson.com>
 <20250626141844.168970-1-mattias.ronnblom@ericsson.com>
In-Reply-To: <20250626141844.168970-1-mattias.ronnblom@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CO6PR18MB3988:EE_
x-ms-office365-filtering-correlation-id: 85b8b5c6-9255-4510-7c20-08ddb5466805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cFQzNkpsWmRrdG9PaE15eHJPdVFYVEZIc2tad21WU2hUNHVqUGdtN0Z5V1lV?=
 =?utf-8?B?ODcxTGtuQ1NmcHlReGdMa0laZjhzNVMzTlkxZGhIRm56NmsxZXgzSmZEakZN?=
 =?utf-8?B?cFk4ZC9VME55Y1NWOXVQWVNKeVBQb3NYYzVsNGxWcERIZUtJS3F0dmsxODlJ?=
 =?utf-8?B?NE9SWmZzQ0hjRVRwUHZqN0QwQ3RBaENRSmhvZUxHRmlTMDUvTVBOazBBV0pv?=
 =?utf-8?B?aHNqRmozdkN6WS8vdGhuckJPNFRTQ1ZTSU1MdEpIOFVLUFZGb281eTZYaXNX?=
 =?utf-8?B?TUdEUWZkUTZLQklTaGpQUkd0SHYrc25lUkFGMW5KOFBURTZHVXJRbnVXU3E1?=
 =?utf-8?B?MnlYNzBXRmNGMnBYVHV3ek9MdnoveFJvdDNueVNqVXlUVU9ya29JbkxZUzFO?=
 =?utf-8?B?U3N1R3o2WFhxcERqY29iRXhERnMyWkdLUUYxMGNzRXRLU2RiN2lvU2I5bHAx?=
 =?utf-8?B?VGZoOWQrQ2FXSlczTmFOaTJMZlo3WE82R1BMYTUrVC9mN0VVUjYvdFZPZnov?=
 =?utf-8?B?YUlTWTVVb0FIVkcxUzdObmUrSGFBcW9TaVcrU3lTVUE0N1lyRGVOeHJsc1dr?=
 =?utf-8?B?c0FETEZKNGRFSEV5cnFZd0RFa2hLTHdXaTkwTnMrN1oyaStyZ2dRK1VrU1Zy?=
 =?utf-8?B?TUNDb1JUR2FIeGh4M0dNejYxd1gzS2dFWjhWTysrUnhzZG53QWU0cW40NzlU?=
 =?utf-8?B?S0FVSXV3STdCMVFmdmVpM005YjA3c3Y1T2R0T2JFWjRNV0dWVzdoaHdDODY4?=
 =?utf-8?B?VWlMZm9IU25vdnl3Yk5mUTlVbjVPNUZ1WERQOUltd3NBWlNEZzU2TS9nd21a?=
 =?utf-8?B?OW5xT0x2Wk1xZ3diKzVVeU1nSUVHL2RNcGgxM0tkNWdaU1Vrbk5obmVhNWdl?=
 =?utf-8?B?YmgweE1xOFAxWktobFpCMkhLNHZtdkliOFhHSkhNK3VlaDd1S3FmdElmcGk3?=
 =?utf-8?B?NjdDT1NnNEpvS2FXdlZGc25CY3FlS0ROU2FkV0Q2WlpMR0IwOUtVS25VbVFv?=
 =?utf-8?B?TG0yeEYxRXhmTTkrbW8zTGtwN2dyUkh5cFovQWV3N3draGw1MlYzVnNPMVlk?=
 =?utf-8?B?NkhyNEFNd0NZSjFrZmxUdWN1cUZ2TDgySVYyUHh2STJ5R29ocytnVW8zNG0y?=
 =?utf-8?B?ankvZnNPRDlwY29xbHRCWGZUTDRHM05vNzFhenZJT2J1RVI4Q0JocGJraWV5?=
 =?utf-8?B?QlVLMUgzWHVxVFVzaEp0WVVWcmkvTVN0VlBQR2VxVkdFOWZKWU5ZNG51R1lN?=
 =?utf-8?B?WThhTlpZYURZdVFsVkQ2YXJaQVA2cmc2QjMyL0t6UmR4dGNqMDc0MkxjRHhB?=
 =?utf-8?B?dFNPdUo0ZkJKd0NaTy9IL3dFdnhqNVA3N3pVWDYwZFhJZVorSUtZbGhmUHlH?=
 =?utf-8?B?NnN0Ty9BNjJyTnNRNFVrQi9QV1E0UkZISXBSeFl6Z0N4enorZjJnZE9sak8v?=
 =?utf-8?B?U0hYOTVtZ0NHMlU5bS9qaGZmL3oxMWE2WE1CM1FRUjJ5ZTl1OHZZZGhHYkNI?=
 =?utf-8?B?d1RwSHI5VGJHczZ1WW4yS2Z0Q0ZtcWxYcEtEUEJLVFBBNEZnT2NheDgxYmZy?=
 =?utf-8?B?OVZIZHZ5QS9HT2UwQW94MVo2TVA5cmNka24yS0d6YzdkYkhlYm0yczBnVUxQ?=
 =?utf-8?B?RkZmc3VaOW1BeVRsQTBIdmFmdElKM2pKeEdrRFFUWk9zUTNVK3BWTW5KVVo3?=
 =?utf-8?B?Q2FqOUZ1OWxBbGE0RGQyOE01cjNSVjByVkc1VHA1NmRyeTFkb2hEUW9qTWZM?=
 =?utf-8?B?bkVvd2czL2ZiaWNuaHVFSmwySXFMSG5xZ2NrL0hBVWJCV2taTGo4RlhvZklH?=
 =?utf-8?B?RnRvUktrNzlVNzlxc2h4TGx1MmxFM0hFMGVkcUNzbERXTWRFd1ZGUU1Rbk5D?=
 =?utf-8?B?VmRuUWFOcGxqVWhNWm9vcU90T0U1cFdYblQ2OWdmN2QvRENlT3JiL1RjSGpM?=
 =?utf-8?Q?HITcg8CfHgo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVYrakhqeUJCODhwTHJtZzRGK0cxeU5BbC9BNHMrTGdCNEpselowdzFEb1Zy?=
 =?utf-8?B?Q21wWHFZWlQyY2dLbTFCK1FGWW00b2pMd1JLRHFjYVVKNXp6Qzg5Wnl0SkdM?=
 =?utf-8?B?aXA2MGd3TGRwdWgzV1NzTS9taWY4MGREZ25aL0taZ3lDY3ZQQy85aWd2dVIr?=
 =?utf-8?B?cUhjVkpCVEdLN0R5RngwNFU3ZU4zY0l2WTNhNlAzaDcyK3BVVGxrL3c3SlVo?=
 =?utf-8?B?YzJrc0pTZUxWUUJ2Y2hrNVB2b2tlSFpLRmRDR1Q4d1RXbHlhdmZWdzdsT0hw?=
 =?utf-8?B?dm9MWk5kTHAwV1gwMDNhcFEyNG8rMjcxOFBieFl2ckFmT3ZvdWJua3pRaEhh?=
 =?utf-8?B?bU83dFZXSmxMODZKNnlHSkduZ1hPV2V4TWRiQ1FrdlVzYWZkZ0VwU2x0Z2hO?=
 =?utf-8?B?S1cxVC93WHVJTkkyV0N5dm5JYjJHOWx0bUhjUjBRYllHZ3E4cGxRSDJmQTZP?=
 =?utf-8?B?MjNYdW1aanQ3OVRSTS9YMFRwRXJSZ1RvODNwWDJIeDFFNjFxSkRTUHNkeUxx?=
 =?utf-8?B?bHBZU3Jwc2ZmRU9TUkk5dzZwMGQ3RW80bm5IT21Ia2M3QVVpdXhiMVVFd1g0?=
 =?utf-8?B?bDJzYnRxcVJCbTgvZGNHN0F4Q1YyVVB1WUlTaHV0RDl3aE5zMnpoWllWS0Yw?=
 =?utf-8?B?djNER3pxY1poaDVxUVl5VG0zUVZzazFmdkYzN20rUkIyeFFFY00zOVRyQzNI?=
 =?utf-8?B?SG04NFJGUDM5ek9uRHRIMjBqcitXSnZGVEJ2bk1Zek1YNGlGdnpIczJ4cDhX?=
 =?utf-8?B?Vk1qSGRSZmcxc1lNeUNhRnIrL2tvSVN1eWtSV0dIdStKajZJOW5QMUg2WEw3?=
 =?utf-8?B?Q3YzaUlkWDlOODUyd3dqbk5VbkV1aklHMCtxL2dab0p5WVNEYU9DYmtmaTBi?=
 =?utf-8?B?d0s4NDVneVN6VWN1UGpmYWRhK1JqQ1FPVE9VTFNiZGI3T05XSE1xNmYvRmts?=
 =?utf-8?B?TlBpWnN4Y3NQd3pJb2ZNWDBVZlhVd1k4eUMyV2krUjRBYmNjUHczd3FlYm0y?=
 =?utf-8?B?UkV2MVBCZzMzZmZ4b1kwMnViYWdZdll3cGZjQm0zVURQY2ZhSmVobmtNMSt3?=
 =?utf-8?B?SHJkU3ljN1hQSWlkNDhyUGJJb1I5cW1jWTZKTFhubk85VUtoQW03dnp1RjV4?=
 =?utf-8?B?Z09nMTR4WHBrRzNTeGYrc2xEdXh6VjhDL0JGVlZDVWdVeUhWK0FMYmU2eDFD?=
 =?utf-8?B?djd0Nk0yMFNvYnpWVTNjclk2eXhBaTBWNGxRVDJmYVE5Q1dwNExtRjVMTkpu?=
 =?utf-8?B?ZDRkZGlHa1lVMkFlaW1Dd0xRNytzMDRwSSticndrTGlpN3ZmZnhoTDROK0NW?=
 =?utf-8?B?TGNmQi94Tlo1VjZBNUVNWUl6VUVRRWYzWnIxNVFoekd3dWY0dzZwdVp6Qkhl?=
 =?utf-8?B?aHJVSjBKZXFXa0hPc2FlaU43QVlQd09kcDhwQzFmMEJxM0E3UnQ5aFJUQkFo?=
 =?utf-8?B?WG0vUHVBY0IzanBpYzg1RmxBVExhMUpORXJuV3l0am1WQ2JVbkZMbllicG1t?=
 =?utf-8?B?SVFha3N1cXo4K1FURk5zYW8vU2YwbmE5U2pMU3liRENnRkFYekVVdHpVNzdJ?=
 =?utf-8?B?UW9udWhWWENja0VQK0NxbnQ2MkJLYmR0SW9GRHR1VkVUblJ3TnBxcU0rUWxE?=
 =?utf-8?B?ZXBxdWVkWkRsbzFWclJIZlNsZEV4MXVVNzBadlF2a0tIckgzeXdMenErbVZa?=
 =?utf-8?B?NHI2VTU2WnFLTk1pd2Fzd3hiOWdRQW5lMlB5OTRSbC91S2FXZ2NLb3BtSFpw?=
 =?utf-8?B?UjRLZWJzVlc5Mjd5V21USFpXQXJpWGMwZ1J5YmNEQ256NWk2NUhMTDloNjQ0?=
 =?utf-8?B?VEM1eGx3M3hHUi9hNTJycUVJdE4xTTFPWFRzNUVJQlorbHlrUnJGY0JxQVFT?=
 =?utf-8?B?SXlqbnptSFhNNFFLY29Fb091bTFmSTlVZm8vVmdOUG9GdmVCTStCRUUzVjFm?=
 =?utf-8?B?WGZ5ck1NdkpTYmhDYStRKzdldGhiNkt0b1MwU2pHVWtDZm40em1qRnRNODVS?=
 =?utf-8?B?SGZmQWJVWnNGcnJoL1gzQ25QMTF2ZGdIWmZNcUR1TkJXdmhPeWRzOTBMbG42?=
 =?utf-8?B?NFJ4ZWdVa2hZZ2MzUWt2V1dZZFN5dGIvQW42S2I1L1hVK2NreEQydUxraWh0?=
 =?utf-8?Q?abtbZEGNcax37UsH5wbMfRs48?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b8b5c6-9255-4510-7c20-08ddb5466805
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 06:46:55.3823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hWb17LnVa1699MkYnZhoPvmFpL5xW93LIBt+/5xFUb5J+qh9QPXnkRglsSVivmFlufCagE14AfIzFO0mFjEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3988
X-Proofpoint-GUID: oiBhQwe_TxD_0s7Bn4HsFUfDGhDDFBlW
X-Authority-Analysis: v=2.4 cv=L7AdQ/T8 c=1 sm=1 tr=0 ts=685e3e63 cx=c_pps
 a=IV+WtIWHodmRHiAFYf0x/g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=0FD05c-RAAAA:8 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=tVFN9ap9uLDKirSBoNsA:9 a=QEXdDO2ut3YA:10
 a=l1rpMCqCXRGZwUSuRcM3:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA1MyBTYWx0ZWRfX6DkKF66tnMWX
 9w/gfXBAoFQ4uGg61AEfgOOFcVOqEQjXPs1YvwhDrnIglieKJmN6aNoDhdit6Wcgo7ZK03TVCxc
 cDzvYyWXGf0oYheHhpoeNWc9DYTRjwytctvtpJgxQqIwf5JOH2sxqULXzqSI5CxDUsATW0uKJHx
 ULH0i1H6HQ+avxuI1l2cqteRtAPYdLrknmhqbHS3sIwE/0b7DOXVMmhPaWIblNuFoQhpM9vWZOE
 Hx9HMTyewwe1CzE9v2eTpNjxf3Nqj0Cbtb1dsuSV1lFBiWbAt6P+3kHaqYpAqkQ3hvvFbnG0/YZ
 R3Ico78GixTe94onROKGzO+mRjirpj3cS7ETyrDNu7jpO3fggFI4eIglNB4oBmwV+7lhu+NoYr6
 dCNQ9swbnOj8S2ZGT1ePfVBR8kXQ4k/upWDiCMNMSNKWXTGsSNGtw+8ENNtNyVVXSrt+/inh
X-Proofpoint-ORIG-GUID: oiBhQwe_TxD_0s7Bn4HsFUfDGhDDFBlW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_02,2025-06-26_05,2025-03-28_01
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGlhcyBSw7ZubmJs
b20gPG1hdHRpYXMucm9ubmJsb21AZXJpY3Nzb24uY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVu
ZSAyNiwgMjAyNSA3OjQ5IFBNDQo+IFRvOiBKZXJpbiBKYWNvYiA8amVyaW5qQG1hcnZlbGwuY29t
Pg0KPiBDYzogZGV2QGRwZGsub3JnOyBNYXR0aWFzIFLDtm5uYmxvbSA8aG9mb3JzQGx5c2F0b3Iu
bGl1LnNlPjsgTWF0dGlhcw0KPiBSw7ZubmJsb20gPG1hdHRpYXMucm9ubmJsb21AZXJpY3Nzb24u
Y29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCB2Ml0gZXZlbnRkZXY6IG1ha2UgZmxh
ZyB0eXBlcyBjb25zaXN0ZW50IHdpdGggQVBJDQo+IA0KPiBNYWtlIFJURV9FVkVOVF9ERVZfQ0FQ
XyogZmxhZ3MnIHR5cGUgY29uc2lzdGVudCB3aXRoIHRoZQ0KPiBydGVfZXZlbnRfZGV2X2luZm8u
4oCKZXZlbnRfZGV2X2NhcCdzIHR5cGUuIE1ha2UNCj4gUlRFX0VWRU5UX0RFVl9DRkdfUEVSX0RF
UVVFVUVfVElNRU9VVCBjb25zaXN0ZW50IHdpdGgNCj4gcnRlX2V2ZW50X2Rldl9jb25maWcu4oCK
ZXZlbnRfZGV2X2NmZy4gTWFrZSBSVEVfRVZFTlRfUVVFVUVfQ0ZHXyoNCj4gY29uc2lzdGVudCB3
aXRoIHJ0ZV9ldmVudF9xdWV1ZV9jb25mLuKAimV2ZW50X3F1ZXVlX2NmZy4NCj4gWmpRY21RUllG
cGZwdEJhbm5lclN0YXJ0IFByaW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4dGVybmFsIGVtYWlsczoN
Cj4gQ29uZmlybSBzZW5kZXIgYW5kIGNvbnRlbnQgc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5r
cyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzDQo+IDxodHRwczovL3VzLXBoaXNoYWxhcm0tDQo+IGV3
dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhrcVchdHMzWjFmOFVBblVhdE0tDQo+IGNPZnhh
N281VEVKNV9FU3JGb2RldVVtUC1MRHQ4V3lIZUJ5NmlRTlRSalkwQVJTZHdTRC0NCj4gYVh5X1Ns
RmRRRW44Y010aUpkbHpXa3M0eVNMeEVjbEEtUzhnQ0tBJD4NCj4gUmVwb3J0IFN1c3BpY2lvdXMN
Cj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gTWFrZSBSVEVfRVZFTlRfREVWX0NBUF8q
IGZsYWdzJyB0eXBlIGNvbnNpc3RlbnQgd2l0aCB0aGUNCj4gcnRlX2V2ZW50X2Rldl9pbmZvLmV2
ZW50X2Rldl9jYXAncyB0eXBlLg0KPiANCj4gTWFrZSBSVEVfRVZFTlRfREVWX0NGR19QRVJfREVR
VUVVRV9USU1FT1VUIGNvbnNpc3RlbnQgd2l0aA0KPiBydGVfZXZlbnRfZGV2X2NvbmZpZy5ldmVu
dF9kZXZfY2ZnLg0KPiANCj4gTWFrZSBSVEVfRVZFTlRfUVVFVUVfQ0ZHXyogY29uc2lzdGVudCB3
aXRoDQo+IHJ0ZV9ldmVudF9xdWV1ZV9jb25mLmV2ZW50X3F1ZXVlX2NmZy4NCj4gDQo+IE1ha2Ug
UlRFX0VWRU5UX1BPUlRfQ0ZHXyogY29uc2lzdGVudCB3aXRoDQo+IHJ0ZV9ldmVudF9wb3J0X2Nv
bmYuZXZlbnRfcG9ydF9jZmcuDQo+IA0KPiBNYWtlIFJURV9FVkVOVF9USU1FUl9BREFQVEVSX0NB
UF8qIGNvbnNpc3RlbnQgd2l0aCB0aGUgY2FwcyBwYXJhbWV0ZXINCj4gaW4gcnRlX2V2ZW50X2V0
aF9yeF9hZGFwdGVyX2NhcHNfZ2V0KCkuDQo+IA0KPiBUaGUgZmxhZ3Mgd2VyZSBhbGwgdW5zaWdu
ZWQgbG9uZyBsb25ncyAoNjQgYml0cyksIGJ1dCB0aGUgZXZlbnRfZGV2X2NhcCwNCj4gZXZlbnRf
ZGV2X2NmZywgZXZlbnRfcXVldWVfY2ZnLCBhbmQgZXZlbnRfcG9ydF9jZmcgZmllbGRzIGFuZCB0
aGUgY2Fwcw0KPiBwYXJhbWV0ZXIgYXJlIGFsbCB1aW50MzJfdC4gVGhpcyBjaGFuZ2UgbWFrZXMg
dGhlIGZsYWdzIHVpbnQzMl90cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRpYXMgUsO2bm5i
bG9tIDxtYXR0aWFzLnJvbm5ibG9tQGVyaWNzc29uLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEplcmlu
IEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+DQoNClVwZGF0ZWQgdGhlIGdpdCBjb21taXQgYXMg
Zm9sbG93cyBhbmQgYXBwbGllZCB0byBkcGRrLW5leHQtbmV0LWV2ZW50ZGV2L2Zvci1tYWluLiBU
aGFua3MNCg0KICAgIGV2ZW50ZGV2OiBmaXggZmxhZyB0eXBlcyBjb25zaXN0ZW5jeQ0KDQogICAg
TWFrZSBSVEVfRVZFTlRfREVWX0NBUF8qIGZsYWdzJyB0eXBlIGNvbnNpc3RlbnQgd2l0aCB0aGUN
CiAgICBydGVfZXZlbnRfZGV2X2luZm8uZXZlbnRfZGV2X2NhcCdzIHR5cGUuDQoNCiAgICBNYWtl
IFJURV9FVkVOVF9ERVZfQ0ZHX1BFUl9ERVFVRVVFX1RJTUVPVVQgY29uc2lzdGVudCB3aXRoDQog
ICAgcnRlX2V2ZW50X2Rldl9jb25maWcuZXZlbnRfZGV2X2NmZy4NCg0KICAgIE1ha2UgUlRFX0VW
RU5UX1FVRVVFX0NGR18qIGNvbnNpc3RlbnQgd2l0aA0KICAgIHJ0ZV9ldmVudF9xdWV1ZV9jb25m
LmV2ZW50X3F1ZXVlX2NmZy4NCg0KICAgIE1ha2UgUlRFX0VWRU5UX1BPUlRfQ0ZHXyogY29uc2lz
dGVudCB3aXRoDQogICAgcnRlX2V2ZW50X3BvcnRfY29uZi5ldmVudF9wb3J0X2NmZy4NCg0KICAg
IE1ha2UgUlRFX0VWRU5UX1RJTUVSX0FEQVBURVJfQ0FQXyogY29uc2lzdGVudCB3aXRoIHRoZSBj
YXBzIHBhcmFtZXRlcg0KICAgIGluIHJ0ZV9ldmVudF9ldGhfcnhfYWRhcHRlcl9jYXBzX2dldCgp
Lg0KDQogICAgVGhlIGZsYWdzIHdlcmUgYWxsIHVuc2lnbmVkIGxvbmcgbG9uZ3MgKDY0IGJpdHMp
LCBidXQgdGhlDQogICAgZXZlbnRfZGV2X2NhcCwgZXZlbnRfZGV2X2NmZywgZXZlbnRfcXVldWVf
Y2ZnLCBhbmQgZXZlbnRfcG9ydF9jZmcNCiAgICBmaWVsZHMgYW5kIHRoZSBjYXBzIHBhcmFtZXRl
ciBhcmUgYWxsIHVpbnQzMl90LiBUaGlzIGNoYW5nZSBtYWtlcyB0aGUNCiAgICBmbGFncyB1aW50
MzJfdHMuDQoNCiAgICBGaXhlczogNzFmMjM4NDMyODY1ICgiZXZlbnRkZXY6IGludHJvZHVjZSBl
dmVudCBkcml2ZW4gcHJvZ3JhbW1pbmcgbW9kZWwiKQ0KICAgIEZpeGVzOiA3M2U2YjhjOTNkY2Eg
KCJldmVudGRldjogaW50cm9kdWNlIGJ1cnN0IG1vZGUgY2FwYWJpbGl0eSIpDQogICAgRml4ZXM6
IGVjMzZkODgxZjU2ZCAoImV2ZW50ZGV2OiBhZGQgaW1wbGljaXQgcmVsZWFzZSBkaXNhYmxlIGNh
cGFiaWxpdHkiKQ0KICAgIEZpeGVzOiAyOTY1M2E3YmZlYzEgKCJldmVudGRldjogZXh0ZW5kIGNh
cGFiaWxpdHkgZmxhZ3MiKQ0KICAgIEZpeGVzOiBiZDk5MTg5NzI0YjggKCJldmVudGRldjogbmVn
YXRlIG1haW50ZW5hbmNlIGNhcGFiaWxpdHkgZmxhZyIpDQogICAgRml4ZXM6IGQwMDdhN2YzOWRl
MyAoImV2ZW50ZGV2OiBpbnRyb2R1Y2UgbGluayBwcm9maWxlcyIpDQogICAgRml4ZXM6IGFjYzY1
ZWUzMDdmNyAoImV2ZW50ZGV2OiBpbnRyb2R1Y2UgZXZlbnQgcHJlLXNjaGVkdWxpbmciKQ0KICAg
IEZpeGVzOiBjMWJkZDg2ZDA0ZDEgKCJldmVudGRldjogYWRkIGV2ZW50IHBvcnQgcHJlLXNjaGVk
dWxlIG1vZGlmeSIpDQogICAgRml4ZXM6IGFjYzY1ZWUzMDdmNyAoImV2ZW50ZGV2OiBpbnRyb2R1
Y2UgZXZlbnQgcHJlLXNjaGVkdWxpbmciKQ0KICAgIEZpeGVzOiA0N2QwNWIyOTI4MjAgKCJldmVu
dGRldjogYWRkIHRpbWVyIGFkYXB0ZXIgY29tbW9uIGNvZGUiKQ0KICAgIENjOiBzdGFibGVAZHBk
ay5vcmcNCg0KICAgIFNpZ25lZC1vZmYtYnk6IE1hdHRpYXMgUsO2bm5ibG9tIDxtYXR0aWFzLnJv
bm5ibG9tQGVyaWNzc29uLmNvbT4NCiAgICBSZXZpZXdlZC1ieTogSmVyaW4gSmFjb2IgPGplcmlu
akBtYXJ2ZWxsLmNvbT4NCg0KDQo=
