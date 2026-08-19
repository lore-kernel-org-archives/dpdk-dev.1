Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD18C5DF89
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 10:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 619F8402BA;
	Wed, 19 Aug 2026 12:57:44 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013011.outbound.protection.outlook.com
 [40.107.162.11]) by mails.dpdk.org (Postfix) with ESMTP id EEC4D40041
 for <dev@dpdk.org>; Wed, 19 Aug 2026 12:57:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ydi8NNiwrO+oaImW2v877keBF8AkgdCDxxQ6V6+yTy5lRDNx2JXZ5Je/FvRixBE0ZI4NvnVAMIsTk25dtBPEELISTQebXEaDpFgTurSi04BhOoLPEgWhJHXiZdnyqU/co32kUONMxXSVZNK3nuWsmBs7Y0sY0KHKKW+t+TqZuKM7gRQvtfknj8JVg2S6xFZXlMPq6DKvZ7j0lihVDQxaB2OgP0K3vSZnAQneYzg7y60oOX10DmKAVoTuvn8Of38qrFKaApCJQAtzwRGDSXRLEXAgB9pnDz1Sr3WF/XPfXChYCmJpGZ4Fg0UXBeBbX+BzGzWjvnKcwFzxeN7wSPBPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TILMLEUHa8G3LEQyXDt33sNnON2pSRl56GUfMES4L/0=;
 b=hV8ekng2EdkjEe/826YP1C3eJx6rXhLbjHN/XxqNOgB3F3xjP7pcfrhpZelXGl5JPGVABnyeqNY4ZL7EEJ1L23t1L7B1DoWMKTSnH66dWigMWB3bbw8r08anQiOqhXivsfBp/VmLoHUF7XDkagHQsV9YY71Z9aDJ7E5lSxLWkvGsuK5S3s0SpozSegnzNTJQe/njBdGfr95PlpSB4YeXLWWZk5d4hyLs/+eZTAN398Npqrwy5TGacOpF0KUCUPCo5Vzx7IabqoftHpqwdq0WulqW933hk+NcIdX+tFJgakNvgM60wN2IMQzfQlngwIkJA63HIG2Up/lYhVxc4tKerQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TILMLEUHa8G3LEQyXDt33sNnON2pSRl56GUfMES4L/0=;
 b=LNwdg/4z/2pCgIKFMABYjI1wJJKoUUsSyx6YLoHsROY3CUZq+faV+6sDj7qRwnHIZ1eIQOQJvtiB8Db+DS6pnLEqnGk5LE7gSf4vzu2ycvGgXDeOhI9HFI1ljBh4tv6D9M6UkZyUUgtieEjKjrqH6xeF4uzVzqFePtzLHG5Dc0WSrI5tzRxGiu3F4RLC/lgR0Xmegrvsg/QncMkbMXFeOXilGL5JkpB4kSj3HWEAddHJG2p8sPKKq/N3QpxlUVUa6H7FwBP4cD6pVPgtbOCszMG1b88t6DWO6kSNmWJWE+ZDR6kipkYb0gVPQcHm7JkE1oq9Bo0FgjkrfqzE0w2Rgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by GVXPR04MB10133.eurprd04.prod.outlook.com
 (2603:10a6:150:1b2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:57:40 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:57:40 +0000
Content-Type: multipart/alternative;
 boundary="------------ll1VsbbeIbCwJFC4ILaQ0DPl"
Message-ID: <d45c32ff-2c3f-4163-9079-c61ef2cbaab9@oss.nxp.com>
Date: Wed, 19 Aug 2026 16:27:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/26] NXP DPAA driver fixes and enhancements
To: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
 <20260818072704.176b9dfd@phoenix.local>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260818072704.176b9dfd@phoenix.local>
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|GVXPR04MB10133:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c26311-9277-41de-e131-08defde0afe0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|23010399003|376014|56012099006|10067099003|3023799007|8096899003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Tgmkb5in9nF/CGRt7El+M9mlR/NoHwjChEd4OBq2qgFYbcxeCQCWYsjaIw1xeBap7P93V5ZlRwosabwxr4IRG+ryrvP5T/a1Gdx0rQhtCRYDhfWKgIx6Nve5R5usBiawbTk/pAIbrWCS+TlntzSlzUym6lPcqaR4UTuRp+PBG9sr8Q5+aDS7Se5VEGWjQWM15BlDqfx4BS/Wkve2QI/m0SzEFCXlZ/yNzGwffSVCIQ9QbsS9mEliBjXmbhvlB+TxJdsMcwOjQUKBuSfL9MAEY7znP993gtic7v+ZIkfmtgMuJtIbrBkjn+a0dadUnre4yfb0lOVUiGb9zqxrgdJX7Ku5LMGtqTVe9eA7cM4PR5n4a1W92LnSAXCVizcewwGmbMFh8Zkl97dF+mjgkppYHfzoDDUuuf5go7yXQr9hKlOCHtd6GDAGLehVc0V//HQhwdVvoivzpMm7ZevmCxusXZN/kLYRaMhcf76rcXLlfMTbLfcUFxgxy3dQq3fckeC+auC+5XOJNxxwS4nGSt5vvZ/qrBY8wS+cSGUMj7LHP4okBlziRLLppaeg0D6bvkzc18hPQLnELkmuY6UrAqsP5Raupp0LXlp/enftDToVU7BPsk6Pq055N6tkN/Uh3p9UtgUg+TnW8N6NjnR2SEpqdBDpzf2i2Lv3TB1JFiHeR48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(23010399003)(376014)(56012099006)(10067099003)(3023799007)(8096899003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEdlK005UGNwZGJBc3drKytNSjJWU0xybVU2TlZpWVpNV0huUFp1dmxlOEts?=
 =?utf-8?B?NzY0UXZRRldpa1IvdE5XVzRxOG9BMDhqaHZOYms1QUhBZW9mYTJNaEFUczRW?=
 =?utf-8?B?TmErZWJMMXRSR292d3YrZFJ1enk5eFFGSm14WkJmaHhQSkd5WFUvYkh3cWxo?=
 =?utf-8?B?RjFJMFBtYTE5ZllYSEpBTG1PaGw3cW9iZVFlcnpWYmpNd0pGRXBCeGQ4OUUz?=
 =?utf-8?B?UFYrU0lLWWdta1pIbmU5UmlsYVVKbXlSWHJDaHBSTE5mbDE3OTN5RzhiNFdj?=
 =?utf-8?B?SnNCUVRiMndpM2ZWamRmYktheS9ITzk5SjYwdUtKQzdvRmlhRHNzZUpLc1lN?=
 =?utf-8?B?eVdoU0FWVEY5V3BXSFJzVFVuZmwzYXVTTUNXdWs3dFF2R244eVM2dzB4RjRK?=
 =?utf-8?B?N2V4NkhleGpINTNVZHBPR29hZVZrMUlsbHh1eHFxdEh6VndLU204c1k0aWFm?=
 =?utf-8?B?ZHF3V1R1d2theE5nNVgrK2F6L285VTZvekw4V09XaXJiQis0WTdDdU45RWlq?=
 =?utf-8?B?dXl2TkdRbkROdng1Ynk5UVFWMXFTcWFxZm5XZ1JlcXR1WitmblFWcXplWlh2?=
 =?utf-8?B?OXozazE1WFp4N1NwNnA0TjJFdmhLeHVDcEN3Zk0zQjVBVUFWc2NwaWpIejd2?=
 =?utf-8?B?cmd5RUhab2tBN1VqZUdGQlpHbEEwUGhaMFpCS3pTNnNJeXdKS2Z1bk1KZVUr?=
 =?utf-8?B?SzJidzZBRk1FaWxTdDlLeHlsUGw0aGptMGJzQTYvdW0xTWtVVC9lM0Z6WHZi?=
 =?utf-8?B?VmUrcS9aVlpsbGFSSEM5aHFLeDZaVUJwUHhLT3B2R1pUYndVY3ZRMG1yOWtF?=
 =?utf-8?B?ZVhBQlJWdVJZQk1TckV2VkxUcDdndHF2MHplQjBsRm8wOXJuNEQ0SFR6NFZJ?=
 =?utf-8?B?Qnd2ZlFGcWMyRTJtekpNUGxiQXg1MTVWYTZ2WTNrNnBzN29Ka1dSK294SWdE?=
 =?utf-8?B?ZFBscFBHZ1ByWnZHMzlZQ0gzNy8wRUhEWGhIVExCR3c5SWltcU5iWDRuUTF2?=
 =?utf-8?B?N0VzSHR0azBHcjZkKzF2NEFyZkJwR3F3bjNoVVYxRUZpVFZpOEtiRlBLVHpy?=
 =?utf-8?B?bWNxRmxzenAvYzJha2x3UE9xL2tNYXJ0SkJISUNxTXlDZ2R4ZHRUVGpOc3U0?=
 =?utf-8?B?ZUV0NGdnMlBjMDN6Q2VDdVd2OWFFR1A5SXlwVGNyRXNTSE9kSVdxYWN6MTdC?=
 =?utf-8?B?VzlqVkZ2SnJlelFVd2RXdTJsTlNFdG1oQ0dsTENJOWdScktFTU1UbHI5UEFy?=
 =?utf-8?B?cTFoUzZIRW1mY0VMWkpub1l3RGJzNHk5VDR5aTFreXJzRFgreGQ4ZzJ0Qkw3?=
 =?utf-8?B?UFM3SFZBZUJlTjFlZlJjOEVYWExXSTZrR0c1OGQ3dHBHWjVXSHFUYXdmOHE1?=
 =?utf-8?B?bEpoMjUyVVd6RDd2NytVOTBxeCtFNS84QXMvZXBQTUxWSU9WUHNWdEVQZUNh?=
 =?utf-8?B?d1BGRWpoMGlCSEhWR0ZLWFg1U2RLQU1JL3p5cDFNQ095NHVDQm9LVWdZNzhQ?=
 =?utf-8?B?S0xyY1BCb25DanVIdHJRZWdPMVR0YjJ3TEJ4NXM1YS9JcFNFRTN2R2hMTHR3?=
 =?utf-8?B?Rmw0aTVlRDFUWjNLOWVhcjBqakpaS2ZRZnNkK0lsQmMxOFd1U3FMWXFtYTg0?=
 =?utf-8?B?VklVNGpIZHFsUitZbDFWMlFKdHg5RXFac2FDK3V0MmNvN1o2c2grZjJGV3l1?=
 =?utf-8?B?ZzVjdE5HTEJ3czlVU3dxYlZJc0huaU44czF3Ym5SQlN6RlU4RnMzL045aXJu?=
 =?utf-8?B?ZlZNSm1JUkpxaHhnelZNL09hdUdIaTE3Z1ZvSEFCZlF5TE4rSFZBOTdQblc1?=
 =?utf-8?B?cGx6UWJaaWU0eUYzb29BeUVzNXpXMHMzYTlKb01WM0ZrbDBvTHV0bnpVN3hT?=
 =?utf-8?B?R3FVZWVHejNOb09CSzh0RW5KQUJMcWVJK1hTTDJQbUM0TEY2TVIzRnl4SlVI?=
 =?utf-8?B?ejVJOVRMQkxyZjEwc1Z0OWUzbFA5am40eHBlcHkyNDU2SUJXU0k3Lzg0MnRl?=
 =?utf-8?B?eDl5YjVXWk4xLzJuNEd5M2VYMkZDM3JGdW9jK2dnNFRkQlV4Q0IxTWZ2MkVn?=
 =?utf-8?B?RG14cWhDQUNKOUN0SDBtUWZuMnNJdnN4NHZ5a1FiSFdNbW1aZjAzL1FZOGhv?=
 =?utf-8?B?Ym1JaUVXVUdiU0V3OVFWR2R1WTBWWkZWYXM5U2YxK3ZoU1Jwc3VXWVNDdXdm?=
 =?utf-8?B?NzFucFFwVzBtZFVDdk94eDRTNVZXNXhhOU93M1llaWhDa01RSk9vb2FIZ0JB?=
 =?utf-8?B?Rzh4ajZHWWRtaDR2RXFHTWdqakVLcWpFVFM1YWRZNmpPcENPdjRzTHBtVjY0?=
 =?utf-8?B?SWlYYVptbVZaQTRzYktZTGJiejdBaFliWVJMVHNLd3RrbTdHSGtEa0FPd2ZP?=
 =?utf-8?Q?l1WKrgZ2rYIvcojM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c26311-9277-41de-e131-08defde0afe0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:57:40.3140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSpqs9B1pvu7tLQwbN7lUtmZe/mBtKitn+RCGxGgcIbpz1MbtAthwUDYDha6xqGKd3Hirub6GYWB7fx2GLkSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10133
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

