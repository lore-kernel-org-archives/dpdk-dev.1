Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67158D0E6F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 15:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99DD640B92;
	Tue, 25 Nov 2025 16:05:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0499B402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 16:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764083146; x=1795619146;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xC7iQqV7z26a9m7aCKGg9isSwWDfivqD4LE5Hm1Hvzc=;
 b=QhrDa/5RIqoYxCRE3qxLXEki3L1i8BIlnNiJrUkdwQ6uwTX7zLkjNB7I
 LFu2DVnN+N7ASvLLUwDb1mMsB9Sw9xX5JuDiBgbGw0FP5Tq3VJnwmTkl1
 xgFdPkuoLcUbVkdElif9r9xupnrdFzR26yC1KbcrL7upF/ors/Dujq4+W
 dRFir12zacdJIJfitbep/2cAavbYXgnyTCRnsnvzi6XwmvtE9yAO4eFKT
 di6TgOGW3GkEtFI33i4yzmSw19FLSak+Kq2PJaDFXOGBW34kklEBxOqJW
 Eos7XEw8hHoCWZgGo8jzWP+Y2p2IJP6MHRF3h7fq+DhjsaIUZOXmE++pa Q==;
X-CSE-ConnectionGUID: 9kyYGU/qR0uO3GOutAWojg==
X-CSE-MsgGUID: FkgmaOuzS/qLw7kwgTEn3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66049476"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="66049476"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 07:05:45 -0800
X-CSE-ConnectionGUID: TdXX893dTmCP/HhnH6fkUw==
X-CSE-MsgGUID: OlxvIM26RcOYb2dV/lMadw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="216009234"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 07:05:45 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 07:05:44 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 07:05:44 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 07:05:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1N2uVjiu6R0+J2EL9vNLwBAHbJMnsQ/Egd2LykK3UzaiodSwDe7teHHkRyzCkmcPZWkA2ChF1BjwS5ivXryXI4wZKqjaLdVOO9kFdKR6mI7+nUkvUbsvs70BnFbOMXBmWZhCCUnNd/6pc/8lE8fOcOBHbKjLvxQXz/H/nWl5Y78S+S9uv8a/4oJxu1PCWq70uu3b6zV9orpNKqfY7hk+oTOxNIJK469lFBNgnVXpHK3FEUMN3DfX0WIWbcigN/MXcgoH7vkMi2Nnh3l9qtwZom9hNFHxaVckfpy5akMvV3Vjm1pV8mWxU19WJlONvMfqNBjejxIfJBK72Uv9YLlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cHyt6tpIyPR1Q9+OnXzDZ9/fb5UxS9BGXARy3ioh9I=;
 b=A4UPkJvTwCfRpiDboFp1GSJM6q68CB603h0/vIDkW/BlPsajogv0aOjBaoY28hTodwmONp6bdg8O4BJCjzPxcKPdV0UaRUT5RA4m+5uirfXVV6I26josRCDmKKFmCGC1lJmhZ3S6lI0VZHuAcchk7ky+oTA7+hEoey6oz/Djf+Gp0MwSHAxv/XpuYsIn5tJ1jc9zeC8/eJfFnufBs10nBq+Ec5sBTYZPuxFXdSfXqYbSvlDbxYsWgnR6bytI5Km4CZ3Ku96sdegK3akTZjJN/pAyIoI7I/wFuyTET1p+VorPNMGF9S1oSeJYMv4Djs3InQwxkhy4mvQKWasj0gfjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:05:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 15:05:40 +0000
Date: Tue, 25 Nov 2025 15:05:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Wan Bingbing <wantmac.bingbing91@gmail.com>
CC: <dev@dpdk.org>, "chenxiemin@gmail.com" <chenxiemin@gmail.com>
Subject: Re: Question: PMD behaviour without hugepages in DPDK 23.07 (XDP PMD
 in Kubernetes)
