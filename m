Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7700C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CC3B42791;
	Wed, 21 May 2025 12:28:02 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 830464065D;
 Wed, 21 May 2025 12:28:00 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qnl6012831;
 Wed, 21 May 2025 03:27:59 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc90pe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 03:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDz95T6oRSW+A4Ad6qAP8+UBqE1GUx0QUkIUYyhgXoxU7W+PJeLaKFfx6gRJ+C7QgzEWFofFEmDViNNkiWfbKYCXp0sr4MQQvcPh0HmY5beEkcGK0EYKs4pgCzny3hseJmfbW6ADcLrd/dzQuVtiZJFft6MwVWrqqt+EQAhBsea8rr5Fogg4gTMQO5rzQR0/RN0jczvPIAaUtFgWA03UMisPqUcxE/BhBEieIGdjHQ9atIvxu+Xb8qhy0w8eCknNWY2Jk4bjVJKuZwWtVktp+c03QxsZZ6QyoFhX1oInvXoX0ioAzXm12RWkTGg94tzXQH0hjCKlBBpC835dmYTCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFREt10F8edbyPqOBd2aytVLGik4WTFxxX35AwVdbwA=;
 b=fKqRekbM6VY14H+UT4AaeA6GwUnCz5aadxEtkyGpPAluJIDqQXZPRy8chOEes4EFYC0N4PXb5Auf/+oWo/JuedMvi1CmHBpxMrY4NEloVr50ZzLsZYADRDy2ZjOEnKUOI9YpbyXZQnJ4Mm6PsCP+uCy4USGxvRvqekW9Cp5RP2oe9r/ROxTSPLIAAZ10z6bifyRX0auh/5XCaADjeeQzJz1RZB71RYcyQ166h9C299hbYLQgmMI1NbHUFPcNlY0kVR1Uq1+55Vr2zHjbau+oldH+87rX0uQa2+zBz9giSAhF7G2UqtuXqRPzPdEWkFtOiYaoLKlS9RILF3gEkuyvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFREt10F8edbyPqOBd2aytVLGik4WTFxxX35AwVdbwA=;
 b=SyrcTAQseha4JLzTyppzW2xcQ7S0GJ3Hbcp/bV9LjASPsn/S/JZjgMoACGBWvJg2Lcu0tM7mEo2Ita1uXV0dnFIY5acSgZJ50GyvaG+QVAqbGBH0Lvlhs1/rlnT5R7BfDTWUDbf+oLOv4IdRvQCJXyjU4i1ujb7OCbz7Yk9jCG0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ4PPF4767F91D9.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Wed, 21 May
 2025 10:27:56 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:27:56 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Shani Peretz <shperetz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Suanming Mou <suanmingm@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>, 
 Brian Dooley <brian.dooley@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: RE: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Topic: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Index: AQHbkmQ4k3jiwngNXU2n+5Mwha/pIrN3Jx6wgA3xY4CAVMRngIADdDJA
Date: Wed, 21 May 2025 10:27:56 +0000
Message-ID: <CO6PR18MB4484382B9C20A01BB17EAE63D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250311090122.121190-1-shperetz@nvidia.com>
 <CO6PR18MB44844B0F7C3BA22106DD9620D8DF2@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SA1PR12MB9491AB9BB59AB52B0D3A37FABFA62@SA1PR12MB9491.namprd12.prod.outlook.com>
 <SA1PR12MB9491AEBA0261CF7E7C07D67DBF9CA@SA1PR12MB9491.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB9491AEBA0261CF7E7C07D67DBF9CA@SA1PR12MB9491.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ4PPF4767F91D9:EE_
