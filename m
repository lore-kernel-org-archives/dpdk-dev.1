Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624CC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 10:03:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0B634270A;
	Tue, 22 Sep 2026 12:03:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by mails.dpdk.org (Postfix) with ESMTP id 09006402BA
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790071410; x=1821607410;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pwJ3RPRKGkVPrnLRhoTx7jmDMUMY5F/K9apzls4gIcc=;
 b=asv5M2smd5VEw2SHiy9utKU6s/wAi96zo8bgldeQUMKYUsBO9/g4pQEV
 a8Z02QQm1YuOYIOh02avv72TYmjxf9TguY1xGGNEMrsPJrchUCukZ1oSE
 lnhG4XygLpvExLLzPcVFM+ZEB10B0anSpr18HbneI+4FnrpO+mOd+3rNe
 9yB8qWsBkTAzAOR3aU8kTBvisuvGKCU61dRjoCKZCY84RTO/hAn6cAzEg
 EFRZaZiCihjDUK2LrQvd7Bn6kq5hUqEJEE8QPSBSf+24ftnUMTNklVkyf
 XLZJAxrVHpQ1M3qL20CiwRPKdriSKlcBKv0jRNKurOtK5fc31iTEvb7Lg w==;
X-CSE-ConnectionGUID: jJQ3QWgTQa6AncDIKOHuvA==
X-CSE-MsgGUID: K5sZUipQSpCJkyYfj18gkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1162306"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1162306"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:03:29 -0700
X-CSE-ConnectionGUID: hBvYczRfRr2ALe5LHq9n6A==
X-CSE-MsgGUID: 4hWyzlFCQO2fbSEyIXThTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299303444"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:03:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 03:03:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 03:03:27 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 03:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzfzOjubgCwAMsdkTs5B6t0QYJxMeQ/NacOIGIb2xAX94G6+RTd8SSWeqj7odgdXvif6q511ns8BYhsEL5C6FBEL6pfkOW5dmfqEIMROIDNoZZcO9Ycss+9DWaHtLUhN+UN3bkl4Gv1HIKEPSl1FfnoQ1OLQBFHn8ar/Sy0WJsbPXdafvugSrlz5966Na6nd4UIl7bbVVfu83VWEUtmLTuisHDJ07yPCZ+76nXX/iV8P7rq8aGZ8+V2hYsTDtxhfgoxi7qfSrrZuRQ6bHO3y691PSZxnAvsUG8G3LJY5uZxu1Zxf+pIt2hml76I18e90sPdjn0C8GvFqQcRukzynFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxuxIYCrSKxLl45Q1wcOIhkWm7aEF+JKTIe9o+S/Vnc=;
 b=Et4F+XsyAd1+WEaRLsX5GDNrqqLFpSZs3RuoFqzyqMgAaO4/n+Gra0E2VWIIdQpZ3CsX8daVSNOC4Zxv+8VT987cTOYiP4rwooV/7Uw052yx4s+ErHsCbxNhJYShjbmC0zUQtmjwQtMRKfAGLbXG7x5V/FV9TVWeX5SL90slVTZS8J4U8LgsD2dQKGwVW98L9SovrGuwNLy6+jtkH9aB87CVffoOaYH8lmE6Uagboc5ZZE8xt3VN1cSXRXEBzJv/OlgP/qjIFVn36QlxPVTciSTR2EFrgnhLo80ptbQq9f50k+/ZmeiRI7jF2YUJ2OA9eEgp1e57gMVsoG7N4ZCAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB021866.namprd11.prod.outlook.com (2603:10b6:610:365::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 10:03:25 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 10:03:24 +0000
Date: Tue, 22 Sep 2026 11:03:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH v4 9/9] ci: run reference binaries against current ABI
Message-ID: <arJSaBypASsxgJt3@bricha3-mobl1.ger.corp.intel.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
 <20260922094026.2636265-10-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260922094026.2636265-10-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0331.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB021866:EE_
