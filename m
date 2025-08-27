Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194FCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 14:14:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00B5A4028E;
	Wed, 27 Aug 2025 16:14:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 70C374027D
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756304052; x=1787840052;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=d/8MeIHJdfpo7L1uIkBZI+c7mp/l1CZJ+bkzIo3t28U=;
 b=lWInS6idvSveTFaHR1sHIuqVQ1o1l5osRN+9sYGfXtYG5Inq7E4hibWR
 EZX6jzm+2ww6miZadw7oWAX8tpOByJ4ve2LrrjIlZzBMd7Q1RJgdQCH4i
 PRsu8df9N2DWr+6w5jfGDIRskepHWqiPapKpUtQjwT6ljFwo//qLIiifq
 VtxAl8x/dtg/zDzQJFO+P/+QGqwA2M8ZyajWhqzcaVAdfBk6sKX56RsBw
 wZlt6fHWs5U4nT4HCgBQDLRBKlgpy9OyrmSl0WkdvCLYcriuPEjzhlp5l
 IqAagRTz+kXw30kKWjoaKwf6mPR916gZZjxsRwBDL4uFBR5RsVaIefJVm w==;
X-CSE-ConnectionGUID: k+Xi07UuRn+NrQVvi6A68w==
X-CSE-MsgGUID: 44GH6nM6RbqIwk2sSuUJMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69925788"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69925788"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:14:11 -0700
X-CSE-ConnectionGUID: d3jv1SPSREmN79kgUIFwqg==
X-CSE-MsgGUID: CIIh6XfWTv2nxCZiRAkerQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169099810"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:14:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:14:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 07:14:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD/DZJ2IXB2qdR3svVJKVaOqt9rUcxHe0cg5Zvp62MtoWTqun36gFEZLJ2dtSTtk9zwmqe4mIrfYyfAznNGhejF0c6sxUiP2Bdn2IH7TGKGlb3FrWLQansEvE7l4KTcK6B/hl7y186gUj22FGdCpZtWFjCPNWPZ5Yel5EWjbgok5vvv9kn5tX/LQ4it5jQV4DyUnNMmCuy2khZxO4dgD9R5Yr1IdYCkFB3OYSODagpREYVdHaw9d0qb4LkakSmE4eD4zqsrwHKPNpnLjImqT0lqBTfHZgg5Z6wzd5NQmwghRq8mL7MB/BwU4794pttPiVd8wT01CINKE5X4hA6gCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE+XYq6+wj+PkodSde8UpbJcWmILzjK2qScpriGaJ7s=;
 b=SA1ZTx+dwfVguKBZ5Idsy6ZdpTudQPWzlm3494wUGcJAw7jaVkzF+kjPTsIO7/wcOinEW85vY8RaDpgkC/vrRNuYMzkBs/0oX84/NPFW6EHboQecDUjERG0aekohZuCVVq5/3UIFpbOD875Xn23EWH0j96fLOcFOMAN+u9J1kTqVp22HUZn34UeJG/SrWgVtGa9Xf/Hl1+Fa1LCs6gNS4iSeXSA+qRL+4TSGIJPWHZgKUaDW3TgFcjV20cG3SBPsteK0fSY553D4JruEWEaiql3aCJPE8uVgqYkmlZ12JvB3YHjjDGjLT9LX4vYLVhPotxuE/p5FtkJnL3ez4XtXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:14:07 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:14:07 +0000
