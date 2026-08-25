Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0912C5DF94
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 08:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEE794014F;
	Tue, 25 Aug 2026 10:07:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 8D8F5400D5
 for <dev@dpdk.org>; Tue, 25 Aug 2026 10:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787645232; x=1819181232;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XYWrao19hPPTYS8E8Dn6k0L6v1EwGdmawSt8yP4cKsk=;
 b=J40MyXTrpa5NvEPZky0P30vBqAiY2UGXujiwKKXhGzEE1lyY9DhVlRWh
 6vS9NWFGgq7XkLZILEjmJdhlstVK6DJ0gtqS8pJLkIeXd9GJeZOROcT6l
 4cHxEr5Kd70OLJn/1lAJIE2+rGlbnoFhPd66zcTFAvK2gb7klBdaF2ULc
 578Q5JOYADGuQmrMNzOBVPEVPxwy/euc/Lk9KOBJEOKvB6Uo/wg6VbTzc
 w2Gi8CiTFCWTz1wzuB5SBLg1f5WyHnK+nMzK7a9LmHOZ/z5175Q38lR8p
 Rc6rfpgJKYsCIaPZT9v8CxocFyb/JUXs8PscMvNda8dbkiuxE/BWyEuhx A==;
X-CSE-ConnectionGUID: ksE7EAgwQ9+kP95JvYLXIw==
X-CSE-MsgGUID: NvNOoySAQNG7PjiszeWOHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88122363"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88122363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:07:06 -0700
X-CSE-ConnectionGUID: 8hwrMXAgS/+VAXSeQCpe1A==
X-CSE-MsgGUID: gy9seEp2SVaE12YF9QFa9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="272443108"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:07:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 01:07:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 01:07:04 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 01:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQquBKkM0SujzArpp0TcA8g8+k4ANQX8bSv698VNEKTjjakFOTlldSOGbCBX2m+R5eQ6B85Fnvf7oUZPFRgvt4cyaIh/q2hwkFZPJR9til8dQnX8EiJxCl2ohgdIFY80xcKpbGfRfWc0ysQtanLwb4yVE5RhSme3ZpFrIk0B8/lRSY678zKTRG4XixsnjekwlkHhpgv5ux6Rgi4FHWSs1s5Dks95nbsxIxELQlM3cz5CSdLmA6YwsVV9+Tdby+a9hsB+haNbuFTkjtretKxed5sPouJNGmEbfCy5VlcxjkKt7xnQRd+HqI3bkcDZD4k33dDFkQ4rQA2rPEG5OvMRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bMOzpILuW/aCu0K5zhXcWh7HCClGt/U+4LQVVlEtm0=;
 b=hw0A3I9bSYJPQY29cZmRxeB2mrFczTANTtFug+GOD0d/lsORN6hMLycUJ2cBWlaK1S1MqyK9Q4khemXUg1vYuRXk0EVy+yk09Q5PjmSS8Gn4VtSB4pcHUnx7uMO2akB/wWTlKZqJCDJh1/qT8M/amoQNrVmtR0NGIRTQsmw27HIzBz8UV/XWsecXpr3uWvExbKKA9ee4oACQebIUjALUgEdnG79HOqqcyrdZRlXTmumfHZVdt1VhUG0zWZGdkqaTfxOQJrVimA5vZ2mfXP7K0Vgf+M+paWJWx8WGqvs3m8mIT4Q7EJkqGA2I9cjtDthfxUenTpOc99FxD/Q4S2+2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:06:56 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 08:06:56 +0000