Message-ID: <aSXFvWwhzqAJoJkA@bricha3-mobl1.ger.corp.intel.com>
References: <CAN-dPwmgoCzwcp46xyz3EPEP7BUL58aO3em2Tot2zqieg5wYQw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAN-dPwmgoCzwcp46xyz3EPEP7BUL58aO3em2Tot2zqieg5wYQw@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 4463d0c8-66ec-4b4b-bb56-08de2c34185b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CFUwjwsczFK+oSFA0fCh3jwhNJ2JNNBrGIVfJMTd3u4pIyxr8AAJL7uiEbNk?=
 =?us-ascii?Q?+nRKMED/jpmOneyrI3Zx0TN1VLBbc7nR9H79iE5dvb4z1y/LAGguBOiLSYKq?=
 =?us-ascii?Q?f03TGv8syEbRSmZFXwQcE+4bqC33tCQmcHshvx+6wRNMSiogbZJT6PSsNlSC?=
 =?us-ascii?Q?6cpxUcBGoi2WruY8PPfsAkGfx7ieSDawBrVJtkBl4c+8kyNRvsTXUrR1Wi47?=
 =?us-ascii?Q?nYX6bYLNQOIJSfMZ4pee8/3hymklGNFeLjpvCqWAxSmAR37LbKtR9vuW7G7n?=
 =?us-ascii?Q?6AV9hEAobd2bSZmVZhY7cc2KqCD5JOwbAzGg1Ho0eXpsMquJ0v8aZ3jUevPz?=
 =?us-ascii?Q?feG7QzafyekI6jXr0MHqNkhumTW5G2fAM65txs5LSE7MH7aDp1pWZ5kiC0hv?=
 =?us-ascii?Q?FMG0++le+zViTFwMlSC0Vh1ol8oAjWx5aJ/nWiETH3iQBNnqNns38SYYE6ub?=
 =?us-ascii?Q?+PKpxKgp1sUAvFCKm2N7gBNVW4vFdOA5QJxWg2KCmuCN9x8U81ujTig12Efh?=
 =?us-ascii?Q?3uCt3Je4F6sp5hLvs/UIhsqI1Ej/KzjLE+KphpZs9iw6wTm4yRwHlXiu0+oP?=
 =?us-ascii?Q?qUB5z5wYGXoxKJJoPIX6Yd3GD/JhCCIFViEY3zGesejYz/JwTrD0MVkpcWj4?=
 =?us-ascii?Q?D3F72ksk/7+qHgVzryWcrNblzgn9o581NGYto0R8GQmHVVahxGHpeqQC8AdG?=
 =?us-ascii?Q?PndV1bx6bKcvnWfuofd/72u0UAEknaudu60V/NlFihlLlEcN4jLlRG6YDTu/?=
 =?us-ascii?Q?i3j/0Z0ZOinmuXGR7msQYAyt1ezx6UiKicDBi/hYYWn6/Ku9t8VyYLtHTwq0?=
 =?us-ascii?Q?Vuy1R+Sz+Kl9N4EVngY4keXzj1WXehVA9EP9fyzc/Z+KGgcZ6rr8W6l7JzNi?=
 =?us-ascii?Q?dqskjB3yZJ68B8mYf9Jr+nKKAsXQGz5VAXvQpn2C9FjrQTgueuvL4i6KEE+I?=
 =?us-ascii?Q?9OSTtfrDmY4A9yWOgZSE0ph7ewJh9WwkCuIRIryEPcvvzmMEbtTo0j3FlAIO?=
 =?us-ascii?Q?nWWaaG+VQuibgP+nMzcEn4AB+srljmWLnTLCzYFs/RmPJ8yhOOIwTwyUeX82?=
 =?us-ascii?Q?9mRGXtPmVSI9DAqqvLJPVBKdRpKxTD6A0D2hYhOtdAtth0zt3szuz5W5ctfu?=
 =?us-ascii?Q?St4Z5MqUyWvEjtJdAUJ1qUbESAUQXbW9iGdAWbxqxsLb25IHqPXkdtJWcCBC?=
 =?us-ascii?Q?FHhXXtQI+fPFA7XBXUB5XFtli/QikdlJqOqHlqbpaEFpwyrDZspdEBxL9QfF?=
 =?us-ascii?Q?yb3t2JadlRoWs6VY8Eu8BKHtbftKxNMTuKVxchN+LMvImPyXXVC9ZGJYy1x1?=
 =?us-ascii?Q?HTqkcrWjtvF9+ptYRuzMtgD324D/98sNXpMKuCTzAp4l0CXQlKizAfwbTSG9?=
 =?us-ascii?Q?L3wHcAD6Vo74UEeA+sNVDobZJLPBbbx+OfFuhkE6V1qZEhj1WC68WLjHVwrM?=
 =?us-ascii?Q?96OPUf4f59VXgQXvZv+UmMlshwNvsvmp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5d3oDf3Cu8GReIB1G5r2MQHiWhK4WODHppqO2eegRuK1snlkEdHlJpV3tJg/?=
 =?us-ascii?Q?xVypLNIy/KY7sFcJ/tDV0Mv6ZZLT9G92+mWvOphTmrUKNQo3hHPruy7SWS9m?=
 =?us-ascii?Q?S/Ru5yptaamIt+TvS6yzuLxXacTChu7J1T/YyEvojNfSuaI11cBrmLh46osB?=
 =?us-ascii?Q?KfhZyifqXdMxZp9XbIiaUV1Wterw4T90dVb1hn0iOIV86rZNc/OV++ZQgEEW?=
 =?us-ascii?Q?Y9XFCNz3+9K/lttidm5SpSgXg3Y7DHMe5/Z8GjmlUQnLnl3aZXM1TGJ/E1tk?=
 =?us-ascii?Q?AQnqqXFUN3wi/bAvYR5hhhD/+SXvgmTrD9j+6OkIeazrS452a343WLF8ip3B?=
 =?us-ascii?Q?/R4wFvVPye3tgQYYEB3TjujzAIvXH9NJ6ZSmtp5FsghNMl1s86fokSiELH6a?=
 =?us-ascii?Q?DuEg4d6iD1DNw9/ZHOP34IcXLDbtcustHDVgWaH5uNM1WHoYh6RGP0CTxRQl?=
 =?us-ascii?Q?kLWcxkUWgslb3NPWfUbMXCFjyryuP9o24pugp4aj6eFKHEma+KCiDebfJNis?=
 =?us-ascii?Q?Ri7AqTNk4WEU61qd1jzYLjdHqCQrIHi3/6m1F8LL9Zc5WDeXVyMcq4bZSoCQ?=
 =?us-ascii?Q?/8BH6hBnMlOCu5ohtgtkB0NTV1k2HX+GYs+sJAfKrAqO5LNjxGoTGpHgeBAw?=
 =?us-ascii?Q?RQsWGkSPBIUdqpU9Ml+oQBRwb9P/zj7stZ+tF5dyRXz7BSxPojaj06khFrPb?=
 =?us-ascii?Q?nh3w421sgq20xAkz91gXsrZD4dmVq6BYGUq5uCtHL4OeLo59uD/3KURGrdFx?=
 =?us-ascii?Q?GwnwsvK4YbNAI8LWq6DoKScIPxQsHm0OxfNm3akqSP5mjQ4KtHwQkuigt40G?=
 =?us-ascii?Q?4lldmONR8+7wF6m38co/r1Nqrnhw5EDCPmvYJijbOyCtdT9vYhN3/r49ie1x?=
 =?us-ascii?Q?BkZkGvVyo46dV65pP4ac7vhU4UnQhDbSah75vrWy15yK/VpPUQujXpwHNx2q?=
 =?us-ascii?Q?CBielpq7VA7Ttpn5sBpnsVhcLsPjS+zkna090rhMBT+Y+xFDwG0Ua/IVbE6i?=
 =?us-ascii?Q?MaM40QhgKg5+hhgldyCgex4Ct15Kbs7rBkrDqCtxYABI/kXB3mOPKq8+QLaW?=
 =?us-ascii?Q?316eNCKGZDG09R5yhQfafmX7D0tEbQQcu1eBjlKB0tu/NYTnbS+xKc/LmT/F?=
 =?us-ascii?Q?4l3e/sY0VEBeYagNG9gTBQYuy6CczrVigc31w9yhSMOCEQYLQKgQwQzLdPPO?=
 =?us-ascii?Q?/m4G4lRBK7ilXY4d/sHgw4zP615o0Ljva74HoW4+qokAGAm4GrclvFbrqzE8?=
 =?us-ascii?Q?2n7F6iCyFajVbpAFm1qzv8c3pwlprqpXPRKSpEqI4qtqbDVBDPO1nYUKCNVn?=
 =?us-ascii?Q?aNtVjmR9OZ65LZp94uoQgQ8wV5KIbG9EAE8v2aorVIPUjak9bJ/gURzF0kRF?=
 =?us-ascii?Q?UkR0uq6Y5xGM/soefEYxMVzJgmSUZqd2tvRxDCI7LGOUr26W2v8Uf6ANW+uN?=
 =?us-ascii?Q?wp2MXVWJua9e/xS5JinvBt7Uz7vC2I2vq2z1SN4cYm7WN2jWRXyQlZHy5xql?=
 =?us-ascii?Q?1hiuPfYX2rEH6Qu/ybXOWNDTyCXnR2oPxIBQfJ6Hn+wR3p1cdSFIli3k3gHD?=
 =?us-ascii?Q?Xv//ghlBVYYSwJf5ApmK1di8YbyIZDMl7gkuGB6aWLRhu33iBcyLp0yrgMyH?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4463d0c8-66ec-4b4b-bb56-08de2c34185b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:05:39.8258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alMaKuyAq+Kr6vM2BK3exFqcfABZ83xLsynFGJBDB8DLVFS+aiy7PkKdkTUUjXEA3jA6jawHinVKixBX1NlkXn1EByx4H/bE9zRgdYshQQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
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

