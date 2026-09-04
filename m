Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A1EC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 08:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF6C042E10;
	Fri,  4 Sep 2026 10:14:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 26C8840A77;
 Fri,  4 Sep 2026 10:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788509690; x=1820045690;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vebgvnWb/fJVYBoCWGkFfoiOFYJtuSzLY6LIoH5HXDo=;
 b=U5TPV8Zujx3yDX3EpKZJK3l6r5YYhBzEwFDmkRAO0in2sPC8Jl6Msdvt
 0WtGApvO4Q3DIf3DQ3792nQXdRApyj4zBq5DRhnC4pvAhPZbEKACobP4a
 fD8I5eHoWDz1nzJM69LIuIvs26gQdBb0Bycp/xaUkNkWkRIpSwFFHzkrA
 MY0axvbvldNDwfHLmoT4sjlqz3vafH2QeBY8pv89vsM2V6kvhaWbPc3CK
 /CfJQU120KMpeXaoiB0DshOo3ypwdFcKEpqy57XuUf3DCA5yQZ+KPVpUR
 KnipKSDL8EUkMuiIoM45LrE18Xe7hyVh19klxpaRzURB3kmFN+f/kdCWu Q==;
X-CSE-ConnectionGUID: MTxjWab4S1qlObiumHNwIA==
X-CSE-MsgGUID: ioFnWj1wRRCjKAdW7omqaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88854171"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="88854171"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 01:14:49 -0700
X-CSE-ConnectionGUID: C8y3NtRoS8mP2bb9Iqzu4A==
X-CSE-MsgGUID: puoHhqUaRKe8REOiDMsOeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="274122590"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 01:14:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 01:14:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 01:14:48 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 01:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYdYaWVHUbmcFCdxZK2iJy/Bh9qeGykAIlWifsc6cqEPKVZgXWE0sUuSgibj5/PJC3c0TJJxNipPtQqSNHwQgj+xQdOhUttsDc6pvtI4DklFPME26yD/+lt4aJTCrxN40/rC7cKI4romvLnGF9AejzW/iWiTUpFuoYTWtf8UkBaV5ownfT3N8MSg85kCrM9wrc4lo7f8TcFypHN87HMNVpuihb7hKyBSqCDEPMox1FyN/ih/EiU1ri/xVWbFOiVHdjv2g9amPQcnGrXoM6MlZouJKQZ5GV281FOoDcUKKpw5iXGaHMRrhXN0yr+AhDqKOE158lcv7Os4ks1FABSSsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88ruvXYIkzlf/Y+gO+4XWxWq+dC516bS74KXN7thCv0=;
 b=XZwzac5tQ2f1nvFVvYSp4qDoN1crIeih4b2muBcoeMoSnknPa+9MLrW7VKLsSsstLQ77rDRmGczCCjwDa2BGpp8qT8CL3uWPPm8o786d5AH3V5SKx8v05/nkvEb1YvxaAFkLluFlOl8/4HRbfwQCu++oXu3aFRfaE2Ml44jYPbwWE/DkDH9+xntWgebbZpOhMEdPTPFn7KVEHIJC9GuM31aSSyLUy0Sh36jkX9yIOHyLjAQq9+yVMB4T6G3aZ4yT8kKIQJm1j4qY8TIOAC9wDgk37DfYD1DxPrpman8JpHnIB85TenSSgDjY7MDbBqAH69Q3i7pOJtIXGZgL0YHQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:14:46 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:14:46 +0000
