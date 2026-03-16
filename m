Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C6AF506E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 14:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70D2540654;
	Mon, 16 Mar 2026 15:37:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AA0CA4025E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 15:37:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773671832; x=1805207832;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lSbcog3Ofm/v+bHtS8yGpbOFdg0iTzrLxl5zQX79bVc=;
 b=WPIiR5gFmQ7IuUs96YfiS3vrv+jbrwUhSxLaLK6zK2buv9XZLc2E5DUX
 kn1jkz3XMMgclfCDjGEFOAs/BD7w2Ojc4m8SRc+Wkbk4Josm7mw6C0XnR
 9KToWwDp1RVx5/0D77BoYQbMRTyQLEQxpWrEEFT0N2830CrVoz7HHcJnO
 Af+L2v2+aF6DFbbgBbg5w+Dy5cRYSONtuLdjSy609mrJ22/1nwSn+Id/+
 Dr1IAAWmrmoXiZVKPxrunFltoqX2QPjk2pYwHHqWJQiRQ0YcLnPwLXSlZ
 Mo7EWASXbjcEdSbxUD9B9fsU0kXNgqvMqiDlNHGHX7CSvTp4Vn1iWNVvV g==;
X-CSE-ConnectionGUID: VCDE1o8OSb+1A6RX17T/Yw==
X-CSE-MsgGUID: BvSvqLQoRZGUVgpLgDU6pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="100145767"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="100145767"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:37:11 -0700
X-CSE-ConnectionGUID: qzscCp5RSGOxDw4paqBwaA==
X-CSE-MsgGUID: QZbWy2yfQPG60Q75nJhUWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="217756930"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 07:37:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:37:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 07:37:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 07:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giSHre22xIImlwX8FA3AVMJx1kzxFOhtEApXrdLaQBUkYYhw086A3RJVUmcwjzaeiDA1nwuAzvVL+xBuspG5KqSIMGsR/NDyxjFg+ta9JyiJAlD62NKjC0PHY7/8IALfs2qyAZIGLi3GfGRN31g3AEXyUBRFp4QfQPRMjYLa2itxSpS7mwMznyrVEhpaoZSrgGNkn3Jye+cVkN7ENwaVAH2Aao8COvpso1xDef1ZOpMF7FmhLzGuphUtyoLj960MFEvGKzLjj7qPX/HlQ6Fr9RsD58BrLTSDY6HSW5PnCpFI6hWllfN/uJpspzc1BAmpG69d4v/qlXm11787s9+Ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVgG9FKjyFleyNGe88DZ1s7RP4iFpFtUdBY96G45f1w=;
 b=XTIz/UHUYTW2WF8lOPrIsprQzUoiDPFl69n34eESJGJX9n3I7qhkPd2jjcspPOJHn08xHou+RW9o1Pw/hoUOGX35dNL9LFqm7NAPINbG+EA1mCSPMOBVrMSAlM3EaOOykwPE+q+tQA/SRflPkF+/zYWh5pU5Gu8XBZyzn0FRAyvg2bY7jQ0k5qVqRdebhFToLKY70kkUoPTu31TrgevkzmE09GpMace0ZhS6pZA4qKwktJr97wPv+ACNWNNgOepTGd/6hs8D+347+Dvm6MUiuCIY+1rCzneKGVsKFSWiW77IfFFvLKk32uF5240coXEkTuzCWjF5vyC1+upwcb9fgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 14:37:07 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 14:37:07 +0000
