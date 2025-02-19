Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18859C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 11:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45D8240E12;
	Wed, 19 Feb 2025 12:17:30 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5058140DDC
 for <dev@dpdk.org>; Wed, 19 Feb 2025 12:17:28 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJZfJa005913;
 Wed, 19 Feb 2025 03:17:27 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44vyyuhrsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 03:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lug+Ei1QecX8zK1tNa2Xnr3nqDDwqvib6eOrAgAf50EGH9yJWfNUy6XtKPiOH16GAOI/QGHai/Lkp6zP+C//VS78WFbFKIcQjP8G9MmJ8croXmt+hRvKCUqABJdMLUtqdn4JSYeX2AifGb6Ao1TujBGvWm2BJeo4x6nsGB6I6/UwOxS8mR7lMPFuGkQyMBgcciACv7Ehg9jpNBum7/RLzL1yTxVIVi63/X/Zlmn2RKdCLQ1lPhGlknaiiVsvqaDUTxlYxsgcKaM8QjCTznxqYK83q4xA396I4GlJcpQP2/jMweDI7OBKlSlhuQojf5aMtVCJHUCtFo57VbwiRp+mXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca7r/ePkCnKtzcdF7UE1W11o7e8Y95ESFyVe6JtSDLI=;
 b=J12/cxn6LM7Ly8NYbPekWgMAuokiZvU5BpqpeuQnfdOM0H09Db4oo1FesBcGY1XCC7Vlzi8xQ6gWRNnbHII7Sp235ET4Tjhw+dRyVDJe9mZoJ82B2N1D3kcJSIh2uy/8NnpWtC1QSPoTgzUEXzr1VQstmYXgVAMVxaNHGOG+L6bP9b29ZTUVXd9v6N9Oqn6vrpYAMOrRqqdvpz0rXrR1vZvZZRHQVc03zA47oBG41bdnNRyKF1GvNK4b2bxMqWQorDmbjBRKmWJX5inwYtuIRd4IvcApW0XE0a4YcvPcD+tgKkEoyICmg0rVNFcB4yWjsaAAGIVBh/B5hcKJhbV7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca7r/ePkCnKtzcdF7UE1W11o7e8Y95ESFyVe6JtSDLI=;
 b=Oejw5KL984us2HOS7wFYTRatNwBTKZu1/iyirsDJYjMxBOE7fyj/1AX74BS1Zw/Ih3zeXeY5bhuZD58RldOqvXtHwqJy6w2VWamtICm9TnqtIhihF+f5C0gnGcQt/Yn3VqcUOJwj//LEiq3tsJo1ur8p+j4yobnNJWp8RmtZzHE=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by SA3PR18MB5649.namprd18.prod.outlook.com (2603:10b6:806:39e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 11:17:25 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 11:17:25 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: David Marchand <david.marchand@redhat.com>, Sunil Kumar Kori
 <skori@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
Thread-Topic: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
Thread-Index: AQHbe+OGbWy6TeZyxkmdpkewlQNvybNBzNGAgAARPACAAUQFAIAKCM6AgAFaiqA=
Date: Wed, 19 Feb 2025 11:17:24 +0000
Message-ID: <BY3PR18MB4785A28BA4894989867FCEA1C8C52@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-5-david.marchand@redhat.com>
 <CO6PR18MB38608A210D1A7ED6477A0700B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CAJFAV8zKFXFG9_HXzOToPvh1feVi8h5F2BBHDkHEN2_BuQwDVQ@mail.gmail.com>
 <CO6PR18MB386067633D5066F40955C023B4FC2@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CAJFAV8zLcY=XcyKHhrknedhbwUZ8Hs2_XzxpkmTmuVj-Z4XF4Q@mail.gmail.com>
