Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA02606A32A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HtOdeVrB;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=e0xWORno
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C77A2402B4;
	Mon, 16 Nov 2026 12:35:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 4FF74400EF
 for <dev@dpdk.org>; Mon, 16 Nov 2026 12:35:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794828946; x=1826364946;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=dviiV8ZuvMcvGWjeWRNGRZFKCVVsu/jm9STaUF0VJd0=;
 b=HtOdeVrBBgstHGUzEtDN1nMsyw4FZesWC/0ODZnOGz1EO8Uj3uTPczFY
 lfBC5YAPynYTjt1i6e5I/1FJxCvqCGB7deznZLVmZRla7ZB/NSA4uJ5qd
 7q8AGOLmjzy9Lat+fvdONGIpB4wV0Swsj1IxA8NxqjV5dPm7Wl30pOQ/F
 xKgIVABhjAqeuTPnq/jsAB6iIm7GRSW+nIl29o8vjMDywHCbPhaqg7Ah0
 j0Sras4szmn5vgV+3XUvQKOuEL01tnyvZiGzHIBEaJ0q2+kSwOyAnRW1Z
 aHFUJ9KHNvgmx4I2deM+kdEZxQwt+kDv98SWyJxW8rgDZJeZfNKtFfnvH A==;
X-CSE-ConnectionGUID: sOovVBJwSoK3IXSUFPRTqg==
X-CSE-MsgGUID: En2jQ/1ZRl+xCCMlgIZt7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3551839"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3551839"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:35:43 -0800
X-CSE-ConnectionGUID: hpAo4SZGQw+laGcW4OMbZg==
X-CSE-MsgGUID: 3u4dletIT/iIw76dAZUoQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9843166"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:35:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:35:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 03:35:42 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:35:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czZYhYt82TN9eV4cfbNLLaAnGPYaggG8RJku/ukx+Jh8srptH5wOI5BMyCxLEOtlRse9r7UVbCL+amZuq7LCgZ/UtRoyFWgrIoqKf9ivjVFqbPL5kWGQBNN6ztVEqF1Wwc24iX4Kz+utUDZWv40WMkaV4CZ39tI03RRuJDOjSl6f1MXlH2sf8pxlGHP5dvlCgaG6S2eKF8D8B78PC1na5jOTAZdOd9IOQzX/fsKX3WaizkD0kFXTErJBIc/qXp9rVpxc+tV4HEdUIAlHWx5zYXuMOQmUlEDilK9rnT5OoXuoTjpHv1Uux7iXqc5qYBIvMws5dDIjs3+3G/Y2NcD4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFNb/FStMXkZSpGfm5pqRipxZ/IoqyEJFo5PWgWq6sU=;
 b=QNtsx2qtsMN70KkTgqyhA1obhbUGq6W2N+0NP3sBRlpOzH05VrjdlXn3ChoboIYA4AF674NjOqUYDEdDHyYEPBn6EkVpS6e1RF3C6tuuUoUQrfrenmgFcVlpMO3sBQD6U9navGd8GeaW9POkwNF3yXOTx65qzoVSZXR/PfnyaG1pgssxVW3l9ndIef9mhB7Nn8I4fKruknjT2+5VB7QOIWzoS9CKxeMxvC5zspg2q8FhkdPbfAc6fRtQ4U0HhWja/sWz7eVyOs+loe3LEZtLM6I6v/WXxqe48kkGBDZ70pFlPiP/zzWrmPLexjjSfBXyhIiy/GvanPyXZcg8mmPrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFNb/FStMXkZSpGfm5pqRipxZ/IoqyEJFo5PWgWq6sU=;
 b=e0xWORnoUUim76sdMSP4LcZYm9apJOSojmaSC/IGFDq6ju8ws25eYOUPLWdIGuNeiFmOHr631UVUj9OrK4JCQVlfzrgSUmYBw9iuGzewfnu9FvLUuOeOV94IuwkbiWL9aWu4s+5utPMD548Cwe4svUkxnBVj0jTczW7Y4M/hTRA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LVUPR11MB9858.namprd11.prod.outlook.com (2603:10b6:408:38b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:35:39 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:35:39 +0000
Date: Mon, 16 Nov 2026 11:35:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <brian.johnson@intel.com>
Subject: Re: [PATCH v3 0/4] doc: fix Intel NIC driver guides
Message-ID: <avrqhbwNyeOsNbSp@bricha3-mobl1.ger.corp.intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114084619.190251-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DUZPR01CA0314.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::21) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LVUPR11MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: d1feba58-0197-4151-3c66-08df43d5bcbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: a9sa0VdlOrCyfrhm8wO4tz6yrH/MSsp3uH106GR7Fg5mS6TVJlPmfwppoMN/Ea9Vdv5pWbEiHXt5nvhjnb1u+fSmtp7AZJ7zeJQ2Fu/CUUH7QoZehzqzYM3b8YwtBfU+USoDpSK1Eah+3Gns2KI+j74MGfIgyIfwf+6zQp4L7Gbf1btCpAlZiZ7R2p05jdn4DtUX0PEkTzByNR3GhpAvH3cVg5ZsRp0I2LEe+kQak50/XSDsKib/n3k4NuF3N5QGshEKfRoyaulcrBed7XgA1Yd1Oyr6r/sGtkR5+TJpJOMgveslI3Skh6kAMF/0FHHb7W3Q/7rCrFrjKv0a7+C+0er7Fz78QX3wwAUS6pEBe8gIWmQyX8Q3asXNMQh6fQRSQVpGVW09u000VSvnFUwkLOYK8LGq3MW1SiAWP9oaQfgn+GoiHVMzyCSQ1GEUmEcH3SfSf0zJ/ynl7fqdkhIb8xKybfoGe/7L1qgM0r9gcK2zSWWoNWC7Yb7NhUrgnMjnvd5QEsmFAyZpt4Vw8FOi/KVhGCdb2SBNwhGRIXXsrWdirfF4R6TgGS9h654xqwaw5kVBNSbRbm90J5FP11pFX4TF8hGCRV9qHHFe+Xsn+R7HjHpwR0ivXAzHKXqd/lvN3zx8G0lBP3hr/IcpCwgcOVaSeIZLBYobgPUHVtxyL1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aw4vVOiYcGbh0A1nBbQrobmpPW46NUFOiCqWIy8aEzrh3j2dJe0+bkDSHJ21?=
 =?us-ascii?Q?UwDR6+qqCvWo+Glqt+D7Z2n+IPeefhucpr9oNQgVcxuWRoeZ/BAFrsJ9tJ55?=
 =?us-ascii?Q?6WM3IswC3LvR3jfNAw9iDHs81ZhTcXKgkPjqiuebQct3RXbn/tbRNgdwwmvk?=
 =?us-ascii?Q?I3tLbEYejuK5WP2aATmRB3C65bpPWBmxY+QzL0nIyHs4kUMRUuG/tDqsw2Z5?=
 =?us-ascii?Q?+snLH/csUAuOOj0xT7+rnMegCcyJoKUiXaHpoNmAgOThI6d74KjXKkIoiOPX?=
 =?us-ascii?Q?FhGBO6Bcy20SlR01pmtRLjYUxZfo/JtFLNyB9vkQS6sSFI5Ep7AVOXhIkxao?=
 =?us-ascii?Q?eTCZo31rRMucRsAWUKTVFvGLYD0zvl91vrU5Ir5y0K7OH6p6LB/XsxPoUvT/?=
 =?us-ascii?Q?5RHf+8eusBbReRtyPfkDP3xB0xjzLEiEbWUgMguwhprSUfKa2nROxlPTfgox?=
 =?us-ascii?Q?zSNy4GuNfK66RuU275CKy823wtqOAocsxqAj7nnS3lrFGLdSH2lTtiuWTRwC?=
 =?us-ascii?Q?2CwlXa7kISURmUJtBS4LFMk7al+XjZGpUC5OgwCV/mPWqraCFbUliys0IBiK?=
 =?us-ascii?Q?GnDhxD1hwAkRUXu0vFp0AJTO1xuNWl7hL+S/oySgMDPeqWTmzCSJ2bdKibCp?=
 =?us-ascii?Q?mKKeYnJB+y73FaQ0c7e8cT2nvKr/5lDK9QZj990rYvrUkghZyuDWA5YUtAmv?=
 =?us-ascii?Q?Aw1E5eEct/hmXJQq1qmW+jZVDa64j0rieMj8Yt/oLUc3s8A0is1lguI+iW2s?=
 =?us-ascii?Q?66woxOytuhZ/1oUhqPIg08UrlOi8nNg89QWW51p+9ouyFZ8KUeEVNVEwqIuT?=
 =?us-ascii?Q?+hTJ7h749j6imtVeKGcvb7eycmVsZNMP15/nm5jL4JKhzsCDU+34plym5G7Z?=
 =?us-ascii?Q?AIGCK3cwytJbm+/4swFO0x/RjER9KOOUyCvXKBPq5li62eZjSdVlQScskc1O?=
 =?us-ascii?Q?PHYAob0sOTE4K6vmZNWXgeIIc2ZspjyIhWPjkmj/BiOHEgvfHavFN7tghR/Z?=
 =?us-ascii?Q?Fzf8U8t0XPtKz2IyObxO6M9tsvAwd/gll/R54DtU/uDUbXXDh9iTdEs/2zIh?=
 =?us-ascii?Q?KYzr0DIMVA3WPFfqeVCLQg10oCFVzKt02U/2a4TEraqnw1hlTVjGRTMjq2sb?=
 =?us-ascii?Q?SZX53Qw3fv3uyJmKPhQrKMnEWa+fbvZSYtbR8aesYkqfr3gOgW3eKH5rHBLy?=
 =?us-ascii?Q?67gk0EmDPQhxDPKk4t5Ofn89Wh3lpuIoGJ4AIXedxr+6fBHpKeBOhCKwqSLu?=
 =?us-ascii?Q?zF9s7gxVFQ3PKJm4OgMQ5vsUd1rP5vFQwtxIKct3vv33Tub8ay0Y8kvaUsTF?=
 =?us-ascii?Q?MjJxhaQzzXlB8XunXdbfi6dIzSPWS5i1aS2vYyVWvhaNvVpJfVCZTsZsOOnU?=
 =?us-ascii?Q?1aKza69R2l+hMmvGJVwkp1dM3clfZZalSS3/6j34WVWM4ECbz+a1/XQ6Uhst?=
 =?us-ascii?Q?JNg/4MWnqda0a4C5GPDkzxd58nC7kKz9pYTTj0SxT5KUivcRW06LVfNmrfme?=
 =?us-ascii?Q?DrcLcPyfOMWgJ9DnDoHSGD2Kdjl8rzFAhX3oIXV4y2BIrQR100kROe804jnq?=
 =?us-ascii?Q?efFj8QbDj2DeZxQhNaTpylfYlY/P3GltAy3Mr6lUaY4rPiFVKmvIZUO7TM74?=
 =?us-ascii?Q?H/d7h68Il9a78ToSLleHG3vEueQVk+0mKdI+89jvTAarYqEIX56crqVE9+AG?=
 =?us-ascii?Q?WKD3ZcTSoZPegTg5BZV5s6hrWaM5iIPCjuTt8KskIrZnxHZF+TZoy1fPVTEG?=
 =?us-ascii?Q?RKIIgwOSXotRra+i4pLOg/EjQ7K8VAs=3D?=
