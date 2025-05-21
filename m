Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBBC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 10:49:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3BC0427A1;
	Wed, 21 May 2025 12:49:19 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 640EB4065D
 for <dev@dpdk.org>; Wed, 21 May 2025 12:49:17 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9qnm2012831;
 Wed, 21 May 2025 03:49:16 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc91nt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 03:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVzU2YxT1m6w+ZzH1w3UdSWpVf928Kz9egWojVuc9QIx6ffGGJ4G+NL4EfGQasyLZUIAeHArX0hdui8lDIghdMINxAA4EjnTc6MtfhVWpPYl7r8X6I5xGHu4ksYh1cJFE3X9Lf4/Vwys7U2M/xP6s2iXr3u+GaAFru9VsdD1x7I0jZ0r4lq7V6FdY1eQizexW1K/lfO39jhINS+MvVp5pL033zZ2cS/bsEq6RuBayfmmuBg/RFUoeoHOSGxL3VfbDy6rLp1S3Bg18aC7wI386xV1YrjZILShy17IAkkObCy1MhvKAjGL4+kBC4/Uvt/A4Z2ZbKM5Kd35mfBJ1osS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyoN3Tmait8M5dyAL1sZ2EtuN6eMNdtQ3D1GJrJdcDo=;
 b=jeMaIs7qHU/7Lqz6kewfEWe8fKXFGfCJgMw6TwVzkPNGqTxRipj/0ml+ZHfuYrPjVsvhDBu2I70UtAgnMDJIQfSR17qPHDxe3zKjfHgKnDK00XYUNJfUjwIJUUVlalFRJ/ILL6GnDGmJgwx1TPSWZc7Yo1q7z24pMrUhemCRYbk0nbMJ6UHH54zjL6PWtXA/ydjvWr0bMe+csyC5rx5p2W928eZ850w4HaEtAovfjSpBYZ8LuLyd6B4pglyXzIA0PHqK4UM26fbQZLxE/E1BZqnEXjlFyvjHjfmnvMublIKBgPSq4/l62g7g1UTGLHdknkQ66MMeU34cMU++mr1IyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyoN3Tmait8M5dyAL1sZ2EtuN6eMNdtQ3D1GJrJdcDo=;
 b=T/TUXaVCb9Oc/4E3uFlp8r16cbi3cYyOc0mvuDgWCpHe4+sE6lR8NPyaaFJmGCtUinTmutrMWf9/BFKp4hHHg6qJFIRW8zuvNCdj2ArwECpHe6z2CaUSkwepIKhUQGMSt0TwCBdNF+QDiCn1lAyqMwqfNz2oObiq9BFOP7EMroU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA0PPFC4D2A1900.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c3e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 21 May
 2025 10:49:13 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 10:49:13 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/qat: fix out-of-place chain, cipher and
 auth headers
Thread-Topic: [EXTERNAL] [PATCH] crypto/qat: fix out-of-place chain, cipher
 and auth headers