X-MS-Office365-Filtering-Correlation-Id: a2aaa02e-9b71-418b-d5e3-08df1890bdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KT1Ai5RDKsoo4CMs85IdBP23FtTg1FlDKKY0HOfgE3wmTlR6QA0jtlDAA9c1J7KwsCwTudrGU20C2RIJAKrsfGAD272q+oJLA4bFMTf5m3EattDrPr3kqeziCraBDp2rrhJaamoovnA87s9fqEk4xol+endeI6ayLGOwUtSd0sC1Lun4RcNBT9ahi0lqSoQQTlG7MZu/GyWtb9HLqlCWeq3tkLK+Rbdk7s4ZWtZ09BKLZCP2tnmDc7rB24HfYMmgzRHispuWwUdVE48IvtAoEGg3DPxRKQmOhY5n3wQUMMW6cCe2oJWuhK39m3Od0IbONMk4ddTbHk3pleDh3QtTzaCOw6QSrZl53oRk00eE3qRRb4yp4BoDc34XBx2xpSs8ulCuXhveRZXcXDsNT7xdg4UnwpG2T8utB3boaqJSi7MwqwtKnT9BpwpNskBrjXt/o3CjbekPzVJksInKkV+4Yy7usnuSVobaukK9LcH99Aq1S68Esl/jvsKGC4rn1aM7lwBeRszQozSEwRSdxKAsQibsVPxQfqTtKRjnNzB0i0Bf3gxPXv6wWHfh8eKlhoMFhWTW/oV5eJcqI862R4A8nUuuhIiSy7zA2RmuRP13b2uqlhmRcUgLtUkAfyW3wv7RSLz9H5dGMTNfHoLFWH/5jY2OxO4luh5vMEIvkWe23D8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYYjfmE0ICPNz6ppiI0Fc9dZSChvE948RFFq4m8daALlZ7Hu01xbeOOjXlm3?=
 =?us-ascii?Q?GFfXb10oSEkemyKeqMG7lshRvLnjRnJJlDq2Oc03CMFNtl4i5Bp9LdxsRA4/?=
 =?us-ascii?Q?wg1TbQSUqUrh9h/B0leYY4tQGv/JQrn/xJBJddj3KI8CgmGAp81XehI4aXuI?=
 =?us-ascii?Q?NLDwfUZlLZDmE/d432LWOlbszq/dqVnH257Is62js55YAedmcH4EVoHd3l8v?=
 =?us-ascii?Q?Gc/YdfuzreibDO1QGYUNvRaPhKsLrnm5QitE5H92OaQMGdIkHkJrS6z0CDq+?=
 =?us-ascii?Q?54Lj6kb9Z6WlVCcW9oIyuvx2FYB8qk6Q5MsmWMtU7vk6pGuSv0MbARrpcVXj?=
 =?us-ascii?Q?1qBQwT188hGahRIj1EEH1bTs/c1Uty5YG3FPhAfCTK79+e66NrwzxOZYE+Bs?=
 =?us-ascii?Q?GNHErTBJmT7Db013iXP2i5zUh/IsYFZpXh/TMw1l1EKZ0+HfXqblHetyn/IZ?=
 =?us-ascii?Q?3i+qAtaBB7T49oNG11s8VOpsYswWB43wSXvNEI7CDHcb+UG3Wnbv8I4RF/xA?=
 =?us-ascii?Q?kgptGvyPphY42cVs/kPnslOm62xy7kXzIBZ+TeACXsP7nXgwQzBa286MUHdR?=
 =?us-ascii?Q?Qzjul3tN3XgJZHqta0aZanpkI7wq0YF0OLFbLBO/J1nxJXpw/4cRCrim1VDJ?=
 =?us-ascii?Q?57CSJX7Ebmz4l9nIHqUAdrbcW+e1Yuv3ta4/8wJDmK8OCPdExQNDq4gbJJOC?=
 =?us-ascii?Q?E/4jupiYgbDz3/36TulJEdf6w07XicJ/rzrqmaTiNnRm8PCg6mz6ZlPnwrTx?=
 =?us-ascii?Q?6PdOPGHsqAkPQrHqKjtn7ijyoCLEw1IL6G9mk7C1PljNyi0L7LOpomyiMRQe?=
 =?us-ascii?Q?NorxEe8WcSWY85WnP0wymr3GL+daMqfp3TqEDZftrsKbRid+jcPK2xJ+a0Qi?=
 =?us-ascii?Q?CaQDgR5sgbWKy+AtytcAXCS/gub9JxVgktbmcXQtzDyCPkRwAzzRYKDVeCJR?=
 =?us-ascii?Q?fESvbKC/jE4IEJlsP/ndFXyZq0mydnl8uJWIzzeownJ4pl+ebNQAanUnsgau?=
 =?us-ascii?Q?1fnF2q+37OToAdKIU0cUqEdKUe3A0pnCvvGr0bWWU5g5ZzmSo6o4oJJlXtwm?=
 =?us-ascii?Q?2J06NTmTE2t2N21rh2ORrjq+R/v7oeLqRRfqtSUOJGOKMBKAQHKVrXcsx5ic?=
 =?us-ascii?Q?k4wSEXfIxqztoWC9Wch7rXfoncthe6Z576sOSfL6aXcosAmwJsAFuabfVB6s?=
 =?us-ascii?Q?7Vvw4lsz0WD2/2m30g/kpBQg4yckuQcVgqIclseDO4fGaFiqAGGlAQ561Fsv?=
 =?us-ascii?Q?Yv9vjN1/6BZ/6m4bbjUbso+sr/SvStU2S/WZ4AcxkIWE9tQS3qdkaG+6Fk2m?=
 =?us-ascii?Q?zCXQC1zCASCGeehLZvkMhdTwGFe5sf3d0/5A/93ezZriIe5zZOC/uCKf6oTh?=
 =?us-ascii?Q?Kwq6RNwO6By1fcHr1c9bvHyCBSTprREGNA//0pQBPqqlt40qfEQv0QL/NSEG?=
 =?us-ascii?Q?HEgXvCufTj3JCO8YGeufFf/jGnODqUKMY+NZo9VKhYzBrs3Vxp3Ox0GOXvkh?=
 =?us-ascii?Q?cmAuhJWgLxj+eqvcHd68URPKFUqCk8EdAjVESQXrFhQ9/slQHz50uUtYVSaJ?=
 =?us-ascii?Q?RsS9zK3A6WGcVcqiFWSk+QvlYjyWTcQUCrAVO70FZvJmwDP4+/vJ4+IJHiL8?=
 =?us-ascii?Q?JxyMRyMFieZ7d3xf9ee+mzgknjWH9hwS2HzPRTRPi1GpdOHJseWwQ+CtBGNd?=
 =?us-ascii?Q?aeZvoia4b/FOourkGjSiZGi4MIFpkhPO4K8v1RC0rP6k0MK/MYxLG3wMfNk2?=
 =?us-ascii?Q?sBn8fZ31dOmnllG3tj7IXV7yii4utGk=3D?=
