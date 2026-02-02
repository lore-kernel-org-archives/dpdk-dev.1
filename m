Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BB5E73151
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E930E40A6F;
	Mon,  2 Feb 2026 10:57:55 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 078FF402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 10:57:53 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 611MJLVG667603; Mon, 2 Feb 2026 01:57:50 -0800
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021121.outbound.protection.outlook.com
 [40.93.194.121])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c28mxsf24-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 01:57:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb78pBfGWr01+azPKcxqiy77+1BXcoXfzRUjA3DVHhER/+1ycfHlNNUs2rVy9x3rMo2jLl0EeMwJcEE7rqNlHFWvHHqx2NYQLINYl794xXd4+QPttSCjroefaKMJlcMLFa/555iXDn9C50Gl15RPAQOPDqxRHyQCNy54t6ZQJkHmdyzhrNTBi3y5+vw3xKS1Oc256tLQU1bf8KXCMssHkpn1LC7ZIrrN1s/CfUNCMhfdpl4DPfjols8fUXbr78s/TngpeOlO33oqXhP/+4XBcxqYylLzBmszZanwSNvQVtwv/G8yeU1vn3NeYix1J3Dijci4m8koZD46IQPTM6xe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8d2LZeAoV5FYfaAg7Tf1Ov2uwpppm69asTbgozBb3c=;
 b=HNgpFZ23EV5xtQP75i9sXmaE3f9mT4oeKcNDOY6VYNmwkdoRad7rP+AQW98m9aWXErv0Xo61Xp3fYqhHxdsyWtnzVKx4VOWmk5jRGLQLZJHUGfa4fOeAuJ4HdtbTq2qjaW9QFyGe4ZNcDMUNqMV3O90GokPzGIBmEje/XTacwK6imrbHViJFrafoyrtjklNpQPOU7RWR5PkQJbE1nw3YdQDJS9B3dqIAT6oQdU+2tZDTfEuN/GwDTiW2EJ2vteBuiWzrOl4FFfcP7MTjTV4r5Ujodvx1Fbbs6J19TFJn4yAluTRPeYjAa88XM/wHEvKLAid0S575xmi/m3g01Er8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8d2LZeAoV5FYfaAg7Tf1Ov2uwpppm69asTbgozBb3c=;
 b=qr18qfxJWLkSuTyB/gu8JAhlaTxv3fM+dlzqt+IZi+nzM26btmJkV8PolIrWU8eSCUNJcocxGlWP06M7ZfzE0ynMV2V7ztWumBSHDG4DwgPodefZbfp30Dr+ABixwNtBD8LwSHXrqXQ4WbcYO9YFO1friTJ7EeAvOlTzKC5Gaig=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 MN2PR18MB3512.namprd18.prod.outlook.com (2603:10b6:208:26f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Mon, 2 Feb
 2026 09:57:48 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9587.010; Mon, 2 Feb 2026
 09:57:48 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, Jerin Jacob
 <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 1/2] config: add optimal burst size configuration
Thread-Topic: [RFC 1/2] config: add optimal burst size configuration
Thread-Index: AQHcXq4VsKPYWcJQ0Eu6wbp/mlvALLUEuLeAgAARbwKAasypLw==
Date: Mon, 2 Feb 2026 09:57:48 +0000
Message-ID: <PH0PR18MB408654829B824E2BF55A1BF7DE9AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
 <PH0PR18MB4086DAA3DC6D60E7790A3722DEDEA@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB4086DAA3DC6D60E7790A3722DEDEA@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|MN2PR18MB3512:EE_
