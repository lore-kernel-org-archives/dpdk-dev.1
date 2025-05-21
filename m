Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49082C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 04:57:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9364D40E42;
	Wed, 21 May 2025 06:57:41 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 73F0240E34
 for <dev@dpdk.org>; Wed, 21 May 2025 06:57:40 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNd8Un032122;
 Tue, 20 May 2025 21:57:39 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc8fsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 21:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX0QILFKh7918OCsfe9iLbe1shE0WvAtc1YN3C9zetQwMx5vjxHM0Jf6zpj9md6sXVV4JpdrsUT4xeTnoR6wvi0xpjv3lq9C0w/SIdIuX4PMFT1QiodvHH0a9v5ooW4IpOG/MAEtYs+1jN2KBOaV5DLdgv3Pxzbkm4qspEhjAt49ICmQT2ueFtg92XxxkQor22DCHQhuUgWSZmDImJ7QucT4RcvdNBU5F4PEhaYrRVN3HDbOUVOSRtuQ94rnWj1R5cvUkz6HmXy2738s5oDqrx+DlkjjYJ1LVzgIqO2foto9X+y/IceqkkLSCr6xJtXo81GHrYXZy5sNmOIhqD2Awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anwIN0CZUGExUs7/ssxAjQxnsDzFxEKc9BgtO9EmT6M=;
 b=nXWaZesZX7vbLhT+SQ47unhQ/9L8w2M04BgdDtwYmPAMM7Ofmf7vMqDiwcej0NnHApJ9z4uR5vYu9kqBjYKBh8Ckf1MDFhtqzmUmGXiejLDOxJTK2XVebtydFVBa2xE08LIipIQWpter8kXLLBjPGGz3oudkeAl9VukyznYsD2SLdTW1Ei/QQZP5og8n4PmlEXcvkMxYgZ3JLKaSjB27BpwGDcYoMg7q5TdPYjR3HovbKbvt5gvtuQifCXf7NzU9fztoeyaXhBvGNUA11ZTkE2zPf5yQQZ1dXpb60aYe8QTax7XD2Jj8UQfXFwDs3ZZ838pqIdGxqRJ/E4AxVaG0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anwIN0CZUGExUs7/ssxAjQxnsDzFxEKc9BgtO9EmT6M=;
 b=fJydPHWrEKBLZaUJPjMyylO5Kj4ciULlOhNVBiCplKg/5wDrfzEA1MSAWBNSK1l5o7raCnQmBfLVMqGranMRw1MNdd4SziwDE1nx+uUcerlGZx1U+OhU08y1/SNbxTuJ29/5aa0EEadsVf7vBYNnHBq/j+rPA7FYBcGrLUE4Imc=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by PH0PR18MB4653.namprd18.prod.outlook.com (2603:10b6:510:c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 04:57:30 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 04:57:29 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Jie Hai <haijie1@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] net: fix offset calculation for GENEVE
 packet
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] net: fix offset calculation for
 GENEVE packet
Thread-Index: AQHbyNghUD9UKZghJkGfA3MAopl78LPcCKaAgAB/KRA=
Date: Wed, 21 May 2025 04:57:29 +0000
Message-ID: <CO6PR18MB3860093067F7BFA7C59E16FCB49EA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250519160711.4024414-1-skori@marvell.com>
 <20250520142137.366c8235@hermes.local>
