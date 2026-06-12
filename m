Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD17CD8CA8
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 09:35:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DF24434A7;
	Fri, 12 Jun 2026 11:35:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4B4E540279;
 Fri, 12 Jun 2026 11:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781256910; x=1812792910;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sUDs4y4GRqzrMG35r4c23sWzp+ZQR0SHWtxghcTsDDc=;
 b=IXgSbEkCH3GykD5547J7Hqze5wf5+7KE1TOMdcIGheztqZuydQtk7A6X
 zIGjcg+ZLJDpIFZ731++o7d/Hp1VLM1mzyBEOptxs1e8gI3jRUJLF1kCP
 Uxt96alzuPJy8r0oNg+E4JgDjhMSm+McpgBGfu5QaP7VBDK+f39ooF61O
 JimRzThbSgnp40Xxzceo0hupfr+ozLZZYUC4NOhjwc1uav+ldKK+rZ/Bn
 5+agsZFArHG4mHZ8vuZXvIrWGHm3g+rBdQrGPdACrnhfdV5sX/yMXDo5c
 4z79c6gY6VpC8tqF15+vGxuCJ8Wvjha3fC7nObMNVUvEBe3jSgivMraP8 w==;
X-CSE-ConnectionGUID: 1BpGI+3uQUuHP/4t1+dJWQ==
X-CSE-MsgGUID: DNqvTuDhTUKmmlKDdy+Dnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84653646"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="84653646"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 02:35:09 -0700
X-CSE-ConnectionGUID: D5GkyhDERxCg5cHOHvOvRQ==
X-CSE-MsgGUID: Ry4AA4NGS1eJ2WU714N4YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="240424256"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 02:35:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:35:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 02:35:09 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 02:35:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ido+Xh9v0bXM3IsnMBto9k50fqw+OwsGTo3G3D8I4M+v+BPMZjhVJe1HFw5zSj379KhOj1VsYMi8rPM/blV7/E/5flmYzrmNv+MRadZxPej1CR+EY6h6eG0+eDDUObiWCcC+j7Crk/5ee9YGVvsu65GJO1IPvbEutRst39mPfK+iSlimLWP+BV4JfJj6g5SLoo9wMnPWcDUGsDN1g+tDKepeN1KnyIjEIqfd+9OyBDC//e3SsTAU1WHhfkc4bPooZ20YtwvZUImA8fnpWCG5NtXeWiAnmej3mZJqX41C6qqNUZYtQVz5lwHlUEcpLwa/eLR73Cy6wQR7jQXjRLeWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51y2lWP8EypopiF8AcZjjmlQ3ffrbdr2nTkp1nL9WB4=;
 b=bdLJ6PJEUdCSPYaQQ/v7cTBZ2ODxyxkqWVisvK5QASRtR1lbzzwk0wOGXUsiT8QErptlcwW0fif9DSvFegmN5OrGp5dBsr7SCt8wO5Ud+ZoFT9T7woLhGKD98lySSmxC+7uy7Qzxe15NdtC2Rxda5MrygNBRmhxnpsw8dea84XeK3up8mTcLVE3DjyqjOcg7kSdMfN8j2fak7kl1UjMTCc2hUo1wG5Oatqnkjh38q/06Hfgn9LifuRd4g8AhPWDtkWndCMLmAMEWLNplCJYZGnB90yY1g4dAR1D3QofQJYfhJ9NjZUnSVerljKTeTHi9lSKwDFXjy5iy9EU7BghM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5312.namprd11.prod.outlook.com (2603:10b6:5:393::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:35:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:35:05 +0000
Date: Fri, 12 Jun 2026 10:35:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Denis Sergeev <denserg.edu@gmail.com>, <stable@dpdk.org>, 
 "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH] net/af_packet: fix parsing of numeric device args
Message-ID: <aivSxPGAMkxLLJts@bricha3-mobl1.ger.corp.intel.com>
References: <20260603170812.212262-1-denserg.edu@gmail.com>
 <20260603181306.459234-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603181306.459234-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU2PR04CA0075.eurprd04.prod.outlook.com
 (2603:10a6:10:232::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c301df-84cd-4065-f375-08dec865e254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1oGGLbfjt2Mmuk+9WhnKxXQSEYt+2LPgVIY7Lj/Nh423ViiC18lztIN79+Fz9cRPKOODfnxSQHIqZpKdnK31FgmtaMB1/AH3KlE5dsPQD0EddBARn8uGDiUXrARLuXPl8uNjr2BJS3WIkYRTZ9lbXAC58eXrERbN/PutV0r3YZnqsneYHIje7eVoYGn/pOPwXSLDIJN7BWAE/6rwGObxyRXs39PUUYs2/SG1XqFJA7jV9R9xDc9zK9RPo5WsOqJy2XlWdrxVWAtDX/W+pD9DolhKJW6AH//ZHv/DZKlbegiEHbxvmGUPb4bieOG/W/sGIoKbhOC7uQupscyosusRf6gSz2nQaP8hd6cjYmwvPfbTgX9zsOcaHEoRWA6XH/jYuAUa6amxmRf/hEvX6sAVxxHM7/SsfpOu7nreh4X80cgzK0xMoCPzWy1XWfcWginy7CO5k6G8M3SIQBh83j/QWXgleQVYIbEVwIP0vfz4JZ2679Ly8WwbDirK47dqzRyGIOQ3cVoS6XPoESF+BKrL5LMYgOaRdHE34NhRq51M/4J6GBvq5ezqvFdN3f5Vi79KSbWpt/1aGuKVoXtG+oDjAPErNpp9v+/sfuVpwG6TMqB5JCt2TM3/mgqwV0qBTquP0AV9sjxcPWCd0PxjL6A5+kOV82s7DHRIL3EsFMSrg1USJO2G8GLSZGvGCkrZXkjm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VcUNEDm/DiJ/tnhQdP+P/5DX1PzyDzTcT/c8fqak9a/fAompDkYNrt+p+bEA?=
 =?us-ascii?Q?GqYX1LlKz5LHaxSp8jTwOlmjQX8H9NMucLJOQBgu4PpBt3XnSknS2UQM++TS?=
 =?us-ascii?Q?GnUsbETHtSlXOH0EDi4Oqn/JcM19hvRXh8iREyyMS9NkT/uxzMA8O1fQ2Cyo?=
 =?us-ascii?Q?z73NAlX7KsMIXDsv1rwvVWwMzbL18cp/IWBSFOhzxK5szO1QdZTevkNnpGXd?=
 =?us-ascii?Q?DcgwRtc7e6j0QfN7ZbQWzOIlndlpeVeBV7Iq1fDMKmuHJhgyf6C0z31PI/z+?=
 =?us-ascii?Q?5QFJkESZoEjyfwk0YdHfGj+Ws6xShYr9SZBwsC69zF1N0GnnqK51vsex7RDT?=
 =?us-ascii?Q?QmD+3pVskDCJfSAiUmX1kFaCooqH26xNWyAlkDef+xxANWCt3Z/gwzyFpWmQ?=
 =?us-ascii?Q?epw2RuVnUNGb5REs30mwKGSdMuTmsWiH0i7rorj2y0XdOvCCsWXvpBMhiS1g?=
 =?us-ascii?Q?BnQZwbcvEq/n3vy9HUGU0k41XlvzG8Y8LI3etTFoPbiicJ5BnWhcjp3sZ1aV?=
 =?us-ascii?Q?Nw9Vpf4rkrjsjAF/idL/5opqQft8YAVJZ2TotmhfKuL8ID4R6wggMP7ejQVZ?=
 =?us-ascii?Q?pISZEQqGXHIB5ka/8x/Q2gbxv84wAQoPgAUMGzB/nRH+W5bCJYoMMqh0hcbk?=
 =?us-ascii?Q?VX5VWY7zyoDukncjt1d4UbBH7Pd4bxglJJ6IxZ98L2Ka+LOTTxpFvIFFv9/r?=
 =?us-ascii?Q?AfCmKYC6ZLTDFyafL4k09yyY6nMsT68RpHJLqkwr2qH5kk3+O4sK1V8P9mwu?=
 =?us-ascii?Q?aYoIQsQEhstkHAOh9kFi4Wv90Qhs8v0KlmXC0G5V1mnpY3qzteRPhmZH/VWo?=
 =?us-ascii?Q?JuQyMatOz6h3fXcvnHKLhOKsjt4R1MRw+YM+xrtmjKwmQ4EqLwHlClSH8Del?=
 =?us-ascii?Q?aA91AXDIxJXwbB16Y1NteqkFM7INhiWehiia4tHuz36kspuczxNWc/RS9aFR?=
 =?us-ascii?Q?8wFWXrgxKsIokikbNMJkeVpMd8uWdavZgPSNs9Dr+jcxGkbPtm5fdb7MdpTe?=
 =?us-ascii?Q?c31cRPVFWNL+wwimWEjaH6qEyjuNgtVwMpATk/VCaTeiPQp/i5gkp/KDjgnT?=
 =?us-ascii?Q?DkGdbMat38od+FcY4Oh2rvuJsGAnylQJDW/npUX6IBhf1q6d89b28x7a/cfG?=
 =?us-ascii?Q?JD2W7v9IAdh4EXh+0KwdV4LtVArhAZ98/HHyD+7IbXVFkIP4SlKhC19cQ1lM?=
 =?us-ascii?Q?3Iqsp4F1/pz1DBVIjJFQcXfSej1+Zpc2CD61ZsTJcgiRrWF1X0LddRJ8kIUv?=
 =?us-ascii?Q?guAQB/Q8idRaNpHJOh+0XuHDyPcZh2T5gc1USbyfRelD5a7gpOl3H3lDwU0G?=
 =?us-ascii?Q?sDzx5cHAkZxAHeSwp2IWw6VhmcU6DoT/B+MjnVmG9naVAEnjcYW2j8sIJOo4?=
 =?us-ascii?Q?u0IY8Swtuy7As8iMlFUibCLvKpUI0rBWQcdZ6IisdqYz0CIxmbelCG6MT4S3?=
 =?us-ascii?Q?qfFmhujBUfulZPfp5CY1Tg/bXBN+wEYPly54cJhmLL8wz5s9vs6GSFjlQKDx?=
 =?us-ascii?Q?5+SJ1NQe5nwGeT/Y3A1Y+S8jsmgr1Gn2av7gaOwkn8e3qQUWPLUYKtMDlScT?=
 =?us-ascii?Q?gHMAn47Ex2iCKOD1fDSomqmp7JHuHryuzHn3orziygDxubSu1olfx3BTqiZP?=
 =?us-ascii?Q?yAChPMT66VRHugRVMj7I9c0OoaWyshzuOLDsCyi9YXw4XpNQ891bjjNPFjvO?=
 =?us-ascii?Q?6ZtFNbQ2bwcVTvNuaCHZcZhclO68h+bmzNu3acQoK+W4lyaI/F+XTGSxddSY?=
 =?us-ascii?Q?vjd+pei3NW/pfv17hW0LfwxWWzOBYlE=3D?=
X-Exchange-RoutingPolicyChecked: qg3H4gEMGVzqfTpVOSwks14gSXxLxkMAZBTNjjg6n/bLwdPpp2aW8Lk7YUu9CCBFc561BAxNzGGoGUSbzOMuaGbKrYqPbO5uuA/3Yn45P5PH5gmMdqklDT2GJJRM8ojMHQriJIOPmOleLsRxkJ61L29A/G2VqtiH5bGDkADyMOJi5fp5THXjsouYqLnU1WuwA4EeODe1Ep/iibz/xKAowGasqfwIhCeN0MEk08E0wZkv2+a0qvXAbtV3OK8l1IcKdK7I3AinCZgzytr/r27xY15G7EMhSQ+zlUA01SCKsbSqnoA9Fy9L+oPebJ2VxTFoDVenbd2A5KJk8PdFEWPyRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c301df-84cd-4065-f375-08dec865e254
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:35:04.9115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wB3FRqmWbFqa7GHmS7sElyP7uuC6Op2QBU57pUZ2rWzZvUzacbatNXG6onaPLv5BTS8KazxnO3kidSJJXQVqE7iV1WTd++5pHXEmp4k91ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5312
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

On Wed, Jun 03, 2026 at 11:13:06AM -0700, Stephen Hemminger wrote:
> This driver has several numeric arguments but it was using
> atoi() which allows garbage and negative values.
> Convert to a helper using strtoul() with upper bound.
> 
> First found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reported-by: Denis Sergeev <denserg.edu@gmail.com>
> Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
