Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EC5C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:51:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85CB940E34;
	Mon,  9 Jun 2025 17:51:15 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 7C3B74064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:51:13 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55995v2p026990;
 Mon, 9 Jun 2025 15:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=a/pjTvtTjty7BLqKWZZRtDww
 CiXLWDHEREdmbo/BTlI=; b=jvhsl2ln/t105XeM7s48Cwyl0Zvz9E09yw3zm4T3
 kZcARYi9cxGAwCUZneo63o0BWBMTJDL64Z1/6T7cd4P9ZoT36bmN3LXU8S3WRvcC
 9JB7LpMVegCkWul2WrBa/Joi7Bpp3CXsK7K3F7/tMEnyTG4VY84p/NcGiKsMV4rD
 sNptxGYBY7w5l6xSVAxc93s0pkXskhokkRJX98vk+33EarIR6Ye0RbU8r0vZnjyz
 Zpitx0Cef+CStDCWDbtuGnQvNcPKWCBD7mE+qKYI26fGCesZ2/OX8GYFNjd15/4j
 W/RsZQRG2Vku2kVzjmdBi/YyW8CvekfIjBbPlSmVvdpPCg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dn66eca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 15:51:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCKQ8cIC8kz43Mj7zm/xcJoH3sU5V9v37bwRzvPWM+Nb7fFwDsY8ujjteMOIwHwRqqhomsdvHuSkh97MYTBL9yg0S6wyVJ+7q1Mta8vtkcsApDHzIyT9z2lqlDT7C7lzmV2raAYgWzOnUBtq0FiQP3iI6Tb1gpQLpykVqzwym/RUZOnDj91bxdXoIX4l8WPegdMOirnKDyqv3XqTxX2NCtcw3e0Pju2Fh0Ka/TCbUaNsgota2EhspFoxACpjVe4nDg3RfRHkN8w1ap1jzI4MSjJnF6oE1WRqQjlGk2x3w9Sf0ONRiYVr9mWDaNc6qMQ+sStGFBfMlYw0PAyDIz9YxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/pjTvtTjty7BLqKWZZRtDwwCiXLWDHEREdmbo/BTlI=;
 b=E5a5diF0gA48+XaLR1jzIJ2AWl6tc9x+pvQ1nMdGBgV6x00ASVP91aZlYZzh63pmzWCXCOuYJrZZVnPapqD9EkEZx7s8H8jf5EWwepuHRVtbF0+WzcEepoaQPUKiyBIUYZVEv4qPLLiW/0RYxfJrZ4odO48uPZtb5c/hPusVpkqHV+N5DTIztSMX9BDF0OWAXrH7tMhA28F6+TXYEU75DvqbjsPTH5y9GI9md1fzI5pvXLraVoR1NV9qVcbTLvL0yl8tpSUHEVFulAExOAPdoAr46NA+RI4R4+9Oaj2PJcBY+PYYgPy+leTfPD/Tw/mBFaXl6V9TH1tJSPcoqMm/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DM8PR02MB8171.namprd02.prod.outlook.com (2603:10b6:8:1c::6) by
 DS0PR02MB9126.namprd02.prod.outlook.com (2603:10b6:8:133::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.20; Mon, 9 Jun 2025 15:51:03 +0000
Received: from DM8PR02MB8171.namprd02.prod.outlook.com
 ([fe80::949f:ad63:50e3:e830]) by DM8PR02MB8171.namprd02.prod.outlook.com
 ([fe80::949f:ad63:50e3:e830%2]) with mapi id 15.20.8769.025; Mon, 9 Jun 2025
 15:51:03 +0000
From: Dylan Schneider <schneide@qti.qualcomm.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Thread-Topic: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Thread-Index: AQHb1y1EXfgSn9oKJ0KB1C7sKMwlUbP53K+AgAEhUDw=
Date: Mon, 9 Jun 2025 15:51:03 +0000
Message-ID: <DM8PR02MB8171CB561807D476C05E013DE96BA@DM8PR02MB8171.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
 <20250608153439.322f6c88@hermes.local>
In-Reply-To: <20250608153439.322f6c88@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8171:EE_|DS0PR02MB9126:EE_
x-ms-office365-filtering-correlation-id: a7db29e0-ad79-474f-adcd-08dda76d7046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZJn1vTDcWmZYr9zGvACglmOb0LEF38cF86nkqU2DBAZh9r8JeDQwA9NqRQZC?=
 =?us-ascii?Q?xOvIqEkT8U+D612v8KIiBCMmTCCyg6Iw61RVJutbtUTgabGYs2r1rllRbnIx?=
 =?us-ascii?Q?EWN4C5oPC/kvlPjILFxkAFe73j8pG8zeifpqNQLdbvPZbr+3Z4ooZqybiW0G?=
 =?us-ascii?Q?XWoJb+pITN2g4p3Gtl/VcEEQqt0DUM2UIbtfFWvqE333Azwd/T9GD9nacqxQ?=
 =?us-ascii?Q?oCorP6eDVpdpD46rk/KTS3gwL7f68ta6txolHcWG0CDHV3F0norxkWq2SRRU?=
 =?us-ascii?Q?4FsovL38MF3V9d/0qwPT7PVZdqh8G95XXe3HYUybPg6krchfkscTaDC1AQm/?=
 =?us-ascii?Q?vyuhfTIl5zHCUBzuxnKD4f0DXDI9wn+rJWaGiqQ0won0FIMz94vZEHx/gDGC?=
 =?us-ascii?Q?/mZGHs8HQsama5053V/c3rYe9gVNpaHe8smjPiwEXYjs/TcCDXDalZ0wvoEV?=
 =?us-ascii?Q?21RkNGA+v+WAiUdod1kheKzZYrHo4/BhVOwdBpeb05HY1qXimkrl+j+xGLYB?=
 =?us-ascii?Q?6vs9hePRns7qyEHOiIfUVGWo+5vHD/ue27wJt8UyVPnC+QsUKOAZ2NKf+dss?=
 =?us-ascii?Q?CfT3qUbuNPLzunVklmUE4QeCs8+To0qyj6rpCAZZM3Qp9mFARdjvzuKqoZaa?=
 =?us-ascii?Q?d4E/yp+Sj/EQcfkG7D/j/aC//fiki3dCbCVJqLl1IXPnkxKtKjiOU1uI7BSC?=
 =?us-ascii?Q?iyoM4Vu1MAj5+vVSPVkaFQ+uybtaQOPCJRd0OpllNbcbtKPumOnW/TCJ9v/m?=
 =?us-ascii?Q?KK/VaqhYMmhLgbQgZ8d4IPH/naL91ogrEkOc/mfg8KY0fTTo0CGhe7B7r9bA?=
 =?us-ascii?Q?c59kbiZyDh0R1suhCEjq7LYEAHbXmjcPpgMwSnbmRH+a/BJFbppZ6qiCIuLX?=
 =?us-ascii?Q?1Y063AVPvrd8tnGUE3QDO2HA/rNhDRx28ho8+fKEfAc6dh16CUnqyJlM80p1?=
 =?us-ascii?Q?V9ApCUNu2wM6bpre3KJh6FGnjODxT+eMGrcPRtXV61Z0g84k6C4Yu/1onlfH?=
 =?us-ascii?Q?iUQ2IEO7novlcOLvd5mFr+9kE+5e9Wyl7jXbeINzAZUpqT3Jaj4iP40U0wrp?=
 =?us-ascii?Q?fKMHgvzUJxc1MLx3rORtJvQIHdunevW5GAlPMBKVdppNsZ4bD5aRtwzRX4IN?=
 =?us-ascii?Q?6ou4tlNhWqBhNepKfnNZ84Y7TI2oZroJDQIb3pV2ModHuDADYNbvhgahbhjE?=
 =?us-ascii?Q?oPm0w6C09LBJAkAq/5o/R6OvNoBOJPkKoSRe7Llj28M9CbmibwA7lm9QHtu+?=
 =?us-ascii?Q?GIsyUz+bxmFNb9IconSxyYHHMB2B154VdLJHh2JjOrzHxsLjMvAnvRNPiHef?=
 =?us-ascii?Q?Nn6+vsCxQpWkLTmFcKZ/Vi8IaeFyoibBLEAVJP/jSn38e8ltyGL0ww9M+AYQ?=
 =?us-ascii?Q?WF1wTFWGGeugYg0R0nhstE+FHKXhvLFSMW+zfBiQasskAd2ld+OYtNfW4pe9?=
 =?us-ascii?Q?Z5+ZzGbNTqWT9FLYRm3ypf1QyUE+WVJeaQt5DqqF38w8aJzaxWJfMA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR02MB8171.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yo6r8xUeXQdYext6+P1pJtgW9tBIxq5f7uOrVSErVl/sct5kiZZ9POxFyI8B?=
 =?us-ascii?Q?8kxCNgl6QhzDovrW8fA4RSMjIzCAjqqdEPxpOdrJ3XuYEl9awII3nuYtnAbe?=
 =?us-ascii?Q?KKynrEbNjlm5du3363KE+5xaEZUtte2sHg9YZuft987mO/OOZIRQlkN3rDzj?=
 =?us-ascii?Q?OmaD5ZYzLPCA5EtRLCh0a6shPlp8Z/kgwjJoFt2f5m9Y0U25nZzfVecyo42T?=
 =?us-ascii?Q?f+ZklinEziv1dlFO02iail1tSmo/kre7lDKwfh8jv9Hu0faaN4hMh3J9I/5M?=
 =?us-ascii?Q?RjBul3lVpzYmSs1FFypcreAoL7HgimHMfJQkQfZkvyBFDbWcIxzbSquy3OFV?=
 =?us-ascii?Q?FvXu5vOLauzQi/m3r7s938rEhx4N8vld3BuH9e3Y4NapakZuJiLwsKtTwN/a?=
 =?us-ascii?Q?/9VuHQOB50x/ygAYcYBQgMonwgQwlSTqtDSlj6A1d6FvDXDjilde+fTGsyMU?=
 =?us-ascii?Q?rh6HWimD5MefBoB5q4dv8MGVJh0nzfPiiWVuwnSbV4YdSyMZNJ8zTrQtU+xK?=
 =?us-ascii?Q?WQ6F8zkzJqKsQz7Tcap7ayJ0hlCsooiGCWf1ZVHQrVUrOy5fedbrIA/AXOij?=
 =?us-ascii?Q?V7KFsqwmK3gzrxHlRAGiGZDJ/uoQqSRXuQfe6fwSSkqecyE+k38fwQtA+hww?=
 =?us-ascii?Q?1PobvXFuSlyiMytQhQi6oyFEmXWjtsbHCG4u+zSsUvxOMZOSArvmnv+ApDup?=
 =?us-ascii?Q?Fz8quOHBJRbmZ0NWl7yMwXeVfQJKR4tK/t8H+8HEj541iryPzlaxZAJrQyVY?=
 =?us-ascii?Q?BTbvjC6D0Ij3PGO/RvEwSnjSiATQck8eMarw99g019cXstyGlI0jFvmxiwzl?=
 =?us-ascii?Q?4ib8fGIEN1Y3U+XICD9B6sp6Q/j1wzp/l5aRVhFZD5zjWfOoS9UvpKdVCVfb?=
 =?us-ascii?Q?eevNCINh0b4v31L3sFbL2AOG4csk0HmWPyyoRTHNytfPKk/nrITHGJuuco40?=
 =?us-ascii?Q?y4TwA/NjSIZyCnQgayd8REmraMcu3rHif8NDkn6LGS2dcvryL4wtANOUlA1H?=
 =?us-ascii?Q?lSKHzpLeyL5fpYngor56yxOTkzsMyw0rsV7No/6Ex1z1Sb7u5+GWWLApqhH1?=
 =?us-ascii?Q?sMyfYLBmkDYklrkYzZOd7XnFkNEIQioYHVL5KDfpRs7cLZklwscvCc75J+6V?=
 =?us-ascii?Q?av1kCbSHWDplswANa0mu4rW9qlhEAwwsGXelokXrFqVwAb3oY2rnBdh2VC/E?=
 =?us-ascii?Q?BbYcjqyQ/uEaQvOzdysK7gEc9Kda4OgevbTxN1a+XAYklDgx+gwxTQGWIaPU?=
 =?us-ascii?Q?eBYCZKYD7p7+mG2N4qzsyzVQZHIjJRr2AGkIz0teQohEyoNxhOawDWmGsmIl?=
 =?us-ascii?Q?EffMLWT0eo9/SWeMDCHYETAWbCo/l3szvS6srBDWvMxtPX12Vv4i/hHQdL+W?=
 =?us-ascii?Q?7+5DLm4AfreWvM0cMw0XXO+mO0GwTaG/jGJHuEsf+A2jvLmLHQGQjnqWWJ31?=
 =?us-ascii?Q?UhuA8w/+qN65ffs4PMH59he6BN7IXt6ftSEVT1f82iinQJQp8DqFsyEp5xM7?=
 =?us-ascii?Q?0+UOIJoIz4Kpnwux7nwoq+ibmBBlaQQ9uqWY0XXjUvB3vyMHotHJcAcdbJVb?=
 =?us-ascii?Q?psobCIZvXofiRNF8s/jmsH2J7dFuiHbAX4mhFj44?=
Content-Type: multipart/alternative;
 boundary="_000_DM8PR02MB8171CB561807D476C05E013DE96BADM8PR02MB8171namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3I/GQ60D1s5G50L6cB4vB/N4XgMZ6hMZnKApHNHTIARda/Ug/P2iEDjKzBjKgymiSJeDDKnh1bbqzbKzEDPEbx9cvzc0PH+9wBCUvRr8FStlhV7+nnoBzaTOYJdSPjdHqOIoH506962mUdRxFQ+ICoo+bd7X6xXRVF7tBrFMRQEHPsmweeZEYmAyuNL4JA6q3z1Kox5mEKLCjQZEtHDifW4KegUbkxLSy+PrrvXgoYNLirTF3hlPiKLV/IVvvb1/wwFOGvn3JhKMtqEzi4b85HhLJqRsFni3kg8AQ3XuUD/j2LRUZS9OF7P3BsFCN9UUy+NueQsFwjLiu5PKebYEhRoaW96c3+AWXpRGLfbukSyZXpMOa6/3Rc3fxOB7FezRG//nlMqcCEyt/VY/N4cfhco8FaL1X/P8/6x2PiS86flxcHigmwlkPdeywRCw5PQbBP2de/33bbOjlvPwQy0UvLzUyZQEJMkfEKCDuNVBFdzftwT+/nW0rSoSIAnJ3Hj63Zu8rfzHiOftzKFh8Yx1neBynDEmhmyMORB77f21dJpS7vF84TQNs+XZsJKctdPgDtkI8jSRiM9YDDs9d4tbB0+hVwIKljKbCx4VBRD+aOywVewq4otwaVhLJzPtS8/a
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8171.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7db29e0-ad79-474f-adcd-08dda76d7046
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 15:51:03.3019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtRWDmYegRpMD4tjzhi1QMvT8I+S5K8kWwj9dWjP8Dktv9JJVtAiW2F40viZe3z5ea4oLVtdPMPhKXG3o3H/y9UnQlS8NgKlE6JRlnob1kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNyBTYWx0ZWRfX554viCcDo2Ls
 iX0npIS7B+T8eA2dl/jTojyb6NfFAbFYZVdzLU0h7EPAMTvoByBDeNvja9bDd+LWgKyBBc1yN2e
 J6ozwA7/Lnd6pOnxI4oOe/DafWtKS4uSAAqzfFHNWo1bvVBGPvzT0wuCvBOqnp72iOB6ds+c9uM
 0448gErXP3GJxpvueJKZQfmejZ4HHx7KHdfs2uPMRPJvpxeHjV8aQijQxM0NomO+oFzpY6d4Gi3
 l+W5JykavoyRblg5UkbbwGlzWs3Cll2G/mE8V5z0TD3PC/CF7toLLyLFnj0CnmCtY1p1Sq6FBbm
 Esc+f9bOfqtqL/aKXfuo+McLYt2L+U3l13/FKzF3MFT1GpYCeB9ZQESfzP4TQxLNEExxkrbJ/Jd
 R8qJSloSnI1wygmArfZUum54IqtAw32ABT1CcTqitjjVqa99hfROSHWn0+2BTWLfEVpXTcjW
X-Proofpoint-GUID: V3HHa5YzpZr3DfgMAvZUDPRNZBNqNmJ0
X-Authority-Analysis: v=2.4 cv=FaQ3xI+6 c=1 sm=1 tr=0 ts=684702eb cx=c_pps
 a=LxkDbUgDkQmSfly3BTNqMw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=jZVsG21pAAAA:8 a=EUspDBNiAAAA:8
 a=8rWy6zfcAAAA:8 a=bt5KbKNvAAAA:8 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8
 a=Byx-y9mGAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=GRf2JX_IAAAA:8
 a=VYDjIKVHAAAA:8 a=_gsV02HDAAAA:8 a=eh1Yez-EAAAA:8 a=_x2vVf0wm1cR0uAePNgA:9
 a=CjuIK1q_8ugA:10 a=rBDVqsrr9RB6wR-VuSIA:9 a=25BTc0CPEtxxeLz4:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=uRw8vnb707Rr89TYUhP5:22 a=-sS9_DeNG7cEylvMdImQ:22 a=GzKgaEE0kT068tgm3IUS:22
X-Proofpoint-ORIG-GUID: V3HHa5YzpZr3DfgMAvZUDPRNZBNqNmJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090117
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

--_000_DM8PR02MB8171CB561807D476C05E013DE96BADM8PR02MB8171namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Stephen,
In this case, is it best to just pass 1 with a comment saying that is DLT_E=
N10MB? Or is there a way we can get it defined in all configs?
________________________________
From: Stephen Hemminger <stephen@networkplumber.org>
Sent: Sunday, June 8, 2025 4:34 PM
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Thomas Monjalon <thomas@monjalon.net>; Res=
hma Pattan <reshma.pattan@intel.com>; Jerin Jacob <jerinj@marvell.com>; Kir=
an Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvel=
l.com>; Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interf=
ace block

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Fri,  6 Jun 2025 15:52:08 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> From: Dylan Schneider <schneide@qti.qualcomm.com>
>
> Allow the user to specify protocol link type when creating pcapng files.
> This change is needed to specify the protocol type in the pcapng file,
> DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> for other protocols to be used on files generated by pcapng.
>
> Includes a breaking change to rte_pcapng_add_interface to add link_type
> parameter. Existing calls to the function have been updated to pass
> DLT_EN10MB for the link type argument.
>
> Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: stephen@networkplumber.org
> ---
>  .mailmap                               |  1 +
>  app/dumpcap/main.c                     |  4 ++--
>  app/test/test_pcapng.c                 |  8 ++++----
>  doc/guides/rel_notes/release_25_07.rst |  5 ++++-
>  lib/graph/graph_pcap.c                 |  4 +++-
>  lib/pcapng/meson.build                 |  2 ++
>  lib/pcapng/rte_pcapng.c                | 21 +++++++++++++++------
>  lib/pcapng/rte_pcapng.h                |  4 +++-
>  8 files changed, 34 insertions(+), 15 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 91e08f4a1f..a585124832 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -390,6 +390,7 @@ Dukai Yuan <dukaix.yuan@intel.com>
>  Dumitru Ceara <dceara@redhat.com> <dumitru.ceara@gmail.com>
>  Duncan Bellamy <dunk@denkimushi.com>
>  Dustin Lundquist <dustin@null-ptr.net>
> +Dylan Schneider <schneide@qti.qualcomm.com>
>  Dzmitry Sautsa <dzmitryx.sautsa@intel.com>
>  Ed Czeck <ed.czeck@atomicrules.com>
>  Eduard Serra <eserra@vmware.com>
> diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
> index 3d3c0dbc66..e0e2b26269 100644
> --- a/app/dumpcap/main.c
> +++ b/app/dumpcap/main.c
> @@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)
>               free(os);
>
>               TAILQ_FOREACH(intf, &interfaces, next) {
> -                     if (rte_pcapng_add_interface(ret.pcapng, intf->port=
, intf->ifname,
> -                                                  intf->ifdescr, intf->o=
pts.filter) < 0)
> +                     if (rte_pcapng_add_interface(ret.pcapng, intf->port=
, DLT_EN10MB,
> +                             intf->ifname, intf->ifdescr, intf->opts.fil=
ter) < 0)
>                               rte_exit(EXIT_FAILURE, "rte_pcapng_add_inte=
rface %u failed\n",
>                                       intf->port);
>               }
> diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
> index 8f2cff36c3..bcf99724fa 100644
> --- a/app/test/test_pcapng.c
> +++ b/app/test/test_pcapng.c
> @@ -345,7 +345,7 @@ test_add_interface(void)
>       }
>
>       /* Add interface to the file */
> -     ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +     ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                      NULL, NULL, NULL);
>       if (ret < 0) {
>               fprintf(stderr, "can not add port %u\n", port_id);
> @@ -353,7 +353,7 @@ test_add_interface(void)
>       }
>
>       /* Add interface with ifname and ifdescr */
> -     ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +     ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                      "myeth", "Some long description", NU=
LL);
>       if (ret < 0) {
>               fprintf(stderr, "can not add port %u with ifname\n", port_i=
d);
> @@ -361,7 +361,7 @@ test_add_interface(void)
>       }
>
>       /* Add interface with filter */
> -     ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +     ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                      NULL, NULL, "tcp port 8080");
>       if (ret < 0) {
>               fprintf(stderr, "can not add port %u with filter\n", port_i=
d);
> @@ -406,7 +406,7 @@ test_write_packets(void)
>       }
>
>       /* Add interface to the file */
> -     ret =3D rte_pcapng_add_interface(pcapng, port_id,
> +     ret =3D rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB,
>                                      NULL, NULL, NULL);
>       if (ret < 0) {
>               fprintf(stderr, "can not add port %u\n", port_id);
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_note=
s/release_25_07.rst
> index 6b070801de..2396c7b014 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -108,7 +108,10 @@ API Changes
>     This section is a comment. Do not overwrite or remove it.
>     Also, make sure to start the actual text at the margin.
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -
> +* pcapng: Changed the API for adding interfaces to include a link type a=
rgument.
> +  The link type was previously hardcoded to the ethernet link type in th=
e API.
> +  This argument is added to ``rte_pcapng_add_interface``.
> +  These functions are versioned to retain binary compatibility until the=
 next LTS release.
>
>  ABI Changes
>  -----------
> diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
> index 89525f1220..13d86b7a18 100644
> --- a/lib/graph/graph_pcap.c
> +++ b/lib/graph/graph_pcap.c
> @@ -11,6 +11,8 @@
>  #include <rte_mbuf.h>
>  #include <rte_pcapng.h>
>
> +#include <pcap/pcap.h>
> +
>  #include "rte_graph_worker.h"
>
>  #include "graph_pcap_private.h"
> @@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)
>
>       /* Add the configured interfaces as possible capture ports */
>       RTE_ETH_FOREACH_DEV(portid) {
> -             ret =3D rte_pcapng_add_interface(pcapng_fd, portid,
> +             ret =3D rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN1=
0MB,
>                                              NULL, NULL, NULL);
>               if (ret < 0) {
>                       graph_err("Graph rte_pcapng_add_interface port %u f=
ailed: %d",
> diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build
> index 4549925d41..3aa7ba5155 100644
> --- a/lib/pcapng/meson.build
> +++ b/lib/pcapng/meson.build
> @@ -5,3 +5,5 @@ sources =3D files('rte_pcapng.c')
>  headers =3D files('rte_pcapng.h')
>
>  deps +=3D ['ethdev']
> +
> +use_function_versioning =3D true
> diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
> index cacbefdc50..f18af25983 100644
> --- a/lib/pcapng/rte_pcapng.c
> +++ b/lib/pcapng/rte_pcapng.c
> @@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,
>  }
>
>  /* Write an interface block for a DPDK port */
> -RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)
> -int
> -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
> -                      const char *ifname, const char *ifdescr,
> -                      const char *filter)
> +RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,
> +                     (rte_pcapng_t *self, uint16_t port, uint16_t link_t=
ype,
> +                     const char *ifname, const char *ifdescr,
> +                     const char *filter))
>  {
>       struct pcapng_interface_block *hdr;
>       struct rte_eth_dev_info dev_info;
> @@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t=
 port,
>       hdr =3D (struct pcapng_interface_block *)buf;
>       *hdr =3D (struct pcapng_interface_block) {
>               .block_type =3D PCAPNG_INTERFACE_BLOCK,
> -             .link_type =3D 1,         /* DLT_EN10MB - Ethernet */
> +             .link_type =3D link_type,
>               .block_length =3D len,
>       };
>
> @@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_=
t port,
>       return write(self->outfd, buf, len);
>  }
>
> +RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,
> +                               (rte_pcapng_t *self, uint16_t port,
> +                                const char *ifname, const char *ifdescr,
> +                                const char *filter))
> +{
> +     /* Call the new version with a default link_type (Ethernet) */
> +     return rte_pcapng_add_interface(self, port, DLT_EN10MB,
> +                                                                     ifn=
ame, ifdescr, filter);
> +}
> +
>  /*
>   * Write an Interface statistics block at the end of capture.
>   */
> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
> index 48f2b57564..9880d415c4 100644
> --- a/lib/pcapng/rte_pcapng.h
> +++ b/lib/pcapng/rte_pcapng.h
> @@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
>   *  The handle to the packet capture file
>   * @param port
>   *  The Ethernet port to report stats on.
> + * @param link_type
> + *   The link type (e.g., DLT_EN10MB).
>   * @param ifname (optional)
>   *  Interface name to record in the file.
>   *  If not specified, name will be constructed from port
> @@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);
>   * must be added.
>   */
>  int
> -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,
> +rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t lin=
k_type,
>                        const char *ifname, const char *ifdescr,
>                        const char *filter);
>

