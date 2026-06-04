Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6ACD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 09:36:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F23594065D;
	Thu,  4 Jun 2026 11:36:22 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21]) by mails.dpdk.org (Postfix) with ESMTP id 8200040151;
 Thu,  4 Jun 2026 11:36:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmE7QtscRFq4v5yquBiLLVAn6GgLIHIZAxyZiEjxxZHpgsIhSyrhuV7M0s74w+6i2u9mldZvljSr7c8gDPZfdOug4mbKKRDF/8PtdNtkVjVemOIMeMgRF8xPNMYa9LaLHh985A1aaTeB8NeLIbIczZdO95E75AgjOM1EpU/woi2FMVsX4akA1yg5jogUSayon4/INKoyeYmLdh3LEh18MBOI28Y4gNAYNT/8BPB90RAg7ah2kfY26VXYs60vFtNs/X/3wwCBF6NBIz1uuY+TLmiaoFC8ZDLjBkUN7YlFpXy9UEPohkh2WTUcXEhRv/14fhJZwiM5zsFeJGW4wOG2BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w65u93JxDD2HEm5mXNuuOMhx4irBmoYB+g9pJjkmxj8=;
 b=j8UFS5w8cU8VTnRdjG7JvReefBNZzYs/9czVNHNV9nqb74nFeea4FxN9AF/rvzo3edt/JQHyvpOLX7iSUUDQSrqpbJ7TA75Iz8FdoinwLsvphjOV+zV+QbbwxsPRmnozw0dR4Xq9QiViv3yYIayewt7UT0kgq0vyFZ8m1fiIhWoq8UO5UHmwZA5B93jDpWD4+6Gb9mwqT58q1//pErWbB1RK5inBZud6Ie5VyvUaTR4IMC73+s3AVlWmZWp9YpsEbheJ8V+fbGF1a+gH1KtFd7zT7KOOQa/ry4fHxCtC75F8wC/UNlozSdYyJTflWjPRGC8dBgBs/R7iPGPUmGuiBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w65u93JxDD2HEm5mXNuuOMhx4irBmoYB+g9pJjkmxj8=;
 b=rWBpQYRolIKLt00yGvOeM21FVK7gB0Yp/sB8lSvsfUrDBRTqKwXpRptb5/RFSnXMm0akj0bxWOzrdb2xRyL2xx/qtd8Kbq0a34o0VIFIqIShk4Fs9tPgZk44SmbsL9EL41lJ6Z+JSoSUO28VwPxS9T3rud5IOS7rrV+65mfoZB9mZmol/+nIqASrAkgjPxYJLOltJWB5i3i7iWxYjimQ4bsOSK8S9b9gDb6GHmthAMEX2lcOcpkCn2GpnMaKCpWbdpGyYFDlm4eUcOoQnQlj01CEU1uvvvbG7Z1znj9yWLuLq4J6fVofVh6lxNnbhHmsvQCxua7THW3ymMCxbggOSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:36:17 +0000
