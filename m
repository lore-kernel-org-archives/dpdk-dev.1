Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B034CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 21:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 585064065B;
	Thu, 18 Sep 2025 23:18:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 79C36402D0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 23:18:09 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IF5aPC011208;
 Thu, 18 Sep 2025 21:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=l9ry2d01CYD0JQN/pf3I6Yo2
 BpFR5RJuOX9r4VGSmKM=; b=QDO9+ksL2FBUWThVFL2o4/rHG2mtu4zYOgQ4Q68E
 /4p1qKaxVWS8n7d24KHriLJHUO6lZzhBwM/dGT1Gl+fQ6Gu0Eg/rRWRUFAh+FLGC
 4Ih0i8AcYD9rJtVPnOB0oJxDv9h/kPK70aQgw8wJYhWYf0ezs3VrNZG1+mCILhIN
 UJXKkZvwUKC+JspKcK/URQtxRZLpnWa6FNpzP/RM93Xle1iFHwXbpCYLjyDyzv3N
 jGkZ15kTU22kfQYHfJjIBzvWGqsQBETBRJtZUpQ1tBNmWv+cm3wz+upNTPXpMced
 Im6ahfB2RcTP/xX+Cbg4JNZx9zZkXSjuaFAWBn5aFPomlQ==
Received: from sn1pr07cu001.outbound.protection.outlook.com
 (mail-sn1pr07cu00107.outbound.protection.outlook.com [40.93.14.103])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4985wx42m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 21:18:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHUzj5qCDQ12aE+mpRtohp1Gs10fD2RQPFur+EOcNShc7JmjKqlGbFpiWrIUgoCC2nyBRs1+PeJZOiCSB0sobVeaz3WDX1v+01zAsLBuaXp2eSadukwIXXPvbNlTpWXd/2VcIAtAEv4cKESi4yeY72HWxiCxyj7yKBYynYDEwwBN9qrNP2yGItz+5ymQC3zcB37CWaosZUYQ8zSmt5U9mdOWbtDyDYbczuKM7Cymc0yPrGT63Znspb4FkzbT+Lb4sy8BY5cPafqefkAULhQnCCw30qEVf8Kt0ssDK+RLjhF4QgGR7HMlkgcfmCVTw7fdx2g5PF76yocIeNgG+2lX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9ry2d01CYD0JQN/pf3I6Yo2BpFR5RJuOX9r4VGSmKM=;
 b=zEImdq214WphA3NTAjW7HqMmfKzC9f4R3OMyHx1IJU1hnCX12bfhkMW9YXLZnx+aWBvyHtJ3O+8fd1/SmW/6RwwxithFdxJ2nvU6S8oKTy9VJs0j/BffIqyW5H6cB7LvZxE8bEIi/NuiERPMtdQ46zadzpo1meccoQub6BoXCoA5cq28XQ2DrX1n0nmhCv1CgIaFTISxfiJHzeS7GRmWBZ6rQ+uC2VKk87vXw0IURI0xGmBbwRrVKVaDMOd5iQGm8kRjId21x+h2e2yBsGa4vxZI9djdLZxigNLvh2u1bFTrN4udmUbwl28Otq96sdedmdErv3HLyu3C2TEsGMHxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by MN6PR02MB10679.namprd02.prod.outlook.com (2603:10b6:208:4f4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 21:18:06 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb%4]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 21:18:05 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Akhil Goyal <gakhil@marvell.com>, Sunila Sahu <ssahu@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Topic: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files
Thread-Index: AQHb0L137i4Jy3qVq0eP0deo4bMumbPrrOgAgAeQrQCAFMAQgICSI2Yn
Date: Thu, 18 Sep 2025 21:18:05 +0000
Message-ID: <SJ2PR02MB9795F48C88D139220AF7B80A8916A@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
 <20250604164134.776009-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484330DB3461425B5FD4AA7D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484330DB3461425B5FD4AA7D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|MN6PR02MB10679:EE_
