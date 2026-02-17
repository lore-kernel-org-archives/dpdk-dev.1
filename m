Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D5E909DE
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:06:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C72F40261;
	Tue, 17 Feb 2026 18:06:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E1C22400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:06:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771348011; x=1802884011;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=hXcDYBqj/T6Y0SW3k6edPfBg3/KA956u7omDjqt2gIc=;
 b=Xqi5cR7wqvga9gXplK9DifjxlJ7fnElwzjCvx6xTnWo3kfEq8TUg+l4o
 RJDg5HEH+AfEDZOIN0V8et/8fkhbxIGaqbtHzTgZpFeXO68kP4GI1oqwz
 G4HpmLJo8Qnx69VQoesAopE6he2HJ4Cr4/x6aIIq6U8MdnZtXXaqbNckO
 yzmyrj51R0hEaJhrQda+JA+oy9GqMoIe2zV2hikFko+zvhqLVKvpf14R7
 iKlbgT5rvuwOTBI2h7GJ/Y9kGqTiG6ayE/amMsBDVYehJNl/xNuFTlASH
 GXhEXKG5q+YYo9WKwP23SHGfrOVhmPsvlyY0qbVw5VwXUPrepIVbc1uEc Q==;
X-CSE-ConnectionGUID: DhGn1ozlQAuQgfwqTS+8dQ==
X-CSE-MsgGUID: gRuWo6JpTWeh7TBiNZd3dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83786655"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="83786655"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:06:50 -0800
X-CSE-ConnectionGUID: 8+24UJXiT8OJsnaW2+9c7Q==
X-CSE-MsgGUID: 6N7KGszySBCULxs819yD8g==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:06:50 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:06:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:06:49 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:06:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGFtOkm25iXC7p+IMhvTNB+GzotE+noveqRi0+pMtqOWC7XBTDkFAWl0QXeB1udyzXeDPmatKSdpaFXCHeTPCMcD0jhRroI9Px5feYrLXLrwZGjDDJkJh/0lui8/CMK1sFSf06BvZ5aGYZukyrxy0ormk7RjuJ7An5OfphKwFNsJPAr37I2jUJn2PQWzlR2LpZyQrvJD/7uTETyirpOfeLomlim3o+MgHJKOkysCS0j6d/P4JgmVXWk2V+qxB9ACsArxv0OEt0E7KBykeCARM7n2pVEf3RXJwsFIvcS3nMPbZQxzF0d6qs2vdMcZp6pPGHiFK+LwWHz/boSsYoX83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdjKrtv8f7imlNTUYjHp8aU2Pbad+nUw17yDd+IW9kg=;
 b=hwY0jueEnu/9Jgx8mDTxvufT3++vtlJtIpnc+wfrSa8/ZyWnDC70iGi9V5S6H6t4rxcL4zFalbrk3vZ61rcWZRp3N/LsKEMxa4oGpGa8Y2oZeRxURpqeRQMgvxW+N+Xrlb1CJhk+eLkyd3WuVYM6xMEVyiMxp44IfF/7YoV+m+dXAhd5MZInzMcoVA4pO5eDzjlOOcgq+A2HA4KZvvAAagin+0EtGH0gqGq8fc5Hkda81fwdAHv0VBwHQmIk9bNeA5ORye3wOAhLggqdRwA8Y1uxmjq0m/Violc2rvZKfzso1yoEK1r+m6ZXNfTF9m8BTI74nu7mXVUwVGUoAH83Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH0PR11MB9524.namprd11.prod.outlook.com (2603:10b6:510:3b1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:06:47 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Tue, 17 Feb 2026
 17:06:47 +0000
Message-ID: <8327dd6b-2a98-49f4-aa63-0c567c2c7993@intel.com>
Date: Tue, 17 Feb 2026 17:06:44 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/27] net/i40e: make default RSS key global
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <81423f82ed0dfb70ad69bb9b019a047b128831ef.1771330391.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <81423f82ed0dfb70ad69bb9b019a047b128831ef.1771330391.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0068.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::29) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH0PR11MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 688822c9-9403-4ddd-58c9-08de6e46ef2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFdxa2V6WDJNcGJmbjN1eFJxb0RVa3Q4cnByK084WHBSc0syZCtqaGJSbUhn?=
 =?utf-8?B?SlVMeUhhZlNGSUVGdU8yc2czK2xNb1Brb0J5a0hXd3ZhVlpzREFYRDJNRFNI?=
 =?utf-8?B?Wi9ZWXhIOUNwOFFTMlRKNFNycHZOdkZFMktVbDN4citMU2dnU1ZWMEVIT3ZP?=
 =?utf-8?B?TXNZcWROSkRrc2VhUHhXN1hMS2dwV2FMU1B5ODIzOTBlL3ZWcnJnWVRpbUFJ?=
 =?utf-8?B?dUU0azgwSWQ0K3ZaM1NybWZvdVVpNklJdU1nMVNkNkZ1cXZLUlBBQVlpd3Y1?=
 =?utf-8?B?eEF5Z0M0anRKaDBtMjZZZ1krNnhUck5weUYyTmhEUTcxa1QxS2NQSGpXbHht?=
 =?utf-8?B?Mk1tZzNDM2NlUXdVUEw1eWNrT0phN3dzWE9CSmladVlBYTBNZU1ic25EOUds?=
 =?utf-8?B?azRITmM0YVU0TVhBZURtOGtGZXRaKytUeHJXSm1Qc0hyMXluM1l5NmhHMk1h?=
 =?utf-8?B?Y2hhelYxVDY1NjNHT2ozSFEweHZZUTBuQjlha3J5a0Z6azFMNU5RNzdqNGhV?=
 =?utf-8?B?OUpmUDFySnE0aElsVmJ3MC9SUko0emlBNnU4enBZS1lHV2FFV2gzY3ZsL2E2?=
 =?utf-8?B?L3dQY3hhUGN5SjhodFVRZkYxQ2xFQmREY25YeWFLWWVSOTdMOERmdEZLaEJw?=
 =?utf-8?B?RE90VWZhUWZDaHFKVmJOTVhpY3l3d1VESjdhUFYzenhIbm5nRFQwWks3N3Mr?=
 =?utf-8?B?eE5EUWd4K251eHhLbDFNWWZOMDBPKzBscnhWcVJ6aTVFQnhzdGJ5NWRPaVlK?=
 =?utf-8?B?cEZNcU9PQ28wYTZCejY3QlFVVy9QTCt4bE1JUjFiYWxaa3hQMGtlUnBRc0lO?=
 =?utf-8?B?YlpjUEc1cGFia0NMTTV6aGxscDV2YUVGTzBxa3ZXK3B1d2Y4am1kSCtsbEVS?=
 =?utf-8?B?RC9wOWs4eUlhVUdGUC9LcUxsUm5QSVBRRzFnSHRUWm5NZXVvRENzK09zRUdH?=
 =?utf-8?B?K09LS0EwS1NBVVBEN2IxalZnMlVTeEdNeDFTR3U3OFpRZzJGdUp1NFhhOUhX?=
 =?utf-8?B?NDhuL0NRNDlVRG0vYzJLYU1wNUJjV0o3dE9PakdDekh6Z2pzZDRLZ0g2bEZK?=
 =?utf-8?B?TFJzQ0dDWmlBSnYvNkxvTmhqbThKTUdMTXp0Q3gwNjU2L1lYNXZsRXAzS2tV?=
 =?utf-8?B?eWt0MndieHJIb0k1OUw4alpLeVdVYlBNVGdUWEZYek1aN2ZQSXY5YmVNeEo5?=
 =?utf-8?B?MGwrRDMvSWlhT2lETFZQUEUxZGp2OTFDejd0Tk9qYko5d0paS3BGTVVIU3VY?=
 =?utf-8?B?clg2eFZHdHFzZUpBVnFPaXNUUGtLV25ueENBM2dNU2hRbEU2YjhFQ2R2dGlU?=
 =?utf-8?B?N2hhVDFGWnlGVTd6Y1puM0x4cVl6YktNajdiV2YrSGNqekRFenRWeUkrelpS?=
 =?utf-8?B?Y0RmMHdWNDBmeEJkSTdrTDNlaFdmcVloWUFEQTB6alRBN2JxVHA4UDZCVVFK?=
 =?utf-8?B?ZTJLVmw5WlFqSmpsVUZuRjhrOVNFTWpvSERQSTE0R3JZVTYzdWN5aGh0NG5w?=
 =?utf-8?B?ZUVwOWVxZU1ObHZzQzlDSmNpMnZIak5OTUR4SExHNm5HRURkT1NpOTdtQlVJ?=
 =?utf-8?B?bHI5dC9kUFRUQS9SMU1pZkR1Z3JwWVM5Mk5FOUd0eGs2V0RwbSs4ZVlOMmlU?=
 =?utf-8?B?clBvUFI3Y0UrSHZSM0p4K0hXc0ttWEZEYW1GYjhSVWNNWHRZbTBJK2ErekpJ?=
 =?utf-8?B?Q053bkErK3BYRHJiZnJ0T084Y0YwdXRyNFNKY1V0TE9mZC9XdGtEMzV6Q2ND?=
 =?utf-8?B?VitGVkpYM0ovOWxjZ0VwWkR3RVFnWDNEV2o5d051c1RaZ1BYTDVjSjJIZkgw?=
 =?utf-8?B?d3F5bGNJZ2RSd1B6OFZUbjV0QUNIYXcxSXNhM3VEeHpYTHJCM3luOW9DN0k1?=
 =?utf-8?B?dDQzTmFzald0RzE3YjBGM2Ryd1k3SGRIbGFzNENJQjFBWWpacTJWK2IrNXVV?=
 =?utf-8?B?Z1NoZUljenhDVVE4Z1F2eDRaemJrZDF5OE4wc1F4WmxqZGFrYzhzU0dvcXE3?=
 =?utf-8?B?VHZMdjRyWldwVXlqNWRQTXhTbytIV21zTUI5aDBzN0ZOYWRKcjhDU3lZUlQ2?=
 =?utf-8?B?UUFiVGVrRFNIamJEWVNqYnEyUFRvYWR2dGZ0ekJ6QWtQOVpBbDN0REwycFdD?=
 =?utf-8?Q?H79Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNRZjRQa2lYYkhxcFduT2lPa0JBSURxdHhkdTB1RU1VMDErTllhUHI3alRo?=
 =?utf-8?B?Yzc5dm4yYWdQQTNjMHVIZ0F4L085M3RTOS9TNWZBYTFzaHdEVk44SE9RZFlZ?=
 =?utf-8?B?K0JmS1U2WU5zdEtrLzU2Y1VsN1MwUW5QZmwvLzJjYUdOWXM0aVI1WjhGSkZi?=
 =?utf-8?B?YnlQUXpxbG9OdnRKTTAxSGlYclMvYjJIV2I2ckFOMXlid2lDOVNFQm5PL3Er?=
 =?utf-8?B?Q25FMUVoKzVHeGJ3NFpEdDdCSWJaVit3RGJGMDVEYVVhZzQzOEI1SjNqTWlH?=
 =?utf-8?B?YUl0ejJGYk5SWWdoYkxLSlNPdXUzUFpHaGNjWFVWZTRwRnZpUDlMVFBzcUhu?=
 =?utf-8?B?eU9XK0RQdWRkS1VJNVc2SWlGYTRrVXlTSldFbzFiRXUyRXdVa243MWNrSlNs?=
 =?utf-8?B?ZFNuMzFPN01VNWt4N01oWGlUQWJ1NXV6WmREblp2Z3AwTzNwQ3JBTE4rblFk?=
 =?utf-8?B?TmZIUmV2anJCTVZpeHFrdzh3d1hhMEticlVUMTdIZlNJUXh1eS9CQWJzKytw?=
 =?utf-8?B?ckEvRkg0Y3Z2WTMzWUU2eWlZMFhBV3FXQmgvUUhZcjhKdzRpcnB6Q2FzZ1lQ?=
 =?utf-8?B?eC9qN0tPWDh1S29ZWTBvR2JmWWpnN2wvMzBmQWhucG1UM2w2L1dCa2Q1TkJ6?=
 =?utf-8?B?OXIrdHNwNC9za3c5SkhKVXRyN3dUV21idTJCb21aS0NLcHZVbUprSlRmYzB0?=
 =?utf-8?B?dE5pY3VpaXpndnlsWmt5cGhxNHZFYWNYUW9LMXFOL1cxejFJRWF2OXVBK1k5?=
 =?utf-8?B?R3NkaHVKbFNDMXNUb2pNWXZPVEdBOE91RHJuOGtpWGdNNkcrZVltNW82REM4?=
 =?utf-8?B?c2wzREx6eDhHTmxxc1VLY2xXQktRVi9qNGlXMkVmZGQ2MWpmcHJjb1lvVU9r?=
 =?utf-8?B?KzJFWU9DdnRTbWNuc0RiMjBpSzNlOXlGQXZlWGhraWpoS3RyMFlKeHFRd3BL?=
 =?utf-8?B?RHFmL3UrTVN2Y1kwTDBoRUdncitFVHRCd0NMWWVQTU8ybERIQWNDSzlnV3JG?=
 =?utf-8?B?Qnp0Y09WMUhvNndhZHZRczBCblVTaUV6MlRIQ0JqelpnOTIzUGtScjNaaTJ2?=
 =?utf-8?B?a3pzZnFJdmdpR21aay9ESnQwa0NDb1pSb3dOQ2pacjBqaThJQlV6OENSWWtM?=
 =?utf-8?B?d3ZaUDVzdXEybjZXRW05VWE5OUpUb0dNZUFWb24zalpHNTRNbjhkRmN4Ymsz?=
 =?utf-8?B?OVIyWld0Q0xXS004NjkyUkN3Z3VrS05ZRVduQkJFWExjOENJSkRSTE9yaFUv?=
 =?utf-8?B?eEdFWVMrR1I5MWR2VHBMdVBGZFZPaFZCN3BEMGVDckNicDJLRTlReDhRdUFL?=
 =?utf-8?B?TEorWjI1ZU9UcnF0WDZMUkRVaTlQbFd6ZFdGVXBBNHFCdThDeEpOUHIyNjNp?=
 =?utf-8?B?ZCtScmRBbXlZa1NscUtsNGx0REEvVFJhZ3h0a2dHT28vNTZPK3RIWUFOK0d0?=
 =?utf-8?B?RWZTNDVTUzZhVENEdWxobW1HcEQyY09QQXZZM3k1OXRkbzRuWEFhK1FOOXJE?=
 =?utf-8?B?bVBoYjVGbXcwTUtJSHpFaWhtVmF6Tm1DVXZmQjZleFJ0UzQ2eDhYdFBQelox?=
 =?utf-8?B?VW1aMTNPR0s3c2s4cFg2VWVqQ1Jza1M4S01CMi95ZnovYzAzOEpzQU9Ta3dR?=
 =?utf-8?B?bGhFU0FyRm1nTEU5ZklsUFVXOGRtREVLOXF1eU9rVWdzN1RDYlFFWS83dm9s?=
 =?utf-8?B?dlFDN1p1OFNrSXpDMmpFNTh3NFE2aHM5d0JOaVdkRk42eXM2Q1BSQnNobWo4?=
 =?utf-8?B?MGJRVDZwTExTcUdSQVgraVJrakpvQ1V5N0R6ek1hSEJUL2piQUdZVGkxNksw?=
 =?utf-8?B?SnNFbGJsZStRTGtvQVBzSDFBQnc0YkR2MEFNMUsya0c3T3QwRnZ3NXhkTjJX?=
 =?utf-8?B?dTAzQmJRWGRydEcycUFwb1IweHhNUXcxUm4rUys5bWhmUkI4U2VrMFA0cEJQ?=
 =?utf-8?B?VG1BeUlwTEJpNzBBMDhTTnlDOEJIME9sZ00wQmZTVHB5U2ozQ3J6aG1LSFd6?=
 =?utf-8?B?bGMrb2dMNTZVMEtRN3M0M21BSG1wcC9hem01U0hWWlRhaE1MWVhmVVd5d3dY?=
 =?utf-8?B?MVpBazFhRjZmdURPLzIvakJTVC9yZFVrNUd4eDl1WmdJU0pqK0ZZNzZYYkJu?=
 =?utf-8?B?ODNkcFB2QXlEUUlJdmxocGJXYTRNRkNKL0FqNFlFOWttYmszZnc5bHl1ajJq?=
 =?utf-8?B?MGFtSk92RE1sWWdvNGdUTnY5Z3E5T2xzbHJZTndrSDhKdWtaTGJyejhhUU1E?=
 =?utf-8?B?cDhOMGhNdWo0UERQKzNCakxuTnZubkpyc1lER3RRN0FaaHVvWHpwTk1tK3Ev?=
 =?utf-8?B?NU84UEo1clNDa0EwTWNtQmZPVGp3MTlXQ2hXQlEvVzBTRW84bUJDUHdBb21U?=
 =?utf-8?Q?5p/VaayFkexjZyiQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 688822c9-9403-4ddd-58c9-08de6e46ef2f
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:06:47.5412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38XIGHwCm44k9mJd7b2o5dvy6OqMhZt0UHUPZVJwQ62j9R3xyFbnp0Zuxa8Q8JWN0aZ7mP3y64krAIsjLAbOtocPopLzoyTSaBZZDGwVf5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9524
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/17/2026 12:13 PM, Anatoly Burakov wrote:
> Currently, there are multiple places where we need a default RSS key, but
> in each of those places we define it as a local variable. Make it global
> constant, and adjust all callers to use the global constant. When dealing
> with adminq, we cannot send down the constant because adminq commands do
> not guarantee const-ness, so copy RSS key into a local buffer before
> sending it down to hardware.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.c | 22 ++++++++++------------
>   drivers/net/intel/i40e/i40e_hash.c   | 23 +++++++++++++++++------
>   drivers/net/intel/i40e/i40e_hash.h   |  3 +++
>   3 files changed, 30 insertions(+), 18 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