--------------ll1VsbbeIbCwJFC4ILaQ0DPl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18-08-2026 19:57, Stephen Hemminger wrote:
> On Tue, 18 Aug 2026 16:47:04 +0530
> Hemant Agrawal<hemant.agrawal@nxp.com> wrote:
>
>> This series contains a collection of fixes and enhancements for the NXP
>> DPAA bus, mempool, dma, crypto and net drivers. It addresses several
>> resource cleanup and shutdown issues, adds new offline (O/H) port device
>> support, and introduces a number of performance and usability
>> improvements.
>>
>> Highlights:
>> - Fix device remove, Tx confirmation queue leak and FQD dest wq decoding.
>> - Add process-type guards for secondary process and improve FQ shutdown
>>    and cgrid cleanup handling.
>> - Add offline (O/H) port device support with a new PMD-specific API.
>> - Add Tx rate limiting API, Rx/Tx taildrop threshold devarg, fmcless rxq
>>    number devarg and non fmX-macY shared Ethernet name support.
>> - Optimize FMAN deconfig, FMC MAC type parsing and buffer pool
>>    operations.
>>
>> v11 -> v12:
>> - fixed recent AI review comments
>
> There are still more AI review comments to address here:
>
> Reviewed the v12 series (26 patches) applied on c1a46b9.  Series
> applies cleanly with git am.  This is a source review of the applied
> tree; I did not build it this time.
>
> All the blocking items from v11 are addressed.  Thanks for splitting
> the FQD decoding fix out into its own patch.  What is left is mostly
> commit messages that describe something other than what the patch
> does, plus the offline port driver and the destructor patch.
>
> Fixed since v11
> ---------------
>
>    - FQD dest_wq decoding is now patch 03 with a Fixes: tag and
>      Cc:stable@dpdk.org.  The wq/channel split is correct.
>    - BMI Tx counters are enabled and reset via fmbm_tstc, so the four
>      new tx_* xstats will actually count (patch 10).
>    - rte_pmd_dpaa_port_set_rate_limit() guards with is_dpaa_supported()
>      and always opens the Tx port (patch 16).
>    - dev_init error paths delete every created CGR before freeing
>      cgr_rx/cgr_tx and release the CGRID range, tracked by nb_rx_cgr /
>      nb_tx_cgr and the *_cgrid_allocated flags (patch 08).
>    - qman_enqueue_multi_orp() now writes all frame data, then lwsync(),
>      then the verb bytes, then dcbf, matching qman_enqueue_multi()
>      (patch 17).
>    - dpaa_eth_rx_queue_bp_check() checks vsp_bp[0] before dereferencing
>      it, and dpaa_port_vsp_configure() has the DPAA_VSP_PROFILE_MAX_NUM
>      bound back (patch 22).
>    - dpaa_create_device_list() no longer returns before creating the OL
>      device, and dpaa_ol_remove() releases queues, closes the fd and
>      releases the port (patch 23).
>    - rte_pmd_dpaa_oldev.h has Doxygen throughout and the two API structs
>      are prefixed (patch 23).
>
> Errors
> ------
>
> Patch 23/26: drivers: add offline (O/H) port device support
>
>    All four OL exports still carry 25.11:
>
>        RTE_EXPORT_EXPERIMENTAL_SYMBOL(
>                rte_pmd_dpaa_ol_set_classif_info, 25.11)
>        RTE_EXPORT_EXPERIMENTAL_SYMBOL(
>                rte_pmd_dpaa_ol_reset_classif_info, 25.11)
>        RTE_EXPORT_EXPERIMENTAL_SYMBOL(
>                rte_pmd_dpaa_ol_set_lgw_info, 25.11)
>        RTE_EXPORT_EXPERIMENTAL_SYMBOL(
>                rte_pmd_dpaa_ol_reset_lgw_info, 25.11)
>
>    The series targets 26.11; patch 26 adds to release_26_11.rst and
>    patch 16 uses 26.11 correctly.
<fixed it in v13>
>    Only queue index 0 is ever initialized.  dpaa_oldev_init() sets
>
>        /* num_fqs is DPAA_DEFAULT_NUM_PCD_QUEUES */
>        dpaa_intf->nb_rx_queues = num_fqs;
>        dpaa_intf->nb_tx_queues = num_fqs;
>
>    but calls dpaa_ol_rx_queue_init(&rx_queues[0], 0) and
>    dpaa_ol_tx_queue_init(&tx_queues[0], 0) only.  dpaa_ol_dev_info()
>    reports the full count in max_rx_queues/max_tx_queues, so an
>    application that configures queue 1 gets a zeroed qman_fq, and
>    dpaa_ol_tx_queue_setup() passes fq_info.tx_fq_id = 0 to the kernel
>    ioctl.  Either initialize all num_fqs queues or advertise 1.
<this is false positive;  dpaa_ol_dev_info based 
max_rx_queues/max_tx_queues are being assigned from 
dpaa_intf->nb_rx_queues and nb_tx_queues only; so oldev will only report 
max queue as 1>
>
>    dpaa_ol_dev_close() is still a bare "return 0".  All the cleanup
>    lives in dpaa_ol_remove(), so an application that calls
>    rte_eth_dev_close() without removing the device leaves the FQs live
>    in hardware and the rx/tx queue allocations in place.
<fixed it in v13>
>
> Warnings
> --------
>
> Patch 02/26: net/dpaa: fix Tx confirmation queue memory leak
>
>    The free is placed after the early return for offline ports:
>
>        if (fif->mac_type == fman_offline_internal ||
>            fif->mac_type == fman_onic)
>                return 0;
>        ...
>        rte_free(dpaa_intf->tx_conf_queues);
>
>    so for those two MAC types the leak the commit message describes is
>    still there, along with rx_queues, tx_queues, cgr_rx, cgr_tx and
>    fc_conf.  The early return predates the series, but patch 23 makes
>    offline ports a lot more interesting, so it is worth fixing here or
>    in a follow-up.
<fixed it in v13>
> Patch 08/26: drivers: add DPAA cgrid cleanup support
>
>    qman_pending_fq_by_cgrid() walks the FQID space from 1 upward, one
>    qman_query_fq_np() per FQID plus a qman_query_fq() for every FQ not
>    in OOS state, and stops only when QMan answers -ERANGE.  It is called
>    from dpaa_cgr_stale_fq_cleanup() once per CGR, and that in turn is
>    called once per Rx queue and once per Tx queue in
>    dpaa_eth_dev_close().  Worse, the caller loops:
>
>        while (qman_pending_fq_by_cgrid(cgrid, &fqid) == 0)
>
>    and each call restarts the scan at fqid = 1, so N stale FQs cost N
>    full scans.
>
>    The cgrd.i_bcnt idle check keeps this off the clean-shutdown path,
>    which is the common case, but the situation this code exists for is
>    precisely the one where the CGR is not idle.  Consider passing a
>    start FQID into the function so the caller can resume the scan, or
>    querying the congestion state once and walking only the FQs this
>    process knows about.
<fixed it in v13>
> Patch 13/26: drivers: release DPAA bpid on driver destructor
>
>    rte_dpaa_bpid_info is freed once no pool holds it:
>
>        for (i = 0; i < DPAA_MAX_BPOOLS; i++)
>                if (rte_dpaa_bpid_info[i].mp)
>                        break;
>        if (i == DPAA_MAX_BPOOLS) {
>                rte_free(rte_dpaa_bpid_info);
>                rte_dpaa_bpid_info = NULL;
>        }
>
>    but every Rx queue still holds a copy of that pointer in
>    fq->bp_array (dpaa_ethdev.c and dpaa_oldev.c both do
>    "rxq->bp_array = rte_dpaa_bpid_info"), and dpaa_eth_queue_rx() /
>    dpaa_rx_cb() reinstall it:
>
>        if (unlikely(rte_dpaa_bpid_info == NULL &&
>                     rte_eal_process_type() == RTE_PROC_SECONDARY))
>                rte_dpaa_bpid_info = fq->bp_array;
>
>    The array is rte_zmalloc'd, so it is shared.  A primary that frees
>    its last mempool while a secondary still has ports open leaves the
>    secondary reinstalling a dangling pointer on the fast path.  Freeing
>    it only from the destructor, or refcounting against open ports rather
>    than against live mempools, would avoid this.
>
>    The "if (!rte_dpaa_bpid_info) return;" guard is below the block that
>    already dereferenced rte_dpaa_bpid_info, so it does not protect
>    anything.
<fixed it in v13>
>
> Patch 14/26: dma/dpaa: add SG data validation and ERR050757
>
>    The commit message describes work the patch does not do.  SG support
>    and the ERR050757 workaround both already exist upstream;
>    fsl_qdma_enqueue_desc_sg() and the sdf->ssen/sss/ssd programming are
>    pre-existing.  What this patch actually adds is three devargs to turn
>    those off, plus a gate on the existing data-validation helper.  The
>    body should say that.
>
>    s_sg_enable, s_data_validation and s_pci_read are file-scope statics
>    written from per-device devargs in dpaa_qdma_init().  With more than
>    one QDMA device the last one probed silently sets the behaviour for
>    all of them.  These belong in struct fsl_qdma_engine.  (s_hw_err_check
>    has the same problem already, so this is three more of the same.)
>
>    s_data_validation, s_sg_enable and s_pci_read are int used purely as
>    booleans; s_hw_err_check next to them is already bool.
<fixed it in v13>
> Patch 15/26: net/dpaa: support Rx/Tx taildrop threshold devarg
>
>    The getenv is kept as a fallback:
>
>        if (dpaa_get_devargs_int(dev->devargs, DRIVER_TX_TAILDROP, ...)
>                ...
>        else if (getenv("DPAA_TX_TAILDROP_THRESHOLD"))
>
>    The point of the patch is to replace the environment variable with a
>    devarg.  Drop the getenv in the same patch, and note the removal in
>    the release notes if you are worried about existing users.
>
>    The new "Device Arguments" section in doc/guides/nics/dpaa.rst is a
>    bullet list where each item is a term followed by a description
>    paragraph.  A definition list reads better and produces better
>    output:
>
>        ``drv_rx_taildrop`` / ``drv_tx_taildrop``
>           Configure the Rx / Tx frame queue taildrop congestion
>           threshold.  A value of ``0`` disables taildrop.
> Patch 17/26: bus/dpaa: orp queue create and burst enqueue
>
>    Still no consumer.  qman_enqueue_multi_orp() has no caller in the
>    tree, force_ooo is only ever set false in qman_create_fq(), and the
>    ORP_RWS_WIN_*, ORP_AUTO_ADVANCE_* and ORP_LATE_ARRIVE_* enums added
>    to fsl_qman.h are unreferenced.  The subject says "orp queue create"
>    but there is no create path in the diff.  Please land this with the
>    code that uses it, or hold it until that code is ready.
NXP customer applications use it.
> Patch 20/26: bus/dpaa: optimize DPAA multi-entry buffer pool operations
>
>    The commit message says the first descriptor is initialized and
>    copied to the remaining entries.  The code does the reverse: entry 0
>    is written on its own precisely because copying it would trip the
>    valid bit, and entries 1..n-1 are the ones memcpy'd.
>
>        r->bufs[0].opaque = bm_bufs[0].opaque;
>        if (num > 1)
>                memcpy(&r->bufs[1], &bm_bufs[1],
>                       sizeof(struct bm_buffer) * (num - 1));
>
>    BIT_SIZE, MAX_U48, HI16_OF_U48, LO32_OF_U48 and U48_BY_HI16_LO32
>    move from bman.c file scope into fsl_bman.h, where they are now
>    visible to everything that includes it, with no BM_ or RTE_ prefix.
>    BIT_SIZE in particular is generic and is wrapped in #ifndef, so it
>    will silently pick up somebody else's definition rather than warn.
>
>    U48_BY_HI16_LO32() shifts hi left by 32 with no cast:
>
>        #define U48_BY_HI16_LO32(hi, lo) \
>                (((hi) << BIT_SIZE(uint32_t)) | (lo))
>
>    The one caller declares hi as uint64_t so it is fine today, but as a
>    header macro it will be undefined behaviour the first time somebody
>    passes a 32-bit value.  Cast inside the macro.
fixed
> Patch 21/26: bus/dpaa: improve log macro and fix bus detection
>
>    The subject promises a bus detection fix that is not in the patch.
>    Both access(DPAA_DEV_PATH1/2) checks exist upstream unchanged, and
>    DPAA_DEV_PATH1/DPAA_DEV_PATH2 were already defined ahead of both.
>    The only change is moving the two #defines to the top of the file.
>    The commit body mentions only the log macro conversion, which is
>    what the patch does.
>
>    The conversion is also incomplete: 12 DPAA_BUS_LOG() call sites
>    remain, including two in the function the patch edits
>    (rte_dpaa_bus_scan) and three in netcfg_layer.c.
fixed
> Patch 23/26: drivers: add offline (O/H) port device support
>
>    rte_pmd_dpaa_oldev.h is installed as public API (it is in the
>    headers list in meson.build) and still puts unprefixed names in the
>    application namespace:
>
>        MAX_NUM_PORTS, MAX_NUM_SUBNETS
>        struct ip_pair_s, struct lgw_subnet_s
>        DPA_ISC_IPV4_ADDR_TYPE, DPA_ISC_IPV6_ADDR_TYPE
>        DPA_ISC_IPV4_SUBNET_TYPE, DPA_ISC_IPV6_SUBNET_TYPE
>        DPDK_CLASSIF_*, DPDK_TELECOM_*
>
>    MAX_NUM_PORTS is the one that will actually bite; plenty of
>    applications define that themselves.  The DPDK_ prefix is worse than
>    none since it implies these are project-wide.  Please give everything
>    in this header the rte_pmd_dpaa_ / RTE_PMD_DPAA_ prefix you already
>    used for the two structs.
>
>    struct dpaa_ip4_addr_s holds uint32_t ip_addr[4] and is used for v6
>    addresses too, so the ip4 in the name is misleading.
fixed
>
>
--------------ll1VsbbeIbCwJFC4ILaQ0DPl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 18-08-2026 19:57, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">On Tue, 18 Aug 2026 16:47:04 +0530
Hemant Agrawal <a class="moz-txt-link-rfc2396E" href="mailto:hemant.agrawal@nxp.com">&lt;hemant.agrawal@nxp.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This series contains a collection of fixes and enhancements for the NXP
DPAA bus, mempool, dma, crypto and net drivers. It addresses several
resource cleanup and shutdown issues, adds new offline (O/H) port device
support, and introduces a number of performance and usability
improvements.

Highlights:
- Fix device remove, Tx confirmation queue leak and FQD dest wq decoding.
- Add process-type guards for secondary process and improve FQ shutdown
  and cgrid cleanup handling.
- Add offline (O/H) port device support with a new PMD-specific API.
- Add Tx rate limiting API, Rx/Tx taildrop threshold devarg, fmcless rxq
  number devarg and non fmX-macY shared Ethernet name support.
- Optimize FMAN deconfig, FMC MAC type parsing and buffer pool
  operations.

v11 -&gt; v12:
- fixed recent AI review comments
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

There are still more AI review comments to address here:

Reviewed the v12 series (26 patches) applied on c1a46b9.  Series
applies cleanly with git am.  This is a source review of the applied
tree; I did not build it this time.

All the blocking items from v11 are addressed.  Thanks for splitting
the FQD decoding fix out into its own patch.  What is left is mostly
commit messages that describe something other than what the patch
does, plus the offline port driver and the destructor patch.

Fixed since v11
---------------

  - FQD dest_wq decoding is now patch 03 with a Fixes: tag and
    Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@dpdk.org">stable@dpdk.org</a>.  The wq/channel split is correct.
  - BMI Tx counters are enabled and reset via fmbm_tstc, so the four
    new tx_* xstats will actually count (patch 10).
  - rte_pmd_dpaa_port_set_rate_limit() guards with is_dpaa_supported()
    and always opens the Tx port (patch 16).
  - dev_init error paths delete every created CGR before freeing
    cgr_rx/cgr_tx and release the CGRID range, tracked by nb_rx_cgr /
    nb_tx_cgr and the *_cgrid_allocated flags (patch 08).
  - qman_enqueue_multi_orp() now writes all frame data, then lwsync(),
    then the verb bytes, then dcbf, matching qman_enqueue_multi()
    (patch 17).
  - dpaa_eth_rx_queue_bp_check() checks vsp_bp[0] before dereferencing
    it, and dpaa_port_vsp_configure() has the DPAA_VSP_PROFILE_MAX_NUM
    bound back (patch 22).
  - dpaa_create_device_list() no longer returns before creating the OL
    device, and dpaa_ol_remove() releases queues, closes the fd and
    releases the port (patch 23).
  - rte_pmd_dpaa_oldev.h has Doxygen throughout and the two API structs
    are prefixed (patch 23).

Errors
------

Patch 23/26: drivers: add offline (O/H) port device support

  All four OL exports still carry 25.11:

      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_set_classif_info, 25.11)
      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_reset_classif_info, 25.11)
      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_set_lgw_info, 25.11)
      RTE_EXPORT_EXPERIMENTAL_SYMBOL(
              rte_pmd_dpaa_ol_reset_lgw_info, 25.11)

  The series targets 26.11; patch 26 adds to release_26_11.rst and
  patch 16 uses 26.11 correctly.
