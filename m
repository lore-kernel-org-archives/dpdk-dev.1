Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD4DE9B250
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 11:40:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D1AA402DF;
	Tue, 24 Feb 2026 12:40:16 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by mails.dpdk.org (Postfix) with ESMTP id 5758B400D5;
 Tue, 24 Feb 2026 12:40:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0pCkRUZ6v0JLBqEzU0c0alXRr6eIEfAvh84NAMlcHghPcjLx5Yd9Cd1VXpWeARkyrneXM8cgHYHNSdtAMw6ZU2qB10bzS8+2px++sm7rvkFyFn79wqCg+X/QLUxgGd/FHAB9zX8bxV0ddZ+FlbsZlLx9g2tacCpbREZmK0O2ac+ifOXhI8PLixlmZbbo2N56oUOjONuITpBujVK/uJdVlWrNPqOZA+pg3aEnfAZjeSvJbGXcGB1xEomi9N0boHP3QtQEp8cuDQByfNKlBGQQxQI7eMcAtDbXSF5D2sP+F/L6QP5+fDmFPGWbCJGLfweQnjacBLl7Wg3rjlOacOOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXjRBvbc6lTOKBWyCULKzmH5zky6CQoazh4vegcbTq8=;
 b=LWnBglih8QbjOQjmZ3cSLp7ZHXCxfGhmzP1j+p+OhvY5rhVK0qLxxaw56pzhPcGcqMMrq/M6t4l98JjnM0O0BKvYHYRdWtx8BDHfHv67NpWlnzoJCT3cKx5Y5ADuPA1OvH8UXLX2R/a+uqvxbXoa/8j2wmhEV5so/IveJQ36whYC1+LTeUBTi+4Yd51WAw1XVApvWJINEUZGnWcdvrtN5UAILUFrINb53LUf1WazdoKzKBEhQi52DT+z64BbW4XVqlnSrWlvu1B04eFcpNOVvES1qYj3CeOv2LR0YNI8FQ7Cf02Xe4h+GJhF3j+TwWy0AJ/0noyaO4WZwU9bv+CYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXjRBvbc6lTOKBWyCULKzmH5zky6CQoazh4vegcbTq8=;
 b=QT3xdlFJZnno9W2rm6zUNJ9KdKZlIORvQiyPSFMWGPnbVQsHxcUxQHrp/KGyptn2iOwtzYMTNh0wHhqn5SPxxXJIxaRcfSRKkucL7OuXa648TBwCX8LD0YBIEKre+wFcbKqJTAki3m55UPENJMNYtspfmzlx5TA4VRhkOL8WianYWptRe/wghCwiPSMCjOfgydZEdlsDhdTRqJ3JGZ6CkGIqlCD8QRgbFrMFy6c6JMucIjlDUXW8E1jr6LHUrp5hlZvscasCSs6b4ANn3WS57wYkS/EedHasSOHXsrWSbdOmOSbVyUXZ4KUUWFOdTy7vVZkdgGCtIaOBgroXoE6iDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:40:07 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:40:07 +0000
