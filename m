Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4FACCF2DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:25:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3A034060B;
	Mon, 19 Oct 2026 11:25:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 52D1140269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 11:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792401915; x=1823937915;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6aQwpJBfe5FqHoxgbzGbv4WdctqjT6vDxtLRhLzAchU=;
 b=njjOkpAYoG53fuBB8ycJDM67OYo9Xqe4nE3uWCF0mQgUJm3fSVuJCutL
 arhXaef9Qvg7uN9fnpHTlgFCOxXSMAbF0qAv0+QZNvUrqdnkHs812mDCD
 aG7ZVfIKQ7Xan+/Lgy1z8gTB6xYAXO0nZtcfOWvp1pfIGr1jood7nX4CR
 k8YUo5ujxHEqOiYodrTZVGT1wyzEal3ZGm17qMZ5A4w1k2LLM0RwiTYuG
 4THJoxFZZErgrxXbtu7NKlRqVyDeBv1s6Wcq7TfrcBQMHF6sq1t0IYw0+
 enZYWA1RdoMJpxWYnskV139t5r9pKroe2EgvL3rIVaQN5sneqr9UjGNg6 A==;
X-CSE-ConnectionGUID: WSo2UwMSRl2pIf7wZkJj7A==
X-CSE-MsgGUID: uTwzRXyTT7OuNzBLOnzcaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1095421"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1095421"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:25:14 -0700
X-CSE-ConnectionGUID: UbUPdPcnRkK3xVhXocmOQA==
X-CSE-MsgGUID: 1m1QXcyTT1GUKB4ZV3dDXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2851071"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 02:25:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 02:25:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 02:25:12 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 02:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nciEchN5fhHjGCQO8mGYTf7TkvK46RB9tmkrPvnbdKYpnFrmuxSo8G7HGInrrdg3bbzateHtH/imkhYQnLljy9Lx27WoKZT58XM3uDQDyrzrm7PKRYT4xutjP3grZ2Gf0jZVUVt9rSJ5jniDjVzcUOkf8pRyjYIEn5wK8b8CMB8u9vzbMnk5WVdArKo1+xNgl5+a0DPx8jZsGcc8UhT9vTUpX7rOZ2ffVg+cvHSTI1foWvEbZk69PUIyumxZI56kz9tqs56MtP2ErMaDUhYsLPR91INeetD8xKtka7A+0O5I40nLf/VeirgRJTCwvTw+W8FSrwbzBZVVHkCnjJMLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/3A8siydIlpJjblASLqtqZkGkmaoa6KBR+tf35Pb2c=;
 b=ihCuTSE2R3TJJ/e87KIs5RHkGlblmMYnyj3PfEb936YCH4/c4BKLPZnpGcVyitsbOZUEerg7b2ulidHvkbHecgMl3FXZPjZvaHabx8q4DnwS1CtE+5C1RowbMWUuiy/QZXhNRDWKWHp+p3hYHKZNplKeOtO95IqAsI/8SHgSQm1KpSgplQ2tA6byczYxxPWu2a7msdY+YN/MZ74VGwLUi9NJRVZymjmJP2Dqa7S9FxIRPDLfgOf/W36W6cBn7DCLG/L5g5BLv3hfCL08eWxH6uI8cAVBmtwz5NqvBeakVOS54uFkr2Zx9KGfyyAl4aZQketM3HjddXxXMdVFnqC0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:25:09 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:25:09 +0000
