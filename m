Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178DF46445
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:14:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 444BA4025E;
	Mon, 16 Mar 2026 11:14:58 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id BBCCC400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:14:56 +0100 (CET)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G227xd2555685; Mon, 16 Mar 2026 06:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=j
 H2AqSKGSoX0AwGM0RDK2FFZRJ5KIn5HtX3Lr4ySOGE=; b=cbeQDM0BJZsF9yuSt
 Jjfu9IUOZV1xIdpkgR0sEWZvVxFPNiN463+qc5Ibh3BQgb8Xz0RZMmHlH4epNjpr
 df1IAj6n/OVvL2IiJDoFMwV7ooXcZvhVPPT1qHHzQRtTWuutL9/6FBlzq66uDOsw
 ikRITuK6PQtu0wQBmrtMV/GRVlY0hNCU8Agf5Jljr2RffXVUbWamr1j2GNcRGje5
 Muv5LgmxwQXwkL/9Crp9mPNVbLwra1KT7l3NpL5RInbmsUJTXPZevykXFiVA0Q4K
 JkB1puR9mEr4dOEeZ5ZuwpZ24P4pKElLMixDTJ0sCHFcNppdinM/d5TBXQFA48kw
 fzDDA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4cw2u95qef-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 06:14:55 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G8miX61421087; Mon, 16 Mar 2026 06:14:54 -0400
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4cxe1n1cf5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 06:14:54 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEVGIug+Ei41uTttO18MTPlYoT4G9rSt8/+L5eUL776FJZZ2C5EV2VsSwpginT/LJ8+t6YnPsKGO0f46ML7rha0MYGWQqiG8ihdyTCSd8ZUIDXJzsavC5sDGJmSQX+x5YYtBvT1nIvpqJpbd9vPP3AQdJNKH1ngSm5Fcpvn80JwsPtXGvW2UcEeDMxvjLV2fw4DYIvgkcKHt3QwdMbl6NLazKAGLAvPfKlwExEfttf+galCSoiXTm/MGBaTlcRHZld54iJWCxIk6kSjkDiGAJOfiO0NDDsCIEzaYk0SR5Hdjmt3MzBVghGNm0qphrIzk6Ds5TrSFCFVuvm++9+nrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jH2AqSKGSoX0AwGM0RDK2FFZRJ5KIn5HtX3Lr4ySOGE=;
 b=RJ6qcQiRc3hCi2Ri6hOpo3RfRbYjmlEZKb0qHHr1BzuMh+E1mfE6v6MMsu0y6jn/wdRB/duMRdxlgeD1Ju7P2k8UuYCPKoAixsGe/ZTzvsmxVTZ/3Jrwapdon+3deq8Et5MmgwsVy2Uz4wLM/mw4TskDSwKJ1taS846g1SPgVLAog0qktwLy6XFH6ZkVQW75sTCPKMiiNTPWoufduITPxU6xvhc+4xHql9+R8fkTlqfYFx31Mpfx2jwCuPcYRW9nGiUFV/hbaCc/8BwAbC600NAVx6YFt3R6axerpq7LYBWzG38gi2m/oP2AUoKGPU7taJPBzR+Q/Y6v4ghH5P8AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by IA0PR19MB8132.namprd19.prod.outlook.com (2603:10b6:208:487::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 10:14:50 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 10:14:49 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
Subject: RE: [PATCH v6 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Topic: [PATCH v6 4/5] vhost_user: Function defs for add/rem mem regions
Thread-Index: AQHci3OTfavL55cpn0GxBxzt32qlHbVk5SyAgBh9shCAHz/FIIAUoIyg
Date: Mon, 16 Mar 2026 10:14:48 +0000
Message-ID: <DM6PR19MB35645A8A062F21964F9789A1F540A@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260122074906.127942-1-pravin.bathija@dell.com>
 <20260122074906.127942-5-pravin.bathija@dell.com>
 <CAO55csy0oikG_HxUeqnU7tMvg+mjCdXP3uEUq7vUNsx8DgBGNw@mail.gmail.com>
 <DM6PR19MB3564F2D3D5466B57EE018658F563A@DM6PR19MB3564.namprd19.prod.outlook.com>
 <DM6PR19MB35649A4D0C34D34853EEC9E9F57FA@DM6PR19MB3564.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB35649A4D0C34D34853EEC9E9F57FA@DM6PR19MB3564.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-02-11T09:57:51.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|IA0PR19MB8132:EE_
x-ms-office365-filtering-correlation-id: dedbd14b-935d-434e-ea1d-08de8344db1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|786006|366016|38070700021|18002099003|56012099003|22082099003|20052099010;
x-microsoft-antispam-message-info: VDO3pGEb+HORfbTJyYC3RwIxQ2giVclwxtg/phldX1a4SSUxEwWdCVJU7sVlxbbG0nG23byg/y/6cN27uRs6++n1UUSKKMKAx7XmyEhnjFDfmJlRrIgAOnmc3334RUv11cyL8r4orpisJO+tqdke3PS3ebpMJ5A1xD7nsUgDlnLg5ATRqNWF4mR53SwLD3e21xnwHGNh6+4AiGxe/Vf6cYK2IOhlQR5lTgYu6sLuvZg0M3HANDuUJ2Ra+YCY626uy4REHPIZImPnWu+Q5XYljZEWyA+kpPH2Yt4xZAqm0JPQsiyk7B8nB0dQKVbmktuc6xchHrjXVOsEVp1IX8C8ftfka5mtHoKpxbN1o5LI7gW5hJJQSY1dSOUMkDcM64d5AXy+Q3N2Zs6gEkETa0UU3almIh4EuT8LD2RX/zm1tv0+WLdIOlbtwVK2MhyRMnMqWtpQ0vkB8FLvi2ChGjNfjtezid0bPeMOLST2aNnnEelb8l1qD1N33UCjLNox6wggvFRpQEzJ8GbsGwXC58wHtIEPZ1tnBlLdv8qu3aanConSA/3S3eGpN9Xu/KcbmRLiKS+s+FzfhWRFk9WgACLFDX0QRkzwq+STDqQp2O6n7rrCFtKOi+gpOxbgzmJ9de1NGQgrZRDGGIzA2H/0YKTghnBhzZiP6IHmS7R7DF2KLJp8rFQB0kSqqEV4gbiJFUD06ILm6LuMGgupZl76g0AGlrW9a6dNqm9eNtAQ/SMukvfzK0Af1rUeFrgnmfxz9t8jDuNAb/9uVC8AMGv8jIOu1hUt9++9dm6UxeOJWYh1lrM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(786006)(366016)(38070700021)(18002099003)(56012099003)(22082099003)(20052099010);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-7?B?aVg1MTY5Q1FtSGdPczZJMzhCZDVkOXlkT0xKaGo1RGRSdmk2RWE5WEF0OVZU?=
 =?utf-7?B?RmpmY3dSOWF6YXlyMDVyN1F6S0M3eGVuYVd5QzFJUlpzdnBqY1VUbXZ5UDZh?=
 =?utf-7?B?RllPTkpNZVlhbWdyVkZIMnJDYVM4MEdRZXRPMDJTZ0Jpc1JlWDZPaFVyUmxr?=
 =?utf-7?B?UXdxY0RlUFZXZUdqMjM2Wk1YNG5JTXdkQVR5ZXI5dFNGTDA3bUVXVWZ2L0lK?=
 =?utf-7?B?ckNkUTRBZDJ2Ky1lY0RZR2FFMzNsZ1V0aEZUYzE4QkM3TkJmWVhrSzIxb1VB?=
 =?utf-7?B?T2pNbzlMdmQrLXBtRlVZSUNIM2ExS1JqNVdySWlIZVJncWI0RlYwa1ljRThx?=
 =?utf-7?B?T0t0YnhSa3RkbTJ6T3BUejlUOHczc0NLemlpQTBoaGlLNDE5Wjc3bDlkc2hw?=
 =?utf-7?B?cDVhUG9TRGp0ZDVpNjRzS1ZoeEY1cDNtL201Njd1dzRSKy1YUHFrS1lsKy1Z?=
 =?utf-7?B?OE51TkJNaUJFYmdod3Rxckt4ZkwyS3lVTXBUZ2tNbDVKWFpJSEFRYmUrLTVH?=
 =?utf-7?B?NWJyWVVTR2NJWGZpcW9NQXNnQ3pNeEpBNjArLTRKWC9IYm9IQ2tDMFZ6UXpB?=
 =?utf-7?B?OXUyckwrLXlpMHFyTzJLWGF4ejZ2R2Y4cTBSN0pLWW52OXNBL3pWUEIxQ3Zk?=
 =?utf-7?B?TkRrWlpPd2EvVkxyckVKbmFyUjZwKy1Ec1hEd2dxcmVzaDhYWUJ6SUJ2Vk54?=
 =?utf-7?B?aEhFem9wY1JIRVFFNTN5NystcExkKy1EWFlBTThuMTJKbnFxMlRldFQ3L2VF?=
 =?utf-7?B?Y1hPcVErLWorLVhWeGtWNzRKUTZ3QmNkMnJNVWF3OEc2M0g4OGJXN3RNRGdX?=
 =?utf-7?B?U21HOS9ISWR4Q3lZa1BjZjFQdjQvZkFENnQ1NEhvSGJxR0VlTFRSWU5WdzFk?=
 =?utf-7?B?MlEzVkxUaTV6Ky1ST1hzbVlERUJ2UWdVc0hOOXg1ZmRTbUh5c2kyY3NqaEh2?=
 =?utf-7?B?WkN6bndNUGpIWEQ0eGxKQ3I1MHJlcHZwOWQ0T1JxMThQMWI5WnE4OXJrelVV?=
 =?utf-7?B?b2pLOW5ZTTNxKy1MNThnbTBIbW5wQjlaUnYrLTZuUCstcHorLXNqS0s5MDhD?=
 =?utf-7?B?ZHZLZngrLXVzS21GODhFT1E0U2JFKy03eSstcEZIakpPU3BKQzFsMm13RVA=?=
 =?utf-7?B?TlhrKy03VHZrd2oxelpKNk1jMDM0dWF6amFOKy05RlJaaDZiZHg2QkducWdh?=
 =?utf-7?B?dWZDZFp3R2VaaWtmdVZ4WG5EdGlTcVRmVVpOZ3VXdGJoTmJjakxlNWNWY1Fn?=
 =?utf-7?B?MFdTUGVsWjNIUEl4T3lqd0tKU0JWcjVqM3V3MXdtdlNlOERmbDZuL0FtaDB2?=
 =?utf-7?B?ZG95NEt1LystWHN1OEIxallsWFF6YlBuSy9mT0FleGViWUtvaDQ1MXduY2xT?=
 =?utf-7?B?ZHhHZVNKWFhlSEVTWnJZMXlPSGNKSENsTUltcW5YUVRrbUFpaDFDOTRPc01P?=
 =?utf-7?B?bzZYd2NOVTM1RmZROWxxd1E3M1d6OVVBQnNEWTZiNjI4d01USFNwc0ZkeHNr?=
 =?utf-7?B?VWVCQnh0aUU0NGpZZzdrSm9oRU5BdkQrLW9wcWFzUDhhazdoMVMxRXB4OFo=?=
 =?utf-7?B?cistSUVkaUNjZjhXVmV4M3h6YzVNa1g0YmVqU3QzRWg0amdiUHpNaERYVmlx?=
 =?utf-7?B?TjF0UFFTSXNvTFBGSnFBbVo4L1BaRDhKNUZtdU9BT2cyd1daMUV3OXVXandO?=
 =?utf-7?B?S2dKTExPWjlqQ0RUSzRxc25vN0hnc0V4R2pLQjBpTms2U1VRTG51a3B3b1Jj?=
 =?utf-7?B?ZFVqbXIrLVdiNGZwKy02L1Q1QistTjJsVHBtNk1YMDZydWdIUHFGMWZTeist?=
 =?utf-7?B?UVBsL25IOThkOG1VKy1mOVhyamhKQmJEcGc4Znl2WWwwU09UbUlNMzc4YVh6?=
 =?utf-7?B?L0FjTy9jYzVSMUhlckJrKy1QSUtvRWxKZ1F3NU1zNFBxMWlDdkF1d3RVYUtI?=
 =?utf-7?B?Mjh2bmJtRE5ZQ3dZUnZUYjI5RXkyamtHTW1OaE1IVER0cDVpcU9HTnZHNEs3?=
 =?utf-7?B?M1lkQkltL3d3ejBqSE9NMTROU0NNdk9vNTBmRVFvbnJuSGhsKy1MRk5BS2ty?=
 =?utf-7?B?Q1AyQ3R6VUVRcG5qczlIOWQ1SS9qbUFFOHYyNGNJQWt3YndleGFDTTl1Sy9P?=
 =?utf-7?B?VWp1bFRsWUVkc2pKQXNLb2dFMWlBOSstcXAvZ0pQdWNJRi9Kc2NoQVpXQ0pF?=
 =?utf-7?B?eTN3QUpkcVFEaDdEYmlnVVFkQUc1Nmk2WVYwRGpGSURNSExhN2M1bTVEWVhy?=
 =?utf-7?B?WmVwWFJBcmM5L3FBMnRid1hRcms2aDVjY1pQQU81WHBMamRzOHZFcms0SC93?=
 =?utf-7?B?UDE5YkdJRG4rLUltVHNPVnkzV3dvU0Y4aVV4a0puYWFpT29Rc2RRL0J3R0RJ?=
 =?utf-7?B?dGh0R2p1Mll2UTAzY2Q3V0pRcC9oaHhuZ0NUSWU2ZytBRDBBUFEt?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YD66CRheIqOXmgUl9nv9anTyUN5skTgJGjYPhOY+7dnqu3VbNmmw+uaEK+xK2Gg3z/H8j0WbKOPC2E2W3jhC1qblBhRRKRiqoQ5Qq/FuU38J14G+52RYmbKnZH2NeRmMlyYVC4O2iTWe3wHKDkuL/B+1/rOTCGe5BagWmdZBA0ryKWmPa8tA2JzhKSVW5zZP3zNdilzRDSQXDqQYpqWgwww/r/CYg9ULvTyvReaK4NGkbfK8DNpXFBS427nXYIUJTl3tmO7AljXofmLqfNcnNBVLWnZj+NlD2PELaC9fpg5YK4fCqg3HExrm9p+0fAzrIhhudJQZAQwYOmoqtr8Dyg==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedbd14b-935d-434e-ea1d-08de8344db1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 10:14:48.9961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWO4d3z0Dij9tfZnPBbJ/GAQJun/vzYykEyzxaWc6CoF0LJbvvjPt12bGB6yAn66XGXWm+QWt/3fP/BQse2oxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB8132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3OCBTYWx0ZWRfXyJ3yvtuG2uDk
 L//8+HRsN9eQ87hqAw9/Rv2OGobCKTq5irmrhkwN2Gj659oMTyXnE9ZRSv6HAaJA6eP93bJikCk
 +i2kiibyGkSCNTXaqzTaziYa1uDbe+jj7GYvjcbV1jFKy4Khowzmmopgc10xXN/WNFn5U19DimL
 ozY70VNTCwMV30cnAWfxOCplfT+xOcs0FqlUToXzfEnAYs5owivF3Hoja9LIfHPQ2aWj1aCrJcv
 15wZTb5xejhQvVdtqt5P/KcAxLokQVm6zMB5tagKJ+0+TP6cO8AfMcJ+39tb4LHnfiuD5rj/Vt+
 +gpsLi33uXcy/zY/lsX4D/Zv1mZn3P1RdcM5d2BRqYOxpBxviBYImoO53pfwCaumPRC/NXv8HaL
 8ZiB1RhIiQNhgaXj7pL0nP+q45Apk7s2tpTvdoysvpurlXPUl7vBiAg4FoRbdZ1eK4vHmdA1Exu
 p+QpyHj4k6J3hFcEONQ==
X-Authority-Analysis: v=2.4 cv=PouergM3 c=1 sm=1 tr=0 ts=69b7d81f cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10
 a=YU3QZWNX-B8A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=m3zZTHMLHbwB7Lmtoed2:22 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8 a=iLNU1ar6AAAA:8 a=XlRjxQ70AAAA:8
 a=eSb-bNSJAAAA:8 a=ytFMdNZ7AAAA:8 a=LfxEVeEBAAAA:8 a=U6VyxppInbH8QvZ3naoA:9
 a=avxi3fN6y70A:10 a=hlJyneSgMmFPbskH-t2w:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=1uMOUU2w0DxzEe95gQqD:22 a=h7YW-pclpbZRD8svLbQ0:22 a=oxySFUAvEW1-6AXleBSr:22
 a=7k9nRlTqVbDGZ3p5_T00:22
X-Proofpoint-GUID: AdBUV58gqsdTNBiLe436K6k5Mp5x2MkP
X-Proofpoint-ORIG-GUID: AdBUV58gqsdTNBiLe436K6k5Mp5x2MkP
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160078
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

Hi Maxime,

I wanted to follow up if you got a chance to review my updated patch-set v7=
 and the clarifications to your earlier message. I successfully reran the p=
ost-copy live migration tests with qemu and dpdk-testpmd.

Happy to answer any other queries you might have.

Regards,
Pravin


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Bathija, Pravin
+AD4- Sent: Monday, March 2, 2026 11:11 PM
+AD4- To: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- Cc: dev+AEA-dpdk.org+ADs- fengchengwen+AEA-huawei.com
+AD4- Subject: RE: +AFs-PATCH v6 4/5+AF0- vhost+AF8-user: Function defs for=
 add/rem mem
+AD4- regions
+AD4-
+AD4- Dear Maxime,
+AD4-
+AD4- Any feedback on the latest patch v7 I submitted earlier ?
+AD4-
+AD4- Thanks,
+AD4- Pravin
+AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Bathija, Pravin
+AD4- +AD4- Sent: Wednesday, February 11, 2026 2:20 AM
+AD4- +AD4- To: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com+AD4-
+AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- fengchengwen+AEA-huawei.com
+AD4- +AD4- Subject: RE: +AFs-PATCH v6 4/5+AF0- vhost+AF8-user: Function de=
fs for add/rem mem
+AD4- +AD4- regions
+AD4- +AD4-
+AD4- +AD4- Dear Maxime,
+AD4- +AD4-
+AD4- +AD4- Answers inline.
+AD4- +AD4-
+AD4- +AD4- +AD4- -----Original Message-----
+AD4- +AD4- +AD4- From: Maxime Coquelin +ADw-maxime.coquelin+AEA-redhat.com=
+AD4-
+AD4- +AD4- +AD4- Sent: Monday, January 26, 2026 11:58 AM
+AD4- +AD4- +AD4- To: Bathija, Pravin +ADw-Pravin.Bathija+AEA-dell.com+AD4-
+AD4- +AD4- +AD4- Cc: dev+AEA-dpdk.org+ADs- fengchengwen+AEA-huawei.com
+AD4- +AD4- +AD4- Subject: Re: +AFs-PATCH v6 4/5+AF0- vhost+AF8-user: Funct=
ion defs for add/rem
+AD4- +AD4- +AD4- mem regions
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- On Thu, Jan 22, 2026 at 8:49+IC8-AM +ADw-pravin.bathija+A=
EA-dell.com+AD4- wrote:
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- From: Pravin M Bathija +ADw-pravin.bathija+AEA-dell=
.com+AD4-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- These changes cover the function definition for add=
/remove memory
+AD4- +AD4- +AD4- +AD4- region calls which are invoked on receiving vhost u=
ser message
+AD4- +AD4- +AD4- +AD4- from vhost user front-end (e.g. Qemu). In our case,=
 in addition to
+AD4- +AD4- +AD4- +AD4- testing with qemu front-end, the testing has also b=
een performed
+AD4- +AD4- +AD4- +AD4- with libblkio front-end and spdk/dpdk back-end. We =
did I/O using
+AD4- +AD4- +AD4- +AD4- libblkio based device driver, to spdk based drives.=
 There are also
+AD4- +AD4- +AD4- +AD4- changes for set+AF8-mem+AF8-table and new definitio=
n for get memory slots.
+AD4- +AD4- +AD4- +AD4- Our changes optimize the set memory table call to u=
se common
+AD4- +AD4- +AD4- +AD4- support
+AD4- +AD4- functions.
+AD4- +AD4- +AD4- +AD4- Message get memory slots is how the vhost-user fron=
t-end queries
+AD4- +AD4- +AD4- +AD4- the vhost-user back-end about the number of memory =
slots available
+AD4- +AD4- +AD4- +AD4- to be registered by the back-end. In addition suppo=
rt function to
+AD4- +AD4- +AD4- +AD4- invalidate vring is also defined which is used in a=
dd/remove
+AD4- +AD4- +AD4- +AD4- memory region
+AD4- +AD4- functions.
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- Signed-off-by: Pravin M Bathija +ADw-pravin.bathija=
+AEA-dell.com+AD4-
+AD4- +AD4- +AD4- +AD4- ---
+AD4- +AD4- +AD4- +AD4-  lib/vhost/vhost+AF8-user.c +AHw- 234
+AD4- +AD4- +AD4- +AD4- +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-------
+AD4- +AD4- +AD4- +AD4-  1 file changed, 202 insertions(+-), 32 deletions(-=
)
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- diff --git a/lib/vhost/vhost+AF8-user.c b/lib/vhost=
/vhost+AF8-user.c index
+AD4- +AD4- +AD4- +AD4- e2831b7625..1a2dcfbbca 100644
+AD4- +AD4- +AD4- +AD4- --- a/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AD4- +AD4- +-+-+- b/lib/vhost/vhost+AF8-user.c
+AD4- +AD4- +AD4- +AD4- +AEAAQA- -71,6 +-71,9 +AEAAQA-
+AD4- +AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-=
FEATURES,
+AD4- +AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-features, false, t
+AD4- +AD4- +AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SE=
T+AF8-OWNER,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-owner,
+AD4- +AD4- +AD4- +AD4- false, true) +AFw-  VHOST+AF8-MESSAGE+AF8-HANDLER(V=
HOST+AF8-USER+AF8-RESET+AF8-OWNER,
+AD4- +AD4- +AD4- +AD4- vhost+AF8-user+AF8-reset+AF8-owner, false, false) +=
AFw-
+AD4- +AD4- +AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SE=
T+AF8-MEM+AF8-TABLE,
+AD4- +AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table, true, tru=
e) +AFw-
+AD4- +AD4- +AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-=
GET+AF8-MAX+AF8-MEM+AF8-SLOTS,
+AD4- +AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots,=
 false, false) +AFw-
