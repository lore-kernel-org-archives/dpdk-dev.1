Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C0E7E0C2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 10:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A21D402B0;
	Mon,  9 Feb 2026 11:44:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D30354027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 11:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770633846; x=1802169846;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ziE7vhMl4kDXL0OICCX4G9DtLILN5jpNBWhJechwGg8=;
 b=XwlLptPO1m/JyFIwtq980GlbRPLpgT+o/oQ18MxYUbT9mYQAyRMOUxJT
 DEaEOaTQOtjN7melF3YDlncAqG6i6vyo7aR7yb99OuDZIYbJw9ioqNCPp
 2r00ANp9RBayA3VG5YrIbf34jHUlGn4ahBSMeGg4YS2jyIf5KA1a41GFz
 /9WdLuwCfmMghWZe9SAEkDwMLR+HGr/OfuxDMDPyX6ZXW5GDWD9eOJwPD
 WrULpdW3mys2jhyLZ2nHZcwsG1CYOQ9bGmbKLx2LaLrDXe0MF0I9tkTQf
 YfD2p+iFExsnEL3UKIdOUTiDwopoc+uxBrSHKpClU5SlvhuuQDlRApByQ Q==;
X-CSE-ConnectionGUID: 791byJIFTJueYj/engWOuw==
X-CSE-MsgGUID: 59Mw/8cZRKCLY2G9FWNcyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71642833"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71642833"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 02:44:05 -0800
X-CSE-ConnectionGUID: 2AhXuakDTfafedr//EFKrg==
X-CSE-MsgGUID: oovazG/vTPaPm2ELTFSAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211613081"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 02:44:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 02:44:04 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 02:44:04 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 02:44:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8CpVPK/s+1Ae8ZnjU4RQbDcXglA/vBTnITXUXgYT/pEv7XLtbvRGCqumvqxfB2UjbIlyXcImzq79QgdmwxC8Qvf+hgJvxh6HO853sMNDSRQbTnvIEPkPXvBh45TTjB/bR4pTg1bLBOuerAxOkjNJ/unyiLy93OPWVtUguT81fez7P8sHMuxToHxSybG34g54TVwXDdVLQahPiZDrQhc1kabLE6A1mwe61cBUg4w8agIQJuut57DPM4/Z+z9az7eQXaMeRi8i/VgmENU2A8484QFZj7EH6mLH4ms4TVwGFhMKXnXpkxzcMzttnbrW7adH0VVKgUI0MDIKoYDmGa2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auFX/AHvnEe80HUmSlq45qv8BJDDZLUHQ+JMiPxhLvU=;
 b=xvBG7XPTK099S+ZZ8nBYd0XBhMjBBAnYDLjmmeHn6O9Edd4osqeOdrKOcOqhoYEvt93nmNdNkaxV+ixxG6xVl6XfKwESz0MRdf/b/+IB1DI2ZQfBfCtaYUnP6nRchddEJTPUVvdp6UnKwfJcC6nZ7CCOfNX3RXdfmnbC6t+2NEjdcQRFkSEJNOV5FgkZXT6t9RfMf2rkPrzihoHBjKAp1P06GqKmnHMxoF6Ysb5ONL0VKDuneyKT8Nh/zEUaNflOxiPgiN6qdE06m3Vm8AViEOi9y3dhUx7Y7Ue3dXQy6/iIgAua0JqNK993fAMFfRx5cr3HsZu+1xYc3jZkca8evQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:44:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:44:02 +0000
Date: Mon, 9 Feb 2026 10:43:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: Re: [PATCH v3 04/36] net/intel: consolidate definitions for Tx desc
 fields