Date: Fri, 4 Sep 2026 09:14:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: Re: [PATCH v2 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Message-ID: <app98jC_nKacjDKr@bricha3-mobl1.ger.corp.intel.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260903143827.327131-1-bruce.richardson@intel.com>
 <20260903143827.327131-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903143827.327131-4-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0216.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::14) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c049f8-6171-43cb-6976-08df0a5c94cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|4143699003|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: HVqSE+4glaiYFpSl7somkZy5oUGtpSiFnM+rceMBJcYi2xFiEyhZt0PiVYmdIlcR9evn079bEn5y31gsUTyDoJpqg8QznZ8MmnuYPM+668dlZAEFPp5Ix1bva4Vs3khsCOmcEtKZ/KaNk0dY7At8C2XQC9HUAFyTtHWIkdUb+JJ6fI8ZBb9ZkBKUzIQorgut2bltHx9WIzIJG+Fvq5K4AxKwslg5yHAENY8MhcytXfEihPEXQitIuwJn2zt0JR2HHjRlRMvF4d+7cxoW0JyuMDCos4p0OPXgb3gt+QcBIG+bhiZ5AfB0cEzPMQFwUwumZnwugA6vfWCJ1Kfpee6W7k/hyhai/oyR6s6H6zod8hUrMMpOUWD3lY7hEa8vNr5xQB4c0kQHDn5eAgGA9+i3uX7bargNz+YGCyUMMy+zF2GCW20aO7ZAgfFgDWvjU0qcvGPr+d2uyiE3OgtwxkMqcjHm7i4b9MRqxv6d/G4K4BQZQ7Ydw0Vo8OCvlnuIXxIezeJIg21bSM5sQG3tiQPoTSQvkvxmtCM08Ve+k42tdvH2V4Ze200A1tLyHmPRvLWm+xgvEIj1xoUfEkB8vY4G/Pn8CiI5D+dpgFZwy9xqNlXoz5YOt+z67uqMbqTxMMLOzSC8nnNG+x+ipW5ACV0ZCwIV4jmHeCiGM/CJnjrC3WE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYrYxHGE9lMXPViVayGLMKaRtc1RGfTxToK3XnlGVsHA9zOTdfzSGCzOILAh?=
 =?us-ascii?Q?AXlYkInV7/+nGZbgVUmIid7gq/b89QpVzrvMX2/jnyIVjJLTWcSo9s3PCvfA?=
 =?us-ascii?Q?FEa7jjA0vR2TeebvVkNYAz3Bk1MFPqF+kdK8nUaBAZTk42xDC/BP6U/CdNGr?=
 =?us-ascii?Q?paY7+K1CaP+Bl6xfRlQdMZRnVyr7AyFQhQ8Nbx+W+eYgjAppgaY3rrRbUMYZ?=
 =?us-ascii?Q?7mnRWg+Kv9Lz+/Izne7sgWt2Z6J1S1R2bQF9yVPXtKOCAN/8PmpAyjvFxEoC?=
 =?us-ascii?Q?VfXs/JRCtOcom5/qhNL5DhuPJ28t/9aKKzCRlSsFFIet1u06G+QrhsxMpR/x?=
 =?us-ascii?Q?QDJN15AdGJtMRWEuqh01t+kJ5in/HjwU9ZLCqO9AdsSTz/+c0zx68WP7ldgQ?=
 =?us-ascii?Q?G5wUeloT5ALtwGC4vOkonP4Oe/i3ttN86/KV8EQcCuYlHeY/bRSE9ZIMuBVA?=
 =?us-ascii?Q?vHBgseIq67Btds6lR5rX144jpuBlOlqZtVjbQgx5oVWobjMWhNIF41P7VKv4?=
 =?us-ascii?Q?SAjIGWogyamxPeOaZb8uK5Yh5EYz9dxnCG6LIVyv6iF2ezYN9X0QHYq6opQm?=
 =?us-ascii?Q?w5H71/HWKi//ytoXEUPGGAdG+4Y1kFlvd0V0acPZsrS4wnWGc3H8kKJrDGAr?=
 =?us-ascii?Q?JimXU+5WQV80F/JwlypjBu6SUJK1NmfXdU4e73Ho1SOZ/xKyPgC6I978mln9?=
 =?us-ascii?Q?rlZDVSZRImFMjliDzdwL1b5THd7ibje68pkfWTGwbFAOe8a5Q5Kfjb5NWKKe?=
 =?us-ascii?Q?XiAkPuvI8UjLCTu1NYIMIlK8Z4k9sXtE6DHegRnKIF7wl4HJXmrpLjTNeekN?=
 =?us-ascii?Q?IGcYOXX68//H8B5IAouapvca7+p35PXFXvfdG8Ge9R0hZSrGqBodopiAj7P3?=
 =?us-ascii?Q?gziawLZieOM1TOg8msSuVuuZ/iaagfJQP9W8GwYyHd1vRmOvl7Ms7hr0iv89?=
 =?us-ascii?Q?hAOviYRViPAN8FxzgOH4+IZsGoMhhQdUlejuCA1jn7yT6txITGx7U15jlakb?=
 =?us-ascii?Q?+70JExwTEM/IKxRhPm/qFtL94ZalQfcyUi4I4GYIuv+50ZZbM5A3lyZW6oxR?=
 =?us-ascii?Q?1rdDau0Qms6vxbbm9jXmTLUIljPjR/C849CRurJZM4FCaEKRCfBPR1cFgbHo?=
 =?us-ascii?Q?QpeYQXtZYbenF7TnKdKPoTN0cLsfyFesfZ3i5Az0Q/erKx7ld/FzFz4awwcY?=
 =?us-ascii?Q?jcd5Yd3EW6ZAXmpzn2Wtk3ISe9KGxgVm3G8SsS0kRkHOg9Xp/8bU2ptLMGwI?=
 =?us-ascii?Q?v3b8mzniPGz61iBRDlFXdJBjSy87f+5FYh2Jw2j69bSZ/jH9TwBJuJfTmPfx?=
 =?us-ascii?Q?kRlcqiU7J21wffYBWWLYc9ti9ZzNnCnkV4ENVOQSCWI32vkFzg/ZUc9U3m1X?=
 =?us-ascii?Q?VL58/ewdHrctpR7yxoI7iONUch9ODolpcmZFux9q8GPnjnQHL09CtHHKqdje?=
 =?us-ascii?Q?AIF6/MbBp3t2CyftSQWqMCCjMNra1JHSl173Vt/HkLZpu0wf8pO4Dbe93suO?=
 =?us-ascii?Q?trxF98qpc4HDvNKnIPK1vE3vGb9feHw6x9PQ5vTRMHX8/7J6IaV+FmaUe/kC?=
 =?us-ascii?Q?/+UjgeqnEhqDu64TdY9D1ao3ym0qGjPB9cMjFLcuWSVm1+X9ZRmWhhYLd52o?=
 =?us-ascii?Q?uAWTpekzvVnGGROz9SrIXDeDqo1ZbaDqRT0S7/QldcYZD0dsyWrwMJnkRSGh?=
 =?us-ascii?Q?DZovTgKpusROkX5jmBCxsNKUYuICiPt34JDp/7ghQV7W9Rud2VXfpt3GsnHT?=
 =?us-ascii?Q?uErxe3h8IwdrR7XTg4XWdbz7FxhCddI=3D?=
