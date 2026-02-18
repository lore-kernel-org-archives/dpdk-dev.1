Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E1EE9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CFC140395;
	Wed, 18 Feb 2026 11:08:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 31B33402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:08:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409314; x=1802945314;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=u6j8zjPSi2GIayPzNPrRnUldzRb53A3dYL6iBwreQGw=;
 b=RLH0TAEGeB7NZdKpfQjQPTursnJ99CGbJ1Wl8xu+tPkQ+GfpYfol5Xxo
 Odgg1jDpNYkCAW9OjTU0oMUj5FJvYrHWx5KtnPTbajxWW04oDVdIAHbU4
 hPiu7OdkqHicQOygfopQxUMTKDOE8B/dyih/rsPnOR5xTfkCJuJiIyX/2
 X3sgTMBIv2Z3kdZ2yzxJGarhFMu2GDuq9GoaBTbvCwekbc0B6xxuw5x+9
 4EVhFNaJtLMDPQhjyQ6wYlFWq+utaxKzOQQgQhYwo9rfIb1lBxmk65/Pc
 Xs43dch0xgsA5yG28xoJlRWBFD57iYwZ6ZzWNrhhxJIMJ2HVmGaXnPbIU A==;
X-CSE-ConnectionGUID: Rd06pR+rSWqPVChZiTgcOQ==
X-CSE-MsgGUID: iBAlqduDTV28bmOSX5+gPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="60052237"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="60052237"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:08:34 -0800
X-CSE-ConnectionGUID: S0AAmEXDRnKRTbwkpSoHpg==
X-CSE-MsgGUID: UXbapTpwT9OrnLREQR5Ilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="214006077"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:08:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:08:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:08:32 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:08:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNBd80f5sJiYUXCF81ea0hFatM0vcIj3BcmPCWGcgFDwCyr4bysMyiNiT9Vr0t7GkPmEuuM0QGK+ESaeT0URx7nkKnnIXKzAq6gyLGFQ4MUYKe+L0w/+RKiYpy4QAQ3eN2L5TlJlp5UI+u8Yd4EWrm+hTBhUCTD7ve0tAKsYduDPJHUFhR1bmZgpx5K1+G4Q+cfxrobgqsrLZYbc83cFwNyvPbQaOHYMSqt4fh2wXE8SyWPaUP7kmqzkMDgRjLNFezfsBXmQLToCrYnTFBMNzfBIEHOJSgyoxb/aKq9gVySE48l5yIkWsSeUokEfupEoTYOTw9Lub54TG2iAGKknbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q158R1sQZ1B7kbE72fSDoEUZfQLrku19R1jIqNcUPVI=;
 b=py/AsujhTwZcu6+j7YAnwjVSSnURAnxuMz71yLqwSW95XMOIU3AlDfqkn7WgWTKWD5qYOBSMkjJgmIEmGmchUZtFRmLNhUkHMSkV43u1DOm+2fTU89CNWEneO2XVXWneNI+ZiesKsvQyBOBPy7Hcdw3jQBj41tUf5T8tCMiIygG90Sw+UvBQXpRVAh6Xni4bI1oD5odSGROwjLO/W70Ll3wHinuvMFz9Wm72NazBKRaFc3Gm81ZCMjr3ftWD6z7hVbckhT1AECdXoYEH/EPctm4+Iw1B3O9VNtpvjUVz5/MKDOveVtzV+u3IBB3RspDUuAawR1QvGv4PVm9HJnHgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 10:08:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:08:25 +0000
Date: Wed, 18 Feb 2026 10:08:20 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 08/10] net/ice: permit secondary process Tx path
 selection