</pre>
    </blockquote>
    &lt;fixed it in v13&gt;
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
  Only queue index 0 is ever initialized.  dpaa_oldev_init() sets

      /* num_fqs is DPAA_DEFAULT_NUM_PCD_QUEUES */
      dpaa_intf-&gt;nb_rx_queues = num_fqs;
      dpaa_intf-&gt;nb_tx_queues = num_fqs;

  but calls dpaa_ol_rx_queue_init(&amp;rx_queues[0], 0) and
  dpaa_ol_tx_queue_init(&amp;tx_queues[0], 0) only.  dpaa_ol_dev_info()
  reports the full count in max_rx_queues/max_tx_queues, so an
  application that configures queue 1 gets a zeroed qman_fq, and
  dpaa_ol_tx_queue_setup() passes fq_info.tx_fq_id = 0 to the kernel
  ioctl.  Either initialize all num_fqs queues or advertise 1.</pre>
    </blockquote>
    &lt;this is false positive;&nbsp; d<span style="white-space: pre-wrap">paa_ol_dev_info</span>&nbsp;
    based&nbsp;&nbsp;<span style="white-space: pre-wrap">max_rx_queues/max_tx_queues</span>&nbsp;are
    being assigned from&nbsp;<span style="white-space: pre-wrap">dpaa_intf-&gt;nb_rx_queues and nb_tx_queues only; so oldev will only report max queue as 1&gt;</span>
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">

  dpaa_ol_dev_close() is still a bare &quot;return 0&quot;.  All the cleanup
  lives in dpaa_ol_remove(), so an application that calls
  rte_eth_dev_close() without removing the device leaves the FQs live
  in hardware and the rx/tx queue allocations in place.</pre>
    </blockquote>
    &lt;fixed it in v13&gt;
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">

