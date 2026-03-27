Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2196E10F2865
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 18:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 355F540E49;
	Fri, 27 Mar 2026 19:28:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B10D6402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 19:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774636084; x=1806172084;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kuyLZzx74+3V4ioaYggYWGD5IO531uU2XSfjUoMzAjU=;
 b=dFmnAF+LJC6qGUzdWMTyPMbQE99Coul5PwAZM1xjF00fGzfzClVbxa2Q
 QFyG7EZ8qxgy4d654ajU/N+q4dW66yG5EkjvG0la2sU9TNA6rCgzLcib6
 iXZapXiqWvqLUOV+/tE0eo4jeEXVD9M5aCmFbI1vkRruKTW+E7tJwCK7X
 IiAOXdIFP+jDYAzuKWLeHj7jNUXLoVD3u4D+eBTsRmQPFOcDfOC4gbgB7
 AxZZif0zSkzq3l4DWFwJDkQ39yYyH8cUNMj1xCJWURpLq6Fe+sTguL2Zw
 qyLK2j9AH8QhYcSw2Lx8PMjm1iPVGvIaXuInaEZEqmJC5J0IZVJSMg1Xl A==;
X-CSE-ConnectionGUID: kEnaDk9mQZaZCRNhyE2ewg==
X-CSE-MsgGUID: +UNufoVvQqyvgIHjg6W1Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75618742"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="75618742"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 11:28:02 -0700
X-CSE-ConnectionGUID: GndcRtOaQGa2/r6i4r34Cw==
X-CSE-MsgGUID: ArnIKswySMitBQyD6GSclA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="224430296"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 11:28:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 11:28:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 11:28:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.47)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 11:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JStEhpUsKRgm/FDXbKrAbj+VGVs65wI6mjAJG44gvb/c7D27AW+WBqq6WWr+OTEHp1l/2fuImrjGoTb8atzJM6Kio7lv/bNrOJrCWMC2Oo+Dmqd6rt8LUuYkoPaHUZEQ82EmZfIzfyKnR7vy42t8jIvbncsDLYe8TcWUnPFxbFHIvveG1LfZL3KzQ8O1L+WWlYKfuTGebaGGAEyWORN+meV9wEAESz5KFp5E2aaiVwDP0ucpFuAVBfB+9YWnlEbEMSheamxK7gFFs+fY5R3HSJmRNtg99KlKgKhGUEV0iAdo21ioHuLQNk7JtRRvcAY9sOfPpRn14LdVg2XSxBPyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBN1nHghQo2PAnyGZFtBtkgugThR3l9yjYLuqP785w0=;
 b=R/2/uoFr8u6fY/U/M1qouhpKdu5AWlrZYgA7jokuWfaBfJGNzpfg8FQFljLSdMmdzwaHGD6y5jZND0hyYQtQjLfPkUQKunMOdb3sJ8+UBEKs1F71tV4jjrt6Ib3mvMW0p3aBLdCYYlzsP8KcLiMKJjlcglcYMO7ge61R1HGtMu+Gu8Nok9X70tpXVt8s5T8jPgq5MuuX0yhUDrnXPhMVX/bbdFT011+gWnokpa9UH/XKYfwF6yAO0LfJYOBw7Y8OvCxX5ZLBqQOIFkaZFSVynq8YoEdM1I+Czmw/7N8vGIxvDN/XJbaZUzf4qYaOXTD6xM+zptk6sKvGjtvH5KmTsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 18:27:58 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 18:27:58 +0000
