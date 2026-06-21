Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96DDCD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 04:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42EA94013F;
	Sun, 21 Jun 2026 06:33:38 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013049.outbound.protection.outlook.com
 [40.107.162.49]) by mails.dpdk.org (Postfix) with ESMTP id 94913400D6
 for <dev@dpdk.org>; Sun, 21 Jun 2026 06:33:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFowzh8MO6x5gAqr0pJ4a4+3kGIZuQtPwe2aZP92hw0krjqsHwisI1WAWqFJ1pF6gN9kykHhhDPLlehqZowB8vbJjYNx8DysABheoAvkIpPklf8RjB31E5TxMMCTUR0L8mKOigVE04oqZGB5uccsnTNtYkPvJ6ckkdyPTE50s5L7QZJJq6moiyjyccais0mBDMcIGwkZf51/OlY4tA28xxnPcD53o9GWo91esj32DsZ2kwEWpJzXLTj1bErxETypZAAN62V81MTqEy/NFT4J7iYX1DM5crUV5ur/qCCAt5O7IjHzhOw3kN0iNW0z4EuIZsatJ1m7lnrhhZvmoErgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAt4BMmYC+3FczBXPIhjzO4NixFYw6ROXLIS0bmnOf0=;
 b=Ot0IIu1/Rm0RUu6/j79/J6AOMclyCOASOf8Raln4JQpp0f0fubYtBFPNe6gjgjzkMF01qmU5y8TOkrEArPcOBQhJBkdrimbTHsDh145VM2Z8EmBRCEfeT1ve9fOs7m8EbYXRiVnQOfg6XDInBEnkUGhmMfW3IXmWKNM/fT7j7bNV7sFfoPbqpYu9yDon+YddL9W3aE6btL2XepCBiH3eJlS962uguFntOKXbJoriZ7nyMIfrSOob1V/ZeRlZ86hieDDbIfeT9XP1mDooAAYF3nDqbPXyTdSGr0pOYtoCsx4817Z3O5Wh738tdeehK4sYCkqmKRWX8TBHIU64MpzUHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAt4BMmYC+3FczBXPIhjzO4NixFYw6ROXLIS0bmnOf0=;
 b=RKdgGvBJxSQ5JBi5QC87+l6AZoQLgGAz2x/QpUh2iZQHunlTREKh2zgSTYco9wBeiTdYPyaoUh1sfEyta+HTimtgWqj2xou+oIW/6d4YfKI6sExR73YAxxa7joZahpY5Jz034ohjQRqlG+2Tizro45drQtN45fBi/18K+0QCLDBZPIAmX1AjOKrz2S8BDLAcakLxKaM2peCeYcCH5zy/z7sKwRi9vX9HPGOulALlLUE5ebobT1+9oTUZkr2AoYm2Cs5bjtov1Gfs7j1urjXDLzduTRcIhSQsmBmxlEpVdi7CWRflo62PXYlkeWyN8KasRj+VTwt65I2Sk/te5+kmZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VI0PR04MB10926.eurprd04.prod.outlook.com
 (2603:10a6:800:259::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 04:33:33 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0139.018; Sun, 21 Jun 2026
 04:33:32 +0000
Message-ID: <c1b545ca-6761-412e-b3a6-44389778edc2@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:03:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] net/dpaa2: NAPI-style Rx queue interrupts
To: Maxime Leroy <maxime@leroys.fr>, dev@dpdk.org
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260616102727.708948-1-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260616102727.708948-1-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0220.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::12) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|VI0PR04MB10926:EE_
X-MS-Office365-Filtering-Correlation-Id: c68f369b-5705-414d-681e-08decf4e4010
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|19092799006|366016|1800799024|18002099003|4143699003|11063799006|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: IwPkQTJd1LIGHgPxjpvTHWudzMorUaSf9bsWqz4TgqO+lWUHim3P7cbTT+s5MSd9p31h8NDwNTHlqdwJWDEOUW7yL9HSjCwr7Q1Mt/OQvdrk6Lv0fmwh5a6AC4HtFR8uQeoHF+HqSisYwhlSUJunCjRTxuig8r+DadKwQolmYsbArY79wc7U+DZg6L5al5bGLC1Quo5UlrY6KcwONYcHicMGslkW7uEZRFjUCrtKohShYY8oKsmkACrUivuni0Iu3DNWcQhdhDcZrJBSqqD5nLypMd2YEpvZwxYqzvGCmP69DUYLa3KbiCliWQRhilLPkREEVJPC+IEE1xwOhOK4A3hq10Ryfrou+KdwhPvmYwle84ny8mwE9u86Qe4/Jyxw1TtoRQ1cfrbkQBDJ5kx44uK/jkkKzBBHPp4bRDpPnjCt5vPZTBwCy0x7IFK5tlugqma0XvhLK+FCX+lTbMn2u3TRx0f+JFGawJFpUkG7hQeoBUKLNKzf8tpFbn5uRmR0++uwK/DpzucYOy3rzn8+rjnh2llCoNbkMpy1dVIf6tw8tRV6T488UM47qpV9jGHHBDc358dOGRiBnU5l9t3ivhvdclcIMetjR5VY4WyGr8cgzoPBSCcv6mgN9OY9NvoT6mm0imYYMvEbM0LZ6TwXSBysS1KfXx0vmDhIwfDa90Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0x3d1NyNG94QmFvamVPeVRxY2YrUG1jYi9iOG55Y0JQNUVNM3pVZXRIU21Y?=
 =?utf-8?B?U0F4UnQvRDZKbmpMODMyc1EyTC9Jdk94cVdqSTNoN0plTHUrK05VQ21oLzBO?=
 =?utf-8?B?NTgxZVVaUzRNZ2dkTE9mV2ZhMDZ2YituT01LUCtWaksyaWRTcUFVMEtXYVZ6?=
 =?utf-8?B?TGh4cklLcVdNczdvWEo1aFhyWGxDckNsWHVTaDc3ZUpLcEp4b2dhNzVCMi9i?=
 =?utf-8?B?NkxGT092dUlRZFJRSUJERjBXL05PY1NMVlVvcGJ6QmxvcklQdWxqeUVrM243?=
 =?utf-8?B?ZDFxN2JpbVlzT2pnUE9HZ0tVMDIyRmxCUWdDT0VGWk9sbjA1OGZ1MjlqaW03?=
 =?utf-8?B?L0hodHVIcjhQTEpWY012cUhYZkx5R1NNSGx6SUJMN2s0ZVhmOVZIcEhLZXVq?=
 =?utf-8?B?amNTZnhJZDk2MkE3eEdzcklLUlh6d3VUU0s5OEYvS1VhOWpxVVlFUGFadll1?=
 =?utf-8?B?ZHJHOVFyMjZBQnlKOHZYZlQ1SzA0dVRxS01DcWp1WXRkODVTanUwdXRnM0ow?=
 =?utf-8?B?K25JTUtSTTJ6a0NHVHpRVXMzSnBDTjNTaG1wVjN5K2pQeG5GN3BUcEpnY2d1?=
 =?utf-8?B?Um9xK1NpUUFCc3FzV2VpVHhoV2Q1OWlHazJyT0c2bGNla2hHamd5eGU4akRY?=
 =?utf-8?B?Q1U2bCtCa3J1cjJ5c2ZyY3hpOHhNeHpvbUFEc1lsbldxY2gzK0t4alhZV29V?=
 =?utf-8?B?VUgyRWVpeUxCdnZPR01aUVRkRHM3bWZKV2tlVmh2U2U0TlMrcm85SjVVKzZt?=
 =?utf-8?B?NDBya29xenhmcEIrd2hoMW9lZDhoNStNeldtdnI3empuL29yUW9UQ1BHaTMw?=
 =?utf-8?B?ODNFSGJRbFhjRHdCMGxhOU5XRlJwMm5lS3R4MEthNW9HaG0veFA1R3k3YUdC?=
 =?utf-8?B?R3cxNFRQbGxMaURhNGJGUTBFVjN5V08yQUYxKzNxKytTTkh1S2FSZkp1bDA1?=
 =?utf-8?B?TFAwVG1BUGxXcC95YXFnWlpZRVVtYjJRNUpzZnVlVERaSHRmWlFSaU1uSkNk?=
 =?utf-8?B?ZVVqb2FQU3ZwQnhXdXNyemZ3cnk4djdxbnNFdnBqNnFMNWtRMTJxTkp2eCtD?=
 =?utf-8?B?ZlVxQ3hLRFhxKzJvOXM1Tk5LbGpjVWM5eHN0WkFrRzBuN3NsZEFNWnhSWVN3?=
 =?utf-8?B?UURuamtEazBWd0ZlY1JrWXZhQUdsRDVkUFQrZ2NXekVXY1Q5QUJYQVlHWTZH?=
 =?utf-8?B?czVoU1oxN2xoTWZCVVcwcHRnWXA2NlZZbHNaQTk2UzNsU3lOeDV1dXhXQU1T?=
 =?utf-8?B?VXlxcGJuTUVQbGRnYjdhdzN4YmkyZ3o2NlhnTVRKY3BUd0R3NGxSVm95Qkp0?=
 =?utf-8?B?RElQQVMvTExLcWI5SHVENGUvMEJIaTBscmJLalptRDBhUFFpMkZ6b0ZraVBv?=
 =?utf-8?B?dTByWEkzdGhkSmlmWkpuaGNycVRtQU9KNkU0VmJMM09ZZWUyUk5vc1FqdkhV?=
 =?utf-8?B?R3grOWs1WWpHb2RUem92RkpDQ0xVVTNCcFUxK0tiWEREOVB5OWlwWlc4RXVq?=
 =?utf-8?B?R0hzWHdaaXNkMWpMS3kxV1VscThjWnAydnJKMWZBczFld2ZNUVRCUzRBNEZJ?=
 =?utf-8?B?V20vRnp2L0NDMVh0NGJiY1VTK3ovbjFnTjZ5blZYMCtZQnd5OWxhMTNyM1Rx?=
 =?utf-8?B?YmtETkJ2bWdKdUM2MHpzNXFaaGtqdTdNTE0wUkcxVkJVWDU4M1lWSzBFU3pR?=
 =?utf-8?B?U3AzMHpNK0hCZ2JoSzg0NVU1VUlNZURiaDJ2eEdRc1V2VGdBeUFFeWFvSS9D?=
 =?utf-8?B?T0l4bFExY3hpVXJsWU0vcy9WSzk3aGkyeEhNVE54MG41TmZXWjRzc0k2RjRp?=
 =?utf-8?B?eHA4Y0ZVVmN4WUJwNTRwcU5RSnNiVHRFbkRSMGhNMEhnSzVaQkR2ZnhVODEr?=
 =?utf-8?B?UE1yZTFOS2FSNFVUYjhJb0xEYXhwbllsTFR0THZEaHF2TE1OKzB4S3VseVZV?=
 =?utf-8?B?RmZxbW1FSysvSFZIbEpmZk9qSGgwMjN1RmFTVzRSMEgyTzU4NWt4WHVmVCtF?=
 =?utf-8?B?QXMxYk0wRkxoT0FDS2dwdXJlQXQ5dm5mQ3ZJUEo3MnZhOTUwQWhaSWNPSDAv?=
 =?utf-8?B?Zk9SUmRvTHM1VzNEejZuZjIyVzljODNodzlpM0hHOVJoNy9lenJBNWlUQ1Q3?=
 =?utf-8?B?YmFHb0h6TU5YMUlEZ3lGY0JqZC9iU3RpTXVSUjBYYlQ1V0xQSVA5NFRpTk0r?=
 =?utf-8?B?UDJMaGRpMFFLK1JQNXFITEpveFNpOFlCdzJsQTRpSzY4dk8vTDQzOGI4a2lD?=
 =?utf-8?B?RXFLVXN6dkRqZktZaC9iU2J0eDdaNDYyd2pYOTBNR0JEeE9Fei9QUFJYZzZZ?=
 =?utf-8?B?ZUdDODloOTN5M3UxQ1l3M2p5aU5IY1ZhdGtKY2lJRVVyaktZN2RvNldNWHQz?=
 =?utf-8?Q?QYdxzkgvoyiIHYxY=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68f369b-5705-414d-681e-08decf4e4010
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 04:33:32.5595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZPRGymc+uKdAvtNS5yRW1Myix/Bmu5g9YQ27vRcV+ImOI/6dl4eR29RngFHwO2ySq/FegOefBpIzKuQ5pjmwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10926
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

Hi Maxime,

On 16-06-2026 15:57, Maxime Leroy wrote:
> This series lets a dpaa2 worker sleep on a queue's data-availability
> notification instead of busy-polling, exposed through the generic
> rte_eth_dev_rx_intr_* API (NAPI-style: poll while frames keep coming,
> arm the interrupt and sleep when the queue runs dry).
>
     We need to try out few things on it.  I am afraid that it will take 
some time and our review for this patch will be late.


Regards

Hemant

