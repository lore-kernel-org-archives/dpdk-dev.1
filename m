Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35397C44525
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2218A402A7;
	Mon, 20 Jul 2026 11:58:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 562C24028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 11:57:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784541480; x=1816077480;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=Vro8FJhv0y5dyOeIfSrsBnNRmmc1uRoqAj4pjBfaQcg=;
 b=YF0DUoALrjH1YaVPFk0ck4YDvKRkh+YInb0lEpKpZQ7kvdpyBvAk8FDo
 WftT51pIGRDkt9sNc9S4CSqCdX9v8Quu30RJm9came6Xg/evvMAf+govI
 5EEpzQTZ7IdFae6rcyCsOGJkvxP+ltDNRNVWmPEziTvh00D2i6P8N7zK1
 YlVaQd1qqjb5JUbeJTSkQBfizZjK2mpaOyVXPdIM7iQ/ePyTjWSkLlvr2
 cOoA7b+jaQKfSgC0uPpzX1Y+fo0pxWborGGYEbes4CK3gf9h9iMq8zt/p
 sTZyyGZLOK8G/ZJ3dtcAgv+tbdCTr8qAO00vJ71KbYL+cAFdBuHfjiCfY w==;
X-CSE-ConnectionGUID: FyYePzzCRO6qzO7T23QLhQ==
X-CSE-MsgGUID: AEOAqZXDREad1hIoYqznFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="95770101"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="95770101"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:57:58 -0700
X-CSE-ConnectionGUID: RQAMT4LfSymkkVCjbXkt5A==
X-CSE-MsgGUID: yU3LbMSSRYyke1hikDw4jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="254798099"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 02:57:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:57:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 02:57:57 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd0H8BUatfFIymONh9x09xcuMdKIwJ+ZJw9yE9l3Lzlsclk611MgJ22bL3EYNc6UUMi0Hi8S4G9p2eVh3wy+c10fNTbevjMPiPr9lPewlPoiAh8CsEIr8nm9q25YOT8VKcQhimfACpQYZR6BHmsNlH8WsWRRVVRI5nOANrKgEOQii3NzqUIeqyluM0KySRM1EpZ+fQ9Bm6l2+Vt/7wvEDUr1oN+eWFXvEvpLumUGPhMl1XNyKdFSZE4aqp7+E92KlgoqtuFiCurL1jCbJ9CsA7X97KHMdN8P/ld1YYyJpONMUrt1MMLV0bPF05q8Eo48pWI0nEWzgXH5U2CUGmhMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vro8FJhv0y5dyOeIfSrsBnNRmmc1uRoqAj4pjBfaQcg=;
 b=qg+ShUw0TKaiozxLUPpwvkJWeWQC0htdVI2MpwP2Bzf3iS5aE0z/Ky13GipJjHykHA59A9J4RwhdSp90k4kcTo4SHXK1G/suZuldcogN1Kf/o93i23/HOppU+KPC89J5ODqaTyNRxIVRpdISul17k8tK2BDyoDQBrIGE0h+gdJEWbby4Pifyy6z0M5exZBV++HLXBC3lZBDXLqU1SM7YAse/EZgurEn+ut2Jz6wYS3nTd4hz1afaR3T+9q7LBIwU6ZzyV3yj0OQWqoFxAAWBA3/J8oqvARZnoT0uai7frQmK8u0zJQ628myjTkltu+ShENfjpQgOs2txwj5EovTu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by IA1PR11MB8864.namprd11.prod.outlook.com (2603:10b6:208:597::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 09:57:53 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa%8]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:57:53 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dpdk <dev@dpdk.org>
