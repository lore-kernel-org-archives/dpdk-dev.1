Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D30CD98CF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 08:07:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B7840654;
	Tue, 16 Jun 2026 10:07:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id EF1FD402DB;
 Tue, 16 Jun 2026 10:07:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781597223; x=1813133223;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zEEdnhdGaNq57lDLf4b5J4WtQOvYQoaN3RKtZ2/yG7I=;
 b=HZZeJddz5tpIrodLwgPoPG/kCyJg0WK7ykXVZPG0nZRixIPM1pUExV/d
 iC8ipXFhJ1+sy7xIyURWn6dD+cufhOsjhmxGEf+0C0R3TEJPEht/Sx7wh
 q40tEMKrjNRmud95uIqgCkkQKwoAolC8hiDkYzsvBjM5uBFnR60tjoFPx
 K9qNAnM2rtWv37+Bc9loXgqegIHkP1XS1dAZ/Lg5iIJt/wBUKKY+rJu+7
 oeSS1wNViMhFpempG4614dmw/xG2CDnmMuaQJqXYg+wL3lwE2YQHhLYhL
 YWKtEv06fkH9rDBx6HUm93OrTHZ9JxOXagk3Cxrw8M7zYBw+nRFBqGoQo A==;
X-CSE-ConnectionGUID: SBXqAKM+SO2her++uffUSg==
X-CSE-MsgGUID: iL93LKP8Th+RULYrni2o1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93026687"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; d="scan'208";a="93026687"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 01:07:02 -0700
X-CSE-ConnectionGUID: 1HUKJx0+Te+qkqhnTBnLpg==
X-CSE-MsgGUID: /4u3YgZwQBym4PgqhetFoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; d="scan'208";a="251618488"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 01:07:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 01:07:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 01:07:01 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 01:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQmbehb/QdnnwtFH+wMchh4KH/OlBxckRUn/2wixi7gsutHuTYhjyEam2tqWHMNgbBtX8Hsr76/RsRV8l2FnvRBHXBBzFAE6gUIcae4h6ILr/qIuctb7DKU1eApvKA2tswW/vsS9ONvHzUxiAa4lw5RV9vsSp228D+ApQZqMb9zKUfGncYh449sEewIH7BUJZkA2DI+p9NfDm/+a09W+mgDKvO7zhtDemx0172lt1QNDaj81C4GHYwQtlHEvpU+3ZXyVazWFUXXBxzjoiwz85n7aRz3QqUoKtGl+JaSgqeFkN9usc8MXZHzHq7wH0lOTTxCrKVmt4cp8rbQodO3I8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBzfkDhuFSe11XXT5mtV7tx933eIMy5i0COGt4GeDVM=;
 b=wsmOZs6GJl12SoHmHCoHMT9HcmKnV4MGgP6BQMfRiJTkWpWeK1i5t/DAym009iawzfEkvu9ODxOj9YF7ssO39KujMWT06wWYnXopOeLU4sRG8aatOIhW5cT8HhhEFdArwEgY/IlzI5AIW4gcVrVH/lgrrKGq7DTOv/W+HF+DWa+G+Kd3hvOKXDizaI14vbE0qaiseZzaF9wxksFy7HwvTc4voBf5bg5oiAVaUyv1+X6HnRmno5wyPUftzUtdeWRcqKZCFqy113HLW+SyYadMpU4lGr4sNl13l3+l2cXK+04KgZMS6PD5OG0htuuWoPXTEZdGOptPF10tS6WP+k+Z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6141.namprd11.prod.outlook.com (2603:10b6:8:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 08:06:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 08:06:59 +0000
Date: Tue, 16 Jun 2026 09:06:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Doherty, Declan" <declan.doherty@intel.com>
Subject: Re: [PATCH] net/iavf: fix scalar Rx path zero-length segment
Message-ID: <ajEEHXZbxsy30RfE@bricha3-mobl1.ger.corp.intel.com>
References: <20260612143531.2265914-1-ciara.loftus@intel.com>
 <aiwo_4aTWi8kBIkG@bricha3-mobl1.ger.corp.intel.com>
 <IA4PR11MB92788A2FA65444A5BDC62C0E8EE62@IA4PR11MB9278.namprd11.prod.outlook.com>
 <ai_G2-sLspd2PdK8@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ai_G2-sLspd2PdK8@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0351.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd2c4bd-b577-4ec4-993b-08decb7e3d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: uzU0RPjLIG7lnBNyKVxwCJJ3EwdAm40Iy3k0nEAYdZf+K6vAMFGF0WcPg3ogVnBu+BJx4HjsAOBw4Y/gWrp2ypcnZp7Omboqd6XWLl0J7P80oO/9pT9HX9fsGwsj2XpeUuC9iPh5gLjsvtAQuk4OqaZAyuIfxMEXF80SNyLVtG8rMIf0d2n+lwH6aJcE8Q00f8ZbG+r9imkeaFyXRpUGGvnkgTlX29D5zPHQZ9qf6f+uwC8Pj9NUZQ11YZDFi2k10bE+2N5+fuTblh23FgENxV38MZCSTUslAs5Il+5hIRTIOG3gvXCPxSiOag4dHJt36kGDS1Ch9pFzxxa+rCtRiUCiwz+xC4MkEFGDOBtE0To0AI8MFDPz+IhVmbCYEw2pyKumepXx8Xr9mJpm1nm1IBJYEEPnz0zAdLpTzUzhTAVqTGYlqiIyDonlLqeSiwD2iTfFiaUSRMH4oVC6mThJSgZJiSvIcgbW2/AIvIiCogyzMM0tvmBdxdcYO1vPPFk1MVhraVZ+LtaJwziqzPM+tXteFCNvoQUl/LkhOD8WunzsHpjUpC86T7waDrU3OPN80dK8a1FU0PbzaRoTZ2vE3843DBa15vfXyqMMnLRoJOJIQPai5dhS+j+0a6FCUIgTloc/bOM3r3pgQtaD7xvtP6pTK0vGcUdQjoedfcXKI4+YzH78khak0GLjb5x5ZmXLItedG7rrZ9NRdKEKsNDJJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1sOuVqJNvvF8srrVXDZs9a7RMf7MY/rcItEl6kgorDMxLupyUHviyB9BvpZB?=
 =?us-ascii?Q?Co7ctAYBpOQVnYl2MuYQzz/ESza4IwsO6YO0W8wrszC0MbB0Ypw61ycmnOTY?=
 =?us-ascii?Q?5XlrE+v+RqLDY+SdJMuHJet8R8H66zCagGGEjUYiBa5jFhQ7yE1I6MQhq/7U?=
 =?us-ascii?Q?4s0CsGncxXg8BzatLwd+hqewPalA54VKHS/iNE2M3y5/ZZqUnZcAXa2/AfTu?=
 =?us-ascii?Q?ObokIIgR3GCyGCTvKLxCUd5/waiSW+rnQsQN4bGRccLqtxNgfPydhiWZsUct?=
 =?us-ascii?Q?1OiGizBlVMCecOTQrLJvqlJn40v4LKfyXlClocwTmpgis9RTowwyibZ4mYPa?=
 =?us-ascii?Q?XZBdXEYroUeIN1gQfIKMrp0u56SBQ88UQF+GgpT8SEzs4gjQ0tLfhPyZydSx?=
 =?us-ascii?Q?7zdbuq3a3p53od3QV7Vxj81TO/zNcwHFaIWwjrNBwBVGV8DF2bgzCjfP6rKe?=
 =?us-ascii?Q?3cTNVVZE0w9J1RKHcFmFOVNXyZ2m6mssmhavRFhw7UTzcZN5e2F53wzYrrX5?=
 =?us-ascii?Q?lKUcRy9Ynjw8NGbVr3wJZqwPoTQy6mxBqfew+1RbyHQg5DqRHGLpkSaa1zUQ?=
 =?us-ascii?Q?C/5mABxe4GyYfWUuPOsdCCS3PN7tmmCqOqEslQ6t7Qr656xWuksksH1y3ydD?=
 =?us-ascii?Q?gfGDTIj+8gTD1XimBKPOoRCDTy1ns5QGpwddmAoFIKxX1CJa678JBvd/2AQn?=
 =?us-ascii?Q?+hX20N/fATVMc2QMk+99om83HvNGTE3zsZ8f4eqbMnv7T86W6MLdWKW23ltW?=
 =?us-ascii?Q?+D9orZ32Lk3s/WLOTm6JAhqSqJb4uwOHcUT+dfXSlfATpUhNIO6O3CDET/tx?=
 =?us-ascii?Q?9BEFynQ8WG+C2D+LXMkCkBHkQyXqeH1IBfiovEHKux0xB4OwtnZQLlYaw5PB?=
 =?us-ascii?Q?e58NcpzAUQKYP4/CHlJkqVxrdTY4baZewOCaeiyYxe3NCcVRFUIe7FQELxim?=
 =?us-ascii?Q?c88h9QtUznfDiv1Wj1bqM2uAMdTL2pQO6J5T2pDvVKuk/Yo3qI5230Ze2pSF?=
 =?us-ascii?Q?FWUX7VKJtd6LvLtp3Ye77QUDPcWdiBWduAMNSnpjhbBPzlOdq5FAPnUmBleT?=
 =?us-ascii?Q?xf8VoKcq7f0HhM0m0KWcJ7EKNqinQhEDOChz8xqcafOPo//T3fJTB3tgtHBp?=
 =?us-ascii?Q?i0HL+hRRfNztGLWVGJIaMc9lQi/XrLkLyzO+93u17CyQcIrfoRsA2T+dO9Gy?=
 =?us-ascii?Q?9b0rKuhM0INhb7W2Q2lERk3mmSwkFCAQWJ1VYklN9vdx3xAFqYlCKYnXYAPi?=
 =?us-ascii?Q?JUWyUjsaZP5BXhmsBhMor5ZB0+JOZV/DCk0igdjnObGG2YzlhdJ5ZB9V6RGq?=
 =?us-ascii?Q?8nJUDe0L6LDHIgBfduhfPbzAtRzALYhXOJ3+zkqyxp8nvf94kteAHBeJS5QH?=
 =?us-ascii?Q?Hi3ZJrV24OEkIIjNe9biBL+WWsuBqwsrEKr7Mwz9vR+zU9O4kTdx3tx7mwVu?=
 =?us-ascii?Q?Yfe6JgQW87JvENsLalLy7emCrqNhmsIAL5PdCtCZXOOik8XorxHwbiC3yK5X?=
 =?us-ascii?Q?PcKlPaoBG+d4u7704bI25yyJX/Z71JpEHdOT4NnuWCn4G6fw4CEZOccBUFbP?=
 =?us-ascii?Q?9h1ECyAOVL+d1R/EdcQeg78HYHOKok/gynfmFfBPQdC41nplb4wpHqDtXLtD?=
 =?us-ascii?Q?FBxEpee5WjIglBO/boblzzI66YaAscr+yV3CvXNmDoFHhJJ9yMV4PWBETFm9?=
 =?us-ascii?Q?JpLdvbkV3688nzSKSueClqXrHbzXjwe4Kkje0/UjoVtX1JB8vWEmanvlTchB?=
 =?us-ascii?Q?0AUQcpMpcBOl+GErW5N2YgPPKWKuE6o=3D?=
X-Exchange-RoutingPolicyChecked: o8lw+WKWUiQhOxQBgUKCXCtKdA+LbrLx9yMRjX3eMJ86nFBO8vqZ1x+RzIOda3cSMAOjzXHaI/I4rJxzY1F5TcNGtkX22eR3jEqDBY1mUQQtJ4LiF7nZDhCQ3bH+n3/e4T+LP0ivzUW/tCRTX+kbA71D6rluMYLpqXjzrm1MYSu0trVHvOdP0ia+RIAwkZ0dNVEmRO5OedS8/wmN5KkM43jmpECEwJJfogRDGf0c1JuWsuNpmjPmtbq57mWEB0wpFKip4RVm7vtTctp3ktO5WikEzj/+rY/Ix/+xZQ+3DcBQK7eMDn8aqmRiVhuTmGMLPn2ekmjdj9KTtk1GJ/5htA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd2c4bd-b577-4ec4-993b-08decb7e3d83
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 08:06:59.3927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sicsXOwRT+bud/jKSsyhOcWMSletIsNR/MVk9ZX25wfE68v5DU9u78kwR8JITiljpHu62MPyy6hmLEF8p4+K/RUdDF/IT0YgJw/Cs6VaZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6141
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

On Mon, Jun 15, 2026 at 10:33:15AM +0100, Bruce Richardson wrote:
> On Mon, Jun 15, 2026 at 10:17:41AM +0100, Loftus, Ciara wrote:
> > > Subject: Re: [PATCH] net/iavf: fix scalar Rx path zero-length segment
> > > 
> > > On Fri, Jun 12, 2026 at 02:35:31PM +0000, Ciara Loftus wrote:
> > > > When hardware CRC stripping is active, a frame whose on-wire size is an
> > > > exact multiple of the Rx buffer size can cause the NIC to fill the final
> > > > data descriptor and place the four CRC bytes into a separate trailing
> > > > descriptor. After hardware stripping, that descriptor carries zero bytes
> > > > of payload.
> > > >
> > > > The existing CRC cleanup code only handles a zero-length trailing segment
> > > > when software CRC stripping is enabled. When hardware stripping is
> > > > active, the zero-length mbuf is silently chained to the reassembled
> > > > packet. Forwarding such a packet causes a zero-length Tx descriptor,
> > > > triggering a Malicious Driver Detection event on the PF and resetting
> > > > the VF.
> > > >
> > > > Fix by adding logic to detect a zero-length final segment when hardware
> > > > CRC stripping is active, and freeing it.
> > > >
> > > > Fixes: a2b29a7733ef ("net/avf: enable basic Rx Tx")
> > > > Fixes: b8b4c54ef9b0 ("net/iavf: support flexible Rx descriptor in normal
> > > path")
> > > > Cc: stable@dpdk.org
> > > >
> > > > Signed-off-by: Declan Doherty <declan.doherty@intel.com>
> > > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > > ---
> > > >  drivers/net/intel/iavf/iavf_rxtx.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> > > b/drivers/net/intel/iavf/iavf_rxtx.c
> > > > index a57af7faed..86ebb2618d 100644
> > > > --- a/drivers/net/intel/iavf/iavf_rxtx.c
> > > > +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> > > > @@ -1716,6 +1716,14 @@ iavf_recv_scattered_pkts_flex_rxd(void
> > > *rx_queue, struct rte_mbuf **rx_pkts,
> > > >  				rxm->data_len = (uint16_t)(rx_packet_len -
> > > >
> > > 	RTE_ETHER_CRC_LEN);
> > > >  			}
> > > > +		} else if (unlikely(rx_packet_len == 0)) {
> > > > +			/*
> > > > +			 * NIC split CRC bytes into a trailing segment which is
> > > > +			 * now empty after hardware CRC stripping. Free it.
> > > > +			 */
> > > > +			rte_pktmbuf_free_seg(rxm);
> > > > +			first_seg->nb_segs--;
> > > > +			last_seg->next = NULL;
> > > >  		}
> > > >
> > > 
> > > The vector paths also handle scattered packets (via reassembly). Do they
> > > need a fix for this? What about the other drivers that work on the PF, such
> > > as ice/i40e?
> > 
> > The vector paths use the common ci_rx_reassemble_packets which already
> > handles the zero-length trailing segment case correctly. When
> > crc_len == 0 and the last segment has data_len == 0, the empty segment
> > is freed.
> > 
> > The ice scalar path had the same issue but it was patched in 2022:
> > https://git.dpdk.org/dpdk/commit/?id=90ba4442058a14763e57ca96d03ab1e6044e3e5c
> > I cannot reproduce the behaviour on i40e hardware (either PF or VF) so I
> > don't think it needs to be patched as the HW seems to behave
> > differently.
> > 
> 
> Thanks for clarifying.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
Applied to dpdk-next-net-intel.

thanks,
/Bruce
