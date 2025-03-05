Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7643EC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 05:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CC8940156;
	Wed,  5 Mar 2025 06:19:40 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9F3A9400EF
 for <dev@dpdk.org>; Wed,  5 Mar 2025 06:19:38 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253SOlb026980;
 Tue, 4 Mar 2025 21:19:37 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 456er1r55q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 21:19:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjO0fq+w9iZXRFvCwZDFJC5p9NpVeyHm5iSv/1J8hQl2JhJgiNnEQLz4PzC9lZLHHfhicYsyVzlgENQNDGjEe0cSX3r54Pi5vSBlFj56mJYB1YkOeNqeHjo30B+1Ivmoht8QKsamt+fVDNGWM9SU6DRV6qOkaDo8DJH4r8riY7vQiPPiENX4/uDna0nYWQfUwlXKQnbphF5wFzEVuIDu0WQvX7y/vDVZkqJFWWK1YO0bbkpfOf/gf87QxoHVVTS5usNTSkFyJt7EQBjV3mT0ma2RZGjRbIQAbGJgQsQpktNgqYNHID8NmWi1j6WQnE6yDXN5VcnMJS0Kq4dwpyc6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLkR95imoP3fPi/pFkxY4pB9u2ZRhUhe19jGYXR8+Q8=;
 b=kuI439st8rrYKuWY/fAwHEJvKQNNiTpsbCM6pu1iQZfQcrTXex/9pEJdAL+Fy1+/zUPQpstlJC+GsBMtZTxxn0o6n33gPfcH1BHYKsR8uhSwj+P1LRIfjsxK61mA9Q8ktoIPSj3mtBcOvv1z1CVi/LPWt5CQ8M/c43s5poDGQid1uAxFswp5N0/O+9s/KAteAhCWY0nNYjFCIBd5kgu1mgY3pe9Goq4iy+veVPfA5cmkFDMhR+pMzhpnR+ukeA9e572rRJJdZLN+4gjubBSFGY5vRwPCIHv8zsr/FIYolWFwjwDyuRy9dC9cgEIlo24N1DbGP46Occtx3Ag/O2LtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLkR95imoP3fPi/pFkxY4pB9u2ZRhUhe19jGYXR8+Q8=;
 b=MLs6NkSCYL2WBxsIvgjF4R5LVa+6yXfS2s8U3zZwdB016PVgtc8ir1VPTRhdGsGKEXD6sZ8P9EKqK6vSQEL3yMBXsodNA6q5xWwlDLKqK2kn6EVMWZPQSG/+h+vWHbFzbPyPCosApzOwyUY1FYlpiO96B6gaWmUo6rxNeHToqLA=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by SA1PR18MB5790.namprd18.prod.outlook.com (2603:10b6:806:3b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 05:19:34 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%7]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 05:19:34 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v4 3/5] trace: support dereferencing pointers
Thread-Topic: [EXTERNAL] [PATCH v4 3/5] trace: support dereferencing pointers
Thread-Index: AQHbjR951oU2v3+skUKtAXTvaJLBS7NkAd3g
Date: Wed, 5 Mar 2025 05:19:33 +0000
Message-ID: <CO6PR18MB3860CE6764ABA05A6D7452FBB4CB2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250304160633.385185-1-david.marchand@redhat.com>
 <20250304160633.385185-4-david.marchand@redhat.com>
