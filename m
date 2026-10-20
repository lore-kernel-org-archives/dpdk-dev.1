Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA24E606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I+wxVwCb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2604D40270;
	Tue, 20 Oct 2026 11:50:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 069A840144;
 Tue, 20 Oct 2026 11:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792489828; x=1824025828;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=z4lh8wr6HB2fvrYTpjhAqIAmqeHQvbfLZYxE0otP71U=;
 b=I+wxVwCbal2SgJ44kYIOPp6QwRzy8Eh0OjbSeJC4AZ65l8cbXHaBha8X
 p2PJXknn4JRpw5PWN8J1Zgx80xkv//4+JSax+83UfHuPPpSFBaUNbdiJW
 hKIXCD5pnikf/x14VwI4G27tyi9AeGxbmXpuKlATigW2zYOQoshSA1Q/L
 5bX4H99v9fqGSo9nBPQgZVodiRzwAUu3qqT+MsZsQfJwPWn4D5jBFEKuP
 PGtOg4YSOnjSSjhAc/NyZIy2cOStVzMBkb1BiEYpzuiTQ7jL/OxcWVLts
 aDV9xNXStePQvdxN39MmJdIUg2SZF/Bkrj3pM/v5pv5N7jAaZOVhqCxV9 g==;
X-CSE-ConnectionGUID: X2P+0lTYRXio6RY/zeMjsg==
X-CSE-MsgGUID: 7kWpbRVNTwydEkIWbSPQIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1067451"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1067451"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:50:26 -0700
X-CSE-ConnectionGUID: GJQr3xzPSd63VEa+ikdDnQ==
X-CSE-MsgGUID: B3AONCvGQuqaKqMYivAJiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3189021"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:50:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:50:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 02:50:25 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:50:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txn5RWOBRNxqvKa1MbRUNuagCS5vO/sqDsSvU7dn8NeoISNVWJPGJ6QIiFcw1hJM2jkeJuKB2HjPCg2mcRb7/ci68uOEwvwr6WQIN2u/fG/H4m2ws+YEZ9QQ7CPj+HSO8XCQs4vzR92/Bs4hdymZvUlmhXbiLDzqjDWTyESQy/9QSrD9+m4NK4jxtTdoarjtQxIgQOPw16vi4a8a8sW606vrg5fXV5BtVT3oseL4J3Ck4+nnYrp5FXoI+kOmChq+88AjCwf8hAwFxQZgMmo8mMv885g704Cn+EObWlbpHV2mipmPVbFJYI7vfAqtRn0Q+42NzhvuCzD27+4XRuQcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMlEFXQpCX7SvSmNLGDhRBg95Q4uronVVjYHy/erdUo=;
 b=uUBT1v9vtHJNxG1WJM4AhlCyxOIzjSYUQFOa3bqkpdVaRGvf0tUJZLPiROTj8uVZaP1qZNVkzwU46YSqZb3zsa25vY3VLyJyatJou3i6BgL5XwPQPXBvYlas6EhJpVZeahynJ/wO3EFdDe0ygT7Ffd6xfoCyoYIOBW+lIFSlfaNkHfg52kzDGdWvW90FCYew3si6FeNGTzek7zejNKjDVIsr2zKEPzcZo6OUvMVQMeFRY2IpvOzeKKayOERU7jh1w+xSic1w3Me163Z3eXweCvsYZAqtEYVZAkFRKvPamwBqfeg9qJmHvpJbZ59fpLIIxGJ6o3T3g/1maxntFh6fuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:50:17 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:50:17 +0000
Date: Tue, 20 Oct 2026 10:50:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>,
 <anatoly.burakov@intel.com>, <marek.kasiewicz@intel.com>, <stable@dpdk.org>,
 Ting Xu <ting.xu@intel.com>, Qiming Yang <qiming.yang@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>
Subject: Re: [PATCH 3/3] net/iavf: fix crash in TM ops without QoS capability
Message-ID: <atc5U95AYFis8IYB@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
 <20261014122419.631288-4-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014122419.631288-4-dawid.wesierski@intel.com>
X-ClientProxiedBy: DU2PR04CA0267.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::32) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BN9PR11MB5292:EE_
X-MS-Office365-Filtering-Correlation-Id: b765be72-3249-4944-e09d-08df2e8f8bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: QgHd0sh/QrnCKiOqUwSLa/SUrd5492agS1/Vn3P7EvK4ti2LcPzK839iSDzBLxAQydHOaA7UsS5VwKibH4iKfNAx6p6dwXbKAnwPeacAA9eL7eat4exF0teiTQnTPtwVrewe9c5n+7vcv4tplVpU2IvpxHCzgXRGjQK9OxmUBBOLvsdNNR3mND0/1040RnR6lcO/mWTXZY1qT82ifRY1ozSuOPCPMPdmRjmj6VR8ZDfwcmSn3hrAee3b2jk/3a0qgWRXqNSv+jXyLcJsJAVNsgE/QpYWONT5mAP/8pQ/ugFa0O24U559h0ryfqnEF7+wLNJNKthgcBcyLifP/mkX6RBJESPe5U6PF3ddE1vhpw5Q0ChCUe7rpqmZ3ZSFwI5L31fURYov+VPlPjmGhP2U/+9ZzV9i3wyH+2vzZCs1E+4js9gcNL6pIyVzQ773hIVfpthDHObnryEl+Z8GRTPaiClmYAa4sQl3ZLremKMezCHbJITWfIDaKc214yjPeoApBYl0jMX2tZSk9VzJUx8o+xYgF82AuTRanYqg/lhWRqXMlP3iKMzMF81W8RGNVy7tDq67K/F0JW2U45h7ahkxjzqfBn6OlgT4VfAmsjRUOKVOME9df3nqyyv1VGAfouciS/05JUrVhXHjHT3TYtV9mTjX+0qMoLJWhcPwbv0drCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rU8NPdGLxfnxyNLwIM6PPyLSCLfmjgLjR/u6eoL7I9hKkf2ToKfUQk0q7xl?=
 =?us-ascii?Q?eeCSgYKwa2ADdk0r89cSm0u2HXdAtNQ4/CE6JrJZ0mwKFB7pLGXlea1aF9xJ?=
 =?us-ascii?Q?REOLKsZ/kP7ErMJ7S3FgnJyKtwg/91XrDqD+7RnyQVBkWxX2A/wR+xES43uH?=
 =?us-ascii?Q?ZvI9oLze6z6P1sEstGNhoJyZ/CRGGMtXIKBvvSjc0zqhb7aXSUnNyiPpZJkW?=
 =?us-ascii?Q?SfAgv6tas1ik8YEFfaz6O5mTn/2YAFVmayI2unq57GCLP8g1HPVOoJZlMaZg?=
 =?us-ascii?Q?p/YBWRjdstCFRpGW0OexBxTCWXFVCg7BIHGXu2eCF1RduOBLqkhkYJXIEssc?=
 =?us-ascii?Q?AcVZaNZUzG5lFepQdYhzyd9se7SQ7i01JSZwAJ0k6YlbIB+Dy8FXZeAjaBSj?=
 =?us-ascii?Q?ATKsLPs+7Ik4kvvDBuIcnSGmSmTbAP8FAC65Xw+5MNaClUvb9Hcgo6DbzCWZ?=
 =?us-ascii?Q?i7ZKjSwohb43tN5rAr8LYW8O7fwF0kzNhCK8v0aJueTpUl0/U0Z1MDXNPOgd?=
 =?us-ascii?Q?hzX4VhMQ0VCwPu6fHb+Ben/hvwRCvepX2HK5g6aNTQSNAsTedeklPOyXF2e7?=
 =?us-ascii?Q?qi0hKQ+l3KR5Gec1ZI0+B1Zm8SlrAUkxk3WQAVPMXgWy/ucAPpBEDFzOb/8W?=
 =?us-ascii?Q?/zFM1dFXz6JUARWEhOj92zlFmAPTh4cIuhdpMbIP39WwKeTZIchn/qY7vVYt?=
 =?us-ascii?Q?QnzPhhaEGcZx+AKucTQo+hZUFvLCBKfu/Iu9ZlcTJhc2/WNBrTPATMaBPrNY?=
 =?us-ascii?Q?BKDXeiyA50fxTDdFWL0ZAAAL/ZHcfj9ciWYl5y7eM9WsikllZI7hpSljjxxI?=
 =?us-ascii?Q?mxXycY9J4Qq0xRjZewZlO1k9MQkva7dUMDOJHK8xlO2+Sr8HQseCEDVKBzbR?=
 =?us-ascii?Q?FfJR3fKH6kTKSGaDylRZXXkJCTWLTHiWFziGCkotR2PttKfs0hL5Q5v1e+h4?=
 =?us-ascii?Q?p2N+v4XS5Vh4jJbfxfkaPJBKb8FJOz/ujexikmJEKpddlLJpzlP63Y0occBf?=
 =?us-ascii?Q?acMspaYnHXqmf4VAhz8Sm5okDwUoyg8W204MgqRIHo0adVnnKX8D6p04pbnk?=
 =?us-ascii?Q?uBODcqFi8QF4xaW/1IK6A0fJ8u1npYwq3r/1fmkY8gLWPSrOyLhjyIWjs3Eb?=
 =?us-ascii?Q?7yYtQZNUT0HKbAzTaQukbBc+PaaINvGn80BMsqyZFkbqvztUK0E4C9bc2120?=
 =?us-ascii?Q?PzdjUAMz54Ifj2GHV0ZYQ6JRp79pxOgjO3kdqsQmyG8HBJ9T1gL3C/b6nBxk?=
 =?us-ascii?Q?EHFLI9aBvg6AvFwFIatI/xBplHWbuRDbe3iIxqDf7fRvZvgSkmT4W2HO2/3j?=
 =?us-ascii?Q?PZypwIZieidN2yelmD9R0Dmy/dlKglV7qTrE0Dk8D4fQt5NK1D+BxbAvmHK1?=
 =?us-ascii?Q?FCwYKDYmSg7C8P87k2aLV1+j1vGX7xzJgLPGgAQNRLllh0btSuzVEK5jqDc9?=
 =?us-ascii?Q?v+P7Ukb0lL/OzjplIEfdE9Ve1FhxQQWiyaJesxxka47qlOYUfudxWtlEYWJp?=
 =?us-ascii?Q?Fku+kRgc+1dHu2shv8Jm3GJPIgVJFPyvlTFHe97QpDQ8PO/PZuaTDnxL2mBC?=
 =?us-ascii?Q?RjQdSWOFU/6tQGLIbmQdjG7LZDvJEjX2wZdTK3VpUyQQQGjk9Jud1lu24pg7?=
 =?us-ascii?Q?yHYZ+tceAE5IThu+CETPuwwRuEs4QnGthF9e+2QWWn0ZkBjpHVIvW6LEXrcq?=
 =?us-ascii?Q?23bwWtKzlIxwcHCVy1phfhLqrQW1Vxuy0VOoaK14Oxzag2F8A9lxb0rWlywc?=
 =?us-ascii?Q?yL5Juab8KvzZCApPzDJyYbaJbgQ6/0A=3D?=
