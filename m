Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E10C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 12:35:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0C274014F;
	Fri, 18 Jul 2025 14:35:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D14A74013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 14:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752842106; x=1784378106;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=merQgyJllZaAW5LeQMjSEFyiVCaaU2qyZuiBGS5p2A8=;
 b=BVR9djlksEt5jacbturJyA0hG8yDXoEDETI8JO/emNBh3uUjTL7AO4Jy
 spoD4HuHsAFXvXIH9uYBvpcWLh77RUMpXWY/QLQb+8QPPOvv9pbUuGNag
 Cq9HrqrLEgx3PAFwO33LExmGUEpdt+hWlVvMp8+F0TxLBE4IpdLt43EWd
 TmCYNUCuz+bHFkR2eNhGmJXt5Tc9uMDnaQwziLzEzzTBU+/Aco1hpjgKo
 q4UqjP/4LWUX/mB0dvTMSDjX5TrkymHsMRtNaogc0ZLmUZalTeqlhkY2N
 WmbZa1Y0XnqMNBriVEYCVAK6xxzN/5z4Ms/4qzrUGJN8fZoGScUZwqi+7 w==;
X-CSE-ConnectionGUID: WLxkrjmOSBy6x4uZAO1g6w==
X-CSE-MsgGUID: UySXWBffTyCSZEbt1M0aUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55289141"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="55289141"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 05:35:05 -0700
X-CSE-ConnectionGUID: FebJRoUzT4yPcP/8OJ4gUg==
X-CSE-MsgGUID: uKXe5w5qS+KS/B86bOXDTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="157431514"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 05:35:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 05:35:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 05:35:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.45)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 18 Jul 2025 05:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOt2LX/4FduWJOn2TI/CDFYBgOuZkpr4O42hCsyPduXMY/3FZnD8BlCHwq2t/VqwzwRhBCzmVoLGFdgk1Qu0WRKn8/qByVw2vj49+VrWs73PGaf/GTDO4UKIBvS6MI5k4myniGzgnh/5r1BVPQaUu3K+rD+OZKP3KyUeMcT4vXpqCqhiyLdq0xVIBf33TnonkUlDsdeSlmIIqYZyXgjRtSbiutvuGHsY92sfeiq6X1jmZGIUsGE/jGFLEplPwoIPC7VJ7DxOaaNppVJAoSkFxpCgvDWglUUK+UmPLctocdraF2c3Ycd/WK+a3DT7Z9SQIqtGUlNrCcrdkPJoWL6wbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgVf2qJH/uAuGRdOm7BY3ynzjwLW7WejaqtT23YaS+I=;
 b=FWXukHhATWe/9lk/Bruq/F1k00EzErRcfVAEC6WHTdrxx7u3Gye2aEwWrrS3MQYuVY7PdWSk0UX8r7153rQA3L1Ss1emNNF35ba1HyJ5sBXsaCQGr5pX8joGRfGvso4ipyxyv+WodiThvx/wm/SyXqiMGOsRQQKKnbP3ovivO0dzZBTzHZvruFshrqOKiIQ7ilL7pvDYdK6bA90G4v3tmsMf4slXb+DoBZM8N5kqr6XoH3o+pcnNsa3OSr2Q46YDh4it6/wSfTCXw6zkVxv07kHXHnEPHsKLBZcRy8l4hsPoDmOmTmxbTKVg18uetW10zA8siWYCFI6paKXnj+BT8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 12:35:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 12:35:01 +0000
