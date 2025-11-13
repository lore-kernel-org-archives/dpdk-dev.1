Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07374CD4F39
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 02:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3906340A6D;
	Thu, 13 Nov 2025 03:16:43 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id B365640151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 03:16:41 +0100 (CET)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1FGdK030500;
 Wed, 12 Nov 2025 21:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=d
 bUN7kQk3vG5BOqnYbBL2d2WeTqjNp7WwOtqvxsEDe0=; b=XavfDNWNKAr5ObMse
 Cp9pW5g5LdZbKTw+nencGATC7fABv3IDKAxZkmCgRZ4BLwWhzsptNBc+VMw5XEyO
 IqXwibQCkidyxjL1mra76IZ+UJj4Fhb3pR7oA73ym4sFgBcmp4pgfN2LsFEz+6b7
 U03roa28djdP73DaPbRbnFlr5wpfZuESV8YMpWF66CJOo4khksOnKx/ClyooRoZW
 N14/aM77MJQTTKMg9k4XynIFpqCzzSwbjYeLq7PfNhjg1Y2ufYp9DzQ/dqljmcL3
 s2Kb1un8w/obsNQ1QAG83RKfgypAegw22wAwkM++DYIFG3JF4rC1SMkAm1KPch58
 Ig05Q==
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa1w1q19x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Nov 2025 21:16:40 -0500 (EST)
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD233hO012177;
 Wed, 12 Nov 2025 21:16:39 -0500
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ad672g4q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Nov 2025 21:16:39 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhWygC1pP6QUhwk3YL4/bN2uxP00w1RSNlRWR2OodFiPHbkEToI0TIjQMxf5nlO7qdLUOWT3iOLAeK4ZmjSV6duiQ7oUJTZ52SsFFlwmf23FXohDcZKQet0VSXnPJG8sO639dbR7h5OIW7M78/ijW6sp1oUJHjMYPJK6MxGCkgIEwSfwHFs3ZP+L4r4kDSCg5jgrf6DtalTdmtWcfOkk2MXckJpRGfxIQfWolIUIzKhhkocqwHdbAfucW2rXYb7+bXXwfnkuJCG3CWBUWJU4gK/Qy59Lvapwk5GSJB2zCydKgF4OAzQx1g/CbXeFUnFRO0JbyLqIlNYZ6VQx/3SOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbUN7kQk3vG5BOqnYbBL2d2WeTqjNp7WwOtqvxsEDe0=;
 b=j1JmwhIRB/XkjnA8qRS+KJBAf8+UPFoFuidNrf9eOEi1Yri1uEssRIGomzulVLclaE6VE0FixSN119MSrE9LWfBv81jiRX2j4x5RQCqab2lUNuCI/+IvIJNBcCvfsnwq3F6b0qJ7kPLjZPUXu701T6HUSAEevX7j73ZA5ok/ikH8EWojWDO1aH8OAqIEZJB1MMqziV/hi4a9Nnm3Xuirs/fo5+7M0n0UufRtPSYPEuYnhkAJueV/novIlhyyblXQpsWtk84d+/hVlun7xCByDByZhQ96O95f45YyfTt2zR4GmhKSmUutvwLaDq2+XngO/V4UbmpUBAekQ6K7vJs+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by SN7PR19MB6945.namprd19.prod.outlook.com (2603:10b6:806:2a1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 02:16:36 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 02:16:36 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "pravin.m.bathija.dev@gmail.com" <pravin.m.bathija.dev@gmail.com>
Subject: RE: [PATCH v3 4/5] vhost_user: support function defines for back-end
Thread-Topic: [PATCH v3 4/5] vhost_user: support function defines for back-end
Thread-Index: AQHcTUK1uWn6VStxUE2UwNqpzuYUW7TiKRWAgAs49gCAAOixgIABoRkA
Date: Thu, 13 Nov 2025 02:16:35 +0000
Message-ID: <SJ0PR19MB46069E6943F5A59B2A5EA2D7F5CDA@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
 <20251104042142.2787631-5-pravin.bathija@dell.com>
 <051163f2-7b6e-49db-83cf-7f6f366c448a@huawei.com>
 <SJ0PR19MB4606743990AD1AFE8EC06217F5CFA@SJ0PR19MB4606.namprd19.prod.outlook.com>
 <8837e213-bc2e-4e8f-bb12-c27819ed20ad@huawei.com>
In-Reply-To: <8837e213-bc2e-4e8f-bb12-c27819ed20ad@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-13T02:14:01.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|SN7PR19MB6945:EE_
x-ms-office365-filtering-correlation-id: 8e6fc264-4807-4e67-7cb6-08de225aabea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-7?B?cjJsYlJDeEQvU3dkRzBCMmI4ODRuUWhXM0NyMEV5UG1WMkhFVEpXRUtCL1BL?=
 =?utf-7?B?LzcrLUVhOXhFSHlCaUFwYjJrejRSWVg2SmdNN3Q1TW5wKy03RzdJTGkrLXN1?=
 =?utf-7?B?amZZcTVLYVFwUzhjeVdndDVvaWlXc240b25ya2ZFVzkvZkdJOWlRV2grLWlN?=
 =?utf-7?B?RHh6OU1kZ3psTVlzSy8zMW9ZemdlNTdIN3EyRXpxbU05T0c5bWt6ODRiTVFt?=
 =?utf-7?B?aGRJSUlXRXBKNHNBQU1hNVlra1J3UkNSNndpTnNuRmQ1RGZJeHQwMzRxNkxV?=
 =?utf-7?B?dlVNc0MzMzMzZEJvV293L2M1bjc1SWdMMmZjQkJmd3JOcG15MXZ0N3QvaGww?=
 =?utf-7?B?WEpEU0ZJWXJiYjgxSnpLMlQzay9yYXdhejVMUGZPOFJjOUkxbkRZUHAxVDQv?=
 =?utf-7?B?SGVLZmZEOUNnaE5Vbk9hc2NHN0J3QU1FaGdSd0pIeUhDSEVLTnljMC8rLXhK?=
 =?utf-7?B?a2xFN055cEcvNUVwSDZTaDhGWkVXRXBRT0VCLzVuTHFIVnRSdUoyS2hxd1cw?=
 =?utf-7?B?alliWnpQd2UzeistczFCOEdOZ0Q5dWVXcEVhenFYaVhoVjcvTUJtTU1tY2lm?=
 =?utf-7?B?ZXB1dElqNjFGL01Sbzl6S0xQTHZOMklvZ3hjQm8veUl3aC9DcEYrLTJwTWpL?=
 =?utf-7?B?cystQkpDRWJVblBMTmdPQ2tqeHBDQjRNMXdPRFdhKy11QUVxUnY2ZEtnVEZY?=
 =?utf-7?B?Q2lnSmxQc0habDdUSjZJY3NveWVtWHh3bGdkOE1HcEdHU0tzcDE2b1h1R09Q?=
 =?utf-7?B?YTYzWGF1REtsUkhzN0RWcWJZd2JQQTNPc3BlTWRra1JLVWo4R0pyT1dEVHNQ?=
 =?utf-7?B?bnd6aU1VZWNwRTRReE1idTBJZjAybS9ML05zYXBENm1tRU12c1U2UVI5d3B0?=
 =?utf-7?B?M0JKQ1Ixb01VMzlIY2paN2JEY2FPUHpQNlgrLUozcEdYUzdvaWI4M25aeEQ=?=
 =?utf-7?B?Ky15ZU5KN0EvdFQ2bUltNEFPUWJaYlZYbkZVNW55SFZoM3AvZistMFlhLy9T?=
 =?utf-7?B?WGlVbzJqKy1qc2JJcTFtZEM0R0xzZFdUdWdoU1J1RnJJdEpvSFBqWWdiVE0x?=
 =?utf-7?B?bjVOQ3BvQ2kyU2FqNE5na2o3VTNFY0w4ZEIwUDhPbG1sRllIL1VxVk5RSk1W?=
 =?utf-7?B?T2NwbEQ0L1VtOFlkekNEblc2dk1tYlVSR0RjcjEyNm9Hb2syMkVxYVFRZ3VW?=
 =?utf-7?B?cVFYWjJOSHNwOUYyRE1mdmRzVHllT0RCV1oxa0RWWVFjaWFIU3RZZFgvRzMx?=
 =?utf-7?B?VkJoWkp2aU9peVUvRlVRaDczRlhiRmRQYWVPdlZaRXVRWFdnczR4N05oc3pF?=
 =?utf-7?B?YUFLdzU4TmRPZ21BTmpldTdJeHo1UzNobkxOdTF4Z0J1UUlYUmtSQm93VUFN?=
 =?utf-7?B?cXA4WlJIdE8xakpPck5QbU0vN1NGUzhwTUppcFJXdlA0N0NqTS9zMTYzcHFE?=
 =?utf-7?B?YmMzKy1Wb1hGNG1LRzQ5aG4yM3poaExrcjhqdkhvL0NkL1JRbENZTW5FVzhP?=
 =?utf-7?B?Slg3NWtKM0dwTlFEV2lBaDB5cEZqQ0t4RFh6c1VoMUtyZjgyN3Y2MXpwUHVw?=
 =?utf-7?B?eUxlZ3dlQ09UZXRPcVpaRkNrd2VmMzhmRnFpZXhVbUdSR2dqeFdrOUdBYSst?=
 =?utf-7?B?MGtoWHFCRjN5RmJIMWVGcmx5T3plSktGYkFpV2s1L1FCYVdPMUNXV29WL2l5?=
 =?utf-7?B?SlYwM09ZQ0U2V2VnNXViN3RaY2RVbmFVNmJ1bDlCQTliTS85WG5lWk52VElk?=
 =?utf-7?B?ck8rLVJoNjE5Um4xOTZld0NXeFE5ci90L1c2YWJJb1lTUGx4NVJRbmNLekZH?=
 =?utf-7?B?VDM2UFhXS0hPTGdKYW5QNnJDOGEvWW1NNk1DS2dhSDZpRGVyQTNtYWZKbU5o?=
 =?utf-7?B?OVd3U2xUcmhFY3VpN0FlRXZMeFE5VUp3NS9ESDcwQnpwemJaVk5UWGNQT2hx?=
 =?utf-7?B?ZlJITmlaTWVPOGtlbUpyKy1XN1VxU2lYL2pDbDBzaTUrLU5ZeFlXb2xpcWZ6?=
 =?utf-7?B?ZFhLcjZEc3Zvci9VWVBEbFFqYnlHSkoxLzhObS8xQ3A0akN3YTN2N1FaQlZn?=
 =?utf-7?B?TUFIdVdnU0QvYzdRaTVwVG9zZzIrLTM1OWI=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?TFpvZEFSdTlOY1dVS1JPSzhSdWxDKy1EUzNlZ1R6U0hmVEVpbXltMFpVMGJC?=
 =?utf-7?B?MElDT1JoKy1qYnNCbkVjcUEzWCstUWFCaTlKOW9tM0hxU241T0dlWXdnQXM0?=
 =?utf-7?B?Z2c4NXh1N1FoaDZZNFgzaVhwWGVDMUVWV2psVklsTVF3eUdMS2U2WjdrY0pq?=
 =?utf-7?B?bmI2a01lKy1TR1lBVFpFUXhSNUpsUmkydnltR1BQcEFCTVNpTzhGc053RTdo?=
 =?utf-7?B?d1ZxZlFEQVRhWVZ5L1JTenpEVkU3b2xrQmFxWnhSMko2ZUVWT2xUbnRjQWVx?=
 =?utf-7?B?NG1ocThDWEpkc2dHYkRrVXIxcWdsTzR4dUlZR3NzS0U0SWVGNUVNaHBiQjM3?=
 =?utf-7?B?RystbSstUVZUUFgzaSstOEJjd2lkYSstM21OL29GMnQ0RjR4QVl6WmVnMkcy?=
 =?utf-7?B?VC9TMVVzd3lXRUxnZUdIYTFzdkZpSlM2cVlNOURxaUdLcmcxOFl6R2RGWDNZ?=
 =?utf-7?B?ZHl2cGs4Nml0SG9ORThkamNWUUFQM3hKZVNuNk5xQVdoU09XaG9lWnA5bSst?=
 =?utf-7?B?ZDB4c1c1NzFVNnl4U2Zzd3Q3V2FaUFl1MlpFUjdXb2VSOUpXRGkzZEhUWUdE?=
 =?utf-7?B?OVNINjl1aEs2VzEyR0pZWVRiV1k2THltTmNKOFNZMFZCVURRVlBrR2VwQWY4?=
 =?utf-7?B?RWlvSVNlc0FRKy1CTkZLRUFXYlBDQmNOcEc0M1hsNWs2bGZLUXFFQk9EMVpQ?=
 =?utf-7?B?UWZ4L0kzeTlKUWJqc1lhOVdHKy1YMHZaVXluZ0xDLy9ldDE4clU5SW1tVTdV?=
 =?utf-7?B?aFZDdnlkZjRiV2JRYlpzN0hoZHVOME1xcUlwQk9aMm5XVGdpQjRzZFpUVHRi?=
 =?utf-7?B?dENxd2ZxbWRQck1KcjA3M2JXVVB5ckpvY0RTUGlTR0Y5Nk5rbEdwTEloNVMx?=
 =?utf-7?B?MFc1T3dwcTlKVkJyTmExUmg1ODYzMWg4ZkpWR2dacmJwZmZDVEJlUjB2TmVS?=
 =?utf-7?B?clZYaFNnNXVjYTd1VmFweU44UGU0RistTU9KemZWakRsOEtZazR0R1FnbUN5?=
 =?utf-7?B?MlBWM3NRdVRES0RWTWxRWnpMdistWXhnTmo3dXljKy12L2Q2ajdIRystVy9H?=
 =?utf-7?B?VEFITXlIeGRSSmhaZmpQdXdMWlgrLWttNkxEaURPUnppeFB4QVRqTEFDc29s?=
 =?utf-7?B?ZmhuWGRhckw5QSstTGE4QjBsbkx6QXJNM1BKOWoyQystUkI1MTFLczF3YzlJ?=
 =?utf-7?B?dWpRT0pZVnVkMFVpYXlHSHhGOVlYckYrLUVlNUpXakJENkpscENvbkxldkFh?=
 =?utf-7?B?VUJxRHZ0RWNUU2l3NVVsejRIb1dFSFR4TUlUU09LU3ZLRkVtUGFNQmNmbHJP?=
 =?utf-7?B?QVNGaWIxVjhXalVvRnNoNHVEQWljOGcwbTlnSXFKKy1OR2xlbG1kaEdFbjFx?=
 =?utf-7?B?M3RBUystWjgzaGVJZ0NBYWdMaE5qT0JmOXZuV0oxTG5xVzZZU0NucGpTVE5w?=
 =?utf-7?B?Y3hjY2NxYlZpNDZHRU1hNU82Z0lEUSstQkJ2ZFh6dTYzMC83Q1BZRU8vNGI3?=
 =?utf-7?B?Tk5WcUR0cW92T2QrLUN5YmVKRGthQkNsaHh0UnZWUU5JbWZuSWlaRnUwMGhP?=
 =?utf-7?B?UzRnN0pydEpCMzFCNDN3VE0zU2tyYkJyRjQ4WW9acWFDcjQzN0NiekJLV2RD?=
 =?utf-7?B?a09wUistZzYrLUJ0QVZ2aHdkNzI1ZzBIVmZ1a2F5VTFueDVjazhJODA0bUZB?=
 =?utf-7?B?a2JUUlc5dksveHFLejBYamQyOEd3UDc5cnpMOG5nWGgrLXVCZG1TNnJxaUlX?=
 =?utf-7?B?UkZGSnhtL3UrLUpqRDRpZU92NlFwcVRvL2FvaE4zNEFGTzVQU3hTbndqQWEy?=
 =?utf-7?B?NllLNlNpbVFiR09qRVNLY1V6dEo4dXFTN1VOd2pVRmFWRUswSlVMVTQzeE96?=
 =?utf-7?B?V0Q5Mmd1USstdWhCRVkrLTQyNlFmNjdwSXJXWHZwNTlLWHRPZHN2U3dMdk1E?=
 =?utf-7?B?OEFEbjVkcnZwY1RpVDEwSTh6OE11NnBjdlo3Yk0vVnZvMEMzR0Fvc2l4NUJk?=
 =?utf-7?B?R2J4STNwRm5TVG5WRGxCSnQ4R3RXNGYvYjdZblBsSGd2SkNpQUdFMFE0VnNK?=
 =?utf-7?B?dlAvamV1SFJCbystSlZxWURzRmJJVWRCT05LT3ErLXZEYnUvaHoyaVZidm9R?=
 =?utf-7?B?alRIYWI3YnNjd3VWa1FYNGlsaldwNEk4UGRPMXZDWlBoZ0JnbWJMNnY1S3VZ?=
 =?utf-7?B?NjcxSFFvdzc1RVc=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6fc264-4807-4e67-7cb6-08de225aabea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 02:16:35.9410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xbm6tlrskyeP23NTMv6flKAY47vqmbqS/f4no9wO55a0NzaiIxMSXam25Lhki+KZZrHbcV+wmOfrfjV4YZazkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB6945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130011
X-Authority-Analysis: v=2.4 cv=a7g9NESF c=1 sm=1 tr=0 ts=69153f88 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8
 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=eSb-bNSJAAAA:8 a=QEEkIeqjAAAA:8
 a=aYO9U0W5PoPS3TTiJzAA:9 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=7k9nRlTqVbDGZ3p5_T00:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=iapMWHAMLVzCBf0btcAb:22
X-Proofpoint-GUID: 19WGGNcYYb6_NpfX1Ko-HV4Ui_lUYCb9
X-Proofpoint-ORIG-GUID: 19WGGNcYYb6_NpfX1Ko-HV4Ui_lUYCb9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MyBTYWx0ZWRfX6F8CA9ZNYUK2
 9wTWh8jPXcv1f99+PakREHmyoWLJnzibhsN1wVAReqGV6Qs0iOppGSxrThrlwH/vmgwPdSRT5oS
 WCu7nkecKAnpAKTyiaFpTv36wcQ1jskaF9oE2yf/mMptR+MN/FBHns6jM3bHRhB81AGuRLnihWp
 4N9qc0j1zC75JRlDQhvPABbndgOEUi37+rSNXCiri5Yy5mnf4FAGA7Ao0t8Pws4vUrQk3lddIR8
 CsLgHe9UlH7Vza7D3GveCbQMAJqJADzAbNz7mBACDHKe+7iNPzbYTxLMGdpRMdzQYo1AdXs6oM3
 r0cPcKTDWBQMxtJP4pN1FFlrCUwX05F2KsK5uLRTNmcCLOnaxbt33Uy+bvsft3VvNcwXPu8bEOR
 g9OOnjidg7W3fc/Re5Gl2ZdE05nIxw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080063
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

Comments inline.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- Sent: Tuesday, November 11, 2025 5:21 PM
+AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw- dev+AEA-=
dpdk.org
+AD4- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- Subject: Re: +AFs-PATCH v3 4/5+AF0- vhost+AF8-user: support function =
defines for back-end
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- On 11/11/2025 7:31 PM, Bathija, Pravin wrote:
+AD4- +AD4- Responses inline.
+AD4- +AD4-
+AD4- +AD4-
+AD4- +AD4- Internal Use - Confidential
+AD4- +AD4APg- -----Original Message-----
+AD4- +AD4APg- From: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4-
+AD4- +AD4APg- Sent: Tuesday, November 4, 2025 12:06 AM
+AD4- +AD4APg- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4AOw-=
 dev+AEA-dpdk.org
+AD4- +AD4APg- Cc: pravin.m.bathija.dev+AEA-gmail.com
+AD4- +AD4APg- Subject: Re: +AFs-PATCH v3 4/5+AF0- vhost+AF8-user: support =
function defines for
+AD4- +AD4APg- back-end
+AD4- +AD4APg-
+AD4- +AD4APg-
+AD4- +AD4APg- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4APg-
+AD4- +AD4APg- On 11/4/2025 12:21 PM, Pravin M Bathija wrote:
+AD4- +AD4APgA+- Here we define support functions which are called from the=
 various
+AD4- +AD4APgA+- vhost-user back-end message functions like set memory tabl=
e, get
+AD4- +AD4APgA+- memory slots, add memory region, remove memory region.  Th=
ese are
+AD4- +AD4APgA+- essetially common functions to initialize memory, unmap a =
set of
+AD4- +AD4APgA+- memory regions, perform register copy and align memory add=
resses.
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija+AEA-de=
ll.com+AD4-
+AD4- +AD4APgA+- ---
+AD4- +AD4APgA+-  lib/vhost/vhost+AF8-user.c +AHw- 80
+AD4- +AD4APgA+- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+--------
+AD4- +AD4APgA+-  1 file changed, 68 insertions(+-), 12 deletions(-)
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost/vhost+=
AF8-user.c index
+AD4- +AD4APgA+- 168432e7d1..9a85f2fc92 100644
+AD4- +AD4APgA+- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4APgA+- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4APgA+- +AEAAQA- -228,7 +-228,17 +AEAAQA- async+AF8-dma+AF8-map(st=
ruct virtio+AF8-net +ACo-dev, bool
+AD4- +AD4APgA+- do+AF8-map)  +AH0-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-  static void
+AD4- +AD4APgA+- -free+AF8-mem+AF8-region(struct virtio+AF8-net +ACo-dev)
+AD4- +AD4APgA+- +-free+AF8-mem+AF8-region(struct rte+AF8-vhost+AF8-mem+AF8=
-region +ACo-reg) +AHs-
+AD4- +AD4APgA+- +-   if (reg +ACEAPQ- NULL +ACYAJg- reg-+AD4-host+AF8-user=
+AF8-addr) +AHs-
+AD4- +AD4APgA+- +-           munmap(reg-+AD4-mmap+AF8-addr, reg-+AD4-mmap+=
AF8-size)+ADs-
+AD4- +AD4APgA+- +-           close(reg-+AD4-fd)+ADs-
+AD4- +AD4APgA+- +-           memset(reg, 0, sizeof(struct rte+AF8-vhost+AF=
8-mem+AF8-region))+ADs-
+AD4- +AD4APgA+- +-   +AH0-
+AD4- +AD4APgA+- +-+AH0-
+AD4- +AD4APgA+- +-
+AD4- +AD4APgA+- +-static void
+AD4- +AD4APgA+- +-free+AF8-all+AF8-mem+AF8-regions(struct virtio+AF8-net +=
ACo-dev)
+AD4- +AD4APgA+-  +AHs-
+AD4- +AD4APgA+-     uint32+AF8-t i+ADs-
+AD4- +AD4APgA+-     struct rte+AF8-vhost+AF8-mem+AF8-region +ACo-reg+ADs- =
+AEAAQA- -239,12 +-249,10 +AEAAQA-
+AD4- +AD4APgA+- free+AF8-mem+AF8-region(struct virtio+AF8-net +ACo-dev)
+AD4- +AD4APgA+-     if (dev-+AD4-async+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-=
is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4APgA+-             async+AF8-dma+AF8-map(dev, false)+ADs-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- -   for (i +AD0- 0+ADs- i +ADw- dev-+AD4-mem-+AD4-nregions=
+ADs- i+-+-) +AHs-
+AD4- +AD4APgA+- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+=
AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4APgA+-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i=
+AF0AOw-
+AD4- +AD4APgA+- -           if (reg-+AD4-host+AF8-user+AF8-addr) +AHs-
+AD4- +AD4APgA+- -                   munmap(reg-+AD4-mmap+AF8-addr, reg-+AD=
4-mmap+AF8-size)+ADs-
+AD4- +AD4APgA+- -                   close(reg-+AD4-fd)+ADs-
+AD4- +AD4APgA+- -           +AH0-
+AD4- +AD4APgA+- +-           if (reg-+AD4-mmap+AF8-addr)
+AD4- +AD4APgA+- +-                   free+AF8-mem+AF8-region(reg)+ADs-
+AD4- +AD4APgA+-     +AH0-
+AD4- +AD4APgA+-  +AH0-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- +AEAAQA- -258,7 +-266,7 +AEAAQA- vhost+AF8-backend+AF8-cle=
anup(struct virtio+AF8-net +ACo-dev)
+AD4- +AD4APgA+-             vdpa+AF8-dev-+AD4-ops-+AD4-dev+AF8-cleanup(dev=
-+AD4-vid)+ADs-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-     if (dev-+AD4-mem) +AHs-
+AD4- +AD4APgA+- -           free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4APgA+- +-           free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4APgA+-             rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4APgA+-             dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4APgA+-     +AH0-
+AD4- +AD4APgA+- +AEAAQA- -707,7 +-715,7 +AEAAQA- numa+AF8-realloc(struct v=
irtio+AF8-net +ACoAKg-pdev, struct
+AD4- +AD4APg- vhost+AF8-virtqueue +ACoAKg-pvq)
+AD4- +AD4APgA+-     vhost+AF8-devices+AFs-dev-+AD4-vid+AF0- +AD0- dev+ADs-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-     mem+AF8-size +AD0- sizeof(struct rte+AF8-vhost+AF8-mem=
ory) +-
+AD4- +AD4APgA+- -           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-region=
) +ACo- dev-+AD4-mem-+AD4-nregions+ADs-
+AD4- +AD4APgA+- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-regio=
n) +ACo-
+AD4- +AD4APg- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4APgA+-     mem +AD0- rte+AF8-realloc+AF8-socket(dev-+AD4-mem, mem=
+AF8-size, 0, node)+ADs-
+AD4- +AD4APgA+-     if (+ACE-mem) +AHs-
+AD4- +AD4APgA+-             VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR,=
 +AEAAQA- -811,8 +-819,10 +AEAAQA-