x-ms-office365-filtering-correlation-id: fb4ae282-5cc9-4128-cc8a-08ddf6f8dbec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KAwORX3uVGbJkfLL22o+7xKJh3JHJyYXL+G1zlqe5aJA7S7kyQihB2h6OjqC?=
 =?us-ascii?Q?WalCpHVr7YLxV/bI/08XYyJSr9aMXaTkxkeIq8vmgf1KN0RmK0hg+ZJ84P3k?=
 =?us-ascii?Q?USggCHvUxsihe7uhbcgWTf2RAKY4KuLDMB9a6EXfLnKDFGC2HzfEK6qnGinL?=
 =?us-ascii?Q?o2jjkQuwj8trOOJTAf982rEshBH1S1oFgUHiWeiW4dgxpMcyCVARJuyIDVFj?=
 =?us-ascii?Q?BlTxfFW00sU5h3ikIFnbYoRVgSUUUt6k6xuh6jJ8MiVOKKWT/q5XTXzFcNCR?=
 =?us-ascii?Q?xvrY44ncCDoTYw6E+mOCTgYOtGKs6BGBvG75HB9ij4zw9XdvhxwhWLoaqkWd?=
 =?us-ascii?Q?5ENHEM4WgaTwGvWCW/rZs7hjlDYNjBbt8s97gCjwrdeWSytyl/PnqmA+kyNX?=
 =?us-ascii?Q?1lhgot65Ga53OeBBb6+vzAPTxp4k6uCoUye8UzdOdq15RYOInZ/En6SvIqnW?=
 =?us-ascii?Q?YRDOClE3Bod98tKkw9aFe9BYX4DXaKPVhBkP8bLW6udPR6/yq8EaH5Tj5viR?=
 =?us-ascii?Q?5jZdWGjDu2yvtLV9xNoN3G9F7D3/KYnBugDsORhGez+vYFEX6qDBX7MJ00tI?=
 =?us-ascii?Q?iPDEQTnc9kM4JHgYvmp8iOnYy3n1vmVHlD4Z+gyMgSRiGko2vXFLTyQiReK2?=
 =?us-ascii?Q?fHbnIy6ndTSyLcMkH4n5CSaei3bahaAI017oAZCKBhRwC9G08Fv5M2UkosMm?=
 =?us-ascii?Q?JvOKS+xXHiAWHfD3WOlqlASjzH+wp5C+aR2/jzC1kcL8OnRAMqE+1h9KsN+7?=
 =?us-ascii?Q?xZRtUXacHVN+ATUhYi4uVI99DSGaoQEJlu3keUa9URyqLY3unsDpvXBzSYHV?=
 =?us-ascii?Q?YIJiyTu+EOuKCyHy71Vs8OeVw4YB2XwGJDSvsI4siXG0E03I8CeiZzA7l4B/?=
 =?us-ascii?Q?cy3idAhDmKGpggcgF3I8LoJ5awdNslraIIyIw2WQauNKnpC4K3FetAcalYjm?=
 =?us-ascii?Q?yQyfodrdlxG/WHAHrC3XLe7fnNjt5l7EbuYT5epn1aD0WuLJzjWdqEdoF2gc?=
 =?us-ascii?Q?n7CuY8hEZ9XkJ16rgYqhUiXO4XU9oHn/LOSbZIFJ84lt/J3zCmSH2hn8NN6I?=
 =?us-ascii?Q?uTTWi/nIrgDMiu0Q3S12epJYlD3hQAvXruR9IozIfXILhKCV1Mz5FvtFwUeH?=
 =?us-ascii?Q?0Xu66POvJTG0b19vwWqYIKykUGkOSYDM99q6of5CX5cKLLeXrXZgih74xG0B?=
 =?us-ascii?Q?1VxRVTFyqqGtMB/PZrOiDbiKt6p7F7zl8d7uR7ax6Ue/lftN+DdGGBrvHKVf?=
 =?us-ascii?Q?rLook7XOTlnz7LRGnZWM/TdFMPtQC2JAsA6mlGKSiyOBb7sZ29A9155aBwYT?=
 =?us-ascii?Q?kA56pspmhkQodtMEesBNmebGOSWSgzJHJXCu5VIzT4k1yRy80RqIjiYZdZ6+?=
 =?us-ascii?Q?aVADjgelkBQcpc4ENK9JY6P1rgusZzMy9a+mb5nWHcMrVBXl0WTysrW81l0M?=
 =?us-ascii?Q?M2pFhgAJgBw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TqOKMtzwtcJHE/iYxayJEWoBq5XRH4BfR4sAKu67xJvS1SH3V5oh8piJiLT1?=
 =?us-ascii?Q?whEeFITAzs+dK+q9Y47Qw/StWEvoXje0/m2L/9GftUlPBsiK9VOnPouNvbzf?=
 =?us-ascii?Q?UQLhlVXIH60AwOxR6L2Q6t7A6I8sDsSUTmzEC0cBe6PdrMKGJrf+4Q/wP3g/?=
 =?us-ascii?Q?xCklJZGQEt1j/hkCDd1VbholkZd2t/FHXg1GfiwEp9GjzpTPckW/WZzDTN9M?=
 =?us-ascii?Q?KGiAjnQ17MaS81rbrWmer4wK9hReOC2o0peTBaNIXPbKmqqEPZ79NJ7Wlypm?=
 =?us-ascii?Q?oS8Lx2CI/vRIOkiCX8DvGeJxB9/tEdJPj/joj0wFJ++UDPIc6ywwjd3ZLUzQ?=
 =?us-ascii?Q?QgjHXXS8viLYX/Shf5R8OY7CKyQOBPpRM/yll2acTIv4qVzJ61As3qvMpXBQ?=
 =?us-ascii?Q?2piWNbwiiETMjHTYyXVaVqeL4e7GRGDsqyq9JheIrJiqHgNojPdcTBfTXGtX?=
 =?us-ascii?Q?8cdP9fz6kR1kzO76IrvR8fXxjYOQCX2QKhPOdhXA9N23YWRo0otECdJzf0C2?=
 =?us-ascii?Q?E4k6/YsuZfsqbTRj8TySVb7mI5qAvvO+R3vBCmEisqk2V3iFr2WZRuDy+akz?=
 =?us-ascii?Q?SrPXqx8P22xRRw0qYVUSZLEiBNJ8nGOVA6poUvjjxmXpGHY0iaHyhX8knphm?=
 =?us-ascii?Q?1lyYwrD2WwGerkxUDWc6/N7edzkv+EqTNDI4rnzWmNOpfy5zV4MoSPRDvf6H?=
 =?us-ascii?Q?4jv8vuFqM5+FM9aNy07SEddmqhomgfMvNDHTarvL2A7/RLDXAwlIEdxP5aer?=
 =?us-ascii?Q?by7nRG2BsprbN4X6JqYohkEC34eggRDPl/mYbeTC7BRtriONc6GDU+a2ojzP?=
 =?us-ascii?Q?y6s9ZQFwN0Uf6BX5CweVrMBdPtfJOv4EVKF1nNHujpm3GvfqtVjqLj+otQqw?=
 =?us-ascii?Q?47AhI2UudRHul2yHnYnOLKAeGcmd7ie2yF1sO384LsnViKNYqOqHGdQFrLOS?=
 =?us-ascii?Q?fMG95spD0OnKEdfAoi4WJgrFkFEQwD05KxIvRgNCUYSkyk2p8cqvGZ661eoy?=
 =?us-ascii?Q?UZSv9s0yZPPrdkLdHts3poMbmO7lipe7mex9SK3jy9v7eeuDbqYNbaC54S7n?=
 =?us-ascii?Q?BNS8fNsiolWar7p38XqDYH4j2Gc9pZHBL49eI8A86FU3kRv+NYDcVuxskD1G?=
 =?us-ascii?Q?XP52Jgd9tpb3eTOBCEL3pJA+Rz70h12R5oPI4+AVauHto6+wmKTHo4G4mCbF?=
 =?us-ascii?Q?2qMX6vFwJ6Zco/Ld5XzfmbEfwgl7lShhbyWR3kwykrzZeSLGkrUd7Yl57zSL?=
 =?us-ascii?Q?1oqUc5Jj6JAzBrJa6zGENy0WWu5p8VQ5lEHFX0PRA12L9a8lPrYWIQnUkfCD?=
 =?us-ascii?Q?7AOpXovjgyqwPGwhUoluFL6KM9+qv8spacox7dZnehTsncegQ2MlZBg16iFB?=
 =?us-ascii?Q?8DcDp+BC81E/qbluhtChqLSWl1qzaWAqeq/s9fJT8hoDcjIWgk5XCs+Gkpi4?=
 =?us-ascii?Q?uWdJZjpleT3yNyOhCrnyZS3uNBUHuAW2kDbci5WBSFUrpD4tLnckXBMamvsg?=
 =?us-ascii?Q?+A5mGNJtudhZuadd08EAYt7DF8lkL2Smt9OXdfdev9XVI8U46NCOJNcu6QhA?=
 =?us-ascii?Q?XhX9TAxR9IOC3UjRc4DKut22Xs5pyhwyx7eT9tft?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB9795F48C88D139220AF7B80A8916ASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mGKi2fcGSgGa6VxNT9EDgnZXBN1QiA0p+he67hqQjJGe7PNo++wNpHGf3lFt7cPBiEKwQ/L+fvthUIMRXDtuJOpLlX8TJ6Pt+JrGSexKIN+g/Xz4r+sP76pHQgXWR412o0ycjhOZ9+UImRd/avPXptgdH/uaHiWh5yvsHqQ5gUTZmm0728hzLHqDqaaPSua7yOY1nZpejugnOmOWOeC5VZGZ07hjZNIaFoUy/zNQoCTO8iflTbMuHQqk2P0mpSCtsymRInEeYt5Zk0pB1N8TmjWTtxte3UDC0mX/IdcHIKYDbCLYaBR6rG3W0xj8Nj14fMzSoR6jxCINQPPdTEPbhHTDYiIaFL8f0dUk+yb6PM7XgHF9sOzBAUNUoKMmr1r61MPiKdRum53rlyNT0ZmJ4X7PLjqj0BiP2xndiJ4MoZv30JLZkyPB7si86aoqZ6aBrHYUzcrOB4o0ry2yexxPdttVUJxy1NHfWIVARiT5e9i9aGapxRVIXjN2V+wWBmteTsKeZOozlD3IgH3JpCjTBcV/v5nN1FkQrSiYoA77ld+CKwWyGxc1leW4mdXvhmhJt05n3Q8hWz3cT5vuNskJPJgOKwu58GBIxj6kZjsEE6ks2b7Ux8kVR1m02fEuFHj3
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4ae282-5cc9-4128-cc8a-08ddf6f8dbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 21:18:05.8459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XAAsxmXTFx3W6w8Xorb1GtjY8sJdSY758JagCcjbD7iplzWS7T5U8gTxASLWeLXpvuBU+bVPVmMsHn6kyiLhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR02MB10679
X-Proofpoint-ORIG-GUID: Wa_G2V0rcthUPzvmXjZcVjSwlIWBQsB1
X-Proofpoint-GUID: Wa_G2V0rcthUPzvmXjZcVjSwlIWBQsB1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDIxOSBTYWx0ZWRfXzySbU2FZ40Pb
 B7jT401AQCB9wGlYDr/PxIT6E/OJC27QicaUSmvgbcSXmiC37qpjfl8iBUvLTs+MknVHbr6CfBr
 RFdj0QEiteF1A7YTJXxyzSpRgkJkPoTwipZgAkKVTewom1ND0jGtJv2Eb+0MeetgQImdKOPBPqZ
 Q3veqw+vvghwhHKlnmMJ24hTbRAqT4qj49yEBa5OrdNb9GEqovcY3uk9AgyU42fi0Qshw/KZQa2
 XbtS/Rxb8Nd77lf3IpEokqCYb7aH0cuizwfDeg8BIDcVNAibhl/z2Za4N0TSPw/yPpJ7oXTwBVU
 YERU1t1X4C2yXbPI1Qmhmp3G6g90g3qPcQ0j4lTtjoFyDnU9VyJDRh7CKL8+YW7rDleMJjfXs1N
 SwKFw0r+
