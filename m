Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D15C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 13:17:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 702BF402AC;
	Thu, 13 Aug 2026 15:17:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D51A440298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:17:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786627068; x=1818163068;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Suzuhw2PydjByj49HOZjfpqpGK+5XlMie69NeqwOvc8=;
 b=ZxFEcsJOeKsVPos/W+qUcffn8xrBdOfGTwqLChUNO+5HuFpV1fZE/0hd
 4bCYg/4JU5czGgvxJf2SP8sSK0nEQvWrwlNqZNzKVhYxwWrRWOXbsXXoj
 AiHy23jY/IgGVk3qT5SQjwVbhTvVlfcbmqNwcTjkFDya+gBJTJRO/e0AE
 of3v2h9RS5sMqSCc8vPrfZwq3dr7nXwdezT0l3vA839eIJcMUQaqUwqVK
 tLq1M9VY5z9odGr9qEZN9uKVSgYwZIWWDxW296TgORc5vmKVvKxJfis1L
 xYS1CRbCfqQI4lztRoaPHYznLxYe2EROTv7uAcu6I5slaFKh8NlYiLgEn A==;
X-CSE-ConnectionGUID: Yw4MLjqURMSCsyHHWZdMjQ==
X-CSE-MsgGUID: dLjEMwmpR1SQmy92nUikjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="90877729"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="90877729"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:17:46 -0700
X-CSE-ConnectionGUID: 3AQna1lrSwOScTccmoRYig==
X-CSE-MsgGUID: uoTLts9jTU2xtyXs1/HTqQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:17:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:17:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:17:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbmCjYW1kmDC3ACzFq6fdupdOUzGr/oerR2uNOmnGoBsIyFgTRe6UbnDaCQ1UDwoK2ZO7KoDEb5W6O+l80EsRI+BRNE1YiRuoHAMEC2/kgHYHbVL7Z0vpm6Ar/XZPJgZE1Yyv/xXYoXOzLmKFktyE2gz2Z7NLX9yuZ0KnY4ubtEJXPkfhQhAtQ4ESu4+ja1Y3naVDgmMxT2mtIPuRfxDP97T3drFjZXAnPp7oMYxXPdSRIjgTpwX/D008gFgezx+BsQmkX54pGs66dImqvw01KWFvndgx8GCEdJUICOeU3oKT/1ZfYPvEUCfkHnxK9up8ivJcTj1M2Cz2ktCnWtvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zedHXcUbhDMnfvqvq/wVicFCF2XfLkuspS3Otp7TASY=;
 b=OvlQe2ns1pv8HY1yI9hMFnP6B0TeK4dbIm462Imty0ehOq84b8dvHH/+79TJEXs3hcq8sE6fVZ1NSMa92fh1aPdjl5cYGeZfgY3v/blb1kCbSLKPgE/a/fG/OUyVnBo+D3mxMCHavGNPcCUnYI7058fMXF3A67iOouR/wSkw29KKltpkzMeDtdAMkSCb5laPbU4dOfnJqQxx5IjckOZop5owxrt5MX0B1YOIL+d4UK5JVulp0I5YgaiDvq3Kfr1Too1PHp/yCQMoFwQctRJmswVqXK0+LfGAckrPTOWEHy7DseVKT/dw+0X4uaEAdc/7e776ktYSMwZcj15dTnrpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 13:17:41 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:17:41 +0000
