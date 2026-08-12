Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F595C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 16:16:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3916440264;
	Wed, 12 Aug 2026 18:16:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 20CD34025F
 for <dev@dpdk.org>; Wed, 12 Aug 2026 18:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786551365; x=1818087365;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=XeMJIuWmKKP2EPVyZasYdtKELZ8KZ2eMHf5j0kM7mBE=;
 b=XIhMnzjRA7oSC6bhvDuUvVG3pUazZKlnZlfd+sw1BncuzonKTXC8402U
 l6WGKGC14yq/8v7URcvtn0L+/O+XEZQgAfyZcP7e0kqzwUNQ+k88l9OaJ
 m0Lf++IWP3X8YKctRcE5sW7blMnu5yLYxX29zhDBYL6N8q8lNSKosU/RE
 A88HdHs4NRWZ/1nirfxuZD3hFzwfCXnk8YNW3TKEI6nWZc4jR+uJddEoK
 3NtlbBbauO5bCm06iF4HCggQaQSGLa3N7yDOIY+jQ300SrUGl5zl1JNqf
 ddf1Ze5EBq5q1mvx2fBfYBhK+q5coz+tWI7ru4N7qadveriooHJ8Ucvqs w==;
X-CSE-ConnectionGUID: rsicpxqpSHKIlc1pkaL/8g==
X-CSE-MsgGUID: kvVW5Tn+RsG13Rpf8T4V+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98625491"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="98625491"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 09:16:04 -0700
X-CSE-ConnectionGUID: /8xuh7qZRPG+0s5TbJ5eUg==
X-CSE-MsgGUID: AD+vJAOZTXC7WlToOe1PgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; d="scan'208";a="263216368"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 09:16:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 09:16:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 09:16:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 09:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkBWKX7QxQhYyppXAlrox0qcUo/XxG1cOICPvwEyJng+ijZcp6IZdzshqk9aSM9cRZid3cs2Bo+cstlcMvfxZ+WLHJOYc9XrKZBhdKPOHJ8VywSskWuFL76aIlpsCxE0z7rjZQrIaz0j61KRnzHaqMxCg/MOGMN9mEtLyrTbz3heO/a+4efcYksIcg844JsPH3zRvl36dD7ApNJLqybFqZev2Xh4Le6UpNO2ejzh3JLddAslMi4mLlB6Vw4nEZWl8epAXdk8rdYcdNRJGmLwDHjKuGFBb8U2EjflqsyBnbcw2ui8QTwqitxPLZjQK8HdxJLEhlwF5adkPFXV60Ej0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvitS+1pcYI0ix7hNcTXnM6Cn4UIsAJRNEd9oJ5wP6g=;
 b=jFKKiv3DyN1S08Rhxy2dZiUN3XRrlHp0AisH6c2w0+VG+3TDMoX6zaHPVHNbtmN6EhiVY5EOvzxYn2ZEQL+/ARhbaWWysvvlFulazp2TS/rmDo/h3qrq7Nd04g0JWEU8d0KlnqwCc1Es45EAEwvuvwe5AnHsfZ1fLr/5hu7FaY75+uER/jZ3SDeW9Oj3dbrTKADuemES8DP9Qa4XZfpZQCrxOXK/rXQ6AU1AaMM99w6DbiO5hOsR9oN/LIiK1i7bWy2jYU/SsanyN7oZYcMH7IXzcLErFFm8hnZ4WSgxvqt+SN665LechfBfoMWURBZWNpzyCnOjwlFXs9uyJxDVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by SJ5PPF8DE294191.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::843) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 16:15:59 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::a6e3:dc11:48e:b2e0%7]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 16:15:59 +0000
