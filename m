Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0999ECDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 10:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B6340150;
	Mon, 22 Jun 2026 12:28:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 021134003C
 for <dev@dpdk.org>; Mon, 22 Jun 2026 12:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782124103; x=1813660103;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=j4VXtmu3nmGzC75NIWXbvTH4PEdkK9ts+m0wftqIpk8=;
 b=coLhbvvKDf8HyUy5PbKlVp+HXskfSQ2mPXO9Q+qJQ2X6FTKx9OwRyfnV
 NjkFGSboZfbSdeQ/sx7QXyAeptwEfSOpbjNsAWVN10A0PgjnpfW+sq7qE
 LQS0cXWXalssVCwfhOjFY/gJ/qiQoP5gpsIQpj+s8XE/z4iV+gNBk9Sjf
 hKw2v273/+Npt3sKLys98WJ0ll4g8iCHzRkDgsOzV97e4EHuwvNqT8ZZE
 AFTllbmFSYpg8Vhv0z8kuSBzSmRfCVGDHOb43LDOW/mhCkprxOZNE3H1n
 lyXLLNocu+o3TZuSpBSOb8FJ79dsP2f7cmtUXZZK8oMPIMz1p56L1EGw9 Q==;
X-CSE-ConnectionGUID: g8V5wtaRQO+gpul6WnibPg==
X-CSE-MsgGUID: MD9yOgNkTwCVd8bwl9TS3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82734670"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="82734670"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:28:21 -0700
X-CSE-ConnectionGUID: KC9tmQ1DT7a8QynCUIsWbA==
X-CSE-MsgGUID: 8T96WkkCTmyk8AuvLMXffw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="248309412"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:28:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 03:28:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 03:28:20 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.36)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 03:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCMxvHjptiKfc8fpr0KLQ/daHH2ye1r4okWONRLEj924QM9dvIAUp7yPEYDijAlB62TGTNNDwf7iKP7hJ8s2prcGQc3KuiR6m/PStmfdu8O9//TJ7ueQLCiCSf7om8POtwKJ2uvtORrFWVXBAdyNlmAgrLZtPXfn5ArworhQTKPsrgM3oId7pDv1h5Au5AS/Qhf/uB+HkPU+h2SoAjyVqJ92bSyGMN+JQ991rq2htsxMkzR7B/BVX4X9+G6GZynBXHIdv7gVLwleAORo4PpT815fcJmHwD1Kc3vN6lWaSojdBzcFkga7hv6bT6tHZdVGgmepo8aGt2omz4PM/EoeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQtzSlCIx6gHcKFCeBDu5zdiQXJA+jE7ngcXxrX5ZMk=;
 b=PbDx3n/yG6N01JVQt21rPPVFMso830sE2wMGpILcToas/UYsQYizLf6MV1ONtZKhEEXhfdKVg8nYEVtn8dqvakIB+EDtcoohq6+mLByxZMwZiVfsUDM5Sm7n497fLXoVWc9LWgs2KNIZslJ9IRVrtqpT5ThV0CF0XXpHfAj0/xa9tOo6Fgu0HxFFMCHAEaHsbfzNHWLQoAYySw8uRO8Yqdq3a+8G79yYW8NSMXRgtJStKeOhlXX5M2ufui3YKKK4f1jRSNqA4IgB+zUjunif3PPR0aqhW7qObsasH2pp+oFZdDeiJM3qiPPsFYdj+82tT/I22mnNsqHhZkgdmKvowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH8PR11MB9606.namprd11.prod.outlook.com (2603:10b6:510:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 10:28:12 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 10:28:12 +0000
Date: Mon, 22 Jun 2026 11:28:08 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <longli@microsoft.com>, <hemant.agrawal@nxp.com>,
 Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH v2 09/10] bus/vmbus: store name in bus specific device