Date: Mon, 16 Mar 2026 14:37:02 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 20/25] net/pcap: add snapshot length devarg
Message-ID: <abgVjueKqc3FRbiJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-21-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-21-stephen@networkplumber.org>
X-ClientProxiedBy: DB8PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:110::30) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MN0PR11MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: d23a43ae-da0e-4294-c0fc-08de83697fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 33u7rP93dny6UJg9EREAz8XXMaE6+5wA4k7QHnM0UpagZNTF/zg18TGK8rKBO+hjAvUS8BnJLGYG5GF/B5lMyoURGBw7NfnAQAquBCXaKqJB2csi6Xdgk4vOQShYhBjiaO1uxcJmDEIl+hAGNh3tlVueJ3EWrqtRGeCiUz8dULCxvknQQh8ak99RYG3Cu7fyvslJGJBuDzb33GBwz3FRPmgbnUCCVLs2RoXqNzHwQTWtzgRs3B1H0gRHEmuYH/gjc5RIQQNRIZz1/FQFS0aHjwKOjghQMyydvD/axli2qIpJ8aMUPSoJ10/oIaq8aNhBifCfHwwEL8+YF4nkOTcrzK7gjBZfx9v9HS2zKQT24FgFiHuPJ4zqdrrKzVsCGbmyyV4BZqsES/hVQzwIs2xGkIZYM/xgcSgpf7wHw0iuWiTdwpuQByHeQxgAWcUIXrsdtGlKZOwhRmKpjulsOKYfFaZXmK5t4vEJ7DKQuAQuwYF3r4CAmssjJeUcxffEe9jZIbok85fNkWPL8nT3R492dZxyEOGF/X8iVzYRDWfuEVrDxbERIK9xk6rtcsRHBUWNI9bZT3GvJjGikIAZ4/lM4DMbGqVI7Fdp5L21lpzS9qr6U24645SAdhuSL/Av4I2A5zVCAVqy+Oep2PyZ1tzYnU3a2ECx5x4XaRAWfNM2tOEDTL35ukaNfIDQpxOrGVmel1wn+K5Oxn0Ct+zYcDIRU9zE7IfGyFSibcacAifwuK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jSzRqmHZhRvowfbmZ50vYjMT10Lu+8S1GMbKos2DxY2zaFVjyAKKSzyu2vQo?=
 =?us-ascii?Q?9AMwm/YgeTDxrVNG4OAeUgdU6TMWicTZnvY2CBoCmq5RY42R2kdlJrGEb6GT?=
 =?us-ascii?Q?IQdYgscZHleakgQ7vZonbSCZnUOs9kKN2IYauxD+1/13WxeX/RZp3rSL0ZDD?=
 =?us-ascii?Q?VJa7svi/yTVI4SaIGkw3cfWc9eKIImkyAU86HEiV2fwfwEdFLFojFJAYXL54?=
 =?us-ascii?Q?s4RiWo9z0NVZRvFAPE5nzFGMXJIDB6Qs6Bw//6SqCgjKIbXAYHAW6PUOmnFF?=
 =?us-ascii?Q?tUrWEfs6y6rmZAf7okqUUJPjp3biwNSzuJwSMi1eMEMaTpMtA+QzqMT/kVg+?=
 =?us-ascii?Q?LzNOAPwqYLNO41WURsg4lGIPyMds9Z1lY6gbKiPeOSiT3WRdIl0eNpJdEdEl?=
 =?us-ascii?Q?oiOflL62YPpaqJnO4bK0uXAYOgqEJgbg+Z0WM3x1UP+1r7Q3QPimQ0pvE1yX?=
 =?us-ascii?Q?XZRcXgCHG+oMdySe3MIM5P/QZ9SZVwwFQUWJr+3BYKuZgrGmmCa+ZTN+mXn3?=
 =?us-ascii?Q?DiCAu1/HHS+45HmWjZukRHFVj6LQsnM7xjxbVc9VhqzN6sbNSbhrPIHb03k2?=
 =?us-ascii?Q?KImBkzX0mT94A2e9Be6XKYTj8EIGvnx2IGe9zFcRt9bGm/6IUPj5UG/kAUcZ?=
 =?us-ascii?Q?EiiGJs+p6eqMObG2frXi913A9Q7zi4Tu5L9aU7x8eo79SXHqMEL+hCv+Z9/U?=
 =?us-ascii?Q?C6vEEJ+6SEGpmecPO6Ohgr7mIp6HaZYyvQzHGTFM7aytCv0jJJoBk6JPRar6?=
 =?us-ascii?Q?oZ+Ebu/9Qbwo/gQCXdgnZY/g01aq9+G0uCy/V3wrx9TD3zNLn/ERy4KToujY?=
 =?us-ascii?Q?jciFq70RwWkmuV23yEkG8pT3Ia8AnsomyrJ1gHr02CWaoC6scAYkijgS2LHa?=
 =?us-ascii?Q?Ov9Ae7CJFo+SSFDEWoAdGT3WQr7eBdICkvvG9IalYRbwl5k6KbrGQsBZVqQL?=
 =?us-ascii?Q?FmYSrsWl/A+0O4XMti7qZtaQhfuQMhV8D36oMrXTplqKXVbKOYSewzjAP6gJ?=
 =?us-ascii?Q?/sDUvJ5m8fZxKyYrB1gQIbOemdVzAxz87PY//Z2O5uhrahBm4Y+1M8at8Ner?=
 =?us-ascii?Q?Z8N6wUQgjnmUzC3uCOH481zemG2m1FVUmDTHrfV0ZA+Ew2o+dEMnyHaALasK?=
 =?us-ascii?Q?25jOoXaHsxHjludIp1mMJvAj/goAck3cNUvHNfuaeDVG7bTnex9pLq+VxAFf?=
 =?us-ascii?Q?zB5mlmya+LuTNhcVNoTpi7aWekUHkqn4HDo0HszgzxWitwS29mlv4ARcm0fy?=
 =?us-ascii?Q?k4xciXZb+T/e5HbyJx+EOzTQYKEqQUJmPVZMHranL+DwWjjsdbDWdT2i8gwF?=
 =?us-ascii?Q?BVdCYO7I2MmIxaCzz8ld21b56F4sLZvspPnTV3wWUI4+XYItNYUvJX0Ds92D?=
 =?us-ascii?Q?HBNZoPoYqR7duELEp9cS95dCtYvXFwBmWDUbyHRqOPLc8190QEMim7LmmRDI?=
 =?us-ascii?Q?CvCoT5YH/y+YDTrzR/EJPqp97wRChDH2qjFnQJzL0I4IYqwPybFTPaBZGKkx?=
 =?us-ascii?Q?CeKsz9/ak62DACBK1QZEgSBRFuMe6ksB/rA4DGIaUoa9EIpS2DOxGG1P/Ajt?=
 =?us-ascii?Q?Neh47nm0z/wFd9X0Xr11X1DYpdEncyBEaSsylz5w2FuAGKL9mBP6eeqH3T3K?=
 =?us-ascii?Q?0oFdi0HaSZp7/GRHd4kWAzkf4BF3nFhBAfit6rKTG8KKhrJTJBOHV5NwxhHl?=
 =?us-ascii?Q?HBkyozETvUzrx5ptfEiXhzcsmNAlzudeqlt1xOOn4lvUgcy/etaqMozH9/0N?=
 =?us-ascii?Q?Dev/Lo1kd8xqh9xiAjvSMn+nFeDTgJs=3D?=
