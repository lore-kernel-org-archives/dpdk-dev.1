Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EFCFF8855
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 12:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D6904027E;
	Wed,  6 May 2026 14:58:24 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11023106.outbound.protection.outlook.com
 [40.107.201.106])
 by mails.dpdk.org (Postfix) with ESMTP id C54BE400D6
 for <dev@dpdk.org>; Wed,  6 May 2026 09:17:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox4kZalHidbN+uuqeKo8aazM9SJj9To9Wfn4Z3hSGfLgoFYXsH+YRxUP7fPJPVYVK2Yu9TGVjCvTTLfZxSsjQDmG2AYHOJkgkaFGF2OhOfWIVfhTxVUySynGBOFbfNgEL/YqIWl1C33QcvpjRWh5V1jpWWALLSIfW+XH8cfeFAPJ7nap52upiJpoP5cgHTqQ0Udcvp+MpYWfvgndjP5Xso4prQrqLFtGM03uTohAdFrBRE7LRmN4tl7sTGJ5Z1GqgbjNh3gsLRbOgsNCPqZIthspxwlJm+WCY5rhFUwE2HZH1/yKVBm9tpeS7cW/jJ82ruKWG/VtxMcLMs0Q01RU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvJWvDlbea+xzGGdz87szo4YAVCJoIsRAHsy5XZ77hY=;
 b=hcNENNSPI0UqNuChR0ahdPQDncrYfjyz3J8iAVIpXczvSseUTSqyScgCWOoiRt4EcGrjMYJkHSeLtEIvm8R42H/gD1Y0SMsccZKV6p2gqr5iAbwnNBd61CX5hEFce/4ivYAGG0T99VO3Y5jOxAWvJppfo0RKVljrzYxJ8NLJPZPW+7ZCU/2Q6Gd3QK3rh3VtSVOag0RSG1GhSQ+elPM16tYnHnvH3qlJoJ3kKzr3HeV6bmX+FYBhnLGjumEpvBM8bpay/2F3fCxTzMVxz1Cuz+faVmEaeT8oyW6Qo5woOP9XPRyM+AdJcbwjIp0EkYA+phxBYGgf+A/ChgXujpaE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=radisys.com; dmarc=pass action=none header.from=radisys.com;
 dkim=pass header.d=radisys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=radisys.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvJWvDlbea+xzGGdz87szo4YAVCJoIsRAHsy5XZ77hY=;
 b=I66v6gNGOJV++x8M4QHmVlVz2ABSWE5UzjSkVKsm376ONgNzqd5+gXZm6ytiFIsyXlJM17e4K+8R6y4ODtXxyDoePr6siZqiKfyFuQQ5pbeVJcPHFTZ7UfdX2wsxFaPMcbqdApM4ISWx/TfikOVYRM4fZE0V96a4nO0y55wUEV+Rztnj2ut67enwrHKE1xL3mZkNgnPDp8sRoFujlBd3vgRDaamh+EuHM7FjmYRMSDqvICNAdvAFA5TWEkZxWxIjlvafOo+YS12W+Is6nZnqiQn0T7a/qTrF4kaa9lNqJKgc9VqRu09WhXSYBh9ihiG7SCgMAkwsxwhXL9YbhtQgCg==
