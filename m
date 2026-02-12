Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D9EB48EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 09:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE3784027A;
	Thu, 12 Feb 2026 10:15:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8E96140268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 10:15:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770887717; x=1802423717;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=oR46gh/R7cEmcbZK3LFoUPJEs7sJDtfjiL2/h28ZsTc=;
 b=GaMcRXcuYm1z/uC0BwksF9ySpvOT++npCGbA+dtmAm/X5dCCfxcvDeLc
 XQCoUxRidHTwxw4KBN41fxOEdsQApG2+wIEy6hiTNRZHUjfm1wCm5NqGX
 rdYNgXZn1FO2zPPgjcqJSL/F1HzU0zJSG/zF1pjX0DLikPbQvhdDw+K4L
 8l+VRBF9I4LcbNdgKM5c/+aDT6+8r120picuvJp7XC17FMG4++C+wGfgw
 YFJaK26ZEWo5fr9bjRdolWDWqoshDGqZ31HwagNQ3yqabf0/DM2x+pnkE
 WlnbSmMHJbqRculnuYghTH41l3P8AEYQtCmpm8xXtwFRutBVS8dvpqJPR Q==;
X-CSE-ConnectionGUID: 5r3/VZJ4THiAK9PdtxP23Q==
X-CSE-MsgGUID: FqQzkD5PTTayg03gQnkulg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="89462743"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="89462743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 01:15:16 -0800
X-CSE-ConnectionGUID: qSCJXj00SUiS+kT7c27KYQ==
X-CSE-MsgGUID: 31VkrhqXTPOBzU84GdiTDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="216760476"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 01:15:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 01:15:14 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 01:15:14 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 01:15:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8YmeAOswiRLnDMZNkIp0C7MC7eekgEdYWrRrz2PwdZLlcK+m2/6AuRTLha6T9LSKAbrm5qoiiATP0MRaQri8buhdMgPbM1cqduRlP/HJc2ZwcWc4KvGs1EaA/iwQYOlQlKEyc8AuzVpfJ9oIC68lbvJL8V/1hc9rifLhinJkraEksoNVHYSn3J/fAGrwYofKtF63mXUa5u5m57VWjalIDU+UxTaEbv6cCD4TpWoinL9rDHyPPgQC6J96tszIBPM1X/szia3kxAwLUPDMFMqNLKIN9jz2Plqp+kLHTZQL2UZjUn9dclNeXR8YpPmtwpXOSbGPSrIlPPP5QUb6Q2rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mH3i2RT/Uz77UQ/s3lArlL9kI3CA8HTAa6m89I+8/Q=;
 b=JSTPExalklLqlk4Pt70RGt2Ny/JI7V2nyLaIblMr0xrxcSNuaIa9pPPHWLFwHKBorkYpR5Ua75I0OZqkcW1+WMl9itWmD3/npTKs4BZvNpZBL4nmJkcecl/ATNK08bZfd/wG6okXAbUpFU+OUIwc/76OPi6MaGZDIRRjhFFBYj5CWFwOfH1B2lbl5ZICiRtJ5lauJEtClvc/Wxkv+ITlcK321Vbe312zSAE/Plm4F1fNOeto4KIaJHUnJ1gpS0Zr+P6IiaiNxDQxJTNt4wNmtb8uRHnTw4Bl1DQgf9WRLxqKHEDZXRX9WAnwG/o318MaXP5UCjxI3x4p1qJPCI6MoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA0PR11MB4622.namprd11.prod.outlook.com (2603:10b6:806:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 09:15:06 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 09:15:06 +0000
Date: Thu, 12 Feb 2026 09:15:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Praveen
 Shetty" <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: Re: [PATCH v5 23/35] net/intel: use separate array for desc status
 tracking
Message-ID: <aY2aFd52IkCRO2x6@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-24-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65711@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65711@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA0PR11MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 41945ba1-b215-47b2-bafe-08de6a173687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qQtQOi7lno3tN/V8KJGlHf69LLz4GpbsIxXo0lIkX22Ojm/0pspoqVHYzx?=
 =?iso-8859-1?Q?wO1f+VGZFAsMbJ22gK2mNwSd3mdQ3lPSinjkRRH9ZDC95c2XWYvApvviwF?=
 =?iso-8859-1?Q?XGWFiDljjXrb9eoL0YQOd7vw47Y2gJ451WNXGqyOg2Fy6NhnfLUpngvePc?=
 =?iso-8859-1?Q?LmrPtC28F8l1nqPiGQHL2+q3T/5FIeUHYqnPBHWBAtZd+fn7Bf/04YKwJm?=
 =?iso-8859-1?Q?HdhrQL7tqUzyNQ4R76cdK/MWyu3a64hrcPgqEPS8bb48u53V6hGbxmPC5V?=
 =?iso-8859-1?Q?tvP/wawAO7a4RQf863xfwFSuLUtoET/7XojjuYF7FUkQvXyg5JW32KpjlR?=
 =?iso-8859-1?Q?TAm7yXpBT/HYnocHbkufoYPi1hTTRuaXgsSfTjwoK3ew5NFaub1GVn4g8W?=
 =?iso-8859-1?Q?IeEkg+H/XhKU1+dkLmzTx/39QV6sBrBEfHhwGrSsfgiDaN7s/s2DLhdP8y?=
 =?iso-8859-1?Q?OY1fymwQBqmWy1eu1bBsJbXYjRlRYrbl/VfyKR9yjx1a0sVsFDxTT3SB1B?=
 =?iso-8859-1?Q?1SNJEWAeVladLQYJhm5J5QOlAsnrwqK0bU6WqcowOOaR/efZ5GtBooUI3I?=
 =?iso-8859-1?Q?nGUL763ELYybgSrJmaQVW/MpBhAyWLtEXP7WK/iJuAGLhUfoZLwK/n+Ac0?=
 =?iso-8859-1?Q?z0EE9twBv8kX0C582lLjdrD0VWTqrPTlmOniLfLUsssjrcrFuRgcNfrCD7?=
 =?iso-8859-1?Q?lX4k4feIaKzapvQPbLJ+Ky5bQSgnZ79oTCGLqkQO46Z2VYDjIwuZ97uVmf?=
 =?iso-8859-1?Q?yuRVVFjb1zclE4gE6sBTc9KjdN/YnO2b9rofaInofiFo7rLDIKF/4u3Spu?=
 =?iso-8859-1?Q?D6x+n4uqbgRnbzB2GAbBv7ZR62aXvW3Oeo9JLAhlTe5kGYjJDEugyj4LSE?=
 =?iso-8859-1?Q?rQnqE6IXo8xtP937MlVi2Ax0mbZPg4oNkl2z2dmJ8OM5CWW4Tn6rvQ+rFx?=
 =?iso-8859-1?Q?TWYoW1ZepVN0BQBV8uco2/rFeFGlcXGDiEkcLSmEVVhxo/L2OATjiEJ1Al?=
 =?iso-8859-1?Q?t2TOmBegJ02qosOXVRi9EeDuN2SGWIqI21MTnKOqn/Hqk9isPnVNbhG/jY?=
 =?iso-8859-1?Q?+QXgr/eQs5j+7H5u8+5G9c8+OKbHATQ/3pvIXDYei+moa+6VkXyfAz+JSn?=
 =?iso-8859-1?Q?20yn71AO3TxN8KPXdJTjr2vO6/DMMD1BY0jGX9Azavhdv8/iGCONFECYuV?=
 =?iso-8859-1?Q?0HVXjpBLboHpZEusZA64DEgTbK1T/iChFTEJ5s9XeWtFhA+kDIGeRwIBWf?=
 =?iso-8859-1?Q?MjB3iZT/IyjegWnj3lO/ROZ/hBpJt5G3s0o5tHUqQUoCASAVIczzPaTSUa?=
 =?iso-8859-1?Q?DFLhyxtD0ClyXkW0ndWoB1ekDtBfI3JQ+7zV33iBYxWf57MHrCEz1Enb3m?=
 =?iso-8859-1?Q?zW7dQ3rLelOyEdkwKEPMKUAVFU5xGwqrGW/9PW6PcmaHcn6krRpieJ7PNX?=
 =?iso-8859-1?Q?ws8ymJ6dOdR/6ZhyR24KwTmEDIhRg20AJ8YmKsN9WwjXEh9RYvDV7h2L+a?=
 =?iso-8859-1?Q?adDTcXruu/cmG8Ie4mFxLfTH0N9BMoaaYHMfFRKrHClsutbQIRPs91AC5y?=
 =?iso-8859-1?Q?tiRIEskeTI5YkH1lG7BbSTWjImvVqnwu2NxwldPrHhAhkV65bjsUV+uX74?=
 =?iso-8859-1?Q?wqooHTJe9ZiFI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5p/8tRY4JJV8RSR0btZhlzu3HVcCi++AZ1hvyI2fqIUlkSXEqm+3Boq5v8?=
 =?iso-8859-1?Q?lBeyAeFdCY9UsUu/GBwv8+w6lGQ8lERzQ1by+Qk8Y5WHkwidzBylJ7WH4K?=
 =?iso-8859-1?Q?a5IjUfBktXcJBDPFK5XHQkKGUrBbL1Yrn7y8DEpt33+fKfR8YDc8sixNk8?=
 =?iso-8859-1?Q?WanPOT0VY3PUV7QFvAXxsTFjQZOjplMrgmdV/oRDha7ni2OwrYd0OsYKGT?=
 =?iso-8859-1?Q?FaJ4LHy3RCuZPxXPNYQWrtTrSI+c6g23stCz9FdSbs7DUKwpLPkIjDXrgr?=
 =?iso-8859-1?Q?OuaY+Tag9Utfj+dUWdJtogcb4XwYc0SRdjdj8TmA99DQngVdmjLl49M925?=
 =?iso-8859-1?Q?0A1J6481CoWrauf1kAGyVXdnr8/vgct9nhXouhvudkJf5D8oMwIymYwLnX?=
 =?iso-8859-1?Q?PnQNb8brjhHWrbWLLZhsnDQEA0rcZTXcHOtDh3xaJW4237Z949R/ml4jzV?=
 =?iso-8859-1?Q?U/YCGoEqwJ+viEwjSkgy7G9p6GE8BtULXQQKfidy2bg/8/x+ZzHLTy7up6?=
 =?iso-8859-1?Q?thSHWDrU+TI1rPVyQoivX7pcKs8h2G2/RPtqtsieZIFym2uiNhmU12UmZ6?=
 =?iso-8859-1?Q?CBynBPh+cnUKKsvnO5m+5UPvXwc7cQ2UHFXELZP+JnzDrmWuA7MPUNc765?=
 =?iso-8859-1?Q?EJ/1vAV2H67xbik7EooWPI+c4s238EX1cB/DhudhBsHpSpxTZcAuRCscb2?=
 =?iso-8859-1?Q?jf3ZHr2rIwSj91bovsKVLhHXDLdxWTVtRsbJUn01JfUyaGtqLDvCLmfGWS?=
 =?iso-8859-1?Q?ubHhelmj65sQnSZGNBoLbkQ/sFuBt+aKQdwsIv1tBbiA/LsbMHFCCVJFCv?=
 =?iso-8859-1?Q?2MSwTsR/iAze2TJMdiW/hZ9Ee6lUMnl6elUnpAHfThDlsPDOIHiQqX6fwb?=
 =?iso-8859-1?Q?HHVMvVsySdb1Cd+ov32jauxFu4D67TnUbMsskQfn2u9VWvP4kvNXnHKmvM?=
 =?iso-8859-1?Q?Tp0ZlaF9vgHk2OJuCQgt0Zu2H4F0r6+sQ0JoGCj8mwFMd2RodVipv9q4oc?=
 =?iso-8859-1?Q?kujT2b3cNrg56J8NUoic/TyVWhRH5DaON6q8KtOt9mKv3Vm9aMfWgHVz/g?=
 =?iso-8859-1?Q?bgZomZEV8Hi8PxDzAliLEDKdmzDScIeeL/2nrFwXvzdhxjoVSuryqOXKNy?=
 =?iso-8859-1?Q?3yfyzJOYFJ1hcYwjeJbkYj4MVPSZc1DoNnSxbc0xQu7DO+uh9eAzVWfgvq?=
 =?iso-8859-1?Q?9/OVGdvxfquwp80VRrfayhto1iEWHwccwVdUrQnO2Rz9NR9kaqKea9bw0C?=
 =?iso-8859-1?Q?iTLlzwyXwcPoQ/pjG92FzR9kXrN0LN0mXjqUXpW/gBE9DwxI/zkkf14lBC?=
 =?iso-8859-1?Q?w3DW883FJHd4ChZlzwDmUoj7lWL11Oowy5zNo7vKZL9jctIffpD7ZvmIAt?=
 =?iso-8859-1?Q?W33lsFBc7hLYvQldOMrv4QdNlOaXadlxjNkghx/lCm9EsJ0GCUKeKnURLm?=
 =?iso-8859-1?Q?M6eX4bOLIIKYeq9LPV0a78BQk/OJl+eYP24tUdLlQM3L2+I9ZmlR8m8LcK?=
 =?iso-8859-1?Q?TODdRPT7+I+C8jOyEBBINYB/xfFmpGEc2PY+1FktYUA44YGOLcSEJZ5NB2?=
 =?iso-8859-1?Q?OEN+JwKD6AIP01QBszEsB5QI4RO32lfS3n5AarUSllCW233sMzTp6nXeJe?=
 =?iso-8859-1?Q?t/ULUlkJmRDLGvt/W1ZRmVfrAC8H2CzOM4+M8w/isKbfdwsWsV03f54ur0?=
 =?iso-8859-1?Q?7kcnb5/2ucfif+Fhtnzdn0Qo1dygv0yc1TD7P/RgXBgjU/HuDZQjQyCpo8?=
 =?iso-8859-1?Q?fh4blpIOxytpJg7Qi7WWsKXllRTI5TffCgSC1JHuWw08HEkTkCz5nMQCCa?=
 =?iso-8859-1?Q?Wz98ZMR9T1G69suzCC4SpiUTih8PorU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41945ba1-b215-47b2-bafe-08de6a173687
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 09:15:06.7129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaaAG+5enReVBHhlmS0X8glxviHODlCnI3jxE2CWcAUQaGjB+6V3nxfUqGD1l4o4t9NX6QWIs5LtwUwMT6THcdzzgeBXK/EcBLh2Jm9RMQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
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

On Wed, Feb 11, 2026 at 10:51:56PM +0100, Morten Brørup wrote:
> > Rather than writing a last_id for each individual descriptor, we can
> > write one only for places where the "report status" (RS) bit is set,
> > i.e. the descriptors which will be written back when done. The method
> > used for marking what descriptors are free is also changed in the
> > process, even if the last descriptor with the "done" bits set is past
> > the expected point, we only track up to the expected point, and leave
> > the rest to be counted as freed next time. This means that we always
> > have the RS/DD bits set at fixed intervals, and we always track free
> > slots in units of the same tx_free_thresh intervals.
> 
> I'm not saying it's good or bad, I'm simply trying to understand the performance tradeoff...
> I'm wondering if spreading fields over two separate arrays is beneficial when considering cache misses.
> 
> This patch introduces a separate array, uint16_t txq->rs_last_id[], which is not in the same cache line as the txe array.
> 
> So now, two separate cache lines must be updated, rs_last_id and txe.
> 
> Previously, only txe needed updating.
> 
> Assuming both rings are cold, how many cache misses would a burst of 32 (single-segment) packets cause...
> Number of cache misses in the txe ring (before this patch, and after)?
> Number of cache misses in the rs_last_id ring (after this patch)?
> 

The main txe ring has 4 elements per cacheline both before and after this
patch. As an aside, 6 bytes of each 16 is wasted, and I have tried a couple of
times to get us down to an 8 byte ring element and each time performance
has dropped, presumably due to extra computation and branching for ring
wraparound when we remove the precomputed next index values.

Anyway, for 32 single-segment packets, we obviously touch 8 cachelines both
before an after this patch in the txe array. In the next_rs array, we
should just read a single index, of 16 bytes, so the overall array has a
fairly small cache footprint, 2 bytes per 32 ring entries. [Or one
cacheline for a 1024-sized ring]

However, the performance improvements given by the rework of the cleanup
handling are very noticible and not really to do with memory/cache
footprint so much as doing less work, and less branching. For example:

* before this patch, on transmit we stored the index of the last descriptor
  for each segment of each packet. It was to a hot cacheline, but it was still
  (if no coalescing) potentially 32 stores per burst. After this patch, we
  instead only store the index of the last segment for the packet crossing
  the next multiple of 32 boundary. Going from potentially 32 stores to 1.

* When doing cleanup post transmit, we still have an array lookup to
  determine the location of the NIC write back to indicate descriptor done.
  However, while before this was being done to the txe array - which was
  written (ring_size - 32) packets ago - it's now done by reading the new,
  tiny rs_next_id array which is more likely to be in cache.

* finally, when doing the actual buffer freeing, before we would have an
  arbitrary number of buffers - though normally 32 - to be freed from the
  ring starting at an arbitrary location. After this patch, we always have
  exactly 32 (or more correctly rs_thresh, which must divide evenly into
  ring_size) buffers to be freed starting at an index which is a multiple of
  32, and which therefore, most importantly, guarantees that we do not have
  any wraparound as part of the buffer free process. This means no branches
  for idx >= ring_size etc., and that we are free to treat the buffers to
  be freed as being stored in a linear array.

> 
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h             |  4 ++
> >  drivers/net/intel/common/tx_scalar.h      | 66 +++++++++++------------
> >  drivers/net/intel/cpfl/cpfl_rxtx.c        | 16 ++++++
> >  drivers/net/intel/i40e/i40e_rxtx.c        | 20 +++++++
> >  drivers/net/intel/iavf/iavf_rxtx.c        | 19 +++++++
> >  drivers/net/intel/ice/ice_rxtx.c          | 20 +++++++
> >  drivers/net/intel/idpf/idpf_common_rxtx.c |  7 +++
> >  drivers/net/intel/idpf/idpf_rxtx.c        | 12 +++++
> >  8 files changed, 130 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h
> > b/drivers/net/intel/common/tx.h
> > index 5da6c7c15d..acd362dca3 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -134,6 +134,8 @@ struct ci_tx_queue {
> >  		struct ci_tx_entry *sw_ring; /* virtual address of SW ring
> > */
> >  		struct ci_tx_entry_vec *sw_ring_vec;
> >  	};
> > +	/* Scalar TX path: Array tracking last_id at each RS threshold
> > boundary */
> > +	uint16_t *rs_last_id;
> >  	uint16_t nb_tx_desc;           /* number of TX descriptors */
> >  	uint16_t tx_tail; /* current value of tail register */
> >  	uint16_t nb_tx_used; /* number of TX desc used since RS bit set
> > */
> > @@ -147,6 +149,8 @@ struct ci_tx_queue {
> >  	uint16_t tx_free_thresh;
> >  	/* Number of TX descriptors to use before RS bit is set. */
> >  	uint16_t tx_rs_thresh;
> > +	/* Scalar TX path: log2 of tx_rs_thresh for efficient bit
> > operations */
> > +	uint8_t log2_rs_thresh;
> >  	uint16_t port_id;  /* Device port identifier. */
> >  	uint16_t queue_id; /* TX queue index. */
> >  	uint16_t reg_idx;
> > diff --git a/drivers/net/intel/common/tx_scalar.h
> > b/drivers/net/intel/common/tx_scalar.h
> > index 0bc2956dcf..7499e5ed20 100644
> > --- a/drivers/net/intel/common/tx_scalar.h
> > +++ b/drivers/net/intel/common/tx_scalar.h
> > @@ -22,33 +22,25 @@
> >  static __rte_always_inline int
> >  ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> >  {
> > -	struct ci_tx_entry *sw_ring = txq->sw_ring;
> >  	volatile struct ci_tx_desc *txd = txq->ci_tx_ring;
> > -	uint16_t last_desc_cleaned = txq->last_desc_cleaned;
> > -	uint16_t nb_tx_desc = txq->nb_tx_desc;
> > -	uint16_t desc_to_clean_to;
> > -	uint16_t nb_tx_to_clean;
> > -
> > -	/* Determine the last descriptor needing to be cleaned */
> > -	desc_to_clean_to = (uint16_t)(last_desc_cleaned + txq-
> > >tx_rs_thresh);
> > -	if (desc_to_clean_to >= nb_tx_desc)
> > -		desc_to_clean_to = (uint16_t)(desc_to_clean_to -
> > nb_tx_desc);
> > -
> > -	/* Check if descriptor is done */
> > -	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
> > -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> > rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > -			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> > +	const uint16_t last_desc_cleaned = txq->last_desc_cleaned;
> > +	const uint16_t nb_tx_desc = txq->nb_tx_desc;
> > +
> > +	/* Calculate where the next descriptor write-back will occur */
> > +	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
> > +			0 :
> > +			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> > +	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) +
> > (txq->tx_rs_thresh - 1);
> > +
> > +	/* Check if descriptor is done  */
> > +	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> > +			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > +				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> >  		return -1;
> > 
> > -	/* Figure out how many descriptors will be cleaned */
> > -	if (last_desc_cleaned > desc_to_clean_to)
> > -		nb_tx_to_clean = (uint16_t)((nb_tx_desc -
> > last_desc_cleaned) + desc_to_clean_to);
> > -	else
> > -		nb_tx_to_clean = (uint16_t)(desc_to_clean_to -
> > last_desc_cleaned);
> > -
> >  	/* Update the txq to reflect the last descriptor that was cleaned
> > */
> >  	txq->last_desc_cleaned = desc_to_clean_to;
> > -	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> > +	txq->nb_tx_free += txq->tx_rs_thresh;
> > 
> >  	return 0;
> >  }
> > @@ -219,6 +211,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  		uint16_t nb_ipsec = 0;
> >  		uint64_t ipsec_qw0 = 0, ipsec_qw1 = 0;
> >  		uint64_t cd_qw0 = 0, cd_qw1 = 0;
> > +		uint16_t pkt_rs_idx;
> >  		tx_pkt = *tx_pkts++;
> > 
> >  		ol_flags = tx_pkt->ol_flags;
> > @@ -262,6 +255,9 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  		if (tx_last >= txq->nb_tx_desc)
> >  			tx_last = (uint16_t)(tx_last - txq->nb_tx_desc);
> > 
> > +		/* Track the RS threshold bucket at packet start */
> > +		pkt_rs_idx = (uint16_t)(tx_id >> txq->log2_rs_thresh);
> > +
> >  		if (nb_used > txq->nb_tx_free) {
> >  			if (ci_tx_xmit_cleanup(txq) != 0) {
> >  				if (nb_tx == 0)
> > @@ -302,10 +298,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> > 
> >  			if (txe->mbuf)
> >  				rte_pktmbuf_free_seg(txe->mbuf);
> > -			*txe = (struct ci_tx_entry){
> > -				.mbuf = tx_pkt, .last_id = tx_last, .next_id =
> > tx_id
> > -			};
> > -
> > +			txe->mbuf = tx_pkt;
> >  			/* Setup TX Descriptor */
> >  			td_cmd |= CI_TX_DESC_CMD_EOP;
> >  			const uint64_t cmd_type_offset_bsz =
> > CI_TX_DESC_DTYPE_DATA |
> > @@ -332,7 +325,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> > 
> >  			write_txd(ctx_txd, cd_qw0, cd_qw1);
> > 
> > -			txe->last_id = tx_last;
> >  			tx_id = txe->next_id;
> >  			txe = txn;
> >  		}
> > @@ -351,7 +343,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  			ipsec_txd[0] = ipsec_qw0;
> >  			ipsec_txd[1] = ipsec_qw1;
> > 
> > -			txe->last_id = tx_last;
> >  			tx_id = txe->next_id;
> >  			txe = txn;
> >  		}
> > @@ -387,7 +378,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  				buf_dma_addr += CI_MAX_DATA_PER_TXD;
> >  				slen -= CI_MAX_DATA_PER_TXD;
> > 
> > -				txe->last_id = tx_last;
> >  				tx_id = txe->next_id;
> >  				txe = txn;
> >  				txd = &ci_tx_ring[tx_id];
> > @@ -405,7 +395,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
> >  			write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
> > 
> > -			txe->last_id = tx_last;
> >  			tx_id = txe->next_id;
> >  			txe = txn;
> >  			m_seg = m_seg->next;
> > @@ -414,13 +403,22 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
> >  		txq->nb_tx_used = (uint16_t)(txq->nb_tx_used + nb_used);
> >  		txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_used);
> > 
> > -		/* set RS bit on the last descriptor of one packet */
> > -		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
> > +		/* Check if packet crosses into a new RS threshold bucket.
> > +		 * The RS bit is set on the last descriptor when we move
> > from one bucket to another.
> > +		 * For example, with tx_rs_thresh=32 and a 5-descriptor
> > packet using slots 30-34:
> > +		 *   - pkt_rs_idx = 30 >> 5 = 0 (started in bucket 0)
> > +		 *   - tx_last = 34, so 35 >> 5 = 1 (next packet is in
> > bucket 1)
> > +		 *   - Since 0 != 1, set RS bit on descriptor 34, and
> > record rs_last_id[0] = 34
> > +		 */
> > +		uint16_t next_rs_idx = ((tx_last + 1) >> txq-
> > >log2_rs_thresh);
> > +
> > +		if (next_rs_idx != pkt_rs_idx) {
> > +			/* Packet crossed into a new bucket - set RS bit on
> > last descriptor */
> >  			txd->cmd_type_offset_bsz |=
> >  					rte_cpu_to_le_64(CI_TX_DESC_CMD_RS <<
> > CI_TXD_QW1_CMD_S);
> > 
> > -			/* Update txq RS bit counters */
> > -			txq->nb_tx_used = 0;
> > +			/* Record the last descriptor ID for the bucket we're
> > leaving */
> > +			txq->rs_last_id[pkt_rs_idx] = tx_last;
> >  		}
> > 
> >  		if (ts_fns != NULL)
> > diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c
> > b/drivers/net/intel/cpfl/cpfl_rxtx.c
> > index a4d15b7f9c..e7a98ed4f6 100644
> > --- a/drivers/net/intel/cpfl/cpfl_rxtx.c
> > +++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
> > @@ -5,6 +5,7 @@
> >  #include <ethdev_driver.h>
> >  #include <rte_net.h>
> >  #include <rte_vect.h>
> > +#include <rte_bitops.h>
> > 
> >  #include "cpfl_ethdev.h"
> >  #include "cpfl_rxtx.h"
> > @@ -330,6 +331,7 @@ cpfl_tx_queue_release(void *txq)
> > 
> >  	ci_txq_release_all_mbufs(q, q->vector_tx);
> >  	rte_free(q->sw_ring);
> > +	rte_free(q->rs_last_id);
> >  	rte_memzone_free(q->mz);
> >  	rte_free(cpfl_txq);
> >  }
> > @@ -572,6 +574,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev,
> > uint16_t queue_idx,
> > 
> >  	txq->nb_tx_desc = nb_desc;
> >  	txq->tx_rs_thresh = tx_rs_thresh;
> > +	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
> >  	txq->tx_free_thresh = tx_free_thresh;
> >  	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
> >  	txq->port_id = dev->data->port_id;
> > @@ -605,6 +608,17 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev,
> > uint16_t queue_idx,
> >  		goto err_sw_ring_alloc;
> >  	}
> > 
> > +	/* Allocate RS last_id tracking array */
> > +	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
> > +	txq->rs_last_id = rte_zmalloc_socket("cpfl tx rs_last_id",
> > +			sizeof(txq->rs_last_id[0]) * num_rs_buckets,
> > +			RTE_CACHE_LINE_SIZE, socket_id);
> > +	if (txq->rs_last_id == NULL) {
> > +		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id
> > array");
> > +		ret = -ENOMEM;
> > +		goto err_rs_last_id_alloc;
> > +	}
> > +
> >  	if (!is_splitq) {
> >  		txq->ci_tx_ring = mz->addr;
> >  		idpf_qc_single_tx_queue_reset(txq);
> > @@ -628,6 +642,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev,
> > uint16_t queue_idx,
> >  	return 0;
> > 
> >  err_complq_setup:
> > +	rte_free(txq->rs_last_id);
> > +err_rs_last_id_alloc:
> >  	rte_free(txq->sw_ring);
> >  err_sw_ring_alloc:
> >  	cpfl_dma_zone_release(mz);
> > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> > b/drivers/net/intel/i40e/i40e_rxtx.c
> > index dfd2213020..b554bc6c31 100644
> > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > @@ -24,6 +24,7 @@
> >  #include <rte_ip.h>
> >  #include <rte_net.h>
> >  #include <rte_vect.h>
> > +#include <rte_bitops.h>
> > 
> >  #include "i40e_logs.h"
> >  #include "base/i40e_prototype.h"
> > @@ -2280,6 +2281,13 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
> >  			     (int)queue_idx);
> >  		return I40E_ERR_PARAM;
> >  	}
> > +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> > +		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2.
> > (tx_rs_thresh=%u port=%d queue=%d)",
> > +			     (unsigned int)tx_rs_thresh,
> > +			     (int)dev->data->port_id,
> > +			     (int)queue_idx);
> > +		return I40E_ERR_PARAM;
> > +	}
> >  	if ((tx_rs_thresh > 1) && (tx_conf->tx_thresh.wthresh != 0)) {
> >  		PMD_INIT_LOG(ERR, "TX WTHRESH must be set to 0 if "
> >  			     "tx_rs_thresh is greater than 1. "
> > @@ -2321,6 +2329,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
> >  	txq->mz = tz;
> >  	txq->nb_tx_desc = nb_desc;
> >  	txq->tx_rs_thresh = tx_rs_thresh;
> > +	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
> >  	txq->tx_free_thresh = tx_free_thresh;
> >  	txq->queue_id = queue_idx;
> >  	txq->reg_idx = reg_idx;
> > @@ -2346,6 +2355,16 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
> >  		return -ENOMEM;
> >  	}
> > 
> > +	/* Allocate RS last_id tracking array */
> > +	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
> > +	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq-
> > >rs_last_id[0]) * num_rs_buckets,
> > +			RTE_CACHE_LINE_SIZE, socket_id);
> > +	if (txq->rs_last_id == NULL) {
> > +		i40e_tx_queue_release(txq);
> > +		PMD_DRV_LOG(ERR, "Failed to allocate memory for RS last_id
> > array");
> > +		return -ENOMEM;
> > +	}
> > +
> >  	i40e_reset_tx_queue(txq);
> >  	txq->q_set = TRUE;
> > 
> > @@ -2391,6 +2410,7 @@ i40e_tx_queue_release(void *txq)
> > 
> >  	ci_txq_release_all_mbufs(q, false);
> >  	rte_free(q->sw_ring);
> > +	rte_free(q->rs_last_id);
> >  	rte_memzone_free(q->mz);
> >  	rte_free(q);
> >  }
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> > b/drivers/net/intel/iavf/iavf_rxtx.c
> > index 67906841da..d63590d660 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx.c
> > +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> > @@ -25,6 +25,7 @@
> >  #include <rte_ip.h>
> >  #include <rte_net.h>
> >  #include <rte_vect.h>
> > +#include <rte_bitops.h>
> >  #include <rte_vxlan.h>
> >  #include <rte_gtp.h>
> >  #include <rte_geneve.h>
> > @@ -194,6 +195,11 @@ check_tx_thresh(uint16_t nb_desc, uint16_t
> > tx_rs_thresh,
> >  			     tx_rs_thresh, nb_desc);
> >  		return -EINVAL;
> >  	}
> > +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> > +		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2.
> > (tx_rs_thresh=%u)",
> > +			     tx_rs_thresh);
> > +		return -EINVAL;
> > +	}
> > 
> >  	return 0;
> >  }
> > @@ -801,6 +807,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
> > 
> >  	txq->nb_tx_desc = nb_desc;
> >  	txq->tx_rs_thresh = tx_rs_thresh;
> > +	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
> >  	txq->tx_free_thresh = tx_free_thresh;
> >  	txq->queue_id = queue_idx;
> >  	txq->port_id = dev->data->port_id;
> > @@ -826,6 +833,17 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
> >  		return -ENOMEM;
> >  	}
> > 
> > +	/* Allocate RS last_id tracking array */
> > +	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
> > +	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq-
> > >rs_last_id[0]) * num_rs_buckets,
> > +			RTE_CACHE_LINE_SIZE, socket_id);
> > +	if (txq->rs_last_id == NULL) {
> > +		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id
> > array");
> > +		rte_free(txq->sw_ring);
> > +		rte_free(txq);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	/* Allocate TX hardware ring descriptors. */
> >  	ring_size = sizeof(struct ci_tx_desc) * IAVF_MAX_RING_DESC;
> >  	ring_size = RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
> > @@ -1050,6 +1068,7 @@ iavf_dev_tx_queue_release(struct rte_eth_dev
> > *dev, uint16_t qid)
> > 
> >  	ci_txq_release_all_mbufs(q, q->use_ctx);
> >  	rte_free(q->sw_ring);
> > +	rte_free(q->rs_last_id);
> >  	rte_memzone_free(q->mz);
> >  	rte_free(q);
> >  }
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c
> > b/drivers/net/intel/ice/ice_rxtx.c
> > index 111cb5e37f..2915223397 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -5,6 +5,7 @@
> >  #include <ethdev_driver.h>
> >  #include <rte_net.h>
> >  #include <rte_vect.h>
> > +#include <rte_bitops.h>
> > 
> >  #include "ice_rxtx.h"
> >  #include "ice_rxtx_vec_common.h"
> > @@ -1589,6 +1590,13 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
> >  			     (int)queue_idx);
> >  		return -EINVAL;
> >  	}
> > +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> > +		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2.
> > (tx_rs_thresh=%u port=%d queue=%d)",
> > +			     (unsigned int)tx_rs_thresh,
> > +			     (int)dev->data->port_id,
> > +			     (int)queue_idx);
> > +		return -EINVAL;
> > +	}
> >  	if (tx_rs_thresh > 1 && tx_conf->tx_thresh.wthresh != 0) {
> >  		PMD_INIT_LOG(ERR, "TX WTHRESH must be set to 0 if "
> >  			     "tx_rs_thresh is greater than 1. "
> > @@ -1631,6 +1639,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
> >  	txq->mz = tz;
> >  	txq->nb_tx_desc = nb_desc;
> >  	txq->tx_rs_thresh = tx_rs_thresh;
> > +	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
> >  	txq->tx_free_thresh = tx_free_thresh;
> >  	txq->queue_id = queue_idx;
> > 
> > @@ -1657,6 +1666,16 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
> >  		return -ENOMEM;
> >  	}
> > 
> > +	/* Allocate RS last_id tracking array */
> > +	uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
> > +	txq->rs_last_id = rte_zmalloc_socket(NULL, sizeof(txq-
> > >rs_last_id[0]) * num_rs_buckets,
> > +			RTE_CACHE_LINE_SIZE, socket_id);
> > +	if (txq->rs_last_id == NULL) {
> > +		ice_tx_queue_release(txq);
> > +		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id
> > array");
> > +		return -ENOMEM;
> > +	}
> > +
> >  	if (vsi->type == ICE_VSI_PF && (offloads &
> > RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)) {
> >  		if (hw->phy_model != ICE_PHY_E830) {
> >  			ice_tx_queue_release(txq);
> > @@ -1729,6 +1748,7 @@ ice_tx_queue_release(void *txq)
> > 
> >  	ci_txq_release_all_mbufs(q, false);
> >  	rte_free(q->sw_ring);
> > +	rte_free(q->rs_last_id);
> >  	if (q->tsq) {
> >  		rte_memzone_free(q->tsq->ts_mz);
> >  		rte_free(q->tsq);
> > diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c
> > b/drivers/net/intel/idpf/idpf_common_rxtx.c
> > index 77f4099f2b..04db8823eb 100644
> > --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> > +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> > @@ -5,6 +5,7 @@
> >  #include <eal_export.h>
> >  #include <rte_mbuf_dyn.h>
> >  #include <rte_errno.h>
> > +#include <rte_bitops.h>
> > 
> >  #include "idpf_common_rxtx.h"
> >  #include "idpf_common_device.h"
> > @@ -73,6 +74,11 @@ idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t
> > tx_rs_thresh,
> >  			tx_rs_thresh, nb_desc);
> >  		return -EINVAL;
> >  	}
> > +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> > +		DRV_LOG(ERR, "tx_rs_thresh must be a power of 2.
> > (tx_rs_thresh=%u)",
> > +			tx_rs_thresh);
> > +		return -EINVAL;
> > +	}
> > 
> >  	return 0;
> >  }
> > @@ -333,6 +339,7 @@ idpf_qc_tx_queue_release(void *txq)
> >  	}
> > 
> >  	ci_txq_release_all_mbufs(q, false);
> > +	rte_free(q->rs_last_id);
> >  	rte_free(q->sw_ring);
> >  	rte_memzone_free(q->mz);
> >  	rte_free(q);
> > diff --git a/drivers/net/intel/idpf/idpf_rxtx.c
> > b/drivers/net/intel/idpf/idpf_rxtx.c
> > index 7d9c885458..9420200f6d 100644
> > --- a/drivers/net/intel/idpf/idpf_rxtx.c
> > +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> > @@ -447,6 +447,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev,
> > uint16_t queue_idx,
> > 
> >  	txq->nb_tx_desc = nb_desc;
> >  	txq->tx_rs_thresh = tx_rs_thresh;
> > +	txq->log2_rs_thresh = rte_log2_u32(tx_rs_thresh);
> >  	txq->tx_free_thresh = tx_free_thresh;
> >  	txq->queue_id = vport->chunks_info.tx_start_qid + queue_idx;
> >  	txq->port_id = dev->data->port_id;
> > @@ -480,6 +481,15 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev,
> > uint16_t queue_idx,
> >  		goto err_sw_ring_alloc;
> >  	}
> > 
> > +	txq->rs_last_id = rte_zmalloc_socket("idpf tx rs_last_id",
> > +			sizeof(txq->rs_last_id[0]) * (nb_desc >> txq-
> > >log2_rs_thresh),
> > +			RTE_CACHE_LINE_SIZE, socket_id);
> > +	if (txq->rs_last_id == NULL) {
> > +		PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS
> > tracking");
> > +		ret = -ENOMEM;
> > +		goto err_rs_last_id_alloc;
> > +	}
> > +
> >  	if (!is_splitq) {
> >  		txq->ci_tx_ring = mz->addr;
> >  		idpf_qc_single_tx_queue_reset(txq);
> > @@ -502,6 +512,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev,
> > uint16_t queue_idx,
> >  	return 0;
> > 
> >  err_complq_setup:
> > +	rte_free(txq->rs_last_id);
> > +err_rs_last_id_alloc:
> >  	rte_free(txq->sw_ring);
> >  err_sw_ring_alloc:
> >  	idpf_dma_zone_release(mz);
> > --
> > 2.51.0
> 
