Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5133CC19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F3754025E;
	Sun,  2 Mar 2025 21:36:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C759940041;
 Sun,  2 Mar 2025 21:36:43 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522KDWon021940;
 Sun, 2 Mar 2025 12:36:43 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4542mu9x6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 12:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEfAoeXGjSMCK99g+q6t8eYwGXN6DE+DypXRu+qD0ePOfE7tfhu1FhUgcIUVMfSE1HsPbNfykUdQU640Y4+fED2zDw2nd9YjkP/eW28NC283RTA1I2PpITjQyu6YsdyWaVjhx6pRyKRtJ/9LBMdvX4JutqAjD7HBG14A0TudTwxnuOBW4vMs6Lp3/2ottaelcy117DQ/kdyQ3vSciQQGw/5mLVdUPl6kpEe0/4+6RI5C4l09l/yGovTtUhLfZkoWPZ5KT3aYPYxvES8Fj1hIoGAjlKZfW0sMDzjDaP/D8RUgQeljk9BNRKtspVlGtQlKYn6cEKbpJuZ021WG4zOqDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxIM7ji0JyDbzgLY6/MsQO6FeFUbiR8U5iy5g6vxFeg=;
 b=mZxPPoLKKg6vXDE83icDfr/jQk95nXilqVfRKSylA/2xgdNCfv54MmItBKsZDzzqFGJRSRDbTzwVPUIsqMTYX7HuL1+UVC7ujIZP73wxs9oPebwrS3LIdbBZuouMup+yZ6I3qhT5JUKf3f2RGotgtNnLRndp3gYtSneBCShCTKZmbFXLdO8p8/xym1dN5uq8+Fyd4c16F0Pk6zqxB/MHpssTsmvOGFRpwkqjxrnQbLH4BK0B8BaOl6b/B7h9LfiibVr12q2VIh+OYp6BS1lICaye89voNDLVRrb6m4yM/lt8ri27hNm//J8yPUzVjlq5UfMDcw3uNfZqERwM9+mQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxIM7ji0JyDbzgLY6/MsQO6FeFUbiR8U5iy5g6vxFeg=;
 b=I99nC59xpQS6txonsA01RbEbu5PgkwXdYpjqf63qw4k2XckwpzE99jkgQYjz9KCLaI4Wa3gDbBfMV0vHkfmwSqvFgFK1mlZpvsnnYhtg45eGTcYXwAYr4hT7O2pGFO7IQE0GM5pJ0hbYqOITXcNfDGSg2lDNri8FQKdBF4nD6tE=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB5511.namprd18.prod.outlook.com (2603:10b6:610:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 20:36:39 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:36:38 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "brian.dooley@intel.com" <brian.dooley@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/test: fix the check of the oop header data
Thread-Topic: [EXTERNAL] [PATCH] app/test: fix the check of the oop header data
Thread-Index: AQHbiCbLcUPduNkMYUCfsWSAaGt4n7NgVAgw
Date: Sun, 2 Mar 2025 20:36:38 +0000
Message-ID: <CO6PR18MB448487F176B63A76799FBCE5D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250226081645.1415920-1-arkadiuszx.kusztal@intel.com>
In-Reply-To: <20250226081645.1415920-1-arkadiuszx.kusztal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB5511:EE_
x-ms-office365-filtering-correlation-id: e3b9f48b-dedf-401e-fbb7-08dd59c9eebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmpsUldNL1RvcjNqN2o0Wkp2RVJQOVpMUGpMNGFWK2FSTWR6TllvYzAySWRk?=
 =?utf-8?B?YUtQWEN2T1lYMGUrSzIrN2NxY2JDTzE3WDlNNUdxRml0ZXVjbVgwOTZ2cFhj?=
 =?utf-8?B?MzB4K2hWYURUd0dhQ1dIKzIzSjhFYVNYTmdmb2pIaForSk9kOCtXbVUySnd5?=
 =?utf-8?B?Vy9kVitWZEtJTUQ2dTJUUm9XVVRJbGNWb21FT3NmaW5iQ2RZdUJvc3VDdjJi?=
 =?utf-8?B?QzgrYXdSVU01Yzc0cFVQQmNhSDJ2eUdxRHl4S2txY2JpdTl6N0JGYjVxYlFw?=
 =?utf-8?B?VlFzSzNLRkVoYlQwQ01wTkNyTTlONFJrdzd0aUQ1NUJ5blpvdy92VFVHSW9j?=
 =?utf-8?B?OFA2bUNhTkhmUW8vU08rLytYSDlmUGIxQkp1cjVtMVdPL2ptNzBHWTMrblBZ?=
 =?utf-8?B?MWd3bjhvQU4za3BsZVFMaGtuUVhLTktnRk14eWtxaloxTmdsTDVHY0YvMzNO?=
 =?utf-8?B?aXFMK1FPMEJjK0dBYlYrTlYzRWZ5YVVCdUMyWWQ1WVFLclY1cG9pOU14Mmc1?=
 =?utf-8?B?eGpyRDlwbTlxREhWUVpudlZrSWFtT1c3MXZOUHF5eW1sSTZ4Wk5qaHhEekVZ?=
 =?utf-8?B?amJ1cERTVm9FV0FtdDhOMWw5NDY4SFRKTkgyekpwazRBTVhKWS9FUGYwTFpq?=
 =?utf-8?B?Q0psc0N0UExSZCtlQnFmTjU2alBKNTNHY0hQZW5SeVhseGRPT3gwSllNcW56?=
 =?utf-8?B?SFQrRjd1cXRCaEgzbHdBSzBVc3plYVhIY3pYRFR0WkJYVnZNK3FnWXFDcTMx?=
 =?utf-8?B?RmFpQmJFcjV1WHBDNkxwOGxnTlBjdnc2K0puZzJ0RnpmenV0YWJ3YXZSdnlF?=
 =?utf-8?B?K3Q1Qkd2ZUNkN1F2K2h4YU11cHh4UXo4YVJ1aWZrTnYxSlBvU2ZDekpRRnRk?=
 =?utf-8?B?UGxybmRjS0crVnlEWlZqTGpOdFFWQlEyckVjNk1mM3JERlZhbXAwcDJJaFBu?=
 =?utf-8?B?WEg2Qk00akd1WXViaENEMXlNdlZMUzkyWFpHeTRZb0Q3NzI1eEphZ2RqUzdN?=
 =?utf-8?B?SEE3eDV4WU9aWG8wNkxzTDVOd3BSd0xBUnJpeSswS1UweThqNnZxZlRpbHBH?=
 =?utf-8?B?Mm9EZnYrekE3c043bHpuK0QrZkZHdGJxVGlHeFJRTjJnYkVySWlKaUVnRENV?=
 =?utf-8?B?emNwRzgvdWlXK0xBTzZ4Wm84c3U3ZDdQaVR2T1p0N0UwcGI3Wm5WRHovVEdL?=
 =?utf-8?B?bmxyZVNLRld1WDh5Y1dzaUdCRmRzQnY2VHRtOFlYVS9CZGVtMEtXb2piY0lH?=
 =?utf-8?B?V3RsT1F0SXdBMHYzNGFKRHgxd0hVemhzZzFFRUgvR1VPamhlRDVXQzJYNEYz?=
 =?utf-8?B?NU80SmV2TXFaTk1Ra0lqMzRSbTRMbDYzOHBIVHF0RHB5VVJSMW9XbCswSzFx?=
 =?utf-8?B?ZW9iQ2dHUUhKaDRPZ0pubDg5NUN1QkZzVGg0Q2R3TE9DZHpHelN1THB6NGZS?=
 =?utf-8?B?YVlFbDRZUktHbS91YVNSNzRiMVFGWDB5cElBajdRQ3RzSUNRbTVqVnRtemh4?=
 =?utf-8?B?MVdNdEdxajhNVmE3b3F4cFVBYWUveUtDWHcxRmlZUDB2ajRQYmp0aWcvRWIy?=
 =?utf-8?B?QWJtYVZEVmxENTcvNHNHWnR4Wms4MVNJeVhqRFc3ZWh4d1FteitMa29oblpT?=
 =?utf-8?B?WCtDM0lWV004LzNaN0M1dnNtUHJaQWY1T2kzZ0duN255ZWN5eklrR09RY0VO?=
 =?utf-8?B?ellGSlRldUZ0UUV5U005WndYUTRwY2EvUDlTbDVhR2NuUlBFOSswb0M1MjVi?=
 =?utf-8?B?ZHV6bkRzS2lSZzkyNG5wQTNNd09vZHB4dE9Lak0vUmcrUlpmamhNZFpVdWZB?=
 =?utf-8?B?TmVrR1Y1RkdLRG84K2hxbWZMVVRickNJem9VaUxGZ2cxK0h1S2NnV3E0Mkp0?=
 =?utf-8?B?VWc3TUxvN0greXFrd2hiekpOWkJZQnJJWWRwY21hd0l6Uks0U0ViQzdIVENW?=
 =?utf-8?Q?6taasdkiz4Z1P0oSu+V1X0/Povz0tSg4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHVKWjl5VG5Cd0RJUU5DbnBUYXV0d25jRGtKUFJKQWRwZlFPV05sUjduV2U0?=
 =?utf-8?B?N2lON2N4WGxKNWNyRmM0OEJxWjVxZjJrWXNCbVZGcllFNXpzeFE0eEVseDhl?=
 =?utf-8?B?Y0FZUWZnNDVPY0pNcjRIREFKdVAzbHk4U3FiOEEzdjhUck40YU5FU1FXZEdF?=
 =?utf-8?B?d1NTZGczQTNlQUhlTm1GK3NTdU9FZnRlcmlSOVgrVTRvTEwxT3RUS0x1K1hw?=
 =?utf-8?B?VTZrbGwxR0U3UGN5VFJIOGF1UkYxNFFpcXpTR2s3c1dCZ1FNSTRYU3B3TWtq?=
 =?utf-8?B?T09Xd21tM29wdjQ1eHNPT3dLcHZMdVJwN0tnVG5VdC91emd3Y1hBTG9UVEdH?=
 =?utf-8?B?U3BETWsyU3NPYWljSzVqcDRmM2ZoRnRkUjlqZnlKbjk0UUZjdHRpQmxYNzA3?=
 =?utf-8?B?VjZiQ1RMY3Q1dDRFQkQ2MXFwcWNHYUFnMDZmZW4wNkwxU08xcFpyaFJCeHZo?=
 =?utf-8?B?bkxJZjlXQzVGeExZVDAwaGRpaGU3bythR2xHK0lVOEswYW1BanpJb0oyUkFo?=
 =?utf-8?B?a2d1U0JDQ2F6eXdBUFhaK1R1ZzQ3S0VXY2dPaVc1eFhIdVp3ejV1NmhCY0xv?=
 =?utf-8?B?cFZNOWZPd3hrRWkvMSt4c0wxb1haU25xSm83cGo5di9wTHJCYjZZWmFqeVo3?=
 =?utf-8?B?YU56U2pKK3NVeS85RzY1VTBnU1pqaFpCTWpBeXY1NkdTbmczWUJmcTN6NE1w?=
 =?utf-8?B?SmRKRmtGd0paOHRlN21LK0RvNmcvNW1FZTd2N21wbjArRTFtcnFORlFwMis0?=
 =?utf-8?B?NzR4S2NBdlpSaVh1aUFRdGZ5NytBOVRIM1ZFRk9JUHVDKzFCRFIyYUdHemxW?=
 =?utf-8?B?Wmc5bUFad2hJZGk4bWJybDRoejYrNjVKbXN6QnFEOFd6blFnY3I5WUpadEFR?=
 =?utf-8?B?VldUUWxxaHYzVUxrTkgyek4yQzk1Sld5Rmg0M3M2KzYvcGVqZTFPeElBVUFa?=
 =?utf-8?B?T2V4YjdxTXA3STR6STdENDFQNnRVc1VSV09GQ2I4OEtaUWJ6bGRac0JBeEJH?=
 =?utf-8?B?T0xsaDk4NUEzTzJ2aFYvK0ZkR081eVRFeDFvMzIzYytxZW01L0VBUXA2MWdR?=
 =?utf-8?B?aHVoZk11a3VWN2JVNUdBelhVRlc5c3JxNEZXTFpjWlJRa0dTN2ZRdWNlL2JI?=
 =?utf-8?B?dVBlSEQ2T0ovdnE5UXJGSXBVUElab1BFTGRtTENyMTVuUW1lSXpZWUxZUXNV?=
 =?utf-8?B?ZmlTVzlVSzBnOVBSYjRrSldJUHZ2aGlONDlnREllMHhkQWk4ZWJSOXVNZHJY?=
 =?utf-8?B?RHFXNyttRDRMd1YwMm9kOXh1NkUrMWFZQXBOczdZUWxVemFSNlJVVy9sU1NX?=
 =?utf-8?B?dk1rT2s2ZWdZZnplV2ZDLzd5T05RWE0wWDJ1Qjllbk5LcG9sNFVVS1pwT2JJ?=
 =?utf-8?B?cXJ6dnJhVm1WOVhGMEJSRjRaRVloY3lwT1M3RzE4RzdwcG9Sb3hlVXNDaGpR?=
 =?utf-8?B?QzREbDFUdHhZZm9QMzBFYzRiakl4Y0J2L2EwSUJwd3Z2enovdUJIdTVWNWNP?=
 =?utf-8?B?RjR3VEt1N2dENzlkV3pTSHRUVlVIYWRUbTZPWmFQelBxQkt2Z29tVDZVYjhT?=
 =?utf-8?B?QldqbEtXZDY0QnVDVlpsbG9GTzczTUxVMXp3UmZ6ZTJqZG5lZ09ZaE11MWxU?=
 =?utf-8?B?TUdSdGNXT3VQUjRWdWcwMjFBck5hSkhtK0d1ekpqeEd4YkYxTllFMVRBbDBL?=
 =?utf-8?B?WVhEY2JtVUtVZktYVHJMSjR3cW11SlhwUTFlSGQ5SUxTZEk4NG56V1ZGVWxs?=
 =?utf-8?B?SlpXWm1ROXlkTU1ROGgyY0ljQndHTzB2QlhYQ3V1eEUyQVRUL1FoNkVJT3Ar?=
 =?utf-8?B?dVBPc2w4UnA4eTBaZ2xOZU54VlZKeFUybGNUclNLcW9XNmJHN1BEK05ZNVE1?=
 =?utf-8?B?UjZlQ3dvRnVTMTBOeUF4MmZ3eUFUZHFoU3crOHFwcU1ycXZiYzR3RC9tNlVy?=
 =?utf-8?B?YSs0Qkg1aTg1dnBmcXRyclI0emErb1VGOXpjdG5QeVRzNTJaQ2g3c2J6cHRD?=
 =?utf-8?B?aWYzVmpCYnkxRmtiM1MzTXAzaFV6MzE5WE9rZG1vdFRBWjJNL0d4dnVFWFVC?=
 =?utf-8?B?M0Vua3hjR3FZNlc4aTN1clduK0ZrQjJvazhFZ29lT25meXdxd01USXBQclJV?=
 =?utf-8?Q?TCzWMdiSFqQdm6Yjpao4lj+mE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b9f48b-dedf-401e-fbb7-08dd59c9eebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:36:38.4963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9hWxFNf6ipYj1tfdtTWNqWUd/TmRDisvf1juyZ04Tg4MlVM14tl1B1qVYQq3Ikqd3TV+tGts3KyhQA01reqvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5511
X-Proofpoint-ORIG-GUID: UUqJpIBpWcH5vRdV9HTM_pPdv-gvM1Gj
X-Authority-Analysis: v=2.4 cv=H6Ihw/Yi c=1 sm=1 tr=0 ts=67c4c15b cx=c_pps
 a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=nnDfVeyQVSmkwSxr:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8
 a=QyXUC8HyAAAA:8 a=Y39rH3fF7qWlq2yYeYcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: UUqJpIBpWcH5vRdV9HTM_pPdv-gvM1Gj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

PiBUaGUgZGF0YSBvZiB0aGUgb3V0LW9mLXBsYWNlIGhlYWRlciBpcyBuZXZlciBjaGVja2VkLiBU
aGVyZWZvcmUsDQo+IHRoZSBmYXVsdHkgUE1ELCB3aGljaCBvdmVyd3JpdGVzIHRoaXMgZGF0YSwg
d2lsbCBub3QgYmUgYWJsZSB0bw0KPiB2ZXJpZnkgdGhhdCB3aXRoIHRlc3RzLiBOZXcgY2hlY2tz
IHRvIHN1cHBvcnQgdGhhdCB3ZXJlIGFkZGVkIHRvDQo+IHRoZSBHQ00gT09QIGZ1bmN0aW9ucy4N
Cj4gDQo+IEZpeGVzOiA1MWUyMDJmMDU5NmYgKCJ0ZXN0L2NyeXB0bzogcmVuYW1lIEdDTSB0ZXN0
IGNvZGUiKQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBcmth
ZGl1c3ogS3VzenRhbCA8YXJrYWRpdXN6eC5rdXN6dGFsQGludGVsLmNvbT4NCkFwcGxpZWQgdG8g
ZHBkay1uZXh0LWNyeXB0bw0K
