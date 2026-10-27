Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156C606A331
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JUlaLu36
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2863F40693;
	Tue, 27 Oct 2026 13:01:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 30AA740656;
 Tue, 27 Oct 2026 13:01:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793102489; x=1824638489;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vD3Am2llZHOlHFV+vawnCkjrc+Mfwawuw/Q9n3WELKc=;
 b=JUlaLu36WHiaqu3Mdal7gdatlWekDx3XOJbndzhmg/wdKr0JRSc710B6
 9TDzed639whyXro+bPoi7Zi7u0/jij+fnKoR72w9iqwQ1FBy11NYV2e3c
 qSmWV+Ru/w2qh+k+rfBzSm1cz/smCVp7mwymhoL5pv/80hUuPLothzKND
 4d8XrbmXT0EPESLSubw6L6TWLAsG5ryBP8juo/H9f6MMxtSGbCDZyFBi3
 PVKHpeSdW7u/jXwrAn5U9eZRGxxMjU8ur46GnLHXNxlmefchTEFJsiZhd
 SrVH7d+7duNOXyXbxcfQzhx60dUWcjcOJa3m2+FkvPwd8Wz6rx6BJmig+ Q==;
X-CSE-ConnectionGUID: lpvSuMAVRLKKyQSRn8TzjA==
X-CSE-MsgGUID: 4NndB2TXTZq2be1htFnjzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1695045"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1695045"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:01:27 -0700
X-CSE-ConnectionGUID: BAiuzbQ5SxGnKeJ2Kdj2Vg==
X-CSE-MsgGUID: /mK9fFHJTzSdFIst8/4eTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6403095"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 05:01:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 05:01:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 05:01:25 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 05:01:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZRU/12FW1KdlFV/I1ss28ejiWwPvWm0t2cXDPouq4eLlIF5VwvahKNBQu533UDKqLHALwH0IftHyGUtOHWc0rmjZ3pUty2acl5EpFAVARjAycRCOCe4ze/R0MHCmabe/vLDuKpA7bGUPV4SzinEwz3b1uP/HnUZgzAGCkvfX3sAFzKkEj7yA5QcXzLPg26wjAAYT9RyVoupaVb9O/e/VNf8EeETCeAGMyoNKDM48vH/gSbrRnbX4C5KUgkTOyz33Bi6FPdLFUlJDvV8tiJxQTnMbWsd1q+jAFLM3gXAiQl/dMFhsVqfo/EhVoh8HF2Qcf8qiT0Q1l9UIhVzBZxijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RituIskR3WQuCCTMNX3d9UxQVtRErqSYKg+Kl8fLfCA=;
 b=hla+vOyENjlICw83wnaTkCCX42Z1OAHmzEp7Fl9YVMwDLG8jHsp3CN6IZmFICnpQCmO5ESkonawitU87UCB/Ac0tr2s/O5ZRpcF80u6uOcCckFmw9hVclL38Vy1O5xjFzF8CnGvoJXqX8VqpTeBNfEGzSXVdB/+23cCuDJ1GcmUgEmUXcriz3vS7hv/bR/htsjPq+Lu3f0JHy+fZAScRMDFlfyhz6A9k0IajBydLGV3MCbN/zBu2v7vLkNGSYtj8jjr9y0U9LSj//HcylEUlMkSmLun7RGAx1lcrmxyChIQevvOad7BUO7TqO0RFTh2Pme+ec2ZPkV2je0COkSPUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:01:17 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 12:01:17 +0000
