Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC12FEDA68E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:43:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D777C402AA;
	Tue,  3 Mar 2026 16:42:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8F8A940268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 16:42:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772552578; x=1804088578;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=VwIZuIdzlOqsA4pJ7i+apG4MPaBd+PV/ee9udLvmmPQ=;
 b=SOeYcr7+d9ZyiiTWXuyHNBPf3JF6ExDasXLtH/A9qo9AxW5Dz40LQSMi
 iEVRGJHd8EnNA8RcsATG8BtMTob998gz5z5XVQUecwrtK3swZYXzbSC/d
 awaPkL/jCZ2NSjAluEnjujX2oNHPc5QS59dH2f43JeE3Qo5yeYCA81OKg
 Mu3gfTh0Zsi613RdqvixnzRWTXLwV7niHVRK0cn/M6SidTBFa2LPm6FCf
 0Hi2pfaeKrvy5B2ATGmopqdFIMBNQ/Ee8Lg7Uv6ECqbwZfzBjTZn7VZSi
 8dvX3n0TxUQ9ZQgpKMBmlgOJBYKTj43QzrnG2asufSiUlOnKynWnMYADL g==;
X-CSE-ConnectionGUID: LNDdlUG1RXemi9OI4MP5gg==
X-CSE-MsgGUID: Rmwwb20HRRKA/MT4zJ+Wkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="85061679"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208,217";a="85061679"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 07:42:56 -0800
X-CSE-ConnectionGUID: WWFZWGtWR52sqoaQ5y8qJg==
X-CSE-MsgGUID: mSchX0ZZTXOBeyYY3cPtrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
 d="scan'208,217";a="222519977"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 07:42:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:42:56 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 07:42:56 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 07:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USCqm2ZghQusImD1m+oBQFWIbv0MlLtIuJryEB+tCBBc97yxL8i/b52XtmPZ0O3QzeRkFSGVDzLJFh9be1OOTOghd1rJX/lpCc6OCfEu/vkpu2rXlEOwYEV9XC+lLXwNn1Os/396ClUOmSjnTUfE944F1AkOe0K3SfYe27rNL6gh4aK6AtnftmNWG8W21oV0NVcQH3WSdLimCam/6lEqTUGq3XETkVm45+WDYRhzn857KfntAvop0+W05qYi/SH2JFXVPl3LRmkxloR+AXHnnTPOjkr1EdXIKhqSDy1b5wYzvWsTCP1bdt6/YGQh7jyfoIhiYAZ/kbqTz9p9U2eD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBD+KOc+ilUCt+j30FO1Yyh3PeBV4mqoL1O7ooi5O9U=;
 b=ARhfBSPxKs+CgLc521AoTLhRo+30XQAzDrtJJsBD71yuvs7RjNo4P9ZecOvvc+MQq+ydMrsSDx+auJaFzpqXY7FBfEyo9/jAaYINKrBVG9tcw0MT/re/GMIOjw9iybmVadA17eDL+QJi51OnxRHZ2MPCM09r5QwS1/+yIPWxd6BvXhZx17OxFmrpHuusPtbYm7+wWbgi845zVcyIyp88ERvBqcv2W4tFmDoV6mPQhNUjfBGjj7DlbRytkkyeXQiFrtfcYVOHL8BrUOBfmIoye9zeHOJUOLy1sqOjnUdYO7OVrs9yRH3NH7B7OrmR4JWv4IgvJGBdkg98/04jysnuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:42:50 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:42:50 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Anoob Joseph <anoobj@marvell.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>, Andrew Boyer
 <andrew.boyer@amd.com>, Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>, "De Lara Guarch, Pablo"
 <pablo.de.lara.guarch@intel.com>, Nagadheeraj Rottela
 <rnagadheeraj@marvell.com>, Matan Azrad <matan@nvidia.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: Re: [EXTERNAL] [PATCH] doc: deprecation of OpenSSL version 1.1.1
Thread-Topic: [EXTERNAL] [PATCH] doc: deprecation of OpenSSL version 1.1.1
Thread-Index: AQHcm1Cu7WIH6RNv6UmSywpuF88FCbWHADGAgBYR1HQ=
Date: Tue, 3 Mar 2026 15:42:50 +0000
Message-ID: <DS0PR11MB7458F999FE36857667389AFE817FA@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20260211121916.2598788-1-emma.finn@intel.com>
 <CO6PR18MB4484DB317E6B27712F68EC2BD86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484DB317E6B27712F68EC2BD86DA@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|CY8PR11MB7107:EE_
