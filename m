Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D1103E162
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 10:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66943402A0;
	Wed, 18 Mar 2026 11:59:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 107324026F;
 Wed, 18 Mar 2026 11:59:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773831549; x=1805367549;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BzwTqQX+ixUgIBVm3w+NLxShGhMKnc/cHru3EEW7v1g=;
 b=Rt2z6zCJPnOqZg7DXHzTgMSScWaEyJLXMp5olXpDMBCjLZXuqG//zxni
 qdCeHMZ0GedS1FLaUt5kKCwqWh9o0g1k6QWS9qyA1uEuFUhRS4CZS0Iu8
 VSJXLC4AvqUlLgSsLzUaPlQEBqV6l+NJZeOqtOiX+yU7JkhHy71Xiu2UZ
 6pWjiISVDKE2FNMh2k/FED8LCCxUZhxAZcU9AKGKrzZ5Rs5qJ/b7CI5hC
 y3bz09uW/HyJQ3dYHRK+tu4J6HvBrst+7iMg0aVd4oG2+SiP90j4bVu2Q
 NIF9liBp+/2NF4wPhSOO51DeEqWUVeX4G3S8Bp/HXuWq0VnjAxMupCNux g==;
X-CSE-ConnectionGUID: mcydweSXQbyPmvFjKb82Iw==
X-CSE-MsgGUID: 7wnw6B+pSW2kIEZTItQHXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74794899"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74794899"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 03:59:08 -0700
X-CSE-ConnectionGUID: 3aDJjcDTQjOVsgIJ8UTkKw==
X-CSE-MsgGUID: IzPoOaPMS2WkzKKkq7v/nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218631457"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 03:59:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 03:59:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 03:59:07 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 03:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcQiMR353Jm9BYVLGyMjvJdmhgta/EMedHNtHQVnNnQEeRmPhMJFpNLdCUk72oKkyGcKfivPzLFiVSyxZa/WRY1wT46aELXxeqR/l9fQhxkdqeM2As5JemX6cjPJLtg7ZrO91XXDTyeaeHsaZ5UWuDIb4LPERXXtO+eVhdGel8gifUs0sN2n3Nf2KGMkhabe8gb5s50bJMBuVRZxhR/kwGnL7R5W4+rd8ePjHJ9JccBGQRkAbuYRuyhuOTxi0EEBs4wVymeotxd+d4gQhE7D8qF9t0/uDdha7snWFlZJXtbO01hpf1O7lgSKol0tt88n8+krDXqG8BPyI/7HOrzt0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG+GKdbXg81XvnL2AUkbohPAWl3f1upYN6+zHiEf2GQ=;
 b=IE9vSRC4ssBTkL48Y10QpddC6zLJLMVKBXz4vk1M079af/bXX3e7lo4A02eFMBeM4214c3ndvGBNSwwnKdllL03vaWgS5vjoKoIST18tlTARcBTpkGAPBA9OTiOtgvHMIcP6F9tlkfS2oeGvhSZdUIkHA9KAWeEZZuTssRPd7dIZxRMcWEOXaO8EU+6JRgqyfDKf6R50A5NRj6PPdNZVJHq2NIaS3St+nEDrPetzJpR3jDywfK6iutS8cQy0lB6twjV1Qnnu8vItuLDumNbksB4n4uhl3Vlpjhc+BMGAH+5cHBIdUeLfZi9F2aVR+BzunUaCm6InRHm+TypAZdYJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF7371775FE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::834) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 10:59:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 10:59:04 +0000
