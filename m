Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36729CA5FB8
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 17:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6359A40ED9;
	Tue, 20 Jan 2026 18:08:48 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by mails.dpdk.org (Postfix) with ESMTP id 9C53A40E0C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 18:08:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjMulrnkn8cRSGYvmQhyVxDFnskJyYKGYBHzwNHmxn6IuxIOF1R4W8aNAgsfzrvBJnsdHXHOlbdUObRU9+k3c1HjHlATbw1bXAWhukrlAa+JOfz5oeLDOPZ5r5iQ30rp4X4cAwo4GZZKUXmgJYnRKUSSviD/5CHr8THzrFOXcr0w4rMfm5xZX0kHtFHXE4LY96toGhf0QjGXZbajEyHlwLriXa8teLSy8UnaMNPUcxxBfZLLOWWJ+uPkq+XUvHs+8V9wQwHEovbWfs30sL0bTT36EcbQXdlnA0xeuil8Z3hLyhDU+7I8kajRvLd2vlEkmu+kJpPPBL3V7jP7WUn/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OH98ynT4r5V2OCdFT5jCL/Ths0ApPnyQtT6bjwCYZM=;
 b=Ax4gWzqG2hiBb3vekyp54wqYDfPGvBU4KUIaHHzV27CZKyODLl/SNQ5d09JBOvbnjtyNIobnqQG18+Yfh/EbPjO+A+hzui85SHSs5POU3ZbBDDdYl1kc/3gwpeEVVRdA+5ivM7qXhStVALY8OfFN02m7F/p4Rz5+lLEVR8O7z3i2wIXkMtVXeIaYYi8Ggw9576sxBZAzxQr+GKIXpm9wq/Z2sApFA0ni1KXg+i3vhecwCJtQODlLqWUZ7yfpzru2I4fjNideTVoDBKKdadMw2jModHa/JeoK6B0bAjw/L0f2AL0ANXSRBF9b2RuQ3UT7yO+u+pF+DB27AvGRpWY/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OH98ynT4r5V2OCdFT5jCL/Ths0ApPnyQtT6bjwCYZM=;
 b=CTXbs90hb/QVB18z9uGsIgdy7bc6RGibS9dQlXzy9ccOw+Urb3My5BxPysSB6TY8tXUvDO2ZxZDWt7BM7PF+3L8iN1rUNp5IMXMVv2JbBVpTU6IvejtNV3zEglGmRmI6GlcvbFEE4dfyHGImt7yXyd2gq+BHtlp806n3o0U9Lg/gibitKD/kHERRvAq5MQWwgACGdhTnM5prXE6Sa4cGNcS8bvqsSAzXULW8fHjQN9SSlpcNUlNyta6Vu7ffu9++1iPReq5w8dvTEWR3/p//zEkyfMGF+VZ+UjCYlbiRmdcnMFBw/4e2c96kOzCuVOj4MzBHMrWyA3yFHkTPdLqejg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 17:08:42 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:08:42 +0000
Date: Tue, 20 Jan 2026 19:08:35 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: "Etelson, Gregory" <getelson@nvidia.com>, 
 fengchengwen <fengchengwen@huawei.com>, andrew.rybchenko@oktetlabs.ru, 
 dev@dpdk.org, mkashani@nvidia.com, thomas@monjalon.net, 
 viacheslavo@nvidia.com, matan@nvidia.com
Subject: Re: [RFC PATCH v3] ethdev: support selective Rx data
In-Reply-To: <20260119083700.541fabfc@phoenix.local>
Message-ID: <81a0c0e9-048f-47b6-7025-9948cae7b9b1@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
 <20260106154554.40556-1-getelson@nvidia.com>
 <12514141-a489-4995-a8a7-e6d0fc28f841@huawei.com>
 <03a55b2d-2957-c8ab-3c3e-dc9d207fc273@nvidia.com>
 <20260119083700.541fabfc@phoenix.local>
