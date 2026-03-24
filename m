Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AB2F54ACE
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 15:28:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B43A7402D6;
	Tue, 24 Mar 2026 16:28:43 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by mails.dpdk.org (Postfix) with ESMTP id 6A83B402BE
 for <dev@dpdk.org>; Tue, 24 Mar 2026 16:28:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yECinEf7eOUzJVEYY6d5z19Y1/5EVfbzHZ6RFLfNoeTADA/rjPLhf62rGU1xERM/7M35TIpsgzewYO4o5R+KM4pKV+coK5jdU4M4DvHu1ZC1SeZxsxZONXChSW9zI8XEdRuq6b176muj01buAj/BPdBtXEEJORLwGK2Ctq2j0PTjUPFIX3gJioQ4bRdPdyA/Cs8gjXy07S/bE6QbWrSfw7D5dsEARDmfITgpP4BJvoOSIADhl1KUafWBobrHHpRDSMZVCBFpmqaDIqI6x/npKmPx8dbzYaDdI66NdvnaWUwBjOrVrMVDfVFJpOShwLyhg2LvRNTBaD8hZh0d0xgHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NSuLPuqSSeLVgArnBYQp3yi5X+xGnR3Z24uF6uaP3U=;
 b=k+9WR+Z+5Yit6FZG0EFz+EZo94/YbQ8waT7hXVqOAyUYrIOmCqdoxBz8ggSZ/p2fAnC0pUblT7pa+ua3Q4jj2Lk3O8vb4e2Ur1Xa3EkTdLC7Iu7YskomFGImRF1iWdesldFubM2RJkOReSODK4K/es5MCKW0PoBIVgCKkJl+mgUMIVEAe4y1b+hld2SWYZFbY5ablc5KHgMs3ySkg1hhYl6eDmgjIA0G462xiR2hpgkot4hRt2om9aBAZf5ADXvewwJiVUpepExrUdGvAQaUuEkUp8/t4OP+HuTDQa2c0MbujraQq2JwcKokRS8d8dhjHPISk4jmoFP8CfuG6VpJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NSuLPuqSSeLVgArnBYQp3yi5X+xGnR3Z24uF6uaP3U=;
 b=gGPk89LmXAaRuIq7M5Ur0M+XDElGyijBtd9yV1YINWVpNBJYCEiB1iqErsf2RVpIZvkol5Pncppk6WJvUVQqkNEZ1r2LG7aINW1alZFroLfaJwpeJFO8xWL49JzU/Pdq2MjUrAmPZeL8o4zi2+kQWfgauxfN8nlMLyjiRtKsxxsSMJFkbJl9ih+JEPpPKYkEaug3O8b53YTNQyIlDmXxIIlGGjgyjLyvGTaLVhyZxGZb8WXB9NCymDDDH+3dMlXBTAKALvB8dVWfJybTxitx9yiyHvC17QOXqP+1xlg90Lk8jhQvwe1X/+MFQG4dhW3luFrnzoAPzOBesepER/AXFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:28:36 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 15:28:36 +0000