In-Reply-To: <20250520142137.366c8235@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|PH0PR18MB4653:EE_
x-ms-office365-filtering-correlation-id: 837bd831-0c79-4e0a-2455-08dd9823fd40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Lzk3U3ZWQVgyZmJCL0huMDVIczdoRXFOY1JwdW9ESkFxdjdlVTlMTjJnZmI0?=
 =?utf-8?B?Vkp2OUpLWFR2NWM0Y2V4WlJnOVl0TE92L1kxYk5hdFJMVzFvV3RGbVVreFVW?=
 =?utf-8?B?WEFISHRFMjRyZ0JvOVhpOTU5bzkrVnF2Q2tiTGpYa3NwdlhqZHNXSzBzV1hW?=
 =?utf-8?B?RC95RlR6RDFjVmExWEh4TENjRUR5Y0xZVll6aTJtUXN4blA4UGVZT3E2SFNV?=
 =?utf-8?B?aUUwamI5S0FPU3czdlpJV3A2bStGc093bHpnVGdtYWxIVnhTa1d5N2NDbGtq?=
 =?utf-8?B?aitPWm9JWElmUVA1ek1tcVBCc2FkNndESkFNSXd3NW9abyt3TE05bXI5QkRJ?=
 =?utf-8?B?ZjRRRVcwMkdvS2Z1WjYxYk52T293SGcrSzlISHNaaURTVDZIWGtCS1NZeXJp?=
 =?utf-8?B?dHRqNytnaldscktUSUZpOXYzSFFYMUt4dEVPTTlDMjFSTHgyc2YzUzNqYWJJ?=
 =?utf-8?B?b1JaYnpxdVFQMzArVjIvVTZLVXljYkwzMnNNZXBTcnkwTmsrQ29yV0JRUkx3?=
 =?utf-8?B?TFg4YUJlUVhxUTZ6eGlOWmhmS2VIT2ZZQXl4T2FNR1l3VXJ1NFBraW5naUNN?=
 =?utf-8?B?cEtsMDRuMTQwUFg1c0FJQUM2SnRmOG5kY0xNNmR3MWxDRDJ4N1JISlFnREth?=
 =?utf-8?B?VEFHWDlLUDBxNjBLcHZ3QUtTa0FINUhiN2NuNDVVaUNjL210OWRoUEVBdFAv?=
 =?utf-8?B?M011UFQvUXltOE1EM0c2QlhxQ2NqUzcwYzc1a0llLytCUzFmcTl6RWRGVjF0?=
 =?utf-8?B?RmlEZklLUDBhNDRaZVptVllsVElGaFQxK1VoM1RUcHZKanQ3VkpvVGo3RGZR?=
 =?utf-8?B?aHhkOUwyOW5RcGNmcFhGNmtibE5JcHFXc0xNTEp2MWk4T2ZZazJJaHVDRGZC?=
 =?utf-8?B?RHMyclJUbEdOZjZIenhKQ2F0RGRuZElKWXZraU9SQWJXdllRamFtem9LRUJF?=
 =?utf-8?B?SzZ1Z09MclE1OGVGcFdzME53YWlCTDZpSGhhOVpvc3NzSW1maldFMEc3aXdN?=
 =?utf-8?B?RXorZ2V1NjdmYUt2T2xHMFNjM2dDSndUN1VVSU81RzFRL1RzNjd5UjRWaHVw?=
 =?utf-8?B?MGVHaEdRMTdyMmJWRElINmlORUdQY0g4U0tERmpZRTAwU25WbHc2RHlIUURN?=
 =?utf-8?B?TFc0NGpRRTR6WXhsMnpNVzZrdFNpcjB5RlRFY0htaXd5WlIvYy85dzRiaVg0?=
 =?utf-8?B?eE9KMUtCNzFscUcwQ0cwSmVwZDVUOEFUbzVweGc0WGNJU0UrQUIvelA0UG9P?=
 =?utf-8?B?UHp0cXhlSnlndUtGdWc1K2JGSkxwTCt1ZnYreFpIaml0SHZPMTd5Vm9EV1Ez?=
 =?utf-8?B?NFhGZFp5d1RrZ2NXQ3hBbnFXSjZQQ0ZyUlpLOElaY08rSExweTl3VHhNS1JE?=
 =?utf-8?B?UFZaMUpPcElOdXYxUnliTkFnczZpbGdIa2ZFN0cyTDlsa1k1Rng1MHRBV3E2?=
 =?utf-8?B?ZHZyQndzTS9ESldBREhYNlVrSjFKVlZRRG4xRzRVWHo2UFVXQTdXK2Y2dGpl?=
 =?utf-8?B?K2sxRFZMdE9uTS92VVYzUkcrT1B0VWVuVUs4bVd2Z3hVZ2tLRFMwZUhVeU1X?=
 =?utf-8?B?c0VCUnIwT0FZMjIrdC9WNlN4RmdiRjZnY2w1d0NGOXNNdW9NQjFtTlh2RnlM?=
 =?utf-8?B?SGFtb3U5M0F4NmRKWUI1ZTI0NHJxeE9DTkJjNDdvZnVUK0pRZWVaeXF3b1ZS?=
 =?utf-8?B?U1NqWGgxUW9mWnFObFY3b3o3ZTQ5SWVQUWthOXhtMUQ5MVZwUTVLc29HR2F5?=
 =?utf-8?B?Q2xTYW96OURCWDJvbHFnREkvYk9EMHdLYlYraU1pUkJoVkIwcnNwRHA4K3k3?=
 =?utf-8?B?L01yMGlaVVFWR05XOE1sQ2pZTmtLVGM2S0JveUQ2Y3BSbDk5V2RTVFlxTUxq?=
 =?utf-8?B?Yy9FTyt3eCthYi9nTXZxckdzY21oUHR0M2dqNEtDRFphMTVYTjVnUmVVeWJ5?=
 =?utf-8?Q?d22UYNbmoZ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlprU1ZuOElCVXFKMWVGSmpzdWNnN2VNaUJSaWFVc1RrSjRqRVBBbll3YnNU?=
 =?utf-8?B?TzFXWm51alhHQ2ZPMkhXUWZub1h0Y2t4aXc4a2RqUzB6b1YxZXhOdDNrc2Qx?=
 =?utf-8?B?SzFnUk9FZTlGSDlQTVh6dmdlcDhhdFBQSXB4c1VVTzVzVXhZUk1DTUEyMnBM?=
 =?utf-8?B?a2d5NFFZZzZnZTNERkJaR3ZvYlFRSEprK2dlSHVYQi9xaTk2bVU2dDYxU1k5?=
 =?utf-8?B?ZE5Ja1J5M25XYTFmMVdWTHQ4SU1HQVFJZ1BxdVFxVEw3VE9lUXhwMzNXY1FH?=
 =?utf-8?B?K3p0WkxUT2ZwY3c5Y2NoT1cvWkJKS2hjZUlLaGhLa3NZUWNWQkpLeGtMWXhp?=
 =?utf-8?B?SWpBMTlBK1F5SnBkamZkZmRuaXFYVmZMa2VqQzRYVXBTb1BrQncvd2xSVkli?=
 =?utf-8?B?b2k4NTJraU1BY0orMTdDOHVnV2hlOVE3V1hYY3MrREo3UTVhTjZYUWRpVmlI?=
 =?utf-8?B?cU12TnEwMWQ0MXpvNEtCTlJaNlVjdE5uZTBTUkJka1JXcFF3bHVJOGk4c1hw?=
 =?utf-8?B?Y0lpUVdTWmlTQWl2WE5zZFpYY0FSeWxSWkRLblUvTnFmdm5rdEZlYjRydUp1?=
 =?utf-8?B?dER6cXFMdFFrZElsU0xFaXZ0L2tqeERBaWVvL0ZmdnFlRTg2cXlTSk42Vitl?=
 =?utf-8?B?WEM4ZWx4MjgzK3BRK2xlRmJZVjVVL3NPZWFsbHlGR0RMREpMc2NvUDBVTjBu?=
 =?utf-8?B?MEFwV3d3aHJ2MGRKNTRGeTg0Z09qUWFMN1Y3RHZsTDZ0T0lsT0puMFE5ZHZr?=
 =?utf-8?B?ZUY5OGNtN21mV1JFSDZVdlk2T3lMZmsrd3MwUmtualRMTU1nVjVQUmY3ckdv?=
 =?utf-8?B?eERvLzZrcngwUy8wNlBJSDhvU0tQejVZL2VvZHBpVXVGRzE2TGxMUVMvOFZG?=
 =?utf-8?B?akJNSXowTlNQMkVLalVQT2RGclJaUVdNdzZoOHp0N1kzK1lXd3AwdzkyaTh1?=
 =?utf-8?B?dUdnTDlabmJZNERWclR5SmNPelc3OXBFS21OZDBnOTlsbTFZTmtneDI0N3JU?=
 =?utf-8?B?TWoxVzlXZnJ0MkM3c3Y5MTBsR1c4ZWJWWmVmYnBLRkZKajU4d2lyM0JYczhC?=
 =?utf-8?B?bStWU0c0QmExM3l3ZjkvdzdrNjN2Ukh5cWR6anRUYUdVL3ZkYUo0YWtyYzYz?=
 =?utf-8?B?akFXN3dSOTk1aVo3V3ZiSmtUbEtrQVl6b1B5LzdXYnpzbm9QRHp5MnlrMmNE?=
 =?utf-8?B?VEtBVk5PVzIrM2tvR045T2NqVWh0OEZYMkZEWFV5QkRCQmhJQ3BsVncwVWl5?=
 =?utf-8?B?TStvaVdMeXprbVJyWk1jYzJWWHNsckZPb2lnTWdPWVluVjB0amJZLytMakVM?=
 =?utf-8?B?YjhjSlRRckZLT2NtTjg0UlVZdjFhemhSbnVQWFdWSTlqODY0WDh6QSt5bnZ1?=
 =?utf-8?B?VzQyU2pjMVRMcHRUeGRpODBUVkFPMlVsVE1Dc0VQTHBOcit0VEhJYXZ5RkpW?=
 =?utf-8?B?M0VPemtDN0hXM0dOc214WmtaeTNwMW5aWkNBM3RmeFgyR1Y4NStsZmUxYlZa?=
 =?utf-8?B?Y285aGtVZHFMOXlXcU1iRnQyQnZFcit2Q05HcG1pQUpQWE9QaHdvTWdxWHZH?=
 =?utf-8?B?ejFKQkg4TFFVdGUyRlpmZENvcm5LQlJKTFhEN05QUkN2WkJ1MktrbllZejZL?=
 =?utf-8?B?NWUxT1hMTmM3WTBHUGdrdFJDOFM1T1JiMGxUa1VJSDhLNkc0KzFGRlNPTFhL?=
 =?utf-8?B?dFU1Z1NCTXN6UG52dWxDQlUyS1NYSTRzdVhWb0FzSTEzWVE4bk4raWZoWmE4?=
 =?utf-8?B?Z1lpMmh3REFkSWdaeHJvQUlOcGQ1ZU5rb3ZOZ1NaSW5UdmNLYUU0U1dKNTF5?=
 =?utf-8?B?OEtHR3JIYmQrN2Y3ejFLdFJtT3VIZmtIUW8rVW50Q2RYdFVjVWZrS1I2VlNP?=
 =?utf-8?B?OG9pRm00SFB6c1lIQm9TaDNVcXE2aW1kZDJYd0Z2MWNJNFIyOCt6bGZ6SFhz?=
 =?utf-8?B?WCtwOVJPQ3JxTk1mOTVBck9QL044aGs1THlOSFh3UFBuQzRQa0V1MjA1Mzc5?=
 =?utf-8?B?YTlGaGRFU2l4OUx0RWZyVlJjSVQ5SW4xbWgzYURqUjA1KzlwY2gvOTFSamN2?=
 =?utf-8?B?bVhEQkpGMU14eEcrLzIxaWtDQlBHUmRqcm9ndXltWDlpbkw2RTVCK2JtdUdt?=
 =?utf-8?Q?XvJc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837bd831-0c79-4e0a-2455-08dd9823fd40
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 04:57:29.6473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3uReIxrEQo4JuvLqBeoDQiUeZmgJJJNEYqPvErAxMfAI1wCqMSPUJI4RkpCjKdImvunJKAt7QTjBdSZ+mqIew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4653
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Zqq_1OnDizgN8WDK3x-WCeUz13cljb7b
X-Proofpoint-GUID: Zqq_1OnDizgN8WDK3x-WCeUz13cljb7b
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682d5d43 cx=c_pps
 a=E4Q64eWPmlOcdHW0GAz4hQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=i0EeH86SAAAA:8 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=1UkrGUahLw6cuq5SnhYA:9
 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA0NiBTYWx0ZWRfX58rnYtU3+K18
 2lTRKhgxTf8UZZJ3vHcImIP46Ur9tASdSS6Zk/FwWuGJTXJPrtFKoeVdFkHKAnSDxZF70qoaClw
 YR4/PokREWn09W5apr6uLbH0nZ+yh+xhKQEynMm5aCcQAH2rTV6Y0/G9UYCblwAyeBk0SiBOMb1
 95TqV+7gvjTCpVJB7p9vsgpt66XItUtyyJSjPSYlZSsQGw6x1R0z6WZIVHdqKMjFs/6C0EI6pjN
 3C/hvsSAXUtRVu7dnE8LuPRwhq8vadqEg8aIPJj8OKND+/Cx6tFMsN2Jjird6QcN59z0IFZ8WVl
 oIIvcadXSvZ/DenCusGZJu8xLFCwn1YMjYJTpifW0cJOk4nDRDDgdMgUhRJuVqkMMKNwx1tHMVy
 6fcEELPjxv33vpHnoISuilAubVLyot1sLrejy3Y4ITjVISjSoLIXcxQW8aC+tj5idQaoQan2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday, May 21, 2025 2:52 AM
> To: Sunil Kumar Kori <skori@marvell.com>
> Cc: Jie Hai <haijie1@huawei.com>; dev@dpdk.org
> Subject: [EXTERNAL] Re: [PATCH 1/2] net: fix offset calculation for GENEVE
> packet
>=20
> On Mon, 19 May 2025 21:=E2=80=8A36:=E2=80=8A55 +0530 <skori@=E2=80=8Amarv=
ell.=E2=80=8Acom> wrote: > From: Sunil
> Kumar Kori <skori@=E2=80=8Amarvell.=E2=80=8Acom> > > While parsing packet=
 headers, offset must
> be added to get next > header but for geneve header parsing offset
>=20
> On Mon, 19 May 2025 21:36:55 +0530
> <skori@marvell.com> wrote:
>=20
> > From: Sunil Kumar Kori <skori@marvell.com>
> >
> > While parsing packet headers, offset must be added to get next header
> > but for geneve header parsing offset is overwritten.
> > Also inner_l2_len is not set in case of geneve packets.
> >
> > Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> >
> > Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
>=20
> Looks good, but why reorder the assignment to *off ?
>=20
> Could just be:
>=20
No specific reason. It can be kept as it is. I will fix in next version.
