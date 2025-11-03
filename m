Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EE1CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 17:33:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 819FB402B7;
	Mon,  3 Nov 2025 18:33:15 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 6D16B40270
 for <dev@dpdk.org>; Mon,  3 Nov 2025 18:33:13 +0100 (CET)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3H2rxt3595028 for <dev@dpdk.org>; Mon, 3 Nov 2025 17:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject; s=qcppdkim1; bh=zC+Hv43rgjCbOTfbX3NFfa1flVM
 beQEvgoi3gnddDNw=; b=bcy5/TYS5Mav/ahQ2FeJiQf83Hju6hyZd/7H2xz1T4x
 vpZ5aCD7lTObvNhaqyFk454obfkmwZEgo5pdHr530fw8v0peuj8AuGeHlB7Zfu1t
 iJE757xxLhzC2S+pVMXFr0TRjQ/kwaO9I+CRf6DSAZx1aZJm/WvSoYN2zD26602v
 Bi6CQCbLJrDaunJn0qydc+VGZrGfSH4HDa30ONesxDvpuKOiHH4drr6Wfl+52Bse
 ww9CsJ1ED4f2r031WVeZNfhPeCoAyu1dKleQvddgQJTA+eJHm6l/8/P7li/wVP7f
 Vm2V4ITmwfhYNx2+x7uI9YE0G10bw/yJ8Tnw7QEKWAA==
Received: from cy3pr08cu001.outbound.protection.outlook.com
 (mail-cy3pr08cu00102.outbound.protection.outlook.com [40.93.6.106])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exg2w9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 17:33:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRBSGOYzayG7xMho2obpI03FfzNafJdlCnUuPZH087Aag+RZujcNaK91HD9AzdTVHcxJYwNRYyT3Tu9qHJqHcAQHyIeG5lKlDjH3Ev7nGvCg3XHeQmDGTfwT8IJwSwjae0At/fbVZMSPY/Px0qWg2q1QENTmtEcOhsnA3e61s017jNPTipTnmaMcu26dCHl9+bLkhktgm6HGoxgRuIIbsffOuqNG1NHIiqxldfb+UtFxCpy46P0qAzFgkIFwwXfOEuhRrdJo1mXfJ0mJDxeqVWfpV9b3PcbwwlsL/1wi5Nk4M5ojvnp9WhQammDWVcv9vvdXrnflIkox6SUK/DhwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC+Hv43rgjCbOTfbX3NFfa1flVMbeQEvgoi3gnddDNw=;
 b=wMCePtxrldvmDbTfyCVni/lME785KiOmu8JTJ2fzGwUJE9pP6MvfbF7Jbk6n+kpCLIh3EASkZ2Q4xFdJbR4Loa8x6tiPg7COCxb0juw3mR05EwTwZN+UDCrP31XbRVS9mGrgrxphIPvTFmUPIb00v+ICUEF9XaGg3VVyO36k6SLEXP0/mPmZoW9aDKQG2Ec6oauJjBdXAu1/tyXRDNB/UGaQjkH+UbxoPN8VVGyj+SS+o6Q2Yoinr2WTQZ8IJ1l7+Mb32TKXssvKgnhdyrj9ckpVB2ZVeZLfM+1jZmK3v6UiDakmC41Uhhpw6rTC8IHfgCQoXWHK12dx+UDUOWTddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by SJ0PR02MB8562.namprd02.prod.outlook.com (2603:10b6:a03:3f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:33:09 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::697:a925:e536:acbb%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 17:33:09 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] app/compress-perf: fix coverity issue
Thread-Topic: [PATCH] app/compress-perf: fix coverity issue
Thread-Index: AQHcRRazNkNdp20yqkaVN+UxsLw4zbTX08gvgAlxzWM=
Date: Mon, 3 Nov 2025 17:33:09 +0000
Message-ID: <SJ2PR02MB9795231F86B9DE127AC2657589C7A@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20251024184745.1698409-1-svaze@qti.qualcomm.com>
 <SJ2PR02MB9795341842DF1C4B70F7B32D89FDA@SJ2PR02MB9795.namprd02.prod.outlook.com>
