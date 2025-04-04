Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D291CC36010
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 08:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D43A40E35;
	Fri,  4 Apr 2025 10:11:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BE56740DD7
 for <dev@dpdk.org>; Fri,  4 Apr 2025 10:11:12 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533La4gC003212;
 Fri, 4 Apr 2025 01:11:12 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45t2cugysh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Apr 2025 01:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzzouY6Z1mFqIZtkn8lUBF9cmsRuzrL12q+wkQoT7beJKnON+VrDgrQ2w2GByoNwEru6JG2+JvUjjS6uMOcbw7KEd4VElkeE7nBTry1ssY54oP9QVFFbbf4i8SYUhCz0tInqS9TBCYHq+CtC2OEJt8ON0C2UhOechabaW41S6icA6ZHeY7PqRbJsclsVZd3+uPhcoV645NNeNMZY4Vfy/YM//79CQppBshpiUHwFcwpwu5/slFPkP6DHvTqXjnWUovrogcVh5etPPq7z6JJ4VSYqJVXy4UhjGWIa98dZvsC5uUw3kmr0MP4BAtFbaOYKizILzqBaledzz+3ajZbL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GorBIaz4weH9ovJfose6kDgvpnQOBMUTWqE8U2aR5hg=;
 b=bMBLsNWYZDyN7UXd4J4ZWaJlweEL2Tp/7/Dokp7BCwDzKnJb+BzWoOoncvEgcI8QXLwmXlH+8KJx9zE5hI/rmzsilb4jxX4STZvkj9jFg+fFk+H6iQQfCR3k+IRlXqYSf74Eip769oJ7xj92fFmv2faLElCFUfHwzHQ+5Uj3m8nA147dngML/wNUEy5AfquT5VEPvDwQn01DHvg0l+ihFJ/LgHKxMdS4cnB0WRCbI3Zh9l3eIPnjsGLpegmxq071ZDQy33ecnzUMaNyPNBBAGO0N6LQBl3XerDCP9l3g0a4liL9yiZuhqLpksfeR3fA+qBpv2zXneghYHKL+JL3uZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GorBIaz4weH9ovJfose6kDgvpnQOBMUTWqE8U2aR5hg=;
 b=dEaMHkgCCIflV73+MOEUNcfyl9sh2z63gXNRaKx4yNsnGiOxaZ+pMaa5RhalYQPucgIpG/djgD5KMhCZWbPdakhMUrXwQD2xa05AzpsU72l4d13DgSjlrnTuyHAgJU4gP0P3L6s/91i53BIAlq0N63T6p1Kd1bb9zJn/un4MSzg=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 BL1PR18MB4136.namprd18.prod.outlook.com (2603:10b6:208:30a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 08:11:07 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%4]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 08:11:07 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Nitin Saxena <nsaxena16@gmail.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: Nitin Saxena <nsaxena@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Robin Jarry <rjarry@redhat.com>, Christophe
 Fontaine <cfontain@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob
 <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] node: add global node mbuf dynfield
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] node: add global node mbuf dynfield
Thread-Index: AQHbor18z+cQAkqR30K56ANYMCI3e7OO24cAgALk/QCAAWuGkA==
Date: Fri, 4 Apr 2025 08:11:07 +0000
Message-ID: <PH0PR18MB40861D73C3869C46BCCB4410DEA92@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250401042053.3518757-2-nsaxena@marvell.com>
 <20250401071522.67cf34eb@hermes.local>
 <CAG6-93zdmJ0V=zFzj-r3GZtjEiygLpHbhE_8SW6odoocz5S-5A@mail.gmail.com>
