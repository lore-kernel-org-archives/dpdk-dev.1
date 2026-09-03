Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E56CC624DA
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE609402D8;
	Thu,  3 Sep 2026 12:41:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6EB8A4028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788432070; x=1819968070;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=4HXCfsFAnN97dWb/4P3ClYw0MRkFjIk0AR3DSNZHap8=;
 b=XsfPpUc25F7NfyuAbZcrLTUkD5hfHncC+QLd7wqtIqqNr5vK6tsiuXDl
 ojpZ3SWKM9iMCB1NsOr0MuWu/GWzca74W0g+443Z18AVKTZnm9NZmcsVD
 g2+8JiKs1eQo3/CdL4reWYuULa7zfkdMpv5+lICt1xwKPCI3Kw0QZdgRx
 7BI9J5OZVXEE3K/1/S26Od8b/ml00OyO4cWg7GnNmm6pghfQ/OrpLotgn
 GcsXBORc/pxSBGgQLVl+Jz0G3RfLQcnaa8JxevVTW6WBXPPRE54zHXhkF
 rzkIGjQxH2JCTxMtmENvBF9DDFGysYOOPc8uJEgYtHwxXAP9IWd/tRDGl A==;
X-CSE-ConnectionGUID: ZXnONP3iSvGfI87scc8gfg==
X-CSE-MsgGUID: kA2hj0yOR9WyxHVBzUrXhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88675419"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="88675419"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:41:08 -0700
X-CSE-ConnectionGUID: JjDcwNJcQryFXuuQACb/GA==
X-CSE-MsgGUID: Is3/epUIRBCb65gPnfU56A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="299546730"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:41:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:41:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:41:07 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bcot9o06Ajeyd6fzPAzi7dLK1RULXy578GnfQ2k7gvqhTxDyLDLYSfu96Rq6dAMrt5VFn16qsbcuqj/wN0otOoikoOJ8PJY2ecEszzWfit2Be6ntnI8nv/dfiev+hXqY3RXjS3orj6iFTBQgodxDLrLWpz9y5QXrGUobJJLGl/R3sxxobXTP6RnWi1QIFuHQcQ92jkDinS4HA4YM8iWFNudVmFgtFIMkYIXFZBki3VDEkDkGGu/IanHPxrReM6c7j6oh0Wt/AQg/Qmg8go4xuJasN96CBTPnxvENQjBHWR4HkivylmKnFI+Jbr6yvz4SITpjFBUmvwBjo6Eo0y10Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV6ZkNisUsQULXWYkASoFWHXoUdHnglEw5jFNS+l6v4=;
 b=QgpX4+PdW6pBODsw7aaoo/PsTWfX2r26jGt6iCfcJ3ZRLJeLjB+S93koLbHwPeKxkdXBa0NT/NYSMsKD4KsnF9deV5HKdyr1mO8UYeruK6DunSheQq1Fnv4iy+oT9xP+FZL8VFm+bgEEtns8skf9rnFSqehpLa/ATUDFA9Edmq2s0DVNdff5HxJErVAba8wT+CDNmbCFxjL5Eb7uD1+OoHrszrCgtpYgKsm/bx71Dd0nlCQKHcsa1XOl1BluNZfaaF5YiXUgDt4eHKTQTCzBzHysh0t9c+IRKZFMM5MQulTceE2rjBtTYpj80g1zax23SWYJw+SMd8oaTfBwSQywww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:41:04 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:41:04 +0000
