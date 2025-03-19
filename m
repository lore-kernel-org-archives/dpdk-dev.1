Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED24C36000
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 11:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5BA7402C4;
	Wed, 19 Mar 2025 12:10:41 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DDDE94026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 12:10:39 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J9AaTT022947;
 Wed, 19 Mar 2025 04:10:36 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45fu2fr8ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Mar 2025 04:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuH3g0VO7hHh6jEa3TsACP1MD/4K0HezP3AlOIeUJNcszh9rcBeQpG3feXAnrcvNKRgcctKRiDI8zl7fUq+tIw1wR7RlTDqTyS35u06YKCU6W40goxGYsK/aAE1Q1U0CCszJHjk6gJy67TVVHmFN/xiikDFA13xTOZSjLhba7gWyB9jrFCcgK31mXthOo9o2Wsw5JnFvZ67m+rrrIFaAG3BTOAZhDIsnwcxAJ0SqOMmcOdX7z/82hMx2Vn7x82Ttn3YZbc9mEq6mPi8EFRvS7N4V2vjsMun5hHY5v21ObfLYvbBhSF2FFDhxYv7Pv5dtC1GBtNTiRlbL8rdiE3cdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NVyhelrBDKoQhpIdYEtD2DMIiKGJ/yVF5vCpLGfUaU=;
 b=iqlAv+yCHOCUychULWW7dhWvSN8bEeqKQ9o/E3aY/9bUV9HZA60CmvehKqisFH/KjAtDZhFwmCcV33gIs7SovkImdS17iOJbbugO3b1XP8yAb7mvxcU3DKpUpeEBRMdyNlSYNie44u/WVJgo4OwZjiKgVlu9VTG8yOCR6ZwY6r1uUUoTgo2gvj477LqecFdz6oeTfGrZQF3lGMYoDhfCmJ1KY86dm78y4WDnx/qcmdaNoiRUStI53PsJJAb66q+5CuirkQvwQZeEIXsm1ukJVH23YD4g+guTGNdfVmCHt9e2ILjsxohn13Sy3XQtDf2XKmTMd3l17J/jwBXjopfNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NVyhelrBDKoQhpIdYEtD2DMIiKGJ/yVF5vCpLGfUaU=;
 b=L+c//RqqHWPVlLKZuDQxyLflbP2oXweAZnJW59ahitMTlXHjkh+N3NNSOWjxBqxRPMNREIt0F+l1mVDkI+R5Rkh488Nuc0uB71qLp78Hu6srTw48xAcLbgolWuFwOFPIto8H3RXehIw+VxPYakFKHx7hcNUXrcJ/Cqdzyp4G8ms=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 PH3PPF874F5ADEC.namprd18.prod.outlook.com (2603:10b6:518:1::cac) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 11:10:34 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 11:10:34 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Gregory Etelson
 <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "mkashani@nvidia.com" <mkashani@nvidia.com>, "rasland@nvidia.com"
 <rasland@nvidia.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] config/arm: fix meson for native instruction
 set Arm CPUs
Thread-Topic: [EXTERNAL] [PATCH] config/arm: fix meson for native instruction
 set Arm CPUs
Thread-Index: AQHbmLlFmasjgL5a60i2rIlQTycwS7N6SiXwgAADIxA=
Date: Wed, 19 Mar 2025 11:10:34 +0000
Message-ID: <PH0PR18MB4086C3FC869C820807A4FA67DED92@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250319102505.596678-1-getelson@nvidia.com>
 <PH0PR18MB4086559122474B889285A20FDED92@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB4086559122474B889285A20FDED92@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|PH3PPF874F5ADEC:EE_
