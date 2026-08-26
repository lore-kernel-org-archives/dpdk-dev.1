Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0332C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9A8940E26;
	Wed, 26 Aug 2026 10:59:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7B9BE40B9D
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:58:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787734739; x=1819270739;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v6K1McqiqaBFuQVe3PnOZCoBqbHLLptvQZeB7giwObI=;
 b=l/3CNpNO6CvVHtDbuGdLOCw97d9mMmtPTsbdvOOla6eUmuzF/35rOfrb
 /HyUuX+KfiR/upW6NkQpzsAVwUWPH7kxoqszM5NPHIhQWxoC5ks7BJSt6
 XBXUTV9whyJLpB82hcZs8iJjG7vH2o9QZjCgC4zd36Add7ALjg/mpp+uC
 2XOZ9iK1Rjt5Nxp1/q1KGgnlm3bjXkZKuwtVCnxVYmVNszsiS93VOEc52
 ldyb+X9M/xhDTBJNmLoL7A3BHr9IkCvLHdXTetJsN5jZsAl7bJvkh/Tbr
 MEBOwU6xfzemqKOcCWaZ7k49vD5Tg4CALw14dVUm1fO9J0IuOrZ/ahx1Q Q==;
X-CSE-ConnectionGUID: QPwiIxkHQA+j0bn0AqXfdg==
X-CSE-MsgGUID: nMRvBFpjQxic9dDOFUQSEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88340771"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88340771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 01:58:57 -0700
X-CSE-ConnectionGUID: qHzsQ2U+QR6mUuJmt+hwCw==
X-CSE-MsgGUID: fIT9QcwcRvO1fUlNbQOAhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="305748132"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 01:58:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 01:58:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 01:58:56 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.26)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 01:58:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsnBsMwoYtP/f45Sr4ljPPsGSyWmf3fc27o+0P0paP2flzbGK3hV5WLBY8hbXfsFJOGxEqHA3tSgi8bsS6iZ0bj/z3tUjEBWjtTR+8m/J38Rtrc5XDaDGc4e3GIeI/Ay0Ct0MPcsImAnfseifzyDSn9zupAJKcIj0ffE7IVni2lbM64pFimtcvxuhSRY9LI1EFwIa6lSwPLjSQzC0HkH5TiYR1lo4HevZoS/DAObya3xG88og8kqRcY5kGhWRdLPxfJz5l8qiJAQqTtYvYPcNNSku8CSHJwvjkPyte7JeXNWVrB3ZoK6uakQo2rdnZFK3zSFCnBfyPICqutysvp2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgi2JBXRUmxRpapSAgOVMOJPanjLWu4gSJ9OieD2RmE=;
 b=fTbZf359ZG+tTzfOaTGNgnVii2hyYcjpJcBscdsaF7+kuQ8yiJ2iF8XQT0mu5yjJIZ+AXvrvJ3mWVGrcx6ncUoc6Hc4uq0wiFb/MWUH4nD9Kd+1ts3vo65GQy4nNWHs8vpg9vSbFnXReIvaE9sD4Kzfkczy/chWRZYwAJlTlCzF5tUc/9WzRv2gVCDvX03v5kJuTnfkkKLOcjvtTfijwuNuNzeIl6kaLeNjvGnbnf/AIjGnJ27myUikWcF8hptqm6cfLZ3nyEctOzi9jdnevtP9x0P0PRQDVG4suvibBrqNxsbxea8MrLFfVsYxMAojWgJ5vaFp7aHaUAAINQwgKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Wed, 26 Aug 2026 08:58:53 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 08:58:53 +0000