Message-ID: <76d7b0eb-34ae-4d09-b4c5-1523578241f0@intel.com>
Date: Tue, 25 Aug 2026 13:36:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/cpfl: add timesync support
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>
References: <20260728102008.860157-1-anurag.mandal@intel.com>
 <20260803093027.870965-1-anurag.mandal@intel.com>
 <SA1PR11MB67825EC0A3DAC9E8282B44FEE4A72@SA1PR11MB6782.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <SA1PR11MB67825EC0A3DAC9E8282B44FEE4A72@SA1PR11MB6782.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0205.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::14) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|PH3PPF9E162731D:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f1eff9-14fb-4106-cb54-08df027fd48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uNKafvuRn3Ffzk1fVbQ74V8X9FK9alzc8fWXsihHYFh6IpdU2FSbY9VBbmVj7JSZqD89vrshWXpSxRagYrwVPLlsoWdrCHSk1Gx4q0ITqpuY47QgsmQ/Gosx10n8karzaF3ZqVB7BZkQ+YJ6GPaenqmkUkTymgEZHGYH815Qqeis2t4WXYCTJHImcP+YdFYRsv2VRlTYZhpbM3OpfPNzWXBWJt2MxGHZroQgsl901zZWyk4SzmPZraeYlnj3K5/827w5P/WDfo8sihxvlHdFH+cjZkC91uWHoMETsnbVvJylX+kAJxuQ75zMDkELIoTxSEPH042ErkFNPh1FL25F1VjTtd5Ndaaatz6jfGriruYbMP6+FPTWg5cyze5PlzNQr1DTFPA3OY/i/JTAv6JxvVIPphBF5d9p9JR9BXcJIqqRl6538s1DXT1QxvujbryX0mWXFnoDEHxZhmVGoowkL820kddU7UtsfN/ZbK053aPj4LtAFzl2w/pR//lwykWoNZyRqISULlNfnNQlFLJQi1++HTOESqi3bVIE6pgBDpPuIcO+yK4NEjCLty+7YIPFgaHXsp9G9c6a36XZm2LezClvxj3ec+vsWEuVvBB/kD9A49oPcl7fNigO/GHXV5J0SUStFuRE38GoKnhV7FLP8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlAzakRZSHJ2OWtZTzVVUk4yNmZYd1B5U3Y3V2VhY0t4U2RrUVBvN1lUOFNN?=
 =?utf-8?B?T0NkRTI1UWpxY2F0eFpXNDh3ZElkUXV4QTVmUHFlL2RzYzV5ODhhZ1B4Wkhq?=
 =?utf-8?B?Q2w1NDM0UUlTSUExck1lZVU4S3BXS0dLeEZYZ2RNSU5XSzlMY0Y4L3NBc2hD?=
 =?utf-8?B?ZnpobGs2NkVya3pWdVh5K0ZCWTRqbHAxa2M4NUg0eUNzWE5iYmdUL2RPQ3ZM?=
 =?utf-8?B?R3ovaUVRbnhNQVBqamw3OWlRMDNTa0lFRTBRMjY2QTdSc0ZhUVh6K0xseUpT?=
 =?utf-8?B?WFJUa20zcGkyTU5qcWRFTW1wdkd4K3NReldCTjR5YmcwK0ZQdkFZYS9xUTJS?=
 =?utf-8?B?TWV5djhrRCt5bElBMHY0bm9JcENQOHArUm4wcU1oUUQ0bFZUMnZ3OVozVUhw?=
 =?utf-8?B?ZkM0QzlXMERzT1E2ZUtleXVmbDB2UUJBN2h6T3BJMDV1UXhxaUVLRVRYZy8z?=
 =?utf-8?B?OFRMbEN3eHNMR3dCMHNaczdWQS96SVIybWVSbWlDRlgvejc5djRaRGx6Mk5K?=
 =?utf-8?B?MmlhSGhGYUEreFpMTFR4NERXekh3aThLSlNtY3V1ejFPR3A0Ky9iYVJqUTIw?=
 =?utf-8?B?Wjd4TlJoMWxmQmc0eU1VcmpNUE5nRjhubXdGK25TZEp4aGY2elp5ZEN0OXVt?=
 =?utf-8?B?bDhoZkpzRUlSOXZpWnl3NUxiUHhSRmpuTEE3TE1YV01Ed052YlZ0VVEySmNB?=
 =?utf-8?B?WitZL3BYcURZdm0rZ1B5eWVST0szTVorbTJrNThjSStWWWV1QTVucGVYZFRr?=
 =?utf-8?B?WXBmNDNLWkl1N01TQ0hUNFhaRVdYZVNxL0FkbHNoVHdpZFN6Y1Uzby9hczVj?=
 =?utf-8?B?ZHM1c1JrZUhYTWF6Wlo0QVdxMWd1OFl0emVTY1BIZnE4N0lKMU4vVEtXMTJL?=
 =?utf-8?B?Sld2ZTJkTEhqb3hWZjZjaHg4ckJ3cDA3bnczOER1dC9DT0pCUmNzWERxRk1R?=
 =?utf-8?B?OTVQQXNJWHZQMHJ5ZTdRMmYvRTc4NzBaNXpwcWFhNU5FMDhlUkdjSDFWUkJo?=
 =?utf-8?B?ZDhJbjNnaUdIVXZzU3FlelA0aVBQQWNFd1U2NnNpd2VWYXJmUmZOcWgvUzE2?=
 =?utf-8?B?bmFvWWdqbzJxSUVoSk0rMnFBTVd4c1JXb0ZWanVvWk9HTGYxa1JKUXJWZjBH?=
 =?utf-8?B?RDhwUTlFb0hwRjVOL1plNmpGSGs2MmhaWStCenVFdUR3Uzd0TE1RVVFvVmtt?=
 =?utf-8?B?emZrRjZnM09LVFA1QVFibmZVemt5aTVoNHhXbjhLOERaQVZJWEdWamJYd3Ni?=
 =?utf-8?B?blFNWEtLS0FDTG1GaCs2bmhvRDlUVzlvVHZXOEx1cStsRFdIL01FZ0VyUTdH?=
 =?utf-8?B?anVYQTNUaXh1QXhmcTlBNlZabmxSVzYvSHREVjVHb0FyakxadzZ1ZDdBRE9U?=
 =?utf-8?B?aFl4QUFZS0c1R0pCa1E2bkJGejhhdGpWMWlzcEhOVVB3TnNEQms5RHhTUkpw?=
 =?utf-8?B?RUdrcTJDekNNNHRKblJsczc0WkQyc05XYWw2Mit0cmk2RHNDSFRSc21QQWhW?=
 =?utf-8?B?M0RmWEF3VVNhNThFZnVSQUZ5c24yc2VVV09VL2Nncyt0Qm5QZDFlN1g0YjVL?=
 =?utf-8?B?RkNrREk3T0xyT0tSRXdKaGwrM2hibWxiSlhDeVdtT2dIOWdoQmZVSFNOV1dK?=
 =?utf-8?B?a1ZOM1ZrM2hyUWgzamdqdUwyWS9FN2ZYS3RXR0libHl1UjNLbWNPeDAvV1Mw?=
 =?utf-8?B?WlNlcEcvTEVCZXZ3aVJvMHNTa1daVloveTlRM2J4TEdJT1lUdERYenRic01m?=
 =?utf-8?B?RFNqZFJIT1UxMlBybEY0d2VmTXBCWU9XSjg4UkZKYzc4bCtzVXMyeWZuVm9x?=
 =?utf-8?B?MDZvWXp4aXhOOFZsWEIvbDVBc1pwV0FIS3ZCNmlUYXFwSWs4UGNRbjhOWFBY?=
 =?utf-8?B?T2xHSGJWTnZXbDF0TWdNenlFemJCb0d5b082MFg4QVJjOGhOVG5LdlQzWjVw?=
 =?utf-8?B?eHErL1JuWnM1VlV6YU1va3NIak1sTkNUMW8vcGVnWGRnb2EyM1ZBWUdhaHpI?=
 =?utf-8?B?aStxMDd5ekJEU05mN0hCSHVpbUE1RjFPYU9aSnVxOUQxNnlRUUs3SnAwUTI5?=
 =?utf-8?B?bi83aTI1R1grZmVrditWWnN2Ujl0ZEhuOHdJNmtJamZTQWF4L2ZVK21hc24z?=
 =?utf-8?B?Z2Nia2tGNXVCWjlsVGxtbm04WElOZXFhZFVIT2Q2bjM1d3Y5N0h2eUlXUEZ5?=
 =?utf-8?B?amJrTkNibnBuMW9Ic1NkZ09UUVZ1aHVUZjVkTnptKzF2cStnamQzWG9uVzdG?=
 =?utf-8?B?UUZ2SGdGeGpGemFsWHhnWXZVdDRLUnJmM2VXM0J4QTREaEVyMVRHMHZGc0U0?=
 =?utf-8?B?VEhITXRWa1RSS1ljS2YxY1gxUTBaS1N4d1RMOUtkRjNlMkpMa28xWmVOTEQv?=
 =?utf-8?Q?evQcA7P/oPf0nBa0=3D?=
