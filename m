Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C85CA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 10:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7081540279;
	Fri,  9 Oct 2026 12:57:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5207D40144;
 Fri,  9 Oct 2026 12:57:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791543474; x=1823079474;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m+1IRjaF2NG+xXNWZm3bGJbx2vYsIA2OnTzHlNOlUmI=;
 b=HWvuMLh/RWFcl4m66m2ZZ8Jt5ORba0gj7SSXLrsu3hkZ6fkycnFVlOQX
 QkwV1UI7B+AW568ER/CbFjepQLdmR5/OGV5jdFPqzql7R8CGVjrFLfyW4
 +PVyCX3l/aOHc4Q2J9uPRCQB9CLCFjOop/DStixdxmcSdZJfIN+WHNADT
 7MXvy9o2SAM74C3p/y45WsR+2hIom3QKt4kpj7LNpXCNNMTEOYDS1OEzR
 oFYyy/V+0/NxIGK5pIllr0lCVXQWL1IX/a8W/v0013y3sIvjBJ0LYdPs4
 +IClxBo2U4BjU+IZaTjylseVeyO/pYuVueinOdN9umfrFWoxCFRQ5BtCZ g==;
X-CSE-ConnectionGUID: J/ztg2kCQ/WwBN1nvP8YcQ==
X-CSE-MsgGUID: ZFOmUIQkRnKF3Pz91MxuMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="347964"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="347964"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 03:57:53 -0700
X-CSE-ConnectionGUID: kSQeBKNZQaWrbH5GvJjPvQ==
X-CSE-MsgGUID: 4ccQbuxXRvWG7G/UVf72HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="275820"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 03:57:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 03:57:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 03:57:51 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 03:57:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtbE5egKP57qUNRpWstBaHqqoIRlZcKGdOQ3Y+5qBjAgpVBHWOX/1FlNoSlPGg10ucy0q674cJXOjmuP+KvZF5XzNvjm9lL4DjQxSJS2QsPJkl1NDNxrjiSS96WY7Qs+8aQIyc6HF+mvlIkycYA6xeV+EGxwnxzE0p69fdAaJij5cwh4dTGUFz/+dtzSIcALRl8vnUoZ0anrOyh/xZGVRdJCmmM0+33+bqqdKeoHyssazhlmGiT2BBZLX/geEE9mf/T2AEx2haG2xgAujNV0oTE8CUwJWk/1BxVblqfJWC02azEkX3ZoqKLHYbEdv4e6REoQt9m9U5g9pdsFQKfklg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miMX83Visn2ZWcaMqI8dvWg3reeSMGIVmAXjYUrUseE=;
 b=uk19K/JX28bHss5IbiBfuMxkTDMaY2QQScQBHq2vaP6E/2ImO/+YzwZJx5x3GHTUGH9BxPKoQceX6bCUbyfxi1XYqE+XscwluUg+cGQx2lq67C2T5rzcSy0TCb183JRjn9tCMgjF63oz3qcuPGs9jT/1BfEJsiKkqcdWBdGNlbIgiV3CO5OHgumldZ5qn4RRMxifDGnK/O5DWRHVmRiVj16vB84rYI1CydjjQXajFAdbC3Wfx8sm0kLs+4nSauVeqdExGrmgTqJ4aiwTkEK9XCqzkuh3jFtmzdusSQTf4m1J/reBy+6tsTzpo1zNcM++gDaeAOrVEs7iDlOlzp2U+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY5PR11MB6536.namprd11.prod.outlook.com (2603:10b6:930:40::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 10:57:50 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 10:57:48 +0000
Date: Fri, 9 Oct 2026 11:57:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>
CC: David Marchand <david.marchand@redhat.com>, Luca Boccassi
 <bluca@debian.org>, Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>,
 <stable@dpdk.org>, Conor Walsh <conor.walsh@intel.com>, Kevin Laatz
 <kevin.laatz@intel.com>
Subject: Re: [PATCH] dma/idxd: remove experimental on whole driver
Message-ID: <asjIppnLn90ikKtg@bricha3-mobl1.ger.corp.intel.com>
References: <20261008154351.387445-1-bruce.richardson@intel.com>
 <CAJFAV8zdGwbqmKa=oFLDAJWv=7_rRZ1zBy_gtk_=C5NCOUsPvQ@mail.gmail.com>
 <asit1s5cdr_rqCqy@bricha3-mobl1.ger.corp.intel.com>
 <4849aff4-5c19-4676-b94d-f8ad393cecbf@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4849aff4-5c19-4676-b94d-f8ad393cecbf@redhat.com>
X-ClientProxiedBy: DUZPR01CA0330.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY5PR11MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 337d12a2-9597-462c-5e68-08df25f427b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4TGt5a8Mqp2Y701QVXqdZvFkZbgRNnpG+RUk7T4pzSGrWvHoJsmgFAIP82+/ENvrVx32nqNkZ926jRuvckMjj81RtbCGfbwzH8RLIRk2MsEPPtLqQxSzyzV+E8MEbyt/LGkuUS26z4EJYNy92LrxenP3Iir3hoAfz6yFCUfeSFf6dNfNtI7fOK/XAv5ZikqDp+4pIq+G0D5SxtypoR9b1PI0bnaapiDR36Uyx0vLwhB1JfyDvC7gCZnD4NQant4DZKZ5QK48f3gzpIXBQ8zcSGgbeWVuWNDycCdF9KXkCc+PC39e/593DINMxBuZQ1K0Sdz8m5sujFbARlyRTcnlScK//gFBpz6S8fi+ohiVO5wNXpYHUqdcb0YSE6VE21Em+accTfVBoh2o+f7FrYriPOx4tvvwp0kyNtMDJiqweoDhLKVYrK6vkw2TV7BC4mrzRNAWHokrA82mYNqEeidLcpq98wAy7hbpOi4OptCOCU0v/nS1Wmc2DfFemFzMWZ8GYPjjuHXOLAjTCtjWowxDEsDsW7pyYU0u3xEB8FPUrf65bgxx4TDPRH3enwW6CsQoO0TaGCwcbVg63KqKP22VauMSikoiofJ1OH7khLv2/MJ/uV7/3S0nN7PAzXx75oIqOGWg0qZfNzIlp4/H1coAIOAfqvBNVSKaBc9rbVllacc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDDw6pt4SUOGqXYHuCY8NoDr1HaYqSD2kQ2guieTF2axmfnRiRtZAb39Gvqt?=
 =?us-ascii?Q?M11AHCppmrmPSkBcIdhBJ9b06D4QYEoTSf39sVccZXTwlZXbnrwGzJDPgm3G?=
 =?us-ascii?Q?bR2n2u+lZFDP9euE3Y43G+2B0rb4LGnggyMWMtGEJZcH1G+9u+NGtVkBEGA8?=
 =?us-ascii?Q?6eLsufwYgNY5a/P4Hh6V0yI838Oz+CWU1bOczO3plqu/Uy1VRSVerv+Jixhw?=
 =?us-ascii?Q?mP9bhYHBfKv5W/zclSGOZ7BBcyyYsZZTArXq67ts9eTTdotbXxVlO+dYDhy/?=
 =?us-ascii?Q?xDOB24fE+sM8d22ray2i1KZck9p38lQ+gI7jy9sNBEQXHOTVvovz9lVn3hc3?=
 =?us-ascii?Q?pa2M5rC0/utF/22n6RXVyeYNPoHau/fal2FtOdkmpCcrV9yfa++Dm60ugdXg?=
 =?us-ascii?Q?Iqw9Q3vQ5DKYBbfgIvAJGe53LNOuCRxaiQRkurzknISGx2m7iMSErbNIrP2Z?=
 =?us-ascii?Q?cyY7HMxQGATnE6bRLHnN/l6IGlmWomyX6FLSUqbF7NzbBrrV3yIHMPSv5LGd?=
 =?us-ascii?Q?d+254ups1QpgSacZ+bm6vwUYuAkimIeqBCscMFZ/ZMrF5PzPkQukZ6IpDJ56?=
 =?us-ascii?Q?xMrC4Gpiblfa/RMHwg038gikm4u5pIbIEdYKKqxfpWjk5p6xHUIjoMUDGEbR?=
 =?us-ascii?Q?S0j8CnMSpAwzbai5yudCOL6vFkZW5teT25sBR7GHXUNok7pH9OthCCBBhNSO?=
 =?us-ascii?Q?3tHHAU9fLjW6sQo1/aV7b1wZWEetHyNCxme4FhC5EsYwhDLrafL5zgm7a0/2?=
 =?us-ascii?Q?vqKfXcoZc/+IlMTdqA/AUEJi3GlKUCluT5EM8LYOZssSMHLtNJVu+UkxJAJj?=
 =?us-ascii?Q?QPkf/p97Bxtz9uN+wdmKM6zKhI0AeorNmJu6k0G+4vB3U30DcmIjaJGL1Xn0?=
 =?us-ascii?Q?L6WA5XoBZq+tYjxDWScAutOxEbJ41GTFwcp/whQQCqHWLdiGli/JakpXwFEO?=
 =?us-ascii?Q?n6p1pzoJz75A2b9e676LK5nR9vGlFo9cdPYJaMXf3F56p4b6Gk4aMKJKMLgD?=
 =?us-ascii?Q?M+DL8vAfbtMM4ldP3kgTiFZNfFKPgBm+BX2GiDFPXQbuwA8yvDU16NLly3v3?=
 =?us-ascii?Q?zLfJ2t2b/EgHbYNYTV69F1WnlM8YC0AaCyYVXZtzFM1Zx2yGv+K6rEYJQgMd?=
 =?us-ascii?Q?GHs24qx1iTIEbkULKPHJxR9qXzWeOE7ogIsVPtjKts0WjSLga/Jx8j4j2+B/?=
 =?us-ascii?Q?l5/m/zR1UbY8orqVuwAcOY3nMuuNujTKUVrgRiHtvuBPPz6XZsT7/YfVvxDM?=
 =?us-ascii?Q?IeHpfZU9sWrTfGDmCYjP6AwadBuzx+tIiDmWo6lpu4YpMcI2TTa1RX8OxfXn?=
 =?us-ascii?Q?jDb7BPd8aAhfS4pW5Te41fAwEwVM2wFDr8GhkIgmrSRVwPZJ3IHTRfHdxLOi?=
 =?us-ascii?Q?4cUdoVzSQCV13dmX/7Rjs8esOBJ/zeipRQ9HZYE5IKgDWZfBhDykhlthWMZB?=
 =?us-ascii?Q?0iFtIVgiYWjfp3GcW7hmH3cAILwP5e9eidCt2xkU1QUW5u1RtRkJMOdyef3S?=
 =?us-ascii?Q?XUZYOobhbTFLaN7ESHzfSllPlCZtfnszkjr+tjni/q+w/MajulWIu/XH8bzj?=
 =?us-ascii?Q?sJvZOOfyX0MD+mZl0Jz8V48nsRlemJ81ZjgsQUHTy+GoDyUdglmqKS3LVkfQ?=
 =?us-ascii?Q?01C/1lXlwQL4pndQ5lZ5BXxL3Y/BpxoOJqiD0hfkThVzsABdwBngOsFoGgBB?=
 =?us-ascii?Q?zRjldZrmcA2HKBXgAvsspr41T7pg9NKQH9J6dO6rDjrdaiuN7fQIr97D8255?=
 =?us-ascii?Q?rWPPbFiSGdk6pyvP3/P4iWHvFXwQLK8=3D?=
X-Exchange-RoutingPolicyChecked: Ux1F0OhPWeKZDRioaBwef/RqDerTYUqEWHRAOQQOGr2SVMLPHlFSSZrw53Ef3sFwmk/hp9fxbOHGwi4yJEq+zkK1uSYx4MsrAZncHuKBoMKPKMo96PhrCwywlB6X46zsphVgu5CXzJo+BdGZk/DVsQiZv2xpacZYGUxOBlSbZWSjMzFrLB97s2/7JwsC/iTFkIU/CtQjbxfLdfA/CgrMOHEYbqoPljIFR7wNSMg6Cd9RrJyaD7vF4PfhPFWavE71Pl7lBXc4vhTKyMf0vWQEM8L9oEC0l1h5Cakc/OkTdcb7yZA9KnkYoA9NryENt3okW1gA5vSb3nJKXQIygqwIyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 337d12a2-9597-462c-5e68-08df25f427b4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 10:57:48.3002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZzjKHIz2lC6FdTysrTf62hKp2OgICiCutrv/lgczTLLLf2M7/BkYfgy6zqy7HBsMIts0k+NxohlnvB0tAgTuo4Ty5uK2qifOTn3yHKt718=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6536
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

On Fri, Oct 09, 2026 at 10:52:50AM +0100, Kevin Traynor wrote:
> On 10/9/26 10:03, Bruce Richardson wrote:
> > On Fri, Oct 09, 2026 at 10:55:49AM +0200, David Marchand wrote:
> > > On Thu, 8 Oct 2026 at 17:44, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > > 
> > > > The idxd DMA driver was marked as experimental in MAINTAINERS file.
> > > > Remove this designation as it's been stable for a long time now.
> > > > 
> > > > Fixes: e33ad06eaeeb ("dma/idxd: add skeleton for VFIO based DSA device")
> > > > Cc: stable@dpdk.org
> > > > 
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > > 
> > > > Putting the fixline as the original start of the driver implementation,
> > > > since there is no good commit point to use to identify the stabilization
> > > > of the driver. Since this change should be good to backport to all
> > > > currently supported LTS releases, the orignal addition of the driver
> > > > works fine as a commit being fixed.
> > > 
> > > No opinion on the backporting aspect.
> > > At least the driver looks stable for a while, so the patch lgtm.
> > > 
> > Given that the driver has been around since 2021 and the oldest supported
> > LTS is 23.11, I felt it worthwhile to backport. However, if LTS
> > maintainers want to avoid this patch, I'm not too concerned :-)
> 
> We're saying the main branch is non-experimental _now_ but it has diverged
> from what is in LTS branches e.g. [0]
> 
> I think it would be better not to backport this patch to LTS as the driver
> was released as experimental in those releases and the docs reflect that.
> 
> That it is changing in main is positive :-) but it doesn't seem worth
> evaluating each LTS branch and backports (and any other code context) to say
> if could now say that about the LTS branch too and retro-fitting the docs.
> 
Sure, no problem.