Message-ID: <e9017361-f29b-45da-a1b0-cc745b8c906f@intel.com>
Date: Wed, 27 Aug 2025 16:14:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@microsoft.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
 <20250818093416.057aad97@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE53@smartserver.smartshare.dk>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE53@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0194.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b304e7b-257f-4793-4b0f-08dde573fbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykh5STU3ZkR4WHpvTVRTbGpvLytUUkEwbk1Gd1UvaERCZFVWZUNja2wra0tj?=
 =?utf-8?B?ZytzNHF6L1QrSmlOdVJzM09mL3FqWlh3QmU3Wkg3UTFrSHY0Q253UEhGaVd3?=
 =?utf-8?B?ZjZqMWd2bFM2NG0xN2xsV2NIczA4ZlNPVU9KTnJ5OHRqUnFyenFUajdDc005?=
 =?utf-8?B?TGZjN1g5T0h2Um93bUFPb2MyVjArdmhoTmtxd3luRExJOXIzdVJmbkpacFMr?=
 =?utf-8?B?NWN0dzVuMXNaWXdTOGlGUW9QM3dBVTR1VHVaNWNFYi9ROEcxSkpUc3Q5azM5?=
 =?utf-8?B?UURSd3NlN3krY083L2Y5SUVWZnVveTVWZzc1VHRFZFd0cnEzL0RMTWN5bHhK?=
 =?utf-8?B?RmNVdHdFekhaankzcHVLWFM3dkt6RlJrRmFmUU5wb2JqbnEvd1dXaWhKQjZo?=
 =?utf-8?B?WEFzVXRHbzBLWDdUNEVab2JtZ0Y2b2tiUUZ2NWsrMWdxUWI5cVVxdW1RTVk5?=
 =?utf-8?B?SUtXSVF3WXl6VjBqbUJNYzJyMHdpSnVzalQ3dkkrRFdkQnBaYTN0b0tKUzU2?=
 =?utf-8?B?MEFsRFZCUkVQWDV5K29aSWFiNkNTUmttdTE4N3ZVaEhCTENJUmdNMTNzNlFh?=
 =?utf-8?B?NVhOck10Q1pZVk5oL1FyUGNBd3N5eEN0c2UxVzBQTkhSUkM3dkNScmxDaUR2?=
 =?utf-8?B?TjMzcS9EcWdvMENsY2tBdXN6clpyQUZDSC9XNE1May9mb1B2eExZYXVoRWJ1?=
 =?utf-8?B?YnZrV1hWeXZyVHV2dm54bmhWWVZNYm95aU9Dd1gvbXhGYmlUU3pjTXRBbzJj?=
 =?utf-8?B?cnlxZDlBd01mdjZTYk1OKyt4aCtRQ1FDajFuczlNSjE0bTNVK0N6Tnptc040?=
 =?utf-8?B?MWFwNVZ1N1hOTmVJM2htY1BWUmJiNmo4cHZkZCtBVzE4Yk4vcGZkQk5mUGxi?=
 =?utf-8?B?TlBPaWRqZTdFa3VhVktqRW4zZEpXU2VvSTgydDlBSjdGMVNnamQyd0E1RmlD?=
 =?utf-8?B?ekd2ZkdTVlJxcEpTR1BDU2FNRU5ZRXo5ZzdpZjV3T3JiQUpKeEI2UXlwNmpP?=
 =?utf-8?B?RlNvdlBzTnVjUld5M094SG94dTl6TXRKSWRMelN4ekZsbncwRjBucjd5MUpL?=
 =?utf-8?B?R3FOS010TjZLTTlTUzR1YW16MHZ0cE92ajhOQ3UwWkhsblNIc1BWQitDT2t1?=
 =?utf-8?B?cVZkaGxQN0xSWWl6eHR1VFAwSytrNWVSaitFTmE3emg1SmpFSkRMWW1HTmQr?=
 =?utf-8?B?NUYza2Nsb3FVcGwyRXFMUXRlTXc1VnVLRXY3eUdhSnBQRmI3MTB3VTUvTVRT?=
 =?utf-8?B?eW9qWUJodkVkYW8yZW1mbTlqU1BRTzBMNXlmakdpWlJmdEp2QnkrNmZPWlg5?=
 =?utf-8?B?OVk3RldnaXBrYi9rNWVoZkU0bUt3djJDUlhxZmtwVi9YcjllSWlCSHB1Y2pn?=
 =?utf-8?B?MDh3SnI2RzErYjJsbjltMytIZnoyenFqUitucE5tdm5ySmcyaUhvK1Q5dU1J?=
 =?utf-8?B?bEFVNDc2dTQrTm44WUgvdUEyeDJOQWdGcnQ1VmhDNWNEaUw2Mm9Jd004aHBu?=
 =?utf-8?B?M2FqS2tHTUhlMGNoSzV2L214U0Q1elpwTkUwb2tORW9lb0FiRzhkTTlHVjY5?=
 =?utf-8?B?Y082Sk9KWGJtRjYzeWJxQkVZVjNUcU9MbVduOElLcEJNSEVWTEEwY3RsNGNR?=
 =?utf-8?B?ckFhY25jdlQzZHQ0SW9EdXRVU3dVLzMzMWgrMVZNY2hEMTBkaEZvSE1BWUYv?=
 =?utf-8?B?TmxNQ0hwdDA0dUVZOHVETUw1am5zQVRJQ2VIT21Nb2lkYjhmbmYzMnE0WUhK?=
 =?utf-8?B?cjFwb3A2THFadFgxandPcjlySnZmb3hpM1ZVakFUM2pVSW41M2xFbjI0TklM?=
 =?utf-8?B?NGZORlM0cmdIWXp6S1lCUVB6QzVQZW16cFVXSk8vcmpuL0hxT2RyKzlXSEM1?=
 =?utf-8?B?ZmJja2R3TDZJVXhDN3lhTWNwQkhFVG1GNGlMTWE1ZzZwSytKUkJoV2N1VkRZ?=
 =?utf-8?Q?UGF/O9px7n0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1qZDBoL1YvL0RzYldyRE94em9nNW11cFdNdVRpc2F4cW9UWWNuaHg3cm9s?=
 =?utf-8?B?dTNFbUUrSXhqZk5qL0s3OE5iQXQyaGVVdlVZN2doM2hBYmg0dGZQYnFDazhC?=
 =?utf-8?B?bzJveklsZFo2TkNyYTcrd3dKZm4ram9YZXJ3SUtlQTB6WTFRWHp1YU1NM2NU?=
 =?utf-8?B?R2EyU1BtMEdab1ZQV2gyOW1WaTdUTUsxMy9HeFNKMnIvaCthbmNMZ0FpTXhC?=
 =?utf-8?B?T0Z0YXhIWGJMRTNZT0cxQWdHaUg3QTFlOWxSSEp1ME9TdCtSQjJ0SUR3cUdL?=
 =?utf-8?B?UlNlUGxaUjhqaUswejQyZkdsd2JPcTljajhkeVl5U3NYUWtySWNOOEpVTmdj?=
 =?utf-8?B?RlR0UEdRSzNYUENnYTBXWTJvbHJwYnc2MURydkVOc2RmaFBudUpad2NQTkE2?=
 =?utf-8?B?dFlYTnQ3dUdZemRoOU1YRm1UakZWZ1FaYStMK0xuZGFhZ3ZkTDI1c0VYYWJK?=
 =?utf-8?B?bzBTdngwMFVEZWovMDlTYmxXa2grbWQ2L1RvRklUbUczY3krOFRVODJkMFRr?=
 =?utf-8?B?RFZrMTlEWjkraFRTNWR3RGR3U2wzM2RhNU5aZWNxdVNSeGtPYmZwK3d3TEc3?=
 =?utf-8?B?OGhHaWNEWTlGamJRUDhqVkIzYUtWVms4cy9CZ0E0UWsvY21vM2Uza2lnRmJX?=
 =?utf-8?B?NXIrVjdOd1N5MW1QcldNYTlFLzR6aUtUbzZLRjJFblE2UWRuYjB1dGp0RkJO?=
 =?utf-8?B?Rlg4T0lhZ0ptSjVzRmxrY3l4K0J3SFB2NW9kVFNZeXp0d0kwMG1Xb3hYL1B3?=
 =?utf-8?B?N1JXdHlYSlhOTGg2cDVWOEdGRnY5VENrSHpLVTRpeWJOckxDNjhwd0Y0Ym1C?=
 =?utf-8?B?bDVKSXl2VFhrbUl3dGdsaXBLcGlWakYrYWJaTi96SFlEaWUwR1dBYXk2b0ZQ?=
 =?utf-8?B?Smg5Ti8vUEpCUEZINlVhaVZpN0gvTW9sKytKU04wMnIwL3JBcFgxM0FDdDM5?=
 =?utf-8?B?ZG1TVU40WTlWOVRPNUhicGtqWjUrTjhyYXd3VzJVckNUMzI5RXdpUUlWUHpm?=
 =?utf-8?B?Rk1RV2I4ZXRadHZKSWVxUkUvRS9IWWxrMm5EYzEydUlUMVN2SDlxbWZEM0dN?=
 =?utf-8?B?ZjJlV2xVdjYxOXF6MUJGNko5LytDMTZta2hNRmVvbFZXR1UzemkrNVRJeTN1?=
 =?utf-8?B?WjVYVGw3Vm1qaDBPZTYyR0JJeStVeEN5TUk4dlBQemlHdnNUNXMzK2ZYTmd0?=
 =?utf-8?B?MldNVzNlcUt6OEl6TFE0MzdlWHNtZms1YkRnM25UVDIrcUFUT2tMZDI4L3JK?=
 =?utf-8?B?NWtPVE1CZFBMSkt1NUlkMk91Vkx3akZTek1PSjh5dHVmdVlCYkhuQ1ptYWVE?=
 =?utf-8?B?TjNTS0VFTTFva1o3R2NRMDNLQ1RVdnhDeStMTHNPV0dhTU51c1E0S3pkbXFi?=
 =?utf-8?B?L3hTdjNUTXEwdVA0MFozMFBqYWNNeXRneHI5aENKbmlXcUJiOEVtWm1zR2RX?=
 =?utf-8?B?MjVPbDN3RGF4ZmI3eGg1Y3UrTDVKN29wSTNJcHE3RGZFdVFzQjRTdmlsTDRv?=
 =?utf-8?B?SEtielh6ayt5TkRSYmFDU05rTVRZby9LSE5pcXVLdTJDNlh1RVhhN3cxejNa?=
 =?utf-8?B?K1FqVDVxTFJrTDVWbDcrYmdRWU41bWwvQkZkRWVUREl6a21ldlJKQ2ZnSWZu?=
 =?utf-8?B?SjJ3ek56L1BhSkszR1BHRFRlL2VvRzlwajlzR1JOK010Q0RCQlFqTUtUL0Yz?=
 =?utf-8?B?ZzFFWlVBUWM3L3R2c0RvYlRLcE9vNitvdFR2SnAvbjJBaGUzK0hGSEVIcG5p?=
 =?utf-8?B?QUV1bkphSmMzeUwvQlFjWTdsVGc5NDVWWkFWT0ppZTRYZG5mUkxBWC82UDdH?=
 =?utf-8?B?TDdwdmlaR3dwaGROR05mMXdPUnZWOXZyZmpUa1FmcEx0d1RIMFhGNVVkWndP?=
 =?utf-8?B?VWxpb21mWklJVjM3UnZrVnJxTTV5NDcwTXNJVjJzaVZLVThVUjE1WUtvb0tV?=
 =?utf-8?B?YUt5RklnUlRZMUFaMTFrcjFmblVNMmY2cys2azZQTlR1ODkrL3ExMjByVWUw?=
 =?utf-8?B?ODhxN3dUeUdkZHQvNGlyNkRta3U1SHprK3Yva1IwbGZPNjlYR2xEb3BOd0xU?=
 =?utf-8?B?OWEyQ0pLVnRYTDJiMEZzblo3aXdVVEw1U3FCRk9IYXVWUU5EcSswTEJKOHJv?=
 =?utf-8?B?TWN1Snd0eFlLbEl1dExjd1RpMXhTMWdEcXJ4UFFrMkxjUW5Dd1NtbGFtdGsr?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b304e7b-257f-4793-4b0f-08dde573fbdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:14:06.9999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOXEcs5VGXqZweSF0JgOSZ9QSPyJXXxU9QChGJB5I06wcYOEQaB3TfMxRdcdNyZhBpVsm0FdHou/9taYeUOFavJfWZoKyEVJyFiZcMRKuVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
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

