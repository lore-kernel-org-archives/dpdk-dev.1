Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101DC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 16:52:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7F2F402DC;
	Wed, 14 May 2025 18:52:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 54D5C402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 18:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747241567; x=1778777567;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F/fclwzj7WCopvI0tWpY06JgYcuG5tRYfv6zhx+Nx0c=;
 b=GtUI4Df6PFAzP9XYX3oZDpRqjyin+/mbI9/0oH1D/FFkcCf8fImueXE9
 0m8KBuYjhSFzVhWX7JdEe7bcdpMIslWFC8Ke2PNC1IxGoMzyp5kOCxqlQ
 TcfGgKZZ7URgkKfdwP8gWNSYei+TerUlKOgrjrnRWPW2hKMa5Uzkchn2h
 +1TcNbhXNVj2G6ecbhr7jBzHnHUXM5RE6T7YOpyCzVAolaroYjjtdGB2R
 UL/IZArHx2vYKWvib93NT4F1Ol4tJUwv4mxDEqTzl2BUVZwpTGYIM+4Cm
 zbos/4JPRbQ3vaVZam4pUPn77tWrtQEn5t3fNeklo1PoTNRNwvqhcT999 g==;
X-CSE-ConnectionGUID: 8wUZ7ugORo+EaZ3ei10aKw==
X-CSE-MsgGUID: W/1G13+kTdy+rLHf2Ab4wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="36773225"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="36773225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:52:45 -0700
X-CSE-ConnectionGUID: SnYHG0CBR4mLO7+OIAyrbg==
X-CSE-MsgGUID: GYi0Rw3UQR61NXVYuCX9QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="143293830"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:52:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 09:52:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 09:52:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 09:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4X60vehi+0CQT7LLd18dc51/IhZPlVHbIlWokRF6ElYtF47jOwIoIZrvuW1CriIVGL7Up9i+eLa2UmaeiBRxkQmklm6tH4lq8OqzoxKWS6Bc+SH/WHtpKij+QykGvgtXI47xVyXgfVdJ5T7JjPT0Zd7ajiPmRu+5IgYjhDvXoVQ21XrIOkx/S/D4i9AHUEWloHXTx/pj2asxf5sEwicbM7svl5alK43amcW369NCrD+JOKtZgG4mSU/h8Yf6GwtM9Pz2ZGll7VT27o/5ToVglb4Hpg2LRqUFl7wJVA1Xb8iKuS2Qu8k9Oen/Dwz9TA5ovYtCC0WzTyhI0K3IBibEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcTP2t4aiy6fGmq+GanDnljOD8ZZmhdCzuNyEyE3hQM=;
 b=k70C3RWX3f0LUdNW09T7hptet81VXk9Sxt7ykV+40XchgVqN1ZBnq+6Ha5EO3rTE8855d6Xh0ZD2PKJqwvprQ9vfUPI38OeNrSPG3dtqzr0V4cGj9lz6IraUH96TlkOMnFBGELf7BUqm7l04jqrosaH26Qzecvo5Ci+IQ6N3fEWHPkQVTbPW5YMRe4eT6EP5Kq0UswHIh5gTVxaEkeAqm2Y1p0OmKJaWh7g4mL7ygdIdMALhKgnHfBakkO/N+WpQ2hyGmC++Th3ZUqcz01Kxq+4/QeYjGAGovyBlXewBqZ1lHVu+QwE/bZ5uwUxsw8w4OOzSdrR+bsgklpxXQIALTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ0PR11MB6575.namprd11.prod.outlook.com (2603:10b6:a03:477::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 16:52:42 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:52:41 +0000
Date: Wed, 14 May 2025 17:52:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
Subject: Re: [PATCH v3 04/13] net/i40e: use the common Rx queue structure
Message-ID: <aCTKVAL2nSNU4rRP@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <d9f86c4577c1b0ee9923fef1d0fa61ac812803d8.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9f86c4577c1b0ee9923fef1d0fa61ac812803d8.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0179.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::34) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ0PR11MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b61d01-bf5d-44ff-6335-08dd9307bdc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AfW47eEyvPWPte9orlND3yFrkTmS3am2iLyGVfBsjlWQrS8B0IYT7xZhVtGo?=
 =?us-ascii?Q?X8VYM+brRp2B+UGrFAWh88gGyKeXJ31SfRZNmrqGuAxbddHB09aNQss+czCW?=
 =?us-ascii?Q?v3KAiX8/QtOfxOTPNwHoP5T6MDWGVolq20CkN+dRbgdgix+Z4/U5n8o4+2Dn?=
 =?us-ascii?Q?3L6gu4CEQs6JYIUPqy1SSdBU3LVDnv5fvkDyd81AYJII07biL5wQzeUQtaUm?=
 =?us-ascii?Q?u+E57q3gA8HG4nB4CKFxj4FJx159SYR/r6gEPXwpOMh06iERoMO6D9qdUDyX?=
 =?us-ascii?Q?9/4XU153a79Ws5hhwDSM34meldpCwvxFpxK+ikfgN8iTk0lFbkp2MDVyqKe7?=
 =?us-ascii?Q?wyMsy5OD5AHaybXUfZ9NIPoW9Y2FpKHMoL7HihSX/cpI9a1UKM/9X1xf0BJg?=
 =?us-ascii?Q?VSwSl7Hr8xMIp6D68p76X4jVsMhb5cPJBUgos+/kjGE1VT3NLztzdXhu/e2+?=
 =?us-ascii?Q?sDrCEf4lvGK2Ufv/b2MOHF9IpUgJi82nmARcuwlc2uVMD4Xu+KBPa9/h6/Wf?=
 =?us-ascii?Q?7FM/vYtlaEZa0joiBZNUpXsIRDygIv3Hi2y3H21BVMwxRg2uXaxsXGjaAZyy?=
 =?us-ascii?Q?w7Ajz/nRJXeN4A/bfRqhndN9zT7cIMZFvybk4tmTMpekcRyt9bnsI5NgghaD?=
 =?us-ascii?Q?vRb5u3G0ygp7wpp0g26bpKsLPwUqCSaePXJ6NDqfSR1iPVlSNUvA5LpW3WAY?=
 =?us-ascii?Q?8+Xjs/crl615iJo51C6np3xJYDrdrq3QVSTpbyrdLtRIXIwofcDQFySkJ91O?=
 =?us-ascii?Q?K+NVYMiPwQ3b/uPidtIDNl2HpWHF2cJkPUoxzFRn4kYTTp4b10H2coqqvvnB?=
 =?us-ascii?Q?s20Q7lWBx7Gjb7B+6hvzpp8euMgarU4hNr6yXVFwqpcrVXVoxZs0TTZO4qlI?=
 =?us-ascii?Q?xCCHMK0exhmlBAlbCm5THDX0F7ywgVOncT0bW+/Nf725fty3BtMA/f4s0142?=
 =?us-ascii?Q?ptX43RsxFFj8CL6849t2gvvrjUvjSSeA8Pf5cBJh3q7psl8b+SglR6nYUooP?=
 =?us-ascii?Q?07wjdvx7CCrBMhA/foa/bqSheIe8hULd/Ugv3XyUcfLB5nUcDzpyvQBK2Kzg?=
 =?us-ascii?Q?vOBTjs9UDgZAs2kbBYPoXVR7Ej3lJc1v9g6BnECVRq+2yN6LWov6wzVC8ezl?=
 =?us-ascii?Q?ppfqB8ow9n0lj4kbTph/i7U7WC7SbzEeUk4EtxfDRmKnNAr5boVjZ5d0Kqlb?=
 =?us-ascii?Q?i5YzgEcHxyVDyH9tIRi9cjkn7z3lo9lut27Ttt+cmcKWoczaeToy4zhJfuML?=
 =?us-ascii?Q?HsyFDTCx2BtqRZ3ADI7t1Ah9NwoJ45Mxw5WGJLrar5yuuO+gkO3QxjTwnHzU?=
 =?us-ascii?Q?ZRuLgb8wpfSyj9X18qNl9poY/OYowzUgq+2rHFp2ZBI6MUG+Mek/2fl1l3iO?=
 =?us-ascii?Q?w4TchVcc2SelnmQzsjbYqtubKdaLdO8ECDBgdOPkVXAki9htuzvQe5rrUQOX?=
 =?us-ascii?Q?9Gsqy+0OYCQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ajMt5SaHMtgnJDGA0FSI39MrV7C6XaIlfqfj08Ra5xemgB8kEGSHc62QjZx?=
 =?us-ascii?Q?StxUKWzWkx20oUBNdsZ1OGQsIQE/7ELkCEQQfPEabb2oVb4hI2PJfw23x0C7?=
 =?us-ascii?Q?yeBBU+b7sUglMkYp0YTo8mCUTdQZ1MWYuRPsaqjcN+1CIuMgZpn3MCit+A85?=
 =?us-ascii?Q?oX37xlLbTB7J5VeBXikmT33lgy7AV0Q5tfOmHJMATnsk9o00ButSScQQCfqA?=
 =?us-ascii?Q?v/GzNL7KKDNo1bONMbNib2YG639JNg8ikHkmQt0GPY8mXQQ0de0cU+jG7NWJ?=
 =?us-ascii?Q?Czu7cuR9UanUb6m3jX2erqwfSqho0LacTynSguy0Jn1BMEmOz4fUz+QQvxb8?=
 =?us-ascii?Q?GAj10Uyq8BOHlPPFgpFjXWI0AF2VCMFM3RTHPXMlP9DbmbhUbokGcxA8Sqtb?=
 =?us-ascii?Q?8JuEYnP9+WCiuYK6xM91KZAkvbZrxgVN7WYNRF7RznbsoK1m/VMrKrUM+tgT?=
 =?us-ascii?Q?HYQ0O1GmdJ4y4JF33/9IFOd7Qeg9ebV3nNQoWmb/9vky68b0qtxRLWFFDx/J?=
 =?us-ascii?Q?wA5V+9U6bghTBqDDTHFo040GE6NRvwcNUItSA+B18kylt9ZqwVxht2LhSgm4?=
 =?us-ascii?Q?5dnT+HNrjLm8Oo40vyjKD1R/BQmzRupVJpJuC3STtyi9OSaZwZdAigmnF3bI?=
 =?us-ascii?Q?1/+NFgoDWQd67/kJ3t5woMxmACKoYkeCLAXqC2xrGf80aSQv+YkE3mEOAZ+J?=
 =?us-ascii?Q?y5QUCsqFiad4HjUCJQNa/EJQkZUpSIv8lroJe7uYl8/U6IhMHm3y8gdc2ddB?=
 =?us-ascii?Q?9obYEKuGXPIxYr2Jydw+oyq+RxNeJUtixX2jxZyqRpoocHM+cMr+yj7BiroR?=
 =?us-ascii?Q?9DtxqM9SCFzcgnxtjE5u0ZbUJ8ZcAiBVXhqKOiP6uREobbdvv9dgSa/tJIMU?=
 =?us-ascii?Q?HdBt4V9bD4x6IebSfyMGB3mk3MXI/SWpJQ8vB3EMo/DXku9qJ9xgmlq6Yc1D?=
 =?us-ascii?Q?vaG9M5UzlgkK+F9EGqSMBm+YP+fJLAahv785Mpa2MlWqBDNPUUtwvrvGKtar?=
 =?us-ascii?Q?qKbz7lsFI6vw+9bcLK9rScyBfgSsAH+Fq63iLA/8HisdT2CsUMzns0cKlMRE?=
 =?us-ascii?Q?HT8w4oPxpoSyHHj2lMxHNZxbgCRZxpyv0E8UIagA2ykcLPy7UgjRw/DhcwQR?=
 =?us-ascii?Q?e7eFldeSENdSU8Ux3AdvCNnPbZGLRzeKU77dfRx7Il6aPGPoxKofZeYE9VaJ?=
 =?us-ascii?Q?SbE6bMO+FCzCvpxwrLFdS0+7VWwXnj2w1W4uOOeHl7hp0YNxHShBG8gE1Lrz?=
 =?us-ascii?Q?L6C28CKtbQC/1ST4hJJBYIEtxnW13Uu4zAWVSDo7B1Ye/Gzkv0PF7PgxDNIy?=
 =?us-ascii?Q?6c+pEoEXKvB5wA9RDW7UuxtHKrOoVJ6a+dFHb/BNAD07je01yl6ykp4lCOL6?=
 =?us-ascii?Q?0KN6Sg7slRJyCO4Mq4sZZrCBpTiedFZqazS7JjDBE5kwng+AEjtHztX3kfKu?=
 =?us-ascii?Q?T4TGjYJhIkm36EgiyD33LxH4jFvRZgDjRa5UuuKvXfBz4rYqUogmQC5lA5iw?=
 =?us-ascii?Q?S7tHCBzswlD5dIWXTyfFURNxiPCJA4BvHBGNbUVKDmtHI/GoXB1UoAx0bTc8?=
 =?us-ascii?Q?ssuF8kQBRPGtI7RNq94IGCzjlj9zh3iKNoBk5VHhpiKBbBHKVg0rMoMCuO2b?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b61d01-bf5d-44ff-6335-08dd9307bdc6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 16:52:41.7959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovoVxOdn5xNuWYNvteaBbIdSnS5pkZDvgjKEwrmyprOPBJIsr9fk11ScJYiuGMtVYBUdYmCXV3iqtjYTaO2hNc2AghUPSzc0Ng7erTwJHQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6575
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

