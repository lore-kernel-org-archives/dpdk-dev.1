Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1EDCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 14:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF54B4028E;
	Wed, 27 Aug 2025 16:02:57 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by mails.dpdk.org (Postfix) with ESMTP id B02054027D
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:02:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq6YnjKWHg+yU8DChXHjms9BtNa7nwvwZ0crQefjGoqXw1tEmmJTnnz4pE21f0q/ly15iNOpmTnUUNs+NiukHS4RiNqPo4VQgTH8h19BOJqMcFFLFPJK9Oi4NrcFfyw3Gmxb/7yuWLz/E//n/gnCxmkOZ59EBm/NyFclr7pfH0FN9wuIYM926XWhvv6Mwgnn356LTQG/UBZOUh03y0yahDpTo342vJzHV5BfGLJoA3wW3jbCHlFti8io7sGvF7UoffFAlPw2fRM98DN1oHN+/KjOnepwmONfLId5Gb8CnWofjpWeK4IMw34wAipz74+/WB5sMhbNLenyt+2wIA5B/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkfVbluRFztx/ejgQmyQ3F+Y4ELT57Wi1CN4Fa3RAjE=;
 b=LeRwRkxbyuM5/O0JN9/iLhRfJVFB7lKNFOOCYyNNPWB7IC0LlIiHV0qHQV8NxLUa4NmZ1W1tt2wb9jlucdboRSFJK58RbgRpBUOyxWMWPW+NnRjirVShsvHnNa26sK7eDPT8yDVzp1DFUkkQHpIeRbTB9Si5ZqYDRGUIjTcK2/d616Mb76tyk2YqNdz4wsDuhkp0jqaUJblATpHm8w/2ZwDJC7tv8F44wyvTRH3lLGzoWQVUH0B87QafMgDdKwhNo8ZaiH9fzD9HSaSvmWe7PAsV4k0tlJtvi2DF1O+Fpp8OpBlyPJ+qJrswp6ihypC4fR3S7Lbxyum95KGKwKkc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkfVbluRFztx/ejgQmyQ3F+Y4ELT57Wi1CN4Fa3RAjE=;
 b=rXqu4s0wDa9NWT7rqgksGg0160ae5054wES4Zxvpa/iLE0+g04IMXtKFAtkyuzH4dh1rqfqAR6EFJRa+aPkRQ9XwnAUpoJAUh9Ob2fgy7a7RUMrIBxC3WBl2FrmXa4Ms8FzBcW/x3N/6wXGetbuB4ngTsUhRuREkigN/aHN5rhiR9q+1piFF5N1/RkMjg4Hn4d614JbozqKQqqIBXDlUcY0ojGKZ/nDdVhgyFGjprb6CNUNd0aLf9+eXHtYEsSewiaN07lrnxon5OZdL8u+mq+yWdoHPuqw4HRG9KXag3KYoGR1qmZtlIxvEIco/FQIWwww7alP9zpZ/5+VutU0tUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Wed, 27 Aug
 2025 14:02:53 +0000
Received: from IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e]) by IA0PR12MB8376.namprd12.prod.outlook.com
 ([fe80::4c58:7502:cc8d:8c7e%3]) with mapi id 15.20.9073.014; Wed, 27 Aug 2025
 14:02:53 +0000
Content-Type: multipart/alternative;
 boundary="------------8bcPBo2CC9sqjfQHQ8TEw0DD"
Message-ID: <e0283765-2194-4426-a80d-cd827cd10598@nvidia.com>
Date: Wed, 27 Aug 2025 22:02:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] net/mlx5: update how MAC address bit-fields are
 used
To: Thomas Monjalon <thomas@monjalon.net>
Cc: matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, dev@dpdk.org, rasland@nvidia.com
References: <20250825141322.974335-1-gavinl@nvidia.com>
 <20250825141322.974335-2-gavinl@nvidia.com> <2010919.fIoEIV5pvu@thomas>