+AD4- +AD4- +AD4- +AD4- +-VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-=
ADD+AF8-MEM+AF8-REG,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-add+AF8-mem+AF8-reg,
+AD4- +AD4- +AD4- +AD4- +-true, true) +AFw-
+AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-REM+AF8-MEM+AF8-REG,
+AD4- +AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg, false, tr=
ue) +AFw-
+AD4- +AD4- +AD4- +AD4-  VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-S=
ET+AF8-LOG+AF8-BASE,
+AD4- +AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-base, true, true=
) +AFw-
+AD4- +AD4- +AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SE=
T+AF8-LOG+AF8-FD,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-log+AF8-fd,
+AD4- +AD4- +AD4- +AD4- true, true) +AFw-
+AD4- +AD4- VHOST+AF8-MESSAGE+AF8-HANDLER(VHOST+AF8-USER+AF8-SET+AF8-VRING+=
AF8-NUM,
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-vring+AF8-num, false, true) +A=
Fw- +AEAAQA- -1520,7 +-1523,6 +AEAAQA-
+AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct virtio+AF=
8-net +ACoAKg-pdev,
+AD4- +AD4- +AD4- +AD4-         struct virtio+AF8-net +ACo-dev +AD0- +ACo-p=
dev+ADs-
+AD4- +AD4- +AD4- +AD4-         struct VhostUserMemory +ACo-memory +AD0- +A=
CY-ctx-+AD4-msg.payload.memory+ADs-
+AD4- +AD4- +AD4- +AD4-         struct rte+AF8-vhost+AF8-mem+AF8-region +AC=
o-reg+ADs-
+AD4- +AD4- +AD4- +AD4- -       int numa+AF8-node +AD0- SOCKET+AF8-ID+AF8-A=
NY+ADs-
+AD4- +AD4- +AD4- +AD4-         uint64+AF8-t mmap+AF8-offset+ADs-
+AD4- +AD4- +AD4- +AD4-         uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4- +AD4-         bool async+AF8-notify +AD0- false+ADs- +AEA=
AQA- -1565,39 +-1567,13 +AEAAQA-
+AD4- +AD4- +AD4- +AD4- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(struct vir=
tio+AF8-net
+AD4- +AD4- +AD4- +ACoAKg-pdev,
+AD4- +AD4- +AD4- +AD4-                 if (dev-+AD4-features +ACY- (1ULL +=
ADwAPA- VIRTIO+AF8-F+AF8-IOMMU+AF8-PLATFORM))
+AD4- +AD4- +AD4- +AD4-                         vhost+AF8-user+AF8-iotlb+AF=
8-flush+AF8-all(dev)+ADs-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- -               free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +AD4- +AD4- +-               free+AF8-all+AF8-mem+AF8-regions(d=
ev)+ADs-
+AD4- +AD4- +AD4- +AD4-                 rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +AD4- +AD4-                 dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +AD4-         +AH0-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- -       /+ACo-
+AD4- +AD4- +AD4- +AD4- -        +ACo- If VQ 0 has already been allocated, =
try to allocate on the same
+AD4- +AD4- +AD4- +AD4- -        +ACo- NUMA node. It can be reallocated lat=
er in numa+AF8-realloc().
+AD4- +AD4- +AD4- +AD4- -        +ACo-/
+AD4- +AD4- +AD4- +AD4- -       if (dev-+AD4-nr+AF8-vring +AD4- 0)
+AD4- +AD4- +AD4- +AD4- -               numa+AF8-node +AD0- dev-+AD4-virtqu=
eue+AFs-0+AF0--+AD4-numa+AF8-node+ADs-
+AD4- +AD4- +AD4- +AD4- -
+AD4- +AD4- +AD4- +AD4- -       dev-+AD4-nr+AF8-guest+AF8-pages +AD0- 0+ADs=
-
+AD4- +AD4- +AD4- +AD4- -       if (dev-+AD4-guest+AF8-pages +AD0APQ- NULL)=
 +AHs-
+AD4- +AD4- +AD4- +AD4- -               dev-+AD4-max+AF8-guest+AF8-pages +A=
D0- 8+ADs-
+AD4- +AD4- +AD4- +AD4- -               dev-+AD4-guest+AF8-pages +AD0- rte+=
AF8-zmalloc+AF8-socket(NULL,
+AD4- +AD4- +AD4- +AD4- -                                       dev-+AD4-ma=
x+AF8-guest+AF8-pages +ACo-
+AD4- +AD4- +AD4- +AD4- -                                       sizeof(stru=
ct guest+AF8-page),
+AD4- +AD4- +AD4- +AD4- -                                       RTE+AF8-CAC=
HE+AF8-LINE+AF8-SIZE,
+AD4- +AD4- +AD4- +AD4- -                                       numa+AF8-no=
de)+ADs-
+AD4- +AD4- +AD4- +AD4- -               if (dev-+AD4-guest+AF8-pages +AD0AP=
Q- NULL) +AHs-
+AD4- +AD4- +AD4- +AD4- -                       VHOST+AF8-CONFIG+AF8-LOG(de=
v-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +AD4- -                               +ACI-failed to allo=
cate memory for dev-+AD4-guest+AF8-pages+ACI-)+ADs-
+AD4- +AD4- +AD4- +AD4- -                       goto close+AF8-msg+AF8-fds+=
ADs-
+AD4- +AD4- +AD4- +AD4- -               +AH0-
+AD4- +AD4- +AD4- +AD4- -       +AH0-
+AD4- +AD4- +AD4- +AD4- -
+AD4- +AD4- +AD4- +AD4- -       dev-+AD4-mem +AD0- rte+AF8-zmalloc+AF8-sock=
et(+ACI-vhost-mem-table+ACI-, sizeof(struct
+AD4- +AD4- +AD4- rte+AF8-vhost+AF8-memory) +-
+AD4- +AD4- +AD4- +AD4- -               sizeof(struct rte+AF8-vhost+AF8-mem=
+AF8-region) +ACo- memory-+AD4-nregions, 0,
+AD4- +AD4- +AD4- numa+AF8-node)+ADs-
+AD4- +AD4- +AD4- +AD4- -       if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +AD4- +AD4- -               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-i=
fname, ERR, +ACI-failed to allocate
+AD4- +AD4- memory
+AD4- +AD4- +AD4- for dev-+AD4-mem+ACI-)+ADs-
+AD4- +AD4- +AD4- +AD4- -               goto free+AF8-guest+AF8-pages+ADs-
+AD4- +AD4- +AD4- +AD4- -       +AH0-
+AD4- +AD4- +AD4- +AD4- +-       if (vhost+AF8-user+AF8-initialize+AF8-memo=
ry(pdev) +ADw- 0)
+AD4- +AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4-         for (i +AD0- 0+ADs- i +ADw- memory-+AD4-nre=
gions+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +AD4-                 reg +AD0- +ACY-dev-+AD4-mem-+AD4-re=
gions+AFs-i+AF0AOw- +AEAAQA- -1661,11 +-1637,167
+AD4- +AD4- +AD4- +AD4- +AEAAQA- vhost+AF8-user+AF8-set+AF8-mem+AF8-table(s=
truct virtio+AF8-net +ACoAKg-pdev,
+AD4- +AD4- +AD4- +AD4-         return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8=
-OK+ADs-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4-  free+AF8-mem+AF8-table:
+AD4- +AD4- +AD4- +AD4- -       free+AF8-mem+AF8-region(dev)+ADs-
+AD4- +AD4- +AD4- +AD4- +-       free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4- +AD4- +AD4-         rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +AD4- +AD4-         dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +AD4- +-       rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs=
-
+AD4- +AD4- +AD4- +AD4- +-       dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +AD4- +-close+AF8-msg+AF8-fds:
+AD4- +AD4- +AD4- +AD4- +-       close+AF8-msg+AF8-fds(ctx)+ADs-
+AD4- +AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF=
8-ERR+ADs- +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-static int
+AD4- +AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-get+AF8-max+AF8-mem+AF8-slots(=
struct virtio+AF8-net +ACoAKg-pdev
+AD4- +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-con=
text +ACo-ctx,
+AD4- +AD4- +AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rt=
e+AF8-unused) +AHs-
+AD4- +AD4- +AD4- +AD4- +-       uint32+AF8-t max+AF8-mem+AF8-slots +AD0- V=
HOST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       ctx-+AD4-msg.payload.u64 +AD0- (uint64+AF8=
-t)max+AF8-mem+AF8-slots+ADs-
+AD4- +AD4- +AD4- +AD4- +-       ctx-+AD4-msg.size +AD0- sizeof(ctx-+AD4-ms=
g.payload.u64)+ADs-
+AD4- +AD4- +AD4- +AD4- +-       ctx-+AD4-fd+AF8-num +AD0- 0+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF=
8-REPLY+ADs- +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-static void
+AD4- +AD4- +AD4- +AD4- +-dev+AF8-invalidate+AF8-vrings(struct virtio+AF8-n=
et +ACo-dev) +AHs-
+AD4- +AD4- +AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       for (i +AD0- 0+ADs- i +ADw- dev-+AD4-nr+AF=
8-vring+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               struct vhost+AF8-virtqueue +ACo-vq=
 +AD0- dev-+AD4-virtqueue+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-               if (+ACE-vq)
+AD4- +AD4- +AD4- +AD4- +-                       continue+ADs-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- -free+AF8-guest+AF8-pages:
+AD4- +AD4- +AD4- +AD4- +-               if (vq-+AD4-desc +AHwAfA- vq-+AD4-=
avail +AHwAfA- vq-+AD4-used) +AHs-
+AD4- +AD4- +AD4- +AD4- +-                       /+ACo- vhost+AF8-user+AF8-=
lock+AF8-all+AF8-queue+AF8-pairs locked all qps +ACo-/
+AD4- +AD4- +AD4- +AD4- +-                       VHOST+AF8-USER+AF8-ASSERT+=
AF8-LOCK(dev, vq,
+AD4- +AD4- +AD4- +AD4- +- VHOST+AF8-USER+AF8-ADD+AF8-MEM+AF8-REG)+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       /+ACo-
+AD4- +AD4- +AD4- +AD4- +-                        +ACo- If the memory table=
 got updated, the ring addresses
+AD4- +AD4- +AD4- +AD4- +-                        +ACo- need to be translat=
ed again as virtual addresses have
+AD4- +AD4- +AD4- +AD4- +-                        +ACo- changed.
+AD4- +AD4- +AD4- +AD4- +-                        +ACo-/
+AD4- +AD4- +AD4- +AD4- +-                       vring+AF8-invalidate(dev, =
vq)+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       translate+AF8-ring+AF8-add=
resses(+ACY-dev, +ACY-vq)+ADs-
+AD4- +AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-+AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-static int
+AD4- +AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-add+AF8-mem+AF8-reg(struct vir=
tio+AF8-net +ACoAKg-pdev,
+AD4- +AD4- +AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-con=
text +ACo-ctx,
+AD4- +AD4- +AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rt=
e+AF8-unused)
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- The parameter is marked as unused but is actually used.
+AD4- +AD4-
+AD4- +AD4- I have made the corrections in the amended patch-set I will sub=
mit
+AD4- +AD4- following this e-mail.
+AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- +-+AHs-
+AD4- +AD4- +AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4- +AD4- +-       struct virtio+AF8-net +ACo-dev +AD0- +ACo-=
pdev+ADs-
+AD4- +AD4- +AD4- +AD4- +-       struct VhostUserMemoryRegion +ACo-region +=
AD0-
+AD4- +AD4- +AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.regio=
n+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       /+ACo- convert first region add to normal =
memory table set +ACo-/
+AD4- +AD4- +AD4- +AD4- +-       if (dev-+AD4-mem +AD0APQ- NULL) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               if (vhost+AF8-user+AF8-initialize+=
AF8-memory(pdev) +ADw- 0)
+AD4- +AD4- +AD4- +AD4- +-                       goto close+AF8-msg+AF8-fds=
+ADs-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       /+ACo- make sure new region will fit +ACo-=
/
+AD4- +AD4- +AD4- +AD4- +-       if (dev-+AD4-mem-+AD4-nregions +AD4APQ- VH=
OST+AF8-MEMORY+AF8-MAX+AF8-NREGIONS) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR, +ACI-too many
+AD4- +AD4- +AD4- +AD4- +- memory
+AD4- +AD4- +AD4- regions already (+ACU-u)+ACI-,
+AD4- +AD4- +AD4- +AD4- +-                                                 =
                      dev-+AD4-mem-+AD4-nregions)+ADs-
+AD4- +AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       /+ACo- make sure supplied memory fd presen=
t +ACo-/
+AD4- +AD4- +AD4- +AD4- +-       if (ctx-+AD4-fd+AF8-num +ACEAPQ- 1) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR, +ACI-fd count makes
+AD4- +AD4- +AD4- +AD4- +- no sense
+AD4- +AD4- +AD4- (+ACU-u)+ACI-, ctx-+AD4-fd+AF8-num)+ADs-
+AD4- +AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       /+ACo- Make sure no overlap in guest virtu=
al address space +ACo-/
+AD4- +AD4- +AD4- +AD4- +-       if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- de=
v-+AD4-mem-+AD4-nregions +AD4- 0) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               for (i +AD0- 0+ADs- i +ADw- VHOST+=
AF8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +AD4- +-                       struct rte+AF8-vhost+AF8-m=
em+AF8-region
+AD4- +AD4- +AD4- +AD4- +- +ACo-current+AF8-region +AD0- +ACY-dev-+AD4-mem-=
+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       if (current+AF8-region-+AD=
4-mmap+AF8-size +AD0APQ- 0)
+AD4- +AD4- +AD4- +AD4- +-                               continue+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       uint64+AF8-t current+AF8-r=
egion+AF8-guest+AF8-start +AD0-
+AD4- +AD4- +AD4- +AD4- +- current+AF8-region-
+AD4- +AD4- +AD4- +AD4-guest+AF8-user+AF8-addr+ADs-
+AD4- +AD4- +AD4- +AD4- +-                       uint64+AF8-t current+AF8-r=
egion+AF8-guest+AF8-end +AD0-
+AD4- +AD4- +AD4- current+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +AD4- +AD4- +-                                                 =
              +- current+AF8-region-+AD4-mmap+AF8-size - 1+ADs-
+AD4- +AD4- +AD4- +AD4- +-                       uint64+AF8-t proposed+AF8-=
region+AF8-guest+AF8-start +AD0-
+AD4- +AD4- +AD4- +AD4- +- region-
+AD4- +AD4- +AD4- +AD4-userspace+AF8-addr+ADs-
+AD4- +AD4- +AD4- +AD4- +-                       uint64+AF8-t proposed+AF8-=
region+AF8-guest+AF8-end +AD0-
+AD4- +AD4- +AD4- proposed+AF8-region+AF8-guest+AF8-start
+AD4- +AD4- +AD4- +AD4- +-                                                 =
              +- region-+AD4-memory+AF8-size - 1+ADs-
+AD4- +AD4- +AD4- +AD4- +-                       bool overlap +AD0- false+A=
Ds-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       overlap +AD0- +ACE-((propo=
sed+AF8-region+AF8-guest+AF8-end +ADw-
+AD4- +AD4- +AD4- current+AF8-region+AF8-guest+AF8-start) +AHwAfA-
+AD4- +AD4- +AD4- +AD4- +-                               (proposed+AF8-regi=
on+AF8-guest+AF8-start +AD4-
+AD4- +AD4- +AD4- +AD4- +- current+AF8-region+AF8-guest+AF8-end))+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       if (overlap) +AHs-
+AD4- +AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+A=
F8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +AD4- +-                                       +ACI-reque=
sted memory region
+AD4- +AD4- +AD4- +AD4- +- overlaps with another
+AD4- +AD4- +AD4- region+ACI-)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+A=
F8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +AD4- +-                                       +ACIAXA-tR=
equested region address:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +AD4- +-                                       region-+AD=
4-userspace+AF8-addr)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+A=
F8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +AD4- +-                                       +ACIAXA-tR=
equested region size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +AD4- +-                                       region-+AD=
4-memory+AF8-size)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+A=
F8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +AD4- +-                                       +ACIAXA-tO=
verlapping region address:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +AD4- +-                                       current+AF=
8-region-+AD4-guest+AF8-user+AF8-addr)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               VHOST+AF8-CONFIG+A=
F8-LOG(dev-+AD4-ifname, ERR,
+AD4- +AD4- +AD4- +AD4- +-                                       +ACIAXA-tO=
verlapping region size:0x+ACUAIg- PRIx64,
+AD4- +AD4- +AD4- +AD4- +-                                       current+AF=
8-region-+AD4-mmap+AF8-size)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               goto close+AF8-msg=
+AF8-fds+ADs-
+AD4- +AD4- +AD4- +AD4- +-                       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       /+ACo- find a new region and set it like m=
emory table set does +ACo-/
+AD4- +AD4- +AD4- +AD4- +-       struct rte+AF8-vhost+AF8-mem+AF8-region +A=
Co-reg +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       for (i +AD0- 0+ADs- i +ADw- VHOST+AF8-MEMO=
RY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               if (dev-+AD4-mem-+AD4-regions+AFs-=
i+AF0-.guest+AF8-user+AF8-addr +AD0APQ- 0) +AHs-
+AD4- +AD4- +AD4- +AD4- +-                       reg +AD0- +ACY-dev-+AD4-me=
m-+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +AD4- +-                       break+ADs-
+AD4- +AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-       if (reg +AD0APQ- NULL) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR, +ACI-no free memory
+AD4- +AD4- region+ACI-)+ADs-
+AD4- +AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       reg-+AD4-guest+AF8-phys+AF8-addr +AD0- reg=
ion-+AD4-guest+AF8-phys+AF8-addr+ADs-
+AD4- +AD4- +AD4- +AD4- +-       reg-+AD4-guest+AF8-user+AF8-addr +AD0- reg=
ion-+AD4-userspace+AF8-addr+ADs-
+AD4- +AD4- +AD4- +AD4- +-       reg-+AD4-size            +AD0- region-+AD4=
-memory+AF8-size+ADs-
+AD4- +AD4- +AD4- +AD4- +-       reg-+AD4-fd              +AD0- ctx-+AD4-fd=
s+AFs-0+AF0AOw-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       if (vhost+AF8-user+AF8-mmap+AF8-region(dev=
, reg, region-+AD4-mmap+AF8-offset) +ADw- 0) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-=
ifname, ERR, +ACI-failed to mmap
+AD4- +AD4- region+ACI-)+ADs-
+AD4- +AD4- +AD4- +AD4- +-               goto close+AF8-msg+AF8-fds+ADs-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       dev-+AD4-mem-+AD4-nregions+-+-+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       if (dev-+AD4-async+AF8-copy +ACYAJg- rte+A=
F8-vfio+AF8-is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +AD4- +AD4- +-               async+AF8-dma+AF8-map+AF8-region(d=
ev, reg, true)+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       if (vhost+AF8-user+AF8-postcopy+AF8-regist=
er(dev, main+AF8-fd, ctx) +ADw- 0)
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Post-copy live-migration is broken.
+AD4- +AD4- +AD4- The assumes the vhost-user message is of type SET+AF8-MEM=
+AF8-TABLE, and so
+AD4- +AD4- +AD4- assumes ctx contains a VhostUserMemory payload.
+AD4- +AD4- +AD4- But here ctx contains a VhostUserMemoryRegion payload.
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- Given the complexity of the patch, it is worrying that su=
ch issues
+AD4- +AD4- +AD4- are overlooked.
+AD4- +AD4- +AD4- What other features could be broken?
+AD4- +AD4-
+AD4- +AD4- Although I tested this before I have again tested Post-copy liv=
e
+AD4- +AD4- migration successfully with qemu using the following steps.
+AD4- +AD4- - Ran dpdk-testpmd while enabling poctcopy migration as option.
+AD4- +AD4- - Ran two instances of qemu, source and destination. Source was
+AD4- +AD4- running alpine linux while destination was started with option =
+ACI--incoming
+AD4- defer+ACI-
+AD4- +AD4- - I did an add memory region at the source VM which invoked
+AD4- +AD4- vhost+AF8-postcopy+AF8-register function. After this I did the =
same add memory
+AD4- +AD4- region for destination VM.
+AD4- +AD4- - The +ACI-post+AF8-copy+AF8-register+ACI- debug messages which=
 I added in this
+AD4- +AD4- upcoming patch-set were correctly seen on the testpmd console.
+AD4- +AD4- - Following this I turned on migrate capabilities on source and
+AD4- +AD4- destination VMs at qemu prompt. For destination VM I also set t=
he
+AD4- +AD4- incoming migration to TCP port 4444.
+AD4- +AD4- - Set the +ACI-migrate+ACI- destination to host 127.0.0.1 TCP p=
ort 4444 and
+AD4- +AD4- invoked command +ACI-migrate+AF8-start+AF8-postcopy+ACI-
+AD4- +AD4-
+AD4- +AD4- After the above steps, the Alpine Linux VM memory pages were co=
rrectly
+AD4- +AD4- migrated to destination VM. I would be happy to share console l=
ogs of
+AD4- +AD4- the above test and step by step commands.
+AD4- +AD4-
+AD4- +AD4- Source code clarification: In the function vhost+AF8-user+AF8-a=
dd+AF8-mem+AF8-reg we
+AD4- +AD4- provide the argument of a single region of type
+AD4- +AD4- +ACI-VhostUserMemoryRegion+ACI- in the message payload. This si=
ngle memory
+AD4- +AD4- region is then converted to type rte+AF8-vhost+AF8-mem+AF8-regi=
on (variable reg
+AD4- +AD4- line+ACM-1761) and then added to the list of memory regions usi=
ng the call
+AD4- +AD4- vhost+AF8-user+AF8-mmap+AF8-region(line+ACM-1779). By the time,
+AD4- +AD4- vhost+AF8-user+AF8-postcopy+AF8-register(line+ACM-1794) is call=
ed, the newl added region is
+AD4- part of the +ACI-dev+ACI- structure.
+AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- +-               goto free+AF8-mem+AF8-table+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       dev+AF8-invalidate+AF8-vrings(dev)+ADs-
+AD4- +AD4- +AD4- +AD4- +-       dump+AF8-guest+AF8-pages(dev)+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF=
8-OK+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-free+AF8-mem+AF8-table:
+AD4- +AD4- +AD4- +AD4- +-       free+AF8-all+AF8-mem+AF8-regions(dev)+ADs-
+AD4- +AD4- +AD4- +AD4- +-       rte+AF8-free(dev-+AD4-mem)+ADs-
+AD4- +AD4- +AD4- +AD4- +-       dev-+AD4-mem +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +AD4-         rte+AF8-free(dev-+AD4-guest+AF8-pages)+ADs-
+AD4- +AD4- +AD4- +AD4-         dev-+AD4-guest+AF8-pages +AD0- NULL+ADs-
+AD4- +AD4- +AD4- +AD4-  close+AF8-msg+AF8-fds:
+AD4- +AD4- +AD4- +AD4- +AEAAQA- -1673,6 +-1805,44 +AEAAQA- vhost+AF8-user+=
AF8-set+AF8-mem+AF8-table(struct virtio+AF8-net
+AD4- +AD4- +AD4- +ACoAKg-pdev,
+AD4- +AD4- +AD4- +AD4-         return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF8=
-ERR+ADs-  +AH0-
+AD4- +AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- +-static int
+AD4- +AD4- +AD4- +AD4- +-vhost+AF8-user+AF8-rem+AF8-mem+AF8-reg(struct vir=
tio+AF8-net +ACoAKg-pdev +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +AD4- +AD4- +-                       struct vhu+AF8-msg+AF8-con=
text +ACo-ctx +AF8AXw-rte+AF8-unused,
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- pdev and ctx are actually used.
+AD4- +AD4-
+AD4- +AD4- I have made the corrections in the amended patch-set I will sub=
mit
+AD4- +AD4- following this e-mail.
+AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4-
+AD4- +AD4- +AD4- +AD4- +-                       int main+AF8-fd +AF8AXw-rt=
e+AF8-unused) +AHs-
+AD4- +AD4- +AD4- +AD4- +-       uint32+AF8-t i+ADs-
+AD4- +AD4- +AD4- +AD4- +-       struct virtio+AF8-net +ACo-dev +AD0- +ACo-=
pdev+ADs-
+AD4- +AD4- +AD4- +AD4- +-       struct VhostUserMemoryRegion +ACo-region +=
AD0-
+AD4- +AD4- +AD4- +AD4- +-+ACY-ctx-+AD4-msg.payload.memory+AF8-single.regio=
n+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       if (dev-+AD4-mem +ACEAPQ- NULL +ACYAJg- de=
v-+AD4-mem-+AD4-nregions +AD4- 0) +AHs-
+AD4- +AD4- +AD4- +AD4- +-               for (i +AD0- 0+ADs- i +ADw- VHOST+=
AF8-MEMORY+AF8-MAX+AF8-NREGIONS+ADs- i+-+-) +AHs-
+AD4- +AD4- +AD4- +AD4- +-                       struct rte+AF8-vhost+AF8-m=
em+AF8-region
+AD4- +AD4- +AD4- +AD4- +- +ACo-current+AF8-region +AD0- +ACY-dev-+AD4-mem-=
+AD4-regions+AFs-i+AF0AOw-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       if (current+AF8-region-+AD=
4-guest+AF8-user+AF8-addr +AD0APQ- 0)
+AD4- +AD4- +AD4- +AD4- +-                               continue+ADs-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-                       /+ACo-
+AD4- +AD4- +AD4- +AD4- +-                        +ACo- According to the vh=
ost-user specification:
+AD4- +AD4- +AD4- +AD4- +-                        +ACo- The memory region t=
o be removed is
+AD4- +AD4- +AD4- +AD4- +- identified by its guest
+AD4- +AD4- +AD4- address,
+AD4- +AD4- +AD4- +AD4- +-                        +ACo- user address and si=
ze. The mmap offset is ignored.
+AD4- +AD4- +AD4- +AD4- +-                        +ACo-/
+AD4- +AD4- +AD4- +AD4- +-                       if (region-+AD4-userspace+=
AF8-addr +AD0APQ-
+AD4- +AD4- +AD4- +AD4- +- current+AF8-region-
+AD4- +AD4- +AD4-guest+AF8-user+AF8-addr
+AD4- +AD4- +AD4- +AD4- +-                               +ACYAJg- region-+A=
D4-guest+AF8-phys+AF8-addr +AD0APQ-
+AD4- +AD4- +AD4- +AD4- +- current+AF8-region-
+AD4- +AD4- +AD4- +AD4-guest+AF8-phys+AF8-addr
+AD4- +AD4- +AD4- +AD4- +-                               +ACYAJg- region-+A=
D4-memory+AF8-size +AD0APQ- current+AF8-region-+AD4-size) +AHs-
+AD4- +AD4- +AD4- +AD4- +-                               if (dev-+AD4-async=
+AF8-copy +ACYAJg- rte+AF8-vfio+AF8-is+AF8-enabled(+ACI-vfio+ACI-))
+AD4- +AD4- +AD4- +AD4- +-                                       async+AF8-=
dma+AF8-map+AF8-region(dev, current+AF8-region,
+AD4- false)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               dev+AF8-invalidate=
+AF8-vrings(dev)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               free+AF8-mem+AF8-r=
egion(current+AF8-region)+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               dev-+AD4-mem-+AD4-=
nregions--+ADs-
+AD4- +AD4- +AD4- +AD4- +-                               return RTE+AF8-VHO=
ST+AF8-MSG+AF8-RESULT+AF8-OK+ADs-
+AD4- +AD4- +AD4- +AD4- +-                       +AH0-
+AD4- +AD4- +AD4- +AD4- +-               +AH0-
+AD4- +AD4- +AD4- +AD4- +-       +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4- +-       VHOST+AF8-CONFIG+AF8-LOG(dev-+AD4-ifname, =
ERR, +ACI-failed to find region+ACI-)+ADs-
+AD4- +AD4- +AD4- +AD4- +-       return RTE+AF8-VHOST+AF8-MSG+AF8-RESULT+AF=
8-ERR+ADs- +AH0-
+AD4- +AD4- +AD4- +AD4- +-
+AD4- +AD4- +AD4- +AD4-  static bool
+AD4- +AD4- +AD4- +AD4-  vq+AF8-is+AF8-ready(struct virtio+AF8-net +ACo-dev=
, struct vhost+AF8-virtqueue +ACo-vq)
+AD4- +AD4- +AD4- +AD4- +AHs-
+AD4- +AD4- +AD4- +AD4- --
+AD4- +AD4- +AD4- +AD4- 2.43.0
+AD4- +AD4- +AD4- +AD4-

