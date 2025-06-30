Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A19C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 13:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3E574065B;
	Mon, 30 Jun 2025 15:50:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id B7E7740291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 15:50:26 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8DNFG024769;
 Mon, 30 Jun 2025 13:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ACUULNobDMDKex1oU8/1j3Qe
 60BPuxgT3jc68OY+gcg=; b=BDnygOeygm79svB/C5ZkohQAJYx/KRVRbjTtXhpG
 02ZDOa5cuAKwwzAD8IrXPqC1HIA/5uVJKwgAqQyilwwiMf14QjCLU/LRNS/Mt6EC
 P9qxhA4bCaIEE+19H9zXYzQ2eiNLyPXBIaETWxlVR5Kv0OE9KCFFV2CiVYY7Zmjp
 VfclVlc8VUc7cfPW/+e8QzYBKnltqfu4zVWYAYGzajLq06DbQb0JUyGgCcbycSw+
 enymw55R+CflkUTLCAK7M1PHRXUnliKEgkX67365SawiPCOa9t1ONHhjzNhx/pPI
 lMloQLlBOtTpf5rNzYIJhMuZ/uxDtaeL6LdM+NGSWm31Dw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8s9cxh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 13:50:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM0u7ONZIlSJjmBSU3s2lmaLjqpeBojAWWZh153n+qBWpv/7/yVR3ToLNWRxIASovcMztzjSqTt92G+CbICX02f7xLk7vNRrbujLAKNcadUfK7rZZWbkfy4x+kzvPHGhqkk9nBDkdvYew5U3fN+EYVRwsGZ9D853vwQxHqiQKQG5WFGzGEUt/AGkzGFQazKEBhNVzGtETHVdQ1aObQrwxzRKFguAMqmG/r90Vjb62dya2yMCzUQcL7znqkZZBsyoxESJ40qS/3Vvx7v/MzG/1tEZKXvP/L72rkR1Pc5svWpf5xF4EBqa6NMIxXFzmAYAsH1Rmcyr0Ycf+K3bZzx3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACUULNobDMDKex1oU8/1j3Qe60BPuxgT3jc68OY+gcg=;
 b=Q3PkiqCNFt7+jkE1vS/lJnSLtcIN19VsY0mXClfuPKxtCyW09JNFutVdhrT9Axs/ibWiV2zWP+T0AIKVASHVS+oQiEW5Gi3Ve/punzC/NEjeXxg4iku3A7kHID1E5qz5/7YrX/+lT6sswHR21bGvAjtUpk12E1Znyvqkya1NcUJKqGo8cGM3NYnUN5W5LKcOpQFBRiKlwKM58wYDk6JU9cuXxb+JAlf0DC9VG9kE65iuK9UJB465eZ2VrbTOyJQOKwx25pFe3QUQKl2aJ3SCvj/riz6zEJz6KqEcYBFSU5c8a9VGwghjMWZRLx8oKo10h1wYGzKXI0Z4p21eFGpvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 (2603:10b6:208:509::11) by DM8PR02MB8103.namprd02.prod.outlook.com
 (2603:10b6:8:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Mon, 30 Jun
 2025 13:50:16 +0000
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5]) by IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5%3]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 13:50:16 +0000
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
Thread-Index: AQHb2YQ73VfknzRgqUKIslHGkPlGlLQXYbIAgAAB7lSABHUkSQ==
Date: Mon, 30 Jun 2025 13:50:16 +0000
Message-ID: <IA3PR02MB107711F11A8681D42D5B911B4E946A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250609211937.345620-1-schneide@qti.qualcomm.com>
 <6923574.A9s0UXYOmP@thomas>
 <IA3PR02MB10771799502C67457C7CBE257E945A@IA3PR02MB10771.namprd02.prod.outlook.com>
