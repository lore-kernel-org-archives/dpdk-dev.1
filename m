Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D4C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 06:04:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A16934026D;
	Fri, 25 Jul 2025 08:04:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 945084025A
 for <dev@dpdk.org>; Fri, 25 Jul 2025 08:04:25 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ONV6Fr006034;
 Thu, 24 Jul 2025 23:04:24 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2118.outbound.protection.outlook.com [40.107.100.118])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 483xjp0k2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 23:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEk5y9iNpek7H9b4LGcfYA/If7lfxHnOEd0M5LA7bJ4/HkV4Vy8jEkroFsLi9RZjY9cpHu8/HMWnyj4tVO29SIClVUl/Ilh8Gu/LOyi52dagJdAP+zvK6Mt4av0ybqg254GEqEeCDYwfFwVXZ1O4sIhgBSxvVBElcmkPBVFi9dt8VgSR7ZC0xTGfpC95seODmh8SQ1mt9o6bJfgPXKHYVfjWIl5Q+59eSE9WkKmjuWyGzyoFwlr7/ycWUOhhEbdAJ2easWUL0NWP+hiLgZMw2sYzHGzc6v3qpkhgxLCpkgULgAsm0s5rMKgDYauyE/PmSaq5i4D8nSkWEeYRSQrIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao0uYrlPUKqnaZ8qqoT0kdYp3sTC/42xpebpmmYlIdo=;
 b=x+dIM5RMidM374KHJgajTrTGOQlymOkbfsj5Ez+jbTVxVb/GRk1JijK2h+2I7ruy/CR1pEkKanCDkw9LyA0ELKpKwUxHNmp1hej/WV0oPbnj3a7Qr/sCoiNh6CpFoUT8eKNrb6d4kCtZJ8OzVtmW4JnUrMDZAJxi210OoHw9AVNpImN2r2xKjxf9et+a3iFnJKYzFeLYuLQCmfd2Ran7+GJFdnu7l6RuRdcTZxx4IxGBunQ/kweB1O7usTSk1uhUflKujIBTmCwJ4yc9fwUoKp00JuJyxzvFXqoHmpq7ykn7moJBGjWtOWiaxRewa7YKmGcMeT7wwGXMmVWdZuOzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao0uYrlPUKqnaZ8qqoT0kdYp3sTC/42xpebpmmYlIdo=;
 b=vfN6IxEZrdFjnCrOB6wDy1gzoiEOT+4j4Ygy6iAxO9sy7MUkh9+fw+sZiN9QDe7ExtNC9z2R8+yF33UkHjHPJf82rDV/lJ8+I+tZUs2qJ6qSkcj/2noL6lwvJuuMWhwrXYX5jiuZG8TKzswpxTVxBFFSzY3ODzh1UeC+E60ypV4=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 PH0PR18MB3816.namprd18.prod.outlook.com (2603:10b6:510:49::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Fri, 25 Jul 2025 06:04:21 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%3]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 06:04:20 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Amit Prakash Shukla
 <amitprakashs@marvell.com>
CC: Jerin Jacob <jerinj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Vamsi
 Krishna Attunuru <vattunuru@marvell.com>, "g.singh@nxp.com"
 <g.singh@nxp.com>, "sachin.saxena@nxp.com" <sachin.saxena@nxp.com>,
 "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 "conor.walsh@intel.com" <conor.walsh@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>
Subject: Re: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Thread-Topic: [EXTERNAL] [PATCH] doc: announce DMA configuration structure
 changes
Thread-Index: AQHb+mfjg+2JwiV92EKoEHKCVDW9E7RCXj/U
Date: Fri, 25 Jul 2025 06:04:20 +0000
Message-ID: <PH0PR18MB40865EFFF34A38C49079F979DE59A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250416110541.10358-1-pbhagavatula@marvell.com>
 <SJ4PPF0C545507BB640772878BB9BAC8D6EC878A@SJ4PPF0C545507B.namprd18.prod.outlook.com>
 <3307880.vfdyTQepKt@thomas>
