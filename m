Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE590606A325
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=clHwPEL+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 794A8406B6;
	Mon,  9 Nov 2026 20:58:55 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 257D640265
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:58:54 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HXbgW1270258; Mon, 9 Nov 2026 11:58:52 -0800
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021095.outbound.protection.outlook.com
 [40.93.194.95])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hujp6rkfs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 11:58:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqxhgKk/rOCUVkJrEEbA+Qvm9uKGvAvzW3Bdhrae7vCVXP+Ss4itDyXcwLVleI90toGtk40B7mQmtiI3KQTWD/oClYQs4x7Ab54zLEyFhKv3dLOgtgLxQ/CWenQ1bIJ353n+7AFhcMoz4KjQEweGRwe32YiCc8OglNXUTCPez7wdxf1Uya+BkCKocNWH1dtWc6sREMPiuFzBO7hUfMKCnc6emuk0pNrCHSkwlNPFfunUt4N744yM7HRnYtuHs4qC+rMvngf/v5KrdKBm7Hr9eyctQx4NJ0nUYgfx9d+R+7STRkCkMluNFiFjE094aMtQbnePsl6WmSjv4QOSglWFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cRfR7svau2T+72x1TXgBTD7eTWDMNnePTpYVz0z/c8=;
 b=gRbjTztfc9m83LGuYLPiuBzwxHNAK+GZGOe+VrCxJWnNv3Dj/iuu7H3yodLKaaoJtIsBBEc1V0K9ghIhb+kHkOXLHMRV6CJ9/aDx6XdokVjhBd6bjyAUV1KzWCV3y4dB1NHPZYl+RnBVswzJH6/p3WLBf8Y4dSNar2ZF2ivawBaKIqR9n9Jbxua1S96iK2XGwofhswkbCu4qwRwSWJhuaASDMt1SrctcRz3HbJDUqcRv06hOBnpOVewuqM6GMSuTNSuUfK7oh4dLGQlUmPMd5eImsPSpqaZWJTGVxySXSkh7wGT9906on8HAB3xxF3dUcWYfDj1hIx8BGO2EeMX1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cRfR7svau2T+72x1TXgBTD7eTWDMNnePTpYVz0z/c8=;
 b=clHwPEL+mO7o46bhtmrFRELMXz/fpz2p0mjzFfjRgDU8i9tc1XuVfGdFPe4mHyJRB0FUIEq0HBhSHEIUmmhpVKHG3STIU2to7V0CE8LH33LCRb7ZJqoboo4Epksb6a3Nzd72f2P0GWo8+5I/sUfJ8Ft0C+DT73b320vFohDT/GM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH0PR18MB4244.namprd18.prod.outlook.com (2603:10b6:610:bb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Mon, 9 Nov 2026 19:58:47 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:58:46 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: RE: [PATCH] crypto/cnxk: improve RSA private key validation
Thread-Topic: [PATCH] crypto/cnxk: improve RSA private key validation
Thread-Index: AQHdV+J6VlcuJIEzeEqDJaYGbetssLcmWZhw
Date: Mon, 9 Nov 2026 19:58:46 +0000
Message-ID: <CO6PR18MB44841B181723FF50B260651FD8732@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261009113629.2597960-1-ssarananaga@marvell.com>
In-Reply-To: <20261009113629.2597960-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH0PR18MB4244:EE_
x-ms-office365-filtering-correlation-id: d32b6f8e-914c-476b-fb9e-08df3e9bdd8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|3023799007|10067099003|38070700021|11063799006|261028144727099003|261102123227099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003|56012099006|261026140227099003;
x-microsoft-antispam-message-info: r4F9YjQnD1oAylldhHJQiIv8drCsHrNNdKZpmFNRnUZRaZJkHIeTXYpieag/2OBoX4PmySK4nei4cyJUlpMOT3HC7V50KwNib9VviUFxlw8IynLRBw0AXMwTACPDeg5tc25JwVfFHn8MKBD3wDUXFusvgjSHH7IC0vukdmlyYvL+WTf5pTqhVbfwbKW5060vHrs9XifINTtB5/SD9XwMW3H+6RZ3XguREIjcPmBQONFDYobGDvFEd6g+2DvQPB1T9tofxqAL7S6LrIHTDriXo/j3v/wRHRfJL5I/1zEGRAN86HwRC6E8uD8zxP1QkdFmBvRwAR9SXeMOp1u45pZEF/4lDqEBBKQd2NnpaWrdK/I5xMcob/wTWGuurNp0dVwyDd6YExSZdSNz1ryn/P/cFXS35ZebAlQIhFg514IHop0jyUZWck3Y/fLrbxTOj2zlchkIEbU84Ry7+n0PxrjUvvC/QPpbFEsPAJ5kGlOtEiOMas/YSlLwUTwct6VxzvPCoSUs3nyOwMEpy3TjVJF5i9NvxioKDURYeY55aSCFEsKeCy9EVlCYLoVg33Dssys7r3siXxkHCOC/EU0Rsf+2Qlb2FrLGOizAZ68c+TV+wXmOaFa422ilRTMOm4heYhW5UiBEiguVsTdy7wHadrNqGgMYA6Rv4aMMr8fFWvnPJdo2oZHd6P2dRQ/3s+26aw4DK6wmP8eeM3HdvCVr39YUqNH1nnTEPSGb15LA2vPE7x4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(38070700021)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(56012099006)(261026140227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wgUHNqm8tFfh2M/MDOsv0OaU3vnyhg5sXk6oj1j6EIZ/PVfCmb8bXD5bGjUy?=
 =?us-ascii?Q?okY0SwHALzNURXZ6kPMcVGBjcTGulplfxQLVnrx/7HtAyf7gZmSgVFnBbRBS?=
 =?us-ascii?Q?Wz8wyGiIL87pGSjdnpAFeNIHH8J8yHn77sxqVx2Lapbm23oSwIrTmmG106Se?=
 =?us-ascii?Q?uEfPYHsxBrx9rMW2V6q3paAj86rHXYJv1WTLeYNogV+oMR2T8UlgKDCvSDnw?=
 =?us-ascii?Q?itOWzG7W8g/J2w9T/5ICNyFedv/CNMIerVMJXsY2ItMK6gKetQP5AKFGW+fk?=
 =?us-ascii?Q?nGHeYPHR4ypuAdvKbV3PLUIn85ztqfxbYUdGLOJNOnXwjZYJchDzJUYLMkvN?=
 =?us-ascii?Q?UuBkN35xf4mjd/pPiPGNBBx+Hz+WwsXB/jfmL8G7mVJCILFmgAPOI/n2SfWm?=
 =?us-ascii?Q?1cyE86ILST47/9VdZWsN9iQFiYqpAhV7mZ6kVGU42jpsL7cMR5aQaa0SvgNQ?=
 =?us-ascii?Q?gaxNW8GOfDU6MmbAbrQSzhIug6x/iEt9Rh6b5bkxRHbGcuz4Do4lm83LXWCU?=
 =?us-ascii?Q?lBFHCIEAiwpwgdLQV4dEsRoc4c+Biz2lqA1lzqPYrxhc3DIzRznysPF4hG64?=
 =?us-ascii?Q?v3seLtsqKxkCZ0kI6q/TD4EfTo/ErgwiZ2icfiep1mlZJv51KMxQupya1Eb/?=
 =?us-ascii?Q?A0H7AGG52VM3jppsNw/oEaBy3yeVtRcRRvjjRykR3CRgK+B8Cv7KN33bwi1n?=
 =?us-ascii?Q?UbCB+IQnK010ADfjgiAZtoI3NMHWSx08FUTmriBTmy8wr8OGczWZeQzCGCXp?=
 =?us-ascii?Q?GdSdBcapreQ1WnzOl8SKRRFDs5zzmMkcowgKi6JcCLJI0uKETgT/bUUmJmaF?=
 =?us-ascii?Q?qf28Btm2cyLhQ4+oaTR0etimeSVt5Z5HpmEvDtuBKOQ/QoJ5qlrwyWHgJuEG?=
 =?us-ascii?Q?N5z5B1F3lNn41Toir5fZxNv7YDMa7yRgvvL9sU7ZTuoIy1KDk7MucZN6Np5g?=
 =?us-ascii?Q?+QL5JCjRLOPknD2l3zyihFdZ24+SqSn6XQsPK97OqXU5IFGR4zFmNXgQhgwu?=
 =?us-ascii?Q?SZwpN1e16Tm4YGUZnWmRs7EGjAlL2J0Oc4X75mTSnygqvO6sZgsLDDFz4pZP?=
 =?us-ascii?Q?1Iuj5W9VcdiMMybG8olIBXg3hypUj3UP1cogsA0H9vsva/JGGlh+Rf1UCpwx?=
 =?us-ascii?Q?hwnt0JGdBvm40pkFnOsLPS20iXuOA/aN3mWewGC/yG/koDJI/NxLnjd/U1/m?=
 =?us-ascii?Q?0xz2qbR17ARCSFmvGqYq6mS1mXs2Ga8Ven1kWrhCrv6UUrkdB5209PkUBc6U?=
 =?us-ascii?Q?BJyGNzQj6sgVHp5hxZtO2WnTtBe4QdlX7Q8yAf1E5BpQwjnTE3qG70OrLsT/?=
 =?us-ascii?Q?znBn381PoHPpVTkeyKaEJoHDrbk/NR3XG5B0XVXhJz8poS5DPB33vRSqiH47?=
 =?us-ascii?Q?Wi7WSp109pF2rjH7k2WWwVrs42bg1DaF7XUCRpYGhFuFaB45fSGJ2qLzrbpH?=
 =?us-ascii?Q?iznbGsnRUYSrjh8WxirHKrVSfxH8ZG0tPk+IlP76qWsPBbT9ssCdGp9fXtNh?=
 =?us-ascii?Q?NKx+P7mRwyJG8iGuOVQDe1vIbu7fK78aU7K7/mZoBfF9BnAcJA4CTF09Dsqo?=
 =?us-ascii?Q?BoYQh6BGzIxqKDJP6BJp93l1d1XzC5llu/WodVWlVpjfGWu27MHzfV/By3/m?=
 =?us-ascii?Q?hDd5bGSKwMdUZ/wnEHHLeKNiuwhxBArJrZ6Q8tk1Ir/MQj79GwbLYETv1jKd?=
 =?us-ascii?Q?bo2/7cl2qo1zaM3X/Njc+UPRhJU9jUm7neDOcRXJyiN4G26E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KAo14FZ9JQCg1SoFl6sxxBsYA0DaVcrdlYjzGQv2f2pSzKZc/b9YNXd1YX2BbCyGw/XESs5fC+OA+dD/n0eQhndZxlhwLxUJfB6LjgHD7bD6rKCrEUUN4jK+wdfBbvxnGYTVC3UupGFob71qZopJY6GA5ILsAprICRB7wplizUYZduOLpCt7fQ0FvbL0W1tiA9pto1M8QzlmeXe6gEbGzlEEyfadxMn0Vgr9JdkpfFmYzr1LmVEgwJf+we3TyiWggXdTm4HAcwpgwuo1FjPLlK8JoH15TZFI8rYOUgqxzK+0oSnlFN3fxy3/aiJDEtmlJZlTYzVNndsdYm/bZ9WBgQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32b6f8e-914c-476b-fb9e-08df3e9bdd8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:58:46.7819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRfibG3OfzFX0eoAbZ1pKiD3+elPi5O6HWvyNkkgH2RcUZBKxWgreUrCD/RLeIw8gWmYLYgG43J4isB3yU79nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4244
X-Authority-Analysis: v=2.4 cv=d85gWhjE c=1 sm=1 tr=0 ts=6af225fc cx=c_pps
 a=KKEi/m33+wCRTXJOHCufbA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=i0EeH86SAAAA:8
 a=Le-shVUqJ4Uv9s_SEikA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: J84Qu5L50x7XHbZJ_p3KzLOIyj7uoALD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX0qSD4ED6sKtI
 MfhYAcKH+TXk7VTz1D7EiTVM4IUSLUVcnNjNkB4CCucPqNk3OU/yRh2RjSSzdn1KeKEZ0j5HgAG
 AoICdoVNWahkoYFXAl24dQKmj5sXQ+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfXzo3xZyiVuIJV
 ov5utaoKYdpBPJ8Ny8sglsTIbPkICBNRCZJnFiFxII/HsQvyQjgK0esgEVpf09QKH/ZLgrYxU6H
 cO9x2ZF6uSoUDD2Ju+8p1BFl+uD+PBNCeRtlB4zKTr71u0EHYcuLnbstbtxP72KE8ewFC1JTBq0
 zU2t07y3Jjj83x7sSyKBppysoLd2+9y6qmb4XDypu4iWONJPjjI3aYTKeOqIbKuIN5aCP+oQIZb
 A2SnFbpJPUGVXZlFMtaQQulXhVeLxHSP1lfXFG27IiB1xbEYlYziTQGuDSypMwP53JZcmWQepBg
 9F0QOFPzJQp7KkpaVVH4VdKMxDq1gL/yvll7zLcJ5SYfZzezjcnnVbeYrGSEU5/LzVlKXc78GbJ
 yYT7O6f+zembIYqvKkJC+csbWbDl+k7gRIpjJrc6FKeOvbIUmbV9Q+2fc1v3LOphXEjD4J6M+bJ
 zNMBg6GsuMjWcrVHjJw==
X-Proofpoint-GUID: J84Qu5L50x7XHbZJ_p3KzLOIyj7uoALD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Sucharitha Sarananaga <ssarananaga@marvell.com>
> Sent: Friday, October 9, 2026 5:06 PM
> To: dev@dpdk.org
> Cc: Akhil Goyal <gakhil@marvell.com>; fanzhang.oss@gmail.com; Ankur Dwive=
di
> <adwivedi@marvell.com>; Anoob Joseph <anoobj@marvell.com>; Tejasree
> Kondoj <ktejasree@marvell.com>; kai.ji@intel.com; jianjay.zhou@huawei.com=
;
> radu.nicolau@intel.com; Gowrishankar Muthukrishnan
> <gmuthukrishn@marvell.com>; Sucharitha Sarananaga
> <ssarananaga@marvell.com>
> Subject: [PATCH] crypto/cnxk: improve RSA private key validation
>=20
> Add upfront RSA modulus length validation and reject zero-length or
> unsupported modulus sizes. Validate CRT key component pointers and
> lengths, validate private exponent length, and derive the actual CRT
> key size from component lengths instead of relying solely on modulus
> size.
>=20
> Also round up the half-modulus bound used for CRT parameters so
> odd-length moduli do not incorrectly reject valid factors.
>=20
> These checks ensure RSA key material fits within CNXK hardware limits,
> prevent invalid parameter acceptance, and avoid potential NULL pointer
> dereferences.
>=20
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
Applied to dpdk-next-crypto
Thanks.