Date: Wed, 18 Mar 2026 10:58:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: John McNamara <john.mcnamara@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v1] net/i40e: fix unused variable issue
Message-ID: <abqFcvrQFoVkq-AA@bricha3-mobl1.ger.corp.intel.com>
References: <20260311161955.1833722-1-john.mcnamara@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260311161955.1833722-1-john.mcnamara@intel.com>
X-ClientProxiedBy: DU7P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF7371775FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f485faa-057f-4dd0-7d13-08de84dd5e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: EQDzaf3ceLI51xDvERCNPnjv4/d7C+RdPWF8xYMQ5di1u3YrgGVK//ESX5L4/wPBxt+YLplgAN5wqhZDzPBcDBUzTgbAdkLE9SFfKfApK7CP2w0krbv9XR3EN/YNUDUNqLSSF+2+AT2iaxsFb3/zVa0xmtYXNmZnaz2WL5HJpGdkKNV7PyNMxcptxb/4OnY6Zx4/A6P8tYasZAY7+QROByOj4eFjzYM20niPQ57ul/sVgrt/AM4Fw7IN/wtRYR9tm+HwDT6N2jf8Sv69jNSNCaQ43lE+LYO5919EjzlDheXHO6xKBAnzYBEfaRqF9EAChUo+Q4bM9DFI7F9AOpAUpDx4PDQ+04xaL6Iu7j27/ZmLJQRfAlqKf/llu/qMdFyxalNQBPveoc4reJ74uRO3vxIIRJtLPTPEp7NjUxvvMEAlkpLrhFMzHN6wcjHccsA0+uMPM4YoQlunER9jTCiGsMYHXXuqRSLcEvl1+3j7BUIn+EajYaV1eDXQsYys6iLPodf87hz2mC0bS3/FkqP8yWpcQX8PSHHJQC1VIzdAkqyG/QwemCv4WvWO9ce1MIlnjdtTaL+kAFAZLrxWIc4ompfqT0ArTDiGvD17ZNNGr2iokrIs2uut0LA0uwtNvhOYr6QVN3mTQANznCbhSWZAeNuWzM0GtfWSiadytE0jCkqhjkNHvNrdMgKKTeeJP+3cWuiFRjfCxhDxREuwVdKcIkOblbkZPiEmZz4lEeUnN50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8pQhzCET+jmC7gTN4aeVaGA3Jy8pm63weND/gZk9QsPtJdz/sruO0NGydQF?=
 =?us-ascii?Q?+1CtzvGJamq7KF/okji4vdUCWUwff4/pPIwmjW0zNIy9HNEbgNiS0OjSblTT?=
 =?us-ascii?Q?sYFpiWZusnyvTEBH+kSoQ1yv5RX4QpLci+KzhehlVJnnrEt5EIeey0I94cch?=
 =?us-ascii?Q?H2sLZ7e2abs6pgQBnwgBYZwSElFTBRwhHdUTVuiiCf6SG24mpDxBvGkq+KCm?=
 =?us-ascii?Q?6KvqTMTNVY9YHWXWTCq/B0Rg8gx0f0dT5rjo/d1JVQGpygJz9SK3HX66K3n3?=
 =?us-ascii?Q?FbZJVdNcN3bFzg622uoWQJbFtXpmNr0wmF90t9nZ+gQ1vNZntUqsDQwMSQR6?=
 =?us-ascii?Q?oR3Erqm7TDn0Gqzqn2HFpXkJpMKkHi/dM/YRcZEqwxAT+FhtqM+/zdQESWBm?=
 =?us-ascii?Q?GWZe8PnYduGm1I6QZFx8JD+pqC7CttvN9isP4HM4T02wOyFrS696J3qRNjNo?=
 =?us-ascii?Q?zv16s8CjsBB95joA6GDHAb9GhSx2E9m0u5HfON7DyhfzNrBfEqEw6OGEi3I6?=
 =?us-ascii?Q?JOLIF4JBJdPUpZ6UB9KOJIPkEnwAH9eGRDyyZdurqB4OqWkIKBElBJcjKvQa?=
 =?us-ascii?Q?KsCa1iPSe7V25j4/Y0U7UCr16JmgEiwoqxkIcAHtaSZc2gE3zrD8d58v5+WA?=
 =?us-ascii?Q?XPjRuwNADKxHh9J8ble0NnDLfiWGMOUL1/W+JhDKodBpZvWhPxrhhC1hgfYZ?=
 =?us-ascii?Q?0Utz2g/N9b+b52EMt3gZE1HHDClh9DE0iIfwUs0csigQXIKvwAkyOyL1hFPA?=
 =?us-ascii?Q?qNO+S4N3ibY7lbd7VZxlm6ANjiGCwzn+KznQNLHbsTslq7xzKYysV7KJS4O/?=
 =?us-ascii?Q?IgGSGDovfkfoEoLvXCcrTA7K2NT7pEFZl6mpHJaGISEARgHC8Se3G8PWFR1r?=
 =?us-ascii?Q?3J9nPuBog2jiM5N3WtMLLDTeYcnbs5h4hqt1Rlo0zLQWFqyeK0XzYeY+B44H?=
 =?us-ascii?Q?p5Tnsr1VvUTbMqTGmLNBnDQAJy1Z3VB7b3VtvHKt01ka21tyHSq5PoRPmavJ?=
 =?us-ascii?Q?yPEFBM9WUhyoh6hRTN9lJ+vEsGdM5xW+jrrZ5nD5MljaSigXLtyuaJc5sE8h?=
 =?us-ascii?Q?oyslLApnZitspCIw333MThQIAvOBu0JB+NGZtKFkUQ52+UwSERl0vdJGCm6t?=
 =?us-ascii?Q?9QLjS3ITVOG50pi24+mJvJLKUVK7cVIgSk/T0maXZgmLzXPRO94VzkaCYDoE?=
 =?us-ascii?Q?nMNukfSAAV6IWPn4E9Yo+k2xMu6q4FRC2KzSqiqoxD8C2ydbx++R5n+IkcIO?=
 =?us-ascii?Q?/OtJ1m4mcdwgxOtQCFkPeQLKOX9RL2uGmuHT00bv6QHM+NvemMJtcaHDU6HW?=
 =?us-ascii?Q?yMMSwKI3Mh+6VNJTkeKanUzD+aB4dOoyzdOWv/mAdoGL8NYq7XBvCpGJI5X/?=
 =?us-ascii?Q?sVME3elZjXydDGgxUl+p1f2O/zqOT6AcBlPGB//TaYPggburvRgpL7YBmajy?=
 =?us-ascii?Q?S/efDSx3FZ/lWKAg6nRzveTD9SbVWxWZ5F0jJjitXtrZsoWRhLmjStWH/ds3?=
 =?us-ascii?Q?GwOCzsB0npR0uOzyndMisLezRWzSwQ3HQctiYTpbDbNSfNE7dJFSE/G0cyHn?=
 =?us-ascii?Q?Srj7TQOg3Ona8bDrcyaNHI72p4pukwjTCND3wCE67ScfUCV2l/K6sNTdtaEy?=
 =?us-ascii?Q?VFkCrlCizmofm5U4LlNOkTkKekQKlzfJziVyNe6/eaMnDOeJgNCNnYbj8krb?=
 =?us-ascii?Q?hmPzrgNJ3w/DRDluXch1mxxrbTnZVmKLwosfAwFWi/PgsGIrmbT7RHs+leHG?=
 =?us-ascii?Q?ZZE526T1xxRjyLmX/H1ifYWWTf5OEVI=3D?=
