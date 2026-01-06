Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0BCE9D7D
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 16:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F65740B91;
	Tue,  6 Jan 2026 17:52:13 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3]) by mails.dpdk.org (Postfix) with ESMTP id 4C348402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 17:52:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emT1cQRSI9ykbEe+htk/ylAemh/WE8Ql6V1LKDaNZzCTfYOZAvOrgVE+n8UZc1KMSEIC8betMMgPtDESjuGG+D/n+AdYZ6Nenkzw7JzO5HIJEEF2tPMfLkk9zMS2/ad7AXEshf6IRynoQnKWRNrSmfoMdEbR6FNMIdg3gpXulzARpZiBOYON8AdOmz/333Ke9MEx+WhPmSn5wCX4df8+P2Nh3gbnBytR61jx3Kv6oaSp4JwjOCoPtu8DWC3Kh5EuPhOTpulbaVRu4Hne2nVOH9P5cTUJ9aR9eHbcoxeR3k0j6o8gN/tAkiWwnuyH3p7lIs5Ac0fVFBO+Dgu4lYmVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn6i4j+gIMpfUbDl6f3euu6qsrdJT6BAdjSHPLuyQGk=;
 b=zHky/g3E7Bui4YIqk022yBQcvDtqajat/jUdSoGUWfSyJhXIXk8lvPowDIMbDx0E6CZZRz4Oc63GOeNYOVo9IctHcGwQkwlKgv2JMdbXFtlVonTz2YkhwnTfa45e7/kKi6geKWsB++lUzLYi+LIMyQgDVdEKYnDdrJLha5dPYsVBcWEEHXNilHUwamntlX1YdRQlwoHuiH2z6gG31rEElpEBTPjKTgkif1ahmqa8X6zq1r+DGudGU8GdUJjpcgOlhNM5+E2S/lPq2CUw6WEglxUmB8KXd8lEZ4TofXx4FaLkupZe5GonsR+2jvqsZPcHulh0j0vAUh6z89ysVIEiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn6i4j+gIMpfUbDl6f3euu6qsrdJT6BAdjSHPLuyQGk=;
 b=c/rlol081FbFnscFfEWhffN59Kt9eFTn0gJZggqyzQ9EWSrO/7H41lK/NqEjdZwBcUeJYLYQx2Xh832lcnVJImyAwkjICsd9X03JOB55X1ePitpaTH6/LeebJlxNodl9pBTna3GSytr27SEzcnI3JZ2Yi0VwgWWEKmhcmsdY/XocuApzPcslzwtQ8Zr9KC9JUiZOMfj060ThKc4IeAkagp4wmVBQnKN2Pu+DiE4U55GBqI0P0xdGBGICp43v165qQMPevm8XuwSrGHsP+gc9MDC9VuVKzi5fiBxbPPnHVZZP7F3MU0SFghGl5eGcvQumMXc/73fzLqyeM48Tq6PS0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:52:07 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 16:52:07 +0000
Date: Tue, 6 Jan 2026 18:52:02 +0200 (IST)
From: "Etelson, Gregory" <getelson@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
cc: Gregory Etelson <getelson@nvidia.com>, andrew.rybchenko@oktetlabs.ru, 
 dev@dpdk.org, mkashani@nvidia.com, thomas@monjalon.net, 
 viacheslavo@nvidia.com, matan@nvidia.com
