Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0CC36010
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 11:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEE1440156;
	Mon,  7 Apr 2025 13:56:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 60E7B40041
 for <dev@dpdk.org>; Mon,  7 Apr 2025 13:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744026999; x=1775562999;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=bS0QXpu864T2kVfKdYcg3e+IO1GsK0SMoqPIXiW/UX4=;
 b=m8myYC6I0lcx5ywH5DbmgsFW2cbExA5qQA4wU6fwf3OOPWeFnTOkPAJE
 f1uYc01XodQLv70rqZNPKxq8J0BieV5GNuhavXCgcwAjhSsm3bmgkGZWv
 6mK0cOgRgAZvemDMsExv5hX2dZamp82HB8rXdoX2W7MWQURG/fDiH2HvU
 skkXM8bEX1yGAfCOv3gQMZij7C5oEg/Fsn/TUWHtuKtYDFb2RdHlwm+jx
 GZNW7uNjEGfIOE5iRUUSF1GE4myG/nQTlDS5lZWVeMnbwUB4kKL5gZ3H0
 A3Yz2Jjr4wZt2UR/1hgfe/Scql900EfdSM9LKwKWlmjMBwSvMLGhkfBZH A==;
X-CSE-ConnectionGUID: 1zae1dwbQ3ekgGVv8vmIIA==
X-CSE-MsgGUID: Ly1KvDG+TgyVtsy7WLDF5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45298722"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="45298722"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 04:56:38 -0700
X-CSE-ConnectionGUID: eH6fZBp2Stmp7E522tl7SA==
X-CSE-MsgGUID: zIAbxkstTqaBNKYVVMZDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="128872237"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 04:56:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 04:56:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 04:56:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 04:56:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnU4wzmsriHg6DVRmHNx/MKrNsvJsEQF9WTMdQWXU3pWeK6xhWk4UUmRhMOf334joewKDV8719xZ2T9XTLOdt1d4InIjBYp9shwoKQABju7WJJDtis/olKAMtGW0Dn01iAF7evabwUZANoMH1kSrcpDfhevM9HHDG8lKFRJXTSCk35LQnP4jvRdfnTNJ0NTBDu4kjc1FOOO+IEHyx7SdhukteUyVfoJiFOYADuZWKYI+5WYkEsxieTtNe9LWDjqYSevlVQ8JxH0Z3LhEATVdd5++YzrN92z/dSTx3ckBLuzoDDTEf1n0p0wJyh3tvU9hvgkrxXMgwTDt99+U3r25wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j/PFR4o7Hj/UuT0a5+JXRQDoUCMiOT1fOeV/A6N6fk=;
 b=rvi23QwvmOunLiMrjam04sLUqvtN4M0vLYDG2jduLFrYYRo/6ETMhNecQQCZpwQNz5Jzrd3FY7V8ZGUdgFyAvwL/69QoXqsWQfNs1DsV4Q1VAJDoJp1J9I8qdo18MDqHtAEH46l7hIU5eTKVyBv1Ubfc8HLoM3Gqwna0ubebDx0oiVGjqVpz2v05XxY24Vlf/iVFEqkzLMsZq3SJWfsKso6+NveCBHxvVfSK48JgW11wFNtyAQO6v82kxHoCzZMP+1jxfZc67qYDOu8ul2lECSToYYmWlxvaLizHnveQknGUAv6JjJVBvfdAArVd2vQMSB+wEDsaQA6n2/+/LxZhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 11:56:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:56:07 +0000
Date: Mon, 7 Apr 2025 12:56:02 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <Z_O9Uq_Mg86yjKzi@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
 <Z_Ofcb4ktAmn2RqJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
 <Z_OrsVaV64pLREqv@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB9A@smartserver.smartshare.dk>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB9A@smartserver.smartshare.dk>
X-ClientProxiedBy: DB7PR02CA0021.eurprd02.prod.outlook.com
 (2603:10a6:10:52::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: d295b1a1-7d7c-4567-7aba-08dd75cb2e05
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2daeDh6dVFTd3EwQ2tDdnZ5aGpTamo5dE5TZlBIaHRiM3F1ZGkvTmhvcThz?=
 =?utf-8?B?N1AxSmgyTXkwSlNpUnZ2dEE4a1dkdHdhbzhWSVVzUExCWjhOdSs4OXJhSnZN?=
 =?utf-8?B?ZHNxZmZLZTQ4bElBYTZ1a1o4S2tHQXplWEgxTXgyUWRTdURIOUduT014V1lq?=
 =?utf-8?B?TE44UUE0SFNIT2FXKzNydE9ZcTJ4QnF5MEZDWjJrUzVDcEwxU21PTHJWSjht?=
 =?utf-8?B?eDNHdDR5YnRRamNzTVFwL3h3QnhLa2dOTVFuTERnSXExNURna1M3UkhFU3ZY?=
 =?utf-8?B?ZzFZdmJIMUZ4OHUrMTlFR0FQTXdCOGNwSlRWbEgyTHRZU1Q1UUxuUWR6OW1H?=
 =?utf-8?B?T2c2OFhRd0tvVUxrNDAzRS9HTzA4ZnJLdHUxMnVlZEJ6UEc4cjV4UTJHbFUr?=
 =?utf-8?B?djJjNVk1VmZwdEFvUit1QzRubkZuVE9CdCtJTk5KdGRwbFl6bTF0cjBmSXRL?=
 =?utf-8?B?VHcrS0FmYUVaTFBKdDlGajdrZFhManFwbm80S2lwQkxLckoxRGN5S2NrMmN5?=
 =?utf-8?B?b0VMRjJBOExUZ3I2WmlFMEtjV3FQUndFZU5POW8vR2h5NmpOMytiUElBempy?=
 =?utf-8?B?WGhZVGJpQW5aNXViYVRtMlVMdUg3ZS9FbVRWR0s4bUFjQ1pLdEFOZ1hNWk9N?=
 =?utf-8?B?ekRkYTBBNGR0OEpJNTNOUDcvWU0rb0Yzb3lhUVRyRXVmeVZjL0JBemp3azJH?=
 =?utf-8?B?eU40NXliRFpDZ1hMV2NsditLVUFtWGRDSytiMzh6RE9hOWdhTFQ1N2FnZWlF?=
 =?utf-8?B?bUhLVURXUE1lNzVHLzRMN3dBWEhjM21tcGVaanBvb3hjMzdGZ1BQdXVTMlo4?=
 =?utf-8?B?Kzl1QmR2WmhjRFAxTU5kWTlRclFCK0xDMU9IeG9sOXlwcndsekJOclpQRVJp?=
 =?utf-8?B?KzVhekxZUkljcFM3UGRqTVYyVEx4RldMNmhmK0Z0N3ZhQUsxNENMbmVtcDlZ?=
 =?utf-8?B?T25uWUVXZFN6TmRYRmM4WVBwUlBIM3JvUE9JZEQ5WHhPV25ZbjBpRlNKYW8y?=
 =?utf-8?B?K3VZaGhKVWlvSTZOcE1IL2pWUFUxYmlWOWY3KzJBUHArNzJES3gyUWJiNzdr?=
 =?utf-8?B?UEFoV2REUzl5S3RqTkhIR2hwbkVOaWVyQkwzS1hhcEl0UHRheXQyditCd2FC?=
 =?utf-8?B?alp3bHoxZTk0QUtJdmJjYW1jWHF2RTlIOXpNYWJnRk0vdENWOVR2NjJ3bk1y?=
 =?utf-8?B?cFRvQ0I0NUN1ZG9WUnlFNVViQWpYU0pHTHpPNU9kN2RoVHFSZ2gvaDRVTE1U?=
 =?utf-8?B?V0Z5Q2NxVVhpcitKNkwvZGVhWGlWUm8ybGhvU3hsZ3prd21KSlZ4aTRpNVo0?=
 =?utf-8?B?Tit5b2FIZGFhNXYxZm13WnlSa3lZVHZuYjJCSTVJZVlBN1pRUytXd1lIMDJ4?=
 =?utf-8?B?VVgrTHZnQjh2bjFkRmU2bVBZb01VQVh1MEQyZDFXS3VIRlI1TXE0N3hRYnhZ?=
 =?utf-8?B?cjNWeitsS096TENtU0lRaW9lVkxmTkxNeE5aRm9UdXlLK01lZk9Kc1dzL0RD?=
 =?utf-8?B?SEZPdmRzckthai83ZklCU1dkbVlCZEc1YXNKVlJ3R0J4OGtzM1p3L0FQSFpr?=
 =?utf-8?B?NjROUFpKeHNmR1UyVXdSL0I3eU1DTzRSSHEyVkJacFBFVStuSmp2MW9jcmdK?=
 =?utf-8?B?aUoremJIRVJKVXo3eU5reGNYalUzb3FlQjRoZWNjb1U2cmkyVlRTTGVTcWJG?=
 =?utf-8?B?R3R5T1pwMGNrb3kycDlrY1JzMzlZYWZoQnF2eXdsZjJ2WkYzUmNnSlMyYXpU?=
 =?utf-8?B?U1hiK2xWWkpjWHVwU3cxREpMalhmMDhPS1hqTXZRaDIzTkR4ZCswSmtrMTRK?=
 =?utf-8?B?aW56dmVRL2FzSkhvVERtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFAzRDk1RUovZG9acUROdXlOeXRPQXhNZkRwZElRcE9yWUxZNjNlcGpOOTFW?=
 =?utf-8?B?Q25DcHZlbHFFTzlBRHVWNjJOMG1aendyQlZjdmp1ZHY5eGFTL1dnQll5bnM4?=
 =?utf-8?B?RXlHV2lVc08zcEJXVXNycVhUcVFhcjUyT3dkYzNnUktmWWFOelFlRkNGd1R0?=
 =?utf-8?B?TVBaSFJTSUxZR2U1VDU4TFNDejV3em5SQThGbnhqbG1GWi9zWWRlZmU3WGJ6?=
 =?utf-8?B?dXNGYzZhTVFVMHhJdHhraUZ4UGI2amY5N2h3ODVtNFVSQW1FNmpRZlBWOXp5?=
 =?utf-8?B?SWpGUkMxNXpXa2cvSTFvWUNJckdVN0duMmxBZ1poaVd1M2pWT0FhNEhmK21k?=
 =?utf-8?B?VUIxcUY2c0twTHB1VTdnZndEZ0R4Si9LbVJPOWNhOXAwbEtRU2FpZzBvNjls?=
 =?utf-8?B?UFoxelVBbUd2dzB2TGF4NFo4NzZ4YkxrTjdhUmVTYk4rRk5zNVgreHphem9s?=
 =?utf-8?B?eGhNTkVUbXlza2dCaU9vZDhZWmVweUpLVFErUnU4NFVrR05LSkRQT255WU4r?=
 =?utf-8?B?T0gzNFQrQ1U3aXFYVEVIKzFYR3B6MGZxVzJQNWRYdmluOXkxcVgzV2dXakZn?=
 =?utf-8?B?eHVvcUVjT3BRclBZK3o0SXdjd05rU3czQ0doWWRJV3VxaXRGUkhhdk1GZHVF?=
 =?utf-8?B?aUZzNEk4cGFxbGtJTXBTRmowYVZpZi9sZy9ZV29VVXJBYXNYWnJkVWNxQzll?=
 =?utf-8?B?Nm1veVJ4Z1E3SEYzbzNVN0x5NnpTOVdBMTV5SFFTUS9pcVdmbDlPVC80UmpH?=
 =?utf-8?B?R29QTFUreGN6YXZjY1poMUx4NE8wM3pmSjBDV1NBNWdyWUFRRTB0ejJoYnVN?=
 =?utf-8?B?ZVhOMFZjL3ZvMmxtZFh3UW8zM3psWUFYemZGWTdtZHJTZ2ZVRzJYaGZZWkl0?=
 =?utf-8?B?UjNSR0llbU1HeVlaMlcxdnhYY0Y3Wm9ReHdSRFVDc1QwYTNvUi9UcitNWFJG?=
 =?utf-8?B?citET1B1Ymx3RDVHL05pT1FCY2tadXlvb0lnZnVyREEyQkhDMURQKzBPNDRY?=
 =?utf-8?B?WnlpNWtoNitDeitRZGxZSC9DQ2puT3RDa1I0ZDZUTkFNYzNjZ0NMVkh3cm4y?=
 =?utf-8?B?S29VWS8vOVJyYjNmRHFvK3pLVzZOL3JVWkNrdG9BTTRialNWcUdNb2RhZkhn?=
 =?utf-8?B?NHkyaCtGRlcyVC81UUFLMDI5RlN5Z29OUHBLdHl5L2dPNnZPNXAyRVlOOFVz?=
 =?utf-8?B?azUzODZHNTYzRm9TN2xlcWJuYWIrdDZLYktNUnNOeWUwcldDRE4vVHp3KzB3?=
 =?utf-8?B?YzNkemJscHFGM3p5cDJUeVR3NDNqRFNSNUFBdWZCM2JBSHhJdUE4NUg4K015?=
 =?utf-8?B?TzZWcThnNGJFSGRrOFBHMTB3WmFGU2FQOEtUZ1EvTjB2Zmo0WGdsUEtGMExL?=
 =?utf-8?B?UHhFb25XMUVvdFQ2cGpYVEw0QVVZeHUxNTBLZ2xaNnpDNnFRVzQzVzdTUG9q?=
 =?utf-8?B?MmRQZzg2QTQ5a3JBb1FwcUhVZXd4V2pscUN0cEg4c1Q4Vkp4bEZsNmpuN1Ev?=
 =?utf-8?B?S0N0dThNdFZxclU5MGNxTk5XekcrbTVtU1piUTl1ZnJiNDQwZnRwSElDOEFC?=
 =?utf-8?B?VkNieXBYczU3WWhDbjREZUFGMzlHaVV6TTNTVG5kUXN3bk9kWTZQUllqR3Bp?=
 =?utf-8?B?bmJMNHdERitFK3BuWS8rQ1kzVkdNZk1iTVpqUC8venRZYnE0OEJRdXc5ZGRk?=
 =?utf-8?B?ZEdDbmFNamNQcG1GcjRqNE5Sb0c1Z2FONGRUR3h2NEJrdDladjFTUmE1c3dX?=
 =?utf-8?B?b2pmYWp6VC9kWWJGOVlvVjdkaWVXMFN4TmFpRG8wYkFHOXh1dzZmWldORWFI?=
 =?utf-8?B?bGxGc1E5SVBrb3hrTml1bzdzS3JaN2U3T01kS0VqRHQyLysrREtpcG1EVndy?=
 =?utf-8?B?Nm9BNUU3Z0VzN01GQTJEKzNmYkpVSFpyQmZjYlc1THpJRDFMQnNsaVI5YUho?=
 =?utf-8?B?WXdQK0IxV295SGNENTMwZHg0VXpKWk45c1E2aTFudHBNdFdMZUkwNmpUODFW?=
 =?utf-8?B?QUVRUUJjeDlXSU5qR0ZEUDBneUluMlF5Vy9YTDFlS29iQWxNWUtBcW5NdW93?=
 =?utf-8?B?Ym1PMDN3VHNhTHNUam40Rk9MTDBCRWs1YTJ6RnRWVXlPWk94T0VBSkNyTFJt?=
 =?utf-8?B?T21hR3Rmd09xUE53KzBkNkxvaDVDc3U5NXdneFJxZWJTbG4zZWJQUjE4eDRK?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d295b1a1-7d7c-4567-7aba-08dd75cb2e05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:56:07.0118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81Ae5Cf90+iTr24t/8M2LCfbYpEL1x5WVT4WpLKMcemj6EFsWQ2iG7j+6z1HMo2jVdFKPMPsygbWuPjvSSyUbMgIy85bViT9e6beFcJc4N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
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

On Mon, Apr 07, 2025 at 01:32:59PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 7 April 2025 12.41
> > 
> > On Mon, Apr 07, 2025 at 12:15:13PM +0200, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com] Sent:
> > > > Monday, 7 April 2025 11.49
> > > >
> > > > On Mon, Apr 07, 2025 at 09:04:05AM +0200, David Marchand wrote:
> > > > > Hello Bruce,
> > > > >
> > > > > On Tue, Apr 1, 2025 at 4:08 PM Bruce Richardson
> > > > > <bruce.richardson@intel.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson
> > wrote:
> > > > > > > Traditionally, DPDK has had a direct mapping of internal
> > lcore-
> > > > ids, to
> > > > > > > the actual core numbers in use. With higher core count
> > servers
> > > > becoming
> > > > > > > more prevalent the issue becomes one of increasing memory
> > > > footprint when
> > > > > > > using such a scheme, due to the need to have all arrays
> > > > dimensioned for
> > > > > > > all cores on the system, whether or not those cores are in
> > use by
> > > > the
> > > > > > > app.
> > > > > > >
> > > > > > > Therefore, the decision was made in the past to not expand
> > the
> > > > > > > build-time RTE_MAX_LCORE value beyond 128. Instead, it was
> > > > recommended
> > > > > > > that users use the "--lcores" EAL parameter to take the high-
> > > > numbered
> > > > > > > cores they wish to use and map them to lcore-ids within the 0
> > -
> > > > 128
> > > > > > > range. While this works, this is a little clunky as it means
> > that
> > > > > > > instead of just passing, for example, "-l 130-139", the user
> > must
> > > > > > > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> > > > > > >
> > > > > > > This patchset attempts to simplify the situation by adding a
> > new
> > > > flag to
> > > > > > > do this mapping automatically. To use cores 130-139 and map
> > them
> > > > to ids
> > > > > > > 0-9 internally, the EAL args now become: "-l 130-139 --map-
> > lcore-
> > > > ids",
> > > > > > > or using the shorter "-M" version of the flag: "-Ml 130-139".
> > > > > > >
> > > > > > > Adding this new parameter required some rework of the
> > existing
> > > > arg
> > > > > > > parsing code, because in current DPDK the args are parsed and
> > > > checked in
> > > > > > > the order they appear on the commandline. This means that
> > using
> > > > the
> > > > > > > example above, the core parameter 130-139 will be rejected
> > > > immediately
> > > > > > > before the "map-lcore-ids" parameter is seen. To work around
> > > > this, the
> > > > > > > core (and service core) parameters are not parsed when seen,
> > > > instead
> > > > > > > they are only saved off and parsed after all arguments are
> > > > parsed. The
> > > > > > > "-l" and "-c" parameters are converted into "--lcores"
> > arguments,
> > > > so all
> > > > > > > assigning of lcore ids is done there in all cases.
> > > > > > >
> > > > > > > RFC->v2: * converted printf to DEBUG log * added "-M" as
> > shorter
> > > > > > > version of flag * added documentation * renamed internal API
> > that
> > > > > > > was changed to avoid any potential
> > > > hidden
> > > > > > >   runtime issues.
> > > > > > >
> > > > > > > Bruce Richardson (3): eal: centralize core parameter parsing
> > eal:
> > > > > > > convert core masks and lists to core sets eal: allow
> > automatic
> > > > > > > mapping of high lcore ids
> > > > > > >
> > > > > > Ping for review.
> > > > > >
> > > > > > At a high level, does this feature seem useful to users?
> > > > >
> > > > > This seems useful, though I am not I would touch the existing
> > > > options.
> > > > > I would have gone with a simple -L option (taking the same kind
> > of
> > > > > input than -l but with new behavior), and not combine a flag with
> > > > > existing options.
> > > > >
> > > >
> > > > That would be an easier patchset to do up. However, it would then
> > mean
> > > > that we have no less than 4 different ways to specify the cores to
> > use:
> > > > "- c", "-l", "-L", "--lcores" - and therefore need 4 different sets
> > of
> > > > parsing options for them, and more checks to ensure we have only
> > one of
> > > > the 4 specified in any run. That's why I chose the modifier option,
> > and
> > > > to try and consolidate the core setup a bit.
> > > >
> > > > However, if having a completely new option is preferred, I am happy
> > > > enough to do up a different patchset for that.
> > > >
> > > > > I scanned through the series, not much to say.  Maybe add a unit
> > test
> > > > > for new cmdline option.
> > > > >
> > > > Sure. Once it's decided what approach (if any) to take, I'll do up
> > a
> > > > new patchset, taking into account any relevant feedback on this
> > set.
> > > >
> > > > /Bruce
> > >
> > > Changing the EAL parameter parser to a "two pass parser" makes sense.
> > I
> > > think checking for existence of more than one lcore specification
> > options
> > > should suffice; we don't need to accept multiple lcore specification
> > > options and check for conflicts.
> > >
> > > When remapping, do we need to support gaps in the "lcore" (logical
> > cores)
> > > array, e.g. for secondary processes, or can it be continuous from 0
> > to
> > > the number of specified lcores?
> > >
> > > And are new EAL parameters for this really beneficial?  Doesn't e.g.
> > "-l
> > > 0-9@130-139,100@140" suffice?
> > >
> > Actually, I believe "0-9@130-139"[1]  is not the same as
> > "0@130,1@131,2@132,...". The latter affinities one thread to one core
> > ten
> > times over, while the former affinitizes 10 threads to 10 cores -
> > leaving
> > those threads free to move about within the 10 cores specified.
> 
> Interesting. The documentation [GSG] isn't clear to me about this; a example there could help clarify.
> 
> [GSG]: https://doc.dpdk.org/guides/linux_gsg/linux_eal_parameters.html#lcore-related-options
> 

Yep, agreed.

> If users are manually passing lcore parameters to the EAL, then I see why some sort of remapping shorthand is useful.
> IMO, if the mappings are relatively exotic, it should be acceptable requiring an external script to build a long list of mapping parameters and then invoke the application with those script-generated EAL parameters.
> This would reduce the scope to support relatively simple, common mappings.
> 
> Could we expand the --lcores syntax to support common mappings?
> 
> E.g. "0-9@130+" to do what I thought.
> The lack of "()" treats the entries individually (not as a group), and the "+" indicates auto-increment.
> 
> A more advanced example:
> "0-9@(130-131)+", meaning lcore 0 gets cpus 130-131, lcore 1 gets cpus 132-133, etc.
> 

My issues with the above syntax idea is:
* I think it's overly complicating the lcores parameter adding in the
  support for the "+" symbol - especially in the advanced case example you
  provide. I worry about code maintainability here.
* More significantly for me, I think it's also getting things backwards in
  that it is focusing more on the lcore ids visible to the app, rather than
  the physical cores to be used. For the example above of 0-9@130+, what I
  would expect is that the user is mainly thinking about the cores he wants
  to use 130-139, which are then to be mapped to lower ids. If we had the
  syntax reversed where the physical cores were first, I'd say it would
  make more sense, e.g. 130-139@0+
* finally, as I found out last month, there are systems on which the cores
  are spread across numa-nodes on odd/even boundaries, so to have an app
  running on socket 0, you need to give the core ids as a list i.e.
  0,2,4,6, and cannot use ranges. [This also reenforces the point above
  too, where again it's the internal ids we need to generalize, not the
  physical cpus]

My thinking on the matter, and I'm happy to be corrected if I'm wrong here,
is that end-users are unlikely to significantly care what the actual lcore
ids are internally in the program, so long as they work and are unique.
What does matter is the physical cpus on which the code is to run.
Therefore, my approach to this is to find the simplest possible solution
whereby the user can just provide a list of cores and tell EAL to just map
them to reasonable values. For the "reasonable" values, I would imagine
that for the vast majority of cases starting "0" is what is wanted. For
anything beyond that, we already have the existing --lcores syntax to be
used.

My 2c.

/Bruce
