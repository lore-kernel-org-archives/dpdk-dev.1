Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8411DCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:13:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69B874013F;
	Mon, 18 Aug 2025 08:13:08 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 284484003C
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:13:06 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I5CCPc016390;
 Sun, 17 Aug 2025 23:13:04 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2137.outbound.protection.outlook.com [40.107.102.137])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48kwtkg31t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 17 Aug 2025 23:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plQOb+QZBGk87SpsuluqNKbYKdVJPjv2c5H55JZfjFyCKz71giYuOKf3OCo7rrjbKHgQdCX4UFz9AoimtOMnViMHR3xaWxJSb8rVtFiDBWNmBUP3IAL2DQnQPAsv2LY1Gu7tx4PgisrkYRmm6UosUOTBSUqyinhlsqp6gcBxU7hf/mIpHu+dxVxOtvEHQb358RKYoDCAD3ZQnsLFINYppDYZuF+0fHdxoaoooAMmoTiMIogffkHvoACzNFL96Wd3MFLMizYfhS9L3l5PrGkO2ZiVSsNnmbPz9I6VEyYa2mzKC6unPdk3E0tKQ/8pVk802w0jFsuVP5nmf7Vx7XS/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5O2HK3c4C5VJg8FdscALwkjFax5//OUDRzkU/xFgXI=;
 b=nahD0+F9UkZjdqvaWAmnogHQZne129cXghIDQsSKaFeT5MVJEjFBpFupzPWGIWyv6/fm8jxcScO1edgZ3VT/qbz/D9jYJtc9+Bxoec2r/IA8vnEPqb+8nPXhHxhbmVkdQtBPpYakaHZKtoZkv6p1pcKUBoytyFYk9AYY20f5YvL9St4ekN1trTJZF9saVJrXK7F+AXX3epvpR+rhr8cIqdwIjoBLecjs1z/rgSuGZIdVaISgQIP1qrN1XfwD0qtffrmbJE31ytoMHAn0n/qfEw0AWfwG+TvTACaIYJwSKYQOAJwhjfTHDO8coA31XV6ht1UM4C8hVSMBPNGvWbREog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5O2HK3c4C5VJg8FdscALwkjFax5//OUDRzkU/xFgXI=;
 b=PU+8TOuZ/gkb7hp7K41hTyAmY7lQVMeqETe3xA7AupYac727gcBvJJ87fcx0n5OlZdf6CEt45RM5Q4L8B0yPz4YG95uBDhSWHqgDbDIE6B6TPHNESfxYC4l/l3Q5a9NZ07GULKuiULejcS1cpLW47uE77xCSUt68Vbf2MC9QiWs=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by CO6PR18MB4082.namprd18.prod.outlook.com (2603:10b6:5:34f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:13:02 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:13:02 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcDPMrF3HoVpw6hkmGZb8+hkiii7RiUUCAgAWiufA=
Date: Mon, 18 Aug 2025 06:13:02 +0000
Message-ID: <CO6PR18MB38602751D61AB86F9C7150CDB431A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
 <20250814090747.0fe0ca15@hermes.local>
In-Reply-To: <20250814090747.0fe0ca15@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|CO6PR18MB4082:EE_
x-ms-office365-filtering-correlation-id: d26798b2-685a-434b-7a41-08ddde1e499b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eG8yKy9GdEtyVXFVaUQvbmtIUFVCM25TZWpNeFhxQ29lVGppVHI2MlU4dmtt?=
 =?utf-8?B?dEMwMnRQZ2lsRjNMKzFPWU5tODcxcnFNNGF6YlNWdmJ3WVFyMGU4UXg2Kzk3?=
 =?utf-8?B?ZzlJRnVydXNHN2tocDE3NGozTWc5dlkzYUFYR2Y2cDA4R3dnNktPaGcyamV1?=
 =?utf-8?B?SjZRaGtoMHJIVWN5NDB5bGtSYVFlRGFYMm5zTHNZazQ3LzFIWng0dlYyQW1D?=
 =?utf-8?B?bHNCWHVhcjA2VitFbE15ZEZwU1lKU0k0bklNQnpodnVHWkRUNUxncUVXWXBx?=
 =?utf-8?B?eXF3Z0hGZGdHWEVYbGdIcnJhZDBWNmNOZnNNMTM3eER2dTlCUW1wenNTMlBp?=
 =?utf-8?B?K21iM0VtR0pleTVGeDZaWGovVHNnRXE0K1d1RjhRNVpoYlEvMzNJWlpQRm5v?=
 =?utf-8?B?cVc4UWJLc1hwWEI2TXFCMFJwUDlkT3JET1BYVWprVU0zRDlsR3kvYVVsSE9B?=
 =?utf-8?B?WGhxNjVIa21MQyszN0NFR2VnLzk4UHJHSUw3bWIyVFlFLzNLQ3R2YVByNnhL?=
 =?utf-8?B?T2RLcW1ZS2hYYmcxelh6aDhBZEhEZHlVT1ozc3ZWM3VQa0wvWDcrYi9HdW8z?=
 =?utf-8?B?Rm1CZW5aOVZEaFNFc1p0c1FGc0lOTXd6aUl2Smxxb3NwT3BSNHc2amliTVNB?=
 =?utf-8?B?TlBNV0RqUlpObUVlWDd0NTJvVWdDTkRwQ3kzZEMydDRvZ0R3MGFVeDdsZ3ZF?=
 =?utf-8?B?bncwTGU3Ui9jRXlDNzlLUTlkemFVbWZUL2wxcGFzc1JkbkNKQkgxY0t2aDcr?=
 =?utf-8?B?Z2ZCc0VBSEwzMU5pZkxBaFNNcFp1MVRpeUVSeGFJbUp0bmc4UjE4K1B6T05r?=
 =?utf-8?B?RjNLTzdORnBadSt0S29wY3Z6T3dFOU9mclpISi93SXVNRUdPdllodG85eFBz?=
 =?utf-8?B?TlA5RHVXaTNjakVUV2oxZkNBSEtSd0pJekI5QUhScXF4dTRUVElad3owZXA2?=
 =?utf-8?B?YmloSTA1ZjNmUVBXR0hTaVJYVlFjZVNMbWVrbTRHN21maUgvOTI0Q2IwL0pR?=
 =?utf-8?B?L09lN3RGTk1mcmprN2hKOENyM1FXcUxseGNOUHFVYmxHeW56R2lJcGRNMnht?=
 =?utf-8?B?anFldmVUbjk0Y1ExNmVaeDdkWkJ2bFR3dHRzSlVtUWJnOEJHcDBxaUphMEZ6?=
 =?utf-8?B?VHRjSUd1QklKQjlwQ1QxV0Z1K05iLytmVEFOWFhTKzhCZjhmK3RxblpiK0R1?=
 =?utf-8?B?Sm11ZGVCc2V6VkVWVDJJWEg4d25XaFhJdTF0K21lbnBaVEJnRkFxbGR1T1NW?=
 =?utf-8?B?Ukd3dElBbEN5cEdMTnIzbVQ4b0VFRzMvakVVM3NMSlVyQUltRXpvNDROOVZJ?=
 =?utf-8?B?aHJrK0dYNGExRXFWbWNkQmszcnFWTUNWcWh3c0laNlNmTDFtUmtYUHdFVzRD?=
 =?utf-8?B?cCtXbk1jczV5YWxFOXp4QnFLRTN2dXNmM29hdGErYi9UT0Y0NEZVQ2g1aFBP?=
 =?utf-8?B?bGdZZG9zTzFBcXdhSTNzbVEwZkJHN1F1OUFnNjNGTm84Tk5YNVZHODhVc1lS?=
 =?utf-8?B?TmV4ZWtGNFZBVFZSWUg1b2FES01YdUMxNUtqc2NPbEJTNWVNeVdQWHp4akhC?=
 =?utf-8?B?dXlxNGgzSDdZN1pkN1ZrM0dOaXNJcWhTZEZFRk5sQmZ5clp0MkRraGxpTVVX?=
 =?utf-8?B?UTVNcVdleDJwYkowODZKQm9hRlk5NHA1TG5OeWlXQWtCMXJ4eTROVU1YKzhj?=
 =?utf-8?B?SkUrLzlEMG16UGJOSzUwNitudmJ2WDYyR3BISWVyVTF5MGRnNXplQjJkMjlo?=
 =?utf-8?B?VU1JUzBkMm1obCs4TXhYQmY1QnlrNVVWZkl2YXRIYnRBa0hsTXRPVWVRK0Uy?=
 =?utf-8?B?dHF0aW9DRmRrdUE3RlNKb0x3bTFzMkxXYWJOeWVicFdjOU1WbWxUNEF6bXBO?=
 =?utf-8?B?a04zMG95VE80Y3hDVlA0TDZwU3lqTE1VQ3J4bmV6TkJGT1orTk1vNGthbFFP?=
 =?utf-8?B?K1lCSXZBMkJPbzVjYkxIcVBmRUt6cUF2dE9LK2Y4RjJVQjl2NSttZDJqSzZt?=
 =?utf-8?B?WHZHZ0I1U3VBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDZNc3g1QXFGbmEvbU5xQjV6ekVnd0luMDBKc0ZzK0xnWHNvbWtuSThWNU14?=
 =?utf-8?B?UnIvMUwyZC9ITjBVY2ZhSlYxTFdxMjgvOFNyV2hXWjBGRnFPL0NWeU5xOWFv?=
 =?utf-8?B?UEtpWHhMbFpQNlJQd0kxaVZ5bjBSR2tvM2p1eWZlT0RyZmw3YkJ4Y0JlY0lV?=
 =?utf-8?B?eE45K1RNYXFXVlIzVnAzakJucGsvcVc4QW95UW1WRitjODFOSVVwbWF2d05M?=
 =?utf-8?B?WmhNVm5KOXA3NTdpR2Rvb0Q5T2RsbDdYMUYzbk8rQWxBaFFBVEw1M2ZUcmFn?=
 =?utf-8?B?MVU4RkJ6NDhFWnBsbHd6NVJXaEcvS0NlOS9JWXZOS0ovZnRWenhxYTlqZy9G?=
 =?utf-8?B?T2ZYZ1I5U2dKTUc3SmVYUTVZTjhmYnNKbzBIMU9ybE5nbW5vQ0p1aXVzZHIy?=
 =?utf-8?B?ZzU0Mk5zUzdTUHY3dzRuL0Y4aUZoSFREWkFGWG5FazNoRUJxNHpITnFJRmhu?=
 =?utf-8?B?NHF0SkgyR2puQmcrbUZaTjNseVhqLy9mYkdXVVVORDl6YjJSQkpFMTdSYXhT?=
 =?utf-8?B?SmZ0MFQ0RlYvK2h1Umo4RHovKzFXZW1wSXFwS0tpS2pVeE9uSm9zcjhKd01i?=
 =?utf-8?B?aW15NjVrUDNyQ0hleDJzT1dxYmp2eW9DeWFuUHYvaUxSaGRGSHNWZDY5TVNJ?=
 =?utf-8?B?N0h1MDBKaHNOK1BrbEdTMTVBYWNYNnVHbjhUL2d1U29ycTFrQVlIYVZrbGV3?=
 =?utf-8?B?MzZyRGphVUYxdFpGSTFmTWtkaEx5U05leDVPZEY2eVdRaHJZemVlSFFhR3la?=
 =?utf-8?B?RUFxMm1ZTTJ5U2NGTll2Vy9lSmZjeXhHa1dESHFEMWhINUpReHFYNzlhVDFm?=
 =?utf-8?B?R2RNQ1RRcWVBMWtCQTNSblJuTjZHUHhlNWlnMnFuMWpzRG9yRnZncVg3NGNF?=
 =?utf-8?B?eS9aclRmd1FpSEllQkZRalNtM1YwZm4vNFJnVGpEUHdEYWkzUnVpT0J1S3Ix?=
 =?utf-8?B?Q3hWN2hpNnlVMjhRZnNUSm9ETHpFR2l1cTZJc0xnc29QZ1FreExvcUJSNmtE?=
 =?utf-8?B?elU5NmxxQ0JuTGlQbjNBbU5QTEx2KzBZVUNTTHZkenpUMGNDRHk0Sm9iemhM?=
 =?utf-8?B?YlV2N0xaVEdDQ1lPMHF3SC9JaDYxL0J4SWh5ZlVNc1RJY3dpUnRXZUVDcWkr?=
 =?utf-8?B?YVNKVGFWb2szVXhsZm44Z2Z1L3lYUWpRS1Vjc25oWXhyVklpQmFWUVlIaGpO?=
 =?utf-8?B?cU1ZNXFBeTNCOTFTT1hWc05mdE5Ecmlxd3hZTUwzRTIzT21QU0ZQT0lsMkdK?=
 =?utf-8?B?L21hSkN1MWVrMEtzQ0YrS1hPVVZOOGtEKzBnY0lZQ1NJSDVlbWtPb3E3SklN?=
 =?utf-8?B?S21OditueFkvYmlCQzJOT0VDU3RDeDg5eERoekpYMTBLRmpZTWNEOG5zaURn?=
 =?utf-8?B?ZURCemwxYnBYNVBZSUUrKzZ6MnNCQURiNlM4Y0ZhM1JpNFpsbUFWdytnc2Zy?=
 =?utf-8?B?K2pqYlVGKzBZNU5XOEt4d091eW1zTmQ2YXdqbGhtRmtOelRvNW9wOVN4Q3lQ?=
 =?utf-8?B?YUxSOGZ6QnFFNjU0cDZJbkNSdFJxQUdYSkhrMmsyM3pDais5V01tUUQ0ZW9m?=
 =?utf-8?B?aWFTd0xhbGZxam53a3loL1lWRUMwNGEvRDQwZDVDMTJvWk9EZmwrRWhLYUFW?=
 =?utf-8?B?SHdKNXZLTjJTTXFDR3MwWXZkcXN2SlZreDFHa2Rzb01oR254QkNFUWpTWmxW?=
 =?utf-8?B?WkVPNjU4Y3Y1cGh2Y3hleUcrSE5QNkkvYXZJTzF6aWRwR3NSMWU4STc4VmM5?=
 =?utf-8?B?eXBwbTRVR3RUbG1ObS9MUHNnRWVKTTFERlFpMXR4MkwzVDhxWmNHczVpNmlx?=
 =?utf-8?B?ekZEaWhQdEF2TW9IZlp5K0NwajRMSkEvNFlKdHF3U2t1d1dieTczWXBpTlpO?=
 =?utf-8?B?eGd5cWx1bzhyaGk5NzJiTFMxQjB5RGV0NHozbnE0NWtqWnBpT0FqSWY1akMw?=
 =?utf-8?B?VExJdlhCdG1qcGFWS1RvbE51TnlkOUF0YVJEMlh3Qk1pQUpOV0xJVUpRS1Zh?=
 =?utf-8?B?eEx3NFVBRHdCRkU5TTBLVU1QMnJVVnZNTjBTK0R0eEt3RUJ5WnlhN3FQQS9T?=
 =?utf-8?B?a2JtUFJDdnMwM3REbUJSV3JvakNzSTQwb1V3MmR3NWMwV1RaQjVHY3FaREtz?=
 =?utf-8?Q?UPvQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26798b2-685a-434b-7a41-08ddde1e499b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 06:13:02.1212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryfsJAKtccKlRcr3vKiBgfV1Hq8uMG/kHwOOSv8n2bL7NdB+MHJ1YEk+QL+Fyh2nD7TQUS/OqGPRQkh35sCIaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4082
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=68a2c470 cx=c_pps
 a=CBYThBuVmAfCrlMIRLUS/g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=Dt5a1chFYcIF6Dtl-hoA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mMDWrZA_fsZUrlK5CKGjWh4uFkhaWHUG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA1NyBTYWx0ZWRfX/Ga97fB12hhL
 Ml1E7zwhP7RpjtR5emNRij/k3qSqQ0jCL2HPwxcmLjUjwWL3O9Eq5i22TFMGForYFTFJf/Bjj9D
 ajM+WCW9s2fTcOwRBt6OIaTV0bihLX1NIG9zdbil69iSWUjzC7Pw6RU4yjtlT7igCV0JSh3640n
 tSywGAedTCEr/v4oikqz3smijkfNbzDRWcTpU2rrj931mE1CFr9Mp4dC2Ng0t3MAGdQ6i3S28wu
 nNQoso+0oI31e7F9TxKhHUJi2c/Ta76opGvd5KXaEob8A4PfO3s0PNYO3sGLQfKnloVu/LjoBXN
 NFS1v8p1QkPMOSCn+YZrmwNq7AqdO+SWL8dceNPr/Ow3Xo9ufhsKtZmIlLGCy0QODhNSzeIQsdt
 W+ahV4z5+ENx2VjZGheAekjDIh/KuhtxhZPpJjbDtwtwf9CrRUZhS6r/lQ3llKElb8ovAsd1
X-Proofpoint-ORIG-GUID: mMDWrZA_fsZUrlK5CKGjWh4uFkhaWHUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
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

PiBPbiBUaHUsIDE0IEF1ZyAyMDI1IDEzOjQwOjA1ICswNTMwDQo+IDxza29yaUBtYXJ2ZWxsLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwu
Y29tPg0KPiA+DQo+ID4gQWRkaW5nIGxpbmsgdHlwZSBwYXJhbWV0ZXIgdG8gcHJvdmlkZSB0aGUg
dHlwZSBvZiBwb3J0IGxpa2UgdHdpc3RlZA0KPiA+IHBhaXIsIGZpYnJlIGV0Yy4NCj4gPg0KPiA+
IEFsc28gYWRkZWQgYW4gQVBJIHRvIGNvbnZlcnQgdGhlIFJURV9FVEhfTElOS19UWVBFX1hYWCB0
byBhIHJlYWRhYmxlDQo+ID4gc3RyaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTml0aGlu
IERhYmlscHVyYW0gPG5kYWJpbHB1cmFtQG1hcnZlbGwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFN1bmlsIEt1bWFyIEtvcmkgPHNrb3JpQG1hcnZlbGwuY29tPg0KPiANCj4gU2V2ZXJhbCBidWls
ZCBmYWlsdXJlcyAoc2VlIENJKS4NCj4gRml4IGFuZCByZXN1Ym1pdA0KDQpJIGNhbiBzZWUgb25l
IGZhaWx1cmUgd2hpY2ggaXMgcmVsYXRlZCB0aGlzIHBhdGNoLiBJIHdpbGwgZml4IHRoYXQuDQpS
ZW1haW5pbmcgYXJlIHJlbGF0ZWQgdG8gb3RoZXIgZmFpbHVyZXMuDQo=
