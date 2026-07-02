Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76304C43327
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C957402D2;
	Thu,  2 Jul 2026 10:21:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2561C402C5;
 Thu,  2 Jul 2026 10:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782980468; x=1814516468;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=o8HbAxO8C9i2yufLbx+JiEo7oOzJLf7PQHR89L5FOAs=;
 b=h3uNEIuTJfdvIc+Hrwx2vqXBgTLEpYQRXBgmWJB2yvOlxVWLQRGgiBR7
 t2OCZKtPCmSTlmP6Bds9K7Amy9HIiyGbyk2E5Rc+Gae7cm41rEbrqGQP2
 uZtIKoXbJmuGR7NSIOLhEd7KJRgL23PDSoAPhW6nxzCSVkvFOXUMZmolz
 USXeulsB6g/r0g5pEPmAVI0NJNhrVMYeBL6AL3fWPOK2TkCxXfzjEdyRq
 RbJRNQd1x/MN4z9AHYCwS+2VhNS0QFXt9m+cJyBV/6XI56/RC/T0JM8om
 6wHYEXdF58opuP8qhJE2JEqVAriZSEEnMCz7Sd8/ZecxMIe9DIegZkI0G g==;
X-CSE-ConnectionGUID: 2v7HdgDZTZyQR5kd0mCg3A==
X-CSE-MsgGUID: GHZObC1rQQGSpHaX/972wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="71248835"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="71248835"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 01:21:07 -0700
X-CSE-ConnectionGUID: 96X1i+mUSzW68RL02BTN5w==
X-CSE-MsgGUID: V9slgTvlRay6Y2YM5+Wcyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="256710695"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 01:21:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 01:21:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 01:21:06 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 01:21:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDw/qy/4FbS3Wp0rjO5JYP9DRIY4Hyu95Y72uz+v8ny7fG4FtEhNVJqNwbH3MEq/fjE2Z+ohgtwiwTE+arx7c+uG0bote36ffyGBK7AZUc49W+V+HGMFmOYTTcLHClPNzxGWy0ssLOOcIv6iRmMijN/gKBeFWR9Io3Qgo9L0Gv2IjLY1T3bkR5qJJeyu2YSWk1LyGBS9YdlBjZDw2uuXlBpfXaWu3Cukh3gwYWzzw0MXHjmQhrtr6cM+3zUkVfMrRxKX1DzmodPfbuu43F/ZCwDoZLbyvSJJThrwNB2BhrqhGc4f+LV/qthh7qsdt6xAm7vA82XzkiNSyjomM4Xy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3rrt/JJalahiVJUUk7Nk5sfKDNv2cbSOhIUxFe7/eA=;
 b=KZfa+QeMY5D/6tLps/Ngrt/xi1JMjB34iQz/ywjomhyRai042KVpc+GCKMfgH37d9SFMGHgbh8UkBPwg2L9JWgA3XBdJLlZRe6PratQtwdo1XGsk2qDt8+O5Un3w5Dkgz35QoPNjLKxXCtrxynevfyWnu5Ep+2YjFrR41tTmWdDrCWUsJXYeV8V4+miRfIs1zlnMuYrM4zGz1bk5331v6HR8TuWjsz+2sBgLnISzgJN/bz8HCXPCvH3WQ6A5Z+Gx5QUGD+4IF3ZpY8HXYT1qNmMPrGnJXmqMjxsmv2yXOxMlaI9DSqRFNdhqV24P8b9iUmfyHs/3raxTJaJL60ViNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA1PR11MB9874.namprd11.prod.outlook.com (2603:10b6:806:4d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 08:21:04 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 08:21:04 +0000
Date: Thu, 2 Jul 2026 09:20:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix QinQ handling when only inner VLAN
 capability is supported
Message-ID: <akYfa2k0x66ejPMO@bricha3-mobl1.ger.corp.intel.com>
References: <20260701230858.436510-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701230858.436510-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU2P250CA0026.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::31) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA1PR11MB9874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa4ead9-f2dc-4506-9c75-08ded812dbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +JDGnCLEGDesYcVdP/YpskvfUO1sKUMgxaa/dvYO8s2g2U1bths5387rQtSUn6d5uAaFpvLl8Pg7mTwZmHaP9NXl6O+6Ag80IGfDpeV+cqdsYNv8i3aj3Ph8GmFRUFWVgjm1CEbLjzgIUiFXu9zKiyE24a+V9ov2p9O/b1HB/UZDYRQmpj02deYY4Ye/XW59sSr828NlR0qe5mwKn+WXZq7zn32kwYptM8PrKBP7fZAx8z9B8cOxRlUCCxTIfrft31a9tembhyC7naFd2sYHUVuk6tghJ1asSvKaup4VRRiX/bvEYe5tjXxTTy3F0yayOxf5A92aeMmgVjYPjybxkH/AY0+NjONOXfZ5HHWvasHMX3rDdYSphPuXuUFz3QAamYHqHbqoMtkB5Q38AY3kd/G1OcfA0lWc4Ec5BUIYaSfjGB6dtafYUZCjjrUA0+o3Cs4ndPmzRuGYdom7pgkHHM5xZswClbC5UULHjBwl1pdlcGujEh/OjfOQ7ANBsmIaRZlJ6nPm7aobu7LZFLMOn2/lG2BLHl3Tpu094EyAtfF1nSwtnO/ptC3Cpzg/aDcczFICp5qqlFKtx4npXpO3KxJcnMgPFc1NrdvPRkkn6AEm0RWcN6yduG9lK9CXqzCGQOSiRu3ujVDMMCgTGBSzqh1F1gcNT0PlsnbuK8QKavQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPrt2YB0IgQ292rRloT7p8xMihBC3xoBiEfGhJVxowHfmvUW2+tbCZF+GwYI?=
 =?us-ascii?Q?3D9B0W61OBOrQiE1sIJty2shyVJx9qXNrdLEFhzVo1dQwdTBh8PZLr5t6GD5?=
 =?us-ascii?Q?G6wNBTBU6463tjU0QKjdh0Fqu00eu/OrOFh6jyS0ypC7JyPbQlbOf5ss5y84?=
 =?us-ascii?Q?h6BnPTl6PHVh1ylWrPQxRUiiNz5yL4aW45nsFqT24vN9VDc1hsiItMt/pMXU?=
 =?us-ascii?Q?MOquB1FXWHz4e4GzBJli8MSXgr4iHQtBOfu7EJQhy09rgUqwIv5eWnc213pe?=
 =?us-ascii?Q?OOPVM9unlSzXN9rCCfPV7hemXlBSnv2WndvMw6yW6rxPfgNbXSrZdDtffOA4?=
 =?us-ascii?Q?Oo47MgvBZqRjDnseLTs7xZFX41eGKV7jfuC72S87TX8tuYWnskTdX680EIQI?=
 =?us-ascii?Q?A4fPROL9rNNbEv12y4eSsrm8mkDaAc25tRfbMagfPCpZnYnPu0S4kl2tVzdV?=
 =?us-ascii?Q?U4qMDg+WWMkV6IJvk3hKJk+PKdKG+vyG3iolKNuqcVjU76xsl9sEJy6rEIoR?=
 =?us-ascii?Q?1roC5wNPRuSjgLQ+sp0DZpN0PtDGmVvql/PCM4fn5Ru1tP/f1kCvyclPzYcX?=
 =?us-ascii?Q?i0m0qObkz9zDIl3OqNW8NXS5t3WGJnRIEFsGsfVglJ0zssamXUXAz+NNF6YK?=
 =?us-ascii?Q?y2jic5mjnz7IeX2RRQr8Wi5MoDWYX2CozLI4CQ0g13G+tia6Pz/psxrKhkHC?=
 =?us-ascii?Q?sJBOpFOu30ucROTHeJz3C2yA/oUJzriUSQiIDYPnKAtiZXKmcGSp/xk5nJgN?=
 =?us-ascii?Q?GBDTiaCrOxe/HDCjNXRQLZdmrarhN3gPJFjDvwSzAI37tK5qWit07XY/3Jj3?=
 =?us-ascii?Q?nvIQtPikA6ERARiHAoATcP4uO8J9s1/bd+ZuSJUEQrZUQD5vKqVKr37Tx//M?=
 =?us-ascii?Q?Nf+gqiPsthkeEidWQjIwQ0cNE9PUULpiqQetdofQ7CVJQ/7SVrnVooaCx3Kg?=
 =?us-ascii?Q?opQGDQwr7yBkS+z4m9p8YBHHyO6+1rUU3OwMP4qtUjNjny28uQ5x1R+YaTTC?=
 =?us-ascii?Q?mjym1ZfLj/nVMzks816BI0uj0Bb5GFpnj+Ps3ipHiAu1EXkQftQFnILeA/j6?=
 =?us-ascii?Q?RCuKAG1qMYK0A8GCoIbZRUQpnshcMNCI1+pgUkTkjA1twU6rivmb33sOC2zg?=
 =?us-ascii?Q?8oRQVf6As0F7bU5BvjcoPoxKBYaHede6dhGbQ3KCNo2rfoxdzxUTRs1B52pd?=
 =?us-ascii?Q?MtLOQLS+RCfKfliq1RxtMBuk05MNH+RMsEsNCqbVJmg8U5teIXYsjFH291Yk?=
 =?us-ascii?Q?er0YZHkrXRpgqDCr+xjY8KWFXbAzQx82SWZ/aAB4kLxXJ9gcXnuiuidgEWbc?=
 =?us-ascii?Q?TVF0+KPeDZmrsR3Rl4YHN3whyH+gVvvb3bk5gs2j/LhCd415i7pLX4skSyh4?=
 =?us-ascii?Q?6GQ5z78ndcamTAAbeFTuZg/scKL9Yrq9dilN7uLw3yNUVZGLQZjs2MtHfrGh?=
 =?us-ascii?Q?6zQ3EX+/0cvP6CYL6JnoIc7IU5u0TtO4ShG4XpqVF1PMVRe9zgI0LHp7qa/Z?=
 =?us-ascii?Q?uZAAz5iTYmHbmiZGSUaXp09Ya2CAPa3AekVAna4qRh37Oaw9moYtfAQT5LOc?=
 =?us-ascii?Q?ZJ88L0I3FAa8e+pbFZ4F4mcMyD+EunOfiBsE6RuY7wZ3P0MFp+532GCohIcg?=
 =?us-ascii?Q?ncSQ2MOeokgqt7pOqFy5N8moKxw95jkAuEwjAbgrAAhfTqK9TxrvxXbz34lM?=
 =?us-ascii?Q?KxdigqH7qnqTdkWyMUKc9URWtU1r3MVvE/mZE4EJcojA2ySvsBBjUwHiGr5x?=
 =?us-ascii?Q?HaZgxp1irx/6oogB4VfGXAwEF0R19uw=3D?=
