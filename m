Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5725D58B07
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 12:24:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CABF4025E;
	Mon, 16 Mar 2026 13:24:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A2ED4400D5;
 Mon, 16 Mar 2026 13:24:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773663873; x=1805199873;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=yBXdY8Bp+3YTttBuTIB9HdBjQoSWzZ//ogUGpm3Pvts=;
 b=A10B3qWUprkxmhchI1tpblLRCnPgcnfDbGlJtbFXvq2CJb09CtZ/kufs
 whwyuCNW4k5u2Wlm6Vz0oC4extHeXE23vjZ8L+6fmek/hzn/CMlvdoTqT
 wv70FOOilRV1N8RgpZxjI+Jw8wDQDoMhihT4bVMVlNohavlGHBnjGtcuC
 SEBX0KbZU4r2jtFHFWnzR05rr44bE5MC2exb3RWZnUSlXfb5/xe5+tx6x
 AlsI90YRFjVjUh5kjBdZzETCawexy+A5nXJis96Ku49/YAm7NVbIzkUq3
 RhprGJK5LGAPRU+PXhgoWFCCpXX3HGTXIxAOS1XyV3FzPcjAohrcAx6eA g==;
X-CSE-ConnectionGUID: JjZAH5ZlRXysfjLQ252UUQ==
X-CSE-MsgGUID: 49SythJbRfSGXZhS4+VjdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74864013"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="74864013"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 05:24:31 -0700
X-CSE-ConnectionGUID: GIM+7/J9QT6YBKP16YJ3VA==
X-CSE-MsgGUID: RhZgO9d1TdiHQA7elkGaqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226574557"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 05:24:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 05:24:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 05:24:28 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.32) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 05:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+6k6ryo2HnGJgqCP7Y5pzoh6Ws1tG3qwNG1xzVXK3iRmUpjMQ3ngYg2PmegMjA86dQ6T6netyDEe7IPngMALaPKoNw24Dp+txKrxd7BAXyKtOYlsOEP/gw6+va2xip16GsvkWu8cjKdTFhHSgeZYmHMstC+KS2WdC4DusZOrVhA5pNUkbqRH2wfLznGG6s3tuilXYNFNZPf3fmTb6/GFHjlYNeRLKbbxebgwZhopcu+hSgUjyAL3/Ay1k0l8QCHtbISMXB68bxwiWEVeUmCXacgGzniwlybpX2v6OkYXQOvw8+DWvXWAevReAWVRXPMG4blEE8tHDHU6p5cijbxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zc+PH88yKZOcwYgjzaydkOXPnCx0Ha5y7cd/B/DOIY=;
 b=OCVOJ5Jc/lfcGELNhTlQ1THDPeXN9diIsgvfDLrlhpwBMN7fZNTUJ2o+wzeppEr+x99xgqU6yY66mQVMQeS5osFK6NRls2dMQIRRErX64/RafShE3+TFw255afh2U2yPeGoAO4piS11FpBKXg2E4d9R4rzHb8Vglt8eYTUe7N0gtyaAUogBal1owkneOWxoPMJHRI7EZSBJDCISOMNs7SV9HWW5NIG8Ymr3wJfZ8ax7GgadyAWQNtpY3DybGE6rQe0WqwCZDLIP8TTgxylXWgHKsyTo5jaMmcQb0lsg+clfOM7ncs3ZpWEYP5BVRVwXDpBmZTlGsFeEcYBF0rwA7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MW5PR11MB5906.namprd11.prod.outlook.com (2603:10b6:303:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 12:24:25 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 12:24:24 +0000
Date: Mon, 16 Mar 2026 12:24:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: Re: [PATCH v20 09/25] net/pcap: fix error accounting and
 backpressure on transmit
Message-ID: <abf2cZN9nTohMS4U@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-10-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-10-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0255.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MW5PR11MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f05eb7-8d62-4c85-fc47-08de8356f4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: x34cR+XwEsOGjg3MJICxOszOTfpgT4okUkMUudOsnx+MSbbVCn8t56enIHCtzX1qOP17br4Ky9iy5ehcgii+aDBCU5lABHR/aco12slTxlPzYKipQajcxXsScBu7IJf/PkeIe0zTynJdpszHnnU+l7bKDN+Sj3Pu1ZH4imzdRh1fX8Us057s5M3TwUPQrR1oPk9y+f0+5tcujlkiQIsOTS/Al3Hs5O82ofzBMe4CV+RkRbZDh7qZRWIAgibGSERwIAoEY5M3nDqE+933rA/k+gHPZXSYAkLyt+PaG5KjkMpngQQjrhHW+nTV4f99lv1FY1yhlzg87ZjP+AnGsngmg+KXeDI6HfviLQfiqPIe4XBCI3AWNvK7+/OzJ4pzLvWPCfeQr/OLzFFfF8fZgELkJN6JzIGiXazmMjFcDD/bScu/Fkl4aTbzRqI3w/Um6ecp8AFolegPEcX/LuF+1rWe2nnRcpGvLPXUZhb7ZDQ7xMX1WfQfA3JcZJewogPv74KIHyTgHKPH/3Ns0HIZJLe9zZMaE9lRNJ8Ksw3c6ORwVExoOp95igGm0J0N0t7H5q0y1jk9RI2rknfNXX4oX/htiXJHhgC4vrv/Zv2xa10Pmkj77bzu9QQ5rJ9KMZv/7OCm+fHHE0uy6Ac+i23/rLWy8Oo1HkoE8tjg63GS8IkVZWIZDsh0DBqWVjUhYvdJNcHb4YOrVqHKlLpemoZprJX5zRgZhgaR7g9YlgJbCWk+0Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S85eXce2I/K0Sq7/IEflOVtQglH7tXhlj+YIGq+TQRaMKsUjEFu8xBbeoi+j?=
 =?us-ascii?Q?fptHlBR8UL5EHVZ3VBWRnew3akjW5SGdXfkvAWDPT3EdEbSJv+9cwNeibuNq?=
 =?us-ascii?Q?03qOK0l3VlKylGPs7tA1tX9HULGJfc45VN+ZnOI261cINcjbERFfHa0e60VN?=
 =?us-ascii?Q?ghK96LvpPuI6tl9yyXNK7NBQ8aGPX4LVb04oW2s1oRIUlg3XCBC32iC14NXI?=
 =?us-ascii?Q?AAkh8eo1ev56T9ajuFhUJIEKW5S/tiF20NA+oY6LRDAQb90SWvfWTZCeWcJd?=
 =?us-ascii?Q?PIKzc2olcHuFzkG6c/HfiIdDvFIU8Jrl2BSeIe8OrJPkINND006O2SO2uVDL?=
 =?us-ascii?Q?DW18lmhJyujJm9b0aPsK7u2IZ78gaRuartGzBc0oxiaZXWR8drbC3I+U0f+c?=
 =?us-ascii?Q?vq8o1QIWrc/o233+HXcsECcEuHTFeCf6sa0DPZ00L2DSWvWWunIIG5FBFEqv?=
 =?us-ascii?Q?TM5XEcZDGSMraIFGTB7vdp3CDmbgWnC8wWh/C4aq3QzidZn2tcqoxZbOZSIG?=
 =?us-ascii?Q?AxK7qaqi2tQqSTQjXA0GBeP1xLUu/WmPbCbRJIUd8+2bsdCRSbGVbCyHJaTv?=
 =?us-ascii?Q?1EcZoiCJxbLzKQZPXy1pR4+pAHzxt7yKLiitzcPtyPObfjIzRce0eeQmUFy3?=
 =?us-ascii?Q?MvZfGtHodOV1G6wou7UDTpOz5j4gWNCehbUIo6UfUXaFS7fx1JNPhgsLCSOr?=
 =?us-ascii?Q?7zpmjnm8E8phqVWMTQyV6LnXE/vrY9UOScwq9ZgvaKhGYcIdicZeumPAnDrw?=
 =?us-ascii?Q?V09RSR8RSLnUL1RiflmVS5nxd4uatomx7e03+fMS2EXMPbj4ovlHJlc5exFE?=
 =?us-ascii?Q?QXz8ceWpKygh7L2uIg1wg9/Wg/859e8AFMPjaYIkroiIEa1SdcCbVnMWTAbb?=
 =?us-ascii?Q?3DOg7k6gaR3JvdH2xoeOW77hSnEGGtwc4v4AkIIZaLMLAiQIU1Wy/xUKq+72?=
 =?us-ascii?Q?tEmQzBh3B+wp4YJtKUqooYMmAhzze4xYgIYFNttjLFQiJJezvixdgD9kCRvv?=
 =?us-ascii?Q?/4wymVLIhezVx9YXRVnPsjTyf4fqZs/Gpm/6UUp6ZrrRJknOf+pyxXijgqND?=
 =?us-ascii?Q?dNirYDyFsNdgglOJqHTj38EDJY2CkybLQ0Es2uJYoA8yPMLOmK72vDe0o0iB?=
 =?us-ascii?Q?UG2bTXM+NriOuP/iy3RHiMRY4ZujyatKgE3QhG57PTjoPWuAiUwF1u51FWge?=
 =?us-ascii?Q?ZvT5ha6DKGZSBC2arYlEZeVxBlQGgce0jFvOcK1OpaUQFu9f5IrTUHi7oY2O?=
 =?us-ascii?Q?ziDQuKp6mrsG5jt2IbOvtBAxh7ruV8jY8xztCebvHX9XmoRB2RiMfN81jvlv?=
 =?us-ascii?Q?yWBaS+GhVEnwWcca9y0rW8mWnf2RjC2kDzmVMJrdIhwqhYC/iks9pnkEnBDi?=
 =?us-ascii?Q?2NfJzpL/5PSYcLpr45OoaGOn8I5+5h6IxrcPoZ+FPMImfDPkKso6p5MocJRN?=
 =?us-ascii?Q?fUtb1ChJzPu/vziSqB/PPd7e+7/ZgfmHBhuuhXg6nsNgWeK3AY+Ufaa7tpTY?=
 =?us-ascii?Q?InX4LM3Hk/hvZz+NIc+lcMy+vNyUurbyhZ9zFhcCPgmetjaTjbcwB4H+mczD?=
 =?us-ascii?Q?ZlnitSDLZ4DWN2D+OVuxxTSHdnBkaK2GP49Taz85GOWMbsNUBSGnkgJqRBMM?=
 =?us-ascii?Q?TYx+iEUJWOI/0dAwtS0nTMg8lGqSNVixflhOXeshxzOhcy28TITGTKkkxTnz?=
 =?us-ascii?Q?LIhMvZ2U6jaVr8OK50YDmL6ShZykmsittkyQ8OtUwFc152EI+IoCLyk7mD0T?=
 =?us-ascii?Q?R7wrzZboQucGFW8h8R6LvDrIaO2wq2U=3D?=
X-Exchange-RoutingPolicyChecked: hJ4iz0buttdCYPyFbUg0QsYIt/BJdYzTMW835+ur4CiYg/ESLTV7dF5katlDGIEjxyHguXl7Ka2tNAZjkOUxLxAcjWb4BwuLNLpZAGEVB56YYsjlBIwFMg71f4Hc1+WShWm3A+20H2rtIhRcx1ADw5Jqd0ljseeFYzI7P5aaBWiHuM6Qaz2qmmnSU7Jbj+DrWr47B6r735j/dFHysBcknhwnvjCYLSMhn142Fo0Qhxj0STVY5EqSFTIMua0zn1ylgL+RhPnbPOz8mSep5heccRmQni8u8IB4GMzghqZImeKbvJGAA5boKtGVeHk9lKGCx4AJWaaInZlwUZO4zpYdSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f05eb7-8d62-4c85-fc47-08de8356f4c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 12:24:24.7720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saZfSYLd6ahlmc/fJJ7b6aeQQdgZX6Ogtw9gJ8uzCAzXXMrIQJCTTtPffOAKZa56p5OtZUPFf+noe4r3tlP+3ePlXky5FQ4hJkcy3+CMXZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5906
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

On Tue, Mar 10, 2026 at 09:09:47AM -0700, Stephen Hemminger wrote:
> The error handling when pcap_sendpacket() was incorrect.
> When underlying kernel socket buffer got full the send was counted as
> an error. Malformed multi-segment mbufs where pkt_len exceeds actual
> data were silently accepted.
> 
> On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
> socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
> The send() call only blocks when the kernel socket send buffer is full,
> providing limited backpressure. Backpressure is not an error.
> 

I think we need a clearer explanation of what this patch does, this didn't
make sense to me on reading it. See also comments inline below - I think we
can get a better patch with a clearer explanation by just focusing on the
changes to eth_pcap_tx. If you want to update the tx_dumper function put it
in a different patch with a different explanation.

> Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

With commit log clarified, I'm ok with this, but would prefer a smaller
patch.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/pcap/pcap_ethdev.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
> index 72a297d423..47a050df11 100644
> --- a/drivers/net/pcap/pcap_ethdev.c
> +++ b/drivers/net/pcap/pcap_ethdev.c
> @@ -407,7 +407,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  	 * dumper */
>  	for (i = 0; i < nb_pkts; i++) {
>  		struct rte_mbuf *mbuf = bufs[i];
> -		size_t len, caplen;
> +		uint32_t len, caplen;
> +		const uint8_t *data;
>  
>  		len = rte_pktmbuf_pkt_len(mbuf);
>  		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
> @@ -415,15 +416,16 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		calculate_timestamp(&header.ts);
>  		header.len = len;
>  		header.caplen = caplen;
> -		/* rte_pktmbuf_read() returns a pointer to the data directly
> -		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
> -		 * a pointer to temp_data after copying into it.
> -		 */
> -		pcap_dump((u_char *)dumper, &header,
> -			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
> +
> +		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
> +
> +		/* This could only happen if mbuf is bogus pkt_len > data_len */
> +		RTE_ASSERT(data != NULL);
> +		pcap_dump((u_char *)dumper, &header, data);
>  
>  		num_tx++;
>  		tx_bytes += caplen;
> +
>  		rte_pktmbuf_free(mbuf);
>  	}
>  
> @@ -435,9 +437,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  	pcap_dump_flush(dumper);
>  	dumper_q->tx_stat.pkts += num_tx;
>  	dumper_q->tx_stat.bytes += tx_bytes;
> -	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
>  
> -	return nb_pkts;
> +	return i;
>  }

While not wrong or problematic, the changes here are unnecessary IMHO,
since there is no error that I can see in this function. The changes I see
are:
* change datatype from size_t to uint32_t - ok but the original code wasn't
  really wrong for this.
* having an RTE_ASSERT for the data being NULL - I suppose this is useful
  for certain debug builds, but only if the user knows to define
  RTE_ENABLE_ASSERT.
* extra whitespace line - unnecessary
* drop status increment - the num_tx value would always equal nb_pkts, so
  this was an increment of zero. Removing it is good, as it saves a store.
* change return value from nb_pkts to i - this is equivalent since the loop
  always completes so that i == nb_pkts, so change is not needed.

The change I would keep is the unnecessary error increment since it was
always zero - however, it doesn't go far enough, as num_tx can be removed
in the function completely. By function end, i == num_tx == nb_pkts, so
let's just use nb_pkts directly, and we can also make "i" a loop-local
variable.

>  
>  /*
> @@ -462,7 +463,17 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  }
>  
>  /*
> - * Callback to handle sending packets through a real NIC.
> + * Send a burst of packets to a pcap device.
> + *
> + * On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
> + * socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
> + * The send() call only blocks when the kernel socket send buffer is full,
> + * providing limited backpressure.
> + *
> + * On error, pcap_sendpacket() returns non-zero and the loop breaks,
> + * leaving remaining packets unsent.
> + *
> + * Bottom line: backpressure is not an error.
>   */
>  static uint16_t
>  eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
> @@ -484,34 +495,37 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  
>  	for (i = 0; i < nb_pkts; i++) {
>  		struct rte_mbuf *mbuf = bufs[i];
> -		size_t len = rte_pktmbuf_pkt_len(mbuf);
> -		int ret;
> +		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
> +		const uint8_t *data;
>  
> -		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
> -				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
> +		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
>  			PMD_LOG(ERR,
> -				"Dropping multi segment PCAP packet. Size (%zd) > max size (%u).",
> +				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
>  				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
> +			tx_queue->tx_stat.err_pkts++;
>  			rte_pktmbuf_free(mbuf);
>  			continue;
>  		}
>  
> -		/* rte_pktmbuf_read() returns a pointer to the data directly
> -		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
> -		 * a pointer to temp_data after copying into it.
> +		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
> +		RTE_ASSERT(data != NULL);
> +
> +		/*
> +		 * No good way to separate back pressure from failure here
> +		 * Assume it is EBUSY, ENOMEM, or EINTR, something that can be retried.
>  		 */
> -		ret = pcap_sendpacket(pcap,
> -			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
> -		if (unlikely(ret != 0))
> +		if (pcap_sendpacket(pcap, data, len) != 0) {
> +			PMD_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
>  			break;
> +		}
>  		num_tx++;
>  		tx_bytes += len;
> +
>  		rte_pktmbuf_free(mbuf);
>  	}
>  
>  	tx_queue->tx_stat.pkts += num_tx;
>  	tx_queue->tx_stat.bytes += tx_bytes;
> -	tx_queue->tx_stat.err_pkts += i - num_tx;
>  
>  	return i;
>  }
> -- 
> 2.51.0
> 