Message-ID: <aYm6beRUlO3FAWNh@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-5-bruce.richardson@intel.com>
 <DM3PPF7D18F34A112DCB681050B200755078E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A112DCB681050B200755078E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 63efd99d-d948-4470-44b3-08de67c8235f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2CeFqvKojLmsmIfoLdbrG/6p/ehdYdFrX1wBSiaPTwAhuRQ7NmiEXLQFU062?=
 =?us-ascii?Q?XmH8/sg3T0Fh7qlfbVt47WG4KihnNgHz/3/HvkBiv9/tq8jqBedbi/i8lkz6?=
 =?us-ascii?Q?7IC8Qv+e6uQNUr8xdToGjLQrKuNLKPSssP8jI9TFNB2AO43Y8EItBTCj4ARX?=
 =?us-ascii?Q?AsAcRG6aWrGDcA5+7MNgp82ykpKiuddwSWHj3zQMtwFCWwREY+SAvB0LMO34?=
 =?us-ascii?Q?R9/Wn8C4T4O2wlcmjZGDA2B+s1JsTSWWFK4w4oGpqZ86Za9zBnClaN0lgmPf?=
 =?us-ascii?Q?rzt4O7PRg7LK+mrcQnZbU2CB8FcssKSUKQG4gKgNQVTEXHIeBp0ex32wtRdU?=
 =?us-ascii?Q?vssbjUrPxQQQ46NhgmxxOdnuOtudawzKnsn4x8BnXFwjD1HfyOiDRN0WvPSh?=
 =?us-ascii?Q?AYD63dWvGqGwIOddmxSk2S3k9BUJ3VOXc8Ajz/4uyA/CdrJ89xJ9nsqoZDGo?=
 =?us-ascii?Q?qJJTH0f0mdtrFnOQc3bJhpIEbZehuTKOlM7+Gv3fqAkn+lC0N9llTysos69D?=
 =?us-ascii?Q?P23I1NRknYQDuqKnRNJrZJFemgQo1QSCzVx3IrvBjXLqhea9hJwibJglg8Db?=
 =?us-ascii?Q?YqkNjI6tBr4NxDwXEUFtFB7Woi4ONUftjIjr1OkKSvtdpO0KSK4W+mhT7y45?=
 =?us-ascii?Q?o+gR61Ooe782sLxdRe41XpwUpbSnp3zZQK6vtNSlbEoKUUQl0u1Sc9vHmq4W?=
 =?us-ascii?Q?ksZraX2TISArDGswOcoBFpOqoQEANYWR/zRb3/imNuA1ka944nCZ95SpRKXo?=
 =?us-ascii?Q?ikSCqFaGRGG/y02vMJIDz3PJzakClfzaQ8tdL15PwZcKWhlb5tUrz5esGI85?=
 =?us-ascii?Q?h7fMfIfBB1gK0noLYPvmQ5BpBsDdAS41mb+HvpsY3DKqlD7sWFdhPWufembs?=
 =?us-ascii?Q?gXFl60BTuKU8PpWpTQEJX7cS4rbXdKae59ezt2gpxFWUoDyyvqFc85E8H64z?=
 =?us-ascii?Q?MAHUABuZjgtDjqIQuAzizgctSsxD4/ZhTJyX7uz55zBdNoWM1GmGy4VrPCsb?=
 =?us-ascii?Q?D0+SAqedNW4Jpfefuxt1j04ZbBFDqz98KJOBcocKnmUSVSycRj9WAPaJPqiL?=
 =?us-ascii?Q?zYX4Mva1/qKv1MgIr5mr2F3AcZnoKkdDeQyOll1LodQnRnLE/V6wR1TpxCaH?=
 =?us-ascii?Q?xv8n9PLSI9OyL18U1MU51MNc0dnqIEGj/I3gYr/FrnIJWCz5pw43oJ+CWpLn?=
 =?us-ascii?Q?QsjL4ZKOfc/EmwvCXWQ1/vBoOWikg48YXrddFotfhZ0PU8brKVZT7Qfa2woh?=
 =?us-ascii?Q?NY/oJqiHb4q27H5WblCWo7eWr67tRmyATi2KRERvbZFq5rJe/SzywBKxA7eo?=
 =?us-ascii?Q?Z6PrwgtxTfPJpjLWd0VvtAR/RsMIKvGZRbGn9iQJaX5h0St0joSgOf13AffQ?=
 =?us-ascii?Q?2CpvPjyIqJuE/ReT9ftYBmSEBGXGQzq/zem+cflPLXNyy2hNcff+rpqxX7Zr?=
 =?us-ascii?Q?0wKGLLfuJaMKQGgvds+Kq4X1MCbURwuEG0oK199hTWtGyphODWlmeLC2ojow?=
 =?us-ascii?Q?RQQDmYWABIDqFfYTm72UWsOYH8PXosLTZEQdLUJiajqDx0apd4QYwK8jpSkW?=
 =?us-ascii?Q?LbTc58uA0YtTxNLaMyI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oaYOCr7pktGyo3Nlg3esqiG2jylBzBOJMsBowm9acC0L7C9r4G7C0gh0phpB?=
 =?us-ascii?Q?4qwo71Of63+Q9W2q2aSoHxLmBN1nSUmv+SC3JSk8MpaQuv0wFu9mZiL0KnaK?=
 =?us-ascii?Q?xK9Uhtnw6sqznCHCuyhW3DS4ouY/aF8RSsQzFetwd3ns75+TvtmbVT+W6KTA?=
 =?us-ascii?Q?QwcC6uDMHaWmhhCmITLPx+vqdDRr1h72sfWfSRJK0phpFeP47CK0kUetE3oc?=
 =?us-ascii?Q?eAts9MP8e3F2zsHSunOE0cMnK5/vb/JxqhbJyl8YZk73CD4iVPQY+7hNsCWk?=
 =?us-ascii?Q?fttuOV7noObeRAuCD2buZRW0IbH+lTRlrM367XC16pKk4dH2TqNkLq9ekk6I?=
 =?us-ascii?Q?D4Fg8W6HZibgCSUyVzFYm33iTQQAlidi8/az/r/3HJ6lDD9vhJbQFzNLp3wT?=
 =?us-ascii?Q?Bsz363ZMujhnTtJONxnvkDzn4n82PHr3oCm5lelWs2bXXTStTANaGnN41Smj?=
 =?us-ascii?Q?9PL8n79eSx52JFuOCNOY082R7Do9RsYWP7kdoT+5+4kFYtqEGrwUBLLxZlkO?=
 =?us-ascii?Q?7LJnCHiMRKK3q5jDqVqWYDmrCbPadoio/3hwvvIuqg00rGJ3q+N3Ex1aAMub?=
 =?us-ascii?Q?zKYusRi8H9wmkXkJhsi3HYyGW75w/8/HgmIVAnvaTUzHTh7rH/AkV06I2Cdc?=
 =?us-ascii?Q?IZNBKl8TidChVBraW4D/M1UTE7ayxp4M6anJeuiQXi6S9PbYIrTGCtEyEZZl?=
 =?us-ascii?Q?kPIQiI9U7q/6dvgpEn+6MbGuugqwQmr9oUEQDKvElBEyK8/cHzVUQIvCh7yB?=
 =?us-ascii?Q?Q1+0HXeN9CTmPWs7w/c8aj/e1sNZkoih8BkCycdWeNj2Z+hp42SnNX3A5aJB?=
 =?us-ascii?Q?E79cMhR28HNIAqDxK9AbA1aVotL6ynaQ57LP+JRJd/2/ZKlLAzJWlf1ox03U?=
 =?us-ascii?Q?hw/P/lOyetk2XhTUaxPThUoBlUPwfQLZZholXiVjnG80FtGICj7iQVJzAu3d?=
 =?us-ascii?Q?cMD7K2mt6BlZe7dWZArrnzeT9zw9s3RgYzvFBr2JTNpSNxvJw6W2ULlFCPFL?=
 =?us-ascii?Q?REJmUleN2J/9TCp9YPEdvUre2MJuzeqFlVcHGQ5kxHAV8KYRWJ4+wwu4SDaU?=
 =?us-ascii?Q?b4E97vk5pp1mgwy0xtVgdvZPUszrKS/Vdnm3qIoP5zemLQOBZYSK/yeZ0QVa?=
 =?us-ascii?Q?5m9D+dnva8HsNrd9ya1pl7SvOmPvIhZ6RrBLNPHQeTHvc/08HXjyqCRX4DAQ?=
 =?us-ascii?Q?R3GW3RnIWjOcLOPsgD5Vf8BiaNrjs577UtedCaLV7rM/CB2ij12ScIFTXhhu?=
 =?us-ascii?Q?KszkmMWp4a+69R13SQWMxnuMLOBlHhBPXN6cGjNPwnJlJ3mJXm7HRRovvUuP?=
 =?us-ascii?Q?1/n+eMU3oLKfAFrj+lkyVVETFXyH9d/ivFOc784P8oIuu7YYAmOOlCueGEL0?=
 =?us-ascii?Q?12WHJHS8G/oDXsrfjpP2LuGm77154mifF0GHTmS69WlrI+UX6LXDVQfhbebN?=
 =?us-ascii?Q?hnpMHdGqT22KhqkQxjxgAynkPELU4GEWYVvetd8iYNofOCxCE83+DMwp8kNu?=
 =?us-ascii?Q?5r0vCPlHx1kX8F9X/pD17caCqZ984NieiBYKWuLb2PF13n0owopXtssbu9ea?=
 =?us-ascii?Q?L+wmNBlMQiw6YU08fYLwHAmE4A3wgYf36SW4V43Q7W0zaMqbPgdxaNJ6YCuK?=
 =?us-ascii?Q?ugE4z96dzSDopLWTz/I/ui/bv1OGXCkZWCjpq16LJpKvvinEWU3Pttqt6WvQ?=
 =?us-ascii?Q?7MXOo4yBQjp+Yb/s628bq6oXxjjTaPV+B+NB7Pr9XNnuPRPInTvoTT2yDExW?=
 =?us-ascii?Q?zgoFA5A3nZv3NiR37JUBpX/3AAh/+uE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63efd99d-d948-4470-44b3-08de67c8235f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:44:02.0178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASX6Que2IxIlef4ew4qa5ZaapyOsKUMuIurNClUV6/UOOqpLhE30+qN4RkqDIXwW9f3L++5Iw+9Y9gBFVCBIlcUJhpL8b0prnpx2F9ZmCjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
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