Content-Type: multipart/mixed; boundary="8323329-1966462870-1768928921=:872928"
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc94dc4-f8b6-4e65-57c4-08de58468f8a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-15?Q?Jbxr5A/D4munHr9Z0qZa7uWST3tZYNxQHkUG5vc7qR7iA6MuHT0AoH0ME?=
 =?iso-8859-15?Q?5/NSzfKE4S/ZYYmas8hww7h+CIch2Xm2VoqbsIdVk8w4iZHDyqLgnaG4b?=
 =?iso-8859-15?Q?9WKwBZYUIg4I4Yt68bmGiNV7eBaFNml3wHxeQnCBuWEf1qsLk8Lli/T2V?=
 =?iso-8859-15?Q?dL5u6luLoQbFg5PYThmiY/KnxDk1TcqdRmonBkjHiPhPRyk3HmXHSrpsW?=
 =?iso-8859-15?Q?uLr9kkZY97LlMEaC0F3crp+G0IwSWasgseILGC/CAYMCM+S5T41fDeZPO?=
 =?iso-8859-15?Q?BN7vJajOuD5QjYanO+vkF/LzqSnrP41ze79iCZud3JAPzs6fPQQnCqD5Q?=
 =?iso-8859-15?Q?qihe6hRtbwbWBz70rxUH0eM4KUTa/5JdL5GqKPcA0bHLY+ACGvk8Pe4nG?=
 =?iso-8859-15?Q?Rl/3SUPFP0v1vZF/PwtpyF4o+yaznYfb4Vi0yhTf3bwip8EM8Gx9DP6wm?=
 =?iso-8859-15?Q?Nk11eBLyn9Qn+E7HFcdufTPlGAZOtkNR4kYRTRbw3d/u7V4Ox8ppyKm3H?=
 =?iso-8859-15?Q?r98n72RUonlgvUx4c8sTh6bLJ5eoFIz/jCotuptmbqvzcsniEvin2gEhD?=
 =?iso-8859-15?Q?qZfvWkBmWET6RxA8wLm/CUQWWMbEhrm5KgQ63O5Aq+ZP4dX+f18YM0TmI?=
 =?iso-8859-15?Q?oZIUT2isZ2MGWJhdmh4FJXkEydp/V2QPhK3smTE1clQ70HfqA2vaL7t4r?=
 =?iso-8859-15?Q?V5Mcog8jdDxaF9OxOunRJRB/Zxdq4xkCL6edhAUwpEo1pdz4aN5ilVLLT?=
 =?iso-8859-15?Q?YYeWpoDhFaGUZcRn1jCB3+JY+7hcl7/Mc5jPUonj6xhGe4Rkj6QlEEqhO?=
 =?iso-8859-15?Q?lr2VLnppZXhD4Qx0aF4lHMBGpJDCtAb8N1tcI0pdVY0CkLGXM9rrd34AG?=
 =?iso-8859-15?Q?VeQ0SObzGz3Fbm0x4IwdPIUR9FKCQondETqiwe1Gq8Kpb+1mjIHrZ1C8z?=
 =?iso-8859-15?Q?/fzRyV9wHzfXVmwX96P73ChHZIu78jMS7/Gb8yuz32nccfIUavVlYbeav?=
 =?iso-8859-15?Q?oJRoYkC7BVYAFLuOJEiviC0NLWfNJjqFFfSomE7E1DpiMkgevhk9ujjJo?=
 =?iso-8859-15?Q?xFjhaL3kRCAxUy1N829rnS0y1fkYAWm1oD4J5b0IoFfBD9ybazaNWgQ1p?=
 =?iso-8859-15?Q?150gHz24xdOBm8iQ6Zf24Snkhf8O2wQ6nuTa39TkFgNHKnyx5X1NR8SyR?=
 =?iso-8859-15?Q?oVzFReZaPYVF+yvkjd0nZuIRQ1Q54/H4HyD7gWwZLjyEYTClzg4Zp0aVD?=
 =?iso-8859-15?Q?oA2ZzcRl+i0gqb2wrSQSQ+C4071HSGxF4tPhqc93Ixpx2E0BrABhhjZx0?=
 =?iso-8859-15?Q?re6Yo98sRKpwrRwV+cOktPQjCtX3ZQSEAL7CnhH57LOX6545w1doZ/BLM?=
 =?iso-8859-15?Q?DClLfw1fggophdC7eu65xS+xSpD1SRG2HAskcM097tmtCBP9UNwnA0Yq7?=
 =?iso-8859-15?Q?mBr+V/PeAi3s8ayRBHVc40TeM2rxmn1T8PBFiFWaSdOuHq+7qpBU9DMVD?=
 =?iso-8859-15?Q?WmrBzKBl16ZnzXDUmw9EhegnvuiRN1DLMnD3cBVMnoJIvWa9/boU1jEYn?=
 =?iso-8859-15?Q?TQI2M/JXC7sVhxUbKifuAAQozfAH7IetA3Hbrsu4EoGGKSzIESy5jo2gS?=
 =?iso-8859-15?Q?8kYdn1ROX10/gfub4SkVFBuVFM5gcebldcnWcBms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-15?Q?UKulRU5T09Dq8V55cde74+BladcbzTamc6n/46vWZuqhrXuhexbjpbgP9?=
 =?iso-8859-15?Q?AxvWHLCQxP3Y68YUQJMuSXQXBscw4FHF5aLPXM04Ejl2g9ENn58d8CA8M?=
 =?iso-8859-15?Q?LWXQIUlaf/+C6igstSKbnBdtd6Iw0WEOz//ZmsqT0sptgHxMJPgiBom4W?=
 =?iso-8859-15?Q?RPc52iVZfkWdnOrz561HcKoCWeGyzakN4081SzBIBiZ6gKnjtT5WZfMlL?=
 =?iso-8859-15?Q?kkqYt2qfCXscJhPXd0CKlGuEiNpNJCZhPsqt1rCeOZd0hPyON8LXMPeld?=
 =?iso-8859-15?Q?suMD6up/PD3LvTMl3ZTYkwLtDcdgp6UgDuDgxe1ZRRmBQ//hhIrKnC+zG?=
 =?iso-8859-15?Q?3i5UY5cKt/PfPP4xLZYly8/d9nvpPTfnJqx2FZclDHSvtIKw0jjcHlu5N?=
 =?iso-8859-15?Q?ckbVAeFkWn803v4YnyUKjA+yhfzTVGH9XGIYqoaKV0YJUhnJycBGaap5e?=
 =?iso-8859-15?Q?QGA1hXVxpUYQVUt1HAR7/k2T3uEu0aHeHmBQZ2b2DP++aD+ngNLrSa17o?=
 =?iso-8859-15?Q?zkW9I1JoZUVJO9IhDhd2pnzU+iIczDtfng/98oAiol0GHUtvH95zTcmFf?=
 =?iso-8859-15?Q?/5m4FxjXD/C6HlTRJLTiHcPKIT4XAKuDLi6w6z6ubTalWAqPt0deUKAY2?=
 =?iso-8859-15?Q?vjk13muJ0xvqbeKWZ8ZlIdF2Jc/uRppNUWyfE5m9h2UZpjhZeh/LzsKJy?=
 =?iso-8859-15?Q?hDjltqpi7jhHN/E7IrRrT9qCYkPNZmWOaCqsKq99QgzmaxLwupJvGFBaB?=
 =?iso-8859-15?Q?XoiuMlsGXOp65Fe8ECQyVZIZXNpV6LmZzFFB0HZWtSxeM6J7+NtHB87h4?=
 =?iso-8859-15?Q?4eMva8F7KWDXzP4Efrw422GtwwTzKwCt+E4k+Zc10f0spqLxHL8YRnKeE?=
 =?iso-8859-15?Q?EMZCs2AJErrcC1x34nUWuxxV9Dgbokvo7Y2VWGa6TVY72fMC6mkB2Gop9?=
 =?iso-8859-15?Q?aSfR/ANt0ORF3YbwC87zXitj48G3g9uLd9IQ0k1za+KfToZ73J+Jp8XM9?=
 =?iso-8859-15?Q?Xe/zt+gd4baqYmlu87uGeZOUEPPPyN+dtGWguTwB2w0R+W+NW1x60xBA4?=
 =?iso-8859-15?Q?0zTpJLYrya26JWyY49zdzMBU788vLLa51uw/OxwxWulGDSM+nLPKo70Ng?=
 =?iso-8859-15?Q?cmxeOvu7BwWptowb2o5abg2vS3grz0Nq6KcXsUNQz/zUbSZXpCc1bDgrn?=
 =?iso-8859-15?Q?jXml3a5Pid9dktGZxaistDchWlx6BDg+0f/QDwQi1k4/1z27OeVKgyzOJ?=
 =?iso-8859-15?Q?GbFE2M4+efOp/VgODZpABqrJuseaisUc2Foxoab2s5D7y/WSBrdMauNA+?=
 =?iso-8859-15?Q?0xvOKlY1ujsl0SgXHii/PlKgGE89a7bNNRANybwBTfGnmYVChjLO9CEG0?=
 =?iso-8859-15?Q?eZKJHn9zSc05k4atNffj/o8UKuXDoYmnn2JjKVfo8fMEmhPp+/1tcPU9Q?=
 =?iso-8859-15?Q?WGwWfpEM1xdpakhv4ablVKEEiOAdDQ+c9p6zOrFLcbH6+2SFEArqX49EP?=
 =?iso-8859-15?Q?bwK/Jalt+qSU/4qFEU9cNe9UKzXTnPF35d6Mhuc1vOxiF8vMKZLuzXNiq?=
 =?iso-8859-15?Q?jVJlt0ml/xHOV6wC+z/1P0dqWT4UUpFjU9KXMs/acmomNNTCgx7O8aBn4?=
 =?iso-8859-15?Q?EuwZpccgPgQ7VMu2R5FBESvLz5tEeTZn8fQvCq8oXCsEtgrjOyrvQG9i5?=
 =?iso-8859-15?Q?h8f5xtfTNjmalNi9dxWHhiR90soW74tqN4z5aUPlsjviBD/xcv7M1sXUW?=
 =?iso-8859-15?Q?CpIJGdX9oGsEemLLk6VXtcxgWrcMB4QNZ2z6peZIxbmBPkgNbghjsqM33?=
 =?iso-8859-15?Q?aAGfVMtfp2CskhR9uaKS5XPzqKQFoZb//n6mNO0wL+u0RtQyqgAU+oQ9p?=
 =?iso-8859-15?Q?+mE4nUtkqPhWovFD4adekPj3b7TkPPhGB?=
