Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DC1CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:33:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFCFA436E2;
	Mon, 15 Jun 2026 11:33:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6DBB3400D5;
 Mon, 15 Jun 2026 11:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781516005; x=1813052005;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bU7GaIp80FiymbhQG7oQcAOwk1WqbVKjfmKTau4Iy5E=;
 b=as4m20FJqxB3p3JSy1aJngpuycks0J/HjcjJppMfbkaDHe1/5GDszgo9
 /uSRQNcd+8JE7Lc1yjCb/mBqTEu9sCnu2F4EsFmlYY2Es2mFr+SVDoqF/
 x6L7Pp/Opl0Tq6bWQFqZ/EpyGY5P1jwICVosWBwzVn0/yjVRo7j07pVIG
 ZYEtnfCuqqB1iNl5LnZURbamD7pweFrivCl6xU6uaiz3PdZwpEQnl7BNA
 TTKPrP98QDJXMgLvUq5ru5h4QEBtrctUCusaDyGeHNqcuhPZ0gB1QfWdq
 v4EKC8Qk1fxlhcXBJHMAG87AeyCqrjUFeAxQeMqKu+xPmnPAKWJtnDq35 w==;
X-CSE-ConnectionGUID: o8i/U682TH2tWvGM+NoG2w==
X-CSE-MsgGUID: RikEmx92RGGHu8d58p3aaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="92923816"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="92923816"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 02:33:23 -0700
X-CSE-ConnectionGUID: whCII4kARMG3SWO+mYSIqQ==
X-CSE-MsgGUID: NKGNk4VHSEmriBcTBqIUQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="247510715"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 02:33:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 02:33:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 02:33:22 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 02:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk6nUHVpxKMfIr2wxBq57WR2fNVKJIzoP/5LbMnfdvBtHGvgbjuQzytnmjw/6IQwOZOnPbZ3f0Ptf36RoPE50+no/K/rDzQaSJjdzjoYP0g3+MV8U4iR+1Gjy455i0y4fODBq8wIsOfLlzBbs7KoKpCKiNfLAyRhpm5Tm3iObr+1Q9OWdEY9aLZZGtAaoc2xmTL9ACI14ciC0k0sFXSlvdMa8pJjoAT8HDvjjUuY318lAKVmJVWdjzsjS2pacYteEp4Q5SJTQwfurPYzqFzXSV5ioK8eNJnzLw2b+ltLONpxBgdRxRk6K0GD+2EsZFvWN0jzD1UVxKhJq/7w/YZgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMM9+E+AJXN9czft6jUAoaLIEXDtnW5pYiI5uqfAYnY=;
 b=yK9thY9CaBMpMxmU8ivoEehFMxJK4vUJDZoWKNfgmw1y0CJetCbqsBoRGZrUlf71GDiq8OwfTi4i0NUXJZgUTSbYtuCBmsO6BucLBVN+tpNOY+3wd2aCBAV+rzkJ0qMi5QucQSB0ujeGmds0JiGf7BuaUevJn35n8EgRKnB4pLBVObY3GvXwuE6uAN+CHjpYrybmud4Ay+GzNEMvG76smdk7ZxWgJyycgRHXMPpQHymQp2w/MQeWhkzOyUTrtJvhF3vyNY72Ry3Cw0rBVcfpvX2hIInSJkKhaqO67+6ZVOZ3tUS0px5zm5DZ9selMt99pxs2Qf+L42ppWwcX4y99Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 15 Jun
 2026 09:33:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:33:20 +0000
