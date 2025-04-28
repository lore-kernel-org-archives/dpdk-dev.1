Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6245C36005
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 08:09:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10D9E4021F;
	Mon, 28 Apr 2025 10:09:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id F1B4C40156;
 Mon, 28 Apr 2025 10:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745827741; x=1777363741;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0RebQh1XXvapt4VbLTYjc6DqaKIYg6CS+vcZ83pZHRA=;
 b=ZAGbA5UDJvjx3MfG5mdp0wDFPBLBHwDpxEv9SDRqWjS2eskyDnXp4LNN
 BMeVvMWa+ogVfI+qE39jG3ltI3d9GGk2jKzJeIloqUSeviuWNJkqfSMd7
 /OLf70f1dr5ABScRq8+ZS86VP0X1VD/SbREvEW2UmYT/maQW1wSntO25Y
 WdWhp3p2HJr90nQ9KOONg5RG2iv3vCyNcDmEtFRB60kdHiuYdPaBit07S
 DPq6OcnB8GgZjTI4By3MZeulBihVxluIwMIivZbHf3t9YP6L9n8xQwoIX
 KpI8Ill8x5LunAKc7pvO5hmcawntJBH1OepRkyjFdyxwN4TH+VZY21n3g g==;
X-CSE-ConnectionGUID: m8Kn2mioT4KLvRT+o/uqhg==
X-CSE-MsgGUID: FpShpl6HTqqT9NAmSv3yUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="46525124"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="46525124"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 01:08:54 -0700
X-CSE-ConnectionGUID: ZSIzRms6Ql+guVCb1+rLmg==
X-CSE-MsgGUID: q/kUT0rhQ6aP5J6VZSpNCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; d="scan'208";a="164518008"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 01:08:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 01:08:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 01:08:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 01:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4xW/7fJyg2bSxvmQqckf5DsB+SsZqn4+eCp9Jigtjs9CV5A3H3SdY8KA8kpE7G8jeXlw2OiDKIOnjUReTt++VEDRFIQIDz1iveuulKCJQk1CAL8k9E7khCYTPRxw4NMm9WW9ywH0+TQuQIY5BfApQ+pqScYxP7exmVC0toLEjusMMPbaqphu/5e0wGNqwJsYE7Z8iNgun4mHB0MyemoTYihskDBowcgsFcxCZ2ypZ3DxayKUDxNRV8UxjDkn0vgctGTgsljBX8twaZTXU1djFI+BSGE3jJR2OnSY8RlcpVGTgqQB5cl/+F0C1yRVyGYjiaPMZEAMMc0xom3Fb6BYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdQoT7p4QbLyrgHohgabjdeoKCSxf01sxjTnDLLp8lo=;
 b=r+m76930tOvaWHsxMjBT9halAjAReeSAmrFR3oK0CKa0p6FJgc3hNrg/lJBrUxqIUlx95jMnzFWehkLIghvDnjLuoS3aOBgmGxHAvqBDYVqHY8+jOoT4XlsC1WkPmVIcivI21BzjXUK3UNDbAb2a2EA9DmnJBgX4UEF75giXXGgTi+WcrFabtJ9Ff5dAEQTqQMqgLOsaAZMRzQEPQAOG+yUmAEVUW0Ypt93ImzDi7F6rs5117QoEBE05BvwjRC0CATSztAjDOdBCURgNqr6gP0xeIwzYqPABU+N8bA8yjrzODlt8N0tHG8rXW6xh2oSRxT9kZ7NIre4tMQKPA59UVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 08:08:32 +0000
Received: from MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21]) by MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21%3]) with mapi id 15.20.8655.038; Mon, 28 Apr 2025
 08:08:32 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Xueming Li <xuemingl@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Ju-Hyoung
 Lee" <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Yanghang Liu <yanghliu@redhat.com>, "benjamin.walker@intel.com"
 <benjamin.walker@intel.com>, "qian.q.xu@intel.com" <qian.q.xu@intel.com>,
 "yuan.peng@intel.com" <yuan.peng@intel.com>, "zhaoyan.chen@intel.com"
 <zhaoyan.chen@intel.com>
