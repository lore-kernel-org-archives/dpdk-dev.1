Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FD606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=Rp/1R5BP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE1C140264;
	Thu, 22 Oct 2026 20:46:08 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 220274003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 20:46:07 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtZu31346583 for <dev@dpdk.org>; Thu, 22 Oct 2026 11:46:06 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020099.outbound.protection.outlook.com [52.101.85.99])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hfn6c95r1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 Oct 2026 11:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrTCuefBgewSGX2WCSntETmCwhY2kjYkiG+nOPRBJOXyH4bcJk8NOV547na6H2nr09TtfJdPlHrO9BLPcvvJ+q7xM1ZVowXP0Z0/E6swM9LwCg3sHFLQZqX82TpqxR1nS3uyXPR5jvyBMdYGRZKYD0XB/fYmyIGL93Aq/XcTO9sZ84JfNUikEzlpyji/4VdiQ+J9jmzk4PzWqB6XBdsAUqyWDPHBH5k2tn6mUCldy/ykS54N7w5Ogc6eJVbNkEqEJyiSCuWPPrnpNSy7Z/Q37goGDACk8eccvX3tlhJqfyFvKqXMRnUlt8bFHW8P+I/aE2LfnpQdD6IfCVnKswp6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqntTvrWxbZJQ/WpaGkomI55HT+sVAZKG+jfcUfGBhs=;
 b=NoTpE2Ne/lOcIxlfvBRJpiTnf8OSWU6esPI0yEysWSaoKqOp4GbszWYkRbk2cVP6vt+YAkeBssyH5UdT2gWkjMkKOD9dFb133XZTA7vVuHaWTi+mCMjBBmDm1KlRyeSGs38wuQvcbWn/fgVggfj6IVSObe2ESKGgoUXsNqcjVCtf1k1xKDnuqAufGUHqfrYJAfYP6FCFhTN0gDqNW8zv4RebCudZ15k628xeBGn2VBEyDR6pUpzrvofqR+B0HoU3lNOv2aR054LYWsvUNWLzVXkcbxEMOT+k1c3Yqs3TQsNRWYL5RQGlt7fwJVyG3G1jk7PQ9Np2u95hHwMpXdMQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqntTvrWxbZJQ/WpaGkomI55HT+sVAZKG+jfcUfGBhs=;
 b=Rp/1R5BP3kxfMlUg4AZuZHwXeFKA9/mCHodonvXNTviImp3zDXBnr7hj0VNAmHyfPxxtCS0/3t5DH6xUNR33zcutOaRpGcf0t6lsSLckEAfCqLICwAVnSQZIC6BODK6Hr5giPu1+8d4pyZ9HGzYrSTgl3IhL+KznzdM9W8hLNqg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS1PR18MB6134.namprd18.prod.outlook.com (2603:10b6:8:1df::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 18:46:03 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:46:02 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Rupesh Chiluka <rchiluka@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 00/16]  fixes and improvements to cnxk crypto PMD
