Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B2EC021BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 09:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E20074064F;
	Thu, 27 Feb 2025 10:44:47 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 10DB740290
 for <dev@dpdk.org>; Thu, 27 Feb 2025 10:44:45 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8WVkb005610;
 Thu, 27 Feb 2025 01:44:43 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452mmn85fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 01:44:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VckxumqkQV1GiUY3WsaiyGa+rPcamP5tnoTbUOKvTrNd5p+peroGYz0rZJNEXE0DnmgzKW1NDeCK6LBB+L+sBvQ8306YGKk45xhrkgFiqQZ9dmsWmFZA0ovWtmdCDoODojG+AFod35s5CVLbJu2QM7nGqXu+4KwHzxRp0g1+/IuiK7WwNWixk85o62vdYnKrMvlmd89jCFxqhEPbBbV+iNspB3gOu7miFz+2oWRe/nd9aQfJgHT3heQA4cZdvdyYjgQaHm3LpNBGXDzNTuvzuLYIC3cxnJW9i76EP5OOuEOmhCDsyRp+S3wXJN4hxSsxXGytWnKJKTRQxT/jbatHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oggh0PQc4jIcwVtUiuUy8jqIVnzwm6BKv9Vvtjwnmjg=;
 b=cVCuttrEkdJJQbKnBe0Qzu10L63hlqbrKFFpFBcg0voaljFjuxu1fhyiXKtD4NagMa/DiFMysltsZ8HWqN1kR1yV5KjuDR1Er8lubkWNaMgJscFwwfDvWEl2oh8OiCmPkDVCIpldzMJagJr2dCt7DXczxT4Pz8t8YmhziYXpTpVaEuGMnGd/6TjYzzVCuSwMj3Sv2+aHh4v9SBVd58nHpmU8ZgnK0JqS4TRPos0Qh8wIjCm9pSjC2o0/RxoLAQ+yiWjwa1PtSWpWL3i733bfNg9ZmcF+oZgvyQ3cfI7+97n9iZfMriVsqJB8aez1lfb5Wv3jajpsQV39U0wGtZGJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oggh0PQc4jIcwVtUiuUy8jqIVnzwm6BKv9Vvtjwnmjg=;
 b=D7OQGVSu1PJDhcyFSP7yT4yiQQnj/bP0fazcLIlrQyVSfLb+1lN1wcSfKSlV4i7XqBu9bflMO/EQogo7qsEazfwntEUa9EjwW4wRpTN4NUy6/rXtDmS5+y1ZUeOhR0F6r4qLKCepMGLXpbymb54Ckyuf7WkjAJDIUT80g8jN69Q=
