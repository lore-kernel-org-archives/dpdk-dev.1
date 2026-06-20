Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD07CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 18:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC20B4025A;
	Sat, 20 Jun 2026 20:28:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BBD5C40151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 20:28:54 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KI8Ym81142946; Sat, 20 Jun 2026 11:28:54 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021078.outbound.protection.outlook.com [40.107.208.78])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4evtcb5s0h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 11:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQlcbLAyNOKiUaxecfq5oDUTW+1nuSIYVUuJtJfPBYXMHQKPX1quaBv1GSlZ7kawzzFcZHA5Vb3g4IJnTQSp+bzdQrnSp/Vsmeut085lmgMPwWj9kMEtacqEfY+TqaYfB87/eqc5C9tWx0WSgdb1/hGyANZNg58nx/xJ1rjTc2YFqv3ilUm9BikXpgGEa0BVFOSmoVmd9vWgi9WjLZjTUnaWSEvlXsL31zjIK9O4SGbVAdv4y5LPXXR3GTP4c6xJ+CYlMTiOk6PrQzuAQXQGecfFPo0cNtGTIL72yhxjpja2G78/bWoCsl/ztsr1F5G6U3X3qGBMX59hSweq8FBP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo86an4HXwHgTltACb0iNg2NNSddLU2AyO9uy9vixEQ=;
 b=m7nB9ST7LaArB4ktTWod3tZ/qimLWwuMFrgWy51xBR1/hSs2ZLBVsZ05Upn5HtX8z4+xvNQ8ylAiej3rUlLO/PxyPuF4cBqA43Vy/dsnUHQKbtfGYo4Lm1YhvyrqdOKxHllf4NnaiTv27vaOYetG36QEq9VdQMGi2Npwh5ALi0CwFWtxth+75z1ZlTBkLtYruWhihziT76afSsRZAj7dQF51OHpT4SPKYR71gwAHnLOMwAjpF9Xsn8pu3RLB7hAuzd5SsD27FIDARrC5R+9VovxU5LQPqarruLFXSSxaASQ2WBCvcbh1u5dmz7vTOUSnUkU87exC9JgNEDZG4c+YxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo86an4HXwHgTltACb0iNg2NNSddLU2AyO9uy9vixEQ=;
 b=EQDn8noG4Nlovqfos88bqMr1fQ8zRC8fpitLDL2WyptGuMBKPZq2XxI7IQxtalUQnecOZ7KSeHm98TBWhjcp0b34ZUqrewT115Qe7VUWqlgMKQ4v/rU2/KX+IM1g9siSrlC9StxOPfJtKn+j0ZJMeckcZhed9JRedzb1pOFaPYY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3660.namprd18.prod.outlook.com (2603:10b6:303:55::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 18:28:50 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 18:28:50 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v2] crypto/openssl: update to OpenSSL 3.0 minimum
 version
Thread-Topic: [EXTERNAL] [v2] crypto/openssl: update to OpenSSL 3.0 minimum
 version
Thread-Index: AQHc7nh+EFNUjCvylkeVpAewlVMNebZH59+Q
Date: Sat, 20 Jun 2026 18:28:49 +0000
Message-ID: <CO6PR18MB4484A2BCB56198DC86E60FB6D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260527110227.516868-1-emma.finn@intel.com>
 <20260528080320.650260-1-emma.finn@intel.com>
