Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E235BCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 18:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14724027B;
	Tue,  6 Oct 2026 20:22:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9B08D40151;
 Tue,  6 Oct 2026 20:22:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791310947; x=1822846947;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=SLbXJxc5iv+kwuPvnBIDrWVz2OtpggXv0CNwAm3oDpQ=;
 b=YIkmfKGJ9SYn0vOuaSzkT9OwivmJp0pYh8XaL4VhTC7TtnLqvBDQmUzv
 u7aU34h8ZQwKob3tIK9EtPKUXAt5sehU/KfDUtPXcWSEeIYbHmDk5kBif
 6lmyeUsRDI0QzNNBP3OOTF/9Jy2nSu58YH9zcgb3kcFzozCV5QYLfyZo0
 OKI7W9CTy4hKIJQ6AAPHjhHXmQZ93UdSIrQO3LnRjGqD/D+qQTjnjmFLB
 08K4U/6i/9oFegrZENcVFm9IqoyqSJ4Viyri0LNqPhKr6J9sAA69dyqbk
 w3cqM8ubOZYhXZ/AYtbaJwJU/ffT+K93z1dtec9J61sn3QP7zQe5DYSYB Q==;
X-CSE-ConnectionGUID: 38Sh+QLtS7WoPJBFedGP1w==
X-CSE-MsgGUID: MthRqY3gQFOs1tHRzKvDew==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="95829006"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="95829006"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 11:22:25 -0700
X-CSE-ConnectionGUID: Xx5tK799SSG0Z8Hqc3wxRA==
X-CSE-MsgGUID: Jxb2P3cPT7Wq2P4IG6EezA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285145052"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 11:22:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 11:22:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 11:22:25 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 11:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKujpdE4FXTw7ZWZcDu13htzhgujuKxX4WUqW4ZuRHSaV/sANoNnd6tD5D1NvbP9ZdshXHuyMyQzNvMbb3bKPSTE9crF1VBYXhYUL0u0skvP8wz71R+cKSfV4K1r4ukc13fXU8ghi9SpBVbd2KSy31HhO+JUwzddqwwYPQfiyS61mxrTnaMUieNjLgQSS0h06rvYPJ5OvEyh3l0XPQ3v3z7zZ5fSb8BZUM7UoQA/WdOrt8Xv002cmeoPNtGnjK9aLEsYq/RaaxkSMbdf5Ci7cU5+0Wl6civ1wU1c3O9ZnnF/U8VFawVOwzgIXwZpWiTz7r7NVccyQ0P/RU6F6q54SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF2ptQWly+e0s848iMPTRwnHNGm85SYa+DHHYETAHZo=;
 b=JxyFAHmJcwtahyktrI4UGe7EOb0ic2psSDNVGgMf3cwRX3BxcYjcNTkZRXJPPTub5B4TNXWaCy+xgqI7Oi4iNYRIffhjYp1dkJ12oB3qXyb0vIsxIkB4/EJRihQqPoy6v+Jw6QKfTr9p3Qa+/mMXN+1YmpZtw+eFiW6o1NVibYSMQ030yPmxxqSmKKcOBepaN8+VhiQ3UAa0Mf2PuWBaQNupwMBUcgQwTGGnGtk0LTSPJg5IryXYXE3jGOvkUZrAYAYrbBYiSDyPvNz+rC0aF4UYdLJXe8x6LaKtmLA5CheWIIjcNPQ4VL1tJGbd//znlQbYB8rA6QWv7v1vd4l+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Tue, 6 Oct 2026 18:22:21 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Tue, 6 Oct 2026
 18:22:21 +0000
