Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627FEC369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 05:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C04BD4025A;
	Thu, 17 Apr 2025 07:08:19 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
 by mails.dpdk.org (Postfix) with ESMTP id 46629400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 07:08:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYLAb6ADXgEwwAYSNeMyD5yylXhEuTBHTBnroGMZIua1rm0p/R3FjTfwXs1ZRo9VVi1//6ObHnC8aykm/2Gwb9r4RFS/oE9rFdLttVP+zuXLNts2shgu1rknP8Ljmle9IjQ5GYrF0Ixec9IKDvKpRlb2mhmThgVqXFFZE8k2njD0spF7v/YmmlZdzOxjcJQDKDQ2u3cJEGpdQDjZWIx1vWNyw6whx4ULzbISL9+6+7tbMgNsbVfKtb/Bx6P7nCjWIyu/TZlaH5Ta9nhbcR21NOe+2uhiraHzD/Rv6bocUnl1B2SiyeDrlA2nknKqAXqNUwdHUnKUA09gQwsdAmPJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+MKrmV7CAv0qXW9TAh059f/hy17oti3oAK1XrhVZxw=;
 b=nzGpw6SmOfiP7LFoUgalfO9ljXKQHU2pdkH611k3rRk/SZKZMhqh9lW3FAq8eE7NK9+K6PZgawP/iSw1smdVcM6r42i9FF3ItZv8ktAkUnrsakwj+cQYLTgTlNsO5X41JBwgPlOsiSDIHlCRJSN/OisDhWOMIbec4Ya37ZqYWlWhtQKuDsceY5WckBBbTRc8FlM/OuUxZ5DBccYi+IpU+wGhzCCxwoVEPnqfaBWfxYGnTILpC/mZgwL0vJ8lEeMlowN/BJlTgGm+VW7u/GD53mg0JDUaad0D2Z2CRPaQ1cQaaFxgOg5CkrUlQ5Kh+H/vukSuiq924mo3ghn0gr3JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+MKrmV7CAv0qXW9TAh059f/hy17oti3oAK1XrhVZxw=;
 b=pMEEdZmcsNfH+ytw7N+7RMeeXTyL++11sD7luhtYyO2jVPnEfu/JW2BTDHHkogRQ8eBG7VURqZ4qrdDJXEZuJm7ziPSUOg0UmgqxW7HME9auIbU6/EPreHOM2g/DZnR9ONk6F+ZXKQv8L6RrygocfSjdA07SNWXFeNBSlACtHN+UvtpbKTZ2p3P+b884vQTZ6xxhhW+HUj5tAda83S1+fwRpLdcRcuIZEQO9KChbRND/pVTXz38QzJY7XZGvucV1zqURj2SQrj2ko89001epEkbEa+A4Ceno+LMBKCpyS5egZ/RHIYqw1wjlkrzSZ1YmrnxRjPWFEMj6Rtmouw7ZUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 05:08:16 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%7]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 05:08:16 +0000
Message-ID: <3ffb4464-201f-e614-5fa9-a4cbb46e94b6@oss.nxp.com>
Date: Thu, 17 Apr 2025 10:38:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] license: add exception for Linux Kernel uAPI headers
Content-Language: en-US
To: Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org,
 david.marchand@redhat.com, thomas@monjalon.net
