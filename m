Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6CDCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F389540659;
	Wed, 12 Nov 2025 10:31:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id AE67B402E1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:31:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762939881; x=1794475881;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OVC+B2pR9F9sGbESyAGlLrtNkNBSzkKMGEXBsBV1yTg=;
 b=mvftrfzSXTesij1zdp1vtZwExkt+dzsuFLnHfADM1ovBw6afLDuML7+d
 FDkb0jTjuhx+vuZ7/P8wpHegeZJ7OIPxd+pGflafLfUDajAoL9ma8g2P5
 hrOgOWoOffODh/p2zBiNZyIItWJK46FAVfWB4J6f7EFzFn/tvVkeyqgd9
 IqMbjdtiarv2qn13b48/IxmqF6DyHSrtaL2kkygTfIvZBReqpPQPafwij
 Yw+LW/+KgXzWD0XxBRsp3XUwxnPM0sGq7ul7BObgq5w9eO9yqkLK/OSyp
 3EVwHwd7bFKQJQjq3IsK6Q6NAwI5Yc88MQnBsASc0krWt/lbJSLREXLBn g==;
X-CSE-ConnectionGUID: +rTkVWd8SyaBisBxbGPfWQ==
X-CSE-MsgGUID: mRp2oqLzTJG4MPhZ9LixFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64006520"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64006520"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 01:31:20 -0800
X-CSE-ConnectionGUID: l1blKUAGRHilL4L6/QL3Cw==
X-CSE-MsgGUID: yCGvZ0yST9y1gRjNa/Zpew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="189899469"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 01:31:20 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 01:31:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 01:31:19 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.55)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 01:31:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qht6NW16591MHI5UfB748bNbz3RD9S03+fEsvM5Ws1u78MBTWu9WSTlocOzS38oqKo1QOd2o4JF32no9utywuZo9T2RJPHXbR1099Auql14WTgjKxCdbt2hDP3Yl02GK2eAUZUFKQP0wd9QuE/dr/nKBQzPt+vdz0tJQ0iG9WaxcW0SelQRpMweQar28XT4WFMr5pXFNx+w2h08c/6qn8e349SxFEfPqHLUYCw07waqtCK15loo6RC05V/6A9yYXZBnatfbJ7WA3d3YRFZadqo1pyTFYs6wpTpuTtKIT76neEOVZNgOjPdJX16vpVhP/FvPnx8Q72eIL7Hml1XVaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUNEsCkSiCR7zFs8+zVRR2JIgpmYHafUPTUwYNcGKnU=;
 b=uKsOtCLyULg+YRogBehKqlM6h+PP1dC4SHuoaB/VD7uFD/xsD8nR6+7euBjNWhTI8uZM78ubXJFl5wVmQ9GmGWu+2mjRNudVifgfQr5cVvoWYsEKqOxf16g0ezDE9fm8xwBIgAceKJ4PcboIjoKh0d7pQL2IkIFRfhzbaYzpXuqDMOB6jq5+e3Mo0giR51ujrTqrXGYKbsQPPisl50Ze7sLSnvFTvqTAv2XR4sKFQ4Oq3ETNinb4AIkuA8rU4j0SgaD6n0AFHe42Mrbqbhw0CLb1lxTGAWJmQfemBn0PWqC45RTtkmtp29+3tMWg9y3++V/iUaVI3UyZ7boxy8NmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB6987.namprd11.prod.outlook.com (2603:10b6:930:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:31:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:31:16 +0000
Date: Wed, 12 Nov 2025 09:31:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] license: standardize SPDX tag for 3-Clause BSD
Message-ID: <aRRT31JDkFl1hpsI@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112091335.662991-1-thomas@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dbef99-247b-4d85-ff9c-08de21ce3a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?krZ2NpEhF1y2bRtp3sXB5dFFtVaRt/qp+eQpdNM0CovATYjT0/N4PlpdbiO1?=
 =?us-ascii?Q?HgN0w49KVXgXOC2+0AGbagibL+/41/x6EsW6lCKMyAUSTekbP6479eqvLxGP?=
 =?us-ascii?Q?sxn4kFdSeUH2hhRpl6YTAQO5IURSZSRi1CIG8YhPmWFx4s6wO4sprO4Nqe6o?=
 =?us-ascii?Q?P37Mku1rlfSd7nK4Mske/fKHJiTLBpZ2Jyq9rt1JMYKDBZTIg4D0XD2SapW8?=
 =?us-ascii?Q?TWwKRWyEo1MH8p3PjHmCoxEerBvFUDzeQPM//XJjkBAEssPVgdFSA8QoyyRG?=
 =?us-ascii?Q?W6p7vAZGAnVkawBRtVtCc8QDnBF6Pv9+JJjKFJ4Mvj8C3h5aU3KFzQljRi2z?=
 =?us-ascii?Q?3i5NggCFrbX7+1XqzwgqHz6QZWTG1u6aypL8fW0nHtzSgGUuZKQsfb8kea6l?=
 =?us-ascii?Q?mgxYAHUtQt88W6LBkoujfV2WfNuhe3ERpmXFBLCTiaIvLvqZsa/RTbVmCtKE?=
 =?us-ascii?Q?8Rms6waUNcsAW8lAURjKZw0lHTptnAKU2troi9+g+nlACv7HYMmEnwMLA9Lz?=
 =?us-ascii?Q?GyAYv4wdkjB1ydHZt2fYTx8MBnQ4DbGPH3OfcKAicdeewE5FVhPm0w6IGACl?=
 =?us-ascii?Q?PPIFo7OkKCxvoq8cZXCXYSmDwX7Nh9Bkl5hSVp+Wrm6FPN8/5H9u3v7xXxZE?=
 =?us-ascii?Q?k0mnKpmSIa1s6FkIUWrLdr7aMvVNIzoX0UOiUEh81/fHuD5R4LpLbWCcTlaG?=
 =?us-ascii?Q?aBtgHnG2X29NvdaM/hvngetJ0f6u5VoLlfl9xLcLNf82quxwLFKXTfooDMht?=
 =?us-ascii?Q?aHXJFccNNV5kITJ7b1PwESqLJe4UG3pq1Gc4XFfD9rofjTv02HFRmUIJ8OR8?=
 =?us-ascii?Q?lw0eYKqKREgMsb14TKE4MTzFn4wdgJ2O2rDip3t9Q5UP0kZJWdObjv7kIQzj?=
 =?us-ascii?Q?FNTmCSbFANb/9MHw77IcYdoC6i1OFpReLMkHtwTWNfDHDEUqI35pBYcK8g8P?=
 =?us-ascii?Q?eYozkGBkZSdOPkZzkdF6crRqLfWXH+12HhaY00D0MbU+uEYr3zxTp8zCtbDW?=
 =?us-ascii?Q?r2l5dGw1mhp9r69yeQTwZxkiKwwGBXbYUAnYlOYfdyZxB+oWRknpfl4gKKGl?=
 =?us-ascii?Q?dMUNEOlh7jLR20wF6rVaIGKyCYLuY2OfGKGj4spPcmyY5JHcUg9EIjzCLrSz?=
 =?us-ascii?Q?WHSBm3KFY7UvvCDv/p46Q94+BdbdRy/CpHb9dqQD8Zchfg6JCdR1X5Y3jQfw?=
 =?us-ascii?Q?JTRy36Fe1aL/JP/Sc/Yzy/iil8CAagNxxG4uTOua4NH3VAOP6C45CQeaR3F3?=
 =?us-ascii?Q?7jVJxvmZNDp6XIgRBHFLb0upf2ZHhOW0t+C61XaKobs2/5viZCzquR5kbSGl?=
 =?us-ascii?Q?eXClo5KwnEFM8+Lbnlw0HYeiuCKcYdGRVv4SbiufC/CusDcw2fIPiKY545vc?=
 =?us-ascii?Q?Bzqb6Ub/sMx+wXWVXF7PrkkBmNjCCTMKplL2hMI92wb59wYzQA+6zUU3Uc4R?=
 =?us-ascii?Q?HeFz3CMf40sNACL8Q91PGIMTWqd9y736?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FaFJR+Vo8lo/dj/73Gvt96QeeVvxzM8tyyBj01dpcNcdg7ThJz1De6/MS+64?=
 =?us-ascii?Q?gXnQVZIkRayZzhqitanBiGGR55x9nUycYXSLWDHBl9Oi6OyLby0IKDDJGT92?=
 =?us-ascii?Q?kEuIYrUVsYdf67xPgujPflV2d3guBWBlCAQgr8dj3q0R5MtGGw5pItm9Ms7+?=
 =?us-ascii?Q?avqgiTYBkNpGu9F99EqaNVo+AVRxOjf9j2T1IMMxXw0DNjuEGhP70XCXJKi1?=
 =?us-ascii?Q?8ppWTx8U6G0VzoVGs97vJP0THJnNDKd3UAXaSx/tJ4Pv/znS4zYcvofwcx2/?=
 =?us-ascii?Q?lMPt8D0vX4h2/wURpUFHXkjlTC6M6Nyick7zxFhGVfHJbxo6p3ghui9XqPC8?=
 =?us-ascii?Q?TdDDdIZmRxKFxeAs1Mhvb7nLZrs6kzaVz8WB0Tkl+qHEaVi21Hb6Mdp7VBBU?=
 =?us-ascii?Q?eE/1F9etjTNJSCAmrFqfcgNiw4UeNV3tKYF3v0bbZHFc+XoTfLdwrzZvV1vw?=
 =?us-ascii?Q?Mqt9k0WVjXL1lK7PiSorVU497E7JO99g2ehIyhGjJwjCUriRL/o1oJNCJbeE?=
 =?us-ascii?Q?Xw6HHu4y/EuI+yMBwzh7J8I9NCEDc3QUUV+4VjnHktLe2Aj8HQoYU1b5l0pj?=
 =?us-ascii?Q?5BReFgOe64naEkNtgf0H+MteYBRa/TAzm0VvtaOzFtrjPefj/02f3jMpX70+?=
 =?us-ascii?Q?92cyPzlkpMiC2IguvUrgHlkjSpsWQ0QJXLq36stqmLEP6BA+aSLvQzLkuuBX?=
 =?us-ascii?Q?sDI8/Gm3EvGiFEDcTf900QOcR0+fkqRxLI87pvf2OvUFQlx4fu2EXfoQ3HMt?=
 =?us-ascii?Q?eoTxJOKoP+lUm2TPb4ydCyingYrMiFf0sEHw5BelLv+MCuxmeZlrRNtJcj2B?=
 =?us-ascii?Q?8hUl1vInNo8SQdmzXyJ8LI7Ue/UnwPCeokK8yqWsTGp9KoZmSpiDNA8RBdc7?=
 =?us-ascii?Q?V7uieGlTdU7/9aKtph/mDeM4YGrgrUV4B95fuZp5/izdntalMnUhk+74hs4T?=
 =?us-ascii?Q?mRWtfWfXtrPcM6xBJ8qvRG9GwTpDHf4PIRHha+SZ2enE4p5pSikmSewd2Lxp?=
 =?us-ascii?Q?7sDbYiGW+AKFS4gtKWNIOxcghNnzpoetl3SRmu26z6tJn0jti/GJQ5vSaObN?=
 =?us-ascii?Q?qYl6d0fYXXPDqRATBjpSwblExQ3nhih/zM2TZJV2IMZPBDl5vANevcphQ/sk?=
 =?us-ascii?Q?iDzy3XAnlWpSbC8L3kRh6hQPfEirDYCFX3ya0oxpqAtJHrrq7RwboLk2s90W?=
 =?us-ascii?Q?16RLrb+2NH1PfXGSUpMLXDo87E3j9mHmGMiKgljwfiz2NoujLYPo+pCqrH61?=
 =?us-ascii?Q?dMPydAAqdu52aNUot1kPLp4oW9OMYKf9NqskhkCJBJln/sCBjB11Pd+yapDs?=
 =?us-ascii?Q?mhZSX+fpHecov8PMsOEiATQmxKkF5obzPovN7ZGvE10f+73gYBFln1/wKYSy?=
 =?us-ascii?Q?4EuVwgAPll7dI95tsemR1++LQXC4WZd26hMkU5ikcCwOeBjAH2Gr5qm5icY8?=
 =?us-ascii?Q?lZqJkXCiryoisHaCm5n714N3sHgSg7jtSHszQ1gKkrIHIHfYWk8xIDfcCSxE?=
 =?us-ascii?Q?OTg9NCWbr8wp84qwTVbjfhFrgBJLHnScmOEV6bzw9UxvGE6F/6pt04kU16AW?=
 =?us-ascii?Q?4AMMEb8RIXgbIXAtwu9lMdDtyhy6Py2boSl/H8fRBy/p0X3h0I2/aRbxvKCa?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dbef99-247b-4d85-ff9c-08de21ce3a84
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:31:16.3298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehSkscy9noogdphKRFbFZezfEbX1qyA/h/niXC8TxYDerqpFyVKdLWVdJoLm5Ou3qSAW+5ZP7B1Fg7Mth98nOs0J0kyKhsId4zmb1FRXFzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987
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

On Wed, Nov 12, 2025 at 10:13:35AM +0100, Thomas Monjalon wrote:
> Make sure the SPDX tag is used as defined in license/README.
> Reduce separator to single space.
> Use parenthesis and uppercased "OR" when a second license is applied.
> 

Upper-case or is fine, I suppose, but I'm not convinced we need the
parentheses. However, I see other drivers tend to have it, so let's
standardize on that.

> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

