Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8347C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AB8342791;
	Tue, 17 Jun 2025 23:19:52 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BA7D1400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:19:49 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HD5R9G023058;
 Tue, 17 Jun 2025 14:19:49 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2129.outbound.protection.outlook.com [40.107.92.129])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47b8xhh688-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJOMY9PQYrz6dOmREsErMl+9Mf2G8O8LTOpJI8TOtj5FS5Yzi+QHVQe6o9n1D5sUD+mhXw9m/FH8eppPGDsuiMb4zC6305f/4UhVHIHj/HGLwK/6eSOZCcVa3hsLbJHxD7xYJ4KGMhxDM7Ifl6sE2hCht4U8OBX4MEN2PNdaQZvSFIdlWUt52RKlwxqOwSGXikmtNQNZj/AB4U9WIqf9jZWXmhZeKPcCCV7YmLIzyVJKU5v3FTu6jXmIOav9PUY1n9m1XHMWLp4JDd9OymHyPjs2sArOOB1EtYtRWcFC9M5D3EvdZt/syXRNmRgaSdwhJ6ajgEtdj+1clVp+LVShEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4pJburuZg5U3FFdcu/u4jUvs38bB2w1k8K/ZApi6P8=;
 b=SAYaM1gavdRSiBaFko+0toa3VUsQXz1uCHDmgWfUXlHhTs3X3UIJn7Qx1xOWnyNEx0mDVWmVGlcKtC0HLHS+nGh1E/jEVv7beLKiX0AxB2TmWusNhQZmzF/ghSJAmsMGWzAxbnEZEufMcTgjrV/UOOr5hIJTHeb+ajT2JifSdvr6TmUeIXXAsQx2AAE7gJTrSX7CSX8Gy3FDQGUhtClqXLhOc3IPo3YY54MiAMIBgPzWU0oBnELyGYnbD78I13atsYMsc6y/591CwVNRi3K1Du7SMNQTTlToGgs4s8bM0b3REzK32YKKJGgqSU4OPl7Rk/qtkhEXXoLuafUqySYm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4pJburuZg5U3FFdcu/u4jUvs38bB2w1k8K/ZApi6P8=;
 b=ciJOQHMm08X3EbGoChKXSlKdNYMUSv3vWb7m30DCl9VAOtaU6yD+rfnomX9+4ReA4dlKeqDQUWLv9GEPx1HZQMp2z5pCZ3bUg6JU57ckjthKMAipvcxPDC2f/KSCdAsJLzSmB+jo6Q1reOXXRPKOKuM0rzmoDJk0kwt4z0D7v/8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ0PR18MB5086.namprd18.prod.outlook.com (2603:10b6:a03:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 21:19:45 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:19:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3] crypto/qat: remove ZUC 256 support
Thread-Topic: [EXTERNAL] [PATCH v3] crypto/qat: remove ZUC 256 support
Thread-Index: AQHb24NZ5O16HgaOyUaHM9CTyLp/s7QH4/Dw
Date: Tue, 17 Jun 2025 21:19:45 +0000
Message-ID: <CO6PR18MB4484F114B84CA05C93C1DAFBD873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250603103054.60606-1-radu.nicolau@intel.com>
 <20250612101816.241875-1-radu.nicolau@intel.com>