Subject: RE: 23.11.4 patches review and test
Thread-Topic: 23.11.4 patches review and test
Thread-Index: AQHbssiF7CusVzAR1EWIz7jbXLUnXbO4w3lQ
Date: Mon, 28 Apr 2025 08:08:32 +0000
Message-ID: <MW4PR11MB591237692FC1241E2C8221BF9F812@MW4PR11MB5912.namprd11.prod.outlook.com>
References: <20250421141920.622156-1-xuemingl@nvidia.com>
In-Reply-To: <20250421141920.622156-1-xuemingl@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_|SA1PR11MB8326:EE_
x-ms-office365-filtering-correlation-id: d05209d4-b72e-4ff5-ea2a-08dd862bde03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SPzXhgqjS3/AsdPeElVBRk2xI3fY+U4orCiVzX24iVMA7BSpFoae5y32XVbf?=
 =?us-ascii?Q?xinwKKQkVdtXU0D9gbzU6RktNbdmN+AJIuOcRVHxfmcuZH9r0bP3G2w1Td3b?=
 =?us-ascii?Q?kXEtqzm8OEusVGgJqWUwDReL/yUquNR/ToYvxfPWswNfKbZUDQRwe3G6kPqo?=
 =?us-ascii?Q?k32saNtnT/VaRmHNKyEhwPW/GCaLVlpn+EpCMaR3OXdRB41YXsG1kcYiUNTx?=
 =?us-ascii?Q?6yBHUJCZ4BvpWnOU78FSHN+b6kiqu4vGiCSjeX5luqYRZ4jR78Ldw9zcFG+o?=
 =?us-ascii?Q?yAJPyuV4jUurqHuQ2O7CtwhJ1noJKgfrk3X7mrrsO/JwpZqamSgb/itiR7wu?=
 =?us-ascii?Q?nJjomB4j2eSZD5c0rENpQR1jUErhp0n9ST/aOUkp1ubBcw30Law6i6+ch55H?=
 =?us-ascii?Q?c5bH2jRwAjm/knsFVM2o6tWPtzN/OwbzE/kn40xd/OIn0pdRJeek3FeHcM9A?=
 =?us-ascii?Q?P/RM2EYTjpKMuB2o8MPAo5vmTxl7W3N4Bhge9BWuj0LdbIswPt+h8oMyi3YB?=
 =?us-ascii?Q?JKe5BM6PqcVUwXM/aCTXZt2WUmKVC1Q8Pp0XmHMRkgGyTCwqEAPI9q+te7g1?=
 =?us-ascii?Q?8Cw5o7345WXK4Xn4ZSF6QaxKicLCTCGIxUs5pqFVL6iNTIY6KKj1IfR5y29c?=
 =?us-ascii?Q?/zp4h1/eXLTovkMqgo5gF+5PpoN9CingNDHSNvxws2m/uBjo/u/e4qQkYra+?=
 =?us-ascii?Q?FvARCSEwVkwTE5qCcEB6Uh6XsM0sW46yJSDOt/x7um+QuoNzAi8/sb9F7/JV?=
 =?us-ascii?Q?KK58Mi9SexWD+kyaOL3Fcb0Qf8bw7aJXrMA5KZtuNyHtChbeXm1dvqdZ42Ye?=
 =?us-ascii?Q?Pjeio0img3WLyrjYZcV6s0XDB+GqKbmgTtE5XzEWFjl36iip3HAk+gsljX2n?=
 =?us-ascii?Q?ZLP/ua3582/sz+rGnr2anBCFTKk5urpRO5QBnDuxepQcYpbLRcRj3ct0vcKw?=
 =?us-ascii?Q?Qu10RynE0sVvf3TbNVtgF7vrkS59clx/qvCHogQSqn5+JoeQbe/kCvjL+lak?=
 =?us-ascii?Q?sbkRaQk/62gnqzVHUQJ5yjYNOQYSzYXI3zA56zHbHp6ZI6JWVk//+BNM7mJr?=
 =?us-ascii?Q?OFJTiP1sNBytFa1NSg6MaBRjIHv7DKJVnfFrPoZVblLWiGacs4NBelua8fPg?=
 =?us-ascii?Q?IoQh/I5H2UxbYpEbt80Z2RJkRRf56zAJaocKVKatT3c5r/o2pEg8K8goFeYj?=
 =?us-ascii?Q?oAa+lNDYL9enjlj5SAP3EyEyscS4BZT44wZUXF073NMD/XTHB5jYnW419M9U?=
 =?us-ascii?Q?v9KQBzi/4+2m/ngaITB3Ml8XTt7VCehzq+Yj/bCWr/+7/v2Ety48etT9ZVy6?=
 =?us-ascii?Q?5wdJi1q92Gva/baw6I+4E/52e1IznDbHiU0Ci5Dh2Wzic3uTnFOHf0YJ1RL3?=
 =?us-ascii?Q?2zbFQkxP0TqD9vVEw4Ra4U8BizaVSirtbrwc5j7QEHWI2XLWD5fexpYPeS5w?=
 =?us-ascii?Q?rNawMHk+Tx4QWO/t1rrJmOiDMp8m5P1q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5912.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KwsESio4aBoUj9CEnQK9pPvXJRqAn78XI3XAdtnvKyXndtiejXpq5zZ4c/Cj?=
 =?us-ascii?Q?W9gzAjSZ1zqpZ3AN6p6CpW9D/N4mQFDcnAFEAO9v78c93Ao385zmx/b+g9Ud?=
 =?us-ascii?Q?p8SHzcjuKtcXDEb7rFhUX1PiKQnywn+W00B+zOaxLJB+7cQ72yZ1GeEDFqEM?=
 =?us-ascii?Q?hb7NyB61Elws+Bc1XolTCzYOw/CEiIeST8gDi2xhNJiB29c3OkyPD3UoCILr?=
 =?us-ascii?Q?z17vQSGplnjHtjJmytjGuluA4RvVn8lJhcb81TllQlSNEJNzyF3rBgQYI/cx?=
 =?us-ascii?Q?isntjvnY9DmTWtF8P+QyCpjp2SrwbwrV6QFGrwqDENOBj0adkZT5siQ3ig8l?=
 =?us-ascii?Q?5jST+tfWC01dfjOvVZyAyOIBD7jyfroKtbsOFlnKPZGP+2sYSKEyxJm9tKeP?=
 =?us-ascii?Q?FLLJ9uT+SVVPuJGALt60Ccr/vxmGp728EUBmwBa2VY5H/hyOwVZFXZiCOko4?=
 =?us-ascii?Q?NKbLHmNh0rqcFvQkaJNJ3JpEsjgm1tr/TZc2e4vUNFuNZgmqosOlPhkBqIrC?=
 =?us-ascii?Q?P9tySzPDIOfttZmEQKTous/6EUtvTMCukk8kOwHUXOs76YjuKXw46IL9h4js?=
 =?us-ascii?Q?hBHom2V5tad5vfMNKZ/ZPD4Jwfjgmqf8hulPbsgemm+mKCMXUW0sHcH+arGF?=
 =?us-ascii?Q?cnblKH2JNiacj2nU7EGmUYHlY0M+qbN5AVAfCdkDWxOA1qcYGb+hlfctxSLi?=
 =?us-ascii?Q?X829uYf99wU7CMVw7mffdkCGtzQGLCsMTdg2CbcacHEu0s2F0iFc0YcF8SEu?=
 =?us-ascii?Q?8FyA40CsIGV+Y/VuOJB6w+2s6p/jITf0rBN+2W/AmjFJjvVMnxrWQt2WPY9t?=
 =?us-ascii?Q?xOfm0SsO5MQZUixx/zRg6FXjKcl/yVJssG9cMTf4d6NAOrrSPZAhv9yk7rQ8?=
 =?us-ascii?Q?1WquobWqYmTbBexPC1SaozjFkjVyqI1dR9TDwK5pXrvq/SXGg1e9KQrFxQNc?=
 =?us-ascii?Q?g2j8Ee8NCZrWaxxiQujvBNqJU84RCFPoPi7ZFMatm2zvYZ1L0KrJW9rUoyHy?=
 =?us-ascii?Q?8WdKVN33Qsrwt4sRA4k7urvG1L0Ng0N2ply4Y76wr+c4NOCp1xkh8oH/a2gg?=
 =?us-ascii?Q?77S++mb/8AakCVZ78SXHH38zYMKrSIdBO98+0PTKiCpkyG8YxaZl1SOGd4vM?=
 =?us-ascii?Q?rTYKvpC1UfQwvMFhkXWmTwLOqppeMWjkmLwBwEpk09pCl4vjzD0wAIHyMk+G?=
 =?us-ascii?Q?Xyg4Z7vS+e0v9fbiNwC4NgJVbDu0LXR9UK5Xf41lfcdm9jymROxHGxY84CUp?=
 =?us-ascii?Q?lX6chXG8xtQ92GFRduBLSKyghZp0LB/wEiqph0cmCs82O3+KzQlPWoHc+RkI?=
 =?us-ascii?Q?SWJ2RwGaylZQ2HfOOtVNWSVI1qoFub/xlNv0vv8D6iynKeAHyoyg9U02jY2X?=
 =?us-ascii?Q?1SF2vWqSUaVqNX7qX5Z+U6oSadgpBORZB45ZVobZ+DvGtE8vFsTKLPbAPgrW?=
 =?us-ascii?Q?bEF1ItUPULIeMyvZa0zurSv0X3576xpKeA1JKyTYgquUf3UJrNkD38fVKd/C?=
 =?us-ascii?Q?QEFECuGm9LLThgcRxqIzKCi30enc0AyZubSb2/ILudxQfOMBHaO7lN4ruTJl?=
 =?us-ascii?Q?q29VdWbLeKQ2YkIVoXLWGncfShUCJS7Qhtre+YSE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05209d4-b72e-4ff5-ea2a-08dd862bde03
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 08:08:32.2665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rzTLg81T2tFF6J2UDvmriWvW1DC0xWf0dA5cFAZpSToHFLI6jzkH5jFzV9YwyivEm3v2IsAq1oOQJchGOLJQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
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

