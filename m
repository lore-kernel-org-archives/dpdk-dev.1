Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8E4FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 15:43:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78F924027F;
	Tue,  5 May 2026 17:43:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B6C654026C;
 Tue,  5 May 2026 17:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777995811; x=1809531811;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RzOePz03nn1b7baIpLuVkZHYSPmhqBfH71N6tEB6tEo=;
 b=CtPFBiOYgPpwSlEW2CINLFFNBeCNGSm/IilatX8Tp1HHVl2GJsSjwiav
 j0z5rKdm6K5AkG7XxT7HGm4Ga6SR4IxQfT0+CvivjRaJx8V8tUG/PZeyC
 O9eoXf8E1sqBU/r4gral849jjEiNw8IN2EPwqwzlnkOwFpBVkB2vCb8WL
 WfsLkfwyFO+9Gw1JQG8TCQIezKq7XGNLigTfmWIBTOnmLsYoJO7BF/sqY
 ZCdMeaQEDHgvf2dlKPWjv+Jy73iNMhTTiQrdW+HIqPQmLsfxuj/i03SzW
 glVzcbSsO6XHrfW3rZBZbFk5l0JyszeAmsE4dDuZc1NkzetIiqOKo3Uqj g==;
X-CSE-ConnectionGUID: b0nQ55C5R+ikEZvCr0ulWg==
X-CSE-MsgGUID: 7301lzIgQJCStuAQyCKsqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78578494"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="78578494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 08:43:30 -0700
X-CSE-ConnectionGUID: DqG9qcpxQZat2OoNcZtcvA==
X-CSE-MsgGUID: 5iY+HTxWQruwuHl7chbkGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="240137612"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 08:43:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:43:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 08:43:29 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 08:43:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJXmqgdrb8qFFJi6x2Fe0SeUwBCm6NRFZAze60N1kWzK6rqcqVlqB/v8DApDX4XMuXVDY0vqbC07LravVGEsL59exV/jRPrmyTN4bnhH2+L3BPOi799WRuzXBIlxg77MmC0Qe5Z1R6mGaH+D7YN/q/el+Y/XejiXTP1HnOZrFsPlPESJiLGe0KEMSm0rCQylAz1DEc0kZglxKpZsAfp8fNmouXwW3FnmsaB3L34Eztayejf9MyZDD5FhTKOaCNb4elD/JuqEluGVNBBWSTl+QvF+/Lkf8kqSC/mUWtjgg/T9xwblQPOvf1KQXyFw/6xlNzG3MFWzl9eqQDyUyNDrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nrzt59l2AgVrNfUy6K0slxpsC91M/3MOZJWrNEwVg2M=;
 b=cb7TNPmAY1nKIExIRrSJqqjNsItasApN/mdivaVhfYwMOF8QSzlbg0VQnqQfiDCr6jIjUVzR/5qd1DY0wpEBoqynuX0bbTKTVbYtBok0ZDfA3OGcxyt1MYCP/vn7BgfXYb3Jk/e9vewxw+AwKhCPrPnoMwT9NCJ0MzZTG0y0dyhfQib7Ahq++wDpuNQFxWFBHxiCON4jvTlYK7TMhitccz3IkCxi5tsUdOfCC9WOHuMckBI51gTz3dtkDuGOhjgbqdNwqUMQOuVtCrj6gHG1re8owoPvWNziEVcCTjitS5mjBKLG3qGFy25n1PmgdHbidH4/ImyeqZDwbBa1Ht5/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:43:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:43:22 +0000
Date: Tue, 5 May 2026 16:43:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Daniil Iskhakov <dish@amicon.ru>
CC: <dev@dpdk.org>, Andrey Chilikin <andrey.chilikin@intel.com>, Beilei Xing
 <beilei.xing@intel.com>, <stable@dpdk.org>, Daniil Agalakov <ade@amicon.ru>,
 <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>