References: <20250416123426.2638250-1-maxime.coquelin@redhat.com>
 <20250416123426.2638250-2-maxime.coquelin@redhat.com>
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20250416123426.2638250-2-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec779d0-e9fd-441f-4a23-08dd7d6ddc4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDBob0QzeXlJdlZRU2tJZ1VVWDlqSHJsbC9Cc3F5YWt2Yi9HSUkwV3ZRRFJz?=
 =?utf-8?B?SUp0bU50SUNqRTNpWGc2a3hlV3pYemM4dzhLZ0pNcHJabmJzd0w3Zm9HNits?=
 =?utf-8?B?Q0tLYk5CMUY5VC85WUhIOWZPWThWYVlxUXo5NHBzUW8ySEltRTVjcGRkMVZF?=
 =?utf-8?B?eUptNVN1d3F1amtWVnRTV1hXRGdVYnMvNUYwUjJzTFA2M1A3bjAvUUFlSGVD?=
 =?utf-8?B?UUpNbkpmT214NzM3MzMyQ3Nic095OGswSnRoTFpDYlpFN2hoUitJT21XQ0Qz?=
 =?utf-8?B?OWE3Tnlvc0VnYXIrTGMyaGJMUlljVWRRK1o4TEVWWnIwMVVBR2tCeGc4VXow?=
 =?utf-8?B?RjFVdVVhOG1Dd3lsSkF1WkN3MmxraTR4U3R2MTEvSkpWV0piMkpaUjU5NUVG?=
 =?utf-8?B?UWxQVkRQTXAvQ29SRk9LdEp6ZkNZOXJ3bjRxWEozSXJHYysyeUJCejZ3a0VR?=
 =?utf-8?B?R1lpM3NzZGFUNjMxOEtmQmtSNURpZ1hSM01lSytwMm94Smx4WFQyNVNKSHRR?=
 =?utf-8?B?b09sRTV2SWNDam9RRkZmalJmNUo4cmprTWFhUE91dE50UUg1aU9rcjJzRm9R?=
 =?utf-8?B?UUNSd3JJVHJJeXdwYUdERmo3ZXVzTTAyRzdsRTd1TktWdmNtcHhmZGx1blJK?=
 =?utf-8?B?Wmd3U3dadkgrZFRrWmJ0dDRyRjNiSVlnbFZ2RUJQbitlSWNOMk5WbGUwRkFQ?=
 =?utf-8?B?Q2pPQ2NCaVhUWU9zd25mN1Mra3VWbEZHa09oZXpNbERBdHhpQlM4SE56SEJN?=
 =?utf-8?B?eUV5cVdzSVV5eGdzd09hQk9hNWovOGl1Z2IwdzNZWGVkTjZOeWRZQXlYd2J1?=
 =?utf-8?B?MlJTV0JidW1hbHBFbkFtd2dPMnBRYnV5ZGluQ0xNMFJrVDd4VkxOaXA1V2Ex?=
 =?utf-8?B?U3E0TlFCWUg4QzUwNU4zVmpTV1BmSDlUYVFYNmphbEJZalV4OGFxWU44ZTN0?=
 =?utf-8?B?dkMyZnk4YzhveUI5TFBTbFhlMTZTVzJsdmU4YU93Y05rZGVJRlFSNFJzZE5p?=
 =?utf-8?B?aE5QQThLZXQvQW15R2pKNEc3MTNoZWtQcGpXQUI1RjE2Qm0xbThhWVhKZktL?=
 =?utf-8?B?UmlEejUrZ3hzNy9ySk1BWlRIcGg1QkttZ2UweEJYVExSaThXaWZvTTVyamNE?=
 =?utf-8?B?MnluWXF1V0pySSs5U3ZlZ0NsNGpjUFg4M0IwaVc5TC9ZRlZWVEl4S2V6QXFC?=
 =?utf-8?B?TjZSV0hoTXI3clZ4czIvS25tVkIzQTk0d3FZMG55Z1NMR3U3a3g2cVB2WElP?=
 =?utf-8?B?aEkwaVdqaXdHamdFRnFHeXhUbmd0RlFqU1hhUUl2QmlIVDN0UXRMcnJUKzlP?=
 =?utf-8?B?SWdvNHdwbVEzdkVlZllpQmV5d20zV0dMNEV5LzJzaGlGay9ObkxmcWFreDlK?=
 =?utf-8?B?OEpXaXJxOEtqamdGd0lFYUdiQmwxbmJ0UTc4c3RETkphTGtHWE80R01Dam84?=
 =?utf-8?B?VjhBeTlNMmJRVHVPSmJoMUJidkVacVhQck56R1RqQ1hGazN5K1JKZUxVcTdB?=
 =?utf-8?B?OXI5ZlpMTVV2TWJoYjJ2N085NCtPY1RhV29HSFRLQ05KbFlldVpuVzhuZnBV?=
 =?utf-8?B?b1RMUGxoQjJqOGZhUFZGTjdDQ1k5K1BJTWlLT2tBdXZZUHVPV2FQdlZNeGlv?=
 =?utf-8?B?OVhNaXFwN1hWcDBKVEwvakxBcWd5L3RQKzlneE1YV1RCR2s2bG5yWG1wQ2lh?=
 =?utf-8?B?UmlPT0xHdzRYR1ZvcEtWQ25Sei8rMFNTVHFHaE9CckZjVmMvNFFmamo0czg0?=
 =?utf-8?B?NDE0Z1hVa2xJbWQ2TU5tb3Q5U2RneEpPMU1XWjhPQXdLTW9PMHQrMzg1LzR1?=
 =?utf-8?Q?luB/5j5VlBats/OnEWRPFrdVbzQvrzuWqla9E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2JOeGJvSGorSmpiYkV4QXZQRW9HT1R4VzU2TjVNSVNIeGRNYUpBZ3hsUE5T?=
 =?utf-8?B?VEVFcWl1dlZOM2xJTnowbEE0c3hNSTFSbmQ3ZzIrcFRqbmlES0NoTS9LNFlp?=
 =?utf-8?B?aDJRTHZNOGljYmkxQkFTdkNNWlFRc2FaTFd5WDdxbStVZnNVS0tidmZ5a3hE?=
 =?utf-8?B?SmVMZkY2MW05eVFKdFQyaExmUHROVXdMSSthVERodTFlYzdYQTgvQWpQcGc1?=
 =?utf-8?B?MUdkbzJRVWF3SjByU3FIMzJIbU5rZnBHMHIvSHZFSUZCY1FsZzBpTFFzNjFq?=
 =?utf-8?B?NjRJdmllSU5xMG96b3ZKWGV6MFdhVWNQMkN5OTl4ZW0yVWFqM2pJdDdYbC9U?=
 =?utf-8?B?STZxeGFhOGlpU3MwaTdMVkI4MU9VUDVTVlVuM2RTL1YvM01wUzdZRVJGNlBw?=
 =?utf-8?B?dkhSWWFzRDdkQk1UVkJWVE84dDVWOGQxdE1WT1d0ZUcrSG5KQzVPc1FNRGQr?=
 =?utf-8?B?TVExcnhISVRhZXp5bjdRUU1wSnBaMWVIVUhYWHdEUm5WUTUrazNDNVlvck9m?=
 =?utf-8?B?OWNaRUhFd00zYU5ITzFDdnVTTy9SN1pybGhaVG13ZEphdG13bUJTQ1MrWmFP?=
 =?utf-8?B?WVFLd3dpbStwb1JhektnclJUY25ORUN6eDdzekJTN3pvQTdkY1NYYnNibUxj?=
 =?utf-8?B?Q2JiMVBmMzU4SWdUeld4MFFuZUtZUzF6aVgrOFgwaWhNZHRIRFBDdGlyV1hN?=
 =?utf-8?B?YSsxSG9SdFhXUG5RNG44TkczZlRQUE1QS3BveGhaa0FWMkNSZVJwZzJScVdn?=
 =?utf-8?B?Y1hKZEpJMngzTEd5SnFGMklsdkNiL3RVM3UxL2tpWEZNNTE3aUlyRVk2LzBJ?=
 =?utf-8?B?ZW5oODFib0tncUh2QmVManY5UDB0VnlBMjlCSnFtWEs2NmJsTnNDdCtBVmZV?=
 =?utf-8?B?cVkyOWNBVzBqNzRVVHkxaC9QelVxaS9EenQ5Mlp3aHRPdkxWYkhaaXQ3blJL?=
 =?utf-8?B?aVQ3UkFuWndtYWhPSVFlT0hzZlFqN1hYNFN1WXJyTXdZcjBWUmtjOU1wTEQx?=
 =?utf-8?B?Vm91ZTZudWdueTc0WGJNcnhsTk1ueDRXNHJqam9EMXczVVliM1ZUaE1QdVdr?=
 =?utf-8?B?NmpWajJ5cjZ4Y3F1a3FheE1RYnhaNGRJaXlLYVQvS3duZE0zTU90MkJGQ3d6?=
 =?utf-8?B?RHZML0tHQmxxTVJpU25kK3Y2QWFsNE16ODdzTG50N0J6QUtzWXh4NFpReEFs?=
 =?utf-8?B?dXQxK245UTZ4OEtaZzJvdkR5VTFKWEVWaDI0TVMyMFZzd1lQMnZkaS8vWHN4?=
 =?utf-8?B?NUxMbnJxUGQrS2g2N3lMZ1c1WHloUzVkRHh3NCs0Ym5WdW5PZ0ozaEZpNmJP?=
 =?utf-8?B?VkV1UGhFRllMV3E0aWVLZ1hNeVhLcEtmb0cvdkd3TEMrb255d0o1aUt5Zisz?=
 =?utf-8?B?Vko0TjRqVjRoSzg4VVdyOFk4NDJ0NGRUL1UrZUFzU0IrdzBCZDBEc3JkVW1K?=
 =?utf-8?B?S2pKNlBrenhOL0JZTE9vVXlwNWlLdFNtUGk4QUx1YzU0RmdXak9tamlzZ3FH?=
 =?utf-8?B?Y2dKUkphYUJDMTdDQi9Fb1BBcVd0MzVjeFZkRmZXY3Q3TFVqZjNPVE9PRzB6?=
 =?utf-8?B?US83dmVGV0xpUTVwYndYUEI3TmFzdHJuQnUwZEI5Kzkva0gwQlU2V3VXWlc2?=
 =?utf-8?B?aHM3UjFlbDAyUGZ6a0hzb1JvZjVTcXhrK2ljTnFBeDNjN1BQZGRJT2NBcjZQ?=
 =?utf-8?B?QVdvTENkR2p4WEMyTHZVRHNPc0x5QkRLNnVYcWdINWF5dSs0OWRiNkswVUlx?=
 =?utf-8?B?TThnMzBqN1YwQnYwNi9pQnNVbk8wY3VHcG1DdURFeGVweU5tMW1hMlFka3R6?=
 =?utf-8?B?OWd4eTF1VlI3Ui9CTWJvQUpHU3J5Zm15NWJ6TUFXcTJOMmVYNGlLV1hiU3dF?=
 =?utf-8?B?UURjSkFqQVVZTFNhWTAzRHRCZzZVV1ZOVnBUc09xa0tzRXo1d1I1VndkTnVR?=
 =?utf-8?B?bTdybUNES2MrMjVLaGd6dzZISEhROTlLbnkrZ20rS1kvZU9jNFFGQTFiaTZ2?=
 =?utf-8?B?bWlPRnBXcDdBQWk4N2x5L0dSTS9qYVpVeTR4R1l6akNrbXVNQ3lGWkJVaUFB?=
 =?utf-8?B?cFdwWFFIbE42U0RZUVhuVTlMOXZveDV1UVRid2VIRFRIOTN0OHhMZ24wYjVO?=
 =?utf-8?B?MEpzVksxbXg2ZFZLL01mMlFkWE9qRExlY1dJSFpiSWNJNk9qMjlpcTBUbjZL?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec779d0-e9fd-441f-4a23-08dd7d6ddc4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 05:08:16.1371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4xodXjhD7rGNUOYqJknKD9OSyR6h898PmSG8k8wcbv30LN7iBFo72HamEy2HfUyps2P3U5pa7oOHcVEQAaY3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853
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


On 16-04-2025 18:04, Maxime Coquelin wrote:
> As approved by both Technical and Governing boards, Linux
> Kernel uAPI header files can now be imported into the
> kernel/linux/uapi directory.
>
> This patch also fix the SPDX tags checker script to take
> into account dual-licensed files.
>
> The process to import such headers is documented in
> doc/guides/contributing/linux_uapi.rst
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>   devtools/check-spdx-tag.sh |  2 +-
>   license/Linux-syscall-note | 25 +++++++++++++++++++++++++
>   license/exceptions.txt     | 17 +++++++++--------
>   3 files changed, 35 insertions(+), 9 deletions(-)
>   create mode 100644 license/Linux-syscall-note
>
> diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
> index 1fd0d579d3..984825026e 100755
> --- a/devtools/check-spdx-tag.sh
> +++ b/devtools/check-spdx-tag.sh
> @@ -48,7 +48,7 @@ check_licenses() {
>       fi
>       exceptions=$(build_exceptions_list)
>       git grep -l SPDX-License-Identifier: -- $no_license_list $exceptions |
> -    xargs grep -L -E 'SPDX-License-Identifier:[[:space:]]*\(?BSD-3-Clause' > $tmpfile
> +    xargs grep -L -E 'SPDX-License-Identifier:[[:space:]]*(\(?|.* OR )BSD-3-Clause' > $tmpfile
>   
>       wrong_license=$(wc -l < $tmpfile)
>       $quiet || cat $tmpfile
> diff --git a/license/Linux-syscall-note b/license/Linux-syscall-note
> new file mode 100644
> index 0000000000..9abdad71fa
> --- /dev/null
> +++ b/license/Linux-syscall-note
> @@ -0,0 +1,25 @@
> +SPDX-Exception-Identifier: Linux-syscall-note
> +SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
> +SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+, GPL-2.0-only, GPL-2.0-or-later
> +Usage-Guide:
> +  This exception is used together with one of the above SPDX-Licenses
> +  to mark user space API (uapi) header files so they can be included
> +  into non GPL compliant user space application code.
> +  To use this exception add it with the keyword WITH to one of the
> +  identifiers in the SPDX-Licenses tag:
> +    SPDX-License-Identifier: <SPDX-License> WITH Linux-syscall-note
> +License-Text:
> +
> +   NOTE! This copyright does *not* cover user programs that use kernel
> + services by normal system calls - this is merely considered normal use
> + of the kernel, and does *not* fall under the heading of "derived work".
> + Also note that the GPL below is copyrighted by the Free Software
> + Foundation, but the instance of code that it refers to (the Linux
> + kernel) is copyrighted by me and others who actually wrote it.
> +
> + Also note that the only valid version of the GPL as far as the kernel
> + is concerned is _this_ particular version of the license (ie v2, not
> + v2.2 or v3.x or whatever), unless explicitly otherwise stated.
> +
> +			Linus Torvalds
> +
> diff --git a/license/exceptions.txt b/license/exceptions.txt
> index d12fac2034..cf2034747d 100644
> --- a/license/exceptions.txt
> +++ b/license/exceptions.txt
> @@ -9,11 +9,12 @@ Note that following licenses are not exceptions:-
>   	- BSD-3-Clause OR LGPL-2.1
>   	- GPL-2.0  (*Only for kernel code*)
>   
> ----------------------------------------------------------------------------------------------------
> -SPDX Identifier      | TB Approval Date | GB Approval Date | File name
> ----------------------------------------------------------------------------------------------------
> -MIT                  | 10/23/2019       | 02/10/2020       | lib/eal/windows/include/dirent.h
> -BSD-2-Clause         | 10/23/2019       | 12/18/2019       | lib/eal/windows/include/getopt.h
> -ISC AND BSD-2-Clause | 10/23/2019       | 12/18/2019       | lib/eal/windows/getopt.c
> -MIT                  | 10/19/2022       | 10/18/2022       | drivers/net/gve/base/*
> ----------------------------------------------------------------------------------------------------
> +---------------------------------------------------------------------------------------------------------
> +SPDX Identifier                 | TB Approval Date | GB Approval Date | File name
> +---------------------------------------------------------------------------------------------------------
> +MIT                             | 10/23/2019       | 02/10/2020       | lib/eal/windows/include/dirent.h
> +BSD-2-Clause                    | 10/23/2019       | 12/18/2019       | lib/eal/windows/include/getopt.h
> +ISC AND BSD-2-Clause            | 10/23/2019       | 12/18/2019       | lib/eal/windows/getopt.c
> +MIT                             | 10/19/2022       | 10/18/2022       | drivers/net/gve/base/*
> +GPL-2.0 WITH Linux-syscall-note | 12/11/2024       | 04/14/2025       | kernel/linux/uapi/linux/*
> +---------------------------------------------------------------------------------------------------------

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>



