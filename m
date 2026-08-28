Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3AC61DCB
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 22:44:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BD3D4025A;
	Sat, 29 Aug 2026 00:44:49 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id CF58340151;
 Sat, 29 Aug 2026 00:44:47 +0200 (CEST)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMbex0295609; Fri, 28 Aug 2026 18:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=6
 L5wEIszW9pANIh0nrH8IV9JKTwMbwXCJLHILdhWbfA=; b=xECKnyHJemA+Do7RR
 xzi+FK/leqjhQy6Ow/NCzZ9LZG3uCy1k9mfLRjqSGhffM1bTm8XipgXROFwEB50u
 EZiXo5CqZ1BnVp081BGWpMHi4bfWOHpAZ1L5cdCUtei8C7Iq6wEi2HLifCgr27bK
 z/Ka0VL/O4oY71g7HzUsT8wNRy1xDIZhpz06bDxpq2i2HOCqnoN5vxuuhexu/Kuc
 SutTe8tMsYqQiYXwyKwwwbxggN33I1fIrchwtoXyrPGermkqLfYOQjjnytn5SExg
 VrYSLug9zM1KY7wp/frRALYXTrvCWQPmV5veK3jE3iz9dWEc8uzZr6UOBzX9ktOn
 6FJ1w==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4g77sewep9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 18:44:46 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMUCSn2601326; Fri, 28 Aug 2026 18:44:46 -0400
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gbhd799au-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 18:44:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsNSDbX4quyCpnT14T3eKPoCodrqGHTkgt40i9epEJL8WZ3xiaXCBnQoskWuc2TyHcI8k30H0ZndYRQHTbDwxu/bvDXVXvtwryqlkqTCZjnaqwRbSZQ8jVxjwc4f5XnhAsjH1aIlJ+r6Cjor6LP5W7QL9WPoCKcR4wpH0aYgeHvoeIvXbDFk8oc7iLxkQ9inpDJoD4q9etY1/mpbqqfWF1csVD5QU2vtr95u7eMK0h2cQOGJESYWi9mnTB0GXmdaMf6uMwRTDmZHPvqOZuqo3jxT5yTkt9kyfLEjY0NYD55mCRfqwSjj8R3CkwVLcV9xlE03dnvrWi/qtOehzFjcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6L5wEIszW9pANIh0nrH8IV9JKTwMbwXCJLHILdhWbfA=;
 b=syVY1v3TQfY3yWHPV/nDBTc5W7chgaf58gBdlz8IbRGoqFLzj3tgI9ecVGFdaFurX3KZb7skcBXgyX49tuM+42k4Egbjjl20g3ihFzPWHbh9/cE23TqjEmyEJcHydvEtexi/rvvm0zXXmoJjkASOZ/9FRdbXU4JjWpavSReuDAK5F686TKRLunUoeWAe/sdBB/zHdgVCYW6YtcEiIE98VrF0rSMUeJi4CvqefADr+iL0qhI0EotzVTWtb6H/AaH98sAC57Jy8Kq0WBIotuZhZXaJJSYiy2wg0gM3oK7bi0fqiehsQhnvnUEY2qu5CoK2Sf7N7LBkkvBbhHLh6WfgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::ca9) by SA1PR19MB6670.namprd19.prod.outlook.com
 (2603:10b6:806:259::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 28 Aug
 2026 22:44:39 +0000
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267]) by IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267%8]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 22:44:39 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Topic: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Index: AQHdIJqmnf1/7bON30W14JW0Wc3J87aHKHoAgAAJu2CAAAjrgIAAC/nAgAB6AwCAAB4JQIALQ3EggCEZjTA=
Date: Fri, 28 Aug 2026 22:44:38 +0000
Message-ID: <IA0PPF659BD4C460C43728C6C7E57AC109EF5AC2@IA0PPF659BD4C46.namprd19.prod.outlook.com>
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
 <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
 <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <CAJFAV8xPCRAerr-goiD5UbxPjmy5ddyb0ew8FK+nZMdu_g1kDQ@mail.gmail.com>
 <IA0PPF659BD4C46C174C843A7FE6C0208C2F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <20260731082756.31f7a9d8@phoenix.local>
 <IA0PPF659BD4C4653EA823F77F74FBFEE61F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <IA0PPF659BD4C465FE225045F03A10056E2F5D12@IA0PPF659BD4C46.namprd19.prod.outlook.com>