x-ms-office365-filtering-correlation-id: e7a81198-578d-4955-b818-08dd98522707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SzRwK3RSY0dKaTBqM01INS9Cb29FamxLMFpYYVFwVThCbTJ1dmV5enNZeHN3?=
 =?utf-8?B?SmVXaDZQQ2FwcjUzMDV0aDFPMUpBQmlmTytFTlhkNWtNbTJyQXJqUlcwRGVR?=
 =?utf-8?B?amR3K1R3blgweUxhSDNKcGthdmNsRzNWV2YxSWM1V0lwR2JaZ1A4QmNuWlNY?=
 =?utf-8?B?ZTZyQk43aWJHZFcySS9qZDVwTk1vbTFKd1h5ZGNoUnhiUHduaDhFUnd6b1dQ?=
 =?utf-8?B?WDVubVVBWWZldnRsR0R5WDlwYXBjSXUrenZ1aExzTndrMjliblhQajBmcjg4?=
 =?utf-8?B?VlVRN01nSkc3cGdaaVFSL08wYW1xVnZUcHkvVnZkRVVjaGdFUFl5eWdrVVBQ?=
 =?utf-8?B?eDBQUStZTTZIUXJ1VlMrVjFvcTJTN0J5Q3JYdU5qZVg2UFRBRFYxcWp2aGxq?=
 =?utf-8?B?aWVIaEsvbll2dDI5WkF4eTZUZUd3NHZOd3VaOFBDbENZNVdRWWtlSzdac3dR?=
 =?utf-8?B?T1Y1TkNsYTJvUTNySmFpMnRpVDN6Ukw5NCtSeEZyek9WOGpOK3NBWDRSdng5?=
 =?utf-8?B?UlFkckl3QkttcGdsRWw5UVIrSS9OUTQwUkhweG1heEVXQThKZHFWQ3JXSUp5?=
 =?utf-8?B?YlFlbTdqLzR2QWdZb1V3cnNRSGVnYWRBSmFXMFJWSjNCTUJmZDM3OHhPbE9i?=
 =?utf-8?B?T05SU1dCeGtUYmd0K0tuYzRsakxldmZra2xneDhQZkc3OHNSNmQzTk5oMGY0?=
 =?utf-8?B?RFRLTm9Wcm50TVFzM3UweHpXMWE3M3U1ZWpibEpRazdRbFBUSER5TTBNQTBQ?=
 =?utf-8?B?dEQxa1Q3cjV1UjduUCtCRzRtbGMzbDI5eExlM0k2YlRtZXk4aDhxVXBnakFx?=
 =?utf-8?B?aUJLVTRMQ3Vya3JmMlk1alIxT1ZuODRaR2xHaWtKZXVmaWw1ZUtwWTFKSTZy?=
 =?utf-8?B?aW5pc29YVzE3NmhFdnZlS3NjSk9Ocld1VmE5SjNPQjYzL0ZFN1NsSVZJbnQw?=
 =?utf-8?B?dGZZZlNHdHF3S0U3TTZWY0JWNkNpNFRoeDJrSGtRT3diQUIveVR0OE1nTjg5?=
 =?utf-8?B?TkRoL1d6c0ZZMThGZ2ZVK3J6dWlMZlM4cDRtRWkrVGZSZUtiVWM3NHVWYWZm?=
 =?utf-8?B?cEVNRmlxV0ZGRnlheWhoSUJHVlJuV2VNVXB5MEdIY08wM2JaUS9rbDFob05K?=
 =?utf-8?B?ZXUvTlVPc0hOWVYxY0ZNcU1sVHcxT3JJdmU1VnFrbmM0cFFFUUx3eVg0Yzd5?=
 =?utf-8?B?VGJ2bCtrU2tQL3M4NkIwOE9YL2RtcmMrWit1ZVBGTkQ1QlRKL3JKWS9SWjVi?=
 =?utf-8?B?NFFvTGwrQVl5b0VvV2RCRE1qS1RuVFNWZDdHemRiSU9JTWJhOEFBTG0vbzI4?=
 =?utf-8?B?VGlhc21BOUhkZUZRdkJWbXRGUUN1a1hRYjBFU1g1VXBFS2dJQjVkdlNGTHFv?=
 =?utf-8?B?VFFXdk1sdVZCUi9EaUR5Y29kVm9GOG92S214NUJCeG1wRTVRSUJDUG93TFQ5?=
 =?utf-8?B?RDc4dHVlRWZ6TC9EdVpCeW9wd2s2TS9sVTM0YmJFT01lUE5Ra08zK3ptSTl4?=
 =?utf-8?B?d3hUeXdJZWJ2Rm5SZXZkKzB4SWlBMmd0TEpuVUlNTUdwMWxFZ2h3a25yUW4v?=
 =?utf-8?B?S2x0MUs0andkeVRna3BsbWdCelVVRlo5My9IWW4zam0xaGhHdG1ULytJcmt1?=
 =?utf-8?B?R1kvb3BxQzhTYUZMZzY1YTYvRDBuTC9RU2NnNGJvVkVvWGFydGdhSDNvQWVY?=
 =?utf-8?B?M2FjYkRhTHczbmlzeGI4WW45VDJIVEQ4aUQ4dU1HMHZPOTJqRWNaTG8zVTNV?=
 =?utf-8?B?NGZjOW12Y0VtYlR5U3JHeVZuQUUxKzlXV2x3S1YrTnVvZEVEUXc1dnVEWmE2?=
 =?utf-8?B?VXJJaGd5amtRZTd1M2taUFEzQVE0NzR6a1RzSGZkczR2RVpBSXJCejV2MytK?=
 =?utf-8?B?dkppTlJ6RS9aRVE2VnZqSlBDZXE0NGxlcGNIc3U3UDlHdE5qK1FWWHRYelNu?=
 =?utf-8?B?Y0pLbFEzM0MrL3piRWtYdGFZSndIMWVJbnZYSDFCMmlvakRxSGVMSWw3Vkha?=
 =?utf-8?Q?ecJi4PWtPzzEScWi7XWJIMQL9LUUiU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkRmM1JMTFRwSlhpTkJ4SHRHclpEK0JEVkVBU2g0elI2ZWprUy9NaWxYNzRh?=
 =?utf-8?B?MVk3eUladC9mMW1LWDVaTGo1emNFZ2RHOFlJb0lJS3J4Y0NWcjBKZ3hUM2N5?=
 =?utf-8?B?bjZoWHc5eU9Sd2h5WnAyTHBiaGt6Tmt6Q05GNUE5eVhiS2owWmlwMEVGaWdk?=
 =?utf-8?B?L2cyNCtMV3NMbHZQc2xIMytERWJCcURrbWw1NzMzK2R5eGZXV3RjMjl3MGFn?=
 =?utf-8?B?cGNyWG1sL0xaczEwK0VTWnFoMkR1eVJMeGdiU1pZckhSRDg4SnlrbUlwN3NM?=
 =?utf-8?B?NU1TeHFmZnNHdUdhZUxwU2JXSzF6Mmh3REZWTDFYZGFHcDhBZUUrUUNvTzRw?=
 =?utf-8?B?ZFc2YXo0WjdtWE5KWXQ1Ritrc2FCNDFad09sejFuL0x2U3lLMjhyTkQrMjdK?=
 =?utf-8?B?R0JwbW05b2J1VzUxVWtsYm5HaEg4NXhMWExhV2lwVGNkUGx6TlRMYmNBNWZN?=
 =?utf-8?B?RVZ6VnkvbHBaMGFiV3ZpNzltUGJzNFhJUEhZRFhhZ2ljbE9ETWpWQ2JSRG5U?=
 =?utf-8?B?QXBlc2JtWUdwcWs5VytsUFpJdklrNnM4TjM2NVJjT0paZlJ2RStzelZZazBZ?=
 =?utf-8?B?UTJxMDZub0tWcHIwcDc1ZXZhRzNtME1qWWE0OUpxK0NadGZOVTFnK1ZDSXdP?=
 =?utf-8?B?ZnIrWDNCNEU0U3k5MjdMU2IvUGpHczJPWndLeHR2cVIwaVNxcmRsY1pyak1Q?=
 =?utf-8?B?MFN2V0xFS0pYa0VyUXhEUS9NTkRibmhUS1UxRmN6bU1PWnFtNGpIOTB5ZzZE?=
 =?utf-8?B?eGJYYXRCYmsyZ21URHUwcFo5Z20vMDEzNzdYOHV4RjRmMStTZStMek5maEUx?=
 =?utf-8?B?c3lkNmwwKzMxbFAyeEdMWkpydm1TeEk3WmQzY01iTXM2M0xucHVkNHYzd1FB?=
 =?utf-8?B?cVIwbmRZai8rMURoWCtpWGpLY3dvMURwYnZ2MEUzMjltczBBb0dvcWt6YS9C?=
 =?utf-8?B?SkhBanNUWURWYjhXQzk5cUhwcUNRd3dPMjdEak4yRnNaUDRVK0tJYnpYbnk2?=
 =?utf-8?B?UlVEUG1EL09rVXNiMFg2ZWhFZ2hIY3YzZTRyOGV6dzVVcGlUWVZvQVVEVUFU?=
 =?utf-8?B?TjdKRTk4RStLUzBLVlYxeVQ3engvc1ZrQ0FvK2dQVXZTd3paaWVmb0hKMVlt?=
 =?utf-8?B?dVRQSStObEF6SVRCR1lQeWMzWTB1SXF6L2ZWeTRxa1lsY1lmZjJFSmIrM2xr?=
 =?utf-8?B?bThoUHgxUUVEbTBFeDNsYWxYRW41NUxQYzZwdS9xaS9oSkdrWkRaZlF5ZDNx?=
 =?utf-8?B?Q0Vacjg0UDljSHdiNk1VK1JvUlhlUi93Uk8xM3JnbXVUVUtVQmlyVjhJRE9j?=
 =?utf-8?B?RzNmVzU0UGhCaUU0a2wwZ3lVTE1RaEdKQUllSnM0NHNsUVFpckZlblZaTHZn?=
 =?utf-8?B?dDhudkpORHBpOFloQjRQSys4QTNoTGFtWnozL2RQMkxxdTBYWFpHbnhBcFlo?=
 =?utf-8?B?a2g4Y1ZhSUdSSVQ2SkZJUVQ1U3lEWDdOUHpFamc2RHd0MDFOYUx1Sm1IRTV3?=
 =?utf-8?B?d3U1U2lYVnpvTjAzbHI1TzhLdUtIMHFnRkJZVWNFZ2JwZ0VLOGtRakNZN1dr?=
 =?utf-8?B?dTdKWXhDN1ZVM000U0ZjeGJnaVhFcjlVWnhCRUdJMll4TVpleUdUTkptRDk3?=
 =?utf-8?B?MFpEaHJTaEJOUndxS0ZEUVR0Y3BIWnZMamxqdkRiU2t4WENWSzJrclFTUkxi?=
 =?utf-8?B?aUJGTndvMXVvZTZ4dUQzNlpjVk1GcVRvNUxGWDZCaGJSbkQ3RWxMbDlzNjJa?=
 =?utf-8?B?S2VuTjl2TUk2TklHMlRWakh2OHAyclpuVHhNSDJGcTdKcWJiMzBRZXkxd0VB?=
 =?utf-8?B?TTgxWU1odTd0TTJITGkvZlVYRjIzQUVjNTR5eXMwOURJN2JPZEI0UVlIbGNM?=
 =?utf-8?B?MVgyeUtweXpYcFhiOEQwQXFlZnl3Qy83cW9VTElzd3dOa05iWXhla1l5bFR0?=
 =?utf-8?B?WmR1Ykp5MU1icG5KcFJuNHNlbkE4RlNTZWdDYXBqWGROcEt0QlhFMnhuTWlh?=
 =?utf-8?B?MVUwdFkydGdDTDA0dVJiTXVwblc3MzB3dzREb2xGNVArQVBoUGtSVWw3Q3Qv?=
 =?utf-8?B?eFdWL01DT1l0M0FyMlNWMzBzRVFtTy9OVHlZeHF5QkJzVm1mZVUzbUVBdG1w?=
 =?utf-8?Q?ny++952euh92GJWvgoTL9hlOE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a81198-578d-4955-b818-08dd98522707
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 10:27:56.5447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkniwLfQDM8bs/Cp5TSp65sY7hfATCsuH1SJZtb155sfwg3EsWaIgrTBVi/M09y2vpsmSz13qd2nFBacqhHpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF4767F91D9
X-Proofpoint-ORIG-GUID: bsBeSBlkYIcBBEOiq3u6hFkA52Q7g-cG
X-Proofpoint-GUID: bsBeSBlkYIcBBEOiq3u6hFkA52Q7g-cG
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682daaaf cx=c_pps
 a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=Ikd4Dj_1AAAA:8
 a=eoxVqxtwYBPUszH2e7YA:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwMyBTYWx0ZWRfX7QSgf1x9+naW
 T9Da4HP+vdyTRZL2SByuK0/yU1xFrQm7PN0kBsb6ZaBFNlyctOi4u9qRmpsqJ8K1Y4gg3hL6ycS
 FWVDGJIthquPM7Txqez8W8j7bk+dZJSD5eVMtMxnnatBVBXDcyy9wB3cjw0fRVcN+safXviXWAs
 F0WVlxC+aeHCRKVebuE34WmWXQHEI/Lckd7/olKk19T8xqwcWuN16T2lKc3VgR+bh0g3eERfSVe
 7LqXdmC1b4hwS+oFDMo1Rvg2xmW9e4FWChLx4nAD/zln2MwbKSl4Bxbv0ablsrXRt/iLHnHfauW
 UPbXrE16dNrC3AYZuu0KS4Bwmd8Y3TXiAzAQmbKylfanzbYZ3Xzvk5h9G8cevAUPQKFYVj7DPj5
 vSI+/kiCH8hP+UL+J/H8UN+LORmb+edGgJO4+8fJGYyf9X5C+FUTQl1zw4eHvVMDxcZBHepY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
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