Received: from CYXPR08MB9478.namprd08.prod.outlook.com (2603:10b6:930:e0::22)
 by SA1PR08MB9743.namprd08.prod.outlook.com (2603:10b6:806:3cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 07:17:36 +0000
Received: from CYXPR08MB9478.namprd08.prod.outlook.com
 ([fe80::fe4d:bfef:1b87:d937]) by CYXPR08MB9478.namprd08.prod.outlook.com
 ([fe80::fe4d:bfef:1b87:d937%6]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 07:17:36 +0000
From: Reema Sharma <Reema.Sharma@radisys.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>, 
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
 "jack.bond-preston@foss.arm.com" <jack.bond-preston@foss.arm.com>,
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, "kai.ji@intel.com"
 <kai.ji@intel.com>, Prakash Durgapal <Prakash.Durgapal@radisys.com>, Pratap
 Rana <Pratap.Rana@radisys.com>, Vijay Kumar Mahto <Vijay.Mahto@radisys.com>,
 Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com>, "Liu1, Kai"
 <kai.liu1@intel.com>, "Zhang, Liheng" <liheng.zhang@intel.com>, "Xiong,
 Tanghong" <tanghong.xiong@intel.com>, =?Windows-1252?Q?Mattias_R=F6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11
 Compilation Errors
Thread-Topic: Request for Review of Fixes Applied for DPDK 24.11 and 25.11
 Compilation Errors
Thread-Index: AQHcmxkEps5DwiT+1ky/8nPNVa1UZ7WhHnfBgAAlLgCAABUuUIAADBwggAABVTCAAAI78IAdiMWlgAA4NgCAAZJyD4BALPTl
Date: Wed, 6 May 2026 07:17:36 +0000
Message-ID: <DS0PR08MB946527D1CFA667062588E491863F2@DS0PR08MB9465.namprd08.prod.outlook.com>
References: <DS0PR08MB946583905393503122A46A898663A@DS0PR08MB9465.namprd08.prod.outlook.com>
 <SA2PR11MB5051B9440668583D5524F40E847AA@SA2PR11MB5051.namprd11.prod.outlook.com>
 <DS0PR08MB9465E1596F77A744A34FECD68649A@DS0PR08MB9465.namprd08.prod.outlook.com>
 <5559422.aeNJFYEL58@thomas>
 <DS0PR08MB9465E290C821A7DB32822DA08656A@DS0PR08MB9465.namprd08.prod.outlook.com>
In-Reply-To: <DS0PR08MB9465E290C821A7DB32822DA08656A@DS0PR08MB9465.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: thomas@monjalon.net
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_8aa00c31-701e-4223-8b9c-13bd86c6a24f_Enabled=True;
 MSIP_Label_8aa00c31-701e-4223-8b9c-13bd86c6a24f_SiteId=d05e4a96-dcd9-4c15-a71a-9c868da4f308;
 MSIP_Label_8aa00c31-701e-4223-8b9c-13bd86c6a24f_SetDate=2026-05-06T07:17:35.596Z;
 MSIP_Label_8aa00c31-701e-4223-8b9c-13bd86c6a24f_Name=Internal;
 MSIP_Label_8aa00c31-701e-4223-8b9c-13bd86c6a24f_ContentBits=1;
 MSIP_Label_8aa00c31-701e-4223-8b9c-13bd86c6a24f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=radisys.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR08MB9478:EE_|SA1PR08MB9743:EE_
x-ms-office365-filtering-correlation-id: e0c7550f-b539-49c0-c19d-08deab3f8cd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|18002099003|8096899003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UO9+KA1D9GVCxhSL2mIN/h3UOgW/8EpA/vzWq8tJCHD+EYBC3H2nY8SzcYGQr6eZnGUkuJldXMfg1a7ED/60ldX3hZ5Tz+w9P2B4eEVo7U/38zFwkWM2kcf4hdki3mR8jX1o5ZoFNgSxg7NxtgILkm9UCaEjngKkMaUswN1LOPyup5csULYZyvyHT7DG9xA0nj8gven26ODuvpSLJ/MBI7WPFrpWSF+SIeWrWNE+MTkwVZyTVKXiS8pqlDcz+dZSjSegMFbpLw4/EzMZfk3sLAXmYKFcr9a1+Qf5F/nZxgDTEY6mOUJ3ZAZzC76r5ddQX13vAaglreuHncLTM8IC4V4Tc5ob617OrgX8B+DcUsxpLY35cKXpV9P6zyRZ0s7BKbsGLXJuCbUPAiBp0gLUdNVxMuOrpmlft566QupHWnDJgS2TKFpZ4grcrWLEfBCw5UOTYOfniXp41lpCFmGXGHrszbY+J+LZRUa4aE4Q2qjnZjB5PWZ44z7TGW0S3CqatiiU9uhGdxYZHeXScHuw3SrUM0+NNHR1Q6Da1DZ7ZbgoYFpX8DmINluSfwrHGde+a5JfJFIZID/H4OGZsHRR7ru2+bYNk28SfmSQeqtWbjZrolAovdPw2XAVesHsPKi+N+0s8JDgrVo+sNyW2IXeDVoW9jREYF+efCCSvxlJtc2nGiGtgiZjBCE1dGMxCuriOxabrx6zucL4iMhzjeUBFrZ/Tu0w9AFnFg3tbAp2oZ1tTT2udLffobStXIzQeCqv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR08MB9478.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(8096899003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?M0eZ+U7NCh/AfbOCcaz/AUbUb2ZClwOvanCrkQrCwiZCFDah5lkSOlRw?=
 =?Windows-1252?Q?dSrRJok0ogV+Udbf1Z/fXieSWZwObuoOebPSyf55DZJfZPqj1mM4UG+b?=
 =?Windows-1252?Q?jcKSOLERE+wH/wuT3ppVW6A6KL56aDq5e7d6aZeE5SdwHYllQZ9fFDPD?=
 =?Windows-1252?Q?Lr0pyF6VhP/sKkM4+Tky2t/O44d1JHBTsf0QSlphEh/0mILIl+VgIn5Q?=
 =?Windows-1252?Q?mF3CuoW8iXLMUVz8MeX2jaPXwW/VSX1ZdySWyV/z1FLIwfwgSN9ceNVe?=
 =?Windows-1252?Q?iFj6+0trxHau7O0KbMOAOINdRmK/SKAasKh2LLE8emXYBAZm7OQ1HQ7B?=
 =?Windows-1252?Q?SRe71dN8PH/ewMGPlSLt0W1DgHGO89mDh2z7rZ74Q9rgvUk2Fv9m0DYQ?=
 =?Windows-1252?Q?LkFIEfPQClqMAL4/cDUU79zSVNIvXJNxkStlIcS2vt/miKW40TrMvH01?=
 =?Windows-1252?Q?qNipE7hjLXtANskSdXLcoShSuyK9+AvmdmK95nUF9FYKMv3n75ErRhCz?=
 =?Windows-1252?Q?c76Ia2O+oW0nUHEs9zgicHsG72vDzN19zQxCqZEyKxdgcsr/EI/WkCgU?=
 =?Windows-1252?Q?NHHmWkzlK49YE0lIuT13M9ejS5+763OsH+7FfeQn4wqmEAoOr3cO3rs3?=
 =?Windows-1252?Q?Xsrqh4r+ayoLs+kGewJJoYZPLLDxlUhtukAbMeF29RUk3j24YpYi8eH1?=
 =?Windows-1252?Q?BWi394A95QZj3nGSGJ9gJ9XGQekvvgssPTI+RmRg6EW4nQ6CiQfapPLp?=
 =?Windows-1252?Q?hOXYeUNLUN6410BT2lihnr/NGZHCdJMPw98v4PvZ0vGQ2d+N2iNG1mUq?=
 =?Windows-1252?Q?i2l9Or941D4QFw7mNM0fOsapNC8IbDFadUiYxY8pa0JJ+6Su/Tb519Ak?=
 =?Windows-1252?Q?EEMP5t9vhqrJwr4amt8/PkMKz3cnPkuSqwglV3JoIU65gWvkd56Wnyil?=
 =?Windows-1252?Q?YZiu85XZMy+0ok6GRakgVfw+anS+rzxXk1mnEy9Ia5TD+oe7PwV6jSYA?=
 =?Windows-1252?Q?Zpc59SIv8nKPhVR0lxAIvJKAMOnFtu4VA9/mdNf5X8WxW52JPNE/SoS1?=
 =?Windows-1252?Q?x+OgWMExt48r0wuX9hXEdKW3wweHKolEQgzJc/UjwH/pXV2hsu0LsejW?=
 =?Windows-1252?Q?HFfH0G5rlsQRPcczscn6EPxm9Q330lxqpd22+Seoq2deE0ATUUzKI3x0?=
 =?Windows-1252?Q?DMMI9TWj3myxS5WRoUJIB4Q/iscoUhkeFou7UHSXU6PcxCnV5rfGNqL1?=
 =?Windows-1252?Q?NYJkt1q44YWSHprdO9J+nBn/Gh3sqsMEVZu8EXVbNxVoz9XBZvCUaQx3?=
 =?Windows-1252?Q?KPvNM9P+R3FHY0p1BCMcblj4qXMf+i5RS7AQZ2KbrYRgB58fY11izPTi?=
 =?Windows-1252?Q?Axyz5EHhFrZDen+zlqbmj9/h2pCrkn1gcZ6P/X/er5z6G8gdEUqDSgFO?=
 =?Windows-1252?Q?AfMBWdC/ImHhmunzpOOVUS/LL8rT1D0CxFkzHtKKqIOXY9cp/787Fy0T?=
 =?Windows-1252?Q?NBhdlGa5zOhOwfdpbBkpo2iY2moKphxzM9FRrVhNUayW4XJG/B+m8SAB?=
 =?Windows-1252?Q?eyeL028hmi3OQtgzc126qivNAhiYeZ+4Zx4k8y04WLEB3S0ZnmVE6y9d?=
 =?Windows-1252?Q?YJSukOSp7sflipPm/Fnu4sgPX77R7rDKrqJHSzt1FFJLvvTLDj/ZR8Lr?=
 =?Windows-1252?Q?mmXuURZUmdUft6ydVT+PC3cTMCMM/s8WF6o5G16CBQRW57Sm2h3SaDHh?=
 =?Windows-1252?Q?ZSUA4lOZZOMI8W9VvxgQ3SxmQMdr3RKMp1gNJ+Fxy77xqtOLO5HPklPE?=
 =?Windows-1252?Q?bPgecXP83qFnimgk6YMEQ9AIrKMIO47YCips9orKQ4Lzg2HJ?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR08MB946527D1CFA667062588E491863F2DS0PR08MB9465namp_"
MIME-Version: 1.0
X-OriginatorOrg: radisys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR08MB9478.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c7550f-b539-49c0-c19d-08deab3f8cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 07:17:36.6754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d05e4a96-dcd9-4c15-a71a-9c868da4f308
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zvu1jqWNM2qA/OyaXBtxTUADgTqUUg6m5GIfJ7Pd4WdXttX1tMFfv4HZey3KnXo0w1emORJsE7F3EPz/eNJR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB9743
X-Mailman-Approved-At: Wed, 06 May 2026 14:58:23 +0200
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

--_000_DS0PR08MB946527D1CFA667062588E491863F2DS0PR08MB9465namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Thomas Monjalon<mailto:thomas@monjalon.net> and Team,
I hope you are doing well.
I wanted to follow up on my earlier request regarding the review of the fix=
 for the DPDK 24.11 and 25.11 compilation issues, which was expected to be =
available in a future DPDK release.
Could you please confirm when the fix is likely to be available and in whic=
h upcoming release, we can expect it?
Thanks & Regards,
Reema Sharma
________________________________
From: Reema Sharma <Reema.Sharma@radisys.com>
Sent: Thursday, March 26, 2026 2:16 PM
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org <dev@dpdk.org>; gakhil@marvell.com <gakhil@marvell.com>; d=
avid.marchand@redhat.com <david.marchand@redhat.com>; stephen@networkplumbe=
r.org <stephen@networkplumber.org>; anatoly.burakov@intel.com <anatoly.bura=
kov@intel.com>; jack.bond-preston@foss.arm.com <jack.bond-preston@foss.arm.=
com>; gakhil@marvell.com <gakhil@marvell.com>; fanzhang.oss@gmail.com <fanz=
hang.oss@gmail.com>; kai.ji@intel.com <kai.ji@intel.com>; Prakash Durgapal =
<Prakash.Durgapal@radisys.com>; Pratap Rana <Pratap.Rana@radisys.com>; Vija=
y Kumar Mahto <Vijay.Mahto@radisys.com>; Jaydipkumar Dhameliya <Jaydipkumar=
.Dhameliya@radisys.com>; Liu1, Kai <kai.liu1@intel.com>; Zhang, Liheng <lih=
eng.zhang@intel.com>; Xiong, Tanghong <tanghong.xiong@intel.com>; Mattias R=
=F6nnblom <mattias.ronnblom@ericsson.com>
Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11 C=
ompilation Errors

Hi Thomas Monjalon<mailto:thomas@monjalon.net>,
Thanks for the quick response.
Yes, you understood correctly. I encountered two issues while compiling a C=
++ application(Radisys CU module) linked with DPDK.
Compiler Version: gcc version 11.4.0  (ubuntu  22.04.3)
Regarding rte_bitops.h:
Disabling the macros works for my current use case, so I can proceed with t=
hat approach for now.
I agree that the behaviour of the __RTE_BIT_OVERLOAD macros needs further a=
nalysis, It will be great if fix for this will be available in next DPDK re=
lease. Please find the error details for your reference:
dpdk/dpdk-25.11/x86_64-native-linuxapp-gcc/include/rte_bitops.h:1468:1: err=
or: conflicting declaration of C function =91bool rte_bit_test(const volati=
le uint32_t*, unsigned int)=92
 1468 | rte_bit_ ## family ## fun(qualifier uint ## size ## _t *addr, arg1_=
type arg1_name) \
      | ^~~~~~~~
dpdk/dpdk-25.11/x86_64-native-linuxapp-gcc/include/rte_bitops.h:1468:1: not=
e: in definition of macro =91__RTE_BIT_OVERLOAD_V_2R=92
 1468 | rte_bit_ ## family ## fun(qualifier uint ## size ## _t *addr, arg1_=
type arg1_name) \
      | ^~~~~~~~
dpdk/dpdk-25.11/x86_64-native-linuxapp-gcc/include/rte_bitops.h:1479:9: not=
e: in expansion of macro =91__RTE_BIT_OVERLOAD_SZ_2R=92
 1479 |         __RTE_BIT_OVERLOAD_SZ_2R(family, fun, qualifier, 32, ret_ty=
pe, arg1_type, arg1_name) \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
Regarding rte_cryptodev.h:
This issue is not observed with DPDK 25.11. Please disregard the earlier re=
port.
Thanks & Regards,
Reema Sharma
________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Wednesday, March 25, 2026 1:47 PM
To: Reema Sharma <Reema.Sharma@radisys.com>
Cc: dev@dpdk.org <dev@dpdk.org>; gakhil@marvell.com <gakhil@marvell.com>; d=
avid.marchand@redhat.com <david.marchand@redhat.com>; stephen@networkplumbe=
r.org <stephen@networkplumber.org>; anatoly.burakov@intel.com <anatoly.bura=
kov@intel.com>; jack.bond-preston@foss.arm.com <jack.bond-preston@foss.arm.=
com>; gakhil@marvell.com <gakhil@marvell.com>; fanzhang.oss@gmail.com <fanz=
hang.oss@gmail.com>; kai.ji@intel.com <kai.ji@intel.com>; Prakash Durgapal =
<Prakash.Durgapal@radisys.com>; Pratap Rana <Pratap.Rana@radisys.com>; Vija=
y Kumar Mahto <Vijay.Mahto@radisys.com>; Jaydipkumar Dhameliya <Jaydipkumar=
.Dhameliya@radisys.com>; Liu1, Kai <kai.liu1@intel.com>; Zhang, Liheng <lih=
eng.zhang@intel.com>; Xiong, Tanghong <tanghong.xiong@intel.com>; Mattias R=
=F6nnblom <mattias.ronnblom@ericsson.com>
Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11 C=
ompilation Errors

Hello,

If I understand well, you hit 2 issues while compiling a C++ app linked wit=
h DPDK?
Could you share the exact version of your compiler?

For rte_bitops.h, if disabling these macros is OK for you, go with it for n=
ow.
We will need to understand what happens exactly with __RTE_BIT_OVERLOAD mac=
ros.

For rte_cryptodev.h, it may be hiding an issue somewhere else.
Please could you share the exact error message?



25/03/2026 07:55, Reema Sharma:
> Hi Team,
>
> Could you please review the attached DPDK patch (dpdk-24.11_patch_for_cry=
pto.patch) and confirm whether the applied fixes are acceptable from the DP=
DK perspective?
> Your guidance on the correct fix, if any changes are needed, would help u=
s proceed with CU compilation.
> Kindly share an update at your earliest convenience.
> Thanks & Regards,
> Reema Sharma
> ________________________________
> From: Xiong, Tanghong <tanghong.xiong@intel.com>
> Sent: Friday, March 6, 2026 3:26 PM
> To: Zhang, Liheng <liheng.zhang@intel.com>; Reema Sharma <Reema.Sharma@ra=
disys.com>; Liu1, Kai <kai.liu1@intel.com>
> Cc: Prakash Durgapal <Prakash.Durgapal@radisys.com>; Pratap Rana <Pratap.=
Rana@radisys.com>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com>; Jaydipkumar=
 Dhameliya <Jaydipkumar.Dhameliya@radisys.com>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>
>
> Thanks Liheng,
>
> Just got other info that, you can contact  DPDK directly through this mai=
l: dev@dpdk.org<mailto:dev@dpdk.org>, but the response may be slow.
>
>
>
> BRs,
>
> Tanghong
>
>
>
> From: Zhang, Liheng <liheng.zhang@intel.com>
> Sent: Friday, March 6, 2026 5:51 PM
> To: Reema Sharma <Reema.Sharma@radisys.com>; Xiong, Tanghong <tanghong.xi=
ong@intel.com>; Liu1, Kai <kai.liu1@intel.com>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com>; Pratap Rana <Pratap=
.Rana@radisys.com>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com>; Jaydipkuma=
r Dhameliya <Jaydipkumar.Dhameliya@radisys.com>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>
>
>
> Yes, there is a file =93MAINTAINERS=94 in the DPDK root path.
>
> The file list all the contactor for all dpdk libraries.
>
> You can search and contact the person for crypto issue.
>
> If you can=92t find it, please let me know, I can forward to you.
>
>
>
> From: Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisys.=
com>>
> Sent: Friday, March 6, 2026 5:45 PM
> To: Zhang, Liheng <liheng.zhang@intel.com<mailto:liheng.zhang@intel.com>>=
; Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel.com=
>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com<mailto:prakash.durgap=
al@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@r=
adisys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto=
@radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<ma=
ilto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>
>
>
> Hi Zhang, Liheng<mailto:liheng.zhang@intel.com>,
>
> We have verified the behaviour on CU side and confirmed that this is not =
caused by our code. The issue appears to be related to a DPDK bug.
>
> At the moment, we do not have any contact information for the DPDK mainta=
iners.
> Could you please check internally and share the relevant maintainer detai=
ls or forward this issue on behalf of Radisys?
>
> Thanks & Regards,
>
> Reema Sharma
>
> ________________________________
>
> From: Zhang, Liheng <liheng.zhang@intel.com<mailto:liheng.zhang@intel.com=
>>
> Sent: Friday, March 6, 2026 2:49 PM
> To: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel=
.com>>; Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisys.=
com>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Prakash Durgapal <Prakash.Durgapal@radisys.com<mailto:Prakash.Durgapa=
l@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@ra=
disys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto@=
radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<mai=
lto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>
>
>
> The e-mail below is from an external source. Please do not open attachmen=
ts or click links from an unknown or suspicious origin.
>
> Hi Reema
>
> Looks the changes are ok, but you need verify them by compiling your code=
.
>
> As I know, the following are the better procedures for DPDK bug fix:
>
>   1.  Please first confirm the error are not related to your own code bef=
ore changing DPDK code;
>   2.  If it is real DPDK bug, you need contact the according DPDK maintai=
ner to fix it;
>   3.  Finally DPDK maintainer will provide an official patch;
>
>
>
> From: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@int=
el.com>>
> Sent: Friday, March 6, 2026 3:52 PM
> To: Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisys.co=
m>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>; Zhang, Lihe=
ng <liheng.zhang@intel.com<mailto:liheng.zhang@intel.com>>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com<mailto:prakash.durgap=
al@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@r=
adisys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto=
@radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<ma=
ilto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>
>
>
> Hello Reema,
>
>
>
> Sorry for late reply, copy @Zhang, Liheng<mailto:liheng.zhang@intel.com> =
here for comment, thanks Liheng in advance.
>
>
>
> BRs,
>
> Tanghong
>
>
>
> From: Reema Sharma <Reema.Sharma@radisys.com<mailto:Reema.Sharma@radisys.=
com>>
> Sent: Friday, March 6, 2026 1:41 PM
> To: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel=
.com>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Durgapal, Prakash <prakash.durgapal@radisys.com<mailto:prakash.durgap=
al@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@r=
adisys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto=
@radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<ma=
ilto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25.11=
 Compilation Errors
>
>
>
> Hi Xiong, Tanghong<mailto:tanghong.xiong@intel.com>/ Liu1, Kai<mailto:kai=
.liu1@intel.com>,
>
> Hope you are doing well.
>
> I am writing to check if there is any update on the pending DPDK issue ra=
ised in this mail.
> Could you please share the latest status, or let me know if any additiona=
l inputs are required from my side to help move this forward?
>
> Looking forward to your response.
>
> Thanks & Regards,
>
> Reema Sharma
>
> ________________________________
>
> From: Reema Sharma
> Sent: Wednesday, February 11, 2026 11:27 AM
> To: Xiong, Tanghong <tanghong.xiong@intel.com<mailto:tanghong.xiong@intel=
.com>>; Liu1, Kai <kai.liu1@intel.com<mailto:kai.liu1@intel.com>>
> Cc: Prakash Durgapal <Prakash.Durgapal@radisys.com<mailto:Prakash.Durgapa=
l@radisys.com>>; Pratap Rana <Pratap.Rana@radisys.com<mailto:Pratap.Rana@ra=
disys.com>>; Vijay Kumar Mahto <Vijay.Mahto@radisys.com<mailto:Vijay.Mahto@=
radisys.com>>; Jaydipkumar Dhameliya <Jaydipkumar.Dhameliya@radisys.com<mai=
lto:Jaydipkumar.Dhameliya@radisys.com>>
> Subject: Request for Review of Fixes Applied for DPDK 24.11 and 25.11 Com=
pilation Errors
>
>
>
> Hi Xiong, Tanghong<mailto:tanghong.xiong@intel.com>/ Liu1, Kai<mailto:kai=
.liu1@intel.com>,
>
> While compiling the CU with DPDK 24.11 and DPDK 25.11, we encountered the=
 following two errors:
>
>   1.  Conflicting type definitions in the DPDK header file rte_bitops.h
>
> [cid:image001.png@01DCAD92.9C6111F0]
>
>   1.  =93template with C linkage=94 error in the DPDK header file rte_cry=
ptodev.h
>
> To proceed with our CU compilation, we applied the required fixes in the =
respective DPDK include files and generated a patch named dpdk-24.11_patch_=
for_crypto.patch. The updated changes are included in the attached patch fi=
le for your review.
>
> Could you please review these changes from the DPDK side and confirm whet=
her they are acceptable, or advise on the correct fix if modifications are =
required?
>
> Thanks & Regards,
> Reema Sharma
>






--_000_DS0PR08MB946527D1CFA667062588E491863F2DS0PR08MB9465namp_
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
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Hi <a href=3D"mailto:thomas@monjalon.net" id=3D"OWAAM249121" class=3D"x_tWK=
Ou x_mention x_ms-bgc-nlr x_ms-fcl-b">
Thomas Monjalon</a>&nbsp;and Team,</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
I hope you are doing well.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
I wanted to follow up on my earlier request regarding the review of the fix=
 for the DPDK 24.11 and 25.11 compilation issues, which was expected to be =
available in a future DPDK release.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSer=
vice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);=
">
Could you please confirm when the fix is likely to be available and in whic=
h upcoming release, we can expect it?</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Reema Sharma</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div id=3D"x_divRplyFwdMsg" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Reema Sharma &lt;Reema.Sharma@radisys.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, March 26, 2026 2:16 PM<br>
<b>To:</b>&nbsp;Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; gakhil@marvell.com &lt;g=
akhil@marvell.com&gt;; david.marchand@redhat.com &lt;david.marchand@redhat.=
com&gt;; stephen@networkplumber.org &lt;stephen@networkplumber.org&gt;; ana=
toly.burakov@intel.com &lt;anatoly.burakov@intel.com&gt;; jack.bond-preston=
@foss.arm.com
 &lt;jack.bond-preston@foss.arm.com&gt;; gakhil@marvell.com &lt;gakhil@marv=
