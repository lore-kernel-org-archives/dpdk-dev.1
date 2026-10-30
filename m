Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E0606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JlqGkbbb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D9E740288;
	Fri, 30 Oct 2026 18:12:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id C7F2440285
 for <dev@dpdk.org>; Fri, 30 Oct 2026 18:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793380341; x=1824916341;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SI6iwntEd5drVVrWzDJqhRkPKb4zsG1ydgWbCyyxIqE=;
 b=JlqGkbbbZzlVSfNAaUSONoUzTxZ7ql443injC9OxPVEGOzk+dZ/jrf/F
 DSLD4wZydgAm9MTd9qO9TQUg2lCGKgbN00E5jDqmYlKhU6PcZQe9hlCyJ
 HPD1UsKhz8ASi9pxPVt3WBzQ+pdUqFBbhEF/P4F0nVcFAIDh7ki04/ePE
 G4wlZ21VFrUKRq6Lzb+CXba3tuATZMNzQUrx+aLoAwnQycVFjkmYqZ/Ej
 T4+bYHpFQvFyHxsAeCRhVEsfjwncug+RBZxZ4j/IBJj8qno6uTWeyal3A
 I2RKAvzoiMUCebvEqpiHTbKvDyTpGcRhrm9VaJaxRN32T7IS6TNb5TFB3 w==;
X-CSE-ConnectionGUID: bqisvskDSRSPssthXc3LmA==
X-CSE-MsgGUID: MwHXhmJHRc6zqrB0Dq0MbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2044174"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2044174"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:12:19 -0700
X-CSE-ConnectionGUID: Cs/zSqQMTGqGUYSZXRU47Q==
X-CSE-MsgGUID: fVsr/qS8S9ywjLbfATuWFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5832534"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 10:12:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:12:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 10:12:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NruB1VjZeLNNJXkZaIhgzy0O32sbnyaCVodY7xNxEphgaEArKmSTE94Vyr7T0x96Nr5RnNk4XeWGk51jVWcXk1RtUGjxlFNIEDwbm/jMLnBSzZEplPhMzcL1njDqDLSrLudnnwJ9nWPGIta8DNP1rdw4Y5eSulbStaA8IKcYAowjt10x6M8e5nxTED4iMNGYOcaytKB+WqRsr5GsABbDDC8i7fg6tO0+IgwDVwJaELh1mayg/OdB5LLKP5EkHXWg4KyvNTCJd1kObay0G7iaoV3L85BAH1uiXoEj932OQj5iueQ+XZDdQ+5Ne3n3VN/Z3G13Xldzrp+re5CGXyfVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqZ2EPnIBeweGtNa5WI9bo3FAkk4K5J+ERosJDorvn8=;
 b=yO0ITNZnEyOCMdcMu9mrCTaOELVnRR/QzoJhSblMNKZWW5AlDRE/cHOHZQJtFRmCz4aIrNjFKNRn+EKMMeEUozs0KtGdaPnTLxEJrCp/qHdY71Rqxbdi175/pCZyYfATb8two18az7QQ2sIASWwRb530Uoep29ltj3x+YGF7WWFXEn42c/WS3qUEj6j9p0NV3swRhxU4sl5N7Qwd8LexlK0+etIdOTkwEOkq2CRzSYfMYRgF4mDzwFoGfwXizLpJcra9v2Af/zx1xxJ+b/3eXQLVZ6bL+sXjRGEDAvLgpjuV/Za0HYLkcDNULAU5wiPkLBYJOOJteupyejJMkFSafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LVUPR11MB9786.namprd11.prod.outlook.com (2603:10b6:408:39c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:12:14 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Fri, 30 Oct 2026
 17:12:13 +0000
Date: Fri, 30 Oct 2026 17:12:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 2/9] net/i40e: reject VLAN with tunnel items in FDIR
 flows