X-MS-Exchange-AntiSpam-MessageData-1: Z3YEdeEaamj6LA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc94dc4-f8b6-4e65-57c4-08de58468f8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 17:08:41.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ffNF6VmY2UyzkQmT46Y/uYqaNAEae1VbqU2B/atoJRpZxVZgOxpH13Awk9vZYeQ60+y+2IokchkJpARw+u74A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107
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

--8323329-1966462870-1768928921=:872928
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

Hello Stephen,

[snip]

>
> What is the intended behavior in the selective case. Is there any mechanism for
> application to see original length?
>

The original packet length is delivered to application in the first mbuf.pkt_len field.

If the selective Rx read was activated, Rx burst will assemble mbufs chain that 
matches the queue split configuration. 
 
For example, consider application that needs to check out IPv4 header and the 
last 512 bytes if packet length was 8000 bytes. 

1 Application defines selective read split for Rx queue 5:
  - The first segment reads Ethernet and IPv4 headers.
  - The second segment skips packet data in range [34 + 1, 8000-512-1].
  - The third segment reads the last 512 bytes.

2 Application creates flow rule that matches IPv4 packets with total length 8000 
and forward them to Rx queue 5.

3 PMD rx_burst operations for Rx queue 5:
  - Read the first 34 bytes into mbuf A
  - Discard next 7453 Rx data bytes
  - Read the last 512 Bytes into mbuf B
  - Return chain A->B

The application knows how to treat mbuf received from Rx queue 5, because it 
created data split for that Rx queue. 
--8323329-1966462870-1768928921=:872928--