Subject: Re: [PATCH] net/i40e: validate DDP segment header before use
Message-ID: <afoQFEUOA2HEQL4P@bricha3-mobl1.ger.corp.intel.com>
References: <20260427154401.1813519-1-dish@amicon.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427154401.1813519-1-dish@amicon.ru>
X-ClientProxiedBy: DU7P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1b5dd3-308e-4dfa-97cd-08deaabd099f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: XB5AEb710KA/wzd/PWFVa+4WrGFZsWtH+OYqSXm4YC4ejNg1/7tmv9Zq38ifPDBMon6tTrjHMHrCuR4u+c9MB93r6yLYtdch59D+CMrBR7s7uj7LvbeVMG2sOJs8D0gNLFTkRZPABG0TU9lR8zjnVzGfiEjNnNE24CzfNP/u4SvJ1imKICYE/QLOAwrjDj9E1w60e0ea5md7CbnsUAoK6N31BHWTJoyDR3/lsNqVhbQEZHBoropmbERDe3UeQgRHRGGhm01BGoMMnLbLdqFvhglg7KWs6CMcePakd4gKJjMmsBimkzVfyzAYQh1mzRX81wk6upMoNrOCe//U40CKVFZvmLEu/Ra8+pmNu/PjrZQ5nJjke3882thnSbYOs+j9odaR9bYJEAbCVo4gVXiFgOQkUvZCeOVIU3W5eaDrptn2doFLpMomJp6Gdpv4waIs5dKPBqFHTYHBjsfe+CBOcI2XRMHXtY4gs8TkPWLhAhvIrwjXZ2OSO1FBd+c270sWcKEj7WB32RDRgH1RZrgRjHnyIBzb54SiDpnWjGI3CwiiZOjinV++ustDbxaKnyRNL23z35g4T/yiLqQ85TLLxg8xVCUl/4AupbgM7FFn73FrPoS3wuae6k9O3Ubb49Y08lk+p/D+vvtb+9PToS+Afv2oL7BLF4+eWM7a1NSBMolvYbcGtHj5Y/g/hM6Ikwer
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?srUPvCAbFSxsMqiTV/pTRfPT/CFAjn8NsnW8QS5MmMjG5c3sQxvEfMf1yJzI?=
 =?us-ascii?Q?KjM08VTUEV4Bl6Qr8QKx1snAZsnOoocRw1MgEZenFbAG2JRWWZz0S8mqNWay?=
 =?us-ascii?Q?Y7Sj6Ie41/VOgqkVarK3FXozDiCYCS5T5OBDTndBDLizEtrNRNK8ynOEHQ5e?=
 =?us-ascii?Q?w4NNbGUo9Tf3WfyrvmMn5m4s0l/WKraYe+KX2tVyn9gxQg/KtjKiNLdmSlgK?=
 =?us-ascii?Q?2Ydr1weroYdPePJdfje86GDdNWU5mj1Yo1K0cq6DB7jlTAu5mOdJXgJB5eKW?=
 =?us-ascii?Q?HDiLVdsDDlugcEnH46No63/Jhq3QP/QehmI/7oXaQH3chtpVJsiL8QC55wRH?=
 =?us-ascii?Q?gbTvDg+7imSIf213eFQc4HFHrRErpeeAP/T/yKFhxsv7R4TYCwtuQoIShTzp?=
 =?us-ascii?Q?VqI4n/UbtEJoXJFXVnjyFcmxnTSToVnCoajKFop+Pu62wwvypeSZ7kLPHWjm?=
 =?us-ascii?Q?V0H/IE4mTDx1T72mkQtoDddENMlKFln7XPUHv/RaSFOBcDmNdMjD/kh9XUdz?=
 =?us-ascii?Q?G4VZdFqahZRNgc4brb5h5nzz6B0CkJue65RHIqWCR3tpHJvBT8rBnyUFco9Y?=
 =?us-ascii?Q?E4U+TGHvd1dZFSm1/igsRzI2vD4qKjEqpmL90Oa9WO20ZlApxCJc2mkaphWC?=
 =?us-ascii?Q?aFM5SUg1if81SELCvsXSjNAJBMOJvCTqEsMFY2dmDnu2eDALCl5I9/eFHg2v?=
 =?us-ascii?Q?N59atEa1YrYbek4S6KUEQybJu1THByglIpbcr2tnTMxebIu2C5gB77ssdodg?=
 =?us-ascii?Q?lvEe5VwBjq/ed2SFbUXVItiVfeHhWv0dKhiYZ65tJCSnI8OhKe1ZrGReJbSd?=
 =?us-ascii?Q?shovHVDWNctrmq3qVNZK2c7XPGaYzUR2sKoyCA3mcu16R4N1a+rU5MA4iU9x?=
 =?us-ascii?Q?UTCVzRZmgh1NYP57lDNQjjGXSSiBj0D9gEVP8vNdoBPGBqQVSL7Y7z+Bc7Kp?=
 =?us-ascii?Q?J8n8X7fJYL7FQ+PcRAiseCxYEqUp2eQhJD6Ax3kiRuXfDqFm+0e6OgdwQxMk?=
 =?us-ascii?Q?46aWIZdJwbgD+fYeAGls3O6O/g1jL45pzx6bbX+SSaZucQE8RtFUG3+Brgnk?=
 =?us-ascii?Q?bwkt748aQan+d3nYUn4EIQhrQazCMdLJcID132zLBnxd+3QlMRgKrBGXEuSk?=
 =?us-ascii?Q?lVqloB36p6LwkuWG8AJjLXQxKUxlE5csSszwgfcIQomd42yd47ZT56Eaw3gj?=
 =?us-ascii?Q?srd6WYG7fN/5addsh4PROt0vam942vMCRGNpZWoHIQ1DviuIKv+HzgpMYeds?=
 =?us-ascii?Q?yzJ+jBS2RecYzaatwS4bDAHKqyq9I2Of12lCdbyL/LHSYaVVG06e+sO+isOe?=
 =?us-ascii?Q?3zTi2OpsNm3Xpqq5yPOaYQZS/H1WcOdwlRGhtBj0/eTDuNNA3YHzi9stqqrB?=
 =?us-ascii?Q?g7+U4S4LMs0yrM+XGv6LJkUhY3c7muzmW1atKdnxIg1eFK91EIrEdbqz3COL?=
 =?us-ascii?Q?iLGc7TpYjOa2aeHUkzxSfJh5XhNyGqq/LSyI3U4gTClACXtfERrLysPVbgKX?=
 =?us-ascii?Q?RWFaZsb3nd9P32tRLC0A2v2fH6LpBSReY08bopY8IxXjUhjqVBEbMFG13+Xi?=
 =?us-ascii?Q?7wwKNiXjmg696L3B9Udae36g91fzFap8FRQa1yw3JRxxVdSxxFW7AYaD8cBN?=
 =?us-ascii?Q?SYJmBrGR0wNQ4HMiASbxjVGgmsGcMb74P1H07bz3yx8IoDn4WWII3ijNrY1a?=
 =?us-ascii?Q?ARXiHSiacgVcd+n1NkTCk2LSkb8lRyC4mZ1InwPtnJL9kkWQ88kJrv0PzSJ0?=
 =?us-ascii?Q?+8T022uvzAmFZJKFLuGq1yRWl1IdQME=3D?=