X-Authority-Analysis: v=2.4 cv=Fq8F/3rq c=1 sm=1 tr=0 ts=68cc7710 cx=c_pps
 a=tpvIgTILjtE+AOyKvWzoag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=9WY5gImDbHDRrjYijhYA:9 a=CjuIK1q_8ugA:10 a=I7LXkigzvl-gXHiz:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170219
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

--_000_SJ2PR02MB9795F48C88D139220AF7B80A8916ASJ2PR02MB9795namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Akhil,

I attempted to split the changes into multiple patches and added a depends-=
on the second patch. But automation does not seem to be picking up the patc=
h as a dependency. Is there a process step I messed up:

Patch 1: compress/zlib: support for dictionary and PDCP checksum - Patchwor=
k<https://patches.dpdk.org/project/dpdk/patch/20250918204411.1701035-1-svaz=
e@qti.qualcomm.com/>
Patch 2 with depends-n: app/compress-perf: support dictionary files - Patch=
work<https://patches.dpdk.org/project/dpdk/patch/20250918210806.1709958-1-s=
vaze@qti.qualcomm.com/>

Thanks
Sameer Vaze
________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: Tuesday, June 17, 2025 3:34 PM
To: Sameer Vaze <svaze@qti.qualcomm.com>; Sunila Sahu <ssahu@marvell.com>; =
Fan Zhang <fanzhang.oss@gmail.com>; Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionary files

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

