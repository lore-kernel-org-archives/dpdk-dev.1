Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A008FD8FC1
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:53:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88286402CC;
	Thu, 26 Feb 2026 15:53:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 088384026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:53:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772117598; x=1803653598;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9sccayMzPRcZv0kfWxyIKW88Z2O1j+RkziPqvgddRVM=;
 b=XU+UxpfYzwZ5Iym4/LT73B0TW5OBaNVowcz082t8twm92zaLWdtcSZTI
 e74GLf1IprVqnUo0rL13ZlormoU5vnOa6omWT9dpJHwJEmjxrRbE3tnXp
 ACD7tc3e9sS2qerZ9VloRv9PQBEd5w7ZOqFw/wkMiPIxQhPGan5PsugX+
 R0qH8J9hsKcLmWxFhn8xK96pUlOSp7sWgHgDAxXdKL7BFWloRw6oAVXYL
 PvbtGBFeJvQI0CYehO6KO4wmMJDh/nbTEik4O14tcQBIkpn/HgZ1ndKZz
 Q0aWkwaeDNxIje4Yde5vMp530tSOQIorT3iKDLmGiTbi5zc4TZ60TGJVA w==;
X-CSE-ConnectionGUID: ZYMhbeQ9THKrd323ZLB7Sg==
X-CSE-MsgGUID: FB708zzUTqigUxyRfhO2yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73224807"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73224807"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:53:17 -0800
X-CSE-ConnectionGUID: 7sQA3I4rQZ+GpuOok623Rw==
X-CSE-MsgGUID: z+j/+9mCRZmoX9fKAU+/5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="214833534"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:53:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 06:53:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 06:53:16 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 06:53:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFkfSws85UPlC4opNKpMZIv/1sKtcNjkblwSCdiYhXPqL9gEQdC+CLx9ObMkJyiV6aX6UuTXrVv1J1ym6AC3qDZRQirbBw3fsql6I8ZiIHYA1/wlF3ETX/1MtZqDsP2WjqQ/3TkdtpiidHoAzbgKAowLIIoRMRyuo0fGrA9MaXfmnEBLjdpvllY06vblPhcJq/b963McwZ+kTxzW2Vdny7oonWtZ3rXm7884RDwN2cy2sfIJ4lj4HschowS2V02V9gLSHatK2ui/K4qyqBr2haG909u+ejDXWJJ6jtB01S2VWq8+TnGUnsMPVLCYEoYjsOsOLk0I9HYY16gOmmaR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPxNAXJToebcKNxK81+zc0XBPimYhl2v1+bXzIIcSps=;
 b=IXvOdNLX6n4eRaYAOCMfwR1+bJ6XU8PaKf468KhUX3pX03gTHhx2Ptfr4pFWBS5ChEIS6cQ/RJuHleZLR/w84AQriOOzw0O/t3UWFfywaNFOEx+ZY9tGjvCo76QMNIQBoXteBDxKISE3GzZMlYQEz8F4Eyym6pizY207R4ks2yK53GOJj5JSuS6eJz9QErHBGGpG8HCAPsMA8qxXYhUmZr8nOwIJV+waLYoHZ16AA+1gX/u3VuIylj+stVLBTtue7Z1RrwyG/2LmNubX+QiZljfLxwJtTboIXihqeIvFdMxyvWcG6Qwmc2M4+rLeL7S+Cjifbr4Fj43PbdCF+gmzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 14:53:11 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 14:53:11 +0000