Message-ID: <aZWPlJWBZ8JwSmx5@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-9-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-9-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0309.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: f70a3752-80dd-47da-2055-08de6ed5a788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GL+7W7KIloL2tv+XoWMV53laj27cOoNUdrKqwgB51iO56oKAC9RJqkOiGwtm?=
 =?us-ascii?Q?olx8NA0IGlweyeTGkIWO83H9vXcGrgTj28vsHQl07RvrGX1sZNIZPvPBnj6g?=
 =?us-ascii?Q?FIifG/czvqzz4IApy5FDZu/ZmMEV/GM+UCFWRgL7POWHt+fm2qaSBXBen8tQ?=
 =?us-ascii?Q?6Z31vUCyYqqCI1GeU5IydyBNz/vhrWxiiXzgwvFEDyfW1dj9FJPwrYvRudcK?=
 =?us-ascii?Q?dJS4mWF93bM1VhAvkuH/3+8oeVjmXCIS81lSuGjU8UceN1GXVqZq1YBdgFxD?=
 =?us-ascii?Q?y1aHjywf3Oa0pDU+7CaC4RIxSbW/E8JUnNuXhLG3CxVHqnU9nRW6Zfjttkch?=
 =?us-ascii?Q?X/N75K4NBaotQu570Jon1lFDtPIoibOBEH+8ubYPs8Jf6rAqt/HGABeqqmHo?=
 =?us-ascii?Q?zuLYSqx+1HK1v11onpsgzD/YdVepbyO6cyIsFRvov3HqpHXIkowHTVll0uIv?=
 =?us-ascii?Q?0/ujpf7ke2aI828FjiTCVaWSte11InW6ckphDwMUMJSzC8xWqjG8RbbC28AX?=
 =?us-ascii?Q?skEXbcrg3LxnnGn/RTX0/Jm5iq7edTi24rnfd8ljTi4GViyB+vWjTXIA63wk?=
 =?us-ascii?Q?iFf+Q3xe/wjdKbpDqLafQEtfmf63uYTv2mjPKJhapWpBy8RGDFd41cw0jtDd?=
 =?us-ascii?Q?PLwj1fhfNWBNG8abhTltzjveidb0AyBKIgG4a3LxqiOs5eKArXBOorW8Q8mL?=
 =?us-ascii?Q?QMHPxYfJ5AwkSkkNlYQOGn3JKkQ8r4EragpaSzoR/nYg3WMs8TxxOtNAIyVi?=
 =?us-ascii?Q?pIseriuj15RWPoiezbJZkIVMNuBfSI9k2PmhVQgDnirJ66aUX0XHOls9fNOw?=
 =?us-ascii?Q?gg6IAUK+PhBsSXwjDQIWRmO2e1WG2+d5z3TwdMboF2vCooya6lm7La5aWZdz?=
 =?us-ascii?Q?QCPEeiajJ8zC5pPpMLJoetTWObrxmNxbVk0jyxJb02lzsfgIOUlfF4aRgVni?=
 =?us-ascii?Q?JB/Cj3lZAZk9d5QhTBhHoDPaDFIuTT+BGNh/9g1NbIzbP0gNCXOvZAJQ7hcb?=
 =?us-ascii?Q?mwVGuiHWrw9Wrmd/Cuqnjdf1MLUNvef+Ayn1DHpRc3qj1VqS2tl7FIb6WIIL?=
 =?us-ascii?Q?49RXmcAtB2dIR7LaRlKOCQq8XCW7YGNEu+0j07A8/qqpGbrN7yNRrtMCePmj?=
 =?us-ascii?Q?WHcRj/LzL8wCAXsavVa1NzdPVnZqv7ArvNH3gLMUoVhwRznW65B7QS/TG06n?=
 =?us-ascii?Q?91dqtcZpmNOBSO2wgSOV2P9veQLEbGDcIjY95uZFDhb+9HM6Q2XVNUpS2TJm?=
 =?us-ascii?Q?WJApFtM5j71ytkBzu9HKsRog5E8NGF4rHLoG+iHswjZRXDpWZJOneukSH//9?=
 =?us-ascii?Q?PEmedTENY+9xa93XAn+4g7lM7rFGQDiacbycUyqncpaI40gZ+VsXJ/sFrc4t?=
 =?us-ascii?Q?qdjInB1mMEeKIrQVHTFFfM06JcVPO1G3G0RNzn/WcovsSFInsooRehugB4QV?=
 =?us-ascii?Q?I6oZyObcCoAiILbKI07o/7W7e++iMwc8FJC3pPvTR9WrqA5AQeMEJ9q1nQQ9?=
 =?us-ascii?Q?u3WxIjj2xj2tk1qHLjpv4MKwhQQlCwkUJSYU3ncewA2v+V2jtQchE17Zg3Ex?=
 =?us-ascii?Q?3qBeZ6/7QStsxfdqv48=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTfgDbSaOZj0kiqX9FTq19z2nRh/XJdXrgDJtlGufbrGn7O+8nybvesevhYd?=
 =?us-ascii?Q?NXHJiQj1bQ0FSpP0sEn9aZ80jyflY8iIQPkkIasAlCev6YeRWD+fW67YReKZ?=
 =?us-ascii?Q?Y5H25cTyTQPIGE8fE64b7AAYjQQ8/qRoV/0gid7/6LaMd5xYOmaRznTc7YaK?=
 =?us-ascii?Q?3sYuA5UKzAcMJF7yugWeYIRX3jkQn5dKpMIvhIA6SKqam7+C38nEZ9PpiwbN?=
 =?us-ascii?Q?QFNk2M/EBPCoXVJrr4kdtracWbrd9H6r9dt53SPPV7mu4jsunQBL3+a+JAaq?=
 =?us-ascii?Q?wu1puc+o61otRnAFfMZ5pV8/3qoKWVvAcOizBGNMu/PMrazCxMNqWSi+B4f1?=
 =?us-ascii?Q?KvbuFoS5rTf8mEz8M0XvvGd/VI2bA/FKu4DvL0D3SXQKyxmhZk7Bm2p8gmR3?=
 =?us-ascii?Q?9ZPwY8316uI39Sl7ZaJNACAEP9wZClp1l0RxMDX0chtYtO0Mm/11f+/Yf0xt?=
 =?us-ascii?Q?4fr0j0jRGlurAUCdxy0GOy0nwkoxfhyM0/bD717nOMbFpvCoIp1L2F4cx5di?=
 =?us-ascii?Q?X2myMyNJx4ygSmtPc9eAPP+THOM+z6rJ6mYRqkcZQ2iSIRbKhJg9ZpYbxKYM?=
 =?us-ascii?Q?9OQnUy16A8qvv3yWy4FTGmPHIkXY0U49Kuv9Vi9HexJQ8gZv7zWs9Xqtkqw+?=
 =?us-ascii?Q?n2X9y2aT+EUxWMKdrg3gG21C/44XREllvsMrBPbXZoVo92GYYTgdvVZ1/rWU?=
 =?us-ascii?Q?zrYilwZx7CH8d1yqsawLeUUvOL/+UuzMBVBlPypOhGNBnSEopXxkl81gBY9W?=
 =?us-ascii?Q?/PK28zkJNZofQqH5itePMKjYTia/fI5SB+qbt9fPhG6C28Q4KVktZJvX5GKf?=
 =?us-ascii?Q?OUzJeuatM7tDEUD0EjzTU4XQ1kgsBYf5HSJBGedz2Yten+BQpfzGN305mPah?=
 =?us-ascii?Q?wf0/vK7UTp7bD4Zz5uE1G3zhoHg59hSex9uDPHKkgmsOsyy/jZsS4iugk1GJ?=
 =?us-ascii?Q?I0uXxt+POnRWsx1GD9ladQKnvjRBlNii61B83k3e+tW4YagCURAqRgw/PlY9?=
 =?us-ascii?Q?qj0r2lTGS7yO2J+OknOSy7fn8edgAmpVUJb8PGmqqOHgj1dqaPQElO6BGEfv?=
 =?us-ascii?Q?4Yj6MHueYilWEdJsUJGWuBoTSKTlqCuWlPTuQgY6c4KnUpWbx04ecw14Xz6d?=
 =?us-ascii?Q?EKz/7ZpSyghMRrRnXekqIvDEfI/r+UimfSGsbemq68zIykeURga/4zLmabU2?=
 =?us-ascii?Q?54Jt7q+p6PSkE7jMJ8hFvjIu0+nQKPXF/ZjiiR0NSkt1sZfhpJFhP1Z97ZS8?=
 =?us-ascii?Q?if1Uy9qM/1hhGBtNXSpp1lfgZ9gNnR0EYnsakMmSHF4ngCd7vubLW6tiyW95?=
 =?us-ascii?Q?25pbuj7Sm9MbDBUBAig8uPrOaPmWXakYDklSmQkcNwTa/EpcT2yhm02zMrGL?=
 =?us-ascii?Q?D5m7MjhHfnyx7bnUwQSQxIwEarKnBHuOUtOrLdkU9Fxrs/1hsvajY8evmctT?=
 =?us-ascii?Q?SYgkHXLIB2i5/pzL/vgCTx0SzGyK8aqUcL7IdnP6JLpF3/tHK9V8Rs48leip?=
 =?us-ascii?Q?vmlZQSmmCeYYRxXuwH8CgI8J3SajUUVcnhAberiuese/rVHKRQ1DXAJP9SL2?=
 =?us-ascii?Q?ayRgvWuHaGRSgLHVWf4EZFqi5t+oD5HMGppclCEYogMkBAunG2yKCwli/QtZ?=
 =?us-ascii?Q?QBwTIvrgPbnImXjrh2Mz5OKxmaYI6AzXgNyvDwn4+wob265u9aFq/EVHXeQd?=
 =?us-ascii?Q?zCfWzX/Pg4G945pkcuW6/f2P2t1XB8rZhXc2slBUjzCLiGSgj8nvF+m3jX4a?=
 =?us-ascii?Q?U8ejmdAfead0ZGTAmrg2n1kgE49Ampc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f70a3752-80dd-47da-2055-08de6ed5a788
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:08:25.2042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZD3k3HcN5XVqKXTJWaKBOkfk6ND03khdcTWgAC4IaR6BC1+pGmt466INNLvOjpnoi1yJGToR4ZuY670Aeh0IWgLu8PmPIBG9tKPpG64sLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
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

On Wed, Feb 18, 2026 at 09:49:35AM +0000, Ciara Loftus wrote:
> Commit cf96ec231d02 ("net/ice: use common Tx path selection
> infrastructure") changed the way that secondary processes selected their
> Tx burst function. Instead of letting secondary processes select their
> own function, they now used the function selected by the primary
> process. However, the primary process only selects the function at
> device start, so if the primary process hadn't started the device by the
> time the secondary process was selecting its Tx burst function, the
> secondary process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: cf96ec231d02 ("net/ice: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