Message-ID: <9c02cf79-6902-429e-a67d-e53ae203bb49@intel.com>
Date: Mon, 19 Oct 2026 10:25:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <Fb4CjKFWRziKn9hdw7IRLA@monjalon.net>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <Fb4CjKFWRziKn9hdw7IRLA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SJ0PR11MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8d654a-5465-4468-6b64-08df2dc2de84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V7xkQAhd0kB4LdJhpr1NwNnLxxzi1nsRl+KlAhoOIPyBl2iON2bJKCVPKJ7Dvt4SzG2ajph6u44e31dJ4aakj1QDSW3QEDYhRB6P+4FRBkULkzCpsGICtGCfjsr/mYdDF1VBJZlBD7rMIqrZVurQD8JbywLPu8dRbUZB1b+wTTfdYoI3zL3BRY8Ip6dOrykSfAY3VsAao6IbNQBrcZdNje3E7xuId0r8nzExLSM++AZnRYAz+N+L5PTJg69vt8UkJLOcimU2rSUt84qE9PW4gMApNBhq8MehSSLrQUECnpl2HUoiLVfevww7k8IvyPv3m66T+8loDSIOXfi4RmlwsLhc8lV1SaSmfSMossJo9t4QiJjER3Kpsx1hjJa3tmprXTB7SG5Ldd7L4CmN8volZKRhDVHZ8OUD2mDrPrPlxlFDz58aCwpgacFwV+L+g/SpK7sseznAqgRj+eVuw8Tc0e5o2zzPdtGldMTeVjK4Vr05H/yuA0ZvJhUFzM4EiCm1N8riMKlQKi87FTx1As8xrnd2J7JVtGXtJSRf8oTZheD+9JAxZlt9ZyEqdamsmKkeYXlKFz2PfOeNxI7sVVy75/aJchE/aDXKnxrPncwwBXvt3KoqtC/DEFbUvGMV46f0R4xNN1u8P9axQ6kBGKgpVIjCFe37KwAlv4XPInwufFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0RuV0JYMEVoQUYxd0ZaeTJSWW9wQ0NKQ2hVYytHQTZuSWlMMGV0U2g4MDVa?=
 =?utf-8?B?ZERxK2VTeUVjWDBjL2gzUmtRYVEvUEt6VW9mQW9FUldxMk1pcElheUZhVDhr?=
 =?utf-8?B?RHZKS3FoS0kxRm5YaXNjU1plT0dwc2R3bXV4TWl4ZGlnU25vYS9jak5ybFdD?=
 =?utf-8?B?a21Ga3lJSytqZ0FUTkpwNWMwZ3E1c0hyN1FYbThmN0FnN3FRKzdzUXJTWEp0?=
 =?utf-8?B?MElHcjBkREIzZTJVckJpZGhqWjIzTzhTOXRBZ2Z4NWtsUFY1TlBPUmJ0T0Fv?=
 =?utf-8?B?d0RWT05EQ0tzTU9DSTVsQjF0dmh4TldzQVBNM0kzNlpDZXUzN0ZJaG5vYS9v?=
 =?utf-8?B?Mit3UmpETm9OUmRtSUpwU0xlV1dVaVVCbStZZVpoTG01NkFLb2k3N2NRRm5s?=
 =?utf-8?B?YUtxOS81WGREYjdKemhFdkRnQzVhTXVhcUg2TXBhVWtRdENlRktnNEtKMno3?=
 =?utf-8?B?dko2Sm5ZTUlTM2JTaEtYWC83cmtId1p3NmI3b3JxUTA1dDFYYkwrSHBLaFFX?=
 =?utf-8?B?L0c4cnVoZDdLNDBSRzlVV1JZQlRQRk1XQ0JUNW04OWU5NlFnWUluYURlQ1Fv?=
 =?utf-8?B?Vnh4TVBFK09wVHQvM2VHbURpM1A3RjdxS0tlZUpGR1ovNCt4em0xcnVCWFZN?=
 =?utf-8?B?RitPUzBsZmFrc2krUmxzUUNiaDlYZkJycWFlOWJtSmEzeUU1T2NwNmo2c1JP?=
 =?utf-8?B?OG1LVEd0ZjEwYzlaN0hsZ0ZsRXVOR0d6ZmRsU2UwemYra2NHT3pCTUIvRGpH?=
 =?utf-8?B?ZVV4VDFmUGwzQmc4WmVIcWtkOFlKVmg4WUtYRzRsazhnY2pCUHBZOVd5Lytr?=
 =?utf-8?B?bUo5WWJCY3J4VTE5RFY1emRkSjBhc0RwT3ozM1dpZGlnc2ZhK0hNSElBN2lP?=
 =?utf-8?B?SWdHeXhaNFNNS2dHMTF5L1RtVFN5MGE4Zm0xelB0TlREUnBRTFdPLzNPZitB?=
 =?utf-8?B?M29GSG5uV3lweTlJcWFaNUtjRFNteWU5TG9xYS83S1l5MGFBd1E2K3ZJZFY3?=
 =?utf-8?B?dWx1d1ZQWVk0L2cxd2dVQjlhbTE5dTJ5b2lEL1VaSzd6U2czaFU2dzhEaGtM?=
 =?utf-8?B?Vzk2cENqc2kwMHdKMXZjcGpmbWczK3Vnb3h5NFQrVDNpYURzcDhXaUpNcGZI?=
 =?utf-8?B?RVVEMlZMODlNV1Q5ZHBGV2ovWTFzTXNUcDNlMXoveUlaNU10akpaVXg4WGVp?=
 =?utf-8?B?NkZabFN5SnhkcS9Lczd3U1ppUFFnRjl2YlNvb3NUSi9ybmlBVHNPVlpiVGh6?=
 =?utf-8?B?WXlwMTY3MnRhMXBidVR3dUcrb3p0NHpiRjRwVEtrTUgrR3FGU1JhUzQ3bVhu?=
 =?utf-8?B?eXNTNHNXSXp2ek0zbkJsOWZud2ZZZTVrYWcwRVRwOEpMRXVoUFFrbk55STlK?=
 =?utf-8?B?YWNTWVlrdWZaNEhUMDFyRCs0em9jSGhtN1JDSFo1RjgwVFJvUWU2QTFPRS8y?=
 =?utf-8?B?a3VVbmxjNURLNDJ5NFRQbWlvakQvWTRBMGhyWldVSklBdllMU0Zxc2pNUUZ1?=
 =?utf-8?B?TmJ3Zm1kcnFFODZ6d2laMTlGNnpoUlloY1laVWxGNnF3Tm9CWDR0TVJXVEhF?=
 =?utf-8?B?YnlxSkhrMjFTSHFFTzNRSUJwaXR0K09MZnRMT1k3WGZBVFJSYjJzUW80allY?=
 =?utf-8?B?MFA3c1ZseGlNdlJEYmd4MVFtaUV3U2JSTlMxa1FHOTQ4b1V1QXI2VG01aWYv?=
 =?utf-8?B?a0FzTEhRSmRvdVNnWmY0Y1d1cFNmMFc3ZXozeC9aQnBaemR2a0IzMkZVaVdT?=
 =?utf-8?B?RWNXZE9kWDB3N04xODlNR2hRRTZTQ0ZPbXgxVStET2xNSndZaUNFemlVZGx1?=
 =?utf-8?B?NlB1Z0d2YWduVDRrcElnQTB2d1RsSHVad0xUWFhpbytxeDU4TllYU1BDVC9I?=
 =?utf-8?B?THd4N25WTVhBNk96Z3V0NDJGMzJ6VU5ndmc2K3hBaXZiQXFMQ0pCempMdzVa?=
 =?utf-8?B?bklCWWlORS9ZY1llZzV5RWkwdWFjVkVrRkF4LzM3enRwRU5XQnZUaDBRMW9S?=
 =?utf-8?B?dC9WNThsV3hwZDdmU2pjK2M1Y3A1ZEZWSGlqbVVvNVlpcG03Y3llS0lSN1FZ?=
 =?utf-8?B?UnJ3YzBxdm83Q3N4OW5mWDQrbEU4ZEpqemtzRlNKekdzTFVXUXBiRGFaaDg4?=
 =?utf-8?B?QXZPNG05K0Fsa0ptN0ppZmxjbVFYZURzeUxEWVlOL2tnWlh0eEhlbURyaWRE?=
 =?utf-8?B?ZGZETDRBUEdFbmt3bFlRVVhiQXo1VGhYR3ZTSDdUTGNzZ0ZPeG9NeWRmY283?=
 =?utf-8?B?bzlWZ0o1YkNjUjd5UUpPSDR4eTVaUFF0ZTZYOUFCUk1MVUVsbUtuTzdqNUN0?=
 =?utf-8?B?a1g2SjV5LzlZRDNvQnBxR2hHcitGYXFXZFRYZzd6VHNXMGRydm1pdz09?=
