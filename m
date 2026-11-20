Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF2606A331
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PcSj65co;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Z5+Kg97y
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECC92402E3;
	Fri, 20 Nov 2026 11:42:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id E06D640151;
 Fri, 20 Nov 2026 11:42:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795171325; x=1826707325;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0S56qaf5s9qnVf1fJwbZiEcfDp5O5PMrpuKGbimVC+w=;
 b=PcSj65coH2FMHC7BS/g5FBMbD5lU+7PLfJnHHZDnL5MK+y8MvtHpPvm6
 d5YB2f+Hy3zyf6PbEY+mNldtAxkcTDhvt/yyABDmVQWesdIgTryr9IfQU
 yQp2Mxe/hZ3x+dIhTALUIhtMDSJBzDjVzALRTyIK1ikVGUNXREANlI813
 iTrNsasDx0T9Ik18kJLmTkydcZeK/A81vSYhFNEN/00/WBd9lTI1GJv1r
 t1cu0orCn8pjplLkXS1agYsVL7w5cWGpO30oGlP+vL+bHqjJiN0EytWVC
 w16V9XCvRDA17cLgdw279QzAp9Y4w9Et/vjZbdDiYLZ0w97K/BbRe/onJ g==;
X-CSE-ConnectionGUID: Rd7mW4rmT5ClncZdhC2BoQ==
X-CSE-MsgGUID: 5YLphNFEQQWd9RFUsNXEHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4035141"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4035141"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:42:03 -0800
X-CSE-ConnectionGUID: 8ytVbPFFQaWCFrVQixWlUg==
X-CSE-MsgGUID: v/olIhM5SLuvOxGi/ziMuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="11004452"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 02:42:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 02:42:02 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 02:42:02 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 02:42:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7klniipPgQUss7AyF5/vdyv2FrI4kz3gpfC43dsRZWuS8Blm8wQoLsxnDBEkk5mITWrvOxSYzsvz36csCwgG9lz3RRLOG237fDnN/vSMQRp0FOFNykvv005DGdkm/VGz7WLU74EioNs7QwiL7s7uIHuFKuKjU5xEx66DdMm0M3kVd/YxIcpJN/GTtjauV0qOQ7pAwWzNASTLcKAnzVlqwVwhmSlJ+RS1+99ybxKKW53G8y7WrXMpQtRGAxcyu76+fJewhwjea4d7OLaGvcdNhZNiAABEnBtFn5k+0Amb2Gr3KdDg9SqCRe70t5QnrMfgaO0K2MhjCQmeM2Vxynjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOsIhky3Rdit13xExpZg93srBtxcAS1yyeXZXZJiHDY=;
 b=BW0RkvOST2vOCi0bAsk4BWV6vl3B1TXsxsVmIvKRylPHCX2LTZHLK7nfitmhT+39BSQU1OiJd2ToY5sKrdOnJv/f7VgQKuDfpRTbGBCGso47AchNPVYK+ZM4FoAW3PEPbBcxeOiD/VsGcrqwsN93FKjk2AqTSRuq/mGbgBEq+LxyL6a/ZYdC4YcxN6TTiYekD+HIf/N5GyqPCsMqQ7OpxVOVaOHDloJjFxPIqgVpzlkpkBea55en0yPOh5WyItSITjiI9rRGUGrbKpS6B32i14JGEJHS9LnvROMve7mYXAuhbnRU0c84heioe5A0fy5UUAf/ZS4eQrIP3bQSxNOm2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOsIhky3Rdit13xExpZg93srBtxcAS1yyeXZXZJiHDY=;
 b=Z5+Kg97ySGgqJQKjJd+vTswOoeCb2gya63Imnxm2RyPIBjfTQ70gEmumJwFe7mrt6vJshoJkun6wWt+4VhcW/8YW0OjNE0lkei/7QDZw0gxuCm67VTkLvvJ4n4N1gNE7rZ83ENNkt7Uy7yiaCaLbHq40ZicduP5eGPYdAQrVmQY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 10:41:54 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 10:41:54 +0000
