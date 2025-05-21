Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3BFC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 05:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A8D040E3B;
	Wed, 21 May 2025 07:02:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C840E40E34
 for <dev@dpdk.org>; Wed, 21 May 2025 07:02:01 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNkwVw016102;
 Tue, 20 May 2025 22:02:01 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3purf80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 22:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBytZtDcqZoGRlEOoF1W4nU9G0Dx8ogm6Ji2PtglXAmdTl73j6RSudC1Xgji9HkKXs+yoi6zWSoRI6jfnKFslzNQstqxK0U/9pL9McgXwjz0QraE160UsMudgazZkS+LC2p/0kC/pBrJNFdeSIMd48LV+Piz/PMmXeMdtJdAzMsBfTIISr3Zp9QMMyxu7hcXklKqQV0LKDgdsFSACjxzEwXAiaGWKJfWj9uQC7zRgioD2NQcGVIRoljbX+9AhsjBs2+3ZQByIp1o7Y2pCH2zslgh99DhJtPZbYydINE0Nv3VkTqIIabnS53z/xA6o+UWAVgNy8RJgzDPwZbG+A7LAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAe69CYrO3n61k0CpMgP/el1gk5ZkX7lmEvRMNFP5rg=;
 b=o6qrbh+wOtY9ys/TmGymJR7vU84dYoRGcdaSkvPyQDN5lNtnJUAS2CPHNz1cSJO/5n9+qOhtgIS5VYmammG6KvZulLj5smpSYvTXGu9tSID2B0ucPtPYPq6gyGWG5lkoqTozzc1jvviU48W1IreaZM16zwSBNE/1J4DpuoWfA1KvrOyVjO67B2E6XY0rkua3k+9MJD8s8m/3YaLGmpZRRI2q9lXDHtr/R5vajxfL+aCRabVj2InX1IK82FLD5oXrqhog1q8i41muJxWccGo3sthTNDqL2bToQ9cJ1tdTC64xe/qp8+fUjV8og8vX2+XY9iqzbhMyaLzCoVWrh3AKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAe69CYrO3n61k0CpMgP/el1gk5ZkX7lmEvRMNFP5rg=;
 b=ZhTbTJpTP2+7aL4IEQryvsPBLwBq2sHfjhyQZ9qKA+2LDX8+kOHjvzbOGzOW5RX6/vNgxEWhTyQR6OsJLR2EctuHd17fcY63OJhHLSU//evc5FjDQXiLq94V4Ak7ObxbCx9i0tRA6pG/Ar7PyaoLdLoOD/w7eVWTPDtDEBsYorI=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by SJ0PR18MB3979.namprd18.prod.outlook.com (2603:10b6:a03:2e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 05:01:57 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 05:01:57 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH 2/2] app/testpmd: clear stale internal len
 information
Thread-Topic: [EXTERNAL] Re: [PATCH 2/2] app/testpmd: clear stale internal len
 information
Thread-Index: AQHbyNgrVQu4ITMmyku2v7rfPm/Lu7PcB2mAgACBesA=
Date: Wed, 21 May 2025 05:01:57 +0000
Message-ID: <CO6PR18MB386027DB3D4E6D472E32FB03B49EA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250519160711.4024414-1-skori@marvell.com>
 <20250519160711.4024414-2-skori@marvell.com>
 <20250520141711.0b9d481f@hermes.local>
