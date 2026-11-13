Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA5606A32D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AWBMttAQ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VjXh6tt0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4C3C402A4;
	Fri, 13 Nov 2026 17:37:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTPS id E4F654028E;
 Fri, 13 Nov 2026 17:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794587862; x=1826123862;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=d1LJIw2FBiVaKrcwe/drHokirMbOxEQUybgQhR9DRmc=;
 b=AWBMttAQ6oa6ohN7pNknQ/uxFMozBxdAoN7yPY2i29ocmLzxbeh6pyIl
 qO4pbp1b7kN4Js+rorPmtKq/1IJMQ2iMAm79YM4K0qWV0eHouvyXhhPHn
 KQFR1pjqo+fF6P2qB3qwXtVhWj5MCiNTmuNcUJHM84rw+8uMpl6G6zgC1
 kGiI2ldPZn5WJ87QpkakHICmu4uFt6+fPoANyhf5I2GX/Kl2o3jG6pPa3
 0Hzpi9qY8J7mCfqmZExm/HtWf5ROnSgKPcXHYsz+yUbT8ksXUJbu3fgBJ
 iw6K1U19PlR7djnfAVUaC/SIbq8SODG7SZ4SroBEAREBM3lcXl3C/9QhW A==;
X-CSE-ConnectionGUID: Q5BnpzIDQl2XSEdyrCm0Xg==
X-CSE-MsgGUID: VpY0Tzi5RSynpruVbeMS+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3429644"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3429644"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:37:38 -0800
X-CSE-ConnectionGUID: iM38fo9USbq7u1vK07KTOw==
X-CSE-MsgGUID: 9kKR/PI/TUmEDCwbY5oFpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9502809"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 08:37:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:37:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 08:37:25 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:37:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxQgHf/uV8HbxBwYFGwhUKAQuuTt/LcALUOrgzUrBjMuqt9SaDBAN2rasCO4hhZC7C0k8qyPc3B2YCIw87MmOUsyV3qS2eJSvjqK65BdiCQnavqYP8kz00g/YuEkQOJoO8VG6SRlxSdiqHpRXCPWubf7/5dBuHUcv5cQL++LCwuoyEVRVFHLuO19RXwmaiivIP8f1ZYJPVTe2jaWkzYaqalNCrcFIEcHI0e5bpmlaEEBRftqvM/f943/CcjRaOHwL/z/bEYzvMZTw03H+I7GCTtUBz+s0kgZwilkKtgEB3BjVytUTYsFQXWlDXlEisez4clQlV2RUeNv/gJU9lb0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRWj6G1ttPPF+pciXl0ApPwYrCT70fyOi66MT4tv6v8=;
 b=aoXAn3kpvrN9MqeliB0I9QHvjs72pifpBCLfHm2k6ZT6ZtORe4/oCKofrXTni8FifhyBQsxiS1AumuzfF5+m6N5wYz52yS0heF0rI0EPLU+EkUNEmHtGrd9kvgPvGAFBsptSbLkJXErrpZvAxSpIHF/gfr11W4ZATWRUTnkhu7OKVpExU0zkC2PhBrKMDSZEwrDNUxH6TwdSHvnOyWvtD0JIZz/YdHIAfInuqFwq0NfIm9PhBKXBSGH9383xIs9wz5Yda42HNKEMKkqFp+T8FQLAj/22Xnz3fcvgdJdVOzA4JaMPGU+8a64WQeAU0IFC9xVzjtolqC6U/Ma4B2ACzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRWj6G1ttPPF+pciXl0ApPwYrCT70fyOi66MT4tv6v8=;
 b=VjXh6tt0/iukgzQyltrJngR+cIJx49WAZeRfnbhsxQu2cU7L0Iu/yzBkpHYgwVxHQa4+LD083DHBYeBhZz0CoJ4MiBdgDbJtOmMm9k6+ekT+uaI3hnuuRGfVuzEVhLuePW9GSnGslnklP9Nt8/54cTufQaqXoRqRUWttLFUeSHk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 16:28:57 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 16:28:52 +0000
Date: Fri, 13 Nov 2026 16:28:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marcel Telka <marcel@telka.sk>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3] net/ice: fix trailing bytes drop in get_module_eeprom()
Message-ID: <avc6wNzhYXVZxLfg@bricha3-mobl1.ger.corp.intel.com>
References: <avXWJrAYifpAF9nJ@telcontar> <avbq3hRC0CYC4f_q@telcontar>
 <avbsHttyFMKKCcmj@telcontar>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avbsHttyFMKKCcmj@telcontar>