Message-ID: <431e978a-1763-43b0-a2c9-d285edbbfec8@intel.com>
Date: Thu, 26 Feb 2026 15:53:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cryptodev: fix memory corruption in secondary process
To: Piotr Krzewinski <piotr.krzewinski@ericsson.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: <dev@dpdk.org>
References: <20260226135727.4171394-1-piotr.krzewinski@ericsson.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260226135727.4171394-1-piotr.krzewinski@ericsson.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0203.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::28) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f3b48b-f98e-4728-4fcf-08de7546c313
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: ztZpzvWdOLDawzGca7pAzK1ySgO831vUQZwixnm5yXXnITeB+mcK/DV7kKqBlvdnFtINM4lcXvQOEvUwcJUPdEHGu6A9UJQ6avr8aQaMBfwnnEqEXkzOYtex2muMtDDY/hTMJ21CmbjLH0jshensidPxopwKVuFoL+tL0OPRFIBBSk09BI/REIOFpLKdZ8dqv8EdZJYdQlQDZbl34Dd/7Bwo8LQIcXEYY75+nNnJD1j5w5u8TMaX/VfCcSBoNVXXiqbdU/IH3dnJ2dRbf4RT4ca/B0bpl1gDWhBzupdvj/yX4zy/K92f3NFfXrjrQ20IE/eKPtg7i+jhOeH1nIs8Gt2U4Y6hX1Wfh4S1FU4t0azpbJdEYBmaSJJfQzxuEqzYZozsZ9zss1J5qkP/hMDAsod/dYaqop35dqfgQ0ekIOCa0O48zFA+jhyKuKq+F5n4qjL5gJsVl0kNaalw/yiEa0C0ijmo9Hx5onh3dn3nK072VqnRfmgoUCezJggpRpWyCkHfqn1/he2ipEUobRUXwm3VQiHyubLIit0GjTZEmFWo7BMNDdE54g14PIijYXS2Q1ZRsJy8dsI0jM5i/DwuE7klKwucpQ8wa83V5XogpUopu1MWY55IUiJQBR3iuESfGu78PhjwWX7ptYUAA6iI0H1ZsHFnovsMwcLkCSTroWxOQDsGZd55Dm5b7NPkgP33BO5gIzcoFxGDRdnNrn3gEj4IAaNVBKXOnIZPVC3sTtA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWs5NUV6RVJOTWJyYktDMFp6L3AzUGZYbC82Ly9qbjhxSzY5ZGZKS01iSDVV?=
 =?utf-8?B?anBOTTVncG1mNnVSUmFHdmJER241QlVEM3EyMGF3RzVzaEJzMHJPSVF4MWU0?=
 =?utf-8?B?bVhwcEIvdFJnU3VlbHg3ZjMyQkI2dHhxM0hic1NLMnNDQ3pjdzF4aXdSTFkv?=
 =?utf-8?B?bU5SbXh1d3o2bnlSaFUxNTRqSTFSbWU2eDZVTzVXUHQ1ZkVzMHJqbUR3OFNW?=
 =?utf-8?B?czMwa3lVa0llWXJSMU5kSkk2TkxGQUZXN2owdFhUOFk4Zm9IR1pxdWd5cjI1?=
 =?utf-8?B?Q09XaXllS1RZYm1ZOW9HZmcrbTdyanlnRW1jcS9nSHFodTFKNFNCZVhUZk9H?=
 =?utf-8?B?K1ZXYWhNZ2UyTWtNbVNjaUc5YWRwbWlpalBZWTNUcGw2MCtReS9aUWxHL1U5?=
 =?utf-8?B?b1dMOGdtdnJoQ3hSOXBJdExFWTByaU9MYVhBWFIzbE9hVkNyNWpjMTBpaXlP?=
 =?utf-8?B?NlRtS3hiZ29zWE9NOUVhcUtiNjRiQU1pVmFtaGxMVWtNaWtNZ3BQRnladWl6?=
 =?utf-8?B?YkhMMGlwR3NXSlNMMlU2WEJhenlkY01xSjJNaXJVYnl6VVExRjcxMm1CSU5k?=
 =?utf-8?B?VEdXNEw2RGpocFpxalJrcmJkbzhxOFRpQkJSWVhuMlA4Y1k2dW8xUHgzS0pB?=
 =?utf-8?B?TURFUUNCMjdpNEFoMm5iak9JTnlQQUNhSjRGc0tkeDV1WUJkQkZBakdhdnht?=
 =?utf-8?B?cE5vWU8xbHNiYzdKdXo0NnZnSTI4K3ZaSTIrbkpVVXZkMGl1b1BqOHhPR0c5?=
 =?utf-8?B?L1NIV2RVRVNtVHh0SFc0Y0J6S0xNRklBemVCNFN0RlI4RVdKak1JWkNMV2Fr?=
 =?utf-8?B?TUo1V2RCSzBqdGpQdlA1MjJmMFprQm05bkp5UkRzZ29PN0xjRUxZRC95VWNx?=
 =?utf-8?B?OU9JanNwVzlDSmNmeHFZWFRBdkI3QzNmclpPdG9IVk5TRzNPekRqN1FwdE55?=
 =?utf-8?B?UE9Wc0NEZGM0ZkZxY2JtWHFoYUVPUW1aQnNUSDMvdTZicWNzMzJzc1ZhTVJV?=
 =?utf-8?B?M2s0Q3dZV095Q2FpUkEvMkltQlRoVjB1c0lEcE9nZEJoaDNhekQ1Uy95YzFo?=
 =?utf-8?B?OHpJbnRuNGtxN2VQL2Q2Mmw3aURiMUNtcXpra0dIeFp1NnlQSitOYi85UnV6?=
 =?utf-8?B?UzVUeStZNzZHQ2NncWpmVWRDT1ZOOHZCaklQSFpudldwK0xUN0gyd0VkNUo2?=
 =?utf-8?B?UWF2NEFTM05WWVB2TXJKdE1ScHIybUo0RWd0NFZ3Sks4V0dsdjFNaXFiaDhi?=
 =?utf-8?B?UnZlNUhlWVlZcm9uaHhISjhFU1Q2ZjhGakxBVWFmUGNnTkNpOXEvT2xJazFh?=
 =?utf-8?B?ODZxd0gzTGVUcmxmVFplSzRraUY5TnNzZk9pR0x3OXNBZHRISVFYUUxwYkVW?=
 =?utf-8?B?WmEzbnJmM2x2V09QL081d0Z1d2NVa0s3ZVdYY0ZVSjkvMjBXb2l6Y29JR1Bw?=
 =?utf-8?B?UjgveE5wSXJHck5wWVF2Qm91a1JheHdKdTJwQ3F2WXJUZmdSR1RRcUcycEgw?=
 =?utf-8?B?ZU1rVEZHbVgvdTY0RXN5SlRtMEdPUGVwMmJYbitLZDI2UDdXcGxUT1dldjFs?=
 =?utf-8?B?MnA5M2FGVHliaW1ZaUMvZUVlYkFqa0pkSkppdmxSWEo1ZXhieHFsMkJ0OTln?=
 =?utf-8?B?bE1JVHdhcTJwVGpJaEV1d2FFNHRFS3VwNVUzMFg1OXF4TXJ2MHZmbnRDZ2Rv?=
 =?utf-8?B?TFNsOC9idEJGc3hWelEzL2RFOGNzTW9PVVJjTS9pSktKTkYvUWNYTGJSSUpv?=
 =?utf-8?B?UVdOdlJBY0ZRQ2VJTS9VQmRpOUwwaXB6Vm15SFJWenlyMEJOVzBXL1hZa3Zx?=
 =?utf-8?B?MHJyRmZCaWxZMXh4V014L0ZiYXI5UWFzT3pvUE0rb0xYeDNQYXlrTkJKbHhm?=
 =?utf-8?B?c3lIbUF5K09rcFZSNU1aWW1RTTBmWVo2clViNDIvcE8yRHJZdy9DbUx4YkdB?=
 =?utf-8?B?NFo5bFhiOGtxSUUxRUtGWGlBRDAzWWlTNC9VR1hhdytmT2hmaU9PMjdJT1R2?=
 =?utf-8?B?cDJNOW5xVlZkTVFvSnArcDdGWkZHcWM0TW1Lc1JPTmxDTm5MZHZvWjUwYWVW?=
 =?utf-8?B?aXJaai9iTUdLYWVWTnVhd0RpYWZKd04wQ1p6UHI2V3RZRmcyMzYzWWxBWVhN?=
 =?utf-8?B?NEZCV2NTZVNVNzMvZnBMR3BLamp5b3BvV3dpM0MyanZoMnh1SFF5RDd2ZmEw?=
 =?utf-8?B?bDdLMkJUZC90ZnNzRTZaL2ZJcUF1cWxMbWlNZVE1N1I5VzBLNDVpSVJvdGlz?=
 =?utf-8?B?QUdWN0Y1NWhFdmkwNDAxY003SnU1aU1Edms4SWNEdFpCejlDNXM5Z2I4L2hq?=
 =?utf-8?B?Nmt6dGduMFdUNkg3SExmQkZIN01XNllrUWJVWjFkNEJraHh5NFFzV3cwMTJJ?=
 =?utf-8?Q?FIoa/B620H5kxO24=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f3b48b-f98e-4728-4fcf-08de7546c313
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:53:11.5697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1ixZzCOfAB2CWzMnZMlEcLjXP+PuH5bBk0i6nnwrjnEvCW9W2gUliSzukNUyNyIPAyEuSnh02IpjU4wJ8Sd/H50c0XhogCYPzgpnIGDlGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
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

