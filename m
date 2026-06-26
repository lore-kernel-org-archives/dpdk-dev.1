Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79115CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BFE7402C6;
	Fri, 26 Jun 2026 10:47:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9AABC400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:47:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463678; x=1813999678;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MXVlSu6Cb9JtBznlF39vN1LAewkT8ZjezPjAT9btAnA=;
 b=dPTNQkDWzacq1v8E20ahCIAck5zRP7ei9319rvXDexYhEXIXbNluSVkq
 hpRB3f0znBw1UjS6GI3/SU/B2iZ+T1gxUdTLckVSogRsyEFbeVi3ZcWWK
 1hHXs4Y7TBmUyMPrZqwQZlcHe++FqKlEJsE7+901qqQ73kK2IspTPd5Pz
 1B4gNmQ496k4K7c4N1RtU5q0pSNDtoRPK5tg+IR1d+LYz/7+6m/3QA6f0
 u4bMuES+gyQCAPNUo/EUx8sFc8jxwIocHYpunqoIGk7/UCotdDZt3teFM
 MugToPXa98ukVh8kCgfs5t2JXfDDIxAqMJU/iWGJr/Xlg6PysIWKdeb5s g==;
X-CSE-ConnectionGUID: AnrRuNQFRa+Tvp9qCYEHCQ==
X-CSE-MsgGUID: 1YLAPzfRTJKPz/4qwIPJHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94649442"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="94649442"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:47:57 -0700
X-CSE-ConnectionGUID: LPZPwKprQC24XHlfIHPj4A==
X-CSE-MsgGUID: 954qaAX3Sg+HEg1gOuVBEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281359397"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:47:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:47:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:47:56 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak+Nz7Riaul7DIHi9GWYlwIOMj6WzgMfvjeShczMUDDPxutmml5ii3NWiY5wGUAfM9ec0c9eD/FkW91RlZWiEoOa1FmYbqUmHbdGYhzXe6ZipJcKxNbRWxkt9iXPG2ZlbP89QT1/a/245k496W91zjkkdUQdtm3QUGj5X8n7CDNOageg8LHhibetp0C6jkvJmWaQhXzKn/KGhGrnV6amP59wVlQ+LhY5KYXB9dLBYxTMZdVnWavhLEZMhqbM58LbmQPtfGqAwCRNrp+lZ8PAVva3bEBvtVjf0vxb+Tdjt3Z5SX2RcuG3xs2Pup9XgcO/Y29XIROxmCezDc81sSsDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOu+DtPYtrw95PKscd3ZGh1pDUZQT1QFhVizN5BOnOE=;
 b=Ag6qSF4AXB7aw7oozfjg6LTRjtxRMRIBOcnBn1h+6p9moQJPIQ9QSv5TGXA7Dn89elAOHyCt6G3LQOsV+4zK9qnu3VQjumyUhPMqep37t8Tr2RQvpQjFJKGa8y67OtjftDmAv5B/tcieJ4JbrHEstz5WSNczfFA5kkwbwF+YutZ444CyVittZuLlybQG25t4QCMo8sNV2iKesVCdH9ty9tuFWEr9ZCqyP2W+/9G0OTIJtV6vUPykrRImhXK7cXz+ewrpYGtxzqvMUCW6wPZoqDYeyFLJA+km7Cy3lBvoKDMkDmkrfxd5WKkz1hbiHpFYGyW0m2Ud9LqhGub45/PjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:47:48 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:47:48 +0000
Date: Fri, 26 Jun 2026 09:47:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/4] net/ice: fix potential NULL dereference
Message-ID: <aj48r5GCYmLvhZ5X@bricha3-mobl1.ger.corp.intel.com>
References: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::30) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: d440b13e-38f2-4abc-b2a5-08ded35f9956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Exmq0FHxPoiaxLNsXly6yn8SIkttrwRZSSyEwc0LfOcYSvLBE+t193DGbAu+s71axKWN0CdqaQIz8+K9IkaH6Z6ahjx2I/0e1xZYybB3fJ2ZvSAUADmds7BmvTpFU+LPduW4ZRhaR4i8UECqwFJmPRD0Xz7Ua1sLfAE0OgC4c21EDqoP+n2J6QBw9/Cyhabnkoq0A2lQfihwS0iQetMUshkG1DXcwqlb4qVSV3+J5GO72XBb/muDmVr1dMA4r3kdM1RftU8Uftn3njWoiR9jIl7j3FajTCIUYvW6vVQTgPc9G4ZCjjw+XdzYA4pTD/xFZp0rOA1RKBEmeKjC5orNpTxpFMblfVwgemlhHAULdTBqjcEfeI23QJOaNdViaW/6wkEfkJxVLLZ/M2eZa+aY7hq4crtF0fjMF+qKVo4FI4FZ0eRIwbp9QWcD0qrXR/HN1XWZ6qfJI9m03zri29S7hJJg3Was2yKoSQ5tBUObiXTY5K2lTL/HQjAOXrrSNln5mj3ndeFaey/MebtOOtg+emP8rBq56Bv8Fdn9hjNZzJ2Z4WujVv0DZkRNzOavxRC4thlEjgCPe1uzc5jXi/BNFMBg/zLsvnRUGX0YDePs6dIxE+E+n/BvpeIzcu6azPO/1oJiadI5u4lilyFVDa3ZnmiINJjU5z1sBldHtWAfaoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZWxCMHxBq10psO+z/7UwH/BylaF3BbYUrlRWCJ7EDumWAxY/174GmsTyQmi?=
 =?us-ascii?Q?u1eAXKeMsWF53mwUABF5QAqmBdrqsbrrTQemXTU/YdMA67jBTHNv0ROdF4/6?=
 =?us-ascii?Q?Y5bnnJhrhd8o/c9+FIfDwcZjTDEGfT8MXtDXBXjEUOd/unxohC2EAf8Sopl6?=
 =?us-ascii?Q?hpsg9ZVEJo8oiZx0oNQ/uEXZx500rGuVWSlEFkRjdlH67lDUVFTojryZg9NJ?=
 =?us-ascii?Q?jCe5c7b2IxUKXK4bldyd24fHMrmGOQLSb8WCAwO+lzaeXhCA4qcAkGAIH2OA?=
 =?us-ascii?Q?attpJ+EBTcdDPVn257UwHsogJQ2RNH+eA+yjn+HmHXf2z4BapRwub5ljf8vA?=
 =?us-ascii?Q?iwmoZLL6Ka19z4MzpMDMkSa1oTDR2J6hufTGFvtO8J9V6uwuG1HdhlR8X/N8?=
 =?us-ascii?Q?4gL9H72nA2/yx0vfQNkGcPuIqeKuhG26M/6tsFizz1lJWy2bXg8OPbvNKm6A?=
 =?us-ascii?Q?/Vl6rHKOtDcNFDL6zUH87+Lb6Vamq+ZE5IzZVwxvyT9vViyctPM1FDVe298C?=
 =?us-ascii?Q?owVj/nT8NP9etl8A6j9rJw1Pq2eJAmQ9X+re/3Bd2wMXAX2pGMYU3X3fplPV?=
 =?us-ascii?Q?me3XxbxoygU0DSCaoBOy+b9RlgokM9v1C6VEDsVubhpQBqP4EtMvO3vPkR97?=
 =?us-ascii?Q?d5db4MvFehhgvG4m852MonqJboBnhoX9oNnEFRpZCEVGV6p8uEs5VN+Y7qIr?=
 =?us-ascii?Q?yQZE9FLsFPK87VY2lldOyUIMEZ2f5mHIvu4NRqEQEImuCl61oJ1UZtSd/1Y5?=
 =?us-ascii?Q?JAtWohX2WdsGiAG8ACzDC46/HEPGbEPghZM8VFoFrJfxW9hIohSDa0AQ8bQt?=
 =?us-ascii?Q?gcuzZwHkUhPK/r2JAue3WgXXvpaLu9kTq157/ZKSEMcQA90WlUTINM50TJ+r?=
 =?us-ascii?Q?OjAPEWq34AteKjvFTfyYGYAJX5qOprQHuADuLu0aYwShYN7I/ZY2tBSn2G7M?=
 =?us-ascii?Q?dy6ODRhBPIUSjPV+pT2c2akeqAbHmwmH043x9VitBZPAeM7buFNf4+PIu73k?=
 =?us-ascii?Q?R6BF+t+9hV+Jc3gcLuWuDVCtVZ7PwREJvG6Zk/pxGjWFj2oGVpqgaFJA8r0r?=
 =?us-ascii?Q?Ce9o0qwbk/JWkvNzQKOcVSa0z6UND0ODfCMTaaFHi1+ps+LREWfRE33r3dhV?=
 =?us-ascii?Q?uQdAS58GYGN8nSUwq+Gb0dEavBlEiE6JcJcUqyRnUsuMxv4rQqeKc8gTixrX?=
 =?us-ascii?Q?p2xCsLT6Kn8S+3vT7aZiJJ3e3M/n57KZPMA3Po0DoGvcPnjItswiGbqjQ2Ar?=
 =?us-ascii?Q?yVyUJuWlaFoaM3ooxa8sKhgS59UJ6he+Qw9cJSCfXSySsVaPpWhVSqmuenBj?=
 =?us-ascii?Q?6QdXpRDaHVfKLNhVHZfiF/jyTdqjQ5MVByOhHVBtXfevHh0k/umplxRXMssX?=
 =?us-ascii?Q?3oHZF0jmmwz3Ubq/se5rGt0PQL0UhCq5HPQsDJtni3DSrmkafL33sfxHFLmi?=
 =?us-ascii?Q?uZD/vG72UBJGWNZ6O4oTvsdsr3eaZ4cJlTuEIKIZtf/ajOHKwOqRnhRihRLe?=
 =?us-ascii?Q?UtJGtcUgJk/DD82uFz+v9wxIh/Hw6JHUl7JqcHu5rjiQKAp88a4Zaf+D51qp?=
 =?us-ascii?Q?QTjebIIXi1cfqj92oIwxm38vBsaW9eds2VWYS1jxUzvRyvJatBNf08m0Urvt?=
 =?us-ascii?Q?R3Q32XdMUiTL+XzgpCauabV0FaJY/nhzjISetV4jsK6yDR6VfeuTQmjD/YSU?=
 =?us-ascii?Q?ib3WZTG428/paw4wQWLSMbcgPMh9d71UxEq0EgIS/jhOmUkiERfHBiFHlr9K?=
 =?us-ascii?Q?aaKUBvXfPVRn3JcLsxMwhM5+OhzODGk=3D?=