Build is failing, DLT_EN10MB is not available in all configs.

--_000_DM8PR02MB8171CB561807D476C05E013DE96BADM8PR02MB8171namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hey Stephen,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
In this case, is it best to just pass 1 with a comment saying that is DLT_E=
N10MB? Or is there a way we can get it defined in all configs?</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Stephen Hemminger &lt=
;stephen@networkplumber.org&gt;<br>
<b>Sent:</b> Sunday, June 8, 2025 4:34 PM<br>
<b>To:</b> Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Thomas Monjalon &lt;thomas@mo=
njalon.net&gt;; Reshma Pattan &lt;reshma.pattan@intel.com&gt;; Jerin Jacob =
&lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marvell.com&gt;; =
Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan &lt;yanzhirun=
_163@163.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] pcapng: allow any protocol link type for the=
 interface block</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARNING: This email originated from outside of Qua=
lcomm. Please be wary of any links or attachments, and do not enable macros=
.<br>
<br>
On Fri,&nbsp; 6 Jun 2025 15:52:08 -0600<br>
Schneide &lt;schneide@qti.qualcomm.com&gt; wrote:<br>
<br>
&gt; From: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt;<br>
&gt; Allow the user to specify protocol link type when creating pcapng file=
s.<br>
&gt; This change is needed to specify the protocol type in the pcapng file,=
<br>
&gt; DLT_EN10MB specifies ethernet packets only. This will allow dissectors=
<br>
&gt; for other protocols to be used on files generated by pcapng.<br>
&gt;<br>
&gt; Includes a breaking change to rte_pcapng_add_interface to add link_typ=
e<br>
&gt; parameter. Existing calls to the function have been updated to pass<br=
>
&gt; DLT_EN10MB for the link type argument.<br>
&gt;<br>
&gt; Fixes: d1da6d0d04c7 (&quot;pcapng: require per-interface information&q=
uot;)<br>
&gt; Signed-off-by: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; Cc: stephen@networkplumber.org<br>
&gt; ---<br>
&gt;&nbsp; .mailmap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp; app/dumpcap/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 4 ++--<br>
&gt;&nbsp; app/test/test_pcapng.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 ++++----<b=
r>
&gt;&nbsp; doc/guides/rel_notes/release_25_07.rst |&nbsp; 5 ++++-<br>
&gt;&nbsp; lib/graph/graph_pcap.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&gt;&nbsp; lib/pcapng/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 ++<br>
&gt;&nbsp; lib/pcapng/rte_pcapng.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 21 +++++++++++++++-----=
-<br>
&gt;&nbsp; lib/pcapng/rte_pcapng.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 +++-<br>
&gt;&nbsp; 8 files changed, 34 insertions(+), 15 deletions(-)<br>
&gt;<br>
&gt; diff --git a/.mailmap b/.mailmap<br>
&gt; index 91e08f4a1f..a585124832 100644<br>
&gt; --- a/.mailmap<br>
&gt; +++ b/.mailmap<br>
&gt; @@ -390,6 +390,7 @@ Dukai Yuan &lt;dukaix.yuan@intel.com&gt;<br>
&gt;&nbsp; Dumitru Ceara &lt;dceara@redhat.com&gt; &lt;dumitru.ceara@gmail.=
com&gt;<br>
&gt;&nbsp; Duncan Bellamy &lt;dunk@denkimushi.com&gt;<br>
&gt;&nbsp; Dustin Lundquist &lt;dustin@null-ptr.net&gt;<br>
&gt; +Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt;&nbsp; Dzmitry Sautsa &lt;dzmitryx.sautsa@intel.com&gt;<br>
&gt;&nbsp; Ed Czeck &lt;ed.czeck@atomicrules.com&gt;<br>
&gt;&nbsp; Eduard Serra &lt;eserra@vmware.com&gt;<br>
&gt; diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c<br>
&gt; index 3d3c0dbc66..e0e2b26269 100644<br>
&gt; --- a/app/dumpcap/main.c<br>
&gt; +++ b/app/dumpcap/main.c<br>
&gt; @@ -800,8 +800,8 @@ static dumpcap_out_t create_output(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; free(os);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; TAILQ_FOREACH(intf, &amp;interfaces, next) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_pcapng_add_inte=
rface(ret.pcapng, intf-&gt;port, intf-&gt;ifname,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 intf-&gt;ifdescr, intf-&gt;opts.filter) &lt; 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_pcapng_add_inte=
rface(ret.pcapng, intf-&gt;port, DLT_EN10MB,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; intf-&gt;ifname, intf-&gt;ifdescr, intf-&gt;opts.f=
ilter) &lt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_exit(EXIT_FAILURE, &quot;rte_pcapng_=
add_interface %u failed\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; intf-&gt;port);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt; diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c<br>
&gt; index 8f2cff36c3..bcf99724fa 100644<br>
&gt; --- a/app/test/test_pcapng.c<br>
&gt; +++ b/app/test/test_pcapng.c<br>
&gt; @@ -345,7 +345,7 @@ test_add_interface(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface to the file */<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id, DLT_EN10MB,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; NULL, NULL, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u\n&quot;, port_id);<=
br>
&gt; @@ -353,7 +353,7 @@ test_add_interface(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface with ifname and i=
fdescr */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id, DLT_EN10MB,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &quot;myeth&quot;, &quot;Some long description&quot;, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u with ifname\n&quot;=
, port_id);<br>
&gt; @@ -361,7 +361,7 @@ test_add_interface(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface with filter */<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id, DLT_EN10MB,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; NULL, NULL, &quot;tcp port 8080&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u with filter\n&quot;=
, port_id);<br>
&gt; @@ -406,7 +406,7 @@ test_write_packets(void)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add interface to the file */<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rte_pcapng_add_interface(pcapng, por=
t_id, DLT_EN10MB,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; NULL, NULL, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; fprintf(stderr, &quot;can not add port %u\n&quot;, port_id);<=
br>
&gt; diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_n=
otes/release_25_07.rst<br>
&gt; index 6b070801de..2396c7b014 100644<br>
&gt; --- a/doc/guides/rel_notes/release_25_07.rst<br>
&gt; +++ b/doc/guides/rel_notes/release_25_07.rst<br>
&gt; @@ -108,7 +108,10 @@ API Changes<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; This section is a comment. Do not overwrite or=
 remove it.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Also, make sure to start the actual text at th=
e margin.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; -<br>
&gt; +* pcapng: Changed the API for adding interfaces to include a link typ=
e argument.<br>
&gt; +&nbsp; The link type was previously hardcoded to the ethernet link ty=
pe in the API.<br>
&gt; +&nbsp; This argument is added to ``rte_pcapng_add_interface``.<br>
&gt; +&nbsp; These functions are versioned to retain binary compatibility u=
ntil the next LTS release.<br>
&gt;<br>
&gt;&nbsp; ABI Changes<br>
&gt;&nbsp; -----------<br>
&gt; diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c<br>
&gt; index 89525f1220..13d86b7a18 100644<br>
&gt; --- a/lib/graph/graph_pcap.c<br>
&gt; +++ b/lib/graph/graph_pcap.c<br>
&gt; @@ -11,6 +11,8 @@<br>
&gt;&nbsp; #include &lt;rte_mbuf.h&gt;<br>
&gt;&nbsp; #include &lt;rte_pcapng.h&gt;<br>
&gt;<br>
&gt; +#include &lt;pcap/pcap.h&gt;<br>
&gt; +<br>
&gt;&nbsp; #include &quot;rte_graph_worker.h&quot;<br>
&gt;<br>
&gt;&nbsp; #include &quot;graph_pcap_private.h&quot;<br>
&gt; @@ -117,7 +119,7 @@ graph_pcap_file_open(const char *filename)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add the configured interfaces a=
s possible capture ports */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ETH_FOREACH_DEV(portid) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D rte_pcapng_add_interface(pcapng_fd, portid,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D rte_pcapng_add_interface(pcapng_fd, portid, DLT_EN10MB,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (ret &lt; 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; graph_err(&qu=
ot;Graph rte_pcapng_add_interface port %u failed: %d&quot;,<br>
&gt; diff --git a/lib/pcapng/meson.build b/lib/pcapng/meson.build<br>
&gt; index 4549925d41..3aa7ba5155 100644<br>
&gt; --- a/lib/pcapng/meson.build<br>
&gt; +++ b/lib/pcapng/meson.build<br>
&gt; @@ -5,3 +5,5 @@ sources =3D files('rte_pcapng.c')<br>
&gt;&nbsp; headers =3D files('rte_pcapng.h')<br>
&gt;<br>
&gt;&nbsp; deps +=3D ['ethdev']<br>
&gt; +<br>
&gt; +use_function_versioning =3D true<br>
&gt; diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c<br>
&gt; index cacbefdc50..f18af25983 100644<br>
&gt; --- a/lib/pcapng/rte_pcapng.c<br>
&gt; +++ b/lib/pcapng/rte_pcapng.c<br>
&gt; @@ -200,11 +200,10 @@ pcapng_section_block(rte_pcapng_t *self,<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /* Write an interface block for a DPDK port */<br>
&gt; -RTE_EXPORT_SYMBOL(rte_pcapng_add_interface)<br>
&gt; -int<br>
&gt; -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *ifnam=
e, const char *ifdescr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *filte=
r)<br>
&gt; +RTE_DEFAULT_SYMBOL(26, int, rte_pcapng_add_interface,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rte_pcapng_t *self, ui=
nt16_t port, uint16_t link_type,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *ifname, con=
st char *ifdescr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *filter))<br=
>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pcapng_interface_block *hdr=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_eth_dev_info dev_info;<=
br>
&gt; @@ -274,7 +273,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint1=
6_t port,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr =3D (struct pcapng_interface_b=
lock *)buf;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hdr =3D (struct pcapng_interface_=
block) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .block_type =3D PCAPNG_INTERFACE_BLOCK,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; .link_type =3D 1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DL=
T_EN10MB - Ethernet */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; .link_type =3D link_type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; .block_length =3D len,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt;<br>
&gt; @@ -319,6 +318,16 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint=
16_t port,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return write(self-&gt;outfd, buf, =
len);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; +RTE_VERSION_SYMBOL(25, int, rte_pcapng_add_interface,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (rte_pcapng_t *self, uint16_t port,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *ifname, const char *=
ifdescr,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *filter))<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Call the new version with a default link_=
type (Ethernet) */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return rte_pcapng_add_interface(self, port, =
DLT_EN10MB,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifname, ifdescr, filter);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; /*<br>
&gt;&nbsp;&nbsp; * Write an Interface statistics block at the end of captur=
e.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h<br>
&gt; index 48f2b57564..9880d415c4 100644<br>
&gt; --- a/lib/pcapng/rte_pcapng.h<br>
&gt; +++ b/lib/pcapng/rte_pcapng.h<br>
&gt; @@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
&gt;&nbsp;&nbsp; *&nbsp; The handle to the packet capture file<br>
&gt;&nbsp;&nbsp; * @param port<br>
&gt;&nbsp;&nbsp; *&nbsp; The Ethernet port to report stats on.<br>
&gt; + * @param link_type<br>
&gt; + *&nbsp;&nbsp; The link type (e.g., DLT_EN10MB).<br>
&gt;&nbsp;&nbsp; * @param ifname (optional)<br>
&gt;&nbsp;&nbsp; *&nbsp; Interface name to record in the file.<br>
&gt;&nbsp;&nbsp; *&nbsp; If not specified, name will be constructed from po=
rt<br>
&gt; @@ -84,7 +86,7 @@ rte_pcapng_close(rte_pcapng_t *self);<br>
&gt;&nbsp;&nbsp; * must be added.<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; int<br>
&gt; -rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port,<br>
&gt; +rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t =
link_type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const c=
har *ifname, const char *ifdescr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const c=
har *filter);<br>
&gt;<br>
<br>
Build is failing, DLT_EN10MB is not available in all configs.<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM8PR02MB8171CB561807D476C05E013DE96BADM8PR02MB8171namp_--
