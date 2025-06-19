Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F42C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 13:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E3642E7B;
	Thu, 19 Jun 2025 15:34:30 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by mails.dpdk.org (Postfix) with ESMTP id 6B32D4025E;
 Thu, 19 Jun 2025 15:34:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6nz63SKYuPkSozF9OElbEks/A7cmP56F8bbhxA+HE7UAQM1G4yynlxL+wzBzrPhyBE7n+mDf+YE3sRcJvcx5J7/0ayYNOWOsMNryIJBX8z6/LrwAvXKp/aoa8xdsiokhrAiGh/XB2+r100d/aSsVP1U58I/nxrINQhG4I0p3n/5DHnRokSFGZTczR8frCJhT9ITE7QSmfrt4vnraWXy5iISBLyX7wBtJ5Bw/RL9PSCKG3avlWGUcRf98fDvQbo4YioheGdqcivWI8jpMLwwa/JkuImtjsIsIw8B7zrY+47zEbR7to3CP8j+PywFIl9s0VT+CwkB0F+4YdWsVfAAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bsk/N0vqi0lQlR50k2/SftprASmn764R6aTPI5+0FOg=;
 b=ueDUrE0UhG+f/oJqXGdyXxQIwvRZhrCpjydXEETeEyUs0h09kSjhUrNguSCPxy/0RxYlpaG68NteM99AXQP72Lo0g0sFsT0tkSt+S8pTe4nBrsy7d5pLPqRG3RE20zZrIQiAwTJP91hiH0RhmjZ/XMkcyfwyeEYiQ9ZU2ilysurIvhyu+o3pFYJqGpOzyujtN1G2pZxOrykHXvDCVDWwCMLRszDk1Odr8thcFsOmqhGVpJfbFNajuLO1X7pgq2MqXv5WT1vrKkt+c+8m7BCZKRW/goJU9T9TMVD5IOmNTuD4OvFAlEy6VduhS4Oeacz7A2ZEYXV+I0GZvNk2Z3Qncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bsk/N0vqi0lQlR50k2/SftprASmn764R6aTPI5+0FOg=;
 b=PIx8gSYcfYGCVUExG/gAzEWobjz9+D8o8cOL8qs7EAey2V39iaxlZogvbdXTMUPJ+PerQKqcIQLWJvS5ZJgEt9b6eog/W2bghnY/75bhwKLzEDNXFlzB5ezD/b8egZmMFsvcg5ldrDsVnSMIjpyAKpQlboa7N5JixtzrQxuAiJsdRskpWFU0tx4PZA/PyEJGdXrNTa/RBWc4PdK8taWmQWgFLqtM1mjBN0Y2yeC+/amPgNijH+/d80gGVwLv2W1NlMemZhV+PY99cCk8mGd4xQJ3t8ZeJrFPGFP6z4iZ7FJx0jMegxIIx6S8v2WCQXhbUxTxV4VCvfgaWw49x7bEmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 19 Jun
 2025 13:34:24 +0000