In-Reply-To: <CAJFAV8zLcY=XcyKHhrknedhbwUZ8Hs2_XzxpkmTmuVj-Z4XF4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|SA3PR18MB5649:EE_
x-ms-office365-filtering-correlation-id: 1538c07c-ed5d-4ad0-37d3-08dd50d6fcbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VHBhdkN6Mm8zQ3FhRVQ5cGVQVjJER0w2VFZXQ2swdjZ0UTBpS21SWGxoTXVO?=
 =?utf-8?B?bFd3R0x0dXJ2dk1FRUU4bHkvUWxJMEpyelpvdnRmVW5yR0p5dlArczczR25r?=
 =?utf-8?B?a3N5ZEVnbkUyak0wWWNPSjFDdTE1dVNrRkc0bG9IbmwwY3hPZlJNeG5NZWRL?=
 =?utf-8?B?Y2NhVGdBNDZhREVGbFcxanUzaXV4YWZ2eDczWEFJeS92Tjc4YmpOZlFDNjJK?=
 =?utf-8?B?Z2hET3hYaXZlcmUrYmk1UDNsMGpodkRoeXdtSlN4Vy9valorOHMwQ3lHTnpZ?=
 =?utf-8?B?K1htekVuWE42cVRmL005Yzd2R3pVUmR3dU40R1c5bkNDazhLRVpnMEpTK29H?=
 =?utf-8?B?TENteTRGRlZqZms1Y0txL2k5c0FlMlMrczVXbmtCOTB6TnhtZUZlS3RyNkZq?=
 =?utf-8?B?M3RHcTlzcHZSREVrb2Q3U284cFB1LzlGMEdxc3pxa0hsb0F5VjZzcUhzN3R5?=
 =?utf-8?B?TkhjYmZzY09YcEQrQzY1T3hPTFJjRVdHZHQzKytBK1FRQ1drL05SaGFIQkNB?=
 =?utf-8?B?RWIyVDJUYkZlMFVvK3crWXpNNkk2cExXYnBGUWdmOXJiQVBKS2xna3BTcVZj?=
 =?utf-8?B?TFJnVmYzZlIxaVpGY3h3VTNKekVRVFhQeWlVenhxQXBpaW00WFlaSzZyTkdO?=
 =?utf-8?B?SUh1M2xEVUdMb1lBZVZIck00ZDFRcDZ0NVM0UUgvVXlOWDRYREVCKzFKSVNa?=
 =?utf-8?B?d2huNCtGMG4rNE9ZZlk1V0o2ZENoNzFPUG1BQldoSnRyUm9ydHpEa29tNUtK?=
 =?utf-8?B?ZEFCN3BXeU1sdHN4RCtQb1BNRkJLTTlnNFphS1ZxblpuQXoySURsM2FBUGd5?=
 =?utf-8?B?eUZ2QUx4VjdRaXEySFFUU3pjTkpnODVOaXArbXRFTXB0Q0ZKb3dZcTE3QjZa?=
 =?utf-8?B?c3hYVS9uUnBaVDFJL052UmZJV0dDR3dBZHdLUTdBTGJ2MEVzVmppcXJtWlI4?=
 =?utf-8?B?VDU3U015MnRuTmtORE5QQlNZaVkvSEprZFZpTFMrY2psRGVRTlNkaDJjbU1o?=
 =?utf-8?B?ZURNODRIMHI1VHhMVGIwYW54enk1UmY5ajZJM3NZNDF2elFaaDlxNkxWWFBv?=
 =?utf-8?B?Qk1ac1NNdm5ydytubVlqcUorNVVkVzhBeW53SE43Q1FVZG1OMVU5d05DRE9G?=
 =?utf-8?B?U1VLNkI0cncxNVRDOVVubHBxaGRqb2R1K2taZGoxK1ladXhZaitXcTJKOFhp?=
 =?utf-8?B?Y3p0cHdiYzFTQUF3ZmtGeDc1SDNGMnR0eU9tdnNvOVlCZ3ByYUVFeHlGU1I4?=
 =?utf-8?B?OW1nS2hVY0l3Tm1semRGbjZWUmhDZGszb1Y4K2I2czM2b0ZYd01JcVRoSkhD?=
 =?utf-8?B?NGxqZlFQUlh4YnhLTzlhMHFxMi9hR2g0R3k5UmJYSE4yai8waWE5M3NxZTlR?=
 =?utf-8?B?cFMzN0hWWnBKSWFCaHFXUjgxZmFjaHYzdmtsc054UVhLRUVsZjFadXpSZnVS?=
 =?utf-8?B?VjVhYWVtMmtUMFp2cEZpN2FzY0pJd3NIRllxc3BHL2g2bE5WVzgwTVg3WkhZ?=
 =?utf-8?B?WmVVdXVpUFRld1FnKzR5S3crR2htSW1leDhwaWxtb2piSWxpVS9IUUptd3Zt?=
 =?utf-8?B?ZHUyOWN0cGltZ3EwdWg0MVJZb0piNmZnTGFWWHpEb1RWbHE4MU9OVVVJSC8y?=
 =?utf-8?B?Wkd1UWVHL0laMWFTdU5QclJId01NaEs4S1lVSzBYSHQ1RmNveGRjbmdLVngx?=
 =?utf-8?B?dmxLTTZGWkJ3ekZJL3VKdzN4Y3dwbHpVUHpCZ2N2YklrNXUvclRQT2NOV2t1?=
 =?utf-8?B?aVVGS1lTU3Z5Yk9UTVU1UUtKaEFveTlXQ3FSM1VlRHBuUWczVUFDa3JSZkgy?=
 =?utf-8?B?RWFwZEY3SHFKOGxZVEc3NlFoRlNIZkxyWnh5TUF0OExwSXRSR1lvR1pzYjJU?=
 =?utf-8?B?U0pOZkhoMXU0N0I0WWltZE1ESnVPNS9HMTk0RjJvNVF4WVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVFROXlDU0lNbUpvdkplUU9FY0o4Lzl2Wkw2aks3Y2FnUHJ6RFVWVUVESTVl?=
 =?utf-8?B?RXJVNWh2V0krYXczMXpZckQxcU1STC9rWEc0bkNUK000TFZyNWgzU0c2UVlt?=
 =?utf-8?B?Y3RFcm1JeE1abitpQmNRUDZBeWhSQnFkcTYyQ0hBRzg3YjJ3b0JtSE5RcUhF?=
 =?utf-8?B?VGNUcFZ0WXp1SWRJMGJNZGkwdnlZRUgwZnhQbzIrSi82bUlUYmJCOFJSL2Z6?=
 =?utf-8?B?UVU2SDkvbG9jQXhrY3V0MTN5eFc4a0c5TVN5T0FxdnhkMk1yVmN1V2lEdWF1?=
 =?utf-8?B?cmFnYnlvWE94dGxuT2hQeFhYY2pUNFJieFdqLzhvZmlVdWRTOXEvanlrNCsw?=
 =?utf-8?B?dDdyUFdVK2xrWDE1bW9rd243MGVUMC9CanFpVXJnOUIxN3V2QjBWWEZlbkly?=
 =?utf-8?B?T05tWWJvYWhzR1RvVUpIUmRiQzhrUG9oa3crbzBFQTVJVmlLSzFjRGkrbGt0?=
 =?utf-8?B?ZloydkRlYlBRUTMxNzRZU0F5RUR4UjduZTd5bTk2TDFiYUZTVlQyNkZoMjFH?=
 =?utf-8?B?aGQxbkVJNEFtRmltbFJrYlYxU0MvdG5EcWRWR0wzVE1jcWl6cXBIcFpGWXdt?=
 =?utf-8?B?MWladHgvRWd5KzZBUGd2RzExMmVrQmZxbmgvbFQxd0hLR0doNHREZGZjYjNQ?=
 =?utf-8?B?MkVnVFlDUjFRdGxncXpkd0lSZ1lYdTM0ajhPUXR5Wm5keW81Mi9RMmJOYlVt?=
 =?utf-8?B?QnlyMmx4c0gxODFldUFLclo1bUFCcGIwSVFHQnpxRzMvUEFFRCs4UWtsY1pz?=
 =?utf-8?B?d3JVNCtuc1JlWHVyVFVvaEF1UFA3QysxZHRBS1Z2bjZUK2pMQ1lkWmhwQ1FG?=
 =?utf-8?B?L2VOTUtiQmtFRmc4c3pCT0N2TXZtUFdPcW5HaE1wc2FaVnNIRXRkZWVFUlNa?=
 =?utf-8?B?QVR0dGxaZFF6SHVpckkxbkRONVBrNGpPS24xUDRxN0JucnNwU2ZaZ0JLWk11?=
 =?utf-8?B?emFkME1TUnZ1MWxUbGxqSmtBVnF0Z2ZoeENnOVp1UmtzR3lRTWg1REhhaDVn?=
 =?utf-8?B?OEVtSTg1NDd0allpLy9rak9WRjkvUm5xRHNPL21QY3A0T3Z3ZGIzL0t1ZDBr?=
 =?utf-8?B?WFora1lSSW4vZ1BMMDZiWjZyWWV6K2djN2tUNWQxSEorUCtqakR5OE5qVmNn?=
 =?utf-8?B?cUlySjBxQzhjSXBVQ01vaWU3bTZTY2RZTFA5S2lkMGtpUEU2cDRKY2hqZEoy?=
 =?utf-8?B?Q1BsWE1jQlhISjdLNG9Mcys4bWZmNXBROXY5WU1iSUg5S3Q3MFdFMzVvQjB0?=
 =?utf-8?B?T2c4WHRISkQ0R1dTa0x4WnMvVFp5cGJXbk05RWVVdGowZkp1T2t5bFFlU0VO?=
 =?utf-8?B?SFhsSnZQUHV1MUVMUHNRNVlPUlBES2g0RjdteG0xQmFQNnNjOVZvV1ltd0hD?=
 =?utf-8?B?b0tKUTdyS2NGSGpXWlpRV0R0N0xYNHNFRWRQbE9SczBGVXdnVkpjbzNjcGh5?=
 =?utf-8?B?SGdUaGQwcnZrQWFsbjh4MUFnMHhPdndPb1JUQ2loNmdyZThSWENzV20wbEtt?=
 =?utf-8?B?cVhpbytBdndJRjdFbzRyMVJEMFBPZnY3VFF3dURQc1cvMzQrdXp3enZsbStj?=
 =?utf-8?B?ZVRNSXJVQzRCVjNzak1kUXZXZ0NDZzI0REdkWEl4ZUhMcDlzRGdNRnp0Q0tN?=
 =?utf-8?B?Uk5DQk9JK3krNzhIVFZmc1Y1MCs4TzhRUVovRnFyaXhPeEtmeTJkcHhoc0RQ?=
 =?utf-8?B?K3pKTzJYR2JTcDlwYUlIUWx0alB1b3Q1eThzbUhPeDFrSEpLSWNoZjdZKzZ3?=
 =?utf-8?B?YkVZOENzV1k0cUNGNmthRGVuQWZEWmdEY3E3Y0gzcUxIYTZveUphVFV6OU5W?=
 =?utf-8?B?VFpkdTJWWE13L0NzQ09lbFZGTVpVK1pyUnBSc0R5TmpSTGF1NU55WFFXb2ZM?=
 =?utf-8?B?dzNPM2c1WEpWc1BnaWRLUDZjbENDZXE1bHR6MTBJT0lPOVRFVEZadXUzYTRS?=
 =?utf-8?B?dDRVcnozdGRNZ1BoajZyN2xDdktmQ3Q1U09kODA2T2JWTkVIVnQvQTRYMVFE?=
 =?utf-8?B?MXJQN2ZUTHVxRS9VWVBRM0NWWUxCTGczWktVNWIvTTJKUm4rSVBrVERJWWsy?=
 =?utf-8?B?Yy9MV1k0czVTN1dtMkJVTDBaSXlneFpIRThRVmlzTVBhNW9JM01RN1ltVytF?=
 =?utf-8?Q?VyZY6FNFdbe4s9YfKmrIXAeWo?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1538c07c-ed5d-4ad0-37d3-08dd50d6fcbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 11:17:24.9524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FXSiQsmSb1VAcICIPcfVNCdNSPMvLbD2yTkzOewLhhssNABk+h6W89cJCuj8NWaHGWI+1mSIVTW4FQDy3nwGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5649
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: uhso3xTC5l7nayn5ilxwC5QSm2ET-hBJ
X-Proofpoint-ORIG-GUID: uhso3xTC5l7nayn5ilxwC5QSm2ET-hBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-19_01,2024-11-22_01
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Tuesday, February 18, 2025 7:58 PM
> To: Sunil Kumar Kori <skori@marvell.com>; Jerin Jacob <jerinj@marvell.com>
> Cc: dev@dpdk.org; fengchengwen@huawei.com; Kevin Laatz
> <kevin.laatz@intel.com>; Bruce Richardson <bruce.richardson@intel.com>;
> Tyler Retzlaff <roretzla@linux.microsoft.com>
> Subject: Re: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary insi=
de a
> struct
>=20
> On Wed, Feb 12, 2025 at 6:=E2=80=8A14 AM Sunil Kumar Kori <skori@=E2=80=
=8Amarvell.=E2=80=8Acom>
> wrote: > > > On Tue, Feb 11, 2025 at 9:=E2=80=8A53 AM Sunil Kumar Kori
> <skori@=E2=80=8Amarvell.=E2=80=8Acom> > > wrote: > > > > > > > diff --git
> a/lib/eal/common/eal_common_trace_ctf.=E2=80=8Ac=20
> On Wed, Feb 12, 2025 at 6:14=E2=80=AFAM Sunil Kumar Kori <skori@marvell.c=
om>
> wrote:
> >
> > > On Tue, Feb 11, 2025 at 9:53=E2=80=AFAM Sunil Kumar Kori <skori@marve=
ll.com>
> > > wrote:
> > > >
> > > > > diff --git a/lib/eal/common/eal_common_trace_ctf.c
> > > > > b/lib/eal/common/eal_common_trace_ctf.c
> > > > > index 6bc8bb9036..d9b307e076 100644
> > > > > --- a/lib/eal/common/eal_common_trace_ctf.c
> > > > > +++ b/lib/eal/common/eal_common_trace_ctf.c
> > > > > @@ -378,6 +378,9 @@ char *trace_metadata_fixup_field(const char
> > > *field)
> > > > >               "->",
> > > > >               "*",
> > > > >               " ",
> > > > > +             "&",
> > > > > +             "(",
> > > > > +             ")",
> > > > Adding brackets makes token names a bit complex. Same name is used
> > > > in metadata file to dump the traces to the user. With this complex
> > > > name, user might not understand the purpose of that information.
> > > >
> > > > For example, _conf_src_port_pcie_sizeof_uint64_t_ is created in
> > > > metafile and same will be dumped. But with this User might not get
> > > > that
> > > which information is provided.
> > >
> > > In practice, as there is no other documentation for a trace point
> > > arguments, a user needs to read the trace point definitions.
> > > So it seems trivial to me to link a variable name in the trace point
> > > emitter, and the metadata in the trace files.
> > >
> > > >
> > > > This is the reason; we followed the existing naming convention
> > > > which is user
> > > friendly.
> > >
> > > User friendly? I don't see how this is different with '.' and '->'.
> > In general, structure fields are given a proper name to represent the p=
urpose.
> > When we use it directly in trace point using '.' or '->' then it remain=
s a
> meaningful name.
> > Adding more tokens in name, is making them complex and deviating from
> there meaning.
> >
> > I am not saying that the mentioned support should not be there. I am
> > just trying to convey that If it is possible to make meaningful names, =
then that
> will be more helpful.
>=20
> Hard to preserve such information given the limitations of the C parser (=
which
> seems to apply to the CTF format).
> I still think that interpretation of the metadata in the traces require l=
ooking at
> the source code, which means that the "readability"
> objection is weak.
>=20
> Jerin, opinion please.

One side, it reduces the number of lines of code, leveraging all CTF syntax=
 and other side it traces string becomes complex.
IMO, We can go with new patch scheme and document the new syntax so that so=
meone parsing babetrace or tracecompass
can understand the meaning of _conf_src_port_pcie_sizeof_uint64_t_ (as exam=
ple)



>=20
>=20
> --
> David Marchand