PiA+ID4NCj4gPiA+IEhpLA0KPiA+ID4gPiBBQUQgb2Zmc2V0IGluIEFFUy1HQ00gY3J5cHRvIHRl
c3Qgd2FzIGNhbGN1bGF0ZWQgYnkgYWRkaW5nIDE2LWJ5dGUNCj4gPiA+ID4gYWxpZ25tZW50IGFm
dGVyIHRoZSBJViwgd2hpY2ggaXMgb25seSBuZWVkZWQgaW4gQUVTLUNDTS4NCj4gPiA+DQo+ID4g
PiBBZ3JlZWQgdGhhdCBDQ00gaGFzIGEgcmVxdWlyZW1lbnQgZm9yIDE2QiBhbGlnbm1lbnQuDQo+
ID4gPiBCdXQgZm9yIEdDTSwgZG9lcyBpdCBicmVhayBhbnkgcHJvdG9jb2w/IENhbiB3ZSBub3Qg
YWxpZ24gdG8gYnl0ZQ0KPiA+ID4gYm91bmRhcnkgZm9yIHBlcmZvcm1hbmNlPw0KPiA+ID4gVGhp
cyBpcyBhIHBlcmZvcm1hbmNlIGFwcGxpY2F0aW9uIHdoaWNoIG1haW5seSBmb2N1cyBvbiBnZXR0
aW5nIHRoZQ0KPiA+ID4gYmVzdCB0aHJvdWdocHV0Lg0KPiA+ID4gRGlkIHlvdSBjaGVjayBpZiBp
dCBpcyBoYXZpbmcgc29tZSBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbj8NCj4gPiA+DQo+ID4gPiA+
DQo+ID4gPiA+IFRoZSBwYXRjaCBjb3JyZWN0IHRoZSBBQUQgb2Zmc2V0IGNhbGN1bGF0aW9uIGlu
IEFFUy1HQ00gYWxnb3JpdGhtIHRlc3RzLg0KPiA+ID4gPg0KPiA+ID4gPiBGaXhlczogMGIyNDI0
MjJkMzg1ICgiYXBwL2NyeXB0by1wZXJmOiBzZXQgQUFEIGFmdGVyIHRoZSBjcnlwdG8NCj4gPiA+
ID4gb3BlcmF0aW9uIikNCj4gPiA+ID4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFuaSBQZXJldHogPHNocGVyZXR6QG52aWRpYS5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiAgYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMgfCA0
ICsrKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FwcC90ZXN0LWNyeXB0by1wZXJm
L2NwZXJmX29wcy5jDQo+ID4gPiA+IGIvYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMN
Cj4gPiA+ID4gaW5kZXggNmQ1ZjUxMDIyMC4uZjliZTUxZTE3ZiAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMNCj4gPiA+ID4gKysrIGIvYXBwL3Rl
c3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMNCj4gPiA+ID4gQEAgLTY4OCw3ICs2ODgsOSBAQCBj
cGVyZl9zZXRfb3BzX2FlYWQoc3RydWN0IHJ0ZV9jcnlwdG9fb3AgKipvcHMsDQo+ID4gPiA+ICAg
ICAgIHVpbnQxNl90IGk7DQo+ID4gPiA+ICAgICAgIC8qIEFBRCBpcyBwbGFjZWQgYWZ0ZXIgdGhl
IElWICovDQo+ID4gPiA+ICAgICAgIHVpbnQxNl90IGFhZF9vZmZzZXQgPSBpdl9vZmZzZXQgKw0K
PiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgUlRFX0FMSUdOX0NFSUwodGVzdF92ZWN0b3It
PmFlYWRfaXYubGVuZ3RoLCAxNik7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAoKG9w
dGlvbnMtPmFlYWRfYWxnbyA9PQ0KPiA+ID4gPiArIFJURV9DUllQVE9fQUVBRF9BRVNfQ0NNKQ0K
PiA+ID4gPiA/DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBSVEVfQUxJR05fQ0VJTCh0
ZXN0X3ZlY3Rvci0+YWVhZF9pdi5sZW5ndGgsIDE2KSA6DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICB0ZXN0X3ZlY3Rvci0+YWVhZF9pdi5sZW5ndGgpOw0KPiA+ID4gPg0KPiA+ID4gPiAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgbmJfb3BzOyBpKyspIHsNCj4gPiA+ID4gICAgICAgICAgICAg
ICBzdHJ1Y3QgcnRlX2NyeXB0b19zeW1fb3AgKnN5bV9vcCA9IG9wc1tpXS0+c3ltOw0KPiA+ID4g
PiAtLQ0KPiA+ID4gPiAyLjI1LjENCj4gPg0KPiA+IEkgY2hlY2tlZCB0aGUgdGhyb3VnaHB1dCB0
ZXN0LCBhbmQgSSBoYXZlbid0IG5vdGljZWQgYW55IGRlZ3JhZGF0aW9uDQo+ID4gY29tcGFyZWQg
dG8gdXBzdHJlYW0uIEkgY2FuIHNoYXJlIHRoZSByZXN1bHRzIGlmIG5lZWRlZC4NCj4gPiBOb3Rl
IHRoYXQgcmVnYXJkbGVzcyBvZiB0aGUgcGVyZm9ybWFuY2UgaXQgZml4ZXMgc2V2ZXJhbCBzZWdt
ZW50YXRpb24gZmF1bHRzIGluDQo+ID4gdGhlIHRlc3QuDQo+ID4gKFRoZSBwcm9ibGVtIGlzIHRo
YXQgd2UgYWxsb2NhdGUgdGhlIGNyeXB0b19vcF9wcml2YXRlX3NpemUgd2l0aG91dA0KPiA+IGFs
aWdubWVudCwgYnV0IHdlIHRyeSB0byBhY2Nlc3MgYXMgaWYgaXQgd2FzIDE2IGJ5dGUgYWxpZ25t
ZW50KQ0KPiANCj4gSGV5LCBJcyB0aGVyZSBhbnl0aGluZyBlbHNlIEkgY2FuIGRvIHRvIHByb21v
dGUgdGhpcyBmaXg/DQpBcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NCg0K