X-Exchange-RoutingPolicyChecked: YmaNQ291ohUDIYs+uatdmqY2XtWX9EYYCOp3CzvSO6bcXjgNH4tTb+DY9JA5RTlnmLBthelx0OGzpfqBYdJLTFpS2aoGQPXmBPsNP+9WLBdMNiSKBSqh3WI7I6eyYs6NSA8AE3LkWolHze8j3vTS1hWmyPBK8H5aIcyGUoWTljdEnEGmtoQmiGBjEUSGk5ZwthQlEgjMP/XN4e5q1oP61CsQaorE5hiT3oGD+RixEvBiqS+5uKsBnptK+uvn8JzxuwjoTDvQx2vEOqb77bEAvzcd/Md1n4v16qfQYt3cHnSeSxBd5QX9e8INJBRCGVEFZprmikHVYfyDkHZ8b0q53w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f1eff9-14fb-4106-cb54-08df027fd48a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:06:56.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnMCtdcAaQnQSS5olHCoxv0YRyJKVL7YNw1EOLgcm5pVjipVXRe4rZ1QybCREPOnYu4v4yECX86RPfIh9HW+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
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

Reviewed-by: Rajesh Kumar <rajesh3.kumar@intel.com>

On 17-08-2026 02:48 pm, Mandal, Anurag wrote:
> Hi All,
>
> Gentle reminder for review & ack.
>
> Thank you.
>
> Regards,
> Anurag M
>> -----Original Message-----
>> From: Mandal, Anurag <anurag.mandal@intel.com>
>> Sent: 03 August 2026 15:00
>> To: dev@dpdk.org
>> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Shetty, Praveen
>> <praveen.shetty@intel.com>; Mandal, Anurag <anurag.mandal@intel.com>
>> Subject: [PATCH v2] net/cpfl: add timesync support
>>
>> The cpfl PMD advertises RTE_ETH_RX_OFFLOAD_TIMESTAMP, so received
>> packets carry a 32-bit hardware timestamp that the common idpf Rx path
>> extends to 64-bit nanoseconds using the device PTP clock (PHC).
>> However, it never initialised the PHC, so the timestamp conversion had no
>> reference time.
>> Applications had no way to enable timestamping or to read the current device
>> clock to correlate the mbuf timestamps.
>>
>> This patch adds PTP support by reusing the idpf common PTP helpers:
>>
>> - timesync_enable: allocate and initialise the adapter PTP state,
>>    query the PTP capabilities, program the base increment value
>>    and set the device clock to the current system time.
>>    The PTP state is shared by all vports of an adapter, so it
>>    is initialised only once.
>>
>> - timesync_read_time: return the current device clock as a timespec.
>>
>> - timesync_disable: release the PTP state.
>>
>> Once timesync is enabled, the common Rx path resolves the cached PHC time,
>> so the mbuf Rx timestamp dynfield reports valid nanosecond values and
>> applications can read the device clock with rte_eth_timesync_read_time().
>>
>> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
>> ---
>> V2: Removed read_clock support
>>
>>   drivers/net/intel/cpfl/cpfl_ethdev.c | 107 +++++++++++++++++++++++++++
>>   drivers/net/intel/cpfl/cpfl_ethdev.h |   1 +
>>   drivers/net/intel/idpf/idpf_ptp.c    |   5 ++
>>   drivers/net/intel/idpf/idpf_ptp.h    |   4 +
>>   4 files changed, 117 insertions(+)
>>
>> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c
>> b/drivers/net/intel/cpfl/cpfl_ethdev.c
>> index 4315adb68c..e4dabd8043 100644
>> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
>> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
>> @@ -1335,6 +1335,110 @@ cpfl_hairpin_unbind(struct rte_eth_dev *dev,
>> uint16_t rx_port)
>>   	return 0;
>>   }
>>
>> +static int
>> +cpfl_timesync_enable(struct rte_eth_dev *dev) {
>> +	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
>> +	struct idpf_vport *vport = &cpfl_vport->base;
>> +	struct idpf_adapter *adapter = vport->adapter;
>> +	struct timespec sys_ts;
>> +	uint64_t ns;
>> +	int ret;
>> +
>> +	if (dev->data->dev_started && !(dev->data-
>>> dev_conf.rxmode.offloads &
>> +	    RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
>> +		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
>> +		return -1;
>> +	}
>> +
>> +	/* PTP state is shared by all vports of the adapter. */
>> +	if (adapter->ptp != NULL)
>> +		return 0;
>> +
>> +	adapter->ptp = rte_zmalloc(NULL, sizeof(struct idpf_ptp), 0);
>> +	if (adapter->ptp == NULL) {
>> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for PTP");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = idpf_ptp_get_caps(adapter);
>> +	if (ret) {
>> +		PMD_DRV_LOG(ERR, "Failed to get PTP capabilities, err=%d",
>> ret);
>> +		goto fail_ptp;
>> +	}
>> +
>> +	/*
>> +	 * Write the default increment time value if the clock adjustments
>> +	 * are enabled.
>> +	 */
>> +	if (adapter->ptp->adj_dev_clk_time_access != IDPF_PTP_NONE) {
>> +		ret = idpf_ptp_adj_dev_clk_fine(adapter, adapter->ptp-
>>> base_incval);
>> +		if (ret) {
>> +			PMD_DRV_LOG(ERR, "PTP set incval failed, err=%d",
>> ret);
>> +			goto fail_ptp;
>> +		}
>> +	}
>> +
>> +	/* Do not initialize the PTP if the device clock time cannot be read. */
>> +	if (adapter->ptp->get_dev_clk_time_access == IDPF_PTP_NONE) {
>> +		PMD_DRV_LOG(ERR, "Getting device clock time is not
>> supported");
>> +		ret = -EIO;
>> +		goto fail_ptp;
>> +	}
>> +
>> +	/* Set the device clock time to system time. */
>> +	if (adapter->ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
>> +		clock_gettime(CLOCK_REALTIME, &sys_ts);
>> +		ns = rte_timespec_to_ns(&sys_ts);
>> +		ret = idpf_ptp_set_dev_clk_time(adapter, ns);
>> +		if (ret) {
>> +			PMD_DRV_LOG(ERR, "PTP set clock time failed,
>> err=%d", ret);
>> +			goto fail_ptp;
>> +		}
>> +	}
>> +
>> +	adapter->ptp->cmd.shtime_enable_mask =
>> PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
>> +	adapter->ptp->cmd.exec_cmd_mask =
>> PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
>> +
>> +	return 0;
>> +
>> +fail_ptp:
>> +	rte_free(adapter->ptp);
>> +	adapter->ptp = NULL;
>> +	return ret;
>> +}
>> +
>> +static int
>> +cpfl_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts) {
>> +	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
>> +	struct idpf_adapter *adapter = cpfl_vport->base.adapter;
>> +	uint64_t time;
>> +	int ret;
>> +
>> +	ret = idpf_ptp_read_src_clk_reg(adapter, &time);
>> +	if (ret)
>> +		PMD_DRV_LOG(ERR, "PTP read time failed, err %d", ret);
>> +	else
>> +		*ts = rte_ns_to_timespec(time);
>> +
>> +	return ret;
>> +}
>> +
>> +static int
>> +cpfl_timesync_disable(struct rte_eth_dev *dev) {
>> +	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
>> +	struct idpf_adapter *adapter = cpfl_vport->base.adapter;
>> +
>> +	if (adapter->ptp != NULL) {
>> +		rte_free(adapter->ptp);
>> +		adapter->ptp = NULL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct eth_dev_ops cpfl_eth_dev_ops = {
>>   	.dev_configure			= cpfl_dev_configure,
>>   	.dev_close			= cpfl_dev_close,
>> @@ -1368,6 +1472,9 @@ static const struct eth_dev_ops cpfl_eth_dev_ops =
>> {
>>   	.hairpin_get_peer_ports         = cpfl_hairpin_get_peer_ports,
>>   	.hairpin_bind                   = cpfl_hairpin_bind,
>>   	.hairpin_unbind                 = cpfl_hairpin_unbind,
>> +	.timesync_enable                = cpfl_timesync_enable,
>> +	.timesync_read_time             = cpfl_timesync_read_time,
>> +	.timesync_disable               = cpfl_timesync_disable,
>>   };
>>
>>   static int
>> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h
>> b/drivers/net/intel/cpfl/cpfl_ethdev.h
>> index d41aa93191..a9e532a46c 100644
>> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
>> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
>> @@ -16,6 +16,7 @@
>>
>>   #include <idpf_common_device.h>
>>   #include <idpf_common_virtchnl.h>
>> +#include <idpf_ptp.h>
>>   #include <base/idpf_prototype.h>
>>   #include <base/virtchnl2.h>
>>
>> diff --git a/drivers/net/intel/idpf/idpf_ptp.c
>> b/drivers/net/intel/idpf/idpf_ptp.c
>> index 5c3fcb90e4..47830de239 100644
>> --- a/drivers/net/intel/idpf/idpf_ptp.c
>> +++ b/drivers/net/intel/idpf/idpf_ptp.c
>> @@ -2,6 +2,7 @@
>>    * Copyright(c) 2025 Intel Corporation
>>    */
>>
>> +#include <eal_export.h>
>>   #include "idpf_ptp.h"
>>   #include "idpf_common_virtchnl.h"
>>   #include "base/virtchnl2.h"
>> @@ -38,6 +39,7 @@ idpf_ptp_get_features_access(const struct idpf_adapter
>> *adapter)
>>   		IDPF_PTP_ACCESS(adapter,
>> VIRTCHNL2_CAP_PTP_TX_TSTAMPS);  }
>>
>> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_get_caps)
>>   int
>>   idpf_ptp_get_caps(struct idpf_adapter *adapter)  { @@ -212,6 +214,7 @@
>> idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
>>   	return err;
>>   }
>>
>> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_set_dev_clk_time)
>>   int
>>   idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time)  {
>> @@ -256,6 +259,7 @@ idpf_ptp_adj_dev_clk_time(struct idpf_adapter
>> *adapter, int64_t delta)
>>   	return err;
>>   }
>>
>> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_adj_dev_clk_fine)
>>   int
>>   idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t incval)  {
>> @@ -487,6 +491,7 @@ idpf_ptp_read_src_clk_reg_mailbox(struct
>> idpf_adapter *adapter,
>>    *
>>    * Return: 0 on success, -errno otherwise.
>>    */
>> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_read_src_clk_reg)
>>   int
>>   idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t *src_clk)  {
>> diff --git a/drivers/net/intel/idpf/idpf_ptp.h
>> b/drivers/net/intel/idpf/idpf_ptp.h
>> index 0c901440fb..851cdad027 100644
>> --- a/drivers/net/intel/idpf/idpf_ptp.h
>> +++ b/drivers/net/intel/idpf/idpf_ptp.h
>> @@ -88,13 +88,17 @@ struct idpf_ptp_dev_timers {
>>   	uint64_t dev_clk_time_ns;
>>   };
>>
>> +__rte_internal
>>   int idpf_ptp_get_caps(struct idpf_adapter *adapter);
>> +__rte_internal
>>   int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t
>> *src_clk);  int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
>>   			     struct idpf_ptp_dev_timers *dev_clk_time);  int
>> idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
>>   			    struct idpf_ptp_dev_timers *cross_time);
>> +__rte_internal
>>   int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time);
>> +__rte_internal
>>   int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t incval);
>> int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta);
>> int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
>> --
>> 2.34.1
