Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333D9CA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 09:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46AFF40269;
	Mon, 28 Sep 2026 11:57:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7F8BE40041;
 Mon, 28 Sep 2026 11:57:27 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9JsiO1026033; Mon, 28 Sep 2026 02:57:26 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022086.outbound.protection.outlook.com [52.101.48.86])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gxbdm6c0w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 02:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX27PKEwyH+ZZuq+WYpNRKMaYa4mXNJIqh/p/4N5+3fn3fnUdgtTpDEq4ZrnBz1EPERAunJEeL5Qm23ajIchT3eqBsPNIJdko7JUpasbEpK7UjB1RrfTNXo7AFz0xS8aAGlm2DiRGqgyXMOaQmea82Dti2P5LqqDlKP6nWn2wm6zr3e2asZyYR2VcZM5gEwQmVJvoUvL69roB2yzHC3dvw8cohvuVTpOVgp7NZtQVTbTMWHNl1I8IpO9YltwdkJgsv3MYXtG41fmBdJrliOv43t/O4aGqlLiQe/riLnWGNhiVOeeIzKeYpZHLDIrE8u7h9YJV60MzvbetSOnU1jEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F96jyJuuVIIYoV+xF+fC3FXCi9b4svqStn98eFZrME=;
 b=T6fwJu4jDuXr0cLq4Ii7NYeyJ2yImORaTW/s7LMfm6nQIqnegCSBx7V5RCC6aRVdcOcoQh9LqtlVrR1RcfBZvF59FQxP3RrW/iWaxStF4/WQkDjlXH4d49kddiv0QYtHY9LSUEDUPKz8/tUwM82YnAth29g8A8jkkB/mEVB8aRWDhm3BZnLR4HArNw9NzOBWi/WzB88q6GuDaceuWnPAyqHMGqY6rOW/CO5aBP5qOXHnIRoNyPGKUuQ6YPNB03sfcH1lEOBrzNZHYGkMkeA2zSa3T8UPP9tR+Y7k+uCl+mUPahc3qXGGXpedhCXcmsx6NHOn+yp4zOn9HazqsAbLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F96jyJuuVIIYoV+xF+fC3FXCi9b4svqStn98eFZrME=;
 b=lN+jcitrf0JdM6HoJYiWxsU3CqnigJz2DCvjpnutlyuj+eisQ5BzUKDuo4+++P7hYTn5sG1khNPfWmkA3vy42bhGET1S9NWV10gVeKUe1/ml4Bo0/e7xZj7OhLvA5pXQMsb4Zz6A+f7wpm2r/raw7XtgX37HeqUXCGt6A9vAdtA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB5251.namprd18.prod.outlook.com (2603:10b6:510:1bb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Mon, 28 Sep 2026 09:57:22 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:57:22 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>,
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 0/8] cryptodev: add RSA-OAEP and RSA-PSS
 padding support
Thread-Topic: [EXTERNAL] Re: [PATCH v4 0/8] cryptodev: add RSA-OAEP and
 RSA-PSS padding support
Thread-Index: AQHdTwbf5QPqz1VSiUi2vVGYg9bGZbbjtl8QgAAFbYCAAADzQA==
Date: Mon, 28 Sep 2026 09:57:21 +0000
Message-ID: <CO6PR18MB44848CA9B636780307B2E569D88D2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260925081500.3848187-1-ssarananaga@marvell.com>
 <20260928050412.276760-1-ssarananaga@marvell.com>
 <CO6PR18MB4484629FDC6B984AFC24D7F8D88D2@CO6PR18MB4484.namprd18.prod.outlook.com>
 <LZGjqyc3QPSiooArUsg_Gw@monjalon.net>