In-Reply-To: <3307880.vfdyTQepKt@thomas>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|PH0PR18MB3816:EE_
x-ms-office365-filtering-correlation-id: 6849c462-e364-412b-13e3-08ddcb4118f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lFLcnvQ22D481aQ/rJvb/CHblsN6sBEfKRkOu2CfBmgCuQ7Fjt7ay7dMcl?=
 =?iso-8859-1?Q?NHb6NZXvvkdSwS0L0jIbx4m/mhRcXasKyRzPC2nQx9OK1jZm4Av58OdjJc?=
 =?iso-8859-1?Q?jyiXcnldHVhbuSA4UbPTT2K7bCrEIoXMl8u2E45ObUkvoCBI+ZPEtSBKBu?=
 =?iso-8859-1?Q?QHGrJfYmpvHjJiJtZODJeeGMkdhlAjMn0mxJOWYaicPu756MHFZw0NuUCG?=
 =?iso-8859-1?Q?B07wbpxUs/X/PdCBW60lnnv6Q2EJ49UMbBPDimyORsGGP4fpMfvS36tfAf?=
 =?iso-8859-1?Q?f7LLFTmWp/anhT9sQ9libsTbc747U5pqaor96zk7zqGpoB1GVLpSQnykdB?=
 =?iso-8859-1?Q?ifh1jM/gP2cdkU+VLaeKScj0IFHmDtQU+dsVQuHXL3OzuQLB5yD2ZgrHjc?=
 =?iso-8859-1?Q?IFQ0vFukFXNWaIO/+mv+VeSBImInj1iVvoJP3s1RrU0TKgFt+aLDaBuZ+z?=
 =?iso-8859-1?Q?dpwYqCrrcd128ZbzYBnUUnkaJ7qZ+uweg4Uh9QR5EJ2gEr7NBIJnqwpEzb?=
 =?iso-8859-1?Q?6I3P/y5POGDJ9T0rJ3RHc5J/D16fPy7ALv2ZbmM/5fU2P5fBxhaQajjOJb?=
 =?iso-8859-1?Q?rIzPqhSXIBe23m1Y3yl2ddB0Y+kMl/GLidYeFS18UChCZHtAtW1tZGZTmN?=
 =?iso-8859-1?Q?h3fffmepZOsHsuPvw0zE31OriIz4OeUfAOsf5m0f/lKP31EzUqkUn1RoCl?=
 =?iso-8859-1?Q?vk0tFIiM7Q7fdOBv0hiuXulKVmXKJjlIyaeBwQWESAKMkGFeSIDNctzpIF?=
 =?iso-8859-1?Q?+OD7ZkBcu4ksEv9BZGKWZLIP2SRtMaMkUzwmEErjTRG4x0Lh6DXzq5DKnH?=
 =?iso-8859-1?Q?v3ZfsmjjT31cu95KReLg7LoOPAUOGn+MIRT+Pi05mGk1lEDMFzUlCFUIX+?=
 =?iso-8859-1?Q?Bvtk3/aKfeNTMHuV5gckITvrxLmEMkru6DLepRffe1ew6mbtugfZWqdpjJ?=
 =?iso-8859-1?Q?A1YBNoFrH9EnfWF4bOC/5gq5PvXus2FoNqWOKw+2Yug8yNbIWOLbwsIdSJ?=
 =?iso-8859-1?Q?NzqlqATcYorGUdt2ecjx12bXe/9HW7RLvvB1TkEBRchDkRphlChhbdDWr1?=
 =?iso-8859-1?Q?LBVrmxLii1I2gs8uuokzKQ/J04kEsCnqRvQlYDLc4cqRDtP8LIYgOc2pSr?=
 =?iso-8859-1?Q?dWIv+BrevHn75ofpV6+6yHT/9govXE/FQGv3fGlYIBVCo3hvLzuLRZfQyx?=
 =?iso-8859-1?Q?jHi4PB23WfiAxA7uuM+ZqpzsRzsVU5K8zCuxEK+5a/o3lt/q1fW69JhReO?=
 =?iso-8859-1?Q?HZh3BCmYG+rQNhSj7k2wZd7nZsGW9Qa4KlTFQq/1E53+G0mo2mzVpDTJbD?=
 =?iso-8859-1?Q?mayEKQsoOemVW1Bit7sCvCrVR5x49+xRjelFZ30UMy2WdNa722YA2a8r5m?=
 =?iso-8859-1?Q?maybW3wLU6DeVOz0KhYQivubrDDJaq5jVFJq48BkznPXa43gXBPOETzbcW?=
 =?iso-8859-1?Q?DjKglk+Yq/2uQI1Bp5uc8kletDDtr/vJK2SXUTLt4fDAf3ZG7EMLFegwJi?=
 =?iso-8859-1?Q?hkHI9cT7sHuYZpwwZ7OICbsPCbQVHC5CauPaGvLarXhU2b1szDVnLycDwv?=
 =?iso-8859-1?Q?yK4AG4s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5Ol+8E9ghFi7KqS3NMRYr/scVSBpNnQjhuoR6fM6n/F+FE39HPKxcJ8bBj?=
 =?iso-8859-1?Q?9g6illLASHE/lfQtfZkNAcNvmFa6cMxVbKuWMHes9Cj6kOdllROnnFRiDv?=
 =?iso-8859-1?Q?a04wsJ5CBLdV3tEsPC9NTs4fXNtihUdCt/jOLLYm1FyOfqKTOYgt777BnZ?=
 =?iso-8859-1?Q?PiY3NE94zXKW7OE18IoXzC8r4rU3Due+K5s3Z/+EW3ijHItjzNLjQIH6dq?=
 =?iso-8859-1?Q?ntZZaw6K3Yqt4PvQ5ChH6EHJ5wHDDvt1ojjQv6dgFoxoQp6MWhZu7ePuMN?=
 =?iso-8859-1?Q?3ZHBg/3oZ8CQUuZqtX6wRfKcF7p+ILqajBQg4LYzz7HI/MkDuxm+e+GL6H?=
 =?iso-8859-1?Q?vryUDP2U59pyJ8WAdMtlgnkDg466HR8oqxndN7+0AULkc8Hn6LKezdNtzV?=
 =?iso-8859-1?Q?ucwMYhz+VZM9HQ5gDpnCsQT0GG6wSmPXWhzrllE+JsSPPn4AWaubuX6ift?=
 =?iso-8859-1?Q?0lw4fV6TMgq9VCkCE6k5AqcNwUakHzl+UlXOhNWAU50IeDcwlM8qUKNdsb?=
 =?iso-8859-1?Q?d7juYrkW0/mHQHOTWuW7bN82gF58qnca/eLDH8PoIsjbcb6DbMW+HWHkAm?=
 =?iso-8859-1?Q?Wqf2wfy4uezkeZTudmmlTjEocFIiqU7YmsNaaNmeYskLc+koQK7j2ba3D/?=
 =?iso-8859-1?Q?9IXFElTWRLdkGB2aD97Viw2WTR81fN7mXn4WvesJEt0qZxw7BiMgpGerzc?=
 =?iso-8859-1?Q?IvdYyRlKNDZJ3hRenpufZ/Li/IhRNyXn6MCfcsI1ZQJi3atybYo7DVP7z+?=
 =?iso-8859-1?Q?FZwdkKa7Bv3QAn2QYzXbq53XLGqXdo2hPmjoFJx2EIfnhi7tHv6Eg3hF9z?=
 =?iso-8859-1?Q?/bWRd43wL10fAaeS7H+X6YXdRwOYqbe0UDWHEPDOp89CGAMEi1kFWtwwCk?=
 =?iso-8859-1?Q?RzamfcbmZpj52TKpIxOGsk27TqKr3Tp+UeE3/nDwe+oHRGbxKjP2hKe72U?=
 =?iso-8859-1?Q?ySJse6ijmufzd/M0gD4SPlSoJroAoYWKkzIfN5kAXkTcHdeOvZnT0mtcBv?=
 =?iso-8859-1?Q?NUlbsGWJ2PJRPtWRaTgRasyAXCT+aDPxLXyUwL7HwyyGFIkrYo7qaJDqJc?=
 =?iso-8859-1?Q?LHqLyiBbKpNdyZlkglpVis638a9UcXPyGO/Esdb6Z+H+zmBvDjPHwUC3zy?=
 =?iso-8859-1?Q?kUZPKEvbmSENuVnt89uamHsDTVqiKY2RRq5OJvqL48+Y7rhibF3ZZ4CIrV?=
 =?iso-8859-1?Q?5s4lANwEiUgnXbtPzm7xGwHpWGtwJZhDqJb0G1JZIgXcxfNyJf5M+6oZ99?=
 =?iso-8859-1?Q?xoijZvn3DGBGP5SCqO7p43glmOudPDgmllu6852gIE/dyDLIN9yLc1I13F?=
 =?iso-8859-1?Q?5LTPs3PJ7rjNTPnfOnwVE8T0QjUNm/y9Mrl+MuceGJOuB5q4xMomIGBzZD?=
 =?iso-8859-1?Q?bGMS8g47Ej15ZufDm4qvULSMuSQr0Bi2nrC3I07iWOiOhxW7z9vCqMuIYH?=
 =?iso-8859-1?Q?Ptq9zpmS8GuWo4TLpeapMSD8oxAk5P88Oabz9NQHmfI6itzle/L1PkuI7t?=
 =?iso-8859-1?Q?do0L6FR146LmGZr25PYrWZXjUbsf4zG6wLy+l4C6h7WKjvE26ARW3dLnMe?=
 =?iso-8859-1?Q?7u+Oe8IPN0skGq5TKxAD7rzMkNiq+wyrPiKlgp5APC31QII85G/6RUjCbS?=
 =?iso-8859-1?Q?5kYNpVgx0L6kcgTz0VuT0PjPFLg/5aOrS/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6849c462-e364-412b-13e3-08ddcb4118f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 06:04:20.7652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnxRXP/qMgtPSNbGcwS7Rsc/7gMNo/KAs1unjQxBJJqyAyR8JjUvLlYbabs0CNLN7ptfR62m3s1KpXZpYdyz788pP1sNnEOW+OnAuj3YoT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3816