On Fri, Feb 06, 2026 at 10:14:15AM +0000, Loftus, Ciara wrote:
> 
> 
> > -----Original Message-----
> > From: Bruce Richardson <bruce.richardson@intel.com>
> > Sent: Friday 30 January 2026 11:42
> > To: dev@dpdk.org
> > Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com>; Burakov, Anatoly
> > <anatoly.burakov@intel.com>; Wu, Jingjing <jingjing.wu@intel.com>; Shetty,
> > Praveen <praveen.shetty@intel.com>
> > Subject: [PATCH v3 04/36] net/intel: consolidate definitions for Tx desc fields
> > 
> > The offsets of the various fields within the Tx descriptors are common
> > for i40e, iavf, ice and idpf, so put a single set of defines in tx.h and
> > use those throughout all drivers. (NOTE: there was a small difference in
> > mask of CMD field between drivers depending on whether reserved fields
> > or not were included. Those can be ignored as those bits are unused in
> > the drivers for which they are reserved). Similarly, the various flag
> > fields, such as End-of-packet (EOP) and Report-status (RS) are the same,
> > as are offload definitions so consolidate them.
> > 
> > Original definitions are in base code, and are left in place because of
> > that, but are unused.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx.h                 |  64 +++++++-
> >  drivers/net/intel/i40e/i40e_fdir.c            |  24 +--
> >  drivers/net/intel/i40e/i40e_rxtx.c            |  92 ++++++------
> >  drivers/net/intel/i40e/i40e_rxtx.h            |  17 +--
> >  .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  11 +-
> >  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  22 ++-
> >  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  38 ++---
> >  drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
> >  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  11 +-
> >  drivers/net/intel/iavf/iavf_rxtx.c            |  68 +++++----
> >  drivers/net/intel/iavf/iavf_rxtx.h            |  20 +--
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  41 ++----
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  80 ++++------
> >  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  34 ++---
> >  drivers/net/intel/ice/ice_dcf_ethdev.c        |   2 +-
> >  drivers/net/intel/ice/ice_rxtx.c              | 137 ++++++++----------
> >  drivers/net/intel/ice/ice_rxtx.h              |  15 +-
> >  drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  41 ++----
> >  drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  39 ++---
> >  drivers/net/intel/ice/ice_rxtx_vec_common.h   |  41 +++---
> >  drivers/net/intel/idpf/idpf_common_rxtx.c     |  22 +--
> >  drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 --
> >  .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  41 ++----
> >  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  41 ++----
> >  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   4 +-
> >  25 files changed, 408 insertions(+), 513 deletions(-)
> > 
> > diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> > index a89412c195..03245d4fba 100644
> > --- a/drivers/net/intel/common/tx.h
> > +++ b/drivers/net/intel/common/tx.h
> > @@ -10,6 +10,66 @@
> >  #include <rte_ethdev.h>
> >  #include <rte_vect.h>
> > 
> > +/* Common TX Descriptor QW1 Field Definitions */
> > +#define CI_TXD_QW1_DTYPE_S      0
> > +#define CI_TXD_QW1_DTYPE_M      (0xFUL << CI_TXD_QW1_DTYPE_S)
> > +#define CI_TXD_QW1_CMD_S        4
> > +#define CI_TXD_QW1_CMD_M        (0xFFFUL << CI_TXD_QW1_CMD_S)
> 
> This define is unused in the series.
> 

