Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA1CD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99ED340673;
	Thu,  4 Jun 2026 18:22:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B2CD240670
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780590126; x=1812126126;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yPLIMGg8CgBYOlC2pTfIjBAfV4A1/DkigrGlM2rC2v0=;
 b=bMDE0YW/PGarbVtytP5lV5t9ppQ9xT3C6ejaprl+k+EcJbp/Q5B0fJDC
 B2IMRcFD5JVKvh1Kx2rFOTh7vN0akn9uIegA//xv1wevg2LgyAUCuI0hm
 kKDDrO7ZjcR7xQqKkRC3PMy7Yk6mcpF2HxODsrad+KA6ZEznn+pCrO5Ll
 7jfbJKpGpaeFy1j2cbNXrc2QalP6vd5a9ZrCKWqFD7n/mOZqVPCvipm7s
 1wW2ev/YlOtW6enunI1CI8lkV8h+i1DTb5A3ISJQ2kjweXulJRtk4W4qC
 /UzcQYr1o1ScJIjxOJVFFNON+UzDpbfdgxLDVX4QBO4uhXqjZgk+ZPAJn Q==;
X-CSE-ConnectionGUID: pf0hSdZiQY+86RE56bzlcA==
X-CSE-MsgGUID: 3oojgmWjT8WRE98J9afjKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81417581"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="81417581"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:22:05 -0700
X-CSE-ConnectionGUID: y+zk4rbXRfu6weR6CVVonw==
X-CSE-MsgGUID: DNLAzBzkSRidhfgNetETgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="268262972"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:22:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:22:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 09:22:03 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 09:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdczUvBk5kZpTUsBFhtFbj61pgsLf4Lg2me1XdC9SYBP2sL94ktbVB8Y/97dTxHEP4pJX6EQy3Pwdj0fRjmBsNjuc1YtORlh1OzGWNn+lsG5jn7pHoClGT+hFX18YJ/ARjImrFHs620ZnhgnfTcD8XsJuHXlkboHiAaz1zJcnCHEJNLzjq+FRcCSWl9MsHFZz1XUEp3rPfFFVGAWc8igm4xtyZ/b7gyqQaal6QH9bUZ+QRQ/95lDSLPMapRkBcqPqHmYs0+Un6ZeuZpTZrdiorDcO3WkRonTz8tBa5mQ17tOOZ/6urzNJbqw0xqaziBhbYcx1MnT778pga7kTyQ8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYhO5GroiiyzuGutsmg8bQT+XY4c3cFuhGT0H0o0F2U=;
 b=AYinpkyuqoxZJwVO838StkID10/ajHO0LytmM+/cIQthpg59mN8i6Sl+8EYxD6MfvwSQiVUF2sL4nMRCAFftthr9q+XSgikLOBD8pI9HB2mT+aBEGh6dGi/yGYPOhAppCt32n7ybSvAkqmoUIWwX7C0n0G33yJnSpHdkV1EJFDNImKu9eBMpdBbFsFJOhBWgDV6JMEd9+X6CyIAY0DFtzO6qsqkuFR8kkJl/NdGXx4aCPB/AGU+YAv6g5eVgcj0LdZpIxzkqJFsHQkB9bLN8q8vgU6EAItr3L1M8R93FYRAI7kOofE7zMkKKqU8Wx58xGtkGZZbWmhktX1WKzmjxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 4 Jun 2026 16:22:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 16:22:01 +0000