Message-ID: <9534229c-fe4c-45e8-8bb0-515f440b1a32@intel.com>
Date: Fri, 27 Mar 2026 18:27:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: Maxime Leroy <maxime@leroys.fr>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <nsaxena16@gmail.com>,
 <mb@smartsharesystems.com>, <adwivedi@marvell.com>, <jerinjacobk@gmail.com>,
 Vladimir Medvedkin <medvedkinv@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
 <d944f17d-35a7-42d3-9011-2d368f530474@intel.com>
 <CAHHRULXCfeFrgTosCJCvMK0+Qe-eBy2bJs43KDvEwYC6A6GRCg@mail.gmail.com>
 <a3a95872-2cc7-4b9d-ae70-179050339bd8@intel.com>
 <CAHHRULUHTLohJ+2=uTRwB5mq54yK=wytfC0vCf-sa2Bv-rwX8g@mail.gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <CAHHRULUHTLohJ+2=uTRwB5mq54yK=wytfC0vCf-sa2Bv-rwX8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0198.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::29) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: 93aefd13-1bb3-4259-3ffd-08de8c2e923e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: fm/vDKR0xHUJdqfVIYgJqO2A2Ni1LKDzRbMcENaFWdRsy+FtmJe5n+LHWSkNorEVSKBnZ0cWixmcVo0KyRJScA8m5PbvJ//YlqvpKuH/6E92Iy/l8hG6umBsR9QV+r6MBC4lLJocosDtqLw/lSsXjRA7j2JChPe01wOXydV/y5TXtFO5YNEzB9ps+Ff9D5fM15YZjHGal9+esUOCM94zEAfNBWIxFFsjzS88Xf7iKPVnNTbpEpOBvsYQTBY7avld2cyUmunzgk3mHn6Rtq+pEg3YWmO1wwXTGsBvy0+ofqgItOAb9HNpl8OPRwZECNyuOz38DRyymY1q+Y/Nzi5iksGi9wYUXIPv0B+oC1m3eYnRYyzbKPpBWfW9TI4pOUuNPgjIREW3H16715cLoKSzfywjrcFQrXZvHpHVMdRzLlnjZaR/ge4cbX3D3UTyQ5Fq/K4voS1BXr9Q2aRJbL/oeXZd6qF1Sp/MfMQLXvlGJP3TffSbJWhAy94JwLdXgleXVUPLx0eMshs7EHR+opg4v4uLoHV7G3/6zomiHHZgYXZhNG8gAejRED7LcRByUmCBLmbQqPvxGqZVhe5sZdHXUv0Scj3zVM33IMSwMja8iy9cy7pHXSRzR1gkPSNnw/VMamNy7t7IZw1SKFQd66j4NLLo5DRrg0Z0k6NT4KjEsO6yqWjHr1CqEBiHsWyFuoD2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllQOVlZMFg1Tm1VVjBTTWYwSzMwWjRFTzMxVW1QTk5tWGtSbHR0V2xTWDlt?=
 =?utf-8?B?bzUvNm5td1VvM1lkUldFUXhNK2VuNXNuMzNJMmRQNXoxcTk4Vmd6U0NZb0FZ?=
 =?utf-8?B?bzY0aU5tY1d0NUhzQ0JMNTJJTGNWSU9TQWpwcjVQZjFSRWkxbUdnQXVDTE5q?=
 =?utf-8?B?cGMzV2h2bW1SVm9iRU5EdzBrUzN2UEl5eFZNSlBSOGMxY1lSSWpNNnZSNzJG?=
 =?utf-8?B?enNsdVVzbUtvTTc4WEl1N2sreEZqbHczc2hTNjVLYkd4MGphYXhDWVBZUk1E?=
 =?utf-8?B?VjdiMTFFWk4vRnVtN1JVTnBDbGREMmp6U25pT0IwVmUvK0dSUVlKQTd6TTZG?=
 =?utf-8?B?Q1FHVEtFa09QZXZiVXpSU0FWOFNFVVM4d2FkQkdIUTJqRm1EQWZKUE1OSDJv?=
 =?utf-8?B?OUF2VENiWUpDUmJlYlpDdjVjZk0vRnJULzluY3JXRURWODk2SjdyVHRzU1lG?=
 =?utf-8?B?VGx6dDZwNXh2cmREQXg2OE5NMDh4Q0JGUTc5NnVaaklieC9ldTdBNUFFSXk2?=
 =?utf-8?B?eDdrUCtoREVaM2QwZmVJZGEzNTBGYTdlTXZNV1VIZm5zZTBrckZNSURkZjl3?=
 =?utf-8?B?YTVqd2lmK2d0NW0wb25CL09hV3o4clFPMXRRU01Ebzg5eWlSeE5UOGlNcmt4?=
 =?utf-8?B?aTVPUmpZdkhXS0hDZmFRNDFDWUthZGRqTEsxeUtCeUY0ank2RVZQdy83dUJz?=
 =?utf-8?B?blRYbWNQekliV2prbE04WE54U1h0c1JrdzIxYzRqcGZBVDJleTVoRE1VSjZZ?=
 =?utf-8?B?aTNXWm1Uc0dOWUVyV2lZQ01ndkhnR0hrR1loY2c1MjlTcE9CMnE3VDVlVFQ4?=
 =?utf-8?B?S2tEM3MvR2x5MGM1aE1reHJxZTNvNzdCdGQ1bEhFQ0UrSFlwc25icE05UE56?=
 =?utf-8?B?ZXVycVZsMFhjdTl6OWJoazJ3MVNtZ3JKUUwyYWVIc0dETXI4VHFta3RBREJN?=
 =?utf-8?B?Zk9WbnhXbUY0ekpLSTN1cjZDZG5ubzltK1Q4TkhCNjg2OHlJTmtmSk9MT3Fv?=
 =?utf-8?B?N0ZlcmFjc1MxMmdtQXU3aWhLeUpBbUczeVUzVDhvaTZaS0pYeDRjQS9XM0pM?=
 =?utf-8?B?eWROMHBtWlNBTkF3Z1lqWElxSnc4Rk90MWNMZjg4TDhaZGtSNDl1VlM4eElz?=
 =?utf-8?B?NDRzUzBOeXQwbmE2OFF0bTVubExyREVmaHc1b25SV3VTVUU1Sk5mL0VENlVH?=
 =?utf-8?B?TXVUc1VNdDhFaFNvcVJzMURxRS92TjRCZXhBbDc1VDd4VmJkbDhlUUlidmto?=
 =?utf-8?B?dnJNQjdvUmd4L3lUc3dHK1JmR1c1S3BFa1dlbk1TUTVxVWFub0g3eXRkc1dz?=
 =?utf-8?B?bzZIeUZFMnhSbmN6anVJc0VjdGsyOExtcC9EMzBrRkVxMjRhbW45K0hvNFVx?=
 =?utf-8?B?VFRuM0U4eHRrSG1SSWZtS2RhTzRGUXhCalNuRFZtNmZmdldFdTVSUEYzbEZT?=
 =?utf-8?B?WVJOM1VNRHJOZTVaTDVFRVZEek8zaGJwWTdoREJPYjErWFY1bC8xVHkrVEJu?=
 =?utf-8?B?c2ppdGk3YkZNSUVsT0dkV2o3eE1icHQyc0QxeSsySGI3d210eXJmUXJKSHAz?=
 =?utf-8?B?Yk0razFVTTJwa3hGdlkxUTB2Slo1SE1qQ3pzazU2ZWtDYlE0Qzk3cWJPekRa?=
 =?utf-8?B?SzB0M3czRFBGd0szdkFTbnJRRFp5U1BmK0ZqYnJpSVVFYitXaWlGQnFlenVY?=
 =?utf-8?B?cmxRcnFadmV6eHM5S0RUTHR1NURPRThWOCtOalRDYzJBd3JVMTUxb2wydDJF?=
 =?utf-8?B?MWpxbUlBWlQ5aXk2bnBjUXU1eDZXRXpBS0dFZnE4Q253YnBMK1JBWStNODRG?=
 =?utf-8?B?cUJHUE9ZemJGTExEYytGd0NBaXUwTTRKNHA2d3I2bG9BY2J5MGoxcld4ZlNH?=
 =?utf-8?B?ZStVMW9KOTZEdi9pTlozLzlTeExyRGN3Z3VJcG1xdVAzMlY3TWlUQm9RSlJu?=
 =?utf-8?B?YzdscG9JOWdnZnNKS2oyS0F5WjFPb2xKMXlsVGVsTVBBeDFodTZWT2NtN3ky?=
 =?utf-8?B?UG0xVmNoNk1pWVpPNjlHVEJWbnhlTDFMQ0V3a211Z0VLb1hIVVVDN1pkUXhN?=
 =?utf-8?B?b0VpRlV6cE1RMVlzK25JY1BtQVlsTHdEenBLRmNCRWgvVGxkSTA0RU9jeUtK?=
 =?utf-8?B?cWNhTmpFQjZ0SEJEcy96TDNBRVJ5SW9zMWJQN2JLOXNMNXR2bU0wUjV5T29v?=
 =?utf-8?B?OG5Qeng5d01nNHAvWU94cTNNNmN4K1lvQlpyVEYvZkxnUThqRGd4K2p6T0Q5?=
 =?utf-8?B?MUVNbTZtdC9NRm9pdnJocUpwYUVPSmVlMTI0ejd3OGhjVGJ2dG9sR3RsQnZ5?=
 =?utf-8?B?S3ZEd2VzZW95cmdLVTdDcDlqUkplcHF0V0g2ZzNNNEsvNkpGNjlqbzQ3R3VV?=
 =?utf-8?Q?+HLYPkMug9c6PO+s=3D?=
