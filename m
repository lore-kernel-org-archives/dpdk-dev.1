Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528DCC3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 09:42:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03CDD4060C;
	Thu,  3 Apr 2025 11:42:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id AC3564060A;
 Thu,  3 Apr 2025 11:42:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743673340; x=1775209340;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RCY0pWeC8rE4wEYZEKiRd9c3VXMYn/wqhOhkHDM86jg=;
 b=IzXprC/87OMkbHNKYUya0thlaZ/fVSvK6UssKvbt0ICAiBXowZxZaODY
 FZ8QtIBN33RGAbLjF3Lrnhb1WNYH7gPwB/JE29im3szcihPB9Zc5NGw1F
 fLMXg7cuLTqvvkGcgn4DDiOVr0a3nZgUf0Oe0CiTj+pTZ5WMdVlPHiIEk
 A+vfoLPoEzm/gFLwhCl0ZPm9NtM/UwLX+jM9/ECvgCtAiq6DhDJeGY49R
 Pc32A3x8vWTfQvXcCBITnHXYtiqvbJhKRVARGdJlcqeGpE2WEIxojvc8m
 Kql0UcVJuPmPPFVPtw1pcTKTrBtaXUk1F/xBj6rDDqGSPtSkz4WxEhacY A==;
X-CSE-ConnectionGUID: zwt9b+F2QCievlDpyONBoA==
X-CSE-MsgGUID: J1Ay09CgTZCz7KeaQl1PzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55700229"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="55700229"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2025 02:40:35 -0700
X-CSE-ConnectionGUID: RfRy/lVzTayvOYMhbIZV4w==
X-CSE-MsgGUID: jWhW1zMOQ0WERZa20oPqlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; d="scan'208";a="131677426"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2025 02:40:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 3 Apr 2025 02:40:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 3 Apr 2025 02:40:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 3 Apr 2025 02:40:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ5RQaQosXCXd8oTqaCI+W3iej4JOvHmtHMCUATf7Tsgn4TVX62wWXfLcZb7MXjb/MEo7rSUx3ax1koWGTYt0Zvyf6gN1pLEZtFyuW6POVVB0PNVC76b/Wh6OimaiD1zcmxBpyY3BChS8cxwAN+pFD4ow10iZZbd6lU16TAeezHzzho30KhsuVRN7MRJV21EmZmKOkVi+IaPHEMuJdE3t+eJgZV3wAaWt/tFj9aIO98eJ44dhpiPksWkSnlzGU2wajFUamEjCFJY/7bxF4tBJY8V0krGSm5QZsDlwwsFGQJTqhx23bbiC/qKstMYRB62Obp1Hm3IQXm75IAjef5T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ojm5MZvXIZVBqscRIFx/WC6ZIOJ/sjSJ4RrtFaqTW/s=;
 b=FqkLFwIjmEBtUEoKflBUzq8+qnQlsFhC7OpBgmfMEEhRZYLKvJiSwiO+RF8uuzkYr5MluwPlxwVhwHwLPevIRLv+m/q9GmS7VMBp1z6j/nUC209iB8EnkNkzDFRoFmUMdXpuZH/xtc2Jzb9Wmt9jkBYOhqsJTGNhSZ8DtfcFrKlg7JOW7VE6042am94CkZMC7UTCl7FjlAKl5/gqqOKvik4GYD6QP3Nl6ougEKflQzetX6SWmudeNFvskoeogbfRAQ/uh9qSBRW3cbiCEHDNv/U8l26/CvbjccONh4xdiEqvIj1QUUB3iehdgs9RP57DZqLGyK/M+PMUdB71WAozKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Thu, 3 Apr
 2025 09:40:31 +0000
Received: from MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21]) by MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21%5]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 09:40:31 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, "Stokes, Ian" <ian.stokes@intel.com>, Jerin Jacob
 <jerinj@marvell.com>, "Mcnamara, John" <john.mcnamara@intel.com>, "Kevin
 Traynor" <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>, Pei Zhang
 <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>