ell.com&gt;; fanzhang.oss@gmail.com &lt;fanzhang.oss@gmail.com&gt;; kai.ji@=
intel.com &lt;kai.ji@intel.com&gt;; Prakash Durgapal &lt;Prakash.Durgapal@r=
adisys.com&gt;; Pratap Rana &lt;Pratap.Rana@radisys.com&gt;; Vijay Kumar
 Mahto &lt;Vijay.Mahto@radisys.com&gt;; Jaydipkumar Dhameliya &lt;Jaydipkum=
ar.Dhameliya@radisys.com&gt;; Liu1, Kai &lt;kai.liu1@intel.com&gt;; Zhang, =
Liheng &lt;liheng.zhang@intel.com&gt;; Xiong, Tanghong &lt;tanghong.xiong@i=
ntel.com&gt;; Mattias R=F6nnblom &lt;mattias.ronnblom@ericsson.com&gt;<br>
<b>Subject:</b>&nbsp;Re: Request for Review of Fixes Applied for DPDK 24.11=
 and 25.11 Compilation Errors</div>
<div class=3D"elementToProof" style=3D"direction: ltr;">&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
Hi <a href=3D"mailto:thomas@monjalon.net" id=3D"OWAAM141401" class=3D"x_x_t=
WKOu x_x_mention x_x_ms-bgc-nlr x_x_ms-fcl-b">
Thomas Monjalon</a>,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
Thanks for the quick response.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
Yes, you understood correctly. I encountered two issues while compiling a C=
++ application(Radisys CU module) linked with DPDK.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
<b>Compiler Version: </b>gcc version 11.4.0&nbsp; (ubuntu&nbsp; 22.04.3)</d=
iv>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
<b>Regarding </b><code><b>rte_bitops.h</b></code><b>:</b><br>
Disabling the macros works for my current use case, so I can proceed with t=
hat approach for now.<br>
I agree that the behaviour of the <code>__RTE_BIT_OVERLOAD</code>&nbsp;macr=
os needs further analysis, It will be great if fix for this will be availab=
le in next DPDK release. Please find the error details for your reference:<=
/div>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
dpdk/dpdk-25.11/x86_64-native-linuxapp-gcc/include/rte_bitops.h:1468:1: err=
or: conflicting declaration of C function =91bool rte_bit_test(const volati=
le uint32_t*, unsigned int)=92</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;1468 | rte_bit_ ## family ## fun(qualifier uint ## size ## _t *addr, =
arg1_type arg1_name) \</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; | ^~~~~~~~</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
dpdk/dpdk-25.11/x86_64-native-linuxapp-gcc/include/rte_bitops.h:1468:1: not=
e: in definition of macro =91__RTE_BIT_OVERLOAD_V_2R=92</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;1468 | rte_bit_ ## family ## fun(qualifier uint ## size ## _t *addr, =
arg1_type arg1_name) \</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; | ^~~~~~~~</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
dpdk/dpdk-25.11/x86_64-native-linuxapp-gcc/include/rte_bitops.h:1479:9: not=
e: in expansion of macro =91__RTE_BIT_OVERLOAD_SZ_2R=92</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;1479 | &nbsp; &nbsp; &nbsp; &nbsp; __RTE_BIT_OVERLOAD_SZ_2R(family, f=
un, qualifier, 32, ret_type, arg1_type, arg1_name) \</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; ^~~~~~~~~~~~~~~~~~~~~~~~=
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
<b>Regarding </b><code><b>rte_cryptodev.h</b></code><b>:</b><br>
This issue is not observed with DPDK 25.11. Please disregard the earlier re=
port.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div class=3D"elementToProof" style=3D"direction: ltr; line-height: 20px; m=
argin-top: 1em; margin-bottom: 1em; font-family: Aptos, Aptos_EmbeddedFont,=
 Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; colo=