> -----Original Message-----
> From: Xueming Li <xuemingl@nvidia.com>
> Sent: Monday, April 21, 2025 10:19 PM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Abhishek Marathe <Abhishek.Marathe@microsoft.com>;
> Ali Alnubani <alialnu@nvidia.com>; David Christensen
> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Ian Stokes <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> Mcnamara, John <john.mcnamara@intel.com>; Ju-Hyoung Lee
> <juhlee@microsoft.com>; Kevin Traynor <ktraynor@redhat.com>; Luca
> Boccassi <bluca@debian.org>; Pei Zhang <pezhang@redhat.com>; Raslan
> Darawsheh <rasland@nvidia.com>; Thomas Monjalon
> <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>;
> benjamin.walker@intel.com; qian.q.xu@intel.com; yuan.peng@intel.com;
> zhaoyan.chen@intel.com
> Subject: 23.11.4 patches review and test
>=20
> Hi all,
>=20
> Here is a list of patches targeted for stable release 23.11.4.
>=20
> The planned date for the final release is 25th April.
>=20
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>=20
> A release candidate tarball can be found at:
>=20
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.4-rc4
>=20
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Xueming Li <xuemingl@nvidia.com>
>=20
> ---
Update the test status for Intel part. dpdk23.11.4-rc4 all validation test =
done. no new issue is found.

