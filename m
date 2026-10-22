Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E8606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ku4Pc1aD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A0B940264;
	Thu, 22 Oct 2026 14:58:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id C73664003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 14:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792673887; x=1824209887;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rpJitttIh5LSpfMyFJhaYzclzlRf9UuHpW4Bivalk0E=;
 b=Ku4Pc1aDTyJ+I1PVq1GufIYwApcgy+1auDAT+2MSLRX/PgjdAYjwzbmz
 426dYkmvrflmarnOD9AP7KZvbbl73415WdChOgjgQWbEAgU30l0vt2GQx
 XtGooSXkbcnAUEVGI5DyWT/cHQ/XPJGoEV0rWHvjz6lF4gxG0WrT6lBxY
 ATC18mMzkzGoDCf7TQ1BIdJVjbkn0QZr7v6xnOgpGQCqia4flBeMb3bxc
 AerD1/9Wd6wN9NU8i6vAKBLsw7AimR/ZkQk9jaECwcYxGmoBmncw+VGEY
 EpRQuhIkN96sGO2e6znbu1J8r2LyJ5nntGgGg0VoiWl3mFj66FdhnIV/6 Q==;
X-CSE-ConnectionGUID: 5RJt/06iRXCSmx2bz3l9mw==
X-CSE-MsgGUID: X6SkwEA3TqOr+0JE2RiFDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1297425"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1297425"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:58:06 -0700
X-CSE-ConnectionGUID: ymYRqb+uTuWmxw6rsFbU2A==
X-CSE-MsgGUID: /xtK2O7PSqqM0MU9q8FU6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3237009"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 05:58:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 05:58:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 05:58:05 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 05:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEpSsJYR+NjKtFbRhYB91UjnmtMDTPsZyPB9iXyxmpw1124Yjfh4ByvdsHcQnYB8dV/ZrhHrIjP+iCK7Tij/y3dfdxuPJWEquWG3NnlXfMfjmbzeOZb0dcNlV2j1wW9x+V/GboUlaKj0/LqCwGLQt5pejNLk7OClkerbj1VXUj+qGrKVotpJNUi99fdVO5fip8AAJSnmXIBeQ/E+V0QqCDB27Nhfu+TBu/6Mo3AtE6mJqxxEn4u8nUTAQHDeggeo9gFF5FwZ7M5rhTg25rq0z6ky3CvOWg/vOIfkVeZeEQQFk9h0GZwjANyf1pRb2aVYan3MFgE2Yk2hvVG7au/Nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxwaV/JASzPUS3fi/6L08Dj8Ye8vL8jXRlRiXEaI+FI=;
 b=Y8BN0gP82m+59r2ATNackslPDaWeBnz6uKv8VOt1jUMKaCTZmtVBj3AYEJo/NXKIrqjPHApnmUyHJbexZhSO4lcyidBIcnCfbQVuIes6WREtmO2zHlXJZNRTjmfJstSxa0TsI6KvuFpNbkydf335W5bbc2QKBAs4IeiCLHk3yVqMEDFJ9EBPqIh2nLWCehq72KHhUSBWOxWhgrw29t9T0inKH3oQz5UjnoiLmmh9qjh9513FKcdQqobwc8wyKRMtzwjxD+vBma0zt1He/M1W4Q4Pbz8YSqNtIBBUPt84pBWQ9xfFktLycJTmWcONPpyFBhUUSSeI8p1llHQkxghoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB6497.namprd11.prod.outlook.com (2603:10b6:510:1f2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 12:58:03 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 12:58:03 +0000
Date: Thu, 22 Oct 2026 13:57:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Qiming
 Yang" <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH v4 03/10] net/iavf: fix false success on flow validation
Message-ID: <atoIVtc14Y8dCl4D@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
 <d541e9890b27dfc0b2d524d46133ddbfe3523cdb.1792592724.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d541e9890b27dfc0b2d524d46133ddbfe3523cdb.1792592724.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0319.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d1285c-d60a-4253-157c-08df303c1bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|4143699003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: YcZIu3QJTDlMT7UhSsRZi1vtatYuNUz7zN7c5P3e506Ik6f3IIGPXZo7uW39hL0MSFIRzNTHTPo63XFHUKQftAMsNEB3J/EEkWfg/AV+iaCZuniKtVLKHKovwp4Er7kE98kh1j+k9n0JZGBHlIPfclgQXFlxPqKcJMCCDGMmB3NMkqvFLzcfCMcv/pHN14T7fEGEma8/+XGgVHnsov5POkTgLTXJO82bQCLVBzV9MFTntmIxCAUVtheC8jNSlO4OJJDg5hfVWwDfq4L5jh11mIZYZozfQjSHURDRhUiioa/L5I2UyZ7c3j913VNZibZGHfszMdeJH8PRUzF0RPlyvM6JPat3kOKwqCwkxMcKZU0N4wq6YM5oc5tROxD+FsI1DPVidfRlUhaubPmm5jGahuONdEwyegRKheMpUTZ7rnlKARTcPraOloI20Q0Jrfr96yxz4hycsmNAYQ51esbtARzcARwqmmFkG9JM2jQUOdN8hL8im/zmP1vRZzFd2D6+pBOxUYN77fmEdHQooK44DsdQiH2f1X9VkG05ZZIntpi/LhGodwkE2xS3IEMYiWBCZxn/MiHd6oVkNrKxMonZs8Wmg/2V/NkuV7vssTQ7+IBzgu7+5W3UUzD6Ife3miQ+a1FOyquqgHZJ0DagFb+w7/vo9NMpEi0yzxu7fi3kjAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YT+kft6h+pM5yTOzJMciydd0/djgZCmgeZBMz7YhUc30eXAe9q1gM4owJXK5?=
 =?us-ascii?Q?630l4lJ1kv0JnJdkjHa7H7DhP3c1VSGzit4aJvREUQOnXE0dxNBxc8qzIpIh?=
 =?us-ascii?Q?S5u87UZtsjS5T2v9ipE2RlXJGtUMVRtrhLHbL74QoTTCi6c9a9Jrr8akuHjs?=
 =?us-ascii?Q?0kmSBgyPDdSKebW4oIn5Zncn8XiE9RLxJNdosyP+8P3yrmivMPswRapcwkcb?=
 =?us-ascii?Q?KqmAbU63Q8Ag9x+pv8I0ri3f3zBPo7krWb5USwmb3sD7VKZUcKgySUUxavHg?=
 =?us-ascii?Q?3BQHnQJEwj2oAhwTc9LMewKKaZwCYYB/AvjXVbUNOgjezQfdUM+K5MWURcw4?=
 =?us-ascii?Q?HzDPsRPo3O04KUWIIjreRDoAkYhYqhjnDGtJasUIwNhrjsEFir4qq1jUkI8G?=
 =?us-ascii?Q?zTpDHlkkTDqkcI3jJYzS3bQQhSOQM/AMvOeIsmcDIhZqv/RmmOShBok2NIfC?=
 =?us-ascii?Q?XxFTw35OzXikh/rAvdttOXW2kvD/u4m9bqDPaj9n3ms4p+9fGNvDyDTdDlsG?=
 =?us-ascii?Q?sbWut6b2d/dHkFkKNoArvL4VYJGjLrzyBMTCq1hYi6/TNP6bjTfecoYW1rmp?=
 =?us-ascii?Q?yggZyGfOBkSUFxLSyTbz12aBlrgZsShuu9jdqCL522IrB9neRXZMg2Ld5MYr?=
 =?us-ascii?Q?qiLK4RgKIVjhuwyCg9RMvA8Njt5h/Dl6/rG8xpI+59V2GbzeLTrin6irINjP?=
 =?us-ascii?Q?BzZdqljKWRhSViE3iBCUZ7+rXNOZUPJsvfPFowuPzrfWFkozHDnZ8SpgGGJ2?=
 =?us-ascii?Q?sTNS/3UHYN8qoJ1z0szllxDYu3Lkdcl/jdg/7VaUkec3inaBJsK9cL+EtVvW?=
 =?us-ascii?Q?krHYvBR+F64jG/oUtYMwbUdmg1evx+nlP8qawF4QeNlNAGh2Zj0g26J+9kQ3?=
 =?us-ascii?Q?u9+IA/nyojGML/63rprD4Bi2kTP72bk4DrslMK9zJR+6s5zabhUfohFfnOB6?=
 =?us-ascii?Q?TWQzo6zcsHaytstuuu63nRyOkajtgnzIUMuL+05ZDCBDX0s0bADg6+hKCeD+?=
 =?us-ascii?Q?CuRbcR74YISKutuJnFvVsO9yTpCIiX7V1iGxr4JH+wwlXfCF8E+HdtQ0TgEO?=
 =?us-ascii?Q?FLL8J4zgA0YDy2UBREuAPWSNnZUlaaKgneX63Q50xyhM/UHAesT1PausSps0?=
 =?us-ascii?Q?ofSs6btQXIrSrLct7ndOjRTRLM6BHsHYnoRh0yvXfqzheywzBOxl+MS7mceT?=
 =?us-ascii?Q?E5+JxU8+NubGzstWUieQseb9UWLa35tqYY7i/wKGlzwgbMlFUISzcDzhr3mY?=
 =?us-ascii?Q?aLs/lnC5wzb0rU0PWMpVf6jjhdHRAp9zgSyjWnJp2/QgoM8QDdRAZ5Vuj3hn?=
 =?us-ascii?Q?D71J+J84cs+SiD2yL7G2yyffCnFrtCXw8orUPq3QvMyyxe4zSXdKeMVpt/SN?=
 =?us-ascii?Q?D331X/N9Jn/B0DqrUaYYLSx4Usjc+qcVGoitC8nPIywtPojOCVcfJnPWYdy6?=
 =?us-ascii?Q?Z5+wv7ZdTLp+n9l2zaJrrSVvWOu7Ffr2OkopVI8f/zrBWNyJKzTmrFTIUuid?=
 =?us-ascii?Q?/dzdFQWIrKd3sJI6CmVtPyxnTXY07lA2WQvQAMVuvSa9g3OYVcAPR+hZ7TYc?=
 =?us-ascii?Q?Y3G7YCd3aM6I8mCjwWg9YVLJCFQiZ6ETo2w/TGS8UZlWnBRHBLoBzB3T/j6t?=
 =?us-ascii?Q?qWScWUhVF1usQac3jB4sDmxJ9FOZ0kTbajk2Jo/rM5vsA9zF3j1dG/YPCs31?=
 =?us-ascii?Q?Jz9wdAbfVeVmWZ2hsM3qJij5AWXSCaIMB2/f/+YlIzAX5eJ2oXYRGAsr3wGj?=
 =?us-ascii?Q?4dzQ5QqyV6ZNhGygePylXSNuxpzCwbI=3D?=
X-Exchange-RoutingPolicyChecked: F64GOC3QkAKPM+7jPAGU/4GL3LTBvxb1L9Y2S+ZGaJXrs4VhEnQtxejHLLGLQFWtFls1/MhZFj5h+JG5aEC0YI4riaLDCkHfHFlJX1YquqArj7jgZGNk4StCo/TxH+eEruBVBQpBFAf/OXyq8ayOVSc8H1ag9zveYzMilLPfiQrxtpxAeOKrfNnxLP2vvxfNh9ZyZwmz8TQ3TuwhVdLFAx0DuGFmPKQt4JTIX9lgWxqw6Ztk5bb2maGq+pg/AqPnZZ1OxEUP1nQhyTFEIESwLuOP2kC3FFJ8+dqIxkKTMNRCps0o4bSZd7+dFb1EJ26qQPQZLN2z7AKxpspLA4lmiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d1285c-d60a-4253-157c-08df303c1bc0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:58:03.2879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0dUcITtVC8N+SZwO1wGMxgEgfcIbRu3afinqEeDn67vWIcpTPk8A1VtkOlI1seYdnveqrmwB4LdCVsdSryzIYzCr6ImsZR0+Hq1hQFZnMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6497
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 03:25:43PM +0100, Anatoly Burakov wrote:
> `iavf_parse_engine_validate()` sets an error when validation fails, but
> then returns the engine pointer. `iavf_flow_process_filter()` treats a
> non-NULL engine as success, so `rte_flow_validate()` can accept an
> invalid flow.
> 
> Return `NULL` on validation failure and return the engine only after
> validation succeeds.
> 
> Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_generic_flow.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
