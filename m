Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04AEA3F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE55340431;
	Wed, 11 Feb 2026 16:52:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 46D2440297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:52:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770825178; x=1802361178;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=kpx05rqui/XWAn9ZWn03+r/524QtZORwvf2HJ06Imkw=;
 b=djfcsuyStoh4xUMSpHMjYLRUIuv/S2OjWsAHhAe988v8cFslVHTPal6t
 w1AjiW+vptGE2VndG/n2Mfp6oBaw/ZrkNOIJBIhmp4YaI9aikrWsGq0X+
 RrjesT/WLn1JykR52mQAhKDjDdQZe3RU4M5q6u6pWWKXWWYP6eJxzViPK
 StBKKxExdTSRyMCWZzy11S+2Biu3Xbg2U8nXWbpECVdDfCOu7N5JqbewV
 527cb7tTO6or6jyAqKvZGi2CXnC9RJjLt4396RGvg2tEMZTnAwy/n1rj6
 D57BulLWzfubU2j+H40d6bO2C8HOsofNUn5rbSlh0fjeaBx/e6Ejqz1DW Q==;
X-CSE-ConnectionGUID: aGYjvTl7TfiWAzKntj1iAw==
X-CSE-MsgGUID: V0NSCLqxRBuDMX6lQQhuiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72047573"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="72047573"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:52:56 -0800
X-CSE-ConnectionGUID: z2AV5EgTSESp0JR6msSq0w==
X-CSE-MsgGUID: UBPymVk1Rie7962pEffUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="216557878"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:52:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:52:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:52:55 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:52:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDuLyBFeau6+7sV365wVKjTF4LEO1K4//wNv8nCi1MzNthd4lXyeuGASdbJ1jKX4+W9HXjNROs/coPyYzcD4oS/tkEgIBnIOyqbJ73YvIMSTjgRiC/bzxhzDlqa9Ow0ceSS/elFTf8awcsZ37zuHTXTS5HSUI2x6SLv6gaSVkSepvH/Vy7Dp+PPVhAOnCJcsSvluUtbyR1bEaRMDZSmJWcH4uALInR6Rs2hdbkj/qiCzbcscbtEO9j9jevd++OXIte55FIvJ04XV3EjnyXmtkeMb4hFBqEUqqhaPFYbiMKVIyzE7npKBCw0GzxqIyX/87V+qkB7/ehvKGW+w+1A57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9neVm3F7lKUZiXazcrPt8uegepU4GdX+UYKTH4pAFuY=;
 b=mfTtWTwwAUmcLbNSgX9Dlig3FgRrwoQgkNBiFPGJEWRIkC0EnwrqJ3a1WYvcTBPISSIkHGPN5vcrURSRJ0bFPkR5ZkkauiQM6isF0MYkwMQWxvADiaNLrT1KyiBYz0i/UNfnAiXyrHeQ446gnFbEhp04OP2ywrhOpYVUWc+MNcrLVAvqnzV2X926oV4VVd9qtMbFk263/aKndEcFKWIf2IFmhnHqVNgCnmaJCAkfq/DjKAf74V94K35mEvGeA6Xy3SK3oRmhexoedYkXlfIe8tRYTLytL0ZUk6jey1Pcgk7tmOMnvyru0CAl+ZuKLElIQFUTXg1yfHETCr4Ciau5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CY8PR11MB7194.namprd11.prod.outlook.com (2603:10b6:930:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 15:52:46 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:52:45 +0000
Message-ID: <b90c9375-69e0-440d-a015-df7ff75ec8ba@intel.com>
Date: Wed, 11 Feb 2026 15:52:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] net/iavf: fix memory leak on uninit
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Declan
 Doherty" <declan.doherty@intel.com>, Abhijit Sinha <abhijit.sinha@intel.com>, 
 Jingjing Wu <jingjing.wu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
