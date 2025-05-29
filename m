Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD2C54FB3
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 05:20:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E7BD4021F;
	Thu, 29 May 2025 07:20:33 +0200 (CEST)
Received: from mx0a-00196b01.pphosted.com (mx0a-00196b01.pphosted.com
 [67.231.149.170])
 by mails.dpdk.org (Postfix) with ESMTP id 16E184003C
 for <dev@dpdk.org>; Thu, 29 May 2025 07:20:31 +0200 (CEST)
Received: from pps.filterd (m0072398.ppops.net [127.0.0.1])
 by mx0a-00196b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3j0QC031466
 for <dev@dpdk.org>; Thu, 29 May 2025 01:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscout.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 netscout.com.09.24.2020; bh=1OjWnzXzgtYLgJxgNSNGyq0qIlx0LLzGJ1hj
 2db7J/8=; b=m1Mz1pa6dZS+Gsp2YPzW6X2Hw07QdAHYVvWQBnnW8sgzOdoYVZ2P
 HQBwpwS1Gq7mlVHFbBkHufzWhnkk0ByvL+mFyT/Qph7eFIIgcB7gdxKzyYOOR+r/
 Lpn05S8dPEYzkyRzXz30b0UO3LUHdlqEfZwJwP2msnhxSD86Bl7EtOPH7Pfpao1L
 EP6w9fmtOzKJgYKtVvOtww8hnQlBsSwxHqvbqkf0W4LcSls2h9TSR0saYtP7MOvG
 4OjeL4dEjqPx7fjFj6vJCFKO9Xj8hmDdsSRWCwLB8eQE+w8YlC/klX0S99pyEWwu
 qETbYpDg7p3rQmdBGtkJk3B81MRHRHqdNg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0a-00196b01.pphosted.com (PPS) with ESMTPS id 46vxn9u7wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 29 May 2025 01:20:30 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQykCRrbML7B2fHywSFnLcVd7ftZ3rSklfgW7crrp4m/dJVi7r6DaD0UTRUkyfUMUdVq5+icxLPdy4PWnthpU8YYr7Zu79zHMg4cZZ66iYBQOTo1yyw8zoiXeX/LWdBqD9h9cisKOAxhbA3QNfR27mI+yYDzxgf2IT3JWf91eEibwlM0Bjz5TiijZwyuntNT02UCnnsCI53qvFBGjAmjdmnl91VgHlOxrs7bFLW6xYAZ6SZn6rj62KyuXEJNHwpdKHmLxkM/z4dE1vP/v4Ii96nXfVRRsYPiJUfXiaKmDQiNx+OxbucqGGZAUpodYZVHCAyNVpQa8eghFkhTl93aug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OjWnzXzgtYLgJxgNSNGyq0qIlx0LLzGJ1hj2db7J/8=;
 b=ZGmx7qvO9b/LJa9so91FwgAa6A3NgWjzXLWd51T4+bbgTaZEz9BXXSFKJa613sgK++U8lTSftTqhdSMUXyaFt3fnF1IG5YUsGGwTK26FGYYk5EqmTaImvO9l9OAUnl3TIy6ag4gKG80QY060cBKxwsB1QzJESoNT1oH3valJr6eFYD0uhvrOnp4EmiN7vQAJ/0Ceke1/4qJjLK3xitkYwlbsYn9YsMOUQkJUkt26LK33C+ovU2zBnEOepBpXF2xlfodOCDF4Iyxm3MBRr5hrSeW92anoi1s6OeCda2iO5nBWzJXKmVcKnYVjT8gatLQAlIxw9YJfNWf5Wh1LuyfDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netscout.com; dmarc=pass action=none header.from=netscout.com;
 dkim=pass header.d=netscout.com; arc=none