Date: Mon, 15 Jun 2026 10:33:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Doherty, Declan" <declan.doherty@intel.com>
Subject: Re: [PATCH] net/iavf: fix scalar Rx path zero-length segment
Message-ID: <ai_G2-sLspd2PdK8@bricha3-mobl1.ger.corp.intel.com>
References: <20260612143531.2265914-1-ciara.loftus@intel.com>
 <aiwo_4aTWi8kBIkG@bricha3-mobl1.ger.corp.intel.com>
 <IA4PR11MB92788A2FA65444A5BDC62C0E8EE62@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB92788A2FA65444A5BDC62C0E8EE62@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 64431e10-2e6e-4895-1df6-08decac122f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|6133799003|18002099003|56012099006|11063799006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: d9xe2FLBOCxQipSy5Lg8fX1V/g9qWs5F8CzLh6ZASBzfqGsKGGiOVNxi8XgDEH8/0nCRyXJtlbVesE7BeLToMgmsor3Ou3jGt8FKBKW3OutAYZyVnhggsiikFyRb/aP9HRwrCGRjfP2yQEEgb4jMzBBXxZKOFXmB4asnUZ4ylZ0dNqwKFNy+VEIORg7O510LQ5Nu3SP4A/WGw/Go9qI+5fD0DBRoRB5MXbPF+qEmfdspJvs4D+BfNAvYvXp2ONEyqi7NN5h1ML8bqsbQa7P3kwNS8LwDaXvNcOtf2md7LwvAeIxkF74qwN/t1BTIDZMlHf/M2tnTXR5BZPfRg5akHDfx2hiEIqGgEFrpDBNapOyeZwnbAaA5r7E+bDrFqqzrnPyRRNrqYBOF3IBNz+LamHCAA9GOCdbdl+Q4T2XE8rcozI9hAlRQQDUcg4vL7pm2YdzUcTJpNNLj76npjdXZJVMvidLw7lpGYMXmYWhtdGLpLMzUcc3ZKXpsBCV1UdPFyxdbpJqbzcifnI3yprw2kTPO7ipmXFJOuxSe6yGdsVfo2MgTGCrbDP1AOdN+KuGpTlUcRDXPJJG5Lccmy6eb+gE2gZ0uGBj6N/7d4Ma103ALLgn3gq4Bh57x0iqKG+OF5682Tsg5l5Z36uetdzol/V2jwfdME4OGUgsJIUUnEpjFgGNnVFzP6xv6+APRQMtK8fR30rbNYEF915oZK3HOcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(6133799003)(18002099003)(56012099006)(11063799006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cXYdwS0fZStRso0NL+hDC85WlDsZ/dR4NwkHpEwpa0UCcIpw1dZNwc5cQ55k?=
 =?us-ascii?Q?ZJPoG0QrbojOWo+F9z0GyKQhCSAM3/y6z/+/M/Fl1pOE5iyPUvUF/UcVuMnU?=
 =?us-ascii?Q?xNq1E1stNKNEUappK1/LUfWR3U5C6DIfIrFs+iFZwp/AxoXJ9DtFre1IL3p/?=
 =?us-ascii?Q?XqtrIeCdKOgegLFTs15mBgwHSFexP4bIpB9tRfmBHJv4Pydf4ZoQm8fjqzk6?=
 =?us-ascii?Q?YrX0nYtTA9G5j5vu3JOEzHEJjRVFQIKbDwUoYcT20NNbrg0brmEofY1R6Rms?=
 =?us-ascii?Q?dBzOGQ/8EcXPCNdBbMKLWbQYjFor77pfLgfG+RowwyjmhGUNXTzMTjUnE0NB?=
 =?us-ascii?Q?jxdUOajiVzAS0i6llIoo2OvPgW/IZC6fI40XfyTY8HdKrkIwa/BYefbV5evJ?=
 =?us-ascii?Q?RnIB63m4scUEDoFzsLvuMR2VvieK9NND2FoVPbfidKRaU56h2CAKq0KG44Qs?=
 =?us-ascii?Q?Rr+qCCAlIx5q3XGq3XT0WSjKbaRIVpuVMOEeVIb4QdWyR9WRLkEqlt9zQB0g?=
 =?us-ascii?Q?UyAOirQYv9WZA5ayQ4u1/n1XEx6vH3uA/UMKGDNOZRu9WZbHytG5YDLb6TuL?=
 =?us-ascii?Q?y2bAW7zckm3r4XntiQJiDrPOeJu2cLwMMqLlTJANdXd3Pe9SMbgrj5TWqKdh?=
 =?us-ascii?Q?MplAAQ78iY5rXlsNL2Jg2QzEWGUT4lD2mlMHGzhlpvsST2s+ocl5Ad5jtvlv?=
 =?us-ascii?Q?BN/moniIQVvANf3A/qR/xqaznnBbgtG8ZSgkk1h1pkBq4Ez1ydyfYBhJCAE7?=
 =?us-ascii?Q?nvtZQqrmGr+hELwqNqj8CP2+E/WGrTvLoesangWhed/q4o8sT22TUCeshXT1?=
 =?us-ascii?Q?R87tXzOHA9B3dyITR7mlf1Ty8zq8THeVvsOX/W52iB8jriD78V1fxFOLpodY?=
 =?us-ascii?Q?ns+yUnCJSGEscWbzG19EyFMQvqBhlA5jhmteE/WsbojZOeDW+lKS1yIhRCyG?=
 =?us-ascii?Q?+EnRyo9NNRpc1GaZZ0TfsOy7MrDCvLpDKB6Vt8bCAP1hT/z/a568yignloUd?=
 =?us-ascii?Q?v73FHBXPZinRMn7t5VSkIHXPVmxp52QtkzG79s+a8MPdM0bGDbAWytW6+ANT?=
 =?us-ascii?Q?O6tOU0Zb3IAgJjmDG1vgjTUu0W3Kc+KQqwUfxfCAXpWLk7dcbwiqSBQu4MEE?=
 =?us-ascii?Q?g4o2sfrOggTswCxdrI9jHvLO4dvuPGzhM/OXN6GmlJUxj0xbUdRv9OlXHLp+?=
 =?us-ascii?Q?bl3J/B+K5Gm0Id5RXoccTJHroeoXK6WLSwrFNx/9t4x6S0V7ALbBiHxgXAUz?=
 =?us-ascii?Q?UGDX4RUqTY0Go0RJuvdvDHjgm1HJoRavhPkeeQJCpz4XTwQpTMPARHAMBPHo?=
 =?us-ascii?Q?/60h6KD2mIX9NqbxBNNtGKNdQenC2TdmHAsCkHd5qKIntn00WGv8hwC+/kty?=
 =?us-ascii?Q?cJNOySs0pyuOIvH80mc/VvDC3Cm/OUwQv9+YR9Fzm3vKCdRbr1Ps6MX9p0de?=
 =?us-ascii?Q?qg8FaSDeQRs3pIwAS3HonnVjiPCLdqJeR/EkmeVLBwkd/PXUp8iPavu+USPK?=
 =?us-ascii?Q?5Ln5a80IPnF8MIVJIjqnumz7aT+jQ5+6Kgfwo8KldVKW+dkal4qy0EIFHEV6?=
 =?us-ascii?Q?C3ABdNarDKbu2z0bWrofn49XcM1Mr39mbFvfA80iLkQz9e1drecG7DHuiOay?=
 =?us-ascii?Q?8GK0yRNv3QFpsVmtWksB8chsTxCdmuFKPbdJHcuj2ujQvEPmTKPTHWvwqKTM?=
 =?us-ascii?Q?5yIwMLVMVT2dKZt4EJWaVNb28FKQeYj9felb4GjDJGKGwXx8lyH47FwQWgLS?=
 =?us-ascii?Q?1b8QnLMbMQxEoZJgr3n/eiohO02uRQc=3D?=
X-Exchange-RoutingPolicyChecked: Dx5mCa+VBdYndVySN7nQDPIUfegJDrBgupDlBRCEu0emZPbHeOcpobL7uqYybAfOhkEvNMDdgtdHVqhU2cQS5RLIXsRmZrCt336pY86gp2Nyg4xk92CDDwbNR2JAOOcgSANVIUVyr3MEKZD/uB14iagUqmXUZx2tvxVvpU43Y4ajbQ2OawNAWjfa5UJF58FYVecRBeCC2v3JBNU6IfDRqFNKAB31aLKmsD9NXEZ1Z+de4027FKi4cnoVfhWDdDLPA5KBEVhqMDUL5fysZKdw2EUrf/NokfP23tVoiZCfEEnm2lQSNcqUTmEkfx1l9q3qVeNWAhurCcuEO8CZdAHcXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64431e10-2e6e-4895-1df6-08decac122f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 09:33:20.0085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We6fdQTE0LOLFrJDJhbMER0cUBCmb5bHBSwzNCXyyooZiRQAkmCYAUbFNPY71i+JGujx2VrzfRmYT1h/RTanf91anRz8lXcalMnuW9TTmZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
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

On Mon, Jun 15, 2026 at 10:17:41AM +0100, Loftus, Ciara wrote:
> > Subject: Re: [PATCH] net/iavf: fix scalar Rx path zero-length segment
> > 
> > On Fri, Jun 12, 2026 at 02:35:31PM +0000, Ciara Loftus wrote:
> > > When hardware CRC stripping is active, a frame whose on-wire size is an
> > > exact multiple of the Rx buffer size can cause the NIC to fill the final
> > > data descriptor and place the four CRC bytes into a separate trailing
> > > descriptor. After hardware stripping, that descriptor carries zero bytes
> > > of payload.
> > >
> > > The existing CRC cleanup code only handles a zero-length trailing segment
> > > when software CRC stripping is enabled. When hardware stripping is
> > > active, the zero-length mbuf is silently chained to the reassembled
> > > packet. Forwarding such a packet causes a zero-length Tx descriptor,
> > > triggering a Malicious Driver Detection event on the PF and resetting
> > > the VF.
> > >
> > > Fix by adding logic to detect a zero-length final segment when hardware
> > > CRC stripping is active, and freeing it.
> > >
> > > Fixes: a2b29a7733ef ("net/avf: enable basic Rx Tx")
> > > Fixes: b8b4c54ef9b0 ("net/iavf: support flexible Rx descriptor in normal
> > path")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Declan Doherty <declan.doherty@intel.com>
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > >  drivers/net/intel/iavf/iavf_rxtx.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> > b/drivers/net/intel/iavf/iavf_rxtx.c
> > > index a57af7faed..86ebb2618d 100644
> > > --- a/drivers/net/intel/iavf/iavf_rxtx.c
> > > +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> > > @@ -1716,6 +1716,14 @@ iavf_recv_scattered_pkts_flex_rxd(void
> > *rx_queue, struct rte_mbuf **rx_pkts,
> > >  				rxm->data_len = (uint16_t)(rx_packet_len -
> > >
> > 	RTE_ETHER_CRC_LEN);
> > >  			}
> > > +		} else if (unlikely(rx_packet_len == 0)) {
> > > +			/*
> > > +			 * NIC split CRC bytes into a trailing segment which is
> > > +			 * now empty after hardware CRC stripping. Free it.
> > > +			 */
> > > +			rte_pktmbuf_free_seg(rxm);
> > > +			first_seg->nb_segs--;
> > > +			last_seg->next = NULL;
> > >  		}
> > >
> > 
> > The vector paths also handle scattered packets (via reassembly). Do they
> > need a fix for this? What about the other drivers that work on the PF, such
> > as ice/i40e?
> 
> The vector paths use the common ci_rx_reassemble_packets which already
> handles the zero-length trailing segment case correctly. When
> crc_len == 0 and the last segment has data_len == 0, the empty segment
> is freed.
> 
> The ice scalar path had the same issue but it was patched in 2022:
> https://git.dpdk.org/dpdk/commit/?id=90ba4442058a14763e57ca96d03ab1e6044e3e5c
> I cannot reproduce the behaviour on i40e hardware (either PF or VF) so I
> don't think it needs to be patched as the HW seems to behave
> differently.
> 

Thanks for clarifying.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

As an asside for future work: we should consider if we can also convert the
scalar Rx paths for our drivers to match that of the vector, where we do a
simplified receive per descriptor, pretending that each descriptor is its
own packet, and then use the reassemble_packets call to put any scattered
packets back together. I would if that would lead to better scalar Rx
performance.

/Bruce
