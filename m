Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B60EDF15E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 13:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BCBB402C0;
	Fri, 13 Feb 2026 14:15:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B11CE40287;
 Fri, 13 Feb 2026 14:15:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770988514; x=1802524514;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=T+39zjQe/hYVc8rofP4BX+cMqozX1TRHhXxkkyznvYs=;
 b=Ju2q1a7SfVQVCCp8DPNuQD6yKriVyl33NqLneIxOuqO4jAtP7eorAXFn
 nUwYrhlePWHw8XShoZEaZpJB52+IscihMnLJfY2jnutZ5pviVHtnRYeIA
 dt4vpQ6olYC40dy6KF/yLnlZkGmCatwEzhSypCOGy4E+4RBnAzA4Ne65y
 xXhTHdR0pOozqQawAYJKkrWrjlgKcnPeYyPQE0SHyMJtgByRvY9ZT5g4d
 Pr44UbRmkfzWZJpnCnFv95WsMwktzBqgBjqn+i8lklQ1MS3GyFHF8+v97
 upkywOYKII47v3YfkJ5zuyfkB7vAW7/UGJdwAMho7rUl6ALN2APESfFfZ Q==;
X-CSE-ConnectionGUID: 8PKFklvFRqeZsEpGxI+tTw==
X-CSE-MsgGUID: 4MuTIu9oTCiz4rssdaSG4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="82495304"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="82495304"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 05:15:13 -0800
X-CSE-ConnectionGUID: cc01CRvaRGGxHkd5bCWdwA==
X-CSE-MsgGUID: 8PGFE7HoSCqJmgBZLPN/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217071713"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 05:15:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 05:15:12 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 05:15:12 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 05:15:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYvUvD+m0mNExRsviOy8Wn+1NU3qeKaM7ofOD9Tf9GKpXjpafrOw+O5SOJA5dg0vjm+XpuK5hTXGvGpmNpVGi3n6Xuog2vHX/8b+pe/g5UP/idJe1cG15WgfLeGiWF/Q1UKigWHvRRY04meVGThQ8ZO+8tq670twVf3x3Y724hg8oV2gBbhWfH7poUwU/lNIGmQK2wn4rLiZU7oFb/r3Kpn5PGtCDmRnDC1V4Zrp67Fan83D47DHFjdGf3GClgACYCtUw7/hS5a2/6xSGtD90LZJhyc7/e3rAJZvYhgvz9olNGEpVf89EAUBh1MPlylRfLhWM1eq1EATCys1TpAa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NW8VKevBsaLeiSvnjMRhQGvlVoQHQqohfX1j9sHuZEI=;
 b=PdmVgp1LorP5ukb/vrP30N5/SNtgDqOYrM+GKCUSvbvyLKZT76OeIiwe1Bu3Vq1CLSY/8ERBeG2YeRY0DdL8QAHurxnWyECjLExSS0RDwgpbQ/gYRDt8viVWt0WskkDk63b/X8GVsTC0x+PjUKS9QrSNGS2POVdMbCZrOUhTHuNnppiNhmOLiTawlH3R/ahDdrlE2Kw6B2IfIp5lkyrXuukGhF+yrug5pL4HGW7zGOI2L6WtTLeXeX53wxdqaP4fI/4OhLlGVBbMTxDIJ/GQ2bnyTDGQ34FzrJ/5VbDN8EMf/C0G+1WZEKTo/TISCR6GJT0BCChOX4E1WI4I+CJ9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7693.namprd11.prod.outlook.com (2603:10b6:208:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 13:15:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 13:15:10 +0000
Date: Fri, 13 Feb 2026 13:15:05 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 01/10] net/i40e: permit secondary process Rx path
 selection
