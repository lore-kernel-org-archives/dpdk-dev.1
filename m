Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0AACED606
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 11:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C4FA402A2;
	Tue, 18 Nov 2025 12:18:58 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by mails.dpdk.org (Postfix) with ESMTP id 149E540150;
 Tue, 18 Nov 2025 12:18:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qu1z/A9pVrGGIt3/s4nZzGFLrfq0ezhgL1xZNQQ9tIL8DC6iEPyY+Vl2n2p/OTNtfJIsVZQ7ghm0n2MR+TOsSRdjxgWm4nuNUdhGk5XHiVToLu7mCB63sziAS+JeieBf6LHbziRFfndfp7pg8o5+RfiR1CwLA3uBy9OFicAzieOcEDAU594fLUp/TyqzygULLGIxRghlVDnFnkPekDSJGeW+gkag/G7qgPSv4P63xnDq0PyB2amgMEZtaoMeu076GLbgkLAHZWf9Mk8rSE2mW5psRZPfFWTm1C5cCwAiD99DVg0I3fhh8KBAJEugnIbcBThkN7qQnofFAb1NbgJ/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngEAtNaSSvB2J2oywwZhPWgYh7BUg5OIF95xjOz9Hng=;
 b=LKzgaadB9JUvjR6tXm1aWsSCzznuAOZ0PU5y1KZ3pr+cfLSyoFbxRlOm1pOvpL3eOJRpusxuErRRSuJxX9M+BEy4oqbO5LRJ1FXMhN4CyRkikVv9THAbBy8rZRb3g7x02qhFl43gFCyKW9EIuQRz95H3yDMLaI5QkD9j+1fUo+pYywf4b7he8Idxfqn/aBbdpHSQgvZeTDaMIUmtKGFihI2bh0xwt/R2fnuT5OxxbuCgrN8lT22J9NZYpWJsZeFcXDTCyv303JUV816ywZvY+vp8M7UqLa0QmepbhNV7Rn9KrJUOTGg65el/uIQ1QUg59dIKsWoJecLYTtsaJn4Bng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngEAtNaSSvB2J2oywwZhPWgYh7BUg5OIF95xjOz9Hng=;
 b=Xq5HpLKF4Fpb3LqhtNyuiQ31i/plWUxA91t5+ETgsptLJ44pjkevL1pctQ3NQyjS+5vnmxi0juuXSuNoQ5lVXfFCv8ajoOrg/lflSXIm1dz4cJpaTnhBqGvAzvo5xGv+8qwmjW5aLi6e5V7mx244Tjhhw6gaB3j3ejuNnowvdfJE9oD8RQVHokCXAxLl5AOQ2Cx8Yy3fI64Qu5r72Ds5pkSUydx5en9te4NoTncK33Yc62mc31rk4fS8jpoOLaOOkpsFgbAQ2vqeDabQVzE2sydk3xBDAl1+l+E5wtMIY1lOrtkg2sNZQeSCzYYStn758xOi0m3WMeCRd3Cj+COwIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 11:18:54 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 11:18:54 +0000
