Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF0FCCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 17:56:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFB1D402D6;
	Thu,  6 Nov 2025 18:56:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id A8E064013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 18:56:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762451775; x=1793987775;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=H9ac16dE9K89kVq3uor2tG6+Af0G6099H+YJCA2EOp8=;
 b=YWn0RobpqduLL4qkF9HSVOKdm+H7wr1NzZWYEzvY80xNNnCSSQ3S0x+M
 R8YCwhSFwev+X4hEaePC/dxCGh7fOJ5/yvJ/VYACkd9v8eKoRsgUV4fwa
 X/w0c96kNoSjTWCr3EO/VGrk1j+i7zzuSamgNnNYqoqGGA/lQnopWx2fC
 HPIA6cI7T1vpOHEVkOpYLSFtUN6v6VIar+0xSSvsS3qGgLPJYHZtD0yWg
 iz0z9lM8D9bp5gZl7YG6IYUYL5gSOesXeitUh/bT4Vu1SyuRmBB7sFAO0
 0BUuKOO2Ive9hKWwOHgy7J4AeZoY89RYMbXsoCRMlndG4sX3ZgZ6g7z/A Q==;
X-CSE-ConnectionGUID: xnxjXE4pS+e+SmwXIGuDWA==
X-CSE-MsgGUID: XZ+/E9iqSu+g4YsuImJomQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64637963"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="64637963"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 09:56:13 -0800
X-CSE-ConnectionGUID: E+BwvDMDT9Kzi3XyQUgsIA==
X-CSE-MsgGUID: lURBnx/7QX+gzLdy6C5ABg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187663296"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 09:56:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:56:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 09:56:12 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:56:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2dPMfYxIrf7Vp3Gw87zAlHnfJSH6cb61Xq66KBsvgBoiNvKX427o08hRsZgug58np6XHoNHgByQR0yMsgI9RxOJPexFqyJ1CQY6bpitWMAL5HZmFnaEUV3X1OF08XkihtD8/7RpKtJsbNTv/t+5EHg9f6Jwb3pV9L3+tWaB47Jz3l43miHQ9xPzIoC6qqBLsuc6+0I+Z0MiSJtnrS+IKEcEfmqQsGA9icLE68CiTrCe89kjb0oq4b/PBB2qnytrBEP/vEvcy1rTQY1odmvMy+uAp/iiVrak+3gGBAJ3lXAGpAytYOSlL2+mEemNcBDC8jkqdC5B3yt4HVB7bdkGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uNQt298xuMCw6y4Q7gqzHWomYzpfQO8XmgOWBhlPfc=;
 b=tERTbeji2CxekBjPzWsBrH0VYVdOYMOZhMzEHp1b6X66cQDAqyysiHtMliBAklqnWX6Mtnx7a6QRT+SuCJwbehGO3v5wfTT4VEr6D5akyhCZmBc3eWgLPA7IjeyVo/e8KH7lEPRG/Es/B5whG0hu2WjeG3vff9j/VzuagkJXQjExKjst30vA8c+Bc8txA8qfP7PrLuMmOnbMR8YomXjcLskQ5DBLACS0l2aMWQAvZlzqmA9okNP6E47nzNhdlue/2U4nb3nxK8wQnCkCemh6k+ub29slh1PUA3oPwZdJfuJ5OUQx99c+8kWAhUZduMkFjxYoRed2QNSvAhjJCzd7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 17:56:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:56:10 +0000