Date: Fri, 18 Jul 2025 13:34:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] build: remove obsolete compiler checks
Message-ID: <aHo_ccDzIZnYa06T@bricha3-mobl1.ger.corp.intel.com>
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <CAJFAV8yu1Gf_fQOibjZMd8oh9CYeCEQNSqpSfcfYXNYRhixvFQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yu1Gf_fQOibjZMd8oh9CYeCEQNSqpSfcfYXNYRhixvFQ@mail.gmail.com>
X-ClientProxiedBy: DB9PR05CA0029.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW5PR11MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c213607-ac54-42ef-6a23-08ddc5f7839e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1JJajB4MGdqZ2ErWnNJcW9GeDNaYU9pcG5Ka2FKSjY5cFBSaG55UzFhanZo?=
 =?utf-8?B?eFJFc1Q0YzJGMDFnQzROSzJ2THJYTlVubW5RcXlhd25yVExaaVN6Z09HUytJ?=
 =?utf-8?B?NU5oYUpjc2ZqM3JRQ0hVZmZHd2wvZXNvKzZWWUJMTDk4aytDU0JDRjBVMGpl?=
 =?utf-8?B?M2lPa0ErbFhqOXFrNkgxOEVEK2FvVkRLZXJZeVdUL3g1Y0F4NWVDUE1Ydm1C?=
 =?utf-8?B?d2lGM1A2RXMzeGsway9yUGJSVWtDb29nSjU1aTJMM05FaSt5anBHa1ZNQTVP?=
 =?utf-8?B?VnUxVGFmaXovczB6L3RmM0hseVkzNHA1VkZLY3RLaHpjVVlCNjVjL01DM09S?=
 =?utf-8?B?VDNtZVJGYzVrUDNIem9SWGFBQlkzVWhVK0NHTVBDTFRsY0RwVDB1cDdBUDFP?=
 =?utf-8?B?NXF4alpCTENLdGJVYU5sZ3UrVDNSaktEb2NBKzBGMVNXekxCNDZsYTlZbDcw?=
 =?utf-8?B?dUpCMTR2Nms4U1drYlJJTVlOU21IcHZ2R1JWamtsbDdQNWJuZ1M0VDFxQ3Fa?=
 =?utf-8?B?YTJKOW1nemRVVThhZ1JuODNwOGpBTjRZMGhRbWxQR1VEU1BTYXcydk9vTnhD?=
 =?utf-8?B?MVgvV29TblF1Y3dmVWcyWFYraWx3b043U2UzNjQ5Q0ZTbjYrNlNaTlhoSGMz?=
 =?utf-8?B?T2F1dzIydFF6eUd5cENlbXhDTGNoV2ZLWHpsdndhUTZmdldOdzJzeEExWUNK?=
 =?utf-8?B?NXhVSFZ4SkRIUVRtd3pkNVVZWkY1TnFBWm9IcENTTWgraFF1T2k3WVNUNnVw?=
 =?utf-8?B?WWtPTVVGWHRURVVUSS9LL00zaGNQaUxuc29Ca0J1NTdiY1hVdjdvendUOTB1?=
 =?utf-8?B?RGdNSDlPS25MZjgzVVlDU1oyaXRRTm85Nkl1dUNRelZaYkoxNTg0QytSQ2ti?=
 =?utf-8?B?ZWlRNXNhZFdyVGR5NnNuNGQ2aEYweDlmVk5YNkNCalBxekU1MElvK1FicmpY?=
 =?utf-8?B?d1ZZMWQ4cW1kejNOQkx6S1V1dnBTWlltL0NaNyt6WlNsSzVDeGUwOGwvOXZI?=
 =?utf-8?B?Y0EyVHR6Lzl0Um5lRnpSMUd6RTdkUUZxN0MvWllxMXlhQVczUld6bERnbThE?=
 =?utf-8?B?K2tBM0pMR3Z2enNhbUVzSkQwYndCRlVsdFJZMXdGaU40MDIwemwrWTZveGlJ?=
 =?utf-8?B?K09OQ0x6S3RnaEMxQUZ4VGswQk9VWlp2WjdleEp5UmcyL3A1Q2JSdm1BZTBF?=
 =?utf-8?B?WG9JenVMVkNUVERPaTJUSk1vWFd4YncyUDFSd1lIeGpsMDdPMm8wUUo5Mmp1?=
 =?utf-8?B?TmluNFZ3eXZ4aklWUDlVY2JlTlRtbUhtOVBNWGI3dUtPTDhnMmFsV3RVQmRa?=
 =?utf-8?B?TXVrOEdPVUpYTlJIa1hkQVZxaElpRzY5eE1xSlVIb1orclRPRGVsK0xSQkEy?=
 =?utf-8?B?S1B1WWtZQ1h2d05RTDVnZHJWYU9BUll5YmhUWXVWRVdTMUFvTk91NjZPVkJF?=
 =?utf-8?B?RkU0OVFldjJmY2haRWFXV2R5Y0Z3L2lyTTdTUFJNcWF1NzNOdzJaSEdRTlRr?=
 =?utf-8?B?Y3dTV0tlVlplWlcrMktKN0ZiZ2pWK2NYc1JOME5ZMGpuNTRqdE9MNTgxSEIy?=
 =?utf-8?B?T1oyQmpmRnB4RjY2d1Bmb0dHNmIrb1JVYVVXVzVzbFRvT0NNOXErSWVnelQ2?=
 =?utf-8?B?WWs4OWUrdVBUTjZVeUhiYzFacW5hZ2lLelp5YkE4MURKYkEzRkVTdUFDV0lC?=
 =?utf-8?B?cWh0NkczZmF3Sy9nODR5Z3NlZitBNnJ0Tzh2ditVVUJwVTY5bHptdnlKSlNm?=
 =?utf-8?B?dzM2aFo3SzdTY2xZYzU0NStqWUVaQ2owanlvdVY2Z3RUTUVka2tzYkdPMURM?=
 =?utf-8?B?eTB1Lzd0eXI1YlRTYi8rYUI5b0RSM0c2Z2pLekg0SGtwcnQzL29CeEh0Qlp1?=
 =?utf-8?B?Nlc5d1dTSHkxZ1ZXZCs2WFV3Wkd0dE5xZ0FjYS91QkJZWUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBCazZIYmJLdmw4OXJqTVIyR0UvR0s4bm9VbWhMNjlOVFYwUlFzc0tVbFNW?=
 =?utf-8?B?VnNFdmJLQ1hSbWhTeHFCOGJwTlllbjhUSEo4NHZLaXhnU3MvYlh6bnJKMFMy?=
 =?utf-8?B?cTZVRnduWHdQTGp4MVM5a3J3Nnprb1l4YzBoT0ZuSEZsdDk4QUIzRXppOXZh?=
 =?utf-8?B?M245WWZqeTBsQUF0NXgvRlBjdDdsMUZseklCUFgzTzZsS3pnN3lKNmh6enNC?=
 =?utf-8?B?QndzQU9ZbE53TGlKUXBybVRBa3g5REhPMlhybTk3SXQrSkdWdytEcDBnRFQ0?=
 =?utf-8?B?anI1dXA4eXBCaHNHaXN0Vk5QNVI3d0VOSWVuUEx3Z3d6VEhrRHBVdmZQMjho?=
 =?utf-8?B?WUl0VVV0N3VhMmNJWkNYK0J4cUNOR3RtMWEyRFJoQXVnOGhKUUlkTG9vdkJ3?=
 =?utf-8?B?SzBGVE5QMDZ3eVlNbk9oUlppR3g3K3ZUTGJPemxzK1JLOW9jTUNwR0pqTDlM?=
 =?utf-8?B?SzdhNFlEVXN1R3pBRGdRUjJ3K05wUTJpMmtyTmhMUTlocnNZR3NCWFc2RENr?=
 =?utf-8?B?VXBvMmlUZmhXdFZLOHQ2QmFtempOaFl6WGUxK0FJVzZXRXRxUTBTWUo3SVNq?=
 =?utf-8?B?QWF4RHdhY0x3cWQ1VmI4NE5mL0p5eFZ2TENOUG0vY2FoZWZYb1o2TkdKdHNX?=
 =?utf-8?B?Y0NZS01ETkRWTGZaU29EMDBmUWpTRk5BSE5udlp2UndjRkZWQmd4K0l0T1Bk?=
 =?utf-8?B?QWF4ako0WXdPblkxcVk4cU9oRFl5bkxxQVRGaUtieUpqaktDU2F3TG9oYnFm?=
 =?utf-8?B?R3diTkY5YlVwVlJRUFE3VjBhRTk0ZWUwN3VqcHVOR1Iza3l2Mk5GSVNhN1Jh?=
 =?utf-8?B?eE9rQndDRFZPa3NpUmRpNDlsclV4NjE2b2pQUmgxU3ZtbzAzSWh5WmxGL1BF?=
 =?utf-8?B?enpVMlp4QS95dnFWL0Qva2VpUGdCSjlYUlR4OEFScmZCYnQyWDg4L2xxUHZB?=
 =?utf-8?B?VExJMkhzdnNMcTBoL0p4YXNWNVQ3Z3M3eFY1QmNPbDBCTndXbVJOQ3FERVVX?=
 =?utf-8?B?N0FWQ2orZjFJK1RJR1U0UkpLN093R2dEN1dDNStRVTcxKzU3N0FubWlqTm9o?=
 =?utf-8?B?UmdCN2dFTlRuTGJ0aThnY1lHblNqRHhXb0VHZjhUUG44UHgwcElZNW54b2RL?=
 =?utf-8?B?KzZYWUhHTzByL2IzN2tBczRkdHJkZEtFdmFieTFZdDVNUDczS056QWpKNVNN?=
 =?utf-8?B?NXEydEtZdU4yZ3BtR2tXTGxOUHdHM1hUbHhzUWpkc1htbWhSRjVJSEtOeEU2?=
 =?utf-8?B?WlZ1eVIwZy9RWVJIRmpyN0J1Q05Vd2ZIcnpZVzZwZXVSNlRDYkpoYVdOcnNK?=
 =?utf-8?B?M0NYb0I1STJsVlkvZnRXdTY5K2JMV0huY1V4NlREYXc0aFlMc0xUbkNqZU1z?=
 =?utf-8?B?VUpYOVQyZlF6cTBnWEZoRXNXSDQ4WGxhb2loYnNLYmtvbkZ4Q3pIdG5Nc0Z3?=
 =?utf-8?B?RGtneU15MVp0allYUUMxVU9oeVYyTGlmVm42Sy92eXFBSjVVYzZkNk5SaVpH?=
 =?utf-8?B?ZHgzOVgrZDJldWF2RU5xekZTbmlWcWhqNCtDRDBjSGtPZ2VuWHlIWDJUZ1VV?=
 =?utf-8?B?d3A4TUJPZXJub3hwMjdCYjFnVU1JRkdNYXdJOExmRll6a1RXdzJrUFgvUDZo?=
 =?utf-8?B?cjcyZ3FUWEl0bEFHWUwvUmVucnNXM3NkOGY1N3h2TVJQK0VZa1lqSzFCZ05l?=
 =?utf-8?B?Nnh0WGJWRlZsakhsSXhvYzNjNHNicWpLbWVDQ0VXc0pSQTNyVlF1Y3BwTEJZ?=
 =?utf-8?B?MjRNSmU4cFA0R3BYd0xhdlhYb1F1Y3pBekpwTDZXN3lKRHJzMHlYZTNXRnVs?=
 =?utf-8?B?VFlmVmYxQk5tR1R4djlONUVXdVdHSVU5Q2xtNGtUZU1DcFB4eWVaTVRvbG01?=
 =?utf-8?B?K0RROU83c1JQd2s3b3o5cVl1RzBud2NqZ01DVnQ4Ry9oNkFWcy9ZeGVjYkpV?=
 =?utf-8?B?QVQrenZVUDZzV1J4Ty9TTEhXVFViMGtKT240dkNDcTIxZVZVZ1dwUlQ3ajFW?=
 =?utf-8?B?NXpVUU5wNDkzSW5ZRXVSa0F2N3E5Ny9wbHVEbWFRdDRIRjkxalhhcjRtWGpF?=
 =?utf-8?B?MldyRzEwL1lBWExHeGJYSmN3R1ZQRnREbk92NzlrWkhPcGhUNFZaSi81MTY0?=
 =?utf-8?B?djhTR1A3NUxYM3N1MVJrQitadUxRN0NXd0d6QUtXUUtsTFMxV09mQklpYTlM?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c213607-ac54-42ef-6a23-08ddc5f7839e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:35:01.4614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43IEvb6ks4tffmPX4AcODD56eS8nj+4DZMGALa9GNw/B9lEXTHfTvsXNexI93dQd/4hFr5t7281p9u/tgx+uy2E50GROChcyE0VPNnf5Pvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
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

