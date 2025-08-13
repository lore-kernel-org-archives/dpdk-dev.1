Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB94CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 07:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E06DE4021F;
	Wed, 13 Aug 2025 09:42:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 472E8400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 09:42:45 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D7aNHw007410;
 Wed, 13 Aug 2025 00:42:40 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2129.outbound.protection.outlook.com [40.107.223.129])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48gpfar0ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 00:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1EGglTGjIJrNWjzQXkQgkKnvz9OL+x2/IuKEyeQaAnjpNHb4M24w7LzYEPaJ5nTFn42AQ4UdntO2D8RaW0K6vH/UYkZ3olVp0blLuvP3j61aMwvk2xO/Zz+KoqUvTQ0eoxnyoaounxB92Wgl7GMGQZzEIrsQFW02HxytKbUzN0ZyhlrVY3yOcH8J1vpiy+1OFBTHCDS05fe1cbdnhfWITMDngGS/aWQWkXXzgNPFOR0QnYqrxJYxzWq7mivxPuwBKPXA0ryXHH6J8znBp41z/vE+xDkBL+/4di9b8htklTMXWFSl0LlH49xPHrEpZMsugSTuO/OywTvfMVUOaZErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xImERGiGEgeeIYx27XN4V+wGycGAqGHZ1Y2iH98jwCY=;
 b=c+HfDel2Bj3bNA/9goJTH9nCOIsCNpYwLs3FE93Y1oT3KpjgUDY5cpjrP9Es2/inux6JQtoboDqJFSIqcC35gR0U5JXIDZ0cU0PKJkD45Xkw/skVqvnMOUtgkK3MRO09RdnbXTjG2OHWvFY+SHTobrURVbV30rAqETlX9RlyaoMkTkp5r9vjxQ4/IG+0GfGJgrPZ34dinxFmGGOW47YD9P1HCIfNooaklhvN8kKi6qcrIrw3CbxgzskH7YToQ0EVIeg4qOZATH5ZiO9UsZ+m3SbTSdCd+RRj69J2yd2034Eht6Mu3L5f4pKeEKnaabT/a3VsDiluM6gY717bD7828A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xImERGiGEgeeIYx27XN4V+wGycGAqGHZ1Y2iH98jwCY=;
 b=mnPpiNnrXLdieEA9WYUKpx38DKNOf8Q7cWmhQPwW96wrSAiIprKvYy5/nEUCaUdxqk8aH2d/5QA/NCgFHQZu7cEkrad3Mkg23qeP8Pg4veFF4kBBpOY4bQaAnaZrIIryj6OlbXxAwSd1FWBWde0fIzTV9IL3iIV03v81NlNxgbo=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by SJ0PR18MB4527.namprd18.prod.outlook.com (2603:10b6:a03:3b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 07:42:37 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%3]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 07:42:36 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Stephen
 Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHb1sV4glZQDx84DkubxQo6XdgHSLP15I0AgABbtoCABZrpAIAAGSKAgGSogLA=
Date: Wed, 13 Aug 2025 07:42:36 +0000
Message-ID: <CO6PR18MB3860D708EC9F561A28AD5B75B42AA@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250605113159.3035480-1-skori@marvell.com>
 <20250606092904.3145608-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCD0@smartserver.smartshare.dk>
 <20250606082307.152616f3@hermes.local>
 <CO6PR18MB3860A0F5A75F34D2C76F1B58B46AA@CO6PR18MB3860.namprd18.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCD8@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCD8@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|SJ0PR18MB4527:EE_
