Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D8C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 14:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E360D40150;
	Fri, 10 Jul 2026 16:52:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 21ABE400D5;
 Fri, 10 Jul 2026 16:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783695155; x=1815231155;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0YrA9G5jOtsOOKykBN1fQmsBCTfKMAp4hQE04PHmMD0=;
 b=M8qNml8wgp1q0lsZVHU9LnFELQo6mEU2tyiGsfgZTi99gXmmo+nFXrue
 60Om5HCNKTt6crcPS4euVR3LCioWWc2gWSNK6q3tEsde/NtBt2DYSOC4i
 UV16n5+VBTtxeyIo7tLP1OEXvRIttVCjSGIwMe7s1xBGIiY0mWw61FSao
 FvB7wW9a/JUYTi1Ha9Bzlu3Oox8L6GDB3FsLKWv1SZUgxW2TpnR61Q1PT
 QC3RWm1imXJsTL32xqWU6dU/9NxGd5E/K6eYLIwQxf0lf+W7sXFoQOB/1
 Q40HzcTSoa/DcF7aoz/GH6s53or4/uVSo1SpdpD17GUePoc5iJuVAdVJi Q==;
X-CSE-ConnectionGUID: Ua2cVAZ9RJGadckRrlADRA==
X-CSE-MsgGUID: uU+bR4+6Rh6Suf52IkNvlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95040630"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95040630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:52:34 -0700
X-CSE-ConnectionGUID: mpyNp5jISneNMAfdd8fdjw==
X-CSE-MsgGUID: /Ku1yPiSQke18JCjQC/z5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="250484702"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:52:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:52:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 07:52:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xan4aFsyCwLJrWAt1kOZDRhptsYCtTtSB9azGD1N1imZeEMhY62iv+3pyZa+OGRZCRmVuncDFRH4HB04YPUasqUk7+7m34cKfTHo3UQZmoXJUUfURUosCwvxwUFwEWmHLuG9uNnHuaN7XJFHyJvJSYUbNxojF17vnHXMgBc4i+GjPFEOSIWRZC/wwBZ9q0QwfXKF7DXSRFsWZANZKx0BEiht5sa1wlttvtfvShNxXvhofke3fS4R3KnDoeAEz+zl2gWhNGAfNOHY8qDeJxMwA41BykE/I7cbhLKkorfpbyMxtrV3qWGDPA08TVBRUH2ukVV9skmFwaZicaMQtB+yGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BKCA3tuPGWP1cuj0MHGnZeP0TNUFOCBXKWOgysUYnY=;
 b=Cr8i2f9kwwoQLnA4+kbyXS212+Y85xHUfcePUU+MwpBjGddNx3Sq+sTuMeJd1gBLMuIRqyy4+2rBHFnP0hcGWIqklLMz5RVaEnHyXGYcgicI+MmNnHSJCxvs073HVXBLPdGensLXTRSeqmDemxVuNlh1X9jD4Ve/7N3mIQuvNV05LdTpihNkIdBsTZxQs+SsOJymWRQg6vAcStiRQH0zKMhGfkg9n541lu8WX2gHxAYq6Hi/qZGa7f2y0MijZU/wqdWjtcHGnnx6U/w5FCgy2wwTpB1MI4E0vLlAhYhrMMdIBtCcWNRZT8SXFY2qkfklQmPm4o3jqFRu8Q5S1ju05A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LVTPR11MB9887.namprd11.prod.outlook.com (2603:10b6:408:3c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 14:52:32 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 14:52:32 +0000
Date: Fri, 10 Jul 2026 15:52:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>, <stable@dpdk.org>, Ye Chen
 <yex.chen@intel.com>
Subject: Re: [PATCH v3] net/iavf: fix single VLAN strip in double VLAN mode
Message-ID: <alEHK_HUXmSbB9Mi@bricha3-mobl1.ger.corp.intel.com>
References: <20260708093955.495637-1-anurag.mandal@intel.com>
 <20260708185847.550732-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708185847.550732-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU7P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::16) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LVTPR11MB9887:EE_
