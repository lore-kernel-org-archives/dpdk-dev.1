Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF71DCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 057514060A;
	Thu, 15 Oct 2026 13:53:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id DDFF1402E4
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792065183; x=1823601183;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wKgLMtjKZSz5vlKH/AHhIHwFonowh9cSlSjk+aIy2r4=;
 b=acbU6PflmqK9ve8hzaboCn9YBDCIZrsOE36KP65vdcsO+FWPBVV5/MbL
 JxvsZa1qM0lBh8v/RrRKmUzuQl9hiONHe+ZbuQX4UwJyu8EMCfLh+hMgF
 xvrlKcSIbmu0py2Pjv5BaMBaCUYctxbJDx/Gvnnr+CDbsEH9Ufdz3bh7A
 dIM5CEljtp7JvXaetMIcZfNdR31K5+BL4afCxnD2CIFRSDkADoamOnGEA
 qv+m8Zj+eqV9U+qj+jeq4K4vXSpAGv9E6sEVjFv5cGgy6H0UfrGj94ez0
 jrcwQUseJ6SRjU7xwVqkuXOZ4mBJLYNKgZaxu6OyhHnA4C/QiqPdX0/vd Q==;
X-CSE-ConnectionGUID: mpJFFP74R0mfqT71T33mig==
X-CSE-MsgGUID: EAwHK8GjSjudUXBTrO+lDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="730419"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="730419"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:53:02 -0700
X-CSE-ConnectionGUID: 09bo1BjRSXOGVOwW5rH3bw==
X-CSE-MsgGUID: giojt2LJS2WUiOj71AKYSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2142158"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:53:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:53:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 04:53:01 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:53:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtLjjvRVXFFwzi5jmiSH1QE8dHBAzG1M+6wbgn9tZ+hQZ3yIaqtcOTu7qc070JacZfAzr/jf07sjSuVjMaiYMCRnick/z9hafXazF+uBvvthfySdKr4KEm7Cew+ASoqKcKLjGtCVOZofl2FbfknC/zVPvNiXQoGcOci0tZq/b0ldHDnYF4T6Zj7YyjNmBQnaPb2xVAd0Z0vo0Y4pYdTNHl1YbPhyjx5yovub63zb1F/3cO9wF/9nEns2EQkdQpHWmy0BRWdl2zVJHR/iVx1lnJCUV7yopxe27ewR2jCM6lem9OPdiAGEUo1gykgqvVI/dlJMFnPzscmmYDDl0hZcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6gDHFYuvieRBQ7kkSGEjGJfpS78+fdWwxB6lGdHsFI=;
 b=QbCJ9Uo+KKLYSNZ0dwNVSSV6p+729k/LWGrge9HMKt94Y4M//OM68dVRdHPhnXNRfhzuLdBNvG1TtFWi7nQZyHKQcSlTdaWAoP8nBfTTKL9bU0l3kbnPnPnCo3CyorVebdeSkji4dHWAuDNohYo7NoLl8Mel/WojEjXKMQFOrMnl17Uxx9eEMzRyqwh+tpJy1V7Dq3teX4xfdIn/TYZxen4afdFWWNd7jZrqlVp9D1zSbWuKecmV1POsalunAHvT+9U705i70V1hn8tu27IHvdDHWCLcxb9alsUPQLuQXZrun/OcfW2vj2trrM3OvPvXkS39/QJBNwFgcEuMuA++eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB7146.namprd11.prod.outlook.com (2603:10b6:510:1ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 11:52:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 11:52:53 +0000
Date: Thu, 15 Oct 2026 12:52:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk v2 2/2] meson: add drivers to dynamic libraries
Message-ID: <atC-kJHTeupb1Qri@bricha3-mobl1.ger.corp.intel.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
 <20261015112607.3008792-4-rjarry@redhat.com>
 <20261015112607.3008792-6-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015112607.3008792-6-rjarry@redhat.com>