I think I'll keep it in for completeness. The definitions all seem to go in
shift-value and mask-value pairs.

> > +#define CI_TXD_QW1_OFFSET_S     16
> > +#define CI_TXD_QW1_OFFSET_M     (0x3FFFFULL <<
> > CI_TXD_QW1_OFFSET_S)
> > +#define CI_TXD_QW1_TX_BUF_SZ_S  34
> > +#define CI_TXD_QW1_TX_BUF_SZ_M  (0x3FFFULL <<
> > CI_TXD_QW1_TX_BUF_SZ_S)
> > +#define CI_TXD_QW1_L2TAG1_S     48
> > +#define CI_TXD_QW1_L2TAG1_M     (0xFFFFULL << CI_TXD_QW1_L2TAG1_S)
> > +
> > +/* Common Descriptor Types */
> > +#define CI_TX_DESC_DTYPE_DATA           0x0
> > +#define CI_TX_DESC_DTYPE_CTX            0x1
> 
> This define is also unused, although there is scope to use it in
> patch 7 net/ice: refactor context descriptor handling
> 

Will investigate. Again, even if unused, I think it is good to keep for
completeness.

> > +#define CI_TX_DESC_DTYPE_DESC_DONE      0xF
> > +
> > +/* Common TX Descriptor Command Flags */
> > +#define CI_TX_DESC_CMD_EOP              0x0001
> > +#define CI_TX_DESC_CMD_RS               0x0002
> > +#define CI_TX_DESC_CMD_ICRC             0x0004
> > +#define CI_TX_DESC_CMD_IL2TAG1          0x0008
> > +#define CI_TX_DESC_CMD_DUMMY            0x0010
> > +#define CI_TX_DESC_CMD_IIPT_IPV6        0x0020
> > +#define CI_TX_DESC_CMD_IIPT_IPV4        0x0040
> > +#define CI_TX_DESC_CMD_IIPT_IPV4_CSUM   0x0060
> > +#define CI_TX_DESC_CMD_L4T_EOFT_TCP     0x0100
> > +#define CI_TX_DESC_CMD_L4T_EOFT_SCTP    0x0200
> > +#define CI_TX_DESC_CMD_L4T_EOFT_UDP     0x0300
> > +
> > +/* Common TX Context Descriptor Commands */
> > +#define CI_TX_CTX_DESC_TSO              0x01
> > +#define CI_TX_CTX_DESC_TSYN             0x02
> > +#define CI_TX_CTX_DESC_IL2TAG2          0x04
> > +
> > +/* Common TX Descriptor Length Field Shifts */
> > +#define CI_TX_DESC_LEN_MACLEN_S         0  /* 7 BITS */
> > +#define CI_TX_DESC_LEN_IPLEN_S          7  /* 7 BITS */
> > +#define CI_TX_DESC_LEN_L4_LEN_S         14 /* 4 BITS */
> > +
> > +/* Common maximum data per TX descriptor */
> > +#define CI_MAX_DATA_PER_TXD     (CI_TXD_QW1_TX_BUF_SZ_M >>
> > CI_TXD_QW1_TX_BUF_SZ_S)
> > +
> > +/**
> > + * Common TX offload union for Intel drivers.
> > + * Supports both basic offloads (l2_len, l3_len, l4_len, tso_segsz) and
> > + * extended offloads (outer_l2_len, outer_l3_len) for tunneling support.
> > + */
> > +union ci_tx_offload {
> > +	uint64_t data;
> > +	struct {
> > +		uint64_t l2_len:7;        /**< L2 (MAC) Header Length. */
> > +		uint64_t l3_len:9;        /**< L3 (IP) Header Length. */
> > +		uint64_t l4_len:8;        /**< L4 Header Length. */
> > +		uint64_t tso_segsz:16;    /**< TCP TSO segment size */
> > +		uint64_t outer_l2_len:8;  /**< outer L2 Header Length */
> > +		uint64_t outer_l3_len:16; /**< outer L3 Header Length */
> > +	};
> > +};
> > +
> >  /*
> >   * Structure of a 16-byte Tx descriptor common across i40e, ice, iavf and idpf
> > drivers
> >   */
> > @@ -286,8 +346,8 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> >  	desc_to_clean_to = sw_ring[desc_to_clean_to].last_id;
> > 
> >  	/* Check if descriptor is done - all drivers use 0xF as done value in bits
> > 3:0 */
> 
> I think this comment referencing 0xF is out of place now that we're not using 0xF
> rather CI_TX_DESC_DTYPE_DESC_DONE in the code below.
> 

Ack. Will look to update.

/Bruce
