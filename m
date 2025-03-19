Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AF7C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 11:02:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 332B2402C4;
	Wed, 19 Mar 2025 12:02:19 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 88BA84026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 12:02:17 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JAYI59008830;
 Wed, 19 Mar 2025 04:02:12 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45fv9d01rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Mar 2025 04:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/+au4bj69DYhTvoNWeMvDUGlRwnJAu0B4fzrTFHrdHeyZzJil7dHYarVraQCAhRid3VFeIPDRwFSdzO1Yb45CZsL11M6VDfWoCCv0SaXOTmapt5bLrZRhjGAoQmGfylVoaqrzrZgK2zgCkV7Cyj7a0/LT6RUcvqlrf3kXdcki0fRIlgc2CeSQx1kNV/xhhOQBj3CRvqWJqetVradO6xqPlfpbuVHtlwoZ2mKrlNaVrY+sRB3QY44AcqFNg/St4orczXhFd1eMIWSgawN8F+3uoH/+puxdf71g7OPPUOpVT3h0HeJE1SCcfkwdtDDUGhcg/raUQJOzmHCl1+zOR8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBU5IV+q8TueoW6+s2LBE7qsFc3kShc6r562Ucxzgz0=;
 b=FKkMsovylQ4cpyDEJjlVtCfMTtAiVJmxuvFp1RYZLAJm2eWLftp4VbMpuRpPcytSYyZlNmL79TvLDT32+27zJf9l91EZgFk4Ksd6ApQV3KoAp7rwH0UMo9pkIZjVqyxp41UYLlVSKOfJ4d0f4ZySlwZHos7aNRLqDdMVQsh0MP3m/psVPHj8kzrnzmh6XfwP5XMcYoOx65FPAxt/EcYZx24VgAauk9PH4axAH8fyYFT5MJUlIp6O3y840UPT8hflWL/dayO7vpsSH/4KqUX4FVtWNUNfFE7q4ClBjxuK08nGTA5Wu3I4rGAJVYyjbkhQUiokErYsxUMaIED29sftHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBU5IV+q8TueoW6+s2LBE7qsFc3kShc6r562Ucxzgz0=;
 b=Wy8MUlWWjRm00oMXhCXBqpbNtioLzHfVKYb7wODb/HwUTl2m1CQ0hUVCKSjBNqNiSlkW9beUb2tKoDXNEnTGE/u8w7c5j2q6ioNrlgGHl2lbu9XxqnKUj4hUw1zJ0SXJVPPQjn/LOQGVMCcHHx5QSa+NNev0jbWg81AjZYZbnC8=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 CO6PR18MB4436.namprd18.prod.outlook.com (2603:10b6:303:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 11:02:07 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 11:02:06 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "mkashani@nvidia.com" <mkashani@nvidia.com>, "rasland@nvidia.com"
 <rasland@nvidia.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] config/arm: fix meson for native instruction
 set Arm CPUs
Thread-Topic: [EXTERNAL] [PATCH] config/arm: fix meson for native instruction
 set Arm CPUs