Date: Tue, 6 Oct 2026 19:22:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/idpf: fix Tx payload corruption in split queue
Message-ID: <asU8V6Fbk9ar5YBl@bricha3-mobl1.ger.corp.intel.com>
References: <20260930044630.250936-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930044630.250936-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0335.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 2014fc83-b695-42a0-6393-08df23d6c2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|5023799004|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nmfVSuuUPVj29xr81dIjvJFuimqGhD7w6ElQnGeAmdk8/MJhS/qExF2O4wNKpYv0i4JQgwoOGCAlQ3xVqNxPEloYr2L91IJNTW7WgYbUrZfh+MDLZnLlkXG/1nn4i8uLD5uRQM+ezpT1ESD/5cSohYH8aTAEFdHR+hyAk1mtNWEwoQFbrB5w3L/PpIo4bkzh81gHuBJs+9eB28avAYG6oPdZjmmzkzEEZ56jTHW/72vmZqxJmzinQHAFeFrfXYhTyjq2jGQHdJzYzFKKzosOqGcJgGfLTf0dsFcXru/+5VWJpnIhdwef8J+dFByH6bcOZ2ze3JHk/4EFFPVSEYx9+h/sCW1vpL6mqWWNCBG8wh13uf79Ot6Nkmpy7dOc1zSV9h6Nlk9lSpCcFAwhX93cB2DfURNJjalpr3xlmgPpyZFZeLARhhB5b0OvUagkwQeCBf1j6+xFCP3cbtT9MwmTxUx2IQ74/Kre3QAlxza8DVyXRo2XH9KdW/om5L66CjbxBMOnAf9/bn+bIj9irQOlW/ftPZItdBmpfjYBMPKoakx8Fe+gIRxpPwSs/LCgd+QiiaGcW2OjtWuYN282QE0vHxA5IAJqQ3wFEnxL6ZTS457MFlUzphn80h2xUliMdx6ZxexsdfR5IzB8uNla6xuqfeXTvFg4xWF6P6ZZlzljXhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZYdjcxcCs2U2xRdWhPN3gzTUY4c1B3dFgvWTJQVnp5ZFpNUmIrM1oxMEZD?=
 =?utf-8?B?allYTnVlUkxXdkZ0RVJPdjI3UC9oSmQxSDFUQ3Q1TDYwOHY0TE9FZUYwcStT?=
 =?utf-8?B?KzFEWDlBUTJXL1RGN0JTeVFGSHZGOGJSRHJDNnc5TWdDWDdvSjRQQnJ4UHEx?=
 =?utf-8?B?OVR6R1Y4RUFGakVhd2gxZzVSZ0w0K05SdmthVlFPVHc2NEdiUkJ3VkNEQ3dP?=
 =?utf-8?B?WnNhKzdaYmtkQWlpVlRjMEwvYmdnbXJyQkNFVC9UTzdLR3hYV0srcmNZUnh6?=
 =?utf-8?B?aFNKYWNUTjRBR0M3bEIrQWQyTHFDNkdYbVF1ak1DRFdNWXNQMnJkSE1VUm5H?=
 =?utf-8?B?ZHlWaDJCWElyRjl3S3RxZmF2Mml1eHlQYmtiTFpuN0ttVGNFVHoyNXJrSzdC?=
 =?utf-8?B?OXVHVEtvSHdrZm9pc28ySVdhK0RMYkc1QTg5OWVxNy80Mkp0ZmYrdDVOMGp3?=
 =?utf-8?B?RGRyZkdOTHcvR2FQWmQ1aHJQR0tqcElwNlJYcDNlNnlJVjFpbGpsZXZCa25H?=
 =?utf-8?B?Vi9XdndMK1pubEdmK3ZnNngzcGp2dU5wL3BEZVJKY1pxWDBTVzRTQzFyR1Yx?=
 =?utf-8?B?TTVDLzljSitOVFdBYzNxRHpkNTFFU1RVbFZqSzNDNUVMd01wWWR0Nzl1WHBu?=
 =?utf-8?B?WFN3SjhqdGdpRUMvS1R3V1F5aUowUkRLV3JYN3FPbFJIMWVFc0IwR0Y2Q0w1?=
 =?utf-8?B?TngrNFlpemR0R0tsV3lkSnBLeGw5SFZmUXNvTFM5VlhPcE4zUFRyaStpWlhR?=
 =?utf-8?B?SGJ3cFVtdkgvd1l6UjUzbEt6dmVHeHF2WlhtNE84RmVYYTRlbTFCbFE3bzhZ?=
 =?utf-8?B?OVBPRWcyODZzS2k1UkFJbDlYb2svMGVNOVFSdGg5cjArV3BweGxvaHArZkhw?=
 =?utf-8?B?NFFFamlCSXNtN3lRUUR5ajRnSDJqMHJ1Qm1teUoxdy9TemFMODREVURlM2E0?=
 =?utf-8?B?YVk0b0JjODVQQnFVZ1hWM1ZZQzg3Q21VSXBCRXkxaXN0UmNXcXpmVnZ4blZJ?=
 =?utf-8?B?MWRuUEtROVlOZnB4VVY0clhIaW9SeUg3OXYxS0N0OC9IWFlmalMwTTc5Y2hD?=
 =?utf-8?B?SjZRTXphL0tMN21VdzhUQTN4K0tnMjFHKzN6VERkeThHQTYzalR5NjBGOVUv?=
 =?utf-8?B?SFp4UEZRa0ltV1FQTWgrTENlS0F1MDFLcjJnK2dEVkNvZFkzb0RuelV4TkJa?=
 =?utf-8?B?WG5ldnpjcHFMcGZrdGJ5S0wzMkdyNWZOcUhYSkp4YnJMMnQrWHc4YlJ3WHc5?=
 =?utf-8?B?UjdKRVJHZzF4a3c1b0xYYlpSdFlmMmYrVEl5QWZ4VEw2Yk5uYyt3NHQ2WlhY?=
 =?utf-8?B?Y3VKQWVKUXJtVjl0eW5qdDh1T0cxc3pzMEpRNmxyaWtFRzczRFFib1FwS3Fk?=
 =?utf-8?B?aU84OWloSlZuRWFleGhaT09WRmJXaVpnRElBOUJ4emI1U1ZzZ1hWbDZTZmxY?=
 =?utf-8?B?R0dnamw1MGpjY2ZWbkl0VlF1OU1yNW9rQTA4Qkp4eGNDdVhKUVN6WUNhUVU0?=
 =?utf-8?B?Zkh4eDd5aTJLcUVEVVdNQ2tHcDZmNnd0Z3F0TzdrUEVXeFdCcjBFdXU4elNj?=
 =?utf-8?B?cnFranhTbmRTTVN2eGNmRk05amdjSVo2WmFaUXZCZVVuQ2N4WGsyUk1uWjVV?=
 =?utf-8?B?eE82MWxaVzdtb3p4SWpvWVU4djdCaVBabkRIdS81OENzWU5EQ3gwWkVDekFK?=
 =?utf-8?B?MU1RSURwME1uK2lWa2JFWHdjOGNaMjBiSXVESy9EZEJlMmFHeDVOTExXV1di?=
 =?utf-8?B?bUFSZnZYQlJUMXdKT3pRV3BIT2MvTm9sU3Q1WjI2ZVhnUUpSZ01JZ3BFYWlB?=
 =?utf-8?B?K2JjWFQyWlYvQkZOZVowMHNVaGE1UXBZRDFncFpyYW5YdkgyM3RlNGZVN1lM?=
 =?utf-8?B?TFpNeEJYWlE0V1hHdnI5YXhTeTNsOFN4RWVUR2ErVmY0ZFhSZmNLeTltWjVX?=
 =?utf-8?B?Qm5xdWVlaUpTMUJUYlRHZUMrUUlVaFFmMnFPekdaZW0wRHcyR1Fua0FRZFln?=
 =?utf-8?B?Z0VpamtaTERvaDNQbzNJMGlWMzgzRkVsaW1IbkpnejliZjdDK3NhUzl1bGlC?=
 =?utf-8?B?ZmZONDY2QU1lNkFHeUxpUjBXR3NxVzFNUzM0dXBpeDV0VzZvemtkTEh0Q1Q4?=
 =?utf-8?B?QVJrMG1wUWJ2NS9QUng4elFWZHpTOFhJN2pKcDNDSVErMkRXZE1Pdk91R0Rs?=
 =?utf-8?B?U2dNQm1KWWF2M0c5d2JZcVBYbllzUzBQU09acTdtL3pQeWtBNkhTTFdmSDJo?=
 =?utf-8?B?aEd6RFRGMGJaL0tWSWVRK1hkMW1qYTNncURmNnkrSVZPWGE5VFVIeU00TlUv?=
 =?utf-8?B?UDNjeStMM3Q1QlZtUXY4UXp1K056NHdzTk9JVkhDaTdqa2ZTY2MyVURLekpm?=
 =?utf-8?Q?izAkKWKYw4qWxSUc=3D?=