Date: Thu, 3 Sep 2026 11:41:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 20/23] net/intel/common: include network headers
Message-ID: <aplOvCBcC2O8dpWG@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-21-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-21-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0213.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::8) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: a552024a-7f60-4085-919b-08df09a7da78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|3023799007|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7Adj21Ql0YhEhHHNBqv9u9QIndeV7MVNmEFruqfeyKE8Vnzcf+vqhGNX7J0AZ4Vo2yTpLXqsEepT/N7a89V3errx7zhsh8YwS8x0zOfbIy2sNEi8NC0Z3S5UyHcW3j106vxBCD8bsbUgbCGt17svM5wcNg14r2TYIEubNUZa9/wLIPDhQrfBUmQVXAryGmCXkKesnH1XqKqow8CU9Si5J0g/R6ULDGkjp5Os97YtJoV6c2e3xzNN+GGrD083B+CJcZlTApvbRfpmefSQ4bV95REW9TcMNFkfjLFz52Gjup4yehzqhSKJQrHiWvzByO/6iESzmp6rZSHVQzszmNaOn0ahdGe5gVwKu+EP6RgZkDldQ2tRXEqaHWqLe8+Uo7+tCwfram6v7ZN3nVT8gol3FvaIcp6gQwJARITIB/WC2WRgob21yYK3LdqITvj4dQAAHwqKQPnL7xfmyeoSSLddEv7vjCzscQ7rJEbUQ4+tjaUV8XI+JNTUsjN1PJBspQK28Bn/m4OCIMw9ErLmJTawo/OLTLYcAZCrERMDFCy8Zp8aFfrPuyQkZ0Q01S1cewHgqdAKDPTfWqHxpvo9eICwltQ0a9WYQoUjzE56423scEeAGw7featxzlG5bLt2M7q/skP/jvAPm918KZPtmh/lWE7x/PippQueHFSNZ9FX+NM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gx9coXzNpwBNayKzoHnCk35sgd1/sZ2yT0BAuPtY3d1qsyaBjfh/A0Rmc3sP?=
 =?us-ascii?Q?Uja9C/nr5o6n1PrznbJQhWnK3YN6iXg7E7w5pQzpCVoxCgxrZWOURiaR7t//?=
 =?us-ascii?Q?6WYFBiKd/ubI/DKxjQXf2ZtDTFoaFmni5SYKkUUYXkeFzFCj7CrjAXvTgcRl?=
 =?us-ascii?Q?jHf1QHs2T1EkT14h1Xl8EsPlCxGtxLoliYDM94yMcN/A4lOlGTE/yDjG+T0s?=
 =?us-ascii?Q?eJmyBFvdxXZ7jyXuLE96hf9wh1sVOtTU3ERuNhlxopy64eiyyciOnDbX8QO4?=
 =?us-ascii?Q?ickW2BJS8PicNRULYGRjm1PLEdXRS04ozU7cKY2kUTxrOGjXJPZO6VblkTp3?=
 =?us-ascii?Q?5wumNpgkJiJpTxoB1V5mvIgYuTHZjTG3KAgmyXKskmCwLeWydk4mud4HLgI1?=
 =?us-ascii?Q?cls2+O8/dm2X4GgSRBjSy90P9VcRY1TAlSGs5g8cugex0IgnQEdl2LeeLfnH?=
 =?us-ascii?Q?A09TmlyxYqVrj0duVwJbT/hmxLBhwa7kD01orI20I8S+9FHwWVqW4te9WWS0?=
 =?us-ascii?Q?PbP5gQ16acDNlb5ds4cnjPAkQXmC6han+IAVBY1wYQeg6R+GP5NYGhJiPJ2L?=
 =?us-ascii?Q?UuWEspEbstWSTC9DpC0LZfITYaa+in1wy8jxcTJg4aImLOvW28Ln6Ciq+C0J?=
 =?us-ascii?Q?SRus/WZ86RlEfIVpN9h4cigyVBXmtAseSKk7Qfqlz3EQKLY2GhHJMiwIPEoE?=
 =?us-ascii?Q?05IudW3I23iPEXczxeO0o44o5tFl6X5mHac0TccF9BE+IOs3tC40hneWJDkk?=
 =?us-ascii?Q?ly7shLWFLNJ3z08/y/k05agZr/neWsOmPmmj/WVkBP1aBs9ynQ6dPbT5gQZN?=
 =?us-ascii?Q?Pbn7ywaFSSSqiKtq2ygOeMLIfcU7Gm7BPHNndAXuf209IlK8PIW54kBDJYSZ?=
 =?us-ascii?Q?pwyDm3e4qzj84kR7HKDLn8JpdSNIUPeprxdL+ZyobhbiBe+Ine3isldkyTsq?=
 =?us-ascii?Q?T/ilXKsks9DZIVFzRN/22LyJJ/crCy9rkFuH5ZgH4lLENrEH/441asqwKvk/?=
 =?us-ascii?Q?9teWMzaGglot3gHZv32s5dD0MYruKYtd07DIR9A/hVByeYGfbhFbIwHmnG8a?=
 =?us-ascii?Q?NyZelknV8C6YRmbrU2771dBPQarF1WFFOiLGNmOjN4hJ7mfrjcl/LCHQuJcS?=
 =?us-ascii?Q?5x3ZLdk8Iv61j+dlNw0HErpoHN4mbAiodgPYzm+zXw4VOtfI9DbbaJpuikD9?=
 =?us-ascii?Q?QeAyapetWxSURDmXYZuE9U8wzoBCc6Cpcj5TEnyfycdvzENpgdUXRNzYUHAY?=
 =?us-ascii?Q?EjdMdChZP+TC+OQ8/UM969vf4wEegVmiQfyM6hHBNg0QnAgn3Ec3gFOklgcu?=
 =?us-ascii?Q?W7S69n65dPNTMHpKeWTazXCw6JihAAgjiHOwseBKDLdAAORW8ycnV2vEtlMs?=
 =?us-ascii?Q?55tVn0Goe9wwm3qXCgKjoTAjcgf5up5BIxP3/5K6l3nJk3hGHALG79sm+iPh?=
 =?us-ascii?Q?0pPDpk78EmXjYSddUvE3U7E5VWjLH47GeTjCeguPECGPlRR+6CvevHLa4Qkp?=
 =?us-ascii?Q?u/qsocoy+rOgUwCzuJBS+GkxZCDBIWt8EV7MNomkp+tHTx1vUFMBqQlQR3WS?=
 =?us-ascii?Q?J0hxdWQtLKni+/GnjtoZJrtEi/dUCKcSpjel3TZs38ULQ9Q488WmDgn4zXxj?=
 =?us-ascii?Q?D8bMukAnc+6EvKeO/Z1TvCxf1B7xK0W9Rj3TiA27HuR8XFDeM7p+9WzFJmmY?=
 =?us-ascii?Q?+WZrpuixgzPlT+KlWevyJC7wR59LTvQo+1XV6YXkKxgVsOGwVIdl8rz6mrgQ?=
 =?us-ascii?Q?OQ1wi51dFhAgiYtCMyx4td8C3PPKUdM=3D?=
