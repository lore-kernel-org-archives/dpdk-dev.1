Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89253E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECE524064C;
	Wed, 18 Feb 2026 11:03:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C836E4042E;
 Wed, 18 Feb 2026 11:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771409028; x=1802945028;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WZd7k4D/FMq2FNmGW/1HY1RCcTFn5rnkA7Uc4G4y/qU=;
 b=TYLfZVzeSyRqyn5yQcyd+M2ulk+n+o7r1DItUsVwfl2yQMFGpaj9OwlX
 bl5Rd8IA24SNu8/og5N37S+Bfqg9eNanHrDMhup2GKDlseiyyq8Rfd+Th
 zKe9+s8I3MOcBIqiyTDze2yzKV8WZ6JoW9QOQPKk5XGRzWiXUgQbPHDEi
 hoMASJTj3JEgZdRZIw4QTS7e6jCATXWroxiiY0y+f1t8I6ToK6OmlAX9a
 uxMxAgituuSZYQIlB4CO97z8Ofpewm/FloRcsvel2imn1jAz0TtpagEZ0
 n4eR//CjrEmHzE6tJCQ6Aqw5qA2+/zAu0V7Tt29ItLl+aq2/ewG/PSXIH g==;
X-CSE-ConnectionGUID: qhGLNrB1S4KOMh3FhsNebw==
X-CSE-MsgGUID: MynZTRuXSE+IIBTcrw/sSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="76320759"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="76320759"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:03:46 -0800
X-CSE-ConnectionGUID: EiN0aRezTkOQnygrZPeqkA==
X-CSE-MsgGUID: fKEyJkz5S3aE921tmI6fNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="213356699"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:03:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:03:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:03:46 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:03:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omJGmaPrwvIpyXsvseF9YxKGE/u/lDju8GQCN8LlZKNK/u30mnnn4LgckDx72xmTxmTlB2dXyh1vC21b/VCeKtn/NL8SacmqG8FmSl1STBI3+Uw2p/GxpyknAt5hpt5i4xtNSOpTvBw3pjFUsKSU+z/iI6BVCSDQ9P9bKTOSkGbyvpoy18/Zb6Rl+CvVfpvEUduC0vK90PfH9x+5/PI5OIYXzzbr0hVRHMlcN5Y8XWqColqpD0Fn1GVxvAiATNhCEbSZyVoMZ/g/dTrj+pYZ17FSCm39I0J0tR2JLrkQd8k+w5Tg9xgvbOTZdy1qxVAEWbOiVznY+S5YiFGD2FQnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx7r9RsCEG0ZxfR4cNOgyp7uWGBd0rxGxLpP5//A04s=;
 b=pcYDASAC+7DEXz+E6uo8oAdDZLt7GT+HgaapCtSEGJqrefO5HiecSEN9QUi9nnbKMuoaAbMhsU63/aAnkedRQ6xOYnOupeZ+wT41hBr6OkmU2zCbh05zlmglXa99Q3SknQiqhZzJGdu/sbFAAbcZzbnVHJu7wVZSKIxm1VerWF6TzzwPP3vWvgcNkvsoUeuTSvM5pGyvHCWU+xVhTSmksCpt2hlj3d6EbWtTuTqt0FGdViwHXWzhc7g2g8KVAqIo+GsUSCQvIkCZ+sdnd8oSSYbLH4zj+mSvYXLr5e/i2LW9EQohVVCHWGJ/8628Z5q0aGXRFHJz4z2MfYSC8HIz0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA7PR11MB9542.namprd11.prod.outlook.com (2603:10b6:806:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:03:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:03:44 +0000
Date: Wed, 18 Feb 2026 10:03:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 02/10] net/iavf: permit secondary process Rx path
 selection
