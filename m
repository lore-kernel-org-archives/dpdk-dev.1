Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D60CC9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 14:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5723432EC;
	Fri, 25 Sep 2026 16:33:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F2AF342FDF
 for <dev@dpdk.org>; Fri, 25 Sep 2026 16:33:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790346812; x=1821882812;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=O2nGexH1korfEqXVo82QQ9xMz5q4QJ2uYx4zip93dS0=;
 b=SZtJAQ4JLmt6ltZ6YRt3B730Hn+WoICYikvzqIKHQkEgmxUQ3E2Q52D9
 VqtmG7n1VJ2X7oFZNAqjjEZiSaMW+QyVhRWTDxvKhvMgdEGEoCYpoz8mA
 YhBE1M0qtw7g4Dk1s8wRjtVXUiaeCMIKe2Nod/vM+ngIPBt2WBVnagS10
 f7emUQnBcdUIvFQPpQbts9Ad82jPq+DzQtzQ5LmXw8Fk1awJ8P7gm3P4w
 HhnrV2/dicRC8kJtwKi89lweNyEnmRiuKssDy6vqB7vPu0sdqsthmk0tZ
 BIOUrAWHbqHsTq62EgjIxDrYmEj8RMC4vCWoyA0/pkWzAu8Jvce7GNaP3 g==;
X-CSE-ConnectionGUID: Y+hvo4S0QROl4RGmVX++dA==
X-CSE-MsgGUID: 1jXmJTH1Th6mbJAb75XrUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="116661900"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="116661900"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:33:31 -0700
X-CSE-ConnectionGUID: kTRTSYhWQAaPsd1uRBO+nQ==
X-CSE-MsgGUID: Achu32o5TvSMtj9xUV/BFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="303855574"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 07:33:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:33:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 07:33:30 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 07:33:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO4Xvcfmvc6cPYiNhiatLl/AFX8+aJ1yG/A4RQEsmeE1L1XAmUO9R69MhJ7vcqSDuKUg6TsP1Nzk07ilqhHLhdvblqr1Mp1OrhnfyyTIreZN7wPP9aCmbCvteYo2z0D7nR9TYz4jQwLlQk/nkUf9Aie4Iw4YWncMWxiUPYECsAjpvaslrjwnkbzgFMNRj74BR3mMesUm+qC1BpTM71fiX0D5vDkhQPQZRhUVAYq1ch2SkqpicsCw0OI5SFGzvi/fpetcd/vJVAaCIbisr4zOGTAL3vZaxMjAhOqSH1A4DfOeZnXanksBvNmjjUVy3gRBS0N8DwJteZj02pjFz9Ok5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji53xdcO1AwhH+8Gf4KurrDZCiyHx9YLbru9yu+LfQs=;
 b=X2C2J7h8AcnzdHD9mW5GugOqJZDAmvimw58yyJ0mLrvtPJtjoGOmERlXVZPqQAjBcMK1cm5ADT3SG1orL7aJBlEBTzFZ+0Ud9U+FP0GJoL3YU4POh0FP3tGgzCyAS1AQf66q9EfucB6M3X/vsvXEDrjLkoEFWnqtPdFHkujYO1nqG1OhqYxsZP+gai0DfATyfM1vuYIbO6R0Yg/NmaQ6qE0XhY9z9gfkVnJMms19lIlbDHFtheqB4ZvqLKXth/MZsCvrrXvWoebjcNGnaXsxCMrvNc/QsqSxBYpMdWeg67CLe7rXme+ub1nTIWG+/BLupUx0cmXT6Pd1j3nVbRYomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW3PR11MB4683.namprd11.prod.outlook.com (2603:10b6:303:5c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:33:25 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 14:33:25 +0000
Date: Fri, 25 Sep 2026 15:33:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH 0/2] net/i40e: use common AXV vector code
Message-ID: <araGMPixp5RWVYAe@bricha3-mobl1.ger.corp.intel.com>
References: <20260923135146.3527913-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923135146.3527913-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB9PR06CA0017.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW3PR11MB4683:EE_
X-MS-Office365-Filtering-Correlation-Id: aacfe27b-c5f3-40ca-9ef0-08df1b11f52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iSOuHXer+VsiTd10vmVPLXGPR5/yKWNprsTsYy/IITnfwiaHtrowZBIkKjsfxVWkgc14ATSpO9/Lzy+xv6I19oLkMZXR2BD+rGs+8no+UXDNQ4zd/KHdg/QazolYQPjbOCIMvdiCdlr18Ujhh0WO5OyI/v+Ddl+9NYUkkDsdO+hgqJzKa/q70qem89hDhKiZMBcVkOj7gmAHvJ/90HQiYO0w5P4ktFbfv4V+DPzelO45jFOE/hNWHVauAdblYnUy+ZezDTqVPf7WXUdfc+juaSU/43Lod+S7r1GPSc12lXpy5nFFWV8JcCZff4AsokxI8Y2sLzV4OFQqR0jG83mnEzkm3hmsntqSlWjFDJmR3vTr6hRtfB8zqjJfJDlslDo0qGLSejEtiMbs12HspL32AHH5Tuq/FhDs2o6314vZ3dRM3bLYSuXxi5QBs06xJ4AD8L+Ye58O3Q4u9zq6v/+2lQYuTnBTC9wy+VuZ2bX6CV9GWNU2a1H1RdAJGPLxJOU6gShZTZ4tVjJfdmRuMss7ONR5221BiVDaG9ly/jgDfuG/dlclj+Uss/6TWs3ijeO4uSCyQOXJPAeHacIxgDO5vZKP9blDWkK61UR7cd1UkVCcKkZOsFNbWe95IvFGTvfX7V/tbv+CkoYY3T/mFbc5kVwjuDdWOmI0vTjip3rEStg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?keaJlgXizqR/GWuSf+Z/u9hp+rCymwXQLEaVF/j9eimaY+eWEF+2BBuD5cPb?=
 =?us-ascii?Q?U1iZ/aIXYoeiFr5ai3Oj5jn2hjgmGyr2KJot/d1q6JbzZ8s+jR3tXbA8tmth?=
 =?us-ascii?Q?37Pd/WuZu9k38Tes6eWryrn2YxPbGHoJN1zWs6Z1BSUFs9suO2lAXvHErJJS?=
 =?us-ascii?Q?3acSVIBRZ3TFCfQbAiZNolysTCxF1u/vvCVaFevtI+r3XXn4lm8YxJFBckAd?=
 =?us-ascii?Q?pE88vP1YZ4dx3FXMfemcLf/GWTuoh/jxDy7X8O4rrJob3NypBn7/m/2R2VgS?=
 =?us-ascii?Q?MurW00/Ar+AUHh8GEO053bn8mBDXkN/CqKX6pLwezC32IjAuSM4UMe1v5M9X?=
 =?us-ascii?Q?hV+YXYOyLihb5TSqL16LkgOXIEUpxXGqB7ejCItxbjhYyguUKA9wnWHoxwJq?=
 =?us-ascii?Q?1tLswEaTFNeoR65nzqH2R4ef8NByB44kiYawih6Wrs7APGZ+Hz8qg0cPTD3d?=
 =?us-ascii?Q?aiIoh6eoh4+sF+Q5HxzdCIcGRfXGoqfiI7Z4UTKmgtcHIwqq4Fvze8vkP9d/?=
 =?us-ascii?Q?jlLQPi5T+utXBb720koqbY+u6ATQZK3CfgAA75GFP7xPMFjCvTqdaabT6/YJ?=
 =?us-ascii?Q?nNEnI81w6iLL1OUwdYkvHwsaV3NjzsF7XL6ZxE/7pP96Z8jGwNv6yA22woS9?=
 =?us-ascii?Q?x2x5rt9j4Z3gY/xnQ7i2QNVfmaiN086q9RiVgXsJ76qtPO8U1JZjmZDab3Bl?=
 =?us-ascii?Q?XWSLEluYO5oCgBgyZe4Op12I/q7RKyL5xWMIwqoyKxfQ+qX7Fyr23ZYWPAq+?=
 =?us-ascii?Q?TG8UwWH3cRfBM3klWWyyZ+vHC/0KTkxnGi0tQLcdsRi0+zdox7HG8GQT3u1q?=
 =?us-ascii?Q?wnl6dNlwjJEj15nW8gGhRqGirEOwQpyoJgBp+86r6UFmcs12uWKRdzKI/K38?=
 =?us-ascii?Q?Iu1erNOH65Ye4m9sbyP84oaknOa+woNyJZ8abxDY/ynELau5BSTAiqFdHguc?=
 =?us-ascii?Q?pgx0U8Z9afVXT1cuxn2E7e9IcCNJ4qUkqEwZEHvm+aL55lKNH9xNY3fZ4gRc?=
 =?us-ascii?Q?+HoKKfinVuDXY6mzT2S8bWLutUidnSHegjFaVjYWwHOeEm6oNvAXZK7l5hh1?=
 =?us-ascii?Q?vsmLQptDsPhHVU5VyPL+gmUXrGS197agf+gVv69J2qIp57phK1KmDwc7r3Tr?=
 =?us-ascii?Q?8QXPIr3GWD7wVDVka/9UFpmKYcBxfQKfRQtLWr/pWU1du9eQh8+LJ8dascj9?=
 =?us-ascii?Q?Nz8Dl3T8KkIxh7VGIhOxTJubvMyRIsfBm5pK8P/izzIhtKD7r6bXPlkbqFiV?=
 =?us-ascii?Q?upRQmpL+Kn8Z8lsiVQay3g4WfFdc3PV5OEayzUIhwYeK4u3USab5KV9UuLxV?=
 =?us-ascii?Q?oefkOBWEQ8PCba66jzLtH1mDGP8CALNSkUFfakYrluwLRlBzWPBSmS2NQQcI?=
 =?us-ascii?Q?VpKSCEAv/wZsW6Di44ozfpT15/CzT12G2AxPQBi6GW1Eq8G1n+O7e77oXx5H?=
 =?us-ascii?Q?ZqSblK2h00s0MD5XFaFXtcXGhdTMLqqG+ucoAVRKqFeoI3IqzaiRXYxc55p/?=
 =?us-ascii?Q?jc5Jpyp4B5hDJNseNFLT5NQqX8Zp2VAgQmvPnHiFtnM9w8o9TCriP4NiwYCU?=
 =?us-ascii?Q?mQN0v4xxtKomq1zUewKg2sZJAYDs+xgEfL8X+q9sIpiB6HyvpMvCaIM5s520?=
 =?us-ascii?Q?etKaY1niCSXrqMtB7lDOh/xZ6RIAoYQ+ErVVo9mIyT1oCahJo8jbNUAIwUtP?=
 =?us-ascii?Q?hBslH93odV1+OXIrYMkmJUF/Du1+eJnM8b1d4lqC5IUTJ3xoVGhKQ5+Umtv9?=
 =?us-ascii?Q?1QPwbxrfvtKKEOU6MgYqah7YBFZnrhg=3D?=
X-Exchange-RoutingPolicyChecked: u7akOWw0OuSbvP1vShdlganmMJB4U88CkrcTJ4h/xWgZuAzPnMjctSCePqj6vqoKvgRpZ72ieShMSCy0Z8BwCvDA90WMAxYnF7VR+LsQhknZMXEgRlV18h01jhzhr35TQ0OBgCYWZu0TcRhdj7YAY02nUvatpgDuYHf+/crtEDixNXYHVP2VitPH3gmr90MaxM8kmpAz697lDyYFr5gzUWWP4gd3YxYBOBBOcQ2Yk9yDOjQMskuhZSNRstk5v8q0uTrJiPKnEWDABlbXVj5E+mx15j33OexVtqKJvozZXQGUUQCpan1LP3VVKxNaEAqNLtZvQ+JlASTxItaGCaTVgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aacfe27b-c5f3-40ca-9ef0-08df1b11f52a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:33:25.2882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99ox/IQ+XeP0ZaQVxPyvQ+FeZ7e2QhkRylA4kJ9F7wbME8QewTWTZZg4Ve2Ry7RqIXLKW3xblnVCUFuI533KR6oHGG3tvscNa5kdLaaAmoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4683
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

On Wed, Sep 23, 2026 at 02:51:44PM +0100, Bruce Richardson wrote:
> With the AVX2 and AVX-512 code paths from iavf and ice consolidated
> into common folder, we can reuse that code from i40e and reduce our
> code footprint a bit.
> 
> Bruce Richardson (2):
>   net/i40e: use common AVX2 Tx function
>   net/i40e: use common AVX-512 Tx function
> 
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   | 121 +-----------------
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c | 113 +---------------
>  2 files changed, 6 insertions(+), 228 deletions(-)
> 
Patches applied to dpdk-next-net-intel

/Bruce