In-Reply-To: <20250520141711.0b9d481f@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|SJ0PR18MB3979:EE_
x-ms-office365-filtering-correlation-id: e834c61f-8557-43af-9a52-08dd98249d18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bTFvZzVTNGNWWTRqa1ZjbUplbWNCekduVDRUNVJwSExVL3ZST1kxOXhJL1o3?=
 =?utf-8?B?ZDJaUkpESDcwdXZFWnZIaTBmMzdXYm9EVG8wYkxibitQZnhFOEc1VjJYbjRM?=
 =?utf-8?B?bFV3ZG0vWUZTNGFqYWdwUDhJY2x3SGVsc1lQczg2WHpJc2ZiU1pZb2ZwMkkz?=
 =?utf-8?B?K2ovNDBHbEgvbmpSenE4QUxCZnZDa1FVSURJNjRVazZXUTRzSXcxQXhZdEdn?=
 =?utf-8?B?QVRsMmNXMkVXL3Y3SkplNFZnYmdyV3dvbmUxMVNWamI5TzRtUzk3ODdoNXdr?=
 =?utf-8?B?YWorWEluYkxwSG00ZUdOY1IzM2V6aWNrY3NTcmFKN2hMdEE1M1N6OWl5SGdF?=
 =?utf-8?B?WTAvalplVGpVZXVYSmpCTTRlc1cya0hXRWs4dWI4SG5aVDVqSXpIMllkTkpa?=
 =?utf-8?B?ay95RDBWYjVXcGNRTjRZWS9OVGxFbHZlM3Z1NFdFUDY0dXFRMFo2d1hQMHY2?=
 =?utf-8?B?UnRmVDREVUxQeDlqMG1xOC83MUJlSGZMSDd4dlhnVTRrY0JvOGJxNS9BYTdo?=
 =?utf-8?B?NG1EeVEzRkdoa05XbTNud3VUaGNRdi9SKzNieGFMaUZ1aEw5MnBLV3hjVGww?=
 =?utf-8?B?WWs5L2hDdVltdzA5UlBwbUVZYk9wTHRuNTJSTVNPVE5mSXVVU2l4NGdMeTZt?=
 =?utf-8?B?MHArZER5eUh3MEZGTGtKZDZSMEd4S216UThmUys0Y3NSOU9IT3lNZ25MWVA5?=
 =?utf-8?B?THRzd2l6QjdJRGUvZWRDS21Sa2w1U0FZQW52TkFTVGFJWmtOei9lRjRib1pJ?=
 =?utf-8?B?ZFRRMm40VFFKRTI4dVE1WWJNZTJLOXVBdzlURkJsSUFNN3hlZXFjT1J4NGVx?=
 =?utf-8?B?eHV5N0xDS2NMQ0dLb2VFNHpGQlBqK2pXTjFnQWN3Qm5IakMySVhTNzJLSDV2?=
 =?utf-8?B?WmQ0K2FqMjR1SE5ycXVoWTlTWlJ6WTAvYUhwT21jN3Q1R0sybUM4ZFhjc0ox?=
 =?utf-8?B?aUdCVzhRbWZnM0xaZGF4TWhZc0MvWWZNbTJGVUxhT0o4Nm1ZSm85K2lJUWVn?=
 =?utf-8?B?d091Zm1zbjlMSkFDUHVTRTJiSnFPeEE3Kzd1NUhPV1hqOTBQVGRvTG9Pd1pK?=
 =?utf-8?B?bjhiL2NpSjRqb3pPTFY1bWpwOU91cUJpcTVvQXYrSTM3OVNpYUw3OGR2c2Ni?=
 =?utf-8?B?RVBsZHZ6ZlhkYzNiTEt6Zjc5L0c2NjNnUVljN3RZMkNZR2J2N1VPMFBTblU4?=
 =?utf-8?B?UGppNHZqN3JCYUFjcWpkdjhuSldLTldVWWQ2MHBVWXF6SXhWMDZVQ0VHNklW?=
 =?utf-8?B?RnJ2Zm1sTHFTeDVXRCtZYWQvYlBHU1U3WnNiZFhNM3cyRjdBRktOaStPcUl6?=
 =?utf-8?B?Zzh3NzB1NFZoM3F2OURNYW0rUUhxQTh1QTUwYUs0UGxxR044WTlXcGlpemU2?=
 =?utf-8?B?MFZvZmUwYnNYM0ExNDZZTnIvRWhia1lJd0dSYzJSd1pmWGVIZnltMURPL2lU?=
 =?utf-8?B?MDZ1dzBYdEJrWE4rRlIxb29YVXI5T2ozblNEbzRvaXB6dmZQZHUrOFFWdWtB?=
 =?utf-8?B?SDVZcWdaTTdUVVErajB6TDhZaDM0eDM5NFBOcWRUMkZCTElwRXJmZXI0OFRR?=
 =?utf-8?B?NG43b3dyeUdKcVpJK09HdHNMd1dHNUlUeE5FbHpFQncxNkxLZGtvT010VDFQ?=
 =?utf-8?B?VXV4Q1pNcFJROE96MkRSdTlyenJCTGwzaExrWGhiSW5Lcm5wTEEyS25WMkVv?=
 =?utf-8?B?ZE9yWTZiS1dESVlVTE5lNUhUU1NhakJBSkhPdWZCbjRLNjVEMS9vRnhyTEgz?=
 =?utf-8?B?N3BFNHV6NmxmWlErMnJZMTRwb1FxSlF1eGJSb1Q0eFFlaEhJbEx3V2k5aHVn?=
 =?utf-8?B?N2RmN3RnbUY0NEVCOUhkN2ZJNllYRDZGVGcxanQyLys4bm5QaU1pUWVmZnJ4?=
 =?utf-8?B?K2JPd2wwYXpMQ3NEYUtoYjhPSTBDaEM1UHZjam5zQ0FCazlxK3grdVpoSUV0?=
 =?utf-8?B?R0wyVTNZcEp1YXJpRlduU1FrUS9UME9sOWNJS3p6TzRZZzFZbk1kcThjNTRE?=
 =?utf-8?Q?3lK2y50v3JInsoCT0FlgTU0qa87se8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkJFUjNISWZDWWkyMER2QnhVUzEzL21RNC9vYStNNVBwVXhmUThwZU81aWla?=
 =?utf-8?B?ZUZDUmNIZ0xZeXYvMEpiTHd1T1F0dGxIT05UUDkxVDlKdDdvV2JoTFNRVnhz?=
 =?utf-8?B?M1p5N3VFZk5IU1VGK3BYeU5WN3BSMW5GV2tRWmZKSS9TVm05elhaVzJKeWxB?=
 =?utf-8?B?NDZuckVLUnQ2M1NKWm1ra1V4WldCYXFKZmNVK0hMb2ZTOGJCUnRBamQrUTIv?=
 =?utf-8?B?SmYzNGRIb2hZOE01a2ppUFJsVG5iMnpKL0hiZnpnYU93dkx1cHlnWGpidVpF?=
 =?utf-8?B?ZjM5UE14WXNKakFtSHQyMEFhWVJiN2dGYUcwUXk1eUx6blltNXB6R2xKWENw?=
 =?utf-8?B?aDVYRVdYMmlESVZVWXJhWi9KcE5jQ0J2d3U1WUk2d1QxVllPdVI5OG9HQ1pn?=
 =?utf-8?B?aWk2a2RyS29xWG4xT0RUb1RhRlZpU09pY2x0LzhXZE0zbVMrQzN5NGM0V3ZC?=
 =?utf-8?B?a21iN3ZOV0l6cWl1UWZYbzdQclFDVThGdHZWZjVSUk5kVGxEeFRsNloweHJo?=
 =?utf-8?B?aGQybGJ2NmJ1cms2QWEzTGZxeEZGSEdzTVN4eUpBYThjQytoYU91QjNHNVVM?=
 =?utf-8?B?cjJ6TjdiVURtaWdtNUN4TVJDbnN5bWw4RFM5ZVhLdGhxNjhqUzBSRG5HRXlI?=
 =?utf-8?B?YldWT1FDc2ZqZlNTTXVPUXJqUk9mY25pTDBjL3Uxd1A5M0FQT1YvbDBhM25y?=
 =?utf-8?B?UVZ4aHlteHZiMzJ5RW1sZEpaUjJxTlRNMUc4bUVjNWJITi9QYTF0VEtKNGRz?=
 =?utf-8?B?M2ZHSVlxS09jQ0ZFMzJWdkJickl5R0w3Wm1VZDQ5YTkwNXprSnRydlg5aVRI?=
 =?utf-8?B?OExyVG1kVndqc3UwMjhnQzlnV1RqMitkSjhMY2pySUM3MVpBLzF3eE53eUhG?=
 =?utf-8?B?endnd1JxMGpBZTJCajhKb2NtSUt6ZjVxVExKRGFzaCtTNXVxME0xaEw0S2tj?=
 =?utf-8?B?ZkdYdDI0clFuTklQTXBMaksxL2ZiSVZNWkpxRFAxQzZMRXB5bmJpaEZlcjgy?=
 =?utf-8?B?UmFoRFl2enJLMDUzNTd0UURiTFNLdVUrRlRONlgxN3ZldDM1bk9RTEVKUVNU?=
 =?utf-8?B?R0ZaT1hwa0trSUZIaWxxTzNwMWRlM3dRcVF1UzN4Q0FzSFNxYW1kOUtVSWNT?=
 =?utf-8?B?TGV6ajBCeGlsUlFBVUtqTVR4TjZHSHBkZlFEMlBnWklZZVhsRmRIbWQ5Q09K?=
 =?utf-8?B?Q29sdENIREI2RzFud0xRdkg2WVM2TEN6d2lzcmhXMkhDTDhTVnhFSnRnYnlu?=
 =?utf-8?B?VGd3YjVSbmJFbnZ0aWxGamZPejN3bEdqQ2ZKRU4vNzdtZHNWQ3VxSmFCTTdm?=
 =?utf-8?B?SnYzQ1Boci9pdWU4bUl2aW9ocUp6dWNmOVVrQ0ZqY2RaOFkwOVFESGdaWVVa?=
 =?utf-8?B?eFU0ZDA2ZW1FRVpvMWtCMHpKRE1sSmJaeS8vSHJPOFpEaWhlbjkrbVcvS1Fs?=
 =?utf-8?B?ckVTU1R4bVFuNHBDbmdLWFZyTEVUYUVFcXhrNldldzJTekJ5cnIrSU1kSVEy?=
 =?utf-8?B?TVFjN0FIQWpaUzdteXluaDMzTWppRnlyWFVZVCtyaitVMVllR3I3S1JDN0FM?=
 =?utf-8?B?K3ZtcEFYUTZ5SE1kUnRmZWRUYTFyZHZ6V25JV25WZmxjYUR2Vm9WcDZyM2E4?=
 =?utf-8?B?T05kaEMzemxqWDlhSUdPR01UZEhiOHBkbXFJaHNqdmJESEU5bVE3RkgzUk1M?=
 =?utf-8?B?M2JoNlR0RU8xS2JPS2FqZ2NkSWhOYndnUW9MYVNOK3BVSTlhUlQzWDNwWHlZ?=
 =?utf-8?B?eFJxeWQ1bENiTGdqeWFpQmlXTUlqTVBsb3VESGFXSnFwRk5kUEloc1l4UXdv?=
 =?utf-8?B?VEZoTHpCZTFORmxQd255eGNrQ0pvaW16UDkveWpYZ1JkcUplbzEweGRvM3JG?=
 =?utf-8?B?dGZiV2N5aXAzaVdMaVg1d3pQZ1FlMnhTYUVPZmE4MWg3SmV2d2xOSjJOR0ZU?=
 =?utf-8?B?eDhDUVlTaDdxME42UWhlUjBwRWo0c1ArbUxLUjZuUk9oQmQyOVhmdFlFQmpI?=
 =?utf-8?B?bjdUcldVQThiaTBDN1NrQWptcTBramp4MWNHWWhPaU00R3dHdnc5KzZyYldE?=
 =?utf-8?B?Uys5bXIxeGg2S0Vvbnh6UGtTV3pZYWdmUnExWmErRy9LOHhFdk5UQ24wNmli?=
 =?utf-8?Q?Dctc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e834c61f-8557-43af-9a52-08dd98249d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 05:01:57.8020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy6IG8olEYsvJ9Jj8MXw3PIrC8/aF+SxSNQbBK5IhLf6iiJMzfTdlMi/pyBEXw3HMSZxkHGFklcrANHOyisshA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3979