Message-ID: <eed95506-15d9-44b8-ad61-a321336751fa@nvidia.com>
Date: Tue, 24 Mar 2026 17:28:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: cleanup unused olx parameter in Tx free
 routines
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, dev@dpdk.org
Cc: matan@nvidia.com, suanmingm@nvidia.com, dsosnowski@nvidia.com
References: <20260323101345.393740-1-viacheslavo@nvidia.com>
 <20260323124110.425154-1-viacheslavo@nvidia.com>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260323124110.425154-1-viacheslavo@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 36789aab-0f86-498b-b189-08de89ba0473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: hh11s81uegeWViT0ZL62MWmt1LpcaqoAjbaeKqAyBjZL1mUWFZ50ftfpC9sd3cU0AUtx8jJ6TqjcJB0nbihMkEce7jjMzyatoAHknKUQLE1KwpfkV0J6pC8gGnE5kU83Xr1vO+i/7LpIUlI59VueZEGUhQ/THXe0B+NzVq72hkKGPVSB+QIs9SFgwoDRtMdRORVnrvX791zEKeixNyCYHuzsKXkluHg5eNr+QOiY92zTPnbKN8KRGYkI0PfTPj3pCTCiSXCMCxb9LfBy3JylWoJQGTyTRA7kZ4qeRdoKQMqDXtjaNPcqnvoeqpFRKtNeUBIJ15fgvdECCsabo+kZ77ncJ8y1nQkPnjKIuLTWSElpQuQeZk+eSh0jMOFexpSOUrN2Mhhrq8lAOFHGLKPxtxg2/2Ti8zJ4BSXqUDELR9a0hXCoBGzI2p4L9wjcC1JWoGLqOzJuDqwG2Ne2jTfURgvkeA5c/E0DGTqnBm9Dmjj1HFiv/6GirS/dGrWl5YJiBljtKYUCm4nbSptJEEjVFySCISaKWvlzMJYgXChTe5kXLXVrr4f3w+VvhMQB5kYx27OWXWvmGkwAubd5Pj/NPjpfe7fkrGz3rc+EmmwoP+4ZLsFOs38goO1A6aPas4oaJixghnbmIswWwvhEFN8t60aMEKuNXXMXlYOZdcu2YZTCuealyZL8WZPpUFL6wyqci3S+/k/CW3SiOZ9HM01AxfgGaqZh/hwPiFc8lwzbjKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnUyTmdrWExFUVRURUNJMFVkL21BN1FOQ0E0SkMvQjdLQ0tJMFRkbWFCKzE2?=
 =?utf-8?B?N1pMOFRkRnNiM2EwMEx6N0ZhUytsNXVnczFQMS83ZFFibmpzNTlsODRlY1Rp?=
 =?utf-8?B?cDloSHhTaUNIcUV1UmlXbUFIZForQ0p4S2xaNzkyOE1qMHkvQThXSkFFLzY4?=
 =?utf-8?B?enFlc2RRb0RRMmxpcy8ra0pMZVJtbGdnNkZuR1MwMzg3Q2ZEZW5BSTR2ODZx?=
 =?utf-8?B?V1V3TFoxN3RHVVlCUFBxN3g0VUdaekVIWFNNdHRoZE5WUktpcDVacnY5djFw?=
 =?utf-8?B?cTh1OCtIbHVNWm9SNTRxbWdhZlNzZkVQMThxM1hqbmEvQ0I0RTYrM2ZXVWRY?=
 =?utf-8?B?Wktud3ZXaXVjTGZLNnlsZlpRaHQzT2FhQnU1QlVhSVUrSzhKWGF0MGZ1NE43?=
 =?utf-8?B?R2pkVzFrTW5KVFVlODhXQkVIRGY0NlVVU2dWNXNVODJiUGp4K25qY0Zad3Jn?=
 =?utf-8?B?U3c3eCt2VGF2WE5ubEJVTGJ1TDJBanlVbkhIaFBGVThiMjVObHA1VVl0Zi9n?=
 =?utf-8?B?Qm5QUWR5b3pKS3lacFhZa21mMDY1SjV5M09rblFvZEk2S0VLamZFcWhGK3R1?=
 =?utf-8?B?cHZEVTNRMlFKaDZ0Z3dUeTNEQ0o5V1RHWWJucjF5T3NiZ1FQWkZjYjgrSnd5?=
 =?utf-8?B?em04cW50aUlvd3lTZVJpNlQ4ejB6eVVEeUlpaENOblowSGRORGxOYWVqNitS?=
 =?utf-8?B?blNHMDdhWnprR3BTc2NiMlhWOHVoVFZpUXRlTG4xT3B2VVBodStwbDdUNHR5?=
 =?utf-8?B?SGdwRm5QRE8vYjZ4bUtzUXIrZ3paaVRJb2xKakNTUldzV2Yyayt1bkdVUVY1?=
 =?utf-8?B?KzVMNFlQZ0xwOUVYcWtqSnBjU0VndlhKdlpUaG80VFBRUFU4TGMwRFloYmZa?=
 =?utf-8?B?QUF5M1VLcEsxVDMzMUxjSHlWVHNkUG9sdFlaV2prWUFvN1phNVhweTN4RkV2?=
 =?utf-8?B?U3JCYjhsRDcyc0pNaE9mZU5qdTVVNW13QWppWmErVFZGU2NYZmFsUFZkU0lm?=
 =?utf-8?B?OUtESUF1Z0txelhoWkZ0aDBQc3ZlWWc5QjdHU3p4VGt5cFhSWGZIK0JyS3RO?=
 =?utf-8?B?WS8wREVtUFFvN0RxazZ1b2lCY1dGK0RmeTAzL3dSL0dabHpBbXcrTDdUOFZa?=
 =?utf-8?B?cE9hS3k1TDhibG5CUERTTnJJQmZLdVY0eGFjS3ozV2ZwV3VJL0ZnRzhQSFRZ?=
 =?utf-8?B?elBGOHpVam9GbmtrVG1BbnZJYjMwak5LNnN4TDVqbmdsREFpZ2VrWlJOSzFK?=
 =?utf-8?B?Mk0vYXU2UndoZjRDMTduZmdwQjBYTTlHY29GNDVOUnBxMVpGYmRmNTdNdC90?=
 =?utf-8?B?K0FNaHJ6WnR5aU9naHVSbUpQZ0w2Zkt3Q2E4VXE2TldiYTNYNmdFVmNsSWN2?=
 =?utf-8?B?anlsdFY4Syt6MXZkQkx5NitoSEl0citqc2luL0djcW9BNzNjRTR5VjJ2ZmxJ?=
 =?utf-8?B?Zm93cHFoNTd4ak5RdEliWUVOSjA5VGE4RjVGZm94bEpjYk0vTE4yVmJyWjM4?=
 =?utf-8?B?dGo2YTR5WTJXRkU0RTA1blFpQThZeGRlcSsxVXpPVnBmT1dQUVViMWZxWkpL?=
 =?utf-8?B?R1dnZU1vRDZBLy9JVm9Mc21OLzVtQnZ3R084ck1KMVhEV25KRXVJN0Jyaklh?=
 =?utf-8?B?eGIvTnNwcVAvZXAweVRiaVJEaUI3dFhyVDR3R0duMDJsUDFVeStobWxvZUVn?=
 =?utf-8?B?RmtycUp2VmhpUjlSTUU5cmo0RVRnYWxMSXF1VlZsYjA3dGU5a0hqVXY0WWJ6?=
 =?utf-8?B?V3pkWHNqNlVaUkVjSFlGeFRQYmFyVE5OMDRmRjNNMm5Tak5ObnIyVGUzaHZX?=
 =?utf-8?B?Q3c0NjBpd0pvdnJiOGtmL1YrWHVUakVKeldRK3Z1OUlmT3VGeTMrYXR2QmM0?=
 =?utf-8?B?b253Zy9XTVVuYmpldjVnNmVmb01nMjlGWlI1d2h6VkI4SmRFMkw5VVlvcWtD?=
 =?utf-8?B?RmFwWFZZNUdEOVhubG1iY1J1eTV0d1FuM1JnV1UzSXJTbXlMUVNmbTQ1UFpm?=
 =?utf-8?B?Z1UwbnR1c2ZReWlqUi9ubFAzS2pxUk5LRjU4K09FbGdQdUV6K29QL0N6SStF?=
 =?utf-8?B?UlBmaHZ6VjZUQ0N6QjZpNWMxV1BBNjdWaVVzeEtvWWRyTGNRVk5laGJETk9q?=
 =?utf-8?B?UHE3dkhHUmhGMCt2cmU0b1NWRzVmZVFQVUxaTXFiMWc4L0JjSjdXK0tyKytN?=
 =?utf-8?B?UXY1ME42allBVjhENThqSjJxMzVJNnQ0UDUvbUtWR0JZN095bjRJZm9kandh?=
 =?utf-8?B?SVcrZXd2VkUxK2NtYWNZYzFlTVozRE1KbUdGL2NrYlcyM2l6UElDc2hnTldL?=
 =?utf-8?B?UzJzNXJCOXdQVTUyMEN1MUxLMDdNY2RGTENlTEZ2VHVWTDdkMC9Kdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36789aab-0f86-498b-b189-08de89ba0473
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:28:36.8282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grl4p7Q1oWvbu17z6Jfd8rSlL7zZAekziv+qO7bo5qjrW8ZeuNjwfhH9rTf2Cv1H5fPyoXr4ZtSgBiVwkAcztA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
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


On 23/03/2026 2:41 PM, Viacheslav Ovsiienko wrote:
> The olx parameter is intended to be known in compile time and
> widely used for static optimizations while generating the tx_burst
> rotuines code from the template.
> 
> However, in the mlx5_tx_free_mbuf routine we have the olx parameter
> provided in runtime only, for all possible execution paths. And the
> only intended optimization (that actually does not happen) is to check
> whether multi-buf packets are supported. As fast free offload is not
> supported for multi-buf packets, we can simplify the code and get rid of
> the unused olx parameter in the entire call chain.
> 
> Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