x-ms-office365-filtering-correlation-id: 730f3e50-6883-48b1-d4e7-08de793b86c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|42112799006|1800799024|7053199007|38070700021|8096899003;
x-microsoft-antispam-message-info: gwMTXcP1HrdIX2ijp63z0TT0bHZnJzklxYZypjVTB060se9m6UHoev1BRXBct2ljIH/Zl7rxneCbImgUK/uo+jfJ7BDLkNDVBsGPp2s6EpfX9p5LBiKU88r6iux8gj9cYGn4LAEjDOaAq0IkrEvDdy/WNQMGBaKoiRHaRhrS4oMhp4Pe4694glp/71B3a2adAcIi3fDQp/NPQEXvixXbPlSIPtJyLAlW6kMrfmi3CBBA18BYAMzA+7yiH73D/GiAKaRUchl5Wy16JNDAHIpUHQMU2PIbWgqPVFDCp+FUBTWT/z2bB0LE79//AUUOYZzvbbTylxbepuoSvSZPtVN4mTpYzS0amPghx7xGPv2YREON02ukx2U6W7TFYADuU9+HYZ6emdUTB6L++grCVb6Q06TX6aLXVHE7PXRgCIylXqCrWP+YMcX6xGEo58zjEupdmt+SjlSeVVMg1LyrhrEBzL0hBl0f/9pVcwgkbXfnirNtXQDSF1Qz/KAlzI3J50lxFH85UtkX+brxKzD3mSVsHNpF7Sidfm45iPg5ErD6xeLDkH1vDToI+uVLQmGT0SYYH04LichkkP/vK1RzHiJSLl1l5NJ+YjKcbpc4yxbI2tEGtSa2oGcNaoYTOjNKAj/qRS/wxkhzzgQN4KUXOWnG3fK2ZgGaiexLu2ocpsD4dDqImuGauRwBJQ0PC8ijeOCcr2yykrFN6c8Q7rITJgYVFfhHyYSTQR3c9eJZOaaXThWwcM4voS/ugrZNFz0LvOFmiO5Wm3Atj+rEpUlopMtLn19wcgCYUjLL2U5eflH6vgU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(42112799006)(1800799024)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?helnSG2zyh2hkbDTGYZr4qKMUsztfaAAZEeVJ//MoomGexqA7bmpeFkV10/+?=
 =?us-ascii?Q?q+P70EF9rm3YjsJrl5+6I7JBrsJz4BJ5J/IPyiClMbp6B35ab26qMDfaFUFf?=
 =?us-ascii?Q?dcZoDtzmj9O5GzeulS5bsa9btK9NgqAXNsVMIuXafr4IgD6zZ99JgslbSxOZ?=
 =?us-ascii?Q?PiOfJNep0Prnjs04+5qrQdMdo+xXskhcVsL73ZG1qMt5c6NEfEQlcoMf0lVl?=
 =?us-ascii?Q?Zd6u0izdvmnKS4KvW7mezTdxh9MeeztoGG7R9r1YY+PmnjWRSohSxrRelYaM?=
 =?us-ascii?Q?rVAZRxwBSPS4vM09uiJqPx6AWvXehVEYPESo9nsETx+QpdkNGv9JkI8Pe/jb?=
 =?us-ascii?Q?wC63HInL+jB31jy0aohKBPuGO42+FxkSLM5Y/KcuCmV4qkBozB/+mCTkWDhJ?=
 =?us-ascii?Q?yb/aD3ZWw8UHnq7IUiJUF3LRBiznlcRAPeAe9lluqea8ALs/HhT2lz0ywT12?=
 =?us-ascii?Q?/ewnt6ABPamsWGc7n9opy0a1Kv9PUYopjRyu2kvLgzVlCVFybJ9b010XiEGM?=
 =?us-ascii?Q?dHoM+AFf5Ue+rQzQSaCmDeX4zhHwUJ4tp7tFdF8pZc+81nLhnGuT294/s0v6?=
 =?us-ascii?Q?CmojS89jVNtGaKRrDTEc2Lr207f0vuJBB12+RIrgX5geDEpkqqVs1kpYqZlg?=
 =?us-ascii?Q?bseHZaSmbnzbk+2L9igNPCdefkj2PiRjQGfcFgifWWA4J0hUMwWTXldHoCio?=
 =?us-ascii?Q?4tktUToZ0U/ffFSREF30tIwrGaTDW831v8clhJ4z7w52sAJU4j28BvkPUv2l?=
 =?us-ascii?Q?Dst0epOrBzp9lvcms1HkP6TtBqQPyCY2rq+I0w2jHxCnuHkrfRBhlSOvYQWO?=
 =?us-ascii?Q?ix6lHmAjd1IAhfRVbnWIdTzdraN3/Bx4iNZ4In89wjVtuoGK10B0sOD6rQYa?=
 =?us-ascii?Q?t/c8iG251DYa3JAJ0bIlgR6wTfJX62Gmrn/otvjGmBHnUjE0wraFOc0uOwdQ?=
 =?us-ascii?Q?lAE+xINGwpAnVS2VjBByQ8EifU86EULn1qoceOA3sLtG9vefqRaHzdVfVrqw?=
 =?us-ascii?Q?QaRikKa2kP1+1WIb7Jyv/1LUoPwbIMaxOfIDk5z8LVZWGrH7wvbZpGBib+Jg?=
 =?us-ascii?Q?Tan7tSPRO1IFeQyRTE2tTAkoQLyqlN/2+XJ9ByjLJ5FooxMuZiwa9P81/QVr?=
 =?us-ascii?Q?W/kLOFbcBKKJGNw+HVHvEk7XMKVDkIqoGa0njKBfi8HG8ynqaAYuEr3G1HoK?=
 =?us-ascii?Q?ChB+cF3fab/61SZx1Qqjrwe71r/iA8h1tkBA9M8YN9Yf8QieJq3UBR2OnzMg?=
 =?us-ascii?Q?jmEhpMkyBy2qudvQRADdJ5NUaGYialzbhNBdMbDKxQqfo7ncG7Ad6FEx963y?=
 =?us-ascii?Q?prp96emN0wE5G/49OAfTkeeO2mP+WlHA0ALzfe/Za18tkbw+IQLpa746FMY0?=
 =?us-ascii?Q?9mMK7ssbRJfA3hRKrghYwZXGQYqj75ua7KEIuHjuYiPBNbSjAW3szYQJ2vkp?=
 =?us-ascii?Q?Y8LJCiHFYg05AFSbjr9/dUdYX2kFQb8R4HxWJ3mRGbmcCA0b4f5oJtUBz1i9?=
 =?us-ascii?Q?jv+jwgLLjAkdgJh8Q3qE8mEFxGia6mSeJNhRzsBtEj60Rw7zcaWaXdvt74Q1?=
 =?us-ascii?Q?0+Qe7XRgbL1bj+Xc+a9IXTi5l4/kUJxdyp0AHR1Av6/Tta1SYYc68LJK9tVp?=
 =?us-ascii?Q?s59sgG3tahiiRkp5ilQQe0kl3Me+O8YEa2WvYRbLeHvXhk4GF+HL86bDXuBq?=
 =?us-ascii?Q?8TKTtW6b69vHu2er9/FIF81YIjB+I7p19GYOYgoqsrBzpgp2?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458F999FE36857667389AFE817FADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730f3e50-6883-48b1-d4e7-08de793b86c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 15:42:50.3842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZA6cQIMdSrMSFXH+dEvjTCk+GGN7TDJIT2wRDBQU17Jaf9VGAOEwhxnCASVgZ4m5DdmS5XnUeHv1np6pTz5y0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com
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

