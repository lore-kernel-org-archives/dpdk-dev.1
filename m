Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117F7EF06E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 13:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61F2C402DB;
	Sun,  8 Feb 2026 14:27:50 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69]) by mails.dpdk.org (Postfix) with ESMTP id CDEAB4028C;
 Sun,  8 Feb 2026 14:27:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvnsg4hXwHK3UESfh9I8guGe2qLI2VUOjmSHVle99oINfw/X234gHbZCked4NpSEHNRh3kBgcvZFo2C0hk/b8/1UNNkgYOY7/PUK8NoXdvxvwaaiCtk/DVUjQwcleDylNewmX6idMz2ShSJ28nVp0611FyWC1pOG8cB5YkaI3N8SIVSCQvcKaEDuOfz/EEjU5by4nhZEX49unLwXmsNgak4EfZoq/XJC283USPfFVd+7D1mhkStEnYcGjAtgJ8v/dtBPcAaiBjwdkguqniVgmi5vPuaJGP7R0SkXITbclyRN+cRXrr9Wb8pzlKJi0YSRNZDEjfJkI1FSiGa4my5e7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5wzRutRnZ/roF/xqURZm8KZlZPClSOdSx53qCfZa1o=;
 b=xu4sBhBRGJC5cxnAioFPz8x6jpxAC//xcMtaEEc4G4opri7W1cTQX7G0fwi/LZeBN/NBWjpkKC/DFG80YqZbfI1nX3QYoIXWQUIA9+d08BZ9B/DmkGIxQYBe6aVB0K+176CzyoRPTymqD0vFQz0EhHuwJ98yVGhL4d8o1sbPFcqPLf3T3312GQBEC1P1gRH4JACWsC90xtlzOrv/VMxsn90YjlDKfxqxjtR7k3Qa5Ujmrx5NbgoipnRubC5jzpOV1yNaMl+RMqOg39BrL18ImN/8afCiOi4N0LLbY1HhM1+exqIZHMn7MU0ADFGlRMl9toh4Gf6/nkNj3FnirC6vZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5wzRutRnZ/roF/xqURZm8KZlZPClSOdSx53qCfZa1o=;
 b=G9QP5WfKlklxcJicGnOHiKKnQX7ZUb0Z+ZsoV2Afkla++QMECt4jXgXwT6762SgDxBoTJDtaIal1Q5PapZIsLp7uO7WAcl9Jhlzp1x7sRT28zjac1xdPoLDUgHJCXK4ORGkvCcb5UPDypVRg4l/sZADEgQ1o2FtlIMuUsmzmbk9jMSeGPOOSnkWrEbMZcLnE2YOed2np1hNdOizClOTDDkgOQhtQXd8Y2tptmcY7XjSGqsrz1GEy/1BdYwWuhWrySJPn7BfnScC19FHwu7Y1jU1lI4l+NcMxEPbDnvPfHjUAx+xKc8mzK+LQC16H8TxNhPgwoeoao0uxCJNHgR5EeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:27:43 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:27:42 +0000
Message-ID: <8e18207e-f2d0-4562-8e1a-3cf3c8db426d@nvidia.com>
Date: Sun, 8 Feb 2026 15:27:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: fix memoy leak after device spawn failure
To: Wangyunjian <wangyunjian@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Cc: "matan@nvidia.com" <matan@nvidia.com>,
 "suanmingm@nvidia.com" <suanmingm@nvidia.com>,
 "Lilijun (Jerry)" <jerry.lilijun@huawei.com>,
 "stable@dpdk.org" <stable@dpdk.org>,
 "dsosnowski@nvidia.com" <dsosnowski@nvidia.com>,
 "viacheslavo@nvidia.com" <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, "orika@nvidia.com" <orika@nvidia.com>
