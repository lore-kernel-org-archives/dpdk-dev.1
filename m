Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5468CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 15:50:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F86C402E4;
	Thu,  4 Jun 2026 17:50:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id AD0CE402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 17:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780588230; x=1812124230;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KLHIRiEnCLtdrOa23WCz6+zwYe8k+pDRBUgu8Q2G8cI=;
 b=YMPghd++JG8Rie1csb3rAovd4T2YituyH7KCiM7wyBwiEHFv7TY0QlRe
 K3VluS2A7TDt3uvVW8aJCjXeSs67N8er1Va0E3fEssjAmyASkafhCVWUP
 9i7UiiAkSsMMoXVcozYnIX2Sy1v1gZ14UMIe2IiOssn89sBKMZSwJVK2H
 /+tFeOZkXog6Qa7f3FWEIIZubMVuK6ibE7Q05S+DHSnmtg4F+CoP656YU
 7Pnjhoo2JVXh4QluOFY7TbEkRpZjWZRg8m0OsxrUNA9G4oK/crEHt5N4h
 C5Vf6Zuvg3MNmDkYFd2H1mO4YKNNua/fTGhIgRNMxyUeVzjH2HAHis+Ns Q==;
X-CSE-ConnectionGUID: zcdnbXQJTd+BVs+DCQkYxg==
X-CSE-MsgGUID: CENZemZnR0Ol3256a7zgMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81451296"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="81451296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 08:50:28 -0700
X-CSE-ConnectionGUID: p7u/cgR7RDOoOlp6Kca3NA==
X-CSE-MsgGUID: Hv9a9Wu4Ra+GoK7PNmBl0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240115404"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 08:50:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 08:50:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 08:50:27 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 08:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqX1weWlAL+BvyUAinrZoMBLZ4KmDf8ykhbO+2bPZRFYXZkWN5fTm7OD/XVoG2tLzW7nEu1mZIANFs6B348iY3ua1ua20Wuj/D+4QrV+sP1DXCo4wWFDRfqOaeNvzCutvzAiCTL0Ndu0HSNa3Y9NLU5GYRphiXiu7cdp3f2dZm3UbMoAJESRYul5nJMc0wYFDL7l0wFWxd/DfvzVefPEc4tDK8NCklez0OBs2l0q9WfhuEWWTSjbthEkoLWsNWK1fxNwBULn3xBc90+J785WklQcADfAv2PuBdpXIOaX32oQFcDYiGzESjyARE3e2paSbBfMZsCcPLIhsFdyBxsG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATlOBx1zf941nvf2zuPkTkdvL4e2esZ4cTbMuRcrNIM=;
 b=h3+vMgre6fCURKmyn1sE1OtrFk7fuZbAGcSzfV64RxgxQZIeCAVQSS/VpB9zhZi2jktkiwrja0clhuB+fvyTgDq3RAdscrufTzm+oNaRTiD6VklLMK5SIlLXW7QXSBz78BPgCpGTWc/HDts9fkAa32+csS3yIE5IfZZ2bJfLWrj50MNMNc6ZOkI1+6hcLWrJ6WtBqOyKrTyFzI51mL7CsYFUR2DzRsRI5IpNiCQuQddUP4o89efRWe384dPVyV6iM6y7vFU58So8y7AMaTcX1IuFvG2TxG5b62AX0vE4QsLSSwOsoix7YvK3E5O4A6zi71rWhBlIw5wustwOC+EdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Thu, 4 Jun 2026 15:50:25 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 15:50:24 +0000
Message-ID: <1cf7c0d8-1db4-480d-a518-a79d568b9909@intel.com>
Date: Thu, 4 Jun 2026 17:50:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/27] net/intel/common: add common flow action parsing
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <cover.1780068633.git.anatoly.burakov@intel.com>
 <cover.1780068633.git.anatoly.burakov@intel.com>
 <6834ddc6a6bc96b18f0078c2b99a58114bda54e7.1780068633.git.anatoly.burakov@intel.com>
 <aiAmGWmhD2n5ZPAc@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aiAmGWmhD2n5ZPAc@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH0PR11MB5298:EE_