X-Exchange-RoutingPolicyChecked: Sa2F4ZM/KcuwZiwYhhkzobrJIEqDT5330uqbj1Cc9JbGj46rTUj5BRYFS1AnCexjJnLiMtx2MpGP/NHV7j0KwKb3/YX7TFFDwpdUUjdCIJ9wNTe0hzyqB0E71ksU+ciXtOvsifW+SdBaDR2J6saqfRXvn3j4Wx+3lmfTubDa2XSIeIa1lOZihhIxTcwhlLzl97NdNFRxRGn3UGo1KmFXig0jS8nuyWPA2+iohcEGq+tDbcDACTZKL0TLNGDYqlHfGzQbwVUKMVlZ2UXrKN0V54V/Ggf3Mh7SBvnOM/rGxqzvmz16NcSJtlpx0TuC2hKRuHBETXW+W5szotUXUQeWBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1b5dd3-308e-4dfa-97cd-08deaabd099f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:43:22.2810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKKl6kqZgzCHgYL5T/jkH7/rzXj6jlG5SEZEmoyJiL1ftoOGIdygSB3KOBEu2ECSsoJ0qwcnMCxE24lKb/kFNT7yNh5AahlJUqZ5RUwvBNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
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

On Mon, Apr 27, 2026 at 06:44:01PM +0300, Daniil Iskhakov wrote:
> rte_pmd_i40e_get_ddp_info() retrieves the I40E segment header with
> i40e_find_segment_in_package(). That helper may return NULL if the
> segment cannot be found.
> 
> The returned pointer is validated only in one code path, while other
> branches use it without checking. This can lead to a NULL pointer
> dereference when parsing a malformed or incomplete DDP package.
> 
> Move the NULL check right before the segment usage so it applies to all
> request types needed.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: edeab742edac ("net/i40e: get information about DDP profile")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Daniil Agalakov <ade@amicon.ru>
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce
