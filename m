Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C638CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDA72402AE;
	Tue, 14 Oct 2025 15:34:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id EFA97402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 15:34:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760448875; x=1791984875;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XcgosO79/x2zVVKyIDvx/qQzz5OfHdgiY7+HUHJmaq8=;
 b=dV4YmSRz3aG6uFbKyj9c6sjwgDCrynjUXz4p1y298VOJo4/ZLCtaqRV8
 heWPjNvRRjmn1KLcGFntl2+up0OeX7tZTzVDQ64EyDeqh6ox9rMSEEC9/
 JvOIta1lcOfq/W7Z4VGm3ebhtmeEp7o6E5/OsiE2LHzfhvuhOAABcw2os
 Pkf1XXHkE1HziGtqyYPl7dNf9DR8mHFNg5E2XPVzyGkIpQpUhaaZku/33
 Y3kB0gBYH6RTkBeY5xgn2Akha769vC5NR0scJ3ZzxbhUEOabcCf5Tty7W
 j2bOiJZ4IZU8X0RvF86g4YdB+J0moBcupTUb084Az2E5GB/3yvC2BN+xC w==;
X-CSE-ConnectionGUID: vfUDhGREQY+GeZCWFeSMkQ==
X-CSE-MsgGUID: YmpQAtqrTSGTOy33nwWO4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66264060"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="66264060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 06:34:34 -0700
X-CSE-ConnectionGUID: genuRaUwQYGeqYatO3Jr+A==
X-CSE-MsgGUID: da9cWrhSQtG2FQ75fYPT8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181896385"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 06:34:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:34:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 06:34:33 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aslG4WrUXSi4hulDNV1g4xFa+kNVzynSX4cMtvkusArZlxCJR/+KX443R44Yf/Tw6HLOqoFdmB/tgAe4uGwj4f4HfultHaNgnNiPaggN58JiklhCGKMUAVJZcCfmajmx1hWP7VE7eCwyXaEQ2LAvQHWx5llYW2stWezzq7twtAY1hdODYjURwRBNk1IbAB/p3IHZCgtS7c1WPYLKFrQl94RehbL8yO2T0zv9iHVRpm6QLXuWLUt7j8x3uBVgGGbnS7uzpY0G0uYONp22ZopQhxPsw3tCQjhLvuqo2rK7jUV7D04Q2lMJkVdkUGHERYLEGdCw03U4QgSgIdQwl8Yh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ3xmud24R7SG8xxcGvBh/8QvUQuzOQXLa0BtEJyui4=;
 b=iEj5IONd2XPEf+coX/BA4K/rEUXwdh/zFlXJS9A+6uI61QlQ8ptv2EIOmmEtCN6xt/ekqMTka/4b2LIN25CQVtlile2WTfEi6Ib5qQ9f6TINUpx+KBAWQ7RJNTyvfOx69wA6hamnM4RdFIJgJti+lQ2IjYc8h6E8aJw9pA+0ljvvTpzPvCo0l4I4lKVYRq/+fgJ7s6NJ2P4941oCAZccdEFoLA1Z0wj5ma1Oec5JlEpsOiG3PoFsLpv+wEuDo6peUkwPBiSJP7iXkU2XVM9IiAFKnzhtWyBG3UGxgcwxJIxYwZEIdHOalJi9euW6BiJwVoQQ1Tyxo6Fsa++vGep5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15)
 by CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 14 Oct
 2025 13:34:31 +0000
