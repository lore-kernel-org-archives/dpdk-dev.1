Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFD9E81BA1
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 631A5402B0;
	Mon,  9 Feb 2026 12:40:55 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 852534027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770637253; x=1802173253;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MrmRRdtlQjjnEl4qrXFrO/tHhlMk4wQ+2YMWh3x6Ga8=;
 b=m1kT7w5MMuT4GF9yuJQa7h9DSQFJlCGaaSh2j5lseGMTzV4Yi0m59ldl
 PUYrDXMiEvZaC859M7elVio3frRiTXTIfBKAaeu+q4jE8X9swzo5dgB6t
 f0G9W7QcYLMADpK7ua1Q/AHFNnq7dkW0WyMSGGacSPyDkDqjZLXzoObdb
 SWe5AhMqRy5We/OQum2vTFp7sXN/thloD36sppq6o87AE4OsAwYRciv6s
 WdogmhVheUX2ET6+6Hj5RaDfi27N26rZ0KQBZYvf+e8C72+bavQY11tUx
 LOdSKR4beBUPXzu7wEHqpgzLPvYY7f24fJsKXEVelF+ivELkDAAMYuo1y g==;
X-CSE-ConnectionGUID: VEbn8qtETxeS9wj8puy7tg==
X-CSE-MsgGUID: 1z1iGclDSHexDL30VtUoiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="70951927"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="70951927"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:40:52 -0800
X-CSE-ConnectionGUID: uT5cWqB6RjWSq1Eu8zTsGQ==
X-CSE-MsgGUID: FR6qslOYTaG7X7Cutio54g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="215974205"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:40:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:40:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 03:40:52 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:40:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHyYqvP8Nlp7722bUcaZ+Ogbj7S90Rbb28ve0TgPxD0js6LUP6ejb7oW4hL9LGgAr4V4aWbOGcg4uG4R4/5cEVNFCvMezgtlUGyTLV8E9k5C6u3G7jyxxO6RvsqIXzLIQFuKN2OobC7Lv0B5/YM0nAs0Pt20qMooqgm55BZ/U9Np0VRSRFeEryd4JyYXzhlaK0T18jkdxzQOZ5vQ8DlF5BuYz17WP2VIaGjPqfQoqdQIaHUqj/h+3/WzNdO3x8StuNJb/eTyrZgaGlsiCnAHjNDxsgLxGms4cNYouf2U0XuaVkQZsknmX58w9l3JbA0IrNxPMM0tsaUZNn3OEMM+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au55Buc4Tu078cvfy3Pc3YGxYqUF6PKwWUYA3FfaVio=;
 b=Tm1Xyae9NT4BnK98sgKZ8pOmOaJwf5UygU698zYW7J7M61EnJ50h+SCD2BrjmZK0WL8mE50koExmwcpIIo0VU61pGIfqsTU5JUG0S+tb7TxOwbiT8x2x2VDcOdc5jUEqPw1RUFfJ5GppNPpXjZCZBgXs37ODnBJ/v1BnTMtph9RtweP4guQNl84RdtXQGrxZ1fcVL7j+trv8cblML041TTbiISvIbEWUsXSEvCeirCH5+sT5H0PFlYQ3tInm8dVbVQjCfhQvqvf9hDfcvjqpRU28E2ycjf4jlL4tTgEgRwoFbYS+1gmpw6L8KVd5UEYSh8xqfC5iyNnjIKNbUxdUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPFB0F355549.namprd11.prod.outlook.com (2603:10b6:f:fc00::f45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 11:40:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 11:40:50 +0000
Date: Mon, 9 Feb 2026 11:40:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: Re: [PATCH v3 10/36] net/intel: consolidate checksum mask definition
Message-ID: <aYnHveC5Y4_iNat5@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-11-bruce.richardson@intel.com>
 <DM3PPF7D18F34A12FEC34AE8A326C0E0F928E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A12FEC34AE8A326C0E0F928E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPFB0F355549:EE_
X-MS-Office365-Filtering-Correlation-Id: 4018d7a6-d6cd-46de-814a-08de67d01329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OLcHSWTYGfBwqLMOHAwd1lszlGz3/VeJTcE1UIa8sMjON16N0ll9Bum0IB0U?=
 =?us-ascii?Q?WFPG4nF09aktkv1mJM0Cv51Knvj5CAuIniBE2hkhHYJhAn2ANtFo88MGYIVp?=
 =?us-ascii?Q?xfTrHsmbNrtZwxKWznVjrKiKSSu/mh1FiKRMNn0P0/JkEOn3t5H6gpv68iKy?=
 =?us-ascii?Q?UL4Y4VBCBubyHsQhbOMlo6E4ghcj62d4Z0H7A11hZlfft8t3CLndeeUHodtg?=
 =?us-ascii?Q?nZHnwjzCf2fPpUe5H6r/szzLdEbvuX8u8+1RXBC5uBeN7ih+fgcWr+9FKWMA?=
 =?us-ascii?Q?ZT2q9wI6scgp61csTIECLPsi8nx5CcvZQ0PBbxzld2xFuXTVCquTjRmYVtMR?=
 =?us-ascii?Q?mKxu2Ktl5Vi20jzRk6qlfW1X2j/SoB22uxxmXoRDgB0FM1RXcVIlPK9jhWDv?=
 =?us-ascii?Q?7lq3WEm+74QJ9jPmst5p5BYPDTbxAahujlXlthnQjMDU0c5Ykvw5sCsOpoCV?=
 =?us-ascii?Q?HxZF6XIMYg3om9cFl0Euvxwe+BPdaC+lsRmxDtvUT5RQF+mFwB0kbfk9Qy4T?=
 =?us-ascii?Q?xENMg3mJfGgcJA5MOYFOfudEo2gita5M4RYNpBEMgEW7b0i+TWOV98tIBaWE?=
 =?us-ascii?Q?EJyGKlSdMI6UdWM/B9CI3X0Xn6Th3j0Ue9XIXOBzj2WBPweosFEXl4mzCP2M?=
 =?us-ascii?Q?/3Z6P+YJXmahblKDZ3F8Dg+dUi7wctd3g+hz4GJk1EM1dr4faVvH+fa7pOZU?=
 =?us-ascii?Q?83Mc3A7yOiiXi3KZPY3KRQAZpHwVr6DNDQfHBH0mlo0WmnpRHuGctYEgrZ6R?=
 =?us-ascii?Q?m/BGMPebJUuVfTlZmdpe3hDiNfpg90h6VufaZo4zH0OKG7/dsbrvqZjNo0Z6?=
 =?us-ascii?Q?ZOH+Bo7N0LdlmZYIpuCpNTnkJ49w4ixclR3zCfDj/e6VEuum+JUaoOflhACu?=
 =?us-ascii?Q?ImaeCu33BJSPDfMImwGZW4ELFRukmYOl5hyFTM2WyA4kDCJczsX86awvfoT0?=
 =?us-ascii?Q?nJQPYc3eJtRgUzuIK9/jLEeKmlWwWvkM4dI2AdN04I9aKXsojcY3mSvXetNe?=
 =?us-ascii?Q?AQ++E5EVCWqW7/EJ4ruPjuiZKu9sBM2gQSq07NZ1BJiH3cwxKRD8t53u+H5g?=
 =?us-ascii?Q?oVwPYjcY6gmyC3vqXYxTFu3DO3/XXXNIIx8L0UV9G1DN0pM7sTtSNQvPYiGl?=
 =?us-ascii?Q?ahsbryiSMojQTh0eyyrgrUyJnxyVdCnMUOCPANwvpEAoRTIq3fLGk1TcHOh0?=
 =?us-ascii?Q?XowZ7CaFVYfK1Bl5yrRtK3B2UTFkNif4ZnJs/u2pvbT3dA5xSRDQ4fTMC1Vl?=
 =?us-ascii?Q?Sj1g33uNzpD3CVszSxst2+co/T8ltWa0ZJi2uEujFtZp/6Fq8JROMgcJfII/?=
 =?us-ascii?Q?cA1iPXxawmTNdUJfbyVPorvFeiI5CcxVWjdbbwrL/1KVZ17OUGtwruwsRQGo?=
 =?us-ascii?Q?8vgbTCLuiSjFR2Pauojd85SzXcxeDzpeDP4PkhGsCLt3Fr2emqQeEhkWPnPF?=
 =?us-ascii?Q?CCNTFrImvLJrKLbvGGSM6KpF/USEVvMV3fpzSOyqKxZxxm3zNRrC1PLxi3XS?=
 =?us-ascii?Q?JxsJPwrohx+6ggBVrsn2jU0kCt3a8mkGZ4Pvf7y47Bq74becWJKVM9kxFybd?=
 =?us-ascii?Q?+INgIqYXmnbkgsXYm6s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NLjnkqVW6Vl5bWCf0HWOV5qebnp6RzOYZaXWrHgf0YHc3beLM4x1rCm8Qy1y?=
 =?us-ascii?Q?lrkue+UXMY1VYSkZluGzVdgYKmTU5S+KLGUi6yXTGLQPYUUqW1d/DX53/XKk?=
 =?us-ascii?Q?NpC+yvn5uqT75w3Px5YACJnRXNTA/VW13gsJEOP6bJnSmzGkcnTU5w5t4cix?=
 =?us-ascii?Q?05MAKO8H7ou0vkBZvIQixpWSfqXIHy57LqzaY6zf9WJGKDPnQWoxPvfR7c4s?=
 =?us-ascii?Q?4WPEl9hB/uFVRTkr7DvUO1rrFzCxTW01lcpLWxvml3ynVKCtq8iJHL74O6Ti?=
 =?us-ascii?Q?4H7ezQbIOdaSmstLuWa0vRxtlTMl4ApLpRkLlCuNNZzDrsKJZ35ta8dniUmI?=
 =?us-ascii?Q?ikpHIUOTZU3zsJwC+arAJJuV/vikiYDOR4FzoV38fQjCRcxhXJTwjibVSMHJ?=
 =?us-ascii?Q?ccQM6UBx+3xDhBI9SlIg82M/xQteT4IbGzjmT27OvuyUYX/DGVtwe124X4Jm?=
 =?us-ascii?Q?F0lAgYYWPH32MiHsZHO6UkgPTwQNHqAjsSDlZwkkj5Rd7ZDN7CC2F+uZOJG0?=
 =?us-ascii?Q?nOK2taOA6ZyU/qi2NddqpHS107UUBgVrnTAyBdQ/2mSaDAcyAlF1i6WPSYAa?=
 =?us-ascii?Q?Z+lrxJo7cQpbuI6gAQ9e5jI4H+XXu6SrXC+9GNqUH9v+NvpbZBc32o+IhVcJ?=
 =?us-ascii?Q?k85tsYiP1VrWZAZwf+5Py5X33q5JdbCeXP6ivGEV7WO5MH58on57OVrz8Vv7?=
 =?us-ascii?Q?0aph5J0W5LYH01C/mZ+GP5N3UShBp3grNgVc9GHbR2NF49cDuljKSPIT+mj4?=
 =?us-ascii?Q?3BScGObmpfQdMjY9v86imLUIJhKMdE+4bfSqVGOyhvbD19++lUdB75Qxo+vO?=
 =?us-ascii?Q?f/dooQtHbIBFUIWUMJIBeoPHhCoWRfZb2JbFJ8xNRj3v5DDOuXgCKjR46IU3?=
 =?us-ascii?Q?PvxIXeGt9SPBL1k5ysmbb0XqXByfkGP20hfihMWDa8FLiDlHwjMg19c64cAb?=
 =?us-ascii?Q?3S9kIVvfhq3nQGJCxKMUt30Kk8S4Ak6fcHcxF0/biBJn6U7FY/ODHC5Prp3K?=
 =?us-ascii?Q?vVfO1baYRn2iex9PrlsVfijCV7dbOkY9cObn652/X2tQt73BpcG5DsCS+lCF?=
 =?us-ascii?Q?zWcPwkUwP5qali/+YE/m2cyJI4GwO2B0uPkxmreGMOwI+s6KdKpoFlY0f7Nj?=
 =?us-ascii?Q?ezFrqa2UwPiiE++/cAAnryjEPhcoTyiCeSARMYZ8OkQT1MgYsD9B2dBYjWiT?=
 =?us-ascii?Q?e4T9aOTcNbsYv79OB/kEpKWTrBS9g25arY83273OFaInxD4T3KYSKR0aDUyA?=
 =?us-ascii?Q?D5XfSpnbgylsLN/EniWlT51FOS4kEk7pe3Az6e7IRdzhfhy39SC89CX6yX8U?=
 =?us-ascii?Q?wEIskqGAjcFkbPRbgDN7b/03aHtuC3njkloKSfENAA77fwaQnGUj+rwOhvGN?=
 =?us-ascii?Q?u1/u0BuixisplZFzF2og8plfjYoT4KKiAd6ZUQowFYRTP07JXav6+M9XQDUm?=
 =?us-ascii?Q?sQUDNJi/qseFYxbiLfK01PE+WJNJIOe7Whg12bfMHfUMDGxL+64HbThfM0Lh?=
 =?us-ascii?Q?T4UDs1sUGKxOsoHEJtcMaK1XT5v0Y4Jtu20fqndO9TR3cOcjO8dBjbVqWb5i?=
 =?us-ascii?Q?8ZlZYjeWpxzDKgm+19549W8z3TiTBbeS+l+S5Gsh8alpMXQ3/LmTyxM4m8C0?=
 =?us-ascii?Q?YbvxpedSAI6F8eruUrA1qPc0b2v5+lNVRqEnxHFLZ7KM5wceBJFyOxzuvCxK?=
 =?us-ascii?Q?QJmCyBqIG28mSnmyy7n71FPK+u6X0QJyT1HQhCB4d9g7+GrkfeIHPHt6ubca?=
 =?us-ascii?Q?S38ifEt/6HusJMEC3JmuJ2+Dq9XWqL4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4018d7a6-d6cd-46de-814a-08de67d01329
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:40:50.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDYzIUbDaTG71XNFk6bNSOp2MzxhUwgBylqWtTFgHqxslskjHGdYHhMQt+ZHAGD1C38lEwstQeMgeJ8eiOwSQJu1LDSLMCK/yEaKE9CV5Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0F355549
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

On Fri, Feb 06, 2026 at 11:25:36AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH v3 10/36] net/intel: consolidate checksum mask definition
> > 
> > Create a common definition for checksum masks across iavf, idpf, i40e
> > and ice drivers.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h             | 8 ++++++++
> >  drivers/net/intel/i40e/i40e_rxtx.c        | 7 +------
> >  drivers/net/intel/iavf/iavf_rxtx.c        | 2 +-
> >  drivers/net/intel/iavf/iavf_rxtx.h        | 8 --------
> >  drivers/net/intel/ice/ice_rxtx.c          | 8 +-------
> >  drivers/net/intel/idpf/idpf_common_rxtx.c | 4 ++--
> >  drivers/net/intel/idpf/idpf_common_rxtx.h | 7 +------
> >  7 files changed, 14 insertions(+), 30 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > index 01e42303b4..928fad1df5 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -53,6 +53,14 @@
> >  /* Common maximum data per TX descriptor */
> >  #define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >>
> > CI_TXD_QW1_TX_BUF_SZ_S)
> > 
> > +/* Checksum offload mask to identify packets requesting offload */
> > +#define CI_TX_CKSUM_OFFLOAD_MASK (RTE_MBUF_F_TX_IP_CKSUM |
> > 		 \
> > +				   RTE_MBUF_F_TX_L4_MASK |		 \
> > +				   RTE_MBUF_F_TX_TCP_SEG |		 \
> > +				   RTE_MBUF_F_TX_UDP_SEG |		 \
> > +				   RTE_MBUF_F_TX_OUTER_IP_CKSUM |
> > 	 \
> > +				   RTE_MBUF_F_TX_OUTER_UDP_CKSUM)
> > +
> >  /**
> 
> 
> <snip>
> 
> > diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h
> > b/drivers/net/intel/idpf/idpf_common_rxtx.h
> > index b88a87402d..fe7094d434 100644
> > --- a/drivers/net/intel/idpf/idpf_common_rxtx.h
> > +++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
> > @@ -39,13 +39,8 @@
> >  #define IDPF_RLAN_CTX_DBUF_S	7
> >  #define IDPF_RX_MAX_DATA_BUF_SIZE	(16 * 1024 - 128)
> > 
> > -#define IDPF_TX_CKSUM_OFFLOAD_MASK (		\
> > -		RTE_MBUF_F_TX_IP_CKSUM |	\
> > -		RTE_MBUF_F_TX_L4_MASK |		\
> > -		RTE_MBUF_F_TX_TCP_SEG)
> > -
> >  #define IDPF_TX_OFFLOAD_MASK (			\
> > -		IDPF_TX_CKSUM_OFFLOAD_MASK |	\
> > +		CI_TX_CKSUM_OFFLOAD_MASK |	\
> 
> With this change should the features in idpf.ini be updated to include
> Inner L3/L4 checksum?
> And IDPF_TX_SCALAR_OFFLOADS update to include
> RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM
> RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM
>

I didn't add it because I hadn't tested it, but since it's using the same
code as other drivers it's probably safe enough to add, I suppose.

/Bruce
