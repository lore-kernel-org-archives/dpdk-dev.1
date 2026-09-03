Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305AEC624D7
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:38:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D7A7402D8;
	Thu,  3 Sep 2026 12:38:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 34A654028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788431933; x=1819967933;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eTX3tOEBgmgTWmxc0sHk8gJC/GZ04GQMjbtSRtzV0Y4=;
 b=W4VqG0o6hJ/Nm1iuh4787AsDEgve8uQFplkUViphfj/QvZO3ZwOXGnYt
 yJ4mowW85Otz3VwzelzhOF03lw41zw6lwaTfHadUUhdmgkfUcfhrH228D
 h1bzuPo//fIJSK6dsjG7n6clo7BLtJzrquZaTVf+KMqf7s/RX/PeWu6Zb
 ut+8E9qJiUs4l9zPSfMonhZk4xViul5ZyCsz8Pv8kFX6aRsYnUSfOJn63
 TvhBjLqr0M9W+G0puN9AFJ25GDNRglKkNblI48jDJANkwBJt5b4gDJ2re
 8bsJgbu2v5BBnA9l4lCCkBniO4LmUuD4STmZsHwoPdq/1RCbDBqba5fK4 Q==;
X-CSE-ConnectionGUID: AVPwPXBfS0yyNPrvuwUmXQ==
X-CSE-MsgGUID: SsRl8m/LSpq9io98m5z6UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88962898"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="88962898"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:38:52 -0700
X-CSE-ConnectionGUID: DhzM2CfgScO4ljuvlsVGhg==
X-CSE-MsgGUID: e3LP09JoQniE790La4KdeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="270224051"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:38:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:38:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:38:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNYyyfRshO2F9m1coQvQaTsrnmZxwzW9sYl5CMGD4OP4zTGoiM7O893QI+wjjDwVj5UF4QpPiKkHskSGGkpJXxTBI+cmCZLBP2ZzY4hwf7fR70s5vP9aIpJlthI/guccYGCDK13TYhibC1MAKmcEpYaxhhrObvTC2zGSUDwLYsmJVyKY2tAJRhaDr9wJEXubNzlf2F8IGdu0abtlTej4n3RSA+BLyhcMm7agRdjHpMB2voj/D5Mku9Vgy4DcowClWBK27Wkg6tSNQvoGBDyZ1RIB/Dujm92wvMyytdObnzjV7JncGCkoOcaBpiv2U4TmmI6PFxadRAVqmrQ9Ui73JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Fz8O+StSIJk0n6znKrrb4R+rpZWR4YxbZ22vce/Qs=;
 b=LGT+glsV8rRLPyU1ubR0BstYlgq0GziD/t0nwI31PKuPkYUFZxaZiim4c5FSoRLz42mu+c2tgqm139OPDO5GY/nhsHC254fzu3Nezf5k0QZdy89gOGBi0DktUBWjJmpj64vPznmUTHtqCD/LRT7q/fN1itpvODg7Gu/GrXMa9aFz62IwQ1QtdfAcuFyKazkQP4lu46agF6iudVxVljJ7mc1UdX50XxDbBafhRY5Onxb9jnKxdEMbvZHeat8/+nAhDQJnnmez5F96gqJykjBajdwwvkekMyYFKd0lipuCTeATdpICt9X2L2irD4bFvo9ESicI7xvkyRW3rhmfryJRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:38:50 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:38:49 +0000