In-Reply-To: <SJ2PR02MB9795341842DF1C4B70F7B32D89FDA@SJ2PR02MB9795.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|SJ0PR02MB8562:EE_
x-ms-office365-filtering-correlation-id: fc91484d-9403-4ee1-6cca-08de1aff0e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?x10e1p4RuIMmiVRz7eJJ48fxid9BDFwOUo4FaLGBffoCzZeIOvliRM5AoO2W?=
 =?us-ascii?Q?mAb+P5zqGlt5Ghxbkotsa+wYHPzuqjPYcAbQqwIETdGSgA0rH58ydRPH+Bev?=
 =?us-ascii?Q?KXJWk5/LQivSbNoF+SzsuTLzaOEzDRWf72PKtcQ+w59IwPPYjXiIflI2HcRS?=
 =?us-ascii?Q?v4CvHFuxZVRb+mn8TrQN01pSw5wr2xcrPRc3gXOx9uEesaPMoFoWhDS9Msbb?=
 =?us-ascii?Q?xE0SC0KpjX0nhzRNS3MJToYcASVM7eAr4gnx3llwTXtzk6gTiiH/U8rnf0vs?=
 =?us-ascii?Q?z2uXY09A43xciamfZ5cGYqp8Zk5xfiY3f2c/7l5hDxHIHgZcuJY+QTksf9Ps?=
 =?us-ascii?Q?o44r0Tjo6u8VfkSgGByBlH1DqbZqw68DvFQ+EBg2uKi3JsN4J+BCQ8B05dmI?=
 =?us-ascii?Q?jMZdyTRPCzfed7dwOfRrlCQWNBeNNrYQr0o8BCvpzszOk9sopYomFETnJXgQ?=
 =?us-ascii?Q?0lROAarlbD6TOxHu9WXDG3gU70W3ruoKaWyf2ebymmew60/ic7UwcWGbdqcj?=
 =?us-ascii?Q?slBQCc3OeYc4jjXos9xg7v6iyMqQfZR2Okm94o7zGwNPpPxnL68m4teN0f8e?=
 =?us-ascii?Q?P7nCi56M+gvlj6Oz0c97kW7Nquu3Qc4H6ZDqOKOOrteI+ofTJiZ28Ovtr8h/?=
 =?us-ascii?Q?fmtsklzJc1oT0QTxVvK1K/wBqnfvyW8SvpR0FQLrFHeTE+38YZPA7DddCkXC?=
 =?us-ascii?Q?R1OZXxk3k6TAuhup41/KDZM+Uuaudh7zmTdAXrl5pmDlgbgc/cWVaeud8OEj?=
 =?us-ascii?Q?qCBwMODyackxF2FRRZPY/w9VAe6p8LKvJMkBUDaoo+KXDpFQs3M0nIZ0MjY+?=
 =?us-ascii?Q?y8tKkNPC+iq+0l5VD+w6zgfVxle6Jxgp+gyYwl2Zmzy7uykTjkTmDkWc6ffq?=
 =?us-ascii?Q?6YlzJ+aVTM2zHLh1jq0VealAoTqrVdV6Hw0olhPlwitbWyJ7rhGCJTI9LGTk?=
 =?us-ascii?Q?x4AysV9DhArczPSpmU+8O28bz1U05kttkaY4P+2LcTej95n1A2vld6/2U4UN?=
 =?us-ascii?Q?V/sV6v/Li1uEzwPgEjQu4/f0Hh3zHH2MBBWDYDMqyyCjjhdNov11iIo/7UVK?=
 =?us-ascii?Q?uwjAQTBKDFBiHZMvMjenRgQNP49HWWQ4LU+nQwlDfC8aye57MDH3a230jLG8?=
 =?us-ascii?Q?7Y1zCKGje4YIoR32ycTdjxQ0ygjZPj+AgVvB2AFxS9AemLq9t96rZyvY+w2q?=
 =?us-ascii?Q?S30sDgMYZjC9tPBDgSISb+pePzXfnGmJ50oSvFZbuTnr8lFExVT/R8SIuZ+c?=
 =?us-ascii?Q?9eM3CgnsA2dBKcsk8emeITO01ydYOMVsaYCc6WPrnQty53eARTPTXLpzBr8b?=
 =?us-ascii?Q?I6jWZIi4lP43+Dqpe6ys0zijbUp6RsTo2YhqiT+jkX/VSr1rmhtV0DC98h64?=
 =?us-ascii?Q?21v4sZ82JzF0Fj1/Xc9gSzBARhIrAPRavTP8SRVyUA/7fjrUSzNha8ReVLFF?=
 =?us-ascii?Q?BNMSB4B9EyCfK2J38NUIaQnDaj4DAE4UoRVk0DKkiLDunPY3xE8/mRtA4vae?=
 =?us-ascii?Q?iytmkqz/qm/AYOBITao6WreIZQ9dwl57vRRd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njEQ6jgonAHLx0pjNtMUqTmbphkmmIzQ0i5LLKQOyXx5ACdIRwF+bJl9uAzv?=
 =?us-ascii?Q?Z6eN0cF1PE7AyU5jARNe1f97RG2S9VT/KfInMDzU265Nkn+KXrfye67kxqq+?=
 =?us-ascii?Q?Fu7n9iOGVe6Ifffjn5ic60C5kAx84Jbrt4qIn1+f5MLiAKtEoeL87hTuW41E?=
 =?us-ascii?Q?AbzS7RSeFamLbHix/IvaCf1QEWmfuzuivT1nA59wR+C4qEfPgoz477bPWSAj?=
 =?us-ascii?Q?xDFNbqfLh2BsYzvDHIYrgEfa9+3EhxrJ9t9fNO6NLp9LdSAb1H5BvCBPgpRs?=
 =?us-ascii?Q?W7BjosmhMF9PHMx3PI2HQ+vcm2f+1KV7Ck90EQ4xypElxuinY1Y7D3pBhEQP?=
 =?us-ascii?Q?tk0O9ea2B/eMMnFIFW6VqbXc1NyHK14oZ2J+LmIFGfqzr7a0GfNQUG8FUJRq?=
 =?us-ascii?Q?hTPQLl7g8UKgUkH3i4oF5bdkMAYTGK9woMXZppEeII98b6LgoygZ78th9vph?=
 =?us-ascii?Q?ZZ/nuioVr4Npx9zQa6HViWpqiCiS5eK5dQ3tN8we8stdjCgG4oYA9ClJb9RF?=
 =?us-ascii?Q?bg9v7i6kx+Ur5FbxaoNifA87myAY8U6sJcQyg8oQi+hQpiuOGHOwXHTX0Yuw?=
 =?us-ascii?Q?IjCKcKK1dS0hRSNcvxjAEyzMOKY7spoxM3aDMcrga6QZjipdqm6nhyANTS3b?=
 =?us-ascii?Q?Kv2BfwNLZz7qM/WVxL1pCZlStmd/xW0dWfD/NkbgK72B3biPoc3UJU3zPrK6?=
 =?us-ascii?Q?p74XblTXGwTEgNKK69Q4ihEykoCY/HZjP4tia7BpY9xmiOhdwoxTFhDbigBs?=
 =?us-ascii?Q?K6LkzrfHWFdRlFFGESYMckWplJelt/pUFo4qJcKTUzOHdx7BINbtHsZN67Gp?=
 =?us-ascii?Q?ou2sP5JM5MMrKTzsRS0CYNCP6LI/e5hrTvxpgo5KyZSMD7bv8k7GwVsdpkm/?=
 =?us-ascii?Q?o0DZqAoEHowR3gIQvUv5n/QTnTgD3kQpOeRInijTeAvlW908vhN681so/6rl?=
 =?us-ascii?Q?aSFZJh/aEewWkywJeZ98z7e1uALgKxRD7Du6JhoiwcFSIltcwsSrbf9ayswH?=
 =?us-ascii?Q?JqJ9i8pbKP3x9fRuFanu+fWI8YXkdTG+nTkJke3FGeDTD09KLSaEXU7pIw+e?=
 =?us-ascii?Q?wbJfjmxIPllcoNXSBXaPU4fRBvJTogTCiPfZI0P3Q8l9QpMfFs5ZQSn7TRXt?=
 =?us-ascii?Q?jhVxkzGkNcmpSC0xDHcofSxxVUm7ExjXpZUR3+rV+kIEo+dcW60purL3tPbA?=
 =?us-ascii?Q?n+txSjrBl2+ghdj0fDgxec8ptlTq2v/AhWbUvxV5NdV7yxqAM9qkoLDw79rs?=
 =?us-ascii?Q?N9SNZgvKT6kVfToMCk3A3ZcPsrqdyVfprf0BsRtyMGdr2SgdL1yNxiWSRvJ3?=
 =?us-ascii?Q?vtfetGLD/FGWKWt1jLSMdtuKdDTTB2Jp8gP89F312cA7bOjSWwuZuVfxGeMz?=
 =?us-ascii?Q?RuI06zB59Zn+Cwxg5DcATCBt07nQFmkoqeCWoHJ8xPW3KI9SrpJ1A4nNLuks?=
 =?us-ascii?Q?tAgA18Kya5gvnuW4XAFpgmf40pzab608xiwEfB0XbDKmFntt5sRbJXy187BF?=
 =?us-ascii?Q?bw0Mh/552/y3z/DHk18c29iUZOAYFzvFUqraegCtQTwbcs84OZUT/05dYgD9?=
 =?us-ascii?Q?eTJUTneSNqp7Dt18G4DZjaB09pCUvt50MsD/Ildu?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB9795231F86B9DE127AC2657589C7ASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hb9cjGu4BJwau6xSDhdRuaAsn7QHc3jtIfSgEx+ktSHUnjm07H+u5SOao7ph1SlFVOKJ8JzrZ7SvwpW6TH57bZE6JHygvyx8W7vYaS0wSMKU3f/A7GsCfkM1NY9HdEf49YhXKEJKXNdkbWBUpWD7XdHJA6g25cK7OGUEpbRTWnfgh5ep9QUIMs3OHBOxfdgPJwtLh9spGnhQo/Bt7JqXVx4ffqHgluPNXZKL8n2ZPyhNBpyNRZZhBirhx5bIqY532zufBjuDwFK+2kkem61ADvlfyW29jFZ2a3PffnUDoRcU5Fs9IT2v1x3U+DK97m+htAgunQ9xYdqnczYdLy3A0NXeMCgYsNlTO2LXH61yo6SwXI0yNcKll+YtFAnVt0LjMsPlC1qXZpUNYNjgDTQr9B49OBg9JMl2x0CH5CgZYt24lJopUzyCpJUSdsqJ47m4acyf8ZH0q9osRXVKeSd3Uk63RIpZKtAdegjeF3vzZ2C8P1MK1eRUeNgZVaLdRPJUZb0y+Y6Had2hgX5fDbZHIAe3Zew8RjF2Ds59vek8XxJwazbZAkRFavG2GTceRDxk3U+H6PV2R1OLVbDuJ9qhgpLR+pUTt3byq2kfMuHrokre8v0buzy84t17h2taZdnv
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc91484d-9403-4ee1-6cca-08de1aff0e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 17:33:09.5198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgQov7OmGN52uRIso9LTYMe9WRnyRM21jJ6P+l+bdKClQ56UKtH82cZhaMVywDu3xFBOho2VQFqrVUR93Kkz5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8562
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=6908e758 cx=c_pps
 a=DpTreEsoTQaklvYkDh6UiA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=9cW_t1CCXrUA:10 a=xqWC_Br6kY4A:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8rWy6zfcAAAA:8
 a=SxM26bOyJmv0ALaE1eQA:9 a=CjuIK1q_8ugA:10 a=xfbmT3IrJVpm7hlXS28A:9
 a=Q2i8-JGsdMOYpwta:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=DYNvvWTX9Sh4oU8lHtL3:22