In-Reply-To: <IA3PR02MB10771799502C67457C7CBE257E945A@IA3PR02MB10771.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB10771:EE_|DM8PR02MB8103:EE_
x-ms-office365-filtering-correlation-id: 6ad46187-b6c2-4f79-4129-08ddb7dd0b5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YhU/wSgtSTo7ROJLjjPNtMZO5CbyIm4gCKIgHkooJfj1M9fAIcuT6SOR+nkn?=
 =?us-ascii?Q?7gkl+pKffkF1X3uu8S9h2c6c/jX/JwD89CCCSJFkBbvnFt3WYC05d/33inny?=
 =?us-ascii?Q?gg4hexcF9fcuIBCclfdkLW85Gz+70dl13ZHJlf2qRFi4ErS5NeCwW0HF89F5?=
 =?us-ascii?Q?kItl9crIsXFx3PdKFXpSMeUxgAIsw1dUfmVRuYaLZsEWeC8sIeJXx+5rWtwg?=
 =?us-ascii?Q?uWjtlpBubjJwICPrhQtn7Dz9kuAeW65uIf9nEOxMa2vMWygLHJ3wR7hMHrXS?=
 =?us-ascii?Q?XqYIG8p4H5EAYWVJawrwz5RH1IGljsyJlOaHMjmdaAfFghXmeikNotLZlpGj?=
 =?us-ascii?Q?IRxepsH/ObQDoLK4kh1hX7H5VCsO5LB5hYVbsk55rouMtMUZImavzueONX47?=
 =?us-ascii?Q?vOkgW1OTUdNRO32E4hR7a9lMlMUnrY+yam6CS41VHXaREA+ePAA9RvVO2qua?=
 =?us-ascii?Q?lU4jh4mIZ6b217fWbG/jC86R3y3noVQZB79+GxSgnHsQFY2Sguam6J5Gu43+?=
 =?us-ascii?Q?mw6KAwWxv79Hoh4chvk9n4z/dyAqjIJ2TcC2aksNch2ZlaPYH2bIG0emYfZF?=
 =?us-ascii?Q?0Iqp+4WiV6BQUrSaNDomWR9cv/PRhk222IpP0FYiIMpK32FQvinOtFaFWxYn?=
 =?us-ascii?Q?fqszQeLKNEPJGxQUZdD6iRmCEB+TwmMJGxn2nL8hV5cHUGtreAKas/g1AmYY?=
 =?us-ascii?Q?qsmo+ZakPh/ixk2OrbydoA2E0Wxl96UI0uTzifT0ZVTkvXkvmvIye57qyubF?=
 =?us-ascii?Q?YzuLF4VsMe4Qi4ftU6of5VOlt44NxxKOXGdPSAN26bWZQ5bTycOzU8dwDJ9t?=
 =?us-ascii?Q?26ivHfAMkUWZmAR+4gQA1bmr/wiW4SDuaGNVhlZeClrtGrIHWASUc0BYDTPR?=
 =?us-ascii?Q?UpjRuIaeXXQuQPJTH5ZOrRHa3yatMA/k0WmkLZNBE58aLNoeCoXJWepjxviJ?=
 =?us-ascii?Q?Wh7QYwOLVWW3FuaWTdZZbnU399VIh7fRXEviigWEZbTmhiklnIJvZLx3Krdw?=
 =?us-ascii?Q?zScB+hVn1HTtaeTBOmNjuO6bz8Bz+eyruJr66oXeBYLqlAch+n6NSaaAEAvN?=
 =?us-ascii?Q?vBH7t+/zhaeUf9RWxp8z3yIfVgnpapH0QtiOZox2UX9qMs4r+WFFwZOgQxko?=
 =?us-ascii?Q?01tAUJRYycEFqTx/jn0I8r2++KSZ5QHDUB0j5zcJCmJxmz2yHLk/k6Y6WJUL?=
 =?us-ascii?Q?QCDwicrA9ToK2B++XpbNa9SC5yt6KFhd0cy8RBYziusYaJq8jlKems6lMR7S?=
 =?us-ascii?Q?GwjxqbyfjUQKmhcrc9vBqaCCvl+ry/ntU2SS0+OBqFak+qpU42AbUEe+p7yd?=
 =?us-ascii?Q?aTaul/zErUq7WSNVJdDvXssFuISUUMqz7AKRqoAFcXOHYUw9rWnpnEkGKc8D?=
 =?us-ascii?Q?MDgFcMspSrMw2d1STr8nNuh3SgVxtFwjMY1WgFbOWcMP7pAVr/wrIYLHdAys?=
 =?us-ascii?Q?ZMrm/6SlGUdXfd1XRCaduN7oMbtj29pgYdgE81RLh5IVBKPQJfcX5gGBMdiV?=
 =?us-ascii?Q?E7ZLZkIVK8uPJsc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR02MB10771.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jbcp+wWzNS+zRN5gtQ5J84hXR2s00KQY4ZqdswsMsK4XRTg4SPXJelBJO+AH?=
 =?us-ascii?Q?M6+Fw8BW2zMOiPmeVo9yW9bjn3plsfPm24hETlibCEaQDBM1T/IGMf9x28fF?=
 =?us-ascii?Q?wlWibOI+/T+TQnJnLpzQg8jjskIxCifQfK17PA+20Z+UooxbQvi/Bx1Djb+H?=
 =?us-ascii?Q?ngFzMrX5QjeXl4SY1tirf4wz2sHXl8lw4Y5x0Lu060GLB7uw3UPFTIatAIQj?=
 =?us-ascii?Q?g2800rROBdYSDVe5hi2e2JUyM5ypSIMIcI9h/UZlhQmwRv3AomZUz3cst/SK?=
 =?us-ascii?Q?7LNdvvnYQ1iHJ6tk3P96Uu86YZkWBLBCDVh3WbruOWDZkB9J06QuFBCq+QDs?=
 =?us-ascii?Q?zUdXhcruYqIXfwtDnpXIN5q2KGalY3sl6Yiqqv2Qsz5wCsmFEW6UAmZUafrq?=
 =?us-ascii?Q?So63UJkF+5nzChuUUNsQSryRX0M0+Io0CgzEZnWlwW+TnJ0/3db7xZEejDBB?=
 =?us-ascii?Q?A1L7kpmV2j0+45chABtdwrHOzjTNnIafo2FXXKV6lE2Treq8y3mdf4x/uvsR?=
 =?us-ascii?Q?TlS2ZPfmnU+aFFUgCMYcls22KYTuT1wg33BePsE9+DVT45ExdeL8cfnGZM1q?=
 =?us-ascii?Q?UggPAKHREAheBCyHSWf+17Sj0jo79mgCfcQ2r7nYyXwCfGB/Ll3oon+b6bCl?=
 =?us-ascii?Q?INj4wixaqvJ0x0+fzyBLlXarFg9OL5OPUts4f0U9ydNqfRXvorEzXSC6RZvY?=
 =?us-ascii?Q?32pQW9YQI8YWOnuPehF3a5z5jkqYZc6mXD/SV1LIlv/BMcP0O6dEYPaZuSV1?=
 =?us-ascii?Q?vzWRln6YYge8ApbDZthY7rHvOkZ2AbAefQSGAwCXJTeLrTA9go5hm+PW79+2?=
 =?us-ascii?Q?OsFjAakQXOD16MsicrHRZ86StZwn9wOedbxPgXXEwt2Xy9CPPWE3ADQ6/BJh?=
 =?us-ascii?Q?3l7Q9y1Mrc+1+FHSYjQ+p7O8deCVJUAB7az8UG/Bn6FHEpSaF2NSTJdUiY/B?=
 =?us-ascii?Q?9ObiohIFfLsDwogr+P15SmZMxaFgyekjI9AXTvII/WMAPeoErcbwU1YSACOu?=
 =?us-ascii?Q?u3qwpdZwTSJazhYwc3Km6KHJYxp/YtrhdNhbVlihxDt7Sjs3GozalMUQ24Dz?=
 =?us-ascii?Q?KZ6OI9KxWKWgQAvaWUCckZcIZEyIU1OCbi4xJ5I+G30DrsAIAPx0P7k/xorb?=
 =?us-ascii?Q?nopW29iG9wnllIS6j2cGCMVqwNs9sFdU/1JLV9KMPnxFffKAtixdisGh0gY+?=
 =?us-ascii?Q?i7oYfFMQvem9iezJAG40r16bl4hAv8wzBciKmkj3pmeRltxRkhE4SLkYoBM9?=
 =?us-ascii?Q?iZSy7BJdq+KVV5wsdM9aBwei8tAmBxVSammk33JlUjfLmKGXz/0bTjdkinij?=
 =?us-ascii?Q?dYPzIAOX7Gu4K6f4XaGtDD2Syx6fZ41WvUCI2alh+bZvoZS3blWBp1leGBzR?=
 =?us-ascii?Q?1vRqV1oyha3ZWsWD6f+lUQh3QNMFak7rrKWZQD/zoBohqjovs/hJa1mtI52m?=
 =?us-ascii?Q?koLi1Xt4UgcbZbftWoI5zQZ5/gKK5rg7Toq02VM6iEeKgOty23l7f6o6yMFN?=
 =?us-ascii?Q?ucujqAQFBczfdpDSSaXsjV4s2ZosRo8SdZW8DG45gbVK7EPew3Jvpc5KfdWt?=
 =?us-ascii?Q?GOqQjc8V77jILyvywDoAdLcXyyI+H527N+kPdR//?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR02MB107711F11A8681D42D5B911B4E946AIA3PR02MB10771na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AmQi0cIjGUgwpOQWw7O5/+d07NIskPfGOTdcmNkcH/J7OuFBlWE9LxUb+njSTrj5Tlyj2qGMd2ODvdlmH7I3boohOptfOgd3QeQGbrLemRi35Yri02F8RIheuaa48i1ibS+/gpYGiSndldtG3XXRQk+1zRvSwd7t7WzWQkRSdJ6oQrPcVsTFCbyDGJvuvjKrwKHtUuWReRV4GsT/8dDOfPAL4hH/N5cqkKYOWTK4V13ZTY0RfbXifGTaS0/uBDxxeBaIhj0nzI+oGzrgsG0bBLkhDobw1E48kSu6bUc6wUWDoTRqIN/bKPy2XFwrWj/OF9xuDpis+NfJGjWO7mZ8t+6bOrf2lpPh8AffsQ42hbfQ9dX/PrdULBxl+tMtiuOU33KBBZyNp/bMTA7nAILgS4juLsMkiN14gH0BQ6gcdD52ZDfRH55SNjsQyc9c32YEbQ6u5cIyuzeIM+R4oyh/xS+jJfeIOjhl0HCzr52Yaj3yiAfgQaRhHt0xpdHjErOKNOuLQXdsUtUaBf+m1wHR208PlpVk+G8ZNWfinmc2bcX3qPv2IzbALh5+S5zt1dOlvpRzPCmyRiQNyjB0xJ9GL8jcl3duEf+7tUfz0dBiFgwol/YB9xPG5nFF9e86ll58
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB10771.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad46187-b6c2-4f79-4129-08ddb7dd0b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 13:50:16.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MH9izVG/Stp8e3T3BuaNxZrGHLREikkvd77YhYrJFV8DNFAbei+YHcjtxfCGli32f91Bs8Vwm8iviRlDFPiqxgfWn0I+Eg5mgDTswRueBBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8103
X-Authority-Analysis: v=2.4 cv=H/Pbw/Yi c=1 sm=1 tr=0 ts=6862961b cx=c_pps
 a=WCFCujto17ieNoiWBJjljg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=bt5KbKNvAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=Byx-y9mGAAAA:8 a=Ay4m3o3bpiR_8mFBA7gA:9 a=CjuIK1q_8ugA:10
 a=BeDfOhnE6cbHF7R9RVwA:9 a=GJH-iXveXdB0Sbsq:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=3Sh2lD0sZASs_lUdrUhf:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: zu0Vcq46WBYe3yO52MlwLC0OzO3HWJDj