X-Exchange-RoutingPolicyChecked: xFe5tdLuC4STkS/WamWA6KzmzTnJAMckzFw9EvbFayzXciKVVezA7TUfa1R7qXGsP9vPWFzRh4AkQEPsZ/oOE56zVZ8dlZLyRebpZnyQoDtA/aYNQqp9w7EdX7Vn8NncBSN5uMvnNQYcxloJAw/1iBjZ4FzGcpRo5JFxYzhjpKicFasThUpKeuNDo/0xZCkCht1ar4SFu8KtcVOITPd0YhsN1pHIHqq68oIMrzuZYfb5eDl0TeDthe5T8Mj0yIPx2JnY470ACj10NK2+zg4+Nnrjxg3UKhNkZFFtnUZX57DjZL/23fni9ONL3wyy3iBDBCUK3LASRYJhqRZIS118mw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2014fc83-b695-42a0-6393-08df23d6c2fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 18:22:21.4434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jvq+GbJUssc6NcNbIcC7OpIAmcQIJLaSD4ETlxGG4xKB13KrWctleppA0zQzrOlKJxmjnBJp88MV7sMd+jRi5k6K2iY99O9WOk6pgYCkocU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
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

On Wed, Sep 30, 2026 at 10:16:30AM +0530, Shaiq Wani wrote:
> Observed on ACC while running NVMe traffic tests: under sustained
> high-throughput split-queue Tx, payload bytes on the wire did not
> match what the application submitted, while headers and checksums
> looked valid.
> 
> The RS-completion path was freeing mbufs by walking sw_ring[] slots
> between first_id and the EOP sw_id. sw_ring[] slots get reclaimed
> by RE and reused by subsequent submits well before RS lands, so the
> walker was freeing mbufs still in flight for later packets, whose
> buffers then got recycled and overwritten mid-DMA.
> 
> Fix by tracking completion ownership in a shadow ring indexed by a
> software-defined compl_tag stamped on the EOP descriptor and echoed
> back by HW on RS. sw_ring[].mbuf and .first_id are no longer touched
> on the Tx completion path.
> 
> Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/common/tx.h             |  7 +++
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 72 +++++++++++++++--------
>  2 files changed, 55 insertions(+), 24 deletions(-)
> 
The AI review linked from patchwork [1] flags some issues with this that
are worth considering.

