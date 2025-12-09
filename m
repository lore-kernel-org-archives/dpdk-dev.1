Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEF5D1CDC6
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 09:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DDAF40270;
	Tue,  9 Dec 2025 10:06:32 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3B6C74025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 10:06:30 +0100 (CET)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B98UjTe016163;
 Tue, 9 Dec 2025 04:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=r
 8M2begp0BHXx3B6uaZ7z6XGD45QhetzXJR9z2LV0xM=; b=MttUOFuDdchVJhdFo
 6oN6TDM22lk2bYcliSUao+vHkzTEWTGZpfapLpzljSewUNI5uzKbh5QHAJ/Zm4ra
 MO7RlxHh1W7dgNkAZp3xkAHWrYc93Dds3XmLRE3Ktf3tAu5rIVpa7zLOS0caCd/n
 80MZHgTZ3K1pyl/niC4tCeAyfePP1yIESz0F557i+weM5joP/DDPxN48dT6PfH8y
 IHO8r9WuciqCnul09lg/pO5DKTs4oUKS82+ARpdMNyGDsieHlSnpyisOcT3lApm8
 a6UYsx0lR/HwKYiC+CjR34VLCpMBAYHMzr/qXi0oTA7joPYDD7Fu/JtsDO/Mh8Mq
 3X0pw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4avh775db1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Dec 2025 04:06:29 -0500 (EST)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B990RQG021022;
 Tue, 9 Dec 2025 04:06:28 -0500
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013038.outbound.protection.outlook.com
 [40.93.196.38])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4axgnhg53x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Dec 2025 04:06:28 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhM6HJaPS1hpjzwnFBXxpBsUmMrT0wxjX2aVtJ5xJQRkFmGm27PddEK/tr3Fn2lK54WaBBh5CrY6V4+I9C5BOYLHItCeHV9c72lJ1jGaPxPrnFmaoIkA6a/h38JDGaqObuxTN4bild6wF0J2JdGzPikc6YWoYU9qq+t6RPkxQ0mQD0QvgeSzkGXx3wMcT6YR63knXPJKjn/Gu27T5llDgLs6EJbs5U35LcdRVhdcTvKtmYCYPbE7jcr4W2xxp0bNZWmPRe9bjsSfl9UYWVElxXxkRtE4WqYQm0/TM0G6j1OVcNgQCxkjxm2xVP6VaOm57SwI2WERyKqypP3dCXtXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8M2begp0BHXx3B6uaZ7z6XGD45QhetzXJR9z2LV0xM=;
 b=noF7WJvaAfzZYK1Ub7xzLf1XXCQeMjJRlAnUQSrEDAbWKvGqssl6SGdUVLqAwGRsZoQ4IclaTO4ILxMlNbJs9ppyjZGICGyLKeyF6MANWYmLCvq8Kh23zTsMbLKnX7giRm7bcAZXsDRTjhMDjiRrryxLymrbJI7TqokAbznc8wnTVDGi8hPh7tIc9OPS2JctxUhxvo9XQaozdcOxxEfCthv1I73DvBwmT+2ptCWVsKlj+l+6pbiR1lfWOWGm1hiByY8TzlTObXRnrqeXpq0JkFhhUJoIrJK9n6GuqaKXzN3boyjg2PrJroSfnuJqfj2PTcoiNINJIncEaqyhtsBGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com (2603:10b6:a03:289::22)
 by DS7PR19MB6400.namprd19.prod.outlook.com (2603:10b6:8:93::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.14; Tue, 9 Dec 2025 09:06:25 +0000
Received: from SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e]) by SJ0PR19MB4606.namprd19.prod.outlook.com
 ([fe80::8938:6218:a89e:ba8e%3]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 09:06:25 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: fengchengwen <fengchengwen@huawei.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: |Smoke |FAILURE| pw(158765-158768) sid(36689)
 job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function defs
 for add/rem mem regions
Thread-Topic: |Smoke |FAILURE| pw(158765-158768) sid(36689)
 job(PER_PATCH_BUILD17274-20251113210704) [v5,4/4] vhost_user: Function defs
 for add/rem mem regions
Thread-Index: AQHcVMW3flDa9V4i3EeDFkBR+lHgGbUDDkBggBYeGfA=
Date: Tue, 9 Dec 2025 09:06:25 +0000
Message-ID: <SJ0PR19MB46061E7A91AEF354663CD827F5A3A@SJ0PR19MB4606.namprd19.prod.outlook.com>
References: <553996$6i5mrh@smtpauth.intel.com>
 <SJ0PR19MB4606FAC1A477B65FC4AF1CEBF5D1A@SJ0PR19MB4606.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB4606FAC1A477B65FC4AF1CEBF5D1A@SJ0PR19MB4606.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2025-11-25T07:19:54.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4606:EE_|DS7PR19MB6400:EE_
x-ms-office365-filtering-correlation-id: 47934c28-a166-44a7-e53b-08de37023aeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-7?B?cFljWFVsMEdkRzk5ZU9ud0hYVHJ1Ky14dUsxRG1qcXpyM2NkN0VSSlVQMVNY?=
 =?utf-7?B?V2pCYS9UTjNmdFViNjExMUFXSm8walFFcVR0dTVuSEd1R2lOdk9xMDlIT2JS?=
 =?utf-7?B?Y3R5U1JOSWIzZlNlQjlvUXVHN0RxYlpMQTNqUmZNZ0E0azM1OHZvQmRhdEhU?=
 =?utf-7?B?endGWjk5YW9ON0s2QkgzYlIvZzgzYnRMSWtXeEc2TDJ0a21UVnBwZVdieGxv?=
 =?utf-7?B?WlhYeFh2RndldnUyVWhRbnQzYmxsN293SnR6dm9xUkRMbkZ2TkhpbnRqZnA1?=
 =?utf-7?B?aDQ2bk4yYnpuL1c1STd1ZjlhRnpmcnlvQ2dmR1JTeXQwaXVjci96RnBTYnJl?=
 =?utf-7?B?b2V5NkJURWlHWWJUakhOZjZSUi9CeGU4MmRGQnlwV1dvb2RvTGY4N3E4dUNz?=
 =?utf-7?B?YW9YbmRiak4yUkY1QnVFWmtyelBEVi83anQweFFDZ2RJUDRBelM4SystNmc=?=
 =?utf-7?B?eistKy1OaUVKNWxRR2dNajFxcnR0RUl3VURxMWQxYmZLblBYTUpkY3l0WGE5?=
 =?utf-7?B?L1JzU3NvKy1Iem1VRVhpRThRTUNZbzNDdDVod3c5N2VQbWVqM2h4cnNuOHdK?=
 =?utf-7?B?UnhWUzFZQmVyZ1QxMTFKTHZBMFlPWlV1L0R2OW9iLzJIcWxYKy13aUtVM0dJ?=
 =?utf-7?B?dUNrZTBOcGlWMSstUDBDY09ReUN6T1h4d003OTRBODVIWG5WKy1lS0JCczhy?=
 =?utf-7?B?MVd5UlVhOGJJSlk3SUpYMksyMlo2Tm1OUzU4TmwrLTNUanhpdEdxbXZqNkd1?=
 =?utf-7?B?Y3d2NnM3WSstVWJmclgrLW4za2puZ2I3aXpxUzNrUHoxSnhwUG9udTd0VXdR?=
 =?utf-7?B?TnpUKy1WbDFpS3c2R1BaaDVyM1dNQU9yWWc1YTc5N0RmZ29Nbk1hRTdFSWtR?=
 =?utf-7?B?NkdMUXBiRHNZZTZYS0UzTTRPdnR3SWVwaistV3VIRjhKODNMclNDeEN4V2ZS?=
 =?utf-7?B?MXlzNENtV1BRL3F1a1NDVGhUKy1OQmRMUlpCSWRhY050MUJVbmk3R2cvTk5a?=
 =?utf-7?B?c0NjQnZsa1hlM0tvdzdOUC9tSzRZTk9UbFJka2ZZZ3YxdEx2ZGRjKy1aZ25B?=
 =?utf-7?B?Z090RlRPWWtya1o3T2pCc0tUUWdxaWNWU1g2TmlDQUZtMXJ0Y1VzMTJib3ox?=
 =?utf-7?B?Z0F0NFpsTG4wcVRHUkM1QUZRbVlKcHFxZG9DTW9XNGtCS3FiZGRDeGZmT2Ft?=
 =?utf-7?B?T0srLW9iWGpCVDB2M0pvMjZjUENCeVRDeHNGN2orLTgweTlHSmJpMXJxUXNk?=
 =?utf-7?B?NTloc3Nucnp0MVg2Ky1tTTh0Ky1HKy1xbkZMQUY4Ykt6SGV0ZWp6bzhJckp4?=
 =?utf-7?B?NllhZUQ4OGg0bDdtU3hHQnhRYWhFSDFFbzJiVkVLTHIzdjcyd2cvbDVSMTlq?=
 =?utf-7?B?MWhkU1l6Q1NaenUxdHVscTFvMGRBcmFjTWVYT3VzanRaVjNBTGc1bW5CWGpP?=
 =?utf-7?B?YTZucVdiT281TWZiYmJDSXU5RjRPOGtvazZRYjd1ZkY2OXVRUmZUeWpGSjRY?=
 =?utf-7?B?bnR4akZxekpmWThReU45ZHVtaUN1TWozLy9UUllkeER0Q0JEd2FJSDRUeEI5?=
 =?utf-7?B?aVc0VFVpekZLSUdBaE0yblZlYnhQanVwRUxHeXBSZDR0bi9BaUF0R3NMQzNJ?=
 =?utf-7?B?b2ZOQWt3RnNTZmwrLUZOY2JNSystTWJ4VUloNy9WM2FBdXYxbFduV3pxYlVz?=
 =?utf-7?B?RnZ5VUhoRU5pZW1MSUlVcUVyQnRsbVNCKy1CRFZxN0VlN0oyZGJldHVDRmlE?=
 =?utf-7?B?Z3FFTTRzdkpSeHUxbXhId0x4UVlKcy9wTkFKam11R3ZFYTRzUFM3OFdDeEE0?=
 =?utf-7?B?SEFEZ1N3SWpacGpQWTk0Q1VDcUFPSEFtZS83cFNLZ1BpeDNvUDJDb2J1S1lE?=
 =?utf-7?B?ZDlMZk94czg2ZUtOUU51YThYbUNpZWdROVVxRGtqVFlPYkJTeVlXZGVSVzdU?=
 =?utf-7?B?Uk95L3BHc2VYREhTMTFRZGFlZnAzSEFrdjRBaG5Rb29tVkkvTVJ0ZnRTQ3pY?=
 =?utf-7?B?dVU0a0NZMzMyZzlEQWQ3M0dQWnduaGdPRGlFaXBTaWVmOW1zSWdrT0RodUox?=
 =?utf-7?B?b3pVKy13cGZ4aHIwYjF5Rk4xZEluam9aT3RUb1RwdW9MTW9tdEtldmN0VTZW?=
 =?utf-7?B?U2VWSy82YmcrQUQwQVBRLQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4606.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?cnpkQ0Q3UDNXSjBhQjgyTGRualVjWkY0UGJNcjBhMistcG9UKy1iOFdVaXJH?=
 =?utf-7?B?alVzOTJqMTc0dk93QTFvQUU1MVgwQUhGZTVXMk1TeDloQU1QV1JsRm9Pc1h5?=
 =?utf-7?B?aTV1T2NQSG9KZGhickViWTltZHlPVTIrLXp3UEVlS3ZtN1hmajVqZnY1U202?=
 =?utf-7?B?NUhIb0s1ODFsTTdFN1R5QVNvazZCRWJ6MEN5QVFsdzFuQTNMWSstSFovbFBP?=
 =?utf-7?B?N01Zb0ZkY2lwSlJkaVhBQ2pSN3JLR1ZIR29aUjRQbWY0SnRtb3p0VVY1a2NZ?=
 =?utf-7?B?REkyRXVZZmdkQ3FUSkdySEhscmVnSE15ZC83NThSWkNkczJRWUhudFoxb1hZ?=
 =?utf-7?B?Tk9Ja3VBRVhteXc3aFlLekhxanUwWWJkNmw4VkpGcUhXeGRNV0dzcTUwZG9r?=
 =?utf-7?B?eFhES1JlUTZYdWF4NnlmcjZOTjZhTWJ3MjFPTG1tM2VZYVVWcXo4Rjk0OThS?=
 =?utf-7?B?VW9ZZ2tqTVZmQTBpUzVyQ0xLUkRMakRxM3h2TTZTclV2aXFVRE1pWlY0RkZN?=
 =?utf-7?B?enRyL3hNUTVpZ3Y4SGVPQ040dGUydistcVZ2U3NSMzRYdWgzckpWaTQvZkJq?=
 =?utf-7?B?RTQ4dUtBaktVaHdOaGc5Q1ZqbngvNUM1Rkw3YW9QU2pGZVFVSmV0aWVLR1pD?=
 =?utf-7?B?TWJnd2xKVzFyMFlZZmpBL3dzbUl1SHoyNUY0bEwwdURCQmt2anlWMzFZSlY1?=
 =?utf-7?B?MUdsY0hkdSstcCstMEF5d3pLMTl6dzdxd3d6bXlTQWk4Sk9FbUxoaWxUOFhC?=
 =?utf-7?B?SEl6QmhUdEtiOUk1SGZOUDVBTDR1a2JUS213eWFVV1BuZm13MVE5Szh5VlBw?=
 =?utf-7?B?NFNSM0xGam5ITHE2QSstOVQ0VlNMKy1lZjlJTXAzMnl0OXhIVTRLRXZmKy1a?=
 =?utf-7?B?bDhEdGFUdWdGS0Qwc2d4YkcwM1k0Zm5ZTElYenlRNjBUT2tXdlV2aUt3anBr?=
 =?utf-7?B?cUVuemhzVlFPRWxCSVdqN2lXaistVFhBRUVyc2hIQlhRVTNrVVdvdzhaS0F0?=
 =?utf-7?B?b21vajlVRWcyYjhiaFIrLVd3WTlYL3lFWlp1WlBabDEwdnJkb0RhYk9hODRT?=
 =?utf-7?B?YzVHcDJsSGV1WEQxQVZSVHp1bHZ5UUwrLTlGS3htSkdvQmxaWGQ1NkZPV1hu?=
 =?utf-7?B?TjdVaUhvVkgrLTB0ZDZnSTRiT0Vmc04rLWJVS2xlaU1LZ3pFc1hUWS9OWGxJ?=
 =?utf-7?B?S2lXOXF4TTNJWEEwUzBPU1ZTZzV5Qmx1eU1NbkNIRVJXWElBMk01S0RqcXg5?=
 =?utf-7?B?MDkzRGNBYistOCstZXVZallTcTZ1a01TUGt4U1NGTFV5aystVEx6aGgvRUFU?=
 =?utf-7?B?UXRvQWh1d0orLVBycEQ4R3BSdm8zTVg2RE1mZGxPMU1oZTFDUndzdFRJWjNt?=
 =?utf-7?B?VFNtd2dEUUNnSTBGOEM4QUExMHJMWkZaKy1PeVNiUlowN3hzTzBUYUxKQk9k?=
 =?utf-7?B?SmpmWSstNEFTcjlPeUlmNHlOTy80VistVDhyQU00eXBxZ1NUYy82OGVTYk1J?=
 =?utf-7?B?eUxhbUo5SDlRYnJEeHYxanV4NisteUpscnpCNzM4YnFJTVhXeEFGZThSOFhP?=
 =?utf-7?B?Q05hV2lwNFVtaHNCWHF5RFdHRVU0b2VxQ2VMVDJ2eENSem1JMlhFc2hsY3p3?=
 =?utf-7?B?RUtUTjlud3k2WjhZZzd1bUJBOTRPajJvOU9ubXhZYW5VdUtXUExKajZKckpE?=
 =?utf-7?B?Z0tMdVp2WEdSMkN5NGhYOHErLXBQVEJPVkc4Ky1ENE5PU3dSSS9VcW44bjc0?=
 =?utf-7?B?Y2tnSzFhV0dBYXgrLTVILzhBWW1mdk52UXF1dlpaNHAxc1NLZnRvOHJaV0dZ?=
 =?utf-7?B?eGZjb2NnRzFmQ1M5VTBBcFpIby9IYjVJa0dHYUlWWUhpTjhBZVBpRjlaWFd0?=
 =?utf-7?B?bUd0dU13Q1dTWHJkZHRzMGJuRnNZVmJGL1kybWMvTldOdElMRmZhOGkwTlBm?=
 =?utf-7?B?RlJIa29DOGtQSUlNL1BteUg4RG5CZFNNRnN6MG1GcXBuM2thWmhaaGhQNVBH?=
 =?utf-7?B?TTFYY0VSYVh4OGt4QjJWd1NOZ1pVbW5pU2JRQlh3Wk1pRjNJZWw3aDRmYXhR?=
 =?utf-7?B?N0xTWWFlbVViZG14eXJsbnR1WjBEYWtTOWdEKy1HKy1LRlZXbXg5WUl4blYw?=
 =?utf-7?B?OXFkSGVFM0YvV1hUN09LWDBGdks0VTI0VEtBZEx3cVlIcVVqZTVwc2VQMWdZ?=
 =?utf-7?B?MG5GSG1iUjE=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4606.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47934c28-a166-44a7-e53b-08de37023aeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 09:06:25.0852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCNNQYvd/3Y8LHjqJdHd1uQZ1CxiiajKXh14gdj6CEiBkUKuUCI5Z0eZfbcwgw0Uea3CQqiJvZkRk8dKq1dweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512090062
X-Proofpoint-GUID: NQX0sKMwcvsopCfyuVzyWJXBp2RewtUn
X-Authority-Analysis: v=2.4 cv=H53WAuYi c=1 sm=1 tr=0 ts=6937e695 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=bWxv08ZMR_wA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=uherdBYGAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=iLNU1ar6AAAA:8 a=ytFMdNZ7AAAA:8 a=XlRjxQ70AAAA:8
 a=eSb-bNSJAAAA:8 a=XFJw1KJJAAAA:8 a=LfxEVeEBAAAA:8 a=gx6ovfFWC_3hjobV9VMA:9
 a=avxi3fN6y70A:10 a=aV_cevuMhtcA:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=oxySFUAvEW1-6AXleBSr:22 a=1uMOUU2w0DxzEe95gQqD:22
 a=h7YW-pclpbZRD8svLbQ0:22 a=DKZDSSD9H29Cdu8kcpdD:22 a=7k9nRlTqVbDGZ3p5_T00:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDA2OSBTYWx0ZWRfXwBdEyOffYIF/
 IRjPuCycEWtJdtP+InHiSYDlpnCmXKY9Gg3fNS43UlBPL8tUL06GPHjm69EgXcKCsSZCrcR5rDO
 +v3EacgNp2BuR2N4/aF5gWrAxEEuCHXS2mPAZYptyfTcgaAQYNQt9E4L0rYhiGLyqYz16ooKqOg
 VMIMS+OH82OUPwi5rb0kPwR484mCBRabRoWS422k7rQnhv60rirmJs19He8YSZ5hwfBXLYTh2rZ
 R0vu9L7Dj3sSm+n9vUy/PLN4hs3V5uyzNmF8tbYbEc3tonPzW+guWZMghAvRgSdeK4fHuTz3bRt
 +82lPeTiyCHHtlg77l0LuxEez3RO6YsfizEAsPrAe8kRJt4C7Aj1sPQ5jZHjws/tHLjKNGNSYk7
 EjtFfYIIA05Gpki9NPDfQaD4nxk+GQ==
X-Proofpoint-ORIG-GUID: NQX0sKMwcvsopCfyuVzyWJXBp2RewtUn
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060069
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

Dear Fencheng, Maxime,

Gentle reminder to check-in when my changes will be merged ?

Thanks,
Pravin


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Bathija, Pravin
+AD4- Sent: Monday, November 24, 2025 11:24 PM
+AD4- To: fengchengwen +ADw-fengchengwen+AEA-huawei.com+AD4AOw- Maxime Coqu=
elin
+AD4- +ADw-maxime.coquelin+AEA-redhat.com+AD4AOw- dev+AEA-dpdk.org
+AD4- Subject: FW: +AHw-Smoke +AHw-FAILURE+AHw- pw(158765-158768) sid(36689=
)
+AD4- job(PER+AF8-PATCH+AF8-BUILD17274-20251113210704) +AFs-v5,4/4+AF0- vho=
st+AF8-user: Function
+AD4- defs for add/rem mem regions
+AD4-
+AD4- Dear Fengcheng, Maxime,
+AD4-
+AD4- When I look at the test results below, I see that one of the tests
+AD4- +ACI-test+AF8-checksum+AF8-offload+AF8-with+AF8-vlan+ACI- failed. How=
ever, when I navigate to the
+AD4- actual test results page - that same test shows passed. Could you ple=
ase share
+AD4- your thoughts on this ?
+AD4-
+AD4- https://mails.dpdk.org/archives/test-report/2025-November/931175.html
+AD4-
+AD4- Also, any thoughts on when my code will be merged to mainline ?
+AD4-
+AD4- Regards,
+AD4- Pravin
+AD4-
+AD4-
+AD4- -----Original Message-----
+AD4- From: sys+AF8-stv+AEA-intel.com +ADw-sys+AF8-stv+AEA-intel.com+AD4-
+AD4- Sent: Thursday, November 13, 2025 9:48 AM
+AD4- To: test-report+AEA-dpdk.org+ADs- Bathija, Pravin +ADw-Pravin.Bathija=
+AEA-dell.com+AD4-
+AD4- Cc: daxuex.gao+AEA-intel.com
+AD4- Subject: +AHw-Smoke +AHw-FAILURE+AHw- pw(158765-158768) sid(36689)
+AD4- job(PER+AF8-PATCH+AF8-BUILD17274-20251113210704) +AFs-v5,4/4+AF0- vho=
st+AF8-user: Function
+AD4- defs for add/rem mem regions
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4-
+AD4- Test-Label: intel-Functional
+AD4- Test-Status: FAILURE
+AD4- https://urldefense.com/v3/+AF8AXw-http://dpdk.org/patch/158768+AF8AXw=
A7ACEAIQ-LpKI+ACE-jCHbWx
+AD4- KxAWgIg6OQEvPP3-yCEWdKOlDUFrlDl-
+AD4- Njivh4rgNkJqRj9YFVVY9hRHocrV4lnvkjjvMMC85WVA+ACQ- +AFs-dpdk+AFs-.+AF0=
-org+AF0-
+AD4-
+AD4- +AF8-Functional issues+AF8-
+AD4-
+AD4- Submitter: Pravin M Bathija +ADw-pravin.bathija+AEA-dell.com+AD4-
+AD4- Date: 2025-11-13 12:44:22
+AD4- Branch : dpdk-next-virtio
+AD4- CommitID: 6b37c26a95
+AD4-
+AD4- Smoke-Testing Summary : 31 Case Done, 30 Successful, 1 Failures
+AD4-
+AD4-
+AD4- OS : Ubuntu 24.04.3 LTS
+AD4- Kernel : 6.8.0-71-generic
+AD4- GCC : 13.3.0-6ubuntu2+AH4-24.04
+AD4- NIC : Ethernet Controller XL710 for 40GbE QSFP+-
+AD4- Target : x86+AF8-64-native-linuxapp-gcc
+AD4-
+AD4-       Test result details:
+AD4-       +------------------+-------------------------------------------=
---------+--------+-
+AD4-       +AHw- suite           +AHw- case                               =
               +AHw- status+AHw-
+AD4-       +------------------+-------------------------------------------=
---------+--------+-
+AD4-       +AHw- checksum+AF8-offload+AHw-
+AD4- test+AF8-do+AF8-not+AF8-insert+AF8-checksum+AF8-on+AF8-the+AF8-transm=
it+AF8-packet+AHw- passed+AHw-
+AD4-       +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+=
AF8-check+AF8-ip+AF8-rx                +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+=
AF8-check+AF8-ip+AF8-tx                +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+=
AF8-check+AF8-l4+AF8-rx                +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- checksum+AF8-offload+AHw- test+AF8-insert+AF8-checksum+AF=
8-on+AF8-the+AF8-transmit+AF8-packet
+AD4- +AHw- passed+AHw-
+AD4-       +AHw- checksum+AF8-offload+AHw- test+AF8-rx+AF8-checksum+AF8-va=
lid+AF8-flags                      +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- checksum+AF8-offload+AHw- test+AF8-checksum+AF8-offload+A=
F8-with+AF8-vlan                   +AHw-
+AD4- FAILED+AHw-
+AD4-       +AHw- checksum+AF8-offload+AHw- test+AF8-hardware+AF8-checksum+=
AF8-check+AF8-l4+AF8-tx                +AHw-
+AD4- n/a   +AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-dual+AF8-vlan+AF8-prio=
rity+AF8-rxtx                      +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-filter+AF8-co=
nfig                           +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-filter+AF8-ta=
ble                            +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-insert+AF8-co=
nfig                           +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-random+AF8-te=
st                             +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-strip+AF8-con=
fig                            +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-synthetic+AF8=
-test                          +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-tpid+AF8-conf=
ig                             +AHw- passed+AHw-
+AD4-       +AHw- dual+AF8-vlan       +AHw- test+AF8-vlan+AF8-stripq+AF8-co=
nfig                           +AHw- n/a   +AHw-
+AD4-       +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-bigger+AF8=
-jumbo                     +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-jumbo+AF8-=
jumbo                      +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-jumbo+AF8-=
nojumbo                    +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-normal+AF8=
-jumbo                     +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- jumboframes     +AHw- test+AF8-jumboframes+AF8-normal+AF8=
-nojumbo                   +AHw-
+AD4- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-port+AF8=
-all                           +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-port+AF8=
-cmdline                       +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port    =
                           +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8=
-all                           +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8=
-checksum                      +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8=
-cmdline                       +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-port+AF8=
-multi+AF8-segs                    +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-txoffload+AF8-queue   =
                           +AHw- passed+AHw-
+AD4-       +AHw- rxtx+AF8-offload    +AHw- test+AF8-rxoffload+AF8-queue   =
                           +AHw- n/a   +AHw-
+AD4-       +------------------+-------------------------------------------=
---------+--------+-
+AD4-
+AD4-
+AD4- DPDK STV team