--_000_DS0PR11MB7458F999FE36857667389AFE817FADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>
________________________________
From: Akhil Goyal <gakhil@marvell.com>
Sent: 17 February 2026 14:40
To: Finn, Emma <emma.finn@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Ji, Kai <kai.ji@intel.com>; Hemant Agrawal=
 <hemant.agrawal@nxp.com>; Anoob Joseph <anoobj@marvell.com>; Raslan Daraws=
heh <rasland@nvidia.com>; Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>=
; Andrew Boyer <andrew.boyer@amd.com>; Jack Bond-Preston <jack.bond-preston=
@foss.arm.com>; Vikas Gupta <vikas.gupta@broadcom.com>; De Lara Guarch, Pab=
lo <pablo.de.lara.guarch@intel.com>; Nagadheeraj Rottela <rnagadheeraj@marv=
ell.com>; Matan Azrad <matan@nvidia.com>; Jay Zhou <jianjay.zhou@huawei.com=
>; Hanxiao Li <li.hanxiao@zte.com.cn>
Subject: RE: [EXTERNAL] [PATCH] doc: deprecation of OpenSSL version 1.1.1

> OpenSSL 1.1.1 reached end-of-life in September 2023. Future
> releases of DPDK will require minimum of OpenSSL 3.0.
>
> Signed-off-by: Emma Finn <emma.finn@intel.com>
> ---
Acked-by: Akhil Goyal <gakhil@marvell.com>
Adding more PMD maintainers for acks.