X-Exchange-RoutingPolicyChecked: VbJFTMx7+lNeFxu/s4mWNyp8W1JMo4qgChFD67Oq4dCCyb5bgM1eTAUm9oqb3PtMk/7APdLWVFf9ArPUrmceyexEenjlL7bViFOxW9WMTVse7uZZm2RT2DIiaiXqsMHsv14FLPkbmSUMriBX5t/6BgEe7/NGBQmZT92T9XJULKViMeSy9jmfxG1KRatbTT0UX7yzwOLqXrUAW5yCFzPOqEnqXyJN7lPb1QhzZ0lWV69tQnlOZhVSu8v8brJ6jSaD7WNg65124M0fZhuwY/XPCKJNyndFKadD5JsOtAAVygZ1ZJhvBuoIK6Aw/qLtX0L+Fow15NYyjr1wpsNADnkOYA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93aefd13-1bb3-4259-3ffd-08de8c2e923e
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:27:58.4531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MWSW/AdMByDjv215JoVCwkRvxrGvF/IrpDoxK69ihU9BZBUUWUNRQZmPMryYoipMbg8teNurASokC0cQZR2r1xdO0+utYrQQkRihrMeiPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
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

Hi Maxime,

On 3/25/2026 9:43 PM, Maxime Leroy wrote:
> Hi Vladimir,
>
> On Wed, Mar 25, 2026 at 4:56 PM Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com> wrote:
>>
>> On 3/24/2026 9:19 AM, Maxime Leroy wrote:
>>> Hi Vladimir,
>>>
>>> On Mon, Mar 23, 2026 at 7:46 PM Medvedkin, Vladimir
>>> <vladimir.medvedkin@intel.com> wrote:
>>>> On 3/23/2026 2:53 PM, Maxime Leroy wrote:
>>>>> On Mon, Mar 23, 2026 at 1:49 PM Medvedkin, Vladimir
>>>>> <vladimir.medvedkin@intel.com> wrote:
>>>>>> Hi Maxime,
>>>>>>
>>>>>> On 3/23/2026 11:27 AM, Maxime Leroy wrote:
>>>>>>>      Hi Vladimir,
>>>>>>>
>>>>>>>
>>>>>>> On Sun, Mar 22, 2026 at 4:42 PM Vladimir Medvedkin
>>>>>>> <vladimir.medvedkin@intel.com> wrote:
>>>>>>>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
>>>>>>>> allowing a single FIB instance to host multiple isolated routing domains.
>>>>>>>>
>>>>>>>> Currently FIB instance represents one routing instance. For workloads that
>>>>>>>> need multiple VRFs, the only option is to create multiple FIB objects. In a
>>>>>>>> burst oriented datapath, packets in the same batch can belong to different VRFs, so
>>>>>>>> the application either does per-packet lookup in different FIB instances or
>>>>>>>> regroups packets by VRF before lookup. Both approaches are expensive.
>>>>>>>>
>>>>>>>> To remove that cost, this series keeps all VRFs inside one FIB instance and
>>>>>>>> extends lookup input with per-packet VRF IDs.
>>>>>>>>
>>>>>>>> The design follows the existing fast-path structure for both families. IPv4 and
>>>>>>>> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
>>>>>>>> first-level table scales per configured VRF. This increases memory usage, but
>>>>>>>> keeps performance and lookup complexity on par with non-VRF implementation.
>>>>>>>>
>>>>>>> Thanks for the RFC. Some thoughts below.
>>>>>>>
>>>>>>> Memory cost: the flat TBL24 replicates the entire table for every VRF
>>>>>>> (num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
>>>>>>> 32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
>>>>>>> on demand -- this approach forces the full cost upfront even if most
>>>>>>> VRFs are empty.
>>>>>> Yes, increased memory consumption is the
>>>>>> trade-off.WemakethischoiceinDPDKquite often,such as pre-allocatedmbufs,
>>>>>> mempoolsand many other stuff allocated in advance to gain performance.
>>>>>> For FIB, I chose to replicate TBL24 per VRF for this same reason.
>>>>>>
>>>>>> And, as Morten mentioned earlier, if memory is the priority, a table
>>>>>> instance per VRF allocated on-demand is still supported.
>>>>>>
>>>>>> The high memory cost stems from TBL24's design: for IPv4, it was
>>>>>> justified by the BGP filtering convention (no prefixes more specific
>>>>>> than /24 in BGPv4 full view), ensuring most lookups hit with just one
>>>>>> random memory access. For IPv6, we should likely switch to a 16-bit TRIE
>>>>>> scheme on all layers. For IPv4, alternative algorithms with smaller
>>>>>> footprints (like DXR or DIR16-8-8, as used in VPP) may be worth
>>>>>> exploring if BGP full view is not required for those VRFs.
>>>>>>
>>>>>>> Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
>>>>>>> Mixed-VRF bulk lookups do not occur in practice. The three AVX512
>>>>>>> code paths add complexity for a scenario that does not exist, at
>>>>>>> least for a classic router. Am I missing a use-case?
>>>>>> That's not true, you're missing out on a lot of established core use
>>>>>> cases that are at least 2 decades old:
>>>>>>
>>>>>> - VLAN subinterface abstraction. Each subinterface may belong to a
>>>>>> separate VRF
>>>>>>
>>>>>> - MPLS VPN
>>>>>>
>>>>>> - Policy based routing
>>>>>>
>>>>> Fair point on VLAN subinterfaces and MPLS VPN. SRv6 L3VPN (End.DT4/
>>>>> End.DT6) also fits that pattern after decap.
>>>>>
>>>>> I agree DPDK often pre-allocates for performance, but I wonder if the
>>>>> flat TBL24 actually helps here. Each VRF's working set is spread
>>>>> 128 MB apart in the flat table. Would regrouping packets by VRF and
>>>>> doing one bulk lookup per VRF with separate contiguous TBL24s be
>>>>> more cache-friendly than a single mixed-VRF gather? Do you have
>>>>> benchmarks comparing the two approaches?
>>>> It depends. Generally, if we assume that we are working with wide
>>>> internet traffic, then even for a single VRF we most likely will miss
>>>> the cache for TLB24, thus, regardless of the size of the tbl24, each
>>>> memory access will be performed directly to DRAM.
>>> If the lookup is DRAM-bound anyway, then the 10 cycles/addr cost
>>> is dominated by memory latency, not CPU. The CPU cost of a bucket
>>> sort on 32-64 packets is negligible next to a DRAM access (~80-100
>>> ns per cache miss).
>> memory accesses are independent and executed in parallel in the CPU
>> pipeline
>>>    That actually makes the case for regroup +
>>> per-VRF lookup: the regrouping is pure CPU work hidden behind
>>> memory stalls,
>> regrouping must be performed before memory accesses, so it cannot be
>> amortized in between of memory reads
> With internet traffic, TBL24 lookups quickly become limited by
> cache misses, not CPU cycles. Even if some bursts hit the same
> routes and benefit from cache locality, the CPU has a limited
> number of outstanding misses (load buffer entries, MSHRs) --
> out-of-order execution helps, but it is not magic.
Correct, but this does not contradict to what I'm saying
>
> The whole point of vector/graph processing (VPP, DPDK graph, etc.)
> is to amortize that memory latency: prefetch for packet N+1 while
> processing packet N. This works because all packets in a batch
> hit the same data structure in a tight loop.
https://github.com/DPDK/dpdk/blob/626d4e39327333cd5508885162e45ca7fb94ef7f/lib/fib/dir24_8.h#L161 

>
> With separate per-VRF TBL24s, a bucket sort by VRF -- a few
> dozen cycles, all in L1 -- gives you clean batches where
> prefetching works as designed. This is exactly what graph nodes
> already do: classify, then process per-class in a tight loop.
How lookup is performed in this design? Am I understand it right:
1. sort the batch by VRF ids, splitting IPs from the batch with IP 
sub-batches belonging to the same VRF id
2. for each subset of IPs perform lookup in tbl24[batch_common_vrf_id]
3. unsort nexthops

Correct?
>
>>>    and each per-VRF bulk lookup hits a contiguous
>>> TBL24 instead of scattering across 128 MB-apart VRF regions.
>> why is a contiguous 128Mb single-VRF TBL24 OK for you, but bigger
>> contiguous multi-VRF TBL24 is not OK in the context of lookup (here we
>> are talking about lookup, omitting the problem of memory consumption on
>> init)?
> The performance difference may be small, but the flat approach
> is not faster either -- while costing 64 GB upfront.
it seems you are implicitly take an assumption of 256 VRFs. Is my 
usecase with a few VRFs have a right to exist?
>
>> In both of these cases, memory access behaves the same way within a
>> single batch of packets during lookup, i.e. the first hit is likely a
>> cache miss, regardless of whether we are dealing with one or more VRFs,
>> it will not maintain TBL24 in L3$ in any way in a real dataplane app.
>>
>>>> And if the addresses are localized (i.e. most traffic is internal), then
>>>> having multiple TBL24 won'tmake the situationmuchworse.
>>>>
>>> With localized traffic, regrouping by VRF + per-VRF lookup on
>>> contiguous TBL24s would benefit from cache locality,
>> why so? There will be no differences within a single batch with a
>> reasonable size (for example 64), because within the lookup session, no
>> matter with or without regrouping, temporal cache locality will be the same.
>>
>> Let't look at it from a different angle. Is it
>> worthregroupingipaddressesby/8(i.e. 8 MSBs)withthe
>> currentimplementationof a singleVRFFIB?
>>
>>>    while the
>>> flat multi-VRF table spreads hot entries 128 MB apart. The flat
>>> approach may actually be worse in that scenario
>>>
>>>> I don't have any benchmarks for regrouping, however I have 2 things to
>>>> consider:
>>>>
>>>> 1. lookup is relatively fast (for IPv4 it is about 10 cycles per
>>>> address, and I don't really want to slow it down)
>>>>
>>>> 2. incoming addresses and their corresponding VRFs are not controlled by
>>>> "us", so this is a random set. Regrouping effectively is sorting. I'm
>>>> not really happy to have nlogn complexity on a fast path :)
>>> Without benchmarks, we do not know whether the flat approach is
>>> actually faster than regroup + per-VRF lookup.
>> feel free to share benchmark results. The only thing you need to add is
>> the packets regrouping logic, and then use separate single-VRF FIB
>> instances.
> Your series introduces a new API that optimizes multi-VRF lookup.
> The performance numbers should come with the proposal.
By the policy we can not share raw performance numbers, and I think this 
is unnecessary, because performance depends on the testing environment 
(content of the routing table, CPU model, etc).

Tests I've done on my board with ipv4 full-view (782940 routes) with 4 
VRFs performing random lookup in all of them was 180% in cost comparing 
to a single VRF with the same RT content.

You can test it in your environment with
dpdk-test-fib -l 1,2  --no-pci -- -f <path to your routes> -e 4 -l 
100000000 -V <number of VRFs>

>
>>>>> On the memory trade-off and VRF ID mapping: the API uses vrf_id as
>>>>> a direct index (0 to max_vrfs-1). With 256 VRFs and 8B nexthops,
>>>>> TBL24 alone costs 32 GB for IPv4 and 32 GB for IPv6 -- 64 GB total
>>>>> at startup. In grout, VRF IDs are interface IDs that can be any
>>>>> uint16_t, so we would also need to maintain a mapping between our
>>>>> VRF IDs and FIB slot indices.
>>>> of course, this is an application responsibility. In FIB VRFs are in
>>>> continuous range.
>>>>>     We would need to introduce a max_vrfs
>>>>> limit, which forces a bad trade-off: either set it low (e.g. 16)
>>>>> and limit deployments, or set it high (e.g. 256) and pay 64 GB at
>>>>> startup even with a single VRF. With separate FIB instances per VRF,
>>>>> we only allocate what we use.
>>>> Yes, I understand this. In the end, if the user wants to use 256 VRFs,
>>>> the amount of memory footprint will be at least 64Gb anyway.
>>> The difference is when the memory is committed.
>> yes, this's the only difference. It all comes down to the static vs
>> dynamic memory allocation problem. And each of these approaches is good
>> for solving a specific task. For the task of creating a new VRF, what is
>> more preferable - to fail on init or runtime?
> The main problem is that your series imposes contiguous VRF IDs
> (0 to max_vrfs-1). How a VRF is represented is a network stack
> design decision
exactly - a network stack decision. FIB is not a network stack.
>   -- in Linux it is an ifindex,
so every interface lives in it's own private VRF?
>   in Cisco a name,
are you going to pass an array of strings on lookup?
> in grout an interface ID.
haven't we decided this is a problematic design(VLANs, L3VPN, etc)?
>   Any application using this API needs
> a mapping layer on top.
I think from my rhetoric questions this should be obvious
>
> In grout, everything is allocated dynamically: mempools, FIBs,
> conntrack tables. Pre-allocating everything at init forces
> hardcoded arbitrary limits and prevents memory reuse between
> subsystems -- memory reserved for FIB TBL24 cannot be used for
> conntrack when the VRF has no routes, and vice versa. We prefer
> to allocate resources only when needed. It is simpler for users
> and more efficient for memory.
>
>>>    With separate FIB
>>> instances per VRF, you allocate 128 MB only when a VRF is actually
>>> created at runtime. With the flat multi-VRF approach, you pay
>>> max_vrfs * 128 MB at startup, even if only one VRF is active.
>>>
>>> On top of that, the API uses vrf_id as a direct index (0 to
>>> max_vrfs-1). As Stephen noted, there are multiple ways to model
>>> VRFs. Depending on the networking stack, VRFs are identified by
>>> ifindex (Linux l3mdev), by name (Cisco, Juniper), or by some
>>> other scheme. This means the application must maintain a mapping
>>> between its own VRF representation and the FIB slot indices, and
>>> choose max_vrfs upfront. What is the benefit of this flat
>>> multi-VRF FIB if the application still needs to manage a
>>> translation layer and pre-commit memory for VRFs that may never
>>> exist?
>> This is the control plane task.
>>>> As a trade-off for a bad trade-off ;) I can suggest to allocate it in
>>>> chunks. Let's say you are starting with 16 VRFs, and during runtime, if
>>>> the user wants to increase the number of VRFs above this limit, you can
>>>> allocate another 16xVRF FIB. Then, of course, you need to split
>>>> addresses into 2 bursts each for each FIB handle.
>>> But then we are back to regrouping packets -- just by chunk of
>>> VRFs instead of by individual VRF. If we have to sort the burst
>>> anyway, what does the flat multi-VRF table buy us?
>>>
>>>>>>> I am not too familiar with DPDK FIB internals, but would it be
>>>>>>> possible to keep a separate TBL24 per VRF and only share the TBL8
>>>>>>> pool?
>>>>>> it is how it is implemented right now with one note - TBL24 are pre
>>>>>> allocated.
>>>>>>> Something like pre-allocating an array of max_vrfs TBL24
>>>>>>> pointers, allocating each TBL24 on demand at VRF add time,
>>>>>> and you suggesting to allocate TBL24 on demand by adding an extra
>>>>>> indirection layer. Thiswill leadtolowerperformance,whichIwouldliketo avoid.
>>>>>>>      and
>>>>>>> having them all point into a shared TBL8 pool. The TBL8 index in
>>>>>>> TBL24 entries seems to already be global, so would that work without
>>>>>>> encoding changes?
>>>>>>>
>>>>>>> Going further: could the same idea extend to IPv6? The dir24_8 and
>>>>>>> trie seem to use the same TBL8 block format (256 entries, same
>>>>>>> (nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
>>>>>>> allocator allow a single pool shared across IPv4, IPv6, and all
>>>>>>> VRFs? That could be a bigger win for /32-heavy and /128-heavy tables
>>>>>>> and maybe a good first step before multi-VRF.
>>>>>> So, you are suggesting merging IPv4 and IPv6 into a single unified FIB?
>>>>>> I'm not sure how this can be a bigger win, could you please elaborate
>>>>>> more on this?
>>>>> On the IPv4/IPv6 TBL8 pool: I was not suggesting merging FIBs, just
>>>>> sharing the TBL8 block allocator between separate FIB instances.
>>>>> This is possible since dir24_8 and trie use the same TBL8 block
>>>>> format (256 entries, same encoding, same size).
>>>>>
>>>>> Would it be possible to pass a shared TBL8 pool at rte_fib_create()
>>>>> time? Each FIB keeps its own TBL24 and RIB, but TBL8 is shared
>>>>> across all FIBs and potentially across IPv4/IPv6. Users would no
>>>>> longer have to guess num_tbl8 per FIB.
>>>> Yes, this is possible. However, this will significantly complicate the
>>>> work with the library, solving a not so big problem.
>>> Your series already shares TBL8 across all VRFs within a single
>>> FIB -- that part is useful, and it does not require the flat
>>> multi-VRF TBL24.
>>>
>>> In grout, routes arrive from FRR (BGP, OSPF, etc.) at runtime.
>>> We cannot predict TBL8 usage per VRF in advance
>> and you don't need it (knowing per-VRF consumption) now. If I understood
>> your request here properly, do you want to share TBL8 between ipv4 and
>> ipv6 FIBs? I don't think this is a good idea at all. At least because
>> this is a good idea to split them in case if one AF consumes (because of
>> attack/bogus CP) all TBL8, another AF remains intact.
> If TBL8 isolation per AF is meant as a protection against route
> floods, then the same argument applies between VRFs: your series
> shares TBL8 across all VRFs within a single FIB, so a bogus
> control plane in one VRF exhausts TBL8 for all other VRFs.
>
> But more fundamentally, this is not how route flood protection
> works. It is handled in the control plane: the routing daemon
> limits the number of prefixes accepted per BGP session
> (max-prefix) and selects which routes are installed via prefix
> filters -- before those routes ever reach the forwarding table.
>
> The Linux kernel is a good reference here. IPv6 used to enforce
> a max_size limit on FIB + cache entries (net.ipv6.route.max_size,
> defaulting to 4096). It caused real production issues and was
> removed in kernel 6.3. IPv4 never had a FIB route limit. There
> is no per-VRF route limit either. The kernel relies entirely on
> the control plane for route flood protection.

FIB is not the Linux kernel, as well as not a network stack. We can not 
rely on a control plane protection, since control plane is a 3rd party 
software.

Also, I think allocating a very algorithm-specific entity such as pool 
of TBL8 prior to calling rte_fib_create and passing a pointer on it 
could be confusing for many users and bloating API.

FIB supports pluggable lookup algorithms, you can write your own and 
specify a pointer to the tbl8_pool in an algorithm-specific 
configuration defined for your algorithm, where you may also create a 
dynamic table of TBL24 pointers per each VRF. If you need any help with 
this task - I would be happy to help.

>
>>>    -- it depends on
>>> prefix length distribution which varies per VRF and changes over
>>> time. No production LPM (Linux kernel, JunOS, IOS) asks the
>>> operator to size these structures per routing table upfront.
>> - they are using different lpm algorithms
>> - you use these facilities, developers properly tuned them. FIB is a low
>> level library, it cannot be used without any knowledge, it will not
>> solve all the problems with a single red button "make it work, don't do
>> any bugs"
>> P.S. how do you know how JunOS  /IOS implements their LPMs? ;)
>>
> I do not need to know their LPM implementation -- I only need
> to know how they are configured. No production router requires
> the operator to size internal LPM structures.
>
> We can impose a maximum number of IPv4/IPv6 routes on the user
> -- even though the kernel does not need this either. But TBL8
> is a different problem: the application cannot predict TBL8
> consumption because it depends on prefix length distribution,
> which varies per VRF and changes over time with dynamic routing.
> Today there is no API to query TBL8 usage, and no API to resize
> a FIB without destroying it.
>
> This is exactly why a shared TBL8 pool across VRFs is useful:
> VRFs with few long prefixes naturally leave room for VRFs that
> need more.

but this is already implemented. I don't know why you repeatedly 
concerning about this. We are aligned about this and this feature is 
already there - in the patch
On the other hand what we disagreed on is the sharing not only across 
VRFs, but also across address families. If you don't understand the 
amount of TBL8 per AF, how would you magically understand the number of 
TBL8s for a merged pool?

>   This is the valuable part of your series. But it
> does not require a flat multi-VRF TBL24 -- separate per-VRF
> TBL24s sharing a common TBL8 pool would give the same benefit
> without the 64 GB upfront cost.

andthat'sa completelydifferentproblem.Please,let's separatethe 
problemsandnotmixthemup.

I understand your concern about memory consumption. Ihavesomeideason 
howto solvethisproblem as a parallel to proposed solution.

>
>>> Today we do not even have TBL8 usage stats (Robin's series
>>> addresses that)
>> I will tryto findtimetoreviewthispatchinthe nearfuture
> Thanks, Robin's TBL8 stats series would help users understand
> their TBL8 consumption -- a more practical improvement for
> current users.
>
> Regards,
> Maxime

-- 
Regards,
Vladimir