CC: "Hosamani, Manjunathgouda" <manjunathgouda.hosamani@intel.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Mcnamara, John" <john.mcnamara@intel.com>
Subject: Recall: DPDK release candidate 26.07-rc3
Thread-Topic: DPDK release candidate 26.07-rc3
Thread-Index: AQHdGC470typ+QZQhkyApzYf7Nkg4g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 20 Jul 2026 09:57:53 +0000
Message-ID: <DS4PPF00BBED10C11A5B7271BE6BA1CDEBC9FC32@DS4PPF00BBED10C.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|IA1PR11MB8864:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c91e0d08-3074-405d-8914-08dee6455e15
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: 73tPMinA3+9yzIHhNuyvjEl7x3j+jWIFLziOvmoyZWIxT+in+k4civ2mxcw3mVZtQgwR3B13oPdKzSu06tgzrOmSx7c3SGzFjYQaBxSraT79jNFW61QnHcdDZO5WHzdp12i4u2w8XWbUK0i3ZHaV6Dk9+kBk9imkaxGL+GS8n9Q6jGS4ZIcPQh32qfz/G8crJthrzi7o423cwimBjHLcUgblMAMsTjvNK+q2Fcn6f2BvmT1KdoWivT7j7USUcl/6cHzc+t0w0YnvLfqm5LdYwZGJ6e45W+hQL51LiVqACKNgWXwOxyMpZEA5IF/h8dAOCKPHicIDpDadoXgLwH3SqJsZvZjEa0DAppqasEaLZnr0VcIkRWEOXI5m7iUUaYc7H2/wI/PXvtImlvTW83DrDRL7kQINi6KJw9ZvvCZh75YiToS0kxX9oJQMzH0tMUYftHZQV8kw1jE9BX3iGHnaiTABBU9eafO8At8R6kkfDsm9wOr0pqLiXPmxTEH9vT4pcjyXOPWZ3X5vaJhRcBSjvzf29yyF1PSfTegpCzD0sl9+8bMhvFr5+IivB2GVDQuh5dLu13e1xUhT/eU1snFOcUVUTs7OATXyzVNbsF3+S65OuRbsJPH3wg13CYgzVB3jdqwxtbqpERvVDRdcTJRp/Os2xtRKNK3k3QxkTYRIVBtdd9Pp3uX86/tPbrqW72M7ijoPzZYDbIqhfDvegnOZwPsTu79RR1dGLgEhleHhR3Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6w3ev+HTvfkVnNVirxMRgzIcDVhm843pbkgYcxdaO8Oa2Y1hLSotTZJHsWUU?=
 =?us-ascii?Q?FGeoBdqdpB4Z+mQX1MYtAsdoul5zrVv/02/nE0ldyfdf2El21P3pZggW1UA/?=
 =?us-ascii?Q?BH0fl2wMNzreYgmvxMI8TRRyOgfoc2l62IP2nO/XWHQlayilRwoTwc4rPerv?=
 =?us-ascii?Q?3blne6cOs9OE6hN9gZGJdkD/p5DDs2W2a1qAFhwLBLRNmnxCV60R2SMdg2cc?=
 =?us-ascii?Q?tl2PLC3k+C8RWBaoSb2Axw3uEC01b95412XXQ1NLPytq8CxEhs2qVgINW9I9?=
 =?us-ascii?Q?Q/0o8g7hni3FEn4djBY5pwDs22aCv5791c+qEBMjAsiHaObd7WYkbxA8fKJc?=
 =?us-ascii?Q?SoqdFl/YLq29bQz+1BHSg2h5j1LBoFb6qyHF+nOC1A0nzwUDhMprrTgRKtPu?=
 =?us-ascii?Q?oVMCe9vUqnSx+WtaWHq/zbizTge8uqFgoNysNPPebkHUHNHbEfX01cBm5oJA?=
 =?us-ascii?Q?JRo1fyDrWiMpgVCJXcJO+0ni3loKyvmpbCH+DIEUHZfdkVdhH9bT8MV50f+a?=
 =?us-ascii?Q?A9w/Ar5VXmRu0pDN1AZtKQwDDrGyR4dsSKEnFFXbLJeb0BYBceBfgRRcmCEY?=
 =?us-ascii?Q?aVwwqCeoImj3OVEGlyRGny4raavEpo6rXrHRnTiaZtUjdVckFR5TqDP+3vhl?=
 =?us-ascii?Q?icFr82mF+E8qXqlrDXXmT9Q31LgC2h35Nxqv8al5FPNGp0Uy7WfD2QGxKPFa?=
 =?us-ascii?Q?e/+ld1JBxNr/Od6mUQ+b6cpq6zTEbS3Y4PVm8MfKT2U7Pmpw3wC8cYPv1F3p?=
 =?us-ascii?Q?jR2cvMHWfl5sv7rmLAa+zhw8oN277Oi6M6m11mOVR8DT6Ak/23r90xSvOEnt?=
 =?us-ascii?Q?8HPc0s49KpoxC8TaieoeB0MV3Ibl11R6kPHjlmXACcYiIJnVJ9DXdybIG/rI?=
 =?us-ascii?Q?A3IPcbPyT/qpCm1LqL3ml/zsyMly4MuUE3LZhteavWw6xzByBSa1+xxqeyDT?=
 =?us-ascii?Q?HY2FtJlpCVc/hm36qeG5W/YYTST/tDtjk9NWAJDgnWc+slsCxQRbVzwUX7L0?=
 =?us-ascii?Q?vW9jujTKxCHOsh947j6n4p0y4CO/alSGH0JO4m9SmBl4BFq9wEBO6n40LClR?=
 =?us-ascii?Q?QoAo0bp7RU/iKf5RiIADN5ULJotlhELEKqSivZ5OIERGPFphDeq0ggj+2Ns7?=
 =?us-ascii?Q?GYYnXyu62akfLEnEuS8xsdGbU9YC2R01y6DklFzpleAC50fAA2Xbl8ohS7Ep?=
 =?us-ascii?Q?KbRFvpi14OBlONSwME+GUedlEoDhuN3L5gXE8/YOcQdezEQ+1uAlYlx4yyyU?=
 =?us-ascii?Q?2IcYJyq4bjbcVVb+StmQ0BHup6QmaZ5fgPW0sfJpVB3WsnDLRs0ukxid+Me4?=
 =?us-ascii?Q?h4gCvYhipPQbKfDcrsVUq8qwC6BWWrkBJ0NUy3bWzakFHpEHj4QLMgJpLsp3?=
 =?us-ascii?Q?teT5TEwDNlGK8whUZbuCyqlao2FoGTIpswL12YYgfFH76YMJpemnJO3LG66e?=
 =?us-ascii?Q?mYelE9CO09w3xmGHTNc6Fr1H5Cxmg82LHFne2tTj5AY1IbhXEsrjXwKnWEl6?=
 =?us-ascii?Q?HNh/1pE+UE1uGWTiVGFXDaqvLL7Uw/iv9efWteHQfR82ESKg9pTZUP8rL9lL?=
 =?us-ascii?Q?GXKFN+3MzWvuAHAdRoXMFKRRuvulBF7rPH/N2mNabojw7gAi4g/XKPmyN2UA?=
 =?us-ascii?Q?+6IoDkfITTQwXjbJtjXA21mEVktzPqo9pzSiI7BTe1Kg7Yjx+w4MM/sbJ+9i?=
 =?us-ascii?Q?G8oXTfGg0cr9pxPDa0taGBxMN1J3HNg6r3n+lQBfsN2HzS4D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ODOqevWWuAq1ztj20G+M5IiGHwb69Ovi9FQvuU4mIR30AQydg2ApT0WAAHso4NL33FGHZ42sDz7KpxA3nUUd+tH/i4gW1aztF7hjKCvhY0710hlfYLT1WJpEWsqDssC1Lro7//yopt2GNByP0YvQdFdUROn56nr6Jo//Zqt+TEJIWCLRz9vn8eRpBtGYeG0gC/fYMhYWrtUN73G/3k7gJvBJl5fPvEFVWwtHbpnsaEwy3NnXlCkOnYVkVpo6jvdSu7mGoYVnatEMvjuvlCfWoc9If2qMMe2bAvd/qwMp18nJKNpZV651yg+t9XFeme72M3ISAfduxU6HiZ91OnvVWQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e0d08-3074-405d-8914-08dee6455e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:57:53.8399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-transportrecall-originalinternetmessageid: <DS4PPF00BBED10CFE374C1284F5DCA11F269FC32@DS4PPF00BBED10C.namprd11.prod.outlook.com>
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vHhnX/2rkYSx+TOcsKkUXNXdMLVyRAVZCkCxkhRzZWtIIquplQ3byCdw89lpa59jq/rW4xZFAsNsTG6m3hWog==
X-MS-Exchange-CrossTenant-messagerecallsenderobjectid: 668011c6-0c34-4626-9c5e-028805d15073
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8864
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

Xu, HailinX would like to recall the message, "DPDK release candidate 26.07=
-rc3".=
