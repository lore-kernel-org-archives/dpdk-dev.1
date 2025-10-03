Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A10ECCA470
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 08:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E158640265;
	Fri,  3 Oct 2025 10:13:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8613E40262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 10:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759479234; x=1791015234;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SpJkLTVFnPtQUPhVCUbQwGGH4HJZpUXvJCt9FiNXoa0=;
 b=SYUbcfuyBo8wRivV+oUXO013s220f/aNYdHOLroVaHb0+rb1WVllaFTX
 5NxzseEeuRFHQcvduFoPK9PsxBH9734EWgcoBhPgrKTr1787LOUuvrwHO
 w6n8iJcnyyhOn/SikAE9j31LH5XX/BAgQky3WKdYCUSmfaWysEP/G0ww0
 dxygUccz6YXRJdfIhRiwhqAEkJJwdWegoDq5WoL8+0v5PgCKRF8at3d+i
 0gu1Qx/ZU85kmY/mHYYEHTOOCuiaKjN0MlarE65OeJUO+YN+Z+kFbKVIk
 8BC7JIhlCPxYCYMsdhIBfkgmNxafY0CNd1Hm0Myn87YaiuTofLIljMgUD w==;
X-CSE-ConnectionGUID: TlSPsTlvRqKEymTMvZ79WA==
X-CSE-MsgGUID: 7UQfRzuSR7C6AOOBoTbXJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61724691"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61724691"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:13:53 -0700
X-CSE-ConnectionGUID: y0/quLxCR9u+9I7IRn3USg==
X-CSE-MsgGUID: ifcRpPgmQBq0ClF/bT7ykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179258403"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 01:13:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 01:13:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 01:13:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 01:13:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNCw4Y8F8xkgoFAxARg9gLVVEb8KzGx4wgrrQlBU07U5HTbSDYTai3CRYAdnyp7v05E7u3jC8+kCqkYRlGnUYDQDU8qMjNkLEW5H++dof+kP+l/VQ7qFBdoD8HO2RZfBkWaJ3vozEeGJ4vGweU2hxEfp16KujsOzz8xXn0QsUOwiezPNf13pZw5wtyfgecJ2WdpD5Jsct+kxUHrag0m5OtbkqnOogwM/REDXA5yuYDS9Gdb1YKTc7gIQsHIj5cXAV8aFfRy/ddcYubi7Ka0up0yissc15W7koPr1MxqM5jDyDEAxdlFt9yk4q/rUik2Cmtx8Hxb74NvZbmQNlgjlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVmKQoTnnsHfPIw5BXlj3T1HGpxPPBHQmlmYSmqLjHI=;
 b=r8b8bL4rm6M/70qbG8ok8behjPz+RZ+VHHgEkm4Q68ZZjrbdNNwr6ZuEQukUEWYqp62WoXaRNkOr+SPF0c4EjZ3N8S7Hd2q1JeFXbiHsN+xQPq8jdfVv0SnuaO4KHp1xPww9G0iiWracZp5WVoGVxp+5yNniOD+lEoTm1jhuFgYIJ+4OKlGvSUkbTIOyBfA1V0Db+tRuenMFKk5RibJg7JxulSkvZf2bQxc8+KwIuus4DjV/Ssby9fTEVTrOtW14buGPzgXLVtZ97RLRObc8HuzzKFMZouU/0sL0ic6OLw5M0vttSDsAhdq+HXyXqnGYA2zlriKmktBunN5hbphUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF248AC5624.namprd11.prod.outlook.com (2603:10b6:518:1::d0f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 3 Oct
 2025 08:13:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 08:13:40 +0000
Date: Fri, 3 Oct 2025 09:13:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>
Subject: Re: [PATCH v8 00/18] Simplify running with high-numbered CPUs
Message-ID: <aN-FrwMIoyDN6_W5@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20251002174315.962992-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251002174315.962992-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2PR04CA0309.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF248AC5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b459544-9160-4964-1da0-08de0254c2c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V2Un4mwebbpGzMIYz1Py4byFNUIea0IPrQdXavckBiKmEhGN2vy7A+p6hb7R?=
 =?us-ascii?Q?CaZbjZ3aXAtr/11nkJojQRFfKz09ZrMkKIdG4SJtHGzAuEB+MfbQypSZ/TN5?=
 =?us-ascii?Q?ZFfVFEY9CzlUrFDLIr0eh48uiKFW4K1qleryrLYpx8Ha2NMIo04C33NySVw9?=
 =?us-ascii?Q?CYFLI2VSfmRLnHUTvOjfpPDcHvMmi4UkBZvWxQa/KfhwipoDiRTjcqk4E1F/?=
 =?us-ascii?Q?PtBqnZIjTW9+aMKJYFZg0ocO16XNxyS7fo+RupeU1suzhzAQ7vsDehIcoY5N?=
 =?us-ascii?Q?AHyW04dkOFQ2CbEtMDaXirUpitGDFJcgo/dVb/WA1VTIf+2srAbkShKHH3k1?=
 =?us-ascii?Q?CQLnyzZF+ku/fWWRLwLGYFRQI/3tJkGtcs0DlD4cuxo2abnmODihJzjNPAmJ?=
 =?us-ascii?Q?tAZXgFYYLeIQhZCzKTwunEONsvuAccY6s3qBvOm+2RMM9FB5SsMq9G/lMgTA?=
 =?us-ascii?Q?ASQzCTtRiMOKb54FE0bnlGH4/aK9w4rc5vpCETuHT4g1qGybrhU81wmMm49X?=
 =?us-ascii?Q?AmSlvso5J4PbPm1x9c0CO42xCu0ms/iLh+DKYvswKVCj6YBzqrceLUUHj2rp?=
 =?us-ascii?Q?lvnKrB5gVetXotAee2b3mChs0ABdeAhMVRknHP6mN94/U+krRTP7CGQppK/z?=
 =?us-ascii?Q?N3qbNViHbJmo5hNUb+l2xP3HJCGd0Wppo9f52Cgkjh16p0PiywVH4zI5xGlz?=
 =?us-ascii?Q?4ipf3G2ccU8KsO1WlmI8Uy4w0W5KUVVEi3vuH9RV4DAQbpQ/DmJXWae0UeXF?=
 =?us-ascii?Q?fwjwAk1OcBuKzGZL1BaSPZDy8ioGUOcW/Sp909+SrXyHXcLuTHTzMgh1PzYR?=
 =?us-ascii?Q?cK37BSgOkuuOTMBKpPPAlsOdJHK46N/I0C31foix6Mxkf0reBuA10EHBU3Rl?=
 =?us-ascii?Q?m96ohxN5NSBJxV9voad/6j1xyz29sWLBV4zgMMek/yITRxza3cxa1TN0EisC?=
 =?us-ascii?Q?7ZQjOjNZTQaSNiDr11DYu8oDiIohCAgncrEfYCnQ142MSiTKhVJyfDDoyDht?=
 =?us-ascii?Q?uUWQrxfkJA65ZtXgSJgIbrRBo4b3Xf2x09AWuS8lBYwcmAhUJ6AYsngloLlS?=
 =?us-ascii?Q?h4eTuEPlBoC5EoraVne6+MV2z086wkQZMLr9VQgnSMMUba3CdnakF58ax6/F?=
 =?us-ascii?Q?hDup1oNz17bm1m4tryEG+oGeexzK0SK/ARG2QEVtafW8lZCpIZfJY3axYiZz?=
 =?us-ascii?Q?hSTa+Vpr0WS/rGKvbZv/FS3PxElmsD2AK936O4BCLew7dqzPzq6AV7DfNBT/?=
 =?us-ascii?Q?sPDv0hHUpk521BQBaxIkkxtbMnbbVld3knBjRt7yYZq0J0m/2dRHk1MOLJZB?=
 =?us-ascii?Q?n8goAe7Rxlg8B931jxSpXcdZSIvIRC9MpSouJ4rneU751P9Fnwd5Ehje2zGK?=
 =?us-ascii?Q?hqDRlYQJjEsIsUzsL650i6o1Wo15u0IiFfJSd4xAAzKeY2gjlXKz/B8ChNig?=
 =?us-ascii?Q?Ah4jftDdgW0jl4Fu/2q0G2deToXM2dN/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkqgaSAhDuqdbOYeyiUHqxdLQlHHWhg5YSxZ7HEGxjTti5cqM+oaR5L9YeZZ?=
 =?us-ascii?Q?ExBgIurBHetw4+iUcMbSGZzoY8d0UhdxsBvw8MJBl5UOp2rO4YkkrdkctOil?=
 =?us-ascii?Q?nx9fPcvh6ynpTgvbYZ5RkYflaR8FCf8fA6kTolA4BmKaeVgpzE98Nw2j95S5?=
 =?us-ascii?Q?3HRy8uN+MK39Z3D7mQ+wWECwuWVoxKbJC3e7kKegqCz4fz8pGtOGX3dWNWnv?=
 =?us-ascii?Q?DmEN+xtZhF5Uo9VdO+WiNTCxea/LYFws0IvtcEJBpUcDP0cPtjOkP8y996fJ?=
 =?us-ascii?Q?rSE+tz6dEA2RZYI9BLrSN/THmqZngfj6enJtKMdQ5ogW5kOzjEe0z2jRaWkh?=
 =?us-ascii?Q?KHm1qO8cfHng+zRmr3zX+kWF2lg5Awdlb9nt/oObUBQm/rsTRDxsb5g7Y+Ut?=
 =?us-ascii?Q?guRLr7/LJ1UIwVTZcy4A/O9WaOK6TzfFLw8TBNu5mXL9OFDG5GA87Hyx4W7k?=
 =?us-ascii?Q?nlJ/FBIEUnkMwwzIHNeIzYGbEjgXO9WIcEt+8PnSx/HviAyxhnfyPyGh970T?=
 =?us-ascii?Q?DDudQHFoEPU47nF+Xsm3oeS4hFQ6jOVq7yeZ/8rO346j1j5HMhqaZh3y97+S?=
 =?us-ascii?Q?eqLToGp1NxcuTIrhoiGpZ6BvN+KYnE3tcIxJjstJGiIRNFstyZvPpt1IY8Q+?=
 =?us-ascii?Q?CX27MtmMM1dSdk+qabWtmWDrHiJlksy3ILWfx+2xZ+RsOsISqg4ou6cWYKv8?=
 =?us-ascii?Q?AJlTtirWayMvZE5WLcbDgRdkNl5Izg5arqoA9A4kQl2UIjR0ULox1m/yFkVD?=
 =?us-ascii?Q?e8S1JA88TxUbxwpnj+mbhRRQVVQNC69bBc8ZLu/Nh3PN4Nr1rtUpgrWMbwPA?=
 =?us-ascii?Q?tg1+a5HSNIEC0z5cMZj8QticH6VF/QhGMuecAjQelp2XLtPoPvhBUcrZKx+X?=
 =?us-ascii?Q?EzUyXW4aJSKuMEr5yIlybBSYXYtDf98LA5iOuteg8HVKadEKfrK42uxJEr1P?=
 =?us-ascii?Q?DgwqJUJixX14mOmx3bCo8AYxe6BsFFm9Sxe0X0rPgXg6JMy9/qLx/D5OrTkZ?=
 =?us-ascii?Q?Ndf+N9pTxFr0z4/zhJp1P3xwrqmnZLuGdq2QuPwhlUN/brTqNC6AWXpiZMey?=
 =?us-ascii?Q?53sqDf/ZivcBxV2tPq6dMOadsffABJMozVyqEv4ZWS4J8SfTVuoIiFfzZzcK?=
 =?us-ascii?Q?LMieStDmrBvk19Jlf9DBiZE7SBP00hYcyYyMpjY26hYYKP72Tb4hxPP0km3H?=
 =?us-ascii?Q?W1x/zQ9tdKjkzgLqmmfdkPrg7WzJZ65DpDqom2XJlrfuCx8FYEzaDnbQmnNX?=
 =?us-ascii?Q?fUDArPHnc3REoWcIlQ+2gfuI6D+D/e+c3E945dmA914EtiYpTDmVMb6sqP6s?=
 =?us-ascii?Q?V4df6UF7t2NHpVkVHGQWwga50L7mO/fdB481H6tXv/kb1phA0frEA+ntTo2d?=
 =?us-ascii?Q?hdHzZOnuHHDprhVy+Z0A/qxPi7sQDBwoeG85hb4LMrQhYQz+7BD96AWKhrv+?=
 =?us-ascii?Q?5ZEB0jpP3skaXNi+C1ChG9gcYCJVPwAnmhAX85HNT30Fb+mOl8tHHMtc2JrO?=
 =?us-ascii?Q?AZeaOD7GftETgwXYEUoYZvK0o8Kv91BtcO0cD/D5vORigLgdI8b5V5OD3h9W?=
 =?us-ascii?Q?Vs/3T+Ig9f+qGFFjylrWtY6++y1MTlxs2yuFN9zrfzTibnYFHySsAz6zTo6A?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b459544-9160-4964-1da0-08de0254c2c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 08:13:40.2609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnODCYmtxv8lk+d3CmNCjecB5Sx6aDoI7/tU6yudQ6ls01sNvsoup14mV+ZbYp0jzQ5TyzY2zYSuv9jsflj6wTe7/jZG3Gj5lLdQHf5stuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF248AC5624
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

On Thu, Oct 02, 2025 at 06:42:57PM +0100, Bruce Richardson wrote:
> The ultimate of this patchset is to make it easier to run on systems
> with large numbers of cores, by simplifying the process of using core
> numbers >RTE_MAX_LCORE. The new EAL arg ``-remap-lcore-ids``, also
> shortened to ``-R``, is added to DPDK to support this.
> 
CI is complaining that it can't apply this. V9 upcoming rebased on latest
main.
