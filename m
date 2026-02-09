Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D15AE81BCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:40:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D1FA402C4;
	Mon,  9 Feb 2026 15:40:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4E0D74028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:40:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770648030; x=1802184030;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=G0FFIvRz4+n6IeiU/1YkLMXDg77mnawC47J/4dQQpQ0=;
 b=YXMmwHsK//3UR/JGPl5i7Jy+LduXBT2Zi3OdJcLtAqyIy0UWAUN9t0Ra
 jWVx5J0qpDEzNJ1eYUAeq1pm0V6ZIfU0HL63qziR81XumZb7tRzzFtbcI
 RPTk+kcfIMMIQNGuVg0oh2CtjzDwQ3PcFRaRXsb83b2mearZrW9AtY/3k
 ES0yXpYcZcqjtHNOjHpfFw+0+WBCVn0zF9J9LWeuzHE6n9PhaSlMHsRa3
 CDajvp6qy4kubMmsQCGJq5saktDwIkYrLC+dPX40UetSQbAG27w9iir/B
 ITIoyzXN5WC0tnelDqrp9cUx3EUApg75NDo4uHgilG8FivUo7v6beiayf A==;
X-CSE-ConnectionGUID: 2LdmnJ5BRq2dAt7J9MtLfg==
X-CSE-MsgGUID: M8S3ldnoSviW31jrMKF3vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71481225"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71481225"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:40:28 -0800
X-CSE-ConnectionGUID: DIwnx0gjS92oUO1VoMGX4w==
X-CSE-MsgGUID: z3+boEK2QKy5Qr1nwQRFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211615041"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:40:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 06:40:28 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 06:40:28 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 06:40:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMsgrDW+dzRhLi6A/dogdIUH2n5cChWl04qrGfjkbHdUWX12q02eJjEcKjWokMkqTaIQbVpGGhLqgzeJ9qdRufvHIFDy71ibQP6sMxsuBnctQ8MfTXU3+cTALNdknSEvSic+owsyjdgmS0lBPXgNTxxe8B3yOKfgMF2K9ZE4Gn2Q2ZtWUK4nuS8SS1fd29UFSUsXnccEagy1XhCe5VdxcNNYv6uS6hRVQlf4xA73yDJCcp7+TtozlsweZwriLpHCkcEem3+iLWgFrrR70XkVSIeRjxv+7c5e9mmMBKeG2Yts1Ok5KxKq3QxLL2ZQFQ7tNlksJA+khrHfuMRfkSwzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0FFIvRz4+n6IeiU/1YkLMXDg77mnawC47J/4dQQpQ0=;
 b=dXxk9xN9YQbM9+1opRy/lImACdJpfWj2HCOON8YV5l1g9uVuyN5W5k4R90tppuV2vSSS3yJfikKJW/zni5hxD+J1VMy5UWHQV4Kn+czW+ZkDGaPRPyzC07ToHRVxMY2fXDaAgfWivruLCzCootmr4PoJBueK7DjFb7p3kLLiNT9yrUUe96w4GXyCieKuEdPFpzyh9WJ5sD+DgSMIB/M8vcU8KojFv9IJbsg/zEQp/2ZP4bqzhteAIfOXuQ11M6OOUEa1J6NLgPXD63l3TC6qGEh6A+WPywVdXCb8Ce3/3o1QiUR73riVikrfEFlWZZ6YxW3nW89rhaObeXqhD3q5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 14:40:25 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 14:40:25 +0000
Message-ID: <e2762b1d-f3dc-4982-a41d-5b1388df6492@intel.com>
Date: Mon, 9 Feb 2026 14:40:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] net/iavf: fix memory leak on egress IPsec flows
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Declan Doherty
 <declan.doherty@intel.com>, Abhijit Sinha <abhijit.sinha@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>