X-Exchange-RoutingPolicyChecked: RWcdrJmtbBgfKhZ43AVsolLQAEYXGrNCCS+f5jC3iD+m+16XN/XMp5E8Ar5CCiNH44JeW7gA86PmYlvMfKoAZ6dWsOYW18lVjysh/XMMzx1J9mF1iJDdRvV/ypqYOS+r6BxAR/Mz+ivLg5GY9MrFOi1/OLksvY77eg5DvMSqnLpPRYD7ejhadCYPIjIxoCCYuVlT+KK/doRe4ansR95H/+0/jjQYoPJF2+mKNTuJKlqJz9U4003/VoGoywBjvGI64Jmi8bPUtSPWEuvO4qbOIa/NRZDojfAf8+iz0VRGP0EJMjgsCcJZO+QEAuy3s2AghmKlCQtSVrc3WUnF4M/NGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d440b13e-38f2-4abc-b2a5-08ded35f9956
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:47:48.2400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqBAaxQw7vrKNezPp28CyDVSJBcb//fyDYjZ3r55V1DZ8f5y2JUvc5AEip9A0Jf6/AfQwQ4XDgWONr+CJ8itGF7TT6IzWXMUx2gYtaxmwbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
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

On Thu, Jun 25, 2026 at 04:48:10PM +0100, Anatoly Burakov wrote:
> Static analysis reports that a rule might have a valid engine but invalid
> rule pointer while having a valid rule size. This should not happen in
> normal operation, but it's a good defensive check, so fix the potential
> issue by checking for the problematic condition before dumping flow memory.
> 
> Coverity issue: 503774
> 
> Fixes: 215a768c180a ("net/ice: support flow dump")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