Message-ID: <aZWOfF8qFNC845ZT@bricha3-mobl1.ger.corp.intel.com>
References: <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260218094937.1652391-1-ciara.loftus@intel.com>
 <20260218094937.1652391-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260218094937.1652391-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0250.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA7PR11MB9542:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dec842-f05e-4c73-b0ec-08de6ed50055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WrIe52LRmZxLsSX/9cLVTI2Rf06JU1mN55Dvx5AvmPAQI+wiX24YLt60D/gG?=
 =?us-ascii?Q?9HNSpnSOXP7WKNHOh0+gBGFTO/BRFBcRNTPgbHE/4un53QIk9A4DQxzf2WfM?=
 =?us-ascii?Q?G+jCNtyhe4r/Fcb9c2oIng/hBZyg6Tu57HWuXK5PL5Xjj5ZQvf+c1xt7o5xQ?=
 =?us-ascii?Q?i/eBuSXK5foc4J6AD/gcKJXWTd65V42aFAlo7eYKHrS39P3/Oh2CR6awDmIf?=
 =?us-ascii?Q?SzJxuDDPGSoRKS/SIqBTLqfR8y9hjfeIXEDZfTh5nTLpJ7DIS51G6isnX6Uj?=
 =?us-ascii?Q?Lv7LOxALQ0yZ1Y9cjvRBoXQgU5wvfHT37IpzV+Tkfwb035fhP+43r7ngqhs+?=
 =?us-ascii?Q?u1JIHaq0w2ZyaqSMEGdSapKPuKFyhCyteXxvXva6peREhwGsblKh9bVUQJ6l?=
 =?us-ascii?Q?TqTuFluOm4PEhbI1tY8rwoLTOWm9b2NxVq0IAtQeT8K40hiKqagtx64BhkIy?=
 =?us-ascii?Q?BXX/8bbQrpTRlrJFYWft9KuwmjjA8Wj2D/RD2x4lgnfLgxGjD9qAK5z46f4f?=
 =?us-ascii?Q?knPEt9W3T/QvsXetgeKN7PdN8yOWr1MACOoJZ34eWHUshaK1iIIpO2UYaoxH?=
 =?us-ascii?Q?HOhIHWF2bc72pCsWl/sqlgwcR1v6/JfBI50bMyD0PoWE8F2aJ00bbJI1ost/?=
 =?us-ascii?Q?MEcS19kl0Picyll4LLViCxYvfyQjHgXK+AfOVOHcINwJA782/vjJKae+K0D2?=
 =?us-ascii?Q?Oym05Ecd9gRFzESIAk1lvBcMkrb5YVMGizy9S9tpRBTZYEYjWbNMCHJ15KEz?=
 =?us-ascii?Q?sJEfL5f2PVt+YzULPWLiY2ZENtZTbs4Kgw9Njkg253eAK8DwOQwSIn521Lq9?=
 =?us-ascii?Q?HtiJrZRBjiui8Gsd69X4epqSctliVPq3ou4Xrd77M6+X8f2ekdIrCn0fAQZI?=
 =?us-ascii?Q?oCRciYa/JF0tEah6cw4eI6rtwtcALy+mtKL28HGOLGmdxzJgZdML8RBs7Piv?=
 =?us-ascii?Q?n5BZaxS69c1MgzxsFjbFh7dMeGa00ezTLX0S5UQ4ZyaEtOUS+KZh2Y8P+vKq?=
 =?us-ascii?Q?fuy8RTlPD2SEXvvH3GWgDEkynU55WZA33XEPqf3D3ftbugKP0Ys65xFhhOIN?=
 =?us-ascii?Q?qPCJO17izF51t2SZ7yte6DLA0GkHeFdcvRW2bMGlBjBx6Y+Te18A5eUeGArG?=
 =?us-ascii?Q?xEWwN6VpfnRgDuYB16Ze/zxm7NIXJeBMOqZvQxBcNs24N55ZtKYmNWGsclUW?=
 =?us-ascii?Q?3oaPBk6J7l1UTsqIdk7R5KrRaFbMn/X+4DVNkq5b0QWwke4ayPtERd81yWjW?=
 =?us-ascii?Q?n9UGG8mYn5Ek83EbuRTcXQeyvCbOY/Za0tzNoxWzhYPX/QcUblR8sos7DpCK?=
 =?us-ascii?Q?ahh8ijKdauIVSwRkBmPK1UsMzP3gbhJeXsAtXapHOt+Bm7FSXSjkXBD4yD7L?=
 =?us-ascii?Q?EcWZho4E/7CneQwf00XoIIYJUy04GhmunhqT4ZH1Am6V8rZlaCS4bezVRYvh?=
 =?us-ascii?Q?7LOK53rYWA6+mzUE239rB9xq4CZ+dkGT0KewXSwvK46ldpBeFmUNrLwwfJDg?=
 =?us-ascii?Q?F4ciZ1c6IshfYjAMvoepP/1RIz2pyel6QWuvz1UmUDX83WHLxwP7ktNMjLCH?=
 =?us-ascii?Q?+t5MYEAHLaCJSxo6M2c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxr5l23NUval++KpJIwI6oYtfsAN2e3I/kFDs5uHp8T4oSyT+XSbj0jKwKWA?=
 =?us-ascii?Q?OXfXhiRkjnGvXsuC15Jt+SYtHnP7BAwnuRuu/adk9FcxGE62dZNz6DgHBxS1?=
 =?us-ascii?Q?Fovve8rbaTG0IsGstzCKUX9VEfT8kv+359VTpx0B1pETfxGKoP9fBV6Vp1nD?=
 =?us-ascii?Q?VMfkL8Gg6b3U+KV1/aQouQLmq8fTZ2rDjzW1X0dWShMzWppW5fCJ++QV2uUS?=
 =?us-ascii?Q?vYlQwTpP21Fw24X1Rz212wHMRteFwV3nQgggkhqRlOShv6w5q9s4TgjgUIgx?=
 =?us-ascii?Q?s0FLI+H/7kES3WCN9xk+nmqJROeTt04+0Ck4/kZcGt2J+17NlX8txR1ndkLP?=
 =?us-ascii?Q?WcRLIr1nMHSApakyFcskn+diWaJ6ftlPrd3wUFk4YCcgSkuqA8/6JcBIwS5w?=
 =?us-ascii?Q?+IUnBdnO0dlw3APmMPkSiikfBslL+Evv1ZtW/3zRQyVRuT8K7EU6iNu7bn0g?=
 =?us-ascii?Q?cuVmfIkYkJMGCXWQ5SBdF7zU66LLKJUrf/MQgGoTwUBhEkDdWW6jsLS/zyjZ?=
 =?us-ascii?Q?oEVD3g+PhIEMjx3dgOlE0t6nZUnEpCloiFlo1D9mYMNtxWWnYxHPcezd94x6?=
 =?us-ascii?Q?W7SEQBYAfCnNmN4BAcNJToDreGzk2ljvg1yXeoAQOb++ZUIGlmRJ5saDOqeJ?=
 =?us-ascii?Q?dnejcR4KZcDRdRuYMbVLD8fNQ5iv5fBFaUbIrFJRhf6GRy1KL+3yJAf5+hHQ?=
 =?us-ascii?Q?NPl+UQFK5zzpCaAKlVxuRuaZLSZDNWPnRGZx+B3KPKHXHW11imfSCxye7B8A?=
 =?us-ascii?Q?vKRkvLzRSgLoep0Pt3dIgPCl8HDMKMZpyfNlf2+5P++xj7xRU70NuiOyLVz7?=
 =?us-ascii?Q?4fNx31YrEfZUx8B1ZnKVDEf4+KK77xhs7t8H63U2xu5WIgDTnUtrbU6Yf9db?=
 =?us-ascii?Q?edFETZjmhG8SMYt9qgifVcA4wnW3B51j1BZwv3QhE9Sns7Hvke2vI98VndD5?=
 =?us-ascii?Q?wTZO07uZE9FQE2PU8xrUEMJK/8BZqcK/+f9XI8qmT0hthzvR5hbi91f1qDU7?=
 =?us-ascii?Q?Qho3RQz6bqzmwUyCLsGyWPA3r9e3a7c7PwZ8tyCZ53jNOZg5HZGpV6nTYYKc?=
 =?us-ascii?Q?MJ12tRBEVUPMuH29cdcE330CFHyZwnFPGeOP1/7Wat0W/jEDskwRVWhQPJ3o?=
 =?us-ascii?Q?aU2ABbXsDTxNV6h9H7hnvBFHnZ0HiH5CAvMPbtNSsCF9sl13dB0Jr0ELtQyI?=
 =?us-ascii?Q?CrETvTiKurU0a7+r1QRpebAu+EmiGbryr9jvVZo+h9S0Ue5T2DRb30gMJEni?=
 =?us-ascii?Q?oXiOehXiqrlS5ZIKqFz9YpQiF8NkmZTMkrFz06QKnAF3M0uEwKVsViT5KPAZ?=
 =?us-ascii?Q?YzXyBOwIliTWwmLENC7Poql5zkaWL8V0jvgIO9OgYPDjGPwOqNJr00m1L5D6?=
 =?us-ascii?Q?9ny3xe4lX38bpUbD83lEqkW9aXyFfyvbykyYFFKeGEqMB4DoGviZrtqFX/Km?=
 =?us-ascii?Q?Feonp+uVby84XKZWOw/AbL2/BWdHBQNPeadoyiNjVYjnqw6hZvHIoKAH2xno?=
 =?us-ascii?Q?wdcXDVFSPl0wHlcQbvo7M4rHDbVagFtJkBb8MMVT/FVUhJLVKlMKXaCtju18?=
 =?us-ascii?Q?95uA5Da3T28OGFYzsZ2tOInpy3GI/FWgt9BiSvIRjvY7zkYf0U8FCqoEXBpR?=
 =?us-ascii?Q?yCAq4IJaUgxkIY+WDU/5vzg7DaR8KKEpDZzA9rrbHVEOdVK1d8gpz5KxD3Rp?=
 =?us-ascii?Q?C2kpwY6KKyqoOwiLKan0VJv0Q8WCySQsjbknDSU0PiHd+EXv5+U03HXMZPHS?=
 =?us-ascii?Q?n9h5+/E42x3uK1rHf3szHA/CPdjgPsU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dec842-f05e-4c73-b0ec-08de6ed50055
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:03:44.6776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRQHz9SQcisGvyUX5UQEO7ySwwv0mQKlHRXFafhSZkEyagZP1Vr6DAsHihOLpEXuYnKTKEm/j+yBpOwdvnHYKtyHL37alXxFkQb3ec0UtiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9542
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

On Wed, Feb 18, 2026 at 09:49:29AM +0000, Ciara Loftus wrote:
> Commit 3f59c3d97a89 ("net/iavf: use same Rx path across processes")
> changed the way that secondary processes selected their Rx burst
> function. Instead of letting secondary processes select their own
> function, they now used the function selected by the primary process.
> However, the primary process only selects the function at device start,
> so if the primary process hadn't started the device by the time the
> secondary process was selecting its Rx burst function, the secondary
> process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: 3f59c3d97a89 ("net/iavf: use same Rx path across processes")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