>  doc/guides/rel_notes/deprecation.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/doc/guides/rel_notes/deprecation.rst
> b/doc/guides/rel_notes/deprecation.rst
> index ac667e91a6..fca556d07b 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -20,6 +20,11 @@ Deprecation Notices
>  * kvargs: The function ``rte_kvargs_process`` will get a new parameter
>    for returning key match count. It will ease handling of no-match case.
>
> +* cryptodev: Support for OpenSSL versions earlier than 3.0 is deprecated
> +  and will be removed. OpenSSL 1.1.1 reached end-of-life in September 20=
23.
> +  The minimum supported OpenSSL version will be 3.0,
> +  and version checks for earlier OpenSSL versions will be removed from t=
he PMD.
> +
>  * eal: The ``-c <coremask>`` commandline parameter is deprecated
>    and will be removed in a future release.
>    Use the ``-l <corelist>`` or ``--lcores=3D<corelist>`` parameters inst=
ead
> --
> 2.43.0


--_000_DS0PR11MB7458F999FE36857667389AFE817FADS0PR11MB7458namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Akhil Goyal &lt;gakhi=
l@marvell.com&gt;<br>
<b>Sent:</b> 17 February 2026 14:40<br>
<b>To:</b> Finn, Emma &lt;emma.finn@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&=
gt;; Hemant Agrawal &lt;hemant.agrawal@nxp.com&gt;; Anoob Joseph &lt;anoobj=
@marvell.com&gt;; Raslan Darawsheh &lt;rasland@nvidia.com&gt;; Sunil Uttarw=
ar &lt;sunilprakashrao.uttarwar@amd.com&gt;; Andrew Boyer &lt;andrew.boyer@=
amd.com&gt;;
 Jack Bond-Preston &lt;jack.bond-preston@foss.arm.com&gt;; Vikas Gupta &lt;=
vikas.gupta@broadcom.com&gt;; De Lara Guarch, Pablo &lt;pablo.de.lara.guarc=
h@intel.com&gt;; Nagadheeraj Rottela &lt;rnagadheeraj@marvell.com&gt;; Mata=
n Azrad &lt;matan@nvidia.com&gt;; Jay Zhou &lt;jianjay.zhou@huawei.com&gt;;
 Hanxiao Li &lt;li.hanxiao@zte.com.cn&gt;<br>
<b>Subject:</b> RE: [EXTERNAL] [PATCH] doc: deprecation of OpenSSL version =
1.1.1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">&gt; OpenSSL 1.1.1 reached end-of-life in Septembe=
r 2023. Future<br>
&gt; releases of DPDK will require minimum of OpenSSL 3.0.<br>
&gt; <br>
&gt; Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
&gt; ---<br>
Acked-by: Akhil Goyal &lt;gakhil@marvell.com&gt;<br>
Adding more PMD maintainers for acks.<br>
<br>
&gt;&nbsp; doc/guides/rel_notes/deprecation.rst | 5 +++++<br>
&gt;&nbsp; 1 file changed, 5 insertions(+)<br>
&gt; <br>
&gt; diff --git a/doc/guides/rel_notes/deprecation.rst<br>
&gt; b/doc/guides/rel_notes/deprecation.rst<br>
&gt; index ac667e91a6..fca556d07b 100644<br>
&gt; --- a/doc/guides/rel_notes/deprecation.rst<br>
&gt; +++ b/doc/guides/rel_notes/deprecation.rst<br>
&gt; @@ -20,6 +20,11 @@ Deprecation Notices<br>
&gt;&nbsp; * kvargs: The function ``rte_kvargs_process`` will get a new par=
ameter<br>
&gt;&nbsp;&nbsp;&nbsp; for returning key match count. It will ease handling=
 of no-match case.<br>
&gt; <br>
&gt; +* cryptodev: Support for OpenSSL versions earlier than 3.0 is depreca=
ted<br>
&gt; +&nbsp; and will be removed. OpenSSL 1.1.1 reached end-of-life in Sept=
ember 2023.<br>
&gt; +&nbsp; The minimum supported OpenSSL version will be 3.0,<br>
&gt; +&nbsp; and version checks for earlier OpenSSL versions will be remove=
d from the PMD.<br>
&gt; +<br>
&gt;&nbsp; * eal: The ``-c &lt;coremask&gt;`` commandline parameter is depr=
ecated<br>
&gt;&nbsp;&nbsp;&nbsp; and will be removed in a future release.<br>
&gt;&nbsp;&nbsp;&nbsp; Use the ``-l &lt;corelist&gt;`` or ``--lcores=3D&lt;=
corelist&gt;`` parameters instead<br>
&gt; --<br>
&gt; 2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458F999FE36857667389AFE817FADS0PR11MB7458namp_--