Date: Thu, 13 Aug 2026 14:17:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 2/7] net/iavf: defer device start when PF VSI not ready
Message-ID: <an3D7tNkwtS9RADr@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
 <3bb2a6e50c1ba06f4929fa9bc8374416d15096eb.1786617159.git.anurag.mandal@intel.com>
 <IA4PR11MB92787BA8C6BB190A0EE0F31C8EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92787BA8C6BB190A0EE0F31C8EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::18) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3d445c-a645-4ff8-9ad1-08def93d410c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: lGisQ99upnteXOs/bo3osMNYBy8N5scQ93QQtOhRKIMSfu+ozgajCNo4xXqypj7MLozw2vFwmcEY4tzF/p8z9UT/ToFNLf9biIqbF9I92k0/YYkrFadFMQ3bPPlsxMKagLAO4gsNXxw6ftQKirEVyjGhiDipzbX6iStJc9fYQetx8Z3EyFV9JKS0+J8q8cgZ7eFrGa9zSQj4Nzgp5aRTiM08ys+4VGIJX6Ga658Nb4RH1Qlej5/IRVHw+263724E1MNsMKbRVjFKv7tUSgt+8+CecAmgfl/0a8Ly2seDNwlwJ5DSICq9xB65FQsmj+Mch1yIGv9WOYQqHq4l5ML+bAZ/8pS5ITwPyoAaEqsvm86sDzCulpP7sIMrQ1CnTvnjlVXEIEZCKIVaoyCzeRNRvXN/Mmq8rzsg5osaJQQegr5GU18s+IqzXkAcI+dZK+4QSCDKlnQ41E/dUf3xN871r7NlojKy9v+mEmj/9Ni1I8lXenNs2pREm7w9c1Na2GQxewat75eZt1OIKa+WgTjf5bNRJhyowO6HeFga5SZqmeY8QdnXVK2jTEm7KmdbG28C9VkC+AVdeQ9lsef9QrUqGTcGZ1BWR+Z3+UFnCYtxfVh1ThesJi/W8LYHjKgxnRnr5D34gCKt4afouwEP9EVocEHHhKtZaVKITxO/SakUJVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nipo60OTDf8piZAIlzUb5QWNCQvOxS/NSFLOEMRqJ9+O377YsmolxdhuHPlX?=
 =?us-ascii?Q?wqaW2Bi2+Ts7zNzzaacvrNL2rVEuMM9x4VGuiG2aijYPSnIqQJ8wS1lmMdCU?=
 =?us-ascii?Q?7GW9yviD4jLgvZwxL6JpQon53kb5MMV596O4Q9lHtyznuwPR82zqkNAI9cL2?=
 =?us-ascii?Q?gyRycx8HrYG/5kQ+C8BCBOCWdqb+24+PGsdE33iRrTYE4InzdVytsi4agpG/?=
 =?us-ascii?Q?JqHAhtfD+wAS4gejTV2x63/s5GkkC1IMzo+R2HgKuxrct4IVdipQcsmKOdyN?=
 =?us-ascii?Q?FYctnwzQfqEfCGOuLp99CGLqRXtnSd5pxu2mt7CKtWwSXJ1CfuVAS8ownpqy?=
 =?us-ascii?Q?+XK3QLuSaZ/yQmn8QZU7TzSP5sphs0wW6JI2jcQ2LM4BIZFGH+XzKIaoONPD?=
 =?us-ascii?Q?MeObj4jWM+QsIB5bHjRdv+6OItNEZBqTAasvTPDWR1Hq5EEburJwFhkgy9AI?=
 =?us-ascii?Q?P5hpwSySq2jLH7GETRmyyHamf8zJRNNs9gn4rypPDG+jZ3SrTmvLnPtZ/FiB?=
 =?us-ascii?Q?Dk5cfCrE82GA6VnM2wZm5KoyiLU5URZ2VUhfqhCj8CSAdzGJT4EF3AD8i6vV?=
 =?us-ascii?Q?DSPTsQhOqAtJ5l5QjtPlJRFqU3X+qijWAY77cKRP86KocMjD+yT44S0lDP0d?=
 =?us-ascii?Q?4gk+k1idETmmjoCp2ub+tuUrwx55IJPnTMQ10SC+SKe67VNPGGRTg+rLbvU+?=
 =?us-ascii?Q?4f5EnHFFhtjA4twjIaOE/rKWOmFvLVEZ63u01rPfHSzW/feVRUFdqLtWlwf2?=
 =?us-ascii?Q?zkXPB3hOFCi5jXP64UdAiVzAp41+FYAq802bvCUfg+72ZsN2dA8K88fZwrgr?=
 =?us-ascii?Q?vxInIR/qF5qBYG9tvoVAtJC7/nC8vD9uelb6fYQYm/EzxvY7tGM5uOUkhZmk?=
 =?us-ascii?Q?OWMAv343/HjrxBbJ2G65xDoNME/+xoTBX0wuiGK9Rt6mt6aIoMhOSExd3Nst?=
 =?us-ascii?Q?JWd3BEd/fJmIH4Ob9VEQpBNSAWNQHNR1LYP4DbDdvdI7mF3EmI1Eu2SbIjKt?=
 =?us-ascii?Q?6Ts+ucsS8E8hxOXxc57YvpWLJJt/c55jfPh06gjNn5CQ/bKYSPrLXyv3YYnY?=
 =?us-ascii?Q?FU9EN7VZRWAu7gZ9cugtgby5dEWw2yFe+umy253+qeiZgZcKnQtEkXwSfEZf?=
 =?us-ascii?Q?uTCg3qlV2xeJPy3qVml/ShlT0r9WqPdDiXZsRvqp53z7w24MRcE62Jea8GLt?=
 =?us-ascii?Q?t2nVA/N9Fl/mkOhfwOsJtRoZLIsibxT9bJOi+6ol8NprpJQPN9c4uIgngo7E?=
 =?us-ascii?Q?AkTpCuFUpGWW8h9mMu8mJMhgzcD8ZumuUXrbVbdq82SPgRUUWtD4hkPWicWP?=
 =?us-ascii?Q?G2CwKgMjDUVfCCI56YZ4LEtoXFeK3/NCrpqhNps6vZccEDUelclQaKKryFnd?=
 =?us-ascii?Q?ZcX6nJkbz3dGdi+33sxULA7wonVXqyTuxfBf/iEqXYL6eS0FvsC8zLyaY7yb?=
 =?us-ascii?Q?GRrHFkMEycguFX53g4NmJPNyJ6PzIB+b7pFsTmIr/pWzukbWsqXmhaSHjp3m?=
 =?us-ascii?Q?/zcktQmcAUnHYWd9dB0ULdU4Uag7LXUzQyM5x4WNn2mfe1grXXN6IH2Rwkgo?=
 =?us-ascii?Q?fNDXwEZmgR+vClfdamJYpMTmlF8vnUyte8mfbwllHwyKL3v0/GI+yZzlnQxT?=
 =?us-ascii?Q?R9a+TWthpMsm7Plz/RjEcogJ3rxgmiVTD0G522wS5a5OLi4D6YphM//uOfP2?=
 =?us-ascii?Q?svSCyBFoZrKXPupx+Uo5S8hFQv9EypMJuSTV6mOr2uJoAwiY7f/fuHKKP7kj?=
 =?us-ascii?Q?nEzSA7CdTwPy4OGJAsXL80sSl0f1beU=3D?=
