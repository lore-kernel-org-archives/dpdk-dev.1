Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3555FC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 15:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A5B940BA5;
	Tue,  8 Jul 2025 17:15:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 260464025E
 for <dev@dpdk.org>; Tue,  8 Jul 2025 17:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751987747; x=1783523747;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Bow8SaPW3YtDgW+iqxk1+6ETpuxFhqOW+989sKAxMro=;
 b=GyFH6chiQcpfYSS1v0COrqEu0kiZGFxpw7RJw0AZ/d/g3rOuRDspwPOP
 pAQuxKrOMPWHLeSgmO8OefMgmDmGMADVcIcSB1xj4qqYNnK407ui2Bv74
 AI/LDHPYH9WDT3tPEft/IL8U2fFsyeBWE0s7e9Hzyptiym+i10HuVCYPI
 vUPgLaPlL0TJzRZHZPBwFg99QbNAAiJWju/yk2fXDJOc8bMSGroXQphIh
 ZdVsDihJmK51rMl+I3Fsjd00HfP5aWsC+PNiUe46e1gofB77mzCrF153L
 GaLbuWF3OiVJYYHncWkYQuUPgjSLVPStXnzAF0MmbyN83+5kig/BCFFAz Q==;
X-CSE-ConnectionGUID: qkH4/GNVRyiKAcKDJ7Cgsg==
X-CSE-MsgGUID: JfyTKVICQ+6aclywnBBvBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79662128"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="79662128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 08:15:46 -0700
X-CSE-ConnectionGUID: 9RGF8h+6Sfq7+k6BCIAJFQ==
X-CSE-MsgGUID: N6GYpZiiSeimlzitqKtZUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="179201533"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 08:15:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:15:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 08:15:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.81) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 08:15:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAadwc5Wu+scrx0M2Hz4Y77OZ0tJdsFRqKS8a6XgJy28KQGhtQWKYWUg2huIwbN5cnjJxYQLPNABwAAD71NAf2Hclu8wC8iFNu1dletwChjgB1Si8KHk3KfFyJgzOL4h7ko7A7BOSl7pDX5IMQM4xI4zW5qUs5Ct9mKA5orrB/dwyFj5zj6b1PljKNR4Wa5ROpCzWfPLUfLin6ZhBh5nr7ExbPE0HVoHLLJSde9Hrk+IobF0WrVlqBiRa45+xsv6o9Pz0dVhQolpBSrkmQLRb7zQFO7SgBp/gzszHlMhp3UFH6WQzlF3Gg3iGL7MfZAuSFVRQQvCjvJtnMEnnVP/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl55m+dNl+ap+3tLSJ8oYUduMBZZpT/hjgd6P8l7kHk=;
 b=YHELC6go0p9d5VYDJk8DnZIiXRkpu0fh9QUzmHcjg9mnWGo0kGZ1+NQ0QM4c7M/72GrsoT6Wqm/5BUZKZFVZe8SykclsRQk9yVWToGSk06UYM2c9KYKVvpnz/0I1ubXMjJ/9TdDGuAfqtUfhry5/RO4yoQrZASIf7XN+SrUcIvOVz/mdSTnOUiDnVLuqqCMPw9N87ix8bd6fHmv2ZdeVB8K/D+14Qy1qGQmhcnTBnJFZkStK/IwyO7595/aQCo+uQfABd5SpBKy0Xtu9dtkQJ3NDLXLNrIvne/Z5JFV2sNJvWiGP+iEH1HSlQi2dKpwV5BIWYmoL+BSGksmrIKHa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 15:15:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 15:15:42 +0000
Date: Tue, 8 Jul 2025 16:15:36 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Vladimir Medvedkin <medvedkinv@gmail.com>, Dengdui Huang
 <huangdengdui@huawei.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] net: support VLAN stacking packet type parsing