+AD4- +AD4APgA+- hua+AF8-to+AF8-alignment(struct rte+AF8-vhost+AF8-memory
+AD4- +AD4APg- +ACo-mem, void +ACo-ptr)
+AD4- +AD4APgA+-     uint32+AF8-t i+ADs-
+AD4- +AD4APgA+-     uintptr+AF8-t hua +AD0- (uintptr+AF8-t)ptr+ADs-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- -   for (i +AD0- 0+ADs- i +ADw- mem-+AD4-nregions+ADs- i+-=
+-) +AHs-
+AD4- +AD4APgA+- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+=
AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4APgA+-             r +AD0- +ACY-mem-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4APgA+- +-           if (r-+AD4-host+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4APgA+- +-                   continue+ADs-
+AD4- +AD4APgA+-             if (hua +AD4APQ- r-+AD4-host+AF8-user+AF8-addr=
 +ACYAJg-
+AD4- +AD4APgA+-                     hua +ADw- r-+AD4-host+AF8-user+AF8-add=
r +- r-+AD4-size) +AHs-
+AD4- +AD4APgA+-                     return get+AF8-blk+AF8-size(r-+AD4-fd)=
+ADs- +AEAAQA- -1250,9 +-1260,13
+AD4- +AD4APgA+- +AEAAQA- vhost+AF8-user+AF8-postcopy+AF8-register(struct v=
irtio+AF8-net
+AD4- +AD4APg- +ACo-dev, int main+AF8-fd,
+AD4- +AD4APgA+-      +ACo- retrieve the region offset when handling userfa=
ults.
+AD4- +AD4APgA+-      +ACo-/
+AD4- +AD4APgA+-     memory +AD0- +ACY-ctx-+AD4-msg.payload.memory+ADs-
+AD4- +AD4APgA+- -   for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- =
i+-+-) +AHs-
+AD4- +AD4APgA+- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+=
AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4APg-
+AD4- +AD4APg- I think the using MAX+AF8-NREGIONS are most for convienent, =
but it will
+AD4- +AD4APg- impact the performance, because the rte+AF8-vhost+AF8-va+AF8=
-from+AF8-guest+AF8-pa()
+AD4- +AD4APg- should iter the entire array.
+AD4- +AD4APg-
+AD4- +AD4-
+AD4- +AD4- Replaced VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS with memory-+AD4=
-nregions.
+AD4- Please review v4.
+AD4- +AD4-
+AD4- +AD4APg- I think we should keep the original impl: make sure the nreg=
ions
+AD4- +AD4APg- entry of memory-region is always valid.
+AD4- +AD4APg-
+AD4- +AD4APg- Beside, where is the modification for rte+AF8-vhost+AF8-va+A=
F8-from+AF8-guest+AF8-pa()???
+AD4- +AD4-
+AD4- +AD4- Could you please provide more detail ? rte+AF8-vhost+AF8-va+AF8=
-from+AF8-guest+AF8-pa() was
+AD4- never called from here before.
+AD4-
+AD4- Because rte+AF8-vhost+AF8-va+AF8-from+AF8-guest+AF8-pa() use mem-nreg=
ions as for uplimit:
+AD4-       for (i +AD0- 0+ADs- i +ADw- mem-+AD4-nregions+ADs- i+-+-) +AHs-
+AD4-
+AD4- this function was never called, but I think we need to make each comm=
it
+AD4- complete.

From what I gather, both of your latest comments, for patches 4 and 5 are r=
elated to performance impact because of 128 memory regions. My thoughts on =
this are, I will work on an algorithm to optimize as you suggested.
Meanwhile we could approve patches 1-4. The rest of the implementation does=
 not need 128 memory regions. The existing 8 regions are fine. I put in thi=
s change as I felt it makes the system scale more and was also suggested by=
 Maxime. I think patches 1-4 stand by themselves and have been thoroughly t=
ested. They could be merged in unless you have some other recommendations o=
r changes you would like me to consider. Thoughts ?

+AD4-
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4APgA+- +-           int reg+AF8-msg+AF8-index +AD0- 0+ADs-
+AD4- +AD4APgA+-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i=
+AF0AOw-
+AD4- +AD4APgA+- -           memory-+AD4-regions+AFs-i+AF0-.userspace+AF8-a=
ddr +AD0- reg-+AD4-host+AF8-user+AF8-addr+ADs-
+AD4- +AD4APgA+- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- =
0)
+AD4- +AD4APgA+- +-                   continue+ADs-
+AD4- +AD4APgA+- +-           memory-+AD4-regions+AFs-reg+AF8-msg+AF8-index=
+AF0-.userspace+AF8-addr +AD0- reg-
+AD4- +AD4APgA+- host+AF8-user+AF8-addr+ADs-
+AD4- +AD4APgA+- +-           reg+AF8-msg+AF8-index+-+-+ADs-
+AD4- +AD4APgA+-     +AH0-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-     /+ACo- Send the addresses back to qemu +ACo-/ +AEAAQA-=
 -1279,8 +-1293,10 +AEAAQA-