Received: from CH3PR11MB7762.namprd11.prod.outlook.com
 ([fe80::2881:e12f:a804:cb14]) by CH3PR11MB7762.namprd11.prod.outlook.com
 ([fe80::2881:e12f:a804:cb14%5]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 13:34:31 +0000
From: "Vemula, Venkatesh" <venkatesh.vemula@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>, "Wani, Shaiq" <shaiq.wani@intel.com>, "Marchand, 
 David" <david.marchand@redhat.com>
Subject: RE: [PATCH v7 2/2] net/cpfl: added CPFL devID for MMG
Thread-Topic: [PATCH v7 2/2] net/cpfl: added CPFL devID for MMG
Thread-Index: AQHcPQjoCYNpm0LKm0e+lrZ6aDu9PLTBpFEw
Date: Tue, 14 Oct 2025 13:34:30 +0000
Message-ID: <CH3PR11MB776244CE121AF42DF81177EA9AEBA@CH3PR11MB7762.namprd11.prod.outlook.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-3-venkatesh.vemula@intel.com>
 <aO5Gs9gOiTmgBSOW@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aO5Gs9gOiTmgBSOW@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7762:EE_|CY5PR11MB6462:EE_
x-ms-office365-filtering-correlation-id: 3dd9bfd8-9665-400b-83b1-08de0b2667dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?y8kQUX2N3ReQrOwQD1rj3Strtu9Rw80tPMeLFgYhFNBX78L86m7DBqhYU3Y5?=
 =?us-ascii?Q?XhB5s4hJh0kOTc0rbI/+j6p/4WOD6Oi1YzKXVcHZoS3iKhszO/9X2sYzmGfp?=
 =?us-ascii?Q?FAjcl3/X8VRDVm/EUPhg1UBSRPwPFQVUINmaclankRKC6ck2p2prs80Lj4XM?=
 =?us-ascii?Q?izU2eneNQTlmsCVEpuEp2sy7r/AlRxdIj4NUlLRg4wNGUPsIeMv5OxKRpGl6?=
 =?us-ascii?Q?fenhkbm3u5TXp5ezZ2/V+Wi6D8DaJXWWWjWqDU+c9bzZNxrXwotFXfwLanvV?=
 =?us-ascii?Q?LRrE+qobsNXIMNBnflzonxaXFUu5mc4mRApciOj1R2/uM4/EGoVjU7rzclqW?=
 =?us-ascii?Q?rMIXbo4XPkWngddKUgIbXP1pMF626b10c8u+41cbv6IGabj/ywgsTwLUg4VZ?=
 =?us-ascii?Q?IxhfZwSYtS/f7kXnNbQmxqIf6ui3vA5Byc85gF2NjPTqiLGAasi62WcML/7u?=
 =?us-ascii?Q?3i9mgmvHXoPUa1eHPO4JnemwdCi0qbLfFAAfiO7ER6zUguEZslni2vORAFgD?=
 =?us-ascii?Q?I6Z5QpoFiSoxYo+1cMWL3cPfF9KWnxfTk0TOzlP4WvPvE3NlgY9RhBfay+PE?=
 =?us-ascii?Q?jW6Q0iXm9lQkFJhcKN6H0na0Xip3DK3uEU5W+k5+2BIjjHCnhlECg/BHv0/O?=
 =?us-ascii?Q?iNW2/jzWBcfBlc1YLDz8OaWY3xNHvq2R0WywLd8cyWwaB8G8kyFG8SVz6S77?=
 =?us-ascii?Q?vB5Ojo64Qcm1kla0xmW08Ue3e5Z/CvsWaKQD9avM0PSWVH9YguT0eq9hqN++?=
 =?us-ascii?Q?bAcIKBGCWW/kS3/LgslB84fKk5rfWZQQXOMTSfrRPjYLXH6FEA2Qird3/tU9?=
 =?us-ascii?Q?Xgyiz1Uw93RGgemtqZcYlZSKqC58ZjUrv1M1ivO7C9lIzQJ2oq/yMwcrkpV3?=
 =?us-ascii?Q?WbukAy6sxO3G8M+VeIQFImg/pnfnONNsUGMHUcFeGuEEXXvivOpbl6bYCD6q?=
 =?us-ascii?Q?1HFVI/ap9FKvzAZjYNS3KAU85PVYHkTKSir7Ws8/SPhoGiHHXMscYme2KBmU?=
 =?us-ascii?Q?EdYFAKbjyUTUu7mhWxNwtLMYKDh/hjEkNzfHnT0X1vh4dHI4xDBRghwD6ltQ?=
 =?us-ascii?Q?hvPZRJP/gJ2phtgwvRSM0E4+3mJvQ+Dy8Qzfs0r5S1kW93ORUHquMxx/iPg7?=
 =?us-ascii?Q?kq1T0uRpIGYUnsz5HIL2XEYVVUF0UFWwoI+vBqzklcwKOUL/uTmwydTtGCUp?=
 =?us-ascii?Q?QQsvYh8jj9TKQx1cqzzVCocVQwHjqGJrw6xT8gGm0VEeOMYrx0FHgB7z943o?=
 =?us-ascii?Q?gZyad7fhWOkofQywJyqeYi8/tp5a+ROq6lbSvKf7mAJw5sWKa4/a0hCx1TA1?=
 =?us-ascii?Q?wqhVb3iVPSY2IDqX2qd5N2s8n9kMixN4k7F5Lmv2Mw0iF35uPQgq5BqmSrpA?=
 =?us-ascii?Q?XHDWU4LhqOSNhw1SV3fUoHDJrKVbT6RvcKxDZ31wBOUyGgHsWsacCTPcIIm+?=
 =?us-ascii?Q?Z8i6OXzpTQpKI3fv+Nf8V7AEitTCx+040JzgDY+K+/vtNEcDkLIB5912Hk6p?=
 =?us-ascii?Q?z5rEOzK3FQAx60G5N1JEL0qX/cZq8LU4mve0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7762.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zWOYCh/CXrT1ZiDwPe0mY+fcVffyoHwBOyhcoU+LNpLV2/n2hDrs7/dFpaKH?=
 =?us-ascii?Q?GSOtZmd6ZGV94xP0wpLKtAvWsUUJSX8N9ZzcdvOw9VY3Mijzou9PHCYz7bP7?=
 =?us-ascii?Q?K8u26SqfA43s9gZ2RF2Segk+eayyOuRQDVfBp2xMLwx64Il+lJm6pKRRkxrK?=
 =?us-ascii?Q?1aIh6LPbL+Tyiv1+gQY5gCcOxwA8wNvct1ct3ZMWubWNgZhFXFXrU/q0ojT5?=
 =?us-ascii?Q?yWSgY/xnZPnsB3UM5Y/kBqTNvQFYEfO8vX9ForzfD+IbVflHBB53k3zN69Jr?=
 =?us-ascii?Q?MU+oZZnoq7JnA7Wg440dS4qYmBOap7x+TIuG3I2Lsg9tN6dzqXQKryO107nQ?=
 =?us-ascii?Q?0OVJA700Dn0vVTg6nu25UVDNH2QSGsDsmeaDlwdvRJAS3SdeJQtEA5LoJwgw?=
 =?us-ascii?Q?imuXeKvr53TV0rw+2KI3KNC+/ypnbJ2YaWf7+HD/3BSQ/5Hr/lCju56BIHSt?=
 =?us-ascii?Q?TCskALUJZdG4g+/ruZBUePwiRaIpg1CxaOFf1lTuAc4kMh6XqGXKulQuCBiJ?=
 =?us-ascii?Q?+vxR8H75Z4B7KsSuiVUWecHRjtkKN+UtNRd5kEHB4KhjqlkwkyseFq7YWvsT?=
 =?us-ascii?Q?SEa2W1V/t7DB9FoEF8Bm39sdlz7YTx4NG/5E8GCzbfRj/QyO6YBrmI85AqOx?=
 =?us-ascii?Q?o+jFoTYc2cpXF4QyQAAXYYPTK+UUfm/vjm302PNSePe2cpaS9UpX/dzce4Dy?=
 =?us-ascii?Q?8Axaz8c2SGX2///C4ChtOfP+NqGpDlzbagwzAgtJOfEC1MqF75/9Qh/8qBYF?=
 =?us-ascii?Q?8cbhdISpu9OuwlO9qTqBSzaFXd4mlAH7sVOiBmGCMD/K6KS71eyyRG+4b5lG?=
 =?us-ascii?Q?Ccrg+4mIY1L/x2ezuW5c27AA15RImzEfU+r3rHCUXTC8SqxMxes7U5jmLusi?=
 =?us-ascii?Q?08c/66ukd+n+PESxoU7eN6kTl6HFRAAzh6gMmTPa4EVefWg3k76Px5hUyBch?=
 =?us-ascii?Q?+EYH3qh5ivWPpw9yQqYmwpJuGSOdawjh9LU38gxTqgS2ueFv9nsKKO22Cvdk?=
 =?us-ascii?Q?sDeYnay5/h6yP6bKjPEqLXGI1c365bnkni6WpQl+meP9qTyuq8xV3lCDGLE0?=
 =?us-ascii?Q?J0DxP+V9Rmt2+1U798WDiSmVwNSYsGGkMlTjCAfR7ncuDuqn9o226w45cMvK?=
 =?us-ascii?Q?FtdnEZZozGZLKlKuOBYRmrP//Q3+JafD/WG+zNNc5RaHhEwX+pTUNHx2qRDX?=
 =?us-ascii?Q?T9ng/PfP4CjSAhxhuNR+8W0DnkTZyTiYejHCAPkeRk43Y51kmTk1oINru1M2?=
 =?us-ascii?Q?QCQP+j6pUykAvRQHym9gotKa69gf5jejg3Y/a2p6HvD68J4ArU6CZ592BAtU?=
 =?us-ascii?Q?urdWFiM4tQBiTIXhyqhDSSd6tri1VQAet1EAdCiQgPHwFwTAC3/mrQdD+lIU?=
 =?us-ascii?Q?X2dvOQCKUEk8WvhZbcAMmZs+a1mWFwKe8rFdDXSslhQMvxOZrjM88T13iSsw?=
 =?us-ascii?Q?dN54W4DhT+nPZX0p8MsMxwl3X5iQNVk8F4I6rMCljGwxCW2NPpfWgpDUkLUm?=
 =?us-ascii?Q?jfvkzmxOIsS0M5ZrVVIA5Fkj5nCfri4soaqtfJhAFfyH545/I67xu7EE5pTr?=
 =?us-ascii?Q?QyJCkxWeSLJeu4ZFv3epxWouPDQ0/M1dFZf6dIqL6BzQF+DNuDVhmSLD5I6f?=
 =?us-ascii?Q?quHi2fuS3uFUE9KNjFyaCREc+uPpiwlQIRuHmGMhBK1p3Uqr5Z/DTk7tMBtJ?=
 =?us-ascii?Q?VIpeIQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7762.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd9bfd8-9665-400b-83b1-08de0b2667dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 13:34:30.6320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Adpk8s2L8bSAnqywXTJzTggt8LuCTEmQ42aJrCrkQTDW/xEknEJjeVumhkaG/bMyd3/77gfmymiZMVIMG2CAa46Gg+U799FDkRoJZitiMrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
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

Thanks Bruce.=20

-----Original Message-----
From: Richardson, Bruce <bruce.richardson@intel.com>=20
Sent: 14 October 2025 18:19
To: Vemula, Venkatesh <venkatesh.vemula@intel.com>
Cc: dev@dpdk.org; Singh, Aman Deep <aman.deep.singh@intel.com>; Wani, Shaiq=
 <shaiq.wani@intel.com>; Marchand, David <david.marchand@redhat.com>
Subject: Re: [PATCH v7 2/2] net/cpfl: added CPFL devID for MMG

On Tue, Oct 14, 2025 at 04:15:11PM +0530, Venkatesh Vemula wrote:
> CPFL changes added to new CPFL device id for MMG.
> rebased to next-net-intel-for-next-net and fixed conflict and compiler=20
> issue.
> changed macro name IDPF_DEVICE_ID_CPF to CPFL_DEV_ID_MEV
>=20
> Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  .mailmap                             |  1 +
>  drivers/net/intel/cpfl/cpfl_ethdev.c | 13 +++++++------ =20
> drivers/net/intel/cpfl/cpfl_ethdev.h |  5 +++--
>  3 files changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 0dcd8fce3a..7c121cf5ba 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1665,6 +1665,7 @@ Venkata Suresh Kumar P=20
> <venkata.suresh.kumar.p@intel.com>
>  Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
>  Venkatesh Nuthula <venki497@gmail.com>  Venkatesh Srinivas=20
> <venkateshs@google.com>
> +Venkatesh Vemula <venkatesh.vemula@intel.com>
>  Venkateshwarlu Nalla <venkatn@marvell.com>  Venkat Koppula=20
> <venkat.koppula@caviumnetworks.com>
>  Venkat Kumar Ande <venkatkumar.ande@amd.com>

Mailmap change should be in the first patch of the set. I'll probably chang=
e the patch order on apply to fix this.

