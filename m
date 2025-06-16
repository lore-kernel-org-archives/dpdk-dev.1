Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7EC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 07:36:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B5FD40292;
	Mon, 16 Jun 2025 09:36:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0267C4027A
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750059406; x=1781595406;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wgVlG+nVzgd7kZ855SOvrjX6wlX+lxff7VQcweKJRLU=;
 b=O9XmGK7Aqfrr58LrP3bmESos0GRKOXt/7N4dHCWtiZKn52QrQhlcWWjR
 QppJ01Wy3nirP9r4Afygo4pB0AL3OJORXTZ74seWF3mG16Zr3gVTdxZuR
 kcojDHtgqevj5W+l8ROyoGYg2ugXGtYEtsBcB8vVlWU0XBeABr6l5eeyz
 cseqtzTJ0/CTScuTeeosY8w6w/IRC/ksdc2xi/zxKv+wK4JYmGLYul1OL
 iLCC8FJq/Dwj9dUIO5qUqQz+3jT9E+/8cpMVgl8kiKRW+MwYFF9bGOxJo
 tMBQVRqiTIkoP8ufUr6fPqAhNIKPkMh3pvaugBQbz04WzI2wWAvkOXPvV A==;
X-CSE-ConnectionGUID: fyquidRaSfa3q6i9Bv3dgw==
X-CSE-MsgGUID: /GyXXlyrSQiHGwMhOJSG9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52176353"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="52176353"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 00:36:45 -0700
X-CSE-ConnectionGUID: hQSiNl3ERPG39sJhxqnoww==
X-CSE-MsgGUID: 9mHQM4DyTom/gpB6BG9P7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="153268242"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 00:36:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 00:36:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 00:36:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 00:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RepmvhfOcC/ynGtk7UlYY6PBY/DW0vQheM6LV/+dyHfDYMWzQHQY4COGvPQNnvw/cLbd8T7ICfpzQ3ZVjIHr6GuRV7vESvnUVNiIzk2OnY1HH5jE+faAUANytX9FOUa5zAOYJIcAeq+tHL1iOUV3rLfrJUOS2rgZ+HnyA2PINQghgYGK6h5XcAJ7njGU1Z9PffwLiFIvaJax/LCX3LhC8Ba00fdHeIN1KmJ0xd+8omHzBdbJPOr884A/WYmVUC3a1aTXMF9vX+ohgGF0at+pwYt+PCFJ6Isi9PubVD5r6MUhIFSJIbMkGoJI43UzbIbLZkXB/jhM6mevcebTyvyNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfbJTepio2wBKHhyZxqveROEV8HED7RmgogPxyNWBLM=;
 b=ON978DkKHXLUMa9/Ts+Z0HtxsXP3D1WdogUOLjE/s1UtYq55F789of9L1wRYwDeIW0S9VKcz+7hJJS/iJBj+zmCq2efRSJwvUWie05qqGxb/Mrm6W90sHCIB8h/T/EZujr0QjTIcjBZklTSYXPF0r4fzt1io5MrYKMn7UwQvHPgOKioJnPz2SoCkjTAQA5b2F5dorXhRESq9a876o7uEyBISss8rJYPSHoS62M6XG+XO0Ay15GitsRkUCnU3XdOXHHBGcsxILKpdInX72tMv9GVwAQfFtQj5DY+4HdrHzA0DANueaCRCsH9v9enmCkc0Q8jdySIsSzI/KlP/NNRoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 07:36:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:36:36 +0000
Date: Mon, 16 Jun 2025 08:36:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] buildtools: allow a different minimum meson version for
 Windows
