Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A61EFD20D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 09:01:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7402F402E6;
	Wed, 25 Feb 2026 10:01:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8B1D4402E6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 10:01:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772010061; x=1803546061;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VIqQ+/wd7tlYMdEbXAy9vIkNw4VapvgKbEYXF/Ah8uU=;
 b=M4bou8bq/SiS1jfgSVCm9x1Bz//AzMbdHE9L80x0j+FZSQ+dgYPm8T47
 dn9YkHa1OiF3ifpwG7fEkW/gN2AYlfBoH1aSbgI8b0aUaIyYNgYuGdgGz
 LbzPcvGZ1XBaKrBxrMPu0Aejp8XzuDro0U5akf58+nWiF8utWY6wTsq2D
 XTAVOHQb0vru10zg6HSAypzo7dmsumZtHHVu57MPioJ0DwDEtMLMf465p
 sfRpRkoSW8D3MiVMOM9Fas8/SESN5mCJORjMFCtGLJj8+swTrWWVMsIxV
 +VlvcXvfxvtm7DgXz3h/V9dxGl4LAXPmiVM+LQo07IhmJ2MQz0VzHt9i7 A==;
X-CSE-ConnectionGUID: pZaJvba5REKXXe5sHyg/Ew==
X-CSE-MsgGUID: b74OgevGQVehHJkk9ogYTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72948631"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="72948631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 01:01:00 -0800
X-CSE-ConnectionGUID: pTYMCcy8TRainAxjRmh2oA==
X-CSE-MsgGUID: tSvi23ZMSHKe6hrwpT8IRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="214482710"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 01:01:00 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:00:59 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 01:00:59 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:00:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2GpZgt3Dq9x/spjCkUUKHVw9PP6GcNsSyHGwRy++nw/tbbxIxPvSx4+2sYpLzo0Do4nYJaFfXJqk++C57iA0FhfA12W1as0w6XkDsxvjCjpysaU/2257hriLNQ/CrD/kxL6/+uKmITGWuvVqfXqaakbtddyKbcqns8d4+FILcvlTzhSnOiHhYqtif3YEHqNFU8J+4gfTkqJiSSPrwN9gaFj7N79HjpJpGlniMMVeOLp2gcy27DuTIJJUOlRWqOh1abGfuCIpEgU0c/k4WExZ6Chzo4WwC3F+OowTiDV1mtR0FMNaYyXGscvDLRJso+9RgWwsZzKnq4M3qq0yWUp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kxb5jak7sSTdk46zSRs6lq6omnXVIK2ohwhXb/fq8I=;
 b=SJc79vSWsvYOUItkeexTyCn9xGQ4D4f3NKsiFAE1wsdr2wKc+kIXWk7w60SykeDZ16OeRu3qswvffmWovWZ26tS7ZaQUKlQRlnW9RreE3Cx76AAbtnsgb/utWRh6g+RidqhuCAPLrm17UMF9YGqJYjPwr3qScJxMkcHZtLjc5QGCYotNzz3HjiVr9Lxc82J2vcB0O2Jlu3mdAHaAGcPRhD0pFm56+Qw6xjLX5BMAa9b4gZqbv9aRsVZNHDmOI/mfZgqvLAd3QcTBfoTqbNiNpIT35Mi5vA2vmwwcWoYAMRN5rZchZFhPQUAfsf5Mg3qogjPf8LLgSOe6rgy7mX8AvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 09:00:57 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:00:57 +0000