X-Exchange-RoutingPolicyChecked: KynHQopN7jrvs5Qe3heX33p31imhM+5w9SHzh/9jnt6nECvKbsvjadAPBiXTwi5VD5wASv2EPURCxiZF9cBvmO7/QgB61LWBAyYF2WMYOe4VRFfylQmW0jwbxWrbUbUU0YjQBGrhQRmUrpEP6l4sEVjW7i4iAFUzWMowBqUNsbFwOLefvoIjaG3Avjd2rFx9ECiW8igJ4q7Csd11DfA3UI3A6Jb7OEZAvi85djHzPaE2k8EDkZX+2cQ4roNzt5pZDM4WR7vFo/RUkcfeR3LA1z/i3V+VU7OxUmUeoyyk4ZSpLbrsjec4JIgiaBq6OdWCt+vBq4rWuaQnmaXVyxONpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b765be72-3249-4944-e09d-08df2e8f8bed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:50:17.4097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81CFs8HDwOrAmJxnZvPmiEBE8utqqYAs3PjBCs4xeV7Fysz18pbaUZXvYg8XfTJuDtOOQEnV1m2dQ3EfSTPSo4sbw2WcY9RU7H05YOH0dIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 12:24:18PM +0000, Dawid Wesierski wrote:
> The VF allocates qos_cap and initializes the TM lists only when the PF
> grants VIRTCHNL_VF_OFFLOAD_QOS. The in-tree ice PF does not grant it.
> On such a VF, node add, shaper profile add, capabilities get, and node
> capabilities get dereference a NULL qos_cap, or insert into a list that
> has no initialization. The application gets a segmentation fault from a
> call such as rte_tm_capabilities_get().
> 
> Return -ENOTSUP from these operations when qos_cap is NULL. The other
> TM operations only search the lists, or check VIRTCHNL_VF_OFFLOAD_QOS
> already, so they do not need the check.
> 
> Fixes: 44d0a720a538 ("net/iavf: query QoS capabilities and set queue TC mapping")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