known issues: fix patch has been merged into main, but they not merged 23.1=
1 LTS, so this issue still exists in 23.11.4-rc4
  1. vm2vm_virtio_pmd/vm2vm_vhost_user_virtio95_pmd_with_mergeable_path_wit=
h_payload_valid_check: start dpdk-pdump in VM with virtio-0.95 protocol fai=
led
    - has fix patches: https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D30356&archive=3Dboth&state=3D*

* Build & CFLAG compile: cover the build test with latest GCC/Clang version=
 on the following OS(all passed)
  - Ubuntu24.10/Ubuntu24.04.1
  - RHEL9.4/RHEL9.5/RHEL10 beta
  - Fedora41
  - FreeBSD14.2
  - SUSE15.6
  - OpenAnolis8.9
  - AzureLinux3.0

* Function tests: All test done and passed.
  - i40E-(XXV710, X722) PF/VF: test scenarios including basic/RTE_FLOW/TSO/=
Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - IXGBE-(82599) PF/VF: test scenarios including basic/RTE_FLOW/TSO/Jumbof=
rame/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.=20
  - ICE-(E810, E2100) PF/VF: test scenarios including basic/Switch/Package =
Management/Flow Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descript=
or, etc.
  - IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test=
 - QAT&SW/FIB library, etc.
  - Virtio: both function and performance test are covered. Such as PVP/Vir=
tio_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESX=
I 8.0, etc.
  - Cryptodev: test scenarios including Cryptodev API testing/CompressDev I=
SA-L/QAT/ZLIB PMD Testing/FIPS, etc.
  - DLB: test scenarios including DLB2.0 and DLB2.5
  - Other: test scenarios including AF_XDP, Power, CBDMA, DSA

* Performance test: All test done and passed
  - Thoughput Performance
  - Cryptodev Latency
  - PF/VF NIC single core
  - XXV710/E810 NIC Performance


Regards,
Xu, Hailin