r: rgb(0, 0, 0);">
Reema Sharma</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, March 25, 2026 1:47 PM<br>
<b>To:</b>&nbsp;Reema Sharma &lt;Reema.Sharma@radisys.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; gakhil@marvell.com &lt;g=
akhil@marvell.com&gt;; david.marchand@redhat.com &lt;david.marchand@redhat.=
com&gt;; stephen@networkplumber.org &lt;stephen@networkplumber.org&gt;; ana=
toly.burakov@intel.com &lt;anatoly.burakov@intel.com&gt;; jack.bond-preston=
@foss.arm.com
 &lt;jack.bond-preston@foss.arm.com&gt;; gakhil@marvell.com &lt;gakhil@marv=
ell.com&gt;; fanzhang.oss@gmail.com &lt;fanzhang.oss@gmail.com&gt;; kai.ji@=
intel.com &lt;kai.ji@intel.com&gt;; Prakash Durgapal &lt;Prakash.Durgapal@r=
adisys.com&gt;; Pratap Rana &lt;Pratap.Rana@radisys.com&gt;; Vijay Kumar
 Mahto &lt;Vijay.Mahto@radisys.com&gt;; Jaydipkumar Dhameliya &lt;Jaydipkum=
ar.Dhameliya@radisys.com&gt;; Liu1, Kai &lt;kai.liu1@intel.com&gt;; Zhang, =
Liheng &lt;liheng.zhang@intel.com&gt;; Xiong, Tanghong &lt;tanghong.xiong@i=
ntel.com&gt;; Mattias R=F6nnblom &lt;mattias.ronnblom@ericsson.com&gt;<br>
<b>Subject:</b>&nbsp;Re: Request for Review of Fixes Applied for DPDK 24.11=
 and 25.11 Compilation Errors</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Calibri=
, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; font-size: 11pt;">He=
llo,<br>
<br>
If I understand well, you hit 2 issues while compiling a C++ app linked wit=
h DPDK?<br>
Could you share the exact version of your compiler?<br>
<br>
For rte_bitops.h, if disabling these macros is OK for you, go with it for n=
ow.<br>
We will need to understand what happens exactly with __RTE_BIT_OVERLOAD mac=
ros.<br>
<br>
For rte_cryptodev.h, it may be hiding an issue somewhere else.<br>
Please could you share the exact error message?<br>
<br>
<br>
<br>
25/03/2026 07:55, Reema Sharma:<br>
&gt; Hi Team,<br>
&gt;<br>
&gt; Could you please review the attached DPDK patch (dpdk-24.11_patch_for_=
crypto.patch) and confirm whether the applied fixes are acceptable from the=
 DPDK perspective?<br>
&gt; Your guidance on the correct fix, if any changes are needed, would hel=
p us proceed with CU compilation.<br>
&gt; Kindly share an update at your earliest convenience.<br>
&gt; Thanks &amp; Regards,<br>
&gt; Reema Sharma<br>
&gt; ________________________________<br>
&gt; From: Xiong, Tanghong &lt;tanghong.xiong@intel.com&gt;<br>
&gt; Sent: Friday, March 6, 2026 3:26 PM<br>
&gt; To: Zhang, Liheng &lt;liheng.zhang@intel.com&gt;; Reema Sharma &lt;Ree=
ma.Sharma@radisys.com&gt;; Liu1, Kai &lt;kai.liu1@intel.com&gt;<br>
&gt; Cc: Prakash Durgapal &lt;Prakash.Durgapal@radisys.com&gt;; Pratap Rana=
 &lt;Pratap.Rana@radisys.com&gt;; Vijay Kumar Mahto &lt;Vijay.Mahto@radisys=