X-Exchange-RoutingPolicyChecked: U8ZLEmYXv9CrlnRhI9GRmiAbXMYxQ+YWcmfwgHABmIfFdwzJvmwVs708Zgbs8Wvec627g7UdZ73X8diWzk/jFaPKzT2uNSSg5E4S2ZDJ0Ts5tzzXmKCUs7EqJBv+EssibE5QquNjaanFZm7VaDgowwbdG9VLINtXrMPjKD6MHkFiTbVsIyqdD+iU0Pe9BTjXuMdYLQoSyKYnUYIW9e89IQEJk8awkAxZ7nf0QflbLVG6/CxmdLuShN0efnx1dMQmeMGCR17ADgmOO79C2T4wVyqCHYHnUDbf659RZaT2uJavMUyJ1df1xsNs8E6beG96hL/8iX3qusqRgz56F9sN0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d23a43ae-da0e-4294-c0fc-08de83697fdb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:37:07.4332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uscv6HVGZY7p5+QafxkmbaG0PR1ixzNOvRuHhEIulbio1u4Vs4T2EgSEhZnDOmhKVmMXd9hHgS8UUNvquexWxW57pqWg5OsVGIsuk+XUuvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
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

On Tue, Mar 10, 2026 at 09:09:58AM -0700, Stephen Hemminger wrote:
> Add a new devarg 'snaplen' to configure the pcap snapshot length,
> which controls the maximum packet size for capture and output.
> 
> The snapshot length affects:
> - The pcap_set_snaplen() call when capturing from interfaces
> - The pcap_open_dead() snapshot parameter for output files
> - The reported max_rx_pktlen in device info
> - The reported max_mtu in device info (snaplen - ethernet header)
> 
> The default value is 65535 bytes, preserving backward compatibility
> with previous driver behavior.
> 
> The snaplen argument is parsed before interface and file arguments
> so that its value is available when pcap handles are opened during
> device creation.
> 
> Example usage:
>   --vdev 'net_pcap0,snaplen=1518,iface=eth0'
>   --vdev 'net_pcap0,snaplen=9000,rx_pcap=in.pcap,tx_pcap=out.pcap'
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

