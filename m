Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ACFC54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 10:06:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A0544064C;
	Thu, 22 May 2025 12:06:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id AC13A402CA
 for <dev@dpdk.org>; Thu, 22 May 2025 12:06:39 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M9H81h007487
 for <dev@dpdk.org>; Thu, 22 May 2025 03:06:38 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46t15jr38p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 May 2025 03:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwIXKswnZ9vdESbifnWgbtZqpA5NKRlpJdO5coJ1OEM/qVptkctIeQ1NvXwacE1hiIMcbGDAcE0lvbgLD2pVxErXFeuA0yMsydK22p6yFmkARX5oHJZa5ribkByfY/isSLaCO3ckgSLfK1bVhq2OSJWpwk4ZlLnZrDY2+lgBF4cwcAppzeLWXlG/RGlUtOQ5gcnrBg1juWHD1MDHDM3lg8cw8TAW+f6N7UUmmSdu9+0jwQlk40Cp1dZ3l2rRntOJo7328n3LGyKx9ljrOlBLdOmGTu+3JOCoNf1pVxbWWFkpPh/j/Uv5x6ImAlw57WBD2MAYbvg2/aMrDdFghaHlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru8az+rFYSX5do1tGJjdE8uLMqpH0auOxbI4BleLXQI=;
 b=FfCH/lqh6Jrmbc5b/YxFSL1MBL7Gza0CM58A3H/jm1gB3olI5m0bW6tCgmw+T1fMeI7hUKUzGwjadSIsQCb9nXd7SHPlRdcGHutByC8cHZ1ean8GlhtDFAge6b4ELdgfPEP+q9B0Xe8//n/njWCF/UtovMhu4JGwHpWZIOqCE09UXyNaRVrSN6rP+vvhpduftF9SOUqyFTYOY4Uq3S5hTooSMgudl+tGmnKFJhvmsZFgDWclK1MZ4KOIwGhHlRYG6UWhw/1j7xLScHoVpMCmdcHTNAnIZNxfHYJ4Gt7ThdYYyIvKugGMGbK1Jj28PDijFR0IDNseqk/bAgSf4rRcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru8az+rFYSX5do1tGJjdE8uLMqpH0auOxbI4BleLXQI=;
 b=gubTH/b5lZQQhV8MmdXuuOEgrHdV8imsUjetkPt4O+Msu/MMz+A4zzTOmoiGv6gVDFRxR5k/QYY9ec6av0DGXB6kVF9RYN87M9BK/72Pl41KJAWGjDBsmfMc2k3bjUtTM5JvWyjblDObQj6Ci5bTHtsmniJXWxcEZL8GNbLRLPs=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CH4PR18MB6190.namprd18.prod.outlook.com (2603:10b6:610:22c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 22 May
 2025 10:06:36 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 10:06:36 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Satheesh Paul Antonysamy <psatheesh@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Satheesh Paul Antonysamy
 <psatheesh@marvell.com>
Subject: RE: [EXTERNAL] [dpdk-dev] [PATCH ] net/cnxk: support ESP based RSS
 hashing
Thread-Topic: [EXTERNAL] [dpdk-dev] [PATCH ] net/cnxk: support ESP based RSS
 hashing
Thread-Index: AQHbo6jFqk79It6RYkS5Ah/pPAd/J7PeuuqQ
Date: Thu, 22 May 2025 10:06:35 +0000
Message-ID: <BY3PR18MB4785BE4D5D5ABEC95BCAB160C899A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250402082459.785424-1-psatheesh@marvell.com>
In-Reply-To: <20250402082459.785424-1-psatheesh@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CH4PR18MB6190:EE_
x-ms-office365-filtering-correlation-id: 24c47035-47a5-4f05-df2d-08dd99185626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZWo0MU5vTUUvUkw0SDk2bDFPd25TVi83eVNHNTR6bHdNQm1GeWdLNFVyVU9l?=
 =?utf-8?B?V1JIVmlieURXSEhLa1d6K0lSQkpGYStTcTFXSlNTVTFHQkc4VzBISEJxTjBl?=
 =?utf-8?B?dmVNSE8vNFBFZnlCUnBiMURzOEwyTXdzdFRrL1lJWUhxK05mbnF0ZFpDbUtx?=
 =?utf-8?B?TDVsMitoaFFWS0s5MUpXVFN4eVh5ejEwNHYxZ2J0NGx3NGI2bTVuSFBmcE5s?=
 =?utf-8?B?S0NVQnRkbXVoaHNHM3NQVHRYYndlbEdhT2NhL2JYaFY3N2VWMmYyOFlOdUZU?=
 =?utf-8?B?dW95RmtOUjBGSnJVQ0ZQdWZpRXBxa3U0RmIxQlFpaVVOalRzRkNKaWxWZ0NG?=
 =?utf-8?B?dmhXaEV0ZENuclJCS3Z5dkdiVUl1aVlBdDFXR0s1SVM1UTZHcFk5eVpwUkxM?=
 =?utf-8?B?VEtHb3hVUGRzNVVNL3c3U1dFYTdYVkdRU25NSDVuQktJSWxsSHVkN0QvZDlG?=
 =?utf-8?B?WE5YdHhNSGZMWElteFBIYkk2ZHJXZ1hpSWJLRjFKR2UweVpFTUV3TVpRNk4z?=
 =?utf-8?B?b2Q1bUhGV2ZZTy82aW9BQS85a0VkWFU5V3hWWUZzRFl4cWZZNEhQR0E0Rk8r?=
 =?utf-8?B?enNLN0c4Y2VGcmtXVWh4M0s0NnlNalRPMFk2cEZCQmdmZmM0dHQ4elh6bUky?=
 =?utf-8?B?b2h6dXNlUXdLTkJ0K1BLYjBrS2FBVXZoSjc4RnpqbHlMY3ZQd2NpeEJNZ280?=
 =?utf-8?B?WmlrOGhYT3VRQ05ERHB2c1N6NFo5TTl6b1cxSUVtOU5HNVAzcXVmaTFDaXBq?=
 =?utf-8?B?UjRORm5jMGsyRjM0UEZDLzl0eTZlUEVJRnNXaVM0aUErL1k5UFlsWmVzWERl?=
 =?utf-8?B?SU9zaGFHTnpaWTJIdzBWelB3dExVSzlmM1l2UmdMRCt3Qm84bUU2ZG8xNDM5?=
 =?utf-8?B?c0U1dEZzWGNPeHJQOXh2cTN0TXlIRXZYaFhoeXM2RVNISXlGYVRTaDVvM21m?=
 =?utf-8?B?RTU2ZGJPcUx6eUQ0eWFsNHFZUkRSdFJxU0dSUkRnREY0YU5VYmdrdGxjVWp3?=
 =?utf-8?B?S3hrV3FsQ1BiVHBOV2FEQVhCUVM0M25ESWwvM0RlSFlrRURsMEF5eEhuTHJS?=
 =?utf-8?B?MHpoclpGbDBEMGFVeWhCTTBSMUhUVVIrUGxBMytETDRuVFFhYnRvQ2dtTXJS?=
 =?utf-8?B?aHprRWo5cTNZNlRPcU1PdzJGL2d1ZnZyWm9xQVd6dTRxeGw0bTFZRnV3eE5H?=
 =?utf-8?B?K1RWQlpWZUN1MEtHUGVsZW9XSkk4VVhJMC81V3FNcWlaMFNIZ2QwQjZvWWFC?=
 =?utf-8?B?VWpHL0UwUmdUK0t5bkpzeGVqeElPU0wzK0t1Ym91SDZXMSt0RENhYXlEcGl3?=
 =?utf-8?B?bGFpMm9VVVNyaFczdTBoVHBkbjl2QkVGSHFnWVEvK0pFd0VDZnpOU2VuVVE2?=
 =?utf-8?B?Vlh6eU12VHNjVHE0VERpN1J4S0poQkNkTTVIalNsMFYva1lad0QvbDUzdjhw?=
 =?utf-8?B?T2sxeXJsV2g2MUxveGllemhkUUhiQzZGaXhlRkJ2N1J5ZDFoRk5wL0dkKzZk?=
 =?utf-8?B?TCs1UDNkOXNZWCt4YXRmRUJranZlZWI5elROMk5Xc1VKQXkxWkYxN0hVME0r?=
 =?utf-8?B?ZkRTWXZEdk9GQlhyR3NudDBUZGRQSE16SGk2eThMKy9uOXBRR01qYTU2MTFo?=
 =?utf-8?B?cmdqRkZVU0x1MW9vU2dPYmxjcXZqbksxVjlGUGQzUnZqSDFYaHlWTDU5Z2M5?=
 =?utf-8?B?djZqZ2ZrMWtpWHVqU2FkOFJWYW5YSk5nSWZhMlZPbkYvSW0rSVdLOXpsajhF?=
 =?utf-8?B?L29ORDBmNVk2a25LNmhpKzBlcVFnNy9JeStMdjV1OHFPU3FFY1JsRVF1L1Ex?=
 =?utf-8?B?Q0JxZSt1NW00WU5sU3p1U04yZXhOa3RlekZBcHZhNHoyTWQ3VXh4RHh3dTU3?=
 =?utf-8?B?VU1rdFM2TlR3TUdMcEJVYitzeElDN2M5UDhBdmxLeDNEK3BSOTlIcFhOc3dS?=
 =?utf-8?Q?5phTPmnp/es=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW1yMkp3STZOV1FHVnhOUXd0R2FIR3BRSkp6U1c0Y01Fdk9Zb1RlenAxNlNo?=
 =?utf-8?B?bXU5YlVXdHk2T1VWMitvT3N1dmVPSDJmek5XRVZmcnhYQXdwTllqazFwOFRz?=
 =?utf-8?B?R2xDUzNORHAxdEt4aE1yZi90R1VSU3BOU3h0dVBmUkN0NVJRRG16d1hSckVL?=
 =?utf-8?B?NGprTDdqbVRYcEdUU2t1TFNTVUdTbGNtRFgzZFpENVZkdm8xeGI0cXBjR0Ra?=
 =?utf-8?B?RXJoRWNIeU12SkNvV0NEVlBGRGlsY2QwRzNHLy9xeVgrSVAydm1uWGhGY08x?=
 =?utf-8?B?UC93KzNjaFpteHhSTHpKQTVVcS8yaFhqZVBkNkI4ZGNlRVAxbG9EMEsrVFhG?=
 =?utf-8?B?b3J5U0F6aFFCYVVZUkQ3Mm9iM3E0Z0J5U0RFdWZhVFJCamJ6VXluQjgwcGFS?=
 =?utf-8?B?RDhkTjJsVnMzZmFBVkgyUHk5cjBPY3JjMmIwajRtYkhORWFORWdlamJENUpZ?=
 =?utf-8?B?MUZlaFhPOUZza1RUelQ1WHlabDFIVEN2eHJLT2R0OVZ2RGdZdzMwU0xIRWor?=
 =?utf-8?B?UzJIZkhIcmo3Z3RsUFd2NnZHSjhwOUlhNFJFNDJWZTZMdzlBbzZtTDdmWVY4?=
 =?utf-8?B?MXJrZTVKbE04RG5rZXBacllKcmV0VjRvUUJBRVNBcklUUHllOGpiWUUyNzBY?=
 =?utf-8?B?eE02UjFBUncxMkk4WXVrV3piemZSL0VUb0h0dUZEZ2d5RHczcThkcWtNRWw5?=
 =?utf-8?B?cGtjeU9OZXpqS0hvbTBBYklOZWhocmtsYm03U1Y1RWFsNDl4MHRlelJiSUtC?=
 =?utf-8?B?ajVDSnBpNnZhQXZPNjRVWnJieEorbklJZzV1aVRsRVlkcklIbU1IS3lDdjhO?=
 =?utf-8?B?ZDk3TEQ1Vkd1ZDgvQlJ1ekRrQ3dPWjM4c3FtZGUxbjZoYW85TDZOdENaU0gr?=
 =?utf-8?B?akVwN3IxQ1RrR0NMZmxZdm5KMFJOMlBRYXY5aDZEeTd0WXpZeldoWjV2ZEw0?=
 =?utf-8?B?NlYxUkxqc0tPNkVHU1FpUzZHenYrc2lkR1Q1a0F2YWovQm5MVk9aL3lyUUZt?=
 =?utf-8?B?TVhSUUJ5cVhXRGkrNkZhQzQvZEREaS9XYUF0bnJEM3owcTliVVR2b2gyMGw5?=
 =?utf-8?B?THNCN29MRlZiMVB2ckI2anhRNUJrRHVuK2JmV2RxYUcwYkpiTWJDb1RialM2?=
 =?utf-8?B?WUV4QjhLMTdEeS9rRXZzM1lOcUc0VTdSZGxGTnpDMngyTG1zTGdYWlVEZnlx?=
 =?utf-8?B?SmdhbWRVaFhiNmdRWUJ4M1h3c1RPRFprTE1YbEhoeURnS0pxREUxazNjNzBr?=
 =?utf-8?B?akJ5N1Zhb2ttNDg0UXZJcVNXSlpDcEpBTmFSMmRTcWFocFM1Y2YwTTZYQ0V3?=
 =?utf-8?B?NFFoRjRvWGJDZ1BLNWVXWHpWUmI4Sy9rUExVZ2lQdGxiL1pQYVZGQUdrTGRC?=
 =?utf-8?B?YStJR2FjQU1Qc0dab0FQL3hjYnorM3hiNXhTOHU4RVpTTVV2bU4xMGorQXp2?=
 =?utf-8?B?MnZrRFp1d2laQ0E0TnZtdythdU9GM0swOU5pdCs0eFRnaUZBc3pxRmZCZSto?=
 =?utf-8?B?MEFiUEdGTExoVC9oa0FUNUUxUkh3VVQ0a1RLc29NczhLcUM2M0NsRXBSdllm?=
 =?utf-8?B?KzJPemhPVHdpS21BMFVHZVdycGFDOHVTbFE3SUVySXFEaWszYTh3dUtEeUVx?=
 =?utf-8?B?NEdFWGRycEV0VVNpWVNYOEZRQ2pPT1hiVytTQ0xrRjhoNThReHpmNlhFbmZU?=
 =?utf-8?B?RHo4aDFxOG5QOFp3cENLNVRoRWROeWtRSFh5bkJQK2pQWXBmbXBHdFhCRXFp?=
 =?utf-8?B?VGV1RFdES1pMNXZEZGRNMStNQk96QkpPbWtETVE4WVg1ZklZa1BYU3hGdnJp?=
 =?utf-8?B?YzVLVlh0aS85dHdvQ1ZUMG13ekhnRkFzL2ZoQlVGSDM0WmhxZ3RHNWRlUjQy?=
 =?utf-8?B?eUsvSGdsTit3SVRYdW82RWZWdkhHd1E5S0dTcnpSOGxvVGJnQ2tTTVM1bjhV?=
 =?utf-8?B?YURPQUJzTHZiM01TZ1kvck5LRXhUOXNiU3IzWmMwaldhTGlBcDZvOTBKdm05?=
 =?utf-8?B?UGJJNGRodllIOTZRWm1BbEhoZTFhMVp0WEduYlhlQ0k5SUMvR2xpdkc1WWR6?=
 =?utf-8?B?UStyNlFTYnVEZ0ZvaGlYOWtyNmtEdjVjYTkwVWFyejdTT3k4Mk9YcjAvU0Fk?=
 =?utf-8?Q?ZuUNW3Q1tlx2HImrZkYd5VJrL?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c47035-47a5-4f05-df2d-08dd99185626
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 10:06:35.9499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAqKU6pwVnLJWNKqe/4ORs3qUYG/vc3s/xyLbmiuR499tNZfwRoHvfkb3uQHn6KJzRZKZ4QcC4S6XGhN/B1eag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6190
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: MJSttptbYdxtoQzvYk6Snh_dq1ENKu0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDEwMSBTYWx0ZWRfX1yAnW4f+XDjt
 aY+BWOIMLXw9eBwUrZRjYuGL43zu/KUAg5HKr9loieDwZ5F9o8I/ct603HgO31iWqPcbLzVKOge
 /j9tgIXRTtqLJL7mvv7rZR09OdvMp0/cYR4yjOg8S9mrmnONFsn0ACISlx6QZVXgyhr5rIiaZ0R
 75QsFquOXLCuJAFDX1QA8xgkA6PcD64kT0orC52Rsv4J1SD6BXIFLiBxAafyhSeN7hRfP8L/B8W
 4bN5uYbjdzdKs96cAl+zuEaN7BUaS+AdGXziwuRttkJ4c9OZOsfKiBffylNVIZyv9fg2JHVsWYH
 C7j8U9tbnStDCC+qGsgYSCIE+qRKuAGswdXtWXPEog+CtBrTGmzScSOEvKXAX8RAbrvWnd1My1e
 0eb5f2UxCYPdauljQAk4aahXShl5FX/h/Z3Bhxb2XK8fh7n47mNqLlPSEplSCs5sstOTR1Il
X-Authority-Analysis: v=2.4 cv=HOrDFptv c=1 sm=1 tr=0 ts=682ef72e cx=c_pps
 a=dIBsZBmI1wyUZqnlzmwqRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=RpNjiQI2AAAA:8 a=1UkrGUahLw6cuq5SnhYA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: MJSttptbYdxtoQzvYk6Snh_dq1ENKu0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_05,2025-05-22_01,2025-03-28_01
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
> From: psatheesh@marvell.com <psatheesh@marvell.com>
> Sent: Wednesday, April 2, 2025 1:55 PM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Kiran Kumar
> Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: dev@dpdk.org; Satheesh Paul Antonysamy <psatheesh@marvell.com>
> Subject: [EXTERNAL] [dpdk-dev] [PATCH ] net/cnxk: support ESP based RSS
> hashing
>=20
> From: Satheesh Paul <psatheesh@=E2=80=8Amarvell.=E2=80=8Acom> Support ESP=
 based RSS
> hashing. Signed-off-by: Satheesh Paul <psatheesh@=E2=80=8Amarvell.=E2=80=
=8Acom> Reviewed-by:
> Kiran Kumar K <kirankumark@=E2=80=8Amarvell.=E2=80=8Acom> ---
> drivers/common/cnxk/roc_mbox.=E2=80=8Ah | 1 + drivers/net/cnxk/cnxk_ethde=
v.=E2=80=8Ac
>=20
> From: Satheesh Paul <psatheesh@marvell.com>
>=20
> Support ESP based RSS hashing.
>=20
> Signed-off-by: Satheesh Paul <psatheesh@marvell.com>
> Reviewed-by: Kiran Kumar K <kirankumark@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
