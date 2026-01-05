Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C58C2A062
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 04:21:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CCAA4028B;
	Mon,  5 Jan 2026 05:21:45 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1701840273;
 Mon,  5 Jan 2026 05:21:42 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 604NSP7b1163865; Sun, 4 Jan 2026 20:21:42 -0800
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021139.outbound.protection.outlook.com
 [40.93.194.139])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bf3gmj4mh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 04 Jan 2026 20:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxYA37I9j//kb1tdkh4OuJ0VeesLzySv0fBytknKSSLs2SCOXIVh3wcwwgCzehfiVRlf2xdscnsXSqbeTXWjpO0JkDken/YDqTVuG26g/48Kdh9M3IR3Np/jKN/oP+sm1EzNTPfbTAXIcO6hIPjtLt0SsH6K1SPVaOBe1M4eBGEb99Nz0veeWayPWZ5VtgOfYkklcOURea+VZ3kP4SmHe1dD0+shets+D0aev6q+ILhUa9dDG9lvw09UIDQ/KXytRY9UCkGBxDmJPbpm1EUnuU8q/sgLwIfix5E5LfNXoZsnXlp5Haj2FLpFMlkY3TZLxT8FYVht6VrziauCq64x3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ji1mpGjc+vVW0aNChqk5Vxt0pY/y10oaAUrA8oOjXY=;
 b=yY9uGT+f7S6Mp2Rn8i1KkmzC5qjJZfKGRc5juwHsgww/s4QTnI3cjPS/9AsLdir+y0ZGJa7ZHopK1TjaDXmvsDOB6OawnmYTEcxdAKAb01LoXXMjmuNQE30KQtZbBu0fPzD2NnaFtekfe6gLhXB8NWIXiTFF0UuvOI1XLoTOs5CqaVXoeFeMIAMuTC3K9h0AGVkUSPmJPxPSVu+gLftshHsapyeVPvzvXzTGWniPIzh+r4YIdgVDaOzI1OKUHxY90AzoiTTQnzdQcPGHbBK/19HUkRUJqXi/D+BvMxzQYrwSGzMh2JiJ2z4HnsWXtfsgst3Xsv33hr78W/n5cXLY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ji1mpGjc+vVW0aNChqk5Vxt0pY/y10oaAUrA8oOjXY=;
 b=hy6ajC4qUHa8mDNPUxxzN0fCFJa//w+oa6yGBgzbYOobu3tFaqk8Us8/gww2PvYitl/XIVe+g2swYHyrVLB4J8dFA6IuHi1tbaNLh6UvK/7jmQkgtUP4h7pG/pqg/tQvAryt6ItJlJHm+Xdk52pPdrH1TJhidZZveAaRXYbIrhw=
Received: from CO1PR18MB4714.namprd18.prod.outlook.com (2603:10b6:303:e9::18)
 by BL1PPF8A51B4558.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::da7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 04:21:39 +0000