Thread-Topic: [PATCH 00/16]  fixes and improvements to cnxk crypto PMD
Thread-Index: AQHdX8uVpjBxwIo7YUSCFyA0akTOZLcJ624g
Date: Thu, 22 Oct 2026 18:46:02 +0000
Message-ID: <CO6PR18MB4484B1807B8C17A6DFAA6A9CD8652@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS1PR18MB6134:EE_
x-ms-office365-filtering-correlation-id: 441a78e9-d665-4a96-63d7-08df306cb8fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261021123027099003|261009223027099003|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|261021121427099003;
x-microsoft-antispam-message-info: b7xz9Jug48w3Rtw6h/kkZOS8t6/3sP4maGvNjR+rzFqT5XUw91c6J9BflAtGAYrrikDz0snuWMIg5HUBkmc2Cc65J+7oglAvJ/B3V1XE+W5h48fTb9Q3uvCYYl/uXuEc95cEYtTFv4/zmd2UZr0mGJFsVxScJw3eFcKqE1cFny5dkyqC3pdofs8KmmxUgW+UZGtGO8BC/xhShpfpt5NO0p3aJiY9x3T8/hTFzBo3lioXw80jBIAKzUMhFDOTyYIHvX9spKDnysdn3naKN3rup29fI2l51hBMmJZI5g0F/mX7IDO1y+MvSNcKJZsp1JGIooqaB/dqzrMOKclidDyMqpYVLrM1a84/kpLPmTFujL+hQbnnTwAw/X1ykpX9pGtJy2wRQew6SHjjNeVLLQEBswCKwA7RjK6Cc8+5RD7Qn5FJ5BdHpZSXLQTMkK8wJOIsU0lnaAAhHJ+/CxyOwM3W4sLEaDXuORd5/lnqO+z5GGeBx7MvYwQ8R5TsI0dXkU/uNIZzegN+pFNZlcrP4doUp0vnH3bUVAa4WBsYaLtEroI2zqA3XSpZ0HVSNYtLLMr7839VB7RF9w4JdI/w9RG/7Y6vX59Zdp4EOkm/iL1Xvt11ePkf2e4h1Aapeef309okpEdPrELSnNdtP3nPQZKwrjnYo1/2t6GOhYGGD1A7/yVrn5Q5r+r56Mz/9q+NyTLfiTlwrk8x4k59tkwfKe8HiGyG0a1wJfq2WAqunjSgirA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261021123027099003)(261009223027099003)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f/RHCWFla6ckAuQj/Z49ryUS9E/WWa7C7RMLZvT+aq8eerbsASyoRHz5JbAt?=
 =?us-ascii?Q?9kpDth17su/EUn2xK3RqXTSzU1Nko3N6PeImWspylbR3g/AMdXnpShf9qMTV?=
 =?us-ascii?Q?i0ZfUPfxWtfjwQO1O/m+jYJC28cueIHtBeB/msJK7xX9geN0QEqqCrue80TM?=
 =?us-ascii?Q?S0joOALKjlg7OdGYN9aVZz9V9Q3D+9gOoFgEszxNf1xG9HlCEle0fN24cdLo?=
 =?us-ascii?Q?lWtFuGAz1KoeuS7O4mseYw4CWH7BMzgD/IF9Gp5xza4KW07MAx7/4IFeSHH5?=
 =?us-ascii?Q?dcnRH/9gNC4tyujLGeVtpnhGZSup5xzQ1mZlO+/y7ujpXhqEsOdM1OMhGohq?=
 =?us-ascii?Q?WTQAIQ7OBnSsbAvDJ8PJpU3wgcUeT7Goqt71v4Q06+Cc0JxmxMk2taktPo64?=
 =?us-ascii?Q?fyABZ23xpHb8TH2a+Wt7cCLe0RlWE9HYo1Fdfrz7I9ac5Mn2e0OkP92jUSex?=
 =?us-ascii?Q?b/w7JeYy1KcFbLnd2OjUFbNbKEzJeSE+O0GzAJL4KhnU3euu9fK6cwerwMb/?=
 =?us-ascii?Q?LVu32E1edmO6n/f6Zx9JZrrMjpjvUhfH+9lygeQdAENdz7v2wY6OrTSmEW1p?=
 =?us-ascii?Q?TIMWeA6ocyQcSr2ppfVfRyt2vsbYnxrcuoUzuke3zggu4tBrUB6Dlb9gO48p?=
 =?us-ascii?Q?fyVps1bnHZZb7ysVCTlTKe5QhZG0rZbRuCFZBTU/y9g7kncpMFOMUyF7TiwW?=
 =?us-ascii?Q?Fqeq61HewoVfbb7Vl4flcceUwSi9o87g/l5RUtAkGPjhso88F6mIh15vRpho?=
 =?us-ascii?Q?INVjBAUiVoimjSm+cpISiCjTkGeNXR0iGf2PvC9LoMtqa8duaRgUrklZt9gs?=
 =?us-ascii?Q?MnuG2I2+IpDmqQmVKz0ajjJhUBJeGZx3ezhsPzEqvPQpn9aTkG4pZeix+GN1?=
 =?us-ascii?Q?Qk9Wcxe2vHNt+dhoeE5GOlH7VD+PaBC8aWYJOJiwJUxmZ8Hhu97sMK5bOk91?=
 =?us-ascii?Q?cKxvtX1EJXqsQyKBRNzuVfuhzP5KGXTd4VFPc2lt4YHhWHkjOTddVN+pjPMr?=
 =?us-ascii?Q?2KCnbhkHe5qpAp3W6WrMwsBdvaJgkvtAiKSqAPsRAqwROzV1EUtI2s0VFk4k?=
 =?us-ascii?Q?SrIp/7l9kS/q9wwJ8HkxYOWjkbqkVxv1I6x3v0UHFWpp9EmeSC7dWSTHqmqO?=
 =?us-ascii?Q?ai41hC0w080MfrlY12OQRAuKz8pG7wkI6rj8QPD9akIGnv4TUirOTXjJRaFE?=
 =?us-ascii?Q?yFVzJo9TUem5jcD2Y+ZqCdq1Vsfm5fGjlq1xGYPjPQtSzq3peYczKymrzHga?=
 =?us-ascii?Q?dD15IBKp67OPLPvM7jHFFREQaBQoaWNCmtWRajaQ/iYUjvfztUFWTCZvvGno?=
 =?us-ascii?Q?LWYpOgUCLwZF87qIpY6aD86efnxrltStQtDG9FoJWnE+QJXgaI0LXr7bE7wg?=
 =?us-ascii?Q?3baUETfw9BQGwDB8h6lXTmAwEatBnEik8t7Uug0beJO82LeluWAfXjkknCuh?=
 =?us-ascii?Q?+b46KZU1MBVKxT8Rp/KAeoud9gGxZVucWEzL9NYM+xtNOBm6VofdASOc6q3O?=
 =?us-ascii?Q?XCzEfaud8xYTcNvk5dIbOyiFxiMOsgLkqG77Us2zyQBRk4RqLi2I5jaFh2It?=
 =?us-ascii?Q?0YTgjlQ5FznkWmgPNQCSiErtgfKqxUpWVs7s6eGgLXwj3Ht6TkFpuqU6TERl?=
 =?us-ascii?Q?iL/qZImbTSV02Xktxy+tQYJ7hfPEs+sepDM0FxCyNHtMl6/DMclhVcMpmm/0?=
 =?us-ascii?Q?VB8skSqdpyGDdquKpNVsEvlXnv83lqw3VpL0/EwkR2Qm48Fx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jxbuCZpSS5JZacIBV8nVY1y8W2Mt5OIP0xOPhCdtCSpIKLqU0LIrJ4joyPm+KAibaeKEN/uMLB0BxrsK2EcY3kZIwu6/sb9JIQArYVui55RBUhXMZ8E/qDmKw4NEgm0iO9LyWKAUmd1Rm4pAomy+KqMD65crunRMSP0fTs9YGAsGkKOsY1yopqLYIB52ka4xCSlS6MX7TZBTT1mNExK6yd1UFUCTKaCFox3BQrK0VnKDwQQlHtxcht2sDGRU+a0GBEsmEDxGaSL7wgzbSWwpZhhAc9Cj//s4wH7S5JhHSSvP9lsyw0t2YlxesymveUbAV5BV1fGItMaW8r7mhY+MfA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441a78e9-d665-4a96-63d7-08df306cb8fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 18:46:02.7618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iuUEQ3Y0HUhgte/pJVyG7BVZ1BVZg5efewVh2AZ4r9uXIV2CNi5gqYDUAkrMIsz0pnHv1JI7+uQbdz9W9+efA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6134
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6ada59ee cx=c_pps
 a=GGH+j3rhJf5zTl2H81NwCw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=qGgNQhG-rZxpPLqJ1-cA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfXyQNkVIhKfzvR
 toS1rOi3DxbEg1QaEipwZe5m2bggE/G/vGrgQ9aEtofY9QSWa9t34aU1+7Psy1+FnZBoLPKDJLA
 mjjI5PsgT2yjRtpnVONzd41ut2mfXwEbuuQskW8fEc2ZfwIEPYapiafytD+AsWYCJDXcSuAAlfI
 KBtqWFI2g01fPsojVo4N7Czc2tCz2sIn08C1rgxYmNkiveKRqUo+5dkiCFX36OSGIjJMQYdcLyR
 jIDoVz3TiJDo1nZSL/wf0kJLY7KZ/zE3p0Tfj5m0+k3/OyMDbvkuznmhjFl06hxDXTXLw1En2FO
 veM4l9AKwpIAxroVXXRPdtMDAgRunPdKmT/Sp1+I98/yUbsD4+310kEJm64vfWp4x03glUcq7CE
 lKRGDdRDq85O/NsCCTLcncpTHlShBgwFs2NMw+nsBvNom2v7mYxp7o9xY610Jj/SIeobTYiNvbD
 yJKaJGUZd3dinDkt2KA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfXxJc6F4SrdzSa
 4q7dnKumXkyrKcla0PqwLxvOLJoCo6T8IEcor1zALRRkvMpjqpkj/43/NG4mlHfZ36hwVvU2Rh/
 mUzDex0iSuoZREiEl0F0ZMiDLzl99LI=
