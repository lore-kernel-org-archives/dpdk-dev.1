Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07ECC531C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 11:06:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B908A4028A;
	Thu, 23 Jul 2026 13:06:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id DA5D44027C;
 Thu, 23 Jul 2026 13:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784804792; x=1816340792;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7jUKTxH3/j8mWixbKPJCWnh0mfK2gerOFjwZE9GgYGI=;
 b=AcqlGyGizovHhb8OsCECq/UX72mKyb62+3TCNbZdc7E1bVicGHhW55HN
 rx3qGQoRrrvFXEUVllW8DMQwa7/dYokGZkGQuDoR7BDhMapXxCpY5kvTh
 CZJAso7a6xr/sMy0OApTZ5mTI7HXHEX/GsugxOb+y2cADRkRTrIxzQeVD
 hY8qHcw171i8v4Lj+7hgjGLgc5XmZs1P8bhsqAYujiYPQifdMta/o4Q1k
 5H6MU0OUhRxwJywCCZx5hEkGCKSiPkOJyHnWw9spDEbaiv8SmUhycHQZl
 cLe+E6haFrV224Gk1PTxDgxMVImATPy6fgnxcvBg52SCDYvWXWFyJGnG6 w==;
X-CSE-ConnectionGUID: 4FGQdA3SSTa5Uy4a+6ghDA==
X-CSE-MsgGUID: 2jaGmP2UTlSKZJaSQdeSvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85330287"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85330287"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 04:06:30 -0700
X-CSE-ConnectionGUID: /yFs7Q7gTWuMWEeTqkjnBg==
X-CSE-MsgGUID: QkGMlkVqTzG1KX19Np9rLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="288372538"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 04:06:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 04:06:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 04:06:29 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 04:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPnQT41qMcDqg7Clthp2/ZJtoQ2b6PUumi/WpCusRYsODsRp++bg7Zc8ezsF4YgKhb6IP2ZwUKAFFMwwsQ7IhOeVrdTOaCTOQvDjweGjGNK2CrkBo3dF/pA8QF5xxLLrZ6g/zlCV2qju+5UyXOGZFz5kwwYPt56ztcIvIsfOT5nnCBx++beWAjqvYelmA1zaiXlQFquv/CGBJfIE78SAVBflVvEpVqGIgSOISsEP8FXPYhz+nMN0kYSe15XnckwP7nm3DHJHbFxGqy1zZ1wmfcvey82FSiVwZLVxacoraRF9clG6dBcJquQFIF/kfdz7S2MkE8o/yicVqZelONPEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEcg5GSQhHK3bJzTXSZ2Nvk5LuwAX5VrZBY05SS/D74=;
 b=STvgY1BWGbx0PNSfqhlUVhLm/lGv3tXbXEYD/hsa2xoordnlXBB1tg/jYX4zLPcFhKp0FYzs62oO9dF8As93yHt9LKBkcM+pfqM0kAdCxJa3ljO18MQ7Tm7Cj5ky9PG59fmLbg6llgFTt3ah4FWTXjfXZ5gBbmas2aVSE+K+4WN6QOP8AkD1rGOJfpCXewqQ2k00LOwxaaaKbZbhWkmZOjoh1RB+onz/IofNXoooMc6RsI31JA39ql/+3V2cxt1zrHAh4cWUwEAOp6CRh+Jd6h1Z2a25HwfXukc3CrNw96UWUgFu5DERf9Ik+mdi/Vv0FeJWfRhPJz4/4EFs6wClkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS6PR11MB9917.namprd11.prod.outlook.com (2603:10b6:8:461::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 11:06:20 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 11:06:20 +0000
Date: Thu, 23 Jul 2026 12:06:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix VLAN offload when inner VLAN is not
 supported
Message-ID: <amH1pxMJEtK4Pa-c@bricha3-mobl1.ger.corp.intel.com>
References: <20260715225234.482186-1-anurag.mandal@intel.com>
 <SA1PR11MB6782C22FF22157251A5A9FDAE4C62@SA1PR11MB6782.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6782C22FF22157251A5A9FDAE4C62@SA1PR11MB6782.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB9PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::32) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS6PR11MB9917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9605a610-ba17-4168-ecc1-08dee8aa6cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|6133799003|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: lo19RQp998iDQI4JMHEYbSrof4RaD56tNimoPJd3JXLNVu5pfh41Zk7U+AHJfIawOqcBvuKlgl8b2N+jCVxmSU9EA6a6bhw/oSQLUCw+rwzKg+/pxeAnD5wr3dOoQRAcnDIxLtJFuG4o//PtHZs7RbwwpeTc+B0D0G1tfB2kv+/8OMcyeflVS2zeEsVU6X1kORc7KsjWqAJGkywwDdbNspbkXXyEXjIuv+MC3WLy3UpZPro37jzDUWHBdNHJFBY8xwzSHlsAL6lTR57npQHiZowHvACsdCNLaRCRRCJneV/WZR4H+kLGjrj6GDMZ9M9Zos1q6oL6PhrED9cWGyuhOcI8XJV6aaag8tXQgJtjqVBQnJmdoRQFfAs4qbng4FN3bCOGepBsj054JCs9AwUuAG4x7keQ2FW9s2bb9XOEyblxT9T3yayLisnelCzgghyD5XOpE8+IIZ565+b1VOc55XwO3iMcU3fvdg75FbKXGuVSRL9d6kBJ1KpFX3mCbzAZj8zUYrIjt9qz3jlSp3wf6OLwvftm1ZnL4k/Vug5bm0v8iquvbvwbNbWN0YKLq/i618hfmNjucibSi8+vLat7KVvRsUVRtXoDk2TsfpCN2EmRCXeh6M4fw08xi0i7ve0QgOeZBqQKvI1M1/efOoNbJJWR0tDIIK5pUT4KetOxAT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(6133799003)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MibDWvnWDEoxRcz9uZjFZpjK7ZE+HBAtx9fdlFDccn+Qb7sYl65i+RqbvO8a?=
 =?us-ascii?Q?7uxQuoDBLtldrzXsfMqh4jOkdHEF1ZzQtXQ4CPpu/aDEPpkMcyhjeYzRERZu?=
 =?us-ascii?Q?7arX6hBMAdzIuZQ1dvhkF94SHx3iQrjsIy4TWJ/OylbPPZK9+Asc+n4Xdn2N?=
 =?us-ascii?Q?vPo+VEVxYlPhpEDGxUdeis89EIlqSRJjESt2m5IdRg/4X0+WWaw+D4nt0cMb?=
 =?us-ascii?Q?lYNWMbxYVQ8RT71vFw2+MW5DCt6Ld9hPT+HvV+d5bQaJIab8oWifb9SH+Rgh?=
 =?us-ascii?Q?Sojbj6wwZcBmpK5lB6/zkaJG8jnYJ9HnyHvRhvuQfW7ZGqSehxZMjs+XlxD/?=
 =?us-ascii?Q?hIutzAyBmev39cdC5De1Y9pszRa4VtHBXGqkotFCikOGlTOasbb4wvF5xRe8?=
 =?us-ascii?Q?VKcRGmatIFrrrcvWu/vJm2snaTcQ1j7ReFisZOskQpfoJBIXUpiimiYIj0EC?=
 =?us-ascii?Q?GrxTW5WE6iv8vp0aH4uthyQ7Db9cB+MkxbrgIPN0Svb9v0eY28hFrjKJ6+MP?=
 =?us-ascii?Q?twa2NQ/JaKWGkRItapQu5ywwpLOzM1LrVwdVFOVoo8Nck0CXf4LgDwb3AQNF?=
 =?us-ascii?Q?WA5+aor4lPrszkA9qd+yl/Nsx8iAMn7K92UxbGD4SBVcQ6VVJ/KqqJQnMkfZ?=
 =?us-ascii?Q?BWtwJFwdR2L2pLPhueFCi0g3EPHcl7fbne/a/2wk2WV223lj713q1B2Decon?=
 =?us-ascii?Q?1LU8C1h0l+Q0QHhSFWIYKehA5QspUDIFPJINIL4WfrNC0rB+jVgcF/4Y0b9j?=
 =?us-ascii?Q?JtpCvAdHOrnUBJC14fSPV4QTmkzmQxHOT6HiSnxMSgHOyy4aZZj2RXuUgbJA?=
 =?us-ascii?Q?Q3WkK7HpEEHtH6ZwD6rkqVT6GcNJrIyzZ/zXmLs2FLdIfaR6ToKpLgdyv268?=
 =?us-ascii?Q?ILaQOn+8fnS9X+A0rB9CZj4iW0JGZusEYok/yDqIODZ/fjSwCXsJ2/h1Pee+?=
 =?us-ascii?Q?c/XixLIjbwubildQBIUiWlnsMcCD9SQHmTfnJy+o8vno5jmIUk4iWQ5w5zvH?=
 =?us-ascii?Q?UfLfGuKg0k4GqFWu+IVb0eUj6XRJOZFKaf/9vYAJOvuVFMDXOdULL9AlMZ2U?=
 =?us-ascii?Q?DCKlz9Qh6wtZ8Se3PVL17Fy6JhYMc3zDeShsibv5lYfi8AM6JdmI6TwgDMg5?=
 =?us-ascii?Q?bPrYFs+WQNsHrRhqNULmJ8SJfuuwU8Ok1OQ0cBr8lFjSzvYowlCVm7+IbbkJ?=
 =?us-ascii?Q?2DpjkdnTsFha28c4ET3/2EsTeFkg77LgZOVgB7CgwGf8TeEzKy1ez6/MXcFw?=
 =?us-ascii?Q?aYbr4Bkx8fgPLrMKXrmhGs6vAhPlZv0OkUFrcB/66xrawYVlHYFLaN/4JHeA?=
 =?us-ascii?Q?gVWQ5ZcGrcMlRt5j9EtmS9qoxBbIAjxLc41LdKCo9RY+EQwEm77nyGJHxiqS?=
 =?us-ascii?Q?aSOfCqzHh/Hpa2zk0JvLbvbOfkNH8xkGyoGDHcWUFIm1XNv55Wi11A64DTGK?=
 =?us-ascii?Q?eLb6SzPW0mXLU50U5XjhvBtXP73CC8v7n+7+7mRFSfbEuO/czCR9jbqXVSO/?=
 =?us-ascii?Q?wChFL68Cr6TCTrxy+l/mDsEJvH6HvTGB7aziSwpZxASv7/yQlvR+i8KWRX4m?=
 =?us-ascii?Q?kSIrvm0OwCfz6QeX2ZFStXaKcteZY6IPVymUlj7US3g14sur92mfrUJu7iRR?=
 =?us-ascii?Q?Dvui8tK4F8tZOonsrUGgGVGGSQtASgHKUmouosb/iZyO7+YLif9JJS5JMXnV?=
 =?us-ascii?Q?JANRExc9TqjLm0fdgUdx9605E8znQdZhJsWIhli2M8yxj5ltHHDNTOfSoPLW?=
 =?us-ascii?Q?hkzDtthc/ktnx2azXuA3xHOOF1tbrCU=3D?=