Date: Fri, 20 Nov 2026 10:41:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix silent drop of MAC addrs in ACL rules
Message-ID: <awAj7V4oE3nRDr_O@bricha3-mobl1.ger.corp.intel.com>
References: <20261118115724.2708792-1-bruce.richardson@intel.com>
 <IA4PR11MB92787FCB7016C8CB60DF4CB58E792@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92787FCB7016C8CB60DF4CB58E792@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA0PR11MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc22834-c7be-49ee-9d90-08df46f2e481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261028144727099003|261021121427099003|261102123227099003|261021123027099003|261021133027099003|261021135927099003|261021130227099003|261026121527099003|261026130827099003|261022113327099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261026135527099003|5023799004|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: X3EPtpfbPZVOdqEpZ1MyEnv+s5ZsS0jv4lMsFPHzLz/F44rbbIMEkTNODzrCfyxCzUvkHxcairfDMmzsxoGfHBVgOC8NmPVlCi81PeRH5REaNfv7dABQkUCWL9TZkmgM9n2d6zqaf7NbR92hivjMT/XzV/KsLcFkIrqWXzdHGtCOpOmQGS/B2/vbfn6Vel6dzgsjjlLkMYrq/hnDOG5+2BKEda44NUV1QGvXzf2jAMRWwFMKcwaYe1Kv0t7i+LFjn3K6f93idrUxq1qu9OGL+z88ggSp0qTfJEvNSV79w7qE71Ds67nv5RE32OoNyBLBq7x40Bg9qLgy3+Ax46+D31zRO2zViBXZf62w+7qabpTU2IZiRlCH0rtl3UfO805YbnHC5L9Ux9HLw613nVqRYgRms7z22rxL9WtrC3LIN/n0X+3DCTYr10afxeH6vpE4LE+eNy0+kAsWUKHkJxejG701XARK8BQtebrD7GB7GmurSjesTNwGC7d55/M4d0rnuNbz/7X2JJ1PTfG1/CZZQOqhZM6xgPUDfGebOVOp6CJ4iFn5s7oNvg5JDLvLQ/A/LZ1dVxBJRqJ5eYWCtd6wbPSGO+EJ+hib2za2p7XmgsswdzMEUfFYgd0VNP+Hz1xhA4HId9heSYIW+G+URHyza32klajQDVGugdhAgxU4/KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261028144727099003)(261021121427099003)(261102123227099003)(261021123027099003)(261021133027099003)(261021135927099003)(261021130227099003)(261026121527099003)(261026130827099003)(261022113327099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026135527099003)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VL1HOnrCR3UBq+G8CClaW0nxOqMGWY4q9fmkEXmf4hb6sTfjWnsMlGHSFjbE?=
 =?us-ascii?Q?nedguof023fMXHLU1WVNFWVP7J4SilvCOy+/9In2xQOaJeOdXMhq7gDnRfB0?=
 =?us-ascii?Q?mt4kGw5kRqREhuZKGePERlCWuBQ9eKkRU7Eu37tOgTegb+V4LmvAy71iKCny?=
 =?us-ascii?Q?D+S39tOZrDQvn7U+CsLHFq5c9Yb+haCmdXGVuSl+rYh8AMWnyt8BfrtNulfR?=
 =?us-ascii?Q?kprQYaWEJOF27Al8ErTR+JOd/iV+N+MCpvuiwlMO2xQw6BB7NWLKouAGrD0x?=
 =?us-ascii?Q?0D3dwRobsFXiPtUkwNcCPgfpMwwxWJWLeFKrRo1GZr1DNptLGwFtKFn0jP2T?=
 =?us-ascii?Q?bvmKGv+65OfmXus6TBCQeMdEsJAM2tPtSessZds621LpcFvTqUMw/VXzDFTR?=
 =?us-ascii?Q?j2prH7x17SlPsrFwhJ5/Vn/PrXU8jlHAvbtJGbT9e6PG8MC9eWcklmXu3Qsd?=
 =?us-ascii?Q?5ZQashsbPZDKUM7Tej+AN3xyXw6ed8eb3GXEJM/Qqxdf7DYmvKQrazqN3ITs?=
 =?us-ascii?Q?667+iVUHdfUDFIeGaYB7KUNvQ22wrryn37m/4AKY//6Fsiw336ZRGplGE7w8?=
 =?us-ascii?Q?7rib2WenZgaoRZJL5BW2CNlEwEXVh+vtRSoLzEax2pALATfJIeIgDuNt/0mZ?=
 =?us-ascii?Q?A8V0sm61N0Yo4XBDrdtwXW/3+U1wsqoB15YmWnngzzn+Ol1WYWbc6PCYZfsD?=
 =?us-ascii?Q?wUQr3hgAka6dO8B9+t7QCkiBGkVDL88Wyh1SK39w4uXEC7qHH+IrBAwU51QW?=
 =?us-ascii?Q?sZhqrkPPP7ijeJTRYHllo9lVIy7pialRir0FlNVjF8LJKLLOkChNzJkNLEyT?=
 =?us-ascii?Q?V+AJuZScxTdLEYcXoxlyVWtDHE3MjAapHJsAI1EUgEfrOdUNlxyGyDimFShL?=
 =?us-ascii?Q?5G5JkYAVBEXi+wLXn/UH8uJKFLSsxliL4YAzSKxLPQIzzYONHCxTn9Yo22/6?=
 =?us-ascii?Q?2WFUthWdYzTkKIqGZoA+DIiuu7hWsySIqwa8m134QT0Bznhffu+1zvcpAWMX?=
 =?us-ascii?Q?l86+b0+M/EqkAUPezQsa+WrdcHkJepKF+xReKZRHQ46z8hTLAZu/BsI/71pP?=
 =?us-ascii?Q?6SK8OzI+fb/HsbQ9QxmYYPoOZGwHBURoQtuiDkRPjTHf1GynAqfg4ulEJ7fg?=
 =?us-ascii?Q?9M8ZE8ME0xQ+sKOEGgciTEYH6PHmMo8KFdY/8Wmdzup8Xd/XIxwMA/5GtOwL?=
 =?us-ascii?Q?VoS549mdOqnpgr61Fh84D3ywInJyZ3HFpdY/295MjgXdc3vN+UQb4bVkfOYU?=
 =?us-ascii?Q?uYQSjw7XzPYqtJ7a6XcSK5C9na6HOW3T1a+tahcdi6rXm2HzQchFyQiiWzat?=
 =?us-ascii?Q?3jIIcvJdP03S/ge50yFcObB+BMAN+cCg4nmAwAIFks+qJcvSUIRecWUXxI4a?=
 =?us-ascii?Q?KTBJYyyg3pAbGa4cNN1t3068ZwI8xKUEJ1n17eLPxI3qBYswYq+v69nOoXds?=
 =?us-ascii?Q?e6uZtbjYwdI5nGLMAj4Te32ncFQeadPjpLzCCGKu/45VNd7AM/HSQSGfP/zY?=
 =?us-ascii?Q?DBp5oExKMhJArl1xoakhlIwoAaLCmLJ3tZMgEAUIzwBm9MEHh+SVupGqHKzU?=
 =?us-ascii?Q?h8q8+CSIXjx5P/q6P91sNfdlylXrKHjNh/A5WLAc6riksR4UeheSqeL5qdoN?=
 =?us-ascii?Q?ySGtB+bqYrdPaxKTbZ2BkirYX51vCINXaQvAgWvEK1vLSf565yr4O7fYtV/H?=
 =?us-ascii?Q?WmViMloqiS0e03CwoVW1J4uMYfof3BU/Ttd3h5K3HpMyeUlrje0PFux7WQ9k?=
 =?us-ascii?Q?EI/GVUeLvURYwlvXSK3WpeMyr8V/Fdc=3D?=