X-Proofpoint-GUID: MaE10RxjeN3IN-1M1VBPHvPcshysKfuB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE1NyBTYWx0ZWRfXw/8c/Ss3wmhR
 a8zBMxnaU6WH/nctMHBAezfWGarzXpyaJSVdpUKvFD7j0QPCsQwgFPCZm2Sk4vfvWvyDcyXx5iM
 gU7PYXjiajhATryp3j62+Tj/l6iyeSze0dgQGyKTbZmUQb412mwVVTxw4qNcdB3mAtp3MpUhOxF
 My79PHxdKRPmEUv+tqcspDxLKoUuG5/BaSxBohU7E6IhDMpoGPKL/N8z76kL9ImWRH3WWOqzZLm
 FeB17tQh/t0aVSivfNdoyjsMyr/RTwl52ozZnGMlrXI1Z7IZTV5mJUtaiRTgbPWSIaCucBmffpk
 IEIkmxVXfAkVoqxT/XTZbQyVqKVSdgJM+UnCSwg2QjG2gmOjnLrM3lpXTHU/sfTGSBIm3tS3weH
 tSRgysgE7/4TEB4ahWQBuBIg2YJzog==
X-Proofpoint-ORIG-GUID: MaE10RxjeN3IN-1M1VBPHvPcshysKfuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030157
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