On 8/20/2025 8:42 AM, Morten Brørup wrote:
>> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
>> Sent: Monday, 18 August 2025 18.34
>>
>> On Wed, 12 Mar 2025 16:15:29 -0700
>> Stephen Hemminger <stephen@networkplumber.org> wrote:
>>
>>> This series adds common macros for safe iteration over lists.
>>> It is a subset copy of the macros from FreeBSD that are
>>> missing from the Linux header sys/queue.h
>>>
>>> Chose this over several other options:
>>>    - let each driver define their own as needed.
>>>      One Intel driver got it wrong, others will as well.
>>>    - rename all the queue macros to RTE_XXX variants.
>>>      Seems like useless renaming and confusion.
>>>    - Several distros have libbsd package with the correct macros.
>>>      But adding yet another dependency to DPDK would be annoying
>>>      for something this basic.
>>>
>>> There are more macros in FreeBSD header that could be useful,
>>> but we can add those later as needed here.
>>>
>>>   lib/eal/include/rte_queue.h              | 174 +++++++++++++++++++++++
>>
>> Revisiting this and wondering about naming...
>> The file rte_queue.h is not really DPDK (ie not related to runtime
>> environment).
>> Thinking of calling it bsd_queue.h as a compromise
> 
> Since it replaces sys/queue.h, then maybe sys_queue.h (or rte_sys_queue.h).
> 
> But more importantly:
> It is not really DPDK, and thus shouldn't really be part of the EAL.
> So here's an idea:
> As part of de-bloating the EAL, can we somehow add a new directory structure for independent "libraries" like this?
> And treat this rte_queue.h file as a "header file only" library, and put it there.
> Then, build wise, the EAL could depend on this "library".
> 

IMO it depends on what you mean by "EAL". EAL is environment abstraction 
layer, and this header abstracts OS, thereby meeting description of an 
"environment abstraction layer"?

-- 
Thanks,
Anatoly