In-Reply-To: <20250304160633.385185-4-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|SA1PR18MB5790:EE_
x-ms-office365-filtering-correlation-id: bba2cce7-3e6a-4d82-0c9b-08dd5ba550d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SVpYbi9wZUpDZnpsb3BHYms0cGhSeXhUR3lqK0Y1SVhMcHpQZklCcUtrTEFu?=
 =?utf-8?B?SlgyRjZsdWpnakFvZVl4WExlSG5DRjUrVTdJUUN6OHlGUXZWaGt4akFzYytq?=
 =?utf-8?B?RXVtTnVJaUVnQlMzV2ZDTlRJM3VMUUlUeGFTMVY1RTBkNGt0MGQ3Tm1IWGFy?=
 =?utf-8?B?SGlIZTJZU1F2TTgzY0t3WHIvVXZVTVFmYmZlcG05bHFxZCtKZmhrcmxFdzlk?=
 =?utf-8?B?ZGVaRWt6L3lQTkFVR1hDblF6S3Ayd1dFZXFsaWdiK3ZRc0xxZzBFaFI2ek12?=
 =?utf-8?B?L0Zsa0taOHQ3OHlnNVMvRHlrNUFnTENEbmZmMlVPOVRwMzIwYUNnWWF6OG55?=
 =?utf-8?B?RkJUSTc2eW5zcXFvNkYxbjEwRDhXVU1Qb284aFZqd3lmdHpHQXFlUEd1RWRs?=
 =?utf-8?B?Vk5rcXdPYUV2cWRXYzdFS1E0QTh5Mk8wTTRNejM5anhSVW1FN0xDOVVPV2NV?=
 =?utf-8?B?cHg2bTNZVnltL1JMOGpyRUhlejg5TzBmaXlCenJiYnpTQzA5TkpwbGZQLzJL?=
 =?utf-8?B?eFFPYjVwZ1NKMXQwU0w3WTVtVFgrSTFMMzg1bmFyaG90NDMrV1Nmb0FEVGxz?=
 =?utf-8?B?VE5sNHNseDhXK0JSc2J4eS9pcGhHa0crQWNqRlEwZ0hMYU9LcWcrSzRORVR4?=
 =?utf-8?B?SU1XdElLakViRTBpTUx6MFlEWDJQdnN4cEtTTlI2L0FDd0t4eXFXSlhLUmxw?=
 =?utf-8?B?akFzOVk4L2FKRzJyVE9jdDF4VXppNnMzN3RDQXEyNHp6LzN0WHAxcm1SYjZm?=
 =?utf-8?B?ZHZSOGEycVR3eG5pdXluc2p2azkwd05qY1M4NFBJQWV4d1I3d214Sy8zR0lD?=
 =?utf-8?B?Y3ZuUklFTktNK1VLUXlEajJQN3NFcUExY1YyeFRFeTdtTmk4cjNaMmRNODhR?=
 =?utf-8?B?amthWTVucWV3eDUwUVdObUVJVmhBZjRzZllwSmNrMjlQaFk0Uk5TRjBuTDFO?=
 =?utf-8?B?UjJYVG84NVZzdkJSdTlMbHo2d3ZvdHYxTTZlcmNzMTVHRXFKcHJ6QTNSeFU3?=
 =?utf-8?B?YU5VbTA3bFRhUWp1ZG5xZkdQeXV6QjJPdDRLcWM3b281R0orTUQ0V1k3Q0RB?=
 =?utf-8?B?Q3ZTak5EUEVEUVJERUxEN2tDN1Qya3dhUlB0QnJDYklQQXUvc1djbnNBQnl4?=
 =?utf-8?B?ZmhqUmZ5YVlNc0l3ajBPQ3hDYXI3dy8xbDZQaWRITHNsNk5idVhVeEpVYUhN?=
 =?utf-8?B?QWcvYWI4QVRPc0tIeUJLNTIzNUhYSXlka0hTRFhQWkRSejdEci91MHFRWllK?=
 =?utf-8?B?SEFoRFIzbkwwazlXanRvMEdKTWJLSURiK1A3a3VtelA3OElaaUg4RnZrQWNj?=
 =?utf-8?B?ZEE3UHFVTGFNaUNtbCt5YU1TM01xUXVsUFB1NTBxZzB3NUVYelhZTGlwbmQy?=
 =?utf-8?B?SktTcGVtOEpmY3Y5MDNSelpvMDJiQWJ0MURRMlEvd0tNaTJqUklQdzFNd0hj?=
 =?utf-8?B?d05VRGJOYlVPbnRGWSsrc3pvNlp4SHJ5aFI5bGd3OHM3SWxWeTRucUFlL1B4?=
 =?utf-8?B?TEJ0OG9qNGVXc09SOWU2QVcza3A0ZjRxaWQ0NG9CTkdrOFlnMkhpSEQ0T3FB?=
 =?utf-8?B?N2t4My85VGR2TGFGRUdncmp0Rm1UMmtueFRKdVVraldIWTdGc0F2dWlOb21X?=
 =?utf-8?B?bCtKOVhqUVpLdWxFNnRwM0liN2JYVThBUmxPSzFuTTc1WStYeklndXNMazJY?=
 =?utf-8?B?U0NhWVBvanBHMkxSVXFCTmZhSUYvRm5zK2ZIQ2RGSnF1NlMxRW42NU1nWEIw?=
 =?utf-8?B?aVI0RHFlVi9NNmtXaHgvR1ZCRGF0elhobnhNWEdJVUdPVUFCcjlSNlR5dk5V?=
 =?utf-8?B?VzhtdkUyWXNiSE56cWFrOCtWeno2M2JWTHoyR2ZvOXdGUXpUOXdHOXpucG9C?=
 =?utf-8?B?N3hjWjFEMkpMU250OHlycG1XZ3lFMzJYcTBUZVNoWEZuYnlxUFpTYUFtRlZw?=
 =?utf-8?Q?5OxBWFj3t4lINo8rLHKK72Pu+xzt6CMu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWRzTFp5c3ZYVkRmaVBRLzlqT1c2a240MXhQYUdmZ0lrR3dIRU5BVTdjeTJn?=
 =?utf-8?B?ZmxZSlZ4N1c2R1dYTkpaSGNQTEJSelFQR01kcEQ2MFl5S0lYbTg4M3I0NEhI?=
 =?utf-8?B?czN5cEJJNXZoREV3Q2dJUWp6cDdDVU10SGVqSmFzWXg5V242TEJCV3RKK2Rp?=
 =?utf-8?B?dEp4b2tVVEJYeHQ1NnpsQTcxSVJITmF1dzlON29yWHdDbGVwVjg4TzJ0ME9z?=
 =?utf-8?B?MTBzVjRIQ2MzblB2MDUwbzc3NHdNSzN1UjJ0ZUhWVGVFR0NUbHF1OGVvSHVV?=
 =?utf-8?B?emR1ZEJTZ3FSNHdwbjk1M2FSSFlhaFRlNXpEaEU3QzlxYzBjeGVOR1F1UW0w?=
 =?utf-8?B?ZmdheWp4bVdrNDNhVXlWRXNub0gxZFNscHdPeW9CeU5LU1JXU3F1cnhoWEx2?=
 =?utf-8?B?aUdLRWF6bHBTSWJBVUNmOGw1K3VUd0ViUFE3MzJwSHh5akhRcytSUHE1bU9V?=
 =?utf-8?B?N1JjZURkNnJzWER0MHpHOFFjTFNWZ1Fnc0RzcVZKTElwcVEyOFlUb3k3dEVa?=
 =?utf-8?B?dmpyT2YvTGJ1NFNGSCtpY21ISXlkVGxLSlhRcGVoQnlBdXNtQmw0a053MUZ1?=
 =?utf-8?B?am1KOVZWWms3ejFIYW9XQW4xeGY3VVRHbDJVSkpPWG9LZW9wSC9PeFdTbGJE?=
 =?utf-8?B?N05uV2t3QXF2Q3FVaVdkUW5JU2ZjcnFIVHNWUGNiSitaSVkrN0hwQjhMQU9H?=
 =?utf-8?B?TVFMdUtCL3JFOXA3cGlJZ2JqY0p4SDQvekZNZEtxc2xFTmNSVVR0OHlzUzJj?=
 =?utf-8?B?SmJrMXdib0hZbzhqQ0FmaWIzcXdwZWFVeE9vL2lZa1RBd0N0OXYrcElpU25J?=
 =?utf-8?B?RFE5NElUbTNlWWhqL0hlNmh1dVhOS1BCU2huV1c3RkNuUzhnQzdvTFIvZmJF?=
 =?utf-8?B?T3ZMWlpzWDFvRWN4cWZFQ1NRREVuTGlRakRlUGRzUm5DckgyNjBpZkhaTmVQ?=
 =?utf-8?B?eHFSNVoyM1QzWnVYeVhEMC9rMmhoSzh4d3hSeHBRdkNLTHhiWFpIbEFHTTZK?=
 =?utf-8?B?azllWEUwTUZxeTlqQXpGOHFFUXRiczRYdC9KZWEzdDhlZHpWQi9qYkdqNE5k?=
 =?utf-8?B?K2wxTlNmWkFjWTZaMGlnVmxaQkRRK2pBSmJ6aktBY3BCaktqa09Gc0h2a1pm?=
 =?utf-8?B?SmtXaFpmcVpHci9teWZmK2M4UHV3Um8yT21CQmdKcjA3TFk1WW9aUEx0M0dh?=
 =?utf-8?B?RTNDMm8vaWgzcitKNU5GZVQzNzNtU0J0L21SYkVnUWFKenBBaGo5eW8zamdI?=
 =?utf-8?B?Y21Kb3B0U0FRNStVdjdyR0xMWTlWNW5YUlR4aWFyUVVxZkRZL0hZcnVWSXh3?=
 =?utf-8?B?Ly9XV0NFdWRHS0dvSDl2NW0yNVY4UnRSeG5xVGQ5ZFF2OTBrZm1nWTQvNnNW?=
 =?utf-8?B?OWkzcmVsL1hwK1QwRWdvdnR1V0U5bWtzS2JSakN1dHcwdTA1U1FhQ0gvNzhw?=
 =?utf-8?B?UGZ4VnVzc2s5Q2ZTQ2tyVGY3RlRJS1N2R01rbkZaakFOVGJkdTQ0ZlZqVlF2?=
 =?utf-8?B?ZFlLUUk3YzJDNnduUXdsVDVESS9OT2VYYWdPOVh0RFFtNk1WUkJvdFRIc203?=
 =?utf-8?B?RGlETGlIczlvQVJaR2VBbkUzSXJiTGl5Z0NmZmdxM2VMeUgvVlkxNlA5dHFy?=
 =?utf-8?B?VnhYY2JhUDl5cWxVZElHNWtBTlE3TVdseXhMR0lvU2FoR2M0Y2xsYTJhc0Vk?=
 =?utf-8?B?VmlaaTB1ZzBXUEhic3RsWklQdFQ2dVpBSCtlLzNIenhqY1Z2d0tKUXZmMTVC?=
 =?utf-8?B?UU1zU1RFMmlHd0FKbVZucFVPaTVQSVJkZ2o2V0tCczErOUlIMUN2LzBHcTRW?=
 =?utf-8?B?M1htM1c5SlhzS2sxRDVRcWdpTmYvN2s3VFg1cGJ6dHl3a2JWN1FkaEVBdmpz?=
 =?utf-8?B?YXlEdklucUZBOXpFdDBTS253VHpxYW5Ob1RVVytubjRLZldVMDErRjRvbW1p?=
 =?utf-8?B?NDlBM0kvdUZVd013L1M3L0pnbjBFczhZTVR2T1NYQUtZUUNzSi9jeHhSeXR3?=
 =?utf-8?B?MHVmQVo3ZXdyVE9rdHY1WVdZYi8vR0R3THY2UDNFUlRoMStoMm9KcXliOXQ0?=
 =?utf-8?B?cStEVHIzcVRHanZ4RTN3ejlJUlc3OUVsVWNOQmtmSUxaRlh5UG1ZdEZYMmZO?=
 =?utf-8?Q?ll0A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba2cce7-3e6a-4d82-0c9b-08dd5ba550d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 05:19:33.9590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzmU1jPkY1d82uWfVk2Umz9EE9e3hVYX43UssnKaagQ4PANT+gw8dbpUpSOtt7OM/2FCRACA9UULZed9mQytoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5790