Thread-Index: AQHbmLlFmasjgL5a60i2rIlQTycwS7N6SiXw
Date: Wed, 19 Mar 2025 11:02:06 +0000
Message-ID: <PH0PR18MB4086559122474B889285A20FDED92@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250319102505.596678-1-getelson@nvidia.com>
In-Reply-To: <20250319102505.596678-1-getelson@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|CO6PR18MB4436:EE_
x-ms-office365-filtering-correlation-id: 94f886cb-67c5-43da-156e-08dd66d57ce0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eSs2QUYxSjI1aHRBMTJ5d0l2bUlKb1lVZUdybVRtQi94akgzNWtrcEdteU1s?=
 =?utf-8?B?U1hmRHIvTkw1aHloK3dCUi9qMSsvSmZsNkJnYzRDQXAvUkFaSzZ5TXVRa0pj?=
 =?utf-8?B?SUhSS3Z2eHdxMjhHZXU3UVExZE1JcnptdmVUZXlDVmNFMFFwaXdBM0Y5U0Jx?=
 =?utf-8?B?dU9xRVJ3NkdmY095U0d0VXMrWVQvRHI4NFpERzB3VENQTGtUWUZlYkpBaXlT?=
 =?utf-8?B?L09xcTRobEVneEN5WnJjeVR6dWc3U05WTE9PM2RER0ZMQkFqTmZqa1NkRUZJ?=
 =?utf-8?B?cDhOSlZOODg0bDRXMTVCU01CUUtZYlEvNjkwWnpHNWRKMkNFTVdHaFdjaG0y?=
 =?utf-8?B?Y29WKy9pd204NVlXUGZ5L2FFZUx2Mkt0UXVQa1Y2dVE1L3pjTU95aklOcmNZ?=
 =?utf-8?B?bXd6SVFyaU9yM3hKWVQ3eU9CeHlNTGlDcVh1MWxCc05hZmtJeU5haS9VY2I2?=
 =?utf-8?B?V1VaQzhKZXE3eURhU212S1VtMFpiTDFzdGtGeXpaOEgwTGIxeUxuYlhGUEtV?=
 =?utf-8?B?Y0dSQmRpdUZza0kvTHhiU0sxWTFiZFdTZXdsMWREVC9JbGkveGNtUUxkV2xk?=
 =?utf-8?B?M0J0ZnNpU2QrSDVBUSt6Zzc1QUwrWkdHeUp4cDEvbkQyeFVzL3Q2ZUcrRy9o?=
 =?utf-8?B?T1NDN1lxRHRiZklhOUVBZHhmN1QwemRlNFFlNExRMkdmdWtFR0JkZWMrOWVN?=
 =?utf-8?B?M21zbUFwTW1RY1JMSWwzbWNVc24rb3NzRHpkTFFBRnpGZTd0cnFqajY3amtE?=
 =?utf-8?B?dDE2Z3hBR2RFT0dRNEEwQnJUMmlHVElTdlp4cHBmL1ZWaXIyNjhlVVUxR0Rm?=
 =?utf-8?B?NzJ6OU9LbnpxenNXN2pmYmFaWVM0WXlHaWpCNDhOYW13Qm5kVVRlS3RMVk9o?=
 =?utf-8?B?OS9FcjVBTzZzTFBtNUZOK1dqOVREVmQzc0pMN1BZVnZqT1FIUGNFQWwrYkE1?=
 =?utf-8?B?SGhEUHFySCtJcUZIaXpuM3VEcStybWtrNHEyRWdDYzhYcUJtbVFLKzhLNkg2?=
 =?utf-8?B?aTNkZ2hHLytRVTBPRm85aFJYSEhxQ2lXYUh4YyswQk5ZNmZOejBlUW10SjVt?=
 =?utf-8?B?bEJSaWxHaTk0cnhHNEM5WGxkbCtOS1hiditQZ0ZMN3ZZbVpVSG04aG9TN3Zh?=
 =?utf-8?B?TlgzUmttR0NhVm9UNzBqQjM0VStteG0wc3hKTkpEUk1heHJVTGVNZmY5OXVa?=
 =?utf-8?B?ME52R2VRZzdmU1VzbHg3aFRTc2k5TUdkamt0dEhMVFRrQTU2T3FiQzMvSTlW?=
 =?utf-8?B?UCtYclc3MGFOWU43TUxQMEc5OGhPMEFkRkdLcGlGYXR2VHZ4eEpmSTZIVWZR?=
 =?utf-8?B?RUhyZUI5OWlZajFzK0hBV1g3L2Z6Ui9vcStLd2NmMWtjNGt1Y3hTaExmTXh0?=
 =?utf-8?B?ZEZuZUlpVEdwUEVRSW1lU3NNN0dzT1V5WEVtY3djMElSVFVBcStWVjlWNGhW?=
 =?utf-8?B?ZmRZVWVkUHZnK3hFTEN0dzJPNVNqR0lJbjJJc0x6WjVtWmlWRTVyUDJmdnIz?=
 =?utf-8?B?K2x0dWcyVnZJenBPVHhwTGlDOGtVZW5GK2hmdjJKRUJXWDdPSVdzWUg4Mks5?=
 =?utf-8?B?STNaeVU1ZUNOOG1HbzJXb09lUldycE81SnpDTzc3VUY5UE9CSXlXZldoRTFD?=
 =?utf-8?B?akhvMlFHa0pib0ZRQ1k5T3ZRZVRTSVJtNFR1OXd2SmhweFh3dlNuMkYydUZ2?=
 =?utf-8?B?S2lyQnFmZ3h2dWxnYjRPaFNLd1RhbXhleHVrKytZeFBxYzJydlVnemF6WVdX?=
 =?utf-8?B?M3l3OXk0RjY0b2kxMTdESmZYOURFa2tUQ3BrSWJzK1Y2ZWl5c3VtaGhHamQ1?=
 =?utf-8?B?SXdoQjJuWlNQTWNCUGNMSEpQc0hrRUVNS3R2RStVOXQySmdJYnZ5TGdGbDEv?=
 =?utf-8?B?QlJQUmplRGdTaWh6NTBFNUZQT1JveGQzRkxkZlM4bEpXYXVwN29jN2NnMnhy?=
 =?utf-8?Q?QKmoPOSXggY0GcDflusvn3MFTTx72hoH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d254dFh5ZmFWYktqSFdGS2haRWx0NmpwSVhMU3N1UG5TcC80bGlSZXpjN0lB?=
 =?utf-8?B?bkhKQXlOaS9mazZLalE2alJOSGtNcFZzMnlTTXA5UmgxdEpIRk02MlBOcTRn?=
 =?utf-8?B?TWVxWGlibXliSE9iZytlbGRaRnFtZWMwVG5qZWFYTlV4THdJUDd5c0JRYng3?=
 =?utf-8?B?bEd3a0xwMEFwVmtneHZLMS9JOFptZXA4TXVQVitpak90a1l5VWt3bjl6STM0?=
 =?utf-8?B?MmFGVXRsTGdsa1ZuNHdkVXFpUEZWejlSODE0eE9tZEZkMXJzME5BK0dOWGZN?=
 =?utf-8?B?L3ZtOHh2WWxKNWpYVlgzZWU2L0RYTlhCcGg3MHZXSWRhcldISjhwUkJScUJv?=
 =?utf-8?B?WkJhRVpwNzRzeHppY3VVeGlHSGEvZkpXdkFoUUtRdEx6Z0QwRllYdVhHRG1I?=
 =?utf-8?B?dmJXNGpDakthWTAxVzJ4Q3JOWFVhOW5Vci96ZXlsMDZPU211MHBIck90M1BO?=
 =?utf-8?B?QjMrQUZ5TysvanVOVHJsSEtMam9ESzJkckYvaUorWkRNTkl6OU1hTzVpdmpX?=
 =?utf-8?B?RktJUkVXZS9tNWpKanZ2N1NtU1NQQTR2THhPWlNHUWcyMzNJaERNdkVKNUg0?=
 =?utf-8?B?WVQ5ME1GZU9NRnk1VU5aQ0QzblFVR21TdlovSHAyVnIwU2pTS3B5RTNtd2c2?=
 =?utf-8?B?QitCNk91QnFha05nNytzM3FOQnJrVUJ4eEU2QnhyektMN2hVbHQ1dDcwb1ZQ?=
 =?utf-8?B?QTdZeXFpUVg1VUNha0k2b3IwTzJHYXhIczN3cVNsUWE3RXBJeUNIaUhleUhR?=
 =?utf-8?B?ZWpNUEVvMmZtWHU0TnhTUzFPV2UwZlNkYnRMbEF6dWIxOXZLa2ZFTE9uQmtO?=
 =?utf-8?B?dGJvSEVKVE1Hc2EyZTZtOEV1aVltSHpUK1hFTi9vSjZncWM5c1dWR1dnVjBN?=
 =?utf-8?B?VGdGQ21XemVrS21xQU1icWVXM1h3cGJqQUZYaDM2cndpWldWdWRiVHdiWmRs?=
 =?utf-8?B?akgrRitmSGc4MWRpMFBKUk92Vm5SV1pGNXd1TzZPTFU2dGxRaUY5eTdJR1pI?=
 =?utf-8?B?cnUxZ09RUUV3T3l2UUMrSnFIWXRROUdrOCtBV3ZMT3AzT3dwSGNqc0puV2pY?=
 =?utf-8?B?bDdMNWxGdTBHQkdPUVR1QU11cGhiajE0WThpRVVGekZVLytiZnhJODJpbTJz?=
 =?utf-8?B?SjByRm1KTmlBV2NjMnlJeS85WTZHMFcrcEo2M1lHckVYS3N3bEFXWTRwdi96?=
 =?utf-8?B?cEVsOHI4RUhjaWRBQmhCZWl5Z3QwSlByUU1Da05zMDBrejJST04wMmlFUWxO?=
 =?utf-8?B?WEdrREdWYjJVY2JSRVlaL1VUaWxlSi9sblh6SnZ0RXh1WnZ0WWVKUUZOenZ2?=
 =?utf-8?B?QWw3RDYyaE5MNnF3a0ZFbVlzdnJtRVYvMVRYK29Va2Vyb2c4QUZBZ2Q0eTZI?=
 =?utf-8?B?QjIxdUZBaDlWTy9hSUc4R0twUzU5TWR4OXdyL3NCN3RZYlNVMDNzQ3E2VXlE?=
 =?utf-8?B?K3lscUwveWtLdDF1eWxJdEk1b2phWWtCYjFnZ1hmdVFWaEh3R21HeHlHaWVC?=
 =?utf-8?B?Z25WS1RpSXYvNlR4UVI0VUJDNnBnQWRVUWZNd0tZRnlER3JwSmNQQktON3BQ?=
 =?utf-8?B?VUtGNUx0MmxjTDgxazdPdHpWT2E4SHUwM0xLRmdvWGZjUzNzVWh4dWZNTmE2?=
 =?utf-8?B?MnFKM09PQ24wSkVYRXdsQUVvTTZMZ1h3RTFwNnErSjVsVzUvSE5VTHlXNytY?=
 =?utf-8?B?dHFyTFlaQWE1bkJadUpZMlI0UGNzd1dkK1drZWJtWjYycllmdjlNYTJZTWlM?=
 =?utf-8?B?SGJRYlRjQjArVXd5cFhKOVZqMndmamJlcFU3ckRPQ0lnSFM5Vkx3VStsNFZo?=
 =?utf-8?B?dHMrWm8xbFZUZVJ1SFpGZWZsQXM2dWNVelFZaTQ5S2lUT1pYMTFMK3h0UHh2?=
 =?utf-8?B?bXFYREYzRUM5TjkrQ0dXNHB2SzBFMGU4Z1JiM29uSXN5d3NMeHdyZUJhaXRE?=
 =?utf-8?B?TzdRNFJxV0RRam1qVVI4QUNTdVFMY042NUNZRmNnc0ZRUmtYNUFtNERZYXJn?=
 =?utf-8?B?ZG1WYUJyQTNsOXZoeWp3NERKZzl4MTNsQys4MWcrbmh3cUN5MmZnZ2tiZXly?=
 =?utf-8?B?c1JGMVN6NWRLeHNHSkxFT3E1MjNUUkVvZjhiUUR2WDhDc3prYzZmc3pPbkJh?=
 =?utf-8?Q?Sg9qNeB+aCbZq2sVzwwnZzqrJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f886cb-67c5-43da-156e-08dd66d57ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 11:02:06.4999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvuTFwPL5QTaiGrRhOTpHWukNTh+/kfpNvTXARxhx+2nHrscmRv4umS1fG+sRmTiRQ996dy3CqWMA91Zr+PyshfQOt4cgLGtij7u8BnAq1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4436