Subject: Re: [RFC PATCH v3] ethdev: support selective Rx data
In-Reply-To: <20260106083336.07408e78@phoenix.local>
Message-ID: <7cb28bdc-d6d2-0045-5fe3-a0a8987772c9@nvidia.com>
References: <20260104131301.196350-1-getelson@nvidia.com>
 <20260106154554.40556-1-getelson@nvidia.com>
 <20260106083336.07408e78@phoenix.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcd0347-02c0-49ec-284a-08de4d43ed27
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2af4U+7Oe9k6nKUyN9JwNjdw0Lrgcn3EPnxHOxdNTDnIfFXkdvFASCbw4Ys1?=
 =?us-ascii?Q?udUT7FasbcY6922YKXjkVoB41h8TgnvTmNyAMp6CV9PWnv4MuGoLkPxoJ6xF?=
 =?us-ascii?Q?xpr7uaEyIDLWfKQCxjchD8WD+1eBPoLMMORVaSQWoDRaXXM4AyCLJ/7yLv4F?=
 =?us-ascii?Q?gj2fleAFLCEr8RLTptjoZJgOcWPPaumD3Nz20icYTVI+CoHIHPDpVlWmwsyY?=
 =?us-ascii?Q?nFg0LlFOq1b3OE/XE/FrG8cLot4zKCjxiJEB7ks52ko2Mc/9AZPaF6ifCnuV?=
 =?us-ascii?Q?wIypYoiqIURw1JgGvUD/V2nefqG3ZBFAKQ17yseDkIfZD0tkE8ebGvJ7z8Kb?=
 =?us-ascii?Q?3v7RweU+I9BsWFBckRTNv14IAqEUbDNiuZkM52NEFuggVZWyTDVuVwgfAZJ3?=
 =?us-ascii?Q?waf62uWF5jXyraCKT1u8qTWa/Lb/mQbZ5zIK6dv20B19oNg8f3QruXrKOaiB?=
 =?us-ascii?Q?vBYriniAvXf77oZaRHL8nRdH0auuvMtmBo/IcEXc3yTQZ5rOVLObDNuPLvby?=
 =?us-ascii?Q?McjKPYbwH8wNP8fGl/VfdqOYU3C1NdQsHIOCX3tzEqKpfs1VfXlTf4ncxHG5?=
 =?us-ascii?Q?9Vamu7no102tZnZqXq+4XJ3z1RrTx9bNktT6AXmzfm5eSXfiPfvETsoexHjL?=
 =?us-ascii?Q?j4WZUdw09px5GRAt5Xq0j/9wwEg2KMQEpuTcLuhnwyPBFhOapYc1AcWGL+zu?=
 =?us-ascii?Q?jPMf5/l4C9CYw+w9TnQ3QS+NyhbYv37ZAlqGUEsXG9I7Drl+jVI571tqso4P?=
 =?us-ascii?Q?XDKU6ob2fvx/ZledhUoNW2B1v5ZRazL+H+8cmybnw1tWR/V7r/w617vT2Ou4?=
 =?us-ascii?Q?tue1GmCf3C3AwoVDsspoBuL4XSn+e44XAh12E1JHXJtp5O8qoZr25/tINiHn?=
 =?us-ascii?Q?miYduVTKOYw8DnrF7ffZ0xZMD7/tgX7NMcL3OKTY/JrHpTXRYtPiTDN7HvhI?=
 =?us-ascii?Q?KSZm0dybDtJFcYJzvLFBjEq/ov2PNwN8nhdfWh3wVfUbohAH6YhvJwq4mdtG?=
 =?us-ascii?Q?c2aOlycMU1haqCxcpKt+qIbf1bM1gz3VtetJldLW5PYadqYgnLlgZBzkGMRq?=
 =?us-ascii?Q?0zVTVE2cHo9dIVc+r0WHU4KSTy7MS9KEAI6zXZcMI/PFrXI4sRb0G5hgkARS?=
 =?us-ascii?Q?DZjypfeWYSkvs4EEUcGtFLVluvxhBqC1v2cOMoDqPoXIl1ONoAIYS5pq8Xj0?=
 =?us-ascii?Q?uPRRug31lpBi9J+CEiyM+vPlj1fKqRJgPHm5aHcEjwDrSbpM6pG6WZsM9TBd?=
 =?us-ascii?Q?aG9VCmW/9r8Tu51VYM418UOHZuUJgzRkEUwlRQc3F5m1BC7L0/RgKlFth3F0?=
 =?us-ascii?Q?p9iwZrr+7VQPASqkQfxmRRJoq9tovCOyp9v92MTqVglh9yy9NFEbbmIFIeju?=
 =?us-ascii?Q?ruUSRtYd0O5YvVlfOisledA5DZgtPKQqRR/9hm5li0woEmpIfHKPbNyQCbxu?=
 =?us-ascii?Q?22KxwBjM/7BfatY2u//OZm/mfPbH9HRJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cZftxJuemI+Rb5BmuZap/uVIVSb9xmz431cvdunGFmaUKvHWJcKBAgbsNJGv?=
 =?us-ascii?Q?VgzRiw9XgK87m9Idfg8R8cGroZLtRAdw57o8dF5o+lDVezyAazfbidNp7BZq?=
 =?us-ascii?Q?yt80P8Uh+/rQA4ifv74QcRE1q4BJMSZeTle/oOSrXjt627mV4/gpXbCkdKVI?=
 =?us-ascii?Q?vx3OLDTn0DM00SMKvxxStrqH+ENMZDmkYtsi8sHpgUdLZjFzeuXmdC9V8rQb?=
 =?us-ascii?Q?ikzbf5XCIkCp4/2clPidDGt6dWt2nc2Wky7xGHG4CsbrcLM3UsPYIN2W22nH?=
 =?us-ascii?Q?m/cXNxRNy4VOnPLMJXs3pEbWRhdeJwp9rqwQpMH3ijgoH0+Df6r4oVFo9x4J?=
 =?us-ascii?Q?lITO4Rf9utb91FrKcj4K8w+gr8gyJh2cWFulq9h0sCqn49GlMWyhgcKMscrr?=
 =?us-ascii?Q?RgrN5Q9rwT+ZsyNELU5HKkPQyug2BHzNhSYWpbrt3KkNHWuqkPhXHkRIY8EB?=
 =?us-ascii?Q?ZNmR+NctoQohJIGpJol2eSmHHG5YzV0zZ2KqJBNO/0HspXuXRGBAaUh1Eiy7?=
 =?us-ascii?Q?yiQuU+j+MGlbDs2fVwsPzSVrPKGqKtb+bk7Qqgzu6+oyfOooDUK4PFGLQpgf?=
 =?us-ascii?Q?CdpVxj+FoJ/zwyHbe4l+/pJU1xH1JFS+qpDZU5lvNvloJc3DTiT1ULlW1mRs?=
 =?us-ascii?Q?R4RVFNiHtqUPu1pGs7zq7kQB5+U08pukeD+PCrf2fA0QvrZo9UtRn3mQdPV/?=
 =?us-ascii?Q?W87TRACtcPAi6M5IesFF0+mtkIJOgF2E4F4VMlpyDwHjXtkWXka+YkLrc07X?=
 =?us-ascii?Q?JuV6rK+SYDF0CFuoITw53Ijx29j3hgzezqo7ekwuPirVg3FoV78OR267qzFy?=
 =?us-ascii?Q?t1go+wIHfa48vWBmX+KgvYi2TktHF0nwhw73NWyzLNa7YKucC+3rd5V9bSUQ?=
 =?us-ascii?Q?7a/VBffkgV1CQecIIBsYafQVdMS7ZHnQzRJiueD3l+jkTmQqQvPvevTcje+I?=
 =?us-ascii?Q?9KEQTMoKWw2Vm9o/f8Z5vm5up9B6G6tvqhDRPBBhalmG7X7YlExOCPMP21dl?=
 =?us-ascii?Q?tDMfdpetlF9L27baYgoLpU+g2J8ki85tplE2Ys8OXOM+ZQJ2LOaxI1pSZASt?=
 =?us-ascii?Q?twBbAu4eKOXMlg6fCR7JbLfZgO0swb1AOpeKaTCI6T7sTrdF8a7QY9jPXFXn?=
 =?us-ascii?Q?8w56uf1n4oFawmEu6sLwzayISP521bEHag9Dkhrx7xnrHgCrzG+m+df64aBy?=
 =?us-ascii?Q?xDVdkWaFzZwkmQNRtWKIk/W9lfzDsJFTmuh7qRiKrUm0j6th2k0q/a0R5+9h?=
 =?us-ascii?Q?bTE3518HuB7BBprYtqaMOL+vf9fdIUk4a+8Q9lmcGh2+oHsjH0WOc4NiJ52A?=
 =?us-ascii?Q?7nrTiTwF8PJhhktqQ8hWVabTVKji8su93zpw4ayUf2/mdaPg9rWmQ84aQc1f?=
 =?us-ascii?Q?i4823t66twfomFv//ZY5+T8h79Vt1VFaHArOOLdX7mD4DXQLQdjIuV/z+eOS?=
 =?us-ascii?Q?tdfkZH4UC7qi8Yk2gXpHuoxXU2UaBOSSMsh/3Qsh7/AvCuPZPjuwYkZ5Vn2B?=
 =?us-ascii?Q?vLB62VX4l6ev0WwTWOAPj1oKNmlHEGBzNTq37he1j1yOH/BoRP3Jj+Zjr58t?=
 =?us-ascii?Q?MaprW3ITx5wtL2UnUqFUWeWFBcJhITGPIpzcUdA7tcKUqB+l3GZgFBp+mn9/?=
 =?us-ascii?Q?iiNlk3+8eodf22Z7J6/yw0C6CHllIr1HKZEfa4o6dQTVLT7jA9xpbn2ZvjDv?=
 =?us-ascii?Q?/27MmNPorVW/N2ERTxlaUTb6hW9fvAF8NxfUhhT3LxbTqtYGnKzsvuGBWq5z?=
 =?us-ascii?Q?/yFtdwPN/ZnPt1f9a0t2fxt76BlTGuQ4+/Akg73Nw3tI2GvQ/9CIvVBmwEMz?=
X-MS-Exchange-AntiSpam-MessageData-1: J8PC/FCGSldbVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcd0347-02c0-49ec-284a-08de4d43ed27
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:52:07.2382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldcBwOmV+KmeZ3uRYmC0HqIzIirNTqQUN7F6k4jXnu0aMKOCIX02Ol3W8beikNp+MlyMqh+L4q7NxPYmN/y4CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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

Hello Stephen,

>
>> In some cases application does not need to receive entire packet
>> from port hardware.
>> If application could receive required Rx data only and safely discard
>> the rest of Rx packet data, that could improve port performance by
>> reducing PCI bandwidth and application memory consumption.
>>

[ snip ]

>
> Will need testpmd extension and a driver (ideally multiple) that support it.
>

Ethdev library, MLX5 PMD and testpmd patches with the selective Rx data read 
implemetnation will be proveded after the RFC acceptence.

Additional PMD implementations depend on HW support to safely discard Rx data.

Regards,
Gregory
