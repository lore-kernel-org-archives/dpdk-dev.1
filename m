Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE0C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C72294025D;
	Wed, 14 May 2025 09:04:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C664540041
 for <dev@dpdk.org>; Wed, 14 May 2025 09:04:57 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DNSpPl028326
 for <dev@dpdk.org>; Wed, 14 May 2025 00:04:56 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46mfssrpfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 14 May 2025 00:04:56 -0700 (PDT)
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54E71VxU022597
 for <dev@dpdk.org>; Wed, 14 May 2025 00:04:56 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46mfssrpfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 00:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPiONdVmKVOTqx65PArI4eB5iPSDjOrT22SG+4JASxcsDNZNYhYDLSIzhlnWVNXp5MF9Vxrs4CjxTC88K0NUkFvdmWAHlJ05FxGyOY1vLhu0ojmDspHwTl8tFudgVAKUPSp4na8tcnwoqGhyuc9eafnamduhJsIPrDqXKPmq5h80eBQqptf3rKgNdxx/NoLu2iMr5nci0qex7ggqZs/fLf/hnkJJl9nnLmTjvN0Q5YTU3kmOUVDcacltOuQpxYubMTmgFOH5SOru9ycZy2K1YC2Vdub20haeqinsIC9Xwgv2/xj3OQSREId6Pnj0Z7cX0+I2X+wAmwEuitn4+ii8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b35rWjnPLtUHQeO/D54+VuLYh/1dCS5Jobgf5wOkVy8=;
 b=ERR+dfMPaOAbJQ3molCU9mlL66cdNQZSX/CadX5TgNa1ZxE4rySgZTVjNCSi02TBhI1wmhZSZ6rkHTuJeNp0UwpEoprvH8GxEmeDix/iSOatqIKq0vEvwlw0TsZfISj6fsB/AJ87+AzVdIGAC9xyYddEhAstBNXnhcDBseZAI8qC7kU8kvQ0ehIKmKWgZsuXzJOPOWErhw7w0klNgO48bCNt4pkMfJHB+lIV7HRuLTbQzlC4COHpcfpNGYuxFvwuCQXASU/1wTkMxetoDgE/ddG/FLUzqWX8BtnTPLQ1HH4kg6VnUJ96ERAjYv5eYBeetJpXBQWg073yswTc/ErG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b35rWjnPLtUHQeO/D54+VuLYh/1dCS5Jobgf5wOkVy8=;
 b=AmwwRtPbqNKon4VttZ9m7GvUpuu0kWUVLUcQSjCIzYBVovw+0pp6+y+2fe4Glq/uuBAOGXEi6lgolHzbY56J0lz942u/n3xGxF9f4YX+3iat2wXds2JPhOlSBKEUFiKrIR5W1ImxSjE1vWYaovVXTweqRln3DPtX8uLIRA5ikUo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW5PR18MB5198.namprd18.prod.outlook.com (2603:10b6:303:1c9::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Wed, 14 May 2025 07:04:52 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:04:52 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 2/9] crypto/zsda: add device operations
