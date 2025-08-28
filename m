Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F873CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 04:50:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 253FD4066E;
	Thu, 28 Aug 2025 06:49:59 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by mails.dpdk.org (Postfix) with ESMTP id 1AA5D40263;
 Thu, 28 Aug 2025 06:49:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOBmbvPCqH4FUkkohAfQEZ8HZtSYnEpcmOWQexORzKObwIZz8H1h5d1FBvS5ZsGplEQNf7WtZHuSF/9rRomsQXLEA8wf+fq53qTQlIIY0ZI1Zw4fVvZBmG7wdliUMpwUGG0l3CrBn2eRwfxDXbCxT2U5XNSMAoz2E3/WP+MLBXMbRBXvdNB2zWh2CxtK7ACVdWTI0ZCOM8WDqBgIM+dgNSY5B/iZNTacoKnz898Rzz0zWVUg1bPPS70qVWZYzB1//OsNV4Zj+ZCQvNSFqFlU6OwTFUDWdOfKVATyCGNvRG/GZd0uS1b19w7pyIfqV1xuxNo+hGZdbGL9eVW0hLyjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHzKolpEEJQJ87XPEcGaWzKC62u0ccmd+1jd9+4Svdg=;
 b=szTdUTA4pWVqquasvhZdYrQeZAnV6tOWpaXyXmP9eBIeYk5uovDXCP5Sbdsd8bjBKQrJw4tTGZ5BDkPQNbAXgYOlsi4utse08pVgcViMbiEq9h9gcbgjg9XRKDUnp8k1Ey7+/keY1olDCluKHWwGU5VR8+vnJFf0R0pCWyGlvnz/LLE6ORpGxeK7Wrw+U/PU2aUdek7UpH0WQYoSAJ5hwquq5WvyhJu85dDQcX4LIaXAyIzMWeIxRnPddLKep9iGyGDwYZDN3P+53zu5QQXeP65jqNuAy01sVZ2fJH/k1Ir3jrWzH/fMTnH1XKmyBJn6qb2VmayWOMCeWF2RoZmT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHzKolpEEJQJ87XPEcGaWzKC62u0ccmd+1jd9+4Svdg=;
 b=ix246RpReOXYFIUt7paXz2MKTtZzD0mU4GVR3kCB3KXDUp9cf7t/YN8ETEbXS6Y6j7Gy3oiQNDFQ5zDfKe8BS351r9WTCfO1xQ5TaxQ3hxJ0y03Atn9fiNdUB1yNHCIhcRSOnhmMYVrEMCGOKMH78Lq3mYU9KQyk1WPkbw4j7MWMw6OgVa/6f9Pc9XWtebyXO6h7qx1eUNl25J2RnASIBL/LtPHhoiBeiZkMtWTZ9rxpwE0oHBPfA/p+DfWOKxQB+nnvnYq9SJ2AnR5PzsMdZGwCaGuNP6IQ37egBDGVk8zaOS7Tv/fIia7uIjXa7uA4BYaa5hcGnAahlD+klaJ19A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Thu, 28 Aug
 2025 04:49:54 +0000