X-Proofpoint-GUID: zpQyRcUplCMVDDTPdpTP_hYBKiq67uuE
X-Proofpoint-ORIG-GUID: zpQyRcUplCMVDDTPdpTP_hYBKiq67uuE
X-Authority-Analysis: v=2.4 cv=TrcchCXh c=1 sm=1 tr=0 ts=67c7dee9 cx=c_pps
 a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=20KFwNOVAAAA:8 a=M5GUcnROAAAA:8
 a=1s1yUlYpqXZwkuTDsKQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_02,2025-03-04_02,2024-11-22_01
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

PiBSYXRoZXIgdGhhbiB1c2UgYW4gaW50ZXJtZWRpYXRlIHZhcmlhYmxlLCBhZGQgbmV3IGhlbHBl
cnMgdGhhdCBoYW5kbGUNCj4gZGVyZWZlcmVuY2luZyBwb2ludGVycy4NCj4gVXBkYXRlIGRtYWRl
diB0cmFjZXMgYWNjb3JkaW5nbHkgKGFuZCBhZGp1c3QgdGhlIGVtaXR0ZXIgdHlwZSkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNv
bT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgdjM6DQo+IC0gc3RhcnRlZCBmcm9tIHNjcmF0Y2gg
d2l0aCBkaWZmZXJlbnQgYXBwcm9hY2gsIGFkZGVkIG5ldyBoZWxwZXJzDQo+ICAgdG8gYXZvaWQg
dG91Y2hpbmcgY3RmIG1ldGFkYXRhLA0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gLSBzcGxp
dCB0aGlzIGNoYW5nZSBvdXQgb2YgcGF0Y2ggMiwgYXMgaXQgcmVxdWlyZWQgdXBkYXRpbmcgQ1RG
IG1ldGFkYXRhDQo+ICAgZml4dXAsDQo+IA0KPiAtLS0NCj4gIGxpYi9kbWFkZXYvcnRlX2RtYWRl
dl90cmFjZV9mcC5oICAgICAgICAgICB8IDEyICsrLS0tDQo+ICBsaWIvZWFsL2luY2x1ZGUvcnRl
X3RyYWNlX3BvaW50LmggICAgICAgICAgfCA1MiArKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICBs
aWIvZWFsL2luY2x1ZGUvcnRlX3RyYWNlX3BvaW50X3JlZ2lzdGVyLmggfCAgOSArKy0tDQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0KPiANCj4g
Mi40OC4xDQoNCkFja2VkLWJ5OiBTdW5pbCBLdW1hciBLb3JpIDxza29yaUBtYXJ2ZWxsLmNvbT4N
Cg0K