Date: Wed, 12 Aug 2026 17:15:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] stack: introduce pile
Message-ID: <anycOPsfQs2cbZLf@bricha3-mobl1.ger.corp.intel.com>
References: <20260812134756.1829613-1-mb@smartsharesystems.com>
 <anyEWVXfFEHBbsAJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F659DB@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F659DB@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::8) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|SJ5PPF8DE294191:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d751064-a16c-4ed9-f422-08def88cfd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2enFrOZrv7jHh6IPZZOhA2pazU5cybapWpHL+LWfar7dnnx0O1wKZMqOn2ApbCUtrZK5LOmCRzbC9pZjDnBAfHHfW4R/TByFm32dcqxlmH0qkDhqLON7OfE2yF1KUSgj4B7xc+5Yos2JJltaQVzllpoS/1LBF7V7LYzYMTe3AAHPycYpFnbu0MelJ1yGYsVAl34qNKxe3NydeIguLhHl1/PRra2U3IbOEAkWfTP+axBVH2VyOod8vCYiqYneVaAEQZloTSFKbXE2MCGOQRNRWLF7e+3Zvnel3MERBJFAOot+Bk1j+17/6RbmoOzxsOE6iQ8gK8fBZ5+NSEEXfMZwpSrDRfd8Rmp4KYBzesTpNvsUviriJ8MIyfmJ5HYsTIIc97K1PO0AhoAWKINhpYtzEAkSQ0tBd7mNhsbBEloQXU0v6X6EUrVQbuBKrv+5/S1ZihFi0GlDrViHaYrtsI+jhQZQHs1iGMopafotFlZvU0NlzmSWJ+sE0iZJ4lLj5F1yPUKmlviQ5Cq9zXD0dIDkJA6/kHxPWQS9/XB2ze8UnSsoiolYBZZ02NVz1ngJQ+QR+Oy6cthFPZ30UfSpk6Cd/wf+3r7MiMxBeBHi4s1f9l5zScHqSIUg6eAQEto0DErS1UxZFjC4jbvc2LrdnDSzygeUS1ZYfkV+U2vX1njzWbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rj8zwCU5PVP3bB3viOslwrT9Hxn5aSjEXQVz0jeG8R8f4u+4pZlj7E6BD3?=
 =?iso-8859-1?Q?u2x5TV6eTDg+r0yhX1lR7b3dbyhAX+CUi9VSFXw2BpS9hc0NpOInrHYUC2?=
 =?iso-8859-1?Q?km3ghjUwZfNAxywdDr9GwgOBrNW81NY21c7nacMitbw5PVDSjLZThdeGyk?=
 =?iso-8859-1?Q?alDmac8vAi89zdEnSffY0Mn4wVGSOmIrVYr40RCaLpWgC/UaXLXD74ltth?=
 =?iso-8859-1?Q?qwaCDe75z7ctthweQVjDMpCcqv2IbNTBu+FFuIulv5r0l5BxinTOsubLYj?=
 =?iso-8859-1?Q?drQgWlUB7DVvKF+2xc27LwP2lNNyCGU4WGRCBVbP6drgjryHyFwFcgQSnM?=
 =?iso-8859-1?Q?60ftyVmlTn5MMq9kKO2tR42LDCH4F9nAdApwDODJPEcnUQnE54ID7wit/1?=
 =?iso-8859-1?Q?+IvHz09Aai96Of29ujsAfnlYnJ/44p6wKyqRumcsUlfLgoE6MFvVhKAz/l?=
 =?iso-8859-1?Q?o1DTD2TWdrCp6nSZsMj7hpZ8QlK+vM8QH9scJYEtMX9QzU2SBG5ZAgR15Z?=
 =?iso-8859-1?Q?66fOwE6cUB66DmGjuHwVq7wP4LqTAaQMl9oECunBkghG38ZooTikRRESaT?=
 =?iso-8859-1?Q?G+Yd4YA1VSlP+UxDz4auX4Kda4pssuLpE0HU20EyM3vBQfpiS/RZpBElJX?=
 =?iso-8859-1?Q?Acv3DZpFG+d/IdV91bmBxzhrDRg6RsUV1OBtUfFdKYIR0JsAqx9AAmwC+R?=
 =?iso-8859-1?Q?CbVtQUhbSI8Dx1cZq9bGCHFTFB9y/mEFeP5GjilLoM+nt91ZrZq9ncTR0g?=
 =?iso-8859-1?Q?D4RWyTDfOITHaeerd56C8guFQhh5y8tHdsOwzp4VxIqznYIOhQkzG5YHel?=
 =?iso-8859-1?Q?Y0PZvE/fmyW4IcVvp9YvHq7pbZN1WdE17RDjlcnXKi7W3SQ/L44gz669lw?=
 =?iso-8859-1?Q?NqEXi47ngKi43hTlcbTJu27ltH8J5C2xVtuhofHp3iPI+mDL7XYpHXlFBV?=
 =?iso-8859-1?Q?tHEDeKZwZ3LG7LREloxoj4eFEkd94wWto00BfVrp40v+I2pE3Qk6zBww19?=
 =?iso-8859-1?Q?bMmTPQ/lENrJ30n9Y39U3+YEW8JoFP/lZiynRxcBa3LZBw8jKjIBXMaHuu?=
 =?iso-8859-1?Q?fHsa3aZBv7rhX1s6pbGcR1CzkgvECPWRzmg4HFbXbnLmehqJWbTdJAT/2X?=
 =?iso-8859-1?Q?+irgCIr5Pcdpqy7tZAtOyCm+7l/2Sez04KpTeYKzMNvRh7kvBtYLU6NIG2?=
 =?iso-8859-1?Q?pURcfoC7xm92scEuaunnmYw/oW1lfxNCyA1HlgLYofnx6IkabqqjQ2t2/o?=
 =?iso-8859-1?Q?0UOtilO2YcGcuVG6Oep8nogMvrLaX3ntciRclkrXxRDlJRSlLngVgpy3EB?=
 =?iso-8859-1?Q?Z0hkv2FkcWqdCOAKFBf6p7s4ml5zj0PPP/k7E3NJa8bFXF3RGPrrKbRM+0?=
 =?iso-8859-1?Q?h0MYeeoKTPc6iX7xuuLuRwHYE1PTmn2r9iwPWqGkSojExpfuPlbCXxhR/e?=
 =?iso-8859-1?Q?D9AqM4onMppmNv+dYNVmy3p6eD/uhjXzc2sGBUbBRFVfFBRwNf28Ko3C54?=
 =?iso-8859-1?Q?vIgTDh8ASuZytmNDOvmeGFRrwrsUWsK3jUthtE1kHFcyf5fLlHOLeCJGmR?=
 =?iso-8859-1?Q?9ISmiy5KE7yaYYvrYwK04D8PtCvG4TQp+oea2tKvmKQ8I5TuLmmMkc3y+W?=
 =?iso-8859-1?Q?LEBpBt2QWeLeXeP9jyh13jqw9rZcbGcHvmiHVf626hjF4KBNHe/HKYvTon?=
 =?iso-8859-1?Q?RIrPXzlegARXU+ah6JESxZbJ708pXN6RSQVm3xBNWiSPZoGIl5AKuCCCf/?=
 =?iso-8859-1?Q?mwv+H5omy7G8L0pyFg8GwGXKFkOTwMRY8tpoZO2l9BJO0obQbMNnCYibyy?=
 =?iso-8859-1?Q?C5Gk3IXd2aQd37D0SdhyIU0m18s4PsM=3D?=
