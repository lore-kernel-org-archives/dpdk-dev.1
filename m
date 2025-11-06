Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A8CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:06:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C30194021F;
	Thu,  6 Nov 2025 15:06:29 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66]) by mails.dpdk.org (Postfix) with ESMTP id 581484013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 15:06:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8VWhp62YTrD+UcAU1hcX98ZfDPGV09jZOP3br3amh1JfJVJivKVftBQSJlpYlBRqTZKbwqD3+6kyFX6jDGWbqmOQnVvBfbXsQq+aTZGIUmX0pK7YkS7pkoPgso0FFLGaQm2s0/HxM/WcQKwg2B5SKqeCGF8Lj26sxr7U8wtveEwO9ErypjTQms9hGe7CjZA6r7sizCOorRMfNLBu8a30U2FVs9NUntk5FMAzQ1myKJBDv6CiW2sl39RuB4lLkhUXMDJI3nbkbk6w2916824anUlMo447dBvlzBd2XQVE+qAm3RC0+cvNNkTHqo4UacT6lS/uVBJ/ymSaQtd+oUIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLnYsr2jrgD/QKfCofD3AusVom+2ag1nQ7HmKed9FFM=;
 b=MHwEcuK4n6WSLr8euvWIvKi6090QGHyHlc4lt74TBOFlH5mRJKw40UgrTbLARaKV7Ijds2+9DCt2gJsMI2Xy2bhbL6/40ISNHZywbxW81EURV9x/4OQImdXdWD1AsK8XHVDZnoLxFi33j+xFmfq3VPgOLffUhrdjAqr1SzOZKDRcxtCjDRlTGpE9O/jKlT/NJx2/y9b0S3apbYhpMTEc2uRnkhRSSMc+ATtiPeQnfDa1YON9xZoXab3L6tSKIlnPofxIOVuvtVytRpBuQGeoqRnuVP20a7Qhfu4eJ5jJldFU9pdeJo4/2bJv6ArSgnZPPte/2PjQLnRZNAZR76Qajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLnYsr2jrgD/QKfCofD3AusVom+2ag1nQ7HmKed9FFM=;
 b=Jwenpkjrk97M4mKWb1X07tiAvBPHpMZ9BQSRl0wW6OHyhHbhesykzYtuS5+02YDH8OPizB/g0q6F0tBSBAE+h0ghCceAmtfpk4cCCFgJ8nWwIAaRoTIc80sl9LUAi5UZcotIQJ8wMbnmhfWyJigUa4CgdKPxo+3Y6aeuslFPEvhhHZyhbg4E54hQEzQ7hChFPeAsdjjr9tnH+v7mScdlz8SZWIZamjJOA4EsTEODM3k6avtMSmvCJtdJrc0KKRoi+fH0lxgS1IeK8UmYLzQAfe0bN+b1f717xCJct9hvh7yfHuplBQXp8sTcJoRYoYqodbskLCBk8HgwAwXxy0EELw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 14:06:23 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 14:06:23 +0000