X-Proofpoint-ORIG-GUID: sEqRnL_VftVhZiEQvPZCsBHnYdzwHFkN
X-Authority-Analysis: v=2.4 cv=QNJoRhLL c=1 sm=1 tr=0 ts=68831e68 cx=c_pps
 a=QwUpB/ogEeCTbrjYvoEbwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=zPAd3tv2xoSLNlOkp8wA:9
 a=wPNLvfGTeEIA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA0OSBTYWx0ZWRfX/A35Q7OcA69k
 van/bSrmRJoSe/LiW7J63OkVtt3bWyqSfgWp2acvmxGBWSO9tDQVaTnT64VIUuuymKjANGUPADm
 sO/H0JYcKP+gwI22N8HATBB494HQr3CZnVx3QnFydPrUsWFLRdZ9KjPo9OJAMBMHV2ud0QpVjDJ
 3AiFREzLn9HvcW+xoRSE9UlSQuB2+m5yqNmm0Pr1XES0QKO7FIdb3AA2EbQxXwyKz36OsRGipG4
 MpXMDXNA86l54JcO0w1u7OhZ5+YxE6Rs9zP1b3hULakOlG2a+dU0F3QKR0vQsDOPqd7kWBZt2lQ
 /ucq9LDvvObLONfTlzOfyOEnIB3eXamPR79VydWg2otG388cu4XKCR66qWw0j7A0jNFj5UcfEAk
 6Sxjy0qlTKs9IVzn35xX6RYs5M1xWPjsMIYi7ficvDqaDpZzBLIg5KOwt/4/RnHlN+8hB9w0
