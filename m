Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC15606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=asFq7kQi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C91BA402D6;
	Wed, 21 Oct 2026 11:20:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3385C40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792574411; x=1824110411;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RXTK/nn3zTpBF24Y8qbBzGNAbPFHMz0dZPXzfNwrvJQ=;
 b=asFq7kQi6RZFqp3GEof5Ja8mhcUWf6m+CbjK0t+SfZ9WsNYLOTGd3DzF
 K2fzfBA3UzSnjZXv9RmzWRjTdunJeF33Oyd8ofFUFvL1zZWfRnNCxc0J+
 qx0d8ArrFbmW0DP8HYtKu1Spg5T+5IMQkfUJDvJOWPQVu5t2YWdl0VSPY
 5eUOj0m5FsYP6Iq4b5qrzzAs4Y+FAaXThJEHRJKplUGoJHOHAcilDPW9V
 lThDCt7oE/Jl2/46VOgWmnBpQCT4NUCZ+dDUinnuJWBUf6pasHuE7Ijze
 D3dLuniKsWB9reIT4G4lM5TDERFMDPIaQIfcQp9qhAP8yHDyes4KdGYyf w==;
X-CSE-ConnectionGUID: nfK8g7dVR+W1bIFiD2deTA==
X-CSE-MsgGUID: nNqPNzS6QIOyFU5K9jLgjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1166977"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1166977"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:20:10 -0700
X-CSE-ConnectionGUID: 6v2vc995Ta28TkYTFCjRig==
X-CSE-MsgGUID: t/3x+wFPSfWjWHLBpEup7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3470730"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 02:20:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:20:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 02:20:08 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 02:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJkqz+ll7E9J9dAHb5+WuD+nHc79htYG/ZTw2jhi/FdM+qjp3m0+80I11AfA+0Rf8Sl4PlVn1ZCGD3xHtggotEkpSuKRUtxucuiryQbvW7f8lOXUErrIy97/8IFWXmWzmLRCbecbUEhmRYBKqTWrad85PtydzNWR03jROFGRqzHmOcpaxtGsuwPo5WIpzh1uHrVMIjXIT1dWAYBMVgFwkavwK3nf3EViqpFnJLxAZK09XPBmuIfZ3R5pPS0o8yakZJC6K9JPXnucPMeoOjvPB2tAGfmU8rIoODu99jK9Nx7Bpzq0OtVpvGjwzTpeLAEKD+j2//e59nuogsrLXApEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1cS2w1IbP17tR4gfIOtl+gQkTlqj1mlkGtb5AqW124=;
 b=mp0B2LovNHV+KkQsQHrc2rzrDYDXUPGZN0opIhNUyp/kUDa4lmsyJBwe4gTjUkFsysnMIMxTN8JLK0Viw52EooZZIB2byhe2/HVhwVDU1WlkawLtq4+YM5gawsiB/UKH2odWEzMiqLZGgULY+QutQbvBzFTIa6YGZr3G1cIQAI6zRDU7s3TEIOFHmDxJ+7xrfYxjU6082BBuZeuvV0Vpq4llXUmnvOnVdOgwzhq2ghagwBuNftMHRlVZB5SxSZEwm4tCghrHca/DgA32D3HFfB9uDyIToKrRxOzmVdrYevE1j2b0UYl32lVFWeJJKkKiAqgiomKvRubOPB7z0rqWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BL3PR11MB6483.namprd11.prod.outlook.com (2603:10b6:208:3be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 09:20:01 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:20:01 +0000
Date: Wed, 21 Oct 2026 10:19:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 4/6] net/ice: remove temporary flow pattern buffer
Message-ID: <atiDvHYApZIsfwc9@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1792498154.git.anatoly.burakov@intel.com>
 <51906e4e6f627746e057752ad7ea6b5f0f99fe08.1792498154.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <51906e4e6f627746e057752ad7ea6b5f0f99fe08.1792498154.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU6P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BL3PR11MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 28528607-34fb-4ad8-cd3b-08df2f547bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: L6AGVob+NQhCGnLUALrpCU/AtYIBpkVEoBRuoai4Ui7hJ+48y8rC0elVL25OgoC9QCFkabqkDmWApN3WwXvJC3VuuWpdKaa9uVHwdMKtCHquKQ5K6iD+f0bNMhDjvEXosIq5WLkzrc0UeSenNXtA1uZ487Ls5rvGPYh59tqHFCbHB1sX/fwkcGPUbjswxah+opCOz35JnjOVOp/Sq20JF59RlEUJ1eXgFhFjit5xtbdw6WjcHWwzj5TbM+UOYrFa6Pu/vt7k+ZOLSb5AQSSoDDcFJrlj7rhobF3vwS925gmKt7SdG0SYES4cwwGdQEjaHp7QFR/GCH3xv+jLDW+irMgSS9iqA1sY8qXM6UgL1aO62SbbQd3zqXdvzta3jXZQBs+mfGK4QexSk87kpQUdNrb5wWElVzHqiXF/ZnyZaI1jV4eOY4DR1MDhwI2TFZ+dycgg1sct24ClZRb6tMTYAs1uwvsCgIKHNfVVHzXRDt3qEQqCKChOk5FI3WHcDiyf9c1IGQql+0gb8BRTbGL3HJskaFipsN+MsMDLABV8JHzGNunP9XdptVR7GltqxTGvZjrCwKxaQFmHFZRHbsk2GnC4NNKaoPIVtHKFeQqAUuK6BUD1cS5PG8M1POYIHQr9qoG2jDd/kvI3ug9LFC0/1dT2/g5ttx5OK9LLHaOnI2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQm6HRwD/47xIwfZWRQAeDAcnk7WDbhpHuC7EAL2Yjkv8z04tv0EM2isLTl+?=
 =?us-ascii?Q?3UG5mLM352z82V6PKOgDjlCHx2QwD49frRk8fLRQr1DK30te96GvBaLhxrf0?=
 =?us-ascii?Q?ljwFzWf8Xr/ThEjlsih4eIX5ewMNMJwQDBvztscBfslXCR/WTY5Rgre15IfB?=
 =?us-ascii?Q?pdLfLzbzIhvKpYDSOvPCJxutNN/inD639hSjyWEfcYveebd2C0qhXPcA0Tqo?=
 =?us-ascii?Q?ieWsp2kKXXsBgWAwtgUxKvgoIrZrJ9xDFgZA/ut8OjBiaWyQEZr+4OarM+6W?=
 =?us-ascii?Q?IQyTSTed+yxvpTxBQXgvBZtcXiw25uoQNzzQibFhyAALsD60vivTJEOlaNRW?=
 =?us-ascii?Q?Klyt63UhsDhna+wlsU85fxFq/w5o1vrlms77tNWsGGyPbCoMVPisnO2yf0CR?=
 =?us-ascii?Q?nJR5nqHwXpuvnF5YnnfyPZriqUY5stOuE6tkw+WPiFkLkcMHT/AqheU3Jm7x?=
 =?us-ascii?Q?dgRa0Ko3l5PFeJsgb3efM96IcG3LMGjZxRpcHtGOFr5zieKuWQUdj09VN23G?=
 =?us-ascii?Q?4YvI8GbugZGJ4o9U14v/mM8gDpw6NBxLoW2VlSPoYGCqPc2C8FcnHye396f5?=
 =?us-ascii?Q?2VB4XBvDVQAZJM8eMXGm2LqV77KHuKbFIgE/t/TF7fKGwkepvnotLCae+u/4?=
 =?us-ascii?Q?nddNm7zaPghZnY357nPQ93m50TJiV5YpeU6Z3HAAhnHn8O/V8Ac4z60CBXtf?=
 =?us-ascii?Q?mi9gTmyUjcVYUWFtHld/ZsGIBrCejWRjWnBG7VV6eFKpkZkY39+2PNgWqthR?=
 =?us-ascii?Q?E1FtX1IEf16c83C2s9J5nawBSPrv0zxtdVX0DwHLR2U4KYdIWtsBbifoYFwp?=
 =?us-ascii?Q?CKj0f/DJkR5BZARlDCd8W8MOwJlXSTZMi9gwTRjOwSEhyCwgipL/thfYzHyF?=
 =?us-ascii?Q?aTQ0lKfA/PE/kEhNNkmEffZemv1CBevGh7Q03Fa6jAe7qW3zfxqBw/0pIBk5?=
 =?us-ascii?Q?pkWPR3hVKCbhzRgBFLorTfSG6Gnu9uwUas3xli4v+sGnLetLcadH2dEKdzd9?=
 =?us-ascii?Q?4vp1sJbfbJH2H0D7KCPZMN7Bl0JPO7IhB0GPhBl6fHgmINuuSHZI9GMJubh/?=
 =?us-ascii?Q?7WCJFwUlQTdbdOTIaZRT7G6f9mE1RlIlY51zdY9XyNCQtal0DzD6h5Afw/qf?=
 =?us-ascii?Q?i4is/Cj+CKSkIH75gFITivOTZG4AxFGieE8e37+d2Agl/Pm+4dE0VeUsoL0r?=
 =?us-ascii?Q?W2bSCiAPjGVmdIRNN/eK2C3gPBjzK2n6/TXILUUfWTFlTBiyQd+UR5lxYgLW?=
 =?us-ascii?Q?wVta2rgUxQ9hlWPXaXoYRjn8fSe3cBW9MSLNM4t+v566tV+Uti0xZVVzTYit?=
 =?us-ascii?Q?Esouzif1GdfViOfwLnP5+K1E385C3hnoy8N0ULFTOcmzFq+yocbixVw8hKIi?=
 =?us-ascii?Q?ZdnD51GLfrl54ZIb33zT4z4csy3pBYeU1NNlKIEtMKDyMGA+cIp3e6mfMZlG?=
 =?us-ascii?Q?rc9n7NzSzMe9AqQbS4OQrIDKZRJJ9iF8fLxO0gLXpz4Lu7K3z53fUfBq23Jw?=
 =?us-ascii?Q?uvBYJzCHJFPbHiHbNrt6qhbkJZ5UbI5VfWSNcBm8j5Wp2+PfV4oC3kycmZRD?=
 =?us-ascii?Q?DbeVLagWmRjeb5OoWKeneZbtIxShS8GinAyH1Z3tsNdTTGXpnSYAcmgtLtpf?=
 =?us-ascii?Q?wh0n1jSbzZpoJ7Ox1dDqQce17MyVDmJ8u+DPApqRG1lHx70fuOXL8qeiR+ND?=
 =?us-ascii?Q?/sJkSGqHEiPYqxRt9b7ZHO8nUVviuB+wcVKa+A0WQwpLU25DGW5WgKrgHDJz?=
 =?us-ascii?Q?Eoz5ZW5SRFKj9oxPV2XMIrp9xiU+6kE=3D?=