References: <d977085ec59e6ab62d73603667aeac0474014079.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <d977085ec59e6ab62d73603667aeac0474014079.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0017.eurprd04.prod.outlook.com
 (2603:10a6:10:110::27) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CY8PR11MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 30aad387-2807-4b79-1c3c-08de698598bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3p4OWhYeXdZd2xvajBZVmRWRzlHcFFTeUVGZ0g3dkdMSWtULzU5MDZNeElX?=
 =?utf-8?B?MHBOeVVBd1FRdW94Q21zRi9iV0hJR1dWczB4THpQc1Z4TzBzUm1JVncxdnR3?=
 =?utf-8?B?UVdsVHJPUFkxZThvWW1sb0VJUkgzT1J3d3N0enc5NHlMUGJwYXU5R0dDOXBR?=
 =?utf-8?B?c0tQYWU4VFR5cUJxZ2k5SlR3aDdvWjZQK2Rpb1pJMWFUK0tXN080QVViR1FC?=
 =?utf-8?B?MFhKamZWdHB3dHFEV3MySWZaNDVJVXA4Tmw0MXJnQndqek9RdjFOeVgzdTgv?=
 =?utf-8?B?S3J1UFlzak1rckZTYURXUjdiSm9ZQU43bjRaUERReDlXYUM3M3g2QnJRL0Nq?=
 =?utf-8?B?b0tCUUNDdEc2TG85emExbjJBcDZ5ekhoZ0I4bkNpaXdGRnpMS2U1UHA5Uzgz?=
 =?utf-8?B?OHdwVldHRDFRazlZeXBXTnZDM1c3V2NWcXhndkNiNHR0TXlDdDR6WjlSMkdt?=
 =?utf-8?B?Ry9FeU5FQ3NuMDNQSk1IbTRKbzV3Tk9OZmxnRytsczRjTXFMT1pxWXlJd0Jp?=
 =?utf-8?B?bVVkczByK0oveWZHR0w5VitmMzJvRkVYMlZqRW5KYnE1b25qU1FpcENzeGhh?=
 =?utf-8?B?aStNN3ZRbWduZCthRlF5UDR3TTdVUHVYS3p2WHZwOXhMN3drT3U1QzBCVFZO?=
 =?utf-8?B?YzBobGhRWkF3VU9TYzFMQVYveFl6MU9scXFtdlNXdW85S00vTXB5ZklHWm56?=
 =?utf-8?B?aHpFcDNtWUc4L2YvdHNyblFpRnM1ekRuMHJ5TndCRDI3VmNmOWhneGJnckhB?=
 =?utf-8?B?YSswbHh4anA0a0ROdHREempzajNtVUZEZG1Yc3BpMlpITW5rbVVIL3lBbFlZ?=
 =?utf-8?B?Q0xhL0d6VWgydlppZlhUUVFENmJrSVptUDFSTGNKdGJKVXNFSWRLVzZKYWcw?=
 =?utf-8?B?ckwrSmpwdWdVMjYwZC9YRC9GN2kvd2cwZjZUdzBoQnJBTnZXbC9tZkwvNmJD?=
 =?utf-8?B?WGNRL25BQ29oUHVTNG5NeDcwNmtlVkUyZHFrZGsvNGFWYkFpWmRjN0VJenNt?=
 =?utf-8?B?enJCcG9PK04wanYzTXNIVTRnNjAzTm03Rnd2UHV3VXQ5TVRZWmdmRWpRL0dT?=
 =?utf-8?B?S2NMWml0V043T3lYQXBUWWt2YnNqMDFEbGlENE1TWDlhUStGZGp2emRMeDgw?=
 =?utf-8?B?S211VUpuODVmNjczSWN1UVN2L2laM1pua2wwZGljMXNWWElUdndoL1VrRVJr?=
 =?utf-8?B?V0dyQS9YUjdBY1dTNVpsOFhSaDRmeTNYVWNVZHNMaFE4bjBpVEpGdHJZdWZ2?=
 =?utf-8?B?ZWxNN0dTUnIxSHBJRy8yajlSOU1SYU1UNzRjbTJwbkh4amJMemg3akhLb3hK?=
 =?utf-8?B?c2ljd3pNRStwdnhmRGNQYnZHY3NBMzRFc0F5QStlVnVBL1lTdFBkZnpLN1pL?=
 =?utf-8?B?NnFzMUp0RXJmMFZ1YldvTnhpQ3ZydFUycVdGNmJpSVEwZ1htVlc1QzJhbXcz?=
 =?utf-8?B?V2JlMDlPRi9vU29TMTlSTUI0dWJTbUVEbVlZQ3h3MHAvaWlTVFBseXk5bzdy?=
 =?utf-8?B?NmxWclZJSVZxSG16SFNnemovOE11cFdpc252TTlGR0dLLzVtR1lDVEVHc2l5?=
 =?utf-8?B?VEVnUldRdTNEYmYzWGhXOHgrM28zUW8vNndsZXdvdjNQcGYyWFlTTm8wWUg0?=
 =?utf-8?B?WENMZXlTTmk2eTRaSWdiQnkwczJJbGhUUEZHZ2dmVFRlUldDZlBDNjVKb2x2?=
 =?utf-8?B?a3lvdXErU3RJcGtMUmFDVmxXKzNScVJMRVVwdEtoQmo1Z3lOekJuNmZlYmwv?=
 =?utf-8?B?bWlZMlRrWHhyZHV0R1Y1dXNlRHNpbDA0QVlxbjZEK2VaNi9NU0dmWC8vaTdM?=
 =?utf-8?B?RnlwS1lORDdIaEJjaVVhVEs0R2U1N1dEckQzYkJzZnVvaFE2Q25tQllIMXNX?=
 =?utf-8?B?eFYzb28rZ2hVcUE1cWsvY2xBVXlJbEllVkwzSGpvMTN3M1dqQ1IxeTdxbzkr?=
 =?utf-8?B?VGJaTkFHUWVUdmY0QnBYcU84cVYzaThPMjdIdHNVa0lMUU9qWk9zY3g4Z2Vi?=
 =?utf-8?B?UGZMUEJMOXBEOWJJdUZReUIwQXRuc2NPRTBaQjYyRnljVDJXRUlJYTFUT25L?=
 =?utf-8?B?Y2w0ZDdZdHdGRi9NSEFSNXpZak5DS1d0eXVGbXBHRVRUaUkwTkRXRXhoMkdW?=
 =?utf-8?Q?PePw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FGbTNSQnhIL2VGU3lKejAybWgyY3puVmdFWUtwdE9XSHlTajg5R3VlNEJN?=
 =?utf-8?B?cEQwbzZISXJ2RXVUcjQ5UXIxUVdMekd4MU1iNjBCZGJPY0pGNCtySU5EZHEx?=
 =?utf-8?B?QUljdUpzb0s0VzJtd1ZsU1JTTUgvSW9RKzY1NmVlTnROUzJQSnFMeUJrd1FI?=
 =?utf-8?B?b1k4RklFcGNXM3k2K2p5K1kwckg5UHh6UG5VeDNaSXFyN2hvcXJBZzR6c2th?=
 =?utf-8?B?Yk1ZV0R4Rm5UMC9lTUpsVUlqdmFwaUxHd3ZZZE5pYWZSNVh6VXp4NUdtaDBZ?=
 =?utf-8?B?aitzUlpMZ3U2OXZ4TjVOSnNDcXpYM1R1K3lKUkxnZFF6S2JxbW9NbjU2b1pr?=
 =?utf-8?B?ZkdMVUo1bjhyaytNbGx5aVNXcHVRa1JDM2ZZTVo4eVlxYnZIeGlHZS9vZW1h?=
 =?utf-8?B?UjVGaTg3dTFpVXFHN3F4WW15Q0JQZEZRVDBuTWRjMjhMb2xwZlFJQVNoVFFi?=
 =?utf-8?B?WjJxb0UrdDhHOU5uaVdjUzZhRGU2UW92Q2UzeGZZb1ZHR0RFeTFzYnpWMEFI?=
 =?utf-8?B?WkFoVUlOS2NVd240Q3RKdXBiSkhHb3czVFgxYTVqVzFlRGU4aXBXUFFzOXF6?=
 =?utf-8?B?Z0hUMTdCSTd2bW9nU3pLdmt2OVRPYjRUaEl1bTJqTUIvRW1nSzB3V2E3MUFN?=
 =?utf-8?B?dUpzZGxyY0V2RWZ5NUcyQ2pjRDlpbXZkbjhscVc2QUMvcmxQd3YwK0pFRUN3?=
 =?utf-8?B?UzNTNkJ0dUg4QlVRdnduekZ3VHpjVmdXMjF2MEVCUnNnU3N1b3FGZ1Y5NEFw?=
 =?utf-8?B?Y1Nsc2xTOXlRQUFwTUdoTUVibzliSmNPekY0a2lqVzVRNVd6MjRLbjZGV0VW?=
 =?utf-8?B?SkU1L08vc1ZEVnFsL1Q5MmI2S25VWHVONG5oaWVoWlJoMTNzb3BzeEkvQm5W?=
 =?utf-8?B?aHN3Y3NETzVEbldsUWsrcjZDT0Z1REdWWFZVYy93UlJSTTgxbE8wZ05lNkdH?=
 =?utf-8?B?RmNVMTlaMUw0bXY3ek05WjE5OTU5YlJsbGJTb0NPaUZMelRld050RWpJTzI1?=
 =?utf-8?B?NkZGWTRFT3dsZmNBcWsveFJhUDZHaDV6T3VyYUo4c01xemVDV09JdlgrU3VM?=
 =?utf-8?B?ZTZuR0ZLZEtMd1E2RWFMYWtwVkpXWDB3cWpFbEI1aUhFcEFwNHQvajI5Q0Ri?=
 =?utf-8?B?bWVDekRaVXp0Ym5TdDhId0k4eHF5andROVNBbXAranpnUGx2S0lEejFDTnNX?=
 =?utf-8?B?Vko5em4vMUlOVHBMQmdnRDFQemxmR2U0b3ptOWxkVjFaUzZHTktiaUZhWnRU?=
 =?utf-8?B?TEFYbWhsU0FNNzVaMnpMNU4xZ0FzQVlPTlFnKzQ3dU52S3ZyMWFxREVYM1Vr?=
 =?utf-8?B?RU4zUEZ0SDN5MmZWUlJYWW5GejloeUFtV3Q4WjJOQUFoRDUzZWk5bGlLdzBX?=
 =?utf-8?B?NGpET1RHRDRTamRJMzBDUE91OFh6Y2w3aFUrOTBnN3Nic25SNkdsR0hvU2s3?=
 =?utf-8?B?WWl0bXNBcnJVSVIvWWk5T2VkYzdYV3hQbUJ5aGxKbXlvWE9rck9CRXpzZ1RO?=
 =?utf-8?B?VGsrUTdzRFZPWk5hZFAycGZ0K0d4WWVnYmZFVU5naXFLQWNYRHp4K0d5dEtU?=
 =?utf-8?B?Rnd0TUNzc0JkTVVVTkwzZ293U1NvWVRQRHZYY2t0dnFMK1JuWFhPQmNicG5z?=
 =?utf-8?B?QndITDFMdXNHSGZJWTY2ZFMxOGtwbG55TTZ3ZUduMGVOdkhnV3JzRnBEVkFZ?=
 =?utf-8?B?NXNVemplRkxHbE9pcVhaSms5OEZWWHAwczRJMDBRemhVUStCdzBNUi9NK2NZ?=
 =?utf-8?B?ZHpnTlI1R2JNS3g5aXJ3djJTU2dSdTN5OVBMNHlVeGM2bUJ4bGhGVEFVbVFJ?=
 =?utf-8?B?Q3RUUitOVEx0eXd2KzZkbmYvdnpzNXg5MEZ4SWNnM0MyVjlTZFdkUnRhNkNH?=
 =?utf-8?B?MDd1Y1dPY3B4YnBaYVFieUNUNndYQXlVN0pYV1huS2NZR2ZmcVczVHpMc3pG?=
 =?utf-8?B?ckUrYks1dFJldCtxc2E2eG5DVHdFQXZma2Nhayt0R1hFSVBEQm5nc3VKVXFR?=
 =?utf-8?B?dkdabHBtdHNvME1nV2oxWFNHN3U5dWFhWTJJWGVyNlU2b1pheWJWUnFsK3Iv?=
 =?utf-8?B?dytmQ3dDMUVxaHBFQWZvaEk0MU50YTc0a3VhcEppdGdkbGNENUlISnlHTE1J?=
 =?utf-8?B?UFdVMTNvUTR6ejdZUys1MmYrSU5jK2lTbVNjY2RpUUlVRTlhSEhsazhSSXVm?=
 =?utf-8?B?eUtsS3F1S05vdFNnWnluelNNcE43ZGluRURyQ21kdlBnK2Z0SmIrNk1mUWRh?=
 =?utf-8?B?RzgxblNhK2JnWUQvVGNUNGtjM1BtQWhsWG9aTmw2bVlpM0Vocy9DQlJBUi9W?=
 =?utf-8?B?OW9IYkJmNmp3aE92OVkvWFRaaXdJWlBZU3VjdWk1dThWbzJqbUw0YVlScFpS?=
 =?utf-8?Q?O8UGZr1MFj3nIBcI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aad387-2807-4b79-1c3c-08de698598bc
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:52:44.9189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cTW5n0A5S+CTjCMZ16u5NSJck5sMD4RGZa9mVq4vAe3qUQiXWBVXuPWZqDdrmOObzOLChF/80ViBL1njP4f6QSXWlesjQ18PinXz/kmBd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7194
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

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> When IPsec is initialized, parsers and engines are registered into the
> common infrastructure. However, during deinitialization, they are not
> cleaned up. Fix it by including IPsec engines in the cleanup.
>
> Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Radu Nicolau <radu.nicolau@intel.com>
> ---
>   drivers/net/intel/iavf/iavf_generic_flow.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
> index 02917f863d..42ecc90d1d 100644
> --- a/drivers/net/intel/iavf/iavf_generic_flow.c
> +++ b/drivers/net/intel/iavf/iavf_generic_flow.c
> @@ -1859,6 +1859,11 @@ iavf_flow_uninit(struct iavf_adapter *ad)
>   		TAILQ_REMOVE(&vf->dist_parser_list, p_parser, node);
>   		rte_free(p_parser);
>   	}
> +
> +	while ((p_parser = TAILQ_FIRST(&vf->ipsec_crypto_parser_list))) {
> +		TAILQ_REMOVE(&vf->ipsec_crypto_parser_list, p_parser, node);
> +		rte_free(p_parser);
> +	}
>   }
>   
>   int
> @@ -1920,6 +1925,8 @@ iavf_unregister_parser(struct iavf_flow_parser *parser,
>   	else if ((parser->engine->type == IAVF_FLOW_ENGINE_FDIR) ||
>   		 (parser->engine->type == IAVF_FLOW_ENGINE_FSUB))
>   		list = &vf->dist_parser_list;
> +	else if (parser->engine->type == IAVF_FLOW_ENGINE_IPSEC_CRYPTO)
> +		list = &vf->ipsec_crypto_parser_list;
>   
>   	if (list == NULL)
>   		return;

-- 
Regards,
Vladimir

