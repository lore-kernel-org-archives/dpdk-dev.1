Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF1C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 10:03:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A906B402AE;
	Wed,  9 Jul 2025 12:03:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C9C794021E
 for <dev@dpdk.org>; Wed,  9 Jul 2025 12:03:45 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56982Us3016948;
 Wed, 9 Jul 2025 03:03:45 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2133.outbound.protection.outlook.com [40.107.220.133])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47smjf89x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 03:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hl2chfndYIwSJdnACEXXA3pPGk/UawRXjCeD8XFwOR0kGzARKfhTaSJeBLr4oNEdcFFB5jThqOH51fb9MzGQqP/AEhDHsNa5xfRvQck41qG1H77kfnLJrLv7oOdCbkZM4ydzlFP3KvcQbeqgdGLliGl6GGotetgg9fl4iDvdofOqAORjLag0aPAdzeJr2TGuqqNXvqQL2kw1KMlT1LRYXHU0KwvbU96lvbSu1GsZmSJ3pVRWz28suDqWGUWb4ZJOwTgMu8UT/WUzXtlwl9uNY9hOjn0VFFfkCh/q608aXv+C/g9VJa0gNn17D0B9D5Ol470zfb7coLexx0sp/uvoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpLEMhkKTuj83swNUzN0Q8ZRmnVzhQ02kvGC4GWPNK0=;
 b=toVtnqMPNLkS5AZ0VV5nfYEPHdv9NAJTMvBSpWm139zfTLbQUsYNHLb28qlYyRqDRw/3OK/59ih1pFq+3j1DstmS4o/gPn70JrJNx2urdreJYcBGq/q9yX/0TApD4NnNQrAwc0U1TXXal653o5SKuISgmlnu3inyAfL9vn4Zh0atxPDuhTTF/WaA95PmcORcHl490nR+F86ZYFQO8iLw4cMQiAqrjlVXdRJ07/+4XW74ZXTtj21Z+Zl0QBLvVERzzxb9DVbsAvArHYNqlPox8ubdyaF+3tM3fgirtqiFCLMePRW7vAxvKGrEQ73X4+b3xGNtMl5rYCHizkXVDj0NRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpLEMhkKTuj83swNUzN0Q8ZRmnVzhQ02kvGC4GWPNK0=;
 b=YWDNQtOlHwxNqOHIb3WHusCbHQx8rG7nKK/pp+HM9mf0lgO7B9l5+jLLwUkh5OrOQRwMICJ3LUvdraIaKTVkX/Sne6Zqi8qMxbhBauVD+JmWsEmFwqHo67kpFup+GIXTigv2iIR1H+awaLtoASgmExm847ohQ6Sdp8Lswbto5/4=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB4521.namprd18.prod.outlook.com (2603:10b6:510:e2::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Wed, 9 Jul 2025 10:03:41 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 10:03:40 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v5 1/2] compress/uadk: use async mode to
 replace sync mode
Thread-Topic: [EXTERNAL] [PATCH v5 1/2] compress/uadk: use async mode to
 replace sync mode
Thread-Index: AQHb8J1P4jFxhOyRyEG73mK90XdgSrQpYhVQgAAmAYCAAAgMAA==
Date: Wed, 9 Jul 2025 10:03:40 +0000
Message-ID: <CO6PR18MB44843776C190BA6E914BF5C8D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250709064701.100676-1-zhangfei.gao@linaro.org>
 <20250709064701.100676-2-zhangfei.gao@linaro.org>
 <CO6PR18MB4484DBFF1F7E17C3B3187F35D849A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABQgh9H7+WTpMbU_xQXKAzrNV4yucxe=rswdpXEapY4bsnfXLQ@mail.gmail.com>
