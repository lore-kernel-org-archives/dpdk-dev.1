Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F0DC35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 11:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C5F3402C4;
	Wed, 19 Mar 2025 12:18:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 85EE94026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 12:18:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742383087; x=1773919087;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ceTwuvfqi2eaAzLgYVTltP4NW85fVPiK1V+wXXovyVo=;
 b=gR6N2LF+usbK/AEKRJ1uDPlMInl6vW90K6A2ZVHj3h8W1EJKvE4U+6OI
 zYBVA2sQsJ0bubtx5TdlnwW1S9nEf2mlrj46lBFJJ/BiLSqaH2aWJkDJL
 NX9Ko8uVnr+FR1XPe7yWNVbC4Nbh3D2gVA5lpTkzC6xmWeBfi3bNpWHru
 D3q7qRZOGXlM30C6RmtskRcGVgzMyXYz0hsPjFUMdMjb1Sf+Ozuh5f02j
 LuKpJ9bnmarhmcZoyi3r6UkaZ2fy7rwlcNk2R095xubfWawYcwfFjDulb
 fO+UKJ6TIpgvFEcZFUpwQbz7ckK5hn3rASrtSYFVANd3uEzL6nMLKgxPP Q==;
X-CSE-ConnectionGUID: Zlg0AvqET6qHcl8lAm6/Cg==
X-CSE-MsgGUID: aKmZNF6cRJiPhiAOmKzH0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42814751"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="42814751"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 04:18:05 -0700
X-CSE-ConnectionGUID: +rhsJnHaROOuez0SoQwLmQ==
X-CSE-MsgGUID: /55jNjWQTs6HrYlkGJo5Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="123510328"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Mar 2025 04:18:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 04:18:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 04:18:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 04:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qav7YYXTnNZEw8KDhzBMFpTckyJUf8TKMFRG70hjnbbCE0Kopu7CPXvi4jsRLX7ASRCPcCaLhxXHhjCUcYu3U6LGV7oCVlrZmsVCwSME033yx3jI49+8zMYLmWb+PEnJkVw1nAzde+vH6w52qPzECsL3EWoaSu8uZHNtKhB804MKe5mCCVdvPSMWHPk/3XVJFKPv3tlqei8Z1PGy2kVsQmmcAZ2W+SfeuW7AUvgq0bY0z0k4cEJuhX1OhEhSQqFqcSvlDfi5xIP1Ro2vWGaLfLYS1HjyaVTuGaW1vj1ovm2dMis8C2/2c4JKloxrvwiRKw3Kwl8e2v5yOJtJM5AFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+T+R1c+DYduA2L7Iy5kJX/Px+wfeLtFZHvx6SRyChY=;
 b=MMDoxXqCWneLm8ulZHX69Usj6yK4V0sJDxhGtIU3xB1yLtYGACD94oV4OMhNsLfTz5Mrt9sfggvkpmtpWNrXnRItZQ/2yozzs2JRMxGl/EjM5pdcrO0ZlhBmTfSyVhso7j57UZrNiZl0Hz1uyF6zw+fYweYbeH7S23achQejfXVOkU7VTsTamvJ1I0AFv1Rh4fnNeGkwJpOiQZsAGaOg9Y+sXKQjaLMQE0Atum5Hq6smRhenlkTv5ssCHl3iIE5qRKunBuCtsSNlEEZ5yx/4NZ9bhpNsxEYonie6vg6NffOe0SwLR1HCj3Zfm1ODh/3NXgGaBRA9bgzEv1fK1tsUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 11:18:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 11:18:02 +0000
Date: Wed, 19 Mar 2025 11:17:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
Subject: Re: [PATCH v3 02/11] net/intel: use common AVX build code
Message-ID: <Z9qn5Cf2SegamlII@bricha3-mobl1.ger.corp.intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-3-bruce.richardson@intel.com>
 <CAJFAV8wH9jQNVYpFcvMXQSnChW=6zD2oCxjhFS=ByQUw1-Z6+g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wH9jQNVYpFcvMXQSnChW=6zD2oCxjhFS=ByQUw1-Z6+g@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0313.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b1948d-78b9-469a-fb8f-08dd66d7b63d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1hxdHRoL0tZci9Scy92aUpnRUZkbElxcFJpTUN1dTRHdGhPbDBXSnlCTC9o?=
 =?utf-8?B?Y0pNSmtjNVkzZkxHUWI2TVdCVW1tRS8yUHVoUTdTMzRIN00vK1NYRTZSQXFn?=
 =?utf-8?B?SHU0aVUvYUlFSTFQb3R1WkphY2RPcGxWektKWVUwTzN6cnVYemVpdEFxUEVk?=
 =?utf-8?B?dTdUaTRJZEVYaWpkcUJRb1VrV3IrWUJQNUw4TzBLTG1VQXZRL3djdWZBTEJH?=
 =?utf-8?B?eHZrU3lMNi90WmNOaDlFUjdxTHFBVlZCM0JxOTYwNXV5ZTltWWZveHBDOUtw?=
 =?utf-8?B?U2NuemhnQWZtZm5ZMVN1ZUFhNUVXZkFIa05nT0F1Q2R2enN0ZDBISGZkUmcw?=
 =?utf-8?B?TTU5b1EzWDVZRGZGeXNrbXY2SkFaL3ZXMGJRVVRDV0VLSEVyRkxwd1RuKzFi?=
 =?utf-8?B?Wk1zRXZNWnBNWU5WZVQ4eVB2VXRYSm1Lczk1bkRsYkZvSzE5bUU4QzNtaW0z?=
 =?utf-8?B?d3BNWXYwV1U5cmtVbnNyQ3RLWHpzZTFIRW9FVUJUWlAxbU9za0hHK0hqQU9h?=
 =?utf-8?B?eWRadzgzdUFqakM0cFB0eS9ob3dodHJSWjZQeFdaeXFCQ3R3WUwvUUZkdndD?=
 =?utf-8?B?ZkNMMmNqVTI3bmpEYXpaUWRuU1l0aWNpbnVIS3E2N0pPU29FS0ZVWUtMbm0v?=
 =?utf-8?B?czZDUGZOWkpDRE1aTjJ2TXJ2ZGRYQ1JKMmxiWDdkVjFHd2ZPdHdGUWVsRFEw?=
 =?utf-8?B?UFFUMC9KbklSVTEvMzhzMXV0REZvSEtYZEJLMlI1SjNlK1lDaGNPT3ZNNng4?=
 =?utf-8?B?NTB5WHdibm5GYzdlR3IveENJWndIaVk5WnNlbVFvcWFlOWQxaXIwVUExSDRW?=
 =?utf-8?B?TTVnb29qTkc0elZOVmltSFN2QVdrOUtUWi9UTjFwVWgwenRhZ3hKNDhKN3Z1?=
 =?utf-8?B?OGFyU0F6Y0JsdXVjSGVNUmRtajljT3pLaWlGV2JxYXJUZXlWc0wwN3hkUW5U?=
 =?utf-8?B?NFNYb3h0ckJWZlZza1RuUTlvR2FJRlBMMk01c2s1WjE2U0RuZ3dYSzRwei9C?=
 =?utf-8?B?cDJCeXdaVVkzVGVNcXJKMk1qL09YeXM1SnpKUlFxKzNQdXpYMC9tTlcvdFhS?=
 =?utf-8?B?bnJRRExZN2pZWVQrdnFCRzBvcVl0eVNtWEl2QlhhTXR6K0grcnZ1M1RMa3RW?=
 =?utf-8?B?V0VFbDZ6aXN1U3RGcGp6WHN0Y01EQWROck1EbExtam5UWjJkMmkvZ1NWSjIx?=
 =?utf-8?B?eXd5RC9Gc0FaT2FFNFZQM1FtSUg2dFZpZ3ZYUU1JcUtHUmRFUW5XNUtrSGNH?=
 =?utf-8?B?OS9ubDRIRW9kQml3Tzk5bnBMOENEVDg3eTZtRzFFUUJzQjlkaE1xMGZOSmZu?=
 =?utf-8?B?dXI0SlEyRk92c2VLRXJZVmxYWGgyTjBMc2s4eURwLzNyQVdIWmRMa0NyS0FX?=
 =?utf-8?B?Z0lkd0xyMGZwWlhCLy8zdk9XSDAxc3pRamptY1lWK3YvVmhqcktOZVpNVlMw?=
 =?utf-8?B?eENCb0p0Rnl4VzFjRWpkS1NJeEZBcGF4SmRQZUNCclA4eWJYaWtSVEZFMDJI?=
 =?utf-8?B?Ry9CRk9JN1dDSFZsdXlWd1RqdVo2RlBEdmtlbXIxZHBYaGJGWW5BQ0VmUm05?=
 =?utf-8?B?dklxcU9YSDFsRlZNOUJSZ0pZMTdTUUREM1dCais2UVhIQnJBQXNGc1VlTldR?=
 =?utf-8?B?Ujh6eUVkckQxeWVxcHd4V09CWmlIMCsxREpoZHJiZFQwVk9uLzFxWHVYZm9t?=
 =?utf-8?B?Y25WUUVISWZ1a0FjQm45UjRMTjFuR1o0N2ROZ1Q1aHh3ZG03dUN4V3d3aG5w?=
 =?utf-8?B?ZmdlWU95TXlaYXNHRXFKVEhsZ3owMlBtckhBM085cW5CdDVOeXZOaVJud0Vh?=
 =?utf-8?B?THJaZmJJRFlFTXdwZi9Jb09zdG45QnFkZEtQanhVVzZoTWZRbzhDMjByK1NQ?=
 =?utf-8?Q?1TFLLenVZGq2a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEovY1VSbVdjSFZUbUZsU1pnTkJzemxoN25GRXo3ZkNEV3lyUnBFT3dXeU0x?=
 =?utf-8?B?MnM1QnM0WndoaU1DMEdrSWVyNnFEUUxYdkVnMlVvRTFaWXorSUxtcXZUMHVL?=
 =?utf-8?B?dTZrUkNiM3I2dHNPVC8wSTVGd1BLNkZKTGxpSHRrNkhIWXZyQ1VoQWFsQmx3?=
 =?utf-8?B?WUZlcFFQWjZWSG9vakUyQWx0V0VJKy9sZlg4OFZjZU13bDZnY0lOaVIrKzJN?=
 =?utf-8?B?b1VHUjljYUkxdWNuVFdDNmNkV2xlVjc5K1pvenpPWGJ3eG9PNEFleGJTUHhp?=
 =?utf-8?B?YmlqVnNyUHcySllsVmlXT1hiMEVuMlNwdlQrNDh5N3FQMHFFbXBrRWZFN0ZE?=
 =?utf-8?B?cVJJUEFUdC8wdzZLMUwwbjJ6UTdYeTlTeDlONFBSV3pWSnRETGpVRDFYK2dK?=
 =?utf-8?B?MVJYbW1KSGl4Njd0RXBLeFV2cUNxak1ZbWsrbllySlh6M1RPUU03eEpkNDlX?=
 =?utf-8?B?NVFIbFVOUkpxU1JENFA4WTZNV1RGVkVSR3lSQmhCSEh1b01ybU15ZGw1SkRD?=
 =?utf-8?B?TzV2QlJNeUtxTlFEaFVBQzJ1ZGpLUzdFV3V2TEZhWDhhZktkWmtlV3dOMDJk?=
 =?utf-8?B?a2YvUHZ3b2dJSXRzZkU1ZzRDaVpqaE40MHg4U3E1cFdHb1Zyby9GL0lPK3lN?=
 =?utf-8?B?T0s4ekl3L0ZNakYzanRKVkFodFJFQjRzVjZSSlZwRTY1bnBLcmtZSjRUN2pw?=
 =?utf-8?B?VDNDNXVadTFnUEJRaDAwbGhZTXpjWFIwWWJBc1BXWS9BdjBXTmRwK3p6V2NJ?=
 =?utf-8?B?a0d4NkUyZTgrUkpFbEUvV0JGWXRhUGxFOWMyWGo1LzVoNGh6eUs3eFNWUUwv?=
 =?utf-8?B?SWNvVDBqZC9KYm9BYi82ZE9aUjluVUVaaHdkbE1UK1hIMTgvUzQzeXUyRzVp?=
 =?utf-8?B?Qm9lbm9wR2FmSHp4b2xMRUhBdHl0MjFtWWtlYzVqRHhOc3c5N044MVlYZFk3?=
 =?utf-8?B?MWFwVkh3OVZ3OVR1RENpb0tZWVVJTk1uTGkrKy9Icm90SlcrV3BDVXVGTjBq?=
 =?utf-8?B?T014bHVPcXVWS3RLMksvTEJLS2kwclp3dTRUZThUMnc3bWtHeHkvYVJnSjJz?=
 =?utf-8?B?QXNNalJVSzdETjRWRGRxa3N0ZEZhUnk3eWc3eVJGdHVkN3o5L1E4YVBEWTJF?=
 =?utf-8?B?VFZNcjl1alRGZ214QTJxbmtVdmd6YmhpSUw2ZmJQVXVnRjZ5NG52M3dKYlFk?=
 =?utf-8?B?ZEcxK1Vzb0NPc1VyaGFJMW9QcVFoRVZTaTZMMmp5dEhjZmZqWXVwTmJsT3dy?=
 =?utf-8?B?V294RFdzSHExdXQ3QnJYUXI5clp6RnkwMEtJQytMUlJtYkFNZnA1SlRyQ2tO?=
 =?utf-8?B?bVBkU3JKd2kxY00vUkl1amxGYWtaNDNXMnNpemhWMjl3SUp2MkNHOUlQWm9i?=
 =?utf-8?B?SkN5d2V0L3NaSjZYemYxOGY4YjlaVjBEUThqd0NXRUFvOHA4eHZPOTd4RFg2?=
 =?utf-8?B?NjNmdmRMeVFLU3Ezck9WblRUdko1TEdiZ01Od2tjZ1NDZGdKR05WQ2hkbVY0?=
 =?utf-8?B?VTV1MitPTERrQTBZLzV1NmlKMU5PQW5yMFduQVFoZ3pNVDIzcktvMHZqRnRZ?=
 =?utf-8?B?YnU4eS9CVERoOWVJZnNsb2Z2YnZEUmJCUlFaeHROZkJFc2wvTzVyMC9QNDlX?=
 =?utf-8?B?S3h2SFZGUUdMS21CblorNDVmZlcybHdLRXhVSTdjd2x2VElybDh3TS9hL3VD?=
 =?utf-8?B?ZWdZQmcwWU40bTdYeWw0Zk5Jc3l6WXk5dmt3Rlgvb0UvaThoaUpXMmxwRnpB?=
 =?utf-8?B?elFuZUNBemc4RkVJREJ0L1YrNTJJWHZWVDJyY0xUSVJuUmRJN3VmdlpTa05q?=
 =?utf-8?B?WDZ5OWU5MDhhSnMwUldadEpkVGp2SE94Y3dNQll3SWtBdjd0UVBpdzFwSkNh?=
 =?utf-8?B?TEhYeVRXejVQWGtoQ08xd1V3VzRLRlU5K2J0amhFUVcwY3ZZYmR1NzZhc0lE?=
 =?utf-8?B?TEFxMzZzYUovR1RWNG55M0RlRjJmR0Z5Y2pSUWNlSFNaamxiVU5XNGtQOXRz?=
 =?utf-8?B?RDdkV1RHamo0YmwxMFFLdG9ORzlWQ0pMcFdCS2IwSTJGQVRidVZNTlRaK0pT?=
 =?utf-8?B?MlNHKzJMclFUVjcxVHZYb0UyZkdnZVlUcm1TaVZoOEJSMzRsR0lmM1UrenhE?=
 =?utf-8?B?a1BUV2hFUFlFSC9hbjVkREh0R0wyeURua25tRzdOaHBMSWtjM25Ya3ZLdVJa?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b1948d-78b9-469a-fb8f-08dd66d7b63d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 11:18:02.0492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBG7H/2S4sj3m9p4XlO7N8jySbC4mEJD4Fpl+OxOlWCPp/tdrb7FBpPTWFSpg/4OGT6IZffLDTTN+yco/FcisO2MSRzYEgh6l2Ek9hWzETs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
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

On Wed, Mar 19, 2025 at 11:11:17AM +0100, David Marchand wrote:
> On Tue, Mar 18, 2025 at 6:35 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Remove driver-specific build instructions for the AVX2 and AVX-512 code,
> > and rely instead on the generic driver build file.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> There is a small merge conflict, so a rebase will be needed.
> 
> Some nits.
> 
> > ---
> >  drivers/net/intel/i40e/meson.build | 26 ++------------------------
> >  drivers/net/intel/iavf/meson.build | 25 ++-----------------------
> >  drivers/net/intel/ice/meson.build  | 25 ++-----------------------
> >  drivers/net/intel/idpf/meson.build | 25 ++-----------------------
> >  4 files changed, 8 insertions(+), 93 deletions(-)
> >
> > diff --git a/drivers/net/intel/i40e/meson.build b/drivers/net/intel/i40e/meson.build
> > index 2973ed1a01..25a3d72714 100644
> > --- a/drivers/net/intel/i40e/meson.build
> > +++ b/drivers/net/intel/i40e/meson.build
> > @@ -40,35 +40,13 @@ includes += include_directories('base')
> >
> >  if arch_subdir == 'x86'
> >      sources += files('i40e_rxtx_vec_sse.c')
> > +    sources_avx2 = files('i40e_rxtx_vec_avx2.c')
> > +    sources_avx512 = files('i40e_rxtx_vec_avx512.c')
> 
> I prefer += (which is also used later in this series).
> 

Ack, will change.

> >
> >      if is_windows and cc.get_id() != 'clang'
> >          cflags += ['-fno-asynchronous-unwind-tables']
> >      endif
> >
> > -    i40e_avx2_lib = static_library('i40e_avx2_lib',
> > -            'i40e_rxtx_vec_avx2.c',
> > -            dependencies: [static_rte_ethdev, static_rte_kvargs, static_rte_hash],
> > -            include_directories: includes,
> > -            c_args: [cflags, cc_avx2_flags])
> > -    objs += i40e_avx2_lib.extract_objects('i40e_rxtx_vec_avx2.c')
> > -
> > -    if cc_has_avx512
> > -        cflags += ['-DCC_AVX512_SUPPORT']
> > -        avx512_args = cflags + cc_avx512_flags
> > -        if cc.has_argument('-march=skylake-avx512')
> > -            avx512_args += '-march=skylake-avx512'
> > -            if cc.has_argument('-Wno-overriding-option')
> > -                avx512_args += '-Wno-overriding-option'
> > -            endif
> > -        endif
> > -        i40e_avx512_lib = static_library('i40e_avx512_lib',
> > -                'i40e_rxtx_vec_avx512.c',
> > -                dependencies: [static_rte_ethdev,
> > -                    static_rte_kvargs, static_rte_hash],
> > -                include_directories: includes,
> > -                c_args: avx512_args)
> > -        objs += i40e_avx512_lib.extract_objects('i40e_rxtx_vec_avx512.c')
> > -    endif
> >  elif arch_subdir == 'ppc'
> 
> Below seems not indented the same as above.
> 

Yes, the indentation is incorrect, but since I'm not modifying these lines,
I'm not going to do a whitespace adjustment - save polluting the history.

/Bruce
