Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA337E9128C
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 08:10:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B13ED4026D;
	Thu,  5 Feb 2026 09:10:31 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42]) by mails.dpdk.org (Postfix) with ESMTP id C3B9B40264;
 Thu,  5 Feb 2026 09:10:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3rjgVzyp4eFkJXv/cc9TKQlicIz8jQQMB27Xa4lRVBsF9ieIzuykoWwM6j3t68hp3DLgbGWdXj6Xh1ScVZzvKcFOq9DaZ4ZLVecawRAT1UQ1anBUwTRL2ywYWxaoSU2UHtns0OMaOP2viZiEd3WN87lFhPltHJ3iU9/fhnt87ao4Lv5dMCQVqRRfj8OiurDAVYwRiEMaAP5NmM6O1I/fnvmFhVmwlUCiCntTo08I+TuszlI5hwLapLZtznDgvvih+V2g0xwBeSQJqqFMXMpi3WjJFw8sesK1vEP2MIvwo6p3ybpMNfMFptE5nS67JEfiViCsykR6WfTlRNt0u0+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hhMVg20/72Dun4i/Tx43ytEBO1yQIn/grP4WNKRlPc=;
 b=pNO67m/iJWqtu4CKWlLTd05Id5i8uj+tBmjBgeWcVjIznQzjrsaFYqRmCp73Z5xA1HLtHYHpi01CQGos3KbuREuQ1CAsBOqOkzwWg/Epfv5SiOdd4F6vcoB6Agmntdd1VhsZ2BfkSWSavcJSCJQ93XkFtBMBESRFzuMc8meSF0Rz+VFSADwz0EBg82k+v1YhdZUihvyOv34ex9E/Va2oOuc7QCw5MXPq4duFQ5r5nZV5ciGvwfnTm+QemL8wWaDBpOyE29z4vqMzvm/Sbh7GX2H4DxtSfb2KnjkWcySFt81oaSEuZyXLSsYYEAeGuOI4t0R6QHauMFl3+HJJt5wOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hhMVg20/72Dun4i/Tx43ytEBO1yQIn/grP4WNKRlPc=;
 b=uJEID270XACt6geIAVNebGsw8W32O99IATKun637UiF7+guhPP7SKXaK5dj9s2akbS607qfqLzw+xSD5r3zP3V0z4d9mMIcsSJr6cVQNEEF98lFXk9dEIsVVn4t6mQy1PpuiO2lPBHrTukrTczLRtLwz5Rn/sBpGOo/LXaXs2CvMH0tG4JlspSxO7u17DTkQzejPIpUCnTflLK3Vj7m5GGZqjGeK8LVg7dSTcMSyo+dYbJ1nIiViNF2gAna0XRyg6kIaru1k9zp6lBq9g26qvxsul2j7Ycl0sAB+TymDKs9zLMJq62LEfEPkNCIYYafdGSvYjEjktfMSUWzMzhlrQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 08:10:27 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 08:10:27 +0000