Received: from DS0PR12MB8443.namprd12.prod.outlook.com
 ([fe80::f2f9:e6e:f9c8:4b8]) by DS0PR12MB8443.namprd12.prod.outlook.com
 ([fe80::f2f9:e6e:f9c8:4b8%3]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 04:49:53 +0000
Message-ID: <e30c6a96-d536-4454-b7b2-c98c4a24a3e4@nvidia.com>
Date: Thu, 28 Aug 2025 12:49:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/mlx5: fix probe optimization race condition
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com, 
 suanmingm@nvidia.com, thomas@monjalon.net, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
References: <20250828032134.167999-1-rongweil@nvidia.com>
 <20250827214044.16f9baaa@hermes.local>
From: rongwei liu <rongweil@nvidia.com>
In-Reply-To: <20250827214044.16f9baaa@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0028.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::8)
 To DS0PR12MB8443.namprd12.prod.outlook.com
 (2603:10b6:8:126::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8443:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed5257e-58d8-4b6f-c088-08dde5ee5440
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWF4a1lZUEF3Mks0MG44bjNiM1Z3U3A5N0dNcE00aFdwOUI3RTRLWTk1ZHcw?=
 =?utf-8?B?Y3pZT0dDMG1sa1gyaVY0WWI3Q29WVEo1UXBaZUdTT2dURGR2M29aYksvcnJK?=
 =?utf-8?B?S0Y5ZEtDNms5Mm5OVUUwY3ljUkRvYXpQWW1kWFBzak5jUGcrbTBKcDJFaW1h?=
 =?utf-8?B?aC9aTG1mcmVob0xOVVkrczVIRXZoRktWNDhqUGFlY3hmb25BUENQY3V5bjhj?=
 =?utf-8?B?eG96cGx0TktyQ2RadXM1N01hc2VFY0NMWncwMUlIQlBvQ1o4UGlLVnBXQitK?=
 =?utf-8?B?Zzd2MnovRnoyMXVCbmQ1MU1yTDJRdXUrSUMrRlhoYjV2K3dGdk5MQ1dXTkF4?=
 =?utf-8?B?dno3VzltSzFzcTNMamxjNFVNMERKU3RjbExDR1FmZ0VDNnNHT211Z01HWFJp?=
 =?utf-8?B?c055SXgwVWpQblVpdnJQdU1wOG5uTitFSjNEc1ByMGYvUlVQL1lBL3dyUVdF?=
 =?utf-8?B?SG4xaXFOakdqeHgrZjJSNFNab1I3cGpNdkVJTlcvczA4dDQxQ3loK2wvQysz?=
 =?utf-8?B?Q2owdWkyQTg0TktMaVhIUnZSalFwcGlqN2k2SHNzZC83THNWaVFKRE42SjZ5?=
 =?utf-8?B?WUlVMko0YTk2cmxCaG1jR0ZzSndwOXEweXNSSkg5Q3NabENQSnRNMVY3bklr?=
 =?utf-8?B?cng4VUF5bzU4aGt0Z0lhcnhRdVhibERwZ2FGS1FpRzFkWnVuL1AyRmszMngr?=
 =?utf-8?B?RGI1NmVTNFhnTWJzcFdZTnUwYWxDcm5Ma3BhOGZTcjF5UXJnUlRYWjBqaHo3?=
 =?utf-8?B?N2UxNDlmQ3gwc1pjSHppWkpEUlpVTStPeW5TV0VkTVBVN1J0ei9GTi9YTnZp?=
 =?utf-8?B?bXp6OG4ybnVLdVg0dTdKMUZuNXpzVnB6NndOUWIvbWRKYmI2Q2NHMllLSHV3?=
 =?utf-8?B?M1gwd3QrZjZpb0YvUG1xOWNTK2JHWm9EOENwS1NEbmdESHV4bmdCdC9ER043?=
 =?utf-8?B?Zi9ia25kYzBkMGJnNGRzUGV0Q2sxRS8yZXhNdEJrUStXM1dlNkYyaUxXZ0Qr?=
 =?utf-8?B?MEJUQm5UNVMvQm1KV3Q5d0hYdkNYRDdjL0k5bE5oWTFXNVpxMVhkQS81OEVI?=
 =?utf-8?B?a2R1YVFKbjdRZUxYeUR1TkczQk83NTk3aDR2UXFyeTE5R2dHMUViK1pzRDB4?=
 =?utf-8?B?dnNHSUJRVjl1SHN2dXB6Z2hGODZvcmdvemZCYjdKeE5sZ05TSjM2MXJ4Qm9L?=
 =?utf-8?B?eHBiaDE4MDFsZVhrMVpIWUR5c3VyQ0ZVb04rRjZmK3pLQTlscUR4OCt4Tmo0?=
 =?utf-8?B?b3U1NzdKWHJtdHNRd3k1UXhMY0VUcUxrd1FRR3N4NWtqNjMxZWxXQkI3S21U?=
 =?utf-8?B?NVQ2am43Q21HNlhKRHpieGhhMXNSU2ROa09VNUVrOVdmbEJDTEEyekxsUTBR?=
 =?utf-8?B?aHFiNEhMdGVvS2pBTWtUWUlvbFhZdmNwbWQwWUNqMFZ0cElhMUpHd2tSMzMy?=
 =?utf-8?B?alNTeS9RUXl1eFVsd0pEZlg2a2t4S3NuRHoxcVVMWC9sL3FubFVMcHF0ZS9U?=
 =?utf-8?B?bWtCZzZIcXp1eVQveEt2TDEvdjhLczN0TXJFU2cxZXBxc2pWV04rUmJXdExI?=
 =?utf-8?B?M3N5TWExWWk4UmhxL1p2ZkhPb2lUdTM2blViLzUzMjJRTERWQjB6MFcySHdY?=
 =?utf-8?B?YU53VnVZV1dYZ3ZYUm44d0dDRW9mVFdOcTZPdERNSHNkVjlzME5YRGFMTW9T?=
 =?utf-8?B?dm1ZUHY5QjE0T2VQbk0zQ3VmNVplN1N1WGswWEpGV0VNemNadTF0dzI0QTdj?=
 =?utf-8?B?Z0Zzdi9iVmhNb0plSFQvQUlRQUtUVTNSN29YcDRJTExCNHdzZHZSN1N2aVcx?=
 =?utf-8?B?R3lzNER5V1doUEJFRFU3WHBMREY3cWNEOVZSREsrODF4SC9PdkJUa2Z6SFM2?=
 =?utf-8?B?aUdrTVIxbEdUZytzaSt6TXNyeW9TUS9TczNrRFBkSEdDd3N2VUxpS244WG9B?=
 =?utf-8?Q?nm/Wp5mRRXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8443.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtnYkw1WVo2aTdJNy9NRTlIQWlNK0FNaVVtYTFRM1RHeTlyZWZYZE1HUk1S?=
 =?utf-8?B?SXoySUxLa2duMlZCTy9mRFJQNFZKOCsyd0N3N3dlcmJnQlNFdThpdFhmQjhG?=
 =?utf-8?B?bHNnUVdaNG5TdzRXMEphSThrQmVob0VNRjF4Q3I4ZUFOOGVoNER0TnZpZmE0?=
 =?utf-8?B?dFRtQkxYdTNyU01FYXFjZmZRclVmeHJEd2QvMmMvVUZmbFhJV1RmUFVyR1Fh?=
 =?utf-8?B?VEpMbkdVWk13Z3hhQzBFVy9XbGFDRUNYck94TVZYQXEwR1NGc0d6Tm5jWDZL?=
 =?utf-8?B?OXo5VVArbWxVN0xMcVlrcDlXZEp5ZysxUW5pUTdpVjRUYnp0U01qalRHanJB?=
 =?utf-8?B?Y3hCZU4vdlRoNjlyUmI3c3ZTVmsxaEJNSkMzUXBTMlhGaE15bzZFbnZwcWhQ?=
 =?utf-8?B?QlczRit3NmQ4NWczLzRnYmx2ZDN0ZmlyY00rdkhISFBjUkRaRDgvMXVIYXJi?=
 =?utf-8?B?bEFZditISXZub3VPSjFuL0RzVHA1cGVLT1VzNHg1UkVQYmJXRjZRcWo0dW10?=
 =?utf-8?B?WGUvdWJBMVVyb1RYMGREY3dQL3ZNUjVuSkFnZ09xc2FuU1BGYXdtNzNGWGNx?=
 =?utf-8?B?WVdqR3Q3azJiRmJHUStFV2ZGVHZBWXJBR1c4MEJxZTdWcTV0QU15M0swRkRi?=
 =?utf-8?B?NXdVZzhPUEtuSnBBTTVnYXVKeVE3V2FYL09aT3pxTUM3cE1SSUFDdkJadE95?=
 =?utf-8?B?RFpYbVFwdzFjTXdjbFF5dEJ4Y0NSa211d3E3R2VtaXF3MHo3WkNYQjlNeHRq?=
 =?utf-8?B?YkI3UVJnQ1phK3NTUFJsTVdiOFVpczM1bWk4K3d1cTBjamNjSzJuLy9CbUth?=
 =?utf-8?B?STBMS2tEeFNHZ01HbkVzYVVTUE5tOVU1dkt0VUhyTmJrSWFweVZnb3pzR2hL?=
 =?utf-8?B?TGt4N3Yrc1B5Z05EL0tSZFR1YzRDWnNkdUNNT1Q5OC9yTnVJYVhWSUJYc0g2?=
 =?utf-8?B?c0J2V3Jqa1ZTRmQvak1sS28rWi90R2dpbHdERlhCMi8zdXVHVWxpTkRKOFJD?=
 =?utf-8?B?NGVxeFBWU2c2Y0hzdEt6UER5T2YzckJwbExaR3FuSFZIc2IxS2dpZUhGK3E5?=
 =?utf-8?B?UEpYbmlJRUhML3BaRWgyUEZlN2FZQ3FDMVhIL2IybHEzWkQ0STFFT2g5dEpG?=
 =?utf-8?B?dVA5UnBVMWlTY1dtVGpMTHlZK2M4N1pYbEtOZklXbXRJSk1KZER3czh3dndZ?=
 =?utf-8?B?VnlrVE9vRE9ZRVA2K3lVejBJbnR4WDNZM1ZtNGJiSGYrMEpkVE5wQmhYNEdO?=
 =?utf-8?B?bDhCSzFJZFByMlFtQnZlZWdDUnU2d29iV3hacWk4RHVEZ0VIWUxwWHI3VkNG?=
 =?utf-8?B?bEZ1aUc5a1BlTi8zQ0FqdTdEUUdTRTRuWlY5OXA4VXpLdUFtM3dwd0JjVjN4?=
 =?utf-8?B?YkQvazVnTTE4dGh5d1JsUEIzMUVzcUpNRjVqUHVPREl6dDhGZTF6MVpxMEw4?=
 =?utf-8?B?MEdnUFZGbE9DdXFnSlVEbEZiNDJIWDFaenAyeERCWmZ3V0puRml4R3VtS0F0?=
 =?utf-8?B?Wk5Nd1dtbnk5dGZUenhIVWF1WmsraDIyYjllNm12Vko4T3lrNFl0TjY4Q2JU?=
 =?utf-8?B?ZDcwc0d2aGhQWnM4M1dJMURpcXl4S2w2bytyWHhRZ1k0NkdRbUNVMXpGMHM2?=
 =?utf-8?B?ZDZIVVhGaExQc05GbVUxakV3Y0xnNmM2R1FNdjBycmhNMUh1VUp0dzV1bmVS?=
 =?utf-8?B?dzByTE95VHpYeXdyUkwzTnNlcWl3TGMvZGkvMWdMK3g1eUJkV3ovZE45MXlr?=
 =?utf-8?B?MGwxUWh0VVc2L3ZxK1ZHOEdFazlPckU2VkZ0RmV4dW10UzBoaFMwV3k3NUdv?=
 =?utf-8?B?TThNNVBzQjZLM1QzYWZkaGdXZSs2VjFJWGxjb3pkaVZDZzlsT0wyYVN0M3J6?=
 =?utf-8?B?WVQ3N1BzWkZsR1JQNnVCbXJSRytOazVYaG1RemVkbnR5aVcvclM1b0hDdXBr?=
 =?utf-8?B?TmdTWjJveFdXTENvaEhlaEFjV093eXpwaXRiejBkN05SVk5MV001QWtpOGha?=
 =?utf-8?B?dDFPdU53aWZaZWxURWNVbkRCY295TzJsNWlTVTNVd2ZFZ1N5dmlLRnNJOHRw?=
 =?utf-8?B?TVg4WFFqVXkrQ2ZwR1RDejE5TzFQYktiMUZjQVdiVGUzV1U5a0dQRzlxVlFP?=
 =?utf-8?Q?r+AFoRN+qb40gjspitdbz+qhM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed5257e-58d8-4b6f-c088-08dde5ee5440
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8443.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 04:49:53.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJVvGlvAZQC1xbgKUGqJECN1+XdX7Lry7GtySjGJY6sIeNvmqVL8bVS1kpQRCfg6B0aCWIfjitm50kvky+FvEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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



On 2025/8/28 12:40, Stephen Hemminger wrote:
> On Thu, 28 Aug 2025 06:21:34 +0300
> Rongwei Liu <rongweil@nvidia.com> wrote:
> 
>> With dedicated RDMA link monitor, there are two threads
>> which can update the IB device port information.
>>
>> Add a new flag to avoid the race condition. Update should
>> go through RDMA link monitor once ready.
>>
>> Fixes: 51fb5c40c826 ("net/mlx5: optimize device probing")
>> Cc: rongweil@nvidia.com
>> Cc: stable@dpdk.org
>> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
>> Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
>> ---
> 
> If variable is modified (with out locking) on two threads it
> needs to atomic or volatile.
Exactly. Before this patch, it' user responsebility to seperate probe probing and sf manipualtion.
Obviously, customer didn't follow this very well.
Now logic change to:
1. Update all port information in probing thread.
2. Probe thread initiate the dedicated rdma monitor thread. Once ready, all port update will go to this thread.
3. Next port probing won't trigger PMD port information update.

No lock is required then.