Received: from MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84]) by MW4PR12MB6754.namprd12.prod.outlook.com
 ([fe80::baee:e8cc:6cbf:3d84%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:36:17 +0000
Message-ID: <66253785-b2bf-4e4d-a905-96559143c688@nvidia.com>
Date: Thu, 4 Jun 2026 12:36:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: remove nonsensical flow action class_id checks
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Michael Baum <michaelba@nvidia.com>
Cc: dev@dpdk.org, Michael Pfeiffer <m.pfeiffer@syseleven.de>, stable@dpdk.org
References: <20260520132533.159996-1-a.schollmeyer@syseleven.de>
Content-Language: en-US
From: Raslan Darawsheh <rasland@nvidia.com>
In-Reply-To: <20260520132533.159996-1-a.schollmeyer@syseleven.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::13) To MW4PR12MB6754.namprd12.prod.outlook.com
 (2603:10b6:303:1eb::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6754:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 746944df-3993-4a68-e5b9-08dec21cba21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: WLFLQF/Dgs2UWEJt7vdN4yZ3IH9HngtBHnzqdAg6w9A4S3c5P302vG/PiOGiL+6a1ynB8snRsGMdIiKlBJ/ppzCOcKsOK3jGYtne/yAgZBasT28iobdVfImfkgzhr+H3bCHV02ZTIxkC0Mf458vMsEosyhJcrWgdw0Yo2JiSFbmCs++SNYcbxGchhRJxwVknxEiOoizREKeVm0KZHGkOBFIIyvBqNMQFQZsmCQVtRlGJr5kgER3BWK/KkojyKZ13ZMLVVe0swQDsVXviQDnVOuG00JtlRjaSPpahQilsIPMmkopZ4xDnLa/A6RP8JafWYGhWnACjL9jxael0D7r/FRsvYlt758RYBKC+mvHcgrfINxPNmLnUekOambmMtVqNLmMsTDvm0R7w6wvsKwmhRnptIYH9adOTMJavZHtetfB/eGf5feJ3G/2TN2jlnUb8CS2gWfhnOfG29qHbewK9D2n0fiwpaJpeRsGqpyRXssTZGPs/og5xHkuffyIeoibT0xQY/44JFUU67VJ66sBaUc8moq/caYBenEcCeaLxt4oK8Ct+KAKl+yMjyhwmyFJ+JbWUuvnZ1Utt7W2znhU0LwZRoPtIPVxJV9vk+Ru9lk+qm8Z/vQwdOtsS9SGSHNtfoGF7pnm43fxhStIeMP4fXNfxn9xGGVIMeDAr55ivIourz/J261VB2b15v60qA5WR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6754.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xYbGRqN2l0NUpTSERoSXlURDdrVll3RUwxcTlrYUhESWRlY0pPSWVzK3Mx?=
 =?utf-8?B?OUQ3Vkw5cjIrMVVtanhzNGd5WGpVM2dKK05tVU5aUjUrRmd1UWV0K1hkM1pj?=
 =?utf-8?B?d2ZIcGFJRHBZd2NwYlZpRkRsRGxES1cvZ0p6VHo3ZTFVanl2YmhiTVY5QXd3?=
 =?utf-8?B?ME1UZ0tod0REN2Y1eEVEWVp1NlBMT1FjRmJhZzdneFYzOCtERXl5Vk9xN3k3?=
 =?utf-8?B?MmorUytEb3U2OVorZTNJekFXZkRkSlU5UTlIS2ErSTN4Sm01bzlXdFIyZGpo?=
 =?utf-8?B?L1RRd0FVNVR3am9hcUZXdDhSU1FwbjBYdm5jRVdBcjdGQ2RJZlY2RWkrdWpJ?=
 =?utf-8?B?SmpoUGo0N0gyeU85K2VReEVaTDlvb3VEQWlKU05NOE5uY09qbThBUVgyOXNm?=
 =?utf-8?B?bHFYenkvNXZwSmc5TENjNlVvNXl0S21TaG1JVUR4R1c1Y3hIdGhjclcxTXRx?=
 =?utf-8?B?bUs4SFN4QnZ3OXFGVE93SVdWYnJ0MXN6bHdDZTc1S2JablkrNVZ2bDN3VXJq?=
 =?utf-8?B?ZUJmZ2dzQWNTQmkwVjV1T0FpSGZqVTNiZUR2bGp1WFdnWUtWNCtLTi9nVTRJ?=
 =?utf-8?B?SE1pUW9CM3p1QlgrUnpIc0V1VnZuRGNMVjVoNlNjTERTTloxd3ZvaTVHZFpO?=
 =?utf-8?B?SWxBTkVySUUxc2VHQ1NNOUZ3SHhuMS9KZVFKZ1dtQTRzT3owYVJETWVJb0J5?=
 =?utf-8?B?Z25YSTBmbzZQNytWcitCbEhWSDFlajMrYWVDOFFwRFJ3TGJITWZNd20zdEVV?=
 =?utf-8?B?SGdSWWlXVmF5TUJkcDhMdXBTU0VuU01naUhlL0hGeUhhUkM0cmFqUkY4NUNF?=
 =?utf-8?B?cnI0QWZoS0RiVjQ1dTN0ZTE5OWxYUE1KTWR2dmUwK0gvRVRNRVFGL01STnY4?=
 =?utf-8?B?TU9HbVBqZ25GS05DTktFdS85TjFOSExsdXkyN1I0YjFRQm5YYnJHd1hIdTRR?=
 =?utf-8?B?VC83V3F3TTNwNTM3Y3lUQVZKOFEzZEMwSnZqK2FkYWlqZUtHbWx5SVpBUmVh?=
 =?utf-8?B?V1hKREJoS2Y1UFZzTHRFV3pGdVJxRWtUUkdRQjkyZmM3bUF1ZWpGZkRUeVRm?=
 =?utf-8?B?czNPaEFQb0ZudDN5T0JRQnZsa3V5bXJZYncrcnVVVU9ZVXhTdFg1ajFkRENI?=
 =?utf-8?B?SWZJTG5PQnlISlQ5YTI4NkdxRWQwQzNvSkNuYjMrZ25kU2tWWHZhTGV0UFpt?=
 =?utf-8?B?MzNpS1QwRml1Qk5jRlpSUHNDdjdYSCt1SjNUaTg2OWpKY05zNnNuVk8yeEE5?=
 =?utf-8?B?c2QvM2JCNUtaNzBXQkJZR2NqZkJTMzFUanhHSm43dnhmYUtEV0ZBS1NYUExZ?=
 =?utf-8?B?ekpmY2Q5dnpqQU05aFBHQk5RcXpYUDQwT2ZxM2tQU0hCMmRmcVR1Wll1T3FT?=
 =?utf-8?B?cHNiZWRyMkNrQ2VuTDJJTS9lQVpzN1krSFFSMVRNVlVSdlJZRDFKWTJRNkZn?=
 =?utf-8?B?VVAvb1FZNUVGcWlGcFRvMmg3NHV3ZjdCaGhEK0xVaDA3ejVoT245ajFOeUFh?=
 =?utf-8?B?YTNwdlhXTnFZdFJMNjlHSmlrQm1CVGV4NWxZemVUQ2dKeTlWYnRnM0ROR0c2?=
 =?utf-8?B?eHRZWWthMWgvZmVKTkw0VUJ4bzR0WHUxcDZOQ1NBVWEvODBlWGI0V3FkeHRC?=
 =?utf-8?B?MlZJNks4ZG93Vk1ma2k4UWg3Z1gzcThCZWZKV1pNSlJuRk1jdW91NHhGZ2hx?=
 =?utf-8?B?VzdhSjZuTXhUSGw5bWs5SUJwaGxiZGZDNmg1enZVTXJXYmowRUpTT0Yza2Nr?=
 =?utf-8?B?eXBoeFY4akx3YkcxdVNzNnhIM0lhTHN1QjJPU1RuUnZTeHNzdTJCVHpGNXpM?=
 =?utf-8?B?c0pDSkdpb29jZnlPT1Y3VWpRNkRHWmhQVkNXdGxOUTd3c1kyYnhuS0tvT3JC?=
 =?utf-8?B?VkJWVm5HUmgwM2xoVUVHOVE4UnlvMCt0eDhnNnJHVVhtQk5MMW1zL3Nza1hR?=
 =?utf-8?B?czlRRks1VTViN3YxejdDdGdnOTF4aFduREtMSGVMYlNGSjhYSWM1aFVidjFx?=
 =?utf-8?B?TnF2VC92ekhWUlRCVlBWUmYvWUE3S1NrTkVyd2lZUmZUUkppVWY0NEtDZEd3?=
 =?utf-8?B?MEhmQ0JNODl4cDlCUzZhMkZud29VRnRtaDdscGlpajhoS3VtOHhaQUJvTDJ2?=
 =?utf-8?B?aHRIU0JhN0xwblZkakc5TWMrZklUeWs1dm12cGxFeTlydllFWUlHeXlueWVi?=
 =?utf-8?B?eUwvWk1FY0V4S3VNb25XbXI5ZVVySHh1VHQyUjl0TnZlR1RSTThuYzdJQTJS?=
 =?utf-8?B?WlNRUHVOa0hzeUZCaHZZdkZVVDFqb1RTczJxM2hJdERTMHNjS0dUdHJMRkNh?=
 =?utf-8?Q?AkNshGSXgG22YrKSoB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746944df-3993-4a68-e5b9-08dec21cba21
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:36:17.3572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5w8dt4Tn/55A3kTEF3+CiJT1e76RPioXoSat72ndtbR6qyOwm9PAWFXMYTqihrCmp7JNcdT8+GB937MSREe4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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


On 20/05/2026 4:25 PM, Adrian Schollmeyer wrote:
> From: Michael Pfeiffer <m.pfeiffer@syseleven.de>
> 
> For a MODIFY_FIELD action, flow_hw_validate_action_modify_field() is
> invoked and enforces class_id == 0 in the action's source and
> destination, if the modified field is none of
> RTE_FLOW_FIELD_GENEVE_OPT_*, as the value is used solely for GENEVE
> fields.
> 
> However, this check is flawed due to the way rte_flow_field_data is
> initialized. As it consists of unions and anonymous structs as members,
> empty initialization of this struct or initializing just the tag_index
> only guarantees initialization of the first union member, while the
> remaining member's default initialization behavior is unspecified.
> Therefore, depending on the compiler type, version and configuration,
> the remaining members may either be default-initialized as well or
> contain bytes from uninitialized memory. This causes the check to fail
> depending on how the struct is initialized wherever it is used.
> 
> For example, rte_flow_configure() sometimes fails on mlx5 under these
> circumstances with an error "destination class id is not supported"
> during creation of representor tagging rules, as these internally use
> MODIFY_FIELD actions in the following call stack:
> 
>    1. rte_flow_configure
>    2. mlx5_flow_port_configure
>    3. flow_hw_configure
>    4. __flow_hw_configure
>    5. flow_hw_setup_tx_repr_tagging
>    6. flow_hw_create_tx_repr_tag_jump_acts_tmpl
>       --> various rte_flow_action_modify_field are initialized here, but
>           class_id remains uninitialized
>    7. __flow_hw_actions_template_create
>    8. mlx5_flow_hw_actions_validate
>    9. flow_hw_validate_action_modify_field
>       --> invoked with class_id containing uninitialized bytes and
>           non-GENEVE field type
> 
> Remove the two checks for class_id in the non-GENEVE case, as this field
> is unused for these actions and avoids additional implicit dependencies
> on the correct ordering of union members.
> 
> Fixes: 1caa89ec1891 ("net/mlx5: support GENEVE options modification")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Michael Pfeiffer <m.pfeiffer@syseleven.de>
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>

Patch applied to next-net-mlx,

Kindest regards
Raslan Darawsheh