X-Proofpoint-GUID: xnHr2RjSS7YAAxz4vHycT8oVZ5v1vivm
X-Proofpoint-ORIG-GUID: xnHr2RjSS7YAAxz4vHycT8oVZ5v1vivm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Tejasree Kondoj <ktejasree@marvell.com>
> Sent: Monday, October 19, 2026 6:38 PM
> To: Akhil Goyal <gakhil@marvell.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Vidya Sagar Velumuri
> <vvelumuri@marvell.com>; Ankur Dwivedi <adwivedi@marvell.com>; Rupesh
> Chiluka <rchiluka@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; dev@dpdk.org
> Subject: [PATCH 00/16] fixes and improvements to cnxk crypto PMD
>=20
> This series adds improvements and fixes to cnxk crypto PMD.
>=20
> Rupesh Chiluka (11):
>   common/cnxk: validate cipher key length in IPsec SA fill
>   crypto/cnxk: reject truncated TLS records in decrypt
>   crypto/cnxk: validate TLS xform and keys before SA key copy
>   crypto/cnxk: reject oversized SG vectors in raw datapath
>   crypto/cnxk: guard trim len bounds in TLS 1.2 MAC trim
>   crypto/cnxk: guard trim len in TLS 1.2 MAC trim for CN20K
>   crypto/cnxk: validate TLS 1.2 MAC trim lengths
>   crypto/cnxk: bound SG segment count in packet iov builders
>   crypto/cnxk: bound SG iovec index in mbuf walk
>   crypto/cnxk: add cq_ena devarg for CPT CQ mode
>   crypto/cnxk: size CN20K IPsec SA by context length
>=20
> Tejasree Kondoj (5):
>   common/cnxk: use context invalidate for cn20k
>   crypto/cnxk: return HW CPTR from cptr_get for cn20k
>   crypto/cnxk: enable cq_all and allocate extra CQ line
>   crypto/cnxk: fix CN20K CPT error recovery
>   crypto/cnxk: enable ctx cache for cn20k crypto
>=20
>  doc/guides/cryptodevs/cnxk.rst               | 16 ++++
>  drivers/common/cnxk/cnxk_security.c          | 15 ++-
>  drivers/common/cnxk/roc_cpt.c                | 97 +++++++++++++++++---
>  drivers/common/cnxk/roc_cpt.h                |  3 +
>  drivers/crypto/cnxk/cn10k_cryptodev_ops.c    | 36 ++++++--
>  drivers/crypto/cnxk/cn10k_tls.c              | 33 ++++++-
>  drivers/crypto/cnxk/cn10k_tls_ops.h          | 12 +++
>  drivers/crypto/cnxk/cn20k_cryptodev_ops.c    | 39 ++++++--
>  drivers/crypto/cnxk/cn20k_ipsec.c            | 42 +++------
>  drivers/crypto/cnxk/cn20k_tls.c              | 73 +++++++--------
>  drivers/crypto/cnxk/cn20k_tls_ops.h          |  6 ++
>  drivers/crypto/cnxk/cnxk_cryptodev.h         |  1 +
>  drivers/crypto/cnxk/cnxk_cryptodev_devargs.c | 28 +++++-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c     | 10 +-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.h     |  4 +-
>  drivers/crypto/cnxk/cnxk_se.h                | 84 +++++++++++++++--
>  16 files changed, 389 insertions(+), 110 deletions(-)

Series Applied to dpdk-next-crypto
Thanks.