X-Exchange-RoutingPolicyChecked: E7KNvyFjA76pv+ykfb9T0FWkp3bfk4PdUr6N1hofub13fDcxyh+2ljOc6pFgEz2UiQi+WkL4uCEeL70xDXE1tYLDN0O6IX3mfaVh+VOvv2tlutGpBGLPZQKUbyY33xUe0lsfYEj1R4as1I/Wua68P3BrkN2KFTfua5LjiI9wHwx+aVIsIDv/hhUs7iI9axJoSO+AvYuCyHhSXKzTmsW/MTi2HWJodQCLYYd2x1U3sh6I71xJZrHnyDqjp3GgeY83rWSUIVS7bWXUydFpTJmTEYoNp/PcSy3jTA2j2U6Aiu2c5UMEMQ/OlNmeWvKeVHNC8p6Hl6OprhEy38jy1cPkaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc22834-c7be-49ee-9d90-08df46f2e481
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:41:54.3318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnGJ3XS+74g+nyrwjsMrY1Qpf8WYVKg2etn3f3u5FfwDrCHKaEKNK/udDcmHqNYLS904QY78HPt+kfwwj22LLALJvqIJZT38GPFlebC6fqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 11:08:39AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH] net/ice: fix silent drop of MAC addrs in ACL rules
> > 
> > For devices with 4 or more ports, the size of the ACL rules supported is
> > narrower, so MAC addresess are not handled there (see [1]). Reject such
> 
> Typo: addresses
> 
> > rules in the ACL block rather than silently accepting them with missing
> > filter fields. Those rules can then be passed to other engines which may
> > be able to accept and correctly implement them.
> > 
> > [1]
> > https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/ice/ice_acl_filter
> > .c#L170
> 
> This line reference will be stale once that file is updated on main.
> I don't think the footnote is necessary. If you want to point to something
> you could point to the function name eg. "see acl_add_prof_prepare()"
> If you want to keep a URL, use a SHA that will remain constant.
> 
> > 
> > Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Code LGTM.
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Applied to dpdk-next-net-intel with suggested commit log change (and
spelling correction on "addresses").

/Bruce
