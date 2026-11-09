Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50C606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wp/vAN80
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA2840B98;
	Mon,  9 Nov 2026 18:53:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTPS id 2FB2B40270;
 Mon,  9 Nov 2026 18:53:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794246827; x=1825782827;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ss36gGYKx7hUk4aBlJbeDG4tKOERtHs5J9wzWTXTvw0=;
 b=Wp/vAN80Av0QCLW8VYnT2UUwYeudVviCT2SAvvN3BV7ijbpNhH1uO4TV
 Le29WMJpY+NLtHsC9Dv5CGTpTCQ6zESuqLjfOFGvr3n8RANvbfoOs06qQ
 3jqTwaGdgb59ag1xaUqXlUQUT5wDrbBYsFX+O7vvj3OwIYuMKzBGpzXFw
 bbhc55+Y4ag/jgVsXVe/W/mlhD15CpiU+yzgsaALCCuinZSBBRH/fMbpF
 fgefNAEwj9JPf7ItYn/x86VvNo3MR1vMKhPjMBTZ6XYHBN6vDRYnj2wUi
 aV9Zlf9gpqMxAnU24gsjKadZoLz8WbAvGh3cSfzmPjPRRQuGkhAPQlk3x w==;
X-CSE-ConnectionGUID: S5ynURLOQKiaN60zyNYV8g==
X-CSE-MsgGUID: 6HR0aMzYRjCPIyQwAwQmlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3011904"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3011904"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:53:45 -0800
X-CSE-ConnectionGUID: dBp9JhyDSyS0eNrk8nJF5w==
X-CSE-MsgGUID: hgNcWo+5SBePVQ5OB3D37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9784687"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:53:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:53:44 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 09:53:44 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:53:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh69uek4RgAJHQopz45HVqygWAqAxOrTDVRjBU3Z6FSRm04EBKsQlCQ4OKIxClUbrPqUGZgX9MqEsMJsr4eKd0DYO4fsZOLMZFjfCE5fV320yhMyw7bhLhtD5yjeMjHfAltes64huLCWM7ixTkWE59AE7GT5CXTyMKg+o2wyEKUoRVEM9L5cyI6HX4JUJWjRgOn3e3U4z1S7S4QVc/elU1IOG9JnTznX91/Qi1h+Ox+Lrv97K0d6dPWcS+d77O7Kclg0/Vwr9Apj2dun0FX6GKrDbWGj2AYXXiJisDJ8OBYIK10cLIu8J/l4r7muK+6GygKmGieZ4H7+P6yCpK5a/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrbccTQrLZiQqJymPbKu98K1QnvP3lEz22PQZZsFUpI=;
 b=iu7avWV1Fu1ncVjakREUaJ8L0ynxfz0bm9HN1VTaFo+Gx0VY2387dELgANo3oQCwviMlm1GUG1+J170fwa66kW3/ijAZwnf0oz2g2E0Ddte4h5KHRY51nZyr6ayEl+NDNHqg0PXlRgXfh1y1ctuoyAEGL6GiNVycqannabPdMW9hmqaO6mfwDM09YkzpIQkG4ypAYnbRn5Ess083jkl+ujIGEp19sXE2KyJRAcChRkxwTrMmXHX3iz2iI9QBrpBKz5iRbS75vEY1N6DSVU62+BOAm09t5xlRvXwiM2fZXk9q4jgwF5WWSUbic7/A2RMnRHTOtFPW3i3yBBy4SM17UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:53:41 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 17:53:40 +0000
Date: Mon, 9 Nov 2026 17:53:36 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 "Anatoly Burakov" <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 2/2] net/ice: fix DCF minimum API version log
Message-ID: <avIIoGi1gil48i2-@bricha3-mobl1.ger.corp.intel.com>
References: <20261109124524.115656-1-sandeep.penigalapati@intel.com>
 <20261109124524.115656-3-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261109124524.115656-3-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::25) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8094cf-4435-4594-c405-08df3e8a63a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261102123227099003|261028144727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: MUV0KmuaspkiSp+PoCikN6BBlvs8mWzdoDaesnT6eaV09xsM88G3VSVkqRy0DDgOpQ8aCmvea4159rWE1pYK8EYuizmXQHtho6ycQI/tPy/Sr8IxYP/X8PLHcAaqGz3DCnV7vo7+ifkgAVMAcWiOYX6v1ibAHGbG1SYECI9VsRg4mTlB+PLuMLOV6XrbJisB3QocwsbqkzyfvzV1BxPOIVoCol+uh5+U1yltmx4n35U/r7XVkYUkqvN6zIpD1VF+aE9wKfffG4xsWHn3i80x7/y7w7ivnPu1PkeJVQVg44T6e2mKGNKGu25UxhPJrckqUEabDBfzV9FKwYfoQ/hTCbYtJ7LBxtp02Qod3rXARcFYWlIJjoA9BO6MvkrrT5Wx94GEVoQHuprYkOaDosU4uMScWjC6vC7v9bc7p9+sTtD61XiMzyQX1yXat/EC34Aie/Yxh0aLqF2+Lr8dQ8J09cwSIfadMB8PdL7rV0B9Dha1eLkCqvjr+j/vClSXmcLRi95h2NqSHyRGMFXZLheg/8PefmOsJVhF37noPbOaJSldWawIs4guV9T6zpVnmvOjDZGGdMr2ytdAQgDewx2KvYR1wZ1e6Tb8uXvrgCy3MeAUbc6jadD+PqpzB4U8bDTRBxyd/rfStphxQIs6b5Ibpeof1P/SivGRRXyrVcoKuvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261102123227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JjIPEEfV1uYmd71o68Zq/Pfol11+6tlIbYtq3XOlZ5OmOgeUJdSA3hzq9k6b?=
 =?us-ascii?Q?xyZnuZljMnnRnwj3kCPWPfxeqD7AUWWmtQ33UMfSyiyKv23Jv5NXoWEwO0m7?=
 =?us-ascii?Q?NsoPxbXRcfIxnL54u8GnxtvpHJzrHjn6jihXF6dsD5lAnlb3zE4RjZP9FEb1?=
 =?us-ascii?Q?TGhR1lPZps6FmKbyj2PRT8RtZrFlAcduoVwL9srIsWgwUzLPp92V57QJsQCg?=
 =?us-ascii?Q?ihiAr2COKUZfLp1TE8cRCp5jydAlPM2XjtLT1Bg6gOTZbKXQv4nqha2mXnEr?=
 =?us-ascii?Q?6brai9PxYWfCThdB0Ws3pIpFpVmr5Bog30pRM+dmPD9Vvox7wUF2/flQEw7t?=
 =?us-ascii?Q?kUkHXgoROtSeUqeIt4jxmOA5Y6RimLzgId4E+qIOMGOx5MyyZmhvZbo3y6du?=
 =?us-ascii?Q?pbLcZWHNsXLdUDbVuMlvISnDv6GbGZRDEVSI6n8vRlSYMq8tCcmEzl/nU94U?=
 =?us-ascii?Q?g/RcmroXpkS47JVCzNSqD5uHuPX3a0+Q4vce6Nd4SA4UMklRk+UntE0qy+q6?=
 =?us-ascii?Q?IqZoV39S3iloi8II3irQQ2LtCcIzewbMFKOZAXIaPuKSMTfSQoIxFUcgOd+y?=
 =?us-ascii?Q?kgoFcER+Vu7tdYh/E2mEtf5MLfoq37u8Hrsd00CxF4aGr+oLh+Y1eZ0fFD1T?=
 =?us-ascii?Q?acBEI7O50ueXR+EQ+CVZ7gCUpNY/XLGNkj6U7MaMR+Oci0SxqNhxwoEblhRV?=
 =?us-ascii?Q?D6PVKWZWiU/FTEuUBhrOxC+8XUkkuW9uLJqJF0TaaERKdACEJQEHm34n8oHN?=
 =?us-ascii?Q?xUJumrRWRHknNXXw4jeGnXg3VO8qOfsUf4Ebjb/5+y35j5HKQTjuRF+Ws3Nw?=
 =?us-ascii?Q?Dt9Kxysru8cv0hWjLz4Zj/YKVP92uWhWsTFvPaF/tMkOJprxhntEglEFX2r9?=
 =?us-ascii?Q?aUBNLJaalwxk9liYBaxPVB9MkJQCubdxayVtDJNBXAVqN/QbIk9okEZPY42M?=
 =?us-ascii?Q?jeRGsEeIQZcvZpiFNzsn4FKbohoEw1NOg8bzXOZxrTI07X73/dmKYesuOajn?=
 =?us-ascii?Q?YJI4wmQ8DoTREnttNL7jDpl8g+n9X0d5WPVBTmWSLOylBbZdm3gO6W41FiaR?=
 =?us-ascii?Q?hH2Im3CL7A+TUEVa4jxALu06Divi5lmrmPCsPwYbGngA/p9XmPpz1Zwp6tZy?=
 =?us-ascii?Q?kuLruKy+w39qicMhrWb8DW3onuYcSS1zplS+LoWLT/uE40rR+TswuXOoboQs?=
 =?us-ascii?Q?T/Qb++ypt9rqnAMn2iMLuNG94RZD10qjz3WpR95QHwcFjjhrRtq87egaLfUM?=
 =?us-ascii?Q?VSKcVQ1P/OrHy42yA0jSkt2UCQvEqRYXeu2Wo4Ip2z3lY0anppbPvKXfK1FK?=
 =?us-ascii?Q?j5AgBKjD/uyqKKmJX6F61tgxFhbw8LYUJQ5QEMy5VipsVppPcQtHcJKREdqQ?=
 =?us-ascii?Q?JHsrT9n32FJvxvZvFLaGcYjFFciXDIvb+/Qn6CVRbtjZh6sm5IHx4JOpjFC2?=
 =?us-ascii?Q?VOEelz/jTAt0Vwhn/IcEto4/FogsETg2sQYWhelXxxTztWfVFCWn/xhNOM0p?=
 =?us-ascii?Q?JJdu/OI8q/HAV9Y3hluhZ+bIOmrMLioJD9sJwfIoTZm7gp3hQSyDhDwkzT6G?=
 =?us-ascii?Q?OX3ZvGePXHCzqyqVIKjFfWXUPgrr8uDAe6gx0TV2sL0zXdO/axdsw12vJ0zO?=
 =?us-ascii?Q?pOrFIFu3vI+yVq8t0cd/ecXpgw97roLVXANgfy//zm2K9anQ4BCSyojK5svU?=
 =?us-ascii?Q?e+5Nv7e/v4dXbzJVRIOn+3VauX0WHQTlqQKFCPlouwR1wrZaxXqRX9FizVJf?=
 =?us-ascii?Q?Ed8aIU5cjw=3D=3D?=
X-Exchange-RoutingPolicyChecked: U0RP+18Mq2Fx95vtpUo/sDkXQvlbCKCJORSCgVYGgeOBE1BFnGNTEWs8GJHsan7zzF6dmTV0GxL65U2ChjnLFxzD9qqAuCHjKpY6wjIU3Hc/yTSi241Tx0Cfo7dK1T3Yulbr+7lSsbCC26bxRCDOQVy7WDvhzOhycRWsKiWxjFuvJxKJZ3sk+7gww4V91V64yC0vx4aq1xm6AyLhxzLYzmB4VgyF8ZIL+gOq+BbmDdoBMTGuwob4QnKtRdxl3bk8Gop3u4LDrhVNOKD2AiPUHrmRl7T4hOwcgboIr70BqOHJPU8TRPy5ppHOBTNHXuYLlrW6c1Mkaiwap8ZeOgsgAw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8094cf-4435-4594-c405-08df3e8a63a2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:53:40.9319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkmo9vE6P2vAICSoCIATzHbYDSNQIqkm8p8KmaDK90BvkOhc6/U3XNHnZCE5I2binU4QFt609WgmZ1wjHvFwLnGmUzF5zM7Terlf9TaBtSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
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

On Mon, Nov 09, 2026 at 12:45:24PM +0000, Sandeep Penigalapati wrote:
> The DCF error path that rejects a VIRTCHNL API version below
> the minimum passes ICE_CPF_VIRTCHNL_VERSION_MAJOR_START for
> both the major and the minor format arguments. The logged
> minimum therefore repeats the major number. Pass
> ICE_CPF_VIRTCHNL_VERSION_MINOR_START as the minor version.
> 
> Fixes: 7564d5509611 ("net/ice: add DCF hardware initialization")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