Message-ID: <aY8j2R_06CbaRE-q@bricha3-mobl1.ger.corp.intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
 <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260205124627.371733-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205124627.371733-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c093d7-8af9-41d0-d02f-08de6b01e9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M0FSHLULg4f3FB5zaMoRweGffFHHSGVf63hr4C0cveheGOggyzrtHPXpXuxw?=
 =?us-ascii?Q?qTusII4zLnmZ6hJ59QkemDSIWqCVI0Ex0CQp3yBhbBFvSAWBD1J1gStBJhwR?=
 =?us-ascii?Q?8NrCKidQ2xbUdi/vW4bYCFsB53nLDhjlIcMwVbmOTCn7GeeDRfp0F26KoFE0?=
 =?us-ascii?Q?WZFlZ9MDPmHvR4tmltqhucjdxpU+74UDujlJ8BoWf2u314VyqGreP5ggmLux?=
 =?us-ascii?Q?qOawBm4zA3mFRfIPRgxXRmZS8PrOv/fc9PUxx4giqe58hdFgeRndEt+dEBBq?=
 =?us-ascii?Q?9asL46emwDvEN0Psx3aqAzNSeuuAe8ecXwJGI6BMaV9nm2YFPB8I29lqkl2E?=
 =?us-ascii?Q?YDoVuAHPAXKWMvWm/byChcKhOXmSC9+YL+cXumB3+vsafVueLfh8J2Ny7Gv4?=
 =?us-ascii?Q?8LinIONUU+yAcmvnOygH1dMPe2VIBoWYt9hspJBcQp691xbLlBt30xlnbBlz?=
 =?us-ascii?Q?IfnMhIbp0T+5BTObxelqHavkDeO5IaMUPc6WBsL496nxcYIpBF31vRDKZL65?=
 =?us-ascii?Q?JEewu4Ld5M0x4L+WkcIHlEnBOEM6ZGFwuC0YfLxd0s6AsECTGZEXArRoMmk5?=
 =?us-ascii?Q?Qt73D6xchtPpMEjM95NbLVBW7gW9h3jxcrbuM2R+jCBZiu7US3UL9AMXauFs?=
 =?us-ascii?Q?jCuNFbhH+xczP4iDE7g7EXm+dAvnBXCtm9Y2Y6K6vt/yjE5FfUQUfVgCwHey?=
 =?us-ascii?Q?upVLYiuOvs5IBqzKi2LwkVTaU7f5L8FaCoPFWaWNHdPV5zsu9EAMVjaKFe1A?=
 =?us-ascii?Q?Q3V3NAocgNHOBJTwCFlvoxmX1AS13Ac1kuJba8EfZhlgGHwdz2ND2L8vaFbC?=
 =?us-ascii?Q?RaYZJXywEDuJLRdq1beUmtCY2Hyl31z50J6bplA6H4UY+mW2iq3UEsyGIABT?=
 =?us-ascii?Q?C3vI1Iw2CuSbRb34n8tb3nIXJo4fJJH8j1WHlOBpMs6rc4TBsQK1S4MgDkkP?=
 =?us-ascii?Q?kPWBQ3RwDpwOFeoCPfLBY2eOwb/o8YjRXv2Ia3BZkDVkjxTw9g1i2q5B/DVx?=
 =?us-ascii?Q?wwEPVFs34mkMN2Gi2l23oXi+oq0YUkxskmSgqm+y6X8DVs7xAgXwbNM8Immm?=
 =?us-ascii?Q?xLtyXPHmPloSyC1JfC8upWq5nnSBqp0pGkRemuKspla+xzN1Z5nU+5yl5jbO?=
 =?us-ascii?Q?YjK10zZLAsu2uqoG3maX9WgvOy+3goVsiG4ydXzDs8CXxAzN8gtIZKR/X+Tf?=
 =?us-ascii?Q?G+XMrinsqhTcmt0UN1jR9kagn9GUNjW8//2g9M80vdsvoaMOYJWltx9fjuAV?=
 =?us-ascii?Q?35874zmUCI/mF3vzgb/+KHbJWGWcqETRpMGI66sG59Qg3nf7AHcVT0nR5s5V?=
 =?us-ascii?Q?RAgr5nNWpzW4O6RdLy9k0js3Y4gaqCCXvnxPNbwUrOPXWyRnrdjgytMHM86E?=
 =?us-ascii?Q?g0NxYyyQ2bZTVcQn5NIoM8QzOl8ESx0NfV2WdHlUszJRchsgpdV+F3GTZbYm?=
 =?us-ascii?Q?oUHIBAeRT42q2Lu9FwIZFg5advZd6SoSS+1Lrqd2uJSYfe8hrNXAq1T8kg9n?=
 =?us-ascii?Q?nSQQORaHyEqWZ9Q9W8HHZ1AbvWyoEqKK7kn33riT9CwPZi2WatCVwmh4gvdG?=
 =?us-ascii?Q?GSCiOIiw84BieCyq+cA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2d9jkY/64U+KWHF/4KxPPxH+FIEXCgGjYkI9wK4XykqW/kX8UM4SB6Cq1Kd?=
 =?us-ascii?Q?Ypzu5wPBauxyh95k378SpPcwQ7m3WY1LTYzlwRBHYyNrvOL0ZGAmZwsp3mR9?=
 =?us-ascii?Q?GgRuGY7uuvgwfcRvgoxNGMfCOfqz6IhQ5Rd3nbnNZPMtpUYJoGoBDmpJdh4T?=
 =?us-ascii?Q?8p2MhHFbWNgEWWxrNvwr4gJWUxHnniYVD/f3mraybmNxBvFuxmrBE7L6E2Nl?=
 =?us-ascii?Q?CeVot71LfBKjad+G2zBq12bv6c03sWf8SbAPIvqjVTD/cskVbxucWl5kuf3z?=
 =?us-ascii?Q?AfrvZAhSLUMWxJMJCQcnapoyycfKLUQKMwvq+VrWQE6DxezO2dVRSAW01Tx3?=
 =?us-ascii?Q?zR4waQiXCFXZlrtwLlLBGymqVmF58Z4FyEQg+79pyHFAqN86uuPGP6Fzt55f?=
 =?us-ascii?Q?YY+Z6MFNtuxBE4TYsMcETvnPOuNi1p9Ee119iav1L9jdDWI9hT1uvaQHqKjL?=
 =?us-ascii?Q?WcAMFI+SLi39JJe+vMustUldTFrbQmOLh2DaghrNbsgBHCY0Pgg2vabC4sVF?=
 =?us-ascii?Q?CQQT+4bsbTjENfvXOQhs0RnbW/CNxVWMRYUY1rVciA9K2RoKPRYY7SFUvPoj?=
 =?us-ascii?Q?di1sB64SCPXxD5TVCCT6z4u7XLOnkc+9oYq1EEmSlKoWiHwnTtX1bi2wGdIS?=
 =?us-ascii?Q?6t/ecMs/5U85HQttA7Me5MLgRLORbUe/huBp6yjSlNUXZ7+TJNr/NgZRnR+/?=
 =?us-ascii?Q?gCqVY7t3Q6cg4qB+dKtI8Mw0PXmVUTC8Y13AsmD0Db1lsyaqE8AM6w6PNlbs?=
 =?us-ascii?Q?cC49IhVFLLIsKfOiDhK3lSyJuNwzSfZtvsDIpp7fWS6uug/0QNi3njVo65LK?=
 =?us-ascii?Q?YbpUi9hlyOuNZYz4U5omSKRoS1uJCepzaxRxYnhd2ZtARY9jmeaWfyU8Pz3t?=
 =?us-ascii?Q?Gs26HuVDaO+fwOxf53DkG3kxHaOCiGc+oGH6XBHThwi5UMNmopScRfp6pjy4?=
 =?us-ascii?Q?3CP6+fLg+ec56V6++OaNvmE1slaYUfKFN/+tCldUkqsRHkl7laWTUp4hoezm?=
 =?us-ascii?Q?9815YJZBw76zWZ6PcpoM/1GjLcpiEfPywo7pSG/RNwzSpFB2Zg9ZIIQtQkGF?=
 =?us-ascii?Q?Wctj/8chcLawW95BFUbjrmQAi2o6PWqEK1+Xp09cFt7itD00YZt3Tcbnm8+2?=
 =?us-ascii?Q?avwvsii355833pqDyPMUxMEARAaUpkaHOo5cYbwl1rcoZ96lG82ZYQ0Sbla4?=
 =?us-ascii?Q?8LkDlx2KE2A6ONzj5AnS2I+LUWIYwqCk4d2M1P7+mLjf7wcTw3aKo8k3oOy7?=
 =?us-ascii?Q?sBEpR/Ff3jPerRlT4emE33yFbmN+mmLryYCkD+ACUADgqtMEVtNdfHyNSXqV?=
 =?us-ascii?Q?4unASaCUjdHDT2cx88WtgFf8nviFUwGNGY+X3EcitGExeL/2QVy2+8TV3i+A?=
 =?us-ascii?Q?90N4MMlt95eBf1sTQenA4qaDyVgW+HIL6Bl5ZMlpxzcm/9gxcHWP8KiXv67H?=
 =?us-ascii?Q?Jq1lY1lNbUM1v2T1u1S9qcxHgh+wbDzjDFtH7Ay25toYfu9p1AoGzSvcqG/I?=
 =?us-ascii?Q?3ax0B2d3BtOinp6KXf4EfPYgx7n9oJMIHzm2msZc6DljXJdMXZkzOCOMtdaJ?=
 =?us-ascii?Q?kPfkM2StDbm1E+IqT6go3GKP2PvF8IhYxszvngr+eRzrVE/0cBdLzBwCFYg/?=
 =?us-ascii?Q?GoZ6CsuG9V+faZxGbAo8Brh5KphhKvUQs7BOfKyL4panYwmSC4yXkWQQJqUO?=
 =?us-ascii?Q?hddY0xy2m8rivccbKsxAD2u28Q7fOawFdy2XkmQ679nwUYELRT+/OR07GFc5?=
 =?us-ascii?Q?aBVJFA1W2R4HXsp3RpgvxJkmIZEa2uU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c093d7-8af9-41d0-d02f-08de6b01e9f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 13:15:10.0069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7b1koDCNu40oLU0EUPnxapfvav/Fo8/jCeBrRmVPUaXlnVHztDSej5AAq1/VAzh/MaBHzZCo/J9nqywcX/eel1S0dyFESDKeGp4sPtWj4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7693
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

On Thu, Feb 05, 2026 at 12:46:18PM +0000, Ciara Loftus wrote:
> Commit 258f346f5d5e ("net/i40e: use same Rx path across processes")
> changed the way that secondary processes selected their Rx burst
> function. Instead of letting secondary processes select their own
> function, they now used the function selected by the primary process.
> However, the primary process only selects the function at device start,
> so if the primary process hadn't started the device by the time the
> secondary process was selecting its Rx burst function, the secondary
> process would not select the correct function.
> 
> This commit addresses this issue by allowing the secondary process to
> select the path if the device has not been started yet.
> 
> Fixes: 258f346f5d5e ("net/i40e: use same Rx path across processes")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
> index 1c3586778c..3deeff165d 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -3494,8 +3494,8 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
>  	uint16_t i;
>  	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
>  
> -	/* The primary process selects the rx path for all processes. */
> -	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
> +	/* If the device has started the function has already been selected. */
> +	if (dev->data->dev_started)
>  		goto out;
>  
There is no atomic ops or mutual exclusion here, so what happens if two
processes both call this function at the same time? Do both just get the
same result or do we end up with some conflicts?
