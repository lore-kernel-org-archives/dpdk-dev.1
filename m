Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F775C282D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 09:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4DC640156;
	Wed,  5 Mar 2025 10:54:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1C220400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 10:54:44 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5258qSX3019045;
 Wed, 5 Mar 2025 01:54:43 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 456kg183tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 01:54:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4PhJ/ggCl5g+hs5L8FcrAmkoP9tutAMZn3GHKu1mkfB5mbvC9AgR0s2FK5RBatiyi/q44kOe5p/ycnDU2ujB9Cg3nmUZ08VBY+pkOXvSqkrGrkJIosslrtkDmFBlvzTYaCxWhGIQuywlu1culqy9VXGjgq/XIq8nfXDzwsc3+UxHMnL7tZbXp6y3kF2O+8yy31uZqsA6KXNy71fAU2SOMKf1VqZEJoWBMoQDBzgY3crkmPTQZGnRL2QJwWlmqdmvOZVsP+LChRAx9f0HX5KemGVvJo5wCjrskOovpXMuLvbJDbxXaz9HIMVu/r1+0tq1K09QHgUvHu9EyKjeLxPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvxQUTXqY0EdXxBaLlCUwD4MKw8UyZ+P893uOMdNJ3M=;
 b=U11D3ueuZdgIsOZh5Hx08fTj5ghJd6DKcUb96dEPuCA7SR9TmifGb6rsafPeekzxCcbKZgwPCk8Bs6BMdiQuIIXQPrzl+bV3n8kuaGO386vyFGs11OJx4Td+QdBOAqkwufk8wsxHEiU9Dq1YBd6fz+tptu0Buy3YY6tCBbmQinbqFqwgWXBiY0p3A1eV6O6mcIbUj3FZgUEHrkmSR6LYpuaaQbgy9nrqdPNyCfeWSH7lbVW53yWIpeUYjXFRU0eRXo8hRgASrHQgk/vY7tffkWyY+TLOkmWosXtInT9VSVd3L41fX5d14nz+apr+CTTk4lGguMrv51L0K+G+PUOVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvxQUTXqY0EdXxBaLlCUwD4MKw8UyZ+P893uOMdNJ3M=;
 b=KHQlWx5BRVaH7HN80EhPfHWzdNnfKDfdaSbxjTvEj3OvBoP4G3RlzIHaA56BjfywuDBOeMSc0LgBW9MkfvTl5/erBNu1Xa/ZwC7BJ7JmJ2CJT4vdW/7QE6tHih53wqhb1g+G4uC0Zgov7Od6xu/8p8Ud3VjM1aCJuZSE5ctRlLg=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by BL1PR18MB4374.namprd18.prod.outlook.com (2603:10b6:208:31d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 09:54:26 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 09:54:25 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Akhil Goyal <gakhil@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] vhost/crypto: fix build with asserts