x-ms-office365-filtering-correlation-id: 7a1f3ede-01fc-486f-2962-08dd66d6ab6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDRwa2ZNQUhjOG5FdU42WFlmRnZaRlpObi9BUndIdTQrK1hyNXN3Ti9ZM3Rq?=
 =?utf-8?B?WDdOWUo4UEE1c2VvNnlUYzVCK3IyVmVYd25Bd3pSazlDSjlkbnNacmFXK09Y?=
 =?utf-8?B?WHpwNkgrV2o0cTVPOG1RMDJPV2lvcmhIbEw5bjlTb3E0d29DSDBSbGM3ZVRP?=
 =?utf-8?B?SzNFYkJpRVF4TkI3NzN2YlY5SXRwM0JBdVl3WTdXcHpoNjZ4TjBvKzYxZ3U1?=
 =?utf-8?B?U3hLMlpQV21uS0VzNW1URDFnRThlNWprdVEySUNzb3EzdDE1aHowdkdvb3Z1?=
 =?utf-8?B?QmtGb3ZveWIvczdlMzkybjc5Z2Nid1pYQ0FFMElhemR1M0JTdjMxVkxuVG9R?=
 =?utf-8?B?K0NzNVJVRC9CS3d2SjhVbUpTOEsvTXpEemIzVzZCeUlPVkc0eWRCbndubEZj?=
 =?utf-8?B?M3FpYVQzWmV2d1RJbThvdE1vZXZSS1l1RGRyL2FCeVlLd3FSRVdiQjgwSFdG?=
 =?utf-8?B?cVV2bWpvVzdJYk1QUmZMRDFKUEtraXJ6QmF0VEthVlp0MjM4Q1RBQzJMcVhE?=
 =?utf-8?B?OVZybFJKbjFrMDhTYUxhS0U5cDA5RExXMHZ0VWR6U2tHRnFUMXo2UFE5TXhi?=
 =?utf-8?B?dHkzUXIvZnVGZFZDSlpscGROQjZHZGlYTzVQdFNJWjhEeHRaVUhHbGxJK2RP?=
 =?utf-8?B?OXErNGc0czdMd2FhSlhLSHVXcStLbXI4dGtWM0hZVUlPZHRSTFJyZnh0V2Nn?=
 =?utf-8?B?NE5kci85Y0tJcmhNdGhUTzdPa3VHMzltU3ZWZlJxcUFTcmdYejJDbzlIWU1y?=
 =?utf-8?B?MWdhclArU1MzSmc2ajM4VnRDNnY1TjB5S1h0VDRUY21WT3BESjcycW8zV1hq?=
 =?utf-8?B?b3dsUjNPdWxjUnUwWEorTVorWUc5SFVQYzNyRjFYMGVZVFFCSmRmMS8vMEZr?=
 =?utf-8?B?WmVlQ005cDdBYmQyKy8xVmIwb21aRFlDYXRIWTlIOURwWmtGc0l6M1JNYVF1?=
 =?utf-8?B?bXBtanUxYk1Id2cySERYN1podmVBSnFQRzRCTkhuY1dlVFR3UUhKQXpVTWw2?=
 =?utf-8?B?eTAvSjB2elduN2tBaWtQNHhTdWhaVFVoanJPNlpsT25mUFNLb0dxalN4M0gx?=
 =?utf-8?B?OGhkejNVcTBCbWJPYWZLazZacVVNSXJQOEFEdjVGTlE1ZWpSL1lQQU5lUHZv?=
 =?utf-8?B?NGFXR05SK2FRVVRJL0NGMk1RRFFoblRTTXRVcmVXdmw0R2pjSmV2S1drdHB5?=
 =?utf-8?B?YWhZUXB4cWxBdTY1SDRvQnlsYVRxYUh5TnM3d0pXUTc4MXNvV1F6ZGQ3MzJU?=
 =?utf-8?B?SzRmK3pzV1VMYXdtZDJlSFVkbDhxOTJHS25EdWZhS2NZVXB6bzE2TWw3REZq?=
 =?utf-8?B?TGMrYWlTYjAyd09NVWJMSDl1MjBoYWJaQUVaRTU0a1Z5K1NCVXJtZHV5a00z?=
 =?utf-8?B?dmthOWdNaS9MTmkyWEtmVHlnVGtWUVZ3Zmg2alZwYm5SbXgxdkJRWkZkaC9Q?=
 =?utf-8?B?bDZvOHdRcWs5NDRMbWkrSkUxeHdIa1VVbmFleFBJTm1ZdVY1WmI4ZFlsaWF1?=
 =?utf-8?B?L2NYK01WSGNJdHl5eHVoT3ByOGFZREVKdEZNeGx0YUxza2hGQjgwb01BUmZC?=
 =?utf-8?B?TEZUVjdEQk91WmlyWWRsdmxsc1FNQzN3eXMyRWhTbzdqYXpqaG9INWY3Ny95?=
 =?utf-8?B?b3NNcjBWVllucHJVRElZNG54SE5WbGU2Um5xMFlURVBLSVZENU9jYXJqZzlO?=
 =?utf-8?B?Wm1tTEF6enp4dENXdHZZamJxNWRwZzc5b29lemI3UGU5ZS9IYzFzUnhqMHhC?=
 =?utf-8?B?blJZY3pUOCtuNUtodE43M3d3OVN0QlpibGMrRE8yZ2RkRHc0UmtoTTdDby94?=
 =?utf-8?B?QWl6RWhqa3dKM2N1bkRqREM0QUxUcm5WeU91bUNlWFREaHdsV1FQV2RGRDZt?=
 =?utf-8?B?SW5TRDJ4SW0yVXdWNWpZbVpURFJqbTczNmxrMU9pMzhnZnU0UW90S3UrcVIy?=
 =?utf-8?Q?hDsmtZTC4MatGCNHFbrlDFfocpBhtzF8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WC8xNVJoK0FCNld2emE0WVJOVzFlRXhKNkRZWWo0YnBPT1o5Vi95Y1JpUUJn?=
 =?utf-8?B?OFpLSldPVXZodEZFWWtpODd4M0dySkszU3p2NkdBNkplUW5CYzlvSTRBTks2?=
 =?utf-8?B?TndZbDN2NktCekh5bG81L3hZZUJrSjlVaEhZd0JBRkJtR09WWURHYWJKZWdF?=
 =?utf-8?B?K052aEdMNWdkb25seEJyTy9zNWM3UlNuVkhXc1JlUGNCSEhINkczMFhtWksy?=
 =?utf-8?B?UTZ6bzgyemlCdWtha3g3WTJhbzZpRzh3alJNL2N6Wlg3cHEzd3ZYZkVUOFRr?=
 =?utf-8?B?Q01UMko4bklpWDBRRGd4RGUrQzREU09HTzFnMU16UUVvZEVGNGM0N1ZOenNt?=
 =?utf-8?B?QlFIV3M4V1MxejRMb0ZzL3BjMjROZlo2dU8xVXZxeW8zSHJ5YVhyOEJuTU5U?=
 =?utf-8?B?MVZQL0FQazBGSnJBY0FSTXdYb3FveUZRd1pVU3drYjNhTkk3R0lZcWprdnlD?=
 =?utf-8?B?S1JHdFFhQ0JPVlkrUWR4ZUdQb051VzJQQ293RWJ3eGhnRHdYc3plalFuYUtU?=
 =?utf-8?B?VHhlZ05PcThVSHQ1S1FhUDBJQk8zVXVoOXFFU1lCSXpqYlV2Tzg0ZUZvRXhM?=
 =?utf-8?B?K2pXQ2VnZlh0dGRydkhrTk12a1pHcVhEN2t0RGJIcHNHUWtrdGtScUZ4Y2Jy?=
 =?utf-8?B?NHdjTDdWNEhmUnpMUU1oaUFmOW9TOWdGVXJ3Mi9FUzJ6bU1PRlZsZEtPU1ZW?=
 =?utf-8?B?bEhGV0x1TXpoV3FOT3ZCYVRVZDlFQzlad1cxMXRnNGFnV1BCcy9lcVRvLy9z?=
 =?utf-8?B?SVBSNDJRaUtsd2Vqc0srbWthMjNIRVhMMlhXRmMwOGs0dTF6cFpEeFJXR0FU?=
 =?utf-8?B?Y1IybjFlZU02TUNQOTE4WjNiZXp3elFBWHBVNko1MkNGOFlwMENMMGxBZDB2?=
 =?utf-8?B?SXI1OXNuYThMa01NMkxib0hlcFh1MWl2QUZSY2M2cmdNM1BWWElidDB6MUx1?=
 =?utf-8?B?cnh4bjV2V3JHeVB2QXVuRGdhQkdHRkVTc1BqMncrSkdCMFora1ZQbzFWVWhl?=
 =?utf-8?B?Z21TQkkvZjdremUya1AraWx4N1VlbzZIVUZ2Tm5RU3NoK2VCcnBqQXRXbGRq?=
 =?utf-8?B?NVM1MlUwVUtjWnNGZU1McWNiSTBPZWJYZHQrNHdMaDQ0UUNMaGcrMHVKWDlU?=
 =?utf-8?B?VGY1SktWR3BtZVI5RnJhU0hsZkdFOGsvcVhSQzluVTFDaWxHSHptcXV3SGZy?=
 =?utf-8?B?LzRjL2didmZTR1Zmb2FOQVBydFJsaHRpMjhKK1FYQlhVSzVMVDVWa25KUTFV?=
 =?utf-8?B?Z1JIYWJUczdoQUxtbFBCOEhPVzBMSjRpeTJ2T3RPWWlJY0dhdVk4Z3F5QzdQ?=
 =?utf-8?B?YlZWcEZsOVZFaWxrL2ticllVQ3N4YUxZK09hbmM1ZlF4TkdKWjg0VnowK0l0?=
 =?utf-8?B?a21jMjFOZi83YmtUZG5YZUpFQUE2bnRlQ2hFMVl6TzlOaklUU0Y0Z2JRbFJY?=
 =?utf-8?B?Ujd2SERiQUZRMXBzbndoTi9mZUdud0RaNlduK0FISVU5dm1BSCsxYUpOd3ha?=
 =?utf-8?B?Tzh2OXZrMEVmampaTE9BdUUrcWRpSXlnUzhrZmVPWUFVc1kvVzlYVzIvWEJa?=
 =?utf-8?B?NlRFUjVqeldnd0ZhTGlZZ2oyWWFXakZJQjIvcnhaRFVqVjY4WHZQa3BoaGNp?=
 =?utf-8?B?QXFEZUh6Q05HcEduRXhrRjhrOVAzWFZVa1dlRVVnSFVIZitva2IrZ1RFY29t?=
 =?utf-8?B?WG9VTnJtRk9obVJ6VnVHZndYdXlUNjJnRllxeWdEV3h6SXQyTHBITi84RVdO?=
 =?utf-8?B?UmtGVkhveStaZW9xTExueFljd25WWE44SVRzdmFRd2w5QjQ1NmZxeTlnNmo4?=
 =?utf-8?B?UGJEUmFSNzNiVGxwSVdIWnpZZWh4M2JxemZrQjFpakgvQm1xZkhLZnZlVVpu?=
 =?utf-8?B?cnM1SmZ0NXhRVkxWWUwya1Q3cjVya2F5N3o4MHJTYy9ocFgrSTBmQWhESU83?=
 =?utf-8?B?VllEZzdXdWRmU0h6SE5vUHBVV084Y2tEYkFHOTV1Z0hmdWJURHR5ZjFtWk5I?=
 =?utf-8?B?YXpjYXYwOFRZSnNCd1BXamp6MlNxeGg1cC90QmtGdU9DSllhZzlKSzd1czJ4?=
 =?utf-8?B?Sk1ObWdyVGQvQzNlZSt5MWNJOGl1NVVKbEdlOG5QVFpsejVPeCtqWjd3YllW?=
 =?utf-8?Q?FM0CKwKfcHnZT6PpCK7doyU5M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1f3ede-01fc-486f-2962-08dd66d6ab6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 11:10:34.1050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZV6u5G9Es6fEjB546PMyICnfxXTT9cF2kg9n7qX9dYpaI1MW+4xiDTuSapVR0MVKs34o0+yDiQai10f7ii68GULm1+1bcce1zj16ECNRoOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF874F5ADEC
