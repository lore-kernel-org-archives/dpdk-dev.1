Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDFCCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 570964064F;
	Tue, 14 Oct 2025 16:07:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 48009402AE;
 Tue, 14 Oct 2025 16:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760450855; x=1791986855;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jcL1XFIcCK/hpam/eVfudFTqV5PPZCFVo+WgKbg8Ggs=;
 b=LenbyISCwhvOpFkQr0qEhAnac47OMgc3yHsj0TBnCzCuSEjvVRYYZLvR
 MDnpCCnHL1+tixJze7benOYzi0OUTuAiLA0ghaVj08XNfMssacjlrPbSu
 wbx0PmzTQUpwGV3zXUEgIE8ZReLw7hVEK9cpRQP7bqz8MCGepPnwLkvWc
 oFynco8nsqw1ji/4QICNhaAHcOSU7V9ZyqWxtI4ItaNhrUlz+7BOYC6zT
 L4DhNJdzR0H49DezKlGvLzPF1hfk3JoIljOV5uO4I6OwTUHEz6NpqA+ah
 xzKUzOKPcs/9sVI7tGR0u0xXL2DPLeo+ghLpi68qXYez3YNsTwUKNCc76 Q==;
X-CSE-ConnectionGUID: t5mjP8UgRKWRPlEZjr+I/Q==
X-CSE-MsgGUID: 1lBzn2iFSUCnJn8UiICbTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="74061676"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="74061676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:07:34 -0700
X-CSE-ConnectionGUID: GYDT+mfLRnG8Gr9Af++ZlA==
X-CSE-MsgGUID: +4/hVK8KTR+9IKS/m4gXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181443693"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:07:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:07:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:07:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+dARDnpu7HQK4Xp/RJ5ODhQNgbYIlVbsCKegNTRgKEcMflXBH7Mj0EqOzt+iPY7hv/1+j9rSxSSftvSqgPaeIsRoAO3ZOF6dVEeaUheO9uNm2t1uTvufRWox00gQvdbjr7FV+Sm1tc6HnVNZgApe6C6oJYIWzJaQYYYCxCPsvWIMUC97sYtBdWdtFVkhtVxvRNjiWp2lvFz/nLXAR5GXyDwxdP3aw0ueM1gNWidc7rhyB/aY42jBxAuhaiBNHVV6lRwfCF8Ke5xFDFtPr+5ZsdKOI3OlOInAC2cKzoGdNuy0YXoJaRuoQBqoYRYD8Olk9pve/H1HA3ZZr7xFOYdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW4FG5rQtdYyTjgs9s7YlEOGyhJdIseh40j6uNwuAOs=;
 b=Dnqvlj3ecob9u2l4lcf4ymD0zR1akKSnqTUpvjkZjp1am14BGs31zd0CS1WRMimVIiB90ZLQr/Mq9oQPufLQuqyU0iiiUZw6qFhuWFNz0RJCeM+t0Bd3IRyRJSKlBzOuUBL7FuATMB/LXk5nF9Zc7sOdo+oDZFhfA9XjarZLrgdYZ4iCdPobHPcVDJEhjIWEORreFNM86LiE2azPl5omGJ+snK1IGHodForMTuLM/h1G0E3IrmphOLBqiSxBu/52cVZtL7a0DYLDdr8pH12jACehlBsLRPND22us64xHBNyzxBeLjSnkWhOfkEFQNCIjV3wFAZrKfz7h8ePlGxaQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 14:07:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:07:30 +0000
Date: Tue, 14 Oct 2025 15:07:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: revert count drop-all filter in Rx stats
Message-ID: <aO5ZHZoKkQdy5vE7@bricha3-mobl1.ger.corp.intel.com>
References: <20251014054324.3908737-1-shaiq.wani@intel.com>
 <8ff1b2df-c3bd-45d4-981c-c711409c173d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ff1b2df-c3bd-45d4-981c-c711409c173d@intel.com>