In-Reply-To: <20260528080320.650260-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3660:EE_
x-ms-office365-filtering-correlation-id: c39d9232-eb21-493d-44fa-08decef9c630
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: Gw5VpHiW6pcKWZAM2zklcs5YMZvgkot3BB2+aWXG16UAkE/0yDYn3hCpABv4u424reAJ4Dd8yXZuMygjPS4qMrO2/DbzeFg39ORPDUeem289272CjCRQwh3icee30D7UEs364pgOD0SYJSe2DHjTXm0tCfBvFBaIHH3RA78v24u7uYzgK+gfPxoE4nPg7AtBZ1OLQZfkNA5+xObOIdEBObj2RPeJLkCzQBMtDF6cVY+XU5c0skA9H8GHwoRNrstH3URLnOPC+lx2m1JIoAHa7TvL5OjW0/l0vEnjSSqdpoAu41Ajhv1yM39vc1dLS9DMrba5xeIhkKHH8J4wkOaAmAH1GvXdCpJMGP5+QpQiTjlyiZ3L+WHFLgikXctakv69TgKZ4sKmgS542p0ZFV8gcWd7S29T3wlH2ioCEdC+5YGpKEn4SMW+KBZcLJPATAb3difdpt27d6wcZHkPptNLvPDt9zv+Fvb03pKkWg8sEY0alfe0MlfXRYpBqo+L3tBKMP0kA3nKKPJkeUmlE+p5/29QwUJ1yVv+UeYH0Vz6Ik+hXh+lw7wu44OyK7ZR56YrcsxvfaUeD09diRjrYLpYu0l2SVovBCIsMdZg9HLgba/4n82d8/SEjRsjBpISekR6i3aH5qh+0JpS2o8yEU0/+mbDjH1kn6DHm+jKk4IF193NLISP0vNFPf0p3t61fnU3aHIdixkCyx50gnauzshw6e28xER/kS1Wgacgan9O2v0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGV0UzZpQVZpNUUzQisvZWlzdUhCWnkvYlgwNjhrNW42VFRFTXRMdWpvZGdI?=
 =?utf-8?B?MzZaS2U2cGZqTENFbWNzd1o4cEVUT2dEaWpUM0I4VnkrNFFrQXpQOVRwYlRQ?=
 =?utf-8?B?c2NFbFhpUUZEMm80S0tjZjdQeXM5TGFoQ05uSWZIWXI1NUsvQXZQL0FKMG5q?=
 =?utf-8?B?eXNiTVFIOEJjb0h5TTZDNnhmRUNFcWc2cDBVV3huWFBhR0x3cU1tQ2c4bFpB?=
 =?utf-8?B?cCt0SnVXSEpYUVNIOXNDZlJxRytaNGp6Rkg0TlhQZm9qVE1VelEvWEdWMVU2?=
 =?utf-8?B?M0x5MEgrSFB2VFJLTnpUSllQYk1HQkoxcmw0a2xpalUyQnFCdkZRclp3cUhI?=
 =?utf-8?B?b1hrTFp2ZXBkeUs5czlib2g2QytHdEZJOXRZL3RDR2NsaXZrZ3VzMUMzdFNP?=
 =?utf-8?B?Rm5jbGxQNWlVVVQ2SXVCTnM4cHFQb1FWczBrSzJvV1NuTnZJV2xRYjBvbjVy?=
 =?utf-8?B?NWlJTXk4bVJxczFoQ3lueGdQek96Yy9RT3NEbk9mV2JVTzZpR3Irb1BsN2JP?=
 =?utf-8?B?ZDhZUmJCWWwrSVRaaTRMMTk3bGwwNDZHNmNQeHJaLzJMMWV0SGxpam9ReEUz?=
 =?utf-8?B?VFd6SVRLNTF4RVI5S1dvOEkxSlJoTVhCL2VueDJBdmNpR0laOGF6MExQd1FU?=
 =?utf-8?B?ZXY3L2d3dFBlMTJGWDNTZmsxODJmT0VFNFFtNVE5Q3h2RVc4K0NJd0xIZmsz?=
 =?utf-8?B?VWpGd2ZsTm16ZStZUVBzNU1oZ2tMK091ZmhQNTZqNncwcXhxL0dwVnZqUzk2?=
 =?utf-8?B?N1JMdGxvcW1Cbjh5R1ppZjMvNWtLNE80QmxHY3BhV21EeS84S2pScGtWOE1a?=
 =?utf-8?B?anZyd0x1aE9KeXhLbEdhZm5xVjd0S0NsR1Z5VTFTRDJPYnNWQkpnS1J4eDJt?=
 =?utf-8?B?YitSVkZHYTFJd05zQ3RKVnhWODNXeFNvaTlDd1o3M1NWZGZPZmY2bTRYZHF0?=
 =?utf-8?B?WmkxeEpIc1AzLzZKRlJEODZCbkdTUHhrT05FNExGOUJhcitCNUhBWi9uWStM?=
 =?utf-8?B?VmQxRG9EdXFPZ1l5dnd2UHpPY1JaK2tta3ZJb2U1dUR6Z21wdU02VVB6N1ZN?=
 =?utf-8?B?Wmd5Mm1RSE01NzJqOThRUTRRT3lSVHhOVzh0M0pld1FkSCt2ZzJvOFNaZDdq?=
 =?utf-8?B?S1ptWW1ZSXdXTkdzL2N3NEtUdENBRE4rU3RtOXlVYml5SUdpdE1FeUttNVhF?=
 =?utf-8?B?eG80Y1NuTEtmLzU4Ukx0SmhqY080ZG9XQ3ZmTDdtMFVEdVhuK1lRVUhCSHdi?=
 =?utf-8?B?a3NxQ2VWU1BOYXVkODM2bWZha0xUTGt3dmEwb3IxOEpaeE1hUkJucnluaFdx?=
 =?utf-8?B?eHZkZmFNSmlSeFBSd2RqTDVjNFloZ1c2TXRBMjZLT3N0ZmUrZXNRbmZYa1pp?=
 =?utf-8?B?Z3d1N09iNFZ0VVhaMkUzbU51dURVSnB0RjFSSlpadDljTGVrWnVRQU90U2du?=
 =?utf-8?B?UDBTQWFZRytkUDd6cm41anhOaTJzaFBEVnFpU1ZpejVHQUdzWWtZUjFmRmg5?=
 =?utf-8?B?Tm9xN3pzUnZQMU00Yy9FaVJoYk0vN1FuUFdOYTN3bVo0ZThaZTRYNFFjbHBD?=
 =?utf-8?B?di9CRzdURGE4eVFYYzBjTUZ5bjRZc2duSm8yeWIyMFQ5M2NBVEFsUjFVNzlv?=
 =?utf-8?B?blpEbjgyYklnN29QWCs2NjZMQW5wcmhjOE43L3pkNnVOeGh2Uk42YTFuVzBF?=
 =?utf-8?B?YkJuZ3ZhRVFnK3JlamVpcndaMlRsQmxKM2RZc3ZGVWVUcFdCaC9GUGVMMnNJ?=
 =?utf-8?B?UkVpek02cXJsYzRJcXA0NmUrcmg0MHBFZ25tWUFYZ0lFeklQUkEraEtld1oz?=
 =?utf-8?B?UjZId2JQY0ZrTGZFUURLVVRZRU5WS3ZnTmlLd1FDQTNUVzVVemVOMFFHN1dL?=
 =?utf-8?B?STBtVSs1bU9PN09yanJ1S004VXJGREYxYVg0dkpKWGk5QXZURDNyUldmS0pN?=
 =?utf-8?B?a3BsRHFTenI1SWp4ZVhPMUlpMUZhZ2VQK295V0lPT3QycGRJNGo2MlhWZnR1?=
 =?utf-8?B?dm9ER2lVa3A2NXBVSy9XOHo5RUpaOTZpZStmVXhyM2hIR1hvQ0FTa2p1NWg2?=
 =?utf-8?B?b1pWS3pVTWtPTERtbjdWTElNc3JoSFBna2JMMitvYmlRV3RVYklRTmhiV2Fy?=
 =?utf-8?B?WklNdHdrbk92azFGekRIUGdsSUdOcXdXazJvb3VrdHZpKy9KK2ZwS29UMWZi?=
 =?utf-8?B?RWlMVUdPNDRoOUlPVmVkTWM5RnpJdEx1MmwyTmdKLzdYb0NmR3c4NUxNRkMx?=
 =?utf-8?B?eDlBWmx3QnUrL0RoQlRxeTJTR3ZZNlVjQTJOUkE2WGJqMFlmZjU4WXd3U2Ev?=
 =?utf-8?Q?x4wmRMoH0ONRVjLJJt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N4sjdrSJ9cq0b3MaU7vM2gqEjJMzpcdNk8jS1PjOM+z9Zxf31of+Y8M3Vuk7E/+0b73a8jPTpiWTT6YmGjSgFH+TB9nEQtk2H68c8A8jjjM590lq/sxYhQ5ekLrRF4ivD99amE+aJOFZqA15o9iO+AnoccRwbMLagqqtACk4AMdoIUA37LiqzkXoips7xKLu6rTGNX3qFgprLusulY9cnePxiLWI3xmfw6V3WwS1RxRGTjeeeZpy5j2ReOQA7sRg/XD1fKIvGsuMmbi2nrSPwgT5IStlawYkn/x9MmowT6gG5Ni14XnwZudVvoPCwARtB/rrBLIV8FAVu2wUK/i4Qw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39d9232-eb21-493d-44fa-08decef9c630
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 18:28:49.9901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wa2eTH4TMyFq98TdxGbzSUZbnGBFlmj8e5qQ0ogMs5w4yn2pqIGuh81/6/xNyAkyBKsjdzT4AC9W6xLsuWsNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3660
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE4NyBTYWx0ZWRfX1M3BiZLVBxs1
 iFt13N8QMvIlHeWE1KL9FdIa0r1a+V5GOFr1JMRTcpKiZ8VimmpUKGSdzsE3fpeEcje9blHWkkl
 ToRQyHJjc1jyg83vmTkUCTH2p+N86Tg=