Message-ID: <d7375712-7dd0-488e-b726-55734945a280@nvidia.com>
Date: Tue, 18 Nov 2025 13:18:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix warning from uninitialized variable
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Ophir Munk <ophirmu@nvidia.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>
References: <20251113163301.285550-1-stephen@networkplumber.org>
 <20251114174912.1103626-1-stephen@networkplumber.org>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251114174912.1103626-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 2894a2ce-641a-4aa9-a702-08de26944224
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmtZRlBWNkF3OGtkMHJnVDNTNFpKaW1yVXBlMkpnRUQ2ekVZeTlDUzhZaE4r?=
 =?utf-8?B?cm9VQzhDMjBUbE1WNlJzUldKTlAxZnlFVGZEc05QbE9sL1JGUEdCWC9zS2R6?=
 =?utf-8?B?TUs3cXRtUzNKeGx3bFV2QmRubEs1ZlBEL2owaVlrR1BtSVlJTUttTW1zRi9X?=
 =?utf-8?B?ZjlLemZhMTV1enAwaWY1N25nUEszY0gzQm1Da3VPVFUwbEJSK25HUWdhVkZw?=
 =?utf-8?B?NEZ4K25yd2xrdC9yS0padGFKemJyOVNkT05pUzZJaVViY0lWMFJyZUtLdGdX?=
 =?utf-8?B?NXpQbXZaVmx2TzVvOFp5STljbzcwbDVZV2MvOUV5b1NHZzc0YWJTeXRZSnFy?=
 =?utf-8?B?a0NSbTQxYWluWEZ4ZnN6OUZJR1RFWEJRQkRUZkc2d3BBeGpmbE9TU0R6M3ZM?=
 =?utf-8?B?K25qQVNreGpvRWxyRjhmVUsvMTE4V3dJQ002dmpnUmRzV2hocy9YMytJekNm?=
 =?utf-8?B?RnlwVVVRTW1HcXl2VVBadDUwRmZDcmREZTVtL3k5cGxzd3lTMzZ1TmFacVh5?=
 =?utf-8?B?MGQzeU9YM2RyN1JVU2NEZ3hXNWIvcmk1MWlTMTBJUkhUSWs2bG5WQitHdEVG?=
 =?utf-8?B?TDR1MUtuak9VdnR6ME11V0ZkaHpBWnpvVUpIMW8yaXJ6QXVBWXVVUHhtK21V?=
 =?utf-8?B?RWhFVkVKbytwYWRZSG94bGtPNzBMNlJheFpnT1RtY01mOW9XUHRtZVV4Z2hU?=
 =?utf-8?B?Z2xmY2dtUlVmbkdJbUFZSkh2eDRSMDZXZS9kYUF2WXBpVGNJaXBvbDJDNHFF?=
 =?utf-8?B?Zzl1eGtCZUxkRWNJVVVuaEtabUtLUFFtRUtkYmZZcVFJWkRtOWJsbTJ3bDBr?=
 =?utf-8?B?aHBhcjFRNDMzM3NZb1FaemJoajlnek1IQW10VVhLWktnRGZLZ29LdnZ5aXNM?=
 =?utf-8?B?SFZHSExkcG5jZDV1TkN1eUowU3R6MzlUYnErbEdGOXdMVndHQ1ZudXYvNHhN?=
 =?utf-8?B?bnN4SGlHUWZ4VFloaWJxaU04Q1J6R0owMHRUNHRwaEJ0UTd0TDQwN3BPeG4z?=
 =?utf-8?B?NkJVOUVnVWRMZkMrSVdqNERmS25xQm4zMkp2TnlIZGZZZGVkRnJhTGRNU2Zs?=
 =?utf-8?B?OVpDWm1KdWJ4b2xNQzhUK1lHT1JoMnZuUU1XVWZXNGE2NTR3UjJvZnUrR21L?=
 =?utf-8?B?Kytqd0FnSFBpcVdQU3JDSk1NSkMvaTA4UWVDTnB2d0IrazdSOFNjcmJTb1Ex?=
 =?utf-8?B?b1hOdVhyUlcxZnphcWFCSVhJWmlxVHpaK1lxZ0hKbUhUeTlRamRqY0xkVXl6?=
 =?utf-8?B?dXJRdlhSUTl5bjlzVlR4bVBGOGRJT0w3Y0dEZEJnYzM1cTVUQVIyUi9wV2p3?=
 =?utf-8?B?S0ZYS3Y0RHlIRFI1UTRhOTBYQ0N1L1BKK0FGdW94SjdxQ1I3anM3UEhpa2NY?=
 =?utf-8?B?L3d1S2swT3hINXlKSVdrVHNBRzBENWlGMCs2Vk5mTm5jdnhyQ3ZrUStudEpG?=
 =?utf-8?B?c2UrRXFya01lWmx3RnkxNzFVM3NiV1htcDIyaWdCdlh0WDF5VEpDSzZ0UlBI?=
 =?utf-8?B?VG5sc3NkOURXd1BPeE52SjJDbnNWNGdjRCtCRFZrekVmQmNZREJrT0k4cHA5?=
 =?utf-8?B?NTlUWGI0WW5STzFFbzRQU1Y5cG1kM2NXNVliZEV3R1lMbkhSVGIzc1ZIOWQ3?=
 =?utf-8?B?b1hhb0RnRW1YQ2dmR2QzVWtXdStmVE5Hd0h2d2k1eFBady9jVEFPbVpxUC8x?=
 =?utf-8?B?cEgyNzR6MElqc0dCL3RQZGpZUjNQc3ZJaGI4eXIwRXZhRGgzN2ZMdE02UHU5?=
 =?utf-8?B?UHRqWGxqd1JNcUROM1ZqOU5FUEl6RVg4Znp4eERTakMzVHJFWXFDRmd0Tkx3?=
 =?utf-8?B?Wk44MHJla1JLY2phODczNlhGN3dPQUpidFgzOVZqQ2FabGY3cDlXT1RBVHRa?=
 =?utf-8?B?SGdSMUhNclNGNi9heXAzczJwWSs5VUJ5VWZ4enNWWVU5Qk1CSzBHRWZIMjhJ?=
 =?utf-8?Q?3RnxnUQlVbg0DdxdJA1+SiZoKumyk5Kv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0I5MHFmWktUQUh2KzNqVW5BbXRvVzRyS1d5UkNVTE1OeHp5alpqd3JZbzRG?=
 =?utf-8?B?a0VhdXR5czdjaENlTG5sdmVzTjFPZVNjRHl5TjBrNm90aDdESmhrNmhoNFN1?=
 =?utf-8?B?NUdNMnFCZmtuaUNTK1RPZTByNTA0dytrdCtyMnIrZVkzV3duMmpxcjg5OE9V?=
 =?utf-8?B?aEhUeFF4cFp3ZkUxdHEvNFBZS1Q1Z1BsTlFITGZtWGdYbDl3MnpBcEp4V00z?=
 =?utf-8?B?ZXVTL3EvaFFZQ0tONEk0b0ptNGRJTDhKYWQvd0FpQy8vWFA4amJmSGRmN0o3?=
 =?utf-8?B?R095ZGhSdkZOa0o5WHg1dlB6THZnekFXYkxTQXpEVWNFMWdqU2dnb3VLSnFz?=
 =?utf-8?B?QVB2TkJvUjFja2hvMUdiVlMyVHg0alE1SVVuaUpXRmZZUndNSm5iWFFZZDNw?=
 =?utf-8?B?TUJWK2lwZ3NRU3Zoemc0NVNyb2lpT0hkTWRra29BTDlRM2c0ZUxFY3cwSFFi?=
 =?utf-8?B?THA3RlVrdENZMC9pOEp4eXk5SGxheE5yVElWM2pUWk1Jb3BEeTA0OXd3M1R6?=
 =?utf-8?B?SmpibDhHT3BuZFVIWGxpb21XZ3dZTU90MU4wTFB1ZUxjR1R6cHlHUkt2eHBI?=
 =?utf-8?B?alhBZlNKa1JKRzFnRE9udEo1NlRnbXc5Z2ZiNGo2TDJsdklXU3pCQjNrcWky?=
 =?utf-8?B?WVZ0aXJkNnBUdWZ1LzU1L2J3VDlrNFRPeDBuMXkzd25FVnhyMVZpTTVDZEFy?=
 =?utf-8?B?Y2dWR2d5cnFSVnJrK20zWkE2ZXJPUFZUM2lXS2NYR0RFQVcrWllTY09rR0xN?=
 =?utf-8?B?cmlzWDJVREZFekkvZUx4dVNCeGNVNDEwNFMyN1VYTlpTVkFvT01LYlhkY1Jk?=
 =?utf-8?B?cEJUeittNTdoWkMwbm9XNGJ4ektUVHppMlhJZTF3K3grcjQzczUwSVJYdlk5?=
 =?utf-8?B?ajF3WEYvQko5SzVyY3M2dC9iQjRCazgxbmhFQjdic1k2bGZhNGFWYUd6SGN4?=
 =?utf-8?B?RVhNYS9XN0xyNzJoQnVUSmtYT3hWR3lkdFpLaXgrSC85ZEI3NkxUWm9scmNk?=
 =?utf-8?B?UEhIYmxGQmZZQmkzZXdua0RDdzZ0aHRaeVRLdy90MUZvL0kxYi8rN0xPTGg2?=
 =?utf-8?B?Z1dKMm9DaHZBeVJGZ1h2SGcwcUpuT2wxQnZLblBFWjV2TUJLWEtKTEJvN2Rv?=
 =?utf-8?B?TUxiU1hMNHp6RVhwYm1IMDJTb0RNOFVZNzZ1Um15dzY1bzNPOFNEN0p2NnNP?=
 =?utf-8?B?ZDhxOUZZTThUbUd1Y1FRTC9TNW9MR2t3NUZHbTJVOHNxSW5rblVzM0VDM1F5?=
 =?utf-8?B?Q1YrVVlWd1hRT1BhamMwazB4MG5hNWwrd2ozL2VHdGFJOTRtQkFERW0wSnhU?=
 =?utf-8?B?Z0tyT2xSQ1QrbGNYVWI5V3pOLzlvcE5xeXhuSGxpaGFjelhzemEyU2pFcysw?=
 =?utf-8?B?b1lCSzB1Q1AvUFFCVTBWSEpoSTllbW9XRXRaUWtmNFhpRWNuVjhMU3lZRDhy?=
 =?utf-8?B?TkJzbG1YNDBlR2RpTStWQkhHMmFWOElEbGkwVVlzSW5FQThXMGJvQ3Fpb2hy?=
 =?utf-8?B?Y2hLY1lhZlJTUGpGSGt1WTJpQVlreGI3UkhucGVOZDNDVXROUURleG9Sd2o0?=
 =?utf-8?B?YVM2TjF5dWlJbzhRblhyc2RFRVlBS3lwaFFZUjVGZnRDdjFVMG5RNWxHTUFR?=
 =?utf-8?B?VlNXcDErdlpGNkxQcFVIWVRDdzdhTVJaV0JpR2E5WHdNS1YwZkFseUZub3Ju?=
 =?utf-8?B?Rk5zTjZBYjFtS1ZKUjdBTjVqRDZkSGhJWUV2bEJIV0l2OHpCT2lyMlk3MWdx?=
 =?utf-8?B?ZkxpLzlxNVJkYmVkUXFGNU9yY0w4aTA5empqNGlsT2pjNmYwaTZQQzJ4N01I?=
 =?utf-8?B?dzJBRGF5MWhBUk93NzFQMUZLU0wxT08yWCs1ajlvcitkTzVBbzZRVzhuNEto?=
 =?utf-8?B?emNBZlJ5cG1VZmJMWWJNT05GM0JGSDZ5eUUxYnhrNUphZGJHQ3FteldYL2R3?=
 =?utf-8?B?b2pZVFZoanp0UHpla2JPZFNpa1JXRWxYMFNVSFp1UFpua2JxV0lxSFRISUxj?=
 =?utf-8?B?dTRGa1pCV3BEYXo2L0JTKy9mS1dra2NzbTQwNXZ6dkkvNDR4NDBvQ21wbEJZ?=
 =?utf-8?B?dDBHRlpKditFSVJLSjdDUFJUcStYb0JZMUFwcm5IeGdoaUhuVE8rcEFLUk1E?=
 =?utf-8?Q?Bl0nycPeV9BHsooZuDOBhmSCY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2894a2ce-641a-4aa9-a702-08de26944224
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 11:18:54.3587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7eKjqokM5zw236pKHWSnmevl6WU8oMY8MBlD8PXbVANcTYz0X4vgD0bogxv67qH3wtELvJglQkI6ZMGU3Faekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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


On 14/11/2025 7:49 PM, Stephen Hemminger wrote:
> Gcc-16 detects use of uninitialized variable.
> ./drivers/net/mlx5/linux/mlx5_ethdev_os.c: In function ‘mlx5_link_update’:
> ../drivers/net/mlx5/linux/mlx5_ethdev_os.c:539:15: warning: ‘*(long unsigned int *)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0>))’ may be used uninitialized [-Wmaybe-uninitialized]
>    539 |         ret = !!memcmp(&dev->data->dev_link, &dev_link,
>        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    540 |                        sizeof(struct rte_eth_link));
>        |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/mlx5/linux/mlx5_ethdev_os.c:515:29: note: ‘*(long unsigned int *)((char *)&dev_link + offsetof(struct rte_eth_link, <U38c0>))’ was declared here
>    515 |         struct rte_eth_link dev_link;
>        |
> 
> If the retry loop exits the code would do memcmp against uninitialized
> stack value. Resolve by initializing to zero.
> 
> Bugzilla ID: 1823
> 
> Fixes: 1256805dd54d ("net/mlx5: move Linux-specific functions")
> Fixes: cfee94752b8f ("net/mlx5: fix link status to use wait to complete")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Raslan Darawsheh <rasland@nvidia.com>


Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