Message-ID: <auTP6CCPDQQ0bWdo@bricha3-mobl1.ger.corp.intel.com>
References: <5e64cc416c8ab3b038eee6bb55836e0b8ed507ab.1793353214.git.anatoly.burakov@intel.com>
 <6cb6188aaf9c36b9b2f0c2ee6fcf75cbcba1f480.1793353214.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6cb6188aaf9c36b9b2f0c2ee6fcf75cbcba1f480.1793353214.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0051.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LVUPR11MB9786:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7f834e-e8a5-429f-fe09-08df36a8f108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: PYBYpxTXB+thJxS83lUbbHLIJjydbzOUIG5pNjtzIuPGbYQO0a8UNza+P8uxqipktHmE1yJy0cjtNCHhVr6loLN8jU9OHiMrN3fmDhVw35lCQn90EnWQe7nuvVr2LQuVCrLejVuijxUinbCV/z8bWZE7/7BU2iMbjd4v27LHwUrI6AzBipdPFB7xpmQ3yOBYZtGedAbeoewCUe4AFt7q+Bm5iAZbfWVCquRLdBaCLIAyqAUZYp74KkGaJKBeosGjSKEj4X05sdk5LhkmCAUTjEsXJWsmn4LDRiyKmA7JrgNaGwd6CEoLVKsCGlOCVznXIqQxJtEXp6MZpKOWBBYvqF/qaoqf4KVL2yXCJNoJqJ6gsVOiWpW83hespQN2EqaYPgJrEWNzxjkCsCKOYh6ED2x1jakKmuwXybaljWf39E136bJtzNnxZi62Us2+lw0LAexttDFiIVcwviqlsDYlEWLo+qmMiG8uPuEZoUJUa1HMQGp4X7wvPrWBp6OfGo70XflBfzPQfSxza6OeRHxX88jvGPrBy3XJVx3eelXzSkVQNGNg43Mg2Qk1i6StegeLgoVpbIHwWOeCLrer/+1pYCH2ZHgfZB4t8jqfFdi9KX8oyynGlzzDj0YM5MYaewcW8/hMEwLivBQneRdQHlDeaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SdfDhsAQpkf9/Qmi8QBaKGki4ufmJF3B7uEL2FQ8HSjtpxAkdQjzemPa+YtW?=
 =?us-ascii?Q?zW+I0rS+wkszrrCpLY3UFa61Mv4vTR1XZ2o+CS7BAPm8pNPfv0DSlvV5g+dv?=
 =?us-ascii?Q?I84YEgGu6h1vlP5rvc45xuw2O18ba60qXC+QNJr7NTAe9RbO98N4drlDG9g6?=
 =?us-ascii?Q?kjV9QX6i5qYSxiPXaHnaKAeW5jIDOAdElK1x7jmKn7mb5QiggMfFTrgYnyWQ?=
 =?us-ascii?Q?ymqCokKnn5qzJSDR2R1v+H5m3crhC2eNxFN/ZBjOBiAw1sasY9TRS4+1DTMa?=
 =?us-ascii?Q?p39qqR6QO+Rl9o1jrnttirifA4im8Sn/SRcQQgj8BoSscFsqTJxMdPRUM3I3?=
 =?us-ascii?Q?vCzC5S7t7LkUUMhk6Z4y3t4YInngErxh7SNaqERyHdkUo8tnoOt8p6DH1uAy?=
 =?us-ascii?Q?D/sDlEHH656xpOCFb5CpxJ4yOmKYMo0+Omj0+/mSRpJe1lgF6yhmQSQJWEb2?=
 =?us-ascii?Q?6znkYiJErrA6yWWlDtksvjort/DLp/TbzMVU6AS+DalnMFv2w4PEuwqVFqE6?=
 =?us-ascii?Q?jk5051nCcCgD7B6iahtD6EMGFR7B0SehN9oeCZ8Kpblxo9NnkxeYyWFNK1GZ?=
 =?us-ascii?Q?tEsvLfBfzQjgF/XWryXNkLeZbwc7ufBV4V74/gT9PcsiV9bZVBh3QHipOIbl?=
 =?us-ascii?Q?nbATtmKOmIZAu1QwzTW/nhXDO1+j6JSEhxbplgGzBwk7OumZVdMVfyObOMJl?=
 =?us-ascii?Q?FxARHy9HZuyC57tadVeW6ZHVlvZ2LD6gny3BttaLXv0HmZ20x0MZduxRm7A2?=
 =?us-ascii?Q?LHB0BQXtgtVE6ktvBt3/n3sYDN0rigPkAE2zpgmexEWR07/hBK/geZ2Ta/Gt?=
 =?us-ascii?Q?XSfoCypuZGQQBw5j2ucd+Lyfl0TuEmNhXE9WJgTnBMBVXfyUV0+DxM3gPe5f?=
 =?us-ascii?Q?h55aG3B6VydAMJGq4PWIsfvDtK8vAXoiwlYfNkj35F1cC74JTNt+Sf9p0z3i?=
 =?us-ascii?Q?uCnb02ouCRTLdzovITmZ489SXdnp6KR3Na7l6SK5fOe8GcTDYCloEiQVtYhl?=
 =?us-ascii?Q?WxAznXFgPVkDxQaY5B/G1dls/ZxA9lNBaNlNWPyD/cCHRdp/IjlWzM7ilVeN?=
 =?us-ascii?Q?zgC5BTKnSyLd1lB7uBc2V/0YkirKVrNdzgRrpUS1Bk+9jPxOI7ERrKU7/UlB?=
 =?us-ascii?Q?wY+3womR0/7+/z1DxyAn1StNkwUhiISy3Vsz2jQCIRy+HzywX6UPu4xL90Ex?=
 =?us-ascii?Q?YrQZ+ZzFIiHlm0AsWbMbKFevoSrno4ssM5+S4r6b/pRwg/LalgcBTcKqFwh0?=
 =?us-ascii?Q?QEWIA142VkGE4KvzquPK91RCFR5LwqvnYbbGWXPNG3N8eZLTMcIZTJF9reyY?=
 =?us-ascii?Q?b7fwMaFwZSV9fgLRZaCPyXVFhmIzCtZ+TmXzq32v0ZJLtHvaweBEXBuSEyJ3?=
 =?us-ascii?Q?tNBVq2epcRoGk5tfDurzAb6KcPZa/j3QoaxV4p1ol1rvh1tyKFd0yi3SpL35?=
 =?us-ascii?Q?6n02q7S0e139xWozgOzVnPEhR5f5q792YXD3khRbVeHhdThiT+rgXbt12ufO?=
 =?us-ascii?Q?SnJSODbP3NZeIIOk+ht3urYhiUKzTRtWUWceaXbKXSIflDMNXHRZLTi03waw?=
 =?us-ascii?Q?W8STfjJWzU/SfLCh5WRPUzxifjYQXWh864C5Qwbqr75flwlLemgB979Kz+1S?=
 =?us-ascii?Q?XaKdzfYl9RrcU1TFMUq2uz5vjoH4RDpxrwh0LGDFjuxHeCeb0lKycpb5jGM4?=
 =?us-ascii?Q?v1LUslbxKm+hMrtMy8Ozbcix5C4/1QypPCfGAbZgxz7WCunuyaA/Y5zBQ81g?=
 =?us-ascii?Q?ZElmUDQNOFZdsBh5jsHXy8F9uzyVeqs=3D?=
