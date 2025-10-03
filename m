Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF4CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 16:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E40F04028F;
	Fri,  3 Oct 2025 18:56:25 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id C953640281
 for <dev@dpdk.org>; Fri,  3 Oct 2025 18:56:23 +0200 (CEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5939xi2s012279;
 Fri, 3 Oct 2025 16:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EKbsepo+UTnzIeXyyAchIpFn
 Kllsr4Juk1h5JYh76L0=; b=pSD/7ZSp6cJXmhS2EfKk2kE4PAwo/G9x6HBXusYR
 H5tMcMalFysJNTAyhXIwGvvRnmEozw7RG3jcvrd+nKsMJFAnWbdwSeRCNlVO335m
 yBkj8i0sOAxWrLEbVHFEa4kCVc6OhoDxRxi9NIIpXASzPlmnWnS08jg8suC3JQvS
 XLDaLbp7kqi4nhXBD5WzmA1FSWxmZMo8h/JQzEyFMcJeUyd8k0nZTwKckJHwFJnJ
 rwfkVHQ2X3j1RHaD6AS1TlFEz7k7phYo4m2gyrDJUfN5UTvuf2rSeqk5rZtayFw4
 2hnV18+GfCwoZD62FrPC9k5OeP1hA6IGlEDz+3YAYh1esQ==
Received: from co1pr08cu001.outbound.protection.outlook.com
 (mail-co1pr08cu00106.outbound.protection.outlook.com [40.93.10.102])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e80u3k7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 16:56:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO9UjyFQlueJLTfZqca9y7WhaqPfyewDFwpHRDEDDSQze3cA1N6nV0ZMUy6bCeK6gfgsR9RLbM7nnwnU1C6QPP19rOFXJS+59cKTekP/KrUFxMHNxOcBb+NE1D7qnpfT+x5L6DWk/4WeU6IgEfheXPabiZ8h5n/Syl80YXihUQc+pbQZA7q9I0P585o4Q7xQl36uX/UF6oyGd1sq2r3231KkasqXm5k17VvJkgdcJUc7yPJTYB6N5IgqItBeZFtlTCXKYVKegEc6zDnyQwacoUq2wqBImQrOBUP0nmcqimovnTJElmfGwaEg+xSkhv6AdxQRfJc/bgaaA8Q+zIzLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKbsepo+UTnzIeXyyAchIpFnKllsr4Juk1h5JYh76L0=;
 b=nJFDguR1ZVFUMNIvOYdLTq1oRgzTrZGYofPB5BAUH6GhtyC5/FlVPamV0+qRaUF/A4w2chWM+y4c2unuZ86doxmXLWPW534bEfY1fyhCM07X/Q4TOH63XM22AMsrbfR/CkWzF7V8mRTjjtniYkrm/2A1k9ApJvRZNS6KSyQMpsIJHmKlvsncwLWtPxaJueJZyndkqZdnvpOf7pMWGlNRutIS4eEUdbjz6S3hJKlC9cU8DAdWgqjBjjikmSms4kldSpwbzgQ8TJsaC/DDQY0zyqgMtbOPsjEgotPjw9j6rnY7QEXfonfOciP3PyQOWW9XL693bMAm3C9ZAs0XRaP7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by BY5PR02MB7060.namprd02.prod.outlook.com (2603:10b6:a03:236::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 16:56:14 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::5f1:dcbe:bb2f:83d8]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::5f1:dcbe:bb2f:83d8%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 16:56:14 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Topic: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Index: AQHcLW7+Yx3s32UTiUaGijgdWUWe3bSsL5oAgALpJYCAAPqwgIAAnf58
Date: Fri, 3 Oct 2025 16:56:14 +0000
Message-ID: <SJ2PR02MB9795048742BCA7F33AE5F86589E4A@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484EEAC621E731A4E5E64C8D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
 <SJ2PR02MB97957A1B0CF42BF92F77941689E7A@SJ2PR02MB9795.namprd02.prod.outlook.com>
 <CO6PR18MB4484895AFF0D3C3932D83C70D8E4A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484895AFF0D3C3932D83C70D8E4A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|BY5PR02MB7060:EE_
x-ms-office365-filtering-correlation-id: 55f78691-de29-4ce2-a6f1-08de029dc380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?bMrEZKhe1WrgPnj0cFW3eRfjDZZTKt9JRczGwVag+pxziNOgC7s6jGTW2hsa?=
 =?us-ascii?Q?4DaYZgsxg0FEjgts6BQAk0Xip3O8WBBbOypf6sjuzWcsgRRBzy4bZb7U9AO9?=
 =?us-ascii?Q?6YkyO8zqXh8QFuGyResLosIw6z1usU7oUPGk13u9IXeyvGjSp/QwqSWAl9lY?=
 =?us-ascii?Q?k37QkHbP2Sx4rUgDn4ZpqZkQF225TuwB7bNeUrk0IGhvF8t8BtS1PRkTAcsk?=
 =?us-ascii?Q?D8xMLxoVNoeP/+OdV8TvD76ODCUmMveCu9X443/fsqdLhnW+CqBNra5enVJr?=
 =?us-ascii?Q?gtfcAStaCGQOV5jDTWePtzPjgZXjG+OygPlRuNOJXJT7syZdb5ThwjY/LWSS?=
 =?us-ascii?Q?fj67HEGMQvKQaHRhEuGFdMururks6PiwESgO8IufwBJ7tMkLsRWCOkalMpp0?=
 =?us-ascii?Q?AdFv0cbG3NMhrtiT2B3POeZ71YtZcg9P0JhQiKSd6xaPgTbA1IqlC90LqgaV?=
 =?us-ascii?Q?HFUxMSH/CoPNN2/4wJNOQHUlWIquy3IuV80a67BOG5cAWK1btz1x6QkbdjtC?=
 =?us-ascii?Q?jpYS4g6RRjCTzww7PsecgrbYhcHjDkwSAhqvGjPnf1cNIvEVSFeX+Qut3aaD?=
 =?us-ascii?Q?8I/NU+C1bmRtmKd0LiVNKd33h0ZiqywxQYDWXhwwt0cRRPFrHWYxvtgBMDKi?=
 =?us-ascii?Q?BKBFyVKyfE4WRHMesPBRcNfNOk+2MJTXfwnbE7EGAu0SdmK5CUIixO0Nca7t?=
 =?us-ascii?Q?h6zNG7tWDifnbX3mNOfMCtLZQYMtFHPwttGtyTVV4so2c7+2uxHJg4Lr6IIZ?=
 =?us-ascii?Q?4ufDKs+4R5SdQyo1eKsa6RwQGYbukvDHH4YHIWJ4JT+uWaH2630nhGyerqOH?=
 =?us-ascii?Q?zX8eKIyCofoX4EompPnrLpwPYTqeTh7a0j5WdocOpiHL3l8jCjjrTj7Y5Yfx?=
 =?us-ascii?Q?OsbT1LJB+YWnJA+1Kl9d1WYfnnsjjVIzlIExtRk9Ykav870I+orqdyfaEo6U?=
 =?us-ascii?Q?MjSXyXOtGzrHvjDDcfBu8WynA9beRRjdvzBz0dn4Krwms5XX4SlV4M+xyefQ?=
 =?us-ascii?Q?vpx5FMiN0cPFqyDE55UlDwO5cOxlkvlXdoO7SnCJtcQ44LifQH176uEDzrbo?=
 =?us-ascii?Q?CJr0PhWi6Lg74K+xO/eWYQ3Dg5mU0ypQHTNpRCgTe5htOoS7t3OS27G0vkTk?=
 =?us-ascii?Q?4kCIJrPSmfRK3gOYuZodmpH4AGrvxCYGLtIHyio+kPWygPUIupQaibsdoyHg?=
 =?us-ascii?Q?gJsEdUeuFrSiPzYcnVoZ0sfPz977UEAbFHePZj87fNaylrtg0tqtEGdbA1mg?=
 =?us-ascii?Q?vkZn4QP7QEe2unCeDLT328clGPp03wc/PM46Erpmj7aK/g2SCo1kytKYYlTm?=
 =?us-ascii?Q?UJQoTzPVnMS2vB/5/b6LAdHjBp6MlyjpWFmGdE8HmHR48CzAGwcdHBYgllI3?=
 =?us-ascii?Q?nhBxuUKZOulCIBBf9sW1F3Mu0ACbtSDNe63gIHC9806fjzYB32KZPn13k/7I?=
 =?us-ascii?Q?2RqBupU1iIQBQz9PYb1Ybw8h1Coi5WxndgZdJNTdaE23DU8KJKiyow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xqm/TotQtsJwZJDN7hgKikpKkN3qRTb9YkxbRYBcjH+uGN/l0Ii6t4egCpEw?=
 =?us-ascii?Q?DswTGoggAX0vE8/ZPxJznAqDJd/7/Hc7O04CYWuR/aG9fTjw+teNz87XiFXj?=
 =?us-ascii?Q?ec8Gp9vlUnSeRQr3Xhpd7SPKKanKy5JCYtMWAbmF2KWDCVKaI8CyiOPpcUTc?=
 =?us-ascii?Q?UExfw4wVly4t/ZxFO6R/vdh780J5FcG5nfbMqxc34QLE59uTE365u8N1XVme?=
 =?us-ascii?Q?GwD9QyWkoa1ysnwCNEEc/mUbCGfKcCUFJ/cXXnKq8Ny3dS7QQtGw+k/WOcDX?=
 =?us-ascii?Q?MZQ6XoGCVApWR8D+6yD8gMrBlktliLyU7d/yMbscXs+/V/Gjt92LgjQwwV62?=
 =?us-ascii?Q?s+zBPCiessQUujftYKrYK2iPrV22+SKSbeyWP6agTSBG8KUFu0Q9xz/07VFY?=
 =?us-ascii?Q?195PM0HUcwc6yyMNWEqn8zL6WfRUY4fPWOWJD9caRm4F1sHJJH+jZLTbwc/s?=
 =?us-ascii?Q?Pex7rgEjNpJplM/dMczat74nq2xWE9frulvg2VLwinPiyFJk+DZPz67Wmvy4?=
 =?us-ascii?Q?Mu9jOssbEljGeHssY4rxEmYZW2Ssozj1+R//NCYINqT7z6YnmPe+d1h1+5qf?=
 =?us-ascii?Q?1hWvlx5uwjsuwXiYx15zbFCtmzXT3hjotQkUXRLBWagkmPWej0HasFkdIEwL?=
 =?us-ascii?Q?5RcVEm+Eol0R5P+Crkti1g5AWW1TydGWYWNlzuYe3UQcWKwgg8+Ig0b/mOoU?=
 =?us-ascii?Q?F3CnK7nj18BqIGRCQrPpzu45rPo5IkT9tVXSEH5TfhWAQy34S6gSsDeqi8PW?=
 =?us-ascii?Q?ALM9OOhM9V3bW8C+R3mloQTb6lRLgPMGgu2niSvFiuGBRIxfZtiQGXx8u8aS?=
 =?us-ascii?Q?NiwaW3S2diskjaVS+TdTNXluelvZW9y97gVtmWCkXNlOlxd+j1GIMIc5PEYh?=
 =?us-ascii?Q?NY/DC1Hj9/A8ted/BJ8M/IJwtcUNZvYJlLZAp9R9ZuZPlLnOOrpWLuaEZ8/w?=
 =?us-ascii?Q?+TXZpw936wFURfsKosZBi2caqhDuHGdJ3z3dQIxU9aKDiUYVGCiqYmJ6hW1s?=
 =?us-ascii?Q?lok5Q9XGQo6dQp2JU4gqRtzHUi50Yfpb0z8ZVazV0Nz1J1r3UeOEtMkp+nz7?=
 =?us-ascii?Q?HJrhtlCh2mmP8B9TNqdc50L0QDq1Xutm2QPE7no3RhQuHK4DEuw28vxBEm+k?=
 =?us-ascii?Q?+IC/ma2u4eunUseALRzOZ1RvzP6YL55vJcKmS3diIzUnRf3NK0+tWBoNutCA?=
 =?us-ascii?Q?WzfA9sZxedlIDnRHiJhL3O5gnxW5pFtCBdNbknYR6qUCHNZCnvJSm7+ivdOP?=
 =?us-ascii?Q?SRixgAD7FS8gDtVTkpVn9yKShaoZVBfiSuZ37VW0HvK8q4KhM8iW0M3FOuCY?=
 =?us-ascii?Q?XBPx+G1zk5Tp/HrO0p/EPD1bU29u9dPebnZVV45FDFEUSfXOyq4eVDGJcFBd?=
 =?us-ascii?Q?USwRH3xMzuPPs0WJx8V7ZgbdjECakt7GAUShGn4Z6AJ7O/ifCP06Do5eOUfU?=
 =?us-ascii?Q?iILT/OC2kn8N2w3qP8ATxhrzGS8O/LF/oIlAgmGk+MATxm5GU7WQQl1n94cB?=
 =?us-ascii?Q?mAvA7sn1buDOSsoeIvt/jQSaKxCxtT9vNUCCUk9niooNKuZX4DQ7pPu2sg8I?=
 =?us-ascii?Q?Ou97rgpWvG1Utc+LNbty0dCCMK3vHpVXiyzHK30Y?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB9795048742BCA7F33AE5F86589E4ASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T43dx+drP88eUMZeUSXERw6kmxStJgUjxgvzRmz14uWCMfTaOBO6pd11jjbS0DEPZ7AtzQr6LbO9ReRWthuSpEVEYGeH3+A+kd/0GIqLleWuIGCQ41V+f0L52yaxqtscimwcSmp0rXICpXwgHbZ8S09SbgSDsBIXNzaVTBjna42FTyU3l2PrnuzDlLX/GXgyJs67ZC35Bjz1KTs4gOnla7VfdGR4CQXBFz0pCDXfpW7KyGSNebTxtQjaacog950VEUbQFEc+OxsYpNcSlYUHNt3279ePOkayBiQy4+Du9kB4VWpqNhcCKWLodLJoG90ur6dLTZpAXD8i3qedwn7+0R/ZhY2wlBmQNMxsEstERvKl9ThYbiej5h9/ldrQ9N2QRsrFqZp8FEG6p+NUYq2K3Ik4UoFWg1JADjZnMYSDcmr6/iwl3cJXIpuV3ip9BewNf3H5RzRUtxT5faBxnIomhsO7x3lVYzmn+6PG5bU6Rl5B8jWt4JfAoKx5/Rq7XzSk/xX6fYgGoznDF/OwOXfhjVt2j4jkfWlpVJt55RNaenThwPoFNdLEvA+CGzlYhi5D/rCbSpMmKnodsc/W2XVA10NTOD5aeHGdcPY6K8PynGOWiKSvMOUf6H6uZw2p9g/z
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f78691-de29-4ce2-a6f1-08de029dc380
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 16:56:14.6120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJJN5aT9WMDXsDvzS6BPLro3TQD4KPv4E1Jx2ziwA724WtA3N72KOK4UQYRHAAMiwp0HWeWa2t18p+VozKBC8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyOSBTYWx0ZWRfX+f/wXCLUd5T2
 oXeCY7gxCvrL022hFEQTPXRCUVMq/wErfJLtRh1pvz+EZt6YBSY80JTSRZnxpCKpLwEMMWvM0XR
 Pg5mDm3+7Ba1ZANAk0nohcGoC467Fi9zaeL6s9h2qMg1V+uaM4y/M+6IiRcl89YDpEMDx9ERwCJ
 BAT5ECe84H0O4Lgs10MIFlXB2qAK1IpCgRBE3CXjvNdOK1NUo4lvCkAmolxfsuTHlJZfChPaeEG
 EsB1dvQ0CJAydWmApm33A/lpVLt6uvMtTZFgNNX9DbLNWgF/wRcsjDgfB2x76zY3D3CShvGvL3N
 BjlFaVCAaJxE5ikjv1/xvoSoLF7eumbC3iUrBvEvk1Vc1JfdwoIT4dA1M/P7ApUfpp8aOnH9Q1r
 1H3fXsLovulirMVGrLPUQ1oLW9x5Bw==
X-Proofpoint-GUID: jyuW9jLNxYX7Ay0q3DdFsGTvmrqGAAee
X-Authority-Analysis: v=2.4 cv=OMkqHCaB c=1 sm=1 tr=0 ts=68e00037 cx=c_pps
 a=IC9ezy+LpI74bZSTnHh9OQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=SWAEecC5FQml2-hjlHcA:9 a=CjuIK1q_8ugA:10 a=nhWdwjMz9NxOi2fC:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: jyuW9jLNxYX7Ay0q3DdFsGTvmrqGAAee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270029
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

--_000_SJ2PR02MB9795048742BCA7F33AE5F86589E4ASJ2PR02MB9795namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Akhil,

I pushed a reworked  v2 patch based on the comments below: https://patches.=
dpdk.org/project/dpdk/list/?series=3D36288

Even though I included --in-reply-to to the older series it seems to have c=
reated a new series. Is that expected or is the command I used incorrect? T=
he command I used was:

git send-email --to-cmd ./devtools/get-maintainer.sh --cc dev@dpdk.org --th=
read --no-chain-reply-to --in-reply-to=3D20250924161918.2211290-1-svaze@qti=
.qualcomm.com *.patch

Thanks
Sameer Vaze
________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: Friday, October 3, 2025 1:27 AM
To: Sameer Vaze <svaze@qti.qualcomm.com>; Fan Zhang <fanzhang.oss@gmail.com=
>; Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries a=
nd PDCP checksum

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

> Sorry for the various series I pushed. I attempted in reply to but it see=
med to
> create a new series. If I am making changes to one commit in a series, do=
 I need
> to resend all commits with an updated version? In such a case do I reply =
to the
> series or the specific change I am updating?
Yes reply to the series. And all patches need to be resent.

>
> Regarding the comments on adding UDC as a new algo: UDC uses raw deflate =
and
> is not a separate algo in itself. Support for pre defined dictionaries is=
 already
> supported by zlib and is not UDC specific per se.
>
In that case also, these new params in xform should be part of alg specific=
 params - rte_comp_deflate_params.

Please note: we need to close the RC1 by 5th Oct. Please send the rework as=
ap.

Thanks.

--_000_SJ2PR02MB9795048742BCA7F33AE5F86589E4ASJ2PR02MB9795namp_
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
I pushed a reworked&nbsp; v2 patch based on the comments below: <a class=3D=
"OWAAutoLink" id=3D"LPlnk401803" href=3D"https://patches.dpdk.org/project/d=
pdk/list/?series=3D36288">
https://patches.dpdk.org/project/dpdk/list/?series=3D36288</a></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
Even though I included --in-reply-to to the older series it seems to have c=
reated a new series. Is that expected or is the command I used incorrect? T=
he command I used was:</div>
<div id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
git send-email --to-cmd ./devtools/get-maintainer.sh --cc dev@dpdk.org --th=
read --no-chain-reply-to --in-reply-to=3D20250924161918.2211290-1-svaze@qti=
.qualcomm.com *.patch</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Thanks<br>
Sameer Vaze</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Akhil Goyal &lt;gakhi=
l@marvell.com&gt;<br>
<b>Sent:</b> Friday, October 3, 2025 1:27 AM<br>
<b>To:</b> Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;; Fan Zhang &lt;fanzha=
ng.oss@gmail.com&gt;; Ashish Gupta &lt;ashishg@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> RE: [EXTERNAL] [PATCH 1/3] compressdev: support for diction=
aries and PDCP checksum</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARNING: This email originated from outside of Qua=
lcomm. Please be wary of any links or attachments, and do not enable macros=
.<br>
<br>
&gt; Sorry for the various series I pushed. I attempted in reply to but it =
seemed to<br>
&gt; create a new series. If I am making changes to one commit in a series,=
 do I need<br>
&gt; to resend all commits with an updated version? In such a case do I rep=
ly to the<br>
&gt; series or the specific change I am updating?<br>
Yes reply to the series. And all patches need to be resent.<br>
<br>
&gt;<br>
&gt; Regarding the comments on adding UDC as a new algo: UDC uses raw defla=
te and<br>
&gt; is not a separate algo in itself. Support for pre defined dictionaries=
 is already<br>
&gt; supported by zlib and is not UDC specific per se.<br>
&gt;<br>
In that case also, these new params in xform should be part of alg specific=
 params - rte_comp_deflate_params.<br>
<br>
Please note: we need to close the RC1 by 5th Oct. Please send the rework as=
ap.<br>
<br>
Thanks.<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR02MB9795048742BCA7F33AE5F86589E4ASJ2PR02MB9795namp_--