Warnings
--------

Patch 02/26: net/dpaa: fix Tx confirmation queue memory leak

  The free is placed after the early return for offline ports:

      if (fif-&gt;mac_type == fman_offline_internal ||
          fif-&gt;mac_type == fman_onic)
              return 0;
      ...
      rte_free(dpaa_intf-&gt;tx_conf_queues);

  so for those two MAC types the leak the commit message describes is
  still there, along with rx_queues, tx_queues, cgr_rx, cgr_tx and
  fc_conf.  The early return predates the series, but patch 23 makes
  offline ports a lot more interesting, so it is worth fixing here or
  in a follow-up.
</pre>
    </blockquote>
    &lt;fixed it in v13&gt;
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
Patch 08/26: drivers: add DPAA cgrid cleanup support

  qman_pending_fq_by_cgrid() walks the FQID space from 1 upward, one
  qman_query_fq_np() per FQID plus a qman_query_fq() for every FQ not
  in OOS state, and stops only when QMan answers -ERANGE.  It is called
  from dpaa_cgr_stale_fq_cleanup() once per CGR, and that in turn is
  called once per Rx queue and once per Tx queue in
  dpaa_eth_dev_close().  Worse, the caller loops:

      while (qman_pending_fq_by_cgrid(cgrid, &amp;fqid) == 0)

  and each call restarts the scan at fqid = 1, so N stale FQs cost N
  full scans.

  The cgrd.i_bcnt idle check keeps this off the clean-shutdown path,
  which is the common case, but the situation this code exists for is
  precisely the one where the CGR is not idle.  Consider passing a
  start FQID into the function so the caller can resume the scan, or
  querying the congestion state once and walking only the FQs this
  process knows about.