In-Reply-To: <20250612101816.241875-1-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ0PR18MB5086:EE_
x-ms-office365-filtering-correlation-id: 6c505bb2-c1ad-4ae1-c4e1-08ddade4aec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFdKUHVLUHlOUFFERm1ZcjhsZFYzUXFtTmZqMjkzNWJCTnl2czNSNWptUmlo?=
 =?utf-8?B?VkczY1MrOUdtWkJST3RXY2JEcWZNd2l2bExzVHlqQkY5ZW1aNFd3NUlKRkhO?=
 =?utf-8?B?enh4Yy9NTUhPSGt1UHU3ZmkxakpERHNXc0l5SHU2eHpNc3EyZnVOckI4aXRN?=
 =?utf-8?B?VFhFYUVBREZZTjFHcVJ0UG9zSDR2aVc2b2syUmdpazFsL1hvUjJSdjVKbkU2?=
 =?utf-8?B?Wm5tTmM2MmZhb3IyWlB0bEUzbUFEaGROdDNQNm5jdEFuSUlpa0FFNHJubXFp?=
 =?utf-8?B?WlFmYjlFZ2pNMWpGMG5MUXJjT083OHk4Wno0SVlacTlmSTZCQkhIN0J5aFZu?=
 =?utf-8?B?ZHlDYURPVEpJcFo0VHRyeXR3R1NrM2hVY1FDZUlCY3lJaXh4d3lrdlp5cllJ?=
 =?utf-8?B?bytGa2ZFZTc2K2N0OCtPcjBNSXlLRWV3SkMzb1YzVlhkZGJmbnRuK0lRVDls?=
 =?utf-8?B?b1d6a1RxOTZabGhUUS81ZjVSQS96K1QvdHc5SG8xamdNbS9CQURENjM4UDNx?=
 =?utf-8?B?cEhwc2JkeTBMalp1OWtkREZzMHViOFU3bmRMb1V1L25VV3RHN0NYZ2NERmlJ?=
 =?utf-8?B?KzJFSmFtckpiQUdrMWUwUk5mQ3pGTy9ZbkY4QVRLZ1BhTWhSZlhEUUJwNWF2?=
 =?utf-8?B?c2swV0txcDVRdVJIbDFQcWtnRlZ1R2lPTk4zUjhFNWhmM0Y2cS9XR2F3MFF0?=
 =?utf-8?B?K2VCTWRHN1F2OHAxS0tBbEg2NmdhM1Z0ZXJ4a2l1c0c2RU9uT3dnWWVQZjV5?=
 =?utf-8?B?R3ZraitrVWFCTlNKWFBYYnAvT0lmNE1hYXlqYjBUOW5qZVpybHJwWHZoQmhk?=
 =?utf-8?B?MUpmM0R6WFJJVUhUWWpTZVhueGc3anFJT2FvUkVGVGMyblhoQ2JBWU5LL05N?=
 =?utf-8?B?d296NjVlOUVhamc5a3lPNkVMb1h4V0VIOHNqY2FwTGZPbWxUbUp6TlZLV04z?=
 =?utf-8?B?OWRTakxnaWNwc0FKUkovUENzSEttaHAzMkd4TWg5NGlpVlJSWkNod0k0VjBo?=
 =?utf-8?B?ZmdWVlZuQklrMVV3eVBxNUFoZlBFRHhCR2g1aUU5cjU1RzVYNHpwQ1VISEcw?=
 =?utf-8?B?YUZuWERDK3ZndU96QUlhMmg2ejJoTlFHd09EQjhEM1VmOUthWG1kTFB3WG5V?=
 =?utf-8?B?WjN2eG52c0lnR1NZQVBxSHNIaXNieTYvQlF5MzhvVkRHWUUvaitFdWhhZUlH?=
 =?utf-8?B?NGh1MFN1U2hMR2FsVEhzUlVGKzNBbTlxQTdpa1pGaEZwc1NEL01hRHIyMmIr?=
 =?utf-8?B?TU5aN1k0S0hUN0ZmVXJsYUtEVGF3UWNUYXZUZGl2c0ltWUJ5QmFKM1cveWxF?=
 =?utf-8?B?VVhwTmJ6V3NhM0Z0NnJGRkozOGtQU3lFbjdEMUJma0piMUI5WEFjN1JiVXFq?=
 =?utf-8?B?RTRSS0k0WFFmVDZDTXhmaWtBeEtXTk9nOGhoSldmQ3I5c0JVYUxmaXprQlEw?=
 =?utf-8?B?Z0trbi9MaUJmQlNLQXFoUFNwVWI5cnJSa1NSeVBaVEZlK0l3ei9wSklJd3pS?=
 =?utf-8?B?V0tLQUdFTFQ1SnluR3l5aURSZzBQYW5Gay9BMGpFeTdyWE5zRjVna0dQdGkz?=
 =?utf-8?B?RjZwZVdNVmt2QzlFZDhlMS92eXJOejl5TVlKNSt6YURqcmZMMXJzZ0t1NmRU?=
 =?utf-8?B?ZiswdzNIckJ6TTVscHNaVENwZ0NDRC9zZkZITFdkSUFaWjNtTjJmQ1dSMFRV?=
 =?utf-8?B?M09udWF4emZmOEJyUTBhZVZodHpnS29BWXlvMkdRNzk1SGpadHhsZTYyWi9a?=
 =?utf-8?B?MkxPeW9WMHJvU1hMRTlFRHhNWXJ5Z2hlM0lvakNheGRuY1RmM3BZeTZxbkdo?=
 =?utf-8?B?WTluU0NPQnh4UmFPRFJxeUhndGVaeExiOWZ3Z0V2bFo2aHpzUjJEbjhwQ0xV?=
 =?utf-8?B?OE13ZXlzSUtVT1lEWlBIQ01TellnRlRmSENUbzk0Nm9namJBeE80ZGJFSUxU?=
 =?utf-8?B?UmdOakZ6VmNKSXlLbzlyRXc1Q0lBWFQ0WHRDTzVCQ3ViYm05cExDNndxdUV3?=
 =?utf-8?B?TGo3cFFWZG1BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmc0RTROcE9JaXJvaVVKNi9YUmQ4ZGhWWGJtTTV4TlQvVVlISUorYkNFZzJy?=
 =?utf-8?B?UVJQczZHTHljY3NDaWpYWmc2dFd4RTdMaC9KUS9FVHh5RnlCbVFmZkp6eHFX?=
 =?utf-8?B?ZGZUYVVrd2NyYStRQXdiaFBBNEJHYWhEcDlraVNyb2VKa3gzMXNLVis5OHov?=
 =?utf-8?B?dEVpNVJ3L0pWcytaL1lid2J3WGdra1A1a3FNM1lmT1lSNWtyQ3RKWit1VzhV?=
 =?utf-8?B?UnQ2cXpWYmlsV3FZQXpGVGV5YlcyWm1DbWh5cW1ORGlZcVNrQWRHSjcyY3I2?=
 =?utf-8?B?cGN6OWJoenlQdk9abjdTa3A5QzJtZDZrY3FBYndqODFjNEdUZTRkR2s4aWRI?=
 =?utf-8?B?ejRzc2xXd0Q4a1dyRVhrV0p3L3F6Wk5SeGR5NG5RWmtpaURvS3ZpdnhsR3Ur?=
 =?utf-8?B?Ni94a1MvVWtodjZOcjU0Rk9NdDRmRWpEYWF1T1REV0RaS0tCcE5RTXMvVHNt?=
 =?utf-8?B?STM4dFYvTGd3VGR4Q1BvVjNxSndhakdiMWVNQTlLeExNTVVQMU1aY2IwKzVZ?=
 =?utf-8?B?cUh1ZG03dzlqU3RtMVlPeGtBVldrZHBoVlozRFc4eGVoVlpTRzV4NXplZFJI?=
 =?utf-8?B?Z29aeEszNjQxaDAwV3VycnVzSXZvVDBhSlpkREFBSVdQdEwyeXFGU3poWUNQ?=
 =?utf-8?B?RXUvR0tJenRuZVM2RFhWRkpLQ1B1a3BSM05EU2tVUWF4dGwzYmhibjlwY2J5?=
 =?utf-8?B?ZmQvSFZkU2ExMHdLTXhzN2pkN0NjUWtlMnFBRmc0dEZQRDJSY0tKN3hvM3dC?=
 =?utf-8?B?YVRQM2tGaGV6R3A0QTVxNkpDR0RHUlRtakdLeXdtSmpDN1BSOVJZd25vQzRI?=
 =?utf-8?B?eDUva2xEaWNFbGxsSVVacDlVS1JlVEpheGhPMmVxQUxvZzlWSnl6cnFKWVRT?=
 =?utf-8?B?czJCMzYvcEdta0s5TUxhMWZxZWR1TnNtVlJTWFJwMHgzU2phZStucEVoMk5o?=
 =?utf-8?B?YWMrQkZQTUlFZ3BIVHpBRnY4Y1J5eTJMVnd5T2lkRmlhWG1hTGs4Y3RpTjQ2?=
 =?utf-8?B?ZVpYenIrY3FmYlpoT29hWGlFektJSHhjdHZSUXQwWFg2S2ZRZFM3MkRiNStB?=
 =?utf-8?B?dGRlbDJsbDIrMW9YWWU4dDNSankvZFI3ZFlJZkRERTZOa1Y0Wlorc2o1SGlG?=
 =?utf-8?B?aW1WZnh3Szc1YnBieHJIbUR1T2pkRzN6ZGRXRWx0cFRlaTc5MG44N1kwSVhk?=
 =?utf-8?B?eVBHWUpYRk9HMFZDN1NMYUVNR3V5WUtuSTV5YUx3ZUFvRzdaYWtMSlpxOHFo?=
 =?utf-8?B?OTMzaUZsSmJ4N24wUjA0OXdsT0JKZ21aSmFvUGFzdi9wL2UvU3BzTjlmcEc2?=
 =?utf-8?B?cnRjTFNzb2F0aENGWm1MeDhWVUx3YklhT0V0TGxaWCtoTEFGZDNmTzV2UWFj?=
 =?utf-8?B?QkM5dzREeUFseThkSmFwdXA4UjBmejhNQktuNzRKMHQwL09pRlZqN3J3ZWFp?=
 =?utf-8?B?L3BteFBuMVR2bUppMG1UMW8weXRhSXpEby9lZWhJZHdtTWtFa204Q3NvcEwr?=
 =?utf-8?B?d0xPb1NXZEUvS1AvQkUwZE5DcHVudWFHTUxiWHNRUHdYbWRQcW1TajFXcit0?=
 =?utf-8?B?ZUJ5RHY1SnlXallnTG5wRStYVTNGUCtKS010L1IwVTJqSk9sVUNLOFhZYmtu?=
 =?utf-8?B?SWdSYzFHbVpDTFFsb3UvWEIwRDN0RnhtUmY0V09LZldsS2FMTGE1VmM0SG5h?=
 =?utf-8?B?YjZ6RWkzVVp3MHBQejU5N3BRUXF6RHVVeit0TWtmWUIvNHhMUS9tbjBNUk5h?=
 =?utf-8?B?Z0gxVVA0S1VQbk5veGxWZ25vdkFGS3E3VEJrQUNUOTZ2TldYOW5Pb2g0SzJx?=
 =?utf-8?B?bDRwWC9MOEZEZ2dUbnJtdnJVeDBYUFdKZjRueWo5bWp2MDJoSjdxVnQ5VFRs?=
 =?utf-8?B?N0I2ZXVEcFdjUlpwNjVyUVIyaDhsNkI2ZTNYVzFQOFlYQThLUU0vb2JSR3Rl?=
 =?utf-8?B?Yjlvc3M2eFN3Y3BMTFJkMkxYcHRnQWQrNW1OaU96WEdJc1BCY3ExZHBGcjgr?=
 =?utf-8?B?YzFycStBcGRUZURVc1RtZDcxQWQzNXczUjdZc09nUlpnZ2FtRjNZekZBM2Rs?=
 =?utf-8?B?WE0zVGpTUTdqWSt4RVl1VUlHU3pvQ2FUVWlaUnh0TXdGT3FydHhodGI5cERs?=
 =?utf-8?Q?ov0s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c505bb2-c1ad-4ae1-c4e1-08ddade4aec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:19:45.2890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNg7wyE5A2G4HLgFRWTTasOtP7DQwcqwfkVkuKatSzm5u8zAzwnyJRG/ppE1oKbPMmk59+MtEnr4ms45NDOd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5086