Received: from CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06]) by CO1PR18MB4714.namprd18.prod.outlook.com
 ([fe80::26fb:729e:a947:3e06%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 04:21:39 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 7/7] examples/fips_validation: avoid
 rte_memcpy() bug
Thread-Topic: [EXTERNAL] [PATCH v2 7/7] examples/fips_validation: avoid
 rte_memcpy() bug
Thread-Index: AQHceb5eAgAgsDlNfUKaz8r62j84drVDAYQQ
Date: Mon, 5 Jan 2026 04:21:38 +0000
Message-ID: <CO1PR18MB4714A82172593F7EF513DEAFCB86A@CO1PR18MB4714.namprd18.prod.outlook.com>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
 <20251230185837.301163-8-stephen@networkplumber.org>
In-Reply-To: <20251230185837.301163-8-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4714:EE_|BL1PPF8A51B4558:EE_
x-ms-office365-filtering-correlation-id: e458af95-cdb3-4d5a-e08a-08de4c11ebfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7142099003; 
x-microsoft-antispam-message-info: =?utf-8?B?UFRzWDlnN2QzbCtDVlVFNVJsaHdBVjZjMnJFb2E2Z2RxQTlWVGxqL2lvMjRs?=
 =?utf-8?B?OXY5QWlMMEpBSnZQYlh0TUVQMjMwa21HdHg4NXdPNDNKRXU2NXJ5UExmejhR?=
 =?utf-8?B?M1QxVjRKR1lUSTdrRHNuVzZWNFk4SnM4UzVubE4zWjZFM2taa0ZDNS9vbDB6?=
 =?utf-8?B?enhTenZuSzR0QzNIWHErYkNTK3dPeTZMcE5wbzI0Qkkva2JDK3hENGxtT1l3?=
 =?utf-8?B?c0I1SWd0cWNFcUJKbEd6NVZOQzVQWWthNGRKZ3kxNXhsbmJNeFhGejNvUmVN?=
 =?utf-8?B?bnVmWG9DY2cweW14RVdLbS8zQ1c1Y3dPQnYyS3BkODhUU2MyRlcrUmxNVVBR?=
 =?utf-8?B?eVNoTTQrSU5EaWZDNEZZVXE4Q2JBai9rOENDbk56VVMyNEhOYlRMRWRRQXE4?=
 =?utf-8?B?Szl4Y3p5NzRuUEFSMXlrL2laS0dyMzczZWQwbng4aXRudVFGbEw2eU9iUHN2?=
 =?utf-8?B?Tm9laHRpWUFYT3phQXBLZXFJT0ozR0RjdkNwVmxHR1BZUmZrY0V6c0poTGg0?=
 =?utf-8?B?YmMwT2JyTDZUZStjb00rSmp3QzVMNUM5SDdCZHNEYU9hSE94M0dYcmJZM1VR?=
 =?utf-8?B?RnQ1RFNhUWRxbU8wYzRFYkFHcWcxd05CbjNhVFRzMU9mR3JCd2NTK0ZpSTN5?=
 =?utf-8?B?UWtlTXJETm5EU1krcjhXTHZ2SW8wWTExazFONERWa0Q2NEdVazlMbzE1SXd5?=
 =?utf-8?B?MVpHVDFpMmx1TS9wMHgvUlN5Tm9nRVpxY09DbnJ2OWlSOXFvKzZ0VW0vdzk5?=
 =?utf-8?B?V3FId0dnVWhTd0k0dW54L2ViSE5za3RYUXdTWDZjN1ZSamR2M2xBaTdMV2tG?=
 =?utf-8?B?TjNiQTFBZDBMTGlHSzhmb1VqTzJBTzMwMG5LN0tybU9sdnE5aXhnWGNIbzJN?=
 =?utf-8?B?RzNWK0lSRmR2UThJSG00bzY3V0FMOXh1VENFWHFaYmw1aWhqbmp2ZDAxQkFw?=
 =?utf-8?B?WEFzTVZIbnhlYW5hRHZ6TWtGSEN5WEJuYjNwNXhpb3FoT0taR2NudzlPYzIz?=
 =?utf-8?B?RGlKT2E2c1lHRmV4aWpOU0FJajQ5ZzJqaFFLNjlSWm83NmlHTE5QTVNEQ3d0?=
 =?utf-8?B?MUYwbkQ2d3hYeUZ2YStVYlNIcDFmbmxsSisxT2o5V241cjNwUitqQ1VaUUVU?=
 =?utf-8?B?bVdvWWJwNU9NNlhGQm5abW8waitibkYvNVkrV1R1bGhHWkdINE42dlQ2OW5N?=
 =?utf-8?B?WVZnMFBRVERzNTh5bzFLYzdnZmNiQzF2QTZjVEFxQUJOMElXNGRrN3pFU3NJ?=
 =?utf-8?B?NExsVk02ZHJyMmJWYk9wOWVwcnJ4bGdRUnNmZ0RDZWRNV0d1SGExc3dDb0pU?=
 =?utf-8?B?dkNwZldPMUxmU2hDaWFVUmoxVnl4Rk0rWGVNKzdGL2FGamkxUFFvcUNJbUVw?=
 =?utf-8?B?QzBqeFFBOUpuam5mZjJrTEN0aVE3KzVzZ0RRU1dpZHUycEdSTGd0aEpSYzc3?=
 =?utf-8?B?NmR4YWRhV2xCZWtibEtWWDkwTE5SZzQ1Y0dpcU9mZnVIQU8xVlQ3T3Rid0w4?=
 =?utf-8?B?MThjS3dEaGtNWFhJV0VxOXcxVlphaUlvUVlQWkFwMW0rcTEvWUVEaUQ3NEtK?=
 =?utf-8?B?dE10aU9lN0t0ZXJuNFdZaGpnc0dZVWIxRG90emNWQVV4QUhpTmcveXJhcFBB?=
 =?utf-8?B?QXVXQ2t1dy8rb2p5Ry9JUmJrUGpaejd4TGxGeW9Xb2VaYThVbU9OdUlvTmo0?=
 =?utf-8?B?dHg4cEN5Vmd2L2JNb2xIRS9KdVlJcUFXNlllRGhDZ3VtNEo0djVaZk9sV0xM?=
 =?utf-8?B?RUNZaWxSeS9wb1oyVmlORStyUUVZUEhEOWxTNERHdDlkbHNSbS9laXFMUXB2?=
 =?utf-8?B?SXIvVys0ekJxT2p3c3dnMit1bnZJUTZoZSs2L2ZOSDBPMjF5endhdG9VWVph?=
 =?utf-8?B?KzBCWEFLb3VscmtCQk1mZTE4ZmQ4b1JsMHBYMUZub2s0N3NhWHJwVW83TVY2?=
 =?utf-8?B?Y3ZyNExRWlNTTzNqUnNYbGY1YWpEdFhmOXlCdFozbXhGbzk0TEQ3RlcxcVhE?=
 =?utf-8?B?SnlMMG1Eb1lGbGl1SlQ0blF4RzVYSGpmRTFpdmpUUzBMa3ZrYzdCblRudVJE?=
 =?utf-8?Q?rPkagD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4714.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7142099003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU1Fc2tRQXl5MThiUi9nZy9RWEsrZG5pQXBMeEhwWDZQY2xEQWx6Y2RhZlUv?=
 =?utf-8?B?VDd0bGNzcXdsY3ZVRWZWSDRDUWwydVFVOENSYXVkTkxuVUQ4eTlWT3F5Tlk3?=
 =?utf-8?B?dy94NFB0UWtiM0J6VEoxQTl5ZGRUM05OQTRLT2pDOGVSdllsSDBTN2lNcGpU?=
 =?utf-8?B?WjBFWWY3SGpnVHdUcVNSTlJHUmhGdk90K1FESkg1UVB2cHpzYkVNekFoeHJR?=
 =?utf-8?B?c2R1b01OaWZhRU1zWXV4cDN3QSsxR2hHWWNNejl3RDY3dm1FQWRraW4zbG9H?=
 =?utf-8?B?UG5EaDczQm5HWlRYdnVBMGUxZXZpRFZSUmtLTWdnMVNVelJWVno5VlJPb2l6?=
 =?utf-8?B?NGNVdjRWUzlOeUlQWUtrVGZzTS9EbDlNQ3BnaGdRZnVTaXJ5d0tvVjE2eXRh?=
 =?utf-8?B?Ym5XeUs0ZVBRY1N5aTR0dXIwSFlQVllxOU1KdUQxb1ZRQmw4NmM4TGUzVUpi?=
 =?utf-8?B?dEhwRTRaUXJNRW9PeVF5ZVhUS2w0MTBudVJoL05ieng0aXA0dXhYVkVhbm1i?=
 =?utf-8?B?NS8xZ0lIOW9hVUZWUUhUN0VKS1dhemZDRWVUSnM3M2JqTVl6dTFhQUo4TWtr?=
 =?utf-8?B?c0xhNXRLak5VQ0Q1bE4zQkVzQnYxWHBoS2Q4eHhmTUhLK2N6R2E4bllzRnBo?=
 =?utf-8?B?SEhoS1BaL3RkbWYrNkVOelNZYisyNkRFbDBPZ3ZTNlZ2TVZKRVFHcVo0T0w0?=
 =?utf-8?B?QzQvODFLcWhOelJEZDhQVWR1L05OR3RYWUJtVGlaaXVWQVNFUzQxOG9TeHM2?=
 =?utf-8?B?SzljZk1RVHQybDBtRG1XdElSd2tHMDFQanhEY1NmS1FuMjhBUEd4ZlU2UFRq?=
 =?utf-8?B?RzBDU0Y4ZTZKRDJSa0VPeWNmUW5na0ZjVmFSZ28zYTV5SllCdXdrbEZpNUxh?=
 =?utf-8?B?N2RYZ1dESlZPYVgwT3hUeG1MZitrWmZVUVBIdWkxR1AyVUR2YnFTSG5lbFp2?=
 =?utf-8?B?SXZpYW5FL0l3azlhYjBZZ0JrY01TT2R4OVJvZ0l0ZVJLU1d1OXNYa3oxdUNa?=
 =?utf-8?B?Q2s1Z21vWGpXOHpvMFVnQThTb3BMNzUzZEJncEczMjBqOFh6T1JCQitYU1Q4?=
 =?utf-8?B?TmI0ZXRwTVZYQ2FRWGNsbkhrbW9oc3B1L1JacW00Y1pyNmsrU2VoUGdGUlVY?=
 =?utf-8?B?QktZRVB3ODBEZ3JKK3JMeGhwbkhLdVVFZmxkdTBqZ1BGd2hucVhJbUNJbnI4?=
 =?utf-8?B?eTVPV0V6dTRhay9tZFJ0VkE0dmJTVkloUk9JU1VxSHRlZVVWanljZXdTdzVi?=
 =?utf-8?B?T1hXc3lQSTRMS2k2U1R1RFlycE5LQXkzY25Ddm1GQWhCS2t5eGNFQXpiRFZB?=
 =?utf-8?B?d0hrbmpnQVdIY0puNUI3QldCUFpUbU10Vmxkc05iOWFtRXp1Y1NOcDc2OXk5?=
 =?utf-8?B?WFVrd040YndWVGtIQ2hidTlKNTlGdVBLc3BHY3NrU1g0S0pZeVFRWkErZlps?=
 =?utf-8?B?K3dKK1FPTVo3UlhnZXBlYVJkUTlqTGk2QWNJY2RoK3JXdGlVMStXZkJ1dG1M?=
 =?utf-8?B?N0JvK3BaOGhLbDNCVXg2N0V0dzdlWHhzZ0VweXR6R3lWQzFZdFc0SG5POHhy?=
 =?utf-8?B?WE44Ujd2TkpHdzRBTWpuWHd0Z3k3N0ovVzJXOC9mUS9adzJrRDMzRGRsMUVY?=
 =?utf-8?B?ZWVhTzYwRThobTJSc2FyWmRkRHpBUWtiNXp4cGhTdWd6cklyaHVXQzU1TEd0?=
 =?utf-8?B?QUVFdU10UUNIVnJOalEwcTNiRXMwd2RJMUF2bDZUOUVITkdjZ3hkMWIxU2J2?=
 =?utf-8?B?R1Qyejc4c3ZpbnBMYXJjOUhGakNHSmZOcGs0cFpPVEVKbDJCQnVZSVpMVnZZ?=
 =?utf-8?B?RDdCZUo3T0JWdStKcXY0L1FNS0wzejNqSkdpaEVyQ0hsVkVZUHJnYVlNZTlP?=
 =?utf-8?B?M09rTnJGZkNDWG9odGVKS2FiOXZ1YndEcmlZNGNYRFNub0laTFBiM2lnem4z?=
 =?utf-8?B?TWFURkR2NGcwWis2RStQSVBGcFZSVmFkbGJ2d3JrRWcwWmdJOThFNWUwa1Ji?=
 =?utf-8?B?b0M1Vlc2bmw4bU5VRlJWQ3BMVkxwangwTjhhN0N1RlVhajRYaVEzd2VQVTgy?=
 =?utf-8?B?ZGlnMVRrY0pvVGVCUXBSYmd5emZlRlp3OFRQalZJWHBuWW9ObkNYOHdzd3Vo?=
 =?utf-8?B?SGRiOXBoOGZxb3ZlMzNsUFB2VW1DdXBJVTc0OFZ1aHp1TzdPWjJSZW90QXE3?=
 =?utf-8?B?a2drRjNkVFJXR1dGR2RLSFU4MmVKQjJvcDNCSytGY3Q3NXBTeVJEU2s3OExh?=
 =?utf-8?B?ZU44aGlvaXBFbElGNlBOL3VJeFF0ZGRGLzhhZ25CL2FsaG9OQXowOW1ndGpm?=
 =?utf-8?B?UHNWaEJ4YjBjQS9hRGVZb0NsWlduOEM1NHllTDJTUStrL1hVbmZ0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4714.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e458af95-cdb3-4d5a-e08a-08de4c11ebfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 04:21:39.0181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCuqP34IOq6MukTkJuiLZWKZNjocyfD9ImKzeKnxnEXWnARFvwOeYIFoneWyQvBg4WWn7b+vl0XDXAN6MV5YiHyy41/k7dnzSziXH87l+WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF8A51B4558
X-Proofpoint-ORIG-GUID: Zbl13vkcXefadmAzzRR4ufT2T_JS_jFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDAzOCBTYWx0ZWRfX858epSqYShiu
 zhRc2xwO7mYywR/w3wNdtFs+gjP8Q8VeWRGYWipiHqO5vfHPG9/Yn4GOBMYl81VawlzsVD8RCQo
 1oxRPBS9k4i1KWq+dAbtE1948dzj/CcuOc5Dtl8UOy4q8jVXV0gRbZuLMb6OknjO6cdncT4BAHj
 3xUMiqNgbQqm2S+0CQ0UnjAq+eAH+69LAfZszgBbBKoQL6aLfnrf6yKwuLgDiZHwA8x4KS3TFCB
 rULy8yvQuWdJ2SYURyBAgsh4e2/H3gzMrbGW58/Ed/C+QlJdJU0tnuxtxYJyfLVqjJoplx8heDr
 wB/nOZQ6WvLiN07+l5Qvico/zP1T4UJG3bhciwWS1c+9LsalHXZrczduiV0e5SqhrqZtFn/IqTc
 cL37gaY7WoCjtYePdxPJpCOjs6zZJ871UK46dVbZCH4EuSKL9RjLDa3rt0OlQ42681vyy0DUiba
 Xkko5i1WvOYl4PRMMtw==
X-Authority-Analysis: v=2.4 cv=PcXyRyhd c=1 sm=1 tr=0 ts=695b3c56 cx=c_pps
 a=pIYMM0/gwuUbaZnCr0OhEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=jZVsG21pAAAA:8 a=TRug3iIhX0IutF_RrBsA:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: Zbl13vkcXefadmAzzRR4ufT2T_JS_jFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_07,2025-12-31_01,2025-10-01_01
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

QWNrZWQtYnk6IEdvd3Jpc2hhbmthciBNdXRodWtyaXNobmFuIDxnbXV0aHVrcmlzaG5AbWFydmVs
bC5jb20+DQoNCj4gRml4ZXM6IGFlNWFlM2JmNTk5NiAoImV4YW1wbGVzL2ZpcHNfdmFsaWRhdGlv
bjogZW5jb2RlIGRpZ2VzdCB3aXRoIGhhc2ggT0lEIikNCj4gQ2M6IGdtdXRodWtyaXNobkBtYXJ2
ZWxsLmNvbQ0KPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGVw
aGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IC0tLQ0KPiAgZXhh
bXBsZXMvZmlwc192YWxpZGF0aW9uL21haW4uYyB8IDE0ICsrKysrKy0tLS0tLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2V4YW1wbGVzL2ZpcHNfdmFsaWRhdGlvbi9tYWluLmMgYi9leGFtcGxlcy9maXBzX3Zh
bGlkYXRpb24vbWFpbi5jDQo+IGluZGV4IGYyMTgyNmU5ZDcuLmRhZjI3M2JjODUgMTAwNjQ0DQo+
IC0tLSBhL2V4YW1wbGVzL2ZpcHNfdmFsaWRhdGlvbi9tYWluLmMNCj4gKysrIGIvZXhhbXBsZXMv
Zmlwc192YWxpZGF0aW9uL21haW4uYw0KPiBAQCAtODgyLDggKzg4Miw4IEBAIGdldF9oYXNoX29p
ZChlbnVtIHJ0ZV9jcnlwdG9fYXV0aF9hbGdvcml0aG0gaGFzaCwNCj4gdWludDhfdCAqYnVmKQ0K
PiAgCXVpbnQ4X3QgaWRfc2hhMVtdID0gezB4MzAsIDB4MjEsIDB4MzAsIDB4MDksIDB4MDYsIDB4
MDUsDQo+ICAJCQkJMHgyYiwgMHgwZSwgMHgwMywgMHgwMiwgMHgxYSwgMHgwNSwNCj4gIAkJCQkw
eDAwLCAweDA0LCAweDE0fTsNCj4gLQl1aW50OF90ICppZCA9IE5VTEw7DQo+IC0JaW50IGlkX2xl
biA9IDA7DQo+ICsJY29uc3QgdWludDhfdCAqaWQ7DQo+ICsJc2l6ZV90IGlkX2xlbjsNCj4gDQo+
ICAJc3dpdGNoIChoYXNoKSB7DQo+ICAJY2FzZSBSVEVfQ1JZUFRPX0FVVEhfU0hBMToNCj4gQEAg
LTkwNywxMiArOTA3LDEwIEBAIGdldF9oYXNoX29pZChlbnVtIHJ0ZV9jcnlwdG9fYXV0aF9hbGdv
cml0aG0gaGFzaCwNCj4gdWludDhfdCAqYnVmKQ0KPiAgCQlpZF9sZW4gPSBzaXplb2YoaWRfc2hh
NTEyKTsNCj4gIAkJYnJlYWs7DQo+ICAJZGVmYXVsdDoNCj4gLQkJaWRfbGVuID0gLTE7DQo+IC0J
CWJyZWFrOw0KPiArCQlyZXR1cm4gLTE7DQo+ICAJfQ0KPiANCj4gLQlpZiAoaWQgIT0gTlVMTCkN
Cj4gLQkJcnRlX21lbWNweShidWYsIGlkLCBpZF9sZW4pOw0KPiArCW1lbWNweShidWYsIGlkLCBp
ZF9sZW4pOw0KPiANCj4gIAlyZXR1cm4gaWRfbGVuOw0KPiAgfQ0KPiBAQCAtMTYxNCw4ICsxNjEy
LDggQEAgcHJlcGFyZV9yc2FfeGZvcm0oc3RydWN0IHJ0ZV9jcnlwdG9fYXN5bV94Zm9ybQ0KPiAq
eGZvcm0pDQo+ICAJCQlpZiAoYl9sZW4pIHsNCj4gIAkJCQltc2cubGVuID0gZW52LmRpZ2VzdF9s
ZW4gKyBiX2xlbjsNCj4gIAkJCQltc2cudmFsID0gcnRlX3ptYWxsb2MoTlVMTCwgbXNnLmxlbiwg
MCk7DQo+IC0JCQkJcnRlX21lbWNweShtc2cudmFsLCBiLCBiX2xlbik7DQo+IC0JCQkJcnRlX21l
bWNweShtc2cudmFsICsgYl9sZW4sIGVudi5kaWdlc3QsDQo+IGVudi5kaWdlc3RfbGVuKTsNCj4g
KwkJCQltZW1jcHkobXNnLnZhbCwgYiwgYl9sZW4pOw0KPiArCQkJCW1lbWNweShtc2cudmFsICsg
Yl9sZW4sIGVudi5kaWdlc3QsDQo+IGVudi5kaWdlc3RfbGVuKTsNCj4gIAkJCQlydGVfZnJlZShl
bnYuZGlnZXN0KTsNCj4gIAkJCQllbnYuZGlnZXN0ID0gbXNnLnZhbDsNCj4gIAkJCQllbnYuZGln
ZXN0X2xlbiA9IG1zZy5sZW47DQo+IC0tDQo+IDIuNTEuMA0KDQo=