On Fri, Nov 21, 2025 at 10:15:39PM +0800, Wan Bingbing wrote:
>    Dear DPDK team,
>    We are currently deploying an application utilizing Seastar and DPDK
>    (version 23.07) with the XDP PMD inside a Kubernetes environment. Due
>    to infrastructure restrictions, we cannot allocate hugepages on the
>    Kubernetes nodes.
>    In this environment, DPDK fails to initialize the XDP PMD because
>    hugepage-backed memory cannot be created. Although the EAL is not
>    started with the --no-huge parameter, no hugepages are available to
>    DPDK, preventing the PMD from sending or receiving packets.
>    We are aware of the known issue documented in the DPDK release notes
>    ("PMD does not work with --no-huge EAL command line parameter"), which
>    explains that PMDs rely on hugepage-backed memory because DPDK does not
>    store the necessary physical/IOVA information for memory allocated via
>    malloc/mmap.
>    Given this dependency, we have the following questions:
>    1. Is there a currently supported method to run a hardware PMD
>    (specifically the XDP PMD) without hugepages, or is hugepage-backed
>    memory strictly required for all hardware PMDs?
>    2. Are there any ongoing efforts or future plans to support PMD
>    operation in a non-hugepage mode?
>    3. If this limitation is architectural and not planned to be addressed,
>    could you please confirm this? This confirmation would allow us to
>    evaluate alternative approaches, such as using AF_XDP without DPDK or
>    relying on the Seastar native stack.
>    Any guidance or recommendations from the maintainers on how to proceed
>    would be greatly appreciated.
>    Thank you for your time.
>    Best regards,
>    Wan Bingbing

For non-HW PMDs like the AF_XDP driver*, AFAIK it should be feasible to
have it work in no-huge mode. However, as far as I am aware, there is
nobody currently looking into this.

Regards,
/Bruce

* yes, it does use HW, but really the kernel driver does most of the work,
  so in practice its more like a SW or virtual driver.
