Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131AAD5B85B
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 17:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B94B4029A;
	Mon, 15 Dec 2025 18:58:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B81A840151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 18:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765821523; x=1797357523;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=7X7OJ8edUdSSoMmVKy7naR060eCde6kgsARNQd7IlsE=;
 b=IPHsQVrSapSuuopVmiKpaDioTHoTDcZpv9lPkmizzmc5zfgy4mpZq+/4
 wDvrgRDmf9EO5n5p3KkTbvZpObzHBQZ200btZW6pIwQfHwQRzCPwxSOpG
 pXnR5PUh9tnisdlKmogNqZjGhPj1H0tiFSqMRiyZWaEyMbbHzFx06R4yP
 AEIDREMlQz/XXiskqseJvRQPZGdTjxi8zgxokg+JpfUu49djzauKMyJ/4
 XMazGPQ1RFgcSfkBMDKx8LNLoMRcuTSFQYxjfD5B4d34yqnCRhaa/gjNd
 kAEBrG6M2REdxYSKmfY1NAAsgG8z4YVXptBHzktSBxl65kQQ4tLb+b4K0 w==;
X-CSE-ConnectionGUID: blWCg/WFQ9+PbtA/dPsVUA==
X-CSE-MsgGUID: CSy6omnnSs2yRAYcKy1C0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="85142043"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="85142043"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 09:58:41 -0800
X-CSE-ConnectionGUID: M2D+9xYnR0StMAYRKGovUQ==
X-CSE-MsgGUID: Lgej6mXjTC+np0+N2d9maQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="198285836"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 09:58:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 09:58:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 09:58:40 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 09:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t34GRu7kiryr+DU64R4FxWRAu+6EwYzu/9Zg4Tbo3mBYf0W4AjwlgQKRcySpOKfMr1olZGUoCRwVf4LvpJnpehL3S0RywjmHkfHppFVby5PaVhoa8bGQ8OJqcadYZUGh7mDjsb/izrOXdxq8KDO1odlJB8Ol/iBcrpxzIBjSDsaNafRDJUxVw7YKhgNhSqoeYylQNkPyOHF8S2P8id5BncjfHnwK2CRgBN7ILmaC5TiYLbMTlOHGwe47685L3RsTB7aTLAyRiq6KKrWXD2NKvFpvi3Ui5m8qgtMjiMxrleGZeUUMlsvRwj2EgipTe2kVIdHCHRUooJicdZrIFUHc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00S8Jk6/RZsFTw/JQBAJqYtAltpb8vCu3AGK0NjNv+c=;
 b=WN+IClvDPSRcporAfl4v4Rq8nDNPBiYj0xjuAeIi1chTyXcNW7gflAF1AWG6l3WsfSXqZDj6wjz7nSWwSPlIP0MysKYYKmYL2yAWY5Quomjnbt82qIg07WjWoFxsLpP+LyQXZ1PeJYs6sV+b6Rcgv4z6vzFEwMjtrgyAl9HUYTFYxm4CVIknW66Ck5/iGCCozsbRPf3/AEYb+QthHYsqbeidd6EjKk5SpTeUSRzO8Oy4iiYaeCmqHQZiVnRjkGbSHV63+sbZmdz2VTTTHPBMlKIDvxpJOX1kGKIZ4RIJzrPJoLyOoczJPcC28hbqtHbtHq24w0TTR2zAfTMoEpbcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9376.namprd11.prod.outlook.com (2603:10b6:208:570::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 17:58:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 17:58:38 +0000
Date: Mon, 15 Dec 2025 17:58:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Praveen Shetty <praveen.shetty@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: Re: [PATCH] net/intel: improve Rx descriptor ring size checks
Message-ID: <aUBMSa4u2Qjyy4t3@bricha3-mobl1.ger.corp.intel.com>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR06CA0002.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9376:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb7771e-e4e5-41bf-f37a-08de3c039327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?CCFgwZwWzJmA+hV6Xt59sfErpn6ZeTGI4/agmQuRlIcouRL6Sk2waly1+m?=
 =?iso-8859-1?Q?2WN7rymwCsLjRhbIwIn13fIeoSNjbbGcJHB6CKeBZjw5tT8/FphqjAdPWy?=
 =?iso-8859-1?Q?w7bRLUuoaxyfuK3fpARALV/hCGcB3AwvijxGzV+JgPPgbGvCl/mdbAWYfF?=
 =?iso-8859-1?Q?6jJ5wvxadtbIMsHpNi6fzBZKLf1zup0h4AMzakfQ1dIld4XQ2dO+iwei2M?=
 =?iso-8859-1?Q?uMca2HSPA4o3MkA9eoMo/h1zxOK4jwfQCkUNrg4ePDACxUmDFXw97uY3eM?=
 =?iso-8859-1?Q?pXUln7F7mg0i8aI1k51fcUFhcHbIDRKIfTrTQK5jNtz58eByMUxOMe/j4I?=
 =?iso-8859-1?Q?cD3x/BkMPGDmFC+agYHhFNcUO791hYpIy27iNh15t1E7SDMgGFmMD9Yhw/?=
 =?iso-8859-1?Q?BBNzWw2dpGIRC5dAABBh2TrbGhkM0WOcWVPeyibQPONaLEIkvw2uo6rjpZ?=
 =?iso-8859-1?Q?GSDxocYMqKCrknjPVELOI0ZxfeTlJPYUnct+y535AeIhjOWXU7vZfpmdXB?=
 =?iso-8859-1?Q?FVY40W45u1l2CDhKk1sUa5jBwGtu2k9E469M4o8K577qop3SyZcZlYa89z?=
 =?iso-8859-1?Q?WpgvayjbVd/ZudLuFUZKyhkxFhDDOvkwpWqHujuy60dzi++j9jc4kZD8IL?=
 =?iso-8859-1?Q?sTj/F0abAM9yiQB/ZM672CDyGK12jDUayTS0OZuCWTi/ss9WLcQtpijUzG?=
 =?iso-8859-1?Q?rYrFc5wyeI1EE5ou22Aad/I1LmTvUoig1nJQROvzsrk8x0uZnwVtWvz/Rc?=
 =?iso-8859-1?Q?596w51UgEp3FTfZp3A9j0YXTtCGfJWdKmsfq7A7XrAw5f6vMaj+4YbmeFg?=
 =?iso-8859-1?Q?cN78sw7gFrUKpgVVvGxQ+3ff1LyFzYSJQcehwz1I0YXzimSSAyFTIiduV1?=
 =?iso-8859-1?Q?5dS7MBNxPCPXwaa/Tpt4a5gxCrQLtKa7d6CDTY50CEZsR35CJIA63X/KuK?=
 =?iso-8859-1?Q?o0jXw47ICbKG8EUxXkZ5znFpqPVQS5h8Z/qOuQe2S1rDanA5iQMpn40bA+?=
 =?iso-8859-1?Q?CCGRsDG2cr81GIdEX+rh9Z6Z0xT5i1FC5KCaPFv+0MYDqYrlHAZ10CJ7Zp?=
 =?iso-8859-1?Q?LthJTtcswcWpnGjQbTmkkMgZ2U9PdErdofdhdnNqiYkPeNjhVlOGIW7qnJ?=
 =?iso-8859-1?Q?xI50IBNDIxfA1Nl9K2JmIUdAKJ58+SLiH0oKfjBT+03jCMXILHPrMOsjcj?=
 =?iso-8859-1?Q?53tCBYeMqlY5DiURRt3rncnizgUOcbjJAASFBMLcbASRR2bmi6gNrwZ6/Q?=
 =?iso-8859-1?Q?bHkLAei+rAF3Eoc+2KXNfr02t26fSpo8pM9GEBdlomxGsd5L6muSlvcmjK?=
 =?iso-8859-1?Q?080p0MK0exkBCDIiHfmrTHtj4nWtGF4/btq8UphfjiAWUew9TV+OiIqawj?=
 =?iso-8859-1?Q?DEgUb9xgm2LGYXPTiF6JeSPbxMxc8vguzgay4ESNCaYyFOPl/bBnrDAtAu?=
 =?iso-8859-1?Q?DttUrkYIa6io+Hlh+n2wq8Kp9tZ5k1S2TaKS0S67SXRkYGq3WCcbEtk6Cv?=
 =?iso-8859-1?Q?6HdkAvvPaqs+/3xj7qCCjl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?h15Q+DIQGS8rRHb6sz1Z5Ur4PPd4SgFlp3MQcLIIHz7vxttec54xS84w0F?=
 =?iso-8859-1?Q?yapyYt/LrQJlpCWScIUnGfKsywkJZ3PVWtMCuF/34VGCBY6cBgNXb0CvDP?=
 =?iso-8859-1?Q?vJOlvQTqD45USUXea7UCFmPwm/hVXE0eE9b88A7cjGdcxxmX5URin43nE5?=
 =?iso-8859-1?Q?7ywx5fd76+DoPeZlDnZ/T4kmHJ/ipv4RmDLpHEg6PtoXeHQRZy+tR8X0Qo?=
 =?iso-8859-1?Q?q/DhTX+TWs4uAc4BsEcTI4qK1d+aXwp0OEavpebnG4Tf+iwtMCmE9OEyb0?=
 =?iso-8859-1?Q?xZY+k62Khu81E++7u37pCTxPBfBsf2G4bSWS9u4aN2htJnpcjouiBdMlbQ?=
 =?iso-8859-1?Q?0gbkrIgq8JR0XFaZ/iiVXFAdsF7L/tE3BDqLydZDYd5pOelJCKbT/hOIUS?=
 =?iso-8859-1?Q?hbsYMYuCzf/H+c3gmMkKHX0tvOkBYsoKGF6KOsLBXQcIRDJEe3rplctzsf?=
 =?iso-8859-1?Q?qtPzJyx2Lw7p8yW0OGIpbuJAsn69ujBvBIiW6PEZpe6S8cFT2/udPRnPS7?=
 =?iso-8859-1?Q?otS6A0/2uQ+IXOoFIqsBPqm+DN+wM1fy29uOQX6kHW1HfMDKQU52DTkUhD?=
 =?iso-8859-1?Q?3d3/TTXk/SfRlyiBWAn1OuFFL8mpI0nZq0VZC7oEhPVX4aj6WD6wv7CZiq?=
 =?iso-8859-1?Q?JlbrvQfmAnfpK6eXRNG63SrHdyzV7jZ96vr2gKWG5jtpbHZnmjMrOVsj6Z?=
 =?iso-8859-1?Q?OyFECRfT5SWgXLMDXwnBk1TfOQZN+QKUsh7hJ9Bkxovq1cZZrAVlaoyqk4?=
 =?iso-8859-1?Q?62F8KSdIha9xZvniQzfW9Qy6G3R0OPb8J3IVZG+w0CLjxugyIAGHBFE5DN?=
 =?iso-8859-1?Q?MxIeBPU7IA8QpznhrYICKy19kExF06m/JT0rPChjBiJaQbQTfFbgUa5bp4?=
 =?iso-8859-1?Q?6WxdlDipfooQaJOh7CA4wopcPl/S7u5PeYmFjc0niCKL3u+TFQps64CcSQ?=
 =?iso-8859-1?Q?j+qao/iRq6tQfSFmXBcSUUOas9Moja4OkBsxXghjOzLTYigTumwMEzFesj?=
 =?iso-8859-1?Q?ZGQy8fLOTaDnLBXBskuoGI/HwNNFTVX2awzooUzHmnjZqZw+ASVhihjPNI?=
 =?iso-8859-1?Q?RNN3qdBF5/ovVXejkt8As2vi7IbOs2qR3m0f/abyEEM3ySjxFYtT2ut1R8?=
 =?iso-8859-1?Q?nxbqcMKkBTrhfk60pCFYppSpJmmQSFcsjxb4UJx/E5ykLy8IxNK14t9c8L?=
 =?iso-8859-1?Q?eXk1W7E3D8409XG5PUaKcqjEcMQtjd69Cz2i1vHbOxfyfv7N9kotjq7sj0?=
 =?iso-8859-1?Q?Cxu7KnH5aiku7cL8JVduD4+Ha/irUB3NoTh04FQ36LWfMU97JuOqW7an40?=
 =?iso-8859-1?Q?ansGXQOlg23R/Hgk5+RSdZCwqQHZSZydDrCXEeqVDuyenF9Sh5a+cZtDNL?=
 =?iso-8859-1?Q?qFip+16C2q5I8lOc0suPoLJfUWkdOBP9S1VsMvTSuRYLUDxPwyWbVgvHCs?=
 =?iso-8859-1?Q?Jir9xXk+ExZqOHR0q99i84LfxcwErFESKBDVnY0Esy59KOMK1nXHDOYl1C?=
 =?iso-8859-1?Q?ReBgUOI7ICcQtJaRZHL/7mMVyieYfTaDhOqhyGK6wfz3nIfmv8h5pvm8fZ?=
 =?iso-8859-1?Q?HGWW394WQyo3WH4jbafQIQ3Bvu/wSEyy3E7m84cKK1ylN750G1VgYExl4Z?=
 =?iso-8859-1?Q?SnVA7cmoWFuMm94crLc3dV6dOH8144QJJtYKVX4OHjzMIDjgNLTePdmA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb7771e-e4e5-41bf-f37a-08de3c039327
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 17:58:38.5807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hlo9kFgsXT4PpG+8yAIYco0e8no/4QaCuAG+HJxWgeXGmEV0GiYXLOmZBhCvPX6ypk9CX8/txnWxt+IYcf9enIjWJ9AnUxGIZgMMiUc5rYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9376
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

On Mon, Dec 15, 2025 at 06:54:50PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 15 December 2025 18.36
> > 
> > The default Rx ring size checks did not account for the fact that the
> > port would not work correctly if the Rx ring size was only twice the
> > free threshold size or less, so add in a new check for this. This would
> > generally only apply in cases where very small rings sizes are being
> > used, for example, with default Rx free thresh of 32, only ring size of
> > 64 would cause issues.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Does dev_info.rx_desc_lim.nb_min returned by rte_eth_dev_info_get() need correction too?
> 
The minimum number of descriptors stays the same, however, if choosing the
minimum number of descriptors you may need to reduce the rx_free_thresh
value.

/Bruce
