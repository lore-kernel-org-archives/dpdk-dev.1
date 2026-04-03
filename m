Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BD1CC6B3F
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 01:28:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5898F40275;
	Fri,  3 Apr 2026 03:28:17 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 595A54025A
 for <dev@dpdk.org>; Fri,  3 Apr 2026 03:28:16 +0200 (CEST)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632KD2ce965076; Thu, 2 Apr 2026 21:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=W
 q0mFMG70VSGK/vnyzhMeFhGcvF9rkxsaopB6/7nRpI=; b=JgPbN6/k42+3GvLf2
 CaC8EjuL1yUAOOPdWgJJbZycLfngENRb/JUTiTr/C1Zcq+rX29TESL/PQX0zXTnx
 3JYPxpLAyw62n67JMLx6K1TZ0H0RnLMMf2M0JsROKX8yuAFStGamXumMu5ONcY4c
 6q6a1JEPIkKS0mYZWkdlIa6BhEZ0zo3a3kFOgVZvEKdzbB17Ht5AX5KnUwGIE+bP
 0P77C+bJC25KaCraQL1bylHEyn9xtV/EnTKiZBVH2CgHzFWe7jPzA5car4bUO5PW
 v6PSXT/VUGcnji5DgLcf+csBQ0XHnnsnd+Y/5uv2MJWEXztgTkRkwEDgimZHAx4B
 KT0bQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4d6sbbb6xy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 21:28:15 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6331OTxf1240373; Thu, 2 Apr 2026 21:28:15 -0400
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4da1s29auu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Thu, 02 Apr 2026 21:28:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySX04YuKetItE7NFapdJPzpEetwB35XiY/i3xyWLdGpa/tyaQMR1YdIsFGqa0DFH+qPn1JC9QpRKrNtiydCu4qOwkK7xc5VySR8syMf0PnaUbYd57jjs9Ez4ksU4at+INYt+ZYTjAw667bGVIKt0Mehe3mAG3bCBVBEbcRQHMLYC4WHbAnicMgHAoibgiR8Na0qEyROkDSU4raJU1XNcppiq6KEpIIUzOPe3T6i1A/Er9JdfOe8pDbo8ZuETOVedo2Wx7IydONIywYJX6jUbb6GtmA9/VYGbms/+/lL36K+8e3IQDlPqzeN/T7ogK/rD0SUnOiByShghCPLkWvuxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq0mFMG70VSGK/vnyzhMeFhGcvF9rkxsaopB6/7nRpI=;
 b=XBTwFGJZDym9qX42R8WlqywkLczUj4ozJNTQrLelnJb/Rq59xhvo6ffXBNBKk3exKBMD2oqPO7lDAnh9pUg7tieaLr2swKSw5QLw2gUlSdE+SgaxlzWZQPwG29bNvY5PzQAnSCXkapIZbKepr7GMTnOvEwEcANS59hMnK0FYRPRDxJhWqg87TbQwSuTXlN9ntxh8Zo9f+bf61T5oS+G6aW06NVxPqSH09U4uUoEdj/j7G10oWSXTzK9zhfy3c5YIS0JVz36zLVlKh0KLr4Ei6deTikoS4arWftKfvlValUfSDgv4jt7fukaD5qpK6uMhVJliBZ/xakUq7e7XN9m2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by BY3PR19MB5105.namprd19.prod.outlook.com (2603:10b6:a03:360::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 01:28:11 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 01:28:11 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>
Subject: RE: [PATCH 0/5] Support add/remove memory region and get-max-slots
Thread-Topic: [PATCH 0/5] Support add/remove memory region and get-max-slots
Thread-Index: AQHcwnOlREUjjeH0qU+VwJd76ZXFtrXL7X6AgACfmnA=
Date: Fri, 3 Apr 2026 01:28:10 +0000
Message-ID: <DM6PR19MB35640352684F22D84E20A827F55EA@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260402073803.3068147-1-pravin.bathija@dell.com>
 <20260402085559.4531d445@phoenix.local>
In-Reply-To: <20260402085559.4531d445@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-04-03T01:27:13.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|BY3PR19MB5105:EE_
x-ms-office365-filtering-correlation-id: 5bb60750-b66c-47db-5120-08de912044a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|786006|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Otz1cfDILeTUEEEAk/bYMC8Elw1osYln8EUT3vh3eg7xMXQCa+BJl9mZCNXerwM9EXvhJc428LWPcKr1nEyEzwwKQUbjpg8+eOhlnTJmNrKGP70sQQ7eoNnUQ+klG+Hbxzixw+BWjFSkDjxicQKfHIDJjysMvg7rBYiFV8MYKDGT6CX0Lbkrba4+6q3yCCufcVukfRrQhXVWNl6KYMfn8Gw1TRlJxFnEX1b4lhOLg2ZVbdA0SMzBrB1gblrXnY91+IPXLJBQ9KVPslMp+Hom3nJ8aGwZnPzM9B/6/oE8GbPDP75FVT6AcdyKmjmlXqOC+bPD2qk3aCHEufXhqPDGBrYIghEoNlfkyW5IhWR8rvr+u6IQpObzaqs/scR7mW/pb5vQaNp0AKh8rAW2e4E66rsPvuQF5zG/HflsNMYHQ7UbIw7RXP5+JwrEAizanct6Gzi+JxX330Pj7S2d9NRLA8xuSWkSuy86TEmVre1rOhzpymYiAfWOjpW6ssFqzdEeEaVuvSVaAaN/LF/svE47E+RNMO5uovRLUvrBKqRwDOSGvcBGipo5cFRucZcyYBOlJhKFuyoXPCVoM+vcib/3MPUmCi+26P5SaU8wNRS95kEhManZmVfoP8GCWc+qpOYndRDgGHpgOjd4Xt4VofGR58Cbn716euwW0qer9nGnZ08VNGpZUSru+Uq00fbLhtqnauswVHXy3yas0BtwCKTShhT8b67/twiB/xJsn7SK7kc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(786006)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVFJeGtqaWg0WFVDRHN4VzE4bHFQamJoelA5UVNielFlM21RcXNXZ0RpemFo?=
 =?utf-8?B?MVhIMW9pTWVMb3F4MXhKbHdjMUUzSDBFOVdoU3JoRTZxSmlWS0lOZmRzbHRS?=
 =?utf-8?B?T3dNNFBST0ZnMzRXaEhCRXA2cWJuRi81Mk5YTGIwRTQvRzY0TjBxZStNZzIr?=
 =?utf-8?B?TXQ3ekIzMjV4U2JiRWNPWW9iMVlzc3ppSk5nRm9tRlUyQ1lCOVVNdmVNUlFj?=
 =?utf-8?B?NWUzcXhGNno0SENFTEFEM1pjc0xuRncxV04zNEVKaE1wT1FzRTFnMFo2Tmw1?=
 =?utf-8?B?eXVYWWlpTVdZYXBZOXVzaTl5bGRzZXM2MlRrYWNtK0x4SlhoUll4c3VFQ24v?=
 =?utf-8?B?T1VlR1lyR1gvRWtIU2V0UDZlRURiSTdqOC8zWkZSdDdGOWJ4OHExcjAwWGs2?=
 =?utf-8?B?Ym1xTlgyS2FyTVdpMmdKUzVVMWdLNHZTeFd6YmphYy9hR3ZyLzAyRW4wKzUy?=
 =?utf-8?B?UnQ0QlRoY012ZWtjTW5aZTBOVElMMkRpNmpQZUd3bnVSZVJOR1d2am9makcw?=
 =?utf-8?B?Q1h2NCs4bmk2QkZDaUFuRU96c2poNnY1cFpZWkkxTkpyRnRhRE5yNjVsbktH?=
 =?utf-8?B?NkQ1aWtOZ0VDbDMyTmFha0VhKy9hTkJEcTVoSUNQUUUxVlRTK3c0ZEZsM0dF?=
 =?utf-8?B?TzVUcG9ic3laand6MTN6TkZibXdlcS81WTJSMmd3L2U0UW02dFN3L1gzYklR?=
 =?utf-8?B?UnhidFREa1YveS8zbVdiREFWN2V6UW43cllieVB1VUIyU0xBZDMxV1AwTllT?=
 =?utf-8?B?cGdFcGxzN05SR2wvOHA1MmNoVEJKOGRvWVBpMGpJb3dWM3VCajFJRk9GMFpl?=
 =?utf-8?B?TlZZa2dQazF2Z3AyNFFSbzd6dlZkRVAyN2F1N0JubzVEbWtrbTR5bVlKSlNr?=
 =?utf-8?B?aFZlM0Q1REt0clBDZ2dCa2gvUzM5eHZyV1RzYytiTXUwdHJtR2crSXBEMXVJ?=
 =?utf-8?B?ZnUxVXRiQ0VocXBlU01tREt2NitJTmRpZ0s2TlJheXNEclRGMXM3UTNYdGRH?=
 =?utf-8?B?VEdTVXBQVjBlUW5IWHNGSGxyc2hiNENueG5rMS9lQVdEN1dMVi9yamcrTmY4?=
 =?utf-8?B?RTFmQU1hSXlCdXlYU0hZcW9pcEI3K29OTnU0ZURiT0hKSDFkcUJCajdJdU92?=
 =?utf-8?B?NnVzamsveHd4Y0Rld0xaR3hjaWc5NHlvUmN0Q0p5TXRBMmFQbEh0TEYwUUU2?=
 =?utf-8?B?UWtxc2VhUnNMeER5Zlh6VmtkaGNNZ3lSOHZ5SnBrbnQvYzl0Y3BKU3JNVFpu?=
 =?utf-8?B?MG4xY1ZUeFZiT3FCeDIyQVYzd0JFcUUvQXlSUGpzeWRmZ3pvYnFJTUJLOXll?=
 =?utf-8?B?eDVzZC9TTTBqQXZCdTgreTBQYlpXSmVPRGtrS3pjQ05GVjJLaUw1OFRMZ29n?=
 =?utf-8?B?cWJ4OXdFVUxzQ3NrUGMwbityTTFKc1QyOGNTOCtnMnJQSFFiRXlwdlRaY1FG?=
 =?utf-8?B?VlBVdmV6akxrdHgwYi9EOFJhMCtreDFVWnRDT0lBRkZwRkFuODRkb3A5UXN3?=
 =?utf-8?B?UFJXNHI4ZjBtRGNyZ2RJLzdjL1ozWjlMWkZJQzd6NVNQL2lORHBOVXJCRGx0?=
 =?utf-8?B?L2R4aWRhQ1VwNzl4cVZwZHRDZkswOU1VRHc5N2kyZHdVNm5HRWdHemptOCty?=
 =?utf-8?B?SFRZSkxDN1ZiRm1xZVMxZGh6dlloZllGQ0xBU0hZdG5MRWMzVTBJbW9BWHU4?=
 =?utf-8?B?SE42UUx3ak1RTGNMSFh2QmNKazY2dWlMVk1Jdzd3RHlkMXN0dlRaRUFqUk9X?=
 =?utf-8?B?QzYrZkdEditQY2dOQ1ZvczlQOXdLYXZrR05zOW5QbGtGZ0hINFdvYmNMeG40?=
 =?utf-8?B?L3JzcWNwbndPN1lOQjhMV0lHNUhhU2ZUSGNBRGRRampjTXNOV0RxbVRtS09I?=
 =?utf-8?B?US9RaFdPM3oyOTVQN2tJTjY4VHRqcWxXcCtHNCtkbGUyU1FENUNVSUFrT0Zz?=
 =?utf-8?B?Q04yckJYMytXVUR1djBYeTdxOVVjckdyM041anpjMmg2M0s0NllrWjF3YXRt?=
 =?utf-8?B?VHMvVUVWTTFsMXBRNWY3T2xCSjNrRXJUMldpTXgzcVRycjFxWmtNQzlBa2c0?=
 =?utf-8?B?Ty90TTVHR1FLaTZJU3VFcS93K2Y4NUNmU2owYTRIQ0VEMmhRNU9UNFlHVHRD?=
 =?utf-8?B?MmpWWitlOEpJVnRwekNyL2JScFZzTTRmQVJqSmZ5TUVrZ241R0JRNnFseXUv?=
 =?utf-8?B?Rjc0SDlmVWwwM1NsOEc2WGJnMjBKeUxJS1I4L3BPelhmeGF0TFJvaGtORm9F?=
 =?utf-8?B?WXJwNy9nNjB4QjlLMTdyVDZPV0NUeTc2NVJEZ3dMYzJnWWI1cGxQYXFzQms5?=
 =?utf-8?B?b25rbFBhMWRMTEIxc1lDVkpqcXlMQy94WEExeVJONW92VFBnN1hvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uYeI9SXnY7m6n5I/kVHq+/nUM/6URUCm5gPh0f1by4kADPTio4HaZAbXv4DJxvB9GbTvOQldGKD+ZrmO9lx5/0TAmRaPIeDkQzpNOXNnlGYnHdEAkWQwiZE9dq6T435DkKTYqrjYFeLq1uaxtwnur+lvxWPYesDO+6dUvyMIfe1Q0ztBv0feU5J8bmL88zUbbZLQKN+QoUAcMW+ID5lR+EG5SRqFsUbkWwbsmqFkl/B8GTFkr2s72YTC2h/2XHc/G8+2aArxKwkgZIDPSd08XL6M/NRV6EnAcAaI8l1gcbuK4cyENsry49oz7U1nTEDspMi3Ivwh3lClGNhD6IbxKw==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb60750-b66c-47db-5120-08de912044a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 01:28:10.9415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6388d0iMfrlh+OUnaZO1zKCfs3aN1GG/xNpZMQy+drwj8d5sSA4ZcG6SVn6x7czIemhTT1EvndC7BfpxnMK/fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDAxMSBTYWx0ZWRfX/+WwDwtsO6oA
 IUpckTKwa1ZuQu702nJ3KJ23veep+iPOhCcyhe9QgEBijvxHs0v+jMYMMK6o2arfmsiLqW2eLXA
 eDXvX9BKIy5TmInrvk+o6crYf6DHaw3RbCA0u4gzmzAPIQh5voStFGAPDD5N6u8ybufKxsceDmq
 rIGjH3O8hwoFx5mXFrkbUCm8An6Ta0ofgbIYd1JSC1OwdTD519yhJYIYCVflvwGA2goAmkhCXTl
 lydgY4s/mdBZoAfUKKM1bw/awO7XSBgX7Tle2WvVWDerQQM7yMQb0WjJiqyeG9agkEANqK/pi+c
 spD9fPW0j8YzP1Dm6Grn9eTe2jzuMGwjrXOwzoGReAMgIvorqyIbBTeBvXw9GEVBreCHBOwn4R2
 8RT1xSkweO/YVlSoScAeZ0kd14ty2lR+4DVHUFZvmQF3U2pF3p16JomNRXyIgjfXJppjA2xL2UM
 u9Q4MBu29nXMsryBQuA==
X-Proofpoint-GUID: rYETQDEBQpLxUxpi9aDyLcXMuVevy0OS
X-Proofpoint-ORIG-GUID: rYETQDEBQpLxUxpi9aDyLcXMuVevy0OS
X-Authority-Analysis: v=2.4 cv=Rt3I7SmK c=1 sm=1 tr=0 ts=69cf17af cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=gLxAKuEMs0EQMVFiDJnH:22 a=uherdBYGAAAA:8 a=8rWy6zfcAAAA:8 a=jZVsG21pAAAA:8
 a=iLNU1ar6AAAA:8 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8
 a=25glldxEvdPLx6YBPSkA:9 a=QEXdDO2ut3YA:10 a=hlJyneSgMmFPbskH-t2w:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030011
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

VGhhbmsgeW91IGZvciBtZXNzYWdlLiBSZXNwb25zZXMgaW5saW5lLg0KDQoNCkludGVybmFsIFVz
ZSAtIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
dGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBBcHJpbCAyLCAyMDI2IDg6NTYgQU0NCj4gVG86IEJhdGhpamEsIFByYXZpbiA8UHJh
dmluLkJhdGhpamFAZGVsbC5jb20+DQo+IENjOiBkZXZAZHBkay5vcmc7IHRob21hc0Btb25qYWxv
bi5uZXQ7IG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tOw0KPiBmZW5nY2hlbmd3ZW5AaHVhd2Vp
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNV0gU3VwcG9ydCBhZGQvcmVtb3ZlIG1lbW9y
eSByZWdpb24gYW5kIGdldC1tYXgtDQo+IHNsb3RzDQo+DQo+DQo+IFtFWFRFUk5BTCBFTUFJTF0N
Cj4NCj4gT24gVGh1LCAyIEFwciAyMDI2IDA3OjM3OjU4ICswMDAwDQo+IDxwcmF2aW4uYmF0aGlq
YUBkZWxsLmNvbT4gd3JvdGU6DQo+DQo+ID4gRnJvbTogUHJhdmluIE0gQmF0aGlqYSA8cHJhdmlu
LmJhdGhpamFAZGVsbC5jb20+DQo+ID4NCj4gPiBUaGlzIGlzIHZlcnNpb24gdjggb2YgdGhlIHBh
dGNoc2V0IGFuZCBpdCBpbmNvcnBvcmF0ZXMgdGhlDQo+ID4gcmVjb21tZW5kYXRpb25zIG1hZGUg
YnkgU3RlcGhlbiBIZW1taW5nZXIuDQo+DQo+IEl0IGhlbHBzIHJldmlld2VycyBpZiB5b3UgdXNl
IHZlcnNpb25zLCBzZWU6DQoNCldpbGwgcmVzZW5kIHdpdGggdmVyc2lvbmluZy4NCg0KPg0KPiBo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9jb3JlLmRwZGsub3JnL2NvbnRyaWJ1
dGUvX187ISFMcEtJIW1HSA0KPiA0X2gwQ01ZVVduY0FiYTVJZ1JQdW40UzZaR1h6YmVveEpodHNj
OGlLaFRlNTFqTFJOanlPb0hJRm5nc2NDOWg2Qg0KPiBlbEdIM3NIQ0llZFdXWHRGWnZBaFlRJCBb
Y29yZVsuXWRwZGtbLl1vcmddDQo=