X-Authority-Analysis: v=2.4 cv=SMtCVPvH c=1 sm=1 tr=0 ts=682d5e48 cx=c_pps
 a=nskeBUqQUen4dZUz4TdP1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=4X6ZbWlz5J_TqU7AaH0A:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: anBqMPclR-DTM1yiDsOFiIrOWo-moDZE
X-Proofpoint-GUID: anBqMPclR-DTM1yiDsOFiIrOWo-moDZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA0NyBTYWx0ZWRfX/YDFEpJVTinz
 ndd6UU+2o+28Xzl9mADazwIupbyPMoCy1EsL/E1yuqvUZc+cHJbr1sznyw6x1afttl0XgH5PMNT
 Ld8HBX8fytjwfLnCSjFt4kpMXcNzbAfwC5ZnSD1koRgrTc7opVIZPzggDhW6rxwFbhUt9eqbdkQ
 eJej9SpzjXMlo1g+L651XVNbVnJwj7Gk0L/qx4pnQRIcYs05aM00DibFjGZqLe9DRF8DPKEOkUH
 1b5P+oz9y0i9F29SIG+BWaL+9s0kzxUvdMpHxvxQVLHDWTlksD4Rl6nHxShgxBmGWVAw7TPHkyx
 Q1uJZET/x7R/rkoUs8zQJKn1LkpVHl0yQ/33+PmPCxnCb+rgN/eg6Cea7J2wrKtTbpp97GgeN2o
 QYI5RlSocQOuHzMEFf6mPnsl6ZmCIB/Eel0n67iwGkSy2JSAKcOpQEUUmFD6uvdgpVZ5AUKG
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