Subject: RE: 22.11.8 patches review and test
Thread-Topic: 22.11.8 patches review and test
Thread-Index: AQHbnkV+K8ydNmsBl0OvhyXtMlie7rORu8zw
Date: Thu, 3 Apr 2025 09:40:31 +0000
Message-ID: <MW4PR11MB59126EC32C85D127C002CA7E9FAE2@MW4PR11MB5912.namprd11.prod.outlook.com>
References: <20250326115132.1444530-1-luca.boccassi@gmail.com>
In-Reply-To: <20250326115132.1444530-1-luca.boccassi@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_|SJ2PR11MB8538:EE_
x-ms-office365-filtering-correlation-id: b6808d08-0c6a-415b-f80e-08dd72939363
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?w29rIogYoKUqOe6tEZhmJGptBxr4A4LK9ofzeW2fxeGL/wTGRbydegIEvdV4?=
 =?us-ascii?Q?8lM/NttKojo9Hmqot50SqbPBOB3OthTmtmBu0wlobUXSmSMuQlHRNMwEWZev?=
 =?us-ascii?Q?BTCs9uzbD0m38EpElCpHaTT4P4ptQ8/1gc5lkzU21QyrajMoGKHYoBLfxG0n?=
 =?us-ascii?Q?OxORXIptyycy1WBUk9gGzCCdAjgOUIIhiuE5h+Tv5T2oCbnBKnOllxn1+SSb?=
 =?us-ascii?Q?49VfYnmH6/3WAI/lEPuejWlUwAn0Ee3ikGdBLf4yH2Zia5lGIJVvx+5xdnmy?=
 =?us-ascii?Q?14ppUoVmpa4Z0kyvXg/FZ+MhX6GjzjyoBeFx8eqJnBcfHj3WMJ6b4isAbs3g?=
 =?us-ascii?Q?BHnqg5TbbwMEx4iJi5nIS+NoCQxQeUk4EKWUxYq454EksqdSe2kPZldZ/sUG?=
 =?us-ascii?Q?RBSrhQxTq0PvwKEazxiVAFNf6lkF5Xpvu8Xnaly93CnVYSMIJc8AM40M29YV?=
 =?us-ascii?Q?7j5dEMB6pXTNR0rkYX2lSDOPuZ87VWE1wDA8qFIAWfFHZ+XnTQEKFlpr9O3H?=
 =?us-ascii?Q?8ecy504paHInv0gSvvTh4qD3iqBl/o338SA+3pX5OIohvXbWWz6zBfQ89ZK3?=
 =?us-ascii?Q?mMuFgqtbFznFA4v9zS3l00JOhQxsgjvyjn6qgFCmsWp9d3dh47qOtQt4KTII?=
 =?us-ascii?Q?z9ICMwjr7ZouUagFNLX4+0mfGpL8QCUUcfeCPSYF/JCpG7mP/IArilIEjZ47?=
 =?us-ascii?Q?I4JmXc2HgjN8+PPiEZ1LKGUNSHbnr5aOYO6IxYI38AYj5kVejA+plHBriOf6?=
 =?us-ascii?Q?8mjioNleqShFGVCuAC3qRBuDOBJ0IPJCoTLgQjGxE9a8TZHT1sApQsuAJjbj?=
 =?us-ascii?Q?HorQ5ZVOjEmxOJWr1YApGU5Wp7GvQeKtqpePxNNWRKwHPa7fI2tV9waZCFAp?=
 =?us-ascii?Q?Jh8yrOk20LMy6x5urANQ7LQW+149VKryqCnYY8mJM7vp+WGX4mSqNdEido96?=
 =?us-ascii?Q?Ow/7VeR+5gFnI9GuqasE0QfDwSJv/QCpcCs35WQhjh9jaTzuJ7o7+b3A6sOX?=
 =?us-ascii?Q?W7wYXg4X7mphb3QDBqEJt91ydtkFJNqF2gi682JXejZz33r3Ekxhi8P9UHfC?=
 =?us-ascii?Q?SVNt8mKb+ir9YzOlms34fwWf5igKxBP0TFhtXjLRikZazMqTYeNUEaRNjnS4?=
 =?us-ascii?Q?ZAh9NdGr2jZ7TGL847F0YGFn/jm4bT51w/0oSO6ye92y1Kv9iu+InYUBZcFM?=
 =?us-ascii?Q?ZIkUDRSt0LQcn6f2pXqsjhPcM/wmGQuRVJjAzyyyvSjJJ+sQqaIo+VxvbGVC?=
 =?us-ascii?Q?jdOALe9musSM96zJUWIuh8eNYDb6duW07b0igt0VAMAnJ5swTDEUJ/pvnsZh?=
 =?us-ascii?Q?ULOqPDbwc7MoNkr/mDynnQjPgD3Z3YY4xIgvwbcKwsnQ6H+s+HcKp6jLkbO9?=
 =?us-ascii?Q?Dsk/oxiF9r092WS2nqZxtcOAL0sulO3THudG1D19XWKZmhQW4SEv6nVEnB4w?=
 =?us-ascii?Q?HTCXk3l7wnCoW3voGlMVrgw9LbWUXA9d?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5912.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DwhL063+O6rw2GEiRlR1Zlj/SYLe9fZSNBtAvsdgrr4uGLWz55LhaPHC85IU?=
 =?us-ascii?Q?hqGbNrqE3dzjL//3lrHOfE6keyCZUGEWtEb718xIoGIbcahE++mXFabAlLYj?=
 =?us-ascii?Q?L3QA8RMdL1kVTY1Vtvc2zWG6i6S/R0gW0m3sPJyQjiI7If0lDAzhZcMX3ph7?=
 =?us-ascii?Q?q8AzLEO0f1ejku8/PEs8o9apoxDx8ic1dNEf641DDz2NnjmOmonET5By1ChH?=
 =?us-ascii?Q?iQohTGqUW5A/ZlSA4/Ofw3cdFGsAxfDj+FLn5jejtrVxfkAkBcPAezWP/qOQ?=
 =?us-ascii?Q?cKfkE8LjV8363AeLswcv5Gq7xKIAcOuKclxd55XUIcMSsVs2Jeq131mIDfzV?=
 =?us-ascii?Q?DSJEBxbTIabg6fKLCUVWPyJ7vwpwOHUk8lD9csFhr4He7W/darn0tZXllvlD?=
 =?us-ascii?Q?QjmZ//SRIpf7m9SJtGtMReIPyuR19peqtdN9MUhdghuhGqZChlbqrgd2qWOx?=
 =?us-ascii?Q?gn4mwhP9SsbkOrqVjvYtyaSjd1zz25oSnnLBbZPuTqY4wgyRzL6zrlcS4rUM?=
 =?us-ascii?Q?1lewZbqsyI8KYSUCXbtl0k5+ISJE68/tJ73FbmL/qhXASILZb9KUP2XIb0og?=
 =?us-ascii?Q?uJh8T86+W7KrpQzQS648m61HV06I9CjWnmpBXZBLZNqEhpojMbQaT2D0OC3b?=
 =?us-ascii?Q?/0osiQisyMAdfh1RMVJ8aBi6o2o4xQ7pytMAQDLfLXzSagzsPRlxeuZElYgy?=
 =?us-ascii?Q?x9hYeTInJCi856xMnrQGpVCNosU69467IE/xLd4GCpmdQd7yu8m/CKqnX2WC?=
 =?us-ascii?Q?q1+GeUoObTZqk4mgRalYaJRgZJRaSBlhVLueISXzN8ZmZq0l2pBNgic/qK24?=
 =?us-ascii?Q?MKmdUKAvljV5FSqReT2qB6wnTVgW2xkdkS+vqQYp/hjLyLsN2SG7dNfDrU/p?=
 =?us-ascii?Q?4s6PlsHKegqSs++V9LAU1Xs+Iow1Nad9CaEEFC51XHwn6QxQ0h11hO1/DqkN?=
 =?us-ascii?Q?HPK6vNBug4TUQk9QUBpLZbgFvLmomGRdyST5KfLIK/hGkIktJYmEBqM2lpWI?=
 =?us-ascii?Q?/pNNJmMec3R1uUrkXpN0PpmzuiWHFbNWNVGxxTkK3h+HyUHivN+EJZhtZbjZ?=
 =?us-ascii?Q?7m89LrVm7knzGysr2gDZttOBA9KU9sDrk5NDU5WxLg/w+YYPNWFEIT9009HW?=
 =?us-ascii?Q?6AYTDxM7SU4TgjN/UzNj5GiZXEwSPnbPCD4lDB++fvitR8BePjDR5Dhngvw1?=
 =?us-ascii?Q?HWRGkl3zZ+JWrE9EvBRRFXp7FiDewO6JwSq/hkdaBvpQf1WeakdD8yDSl1lr?=
 =?us-ascii?Q?3HSyZjvdRe/0CkafcUeBDl41LhjEU9NkqjUOLeb5VyZ4Pr+7NveQmWFlrlxj?=
 =?us-ascii?Q?/T9gjlcIgc6RG+NiPypioyrOSFLG+pXBXgt9aOF59AL/djUVkheIEJqcIa+k?=
 =?us-ascii?Q?q93DjvcgstdI9MUxtNHXOMsQyWIh84r5uDrlJhmg3oDs/SD1uC08Vq1ayVN2?=
 =?us-ascii?Q?kh35SSj+nC1c3jlqSg+JPViVdYUOAhzY2ZlcBSgswJBHBB2mXnTaqM+76Bo9?=
 =?us-ascii?Q?yoWFrOLaOyWxB04phT5TuvIL6loxsTBcQAsORS6Ghm2rkxy/CHzyLARSqvtJ?=
 =?us-ascii?Q?ji9JmRfLocYGVDIG+CAwzo+Q9LJ28elnIg0Esmqi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6808d08-0c6a-415b-f80e-08dd72939363
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 09:40:31.4465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gauPEGZLFQa0lF5K8pdPS1mWGtwy1WEKKulDelDleDkxp+TX9Ha2+TfWDgQri9vUyt3kQclejCjZibN6tNm0mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
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
> From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> Sent: Wednesday, March 26, 2025 7:51 PM
> To: stable@dpdk.org
> Cc: dev@dpdk.org; Ali Alnubani <alialnu@nvidia.com>; David Christensen
> <drc@linux.vnet.ibm.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> Stokes, Ian <ian.stokes@intel.com>; Jerin Jacob <jerinj@marvell.com>;
> Mcnamara, John <john.mcnamara@intel.com>; Kevin Traynor
> <ktraynor@redhat.com>; Luca Boccassi <bluca@debian.org>; Pei Zhang
> <pezhang@redhat.com>; Raslan Darawsheh <rasland@nvidia.com>; Thomas
> Monjalon <thomas@monjalon.net>; Yanghang Liu <yanghliu@redhat.com>
> Subject: 22.11.8 patches review and test
>=20
> Hi all,
>=20
> Here is a list of patches targeted for stable release 22.11.8.
>=20
> The planned date for the final release is 2025/04/10.
>=20
> Please help with testing and validation of your use cases and report any
> issues/results with reply-all to this mail. For the final release the fix=
es and
> reported validations will be added to the release notes.
>=20
> A release candidate tarball can be found at:
>=20
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.11.8-rc1
>=20
> These patches are located at branch 22.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>=20
> Thanks.
>=20
> Luca Boccassi
>=20
> ---
Update the test status for Intel part. dpdk22.11.8-rc1 all validation test =
done. no new issue is found.

