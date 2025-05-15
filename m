Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B88C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 18:20:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D073E40EDC;
	Thu, 15 May 2025 20:20:03 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0E97640E03
 for <dev@dpdk.org>; Thu, 15 May 2025 20:20:02 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ENTYs9005491
 for <dev@dpdk.org>; Thu, 15 May 2025 11:20:01 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46n4vtj8ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 15 May 2025 11:20:01 -0700 (PDT)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FIK1fY004550;
 Thu, 15 May 2025 11:20:01 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46n4vtj8ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 11:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okVRJyMvDb5BSlyz7ul05ArSPF1GrjTPSHbmxlLWV3qbecXDFnU6i2ZqtyYHh4G9VCKLTqp+Per0hiUlg9kzA325m3lyOyxBLYe+5P/sLu/o6x+C9MZyym7QpbbSJhhjnoD5vof4fQ4jJqyQwPDasX8ClqNcD2DPx/etTCspltOxdHS4uP4yc0SSsVTmeGW/6l9IqeSpbygozqkIKOSOSMxHc7QOeveqVvzmwqsLpqgnITDPOXE+jlAYTWQTn+ViPCVsLT/ZcVGceTTfYIHrYKhnkmpFbYbKF+y/DSQ5uEHPfBFMNvjGdrTOYgarqHJus1Fw90u6PeG6LBhdVj2glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7JiyvGxIP809CRfdvc8JC82sedeiIQIlmxIZhBwSHU=;
 b=NnpP+XVBWkg+g53le6NNEBbZ59X5zeaLginASiKjLjkZExc2/1E8buqtyc4uFay4h0Qs1K0euyupVQjaKlmK3Yg/eGDwH3/RAfacks4yhBWtQh3DWsI1s8UhROmu3LHdZWaEVjD3SVFcuyROtv8qWCUgKjBAAJbJSTdX8gSP1maQEr9orL++JK1L2l1uhtS3m4ChCxODTVTRtT1ADNIxuj9T6xusPReuj1CeZHHw8e7Gw0ZbUH7gtsWHsev7Hb3Q9vZK6ElVTJdAIn3iVof7OLRzLOvocHSXNP23/5thEDlBfbTWShkIWUCFJrw6yp52LI26Irw/33epDdWodXGJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7JiyvGxIP809CRfdvc8JC82sedeiIQIlmxIZhBwSHU=;
 b=eTT8SvvDHJjdSlaLrcb3hpzAd596nCX3Bg6sJLwltYLPwBgHoTWDuhz83oYMl1+SqJPkfdzrNUjfZauMsCPXsW8QjGQjKMEnm7b667ScOKldVhKP9ujE7fqzuCBW/DTNgNyanJ9FZF4HGB2ubZ/AJPVj7hm/Bs1XZhXiccoEKLc=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH0PR18MB5461.namprd18.prod.outlook.com (2603:10b6:610:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 18:19:58 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 18:19:57 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 1/9] crypto/zsda: add skeleton
Thread-Topic: [EXTERNAL] [PATCH v3 1/9] crypto/zsda: add skeleton
Thread-Index: AQHbxYO2IlBL09KUtk+uoWKy/fL9RLPUAEDA
Date: Thu, 15 May 2025 18:19:57 +0000
Message-ID: <CO6PR18MB4484443D53E896DA8E8A3BD6D890A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303082751.1053432-2-li.hanxiao@zte.com.cn>
 <20250515101927.1926502-1-li.hanxiao@zte.com.cn>
 <20250515101927.1926502-2-li.hanxiao@zte.com.cn>