X-Exchange-RoutingPolicyChecked: p2A6P8zbm8AAn2+RjdoBuXc7y1zlhx9R+yjgYLhtHT8yL8a/PAuwGfX6HkodKB+kf53bq3YezTZaV7zSUAT8ZbDkxqu1hE3oRBR1x28jqMpLcKz91Le5kT+1EG3b61iO2C9H2s32/nFLsoVBOKG9prULXAihwmAHh/U5MEfQLngHXTr8FBx7+VrfSfH5vK+300aguwhlBawi0S/qgKgKvVm2WBckTKBm+xyE+LnAsRfXrTo143unGkF/PacvdQiGw+nduZX1GNhBzUO+4gqi1oYk7XUcx9QMI1dqQpcuUKSuGFZYnxrpBguXtHaKaOgvn0G2niE/3IlfWIl1W506Ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28528607-34fb-4ad8-cd3b-08df2f547bca
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:20:01.1911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2cJ+7e8ssWJfCIRhyyxiyme3OEkKltqNgUZbrxvcVBG3SePPZGERPRYhWMy3jB79h41eZKKzHNSXZl7FvIXE2MXOcjs7X2Um39cX9Z8Hqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6483
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 01:11:07PM +0100, Anatoly Burakov wrote:
> Pattern lookup allocates a temporary copy of the flow pattern with
> VOID items removed. Pattern matching and engine parsing now skip VOID
> items directly, so this copy is no longer needed.
> 
> Match against the original pattern and remove the temporary buffer,
> its allocation and cleanup paths, and the unused copying helpers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