X-MS-Office365-Filtering-Correlation-Id: a34f2d82-d0f0-4410-418f-08dec250fdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|5023799004|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zOlq29rJ9yTOK84rWSS56nmZ10dSeqBaanO9HDJgtTQ7CCw/WYB5dbJ7km1WCmyI09MQHCoRZD5A8k0hMqSsnwUN90Fjzg2deXWNlztvrxo2X2ssVpzJvkS52ZYIcOnBR39lWyBm/q4kfX8g90bhlknJkYymvuv1Tpc+Ns342VAkfBVV/3qpcwwSMCivTwLs1fgWUWwrPc2cDXRGS1qT9SEEXKClqu9+CBdpJ3ygS2wqlnWepZ75lesQK6ILwl8CqdzcNbmiF1rxT8VS5I9vlmkrePy0tKR5JQuPF62vOCYQt5+/KM3x8YQmyyl2XQHaJ9uj1gonkkBK/KLlTfrvL0cvOeDCnLGbAeNro/HlUg4kVb605S9ThpFhExD1ILlt8P0Jb66WBPhhzcdjHJdrdRAvNH73wZBQ+SzK96OE7RNqsa0lRuK/WtixUyY8HjmmMlx9/MDj7vNDe7vucuqh7QF8gSXcIoHW/d7AC84h/HcwGV+8Ed+u+hZ68sS79w7/qlHQx59K77gSGhVLiXrEutrCQdh680htzdZegtHqUSf3Ke1yy1/u09axG2asXErXoWD6UOvJ28VV4BRQNLv0EUfARLR05blR5V/weQfksTCnvprIWAjQk3EC7Tpi78cuIjP0AkmtelsjVDUQAVe4llKCVx7xwRb2FHAw7dzeCbO0KSBib0nNgMO4elTHIJKH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(5023799004)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1jZ0tjVDdKRTNEb2YrY1VndWM2U2FiVEoxRFpxRG5NNlo3UGpxdlVjaFV4?=
 =?utf-8?B?d3hoMnFGa01GblpyMVJLQXcyTjVla2RFZ1lJamVXOWcwWFRacGR2VGlqLzBp?=
 =?utf-8?B?dlR3Qnd4eWExYjB4SDUzbzBUZzFsZG44NTE0UzJDTnFTc0lIanJCb3V2eXFw?=
 =?utf-8?B?a3gyYnRZcnBVU1k1bGlKZGozUWlvSGY0YXJjNTBmRTJCV3NYYXlZamc2YWVk?=
 =?utf-8?B?eTJEb0p3dXphbEE3U25IM1hYRUsrK0s4cDNHTUZFekZKUHpnRmVxeENKZ3VT?=
 =?utf-8?B?c2F1WVUzdUNZMHVBMkJXL3NITjFhcm5HWHFVOVNrV0JaN0R1bFUrVXZzcFpV?=
 =?utf-8?B?WmsyRnErUzJpdVpNSXRKRE1nUzg2Y2wvWU1YUzVBek44dU02cjhZOXc4VVRZ?=
 =?utf-8?B?eThKSWdOa0hLREQvQlFEZTQ2NklDb29kMmZRNjVqWHllVlBBK0xYZGtFbVRl?=
 =?utf-8?B?SHo1dmt2RTBoSDRsaktWRUpQcTNJNVkyTUZVRXZSTXpwL3ZvcmtVUXI1ak5k?=
 =?utf-8?B?TGtrZjUwYzJZZkYveWxXLzhieG1sTGNkeTBoTDFVb3ZPODhKc0taWlRFd1dV?=
 =?utf-8?B?bjF3OVBCRDBhS0laajVmNWsrbXE4R1p1SmhzcWRvbTlhT3ZEL0NuZjZxU1Yz?=
 =?utf-8?B?MFUrZzdIbXV3eEVRQ0g1MnBYUWN3SlIzMXdUL1p0RzZsbEROdlE0QkM0UG9j?=
 =?utf-8?B?RjhZcExIRHB3UVRWdDJGbmNmVFkzVzNRdm10WTNBNlhzd2hMekdLVjNGcjRO?=
 =?utf-8?B?My9HaktZd0JkcUVSU2R5YnRaNFIyQldISUNOUi9yQVZVL01FczBvdU5GNDRQ?=
 =?utf-8?B?NHdOMEEzZkRtUy96VjJ2VmVZQWR1eThPZVgrUnBpZDk0SGFhVVdLcXcxYkpz?=
 =?utf-8?B?d1FuSndxZlNnZTFJZVZVNkI5SWVMMERPcEZzL2ZjMEl0QUdkT1pOc3d0MVh5?=
 =?utf-8?B?MGxEbkVrQkVSNytJT292NFdId2puc1Bqc3VIcjlwSHJrQzByNGpXNFFQWVFQ?=
 =?utf-8?B?cXBWc0JOSS8yNmMwK20zNjRHdEpHZi83bmZrdWpYMVd3RnBwTHVLalIxZUZp?=
 =?utf-8?B?VlpVME5sTG1uelNXZEluV0xxRVZ3eTBpcDY5dU41Q1Q3WkxCbUhOdG52c2FX?=
 =?utf-8?B?VmZ4Ti8vT3RIcE10TENLWEVrcnBUWDFMZGJpUGIvZ2NHMEl0QjZjOGVBRzZL?=
 =?utf-8?B?S0JHcHlKNVJnUnczSy9RQUdZaHloRTJ3ZnhWdWs2elZheEU2TWZWQjJSeEZS?=
 =?utf-8?B?K1UzZ3pNakxBTlhraWtkVzY2ZHdyQ1BydFpoU1l2ZkoveUx3QmNoSlg5cmhl?=
 =?utf-8?B?Rzk3UThyTGFBSDcxaDdrUTJiMWIwaGcwV3FaZFNwM0pwV0ZnVUVZcDJMNGRk?=
 =?utf-8?B?ZWhDVG1ianBhcW9ENk1VcW1jOVYyaU1MeWRZS1c0b2FmN3B0UmErOHBydUQ1?=
 =?utf-8?B?VmFOMFJSeHJOTEZqbGtGMW95TkNoaWd4Mk13L1JOK0lzRTVCWndINUlTN29h?=
 =?utf-8?B?M1B2cHhwelFlU0tFaFE3bXYrZ2E2OE9IaEgvMzMzenJkelAwZGxsTnlwa1kv?=
 =?utf-8?B?UjRtNEdaV25pbVBTOTRmcm10NFNVSnhVZmpVeDJSTG5QVlAxWDdCSVZTWHhT?=
 =?utf-8?B?bHRkQ1hwVDdpL1NWejJwcHVHNnViazVDdm9oamdMOGxQdTB4eVF0Y1ZMTEJp?=
 =?utf-8?B?OU9vcGs0MGZwby8rcktjbzlZVnV5dUs5M2tWWE40Y21WbllqNzBaSmxtMEU2?=
 =?utf-8?B?OHVWVkVTT0Y1eFRtNHdyeWpjRDdKaDFEN2RRNlltZG50dkRKRFp4dFNzKzJi?=
 =?utf-8?B?dnRSckdYenc2b1dROWlabEFuWEdrMlhlcGpKU0dtcUIyK21lTTV4a3pteitH?=
 =?utf-8?B?cEFudm5VTG9jTnlaUjYwS0xJZTdBaTVyUmRVWkZjeHNUdjh1R3MxTXBScGxw?=
 =?utf-8?B?RENsNXExeXFEdDVpRkZYU3RFZnMya1VzdDdmREV5cWdrZitSdUJuQ0ZLU2tq?=
 =?utf-8?B?S1JKT2trbXF6c2E1c2ZJWE9QaUpoOGRxVndTR3JScExvMVlFUkhMVHpOM3M4?=
 =?utf-8?B?eU9NQ3BRMEI5MUJZK0hzS0ZVYmUvSENVNlVkMHZWQ0ZnT0I5T2tsc2p4UG1Z?=
 =?utf-8?B?ek9YM0lreGZBV002MEFSMGNXRURMbE5hSDNnWGdtRVJQQkgxcFVJeStoR1JL?=
 =?utf-8?B?eng5YUFlTm5FaXJFWENGSlluSTFPeEpXcUhrY2JOMVFoRDRUVDBHcmhNYVk0?=
 =?utf-8?B?N2FWcFBmUUxUODZFcjNyN0tMQmFXUXF4MlFaODZYZFM5ZVJlRC9wNzJZM1Z4?=
 =?utf-8?B?Q3hWRjZxWUtRdVBkeVYyeTMwR0tvTEc1bklHa21LZXBrc0RhZkh5ek9iYzYx?=
 =?utf-8?Q?NPXZJOMeteJ4qrjI=3D?=
