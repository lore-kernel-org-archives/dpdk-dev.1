Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2886C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ACC740267;
	Thu,  3 Jul 2025 18:29:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 33D8C40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:29:26 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563BN8AH025086;
 Thu, 3 Jul 2025 16:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Xd8hHAvAy2dPFbkFHJQjwzXg
 J8YPSf42vkvWm7GUqgc=; b=ai04jWIHtsbPJbY37s7o44qMJpGYo+L5/yCqRgwX
 S+f7uqzxKBzTzlOoKpVnLGbKnG8ctsJCnk8oCzM8MSzteDf3KwxNksjklCgeGts2
 sx8ETBTYo6zyaMgPh0Crw85XyIeRYfsADaGGiHCItoVpTPGDKPxl1GLv0Oh42nSv
 JcrD7erDMvlcuc9MAie7R/w1nF0vGbfb3zk4hF4seW5mOGEF7Jrea68phdNLmR92
 6KOmN71ii6ZxH9Lx+yEbWo6KlwhA4ETAWK9CAZNoZHXgb8qP4VMv3KMPrZVyhm1a
 +ijYQzO0zRQm30IPhPkXl1C/p6rogSOWZzhw6PapD4Fh5A==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8028w4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Jul 2025 16:29:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA3hzSrfk1Rmr7r4MgN9rIdvIvLGof7sQkI4d/0tNfF/0rkohHJ4M1iKkNvJol0R8lpu2hsbGso0lydaZymOKVB9c9kodLf7Be0YllkOs0LxO7NtULqsI33st9VkK1jjZgDCc6h9GM/g9y0lBJMVKG5WcP05KyPFBZiSGCeF4Li5f+JUHtJG+urKlsA2dH53YHAEKip2/+YksCU72zWE96ZsnHS9MO1gWFqYeCuqv71ZEIeU/g6ypkgArZ2haQL6CDKiBjdtTuZaAQz+Fk1Xyk+N6DqMWz7ezg9ngigKo1PCQd8HDzDkcsWcOb4QflHnJMADvaLjvG1KoPo0D8RyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xd8hHAvAy2dPFbkFHJQjwzXgJ8YPSf42vkvWm7GUqgc=;
 b=vwZepa6ZKqVEx9ZOqHUlWPVhZ/0EAvK5yB49V9tInYI8nEs8UgQ2bgPa31eyaMgDtXVIKvpy4UHt7X06FIybNSaJi61eR6Uxx8AcsYHlTEeXmKZRYVlWESyIALRjk8GhW0pS9d9Q3TKhnKEeXfOkVPwBPMU7e1scJIKpwq02ySXbd6E83nlkA+2Gxq3ZZGKJJzJFdlFvTkHNSm7rF3dq3t6lk6n8z5DZXlMwjhECsRty2R+xQ/bvd6qLYCRAr3tBdqwd+4gVpXgk6EF9w1S01KedtS4sFEXY3I2JZOeYEAxgO0POSNmD2rH4WIHsgbjzT1Nm2JNyLkx+7Wte6INQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 (2603:10b6:208:509::11) by LV4PR02MB10954.namprd02.prod.outlook.com
 (2603:10b6:408:2e1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 16:29:14 +0000
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5]) by IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5%3]) with mapi id 15.20.8880.026; Thu, 3 Jul 2025
 16:29:14 +0000
From: Dylan Schneider <schneide@qti.qualcomm.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Jerin Jacob
 <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Thread-Topic: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Thread-Index: AQHb2YQ73VfknzRgqUKIslHGkPlGlLQXYbIAgAAB7lSABHUkSYAACqwAgAN39S2AAS4mgIAALe1r
Date: Thu, 3 Jul 2025 16:29:14 +0000
Message-ID: <IA3PR02MB107716434B37F31DC2949B587E943A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <4485771.rnzLaay6km@thomas>
 <IA3PR02MB10771C80F1E35014C06F8C9A9E940A@IA3PR02MB10771.namprd02.prod.outlook.com>
 <9741269.mr9Zh2SJbS@thomas>