Message-ID: <114f247b-9460-4217-bb16-cffabd2208e8@nvidia.com>
Date: Thu, 5 Feb 2026 10:10:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5/windows: fix MAC address ownership tracking
To: Itai Sharoni <isharoni@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, stable@dpdk.org, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Gavin Li <gavinl@nvidia.com>
References: <20251209122406.3364-1-isharoni@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251209122406.3364-1-isharoni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f81befe-9978-49b5-64e2-08de648e0509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHYraGZkUk9DUTJHdUlUZFdsRlpkWklpbXdMd2ZWUGZvZ1h6VDJIRjRyY1Ja?=
 =?utf-8?B?c2lqT1NuNzgzL21KckoxUHprY08vUXUzMXUreElxZGdhaFpxeXg1USthMHk4?=
 =?utf-8?B?V2ltTEN3SVBvYzdhV3NXRWhDVjBLY1ZJTE9zUmlmR0t6cU56TEpFWWd1Ym9C?=
 =?utf-8?B?ck1pR3UvQzRNTFE3SnNrb253ZytEVWhTWm1Zb1JNMFZoN29BSXBqdjJ0Y0xE?=
 =?utf-8?B?Y0xLbThoMkxzdHVzQmdGQmJESVpwU1FwL3ZodzNVWWkvelRJV1lpV09rN1RE?=
 =?utf-8?B?NzhaVDBXSWd0Vm42d3Bka0U3MUpDdFRVZnlLeUxLZ05qa1A0V0c4Ykw0bXFM?=
 =?utf-8?B?ek9jVnNHUzRCaVB1M3ZDYzZ2VEp3VVYwOStZZUFxNlo5MXltcU55MTljd0dk?=
 =?utf-8?B?WlgvS2trVzNkYjQrRlMySjE1b2Q0TkVnbEVKNmdrQitsQVVUR0hSU3VrdVZk?=
 =?utf-8?B?NlRKT1BMV3pvS0E3NWhxbXY4WVJkOG1JYU5QQ3E3aWZiOFJLQ0lMQ2hmYnc1?=
 =?utf-8?B?S01JWG1uY3ZlbTB2K0VkTDYwdmN3Y1hzM05hMGZwMzVYZlo2NzBDYWtMOGpt?=
 =?utf-8?B?UVBNVlZZT3d4KzZWREtFL0cra1RQRVVMVGE0YnlYc2o3ZVRvdjkvN2IyYU5a?=
 =?utf-8?B?Qkw1OFFTZTlXYVZvTG1SVWd4OEdFZXc0ZzF0TW5neVhzZzVENU9Ydlc5YUs0?=
 =?utf-8?B?WVQ0L3lXYzgzMXpLZ3pLSzdjSitmc0lEZ29OM0gyQ2NCdndXdVEvcFp6bHhV?=
 =?utf-8?B?ZkVXT3VBTGVjSmdWckRZS3RrUDJzQVR3R01EY1B6YXRrVUVSS0ZXWElDOFdU?=
 =?utf-8?B?b3FtdDdnKyt5aFZjWk4vVGJXRUJpN0xlb25ZczMrMkRhMzhpQ3R4aVczUnBF?=
 =?utf-8?B?RnR1MTlDRmR4eTdyT2QramMrSUVVNmo1eUpobjNnSmdUSFlhamRpRTFxcTFK?=
 =?utf-8?B?aTc4NStUeE5ERFp0QnF4RnByUEVjQVNobEs5aVBVNHlpQXJUS0xPbVFzL2pj?=
 =?utf-8?B?VmNtaXRORXZXeDlweUdlZ3FxMzRmLzMxcVZiVnpGTEY0UllxLzFsMGxVUFJL?=
 =?utf-8?B?WlduemtUN0VDckUrYTFEUC9TaGdDQ0FIQ0FNRG5vNDVYZUM4UmN5WkN3T2lI?=
 =?utf-8?B?djlzeWcvdkg4bFFOK1FQNHNSWGZVMzBvNFR4Tk84REt3Qk00TlFkNUZwSjNE?=
 =?utf-8?B?VitPcWx1RjF3L1o0WCtxNnlzSFViVmVzMXZqY2NYSVhMUVh5WjRHS2NkM2Vn?=
 =?utf-8?B?MXVvbkhRai9TajN6a1JtZ0lpWHhzNG5QYnZYQkZ5WDNPUWM2VEpld3d1OUpF?=
 =?utf-8?B?ZHh4QUxFZ1ZXUUU1VG1qamJseFRiWTNiSjg4MG5sVmg0WEFZR2RiZEtyY2N6?=
 =?utf-8?B?Y3FaeFp4KzhBZGlCeWNpSXhGMUZVWk1OUWJsNnhMODNoQmkvbk44M3dFdndE?=
 =?utf-8?B?bUlDakdzSWg0dGtKU0VpQzNTM3NsVEsxNC9mUm9xWGg0Rm82RVJhcGtRaHJR?=
 =?utf-8?B?NFptcytHdG5kRTIzblRsbVRYZU53QnVjbkxOTG8yMklxM1RUL3U0dFZpS0lh?=
 =?utf-8?B?U1R6cWR1QWJ1elVJSUFkYk9KSERRZURZWUxpV1pGcEpTVmtueUhRdURJVmxj?=
 =?utf-8?B?VUFhNVlZTWRPRzFaZnEvWjlxZmVrNFR0L2traGdJbkp4WnN2cFNmZDFnNlRS?=
 =?utf-8?B?d2FVMzdxdGpEZU1NdzlEdmtMbjl5OUxwOW1Qam1VZG1DbkUxU3dUTURtbkFi?=
 =?utf-8?B?OVZlL0FoMWw0MXlaaCtBck84ZWFva2lMZzhLSytuUzg5S1VXNCtoQmdRMStu?=
 =?utf-8?B?c3Q0WGdBMUpGek9VSi93Y2NIY1VvaGg4YU1HYkZFZ1QydGllYlh0SnRCMDht?=
 =?utf-8?B?dHN3V3JvcEJuMm5XanpCOXNmK0tSYWMwdXNZdmFUZnZDeDJKenlQaVkrd1hu?=
 =?utf-8?B?b25NVWJnbzBYSXlMaCtGNXUxakQwVCtReitJT0VHOW5nVGxWNmRLaEdpcGhq?=
 =?utf-8?B?RHhKMHIwOHhSV3BpRmdlM09RVnpVU2lBaWJIWlpJNHJHT1IvUHhzdDg1NXhR?=
 =?utf-8?B?R1N6b2Fxb2Vjei9ITEdXclIwSUR5MHlxY3lJSVZNU29odVdDbGVMYW03RkRU?=
 =?utf-8?Q?NhVM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmx0a0JRdzlwVFdhZDN5YytXL2ZvOVJ0UDcxUUZwQXJOalQ5aVRMZVA3YW5S?=
 =?utf-8?B?cVBIdWFad3Y2bGMvcW50QlJuWkVDWFVaempuUUtsa0s4MVIwcktKdmdWUzkv?=
 =?utf-8?B?SHdzZmc1MkZrcFRmb3A4YzRFVWU1SmJxb1Z4bVVFRWtuUlYvdG9MNWNFMGFo?=
 =?utf-8?B?a2QrT01QQlEyQzFZUzRjSml1WUFxTkNFRkQ5WGdKaXhLTEEzY1lVenFNNFZU?=
 =?utf-8?B?K1h4azFyVUxwZ08xdU52Umh6RS9EM01maWZxYjhoVHdjZmFlR1ZLbWNXdU1P?=
 =?utf-8?B?UHVNOHZsMjdOaU93OHZwdlQrRDJQYnR6Ui9jQ0FDSXhJS3g2OHRoK2lGU2NU?=
 =?utf-8?B?Qyt1cjJ6TEpLWXBMUHVUSVJYU0RXWlVhOTJpOVFHVEtSazlFT3UzMzJyaC94?=
 =?utf-8?B?SVpuZkFVYWNOMWpqcFY0eFNnV1Y3ekRQR3Y3OWo5RVdTam0ydHRoSGdoYThV?=
 =?utf-8?B?MDFzS09BTmpCVkQwSW9kZ0prRDZCb3ZORmJzV0l1TUNCTXg5ZlhPeHh3QUsy?=
 =?utf-8?B?T0FrUXRNTFN6cjMwZVA1NlM3eUNWR3k4V2wwbUxNcjZKWjNHdkUxZlVETmts?=
 =?utf-8?B?V292eEpRWCtOMWQrN1V0a1NMVmVEWmRTWDlQZjVhVmNqVDZQbEtHQ2N1aVJE?=
 =?utf-8?B?K1ZkNmcrdFBrTmwzTDJWMkdlRngrbFNURllDb25vbWh3ZGNaUkJINGFUMEVo?=
 =?utf-8?B?VmNKYWxVYW5xUnBPY2ZsZmRtQzdGa0Ziei9SS0NBd3VReTJTNS82eFZLSS9X?=
 =?utf-8?B?Z3E5Z3hPa3N3RER5OHJHbm5RWFNWWkl5QTBDbktzajdzVjAxcjdjd0tXZ20x?=
 =?utf-8?B?bzhETjlkd1lLZjAwL2x3UTRzOXVJM3hsZk5qZU9sV3B0N2ZMNXlNWE1MdWFs?=
 =?utf-8?B?NEVFekIwMEhrWHZodURxak5mTUdNbFhEM1ZHQm9BY0E5Ni80ejFxanpKL1dE?=
 =?utf-8?B?STl0dVEveUZJTE45T0FyVXhvUitiYzVNdFhRd2pLd2VHNVFPSGlkd2FZdE9N?=
 =?utf-8?B?VS83ZlJzazlzM2c3WmNvMlYyaUMxQ1paMk11dE9nTmdTWHJhQ05WZWF2eG9M?=
 =?utf-8?B?aUZ2R1VPaVFFME5HNnZ5Z254SDg4ejhlZms2ZGpWckZpeE1jMWQ3MUcvUHU3?=
 =?utf-8?B?NzBseFgyMDRwNDhmQTZFeTVjaG9ORXd3TkRRNGlsTm1VTzZIaE11SlJHTUcy?=
 =?utf-8?B?WldKVVRwNUtrd2h5NEVBdjNVL0xXZnVmQzg1ekFaSWVFbVZqRTYreC9UZzdH?=
 =?utf-8?B?OGZiV29XeVNGOS9hVFN5dlBoWGhpRHJMWjl0Qm1tU1dLZDdzRlR3c1pqZjA2?=
 =?utf-8?B?QTA5QzEzV3JkRXIvMzF2N2d0eStSMERwOUR0MWt2M09CQ0hiQ1VxOUlwemhu?=
 =?utf-8?B?WDMxbE1qTWxhd2F5dTdZU290dzVlTEdEdVExWHNTMW54SnN1RVpWeXQ4V2ZX?=
 =?utf-8?B?QUtBNGI2bWNXYkprR3hNN0tyejh4NkNlRDdZMEdtRnhtVWdoNWtwejIxYW1q?=
 =?utf-8?B?anZFL2xoWm1ucVVSd0w4MERuSHdoUW5VSkIvYTNuUVl3eUZwWFBCa1J2bFFm?=
 =?utf-8?B?ekhTMXhlcFM5QUowSnBiNEs5Y2tJMGZPL3h0aDZ0YTVub25rMFpyeWpQS3A3?=
 =?utf-8?B?V2pDOW1OTTVmRmJQT2pHUVBvWXk0dUxnbkZTT1Y1bFZkTUt2bEd4cStpd3Vh?=
 =?utf-8?B?dGs0ZzEzaHNwMEh4RjkybmpPREJEaHN3Q1YwNWd6TndrakJlY0d1QnYzSGlj?=
 =?utf-8?B?Uzc0QW9LUEdBQTNBenRFVFI2NkhDRXdjcUk3d2xkc0JaaW5GcCtDQzU0b3lL?=
 =?utf-8?B?VndFNGhlNTdnWXZjMmhZYkhnTjdVeUFvNUkzYk9OR3Z6cE8ycUVxUGZWZjBQ?=
 =?utf-8?B?UkJwdGlJR2dKWW5rRjkyWDNHY1RBYWhKU29xTy9rYmpIeUNWdVNRbVJTQVRk?=
 =?utf-8?B?ZHdxMHFvNUJlQXFRc0V5aUZGSTdOOGoxZ1JXM2lGN3pRcjUzcklzNUgydXBz?=
 =?utf-8?B?MkkvL0FUUVVqN2QxYVdMa0JDZkw5NmhrTWhiRGJ1SElGQXlRRkpYZE9ObUc5?=
 =?utf-8?B?c1hqMkJoZVgzRVFOZ05qWk94QnFkZXV0dnZXbS9vS3R5VDh1Snk5aXdFVEpK?=
 =?utf-8?B?ZkZJSk1nV2p2Qy9YNVd3eUlhQU9BVjFhT0c4cklxUExRejBQQkZYV2l0ZlNn?=
 =?utf-8?B?TnFxNXJjcGFwTDhhRlpzMGRibmZpRzcxT2syTUFlVVBHQ0NacmZoN0NsdFJR?=
 =?utf-8?B?bUtMWnFiMnJSTkw4TFhqRXUxREZldzdMdzdwWUtyZ0ZNZk82T1FHTERwVnRa?=
 =?utf-8?B?OFh2YTBsNHpqWGRpNGhSODl0MVJ4dDJ4bmRmd29yYzlRSXcyRjJvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f81befe-9978-49b5-64e2-08de648e0509
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:10:26.9069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKyveR/Lzpen1jtz94lZ2ohauw5qIjTA5jyV3iLIhhhcJJkCapWgiyQp2amQYnyLUrIsANuWQyL7cSDQ2YxPZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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