In-Reply-To: <IA0PPF659BD4C465FE225045F03A10056E2F5D12@IA0PPF659BD4C46.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-07-31T17:15:25.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF659BD4C46:EE_|SA1PR19MB6670:EE_
x-ms-office365-filtering-correlation-id: 0679557f-5f9c-49c5-91f2-08df0555f161
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|786006|366016|376014|56012099006|10067099003|4143699003|18002099003|6133799003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: deqCxKkN5TXcwoy9z5FGDudZ0wZwLz/mSBhqjwl3W6XsCJtlVc1hjotbazNejWOEUbyKTNhAq+9kViW/Q1Zd5uAXItCco9UD3LQpgCUf1J0QZIdrs/Flz0QmafRWZXiAOWMFgbtoAO/WXNo1zoIryBtljJctqzydvYRrsVTAdKkMfmQKAx7FWWpYckQqUbJ1RsiaL8z1491VEuPy/Fwj/kZUfgcobiM9Rp+eRvwutUCqaXOxgYZR7g1Q5zJJKmBv13dWbkmmJdsTLfJLtNv0/qUosSQhYsSPoWGzKMmtYcuV1uyOt49tICIOtM5GGdoUbp7L3k4nOMSqk+AI4WvgTViUmIRuryt50k7U4Z+13knobfSMwEKLlH/2b8RbOHRsdMnVj7R9SW1yzAgk1vXENvmklFBhmkRHYzUk5wL/wX+vhu7PaRZ6Tj7sKAaKXRWvjR0nO8MlyWxLKgusqjvhKHc63i75ge9MKA4GDwiQIVBY9mZl0vFrAeIrZ1zN7ZvUcT37HeKSruEM+eHmiDV5uGpXfBR5Mx0ZU2Ph/f5dOXt/fote3P5FjsGh+LieRwKU3Gh3qvjPp+DBspoBzfSBsEno7eXnpxUlNr9fiJQkJoVCEObHqDIfq+q6A5hENKVY8M4cO/gNxlop9Mun/ly5kDU4Okpzf7SznIRfz/xPfyzblu7SBnLs938R2ADxflCHeXLntUrhQEPeNz9oA5NMNCM8DNwmBr4o7wH6ot/kFKA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF659BD4C46.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(786006)(366016)(376014)(56012099006)(10067099003)(4143699003)(18002099003)(6133799003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1FzZ0V3MFhjRzh5anVoQURkS1o1UFVVSDRQUk9BMFNpWmt6N1dwcEJLbDNV?=
 =?utf-8?B?N2k0Vk5HaUp4d2VteFZnamgxQWVEN2lUcG1GVXc3M254YXk0QUpvU3IvTmhn?=
 =?utf-8?B?djBPem95Z3NGOGRtWFVUQk15cEVnOTdGcFQ4cXNqVC8wUGJCbnVtQURMbHhn?=
 =?utf-8?B?Vnd1SXUzRlExSVcyWVBFeTMwZmk1M3BsWUxyMGpOOWdjWW5acEFBM01rbng2?=
 =?utf-8?B?ZjQ0ZG01c0dab0pFNW1qYlFJSzZUREE4RUp4dWNZM29nKzVWNEUxamJRNkNJ?=
 =?utf-8?B?R25MT3BCK09uZm1LRTE1ZzdRWjRMTkw2SFB1c0FQSnZGZmFYeXVFOEQ1ZVkx?=
 =?utf-8?B?Y0QyYnRIL3RDTU01MUJXMDZlS1g3WDN6TDMrZW1LL3EzbFZlQ0g3bkxuNHNJ?=
 =?utf-8?B?QkFUWkZ4aWdQamRtWktHVmJXVGNVS2JFT3pOZWhvbHBsbEY4aVpZTlVPV25T?=
 =?utf-8?B?cjZzSkI5UEtpS0UvOGVhVWpjZzl0aEVsKzZUMVV5NE1DM2M1Yk84TWg2Uzls?=
 =?utf-8?B?QUhWekdsL3Vsa2VDdkxSTG5CWEZ3c3N6L21STmg3TVdzWkIzdnMrZno0RXZS?=
 =?utf-8?B?L2Y2Z2ZLV01JTmh0VmM0b3RyMTZyNWVVaG1CSWY1OHV5NThiMzNyVHRob0JX?=
 =?utf-8?B?VHlMKzBsNzBCZVg2RFlnck1nNzNKSEhoUjU1RmhJMjRySHA3OEdybm05RlFo?=
 =?utf-8?B?NUQ1N08wa1N4OW9BQTBVZ3RvT1MwZnRXcmRMYm1HV2dweFZBOTJ0Z3hiLzMw?=
 =?utf-8?B?Sm00b0NQWldlZ01yT0Iza1VpZ21qbjFUcXZmSlluc2p4cWVlNE1SL0diajRW?=
 =?utf-8?B?Y0xqNGRBMzBqUDBvV0doKzVhakdSdGxRL2c5M1NJVDVpeTNNMmF2dlI4TEpK?=
 =?utf-8?B?MllucFJzQktoaGU2V3JZemF4dm9wcG5EYlZBMHJISFRMeFJ6REZVL3ZzdXRs?=
 =?utf-8?B?MWZWWFhVZGZUSi8wUlBmR3dKanZUUVpMK0pxMFpDVzhRVy9yWHU2N2ZmS1l4?=
 =?utf-8?B?OFA3REludWtyeXNMd1pJd2EyTk1iWE90YnI5TVIraCs5RmpMTENOanFhTWF5?=
 =?utf-8?B?alhHb1BaWjVJMjl0TDN6Tm1VQnM0WXU2OEJ2SG9uTkVNNTEzWWw3SFpibHZa?=
 =?utf-8?B?eS9nYzNKUkdPdnNqd1JXbTBnQ3R3UkliM1R0Rm5aM3JQWWZLZUdqVUcxL3B6?=
 =?utf-8?B?QklwOUk3a3QybkppQytNUm5sbUplcGd2WTl5UUdXTUxDUXF0b1dYOGhTNXNv?=
 =?utf-8?B?QjV6aTZXeVVBRndFNTkyanppWjhoQjZDVzR4b3ZGeTQrckpqWUtha3dGV044?=
 =?utf-8?B?a1FjWm1Jc3hNQWFXWFVHWjZxOHRjd0RqT2NSR3ljbHlLL0lUaDI2TE8wdTlm?=
 =?utf-8?B?TmdPaUZDOU1rR2FqZTVJMllHOUcrdkxxSHlpNVhxUy84K3dybkV6MklXMkg2?=
 =?utf-8?B?cUdnV2diNTNZSlAveWhTRzF2ODZnYVV6dEg0bmFaamdzL1ovbGJ6cXVrQXlu?=
 =?utf-8?B?MTV0OWwrbEkvSW1HYVFlS3htV3Jrcko5U0hwZXpnSzhOMHhHRis2YWh5U1hK?=
 =?utf-8?B?RGdFM0dTSTh4bW5uZnhqWCthZ2xJLzdXSERsSTlvQnZXd3RlTmk1VWpFSGhF?=
 =?utf-8?B?b2UveTFyYlBMaWF6UlhTUjJ0MFpURFJmRDRpMkRVT21pM2hjdVUwdWt1N0hk?=
 =?utf-8?B?Q05CcHZjVzdFQmZDSnQ0YWdZQjlKT1M1NGp4VW5lR09VSFI5dk16dnBLcWpG?=
 =?utf-8?B?SFI1aHpSRnBlVXZKRVNaZGQ3dnB3dVRyVHNkSTFkT2xWTU1CcnNjY0t3OHA2?=
 =?utf-8?B?UzdMalhiODVLOU5uQWdteG9SeFdRcTM0SW5Vdyt3V2k3S2l5anR5cFdqLy9Y?=
 =?utf-8?B?eU16TlB5SFVkd1Byam8zc0d4SDJWYUJYU2dCdDNzR3pjeno3RnlJWnYyWDFl?=
 =?utf-8?B?Y1dzOTM5WUl6cFRna2RtUWk5Tm50Y2MxeFlIMmlFS3dWbWFWUnBLMWthM3I2?=
 =?utf-8?B?cGR2K0tDTDA2NUo3U1h0S2UrdThqR0xua2JudXh0ZWI1VmNrSkJ3ckpSSGxT?=
 =?utf-8?B?dW14SGF5aDhzNHJFQWFiN2ExUDhaU21xSHdJQjJ6WDJTK1p4bjRxWmMxcGNm?=
 =?utf-8?B?dzNZbHVOdU9aQXM0cDNJSmd2dVR4ZGRGRHNYc2JLZWtRZHVGTWJrcGwwTkwv?=
 =?utf-8?B?b3JJSnh4QVdCS3QwYWUvOGpGM1B4MnVTTkVlcnM0VmxKTHdiNEozR2tIbCtw?=
 =?utf-8?B?QTlaVTNtcGM1UXV4QzhGSDBDQkFucjZVaWtMbERGRWRFWTNHZHAyZmtPUHpD?=
 =?utf-8?B?ODdNb1pQamU3Rm16MFI3OCtVSHBPaEdEb3l5UVE0L21VQzR5ZnRtQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i2TlKFOn1GrItLUmnUH6iatSkMEtr1qojAnslLpq/kSRwIpMzecJBUL15SZk7Puqs0ewDsMFJDbd2W9DhaaNJCexc7SPC6DTVHHft/xQ05USAhHjsrWUNOXjzfRyi70/NNce8eTI2QnEodlXjpxdFif23/7tQzK5C9/BUoSAD/c+2StCle/JpSBWkhSTxWDBCZk6qXRuMk3H2xnEAwwoYaxWqjOjczYlPyBP5taWGFPhc8fib7LH47LrY+ULRLidNmBjYUyEHxW3YcbE2GNAkaFK//SWEam1o7KoA4I6DxzC+qti3g6YT5B35W/d7JzWcfQCpzeXPekInY7dzvb0JQ==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF659BD4C46.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0679557f-5f9c-49c5-91f2-08df0555f161
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 22:44:38.9695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHRBnjXkcSPhi6gP9HHjVXRtQRfOnr1F59ETI3OdE/ycEcMbBaz8QgL2LL+akFMYzm5WC0mWW8gikb+Zps/FKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB6670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280198
X-Proofpoint-GUID: YKHv8Kedc8QSym5V-eJ166tLpjBOwJTa
X-Authority-Analysis: v=2.4 cv=AobeGu9P c=1 sm=1 tr=0 ts=6a920f5e cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=PpEg0BoV_A2aca28hXd0:22 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8
 a=bt5KbKNvAAAA:8 a=jZVsG21pAAAA:8 a=iLNU1ar6AAAA:8 a=-xIEic8OkpRuXnkEwqgA:9
 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-ORIG-GUID: YKHv8Kedc8QSym5V-eJ166tLpjBOwJTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE5NSBTYWx0ZWRfX0bAa+3Ipl5tN
 VSHmha6u1UUYfqwT6DGgDbcVNu7b4acg6OTy6jQQ+27CMAxrQSkGw4x2la6AJogq2yRmgI9Qt3+
 YjQD1Ywuv84j2wkVN/Fb8iInjRKU0ySR8ysTVYC2yuQMNMfWK4kfGyKhW4nSwgBmjcMh/GZMdPI
 VIN2/FTRqwB6lg6ililjiZKRUewH+hGyqRQjCtnhYcVJG7oQ3OdH+d6tHMdq8DFRg+WRCOacOA7
 HL8fyfo8zTPyXnYq4NXyDw7yvaA3cLsP/Mc1AGOSi3/42zgklgl3Y3WWZDD+/TOmesG0JAZK1qs
 3AfqFo5VsGCLdtI0J/xSd6ewfqck21CQ1nOSDQEnzqIU974bAcZLgKBqfFG+hrODkVZGH3zT80t
 kPm9AdTRp2fwQrr1CZ0VDXBfjBzYXXyD4mTWG4HT1NQS4P1EbHrJhiOaKyIi0rjlDX+vNB0Dnpj
 MqvmTIFotVGXNaKiG8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE5NSBTYWx0ZWRfXy27loAGNhOx7
 sg+scAh4VVp3nqozUhaTrD5+YeqaWJ38wxdJUAgdNGlujC5Ut8WBKMdNFgovOi2T7TFdWWIFAmC
 2MBtpdpMGpS+ahlmDWc5GNcY8GFetoY=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280195
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

SGkgTWF4aW1lLA0KDQpHZW50bGUgcmVtaW5kZXIgYW5kIGZvbGxvdyB1cCBmb3IgdGhpcyBwYXRj
aC4NCg0KVGhhbmtzLA0KUHJhdmluDQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhdGhpamEsIFByYXZpbg0KPiBT
ZW50OiBGcmlkYXksIEF1Z3VzdCA3LCAyMDI2IDI6MTkgUE0NCj4gVG86IE1heGltZSBDb3F1ZWxp
biA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+DQo+IENjOiAnRGF2aWQgTWFyY2hhbmQnIDxk
YXZpZC5tYXJjaGFuZEByZWRoYXQuY29tPjsgJ2RldkBkcGRrLm9yZycNCj4gPGRldkBkcGRrLm9y
Zz47ICdtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbScNCj4gPG1heGltZS5jb3F1ZWxpbkByZWRo
YXQuY29tPjsgJ2ZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tJw0KPiA8ZmVuZ2NoZW5nd2VuQGh1YXdl
aS5jb20+OyAnc3RhYmxlQGRwZGsub3JnJyA8c3RhYmxlQGRwZGsub3JnPjsNCj4gJ3Rob21hc0Bt
b25qYWxvbi5uZXQnIDx0aG9tYXNAbW9uamFsb24ubmV0PjsgU3RlcGhlbiBIZW1taW5nZXINCj4g
PHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDEv
MV0gdmhvc3Q6IHRvbGVyYXRlIGZpbGUgZGVzY3JpcHRvciBpbiBSRU1fTUVNX1JFRw0KPiBtc2cN
Cj4NCj4gSGkgTWF4aW1lLA0KPg0KPiBJIG5vdGljZWQgdGhpcyBwYXRjaCBpcyBkZWxlZ2F0ZWQg
dG8geW91LiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2gNCj4gYW5kIHBy
b3ZpZGUgZmVlZGJhY2sgPw0KPg0KPiBJJ20gaG9waW5nIGZvciB0aGlzIG9uZSBsaW5lIGNoYW5n
ZSB0byBiZSBtZXJnZWQgc29vbiBpbnRvIG1haW5saW5lIGFuZCB0bw0KPiAyNi4wNyBzdGFibGUg
c28gaXQgd2lsbCBtYWtlIHRoZSB1cGNvbWluZyBTUERLIHJlbGVhc2Ugd2hlcmUgaXQgd2lsbCBi
ZSBjcml0aWNhbA0KPiBmZWF0dXJlIGZvciB0aGUgdmhvc3QvbGliYmxraW8gc3VwcG9ydC4NCj4N
Cj4gTXVjaCBhcHByZWNpYXRlZCENCj4NCj4gUmVnYXJkcywNCj4gUHJhdmluDQo+DQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBCYXRoaWphLCBQcmF2aW4NCj4gPiBT
ZW50OiBGcmlkYXksIEp1bHkgMzEsIDIwMjYgMTA6MTYgQU0NCj4gPiBUbzogU3RlcGhlbiBIZW1t
aW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiA+IENjOiBEYXZpZCBNYXJjaGFu
ZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT47IGRldkBkcGRrLm9yZzsNCj4gPiBtYXhpbWUu
Y29xdWVsaW5AcmVkaGF0LmNvbTsgZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb207DQo+IHN0YWJsZUBk
cGRrLm9yZzsNCj4gPiB0aG9tYXNAbW9uamFsb24ubmV0DQo+ID4gU3ViamVjdDogUkU6IFtQQVRD
SCB2MiAxLzFdIHZob3N0OiB0b2xlcmF0ZSBmaWxlIGRlc2NyaXB0b3IgaW4NCj4gPiBSRU1fTUVN
X1JFRyBtc2cNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5v
cmc+DQo+ID4gPiBTZW50OiBGcmlkYXksIEp1bHkgMzEsIDIwMjYgODoyOCBBTQ0KPiA+ID4gVG86
IEJhdGhpamEsIFByYXZpbiA8UHJhdmluLkJhdGhpamFAZGVsbC5jb20+DQo+ID4gPiBDYzogRGF2
aWQgTWFyY2hhbmQgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+OyBkZXZAZHBkay5vcmc7DQo+
ID4gPiBtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbTsgZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb207
DQo+ID4gc3RhYmxlQGRwZGsub3JnOw0KPiA+ID4gdGhvbWFzQG1vbmphbG9uLm5ldA0KPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzFdIHZob3N0OiB0b2xlcmF0ZSBmaWxlIGRlc2NyaXB0
b3IgaW4NCj4gPiA+IFJFTV9NRU1fUkVHIG1zZw0KPiA+ID4NCj4gPiA+DQo+ID4gPiBbRVhURVJO
QUwgRU1BSUxdDQo+ID4gPg0KPiA+ID4gT24gRnJpLCAzMSBKdWwgMjAyNiAwODoxOTowNyArMDAw
MA0KPiA+ID4gIkJhdGhpamEsIFByYXZpbiIgPFByYXZpbi5CYXRoaWphQGRlbGwuY29tPiB3cm90
ZToNCj4gPiA+DQo+ID4gPiA+ID4gPiBXaGlsZSB0aGUgaW1tZWRpYXRlIG1vdGl2YXRpb24gd2Fz
IGxpYmJsa2lvLCB0aGUgc3BlYydzDQo+ID4gPiA+ID4gPiBjb21wYXRpYmlsaXR5IGNsYXVzZSB3
YXMgd3JpdHRlbiBmb3IgZXhhY3RseSB0aGlzIHNpdHVhdGlvbiDigJQNCj4gPiA+ID4gPiA+IGFu
eSBmcm9udC1lbmQgY291bGQgbWFrZSB0aGUgc2FtZSBtaXN0YWtlLiBRRU1VJ3MNCj4gPiA+ID4g
PiA+IGxpYnZob3N0LXVzZXIgcmVmZXJlbmNlIGltcGxlbWVudGF0aW9uDQo+ID4gPiA+ID4gYWxy
ZWFkeSB0b2xlcmF0ZXMgaXQgKHNlZSB2dV9yZW1fbWVtX3JlZykuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBXaGljaCBkb2VzIG5vdCBjaGFuZ2UgdGhhdCBJIGRpc2xpa2Ugc3VjaCBjb21wYXQuDQo+
ID4gPiA+DQo+ID4gPiA+IEkgY291bGRuJ3QgYWdyZWUgd2l0aCB5b3UgbW9yZS4gIFRoZSBsaWJi
bGtpbyBmaXggaXMgcmVhZHkgYW5kDQo+ID4gPiA+IHdpbGwgc3RvcCBzZW5kaW5nDQo+ID4gPiB0
aGUgZmQuDQo+ID4gPiA+IEluIGFuIGlkZWFsIHdvcmxkIHdlJ2QgZml4IGxpYmJsa2lvIGFuZCBt
b3ZlIG9uLCAgYnV0IHRoZXJlIGFyZQ0KPiA+ID4gPiBhbHJlYWR5IHNldmVyYWwgcmVsZWFzZWQg
dmVyc2lvbnMgb2YgbGliYmxraW8gaW4gdGhlIHdpbGQgdGhhdA0KPiA+ID4gPiBleGhpYml0IHRo
aXMgYmVoYXZpb3IuICBVc2VycyBwYWlyaW5nIHRob3NlIHdpdGggYSBjdXJyZW50IERQREsNCj4g
PiA+ID4gd2lsbCBoaXQgYSBicm9rZW4NCj4gPiA+IGNvbm5lY3Rpb24gd2l0aCBubyBvYnZpb3Vz
IHdvcmthcm91bmQuDQo+ID4gPg0KPiA+ID4gSU1ITyBzZWN1cml0eSBzYWZldHkgdHJ1bXBzIHRo
ZSBzcGVjaWZpY2F0aW9uIGluIHRoaXMgY2FzZS4NCj4gPiA+IEFsdGhvdWdoIGl0IG1pZ2h0IGhl
bHAgdG8gZG9jdW1lbnQgdGhpcyBzb21ld2hlcmUgYW5kIGFkZCBhIGJldHRlcg0KPiA+IG1lc3Nh
Z2UuDQo+ID4NCj4gPiBBZ3JlZWQgdGhhdCBzZWN1cml0eSBjb21lcyBmaXJzdC4gVGhlIHBhdGNo
IGRvZXMgY2xvc2UgdGhlIGZkDQo+ID4gaW1tZWRpYXRlbHkgdmlhIGNsb3NlX21zZ19mZHMoY3R4
KSwgc28gdGhlcmUncyBubyBsZWFrIHJpc2suIEhhcHB5IHRvDQo+ID4gYWRkIGEgbG9nIG1lc3Nh
Z2Ugc28gaXQncyB2aXNpYmxlIHdoZW4gYSBmcm9udC1lbmQgc2VuZHMgYW4gdW5leHBlY3RlZCBm
ZC4NCj4gU29tZXRoaW5nIGxpa2U6DQo+ID4NCj4gPiBpZiAoY3R4LT5mZF9udW0gPiAwKQ0KPiA+
ICAgICBWSE9TVF9DT05GSUdfTE9HKGRldi0+aWZuYW1lLCBXQVJOSU5HLA0KPiA+ICAgICAgICAg
IlJFTV9NRU1fUkVHIHJlY2VpdmVkIHdpdGggJWQgdW5leHBlY3RlZCBmZChzKSwgY2xvc2luZyIs
DQo+ID4gICAgICAgICBjdHgtPmZkX251bSk7DQo+ID4gY2xvc2VfbXNnX2ZkcyhjdHgpOw0KPiA+
DQo+ID4gV291bGQgdGhhdCBhZGRyZXNzIHlvdXIgY29uY2Vybj8gSSdsbCBpbmNsdWRlIGl0IGlu
IHY0Lg0K