</pre>
    </blockquote>
    &lt;fixed it in v13&gt;
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
Patch 13/26: drivers: release DPAA bpid on driver destructor

  rte_dpaa_bpid_info is freed once no pool holds it:

      for (i = 0; i &lt; DPAA_MAX_BPOOLS; i++)
              if (rte_dpaa_bpid_info[i].mp)
                      break;
      if (i == DPAA_MAX_BPOOLS) {
              rte_free(rte_dpaa_bpid_info);
              rte_dpaa_bpid_info = NULL;
      }

  but every Rx queue still holds a copy of that pointer in
  fq-&gt;bp_array (dpaa_ethdev.c and dpaa_oldev.c both do
  &quot;rxq-&gt;bp_array = rte_dpaa_bpid_info&quot;), and dpaa_eth_queue_rx() /
  dpaa_rx_cb() reinstall it:

      if (unlikely(rte_dpaa_bpid_info == NULL &amp;&amp;
                   rte_eal_process_type() == RTE_PROC_SECONDARY))
              rte_dpaa_bpid_info = fq-&gt;bp_array;

  The array is rte_zmalloc'd, so it is shared.  A primary that frees
  its last mempool while a secondary still has ports open leaves the
  secondary reinstalling a dangling pointer on the fast path.  Freeing
  it only from the destructor, or refcounting against open ports rather
  than against live mempools, would avoid this.

  The &quot;if (!rte_dpaa_bpid_info) return;&quot; guard is below the block that
  already dereferenced rte_dpaa_bpid_info, so it does not protect
  anything.</pre>
    </blockquote>
    &lt;fixed it in v13&gt;
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">