References: <097106588d383fdccee60772deb166c252fa2a04.1770641909.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <097106588d383fdccee60772deb166c252fa2a04.1770641909.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::26) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 14db0fd7-6ba6-4673-9c18-08de67e928e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDMwdFR5cG55bHlPaXdmRXpzZ0kySkRkZjcvcWpXbmpJM2tuUUdjOHNtTlVn?=
 =?utf-8?B?T2xmeEV1VFk0NGN0ZjNqVDdUa0dxTkFlYnRPQW5xMFVwVjEwSEtUekdRek9x?=
 =?utf-8?B?M0pFMm5LRGkweERMa3BKaFVOR1BhUXFNM25LUG95MUxZUTNKNkxtWGFEK0pS?=
 =?utf-8?B?RVB1Y2JoT054YzRsV1JLcG8yRUxWQjJmK2NoTldwU3ZxZWFRSHoxZzBmTG54?=
 =?utf-8?B?UUhla1RPWDdrYUhFSHRodE5WS1hhL1FrazRZTGd1YjdMWjRJZFA2eHJvQWpI?=
 =?utf-8?B?Y09CZ2lySk1XNGg4U1RBb3dEV2xoWlI3bjhoODA3K1RKZmNrYnNWUWR5SVh1?=
 =?utf-8?B?ZysyQTR1aVFrdDFNbXRrcUtZbG5sV0ZOY1luUUJxeklFNVlsSHBZTHJJMjV6?=
 =?utf-8?B?WXovYlF3aGlGb1Jhdk8xbGtsSzZxbmhkKzZPMEkxVXc4UjZlcmRGVWtIU0pp?=
 =?utf-8?B?M054YjZpYVU3ZWptMmMwL0FJeTVXdWxjQUplcnNLaUdvdncxQm1hbDlVclZU?=
 =?utf-8?B?LzJkcDh2K3h2blY1em5Bc0o0cnJvY1NvbXM1R0tNVWh2MnM1RUNNcVBsNmFS?=
 =?utf-8?B?dFVEVGdUS1UrMnlEYk5qOFdyeTNsN3ROQjlwS0NaVUFPWDllTTR1VjhpUHRi?=
 =?utf-8?B?Z3pQWWw5a2JRZy9QMFBBaElaV3dscnpPbmtFWlNPYlY5RjFQV0l6VEREbDZD?=
 =?utf-8?B?dFB1cjAyMWIxTjJ1RFZQTXkxN3p4YmgzUG5zWmplTjNnendKdU1uSXprdFBj?=
 =?utf-8?B?bkw0MlRzNHUxcE04VW1aTXhxN1FWNTBjZUZlcnloL1ZvK3FZa0hhdWpqSTNN?=
 =?utf-8?B?K3Jhd0p1ZGVpb2NVb3I0QW5MOVN2Ymk1dTA5M2JHZGtjZkFENG9valBvekh6?=
 =?utf-8?B?Q0RyUi9WYzh4STlzZEZqRGJMN3lrNXVqODRkejFhKytXa2tiMm1SYi9IVUdv?=
 =?utf-8?B?eFN5bWdlRkljWTI4K0dWaGk3YklTamlVZ1BLSHZubUIvbTF6M1JQUWpyd2JC?=
 =?utf-8?B?ZldVVC9VVDE5MXF6NjZMTThpT2I2Tllhc2dLaktOY0Z0N01FSUMyUTUxSlZL?=
 =?utf-8?B?N2tWM09BdzdUVWtnUHhiSGJVNSt6RVM4MGRkMmd5am83RkNsMjlOUmU4eTAx?=
 =?utf-8?B?ejI3MytnZU5sdUgwQW9xeHRPN0d0VWd6K2srblNrNTYwQ053eHdOK2xjNzNm?=
 =?utf-8?B?dHpJVTk4Q21xQWtWOUhEVDVUaGVUK3Y1c1NGMHlvcERNMkVuVGRCTGtUY2tv?=
 =?utf-8?B?aGFFd2lZNlZLRUhzd2lGc1ZPcERmNUJLOTBsalJRYzFYWjJOcXBzRDQ3NmpJ?=
 =?utf-8?B?bGIxRTc1NktoK3Jsbk1YSVU0dXArV3YxRFJveWdVZm05ZTlCY0tqSHUyUzJC?=
 =?utf-8?B?M0VTVk1BMkk5dDlEbG9yelVMTGRST0VWMnd2alY5dEMraHE1MkNRYjEwNDlu?=
 =?utf-8?B?c2tQTzZZNyt4K1cxUlYxWjAzQ1RpWXhySjU1SEtRSGNYQmdtbk4rNUwxNGpW?=
 =?utf-8?B?Q2RtaGZXR2orb3JyeGZNWlAzZFYxR0VVdHA0K0QxcVJFd2pKS0tTRklabmxR?=
 =?utf-8?B?ZTBOTjRHTUROQUI5WG1IVU5XbDExOVNsOHgySFBYNXdwWWgyTG1UU0NOWU16?=
 =?utf-8?B?Z0pDbjkvOVBpSGJOTkFWSUtyQU8zODZJOWlQckYyTGFkWEhnWFV1bWtiNlQ3?=
 =?utf-8?B?NXRFV3ppaXpLQjQ3Sy9nVmUySmc0Ulp4QW1nUVIwb09YU3lnZ2IzZGEyY1l5?=
 =?utf-8?B?b0UxNWVISStYcUZuR1lDdlVBd3ZSRFZteWlFR1RoUDR0SlRRdEl2ZTVWTWJx?=
 =?utf-8?B?RlpOYkhQT25VQ2srTjcwZ1NBZzlqNCtJRFdqcGVjeGpEWUdRNGFvOS9pbnlo?=
 =?utf-8?B?QjRhNHJmZUNNOHoyNU4yWllqM2pJazI1d3VSM3RIdU9Ec1hLelBNZTFEcmtj?=
 =?utf-8?B?YzNEODRFYVJHZzNpZnJrZVdyOVd3QjRKYjRNdlRwUmhvVXNYbTE4T0U0MlhR?=
 =?utf-8?B?eTJ6Ris3YmYzQU5CNU5WeDhPOXpNQ1pUQ3kybW1Rc2JIdGJiTkR2V1FncUNT?=
 =?utf-8?B?Y1JLd1poRW1YTjQwVTlSV2JkYUZxRS80czRXK3BSRDlhc29GSm5JMEdKcmk4?=
 =?utf-8?Q?qGpw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clppWDl0dVMzaFZ1d0cxSVNyaHc2QmFjM3ZYK3ZSL05OSldCWWVwS2c5YjVR?=
 =?utf-8?B?eVJuRGhYNVBGQjJSS3BDTjBwbmFBT05QZjl4OFJFTGVFUXFRek5YcTNIK3px?=
 =?utf-8?B?cHBYS1pOOVNGZ2pCeVorVnkrQzROeDlpWDc2RHlNeEo5aC9sbHpaYVVramhh?=
 =?utf-8?B?c2ptSnAwUUpTeWFZZy9weXR6c2dOSU12R2VVWlJ2UlhKUFFmaTU1cXY2RlVw?=
 =?utf-8?B?amovSzJmVnROME5EWUJuekFEMWlQa2xORTEzVThxZHMzbENMTW9laklmTkZ2?=
 =?utf-8?B?RW1ESEdiZWhzVnVvdFhMbnZmOUNhN3UxcjBhQVU2UEJvRnJKcDhwVW95UXpo?=
 =?utf-8?B?WnpIN1l1TlJuZDIzVTB4NVg0WlV3NEVoZWl4ZDgxMmxQdmVnN1RFMXFBQXpy?=
 =?utf-8?B?RXo5Y04rN1BxZHdhdkxmejgvalZIbS9IdnNwNWxIem5WdXYvdzd4bVFraDZR?=
 =?utf-8?B?Vk85L2lVRUpxUXE3L29xdE50K3lFaUhWdlhUSVEzQVlIVEV3SkhETHFRUWUz?=
 =?utf-8?B?ZW95WkR0Vy9vTlJWelprcjVqWGJqc3BMb0oyMlR2QXpvQ3IyMC9JaFZvVURw?=
 =?utf-8?B?dlJPTWYxdGF1R0tpQVdMZm40Tk5FSG0zSVNYZFRWYk56S01QZEZ0S0tVRFNk?=
 =?utf-8?B?djdqQW10Q25zVVhQQjVJL0VGSk9HdTBxOEgvWStuYm9kaDUxc1RXSmxybkE0?=
 =?utf-8?B?YXFVMHl6QXgxOWxzbTFtbGZEYWM5Rk03aUllYnJiU0xmRWNaUStxUDh0WWhL?=
 =?utf-8?B?ZDVvYkZKQm5wYUNOZURBcFA3MHhhcFBkVnZyVjlmbXRqVmxQUm1uTjFIZUsw?=
 =?utf-8?B?TXRkQmp3TWNMRjlteTJPRjNpekxGVFAwUm9xZkthTEJJd0FENkJhSDV3S1dQ?=
 =?utf-8?B?S0pURTdjdGtYZmRXMDJtU0VnbnI3MHN6dURNNmVpSDZ5RjRzdVJoMG1jUzRY?=
 =?utf-8?B?bTJ0S1JkNVdPWUNtSDA1V3lhWXh1QzRtYzdWZ1cxNk9uRFNMSUNvNkY4ZjI2?=
 =?utf-8?B?cHFoY2U2ZWNWQ0hsY3Z3aW9iTjZ1ZFo5UDQvaTRtcG9ETHpEUmtvL21ndVYz?=
 =?utf-8?B?UDlmRi9YL2pmYnhUeEhDTWYrZ0ZwR1JPQWFEL0F6cnlGQW9UK3lrbnE5Z0ht?=
 =?utf-8?B?bHVvczR6NVdnNVNCc2xUU3p4SGVESDlIN0NybjBycWZPc2JDRGZOMERodm42?=
 =?utf-8?B?SXpqRGJJZE1JY3FLTit4TFgxc2cyeitLRHFRSXVIZEp0cXNRN1ptNERYanlR?=
 =?utf-8?B?VjdkQW5mQWlTbEZnemZDRXh4cVJiSTJMcEdCVlA0a2g4cWp2VUphSUxYZHpV?=
 =?utf-8?B?MGQxd2YrWitNanpYc1pkUW9ueEczTjhWdmdyZCs0cE1BMU1CY1dCbzk4dTlT?=
 =?utf-8?B?Y3FMTkNXWlVlbjdXUXpzOWdXYXBXb0taU2s4QlVFVEk4ei9aOStUa0dtMHpN?=
 =?utf-8?B?Y3JhMlhTL2gxTDY2SkN1eUhJczFXZmNvbWhLYUt0RVlQVjcyN09UdDBFQ0xn?=
 =?utf-8?B?aWVlbzllYjhjeXlTRy9ETk5NbnJPVkUwQlA1ZHdFMXpXY0FWWmVLWmtQNmR0?=
 =?utf-8?B?amVPU1ZRaGw4bnhoT2NKV2VkNy9WSUtEYXlCL3I4LzRIdjNvTW1NeVRjUkla?=
 =?utf-8?B?RXFPWGpxeWxHbUlJMFV1blBBVVZTWTY0cWU1d0FBMGRiR0pETXc1QVQ2Q0ZP?=
 =?utf-8?B?NDc0NlRSd0ptMWY3Sy9FZEhGRFd6U2tMcmlIMnlVRXZrTk9RdVVkZTVycTQ2?=
 =?utf-8?B?N09EbVVORHgra0pPdnNyRzUvQmNKZXllUFpTUDRGNUxpeEQyTmcydVgzdVo0?=
 =?utf-8?B?Qm5DQmtFK2pOb1JtS2lNSVkvMzUwRzcwT1EyRHJldlNkTWJJVUM1a1dnTGZD?=
 =?utf-8?B?OE82RzdTekhINy9kaEJxTnlneUtteXNYMlNtYnZRay9DMXBpaVhKNHBLQVZP?=
 =?utf-8?B?Vm8yUnZBTXpwcGVNK3BFU2NUcjB6NGszOHhQVmw5eVB3V1pDMEV5bXVBZ2lV?=
 =?utf-8?B?dS9wdVF0RE5EUnNmdHQvVVYvazl5N3ViSXp2bW4xc0RPWmZ1OERJMW5TeVV1?=
 =?utf-8?B?aEVrRkxwV0hLSnhCZ0g4SnBxS2pkOG8xZWVJTlJqUHQ0ajNUMzVIa2xiS1JH?=
 =?utf-8?B?cGtFL0NWVVJxdTlUS2d2THRPSW9zK0JXWUQ1aUpUMmJIazljOWI4Sy9NZ0Rv?=
 =?utf-8?B?UWtQaCs2dHBuQ3RhTDlDTis0Y21tbXdCaTg4ZEhuYllsc2FQd2xUK0p0c0Qr?=
 =?utf-8?B?ek52LzJCQU1vQVY4Z0dqSmVvZ0dLQ1RyYnYxNmdaeENoL3hNYlVlVkRiTUFa?=
 =?utf-8?B?aTVVL0h4RE94UWFPb3NZSTg5UldhZDhTZFNaQmVEZ2pwVXJEbmRsUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14db0fd7-6ba6-4673-9c18-08de67e928e3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 14:40:25.2826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BajGBBZnpqtLZQBpHaHAsDpk57Nj+BKFRN53H3NheOmsuRc6vbrkkiIgTLiZcgvpoczNIYpn2Bi5fU3lhNGrjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
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


On 09-Feb-26 12:58 PM, Anatoly Burakov wrote:
> When creating egress IPsec flows, no action need to be done in hardware, as
> this is just a software association. However, because we do not write
> anything to the rte_flow entry, subsequent destroy call will not destroy
> this kind of flow, because it expects a valid engine to be set for every
> flow. This results in memory unable to be freed back to the system.
>
> In addition to that, when creating these flows, we do not actually store
> the rte_flow pointer anywhere, so even if the user has triggered `uninit`
> (which would have freed the flow), this flow isn't in the list so it would
> never get freed.
>
> Fix this by marking the flow as egress IPsec flows, adding it to the tailq,
> and changing the `destroy` code to take all of that into account.
>
> Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Acked-by: Radu Nicolau <radu.nicolau@intel.com>