--_000_SJ2PR02MB9795231F86B9DE127AC2657589C7ASJ2PR02MB9795namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Recheck-request: github-robot

________________________________
From: Sameer Vaze <svaze@qti.qualcomm.com>
Sent: Tuesday, October 28, 2025 11:20 AM
Cc: dev@dpdk.org <dev@dpdk.org>; Sameer Vaze <svaze@qti.qualcomm.com>
Subject: Re: [PATCH] app/compress-perf: fix coverity issue

Recheck-request: rebase=3Dmain, github-robot, iol-sample-apps-testing, iol-=
compile-amd64-testing
________________________________
From: Sameer Vaze <svaze@qti.qualcomm.com>
Sent: Friday, October 24, 2025 12:47 PM
Cc: dev@dpdk.org <dev@dpdk.org>; Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] app/compress-perf: fix coverity issue

Removes possible assignment of a signed value
to an unsigned parameter. Also makes dictionary
an optional argument

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 .../comp_perf_options_parse.c                 |  2 +-
 app/test-compress-perf/main.c                 | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_options_parse.c b/app/test-co=
mpress-perf/comp_perf_options_parse.c
index 49197dc290..16d31c7e90 100644
--- a/app/test-compress-perf/comp_perf_options_parse.c
+++ b/app/test-compress-perf/comp_perf_options_parse.c
@@ -660,7 +660,7 @@ static struct option lgopts[] =3D {
         { CPERF_LEVEL, required_argument, 0, 0 },
         { CPERF_WINDOW_SIZE, required_argument, 0, 0 },
         { CPERF_EXTERNAL_MBUFS, 0, 0, 0 },
-       { CPERF_DICTIONARY, required_argument, 0, 0 },
+       { CPERF_DICTIONARY, optional_argument, 0, 0 },
         { CPERF_CYCLECOUNT_DELAY_US, required_argument, 0, 0 },
         { NULL, 0, 0, 0 }
 };
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index 11b016069c..59af073f12 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -355,16 +355,22 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)
                 RTE_LOG(ERR, USER1, "Size of input could not be calculated=
\n");
                 goto end;
         }