Patch 14/26: dma/dpaa: add SG data validation and ERR050757

  The commit message describes work the patch does not do.  SG support
  and the ERR050757 workaround both already exist upstream;
  fsl_qdma_enqueue_desc_sg() and the sdf-&gt;ssen/sss/ssd programming are
  pre-existing.  What this patch actually adds is three devargs to turn
  those off, plus a gate on the existing data-validation helper.  The
  body should say that.

  s_sg_enable, s_data_validation and s_pci_read are file-scope statics
  written from per-device devargs in dpaa_qdma_init().  With more than
  one QDMA device the last one probed silently sets the behaviour for
  all of them.  These belong in struct fsl_qdma_engine.  (s_hw_err_check
  has the same problem already, so this is three more of the same.)

  s_data_validation, s_sg_enable and s_pci_read are int used purely as
  booleans; s_hw_err_check next to them is already bool.
</pre>
    </blockquote>
    &lt;fixed it in v13&gt;
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
Patch 15/26: net/dpaa: support Rx/Tx taildrop threshold devarg

  The getenv is kept as a fallback:

      if (dpaa_get_devargs_int(dev-&gt;devargs, DRIVER_TX_TAILDROP, ...)
              ...
      else if (getenv(&quot;DPAA_TX_TAILDROP_THRESHOLD&quot;))

  The point of the patch is to replace the environment variable with a
  devarg.  Drop the getenv in the same patch, and note the removal in
  the release notes if you are worried about existing users.

  The new &quot;Device Arguments&quot; section in doc/guides/nics/dpaa.rst is a
  bullet list where each item is a term followed by a description
  paragraph.  A definition list reads better and produces better
  output:

      ``drv_rx_taildrop`` / ``drv_tx_taildrop``
         Configure the Rx / Tx frame queue taildrop congestion
         threshold.  A value of ``0`` disables taildrop.
</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
Patch 17/26: bus/dpaa: orp queue create and burst enqueue

  Still no consumer.  qman_enqueue_multi_orp() has no caller in the
  tree, force_ooo is only ever set false in qman_create_fq(), and the
  ORP_RWS_WIN_*, ORP_AUTO_ADVANCE_* and ORP_LATE_ARRIVE_* enums added
  to fsl_qman.h are unreferenced.  The subject says &quot;orp queue create&quot;
  but there is no create path in the diff.  Please land this with the
  code that uses it, or hold it until that code is ready.
</pre>
    </blockquote>
    NXP customer applications use it.
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
Patch 20/26: bus/dpaa: optimize DPAA multi-entry buffer pool operations

  The commit message says the first descriptor is initialized and
  copied to the remaining entries.  The code does the reverse: entry 0
  is written on its own precisely because copying it would trip the
  valid bit, and entries 1..n-1 are the ones memcpy'd.

      r-&gt;bufs[0].opaque = bm_bufs[0].opaque;
      if (num &gt; 1)
              memcpy(&amp;r-&gt;bufs[1], &amp;bm_bufs[1],
                     sizeof(struct bm_buffer) * (num - 1));

  BIT_SIZE, MAX_U48, HI16_OF_U48, LO32_OF_U48 and U48_BY_HI16_LO32
  move from bman.c file scope into fsl_bman.h, where they are now
  visible to everything that includes it, with no BM_ or RTE_ prefix.
  BIT_SIZE in particular is generic and is wrapped in #ifndef, so it
  will silently pick up somebody else's definition rather than warn.

  U48_BY_HI16_LO32() shifts hi left by 32 with no cast:

      #define U48_BY_HI16_LO32(hi, lo) \
              (((hi) &lt;&lt; BIT_SIZE(uint32_t)) | (lo))

  The one caller declares hi as uint64_t so it is fine today, but as a
  header macro it will be undefined behaviour the first time somebody
  passes a 32-bit value.  Cast inside the macro.
</pre>
    </blockquote>
    fixed
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
Patch 21/26: bus/dpaa: improve log macro and fix bus detection

  The subject promises a bus detection fix that is not in the patch.
  Both access(DPAA_DEV_PATH1/2) checks exist upstream unchanged, and
  DPAA_DEV_PATH1/DPAA_DEV_PATH2 were already defined ahead of both.
  The only change is moving the two #defines to the top of the file.
  The commit body mentions only the log macro conversion, which is
  what the patch does.

  The conversion is also incomplete: 12 DPAA_BUS_LOG() call sites
  remain, including two in the function the patch edits
  (rte_dpaa_bus_scan) and three in netcfg_layer.c.
</pre>
    </blockquote>
    fixed
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">
Patch 23/26: drivers: add offline (O/H) port device support

  rte_pmd_dpaa_oldev.h is installed as public API (it is in the
  headers list in meson.build) and still puts unprefixed names in the
  application namespace:

      MAX_NUM_PORTS, MAX_NUM_SUBNETS
      struct ip_pair_s, struct lgw_subnet_s
      DPA_ISC_IPV4_ADDR_TYPE, DPA_ISC_IPV6_ADDR_TYPE
      DPA_ISC_IPV4_SUBNET_TYPE, DPA_ISC_IPV6_SUBNET_TYPE
      DPDK_CLASSIF_*, DPDK_TELECOM_*

  MAX_NUM_PORTS is the one that will actually bite; plenty of
  applications define that themselves.  The DPDK_ prefix is worse than
  none since it implies these are project-wide.  Please give everything
  in this header the rte_pmd_dpaa_ / RTE_PMD_DPAA_ prefix you already
  used for the two structs.

  struct dpaa_ip4_addr_s holds uint32_t ip_addr[4] and is used for v6
  addresses too, so the ip4 in the name is misleading.
</pre>
    </blockquote>
    fixed
    <blockquote type="cite" cite="mid:20260818072704.176b9dfd@phoenix.local">
      <pre wrap="" class="moz-quote-pre">


</pre>
    </blockquote>
  </body>
</html>

--------------ll1VsbbeIbCwJFC4ILaQ0DPl--
