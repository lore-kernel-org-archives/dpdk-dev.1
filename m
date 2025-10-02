Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E00CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 16:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59ADB4042F;
	Thu,  2 Oct 2025 18:37:58 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 96D0F40268
 for <dev@dpdk.org>; Thu,  2 Oct 2025 18:37:56 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5928LvRe022677;
 Thu, 2 Oct 2025 16:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WFin/l6MkxnVFpqZjnh/l1Wx
 QsBcCdZmjrB84fPpRq0=; b=Tj9oXi43jl9HhYBjQkYYHQEELp0wA+xnnX3SQnzF
 PGCzyh7sffx63BHTlNkhU4xg90FpJEizSN1Qp9+p0DFg/5KF0bmKKVebO+2pl9Ue
 49gtqUQCth6EQSsQfLox6vjva1IoAazF1iS8P55eDjMKluVX5U7qGzbYLmfi6lps
 4Hd9sGXY8mOD4BS/r5YHWOjtH/BAE2WTL7dTGxmX9YU68lODL0nJm3xj9atLKK6T
 ytTNvz1tbn8WYDr3y1UGFGG716XQy4miQys14qwkNNh/9Nh3l3XTpjntJolTDAxF
 3gOgVH2N4XSxJOwArNtry9sjF4Vp6YF//hrAUNa0LeSj9Q==