Date: Tue, 27 Oct 2026 12:01:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix RSS rule overwriting an existing one
Message-ID: <auCSiDjFkBOkglWU@bricha3-mobl1.ger.corp.intel.com>
References: <20261026104711.175208-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261026104711.175208-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a4efbc-b53f-41fb-f3be-08df34220162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261026140227099003|5023799004|11063799006|56012099006|10067099003|261021121427099003|261009223027099003|261022105027099003|261022113327099003|261022075727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: wgAgrBtvqYjKcQ89+r3v/zws1XZ27T19u5WZhrRG8fNygY4CrNWT+9xClBmhiggBkebn1D+U2mQr+AJ3sQU+HU5IDfX3lRYIrfBsLjbw/lHnmwlNhoGuNC8J+y1+WMaVneZlYmQjHYh7xGHof51VkyWf+Et8rXO7qltOs5qlyt9bg+XWYG+taY3DA5dR8xGkzZOOgPSdApFUfV1ftBUjdNkcfSFxEnPikAiAcsPVtqCzMdf0HYossZrm94/ioSacD62BVvR5XH1N22ZjGOqyoEJfgQaNEJURdpMQiOyxyxt2TE8UU+2/9wwhhsdtTigaDxK1oKoNz6xIyaEDeR3VTTmV6nYswrpV4iath4wGNvCYKNfqwRARyuJ4T4Pii7sSEXKtKsfxm4wVwEYYRsqSeP3AvQ/mFCUmsf505roYQRmGGgafxnP5+7FhTxCTpIwrBy5RLqrMIFNuP2idZM8kwqwe/wBm+NUTgBddTKUUuI/RQaL/Yt4LMuz5WUn/3QAWmIG9EbdBEG8SsJwcA353WoqzNCeR/WUHJYsCmH39aqV5b5GVaKHZbvbLy2FkT3acKjGWugSaRmJ2aOXXkgQCIiSns3taHvcmlV3kxReyHLxiE/Tp6ZTMXDswQX507FZiVu98QquPyS4/zuqsqmKGuUeCbDHqHtOBdnwdu9ULQ8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261026140227099003)(5023799004)(11063799006)(56012099006)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022113327099003)(261022075727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bU5Q/hPIF11N5tK9fryRVzi6iz1i/hX072tWN6xLmcdb5mg5gU4nreiJc+lT?=
 =?us-ascii?Q?EsheyvSwedr4O2PfBy4tCflr1Ox5TdQOxXqZyVLhS286fSGZwHz1p8DHCEHO?=
 =?us-ascii?Q?UIfzQ4fSXav4CWkEK5orxSpnR7rrseAwFEKmHzPo6R0KSFuOY2i6vIQF7Xet?=
 =?us-ascii?Q?RHbI9xGYZKUVbzb4fDw/L1x6iKbU4AOKP9425IQ6Ev0Hfn0jRj2ORsFY/Fsc?=
 =?us-ascii?Q?oYs/rXoAFYnBUdCG2Hw1pEgCBGuSsp7c60gltuO+nhpIsllVIfh9yrARk20m?=
 =?us-ascii?Q?L/xL1yiy5MSfmh19fwVP1avEW7R7UFDF36NjnYwhpyTPL/sV/2m0ILBi9O85?=
 =?us-ascii?Q?JyjBL82pGImqNnnjIVSR3B8AS2mWKmjasvy3NGkbORdcrSHwouvzUDYJS5m5?=
 =?us-ascii?Q?2O9gIsL6kZYr8NK5tAPlLAxVbsmrtcrz7mu2/pR8RwDE+CREu4Kn3UkKGmSJ?=
 =?us-ascii?Q?nhlc2aMU55LuETV6L7QXeltEhqxi7ABz8G0Y6yADtzf97jgUEzeMkmSaCeXm?=
 =?us-ascii?Q?79XDT6tCpRH6Pc5MqF3Md3KcFGxfCfHulW+T3U2gtJZMKCPU0JrEydBazz/5?=
 =?us-ascii?Q?ER2aqc7Ml/FJJHCZ4hQ1NghZT/IdVIuxYgGMU3BKjhFlcFCysuJ4NssCf03g?=
 =?us-ascii?Q?xexCAmZbnIoTeJ6Gt4XbQZUKPZDw4xftWqgUoWnrUdXYh/DhAlFJP1CAHpxg?=
 =?us-ascii?Q?sfCpr9wb581JEZJG0KyL7JdYbv/3bFFwWMMTfU/bRlFiWhOjm4UHn8ozyGeG?=
 =?us-ascii?Q?mD/NgGjOMR6eMZOdaYv9Uv4z3YC6ODuK0lbbKpF29MMUQOVYYQtbOWTfQQE0?=
 =?us-ascii?Q?uyWZOzkNv535DCPU7kGAcbrMQGiHimiw8oVkLEB3tjqJnLBsmfnUbjXtQLw0?=
 =?us-ascii?Q?HM5eHMGIi2dY4Xo4GexfHyjiBAFbHGOUoh7SqF2OjZJGwSPH7c6xfku/Vogt?=
 =?us-ascii?Q?9ByGjKTLGQbCaTe4LQbVie1sbsG6W6AsHP4i5zxDNYM78xoAMnHOWj/sQZaW?=
 =?us-ascii?Q?S/C7dzbAHzuh4hPPxWGCi8kidYq8uS4zflWALK2r8CpfUjEQaMkiXIReJkvm?=
 =?us-ascii?Q?0eHKzHh30wZoL9c6x+FdnKsw4taXQxPM+2SVbJc+4O/vDJrTZs3GPZKaGIB1?=
 =?us-ascii?Q?ntUsliotl9fsa3NAaRfeELiBjuQGWRs+FSUCkrWWk35Q4pj2Bo0d4aYKEyZ2?=
 =?us-ascii?Q?6uUpPfDIdjp0e64s12uPgnpY7CKgALCM1N+IoWleKUyBiY/02f8sKsHuVS8G?=
 =?us-ascii?Q?9Pg/a5fnRc9BVly5pJyNOV12oqPPmpj3Swt23YMKAy1S/taCcmvRVK2K+Jbj?=
 =?us-ascii?Q?+D/R2zVkm2iyg/aK7Bz9dkc8Z/nhadYCHaPoLVzGiEMbu6BSd2qoaOmRNtZW?=
 =?us-ascii?Q?pPH+22E3Q6S3eid7AW3Iv+0HxlqxJZuToMWTpqhT7cgx5PyfpHRl0Yqpjjke?=
 =?us-ascii?Q?OpQVlfJlK6a1fx6H3BY3AfWTgitqsz/B+HF9eBXwb4vQn5pMZlIKurSEnSUt?=
 =?us-ascii?Q?gMQ2OYM8GYs5LJrwQbzzIzd4/zQbifoqVON5DBm4CPQCUh9jh0ay0fgU+bNV?=
 =?us-ascii?Q?jyRews1yqb3zHLbujflAex9lCvN1+JGOp5LnsyyLRQW8H+Hj+pTMx9YTxrb5?=
 =?us-ascii?Q?ier3iBXS33Ex6dMUxhA4L40z+X+rppfqhAhQECRse2sbX/zXa13N/7kVjcSn?=
 =?us-ascii?Q?k5ZpEM/kUCHns+Mo79wYcLu04Ws6yf1oR6Y0GL3qcVtyF0KmsQs91ECneEwS?=
 =?us-ascii?Q?XXyCa6ZjkvP5pY6ExDGJ+C7DY5TswuA=3D?=
X-Exchange-RoutingPolicyChecked: lf/uevmcSAiyLYESeKzN6J4rcFCQWUOo13PbCcqbPLIZMTpbE/dmV9SUodRP2gYvhC3KWBVmvs4uWOeoLKAnD+ypO0hucLAi+eSKxLZ1SvORvkCT4o7nfAHc4GTbtzaaYOfOsD0fQZXVyLjyAMfKRaREl9AlD9P7eb4F2RXC3lU2XMR6ZWls/7+TdXkEq4Y+X6oLpjSNw8Qu79Cu6dK5j/9VaTw49EYNUucMvxPF1k3iWuHzbAx6GEA13aR6FVmpH3m0JB54aHTNojiQzTywYzUZnZRt9EdZ1I3lMwZpmT80nMovpNp8kZsS1TnTVCwv6QV2gYVSfqUp1AgycsEyOw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a4efbc-b53f-41fb-f3be-08df34220162
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 12:01:17.1972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TxCv5aNY7qPNck+NwG80VKcyAJfIAtIJI67oMN+wlJXlQTs+aH91yAYFXho61mdIFZ9atlgD+cLPPkIhT4HyUopbpmKaq/Yc+SeFMqmpLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 10:47:11AM +0000, Anurag Mandal wrote:
> An RSS flow rule only selects the hash input set of a packet type, and
> the PF keeps a single configuration per packet type for the VF VSI.
> When a second rule is created for a packet type already used by another
> rule, the PF silently replaces the first configuration, while both flow
> handles remain valid.
> For example,:
> 
>   flow create 0 ingress pattern eth / vlan vid is 1500 / ipv6 / end
>     actions rss types ipv6 l3-dst-only end queues end / end
>   flow create 0 ingress pattern eth / vlan vid is 2640 / ipv6 / end
>     actions rss types ipv6 l3-src-only end queues end / end
> 
> Only the second rule is applied, whatever the VLAN ID of the packet, and
> destroying it leaves the first rule without any hardware configuration.
> 
> Reject the creation of an RSS rule when another RSS rule of the port
> already uses the same protocol header stack. The existing rule has to
> be destroyed first to change the hash input set of that packet type.
> Raw pattern rules are not checked, as their packet type is only known
> by the PF parser.
> 
> Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_hash.c | 47 ++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Patch applied to dpdk-next-net-intel.

/Bruce