X-Exchange-RoutingPolicyChecked: tprKiATGQ37wt5bOerxNQ+SsbWBgWX6rM9+XgSfT7OXIbbyQsBJj11/4tUHGu16MGhso9JPAZ7o0GAur4nPrvH7bt2Xms0GF2NwTgZH/FbEkRdZjcG/ZUFTeeOQ3boI2a8IOSlSqI+Nu8hlj4EYYZvZeh30+wBoXil1o9e/qV5yICmiO9H/pCKSBrJKCgbOhrIQi77T++HQtfhFU+qu0tJpUo5ZQbTZ6/kOcg1txnG4/3r+ejTpmL5IAMlE7tfJ0RpRPrNF+Mm2bUd3gY8jL1J6yX0E5NyGP7YJ6a6q7lkzjvH8+h1p7R70OCdN3On+qRY4ZVQybUGljV+21RfStCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c049f8-6171-43cb-6976-08df0a5c94cd
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:14:46.2489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7AkCl1/wAK3WLkL/95pxhc0a1p3+tKdxZGlo+xTih2FDfl4SBDJPTSaJ9cJQfcJOlMhDpOLK/1DjIYZUrtX8lHX7tUglcYOxRPvKPwRvAT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
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

On Thu, Sep 03, 2026 at 03:37:25PM +0100, Bruce Richardson wrote:
> The outer VLAN TPID setting for Tx was cached in the driver but was not
> properly pushed to hardware (via PF) when changed. Add the necessary
> push call to the update function.
> 
> Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> Fixes: 7ce1363b424f ("net/iavf: support QinQ insertion")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Adding ack from v1:

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index c4a6763f28..2ac4dbdac4 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1461,13 +1461,20 @@ iavf_vlan_tpid_set(struct rte_eth_dev *dev, enum rte_vlan_type vlan_type, uint16
>  		return -ENOTSUP;
>  	}
>  
> -	/* This API only fills internal iavf_adapter structure
> -	 * and does not send any signal to hardware.
> -	 * Inner VLAN always 0x8100, so not set explicitly.
> -	 */
> +	/* Inner VLAN always 0x8100, so not set explicitly. */
>  	if (qinq && vlan_type == RTE_ETH_VLAN_TYPE_OUTER)
>  		adapter->tpid = tpid; /* Outer VLAN can be 0x88a8 or 0x8100 */
>  
> +	/* Re-push insertion, and stripping if already enabled, so the new
> +	 * outer TPID reaches the PF instead of only being cached here.
> +	 */
> +	iavf_dev_vlan_insert_set(dev);
> +	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_QINQ_STRIP) {
> +		int ret = iavf_dev_vlan_offload_set(dev, RTE_ETH_QINQ_STRIP_MASK);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.53.0
> 