X-Exchange-RoutingPolicyChecked: vU8D9iyrNIYXJHyFvXwSCwco9ts8UV7WNZOpGKUa4q6GGM4QpxZw8VeYMJRyyOLZqC00OAEl+/ToaaGcMhr9G2DWQNnl1JR6IoJ5tJNgw03E33L3fUKaJEV0ojMdcDhLJ1qDVNl1bbwl4x4PpGyd9M9gcWAkqwNqktpjjx8BS6ZZLNY2Za//WDabfSnd3sxso0wps+r9uOKZJ+EuKLD7XRpULPykgntc5pCGu5hjbgZ1l6zIHLhUDqwREPnCDdVDt+IUkrbz/jny2QUPofX5/Prc7x952y0zp59qfN00xZTdQCGAptqEVZv0Rg0evUmoqaXqjKzjhnVfAWVP0UZrcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a552024a-7f60-4085-919b-08df09a7da78
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:41:04.0457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOnyeHDC1FxBDVtXw+lu2BCjLcUSms1IbsKLzJGtLvhemR/2mn+NibErMzQeEpExBaMRtW9v+kIOYw/OfHroNr/ywLni3PAZSG04qq5KVeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
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

On Wed, Aug 05, 2026 at 10:09:14PM -0700, Stephen Hemminger wrote:
> This file was depending on network protocol headers getting
> included via rte_ethdev.h -> rte_flow.h.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/common/tx_scalar.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/intel/common/tx_scalar.h b/drivers/net/intel/common/tx_scalar.h
> index 11ab6c08fc..dcb2ea5542 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -8,6 +8,9 @@
>  #include <stdint.h>
>  #include <rte_io.h>
>  #include <rte_byteorder.h>
> +#include <rte_udp.h>
> +#include <rte_tcp.h>
> +#include <rte_sctp.h>
>  
>  /* depends on common Tx definitions. */
>  #include "tx.h"
> -- 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