Thread-Topic: [EXTERNAL] [PATCH v2 2/9] crypto/zsda: add device operations
Thread-Index: AQHbjBgl7x5rjLtxFU+lzzh1yj1KwbPSH9lg
Date: Wed, 14 May 2025 07:04:52 +0000
Message-ID: <CO6PR18MB4484239AB7056A290C290D2CD891A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303031644.1041177-2-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-3-li.hanxiao@zte.com.cn>
In-Reply-To: <20250303082751.1053432-3-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW5PR18MB5198:EE_
x-ms-office365-filtering-correlation-id: e3920ab8-654b-464f-fe05-08dd92b59faa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDlUQ1hReXNHeXRGUzNQUTE3dkxjS0RsMG1aeVJwamJoYXU1VG1YYTJxWHFQ?=
 =?utf-8?B?V2dZRTF0UnY4ZzNtTW1mczJtMjNvQXpyN2krZXZSYTdmMHpqWVJOdjN5TFRm?=
 =?utf-8?B?Y291eFFEYXBoRjMxb1RKKzVjS2xNK0xTcEd2bEFwd3BYUUlTM0svMHBuczhK?=
 =?utf-8?B?U1JQa2ZQVklSeG5ZcDNlSzhhYXMrWUc0US9mUlBRQVRReTFYVkVTV284SG02?=
 =?utf-8?B?ckY2MTBSMjJzUTZpd3kwbFBaelJ0RG5scTdXYlNSYUJWaWNZRVNMWGdHaXgv?=
 =?utf-8?B?LzROdmQ5a0JlYlJjYkhlMjRRRElOY1hacFV5RkVDOXZiendIdi9QNmhqUzho?=
 =?utf-8?B?M2VMcEg1WEVic1NUNG5kNDJhNjgwdXZLT2JpZGNtRzIzQ3JvTkQ3Y0NiUmlj?=
 =?utf-8?B?enZOR2RQd2V2L1R3dktTdVZkSjduTDJhNFFhL0NHYmE0SVVwT3BhS1lrWm5Y?=
 =?utf-8?B?OUJQOWRORERPUmFvYk5yM295Z2tyZm1tTWVtWElnRGxseXgrRFovSUJEd1Bl?=
 =?utf-8?B?YUdFWVdubjNKcWk2OThlQzc5aUJYQmdneU16YXljYnpvMys1eGs1MGpXVkZE?=
 =?utf-8?B?cDFtT0ZGUFBnWENwM00zd0lOOW5rSzR4OTE4T1dzelNTU1c5bnJBeXBVUU9k?=
 =?utf-8?B?TXdPT2NyVm9YMVJBM1laT3lXSStDSFc1d0V4ZFdvNDRhSFQrZE1HaXpmM1Uw?=
 =?utf-8?B?VDFUbVJxem43MFlYZVJJRU5ES1ZkblFWL3paZG01N3BZbkx2M0JJR2JFYUkx?=
 =?utf-8?B?VTA5dE82MmpyTW5mSi9MbzZPZFhFUUpDbzgvYmYzRnAxUzRUMTFFbjc1RmYv?=
 =?utf-8?B?R2FLOVVoWHdPWU9LR0hZejhWckxuM054RzZQWDZESTZ3YStUVDJhM1VDRkVD?=
 =?utf-8?B?TGo2S1Jwa0FxbjA1WE9lWmxxNWs5ZWF0WCtKdDhCTUhhY3oxMXpTQlJ3elYw?=
 =?utf-8?B?L3ZLUXl4dWhwN3lGZ1YzeGV3eWNIUGozUmc0ckJlSWNjazFEV1dpOHZiZE5N?=
 =?utf-8?B?VHRQNkxXY002emRYaU9CeFFMcWpwTStyZXppeElHcCtpOUoreHNRcWZZUFl6?=
 =?utf-8?B?QkFGbHd0UFZxOWhwR2gyQkFycThTaDNDcGk1eWJ1QXBTdXVhYVI4N0FyUUJK?=
 =?utf-8?B?SVdmRTh0NHd6b3BwVCtTaEM3TzRidXpzYmUwQlRReHRXWHUvWEprcHduOFJX?=
 =?utf-8?B?a0dROXdRM2JFOU1kMlZKN0F5SkFSQmh4Q0MxTWQ4dDJLTHZzNS9GVWk4NXhw?=
 =?utf-8?B?WjNHck9LU21uYXRUUlJVMHRHSUJmdHh6SkNoaVJWSkF4YzZ2WVZBT1B1MEh6?=
 =?utf-8?B?MkpabE9ubWdtZFRmNUlQSXYyeWRBbG1aeEZhQTFiZVBYNGNxTkk1OEVxbmZu?=
 =?utf-8?B?RUZJVWNhbGZtdVdoL2loemMrUHl1ZzAyZWdmRTE5TnBMSGdSUHJDSkxFNlNl?=
 =?utf-8?B?K1Y0KzVFOUFMMU1aczNmV0w5bHhKYW91bzBQSG9YbE9mREZEek9Sem5LT3Ey?=
 =?utf-8?B?QmJBSytzUG5BdEo4azVkaGpvN0NONER0Y0xRUGs5eS8xQXRQckQ0ODZKRXhQ?=
 =?utf-8?B?aDNrMit4S2Nsb1FVOHFobUZCcVdiNUZneXVERFBGbTBZbnV2ZjRLTVdjR2Vk?=
 =?utf-8?B?aVg4TUVxQ1BBdFpEZWExT3NiT1VObnQ0WVhXSnJDc1ZVZ1ZXSDM3QjBrU2No?=
 =?utf-8?B?bkk5c2JWZ1FtUStCRVgyVzUxb2VVUGRtMDVsNE1OTkwvRzZmWjZZN3puY2Ft?=
 =?utf-8?B?ZXlveklaV1VubVRwOENUcjE4RTAzS1BUMnd0NFZGQzZ3bVAvL0VBUDNieDRS?=
 =?utf-8?B?RW9RMlJnRHpHN3EwcDVuVkd3Z2hxU0I5N3NUQWlqcHF5Z1l3VVpJeCtUNSsr?=
 =?utf-8?B?L2lZZTJ2ZzFzcHlscTFUWm1JR1M3VXV5UVIyQUorR2xuSTVscU1mTlZyZGJO?=
 =?utf-8?B?ZDliSVExdnV3ZzEzUm9QTk5LRzJjUCtxR1JGYzJxRVBQWkdSTkVOazJ6WEY4?=
 =?utf-8?B?aGx1V3ZKNHJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmtHVTYwc1dmSjBmcDNSM2Y0TXFvaGRqWUNhVzJ2MEhxL3hYeVlRSHVKU1ha?=
 =?utf-8?B?T2d1L0F4NVpiYUZHQUNFRFFvQUhsaWpvVGZYR2ljUnJyZnpsdU5HaEY2V3ZN?=
 =?utf-8?B?ZXdvSERvcXRUQVIvSDVnYXRqMGJ1UEhUMWtKVjVEazJmelFDbHVYWTFqYVpr?=
 =?utf-8?B?c2xoZmYydTYrYkM4ZVF6aUh1RVhyNzV1em1wM1lnbDNxUXgrSE53V0ZLR3Qw?=
 =?utf-8?B?cTVpYi9ta0pJQzhBaFJ0Tk5oYlprQlFUc21xdnkrcjhIVEtuM1J2V2JPYkZy?=
 =?utf-8?B?cHVXWVVVSzhWTFJPM0F4Y01rQ1Vta2R4cXBMd3dRY3E0cWQ1c2l1UTcvbUhZ?=
 =?utf-8?B?WXlyTkt0Uk5iUFMzdUE2Z1Y3YWRUQi9tTTRNS3U2WlBOSXhVMk9scHA4aHJ2?=
 =?utf-8?B?L1N4bk1rRlhUSmtwZkw4azJHc3I0MWJVdzlYS3pLclVpaDdUZUkrVTVVSUNG?=
 =?utf-8?B?OFNBbFgveDdmV0lVNjJqZE9Qeis5ekdHZlNSSjY3YjRFTUdDeS9KYnZqQWdD?=
 =?utf-8?B?aVBzSjNNbGJLaGNlOHFDdjZUSVNWaDdwZytiSEFvaTVGanJWNG5UWkRxN002?=
 =?utf-8?B?c1hRSmJNYVRaZVAxbFdZajR1ZSsrWlhuKzVVTk52MVZiTmFLNkZlSmwza3Fy?=
 =?utf-8?B?SFBGam5TS1RKVittQWVRY2FSb1I2MktpZmNvVEZuaWZlblJzNDJsdU1JLy9C?=
 =?utf-8?B?ZExUWjM4WkJLQytESzVrUDg4dkpCem45QnE4ZzV3Zm5xbFhLNHA3QThTTGUr?=
 =?utf-8?B?QmxjTjJBbGxUOHFlT2hCSjFrOEtTYnQ3bC83L21ZVXZZNGZWeGlNcHV3TzZw?=
 =?utf-8?B?dXRPTWtjY2xXd3pJaVpoK1lUYjFZNG56UE5KWVFFc2VlRDlLc2MvcmpZbDRE?=
 =?utf-8?B?S1llTFlsZThMc3V0dE5sZHZ1K3N1cVFMNVNGa3JkVm0zczhReTY0b2kyZXdW?=
 =?utf-8?B?Rkc2UWZicStTTk9tK21aY09hUm5BdDloNS9DTHlxZUgwSGtmbUlYMmJ5WGt1?=
 =?utf-8?B?dWFUMS9iRi90RXpCZGhlSTBsc0tkcmp2Qk5lWndkL2JXYms5eDJ6UER2aUlm?=
 =?utf-8?B?R0dhdHBWM21sNXFRWEJkUGJHaGhNZ250ZFdtbnY1UitScTdZeVk2MzF5NlBL?=
 =?utf-8?B?L2VocG1rcDF3RFNXbkZ2c3FnYkdSTjh2K05MRG9UUDlqV2pyam9mTHQ0QlB6?=
 =?utf-8?B?eHhWeDZhandJVkJtMmRKLzVDWUFIOXRFOE1YTVk0VE1CcHdxdlc1SzZicjdl?=
 =?utf-8?B?anpma0xxVlQxZTRWb05Jbm5qWEhIdzhieDQzWFgzdkRHeGU4M3pGcytMQmpo?=
 =?utf-8?B?SzBPdXV6MGtCLzNOdjdyZkhmMjd3bHBlVnljNnoxaHd1VE84WWVYdG9Vd2w2?=
 =?utf-8?B?RHJyZTZJa3VyVEhHcXFDaS9zaG5oeWc2WklVMDkxZStsMmhQK3lrSm9wdE5V?=
 =?utf-8?B?UjlzVTA4OGNzakMrNW1mTkpNZTdlNitqbUk0eG5jditSZFRPK0VtQXZWVGYw?=
 =?utf-8?B?Q2ppMWVITVc4YXJGcGFzYkJzRnFELzVBVVd2OWthYnNUWFJlSitGbDhldTZ2?=
 =?utf-8?B?d2s3eHZxT2twbHhzU0RhdG5BVW5tUEtObGtBRS9pRnJIUW9YN0Q1M0NIclFM?=
 =?utf-8?B?ZVZIemlqY0owamFpQ0ZzblBNcTBMM0JiNTljcVZyQ3lNUEUzeXdnK2E3V1lB?=
 =?utf-8?B?RWRFTFpSZ1pkS2ltRkcycmYzSTJLME5zeG9mc3M2VjlLbHRUc2FuT1FJdGJZ?=
 =?utf-8?B?M3QxU3lZQ0NSeTJVWkdWZElLcWFkdVlTU3hVZTY2SERXWFp1TERwRXBHSWc2?=
 =?utf-8?B?UTl1OXRVdjNBenIzOS91QW5qRUwrTGtZQ0pvOVZBUVBuakNCNjluQURhVzFC?=
 =?utf-8?B?L28xa1lieHFjK3AxdU5QMkJGWWdETExVUVdJblhUQzlTT0ZGZDg0UDNYcHZt?=
 =?utf-8?B?US8wcGpYYVBGQ3dxczJxTTBmcHl6enZjZW84SVBWT2JTbElQNndOSkRpZzI1?=
 =?utf-8?B?NG5Nb3E4V2tHeGxvQStHTkVyZnh1RU5xZHdvMUZtcng5Q1FPcUVZd2tva1pG?=
 =?utf-8?B?cExRa2dSS0ZsMzVXbGFLYXkxaGZWNXVXMmVwRVhnM0ZrNWZLa2UxaUszNGpQ?=
 =?utf-8?Q?gvYJ//u1WriFMdvQq25jBe7HT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3920ab8-654b-464f-fe05-08dd92b59faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 07:04:52.1592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3o9GqfBj9OvJV0iMsbhZYc92aWdzYvc4a3Q0kX3D4HEgAcCvKS9hXC5mvrOpYsxsTznmyTOJwOb/6gm+/eRTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5198