In-Reply-To: <CABQgh9H7+WTpMbU_xQXKAzrNV4yucxe=rswdpXEapY4bsnfXLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB4521:EE_
x-ms-office365-filtering-correlation-id: fae41906-96a6-492a-62d3-08ddbecfe1a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?aTRYWTNBbVFsZlduV2ZJVUpYd08xaHowMzRQWkRJSng1N3ZzTzZ1NnNhUnhW?=
 =?utf-8?B?RmNkd0hWajFVdkxaOFRWUTJkV28wai9DUE5XTGlreGVFaEdGcm1vT2xycExK?=
 =?utf-8?B?Q1k0SnF6NE9BL1hjcitvTnpxaUJSc1hqS2lTQ2FwQzBEcjVJYi9pbEhTYTZQ?=
 =?utf-8?B?cHpTc2hhWXVtaFJIL0UyWEJ0bnRWZEE3QmFFem1XL21ORFpIUERIcG1aSUVC?=
 =?utf-8?B?aFk5YXByWGlsTGFIbmpORmtMMW9yeVAzN1cxdlhra00xSVlKRWRkVzdGOGJr?=
 =?utf-8?B?TWM1UlF2WVFTaDZwTXpDdEc2K3J0T0Zkc3pVSHhOeCtRQ1ZuK2NNUDl3ZmRK?=
 =?utf-8?B?RjQwV2l0b2l4VlhVeXptd292N211RVhXdldaYVhDSzRlUWM5RTc3SndIeC9C?=
 =?utf-8?B?K3EvczZHdEpzTEZZdjJRRWJoQnUrQ2szRmFlMGlMckRCWjB0K21KditnOS9t?=
 =?utf-8?B?U1U4WGdBODVUWDNaMFRXZ0xOVGc0UjBDd05rRlRHQ0lSN2VHbHVSRVJibUVk?=
 =?utf-8?B?WE5YNG1YVVdZelhyNnUrS2I3WEplRDR1WUd1ZGhvMXZ1VjErdHg5QmNJNkgw?=
 =?utf-8?B?VWJLS1N6N3NRaEZpa1FkWnlXSmpBT3krR1hrSW9wKzl4Q2J2TXRoMmRiQ1d1?=
 =?utf-8?B?Tm9NZ1F5RE80LzZISXJCdGUrUVdldTNSZ0hPUVR6Lzc5Y25SOEgrajRPb1FB?=
 =?utf-8?B?ZEtub1JZS2pMZUhPOGxnSVhhVUZacUZtb2JFUkZOTVhvL2VoS1UySmxNelkv?=
 =?utf-8?B?d0VkS1NBYlNzbFJ3MXpVZ2l4RlhZSUpmLzZVanE1SS9DVDl5aHU3T2JJR3Fi?=
 =?utf-8?B?QVlWUjI3ekE4Y0pqelZwWCs1OFNWQkI5VUw2MzhKdFM0MkJqSFQrZFJwWHRY?=
 =?utf-8?B?akQ0dDh0Sk5UbHNnMGsvNkQ4blRLS0NiVUt6UFZUdEIyRWtUdHo3SzdHME9J?=
 =?utf-8?B?Y2lMVjRhNzZxWlJIRlVTREg5Vk5wVjFqTlo5RzJtbXBSYWZXVitnUkw4bUJo?=
 =?utf-8?B?WTJTSmNwMDc1YnZwQUplajlxYnExajNFZlE2ZjlsOVR1TWZ0Ny84Q0lYK2sr?=
 =?utf-8?B?NjZHczFlcWgzR0FmT0V1aGZaNFdJZTNnVkNaT0pweFFkR1UxdkJkczBPQ25u?=
 =?utf-8?B?ZU5langva2lDU3V4YnkrZHcvRGVtYVE4NkdvcUo5dCtKZWpJOE94K0svWlIy?=
 =?utf-8?B?TnZ5d2wyU01NUHM3QlpWbDk2OENFUkVsN0ZtYjZQMjVLdHo3OHJHQjZ1Z0xx?=
 =?utf-8?B?QkJKVFI1T3NobFFZNENnS3RlYkdtK3Z0K25lNlY2NG9qK0tuZHNhVklXNUFy?=
 =?utf-8?B?Q2o1TmlvVFNPS3FyOVJjeEMrMkJFSHI1b2R0Rytmb2MwYnpjM3JDWTRhL3Yx?=
 =?utf-8?B?TGxKendDbjBwNEZ1Zk9IYTVGbXE5TldRVlVTYVRnaUVteEE1Vit2NEswcWNm?=
 =?utf-8?B?bDFnSEp3cWppYWZJeDM2bUt4dlVFY25KMWxSTzM4alZrMkpDZXBUREVCNnpE?=
 =?utf-8?B?MHZxTVk2cHBvT29tQmtPR21lb0RYbHNEZythSXhubkR3bXYrT1RLRmVtNXpr?=
 =?utf-8?B?bEE4R3RkSXA4RWVUMkR0ZUJzNFVFSVhtUE1IdFNNOWQ2ZHBJRGhQZVNHKytp?=
 =?utf-8?B?d1BtYUJPQzROM1o3cDVIMmJhZ09odFdZRGxXRFRXOFFzTE9pTEVxRmd6ZVJD?=
 =?utf-8?B?d1IvcG1xZFM5dlZZbTBBNlFsVHB3a2VIZGxuc1d1MHhWVFRzT3ZhSlV3cnlH?=
 =?utf-8?B?R2FvL1RZQlNISmpTUlB6YS9yK0lIQXovU2NVdGhDa1ljWUZ4b3FQT1JKbFlt?=
 =?utf-8?B?K2RoRndxL2Z1My9GMU43YWw3VVQ4dzh2Q3h3WThEVzRYS1kvV0tlYkQ1UGF3?=
 =?utf-8?B?WERaclBQcDJnNS85cDg0Q3RNUnlJVHFDSUIxYWZqUmR5RmlSODJ3NXc5clVP?=
 =?utf-8?Q?1lD50w6O8SU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(13003099007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkZrNG1hbWpOejkyd2ZDSm9hdWZIcFFDZ1V4eFlTQjVhbzBjc2lrWG1NT3pY?=
 =?utf-8?B?cXNaY01hREluckMyUjhTZW14ZW5LYSs0NXZaREUwYW50U1phNy8rajBMRTBv?=
 =?utf-8?B?SWd5OERHSEdZMEVkNzJvTlBFQU1KK1QxZC8vMVpocVhIQ3lucmlNK25sZVYy?=
 =?utf-8?B?UklzcHlQa2lvNDVCTGxwTjVRQUFRT0ZWazVUSzIwb2ZmcC9EaG1sakNKRlBT?=
 =?utf-8?B?b2hOdGJxcFExb2lhY0tjcnBYbkxRZ083enhsc2xLQld2ZWlwa1ZCU3BiOWs4?=
 =?utf-8?B?K0lEZEZlTG9temZBaDhMTDVsQnRZQ1FCelJkd3ZRb3hMSm9hTGh1eDF6dUNl?=
 =?utf-8?B?dFFTWmE0ZmN3eDNlOXdhdm8wdVo0VEszQVJnbGZwcjdybVhOSzNOdFdxY2xz?=
 =?utf-8?B?Ny9UcFlKdGg5bHdaMUlzYUtvTlNpdkFZT3p6MTNxQytQMjNwV2xLMHBoc0ZI?=
 =?utf-8?B?RHYzREtPVDRvZXRWZWZDZUlZWXJKaU4wRGRjcXQ2a0FpOVhqTXNXTWlGdVM1?=
 =?utf-8?B?ZW5iMTJCVXRaMkZPdWxsQ1RDTzZSS3pURGRPLzhTWGk5WHl2MnU4aEQwekVO?=
 =?utf-8?B?WW1Ta3h2Vk1EaXJzdXVvblluT2JIOWQ1VGoyQ2lHeUgvK2dsbjgzQU82QlEr?=
 =?utf-8?B?MHdUaTNqd3RYekt4SWU4dmNMTHpxcnhxL2loOVNQZ25TZjVjSG1ZcXllOUxa?=
 =?utf-8?B?ZVlnL0lZQm9HYUVaUkU0RDdRMThhS2FZM2g5eFFyR1NZS2tISkhMUXJWdGtK?=
 =?utf-8?B?SGM2dDdVUndwV2xuYWhHdjlhY2ZpeHd6ZFBOZEhnU3lLNXJXV3REckV6dVR5?=
 =?utf-8?B?K1RWalU0NFJoWXBUb2FaMXdEVWFNZE0rOTd6SW9YRG4xOHdoeWMvTS84THFW?=
 =?utf-8?B?RVFQWlBsMWZTTndnRjBiNzd0WDVkaTZudjhrQXVwdGVzczMvZmg4MjhBdEJJ?=
 =?utf-8?B?ZUdFekE5N3NVaFlRTUhHeGhhazlGdEhmYWFuWDZ0dGFwNm10SjdoZlVzSG1E?=
 =?utf-8?B?WjNSRit6UnN2TUZpSUNQeWFXeHpQRGZvWlJUc0NXWVlSV0NJYWJPb2VTMEVq?=
 =?utf-8?B?eTVqMm52cDlDeDNUelphRzREanVxTGU4cDZNdDV4czdpMVNlVmJGNFk1bCs1?=
 =?utf-8?B?eUROd0loV3Y2bWtwcjNaOGM3MjBXdDVzV3J3b3NqZjVEOXVKU0VMU2s1Nmo2?=
 =?utf-8?B?UEZVRFU0b2ZWTzZPdC9TdTIyK0RJK1FxT0ZjM3BidXZSeTEvWVRGSTk1dndF?=
 =?utf-8?B?cnduTHN6MnNDcnlkME1hNnBacld5RHVscFcza3lDWjNDT0FzdTlTcEllbzVw?=
 =?utf-8?B?RGUxT1NEL2J0SXJlZldlUEEvaEtHU1Njc1ZOcmVYSkRLZ2xxeWdKSFZ3Nkpq?=
 =?utf-8?B?WFNpWk15aDgzWUR5Q1gvVTdIb3lGZmxFV2l5Q0RZUjJZMmp4Q1VqQklzWFJK?=
 =?utf-8?B?dFVrc2RRLzQwTFhqcU44bWtnYVlYeUIzR2R4TEdlZDBJeFAwZDg1M2ZQMXRy?=
 =?utf-8?B?aDBmOUVydDBDQlF4YVlWWS9iODZmYTlDZnJsOWVJYUFJQ29SdFhYRDRpVHRw?=
 =?utf-8?B?dzhXR0JEd1V1dU51UW4rSGdENUZzR2NydUhZWUdoN1Vvc0dDV2JaUml5aVRs?=
 =?utf-8?B?TkhWNktsOG5Na0d1cTVOa3J2dFVmendDOTNRb0dxb296am80MVhmYTVaY1Mr?=
 =?utf-8?B?c0FCL05TUkVXM2VTd3ExU3FaU3BZRXR2VEFWNzZkWk1nWG1vOVY5cWJ3S0Zm?=
 =?utf-8?B?ZE0wMWpvdjlqb045cTRWc3lRbXIxMHhENEo5dTZ1SjcrNTBZcnpORkNLNHpV?=
 =?utf-8?B?ZkdwdUx1bERmeHI4QkpobTU5TWVFMHNDdkFhODhCSFZ4ZndKdlFweG5tVWNk?=
 =?utf-8?B?Rzc0b2wrZFg3YkpkYTE3RGJNNTJsbnpQaXdJblJBajFkdFM4aUEwdHNTeldD?=
 =?utf-8?B?em9uYUxRa0xvMmNkLzczbEJZdmR3LzNRQ0FuWDd3VCttMk1ibURVc1hmRDAr?=
 =?utf-8?B?Q2xySTZmaUlNN003TW5uWTFpQnc3SlNwL0daQjlycjRPc1JTU2pCcXNQUWI4?=
 =?utf-8?B?c2hHWlFxZ0xKdkpBR3o0YkU5bWRsUXJmcTNueTYwU1plYTVsR2wwRHB1R2RY?=
 =?utf-8?Q?gSfMqFC4ZM5Li3AlQ+TqPdEr/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae41906-96a6-492a-62d3-08ddbecfe1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 10:03:40.9119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PeLzRvQG7qniWooIK+Vx5ArPsQRgdy0Rv9cjAbQcLyAPh3GdZXuWuE5g84wNcci7zUHImCqmM6nKIfcfb5sKyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4521
X-Proofpoint-ORIG-GUID: gdW_PhXkUZl7RpNh_-r8_y6kIDI5HfZi
X-Proofpoint-GUID: gdW_PhXkUZl7RpNh_-r8_y6kIDI5HfZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA5MCBTYWx0ZWRfXyB+tTpCqmaQ+
 QrG7GuYHfouwd6QuaH0NBylG2linzyqiHXfrSsqOA8IfrqNrF7+HgvuZdon+p6bA3YXOqw4Tbob
 kSpxH+HotEdfK4Y36p8WOL0orxe9XFaLYZnTKjxM0kpW12dKSIHYCmBuvpgzSGT6t6gaQqLV6pS
 VkEpi41+waaaBD4Zq2CmeLkORgpFtA4HfSZjdFzW/oLrtmVOnW8Q31tleOmxU7ePCE9LC/UYIrh
 npmQeLSfAIWXzqr/jcHmjL3dgSJTsTwPps5Uzps0zdtkJ/xRGTPcVYQKtra7HUCjtvTv8/CWCf8
 MeYyJhGB1hc4vKrYPohKpywvdjwyGrqgwz8WdXzHUAjdsftsbktptAlc4uGz9xpa6ZJpM2i3sU0
 Alb9ZNYvGRyEcW1HzFf5SyXDCjTtp7msay+ehfX2Sij17i4ocJZ+QDj7Rhdi0bNqfL/PZsL/
X-Authority-Analysis: v=2.4 cv=TsnmhCXh c=1 sm=1 tr=0 ts=686e3e80 cx=c_pps
 a=jIshG2S7E8nEleq52+39Ug==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8
 a=KKAkSRfTAAAA:8 a=xxuNhUqi4NFVTyCvAccA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
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

PiBPbiBXZWQsIDkgSnVsIDIwMjUgYXQgMTU6MTksIEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVs
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBUbyBnZXQgYmV0dGVyIHBlcmZvcm1hbmNlLCB1c2lu
ZyBhc3luYyBtb2RlIHRvIHJlcGxhY2Ugc3luYyBtb2RlDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGRvYy9ndWlkZXMvY29tcHJlc3NkZXZzL3VhZGsucnN0ICAgICAgICAgICAgICB8IDE1
ICsrKw0KPiA+ID4gIGRyaXZlcnMvY29tcHJlc3MvdWFkay9tZXNvbi5idWlsZCAgICAgICAgICAg
ICB8ICA0ICstDQo+ID4gPiAgZHJpdmVycy9jb21wcmVzcy91YWRrL3VhZGtfY29tcHJlc3NfcG1k
LmMgICAgIHwgOTQgKysrKysrKysrKysrKystLS0tLQ0KPiA+ID4gIC4uLi9jb21wcmVzcy91YWRr
L3VhZGtfY29tcHJlc3NfcG1kX3ByaXZhdGUuaCB8ICAyICstDQo+ID4gPiAgNCBmaWxlcyBjaGFu
Z2VkLCA4NiBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvdWFkay5yc3QNCj4gPiA+IGIvZG9jL2d1
aWRlcy9jb21wcmVzc2RldnMvdWFkay5yc3QNCj4gPiA+IGluZGV4IGEyOTA0M2UwYzAuLjg4MTJm
ZDE4MGEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kb2MvZ3VpZGVzL2NvbXByZXNzZGV2cy91YWRrLnJz
dA0KPiA+ID4gKysrIGIvZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvdWFkay5yc3QNCj4gPiA+IEBA
IC05NiwzICs5NiwxOCBAQCBUZXN0IHN0ZXBzDQo+ID4gPiAgICAgICBzdWRvIGRwZGstdGVzdCAt
LXZkZXY9Y29tcHJlc3NfdWFkaw0KPiA+ID4gICAgICAgUlRFPj5jb21wcmVzc2Rldl9hdXRvdGVz
dA0KPiA+ID4gICAgICAgUlRFPj5xdWl0DQo+ID4gPiArDQo+ID4gPiArDQo+ID4gPiArQXMgYSBy
ZWZlcmVuY2UsIHRoZSBmb2xsb3dpbmcgdGFibGUgc2hvd3MgYSBtYXBwaW5nIGJldHdlZW4gdGhl
IHBhc3QgRFBESw0KPiA+ID4gdmVyc2lvbnMNCj4gPiA+ICthbmQgdGhlIFVBREsgbGlicmFyeSB2
ZXJzaW9uIHN1cHBvcnRlZCBieSB0aGVtOg0KPiA+ID4gKw0KPiA+ID4gKy4uIF90YWJsZV91YWRr
X2NvbXByZXNzX3BtZF92ZXJzaW9uczoNCj4gPiA+ICsNCj4gPiA+ICsuLiB0YWJsZTo6IERQREsg
YW5kIGV4dGVybmFsIFVBREsgbGlicmFyeSB2ZXJzaW9uIGNvbXBhdGliaWxpdHkNCj4gPiA+ICsN
Cj4gPiA+ICsgICA9PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiA+ID4gKyAgIERQREsgdmVyc2lvbiAgICBVQURLIGxpYnJhcnkgdmVyc2lvbg0KPiA+ID4gKyAg
ID09PT09PT09PT09PT09ICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gPiArICAg
MjQuMDcgLSAyNS4wMyAgIDIuNCAgLSAyLjgNCj4gPiA+ICsgICAyNS4wNysgICAgICAgICAgMi45
LjENCj4gPiA+ICsgICA9PT09PT09PT09PT09PSAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY29tcHJlc3MvdWFkay9tZXNvbi5idWlsZA0K
PiA+ID4gYi9kcml2ZXJzL2NvbXByZXNzL3VhZGsvbWVzb24uYnVpbGQNCj4gPiA+IGluZGV4IDM0
MTEzY2QwOGMuLjMyY2FkZDAyZWEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2NvbXByZXNz
L3VhZGsvbWVzb24uYnVpbGQNCj4gPiA+ICsrKyBiL2RyaXZlcnMvY29tcHJlc3MvdWFkay9tZXNv
bi5idWlsZA0KPiA+ID4gQEAgLTEzLDcgKzEzLDcgQEAgc291cmNlcyA9IGZpbGVzKA0KPiA+ID4g
ICkNCj4gPiA+DQo+ID4gPiAgZGVwcyArPSAnYnVzX3ZkZXYnDQo+ID4gPiAtZGVwID0gZGVwZW5k
ZW5jeSgnbGlid2RfY29tcCcsIHJlcXVpcmVkOiBmYWxzZSwgbWV0aG9kOiAncGtnLWNvbmZpZycp
DQo+ID4gPiArZGVwID0gZGVwZW5kZW5jeSgnbGlid2RfY29tcCcsIHZlcnNpb246ICc+PTIuOS4x
JywgcmVxdWlyZWQ6IGZhbHNlLCBtZXRob2Q6DQo+ID4gPiAncGtnLWNvbmZpZycpDQo+ID4gPiAg
aWYgbm90IGRlcC5mb3VuZCgpDQo+ID4gPiAgICAgIGJ1aWxkID0gZmFsc2UNCj4gPiA+ICAgICAg
cmVhc29uID0gJ21pc3NpbmcgZGVwZW5kZW5jeSwgImxpYndkX2NvbXAiJw0KPiA+ID4gQEAgLTIx
LDcgKzIxLDcgQEAgZWxzZQ0KPiA+ID4gICAgICBleHRfZGVwcyArPSBkZXANCj4gPiA+ICBlbmRp
Zg0KPiA+ID4NCj4gPiA+IC1kZXAgPSBkZXBlbmRlbmN5KCdsaWJ3ZCcsIHJlcXVpcmVkOiBmYWxz
ZSwgbWV0aG9kOiAncGtnLWNvbmZpZycpDQo+ID4gPiArZGVwID0gZGVwZW5kZW5jeSgnbGlid2Qn
LCB2ZXJzaW9uOiAnPj0yLjkuMScsIHJlcXVpcmVkOiBmYWxzZSwgbWV0aG9kOiAncGtnLQ0KPiA+
ID4gY29uZmlnJykNCj4gPiA+ICBpZiBub3QgZGVwLmZvdW5kKCkNCj4gPiA+ICAgICAgYnVpbGQg
PSBmYWxzZQ0KPiA+ID4gICAgICByZWFzb24gPSAnbWlzc2luZyBkZXBlbmRlbmN5LCAibGlid2Qi
Jw0KPiA+DQo+ID4gSSBhbSBzZWVpbmcgdGhpcyBub3cNCj4gPiBEZXBlbmRlbmN5IGxpYndkX2Nv
bXAgZm91bmQ6IE5PLiBGb3VuZCAyLjkgYnV0IG5lZWQ6ICc+PTIuOS4xJw0KPiANCj4gSGksIEFr
aGlsDQo+IA0KPiBUaGUgbWFzdGVyIGhhcyBtZXJnZWQgYSByZWxlYXNlIHBhdGNoIDgwYWRlZmEg
dGhpcyBhZnRlcm5vb24NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3Vy
bD91PWh0dHBzLQ0KPiAzQV9fZ2l0aHViLmNvbV9MaW5hcm9fdWFka19jb21taXRzX21hc3Rlcl8m
ZD1Ed0lCYVEmYz1uS2pXZWMyYjZSMG0NCj4gT3lQYXo3eHRmUSZyPURuTDdTaTJ3bF9QUndwWjlU
V2V5M2V1NjhnQnpuN0RrUHd1cWhkNldOeW8mbT16dV9sQw0KPiAyV0lWNktxQmhTYTE1U093NHNZ
dkk2VzNTcm9tQ3lfWl9BMTltbGlGbWZieDZmUXNpOFNWbWRZN09WdiZzPW9Zcw0KPiBTVkRib3Bj
cjVhUk5XNl9aMzZKdXA2Y2NiS1R2ZTNWMUdwNmpVdFBvJmU9DQo+IEFuZCB0aGUgaHR0cHM6Ly91
cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fZ2l0aHViLmNv
bV9MaW5hcm9fdWFka190cmVlX3YyLjkuMSZkPUR3SUJhUSZjPW5LaldlYzJiNlIwbU95UGF6DQo+
IDd4dGZRJnI9RG5MN1NpMndsX1BSd3BaOVRXZXkzZXU2OGdCem43RGtQd3VxaGQ2V055byZtPXp1
X2xDMldJVg0KPiA2S3FCaFNhMTVTT3c0c1l2STZXM1Nyb21DeV9aX0ExOW1saUZtZmJ4NmZRc2k4
U1ZtZFk3T1Z2JnM9WXQwQThGOA0KPiBvOTZwbEVBc3k0VmZtRUx2RGtqR1B3aDNZa2NwY1h6V3Ri
YVkmZT0gaGFzIHVwZGF0ZWQgdG8gdGhlDQo+IHJlbGVhc2UgMi45LjENCj4gDQo+IFdvdWxkIHlv
dSBtaW5kIHJlLWNoZWNrLg0KPiANClN0aWxsIGdldHRpbmcgdGhpcw0KDQpEZXBlbmRlbmN5IGxp
YndkX2NvbXAgZm91bmQ6IFlFUyAyLjkuMSAoY2FjaGVkKQ0KRGVwZW5kZW5jeSBsaWJ3ZCBmb3Vu
ZDogTk8gZm91bmQgMi45IGJ1dCBuZWVkOiAnPj0yLjkuMScgKGNhY2hlZCkNCg==
