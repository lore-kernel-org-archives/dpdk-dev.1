Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF3DC3ABDA
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:55:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A64884025D;
	Wed, 14 May 2025 09:55:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2D74240041
 for <dev@dpdk.org>; Wed, 14 May 2025 09:55:40 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E7tADF015210
 for <dev@dpdk.org>; Wed, 14 May 2025 00:55:39 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mq72g01e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 14 May 2025 00:55:39 -0700 (PDT)
Received: from m0431383.ppops.net (m0431383.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54E7tcXi016500
 for <dev@dpdk.org>; Wed, 14 May 2025 00:55:38 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46mq72g01d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 00:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtQSFtR+A09L2j6Zttyio/u7DNdUdtu/kZPqi1CzO8J864/F32lbDqCxm3JV4mrrAp6QgBmIWMD5mBkI2zXTl+rAYBhoPJC7+SYFk+lAikBw64iOoPn5WY4+Ob1Oali5SRYJZSg7qhyFWnWGvy0bpSu9x/0gjjphwc9cV+86pRNIGte5dDDwLQwrhI7HOlG9Jleb3UwftcA0FG69GZ+06YUz4zuLFY6KRZc6PZMtLCuGw5L8qQppgXW/mxOmr6WENy+AAl3KOTXyTAOuMiQT9N/QtJwtcAwWkmkJUXzIXCkhaMAapyS2qsh+zBmEAD2SlOrW869IMKmE0LqywQwsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B+VhpHT9gfg/GHVCqHq9jPecxolIzwQyLuX3eyMbH8=;
 b=hwmIZucpB7eOC+0Ylgf5u3sickSg1a/SzI9MmEmIw3RzbTbHgXnWlbh+hPnlsu4+idqHvQI5oUfQuRkrOuN5x+iyjkfiYoTaEl7czAqC7EWwj1va0al3DWA6Ea4yBrS4ihIjZz30tpPyHTJznhgTS9Z+d2guDNd3xHZ1LPAKEbuqeEUkI/84ImTo0W4w3zzf+qHqpUxhDpoi+B7kuNfB//5WU9F47gsdK6tlL9BL0w6YoneNNEwxKAX4n7dPtUA0FEnWfCnOVscAhjVVibojRsTu5YJkSib53jopLi0PCN3dODGOExQ+XIn4ApyGAh+Ceo+fZTqUKmP/XubBg2qE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B+VhpHT9gfg/GHVCqHq9jPecxolIzwQyLuX3eyMbH8=;
 b=oLr6iFePKiWaxaJLXLg+da6maWwyAFPrjGCRYxMFCaVbRWrAVIbuGOpI7oGjLNtgC+iKf7SjOk2nnrjblNZOyymuBpCSHephhrJ1uXw+vNVLyoGqbt3jA5hEEIm8chhig/9HI7iJiQodQl/sA82ICn13JkU6SEA9+HwxGXYmq1w=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3563.namprd18.prod.outlook.com (2603:10b6:303:5f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Wed, 14 May 2025 07:55:36 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:55:36 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 9/9] app/test: add zsda cryptodev test
Thread-Topic: [EXTERNAL] [PATCH v2 9/9] app/test: add zsda cryptodev test
Thread-Index: AQHbjBhK9Fop9nTcnkaLVJtLHXJHOLPSMsFA
Date: Wed, 14 May 2025 07:55:36 +0000
Message-ID: <CO6PR18MB44848BAEA9BAE01D749F406ED891A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303031644.1041177-2-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-10-li.hanxiao@zte.com.cn>
In-Reply-To: <20250303082751.1053432-10-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3563:EE_
x-ms-office365-filtering-correlation-id: 90fd2511-30a4-4121-c4be-08dd92bcb617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGN2clRmczYxeVN2d3ljeDQvWlJ5eHBNL2VPZGR3MXFCWEVTak05c2toV3lq?=
 =?utf-8?B?d3J4MXZPUDNJRjVEUk1LVjV3TXFydHN5Tlk0L0FZaGdLUzR3TlZyRDA4cTB2?=
 =?utf-8?B?ZFo0WXJDTHBHd1hGT0F6Tkg5ZWxiejVTWVlZSCtBK2srcHdxWGgzZi96K09s?=
 =?utf-8?B?eU1wazF5UjNPTklpU1VROXhicE16QWFHOVphL0M3Z2hrS3pmR1pTdUJsL2Rr?=
 =?utf-8?B?L2hqU01HSWYxTExKZTdwZWFKb243a0NtNVg1VlhVWmJyVWw3TENNREVIbkw2?=
 =?utf-8?B?eks3TmN3bk9ZR2xFVXdPMlVUaHVIbkRQMDBRUGNmcERXbEE0cGNpYWNkM0g2?=
 =?utf-8?B?RDlSRmZBTTdiUGdwMVd4K1RBRVUrd0NjV1dyaE5pUkxqR2Q5VFdFV0h0VmtN?=
 =?utf-8?B?TEg5S3ZONVdnbWNnaW5EdVR5WHFldVZrd0dYSWhRUmRNdnloYW9FRGpjdGtD?=
 =?utf-8?B?a29uT3JQWXdYdDdwY2tWMjRDaDdOeFF3c3p6OTFESXNjZGVwSDFKdU1lUGtr?=
 =?utf-8?B?TWpGZHloM2ZFS1B1Kzgya3U1czk3TXAxWm1SOFd0dU01cGNqT21rK1l3ODBy?=
 =?utf-8?B?SjlXbUYzZlZEcEJ3MUkxZStLbjhsY290NllEc2R1VFA5SFhKY1lObGptd1lp?=
 =?utf-8?B?K3VjVlAyak5PN1V2b0R1VXhDKzNmT0p0MTJTWFpPemJRbndDazhGeTdnSzFs?=
 =?utf-8?B?SC9oeWtBS1FNd2RXSG1pZEZSQXpTc0dnc0syZUlEVXZFdjd1UENKcUlrOVJM?=
 =?utf-8?B?K3ZXdU55M1hIOEZ5TGF5RTZMWnNUZHFqb3ZaalRBeWF6clhNTXliVEhVRng5?=
 =?utf-8?B?WnRuY2Y1RWJIQWh5YjJoZWhHVHRBRTRmMUpydHVaczc1VDZqSzRyZnJkdVov?=
 =?utf-8?B?QkNqNndMbElIOW1jeUNzVnRkQm1GSE9qK3k1M2VSWUYvbXE5dkhmemlwazNB?=
 =?utf-8?B?bkxLaENGM01UYW5vei9XWHZtN2NBOTJUUlRWZ25Kb1Z2VmUrc0JuZGZDYTdo?=
 =?utf-8?B?NDl1a3FETE1oeWI0L0g5RW5zV2xjWFljSCtkRWQ3UFNvVHRTQTV2RCt6VUs2?=
 =?utf-8?B?cVd3d0pRdWRHNEI2REJjN3hsWVppOFA3bThXblgyY1hha0lHcnJSUW1JTVB6?=
 =?utf-8?B?VWwvZnhsSzRMbWNjVjBRVFUzYzcxTmlLV1phL3JDUDd2YllZVk42Q1ZxZnYx?=
 =?utf-8?B?RHE0a2laRnRSdmxiRXdIemxjU2c1REdkblFlS3cxamZhTm4zZlFtYTVIZWlG?=
 =?utf-8?B?aEFmWlk1VjlRWWl5dUtGMStzZE1lNisxMWlZOXFxNGZiallqNkh0RUJtbmlk?=
 =?utf-8?B?Ry94NUMxVnQrcjg4Z2x3MUdSL2RFdkJsLzZyaERuL0trMXc5N0dzWVRTRDVR?=
 =?utf-8?B?bURDT3VJbEZTUW5QanNtOU5nK0JlRkF6Si9hS0FxMFh1THJTWStlaUpKR0lw?=
 =?utf-8?B?TjNPUE9XUEhGcElTd0VucWtQcEhFS3RZV045TktOTjV1QW1aazBjM0kyc3dH?=
 =?utf-8?B?UUpHMlVlZVlDaHpFUnYzWTBWL0FURFhhZkVTMVgwclhlVWVzbmFFcEZMdzdN?=
 =?utf-8?B?MkpFcWRaRVVGVHFoci8yaHBaSjZNY1VySGRJZHdsdWV3a0hoQlA3eTZsZm5k?=
 =?utf-8?B?MER3SEJkN2ZuTU5Rd3JhS1RDTkNuNGU1cXBGaXIwVFJqQzdOelNIU25wZVAy?=
 =?utf-8?B?UDNLQ3B5OHlqTjR4Qnh5MEt2L2E1byt5KytVY3Z0b3RWaVU4YkZ3MXdOUHlB?=
 =?utf-8?B?TU9hV005ZGNNbkhtcXpOamxEa01rWE5sb21rdFBhelVSN3RCV3FadDRUUDdC?=
 =?utf-8?B?bGhSTS9GUHFPdnIyRGZOTU9nS3lSNEJGVjJnTEY3eUNnTEJ6aXVVOGVyNXBF?=
 =?utf-8?B?eTg3SS93WU5JSmtPQTZpWGN6bW5GUlZ1SHdFdzl1ZlNBSnNCd1F4VmpjS0lM?=
 =?utf-8?B?d1BnY29VQlFZaUhjcUIvZ2syR2FRR0RYcVovREkwamYxSjNCYll0WXVxL29U?=
 =?utf-8?B?RWJ5R01XTGt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmFReUUrb2ZQSlgrVW9iVTB3dms1Y1FvSDJjZWJYbjh6Zmsra0FuZGU4VDdu?=
 =?utf-8?B?YVBDZEJ1NDJzTDFkb2NFYjN5YkhTc2NyQVFwZE1ueWJJMVErK0tsWkM2V2RQ?=
 =?utf-8?B?ci9oV3E3UHRjS3hVQ3VSMHJhRDYwbU93bW0zdFlycWd2U3NRVmc1TzRkUW41?=
 =?utf-8?B?TG5ld2hyZXcvcm11QTMvWFhGYzJsUVFhRVRwRlQ3S1pKRkQwOHM5UmR2bUV5?=
 =?utf-8?B?UjVEY2ZwNVRsb2dKRXdPQ3lleEk0dnYvMkpCMFpzWnRpalhjbGxCZWhkWFVY?=
 =?utf-8?B?RjhhZWVoYzFGOVM0VThEODFjaEVKTWxOcjdMZW1sY0tCK3ZrOSsydjA5VVdS?=
 =?utf-8?B?aGtNdk9lRkx1bnIzcjZlM2dWb2pIckVia0RSenNtNitqTURSak1pQVVoUGU0?=
 =?utf-8?B?OVhLTXR3SUY3TVRHdWQxVy9GZ3pVQ3VmYklGREtLL2UyZHJIWmhuU3hBVlFL?=
 =?utf-8?B?T2NTajFNRGFmcys1VWQ3WXpSbUQrdm5jRldJNUhtcmFPQjR6Wm93WlBwdG5S?=
 =?utf-8?B?ZVptZHZOWFo1TEhNSzdiZW1vTlgxRWlTbUpQVTJmVkFhV2JqV2xGellnS1Jl?=
 =?utf-8?B?YVAyQ1NGZUxqUXJNa1ZrNUUzVTN5SlBPODVkS2xHK1pqY1hoOGhwdUoyeUN2?=
 =?utf-8?B?VHA1cGpWQ1VYNFArRVRaMVRqZENKVFlwREdTcUlvU2JXZkRCcTlMWmE1UW9q?=
 =?utf-8?B?ajlzOGVieEhGSkZHNU1QMndsTEtjZzZ2UmcxdHVNdjhRWEw2bi9xOE53MU8z?=
 =?utf-8?B?czcyVFplWHl4WG1aS1JPSCtTT2JLNkJiVjFQekF6Y1lidFVvazlXbEJWWlh6?=
 =?utf-8?B?RVhkWnBDVkZQQlhsRkUzMUVOdmRPK2JjSWdVbzErTjBxclRoaUxkQ09pMGpl?=
 =?utf-8?B?OUZkSkRpdXBBK2xDd29WZ1p5VVZ4MDBpNE5PN0VsUHFJUDl4Qkk0VUlYWmxv?=
 =?utf-8?B?YmJ6bE04Y2NwSTBqallZb0ZldnppYVQxa2VhSFUyaVBmWkJqMXMxUDdZd1Fm?=
 =?utf-8?B?WTQ4QUNjVmE0Vmlub1pIeWtTK0ZQVGZ3NlhYMGJKTHl4RHM0Kyt4MGt4dDFM?=
 =?utf-8?B?SWlUcG1FOEJ1cXFsaXcrYnZGck03OUdVcG9wRXJlQTJqaXZqVENTeFI2bUJT?=
 =?utf-8?B?R2ZpTXRta0loWGMxbjV0RnlHRmxweVRZWXBxR0hKaFcxRkQyY2xrQ1RkVkZv?=
 =?utf-8?B?dk84NTVEVTZScTdsNmdobjIvNXZDazBRR0E2dmV2akJSTWRvNXdQa2wwaEMz?=
 =?utf-8?B?M0lhelBwdzlWR3FSRWVkbmloQkc1WHRqY0thcU1JL2o1eGNPT0wvUysrQmNr?=
 =?utf-8?B?U3M4N3pSUnBiVWFqTFZub1lBdGIyVzRPbUhCd0tXYXcxeitQS3M0OG56U2hC?=
 =?utf-8?B?RXI4STc5b0tGYlM2QyswNWRxNks1Y1Rrb2NHMVRjbkJYMXdIQWM5UXBFYThj?=
 =?utf-8?B?dzQ1L3J5blJPMk91SWY0dlZmbE9rK2hLTXZQcHhzTi9NUEpXaG1lU1c4a1Mw?=
 =?utf-8?B?bGNUWlpaNktKNXQzRnYva2RQZEJVYkFyN2JydEV2ZktxSGpnQm5nemVPR2xr?=
 =?utf-8?B?c3Z3cm1ITXVtMW9HTm1LUHI1OXVUYmhVYXFBTzByZTJQNXFTK3dTWTBTS0pI?=
 =?utf-8?B?Y3J6Rk1VSnUwekdWMFFZVUpxcGRhd1FrejFKV01UWXV0by9TeEVrTkhZaW1Y?=
 =?utf-8?B?Y2c4eC9acjA1eFE1a0RLNENxeG5jaFZpUmdjZkwveFlPOEdyMDl0dWYxOFRF?=
 =?utf-8?B?OURXUGNPd3p1a1doN3F3RkJockdpUVFzSDRhdGdYV25HTUY0Y1M1ZFhUc24x?=
 =?utf-8?B?NzVtMnBaNjd0d1JQcHNCQ2xiVE1hVXJaVis2RnBUZGpXRjBOek5RQTRCOFgz?=
 =?utf-8?B?VjAvMHVqL3ZIempsaFlGeVhiQUdPNEdwazNLeDAwbllTQndsa3VHTjdQZTh5?=
 =?utf-8?B?NnQ2Nll1TGw4WEJBOUZxaTYwZ2ZpNHY5MUVIQ3JWZEpiWTNqSVczN05ONkV5?=
 =?utf-8?B?cHBGUWZqeXJ2RTlsV2hYTEpVQmczNkVTYm1KYjdWaEMrN1ppOTdGU25sRG1Q?=
 =?utf-8?B?czU5WUFxT3o0Y09MUnloMWZaOTV1NkljbmZCMXBaVGxUeGlUL2tyK3MrTFZ5?=
 =?utf-8?Q?OrDQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fd2511-30a4-4121-c4be-08dd92bcb617
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 07:55:36.2467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysewlOWKfx4lt/kAuxwBso5gK2zAiOb7ps3Fpvp91IXKscarjaX3Sq7o/Z3swX9arXG4D12Ck/2YJqatMvJjLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3563
X-Proofpoint-GUID: 0c4cSFGsipssGDkdfrHX5BPJuo_8FdSi
X-Authority-Analysis: v=2.4 cv=a5Mw9VSF c=1 sm=1 tr=0 ts=68244c7b cx=c_pps
 a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=1RTuLK3dAAAA:8 a=O0eLdYTGcYNtOaTc2qgA:9
 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2OCBTYWx0ZWRfX16j93cCfLLZi
 XVMxWaDtbPBCGvm3H9/NSxAEFdnxE7vDCcZZ4c5ocM/0GGMlBlYqBYjugLWGmdeAlHh4HE9/es0
 /jL7ah4EeF2QmtIehPYIpUVolLqqJLf2kA7H65uckJL64JSIGj1b5P/3M3qdgHOm2rwprFeTWLd
 qQpTvYpaPxNHaVy6+xA1bBaxaRPzNSswzkxcSBEfDwzkdf2c2iHFGHTIf1L5Acbb/WpdyoptDEi
 5AdjuqXa9yY7kwlotxnAGlit5LeZHgYk6ppyF8gBuDdjuKADdKTSCfgKJzJgbBKj0gnpmDfQE1c
 FjfjtAn/KaKM7vU1d/efjxOtKsmI2r+JgJ6NJ/QYf606XgzDDdLVqXNC3VqwsS2VmJnwXgonYtn
 q21cTOn9D1KZoYiM+xUtktijEMe80Ir0bagn4vj9ujsAy3AvhdgnHXXIcuqGZSNTgudqX0Pi
X-Proofpoint-ORIG-GUID: onrTiYYL5nmnrM7DKssu_gX0x_1LBOx4
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

PiBBZGQgY3J5cHRvIHRlc3QgZm9yIHpzZGEgZGV2aWNlIGFuZCBkcml2ZXIuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIYW54aWFvIExpIDxsaS5oYW54aWFvQHp0ZS5jb20uY24+DQo+IC0tLQ0KPiAg
YXBwL3Rlc3QvdGVzdF9jcnlwdG9kZXYuYyAgICAgICAgfCA3ICsrKysrKysNCj4gIGFwcC90ZXN0
L3Rlc3RfY3J5cHRvZGV2LmggICAgICAgIHwgMSArDQo+ICBkb2MvZ3VpZGVzL2NvbXByZXNzZGV2
cy96c2RhLnJzdCB8IDYgKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcHAvdGVzdC90ZXN0X2NyeXB0b2Rldi5jIGIvYXBwL3Rl
c3QvdGVzdF9jcnlwdG9kZXYuYw0KPiBpbmRleCA0NDFlY2M2YWQ1Li40NjMzNzQ4OGU0IDEwMDY0
NA0KPiAtLS0gYS9hcHAvdGVzdC90ZXN0X2NyeXB0b2Rldi5jDQo+ICsrKyBiL2FwcC90ZXN0L3Rl
c3RfY3J5cHRvZGV2LmMNCj4gQEAgLTIwMDQ0LDYgKzIwMDQ0LDEyIEBAIHRlc3RfY3J5cHRvZGV2
X2RwYWFfc2VjX3Jhd19hcGkodm9pZCkNCj4gICAgICByZXR1cm4NCj4gcnVuX2NyeXB0b2Rldl9y
YXdfdGVzdHN1aXRlKFJURV9TVFIoQ1JZUFRPREVWX05BTUVfRFBBQV9TRUNfUE1EKSk7DQo+ICB9
DQo+IA0KPiArc3RhdGljIGludA0KPiArdGVzdF9jcnlwdG9kZXZfenNkYSh2b2lkKQ0KPiArew0K
PiArICAgIHJldHVybg0KPiBydW5fY3J5cHRvZGV2X3Rlc3RzdWl0ZShSVEVfU1RSKENSWVBUT0RF
Vl9OQU1FX1pTREFfU1lNX1BNRCkpOw0KPiArfQ0KPiArDQo+ICBSRUdJU1RFUl9EUklWRVJfVEVT
VChjcnlwdG9kZXZfY24xMGtfcmF3X2FwaV9hdXRvdGVzdCwNCj4gICAgICAgICAgdGVzdF9jcnlw
dG9kZXZfY24xMGtfcmF3X2FwaSk7DQo+ICBSRUdJU1RFUl9EUklWRVJfVEVTVChjcnlwdG9kZXZf
ZHBhYTJfc2VjX3Jhd19hcGlfYXV0b3Rlc3QsDQo+IEBAIC0yMDA4MCwzICsyMDA4Niw0IEBADQo+
IFJFR0lTVEVSX0RSSVZFUl9URVNUKGNyeXB0b2Rldl9uaXRyb3hfYXV0b3Rlc3QsIHRlc3RfY3J5
cHRvZGV2X25pdHJveCk7DQo+ICBSRUdJU1RFUl9EUklWRVJfVEVTVChjcnlwdG9kZXZfYmNtZnNf
YXV0b3Rlc3QsIHRlc3RfY3J5cHRvZGV2X2JjbWZzKTsNCj4gIFJFR0lTVEVSX0RSSVZFUl9URVNU
KGNyeXB0b2Rldl9jbjlrX2F1dG90ZXN0LCB0ZXN0X2NyeXB0b2Rldl9jbjlrKTsNCj4gIFJFR0lT
VEVSX0RSSVZFUl9URVNUKGNyeXB0b2Rldl9jbjEwa19hdXRvdGVzdCwgdGVzdF9jcnlwdG9kZXZf
Y24xMGspOw0KPiArUkVHSVNURVJfRFJJVkVSX1RFU1QoY3J5cHRvZGV2X3pzZGFfYXV0b3Rlc3Qs
IHRlc3RfY3J5cHRvZGV2X3pzZGEpOw0KPiBkaWZmIC0tZ2l0IGEvYXBwL3Rlc3QvdGVzdF9jcnlw
dG9kZXYuaCBiL2FwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2LmgNCj4gaW5kZXggYmI1NGEzM2Q2Mi4u
ZDA0MDAyMjIxNiAxMDA2NDQNCj4gLS0tIGEvYXBwL3Rlc3QvdGVzdF9jcnlwdG9kZXYuaA0KPiAr
KysgYi9hcHAvdGVzdC90ZXN0X2NyeXB0b2Rldi5oDQo+IEBAIC03Miw2ICs3Miw3IEBADQo+ICAj
ZGVmaW5lIENSWVBUT0RFVl9OQU1FX0NOMTBLX1BNRCAgICBjcnlwdG9fY24xMGsNCj4gICNkZWZp
bmUgQ1JZUFRPREVWX05BTUVfTUxYNV9QTUQgICAgICAgIGNyeXB0b19tbHg1DQo+ICAjZGVmaW5l
IENSWVBUT0RFVl9OQU1FX1VBREtfUE1EICAgICAgICBjcnlwdG9fdWFkaw0KPiArI2RlZmluZSBD
UllQVE9ERVZfTkFNRV9aU0RBX1NZTV9QTUQgICAgY3J5cHRvX3pzZGENCj4gDQo+IA0KPiAgZW51
bSBjcnlwdG9kZXZfYXBpX3Rlc3RfdHlwZSB7DQo+IGRpZmYgLS1naXQgYS9kb2MvZ3VpZGVzL2Nv
bXByZXNzZGV2cy96c2RhLnJzdA0KPiBiL2RvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3pzZGEucnN0
DQo+IGluZGV4IDM0Y2JmMjM1YWYuLjU0ZTczZTU3ODIgMTAwNjQ0DQo+IC0tLSBhL2RvYy9ndWlk
ZXMvY29tcHJlc3NkZXZzL3pzZGEucnN0DQo+ICsrKyBiL2RvYy9ndWlkZXMvY29tcHJlc3NkZXZz
L3pzZGEucnN0DQo+IEBAIC0xOTIsNiArMTkyLDEyIEBAIFpTREEgY29tcHJlc3Npb24gUE1EIGNh
biBiZSB0ZXN0ZWQgYnkgcnVubmluZyB0aGUNCj4gdGVzdCBhcHBsaWNhdGlvbjo6DQo+ICAgICAu
L2RwZGstdGVzdCAtbDEgLW4xIC1hIDx5b3VyIHpzZGEgQkRGPg0KPiAgICAgUlRFPj5jb21wcmVz
c2Rldl9hdXRvdGVzdA0KPiANCj4gK1pTREEgU1lNIGNyeXB0byBQTUQgY2FuIGJlIHRlc3RlZCBi
eSBydW5uaW5nIHRoZSB0ZXN0IGFwcGxpY2F0aW9uOjoNCj4gKw0KPiArICAgIGNkIC4vPGJ1aWxk
X2Rpcj4vYXBwL3Rlc3QNCj4gKyAgICAuL2RwZGstdGVzdCAtbDEgLW4xIC1hIDx5b3VyIHpzZGEg
YmRmPg0KPiArICAgIFJURT4+Y3J5cHRvZGV2X3pzZGFfYXV0b3Rlc3QNCj4gKw0KDQpXaHkgaXMg
dGhpcyB1cGRhdGVkIGluIGNvbXByZXNzZGV2IGRvYz8NCg0KPiANCj4gIERlYnVnZ2luZw0KPiAg
LS0tLS0tLS0tDQo+IC0tDQo+IDIuMjcuMA0KDQo=