Received: from CH3PR01MB8470.prod.exchangelabs.com (2603:10b6:610:1a4::21) by
 PH0PR01MB6294.prod.exchangelabs.com (2603:10b6:510:18::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.25; Thu, 29 May 2025 05:20:26 +0000
Received: from CH3PR01MB8470.prod.exchangelabs.com
 ([fe80::80c4:7216:f070:e5fd]) by CH3PR01MB8470.prod.exchangelabs.com
 ([fe80::80c4:7216:f070:e5fd%6]) with mapi id 15.20.8769.021; Thu, 29 May 2025
 05:20:26 +0000
From: "Lombardo, Ed" <Ed.Lombardo@netscout.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: DPDK Ring Q
Thread-Topic: DPDK Ring Q
Thread-Index: AdvQFRwm5pqm4qOgS82mQnGr23sevA==
Date: Thu, 29 May 2025 05:20:25 +0000
Message-ID: <CH3PR01MB8470603D8C5E5DEE5BDB5EBB8F66A@CH3PR01MB8470.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR01MB8470:EE_|PH0PR01MB6294:EE_
x-ms-office365-filtering-correlation-id: 132eab04-64cc-444b-377e-08dd9e7084e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VHtwwFhHogWxKkpbTnjGDlyf+zW8N6JE14BzFALhUTVx1z29s+BGV2w5dZoS?=
 =?us-ascii?Q?TkKIfysnHaGqDAXdeLQtDZMJxl83rcEyaAGQtBj19yQESy9BdFZllX70bfEO?=
 =?us-ascii?Q?gT5/uNlYSz+iCbfmglQY4ShmNskxYE9HI6vF6hpkE27Pa6CcyvfsabmiZFqo?=
 =?us-ascii?Q?8pEQ/UnLbDpyoWpC6MMGLJQ84GmQciiV7kv9InCpf5vmbrjwNlxs0OFZH7FU?=
 =?us-ascii?Q?7APauVewlPKROrXMoyQxGICnkdmTgscV4GcXYsaTYCSUU2lH29lRzetWVnrv?=
 =?us-ascii?Q?UyQM/dnHRqoal7CbniNW9WVbhTJVnDAwSPB7LA2COAzGLULjy5zkrs017q4n?=
 =?us-ascii?Q?81Q2FH/QYDjrBtqsqZdu9PvllDzDQrQ0/BLQtlq4kSqf48rvycIqMXHKHJQF?=
 =?us-ascii?Q?kVy1hCSwSwMj9hesRh4f6R2QLACgApqHw9mcnvilt5lG3nGLd1oZ99j74hho?=
 =?us-ascii?Q?Jccz1isNemwx1DyCOKV39sGXZgURUeMPg7cpNUE5QT4zFkkga8JB+P90YSiG?=
 =?us-ascii?Q?9de+R0KpY13d44dsDQT7DgjFQJydwCDSB3iu/cbmIKaqXDWs5LTcXOQS2nd3?=
 =?us-ascii?Q?XzQaLPTiY5+PYn9V25MH39cmDPPRsaomGAHU97R2R6c56XAMgiJADhyDpHi+?=
 =?us-ascii?Q?5jmkhPj0OP1AJLKM50tjBew6+EfsEDGGvdGLfZ1j2c8R6ZortYvnosc5WtNk?=
 =?us-ascii?Q?Z1wnHmdj7/hC69asviHqjaVjqOUiAJ+YgH03UWd3lKMp8XfgjNaNyDGUl0ai?=
 =?us-ascii?Q?kyOSkhMgHwTJTSPoGRQ/GXS8Pq0pvY/qbLLEHuLE6sMWwJWNMcnCTBZIlUK2?=
 =?us-ascii?Q?3kiJOF22lPLvEilMY20UsJ87qftaKxIG+WPMA8j7zpqJePmaA/KbrVr/8rge?=
 =?us-ascii?Q?4FH6+yoHikUXzSqcIsGqCn/pm5/Q26lOSuvPnQX6x2NSKH3jLDO39HohUR5d?=
 =?us-ascii?Q?HiDvEjWtHjgshsFlljRfHjXG7S7aIJkTIstRPM49GuM7WdU5Dcwkq+o0z/fo?=
 =?us-ascii?Q?LklM/OKthhttDGd6M4WrfXpe5bdfZkE91oSyz3YUFdCM/089Oh/IEKh877sQ?=
 =?us-ascii?Q?qaXa9qnoFuDnafCDI3nB8IpT6i5kInAazmo6s3aRa72eYgATvoMf1/bc2Fiy?=
 =?us-ascii?Q?LiNAYg1ihRTpOYOm1AIGGxmJhSnKWchzUAUDTZI4MFxqqySp/1X2lwuLFDD0?=
 =?us-ascii?Q?UpVkRoYYlvgpHQavRW/3wbfDMSjmOvu96sIzPT8PFiYOAZVSAaLgJ/5zacP/?=
 =?us-ascii?Q?zRuyqdUY6w201ij7QXcM5pvkJwu0zV/iZSpZSrnaX5vj0eLEJ4cFDy3FNV8q?=
 =?us-ascii?Q?KXuRvqB0XQ75MgHC9kQGCsg1k25DdTAnjuIaWtGl67wAdRqSGLUHxC2HWr90?=
 =?us-ascii?Q?tWPTWkhtA2tfKznAexwgQOGpz3J27WeX/NjTsxmb4eKHpuBxqCfsEaZq+E2G?=
 =?us-ascii?Q?IrVOGrJdUT2GClM2LlUeMtjTnGnI/tyGhNbs647p1hpD5eIC8vewUg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR01MB8470.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L39uXDQULFZsdyX5hzMgvHv8AnUcv1l609Cz2slWP2R+q67vq7fKONhdFgbx?=
 =?us-ascii?Q?2IqQIw1Vz3dbUQsokdO6muQTs94jIkNDhpBT/e9Birxf38WPzU666iaxVlGJ?=
 =?us-ascii?Q?prnfd/pp+yK+XGVsKQsDh65khkt9CzEIfF1F6zCgAcqbXXJld8QmXDVXv39v?=
 =?us-ascii?Q?adsDw98hYo4gziVb51RPwSkS9PCIX0D45UetAVgKwD+de33hctenz5XLIq+3?=
 =?us-ascii?Q?7Fwc3AlUu5/YZFpriI8J6/CT6J0La53JV79Lpv0iKLcBJCgqQW4NqI1ORzW8?=
 =?us-ascii?Q?xn9w6eFZiG6JlxlZJjhuLe6mUW8RxoM4l8M7srijKzYpAAyLv9F2h5RhDtUK?=
 =?us-ascii?Q?VvypI4PZZnLrHCSY7NW23eAOfIZInio2nblzAopQojmALdVMfnUn6BZWJJ2g?=
 =?us-ascii?Q?9V1gDBDPMR61gOTRng5y4JFmrQ9Sam1/TMlOubd19GOBw0NwQ/b0fUXnBdF5?=
 =?us-ascii?Q?AxqENX0X4bnqXvDBlDtjYP6QRGZExQQqLGyddbtGq9gf8JKsqhYE4EI2i53f?=
 =?us-ascii?Q?fzCrY6torsaCFZ6K0S5Xx/FjMVqgZETXBESGXON71Ixe2Vslp2Tm4x5VXHUM?=
 =?us-ascii?Q?HcsFmsBF6YFMAcaecoXUYf05Ej0SVpGLYov8Swop2S1vZcadCwpzT1TR2+Eu?=
 =?us-ascii?Q?75CBOB5sX3B7cuxfnMlhvr9Ey7VfDHphT753/8MP9Y8S1OlGdL7R6GQubL2l?=
 =?us-ascii?Q?jdzYIvp1/AWp31W1yMrCJT4vxo/f28hENlw7ku155AMr98GgcsiaNI5hsJbE?=
 =?us-ascii?Q?1e+2CcXKCXutBe7CQxlwDYBit7jPtpDzOCRBT9oGd96Kcn5UM+9HDShMG/1g?=
 =?us-ascii?Q?+siIcy6NNuOENx8cGiMOYZICEVuo/GSyo+UXJz3xT2f3npXV/iZBj0NVkhHk?=
 =?us-ascii?Q?rHD7h7LG1xmrlFyAyGYxL212OePXKQOyKt0/OYVVyRGLwvB/RotzCa6wHI4T?=
 =?us-ascii?Q?7/HZLPth9y5tAwAPEr7Wb5sXOVjMVtJlydggWjeCyMYQYY4U0H8eh2h2+4cH?=
 =?us-ascii?Q?p2GL5AfQ2208xx1wqe9DDv/0SGFm/vNgj1eiMkKgOTETsTslpTKwkbZ1fn3P?=
 =?us-ascii?Q?egYU9mssWHyU3CXhhrhcq5I9NuBPrH70jzqGNy56XOP9MJkYhacB3DgEUNpG?=
 =?us-ascii?Q?UaJadt1y1DRd8ltHRM16icxuV4KMYWe/90ykdZbUOgM+sStcEdtKuu/J2YsS?=
 =?us-ascii?Q?Bv5Pyani4KdzhDA66tzrrblh93SXJCuJCaxjUF66LjylIQxDdGoswj3YI4YW?=
 =?us-ascii?Q?XuJbHXx8AmEg6HVtJowZ2QXRBuNLfy3IzyvmYOYJsb5y1IvHQziyif77vWsd?=
 =?us-ascii?Q?DFh3cWj13+FsRIPq5BGIe2RCkRnppZqAR97CWJM/D7teOh+26urJsJvhA/ol?=
 =?us-ascii?Q?q/zT1XN8qGGhFEp7nK1Aao66yWgQR9UFZrrIaTWpHfe2jYFBRhwefS2ctn7O?=
 =?us-ascii?Q?ZviYxfQgXHztqwe+JwHX+NPQW429jOG+4yLTK4L9/kEhgsoN0O+JM4CjiejB?=
 =?us-ascii?Q?uEG/ZMdr50ME0P5Ehf392prKKa1JP7zjxZFBBF50/IfCrM1K3dzx6rVA6HNp?=
 =?us-ascii?Q?8vkXH70E0109wFvIW4QatrMrBu8O/76luOvWJ8L+?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR01MB8470603D8C5E5DEE5BDB5EBB8F66ACH3PR01MB8470prod_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cEwJDezUlc0gATLhi2dZpvGq6JbRD4kLQgsIkCYSFjyKy0CR/4LDucwrW+CBVdSGSVjjgZ/DSsNpTfGTa5moiig+VRt9Y6PQDpX198MlUXOZOBuSFM7SGSBKE76xJ0cdgjYQmtq9qhdpzpe+hjv5cw2VWlOO7Ahn9RGOJAEvOYMMcneZMm5gv5K4F8TzzegvRppK4nsTiqNexymOxoh5L60m0OLosiItZ1ygwTRKXm/I05k3pYFxd5PetbQy8FFKIyhm+wCYIxzY9aptjCKZV6AFJ5uZp2xLHwrhw+OFERVhd82qXTJTILNT4Pks69vA35Fqv7w4oB37KU9BN0q4ILptMB2hHmSTInyQX9Y0un9L7O29yIXKeaNf/8QX+qUMuN47dqIUPAohKyWaztnuz0Pc/4F1bqgqxOqSgzzQVvEac5FFHEzrxBOn5M0aIqgSvYoIb2SWYeXQAayM90RAQnY084VPpR5kqxqtkZoZ9++UCH6+bdn9QYk88/nc0U0tfEL3sP1uxdv5Hs/AJMHuJ7YOuJpcylqBDC0gMdAL2cIbRI6ntfYGc2Tj70se1sclYJfov+10kZDkgEmFG85qVYXDvqOMtQz4EqWUuLaewxGtZnURRPMHrCOLPPR3nFa3
X-OriginatorOrg: netscout.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR01MB8470.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132eab04-64cc-444b-377e-08dd9e7084e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 05:20:25.9438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54f11205-d4aa-4809-bd36-0b542199c5b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAHJzPUe3Cp1TmNgNbxpvDWSHshbxH6TDFZwQixPIBPCcZymLbIXU9NV0flQUwEwM/njd6jwkgtJ4sdV/eYA9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6294
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA1MSBTYWx0ZWRfXzewNJs3Ebv0n
 w1Px0Fg/p2WR/TZGs4sy9JXKKPHScgdI3tEoUuM7X/ksCzo3SSxyiiE7mrXo45lOZsnorv6hCcn
 Rv4tU7+qw35RY93lBMpKDBpqLtPXMtrhKABr9EQEcNn9Y2ONaKWurROuKgvXOSzOsjEQhn7SK93
 jl4xQqtNOyxtORHWcBoZI0nj6K5tL00tkLYvaON4DD09Lvkz3MoKzv73PNrY0kXtYClYoXqKusI
 Ax8vDdT/TCr+3MBK3yi1Du+8+R4Ogum8s1sS+1J7zRDxIV0wpzY+D/H5mI0fSIdH4Rhti01UNzs
 /SzTjLB5Jh8k36vLRHYDpBoBz808xdfn+Lz+mf+n10T81643PZMkTQsWzs6zmoUaVodEK5k4L4w
 +4Iu/4N89B2Suq5vccfvdJIzBuBUYziyWK5P4FpEwh6Wz7lgLdPx/nKOHnvFbwIVovVfkje7
X-Proofpoint-GUID: wIzxFlbHYOQhgWEcmmr0_9JljufO5-k0
X-Authority-Analysis: v=2.4 cv=KMJaDEFo c=1 sm=1 tr=0 ts=6837ee9e cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=R2u7ubPiGj4RsqpscTMA:9 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8
 a=FZ8bo8YZ5DZCJjzRWqAA:9 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10
 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10 cc=ntf
X-Proofpoint-ORIG-GUID: wIzxFlbHYOQhgWEcmmr0_9JljufO5-k0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy
 score=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=974 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505290051
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

--_000_CH3PR01MB8470603D8C5E5DEE5BDB5EBB8F66ACH3PR01MB8470prod_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I have an issue with DPDK 24.11.1 and 2 port 100G Intel NIC (E810-C) on 22 =
core CPU dual socket server.

There is a dedicated CPU core to get the packets from DPDK using rte_eth_rx=
_burst() and enqueue the mbufs into a worker ring Q.  This thread does noth=
ing else.  The NIC is dropping packets at 8.5 Gbps per port.

Studying the perf report, I was interested in the common_ring_mc_dequeue().=
  Perf tool shows common_ring_mc_dequeue() 92.86% Self and 92.86% Children.

I see further with perf tool rte_ring_enqueue_bulk() and rte_ring_enqueue_b=
ulk_elem().  These are at 0.00% Self and 0.05% Children.
Perf tool shows rte_ring_sp_enqueue_bulk_elem (inlined) which is what I wan=
ted to see (Single producer) representing the enqueue of the mbufs pointers=
 to the worker ring Q.

Is it possible to change the common_ring_mc_dequeue() to common_ring_sc_deq=
ueue()?  Can it be set to one consumer on single Queue 0.

I believe this is limiting DPDK from reaching 90 Gbps or higher in my setup=
, which is my goal.

I made sure the E810-C firmware was up to date, NIC FW Version: 4.80 0x8002=
0543 1.3805.0

Perf report shows:
   - 99.65% input_thread
      - 99.35% rte_eth_rx_burst (inlined)
         - ice_recv_scattered_pkts
              92.83% common_ring_mc_dequeue

Any thoughts or suggestions?

Thanks,
Ed

--_000_CH3PR01MB8470603D8C5E5DEE5BDB5EBB8F66ACH3PR01MB8470prod_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal">I have an issue with DPDK 24.11.1 and 2 port 100G In=
tel NIC (E810-C) on 22 core CPU dual socket server.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">There is a dedicated CPU core to get the packets fro=
m DPDK using rte_eth_rx_burst() and enqueue the mbufs into a worker ring Q.=
&nbsp; This thread does nothing else.&nbsp; The NIC is dropping packets at =
8.5 Gbps per port.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Studying the perf report, I was interested in the co=
mmon_ring_mc_dequeue().&nbsp; Perf tool shows common_ring_mc_dequeue() 92.8=
6% Self and 92.86% Children.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I see further with perf tool rte_ring_enqueue_bulk()=
 and rte_ring_enqueue_bulk_elem(). &nbsp;These are at 0.00% Self and 0.05% =
Children.
<o:p></o:p></p>
<p class=3D"MsoNormal">Perf tool shows rte_ring_sp_enqueue_bulk_elem (inlin=
ed) which is what I wanted to see (Single producer) representing the enqueu=
e of the mbufs pointers to the worker ring Q.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is it possible to change the common_ring_mc_dequeue(=
) to common_ring_sc_dequeue()?&nbsp; Can it be set to one consumer on singl=
e Queue 0.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I believe this is limiting DPDK from reaching 90 Gbp=
s or higher in my setup, which is my goal.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I made sure the E810-C firmware was up to date, NIC =
FW Version: 4.80 0x80020543 1.3805.0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Perf report shows:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp; - 99.65% input_thread&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 99.35% rte_eth=
_rx_burst (inlined)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;- ice_recv_scattered_pkts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;92.83% common_ring_mc_dequeue&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any thoughts or suggestions?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Ed<o:p></o:p></p>
</div>
</body>
</html>

--_000_CH3PR01MB8470603D8C5E5DEE5BDB5EBB8F66ACH3PR01MB8470prod_--