X-Exchange-RoutingPolicyChecked: FAThOHUAjZkoBnC+0edQu0pajDDkEPsDNRmbOp5Z6m5zgbLARMcawYVg3AqUuP7cXK71RYVNRNP9PUSl0TYlSJ/sitVnw2wTcRHhdHaHKTqlV9RDWhDSdh1Mj4AF8Es6IFO46QPPw/sudzjP+VMrKVEYsYN2TUB3ZCQJt25X/wMLIlaGAfZxBeSoZuf+cM1VqHggK0OVMx1pdv5TLRPZB2kgMiBgGPVn7G08RJG55s5dZtftox0qeNZWjOfwygYA8zCGFkejCj7Z5SRUCC+qkG/0quLgG7sKN1Y/WbWvCfdEd4O5pqKGSfDWKnWUPYx/0XSBsS0nJ1/phZzaCpL8AA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d751064-a16c-4ed9-f422-08def88cfd98
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:15:59.0780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIf0tfnkdJSETo+/FFTCDF1h5xP6gDS7z8iT86mx6yhHmh9TaN9la5FBma7XTEss+vbYGigtGhPoLJzcczqG0cgH02bFhL3bt8lWT6hM4M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8DE294191
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

On Wed, Aug 12, 2026 at 06:01:31PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Wednesday, 12 August 2026 16.34
> > 
> > On Wed, Aug 12, 2026 at 01:47:56PM +0000, Morten Brørup wrote:
> > > Added a new high-performance lock-free "pile", using the Stack API.
> > > The pile behaves roughly like a stack, but is not strictly LIFO.
> > >
> > > The pile is optimized for pushing/popping bulks of objects, which
> > > it does significantly faster than the lock-free stack.
> > >
> > > Pushing/popping a number of objects not divisible by the compile time
> > > configurable bulk size is handled gracefully, but not as fast as
> > > complete bulks.
> > >
> > > Performance examples, stack_pile_perf_autotest vs. stack_lf_autotest:
> > >
> > > On a single core, pushing/popping 1 or 8 objects is similar speed.
> > > On a single core, pushing/popping 32 objects is 2x faster.
> > > On a single core, pushing/popping 512 objects is 10x faster.
> > >
> > > On four cores, pushing/popping 1, 8 or 32 objects is slightly faster.
> > > On four cores, pushing/popping 512 objects is 4x faster.
> > >
> > How does it differ, or what are the benefits vs the standard stack.
> 
> The standard stack is generally faster on single core.
> Only pushing/popping 512 objects is slightly faster than the standard stack, but maybe the standard stack could be microoptimized to fix that.
> 
> On four cores, it is slightly faster than the standard stack with multiple objects:
> 
> stack_perf_autotest
> Average cycles per object push/pop (bulk size: 1): 3806.65
> Average cycles per object push/pop (bulk size: 8): 554.77
> Average cycles per object push/pop (bulk size: 32): 144.70
> Average cycles per object push/pop (bulk size: 512): 13.52
> 
> stack_pile_perf_autotest
> Average cycles per object push/pop (bulk size: 1): 4012.39
> Average cycles per object push/pop (bulk size: 8): 459.82
> Average cycles per object push/pop (bulk size: 32): 122.40
> Average cycles per object push/pop (bulk size: 512): 9.60
> 
> 
> > The
> > LF
> > stack I'd view as a strange edge case, since even with the standard
> > MP/MC
> > ring mempool driver you still have atomics on the fast-path and you
> > will
> > still get stalls if a thread gets context switched out in the middle of
> > a
> > mempool operation.
> 
> Yes, the no-stall guarantee is a key benefit of the lock-free stack and the pile.
> 

Ok, that is good. Next question, rather than adding a whole new mempool
driver implementation, can we use this to replace one of the existing stack
implementations? Do we need to have so many mempool stack drivers
generally?

/Bruce