x-ms-office365-filtering-correlation-id: cabd7698-eaf4-41cd-5a42-08de62418555
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?j53M6nE4uVXjg+rK+KDSaSwHdChKyqRsRoFzVpDL9lm8z6u4K4VUt4zC3e?=
 =?iso-8859-1?Q?rNLrQ+D8XWHIr43A9WD2Uk+w/haFIxUnO7bx8+prCbB7gIya6tHJbC6LMa?=
 =?iso-8859-1?Q?W9Ua9LUxEhTSS66AL7+R6BPJsfayfjws0PT4lqloz6fMXq5ZBST8Ilux2h?=
 =?iso-8859-1?Q?/+1hat1EMYo3WaNYJWZ+8Q6C47MoYqum47dnDJYEICyhw1VTrnDTGF0dCB?=
 =?iso-8859-1?Q?C3JErjiYfU4/Xxv9yQOf6IPpdoGD6OYBMB/WOHWO95CBWB8/s3il0S7LQy?=
 =?iso-8859-1?Q?m7CLT5N+b223vXERzX85yWihJwLmRUVq9QyiRggbDnJ5ReKTuD6umkgmrz?=
 =?iso-8859-1?Q?TNUVuyAgAmEH5NKIKre6l9myiPyPkYPZ+QJfT+0N9YliWLcS9Fy52jCwew?=
 =?iso-8859-1?Q?5qxHv5XBhHpTXxjcAh3MJ4T9Ib8WV3dSVsiha9I4PHwtn3m1hcw1sCtFZG?=
 =?iso-8859-1?Q?KfHlJpc3T23zRPa4DrG9KiyugpJrBh1ksdOdb3g4QGJpBdD4TDRgvfTnri?=
 =?iso-8859-1?Q?vYawmAKsVZxhWY4mECRjBGNFi0tIvi7+i0GLXPXyTx+7e6O7tnr1MwGM4c?=
 =?iso-8859-1?Q?J1p7LAqn/AOj66UNXFB0tRbCfScKeFjU51lMnzBnL/fWZk0hhkgqXKFJou?=
 =?iso-8859-1?Q?DDDu5LvwmJMgurWIlsflBtXdzRELnXmFKZupB4wTF8VQF2aJvPe+hiUAji?=
 =?iso-8859-1?Q?BjFjgd+egk7Lbr2nHLR/r1HhDNnZCeFSY28L8c96mny3ska+xVUl4SssQM?=
 =?iso-8859-1?Q?VSCUxQNLJCWqghyCWmbDytJYZHFIl05fxyBJ5G2gtEegogVkXmEItPC0er?=
 =?iso-8859-1?Q?zz+0mMnZaMtxsHuugwCLUAN90e7ctmWU6QF6EkEd9knwF/9+KFfb++LypX?=
 =?iso-8859-1?Q?wjIKIGDcPFmwyas8oSnfESosueHj+T1F03Xn4SDcF3rJJjhv0qasLqNW/h?=
 =?iso-8859-1?Q?brMz6cxtRwl0dJsiAncyqhmKh9HF86iDGPepcku6OrTJ+A9/fzVudWaXqL?=
 =?iso-8859-1?Q?cF+9ClvZFFApeYjfTRmRPK0jkBDEOIHWtu54guG3S+u+xqeGWjc1tk3Mho?=
 =?iso-8859-1?Q?Z2vLQMeGPTt2VEj3fFTv//B5/qrg5FQzTviDcrzB/+4owoQTaViIKZ9+7i?=
 =?iso-8859-1?Q?96xxpsXjqHV4sCkuOULd84edX5HWVtZurqRt+tR1brmaMAGfDhDWXjw2L2?=
 =?iso-8859-1?Q?VvoCm9wL/z4utzMDVSdhQHt9DWc/crERvsqK/iNSwvRtfo9UgTesoxNXTS?=
 =?iso-8859-1?Q?C44/LbKBtPvLkX5tCWacSt8UASzsjF1ryl6XA++7QZIJUE7Bq2K/06Mpgw?=
 =?iso-8859-1?Q?iV1dhJzAnBw/SjPsZAe3RbF6Lo4/f0MxPL3pt/tY0oAhXIGV0tbq73OqPK?=
 =?iso-8859-1?Q?rUJEDXyDspwHoT6si191VopVUcXHByWCUM5mRRkDP/0+9O21q8Prz6f4ZJ?=
 =?iso-8859-1?Q?+sAxpr7XXzbXtoSbvKM5gNw9J8pcdJ1mbjl9u+Q4M5eoc9B+uh3nvkhE8O?=
 =?iso-8859-1?Q?imklrFH/uo+OvSEr+UYDT8yfEpyeaV8JQ5eu4SgYczYpsHnPf+v9Bo6v1C?=
 =?iso-8859-1?Q?DSktKODQ3j0/fW46fl84WJtwCdQyKp536F4YpRuXDXZzdkYZ4iecjHlSpk?=
 =?iso-8859-1?Q?LipWZgg1WGX5nzCqSgiZr3OJYnjAZLuhHH5i1FtWNwCbjeiKPDsdIAvura?=
 =?iso-8859-1?Q?dBxq9b2XupAWSc1EqKo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RLwaBm21z4Ygdjt+ESMJ33nJjRUT8nSuovNQfQFczuU4tlWyrf5fiiYWii?=
 =?iso-8859-1?Q?aN2fx5uIVG3hitR/e9gScu3VTeg5+BFmDzvEoDX2NrE8RGEwcxp/mnJDGY?=
 =?iso-8859-1?Q?30hat8zObvf6L2nV8flOPky9rjCq8UQ+Wdgl8ZimMLnFLQDYf7C6IdvIOX?=
 =?iso-8859-1?Q?mtyzQUYcPC7w1qlMD93ouvpvzigSsEagKwyi8yB6BS6Rgts26g4WJ6xvAz?=
 =?iso-8859-1?Q?l38gXIhuGdehRccDtQ8Da5f2Hgv5kV70KtpTyaIp98tKxqmW+PWt7UXLVm?=
 =?iso-8859-1?Q?ZJy5nJu7NGIaUeHgGuyaTpL9pMHUObZ9wjAoIFQaa3B+JKJ6Xsc03vWEzf?=
 =?iso-8859-1?Q?NEYQvp0CpcBy4CPhVa6tscvMxxQkQ9N8mP5+3dtBVydB4iZbVE7IH53CsF?=
 =?iso-8859-1?Q?okWBhMwUnhkKwaEogHCUpw83+FZuIwiyBOTz3n9+BECcdjd0ZeVuMoc7tn?=
 =?iso-8859-1?Q?EfUAcObkJeDHH1XMv0r2tbn8QQlBg2p0p9rLxSpcr+JAzwt6Dli0qlGFN0?=
 =?iso-8859-1?Q?ic/VnPTA4YIwxmnmC1/rFaTTuWJnNShMKiwwUvMqipGNyRJ/3GCwkacZ1C?=
 =?iso-8859-1?Q?2GyOiZ6IUmdUXDB6hJLummzsjthFge95Ruz7WJkLS1g10vDrEMFyDgmjrO?=
 =?iso-8859-1?Q?9sGGoWPED7bADPUOVvLoCSxXiK4eAtfAqYYoQMPRxYV7PZksDT5ILWmRhg?=
 =?iso-8859-1?Q?TV+LZqRkCahh6LPccUj9Lu5jaDH4DftotoFoIKUW0R/O3f9qv4i4bFqZzK?=
 =?iso-8859-1?Q?3BnYSJJl7bLWhLfBQO7geoLsfj8w/At1ShbLsqS5qpcJbZKoAoo6HUbnlu?=
 =?iso-8859-1?Q?EP7AVJ2xkIJF5WVJwhQ6IyV/pZLBU055Hr7zq+/d2cqasK3wO03dOJQUBP?=
 =?iso-8859-1?Q?QzlvKhWw2e6T82jB2Hh2H3GSRr4CE8XmOBP5TgRnrlp4lyaOFUclBWSXbA?=
 =?iso-8859-1?Q?n85W2jvkCqOVb4bJjbWQYRI8cFueuV0TTCVpyI7PrsI/hlEujFaDQS9oNM?=
 =?iso-8859-1?Q?5mYiOQlYUBq0126jaIPMVPckGD04ZejjyKl4MoxxfGVPfvaMW12xmdBzbl?=
 =?iso-8859-1?Q?RUs6o0oFjh/fg+hZXw2vkUA3GFTBvAO4r0T1Or6wTfrTlsi7h7MaQqN2Yk?=
 =?iso-8859-1?Q?ehRPlVOYA4RBXShW5Cvyk+2Wo+okuimGKldgGGRh7RjWhPKdVipiJkMhtc?=
 =?iso-8859-1?Q?3SPJlA0vnFncNQYSwyVH9iEVTana58P06Jz2WCHEyVIgDEPib5ZYJrTEqj?=
 =?iso-8859-1?Q?gyiKmLc+veF8/xs4z8wEoXOxqlrtPpwBRSv02yimV5RWN0TNYWt2S6Rr3P?=
 =?iso-8859-1?Q?r9FJZk77e19Jfa4CgjLYSuWbrAO8tkalaaoYkd7650YXeL22catabEm2sy?=
 =?iso-8859-1?Q?ph0GiXTlKZtQpZbgkqaJ83h1oythyAilUe51NL5l/ofrt6dggirOkBmnV7?=
 =?iso-8859-1?Q?Q3eqxM/giglW9GONYITU8ryZPDAgLDV3Jag0qJegsWdY9AReFuA95wkoWv?=
 =?iso-8859-1?Q?tIhKhtya68mL8ADKTIwIpZOMLWNMGRwjosW4ziMkJaCL5xNkY5iouK/rHr?=
 =?iso-8859-1?Q?nj8foMFlqZDCL9qO1ZZMLrtpD4vmZD7nuIjFbYl0yBgXY3Um7JNfk+suBf?=
 =?iso-8859-1?Q?anORBUpopdOWaBDw5MkiU6MhXAoQUqYua6UsxUOoidlZPktz5yF+2boxs/?=
 =?iso-8859-1?Q?yhwzFpGvsWfpXLetR02fUHo9PAu+nLukDndmwbun+zM4gwDOQ1Zc282tkP?=
 =?iso-8859-1?Q?7AKOF+tpgaGGLIHWA/xJUuu7L8CWDjaUqhmKzjKkVsBW/d0qkNjdJlKihD?=
 =?iso-8859-1?Q?7vWJ1lbSHw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabd7698-eaf4-41cd-5a42-08de62418555
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 09:57:48.2455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7Mht0Cl2dpSgdDzOBB3aCzPu3aJib+9f0xwUo3fzs5S+Ew/6AS8gSWSwh9Qw1ccqMH08L0Vq/l3sPiUaUHZSuM0BhnzBZcyiMsIjKlx2Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3512
X-Proofpoint-GUID: g_h5NglBBehYpYUvBpe6OVin9sy93Q-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NCBTYWx0ZWRfX/aWCDZz/u1YN
 oms+QrgtZuYJuox3170tbnu0f+1HxisGfZNwNOZi0R72vqWjBqKGDHFOB0ZGgbXCNi3YZYR8PRB
 CUVDY/VFD6deGvW/gU71fxWr9YADhltZ+046yjiLVQKaYAURb32c5Q92kxHldDpFnx5skDqN4pD
 8KlWqf1YbJpCyaa/8RA2e5Tmn8bFRqk2awCsIkpgATlmTr8QdROKRo3QlDNOijS4ATuTp2SvQ7s
 KmKBl7xPH7GOMUIKOB+cpRxh8CnqKGJNrD+9LUCvqTeJfsvWMd9LB5pAbxnz/0Qhi3B/H6Jhajl
 rFQAF0dAHZNQCgZXbHir7ZlWrCr8agDruoyBAUVhuDdrqBaPLJ+smy29o5PRCfKVs7ADvtH+024
 //W9Vwtif0nnpCD8Ym5tderF0G8EtMX1Uc65HN4ByBwetQFYKyTs2btysa3z0xPCfXOhhySYv4U
 F2ItjFK+FCTMgDtok7g==
