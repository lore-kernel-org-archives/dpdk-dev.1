Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D6EC87FCE
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:41:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA464402F0;
	Fri, 25 Jul 2025 15:41:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7FFBC40144
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753450864; x=1784986864;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6UN971xMTJR1TBJvIj1ld1jaz23C7ovbHKsoTLYc00U=;
 b=HTzKe/yZvespZt2DMHnlgeGXZAwKbSh19zwDGtSWbRzfnt1lc79Br/Ms
 LxmHka7KkXOFaxv8nEmSS3rgmP3x692kSVmcIe3NChhrFX+DAaJJqnRyD
 0kmXfCDAsNSK9J8m7eB+HDc89Yn9j2tZFMhfZl8+I2etllvrGaLN9Gpbr
 6SRJImBB2zs/zlARm2WiQJcIgwZ5GkKlJtw8XCe0et4Y0Rf8nhEXeUliO
 n6Va/MweqHbq3VRlhFSrUtDmcJcQDhF7FQyomIJLQ1VGX7gDvJUqY2rKx
 C4W5e0fiDxxWJIzEHis+jpAWPF44NBvcn3mQ7kajJ9RfNNTabMC3rO+uQ g==;
X-CSE-ConnectionGUID: mJiwajeES7me3qDAeqp2Dw==
X-CSE-MsgGUID: f2ekUboVSiyG1lXLK1D21Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55724919"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="55724919"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:41:02 -0700
X-CSE-ConnectionGUID: 6GdiBxO0SIGcvNNHhH13wg==
X-CSE-MsgGUID: yuba/QrASMm2Jf88U7Q3KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="198057045"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:41:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:41:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 06:41:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyWp4gtDrgHzyZkJGlPfS0r7zJG8b46//t/+RQHYVOSYcDohY2DxmxqCkKaitrbU5Nh5t6EzZnXR9r4dxOoP812kb5rz5Nw9q3/1JfTg5W65UvThBDYbvVf2D9Hsy4+0UCd+8zh555HCCX39DgT80Y8oEwsDWVbyNL4b8nDmZAQa669ytu4tXVRyloU7zuGsWXjiZlzTPWoG4hdYxK0cSXz/vf3MQuYJcQJB4ZIAzuF6mBJXzg+t5bSrss00yoboVqUmxIKSX0xzMgWF5aYifje9zrt81ChEbk7Xji1qyoAwhRu7AreAuf5i1n09JAoKUUorqUGlInFZOIkexSfhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDV2YKnutNvoET1oQqHVSFAXmTLkNwUA72B+k51qVQ8=;
 b=Z/zNo5zwoOjqZ64IQZ8Toet0usjdBZbim54DjMnCNbHyng3qWPCvjbFD4AXk3P6RliggAL+017k0KgdjBNUZOGlmlF4KB8z+AZUQC0TyfZoM5IaqzJ18wCY+DlTtghrFZ3GW3zmajlmNi0WZujyvtOOG93jgHNDWUYQ0NgEVRQajhgblkzZtdR7AwOJBadVnM2uB8INLZCSj/nrfpOtQ/Ht2pZIJabHLqIKoxL18/elLm1LPutxhSOL1ycJwiR4FcDh7YdGFcC1dL5S1ixVNyMGA+mf7J12ROQv0Maa4ud1dZvixLlbtynN1KY4O1QBy+FQ3L8NejqAyEG5/tzablw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 13:40:58 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:40:58 +0000