X-Proofpoint-GUID: 8zs_l_JDVuDec9OcoROM1MpkPR6DZi_3
X-Proofpoint-ORIG-GUID: 8zs_l_JDVuDec9OcoROM1MpkPR6DZi_3
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=67daa434 cx=c_pps
 a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=Ikd4Dj_1AAAA:8
 a=5ILORlwOZ4WNKcOyAtQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
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

SGkgR3JlZ29yeSwgDQoNCj4gQXJtIG1lc29uLmJ1aWxkIHVuY29uZGl0aW9uYWxseSByZWxheXMg
b24gdGhlIGBleHRyYV9mZWF0dXJlc2ANCj4gbWVtYmVyIG9mIFNvQyBjb25maWd1cmF0aW9uLg0K
PiANCj4gU29DIGRpY3Rpb25hcnkgaXMgcG9wdWxhdGVkIGZvciBBcm0gQ1BVcyB3aXRoIGdlbmVy
aWMgaW5zdHJ1Y3Rpb24gc2V0DQo+IG9ubHkuDQo+IEZvciBBcm0gQ1BVcyB3aXRoIG5hdGl2ZSBD
UFUgaW5zdHJ1Y3Rpb24gc2V0IHRoZSBTb0MgZGljdGlvbmFyeSBpcw0KPiBlbXB0eS4NCj4gDQo+
IG1lc29uIHNldHVwIGZhaWxlZCBmb3IgdGhlIEJsdWVGaWVsZC0zIGJlY2F1c2UgaXQgYmVsb25n
cyB0bw0KPiB0aGUgbmF0aXZlIEFybSBDUFUgaW5zdHJ1Y3Rpb24gc2V0Lg0KPiANCj4gVGhlIHBh
dGNoIGFkZHMgZ2xvYmFsIGRlZmluaXRpb24gZm9yIGV4dHJhX2ZlYXR1cmVzLg0KPiANCj4gRml4
ZXM6IDc4Mjk3NzZkMGFiZiAoImNvbmZpZy9hcm06IGFkZCBleHRyYSAtbWFyY2ggZmVhdHVyZXMi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBHcmVnb3J5IEV0ZWxzb24gPGdldGVsc29uQG52aWRpYS5jb20+
DQo+IC0tLQ0KPiAgY29uZmlnL2FybS9tZXNvbi5idWlsZCB8IDEgKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlnL2FybS9tZXNvbi5i
dWlsZCBiL2NvbmZpZy9hcm0vbWVzb24uYnVpbGQNCj4gaW5kZXggYTk3YTI4ZWJiNy4uZjk3MWVk
M2MxYiAxMDA2NDQNCj4gLS0tIGEvY29uZmlnL2FybS9tZXNvbi5idWlsZA0KPiArKysgYi9jb25m
aWcvYXJtL21lc29uLmJ1aWxkDQo+IEBAIC03NjcsNiArNzY3LDcgQEAgZHBka19jb25mLnNldCgn
UlRFX0ZPUkNFX0lOVFJJTlNJQ1MnLCAxKQ0KPiANCj4gIHVwZGF0ZV9mbGFncyA9IGZhbHNlDQo+
ICBzb2NfZmxhZ3MgPSBbXQ0KPiArZXh0cmFfZmVhdHVyZXMgPSBbXQ0KDQpXZSBkbyBzZXQgdGhl
IGRlZmF1bHQgdG8gYmUgW10gd2hlbiBleHRyYV9tYXJjaF9mZWF0dXJlcyBpcyBub3QgZm91bmQN
CkluIHNvY19jb25maWcuDQoNCmV4dHJhX2ZlYXR1cmVzID0gc29jX2NvbmZpZy5nZXQoJ2V4dHJh
X21hcmNoX2ZlYXR1cmVzJywgW10pDQoNCkkgaGF2ZSB0ZXN0ZWQgY3Jvc3MgYnVpbGRbMV0gb2Yg
Ymx1ZWZpZWxkMyB3aXRoICBib3RoIG1lc29uIDEuNy4wIGFuZCAwLjYxLjINCmFuZCBkaWRu4oCZ
dCBzZWUgYW55IGZhaWx1cmUgd2hpY2ggdmVyc2lvbiBvZiBtZXNvbiBhcmUgeW91IHVzaW5nPw0K
DQpbMV1tZXNvbiBidWlsZCAtLWNyb3NzLWZpbGUgY29uZmlnL2FybS9hcm02NF9ibHVlZmllbGQz
X2xpbnV4X2djYw0KDQpUaGFua3MsDQpQYXZhbi4NCg0KDQo+ICBpZiBkcGRrX2NvbmYuZ2V0KCdS
VEVfQVJDSF8zMicpDQo+ICAgICAgIyAzMi1iaXQgYnVpbGQNCj4gICAgICBkcGRrX2NvbmYuc2V0
KCdSVEVfQ0FDSEVfTElORV9TSVpFJywgNjQpDQo+IC0tDQo+IDIuNDUuMg0KDQo=