In-Reply-To: <CAG6-93zdmJ0V=zFzj-r3GZtjEiygLpHbhE_8SW6odoocz5S-5A@mail.gmail.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|BL1PR18MB4136:EE_
x-ms-office365-filtering-correlation-id: e62f861c-a23f-436a-07dc-08dd735040ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OUl5NGJRSDFpOVNEOEo1ZENqWUxzTWhEbXZNb1dQMmZNU2EwdDU0eUFSZmZY?=
 =?utf-8?B?Vm5ZRHNGS3dxd0VzQXlsMHdGeFNxb09vajFrNFYwVGJZVVk0WS9lb0RDNEUv?=
 =?utf-8?B?eFJUVXg0N2IrWUsxazh1WmZueHFBM0dRRkhibWQ5R29ZbTVwdVIvMnJiWTFD?=
 =?utf-8?B?RWlYZmtjRStTSnpGMktXWmZPdXJWQUNlSWd6L0xTbEN2YXQ2ejh4WEFwTXZJ?=
 =?utf-8?B?c3p6cDRFWTNQUDEyd1lHYlFlNW5PVDNZeWJvRTlhbEpqRWV6blZYeW9mK081?=
 =?utf-8?B?ZDFwS1FVVFpqVVBlS3B4NEdEQzFrY1ZkZXNiSVRmT0l5RWlHZ3kzWnVCTVIx?=
 =?utf-8?B?elFWQ0I2MWQyRUIwbVlUSTlvVm5LMDB5U2I5VVVOdHZjS2Y1RVViU1RBVWIz?=
 =?utf-8?B?RU1pdG1iUnUvaU5qdXVEc3Nib0tGZzYrZk55TUtwZWFxUDBSQWtPRCtMSFll?=
 =?utf-8?B?YVFuOEc0NVh0R3dGbVJwV0JlTk40NlpzR2REVGNDdU9lRTVSNUI1MkJhb1R4?=
 =?utf-8?B?eU5jUGVpSGM0Q2RIbkxIODhGZU4xak5qUWY0Y0xVNWl0R1FRZVdzaUpkazM4?=
 =?utf-8?B?NWpBS3R6RVdueXYvNzM4STBwOXVYRk1YUndRa013S296Y2VuUkRmNksxa1pS?=
 =?utf-8?B?MmZYZ0pjNEpxZGk1SFFDNTY2TTVzVzhBdmloYm5ERmJzcXRBelVVYUVsUlQ2?=
 =?utf-8?B?VE9Da3JLRzQxUTgzKzlKTi9BWE5GdmwvbDdmdHU5alk2UUtYOFVCS2tJZjN0?=
 =?utf-8?B?MDcreWtYWnBjVE9KVVluUHJyUXVnY2xDaVBLcUtVUElrQ1dGNGdtSndlMDdX?=
 =?utf-8?B?N0lscmNmM0Y4N0Q0NEwyTlQzTlNyMm1yY0hwZlJ5aVFDOTZmWVgrd2RrSGpw?=
 =?utf-8?B?b2xoRFozMzB4QS9tV0M0RDZFUmpsWmtKOEpmQVdtUjBGNmpDa3ZMc1Z4RWll?=
 =?utf-8?B?QW55NXZsYkVwNWhkQnV4OEFCdkIxc3VtQlBuYjRSN2lxU2l2QmpSNW5BbkYv?=
 =?utf-8?B?L3pxNGI3b0pOZUd6ck55MWNaM3lJZGFqR1owMVJMTHpBYk1pYldaS3pSWGNY?=
 =?utf-8?B?SzcrdHlKZnBTbFdxdFhRakNrS2Zmd0p3RnArM1U1T2xteDI3Tml2bWc2c082?=
 =?utf-8?B?REZ0aktzeVVJTXNQbXFvWDg5Skc2c2tmWjZGRDhXcysxa3hOaDZWTHJGcmpu?=
 =?utf-8?B?c0dNalBlK09pVFk2eC92MmxUYXZLaWJ4dW1rYjFIK3BEbDNsMFBrRzlkdkJD?=
 =?utf-8?B?QlhweDliUXRRbVZua1M0bUVsaTJsWWU3bTRreWJ0MGtUOWY4anNBWFdMQzVy?=
 =?utf-8?B?dEUzanRBaFhKR2oxdWs1VVVsNS8vMUtVQkY4LzdVUkVrR0orVkVNVVRpMVNQ?=
 =?utf-8?B?N3BjVVAzWW1zM1JYUUtaaThkdFZGTmdiRFo3ZktBRXVnTi9OUzdIKzBiNlBk?=
 =?utf-8?B?WitJZnBUSHhVMGQyck80Um9WSTFJV21lQW1OYnpMQ0ZPVU1IWVZHaHJUUGhO?=
 =?utf-8?B?WGtQMTNHUXhVelQzTmtudG16TCsrNUxvd0x6dHQvVkpQUjNFS2k2cHpzQVQ2?=
 =?utf-8?B?ckhZbldFTmllbzNkUmlocFZ2cVpMeVQzTWVtMmprZC95Wjh5azVMSkYwR2t4?=
 =?utf-8?B?UVNsM0FFbm5jSUtXOVg2QldqY3A0S1BUYnVzNHB6TElhQ0tubmpuVHZIZGhZ?=
 =?utf-8?B?aEdxVWxrNUhwTGR2RjBaWW12TFcvajRSa1hSL0dacFdoVDdoODc1dUUwUEpQ?=
 =?utf-8?B?V29mZXl4VEpjRDVqTkNNKzhaM3VteXdjVVUvbjZCRWVYVldSb1V6bVdvK3V0?=
 =?utf-8?B?TXo1TGk5N3NpT0lobHhtb1VCVEtXMzBFUFBrUC9vY1NhQjYrQWh0cGxZVGRj?=
 =?utf-8?B?WjlxenZva0FWZUJ3NUY0bU5neWdaKzE4YjZGbXhyM2pza2FmZ09kRXZYc3Jp?=
 =?utf-8?Q?PT5RAsLudIl9595DY9vItMsu301JrQNC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1dmYkRuSFE1dXJiL2JUeW9jN1d3QnU5OGxBSmRvSnE3a2piczVSUGhDMjJz?=
 =?utf-8?B?SkZXTlgwQmt2MG1JRjNzMDdTclV3SnhDK3FUemtLcGloK1dzMVgyS08vRnhJ?=
 =?utf-8?B?d0JyN1lvTHNDa21QTEt6TkRmSnFzcFNGZlROK1NvelZJa21NN2x3ZTNlNytK?=
 =?utf-8?B?MVg1SUxkYlpBYmxQSWkzZ2lZaVZLR1dwOU1uaGxuMk1veTg0aVZHOS9zR1JL?=
 =?utf-8?B?OWZWNTRjaGViVTI2dnV2Y1o5KzBoRmczWmh4bUhORk5SKzhCOU42VlRsMTc1?=
 =?utf-8?B?Z20vc1gzM01yRFN5QUx0YnFKZnBhWEM3c3Jpa29LeGhzcnJLYnJLRHVScE1l?=
 =?utf-8?B?VlJ3dXM1MHBnSFlSbDJnSFV4TmlPTDBoN1VuM2VmTHlMd0drTXR6QmFBNi9C?=
 =?utf-8?B?czZzQ3pUK2ZuYVg4czl5aFc5cERIV2d1VC90UXdsRlNKOXhyamVQUDd5RFpi?=
 =?utf-8?B?OHoyZXN3cXl5WENZT245QUl1Rk4vcUI2ZU5taGtrcU9aSnBHV0ZBL3lET1k5?=
 =?utf-8?B?SzkyNXY2OTlPV3Y4eEN2Sm5YSW44SjBYU3dtNW1lOVZZaTJ6TGRYL0dLZWZK?=
 =?utf-8?B?VFl1Q01ieUR6ME9LbG5YNTJiUnBuckxzWmpCeU41UTJvSk1tdHZSdFk0TzRn?=
 =?utf-8?B?bGRQalFjeEZteE5ZeC96WWFyVFNIcDVXWWxLMUg1OHBRS29semFOU3BwUXFU?=
 =?utf-8?B?VEVnNk5DeUgrc3l2dTJydWlWd0dPRDFic0t1ck1HYlo0VXBBaXlJakJ2RlBH?=
 =?utf-8?B?dmpmeGxGV0dXSEpuVkJEOXA2RjFBMFc0YTkzZHhzcjIycTN4ZlNaS3VzdTl0?=
 =?utf-8?B?R3JhaHNGczQ0K1M5ODB1a2RLb1JlZDA2M1c0SnNmaWRycDRhRzZhdHNyYVlV?=
 =?utf-8?B?N0hJQUtHMjg0c0N5c2dsOWNoZ1U4VmpVYm9adnFVdVJZTU1hSU4zZXJhUkpM?=
 =?utf-8?B?RlJzK3VQZW9uSGRZS3J4Q2JBZmx0Y2Z3a0lVNWh4VzJRY0tPUDFmL1dyajcy?=
 =?utf-8?B?RHo5RXJDTkd5U0dvekQzZ2FOMVljM0M3eVF3eG1GTWZMNmZLRU9oNHFLeEhk?=
 =?utf-8?B?VzFNbnJGUGhMNFlNQjlxczkyYjVNNU4wYml4Mi85Q3h1Yy8vVU5UVWFFcnVX?=
 =?utf-8?B?R0pQa3hwVDFGRUdnRWtTdmcwSlZsdlZWYnVxUENQSG1NeHRCek5QbTFLOWYw?=
 =?utf-8?B?WU50QXc5RndSTXNXeko1TDlWclRsU2JuMHRjUnJyclBHbWE2UHpyUUt5a3ZS?=
 =?utf-8?B?SlpENnFYWHgrRlAvemtMSjZSTUUxRUwzNHVXQm40R1haZGtjUTNaK1pESmVQ?=
 =?utf-8?B?dExtbG9GWGNtekFSRXJaalYrbVdBbGdoTm9xUmNJdXh6OW9RWGFYbzJ6a0FM?=
 =?utf-8?B?SFVWRzFOT3JrdXk5VWVyR05QTWZ4SCtDUVdDK0lZTCtXT3JwNUdxQmVpbFg5?=
 =?utf-8?B?QXRzYzYxUW5Panh2YzJNOUhOOHhzcGFxSS82V2RBbTJQbE4zSjFqSGlwUi9G?=
 =?utf-8?B?ak9qaW1KM2dtaXQzQlhvMS9tMEhYRFdIVVU0MlBGM0I0azNFV1VQK0duUDJq?=
 =?utf-8?B?VjFJOWdpOFYrdHhTQ3NWZ3N1akVpMlJBNUM5clFUVzhUZXlHdEwzMVVPRVJn?=
 =?utf-8?B?TGpTY2ZtZDZOZm90RTlPVmZaZFlVNW5XUEthdDVBa212cUZ1clV0YUd1TEh6?=
 =?utf-8?B?NVcvdFZIeVl2anA3alQ1YXQvUitvVzk3N2I5RXhNRHJMZklGdVNRbnMrejBI?=
 =?utf-8?B?L3BxUjJsWDlVaHZNT0xNSSsxaE1XeTBHM3BsSmNxRGl2QmJ5K0EwZ2xuQVRm?=
 =?utf-8?B?QmVwcWl3YlNNcjlSd1AzMThLOFZHeVpwWHdNWC9EM2JicWF6RmlGS0dmZDJD?=
 =?utf-8?B?S2Q1c281T1YrVFdnWFdOYmZtdmtuR1U1WkVlUlRBZUEzYVNRTTJQZWZQMEdB?=
 =?utf-8?B?cjdpbnI5TCtnU3ZsdW5NYVdEWjk0VEZrRmhiK3dXUlhDVjgvYkpPQ2t5Z1R4?=
 =?utf-8?B?cU0zcHFSWjRvcVA4NXhPSDEvcGdad3h0Z1B1MjE5Q2xtQTVxOHE3U0lVYWda?=
 =?utf-8?B?NjFRRld3Szc5OXZvOEJiSlRTNG9Jcm40aWgxeXNxbGNHclE0K053L0QrN090?=
 =?utf-8?B?WDJqUWE4V2NRU1FYbVhyaUxqcHJPUXlSWTNma2crelV1TDkxS3M0VFFSZW9h?=
 =?utf-8?Q?3oSfk62exzL5hl+D+Z+mQVLiE2LoJ2xukVW/F+qlUzsY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62f861c-a23f-436a-07dc-08dd735040ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 08:11:07.5741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJnD9NMh5uIwu3RqNBEzuXfwokjad19KjZsz/sbVamu6bkrOHqgV4ne8EwLAySXwLRr20fUJFhBG37uw9aG7yucSBUtMV1z1k+Urh6IoYfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4136