Date: Thu, 3 Sep 2026 11:38:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v4 06/23] app/testpmd: move str_to_flowtype to i40e
Message-ID: <aplONdVU73CkzoNs@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-7-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-7-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0129.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::12) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f04173-b707-4f2e-c89b-08df09a78a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mUMUmZ9UoFU1tNNATBqZv+dz+KGUCKvIxwrcWQL3T8JKU8mo8FsDp/fFT4idqMq4QZz2lyKWIvuwLgPPlHx5YLNS0YnwlGiFPI+YbLakJAN29yUGFEh6DuqDEbO0DqUtIh5rPQwpR7v78XjvRstGrXjzQ0BDmaFdndYrYdX9DfQrJDV98M2yR9vAO5mQXeNn/7kAe8Z+gwYFDGBPe6CsOBRtZl1Atj0tDIju8S9y/vd8kxz5ETN3dkvLEtFyaMtm5YxJj3iStdjkrj9kLUC4BGmZM8i1ubeYIztA/OndTM6IEi45IzmYUFDEvxM8cd+qnPgupVzXlr81KkMpqFnuAmt+GnwPKzdnueWogHSh8h3bD4vkaBN5DsIARi9Itvud8IxUO8MA5rRg3OiZLvqpM684k1RfywNBqgXDoQGi/BSHBXclhqYsh8rnhbXSCE0JGCyYW/4+cDR42wAqHoj4KmKxGm47tCzj+0QdEt4+3Iw4crgFPuRCewWsicFtkQOwIxiXf+5waGHURgQ9YXgp38Yo5G8vVvlL9aqLdlMvWR5cX3DW4lehwqNwSBQSrMU5DpbEdcj/kkxq7z26QHETPwpPyHTZrbdTPQoZB9cQY+636NZ18filTK3gpJZVjSrVoeghnUe3nZq+y1f0aDfdqoMXVoyMJwTc67iQf8rqvA0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qo6F7zr/jZGfV4YsEZ/JY3L5LHuzot3Wne9fgNlT43/JUThI898Hxfkk4ZEv?=
 =?us-ascii?Q?ESJtZf2FfpbHgeklZBX1Gho0oSRFEFoD+VXXClPCUetASwrRUFz6KppMA0PQ?=
 =?us-ascii?Q?gtKxD1/LrF3i+BtWaGLUtzGaXMCS38mApGZRCCr1o7zf/+vXw/9sWb/De0kP?=
 =?us-ascii?Q?XlzsBpwok2AHO/7BV4Df8PHknJmFhFJ2vyn6vD4YoO/4y/bRgJf4CZcXtVmX?=
 =?us-ascii?Q?z9jy31gTMV8uNmjq3QJybtFm+K9a7NQSmMGGXAVtDRLXwCHJW1gAc37MjhTD?=
 =?us-ascii?Q?Rgbfv6Djjjx8RuR91fd7VrjZQkJcN0QLVOjuM9t16EZqD8AAqKmtgHR0tisx?=
 =?us-ascii?Q?JElGzarZMOjH/SnZUbXdMZFR0hzAVsta4A1syE/hZLpWWACwDwP3AFNvaEZl?=
 =?us-ascii?Q?9Dwvl2DxzWLGu/zUmu+WzrWOdwfZfThUmfGwXYm88UzJALE0vOJUW6lWwjXW?=
 =?us-ascii?Q?DJAXLbsMEGXrjwHZ7X180lh+w+3FOEJMq+MlLa/1oeVmSVm+FPEBA4LDlBF9?=
 =?us-ascii?Q?KWeZJafoeNOF1bSKAdPQhvEIwiTWkVcXnYEZFhaQxia1XDb4NZjttrn1Z1Eb?=
 =?us-ascii?Q?2VW8fxz2Qo6VWvbkVWBDyUlDe2/B7e8dLuu/7H701/rlJD6BeB6sY8eHnkS3?=
 =?us-ascii?Q?ZYEch76B9pGS3BDOiP0lGQyw4PxJjvJIYodecWxb1dQjNR589qPvdnxATjLq?=
 =?us-ascii?Q?IslkukysjPlkqFQ00O8EQ0rIryKfPeDd9aRBJVx6w4+1m4VYcNqW79OntKpy?=
 =?us-ascii?Q?I+4S8nBLPbOQ2lZasjcHBoWWEoBKkk+srkvME3YiuIheUJFBMekD/czExWwR?=
 =?us-ascii?Q?VD+S5Tc+lyJVd5QZ9jK5ST27ZE7Oec1/MPyZ8sTTaZlbVv1Dk7mc1pAm16kh?=
 =?us-ascii?Q?uBO+gi/+/ko0OMkbN/SAxMVdXA7nhpr0V8Sf09gzwuhY+yW19TZMadBCGhc+?=
 =?us-ascii?Q?FtXcdzwlvLe2rylnex1E4sVDiqc4X98Wtry8JNSWBgw+M3uKDN+ToAGk5nyA?=
 =?us-ascii?Q?LjAFq/+axzmZzrHqGuMrxaoHQNNq40+1BxSOJ1+SGgPOuasqW2oXHisTbnpF?=
 =?us-ascii?Q?wZJ1xoagDj5oUknh7X+exu0E1+RbdfGyayTxJ1a4FPocGNpFtWe9vzpkpr5E?=
 =?us-ascii?Q?XKUzAJJ0TcFLaswSlVPLAUoLEb0uCOPnSeWXwRsX3mAMpHdnigS/9osPNViw?=
 =?us-ascii?Q?BMny/1VhaNvbXFC6p+J+L6i3WAj7JWpiggBZsB3tjds9CxfHndR019V/Wakq?=
 =?us-ascii?Q?RSgI6mgPpS6gp2fTOvZ2WqJQweifa+lVocvBhDSDrXYxExUktgTS5ki2XBgs?=
 =?us-ascii?Q?e752pLfDE+t0Z9soqC4Yt9sNu5JR0+vvauWsQwUwj1LLqg9ikQGa/GA/ftjG?=
 =?us-ascii?Q?YMYGOmxdpdc9Bh36SbZaBuJMUxVCHz2k+a+3xwjEf0m808aE+OjlCAoT9z1d?=
 =?us-ascii?Q?/uhS05OmqvmXnlD3W+zwmIqelRWOuCekkEN1z4Q9hQytd27zxJpZ8vv0RW8H?=
 =?us-ascii?Q?a/laB7QIE/sW49uRxck0JhYA2FWNai7p6ULYytqkKetl9AxFyEeR8YDS8vYe?=
 =?us-ascii?Q?BeUURyoU1HEnISdB3aZet5aS1Ll0BRrG/nmVOYsM1ywfUo8Yx+lZhhHyDZFU?=
 =?us-ascii?Q?imuRax4GeyxpuCBPuVDASgWNZ/v0NFbK7GraHij1RPvw8TxiZ+hE4xMSraKy?=
 =?us-ascii?Q?olWMn9zcXDjfRUp7I3/Yl4i4sJdIo+XVejNdPy0AQN+ShgmUeQXUFmN6t2gF?=
 =?us-ascii?Q?UwNbMObD1oNNB2qYtkhYgy7LCYetgoI=3D?=