Thread-Topic: [EXTERNAL] [PATCH] vhost/crypto: fix build with asserts
Thread-Index: AQHbjbMUNxp+etQxLUaRo4djJ1HWI7NkTUiQ
Date: Wed, 5 Mar 2025 09:54:25 +0000
Message-ID: <CO1PR18MB47143216D572CBF3887D71D0CBCB2@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20250305094323.598983-1-david.marchand@redhat.com>
In-Reply-To: <20250305094323.598983-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|BL1PR18MB4374:EE_
x-ms-office365-filtering-correlation-id: 0de9c2a7-a510-40cb-fee0-08dd5bcbb698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OXQ5c2xLbGpRdlRpK0NXTDNKWU1ROStIeGx1R3R2bkQ3VjJ6UzhycTF6QVYx?=
 =?utf-8?B?ZTBxaXZJWWszQlcyK2RiY3lBZW96NVZ0UGZoaHlieXhoS0pKY3hIZFd1eDRq?=
 =?utf-8?B?RlRFWmRUK1NzUmZWRTYrd3I2OXBiRGp1RGRJTllXZmVRaWFWMkVUWWJ2US9U?=
 =?utf-8?B?bG1adnpvR1BkM1NPNE9nejRFS21ocFpZL3ZiQ3A0RWJLQW5NQmN1Qm1vbzZr?=
 =?utf-8?B?L1AwWnNVRWQ2MkxlQmliREJZaTVJZytxQUUxRkl4b2tyc2VZVzByVklTQWlm?=
 =?utf-8?B?NVNFQ0RWT3dqd2xCeFNYTTMwSDBRMUtqcG4zYVNKVHFhTTJINEZtbXQ4VGVa?=
 =?utf-8?B?aVBmYjlndnJUWjhYZUxMK2E0SXZxemxPdTd5WFZ3eGlkbzg5YXpjQmpYc2J6?=
 =?utf-8?B?akRNQXl4SlZEaGNYajZqOHo4bFJScjArWlVzSTNISFBGQWRkUS9qRFRGN0k4?=
 =?utf-8?B?VnQ0WjBxNUd5bi9uaGFLdDdRVU42Qm4rYXd0M0FKYmdhcDgrcHdpUCtkSWtI?=
 =?utf-8?B?SzZDZXlZbXhCUEtVVWh6Z3RjTXRQNmhxRHU2dVZtRWRCWEFrbkJ0WjFHTEpQ?=
 =?utf-8?B?MjBqNzVtc3d4MytYV2RtcW5VUVVBdC9OSmZ4bVhGendLRk9sVkdTWjdDeU43?=
 =?utf-8?B?VUlkaEpObTBGK3l0eFhYWnVmSG84ajk2dGpTSkdMcEZzV09RZ2tZa3MwRHQ3?=
 =?utf-8?B?ZWxiTm5uVDNXMjl5QS9xK2ErTTM1TFdFa1pta1Y0QXIyTDJoUTN5cXZNb2FB?=
 =?utf-8?B?RXFzaG9OcTZPV2tKZFNVU09sS2Z4RHZiTy90NWxmbnphdjZoQTlwMzFzR1Nw?=
 =?utf-8?B?QzBxM0pNRUlBVG1TcjZ2NXhzLzhBdzFBQ0lEaURVSVJvZUtOTkl1cWlEVEF2?=
 =?utf-8?B?Y1p6NGN2Q2V5ZExBckFrV0cxUEJCVlpLeDNPZEpNdjVoT3V0cjB6V3pSVU9B?=
 =?utf-8?B?bzV5a3lqUmJ1UUtQZU9hQmw0RmlZK1dYUUdXeisyRTBVcEdLOXhjMzhvSG9O?=
 =?utf-8?B?VFBtTmR0bXBsMmluTVk2bzVTK3d5MHpXR1F6clVjSERSMk9JaHQzRXlnaEY0?=
 =?utf-8?B?ZDFyL25hckJhWC8venQ5KzZFMHJtYlFsek05ak9TNHVPU0hNSnpidlVvMHRp?=
 =?utf-8?B?RFF6UmFGNHZvQ2JZZEpxeVd3WlM1V1l2OTI5Z3JGdWNmaERMVkpsMXloRWQv?=
 =?utf-8?B?VjE2QTBhK2lFQk9YVlgxS09wZDZqVVlzSC9aMG9LaVh4bktjTVlrSXU2OFMz?=
 =?utf-8?B?T0ZXam5rKzdLRW41TFkxdlhnYXlDeUZzK2NEVVE0MnkrbW0rU3lYR0VXdkVq?=
 =?utf-8?B?dVRmaXJSQ0xySWY4by9vakY3M25BR1JoY3M4Y1Fydzd0TFkvYnlpMXN6RFZQ?=
 =?utf-8?B?bVgra2dTUC8zWWJoVnBENTg4ZFlWc2FiQ21EK2doZXhEbnVUN0tEcVlBSnIx?=
 =?utf-8?B?V0sxRUJmQnNtQ3RvdUtpV1U3dVdIRmxyc1dESE91dTJpS0R5UzFLYjdVb0VT?=
 =?utf-8?B?Vy9kNUJFOTdESXBndlpCNExSclFQL1V2bDJ1Z0JvZ0pvdThoSzdQUGxEUnpY?=
 =?utf-8?B?eEZyWklhbFN1Z04zSHdTT3BRMFF5bmpvVlFudlNZbGVTdC9YVU1zdFFHcExv?=
 =?utf-8?B?V2VwVWdMN0hpcXJmSnZ6WU5IRlZ2Y1p1S013OWVtTnpCWkJ6YVo2dDlSZ0pL?=
 =?utf-8?B?ZXhRb1dkcjkxaUg3WjZiQzhWN21HR1ROd1dkVndETit3VmVFbmZvUk9WRVpM?=
 =?utf-8?B?TXlNWncrdzNwL3o0NFpUeXB5dThzNUNCZW9QcjhtVWkwcUxxYkNnRGsvS1lR?=
 =?utf-8?B?ZmpWc3R6QjdTYUNJdFJLdFhYK0djYTZlcHY4eHVuOFdETjR4MVRuMVRKdVQ5?=
 =?utf-8?B?eno0aGcydDFUaWZSRkdzZXFSdVExZUYxa0ovUDN6cEN6RGxKbDZzOEpYb1Ax?=
 =?utf-8?Q?TEJZvBw5TKdxLErQBHyWnPIW6R3FFy4p?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXAwaFR6QlhVLzFyR1loa283L0NQZ2ZyL0NpbXBGVFA5ZFBnb0hHd0JtbzdG?=
 =?utf-8?B?RXkxTlJmSnV0WTh0Y3dsbThtYng2dVRDaU9SQWYvRU1pbnIrRGFQWWErSTJq?=
 =?utf-8?B?TzhIYlF6Ti9UdEp2STZSNTkxWlFkNVBMTVNWZCsyN3BKbDRHZGZCY1JZVG1F?=
 =?utf-8?B?R3JxMHR1Tjh3MVN0RUZBZEVZMXdjV3JaOVNkV2diK0ZiQk5CdWNtZGgrRjhF?=
 =?utf-8?B?aGo1anRKL2pOZ05PaXJ0eWJkUU5mS1hKREI5amZCWEF0Q3RYUndUTDBra2to?=
 =?utf-8?B?cSttTDJyUFlKVjU1Q3pMKzZZaStoZy9oVkpYeE1sSnozTHF1ZXpqTDN6RXVY?=
 =?utf-8?B?c0ZmNzBIRlFySmVKbU9yMXlGdFg4QllxbmZVa2t3UWJ6eEZSVmNCRkhsTUJV?=
 =?utf-8?B?L1lCbmZpa2ptaFVaWmRYNHlWYlZhRlJhc3RTUVNvZjhvZGNkZ1BvNGgwMlps?=
 =?utf-8?B?SUlzdkZLNDBXUUw0dlZPQmswQldDM21qbzA0V1IveXF6T3pIdHoyYnJud21u?=
 =?utf-8?B?MDdVUEdGUHY0d2d2UXljVHdaTkt0NXFacjg3Q2F5ZCtSdHhjbWppOSt6c0NV?=
 =?utf-8?B?WFM2WXVzcnNqRzJTWG9KdE4zdkMxQjJ3cmI1UFZJTThYcUdPS0xNcGFMZXVT?=
 =?utf-8?B?K09IblE3T252YzFYb0tUNHJxRjZYV1UweFRHUW9rd2VoaGQ3SEl3dGNBYzBU?=
 =?utf-8?B?REhMUmRLS3hTMXBZdFJpS0hvTllTS1phV3U1Zm0rbjNxMUF1ZWF0dkhnUitu?=
 =?utf-8?B?V2UzQ0xPdkpJYWcvaFoyVHVuRVZJTWVGSlJ4K0RZSFVkR0dkc3hXaFRLNXJX?=
 =?utf-8?B?bGFIWGVka1NWQzlVK1o0UW1HVWdXS2ZEait1dzl1eUc3QU9weDNzaGt0ZDUz?=
 =?utf-8?B?ZmpEWFpSdGtQNmJrVUhkVzJyZWU2Tkp3UUx3RlB4aHJEU29FSjhYdkVEcHV4?=
 =?utf-8?B?Z1U2ZU5EWktDbzdvQ0ZrTzUyTUVHTUp2eE1nYXQzbWljMWZ5ei9ka0FManl5?=
 =?utf-8?B?d2tIeGd0U0RjY3plL3A0czArTXRzaDE0U25wZS9Jd3kwK2lnU0V1K0REdmVU?=
 =?utf-8?B?SXFNTmIyVk9BNE1jZjk1b3lub0p2clVOUW1WMDJOM1pjaGZhbGE2MmNXRGY4?=
 =?utf-8?B?TzhNMCtZWm5PVitmT3VpTFJUeU1jYjlyMWQyV3h0Qm1WSFAyRzg2SmhiWG1L?=
 =?utf-8?B?KzlxSUZWREJZUDI3NElRMDFueEZEeHpHMjNIR3FjdiszaDdMOG12T2xFd0Fy?=
 =?utf-8?B?cTZKNXlUdTNpaHE0cm1MOTFISjJKTVFPVEVMZUJZdmNSL3RQb0g1NWhUazZv?=
 =?utf-8?B?SGVka25KVjZUb3VmSkdQcXB2ZjBLOWlMWXRuZjJVZTJjL3JLVHFIay9WNGVi?=
 =?utf-8?B?S3JLT1BFZkthWTFmT3lZV1dVT0tWU1hlYnJCZVlBN1MwWTJ5MUdaUUJyWHlV?=
 =?utf-8?B?N0ZMeVFUSmdyTVU5WnpNYkpidm9QbjR6ZHJkb1hSWDZFOFNHQ0VhZTNNZWRP?=
 =?utf-8?B?NDZnU1pDM2NQNjZST2JWWGpITzVmV3BieWdHMHZYR3k0REJZZWhSRm9YL1dv?=
 =?utf-8?B?cW4vcjV5LzkyT1pmUnA2dkk3aDE1a3YxV3QzQVVIVUpZM2tZREVEV0FJdGRY?=
 =?utf-8?B?TmdSa21haG1FSGZEK0NUY3ZNcVNyREZaaGZXU3JnOEhXbjJ2all1aERkY1FK?=
 =?utf-8?B?UUVyVFVMTGM0TGF4WWR2TmdWdFI3QzJTOGRLQVpOdXFLUGVFakdzdGhnQ2F1?=
 =?utf-8?B?ZGJtbms1UnlmeVN6NzBidStTdllmWEZzQ082Qm9MOXJ5c21WTkgxUlZlTmYw?=
 =?utf-8?B?dmFETXRNTHphaFFmeXh2K2hhbUlpZWxSMW4veHJTSWMzNXZ6bVdwNUdWYld5?=
 =?utf-8?B?MDJVK2ZONkpvVm5rNmdEQ3pvSExoUk1WaUpzb1NHVXdJeFN2S1NzQ05VSUpi?=
 =?utf-8?B?eVdnM2tqUmxLOWJOZnZUUUtQWWhPbXpxV0wyQ2N5UzkzUHNvWGdldXE0QjRH?=
 =?utf-8?B?RjkwTDcxY0MvUTY5ZElpSjloWDBYNDkrMlZPMXJiOW8zNjFpclZEaThkellH?=
 =?utf-8?B?SXVxaFI2RkNmQVdVcGF1dUxyaHV3S3E4ZmlsSTVSVDJHYjRvZGxTL0VOeGRv?=
 =?utf-8?Q?uMXmKoJy78TiWAk2RS8Tc2WJZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de9c2a7-a510-40cb-fee0-08dd5bcbb698
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 09:54:25.6256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjFGkUXOEXRzg4mpL4h3LiPNnZwkZimyC664ASge6z3fa0PYUNacMjZEh7nsN9RMouMeeLyGNoicDkwaB6BWY+v9V5A2KumBStefpOG4YyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4374
X-Proofpoint-ORIG-GUID: FamTP3nugMJ8L5G4gp4B4Wu2GckN8b2x
X-Proofpoint-GUID: FamTP3nugMJ8L5G4gp4B4Wu2GckN8b2x
X-Authority-Analysis: v=2.4 cv=E7k3pbdl c=1 sm=1 tr=0 ts=67c81f62 cx=c_pps
 a=IYePPuTyj3qIg1BHBNk0GA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8
 a=EN3F-9FWvmR7jCWLoycA:9 a=QEXdDO2ut3YA:10 a=thtoIbeCf2YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01
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

PiANCj4gRml4ZXM6IGQxYjQ4NGJmMTg3NiAoInZob3N0L2NyeXB0bzogc3VwcG9ydCBhc3ltbWV0
cmljIFJTQSIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFy
Y2hhbmRAcmVkaGF0LmNvbT4NCg0KVGVzdGVkLWJ5OiBHb3dyaXNoYW5rYXIgTXV0aHVrcmlzaG5h
biA8Z211dGh1a3Jpc2huQG1hcnZlbGwuY29tPg0K