X-Exchange-RoutingPolicyChecked: gM7OKpfg5lwO3yXIi4TDhubCqtqxOq+ZaRmV+Dg7Q9+JDMVTNwduYK4O/mTTWCnDFzOKwZJMgHVW78BEsr1sHa0zaazPOzuUqixkviv5bcWBkfp/9i6FvOmvHK/Um1DE0tN/ch+6fwlmhSgktTXzFx2EhQn3D5ZIOUQzl0+CA5MBHtkXYZpBf+Zm4X4KKH3VF1woWG5UKUq5jQONV9AHxjYIcI7w80j8jiIX+E92B4sC6hpDQqYFUwREH8u4tUoaFpblE9o3mhgWyjxx7g95YAE8GithopWGuZMj3K39G+AcsOyCUmGk/v7SBLrEaBxxEGTnNULsBFWbJiMYIGAVrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3d445c-a645-4ff8-9ad1-08def93d410c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:17:41.4303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbqfTYy65a4AeEz4pHXYuLRZ7J9yFpDqLPVmXDR7nO1jEvh2ms1JwexUXAmWIHnLPPMaH6uIpcZviKKXGM+djo7xke187zNeporu1OPXuU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
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

On Thu, Aug 13, 2026 at 02:12:54PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v2 2/7] net/iavf: defer device start when PF VSI not ready
> > 
> > During reset recovery iavf_dev_start() might fail (typically -EIO
> > from VIRTCHNL_OP_CONFIG_VSI_QUEUES) because the PF VSI is not yet
> > active, leaving the VF down and requiring manual intervention
> > to recover.
> > 
> > Added a start_pending flag: when device start fails during recovery,
> > defer it instead of erroring out and resume it from newly added
> > iavf_resume_pending_start() on the next link-up event, so the
> > VF comes back automatically.
> > 
> > Fixes: 105d9fcefbee ("net/iavf: fix race condition on link status change")
> 
> I don't think this is the correct Fixes tag. It seems like an issue that has
> been present since the recovery path was introduced. Maybe:
> 3e6a5d2d310a ("net/iavf: add devargs to enable VF auto-reset") ?
> 
> > 
> > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > ---
>

If the rest of the series is ok, I can fix up things like fixes tags and
log message changes on commit, so no need to do up a new version just for
this alone 

/Bruce