Received: from ds2pr08cu001.outbound.protection.outlook.com
 (mail-ds2pr08cu00102.outbound.protection.outlook.com [40.93.13.74])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n8rt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 16:37:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T46etpR3yCj/woPg7NC4UBskwwm+oPqXMKC2MrFxuK+UYN0P/8szs6aNmB7fcNl2C5xyBkpzg2w6iD49243LEAzKs0lzy3nyq+TCSntZ+PoZsP1Gqgn9T55vEeX5jFA+wpW0rw1BzILJOusGFspqZqp6XKg+kKmmJUliklUMGf4rjt+Vgn0HMHmcIDp6mKUeg/2vUkgYidgiDZWtpIzlTiVfYSWfekU4S6JNcOycK8wWB9ZuARTjFeSpMfXixQE6SNQLrgp02Xm3dsEcYa5P0px6HGtCvgnJa3mzSCwu/u1CuKtHLiOEl1UDHowx5zm9IY7HpRK0MGK2iiTBAFUuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFin/l6MkxnVFpqZjnh/l1WxQsBcCdZmjrB84fPpRq0=;
 b=PtPcr0S51rxp/u9nMA4HN20R6DoNoHqzu14pxk/y1HBi00Hqb9lhia51Ba4DLnIa0t4ZVNc0qnKoZdiJ+hd2lSZBA4syXRH3lTF9/4h0731Sd4/SDSj3JSVBnO1DqxkqZt8ORmhoOWhoZ3BlBDLptIckHYQSZ5P4anzwk/nrDpo2KCotq+xDzTdZ5P3VdVYqTrJNwKHTk251mWWG05nS1TlKHUKroJ6NVKZcGQxS6ZeKe+LrI5peZbGxOIDtVFc6OQ5l0+ZnG6cMufs3H6vfqs117HHouTISpulU1cWk8iU60t+1R15WDqrzSxW5AD9J5JnfNhIX9mKWYLRfBN6BxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com (2603:10b6:a03:549::7)
 by SJ2PR02MB10146.namprd02.prod.outlook.com (2603:10b6:a03:554::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 16:37:50 +0000
Received: from SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::5f1:dcbe:bb2f:83d8]) by SJ2PR02MB9795.namprd02.prod.outlook.com
 ([fe80::5f1:dcbe:bb2f:83d8%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 16:37:50 +0000
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Topic: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries and
 PDCP checksum
Thread-Index: AQHcLW7+Yx3s32UTiUaGijgdWUWe3bSsL5oAgALpJYA=
Date: Thu, 2 Oct 2025 16:37:50 +0000
Message-ID: <SJ2PR02MB97957A1B0CF42BF92F77941689E7A@SJ2PR02MB9795.namprd02.prod.outlook.com>
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
 <CO6PR18MB4484EEAC621E731A4E5E64C8D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484EEAC621E731A4E5E64C8D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9795:EE_|SJ2PR02MB10146:EE_
x-ms-office365-filtering-correlation-id: e97dc594-f6be-469e-e0bb-08de01d206d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?Windows-1252?Q?6iRq64vcMPtRfXDvNxxD6e3WddrE1o5ITml9GB5cs5mci8LfbVGOfgAE?=
 =?Windows-1252?Q?katgnpsV2H4MRaToYu5DnASp3ceZhzSYgruOpuieNmCjpZf+iCPVcyhQ?=
 =?Windows-1252?Q?kZJTxV1p2IGeDKuj9ReaSbXCF1DoycMBL8IokGE7v5bctjTObitZaKpf?=
 =?Windows-1252?Q?HRj7mfI2KZs/UeGCAecgqcJkuIWV5fYE7avbKXSIXNY1/2vUseoyhckM?=
 =?Windows-1252?Q?2NbpUlTCqslB3550lrBcvDcNo8w7joRBNERffB3ukEAFrGx90JXDOuNk?=
 =?Windows-1252?Q?PuMG6vtIAF2moOK2pdkpg0bsUCwDnjXI0qGFtUwBopyBW61yMSKlx4x+?=
 =?Windows-1252?Q?fdt8LdgtGrytXLgQlfrQLxCVw4DdmGTsbRDV6U05iCW2kiQb790/MPFh?=
 =?Windows-1252?Q?vYmW473lO7pTHB+Id617XyKDUOeZQLhxHNtgFnLGFblifXCjXZp5rDhP?=
 =?Windows-1252?Q?fIGYQqgJadSzzXZbhX+oluPiNPNxEkWFWAdlcRrNuLhDehi/rNYdw8r9?=
 =?Windows-1252?Q?dSRvFuU6rgvIhsg2InNHKv+a811etL6xqXnOzskodishq9HLnpUViUEN?=
 =?Windows-1252?Q?GwynOqpPWxoHmQjqMdNhL7qOpTxzgBpGx7Ml8hQuran/FnAOseACzYiF?=
 =?Windows-1252?Q?okUaInInrHd4NnoiiZWiW6/s8Pk7yDhV65lW085W8ITfZFbnEIz1PhYE?=
 =?Windows-1252?Q?33XqMMUl2nzzTB0DQpjUqQk3ky/glmAhls5hTI8d3R0d/UiOplSOVFiJ?=
 =?Windows-1252?Q?O0s2dqzj6AadirpTfSIDKLtj9Bjbk6DzDRAGOiQpnVzJgDjgKClxOD0P?=
 =?Windows-1252?Q?0rGaRQ/LZRQUqW3sBsSKPsywU36oPDG6/7vCxkaJv/jSJwzIAXCjjj5j?=
 =?Windows-1252?Q?hbjtQ4pFHHI0bSGTxH4bamGB0mdhOxDXJMQbA41Idb1sm8hLSMl3vSBV?=
 =?Windows-1252?Q?/+zODMCMfbxgbGRGxrFphKsdc3cfK5/mDsIzVbA1VkcFVpb64QmkRzL/?=
 =?Windows-1252?Q?DyLfnd40VHXem9kZyEkdTTGPz38SlRuGCrKX7dANIE9WVHIObUDIE20+?=
 =?Windows-1252?Q?6yuVISsLH2EBJDPt5e5jeQeh+SKwU/PGK4fwWCtcKPlNrBVFgkysDc4e?=
 =?Windows-1252?Q?ItmMiS8tSywW2lzD7mAJ7bcg2qDnZd07KqHa5cZVbMbi9d4KzOwsJAlI?=
 =?Windows-1252?Q?tv44c0aj4bmwQe2/2/KK9frDTTckeBbUKGF0n0U3nb9S9FwP911PbMyP?=
 =?Windows-1252?Q?XUB29nq7yBJmIkEkXnq7ICpBs+0awLz5ceNWQNox9VB9BxdATrje24hA?=
 =?Windows-1252?Q?YhBJsTihd6CBGTl4JKFeV3XYcX4cx5fRIGKbeHID6duRrRvCiIZuuSoc?=
 =?Windows-1252?Q?K8PhqCziwP04luMvfDw13cYi34g6PYJt9x9w+qhca48SyxTWhN48t0+V?=
 =?Windows-1252?Q?/MdPmsLtEPMM3ObCZ+xppb7WSKb9k6EmOGFIS9CuUBuSt11GP5y3qp/9?=
 =?Windows-1252?Q?r4Q6w3wS1Im9a/S92tcNkBiENxRIULmWwviqxZup2xd4HwHZUx7/UbqY?=
 =?Windows-1252?Q?Y6F9Ebl85kkZ8l6LGzu1Sp03CSul72untP+ocQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9795.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?MaPvuw13Go6O2EbzWOZzbJ9UIJZKj8ZdH5v9nXaHFaw2AVJknygqtttp?=
 =?Windows-1252?Q?XOfN5J+tYABdMYUQves0kylFe5oSr3ghi9bX2cfYvfGwzHEjMvM+mCZj?=
 =?Windows-1252?Q?SkO/YSuuFzLiQVHb1wmmRUvlWJn2ox7sSzbEPzUG5txPb1OiQDsm4D+1?=
 =?Windows-1252?Q?xDQBSizWbXQ2Cru27f5IxbQ8Ga7D+kalygNxj0oT9YUVsQrjagP/dzxa?=
 =?Windows-1252?Q?TUdBSuJm7ZUMuQDEKcDC40/vaK++MlB6nDsI1KXK3SiV4BdF2hB/CdVd?=
 =?Windows-1252?Q?8x81yA5eu5A4aQrPB6r+FIbp8K3eLduCu4m7aLeI1bjgENCmK5kkKFIf?=
 =?Windows-1252?Q?BqcUZAnbdUfmjx8nCU1ncddV6l0i/EJJU0N33ZnPpJ1ZBw9beDWiJ18P?=
 =?Windows-1252?Q?ED7heA2kYVHXdGDAkJCd0MXYvpnztQdB8cVATfNs70AERykFoJ0dYLYR?=
 =?Windows-1252?Q?Hfhq17AgDEChOviUrIkzGCmAmCMSf4oMlt6tJ1GPZGmHsAKgfM6jbplw?=
 =?Windows-1252?Q?2as2T+qX3NvpcQ/M0Ond7LZETui2phHvGJy/7OYE/jNDICindqRx24Ts?=
 =?Windows-1252?Q?g881qiaZZ+/EN4nrLl4tlNrV8ioymECIyZpZ2ubpGfW6kmBxdplv2Zqp?=
 =?Windows-1252?Q?lQjDqdDr9cmnnUMItcWRDkV9owMqV8skzvj1kxcL4nnPTlfF9y8I17zM?=
 =?Windows-1252?Q?bXNz6XnxV6KnkTgV7WhtYDuQwpft6CxVNd9NWAX+GLAHDwiPsy9NZxlq?=
 =?Windows-1252?Q?1THerAqF69Wro0P1DTjsNQBD3eos35xsdc4YqyuPyrCic3efyL3O0ydG?=
 =?Windows-1252?Q?/5zB+9YHQkFSzdxWPkL64wzuOxAH2W54QxxSPUzAhN1fi4RUazZONEg9?=
 =?Windows-1252?Q?s9fqeGyIfJnb39fduIU9Qer65N9eJHTkKRH0x/gY5XQ3x4HTUSkZk0Gt?=
 =?Windows-1252?Q?ALJdGr7KmDAuURoHOvrd4GDfz9HPqhFfoeIlEnkwQwYPneD/JF/EwRPU?=
 =?Windows-1252?Q?0wnV5cZdMxghN4ImMDdpEyGnpkTag3ryBAHZBdmU2B7KPCRdTfOi3LJt?=
 =?Windows-1252?Q?qNSquznMGoCp4NVuy3wYhJnm3Inkkhe3tx3WgLU4fbBFBlLpnqAvSsAu?=
 =?Windows-1252?Q?SgB87Q1MZA2vhQV+n92KbbJtv9xBySMNyrz7Ps1G4lzh/5pe1vyNgvEa?=
 =?Windows-1252?Q?t4Wv0bikzD9DMCyBqiV1BNE58QQgWdYGPHOJEZoCfzxC+VHuhzEfqIQL?=
 =?Windows-1252?Q?T3SjVOGzONGYTiTLPn3sYrPxw0Y9Vrgpy5VlJReXavYM57qMw1WaECj5?=
 =?Windows-1252?Q?4jcg/RtbAp5BX74DW7x8kFyLg7EikmrW6PjyTId64WhKPiIDjFG3h4Jc?=
 =?Windows-1252?Q?DLN+jDjbScA8vPXHtpxm3+aPVL2COxm73G4JLqZ3tPjeSZWhH3I9IyJH?=
 =?Windows-1252?Q?XqKVELhW7q3YcafvH/HJBTLWTXUlLksIxaBO+UjcACfpbUQzqAOA7AgM?=
 =?Windows-1252?Q?VVaguU0DoTIlRp3gE2iM830q3SxToPvfBLfXTC7NfmJzTCpgrInjU1Ub?=
 =?Windows-1252?Q?eMSRAreYvEuaeJmtNMfncYwfZscp/g9MjaF+IZaPRL8dWLYpuLVFGTpY?=
 =?Windows-1252?Q?dWH2j0lbBrGb/3psRm0jwCm2jo4ConU7IUHpA0qt6slySklyPh0U7eZk?=
 =?Windows-1252?Q?EeaBJeEd7WtVtHlhQjUe8/haayMiXJGB?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR02MB97957A1B0CF42BF92F77941689E7ASJ2PR02MB9795namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Y6sVHpnHI0R+x+1UF/35AJDFTh4ZklzxZJzqySQHa1+1I72OA81hNaNxIGuhN3XNnqLFkv3Sb+RpYzsVGNAyfhi5vatXIYREan0zE0cYDFhhUkHd5dcIZF8VFFg+/xNgGEotRQtaa4va5WbuV3A6wjxa8NQa4KZ0t6vOiVc2H+v3CyaK39arSdm/nXMZHFk5H4KpMSCs66lwyCsaLcoTVSobNzWNbBHS380Lzm3wDN7WiVwg0Gj8043+gF/M+8nAkF0U3cebiFcdznzisCwNc90lDvwrLoeOvqtT/XjhWYeRDpbI43X/Ou3aDLnfYjBA/P+NTXuZLntLRc1kW4JCFySkEpHR7ePIzlNYw3CBNSKHfaili77nEthMCfaqPZNTALwUNyPVFN63BQGZVJhBz2F0hmJ6a5yL2iq3K0QLjHALBEyeIdOifHp6fx7rEnVesA4EpCmGqbACDOrQk5Xt5kNfpNWyhJpmC3hDuBrf5bbOUE5BYAN+yWsghFFUXdIWcDIzAg6iWmb99vjoxYcMcs5O9JxvQHWQuOfm0JVK8mmAa0EcpY66DA67CVbrmBht/fMG896IOre7+e5Tiv2pcLcnesCE1kvCuCZdi54qHY8J5dCSln0f7LBSXdlFBSE
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9795.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97dc594-f6be-469e-e0bb-08de01d206d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 16:37:50.2130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4CYeKRfyrE9tQmsg7A2+adxMCtMPMeluX2XM53aXtYkONFRqtidQWSbcRoYR6oa6sJIZ02JREQLMC7ne9i9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10146
X-Proofpoint-GUID: FmzINqbzS6nScfewA0VIhcHVfwM0yuaw
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68deaa63 cx=c_pps
 a=1w3Rox83O5gulhrCDwffwQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=EIAOKESg_tosXtsA9k0A:9 a=pILNOxqGKmIA:10 a=k13SdgfryrkA:10
 a=2OaGk-CoAkM_qQecO_gA:9 a=hwpe9LhNdS7GZWtV:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: FmzINqbzS6nScfewA0VIhcHVfwM0yuaw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX16pOu1fw79kB
 o52NcHJz0IOSyNy/cr8mbd6SHOO7DJPI3yyp8q/d3B/9YzAiiGeO/NLZW6HoY1yKt7UQO11Qgma
 nm0daRCW2zBLEZIe/h8re3TnvzKdmpUDExq4qeaI81VBpQ54CxmPfbYdMg946l4U6n0dOpNRfOi
 y5Tt/LCEYbSHLye95lCABKqIZCEmTvVZ0Y5/BmeLPYIXnmjT/5DYr8yWRB087Q20Nm7lEYqbBIE
 TlJ/ho8/neQSB9pCQrnfgWaLkNa3c2FkIw3vaz/Gz95vxv4meRLa6NeIJv56oXLdqkJ8vPFxqYd
 TXcLn1CKdkZgUSxsd+erUmM+zA8cJPaXd/WXwGMtbG/IkpWtrobxv/COKQyLcDi3ZVbYl9Abbo8
 EF4V1wk9Bn7uzqz2jZJyumBazN65Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001
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

--_000_SJ2PR02MB97957A1B0CF42BF92F77941689E7ASJ2PR02MB9795namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Sorry for the various series I pushed. I attempted in reply to but it seeme=
d to create a new series. If I am making changes to one commit in a series,=
 do I need to resend all commits with an updated version? In such a case do=
 I reply to the series or the specific change I am updating?

Regarding the comments on adding UDC as a new algo: UDC uses raw deflate an=
d is not a separate algo in itself. Support for pre defined dictionaries is=
 already supported by zlib and is not UDC specific per se.


Thanks
Sameer Vaze
________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: Tuesday, September 30, 2025 2:03 PM
To: Sameer Vaze <svaze@qti.qualcomm.com>; Fan Zhang <fanzhang.oss@gmail.com=
>; Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 1/3] compressdev: support for dictionaries a=
nd PDCP checksum

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hi Sameer,
> Adds definitions for PDCP checksums and apis to pass in
> dictionaries
I think you need to define new algo UDC as well.

>
> Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>

Please update version in the patch title while sending the new version.
It took me a lot of time to figure out which version I should review and re=
ply to.
I can see there are 10s of series spammed without updating the version.
Please take care of this while sending the next version.
Also add in-reply-to tag of previous version while sending next version.
Please check https://doc.dpdk.org/guides/contributing/patches.html#sending-=
patches
https://doc.dpdk.org/guides/contributing/patches.html#the-review-process

> ---
And you should also specify change log here after ---

>  lib/compressdev/rte_comp.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h
> index 96d9b276dd..169d3d960e 100644
> --- a/lib/compressdev/rte_comp.h
> +++ b/lib/compressdev/rte_comp.h
> @@ -101,6 +101,10 @@ enum rte_comp_op_status {
>        * is not an error case. Output data up to op.produced can be used =
and
>        * next op in the stream should continue on from op.consumed+1.
>        */
> +     RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED,
> +     /**< Checksum validation failed. Either calculated does checksum no=
t
> match
> +      * the one provided or there was an error calculating the checksum
> +      */
>  };
>
>  /** Compression Algorithms */
> @@ -166,6 +170,10 @@ enum rte_comp_checksum_type {
>       /**< Generates a xxHash-32 checksum, as used by LZ4.
>        * https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_Cyan4973_xxHash_blob_dev_doc_xxhash-
> 5Fspec.md&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DDnL7Si2wl_PRwpZ9TW
> ey3eu68gBzn7DkPwuqhd6WNyo&m=3DYLWffSHu_HeEi63ZTpMIS7uCsbTGlu1gZDDe
> Pxv8nL7v3JAvIdKcNrrUq3BR5Y22&s=3Db5bCLrPbUjjxy1ItxfYQOUoHAnDjqjVwVfh6il
> TDCIw&e=3D
>        */
> +     RTE_COMP_CHECKSUM_3GPP_PDCP_UDC,
> +     /**< Generates checksum as defined under Uplink Data Compression
> +      * checksum as defined in the 3GPP PDCP specification
> +      */
>  };
>
>  /** Compression Huffman Type - used by DEFLATE algorithm */
> @@ -201,6 +209,11 @@ enum rte_comp_flush_flag {
>        */
>  };
>
> +#define      DEFLATE_MAX_WINDOW_SIZE (1ULL << 15)
Wrong namespace used.
Are these really required to be defined here.
I do see any comments where these macros will be used and what is the use c=
ase.

> +
Remove extra line here

> +#define      DEFLATE_MIN_WINDOW_SIZE         (1ULL << 8)
> +
Remove extra line here
> +
>  /** Compression transform types */
>  enum rte_comp_xform_type {
>       RTE_COMP_COMPRESS,
> @@ -305,6 +318,15 @@ struct rte_comp_compress_xform {
>       /**< Hash algorithm to be used with compress operation. Hash is alw=
ays
>        * done on plaintext.
>        */
> +     uint8_t *dictionary;
> +     /**<
> +      * Pointer to memory containing dictionary to be used for inflate
> +      * and deflate operations
> +      */
> +     uint16_t dictionary_len;
> +     /**<
> +      * Length of dictionary to be used
> +      */

Don=92t you need to define UDC in rte_comp_algorithm?
And move these algorithm specific fields into a separate struct and add tha=
t into the union defined above in this struct?
Seems patch is incomplete.

There is no update to documentation as well.
doc/guides/prog_guide/compressdev.rst
doc/guides/compressdevs/features/default.ini

>  };
>
>  /**
> @@ -328,6 +350,15 @@ struct rte_comp_decompress_xform {
>       /**< Hash algorithm to be used with decompress operation. Hash is
> always
>        * done on plaintext.
>        */
> +     uint8_t *dictionary;
> +     /**<
> +      * Pointer to memory containing dictionary to be used for inflate
> +      * and deflate operations
> +      */
Please make this in a single line if it is under 100 characters.

> +     uint16_t dictionary_len;
> +     /**<
> +      * Length of dictionary to be used
> +      */
Make this also in a single line instead of 3 lines as being followed for ot=
her fields.


>  };
>
>  /**
> --
> 2.31.1


--_000_SJ2PR02MB97957A1B0CF42BF92F77941689E7ASJ2PR02MB9795namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Sorry for the various series I pushed. I attempted in reply to but it seeme=
d to create a new series. If I am making changes to one commit in a series,=
 do I need to resend all commits with an updated version? In such a case do=
 I reply to the series or the specific
 change I am updating?&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Regarding the comments on adding UDC as a new algo: UDC uses raw deflate an=
d is not a separate algo in itself. Support for pre defined dictionaries is=
 already supported by zlib and is not UDC specific per se.&nbsp;</div>
<div id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
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
<b>Sent:</b> Tuesday, September 30, 2025 2:03 PM<br>
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
Hi Sameer,<br>
&gt; Adds definitions for PDCP checksums and apis to pass in<br>
&gt; dictionaries<br>
I think you need to define new algo UDC as well.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Sameer Vaze &lt;svaze@qti.qualcomm.com&gt;<br>
<br>
Please update version in the patch title while sending the new version.<br>
It took me a lot of time to figure out which version I should review and re=
ply to.<br>
I can see there are 10s of series spammed without updating the version.<br>
Please take care of this while sending the next version.<br>
Also add in-reply-to tag of previous version while sending next version.<br=
>
Please check <a href=3D"https://doc.dpdk.org/guides/contributing/patches.ht=
ml#sending-patches">
https://doc.dpdk.org/guides/contributing/patches.html#sending-patches</a><b=
r>
<a href=3D"https://doc.dpdk.org/guides/contributing/patches.html#the-review=
-process">https://doc.dpdk.org/guides/contributing/patches.html#the-review-=
process</a><br>
<br>
&gt; ---<br>
And you should also specify change log here after ---<br>
<br>
&gt;&nbsp; lib/compressdev/rte_comp.h | 31 +++++++++++++++++++++++++++++++<=
br>
&gt;&nbsp; 1 file changed, 31 insertions(+)<br>
&gt;<br>
&gt; diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h<b=
r>
&gt; index 96d9b276dd..169d3d960e 100644<br>
&gt; --- a/lib/compressdev/rte_comp.h<br>
&gt; +++ b/lib/compressdev/rte_comp.h<br>
&gt; @@ -101,6 +101,10 @@ enum rte_comp_op_status {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is not an error case. Outp=
ut data up to op.produced can be used and<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * next op in the stream shou=
ld continue on from op.consumed+1.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAIL=
ED,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Checksum validation failed. Either c=
alculated does checksum not<br>
&gt; match<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the one provided or there was an err=
or calculating the checksum<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; /** Compression Algorithms */<br>
&gt; @@ -166,6 +170,10 @@ enum rte_comp_checksum_type {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Generates a xxHash-32 chec=
ksum, as used by LZ4.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * <a href=3D"https://urldefe=
nse.proofpoint.com/v2/url?u=3Dhttps-">https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-</a><br>
&gt; 3A__github.com_Cyan4973_xxHash_blob_dev_doc_xxhash-<br>
&gt; 5Fspec.md&amp;d=3DDwIDAg&amp;c=3DnKjWec2b6R0mOyPaz7xtfQ&amp;r=3DDnL7Si=
2wl_PRwpZ9TW<br>
&gt; ey3eu68gBzn7DkPwuqhd6WNyo&amp;m=3DYLWffSHu_HeEi63ZTpMIS7uCsbTGlu1gZDDe=
<br>
&gt; Pxv8nL7v3JAvIdKcNrrUq3BR5Y22&amp;s=3Db5bCLrPbUjjxy1ItxfYQOUoHAnDjqjVwV=
fh6il<br>
&gt; TDCIw&amp;e=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_CHECKSUM_3GPP_PDCP_UDC,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Generates checksum as defined under =
Uplink Data Compression<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * checksum as defined in the 3GPP PDCP=
 specification<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; /** Compression Huffman Type - used by DEFLATE algorithm */<br>
&gt; @@ -201,6 +209,11 @@ enum rte_comp_flush_flag {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; +#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEFLATE_MAX_WINDOW_SIZE (1ULL &=
lt;&lt; 15)<br>
Wrong namespace used.<br>
Are these really required to be defined here.<br>
I do see any comments where these macros will be used and what is the use c=
ase.<br>
<br>
&gt; +<br>
Remove extra line here<br>
<br>
&gt; +#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEFLATE_MIN_WINDOW_SIZE&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 8)<br>
&gt; +<br>
Remove extra line here<br>
&gt; +<br>
&gt;&nbsp; /** Compression transform types */<br>
&gt;&nbsp; enum rte_comp_xform_type {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_COMP_COMPRESS,<br>
&gt; @@ -305,6 +318,15 @@ struct rte_comp_compress_xform {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Hash algorithm to be used =
with compress operation. Hash is always<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * done on plaintext.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *dictionary;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**&lt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Pointer to memory containing diction=
ary to be used for inflate<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and deflate operations<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t dictionary_len;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**&lt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Length of dictionary to be used<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
<br>
Don=92t you need to define UDC in rte_comp_algorithm?<br>
And move these algorithm specific fields into a separate struct and add tha=
t into the union defined above in this struct?<br>
Seems patch is incomplete.<br>
<br>
There is no update to documentation as well.<br>
doc/guides/prog_guide/compressdev.rst<br>
doc/guides/compressdevs/features/default.ini<br>
<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt; @@ -328,6 +350,15 @@ struct rte_comp_decompress_xform {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Hash algorithm to be used =
with decompress operation. Hash is<br>
&gt; always<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * done on plaintext.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *dictionary;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**&lt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Pointer to memory containing diction=
ary to be used for inflate<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and deflate operations<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
Please make this in a single line if it is under 100 characters.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint16_t dictionary_len;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /**&lt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Length of dictionary to be used<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
Make this also in a single line instead of 3 lines as being followed for ot=
her fields.<br>
<br>
<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt; --<br>
&gt; 2.31.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR02MB97957A1B0CF42BF92F77941689E7ASJ2PR02MB9795namp_--
