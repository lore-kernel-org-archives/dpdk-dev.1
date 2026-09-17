Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A0C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 11:15:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B64340299;
	Thu, 17 Sep 2026 13:15:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D2C3A400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789643700; x=1821179700;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=8aRSF7VNuge74JPSddt6DrtcXjMzDkuqFWJl6ez1cgc=;
 b=jrgxQoMNbfci//oMxrsMZY0ipu55aua0mJ9cSEWGAFr4WzvXesQVY0o4
 r+gAdiFPPAKs3igcJZbahlkUUhDCyxkKSyoLWToDZZXonjPBoCwM8IS2E
 HKswDegwQuF+n/YiEJ/qYs6hVLZITvrIZYfDMcVvsK/l+GRzJChP4C7Wx
 7GmuSb1BMhdv/FXYTfla/nvFm+Cm7SuToa12JaGr14SzyqPLErQHJJnWR
 9ySOu0dnCaQZiHH6SO8y1u2bWB3nZmxiJKrmcjSMctIU06jQAit+u1iTl
 RrqQ9BsGfTlMP4aV4ZlRoZhTYboYub8RBperrBEBC8FRk17n3ErrF8CLX Q==;
X-CSE-ConnectionGUID: 8ty40cr8TveIaQyJ+bhkJQ==
X-CSE-MsgGUID: qztWg44JQFi7yUF36S7xMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100718362"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
 d="scan'208,217";a="100718362"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 04:14:58 -0700