-       size_t actual_file_sz =3D ftell(f);
+       long file_sz =3D ftell(f);
         /* If extended input data size has not been set,
          * input data size =3D file size
          */

+       if (file_sz < 0) {
+               RTE_LOG(ERR, USER1, "Actual file size could not be determin=
ed\n");
+               goto end;
+       }
+
+       size_t actual_file_sz =3D (size_t)file_sz;
+
         if (test_data->dictionary_data_sz =3D=3D 0)
                 test_data->dictionary_data_sz =3D actual_file_sz;

-       if (test_data->dictionary_data_sz <=3D 0 || actual_file_sz <=3D 0 |=
|
-                       fseek(f, 0, SEEK_SET) !=3D 0) {
+       if (fseek(f, 0, SEEK_SET) !=3D 0) {
                 RTE_LOG(ERR, USER1, "Size of input could not be calculated=
\n");
                 goto end;
         }
@@ -386,11 +392,15 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)

                 if (fread(data, data_to_read, 1, f) !=3D 1) {
                         RTE_LOG(ERR, USER1, "Input file could not be read\=
n");
+                       if (test_data->dictionary_data)
+                               rte_free(test_data->dictionary_data);
                         goto end;
                 }
                 if (fseek(f, 0, SEEK_SET) !=3D 0) {
                         RTE_LOG(ERR, USER1,
                                 "Size of input could not be calculated\n")=
;
+                       if (test_data->dictionary_data)
+                               rte_free(test_data->dictionary_data);
                         goto end;
                 }
                 remaining_data -=3D data_to_read;
@@ -414,9 +424,6 @@ comp_perf_dump_dictionary_data(struct comp_test_data *t=
est_data)
         if (f)
                 fclose(f);

-       if (test_data->dictionary_data)
-               rte_free(test_data->dictionary_data);
-
         return ret;
 }

--
2.31.1


--_000_SJ2PR02MB9795231F86B9DE127AC2657589C7ASJ2PR02MB9795namp_
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
Recheck-request:&nbsp;github-robot</div>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sameer Vaze &lt;svaze=
@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Tuesday, October 28, 2025 11:20 AM<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Sameer Vaze &lt;svaze@qti.qua=
lcomm.com&gt;<br>
<b>Subject:</b> Re: [PATCH] app/compress-perf: fix coverity issue</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Recheck-request: rebase=3Dmain,&nbsp;github-robot, iol-sample-apps-testing,=
 iol-compile-amd64-testing</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Sameer Vaze &lt;sva=
ze@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, October 24, 2025 12:47 PM<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Sameer Vaze &lt;svaze@qti.qua=
lcomm.com&gt;<br>
<b>Subject:</b> [PATCH] app/compress-perf: fix coverity issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Removes possible assignment of a signed value<br=
>
to an unsigned parameter. Also makes dictionary<br>
an optional argument<br>
<br>
Signed-off-by: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;<br>
---<br>
&nbsp;.../comp_perf_options_parse.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;app/test-compress-perf/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 19 +++++++++++++=
------<br>
&nbsp;2 files changed, 14 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/app/test-compress-perf/comp_perf_options_parse.c b/app/test-co=
mpress-perf/comp_perf_options_parse.c<br>
index 49197dc290..16d31c7e90 100644<br>
--- a/app/test-compress-perf/comp_perf_options_parse.c<br>
+++ b/app/test-compress-perf/comp_perf_options_parse.c<br>
@@ -660,7 +660,7 @@ static struct option lgopts[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_LEVEL, required_ar=
gument, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_WINDOW_SIZE, requi=
red_argument, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_EXTERNAL_MBUFS, 0,=
 0, 0 },<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_DICTIONARY, required_argument=
, 0, 0 },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_DICTIONARY, optional_argument=
, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { CPERF_CYCLECOUNT_DELAY_U=
S, required_argument, 0, 0 },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { NULL, 0, 0, 0 }<br>
&nbsp;};<br>
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c<=
br>
index 11b016069c..59af073f12 100644<br>
--- a/app/test-compress-perf/main.c<br>
+++ b/app/test-compress-perf/main.c<br>
@@ -355,16 +355,22 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Size of input could not be =
calculated\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t actual_file_sz =3D ftell(f);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long file_sz =3D ftell(f);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If extended input data =
size has not been set,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * input data size =
=3D file size<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (file_sz &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Actual file size could not be determin=
ed\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t actual_file_sz =3D (size_t)fil=
e_sz;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&gt;dictiona=
ry_data_sz =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; test_data-&gt;dictionary_data_sz =3D actual_file_sz;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&gt;dictionary_data_sz =
&lt;=3D 0 || actual_file_sz &lt;=3D 0 ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fseek(f, 0, SEEK=
_SET) !=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fseek(f, 0, SEEK_SET) !=3D 0) {<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Size of input could not be =
calculated\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -386,11 +392,15 @@ comp_perf_dump_dictionary_data(struct comp_test_data =
*test_data)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (fread(data, data_to_read, 1, f) !=3D 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_L=
OG(ERR, USER1, &quot;Input file could not be read\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&g=
t;dictionary_data)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(test_data-&gt;dictionary_data);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (fseek(f, 0, SEEK_SET) !=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_L=
OG(ERR, USER1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Size of input could not be=
 calculated\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&g=
t;dictionary_data)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(test_data-&gt;dictionary_data);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; remaining_data -=3D data_to_read;<br>
@@ -414,9 +424,6 @@ comp_perf_dump_dictionary_data(struct comp_test_data *t=
est_data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (f)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fclose(f);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_data-&gt;dictionary_data)<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rte_free(test_data-&gt;dictionary_data);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.31.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ2PR02MB9795231F86B9DE127AC2657589C7ASJ2PR02MB9795namp_--