Date: Wed, 25 Feb 2026 09:00:52 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/idpf: fix typo in CQ scan threshold macro name
Message-ID: <aZ66RPUsOpEpq1MU@bricha3-mobl1.ger.corp.intel.com>
References: <20260225085333.2740447-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225085333.2740447-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DB8PR06CA0061.eurprd06.prod.outlook.com
 (2603:10a6:10:120::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5810abee-8f2b-43fd-77c4-08de744c637f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 1WoRhtA/DahD8CKPPjyXlOm/vDZkkUWvBp/alZHZELDBsn4ap3WT9RKsIAOIe7GDZb1kbIHxKHds0e2fKWZ83rrW9oJWlk/nEh+qURJDQgHcc1Xf7CDI1N8FaHKjvlhsE3WfkzU0KqVavn1s6thEVZhPFZJ14j4SWQ7miSTvTBBKrYyVPI8S8DsTrrk5Xpuc5c4kkDd2HQVF9PCux1pft3vA77F2KcCsS5D5zejYjeYhpxy8NQTnNB2dBy7bee+zlIpC6JHxh1LaS/OZMVUEPS2ajlEPu6Bhc2HBbXZJRwQVKQk5emHsY83l+KvFG4wxu4J948yZPbM5lSCSTF3rJ3PSjjy6NXXdz/oM8Mhmz1jAIBFr+uOO6K1sNKZtfng8yyAeaHTxQ5NvqTNziFOfj+tVOgdcc4YYVBdtsU7n23A8paSai3/Pj3RCWbopXW31fOvllCqD/OPXneEUSoPduMtmN57bdI4yjNOxt33Om33cr5kXoBL7EJ/FPXU0oosybAiq7nf09U6aflX3pf4POLapdgp9HQlTx53CZFcUez7jcaIPNnCBbwQkc81azaGKc9niIsyj8Oohj+2MugHCo5Iw1kxx22GpS/LH5oMLBMb0Jq37tOGVEqgcE2GBMbUlDrW9mgu380kxKK1JcwtRShP0T6Tunt9HqgvgMXCCPyEexjY1/WsegpWjC2G/QTBOO6UBK6C2RfpMkzdI+8XvrYtIjuchkxaO1QUVOI/fabM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDD0i0gI+M8KIBBpKTEUWipqb6NPrrKN2y+B1A/gULxKSqm0H0nBtHYJU+RB?=
 =?us-ascii?Q?dZQsjZk8XRksddlNSaBpnDUtycCI1ctqNH9cEvqaiZmwXnHO6Er56S8kY7lb?=
 =?us-ascii?Q?buN5kl5q+UlPZauBFn43PJBzx77W83G3DIWXBRztQ7UwUiovMtQCn28vahT5?=
 =?us-ascii?Q?c5Xc5nwMHiipax+bEzkMuqDh45BJIX8Q4dVYY78IP6sQaPhPmAEhdDHc2jch?=
 =?us-ascii?Q?B+8ZXLOXAOsXvCzV+prus59a/mVPQ07vZnCKSjODsfbqcdNEBG7RmAEsxKHL?=
 =?us-ascii?Q?/BrAlB8QmjxLxL4dVlwGP2wFrJ5lhbCRTfsCD01JQjgFHPf3laA7fyZQfyax?=
 =?us-ascii?Q?FXIjVadYQi8ESACidS8XE2aYeXLdBQbpHaWenQ0Z3ccjtUKK1gzsOo5JMmjY?=
 =?us-ascii?Q?5ZySLoGRAFMqROZiH+aueVymPA8e80fdRSQHnsQv7VOShgwyxNClhXOaaIny?=
 =?us-ascii?Q?qYnqsimikN172mTS8FV4x7TczVIZkNBXAWnOgllCXq4hr5RfMz6uGIN5n7MW?=
 =?us-ascii?Q?TjSz+uhdPuor13DzbyqrBEmA4C3co2EM8zzUAWyoX0PFFPE8Ebo234mN71u2?=
 =?us-ascii?Q?TBDsWcuZKgonT+FDd08udqTcya2pKX4Bv7+1JxhguY4uDUlA6npXeRSpCcH1?=
 =?us-ascii?Q?GicUH43viNbg/kdOFengpotGCc8vTwgOWRjqtA479zIAYyRIISTdcuRy+Dce?=
 =?us-ascii?Q?y7ddaiCb5sbFBDTlExJmfS2w5H406fx6I5fF620ej08Y4UZKM9Ka0/3hcu87?=
 =?us-ascii?Q?VzTMNWXpuj9tQ6evZweIWV5IGQgqwXnydh2z7N4u+/OYNE5g14/4mjwUQp4E?=
 =?us-ascii?Q?BP9ZdotspZ1doG5npNDfa7rwXB0bxWfpQWXbI3/ppHw4u+r9QGQpoZkMg7sR?=
 =?us-ascii?Q?HBydPLZs78waye3QWcy5OH+89XWefM5+8W0P4h2iPbE//zk4cmA1oT2buSue?=
 =?us-ascii?Q?yOtPQCUTfurejmWTvBcI+Rvv7vSVN/SGMb21QdfidCmNgvbg28siHgkfZXkz?=
 =?us-ascii?Q?T9jKv1vDOyKgm5lEUUfClgDTmtA5uhCbf0JMEo8/LuMm53S7n0O79F6KQwqP?=
 =?us-ascii?Q?fK1P4iPRWf1uNjdaLTFLF7FK5ZSynhN72kSOEMkKDxG2keqsmP5zJvhH4MRx?=
 =?us-ascii?Q?b27/xWH7usXfsIcPwNbVvrroWx9ySTwZa2ZYlDp4RxnuCvTqt8wbgUdYUSuk?=
 =?us-ascii?Q?eubrPYJukOWf+HrqHgZ0lGQ3Q6AAxslnNrwa2cYSSQ5J5TEuN10OmIp2Y/Aq?=
 =?us-ascii?Q?MwUOpLc2eGpLz1MuAZp5jjLUcTJHh616+zfWokhfTUcC5Ft70dqGQYs6qQ19?=
 =?us-ascii?Q?or8QrDHX1+/Aq4SGfmPKQUqxdrvQMO6sWhBlOv5ispFz3edo834LP3V5LY7a?=
 =?us-ascii?Q?d9dm6qJF4OOPSi1VRdUO1S/seJUnNj0euNh5oLlmWRg0b3/UTtifxib7LHGJ?=
 =?us-ascii?Q?ctfMA6VYP5tv+mVFWp0O2ZddR6CtUG/x4pPo1ZkQqumfo4XVNJHAp5QJ0myW?=
 =?us-ascii?Q?OGPcchCNzvIuQoVQ0FEGbabV7Kc73AMcA4nW8EtspUfBf0Ky5Xe8HOZnCTzG?=
 =?us-ascii?Q?rRAj1mLbi4ejGYV26VdC3qHE9yHN1nJw366y6FdBNLdHjSKYh8QxaiqyZ1l6?=
 =?us-ascii?Q?2shPmNvsRBKp0PiIg1gJevPrbyVFhPXdDQaXi8XXPvMlqWaHtDEerQTy5TmQ?=
 =?us-ascii?Q?hd7Juc/aB3Lm+LDtYtaP4NXKMOB+pRKGfwFdGNJoLADadm9pFw+E2FDpexaN?=
 =?us-ascii?Q?2G/3ukwIbr2E5YA7Kd9hNwqMso8Yuio=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5810abee-8f2b-43fd-77c4-08de744c637f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:00:57.0475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsW5hVuXtI7WwiSljoH60c2WiwoGEqunB4opsjVdBvciklPPelFwBwxUV0yzZwYRlJaextqgN1mBRK5O7QIgUpLkMuabSmec8bJbPV9uh7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
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

On Wed, Feb 25, 2026 at 02:23:33PM +0530, Shaiq Wani wrote:
> Fix the misspelled macro IDPD_TXQ_SCAN_CQ_THRESH to
> IDPF_TXQ_SCAN_CQ_THRESH in the header and its usage
> in the AVX512 split queue Tx path.
> 
> Fixes: e528d7c74819 ("common/idpf: add AVX512 data path for split queue model")
Cc: stable@dpdk.org

> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_common_rxtx.h        | 2 +-
>  drivers/net/intel/idpf/idpf_common_rxtx_avx512.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