On 09/12/2025 2:24 PM, Itai Sharoni wrote:
> The Windows implementation was not properly tracking MAC address
> ownership via the mac_own bitfield, unlike the Linux implementation.
> This caused issues with control flow creation for MAC addresses.
> 
> Commit 8c06434cd9e4 ("net/mlx5: fix multicast") added a check to skip
> creating control flows for MAC addresses where the mac_own bit is not
> set. Since Windows never set these bits, the primary MAC address flow
> was skipped, resulting in packet drops when promiscuous mode is
> disabled.
> 
> Update all three MAC address ownership functions to properly manage
> the mac_own bitfield:
> 
> - mlx5_os_mac_addr_add: Set mac_own bit when adding the device's
>    primary MAC address (the only MAC that Windows supports)
> 
> - mlx5_os_mac_addr_remove: Clear mac_own bit for the specified index
>    to maintain internal tracking consistency
> 
> - mlx5_os_mac_addr_flush: Iterate and clear all mac_own bits during
>    device cleanup
> 
> While Windows cannot add or remove MAC addresses from hardware (no
> Netlink equivalent), proper bitfield tracking is essential for internal
> state consistency and correct control flow management.
> 
> Fixes: 8c06434cd9e4 ("net/mlx5: fix multicast")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Itai Sharoni <isharoni@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