Received: from PH0PR12MB5679.namprd12.prod.outlook.com
 ([fe80::53fa:ce15:8a0b:f0e6]) by PH0PR12MB5679.namprd12.prod.outlook.com
 ([fe80::53fa:ce15:8a0b:f0e6%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 13:34:24 +0000
Message-ID: <ccab20d4-8620-407c-b7a9-de5b81c4d6e8@nvidia.com>
Date: Thu, 19 Jun 2025 16:34:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal: AI-Based Code Review for DPDK
To: Jerin Jacob <jerinj@marvell.com>, dev <dev@dpdk.org>,
 "techboard@dpdk.org" <techboard@dpdk.org>
References: <BY3PR18MB478574FF76D2777FFACB1B00C877A@BY3PR18MB4785.namprd18.prod.outlook.com>
Content-Language: en-US
From: Ori Kam <orika@nvidia.com>
In-Reply-To: <BY3PR18MB478574FF76D2777FFACB1B00C877A@BY3PR18MB4785.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR12MB5679.namprd12.prod.outlook.com
 (2603:10b6:510:14f::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5679:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: d5de1615-311b-46ed-3da6-08ddaf3600fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|3613699012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE05UW1rc2xNTEZxdWtkNm4ySEFDK1VQUnQrSDR6bCtWbmlkSzIxdUZhS2k5?=
 =?utf-8?B?YS8xdXdURUwxTUhGczdJYjBUTFkwYno3VWZoZlN1TjN6TS8yTVNMeFM2SkJr?=
 =?utf-8?B?MU4rTUYzdW02VWwzd2J2M3dpeExEblo3aTZSRHVjUDFBQm9DRXZlWDZHYzM1?=
 =?utf-8?B?WGJtOUhKMFFweEdSV0YzUkx2dyt5S2tqV2VDVXJYOWRnV3FEcGlncW1tMEtp?=
 =?utf-8?B?blF3czREUlhpK2hva2dnV1BjNnR1SkcrK0xlMTJKV01wUUFydjZ1WThtMkpK?=
 =?utf-8?B?MVhSLzhXalNLd0lOK01Ccm5VNzFOY0dYTG1tdVgwVmRUYkkxOTY2RE5QUzU2?=
 =?utf-8?B?YzE1Z3VQMmRNYThQNlFNVEl5cHpiVTE2ZFF4YlFDQlBGYTg2UDdZYmpHYjFo?=
 =?utf-8?B?dCsrMnhoYUJaU2trdnk3UVpYSkovY2M5MW4wQ0xMS2RhMjZERlJhS0I4ZkVF?=
 =?utf-8?B?YUU2VWl2MDhsaXdVOWNEMHBjOWRsMnhhcVgvd3RpdThYU3RraG1IM2FVRDdk?=
 =?utf-8?B?QXcwa0ZjZThQYlYwbDZtaW1JZi9Mbi9pZ2Z0TTlhYkpvVkJaVUJmaWE5bzVl?=
 =?utf-8?B?ekFpeTUrV2tCdEtjakRaWEMwMzB1d2k0Lzg2NTNpNUU2MWNWeW0yZ0NRc2Rt?=
 =?utf-8?B?eWpEU1d4ZWRnSWN6c21CYkdMOS9QTEtjYmpRUEFUNWxBdlpmVnVvRFVtUXhm?=
 =?utf-8?B?Q0QrNng3MlZ4eW1kYmQxdUJRRFRtTFFtVHVFTklseGF2cUFxeHg4ekZYL3Yv?=
 =?utf-8?B?L05qQnFUS2U3TmROZEk0enlra1BzTDJ4MVMveWwrVGpVM3kxRlorTG9lTjZm?=
 =?utf-8?B?cXhoVWpzSysvdk5UdVZrWjRwUklsN2xESXdCV2d3c201ZlM1UmEwZlVVNVFW?=
 =?utf-8?B?K000dnYvKzVZdkRIVWI3VUFhd0tMNGFYWDloVGwybU5PZkZUMmRYYUphSWR2?=
 =?utf-8?B?M2tWQXd1ejV0ZkI0OEVGWUV5N2FrVlpuL0Z4dTA4dTJzalFJUVJPczNuRlhJ?=
 =?utf-8?B?ZVQ2dHZPcUFMenJPMlhlWEJ6TzIxM0E2RzZFQm5DK1d0TEF2SC8ySlh0c1pm?=
 =?utf-8?B?Zlp2OFBNTW01SWdwcEZYUmk4UC9UaTJoWElJd3kxbmFodi9JRTVrSEVWUG5Y?=
 =?utf-8?B?ektDZWg3QnRNL0IzcU1vYjJRSmJqQ3FaVm5PZUxLWWJwYzFZVmo0L0xNckdh?=
 =?utf-8?B?NTlkYUxKMFdlK01USkFVbWJFbG1STkpHZE00NkRncEd5Yyt6elBQQXBYbFR1?=
 =?utf-8?B?VkhRRUlUWWplMkhLNklKVFdwWEFnaHh5TldBV1EybVFOOEJ4NWxKYkI3QmF6?=
 =?utf-8?B?Q3dJemhPeTQwMXdSVmhPbXVQaHlTbGpEaVBvUFk5OVJ0Q0F4Q3hXNjdVd0xM?=
 =?utf-8?B?V2R5RXRTelNPTENOTkNoUzNCVUVGd056V1dnTEEzU1dJL09ZM3FjTkVXUEFV?=
 =?utf-8?B?RHk4YkVBM0Z3VVFNOHJ6ZWRYb2ZPTUlUbmZVQTZIcFN1RzFpYXYwRlVFV0Zo?=
 =?utf-8?B?OTI4UUxqd2I1TUtyZDlRM1h4V05sNUFZcC9GN0IwaWVBTElIaG13YnNWM053?=
 =?utf-8?B?T3dZclM5S0JTWHplbkxiVW9XQ2xOV2xoTnFac284bVlBd2t3bFF6bVNrMTBr?=
 =?utf-8?B?UTZEUi9vWGVGQ3gyVWpWaFdrY3dNbU9tQzRzUXE2SSsydUc4YlpkT29DS2Va?=
 =?utf-8?B?RDh0eFlJUkxLQWlHV2s3aG9yRjdHeGpQQlBzV2FMalg1VWNHV0pINWFWQTdY?=
 =?utf-8?B?SUxvTTVEcld5RmwvK095OUNxWlhSRm5TMTJnUzJFK0htc3NpSmhXT0RyWFNv?=
 =?utf-8?B?YUUwRnhHbWRVamY0ODY3SW5aaThWTk43L01tL2JDTDdPT1gzN0hVUkJ2cE0v?=
 =?utf-8?B?U1RRQnNhaXArTWpqbjJvRy9BOHNHck14Mk9hRXJDaXltRVlvdElNcXlQWHh1?=
 =?utf-8?B?MjNxdG1qTlVKR2dNRVJ5Z0d3Y1hwZWRwQW1YNG1HdHFZV1g4cXhRMmxJUkZ5?=
 =?utf-8?Q?cIRKrP8H2/4MioFkQF82ZKf4dQWDXg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(3613699012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lrekJPc3JzUFNEVmg1VDljeHNJVWdpMlZFL1lwckMydThVN2Q3ODRCekVE?=
 =?utf-8?B?cHFmdlBoV3VSK3dnUm9DVUgrYWZJY0hrNk51eUV0UHpLQUcyTE9tV3FBL3cw?=
 =?utf-8?B?MXFtWUF0cWRhSGhsRVlEcmltWmt4d1l3VUVvaWhXK3R2OHZtWE42ZUFoV0pE?=
 =?utf-8?B?dmFuU1E5ZmRVR3RCUGVwYjlOUitZUzBGVEV5V0p3SmFFd2dLQXF3eG9TaWF0?=
 =?utf-8?B?NTZoRW0rN0pObzd4czRwb1lZU3JRdFpHcW8rcEZFUzFQZHZsQjdTTzI1ZjhC?=
 =?utf-8?B?RmF5b3cveFVSZTdTQy8xdlI2dE0vS01UOXAzZ3lMY2xXSEpBa3I5ZlM2Q1pL?=
 =?utf-8?B?OGVjQ1lKSGlqWWgyS0k1Q2ZIbmFhZGd1bm1TMFIyZ1ErL0pCNUFQaUNGMXNp?=
 =?utf-8?B?aEd2RkE1YVZYdGY5U1AwY0pRWWEzTlhENUMrMXdIcnlxT3Njcm9mR2kxWTN1?=
 =?utf-8?B?aEJLc3N5czhyLzlEcTdVNExzRFdTOXBKUG0raGpyWGlwc3J2cGVnQTI1MzNs?=
 =?utf-8?B?Vnl6ZFI3SjF3b0VLZW5VVXdpd0V0cll0VngyNG0zNDQvLzVFUDBMM2FTRVhO?=
 =?utf-8?B?WXk2MkdQMmV5R0N3Ny9ZRDZhMG5JQ003Tmp2UUZkSS8zUTE5KzZZUmpJT3pw?=
 =?utf-8?B?MUNSTWM4NmNNaVBmSzlXYXVROVJtUHNCWEZTbmk2UDA0MzB3a20rdGc3RGpW?=
 =?utf-8?B?dXNnbDFvclIxV3k5SkE4MmlaNURleVhRcGZYeUZ3a0dwRHVVMGRmQm9Uem9K?=
 =?utf-8?B?cFNZMFVOdzBjOWkwekxGcU0wUFVxcFJ0RVRadzIyQWZlUmpXSDBpaE1hVnhN?=
 =?utf-8?B?K0llRXVlR3lNbnFuZ3RaeW01WUVvSitqSzhhemo3dEoraWYxWHhBc29GNGlO?=
 =?utf-8?B?T3c4Ym5DMi9hNkJmM2JqclF3akd0d3BhWVVVM3VqZlhIZ1d1cHByK3ozTnJh?=
 =?utf-8?B?Ym84MGhBV3NPSy9JVXMzbWppb3pLTmNXS1VCRXptRUtsWG0vOGlwQUdUYW1U?=
 =?utf-8?B?bU8xWTlJZ0QyOXg4dVQ0dWZnditBUTQ0S3hHS0k5OHJiQStUQjk2bWtZY0Nl?=
 =?utf-8?B?Q3dWQWlTME1TejIxUDNYVzdwMjlFSzU0dVllUFIzaUlpMjI4ZUQ3VDkyK2wr?=
 =?utf-8?B?WXlKRHY1U1ZNSnZhaXJoVWF3c2FBRU00SXlYaE1iNEJYTXh1ZXQrYTVvREtq?=
 =?utf-8?B?UG9NK1RKUG9pd3BtdnNaeG9YdUc5OHBOY3BHUWdmbHVuWjRRNnZldlJEMHVw?=
 =?utf-8?B?NFdDV3NndFFGL2xvNm9qSDNqY21WNW1LaDlpbDBKd0Erd0k3ZkVnL05RNU01?=
 =?utf-8?B?OUlGYzZsN2g1T1Eyc3l6a0h3YUZQV1Q2Q2gyRmIwUU1xazFrNkh5Vjl1eEF1?=
 =?utf-8?B?djVmU1k5dHhqTFkyZEJHZmFSVVVMdkJ6WWZ3U1VOVm1BUGV1TWd5dEtUY0JB?=
 =?utf-8?B?VHFIM2doWTJpWVcySUYvZ3d4akl6YU80REd6Q2ZHdlNER1VDbElrWDZvYlR5?=
 =?utf-8?B?NEtMN05IdGRvRXN3S29VYlpWMjJ0STh3RnBCZHNad3ByaTlFUlI1OGlvenVP?=
 =?utf-8?B?RUgzMWhOV3doMUI3UjcwOEhJdExuVisrVnJUVDgwQW5lL0JmYVBlbHhQdzQw?=
 =?utf-8?B?Mncyd2dnWFIwSW9YL2JlczYzVGxPNlA5Q0VTc3JwZ09KMkIwWTJGTmlmcGI5?=
 =?utf-8?B?WW8rWEdXcTMvZVRFME1JcE9XZ25VeU5oUm5weG9ZWmRtaWlscTRxOVJvY2dR?=
 =?utf-8?B?VmFvQnhmWkFZanAwNmdLNWFpR0g5eEo5WTIvNVE2N0p4M0ZuVjdZYnFjeVQw?=
 =?utf-8?B?OUN0MDF4Y2xSMW5xVHcyckl3RDlzOVpiRjQ2Skk1MklqMWpacTlwdXVnUWVT?=
 =?utf-8?B?dC81RjQ3L1I4dlNQL24rcE4vT3ZUSy9PMllyQWNrN1NwMTJ2LzhHL2hldWNq?=
 =?utf-8?B?YVNDc1A1bVVNMHJ6bkVWdnE0S3NrZXUzNjRJK3F6YlpkTTF5RkMrYi8vTHNI?=
 =?utf-8?B?NzVqZ1V4Unp0Q2lNQkdML2M0ZGR2TlMzVUQrdjJ1bWpxUzd4SXRleUkrZElq?=
 =?utf-8?B?YnQ5aDV1UmFzWEJMVDYyS0R6dTNUR284aEk2b1A4eFZwNzVzNHQvRFJCZStm?=
 =?utf-8?Q?T5c15eFQd6UCVMSBpxS29pKXZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5de1615-311b-46ed-3da6-08ddaf3600fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:34:23.9482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPW1nducUrLOXR2oTD9lGUtVGak8QGMeX0+W3YLDLxbW+QLx2rz7J5vbpB7i36dGyLcLnioVPfA9W6e7aSQN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
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


Nice idea,
Some comments:


1. The first link is broken for me.

2. I like the idea that there is a separate GitHub repository. If I
    understand correctly the new repository is a clone of the main one,
    and only used by the bot is that correct?

3. I think main usage is also for the reviewer, just like in your example.

4. The only thing I’m missing is that there is no “personal touch”
    meaning that each reviewer puts emphasis on different things. It will
    be great if the AI can learn from previous reviews of the reviewer
    and add review accordingly.

5. It will also be great if the AI could target people who may be
    interested in this patch.  And send them some notification or tell
    the developer to add them in the to

Best,
Ori

On 13/06/2025 13:03, Jerin Jacob wrote:
> 
> Goals
> -------
> 
> # Leverage modern AI-powered code review tools to accelerate and supplement human review efforts.
> # Prevent AI-generated comments from cluttering the mailing list or polluting the main DPDK GitHub repository.
> 
> Setup
> -------
> 
> # Create a dedicated repository:
> Set up a new repository, for example: https://github.com/DPDK/dpdk-ai-code-review, under the official DPDK GitHub organization.
> This ensures that AI-generated pull requests do not interfere with the main repository (https://github.com/DPDK/dpdk).
> 
> # Select an AI review tool:
> Use a free, open-source-friendly AI code review service.
> One potential candidate is Sourcery: https://sourcery.ai/pricing
> 
> # Connect the tool:
> Integrate Sourcery with the new repository via: https://app.sourcery.ai/?product=prod_opensource
> 
> # Trigger AI reviews:
> Once integrated, any pull request to this repository will automatically trigger a code review by the AI tool.
> Example of a test PR reviewed by the AI bot:
> https://github.com/MarvellEmbeddedProcessors/dao/pull/2
> 
> Workflow
> -------------
> 
> # When a patch is sent to the DPDK mailing list, a bot will convert it into a GitHub pull request on the dpdk-ai-code-review repository.
> # The AI tool will review the pull request and leave comments directly on the PR.
> # Once the AI review is complete, the bot will close the PR and share the PR URL:
> - As a comment in Patchwork URL for the given patch
> - With the patch author directly.
> # The author can review the AI-generated comments by visiting the PR URL, if they choose to do so.
> 
> 