X-Authority-Analysis: v=2.4 cv=OvpPyz/t c=1 sm=1 tr=0 ts=68244098 cx=c_pps
 a=YkRwJB1Lcas13D3J5+BQ6w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=1RTuLK3dAAAA:8 a=j3GPgviHdY0ZRe3CaVAA:9
 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: GQzXLc8AFi6nkY48w6c1gjAAduITAkLw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2MSBTYWx0ZWRfX33XOMB3WOzsF
 sEvGfGB8wafsCcDI9ucs7z9Fd9iypg6YXuQrcoFB31VErZu4EXyia7qnkIY+zvg/3uClrWG5LsC
 elYiGL/+3VoN/YIgXyTS9BOBYk1nnlAa0R/MJUJl+a5SPdywEO2u5jQ9rGZmssRvgWamaasULGm
 Zl2geLVS1ic1sc1JHI/arH3UVlGCFTlzemb5OrgipNg5OLI3yJ+btKkY1vGKH/K5CT2dh1QNyMJ
 HgXNtDHlEV/bGgKGVtnGpa+RHR8uMAtqmzjWgh09/8+uoJlDSWirp7G7h94kriGjCZEdLdBWuDb
 wsBXU/3ga08s7gxmwE7ttmIinsQpSLk9GXOtn90G1BdXEpe8+mNfxQvWANW95iXnXFZXP9McEQe
 19Ybs0ddpjWg9FwDUenB2X/hF46WlOwV6KcHwoo3FxtBPFAaQ8U62ei/H1XvxGplT2SwRz8p