X-Authority-Analysis: v=2.4 cv=IZaHWXqa c=1 sm=1 tr=0 ts=67daa62c cx=c_pps
 a=ur2hu7Zt/Tb0cWAHmjvzJg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=Ikd4Dj_1AAAA:8
 a=M5GUcnROAAAA:8 a=P3ePHmHgUzJ7PYV00MMA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mDR7rvFtQ-5uCnJ4ybEV5x-H0DWPm64N
X-Proofpoint-ORIG-GUID: mDR7rvFtQ-5uCnJ4ybEV5x-H0DWPm64N
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

PiBIaSBHcmVnb3J5LA0KPiANCj4gPiBBcm0gbWVzb24uYnVpbGQgdW5jb25kaXRpb25hbGx5IHJl
bGF5cyBvbiB0aGUgYGV4dHJhX2ZlYXR1cmVzYA0KPiA+IG1lbWJlciBvZiBTb0MgY29uZmlndXJh
dGlvbi4NCj4gPg0KPiA+IFNvQyBkaWN0aW9uYXJ5IGlzIHBvcHVsYXRlZCBmb3IgQXJtIENQVXMg
d2l0aCBnZW5lcmljIGluc3RydWN0aW9uIHNldA0KPiA+IG9ubHkuDQo+ID4gRm9yIEFybSBDUFVz
IHdpdGggbmF0aXZlIENQVSBpbnN0cnVjdGlvbiBzZXQgdGhlIFNvQyBkaWN0aW9uYXJ5IGlzDQo+
ID4gZW1wdHkuDQo+ID4NCj4gPiBtZXNvbiBzZXR1cCBmYWlsZWQgZm9yIHRoZSBCbHVlRmllbGQt
MyBiZWNhdXNlIGl0IGJlbG9uZ3MgdG8NCj4gPiB0aGUgbmF0aXZlIEFybSBDUFUgaW5zdHJ1Y3Rp
b24gc2V0Lg0KPiA+DQo+ID4gVGhlIHBhdGNoIGFkZHMgZ2xvYmFsIGRlZmluaXRpb24gZm9yIGV4
dHJhX2ZlYXR1cmVzLg0KPiA+DQo+ID4gRml4ZXM6IDc4Mjk3NzZkMGFiZiAoImNvbmZpZy9hcm06
IGFkZCBleHRyYSAtbWFyY2ggZmVhdHVyZXMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEdyZWdvcnkg
RXRlbHNvbiA8Z2V0ZWxzb25AbnZpZGlhLmNvbT4NCg0KQWNrZWQtYnk6IFBhdmFuIE5pa2hpbGVz
aCA8cGJoYWdhdmF0dWxhQG1hcnZlbGwuY29tPg0KDQo+ID4gLS0tDQo+ID4gIGNvbmZpZy9hcm0v
bWVzb24uYnVpbGQgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvY29uZmlnL2FybS9tZXNvbi5idWlsZCBiL2NvbmZpZy9hcm0v
bWVzb24uYnVpbGQNCj4gPiBpbmRleCBhOTdhMjhlYmI3Li5mOTcxZWQzYzFiIDEwMDY0NA0KPiA+
IC0tLSBhL2NvbmZpZy9hcm0vbWVzb24uYnVpbGQNCj4gPiArKysgYi9jb25maWcvYXJtL21lc29u
LmJ1aWxkDQo+ID4gQEAgLTc2Nyw2ICs3NjcsNyBAQCBkcGRrX2NvbmYuc2V0KCdSVEVfRk9SQ0Vf
SU5UUklOU0lDUycsIDEpDQo+ID4NCj4gPiAgdXBkYXRlX2ZsYWdzID0gZmFsc2UNCj4gPiAgc29j
X2ZsYWdzID0gW10NCj4gPiArZXh0cmFfZmVhdHVyZXMgPSBbXQ0KPiANCg0KSSByZS1jaGVja2Vk
IHdpdGggYXJtNjQgbmF0aXZlIGNvbXBpbGF0aW9uIGFuZCBzZWUgdGhlIGlzc3VlLg0KDQpUaGFu
a3MsIA0KUGF2YW4uDQoNCj4gV2UgZG8gc2V0IHRoZSBkZWZhdWx0IHRvIGJlIFtdIHdoZW4gZXh0
cmFfbWFyY2hfZmVhdHVyZXMgaXMgbm90IGZvdW5kDQo+IEluIHNvY19jb25maWcuDQo+IA0KPiBl
eHRyYV9mZWF0dXJlcyA9IHNvY19jb25maWcuZ2V0KCdleHRyYV9tYXJjaF9mZWF0dXJlcycsIFtd
KQ0KPiANCj4gSSBoYXZlIHRlc3RlZCBjcm9zcyBidWlsZFsxXSBvZiBibHVlZmllbGQzIHdpdGgg
IGJvdGggbWVzb24gMS43LjAgYW5kIDAuNjEuMg0KPiBhbmQgZGlkbuKAmXQgc2VlIGFueSBmYWls
dXJlIHdoaWNoIHZlcnNpb24gb2YgbWVzb24gYXJlIHlvdSB1c2luZz8NCj4gDQo+IFsxXW1lc29u
IGJ1aWxkIC0tY3Jvc3MtZmlsZSBjb25maWcvYXJtL2FybTY0X2JsdWVmaWVsZDNfbGludXhfZ2Nj
DQo+IA0KPiBUaGFua3MsDQo+IFBhdmFuLg0KPiANCj4gDQo+ID4gIGlmIGRwZGtfY29uZi5nZXQo
J1JURV9BUkNIXzMyJykNCj4gPiAgICAgICMgMzItYml0IGJ1aWxkDQo+ID4gICAgICBkcGRrX2Nv
bmYuc2V0KCdSVEVfQ0FDSEVfTElORV9TSVpFJywgNjQpDQo+ID4gLS0NCj4gPiAyLjQ1LjINCg0K