[1] https://mails.dpdk.org/archives/test-report/2026-September/1052807.html

Running an AI review locally with Claude also reports issues, and some of
them seem quite serious. Can you review this feedback any fix any issues
that are flagged, and let us know if any reports are false positives.

/Bruce

---
Review: net/idpf: fix Tx payload corruption in split queue

The stated fix (shadow ring keyed by compl_tag instead of walking sw_ring[]
by first_id) is a sound idea, but the patch leaves sw_ring[].mbuf populated
during transmit while no longer clearing it on completion. That creates a
serious regression.

Error: double-free / use-after-free of Tx mbufs at queue stop/release (high
confidence) idpf_dp_splitq_xmit_pkts() still writes txe->mbuf = tx_pkt; for
every descriptor (idpf_common_rxtx.c:1048), exactly as before the patch.
But the new IDPF_TXD_COMPLT_RS handler in idpf_split_tx_free() only frees
via txq->tx_pending_pkts[tag] and never touches sw_ring[]/clears txe->mbuf
anymore (idpf_common_rxtx.c:855-863) — previously this path did txe->mbuf =
NULL; after freeing each segment.

Consequently, once a packet's RS completion has been processed normally
during Tx (freeing the mbuf chain through tx_pending_pkts), sw_ring[]
retains a now-dangling pointer to the freed mbuf(s) with no code left to
clear it. On the next queue stop/release:

idpf_tx_queue_stop() (both idpf_rxtx.c:736 and cpfl_rxtx.c:1368) calls
ci_txq_release_all_mbufs(txq, false) before idpf_qc_split_tx_descq_reset().
That function walks sw_ring[last_desc_cleaned+1 .. tx_tail) and calls
rte_pktmbuf_free_seg() on every non-NULL mbuf, i.e. on mbufs that have
already been freed via tx_pending_pkts — a use-after-free/double-free on
already-recycled mempool objects.  idpf_qc_tx_queue_release() is worse: it
frees every live entry in tx_pending_pkts[] (idpf_common_rxtx.c:407-416)
and then immediately calls ci_txq_release_all_mbufs(), which frees the very
same still-in-flight (not-yet-RS-completed) mbufs again via their sw_ring[]
entries — an unconditional double-free for any packet in flight at
port-close/queue-release time.  This reintroduces memory corruption via a
different path than the one the commit set out to fix, and is now
deterministically triggered by a normal stop/close after any traffic,
rather than only under the original race.

Suggested fix: pick one owner for Tx-mbuf lifetime. Either stop writing
txe->mbuf in the split-queue xmit path (since tx_pending_pkts is now
authoritative) and make ci_txq_release_all_mbufs()/reset aware that split
queues must drain via tx_pending_pkts instead of sw_ring, or keep clearing
txe->mbuf = NULL alongside the tx_pending_pkts free in the RS-completion
handler so the two structures stay in sync.

Error: shadow-ring allocation failure is silently swallowed (medium
confidence) In idpf_qc_split_tx_descq_reset(), if rte_zmalloc_socket() for
tx_pending_pkts fails, the function logs an error and returns, but it is
void and none of its four call sites check for failure
(idpf_common_rxtx.h:217). tx_pending_pkts stays NULL and tx_pending_mask
stays uninitialized, yet idpf_dp_splitq_xmit_pkts() unconditionally does
txq->tx_pending_pkts[tag] = tx_pkts[nb_tx];, which will
NULL-pointer-dereference on the first transmit. This needs to propagate as
a real error (change the function to return int, or fail queue setup/start)
rather than only logging.