X-Proofpoint-GUID: NiKfnHiEzzK9VmEBWy4OMroJphkYrczE
X-Proofpoint-ORIG-GUID: NiKfnHiEzzK9VmEBWy4OMroJphkYrczE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE4NyBTYWx0ZWRfXzs7f/HMT5OA8
 XjVVKmsfvJ1KTa4SmTX2RwuPbsNi0hEDvFWtezzo54z1ChMuTSBbrDyXtzHw8KC8dYLl0r0n+0Q
 gAThJ7RrnUzTzCk9aBKCc0zu0tuQX94zz+lhRPhfBaRrqJhMnBsTTdyT2sV1hkV3FPtqSVCsuGi
 sAwUMGiRr4uucDgedtUbzPGvLe90liMR/UUl84Ye3/U94TXDLJ3pdH0H6RoON5DFMpHSE/sTM26
 qeQ7itRM9iexhuICZWxZxeWwj+2bnUiixQqdeaG5hGbyKPUrBPHaL4CEPDa4VR1wnH4N5R/70A/
 C00KerxE+IyntG87vwM5Hwgt9DrvrmAAA6YtYksSCi9bgth5GspRru8QPhKRLWfNIW4G2SwGd2k
 VR8UK4MnAVnRRTHtSyZ1fGH4Pqir4jnPbyyPCRN8VzfDQKxq+EA7RKpiDlI29+0IqT0gvGP32ma
 YdTEF2Srsl4vWtvUk1w==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=6a36dbe5 cx=c_pps
 a=EX0Xkmt19mXnrP5bPG/VDQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=M5GUcnROAAAA:8 a=e4Vgnq7HHL65rbLAbqQA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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