On Fri, Jul 18, 2025 at 02:21:45PM +0200, David Marchand wrote:
> On Fri, Jul 18, 2025 at 2:14 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > DPDK now recommends compiler versions GCC 8+, and Clang 7+, so remove
> > checks and workarounds for versions old than these.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  config/meson.build                  |  5 ----
> >  drivers/event/meson.build           |  5 +---
> >  drivers/meson.build                 |  2 +-
> >  drivers/net/virtio/meson.build      |  2 +-
> >  lib/eal/arm/include/rte_memcpy_64.h |  8 -------
> >  lib/eal/arm/include/rte_vect.h      | 37 ++---------------------------
> >  lib/eal/ppc/include/rte_altivec.h   |  1 -
> >  lib/meson.build                     |  2 +-
> >  lib/vhost/meson.build               |  4 ++--
> >  lib/vhost/vhost.c                   | 16 -------------
> >  10 files changed, 8 insertions(+), 74 deletions(-)
> 
> Two nits:
> 
> [snip]
> 
> > diff --git a/drivers/event/meson.build b/drivers/event/meson.build
> > index d6706b57f7..b0bc3f40f1 100644
> > --- a/drivers/event/meson.build
> > +++ b/drivers/event/meson.build
> > @@ -14,9 +14,6 @@ drivers = [
> >          'opdl',
> >          'skeleton',
> >          'sw',
> > +        'octeontx',
> >  ]
> 
> Sort alphabetically?
> 