Message-ID: <aG02GA-OTVVfR50n@bricha3-mobl1.ger.corp.intel.com>
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
 <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD98@smartserver.smartshare.dk>
 <CANDrEH=NEpj8X-8e6JXGVAMGXuykp1bgOMKyLFm1TPBEovdx-Q@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD99@smartserver.smartshare.dk>
 <aGzv-gld5GAFO2N0@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDA6@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDA6@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b00476-dcf2-49ae-eb7d-08ddbe324dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzhsSXVqZGxYR0s4dy90UmdYYmhYTFREdE0rYkx3WDZKZmxUVGNEZmJtWVho?=
 =?utf-8?B?dHA1VW1oU05qWVloK05UT2ZzdWplTDVkaVJiNUlieGI0b3lBSW13Um1GRFFx?=
 =?utf-8?B?aStGdGNSL0NXTlVEMFkvYzdpMVp2RGl6cGd3TVBGOVFyZDF6Uks5c2ZlbTlX?=
 =?utf-8?B?LzhNaWI3OG1UUExNMXptKzBhUDV6Y0QxMjU5MGgyaU5QeTBvR0wzaXVQK1Nl?=
 =?utf-8?B?eHFWd1VRdUVocnBTQVJHZ3hOV0o3VCtQcU5MTEJOS3c4ZHU4aGVuYVd0ZFg5?=
 =?utf-8?B?SGt6ZGQ5N3M5ZzVLTnJieTRmT1Y0SEN0cnFnVEpFMG5Dc25qd0k2cVBnU3Rk?=
 =?utf-8?B?eXptSndnVEJvQ005NlZXalNLczJzMEZwQ1hUWm1LUWIzL2pKNUh5TUVBZXJu?=
 =?utf-8?B?eXVweDZWMFBtT3NROG0rSlZST0krOGNzbHBPMThibE9UNk1vaktlQ05nSUE3?=
 =?utf-8?B?UDBGV2pONmdJVXEyaDRBUXN0bHJhN0swSnNBZmRJc0hIampJU2hVSmJXL05D?=
 =?utf-8?B?UEMrMkt5dDlSamJnMlF1amFkOFdzQTd2cUFtR2lxWDBNaXFkdk1VbytJejdP?=
 =?utf-8?B?SW00ZUp2OFdIUWFXZVZPQXFsUi9yWFZVd05PZEtISnVjQ0oyWEpNdjdNTURr?=
 =?utf-8?B?M2RBcW1CQk1NTUNRaW15Zy9YRjZ6NWZPS2VRYVp2ckNhWXFpd1UvNmNPaGxn?=
 =?utf-8?B?SklBU1ppcys2QkcwR1M2QUNxVGdaK0FUZjRjQWJUVUx2UFBNdzNrcjhRend6?=
 =?utf-8?B?MGExNXFYUTJIaVZmaDMyakg2ZGR2K2JNM1hkbUdmUElYUjMvWnFoVVVRelU4?=
 =?utf-8?B?eU1GMVpQWGhUcG1YaTJ2M3Z5aGl4UWl1Ym1vQmx5dkVmWVY1SXBVWTZIalA5?=
 =?utf-8?B?WEZXWCs2WE9mTXBucFdnOXdFZEduSTl5RDhXd0I4amk0VTcyZUswMHkvM09l?=
 =?utf-8?B?OXN6MzRGemE4NkdJWWNlRDZ3VXNoaUVEcWRaVndkRHFKRFhFb3NMWDBRdzdV?=
 =?utf-8?B?ZGRpOW93M0QzSkhLY2dpcWJ2cmVsUWQ4OW0rU1pIZFFSa3k0aTVPQkZUd2cy?=
 =?utf-8?B?WXJEVytFZG9PQ216aXcyd0tqUFN4UDgwOHRZQjB2ZkNtb0tDZzBJMW1ZRmhj?=
 =?utf-8?B?VE1QQWNDLzFjelBsY3NHeHRuczJmL2l3T1YvOE5PN0F4K1MxbE1UbmJ6UGRG?=
 =?utf-8?B?aVI1OU81Y05naTRwSW1KRldWSkx4QjJXbVJSeTlrVTYwRUFtRitMeGg2TFl3?=
 =?utf-8?B?OXRRQjE5YXdPRFhHMjc1NUw4czRIWjdJZ1lSYm5tMy9iQnp2bFRaYTNWcW1M?=
 =?utf-8?B?LytIVVVraFJQSFBtdGRJVTM1MVI0WFBNV0Y0amhMOVExaHBJM2JzeUtFbHJ4?=
 =?utf-8?B?Um5xVk1aWmIvVXRtVU5qRWo3QUpnTWRRMmo2VzRzRStubHRya21YZUNNcE1s?=
 =?utf-8?B?Ulh1TFZYbldmQ0NyM05mREpreE1KSkN5NVIyL2Q4dlFsZlBFM1RRUjhyOHAx?=
 =?utf-8?B?c3BzTUlsQzdGZkQ2NnEzN29BNFRpLyt2NnlOYXRQVFc3di9jWnZibXVvN3ZF?=
 =?utf-8?B?dlpiM2c0RkppVzlXakNIcFNLUmFjM2tJam9adFo0R2hZS0tOellYaVlIdmpj?=
 =?utf-8?B?d2hONnUwQjFJQVJuQWxFRXZVeXlSb2lIZHdpV1E4TXUrZ0pucEVXOWUveU9z?=
 =?utf-8?B?T2xhamdaWmpqcUY0U2hTRFhLTVIvQUlVTmx6UWJsaG5RM0R2WDZDME9paDhy?=
 =?utf-8?B?MDF1Rm5vU1N4UHQyc01tRVJEeDJJbkFGZ2ZXNnpiQlBHL2Jhc2hmRmR6a0xD?=
 =?utf-8?B?Q1VyUDROb2ZwdmlQNi9tc2xZZStkdzRIWEdjL0ZkekdOUzMzYkl4aHlFa2gr?=
 =?utf-8?B?bDlQblp6a0lFUE9Rd1BaYmhGd1FzZ0t2Um5mMWJhUS9yQktGNGM4ajE3dXVX?=
 =?utf-8?Q?ZQjcknCWdnc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVjdHlISHN6aHp3dkp5aUxnd1dKa1J5OHlYV3BUSUFzVk95RTVGSjJsejFR?=
 =?utf-8?B?SVBkVWliTTJzeDhueE56akVHOEIwd3pUdDFCS3dMemY4eERjaXg3VC9KaW9y?=
 =?utf-8?B?czFjS090SlpPUW8xSityWGk0bnFHSWFyNFNvSHZYMmM4YWVyQVB4bS8yd05X?=
 =?utf-8?B?dlBFcE1hS3dnMzB3Vm5KVmt0TDJ3YnIvbCtscjF4VW1nbnhFS3FMWDVDV0ph?=
 =?utf-8?B?Skd3QzZjRzRYcjlsSllVU1JHVlJOTkhqSHFWMEc3RmhIenhjcnlQUW4vTjdk?=
 =?utf-8?B?QXFmamtRb1VCWUUwWVVuY2ovZlpmeHdvazBaQWk3ek82OU5tWW9VRVJvSC94?=
 =?utf-8?B?Y283TFhvYXhNWFJNQnRFWUtLVGdVZWcyeG9YRXVrcFJWcVJqbjhDeHI2NVVI?=
 =?utf-8?B?US9mZHVVTVcrWHptWG5jaTd5TWZqWEcyc1BvK0JDU096dlJUSG94alhOZldH?=
 =?utf-8?B?NlpJUUh1OC9iTkZmL3pTZVZwTXpxWm95TTdDUnFnUmtma09yL21GTFhLZEhv?=
 =?utf-8?B?TTcwSnNsZ2tNNHZ2Zmw3RmdlY1ZQQkVYKytEY1RVMm9zZFJJVGdOcHV0SnA3?=
 =?utf-8?B?OFJkdHN3NVNJdmY3NFBUcmI1R3o1YTNwd1Ztd3FZMkxNU3VGZGlDTHZFc0Jp?=
 =?utf-8?B?QnFKVUl5VEtsZzZIZnVOL3NwN2JRRU9FN3ZFU1hvajRnVE9Vd1d0NHJ6T3FD?=
 =?utf-8?B?YVdkb3NTSG5RUFozd0RQWmpBY3ZVTWpnNzJuMzI1cExqQzFLaWxvbEw4aGtW?=
 =?utf-8?B?bGZjUnZaVXZaVzJLeVNMUWZJZm1tNGxkVVNoTDlIVTZ0VHkrK24xbkliT0kr?=
 =?utf-8?B?Vk1xZ0ZtaGxVQVZNM1hQVkt0NUMvYldGZG9sdnhuV3cyTk00MEFHa1pyaU15?=
 =?utf-8?B?UTVvVXIwaE1WT3NicnlZcldaaXlSTXYzSU1YOXQ0N3I0RlpaaVFvbFFhbCtz?=
 =?utf-8?B?OHcwK2QwMzU3Q1B5cmMyUldlTEU0TTdMaWJhd3NrQ2tMZDV3d1JSdGg2Kzhz?=
 =?utf-8?B?ZHNXNWo3SlY4WG9ndytCcW1ZNXc4OC82NUQ0aEhockQzbm5tUTQ0NFFjaDlP?=
 =?utf-8?B?YTEyREJ4TTJ0eEdHT0JscEhUeXJmSFVzTFhFWmNzQXI5ZWdvZ1Q0eTB6NjRW?=
 =?utf-8?B?N05LaGpib2o1VnJwRjVjYUttSUpYRjhJWkFHYmllKy92S2pIU1ZGVmJSTDQz?=
 =?utf-8?B?dFA4OUFtalJJcTB6Ti9mRk1aa1RWWUs2enp0eEdUUlhPVk9kKzk1bWRtWFJp?=
 =?utf-8?B?bVhHZzdXYTZiQ2lKZ3JvajNaViswaURDQ3pWWnhmZ1pUdnpJd0ZSQ29QNmxR?=
 =?utf-8?B?dzI3bFNIWmdybzl6dDRDeTlSYzJ3OEFRUjZDNUR3YzVPdVRUY0UxbGp0dnE1?=
 =?utf-8?B?NjlHdHVoM1dUdndMVXRVMXJTY05mTWJvM2o0bDh3a2EwekpKTW1KN0JiM3Zh?=
 =?utf-8?B?UG8vajVwbDN5emlWdzVLWDZZcVUzaXFRZkdwNnhxVjlzbE9UMEI5YmFlVVFn?=
 =?utf-8?B?QlJyMW1OdjA5YXF2UkNvYmJOL3M1U0xRUzVKNDFLSUg1MUtjL0FyWnBHdGVE?=
 =?utf-8?B?enk2Y2JjL1pkRnlRYUpVMVBPVUZRb0xUbTI5bW92cElBbGVJcEo1U1NGSUdI?=
 =?utf-8?B?QTJNTUVtNEdxOVJBcEJ6UFNVVDhmeEdBVE1FS0xTTExDMThoRmVvTDIydEtD?=
 =?utf-8?B?VlRXeUdGRkZ5UnB0ZGpjNHUwN3oxSmhzbmFIc3hQUTRCc25zNkJLTGZVVWkv?=
 =?utf-8?B?UDVoWEZjMWgyS05aM1oybFVsbTV6Z0x3RjNxUmpmeTFhb1MyTmJxMStEZTc0?=
 =?utf-8?B?aEMzQm1EdHNsdlovbWhoVjJVL0VHUlhsazhZNkI4OWRzU0pvalllcHVpaGdy?=
 =?utf-8?B?bWpRYkk4TUQ2a3REQzRLcjBNOGFPRitSYXk5Z2J6RkdxQ2lEblBzK0hrYjFI?=
 =?utf-8?B?dTVOTiswbzltbTJlRmUxcHZYY3NLN1g1M0RvNFhqcGMvVW5wN2NQcTZMUEZj?=
 =?utf-8?B?NTVreDgrWU8vZ2FrOWYwN290bWZIcExqcThwRWtLeUsvMUFGcnFSalJvTk94?=
 =?utf-8?B?V1gwSkc3aDBMbU5NL2g5aitOU2lQY2pDUnNDS0RJdUp5SWNEQVVEeUo3dGtm?=
 =?utf-8?B?QXlFbTRrMDBCQzJUSUtyTzEvYlRUeXA0eWM1R3NRWkJOZTNUWHR2MUU1THRs?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b00476-dcf2-49ae-eb7d-08ddbe324dfc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 15:15:42.4665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekfwjywly1xQGV/NWOx8fmNfKqlGvW3Y5Vsd2l/fFB3RxJy/X5gVZ6xGWZMZdofUbXEubZhxv3JdBUCqGb8XL+50zUPBXEH5XFjo327iV4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
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

