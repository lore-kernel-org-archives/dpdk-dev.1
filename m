Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A66C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 11:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 158F440267;
	Thu,  3 Jul 2025 13:46:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id CD37D40264;
 Thu,  3 Jul 2025 13:46:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751543201; x=1783079201;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DTm4zvPp1LPY3wKjBa9yk6QILZ5TUatePJY4s1xZGmI=;
 b=COwqb8lCkkaT9R3r+q+EIN+UlVZySdnpk/tYKn29Valj0XUmnN+uqtf5
 PL9/CsYWbkCJ8uaFblEj+Kf/uCzf1O3NwuuRVyXfA6KfJKj7CyeXs4vb3
 9Q6m9Tp9PUN2qVSemr6bALWO98Y4h85hlfOltq8FPK9Y8JjiN2nT8/ihK
 nKFflmWoZqgN0Xv0aTiw8aIzhGhNEt/OSeBy8OWZx7z6atB4Q9sxJodtC
 0XPOqWv3LmzGiUGsayHJt2yXrp2JlpmO2xD7nlQRX62TPes8vOqqiXewf
 qqNCpdDgA8K1tkQtRvYXRLd4HzGtooSlnxLle4M/v/ef5+hdJpEgYMRMc Q==;
X-CSE-ConnectionGUID: ynoSTjCISB6H+/wNh9zq1g==
X-CSE-MsgGUID: nNwjQxSWQkCWcALD3wbCfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="52988118"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="52988118"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 04:46:40 -0700
X-CSE-ConnectionGUID: tAj9LdWBT3W4h68T9NG72Q==
X-CSE-MsgGUID: woKTLUOvSS2kdrjxAlQERA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; d="scan'208";a="154116066"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 04:46:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 04:46:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 04:46:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 04:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCRFQRFyre2t9in4h5D+5FLIc5ibQQBTScJl/s73aGhqb0uvlDOSr8QlAkDGd4lKw7GSeztHbRTMbkVU2UfeRNzU21AzBVZX28CWLhjgN7cIFGkE4evdr2l8MmLlxJHJrY2c8h9wMFgVpXaqGUa/9+QEdcT3iAerBiBuNDVXoBjlFIaf1sNSrZYPfeu1PC0vsc1y00DX3otXo2kuir08ZI3S/+rPR4wvTeek2SZVHqoZft81/ItfM4QKOakvNSI9F9DMkQaYSwVjy9uImmlpdkxe2O3FVAdjezvPEFmdA2BrRCI/GtwHW42oEEvpR0C2UOObNSKfZnvuoM5WsMaexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6A+1hlvP311WRumMhZXwqzgts5x4dYBoTQPxBECG5k=;
 b=o94ijFnwejBCoIWKLpRzy4XEHZmXZxI33oiiU3k337lJPkHavuWNljaGF1IHy8ZyMuPEudgnERe8zMhJcKjz9ePyEaau/0mdZszCG1CzGF7rbP099wuF/oKarhJmuwC46J/EOfXKJ4x8/YoOMV3jEELEVXP9oKxo2PwFZ8EbSNIlAz0ced6qDr2eA0zXOm6XqQsdq/F4JtdwUC+sIuxojIaPEkJWCtChyydE+eqNIjqDKiRWInFTmUhnyId9odG8RkdZ67J/6UIfX0cLP+4cGtww99M+MRtuon15Nwh6bz0oSWji4q5uoZp/tzJ8LLxhwKvCWm11cxqDQEC0X0DcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV2PR11MB5974.namprd11.prod.outlook.com (2603:10b6:408:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:46:09 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 11:46:09 +0000
Date: Thu, 3 Jul 2025 12:46:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/iavf: fix VLAN strip disabling for v2 capability
Message-ID: <aGZtfAe0zBbnCWRB@bricha3-mobl1.ger.corp.intel.com>
References: <20250703084234.8037-1-amiyaranjan.mohakud@gmail.com>
 <20250703102046.10576-1-amiyaranjan.mohakud@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703102046.10576-1-amiyaranjan.mohakud@gmail.com>
X-ClientProxiedBy: DUZPR01CA0138.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV2PR11MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 129ed5c9-ee61-4e8e-efaf-08ddba2733b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AGA/uWXqYcMrQX2Z/4B5crwgR5f5NgIhTXmhCuX9YzWFZlNtam3YJdCGexvk?=
 =?us-ascii?Q?eP465pfwIoQbKYuCR/4NM04EO26SA312BIWQPjZgc2C3SymkK9k4+7egliHY?=
 =?us-ascii?Q?Ke2KDWm74vglXCePcGCJ7QTJce1RdKidZ4CcooAiza9kitPjd7YM3fzNEJx8?=
 =?us-ascii?Q?MQRm6DPEYoIRPczCQ8hEdKgk0bkeaSISn0Vyoam3cMXHEPFtUN4cYTFbFbt0?=
 =?us-ascii?Q?WdE4ov94sqfEfaJrTHuraw4v1QJgtHb4v+RksTERQZMQe9kA0kpPlOHHKusJ?=
 =?us-ascii?Q?5a06hr+8fRd8l6A/XCOJudxgECbRzRQfFpPuem1OmNIW6sc4kH95D4T7Trgr?=
 =?us-ascii?Q?5lsT803CTx92glMqnY+zIOjZzmDe/euymYchFztCHaDwiqXkDIU4XDZ6fy2X?=
 =?us-ascii?Q?2EUZ9H1DTjSNCncPFlWiX6lcL9Nepi7bFOE1bQ5YPA8EDOmvyqAYK8toi9AR?=
 =?us-ascii?Q?EIjEVbfEh9gpuNfwjsIzlEmgFe9oyRpGCdpJl7sjBCobziFIbw3rj3EHZmiA?=
 =?us-ascii?Q?GxMRD0U/1GULYWGfucDqsf7ZdQU5LuXitiObF2jTSYX3ZR6GBeiMYntYlSl4?=
 =?us-ascii?Q?VDCYw0JAdjosrDO0BOPMpYJZD6BVkqay/PinypOnd2WatoMRSsE1AouePsrM?=
 =?us-ascii?Q?IrvMeA/HP5tpBb0+6p7yYMZMfFefIoeeP/DJx/SEcij4MhCS9JZaRTf13uKE?=
 =?us-ascii?Q?Yrr6CJE0XdfHvxII95D5h4q3DqREZR6r0Q014UMH8i30ezCpVOmstmIdHCS6?=
 =?us-ascii?Q?AX6dFI5jz7xkkbNJWh8M82KhX7TQyuR1+SP6/XjzlR6ZMSK7S30t7WSsbiOP?=
 =?us-ascii?Q?6eygzwSd2AeowJN5XLCVAwLrtFgJkBy2grAqzKVIwuwNctgdjHMPNNZ4JOOX?=
 =?us-ascii?Q?pbTpxe2fGiIJiHv4rGXBckpoVJNvOug0PR9V468cEsKItdn7zP1dC46X+TO8?=
 =?us-ascii?Q?Fhi2SfbFk3dkH6+fAnxvnI2XsA/8xvj3WAZaLulXDLn3uNwLZxX9mlnCpH8V?=
 =?us-ascii?Q?I4IfB6b+ZB4vm5k5vkWmeShazyAgxOBlETvhaFyJOjG6lzbdydg1djnefYwH?=
 =?us-ascii?Q?C4MAhNkwN2zccleQOsTOwR8aKlZqTWkhCv/uDA8V54i8htmIzbONfQ5w92Ro?=
 =?us-ascii?Q?NV0tsnae5FNfheL9ZUtDH0drc4QMHVtjPhH7YvNuknIp52I/e1jiR9FeK0w6?=
 =?us-ascii?Q?c9/dxNL7zgRDuzcJwBHQ7qhWvTtyGQXfttPLJ6nl4HTPVeb3QD0YIpM0R9SP?=
 =?us-ascii?Q?4GiZT4rYuAOIfwa+CbE4H56Bx8FCwH1k6JGZXSvvoOSy5VT5a/xvSDQIATJT?=
 =?us-ascii?Q?ee9ytt60aFeE7o2L9VEJ3IBDD40bhUkI/R7oe6QTdPy0OSN24jYR+BClF8HZ?=
 =?us-ascii?Q?6GyxWKbh0YOqaQkA6VOGdmWO5mt2TB5gzkNqgxz3n5RPLregAIxNx9/25VEi?=
 =?us-ascii?Q?fAQeixPi57c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?naewQi55K30NzWgXcR0WKQVI019OoGfMDAy3Y+YkOWVHzTFL1DUItkl5qiCD?=
 =?us-ascii?Q?de9IY7OlL0nG/eycYfVZMpD8+U/ojeC0Oq85Va0u9VjH/VhLq+9rQSmd1i/2?=
 =?us-ascii?Q?zJ2oPOr/G+Po/oDu8odOx7fS94V54US7KKU2gB9SC5LjYiKM5OvO9du0OwnC?=
 =?us-ascii?Q?ywZCRxCIfS7N0LLEyus3NKL4p5vnqTG0ZmSHaFmpeMDBcL2iJNOIFrFKzQ6X?=
 =?us-ascii?Q?2dA9zLUtYD+iJtVL/fN40ChdNFpZAq8Z8sq/gJvkg9SnBbggfVJG6VTOYb1G?=
 =?us-ascii?Q?ZP5RbJA6NabFAFhg90B6dzop9UlpETrKxEThPl0GVj9nKy5TnwqMonSHHkDs?=
 =?us-ascii?Q?rtAmjs3zDJdr7SQlfcWPzsd9yPPsH3ni63KefSY+n9iwLEnF2pAFzflSsVdV?=
 =?us-ascii?Q?dgIpcfrZSI5uaxrC6mkf7JcRvYtcGeW3B79lgDpSAi12Yr7Tl0mZRdv1zUuf?=
 =?us-ascii?Q?ripRl/iGQ5fVmeqcbZldSyyyL5EEiuBlqYfWRfu+AwhFJ5rIJZjthHaV0Uaj?=
 =?us-ascii?Q?GZ1EtEIWvtcsIWM5GmCFUzzEjNvEPM6JZpGS8HkSOOj3t2+8dC+fv3ujSxbx?=
 =?us-ascii?Q?37rPRKqX4x4MstGj5Tup8hvewy5NzTKQcm3bhO6yP0UMj4IikdX0ydB6Ldth?=
 =?us-ascii?Q?JcPwhg6Z2tjUZQpFc+7mkUQcA7MfXlhZIpVIaY0TTLfm76y300roytvgHXtA?=
 =?us-ascii?Q?h+RE0m0W7c2VJmQljk3v4emGSp4z2lpvygKUt90ARnsl792C9QdT/o0Nj70A?=
 =?us-ascii?Q?CUs13nFwQE1+lST33qY7BVFsGl0o+TyKzvn/PE7S1vXtgvJ17NwURsBeC3en?=
 =?us-ascii?Q?/zxLYq3c44w2y0VGuQOwJKvL0LuRJESovg3cdB7ecBVBeA1aYrcFVdWctF1i?=
 =?us-ascii?Q?e0pbyVX8pykFTDfjcAVEjEyzHhjhhijNaangZ4YTgXe8v3WLQmw1uNqFFiDh?=
 =?us-ascii?Q?DCgkeq7b+vjTzqSHiZ37m8KgTUX1nUHvp/p6WC47PnbxT2BQHs31lpobPYCV?=
 =?us-ascii?Q?ONqTN8SzNCFBm7celQy49hn9s69iM2QnARfsRnxpXZ99dSTlaNCiQtD/D18s?=
 =?us-ascii?Q?K2vLl9vHRz4IO+rup7QSZ1yMGrkO23chqcdOF1isRxZkdPibmaVFXLXkVa4/?=
 =?us-ascii?Q?m6L4AvdZVJ8aE01kX1megq2NHZ73T+c5s1vOwL0MdHdaEtubzNjoKxjHr4OK?=
 =?us-ascii?Q?QpeGJYcTphJJp4klNK8utPGn9kgvdRJhcMVCgEQut1ei4CLVXVJgGTr8kjZr?=
 =?us-ascii?Q?Q9BUUTzW0dNt/qrZPrmOk8jiLMDaRKumWKyGypYFw4hXb2iYMyvd8ubxd2jZ?=
 =?us-ascii?Q?7xSkocogutXHRzJxdGisyvCJjdUbLSXz0TgocReKDkIm4R7GBQgbg2pySro6?=
 =?us-ascii?Q?aXeFa9TeNuk9SZoY4304jWSRIuhVR/EFvvFgu08+uT5vifjQkhmnLnfLLSXO?=
 =?us-ascii?Q?iSwHcFWI4zLs01h+whKy3iHn+XFGNDAjFeYHtQ7p5vX/RiNmJCEN/LcdPIGM?=
 =?us-ascii?Q?Iq7DIUQNh2lXDJiVdKIvkw3Ek9fmCAKpmYlH29Tl0brBQTQMiKTAVGVjE8gb?=
 =?us-ascii?Q?TSdq4GVPUq+IZ+WndkxGMo/9ZvoVWAtLn3ljZp7LcYUzuJpd0D0m9qbMS/Dp?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 129ed5c9-ee61-4e8e-efaf-08ddba2733b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:46:09.2480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqFuVMpynb+KvwvCFEgHvIuWPQolRSzjQRx2RwppF65pcy6OZrDpVednHgsNCHrmoN0m2uLQS5Ev2choCSUTo4VA09XxxjXyhgz7IA8LtY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5974
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

On Thu, Jul 03, 2025 at 03:50:46PM +0530, Amiya Ranjan Mohakud wrote:
> Ensure the correct virtchnl op is called for disabling vlan stripping by
> checking if the device supports either v1 or v2 vlan capability and
> choosing the op accordingly.
> 
> Bugzilla ID:1735
> Cc: stable@dpdk.org
> Fixes: 3bfad066f9b4 ("net/iavf: fix VLAN strip setting after enabling filter")
> 
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Keeping Ciara's ack from v1, since only commit log wrapping has changed.

Applied to dpdk-next-net-intel

Thanks,
/Bruce