X-CSE-ConnectionGUID: 1NGBD7inRyGCdrtF2HqNRw==
X-CSE-MsgGUID: n81ZCTUqT7OZljF2xBQqMg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 04:14:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 04:14:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 04:14:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 04:14:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GndQ8LSVwnSeZp0UtolBxEAxu3UWHkFK1IaHkqL1Iv4oddNOk4NVFwOEoajvj5hpOgXlwqgP91kcjeHm6U/hPPXAZx8qfJRxSCxCetfoQ6M0QxsMpmq2uiZSiKkQsk/Ec9/rAV/HqbN5uAGy5pXxdCoLwkD5lX20u5EazWcUn+JiU62Qa+xiBoQVzXN9VXoE1GAfTEzDeEDbyPQs4dnVF5uuThhAcJxOx7YAh1s6nZHr4S5ILViK+aDeC0ejCpQ0yDVdY9opPZMGIahOnkv+jqsest7uPS/p4SEeDONx9LyJ1zMVjq6rBnZNa1AKgpC301s5u8zoN8uKn2C8SaubYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGJ39BWdbHIxtEYCcIjACL19LCefCWKoOqv0bm6uyko=;
 b=P4GsehHrqt3Cfl+K/M2cLp0yMl9fL89Z8wHQ43R0Lpvrtlp6OEwn533dnjlDIIP0DbFf67Cbta7ArijAXakDmiMTp/QIfHMatk1zjVuEoIpP1RE5N4yUj3XxPbYzEt/qoh8aiqBgTgRoiSqpGYUu8XH2MGsGBzPIYDXM/4ZtdvCRcGPEe58+mT/8KhIiqWlDPQRM2zY8zuQewZd0rHeQI6r2Qoq0PymbjJJF5ylu5wXmxnDnk7Ebw5KQKbv1ZmrA4Ty7WB4rNvVMGqYVCsrihGYgL/2DcCGaIjhiINCpAwtXOvLd3L6/k/BHSstkZme/Lf697OO/CIXgOv+a8W3HxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 DS6PR11MB9917.namprd11.prod.outlook.com (2603:10b6:8:461::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.12; Thu, 17 Sep 2026 11:14:47 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 11:14:47 +0000
Content-Type: multipart/alternative;
 boundary="------------0vrAGr8ETN9YMNiCHi6g0oNc"
Message-ID: <5ac0b690-b340-4cfa-90e6-33cac4c30eac@intel.com>
Date: Thu, 17 Sep 2026 12:14:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Pratik Senapati <psenapati@marvell.com>
References: <20260917101641.335926-1-radu.nicolau@intel.com>
 <SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
X-ClientProxiedBy: DB8PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:10:110::22) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|DS6PR11MB9917:EE_
X-MS-Office365-Filtering-Correlation-Id: fac3de4a-5c86-486c-4d9a-08df14ace25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|8096899003|18002099003|13003099007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: HfaCG8QcRaStKn4PxcghjKtGLHpI/V1OOK9Ho46t6brCoDotiVPhXCK5mu9l2D1XVTMqskvcD4vyv3p8D0VAAvGR9b3BtQOwlerTRfbXwLM7bJ8U3q5d+qO0+TpcYNfnNH39jUU1dziNIEXyFbfjfeRMGj0MVWPO7jRIxE2RVsNhi7UW7krpRK1AtgajngvCxVwAX0UaBmA39QyVRz9OOeArqm5Wk1NyytSkUjcc1QVr5VQNLlvRmVWah4gAkJ9M38r65UTpY1HvJhOqo6Ai2pWSsp34hjgvkbIwQ0pPyzlPvwbuBJP3yVJvIL7QbATBpkwFr6mNaR55xYmGMOueWH/iVG9glZBgdZ660lGNqKd5mXgrW3B4hdM6py8298Ma1aKq88dbkQDmiMTjNsYoCe1tbi8yrMTzSK+IV4is7o0+1qVAZ4LgLHKcFI1SUc5e3YyeaG7QP6WI37mLLw1O65JpY8Urc+4vjs11WxvvyFG/YHwNnmdRCD90DTNFSl4pTZMoN+Q7ioLi2KDH9sNdxumMDCpimkAsbhUa5hj9q8nKvXOrAxItM4I+LwNh3v7CzSWkZXCUt8Yxm/LdHwWZG4awITQJSnpi2Fgpq8NHqwA8tX8pkMD6sWL5Q8z/3jl1Dkocnja8KHOuAL5xuC7ynTU4l/D6A0xgFUqCP0ZwqwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(8096899003)(18002099003)(13003099007)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTI1cDRiNDBvWG9pNTRMVUVJWUcyWlhUN0I1VkRXenBXMTdUN3RrZkNuUWht?=
 =?utf-8?B?cThsYWpPRlNpd0ZWL0NwaDVwbExpeVB6SFNzTzJrR25WL3kxMWJNR1ArYnls?=
 =?utf-8?B?OGIxcFNmeXRWaUROdEp5YXlHc2J0ZmhpbURPb3IzNzVUeGhRdno2cTcvN1Nl?=
 =?utf-8?B?SHBYOWZHVThxRGlXUnZVN3EwZUc2cnZtQ3dUbGJmdXdmT3M4dXhQN1RYclJ1?=
 =?utf-8?B?bEFaYWFHaGE5R2xUYzREeTJWNTRDVklXTXpTb25iVkxRbk1jS2w0MHpXZ3l4?=
 =?utf-8?B?UW9oV3NKODhwWEJtZEZMeUVVKzJpMmRIT0lNR3dFM0R2S1g1U3EzWEJYYldF?=
 =?utf-8?B?WXFBRTM4elFhSGo2UU90MmZwdzYwNnMrTnRLcGtwalFPNEpDMFd5dGdhUjNP?=
 =?utf-8?B?bU1TYWZENVlWYnlDWHR6Mm1vMzJDbi9TeXZLRExWdXAzZVFUaE9JQ3UxYk5W?=
 =?utf-8?B?bWJjOVBwVi9MMEp3cFp6WTVzV1J5bklRRERKbVJEanhoODhWcDdWSCtqOEJU?=
 =?utf-8?B?RjYrdU5kT1oyVy9uZ1Ruc2JSZWw2SGhrL1I1OS9rRGs3MFc2MFZWNlJMeWp0?=
 =?utf-8?B?SUl3a0oxckpnZHNMeThXaGdLU1NpazdJWHlvZWF3YlIyODFBTEM5c3VjWjhT?=
 =?utf-8?B?YzBYV0pXRXpoUG0wMEJkQ0NEUnozZGwvY1VGRG1hZGltRzQvSUpkNzJ0b1F2?=
 =?utf-8?B?REpjbmJUN0kzL0NtdjhrKzJkUEpHU0tMT1UxM295bU1qZ0RzRUZwY0NUWVFR?=
 =?utf-8?B?dVBOVEV4ZTNrbzVqMkRadVRKMGFheUtXRGxjNlZNY0U5dTg2R1dieTc1TmpR?=
 =?utf-8?B?WVFGM1N6RXRRdW84ejhvRU5OZWI4WStmNWJOelBzS3N3TlVEUzJDUUZyYjNk?=
 =?utf-8?B?WVRNN1FJWHNhVG1CUkFISVl0TU9iYXU1QXJPeVhITkpLTWNHa3VEOG9jRkVC?=
 =?utf-8?B?RWlaaURVUTBWMndyM001TnJqclcrWVUzQ3A0bWJKWUlCeUlQVVFKQk50YnND?=
 =?utf-8?B?Z3g1eWVhVDhFZzBWUHdRZDhWZDZkMU5iQkNmL0laeUVOUjNxWFZoeGlBSnFp?=
 =?utf-8?B?dEVzNTdNMVBVaFVmYTVhSDBOVHZKK0x6R2l1OVlHMU00UFBZRzFRSFlYUHdu?=
 =?utf-8?B?cC9nOEl6NXVSZ3RWMEtyZzFmcGsxT2hHK25Wd3VFbmRBdm9ZcGZBaFZYSmhS?=
 =?utf-8?B?azQxdUt1RW96MUFGaW9QU3JkUHRSaTZ5RHpwSTNwMHZjNnEvSklBTXRHTnBs?=
 =?utf-8?B?SkFiVGdpeTl1aFcwL1lDenZXTUo3VEtQaTZkbWRaVXJ1MENLbGtmQ1V6aUo5?=
 =?utf-8?B?YnhibDlua0drZHgvMGZNL2ZjSzdMSy9VTGY4TWh5bXZ2WDU4NW1tdlpQb1lS?=
 =?utf-8?B?OVhiZ0xOWjhxbkgyays2anBGN01CS1pyQXl5SENhQ2RrSFI4amV1U1NFdm96?=
 =?utf-8?B?UW5jZ1VTc3JvQi9lNDFEc0s1emp5K0NBSTgrTmxab3ZDZTVFbFYwNXNnRWVL?=
 =?utf-8?B?L1pDa2FBaE0rTm9RTUNFZ0ZlWmRDc05Jc2EydnpWOW1xOWwrT2RFU2hSdWI4?=
 =?utf-8?B?WlFsUkVlSUxzY3NkMk1sUXdXSy9jbi9xVCs5R2s1YWFmMG1xWWhHZDZaOXMv?=
 =?utf-8?B?cVdaK2xoMGRRaW9NR0VrRWxBWTlseVV5dE9uOHg5SzZBRWk3ZkRYcC9BS2w3?=
 =?utf-8?B?S3pXd0YveUsxYXd0aTE4aE4wOEFCMXhWelAzSjJYWXBvMis2YUtSZDcvMjkz?=
 =?utf-8?B?ZmlyQm9DZFdzUXNReXh5QzF0T0s4eUptQjh1cWE0UzYxV1NWbEVnYUpicCt2?=
 =?utf-8?B?d3BDUHJrOGcxemxXUnF2a0UveGkvanpvK0RkWnNnUkhiRzhwWUlzMUFjNUg4?=
 =?utf-8?B?Q0l4cUk5N1M5Z1pWNk1iR09VeVFobGtZQm5xQk51cXd2SGtsSS9NQTB5RjZx?=
 =?utf-8?B?TnYzNUJvOCtzTnpqa29UVHFEUStjNnJVZGVjUFZzTXlzalNEeVV5dFdRNXFw?=
 =?utf-8?B?WUM4YjJVb052K01KY0d3SEkvbTlZR2VUWWpmSjJvVHVNQjNUenJIVnlrcTA0?=
 =?utf-8?B?RDB0UTZoRUh5eVNKUFRQUlA3aUg1bnBaOGNJbFkxSnVrNUxYcktadThKak5U?=
 =?utf-8?B?YTN3UEFPWnBQQkJBekhGM0pENzU3ZEpCMDBGTkhNQVZFMTR0Ti9iVDVvUXZK?=
 =?utf-8?B?SnRZaTBicmZVblo2WjJLb1JwVGd5M2NvUE8zWW9QbkVBaGIva2tzRVAwVlVl?=
 =?utf-8?B?UnZuaUExeEo5YlJ3NStxcmM1YUFvQW1vbGtIVzRBM0p5c3NPWjFqdkkwaTdm?=
 =?utf-8?B?aFd5MWNRWmRpbmRISFNQaHNFZmFoUGtMVXNuRGJZVkdYWTNtYURNQT09?=