Absolutely, yes.

> 
> > -if not (toolchain == 'gcc' and cc.version().version_compare('<4.8.6') and
> > -        dpdk_conf.has('RTE_ARCH_ARM64'))
> > -    drivers += 'octeontx'
> > -endif
> >  std_deps = ['eventdev', 'kvargs']
> 
> [snip]
> 
> > diff --git a/lib/eal/arm/include/rte_memcpy_64.h b/lib/eal/arm/include/rte_memcpy_64.h
> > index 90039039be..57fe24eb10 100644
> > --- a/lib/eal/arm/include/rte_memcpy_64.h
> > +++ b/lib/eal/arm/include/rte_memcpy_64.h
> > @@ -89,14 +89,6 @@ n <= (size_t)RTE_ARM64_MEMCPY_UNALIGNED_THRESHOLD)
> >   **************************************/
> >
> >
> > -#if RTE_CC_IS_GNU && !defined RTE_ARM64_MEMCPY_SKIP_GCC_VER_CHECK
> > -#if (GCC_VERSION < 50400)
> > -#warning "The GCC version is quite old, which may result in sub-optimal \
> > -performance of the compiled code. It is suggested that at least GCC 5.4.0 \
> > -be used."
> > -#endif
> > -#endif
> > -
> 
> This flag can be removed from meson too.
> config/arm/meson.build:        #
> ['RTE_ARM64_MEMCPY_SKIP_GCC_VER_CHECK', false],
> 
Yep, seems there are no more references to it in the code.

Will fix in V2, after all CI's have had their chance to have their say.

/Bruce