PiBPbiBNb24sIDE5IE1heSAyMDI1IDIxOjM2OjU2ICswNTMwDQo+IDxza29yaUBtYXJ2ZWxsLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwu
Y29tPg0KPiA+DQo+ID4gaGRyX2xlbnMgaXMgdXNlZCB0byBtYWludGFpbiBoZWFkZXIgbGVuZ3Ro
cyBhZnRlciBwYXJzaW5nIHBhY2tldHMuDQo+ID4gV2hlbiBwb3J0IHJlY2VpdmVzIGRpZmZlcmVu
dCB0eXBlIG9mIHBhY2tldHMgKHNheSBmaXJzdCBpcyBWWExBTg0KPiA+IHBhY2tldCBhbmQgc2Vj
b25kIGlzIEdSRSBwYWNrZXQpLg0KPiA+DQo+ID4gRm9yIGZpcnN0IHBhY2tldCwgTDIvTDMvTDQg
bGVuZ3RocyBhcmUgc2V0IGZvciBpbm5lciBhbmQgb3V0ZXIgaGVhZGVyDQo+ID4gYWxvbmd3aXRo
IHR1bm5lbF9sZW4uDQo+ID4NCj4gPiBOb3cgZm9yIHNlY29uZCBwYWNrZXQsIHR1bm5lbF9sZW4g
aXMgYWRkZWQgbW9yZSB0aGFuIGl0cyBzaXplIGl0DQo+ID4gY29udGFpbnMgc3RhbGUgdmFsdWUg
d2hpY2ggZnVydGhlciBsZWFkcyB0byB3cm9uZyBoZWFkZXIgcG9pbnRlcnMuDQo+ID4NCj4gPiBI
ZW5jZSBjbGVhcmluZyBzdGFsZSBpbmZvcm1hdGlvbiBiZWZvcmUgcHJvY2Vzc2luZyBlYWNoIHBh
Y2tldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1h
cnZlbGwuY29tPg0KPiANCj4gVGhlIGluaXRpYWxpemF0aW9uIG9mIGhkcl9sZW5zIHRoZW4gYmVj
b21lcyByZWR1bmRhbnQuDQo+IA0KPiBNYXliZSBiZXR0ZXIgdG8ganVzdCBtb3ZlIGl0IGludG8g
dGhlIGxvb3AuDQo+IA0KWWVzLCB0aGF0IHdpbGwgbm90IG1ha2UgYW55IGRpZmZlcmVuY2UuIEkg
d2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uLg0K