PiBVcGRhdGUgdGhlIE9wZW5TU0wgUE1EIHRvIHJlcXVpcmUgT3BlblNTTCAzLjAuMCBhcyB0aGUg
bWluaW11bQ0KPiBzdXBwb3J0ZWQgdmVyc2lvbiwgcmVtb3ZpbmcgYWxsIGNvbXBhdGliaWxpdHkg
Y29kZSBmb3IgZWFybGllcg0KPiB2ZXJzaW9ucyAoMS4wLjEsIDEuMS4wLCAxLjEuMSkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBFbW1hIEZpbm4gPGVtbWEuZmlubkBpbnRlbC5jb20+DQo+IC0tLQ0K
PiAqdjI6IHNraXAgYnVpbGQgaWYgb3BlbnNzbCB2My4wIGRlcGVuZGVuY3kgaXMgbm90IG1ldC4N
Cj4gLS0tDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvb3BlbnNzbC5yc3QgICAgICAgICAgICB8
ICAgNCArLQ0KPiAgZG9jL2d1aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8wNy5yc3QgICAgICAg
fCAgIDUgKw0KPiAgZHJpdmVycy9jcnlwdG8vb3BlbnNzbC9jb21wYXQuaCAgICAgICAgICAgICAg
fCAyMDMgLS0tLS0tDQo+ICBkcml2ZXJzL2NyeXB0by9vcGVuc3NsL21lc29uLmJ1aWxkICAgICAg
ICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9jcnlwdG8vb3BlbnNzbC9vcGVuc3NsX3BtZF9wcml2
YXRlLmggfCAgMzAgLQ0KPiAgZHJpdmVycy9jcnlwdG8vb3BlbnNzbC9ydGVfb3BlbnNzbF9wbWQu
YyAgICAgfCA2NDggKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9jcnlwdG8vb3BlbnNz
bC9ydGVfb3BlbnNzbF9wbWRfb3BzLmMgfCAyMDYgLS0tLS0tDQo+ICA3IGZpbGVzIGNoYW5nZWQs
IDIxIGluc2VydGlvbnMoKyksIDEwNzkgZGVsZXRpb25zKC0pDQo+IA0KQWNrZWQtYnk6IEFraGls
IEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+DQpUaGFua3MgZm9yIHRoZSBjbGVhbnVwLiBZb3Ug
bWlzc2VkIHRvIHJlbW92ZSB0aGUgZGVwcmVjYXRpb24gbm90aWNlLg0KDQpSZW1vdmVkIGRlcHJl
Y2F0aW9uIG5vdGljZSB3aGlsZSBhcHBseWluZy4NCg0KQXBwbGllZCB0byBkcGRrLW5leHQtY3J5
cHRvDQoNCg==
