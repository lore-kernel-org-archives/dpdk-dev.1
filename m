Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EBAFEA838
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:12:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2430640A6B;
	Wed, 25 Mar 2026 10:12:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D28954028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774429970; x=1805965970;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=kn1GlKy7o9psUzoveO26xhX1/zZ8zemaAbHOrmDq5Cs=;
 b=P7mMyRWyOhteiZNjPKWooMy71YOUrzfSxpfD9BAqPfv2WXIHupQt4Ry9
 lLDwf5JLnKV+yB0ISk+FjPiRaU3UcUXFI6lk8okXN+ihMyZVOKHmEqtWe
 iz/Aey3x2aPCoZf0ZoLpiBgDHe+4d7JXh7Ood5Mt1LhH4MekuhvezetYx
 wF7YHvRO9K5MTnl7rlU04XujuDAY19eYHel9HyzI6kyU6ax1X6KaEI6is
 0I1jdpuLymSrHkMtMykL4o/yfYBqW5cj7uX3RmmswOW68ZciKUuEc0PIO
 5l5Bj632/YCkVBUq1NMKtmwdOgo4zMaEi5k5sls1faYcSc9HPm4oKkDW9 w==;
X-CSE-ConnectionGUID: 0EkobHA2RraW6QOUQeES4Q==
X-CSE-MsgGUID: E2GniiUgR5K69X8CyNWk2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75653009"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="75653009"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 02:12:49 -0700
X-CSE-ConnectionGUID: 3wC3/Z42QEyaSqxo5wZWSA==
X-CSE-MsgGUID: 7LRzyDgpRdiPF0PfxVGH1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="224630080"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 02:12:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:12:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 02:12:47 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 02:12:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwCkFt6arnI42Mckp7PksZkSGnVGkxEgAIZvM6YRIatxaH0BFhW1SIf2z2ExOoruGATvE2/gzd/ymiy4QIWYlaL3SX1xO7SAjz5/dJdmZ99reGnSxxTMTw1ZHg0GibXC9QvpG+hldGudxEkR2MnE5MCTNG7Tv0P3RoI0gBZZf2jO42pGI+WY3NOAfyxYccELVbK07fAW4G5g0UksW4whp6FruId8eDO47lBpPOS1a9Hu3garTBiRTLKsz7LIYyUuJItkypacHBmBf2xCI+AmYFaitOI1Jgs+c4W9PlBUMNA8unPhCz44OAZTcaxyY6fEkYpFBwT3lBvQpAe7pLzj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sjhy5NOQ7X3/Y5YpS3I4YRUUYFDLe9BkiFQPTSJgWRs=;
 b=FBF60QeepFalBXnUQPsVlxpZR87Z7PhGjRVU/F51liew7AdVk1wAvOrI4oG1XexncaLPm5YZWZRJ8r1BOM7RbM6zAlK9bDsnKBKq5Zurwh5nywqP1cGMI/8OclNL0IhR0VxdsMS4q6TtfkzmplOWHWvUwoT2pDtC1jFDWBqNFW3RrvomsRqLKJqoX30c1KRmQaDzm+cxhcePirPrGthX68HldmrdF+IOaomm3N/laCyCuaK9AEoOnUgPbh3hd/FcR0u4F+6/l4XBG0KyFpRggi/mnAumzu8bNLli1b8bLwbHSxYagOFCE2Q/qIOoJcbZY6fF9YZm3Jvqi7mANZ2e7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA3PR11MB7610.namprd11.prod.outlook.com (2603:10b6:806:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:12:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 09:12:43 +0000
Date: Wed, 25 Mar 2026 09:12:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, "Reshma
 Pattan" <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA3PR11MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c52a41c-41c5-494a-611e-08de8a4eac43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: HqnEK9uGp9Wt9W+qB+ZIIQo3DTahilgZn2XgyioseE/sEsw3f+D3jaNT4AQYTWTGWdSoiYJlhoTtO9PEE6DO06YAO5gCfLHE7ZqBXG6rV7CY0YE/loAJu/HlmqmfFfEI0siBjkRPmdukeFePr6t7gbb4ICImSKNTKbdrqL4DvbtuzJHi4H/It+SzTSgtktoKt9LyNlUJk6Ag8kZYQbrK0rheXMWzavAZJmzeO3wL/IUT7GYqHqM9684PV+CsQ0u58TiUknHbBQOoEdYemx0VQyb63k09FJ9zvHHJm/JrfRIoaPf00dkE9aY4TcozKE0N3Yh4F87rGTRrgH5/WXubQC3jf3wcagED67t9f0YEu0t1I2ckl5+PfJ3zNjEK0U1ZxcEKU3oKKCCpENBPYG0/yrW+UTOnOdOL0HSW7S1uzHYiV21qTikNldvBFz/ZvM9bGf8ewMLCI0UXuqEGfmydWFNHyqd82t1hFzSrgjGVxjl8MNQ3B009JwozYAt2+yG8IBw/ee52IxJXT57AY4lSpb6WYfKnnxwO8Z4IiJ43IZTfaARGabT2y/wFdNcQ+vFCvavZyC5+QkGKQFthEe5yHvFMeDJKY0YKi2dZpMS7agG/zQfWRI1ImC2cBh5vGhcYJHxVmg4qVnjCb/1EAGm593KQwce0ciZWYM1bjmVbBp5A10QkchgOpPjecsknaaov/jfta32KRF3kI7Dc8g6qbQ5y66v6VlY624LFzU7kJt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ao2F3qDhEIfDQqg+VPtxFLL+z2V8e0GDL0x/5ZtcVJyEXIPgjZo4JplnQ2?=
 =?iso-8859-1?Q?g2Q1/xnNZ95dtGqC3UGRYLJfG0zJE65w5a6yB9sy5yM6jRMgynNWUY0fwS?=
 =?iso-8859-1?Q?9bhTGZXD8pd0geEiBiqw9mTwcloh6Q5zjV7LfDwe3RyQI3mDKK4ROmKQJ+?=
 =?iso-8859-1?Q?ySb3SEShI3dUIPe4kt11+9Whr06/v6cwtrE2g7rbv9kz+Fx93sLAjaoCiN?=
 =?iso-8859-1?Q?WhEfFBAZoSGUK+KbBGOJkQE6RLrVzAIx8Cm6IT1Oz4AoqJUdhiwHu9sptR?=
 =?iso-8859-1?Q?am93n2sllb7pisMzEvRetBdg7X1udyQMFAJWLbGGPUe/ZGPsLqwsYmQht8?=
 =?iso-8859-1?Q?FR6cM4xeG9JNiYRBy8GIFB8Yqyy3OwoPqQikGzwnlIx4lptsJb4EyN3Tgg?=
 =?iso-8859-1?Q?tSydZqwudX60UtpfXJ2kXPjL6rydH1aX/Oar3Y2NJotRleynkx85STVjn4?=
 =?iso-8859-1?Q?n/OzNVQ+3W0xy3LGAiagi5PHX0BiB9STTl1yC1HwKdr78Hy2U2Fiy+wl2C?=
 =?iso-8859-1?Q?75+Q7y/8+N4N01Dl6PCdWu65VWYEs6qLztY/a0fTx5mwOt9pcz57McUzr5?=
 =?iso-8859-1?Q?BY0ztMoU4eh5lTbdkCFjOSzJcQOknxfw6HbH20rVMfneMItWC7N8sASI7d?=
 =?iso-8859-1?Q?J0O627CMPLEHPUPDybuwVB61fi3XORvU0j1wq4UbhxI1S2QmAM0DHDtfH3?=
 =?iso-8859-1?Q?kGN7AkUiM6/u5SkwUo2ntdmL7QCXlHhhtcqIyjAlBC7WccxSNnBed5vzjn?=
 =?iso-8859-1?Q?phPh9wbRuEU7BaTjl8pWKOhv54NS0VbD5sm5NB2pNaCDPTXa+sGVfDvO1+?=
 =?iso-8859-1?Q?MEsbJzWU64GHnXuLj6hxaOgbG1kkslWhs3lVl2R/ld3XJLSL0gUZlCOoGC?=
 =?iso-8859-1?Q?w4i7GDqlEg1g8hIrNae+hunw7TsNzZHvy1kB8XGuYLiFkXeKhKcFiCCo3x?=
 =?iso-8859-1?Q?RXT07luVYRNJ/U8bP4alc2E+WfqDaBhuX/eA8qkFyRul+mLJArgB7XzY8X?=
 =?iso-8859-1?Q?FYyjm2BaTkR6eU+emxxkEjFLIkydhJkWJ8QvLjhP9TAtV6iGVkLcgTDbG3?=
 =?iso-8859-1?Q?01iNLmo6haqriKktnGjG45OT0bhXwGsvKYVi3cH3b4QHtwXyyXm3d5TQY1?=
 =?iso-8859-1?Q?8JMNW6Bnx7HJ8+kygPjsoTGV+UsctuZHQdVhaBVz2PQJL5UrLYTZ+ugdAD?=
 =?iso-8859-1?Q?+0Y14AnHbW2brCAOhipqUwrkmQ1D5QE7vAIW7h8U1JTjwUXOh+wnLDUoTV?=
 =?iso-8859-1?Q?f37kugQ14LofvOaXGPlWtLYSfPttvO4bnjFnORZMePExE/oMZdv0M7T0Lp?=
 =?iso-8859-1?Q?y9GybKFggSZ2Obu4WzhAyUVXHzv+3UC0Ful6wgDnYy83JB7mD8pnFAgUad?=
 =?iso-8859-1?Q?tbrjfQhzhb+yTJ5+/CyfdREo0rpQqYQ8DoniXjDWzwNWlL8sEEN1aO7LZt?=
 =?iso-8859-1?Q?VzZYgj5oMJjE3tT5RzFMmWHSst5LU0TgHU3401zOLPt5TeThgBucu+/ND3?=
 =?iso-8859-1?Q?BUScPsbb0hrHGWv5oyEZDdKA5s9uQmAr0SFy8BhXIR1cGNMI67m3AabYe3?=
 =?iso-8859-1?Q?JptpfZvA8KofXM0OqWxm/U1z8h9mGMeYko+3soWlmhEsjNJieM2o/tqu6D?=
 =?iso-8859-1?Q?T7iKhv54JDMMqsh0tYUz30xjXJ/vXQvQxIyVzmOyq9OqPtEpQ2i5ebJltH?=
 =?iso-8859-1?Q?peZoKVUg6Ad8o2KlF55l3lo5fElfezr4mTZcob5qkVE4spEEXWnOEAuDxx?=
 =?iso-8859-1?Q?ungC0SOt2Tqk5a6x0UYNz21qzoX6C+xXoHElRdK5H5wuouZy2891zInACm?=
 =?iso-8859-1?Q?Lb3y4XiFZU/a9cN+1vhwkjqjyNfcg5k=3D?=
X-Exchange-RoutingPolicyChecked: H5a5QXtjUj23iQsPMq2LpPnamSyclAgMUofMv7UBL1CMe1wOW/Q49ChykSbBLRTwwpiKbExWVYDtL/csUdkE2c9tRj2R5WI8j27PxdfiHb4ylCiUJ5TvEdnBpbVLVDw/VXxZzgh2ccJvBPL8824Ljm3znXAwsgb6hlAp/mfgorIjwg5hgJz4Udr/DFAywNApGcwvWXECicltcS93G/FYC4awGi9SCy3Yu51+/tuLB3acDST26D14OClJis4VjMClzpoeDgppX5w2Hdzsk/aIq41mViqaGgovYC6nW/YDvpJiQd2m5uYVaqdeMefVZqs9U1QfHj5WH06rDl+rfNYyVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c52a41c-41c5-494a-611e-08de8a4eac43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:12:43.7630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ8vleQHPFm3VOrppFrgdqEIKX99/1oBjEbDe8Wx5uMTp4yh+ZKi/RNI2kt7uG0u0zdTRyFauXIQjhvIPAskrweB9rGjBOmxUoPzYHxaTUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7610
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

On Wed, Mar 25, 2026 at 08:41:39AM +0100, Morten Brørup wrote:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Tuesday, 24 March 2026 18.12
> > 
> > On Mon, 16 Mar 2026 16:55:29 +0100
> > Morten Brørup <mb@smartsharesystems.com> wrote:
> > 
> > > >
> > > > This is an example of something I previously flagged. Like with
> > real
> > > > hardware, I think the PMD should be inserting the VLAN tag into the
> > > > packet
> > > > as part of the Tx function, not the prepare function.
> > >
> > > Agree with Bruce on this.
> > > For simple stuff like VLAN offload, applications should not be
> > required to call tx_prep first.
> > >
> > > However, the Tx function is supposed to not modify the packets;
> > relevant when refcnt > 1.
> > >
> > > Instead of modifying the packet data to insert/strip the VLAN tag,
> > > perhaps the driver can split the write/read operation into multiple
> > write/read operations:
> > > 1. the Ethernet header
> > > 2. the VLAN tag
> > > 3. the remaining packet data
> > >
> > > I haven't really followed the pcap driver, so maybe my suggestion
> > doesn't make sense.
> > 
> > The prepare code and VLAN was copied from virtio.
> > I assume virtio is widely used already.
> 
> OK, that makes it harder to object to.
> 

Yes, but I also believe that the topic was not previously discussed and
that the virtio driver may be wrong in how it behaves.

I still think, for consistency with HW drivers, SW drivers should do the
tagging in the Tx function.

I also think that we should provide a DPDK-lib level helper function (be it in
ethdev or elsewhere) for doing this sort of thing for all drivers. That way
we can put in the necessary copying of packets with refcnt > 1 and have it
apply globally.

/Bruce