X-ClientProxiedBy: DUZPR01CA0122.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d32fc37-c78f-409a-9d08-08df41a33473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|261021135927099003|261021130227099003|261022115727099003|261028144727099003|261022105027099003|261026135527099003|261026140227099003|261026121527099003|261022113327099003|261021133027099003|261022075727099003|261021121427099003|261026130827099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7YJzIyhxRLMlv4yVh1eXvK99H3p+dwqHv7k5faFkp1iMi+QA1MjvYf9MugCaKgo42zQESDXXwEGsUNSKI5NqBjcWwsv6JvmFcyQVqICakfVsXc1Iajt5GQKXlPMEvP1gBoqb6elwauix6aIuzlfJFxyM7WAeRJih35eas6kxt9DwdqZUvjaXdNy6mPKWmj4VubedotSey3OGcNfS7RKu5NBkUyaro/XNmZ3NAinbvBeig2j8PLJBR0zNxAtFFhk4Kw7Jn83tIXD61j1TGRmv8kYo5niUX1P9Ztam0jRgOnOgFQiDxqHSFrNeYPwtTqWc6PwGNtaPO0H35+yfyQM9qvmruXZC6+LWz5We3qGJEtGbMh5pJqsfs0QijH9l3yYaq+CznesEGZAAqx1wtYthTHAiS9uYpyDf83K7VQUReK999XYF9v93iGIo0TKmEew8K4aLk9wkiWK2oixotJU35wEnC22QdsnPmDA9CkTfQ85+THxVPaFtgeRUvBuyKe+GmBOz2vJ9+YJanFhvj6Q2JNXvU8+0h0w3q/+/BLCq+0cZpBSoOKydeJvJro0ziOcn3PeQXakNEb5ZNpYnwSf6BYxXTAYaXbzQaRpouRSPbsOK0anyTLwXcgcFdFjn3A9HbON7TcDfZgC7so8OzRDD6A9WZb/Q97B05B31qK/rGac=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261021135927099003)(261021130227099003)(261022115727099003)(261028144727099003)(261022105027099003)(261026135527099003)(261026140227099003)(261026121527099003)(261022113327099003)(261021133027099003)(261022075727099003)(261021121427099003)(261026130827099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPYD/62GY3EiXA+wuqDNCm9IEW7Iue4Zima81kafCS+PrjYsl9aTAaPxVi7K?=
 =?us-ascii?Q?RzCAI1i1T+tYQcpz1PBWTTnubUkcUxcDi3F6bH8oLz26O3AnmV9EVC8u7138?=
 =?us-ascii?Q?c/jmgW6/7sEnO3xqSLa8VNXqtsRQlrhXZ5C70nKJaOD75uuScz8TN+kz1RHP?=
 =?us-ascii?Q?EvI+31xWDqBinKaEObjrVPuLhuErTQ9JchmqNmw+vP+9wFdGijal+MGCrtVt?=
 =?us-ascii?Q?S/0IGy4xDYQ3EWVrA6omHeJSxMp3hENFxytQNPsKwWnCfe4i7hmjyq8J0Luv?=
 =?us-ascii?Q?OFNUddDmJ1BoeBBFtQ/ntQ9/3hcylhOyNAqd+bc6unNm4nM52RX7oIo+3nLK?=
 =?us-ascii?Q?7XjZ9kZMcAsdaqADRV66Upn8x3tbahGpkwssGlAEuUMmXyP4tgEgRx+oBTSp?=
 =?us-ascii?Q?g6iwolJ8Xohl6I/20iB3LZ5aM5/pPnz0A4xsOYpz5HP/scYMlD2NJqRconyI?=
 =?us-ascii?Q?/Jp9t2eo/CTIm6PFzSMmwz4VEgn6Q7CSjgCBO9T38i8wJSdyVZyyDDwDW7RL?=
 =?us-ascii?Q?Lgw+jiJz6QuG18N0xI6sagOiRu6mGEHhvg0lAHclaQP7WkNyoAnPsUwqADHc?=
 =?us-ascii?Q?fTdTl0kQMuRM+nPi0nyzrE5D/n10xjntWZQHMulj1hQDJdrO8lx3qMFO36MH?=
 =?us-ascii?Q?JPAiqibHngqwc3nlth7SOjvWSZRC4OGhYjEWpLnfs9TGpHL6u+TZv8zN3tHm?=
 =?us-ascii?Q?VuPcZtvjvzyqRi+CjOIJUNfasgBJ9ujxPw34hgX42coRgFvwxavsc+Ah/j8w?=
 =?us-ascii?Q?dXoZXW4AMcauEodHEq/I21IBpx2YOyOE2dtd2AirJ+W3sGERyaQhdatKAFch?=
 =?us-ascii?Q?PErisPgFjYhaW90m5U33iRZHaK1N978JilIXBSyWmC3ydX6w2YziDe+ex3xq?=
 =?us-ascii?Q?eu5gk54BEfLmPomT1+JqZM42ibzxnbVPfWnDF9UgcVrAbngu+xiqYAHNfvb5?=
 =?us-ascii?Q?hc/1aDx9WEg/I0mIIlqHH8S6E2YYW3w5saEgjA3bkzc/u7RSFU5QVEHiJdZ7?=
 =?us-ascii?Q?3sHht5E9BezZu0S30dUKMzkSxVyTIef9d2eae8uQL8W566pnswigzU0Bgzpz?=
 =?us-ascii?Q?jjzuZL+/+vMxjzV3X0oy0GHnbkdOTgxG75lu5p4JcKAZ391bdBE3Wg0RLtSk?=
 =?us-ascii?Q?BBZoa8EDzxsCWuC8zI0VCZ/djO3zlUDcmfw6iVJIL3A6L+8KtDLpwGxIN5tK?=
 =?us-ascii?Q?9KZhmpk6eNER5d56Sqw/VzjuHCDhDsf8vaAIazVHiAfkxkqU/jtCTQIiwx9q?=
 =?us-ascii?Q?mvQIAH129WjbpItmc5q4nYhCR6AC1NMDdUhXQcqbsn5Yyutzo9+CfGHYEOOe?=
 =?us-ascii?Q?+LwJM/+cwMrrq7AAkttllV2yzjDUQ9EvsbZkoFgO5euAvBtw1ynwpzPVljpL?=
 =?us-ascii?Q?6IHgWzda5b+9ZIVt1zoJ2VGV15/BA7aGjmnPYwS6QaSUrtPSWHkdQmB2Yx+V?=
 =?us-ascii?Q?0GiwdbLjKbesXjlJTB+G5ac5WcXkdx2iaeL3pLUkr8nF9C6ko4sKROFph/Mr?=
 =?us-ascii?Q?Fsnd/UPEi9Sp0NKOM0+vlwsYyYHyhq/eLDMQeUh6o7pfrevshB8nL6sEdRS7?=
 =?us-ascii?Q?d97gKGuPfFVcdA4f6+ZOOK2GiLRZgifp9BAwoID1yqk9W2vaRKAr5uJI/8Bf?=
 =?us-ascii?Q?+AghYzfyUtzlgzKlsfA3jPjF8/3XJ1dqvk71rc4Df813YtJDPv5DLmmUHCKW?=
 =?us-ascii?Q?keWTv4ycGo3UNSkZmfN+aeejbt2iDyL4yj5dPWB3HwQ74+tNWm9pXkmW7oqg?=
 =?us-ascii?Q?Ji4fu/lCt4+B1nQzsVoJFfDMEFi15YI=3D?=
X-Exchange-RoutingPolicyChecked: PoXuT+1Czwv6niEJC6nrQ/htD+Qa/OLWipJE8lfJJwc8GZN9A2wKGSKAnS7keF48OP6j3Edw0Xv8HFiOeSpje9ZjLFEaNRIIwQw6rpFSdUj8C0agKrF2SapL42gVDleLLsAhQIefx6hXjC3u0NshRx7m0JfbMYfFSJxJOyYJSes17qacHq+PS9arHTCRta77RX89eqGk7CUh+iqCxrUd/CQBR0eV8cULU0iz0LSh6m/RTnu7+y3S1YEfyNAb1chkNFXlpHSFOEd3ttR2SIgSijAB+bTu1q35oAoQnCsqCyr1wMgrqdGOZ7VjC51zwC8ZDDATfT6U3JqS5cvueIWd4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d32fc37-c78f-409a-9d08-08df41a33473
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:28:52.6675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne04R6tdIyDvD9U7TIBBg4PybPNZNgDJsEvKvh3j3RaJAaLAE9uMgZsZGfTmkC3r48OQYcJl4zfa879BIp8NWtiTQF3IpbW/CfSaCHuCHls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:53:18AM +0100, Marcel Telka wrote:
> When info->length is not an exact multiple of SFF_READ_BLOCK_SIZE (8),
> the final loop iteration reads the correct 8 bytes from the module into
> value[], but the guard evaluates false, so the memcpy is skipped
> entirely. Since the destination buffer is memset to 0 at function entry,
> the trailing length % 8 bytes are silently returned as zero instead of
> the real EEPROM content, with no error indication to the caller.
> 
> Bugzilla ID: 2091
> Fixes: 52569256583a ("net/ice: support module EEPROM")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Marcel Telka <marcel@telka.sk>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