X-Exchange-RoutingPolicyChecked: d9OngQIU1DvQjjDp/QG1x1JyEvMJalwRHpVx7DG62M8ZZASMGgb8Eryk6pricYQcqfjRvuvO/DbqZmlGv0gRLJsAyVU44aD+AwemZPFuS+aRXVqGN/suvotIubsdBQ+J/FYQFfDULhlCu/blcIkCoS5hvuXVCrjVOce6rA142WABIGv7NaH+uwUICgWlQGD76AEnwMHd0QhM7Rr6h67duo5dHFQTa0Urt5uuPnLapSul061ZzJLcbE3L1GJEuVfkq82xUX0ycGGKnbu95Iww6Rbzg0/517OtOjHuyeC6wS10hex9J1EXCQgwq0E79m0jt+hGhWPUWawQN57vNx2byg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a2aaa02e-9b71-418b-d5e3-08df1890bdc1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:03:24.9112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tz8BScOjITpgtn4ARK11+VIQqzBKm8zO6SRbYBixfaqWqpcLX1dbPc0aBbNvOODEX4x1zbhl9NujAlXRvWt0MeuajO/gs2bTEfYsI1lWHEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB021866
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

On Tue, Sep 22, 2026 at 11:40:25AM +0200, David Marchand wrote:
> Let's check if a testpmd and unit tests from a reference build can run
> with the current release libraries/drivers.
> 
> This gives another level of ABI checking, like catching regressions on
> experimental or internal ABI symbols that get promoted to stable without
> providing an alias for existing users.
> 
> Automatically skip unit tests that did not exist in the reference build.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
