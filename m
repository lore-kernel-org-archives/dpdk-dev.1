Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA981C44515
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 18:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D6C4028C;
	Thu, 16 Jul 2026 20:31:16 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 09FBE4028B
 for <dev@dpdk.org>; Thu, 16 Jul 2026 20:31:14 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGTo5r384856; Thu, 16 Jul 2026 11:31:14 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022104.outbound.protection.outlook.com [52.101.48.104])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fewjwhh1e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 11:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSVfGXkKsNaKi0EfDCuOb/11YyPzy3+9wH8xmPWv5mphIRQaOUfag0kadNYIiVWbDkQQkwXC+b9rPu0w7m59Nxels/ZSasus8T8dvJ/x4wL0IceSHryS2CN78EIWai+eK3tlCUNAl8ngPQWsf1Q4Y2YHqvPfWxgqVbrmWJfZvheWoXHIKTxB6uR/MEqg1inthf73qG+ar/O/dmZPIuoDWXtKcdAkgpOPXfGXJ9ShuVL6zxYYasMUeded7kGK+WJnVXomI7gg+6SzLrogLwq9UuwuDZ4DSQpWBdf6RLoatecq9/jiSpth5XmZIbjYcxiZ1lXT1gl7v8HvWsYC0PUVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7bhPTrsOreU3NrC8uRjP5xqo0tkpNDoHJsXtvqscW8=;
 b=yiH+hroIV/7bVrGg+gSya9HBA0ykUBHV+TV7ZgGBPL3f9KEyaU8FI6eXc6r82/Jc1Z8Pj5IpPU+TG8vphb4OS+fhbUG4httI3q8VxdaJHNbrW6COKUXBmoqXd0T6DRUSAygxKVHJjtmf1DVD7hZNdJrpig7+PDOIiV/W9HjqUKMo7ZHUVyRm7vovdVKgyPRfe1fAIMfYyj4KDXsOJY74Ka46rpav+IaWpJFmALvwTriMgNG5mzG8Sc1+LT7Vnt0rG1qKdKFn/KsZ5q1wdrRwlLL+n0q7x8w5tLAZ+b8O1fSxsNsjAc7nDIXIzITNsBUNEwbrIRwu+SpQRjSSsQ3G2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7bhPTrsOreU3NrC8uRjP5xqo0tkpNDoHJsXtvqscW8=;
 b=AmbWw1Y3d5A+YrjZfOVy/L7lJQ07EVFW7YJSeiQQ/SAYa32HGSEHQCYnRdK0d9cp5GFOw08UsQHx0kmXbGrArxGcXG4aKNNqvuafOiAamQr1CSSWNO6lc2BQetCoXxmlaQ1WxOtTqmmNdOssfMDhOHYn+vVFf6x4nHfz4rhHed0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA6PR18MB6126.namprd18.prod.outlook.com (2603:10b6:806:40c::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.11; Thu, 16 Jul 2026 18:31:11 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 18:31:11 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "De Lara Guarch, Pablo"
 <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "weid wei.dai@picocom.com"
 <wei.dai@picocom.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Topic: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Index: AQHcidPTJMSJpLGdo0mOfy1/GuANj7V8W3SwgCs4dMCAsJH2gIAZaMiw
Date: Thu, 16 Jul 2026 18:31:11 +0000
Message-ID: <CO6PR18MB448409312092A71149541AB7D8C72@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260120061234.137-1-wei.dai@picocom.com>
 <CO6PR18MB44843F6D8D644EDBD045B45DD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CO6PR18MB4484A9157D8A409D0A9D9D8FD846A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <LV2PR11MB604554E92C84D5884EBA4DAC81F72@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB604554E92C84D5884EBA4DAC81F72@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA6PR18MB6126:EE_
x-ms-office365-filtering-correlation-id: 6ca676e5-f6bc-4d4c-2935-08dee3686933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: uUYQY7llbScOnGMVQ0I2hM3aEK35kVNq7X7pLJ8amN226RtJrEpQujRDyOIER8TfcqxIcVlEpbdAsbo95PW3PfPHqf9IjEpDUP6ttnnPF7QQVPT6S6oNF70pCU3lBLw800wBqZsD09Qqw2rGWbEJHe2m4N22W2qU9cU/MgvS0Rals8qgCkmcTuD1U2jjv7RwUbns8/JVAw8QrYVe/xf4sVsPYn1mau1Gsjk+5WMt4vABqav/C0kqILvp06qVMKBXt7vzERXuk10JRlEZm7StbNq0XrMoE1nlHRhLd2WHcwh9v39dEQn5L9LOKMt2nYni32tGAn36hpu4Q31A68QXUOLaHbOjZYO0gLkcyNYhG8SFI+bd/OAx7Y/3hV078zSa81YbFyxxKVveblolLIxCjW75A1beR7e7HpoQ4JLYiQuFnKU+VeyIZ9b6okToAIdftTIUs9xp1RQ82hKC3hnKV1btQGTTm7RvOg3YUEeuOsO5pPs5KMe/K1GOp+wY33kpC/SHBXPsmVnOLf90vXmZMMqEN7XvhAk+DvbAP8VM+aenNjN3+KGUkBANImEET3+pgHK0LnH95NfIAOmZo7FOqfoOSVy+sd2OKMBY3vXe67MNfCWpI42fW+SjcnLPLa0iNbQn5wkP1X3qIPt5RDox3rjPUVLornM6fPVJ3nhDceEOm+5E4TVb+xKx97QFEMCmKuSjn20NOHM1yjwya3+aeW7evFAXhNxNp7djI8jJvBQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0NHM1cvbWJJaHpoL0FJc1d2V2NFTjUyaWtPMGh6V2hjbkUvcXc3VDF6UGJB?=
 =?utf-8?B?elNmZythZ0tWcVlGemZvV1dSSGZKVTVHbFdTVS9RN29Bak9hT3FSRVIreUpX?=
 =?utf-8?B?cG9KczdtWHcxUFhKNnpQWGk4dy9ZQ0M5dnpya3gzS0dBQ0pXOWcySFN4aXE0?=
 =?utf-8?B?Vk5PVXgvSFdMblB6Y1Vwb2xESk5WKzhpMVUzUEM3ZWpiVXdNTG1GY0xjUmFJ?=
 =?utf-8?B?cVlsRVprR1ZLR2FRY3RLazNIcDQ3SHoxb2NvQnAwY0d1MjFoM2ZyOHlKeTJE?=
 =?utf-8?B?b1plVUMzRVZDT3FpWHYrMEhRb2QxR1Z4TnkybjlPeC96OFNpWWIrSFByVGRn?=
 =?utf-8?B?QzZqSzdFZmxYZGVBMHdIVHVHdVhEQkpscWYxbFJoenVDK3pTZDFoaUhmbit6?=
 =?utf-8?B?WVAyQ1A4emdpSkNVdU9TVndxSVNTOWFPNVpyVFpNdHEwaUpPUFBoODVnb29q?=
 =?utf-8?B?QkhFbERlNm1hWER1RVJIZVhnRENWdW5qa3ZDODBvRFhrVlpnTTBoQk8zdk9F?=
 =?utf-8?B?UWVKYWFKS3ppYmpQNWpXQ2t2ZGNYQ3lROXlMYnFhRGlpc1RLMzhqdTZZS0pj?=
 =?utf-8?B?dDdFL2VOT3RwUkpKS2Q4YWZ6RE9MVkNTalYydXlYSFRRZm43Vksrb2xpYzIz?=
 =?utf-8?B?anlRWW1OOFEzUDhMMmZUT0FXYjhDSkxqOUZnckJzRXB4bVJaNCtQa2h2QU9H?=
 =?utf-8?B?dkZQaXoxYU9yWi9nYW5WRWl3RGY3eTZBcndZemRwU3BKOFVESzNISVNKQUlP?=
 =?utf-8?B?eVVydG5Ia3lVdE53SVg5dHRsTnMzaWVxU2V2ZFVBQ2RveGdZNFo2a3pHMm1O?=
 =?utf-8?B?YklxbHZVLzNPdDhoV1NMZTBLbjhzOC9RUXJFbXVORE5BS01HZEpibU5EdjFL?=
 =?utf-8?B?Nm5JMTY2TkwrUWcvSjFxelh0dXlwZnBQVEpucnlIM2F1bENBMVA5clpOaGxZ?=
 =?utf-8?B?Rk55NU9YakpvSEIraEJTaE5TU2VnWXFsNGRjSXhxeHBJdDZ4WTJUT21GaUdP?=
 =?utf-8?B?NlVOY0MvdmxNeVJPdnhKVWhJMGNpM0tQdlVyRUYxempWUWIyV0tRN09HR1Fl?=
 =?utf-8?B?MENpOU0vSEd3ckdRb3lEQ29Ld1dLZmltMGtKa2Rxa3p4R2RxQm82WmRpelRk?=
 =?utf-8?B?TDBXdjh5bGhEcUlEb0MwVlV6cVp0RDNwZGc1WEx2UEt6RW11czYvVUkzZmR2?=
 =?utf-8?B?bFVMM3RaRjJ0WVcwNzlJNWF2bjZXYTd5dWQ0aWNGSFB4a2xhVGNUajRENCtI?=
 =?utf-8?B?NEpQYjZJK0I2UEdGbGIydEdkQlFobjArM3dqL01vWTE3dzc4N0JYMEt5aGFI?=
 =?utf-8?B?REhxL2c5V2s0VTY3d2ZRTFp3NkRoVGJhRWJZWEZ3MzBNT1Bkdm1QdGJ3YjZ0?=
 =?utf-8?B?WEFNbDJqVk1scFBJbWxnYWZMeXN4RkVSazJiak8vazlYbTh4ZEpqZmtZaW5D?=
 =?utf-8?B?TGd0YjNNOUl4WmpqNy9NQ1NJeEZLbDlHMTNVMEtzSnBpd0FVUFNNZ09NVElH?=
 =?utf-8?B?T2Z0L29jYi80a3JKdFdYMlEvY01wWU91S2lhOVc4Yjl3UXBMSy95MktPelBD?=
 =?utf-8?B?dURqaFMzMnk2NXVjOVowc2MwVXhmY2xEZ2d4Y29KeWh6QUp6K1lielZLTnRt?=
 =?utf-8?B?UGFXbWFpcU9NZ2RnMS9YRE9iY25FWWZLdTNaU1hPVGcyUVQ1QURwQnJqSXdH?=
 =?utf-8?B?aEw2b0s3U0JDYjN4UmhuRkM4MEd1Z1Ivb3VGRGUrWHlDL0U4VU92K25DaW1o?=
 =?utf-8?B?a1FyYWFheitOakE4bFNVTlhFa3d3THZ3WWJmVk8vK0U2NCs5N0JCOHpmS2Vu?=
 =?utf-8?B?ckpkZy9DMjhKQ1dNcnRCREorcGNLQURNanpWc3Y2QVZkNHZ3NU1mT2prSnN0?=
 =?utf-8?B?czVqUm9WNjY5dmNzalR2c1dFbVpCSlFlbW0xSTBuSnprYmJtc1hKNWUzTmxR?=
 =?utf-8?B?ZVh3M0ptbmlJT2w2cEtYN0RQajR0QnlzNUdTWm9SckVXRk92WWdadDZFU1Vy?=
 =?utf-8?B?T0hySUpGZEs3dEIxNnI0YlNFazhFRXVLbGVjdGVFWlFtdXkyeDJWbmdrTEI5?=
 =?utf-8?B?dDAzVVFvb0pQeW1ZVjVhaE81MXYyMlBjWlJBUHUxbUdsUUY3cDBGMkY5VURI?=
 =?utf-8?B?TmlYNW1hbnRUNnNIaXRaV242SGM5bmJEQzlVR252NHRDMHNTd0Q1aWRzTGZL?=
 =?utf-8?B?M1YwTlJJWmpqRGJXamhGRHd2b2JSb0VBTnU5MFNQQlVhcHRDNFFINWNFNG0y?=
 =?utf-8?B?SDNZUFlvc2laY2dWOWVraEJyOTk2VzdRNWI3QU1xbXRxbGZiZWRWN1NWUS9O?=
 =?utf-8?Q?zX6lxxL9PzdrfP1184?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MpSNZ6wqqGdWwc8bsHqwMhMtqq0QfxyHfUzt84381VENz2Y469CwICPsbCdXVfz3+7Df0+eJ52H674ERsCeVZ0bmHkx23qGY4pI19fupdc9uGy7LMsq+3F4ibp5k5GmcTgoqiWoAwT+nlw7FO3FMgEc3Qwuwym5unHt+rlpB1djGCjFk1Cjd4SNsmNKoxPTnNymplNzz9CqgTC+ihW1JY4+3Xne6m1KEEmjiF2hjznPQCK1HkdqpdE6AqE9qBEjpqTXWoCgr96WohTKpjY3uc+3+pLExNmMf1WhIS/Oj7V00cYOV7jd/38bqEONhSQ+WMFAFzpgqcIo29psjGwvzUw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca676e5-f6bc-4d4c-2935-08dee3686933
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 18:31:11.3977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4RTTIX6vzlfrn/qpgx4S/gXmUPP64qfV3qXGA/fMEP04BFXRumixb6xcS24WIkGzeUMZ89qKUpNXAX+hpkARw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6126
X-Proofpoint-GUID: FRfyfSR_EaqhGSFb_UzDwYhGgMHn2wMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfX2G5QzWeReq4Z
 oroNuxxpX03Qpoyj71MSm/zuCbJHrPpDXreAjd47Zfwvyr+fb26Y7NBFbLOrWBWRfkGoevj6nj2
 XdLdfK4tCRCEyu7X5U0RTmqg7HwTHk/PGSkLhahZb+5BSjqqFxPkS7TQiywvINb7W51+WpKHQaV
 URDVBIGCoNxYfWC0dnU+bCUpjZ65as3jFPpGEhwoHEQoHshdwXTsDSTgCRThsm35vip1SbHsV5j
 I1lLaCZ8oLoajosSABkCNrq9g6aJzUTBaXUERxnmBioPZsJg3kSx8jDwtJIQzWlpsPZb5Bz4XrT
 WMu2wyP6g4Lokof6bOp9o/SoZIi8g7LM5YlUWtKJJtli2H86Z+Fwkc7BggNKaLzdb8pYrM/ueTV
 yZnT2ZfbS62/i4YIn0O6E8fpntSHSyEO7yoY+s0TuBH+H1rwjTG/7UwQQ1I5h3+n4YYNNmD1Dfm
 bQ/P9tnXoS6kgAMBsBg==
X-Authority-Analysis: v=2.4 cv=Pa3PQChd c=1 sm=1 tr=0 ts=6a592371 cx=c_pps
 a=Bea1ssx1ZEalIj1DWwj3pQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=Zc_DtpmQZw8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=HbLRYaH9zA8PqascaUQA:9 a=QEXdDO2ut3YA:10
 a=XqwKkIuMdFcA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: FRfyfSR_EaqhGSFb_UzDwYhGgMHn2wMZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4OSBTYWx0ZWRfX5Uwnge2twjh8
 mzcU4i2ugBsnKZi9wEUWbv5UwARMStnlDM6l4gmg1AwlxStPJxdO7FoNXLsMQW/IH/ToRpQT5VD
 fJLpM42itNO1Fpo39TDHxGhsvKcqL2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
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

DQo+IEFja2VkLWJ5OiBLYWkgSmkgPGthaS5qaUBpbnRlbC5jb20+DQo+IA0KPiBQbGVhc2UgYXdh
cmUgdGhlIElQU0VDIFNOT1czRyBhbmQgWlVDIFBNRHMgY3VycmVudGx5IHJlbWFpbmVkIGluIERQ
REsgd2lsbA0KPiBvbmx5IGJlIGJ1aWx0IGZvciB0aGUgQVJNIHZlcnNpb246DQo+IGh0dHBzOi8v
cGF0Y2hlcy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvbGlzdC8/c2VyaWVzPTM4MzE5DQoNCkFwcGxp
ZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KVGhhbmtzLg0K