In-Reply-To: <9741269.mr9Zh2SJbS@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB10771:EE_|LV4PR02MB10954:EE_
x-ms-office365-filtering-correlation-id: 458dd1aa-d789-4f7d-eb4b-08ddba4ebfd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?o4O0yL3lcUeG5Oy+kpDFRxoQdhxWLiqY5JrQdTgnu7ZTZKRXjJXSTdenPQ?=
 =?iso-8859-1?Q?M8MdxxDqRdVQaeBX3zdWOWKHg3Zm0CzoR3GGdZjiI29i7IOFp/UJmcixjY?=
 =?iso-8859-1?Q?QKt9JiOdAIqwsRtDSsAbbRzkuF6RF87vUWQmAL5saDMAFnksqVki+VxUnc?=
 =?iso-8859-1?Q?2F9AsfPy2dmfxx7fwZ8iOC3cTJ2s3pZGSH5K99c7qxHSpkRVV/TIHdxKYa?=
 =?iso-8859-1?Q?BY20mNwMoXip7vM7y9PcYKH4XepLaZMkfMOQPAYemigdquHpXcDqYgzalM?=
 =?iso-8859-1?Q?EfQeKWsBUv5/xe3MHTAVCTgwPvz0MBMd732jctdddmRmKQH7W48H+tqFVk?=
 =?iso-8859-1?Q?BAxzWHJjCWIEmtKG700jB8OZYh8zJ094C5XW+X1S2YIC57Sh/5N02dlwAe?=
 =?iso-8859-1?Q?c1pOqPCnuxG8C8m932dJHpge1GBW3oqLSx9nglOe/jBhg5TKQjaaML3s6L?=
 =?iso-8859-1?Q?hi9w44fzJC9aV9PW4h378hqEzD+wti++cMMN23RCdsPEwttBC9Ppu7Etkm?=
 =?iso-8859-1?Q?z2l4it/yqXNtm1agFrWFoRY/XEugHdXrgKuWfBT/+CPq8E5Q8VOYJ6xUvc?=
 =?iso-8859-1?Q?HH8Td+o2N9TuwipKqry//ORhPjNpMm6gRCk8mtfoUwoqZxd/0u/1Dghw5P?=
 =?iso-8859-1?Q?1lV1MgWH3xOgOUznN4gbzcn7EgQOweaXApwYin5Yz1f0nJjFO7JaFJowwD?=
 =?iso-8859-1?Q?xcD2zrLPKX866XowdozUsAZ3r8PY33QM+iXkGHcrJxafRczHR9d2V7Djh2?=
 =?iso-8859-1?Q?WgLujxUB1qncWHe4aftgLjC5rs0EpZkxQeVSFK8A3USqJFoXpM6Gpjxrr5?=
 =?iso-8859-1?Q?Wk+++gwWaWR0BnNRHm2STu1nne+r068u7X8cA4blEViX1aVaRpNxnDYonI?=
 =?iso-8859-1?Q?tz+Q4XL2efUuc7i76T4LvW1EIjRDhagvxIn5c0iwd5crLLDZNv+mqtGI6S?=
 =?iso-8859-1?Q?Xz6aIN77pKhu+byCaTBae6u8QGwBfj/tZtrBtaVkfCw4bFJcb9FEBLWxr8?=
 =?iso-8859-1?Q?a8sfEugzjsQsUM4LJ0Ahgv4oRL6aW1zJUZaFWkLloG7LiphMwOE5WDCiZT?=
 =?iso-8859-1?Q?loQGEbNEDwZ9NAV7OzjJjF6wXBxFfTCCJtPuUUusH6YYFOTyZLlESG4mRm?=
 =?iso-8859-1?Q?UMZUXiVSvP6pkewiJJfS+PH3BiYibmyZLsdmteKl9B4Gb2u7bbaig55JZD?=
 =?iso-8859-1?Q?UphmNYK7WxRzy3YKUrIFQLL8PPL37pffuC117lbofE5Etg9awOWuqPWWqT?=
 =?iso-8859-1?Q?ZLac0uM70xs3uZRSM6qqIgNl/f2/p6KQl7P73izck/s+XrgJUh30MPsPNO?=
 =?iso-8859-1?Q?ADhtKMrMpEOz0LSv6tQEsFbw/yXmcaq/7s42WjzfhukFCA5Sw/OPsU1APh?=
 =?iso-8859-1?Q?pjKkOc6OHyHO7gGV9cETTJuKE5Th9kRq4Dk8l9KWBWRmXN8Cw/IQPwOF6M?=
 =?iso-8859-1?Q?nJ0Ox2ldbgPtbXN5Ro/oc+LpATdgcoRvnWr5xqtcc5EbeAz5RTM4HxKQHd?=
 =?iso-8859-1?Q?7yDkJL5NuVD05pUbj1vgpvU4NPz2iBnSHjgBfXA7Hbb3Hvf3MsbmnvWZ91?=
 =?iso-8859-1?Q?EGIpNds=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR02MB10771.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tFV1VKw4o71XZBz6heGxAil+daOj+8+wWqAV2pkQuOStBKDtWidUgOL8vZ?=
 =?iso-8859-1?Q?n8cwBZkTNeddHZU0DaVV44Lj1UYfPgQlR0IvByNK0m9CnpElbqcB0u2ota?=
 =?iso-8859-1?Q?SUeqePXmrDClbPI1VzCzin8bFPx20XH3KHf8fISB4Pd4wQcDBIQc5fr1p2?=
 =?iso-8859-1?Q?G5cMX2hLJ2pvUtaKKB1vasb0+xnwj2jqNw4MPx05emLkTyqZ/9qfcGOi1l?=
 =?iso-8859-1?Q?k1dIzlEW1fCu5luJdB8HXbc3wGMxMM4GRGC8Vxp0az8IwBLBQunBoRxZg2?=
 =?iso-8859-1?Q?+ECHsFPuZHfD3Yovd59Wg6ywcmY3Bqd/sBS967++gJ7yWtujvuxoMZIAI8?=
 =?iso-8859-1?Q?9e68s+a0v3aDOdS9U16MfyLoIEBJPtIm/YbAEneFyyMTn16ZEQpSK4zKKV?=
 =?iso-8859-1?Q?kFrrsjhm0GcFtTdKJ/0Uxp8/gsY7L0JCmoempjfgNyL3jOxRqsq0ZVqs4W?=
 =?iso-8859-1?Q?6eEbwI6dotxIeq0X9cCna47GA2Aum/Bef3HISlmU3ie8UVDB+Lsd8cMMxL?=
 =?iso-8859-1?Q?YODedgJxu/cDYZnFNyqT/+/u4BxM+cBDodd71BQcHIxDD++1STBmNweIf9?=
 =?iso-8859-1?Q?34Car5YQAo7A46KpgbbbfvTdiL7y5Mw8TS74h9km7yhCsBFjwANJHPsIdS?=
 =?iso-8859-1?Q?ZStjlc3To34Da7DsYV/M6hc5m+3gDj0ZsNJf76EGHL6Ti4MdkUROmhiujk?=
 =?iso-8859-1?Q?yTWiuui9wGOLqjKj3W5+W1m2BrRyyf2QBAW424Fv536VJntrthMnvtezDz?=
 =?iso-8859-1?Q?moOCWbdJD6E1h74c4ctoMDMuuAG3ff+FDIWImU7DXJR3lHUKF+CsAceJTJ?=
 =?iso-8859-1?Q?gGWfATe8Ni+9x2X+YA9RBf1yF4LdvKI1w5uwLZCQk36af4ag1dketiE96v?=
 =?iso-8859-1?Q?pDyQdA9bfRTsxC4ydOtiea/pT8VA+C892+9iCOA7E0b896bluh9MPMEua7?=
 =?iso-8859-1?Q?1DqIt0CR/XmazuggLXwP+7dYSKV3eirr2UT3xe3TcljOw4gmtCYWrqgFxN?=
 =?iso-8859-1?Q?gjliK2m5iIBv3RjwD7x7vy1KaLCtkwof2xWyPus1o65mtITlWe7DcIrmbg?=
 =?iso-8859-1?Q?R7yJVFXxLTyU1+1HCmOgtpd+xjNXH+sVuxv8p3oQXKKQ2spm+PZFCsqYWJ?=
 =?iso-8859-1?Q?+siCuvtNuBdy4I8Ax2+PDCRcmWDS5oBVW06qXH91p0+SrbRIJoD/Ub5wOG?=
 =?iso-8859-1?Q?K69lHn5QFiKQEan7ShupGoMM3RFiF0WRWqbZVvTURXCcupMyDkyPtPWQPE?=
 =?iso-8859-1?Q?wSqk7kkpcXouPUTAml+6+CaP8ImW040e7SstlzPkcVKNOXPhGXOUlPgnLW?=
 =?iso-8859-1?Q?G78T9JLVJHmiGFGlqVQRONxxKNIfewIO6GLSm9L8aUFZUZbltrjl9IqkSM?=
 =?iso-8859-1?Q?s+ApSW8jlrrF0VvLcmMn/+6UgBUFFHJ+xW7vBQ6kCsOwhUxjQua9v5Gu+e?=
 =?iso-8859-1?Q?Rgz7r0KbaAXWl+SkyroS94aS/9ohBiTa4XGyVIpv0faG+gfeuFNW/DTlSY?=
 =?iso-8859-1?Q?tBDNXIOrHEMcGABcrA1oUVO6MUP8l325KxIdvHQEgayO2hF6m6vL7N/nO0?=
 =?iso-8859-1?Q?fsFvEzHQXqgYps0KwuOh6BMvEDXyb1LuK5XPJQ6SafT0+SrfcwmAPqi1MJ?=
 =?iso-8859-1?Q?I1+JBzgIQ3LMnwtJ8zYTP6ttMSi1ndJbt+?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR02MB107716434B37F31DC2949B587E943AIA3PR02MB10771na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LnNPBi/CvXwKRKs/Bni1wLFTNiJuWmFbUKHpg//NDBmyTYcLV5iiCmvNp/gjPg7BiY2lHsAbjPmV1AnWkiH73wJVIugklGoV1VUf+hhmHphukoTJcuYjOgrnoR961WEEM8i+75JLPVDAbUrC5clNEzn6V/anHo84AQJ+enKLSIjPCiMSqYk/BEISVUhpWLeutlZ9uYz+8JaqNdSzT+QOuyn99/y/4Ve6ZTtYl6Ki5APOxmQKv1KpM4pUxjZhHHB8ltqc85B9byIkNjzJ8MANJw/AtbBuPo4bDhIE9lX6lt3+dJsii7MIKgsM1z81pFkBrsvswN83b5HZ2gml9umhUPye77izMaWXPweN7nNbOBziBND1U3AIYoFZXHGrGtyZgQ5TvpBwo4m1lgXuUHOTs2V5MRAF4OM+g2UM95uJmc1cZmtA3xctjxEmfC4w/6/JKm3niG7T/c5uy6ydx65Drczx8UjRYJJxZ9S+Rab3raanbKJ7cHWmiBcqTW6HdJv74ZuBXXDJNAv72U1d8vsWQhJwbTriLHLezyFkYKdyEC+jl+6yz2+EVVONdxRZug2cYuINwAOUj5jv/PeahQF5dPKFzChvNQS1inkCDqwLA7lq7V+PudXq7UikTFaEQCsC
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB10771.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458dd1aa-d789-4f7d-eb4b-08ddba4ebfd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 16:29:14.4918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAHMZhblz+a6uNdEBBTzhFlAV8Nbtp8FFZESJABInm6xQ3tVVbb/PqW0cIbFkLHvEKrgU4K1RtGkrBttiuLXNpyq3H/MCa+SLINXk0p+biI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB10954
X-Proofpoint-GUID: QIvlJHtF_6n2j2Ble1MqkKC6NobymI37
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=6866afdc cx=c_pps
 a=zbudaZmfUx0dwwhLSrpPog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=bt5KbKNvAAAA:8 a=EUspDBNiAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=Byx-y9mGAAAA:8 a=-hOUkNs-YIEAflUVl2UA:9 a=wPNLvfGTeEIA:10
 a=gzyx0N1aP53VFfo_:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: QIvlJHtF_6n2j2Ble1MqkKC6NobymI37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEzNiBTYWx0ZWRfX0ez4dIhIF4HC
 YE5vPuTtNzVp2RiQfxa/twa+9HOaC2GuxrCl227DUYKUUMn4mniJvt/AzZhqcNdNue5ZyZQQTzo
 TDk++GigU86xOvHUc3Tq9crnTmi+4uvey6GmPFt+p1hIZBuAMTCdgHLg9y+nNMjoZLhQQ8QzBy+
 F6YlJD3TKB3gL+tbR3OjRekqm2aMQRjhzNa5wchhWtc2aWFYnYhijeIXdiAJhyvDxbSYSIg9zv3
 RvHnt87H0SYDwv28wrnR8zd2fcPNKwp4cwbK14NL1NgVuiDnJ5Nu2iPA2QeEduqzdlJhT36nVcD
 RPDGAPs/h7jBHCrK+5RSgBynNn30YNPCm+9cCGTk0HBRAdmCkasr6n4UWkNMOhy4/P5vyO7FUhi
 dJBxVRMZCirR0syLLRQrdewmRvPsFHT+DZRYZaXCFEB+vDlMYgMDj1JJKxBvfvW//L5+lVnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507030136
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