> compress/zlib: support PDCP checksum
>
> compress/zlib: support zlib dictionary
>
> compressdev: add PDCP checksum
>
> compressdev: support zlib dictionary
>
> Adds support to provide predefined dictionaries to zlib. Handles setting
> and getting of dictionaries using zlib apis. Also includes support to
> read dictionary files
>
> Adds support for passing in and validationg 3GPP PDCP spec defined
> checksums as defined under the Uplink Data Compression(UDC) feature.
> Changes also include functions that do inflate or deflate specific
> checksum operations.
>
> Introduces new members to compression api structures to allow setting
> predefined dictionaries
>
> Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>

Seems like multiple patches are squashed into a single patch

I see that this patch has ABI breaks.
We need to defer this patch for next ABI break release.
Please split the patch appropriately.
First patch should define the library changes.
And subsequently logically broken PMD patches
Followed by application patches.
Ensure each patch is compilable.

Since this patch is breaking ABI/API,
Please send a deprecation notice to be merged in this release and
Implementation for next release.

Also avoid unnecessary and irrelevant code changes.


--_000_SJ2PR02MB9795F48C88D139220AF7B80A8916ASJ2PR02MB9795namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hey Akhil,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I attempted to split the changes into multiple patches and added a depends-=
on the second patch. But automation does not seem to be picking up the patc=
h as a dependency. Is there a process step I messed up:<br>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Patch 1: <a class=3D"OWAAutoLink elementToProof" id=3D"LPlnkOWA0637687a-8bd=
e-4f32-edd7-5be3c43f6d2d" href=3D"https://patches.dpdk.org/project/dpdk/pat=
ch/20250918204411.1701035-1-svaze@qti.qualcomm.com/">
compress/zlib: support for dictionary and PDCP checksum - Patchwork</a></di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Patch 2 with depends-n: <a class=3D"OWAAutoLink elementToProof" id=3D"LPlnk=
OWA86529131-e09f-537c-d631-302b16dab54f" href=3D"https://patches.dpdk.org/p=
roject/dpdk/patch/20250918210806.1709958-1-svaze@qti.qualcomm.com/">
app/compress-perf: support dictionary files - Patchwork</a></div>
<div class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Akhil Goyal &lt;gakhi=
l@marvell.com&gt;<br>
<b>Sent:</b> Tuesday, June 17, 2025 3:34 PM<br>
<b>To:</b> Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;; Sunila Sahu &lt;ssah=
u@marvell.com&gt;; Fan Zhang &lt;fanzhang.oss@gmail.com&gt;; Ashish Gupta &=
lt;ashishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> RE: [EXTERNAL] [PATCH] app/compress-perf: support dictionar=
y files</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARNING: This email originated from outside of Qua=
lcomm. Please be wary of any links or attachments, and do not enable macros=
.<br>
<br>
&gt; compress/zlib: support PDCP checksum<br>
&gt;<br>
&gt; compress/zlib: support zlib dictionary<br>
&gt;<br>
&gt; compressdev: add PDCP checksum<br>
&gt;<br>
&gt; compressdev: support zlib dictionary<br>
&gt;<br>
&gt; Adds support to provide predefined dictionaries to zlib. Handles setti=
ng<br>
&gt; and getting of dictionaries using zlib apis. Also includes support to<=
br>
&gt; read dictionary files<br>
&gt;<br>
&gt; Adds support for passing in and validationg 3GPP PDCP spec defined<br>
&gt; checksums as defined under the Uplink Data Compression(UDC) feature.<b=
r>
&gt; Changes also include functions that do inflate or deflate specific<br>
&gt; checksum operations.<br>
&gt;<br>
&gt; Introduces new members to compression api structures to allow setting<=
br>
&gt; predefined dictionaries<br>
&gt;<br>
&gt; Signed-off-by: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;<br>
<br>
Seems like multiple patches are squashed into a single patch<br>
<br>
I see that this patch has ABI breaks.<br>
We need to defer this patch for next ABI break release.<br>
Please split the patch appropriately.<br>
First patch should define the library changes.<br>
And subsequently logically broken PMD patches<br>
Followed by application patches.<br>
Ensure each patch is compilable.<br>
<br>
Since this patch is breaking ABI/API,<br>
Please send a deprecation notice to be merged in this release and<br>
Implementation for next release.<br>
<br>
Also avoid unnecessary and irrelevant code changes.<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR02MB9795F48C88D139220AF7B80A8916ASJ2PR02MB9795namp_--