.com&gt;; Jaydipkumar Dhameliya &lt;Jaydipkumar.Dhameliya@radisys.com&gt;<b=
r>
&gt; Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25=
.11 Compilation Errors<br>
&gt;<br>
&gt;<br>
&gt; Thanks Liheng,<br>
&gt;<br>
&gt; Just got other info that, you can contact&nbsp; DPDK directly through =
this mail: dev@dpdk.org&lt;<a href=3D"mailto:dev@dpdk.org" id=3D"OWA064d7e4=
c-1917-269a-263a-55f49fa3f96d" class=3D"x_x_OWAAutoLink">mailto:dev@dpdk.or=
g</a>&gt;, but the response may be slow.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; BRs,<br>
&gt;<br>
&gt; Tanghong<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: Zhang, Liheng &lt;liheng.zhang@intel.com&gt;<br>
&gt; Sent: Friday, March 6, 2026 5:51 PM<br>
&gt; To: Reema Sharma &lt;Reema.Sharma@radisys.com&gt;; Xiong, Tanghong &lt=
;tanghong.xiong@intel.com&gt;; Liu1, Kai &lt;kai.liu1@intel.com&gt;<br>
&gt; Cc: Durgapal, Prakash &lt;prakash.durgapal@radisys.com&gt;; Pratap Ran=
a &lt;Pratap.Rana@radisys.com&gt;; Vijay Kumar Mahto &lt;Vijay.Mahto@radisy=
s.com&gt;; Jaydipkumar Dhameliya &lt;Jaydipkumar.Dhameliya@radisys.com&gt;<=
br>
&gt; Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25=
.11 Compilation Errors<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Yes, there is a file =93MAINTAINERS=94 in the DPDK root path.<br>
&gt;<br>
&gt; The file list all the contactor for all dpdk libraries.<br>
&gt;<br>
&gt; You can search and contact the person for crypto issue.<br>
&gt;<br>
&gt; If you can=92t find it, please let me know, I can forward to you.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: Reema Sharma &lt;Reema.Sharma@radisys.com&lt;mailto:Reema.Sharma=
@radisys.com&gt;&gt;<br>
&gt; Sent: Friday, March 6, 2026 5:45 PM<br>
&gt; To: Zhang, Liheng &lt;liheng.zhang@intel.com&lt;mailto:liheng.zhang@in=
tel.com&gt;&gt;; Xiong, Tanghong &lt;tanghong.xiong@intel.com&lt;mailto:tan=
ghong.xiong@intel.com&gt;&gt;; Liu1, Kai &lt;kai.liu1@intel.com&lt;mailto:k=
ai.liu1@intel.com&gt;&gt;<br>
&gt; Cc: Durgapal, Prakash &lt;prakash.durgapal@radisys.com&lt;mailto:praka=
sh.durgapal@radisys.com&gt;&gt;; Pratap Rana &lt;Pratap.Rana@radisys.com&lt=
;mailto:Pratap.Rana@radisys.com&gt;&gt;; Vijay Kumar Mahto &lt;Vijay.Mahto@=
radisys.com&lt;mailto:Vijay.Mahto@radisys.com&gt;&gt;; Jaydipkumar Dhameliy=
a
 &lt;Jaydipkumar.Dhameliya@radisys.com&lt;mailto:Jaydipkumar.Dhameliya@radi=