In-Reply-To: <LZGjqyc3QPSiooArUsg_Gw@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB5251:EE_
x-ms-office365-filtering-correlation-id: c2f3a5ff-1e91-43f4-f5f0-08df1d46e3f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: TZ/Qyl/CgkvjOgBM8E+kalt7xHo9XOkQFdra26nkEjP6trIwj+cV8C0LlW9sAA/fHBWtU1LeJmLye1Jt/LIqq/Li5F3TShoc3bx1+/hiKrW/6jY2TCktiviRX4yOrJv0DTHRjAousnCqYCjgBDr7qH91LiffBpKisFOpbB9MjeQKleQNYaHFFfV7gJ4rDVA+19MJZ+OVf2DcUz8EYs61nCB4zXO3WdZ/FdEf623DjiGDffOx84K2qDlTjAZuHj7qZZfH846iaWlUZaBfRz5aavQcLhTDbQzc0EO+P+JdXIyiewmt69g19rAbOdyPGcJK9Qz8whrnsJrnF7nT/3HxKcEMAGTMXST/yu7ggD11elP+Gx+iCzzsH5mPTxObZGvWkZ8l3Zh9ElgfUorJBphU3rxn4Q+R4+3a3ikPji56YSQr7jqfJCDs/Kz2fxgJJ2WEQulEjelSUmwxW+1QJpwBl1EJVKDyT8dm6/pa3gp+UjjfVhRSLcrCzVaGmxBfXEHVPrm1iy67k7Sgtk/xBPU2B1VqPugGSqDQ+3D8asxy/1HmEpdg4fDwgFkWoX1hJpSb01qZPCcJ+xKiFlDSR/yHjicZaGfqbNn0nd1PwPcBoxnX8zvJrCEyjMP5AV7OPnzMs4tKN6KQOCLeWKlnxckuiz52sIhYYkuzih6tTnzDsguK/OohbdOxyQpqIQ5IWUbfdc6EGPhZKz3lLeM/9HPx46hlbfzoaZNar0lLDc40vFc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUlqNkJOald2MDk3d0hZRnJ3VXNabVVuMWRKNXloWm41VElTcHd6VTNVcEgy?=
 =?utf-8?B?UG9BaE9ldCtqOVNDNERzNXBjS2RQTi8wcTlFblVMaXhiemFmUVpLNjlOM1BC?=
 =?utf-8?B?VE95a0ZmcGdyZytZdXhvWUtJTStpMUVFMWg2R1JmQzZQZWxBKzRBR3l2dVhv?=
 =?utf-8?B?d3NyTWJ0ajN2dWlaYlpKQUh3UUg2b0xtOHF1YVNCS1VDVmZLTGxmVkZWNHhY?=
 =?utf-8?B?RTNUY3ZmU3UyVEZuYU5aVnJlRjFCRVprbDBVMlR0S1VjdnNtcG1jdi9PUHov?=
 =?utf-8?B?Q3UzTjcyaEVlTGplUmxpanQvMjRCZUJmUTdHcURjVGh3WEx3ZC9FVkRTSTdp?=
 =?utf-8?B?TFk3RTZDb0FZOFNHMHVpVVV5TjNTc0R1VGNsbnpzRURVWkhEUHNUYUxIQTZi?=
 =?utf-8?B?cVAvMENOSisyZFhGSWlQZnlCcGRVekZWSHFOVGZvZU91Q3hUQUIwTzRGOEYy?=
 =?utf-8?B?SWkwQzRmaEw2c0xKK04wVzY2Y1NVMmlSTzVqRng0a1F1MTNhNTJZSUJ5Umtq?=
 =?utf-8?B?OTkwcnJyOEZrRjViRkZKVjN4VzhWUGdYZGZEVEV0ZFZEaFFPc05LclVBY1B1?=
 =?utf-8?B?STJtTXFmTDZhM24zODA5L3haWXBxVEc2L0lJdXlaL2lEOHZCRVdWQmdyeC9J?=
 =?utf-8?B?dFgvRkc2NS9ONE9ZTlh3V1BFNXJQajdWSFBmTHA5Q3FUdVVZVWVHVk1sSlMx?=
 =?utf-8?B?Wk9ZOG9xUXBlbUVlcUYvK0EzVE05Mmg5aHdUM1VJeE1DeDBMc1REU2FMRTBW?=
 =?utf-8?B?dnZNRHpjRExKZ2tlT0xBVjdEQjlxQThrSWtxS3gvOUJQeU5LWnlkSFJTZEpq?=
 =?utf-8?B?VFNvVktYMzFBam1sTUhXSTBrZ2JsYXBDNTJFaHRVS2ZtTy9ONDZKbjdaNGFV?=
 =?utf-8?B?cmk4OVZkbXU2b3pSOVhPdGdjTXk5VkgxRFBWNktjOTZORFl0S0huM3AzV0Zl?=
 =?utf-8?B?aHNrUmNMVS9jVThuWWdNR0VxQ0hpMWF1dmljbjJLNHdMYmliNGRBQTVDbDFa?=
 =?utf-8?B?cUE5Q0YvZUJsaGlRN0RzcWtWeUhTQ2lTbzh3UXRtL2NwQmM5eVlZalZmRTRa?=
 =?utf-8?B?TlVDaEtNRHR2ME50VXNQMVJIM0E0M2Z0bzhOM2U5YSs0UTRxaUtJRVdBRHFI?=
 =?utf-8?B?WTl1Q0w5UGcwdVJrT0lHWTczVXlkc1pSUVhPbGhBSW9YVHpEVWVXZFduS2hR?=
 =?utf-8?B?bEpDT3BRT0Q2MUM1a2VwQktLcEVlNjBsNWw5eGtzOURCYUMxS0gvTXFsRU4x?=
 =?utf-8?B?eUtwOFVLMzNxcUI3TlpjWS8zZUp3bG1zdmVKZFEzak80b3hOSzNPNm93TEZB?=
 =?utf-8?B?Vld4V2U2YXRQd0x0aC8zS01rSlVtV0ZYZlk5cWtRNk9sL3RTc0wxUDJyL3NO?=
 =?utf-8?B?d1F5RWZ5dklqOVpmeVFOdzNPNHRZeTJMSDhhVjR6a3pzYTkwNTl1ZGVHK2da?=
 =?utf-8?B?R0JFUFRwVE00UG13NWVmakswYVZGTmpIbVlZUWV2QzAzSEFFWnZtSVJKWEor?=
 =?utf-8?B?S25LT2R4T2xOWEV5RnRRaWdwSVk4RXhScTQ3KzZ2RlRvOW9nUW1uWnVzNTVM?=
 =?utf-8?B?cmxEdzc0NWJtZnpCQk8xMmxOSWxOTGl4Z2FEOTlSWVdYc0xLd21oVVVSVjlp?=
 =?utf-8?B?WFpyM3pBMllOamxoSUJoMVVEWDlnM1MrOGlNTFpVZit5Rk1uM0JMUzFXYkRO?=
 =?utf-8?B?bkwrcVhPNDNRa3Qvd3JTQWdydXNJY3pUYzkwUzNsd2NmYitWWnVma2plcmk4?=
 =?utf-8?B?ODNKOU14TmQzSnJ6RmF6bkJyelV3YXZBTVdZRVFxRzJlY0NndTB3MmV6cm9T?=
 =?utf-8?B?WCtDd0lSaWdhajh6WTY4YngzcjRpalJXZ2dkYWcwOVVoNW1na0ExM2F3NzQ4?=
 =?utf-8?B?WTJCVFpMd3hTMCtWRjBnRDBPSG1NbDBqaVFsaDNud2QrK3dtRHNHRUFFRjZN?=
 =?utf-8?B?WEs1QnVTUENNeDFaMytiOGpCOEt4aVFXRitwMXJMbTNTTWpQK3E1cHZBcDNh?=
 =?utf-8?B?WmRqRmc1dWcxb3BtUjVMMnNIbEl6VVIvRGcyT2xnYVNsQVF3U3I3OHJIMmJE?=
 =?utf-8?B?eE8wYndoaEdaKzRDVVNjYjM0QndrZG1JTVIyZ0lZdFlrWnMya1F5dkVRSTFI?=
 =?utf-8?B?eWJUNUFReTl5UVFrU0dITWpDUWpyc3ptQ01CSkJXaktZWmN2V3VDU1RDcVNv?=
 =?utf-8?B?TCtZcGhFUndYOHlGQXR6eTczMzgzNWt4cWJ6KytrazkzcGlzUnIrc1RDbFZ3?=
 =?utf-8?B?NTBWSXkwWWNwUitwSkRrOGdIa1hpcWxpZDUwNXZjeXRLZTB2RnhFbUJLZWdD?=
 =?utf-8?Q?bmzKzvTbw3Fnn5jmly?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OttetFM3Vve6e40sVjMkWcrIjhIBOOoDW+hhk02ZLYs89cEcigRjzxLAF4CWFWd23Kz6HyxOg5EoSzIrRqUplYA3ddXVNya5ORDZuLt39ktjplKLJ7PoAkHQENvcm03/+/K+PjinbRGCjXSgUsAP0lm2jSYXXPf0Xm1ve6YIgBAPvyZOU8G2WW1sGv/WF1wFVTpq34Ysm6fuCTb0V9zxwBVYGQcVsv67hDaRQBeKWAQr8efbQnzg1GozeA6JzPnc+kYtyBhk5zTkTVZjdunOc48D9GabcC5hxmniDi3jb78kazTwnxVKGYWtVgPA7jqfrZ3ueHCdrRo8HIrnQ2kPtQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f3a5ff-1e91-43f4-f5f0-08df1d46e3f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:57:21.8876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: geCsPBH0FA5WhzxMJ8SeyeC7zpoBbbvaafWoga4b6tZ0ibALH7WZ3RPNp2DCSKHzn3ZcocyHlhHz6tWJ2PA37g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5251
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX23F0k4LjO1XY
 CpOMEKSHTyjAZ7Jxdu4Q3DlE0X8LQEGOkOtxHr1KleJPQ7jSk4AGSch/jYP5R5W2JLzeWpfeGmK
 DG3usnwUuwolcpmxkMZKXZxTwdWRfhroej+2GazVSVh5j2yxRgwPl2TePHkFyK9NpujT6t/Rmg7
 74Yra8hkYBOgoxkJ4oVCjifhL9BlX58j9t7wOUtk2wKrzySMXu+onkNU39AjcCUr+QfvuRSrjQx
 3OAkLuoX+OnfPgJTJuhnRE981vhseUKe+UrS81HN3Mc7K9wYelNiC9o4f1giQIWwmxeYxE2o5BA
 yJ4Hc7CMoDgb6CHfJDKJiaK6Ob6TShnPGz0Fse6pRqN6Ep2byzE6gm2z0Z+rNdiVX4E/65F0RpK
 gU3sFRuv4bDY+fiNBw+znUqm3uYAotn4s3u9tUVuFFA/eXjuBepaweFHmoc2ApISVhfsSJh811F
 FpH1/ZPFxfIjkUcOvRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOSBTYWx0ZWRfX4yp4ZwZ4RT24
 wmmU2iOJfDTvPClaoO6tJQl96bumEJl31dHlrxaL5OiVCsfx659otzeLGDTHPBvxTUSYSXwkQy1
 zf9LFPmFXneEMCROtgqol+pdC1WQfXo=
