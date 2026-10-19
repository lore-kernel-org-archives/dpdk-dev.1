Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F64606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kCsD7zU/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC5B740297;
	Mon, 19 Oct 2026 18:47:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 438C54021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 18:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792428437; x=1823964437;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FTuBp48kplrdT6nbeBSbkaBYn7WEMsltCTVPsB2PWHA=;
 b=kCsD7zU/yCbz1z8Md1nV8lF3FPiQKoU6DKTBdDDH1h9YQV/grKDTR5oj
 lM/sV+vuATeauuXoLZ9B0cYeSLybq/Mhh3EQ5IOBAeePNfiGzPKLN1ZxU
 94vOpd5eCJUT6Ij7dmxdkZ/1WIQ5oy8jIKb74MW5YB/jlKTquZtxFKUL0
 I5mBzbAsQW/gwdodMEJLnvOLauOdNHv2dOc+EYuqzfQz0go/xh8E5yA/w
 zBumnRjkfVoeEs78IPB55YojHJ+RByASVuu7dkfsCYot4+/4s/OiUhGg+
 w1Rt1KkalYLX7SGu/1DeqB27AUArdqI09j6m3VYu+VNiLxs41tgTCvDZv A==;
X-CSE-ConnectionGUID: 3MH3D+LDSQGw/2n971nl0g==
X-CSE-MsgGUID: DEQ6F8p5S2WMiDMsuFMoKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1130914"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1130914"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 09:43:51 -0700
X-CSE-ConnectionGUID: AMFvAOLmSR+ZnLxK1+bCAw==
X-CSE-MsgGUID: ibZ6TSaxT2K7E1zdoQyBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2638424"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 09:43:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:43:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 09:43:49 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 09:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAnXxgl5/f2s3yMYMACyDLWMVjhZkDRI9Zr7uMZXb2EKBKG6zM5Jqc1CrJqQ4pH8CKrdU1G2yAi93Wi/l7BWDk5SXWV05BKAHEDsana5IM7980Ffv9OCo/0M12rw7WfyYaEc1RcjaBf/X8Tayh/XX6yJOt1A2rWGXfMz9/KE1/6eb/17XQL2YDiWrovrBlUOyU44q1m6l6h+/xQVjvLzpq7hZwtft4WCsXxOUFVDeBrNZ58Ek9nVagaYSEd1q3/uC4yVBSiTlj9PL0rC9kDPePsR+Dlli4/wzwCJQZMjYYFrqwK1tkYCEsoEPH7E93+Rzu+zNjbWP5QbxMrYcmlB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KX50Zl5SSGGnicDnZGabG3xI5nJinUAPU2E5y/JcGE=;
 b=olNsylpC/UaIkww01tt7YZIzyrDp8dk0cQb4Xo4yUkNvg/nBOFa70wRbqQ3ZK/5m8Z4ru2Aga/UDsqk8d8CUzSBsUBGLjL5WSrV34Jqavwz+OFkjda5+8E2uc2IS94FpipAQlUuRkWvQJX5Oy2LgHRE8gq0ACUVybB4IZQEtJSmBNCJTTphzXCg2OMPjh43buQQy/tMcDXw6Q0AXarWmjIQqqxIa9C5zf+WRiWZkBeawXDZbrW+qG5aFRhHWvTUOQmuckKOb+Q/BCnKwoHMo1CAlcrfeXm305U6jPrjtlnzrgWjIXyVXcGshevdkdR0V2M6Kd0SZ7iQs6mA4Cs0nGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS6PR11MB517798.namprd11.prod.outlook.com (2603:10b6:8:4c5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:43:45 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 16:43:44 +0000
Date: Mon, 19 Oct 2026 17:43:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Rob Peters <rob@dvbcontrol.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Thomas
 Monjalon" <thomas@monjalon.net>
Subject: Re: [PATCH] net/ice: add chip temperature to xstats
Message-ID: <atZIu4mH6ciaOG4i@bricha3-mobl1.ger.corp.intel.com>
References: <787e4b6c39fcb1322bc92f8bca1153d31006a3ac.1791550671.git.rob@dvbcontrol.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <787e4b6c39fcb1322bc92f8bca1153d31006a3ac.1791550671.git.rob@dvbcontrol.com>
X-ClientProxiedBy: DU6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::21) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS6PR11MB517798:EE_
X-MS-Office365-Filtering-Correlation-Id: f9449f5d-4906-43bd-532a-08df2e0023c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: asRPp1/AtlYu2Y5H5bQXip/RjeOoz/+cqVxa3KBcS6YwtmO+rH3znitQOgsFFUNKxt5RPe3CLjLJq1Z5xLAvXhInBEBaRxcLjIcUfu6DSUKwkXqSH7QKS5dqsFf3s8khaWgW9cErvvWnHcNsDYUDBqwYdFcxF7eaYok7emQ1EKgX+38H4uSEx+m5fQfeidP6rPfv2dWv8FFBGgBVzBIrXSy5Tqb9uuglkAJXVTMyK9JWdlxi9XlIYS/KVmL91bJgCygC+3KdlA0cQR/hKlRqPYf3vWJNrxv0BeRbcfR9WM3l5636I5tpY/Jnfeogxz9hr+OHatqi6HeVzcVrhDvFbB8yZoLLkv5ji+9Gtmmydv5rbwOf3pYjeyPe/Sej7vTTDlPlgRiSYZhA72PcguKslIVr4V4THTAmG00rzPf35zRwWilW4DmlDsNKw9+iZeXeGExlZltb8k4IN3usP/nIWB3yUBetvqI5/qYB802Y6ChaIAKBKQoDbaeno/wng6857x83CQzRqxKW7makOQOxssYUfxSkbyWqI0UeD0kViLXNZg246rK6/X6kazTztjULxwHShpzE4mGs75brBlLsXd1+lumiOj8NlrKhkNn+xaI+FZp/KAfIHr+V/eqm8+PHG+/VfA+5x2u7O0/rLje3mme1CqjOho0Rdi//N2Ww1kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdnsxtXlauo1Epn6dHH/qwmua/uJW0/pFBHA2mOkrV7gEhoN7yaXtPNRQE0m?=
 =?us-ascii?Q?rTeTBn/7ORomRvYRwHlgPNqUkOL/GUYDg9GKJpp0w6G7WHcg+2GalvlvnJaA?=
 =?us-ascii?Q?yKgQGt1YVcMeXoH4riyXQUB0VSLnEqNDERp+ybOPDedKWFGcR3zsvINwSHuK?=
 =?us-ascii?Q?m3cFG4kFH+uND6E5q/kvmG7et0kO5b7RsPfij29tplfNrLhLUlAzG0FlyPPN?=
 =?us-ascii?Q?xuPCn/sXg8QPfKZkIFdCSsZF3nlsrij9o7p/twdOGE+C2FxEWm9jzaIxKmvS?=
 =?us-ascii?Q?yx93HweQFnpCSXsJuzj1AKwn8dsycAXiP10VURnS4Yh/R5TF3DMN+pP6kpu6?=
 =?us-ascii?Q?p0L+yjBXnX9GaFEdH8eGXU9TfvwfhABejsvGjeAZaShity4cWA38IF6/4tHY?=
 =?us-ascii?Q?1CInj2yS94nwZyO+Jqf1ZN9B78qftairQvtPdA9xNDbDVKBWJGh/0oO2yUsY?=
 =?us-ascii?Q?YxkeruFP8G6cVLSqdYB4MbDptFF2TT8TnKKiRAKfGgaxgOHvV8kuXvDQdxv0?=
 =?us-ascii?Q?6UQ8BBH0hmsVpmiBhLAC6c2OwuHWXIKkk5nd72qxC7Jn1kInD/aQfRQiA3wT?=
 =?us-ascii?Q?G7aSTy7dpObJHTtm6Rvh/ezKwTrTupAyZWgziW6Ar95uP7y0Qe2yp6sNJJCi?=
 =?us-ascii?Q?VCtq1KsB3iShCiqFNvHeL9Fu72woodl2xZ2UMNMJPUf1PzrWi9W+XwEUofjF?=
 =?us-ascii?Q?TYqrRdWpRH3flEnZA8JMk7PLbdBYUMpW9YhSsegNqVh19HoQKAkavYqDxiSX?=
 =?us-ascii?Q?aoys1x/A26c8WnhlwD+/+HApIlaVsq4WWB0T3zDgoe+4NAZCBVaEYG/zV46n?=
 =?us-ascii?Q?VieIQVWhX9i1x0eqOfl6spa5H7ZnyYpLgL97id5+DDlrb2tO7JZvP8Axb9iO?=
 =?us-ascii?Q?e7/ADh+KYhu9ZazCYvWmF/hHnZB9HONWJFui/pOkG79jtEE1U/q1i4Bkl9++?=
 =?us-ascii?Q?8EyF+BfYmek36uDgWnyaUJrtHa1ZqABAiIaAatq4sH94i2JNME8gm8zk+8rY?=
 =?us-ascii?Q?V1YKUgaDoPTNROfoyirt9CYj6Kl8RyFqiCE3ynHmNbZvbOag/2o1giPJWlT3?=
 =?us-ascii?Q?2m9FtoGLILUHNjT8kpqI+DMxauP1j8pegJPvOyo5+9CzdjAmnCVnpSnObxlb?=
 =?us-ascii?Q?5d2qxUUhEc78I1yqKbdjC8G9CkqSK7ljENkEx3dmjGXTDo5fFSBvUlPXHVIa?=
 =?us-ascii?Q?PdVcYJLOXPftCUMmXIOuPKprFC43u+WVuwjV9YXRtpQl7T9QzS/ttoiPyAFd?=
 =?us-ascii?Q?IuOuyu5hKR2w5LGUE3BcVZug/OAf/KZG5ff85Z/CACfV4fx51+5ndOjvTZTX?=
 =?us-ascii?Q?P2oZxR2purk4UxVoU8+BGiOuYxzsZ2qhLFTk4JWHYAnetMGzNfXTXJ35hkWR?=
 =?us-ascii?Q?varFQnAPInINx5piSQTIFFqdhb5s1Gq0fJcnniE7r9NxpaeMBw3gSw7J2Y8c?=
 =?us-ascii?Q?wmakDLe3YBh1ujtGvhMuFGP4nnXAwVTsnWrrBMqEBrHQCj6rBUDMJvC2DKUP?=
 =?us-ascii?Q?HI0RI0uLnljMWhqHNVc1ajKOO9n6lEnTNrY+cTEFUt5lrF/8U+D1TnrtBgMF?=
 =?us-ascii?Q?eAz4brWSqxpTZR6UbwGGUaMtYDkVFM7eew8ZhLAeEQxQzoj+LtiCMx+5WxmX?=
 =?us-ascii?Q?GOJ6mmSemlLY057FszhF71qXNIndBoSiRbEpma4zcOUyGB5t4BcH+HE6kQrp?=
 =?us-ascii?Q?OCRjrL/0COz7n6mP0WoDGZ7O1una92A08yHttclQ558K6irduo7WnozFiRYD?=
 =?us-ascii?Q?rP1o7fZtDh46fjKD0nO2ie2l2O3AZTY=3D?=