Message-ID: <aE_Jf9p5HY17jc1M@bricha3-mobl1.ger.corp.intel.com>
References: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1749831278-8286-1-git-send-email-andremue@linux.microsoft.com>
X-ClientProxiedBy: DU2PR04CA0174.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 56620c3d-c8c1-41c4-bb3d-08ddaca88614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oBba1cZAOR15XAFgX6TeSmgjCyIbBvswVPBAgBw1/wWt58nGitAJyioY7Giz?=
 =?us-ascii?Q?RVDFRodA+FPnX/9d7LPxB2xUEOpvbpHdK2VNnfitQvAQ3XLevAbRTqoE6rzA?=
 =?us-ascii?Q?82FnG9umN5OBPW4hekFE/vU45CxZ+fQD8GaDjht2UqDlrXLTMQzh0sutOmov?=
 =?us-ascii?Q?6txMRyGpRyAy1guFwBrtoDQBAoDatxN9JBAUQ6ToykDj3/8JqHqD0oAzB8PQ?=
 =?us-ascii?Q?nsHe1X6zgrJMm9DkxwAu3qMqa0knF4Or7xmYhDJx+Z/R+gS1G+Qx9uPIHklC?=
 =?us-ascii?Q?AuupaIHxwl6vdjeNKdmKeTo9QiX4Z7JctOMRJUIafnK1Ii2FoX7oFpaKF23d?=
 =?us-ascii?Q?MrqMQdoHSeTUedHRPXPSH9nLkHIfKLFmKUer60od7mSoU30/ZM6yqkpKe1Tc?=
 =?us-ascii?Q?QqDWS+Xa/PM5LCAuuAthrMVZFIyKHbXfuULUfo6wYQyTUVbMHXp9RAtExnJv?=
 =?us-ascii?Q?uZvPF4cZ1eSMbRSUIMslZX6xbYjrEKICux3J99pjaH1CggIKROeRlL3VDq+Z?=
 =?us-ascii?Q?5VW+tkiA8uIJF/FX6i4sPq/+0/j+mAGmkJFxBVCpE/Eyx9uJH/MzFtBQoQqx?=
 =?us-ascii?Q?QcOG4U0o2/WDTX3tZtFz9IBLlOiygVKPzuwZkLp6d6znPyDwvPxzhDuAVXJc?=
 =?us-ascii?Q?gtZxKaEZYINVSgx6Nc3qCMEgOqvjKR5UZOgCVlo9pQ+DeG/T+ZDWxSLvIgMJ?=
 =?us-ascii?Q?gUy6daw7Hru4npyzsSOKXCSr8Kj4rx0dpKL605NybJKmKWGoQEe6lcApktnh?=
 =?us-ascii?Q?SgT5uoXTV2oTcHvOIxzJgivQzZ+3SAMyq37/KKJGI73VpIsck0ZRshYU7qpn?=
 =?us-ascii?Q?k400LWi7Pul/+nD/EorBFWzWXAKT8TV7UqSXUkzTctkaVRZhrMsIiFiZrkrs?=
 =?us-ascii?Q?IzXM9UQ9QFPDfnCnPryDaFqmzDhd5GmTLfLQVsOVOmiiLoV0NcuJj+lE+F2H?=
 =?us-ascii?Q?lz8tcBl9zq4HkbUtKtIpCxC8cT7hYkQmNoreI/Uf85EgKkPaV0atGcT3iUjK?=
 =?us-ascii?Q?8yGsJBjMxPnhYqFrP3p4duYUI6yIBm3lalhdwjD2awv0v8coFn65yBTeKtTz?=
 =?us-ascii?Q?gvaw0Ktnf7mA7RdtqeLc8X4eHAHlh/XdT82c8Tv3rM8LFpvitY5N19pEzmdx?=
 =?us-ascii?Q?eVJRu9qyGhZSwLv0MezkhKmQXk4Cn0nJLO1lW404YAYIdfDCWEbSorDNA75o?=
 =?us-ascii?Q?YIzIoS74fx3zBHEo/S0P6UsVcw/bpf2DmpyWIywzmJFXzwCNjgxa0POpPAIs?=
 =?us-ascii?Q?hhH2D4sAZNvZ9XSXpaN+xn/3OaLcOeMAwR7t/+sNCpUz5mQix+uwv7p0Xoav?=
 =?us-ascii?Q?qKR8IS881W8UC+CZpfEIwLsqVWB2vRs2hha04tyhiKkWlagI3JGjtm6hFxzs?=
 =?us-ascii?Q?gUMGlqp8Zj6KmqnUedKeD1PGzr7qmM58IMv/jQ7YbF+m3jZaPTneaNctvtaP?=
 =?us-ascii?Q?k6u18NWvJzI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+kKdKqGYgRG7CKV2PEAaKbROjMeATBwMqsum93qyV2eCVcDFKbtT6ixUY3/8?=
 =?us-ascii?Q?QvF97IspqtW/hqHwNL1ShEG3ckONG0e2JxLxa7kSBep3/n750EfTzkRpDiKf?=
 =?us-ascii?Q?VxmhdLuayIGqp9fwjNy6Gf+kygVNVkbdpHq/2eayGYNIKnM7ykBR64rh+v7p?=
 =?us-ascii?Q?v+I9NtsNakdF3XYKIrw74gXGsJ7BZWyzetI0ZttjhsYmRwUvj0LaL/6JSQ2x?=
 =?us-ascii?Q?BeLhxLj4Sk0B2v4dXsnhDF3sF70FBQ8VKvDHuv8e8edTabAvQOFPJcyYcXlM?=
 =?us-ascii?Q?IUgZLzPyG/FUtQww2yH6XKjwJIOhBPXmg4Dw6Bdx+nrdpAofHlUbArJjQtkI?=
 =?us-ascii?Q?01UDWcWnci9f7aVufx5o4aQVVPGMF5abD0qF5WBCrhtuUNguuU0VWQ6pGJMT?=
 =?us-ascii?Q?+1RBhya9qCdW/Xsv+l8hWMgbBeMppjdZU3SjjuykJg0dWAWUIiBIQhb/29eD?=
 =?us-ascii?Q?NhI65S0YKsfE0KzbBI5+ka5NIv7jE12DcSpK3gXoyKduNbNoSz0OTjzGvTbz?=
 =?us-ascii?Q?nYdZHXYQOh7pzUcB+igTRmEdG2FJMk3jNIpuRnlgv9soxhiFMH9COHhz2Cdj?=
 =?us-ascii?Q?Dpojufw3xyyzk3M4NzCPTHJa/1OkYKL0bni5gEFez4jt75stxh3dhercsSWN?=
 =?us-ascii?Q?/JpANyUwNUkeyY598XpBllvUMerDpdDryR0L5t+0h67FeTji9D6mCR9BZC7p?=
 =?us-ascii?Q?1qdX9TSPdLiXVBcGwMnTY4dp2u/Mk5albiakJlcbVflQwrCzIeBTeqr3a8A7?=
 =?us-ascii?Q?NG3ndQXyuIv4M0YXONShbCGRdIr5Muvg9Iw+mYK88Jyr4Ehb/TlGDCBdhapb?=
 =?us-ascii?Q?TjxP7xpdPgr7CvzQ5f+icuZ9v20c+rcmaHrEnAK67jms2Pjn35l5mIwArBaJ?=
 =?us-ascii?Q?XaBUtdq6S95WBOarhP5Ub0dNvzy9BKVtaXiDS9CpzVK40sQZw+v7TO5NLq2U?=
 =?us-ascii?Q?qfOQXRXFPwWwH9PTudb2aZnbick+6TBjtmapBE1p86Ewe28sRF3ahEO+L8bw?=
 =?us-ascii?Q?ikQ2Jg5SlqSESPJfklnxytvk4qiwIuEOmd1l61dVWgLOSO4dGENg+QC233jG?=
 =?us-ascii?Q?HPQCa1MCWmB4JjbUJcLE/5+uYdl9crc0sH6sgVvvtG5tNFNpD1msW1bL1j6S?=
 =?us-ascii?Q?eyzg7V6xboHB3RMav1aQJ7fEKI/05iPmlOGn+S+ZbdnrZoLVEb3a5GjLgymJ?=
 =?us-ascii?Q?wcSbRsg1SllKgSs0CzR55R+v96CSQvImGJQW/NfNlUfqt4W2P+g4NXcQzQgl?=
 =?us-ascii?Q?T3SZmae3oE5Mu90dmnrFjQy+2hNgJmeX4nu+EozTeThRZPiVK/CxkDhOdkGZ?=
 =?us-ascii?Q?NqeT8rjzrpCqMZ1/Z/FTqa+fXkCVsWW51jCkjh7yE+Wa0XNIwdgeNR6UpooA?=
 =?us-ascii?Q?kVW9MbScUX/Vs4v7EzCpi55+5ctBvTq2vh/0Ozr4gGQBJRyIboPXdl1J1vZz?=
 =?us-ascii?Q?07ZQti9AU/fW5Br2jSJup7htdqIsANoQLbIwmXl74ZPMRFP0RIXjyGVTjvup?=
 =?us-ascii?Q?dNyyzSGIn4DEA17q2xAfw+v9fbpgiD8W2bU4EDsiKYcOXvIesd8WECRis6DP?=
 =?us-ascii?Q?KZ00VuFdyNo+lk41CIDvRP1e1xYOceJixhLxQErjXACyAILwnEHJMnbS0bMM?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56620c3d-c8c1-41c4-bb3d-08ddaca88614
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:36:36.3021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RIIwpZaubBL6GFqGyB1gvhgAxw3EJpWvno5w6caUWmbdrjMHmmH6beeNu5V21sicKNyYgtwfvq4qyJ1eq0mCWifvhdEoRjTw1vVFtYsXXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
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