x-ms-office365-filtering-correlation-id: 3816fcbc-0b18-4de4-44ff-08ddda3cf915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWwycWQ3ZXkrbWZiaElKeHlKclZ1eDFMVkthY3RIYkRrRVhCOXJPMXlCTzNE?=
 =?utf-8?B?WktjSENqakhTZlowdVBZN3ZFOVZPSkcyNXRYT0ovV0EyV01WNUNXNTFmUTB0?=
 =?utf-8?B?clFpV3RJdk1uZFk2aUFPWUhmazVOcVdjMlJLVGhOMTRrWU5GeDAweHUvNFVt?=
 =?utf-8?B?T05iTnpFQ0VoVk94bi9CMDl3S3lXZTJMc3hKUFk3MThGcTBUQnpJZmt0cHZC?=
 =?utf-8?B?VXl5YzFVZHBWNUtBQTAzNk1Xd0tQSWE1a1lPQkFLV01GeG9YSGVmSDJ5YXl4?=
 =?utf-8?B?dCtaZU0xenBzZlZjY2lpcWJoaDM4NjQvQktGR2VtakJRLzNJbFcrMUlVV1Fi?=
 =?utf-8?B?aHpQUjNjSEJhZW9yZW1DczN4bWpFS044My9EZ3BoU2EydHJSMHlwaWxOa3M4?=
 =?utf-8?B?L1A2NlhITk1pNjdVYjZjWndKMFBIZzRvem1Eb1hBa0JmNDB4cFhjQWpMYjZ5?=
 =?utf-8?B?RVF5aUU0VU1DRUJoQ1p2Mmxrc3luSm85UXpXWUY5Q2NWdGVNOHMva042eUxQ?=
 =?utf-8?B?NTVQLzNoL3ZSaGdsZFVCMjloazJ0Rk5icG0reCszenJrWEFRd0laVHZSSUlR?=
 =?utf-8?B?NTkrMzU3T0lPWlZaaThlTGNCWlozOFZzWU93emRUTjdidkJJZWpIRVM2VVRG?=
 =?utf-8?B?ZGMzSmdNVXpjV29VWVBOTUU1MzlRaFJHaE5HZW40ZFVYK1Q2RFUxVm44V3dv?=
 =?utf-8?B?M002UXNUUTZ0SlE2aEc4dEZhWkZaWk1wTDFGVnh0Mm0xR1BGaURkY29zeWNj?=
 =?utf-8?B?aUlsTVFERjU4anFjOWprRGc2Ylh1aEFIR1pUT2pnRDMxbnhQb1RHQUY4cm00?=
 =?utf-8?B?c3ZNQk1PZHdMVkxTeHVJNU9rejdZdlVGcFdqdWtkcTdIOUR0c3o0V0JMaEUv?=
 =?utf-8?B?bVBNeStNUGNVTnY4NHNoZm9CU0NmbWd3dDFhYUhnUGtmYzBVRER3OU1DVkQy?=
 =?utf-8?B?TGpGK25wZTNVbExxUytXSkhiS2tOVVFzWllZUVhKSi9WSm5Scy9YYjM1bmR5?=
 =?utf-8?B?TWJqakhVOS9jY1NlM2lkdm5tY3pELzFpWnRDOVhpb3hqcDBtcllUM1c0MllQ?=
 =?utf-8?B?dmZxWC91Q0lDU1JjVmI2VjJOMG5FSlZXZndVbGRoMGF5a0pNbWc1TFk2Witl?=
 =?utf-8?B?WUJSSnNFUWhpdmJGWGxIZ096K3V5djRDRHJuMlBkS05ETHQvajBkeTBVaGhC?=
 =?utf-8?B?OEViWDdTd3U3K0RWQllPTlBOditLckkvdnpZTmtDMjNOOWtvakpJNS9jZGZB?=
 =?utf-8?B?YS9TVnU2MzZXdFhYT3duL01vcXU2T1N5bUg5aEV4YTZmZ1RWVTh1ZkFKeHNK?=
 =?utf-8?B?dGtjVFVIb2ozRFUrRmpWSU5iekdNY2hKQkltbEllRno4Tm5ZYm50SkxyTS9E?=
 =?utf-8?B?MG9BWWI1blZNNVVuRVkremlndkxkaklQWXpFcVViek4yOUw3ZmhKcGFOZy9q?=
 =?utf-8?B?T29vR1grREdOUFI2bU1ieXBudXB6RE9ENmRlU25vcmR0S3RkdEdSd0FZelBn?=
 =?utf-8?B?Z3owV3RoRHRPbmVBaWw1NTJTQkpBQ0xHNmQ5UHFSdzRVeU5LSDhuQXNPKzMw?=
 =?utf-8?B?a1BsclV4VFkzU3NnZUVaU2x6N3VKYTh6b3IwdXBjaVlwZUczaHkwbjR2VS96?=
 =?utf-8?B?NnBPQ2gyYmk2MmFpZU4wWU9pUzUzb2J4UjdxVlYvS0JRY1R0RVNCK0szMXVE?=
 =?utf-8?B?T1BFdWNvZGcwM25mTkJRdVJONUtzNEV1enpiSVM1NVZVS0hUa0c0bEhxcHdB?=
 =?utf-8?B?ZncxQkRmYzBOdVlWNTROYitxaFdyRVY1VU9EdVBsMkxQUnRPL09mMjgwdmNE?=
 =?utf-8?B?TnNPVzRjTVZtcWp2Y01TMy9SOTV4NzFYMlZwQytLTm1BVFQzR25oc3dpa3RK?=
 =?utf-8?B?Qkg2ZGZuM21xRGx4VjdjajNSUnllN2hWSG1NcWdNZjlybk9hM2YrVHFGaSsr?=
 =?utf-8?B?R21vUmlHY2lJZWlCRzBDVGM1N1VJbjVFZ1E4TFVlU0hLUC92SW5UdVF5b3NJ?=
 =?utf-8?B?VEZQSEF6WWdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WURmQ2ZUaGp1RTdJZmJEamRHSGVPZmtRZE1uMGNDZ3hDWEdMZFZnMHlZTThN?=
 =?utf-8?B?OWxEZGZqTkk1YTdnRGpUQnBSekhoM3EydkJReW1iRlQyREpsV0QwM0hjVzM2?=
 =?utf-8?B?RkVKbmM0cktQSExWYnN3aE5adHUvM2cyblliZXkyeVJOUUREc2FUcGRHMzky?=
 =?utf-8?B?SU9LeEo5RVpIT0xtWjErQzN5TEtJRjYzUGtLclVSd2xRclZnc21obzh3c2JS?=
 =?utf-8?B?bVQ0VlM4b3NTMHYyUUR2WHoxcVFTa1U1ZUx4VGtQV1hmMDhtUDNJTzk2bEQ3?=
 =?utf-8?B?NFNBUzBIK0JIb3VEcXEyRkhGNjZWYTZPSjJuYldnYlZTcjFZUXQ0UzdnVHFH?=
 =?utf-8?B?QW1XWDZFL1RoN3U1T1NBRDBLNUllV1FJZnVCOVFEL2JHaTlSc3prR3d2V1gx?=
 =?utf-8?B?YW9pYnorK1NVSGFPSzkvSTBUUmhtc2FnSjRTbjVjZ2FsUHEweGVLRVJZTlp6?=
 =?utf-8?B?bmRoazBIUWNZRWNBWFJ5UnJkWUE1WkszbTI2Y29wRGt4a0llRUp5MVJxdXlt?=
 =?utf-8?B?RDdBdDV2RkxvMkJDU1ExTnAxVWVyaU0vdW9Rbk1vR28rU3I2cjZ2RUVWVDhP?=
 =?utf-8?B?bzZENDBIUWpKYUxxS1ZxdTdNWDVuNjNHZm8wM3kzZk1SQ3JvcFVsWmNkNWZ0?=
 =?utf-8?B?S2dRZXNvbURrOE4yNWVXNDBoRU0vc1VDNk4rMHlXenMvYWVqRXJvQ2hKR1ph?=
 =?utf-8?B?dGZNNGs2ZmNadnJmMEFXZ3YxM0JGSWVQOHI1ZzYySGRCaEJHcWVxYk12Qkxl?=
 =?utf-8?B?cHRVNWZnSXZMa3YyVzNDa1IyNnEwYmpyaldCd3NrbWs3RDUzZW81RWs4bi9B?=
 =?utf-8?B?UnVLQm83Vm9zM0JJTDg2TTVMaTVSdGpxQXNIcUg4R21TakhJaHQxdkViMDFF?=
 =?utf-8?B?R2NJckF0ZlR6YkZPQmxHbkZCRzR3LzJhY3RHZ0Y5WCtwZWtUWHlibEpZcnhQ?=
 =?utf-8?B?MGdPQ2QrclMwbFlLd2UrWUU2VkkwQzNEeVgvbmxqR1h0djJlRDlCNjQxWjlj?=
 =?utf-8?B?RVQ3MXExYUlCSEc4a0tUSE1QKysxRTJBclora2JRN3ZNTGtqbU5MRE5UMm51?=
 =?utf-8?B?R3pGRzFGeWFyWHRNaGN1Y0lCaUxjL1JHcWhzcEFlMTd1NnhPN1ZLQlFDUW1N?=
 =?utf-8?B?Wk9neDkrd29rZEl4M0NyWWtUTDVpbEFRdDB4WW1jaGRHUURxOVVTQUJicno0?=
 =?utf-8?B?VWRmbGFLUGFQTGJJamVrb2sxRlljRys1b3BlOEJod2J1VTBseldsRHF4cWha?=
 =?utf-8?B?WndDSmZpYzBGVUhKTnFXS0tUckJ5S1Q3NE16Q0I1S3F3TWxmZWo1WU5DenVY?=
 =?utf-8?B?cHdiTTg5Zzd5eEFqaVdtY1FPWnl6V1c5Yy9NUGY0MTBiSjdQTlkvVU9TUlo3?=
 =?utf-8?B?WFZMNzVDUWkwbWpzdmR6NXFSaHVnT0xpM2NESTE0ZzNlVWpLUHNWTUxnZy8v?=
 =?utf-8?B?bmRGSkR0S3d1YlRXSCtyUlpYdUJaWXBRSnBYTGdFd3pBaVdXeC9TNFRNUjRE?=
 =?utf-8?B?bmJ4L0UwbG0xc2pVRHNxZWtMZ05VdGVFcmZNakw0VUVvbG5acnNNUVRINGV4?=
 =?utf-8?B?R2hXc3JOamdoMHRzckxyK3doSzdqMTBBeHRzdG1OZ1NtVHYwempzR1VKc3B6?=
 =?utf-8?B?UDFIYzhjd0dxQ3NnbjcxSlFzWXMzNjZ2cWVlV0JqeXc2Kzd3WWdPVkVVTzZG?=
 =?utf-8?B?TC9nTzQ0bjZGRWFYejZqRjhqdkx2eHRkMkQ0dWlYaHhNSDhSbGhHVFBnVlFB?=
 =?utf-8?B?Y0hsQjlDaWpqU0k3NklUcitXdjVUdHNWUVJKZTQ2OTlUYUZ3eXdJZURPTzAw?=
 =?utf-8?B?ZnFOcVNyVGJDT2c3T1U2dldRMjk0QXNSdklKSk8xbUV3WG9iNGxJNkJGRk53?=
 =?utf-8?B?Ujg1S1NGeTMrcVNKQ2VqWWlsMUpveWxBZzN6eUpuT3lBV3ZHRURvMjFPRExM?=
 =?utf-8?B?bVJQcjhSeGtCSHM4cXpzMjR2UjNubiszL3M0YVdvaUVHVDdKaHJubjBzSVlU?=
 =?utf-8?B?cStZRGtEbk5CSnZ0RStTN3oxSlQ2UVJoUnVJd25wUCtKZGVpSHNPUklVLzVO?=
 =?utf-8?B?OXFnUVVGZFUxcG04RFZSQndESHRFd0F6V0RUZTVmNUNyS3FjRkdmMEg5L0JZ?=
 =?utf-8?Q?UfKg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3816fcbc-0b18-4de4-44ff-08ddda3cf915
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 07:42:36.8070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaoGGEkueAx3wXqGWKi+r5XTvxMyJ5pTkqjLFQ96sMO5vN3CUAEz3Vd9Wd8LAUCkq0sZDHEPYvIuVcld6vsLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4527
X-Proofpoint-GUID: rb5n9BLKzQvc6cIzQcoJmvztCpkDEwOT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA3MyBTYWx0ZWRfX8GF39ihtS9Hm
 LguhclXxAyDKrJXNQjrdWMSwIcwMyTNTN++CcLLpRSO/8luIo16v4kPR3aCLqcJ6Qn4yxA0464B
 uDBBCLB4VlJ3GM80eK1MNKGcqu4+Lcu+Fr2QCDDzIOR+GLkl89nqnNcE5SLjNYtvCHCDBo+iCXk
 ExEKt9+AK9B4DIVjTwDef/yd0IrffXDzfz8yOFmPDmIOspOXiob0KzbOp0ALcgTmgzD1UcBdzm7
 yRN3qkDeTM7yv3qaxrC/m+0V0nUa/MuPPlrxMES1EsynNsuZAT/4qfo7tIacQEWIP72YXOXyXka
 n0WpltHnEaM5MDGaI6jKpo3RMFtQEtsNIuEIx199PUXM+lYumbC5JJfFkNpxHojzuaDofzZGwaO
 olhSkWE0tnoQu2ssNZ6OcE1sKKSpamWor2AVn6jLgtyL4gTO2ecdi2MhYq/qizJOSrmE50zJ