On Tue, Jul 08, 2025 at 05:07:05PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 8 July 2025 12.16
> > 
> > On Tue, Jul 08, 2025 at 12:00:42AM +0200, Morten Brørup wrote:
> > >    From: Vladimir Medvedkin [mailto:medvedkinv@gmail.com]
> > >    Sent: Monday, 7 July 2025 22.10
> > >
> > >
> > >    Hi Morten, all,
> > >
> > >
> > >
> > >    пн, 7 июл. 2025 г. в 19:09, Morten Brørup
> > >    <[1]mb@smartsharesystems.com>:
> > >
> > >      > From: Bruce Richardson [mailto:[2]bruce.richardson@intel.com]
> > >      > Sent: Friday, 4 July 2025 13.32
> > >      > Hi all,
> > >      >
> > >      > this email discussion comes at a bit of a fortunate time for
> > me,
> > >      as I'm
> > >      > currently looking at our vlan tag/qinq stripping behaviour in
> > our
> > >      Intel
> > >      > NIC
> > >      > drivers, and there is some discussion internally as to what our
> > >      driver
> > >      > behaviour should be compared to what it has historically been.
> > :-)
> > >      >
> > >      > The documentation - both in the NIC guide [1] and the testpmd
> > >      guide [2]
> > >      > -
> > >      > is rather short on detail as to what exactly the behaviour
> > should
> > >      be
> > >      > when
> > >      > vlan strip or qinq strip is implemented. Therefore, I'd hope
> > that
> > >      those
> > >      > more familiar with networking than me would be able to help
> > >      clarify
> > >      > things
> > >      > so we can document the correct behaviour precisely - and
> > hopefully
> > >      test
> > >      > our
> > >      > drivers against it in future!
> > >      >
> > 
> > <snipping full discussion for brevity>
> > 
> > So from the discussion, would the following be a good set of guidelines
> > to
> > document for correct driver behaviour:
> > 
> > * VLAN-strip always strips one VLAN tag if available. If multiple VLAN
> > tags
> >   are present, it strips the outer.
> 
> Yes.
> 
> > * QinQ strip, strips two VLAN tags if present. If only one tag is
> > present it
> >   behaves as VLAN-strip.
> 
> Yes.
> 
> > * Specifying both VLAN-strip and QinQ strip is the same as QinQ strip
> > alone (??)
> 
> Yes.
> 
> One more thought about this:
> With QinQ stripping enabled, an mbuf for a single VLAN tagged packet will have the RX_VLAN and RX_VLAN_STRIPPED flags set.
> So, considering this output, it would be reasonable requiring that VLAN stripping is also enabled when QinQ stripping is enabled.
> 
> On the other hand, that might be a new requirement for applications.
> So backwards compatibility speaks for making the VLAN stripping configuration "don't care" when the QinQ stripping configuration is enabled.
> 
> > 
> > Mbuf reporting behaviour:
> > 
> > Input Traffic		VLAN-strip on		QinQ strip on
> > --------------		-------------		-------------
> > Single VLAN pkts		Tag in mbuf->vlan_tci	Tag in mbuf->vlan_tci
> > 
> > Double VLAN pkts		Outer tag in vlan_tci	Outer tag in vlan_tci_outer
> > 								Inner tag in vlan_tci
> > 
> > 
> > Does the above seem reasonable and correct?
> 
> Yes.
> 
> BTW: I think that having double tagged packets on a link configured for single VLAN stripping is weird.
> But describing the expected behavior is good!
> 
> > 
> > My one (minor)concern would be the handling and placement of the single
> > tag
> > in the QinQ case. Depending on how the hardware treats a single tag in
> > that
> > mode, the data path may have to pay a penalty if the HW takes a single
> > VLAN
> > and places it in the "outer" position in the descriptor, since it needs
> > to
> > go in the "inner" position in the mbuf, necessitating some conditional
> > logic.  AFAIK (subject to me actually testing for confirmation), this
> > will
> > be the case for our Intel drivers.
> 
> If that is the case, then maybe someone already thought about this when designing the NIC HW, and came to a different conclusion than I did.
> 
> Inspired by Vladimir's comments about QinQ packets with an S-TAG (Subscriber tag) and no C-TAG (Customer tag), maybe we should consider the alternative:
> When configured for QinQ stripping, the first tag is always considered the S-TAG, and thus always goes to the vlan_tci_outer, and the second (inner) tag is optional, and goes to the vlan_tci if present.
> 
> <feature creep>
> When configured for QinQ stripping, we could control the single VLAN tag placement through the VLAN stripping configuration:
> With VLAN stripping also enabled, the link is considered a "super hybrid", and the VLAN ID of single VLAN tagged packets goes into vlan_tci (being a normal VLAN tagged packet).
> With VLAN stripping disabled, the link is considered a pure QinQ trunk, and the VLAN ID of single VLAN tagged packets goes into vlan_tci_outer (being the S-TAG of a QinQ packet with no C-TAG).
> </feature creep>
> 
> But again, this only works when VLAN/QinQ stripping is enabled. Into which fields the various VLAN tags are written when VLAN/QinQ stripping is disabled will be fixed/hardcoded.
> I'm not even sure the vlan_tci and vlan_tci_outer fields are filled when stripping is disabled. But there are separate mbuf flags for VLAN presence and VLAN stripped (and QinQ presence and QinQ stripped), so it could be supported.
> 
> Furthermore, in favor of my original suggestion, consider TX:
> TX of an mbuf with a single VLAN tag doesn't know about QinQ with no C-TAG, and thus looks at vlan_tci when transmitting such packets.
> If we like symmetry, RX should behave similarly.
> 
> I'm leaning towards my original suggestion, but I don't have a strong opinion about this.
> There are good arguments for both solutions, either vlan_tci or vlan_tci_outer for single VLAN tagged packets received on a link configured for QinQ.
> 
I'd tend toward your original suggestion too, where single vlan always gets
put in vlan_tci field if stripped.

I think if we were to go back and change things is would be to not have
"vlan_tci_outer" field, but have a "vlan_tci_2" field, where the *second* vlan
tag, if present, is put. That would mean that the behaviour would be
unambiguous and the field would only ever be under consideration for
double-vlan packets with QinQ strip enabled. Sadly, I think that would be
too big a change to make to the mbuf at this stage. :-(

/Bruce