On 2/26/2026 2:57 PM, Piotr Krzewinski wrote:
> When secondary process runs with --no-pci, it skips hardware device
> probing, causing different cryptodev dev_id assignments than in primary.
> Since memzone lookup is based on dev_id, it leads to secondary
> attaching to wrong memzone and corrupting primary's device
> data structures.

This probably would be the case even if you didn't use `--no-pci` but 
instead were using block-lists/allow-lists to only probe different 
devices in secondary processes? Maybe the problem is more general than that.

> 
> Fix by making secondary process search for devices by name in existing
> memzones instead of using local dev_id allocation.
> 
> Signed-off-by: Piotr Krzewinski <piotr.krzewinski@ericsson.com>
> ---
>   lib/cryptodev/rte_cryptodev.c | 37 +++++++++++++++++++++++++++++++----
>   1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
> index 7bddb154c2..50071935c2 100644
> --- a/lib/cryptodev/rte_cryptodev.c
> +++ b/lib/cryptodev/rte_cryptodev.c
> @@ -1177,6 +1177,27 @@ rte_cryptodev_find_free_device_index(void)
>   	return RTE_CRYPTO_MAX_DEVS;
>   }
>   
> +static uint8_t
> +rte_cryptodev_find_device_by_name(const char *name)
> +{
> +	char mz_name[RTE_MEMZONE_NAMESIZE];
> +	const struct rte_memzone *mz;
> +	struct rte_cryptodev_data *data;
> +	uint8_t dev_id;
> +
> +	for (dev_id = 0; dev_id < RTE_CRYPTO_MAX_DEVS; dev_id++) {
> +		snprintf(mz_name, sizeof(mz_name), "rte_cryptodev_data_%u", dev_id);
> +		mz = rte_memzone_lookup(mz_name);
> +		if (mz == NULL)
> +			continue;
> +
> +		data = mz->addr;
> +		if (strncmp(data->name, name, RTE_CRYPTODEV_NAME_MAX_LEN) == 0)
> +			return dev_id;
> +	}
> +	return RTE_CRYPTO_MAX_DEVS;
> +}