sys.com&gt;&gt;<br>
&gt; Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25=
.11 Compilation Errors<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Zhang, Liheng&lt;<a href=3D"mailto:liheng.zhang@intel.com" id=3D"OW=
A32f2243d-70d3-70df-9dc2-709ab965e29f" class=3D"x_x_OWAAutoLink">mailto:lih=
eng.zhang@intel.com</a>&gt;,<br>
&gt;<br>
&gt; We have verified the behaviour on CU side and confirmed that this is n=
ot caused by our code. The issue appears to be related to a DPDK bug.<br>
&gt;<br>
&gt; At the moment, we do not have any contact information for the DPDK mai=
ntainers.<br>
&gt; Could you please check internally and share the relevant maintainer de=
tails or forward this issue on behalf of Radisys?<br>
&gt;<br>
&gt; Thanks &amp; Regards,<br>
&gt;<br>
&gt; Reema Sharma<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Zhang, Liheng &lt;liheng.zhang@intel.com&lt;mailto:liheng.zhang@=
intel.com&gt;&gt;<br>
&gt; Sent: Friday, March 6, 2026 2:49 PM<br>
&gt; To: Xiong, Tanghong &lt;tanghong.xiong@intel.com&lt;mailto:tanghong.xi=
ong@intel.com&gt;&gt;; Reema Sharma &lt;Reema.Sharma@radisys.com&lt;mailto:=
Reema.Sharma@radisys.com&gt;&gt;; Liu1, Kai &lt;kai.liu1@intel.com&lt;mailt=
o:kai.liu1@intel.com&gt;&gt;<br>
&gt; Cc: Prakash Durgapal &lt;Prakash.Durgapal@radisys.com&lt;mailto:Prakas=
h.Durgapal@radisys.com&gt;&gt;; Pratap Rana &lt;Pratap.Rana@radisys.com&lt;=
mailto:Pratap.Rana@radisys.com&gt;&gt;; Vijay Kumar Mahto &lt;Vijay.Mahto@r=
adisys.com&lt;mailto:Vijay.Mahto@radisys.com&gt;&gt;; Jaydipkumar Dhameliya
 &lt;Jaydipkumar.Dhameliya@radisys.com&lt;mailto:Jaydipkumar.Dhameliya@radi=
sys.com&gt;&gt;<br>
&gt; Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25=
.11 Compilation Errors<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; The e-mail below is from an external source. Please do not open attach=
ments or click links from an unknown or suspicious origin.<br>
&gt;<br>
&gt; Hi Reema<br>
&gt;<br>
&gt; Looks the changes are ok, but you need verify them by compiling your c=
ode.<br>
&gt;<br>
&gt; As I know, the following are the better procedures for DPDK bug fix:<b=
r>
&gt;<br>
&gt;&nbsp;&nbsp; 1.&nbsp; Please first confirm the error are not related to=
 your own code before changing DPDK code;<br>
&gt;&nbsp;&nbsp; 2.&nbsp; If it is real DPDK bug, you need contact the acco=
rding DPDK maintainer to fix it;<br>
&gt;&nbsp;&nbsp; 3.&nbsp; Finally DPDK maintainer will provide an official =
patch;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: Xiong, Tanghong &lt;tanghong.xiong@intel.com&lt;mailto:tanghong.=
xiong@intel.com&gt;&gt;<br>
&gt; Sent: Friday, March 6, 2026 3:52 PM<br>
&gt; To: Reema Sharma &lt;Reema.Sharma@radisys.com&lt;mailto:Reema.Sharma@r=
adisys.com&gt;&gt;; Liu1, Kai &lt;kai.liu1@intel.com&lt;mailto:kai.liu1@int=
el.com&gt;&gt;; Zhang, Liheng &lt;liheng.zhang@intel.com&lt;mailto:liheng.z=
hang@intel.com&gt;&gt;<br>
&gt; Cc: Durgapal, Prakash &lt;prakash.durgapal@radisys.com&lt;mailto:praka=
sh.durgapal@radisys.com&gt;&gt;; Pratap Rana &lt;Pratap.Rana@radisys.com&lt=
;mailto:Pratap.Rana@radisys.com&gt;&gt;; Vijay Kumar Mahto &lt;Vijay.Mahto@=
radisys.com&lt;mailto:Vijay.Mahto@radisys.com&gt;&gt;; Jaydipkumar Dhameliy=
a
 &lt;Jaydipkumar.Dhameliya@radisys.com&lt;mailto:Jaydipkumar.Dhameliya@radi=