Message-ID: <a4c6af09-1c51-4521-8570-b1a144e95cbb@intel.com>
Date: Thu, 4 Jun 2026 18:21:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] eal: fix async IPC callback not fired when no peers
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Jianfeng Tan <jianfeng.tan@intel.com>
References: <1ad014dd239fa1e8ea62aab7e56a7bf7264c04ff.1780068382.git.anatoly.burakov@intel.com>
 <n2qqs3VCRg2oTV_S-0kNSw@monjalon.net> <FGTuNPDMQtmtEID8twKsTA@monjalon.net>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <FGTuNPDMQtmtEID8twKsTA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0299.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 900e759e-673f-4ff6-4578-08dec255686d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|5023799004|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YhuxCa3qotV12rI+CacdvRpyXHUejoJfr6Gmb/pn+A/JRbKVCRzlgWGhKLl9el1WcVWFbvFERFocu30iS+rG8d0rCsFOJQ9uBYnXRa0MBbr0TKuh+1gWTf3HzjbQTVPDviYnubBNtPr9n8+HCJ8Q5w7QYVRG0A5u/6NJImOHvJFzFVqZBNBS4C4J+yvXn1rX9J14gsN2Y0ddBlsLKB/N8JOZMagaLBA6rmlQ4OY6B362a4Kv0vAU7qXE86scCCwkzFd9u+6SeSYJOfJ6ZToS6AKwzxVBLX/yXhpNQodjSSidY7An3mbixg5qc2A8YFbv5gsCXsfEyN2gVM8YQUsXHMk0NSZGekbPiPOrS5T0h0ju9jkGN2dcU0OWe7nSHZNAFc6TSaXiPHi5aAjdXVIXaJArp4JyAcGJQHDNhhjO6uM8kkzVlU2ScJ46Cjc9GeKmZR5JP89A4m811pO5gf2aG99g1c/akNep0dz3nESyXLFT+N3dIN3xATnjxUgUHkHsr2QyR5QmEu0ag5AeA2TO+53XLGzHXScW8RWM0E3WqFxiAEA/57q+wigD+l4quvXLlDCa9ToElizr1cvx/tIkO/vqApCdqZ+zJ7iBHPtmDRcYSRMtQFIV1gh8c3zShBC9/VVsiQBDVQXPg1gisMmetup+VJ77awzmVkLEyl4kEjjowWGKpQwl4MlNvTEFM6sg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(5023799004)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RIcVRUdkp6YWZVTU5lU05NN1Z2UXdUdE81bzk3ejY3bHJaaW1xSitDWHIx?=
 =?utf-8?B?bXRKTGR2RG1WQWh2enRqOG5qWmowcWRDaXZPREp2bS96Wjd3ZjY0KzZseDYz?=
 =?utf-8?B?V21MbnpWV1VVUzQyU1Y1dkJKaE9KbC9vSHI2c2M4ZjZkTVAyTTh0M0d5dVdo?=
 =?utf-8?B?dmkrSkwyT01iUTcrRExXQUZ2VTNjWTJKMTJpb2VwaGpDL1ZyaVRpVXlJS3pn?=
 =?utf-8?B?S3ZmOVJ2Z2psSFZIb3BwZTdRcUIzdTY5QTVuaEppYkZHQ1NwbDk1ZE03RXZ3?=
 =?utf-8?B?NjFLTEI1Tmp0NVFNZnV3STh4UjZvWHh1eVd1UGNETFkxQndjNmlYUVZJV0N4?=
 =?utf-8?B?ckhCZkduUEhSQWhnM1IycG1xZEhVZENzTEJxcWh5dnVaZkpDTDFTUHZ2VU9V?=
 =?utf-8?B?SGxDeVVZUnJDV1N0b3JGdWVucHJvdjJleHNBM0xnNmcrSWE1emZFWlFwYWhM?=
 =?utf-8?B?OEJ5alpLdmk2NUZnNFIrLzBCQUFSQXpPZ2xWZk9uTGZsbnlISWtpbGFydlR5?=
 =?utf-8?B?Q0dRVWw1emRWbkNoY0NxakJSV2VoTE0xam1WVXNIdmVLSnpUcUJQM0ZmdkE4?=
 =?utf-8?B?ek9IUk9tQVhYcW9mUmNXdHR3SmhjczZuSG9FeExobGxpVko1Z2ZiUmthMGpC?=
 =?utf-8?B?amZCT3pBZENXdmdUWFV3MTVVM3FJU2JFNWVtTWcybW9XQ1plcHB3d1VqeCtJ?=
 =?utf-8?B?cjB1ZC9LdjhUNCs4VWFVNW1DR2xEMXhTWXpyK2crWkFwMm1zL1g4Um5EaXpq?=
 =?utf-8?B?ZXBwb2tYUXlhcHJDTWxiTkJQYm1aRlUvYnBHUXZDbnh3K1IrTUtpMW90Zk85?=
 =?utf-8?B?YXlTdEtpSDhHNUJMdlN6akQxTkg2bHd2ektMQ1Z0ZHVIZHg1QVA2WFBlWlFQ?=
 =?utf-8?B?aTdoUUlGTkVsZzErVTVmRGxvZXJuTlp1M0dBbGVmNDA4VXh1NFpXQkU3LzFS?=
 =?utf-8?B?NlNkRm1BSFhnb1VtZ1Ywa3BIeFpzQ0V0TU5xWE9zd3A4Y3RIV3V6OTNzYzBV?=
 =?utf-8?B?VUdXS3NjZU9Yd05yTGZzTWh0NlUyelhXdTV4RjVmN1ZlcHBSemtkaU9XSjVT?=
 =?utf-8?B?MnU2M0dhQ3ZaeEErTmlRSnlKckVsNnJVd085WGM0MDZ6TzRla1VvRmx3aGNi?=
 =?utf-8?B?cFRrZmxCYjFVemZTenM5NkNZL0xYbVU5Qis1YzZCUkpmWE1Qblo1VDVpbEFN?=
 =?utf-8?B?T3Z6MkFPQjg4cSszcjFKTEZSbmxVQmlXM3RwbVNNYm8rcDlpbHNoVHRyRytL?=
 =?utf-8?B?bXJlU3JTalZRNmg0ckJlcmFucUhpaVREM1N4VjhlS2JwWGZxV0Rvdi9WTUhJ?=
 =?utf-8?B?Tm1JemtKSnJua3VKS3VFZnVUUjRDcDl2UEdPc1ZrOGs3SzI4UXd4Z1dxaTlp?=
 =?utf-8?B?S3lmV3BoQkZTR0lLT2tRaHpPUXBWMEgyWnZ0MHdEem42Yjk2aENvdWFybE1B?=
 =?utf-8?B?L2s4cWMybCt6ZEtvNlBnOHFRaStZUkhBYTMrcXJPbDhxZUI4Tm1GWTBEZXVP?=
 =?utf-8?B?dTYydG9SWkZIdlNadjFFZ1Q5Qm90YlBrdWVkOWtyd3AwRzdIL0toMTZQQmNx?=
 =?utf-8?B?bmQzbnUxUTk1OEFhQ2NjQ3laK1VEenZZR2pyeDBJMXg4MFp2ei9KZ2VNOHhW?=
 =?utf-8?B?c0VoOHBVWmMwL2dXUmZERmN6ck9JTVN4bGFVRkhQRWhsVVRmVWE0R1cvcDNz?=
 =?utf-8?B?NGlDWFRxa0JFTS9kQ21uUlhiS3M3cUJDNmlyK1NoaXVnSElsTDA0UzAyWmx3?=
 =?utf-8?B?eCtnWm9sb0NKZWhTQUZJOXdRQ2QvY3d5b1JWdXVjUmh3SkJmYms0eGphZS9I?=
 =?utf-8?B?YTV0TTMzQ3RyaXRQdVFGdktzd3BXeks4dHRUUW5DVHRjY0w5RnlEOHZDaUJO?=
 =?utf-8?B?UmtPVndyYXpIbjFyMklQaVlWLzNXcEdnZTRsNnlDbTZSNEUyMXNDSVRab2hj?=
 =?utf-8?B?eTN4anVHbjJiZ2prVjFVUlJaV0ZrUlZaYTJTSzFhRk1TdDBoY3pNUTBaZDhG?=
 =?utf-8?B?VG96dHlyUGRyZWRRaUtXUUg2cE9aZjgxUGVZRVM5VTk2RnRheEI2VmlVN0ti?=
 =?utf-8?B?MWd5YjhBYnR4WTZ4TTAwdjBMQ2hrZVJUcFpiYzNjQVo5TTZ6TGtGT0xwSmJV?=
 =?utf-8?B?U2JyR1k5VWRmZ2tjTjRPRzBGT09qTk1Lc1JhSlRIc0VPbnRzZy9EakJlMjVD?=
 =?utf-8?B?aUZSRVhZSWdwdlZubm1RdTFzK2l6UTRJNGpOUzYvN293S3V1Q0UyZEpyZlJ6?=
 =?utf-8?B?V0JsMU1BUUh5V09sZTY0Tjc4SW1DbjdpcTRhSHRUUEZBY0FIMkpYQzV5MGVj?=
 =?utf-8?B?cXdheDgxamdmcDV6ZEFjLzBCYlN1YkpJbTFTVy9VUGd2bUg4SndXVWZ3UUNu?=
 =?utf-8?Q?rTwoFORDGjkHnvZo=3D?=