Content-Language: en-US
From: "Minggang(Gavin) Li" <gavinl@nvidia.com>
In-Reply-To: <2010919.fIoEIV5pvu@thomas>
X-ClientProxiedBy: TPYP295CA0033.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::17) To IA0PR12MB8376.namprd12.prod.outlook.com
 (2603:10b6:208:40b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8376:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 3365a861-bde6-4998-aed4-08dde5726a1e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blRmRkt2eEdUM0YzRXVaOURJUktjMkJaOHBJc1ZGSENZSzZPL0RQMExkdm9r?=
 =?utf-8?B?WXR3VExvTzc0Z0VhMWJqODZmZk9sbGd3anBLeGdVeWZIR3M1ZDFleGJCb3Yx?=
 =?utf-8?B?YmtBOGVrYlBIUkN1UXNVRnp1UGk0MmczODlZVytmUGxNVGNQRVRGQmVOVHpa?=
 =?utf-8?B?dlc0dWRxNlMwUHBlWnlVWjhsU2lYMjdmU3pZV1J4UzZpZFpCOU45RTJxMlZQ?=
 =?utf-8?B?REtrUDc5V3QxaGo2RnZHYVJJaVVDZm43RlA0b0syUHJuRThKZ1ROd1FUTWtL?=
 =?utf-8?B?cVgrM3lqQmlTTTlYQithQ3BtVkZVQndYVjBXQmxIaUpRSDE2MmdTVGo2K2pn?=
 =?utf-8?B?K3RSbWRoUGcyOWpGT2xLa3VYYzk5UEMxdTZ6cWRpcjNGOHd4Z25seFMycjJ4?=
 =?utf-8?B?d29VM1NvTEhSdW4yT2hrR1Z5WVZ4ZmFTMTNiZFhQSnRrNHRtWDlVWXJPdy8z?=
 =?utf-8?B?emlrUEhUTnJxWWY5alNRT1dkK0RlOVdFWUNDSlJWSkEyeUxHaG82a0dRNFdT?=
 =?utf-8?B?ZGs1UWJGUW5PdnlqZFhxVG9wL0xzS1E1RVlDMDVIMDVsUUFhUFcvVFE3c1Rz?=
 =?utf-8?B?MzhaTGlZZWFNcHJUZVBySmgwRkhmNW1iTWt5Szk0SXpsWTFQR1hhajF0ZnBX?=
 =?utf-8?B?NFQ5MDh3YnovbkZsUEhiTlBBcmVHTXpzUGRlYVhDMXZBR04zUjBrY1MwMTFL?=
 =?utf-8?B?NHlPR0JMMjJWRHYzaStscFpzazRNakpZS2FDSXVaZWNpckNmei9uaGxWdVZY?=
 =?utf-8?B?MzMyOXVkZTRyazdpdXkrdm1qeDl1SkRUc2J3Ly9kV2M1ZUM3ZHFlNWRTSEVQ?=
 =?utf-8?B?WG9hN2dnbFR5U3FmZ0pZbGRKM2I0Z2hkT0owZE40MmJFK09zenJYRmJGdDVY?=
 =?utf-8?B?dkdCK3RGSUtOZjkzUG1MWjBOb3ZTbUlMeTFCZXozTTZrMHpidXpKQjd1cWxh?=
 =?utf-8?B?ZXFXL1g4RlRrdzRKL3Z2RnFFbTdldlZxSGRKMVo3TjJ0YXU3eFRWbEQ4bUky?=
 =?utf-8?B?LzFMZ0dBUkRUakVYZGRLWmo0RHJQMmFndG1oS0ZjRWFhYWMxNXpZWFpTOHhH?=
 =?utf-8?B?aG9zRzFEbWd4dXhZbVZiTlp1QzBFdmVHc0JZR25BaUhacXhEL20wd1E4WkR3?=
 =?utf-8?B?N3p4NnhWbjN4N3ByTlgwVS94d0VOeWZ5bWFtazZlbmFLamovWU5oL2IwNW9t?=
 =?utf-8?B?V1V4VXZsM01PZFV1TUdKQlBRRXF2UExEdUcvTnF4R2xQaVg0S09PLzVjM0xm?=
 =?utf-8?B?U3hhU1doSEFUeDF2YjNTaUlnK0tmN09BMzRYVnZCSDkwN2h5TUVNWWhzN1NG?=
 =?utf-8?B?VWZVaHB6eUVLenltaG8rcERuVlZ2alM1ZEY3emxodWM5SXhnRWhkaUd1eVZa?=
 =?utf-8?B?RkNVQTdYQ0V4dHpsSXgvUzYrdFJQNkZJTk1pbXIxdTZFcTI5dTVjU3dXa09l?=
 =?utf-8?B?RlcxOFQ1cDdvNURtSEMwMHpzY3E2cDJ1dVhqdmhqQWFyWm4vSDhKT0VZNUZK?=
 =?utf-8?B?cXBJMU5uT3ludjEvTmNsYzI0VDJDMHJDQ0tPVEZrL0JPa2ZFVjJZa2cyL2Nr?=
 =?utf-8?B?WEFhL0xmQTBoeW1sOTd2aGdHa2dITVNrVmx1M3B0UnQyMmlQbWlub3RyR1Av?=
 =?utf-8?B?Vk0wdFpuVjFKUXpEMHE4VHUrRTdXemw2VmtJaWNMeW1oajA3VTVXWi95dFNx?=
 =?utf-8?B?RFlCaWlKZ1pnYkZUZ1psZ0FBNUlYNlF4MS9vb245aWQwOHB5ck9iTDdOb0di?=
 =?utf-8?B?Z0xobGNVZ0t6OWRoRFVDdjVoT2thYUZvTVg5TDkrd3N6V1M4ek50SW5jRW93?=
 =?utf-8?B?U3UwWkpRVVA4L3ZRNWhYMjQvcUZtVkJ5SWI2enozQjFjUmd2eDNlRktwdVNF?=
 =?utf-8?B?cFpza1VCdVR6T0h4L0xMY3E3dVhNL3dlR1hQeTZRbFhxa2ljSU81U1dvQVYz?=
 =?utf-8?Q?0lKYersPcuE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8376.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZpNGdFSVExbmxmME14WnhsUy9GaGVEYnhSNlZCNmZjTG8xWGNvQVlKZThl?=
 =?utf-8?B?NXFwSkFmT28rYTJZM2g1d3BqT3lVdmZiQjlvWkpQYVFBK1JCR2dpRDhjZHRJ?=
 =?utf-8?B?QzlnWmhSWWZKT0FuTGd0ZkIzUzZNZUc5cFNScHZhRHhqdmZoZ05IZTRQbmJh?=
 =?utf-8?B?dmY3SUVMZ1JkdWQ3QzdNaVZkK0tHMFg2UHBtMFpRd2NYVk43VHNQOWV2Wm5a?=
 =?utf-8?B?Y04vbit4YmJCVDZWWS9PamRiWTRqQzg5S292OWJTallZdURBYTJKeU56MERH?=
 =?utf-8?B?Mm9uSkVTNmFxWmlCWmpNRnc4c3grQkNFcG81R3orbjJyanl4T2h1aXpNSXhU?=
 =?utf-8?B?bnJaS2dnekdZbG5LY1ZZTWIzSHhja29TUXAvRHphdEFNNE1ER1QzaUNldjEv?=
 =?utf-8?B?MDZNL0FjLzByWG9HbjNEZTB3eHE1U2hIUVBBSUNZWkg3OVVvU05ud0JBVWF2?=
 =?utf-8?B?NEJJdzg5YjNzKzY3bW9ZTDM4VmtaRG1zVEhyWmxEdVphUHNlZTJvbDFEOVFQ?=
 =?utf-8?B?bC9wd2RaeGsxeDdBK09TS3dhTktmWUVEbFh3MDNMVFJqM0svMVQvTnlrVVR6?=
 =?utf-8?B?Tmx1RklTalMvNlNsUU5HNWxyd1UxclpVOVlzd0M1QTRLczhQdWJuOWNwN0o2?=
 =?utf-8?B?cmNxV2EvNk90TyszSEFzWnRhMDFpTmhzSnB0dVJhclRoY1BRMi9pZFZ2Rm9I?=
 =?utf-8?B?anRtV2s5UzBDM2o5WGhsdzluVklieFRteVlXZHdiTWlVVnhRa1VnUmFscExt?=
 =?utf-8?B?L3BSa1dhUy9TSFlHbnYrZCt4U3VCZlM2T3dnWFFTMEs3V09FNjJidDgxSEZn?=
 =?utf-8?B?alBlSlp3c2phTCsvZllYait6bS94QStRYmhKcVIvZFJKV3QraG55aHFSR3dG?=
 =?utf-8?B?dVRVRkZUR3RxWTNnVUhSemxKeDFiTWsxREtJYzVJWW9kemZLd0ovdlQwTFBn?=
 =?utf-8?B?azBrWGxOUDc2cGRRcXJSY0Vyb2ExdnlQVW5wVFBzUHNHU1o3VGpnUWw4SkhP?=
 =?utf-8?B?Z05uZ2d1V0ZFVVo2cXNvWVFnZzdLMW4zRDQzc0pOeU5PLzBRbCthSzU2UjBi?=
 =?utf-8?B?WjZWR2l1SGdtSitkYUVlV2lRUGJrYUJaVTRaWmg3L3dBbzRLUXdwbzZkdU5N?=
 =?utf-8?B?WEhVY1JrWU9DUVhrV2RhdG1USm1sQncxYnZlNkp1Z2tqUnR5Mi94RVlESWNu?=
 =?utf-8?B?OUVqclk0K1oxQzlYRkVMY3l6cXhVMFNvcXhuS0RmTTVqZTVtMFpJdTJxVnJO?=
 =?utf-8?B?NXBmazdnZFpDVVdkdURaTmhiVThMbXRnbjJsUzBjM0VxeVllT0dYMXM5YWV0?=
 =?utf-8?B?OHNxa0xNTWVENytlcXg1dVJtYWIwZkFMYUNmNXkyQ2hEb3RoWjgrWWlTSlQ1?=
 =?utf-8?B?dUQ5YnRnMXVMbEtuSU1zTmZoU215T3A5Q0orZXRwRDF1TUJVU2Q2Ni9OUTV3?=
 =?utf-8?B?djY2NmtGT1lFOWxRaTNnVEQ2WDJaZjI4cFc3bW5VTzd5L0xxMEc3SHl2VXd3?=
 =?utf-8?B?YlB1aktVRkdKQURGY0pGTEpOb3podktLM3d6b2g0NEc3cTdiRUEyNFpkeEVq?=
 =?utf-8?B?MHZiWCtwWDZ2OGVZVkxnZlpaeHhvMUVxMGFnOGtLYm1iVkZqbnVYaytiWnVO?=
 =?utf-8?B?cnBRMUs4TDUySEd2NWd6OGFaYUhoTm9INlBRdFlSTFo4OWNzU3VHWHExbmVN?=
 =?utf-8?B?YTBGV1AwbDQweXFySnRNMTkzeVk0alRhVkNHZ01yQVgwN1VOellvNXhPVzNT?=
 =?utf-8?B?TTZwZjBDYVk5NmRLNHJPTnJQTXhTZkg3bmRpNUNMdWgzRkFoTitJSG9UdlpW?=
 =?utf-8?B?QnVVS0FHYm1ycjE3ajFabGM5WHJ5RjVoWDJsQW1KR2s1UmFwZ24xaEhSZWt3?=
 =?utf-8?B?aGpMYlNLUkMzVHBDL2ZKZEp6TWpYaE1IUHBKa1Btd21LMms3NStPWERGbDk3?=
 =?utf-8?B?eDVDVytNelNxb3M0dTl6OUlYZTZGaTV5dm5DTFRWenhSbmVGN2pVbFpSc0FR?=
 =?utf-8?B?SXJCMGMydlRSNGpJL0ZWeWtRVEhBanFhUDNsOFFPN3pXZTlkdExKZStNdWRM?=
 =?utf-8?B?VE8wbVQyZWg2RFZ1TkJXRFFMUlFHTStiZkl2Mmp5OUdIaFowdlBvVUNLbzR5?=
 =?utf-8?Q?RqtZn53Q0R9axUG8It7IepCOQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3365a861-bde6-4998-aed4-08dde5726a1e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8376.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:02:53.1428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NktGkTB5tGrUbkkyg/lZCdhhnZjQFk4JaoZgI1IfFr2ZaasKGYHDaOnLRu5uC355H85k2cw/V+GmXdw4/TEekw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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

--------------8bcPBo2CC9sqjfQHQ8TEw0DD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/2025 10:54 PM, Thomas Monjalon wrote:
> 25/08/2025 16:13, Gavin Li:
>> Previously, mac_own was a bit-field indicating the MAC addresses owned by
>> the PMD, specifically marking those added to VFs by the PMD and allowing
>> them to be flushed during exit.
>>
>> With this commit, the bit-field now applies to all MAC addresses added by
>> the PMD, including those for PF, VF, and SFs. The process for flushing MAC
>> addresses added to VFs by the PMD remains unchanged.
> To be clear, there is no behaviour change in this patch?
Yes. There is no no behaviour change in this patch.
>
> You should mention the goal of this patch (preparation of a fix for multicast).
ACK
>
>
>
--------------8bcPBo2CC9sqjfQHQ8TEw0DD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/25/2025 10:54 PM, Thomas Monjalon
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2010919.fIoEIV5pvu@thomas">
      <pre wrap="" class="moz-quote-pre">25/08/2025 16:13, Gavin Li:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Previously, mac_own was a bit-field indicating the MAC addresses owned by
the PMD, specifically marking those added to VFs by the PMD and allowing
them to be flushed during exit.

With this commit, the bit-field now applies to all MAC addresses added by
the PMD, including those for PF, VF, and SFs. The process for flushing MAC
addresses added to VFs by the PMD remains unchanged.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
To be clear, there is no behaviour change in this patch?</pre>
    </blockquote>
    Yes. There is no&nbsp;<span style="white-space: pre-wrap">no behaviour change in this patch.</span>
    <blockquote type="cite" cite="mid:2010919.fIoEIV5pvu@thomas">
      <pre wrap="" class="moz-quote-pre">

You should mention the goal of this patch (preparation of a fix for multicast).</pre>
    </blockquote>
    ACK
    <blockquote type="cite" cite="mid:2010919.fIoEIV5pvu@thomas">
      <pre wrap="" class="moz-quote-pre">



</pre>
    </blockquote>
  </body>
</html>

--------------8bcPBo2CC9sqjfQHQ8TEw0DD--