Date: Fri, 25 Jul 2025 14:40:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 02/14] net/iavf: rename Rx/Tx function type variables
Message-ID: <aIOJZTpN6aZuiSq_@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DB3PR06CA0032.eurprd06.prod.outlook.com (2603:10a6:8:1::45)
 To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: caf4f00b-dcbd-4853-7982-08ddcb80e2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3jzkseb+9WoidRgaE4mJIy1QwsU9yjxHh/16W4PNo0OuUssg1rqZ7EYyX6I?=
 =?us-ascii?Q?bMuQGFWs6Qva3OjZrSxOQIUSyuVVuTnQYl/GLKX2Ya1PH6JO9qGAeElgyz7f?=
 =?us-ascii?Q?7T9j2l4Fur1zbJNw766NpcsROG1njrRJtSZVeoaWiWrQKin8ELWx63GEF4N+?=
 =?us-ascii?Q?sTFRwInVhLLv8JmFC/N1gfvZa7zj2e2r8AgFzvIsKzqsn+D0S2fUVMpoTuJL?=
 =?us-ascii?Q?QOR61OetvAi5W/Ofc2vN2EdAI7zbmMuTwP/gW3z6dGYtbwLgoIQSvnNNrI3m?=
 =?us-ascii?Q?+9+cqGV43vl0MSOSEbwxADxlfhEzQT3XozLV2X5RkJ9Xq4OcDcSetkzawmdn?=
 =?us-ascii?Q?sINTvzESM/QbU+sLcAxvUd+J2D4Larv9dJQYtzvSu2v8BI2Ir1aEUDjnMrP3?=
 =?us-ascii?Q?U+wk/GAVRKcP2ZigodIYZk54NydqssF1TNbKbr4i0H8y7rFVuGyVQhUSF7yX?=
 =?us-ascii?Q?bAsUP/WXyXlB2AknG8K7THwI8nNp8fce7W8LY3afeqlIaw/M3GSnlgcRQm8c?=
 =?us-ascii?Q?L83W3ij5PBw3Ay2w8O6d5ZzTbU1dpl+cJrHVIZmVSY7P7FltpRdmsDnM67MH?=
 =?us-ascii?Q?rLN79YPrppB75QTNHjKI9b2WFWaoPfPwo7cDXkivjwuJfXp89qxEHQ5D7jR3?=
 =?us-ascii?Q?kenSfUykKQvRjcga2ACm1oe3a3NJ6sx1k2lL1uknCFihMbYUm6XU6h96cwLZ?=
 =?us-ascii?Q?/xikVRGmH1MttNrN3iwvnT6wj/bP2UymfjnKnhi7jweh53qNKn4QrLlgc28y?=
 =?us-ascii?Q?vuyoFDnQO+iVNJ0XrKpygBlCrzzGg3XgdZMSZ4n0qcC/iswUbViQ2CzSyQx/?=
 =?us-ascii?Q?N9F2USaJZCSU+Ki7KFf59MlCrwZ5+jpkzhX5fdmlC0pCI8WCA4tQ1syyw51o?=
 =?us-ascii?Q?Atn3CkF06QGDiPCfav6EQfptvqpCA6GpFXFuAs/0Q60JH3lDYgv1O1Ae6bMC?=
 =?us-ascii?Q?6l/ai4yGzCyQLPpC13D9H32s2a0mZOtzvyYxKIjwWJO8uOtQY2Cj2/7sx8x0?=
 =?us-ascii?Q?JXjVeDJZMRoAQrier1ivq1OCASLA78tCKN+eHThj5uDOlJQq7WrZWPVTxDMS?=
 =?us-ascii?Q?HxH/o/oOcGy3b74v24+tlRkenb42eNwyl32KxmMgQNVYgjnBGrhVooDdzYlF?=
 =?us-ascii?Q?Cqf5MP2j4M1xYIjJuj7KzqutssY6sSHsXy01lH1fkxJdHMRW9D3hlokKEl8J?=
 =?us-ascii?Q?e4EugyiSuN5JUQx9HYwiz2vThyUtjujJtbK4TCUSgFnLKFhY4j6iDKRMHQv8?=
 =?us-ascii?Q?U413h3a0ksSUW7aRWuKNUfpjAzHo319FQBWrmrmzzW/K3lS0mtsg7TUK1c7y?=
 =?us-ascii?Q?byTA+nsWa/YDwQaaddqb38okOrazpmhOsxRdc35KHiUN8L7aDaepG9YrrDmo?=
 =?us-ascii?Q?mVKPZ7ydM/gb6ZNTu9cSNHP8Jn9D+VYyqRWYC0ErAQopYh+dWz23P39T13Vf?=
 =?us-ascii?Q?mnDPDjOzCGw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RLs9DxI9dW1FZynHagZnPPVW7q6t64tWc4i3BGtB0SuSsIgEZBzy789xbo4x?=
 =?us-ascii?Q?kZ31JZpWX5VhiYQ6k2igP8idvkDWnHNG6q7La+XoAycCIGDN2clqG8H9M1nH?=
 =?us-ascii?Q?sMU8lCcPMTwVK05s/gJv56T15ppTZw5DcQopWQ7QbbEDlalS1wFt/enLrvjS?=
 =?us-ascii?Q?YhBACipLffjK9y8KXmHk2CQknXC4N4RbMrcsMtgXESf9gzeqo5PjMufovTas?=
 =?us-ascii?Q?daXhQvYIWjC7Ne+4ZtzyGx1JmQS/DJ8eKIePhg1vxpDx4z+1YkqbHhM98Dmn?=
 =?us-ascii?Q?nhCAcgG8KUUjOkkRu5JBVnfxA+mFA3OWLkkfBLtpo2mzIJHIoAWScx5XgR8e?=
 =?us-ascii?Q?joV+Vw+VP1llRWQuyRVMuNXiL99W2CSEzw+kXCQs8e2rWFjmlKwkgi4up40f?=
 =?us-ascii?Q?Zh4ZcagCyeg+pEW6daBb6hNqgLF7dQgy09VMpmWhvEYBuVkYQ4UJZUITKPiX?=
 =?us-ascii?Q?aHjplqeZUKlDywIbS6B8aJRivAVRVBdm/DPoLmE3JPw2CHUYr2DtEGrl+k1R?=
 =?us-ascii?Q?0EZDonWLQ37OLKbRDEsUaKKfMHIM9T/SHZOvFMIWMC10L7XN4u0yRSH3KDX+?=
 =?us-ascii?Q?mE92I5hC6AUaWB2S16+6la7p59XNNtQzxxA2F5L5EhAP1BHjcNfldrvLkUNK?=
 =?us-ascii?Q?86pD04bpwe/9H50FW9Z2yHTUOoFqZQ359eh2c82sS03TS7l9XFl01lD/D42v?=
 =?us-ascii?Q?JrMj6Mr2Z0JFa5L/YOstY7Xkxm4gtMyhrkkupqaT0quO6OrFhHvQHlP85TX/?=
 =?us-ascii?Q?X9l5sJq0oVKkY0O6AOOVX9xIikh/IUWtQptdR6IndQAOJmdoSpi8Je/37D/l?=
 =?us-ascii?Q?8rZVJ3l6hUEiejllNVwHreM7N08vHVMZPU2x4Rnv4Y6C5Z2CGa9HJYD9OBFc?=
 =?us-ascii?Q?Gn/Zs4jtAvHgXi6k4rLJpJF1WOvT3BWnR8PIMDGtqu20tLd3SnZvCTy37Ik5?=
 =?us-ascii?Q?h3wPPJV2Od5j42SSJyzxyUCfYjg59vKiWEU6Dqbts9NY57LynkvMP4MCgajG?=
 =?us-ascii?Q?/IITagriAVi3GgjMmsIR0L8m1ZVowyqOyHNRaDk02UYnKY7KgdnvC7H1VUCs?=
 =?us-ascii?Q?2SxZSN0XlVhvrf1MheGcTMSjvuhOi+f7OZSfh0YkLBaxnjHqF4b17d+kpI8U?=
 =?us-ascii?Q?1kw4SmnBZcQ/YFhB1ye/qjv/2lbRotOL37KAww/kHSklaiB1vGVs1KPD8jEh?=
 =?us-ascii?Q?6gAp5uu3RaKlreci6PWIzLa+eksDCuNNp8FuybOD01nweuoi7b0wKK8IBINi?=
 =?us-ascii?Q?jlLJ50cTwlJyrX6aRaXEp5T2kzBIB1n461CehyJM8VY2LEsHWlQgKLb1t0O1?=
 =?us-ascii?Q?05CLVoCTy3c6ppxGw6+A6HJXioUlAUraNpiXWPWwwDGyO/wb7T3hMgPVgb1s?=
 =?us-ascii?Q?81qCsAq1tliajJM4rYt90dJMj8Mj57FXtxZ7+MHcYau2BDr9aaZElQeO10Df?=
 =?us-ascii?Q?u2TOrzaezJ0Yh0guzMmeByfsoBA/RW5mWbngtzOvkO0DQ4jCk/zMRHNoZl4d?=
 =?us-ascii?Q?A5jbtFO0bVIEEkfiSI2ewuKhhe+qwhjjSnPmUrOpFOWkWcaOg40L39ky2lqN?=
 =?us-ascii?Q?MW75BDBuesktYEe5vXapYqNvraefjHb9kSNjaB/Z2AWfABJvz6JV2i2CXnY5?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caf4f00b-dcbd-4853-7982-08ddcb80e2ea
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:40:58.1066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5w3nP/ognUPPNPBpwTNK5X4F07iUsltrG2Aj+2RWE8hEcf3U0+Z1sIf8uO8drLCAIYSmruNx4VAawdCxTX6O6QWB5YQpETRxX2pV7gXZ/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
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

On Fri, Jul 25, 2025 at 12:49:07PM +0000, Ciara Loftus wrote:
> Rename variables from burst_type to func_type to better reflect
> the information the variables are storing.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