X-Proofpoint-GUID: zu0Vcq46WBYe3yO52MlwLC0OzO3HWJDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNCBTYWx0ZWRfX39C7MOtmif0a
 GA5ipaAVuNWxiEaaYC55dPc0JLImovg1n3j8QSH/oQq7/ojQCDaioy/6jxTeBZ2L3Iwr48CGjlq
 khtu42NFlw9DTZT84QGXSQOa6m4Fw+ndrdQzVCAOOSZSGjaTgRhjTXa5AC5cxS7yelIpRKp1NIs
 LilFOiA6o2RIGWsmoxmkDhLbY5onm09BDHB1Pe6PzTWq+UfuNGQA49LlQV0XQXVqAW8Y8HzkPCa
 /v3byyB1bUzXc6ltqhsjgG1f4MaMfD/ra51VG4ov2yS+SZa2psmYBqSB4YXt7Xmyih5D8MyaTMH
 83eePTwnueUnQi/+ByY0VxFGXX1C73Lrxrfa63dA3A4A5MmyPEnZoT5mdcxLqO7FDNHSvB5QMSD
 aCa+APZRq8348WjjzhwFpaCYF1+s28oKkRcLWwFKNXpS1t3ptVR/z2u5nX3uy6WiqSh0HDWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506300114
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