Date: Thu, 6 Nov 2025 17:56:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v5] net/ice: add option to enable source prune
Message-ID: <aQzhNsYhvDjnkGii@bricha3-mobl1.ger.corp.intel.com>
References: <20251101104627.64906-1-anurag.mandal@intel.com>
 <20251106163334.95660-1-anurag.mandal@intel.com>
 <aQza75Qqh1j1nsJb@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQza75Qqh1j1nsJb@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: LO4P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: f7be3697-0469-42e1-f4e8-08de1d5dc503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jU719SFVlT6DDmxHy8h/uBma6PZkCUAhjJj1TMPmBR9kifKWnd8J6CsK8McF?=
 =?us-ascii?Q?3EsQKOnBxcNOnaU2aE0nWybE7RhMfRcWnuprgaAGi9zXI84tQgBNdAeOVc+i?=
 =?us-ascii?Q?k0s4amBl3zTA9HM1c3QmL1zysDMkiW0dCDGAXkGBHzvNWhgl9C0+JFeQd5Cy?=
 =?us-ascii?Q?g1N0s1INtB5OBzi+3lxodcE1V71dm5spaiqN7Xa5hQ0cE5bQsJeKJK/xA77d?=
 =?us-ascii?Q?OpqD+qGIGPY5nTlmkUEksTdOHEnI/WRqKNmGx73ba/v4awAldVk49b8XZaFi?=
 =?us-ascii?Q?PdwTbHIji3QO6xABz0g5tgHgNKY+ITJ4QbmvvlDVwbCmj2MIlFU7RwcmZq9f?=
 =?us-ascii?Q?+nKz4b5boydYG9qGtGQx80g/CYRhGNA1owb2Oq1q621XiKVKt0r15jtR0Gao?=
 =?us-ascii?Q?w8XXqfjlnlxzTQaDlYpI+nLkNW5kZWuBNY1FOGRIVcXdRAA1uA5PJzO4blKP?=
 =?us-ascii?Q?uaytB8JEVE/JJgJ6ZwFu1w4crYNXo9IHqdmv1rCnrdYy6l3aixBN236z7Kji?=
 =?us-ascii?Q?bTd7ASMiqg1qw1N2DrMec0snCQQ7zuqGZ69KgWzwK44TmuzR0i1FQ9Pah+wO?=
 =?us-ascii?Q?KELPRV+CFCHNJ/fCx/nypXu3DPsbq+7S/fCnOKGPzCvxZKqeZ3EMuhlTfGfF?=
 =?us-ascii?Q?b9ZZhQyq++l7TpWilAkjYVbejVRrUMg3e7AIvH8Lt7MA62VuOwSOATNHajz9?=
 =?us-ascii?Q?+jpNBLlDQsUhbS0BJaDFOciMnpYmN7J5M9cYIt0UxT+T7cuLIIneXsDXpx2j?=
 =?us-ascii?Q?2jIn8BHXZvr1yNTrw5oUSol7yRJKJujYjhGny5ZDH15PFDCmjnqrDHW/44Ns?=
 =?us-ascii?Q?kdSZUZfeOflw6KOXBwp0/zedd2W4WpiY6bN9IIAmCo7RPEchh8NMsIBQsvH+?=
 =?us-ascii?Q?1txlyqF9rCcnp9BEpvdFBy9RJStqjEPR6tlwd9CR87DkNGcSwlsBsciHVpu/?=
 =?us-ascii?Q?gmtwZbGnkXyXfq3LewXUHN7U3BtectsV3tUbQ3yseKxLM641gnzVqHcLzW8a?=
 =?us-ascii?Q?bkqAjP5xx4DdVm6sCSdGpjEAAdmbsaPY7s8hZXcLEqR2Kyo0phVgJw+uMviI?=
 =?us-ascii?Q?s5heZC+nonaoh0sD3EvdD4n8ZdL6tiHDtz3kMA8KAl+lH130r/faVa2I7DwD?=
 =?us-ascii?Q?ZejsRtKE6XQyno8ohazLCI+TaiALzeSJpZFFiKiyiNe65Bovg++P9AEj7vS5?=
 =?us-ascii?Q?l7GP9+AIdYazJGmq9XDgwAcEFR8ZwineSJruynbkr3OACk7NfiAoGcpcfJXb?=
 =?us-ascii?Q?pj37kGW3Zw76ZczhqbY36L5j4VB+avZum7nO5ZNmPQ08xMJTIDo4xRLKktic?=
 =?us-ascii?Q?ESSIBNcyKy0sBGRo3x1DgnPMilqc0H0RCwGAqclN8u1HNhaRq58DgGJErt9w?=
 =?us-ascii?Q?iM5N73YZLf5VMYymLlTrEH1BsBd1gbqywXhh5ae2Jfl7wT2gG6r6CQG3+8Sx?=
 =?us-ascii?Q?q/Nhc6ihCYHOXAYv+ZGjbEegGZfc6Mx3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q1f14dfwXAMy6VBrn7l3eQHkLA0SsudSoBmqLrr77jUCMHsLHJ5IPt/ASSIQ?=
 =?us-ascii?Q?WZbnQdyuqySILJu26/06W5+IdoWAItzEMxGGE7LF2gtNIXUBYtODPWrKfoyA?=
 =?us-ascii?Q?3Axm4QYWDF2g2p1L3K127Fv6l++4RdtX9p2Jygnzo3fHaLAY3DapaA5YxWCc?=
 =?us-ascii?Q?CDPhHgGmm0Dg1b5lXCcRKndsUnM8W93BDyFPDIhbc8PCRkvCEieMW624xkCK?=
 =?us-ascii?Q?gQLdzhCpD5W73yhw45nW+YyYQdNHEZefxOGFmBl0LgEK6qWE04a2E6ST+9/m?=
 =?us-ascii?Q?XaduIpLfXJP1Wfwscs5KOUHXD4Ig9f7WoJNVIQGYYQ6eXCXTwtUoN3YNRAhh?=
 =?us-ascii?Q?pEaGmvDxa1BroswLNeq8beg8QCf+QmQaqvXOhm7YPp8+xB9aCZIjciC/7fbA?=
 =?us-ascii?Q?+ywFlsek6wbMojDrMnZrcCc/AcKfcyXJeg8qtET7CdwOcDLBv5HZzSzSdlwn?=
 =?us-ascii?Q?89oA815xAdmFTczWd5HHynRhrK5q/qVpfIB+Yh75a81NEOJfeNk9ZmDx2B91?=
 =?us-ascii?Q?CDDFgRfzX8EddfV4lWxorH+zl0YFKLSmtzF+33fqgrIf2GAS7mHSgVZboNlA?=
 =?us-ascii?Q?H+Fmmj7o1Da+krC7D5fkQmfHYo/28McUfnpl+ci2eIlfdKRR1bp2CG39rHlz?=
 =?us-ascii?Q?NU4wjo8EumjPPWYCh/+a29sHvrP8nUBKPo14vNAJCzBwoQuzHuCm0/K6aNwL?=
 =?us-ascii?Q?+ls4wsQU0CFkmlQdyTBVSsSb1UqeaFyk6R9fLtDsS1e5ulbeftFNDaEmZhZd?=
 =?us-ascii?Q?I2LhJt7b0/W4yke1SK5i8FzWjXcCOFJR4TjrpTsVzGuAQBbecHbfb4lCkfnt?=
 =?us-ascii?Q?wMEu7wQrS6kmQChQFiS9lsf/zFNEBRmdDBagcRXbwrlsN1ybcfafAq5hLK+5?=
 =?us-ascii?Q?fsXLuKjs+WiaXsBwf0YqLrI7OW+IWn3ZoitdjqCtOII3C+KpQAlNppufLH2r?=
 =?us-ascii?Q?v/MDxIrstXayTjPjmS8tmwRQpf8q3y46S+6/O7ENKZXsIbVYVNvCHdpw6lXR?=
 =?us-ascii?Q?xkQRtZqb2P5dzW/gvVrom5O2EAv5OZtS/fUTXOU7oqQ4apJmG7ARYLi+iqun?=
 =?us-ascii?Q?MXBl/WJW5hjTYKEsJ9AR8eT+3VJXt6TJgKBWnZpBTsxwVFa5g2iM/Hok7wMI?=
 =?us-ascii?Q?pYFBAu9kY9vZBFdYPVUDz5ioalxAt6WT//clwtNb40xYbqFuwa7lCiXCyK0w?=
 =?us-ascii?Q?fWz//5Ov8caSKU2vYFNqnUQHIEn4JLDIV8RSmBYj1dPksiXHU/dedVR2sYZt?=
 =?us-ascii?Q?x2U5zY/faL37sxB6Ei9aBjYCzh7vntqbyeJs5iBeFwZD30KHrcpMgrHHn+in?=
 =?us-ascii?Q?bHb16xsu1L0bk9F7IAk0EQUThz1EjF7KYZOkAYNeETPuE/bnpMFzwRUNXQMh?=
 =?us-ascii?Q?7OKiLFjvbUq9ArG1grAuap//SN8eIE0rLXu8UXwfEiUSZy5DLpMmVslw5S40?=
 =?us-ascii?Q?H7O20T+iDKQk1kVD2grUiO9z4eVrk6h354AnYyOnVaJ0tTBprLaGRgp4FkRR?=
 =?us-ascii?Q?BYNjaqfliyv5UMfHOX0SjqjJIk+xWsZuVhd9mB2UvayqXWuPVDbcPwbsqRiM?=
 =?us-ascii?Q?ICToqFx4ggccTWBmYceyLoL+alem46oy4bCn/ykvdY3puyG3ekJVh6V+6GSE?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7be3697-0469-42e1-f4e8-08de1d5dc503
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:56:10.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oji/xYIgx/wwprBJ9/Hteoo31y945RvDxdsrMZEnxBt8VSFxPO0bc8tg4/y+rDAsInOOmXDA68y4Kldya4eKzJ0FNf3Zv2YApMwdDhe+iHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6462
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

On Thu, Nov 06, 2025 at 05:29:19PM +0000, Bruce Richardson wrote:
> On Thu, Nov 06, 2025 at 04:33:34PM +0000, Anurag Mandal wrote:
> > Source prune is disabled by default to support
> > VRRP advertisement packets in a vsi of ice PF.
> > There is no way to enable source prune itself.
> > 
> > This patch introduces devarg "source-prune" to
> > allow user to enable source prune.
> > 
> > Enable Source Prune to automatically drop incoming
> > packets when their source MAC address matches one
> > of the MAC addresses assigned to that same NIC port.
> > 
> > Tested the following with VRRP advertisement packets
> > in a vsi of ice PF:
> > 1. Source prune default mode with no devarg option.
> > 2. Enable source prune with devarg "source-prune=1".
> > 3. Disable source prune with devarg "source-prune=0".
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel

Thanks,
/Bruce