X-Proofpoint-ORIG-GUID: rb5n9BLKzQvc6cIzQcoJmvztCpkDEwOT
X-Authority-Analysis: v=2.4 cv=O7M5vA9W c=1 sm=1 tr=0 ts=689c41f0 cx=c_pps
 a=rpzdijBBfSkI3xxH5MEd0g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=n02bokGJAAAA:8 a=BoOCL9KGDXzssFcC2a4A:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=rszdq1ld3peujIA30KyE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
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

SGkgTW9ydGVuIGFuZCBTdGVwaGVuLA0KDQpUbyBhZGRyZXNzIHlvdXIgY29tbWVudHMsIEkgcmV2
aXNpdGVkIHRvIGNoYW5nZSBhbmQgY29uY2x1ZGVkIGZvbGxvd2luZyBwb2ludHM6DQoNCjEuIEV4
dGVuZGluZyBMaW5rIFR5cGVzIEFsb25nc2lkZSBMZWdhY3k6DQoNCkknbSBhbGlnbmVkIG9uIGV4
dGVuZGluZyBsaW5rIHR5cGVzIHdoaWxlIHJldGFpbmluZyBsZWdhY3kgc3VwcG9ydCDigJQgTm8g
Y29uY2VybnMgaGVyZS4gSSB3aWxsIGFkZCBmb2xsb3dpbmcgbGluayB0eXBlIHRvIHRoZSBsaXN0
Lg0KDQoJLSBOT05FDQoJLSBUUA0KCS0gQVVJDQoJLSBNSUkNCgktIEZJQlJFDQoJLSBCTkMNCgkt
IERBDQoJLSBTR01JSQ0KCS0gUVNHTUlJDQoJLSBYRkkNCgktIFNGSQ0KCS0gWExBVUkNCgktIEdB
VUkNCgktIFNGSQ0KCS0gWEFVSQ0KCS0gWExBVUkNCgktIEdBVUkNCgktIEdCQVNFDQoJLSBDQVVJ
DQoJLSBMQVVJDQoJLSBTRlANCgktIFNGUF9ERA0KCS0gU0ZQX1BMVVMNCgktIFNGUDI4DQoJLSBR
U0ZQDQoJLSBRU0ZQX1BMVVMNCgktIFFTRlAyOA0KCS0gUVNGUDU2DQoJLSBRU0ZQX0REDQoJLSBP
VEhFUg0KDQoyLiBBQkkgQnJlYWthZ2UgQ29uY2VybjoNCiJJJ20gbm90IGVudGlyZWx5IGNsZWFy
IG9uIGhvdyB0aGlzIGNoYW5nZSByZXN1bHRzIGluIGFuIEFCSSBicmVha2FnZSwgYXMgdGhlIG5l
dyBiaXQgZmllbGQgaXMgYWRkZWQgd2l0aGluIHRoZSBleGlzdGluZyBzcGFjZS4gQ291bGQgeW91
IHBsZWFzZSBlbGFib3JhdGUgb24gdGhlIHNwZWNpZmljIGFzcGVjdHMgdGhhdCBsZWFkIHRvIEFC
SSBpbmNvbXBhdGliaWxpdHkgPyIgV29yc3QgY2FzZSwgc2luY2UgdGhpcyBpcyAyNS4xMSwgQVBJ
IGJyZWFrYWdlIGlzIGZpbmUuDQoNCjMuIFJlcG9ydGluZyBMaW5rIFR5cGUgYnkgRHJpdmVyczoN
CkdlbmVyYWwgQVBJcyBvZnRlbiBleHBvc2UgY2FwYWJpbGl0aWVzLCBhbmQgZHJpdmVycyBzZWxl
Y3RpdmVseSBpbXBsZW1lbnQgdGhlbS4gU2V0dGluZyB0aGUgbGluayB0eXBlIHRvIDAgd2hlbiB1
bnN1cHBvcnRlZCBpcyBhIHJlYXNvbmFibGUgZmFsbGJhY2suDQpFbnN1cmluZyAwIGlzIHRyZWF0
ZWQgYXMg4oCcdW5rbm93buKAnSBvciDigJxub3Qgc3VwcG9ydGVk4oCdIHJhdGhlciB0aGFuIG1p
c2xlYWRpbmcuDQoNCjQuIFJlZ2FyZGluZyBtYW5hZ2VtZW50IGludGVyZmFjZXMgZm9yIFBIWXMg
b3IgbW9kdWxlczoNClRoaXMgcGF0Y2ggZG9lcyBub3QgaW50cm9kdWNlIGFueSBtYW5hZ2VtZW50
IEFQSXMgZm9yIFBIWXMgb3IgbW9kdWxlcy4gSXRzIHNvbGUgcHVycG9zZSBpcyB0byBleHBvc2Ug
dGhlIGxpbmsgdHlwZSBhcyBhbiBhZGRpdGlvbmFsIGF0dHJpYnV0ZSB0byB0aGUgdXNlci4gQW55
IHN1cHBvcnQgZm9yIFBIWSBvciBtb2R1bGUgbWFuYWdlbWVudCBzaG91bGQgYmUgaGFuZGxlZCBz
ZXBhcmF0ZWx5IGFuZCBpcyBvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGlzIGNoYW5nZS4NCg0KVGhh
bmtzDQpTdW5pbCBLdW1hciBLb3JpDQoNCj4gPiBGcm9tOiBTdW5pbCBLdW1hciBLb3JpIFttYWls
dG86c2tvcmlAbWFydmVsbC5jb21dDQo+ID4gU2VudDogVHVlc2RheSwgMTAgSnVuZSAyMDI1IDA3
LjAyDQo+ID4NCj4gPiA+IE9uIEZyaSwgNiBKdW4gMjAyNSAxMTo1NDo1MiArMDIwMA0KPiA+ID4g
TW9ydGVuIEJyw7hydXAgPG1iQHNtYXJ0c2hhcmVzeXN0ZW1zLmNvbT4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gPiA+IEZyb206IHNrb3JpQG1hcnZlbGwuY29tIFttYWlsdG86c2tvcmlAbWFydmVsbC5j
b21dDQo+ID4gPiA+ID4gU2VudDogRnJpZGF5LCA2IEp1bmUgMjAyNSAxMS4yOA0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gRnJvbTogU3VuaWwgS3VtYXIgS29yaSA8c2tvcmlAbWFydmVsbC5jb20+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBBZGRpbmcgbGluayB0eXBlIHBhcmFtZXRlciB0byBwcm92aWRl
IHRoZSB0eXBlIG9mIHBvcnQgbGlrZQ0KPiA+ID4gPiA+IHR3aXN0ZWQgcGFpciwgZmlicmUgZXRj
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQWxzbyBhZGRlZCBhbiBBUEkgdG8gY29udmVydCB0aGUg
UlRFX0VUSF9MSU5LX1RZUEVfWFhYIHRvIGENCj4gPiA+ID4gPiByZWFkYWJsZSBzdHJpbmcuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaXRoaW4gRGFiaWxwdXJhbSA8bmRh
YmlscHVyYW1AbWFydmVsbC5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3VuaWwgS3Vt
YXIgS29yaSA8c2tvcmlAbWFydmVsbC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gKy8q
KkB7QG5hbWUgUE9SVCB0eXBlDQo+ID4gPiA+ID4gKyAqIEV0aGVybmV0IHBvcnQgdHlwZQ0KPiA+
ID4gPiA+ICsgKi8NCj4gPiA+ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9OT05FICAw
eDAwIC8qKjwgTm90IGRlZmluZWQgKi8NCj4gPiA+ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktf
VFlQRV9UUCAgICAweDAxIC8qKjwgVHdpc3RlZCBQYWlyICovDQo+ID4gPiA+ID4gKyNkZWZpbmUg
UlRFX0VUSF9MSU5LX1RZUEVfQVVJICAgMHgwMiAvKio8IEF0dGFjaG1lbnQgVW5pdCBJbnRlcmZh
Y2UgKi8NCj4gPiA+ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9NSUkgICAweDAzIC8q
KjwgTWVkaWEgSW5kZXBlbmRlbnQgSW50ZXJmYWNlDQo+ID4gPiA+ID4gKi8NCj4gPiA+ID4gPiAr
I2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9GSUJSRSAweDA0IC8qKjwgRmlicmUgKi8NCj4gPiA+
ID4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9CTkMgICAweDA1IC8qKjwgQk5DICovDQo+
ID4gPiA+ID4gKyNkZWZpbmUgUlRFX0VUSF9MSU5LX1RZUEVfREEgICAgMHgwNiAvKio8IERpcmVj
dCBBdHRhY2ggY29wcGVyICovDQo+ID4gPiA+ID4gKyNkZWZpbmUgUlRFX0VUSF9MSU5LX1RZUEVf
T1RIRVIgMHgxRiAvKio8IE90aGVyIHR5cGUgKi8gLyoqQH0qLw0KPiA+ID4gPg0K