--_000_IA3PR02MB107716434B37F31DC2949B587E943AIA3PR02MB10771na_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I did a clean build on system where libpcap was NOT installed.

My changes make rte_pcapng lib depend on libpcap (this is for libpcaps DLT_=
USER Macros).
So now, in turn, everything that depends on rte_pcapng also depends on libp=
cap. Dumpcap, rte_graph and rte_pdump all depend on rte_pcapng, so I think =
we may need to add the libpcap dependency to all of these? We would then ne=
ed to add the libpcap dependency to any libraries that depend on these, whi=
ch seems like a slippery slope.  Maybe that's not the best approach though.=
 Can you say whether it is okay to add libpcap dependency to all of these l=
ibraries? Or maybe there's a better way to enforce the dependency for DPDK =
build? Or is it altogether incorrect to have rte_pcapng depend on libpcap i=
n the first place?
Thanks,
Dylan

________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Thursday, July 3, 2025 7:27 AM
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; S=
tephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.=
com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpur=
am@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interf=
ace block

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Please can you compare which libraries are built before/after your patch?


02/07/2025 21:30, Dylan Schneider:
> Hey Thomas,
> I retried a build when libpcap was absent and was able to reproduce the s=
ame errors as you did.
>
> Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generi=
c-gcc/install
> Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic=
-gcc/install
> Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-=
gcc/install
> Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic=
-gcc/install
>
> These Errors are coming from ABI check: dpdk/devtools/check-abi.sh:49
>
> I see in this function that it is checking for the existence of these lib=
raries, which will be absent when libpcap is absent. Is there a way to have=
 the abi-check skip these libraries if they are not built?