X-Proofpoint-ORIG-GUID: ITVBPYWHk1QrlgceGKWBIAGJrlPwF2ZV
X-Authority-Analysis: v=2.4 cv=GLMIEvNK c=1 sm=1 tr=0 ts=67ef941f cx=c_pps
 a=YTelpZo7+Gv92UPfPuytLw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=zHsfWi_pIvNittI95VEA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ITVBPYWHk1QrlgceGKWBIAGJrlPwF2ZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_03,2025-04-03_03,2024-11-22_01
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

PiBIaSBTdGVwaGVuLA0KPiANCj4gVGhhbmtzIGZvciBjb21tZW50aW5nLiBTZWUgcmVzcG9uc2Ug
aW5saW5lLg0KPiANCj4gUmVnYXJkcywNCj4gTml0aW4NCj4gDQo+IE9uIFR1ZSwgQXByIDEsIDIw
MjUgYXQgNzo0NeKAr1BNIFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGVwaGVuQG5ldHdvcmtwbHVt
YmVyLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIDEgQXByIDIwMjUgMDk6NTA6NDYgKzA1
MzANCj4gPiBOaXRpbiBTYXhlbmEgPG5zYXhlbmFAbWFydmVsbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gPiAraW50IHJ0ZV9ub2RlX21idWZfZHluZmllbGRfcmVnaXN0ZXIodm9pZCkNCj4gPiA+ICt7
DQo+ID4gPiArICAgICBzdHJ1Y3Qgbm9kZV9tYnVmX2R5bmZpZWxkX216ICpmID0gTlVMTDsNCj4g
PiA+ICsgICAgIGNvbnN0IHN0cnVjdCBydGVfbWVtem9uZSAqbXogPSBOVUxMOw0KPiA+ID4gKyAg
ICAgaW50IGR5bl9vZmZzZXQ7DQo+ID4gPiArDQo+ID4gPiArICAgICBSVEVfQlVJTERfQlVHX09O
KHNpemVvZihydGVfbm9kZV9tYnVmX2R5bmZpZWxkX3QpIDwNCj4gUlRFX05PREVfTUJVRl9EWU5G
SUVMRF9TSVpFKTsNCj4gPiA+ICsgICAgIFJURV9CVUlMRF9CVUdfT04oc2l6ZW9mKHJ0ZV9ub2Rl
X21idWZfb3ZlcmxvYWRfZmllbGRzX3QpIDwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
UlRFX05PREVfTUJVRl9PVkVSTE9BREFCTEVfRklFTERTX1NJWkUpOw0KPiA+ID4gKw0KPiA+ID4g
KyAgICAgbXogPQ0KPiBydGVfbWVtem9uZV9sb29rdXAoTk9ERV9NQlVGX0RZTkZJRUxEX01FTVpP
TkVfTkFNRSk7DQo+ID4NCj4gPiBTZWVtcyB3YXN0ZWZ1bCB0byBoYXZlIGEgd2hvbGUgbWVtem9u
ZSBmb3IgdGhpcywgdGhlIGRhdGEgaXMgc21hbGwuDQo+ID4gSXMgdGhlcmUgYSByZWFzb24gaXQg
Y291bGQgbm90IGp1c3QgYmUgYSBnbG9iYWwgdmFyaWFibGUgbGlrZSB0aW1lc3RhbXAuDQo+ID4N
Cj4gUmVwbGFjZWQgdXNhZ2Ugb2YgbWVtem9uZSB3aXRoIGdsb2JhbCB2YXJpYWJsZSBpbiB2Mg0K
DQpXZSBuZWVkIHRvIHVzZSBtZW16b25lIHRvIHNoYXJlIHRoZSBvZmZzZXQgYmV0d2VlbiBwcmlt
YXJ5IGFuZCBzZWNvbmRhcnkNCnByb2Nlc3NlcyBJIGRvbuKAmXQgc2VlIGFueSBvdGhlciB3YXku
DQoNCj4gDQo+ID4gSSB3b3VsZCBwcmVmZXIgdGhpcyB3YXMgYSBjbG9uZSBvZiB0aW1lc3RhbXAg
Y29kZSwgYW5kIHB1dCBpbg0KPiBydGVfbWJ1Zl9keW5maWVsZC5jDQo+IHJ0ZV9ub2RlX21idWZf
ZHluZmllbGRfcmVnaXN0ZXIoKSBpcyBsb2NhbCB0byBncmFwaCBiYXNlZCBydGVfbm9kZXMNCj4g
YW5kIGl0IGlzIG5vdCB0YXJnZXRlZCB0byBiZSB1c2VkIGJ5IG5vbi1ncmFwaCBiYXNlZCBhcHBs
aWNhdGlvbnMNCj4gDQo+IERvIHlvdSBzdGlsbCB0aGluayB3ZSBzaG91bGQgbW92ZSB0aGlzIEFQ
SSBkZWZpbml0aW9uIHRvIHJ0ZV9tYnVmX2R5bi5jPw0K
