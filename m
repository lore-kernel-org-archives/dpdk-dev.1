Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20408C369DC
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 May 2025 13:58:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEC7E402D3;
	Thu,  1 May 2025 15:58:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5E09D402C5
 for <dev@dpdk.org>; Thu,  1 May 2025 15:57:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746107880; x=1777643880;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WthUA7J0UJyNjxNlRVItHEeZUwXIR6QlH8AxgGcucdM=;
 b=UJkvLyxtko7DZJiVZwbN/jtFx33DazIs4SEDOEx3iikJ2kwfbmtSPWfC
 kDrSSi3H2yL6252Rec3RedAD2lhqKWSF0TCz6p3NDvm9qoVuFMG/lr41A
 YrGW3ayhw5hTKHrtTUE+T8wicjseKmCTjM01s4vvcZJvhRjzO5lr5Yahi
 /+D1MIE2QnvAO51hWnlick291UymsakbjeaOLYpPrdAnh/Cjirfol0QMJ
 uYG1Ge3+QVMahfYAh1fVoWjXQsjMqjkh5c0hfC1tAqIoU+WtPMW75YC6Q
 pU31FzEiIMhLrOM8/B72kvnOLq5mT1we/iy/Wm9kU1pTm2+Usi6XLrj1s g==;
X-CSE-ConnectionGUID: ozWwzcqxQJKcZbeymvdtlA==
X-CSE-MsgGUID: tgi2joOXTceF/FcGnMUQ7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="51590505"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="51590505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 06:57:58 -0700
X-CSE-ConnectionGUID: Gg5l5ag5QYSB8gvpqVOVVw==
X-CSE-MsgGUID: 5COVxCZpT1iGAt/qTfjdJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="139535435"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 06:57:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 1 May 2025 06:57:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 1 May 2025 06:57:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 1 May 2025 06:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMRQ7m1m7xY4xbIe+Jt21gnXZYfgayjuqi7snNHn+mWijkFd1tJN917e7mW/+cABrBJ43BQKL9ZZiJKoe2EvbTy97RqhymRMbQxF8qtkGk0/G062wQoI2OY1fnf9bPTawZFmsj645vUEH/WJ6V81Df8C1GS2b9NCXJNzeyClg0qcKiiBK8KtmZedG+8V9yUajvr+5jq1kJAYOLCVGb13w06ICFiZTsV7UcAMrOjkvicPSdcvZc6FcgYjqfUNBSLmiorxXrmcuFRz7i2Hyz2p/8UgONYac8YbFU6pd4UQkqmBLCtJpoJmmzfQEY9EwUtHb4wUysUoZuYFZrjymlV2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p2k/5A2JpNDzRyhDFgcy5VNa1LVyA6P3l50zhpSeBY=;
 b=qUnMhH26piKipiguuVn4/W4Vs1fOyHkoHG6/YQKyDxCU6R4EzU2qhy9JOokZdO7PdQv2A8TTtxpucr+WpHj/2sfQlgCv5W6SFrh/Yjvc5tzxv8KX8HB9GQOAbrTvBx4SXPLjwQmemPk9JN7SGBcJeBlz5vNzmp0l/eNjXjb+jIWo8VHGyIK3NyS9C4xCda2gaLKMtnK1Qyq/J9k6221NTYNRjfTDT8/SjmI7L45gIxuyHtM3m8ReMIJ35a+CRVDg4qfKlWvvk2sucxgj+IpsQUu9/6GLg8W0fBsXCKBw0mbMeLd87xOxjMzNzJ+NOzLWOBc3jjH+2HfxufC2wa9p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6836.namprd11.prod.outlook.com (2603:10b6:510:1ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 13:57:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Thu, 1 May 2025
 13:57:54 +0000
Date: Thu, 1 May 2025 14:57:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v8 0/4] net/intel: using common functions in idpf driver
Message-ID: <aBN93W_aRBqkwra8@bricha3-mobl1.ger.corp.intel.com>
References: <20250312155351.409879-1-shaiq.wani@intel.com>
 <20250428092135.1058532-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250428092135.1058532-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DBBPR09CA0035.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: d2aa1d4a-153e-4fa0-b8d1-08dd88b82b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jU6kdLgsBfYEaoNUgKs1C00CdQBzt+vxo6bwsv0amxlFhV8MPbqt7/xIFmWW?=
 =?us-ascii?Q?ojL8XVIa6mC7DSUYQ/8reQIa9JFQ3PS9aj0QSUVDOvod+8phefKAgtB0TJQF?=
 =?us-ascii?Q?KTKXhlDIT8mrrCh1ERi673CSlZ85Zm3jv4brmRZD2Y/OAC0Ys6mddzzr6UpZ?=
 =?us-ascii?Q?4bh8SXWt4bcwblWMqQ0Pz/5NfsEp5Y8S++WLweXrcjZ+vCQvm9jL264U6DO3?=
 =?us-ascii?Q?EdL+nM/ctFF8Mdq+SPYvxa4zsTXBGrfjHsnm5y1XnGb7RgNdpUsscA5MuRh4?=
 =?us-ascii?Q?lE9pqf5KLR0MH+hllfC4gA/EaESqrtg2q1b2pA2+Lvpsu6ngZF7gqVazlPbi?=
 =?us-ascii?Q?s2ULY8OmQrwHeROZJrWnDjRdFPLrUp8+A4RbmKsqg58EPzcqgcPCPV9lE3RN?=
 =?us-ascii?Q?57UU//IELGh7QTbcZgY95TGyxbfRd5WrsL1O+08aVrIk1u/Fhn6N/Z1M4/zq?=
 =?us-ascii?Q?ZvSyCeULUSLYpcJ6Na+atX3DwMdz9H6e+l5todHBLuj/Cmpa2ujIMGEifGhk?=
 =?us-ascii?Q?iHatRVKgiMMhRdblWJqAWEA0TX9+uy8vuggZuDutendv3b2UW1ho6zfqTtcJ?=
 =?us-ascii?Q?ohy0gNRjH3HJ/2bZcqToOtdIJnek7O16MmT2NwlTkr8cFw3aPbgyPawdcHR+?=
 =?us-ascii?Q?pczZQpoi1iuqrZJu69azesoZPxhcFOUdJnG0MjZdL1wbMPdzzLhDCNOzX6fy?=
 =?us-ascii?Q?rYGPg8WD8HZTd451+7vJUjIEfDEgwuOZE7y9ecoDIigAinvYQFBz6QoAHFcd?=
 =?us-ascii?Q?hcMyE12hVDJ1iV09Uf3+0VXtW1cx1Lxg88LGXoYCU7Aw99e/wWR6IOoBQ5s+?=
 =?us-ascii?Q?CNS4EqQZ24QBUKFgSyVRlzA1IPnC7kWWM2H77Fzv5DneQI2EykjdX/sqEPQH?=
 =?us-ascii?Q?qkhM5rkhbR3Ruj7fO2dJUIye1h5HWO4yUAEwIOX5ouZK3fZ5BD2AAK2jKCw6?=
 =?us-ascii?Q?Ns2vQPVQNsZtg6Ss1ZffONnD/2t4kcn8hTfel5ZgWuo5sQZ7VqklkgcjSStm?=
 =?us-ascii?Q?NkaTgyX0sUGQuYeeQ9alAMJw1H36NfNX7DmVizkE2qta7Y6HlBnlm8uy5v2D?=
 =?us-ascii?Q?cxlvibE/Tf1q519lNIHyVrphoLRT27zrwdkMBILQ2o+h3taiP1BLRh+IhnFI?=
 =?us-ascii?Q?vduYn3Dlvi1mWsLRx9UJEcdP61R7S6ZlWKkGbKWfYatH1CnTLQOqzbLDYJxU?=
 =?us-ascii?Q?QiU9FE3yU0elAiQmZNl1VKUNVyp3l+ngFjwgSRyXqnM3IPuDk+lf5mpTbGKJ?=
 =?us-ascii?Q?98EqmKkkB6Dxv0mqs5K39mQ/BQzX9iDmWbJLMLoxqvemToaH3uFXdeG2NuKP?=
 =?us-ascii?Q?kuUP9Igo8Y+Ckf+lyvoqUvetKikss9LFDodxgXbja6gVyohT+pvffw4OJLB9?=
 =?us-ascii?Q?xMdaxD+rKSrqxVMlcKlhkrp3ObgrKbmFXbguKZlxtadVAR/frg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HkBUW71SpxLy3C4X+EzVEfXOStlPFfoDRS1JW4VM+n25tLlnn6oRmHWoVoM?=
 =?us-ascii?Q?qxtXx06mWn5no4aG3/dFUT/o0thMXczbl2M1CjdDZ2dWRskdlpE2G+ag3qQm?=
 =?us-ascii?Q?QnJaChTCRgqEXafzSyW35vf8rsO0niuMM4nG9AQSAHPK5ip5QigAJPnhzcKZ?=
 =?us-ascii?Q?VroDtWZ5e28TIrcXx6X9oiIzVktz2VcrstlORyIXz2sYeQe6AOvuwEI5zHSF?=
 =?us-ascii?Q?mI9V0sej5e1kkyZaSwPgcoWaa3GLcU4DfawiXg41JOyKvH5EevUD0l6/+w+R?=
 =?us-ascii?Q?SiZ1MxqgqEpxv14foerl1wGZKh1paoHGRJvq9ZQnOWXMxEaRZZW6xSHApclW?=
 =?us-ascii?Q?4dhPxeG6f17OBrmxr5Lyml6FBCppySP9Ryuqh19DAUyVkOWUMRxwCNtK6KMy?=
 =?us-ascii?Q?9hjdrati9/qime2qOdaUvXJs4Xzgc3G5xdRzYHCMLW5Jj3RdgJBpl67HUFhM?=
 =?us-ascii?Q?+nFzOtj+RjkP3SB8HiUQtSdJRAKHBiYMIek+jfBVqAVtK8Y1roFPMBqvVybV?=
 =?us-ascii?Q?oEvM2WtRt8lxmah0DrBg30xcrg7W4gY4C7U+K3r92BbnI5HblwSV21xNxvwF?=
 =?us-ascii?Q?Pk5HPfhAB5MtOKzRR0Fy7Ty4L23TnLlv+lU1DiyoygXlJmvWl9WPgkgXNgvo?=
 =?us-ascii?Q?SXKB8hygJ/+UaW67P+luKMLLrdJ6NqvrZsWatJoIkK7G45EHXdW/bZSqgUiR?=
 =?us-ascii?Q?084jcltPBLX2Fsb09HMek8rob3ZvD14eyi7Azw+d2vYw80v+yXkpt+Ydikc9?=
 =?us-ascii?Q?KLhL7JcHATJnOR1HUE2LdaeiSowf95h+8vfsJXB2BsC1c3oMOsJ8m9NXD6SJ?=
 =?us-ascii?Q?jkE24oxADUY8iSUo8u9J8Vxu/SPV6Bz/jg/PKl4wbFmUgG3lvAx+0k6/rGkp?=
 =?us-ascii?Q?Ya1v61sIsiTtbDUh6NzyZ9Wf1ijsESujnPiqgUjya+oZaZHQUy9VIzBJKKdj?=
 =?us-ascii?Q?zouCv+bBDjnAcF1cxXSKRhulvV43Zi0lvB8JNcA5LzqSAFuHiNQS3DiqzFdU?=
 =?us-ascii?Q?ig/VU329qVi3ggJEdJtAh0dPR01otZ6TDRksyRgtGXT8MmyZIoRq2kjU54gN?=
 =?us-ascii?Q?GoKLHkfx5EXkT3ELNLlQhAHF5M2fUvmalFWM9E1kkxJkW6tIlWflzAfkAmKT?=
 =?us-ascii?Q?e+mSVPDCAcUktnthWGS7/gTWgyyQvg+oab+TiXbthzV9rXp7psZWWzR/Kb3h?=
 =?us-ascii?Q?/zhM474f7Or25RIJk7D/rdaAkV0X4ehNtQpuMSrShkJVMNoFSkhHyr8+jICj?=
 =?us-ascii?Q?edoDvPn9BXOjOBqR3rEDWZsrLLOxO2TCDP7IgJuMoMYlOFOEFYgFMpZdTh+W?=
 =?us-ascii?Q?ErGLQsL38E/n/jGv1IJvZanrf5coV4a3UpdTOlSrFbWnr9XW7NPl6or78aQh?=
 =?us-ascii?Q?RNxhPoZZazLjhH6ZuqBTTdmteXTrU3qWpd9gOxXjTGQZ2UryK4WhEX/Ot/68?=
 =?us-ascii?Q?rsm44mWptCGony8T3cdqt6yCieLsrmbHV5tnfrLrpOzObGTaapcRtF3nwzyd?=
 =?us-ascii?Q?Z7tct9BHJwF2EU2IM79Dvk5S7C//3vyozPqj8+Qg+cQmb7Xsmfo1qTlicC/N?=
 =?us-ascii?Q?zf+K8l6PGcdRv1KoYpbvdHXdwRRQ5b/niYIhj+kaVffCcfH2CammblJX6LXT?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2aa1d4a-153e-4fa0-b8d1-08dd88b82b7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 13:57:54.4033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LtwhoEL06qFPPW4zgddM8rToqE6Iix77b2VTQAiP0nhjgGnGapikF5FG3pBgnWutx+A6iehIbUmwb5AhGCbrbUer5wgPtmlELnk8j9L+XkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6836
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

On Mon, Apr 28, 2025 at 02:51:31PM +0530, Shaiq Wani wrote:
> reworked the drivers to use the common functions
> and structures from drivers/net/intel/common.
> 
> v8: fixed idpf_desc_done fn.
> v7: rebased on top of latest main branch for a clean apply.
> 
> Shaiq Wani (4):
>   net/intel: align Tx queue struct field names
>   net/intel: use common Tx entry structure
>   net/intel: use common Tx queue structure
>   net/idpf: use common Tx free fn in idpf
> 
Patchset applied to dpdk-next-net-intel.

Thanks,
/Bruce
