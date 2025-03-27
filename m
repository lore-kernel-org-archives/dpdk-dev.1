Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EAC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 12:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 798F2402E6;
	Thu, 27 Mar 2025 13:13:30 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6AA31402C8
 for <dev@dpdk.org>; Thu, 27 Mar 2025 13:13:29 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R75sNF013524;
 Thu, 27 Mar 2025 05:13:26 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45n1yv8m6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 05:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Amy7oerHph9elKcXLvOFGIttPCKpG9lh+r5YSCL3YIOvKryBtmpH2M9/fr2wbgZ2tjW9fISxNrXbbXsOl1vUvVg94QGMLa1LlEaoRMd+knNWUSig2XkhdVH4KDWOIUQ+tzTPcVYPexQhtSFYfn/EpPFlrumiGfGYk6+OUFb13lwNQ3TP2hh3Sdnd8PWcH6VSXBv3Q6bxyuNCKZkCEpMCjyUHRAbH1pz77is7bLQPcbzQ16fbFxsERfDLShNTjnyGhFsYydlRUSoXG719ZG2AcFxqSUVCC3SPGulSVS9UcJTLy3Y8WeowjKfD1zFTXWX7Q2lYnzBn7r4uVax9chj8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP1ekakR7jqi2PoArcM6S1bG1/0Nj2wadU45NyKTn3s=;
 b=FHsB3rMRUXzeiD0cpU0XMLDKuEsF21+aBbAlUofeDPrKZ5dAuUb7VYpq2AxeCxH4D6aQsk9HVxiIsP1ybM5GhoesLXCduf/3hMp9CmsT6N7x0f/IEGp8i7AE7ssvWnBoGVUKBBzOt8anzJ1rUK/uZ3k34kHeNTPRNTPkqQGgnWkHdpihh+9sWzAs+Vj1A1IkL6x+18HBcp0R8LVMYZdtQmP8YZMGQWVCprf53KKkvPJG4jRqFxCatWpBLEQwTE+/6AiJyOTnUFom/Kv2btSMiMj0MGZrZ0aTL/bh6HHNCgIH1nCD8WwOeB3AgyEu5zEVz7PgEoO+C+wtDUzF70/HkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP1ekakR7jqi2PoArcM6S1bG1/0Nj2wadU45NyKTn3s=;
 b=gyJA9LRoesNub6rItuQAwHF7fecYPIDs4YS6mZ88p9UYztEHUhq/uCFZPocrOncr0NwjxmpiJnezhxSHKm6W1TGzGMqZnYV+tXIIBNZEjl/7o+0vY6Ju3iBKMkc4JigexDBRNYi9mkt3ghXxo7LseKANDLF+zOWbOZnfYNZjs4A=
Received: from CO1PR18MB4796.namprd18.prod.outlook.com (2603:10b6:303:ef::23)
 by IA1PR18MB5490.namprd18.prod.outlook.com (2603:10b6:208:44e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 12:13:21 +0000
Received: from CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::f8a2:222b:6611:ba0]) by CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::f8a2:222b:6611:ba0%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:13:21 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Pravin Pathak <pravin.pathak@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "mike.ximing.chen@intel.com" <mike.ximing.chen@intel.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>, "tirthendu.sarkar@intel.com"
 <tirthendu.sarkar@intel.com>
Subject: RE: [EXTERNAL] [PATCH v1] event/dlb2: enhancement to DLB credit
 management
Thread-Topic: [EXTERNAL] [PATCH v1] event/dlb2: enhancement to DLB credit
 management
