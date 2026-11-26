Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F6606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 02:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4fzsBao;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Y4XG9GYH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7862C402C4;
	Thu, 26 Nov 2026 03:12:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTPS id CD18F40284
 for <dev@dpdk.org>; Thu, 26 Nov 2026 03:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795659124; x=1827195124;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=ZZ7C98EYRkGqqJWSmVcrI3vwpB5MklPcu/8usba4zB4=;
 b=A4fzsBaoUOzRg4Fu4yrjkq3iqv+IYxBBzPtds30Wf0lSf3fWlZDb5qZR
 mi4E++3OJrq8if88HJv5gTOsk+OkRQQI401AgAVPEbPk2tuTKUzVejqNr
 FZvNyFBdiLdhkNRypAPijyezt8dLKCKyr3E8EKI5kknejhRfFX8aj8XPs
 PiZ+6mm5098rmTm5s3w046TDBUY1ncqQAW8JKvcJMCv6PXNYsfGJsyjt+
 dmHVgpRIebZUjeMlAmGejdhdBu4SPDjpgEChlbx7czMihnqBdshlsdu3Z
 xkagOIBpU1US3uVGPWyM/am3J6JxwdZwHdUcf3vj5HG+4WiZH0NAgCE57 w==;
X-CSE-ConnectionGUID: GB1w/MlhST2IsjEpV3Y1GQ==
X-CSE-MsgGUID: ECs/Wn26T+OSbNexln7F3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4570913"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208,217";a="4570913"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 18:11:50 -0800
X-CSE-ConnectionGUID: bDjqvbhfQwaSSIhi+x1m5w==
X-CSE-MsgGUID: 7z42Zm2hR86I2m5F4VXwsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208,217";a="12359318"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 18:11:50 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 18:11:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 18:11:49 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 18:11:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjvGX1Yi38KQVN0bJIoo+c4qcNEF/STkAjhHW6crRByAVhPDXeS6iEaRD0uMwyeNyVx7eqA9pu9uQJp3M3Crvxkzx5Ml663SYx3xdPRossVdL+vp3Ok5HKlWWNODDEBcz06W3iI3kq7E8bO7DMRzV7V8URUZO5LDd2ZiuBGY51HEZMsla7ln8jtL1Q2vsmW6i3EJoHaiTJDdaHO32qcWNLNoVDE/XhGBtxOwrSfnVfke+wa2VGdxs6pfo/ck4Oiv3Jnduedl2hJdXneSGbN7IFEWhyvkmwaiBwiyRHHIGlH8OSrT7N0I9XS37rs6nV9Wo6ukjSbajYaIwO9eCi5Zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ7C98EYRkGqqJWSmVcrI3vwpB5MklPcu/8usba4zB4=;
 b=f8MrMCaUWJ12z+NJIWlMUShBRcQJ38+G7H2jMpG1wtpCI0qItxr5sTqLMGodo71NBG10VF81z+y5QuLgOG28PRrai3g3av9LuCH6s2Ki/vmxxRGmcOTLqMLjH8pLhL2JuKMuNPsvqGjXpEd0TsYdPXyar6vPRPiGjVyGqTBKP+gq2usYR/tvRLOfqTYEdoBICQo9gNOQ3Bn6KMU/r5tu+pppxZ81EavHtXswc6t9kDeiR9G5DZ81puSula4MAvQ6aGTD9Ymx4u8H1QL3yZnxPSZpOXcJ5772M/vekGnWG5CZHH7iGMhY7Eu5qHjPV4OHt2ubheGgqy5A/2zKMYtCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ7C98EYRkGqqJWSmVcrI3vwpB5MklPcu/8usba4zB4=;
 b=Y4XG9GYHh2xgSqyBRwvs6a+6hhws7JDGvA/SwS8hQirO7Y5shAbCyCezpmw72s/nwTA7+0C7FBnLySgRidzumjGSzkoKDCkllv4SgvJELFNOze1RmImFWoTQssvM9JuSFYFbPqx9CAoAsstGNDDvAZSbZkBtuKxNNO92Q5UCmsk=
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by BY1PR11MB7983.namprd11.prod.outlook.com (2603:10b6:a03:52b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 02:11:45 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996%7]) with mapi id 15.21.0639.010; Thu, 26 Nov 2026
 02:11:45 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Hosamani, Manjunathgouda"
 <manjunathgouda.hosamani@intel.com>, "Puttaswamy, Rajesh T"
 <rajesh.t.puttaswamy@intel.com>