X-MS-Office365-Filtering-Correlation-Id: 36584d0a-5d88-47bc-0001-08dede92ded7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TdlhnwfeVcjMRLK8QHfwb2qMGNQYJxKJp5a5iGEBQ3+FyUV8nsg3OT/oANVeppZg8IYa26JzZoKJFKMizk22/RA6HRq41FXd8A3UUDg6enZybtlLu+mnlORw0EXrWCRmm53lA1ipvWSF/1xYS6UntS/j6bPk1jdD1I/dtlh5RrAmR4djJDkwQN4Lli56JkFWvAU99kkhTA+Ui0JD3NOYdE3bFgLzY/S2Jpi2qe3pqrKa3aIsm66ISttPe9GkZr0rkPS5N9vk2JiUjkqfUo4bqUuOemm+KCJI/MEEYhswjz2L07seJkzARwf3yPheVsWHYU0dqnuO8nBP/mNA6mEFm5D01Jq19Uo/TS92vL7DssB31TLFbYp/QrY4QU8mssrkls4Dec2ymkXW9UZRiRAtOpf23aFtBpe3RI6GA31bHpRnbrMLzsGEXrJwcfz0IXQeLFAkUxtTvXd/Gpni8smgJoMSCX1Gk0BuWMIHDAt139yhLc8G7bdxISNNFBmPP1ekHWhukLa5dln0yxOiahaOBEndwdL8gMdlHD1rKmT0vyRqlIHhX4fj1SrY8ZcVjUoynvPXgUw5eEImMogjrGWk6DemMgtEnEdPvnal264gytC8nbPuTmJ7sw5v4h5kP5/pjAwU38WZpXF67CtMmPaILSO+4/YA/XqzR3fGm9KRu9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHjSNxYsrAQyAOkpE2yu8NkJ0afSuplijMG9n+CT5uRpc+6df3AdhfVHct4L?=
 =?us-ascii?Q?vyM+5lzob2c6SnBOqJlWgtwreOyovC5NYc8FJF39P/J9e33IClekWd72o3Tk?=
 =?us-ascii?Q?i38xAl2hz53lbMNwl7L3Goh9zZJj0sAHfoLT3W48A2mjEoGgAIjqk917eFcQ?=
 =?us-ascii?Q?gbfJYe6QdIKe1/Xgfq2AjzHYx74sNNCJW+TszxukTmRCcsMcPzNcfyXIBIe9?=
 =?us-ascii?Q?qqCKzMnTyPP9QxNF8G7YUsIlb18cBvxQOmsckSmbqOY3gWYizAuQt8X9NYvN?=
 =?us-ascii?Q?2CYcYfB45rH13FVRGMGY/XgpGKHsJGn+9l5HUJiimJMGgLXOT/LibPwpt7wy?=
 =?us-ascii?Q?QiVkhdOpz1w0LdCHdK30n2Qr/D4r7z0N4yBQ/6C3oItY6uDjvSjr0Ae9UDnX?=
 =?us-ascii?Q?Q4uN1BZVCbb+CQ/ldnKX4itXpfrd8mf2FmaXCSqUXwimGCi1QafkDqwf/2e3?=
 =?us-ascii?Q?oUqpYDkoXGr9R8pjN3A+IYPY+X5bkSfHtI7kdRrLYlp+Ot2aJM9M4c7u2/o7?=
 =?us-ascii?Q?surU9ovoyGtntkXPFmWXmoXPQ3K7poQOJm5kQdseSWRozkdHbgbiM1O5A4Jx?=
 =?us-ascii?Q?xVgf3mOE3rlrzkuX7vZy3K4lqu9w0fpbduI6g9W0C8LAAtPdbEBCQjjfnEiI?=
 =?us-ascii?Q?TmOwtR8qYuZQJT625b72c3X1bqs90+W95ibG3Tjt3RDLQHCIyPhH/D1fWTan?=
 =?us-ascii?Q?INXkbMErBDVek3UQ6HSrmcmdjHp291qkSX4Z6VL8+cqxIktJ4pH+VnJuyiKB?=
 =?us-ascii?Q?qMF624rLRuGbvKqlGFbFfooYpmJ3eDNPFcyblA43RL+SmhB7YJ7nXdAd6EUr?=
 =?us-ascii?Q?9MataWSL90qS0KbcYc4u0rWaP8TDUXyMXO679PLZ4qqfw0Gv/7osnyKWizdv?=
 =?us-ascii?Q?mBpvpiaCELzq1OAqSt0MhiKSfVhCS08SfCUzJ19PJbn81setC/d3jl7bZNz6?=
 =?us-ascii?Q?YeL0Qz7SDJhQayW64KVCkS2+3NQ0p8Uy1vJ38XaWE6qYeo8ziSbc2XZzO0IM?=
 =?us-ascii?Q?ilW5Nxy/zqRGleDlkGBczr/JKiq32G2xMgVRy8qU/NQGf0k1WxdY+rnEDNLe?=
 =?us-ascii?Q?1elXq/c+pjS5TV1VCUfMykWpP5msnQ1OVOpmWbYtGHDVp8IF2t3xPe1Am6q6?=
 =?us-ascii?Q?fgQsQOQU1UotSXNMg6TFUDZiInLeMBQmpvYkIN4l67QGCR37wH+T8yYeKuA2?=
 =?us-ascii?Q?v1qUZsjL/kmXtJf7Wm7HpoBvOOk7N6mWdlmWWHZu4LINHyjOdIivaOam6aIs?=
 =?us-ascii?Q?uOTnOrwmJlrT9urNY32ZtekAMQvEs0VG3Zcu3WSeh3xrp/p0gNgmrkBjvcYF?=
 =?us-ascii?Q?fYP+OuVDSwTbegbCCPDT6qDTwtioOd/k0FRJ3z7LQh0rGHDsZrbXK7KbYWWC?=
 =?us-ascii?Q?qxsC5wSpO162OxZZHzDPY9dvadS4eA+Xy1rb7PYgmJNidvoZ1rFNjr/e555O?=
 =?us-ascii?Q?zyAR6jxt47HOSUiphYBz0TGLXbD2Yf4TlQf/hb9BY6iCuFFiy0Qs0UOTfS5h?=
 =?us-ascii?Q?CS9tpWxL7z2HFnbpAh7UDHtaNmx7JeGQBuN/nW8csjXSkdGftna6p6xriVwD?=
 =?us-ascii?Q?7xLMFNgfFr2ONRUCbhdiXjSDodeycMiQWIwTwBJmZG3SZRzAZdK+7ircpE0U?=
 =?us-ascii?Q?WVj5TmsapDE2wgJN6X6WMc1lOqADDCdKBC8197owNg/sNxpVcTj66MKIeRLX?=
 =?us-ascii?Q?5qGdfkHwfA/1zxjojrrFqADUkeHdZ3O2Mqmv7YndzWMyGrLZgk6CD/EF5pQC?=
 =?us-ascii?Q?8JwIA7E9dQCgPT3D2Av5DzR7oBAMcvM=3D?=