X-Exchange-RoutingPolicyChecked: PrYEVLXcZijgId3khyFj5KXeFUU3SZ3O1vTnvrLi+9+anrth7SnHrNO61JRGed2v5oP1f33pbv+Pz0eVA/bh9QISOS71eKOI5V9ES+5F1CsiKL53+TXjLrLU6YatNnpLFY9k9ft9QiTEjD2bWsGtDHqCAugmrJfb2FaXQKDnZYxkt4D/IB/EY/wIEpmw/6VF9UYlfrs+LC6ecchwG0DhsQGEeRRk9/sHySvUVxUqLaT8hGk/t6UWmF/A7UcxufqHXEESF9/hkFXJm1CSdX8aFOAibiKPiasyQZXVOC1zoURddwKggJX3kLS0GureIaEsnQdPt/AZ76NqGdJ2BfXcjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f04173-b707-4f2e-c89b-08df09a78a7a
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:38:49.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWwS9z9Fh2jWLni+whw8nszcf0NHSeC5qfgXooTmW2TBNzMfyEY1tV832AdSBYHFeCwg4KA6wvTbwyMNi0JUlU2gQLSXK3nBdwwgxmyHSCM=
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

On Wed, Aug 05, 2026 at 10:09:00PM -0700, Stephen Hemminger wrote:
> Only the i40e internal command is still using str_to_flowtype()
> so move it to there.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-pmd/config.c                 | 62 ---------------------------
>  app/test-pmd/testpmd.h                |  3 --
>  drivers/net/intel/i40e/i40e_testpmd.c | 51 ++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 65 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