X-Exchange-RoutingPolicyChecked: FkSl4aRDaAIVD585of0uX3Nfx2NJyhUOtLWFwelzuJQOyRDwUvFDC6WHr4ewSh5QUyi2LV0ySknqxm1vI1bvKmfi4kijgLdnuHKh7KDAshrf1IpI/CXcL+hlNymVTRMA/i6LIEkwfpAErTVNiDtEglJ1hcdrMX7ILzBo61U6jCSSyB/vwNRpfbeVdbjZrdpljOTyUFeFl088u6CmLri9BZng4xTTAxUu8g8UJHw8KmdE3/Zaoh4srOeIAC+NMhElnSoNP1p+XWbzkii1w0zrPohFa+C6XMxaWLfFts/gEX2/My9Kdy8f/zeC0EYF5bU/HpnZaNwGBLVV2WmQyzn34w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f485faa-057f-4dd0-7d13-08de84dd5e47
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:59:03.9809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77MKow72gB2ML/j5LOQyK6JCscuX8lRKRFkRTYVUoDMmymETgD+i9+zeScEC5J+juy3nhzy+h+Lb6pvUgTSFbL+M21iFSxuEZ6bgWfziywQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7371775FE
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

On Wed, Mar 11, 2026 at 04:19:15PM +0000, John McNamara wrote:
> Fix issue where I40E_SUCCESS was assigned to a return variable
> but was overwritten before it could be used.
> 
> Coverity issue: 501831
> Fixes: baf1d4cd8aed ("net/i40e: upgrade AQ command of MAC/VLAN remove")
> Cc: stable@dpdk.org
> 
> Signed-off-by: John McNamara <john.mcnamara@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-net-net-intel.
Thanks,

/Bruce