On Fri, Jun 13, 2025 at 09:14:38AM -0700, Andre Muezerie wrote:
> There is a minimum meson version specified in the DPDK meson project
> section, which has been documented. This string is parsed by
> buildtools\get-min-meson-version.py and this information is used by
> lab automation to install the corresponding meson package on the
> build machine.
> 
> Turns out that the meson version specified on the DPDK project
> (0.57.x) is buggy on Windows: it has issues related to path
> manipulation, and these issues are causing failures. Therefore,
> a newer meson is required on Windows.
> 
> To avoid bringing the minimum requirements up for all operating
> systems before a more appropriate release, this patch implements
> a mechanism allowing a different version to be specified for Windows.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

I am fine with the principle, few comments inline below just on the
specific implementation.

/Bruce

> ---
>  buildtools/get-min-meson-version.py | 12 ++++++++++--
>  meson.build                         |  9 +++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/buildtools/get-min-meson-version.py b/buildtools/get-min-meson-version.py
> index f0de8fdf2b..10a2596a5a 100755
> --- a/buildtools/get-min-meson-version.py
> +++ b/buildtools/get-min-meson-version.py
> @@ -11,12 +11,19 @@
>  basedir = dirname(buildtools_path)
>  
>  with open(join(basedir, "meson.build")) as f:
> +    if os.name == "nt":
> +        keyword = "windows_meson_version"
> +        pattern = r"windows_meson_version:\s*'>=\s*([0-9\.]+)'"
> +    else:
> +        keyword = "meson_version"
> +        pattern = r"meson_version:\s*'>=\s*([0-9\.]+)'"
> +