X-Authority-Analysis: v=2.4 cv=Lc6peTfi c=1 sm=1 tr=0 ts=6aba3a06 cx=c_pps
 a=fkVT6ClcRaXWu6jQ4rTLEQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=8rWy6zfcAAAA:8
 a=8I-r9E1SgRZu1ZZCXv4A:9 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: _pRDEAPYEO8YSwQr9NRiFnY1zw4TgPxi
X-Proofpoint-ORIG-GUID: _pRDEAPYEO8YSwQr9NRiFnY1zw4TgPxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
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

PiAyOC8wOS8yMDI2IDExOjIxLCBBa2hpbCBHb3lhbDoNCj4gPiBAdGVjaGJvYXJkQGRwZGsub3Jn
OiBUaGlzIHBhdGNoc2V0IGhhcyBhIEFCSSBicmVhaw0KPiA+IHdoaWNoIHdhcyBoaWdobGlnaHRl
ZCBpbiBkZXByZWNhdGlvbiBub3RpY2UgaW4gbGFzdCByZWxlYXNlLg0KPiA+IFNpbmNlIHRoaXMg
aXMgYW4gQUJJIGJyZWFrIEN5Y2xlLCBJIHRoaW5rIHdlIGNhbiBtZXJnZSB0aGlzIHNldCBpZiBu
byBvYmplY3Rpb25zLg0KPiANCj4gV2hhdCBkbyB5b3UgbWVhbiBieSBoaWdobGlnaHRlZD8NCj4g
SSBkb24ndCBzZWUgaXQgaW4gZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0DQo+
IA0KWWVzLCBpdCB3YXMgbm90IHRoZXJlIGluIGRlcHJlY2F0aW9uIG5vdGljZS4gVGhpcyB3YXMg
aW50cm9kdWNlZCBhZnRlciB0aGUgcHJldmlvdXMgcmVsZWFzZSB3YXMgZG9uZS4NCg==