Message-ID: <dcb80f5b-31e2-4f64-8d92-f4f4783393f4@intel.com>
Date: Wed, 26 Aug 2026 10:58:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Ori Kam <orika@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
 <DPk1E-kwRJqv9GCxmKhBVg@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <DPk1E-kwRJqv9GCxmKhBVg@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0033.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a79ba1-18d9-4e1e-a23c-08df035040b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|3023799007|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4WIONDvF9V3hv7zQUxy5gbu2H+ij/wwCF3ZyLU/oYYy6Qx+wjboOQMBet7J+Q1Vny2yDJ8RcQN/v+O9Xf0E2Mb6D3K4jkzB0iksP4e7GnrjiCD7P34cfeiz1jMriq+oH5Gt7/r8ySpqTiXx6XJMFBXohNL1BAsFi5bRVNxWjfLGjuENxyaZeouNhfEfRhlJUj79F5ScrDVFQYoIWznUVjRD99M4Y5hB17GogzRK4LXBDIJXhKNphX0sYPVA9ItqfcBVbIX/yo0tfgyz2K8ry0Yt5IIJ7DYGN53uGEbB0E2mQ/Sje9710DTLdjBsw03aZRJxvJ234kgbT2NtkpF7ato87E0Czq7tJ5LXYOg7Q9gEO/Bvy2l1go74tIy7SeDYRI69Hw+vO8YGGr1i1QeU+fikrMb+Q5zeX2gaUC4TZPSaE+3YacasdOMvxeMaWfpngpZwpIfUczWZQ0nQxQkbVPUxaIXgPsP3OKmpTJAeog2U4o3pXtFp247QaxeyEL98l0dITHyrxHVwG/NOH0mQq0AiFS5ThUZDeIu7bX5CAlss/l7zXQnFIxTjiFsBw4AgtnooffdMKdMULCeYwmUuBFE7R6KoDGZg65SYtw/XbV6sRcgo9V/unRSdBgOXJIsIl6o3ATUhSiTuJzLyF428h3kSi4X7csrXYFUxma56w0Sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkNUbWcxZC9ZOXh0SDFEUnpXYnVZQmxiYlh1R1FIU1BPV2ZDQWs1RC91aGpG?=
 =?utf-8?B?eE9CWFhZTUowQmdJMTh4RU9hR0pLS0ZSMFIwY2Y2UGh1SHhEZW9IcVFBajZ5?=
 =?utf-8?B?ZnBTcHdnWjZiZFRVeUpjc3ZZOE9FUGVGQ0Z2SEhGR2NzR094TS9XZ1RLWDV6?=
 =?utf-8?B?cSsrUUxiWEFBTzE4VUloM3hlZzV6eTZvUm9zRU5rV2lYNnRkUjVFTzMxM25q?=
 =?utf-8?B?SHljd2lNZ2IySWFqYVMvUjk2NWh0Y1R2LzhjbXdId3Q0c3NwYnpIT3c3MlR5?=
 =?utf-8?B?OFJybG0xWG11cGpCcGUyU25FWVZBWnBLL1B5UnlzSlVQL3RMRjQrQ054TE9P?=
 =?utf-8?B?ZmRqWFhydmJIUDl5bHpFeUhtWFFXRThXTkxpbTdaTDV3Y2JvblZYc0xhbWpF?=
 =?utf-8?B?MWdqQ3hlb2pSaE9FTCtQTVI3ZTZIQlJzUVBld1N0SjhUUk02MEZGdlFjTkxs?=
 =?utf-8?B?b0lnMU5lUG1tK3VwbUNTWXlXR0FtWUF0djNVWFlCWjFYMzU3NmVWL3pzMm5Z?=
 =?utf-8?B?ekRSVUJ3My9yTFozNUxhMlZmVy9ld1A3UlZNNzZ2QTdBTlYvU1hqWFNWc04w?=
 =?utf-8?B?R1dQdFdiVnN3aGQ0VURjaER2bTdKZFVNcFVQWTJOcTFtQ1NZN2dGVUNRS01Q?=
 =?utf-8?B?b01KYUk3bmZFcVRTQ3NmUzYvMmE2dFVsc29ZV2xXYVB2emEwRGpkdkhRUnE4?=
 =?utf-8?B?SEM0WlliN3FuZ281MHoxRnNlWHZSd0VnTnA5SmVBcC90RzZoR0dMYUZFQ2JV?=
 =?utf-8?B?eE5DdlY1THByWGllMVZsSGZIcFJLc09xZHBST20zdm5IYm1GWFZlZXRpVTAy?=
 =?utf-8?B?aFB1YlE3RHhGYnRNUHUvTHY0UEk0YnlHWHhMZG1tZXZ5My9uVzl1b2duQ2Fm?=
 =?utf-8?B?Nys4QlZtZ2RoV1AwRXRJc3N1cDBhaGV2eDViMXUvT1NLcll6WmpQeWZPSXpl?=
 =?utf-8?B?L25OMDR3WmFGS3g2d3N0MkVnaC9iVTg3ckkzd0d2MGRJQVdyREVqdmo1bVNZ?=
 =?utf-8?B?TWNWQWZDbzBvUi9BNnA0bGdoL3RUWEhOaHNTYy9lOFgycWVCeUE0NXlUYjhG?=
 =?utf-8?B?SGdLcmkwRDRMSE1TMzNFMmJIc04vYmZybk9tVzl4blgrNE83Ym5xZ0lkRUxZ?=
 =?utf-8?B?aFR0bzB3K1dEQ24xa0FlQXJjS2hmTmlYYXFNTlorRWZrQUttZU04ay8ra1Bs?=
 =?utf-8?B?OEhSOVhMY3h1VnIxSEdrcUdMbnVHNTBWbGpsbk5Md09Wb0o1dEdIN3ljYmla?=
 =?utf-8?B?Yml2MmlWYis0Y0t5U1BnTzlCT2pkSGMvbmFtck1YTHFDUVBtMkRoS0FsNW9u?=
 =?utf-8?B?RHhBeGtOU2dISklRbUszU0RtbzhNUUVuVXdudk52VDZkUm1yd3pvRlpQKzV1?=
 =?utf-8?B?MkkvWkhXdEQ0eG9ObmNLTlhSbHVhSWU4RWpMcGNvZXVVRnBlMytrTXVaT0pM?=
 =?utf-8?B?TkNFY1dwdW9IRGs1S0VXaXJNS1ljT0F4ekpDaTVaOXZMdzR1SlY0MkRZNjNI?=
 =?utf-8?B?NDVvQWZYWXdUaDRwUmQwdm9ZK3BQQzRsMXI2U3YyUkQyNDgxWEsvcDVyVmNl?=
 =?utf-8?B?N3gzZ0xLa2tjcG1IYjF2M3dvelk2Uk5UL1d5STFRMVpQVDRsSHp0T0xBYU1Q?=
 =?utf-8?B?N0gxS3ArdndLNUIrU1VCSzlNL1RmMUNYQnB6bytMaHFGbW1mbDVYNy90STZt?=
 =?utf-8?B?azltZGZnME4zd0RTYk5lSVU5cHJPbC9wYjFRREMzejRHN2pmNndISVcrZGxn?=
 =?utf-8?B?OVYwYk85MlN4T0tDQlRKb2xvbWdUaUE2R0tDRS9Qbjd1QjUybVY5a2ZvQ2pr?=
 =?utf-8?B?bnJsN2dOZFYzTjY1TVhndHNOcityb0dNWFJTSFdYN1I1eTFpYWltMUJYUjV3?=
 =?utf-8?B?VjNpOGw5Wld0akdYdkZ0aFRpL2FLNEtYYy9raWlDOTd2VkxDSVg4RE83NGZh?=
 =?utf-8?B?aWZNSElqVVJTVC8vaWxCOFNZeDN3eXVUTVdQNDkvbGR6ZlFJZ0xjNWVKNzUv?=
 =?utf-8?B?ZnhQcS81Z0tDWW9HR2dFY2E5ckNOeGZuNjc2TS9icVlDUEpSVmxFenY3aSty?=
 =?utf-8?B?bWo3SkV4bnBvWUdSTi9sRytBQi9MMnNoY25JMllCeGNhTzRJVFZJWlA4KytY?=
 =?utf-8?B?QVBDbzZaaGVPa1pkL1o2YVppcTIzbTIrcmRROVpFS2ZuclN1bnNJckZlcWVN?=
 =?utf-8?B?aUl6KzZDWS94bFAyaWY1VVJWN1N4VHYrUDIvR1ZHUmVmeEZvMnhLRThabUNI?=
 =?utf-8?B?ckZqWVhwMVUrajRBZ0wzS05tTHBZalZ2TVVvanVFVGt2UFAycjZSMVFscUFG?=
 =?utf-8?B?amhSZEVpdi82QU1PdWt4TEQzb2tjZFpIUWhUcEJabVljTG5LQ2NURjFFVExa?=
 =?utf-8?Q?VDO+EcjdxsqS4W8Y=3D?=