Message-ID: <ajkOOCatmPJNHcBF@bricha3-mobl1.ger.corp.intel.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260618152826.490569-1-david.marchand@redhat.com>
 <20260618152826.490569-10-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618152826.490569-10-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0278.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::23) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH8PR11MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: 4526e0f3-c624-4077-e9c4-08ded048f653
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +auXDygMfS4SkEnRMrwlG30wd1M2TNMABsXdL/AlafzSsD6kmyKR+emXpGbGnUDkrkeAnIJ/bQhjtweirl6I2L1TlNwWnfYtz+6vY063rUHTGli3hWDuC83EClgQxJ94ruCmIBSoBkRppphjgdSvlJQkmwUxMH2UQ1WnuEBZ0qNyvuXo0s2Z/SGPr/IFad6QbMV7uPqBLMJrygiJU8ILZ00iuqns2BhXu9PPUskG8qHKhr8Uq0aqz9SxK3p5IoXrt4T7zyMj/WUubQMA6ey3SoxL66g8YYJ66s/NpqJQbRizBGglnJq26CYQkV+jUfz0Ihgh+G56I9AnkpU3IcYIiUGhxZhbCUf7mBmvV1Pae3MHgdTHXI9+YeZyO5/+v6gAe+Y6Mdg5VIQN1jpbY47xYBl9uUF6MUSqlQmtZGqOVwT2iUI98q7iYM0ytRY4H+ivEPfbZQy93pTJkb+b61Vfiy9NroHHAeM7G0pdZg96bUo1Ye3QZevhwCBDxRrqTZ/u6jaVmAuB1fX0mKqE7ftqxNbAqRYvEhg29F2ZYszh2bXXv9q7XqDWjL2wSkDPC4zUUU7CW1xG51uJab+UVygq8RfIDYUGvibU9iiXXAoqS1UEie2BGDZlJcdARvM5zk1kUuI21fRqSUrKiQm42qKRl6Y/UyQ2Pcs49l6woXk6ID0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tveayNJY4EdV9WGDAT6cYL90YSnrxlMiGelGwWSWr3M/8zVgw7b0E8RKOMd0?=
 =?us-ascii?Q?7FiDtIFmUQn+Czcp3GBUEi2bj9Z7c+EVCNX6f6iaKPmGPeIwGYn2Wpc6OHMa?=
 =?us-ascii?Q?0g5nBTGjrIvT2g6PyPex4XVyNV5dJoNMhaaeq/pJ01L7UAxk1zLw5lz0IPNs?=
 =?us-ascii?Q?8gJS6MmypycdGPI8MligDzAiCRHptnGNtnkQbMHcr27Pua+Ongbal/iD7607?=
 =?us-ascii?Q?OCIdbL+blC6IIJn80p0cQUrvCpAUgje5wyUpLCb1A9ert1R40/6rIKh4bmpt?=
 =?us-ascii?Q?xflY33rcd+FbqOqosCLbYZ2L0NwLkTE07R16FA8Is/GjKbidoluAmCzVg2df?=
 =?us-ascii?Q?4STeuQO4U/voJBDF3Y0LGrXljOqT2zMUo23OU/jTFKUxlgpMK+Uvhu1a7o31?=
 =?us-ascii?Q?49IkUFgtK1f309p3vUJQSvxsfU0oq7M8H80vtt03/i9SSOl2J4nqyKRrGqFb?=
 =?us-ascii?Q?S3rodb1pqWs2szRtiRmQY5/zdAZeRG1CpPkjTV4PmRYmrZ2xMOjyflNLXWVN?=
 =?us-ascii?Q?NinLfK2Z82GTxCBYptkuMKFxkmVcvYJOQamCH4L50AaN+bTNbrRI6TC9Nid+?=
 =?us-ascii?Q?eSZWxvxj+bzlj91dukhAtwsRiHqmgPnBgEd1D2WYXU+lvFFQ7uLkIxArNfk5?=
 =?us-ascii?Q?N7zSw5ZhcA7kLj8qfELpOhpvPnymItieG8eLK7bnSJDo8iNdny7JPWhEXg5S?=
 =?us-ascii?Q?Equ6NbEhSjJETfixhZpbmXhrWTPwBGczrWGt75w9YivR2YZkxGkQVhNMKkUB?=
 =?us-ascii?Q?Rr71qUdnit96A8o3iRGYUL4fCct2ZTJ1UYoJJzF9cl3iDXShKECQx2j0AsN2?=
 =?us-ascii?Q?owxQuA+rKQVUlf86BQHZ26+DbTd+CER214asGBrlZHumG1tjKFQIRKf6dkrd?=
 =?us-ascii?Q?U+Ra5acjbN27SAR0+4KJVhqt6dhJOH66WIMRCrkMLPs/l1an78pP2Eapu9/n?=
 =?us-ascii?Q?qJPV0Tci/sXHszkutku6axe7BnGOaAXUnxf8UQ978FAx5VTJQSOMjexrNV/M?=
 =?us-ascii?Q?LEjoOjXXO4lylPXcDkwQgGOwBgYrrh4d/sbLcsX++WRUzR1Gx+js+vVAYQeZ?=
 =?us-ascii?Q?VXBBiVrz/WUdyM3z0F/a2K0qUkXLdRwq9rZrvBn00VwxDzkuz1ayoBZQe+Mr?=
 =?us-ascii?Q?BXc64T07UtiXj6AavcE3lxcVoSG6fyPQpY+1cBA0huGbkT0QDeVGQB8BdcqQ?=
 =?us-ascii?Q?DwHBOLf9reaXBWkwfRHb2/USyg/Efn9PpODY0EalAeigya7LkOw7+DlyBNBi?=
 =?us-ascii?Q?37yYKgGxB9p4dd6q2wiCObIIbWv5qRJap9TE9Eq2xePVqd1P6XES57VX1p5R?=
 =?us-ascii?Q?/4p+mAnx2Iomjww6cVEf9PCPEQ6PPIkVCNWKaou7GoTpTt0Ol+umUya0juk4?=
 =?us-ascii?Q?bKrMTB/O3ucTIwgFYZOjW1yfWKhBOAK0ns5hD2hkVAUHwVWGnVXuLZo9/Cte?=
 =?us-ascii?Q?mf3O+orSlWAo4zoYLK+nm/lpuLzhwJk8Hoyoe7cSj/4JHrd26tdXKFKeqPrt?=
 =?us-ascii?Q?EPN+UyyOE/HpnBSbPQ/w/jdthqJDrr18CKOZbfGg+IM9b7rErFV6gEKU8hqb?=
 =?us-ascii?Q?K5FmAKNOs8pkRTuj+O90VR5P3EkvzWczJCbDqjq4SRyudOQxio/wFZDvaiT4?=
 =?us-ascii?Q?ZoGcBbFd2vJarCBY8WCeBO5Xi79WNQas8UlLJlf8d2f4lGP2q+7Njar+LrOj?=
 =?us-ascii?Q?NhDCYPgIrDbGEJoXzoPqlxyLDGFdJTFyr/Hzi7iDP63BcpAA0v1o14THeS1B?=
 =?us-ascii?Q?UHKgpKMvMYKlTLAR/130a5tlvTCZrV0=3D?=