X-Proofpoint-GUID: ylj6osuXH-ESAIDVZAzlBpg9LUbWC0An
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
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

PiBBZGQgY3J5cHRvIGRldmljZSBvcGVyYXRpb25zIGZvciB6c2RhIGRldmljZXMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBIYW54aWFvIExpIDxsaS5oYW54aWFvQHp0ZS5jb20uY24+DQo+IC0tLQ0K
PiAgZHJpdmVycy9jcnlwdG8venNkYS96c2RhX3N5bV9wbWQuYyB8IDk0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDg5IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8venNkYS96c2Rh
X3N5bV9wbWQuYw0KPiBiL2RyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1kLmMNCj4gaW5k
ZXggMGY0YmY0MTk1OC4uMjJjOGQ0ODJmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8v
enNkYS96c2RhX3N5bV9wbWQuYw0KPiArKysgYi9kcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3lt
X3BtZC5jDQo+IEBAIC04LDEzICs4LDk1IEBADQo+IA0KPiAgdWludDhfdCB6c2RhX3N5bV9kcml2
ZXJfaWQ7DQo+IA0KPiArc3RhdGljIGludA0KPiArenNkYV9zeW1fZGV2X2NvbmZpZyhfX3J0ZV91
bnVzZWQgc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldiwNCj4gKyAgICAgICAgICAgIF9fcnRlX3Vu
dXNlZCBzdHJ1Y3QgcnRlX2NyeXB0b2Rldl9jb25maWcgKmNvbmZpZykNCj4gK3sNCj4gKyAgICBy
ZXR1cm4gWlNEQV9TVUNDRVNTOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50DQo+ICt6c2RhX3N5
bV9kZXZfc3RhcnQoc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldikNCj4gK3sNCj4gKyAgICBzdHJ1
Y3QgenNkYV9zeW1fZGV2X3ByaXZhdGUgKnN5bV9kZXYgPSBkZXYtPmRhdGEtPmRldl9wcml2YXRl
Ow0KPiArICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICByZXQgPSB6c2RhX3F1ZXVlX3N0YXJ0KHN5
bV9kZXYtPnpzZGFfcGNpX2Rldi0+cGNpX2Rldik7DQo+ICsNCj4gKyAgICByZXR1cm4gcmV0Ow0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZA0KPiArenNkYV9zeW1fZGV2X3N0b3Aoc3RydWN0IHJ0
ZV9jcnlwdG9kZXYgKmRldikNCj4gK3sNCj4gKyAgICBzdHJ1Y3QgenNkYV9zeW1fZGV2X3ByaXZh
dGUgKnN5bV9kZXYgPSBkZXYtPmRhdGEtPmRldl9wcml2YXRlOw0KPiArDQo+ICsgICAgenNkYV9x
dWV1ZV9zdG9wKHN5bV9kZXYtPnpzZGFfcGNpX2Rldi0+cGNpX2Rldik7DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyBpbnQNCj4gK3pzZGFfc3ltX3FwX3JlbGVhc2Uoc3RydWN0IHJ0ZV9jcnlwdG9kZXYg
KmRldiwgdWludDE2X3QgcXVldWVfcGFpcl9pZCkNCj4gK3sNCj4gKyAgICByZXR1cm4genNkYV9x
dWV1ZV9wYWlyX3JlbGVhc2UoDQo+ICsgICAgICAgIChzdHJ1Y3QgenNkYV9xcCAqKikmKGRldi0+
ZGF0YS0+cXVldWVfcGFpcnNbcXVldWVfcGFpcl9pZF0pKTsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGludA0KPiArenNkYV9zeW1fZGV2X2Nsb3NlKHN0cnVjdCBydGVfY3J5cHRvZGV2ICpkZXYpDQo+
ICt7DQo+ICsgICAgaW50IHJldCA9IFpTREFfU1VDQ0VTUzsNCj4gKyAgICB1aW50MTZfdCBpOw0K
PiArDQo+ICsgICAgZm9yIChpID0gMDsgaSA8IGRldi0+ZGF0YS0+bmJfcXVldWVfcGFpcnM7IGkr
KykNCj4gKyAgICAgICAgcmV0IHw9IHpzZGFfc3ltX3FwX3JlbGVhc2UoZGV2LCBpKTsNCj4gKw0K
PiArICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB1aW50MTZfdA0KPiArenNk
YV9zeW1fbWF4X25iX3Fwcyh2b2lkKQ0KPiArew0KPiArICAgIHVpbnQxNl90IGVuY3J5cHQgPSB6
c2RhX25iX3Fwcy5lbmNyeXB0Ow0KPiArICAgIHVpbnQxNl90IGRlY3J5cHQgPSB6c2RhX25iX3Fw
cy5kZWNyeXB0Ow0KPiArICAgIHVpbnQxNl90IGhhc2ggPSB6c2RhX25iX3Fwcy5oYXNoOw0KPiAr
ICAgIHVpbnQxNl90IG1pbiA9IDA7DQo+ICsNCj4gKyAgICBpZiAoKGVuY3J5cHQgPT0gTUFYX1FQ
U19PTl9GVU5DVElPTikgfHwNCj4gKyAgICAgICAgKGRlY3J5cHQgPT0gTUFYX1FQU19PTl9GVU5D
VElPTikgfHwNCj4gKyAgICAgICAgKGhhc2ggPT0gTUFYX1FQU19PTl9GVU5DVElPTikpDQo+ICsg
ICAgICAgIG1pbiA9IE1BWF9RUFNfT05fRlVOQ1RJT047DQo+ICsgICAgZWxzZSB7DQo+ICsgICAg
ICAgIG1pbiA9IChlbmNyeXB0IDwgZGVjcnlwdCkgPyBlbmNyeXB0IDogZGVjcnlwdDsNCj4gKyAg
ICAgICAgbWluID0gKG1pbiA8IGhhc2gpID8gbWluIDogaGFzaDsNCj4gKyAgICB9DQo+ICsNCj4g
KyAgICBpZiAobWluID09IDApDQo+ICsgICAgICAgIHJldHVybiBNQVhfUVBTX09OX0ZVTkNUSU9O
Ow0KPiArICAgIHJldHVybiBtaW47DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkDQo+ICt6c2Rh
X3N5bV9kZXZfaW5mb19nZXQoc3RydWN0IHJ0ZV9jcnlwdG9kZXYgKmRldiwNCj4gKyAgICAgICAg
ICAgICAgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfaW5mbyAqaW5mbykNCj4gK3sNCj4gKyAgICBzdHJ1
Y3QgenNkYV9zeW1fZGV2X3ByaXZhdGUgKnN5bV9kZXZfcHJpdiA9IGRldi0+ZGF0YS0+ZGV2X3By
aXZhdGU7DQo+ICsNCj4gKyAgICBpZiAoaW5mbyAhPSBOVUxMKSB7DQo+ICsgICAgICAgIGluZm8t
Pm1heF9uYl9xdWV1ZV9wYWlycyA9IHpzZGFfc3ltX21heF9uYl9xcHMoKTsNCj4gKyAgICAgICAg
aW5mby0+ZmVhdHVyZV9mbGFncyA9IGRldi0+ZmVhdHVyZV9mbGFnczsNCj4gKyAgICAgICAgaW5m
by0+Y2FwYWJpbGl0aWVzID0gc3ltX2Rldl9wcml2LT56c2RhX2Rldl9jYXBhYmlsaXRpZXM7DQo+
ICsgICAgICAgIGluZm8tPmRyaXZlcl9pZCA9IHpzZGFfc3ltX2RyaXZlcl9pZDsNCj4gKyAgICAg
ICAgaW5mby0+c3ltLm1heF9uYl9zZXNzaW9ucyA9IDA7DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgc3RydWN0IHJ0ZV9jcnlwdG9kZXZfb3BzIGNyeXB0b196c2RhX29wcyA9IHsNCj4g
DQo+IC0gICAgLmRldl9jb25maWd1cmUgPSBOVUxMLA0KPiAtICAgIC5kZXZfc3RhcnQgPSBOVUxM
LA0KPiAtICAgIC5kZXZfc3RvcCA9IE5VTEwsDQo+IC0gICAgLmRldl9jbG9zZSA9IE5VTEwsDQo+
IC0gICAgLmRldl9pbmZvc19nZXQgPSBOVUxMLA0KPiArICAgIC5kZXZfY29uZmlndXJlID0genNk
YV9zeW1fZGV2X2NvbmZpZywNCj4gKyAgICAuZGV2X3N0YXJ0ID0genNkYV9zeW1fZGV2X3N0YXJ0
LA0KPiArICAgIC5kZXZfc3RvcCA9IHpzZGFfc3ltX2Rldl9zdG9wLA0KPiArICAgIC5kZXZfY2xv
c2UgPSB6c2RhX3N5bV9kZXZfY2xvc2UsDQo+ICsgICAgLmRldl9pbmZvc19nZXQgPSB6c2RhX3N5
bV9kZXZfaW5mb19nZXQsDQoNCkkgc2VlIHRoYXQgX3N5bV8gcHJlZml4IGlzIGFkZGVkIGZvciBh
bGwgdGhlIEFQSXMuDQpJbiB0aGUgZnV0dXJlLCB5b3UgbWF5IGFkZCBzdXBwb3J0IGZvciBhc3lt
LA0KYnV0IHRoZXNlIEFQSXMgYXJlIGxpa2VseSB0byBiZSBzYW1lLg0KTXkgc3VnZ2VzdGlvbiBp
cyB0byBkcm9wIHN5bSBmcm9tIHRoZSBmaWxlIG5hbWUgYXMgd2VsbCBhcyBBUElzLg0KDQpZb3Ug
bWF5IHVzZSB3b3JkIGNyeXB0byBmb3IgQVBJcyhsaWtlIGNyZWF0ZS9kZXN0cm95KSB1c2VkIGlu
IGNvbW1vbiANCnRvIGlkZW50aWZ5IGJldHdlZW4gY3J5cHRvIGFuZCBjb21wcmVzc2lvbiBBUElz
Lg0KRm9yIGFib3ZlIHN0YXRpYyBvcHMsIHRoZXJlIGlzIG5vIG5lZWQgZm9yIGFueSBwcmVmaXgu
DQo+IA0KPiAgICAgIC5zdGF0c19nZXQgPSBOVUxMLA0KPiAgICAgIC5zdGF0c19yZXNldCA9IE5V
TEwsDQo+IEBAIC0xMDQsNiArMTg2LDggQEAgenNkYV9zeW1fZGV2X2Rlc3Ryb3koc3RydWN0IHpz
ZGFfcGNpX2RldmljZQ0KPiAqenNkYV9wY2lfZGV2KQ0KPiAgICAgIGlmIChydGVfZWFsX3Byb2Nl
c3NfdHlwZSgpID09IFJURV9QUk9DX1BSSU1BUlkpDQo+ICAgICAgICAgIHJ0ZV9tZW16b25lX2Zy
ZWUoc3ltX2Rldl9wcml2LT5jYXBhX216KTsNCj4gDQo+ICsgICAgenNkYV9zeW1fZGV2X2Nsb3Nl
KHN5bV9kZXZfcHJpdi0+Y3J5cHRvZGV2KTsNCj4gKw0KDQpJIHRoaW5rIHRoaXMgd2FzIG1pc3Nl
ZCBpbiBwcmV2aW91cyBwYXRjaC4NClBsZWFzZSBtb3ZlIGl0IHRoZXJlLg0KDQo+ICAgICAgcnRl
X2NyeXB0b2Rldl9wbWRfZGVzdHJveShzeW1fZGV2X3ByaXYtPmNyeXB0b2Rldik7DQo+ICAgICAg
enNkYV9kZXZzW3pzZGFfcGNpX2Rldi0+enNkYV9kZXZfaWRdLnN5bV9ydGVfZGV2Lm5hbWUgPSBO
VUxMOw0KPiAgICAgIHpzZGFfcGNpX2Rldi0+c3ltX2Rldl9wcml2ID0gTlVMTDsNCj4gLS0NCj4g
Mi4yNy4wDQoNCg==
