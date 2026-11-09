Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE41606A326
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gv5DKpaV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 994684028F;
	Mon,  9 Nov 2026 18:50:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 59D0540270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 18:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794246636; x=1825782636;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=l/0DpeYfvK7dk3LBrOqTTRczOju61BWs9FW/ug8bXCo=;
 b=gv5DKpaVPNPsdZvPOzJaToejWfVNLYpQMdJCFhMbcaqJM8VTNStiVYT7
 7QpIIDkOveoFu4cW42+nqDO4e0vSbuhl13cNqjpIYix4cPy5aUOONndiu
 xdi+Lnwn0mQImI0Q2DtwUWyGrF8L+Z2JAhvKONneUDoNB62W0PaRdGYVu
 ipR85o4Xp+1TEtYKifVs+aArj7snrg+A4VDdFD28KkksupvooINSey8zZ
 ia2taDMOSlEuU7AA4BEIpMrZfsXdDh7xkKy+pUlPvpgNdYWNL3HLsXy57
 khuYzvBmgfQYInW/YeHRzGxhk8HvCwJi92uy+29Gt/NZXuvcOlQ5mNIx+ Q==;
X-CSE-ConnectionGUID: 8lk7JmRaT4SXiSfw76mHZQ==
X-CSE-MsgGUID: u2jy3bMGREuoMPSpAajXLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2965002"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2965002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:50:33 -0800
X-CSE-ConnectionGUID: i3m6/wbFRL6t1gZ1prx1+A==
X-CSE-MsgGUID: pZWPVwWjQv6LJhybbR/+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7952486"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 09:50:32 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:50:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 09:50:31 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 09:50:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqyELgV29vPPUyu4UsU0a0j8CTC/Y03p6c5MUFoa1GCFv6RwRVlR5xOc2BZUGMPEpX3VOiQTy/l67wA4KlUwkP3iuI27WdDnPCkDSEoY7dQJ8zK2fJWRD6JMx/pJJaA4zewyFriz9swD8B1dhzTLjplUm7as6qkQc9/kGn27bda0cKC5cyJPdTr0FcB+dO4oal3idDpUfjnC2xVorqN6967pIVvB+XfsWO2XH82M3K4eG/fYDRUypJpjFeeH9uOyVPE0WUxNrOJXB5jY3V9B6Iio71jP12b7wP0GBCOS4HvNM3sL9sGBb2QSuma56wj8zzTFOMqUhLHLy+KnkdmYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yai1dFEk4eiELhIaaM5Pyt0JaktYRKAdOoqJjCE2Zp4=;
 b=YlIYlVITOrB1fxF0SCKvwS8bauX5WQkvr+v6QXhPUrI4nUOvmdBXqZKF8pBVmNsJSgRIvGZXlNl7wQZ+Hkc6Q15/M2ITb++ZxKf0mLESQpVx9m2swi/leWMnkSZ3J4v5LBgXJGr1Yyw6pJwd/8g42dZlkARWa51VlpLlJOHPWCahVj/GnWqZ9kKsLHjcAP6xIPyDG1oDk5aetx8ulPOFUGuFqG+TuGlsOcjCjzAwGmGxHLGK/ec+fAjYROvPA8Mug3GnIt7Fo/2+TXOnBIDPKaAPfoqayrVMn9p0Ki8Z7GxdOr+7zjMi7A0MQblihT7BKjT0EFXvqiIur5excUNEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LY0PR11MB909828.namprd11.prod.outlook.com (2603:10b6:404:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 17:50:28 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 17:50:28 +0000
Date: Mon, 9 Nov 2026 17:50:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2 0/8]  net/ice: fix DCF memory leaks
Message-ID: <avIH4OOmHYrZQSg6@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <cover.1794094943.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1794094943.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0167.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::22) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LY0PR11MB909828:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e2d0b4-affa-4d79-47aa-08df3e89f116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|4143699003|11063799006|261009223027099003|261028144727099003|261102123227099003|56012099006|261022105027099003|261022075727099003|261022113327099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: voJD98IpLqyyWhEzTAudtN0qxi9TSbOQyuQp++SxqqVd7cCMIIPW06178PGBKLgdumYH8IMsuNn4WlWk3Q3lcHQdB0Xr52amwHz03FCEjg6B5gm9ExLcxfGN5tIxZY1kWy/oXeHxSH/WUlLylXmac9UH0AQD0/WJJVw6bl7gsDJphCkYoxh0FRkFlAIjNtiHAUCu7MRT+/5m34wCvvu6nI4IT7oiNcF2UEbtU07yKHxuwI45waXrpyrR33kJTxaZykl7ktDPT9K2uPTPEBLj85ebNB465/lqrq9IyRN1aT/BkMniFWtwXxWeQjJtibgfR3bEipaZyKcit8QW79cfXIo4gJ1G75g6NKdZZj9J/SxYMzwBONTdTT/Lqx5Se2ya6WZiFbKK2LKv/R1DU8YtgSb3SEGlsHFDc6fHDXPY9Fv27NPqU7/IIWJ4LXKVgO+z8Zyr0ugUxpjdVwpKT/eFGetzAY2JQrO6P/28BM9CSVeLTBromVa3U2Hl5FF7gc5pDJbts28WBi2vPsaSeQJvSK/7KfB6Pz+zxOS2YpuiXOCK8hRQWEtyWZWlOfQjOSP0MZCwPkWcf5B+io8jcUYjoWMfGndUNJLuYKWPwp9jgk2GGdpSe6BLO97Ze0UryFbKBm9cfO8ZyfSL2v1u8bNBdatnbTb43uy0fCLNZ0tBytY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261009223027099003)(261028144727099003)(261102123227099003)(56012099006)(261022105027099003)(261022075727099003)(261022113327099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5RqnquHdqxIKLgA5cAPuj2DCxlG7TpPt2tQVqd5iOuc/rUzPJ9HRJNXWE+YJ?=
 =?us-ascii?Q?K/lV20ryyHTTcEyaXFXRhVWiTAyDtKVAwZ5phY7ifKtEeXMwZAblTGiPRl3s?=
 =?us-ascii?Q?X9TucbNsy9hgDW84FLu8bit7RafPTUXK/XbF/Rbq85vIAEThImOEaNAZsc6F?=
 =?us-ascii?Q?yD24znPuZNiqXif6nwvVbSmR5XUd8uAqtP634KeQp0TKkfQK1Sl17YmP9BPo?=
 =?us-ascii?Q?A1Dt6JpjK5Ey1hf0ORfWdSa/qKAwlMTjAZjzcd3NkoVDa/uErN7otJeq31Cw?=
 =?us-ascii?Q?I9/ZAq3fxxOhwdIz70qjTNTdkd6QflCWmXKYOJ/vCmGeZEldrWQ/liBtwqlt?=
 =?us-ascii?Q?X40vF7jXch0MsoxjuD+NMxiENetvziJiG+zSWhvluGl5y5Kv6k9F55aHC4vh?=
 =?us-ascii?Q?bZHzhYeGpBsjo3D8OQFgifhgCq09s4TO3xsiv8lXi+T6zr15m9b3hZHYzOvL?=
 =?us-ascii?Q?1OQ88vBXC/KBuZdfZxoq4wDwfbl0XM31BfYD1E4LjLcY2lv8On/avYVVO0xO?=
 =?us-ascii?Q?e8Ps2HUDet2C/0khbnhMtfuLZ151tHrM9RwLISD7H86Q1lq4Yn5R+UBChuSy?=
 =?us-ascii?Q?qZR2DjWiG6xnP8lLOaZ3s57bOnboyWcaVyPiPd7iZlAaOyk3I9zaIpkz4nqr?=
 =?us-ascii?Q?sRakqwYSMC5RUg7xgIkIuJm7fR8OM55H51C7UjO2Cojz6g409BOo5TVpX7rv?=
 =?us-ascii?Q?LvWGTGf/ssm77y90FB9szKjKDG2SAwZ7hUULPPKPv0qjAbKcddewXWPwNz7c?=
 =?us-ascii?Q?aQOH5L7GvMxdFfBQswk4tOfW113kQvAO6m7mzxbwRETuPpZixenQOZR7Wcti?=
 =?us-ascii?Q?rT5ZCbJT5VlYJgN5oR7WsIEhSMYo/MMe471ceL5DU0XH8SnTX1LjzpkBrrSl?=
 =?us-ascii?Q?XcNdV80eSgIvfSvcLo8G7QYlu9SWkxn+Y/MAgswmzYToGkpmOC/WZo5h1ewp?=
 =?us-ascii?Q?u38/ezksiNZIVUkcSiLCA4garacRxFEo6stSI3rtw8O6NrquPXSJ/Jk6yuPk?=
 =?us-ascii?Q?ktHU4Hua5KqnJOV3pm14TYmRE4Q6Odut8TRVlhCAhuWfVmVfPWZc1OkOjGSf?=
 =?us-ascii?Q?XILyvrTqGZvdWIJawEWPmHqKhq/YnT770d7vR1RoN4AVftioVNUi5jKRTpGm?=
 =?us-ascii?Q?X9eCrSz5P+QHmBsxjDY8KU7pH9BPTXcTLPNXfPeYfhq0HQ6sAlGuqYd1/iil?=
 =?us-ascii?Q?jOueOhSfs8UFmo4EbUqV1fUt7M13k6Cdnt8HYx7gfKf4VupbAVSfhAwiB2IO?=
 =?us-ascii?Q?5t/rNX1jM30zreaV1gutZ1VTRSuj3lqmQe6t17IciAROPKkBqH1XS6z+ZYah?=
 =?us-ascii?Q?Why5Fpq5L7FHUcXHGw1N36VnzgnmzEAeFoDtr82DGOS8rA7xMyVHN21Qoox6?=
 =?us-ascii?Q?TqrRGHVWMbSZS4rfSN0qzca98/abdJ6A8aWk9uuXA8fH5hmfYXhTQ3RV5yQn?=
 =?us-ascii?Q?XsKSgLv4BJMCR+AB1ckrPReFkd3HDqyeuQchwlN/NvFb0C01+DvkgOKFql50?=
 =?us-ascii?Q?pbAzHPD0a2b1UAayuVbjmd+oxZBLSPMPi6vSolbxCHmFfnxoR8DJyIlywAMj?=
 =?us-ascii?Q?esniFufHoWVrp+ua9s48++Hwiw1RgSgwjfwy3hR6m+jfAjH5QHAPFePVGpEO?=
 =?us-ascii?Q?Whx03xj2kFmgLqgwiMthhKeXp2VQx2VnlGgxRca+l61Ztz2SMnT8uLUj2JQ9?=
 =?us-ascii?Q?E8aDXzeG8rsSF6stZkCZ/3LkyR04xVlhJdL4f1CixfIIH70unZ5mu1c+NOkA?=
 =?us-ascii?Q?P+9D6Am+5A=3D=3D?=
X-Exchange-RoutingPolicyChecked: gXwh1bcBZ4gWHXhcL+pxIFY6uiPCvaPDoiIgy69jOuZ5RHmdHjTTjDdve0GwtyS2ziUuhw3BCQTEjvJz8cFyersFh6COFhWU7fNGc//+iQRrJvWppk+Hxn7LT1ka+iIh3EJyNj9/qMwuCyCf6JOO6rMDIZqpi5TMNmEue1wsFLdo/2rMopNarIajusq6PObmnIXQLy10tviic9/078dne8Bsc+B2VYk7Q9z2cXNB9SCowMM6xAJ84mG7iUEfM+KRirrXvlH+yD0/bPe7O6kXFABieuqD7T2oFIb2PMrfxN7hh4sWGHlwfWikDJ/kGikDHoJIfKv/kQJ7gXYh2bgHDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e2d0b4-affa-4d79-47aa-08df3e89f116
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:50:28.8205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Uypdrn350RoYZYJru1xV1ZYsRU87eIPkMRlBIFWv7ovDkS1F6zMavTWE8/JDjheWL6hSZvCL2Ml3n2LgZ2O83VKy6v+2RWnhBeFAkWsdtA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR11MB909828
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 11:52:10PM +0000, Anurag Mandal wrote:
> V2-changes:
>  - Addressed Bruce Richardson's review comments.
>  - Patch-1: use rte_intr_callback_unregister_sync() in the new error
>    path.
>  - Patch-5: fix the re-commit leak by swapping the saved config
>    under the lock the VF reset replay holds.
> 
> This patch series fixes memory leaks, and related error path issues, 
> in the ice DCF driver.
> 
> 1. The VF VSI map leaked on DCF hardware init failure, and a failed
>    VLAN capability query left the interrupt callback registered.
> 
> 2. A failed DCF parent adapter init leaked the dummy main VSI, and a
>    failed flow init also leaked the DDP parser and flow engine state.
> 
> 3. The queue config message leaked when the required RXDID was not
>    supported.
> 
> 4. The temporary QoS bandwidth buffers still leaked on every
>    successful hierarchy commit.
> 
> 5. The QoS bandwidth config saved for replay leaked on every commit,
>    close and reset.
> 
> 6. TM nodes and shaper profiles leaked on close when the hierarchy was
>    never committed.
> 
> 7. The representor info leaked when the DCF port was closed.
> 
> 8. A failed probe left the DCF port and its representors behind. A
>    representor type other than VF is now rejected before the DCF port
>    is created.
> 
> Anurag Mandal (8):
>   net/ice: fix DCF hardware init error path
>   net/ice: fix DCF parent adapter init error path
>   net/ice: fix DCF queue config buffer leak
>   net/ice: fix DCF QoS buffer leak on commit
>   net/ice: fix DCF QoS bandwidth replay config leak
>   net/ice: fix DCF TM config leak on close
>   net/ice: fix DCF representor info leak on close
>   net/ice: fix DCF port leak on probe failure
> 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
