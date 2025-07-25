Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CAFC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 15:22:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A77854064E;
	Fri, 25 Jul 2025 17:22:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 57408402A8
 for <dev@dpdk.org>; Fri, 25 Jul 2025 17:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753456966; x=1784992966;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=N5Eu9CELjvO5/+W+qW2m3BgzabRf0ivC3djUXi0+pZk=;
 b=hACCUfaLN7fAKnzLwVURSHiw3gxKE/7ankm7YDqtVwwcRqLvsZNGlZoJ
 7thchWDjrbeIJ0U/98o09QBMr5RNbcRJZW7a2sgPDfzqvuPm+Lso76zGv
 F5pxKbebmK8uFZduoep3hwnbohWe+KIBWZNof8Wom8BzY7QTIv9pdjFYH
 d+Jt1H7phVuaEU3K9hmvfX7Jyl/bEDCkc1KozOLpKNHVCADItzhsWJSL4
 pjLvZdIJTQ+jQSLB7zbEOmth/oM7YWNJQhlKMW0Bt66pUlFpmlKZRlNBc
 fvoLXoe7Id+qZVb2WYn10oR6MZN5owx7d/fNMWXHy9TxQ4fW8L/B7WrLp g==;
X-CSE-ConnectionGUID: SwroJbXXSDC/DX+6sxqwzA==
X-CSE-MsgGUID: YnBCcCxZT/O3APakyxRPCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55758308"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="55758308"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 08:22:45 -0700
X-CSE-ConnectionGUID: tsR/nqQcRsmZxI2UC3T5XQ==
X-CSE-MsgGUID: lpuppMNOToqczIns9ltc3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="160961249"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 08:22:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 08:22:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 08:22:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 08:22:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGAx8t//qnz1ijtf2KA8/+eY+TMNxTMVvec8iiCqzxklJiK4red9vVk40olc8+7wB96fAkIZbY7HrG/pDr3UyhwXoeQOZyzvZ127l0KgMHsuktNBybY6ItQYFlFkCq/OdfAbbgkhm00DePmMcWRt9pNlhw4DZ6TnyTTOMenL40RTMzu3tcE5PCa7lHRF1pAtVn8JR8ARVVwmZHlDNXQS7pa0jKgn2uEHYk5WHulc1M7YYY3m4yTG3GWh3WOmutc3W+pO1UmTVXimBsH/ImnVT2/d1BCvqBjwFegg5hvLfkEO1Ux+ObYqMLS8EXRvmH32tRdxjGS5IYCFXf30hVuRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBDuMQ1A8kDBE9Tnx9D+n0VxRsDSrJ7RYb/mKbLh5D0=;
 b=GlB0nDp/gm5fxmNuhMIrXxjJS/0FSSI32IjbA0ge8CFy12B/9bVmHADWONhRoAnhfz2x8YoPyVe0C82hWIAxE00H5idrLFN+o+nFtqHQUULcLQfkU0Phe6FiLRCYMElW7e9HK4Z4Qe9y4kEmpqjgCm5XWfecQnYt/pJ9iSoHvKwTAOhFapnw564zKqLpBvmkYkjERXV0rAIkL50FSN+yDRCtyCIKqautvmLfjxw+1FCTAUN5hJJ4FjWbrsrtMlWfC3UWZlKvo935/Sa6FhRfIkFqG0ZKLBHwqK9RaLhxlcAP7kRY2wi8J+nsLP4Pc2ohmMuY1ysi+upZ6Oz1Mqjs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH7PR11MB8273.namprd11.prod.outlook.com (2603:10b6:510:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 15:22:40 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 15:22:40 +0000
Date: Fri, 25 Jul 2025 16:22:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 11/14] net/ice: remove unsupported Rx offload
Message-ID: <aIOhOwC0jDtM-XBD@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-12-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-12-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0013.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::18) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH7PR11MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f710b9d-ada2-40ef-5a1c-08ddcb8f186d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Gb1nnsUn1C33BSDUQXAuCr4OZmLbZxfdFOD4Ho1Hlz036u/0OtaK9LozDml?=
 =?us-ascii?Q?C/0NA5Z2FNwnkyYF3svlMkKcu6S0sTfxuKjSutoZq1ZMgkXFvLn8vpbH/P1b?=
 =?us-ascii?Q?8I2s7qGZi5AsaKBNhsNI0OSiT/n1mrx/Oa3mo06BLaWlokyrXBqVdUJjSXMZ?=
 =?us-ascii?Q?SAvGWGEw7cvB5I5T7OJnZLmKXJQBubZIeGMHpCHxUiAdXEsb8lYgflvwUNZM?=
 =?us-ascii?Q?hxI/vj01haJJDeb6V49vd+UCVJUcb5nx5SWKRHyjdNr13fnTjI8WYwUmn1sj?=
 =?us-ascii?Q?X9SmAQOdFewZ1sJYTTUYvwerJeONKhKBfzkkJ5BykqhK4OQfrUI1o3RzEKOs?=
 =?us-ascii?Q?ASrBk65ua6TBCIAapWPfXkx01rvKoqy7erw2fFyHJoHaz+usB8RV9wS8Kn08?=
 =?us-ascii?Q?rtPJruUq4eY2MPOm/f6n3PAjrNjr3RWWroIMnQW9wBX0LlBoJjBhPPfZg9NP?=
 =?us-ascii?Q?yDQXBNTJw9U+Jc2tzvLVDtSa4kis/2TsLg4xVe6Mu1OfauLwNcqM+7smRm1j?=
 =?us-ascii?Q?8Usw1N5du4Ti+9FIRqyLNhmmXsconYO3igGc6KMotEexL63hf/4y0GC+piqS?=
 =?us-ascii?Q?J9ka/6EAimcEAoVZi0rMXYTbrn90EESvRWl8YBN/FS29+wQwhGiYWIDBAbdG?=
 =?us-ascii?Q?6rkgDsESZCtv1/4UGla+1dxNw/Unm5pl0WCni+PDdZhkp0MX/BWGik1fzm4G?=
 =?us-ascii?Q?ONvafskan5ze4nSH2L1ONIsLls5zGqFw6TXEkQ8ghVyF8Y99GXCEg0RyZCm8?=
 =?us-ascii?Q?Yd0z+0Odp5whEapMmDJolmlfO68UEhDEdMBVNzR03CahOmYnH/PlgNjF+CtS?=
 =?us-ascii?Q?P6BeYkWwQTFYhEog4ouGEpBjDotbTDs+7yC4Zl710kji5RhtwtJEyoiAiLeD?=
 =?us-ascii?Q?Ewao7S61P4b0mC6EzfgLuuJ1tygOcqm2qlnMWmnMMgqtQfoqK2zTQGvhcgy+?=
 =?us-ascii?Q?HweNMMF0vOZqTqbyKmEcz9k48pVuDuhSAwEn5uuPIiNhSmbOE0p5dsmKWVnO?=
 =?us-ascii?Q?gUgExzLlFr3ZClmj0ai3OS8e0NjgCcr1TfQ+TMQUisDMJ9oLDjBkmM5yu2YU?=
 =?us-ascii?Q?w80tD9ueBHgSHveLlvfc42bdKgvx6gN6wTO3+NKjM8m2MpmauBZpWH+U47OL?=
 =?us-ascii?Q?poR5sCaNRUwPnJJ8YZd+S02CBQheUwYNTaylBhFjndY9EdDFXxzCi4+UzwCP?=
 =?us-ascii?Q?sornUPGpyZCD8v0vXmJttxVzluLP/zO2RFZAGwRTbgpr6RSCa1u6roD3KkJn?=
 =?us-ascii?Q?PbgBAzlr2+o0PGda4itbnEx87I06uff6EdXXwwDmT0LAdF6uhMCN/TiT7nSB?=
 =?us-ascii?Q?NK43lCKpG/CopNQemK86CxrK1Abvs6HXlQg9yLA2nt/HkRjV6W3ARyibfvd1?=
 =?us-ascii?Q?lABLt45z8XYByst8FX8FZ3lvr5iuyUEbKjOMFLDykwqVcU91Iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BF08dXNga/BagUnZZvVBkUag0IYCASf5JOk3WJAB3WEPKC6R5p/3XzT6XPgB?=
 =?us-ascii?Q?FHRwpaezUgytNzrWiEONVNzdIC7jFeqPBNqRs/fV4NMszbLH5VXS+vJ0waVA?=
 =?us-ascii?Q?DA0tlTnV2qsuiyj7+VvFth+Tx2Qa5Nbk1Z2tspsFGWBYP2mBVNRCQrIpU5fO?=
 =?us-ascii?Q?kg15sxuW8+tYXD8iPVBsq47VOSwdPfwhHo39Ud00gtuxKIRdcR7cShLvsm3q?=
 =?us-ascii?Q?xoWT1fB2zu1jDjFFTY0wJHD/20xQw9iIlqm55kGx89fBZAQbGGgplFefua9S?=
 =?us-ascii?Q?C0h6MibB+KDEzOQxuAyVptFkgSRnDsGEUYn099XUUZFRe5r0KKc69VcL9/G/?=
 =?us-ascii?Q?HywXKTbQKDbHIXVVAvfAiVaBXPErVStLuNOpJx3Ud9ilJbCCqIpucRSZw28o?=
 =?us-ascii?Q?/0EU0tDl9F2HkL1YbkFch1e+xd/O2O74+mgIKEVMNaE+g79cj3PaED7LpGj0?=
 =?us-ascii?Q?jrbaVe+xAFWhq4cqMU/EV5dW1kmLGJJ86YkGMxiFhmLbX6gpsXYmvj97CQ5X?=
 =?us-ascii?Q?tiilrL0S1ik66oe5+smL/D4GKxHnEUnzHYn9KQyJslu1vIEwmnz8g8Wao1+q?=
 =?us-ascii?Q?r4DEUa9sne2SNfBdyAQWfhcWL+KL0usV02ntrcTmghR5ZSOdMmwFhooJxnpp?=
 =?us-ascii?Q?RndeFZ4BvO+bAgyg2Pyd2GcIP4HlgejXG+Toeoq6VRXNvwrVHDo/n6w12U4h?=
 =?us-ascii?Q?85UD8QPaKfrfyzlsvKzQ6rfonBiFT6LpIWkft05JpoP/Lfmdr//+2idDeQxO?=
 =?us-ascii?Q?SHOf4X4MG6YL360xi9xm2RJ3bRRvMN/Mb/MxivmoD14qdzEAYNZn67unFLVQ?=
 =?us-ascii?Q?EoNRPetad91naXyd+4Kf5NApa9CBY8TrTiLqaCxo0H+F6GovcGkB3UGYodgy?=
 =?us-ascii?Q?VGVpT6KaWkGjs8Nsqv/xKUrkXEHZW6I+fRNsMF68gdKhAgBRufIDpN1RRRxn?=
 =?us-ascii?Q?eo/5sfeies8+nYCVGGteaxah3+fQ+yka1w6JHMHMaBLbXg6yuufnoBc/loIl?=
 =?us-ascii?Q?qhITf62K8IkQpybGSrE99LaFd1yZcFjOqLosfN+uvxVIYQrWB2AjwF2qgaIi?=
 =?us-ascii?Q?WbRM5+pcDJLKs0fVaInsvugAxtyB/KauGZbQz+DtZat9Z6b1t/DyYazkfhBf?=
 =?us-ascii?Q?rnT1WvSsEwq3qBaj2aujWYQv0twplDIraammrzvuSUVhk2A0KdBcDghxFzge?=
 =?us-ascii?Q?0jWajqFm7Ny7qakqtLaQ8IOJZFygqozgNVUzAtyj+ju1V66h/4pRyP5nuNV/?=
 =?us-ascii?Q?go2EQb74X/mnEfmfIVtJZOkaf2eSKHqYsJbVRqkLkFz5SiL6gFiTnHS4zkrU?=
 =?us-ascii?Q?1bzayll1w1WT0nLoprkUvAZo2Kp+RNMwo1egusBLDwa8VQUSR4OcuQqHO2Ji?=
 =?us-ascii?Q?BS+to3NnTTR2VtIfuatSfS+elHN4usnbSVrj9WC9CZnAPA4o1kdPth2Sdjzr?=
 =?us-ascii?Q?Y4DQQqAbX8AtpAXl8bi53SKk8e5fxKAD3kIUTCbXqhTFC8yORnSu8/aaw4FM?=
 =?us-ascii?Q?aumA+Yu4CVFCxxD2v+W4nk+w0pom65oq2LhmDYOhy02tqSe+/hn3O8ClG4o+?=
 =?us-ascii?Q?yFDIj6aCZKBnTS03Z54LBcM782XvUDz1T4E/1NUQ+GYhmmNddG9Mh0QBzNDf?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f710b9d-ada2-40ef-5a1c-08ddcb8f186d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 15:22:40.8139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNLlCKtdxMpUhbJS0Bbs5JijGEo/VeEa0qDqa7J5QeCbCIRrSJfRy6/XbM/N2v4XE7KrV/YnVTmsRTA+982aXCGlOKneugew8vL3zin0FCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8273
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

On Fri, Jul 25, 2025 at 12:49:16PM +0000, Ciara Loftus wrote:
> The offload RTE_ETH_RX_OFFLOAD_SCTP_CKSUM is not supported in the ice
> driver so remove the one erronous use of it.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
