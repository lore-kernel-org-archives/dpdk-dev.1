Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77912CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C079B4021E;
	Thu, 23 Oct 2025 18:22:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id CA70D40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761236561; x=1792772561;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5A36Mr452MVGh5gwyP7LTmad1v04P+8aeHbBxpnM1YA=;
 b=UDHhjEW/deWOM2KdhkQPvkNQ6O0FOFXLLlD18zLBVmSFR7L5kbj7+bFg
 laoXf4b078Oa85GcetkWW16G2U0wcipBr6SIdU1oaQR8Ja9VCttqbKXxJ
 u3pVSxKxw5gD4bRC2rKRuwSdVbb5vA6QR/UVwWrg21FUksyAsirFNvCgE
 YYjK1bDaDpS9ProG/z2bE8xTdF5zeVIWFjKaWGQXhx6SgastQPwRcjRdj
 bA7tMnJd1XNmceRUb9K5gm2ifEQ3eVWOxUuTYWLcg4Xh/r7opRB4j45wm
 2vanZnhT6JkOAOKPa3Et2HXEfx8yaZxDu7xc0CVoJOw+kmvjjch3A7r++ g==;
X-CSE-ConnectionGUID: sNTe3eTPQnefhR8HeSog5A==
X-CSE-MsgGUID: v6n2awUmScust9jkoJcQdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74756604"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="74756604"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:22:40 -0700
X-CSE-ConnectionGUID: DjbhfS/3T6WBqr08+fGIog==
X-CSE-MsgGUID: NtaDHCzsTMSRFCvqQxAefw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="184095002"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:22:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:22:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 09:22:39 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvaonyp0ZfISrlVg33Zu8tTEM0jxrkNiKz/+MNscLulYYS98ObHrpvwPa4VOY4Ww5q7P58qNtY9E4sM2oiHEXLlMiUkJxm2wtjbdPVZv4O51cvLlUF69L3ennbuo7eOIJdKgx4fWI8KfrTxtVM7tDIDRnPvI65VoyMclb6RiTyCmYqPMBypFXaIfFHOnWuIrijdvmuI85mIOoJr0h9TfkpurJOG4RALqjGdwLoSj2LUbx1kfH/RLZd8eX44iY3/ZxHvW3ISYcOoNwGD5yw1Qg8rO9mF5Mm4UXyC/BLhVnfTtZlVgSxh5PSXPm2NsMR0/3YFrqE488RhUwOZcCDoLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKtYZfg4NzqCW0eUR0EZ7qK42rw5DFBCZC0odWfaDPE=;
 b=MT5Jj54/gaN37uliUl0Oowwg7VULyKBSOUMuK1h3O83VOGXLauSC7avEIvU2vJQ/76vUfh5p7N6dOt+K+bHGqJb0nXpt99WnPbncIFQFjJXtDXA0CQH0vFEuQ0fymmmCGxothEJrqEO4Ib8uhp+8ScL6Ly86QZW+GzzstHnWYNjbzBp+ZJqbaFEa6NEVC2tYifaDPN37YwAOuToYU5fBBdDBRBM0JarKFIg9DyNbaTNgNTYLZ5Nyv3S7/JxEyKoZQujWLa+OrZ+RoijhVqSRA3BZYmYH3upms52NZ8ySKC0w9BRnCKSFkP8gsDGv7n4RG0V0Ey3TRPk6fRQkJwYbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB8397.namprd11.prod.outlook.com (2603:10b6:208:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:22:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:22:37 +0000
Date: Thu, 23 Oct 2025 17:22:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 0/8] packet capture bugfix and secondary support
Message-ID: <aPpWSLdxE0IOAdsZ@bricha3-mobl1.ger.corp.intel.com>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB8397:EE_
X-MS-Office365-Filtering-Correlation-Id: 75baf673-077d-4664-b91a-08de12506151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vD0GJNBn3Vp0VMe2l+vUaTALKjOVSMXFemxk7aC2FvNKCTLP6Egiss9poxig?=
 =?us-ascii?Q?OqjfEP6jecPV7JMo/6EBvKuPdHbmkwjFIKVqMjDscP6ClazTPvBtOOLNPa6K?=
 =?us-ascii?Q?JVempl4KdTCN/wsSv2FsfNdt/DG8yfaq0KlrusQh5MgOasiQei8fG78qCkNF?=
 =?us-ascii?Q?ChHviohGmpbNu6MkpyDuo1q7+Kzprb3Ore20yIFgsUWTg5MMY19JUz+CO71k?=
 =?us-ascii?Q?6l6C/JBCHPoHIfDml1cFhVSC03X7KS8YOGEGmucNamdvWS0rJ0O/CXDG5siy?=
 =?us-ascii?Q?8jWwybwbqhDOUtrDm+cV0TdhewzdlngAznl8NG0xp4LXYWXsrIwHtjTWi+v0?=
 =?us-ascii?Q?EwYmO0rbNN6qTXJC3Ss28qXd4v+VsNDy/hE1begtqq3K96v75XwGpDnthI5q?=
 =?us-ascii?Q?xCsywbAhJhND/59HBwdlKK0onTTkgaT+urOX6uSMoo4GNRVX/tEUqLa1T0if?=
 =?us-ascii?Q?LUpP64G0nnFVN3qCysbbuuqCqU4gSiL2ehz4WdlrOk04paiKofvJHVLLqB04?=
 =?us-ascii?Q?3EapHQKU3HsxOqB962eSWKGUtuB9oHobVyVjY9KMHj/tfYHo7foYvVUb6a7k?=
 =?us-ascii?Q?LLhzlVqLpCIE+laOBL7RaF/eatChMnCDW73PvC1Wxz7rxbibIU2NUNPvNici?=
 =?us-ascii?Q?PIRafYWWxj/neF1l1LE9wJwyNnWbx6oVN++BKK7DhqcjpihrUVq/8qFi3Nvb?=
 =?us-ascii?Q?qxT5mV4r7JwzrWdbE556zaFFs76R+gcavOyJfGy2QWjB2cvZ88nLCwe6DW6f?=
 =?us-ascii?Q?0tcWj4IAhbD35417vr6eKAMMGMjYuqCgBZ1djOyij72OljpBBJ+T3267w1ur?=
 =?us-ascii?Q?BKF/EkjAboCIcsMNY2/WFYJaVhQwEgtfnlVaeHUn1XExx0KShYwFdAPQGgIr?=
 =?us-ascii?Q?i5MmSf/5JGQ0nXmEBpciBzBgFNrdgciMXBVDzKocsIO2AJw/xDk98QXMYxIZ?=
 =?us-ascii?Q?9vhS1+ZJCt7kymDl6jNgaQMjywdEyltMz/kQgiUmdCk2qv4tYCrZTzf0Dc/5?=
 =?us-ascii?Q?2FzdBbxXetDyBWfVvbtzJlUtARghzaLf7frZImJkA02Mj8PMvFep3ozW58zR?=
 =?us-ascii?Q?uTJ0wmWkmGs8drGwHbRo39SOSE/vAi03ha6Ihk7BNwTZLT55FnNNug07Mmtj?=
 =?us-ascii?Q?gEbGgalnFvadWuzX6q3PV/sCTz/1fXwhEnKh208qRgUeLcERGB5PNHBd1wfH?=
 =?us-ascii?Q?68P1kT9ESFemY+vkXLSPv1pHLPX13mHwmGRL/L+nzImNzY/OcGSBJAdjBsxE?=
 =?us-ascii?Q?r66wWItvUoMHNZPpoQWURSMQs9rd06jodOpGA4rfN1Uhq7S1aCTOIdxlgMX6?=
 =?us-ascii?Q?4jB4m4HmC+PKQFJ7Mgua7TU41LegT6a5i9+0PEvHnOrv4bVqO6CtMXEFg+el?=
 =?us-ascii?Q?OWJ495H7jiU4XAEtIJuk5aMo0lBfYB2cEIj8ezLrN1O5zhkEu7IoSLPUSILP?=
 =?us-ascii?Q?T46AeG3M2aazuTDsoOslSv6AweLsXd4j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhbOxOj+gBWEdXa4t9cIOswra5yeihdnQG5Dlf08dsalrO7a7KrHri0biH3V?=
 =?us-ascii?Q?Qsf7wJO5e9zfsEoJ8NeG19RL5a5US0X4NUV8nM5jiwmaT8lBKZvrkHhTRKCv?=
 =?us-ascii?Q?y89jO/H791P4PuCjpRnx5DDsV2JPt+0EJCghfC47u31fzs2W2hS7l3VftTg7?=
 =?us-ascii?Q?oV8SwvgtFNIZGKl5nA/aMkSySiFumGrDlesofcU629tLeeDB+B+FbXbvUviP?=
 =?us-ascii?Q?xwkre1u9qeZVs2Kw+z/n8OUIrZ1ifFbBi3ePM0ym+mViFQ9AQ6aFRjI+az+8?=
 =?us-ascii?Q?0n3i4mYLTq5owh1FT8NV51NIRPswi69mwOvx2vsYk4H8u8MlWb+7kAE7ipqy?=
 =?us-ascii?Q?mVhr8sRnItUbjO3syMwlau1yJsZZQ1ZqH4CbFgCM29L66+x0e5mYeIeIkQBR?=
 =?us-ascii?Q?fjo4CKGybgfLPOmsQkdEobtf9+eAu7oW5P+LgMwJ9hBT3SfSJWaS7CHz1Qr8?=
 =?us-ascii?Q?8Y6cnqnMvQXQS4/3W2Y9Zpfvb3bR0c5x1kLHZOQ69rE7sIeLHcnk8i5Y5uU4?=
 =?us-ascii?Q?KHYe2ChSiFp4GL5o7OsOCAi3SHi66T1r43fkVHxViQs9D1Dfq2ZDh7KECs7m?=
 =?us-ascii?Q?4J2woELmTWkLIui/6WvfJK6Mued25iDlVFIcq6i895Kki/+2DTTFeD+T3vo4?=
 =?us-ascii?Q?KKwTaFnt2MwtJDTGvpM/M/hcKy2mI8AbVZf1WO4UYRszL+KM250DnEwCUsTn?=
 =?us-ascii?Q?e9nlRJc6wJeEx1w05Z/xargz3Y33t6M7IzG4VthvcLix01tmgOjilixvryPs?=
 =?us-ascii?Q?0Jx0KKFD0+5c0Nk3bjZPkxIkwcrbh3zYEVOhiYCSngkNklYtLgK8UcXA1PzK?=
 =?us-ascii?Q?Mev5qV1SC0rjG+W+qzKNTvOCFOXHiIGyDNNSeQKken6wraB6m8f2pq7oG/Ze?=
 =?us-ascii?Q?IppKC/3R4DNbwxmacEovivxVKFan1wL0xddH6lfdddOE8pAeatklu4rWbi5Y?=
 =?us-ascii?Q?nEvP4riOyyEG/VlrpC9GdJK+fZKnXbeOm+PZc3jfWVKkXJ/2bXxVqJJt/Wz0?=
 =?us-ascii?Q?xfi3F+RUOLNmLbaQBGnxM6eCDccs6SQ+NxR9/nGSw3VEEb+SSXMOjs7lNxhL?=
 =?us-ascii?Q?214MG5PFO+J5gBz5Dg/GTVEBJqZyabckj9JBJrYdCsgSGOrl1/unglzxgC23?=
 =?us-ascii?Q?1Q5QjdX1FGcKnrmC1ldNaW9dSumn806XXPcfV0QKMbvwSJNY4G29ViCjmQay?=
 =?us-ascii?Q?iCXL62aar8cpu4Up/FWKBeOpJiAjCXJhpjVZFewXRs/xHVlmvhihAt5dCDa4?=
 =?us-ascii?Q?5S6cqutsvgHA5BqjtX9ptBjJ0AWxpNIvAXa6iuj6vN1ONp1pz2wclHuC4C1Q?=
 =?us-ascii?Q?kAKlnfAGVSTPcxhvQA+3dckmjgxjagsHsN5ta+jyQRg2XoEVjaHJRFrudtMa?=
 =?us-ascii?Q?qDECXWhePP93d3t0663WosFZultDSiiWTjLImF/2fK/lsHpXpdsOMmam9Gf4?=
 =?us-ascii?Q?FBhQtWOA2xD4O5OC4lFy3UFt8MQXY3ST100gpptYy/IpiJjiOz41w9TJJ+ir?=
 =?us-ascii?Q?u/9SDHxnR2pTJJGzMl3Cyxb0lcfIoC3881yf1ZkM6VJmaaoBFTlXz9PgJj7O?=
 =?us-ascii?Q?szRUSlCy4Djls42Qz0FHPA2qMQn8saOMwTd8W4FCiwkeJV7cgv4dZtobj/W8?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75baf673-077d-4664-b91a-08de12506151
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:22:37.3933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAekgF3AVWR2b0nA3BhN8wgRxtce+8yIUiu6JoAy3iglE6VQctSeFoFZJaLkoBhCj/DMmDFf0SJoS8TeFR7Gd+DAzfv1infjgnL0fgchCo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8397
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

On Thu, Oct 23, 2025 at 08:46:21AM -0700, Stephen Hemminger wrote:
> This patch series addresses the problem of packet capture when
> the secondary process is sending/receiving by using the same
> mechanism as hot plug.  It also fixes some bugs on shutdown
> of dumpcap (and pdump).
> 
> The documentation has been updated and improved as well.
> 
> v4 - instead of using alloca() instead process in chunks
>      which avoids possible stack overflow
> 
> Stephen Hemminger (8):
>   dumpcap: handle primary process exit
>   pdump: handle primary process exit
>   pdump: fix races in callbacks
>   dumpcap: handle pdump requests from primary
>   pdump: handle pdump requests from primary
>   pdump: forward callback enable to secondary
>   pdump: remove use of VLA
>   doc: update documentation on pdump library
> 
While I haven't been able to do a full review of all patches, the idea
generally looks good.

Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