X-Exchange-RoutingPolicyChecked: oq2BpPXbh1lGSFVhSB4WexSy8lBH4K2AVmtwc7Gu+YXxddzK1MPZD4vgRji7S0nPz4eUZqJX5W5G//GaL9eJABLjfQH/ERP7K4qHjDrHKMyzFS7ILXWaTtDyQcA2NEhP6BEa78OLTQ2MaDrx6ELjYaA638PsbNTwH1wBXksAnkw/jdFlf09J+v8FIq45PdZmOl6GolxrThoVNS1P6ANYbJtCgoKxGaRfRqpBvwbe+0yFS1+6be7vzP2FPlcLSJ2jW+O9keTdxDDkOroKmmNwPAGZ3G5cjCp8+QrzRRqFfK6NL141zxC3xZ+zHBIcpMrhCyukwOZy52Rt5cTM+EzXZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fac3de4a-5c86-486c-4d9a-08df14ace25a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:14:47.5569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO+nFPkxABMbG5uI1Wr8v94y/6COOjosEgYlPdVYSpfVJFUrlLBCbctyE4AcG9qQVi37yDtda6uHq/8XsbDWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9917
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

--------------0vrAGr8ETN9YMNiCHi6g0oNc
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 17-Sep-26 11:57 AM, Gowrishankar Muthukrishnan wrote:
>
> Hi,
>
> There is a series already proposed for extending the autotest :
>
> https://patches.dpdk.org/project/dpdk/list/?series=39137
>
> Can you please check if that helps ?.
>
> Regards,
>
> Gowrishankar M
>
Hi, I will have a look at all the patches, they look indeed that the 
already cover what I did – I will pull mine down.

Thanks,
Radu

--------------0vrAGr8ETN9YMNiCHi6g0oNc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 17-Sep-26 11:57 AM, Gowrishankar
      Muthukrishnan wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@scope { @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}.MsoChpDefault
	{mso-style-type:export-only;}@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}div.WordSection1
	{page:WordSection1;} }</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoPlainText">Hi,<o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">There is a series already proposed for
          extending the autotest :<o:p></o:p></p>
        <p class="MsoPlainText"><a href="https://patches.dpdk.org/project/dpdk/list/?series=39137" moz-do-not-send="true" class="moz-txt-link-freetext">https://patches.dpdk.org/project/dpdk/list/?series=39137</a><o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">Can you please check if that helps ?.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        <p class="MsoPlainText">Regards,<o:p></o:p></p>
        <p class="MsoPlainText">Gowrishankar M<o:p></o:p></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
      </div>
    </blockquote>
    Hi, I will have a look at all the patches, they look indeed that the
    already cover what I did – I will pull mine down.<br>
    <br>
    Thanks,<br>
    Radu<br>
    <br>
  </body>
</html>

--------------0vrAGr8ETN9YMNiCHi6g0oNc--