Thread-Index: AQHbuAcWIKeeMqlPH0C274d3Wmv/8bPdC7JQ
Date: Wed, 21 May 2025 10:49:13 +0000
Message-ID: <CO6PR18MB448472FDA4CE4D319DC13C16D89EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250428063041.2038193-1-arkadiuszx.kusztal@intel.com>
In-Reply-To: <20250428063041.2038193-1-arkadiuszx.kusztal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA0PPFC4D2A1900:EE_
x-ms-office365-filtering-correlation-id: df6e756b-76bf-47aa-9dbf-08dd98552027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cG5jbHFiQUlwclVsMXdNZitkRG9UaE5naG8wQU9hNWJ4NkRZc1dmL1JISjh3?=
 =?utf-8?B?bHF2ci9BVTlaZTBmb1dkNC83N2tYRG0weW81dnUwdTVMby94YXd2MVRBV1Z6?=
 =?utf-8?B?L3U4UkI2clNhME5rMDBON0V2ZzEyd0VoREJCNmEwNlhsR3hmTUdIQ0ZacXVi?=
 =?utf-8?B?ekJBTjNPMEEvTER0K25iZWdqUm51YzZrR0NUU0VDT3k0MnN3NUF1aWVWYnBa?=
 =?utf-8?B?Mm9lb0t4QVZNeThqbGw2amt2c1NmcDdKanlqV00zeDR1WkJSRHRBUUxaNCtw?=
 =?utf-8?B?bzdDQkhsbGNSRlJXY0Urd2F1ZTR5aGdPem1OT0NwZDEzUXk3ZWNEWW5ya3ZC?=
 =?utf-8?B?UGx2RWpaWXFmc0NTUjdTeHF1NklMY1oxUnBkUmF4Z0M3SnRSY1UvajIvZHAv?=
 =?utf-8?B?cXE3V2laTXlNUjRPV0xPRmxRTTlzRkhxYndwYTNaeFAxS2tzdDBxMzJNZnh4?=
 =?utf-8?B?elF2TXRtdjNqNFgzYXdrYUhUcXhmVlBoSkU5OVUyZnMwZWphenl1a2E3K2F1?=
 =?utf-8?B?aXRhSTEyNDRZbmg5MTlRVC9XZ0EyM1JyV1lCeXBEUEduMFZmRDhtK3VFUFFE?=
 =?utf-8?B?Z1JlOXltazV5MGNzNVZtSElwZER6MzN2Tk16MzZsdzJkM3hEVVgyeEYwbEd6?=
 =?utf-8?B?MDdHZ3pGV2s3NExsMzhudXJuOUdkZlFwMjRiM3FLbUpPNVZvWkVuKzBtUldK?=
 =?utf-8?B?NFQ5SFVabzljRVRyc2RHV3laTDE5K3paRXBKT3Q0azVNU1Y0RVdFa2xEd1Bl?=
 =?utf-8?B?WlFnVm1aSlplcFN4V2xqQ0ZsK1UrN1RueUlrcG8xZ0I4bHpCdjNFVHFRMHE4?=
 =?utf-8?B?YTdRc1U3SXJOeGNYUWE4aVhvczNLRWFxNmdpdGg4M3JFQ1drWkExUkoxWkpK?=
 =?utf-8?B?U0U5NjkxUmhQd0JQRHdSV2RNd2tPMW9wdlhMR2R6dXh5djhXNlJLcGtMWFVR?=
 =?utf-8?B?S004aTBsWDNibmJOU1pZRmtES3dGa3RWT3ViWVF4ZTVMK1RQODBMOWRnT2gv?=
 =?utf-8?B?SkJoNHJTamlqWm5MK0xNUVM3eTVsYW1yU3RiTlhXNndvVVFpN0xFNzJTTkN4?=
 =?utf-8?B?M3RVQVhwMitBbkRCN2c0T2RtdlZmbGgwaDkyUmdmUUlhTHRTc3hFcDVqUk1i?=
 =?utf-8?B?azd5ZmJkRktvdmkwdU1NMk00NVFFSkxqWHNsckFQUCtIeFk5b0pxSzlrc3Zs?=
 =?utf-8?B?NVFEOFl6MmxiVTJydmFjUXdCUUJJUFVuUStpaDZBSmpzZzJWV2kzSitsRXlr?=
 =?utf-8?B?cFh3WFQ1enVvZ1NoeTNoeHR5TXhWUWh5Z1VQc2hEZXdiWGllbmNyRUNNOU96?=
 =?utf-8?B?TXN0dHB5TVJQclpKN0xMLzFMWVVTR28ySllpdDRBcVRiZktOdzhZVEFEaU1j?=
 =?utf-8?B?dXhuZVdoN3FNaEp6MTk1dXhQcFFsZTY0SW5iblpocmZ4QlZIZFpmS1NJZU1k?=
 =?utf-8?B?TmdrYlhmNkt4Wk53eXMyaTE4dmt1TDFRbHdvamNwZHhKdjNGMXZuc05tTW9a?=
 =?utf-8?B?RmlBcjM1MDNqVWZ3azBlS3oyMVp1akVpNnVwU09FajBMdHpmbDNWNjNhMFRy?=
 =?utf-8?B?L25nYS8yQ0gyYTgvWVZoaWJxODM2eE1BbWNvZGZUODRBU1NjR3hhajRUcXAy?=
 =?utf-8?B?Tk1jTnpyN09aanpqZUhiYmNqZkpHYk12UDhZQkl1SUVPOHp2RTdEazJQWktI?=
 =?utf-8?B?ZXkrSVEyNURTWEhTOGE1SGpwMnZ4ZG1GVVNKOFJIdXZmcExFTXNPZVZ3YmJO?=
 =?utf-8?B?ODA4eEMwL3UvWlpSUGd5QTBza0U2VHJGVEg3cVBteEZtdXJvWmo0NXV5SDZK?=
 =?utf-8?B?SHVkNGNPaGdhMlBMTnduUVNkbGJhYStnd211dDRBeXhDYXpCVmppSk5DakZp?=
 =?utf-8?B?WEUxNGhBQlJCczJLaFRaZSt4eC9sekU3aW8weFBSTG14UzRBVXFGazl5c1BZ?=
 =?utf-8?B?YStIMW4zVXFxRStIRWFGUkgrRlI0NlBGQ015UVdqTzIwYnh0TERHem5McE9C?=
 =?utf-8?Q?TW66/sD2ijgyabso1RHNNbbiPTV/To=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVFmdFBwOVNkeVFDc1Nqa01JdVJCZXpId3N0eUxtL29wQ295OTVsRGRaL2V2?=
 =?utf-8?B?d3hoUXc1SEVJbVlGZG5UZk5zS3ZpY0RySGFYbzJOblF6a0V4UlBxRzd4S0FQ?=
 =?utf-8?B?TEp6aGk1UFRWRm1iZ2lXNDlxREQweHVKOUp4WEFZbnAzUmh1bEszZFZkeFJZ?=
 =?utf-8?B?bHZJMEUwQXV4YjVFdHRZa0o1dlI5VVkwMFBQTGtrWEFYODJSamEzVkRUQnhi?=
 =?utf-8?B?ZW9iM1lyVFlZb1c2aWJxZm1rNmFIOW5SalF4UDVyZG5KNkJ4Tm5VVlJIMnVr?=
 =?utf-8?B?K2JNR3V5V1VmSnJCZTRRTXFjR2JDbWZDcGd3VXE3T29SMzU2cUdUZk81TFhV?=
 =?utf-8?B?M3BqRVMxYjgyOUJUa2RuZGJXMzZ1azlvYlhQeXNBNUF1bVZDaWYvOWdwVVZP?=
 =?utf-8?B?ZituZ1BuNlFGSm43blZLeVl0QXVua0VXR0NmT3hzb3oyVUljSXV0Vnc4SnMy?=
 =?utf-8?B?SG9sTFdBdVhkRGJhTUNrLzFxaHgwNy9qY0tZWVp1Nzk0M1NhQkRyNXUwOGlU?=
 =?utf-8?B?Z3VUcmJUMXBFQitrVHF4a29ONVRsWE5TSGt6RzlXNE9OWE5PcGZoekVxQ0di?=
 =?utf-8?B?YWoyTzhtcEJvWnk5RVY0bmlTVTBybmFBMDMvZWJKN3dPSlB0QWFqdGh2QU5C?=
 =?utf-8?B?eHRnYUVGL1NoelRmU3VoMlQ1b0N2L3lINkkrQUJjL1B4YVlyazdhNitJeU82?=
 =?utf-8?B?MXAyeWZ6Y1EyYkR5b0ZyYVAvSG1WbFdkLzZmMVQxK2pRQzBFUlZobUQxMzZz?=
 =?utf-8?B?NzdQZUswSFZmU0JNL21ZVmpIWllSdWlvV1RzS2ErY0RaTGJlL3dlckdFVnZP?=
 =?utf-8?B?a3F1QVRqSW9VZFhmTnFGWWp6UUdERHNqQ092TXFub2lSak1UQ3Z5M1BlRXNk?=
 =?utf-8?B?dWdQcnJ6QTI4K1hUOFlENUNEOTBDWE1qV0lRdFlZUHFtN2RFT29veDRNcVJ1?=
 =?utf-8?B?ejZGSXJWMXpobzlOUklPc2FqOWp1NitWQit0WDQwa1FSRTRBUytYcjZ1YVNm?=
 =?utf-8?B?dnM5V0ZMTnZVZms4ZXVPQjh3VzJVR1lvd3pFUHJFUURkY2NDOFRaaHVpRnFM?=
 =?utf-8?B?NkNab3ljWHJNNSt4emhWS21hRnJac2N3Z28wMkp1dGZFZ3NJTWlMZW95cS9X?=
 =?utf-8?B?UFRNa3cyWU40b2puVndSbDRmQVdZUzJwTUpQamNRMzY4Q2dDYUsraDZBSzRh?=
 =?utf-8?B?Vkx3MUx3RkkrdlBsdlhsdFgyUFFSdVErZHY1NmtjemJhUXc2WW9jWTQwcEFo?=
 =?utf-8?B?bkIweVRYYngwVG0wYnJPZ1dqSkZabEEwOHlFT1Q1cDNGczdnRkVRaGFMRXB3?=
 =?utf-8?B?UmlpRFIzSkNJeUZ3eXNiVVZFbTB2WlhDZlFFbnRleWdaSFNENEtPdStJcFpS?=
 =?utf-8?B?bjNrTGgvcHN2QjB6dXQyQkxwWHJFWjRpd1JoMWZnM0hLd2xHeDR0WVJhVEQ0?=
 =?utf-8?B?YmEzT1BLM3lkNGtSZldCditLcWhUTytmcWgvQjlLQ1ZXWWNwd1NKQmdiSyty?=
 =?utf-8?B?TFpnaktFRzB0RGVPM2hYVU82Y3B3Z1dDTkt1MWhYYkxoWkJ6OW92cVR2TFVr?=
 =?utf-8?B?M2ViMmh1VU9SZW5MMnhBRCs5TE44SEQvWTJucnp3RXZQSWxEZnYrRyt5dmRn?=
 =?utf-8?B?WWxUR2pVckE3TGM3UkllL1NQLzVTSE9JUDRMU0t6YUFlNE5DdjBWdUppaHc4?=
 =?utf-8?B?ZTJ6eTZsWmhsZTdMN1p0QUJUYUVkdTVkcVhCeVpvdTNoSVp2SGNmTWhyMFJi?=
 =?utf-8?B?QmEwcW9VNlhGcXZrOXdxTmxIc0xscy9XSzhTbDZYT2Z3U2cxSlI0R1VIdHdi?=
 =?utf-8?B?S0xaU1dNSTVOdGc2dk1DMy8vS1FnWnppN0ZHVmMyNUgwbzhRaWVqN3AyU0Na?=
 =?utf-8?B?OVQ0elZYTVdleWJmQlZEZWNoNFoxbGtVYVBqdHpOa24rNmhvN0ZHN2hYanhq?=
 =?utf-8?B?b0x3eGxhWk01TERSaks4N2htWTk0RUJ6RVpOZkUvUnVBaUh6ekIzeS8ycytt?=
 =?utf-8?B?MDU0WTcwbHEwNjBVQnJmSmJEd0pXcWhjcmtSK1lpZ09HR0RQZ2VoeGY4cUxS?=
 =?utf-8?B?U2V2SWZFOVVSaXVRVi9ZRTRtZXVyY2FoaHFoY25YcFIxSFF4VUxNN0ZjTVlG?=
 =?utf-8?Q?MqDt3AWJHZWG0iBtFlG1YCJBD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6e756b-76bf-47aa-9dbf-08dd98552027
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 10:49:13.4980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkWs+se27IFUSUMlhqPMN7TJimPw7QEyYh0JGCp8U7ckX2pr57AvQ7wyC4iE+ig6+6XF5B8P5nlPR5CDp6HeBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC4D2A1900
X-Proofpoint-ORIG-GUID: wa5qygIkTprHxnL4BONyxauwkZ7ErrDp
X-Proofpoint-GUID: wa5qygIkTprHxnL4BONyxauwkZ7ErrDp
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682dafac cx=c_pps
 a=yfraj20uO1EtZH+TM7jpHA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=QyXUC8HyAAAA:8 a=aBsRwOoz-QPuvzUrOEkA:9
 a=QEXdDO2ut3YA:10 a=4WMZ5Nd5KMcA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNiBTYWx0ZWRfX/Mzj8FzMf1yD
 HosTY00Daq1lWIdKZUo4KBjTZzuOC7y0HvdEXJ6AK5JYXPr95BFh2EhxCXnzGCigJ8YDEZMEh7h
 Ww2hv+qaGAg68XOv8YcEAv2KnHoOa/uKwZgABtN4d16JSyalhWeHelKoxBSv/Y3O78H9S7kD9E/
 CmaSwsQJsjuBcIgdGsgb3W4QgvPt+dZqhxBlXPX525R33nJj8+sNVgCU3Y6qyd20Rv+ofU2aZH9
 iDZpq0Kk5M46QEJgWXGxlo3kvnbNcY8HQXUJ4JW1QpCxV/42833jhboxTx1Ty9udKqL+lViLUiF
 OEg5HOQcQQnuAi7w5tyq4lgpaTxSPCN+w8h5oIIAyV7mTayFlPo9w5vHZXuuAbjjNJLbFq5hsFx
 tjKG7wVe0z7rFWa4tFzDAluxbuKOx+rJwaCC0DWc5iCkugxL08AQzet6T6kTCwwEhfduqWQ+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
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

PiBUaGlzIGNvbW1pdCBmaXhlcyBhIHByb2JsZW0gd2l0aCBvdmVyd3JpdGluZyBkYXRhIGluIHRo
ZSBPT1AgaGVhZGVyDQo+IGluIFJBVyBBUEkgY3J5cHRvIHByb2Nlc3Npbmcgd2hlbiB1c2luZyBj
aGFpbiwgY2lwaGVyIGFuZCBhdXRoIGFsZ29yaXRobXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
cmthZGl1c3ogS3VzenRhbCA8YXJrYWRpdXN6eC5rdXN6dGFsQGludGVsLmNvbT4NCg0KRmllZCBj
aGVjayBwYXRjaCBpc3N1ZSANCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KDQo=