X-Exchange-RoutingPolicyChecked: fxQ6z2+QGWkEI/VSDtveMEdFn8QFcIcCZl0kOqzXURU8xn3sCFdfT3pFUOBkd+Gw+X0SoIKhi/Ek3X3lMApvQCO9eQWkErt1/T+XDn2e5UGHmmubzgbyTJJ9WXlW87ewvd9za+5G87KB9eWc2mQKeJhnwbc5oy6DQ9KYEEc85fYKyScyb7MLPtYNmnh9FqApVt5EoiyE5PKjGPtq0YQRx6rrg8aJ0/i0tQn7kBDEWrdqcwtxtfWXI0K1Bqqf4R75eQ3UMsXf1rwA5mqhQxVuZ/W3i7gQtveJi17eb5FC2FIP5eZn/FZDJi/c0I35urBxamHxV0LHcXUmcsyo3IoI4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4526e0f3-c624-4077-e9c4-08ded048f653
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:28:12.3378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc0UOaXteZ80EoSIumczA6QqkP+9HpPaMgo6GuIIQIYok7/R5gTTGDe4lNvfAthUcX7aW5rx0sY/EusfNY5uFzIK0QVN9wi6nBXCFlafZkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9606
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

On Thu, Jun 18, 2026 at 05:28:24PM +0200, David Marchand wrote:
> The device name is allocated with strdup() during scan and freed in
> several places. However, when this bus cleanup is converted to use the
> EAL generic helper, freeing the device object will require a custom
> helper to also free the device name (and for this, a cast will be
> needed).
> 
> Instead, add an embedded name array to rte_vmbus_device structure
> (char name[RTE_DEV_NAME_MAX_LEN]) which is sufficient for all VMBUS
> device names (UUID format: 36 characters, or shorter legacy format).
> 
> This simplifies the device freeing to a simple free() call.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Seems reasonable to me.
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

