Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E10CEDB7EB
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 22:44:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 884F040261;
	Wed,  8 Apr 2026 00:44:25 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0D37D4013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 00:44:23 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637Lm2Sj4017937; Tue, 7 Apr 2026 18:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=l
 lK1ONIolQhKIOe0nkyQJs2u08opRFX/L/A4tv5ALmA=; b=NuQgDXR5y1YK8bYEr
 sNnHNcE3ADzP4oJtHmkp7I6+YISjWSgfy1x0yZgTF1STKhyQQd4hcyAers8iUisp
 YplhdsvIDL4qpaeTT+XkQ3X7uR9579q7RxIKbL4sUpb86Ztq1JVv4i1gsmrCJ3/9
 pS8BEyq3cdjzePiBAvd+dhIUSIyjB3C7E+4H2D8CcbR1Mb2LmsJTmkM7k31Eljv7
 hqcbwwlg1GF5ckpEjAEk806gMJ2g8NwQ/qLa0qQnpSleDSe1hL3g1SzIjGvXS+UT
 suQg1JePMs2k3PxWLqLoVGDGNQvqbQsAuCNN8czdjIOZQyctQU4BPJSRavKKBWA0
 77zUA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dda4ug8bw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2026 18:44:22 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637MHVEC2334772; Tue, 7 Apr 2026 18:44:22 -0400
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dda5e8n30-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2026 18:44:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoXAMNBfIjF4hMDRZ1KsHXzxZBoZaQHZGa0aN8l9J6R18BDlcoglTKXAOUtjdwadGu8npsskzX8kBkIgxzSWj2mRi5apzfgriEXbLLNiBeC3dmbDrHsO4ttPR3PWsm43thl0HNgbro99FIO9cuCsPzKnwzFZXjmzz8YyTg+2HcY+IVFpZG82Em/mTkdCC+2y3oLmdBN1m+VdskRWFsQHher+qPLAbNuRpT9AODeE/8YIzyXMhKLIHeQsdvCxUq7Vbc+mmekzkaq63vCkqD2c7qhOJaZG7dt3+YcoGiFhVov5ymrw4nHVUp2juiH10qtlt+BmVdZrXM7uwHO3LbU//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llK1ONIolQhKIOe0nkyQJs2u08opRFX/L/A4tv5ALmA=;
 b=M8c3my/NdZlPPJa2pYn2lDZcM/4EQ8pebmB8/4vG7apDWDstjjUS2AXTygt72VBkBLkpxejGacFw0CR1oYhdc6lfAGWjr6nJ2AIEzFmtuUugciQTK5cyl79vhKbJ1/WJy/aasifsiNJMTKn5CDl+78Reburp70eMUlPPAJndzIcQ7Es8GQ0FC2S2aAE4PSklGEwfjUOh/z94Sws7ZVWwd+Z664s/3LHL9xW+XVxM0EY5qdWSFWgY/Fq+nu1himOpxIo08T7IdFTZfl3SJIdUIuakFnkRomra3fozsHkPdjrYJ0LEWVhnhWyyeT7flvT8m45nsz/1DS8+Pt8xfmPSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB3564.namprd19.prod.outlook.com (2603:10b6:5:1dc::21)
 by PH7PR19MB6874.namprd19.prod.outlook.com (2603:10b6:510:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 22:44:14 +0000
Received: from DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb]) by DM6PR19MB3564.namprd19.prod.outlook.com
 ([fe80::2e01:84e2:ad83:1afb%4]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 22:44:14 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>
Subject: RE: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Thread-Topic: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Thread-Index: AQHcxmVhNUZdPluV1E6Mg3NnSRxJOLXTps4AgACLzxA=
Date: Tue, 7 Apr 2026 22:44:14 +0000
Message-ID: <DM6PR19MB3564A625FEE9BC61A71FFCA5F55AA@DM6PR19MB3564.namprd19.prod.outlook.com>
References: <20260407080636.3878354-1-pravin.bathija@dell.com>
 <20260407072118.341cdd6e@phoenix.local>
In-Reply-To: <20260407072118.341cdd6e@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-04-07T22:41:41.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR19MB3564:EE_|PH7PR19MB6874:EE_
x-ms-office365-filtering-correlation-id: bd66cbb2-5bf4-491e-5e19-08de94f731c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|786006|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 9B8sGY00fXSw/yFC2WZacwZI+Sq8JDr5AUJQhTWz2OZWzosNQr6nC5EPgOVPGb/IAl8I4QfAF2G4szS3gnrpMSJcdsL4IWFquA5Gq71fFeWm3dsGrCp4rKHD2Q1ccmSFCbLC3uCibkmqM/qjRz6DYC9MV4gr9SD9IYqQ0vssSo95GS+IHioVYiGegRI91ZhT/XjyjWwQrel4eHKRctUxgvNKLRy1GrRP2T9ICDIiQzDDW6vZ2KMB1jRakJdq3N+dww0UCEnxgfqcDtVuwiwoQGRLTtjNYI9d0T6LCfbXmpXhVU5KW0YySBCCK8x6YDIJGzWjntpZPk7lNLtpzS1S10aSlpt4IGtfBJg3HwWRaGKJV6+xRfaESilA65g6lnSE8QlldGgkjYqJBKiebUNCShQR7YgOjE+W92zLqsK7/6qUWNoajvywBRbAKt4fAi5rHrt+TX3+oaBbRaMmhNscCseDySusWxDJ4Lc64slkMj0QEudVAdcEK2wzKhWVBoB8x/rphj7b+MCizlWBdFfM5mBt9i0az7XZ5pxrKgDGly5kBJgEi2K2JIqX0rcUjED0E5qMc4S2Xb9+4RGtrBPWbO42YoH/bP+AQs57s0GfJAtvJsZ4QXf39UOWqUhTsKlN3+vN6Er93QFzhXO9OiSONIEYoRy+euOMF3h9st961BZuHO+uFMKGcBhHUM8CLXA0wRgA95lpE8dvPq9wDqULBW+zqXTkZujH4SJlwI+xp+F1k1XK9KzhmkcqQ1Fwb7T8TyVopQEE1p7WJGt/z/aCDhlUm7sem9YI53rcLjBjmJw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB3564.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHhIUC9rdnNBYUtoWExYMmdKYVJBZEZIMXpwOGpGWWl4Q01Ob0tMZ2pkUjRn?=
 =?utf-8?B?UjB4bmU4OEFZanFYWVgyS2hVKzZIQWdRaU1IOEdVQUE1WjhKMzBnMHRLOE81?=
 =?utf-8?B?SVN4dUYydVY1N1pUa1JaOFZKTHZJRm9JWE42M0lyQ2d2dm1zcEd5cFNGSDQw?=
 =?utf-8?B?YjhzOW1ZYnhyUUgvaWh4b0lnL2M2T2dla0o4ZlorMms2K0tGckdhL1NEWEVO?=
 =?utf-8?B?ME5aaEdKN0grVlVWVWJlUkwyelhaUEJyK0xmQVNrVVlmMDNZMzdRVzFNTjU0?=
 =?utf-8?B?c1NWbGxGTWU2UVNTWjdPQzlpVm95ZXduSldDWGd2MmdPL2tqWmJNYkdSMHFq?=
 =?utf-8?B?YlRIL3d3Q3AxNVVRcjFoSm9HbHNJZ2lxWTRPcVB0RkI2ZnIvWVpieUZQdmZU?=
 =?utf-8?B?NVZxdVh6MHhxQnliSXZzK1Q2Z2I2U2xWdFUvREwvRHo4a3RUQU9WTkpIRWpt?=
 =?utf-8?B?UnpCUEh4QWk1TEkwR241aGFXVmJadlNxQkNSYjNUOC9nWkdkT3BESGhGN1Mw?=
 =?utf-8?B?K256RlZkckovamswTkR5UXpnRk12RS9sR0JnaHdJNDhaVDNadVB5R1U4b1RZ?=
 =?utf-8?B?OHZscEVPUHp1NGZ3ZVJZZGl2Z2RRUzM5R0tONFdwM1BXNVloSlhmUjdhRXhi?=
 =?utf-8?B?WWN5cmZDTzNtYjZxRDBpNWplYTJhSmhKZEVZOGRldkxLdlRJMVpVVUZjcXlJ?=
 =?utf-8?B?RVhzVkhKT05Uc0hDM2p4ZVh6OHpWTmxZZTZyclRBYVpRUk1ZN2tuVGpuVEVt?=
 =?utf-8?B?bDFKbDNXOW9SWTVQOFpjdzZYTWF3ME1UMXRLWjJ2emlzQ0M1MURIN1ZvODUr?=
 =?utf-8?B?cVVDbThLMWdxdXhMRURJSEVrTmhoK2x5TXBqRkI2TlRFNTVNU3FIVWkxdm9s?=
 =?utf-8?B?L3F2TndKcWVpMk4zVVcxOW5mSGdxaTlUcy9mSU05L1hYbkZScmg0c292bThh?=
 =?utf-8?B?WFZpb3lNdnA2bXZjS2lFSkFDZ1V3VXc4UkRlYWVKVnZrOVZMa1BnNGJSZitn?=
 =?utf-8?B?dVFpMFVZbkZCSHNJUHZJTk80NTJ2WFNXM2Vsd0wwVnpJL3VMZmpRSUtQbUkx?=
 =?utf-8?B?NE92REw1L1ptd0dSb2xyeGkxaXM5U3lPVnFtZWhtZ0tRWlNPWmJ0aGFmd25X?=
 =?utf-8?B?M2tiVS9DWUdUNVlWSlFmc3dYM215L2UyUTVSb2MxNmFnWm1BQnlmMUE1SlVY?=
 =?utf-8?B?aVM2TmZZcVF3djFFU2pjMk0zYVBEWkM4N2gxUGZLcjRTUkpmNzBibTREZlFu?=
 =?utf-8?B?RGU5cTlqbm5aN1Bnc0YxSHJaUnFoZnlEUytZTnZoeHlhT1lGMlI1OHU4V2ZX?=
 =?utf-8?B?S1ZaZEpEZWk4MkN1bGFuK1lMeGdTZGlMZUVUYmFmdFNGVGtUU0QzTk9ENU9m?=
 =?utf-8?B?QWZMMmV6eU5YdkpaUzlzYTZTYTArajZBVkVGSXhtT3RlWlZabjIxdkZrSzJN?=
 =?utf-8?B?VExWQlRHVGtkZE1NaVJlVm9IcVFHZEMrTWk3OW13QUcwbkFzTDBrNTkzbXpq?=
 =?utf-8?B?c0xHNzVMM1RpWUpCVzhTVTVWUFpLRlIxNnY0cklMeEpBTkdqZFBHRWpjeEgx?=
 =?utf-8?B?WHZhNVpwUlVveHhqWFc2eHNBQ0pzYjNjL1NncVk4TWIwZDVNNlRuRCtzdVN6?=
 =?utf-8?B?WjVkQVFxa0cvck9sSUYzK0ZoeUJ3eTZGWGluRzlKVE53c1NHTjBKY1EzemJk?=
 =?utf-8?B?VmZLYktOQ2ZrU1laRVo2RHJKeG53c0V5RU9YR0hCNXZaZThMdHh0WVFhZHVU?=
 =?utf-8?B?T2tVKzRVai9FY28zTjNqNDlkWmVDb2E4QnpkNXNTSEZFQWdLc2hpMSttQU5p?=
 =?utf-8?B?RDdXRnFnbGo1aW91RFp1Q3RkeE0xKzB5WkZpQU5jSGJLdVhwdkNzSEZXQU0r?=
 =?utf-8?B?ZTdwWlozMHYzczc2SGdsaG03aDUzNGNacjVvS3FxcHZCMkcvL3RvZktnY1dM?=
 =?utf-8?B?c1A0b0U0dkd3TWE0b3g3cUViMDhUTWxUSGN6NG4wN210czh2c1hhSG9qK3gw?=
 =?utf-8?B?WWpCYUt2elB4dGlVZ0d4eDVFNS9WcEN2bkNFd2owTXNTNE9XR2NmTnZjcWMw?=
 =?utf-8?B?a0RZVXNSN0d5UWxhK2JGSHlhUlJIRkxuMkJwQkZyWk9NOUpRc3lnS21EenJV?=
 =?utf-8?B?OW91dmdnZGhTNmRsRU9lb3F3dDhkb2xkTS9VOHcyUUNhdmV3aHduTFZNV2w1?=
 =?utf-8?B?MXBaOSt4RERKYlQvZFpCQXhSTjM4dm5td0FCb3lUdEMva0N4ZVBLQUJNNWg1?=
 =?utf-8?B?VEI1R2h6NExWcXFUaEp6QUxaNXVUZzE1V2JtaFJrc2JLcVJuUTYrcGorTW5l?=
 =?utf-8?B?dEpnaGw3MGoxYnhQRFQxZGQ1ME1YaE02OWdzbzBGRGJOaW9udzB6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ep5jT+EdN0KKk4RgtL7uXhnriBk/2jRxJLt4pd3fwGu7oIERvKIH5vfWcygFZmOjZWO6OYYjKwMd6onBflHU5ZgEQ/EeJ5CcBD3XyBM5v2Dp89N1irQVseuZLmZ32h54iSTl0AS+7zoQqg6SyQUWK+DUSfxSZYM4B/OIGXxgOe9i7YBolmbuLX/I3YuK9niA2dGx2FvQfOrKKLOwjuLTORCQiGTfVmhqaEHch3YPENChLqSwh6dG9k9Io6a53nyk+sGw2jhQ3xQ8iQVrPxprq/oqZGEbPmnmtd8grCDuWC4amekbG6dosJ3m2KsUh7S+9Rq5d/AOtlxPxQQulIraWg==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3564.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd66cbb2-5bf4-491e-5e19-08de94f731c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 22:44:14.6053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9v1RCXCkO1Mk/omJ9mrLoZ3qsabvh+rjz/ciYrLNVBiwEpGhm/Sz+IIUXdIKa0njSwHtM/2iqZeSOs/5n/yd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070208
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=69d588c6 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=aNt9FJNJ8fZyd9HhltU_:22 a=jZVsG21pAAAA:8 a=iLNU1ar6AAAA:8 a=8rWy6zfcAAAA:8
 a=bt5KbKNvAAAA:8 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=hy6ZlEeW0J_FMa1EaO4A:9
 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-GUID: qrZ4eYiqH8fZupAho4tgPVRqnB_wRAVz
X-Proofpoint-ORIG-GUID: qrZ4eYiqH8fZupAho4tgPVRqnB_wRAVz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDIwOCBTYWx0ZWRfX7VIqHTyNwBlM
 /jIVIAxN6XSJnNjTH9OrhDRXKQ6/s2xwO/zmm0mh+mDqd7igX3kK4nGXQeDXSz/Ql6ipKurJaZK
 AINIxzqWMCDUx1TpaYXmYa5I4QXL6GDdQup63fx7otZ9gtDzgjEWCFbtA3zpl/QDqqFGnZ3pPck
 honiDKKMzY8FtFynJ5377Jxd6nVqYb3Kmf8OjxmDcf8zq2ZlhPCJ3ipvhFrbSK1oyaEcRXq2fJ4
 HdrdyCLuyecIfsEq4RVhNwVWhLB5cbTmHh1nDE5/T/MxuJ1MBI+LKiF17FRkLZZFjEvKrv+glhO
 dgp6q37Qv3L/NoYyNToiQEvfTBaLX6eAnEgzwP7IrQMxq7a7SBpd/0Bmbm3NwPAuMtOk1kkSaap
 iepj0DJPfEIQj2oubqzUYbS8d7kV1/duvNGf6NEN8s7UHtYKm7FSuCdIAs/q9QvR250ZyTeMyYY
 P8meTwKW91fuuZ+1n3g==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070208
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

RGVhciBTdGVwaGVuLA0KDQpUaGUgY2hhbmdlcyB5b3Ugc3VnZ2VzdGVkIGhhdmUgYmVlbiBpbmNv
cnBvcmF0ZWQgaW4gdGhlIGxhdGVzdCBwYXRjaC1zZXQgdjEwLiBSZXNwb25zZXMgdG8gY29tbWVu
dHMgaW5saW5lLg0KDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3
b3JrcGx1bWJlci5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDcsIDIwMjYgNzoyMSBBTQ0K
PiBUbzogQmF0aGlqYSwgUHJhdmluIDxQcmF2aW4uQmF0aGlqYUBkZWxsLmNvbT4NCj4gQ2M6IGRl
dkBkcGRrLm9yZzsgdGhvbWFzQG1vbmphbG9uLm5ldDsgbWF4aW1lLmNvcXVlbGluQHJlZGhhdC5j
b207DQo+IGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkg
MC81XSBTdXBwb3J0IGFkZC9yZW1vdmUgbWVtb3J5IHJlZ2lvbiBhbmQgZ2V0LW1heC0NCj4gc2xv
dHMNCj4NCj4NCj4gW0VYVEVSTkFMIEVNQUlMXQ0KPg0KPiBPbiBUdWUsIDcgQXByIDIwMjYgMDg6
MDY6MzEgKzAwMDANCj4gPHByYXZpbi5iYXRoaWphQGRlbGwuY29tPiB3cm90ZToNCj4NCj4gPiBG
cm9tOiBQcmF2aW4gTSBCYXRoaWphIDxwcmF2aW4uYmF0aGlqYUBkZWxsLmNvbT4NCj4gPg0KPiA+
IFRoaXMgaXMgdmVyc2lvbiB2OSBvZiB0aGUgcGF0Y2hzZXQgYW5kIGl0IGluY29ycG9yYXRlcyB0
aGUNCj4gPiByZWNvbW1lbmRhdGlvbnMgbWFkZSBieSBTdGVwaGVuIEhlbW1pbmdlci4NCj4gPg0K
PiA+IENoYW5nZXMgbWFkZSB0byBwYXRjaCAzLzUNCj4gPiAtIFJlc3RvcmVkIG1heF9ndWVzdF9w
YWdlcyBpbml0aWFsIHZhbHVlIHRvIGhhcmRjb2RlZCA4IGluc3RlYWQgb2YNCj4gPiAgIFZIT1NU
X01FTU9SWV9NQVhfTlJFR0lPTlMsIG1hdGNoaW5nIHVwc3RyZWFtIHNlbWFudGljcy4NCj4gPg0K
PiA+IENoYW5nZXMgbWFkZSB0byBwYXRjaCA0LzUNCj4gPiAtIEFkZGVkIGNsb3NlKHJlZy0+ZmQp
IGFuZCByZWctPmZkID0gLTEgYmVmb3JlIGdvdG8gY2xvc2VfbXNnX2ZkcyBpbiB0aGUNCj4gPiAg
IG1tYXAgZmFpbHVyZSBwYXRoIHRvIGZpeCBmZCBsZWFrIGFmdGVyIGZkIHdhcyBtb3ZlZCBmcm9t
IGN0eC0+ZmRzWzBdLg0KPiA+IC0gQ29udmVydGVkIGRldl9pbnZhbGlkYXRlX3ZyaW5ncyBmcm9t
IGEgcGxhaW4gZnVuY3Rpb24gdG8gYSBtYWNybyArDQo+ID4gICBpbXBsZW1lbnRhdGlvbiBmdW5j
dGlvbiBwYWlyLCBhY2NlcHRpbmcgbWVzc2FnZSBJRCBhcyBhIHBhcmFtZXRlciBzbw0KPiA+ICAg
dGhlIHN0YXRpY19hc3NlcnQgcmVwb3J0cyB0aGUgY29ycmVjdCBoYW5kbGVyIGF0IGVhY2ggY2Fs
bCBzaXRlLg0KPiA+IC0gVXBkYXRlZCBkZXZfaW52YWxpZGF0ZV92cmluZ3MgY2FsbCBpbiBhZGRf
bWVtX3JlZyB0byBwYXNzDQo+ID4gICBWSE9TVF9VU0VSX0FERF9NRU1fUkVHIGFzIG1lc3NhZ2Ug
SUQuDQo+ID4gLSBVcGRhdGVkIGRldl9pbnZhbGlkYXRlX3ZyaW5ncyBjYWxsIGluIHJlbV9tZW1f
cmVnIHRvIHBhc3MNCj4gPiAgIFZIT1NUX1VTRVJfQUREX01FTV9SRUcgYXMgbWVzc2FnZSBJRC4N
Cj4gPg0KPiA+IFRoaXMgaW1wbGVtZW50YXRpb24gaGFzIGJlZW4gZXh0ZW5zaXZlbHkgdGVzdGVk
IGJ5IGRvaW5nIFJlYWQvV3JpdGUNCj4gPiBJL08gZnJvbSBtdWx0aXBsZSBpbnN0YW5jZXMgb2Yg
ZmlvICsgbGliYmxraW8gKGZyb250LWVuZCkgdGFsa2luZyB0bw0KPiA+IHNwZGsvZHBkayAoYmFj
ay1lbmQpIGJhc2VkIGRyaXZlcy4gVGVzdGVkIHdpdGggcWVtdSBmcm9udC1lbmQgdGFsa2luZw0K
PiA+IHRvIGRwZGsgdGVzdHBtZCAoYmFjay1lbmQpIHBlcmZvcm1pbmcgYWRkL3JlbW92YWwgb2Yg
bWVtb3J5IHJlZ2lvbnMuDQo+ID4gQWxzbyB0ZXN0ZWQgcG9zdC1jb3B5IGxpdmUgbWlncmF0aW9u
IGFmdGVyIGRvaW5nIGFkZF9tZW1vcnlfcmVnaW9uLg0KPiA+DQo+ID4gVmVyc2lvbiBMb2c6DQo+
ID4gVmVyc2lvbiB2OSAoQ3VycmVudCB2ZXJzaW9uKTogSW5jb3Jwb3JhdGUgY29kZSByZXZpZXcg
c3VnZ2VzdGlvbnMgZnJvbQ0KPiA+IFN0ZXBoZW4gSGVtbWluZ2VyIGFzIGRlc2NyaWJlZCBhYm92
ZS4NCj4gPiBWZXJzaW9uIHY4OiAgSW5jb3Jwb3JhdGUgY29kZSByZXZpZXcgc3VnZ2VzdGlvbnMg
ZnJvbSBTdGVwaGVuIEhlbW1pbmdlci4NCj4gPiByZXdyaXRlIGFzeW5jX2RtYV9tYXBfcmVnaW9u
IGZ1bmN0aW9uIHRvIGl0ZXJhdGUgZ3Vlc3QgcGFnZXMgYnkgaG9zdA0KPiA+IGFkZHJlc3MgcmFu
Z2UgbWF0Y2hpbmcgY2hhbmdlIGZ1bmN0aW9uIGRldl9pbnZhbGlkYXRlX3ZyaW5ncyB0byBhY2Nl
cHQNCj4gPiBhIGRvdWJsZSBwb2ludGVyIHRvIHByb3BhZ2F0ZSBwb2ludGVyIHVwZGF0ZXMgbmV3
IGZ1bmN0aW9uDQo+ID4gcmVtb3ZlX2d1ZXN0X3BhZ2VzIHdhcyBhZGRlZCBhZGRfbWVtX3JlZyBl
cnJvciBwYXRoIHdhcyBuYXJyb3dlZCB0bw0KPiA+IG9ubHkgY2xlYW4gdXAgdGhlIHNpbmdsZSBm
YWlsZWQgcmVnaW9uIGluc3RlYWQgb2YgZGVzdHJvdGluZyBhbGwNCj4gPiBleGlzdGluZyByZWdp
b25zIFZlcnNpb24gdjc6IEluY29ycG9yYXRlIGNvZGUgcmV2aWV3IHN1Z2dlc3Rpb25zIGZyb20N
Cj4gPiBNYXhpbWUgQ29xdWVsaW4uDQo+ID4gQWRkIGRlYnVnIG1lc3NhZ2VzIHRvIHZob3N0X3Bv
c3Rjb3B5X3JlZ2lzdGVyIGZ1bmN0aW9uLg0KPiA+IFZlcnNpb24gdjY6IEFkZGVkIHRoZSBlbmFi
bGVtZW50IG9mIHRoaXMgZmVhdHVyZSBhcyBhIGZpbmFsIHBhdGNoIGluDQo+ID4gdGhpcyBwYXRj
aC1zZXQgYW5kIG90aGVyIGNvZGUgb3B0aW1pemF0aW9ucyBhcyBzdWdnZXN0ZWQgYnkgTWF4aW1l
DQo+ID4gQ29xdWVsaW4uDQo+ID4gVmVyc2lvbiB2NTogcmVtb3ZlZCB0aGUgcGF0Y2ggdGhhdCBp
bmNyZWFzZWQgdGhlIG51bWJlciBvZiBtZW1vcnkNCj4gPiByZWdpb25zIGZyb20gOCB0byAxMjgu
IFRoaXMgd2lsbCBiZSBzdWJtaXR0ZWQgYXMgYSBzZXBhcmF0ZSBmZWF0dXJlIGF0DQo+ID4gYSBs
YXRlciBwb2ludCBhZnRlciBpbmNvcnBvcmF0aW5nIGFkZGl0aW9uYWwgb3B0aW1pemF0aW9ucy4g
QWxzbw0KPiA+IGluY2x1ZGVzIGNvZGUgb3B0aW1pemF0aW9ucyBhcyBzdWdnZXN0ZWQgYnkgRmVu
ZyBDaGVuZyBXZW4uDQo+ID4gVmVyc2lvbiB2NDogY29kZSBvcHRpbWl6YXRpb25zIGFzIHN1Z2dl
c3RlZCBieSBGZW5nIENoZW5nIFdlbi4NCj4gPiBWZXJzaW9uIHYzOiBjb2RlIG9wdGltaXphdGlv
bnMgYXMgc3VnZ2VzdGVkIGJ5IE1heGltZSBDb3F1ZWxpbiBhbmQNCj4gPiBUaG9tYXMgTW9uamFs
b24uDQo+ID4gVmVyc2lvbiB2MjogY29kZSBvcHRpbWl6YXRpb25zIGFzIHN1Z2dlc3RlZCBieSBN
YXhpbWUgQ29xdWVsaW4uDQo+ID4gVmVyc2lvbiB2MTogSW5pdGlhbCBwYXRjaCBzZXQuDQo+ID4N
Cj4gPiBQcmF2aW4gTSBCYXRoaWphICg1KToNCj4gPiAgIHZob3N0OiBhZGQgdXNlciB0byBtYWls
bWFwIGFuZCBkZWZpbmUgdG8gdmhvc3QgaGRyDQo+ID4gICB2aG9zdF91c2VyOiBoZWFkZXIgZGVm
aW5lcyBmb3IgYWRkL3JlbSBtZW0gcmVnaW9uDQo+ID4gICB2aG9zdF91c2VyOiBzdXBwb3J0IGZ1
bmN0aW9uIGRlZmluZXMgZm9yIGJhY2stZW5kDQo+ID4gICB2aG9zdF91c2VyOiBGdW5jdGlvbiBk
ZWZzIGZvciBhZGQvcmVtIG1lbSByZWdpb25zDQo+ID4gICB2aG9zdF91c2VyOiBlbmFibGUgY29u
ZmlndXJlIG1lbW9yeSBzbG90cw0KPiA+DQo+ID4gIC5tYWlsbWFwICAgICAgICAgICAgICAgfCAg
IDEgKw0KPiA+ICBsaWIvdmhvc3QvcnRlX3Zob3N0LmggIHwgICA0ICsNCj4gPiAgbGliL3Zob3N0
L3Zob3N0X3VzZXIuYyB8IDQwMw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tDQo+ID4gIGxpYi92aG9zdC92aG9zdF91c2VyLmggfCAgMTAgKw0KPiA+ICA0IGZp
bGVzIGNoYW5nZWQsIDM3NSBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkNCj4gPg0KPg0K
PiBBSSByZXZpZXcgaXMgbW9zdGx5IGNsZWFuIG5vdy4NCj4NCj4gUGF0Y2ggc2VyaWVzIGxvb2tz
IGdvb2Qgb3ZlcmFsbC4gT25lIGlzc3VlIGluIDQvNToNCj4gSW4gcmVtX21lbV9yZWcsIGRldl9p
bnZhbGlkYXRlX3ZyaW5ncyAod2hpY2ggY2FsbHMNCj4gdHJhbnNsYXRlX3JpbmdfYWRkcmVzc2Vz
KSBydW5zIHdoaWxlIHRoZSByZWdpb24gYmVpbmcgcmVtb3ZlZCBpcyBzdGlsbCBtYXBwZWQuDQo+
IEFueSB2cmluZyBhZGRyZXNzIHRoYXQgcmVzb2x2ZXMgaW50byB0aGF0IHJlZ2lvbiB3aWxsIGdl
dCBhIHBvaW50ZXIgdGhhdCBiZWNvbWVzDQo+IGludmFsaWQgYWZ0ZXIgdGhlIHN1YnNlcXVlbnQg
ZnJlZV9tZW1fcmVnaW9uL211bm1hcC4gQ29uc2lkZXIgZnJlZWluZyB0aGUNCj4gcmVnaW9uIGZp
cnN0IHNvIHRyYW5zbGF0ZSBvbmx5IHNlZXMgc3Vydml2aW5nIHJlZ2lvbnMuDQo+DQpUaGFua3Mg
Zm9yIGNhdGNoaW5nIHRoYXQg4oCUIG1vdmVkIGRldl9pbnZhbGlkYXRlX3ZyaW5ncyBhZnRlciBm
cmVlX21lbV9yZWdpb24gYW5kIHRoZSBhcnJheSBjb21wYWN0aW9uIHNvIHRoYXQNCnRyYW5zbGF0
ZV9yaW5nX2FkZHJlc3NlcyBvbmx5IHNlZXMgc3Vydml2aW5nIHJlZ2lvbnMuDQoNCj4gQWxzbyBt
aW5vcjogdGhlIHY5IGNvdmVyIGxldHRlciBjaGFuZ2Vsb2cgc2F5cyByZW1fbWVtX3JlZyBwYXNz
ZXMNCj4gVkhPU1RfVVNFUl9BRERfTUVNX1JFRyBidXQgdGhlIGNvZGUgY29ycmVjdGx5IHVzZXMN
Cj4gVkhPU1RfVVNFUl9SRU1fTUVNX1JFRyDigJQganVzdCBhIHR5cG8gaW4gdGhlIGNoYW5nZWxv
Zy4NCg0KQWdhaW4gZ29vZCBjYXRjaCwgbWFkZSB0aGUgZWRpdCB0byB0aGUgY292ZXIgbGV0dGVy
Lg0K
