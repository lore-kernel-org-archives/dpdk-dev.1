Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58498C88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:09:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D5840B91;
	Tue, 15 Sep 2026 17:09:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7227440A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789484987; x=1821020987;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=00D5mDtZzKLGeHYBI/WsFhYzmCf8mxix5LRrQhyvpbA=;
 b=RglT0Kkf5cGoSOeydWknc0dCWBv4Pk97xOGLebjjTMciFIKQsChxA40V
 xuvWRsswo7fXu6I7VLZ0dKW7rABO5SpTYAd0YLBvqBft4S4tj19F2Pwik
 7yU+tmmpdWXEkvUy7EsTxNfTteSWQPhffm/K95Cmj7uH9fu8uVwf+oZQM
 xLwmDTDlEWk0vr3tcI+JcnPqI4xGVVPCS67nuNq2+49GHW8wJAOtIEMH8
 A/qvnjjbYV5RSk3tpMmRc3smRiaAwbxR/fH7FIJbWTfXNdrTCU/c+qgLu
 8IaeOxb8jRrqyPGqQ507wze/H9O8KQ/pZmZIdv4AyVfQUVT5roNrUu1yh g==;
X-CSE-ConnectionGUID: 7cewfwu+RE+4E9FiZEjMqw==
X-CSE-MsgGUID: QzTJ1ba1SbWoIozHRk9eNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101368849"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101368849"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 08:09:41 -0700
X-CSE-ConnectionGUID: 1UjCYXCOSWCQ8x+dH6SYIg==
X-CSE-MsgGUID: 0lQ5GJJGS9S8zNIM/PBd9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276568390"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 08:09:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 08:09:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 08:09:39 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 08:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ8VkXVT150bJJ3L5KhIYkFHlvlSKbbvGpPHGrMT+nfcrS50T+MpF5nwjBL8olbuXB7owQtcoGMuVuehP/O0Gk3arCa8x9QEKBTkmWok08pyNswNsH4374DGqZi40wfR5OEjc2maOR4HTKH7VHUeDOw7wdP0UEa++TKq4/FUriUBs8d8ZJE9H/DG9xnVGUjQ/5h+XFv7oiRRzYi6Vn7GfbO/itlGHWMfGn/b4gNJN8MhyAuWUlsoQxeZn0bl9jmfDPjW7zIDTO0u8KEr3SBc14i3UpDhf2s5G0OklyWccbTmL9ekz8rhXDkGZFJp3LMEDX8fviW9NN4UbrBN+dQrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLb9lXjorGAWUBjj4UsnQmp+t5UkuJo+lBxPoVoi1J8=;
 b=Vyg4sUTacpy2mhM2VGooc4WgsKSbeeLedWJhhOZ6dGGHPPAHZ9FPbpdkKcl4GStMia4JSYZ/kYilH6hFSoQrns/vR+UZysSx86vmp57obp2EmlGzx7EF8gpRqN4y3O6IgLeN1Z7d4AorwrHFXZw26F5G3WVeYhlVK24n6z+ynQomFpEVffhWIllEI5eGyFcQy3YzyrT+0/euQK/NJx01uqoh/fRUWY7iLYRhkSs+40ISyC4I4XaXV75nhUAKaBYdrZSEMhORvvddCjmlTDav6cuP8Rcc+i/BEuozB3s30XnNoFW7QAw/Yn3rCBChHciYzdILA2BtE/sRqg4QccP1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CO1PR11MB4786.namprd11.prod.outlook.com (2603:10b6:303:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:09:35 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 15:09:35 +0000
Date: Tue, 15 Sep 2026 16:09:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Randy L Tice <rtice@cisco.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 <david.marchand@redhat.com>, <stephen@networkplumber.org>
Subject: Re: [PATCH v2 0/1] eal: add CPU socket lookup API
Message-ID: <aqlfqtifyZlqfq9e@bricha3-mobl1.ger.corp.intel.com>
References: <178941409436.3.12421464753538796039@cisco.com>
 <20260915150507.3-1-rtice@cisco.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260915150507.3-1-rtice@cisco.com>
X-ClientProxiedBy: DUZPR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CO1PR11MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: a8acbcdf-a5cd-438f-5245-08df133b5abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jEU/UDgHqIIQR/porqRaaFHf1klKs2nAklU1JrLudkQ/W+P95VBWkhJ+8ofGp5B9KmTLGxEGHxXxSvSpm1qiKCtptGQsBa7Vs83CAuSqPAUcEz2IjyTgEVbaO1owZ6qdU+wY+BxRgHOxMsiMrq3dcEhaurO9ga4gsCWJpg+Enn0tez9gjK3nDxD3rPPwuj9GHx3h98pOrDh48RwaTiAnK8j6XUlXIflRQa9eVjtI/BtArEmnxxG6YQt/clb4i1ogrX1PJwvEPe2yx0JxiOrHxMZgRK2BVwVwfR5WMZjyHw8tVvtpdO32QFMsjIV9YO84LjLXsGTcnpVfYSFrCgDW+skQFcoBM9tZLKXgAcOXvRNdKIOG7g/ejHHAJEgLqv1VAPLp4pi6spz4SOxB9vjTTtYOJN1yFnmSMQYLRSuRCOnozFtH0zbosOO73M4vp50qFKBQ/sIHkrkC+5QcJiZaIgDrgN6qat7NCyChET1NsE/tbmTaRY3Q2WAWPGHVjaNxEd3MpjjcCPYfTkN4IV5qEiyXU+emnhPKnlVmxz484pYjuM9qCFUarylN/gtZkdP30P+ethpF/dAOgiuGJaUtdQvXqZXvKvFOSqft6l4UliQ4iSDF8vA96ePPEF5a+dl3Y2SENCS8t/KX074VcUYyP8q/dssm4IrHqkq0ymuDKog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kd14F1Boy49v5Dl9qWttqDZiBjNDlubJmfYY0sCBEc32s5GgcbtHt4d62/d0?=
 =?us-ascii?Q?H7OiSDsw9gSN5M0VFMrQzXG+/9LMn7x/X4OjSNqtbi0Flwp0PhAPW2ZtqJKJ?=
 =?us-ascii?Q?c7g6HJ9aiPxItdsSb8T02fNCbYwcfRw0g6NLq4dpLb3Lm6ywuWhpyB6mA/ak?=
 =?us-ascii?Q?5cCuK9IyOpF7oEuvCGqJwb/ISjihRfqNgBli/nKTpIzr1biQQHvtxOO6j7JF?=
 =?us-ascii?Q?wAUkXfILp4xyxd1zEn6NV0UX3NtF9xDLC//HAiqKIOAK2qiBGNQpuRQS/B2C?=
 =?us-ascii?Q?5O4vHu0ZPhdtQJ5yncv5iYTSSy+XhVHZy1aFJkzsQNiPnkhbpRpJNQ3bdast?=
 =?us-ascii?Q?SlyN88NcQjG2IfZXigxt0KCpUPj40gtWzDj1YK/7h2tSN4Kjdz3fVFLs+7+p?=
 =?us-ascii?Q?w3bJu3d7fspl4EMUc2EMkwdvIBFBqOgTtyE8qBWSIr+SOXZ2iB0W4bMWw8N9?=
 =?us-ascii?Q?Q1v5Bnfnt0T9Qz7lPYimjgbyYVi4mBAQiiN1fALJRCJya+GJJCNODLalajON?=
 =?us-ascii?Q?IGtTZ66Xey2sSWG4MZnQMjg1F0eNSrx7HSH6XWsWn4xLQdUbMkj4e55nqHnO?=
 =?us-ascii?Q?tqDia7PjMaXqYBetQUfoUsaJj0obCbf+K5MDczuwb4exGFnGWVIndWPwXh65?=
 =?us-ascii?Q?8vCRzZhO9IylD4+q1yuBw7f3Z4ZUBLgaWTYzLMipP1mlTUqPidfQBrlAB4eh?=
 =?us-ascii?Q?D1gNm0dCseJH7af6GA02mPAdpMRxyuw827WPLH1EtBe7lnSLa9g7ZfGKhpzw?=
 =?us-ascii?Q?dmeoQ+6iaLJXZq9lwUc2Zg2goHAF6ndy7auZw06krgPc1KEfe1J91wG75h9o?=
 =?us-ascii?Q?55oC0P7my6UCh5cGHDAt76gPM7flrHbV5jo8bAyMUUP0+VnWYM24CBjUMkfh?=
 =?us-ascii?Q?EguIrNuRVf9lSiJONxi+S4lqR/BtPKXjG/RHs3Kf6cnqFgdXVQvbVErkpSJn?=
 =?us-ascii?Q?5jDftNl4AfE6/0c2hK7tHdN/3zABKvzTDiMzWjfUSVYgfxyNzHoksbu4R9Bm?=
 =?us-ascii?Q?DFdy+sjc9pPv5wLmUDC222CN/QxkuExbzPAoEC+13Wr4FTWdnScuDO+pkefh?=
 =?us-ascii?Q?3n7rBLfRK4AgQvktV53ZrYtwY52+y0yGVwwQcFmwf9rFtZ7Ti3aGtzxxEPqv?=
 =?us-ascii?Q?NJXPpTp6vSyYlCm377gR/CZgI6MHT0eY/NxExt+zpy613kZb4XhniL1s8AxP?=
 =?us-ascii?Q?Glj2s0YZvVX9tDv4AexNJxK7RKiD9dy5buDxW/wq6o5OabuQymyHGOb7wlS3?=
 =?us-ascii?Q?FqK0dtRd9zgIMbFN3UM5ygfPoI0aIMXSeht3m+CeFtvB4ba+5E/f8peNOT2p?=
 =?us-ascii?Q?ibYZruidWMXMn4C68vfz+VuT9zth33vcbmPcVC4Z+QSbtFHT3QOc92033x2u?=
 =?us-ascii?Q?nRjiSoJjJyp3URM60wHklxy5G0hlxXCjjcR2uCxerbUbEqO3koG9f3U/xruU?=
 =?us-ascii?Q?VME+XZ4aExzmOjv43moEbaxI23Nw2rFBtwEsL07XSHgtzfqNDh7A+TFgLu55?=
 =?us-ascii?Q?FlpNFhkzztkAKp2Y4DI3O5d/Sk7F0AmqI+QML4UeoHoXNRtPp3gJ9c2gdYvI?=
 =?us-ascii?Q?x19AkMVZjk+wgvEwHI/Nu1MJDtz8M23NkjNglb8g72+UZNGWU58CQRtZJtdi?=
 =?us-ascii?Q?Dklas+eoy9UWqpT7Y6DQWEPGhmjocIRtzGiJ6JktmkNCM+nSuBgcz+9woHjR?=
 =?us-ascii?Q?Xy/imzy9YVVMg+PnXA4e2kt0fDtFtFiSLa8pDkFqoJnqKHoMuRJ39+l1gssb?=
 =?us-ascii?Q?mpQ+ALWNR+HM1CX/+sH537UHQ7ZNeCY=3D?=
X-Exchange-RoutingPolicyChecked: 3fg2XkKVSEXrPtMHPpcjGqsd0pAe08SHkdKVtHEdRFI9/Dw7DWJwWJwGVVNdqibQZMsQu3d28nxHNFSo4wL/Od0r9slcdcbqfWHk9+9nvcGKk52aFJWObLFqhXZ8ythiu/wXEyKsTKMS9ftC4AaPrAD/GFh1lhxS1Mf1zvJclJ2ckQYhXaavJaEdUXOanmvXgjfGPcPKlNIGDtqAIwjMxeNOdIquNtvLs5HKTK2KWUEwKu008DrZ4n5M8YWCmGKYECBXL7xbQuTxwwpJ6zmsjuDhbursjz6Oy/mEgXHik+NeD/Uc5C+/ywh+vtlI8/rjyrlSTQ6wvZSVIdNNTD24BA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8acbcdf-a5cd-438f-5245-08df133b5abb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:09:35.8110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoB5lgx0jUu6RuQsq9D3DYkmraZoHmBAMOJvUI3rQrm53G6mRJPkSBCbdix+5Zvdj1M/x5w38+hp2jgBc/ey3RgMzBvUUqgoHpghdP3TCng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4786
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

On Tue, Sep 15, 2026 at 11:05:06AM -0400, Randy L Tice wrote:
> Some applications need to derive socket-specific EAL configuration
> from OS CPU IDs before EAL lcore IDs are useful. One example is
> building socket memory policy from the CPUs available to the process.
> 
> Existing public socket APIs do not cover this directly. rte_socket_id()
> reports the calling thread socket, while rte_lcore_to_socket_id()
> requires an EAL lcore ID and uses EAL lcore configuration.
> 
> Add experimental rte_cpu_socket_id() as a public API for mapping an OS
> logical CPU ID to the NUMA socket containing that CPU. The
> implementation reuses the existing per-OS EAL lookup internally, while
> keeping the eal_cpu_socket_id() helper private to EAL.
> 
> v2:
> - Mark rte_cpu_socket_id() experimental in the declaration, export
>   macro, release note and commit message.
> 
> Randy L Tice (1):
>   eal: add API to get CPU socket ID
> 
>  .mailmap                               |  1 +
>  doc/guides/rel_notes/release_26_11.rst |  3 +++
>  lib/eal/common/eal_common_lcore.c      |  7 +++++++
>  lib/eal/include/rte_lcore.h            | 18 ++++++++++++++++++
>  4 files changed, 29 insertions(+)
> 
I think this support is a good idea.

JFYI, something similar should be possible (or else easily added, I hope)
if patchset [1] ever makes it into DPDK. One of the goals of that patchset
is to have hardware information querying possible before initialization of
EAL. This ties in with the overall goal of alternative init paths for DPDK,
as having hardware querying available allows sanity checking of args as
they are added, rather than just as EAL init time.

/Bruce

[1] https://patches.dpdk.org/project/dpdk/list/?series=39005