Message-ID: <6da33f09-717d-4336-a4a8-90195bc0ad42@nvidia.com>
Date: Thu, 6 Nov 2025 16:06:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document non-template API limitations on top of HWS
To: Maayan Kashani <mkashani@nvidia.com>, dev@dpdk.org
Cc: Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
References: <20251105085453.110587-1-mkashani@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251105085453.110587-1-mkashani@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To CH3PR12MB8460.namprd12.prod.outlook.com
 (2603:10b6:610:156::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8460:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d3c285-ffde-4148-affb-08de1d3dab04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0w2dmIrVUpnY0pXQ0RoTVhxT0pyN3lLc01GSVlNL2FKSkFZNitDemw1RWlI?=
 =?utf-8?B?WGtuMy9RNEp0OWIzdEEvWWw0QlQ4dHJLVFRjdStURzcwSlhtWUNFTWFrb2tV?=
 =?utf-8?B?eUFqTEJFSjR3VUYvNHByS1d5UnNIakNGSWI2R3YvOU5Ua3hhMVA4eXYvTVNp?=
 =?utf-8?B?SlpmK0lBNjdnUUplQ0RoczlJeXZwTkY1TCtJZzBhbVVhMXdaMmdlRm1rOHhM?=
 =?utf-8?B?SW9PODZQa2ZTSGtVOVhKZWZaQm04RFlONW1DQXdxOHRheGxsb3FTdU11bWdD?=
 =?utf-8?B?YmFXOVpvc3BRQnJ5Q3B3Q3ZPNlVaZkN4NXplQ3NpamxYa2M0UFluemtHRmxC?=
 =?utf-8?B?ekl1VW03WXlYaHBvQjgzS3NaWFh3WWNGT2NOYkMyOENnWGh0ZjJzRDl1bDNX?=
 =?utf-8?B?SDNqOWhWR2pwN3U5L2tXQm11T3U1djI5SDZjZUVYMktsRnpFWlMxSWVMeDVu?=
 =?utf-8?B?Zlc5KzZrbDRMZGdVZm5Rbk5Yc0ZuWHJZdmw0TjdKRG1ZeTc4RkZmNm1HT3pm?=
 =?utf-8?B?K3JwUUxuSEFYMFZ1S0o2UGsxaG5jNURKRUIrNGdsdzdNd1doeEhVR0o5M3ZP?=
 =?utf-8?B?eXZIbGNzcVg1RmhEUUNzVnNkazJIZDZTalRraitPSkdQZmYxMDBmT3M4cGt2?=
 =?utf-8?B?c3JrRjBqRE5WT09UOU50ejJVcXU3c0RHd0ovdXo3OXVZTU4ramVmQ3BZdy9p?=
 =?utf-8?B?a0tjMG45VHdjdXdvQXdNRWhwUnc4azhUUSt5L0I0anMyaXhZMWloTWF4dFZ3?=
 =?utf-8?B?TGVKR3phcFExN0JObEZXRnVGREM3aHZFWTRKeHVDdEw5TjI1c1NleGpTd04w?=
 =?utf-8?B?WCtTbGNMeXlVRGRoVWVMN0RWNm1CWkNQMERJL2VYYTdtOFQ5aHBJQkhYVWI5?=
 =?utf-8?B?WlROZUhtQXRWK1grM2JZNGYvODdnYXZIWHpSeDNaQkRBNGwrWjh5WWk2ajZn?=
 =?utf-8?B?aUowRlk1YlB6NVFEb2J3dlFYeFdSeExMWU16djVyL0NiNVRuZ3lZdGVmWUFE?=
 =?utf-8?B?NlBtYUxiZ3RweVJrT0RwN3phcExoNkFsZXpOZzFYb2ZkMGVRWGlzZTlDa2NT?=
 =?utf-8?B?SzkwalFVUi9KRXNQd0M5VGNVR2N6a3FjSGJ3TTZHSjJydkxDdGhHK0JGaWdM?=
 =?utf-8?B?eTdqY2QvQ3hCMXVFWFR4NnFtZTMydVNzWVB2RXpyVHUvZytyanNEY2FEVHFm?=
 =?utf-8?B?dWZwUlJCS2FtaDZ0K2VuM2FtNkNKOVNheXpVckc4NW93MHp0N0lSejYzenA3?=
 =?utf-8?B?TjA3VlBpTGZOWlNQT2tBLzByQks2N3E4ZUpZMFBDQ053YXJ1N01xL1FXQVc2?=
 =?utf-8?B?a3VRSElRQmdmcW1qOGlQV2liSklSY3lqaGt3Z1Nkb1IwL0hNWHJaWnc3blk4?=
 =?utf-8?B?MVd5NUJvZEM0aUJhdEFsRGQ2Z1hxdjJ4QVkzcnBrN0FjOVZrenQyMUhHR2hj?=
 =?utf-8?B?R2pKdUJKZWNSam1DT0RDSXA2RkM5b21oK0xLc3RPcXdZZVlpL1pIeUNpNlhj?=
 =?utf-8?B?WXA2aVJVWTZDSktJdU5URnNTcS94UzErc2pBWWFYWkZhY0RVZ1Jwc09Jbnd1?=
 =?utf-8?B?UC93SW1EQ1BGRVAvZE0vQndCMWlhY3loQnlMa0hkVnhLN2N1NXY0MXllUGN0?=
 =?utf-8?B?L2liQk4vQUhPcWl0MGYzZjZoK1lQNlJScmJNY0hlaFQ1RGpTa1lQckg2emNQ?=
 =?utf-8?B?R1FOdVBTeUFvcjJMRzR5b1V3eHhxZllJWFgzci95THBPeXkwMlI5QTJxaUxm?=
 =?utf-8?B?RTJtTTdYcWx3cUhnVnpqUGVaeHNuQ2tZay9tKzRLa2psSHpSSjBScWlwOTZW?=
 =?utf-8?B?UjZ4RGpUY1h5d1MxYklHM21HSlIwNzdsRUEwaGFmcWEzQ0ZIbGdtTzNQNlJP?=
 =?utf-8?B?UERhekptYVhTRGZiY2dONFRtaHRYaldHYnJic3JYWlJxSmdKQ2IwQW02dDFZ?=
 =?utf-8?Q?89nw4LS0JZPi2sIlIbJ0/vlbLbM0rwdX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUFJSlVWUkZrT29ycDIwTE5mdFZ1ejlBeFBGaEExajFSdjQ1ckpoU1ZsQWJ3?=
 =?utf-8?B?TFFBLzg5ZGNIWklPajVIZmcrMmVjMFliN0VEcGlKNnRXYmdkaFVxcGZnVUdh?=
 =?utf-8?B?OFhzdWZqdmJMMGZpaURiRTRCZGJjNmhxWVNxeU0zNG5vdmpJL3pXM0c1aHov?=
 =?utf-8?B?N3RQcXlrSWFKKy9kN0RaZ2tFMVVYa291bjIyUDFZOE1Md1oxQ2FlY0RGay9E?=
 =?utf-8?B?WWxPbTBKK0xwQWY5ajhZN0Zsb01rK29tOHVRY2duL0xpOVRLM0czR1ZMNEdO?=
 =?utf-8?B?d1pLV0daTm5RM2oxSEI1a1BOZEZDa21hWGN4R2NRT1BhOUV0K1JGdTV1SFla?=
 =?utf-8?B?OVhNQVJnbEJPdFptRFFRaGoxSm50QXFKdUZMUTRkbUFibTdOR2hQVU55YXN3?=
 =?utf-8?B?Mng4eE9PaWhzZmFyVnZRZXVuM2x0azRZZzJIMWJVVnhOVFo4YlhKamxoT0h2?=
 =?utf-8?B?QlIxemV1d3BWVWdOSm1vMzFDUHNLL1MyM0JrTWRKNmtkcmlvdWJkeStQWlcz?=
 =?utf-8?B?WElQZWR0NzFqUU5UUDRJV3dFbnVtZW05TDR1K2hWZTRCakJQZ2k1Qzl2YXVX?=
 =?utf-8?B?UlB4UHZqSjVJdDBIWEJKNmVKNTB6ZW1aazJrNWZuWnFuMUxTMjV4dno5T2g0?=
 =?utf-8?B?dzBJWjJlVndRVVV3bnFDTWlhcFE2TUdPbndnQTFCaUE4T1MrR09MNGxwVkVH?=
 =?utf-8?B?akxzWFpuTUtDNjljd014ZElhY1J0emJYbGMrbFljUmlmS1FnZjNnR3pXa25j?=
 =?utf-8?B?cWxIck45OTI4eXVEYlUzQjJQVVNLeFp0OURFUEx1M2pHaDlGbFZpSmRLOTd1?=
 =?utf-8?B?NllBRDMyblJMRlgvYUh4RWpUSzlPaDI4eUJrcXhNdDZUeDFUZlRZVVpqZ1BK?=
 =?utf-8?B?aEtYb2lFS3RjbEdOQkN3cTlpUjY1MUxnVWdpWkJpdnVUTjg0c0dpYUh1KzdW?=
 =?utf-8?B?TmxKNjM2Ryt4c2RBVlZCdDJBckxJK1lKamkzY1ZCdXlyOUxjTW9qOHVmTWNC?=
 =?utf-8?B?SVRXekRMaklPaGF3cFMzRXVZOHlGK0ZCUFFMbnB0Q2paNkpqWEQzcTc4Nmtx?=
 =?utf-8?B?VjI0Q3FiU3dWZHNEY2lxUzA3NFFIbnhIMHpqdmFRWG8wWEhMMlI3Y01nVzNh?=
 =?utf-8?B?NmxxeXczbmRwRExMN0xYaFpsZkRhbG4yUXJnMlAzM0h4TzBYdVNndXhPL3l0?=
 =?utf-8?B?NjcwMmN4MzRWTDZqa0I0R01uUzNJbEJyYzhMMzdtVDVQdW80UjZVMWlOaU04?=
 =?utf-8?B?WFVnR3lsYmFNMm8rWnMzN2thYUdvUldlaEtya003VThlYVRaUTZ1SForUXdl?=
 =?utf-8?B?T0huYUVYSU02RHVKVG1rQmFSbC85em5Zb2Mrd0k4QTNNeWdvb00zY2J4V0h0?=
 =?utf-8?B?dzl5R21tcTI5L2dmL3RYaGFJME1RVll0WXFpRXYyWW10N20zNStBUHB4UXVr?=
 =?utf-8?B?NGhjMUpZR1phSENOUU1jRW5LZm84aTF2ZWJPNldOZ29XZStVVThhN25xRWhU?=
 =?utf-8?B?VjdzdkJBU3VFaktpNC8ydFdoSFpGSGNtRGNIa0ttR1VLenNRQitRemFwWlh1?=
 =?utf-8?B?N1pib3ZudmhiaXdSZHcxQXVla1lTZzh4K3l3VmZYa0NFM1RVL3NpN3hZUys5?=
 =?utf-8?B?aVZYalJYRk5KcmdwMmNhU1lpeUg2cFpvaldWdThvZGMzdWdSaHNNTTJZSTY4?=
 =?utf-8?B?anc5M0NBVWFOcG93MDFnMVVmY3RTOE9VL3laaUV1Tis2aml2NG9BckZJRjIv?=
 =?utf-8?B?dkdsUnE0eEQ2QVloVEpReG81Z1hZR2xleERFNDBJVlJOWmRCU29SS0lSSlhi?=
 =?utf-8?B?VHYrVVFwOHlDRnhuVW9HMzhEMmpLaHFCVGZsajZDV2JYeGhjRC9idzJUS0pM?=
 =?utf-8?B?S1BqZHVQSUdHSmljdWZ2TFZiTk1UMlRSZ0ZRVkNOTkxHY2tJMTlGQjJJdGtk?=
 =?utf-8?B?T0lENTdFd1l0N0RUbVFmTUF6RzN0ZmtndGdVclFjQ21ZRnZoelBybU1hWS9P?=
 =?utf-8?B?bk1wYmZtUXI1YUJVT3Azc3B6RnpOSnBxaERyWmpZRkhLWGNOU0t6amZlL1Rq?=
 =?utf-8?B?dWMrY0hFOHY5YzJTckpQWERBakxMb1ZrWmRFOHZaZTk0bm9rK254eTUrUGNP?=
 =?utf-8?Q?2TeQEJXg/4FZfZyqH/CzWZMIa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d3c285-ffde-4148-affb-08de1d3dab04
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:06:23.6495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPhO+lFr5kNJ1v2oU/Cl4F9frX1ResgHapoInhD8byoduYekLW1YsPNdcrFpozgpIsIn6PTvkTj6FzlGrbTDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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


On 05/11/2025 10:54 AM, Maayan Kashani wrote:
> Enhance the documentation by adding information about limitations
> specific to the non-template API when used with Hardware Steering.
> This update provides users with a more comprehensive understanding
> of the constraints in this configuration.
> 
> Remove the previously stated limitation regarding the exclusive use
> of RTE flow asynchronous APIs.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>
> ---

Patch applied to next-net-mlx,
Kindest regards
Raslan Darawsheh