Subject: =?gb2312?B?u9i4tDogRFBESyByZWxlYXNlIGNhbmRpZGF0ZSAyNi4xMS1yYzM=?=
Thread-Topic: DPDK release candidate 26.11-rc3
Thread-Index: AQHdc2aOMzYa3pxB7kOJv5ows5GfXLc/r33L
Date: Thu, 26 Nov 2026 02:11:45 +0000
Message-ID: <DS4PPF00BBED10C8A7FAD11A13A3954C5E39F422@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <RBroyiAPRh-kx6sUEfHtWA@monjalon.net>
In-Reply-To: <RBroyiAPRh-kx6sUEfHtWA@monjalon.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|BY1PR11MB7983:EE_
x-ms-office365-filtering-correlation-id: 569bd1ea-27ea-4c07-370a-08df4b629f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|261021135927099003|261022105027099003|261026140227099003|261028144727099003|38070700021|261026121527099003|261009223027099003|22082099003|18002099003|13003099007|8096899003;
x-microsoft-antispam-message-info: isk+I5ThTifxQbp4zyRulS9AxL3BfAZ4sl55lrBLiv8nHQqdMDfzbZLj7y2x+pmXVfAGWlA3p23HGzcsX8DV9Dz14P2fUoaLzNTek1pzmH9dgTduMyTVFvsYt2f3Dr6Sw/zEYzQhDR1K8g9bZnTvcdEMsilHnUZo4GghsqcScFf2qOW5qtDetYrtS727CRHsCVQ34/R2Wxj8AMNOI7mShvb0WIP+h868538KTGV73du5HxZzSgnbOEOejN7QoZYnEpK2JY4FIJagZqTWs/pvUPA5tFeeRYIKbvvAyF4I/OA0LAv5cUx/UcAKgMufa+iOpzn8A7YwxPS7L+owcmT8uxo/ukD+ikLGNmGkazkk46LZZfQH2nV7GgQF/CT1lupuly13JD47MvOxDVTQ3fkZYu2xFdvltDgkIYskt4iXKmjTXi32+8Pa9LwgpS7HJvgFMawQHhejXJOFPJp/GEUTisrHOYFQxPsKRq4+JIguRDK4hM3SUQAmN+vIbC06M2XkzYFCrazGza0GnVh6726lLbG4s5Tp7HdxeFebsGeSS3ieWfXDROXJ7GVb8PubaUtvpyri+WTiCwXWp14WPaDQkWta2KwZyb1SmliydqC7HcCnJ11OTATnIyoh3851f5rZyqJFPNisFUSPqiOQtdwRhPBDzhnt7PKqst6LHOYeWvgTn/lfOlQ7zWBNnk941+87
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261026140227099003)(261028144727099003)(38070700021)(261026121527099003)(261009223027099003)(22082099003)(18002099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VlpaQ2c5MkVERUtLTzY5N0xvTXBtSVBhRVovMXpzNkVPV3ZpR2dWblNKZ3lF?=
 =?gb2312?B?VGV5TlZvZ2lpWG5GWkR1Z0d0VU43a09FblRoclJ4TnRLTW9seG5hWnJLaFdN?=
 =?gb2312?B?a0hINVdiZFpNOVdvS0tob09jNi9Gd3lyR29vM1BIdzV6b3BDVWl6eFp6Zjh6?=
 =?gb2312?B?WG1lRnVYUzNWZW91ZTV5MkQ3SkxvZUFKTzFJV3NTSW5lU25rcHJsMnFsMVEx?=
 =?gb2312?B?Q3JSdUpDQW00aHF6NFcrMTN2a1dqSU9NWGI5SGY2eG9FbFVpVmZ5bDBKUncz?=
 =?gb2312?B?Z3k2Rk9sUlF0M1g3ZWx0RjMzN0tJOXdOWk1MZFA5L3ZybytkTlZuTldoa1BD?=
 =?gb2312?B?eGJlckY0Tnc2cTY3MDYwUVlJV2xLbTlQK2tabUd6S25ZRkJVU05EOENSRllO?=
 =?gb2312?B?a21jUFhyemJjcGM2Zm83cUJIUlZlZUJDaU15bjFXbnpFNHkxVG5YUFl4TStp?=
 =?gb2312?B?OVN5c1pST3FJUkJVODBsUHpmbU9WVVQzN3hJSnYzeXNRaXQxYm5pRXdTTGdZ?=
 =?gb2312?B?Q1hIbDJITytlRWtFMzUrY3NGcUg2K2llbmdjZDBOTzRKTUptR2FPNGNQODlK?=
 =?gb2312?B?V3VVem9Gckg1YlBrRlprT3VQYmUwTWVpbDhIT1oxbW5TZ2lveFBZL2xmT1dz?=
 =?gb2312?B?citUOG1VRlNmcXZ2dlFacUpKbnFSN2d2dXVVWmQxUS9xcG54OU92bHZXRHU3?=
 =?gb2312?B?d1h1OXhZd3hNNHdFVTdjTkgxUnFHU3dPc1NLdlVqR1ROUjNLU3pzWVdYVm4y?=
 =?gb2312?B?bVl1ZGNsT0NLajNScjJ5emlBdVRNUzZLdGg3bXZrVW43UDhqeEdiWlhHckU5?=
 =?gb2312?B?a1hEdGxhUG4yUkZ3bTVEemdHZ3FYTXJhVWdzV1NwOWVBcXVNa3F1aXgxTWc5?=
 =?gb2312?B?djRiOTFtNEhwWGJoQTRFbVlHSWNJTjVoTVVFK2c2dnMvRHVJSXp5RTVUbDJB?=
 =?gb2312?B?OU1CdTVxb0x2MUtCc0lKakU4STAvb2Z6bXYxNzV3TVFlaExOZ2k0T2ZGaWp1?=
 =?gb2312?B?NW1CbWFEMlVKZkhNZHpIUHVUbmdiMGFSZ1hCZW5QWk1lNWp5NTFrNHArSVI3?=
 =?gb2312?B?dUNrcGZucWp4TkMrc0FKc2lpK3ZlUnhKWlB0c1pQZ2RTdG1uQllVVG1IalA1?=
 =?gb2312?B?cTlBSHJDQzZNOGhDTzUyMmVmN0Q2Tk9NOThtSHZDT0lCWEQxZXJGb3BNbFlx?=
 =?gb2312?B?YURKUi9BaEJoNFdLaEFCMUVDT00wUmxyWm9pWnVhR2xsZEdsdTZ5NjRvQ1dG?=
 =?gb2312?B?YlpwWTBlZzFqZndINHpod2JnWitrSURHYWZKeWFMZVhlSkRKYWNNR0FoU3g4?=
 =?gb2312?B?dnBOMXBhenoyeFVZMjZwWHZHVXFRRnl5K0JtZHlnZC9vYnlMRDJpenRMN2M2?=
 =?gb2312?B?UFR2emFqL2RzRmdkbmd4dGVkRlp2ZkJsaEFKN3BZSC9hOVh1Q3BsbFVwbTZX?=
 =?gb2312?B?UEdLaGRmcUNDRjliamJuUDFKTkFGRXlSeHF2d0ZPZXJjbmhDRDVwZTJheWZO?=
 =?gb2312?B?aGJ3Z2ppSW9pcXZzR2Z1QnJ4MHlrT0ZwQm1CY05XOGRWRTlIbXZDSk10blhJ?=
 =?gb2312?B?UUpUMzFVMkJKVW96L21ZNXJQUGdRVGxBNkhWWmx2NitBbTdpQTM2eURBSFE0?=
 =?gb2312?B?Unh2Nm5zaG83ajFnb2dFeHhyaWt0SUo3ZGt0bnJoZ1JxZHVNUWhvWjhXQ1BD?=
 =?gb2312?B?NlkvZ2hJMGNiVWQ3MVRzOWF5S1B3SmxObEV6RW5aQldIVXRSTXNBbmRIMmJo?=
 =?gb2312?B?Z0tQK2V4TEVpdnkweUFNNjFtYlVBZmRhRUc3UGY3SEhJclpFdGZRTFBpN2tC?=
 =?gb2312?B?cW9zVldDWkpaVERrUU5JbGpHbUhrVXVHanVhN1J6bmozVFFqaXF2YlJUNjA5?=
 =?gb2312?B?WnYzRWc0UEFadmFlanVES1hWY2U0Mm5QVzZCQzFoVU5JYXg0a25iMWhzRlJV?=
 =?gb2312?B?alNLL0V4MDFhYzd4enU4ZDZBQmJ4MGJLYUdBSE5jdjBmUW0ramdzVE9NeTA0?=
 =?gb2312?B?ZDFzU0NaY0lEVW5FekRLY01uZkc0d3RzMlFYTnAva2F1WC9VOFZEbVVhMmdN?=
 =?gb2312?B?MU9zWXFiM1czODhicmRDdmR4V0hjdGhQTEdUUVNMbG1DZ0laZWN0WiszRS9Y?=
 =?gb2312?B?QzRNMUFZUVU3eEhCRDlzU3B2THBMbVFSS1UxNW15eDc5UU1MQTRCdWtWZVdz?=
 =?gb2312?B?ZSt3bTNnbjVucVVoeVVsY3FIUE9nc0JTUWRha0NqMjF2ekRMalB5TGRrMzRi?=
 =?gb2312?B?TFZOVXhxbG12UngyVDJHeStObmZXL1I4QTFOSlhhTE8zdzJWQVdiWG9VeFp0?=
 =?gb2312?B?OU1GdTBwSXZ5Q21zWnpEU1RCZ1JIQk9WOHc1UWV1a0dKci9Uc29Hdz09?=
Content-Type: multipart/alternative;
 boundary="_000_DS4PPF00BBED10C8A7FAD11A13A3954C5E39F422DS4PPF00BBED10C_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J0m6WGqbZvPFsbVyuEJvmW0X4k3KGwfLHtYKfQTI6tirBYYvhXhKINBwK5iP+5jNHxXzA5vmmrgWacCxxw/dWvkSoZQYyMhtmyD7hlwN+NWQ3Sg9YST2QrsB1Wy6Wb7NYvLUbvH1F8UUr4vNDU+NO2Q5RKl9EceTUgFha2yDIA/EphOsZdqeIQKHqNqSXL97jMQYBjzV5Hiwh4sDUB933zozf5Ow/y0kkNCdYBSkiwIbkJjz6L7jhALSyofuwgFBSGm1ZOnjgADzpz84hwzKql2/Bw+sWyP4lrOS/cRwKG+y4QwLqFNyoYhuWgm4PqXTGxiCC4tiaTrosZoBzKOfKw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569bd1ea-27ea-4c07-370a-08df4b629f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 02:11:45.6012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvPvJWyIno5O4QB6EZbVsUiPmFQYJABJHBiy9RJBZrdasjPReGuZ/qqS93mZcM8/7ICXXX66BjI9LjaP7RCWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7983
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS4PPF00BBED10C8A7FAD11A13A3954C5E39F422DS4PPF00BBED10C_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

t6K8/sjLOiBUaG9tYXMgTW9uamFsb24gPHRob21hc0Btb25qYWxvbi5uZXQ+DQrS0beiy806IDIw
MjYgxOogMTEg1MIgMTMgyNUg0MfG2s7lIDY6MDgNCsrVvP7IyzogYW5ub3VuY2VAZHBkay5vcmcg
PGFubm91bmNlQGRwZGsub3JnPg0K1vfM4jogRFBESyByZWxlYXNlIGNhbmRpZGF0ZSAyNi4xMS1y
YzMNCg0KQSBuZXcgRFBESyByZWxlYXNlIGNhbmRpZGF0ZSBpcyByZWFkeSBmb3IgdGVzdGluZzoN
CiAgICAgICAgaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay90YWcvP2lkPXYyNi4xMS1yYzMNCg0K
VGhlcmUgYXJlIDE2MCBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNuYXBzaG90Lg0KDQpSZWxlYXNlIG5v
dGVzOg0KICAgICAgICBodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMvcmVsX25vdGVzL3JlbGVh
c2VfMjZfMTEuaHRtbA0KDQpQbGVhc2UgdGVzdCBhbmQgcmVwb3J0IGlzc3VlcyBvbiBidWdzLmRw
ZGsub3JnLg0KDQpZb3UgbWF5IHNoYXJlIHNvbWUgcmVsZWFzZSB2YWxpZGF0aW9uIHJlc3VsdHMN
CmJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZSBhdCBkZXZAZHBkay5vcmcNCmFuZCBieSBhZGRp
bmcgdGVzdGVkIGhhcmR3YXJlIGluIHRoZSByZWxlYXNlIG5vdGVzLg0KDQpPbmx5IGRvY3VtZW50
YXRpb24gY2hhbmdlcyBhbmQgY3JpdGljYWwgZml4ZXMgYXJlIGV4cGVjdGVkIGF0IHRoaXMgc3Rh
Z2UuDQoNClRoYW5rIHlvdSBldmVyeW9uZQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClVw
ZGF0ZSB0aGUgdGVzdCBzdGF0dXMgZm9yIEludGVsIHBhcnQuIGRwZGsyNi4xMS1yYzMgYWxsIHZh
bGlkYXRpb24gdGVzdCBkb25lLg0KDQogICoNCkJ1aWxkICYgQ0ZMQUcgY29tcGlsZTogY292ZXIg
dGhlIGJ1aWxkIHRlc3Qgd2l0aCBsYXRlc3QgR0NDL0NsYW5nIHZlcnNpb24gb24gdGhlIGZvbGxv
d2luZyBPUw0KICAgICAqDQpVYnVudHUyNC4wNC41L1VidW50dTI2LjA0LjENCiAgICAgKg0KUkhF
TDEwL1JIRUwxMC4yDQogICAgICoNCkZlZG9yYTQ0DQogICAgICoNCkZyZWVCU0QxNS4xDQogICAg
ICoNClNVU0UxNg0KICAgICAqDQpPcGVuQW5vbGlzOC4xMA0KICAgICAqDQpPcGVuRXVsZXIyNC4w
NC1TUDMNCiAgICAgKg0KQXp1cmVMaW51eDMuMA0KICAqDQpGdW5jdGlvbiB0ZXN0czogQWxsIHRl
c3QgZG9uZSBhbmQgcGFzc2VkDQogICAgICoNCklDRS0oRTgxMCwgRTgyNSwgRTgzMCwgRTgzNSwg
RTIxMDApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNP
L0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTL1N3
aXRjaC9QYWNrYWdlIE1hbmFnZW1lbnQvRmxvdyBEaXJlY3Rvci9BZHZhbmNlZCBUeC9BZHZhbmNl
ZCBSU1MvQUNML0RDRi9GbGV4aWJsZSBEZXNjcmlwdG9yLCBldGMuDQogICAgICoNCmk0MEUtKFhY
VjcxMCwgWDcyMikgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxP
Vy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9S
U1MsIGV0Yy4NCiAgICAgKg0KSVhHQkUtKEU2MTAsIFg1NTApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlv
cyBpbmNsdWRpbmcgYmFzaWMvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmls
dGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuDQogICAgICoNCklHQy0oaTIyNikgUEY6IHRlc3Qgc2Nl
bmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBv
ZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCiAgICAgKg0KSVBzZWM6IHRl
c3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1ndy9pcHNlYyBsaWJyYXJ5IGJhc2lj
IHRlc3QgLSBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCiAgICAgKg0KVmlydGlvOiBib3RoIGZ1
bmN0aW9uIGFuZCBwZXJmb3JtYW5jZSB0ZXN0IGFyZSBjb3ZlcmVkLiBTdWNoIGFzIFBWUC9WaXJ0
aW9fbG9vcGJhY2svdmlydGlvLXVzZXIgbG9vcGJhY2svdmlydGlvLW5ldCBWTTJWTSBwZXJmIHRl
c3RpbmcvVk1BV0FSRSBFU1hJIDkuMCwgZXRjLg0KICAgICAqDQpDcnlwdG9kZXY6IHRlc3Qgc2Nl
bmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJIHRlc3RpbmcvQ29tcHJlc3NEZXYgSVNBLUwv
UUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0KICAgICAqDQpPdGhlcjogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIEFGX1hEUCwgUG93ZXIsIENCRE1BLCBEU0ENCiAgKg0KUGVyZm9ybWFu
Y2UgdGVzdDogQWxsIHRlc3QgZG9uZSBhbmQgcGFzc2VkDQogICAgICoNClRob3VnaHB1dCBQZXJm
b3JtYW5jZQ0KICAgICAqDQpDcnlwdG9kZXYgTGF0ZW5jeQ0KICAgICAqDQpQRi9WRiBOSUMgc2lu
Z2xlIGNvcmUNCiAgICAgKg0KRTgxMC9FODI1L0U4MzUvRTIxMDAgTklDIFBlcmZvcm1hbmNlDQoN
Cg0KDQpSZWdhcmRzLA0KDQpYdSwgSGFpbGluDQo=

--_000_DS4PPF00BBED10C8A7FAD11A13A3954C5E39F422DS4PPF00BBED10C_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>=B7=A2=BC=FE=C8=CB:</b> Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>=D2=D1=B7=A2=CB=CD:</b> 2026 =C4=EA 11 =D4=C2 13 =C8=D5 =D0=C7=C6=DA=CE=
=E5 6:08<br>
<b>=CA=D5=BC=FE=C8=CB:</b> announce@dpdk.org &lt;announce@dpdk.org&gt;<br>
<b>=D6=F7=CC=E2:</b> DPDK release candidate 26.11-rc3 </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">A new DPDK release=
 candidate is ready for testing:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://git.dpdk.org/=
dpdk/tag/?id=3Dv26.11-rc3" id=3D"OWA6f41803d-521c-1edc-6b35-ddd8934e4a79" c=
lass=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://git.dpdk.org/dpdk/tag/?id=3Dv26.11-rc3</a><br>
<br>
There are 160 new patches in this snapshot.<br>
<br>
Release notes:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://doc.dpdk.org/=
guides/rel_notes/release_26_11.html" id=3D"OWA0860e377-b97b-ed08-32a9-f8c73=
e97f139" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://doc.dpdk.org/guides/rel_notes/release_26_11.html</a><br>
<br>
Please test and report issues on bugs.dpdk.org.<br>
<br>
You may share some release validation results<br>
by replying to this message at dev@dpdk.org<br>
and by adding tested hardware in the release notes.<br>
<br>
Only documentation changes and critical fixes are expected at this stage.<b=
r>
<br>
Thank you everyone<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
--------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Update the test status for Intel part. dpdk26.11-rc3 all validation test do=
ne.</div>
<ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Build &amp; CFLAG compile: cover the build test =
with latest GCC/Clang version on the following OS</div>
</li><ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Ubuntu24.04.5/Ubuntu26.04.1</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof" role=3D"presentation">RHEL10/RHEL10.2</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Fedora44</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">FreeBSD15.1</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">SUSE16</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">OpenAnolis8.10</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">OpenEuler24.04-SP3</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">AzureLinux3.0</div>
</li></ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Function tests: All test done and passed</div>
</li><ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">ICE-(E810, E825, E830, E835, E2100) PF/VF: test =
scenarios including basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filt=
er/VLAN/VXLAN/RSS/Switch/Package Management/Flow Director/Advanced Tx/Advan=
ced RSS/ACL/DCF/Flexible Descriptor,
 etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">i40E-(XXV710, X722) PF/VF: test scenarios includ=
ing basic/RTE_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RS=
S, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">IXGBE-(E610, X550) PF/VF: test scenarios includi=
ng basic/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.</d=
iv>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">IGC-(i226) PF: test scenarios including basic/RT=
E_FLOW/TSO/Jumboframe/checksum offload/mac_filter/VLAN/VXLAN/RSS, etc.</div=
>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">IPsec: test scenarios including ipsec/ipsec-gw/i=
psec library basic test - QAT&amp;SW/FIB library, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Virtio: both function and performance test are c=
overed. Such as PVP/Virtio_loopback/virtio-user loopback/virtio-net VM2VM p=
erf testing/VMAWARE ESXI 9.0, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Cryptodev: test scenarios including Cryptodev AP=
I testing/CompressDev ISA-L/QAT/ZLIB PMD Testing/FIPS, etc.</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Other: test scenarios including AF_XDP, Power, C=
BDMA, DSA</div>
</li></ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Performance test: All test done and passed</div>
</li><ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Thoughput Performance</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">Cryptodev Latency</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">PF/VF NIC single core</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<div role=3D"presentation">E810/E825/E835/E2100 NIC Performance</div>
</li></ul>
</ul>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<p class=3D"elementToProof" style=3D"margin: 0cm; font-family: Calibri, san=
s-serif; font-size: 11pt;">
<span style=3D"color: rgb(0, 0, 0);">Regards,</span></p>
<p class=3D"elementToProof" style=3D"margin: 0cm; font-family: Calibri, san=
s-serif; font-size: 11pt;">
<span style=3D"color: rgb(0, 0, 0);">Xu, Hailin</span><br>
</p>
</div>
</body>
</html>

--_000_DS4PPF00BBED10C8A7FAD11A13A3954C5E39F422DS4PPF00BBED10C_--