--_000_IA3PR02MB107711F11A8681D42D5B911B4E946AIA3PR02MB10771na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hey Thomas, just wanted to confirm,  I see the ARM build passing in CI. Is =
there a reason it would pass there but not on your dev machine?


________________________________
From: Dylan Schneider <schneide@qti.qualcomm.com>
Sent: Friday, June 27, 2025 11:46 AM
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; S=
tephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.=
com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpur=
am@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interf=
ace block


WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Hey Thomas,
Thanks for the reply.
Can you tell me the build command you're using to produce those errors? I h=
ave ran the builds on my test machine and cannot reproduce these. Thanks!
Dylan
________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Friday, June 27, 2025 11:39 AM
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; S=
tephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.=
com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpur=
am@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interf=
ace block

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

09/06/2025 23:19, Schneide:
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

I doesn't pass compilation test on my machine:

Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-=
gcc/install
Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install
Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gc=
c/install
Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install




--_000_IA3PR02MB107711F11A8681D42D5B911B4E946AIA3PR02MB10771na_
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
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: rgb(0, 0, 0);">
Hey Thomas, just wanted to confirm,&nbsp; I see the ARM build passing in CI=
. Is there a reason it would pass there but not on your dev machine?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Dylan Schneider &lt;s=
chneide@qti.qualcomm.com&gt;<br>
<b>Sent:</b> Friday, June 27, 2025 11:46 AM<br>
<b>To:</b> Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.patt=
an@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Jer=
in Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marvell.=
com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan
 &lt;yanzhirun_163@163.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] pcapng: allow any protocol link type for the=
 interface block</font>
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
<p style=3D"text-align:center"><span style=3D"background-color:#ffff00; fon=
t-size:14px; font-family:sans-serif; color:#000000"><strong>WARNING:</stron=
g> This email originated from outside of Qualcomm. Please be wary of any li=
nks or attachments, and do not enable
 macros.</span></p>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Hey Thomas,</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Thanks for the reply.</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Can you tell me the build command you're using to produce those errors? I h=
ave ran the builds on my test machine and cannot reproduce these. Thanks!</=
div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; color:=
rgb(0,0,0)">
Dylan</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Thomas Monjalon &lt=
;thomas@monjalon.net&gt;<br>
<b>Sent:</b> Friday, June 27, 2025 11:39 AM<br>
<b>To:</b> Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.patt=
an@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Jer=
in Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marvell.=
com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan
 &lt;yanzhirun_163@163.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] pcapng: allow any protocol link type for the=
 interface block</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">WARNING: This email originated from outside of Q=
ualcomm. Please be wary of any links or attachments, and do not enable macr=
os.<br>
<br>
09/06/2025 23:19, Schneide:<br>
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
<br>
I doesn't pass compilation test on my machine:<br>
<br>
Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-=
gcc/install<br>
Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install<br>
Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gc=
c/install<br>
Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install<br>
<br>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_IA3PR02MB107711F11A8681D42D5B911B4E946AIA3PR02MB10771na_--