X-Exchange-RoutingPolicyChecked: Yg2jFwxxJhYndn2iD3c/dsgBS2kTlpGK5dLxccb7v2bJ3qOrPh8Wt2e9IOgoTG7hxpw1tHp8joCMTENpVG+5zMNrSJ6AEVjQL5zI8OaH+lkrtlzGuyU0sTw0FY41rMmkrU5zYB17D5t1I3j6hWKdOzOgcMyAl8wjBkY1t6hExh1sHYwHUHMMWbqSpZAlZWIH/4fE4b03Xn0/xx8uGBjYxOHm7N3me4jYQe8/8Y2JA9imamP0d7GE6mjgAscsFiqYRlhYRZ14qQL93KwpmARLXvMIf9TgMz0BlmWW1HFUtGhSkJrD/OOjzd7gz4xtCsNbp3aB3f1YDqhlFCd9sVR7KQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7f834e-e8a5-429f-fe09-08df36a8f108
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:12:13.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ppi1FBh7ouc9zFfRM+ioLcbT0NMouum3e4HnmYXfckZ8FdQ1ALMsVJo/UM8H6i6cMLFgGrx31/1VUpaSv3GwVppaUR41bkw/qxmEpiTUNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9786
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

On Fri, Oct 30, 2026 at 09:40:15AM +0000, Anatoly Burakov wrote:
> The FDIR pattern graph allowed VLAN in front of ESP, L2TPv3 and GTP
> items. These use customized pctypes whose input set does not include
> the VLAN tag, so the VLAN match was silently ignored. Such patterns
> were not accepted before the rework either.
> 
> Make VLAN lead to separate IPv4, IPv6 and UDP nodes that have no tunnel
> successors.
> 
> Fixes: 05432a6e4676 ("net/i40e: reimplement FDIR parser")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_flow_fdir.c | 65 +++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 3 deletions(-)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