sys.com&gt;&gt;<br>
&gt; Subject: RE: Request for Review of Fixes Applied for DPDK 24.11 and 25=
.11 Compilation Errors<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hello Reema,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Sorry for late reply, copy @Zhang, Liheng&lt;<a href=3D"mailto:liheng.=
zhang@intel.com" id=3D"OWA4e660360-51e5-a932-9996-7e19cd04ac34" class=3D"x_=
x_OWAAutoLink">mailto:liheng.zhang@intel.com</a>&gt; here for comment, than=
ks Liheng in advance.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; BRs,<br>
&gt;<br>
&gt; Tanghong<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; From: Reema Sharma &lt;Reema.Sharma@radisys.com&lt;mailto:Reema.Sharma=
@radisys.com&gt;&gt;<br>
&gt; Sent: Friday, March 6, 2026 1:41 PM<br>
&gt; To: Xiong, Tanghong &lt;tanghong.xiong@intel.com&lt;mailto:tanghong.xi=
ong@intel.com&gt;&gt;; Liu1, Kai &lt;kai.liu1@intel.com&lt;mailto:kai.liu1@=
intel.com&gt;&gt;<br>
&gt; Cc: Durgapal, Prakash &lt;prakash.durgapal@radisys.com&lt;mailto:praka=
sh.durgapal@radisys.com&gt;&gt;; Pratap Rana &lt;Pratap.Rana@radisys.com&lt=
;mailto:Pratap.Rana@radisys.com&gt;&gt;; Vijay Kumar Mahto &lt;Vijay.Mahto@=
radisys.com&lt;mailto:Vijay.Mahto@radisys.com&gt;&gt;; Jaydipkumar Dhameliy=
a
 &lt;Jaydipkumar.Dhameliya@radisys.com&lt;mailto:Jaydipkumar.Dhameliya@radi=
sys.com&gt;&gt;<br>
&gt; Subject: Re: Request for Review of Fixes Applied for DPDK 24.11 and 25=
.11 Compilation Errors<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Xiong, Tanghong&lt;<a href=3D"mailto:tanghong.xiong@intel.com" id=
=3D"OWA5546813b-16ab-5eee-1e68-a2d1526fd823" class=3D"x_x_OWAAutoLink">mail=
to:tanghong.xiong@intel.com</a>&gt;/ Liu1, Kai&lt;<a href=3D"mailto:kai.liu=
1@intel.com" id=3D"OWA47342f7e-3499-54e9-e263-a06d84425467" class=3D"x_x_OW=
AAutoLink">mailto:kai.liu1@intel.com</a>&gt;,<br>
&gt;<br>
&gt; Hope you are doing well.<br>
&gt;<br>
&gt; I am writing to check if there is any update on the pending DPDK issue=
 raised in this mail.<br>
&gt; Could you please share the latest status, or let me know if any additi=
onal inputs are required from my side to help move this forward?<br>
&gt;<br>
&gt; Looking forward to your response.<br>
&gt;<br>
&gt; Thanks &amp; Regards,<br>
&gt;<br>
&gt; Reema Sharma<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Reema Sharma<br>
&gt; Sent: Wednesday, February 11, 2026 11:27 AM<br>
&gt; To: Xiong, Tanghong &lt;tanghong.xiong@intel.com&lt;mailto:tanghong.xi=
ong@intel.com&gt;&gt;; Liu1, Kai &lt;kai.liu1@intel.com&lt;mailto:kai.liu1@=
intel.com&gt;&gt;<br>
&gt; Cc: Prakash Durgapal &lt;Prakash.Durgapal@radisys.com&lt;mailto:Prakas=
h.Durgapal@radisys.com&gt;&gt;; Pratap Rana &lt;Pratap.Rana@radisys.com&lt;=
mailto:Pratap.Rana@radisys.com&gt;&gt;; Vijay Kumar Mahto &lt;Vijay.Mahto@r=
adisys.com&lt;mailto:Vijay.Mahto@radisys.com&gt;&gt;; Jaydipkumar Dhameliya
 &lt;Jaydipkumar.Dhameliya@radisys.com&lt;mailto:Jaydipkumar.Dhameliya@radi=
sys.com&gt;&gt;<br>
&gt; Subject: Request for Review of Fixes Applied for DPDK 24.11 and 25.11 =
Compilation Errors<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Xiong, Tanghong&lt;<a href=3D"mailto:tanghong.xiong@intel.com" id=
=3D"OWA7c5507a7-9cf6-cdf1-aef7-bcc3c5ee1fa6" class=3D"x_x_OWAAutoLink">mail=
to:tanghong.xiong@intel.com</a>&gt;/ Liu1, Kai&lt;<a href=3D"mailto:kai.liu=
1@intel.com" id=3D"OWA7ded1914-e6a5-2ee9-68f1-dca1595780c8" class=3D"x_x_OW=
AAutoLink">mailto:kai.liu1@intel.com</a>&gt;,<br>
&gt;<br>
&gt; While compiling the CU with DPDK 24.11 and DPDK 25.11, we encountered =
the following two errors:<br>
&gt;<br>
&gt;&nbsp;&nbsp; 1.&nbsp; Conflicting type definitions in the DPDK header f=
ile rte_bitops.h<br>
&gt;<br>
&gt; [cid:image001.png@01DCAD92.9C6111F0]<br>
&gt;<br>
&gt;&nbsp;&nbsp; 1.&nbsp; =93template with C linkage=94 error in the DPDK h=
eader file rte_cryptodev.h<br>
&gt;<br>
&gt; To proceed with our CU compilation, we applied the required fixes in t=
he respective DPDK include files and generated a patch named dpdk-24.11_pat=
ch_for_crypto.patch. The updated changes are included in the attached patch=
 file for your review.<br>
&gt;<br>
&gt; Could you please review these changes from the DPDK side and confirm w=
hether they are acceptable, or advise on the correct fix if modifications a=
re required?<br>
&gt;<br>
&gt; Thanks &amp; Regards,<br>
&gt; Reema Sharma<br>
&gt;<br>
<br>
<br>
<br>
<br>
<br>
</div>
</body>
</html>

--_000_DS0PR08MB946527D1CFA667062588E491863F2DS0PR08MB9465namp_--