X-Exchange-RoutingPolicyChecked: RsurzVfPGysuwfLpr1OQsrdyBBH3zfJvGYJCPeJhybOi8T1sLQVkPohJjrco9jO0P02VR0SI36KZENvJ3VbLyel/by6Hb70DIvgqubwuFAwgB4tDxF/oKEYo3lUQYab1AcvZkiZd2ml7JWo3l9SEt/OwaciVzM/EEh9IGuLaT0yn/0BT/NserigApj+guBF+VF/6AyuxaZTYo6LargRbrIRaCSiu9x0SDTmQI8F+UNRc9DTuatwRUNdm++hHvsw70M9EyEq7nL20i49Qy4fLxU0PR2RIj0qEH32Sj575IR+c17j6MAY+fLt5EELXL5y5Y5uTfMj2OBn7q75HHQo+Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 900e759e-673f-4ff6-4578-08dec255686d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 16:22:01.6597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7ntDeu6ZPn/qSFvAUzP9iJ/mp3VDxnQOgFruGk0eQ2UzcSC+9jFH8vV1u2IDtG1z+08SOyVrsMXUMCrONjqQn1NaT5cMTO+dejv98IMCu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
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

On 6/1/2026 2:40 PM, Thomas Monjalon wrote:
> 01/06/2026 14:21, Thomas Monjalon:
>> 29/05/2026 17:26, Anatoly Burakov:
>>> Currently, when rte_mp_request_async() is called and no peer processes
>>> are connected (nb_sent == 0), the user callback is never invoked.
>>>
>>> The original implementation used a dedicated background thread and
>>> pthread_cond_signal() to wake it after queuing the dummy request. When
>>> that thread was replaced with per-message alarms, no alarm was set for
>>> the dummy request, silently breaking the nb_sent == 0 path.
>>>
>>> This was not noticed because async requests are used while handling
>>> secondary process requests, where peers are typically already present.
>>>
>>> Fix it by setting a 1us alarm on the dummy request, so the callback path
>>> immediately triggers and processes it.
>>>
>>> Fixes: daf9bfca717e ("ipc: remove thread for async requests")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>> ---
>>>   lib/eal/common/eal_common_proc.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
>>> index 799c6e81b0..0ec79336a5 100644
>>> --- a/lib/eal/common/eal_common_proc.c
>>> +++ b/lib/eal/common/eal_common_proc.c
>>> @@ -1187,11 +1187,15 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
>>>   	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
>>>   		ret = mp_request_async(eal_mp_socket_path(), copy, param, ts);
>>>   
>>> -		/* if we didn't send anything, put dummy request on the queue */
>>> +		/* if we didn't send anything, put dummy request on the queue
>>> +		 * and set a minimum-delay alarm so the callback fires immediately.
>>> +		 */
>>>   		if (ret == 0 && reply->nb_sent == 0) {
>>>   			TAILQ_INSERT_TAIL(&pending_requests.requests, dummy,
>>>   					next);
>>>   			dummy_used = true;
>>> +			if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0)
>>> +				EAL_LOG(ERR, "Fail to set alarm for dummy request");
>>
>> Shouldn't we return an error?
> 
> AI suggests this:
> 
>        if (rte_eal_alarm_set(1, async_reply_handle,
>                (void *)(uintptr_t)dummy->id) < 0) {
>            EAL_LOG(ERR, "Fail to set alarm for dummy request");
>            TAILQ_REMOVE(&pending_requests.requests, dummy, next);
>            dummy_used = false;
>            ret = -1;
>        }
> 
Dummy id is not added till later in the series, but I'll integrate this 
otherwise.

-- 
Thanks,
Anatoly