Nitpicking, but why not return `int` and -1? Returning 
RTE_CRYPTO_MAX_DEVS seems like an odd choice here. You can always cast 
the valid value to uint8_t at the caller.

That said,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

> +
>   RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_allocate)
>   struct rte_cryptodev *
>   rte_cryptodev_pmd_allocate(const char *name, int socket_id)
> @@ -1190,10 +1211,18 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
>   		return NULL;
>   	}
>   
> -	dev_id = rte_cryptodev_find_free_device_index();
> -	if (dev_id == RTE_CRYPTO_MAX_DEVS) {
> -		CDEV_LOG_ERR("Reached maximum number of crypto devices");
> -		return NULL;
> +	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
> +		dev_id = rte_cryptodev_find_device_by_name(name);
> +		if (dev_id == RTE_CRYPTO_MAX_DEVS) {
> +			CDEV_LOG_ERR("Device %s does not exist in primary process", name);
> +			return NULL;
> +		}
> +	} else {
> +		dev_id = rte_cryptodev_find_free_device_index();
> +		if (dev_id == RTE_CRYPTO_MAX_DEVS) {
> +			CDEV_LOG_ERR("Reached maximum number of crypto devices");
> +			return NULL;
> +		}
>   	}
>   
>   	cryptodev = rte_cryptodev_pmd_get_dev(dev_id);


-- 
Thanks,
Anatoly
