Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9AC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 17:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7BC04026D;
	Fri, 27 Jun 2025 19:46:55 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 5C61E400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 19:46:54 +0200 (CEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCbj3E011296;
 Fri, 27 Jun 2025 17:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JXmbkU3Eq9pMA123Knen934R
 9FN49urJqFP1e0bJwOo=; b=cyVp0OBpA0tdHmIKRvti9cMUANFvQWmlm3EHpuX1
 6ktDfG5LQ4mTyU/ehfCJZKC3XxXou9N8aUT+/hV89dxSlMydACWIaS6FhTkgAUAX
 vrq/EN/4VGeVRLILXYtDvDnTtxyPWr1bT/zdIvY7zOHHPpcF4wA1TTdXIh2PhdwK
 cE8owa6WdtgKmDsRMNOtJqtv5Fg8RiVQdVO9A9R3SP7gusR2zXyh2s7C9OVEhPMe
 WsUXQ/Z94GC4UUOszYB1U/Sd0JcuJH/uqUJKKzcRBwe3vbKB8CjvmOMP2M/WRH9I
 tFPGBgowYnFt47J7q31K8SyjZbffSJxUYl9A81pbVBselg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgqj1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 17:46:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuJpXfQ7FB7njIEh2Ne+UTtLTL2y+TW+ZDyibO48oji89H5pKZVNc8aLbjt3FuXhiiu1dyZ/02ynTdKCw+5Zmz8MewIN8jRZPOh5S/qDm4S9XPhMb4tvyAuef8iXnQKZcvH+r10rPHKJxKbCz//45nDspdsWqg9JgPtg5AC3LXUd8nfH0fcYEJ0Ajq684cpuBfv7I6Qn2TbonYRC4n8LKHzJHFm9hKxP7rXX/h4Inz884k01okUHs/loB9xcqLTZtL9PKoq9SiXhl7+y+/Z6xFL+SYP6fwFHck3EdjKGLyGyrmDxZ1czfhqJ4hi+z2mYJedSrbHiAntlpf+/orGZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXmbkU3Eq9pMA123Knen934R9FN49urJqFP1e0bJwOo=;
 b=Fulz1iJk3W3SftToCSGGJqlm+8d2apfYfogCB0AvStuicuFaONfVpgIVeGR08dQuUfuZJtAAflXF1QP7/DdH8JLe1jcUzRIR1Buz+Z6Cl5OIGvNjxBcz2IRRwnUnGcM9v8FjDOY4Rw+lt1vVkR5ym0XLjYFN46PmnABCT8AVhxq+HqUTAuNNYUQQWWDfBUuxJNhcO7aB8HTMEglx3WTfjvFfSvj61LdHaQ5eGwUSErLNqGaL0mbA8inHubmnM//pdrN50S9PiIdpArK+yb3Ef7YYEfj+EoXNyu0sO/v6ZGeopRyWQlf//qLz8nmoxGAO7rSIg0ZBvLiwYDhGhBWzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 (2603:10b6:208:509::11) by SA0PR02MB7115.namprd02.prod.outlook.com
 (2603:10b6:806:da::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 17:46:42 +0000
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5]) by IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5%3]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 17:46:42 +0000
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
Thread-Index: AQHb2YQ73VfknzRgqUKIslHGkPlGlLQXYbIAgAAB7lQ=
Date: Fri, 27 Jun 2025 17:46:41 +0000
Message-ID: <IA3PR02MB10771799502C67457C7CBE257E945A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250609211937.345620-1-schneide@qti.qualcomm.com>
 <6923574.A9s0UXYOmP@thomas>