Message-ID: <6017e0cc-e97f-4dda-ae31-6c249ba1e052@nvidia.com>
Date: Tue, 24 Feb 2026 13:40:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix flow mark reading after reconfigure
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20260211081239.191118-1-dsosnowski@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260211081239.191118-1-dsosnowski@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1ee3b7-7a4a-4330-7107-08de739975c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzI3ZEptclFnZkFCRjVBd3JLRUxrYTNlRUM4UkQrMm91UjVVRVltMllVditk?=
 =?utf-8?B?a3ZTQzU4R3JkOHVaQWY3d1VzRzVOZTkvVWJORU5aeVRtMnVYZ3ZNdVhEcmJo?=
 =?utf-8?B?Qzd1RmFGUHBnMThDR0hOT1kvYlJ4aG5xejcxNXhhYVowL2lBSXhpUThkaEMy?=
 =?utf-8?B?SHhNb3Z2T1QwdDJDZ044dWtRSXBwMEdxZDJ0dDRpN1d0Nzc5aVRvcFRIZktF?=
 =?utf-8?B?cEl2ZWRBYXIydWNLVEtpaGxRUVFFK1dWM1NzQ2lYc2dXbFpYRmZzV0RpRHQr?=
 =?utf-8?B?bjVNbXUrNXhmRWFSbEV6M0NnTENkclRQTGpVdTYwMVBzc2tTMi9KOEpYMXFZ?=
 =?utf-8?B?KzdQQjNXVnNrUitKUmZ3K0lmaTBJSWpiUzZ6WFlnVzFLOGZpK25TTm03eEpQ?=
 =?utf-8?B?RGYzTVVjZ21kM0RQdk9XU0NlWHloVEtUdGZTYzZ6ZngzNUk4aElEWjU0elQ1?=
 =?utf-8?B?aFpMaE9kQm9PVGRFK1JQN3FrMjBPRFhSU1FqdExKRXJxdjU1c0YxMU1lQzNT?=
 =?utf-8?B?Q3dVQW1ZZ0NzSWMxUnpQNVduNTRSeHdkS1dlT0U3d05VVTJNWk1Ec21TTlh0?=
 =?utf-8?B?bHcxYUlWMTdoL2dGVE9lUk5kTXVmRnNlZmJFVWVZSmt1bHhQTFRWYzV0eG1T?=
 =?utf-8?B?emlJODRzUjJvQXlIRm1CSncveVZUc0VLYlhHZ29ub3JxZkc4OFM4aDFMUklB?=
 =?utf-8?B?YnhXZ0ZFM1RORCtTazZRT0NZVVBHU0w3TDRMU3czWHpobVArTVRWaWtUTVQ5?=
 =?utf-8?B?ODlveGNZSXoyK0NyZ05CWkRxMTNxZFpQT1JQRHpPQWVmdVIyNnM5UFBxMHRX?=
 =?utf-8?B?bmJ5VWRJRFRSZFdpVytLMGhyaURVRUw2NEZxanpQVWRjNGVhRXNoYWhBQnhL?=
 =?utf-8?B?TCs0UFRaZ2phc2txY0FTand3SW80Qms5RnR3MkRiY0QyUlVMWXFLSHhiRm8y?=
 =?utf-8?B?TXFLRkpjaWtRVXJCdXZWR3hKYWgvZVpncE82a1NhY3plVTlDcHUxMDZXWmN3?=
 =?utf-8?B?Sk5UVS9HeXBtZm4vMjF3QzRGZ3h6cGpTOFdTTUgveHdZdi9vTjZTZUF2VUJS?=
 =?utf-8?B?Y0Q5MW1jTE9qaFhZUmJOVEJJQzBtalpTZnBCWHVFZ1JwWGpvMzdaclByVVpM?=
 =?utf-8?B?M04rVm51eVE2OWNXaWZKdTlobElBM0RHNE9OZ2o3QXB6djVORzQvZjVURXFF?=
 =?utf-8?B?dzBWZ3pwSm5aZjk4NWlLQlpXL1U0dllDb1N5S1EzRUxRakYweHJ3aXpCU2FE?=
 =?utf-8?B?M1dmWXJyWmdmaFcvTUtFWFBTV1FhUVBIa1FyK0dwazFrZzVKb0tNMExNak9x?=
 =?utf-8?B?d2k1S0E5ZXpMZDg5TS8ydHd1WE1FZlNxS0FvaVVZM01xdHB1bnhJL3ByYmxp?=
 =?utf-8?B?OWxPdTVKNUpsVEkxMEs0VW5UYmFqYU1mb1UzNUVncnhhRVV0RHRUTG1yMXhE?=
 =?utf-8?B?Z2xZUjhJR1Z2cUF1Ni9XZXpoTFFWU09hUW1iTUZuTXNqU0pSK041UDViSFRF?=
 =?utf-8?B?RnhpMlQzMGlUTldYMnZxOUdSQnMyZ0ZpWW1SMmtkQkY0ZE1DaFdHMUlsY0VN?=
 =?utf-8?B?S1I5ZGdoTndkaWRMcElSaExFWklvYU1Rdm5rWFlQalcrMDZjZElCL284YUVz?=
 =?utf-8?B?aVM1WE5wRmg0cDdubHI3YTFrMzRRV1Qxb29ZYXNWaEFXek1kK09VM1QyTTJK?=
 =?utf-8?B?aXdUbDJmT1kwNUoybEowZmlFTFc2UXZIODczUXdMNlBxbVM2RFJyeVdJd2pj?=
 =?utf-8?B?UmVwdFNQcEVVbnU3S3ZlUnBUWWtzSWhSbDdEeWdyZXRtTEhtUFBmMDFmSUo2?=
 =?utf-8?B?bUVxNkZURTNPTUFLNkpUYUZOUDBMQk91TWE0R0dXR2ZxK3NQMjZwOGRwRFY5?=
 =?utf-8?B?VjBRSEo0MDhPMHFqOXVndVROV2ZzemJVZHJUZ09aUkphK0xLNy9xOWcwMXhw?=
 =?utf-8?B?SFdFV0tyb0poZ09NZ1JuYksrdHlhZll5anpwMXVNOHdyV08vNGNrbUV6OU1u?=
 =?utf-8?B?TDdxbk0wdmRCVEdXYWYwdHdHRXl4TUFEMHdFeGd5V0VEbzJaREJVV2NvQk1o?=
 =?utf-8?B?QXRGdWhGaDdOcnhCQ1M2RmVKbm5nNDh2endvR0FISWNQZW01MUhhQjNFR09p?=
 =?utf-8?Q?r6DM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGRnMGp5TzBMZ2xDQ2o0OEFmYmN2QS9VeGYyeWF5NUowV3FqQmw5c0NFQVdP?=
 =?utf-8?B?eC9WSkFlZVhEK0hGV2FJdnM2Nk5WUklqRks2TVduY2JRQk9NYTRFZ3lOalFT?=
 =?utf-8?B?RXJLVS9VYXVlL1czdEFNTGV6N3FucXhYSmwzalc0cTMrZGE5L3pOQnhCYU5q?=
 =?utf-8?B?Sm9MeWpDUkNJaEw0Ujl2RHU2SDB0ZHFaVWtGSHFHQVY3cVI4VUU3MEdqQXM1?=
 =?utf-8?B?UHljYUpxK1c2cWxIV1ZseG56ZGwvOGpKeGNmNlhDRzB5cnREMmZpVTlESVRz?=
 =?utf-8?B?dDd1TS92QnN5NGdPT2dNR2RHQS9VUDdvdjRnMUkyYUNualNDNGFweEVSKzBi?=
 =?utf-8?B?cGxodzQ5MkdQQ3JkMVlRb3A1NVBQTDV5ZGxkcyt2Y0pJRDlNdWZRYi9zOENI?=
 =?utf-8?B?Nnp6TlFhVjFJMkl4eTgxRFcrUFhWTWhFZjg1TjdZYXRRTC9lV3dPZnRSUUxi?=
 =?utf-8?B?VXVmaFdDWHZJd1J1UkNnR1c4OFNVTm9XQkNmWlB2K1luWlNpVVIwRStoSXlN?=
 =?utf-8?B?ZUNpUngyNm9KS3FBb1djdTZTbXBzZGY4aEJEekxwWTluR2laWUNBT3JlNlVo?=
 =?utf-8?B?NUQwVndrN3dYRXlZYXhSbDFzUFhCaGhGNVUrRTZXTnVCM20vS3dIWTI2K1VY?=
 =?utf-8?B?VnB0M1M4dGdPWXRLampScEY1OU03Sis3ZDhSdTdXQWFVSm15Q0l4WHFreUZ3?=
 =?utf-8?B?YWhiSjNTSDhSa3ZTUHI5ODgyL2VTUEplYk9qYzhNWnl4L3ZKRHlHNGRUR0p4?=
 =?utf-8?B?S1BqRStKSXVmWjdQZytjNlJiY3dxd0djdW9ua25jQWVVREp3Z0VXUWVTWmE5?=
 =?utf-8?B?cVpERHRqK2NEa1k5QU1KeUF4QUduajVjYXJKbFlhT1pqYTJrTXB6RGh6VmFC?=
 =?utf-8?B?NTQ5S2pxZVo2K3ZWeGsxUTI3U25FUFY0Tjc3ZW5ZODdZVnVVaXNBVXZVYmRG?=
 =?utf-8?B?ZEwzTDRuNFQrUVVMYVpwM0toOXJBYlZJT0NkYnRzVU1CTTBxVFAxeU1aOXJ2?=
 =?utf-8?B?WDFzQ0FBZlk1d2g2V2dRdkEvcldLN1F4UU0wQ3hGQ3ZoNlZuZG5QeXlGdjht?=
 =?utf-8?B?QU1pMHA3NnEyVFlHUDlJQmc2K2I4Q25YY1hPdndUZ21paEV1elZDeVRzZ1VO?=
 =?utf-8?B?eEtYamdFK1J1aEFKdkdSS3FkN0Fjajh6MFVkVU1EVUY0T3pOakVFcnU5bEx0?=
 =?utf-8?B?VkVIZDJoNXhLOXBQVnBwMnV0VWVkQWtZSVpjYnpQNWszNTZLeFhTaE9nVmth?=
 =?utf-8?B?aDFraWlMRGM4UGpHaXlUeW1DYWVEZUJQeEFubU15RUJsK1MrUUhYNEszWE5t?=
 =?utf-8?B?SndNT1RSbjBuNlZIN2xIVkVZK3RrTlAwWWZwNWhuKy9PNmxza0hRY0o1YkZR?=
 =?utf-8?B?dW1qL2lCcE1mYmMvQytxUGdMcGJNU0xYZjVNZ3BMenduczRzZG9LUVVIdEVq?=
 =?utf-8?B?di94VWgyaXkyZ0hiNWRxQkFkY1pJbXc3anMrVWZrZTVpa1Brd0tMU25XV3pP?=
 =?utf-8?B?N3FlZnRkN0xVUG0xeDVDUmlrenhoaS9zRnh4S2pVYXpld3BOc1ZlMGk3TlVq?=
 =?utf-8?B?SXR4MmxTK1JES3lzek5UZUtTdWNoanFvampONmovOEhxTTVzOVAxNWhjMG9D?=
 =?utf-8?B?OTk2b2gvRzZBZVhVUm9HN2xTZFpqUXV3VjFSRm13WjRSb0J6YjgzQkE2eERZ?=
 =?utf-8?B?N1NzUHBIMHdMRENsQnE4OXdUTVhaUkt0dEYrZHRUSlBnUy9uRXB2Q0xZaDA0?=
 =?utf-8?B?ZHpWb3VzVGZwMFlFNnFJeVhyRGYwMkNtbHh1bGdpQ1JCcjZJUGtOU3I3cVVr?=
 =?utf-8?B?ZlJjQ3NPQlVJTlNGYnZZa29nSVVxenZCczlNeW5oaVlZSXlyMUgvb3NIampL?=
 =?utf-8?B?R3M0QjFyNklWSWJ5NVRYdUJ5WmNXVytOYTlQbzRzZDg1djUwN3M3NmlvQUcr?=
 =?utf-8?B?Y1NUUmU4ZjZNeWZLVE5rc09VY1dQbklaODc2QWpVMVlUNWEwcW1oK0RySnlw?=
 =?utf-8?B?dGJYTWVOZWZxQklEOTVKUGxDZmVhZzVXMGJYYmdFdXhqV2Jad2g5TFlaYjJL?=
 =?utf-8?B?c3c3cUNCVlFHT3UyUjJIZHliSW0rU0N2Ykp0VnJSYWR2dkpsaU04eXBUMStq?=
 =?utf-8?B?R0kzREdNdGRFemFlWFJGL1VvM0V3QmNxbm4vQStlcGllZFNRSGFKU1FtZlFl?=
 =?utf-8?B?cllGaEJnZVRRZVBFSUxGcUg3dTExRnhKRFRjVHFFY1Q1N0hMczlPL0YvV2tR?=
 =?utf-8?B?b1RPWmdZOHR5Q24yRUhTei84c05WYS9ibk0zTzR3TS83WkRCS0duay9xZmZG?=
 =?utf-8?B?WFJIUDhEK0xveEIwS0F6ZEJEb2pScDQzSWlxdm10cnltbC9ydkkxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1ee3b7-7a4a-4330-7107-08de739975c8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:40:07.7719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ScSpbKEZnAwEmFZoj0fPTSqwaznP2Y6mP1qn+TAouCL522NXcb6vhmEBsvstDDCAUZdQt94owdyAmL/jb2mUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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


On 11/02/2026 10:12 AM, Dariusz Sosnowski wrote:
> mlx5 PMD supports flow mark action which attaches additional
> metadata to received packets. This metadata is stored
> in the rte_mbuf in hash.fdir.hi field and applications
> are notified about it with RTE_MBUF_F_RX_FDIR mbuf flag.
> 
> When working with HW Steering flow engine,
> mlx5 PMD reads the HW completion entry field with flow mark value
> if and only if at least one template table with flow mark action
> was created.
> Whenever table was created mlx5 PMD updated the private
> data of each Rx queue to inform
> Rx burst function to read HW field.
> 
> Whenever application reconfigures any of the Rx queues
> through additional call to rte_eth_rx_queue_setup(),
> this private Rx queue data is reset, but information
> about existence of flow mark was not restored by PMD.
> As a result, reconfiguration caused applications
> to not receive flow mark metadata.
> 
> This patch fixes that behavior. Whenever port is started,
> PMD will check if flow mark action is used and update
> relevant private Rx queue data struct.
> 
> Fixes: 1deadfd709f5 ("net/mlx5: add HW mark action")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Bing Zhao <bingz@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