X-Exchange-RoutingPolicyChecked: tamEFE2TBdJv7K7UT2hzmArW5EXFqL1GqoJZBi1LgmGxmf5QGYMWSkL27/3PcRIEwI5TaEcfYbSg1gJzGPRcMYqz9tSLvnGH7qsPOU4IvLhWSVuU97qlztmCsNB4WggKNjHJi8LXTpxz9CSgJ75KTxVCghrvrsFUGk5cB1+t6Fb0hCm+P0SLgmoLt88pEKQ7Z5HBzPn7f8xksQwCKYHYdIFY/aNToc5w9eQsxqG/tGgQ3PsLK8sakSlHvS2lYXRGprbUGt1NKDp90puXMhsKr9ju0//R7XMNy3iNPqe0C1+oZ3UoFnX20E/Uy4MJelY3P3NphKS0jL4Hlh7e0eYJdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a79ba1-18d9-4e1e-a23c-08df035040b7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 08:58:53.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/UF4KXeUaM8e5E0xKj/T8w2kINAEsfpe/26l5up4wrZFAVPWcoF5xRXgFHISLA5paJI4xNFN4SR+KPcxGZq94X7Lwd2mT/d8wVzh0GsLlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
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

On 8/25/2026 3:55 PM, Thomas Monjalon wrote:
> 20/08/2026 16:00, Anatoly Burakov:
>> This commit adds a flow graph parsing API. This is a helper API intended to
>> help ethdev drivers implement rte_flow parsers, as common usages map to
>> graph traversal problem very well.
>>
>> Features provided by the API:
>> - Flow graph, edge, and node definitions
>> - Graph traversal logic
>> - Declarative validation against common flow item types
>> - Per-node validation and state processing callbacks
> [...]
>>   lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++
> 
> Are we sure about the name? Why not "parsing" instead of "graph"?
> 

Because it is intended to help build *protocol graphs*, not *generic 
flow parsing*. I.e. only things that lend themselves to be represented 
by a graph would work with this - things like conntrack wouldn't. So, I 
feel like "graph" is a more accurate name for this, because this is only 
for enabling the protocol graph walk, not for full flow parsing.

> Is it only for drivers? In this case, no need to make it a public API.
> 

Yes, it is for drivers. It is not a public API, it is not installed into 
public headers. If there is anything I forgot to do to remove it from 
being public, please let me know.

-- 
Thanks,
Anatoly