On Mon, May 12, 2025 at 01:54:30PM +0100, Anatoly Burakov wrote:
> Make the i40e driver use the new common Rx queue structure.
> 
> Because the i40e driver supports both 16-byte and 32-byte descriptor
> formats (controlled by RTE_LIBRTE_I40E_16BYTE_RX_DESC define), the common
> queue structure has to take that into account, so the ring queue structure
> will have both, while the actual descriptor format is picked by i40e at
> compile time using the above macro. Direct usage of Rx queue structure is
> now meant to be replaced with a macro access that takes descriptor size
> into account.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/common/rx.h                 |  14 ++
>  drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
>  drivers/net/intel/i40e/i40e_ethdev.h          |   4 +-
>  drivers/net/intel/i40e/i40e_fdir.c            |  16 +--
>  .../i40e/i40e_recycle_mbufs_vec_common.c      |   6 +-
>  drivers/net/intel/i40e/i40e_rxtx.c            | 126 +++++++++---------
>  drivers/net/intel/i40e/i40e_rxtx.h            |  74 +++-------
>  drivers/net/intel/i40e/i40e_rxtx_common_avx.h |   6 +-
>  .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  22 +--
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  12 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  12 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  24 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  24 ++--
>  14 files changed, 160 insertions(+), 188 deletions(-)
> 
> diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> index 524de39f9c..db49db57d0 100644
> --- a/drivers/net/intel/common/rx.h
> +++ b/drivers/net/intel/common/rx.h
> @@ -30,6 +30,8 @@ struct ci_rx_queue {
>  	struct rte_mempool  *mp; /**< mbuf pool to populate RX ring. */
>  	union { /* RX ring virtual address */
>  		volatile union ixgbe_adv_rx_desc *ixgbe_rx_ring;
> +		volatile union i40e_16byte_rx_desc *i40e_rx_16b_ring;
> +		volatile union i40e_32byte_rx_desc *i40e_rx_32b_ring;

Rather than doing this, would it not be better to keep using the current
scheme of just having an #ifdef aliasing i40e_rx_desc to either the 16byte
or 32byte variants?

/Bruce