X-Exchange-RoutingPolicyChecked: h/FrNLr/DRTmxA45qyiUywW3oZ/BfaqW26dhY3BaB66kqTv4o/cu27MgZNXh+5aXdwYUzgOTrT9JBP2HouokEM981pJmNCv5LmlgQ2N8U5B3wnM60SM7wp36apcDO7dkERNfD/ZqxVzi+/KXOXMfnnoEltZIDTktPig680f6nxvy5tNz1wgn1xe6dsXSCXYAxlQMig7qHLq5KegSOsgrRK9dhxqWWIhbN3ex539haA9yVNGjeQAhZAnEMJqBDryupfdJthxaSJrowupALJYn+hefYl9hYW9rCz7gFIJb1oXfdPhPRSQXGTOv6oxoNJ0FZrB7TcdayUGmp9W47+hd3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 36584d0a-5d88-47bc-0001-08dede92ded7
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:52:31.9905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4c4zPh8gAW8LgHj+tl3B//Mv0IZTD2l/tSvIIBvLGGekBYuCcdqZEWGa6+glbbd0UnW0sOXHIxpheI2J+DV/EIWtUQLqBqJ3A9Adqe3i0pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR11MB9887
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

On Wed, Jul 08, 2026 at 06:58:47PM +0000, Anurag Mandal wrote:
> In Double VLAN Mode (DVM) i.e. when RTE_ETH_RX_OFFLOAD_VLAN_EXTEND
> is enabled iavf_config_vlan_strip_v2() only toggles the inner
> VLAN strip setting (0x8100) for the RTE_ETH_RX_OFFLOAD_VLAN_STRIP
> offload, while the outer VLAN strip is controlled independently
> through the QinQ strip path.
> 
> However, in DVM, most hardwares place a single (non-QinQ) VLAN
> tag in the outer position
> As a result, when a single VLAN packet is received and the
> application disables single VLAN tag stripping, only the inner
> VLAN tag strip gets turned off and the outer VLAN tag strip
> stays enabled.
> Hence, the single VLAN tag still gets stripped.
> This does not honor the application's request.
> 
> This patch fixes the aforesaid case.
> When DVM and QinQ stripping are both enabled, also apply the strip
> enable/disable to the outer VLAN so that single VLAN packets received
> in double VLAN mode respect the single VLAN strip configuration.
> 
> Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Tested-by: Ye Chen <yex.chen@intel.com>
> ---
> V3: Restricted to VLAN TPID 0x8100
> V2: Spelling correction in commit message
> 
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