> Or better question: How does the abi-check even know about these librarie=
s if they are never built?
>
> Thanks!
> Dylan
>
>
> ________________________________
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Monday, June 30, 2025 8:28 AM
> To: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>;=
 Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvel=
l.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilp=
uram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the inte=
rface block
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>
> Sorry I did not investigate, but there is probably a different installati=
on of the pcap library.
>
> I have this in a config file:
>
> pcaparm=3D$deps/libpcap/build-aarch64/install # requires big changes in D=
PDK
> #export PKG_CONFIG_PATH=3D$PKG_CONFIG_PATH:$pcaparm/lib/pkgconfig
>
> I don't remember what are the big changes required, and why it is disable=
d.
>
> Checking Meson, libpcap is indeed not found on aarch64:
>
>         Run-time dependency libpcap found: NO (tried pkgconfig)
>         Library pcap found: NO
>
> Can you check whether the error can be related to the absence of libpcap?
>
>
>
> 30/06/2025 15:50, Dylan Schneider:
> > Hey Thomas, just wanted to confirm,  I see the ARM build passing in CI.=
 Is there a reason it would pass there but not on your dev machine?
> >
> >
> > ________________________________
> > From: Dylan Schneider <schneide@qti.qualcomm.com>
> > Sent: Friday, June 27, 2025 11:46 AM
> > To: Thomas Monjalon <thomas@monjalon.net>
> > Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com=
>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marv=
ell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabi=
lpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> > Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the in=
terface block
> >
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary=
 of any links or attachments, and do not enable macros.