X-Exchange-RoutingPolicyChecked: Jx3N0lN9l/6ofGsFfhUtH7wTmBsCiT7hd+hILUVGNEwunx1lxxyDR8tzOAO7a6w9BmNPKoCBjtWLbqCvpWDw6uuqneBD/6tyf277DvDJxjOtNWbvFIo62jqFTDk0KWBCMO1MiStpbiFY0NzBBUstawKCDiDNL0d/mo9s1ndfccXh+PbwXaDH94MM36+tlQW40m3+dJoxQmljEW81c6vOjxBfal8q2khpb+08ioZVVWZmcz+vwN1Vz0xjczgLZhpjd7COX2nfGa0Q4LltULMORlWO1eaXTQlhjhOQPraUj99XbVpnUY6bSWKjVON02QixmrJhiE7d0+xwWqMcD2lYAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa4ead9-f2dc-4506-9c75-08ded812dbd9
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:21:04.4628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY4rE6AqS+BFf6zhEMc/CaC7v+4fwwlAiDC+tdiq92ZvdwdB9RV4lDwI2dHVgh8gLisQTrRVWKr/GZ9Tewwbog10ucbrdmMseKK8HWiZFEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9874
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

On Wed, Jul 01, 2026 at 11:08:58PM +0000, Anurag Mandal wrote:
> While adding support for QinQ stripping and insertion
> operations, it was assumed that Single VLAN
> operations are always reported through outer VLAN
> capabilities by the hardware.
> However, it seems that Single VLAN operations can
> also be reported through only inner VLAN capabilities
> as well by the hardware.
> 
> This patches fixes the same for QinQ operations.
> 
> Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> Fixes: 7ce1363b424f ("net/iavf: support QinQ insertion")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