X-Authority-Analysis: v=2.4 cv=UP7Q3Sfy c=1 sm=1 tr=0 ts=6980751e cx=c_pps
 a=GRNSBXvNJw0HWouCR8jgEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=Lre_9A2vaikyXJUvw1cA:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: g_h5NglBBehYpYUvBpe6OVin9sy93Q-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
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

>>> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>>=0A=
>>> Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the=0A=
>>> optimal burst size.=0A=
>>>=0A=
>>> Set default value to 64 for soc_cn10k and 32 generally.=0A=
>>>=0A=
>>> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>> ---=0A=
>>> This improves performance by 5% on l2fwd, other examples showed=0A=
>>> negligible difference on CN10K.=0A=
>>>=0A=
>>=0A=
>>I support the concept of having a recommended mbuf burst size, targeting =
the majority of generic applications.=0A=
>>Making it CPU dependent seems like a good choice.=0A=
>>=0A=
>>It should be named differently.=0A=
>>First of all, "optimal" depends on the use case; if targeting low latency=
, shorter bursts are better, so "OPTIMAL" should not be part of the name.=
=0A=
>>Second, I would guess that it only targets mbuf bursts, not also bursts o=
f other operations (e.g. hash lookups), so "MBUF" should be part of the nam=
e.=0A=
>>=0A=
>>Suggestion:=0A=
>>/* Recommended burst size for generic applications, striking a balance be=
tween throughput and latency. */=0A=
>>dpdk_conf.set('RTE_MBUF_BURST_SIZE_MAX' (or _DEFAULT), 64)=0A=
>>=0A=
>=0A=
>Agreed, would the comment be enough to say that it is a recommendation and=
 not an enforcement? or should it be added to the macro name?=0A=