X-Proofpoint-GUID: sEqRnL_VftVhZiEQvPZCsBHnYdzwHFkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
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

>> Deprecate rte_dma_conf structure to allow for a more flexible=0A=
>> configuration of DMA devices.=0A=
>> The new structure will have a flags field instead of multiple=0A=
>> boolean fields for each feature.=0A=
>>=0A=
>> Signed-off-by: Pavan Nikhilesh <mailto:pbhagavatula@marvell.com>=0A=
>> ---=0A=
>> +* dmadev: The ``rte_dma_conf`` structure is updated to include a new fi=
eld=0A=
>> +  ``rte_dma_conf::flags`` that should be used to configure dmadev featu=
res.=0A=
>> +  The existing field ``rte_dma_conf::enable_silent`` is removed and rep=
laced=0A=
>> +  with the new flag ``RTE_DMA_CFG_FLAG_SILENT``, to configure silent mo=
de=0A=
>> +  the flag should be set in ``rte_dma_conf::flags`` during device confi=
guration.=0A=
>>=0A=
>> Acked-by: Amit Prakash Shukla <amitprakashs@marvell.com>=0A=
>=0A=
>There is only 1 ack.=0A=
>Per our policy, it will miss the release 25.07.=0A=
>=0A=
>You can probably do this change anyway,=0A=
>and keep ABI compatibility by versioning the function.=0A=
=0A=
Hi Fengchengwen,=0A=
=0A=
Are you ok with this change? If so please ack it so that I can work on gett=
ing=0A=
an exception from techboard to merge this without deprecation notice in 25.=
11.=0A=
=0A=
Thanks,=0A=
Pavan.=0A=