# Basic Intel(R) NIC testing
* Build & CFLAG compile: cover the build test combination with latest GCC/C=
lang version and the popular OS revision such as
  Ubuntu24.04, Ubuntu24.10, Fedora41, RHEL10, RHEL9.4, FreeBSD14.2, SUSE15,=
 AzureLinux3.0, OpenAnolis8.9 etc.
- All test done. No new dpdk issue is found.
* PF(i40e, ixgbe, igc): test scenarios including RTE_FLOW/TSO/Jumboframe/ch=
ecksum offload/VLAN/VXLAN, etc.=20
- All test done. No new dpdk issue is found.
* VF(i40e, ixgbe): test scenarios including VF-RTE_FLOW/TSO/Jumboframe/chec=
ksum offload/VLAN/VXLAN, etc.	=09
- All test done. No new dpdk issue is found.
* PF/VF(ice): test scenarios including Switch features/Package Management/F=
low Director/Advanced Tx/Advanced RSS/ACL/DCF/Flexible Descriptor, etc.
- All test done. No new dpdk issue is found.
* Intel NIC single core/NIC performance: test scenarios including PF/VF sin=
gle core performance test, etc.
- All test done. No new dpdk issue is found.
* IPsec: test scenarios including ipsec/ipsec-gw/ipsec library basic test -=
 QAT&SW/FIB library, etc.
- All test done. No new dpdk issue is found.
	=09
# Basic cryptodev and virtio testing
* Virtio: both function and performance test are covered. Such as PVP/Virti=
o_loopback/virtio-user loopback/virtio-net VM2VM perf testing/VMAWARE ESXI =
8.0, etc.
- All test done. No new dpdk issue is found.
* Cryptodev:=20
  *Function test: test scenarios including Cryptodev API testing/CompressDe=
v ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.
    - All test done. No new dpdk issue is found.
  *Performance test: test scenarios including Thoughput Performance/Cryptod=
ev Latency, etc.
    - All test done. No new dpdk issue is found.


Regards,
Xu, HailinFW sync