Received: from DM4PR18MB4269.namprd18.prod.outlook.com (2603:10b6:5:394::18)
 by PH0PR18MB3910.namprd18.prod.outlook.com (2603:10b6:510:26::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Thu, 27 Feb
 2025 09:44:40 +0000
Received: from DM4PR18MB4269.namprd18.prod.outlook.com
 ([fe80::9796:166:30d:454a]) by DM4PR18MB4269.namprd18.prod.outlook.com
 ([fe80::9796:166:30d:454a%5]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 09:44:39 +0000
From: Shiva Shankar Kommula <kshankar@marvell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "chenbox@nvidia.com" <chenbox@nvidia.com>
CC: "david.marchand@redhat.com" <david.marchand@redhat.com>, Jerin Jacob
 <jerinj@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Srujana Challa <schalla@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] net/virtio: add virtio hash report
 feature
Thread-Topic: [EXTERNAL] Re: [PATCH v2] net/virtio: add virtio hash report
 feature
Thread-Index: AQHbcI72u8xxHtElb0Kuk2Bh46tNsrNYXg0AgAK3GFA=
Date: Thu, 27 Feb 2025 09:44:39 +0000
Message-ID: <DM4PR18MB42690E8143C44B3893DC09D9DFCD2@DM4PR18MB4269.namprd18.prod.outlook.com>
References: <20250126193404.3431544-1-kshankar@marvell.com>
 <20250127074150.3499851-1-kshankar@marvell.com>
 <c4c881c5-c975-4fb7-b018-f5c529864171@redhat.com>
In-Reply-To: <c4c881c5-c975-4fb7-b018-f5c529864171@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4269:EE_|PH0PR18MB3910:EE_
x-ms-office365-filtering-correlation-id: 14bfb7f7-117b-4702-5455-08dd57135b01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEhGb3dtR2kwWnlWTHZGU0puY1BvUUJwM005NUt1OVRBRm8xaDVpMmFJREQ0?=
 =?utf-8?B?bjQ3Ti9RRjJYMDBIendxZVpHNVlsL3BySW1rQmNIUXBEa2pSVDliT1IxaW5z?=
 =?utf-8?B?NC9uVERFU3BYNVhSdVlmYTBVcnIyY1VWTk56eUdsMHZtRkJkS21tejlZVHJP?=
 =?utf-8?B?V2lYMlNCYVNrYlRUY292SnFRUG90a3l3TU5WdjUyc0Mwd2xqWGV1enpMNkJJ?=
 =?utf-8?B?VGV4RHcxRldDaXloTUVuMlRYNGVBcGUwamxvQXhHT2R2VHNtWVZNeEhNVmhi?=
 =?utf-8?B?VGV3NFJLVzlIWXZYekowMWJhRnVHQW4rcXlZcG1UdDYraEpHOWhRZExla2tv?=
 =?utf-8?B?VnRHRjlmTnpNWUFpNzRPSWliOVBEcndXVjJxaU9Ydmc2T2dMbGVZWmJ5dzJj?=
 =?utf-8?B?SHJYbjNtQzJqNnU0UlkyUkNFamIvaTZBRkNsMUN1cExUa2RiOTlVengvRldW?=
 =?utf-8?B?ckdTODNqaHZTaDZqbk1QNDNMbUFrQjREczE1a1F2ZnprQ0s3YWlEVllqa2VY?=
 =?utf-8?B?M2ExSW4xZnhkUW9DZ1NQZnhjL1NKTG9SMVFoS2E2cmRLM2pnVUNqYmlNREpa?=
 =?utf-8?B?OEFyZERlZWFxemF4WTVHNmo0U3VBYXdXSmxxdksxVmc2Mm1udGpnVWtOM0t3?=
 =?utf-8?B?R2xUY082NGFYbm5tU29Kd0F1NmI4eDVOVFpPVlFFdlFjRjBiS0tVMzVmdkxy?=
 =?utf-8?B?Z3VFZjVCQnBYQ0h3K2FzKzlPL3VvUmpsd1l1YUZyM0dxMDlRUzA5QVM5ZG5s?=
 =?utf-8?B?bExCN2FEbC9hTVlUeUJYZ0s0RUlYUjlxeDNIT3hGR2NKcmdmVnNLVWw5aWky?=
 =?utf-8?B?Z2RCZnZ5WnZVT2pxVlcwWEErT08vc3FxU2l3aFFuVzlIYzlwaVdXcURUN01R?=
 =?utf-8?B?ZldVdEhxQjBpWklQSHVFT0hleFpnTlJKbUpUU1N0ZXdMTGF0Q29mclQydUti?=
 =?utf-8?B?bkp2MTlLWFhjcTA0RUlTNUtTRUN3RlhsekgyTG8yMEJEWWRjKzZoYUNwY0hZ?=
 =?utf-8?B?ODU1OGtjdXd0SGpGTE5XaDJaRjNmK211VE5KUzBoSnpURi9TSURiUU1iRWJq?=
 =?utf-8?B?U2ZMNUd1d0FUL1puZW5hZThvMjd3TEdSajk4OUlha3BsUGFYRFR1UE9JZmta?=
 =?utf-8?B?cjRRZ0RPY1FKSStJdnRwSW40OFVMWXU4dlhPbmZpMUVlQTBaQ3o4UWpYZjUr?=
 =?utf-8?B?Y3lUa0tJbVZUTklxSmpIWDNIckNpSjgzaGZuelU3bnFkNzV6bWFaYWRDanlq?=
 =?utf-8?B?QmVDc1U4WnhKbHNGTmw1azVsdGRSbm1NL1FYZlgybzhCenI3QTJxVVNSUCtq?=
 =?utf-8?B?SHhiVWxBTzVLUmpVbkw1Z012eUVkZmxSRlpQMWQ1WWg3SHVHQmlKOWtHdU01?=
 =?utf-8?B?c0tiZDRRVkRHZG1jdXBJa3lWSUdOTDRtbVpyVWxFTEhqTUhaSnJ6WUNnUFlH?=
 =?utf-8?B?YUV1WWx5ZWtRMmIvRmpHRFF3TlNsWEoraTlPakJ1b2UwTVhDOWZzZU1YVVRI?=
 =?utf-8?B?dDZkR0JPMUd4R1pWTVZIaG1ZYzhSeVhYNFU5dEwzM0ZsWGlUSk1NUld2QU5x?=
 =?utf-8?B?YzM5QjlUUHpBcEo2YkJXQk5sYnhKY1ZiMXpGUjVvVXdhOTFQL1F3cTBsd0cw?=
 =?utf-8?B?S1VNd0tqTmVEMzJpM3A5Q1IzR3lLVFJrY1YxaGpIcDh6Q3grcnZJb2dQeUs0?=
 =?utf-8?B?MTNoYkFRYVBMdWVZajlTSTQ3Vk81S0Q0ZnloaTgzRUFUelFKQ0xZSFUzblB0?=
 =?utf-8?B?dXk2ZXpOSjZ0cEhNOHI0NldDYWd2bkdwTmNXZk5BSWRnQjJTNGgwakJ0QUUy?=
 =?utf-8?B?M1pwNXA5N1phdHNmUG9QYWhuNGdUczBLVkVIOHVLZ0ZVV2ZrUEFTVEg0OVJy?=
 =?utf-8?Q?1JX9jut29H+c9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR18MB4269.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5pMkdnM0NhaWtKa1luN0ZFVjVBNExzSldsTmZJTkRuZjc0WEJiK09Xc08w?=
 =?utf-8?B?RHFheHB6UlZQRytqaGpFNlFUNVhNNDVvTFdFL1cvTG9oOXVFdFovMFdXVE4w?=
 =?utf-8?B?bXJJQ2IxK2hadTQyOEF6cDZTOHpQenE3ZE5FRzFYc0F4Wjh2NDJCYnd1VHJY?=
 =?utf-8?B?ZllHM0tuakxocGVvazQ4Z3JPdzdxaWpHalh2SzVZVThyS3pvQWJEZXNCSEk0?=
 =?utf-8?B?RXoyZWtPL1JlUnQ2cHdtYURodUJXY3FJN2xXQjJSVmt1T0VlOXp4U3pEVyta?=
 =?utf-8?B?SWd6QUYwRHBoOVgvOXdadHg5RFhmbEpwWnN3T09hMWpIM2JuTnBZK2tBVmxj?=
 =?utf-8?B?VVNrazN1Vy8xNVkwRkZiNWNuam5NMDMwb0ZvSmF4b1FiTHhEM3VMZjdCYVl2?=
 =?utf-8?B?NUE3a2hwUlhoY1pRaXlZOXppRGFDWnY3YTBPOFpkckpGNmZoNWkrNGdPY1Ry?=
 =?utf-8?B?a3ZWbk8zMEJRWE5xaVhLMjkxVG5YL05aRFB6cUxGMGRjY3YvdHpPdVJBWFZO?=
 =?utf-8?B?TGlZckNYWVFoY0xySXdGZUtFcjdpMmU5KzRNeDZEU1NKK0hQRnlTQ0ZBa1pW?=
 =?utf-8?B?YkVMeW83RmJadlg5YlIrYmY5eEF6UnYxUjlSS2hZS2NjeVZ1TnVGbVlmQXE1?=
 =?utf-8?B?c2RxMWl6THVjaHhXYXlwQS9xNEE0RnJSRlF6Y0U2N3hxVjdjWWQ1SFNIM2R4?=
 =?utf-8?B?eWdqUU04MTNnK0I2Vmc5cU9lWXZpbGNPaTNWZFFlUkNEYkNpOXcxOXUrL2d6?=
 =?utf-8?B?REVMTnM4QUVmMzN0Ulc4S241MUNTRkRPUUFCNVprMmxkd0E1SVRwZmZweWhy?=
 =?utf-8?B?VUp2UlNKL2VNNGZQOEVVekt0V1Znc1FyczhTLzFEeDYrUFVyWlFmZXBoa09o?=
 =?utf-8?B?Mjl6OVdEQnhNVmdPanMrWlIvcVg1Y2F2R2hUdXlweXhtbmhqdFI2WHRmUkNL?=
 =?utf-8?B?Z29DSEZDcm9XcWU0TTZySkZocGJyMGZmZ05sbzRjUXJCRW9oVVNhOWZ0UWJj?=
 =?utf-8?B?dmRYa044NkorOVFBNFYxUnM3RU1YQTJnYVJxYm9PZkN1ckhXUmt3STNiV0p2?=
 =?utf-8?B?MUlmMlBabnFPMXFIZy9ocWtMOW94c01yUXNteGF2bHlheFVUWitJSDB6RThQ?=
 =?utf-8?B?VWxIMERNYU1JR1lGWmVWcjA3MWhZWmxtcDJFL2hVVktNUytnRUdRTDV1clE4?=
 =?utf-8?B?dkVKTVNKMUlFbURNWTVvaDFJQTdSREcxa1kzRXY3WnlmSFZDRWJKRkZPV1Ny?=
 =?utf-8?B?emE1Q0lxR2p6OExYN1I5U1dVdE8vR0JEdDNFUDRSelc3TmlxcXZaeUxZV3ZX?=
 =?utf-8?B?NDB5V1BBZi85QUwvMVBPT1hNMTlwd1R6OXlFMERSemsrTHV2S0kwWHczMTVj?=
 =?utf-8?B?bisxWkN6TGlFcjBXMXZadTRnUEo5YS8xVUVLRUZRMWYrL0hyZk5aZlFCU2ZU?=
 =?utf-8?B?K3dET0kzb0JVd2lvQTFoeHEzYUI5WHExcmZPUnRpblo1VlhrYVdxelVQVS9U?=
 =?utf-8?B?TTVSRE9oYVR3T2piYUZTRjdZaWVNL2tidGJEMEhja1ZDbGZxeGtOLzRQK3l4?=
 =?utf-8?B?ajFMdVo5d0ZzL3FhRmt1SUY3UGJzV2pwODJDekdieDAxMXRDOFJTNmhCdEdr?=
 =?utf-8?B?TlBtbWhsNTdtclJaWXE3dWxsYk9CS29OdHgxb0tiV1Y0Rmpmbit1VFFoMzc4?=
 =?utf-8?B?NndON0FuWjN2c1M4ZkJpUU16Tkw1MUU1bVZCQjlOUUdBTzlpRlRHRXJaNXpS?=
 =?utf-8?B?Y3N3Q0xOdDhsb3h2cGY1c3E4RkZYdEt5S3dMa1NjQlJ5WUF0ek9oc2JjQ0tG?=
 =?utf-8?B?Q0dsam8yOUxHdmhXMUlUWU9ENTB3TVo1ZnMxdUlMSWNGZ2hzN01LaCtabHlK?=
 =?utf-8?B?MHZ6NXZXOVFCaTBEamhKcktXRTdUMW94UllOTGpZME9YaU1IaExGSU8wU2xW?=
 =?utf-8?B?VzZSUm04dk1SVm9vaHM3bFJzYkJmNWJUaGwrZXlsVzQ2RXdrT3RpKzVpbUNX?=
 =?utf-8?B?ZmZ3V3BWWkhLUThGRDFRT3o2a1dLdUNncWkzclZlVHRPamorc3NMYTVjQjZs?=
 =?utf-8?B?ZDBxNXlLRWdEa1UyWkFRdWpaa3N2NjNHNVlGUXZsRURMSFBIQk5EZjdWVUp4?=
 =?utf-8?Q?pT0R6oybrJUE6q8a0M0ewwwE5?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4269.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bfb7f7-117b-4702-5455-08dd57135b01
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 09:44:39.8876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2Hm8oyfvrZkE5WiHcjiwVZ2pdsW5HoVk3o9esLRg+2mfFwS5CANEy67/6/5aOohiJUMn4K0o/OTNazfJH1LUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3910
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JZxGrVKV c=1 sm=1 tr=0 ts=67c0340a cx=c_pps
 a=GbYsmhbcUJoGoLxTsnc7yA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=Ikd4Dj_1AAAA:8
 a=RpNjiQI2AAAA:8 a=K3_rMOR3WuyZ97aozrUA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: Jc2jcdyHCEvSsL5SoYbJF-COQpKqmukC
X-Proofpoint-ORIG-GUID: Jc2jcdyHCEvSsL5SoYbJF-COQpKqmukC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-27_01,2024-11-22_01
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
> From: Maxime Coquelin <maxime.coquelin@redhat.com>
> Sent: Tuesday, February 25, 2025 9:39 PM
> To: Shiva Shankar Kommula <kshankar@marvell.com>; dev@dpdk.org;
> chenbox@nvidia.com
> Cc: david.marchand@redhat.com; Jerin Jacob <jerinj@marvell.com>; Nithin
> Kumar Dabilpuram <ndabilpuram@marvell.com>; Srujana Challa
> <schalla@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH v2] net/virtio: add virtio hash report fea=
ture
>=20
> Hi, On 1/27/25 8:=E2=80=8A41 AM, Kommula Shiva Shankar wrote: > This patc=
h adds
> virtio hash report feature, which is > supported in packet queue mode with
> scalar version Why only restrict to packed ring? isn't it also compatible=
 with