>I am sceptical of changing burst size of 64 since most of the applications=
 _today_ use 32, might cause unintended regression.=0A=
>=0A=
>RTE_MBUF_BURST_SIZE_(REC)_PERF?=0A=
>=0A=
>><feature creep>=0A=
>>/* Recommended burst size for generic applications targeting low latency.=
 */=0A=
>>dpdk_conf.set('RTE_MBUF_BURST_SIZE_MIN', 4)=0A=
>></feature creep>=0A=
>=0A=
>RTE_MBUF_BURST_SIZE_(REC)_LAT?=0A=
>=0A=
>(I am bad at names)=0A=
>>=0A=
>>Having these standardized will also allow libraries and drivers to optimi=
ze for them, e.g. drivers should support bursts sizes all the way down to R=
TE_MBUF_BURST_SIZE_MIN, and can static_assert() that the RTE_MBUF_BURST_SIZ=
E_MIN is not lower than supported by the driver/hardware.=0A=
>>=0A=
>><more feature creep>=0A=
>>rte_config.h could have "#define RTE_MBUF_BURST_SIZE RTE_MBUF_BURST_SIZE_=
MAX", for the application developer to change to RTE_MBUF_BURST_SIZE_MIN fo=
r low latency applications.=0A=
>>This will let the libraries and drivers optimize for the specific burst s=
ize used by the application.=0A=
>></more feature creep>=0A=
>=0A=
>This is fine with me, we can wrap it around a meson option to avoid manual=
ly changing rte_config.h=0A=
>=0A=
>>=0A=
>><rambling>=0A=
>>Intuitively, I would assume that the optimal burst size essentially depen=
ds on the CPU's L1D cache size and the application's number of non-mbuf cac=
he lines accessed per burst.=0A=
>>Let's say a CPU core has 32 KiB cache (=3D 512 cache lines), and each bur=
st touches 4 cache lines per packet:=0A=
>>2 cache lines for the mbuf=0A=
>>1 cache line for the packet data=0A=
>>1 cache line per packet for some table lookup/forwarding entry=0A=
>>=0A=
>>Then the mbuf burst should be max 512/4 =3D 128.=0A=
>>But local variables also use memory during processing, so using a burst o=
f 64 would leave room for that and some more.=0A=
>></rambling>=0A=
>=0A=
>We could probably read `/sys/devices/system/cpu/cpu0/cache/index0/size` in=
 meson and calculate the number of lines and burst but, I dont think its=0A=
>that simple, for example, CN10K has 64KiB L1D cache and anything above 64 =
burst size causes performance loss.=0A=
>=0A=
>Thanks,=0A=
>Pavan=0A=
>=0A=
=0A=
@Morten, Any further thoughts? I can spin up a v1.=
