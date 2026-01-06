Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD5FCDC19B
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 13:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5722402DC;
	Tue,  6 Jan 2026 14:14:44 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by mails.dpdk.org (Postfix) with ESMTP id 896F7400EF;
 Tue,  6 Jan 2026 14:14:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZHdIreIhU0LFGQYdbmv/Cuy6nxgFj4mpqxV3f1KtuRbON9B3OrVclqPKKV6FJdZqioRrtPOvmLpNWGJjDzql1DOs4Z98kFi7I0GruAGwC7iWoOheSruuh1+3UZhi1GmAF7+AoCHUEXxO1Droh55n6cCnpbqsbZUfQCJxp/s1UpLqUqXJnJcco+GQYPwSx0ieAyX2mwUmfaTbYyaXZWimFV3W8t66uCGklZn52PDIKupnnVyhrkhn1pYA+hWienlFsH7Y/SA9cxDlSx2+SyUK+VDpG7ymFVkQsnoG78sokkti2HTZhjE6rbGmS0HBu16xDWtLHBjdupQoKk7NzqTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jc2QIvQxSJN3fb2DCCJm45A9vZKr4AV8JsSgru2S1o=;
 b=x0gqMLmuasZdvAKgvTh69ycqr7N+C5lPCfNmzlf+o7p7t81tjS1r8xZuVqHEqBeMB1MoCCu/10WsBfcFXFFsERzNM74DblIQsGF+Uyv1oJcNVJuHi50rYoK5SZ13/gX3kjC223kc0a3BGfEkhJ1E6QuNiox/tE0lRSbI0HPOJWYqg/zmE6+tiK/r1yyanxeY3ikJyBFSxolIxx8Lpfe4IxUAnS37gJ/v3AUtKDre5d8bpo6XPeFUWQCxaF+iBeemN+9QwP4iP4eyeNoFueKxbsRM0bXiqCL6olRLz/UZqcJw7lYaek+TeysxjW6p/o/LfIh213lVYyQG2AyfTyeS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jc2QIvQxSJN3fb2DCCJm45A9vZKr4AV8JsSgru2S1o=;
 b=W9twt7PKCgZsk8aUyx31Zf2sWMCGvhTF7v6/kPsNPdeW5Y/h742WHddpvTFB9sFDBRI6ThdInlbFuUB8fIcKf86wpWzw3a32Dny4ZUyKM3WEARWdWrmzhWN3oJtzSZuk6htMkByh2WYp0+ikFnwYYQ62vmoyLlfLahBQFzYlBZwj5vq2E+73UfDKsF0YrX1R/4UZ/av+k4fN7fgm4uvnBdkwJueP0afRoWUgoNZf/KZfo2dd3AzjL+w60+vMpRYtgwWJyoceOGRAQ6ONGadj6R0HdLl+q23RrmcVSiIU5kSNqZZ+YZ4Xh3hTNWsMdsfuiKPPpkzbDrlseQGDlLUz2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 13:14:40 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::f900:8332:ba16:af99]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::f900:8332:ba16:af99%3]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 13:14:40 +0000
Message-ID: <3270422c-4e68-4dec-9fb9-bccaa7e9ce48@nvidia.com>
Date: Tue, 6 Jan 2026 15:14:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix the counters resource leak
To: Bing Zhao <bingz@nvidia.com>, viacheslavo@nvidia.com, dev@dpdk.org
Cc: orika@nvidia.com, dsosnowski@nvidia.com, suanmingm@nvidia.com,
 matan@nvidia.com, thomas@monjalon.net, shperetz@nvidia.com, stable@dpdk.org