X-Exchange-RoutingPolicyChecked: AsVZmMIstLa6FIeI0lJxXN0YvcSX+FiN+6f5lnREiBPAidmqqXDv5ASwQY/qCa8KISwR4YMIwEaR2Wcq8E0hvMQnf0b/ay4ieEF7vYIwZx01BorN++D/ZW37IBPPGFvPbHSzoglniorFwDyeWQHdeOS//8UOGbtkWZUVoAtBAST6Qllf3MpeWuyaZ3U15x65A5zi74qXIib4vNGHahs7FoZgZ+iGmUr3IS2ZNmqaiGK/nuooObf517EADVg82UbDBSzzF3n8LhOgb1FoauLpxzmtzRGeBYe84sG+Y8SUn0B3+XhPnVdEdz8fAPG8eAvWuIpVGnXrQz1BXxQ18fsj4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9605a610-ba17-4168-ecc1-08dee8aa6cac
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 11:06:20.1687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66xGBu0ZkXyxwwF8PKJ/0fGDEN2Hisa/dWGbTK6X/gGfeCeSTCzpcCstlwjqXwg5UI+JVdg6MTqOee6fhTFw0k9gxJXUwOP/ekybbJbdXeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9917
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

On Fri, Jul 17, 2026 at 04:33:37AM +0100, Mandal, Anurag wrote:
> > -----Original Message-----
> > From: Mandal, Anurag <anurag.mandal@intel.com>
> > Sent: 16 July 2026 04:23
> > To: dev@dpdk.org
> > Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com>; Mandal, Anurag
> > <anurag.mandal@intel.com>; stable@dpdk.org
> > Subject: [PATCH] net/iavf: fix VLAN offload when inner VLAN is not supported
> > 
> > In Double VLAN mode (DVM) i.e. when RTE_ETH_RX_OFFLOAD_VLAN_EXTEND
> > is enabled, the single VLAN offloads are programmed on the inner VLAN
> > (0x8100) engine by iavf_config_vlan_strip_v2() & iavf_config_vlan_insert_v2().
> > When the PF/hardware does not advertise inner VLAN offloading capabilities,
> > these functions return -ENOTSUP.
> > 
> > On the enable path,these -ENOTSUP are trsnalated into -EIO, which makes
> > device configuration fail.
> > However, in DVM, with the default outer TPID set as 0x8100, a single 0x8100
> > tagged VLAN frame is handled by the outer VLAN engine, so the missing inner
> > capability is harmless and should not fail the configuration.
> > 
> > This patch fixes the same by returning success when DVM is enabled and the
> > outer TPID is 0x8100, so the outer VLAN engine services the single VLAN.
> > Changed "qinq" flag from 'int' to 'bool' to address memory wastage.
> > 
> > Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Tested-by: Daxue Gao <daxuex.gao@intel.com>
> 
Applied to dpdk-next-net-intel.
Thanks,
/Bruce