In-Reply-To: <20250515101927.1926502-2-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH0PR18MB5461:EE_
x-ms-office365-filtering-correlation-id: 309ef757-10cd-445d-c52a-08dd93dd1959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWlhUFFmZ0ZYbTZKRHpOL1djQzZXQjg2N3hLQlAxTGVHbkw0RGhBQWVCVHVl?=
 =?utf-8?B?eVhyTXNNTll1WkhaNjZWZUpUK3dHdVhxcXZVdjczc0o5bnpKeG5NRzlUTXRZ?=
 =?utf-8?B?N3dFRUc3NEprOFdMS29xalRJbGxEeVlCVkIrd0xYVTN1QVlHTzE0R1pRTll3?=
 =?utf-8?B?c2MvOUVST1V6MEhlOU5pSTNTM3ErUUV5cm5Rc3E3YzEyaFpiYlk0dGNuSDh1?=
 =?utf-8?B?UEpLakZmNWRpRHZabld6MVUzdUEvUzUxeVRacFQ2cU5OQUZOQjFCUGVBWk9L?=
 =?utf-8?B?emYyTmRaVFl3enowdm1FWUhtRjFkNGxvb1FJb0FxQ2tDVzZEb3orNzVKK0Jn?=
 =?utf-8?B?SUdyV29ZTlFzeXRocGQ1SCtRRE1GRFFGYytrWFdhQWR4K05oTE5tR08zM0lX?=
 =?utf-8?B?cUwrenNWd3BsOWVHcHQ0Y1Q2SkYxbi81RDAxUTBZdmtzZjhjN0czNEI4ck5K?=
 =?utf-8?B?bzZUWkJGSFNWbnF4cDBRRzlwUW44aXA1USs4T3VXQStmaXFocERJN0x2elZ5?=
 =?utf-8?B?ZmpxMm1SMG84ZkVHMzA4cnJhcTU2RHlTbHZHWENPZFlUK1JCdXdsRWVTL3A0?=
 =?utf-8?B?bzlaWFI5MXlCbnV3bUhpTTcza21LTXFuNUZXODd2YlVQNDhJYy9uK1A4NVpx?=
 =?utf-8?B?U1U4Yk5QU1lLcXNLSGM2UzRGSmtkcGY3THR4RDZqM0M5Qno1eUFxZU5iRHZY?=
 =?utf-8?B?TE5PTWtsQ25VZDlNR1MrN3VXck0wVjRibmtiSnVrVE1vSTJaT0hXRGVTVXFN?=
 =?utf-8?B?MXZveHBJYmc1RXdkcS9JRFUzZXEyc2NNS2hCYno4QVMrV1pmSnlZQ0VsQnRC?=
 =?utf-8?B?Q2pmbldSeXBIbWdKNmU3eU82WjZoMGIrY2tPeDZ6MHpKWHZWRG9tRndPR2ND?=
 =?utf-8?B?dm5xR0s3Z1grODVaMURhMmVUcytUZXZqZWpacmpBQld1TE8xSU5hNXFJVzVL?=
 =?utf-8?B?cE9WcjNNeThVcmVyNXlqUkRJU0RZNzJDaHBQNmF0V2JaYUpQL096dUE3OGlJ?=
 =?utf-8?B?OGZZOGhKc1lxMk1tSDhJdnJaQkdIZW5vbmNXbTFTa2M2M2FtOVpPYXNZNEc4?=
 =?utf-8?B?Y2ZqQkdrbDc3RHYyQm5YR3J5NUlHdW9KcjN0Z0V0SDFmblRsbjdzcHpKT0M4?=
 =?utf-8?B?dnlkS0pvMGpmN1NTMjEwL3Z1emo0bUc2OFp5YjNOL25QTWpYTnFnR0FNajFB?=
 =?utf-8?B?RzI4Ky9GS0xlVDBCelBMbXBoWWdpQnNNRE41cDBYZVpZUHdVczl4TlJoOEVN?=
 =?utf-8?B?aFNTU3RZUE9SK243VDA3cVplWWV0bFZSNWVqQld6RzY1eTFqRTltTWl5UnZq?=
 =?utf-8?B?dlErL1JtYlJ4NmVmOXBvM1FVTS83SHZQWFJhRmdVWmlReFc4MC8raUJPSEx5?=
 =?utf-8?B?ejVDRGpKS0lidnJ3SGpzekRhUzByVEp1NUMxVlYrN2t4SFRoM21DbzVzQUVD?=
 =?utf-8?B?UW1LekNsTGNVTkFXWW1vVjlRd0tCRlZmcDE2QTZJTXV2TU0zOGxDU3hQZWp5?=
 =?utf-8?B?ZVByYmtqdlZhdE9JNjg2TVFIKzZXVHJESUZQY2tNdDQxb1l6aEtyT2J0NVI0?=
 =?utf-8?B?aTRBanJINEV5bm9laEp4VlloeGZEZ0ZFQUtwQWpmbVI3SnVNTEZFWVFTTm1y?=
 =?utf-8?B?Q0NTNnVjT3hXRm9XMENwQ0diYWRwWFc1QTNVeTU1V2hTWGQzRnNVUFJyNE5p?=
 =?utf-8?B?eEx6eXBPeHRzalA2WFpvSDhCdzhEUnp4YnMvbVo2S2FXNVIrTnpHbEVqaTUw?=
 =?utf-8?B?U28yZHpzbno2VXFpeTFTK281OTNGQmkxQnNqemVEa1ZrRlErVGg0QlFEUUNl?=
 =?utf-8?B?UkJBL1owZnBEMTNPelFFNUY0SFoxSjZveHZtK1Z1SGl5NytpQ3IxNzZYWVJ6?=
 =?utf-8?B?RWNPSjhBRUozUHQ0bTNGdytpVGN6eC80L1dibDRmRXk0Z3U3Nk1yQW1WRjhX?=
 =?utf-8?B?dDNkd0NXeFp0QUxqOGpXYTFrZForZlRVbGRkZnF0NlI3SlB0eWZzNmZvMFJU?=
 =?utf-8?B?UFp4TlFwa09RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1A1UE1mTlMyYVNWdnM5UkZaUnVtRTdxeEcwYVo4Qk9IazIrbGxBUzFmYVVX?=
 =?utf-8?B?YVFNdXpoWGVJbWE0UHFxVjcwSDgzaHRoMGhCYmo3UFBPcEZmWkp1T2QvVFpq?=
 =?utf-8?B?VjhuSzlmM3l0VFBNNGtydXd3YWpuUHdoK0Y1aDJIdmdvTU56NDgxTFFQTEFZ?=
 =?utf-8?B?WjB5aTZnbkw4b1kzSVV3YVF0UmFISm9ibGpBQ0VkV25qOEg3c3BabUZBbkcr?=
 =?utf-8?B?OVVyczd6M2RObUJaWnNQY3JmSkZjcTgyWEVsemMzYno2Sk01OW9aQmhaeFVk?=
 =?utf-8?B?WHdvWlp2Q2JMN3dmbU9kck8raTVVY0VFV3J6cDhjNXVaUVU1QzlQRWkwY1Aw?=
 =?utf-8?B?QmV1SzRtKzFuWkFnbXZ3UmFNdkk1Q1crSklJeldPMU11enJLMUx5bktkWHJQ?=
 =?utf-8?B?NmVaVVV5OWpPdEUyZ0EydGtYWHRPS3gxVkhta0ZQU0FNSEpMcFp0L2RueHU5?=
 =?utf-8?B?ZGNlaTJkZFZDSnRDbnI2S3YvdEd2NEI0ekpBUnh0dW1JbjZnaStSOFcwc2FH?=
 =?utf-8?B?Y0xyMC9neGJvRW5CYWxkd1JGeEN2a3kyK2kvNGJTZVZkMFRIeHBUbUYwNm54?=
 =?utf-8?B?VFlXcmRkd05UWUc0a2pZTHZFbmRwWm5sY0p1cDBTYTZvdEhxMm9wNVZBTzBm?=
 =?utf-8?B?WW1PcCs2NFBUN2hwajRIVTUyMUVRZE11NDhMbisybTc1aVlJTTcvYUg1bzZl?=
 =?utf-8?B?WGgvTFUwRVBJaEpFNlNxQ29rRjN1RWJ4NExBOHpEdmE3Q1V2UEthUVhXSnZ1?=
 =?utf-8?B?ZzV6a3hYdmpPS2toMThDbUtMa0NKS1J6OUZFNHV4bVlYRzQ5S0swRVpPOHNM?=
 =?utf-8?B?YUxNYjk1KzJGQmRuaUFjcTNpOE9TMHNManVCUUVFRmtDN1NEcnZqbG1xTzRk?=
 =?utf-8?B?cHBicHpPcmp3Q1Bibk1vTWpxVzhuVjlCa1NBaHRWUFVpeVFlRVJQcUF4eTlq?=
 =?utf-8?B?TVJENGpqSUxRL0x0c0FURHJQejdBd2ZScEZGdnd3NU9QZThZMVJ1UTZpSFht?=
 =?utf-8?B?SkNjVVBBSVZuNkc0amJOR0s1TktSYXd4ZDRWYmdMa3pRUGxvT2QreUw3YWQ2?=
 =?utf-8?B?MzJld3VWSDJkeGN5RVJLeUFDQjZieXRvd1hjOHFDdE5yNTNESDV4VGVaVW1C?=
 =?utf-8?B?amkzams4aU1yK2hJYzU3L0NQL3RJWC9kODh3S0pTdnM5dXZuN29Fb3ZjdDZB?=
 =?utf-8?B?ckQxTjk2elZqeTkvTWx3Z3Q1a1ZOd0pWZmZ5MTZuQzNUaXhTV2xGOCtkZ0Fr?=
 =?utf-8?B?aGkvZWsrd0owVFExTTl4QWdtNHJOcUhhandWYXVycm02S1BxVlN6TkYzOGNl?=
 =?utf-8?B?c1JDUkUrWE1yckp4MlM4U0s3M0FFNS9MKzFKL1doN04zczQzcGZHb09waEc0?=
 =?utf-8?B?bHVzelQ0eWtNdWNhSGZFdWl0ZFBNanZJa3ZoODNOWE5odkhRY09nNEU2TVNW?=
 =?utf-8?B?a2xRYkdzSXRQYlpvQjlKQ1NUY0tnN0FLTWhwSVZuMUFiYUNDenVDMzZ4NFpv?=
 =?utf-8?B?bE03bHhIK2ZlMEcvR0xsVFdYMFFvNnIwMHdvSmx1U1BOUzd3ZzJUUTNXSGVX?=
 =?utf-8?B?d09wK3NFV3NVN0tyeUJwcjNKcDNpak1va1J0TlFyaDZHallsZjJJZWYyM0V5?=
 =?utf-8?B?L0JPZUc5K2VvRkZSTUk3eVlHOGI5TFpJbUVmcmpDdHFpdHJ5VVcreVlpNlNH?=
 =?utf-8?B?NTZkM3ZBamlVMVNhOG56Rk9Rb3VaS2MxT25NdElkcUNjZTlnYm9IOWVUM1Bp?=
 =?utf-8?B?SUtiNlZ5ZW1zWFhRUzZZZ0VKVlpDNHltUENVVlhmbzZEc0RGU0dxUVBMek1h?=
 =?utf-8?B?TzQ2Vmh2azhhNGNVdmlZK0JQOTR5MDFBVzNUbFAxVXJIRE1EQnJib0JMcXpD?=
 =?utf-8?B?NWJJMmVrVGw1ZnA5dkxabE54L2tUdzNkZy84Y1d5azJiYnZTNk9rVXBaZWEz?=
 =?utf-8?B?ZkNlVFIrRjJvZHE3blcyQmRla2xtMGNvdm5GTUkyejc3RHRrS1VYN2NCNHJy?=
 =?utf-8?B?Q0FiWjZReVFQRWZDU3RUdGs4RExQdXh6ck05emVGaUdKOS9Hci8vYUdNSm5n?=
 =?utf-8?B?bTFBeEFIYU1WMmxwcVFZS2lJbEJuTkhNaWhOcmFrejFadmppVnAyYVFqdHpT?=
 =?utf-8?Q?hiQc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309ef757-10cd-445d-c52a-08dd93dd1959
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 18:19:57.8739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7ztf+VbCQ//U7rTC8/vYxhohynY//CvkfNQAbdOX+asOEsJX/11h/jIHQ8DQblBD4HN6Nq5u1jbu/U+FcUDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5461
X-Proofpoint-ORIG-GUID: FnMP_AFvCcklzgTs1Ct0i4rAcExA_5xj
X-Authority-Analysis: v=2.4 cv=RMCzH5i+ c=1 sm=1 tr=0 ts=68263051 cx=c_pps
 a=6eDru+6t2m7UgPRwoW7UVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=IPQcESuk5OIwjmn3OMYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _L7_k18X4zC30H9tm1VknYeoa6u3uUCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4MSBTYWx0ZWRfX38d113xfiIO/
 dgQgCCUqS5jEM5hKn4ae8hCQgV0TL4TYvJ328TJMl90sWop/VobcY2ih5gt7sehaaJ8rdgKgKGU
 O8/wcnHoQLBDnr4UhEjylDMjpbf6jejq8NsmPs/Tumd3oCmTN5x/yBz3/c29b6TfUqhXxInhH+O
 LQFGcNpXVe672cZ8/EViQhwR9KBZRN7lCgruV6JWGmvOuz54pYnhsiBVzgrE8yGIZLKY2V7jNNS
 I4GmUWnsiHnA6RCdbnKUttDXSSMaeDr2ZBl36Q9Y0iGflcl1tJc98NlVajjx1BKpolANZhMKJF7
 6njU3oNeRyorI/koShUaFtR/mTyotj7aazDNEgh3xCEfD98u6qYEdV1D8y45H4lwAUhoyq5LYz0
 lepUzo7RNsnglrxzJREnzZkn6ovsvotYNm1CYrDO7dU1eAm5J4LrDxJElgd7wcToZFGSVU58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
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

PiArDQo+ICtpbnQgenNkYV9zeW1fZGV2X2NyZWF0ZShzdHJ1Y3QgenNkYV9wY2lfZGV2aWNlICp6
c2RhX3BjaV9kZXYpOw0KPiArDQo+ICt2b2lkIHpzZGFfc3ltX2Rldl9kZXN0cm95KHN0cnVjdCB6
c2RhX3BjaV9kZXZpY2UgKnpzZGFfcGNpX2Rldik7DQo+ICsNCnN5bS0+Y3J5cHRvIG1pc3NlZCBo
ZXJlLg0K