X-Exchange-RoutingPolicyChecked: 3wP2ePHToHY0NZ6wCA5bqW2jJhRUHlOc7gDU1evhd+AnPTSZKzHfxEqcY7lHcT/QMNuLH8PdViIlWwY4yWfuF03IV2lH8880ZH/aF+jsrLY5gGm8S7Y47xdzodrD/6km0M1SmjP3w3u/3BLyqGegnIh98tGsFHIhNrZ+hhMoHFyyjRR5UQKZekXWTbZ9C/3g6nRp5ZWapsvbk/LXqRbseM2iA9EPzO69RwkAJJYP/4tqfNjKCih2QhKjkztafnBRGRFBE5tc1vj89F+XaKqv43xJujYDKbQ2YA+fPY1SLu8vL9AnsUo6NW4k6KZn0nrqwOfdUXw/eTE/eZxs5BdDCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f9449f5d-4906-43bd-532a-08df2e0023c7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:43:44.8216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQU4/tq6SzzkgekW+zgn25UoQVvbPk8Wea8yjpO1w5fZt99ramzuUROMLr1xKny+N7Di9SHiuSSxMp5WPE+FKjLXInvXMoC2Yd7fpn5nISs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB517798
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 11, 2026 at 06:52:37AM +0200, Rob Peters wrote:
> The E810 firmware reports the internal chip temperature, together with
> its warning, critical and fatal thresholds, through the admin queue
> command "Get Sensor Reading" (0x0632). The base code already provides
> ice_aq_get_sensor_reading() and parses the sensor capability into
> hw->dev_caps.supported_sensors, but the PMD never calls it, so an
> application that drives the port through vfio-pci cannot see the chip
> temperature. The Linux kernel ice driver exposes the same reading
> through hwmon.
> 
> Add four extended statistics, in whole degrees Celsius, when the
> firmware announces the internal temperature sensor:
> chip_temperature_celsius, chip_temperature_warning_celsius,
> chip_temperature_critical_celsius and chip_temperature_fatal_celsius.
> 
> The command is sent only from the xstats_get callback, never in the
> data path, and the result is kept for one second so that frequent
> polling does not load the firmware. If the command fails, the values
> are 0 and the error is logged at debug level. Firmware without the
> sensor capability does not report these statistics.
> 
> Unlike the kernel driver, which registers the sensor on PF 0 only, every
> PF reports it, since a DPDK application may own only some ports of a
> device.
> 
> Signed-off-by: Rob Peters <rob@dvbcontrol.com>
> ---
> 
> Notes:
>     Tested with dpdk-testpmd "show port xstats" on an E810-XXV (firmware
>     4.30 0x8001af27 1.3429.0, DDP 1.3.43.0): 69-70 C, thresholds 95/105/115.
>     Earlier the same day, on the same card, the kernel ice hwmon and the same
>     admin queue command sent from a DPDK application both read 78 C.
>     
>     Not tested: firmware without the sensor capability, E830.
>     

I tested on both E810 and E830 and both report temperature values to me. 

>     No PMD reports a temperature in xstats yet, so the names follow the
>     ethdev naming scheme with the unit last. I am happy to rename them if
>     another convention is preferred.
>     
>     The patch is based on dpdk-next-net-intel; on main only the release
>     notes context differs.
> 
>  .mailmap                               |  1 +
>  doc/guides/nics/ice.rst                | 22 +++++++
>  doc/guides/rel_notes/release_26_11.rst |  1 +
>  drivers/net/intel/ice/ice_ethdev.c     | 87 ++++++++++++++++++++++++--
>  drivers/net/intel/ice/ice_ethdev.h     | 10 +++
>  5 files changed, 117 insertions(+), 4 deletions(-)
>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce
