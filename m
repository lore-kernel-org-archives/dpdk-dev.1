Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A17DCA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 07:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E6484021E;
	Tue, 26 Aug 2025 09:54:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 9F32040156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 09:54:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756194885; x=1787730885;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=By0P8HOcZUuuNkYY7rb/dPKQTGchqbt7Ne1xWBfGN+M=;
 b=HnBhofez4Sl0U8/klFNSudBCOQmHta7QLBHY3RgR5ISIG9hbwtBwrXFs
 dRcuBH52Et535Kinyb7SQ9IkSGCP/GV1UwlWVzWACjL/A0j83zjndYbwR
 m1SwmJhKi5i/zUOdwEIg+eJC99/VaXop+WlxClKWVY67wa36USIjsmnbE
 UnqiUbJasJjg1DfIa+35VZYcS5bZwzARzRuC5aBS0tLANyfTBfT43YMAh
 kNVKFQgt6h69UPDaf/oXHvX3+4Qz0AFoP+TY5FxY+3ZneN2wZ3RfV4k3Q
 ePjGNWxs6EeCmmnRk6Y9KPSRTEX4fblS6S9nkNkfB5yxOftqnF7Jng6Od Q==;
X-CSE-ConnectionGUID: TyBmZ+7SQH6F5iSHOtNfiw==
X-CSE-MsgGUID: FGHGnDrwT1CNgH6HdQbGOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58355239"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58355239"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:54:44 -0700
X-CSE-ConnectionGUID: 5A+XwR23R2ioDMvM6pcdbQ==
X-CSE-MsgGUID: 1efMjhhgStun8PZlCh2CHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="174818736"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 00:54:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 00:54:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 00:54:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 00:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3LTCPKGE4GSOqTuBDcZTURS0ZN2xIZRJcuhQvYvvP6mGHRzNxu9x+AT70mtbG+mnAk9Q1Xfjin99VCBbjir+XoL6bsBqcj9yMR3MBZjqJl7QVAw5ZycbM3B2M1PCNqSCREUz4E0EqpgWEM5QCmV6vji77I0WADEhCgM59+85PjB+tmQ7FepinKP/oovY+4Ky1Y0e1hyeL7B1xvahafCiNArgqFpAUXuI7TY/fOXGf1atbcATi+JoLOeKp+U6VVYhAS0CxyrHREpxdBND21SbL+LDo5NNgJIWB209iycTxvk9Ngi66f82pWg6FcYRTziGvB6mIhZWLHqN2LeD1bw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihEg/R4RHkr2hyMHWMvwKzUMpOqJLecScwDqSO5tLk4=;
 b=XgB9H2AOT70LQUmRF8hFk5tUptxP1NiX7qywI/4uAujOeSupq2K8Cg8EqYMNimgz+OHeBeowEEEyRRNQFFDCxEHNR8teXdupqTEmUwX1HtyYJrDSLfbuSa0sq98nUNKQvk67CxHhCszgAmSBp4gy55ZA1OEuqxayXTLKvzM8xu8YOtVcm31K8ioY6BdLI5CmnMk/FAtYAwxbs3ifRnLWOhy0HJNblu/SNOqOztqr7OLumxZxr2CqB/abpOPx/C+ns7o1u4YJn3fOq8MwrAXzKTPjEz33Bu+Ei3ye0EVEBmMvhjWYgehQAMiRh6/n8PViQmiYIwiaEskE54dssRXjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:54:35 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:54:35 +0000
Date: Tue, 26 Aug 2025 08:54:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
Message-ID: <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
 <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
X-ClientProxiedBy: DUZP191CA0066.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: e589f6c4-1572-4e37-0f34-08dde475cc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3lINnpLK1pZN09GUG1zTlYwaVQ2N3Z1VUdyRFZ4MndObVptWmxBMk1UZzFQ?=
 =?utf-8?B?elJjTTNaTStNNHdFRFp5OHM5Z0tlNzJlYnNYNURVVjl0MllhUWwvZjU5aHBW?=
 =?utf-8?B?b1o0SkRCZ2hEMDBVaWxYZUFYNTdtb2JWc0w2U1ZRR2xEaEVCTVp2M3lKSWty?=
 =?utf-8?B?M2tsR0hZNVdjcys5ZWV3bFgrMmVDZWZ2ME9KTHR5Y2JnWllBZzNmK2wwY0xG?=
 =?utf-8?B?azZPWkplOEs2elhUSkwvVngwZHJXdm94NVR5bjFWbHJDWFEwaG53MWIxWnRn?=
 =?utf-8?B?ZitqWGE0SDJPbDVLOWV2cUdGaGluai85b2daYUpmRUV0REE4ek1POUUzTFRt?=
 =?utf-8?B?UmgxU3ZoSllCOGE4bkpNbWFxTWlvQzVveUlSRFgyMWZMdjFLMlpxUzBHaTYr?=
 =?utf-8?B?R2NUNzNJbXpZYnEwMGNHQTJUS3pSa3RMZGNGcCtOSVBTekxBU3BZOVJRUVhm?=
 =?utf-8?B?dEE5VVVMZ25EbGE0WllKbTNhUU1xeFdHMnZTZnkzMVhZNzVpdUJoQ0FqS2lD?=
 =?utf-8?B?eHpSbFRvTlNFZndYRXBSZE5vcGptVVdiYWdTSGo4bWZ5aXNqVmFJMGI0eHkw?=
 =?utf-8?B?dy9JWVFkYjNxaHZrTWV0U1Z5VUg5ai8wRzR4dCtKTTVNSlhLRmpsMlo2RXBk?=
 =?utf-8?B?YUVVY1NQT3ltWE03bU1OMk92SVNNLzRtSS9aVWtNYmpsbEZGSTBBdEF2V0ZB?=
 =?utf-8?B?R0MweVJHTUlQOE10c1VHUG0zMVRLMlAzQi9vVjgvbGtubTZjMk1DK2twVW5D?=
 =?utf-8?B?cHh2aXFQMTkyUVRGSDJQMWxIRkNON1hvVzNoUEZYV1UxQVdtNG5CVG1sdDBn?=
 =?utf-8?B?Zm1FV0tjRXAzTFJxamR6ajlrVVV1T3lvejNhMlYyeTZBZDdwMHdSWm11bEdQ?=
 =?utf-8?B?QnI1UGpLTUdZeVo3UUkxeGwvQjQ5ZDJxaVp3ak1QVkNWbTRWRjlvSG5Zelhm?=
 =?utf-8?B?cVJNcXFEQWdwdEFkeW1CR2lsNDE1clZuc1JIRS92VjBXSjB6MHMrZ2xYRFVx?=
 =?utf-8?B?WmJUeGFrTkhyNXUxK3d4QTNZcGlvMEQxekU1aFRDbnBGOHlyeDR3eXcxVGtN?=
 =?utf-8?B?SHV0RFVEUG1rS3J0SnF6OCt5OFVnSG11ZjkrUDFuYUZwR1QvaXBTeDNoMmgx?=
 =?utf-8?B?TXUxbm1BcGxxRWhOSHJTdWZSMFJVUldFNUp2WUVKM0FtdVNEQ1AxQXF6cmVh?=
 =?utf-8?B?em9YaXUvbHhnR3l6SWE1cHJZRU8zMkk4bGJjdTRqSGZlVFVXdVV4K0JVRFJH?=
 =?utf-8?B?ZTFFK0FIekd1L1hBSHdoWUkxY3NRVnU5cENpTzRKRnNkTTB1aGxkZDhUc0hZ?=
 =?utf-8?B?R1k4SjA4NFplTFRKTFY1UlF1Y21xbUxlMEZYMTN4a1lZUllURXlRdVZJMVJp?=
 =?utf-8?B?Nm9CTGY1Skt2VGtLcGVwekZoaXFucHhjdk9vZkhBZmJQNVF0RUc0KzBjQXpw?=
 =?utf-8?B?dkl4MjZ3Wm5iK0t3dWJPTHJOa0F4NXR4aTNYcGlrbDRVZk1VSWRRTUNkWGlW?=
 =?utf-8?B?NHI4TG1oS1FGREU4RGhPRGp4MTlEVnlUM0tmNWhGVkNmM0VabHptN1FQUDF4?=
 =?utf-8?B?RWtEUTliUDdON292UlYzYUFIcElJZ20vcDFZZjU2REsvWGRFRUJBNGVmY0xK?=
 =?utf-8?B?UkRlV3hxalFyRVNrT3IrRWxvMnNUSFpHdjl4bDdGdTByKzBtMjRPUzRUdEJq?=
 =?utf-8?B?ZXpoTEhxREd5cWVFOHJiVS9aR09LY0g5L2VaREFRWHNmZ053cURtdXBZblBT?=
 =?utf-8?B?azVBdWtHVFdvbnBnOXMySjZNRTVVcFN0YjhkTU83U1hDbHBoRGZmYVVCY1pv?=
 =?utf-8?B?bm1DOUEwMlcrU1ZaL01LbU84Nm9oZHkwK01tKzFhN2VaUUVCOTlZUEpnQlFu?=
 =?utf-8?B?Rk5qdERYbWd4ZUVzN3A5RU5jUTM5Si9oYVp2UGlnOXdXTXNMSXdXaERMRVMy?=
 =?utf-8?Q?jeVMfUzVw8w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU1LV0JOUlY4VEJBTEFNVU5ISnJmTmxRbkdBWklnVjlrc3VRajhzQjJJRzRw?=
 =?utf-8?B?WWFubkhiSDJBd3NEWEt0bzNXdGdLRjhnWGFxdC92akRLTkdldGRXWm5ia3FM?=
 =?utf-8?B?b3NBM3BRS29pbTF6YmZZOGJpeCtnOGlhM1dxTlRLaVlKM3NJWFJjZkY3ZDhS?=
 =?utf-8?B?RnJGMExRcG1vQ0lYYTdFZkYxVzRRZGpXQnRFZTZuZWFNVzZjY2V2dGVVanBS?=
 =?utf-8?B?OHBIRWk0RVZlaENnSTRlN3JPTXBmZjB3M3JrTlR5RnZXYVE4QTB4WHdmL2V6?=
 =?utf-8?B?dWZpdzlWK3UyenM0dGZKc1FRY3IxUGJqb3FWZXJ1SzZDbHlNaTFUTnRMeUpi?=
 =?utf-8?B?Yk50dWtwZmJVTVVPNWt5dGQvRjFhbExIRHdzVUNYcGlqWDRnNkFaOXphT3gw?=
 =?utf-8?B?bW1wSEdEZWZ6RmMrRDBDZU9KS1pRdmlSbXg5djFjOTVUa2JyVVFaZy9MamhC?=
 =?utf-8?B?YmwzdTR3OStlc0RJbVcyU2NvWkQxTFNkRzhxQ3ArTndyK3IxQ2ZYUEFUbms4?=
 =?utf-8?B?ZlRMTlFVcXlLTVFVN2R1SnhkbUI2TS9Sd3I0Qy9kUzV4YXFFVTdSNHRuQ05u?=
 =?utf-8?B?ck0rQ0hlVFJvZzUxUHJ6OFlFR1RBbElrQ0dPTy83MDhCenRIbVRXdytvbVpF?=
 =?utf-8?B?SjY0S1pCQ1ZrQmlLbHloTFBtZE5jT25DVEgremhYdm84SWJZcTlMWkdXZ054?=
 =?utf-8?B?cVJnc0R6ek5XdkNLcHpOSjRQYmluUW9xZCs2Z3lyNlhyVTFGWHdSQ1NZRERm?=
 =?utf-8?B?dDUwVnROaWdRZUlXNGI3RnlKTnJ6R3ZmUmZ6Rzh6bC9kQjhZZWt2bk92aW1H?=
 =?utf-8?B?Z0RJV3hKVitGLzFFZ1pUK2g1bFpiYlNsQWN2TDQvU2VxdWE2TEY5Tm0wZnQ5?=
 =?utf-8?B?bUF1ZDJ5VWg1Wm1RY3N6TDZJTUFLV1FyQ3JPcnJ3RlREK3huQ0l4OXhYMnp1?=
 =?utf-8?B?ZDd6NW9XbHVNZXVYL2IrWW9kVWJaVmg0NEprcTdWanM3VVNtamU5MUlRcjZS?=
 =?utf-8?B?T1d4RlNDOXhOdnJZa00wbEVFaVRYd2l3aUJEZ3dIU1djNzNwYzVyWUdhT1U0?=
 =?utf-8?B?aEZ0dFljMVZDT3VpUHhxL2xiM1NVdUlseHFlQkFJKy8zYlNUdk4zdnpjaEg5?=
 =?utf-8?B?OXRWbnlnY0RDQUJaY2NDNnhhZDd5UWEvMldFU1VkUUxiTmg5WkRHMkxVM1Uw?=
 =?utf-8?B?TWY0NlRWNGpvRFI1a2dabFhUTEJHQk0yYmlBUWtLa2lGQjRhKzFyVlF0ZHdL?=
 =?utf-8?B?Zk5NQVNjaGtMMllTbmJORFVQTlkwRXlldzhnSnpXZElqTzFvYkQvNWQvRmE5?=
 =?utf-8?B?cThpdFYyTkw3TDd5anFlVjM4RkQ2MVFsdUx1TGNnUEEvM1R6eWw3eURpdVVD?=
 =?utf-8?B?NWRIV2RVR1ZnTFBZM2J2NmFtY1YyY3lXYzF2WVROQWR0Rk9qT0dXd1lDbmJ2?=
 =?utf-8?B?aU1QaVlqcUhhMllrQ1VCOEtzelA1L1lnL3oydi9QRW9PSXJxY1NERnRDRjhi?=
 =?utf-8?B?WGR0TVpzeWpQcWZPN2M2dVJIdS9zQlZLSU5ZRHhNNms4MGNhYzAvL05KbUZY?=
 =?utf-8?B?NUJRVDNuSWRuajNJZUkwQzY0L1poRGZldXR3d2pBZXBWcDhqUENhUndVdWNj?=
 =?utf-8?B?TXNDbWVFTTZQUXdZTTRhb0poNGhoUTc3enBCN0hkWFZueEwxYVRzNWd1ekNC?=
 =?utf-8?B?amtYRG1DRHB4dENPdTNDdndnRTVhY0tzazd6elRCRnE3TnZBbm1VM0xVWm5S?=
 =?utf-8?B?anZtTy9wUUxQUHJzZ0FzUUxKYzZrVVVuQzVlc3kwUTh2b3pScmZjUVpXSHJK?=
 =?utf-8?B?bVBzNzNnYTlhblhIUWxSWnFxRy9qUngxWkFYVHgvaEpTWTgreEZIZjJteDZl?=
 =?utf-8?B?SjZYSGZ1R3pTUVNYWCs5elZzTWhyK2NaaGRUNUdzaExpbVk4bDJIeU5BN3or?=
 =?utf-8?B?L2JUcWkzcnJEb1IzSFFiU2lkSUF5VURYdlJ4OGNEcnpHNnJrSXU5OS92ckhn?=
 =?utf-8?B?bVFVcDZvSXR4RE0zb0tFbktZMHNVYkRDSXRuM1NKV01uMUdGajFDVFZ5ZHVV?=
 =?utf-8?B?UU5CZ1Jza1FVWExnVHBKM3hmdzBuM1JTZ3ZzOUpTR3d0T2NabllhWVkxTWFG?=
 =?utf-8?B?VzZPT1lHbmdhZzZOekpTL1Y3M2NBQmNSUHloMWloV0JtRXU1a2huWDluVDRj?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e589f6c4-1572-4e37-0f34-08dde475cc5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:54:34.9381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6o5hGwc1h61w7spAHSj/rml3iIvf0H9YCWCMNYKMODhL42dG5aD73XGSQJnO7Ua83Xhbg7oHuAsxzTc+5E/P860PO0jGvUdZrUyqi4D5L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
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

On Tue, Aug 26, 2025 at 12:31:26PM +0500, Khadem Ullah wrote:
>    Hi Ciara Loftus,
>    We may need some legacy support for the SSE path for earlier systems.
>    Or it will not be a problem ?
>    As you specified that modern x86 systems all support AVX2, if not
>    AVX-512.
>    Still, we might need some type of support for the SSE path.
>    Best Regards,
>    Khadem

Hi Kadem,

can you perhaps share what systems you are using that do not have AVX2
support? Do you do new deployments with latest DPDK on those systems?
However, if it helps, we can defer this patch till after 25.11
release, so that we have one more LTS with SSE support still in it. That
would mean that we have a supported DPDK release with SSE in it until
potentially end of 2028. As it stands, even if this patch goes into the
release, 24.11 will be supported till end of 2027.

/Bruce

>    On Mon, Aug 25, 2025 at 5:36 PM Ciara Loftus
>    <[1]ciara.loftus@intel.com> wrote:
> 
>      Modern x86 systems all support AVX2, if not AVX-512, so the SSE path
>      is no longer widely used. This change will not result in any feature
>      loss, as in the rare cases where the SSE path would have been used
>      in
>      the absence of AVX2 or AVX-512, the fallback scalar path will be
>      used
>      which has feature parity with SSE.
>      Signed-off-by: Ciara Loftus <[2]ciara.loftus@intel.com>
>      ---
> 
> References
> 
>    1. mailto:ciara.loftus@intel.com
>    2. mailto:ciara.loftus@intel.com