Minor nit, but I'd suggest shortening this a little to:

    keyword = "meson_version"
    if os.name == "nt":
        keyword = "windows_" + keyword
    pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"

or even further shortening gives:

    keyword = "windows_meson_version" if os.name == "nt" else "meson_version"
    pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"

>      for ln in f.readlines():
> -        if "meson_version" not in ln:
> +        if keyword not in ln:
>              continue
>  
>          ln = ln.strip()
> -        ver_match = re.search(r"meson_version:\s*'>=\s*([0-9\.]+)'", ln)
> +        ver_match = re.search(pattern, ln)
>          if not ver_match:
>              print(
>                  f"Meson version specifier not in recognised format: '{ln}'",
> @@ -24,3 +31,4 @@
>              )
>              sys.exit(1)
>          print(ver_match.group(1), end="")
> +        break
> diff --git a/meson.build b/meson.build
> index 5ff68cb3af..1ae51996be 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -13,6 +13,15 @@ project('DPDK', 'c',
>          meson_version: '>= 0.57.2'
>  )
>  
> +# Meson does not support dynamic/conditional values for meson_version in
> +# the project section.
> +# The line below contains the minimum meson version required on Windows,
> +# which gets parsed by get-min-meson-version.py.
> +# It is important to keep this line below the "project" section, so that
> +# the script can make the correct determination according to the operating
> +# system.
> +# windows_meson_version: '>= 1.5.2'
> +

Why not pick a string that is not a superset of the general meson_version
one? That would avoid the need to position it below the project one, and
save you having to document that in a long comment. (also avoid the need to
add the "break" into the python script, not that that is a big deal!)
For example, how about using:

* windows_min_meson
* windows_meson_ver
* windows meson_min_ver

/Bruce
