Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A00E9D3FD
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:14:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E386F402F2;
	Wed,  4 Feb 2026 16:14:03 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by mails.dpdk.org (Postfix) with ESMTP id 31DD5402E1
 for <dev@dpdk.org>; Wed,  4 Feb 2026 16:14:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x78uAVPYoi8EiOL10atKJleq1j276z4k0hzaXoSc5ME705QhqDf/FCMhNB5CEYziKTKH8FJSdSNk2ddBJIKbXl54Jcm5vX+jE0HQtq/gvlJxAeV5VuuEzebcgmefk5DB7ENbKdaPOOwXhCqQBLDLvX8hz5Ux5TLWzhZqrB7FuyFLUPuW6Vw5tAMHa44oSY8Y9eikaavU/4JC0NdHNe3q1jbZWu1AOnygaDOkwjoWRtefwwkvFuMsGj0piNqOrTGrairjvvT3dWziic2OYF6b0Kq359RjLoZB3sabe2RJG3NL5Pjv5wNPacIHJuIXBb+UOBChYzXVxc9KcmZW5Is0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG88KTsyPtn6r4hq8IK8CyB/qTBRZXVKnPWDZ0y/9Sc=;
 b=t0AT4WsfUPl+RNKuCsAUgAD/L/XENfV17PZ3fvMf9tWsn19c1/QC5fnwU6083aYkQceizQm9Wyf78rRh0qBIP2wBzT8XJ6wIHT7lHlGqQKXoygwDo4vcY0mdoJri55kqLBc9s/OGwMrUVtq5u2JBEvtZ0BkM4jPozCxhJSzOHAIEA1U4d5fXdwgkYYB1+/fDJ02fB3KD2OO+NZq8IaynmYfIZT4/vpfnVEtw2n/GLO1HKYerqh0RMgPIZz1AwkjJYGmhOBCjBFkOW1bTXJ7R8PaAPJu+/16RVgaqQ3QJeUw37OABkPk01HanodMOHgg0fJ0dyvK35ckRT00xgVUqZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG88KTsyPtn6r4hq8IK8CyB/qTBRZXVKnPWDZ0y/9Sc=;
 b=Cuct9bu3GH9zaRSZo9tbfsVUVJSjCN7NwxTP+TWIbgOQsQFEtcXOYl8GJhAqho4RQa4Q+mbQG/Ud/72pWAf8DMYw8fG7tWx7pH445ueX/QwCL55Hwf+P+ommb1iVwhqiKUQ2ZMO7A9DNEW9JOAnYwdONHg+GOWmhLkZHMqS9BfD7pklZH3SAGuv3WnSbX02gg4gmZEg26K5g39OaC6MPpfvZq4vnE/NDK/XyaqNz0Ab691vspF2fxDOAxuUC74O6bTK1uLis7gyhf7nD4dNoBzaxYtUKT/inwstXaKwpL+HXSIbJuoJQIfLCmyDvc7TXWsLJQVUKYiF0Kovi6CroVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 15:13:58 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 15:13:57 +0000
Message-ID: <b059f373-9aa3-4b2e-9a32-ff18ad6c946d@nvidia.com>
Date: Wed, 4 Feb 2026 17:13:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: fix metadata sharing between E-Switch and VM
To: Gregory Etelson <getelson@nvidia.com>, dev@dpdk.org
Cc: mkashani@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
References: <20251123101242.1090544-1-getelson@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20251123101242.1090544-1-getelson@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 5202d05c-ad23-40a2-6a2d-08de640004bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGRWT2FCY1ZULzZEQWEyN3ptOE9CWWR3cFdrdEJoMk9kUDY2Smh3a2VrVlBz?=
 =?utf-8?B?REF4UzdQVTdyWHp2VW1jclFBQTVRc00yd0JoMDdDcjg4cGcvSjRpZmJDRmEy?=
 =?utf-8?B?UCtieVJVVTdLdGVTaGhPR1RQU3Z2ZGVYVEN0bHVXd2p1UlNQU25xOUhrQkpr?=
 =?utf-8?B?VjhyZzIzM3NEZjh5REZQUGVZa3RYNGFTNWZtUS9PVUtTM2RrSWhlVVNkMUJT?=
 =?utf-8?B?blE4UVp6RGw2cCtSOU1EcjJYUERQaE52Nzc2ZEhUdWhqWE5OQ2FqYUxMZEp0?=
 =?utf-8?B?UGJGMHpjKzRsU2tDTEtTZ3BxYlJncHdGY3ZYU1JiMVlpUnczak5IYSt5N1hO?=
 =?utf-8?B?UHpXMlF2MWpIYTduN1VkcW53eXhuRGhNZnFObXZNYTV3VzhCcGZaZXp5UXBR?=
 =?utf-8?B?OHZXa2J6ZDVuQlVTZWZISGI5b3VmeTVKNkswVHJwTnp2allMSHpQVzVSMGlY?=
 =?utf-8?B?OTRTbGw3SzNXVzFhcWdmRFlNUUwxcFQyNk4vTUZLTGNBdW8vMnRzWDVnNG5W?=
 =?utf-8?B?Qlc1SjRmZzRKRVFPeGd5U09lTk9LWFI2SlRaZ3dBQ3FUME1Qb3IwTmlGeXd2?=
 =?utf-8?B?bndjcVphVG9GYUpqOUZrNDZETmdMKzBSdjZ3Y3Y5ckJZaVBIRFFQYUxUOWlV?=
 =?utf-8?B?UnB2Q2NiTGN3OGgrQXlVeFB2WDRXUmY3MDZJdFRPdzFjOTE4bFdUS0Jvb001?=
 =?utf-8?B?SUNPUU9rc0l0MEJqMkNJVDNhQUZsM2RuN3UxMjIyRUZQQ3ZFNUlQVjNxT2Fk?=
 =?utf-8?B?Zmo2dVdQbDMxbng3TkZLaStzNGhGMTVEcjI4MVZVak05bVdyQ0FaQlA3UUVm?=
 =?utf-8?B?bXdRUkdOM1VaUENjZ3o2aE9MWENQS2lNM2EzS1RSK0lUamFLcTNZUENRSXNi?=
 =?utf-8?B?V3ZuV1lQNVBZbXpHcDlka2lieEEvcXZuNHlFbk5FeSthWWw3UzJ5QmVteXlv?=
 =?utf-8?B?VGJDVUJpeURYQlZVSXhRNkxxbUs4VkIyNFlleEdQZmRHTHJheUdiU2FEYUwy?=
 =?utf-8?B?bGhUN3hyZjdmcUg2Qm1LMGNrZ1lkUVpWMkZMYmNpT1RQOTdNc09kSkdyK1M4?=
 =?utf-8?B?cWRkc00yb0ZSaVpMbTBVUmtTY29UYXh4ZkgvNlVOakZkS3k5bHpFcm9JRnFF?=
 =?utf-8?B?VHY3bmJpTWQzK2FxOUJDdmJxeFppc2RHTitQbiszaUpQMkt1MURERGQyd2Q0?=
 =?utf-8?B?bEZXWnFNM3liTytrNUNCZFkwQW9YV0MzSmhIL3B3eDVzUkk5aTZka0FYMTNH?=
 =?utf-8?B?bDN6d25EZFRvalgxVCsrWEhTTkphWHg1VExzd3BXY1loTWprTTRLRVI4QzEx?=
 =?utf-8?B?Y0xWdEx4N1AySGYrSXNXaHVVRThNT1pWSk1ZNlhBN01tcC9PRlZXR04zZ3ZJ?=
 =?utf-8?B?OHk1SytiVHJNQ3FzdWtoaUo3MFE3c1lmS01VUVVTV0Zycm1ZN3lTQVU0ckYx?=
 =?utf-8?B?bkFDeVV0clo5UFJMQTY5b21mVzlnMkQ4eElwc2RuSGROWG9BTE94OURwbG42?=
 =?utf-8?B?dmpKKzA3ZStqMVAvZGtHZEVjcjdsZ3NNSWlZTWRIMlF2Q1VIRjl6R1hTMUlh?=
 =?utf-8?B?dHp2NHk3MkxVTDZVMi9SbXYwbjQzdGxneWpPV2x5UzM0RGJVcFQ4aHM5emZm?=
 =?utf-8?B?S1VtK2p2ektQQytiSEx5OTZlWmNHTE5CWlFqZzVqTUhza0YxWWtMZXErNzBp?=
 =?utf-8?B?TWg0MGltVDVnV0UvWjU2ZWRZRlI3QjlGSWo2NDBDb3hzaXo5aGMyNksxTWdD?=
 =?utf-8?B?bVRKTkZUbkt5eEMza01rdXBVamR0QnRaSThoUHlYZjVDMDdLL05oMklvUWFw?=
 =?utf-8?B?Um55ZW9RSzNNVDZhSUwrL0lpRjl1QWtCNzZsbkxqVjRRTjB1ZFRncXlieEpk?=
 =?utf-8?B?Mk9uaWRvNVZnbG1Ib0hJbGJvanpiUEUrRmc4TDNGeS9WTjBxRW5TVGVDQ1Nm?=
 =?utf-8?B?N1BOTm4xOUVtcWxLM3FyRi9WNjVxMFJJZFNHUWl6ZnlvOWczL1d2Y2JjR29D?=
 =?utf-8?B?dU5GOWFwUk5LYy9peWFWOHBJUFpmNW9hSVorTWllUGVtcHNNMGlveDVHSytE?=
 =?utf-8?B?SXVsSzB2KzJSTDVaV3VWYmZjYnpWUytmUkp3NXljWU4yQnJvRkNnNHVJb2Zm?=
 =?utf-8?Q?XqNU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2JEaFJhb20zUEM2alBEZjc5N2F3eVFrU1BGeDdPSmwySEc0OFZ3ajhJbko3?=
 =?utf-8?B?T2RkamU2OGtEc0hoSmFUc2NWa21FTzNSSWhQNXV0MU9LdDJuOWtTTm1EWDNy?=
 =?utf-8?B?MVZpRHMrTFRmdnFyZjZqcml6R3Q2TkQ2NmdsbFVOUi84L3FvNzE4ZkZWdjRM?=
 =?utf-8?B?enR2c1Nsa0xpS2JFR0NKSThMalFVaWp0YlhNajMxeUlMTGtlWGhWTVVYdVFG?=
 =?utf-8?B?eWJrYkxnRldwYUh3SjBqdFpxdkRvdkdjeitTVzN4M0JFbndJM09sWUpvcHhB?=
 =?utf-8?B?TGV4b0xHdzVUZHpUMlYzZjhzN1Z6MFF1TSsxaFR1ZUw0NzB3VWZsU3RnOFFR?=
 =?utf-8?B?NzJpOEtQc1ZzdGlLKzBZL1hyL2plaUJWczdINURrQ29sRS96S0NyQ0NHNGNN?=
 =?utf-8?B?SzE2MkIxQWRsVWxwbksrRlpIWVF0N3RtQUlEQTVRUERXbCs3bFhLTmppZVBj?=
 =?utf-8?B?WjdHVVJzTEU3R1BJWXZOdHpYdkIrL3RFbEduYzBpamozUW1FSmJ1TG5jVC94?=
 =?utf-8?B?T2hNSm53SUxzTmRSazdlN3lMYWpHK2RURTZEYlBpcHgzU1U5TUZKeGdacm9S?=
 =?utf-8?B?b0VwQUNiMGE3STFTYUQ1cSswN0piVkJHRGF3N0djd0szL1BKWkc0U2JWZjI2?=
 =?utf-8?B?QVRvWHpUUUxQUXNVQXVYOGZkSUllU0tJOFlBblZrbko3cTlpQ054WkJmTFZa?=
 =?utf-8?B?RkhHNUk2QlJSNVRIaUxqNzIxbXFrVktrUGNWSmV0VXlpN2N1MmFHNE05cnd6?=
 =?utf-8?B?U3crNklHQ3cwbXNZS2FzOTRMSEdGWkEvdGh4WlNJK3htUit0b2I1cjQ3Ykk0?=
 =?utf-8?B?bTY4VHNHY0QvNlRVZzdGUTJjSTRkVVFCM1F5d2NVRURIbFhxblNQNE1lYnFP?=
 =?utf-8?B?NWtuWEZRN2trNGsvL3JkQ3JkWC9BL1dXV241MDg0V1lzaVRXdHd6VEY5RWtj?=
 =?utf-8?B?c0xGYzRxL3l3ODB5VlRpZDNTQ28vMkZCWTdCSUtWVkd0d25LQWVrQkpvR0l1?=
 =?utf-8?B?YnV5STJwaldKNEFxYlQ1ejNTSEFwODVaY2p6TDlKbVVoZXYwVksvOFJKY1RW?=
 =?utf-8?B?dmVXRCtraEZXNXhNM3UwVVczR0k5cnhVYmJCTzhKcVlXUCtiQ2UwOVlTMTZt?=
 =?utf-8?B?OVZuQUpjSlkxQkZoZTVLTERWQUdDeVFDR3RlMDI5eEs0OGxzUEZVdnlqeWlQ?=
 =?utf-8?B?TmxpZS92bjlrQUpZUmdtRENub0pkSTlTR1BoR0ZoZjNiRVZwQTZhRW1oMTZa?=
 =?utf-8?B?cXZWSkhqS0ZrOGs3cHpiNG5lSVBuazdNU3pIM0FKU21EL0hBZ09hU3h1akRk?=
 =?utf-8?B?NnE1NFkrNUs0a3BMVkNrbFprU2ZRWW9VQWsvck9DNWFOK3JFWTlwWU1oR3NZ?=
 =?utf-8?B?bWdXY0ZtYmVCNmIxK0dVQVFVYlE3anBuYzhOYVVQWjJzZkNVSlIyQ3BMV2ov?=
 =?utf-8?B?Kyt3RHdSTi9zQmd0djN6NnBQVXk3SDJ3bksyWmtiZHd5MUNZejhHblA3ckdV?=
 =?utf-8?B?V2R3V2U4N3A0cHlhVVJiQmlnOHB4eUhlYlVYQnd3SHBQdnFhamRrcUFSSVNj?=
 =?utf-8?B?S0FBSGlmaFFtMVlTTElZbExnbG1ZckQrUkt6dXRBKzFScjUraWZTcXJVbXU3?=
 =?utf-8?B?TXlxUlpFZnJKNXRGeDVYdEo1OWN2dkpXNzMxTittSUtKaWRRVjhMVFYrOFhZ?=
 =?utf-8?B?SGhkTjRDUzVYamQ4eU5PRVdlSFNjbnFFNFBpb2JWZ3BxS3NkYm1wODhpRHgr?=
 =?utf-8?B?em42dG9CNisrVW9Gd1FvMkVvamxWWDJITENsa3VOU2crZTExR0ZQSGFja0lJ?=
 =?utf-8?B?YUFIbVFNa0JkSStEUDNkajFhK2lGM2hCa2JGZDh0MC95blVnSWl0bTNGSWNu?=
 =?utf-8?B?Tk5UVU54c3VYU0NhL2U5eUZLRXk4U3Z1YlZCUjF6ZHhxRHJHbWZWNExDZHVn?=
 =?utf-8?B?b0IreGVTU2dBRGNOSFY1ZHI2b3E3WnZkTG5KQzhvKzgrTXdLUExmL1dTb0cv?=
 =?utf-8?B?UGNacmxUL1d6YlhFelVnU2VyYnZoRjA5aDlJT1RycHlaS0ZYd3FRclR5QjZK?=
 =?utf-8?B?dk1TUjJUaGpLNHlHN0ZROWlVTG12cFFxTEJjUUpFM0ZWQmR4TzZyWDVSaWx4?=
 =?utf-8?B?ZTR5dk1HZ1U2MmFZbkFybjBCdXEyQzlKMkgwU1BBSFZLcysrUmdWcjhlcEhS?=
 =?utf-8?B?bEo2SC9uUTV5L0xrdHIzSDVaVDZ6blc5R2hwQWNobGtESmdCTUlnVTlObXVY?=
 =?utf-8?B?UlNPdHRBWnlmRzNRTEtLYktUcnZGeVVpY3lBdjF3OVFMUDY1NjZmRG5pUTFy?=
 =?utf-8?B?MDNJc0QvMFVlbzFrc3dlZXE1Q0NNbmxnN0FQSGFvdUZtL1lEUkc4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5202d05c-ad23-40a2-6a2d-08de640004bb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:13:57.8349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJ4BGdBTU2xKgZjcdqrejOkQXInPtATsdd2l0jQojQh9PwbFBx4kbZ7PYsvuRd55Fb+6mVV0iA6EAXv0I+vAyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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


On 23/11/2025 12:12 PM, Gregory Etelson wrote:
> If metadata sharing between E-Switch and VM (multi GVMI sharing) is
> enabled, PMD creates the default metadata copy rule from register A
> to register C_1 on Tx.
> This rule should be created in group 0, but due to an incorrect
> condition, it was created in group 1.
> It prevented propagation of metadata from an application.
> 
> This patch fixes the condition by adding the missing check for
> external rules, so egress group translation applies only to
> application rules.
> 
> Fixes: a78425ba3793 ("net/mlx5: support flow metadata between E-Switch and VM")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