X-Proofpoint-GUID: mlR-MAtUdeFeRNd44zuhFGJozvGwsL8F
X-Authority-Analysis: v=2.4 cv=GJsIEvNK c=1 sm=1 tr=0 ts=6851dbf5 cx=c_pps
 a=NdA3fqtPcSv+XNmBl5L0lg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=lx3pF29cc8o86inOVzAA:9
 a=QEXdDO2ut3YA:10 a=U7BLxpm3AvUA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MCBTYWx0ZWRfX/LrIAtk+60or
 9h4DnEeohdaI7LMTHGbOWsvxMK2vZD4B/zrsxU/Qb6XeFiWUvKFusfaleJOgZ49YwD0OTNJ7BYt
 rmeiZQmr0KbJr7nEZP0N2I9aago/BuS5lsdPAP/4dEoeU2LULgCRdqsV6d7RrEVm1x4s33h08vf
 Jfe67L4Axij60H6+k55MPkpkZXyIVWskfkxVHwGuEVJtb/4WEJYrxD/rbNApwRiYa4llh1+7GmC
 9B9lCp6V/AuT1E9fVULmuUiWo+8XtwSnAM/FZltxZ/SATKI8V0qGWg5PjM+0fIRmKcckGn9uVkC
 FzFrmX41GumrrzDf7SenBR6v7pZRTofejcyD0buWIqfS7PZdJ2BNTU/iRcbVuYzCB8EqXlS0+8o
 W/gx9buQHvZqXATWvxuYy4T6rEYhmqteaFvdE7Srntm2oICU6al1uiHOBU1HM5xPba8jPd5K
X-Proofpoint-ORIG-GUID: mlR-MAtUdeFeRNd44zuhFGJozvGwsL8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

PiBEdWUgdG8gY2hhbmdlcyBpbiB0aGUgc3BlY2lmaWNhdGlvbiByZWxhdGVkIHRvIElWIHNpemUg
YW5kIGluaXRpYWxpemF0aW9uDQo+IHNlcXVlbmNlIHJlbW92ZSBaVUMgMjU2IHN1cHBvcnQgZnJv
bSBHZW4gMyBhbmQgNSBoYXJkd2FyZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBOaWNvbGF1
IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KPiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50
ZWwuY29tPg0KPiAtLS0NCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KVGhhbmtzLg0K