Thread-Index: AQHbh8qtteOOZoyNhUmRija8BJF76bOHE4VQ
Date: Thu, 27 Mar 2025 12:13:21 +0000
Message-ID: <CO1PR18MB47962F090F2A3AAE835A5F65C8A12@CO1PR18MB4796.namprd18.prod.outlook.com>
References: <20250225211715.412663-1-pravin.pathak@intel.com>
In-Reply-To: <20250225211715.412663-1-pravin.pathak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4796:EE_|IA1PR18MB5490:EE_
x-ms-office365-filtering-correlation-id: 96e7addc-2a44-48e8-a4ad-08dd6d28c41a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RVF0Z2d2cU5TWjRxbVQ1b1RuWG9RYjBUb2ZzQjdYcWxXTE9qVjFCR0JwTWJi?=
 =?utf-8?B?M2Zna2VWTGExNUNoT2k5VmFWdnNqQ2RLQVFUcTVRRXdyMmhqc0FKZ3VxeThj?=
 =?utf-8?B?NFRxNEV4R3ArM0E4MkVTcmhZbHN6Z3JYM0lNWTIxazB5aStsdDNjbXpvRjhF?=
 =?utf-8?B?bGs0RWpXdXQ2enRoQ3JUeldjQWc1T3dUN1UwTXljR1NVNU9lcjFjd3ZTeUdB?=
 =?utf-8?B?ZXAxKys5VXR0aFhMa2dtQ0drcEpaVVpnYXhCcnRXRTIxZzA3Zk15TzJlenIz?=
 =?utf-8?B?eDM1citFcXpUcTc4a2MySzdXZzg4R3hHdEhySlJuaUVSd1NtMjVWc29uZHRE?=
 =?utf-8?B?UEQxYVI3YUdNQWk1ZGhmemkwVzFZcTY2eWhHZDdldVRoZTZPeU1mQTBkZ2FQ?=
 =?utf-8?B?SUh1NGVZQW5ucGpWQ1FqbGltb3BjNzJxU1ZqOFdBY1l5WGREcDkwbjkrdmJ1?=
 =?utf-8?B?WVFFaXVHK2h2a3FsU2h1QUFUMGFnUjF3RzRpdWlIbHFPTTA1RDg2RTJ1eFZw?=
 =?utf-8?B?SUtpYnlGMHVBb2ZTU1VSUlFybjM4S2pSY2xBWVZtRVV5ckFyZTk3QTZIcndt?=
 =?utf-8?B?T3RUM2xlOFhSbmsvOHlNVmxSNXl3N1BhOHBvaHk5VjZTb21GaW5aZVA2VllR?=
 =?utf-8?B?cEpLYktha3RTRmVOeTFHV3VTRGNJUWhyaVV2TE9NVUp5ayt4eTczNzVnM1RY?=
 =?utf-8?B?anZkWnFSL04zalExakdZd1M2b3p6R2xBOEtQdFlYOUhmNzhKTmJvODRQRUhQ?=
 =?utf-8?B?amhoa0p0Znk0UVk5VHdRVU9PSmVGNTRDQ25jM0hLb2diTVB1MnFZRllMakVz?=
 =?utf-8?B?YjdiVU9naGJyVFpiOVMyVGI2K1hxTDVDbG9wa1pqSUFabTV5UGd5S1JWWEE2?=
 =?utf-8?B?U1pHbDA4UE9XWFhDSFVDaGhMbUtTWWRCemZ5ajFHTW0rekg2eDB4WjdaZnBz?=
 =?utf-8?B?dUdJYU9IREZadjZQa3JCRlBwSm5EQk4zdzlSZDVnT3dpeUx2RVM4dUZtTzFK?=
 =?utf-8?B?Y1F3SnhiOHh1L3NTaVE3eCtQNkhPSE9KMnB6WWNoV1VkR1pNTGVMcUM0Z3By?=
 =?utf-8?B?TTJjRSs5SFlhaXJpeWp4dlJ4T0RzNFlac0YxYlBrMnRLNUxicVhNYW5KTTRB?=
 =?utf-8?B?NEx4VloxYjJBWnFoY0JMY0xUNE1QWW5oZ04vclpTbk5iY2gyaWE3bDQvb01F?=
 =?utf-8?B?LzFMMlRFNGxPMk1KbEVpdWV5c0dLVm1jVkpJdFE1Ti9ZaHA0d1B2anpvckFh?=
 =?utf-8?B?WTBWOWlIb1duVy9VVDJlcEZuVllIWHloV2FCclBjYk9GNnorRGRKK2JZZEVQ?=
 =?utf-8?B?c2dKZ1ZubjlKTVFxYnBBNE1ZUlFvUWFFSjQ0MVY4VkVEc00zSm9BMHUxaWJo?=
 =?utf-8?B?WDFEL3E4cmp4UTNWeTFkdU81WnJGMG5LVGN4ZXlORU9PdW5MQjhsdmtXVmUv?=
 =?utf-8?B?REJ6NGFnQVVscDJPenFUTGVSQkNsbTRLV01vYXQweVR5WGxnS0UyR0dHVWlP?=
 =?utf-8?B?Wk1RbVZZeGNDS1l4S05VTlp2eVkwcVgzM0Y4b29aU1VxdEdxQy9xREo4czlP?=
 =?utf-8?B?bHp6T2VmcW1DdDZmNUQvZFVtL1pCQTF4OUIyQmVkdElsdDFhd1ZjNE55NEg1?=
 =?utf-8?B?QmZGL1hOTExXVk4yQ3h2bVZ1RS9va3ZIZElJYzFSVzBqeitsellyNjlML2Zy?=
 =?utf-8?B?Uks0UUIxakxaZzJzTUFQZ2c4YUxuYUpDVkJJSGVhSGdPT05SMGJnWGEreGFD?=
 =?utf-8?B?M0hKU2d0N3ZkMU1KOXVyekR5T3dCMStja1NNbjNaRmY1eGlNaTF1VzA5d3Fx?=
 =?utf-8?B?Z3JBbUYvaUJISmVGZ0RTZDlrN0RNdWdoUDRmREtjMU10a0JQT3FvUkVzU2ll?=
 =?utf-8?B?MHlNTjY2bXc2MGcxTEE3ZmlzcEs1K3BkK3R1Rk8yZWJSYUp6U0R5MVVzUWI1?=
 =?utf-8?Q?hw2fgWOLjS8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4796.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHBCdDNSTUlQcnl1MXZSR0hXdDI1Vlcwb2lhSW9xVzQ1ZXpScHdGSWZFVmpN?=
 =?utf-8?B?a1EvUmNqWFpsYzhpY2hBYnZjb0lwa2FDSG1CRFFQUVEvbHdPRHZYK2JhMEVo?=
 =?utf-8?B?MUJrdFRSZjU1clVlRy9EOElFa3dtSVFHM1duREdWVU5PSjlvalJHdEIzdnZS?=
 =?utf-8?B?YjBJOURFR2ttRmpYNU5rbnF5STR0ejJ2RTE2aDhoeHpGOVVIKzlQUTFLUWJM?=
 =?utf-8?B?MXFTMG1BMjlLMVhqcjd5c2w3MjVxMjlvaDFrTXpReDI2QmxzVmZoOWprZEl5?=
 =?utf-8?B?KzJQR3lTb2s3ZHB3NktOZ3RVeXVsQWxpMXdkSmUvaUw1Rk9QOXllNkp1eDl5?=
 =?utf-8?B?cGtlZko2WnFQRGVwdndtY1AxTFdxSkw4cGJ1NEFwQ1pHYU1SbDdnTHJOMzJH?=
 =?utf-8?B?Z0MyMXBsanp3Wkl5cTJGS2lpNmtna1B2b3l0WUVqbFJHWHFMTnA3a1VoTUxh?=
 =?utf-8?B?d1NESXVaR1ZRZU1xdXQvektaM0Y0L0RlaE9kMUdtc2NTTVlhZWwzUStvKzZ0?=
 =?utf-8?B?YzlMTUtRTGNIMDg0Y1lrMGtudk1vOUJ5UTRjaUp6STlZbDJPUTgrY3dxbU15?=
 =?utf-8?B?cy9zWXhNZy9JaDFIdm1pL05oM0x2K3RZeEFnZnRqOXFFeHZVMDRNSCtaTndB?=
 =?utf-8?B?U0FnNWp1YjRTaGU4dCthZFVPNGo5MFFkRDcvS056c2l0bEx6TWdsd01VcXlT?=
 =?utf-8?B?K0hQK1lQL1RMR3JMemtiWEwvN2hBdnM3QlNGenZGbTRGRSttRE5wbmh6bWFr?=
 =?utf-8?B?WjI4SDdVRW5rMTR6QzZQNXlJcjdrd2ZJZnZKVHBUYnJWaDN1VWRMWnhreVNE?=
 =?utf-8?B?a24rc0RaWFovdlZHaDZ3UHI3YU9xYytBbjZVcEphdGFoWTdWaGNzRitWLzdk?=
 =?utf-8?B?SmNieHVlQ2QwK1hiWkhLODNCK1RFMHUyNXpVQTFLRFgya21UMW9GT3ZPOWFB?=
 =?utf-8?B?YUd2TmJ1YUcrRFlFajRyUUxveTlqMmxML0JjS3Nsa0NZNmM3YytHQkx1V3FH?=
 =?utf-8?B?SXRPY2tKZjdRcStscHVxaUQxZUFaUC93eFhuVk1ib2FDQ1UreXRxL0NIclJN?=
 =?utf-8?B?VVNTRm5FNUY2RjNGZ2hmanpqaWpicUx3WVhSRUFwWFFMZlRsZjVJNjFmQlJH?=
 =?utf-8?B?VE5lcWsvQkdYdkQ1by9KMWs2WVF1VmZFU01CVENiaVlYQ0Fia3YyOXE1L0lM?=
 =?utf-8?B?WlVlQ2RiY0ZURGhUbXU1RkwySXkyMHBUSEVrWjVCL3RkeUk2SStSR0NyOEZk?=
 =?utf-8?B?bnNMUXhQUmhiRk9Gc29Ud0dMRzNBY1E0TkRSdThDdGJSQ1h3TERXcWRPdnJs?=
 =?utf-8?B?WjZSZDNLaGtMVm5LbUtpQ3lKcnhJOTF1M0dHV1F4Z050UlBoZlh6Ry9oZ2lI?=
 =?utf-8?B?SEViTjdtUGx3dlYrVTlaYm9DakFtZk5Edjk3SDd0LzVpV0FIRTdGVlVDd1pk?=
 =?utf-8?B?VW9Eek5MZ3JqVEtTNmN3SSt3cWJQb1JIb05YZys3ZHZXaFBlVkxvRFZsaUxN?=
 =?utf-8?B?RkxSNmJvTWFxUVozRERHcU8rbGlpZnRMcDE3S0UrVVdVanpjY2xvTXAxTjIv?=
 =?utf-8?B?V0FHeU1pU1FTUDJPbW9raklCeWMvaWxRMG41UUlZd3FaQlJ1RitMSC9SWjVl?=
 =?utf-8?B?R2pKMXN2TGJvVzZrQnZtUjdaWjRKaHZNSDYwditvMWpTbzRuT0EwM1RoMGhZ?=
 =?utf-8?B?SFlvMEhxUElzbXVJemtsOTlEVDhmU0g3dTZwOEdrMXZVSlhEL2ZLMkNLS2Fo?=
 =?utf-8?B?QmRuQzNsakpDcU5mQS9MNS9LVmg0b1NIdS9nWnVoNnc1K09TT2E5dDRSS0Ew?=
 =?utf-8?B?UEdrMVRUbUJHYnYxUDg1cHhjckJ2QnJ3akRUMkRNSmV4aU43alJxM1RkYTdu?=
 =?utf-8?B?akpvMzlPWGkvMElpcUpYNzU0YitOWkJUUVVUa0FFa0h5d0ozR1hBQVU4dkU0?=
 =?utf-8?B?eXl6cXBJcjYvVjg2VDR1aXFDM3NvS2haelBmWXhzS21RcXVidUpVa1h1Q3Vo?=
 =?utf-8?B?cTJrTk9VMjBLejNaR1ZuL05PeG9JREFPclU4a0NKNWdqSXJuS1M1Nm1hcmlB?=
 =?utf-8?B?UGhlS1lWZHNHR3FZQUlXcDBvanBmTENPNE4rMWpKZHp6T0d4NHVPbmFucm1t?=
 =?utf-8?Q?vZMbEhekSJ8zuxuJx2XDYMbFi?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4796.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e7addc-2a44-48e8-a4ad-08dd6d28c41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 12:13:21.2367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G992lo6kAfVgS3S9CafEtNPtiCqIhzbfgHKD7Jg4HU391AhRtNGVck59CWgoQVS0BDEfSNj3dcbIuKxZYnLe8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR18MB5490
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 8A4yo9k0wy9sbBNNg6lcFPdH4iP2lLMj
X-Authority-Analysis: v=2.4 cv=dKCmmPZb c=1 sm=1 tr=0 ts=67e540e6 cx=c_pps
 a=zz2QubYGG/9FVtTd3zWqHQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8
 a=zd2uoN0lAAAA:8 a=Ikd4Dj_1AAAA:8 a=RpNjiQI2AAAA:8 a=zSJyLDGILjiGCiDo06oA:9
 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-GUID: 8A4yo9k0wy9sbBNNg6lcFPdH4iP2lLMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
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
> From: Pravin Pathak <pravin.pathak@intel.com>
> Sent: Wednesday, February 26, 2025 2:47 AM
> To: dev@dpdk.org
> Cc: Jerin Jacob <jerinj@marvell.com>; mike.ximing.chen@intel.com;
> bruce.richardson@intel.com; thomas@monjalon.net;
> david.marchand@redhat.com; nipun.gupta@amd.com; chenbox@nvidia.com;
> tirthendu.sarkar@intel.com; Pravin Pathak <pravin.pathak@intel.com>
> Subject: [EXTERNAL] [PATCH v1] event/dlb2: enhancement to DLB credit
> management
>=20
> Updates are added to enable releasing of unused credits by threads to avo=
id
> deadlock and starving of other active threads needing credits. It also ad=
ds
> compile time options to enable/disable credit checks. Signed-off-by: Prav=
in
> Pathak <pravin.=E2=80=8Apathak@=E2=80=8Aintel.=E2=80=8Acom>=20
> Updates are added to enable releasing of unused credits by threads to avo=
id
> deadlock and starving of other active threads needing credits.
> It also adds compile time options to enable/disable credit checks.
>=20
> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>


Updated the git commit as follows and applied to dpdk-next-net-eventdev/for=
-main. Thanks

    event/dlb2: enhance DLB credit management

