Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E9C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 14:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD6F1402C4;
	Mon, 19 May 2025 16:01:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3BAEE402AC
 for <dev@dpdk.org>; Mon, 19 May 2025 16:01:46 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54INUpu5001268;
 Mon, 19 May 2025 07:01:43 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46q46fah72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 May 2025 07:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGiVSVsB5+jYa7hCjxkqr81nYQ3foNP7AA6yN7sNaUghP8GfBdInlZrVF3L7KFdwsgxWvBR/Oae4QQe5CD/Wjb92n+FysA7SQfTwckOCmDKWz+ex+XpyDKmlM7+FD9fkfJNIYj6AH0F6bi4G0lB6P8EgDXkNh9qWQ/urDfXdQyuATNew5sW99VYQVOD7EF79TJ569n7HVeM2y+1uXP5MSVOBXCHPs4r4mRqLvpG8SPgXo3QaZOztTWv+ZR+b363gxDin6U2c3hhTHGHF8waxGfDdGOElj9bEfYu/FXDxlDY+3s7nGBQ5wzS+rvYdFbjeVyEU+1tVo0pmXwMcyXkcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1Oqe89jrMm+6ieYdd9m5qWKEdmSR2ZWULOtnReBFC0=;
 b=Jt0cw2UPf+tMKUroHPcq2nyPZWw6ddwBYknjH8kOjMrP3qMbG6gYi1U+gyTHTJlg0vOhYXo+TPIZ+awWRdSo5RqIDgoAdwUkMCzQ93pyXWBHu6hDxMBcZtY9qUqhp4tsMPnLH8UAZ8O8Uli6dFsWGkcjI6pkDA94LxLN8bLhvqlItGa7R5TQ1/BBfhLFAG/xViRI/x1g8mZwqdlWKiy6PzFgMRcd91Y18cj7vmYN7FRWvpPpDfLln9EBqlUvFLIR/o8QEJRqumt/duH2U3GwpuvyVXljhz45uzwBnjgwxtUGaRVHSp/IA4rhVklxbodklekWwGoAphK81ko0XrvtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1Oqe89jrMm+6ieYdd9m5qWKEdmSR2ZWULOtnReBFC0=;
 b=DODwNYZfe4/x0TCCZT/Q0E0FoxQi/s0oQ+tDIwUNN6XXLy1Y5E4Ffo06hzt7sPkPh8LrSPHkhTRd1By8CP11Y7Yp41wjNlpIc4I/MyPc9J3UoA/XIlsKqaBABu1KHd1Sv2+BuSXlGJFLZ0UQkJfUHrRxfVvfJiO/fYOwxQDe2SE=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 PH7PR18MB5281.namprd18.prod.outlook.com (2603:10b6:510:240::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 19 May
 2025 14:01:40 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 14:01:40 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, "Varghese,
 Vipin" <vipin.varghese@amd.com>
CC: dev <dev@dpdk.org>
Subject: RE: rte_lcore_has_role() return value
Thread-Topic: rte_lcore_has_role() return value
Thread-Index: AdvIpLZJaWj+3Hu4QLKxOy27D7eK3AAIZ8ow
Date: Mon, 19 May 2025 14:01:40 +0000
Message-ID: <PH0PR18MB40869A3A3B6E5F0C4D7F02CFDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC69@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC69@smartserver.smartshare.dk>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|PH7PR18MB5281:EE_
x-ms-office365-filtering-correlation-id: dd51d25e-d8a2-4cd8-3d2b-08dd96ddadd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZTMzdm5IZXlTV1FERG5GcmhqMHcrQW40VGovM25McEdCb2JhK1pnUjEzM0Jz?=
 =?utf-8?B?aHBMK2ZsM3NEV2RtVnZ0ZjR3QTYrNUx4aUZYWCtDV1Awa1p4dGVPejhaSXZN?=
 =?utf-8?B?TWhqR0hLYXpwckpXOG5NaXBNTitROEdvT1dhU3NuNFd2SFZSeGd6RkRiN1ZK?=
 =?utf-8?B?UGdUTWUxdXJrNC9lQ1BKQjZpYUtMSThIVC9uWTJvVkVNdXBjVzFQS1AvUi9V?=
 =?utf-8?B?b1RKQlhLSkd5ZVI3RmY2eFZ3YWpDU1Nkbnd2bjBZcWxiWWdvQjVRdHJ4YzJT?=
 =?utf-8?B?U3pKUG1VV3ZYWC9yanlBUTc3eGpQa0ZJV2h2UUg0ZlMvekx5R3ExK1JjajVN?=
 =?utf-8?B?MFZIZWNGcW1KWm1Tejh2RFkvLzNvUmxUanYvY3VyS253ckZ4VDFSeVRZR2RQ?=
 =?utf-8?B?YURGdU92Z0VVdG43eVFaajdXcDFXaG0rb20weG9TK0NyMmZtTWU3STlpRy94?=
 =?utf-8?B?UnpoZlZ4eEZCeXlSUW0zMkVmRXJJOUczT2lCdlhGMThPdkZyNEZoZlhuZnd2?=
 =?utf-8?B?bHQ2NjhVSHZEOEpyUStwVGl1ZzhQZlAvYXJsMURJdEtqbk9Qa2VRcllIa2ha?=
 =?utf-8?B?N09uc2hZWGE2S1pGU1k5S043cDZHdzVoRkVrZjJIRGY5UGVOWkJDUGpUYUlZ?=
 =?utf-8?B?eVpRTzV5ZlVhYlVCOEdDN04zc2NNcVhpNDVJdXE3eW9PS3piWVpYQnBuZjQy?=
 =?utf-8?B?dVlsTDQzTGUrY3RRb0FFd1ErNDZEczJYejJTc2xKVTVSc1ZneTZQTVJUR2g3?=
 =?utf-8?B?T1FOWFZUUmlrREhrencxbGNCdGJLb1dLNlpPbDJvNVdIL3k3ZEpRLyt4NzNl?=
 =?utf-8?B?b0VJdWhDUTFjV2ZxL2dCMUdNNjFQVC9JcW1OK09WQkZUd1FodGpCTVZ6aE9o?=
 =?utf-8?B?clhaZG1VYlNnQWlSN2xPRi9ORjFQcWpGbDI4VU5sMjhtUU9DUWovUXVhMHIz?=
 =?utf-8?B?WlZHdzFiOE1WTFByWXF1RUVoWU04UnRhVmxoKzVqWlpid2VjOFZ3dUZDQVVF?=
 =?utf-8?B?SmhiM0h5cnBKc2F6bUd4MG5WZXQ3UFp2NDVPN2Y0eG5lUmExMUtBYXJTcjkr?=
 =?utf-8?B?TElERnZ1ZVJOWGZTdUwvcnpNWXNZbzVtRnUxa3E4Z1M0bmdEUVRjL2sySyts?=
 =?utf-8?B?WE10NUE1ZW90ZXBRSUxpRnJRemtXTkJ6Z1ZMMGtxLy96UHM3Yjc0dUU3b085?=
 =?utf-8?B?L1liWS9tM2hNbENEVVRzQjdCb3lqQnd6WXZIbFlDZ1B4NkdLL3ovMHNkZkZN?=
 =?utf-8?B?aDdWM091OVJySHdZSjAzNmhPUFdWdTBacnByOW9yU0oxM2lvMDhxUWJKR0dk?=
 =?utf-8?B?T0hzSThraE84TVdud3ZjL2syYnEyNkRvR0lzcVlNMkUrQlVRZ2tkVGZaOXhB?=
 =?utf-8?B?d2lwV3p5US85T2Ezam1pbU50czNpQVRTeDdRSTRiRU5wOUlob01ENVZmdzBr?=
 =?utf-8?B?RllEQUxJcXBqc2EvK2pzVEgvd2lqc2FjSDlkMTA2VFh0SG4zS01vOTZ4QUlr?=
 =?utf-8?B?M2ZNdEFNYURwNFY2ZytyaXU0ZzdhRXlQMWV3OTk4RDlUd3VXcjZhcjlrVnJm?=
 =?utf-8?B?SEMzMjZnaEMzTDd0Skg5QkZIWldWZW13QUhXc0FCQTJlaWVXUjBtNnh6b1Rw?=
 =?utf-8?B?bmtwR2FvWmVLS0RQaGJiTVA0dG9GQnhVbzFDUjF3ZDkyMWxXcFlDbERKb2N1?=
 =?utf-8?B?bVpmVVgrR25ESnhTTFNmMmkwL2c4czhWa1R1Zi9xSjZMTzNoN3FHN1dMdXQy?=
 =?utf-8?B?bEpyb215NUhOSnduanhPcVBKU2REVEkwQjAxZ05JdnZFamRQR1liRVV2Um4r?=
 =?utf-8?B?c1pFanoyV2QrYlVBZlRYN1RTVTdTTkZNQ2d1LzdVcmo2cnNZTnIyV2FGVEQ5?=
 =?utf-8?B?R2Q0aitvTFhoeWpYNysyQ3hmeTZhcUdLTkVpempjV2NlNnhYd0RRSzBySGJT?=
 =?utf-8?B?Y1dWRW1id1Z1czNXSFdkeGpKOWY0K3NobUlidm5nSXZxLzFSaTdNYjFlVFZh?=
 =?utf-8?B?TWk4bEQrWnlRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmhOc2VYYXBzTnlrNHNyN3NzSGl6b0xIcGNOTVN0Q0NheEpNcDNMUjRXVW1O?=
 =?utf-8?B?NkxYKy84K0JtVzgrRTh4enU5UHdHZmN5UXZQRXBrcUtQV3hDc0xONkhRRXRM?=
 =?utf-8?B?dGFGWUR2NzFiRW1UZTJUOXpmWXdjaUs1bm1rclJoVktzTkV5V2s1b2kvbG5W?=
 =?utf-8?B?NDZkVkNRanNka24xOVdaVUY5Q1dIcmpwSkdlamp4cXpndFVPUGdDNGwrOXlk?=
 =?utf-8?B?SHR5SjRpUVBPZmgycFNPK2pmWXhkcmZkeWlaeVVOM3NwcnJGTUtCMmhXRUxI?=
 =?utf-8?B?S0RzRzZmUEc3Smkrbk8yVHBEMm1oYzk2WmtxaGV0TXU4TDNmcEkxOGhPVWx3?=
 =?utf-8?B?aDdDck8zR0lNUTk1emw1NUs1MjlZQ2JTOVB3Y25sZ0NrckcwSnIvb3R2R3Vo?=
 =?utf-8?B?RXJVZzF0ODVsdGdMckNCdVBOb0xXaWRFZFRHcytBUVlBN3BYOTJORGozVDZI?=
 =?utf-8?B?RjkySGNtSXcvVGtMdkRwU2s4SzYvaHEyQ1lYSEpPeGNlaXlRc2tZR1kvRDUr?=
 =?utf-8?B?OFByQXJyTWx1dEt5NFg2RlBhdmYxSXBBM1BpTGVicnE1OGlvQVBBTEVCT05t?=
 =?utf-8?B?R1VPN1RqYVF4R1V1M2JaVkM2ditEK3I3WkNHVm9PaFMvZWxBT1NvSFhlOGZm?=
 =?utf-8?B?WnNaMG94ZTZxVlAyU05MdGgyTDVVTnEzeVFqRG1YdVovU1NWcmdxZmVrenl3?=
 =?utf-8?B?bHYzYWxBdE5IY0ZwZWVEVG1VdzVBWmViNzRqQUt4QndUUlNYRWR5MXhVOGJ4?=
 =?utf-8?B?elVQNEJSdjQzS2NTZi9MYVZQd0R4RE9CYXdHajhuNzcrNzl2N3ZUbk1BalVp?=
 =?utf-8?B?ZDloM09rc04xQlcyMXF1bTNwMVNLZ21rOUhXZGlwZEdTK0Q1WjZzT015M3ky?=
 =?utf-8?B?M0c2QnBxYkczL1loSzJtS3M3cmNLbnlJdGZOZWY2NDdmRStGQlY0TXRGQVgw?=
 =?utf-8?B?cWZQYVlyWTRGU3o3ZGUxeTEwZldWOVhLOEdqMlhMMFk1aERKZ0Q4SmZqUmIw?=
 =?utf-8?B?QmxwbnlJTkZua1ZVL3k0RFFwUXlHN3FqeVZwcVM0bFhqbG9TcldUYzBCdXM0?=
 =?utf-8?B?cUxNdlJUOG1LRkJ2SUZPdWZJS29PbG5PVlhWSndBZk11bTFiYVJhRUYyc1Iz?=
 =?utf-8?B?K0ppSklwdndtdEIvTkEzNjJGZnRDK291emlleDRWWVJ5cEkyVTB5eW95TTlr?=
 =?utf-8?B?V2puUElqZFVQQUpvUE01S3hTaUxFUnlHZ0hpeHU5aVIrSHNueWVwdTRMb1Z2?=
 =?utf-8?B?VXlCVnp4OFE3UVowLzN4SElseXpiYVJyODQ4WGFFK3QwdlNHZmRQSWw1ZGd2?=
 =?utf-8?B?MjNKWlM2RkYySjdKTDhVeTF2K0k5bGRudkN0REVWMW80US85Z0ZPMmJWeHBI?=
 =?utf-8?B?RHBCRGZJbHMvNDYxODdORmVUc2xzZGc4ZmhQNmtvdlJoUStoNXZwUCs0VUdr?=
 =?utf-8?B?US9sbStZWVoyUEFWSE9FK1phODUrNE9VbGNiRGE4T1pzRjVwNFVjR0tjMTFt?=
 =?utf-8?B?SHBlYmdvQjFndyt2NFN4aEtaVE02clpWRkRjNktSd0huQ0hsM1lmUncvV2g2?=
 =?utf-8?B?L3JoQnhKV1dyWG5Ydk9mS2IvMnpTSE5sYUNZVjVmL3VWLzFxTE5MRElDbWd4?=
 =?utf-8?B?NGlQQjdjWW1XSWVBbmFFZUdIeXNYYnNDRjAzVDNJVGpVd0NIcjRmOCt1aUhR?=
 =?utf-8?B?RDNrZU1xMzdGa05HUWVlZXgxNWRDYm1iMC9Sc2pDMUtQSFAwQ05NN0NMdDU3?=
 =?utf-8?B?Vjd2Q2tFRHZKNnFRbzBWWUVoRVp1SFZHOTUwVldRdWZmeENwYkRuQ3p3OTN2?=
 =?utf-8?B?UE8zSjNvS2hMVld3SXh0WlY4MTZJaWhWZ1hHV0xSWkdnS09zd3RQSzh2TnlP?=
 =?utf-8?B?dzlMbHJzSElFVzczZkpiQStQM0tWYVRRenpIblNYdnhDaURldUNsWTcxdDJn?=
 =?utf-8?B?TVhTMjNpWFpuS2p1UGtGNDlhbFFPbWgyNHpVTUt6N2tqNjhyajVsNVo2M09B?=
 =?utf-8?B?K0poOUhieXNRMXpjNTBNcUFmdThmSWdiSUw5Y2Y3RjBpMkVXWTdYdU0zeG9B?=
 =?utf-8?B?dG85UGdIYk5NOUxUWjlxcTVOaHRJcnZGNWVHbUVrczNMM1JZR1F5VFV6TWhk?=
 =?utf-8?B?dE55QWtaQlkxZ3QyUFYvZ0lpellac1RTeFR3ZU1zeGR6alcvUXMvTU90MFVn?=
 =?utf-8?Q?Wf0HQLecVACMzV25zjJNY0O0EBawJABmqwywH20fiD5c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd51d25e-d8a2-4cd8-3d2b-08dd96ddadd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 14:01:40.4339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvOex9bwNKAttJan68lG1VASE6Ya6ZkFJtkfujX0pBYU+Zyf3Bt3dxsFZIbuYQLlt3wIXp2BSjz/bwshgBW/kbdC41E6PtSI4GEQBlEfTEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5281
X-Authority-Analysis: v=2.4 cv=b8uy4sGx c=1 sm=1 tr=0 ts=682b39c7 cx=c_pps
 a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=h6-dSI0CwJI2lAdBwhYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VOd6ZqnsM_DAOvOayDrQR79DYIxOcW0C
X-Proofpoint-ORIG-GUID: VOd6ZqnsM_DAOvOayDrQR79DYIxOcW0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEzMCBTYWx0ZWRfXxmzKsIi7KrDs
 VDJE+C92TxXF/r455+O8iPFXmK6jdUFq6weKQ7E8yjWbDlfdDElMNXjBUjHeXjOvqug9/EFWkrD
 EDAKyNKRpLEAa7cy2bweJw1WXIo91VY1XlDYrJEpVn6lgMAxiC4ICOSHlq8ObGCJZoEJfUokKci
 NitPuQJ4GlE+CqX/VRmD0pEik+Dtupgj3YtjRvZl/ooJGOsLpL+59pFgHKfGk40799X8CJvVXHe
 ewOr+l70D70TMvFRmpWdZ7SZwTZUEGj0IbDtNe4sgdBkzcGmxKDMoqjqY5vLaFwH8kSQA3Xaxvo
 MK0mp1fCSdR2R//m9/RSVGe9CDTEwEKpBTz+SV/Kxpa7GaYKRXIqtxHSE5adM4rOHHnZjVLgTvm
 yUPEWG34xQzgYI6Lkmjztdo8I3XdtZItm8I6mCH1bSV0Reos+C/G4Ptx5vTjkwwA/3LnyL7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
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

SGkgTW9ydGVuLCANCg0KTG9va3MgbGlrZSB0aGlzIGlzIG1lYW50IGZvciBWaXBpbi4NCg0KK1Zp
cGluDQoNClRoYW5rcywNClBhdmFuLg0KDQo+IFBhdmFuLA0KPiANCj4gVGhlIHJ0ZV9sY29yZV9o
YXNfcm9sZSgpIGRvY3VtZW50YXRpb24gc2F5cyBpdCByZXR1cm5zIGJvb2wuDQo+IA0KPiBJdHMg
aW1wbGVtZW50YXRpb24gcmV0dXJucyBhIHRydWUgdmFsdWUgKC0xKSBpZiBnaXZlbiBhIG5vbi1j
b21wbGlhbnQgbGNvcmVfaWQsDQo+IGUuZy4gTENPUkVfSURfQU5ZLg0KPiANCj4gSSB0aGluayBp
dCBzaG91bGQgYmVoYXZlIGxpa2UgcnRlX2xjb3JlX2lzX2VuYWJsZWQoKSwgaS5lLiByZXR1cm4g
ZmFsc2UgaWYgZ2l2ZW4gYQ0KPiBub24tY29tcGxpYW50IGxjb3JlX2lkLCBlLmcuIExDT1JFX0lE
X0FOWS4NCj4gDQo+IFVzZSBjYXNlOg0KPiBBIGNvbnRyb2wgdGhyZWFkIGluIGFuIGFwcGxpY2F0
aW9uIG1pZ2h0IG9yIG1pZ2h0IG5vdCByZWdpc3RlciBpdHNlbGYsIGFuZCB0aGUNCj4gcmVnaXN0
cmF0aW9uIG1pZ2h0IG5vdCBzdWNjZWVkLg0KPiANCj4gQXQgZXhpdCBvZiB0aGlzIGNvbnRyb2wg
dGhyZWFkLCBpdCBzaG91bGQgdW5yZWdpc3RlciBpdHNlbGYgaWYgcmVnaXN0ZXJlZC4NCj4gDQo+
IEZpeGluZyBydGVfbGNvcmVfaGFzX3JvbGUoKSBhcyBzdWdnZXN0ZWQgd291bGQgc2ltcGxpZnkg
dGhlIGFwcGxpY2F0aW9uIGZyb20NCj4gdGhpczoNCj4gDQo+IAlpZiAocnRlX2xjb3JlX2lkKCkg
IT0gTENPUkVfSURfQU5ZICYmDQo+IAkJCXJ0ZV9lYWxfbGNvcmVfcm9sZShydGVfbGNvcmVfaWQo
KSkgPT0gUk9MRV9OT05fRUFMKQ0KPiAJCXJ0ZV90aHJlYWRfdW5yZWdpc3RlcigpOw0KPiANCj4g
VG8gdGhpczoNCj4gDQo+IAlpZiAocnRlX2xjb3JlX2hhc19yb2xlKHJ0ZV9sY29yZV9pZCgpLCBS
T0xFX05PTl9FQUwpKQ0KPiAJCXJ0ZV90aHJlYWRfdW5yZWdpc3RlcigpOw0KPiANCj4gLU1vcnRl
bg0KDQo=