+AD4- +AD4APgA+- vhost+AF8-user+AF8-postcopy+AF8-register(struct virtio+AF8=
-net +ACo-dev, int main+AF8-fd,
+AD4- +AD4APgA+-     +AH0-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+-     /+ACo- Now userfault register and we can use the memor=
y +ACo-/
+AD4- +AD4APgA+- -   for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nregions+ADs- =
i+-+-) +AHs-
+AD4- +AD4APgA+- +-   for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMORY+AF8-MAX+=
AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4APgA+-             reg +AD0- +ACY-dev-+AD4-mem-+AD4-regions+AFs-i=
+AF0AOw-
+AD4- +AD4APgA+- +-           if (reg-+AD4-host+AF8-user+AF8-addr +AD0APQ- =
0)
+AD4- +AD4APgA+- +-                   continue+ADs-
+AD4- +AD4APgA+-             if (vhost+AF8-user+AF8-postcopy+AF8-region+AF8=
-register(dev, reg) +ADw- 0)
+AD4- +AD4APgA+-                     return -1+ADs-
+AD4- +AD4APgA+-     +AH0-
+AD4- +AD4APgA+- +AEAAQA- -1385,6 +-1401,46 +AEAAQA- vhost+AF8-user+AF8-mma=
p+AF8-region(struct virtio+AF8-net
+AD4- +ACo-dev,
+AD4- +AD4APgA+-     return 0+ADs-
+AD4- +AD4APgA+-  +AH0-
+AD4- +AD4APgA+-
+AD4- +AD4APgA+- +-static int
+AD4- +AD4APgA+- +-vhost+AF8-user+AF8-initialize+AF8-memory(struct virtio+A=
F8-net +ACoAKg-pdev)
+AD4- +AD4APg-
+AD4- +AD4APg- This function should be part of 3/5, else the 3/5 will compi=
le fail
+AD4- +AD4-
+AD4- +AD4- I have moved support functions to patch-3. Please review v4.
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4APgA+- +-+AHs-
+AD4- +AD4APgA+- +-   struct virtio+AF8-net +ACo-dev +AD0- +ACo-pdev+ADs-
+AD4- +AD4APgA+- +-   int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-ANY+ADs-
+AD4- +AD4APgA+- +-
+AD4- +AD4APgA+- +-   /+ACo-
+AD4- +AD4APgA+- +-    +ACo- If VQ 0 has already been allocated, try to all=
ocate on the same
+AD4- +AD4APgA+- +-    +ACo- NUMA node. It can be reallocated later in numa=
+AF8-realloc().
+AD4- +AD4APgA+- +-    +ACo-/
+AD4- +AD4APgA+- +-   if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4APgA+- +-           numa+AF8-node +AD0- dev-+AD4-virtqueue+AFs-0+=
AF0--+AD4-numa+AF8-node+ADs-
+AD4- +AD4APgA+- +-
+AD4- +AD4APgA+- +-   dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs-
+AD4- +AD4APgA+- +-   if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +AHs-
+AD4- +AD4APgA+- +-           dev-+AD4-max+AF8-guest+AF8-pages +AD0- 8+ADs-
+AD4- +AD4APg-
+AD4- +AD4APg- It should be VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS
+AD4- +AD4-
+AD4- +AD4- Done. Please review v4.
+AD4- +AD4-
+AD4- +AD4APg-
+AD4- +AD4APgA+- +-           dev-+AD4-guest+AF8-pages +AD0- rte+AF8-zmallo=
c+AF8-socket(NULL,
+AD4- +AD4APgA+- +-                                   dev-+AD4-max+AF8-gues=
t+AF8-pages +ACo-
+AD4- +AD4APgA+- +-                                   sizeof(struct guest+A=
F8-page),
+AD4- +AD4APgA+- +-                                   RTE+AF8-CACHE+AF8-LIN=
E+AF8-SIZE,
+AD4- +AD4APgA+- +-                                   numa+AF8-node)+ADs-
+AD4- +AD4APgA+- +-           if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL) +=
AHs-
+AD4- +AD4APgA+- +-                   VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifn=
ame, ERR,
+AD4- +AD4APgA+- +-                           +ACI-failed to allocate memor=
y for dev-
+AD4- +AD4APgA+- guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4APgA+- +-                   return -1+ADs-
+AD4- +AD4APgA+- +-           +AH0-
+AD4- +AD4APgA+- +-   +AH0-
+AD4- +AD4APgA+- +-
+AD4- +AD4APgA+- +-   dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-socket(+ACI-vh=
ost-mem-table+ACI-, sizeof(struct
+AD4- +AD4APg- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4APgA+- +-           sizeof(struct rte+AF8-vhost+AF8-mem+AF8-regio=
n) +ACo-
+AD4- +AD4APg- VHOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS, 0, numa+AF8-node)+ADs=
-
+AD4- +AD4APgA+- +-   if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4APgA+- +-           VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, ERR=
, +ACI-failed to allocate
+AD4- +AD4APg- memory for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4APgA+- +-           rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4APgA+- +-           dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4APgA+- +-           return -1+ADs-
+AD4- +AD4APgA+- +-   +AH0-
+AD4- +AD4APgA+- +-
+AD4- +AD4APgA+- +-   return 0+ADs-
+AD4- +AD4APgA+- +-+AH0-
+AD4- +AD4APgA+- +-
+AD4- +AD4APgA+-  static int
+AD4- +AD4APgA+-  vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF=
8-net +ACoAKg-pdev,
+AD4- +AD4APgA+-                     struct vhu+AF8-msg+AF8-context +ACo-ct=
x,
+AD4- +AD4-
+AD4- +AD4-