> split ring?
>=20
> Hi,
>=20
> On 1/27/25 8:41 AM, Kommula Shiva Shankar wrote:
> > This patch adds virtio hash report feature, which is supported in
> > packet queue mode with scalar version
>=20
> Why only restrict to packed ring? isn't it also compatible with split rin=
g?
Hi Maxim,=20
Yes, it is. I can add split ring support later if it's alright
>=20
> >
> > Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> > ---
> >   drivers/net/virtio/virtio.h                   |  2 ++
> >   drivers/net/virtio/virtio_ethdev.c            | 20 ++++++++++++-
> >   drivers/net/virtio/virtio_ethdev.h            |  1 +
> >   drivers/net/virtio/virtio_rxtx.c              | 30 +++++++++++++++++++
> >   .../net/virtio/virtio_user/virtio_user_dev.c  |  1 +
> >   drivers/net/virtio/virtqueue.h                | 21 +++++++++++++
> >   6 files changed, 74 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio/virtio.h b/drivers/net/virtio/virtio.h
> > index ef5827c5f5..c2a0fd477c 100644
> > --- a/drivers/net/virtio/virtio.h
> > +++ b/drivers/net/virtio/virtio.h
> > @@ -30,6 +30,7 @@
> >   #define VIRTIO_NET_F_GUEST_ANNOUNCE 21	/* Guest can
> announce device on the network */
> >   #define VIRTIO_NET_F_MQ		22	/* Device supports Receive
> Flow Steering */
> >   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > +#define VIRTIO_NET_F_HASH_REPORT  57    /* Supports hash report */
> >   #define VIRTIO_NET_F_RSS	60	/* RSS supported */
> >
> >   /*
> > @@ -187,6 +188,7 @@ struct virtio_hw {
> >   	uint8_t started;
> >   	uint8_t weak_barriers;
> >   	uint8_t vlan_strip;
> > +	uint8_t has_hash_report;
> >   	bool rx_ol_scatter;
> >   	uint8_t has_tx_offload;
> >   	uint8_t has_rx_offload;
> > diff --git a/drivers/net/virtio/virtio_ethdev.c
> > b/drivers/net/virtio/virtio_ethdev.c
> > index 70d4839def..caacbce57a 100644
> > --- a/drivers/net/virtio/virtio_ethdev.c
> > +++ b/drivers/net/virtio/virtio_ethdev.c
> > @@ -1796,7 +1796,9 @@ virtio_init_device(struct rte_eth_dev *eth_dev,
> uint64_t req_features)
> >   		eth_dev->data->dev_flags &=3D ~RTE_ETH_DEV_INTR_LSC;
> >
> >   	/* Setting up rx_header size for the device */
> > -	if (virtio_with_feature(hw, VIRTIO_NET_F_MRG_RXBUF) ||
> > +	if (virtio_with_feature(hw, VIRTIO_NET_F_HASH_REPORT))
> > +		hw->vtnet_hdr_size =3D sizeof(struct
> virtio_net_hdr_hash_report);
> > +	else if (virtio_with_feature(hw, VIRTIO_NET_F_MRG_RXBUF) ||
> >   	    virtio_with_feature(hw, VIRTIO_F_VERSION_1) ||
> >   	    virtio_with_packed_queue(hw))
> >   		hw->vtnet_hdr_size =3D sizeof(struct
> virtio_net_hdr_mrg_rxbuf); @@
> > -2181,6 +2183,10 @@ virtio_dev_configure(struct rte_eth_dev *dev)
> >   			(1ULL << VIRTIO_NET_F_GUEST_TSO4) |
> >   			(1ULL << VIRTIO_NET_F_GUEST_TSO6);
> >
> > +	if (rx_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH)
> > +		req_features |=3D
> > +			(1ULL << VIRTIO_NET_F_HASH_REPORT);
> > +
> >   	if (tx_offloads & (RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
> >   			   RTE_ETH_TX_OFFLOAD_TCP_CKSUM))
> >   		req_features |=3D (1ULL << VIRTIO_NET_F_CSUM); @@ -2233,6
> +2239,9 @@
> > virtio_dev_configure(struct rte_eth_dev *dev)
> >   	if (rx_offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
> >   		hw->vlan_strip =3D 1;
> >
> > +	if (rx_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH)
> > +		hw->has_hash_report =3D 1;
> > +
> >   	hw->rx_ol_scatter =3D (rx_offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
> >
> >   	if ((rx_offloads & RTE_ETH_RX_OFFLOAD_VLAN_FILTER) && @@ -
> 2285,6
> > +2294,12 @@ virtio_dev_configure(struct rte_eth_dev *dev)
> >   					"disabled packed ring vectorized rx for
> TCP_LRO enabled");
> >   				hw->use_vec_rx =3D 0;
> >   			}
> > +
> > +			if (rx_offloads & RTE_ETH_RX_OFFLOAD_RSS_HASH) {
> > +				PMD_DRV_LOG(INFO,
> > +					"disabled packed ring vectorized rx for
> RSS_HASH enabled");
> > +				hw->use_vec_rx =3D 0;
> > +			}
> >   		}
> >   	} else {
> >   		if (virtio_with_feature(hw, VIRTIO_F_IN_ORDER)) { @@ -
> 2669,6
> > +2684,9 @@ virtio_dev_info_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
> >   		dev_info->flow_type_rss_offloads =3D 0;
> >   	}
> >
> > +	if (host_features & (1ULL << VIRTIO_NET_F_HASH_REPORT))
> > +		dev_info->rx_offload_capa |=3D
> RTE_ETH_RX_OFFLOAD_RSS_HASH;
> > +
> >   	if (host_features & (1ULL << VIRTIO_F_RING_PACKED)) {
> >   		/*
> >   		 * According to 2.7 Packed Virtqueues, diff --git
> > a/drivers/net/virtio/virtio_ethdev.h
> > b/drivers/net/virtio/virtio_ethdev.h
> > index 7be1c9acd0..7aa771fd2b 100644
> > --- a/drivers/net/virtio/virtio_ethdev.h
> > +++ b/drivers/net/virtio/virtio_ethdev.h
> > @@ -46,6 +46,7 @@
> >   	 1u << VIRTIO_NET_F_CSUM           |	\
> >   	 1u << VIRTIO_NET_F_HOST_TSO4      |	\
> >   	 1u << VIRTIO_NET_F_HOST_TSO6      |	\
> > +	 1ULL << VIRTIO_NET_F_HASH_REPORT  |    \
> >   	 1ULL << VIRTIO_NET_F_RSS)
> >
> >   extern const struct eth_dev_ops virtio_user_secondary_eth_dev_ops;
> > diff --git a/drivers/net/virtio/virtio_rxtx.c
> > b/drivers/net/virtio/virtio_rxtx.c
> > index b67f063b31..35bd61350c 100644
> > --- a/drivers/net/virtio/virtio_rxtx.c
> > +++ b/drivers/net/virtio/virtio_rxtx.c
> > @@ -40,6 +40,19 @@
> >   #define  VIRTIO_DUMP_PACKET(m, len) do { } while (0)
> >   #endif
> >
> > +static const uint32_t vhdr_hash_report_to_mbuf_pkt_type[] =3D {
> > +	RTE_PTYPE_UNKNOWN,
> > +	RTE_PTYPE_L3_IPV4,
> > +	RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP,
> > +	RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
> > +	RTE_PTYPE_L3_IPV6,
> > +	RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP,
> > +	RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP,
> > +	RTE_PTYPE_L3_IPV6_EXT,
> > +	RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L4_TCP,
> > +	RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L4_UDP, };
> > +
> >   void
> >   vq_ring_free_inorder(struct virtqueue *vq, uint16_t desc_idx, uint16_t
> num)
> >   {
> > @@ -901,6 +914,16 @@ virtio_discard_rxbuf_inorder(struct virtqueue *vq,
> struct rte_mbuf *m)
> >   	}
> >   }
> >
> > +static inline void
> > +virtio_rx_update_hash_report(struct rte_mbuf *m, struct
> > +virtio_net_hdr_hash_report *hdr) {
> > +	if (likely(hdr->hash_report)) {
> > +		m->packet_type =3D vhdr_hash_report_to_mbuf_pkt_type[hdr-
> >hash_report];
> > +		m->hash.rss =3D hdr->hash_value;
> > +		m->ol_flags |=3D RTE_MBUF_F_RX_RSS_HASH;
> > +	}
> > +}
> > +
> >   /* Optionally fill offload information in structure */
> >   static inline int
> >   virtio_rx_offload(struct rte_mbuf *m, struct virtio_net_hdr *hdr) @@
> > -1134,6 +1157,9 @@ virtio_recv_pkts_packed(void *rx_queue, struct
> rte_mbuf **rx_pkts,
> >   		hdr =3D (struct virtio_net_hdr *)((char *)rxm->buf_addr +
> >   			RTE_PKTMBUF_HEADROOM - hdr_size);
> >
> > +		if (hw->has_hash_report)
> > +			virtio_rx_update_hash_report(rxm,
> > +						    (struct
> virtio_net_hdr_hash_report *)hdr);
> >   		if (hw->vlan_strip)
> >   			rte_vlan_strip(rxm);
> >
> > @@ -1617,6 +1643,10 @@ virtio_recv_mergeable_pkts_packed(void
> *rx_queue,
> >   		if (hw->vlan_strip)
> >   			rte_vlan_strip(rx_pkts[nb_rx]);
> >
> > +		if (hw->has_hash_report)
> > +			virtio_rx_update_hash_report(rxm,
> > +						    (struct
> virtio_net_hdr_hash_report *)header);
> > +
> >   		seg_res =3D seg_num - 1;
> >
> >   		/* Merge remaining segments */
> > diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > index 2997d2bd26..187f81b066 100644
> > --- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > @@ -726,6 +726,7 @@ virtio_user_free_vrings(struct virtio_user_dev *dev)
> >   	 1ULL << VIRTIO_F_RING_PACKED		|	\
> >   	 1ULL << VIRTIO_F_NOTIFICATION_DATA	|	\
> >   	 1ULL << VIRTIO_F_ORDER_PLATFORM        |       \
> > +	 1ULL << VIRTIO_NET_F_HASH_REPORT       |       \
> >   	 1ULL << VIRTIO_NET_F_RSS)
> >
> >   int
> > diff --git a/drivers/net/virtio/virtqueue.h
> > b/drivers/net/virtio/virtqueue.h index 60211a40c9..3b468bd4f4 100644
> > --- a/drivers/net/virtio/virtqueue.h
> > +++ b/drivers/net/virtio/virtqueue.h
> > @@ -257,6 +257,27 @@ struct virtio_net_hdr_mrg_rxbuf {
> >   	uint16_t num_buffers; /**< Number of merged rx buffers */
> >   };
> >
> > +/**
> > + * This is the version of the header to use when the HASH_REPORT
> > + * feature has been negotiated.
> > + */
> > +struct virtio_net_hdr_hash_report {
> > +	struct virtio_net_hdr_mrg_rxbuf hdr;
> > +	uint32_t hash_value;
> > +#define VIRTIO_NET_HASH_REPORT_NONE	0
> > +#define VIRTIO_NET_HASH_REPORT_IPV4	1
> > +#define VIRTIO_NET_HASH_REPORT_TCPV4	2
> > +#define VIRTIO_NET_HASH_REPORT_UDPV4	3
> > +#define VIRTIO_NET_HASH_REPORT_IPV6	4
> > +#define VIRTIO_NET_HASH_REPORT_TCPV6	5
> > +#define VIRTIO_NET_HASH_REPORT_UDPV6	6
> > +#define VIRTIO_NET_HASH_REPORT_IPV6_EX	7
> > +#define VIRTIO_NET_HASH_REPORT_TCPV6_EX	8
> > +#define VIRTIO_NET_HASH_REPORT_UDPV6_EX	9
> > +	uint16_t hash_report;
> > +	uint16_t pad_reserved;
> > +};
> > +
> >   /* Region reserved to allow for transmit header and indirect ring */
> >   #define VIRTIO_MAX_TX_INDIRECT 8
> >   struct virtio_tx_region {