X-ClientProxiedBy: DB8PR06CA0047.eurprd06.prod.outlook.com
 (2603:10a6:10:120::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: f97208fa-ae8b-49c8-6d34-08de0b2b039a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zYpnmsk9ra/oxddBgMhcU1sdMukXS133HYx1CsvfnHfrPZ0ah9vI6T3AtnH8?=
 =?us-ascii?Q?/EBMGj7UTxrL1QRMVeo7S2k9O83a/nrt/wiOoS9gimTPzXsC+qLu77X7H0rb?=
 =?us-ascii?Q?7Hq/L7ZXCFi6WUQ5LQKOqtzyjm3sibBxbZnN3IpDgghjTdtMAQRe2o+cNo1F?=
 =?us-ascii?Q?Ab0Nil4uqM2CNiTzyuJq9VOsqKbPS772uL+taoZOI0PrOwdounIFUx+zERgd?=
 =?us-ascii?Q?oANOFD4coAOu2U6OLTkgEB56EL6/FjY69vfG1Jd424hW/qu6hglvOaXSAuP2?=
 =?us-ascii?Q?RRq67qVKk4QOTKU9Uv6CeAWtpSS1NGNkomsuD78cPfy4ZYHBsDJm7xE54Iwo?=
 =?us-ascii?Q?DzEqClexoy212B+9wbwcuMRjMsz0vPMI3nEsosI3stEVMOiwzLrVXOLAjeiz?=
 =?us-ascii?Q?YLlUSic5eU8Ah138UJJjPCg6iLNobKJFR9lDPH7EBJxqD4q9jt/Scg3yDMt5?=
 =?us-ascii?Q?HqPpad0+p1IJvfx3bpJeofMBoGej9YFa+bvyaTLP4iDGjNqwEhuaBWYxY9UY?=
 =?us-ascii?Q?4x5EBa0FQ4nkv1xPnP16Ut4jtSV9b4LJD6Ka759hoC+Y1JlkogyPON9TMHdr?=
 =?us-ascii?Q?uVXKEuD/ZudtFIrkpELu9mW7+GegUVVSJ7aHQxBJGQzzZDfI4v8aY0PEcMci?=
 =?us-ascii?Q?QxAX6cQUw7+hmrJD3kMIMicBF9xyW4IojV5ME6lBYsaH+P5EDHxur2ZKOVw9?=
 =?us-ascii?Q?Ii0KLDbpsJlzBkvlJhqaB2qFYFzhI3eXJpEV1Xk0PfoWmSOKgd6JtX9DwLGA?=
 =?us-ascii?Q?E9ZokVPjE0LUHBNcqHHDNeG096g1U6fi9wb7MWnzVrvB2GoDQjaxwvNZlKo6?=
 =?us-ascii?Q?lmp9Uj538xzCjT8BrztJAVuQLPi5b09brlCCtJQQRBWwWw2UIQAV3MXcSUyG?=
 =?us-ascii?Q?7pg7H8jJY4K5luPlc3FC2dof6H249jx3BifIz7lKPu2apyyMDvan9KDyHAM3?=
 =?us-ascii?Q?zm0BapcWPiHG0PNaL7XwxZwR4Dph8oTkeKTFDI51HFpZxBGyN8iC0bRwHjfs?=
 =?us-ascii?Q?/p63MtfH+j5zQbwKFiGj6HbMv3Gp8FhHPMYnOzicTQM9krZZwX4kou2Nf4ho?=
 =?us-ascii?Q?UA1KSwLjDpDV2Jer5rnb11o6J2y0wjkZodWwNMGPsQBCyjLiXe/Zp7hYg7oq?=
 =?us-ascii?Q?Wv1LTgwyrShd9yWh7qmXrLXQs2fmvPAC9aMTrOE7KYSCIAktedfBgs1uOuSK?=
 =?us-ascii?Q?jeUrqTqghpBPLdr2wgjaKJie2fGhDDAM6jPY2A1JDr9PW/hWEx9w5z7mf6xT?=
 =?us-ascii?Q?6k1Pviz3RiqKuEeO1RmZ4Y6+Tli5WsSxcSbXzd18NXFSmN1V0tAYh2PSqtJh?=
 =?us-ascii?Q?BJeiaK7KOJo4CoT107tO3NfPB/Cev1lusKz19C6/89pcJoY+yw3lSqT6bmRb?=
 =?us-ascii?Q?p8OatZjSe4aQEHdWMNMGiJ2zv9BXcP6L2TyeLKgd2O1XJ9JHwvYvU+1KMxn6?=
 =?us-ascii?Q?YyW8kgmYVKzhWyJ7TEvSUdQSxzlDdlto?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSEom3PRqrtUkobx4fUQCGGh1Wrsxlwpn7fybiW2q+9el+B/i902egSrmJA8?=
 =?us-ascii?Q?wxw13Zn7verORLqLw++udzZeRdiizdckvpe3XEQAJPo5Hv/0+3y3UaPp4gxI?=
 =?us-ascii?Q?O0ZLx4fxlNB4JYsNCxy2GLP10GuXAS1DWXgMP8hL0t/sjEC4UB6FgXORFKSU?=
 =?us-ascii?Q?WVzgIN8mwyyy9jpghCMBRxUrLPvh0LkzbaYmyczFXb3ZlY2TiUtQ57YA7Vme?=
 =?us-ascii?Q?APRBB5u3jBxAJUw4JgEAADE+GUbcwcWwQG99Zx0zXD8jaHzXit036T7aDsnJ?=
 =?us-ascii?Q?iF2yQ9137a3BTdUOMlIq0u3eU280dtKZozDv25qVYTTKKDPbEKz0xMKDwcBA?=
 =?us-ascii?Q?LIxJgHrHItzh3uw1bf1qZ4xGf57Tkbt5ryx2xL7C1Ngp95q4CLUi4kkZ/Kt6?=
 =?us-ascii?Q?g/YCJpHEtNBlIGE6nMSFKkuzqTx5FIxLFqQvxqjTPYAKT5T33K2LjAeNtjwQ?=
 =?us-ascii?Q?SOkhwin6YmpBqetMiWdbqgU+xOjPH2xMPGa4+KHnO4Yc9+cXIrGwjNWuAaap?=
 =?us-ascii?Q?XQ6Y8t3wosW324Z33XktqzqyfKQ9gO1mB8vwQi6xSnq6fhJaSNWZA/JcKKIf?=
 =?us-ascii?Q?RXTU3vbQTKFQhFo4E4sdMBXzecbmkNOUBiuaGjChHPXSNX2AjRFRMxr0jKf9?=
 =?us-ascii?Q?4iRCU7l9dw8REFznEaSxqqphf5wF/aP4pgr6+oynvgEkNo4MbcqKvUoJ5Dnn?=
 =?us-ascii?Q?c7l281MAP+CKltfVYuFv026aYIVpOy17vqnhjJfSpllgJXrf0ww1lD9HE1vx?=
 =?us-ascii?Q?gn97ozHyE6MVu7aBxvOr7ILI0KsEgXJS8MR/wwU1KPmluIuSDfbe/88RhN7C?=
 =?us-ascii?Q?Gmtd89M8OhbAMW2qA1F1dRWATvh8eSepNXynDp9DFK0tGlIh6QP4lEvHyqlP?=
 =?us-ascii?Q?mY8ly30JF0GCuP2uwpDLoQNo9iiUjbHLL2kFN9D2smov+lzVhNcL+0OQyr3K?=
 =?us-ascii?Q?VNNAYZAs3nF/kij0sSuFoP+G9tP4mDMq67KB+UxoPU11llkrM5NTCXOUeqlQ?=
 =?us-ascii?Q?NkHt5JT8pPX57JVJ6pQUVarn6YQLVKCy5ga7FYM9PieuvhfvroximnaTf8zq?=
 =?us-ascii?Q?gORtiWQX0rEnLQcurXOV20C4Kr2MwEfQY3hstC60BYwbOPoHfyCSF7Smtre1?=
 =?us-ascii?Q?Oyt/4Px3e3i6QttGgosvnQ3ZWjWqKjioGnimdJRcahZsOMlMFgzfrPI0tCcc?=
 =?us-ascii?Q?eh9fYf88HTU+n7Vfmeu4LRvaX2fiCg+tiZKPxstytWgGCGPK8gnCiBMkKMaf?=
 =?us-ascii?Q?hEDla4ksh2lhxSuK1+3pZH1+/3f3xXLHeto8SviR6wXrnQkP+GH5tSX/siGl?=
 =?us-ascii?Q?QIupWJl/dvqQpTE/mnHQgyKlsrbRYNLib6Aesdb8CWElL5OoQf6SXvI7LR4y?=
 =?us-ascii?Q?0LC0GRC9hydPxuALN/F/xR9Adc2N3aHdujWb5MyVtHuKPzzJXG1YWqinLekV?=
 =?us-ascii?Q?Dsg/9cyz3Sy4dtYmvTQiJNBgNl41X5+y9pg1gx6PBHy8zMfLu+HQkTkcnvAC?=
 =?us-ascii?Q?jUZ4ONqkNv1EyYRlQZHfokeYOEjoOqvSBLe7kIPqVL2ymmWGndf/OzbPULgr?=
 =?us-ascii?Q?Hg0sYP57cIUIbqT0Z27UXBW6DD+xIE1npwFNiATIkq7J72sGuUAtSkicalAz?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f97208fa-ae8b-49c8-6d34-08de0b2b039a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:07:30.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqMq7lSGkeJJehUrKl9rJM3rYZXwU8alnlVS135F8F0KTjWjfuWBNOhqryisoxP1l6w55cTAf76q/Ffm4RYxHKt0VWliZ7fItJ2UZB5QOik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
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

On Tue, Oct 14, 2025 at 10:41:38AM +0200, Burakov, Anatoly wrote:
> On 10/14/2025 7:43 AM, Shaiq Wani wrote:
> > This reverts commit af05f9e37153c53335938bcde2978a359c5f4efa
> > 
> > This patch caused testpmd to count packets not destined for our MAC
> > even when promiscuous mode is off.This behaviour is inconsistent with
> > other drivers and leads to incorrect Rx statistics.
> > 
> > Fixes: af05f9e ("net/ice: count drop-all filter in Rx stats")
> > Cc: stable@dpdk.org
> 
> IIRC this change is still in next-net so no need for CC stable
> 
Well, it's in main too, I think, but again only for this release, so
dropping CC of stable on apply.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net intel.
