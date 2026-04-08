Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434710F995C
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A43DB4014F;
	Wed,  8 Apr 2026 18:45:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9F3644013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775666751; x=1807202751;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=2PhtKi5FdgZa6eVXszmpPW4NIi+XVo55gwEjWby6LNc=;
 b=QR4S0FT+1WRnML4S1wuAXb9tsfKAYASotq9Wk2p3obBwrFHfOjEcGyy6
 0ZBSEQj2obGG22HCI72/M3xzxNTHE5NQKGBYuzrst2LkAs51TU5AMeQKB
 iDHJaFaUny8eqodXnCahEfVuc+rXJeTAF/zEZhVsa3U42oGm5vMSpFvZj
 OKk81VZc2700PHZcfY3CnoC01jibfNXIBHhR4GCbgRdaTmZhqEsqM2F1W
 HOU/VlbgMzls6/z9D6FgeB3thR4hOxSs2hWdomHh7B8MGWP5UkDL3wXca
 cM0YANv8llVmNxuguMUVaNzVFiRLIX6Q1mIteO9sEVbfMJugskzjp9xWx Q==;
X-CSE-ConnectionGUID: xEnVHU2lS+aCAQPIwxOfBw==
X-CSE-MsgGUID: 2vrYWuMsS/e+/9fNZ0DkYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75694564"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="75694564"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:45:50 -0700
X-CSE-ConnectionGUID: RnPrQgnQR6m9mdG0tsYQxQ==
X-CSE-MsgGUID: 7cegWv0XSgikwou7tjsxpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="222000772"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 09:45:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:45:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:45:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:45:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr4dMt/4tKxSY72kkmFtSAXhEdtxIy2IniTzRgWSQh2G/3R8BUkmPWvg6TJVUQMJTUr/gs7pWs/7wkL/7bt39J622baWWESu9vZ+IvKKkZTLDP/xt36CnQXZI2A1ZvlHkI0/b7IBy7hqcHFdkZ3/9vb8d3aNJyxovWEnQ8VLd8+6Qx2Tv/kaGU6EHiTL8/E8DBejJImwU2EXT4u99X2CoV/+0sH8WWAgRMSUwzKHHJmVMd/PXlEZfaxSQYwrc44jLXphUBSBPsc6Ql5uVVg20gGDaTAIBqTsbpOe08vtXEC+X1rzeIb0+RIejquk7C+KEMeeNvUyMppPkpU7jK5Ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRfIGV9aVwGip7/wtf9Mh+DlIBy573ULRR2/Vd1OYzo=;
 b=UA/JvkrfRhSsQ9nsvadzwY4W9tfo1wmltYCeYuySHTLtVHuwoOogibTkVigNdl399PG8mpcWGdEz5/O4c9BKD9JJyHyXidJEBiQ9ZPpn8ec/iVFojROxsc71U0y9VDo8eTTmr3Dd+DTT2NljOxzxZxyP0l2z3w0SAgFGqK+SNJUh/KF3d5HoB2dVXARBQKGM259L5rQ0BCsXzNV59sk/N6DPLyctIkAiqHUI3pR6rSRel0IHReY5KPWjb+Q6WpQZVd1RpRqK4JwiRMtf5Gbw/KwrCnRmWMNU3VMMAMss+EVE03Epu0OfSYYRBaKVACaJCPqxtnKDCoEnqrZJnTuw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5101.namprd11.prod.outlook.com (2603:10b6:a03:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 16:45:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 16:45:43 +0000
Date: Wed, 8 Apr 2026 17:45:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jay Wang <jay.wang2@arm.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, <nd@arm.com>
Subject: Re: [PATCH v3] net/ice: add NEON-optimised Rx/Tx vector paths
Message-ID: <adaGMqDicBUFJqu2@bricha3-mobl1.ger.corp.intel.com>
References: <20260324162525.4083381-3-jay.wang2@arm.com>
 <20260407151225.1416270-1-jay.wang2@arm.com>
 <20260407151225.1416270-4-jay.wang2@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260407151225.1416270-4-jay.wang2@arm.com>
X-ClientProxiedBy: DU7P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e36509-2776-41d5-5d89-08de958e4693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: d8qZsdN/Ul/PoYIfgiuXRL0vZGrwkGPT6fw9xvOT2wG8/ETs84loftzdvXnyC+DFzoTPrhucPXNqtvbKoWKaT9UBla5UubQx85o0c7vAliOfVlKbcM0hgetu+d6dEm/F+qaWGfDlNHQigo2JsKI6gZ3C6qUH0KQdgjUHruXt20onHUw8zf1DXpnb0D5MlvBbaDRCBC/fNTWxatQnz2xDgJhiPFZVlprnWHzWd2OFgN9brvnCpE83ARukvhy56JaYGdCZY/I5J7UDxUrJqASXjLyHHblelHm16OUXhcuh2t8EhgmL6ZXdPzeI5bnaAu4edVReMf+37bV0FZFh/GB3yJXRRESyMrBAo+vg4YwX8XQmriNZ6Yh0UogxBOQ23ez32nQRQGSeceYjZXIvep2GXeANCTaFmvcpvh4yf4GLBiWkJuOjGlHbgfgeFyTJTsev/TPHngtnspYXqG+TzQvDt7qlreDB2U69d/kLK7sEzFoHCTOEYJbV7OU00JdBZVzmn0OtTmfFR0lHJxsjsyUHU+rh48s/ASTm4QKbpyqCXvZ0wYhfgdweDNqDBWYbIe57wfpSsBsaLcj2lc0K91Q9fU5eBqn/13XJZq1kSzhJJtg95R+gTvUpaglCG7o4iHQS7gCkI8mH9Wf7Oe3UmfmwV1rSZFNeRBiZso/A2oZPnNIomYtPq+s//IC5ypLp8vhiFpAFXc10RtDT6Sekc+DMEJbxaUTcJ0uCLW/jiCXpUJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QKibzvu2t+dHjV+7uWHJ73kKq7H19ImrG6ryGi5HpaTXjjVeor44oI+uyZ0X?=
 =?us-ascii?Q?dQ+oZfuui9foKfQR4IPQz+ux6fTQLhR1OrmoBFAabniGKLDYrz35IoHv9WYG?=
 =?us-ascii?Q?XWlcVzvb69FocUjcdQSKj69SuFvpUqHjZWCd48sZqv9pT2xhZfMOdThb9gDX?=
 =?us-ascii?Q?f1A6KrgQdr40n0bxPpnEq09C5sTUZH9eOFQAV9X4IdLQfOfcZHtldCEDuHS3?=
 =?us-ascii?Q?K/o7R0FprLEtOk6+vMRM2dAN3dckQ//zeGWHvOVpv4RuwSmZHx+Xrumyvaou?=
 =?us-ascii?Q?uepfMHsOvynTJHWS4iadVXrv9VAC0dE0lc0ApfogYztN37iq8afoHNjWUIir?=
 =?us-ascii?Q?p5WTFv7F5Gqft51fEmwyuQb0eMx/9hQ8BEbExQVFUHSxZTPdMzFLGOKm6BrL?=
 =?us-ascii?Q?E5AWJeLJvFhIKLCSF2FZ/uv5xk8mZ8HjwlDIMjRN5uUnigN5g9jX8VIQvfH4?=
 =?us-ascii?Q?AYLxgY0FYexPFjoU5FqPWi6SioYPJKzN1VgL/VT1nOZJakFuf2FBUuVBG92o?=
 =?us-ascii?Q?/rBfxZ6HhEyPQv/DH04o5jFbCvRclIGpx7+pZgSdHRgZzcERuRbLfnyV6fDK?=
 =?us-ascii?Q?xRWaOiLglR2AW9XxC9qGwbZCn30udJMOfsJrTGhr3o8z6LvusKt+cIun4N9g?=
 =?us-ascii?Q?xOMFSNg8SLlj1VVODhqhpTYlqJYDpXIOh+VIIm3s++GEP0eAiBVtPG+CQ1UO?=
 =?us-ascii?Q?zr/WPsIBSBAzQNtIEW7lccZMIsRmq86DNOvIgoUMKTxT7wIgqLNS58YZg1ky?=
 =?us-ascii?Q?UhLyDBVQFF1ZM6zylXxdqOUzmuJJyia2JgFk8Li8uc4d5TyFkV23T8UdFBiN?=
 =?us-ascii?Q?6me5pujEJV5x6p6rOynGHRJPoYzC2K/Ly5BY82izkqaesz8r2FtDkf1WliFs?=
 =?us-ascii?Q?HjaDwUXZw2rEVh8nRCC4Z6NVbcDMUQtczSDi8GnA8noqD3fMITtHI/pFx8GP?=
 =?us-ascii?Q?e2EGJUbZx1lwBBdD1H1m01/3uUH1IcOAy8B74V8+0/K+uZ1/sBkoY5yhDdhm?=
 =?us-ascii?Q?m7to4NmU+V8r6GwzaN5PfPVdWCsUSZJBQI/D0OMpPrE1g5MKqEu7inX/F0Uy?=
 =?us-ascii?Q?UhMo+LVsWPGBs5ys5jS2bJOTveVjdOXB7iWpG1wCKwzyx7h3sT1RMHhtVSxk?=
 =?us-ascii?Q?8/D/j9y1JaCqRoTqaBBQhd5hM0sWvMpueBCCnqJll1vkMvPB19S5cMts5vJa?=
 =?us-ascii?Q?MDtz6nvHwsRytMuSki1UlBvuccRQ9XzgRfNfYgkVQfoC0EskYuUzJwf+mn+R?=
 =?us-ascii?Q?YuxNUk4ZxRAcRrDenvA5RiyQbIvIoOi5JKQkg7Q97CbFag2EJkpFT1gMm/V2?=
 =?us-ascii?Q?7JC6DNLBIvabI+gyZdd7m7EQID65vcYzd81NmDDBiy/deDBCDwmK9DiDLt9G?=
 =?us-ascii?Q?lQV+PpvWzCv4HROBl/jwNlSZMel0gSaj3iMwhjEHLp/3SkWmYcmQiBNutfWW?=
 =?us-ascii?Q?6XuT6HRollzufZW0PwRHNFzRNHEuG2fTWrTuatj3vIrY0u5SFPPnTqjk6jFE?=
 =?us-ascii?Q?GwFWfW7X3mA8WcYBju/LSuU5dF+4IqAb2JhBJzvjeOYii15eMo87W5cavlj8?=
 =?us-ascii?Q?yHCpjmOr3RZzSCjoRh5JCfCWoU4COUbaojHvf1dsRgCiZ5skF8ljQR5VFqcW?=
 =?us-ascii?Q?WdgsmxhRlOSQtOvUp660Qo/Vv7MbWaYNvJNJ/+PQA5bla30HnlUxATmmBDa/?=
 =?us-ascii?Q?zfLpiyprW0fAgrDodCJMmhqYgj+D8eiQbJ3UJGVKfQ8U3hKXHTKRSbwRKEZr?=
 =?us-ascii?Q?HPX4+Hl2Y6uU8iHvMGK07g5w6a5ijIs=3D?=
X-Exchange-RoutingPolicyChecked: f/HbXxsJDSY1NGz7pCtF2lAtGdB/fT1CdZSVkuVJJVJXRT+e3pA8mTb+rnWF+7dXv5GFGxY0TqT0uqNZm63D70J2D+5OcZJwfy0rt3W1HBghjog+XInzBLZNZb8jyBK6MkM0tYY7uLZXVGxYeN+B3adU7/CWcJA426cqAkHE0qrRHAFUfOVDPHVTxZ3BVuMD1DES9aCcJl48x3SbizIESiuJyYM4c0rguGky6vaiB9tK+/cwV1F7j6mD+Qye9ei4+as4iLw/uUTRQlnkh0ECuNT6WxPN/8SvZQn76ZRNOzKGAV6DY3NEmBHbcNBX7XcqZd4UOT0IMW/FwdXAG9y/sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e36509-2776-41d5-5d89-08de958e4693
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:45:43.6458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRVM4tqDaqz3SMOYnflaQt0yMqKb6+LNoLd/MoPmXASejYOaWqw/VGUv9DTGMuTLH7qO7rBZf5MgIswfQcEn8ddzGxX7Hjy9aaYI9JZV1xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5101
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

On Tue, Apr 07, 2026 at 03:12:24PM +0000, Jay Wang wrote:
> This patch adds the NEON-optimised Rx and Tx paths to the ice driver.
> 
> Tested on Ampere One platform with Intel E810-C NIC and 100G connection.
> Tested with a single core and testpmd io forwarding mode. Observed
> ~30% performance boost in the above test compared to the default scalar
> path.
> 
> Signed-off-by: Jay Wang <jay.wang2@arm.com>
> ---

Recheck-request: iol-intel-Functional, rebase=next-net-intel