> >
> > Hey Thomas,
> > Thanks for the reply.
> > Can you tell me the build command you're using to produce those errors?=
 I have ran the builds on my test machine and cannot reproduce these. Thank=
s!
> > Dylan
> > ________________________________
> > From: Thomas Monjalon <thomas@monjalon.net>
> > Sent: Friday, June 27, 2025 11:39 AM
> > To: Dylan Schneider <schneide@qti.qualcomm.com>
> > Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com=
>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marv=
ell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabi=
lpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> > Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the in=
terface block
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary=
 of any links or attachments, and do not enable macros.
> >
> > 09/06/2025 23:19, Schneide:
> > > From: Dylan Schneider <schneide@qti.qualcomm.com>
> > >
> > > Allow the user to specify protocol link type when creating pcapng fil=
es.
> > > This change is needed to specify the protocol type in the pcapng file=
,
> > > DLT_EN10MB specifies ethernet packets only. This will allow dissector=
s
> > > for other protocols to be used on files generated by pcapng.
> > >
> > > Includes a breaking change to rte_pcapng_add_interface to add link_ty=
pe
> > > parameter. Existing calls to the function have been updated to pass
> > > DLT_EN10MB for the link type argument.
> > >
> > > Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> > > Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> > > Cc: stephen@networkplumber.org
> >
> > I doesn't pass compilation test on my machine:
> >
> > Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-gene=
ric-gcc/install
> > Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-gener=
ic-gcc/install
> > Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generi=
c-gcc/install
> > Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-gener=
ic-gcc/install
> >
> >
> >
> >
>
>
>
>
>
>






--_000_IA3PR02MB107716434B37F31DC2949B587E943AIA3PR02MB10771na_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I did a clean build on system where libpcap was NOT installed.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
My changes make rte_pcapng lib depend on libpcap (this is for libpcaps DLT_=
USER Macros).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
So now, in turn, everything that depends on rte_pcapng also depends on libp=
cap. Dumpcap, rte_graph and rte_pdump all depend on rte_pcapng, so I think =
we may need to add the libpcap dependency to all of these? We would then ne=
ed to add the libpcap dependency
 to any libraries that depend on these, which seems like a slippery slope.&=
nbsp; Maybe that's not the best approach though. Can you say whether it is =
okay to add libpcap dependency to all of these libraries? Or maybe there's =
a better way to enforce the dependency
 for DPDK build? Or is it altogether incorrect to have rte_pcapng depend on=
 libpcap in the first place?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Dylan</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Sent:</b>&nbsp;Thursday, July 3, 2025 7:27 AM<br>
<b>To:</b>&nbsp;Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma=
.pattan@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;=
; Jerin Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@mar=
vell.com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan
 &lt;yanzhirun_163@163.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2] pcapng: allow any protocol link type fo=
r the interface block</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">WARNING: This email originated from outside=
 of Qualcomm. Please be wary of any links or attachments, and do not enable=
 macros.<br>
<br>
Please can you compare which libraries are built before/after your patch?<b=
r>
<br>
<br>
02/07/2025 21:30, Dylan Schneider:<br>
&gt; Hey Thomas,<br>
&gt; I retried a build when libpcap was absent and was able to reproduce th=
e same errors as you did.<br>
&gt;<br>
&gt; Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-gen=
eric-gcc/install<br>
&gt; Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-gene=
ric-gcc/install<br>
&gt; Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-gener=
ic-gcc/install<br>
&gt; Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-gene=
ric-gcc/install<br>
&gt;<br>
&gt; These Errors are coming from ABI check: dpdk/devtools/check-abi.sh:49<=
br>
&gt;<br>
&gt; I see in this function that it is checking for the existence of these =
libraries, which will be absent when libpcap is absent. Is there a way to h=
ave the abi-check skip these libraries if they are not built?<br>
&gt; Or better question: How does the abi-check even know about these libra=
ries if they are never built?<br>
&gt;<br>
&gt; Thanks!<br>
&gt; Dylan<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
&gt; Sent: Monday, June 30, 2025 8:28 AM<br>
&gt; To: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.pattan=
@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Jerin=
 Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marvell.co=
m&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan &lt;ya=
nzhirun_163@163.com&gt;<br>
&gt; Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the i=
nterface block<br>
&gt;<br>
&gt; WARNING: This email originated from outside of Qualcomm. Please be war=
y of any links or attachments, and do not enable macros.<br>
&gt;<br>
&gt; Sorry I did not investigate, but there is probably a different install=
ation of the pcap library.<br>
&gt;<br>
&gt; I have this in a config file:<br>
&gt;<br>
&gt; pcaparm=3D$deps/libpcap/build-aarch64/install # requires big changes i=
n DPDK<br>
&gt; #export PKG_CONFIG_PATH=3D$PKG_CONFIG_PATH:$pcaparm/lib/pkgconfig<br>
&gt;<br>
&gt; I don't remember what are the big changes required, and why it is disa=
bled.<br>
&gt;<br>
&gt; Checking Meson, libpcap is indeed not found on aarch64:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Run-time dependency li=
bpcap found: NO (tried pkgconfig)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Library pcap found: NO=
<br>
&gt;<br>
&gt; Can you check whether the error can be related to the absence of libpc=
ap?<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; 30/06/2025 15:50, Dylan Schneider:<br>
&gt; &gt; Hey Thomas, just wanted to confirm,&nbsp; I see the ARM build pas=
sing in CI. Is there a reason it would pass there but not on your dev machi=
ne?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; ________________________________<br>
&gt; &gt; From: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; &gt; Sent: Friday, June 27, 2025 11:46 AM<br>
&gt; &gt; To: Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
&gt; &gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.p=
attan@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;; =
Jerin Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marve=
ll.com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan
 &lt;yanzhirun_163@163.com&gt;<br>
&gt; &gt; Subject: Re: [PATCH v2] pcapng: allow any protocol link type for =
the interface block<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; WARNING: This email originated from outside of Qualcomm. Please b=
e wary of any links or attachments, and do not enable macros.<br>
&gt; &gt;<br>
&gt; &gt; Hey Thomas,<br>
&gt; &gt; Thanks for the reply.<br>
&gt; &gt; Can you tell me the build command you're using to produce those e=
rrors? I have ran the builds on my test machine and cannot reproduce these.=
 Thanks!<br>
&gt; &gt; Dylan<br>
&gt; &gt; ________________________________<br>
&gt; &gt; From: Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
&gt; &gt; Sent: Friday, June 27, 2025 11:39 AM<br>
&gt; &gt; To: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; &gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.p=
attan@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;; =
Jerin Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marve=
ll.com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan
 &lt;yanzhirun_163@163.com&gt;<br>
&gt; &gt; Subject: Re: [PATCH v2] pcapng: allow any protocol link type for =
the interface block<br>
&gt; &gt;<br>
&gt; &gt; WARNING: This email originated from outside of Qualcomm. Please b=
e wary of any links or attachments, and do not enable macros.<br>
&gt; &gt;<br>
&gt; &gt; 09/06/2025 23:19, Schneide:<br>
&gt; &gt; &gt; From: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Allow the user to specify protocol link type when creating p=
capng files.<br>
&gt; &gt; &gt; This change is needed to specify the protocol type in the pc=
apng file,<br>
&gt; &gt; &gt; DLT_EN10MB specifies ethernet packets only. This will allow =
dissectors<br>
&gt; &gt; &gt; for other protocols to be used on files generated by pcapng.=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Includes a breaking change to rte_pcapng_add_interface to ad=
d link_type<br>
&gt; &gt; &gt; parameter. Existing calls to the function have been updated =
to pass<br>
&gt; &gt; &gt; DLT_EN10MB for the link type argument.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fixes: d1da6d0d04c7 (&quot;pcapng: require per-interface inf=
ormation&quot;)<br>
&gt; &gt; &gt; Signed-off-by: Dylan Schneider &lt;schneide@qti.qualcomm.com=
&gt;<br>
&gt; &gt; &gt; Cc: stephen@networkplumber.org<br>
&gt; &gt;<br>
&gt; &gt; I doesn't pass compilation test on my machine:<br>
&gt; &gt;<br>
&gt; &gt; Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm6=
4-generic-gcc/install<br>
&gt; &gt; Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64=
-generic-gcc/install<br>
&gt; &gt; Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-=
generic-gcc/install<br>
&gt; &gt; Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64=
-generic-gcc/install<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
<br>
<br>
</div>
</body>
</html>

--_000_IA3PR02MB107716434B37F31DC2949B587E943AIA3PR02MB10771na_--