X-Exchange-RoutingPolicyChecked: kz8tc6aEsTqm8RS32CkhL6Q/9QX0gaI9WSxwE+WEI8pP3XFNxGHzQ9gcVJIC3TLJwNBGjwD/DEq4tMX465EyuvMIuwkuZ0bcKlOmpsNVt7ac09Zg8XCGrZEYsIY6UReKGpUigbZPWfpatHGte/m5x2KmYoFw/Ft1uRjQlGBOmuReByBuEw02BTaLHjwtt6z686J3DnVEirF9nBMJIQb4K/7axrQ5AHBIIEdbmc1otbmxBXZSfBKlvDYrret6mKalgW1UgVWuxji7MEhNbnXuzWkTyLocaKGj/8RtZaGyHhBU/LjMT9bU6Oif5O21KeW060TKb1TLC8BvkPOuy7wMJA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a34f2d82-d0f0-4410-418f-08dec250fdd1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:50:24.8086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TULdd8D0BgBG25ZVmaYdoz6z3OuVzZqBCGzK/novnrWlY0Qj25Z9+yB7IsYjKPV4zH5cOWZYFQ9y4V3e5lrtVO6bZijZMBPcTTNTFyqve2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
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

On 6/3/2026 3:03 PM, Bruce Richardson wrote:
> On Fri, May 29, 2026 at 04:36:05PM +0100, Anatoly Burakov wrote:
>> Currently, each driver has their own code for action parsing, which results
>> in a lot of duplication and subtle mismatches in behavior between drivers.
>>
>> Add common infrastructure, based on the following assumptions:
>>
>> - All drivers support at most 32 actions at once, but usually far less
>> - Not every action is supported by all drivers
>> - We can check a few common things to filter out obviously wrong actions
>> - Driver performs semantic checks on all valid actions
>>
>> So, the intention is to reject everything we can reasonably reject at the
>> outset without knowing anything about the drivers, parametrize what is
>> trivial to parametrize, and leave the rest for the driver to implement.
>>
>> While we're at it, also add logging infrastructure for Intel common code,
>> using the new component name defines that are automatically passed to each
>> DPDK driver as it is being built.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/common/flow_check.h | 279 ++++++++++++++++++++++++++
>>   drivers/net/intel/common/log.h        |  40 ++++
>>   2 files changed, 319 insertions(+)
>>   create mode 100644 drivers/net/intel/common/flow_check.h
>>   create mode 100644 drivers/net/intel/common/log.h
>>
> 
> <snip>
> 
>> +/**
>> + * Validate and parse a list of rte_flow_action into a parsed action list.
>> + *
>> + * @param actions pointer to array of rte_flow_action, terminated by RTE_FLOW_ACTION_TYPE_END
>> + * @param param pointer to ci_flow_actions_check_param structure (can be NULL)
>> + * @param parsed_actions pointer to ci_flow_actions structure to store parsed actions
>> + * @param error pointer to rte_flow_error structure for error reporting
>> + *
>> + * @return 0 on success, negative errno on failure.
>> + */
>> +static inline int
>> +ci_flow_check_actions(const struct rte_flow_action *actions,
>> +	const struct ci_flow_actions_check_param *param,
>> +	struct ci_flow_actions *parsed_actions,
>> +	struct rte_flow_error *error)
>> +{
>> +	size_t i = 0;
>> +	int ret;
>> +
>> +	if (actions == NULL) {
>> +		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
>> +				NULL, "Missing actions");
>> +	}
>> +
>> +	/* reset the list */
>> +	*parsed_actions = (struct ci_flow_actions){0};
>> +
>> +	while (actions[i].type != RTE_FLOW_ACTION_TYPE_END) {
>> +		const struct rte_flow_action *action = &actions[i++];
>> +
>> +		/* skip VOID actions */
>> +		if (action->type == RTE_FLOW_ACTION_TYPE_VOID)
>> +			continue;
>> +
>> +		/* generic validation for actions - this will check against param as well */
>> +		ret = __flow_action_check_generic(action, param, error);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		/* check against global maximum number of actions */
>> +		if (parsed_actions->count >= RTE_DIM(parsed_actions->actions)) {
>> +			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
>> +							action, "Too many actions");
>> +		}
>> +		/* user may have specified a maximum number of actions */
>> +		if (param != NULL && param->max_actions != 0 &&
>> +		    parsed_actions->count >= param->max_actions) {
>> +			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
>> +							action, "Too many actions");
>> +		}
>> +		/* add action to the list */
>> +		CI_DRV_LOG(DEBUG, "Parsed action %u: type=%s", parsed_actions->count,
>> +			   ci_flow_action_type_to_str(action->type));
>> +		parsed_actions->actions[parsed_actions->count++] = action;
>> +	}
>> +
>> +	/* now, call into user validation if specified */
>> +	if (param != NULL && param->check != NULL) {
>> +		ret = param->check(parsed_actions, param, error);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
> 
> Running an AI review on this code myself, it highlights the fact that we
> are missing a check for an empty parsed_actions array here, and not all
> check handlers verify the length as being >0 before dereferencing. For
> example, in patch 10, the callbacks don't explicitly check for empty lists
> I think it would be reasonable to have the return -EINVAL before this
> callback check, right?

Yep, that is correct. Empty list should fail *before* we go into use 
callbacks. It is safe in the sense that references are never invalid, 
and well-behaved callbacks should check count, but that only reasonably 
applies to callbacks expecting multiple actions, but not just one.

> 
>> +	/* if we didn't parse anything, valid action list is empty */
>> +	return parsed_actions->count == 0 ? -EINVAL : 0;
>> +}
>> +
>> +#ifdef __cplusplus
>> +}
>> +#endif
> <snip>


-- 
Thanks,
Anatoly