X-ClientProxiedBy: DU7P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::12) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f681ab5-c9d3-4fc4-2a64-08df2ab2d829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: oo3WtaAyQV7gAlZH9UNAe5IbFswIPZ+BTtdxhKwTbJQkLFUxmqtMZNAMECz1KCNAydNqUyjG5mxywVunDRHp0obK0Cpv3eLKlVF5RbQuZH8GcuAoGVoUuwWsY6XSCj49Sh+yB3Gzc0ElhOZVOqQOLzctadiWOjFmgrQ08yDiHn1jQUtRZolYG9XyOm/khv1xmJjT7J5RLl/Ek0cRX7Y0ZLHEWh/4NUgn4clouxv2FIn4OSSCw6JqmwW0L8pG29SEfuLfdzzXnSl/3LwpGBCHzyQBw5CPRsrSHOvuAt1dQh/CtAw2w0WoA4W+xyBsrDyGv9dfoTCSpJP7vPax+JR4s4236mERDOnf1E7ykYuq/JYQ2Nm/kcNeTYVdDC/HXLWm9KjUrfw7YXwS1BPwXiE+B7oMmiPnRmFe/zS9qI5sZhuccmhsqcMMb7DW+L2bEZc4exuClQd0xQY7tgTDPTlSg/6+3Ez63hm3sm8UItCjQd6i4r+OepG++oOjJTTha0Tbf2vA5Xv0C+WPWIibRm9XSyLBEl49cW1FwopSFT7H14tENUbMiEaeDxEWyJzZM4e71noC68SXzmRcNRZcnT69FxdUK4sQlXY2z7VMuVw2vlSOY1FmRdDNfVHVZONP9FjUF9Ag7p7fkxWV4MY3vGctoV+m1qD8dewaKRqavHlfI1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0urK6016VYYRvwLG6dre7aNQZ8mY1JBGQ75btc3COex/3YjlLmrRqOxzehzs?=
 =?us-ascii?Q?wxURU3dbLIniqDmslg6eqH86I7Xfq8S+QRXuxWj+kWlXe2U4th9DNV3UpOGx?=
 =?us-ascii?Q?4v8vzTU2xyX/m1ogGB73lmKYdOXLeuHpoQK66YmS5z3NcMiV3sNPoSXgVZPS?=
 =?us-ascii?Q?v1NwQhHjUVje97NhOkfcs9fQ3Uc136WklZD2n1u3Gn+YmvIuMCwSJf6DM/7r?=
 =?us-ascii?Q?50ZcwRCefqZrz0fC18VfkTEKsjrJM5D/qwygR3jEiRV0i6sPjTX7FnvkoFm3?=
 =?us-ascii?Q?Ij6AhrupJUM08J3s0LPBRH896qtb4kVS2Cbb9j7zUTRvRmh/gKrR+12Fvrcm?=
 =?us-ascii?Q?Um6XzTy3hsGDPwsAXrvWsLFrYP+S+k+3GD9ofSYy7DhH/cpQWDTA9rZvF9Em?=
 =?us-ascii?Q?RkAUFzZifgKNu6ey2cR72LRe+GW0lK21gS35Pox6NQ/NxxbIsZSAPBpuZrxU?=
 =?us-ascii?Q?eJF0uqHVPmd9yzV8siEgULE3FP/mi5u3yhMwSUA6jpR5qq5looLesqFuWqYW?=
 =?us-ascii?Q?HhC66Jyrv48gUCIso/NwJkqv37/RryKzL7l4YOIIlIgMEOBvudryElrdiNb5?=
 =?us-ascii?Q?OPzcDFs9jj0+BpJZE7aDV9c+UCccaDzRabRD3uG9y6cEEr4P2jfXJUDTNwmX?=
 =?us-ascii?Q?fpfavaVGkHgcZHZrjYluRpBJuZCOC0ozm5duBdoRWDCRr4xybCpjTvSGjjia?=
 =?us-ascii?Q?jNGNOVLjBlca5LXy/SlplZi3zyi/Pm6HP6ivO3tpg9pnp7KQ4fpL3G08lfJJ?=
 =?us-ascii?Q?D/J6qltPg186q/I3TB//g/DTEgXUv484W+HXggOEyG0GjtvQgYpW0EdJMYHL?=
 =?us-ascii?Q?VofwEp8lEPZ+MiAHWfRHO5EPwmu5JNCSC6lcwzOFvrGjnv9nyabMnMgIvMe3?=
 =?us-ascii?Q?Tpop0WHSYSIO1nj6ir3O+UwcNZoxENGGXt48Q80Tag5zSqJECcT0VZXte99/?=
 =?us-ascii?Q?1GiFDPrqyFJRxoGWG5UA3F6JQRfj8/yv13djF7s3yuYpMAVxxKVweAlMcW8E?=
 =?us-ascii?Q?MOVleZw9lrn2iiUoZs7doXr7Nbu0AaHSHETu0A6xvw4hZqiho8GIwFR4+XUO?=
 =?us-ascii?Q?JCr1T+FHI5X/gGUnthGkpDzH/p+zXMRD+IjunVuYkbodXJ5PBhaKn2KO4+6x?=
 =?us-ascii?Q?vFJ+lpbpA2nBR2UOGvrudfqbwG4sVqp61dH/bfYZZ4MtvupJWFKcMVeqdCSt?=
 =?us-ascii?Q?fjt6CtPD74dcakZD+xalNsrfN+/Wbq0DlBenM9kmAQp1O28J+CQeFvJocLtM?=
 =?us-ascii?Q?ySMC7sFTKZVioPRjxNyuHYmLI/iYECibd3LRoEpscxxj6DkiqSMskQbf5ymM?=
 =?us-ascii?Q?GDl95cizbSdDWjkgqC3x1fKhDw6SB5pyl5tzZT86tknI5lEd8XkyOdtNtp8F?=
 =?us-ascii?Q?thCrXJKlvLB4b2tMzLhQGVY+C7TmSLnKkX0dfBAXbVhp5dSSGP9Q5jpXE0MH?=
 =?us-ascii?Q?946Q2GvackXI41pmpFuwi9qwGDKVOqQCMDVr8pPazr+PZpBaNUBnWope9S7K?=
 =?us-ascii?Q?GsebRqnvGVb8lN5qROGYJOy86xcQFcJInuWrcvcfcraIh6i5HnM7Rjy51JPT?=
 =?us-ascii?Q?pg+nRctx5Km65d4qTAc4G3TymzT3t322iSlIwyKs4X1DAn22wPIQRbe+swkS?=
 =?us-ascii?Q?Cw82aWKNIxiHd66ureOdPdnRRUXgI9E6MuugapM9zd3ogqicW/pyqATE8hNh?=
 =?us-ascii?Q?h+8mcOhwf99BkhBbeTpCL9T+emFke98eWq3ybsN+Bs1Ra7WaeExc8sFthiRB?=
 =?us-ascii?Q?TGEnYfL0rTDqRO9llaM9FsRT8Nhi3Uc=3D?=
X-Exchange-RoutingPolicyChecked: caBMx3/zF3dDkUj9X9ch8gYegLKF47zI4n+9lDF1qWHD4ehZq0bneITE8pKW3nwAq4xjPJqhcPJ2ilbFl6XBw6kcdnhIjP8cfseyi62bTtexAOVSx0YId+HhdWn97bC8J8biAtWLpMTV+AKf3HGkYLzpQiCfB3MH1wCwheBNfOCg1bU9kqQ3zoUROO/jtfX0pbiQo0xGqo3Gxfqd2w7xHAfconlAsd/VVGZTXxeLEgBAgX2Eoj4vzx7r0cbx7pc8ZOe4i7xFpETY+26yp4NymhHBuVkrOdHTWfogyYnazm5yr6CvjFNZOYA75c/OqFajHdZ8T4kvxgSx13EiINfvaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f681ab5-c9d3-4fc4-2a64-08df2ab2d829
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:52:53.0867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOSWdEC3d6moYPW04rkdSXSdnK4ErzdN5oYIniBW6/9yA7gI4g/A0Kgl9Htq3MVSjwGHBqP2lDUvqKFXhYVUkSFwCYZ3Nm0Jrbdznewtp2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
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

On Thu, Oct 15, 2026 at 01:26:10PM +0200, Robin Jarry wrote:
> dpdk_shared_lib_deps only collects library dependencies, so DPDK built
> as a meson subproject with shared libraries never links against
> drivers that install public headers (e.g. bus/pci, bus/vdev). Add
> these drivers to dpdk_shared_lib_deps as well, mirroring what is
> already done for libraries in lib/meson.build.
> 
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> Notes:
>     v2: added driver shared libs to the list for pkg-config
> 
>  drivers/meson.build | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 7146f036c4c9..0e8e69798bdf 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -405,6 +405,10 @@ foreach subpath:subdirs
>                  dependencies: static_deps)
>  
>          dpdk_static_drivers += static_lib
> +        if headers.length() > 0
> +            dpdk_libraries += shared_lib
> +            dpdk_shared_lib_deps += shared_dep
> +        endif
>  
I think this changes significantly how out pkg-config files are working, vs
our original intention, so I think it actually needs more discussion.

As originally designed, when dynamically linking against DPDK the pkg-config
--libs libdpdk call was only meant to list out the libraries, with drivers
being dynamically loaded at runtime. Since drivers were never meant to have
a public API that was generally used, I believe the idea was that anyone
using driver-specific APIs was required themselves to pass the driver
explicitly to the linker. Otherwise everyone who does not use that driver
could end up (depending on their linker flags) with a dependency on that
unused driver. This change modifies that assumption and, while it makes it
easier for those using driver-specific APIs, it does change how things have
worked up till now.

On my system using a default build, this adds 33 drivers to the list of
libraries to link against when using pkg-config --libs.

/Bruce