X-Exchange-RoutingPolicyChecked: m/pSuPN0Kz4/gWnqMD3nCmCq6atySJYpUqD4YKA8lpz7ZdLyC8gHM8alF3rWRjPeurLdUFIUdwEEH2aqf8H4/X3K7ceBbwI4FXAhbCJ388cyWi+JhxX17MMbB93WSDFTXDhMCluusf2EglWP2orOFBuuPMdWx2SsDJdLvKGlbmpW8MgnWHziDVlMe9WIc1UosjOwlJnVsbhs9nQtT2bd7DHDrhCA+2pOQ7HztmmjeHJBpg3XFnWglMGmbfBH1yT4BepVYmcg+bEEJ67KA8nYU5yt4Dw8HisJiNKjSEMrRGMj2azs1nHW/FNLVOx6CJyfwJujUNxUyL4t9w7HsbZljw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1feba58-0197-4151-3c66-08df43d5bcbb
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:35:39.3486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUp0sbqi4gqFRyx7x2czOPki3hyLs/2zHzXFaBeB6cPSQ3U2qflBi5jDXa5FhraOKky8S2T2h6UwrbLizv/TRZ+Le68cskswzW/BuZkTOTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9858
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 08:46:15AM +0000, Sandeep Penigalapati wrote:
> This series corrects a number of documentation errors found while
> reviewing the Intel NIC driver guides: wrong feature and attribute
> names, stale macro names, broken or incomplete command examples, and
> assorted grammar and spacing issues.
> 
> Each patch is self-contained and touches only its own driver guide.
> 
> v3:
> - ixgbe: drop the "none" option from the "set bypass event"
>   documentation; it is a parser-only sentinel that the driver rejects
>   (EINVAL), not a usable event.
> 
> v2:
> - add the full set of Fixes: tags to each patch.
> - i40e: fix remaining grammar in the queue region flush description.
> - intel VF: remove a stray double space before "Qemu".
> 
> 
> Sandeep Penigalapati (4):
>   doc: fix ice guide
>   doc: fix i40e guide
>   doc: fix ixgbe guide
>   doc: fix intel VF guide
> 
Series applied to dpdk-next-net-intel, with the suggest tweaks made on
apply.

Thanks,
/Bruce