References: <20260105070558.71556-1-bingz@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260105070558.71556-1-bingz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: eaee993d-adc5-42d1-2e32-08de4d258c8f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clVvUmVoNXZEUFlPd3Q2MUJpeHVsQWJ6UzNJdFJGOThwSk9UNzZ2WjBQQktO?=
 =?utf-8?B?WWRuUHlnbFRENWowM0Ryb2cvME1SQnJYb3Z1dkZkaXVpdzc1MVBwOFloQXla?=
 =?utf-8?B?SVByUjNjUGV4dzNLdUZQd0xycHJENkE5Rnh2UGU3UkludlQyNmZJeG5YbzVz?=
 =?utf-8?B?L3BuWUhIYVduelB2eFFHZmFmZjNIb3htV0t0ZTgxa09EQ1A1RWxwcncxYk0w?=
 =?utf-8?B?bkxSRWVyZ3o1OGpEcFJDbmZmMHRnemR4UkwzU1A1VkRHakh3Y0VUMXQ5Zmo5?=
 =?utf-8?B?dGtabXROcXBFZXVmOE85Z3hDMGpwSElkd3hWazRBRzZpbXlLa1RMMFhZMVlL?=
 =?utf-8?B?R25OczJydlI2c0U3MHF5bzBHYzBVUXhTR0t1Q3NoRzNMdWxydVY4azUrWWR6?=
 =?utf-8?B?dGJTSEMyanBVb2JNeGlTelVxNFF2d1FnbG9JckxGTjlpWGNuZm5BM01mTTZT?=
 =?utf-8?B?cEFxMk9BMXl0V3BpVnhFVzRhOTZrdEYvcVVnWVVRbFVRY3hIQXJISENWUko2?=
 =?utf-8?B?WWVvckdoUXI3a25zWE95NEl1Y3RmenB5bE9qV0pXUHJUVzQxK1QwcXJNNzht?=
 =?utf-8?B?MjRGRmRzb01tNjhSczVGYmovTlNlaEFCZEcwWlJOWFV3VjVabUJaNzNBVU02?=
 =?utf-8?B?aXlySHl4NjRtWG5UQ1BmSjFFMXp0d2FKdHNwbVpSUGpNWjhiOEczZFRhU3Vh?=
 =?utf-8?B?WUd1eFF2N2o4WkFOb1ZDcXY5dkNDRDNURS9tZHZNa3FQdTM1azE4ZFhSK0dp?=
 =?utf-8?B?UWJabUZMYVJzVFpuMk9pMkt4STZlWmpZZDh4d3pVSWRnSTJZdnVYRGZ2S0xP?=
 =?utf-8?B?elFlK1h6LzZPSEhvSWsvbnZCOHBrbTlPNXhTZXFOVlFzZHNTYzZJdDRqaUhI?=
 =?utf-8?B?U3FvWnY3SHZoL2xGOGhmNGZHMEV5bVBtL3pCUkFCa21ZWXd4VU1mS3ZjVG9m?=
 =?utf-8?B?cmhMb1JTdG5yZmloSUo3YUo2c0lHTHFJSysxbjQ5WXBxVDdKVDBWUktkL01S?=
 =?utf-8?B?bktOSm9HWkloZms5YXNxclVQMEdpbENCZ1UwQkhLeC9VVlp3UW4xQ2E2NzJL?=
 =?utf-8?B?bk9MZytxMldOTTQ1MmlGVXJKK0ZnYkl4d2pTdVh1N2M3QzJ3Q2FpQzBkZE0r?=
 =?utf-8?B?VHlrU1g2UlZrR3dNVytEbGR1c0J6T0l0YWlrVklreDE3Z3QwVHFQT0syMWpH?=
 =?utf-8?B?R0k0c0xJc3ByR20rL2dXSmdhdmdiWkdUUk82K1VCcWRkaVpVRUI2VUJ1OU5O?=
 =?utf-8?B?T2x3bkdreGQzUWVWU1llUytkVUpZRlk1Q1NpYitJRUFZS2V4Mm5EQWs5NjlF?=
 =?utf-8?B?RlE5cWRRY3VzelEzRytlN2FMRGg5TzRuNm1PMk1WMTkva1kya295OWdwZVFK?=
 =?utf-8?B?WldDUGNGR2huOEQ0VDdYSzAvZmRuVXRZZXA1RXYrYWN4V2I5RGVnTjNJQWsz?=
 =?utf-8?B?VXBwcWdzMllJRnZ2d3YrQ3hZdjV2Z1VSbDVRYnhiUWRYK3cvR2xwWEhDa2x6?=
 =?utf-8?B?aVFlb0hQdWo3cm9HYm5yZXFmTWVhWDRranBiNVNMRVZWR3VsbkNhbmlmS1ky?=
 =?utf-8?B?NGduUUJpYkp0QnNFSDRJWGRXQVdERTBORndMWEJhMDBYTGdkbEduU2Zkb01h?=
 =?utf-8?B?NTFCckVEaHpEVkVRdEkxN2lKbTlHRTQzb24yUjY3QmM5WFBVdXFUVHBwRmpI?=
 =?utf-8?B?bDR2YjFrOHJRYkxpTmpRQ09VNUpnaUVCaThGcklYSm9iQmVkMzBMc0Fiajhw?=
 =?utf-8?B?a2MxM09oYlVZL3hIVzFvcWQ2cnFWYmJDWGorR2dRU1ZKbUwxM05rclZuazd4?=
 =?utf-8?B?OFlKRytTMEs3aEs4bXRWeENOa1drRnA3cE4vM3dUbGJwT0tnZGZ0QThmRkZi?=
 =?utf-8?B?UEZDSU04Mkg4RWx4YTJqTzBCSHo2c3ZYZWtBY0VvVDRtbDhlNzZhT0YyZTg3?=
 =?utf-8?Q?5UASBT51sxw2ze9xJ4yahN3DtonEcjIK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxVVjFZKzU4OXZpQ2Mvd1hkQ1M4alB4QTJzZnZVSUI1Nk1tZDVRakNrcm9F?=
 =?utf-8?B?R0RmbVpJcC9oeU9iMUhnRjZqejFpNmtWU3FLYjQzaHd3TVRiMHQ2ZHI5Mllu?=
 =?utf-8?B?RmVPQzRxaXNCcHZSQXp1aGw3RTlPT1FtTU11SndyR3U4RFRlb1FOekJtZHdi?=
 =?utf-8?B?U0dSK3lwYzUxWjVwY0M3ckFobVpXdjNOUVhoSWgvYWZIWEYwWkVkdG8wUStn?=
 =?utf-8?B?NGFLVXR4aStlcVBqL2F5czlvTm53dTZmc0dYZDRualpldDBEZllsQVpVeUd2?=
 =?utf-8?B?aFVvdUZ2K1cyc1hMdWZTRy9obHpNajZWQmo0MzU4MzQzY0RwNEowYWtBT0ov?=
 =?utf-8?B?djlDOXg2TnBoaVZSV1ZnREEvb1BSNlR2a0g0N2pqWGp3TVhsTGEzRzNpcnZX?=
 =?utf-8?B?UklvWm1ZTlJLdDNJdFVabDBkQVNKV01kV1FXUWt5STZDek5ZdGlmek1UeEll?=
 =?utf-8?B?RzNDNXBtQm9DT1FVazdERlVBK1pZRVYvdkJDcU9pRlV2aEoyMmZNQnBxNkg4?=
 =?utf-8?B?dDUvY2dXNE9BSnZ6ZVNHRkREUjN3R2dreEtoQUFCWnBhTW5FdTRUNHU5SWtR?=
 =?utf-8?B?U2xDY0NhYlpmY2pEcWlka3dpajBaMXV2RC9xcHV6d0dSdTBSNlBHTVZiTTFp?=
 =?utf-8?B?QUgra25rWEtacVlTVC8zL3UwOEJja0ZTS3lqMU1wdkpZejUyQ1JyT1UzeGl0?=
 =?utf-8?B?UGM1MzBmSkZxRmJQRjFFN2FRa0dIVmtYVHc1WXgzdHRIN2diYW40SFdUeUFY?=
 =?utf-8?B?NkUyM1ExVWdCZ0Q4K0FhVHdPSk1jMm1DUW5PZmIwZ2lKWGtZbkFwWUFXLzh2?=
 =?utf-8?B?dmkrZlhXMG5HMnBLcHQvOEExeElPY1ZVL0RZUkZCQUI2bFZvUi9uNkpCVWVl?=
 =?utf-8?B?V3E0akNDb3FrVVJmbW9hUUI0Y201ZDExa3VOSi9uUTh1L3hlZGdRUVdSekU0?=
 =?utf-8?B?bjR4WTk3VGJGV1laRkpnRUhPN21uV1ZjZTBXaE9IRmFZdTUrWjBlOFQraUlu?=
 =?utf-8?B?ckJlYWlmUnY0VG0rWmFYVWd4akh2ZUw3VnZqbU44anIwd2tUQjZSdlFENlcw?=
 =?utf-8?B?VDFGcUZMNFMrZlI4YjRPNFdSMHdHK0h0Z0EzWEpVK1ZaZUpoRHdKVnNRMXVP?=
 =?utf-8?B?bUE0cEtLQks4eDFkYWQyYUlFOGx4WTVEOXhYMEcrOWhQN0kyUzg0K0tZcThQ?=
 =?utf-8?B?dkFvWGg1Zm1odXAzRXdZdUpHTmV3QmtsbjlwSC9ER29BenF5UkY5cmI2U1VP?=
 =?utf-8?B?TWg0OHpjRVJEYXVHRUJGcUlJT0h5UEhIeldTQTR5T1praWwzZENxd0IvaFV4?=
 =?utf-8?B?N2I3dnp6N0oyb3VBZ0Q2UzJmdW1YcWNkTm5rQ2ZZS2owVHkzOTQyQjl4dHB3?=
 =?utf-8?B?NzhQVWc2cGVOcEZrNk9ncXdXU2xzUGtZQWxCRGNQazgvVTQxcnYrOGE0QU9w?=
 =?utf-8?B?QU1rb3pBWkZQN0tuUUQ1UWF0empWSjl2ZDhtKzhpWGFpN3NlYXdtckRSZVEy?=
 =?utf-8?B?UFdCa29scElHRlQrb3pJSE83U1phUlU2Zis1OWZjd01YWk5nVXFpYkR2U3RN?=
 =?utf-8?B?eFVFUjR6M0YrSWhGM0d1ems4NzZmcC94VnVuZktuTTgvYnBQaEErSmFNY2lp?=
 =?utf-8?B?VElROWczeW1OYzg3YWFINnFpRWZoVlFVRjBIYkZZRm1nUXdCUGdHN3FQeTZS?=
 =?utf-8?B?bHVReEw3OE5DNXV5U28rcjdSTUJTbGo1RzJqNmZlV0VlTzdoeDhGVnRvSDI0?=
 =?utf-8?B?WVAvZjZEZ0UzYVNnVUFZdzAwZ0pQRzZ6UUZZZG16ZU9ESVRvWDBWYTBJd241?=
 =?utf-8?B?cUR6Yk50Sys4VGJzOWFVeWpCNEc0c0lSd3BlaHY4WWI2dllqbjQ5NEFScU1E?=
 =?utf-8?B?cHV3K2FWc0pnQWd4bFdwcGZFcDZ0MXFaUUFwMzBhaWhUV1RDTTVaa3NOL0VC?=
 =?utf-8?B?TVcvREdrQ3FmcFdPRXBXU3dTMXpzc2JqRXh6cFc0SlgyR3RTM0tOSTdFYmhI?=
 =?utf-8?B?L2JFK1pHZ1RpVVhTT2M2UlYzc2x0a3RGRlBwOUFtLzFTUzYzZ0xCdlBNYTB4?=
 =?utf-8?B?L2dWV2RuQW5QUjBWQ25nWXNwQjM5dHdqc0lxRnNFT2xtbEVNcUZDV1YvTUN6?=
 =?utf-8?B?MGsva25KMjJFVGhZVjZtR3lUT2d5M0JGV0I5U0FxbXJLTHRjVkNLNDNOZmkw?=
 =?utf-8?B?bURCb0diMDNEMFVyVWVQRXpLY2IxTGl4cUJHWDNsa2Z2N2dUa1BhNXR2dU5X?=
 =?utf-8?B?TUlMOWhIbFZGb0tlYnBhd3lIMHB3dTBLTXNlaENWQ1VkS2c4NWFOS1Mra0Ez?=
 =?utf-8?B?bmdYdEt1L253cWJ1b0Y2WEdUdnpwN3Bacm02S080VUxIN282L0kvUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaee993d-adc5-42d1-2e32-08de4d258c8f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:14:40.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McAPK8vsgxVmXbRM4RDUqJ+I05ibR/E18QPpuuRwH6098LKZVt841jcA+7RRZcoC2crIo/GrkE22LBnuShqK5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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

Hi,


On 05/01/2026 9:05 AM, Bing Zhao wrote:
> The counters that are used to record the dropped packets (including
> hairpin) are created firstly. Then the counter objects are provided
> to the command to create the Rx queues, and they are used for the
> global drop and hairpin queues drop statistics. One counter can be
> associated with more than one queue in hairpin case.
> 
> So the reference count of a counter will be increased once attached
> to a queue. When closing the device, the queues and counters should
> be destroyed in the reverse order. The queues should be destroyed
> firstly in order to decrease the reference count of attached counter
> properlly. Then the counter can be recycled successfully. Or else the
> resource will be leaked before the application quits when doing port
> attach / detach rerepeatedly.
> 
> Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")
> Cc: shperetz@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Acked-by: Suanming Mou <suanmingm@nvidia.com>

Patch applied to next-net-mlx,


Kindest regards
Raslan Darawsheh