References: <1766050280-21036-1-git-send-email-wangyunjian@huawei.com>
 <1766055446-41476-1-git-send-email-wangyunjian@huawei.com>
 <3a252aace4b640689122e2c03b102679@huawei.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <3a252aace4b640689122e2c03b102679@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 427b92b0-b80a-4019-0601-08de6715d69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWNidHM4alZDR3VPMkdlRVowWWYzZ0EzZ3hYQUVTRWpwKzZZNUN5emoxK1Av?=
 =?utf-8?B?ZDIyVjJENlNGQ00zbXNFVmpiTG44K0pVaXU3Q1RuOG55NytMT0I4STlqZzRC?=
 =?utf-8?B?YjdMckk0bDdhSkNzQWJ4LzRGZmZUWjNxb2trckh5bjU1L2NwRTFmajNpL3Np?=
 =?utf-8?B?U29mQjRtK1ZXdGJORUdkbGRRMEx6dkZ1RldOOExJUmRvYmxLVFZmR1NscTVE?=
 =?utf-8?B?WmR4RVYxc3ZGUG1YRWFqMGZtWnJSMndqUU5iYzZoVnVEblhhTnVNSFdJVnRx?=
 =?utf-8?B?SUVsdm54cXJXam5RU0VYTEJzLy9QRVNZK0k3eHlySC9Sai9RYlduTEFBNmFr?=
 =?utf-8?B?U0t1RmUzVUhrTWRPV0E2UzVsdHdHTE5GSFQxYTBLeWtCTjBEVGRKWnlob1VH?=
 =?utf-8?B?c1A4eFlTdTZoWkJMWlJBTDRqNkF5Z1Z2eGVDOWszNzhUVXJPYzg0b1JLVVJ3?=
 =?utf-8?B?cmxyQzBYUFppS0dxa2RZZXovMWYvZDJVS01kaXgvcERiTUQxYmY1LzdLb0sy?=
 =?utf-8?B?d3RqV3FtWnJSV2hZQ051K0ZHWllVbTBxQytXS1NNSUZsRnNXbm9IR2kxWkcz?=
 =?utf-8?B?MUhVT08yZDZZUnpxRmRKZ21mdzBNUVp0QVVVOFhwcUluTVZDVml3emdFRzBz?=
 =?utf-8?B?Tlo2SVp0blNLOFNadE41aHZYd3BXZll4Q0lrbUhYc3R5T29CRFAybC9XZDRy?=
 =?utf-8?B?YVpScllTUUxJZXRMQUNHejdEamhpcUZpemk2Q3NrZU1lMnhvR0lsamRUbWpK?=
 =?utf-8?B?WStpS1hsWFoycGlsVUlLV0hScmZwbk5BY1BQUlo2VUp2c0ZMSGIzeFpMc09H?=
 =?utf-8?B?aUxmbW56b2QvdEtiL3l5QnIxWFdMdW5DSE1lRjlWNVlvRThGQ0VTL1RBUnZp?=
 =?utf-8?B?WUZ6aEVVVWN5S0tGdDFacFNSYWlRSnZvL1hzR1pkOXgzRkFLeDFpbHhmc25Y?=
 =?utf-8?B?enZNcTNBYTM0eGdTaEoveDZ4aU9CakFPM3A1UUptOHI2aWxxSk1KNFhzY2RQ?=
 =?utf-8?B?Mkc0TEZoa2ZtVjUyZEJneU9VMXpuQnI2SU9WMFg1WXNjOFF5bmp0QXRkVFoz?=
 =?utf-8?B?dzFSd3BwdHZDT2NoQ1FqbndnV1lOL3oyWU9RQWRWam5OM1lLcUQwOG9Dc1R0?=
 =?utf-8?B?WWdVRDU3ZnV6VnpmTWZSYm9MN1A1LysxTFpMeDhwNTNacXo0Z01yME9MUDlP?=
 =?utf-8?B?TFBXQTBqSElEMEljcVlWZXl3TXFzZ2hoVUp0NkVEVWJEN1A0eXM5OE45bFk4?=
 =?utf-8?B?Y0l1WVpxdlE1NlNEYk5lTUg1aTFnNi9US1kxNHNGM2x2MHFQSm5lVXZvSWZa?=
 =?utf-8?B?Smpwak5BNGE4T3liaTdTZWg0OHcvdkNBZXo0aGQ2U2lYYUR2bVA2alFMckJJ?=
 =?utf-8?B?Sy9GSi9wNHdFd3ZwSzlSTEtwanBkR3hvMXk1LzNvVWoyK0pVcG5uamdkSXBP?=
 =?utf-8?B?a0w3WWtmRUg0RkpZL2F0aEZBRFNYdjQ1TGVKeFJGanVWMU9tMDhXenZWSTJ5?=
 =?utf-8?B?Z3R0R24rMzExNnQ5N1QwYm5ldnMxTTZNajZDbm9jV21lMllOMk03UllyQ2ND?=
 =?utf-8?B?cG4rMkd5QzdXdG5mVzdkeFBhVUd2VEFUakVHaFA4QWtGUG5kVmFrR05Vc2xU?=
 =?utf-8?B?ZXlUQzBYOTVLRGsxNEhkWHNtOEtKSldtUldoMDJIa2FMUnJVVUF6bkRqTER2?=
 =?utf-8?B?bkU0cHhSZ2I2R0xTcVpTNFYyRStqd2pJeGs4cTIvWWNPcUh1Q2gwNGZ3cVE0?=
 =?utf-8?B?dXgxNDZlZFlLMVUxWUhtU2FnUGUxVktIcVZkVElacjlqOWNBNGtreFBjcDA2?=
 =?utf-8?B?ZGRzSUE5cndVWFZTUmFEWWhFcVZHaWVrREE4NldDeUpxYkFWK1krZU53N296?=
 =?utf-8?B?Sk9ld2hVVWxrSndzaElNVWJmTUtWZlFicXBwanRidEk0eFFtTW9JTWI4Yk5U?=
 =?utf-8?B?Y25yaklWNTg3M1ptSVdsa1NRWUl4YWVreHlNQzVXMkJPWGJBem5BT05zVHYy?=
 =?utf-8?B?MHFjNE85MXVwdU5FYlpnZGxKaXA2eCtnVitWNm9jUlIxN3BqQ3RWVHY3Q2FT?=
 =?utf-8?B?K3NvYkZXbURKZUlZSmd2YzhhbXRiUkxnSGE4Skh4Sy9SMUpJZ0plYXVmRUIz?=
 =?utf-8?Q?Q+bE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBqcmxMS3hvODhlT2pidkxtQldHRUcrWERERHRZaEVWSmtIdTU4Q09IZ1NH?=
 =?utf-8?B?TFcydlBXNmRWQnd0R1BXZEJRY0xwZEUwYnp1d05zZjV2cmtmQWVBTWRFR2g3?=
 =?utf-8?B?Z0c1TUh2ODNjclUzekI0R2FDNVo3MDhMZEVUTUxNS3VBVHkwekRFeUdYNkxs?=
 =?utf-8?B?OXM1K0lqb0dhZWlHb2N3dkIzU2c4RVY2bCtCMUNBQUxUajdZNVI2Tk05MzhV?=
 =?utf-8?B?NTMvOXNSVHNDZndNaHJ2eWEycnNoOEhrYndsaXlpWkdPdGFVQnlBYkpnVzdt?=
 =?utf-8?B?NjJWYVBmazBaN25YcUhEZGlReEtlZUljSlphUHRYREoxUGZnRis4OXZoMUlh?=
 =?utf-8?B?aXNiYjdiUkZYc0kwaFJmVjJEdVVGYTlUVzJQN2VXbm9qNDZXYlZSYUlHcTNZ?=
 =?utf-8?B?Vko0UkFQQWhrUDdOdHpGcXlLNFB4WU9hRkpueGhwR3pRR2ZibStsbzdSVzYr?=
 =?utf-8?B?czJTRkcrWURXQ25RcE5XcUlYY2hOOTdNZ0g1WDFoNmZwcTRUUWp4UlovNUZu?=
 =?utf-8?B?b0FtZHRtZDNFTnh6TEliNGtHblBBaXByQSt3YnhESC9YNW4wOFJ5MzI5WTVq?=
 =?utf-8?B?S3hMWDlKd0s2TjFacHBYWHpzZkEyV0F5anIxNmpuZksxVmV5QmlFdlZvZ3kw?=
 =?utf-8?B?UFZLNTE0Uld5ZlowMElUakxKMUN0TnBwQ09qdmdJejNrS0RHakRjUCtabDQw?=
 =?utf-8?B?Q2dBWUxnVFY0UW5HczNlbm44NnM5aWVhdmNGYmJocXVOcHducUVyTXRvL0w4?=
 =?utf-8?B?UkRJbk5QTVZtQmtRV0h5WGtBVC9PSVp0K3NmVGFJWlRWZ3RFNmxXQWo2eTFn?=
 =?utf-8?B?bFAzcDNSM0prNGpWL04zdUhFSnpLQVVMU3FNdGU4Sm1Tc01ZaUlBaTl4dnR5?=
 =?utf-8?B?MXZqS0RsOEhEQkZTcVp2ai9YUHhlRUFaKzBKMFh4dmZWTHdpTXdyYnpBRUpz?=
 =?utf-8?B?T3JoNGpDczBUMmhIZGZjbTN5N29jbk5qQjlrQmRjSFdRLy9vUHd6amlRbG5V?=
 =?utf-8?B?ZkhpRFY1cGpMalJZNGRyQTBZMWdVaUpWUDk2aU1iRW1WRXBVTFp5cHJQN2N5?=
 =?utf-8?B?Rmx2M3psNEJiMldURHRiWk9XY3luTUF1VmxJTzI1N2tqM2M2SExvMjJKUDlj?=
 =?utf-8?B?WWE2ellsS1FObUFvS0tWNDMrVmpBZjJHUWdweE5jdHN2RGhrVXUxSEhzb3Jr?=
 =?utf-8?B?Wjg5WU13VlFHWVRwWlFSQWZ5NVFwcERSRmNsRnV4bzU3Q2RJQXRwaVFVQmln?=
 =?utf-8?B?YkwzaWZWZlRWWld0Y3RacitiWjI5dDhONWMwZDhaMmhxSWh4YkY0c2FQZkl2?=
 =?utf-8?B?bW15YlB0ZDFCU1d3UnZmcHRPbzR1eUdUdWFXWnNYYjFlOEZmZzl3QXJlTHJa?=
 =?utf-8?B?TkxrODRMVzExNzBwVEM0bUpLeVJHejN5L003MksxVG1lWUZ4TWhkS3Fldmpt?=
 =?utf-8?B?bmJoMlBLYWtJYXUyWEtFaHh0bmFqTlNRdGNkc1ZibGtJckh5SVFGRkV4cTRP?=
 =?utf-8?B?SGc5TEFVUHUzREFYL0NBVnRNK2dDMzB4UjdTajVCT0xtZEhudm16YWtTeFha?=
 =?utf-8?B?bUhDMTZDa2lRWEd0KzVhMG9lVUFpbXM4dkxlMnp3MmJhTkIwZjM0MHRUWWI2?=
 =?utf-8?B?czN5Q1creVBlZFRJSFJDREtPMGF2Uk8vRm9YY3pjNVRnMHJIK0NYdzdydmlF?=
 =?utf-8?B?NnNPWVZoTHJEaS85bm91ZVFwV0Q0ZHJZZ3FNMEdvS3g0RTVCbjZHeWJsODVF?=
 =?utf-8?B?c2lndG9icWVGU3pKbkxMQmgwZDNzZ0pOR1hJUW1SdnhHMk9SQjBHNFF3NUly?=
 =?utf-8?B?S1Bhdk9QQTZEbXlsWFBoT2l4WTg0eHBwSjF5dkcyVnFOMUpjakxKR0VCb2dG?=
 =?utf-8?B?K3pqOGVUb3oxMmpCeDE1TTI2eE55WWUyc09xYXNMeW1JWG1rYUQwV0p5NWt0?=
 =?utf-8?B?dllXVmt6UWltWlJEcHJnWXZkTmk3QTB1akNITUpiZGpQZ0lJVTFzekpwOGlh?=
 =?utf-8?B?dWtWTHprVWdUNENBMGtvZEovWHBOZi9RZ3UxdThOU3BFWnVtRTlJNi9LL05S?=
 =?utf-8?B?c3NPTklUcUtSMUNPSmdQc0hOUXk1VDVDVy9BTUdBUkxORnpoOFNBTUhUQnhT?=
 =?utf-8?B?MkdCYTJNcUJhWjVWVGlhTmlxZFpUczk1M0pSTUtKQ0d0TlU2UTFERTZibkhQ?=
 =?utf-8?B?VWp1KzViSXJOYU8wS2YzNTBtV0x1NVBEd1NYWW9tbWgrakNmY1NtUTE2clEy?=
 =?utf-8?B?emNIWVZZaU4vSWsvam1NY2V3c1p1am1JSzMyK1Jia21QVWtGWkczcmE1MU1C?=
 =?utf-8?Q?fc4NRQwu+IlOw8TXje?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427b92b0-b80a-4019-0601-08de6715d69f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:27:42.8373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFlO4PpWBNI6j8DNWZuXMAT7PhlGUI1hGWqXl4yPjEne62ptWoX1BDRBTj/tVGjZqr/RRbaJHjxT94wOiJIwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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

>> -----Original Message-----
>> From: Wangyunjian <wangyunjian@huawei.com>
>> Sent: Thursday, December 18, 2025 6:57 PM
>> To: dev@dpdk.org
>> Cc: matan@nvidia.com; suanmingm@nvidia.com; Lilijun (Jerry)
>> <jerry.lilijun@huawei.com>; Wangyunjian <wangyunjian@huawei.com>;
>> stable@dpdk.org
>> Subject: [PATCH v2] net/mlx5: fix memoy leak after device spawn failure
>>
>> In mlx5_dev_spawn() allocated memory for the 'priv->flows', we should free it
>> when errors occur, otherwise it will lead to memory leak.
>>
>> Fixes: b4edeaf3efd5 ("net/mlx5: replace flow list with indexed pool")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
>> ---
>> v2: fix code styles

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