X-Exchange-RoutingPolicyChecked: CHvEoxkldlNy5ZDrqBZVPa0eogWUxhK8ZkJMpVXprgoS38CYgH8D49mGQx6NZd2EUdnTroSqebhxeGNbTF7B1yixNKF7nszzAsMFBvWUyrwA837F0Q2SP7Sj3NzSTyPiGcZSXEJ9h7Bdy10yvspnASSaOYaQcr9jh0qgadC+bi99Sup9tI5XVmiXbPrKBzfCdD8iXRggUxdGC3WuHK4XFQtvT6KNndXpUQqUomOfq6WmmE6a39eSKfhslyyaBsPAMUyzjxOCkhWoxZaYKsxNXbr+GAHnNEfqtuCHRKLJNzqPyU+RwnDRX2XdvLE0V3F39gPoi2PFvOWCx8X4Hf3OLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8d654a-5465-4468-6b64-08df2dc2de84
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 09:25:09.2722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w622oTFG+4Gt7GVrnc0o9/aUB+EJEsyBDzZDjish2mp3rGxM8hhzLFAMhYnz52Fj116gAs1mVviDUkQgL3c/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
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


On 13-Oct-26 8:41 PM, Thomas Monjalon wrote:
> 12/10/2026 15:58, Radu Nicolau:
>> Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
>> codenamed Túnel Pablo
>> https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0
>>
>> This patchset adds support for the new library version and support
>> for the new algorithms included in this release.
>>
>> Series-acked-by: Kai Ji <kai.ji@intel.com>
>>
>> Radu Nicolau (4):
>>    crypto/ipsec_mb: add support for IPsecMB 3.0
>>    crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
>>    crypto/ipsec_mb: add support for ML-KEM and ML-DSA
>>    test/crypto: add asym test suite for AESNI_MB
> Sorry I will give a defensive NACK
> because you never fixed the problem with the Arm fork.
> The crypto branch is already not compiling on Arm
> because of your recent change for IPsec MB 2.0.
Hi Thomas, with the latest changes and removal of minimum required 
version these patches are now compiling on Arm, are we ok to withdraw 
the NACK?