In-Reply-To: <6923574.A9s0UXYOmP@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB10771:EE_|SA0PR02MB7115:EE_
x-ms-office365-filtering-correlation-id: ec1fdeff-6325-468c-7512-08ddb5a29377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/iXOwekeC+Gm5z1uX7n/eECN5qas6wq+DaOXnsd1dCHW8pIR/chtSz5qAMQ8?=
 =?us-ascii?Q?u/A8iIBFFQfsGCmeF57jWLZxrQ+MlVpoY9GWLzfVdsYeRo0Ebo1OV8IwzQ2v?=
 =?us-ascii?Q?733eM52Sf6GYPfpipg9YrcYSOV8IeZOMfv10Fw3fBh1LxGHTY4bYhapllNDC?=
 =?us-ascii?Q?MZVFLKfm39+caO5DomN6au8BDVqtyTmnvY3oq0aZAR8q7Y0nroc4IcDRbdER?=
 =?us-ascii?Q?UOujrkmgUiPJlzou5FNVLpK0TGyEN+Mjm38LaPAtMwgQlVJBy6PF0IOovgpk?=
 =?us-ascii?Q?cIkBxg5SmNAaT8mFLAXr3b6t51eNQDRroyeZu8umjR/Gm4vwfB1bUm7i637X?=
 =?us-ascii?Q?zkn1UVCvb0uIFJfUGT+NOAfcCUWvYN6FC3107vYljRhJ4Vh/ETF97DRUGl9Z?=
 =?us-ascii?Q?ET8Gxzw9gzn+7K4pqJuLCfuBIbGfRWMgd1HwiLUnFDDNN0dlGX7fGW9vL59g?=
 =?us-ascii?Q?iQnvdxovRt9H80oOXfeZDXMTeMYqz6gjsjMqYMs2V1bQ1GMExjuxO3LFOjbx?=
 =?us-ascii?Q?7O7d66NIGkIY8s8YqzqdibKr06aa4dkx6kPJWsGXSOgnVamXoWkOBTpunVlb?=
 =?us-ascii?Q?IHpWeuyfvcwd1tADV1r5mP7Ze1AZdeV9CaUTFGnCbz+ZVppQgD7TZon4Pdj2?=
 =?us-ascii?Q?9W+cTVkJ8WkchheQTnIEXKOsmRy09pTyZK2zGWyLGCGTpASwBlFt4zmmMgVI?=
 =?us-ascii?Q?bmaHnxBzFlb7RxJaY7+VgCiH9n1Km0CsOVvQB9xAzFmHkj3oapVuPW9Q140C?=
 =?us-ascii?Q?pMY/1wMv+rAcMNddu7SIpruFvRcP8qLbCkmRbbS7rJrRSUkVuAxk9oRWcqqJ?=
 =?us-ascii?Q?sfNsZlAue4wesjebsQ5LzhI56Px5Zoe7XLFG5uNzJagbmhc5WKnlezwu9hUQ?=
 =?us-ascii?Q?kZmXVYWOLi7QIzeMli1AUZ1lFaOfnEEWpiO4Xg//DtLr0MFPWEIFaclqYOL7?=
 =?us-ascii?Q?3m+t78vH7nSyrW2ui5gwaUeYPJtaI6Fpfy8jfqha6LNphVCjVAbE22FFlgwy?=
 =?us-ascii?Q?OcMpzVKPZ+MMcHPo4Cku7xruXnqWhEhTrlACMwNkJMxgDP82G3CYa0OAW4O1?=
 =?us-ascii?Q?yxgWnQpEYXgLxwUWTuM1TeWWHkgZtmc1jmhTOr2H/gcATiLP1jFgaBhvpn7W?=
 =?us-ascii?Q?J/CEaHMFIWH3uW6ltMNeOZ20ItQrfAgOyN4eo2Wumql2RICYzku2tKYXEV27?=
 =?us-ascii?Q?PxPVSNifL/6eia++BH6gi2VaeRZHMRJKo2IKnQy8G84TXd9s+E3J1qI7ooyj?=
 =?us-ascii?Q?JeX+pSYgvqApxomEVqaEL38nmtQ+PY/fMYbHpsk33+lsJ1NxGb4RCyRBNoRm?=
 =?us-ascii?Q?6rUSBp+H0WZnYQhdwKQ8t/qYQ6C4bckOB+P662qy4Xmv95v3FHZHAP/YoEKj?=
 =?us-ascii?Q?ORmakfKw1U5tCX6hxV4IyHo72mZB6PasTBxNlW0wYklYeMKEsUQEt1K/IqMN?=
 =?us-ascii?Q?CyZYlvxkkYQCkkCMZG7hYtNdX2HZsDFJ3Gez5qNjV6bvtPKj1uEPDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR02MB10771.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iMbbtPBH3eGmq8gGo1ReFsqaqeFwgkEqb/jZBCn2laEdQvg+7vk1eApyKted?=
 =?us-ascii?Q?cA1RwywTFxN2hfnHx4RJHCGyVWOKB3vPLB34tcQPFkHLRZTSsRShYXEkA8jD?=
 =?us-ascii?Q?ZVpIHmVs+S6b/8Y28LymUney7eO0/ZFbW35qa34RRvLla3VE1u2Sa8OXHRPv?=
 =?us-ascii?Q?+SduQqrU9tYDjAw1Shx6hzWnrgcEjKaoeqe9YdKop0NOFfwCPnAF6OCNyCDp?=
 =?us-ascii?Q?Tv6xMTRptpAt9Bjq5/zccXPn3g95ylOPZSxZKcJUXNoPlDvh2eWLBAX1Cq+z?=
 =?us-ascii?Q?Gq+BrQA6fFBibG+rym/aOC5aXWI/RUJDxMixzVoesyLLdlZUza7Dju4+NSga?=
 =?us-ascii?Q?pKGmBvZegEeQ87MlLRHpaX56MtH7YjBncGQNG7DJsn58fy5r7yAbSWjWaoUs?=
 =?us-ascii?Q?MOeeZrZVt0QIR5pVBlBCXmDvhFdA60dINw0E4clB0pcSz7Uk5FGyO2HYw5ap?=
 =?us-ascii?Q?p3Dwk7MFm981nyhp1vV5u2cFAyQH0HncLyr6JZSMqdmfIU8ZCf630RLpP17d?=
 =?us-ascii?Q?KleSwwNEcYmw8HihBkIZ7HegkTgXhhNUEtswqiAJypqr9PVzvsj+2XNNcAAf?=
 =?us-ascii?Q?Gm+Lsa6yBQwLXhVSXtEt5wniLV33zYaXpokflFpbRNlzr3sD3wUevAnkHw2b?=
 =?us-ascii?Q?OA3pHZ5AF8nPgHoQ/ww2gUfafeXJJfRSoNUianonTSk7UzA22SmvCupvDkB1?=
 =?us-ascii?Q?wytL2UGKJKMxUDlSvfbMI273EYkFHb2ys8y8nKcx4ZDy+sP8ejus9RgWb6/b?=
 =?us-ascii?Q?Kz2Gkc6Q2KELhFKwCN+/syoO/pmfJVP563m++4+RPSi039GNzAFjz3FXq75g?=
 =?us-ascii?Q?XoOfvYzl5ZnqczWwtqoi3frz9mmSsUKRBFXfQrSM8tAJzv9WnAmhEn3bAqa5?=
 =?us-ascii?Q?H3deijpVvX5yfb9PcspgFrR9fsaFkCvOzA1xEnnSifkIjaM9kWoS3F/u+6Gl?=
 =?us-ascii?Q?FCZ6avu5VUxWB58moi9fU3cRoXZMNTg6hA/8c/U7WWDXbJHp9auQ4rrnV1o8?=
 =?us-ascii?Q?S/nJ6113vkl+tBjzecfAg8+XNsBXio7apbXu9Nms75v76bfHKQCUd8rgRDtm?=
 =?us-ascii?Q?99SHfSOeU+NQ9K2QB3GJbuO/HQNJpMnW/xu/QI8iu2/KGFWNnVWghXsCzylI?=
 =?us-ascii?Q?0hTE8k/YFmXnDn01cpSj/9N7mJ4bhzl7mqMvc7rthrCB4a+TczAzJrgZlz7/?=
 =?us-ascii?Q?n5j+GgaJFxnoQv9ivyXnzmdw3pzIr5dMDzGjYVgpFWNaFak8yhb70mqezmyF?=
 =?us-ascii?Q?vBYE7oJytxBnZVccplMCuoOKxgymKrcMPOHyDfhnhME5OR7UbjSWNnQyIBcH?=
 =?us-ascii?Q?p5nrVP/g5+WpZnB99S5dfKAM75EWN2GyjYjymu5A99iPk2ceDl2aYntzaoNn?=
 =?us-ascii?Q?bM2Bt0s8BPgLddC/ZGYvrdhsDuX0Y5A+dFjO25Pf7n2yWGuEJu3VCQO0LCmm?=
 =?us-ascii?Q?VmV0jzGMdzLjqut1Y2pca+IEqGlY80VmEHzMjqpk3AuCCKCOdoG3HX+is8/l?=
 =?us-ascii?Q?rzQ0L6VTQf7PqOWIrqleRAZXLXttwhD+xkRVYTLNjwotABLATdFXN3XCzGvf?=
 =?us-ascii?Q?SDJF1cjbc30adRa9yYEA7oLfyNRCizfqmGDMwl2e?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR02MB10771799502C67457C7CBE257E945AIA3PR02MB10771na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kYjYLsOIZVXRPtJME1nsUbJl1g0wxG2jFyo4Z0rRwy3nAmcAWQJqDMuEYbTH0oORSmLpiQwMYXyJIqKxScTWHlARcDYgc8Vra8b15Sun2xFCFRedCCR/4M2RmL1Syf/+nJkQffoASXixvC0AqdGFIumP9OYAtb4cKNNjy82k+mMIaEVjgS9rH3JVwMFmTN8eMNqAzWS7NMesFV1a8VoJcw1jeljaFXo9QbzbFvujRShz4NSe9UXv31ErlTwsIRkzggRwgObSByAB73Lii4GnTbfzfUMhaaJCe6elrCh/3K+5wlR8HX1yc5EodRumNYDtmerpo1mGK5vEj88f+8itC/+YaI68RMbFZ1/Y6nga9qrQRuo1ZLUJtwPfIHYiIllUy5K6+SdHM5BiY1BgMBpTaP35kDmXboPiutLBox5Tj3fXS8H2n4DaHgoSbzBJ4Z+nV1rwJAmTKf61xMhufAfYYmYAmBjyIwh9OtXQR6zLj4HKPPJ5CnxgnAW+lMAammwUYAyqg87p+gJMLIGLyK9KII0nmgWY1HudHEGE3Rey+bBdVsP42CTiqB60E5lWdo6zBinbrBO04m6cdcwgkVlMppfK2GSQebgxYYu9SMJUVKdQdb06GfZ/SBi2F+0ZeqIE
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB10771.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1fdeff-6325-468c-7512-08ddb5a29377
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 17:46:41.9849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEW5JPQQ8Kxxd36M+K6kuNqPNZSOOIdEUB03ljoBnxdHWX92ejW7xHSbFHCzDAn3iTiW9kI2TpVuksYnVoqlOux7cqdVmGx6sKMVqyV5g4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7115
X-Proofpoint-ORIG-GUID: -d8gGdCMwajbo1ulGP0aRLSYb9nG7BY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE0MyBTYWx0ZWRfX4ik1xrhG6YyV
 4zc/FViUjUvzonykOrqi3lGx7SD6V8TKOrpBRb4S2wWzUkRK5hvkujc5sPn3JDyHVscarZdgEIO
 sDw4AgbnMKZc8PSa6uyNjgCcBUT9Qo3D6Fad9TJT6L71CGTpZB0TSEIWUYhniCvecOlGuAVSiDZ
 WwH0yISM56T/zeAdbXJIXMIy4waK3WYMkEiAQxITtgOuz7UVmCl32K7cWmfo33DjmAuai9P9mRx
 QXC3kiVB8n9XBkiOk9r/AvkiqeogH/D9d/nBhw4kjZnT0Yzvxt7fhH6bBFZXF8H9eLpfgNBR9Zr
 y83kXhtmZiRGXOk4LeZFYECUGOBj4y3IpW5ZxK8AN+JvlvzB2I81FI4v4mAdneHudHvcsQXStky
 fms01Orc4SimoEg4aw34wF4fXBrZ3I0krIh4VuMnTndejUdTls0hdNFIjicEaKNIf88dny0b
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685ed905 cx=c_pps
 a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=bt5KbKNvAAAA:8 a=EUspDBNiAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=Byx-y9mGAAAA:8 a=AB5MCDifx778nUTplhAA:9 a=CjuIK1q_8ugA:10
 a=XziWCOvRJ7pAuqve:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -d8gGdCMwajbo1ulGP0aRLSYb9nG7BY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506270143
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

--_000_IA3PR02MB10771799502C67457C7CBE257E945AIA3PR02MB10771na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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




--_000_IA3PR02MB10771799502C67457C7CBE257E945AIA3PR02MB10771na_
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
Hey Thomas,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks for the reply.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Can you tell me the build command you're using to produce those errors? I h=
ave ran the builds on my test machine and cannot reproduce these. Thanks!</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Dylan</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thomas Monjalon &lt;t=
homas@monjalon.net&gt;<br>
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
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">WARNING: This email originated from outside of Qua=
lcomm. Please be wary of any links or attachments, and do not enable macros=
.<br>
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
</body>
</html>

--_000_IA3PR02MB10771799502C67457C7CBE257E945AIA3PR02MB10771na_--
