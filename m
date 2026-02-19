Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEDBE9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 13:46:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94A2402C6;
	Thu, 19 Feb 2026 14:46:44 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
 by mails.dpdk.org (Postfix) with ESMTP id F102B402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 14:46:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjfiOEuVyYRAe6l9Ut0swBnIxUkd9ropl5eKtiGHeAbKsBjG+oJsl4TQTUGIJWXb8i9vuioKeldmh7JpeT84FEbFpk3aCZN/kApGfQFwkq8Dzc9mexeZm1WBzLhHk1grrNvt5HoQTBFSccr5dk8VRrcLxsMlqzu1LlNNcU1rjXhGYk/+av6nqeTuvdCrS3OStA1LQu7m/pi0e3r1YXEYDrCxHaTtb28tzAN5swNRNXZGZefKaIzJSsCcjyMPJ7NXvhLT+u0lK4ntYE+FPQxTsEgPr3O8zjtlt9mUVYI/+HexodlLcvDlUlzuSxRY4MKSepD09cNbufhRh9s29+K0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=ttW1atyGoQl1ZTorIAPyK2E2h724zUPQLAlG40s9u76mbK+hL4FKFeXVf4wPOaiiWykQlt5Yhdt2nAeBxzzFDnwtFe33mKGkK9R3y+VedYP4h8etyWILF+zWaviNfbq84ZLC1ZsGYCqq/2IRsrfgr1bPyCzSSCFtSnVSM0vdvNlNH03BbF5Ar5F7ycIWQMkS1D7wkvtDwDUFB1WMzlqagyG2MXhHOkjVPhP45P3j4vAAcLwMKCLmnrFK53dRhWpdv2+26mnDajJiZol7motx7rYYIdqJatxu8oY+WuvkzbAgyAg50Ajlo8hPQhLGg6Cb77CQt3LjLoOB9zcub2Ad3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=uPm16wNz2Dx+Ow7ZPWVctKQCoxGzU/RiRTPlBb7kgKhUV9nWYFQFMSH7wNRcLAABusP7tvyl9QuTVsKtlGm6Nfwv7vAYpjjZR8QNcTxn6rZjyd0AAlvl67JKOSdoQrVCxdZVCf7631EvmaReTXWCbe+N4nD2E8z9I+ya9unLHP3ZW+7d1+1D0sqWWhupC0qrLDV+Zb3feszNTEzRyT8WOGUer0sxDfJaO/WpD8RVA8D1aAIjPEqSDIDNQFh4t+Ib0KhU1Nb2VH174tn8TXLQF34xtGzM3+dCjhcn+zYf0Qyp4bJzFruepDyQpadRTCVvXHIcJBrcebf0vLI6nXluzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by PA4PR04MB9295.eurprd04.prod.outlook.com
 (2603:10a6:102:2a6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.9; Thu, 19 Feb
 2026 13:46:40 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 13:46:40 +0000
Message-ID: <26b73999-5548-4ef9-8349-7e474cd09400@oss.nxp.com>
Date: Thu, 19 Feb 2026 19:16:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] net/dpaa2: use CHECK_INTERVAL macro in set_link_down
To: Maxime Leroy <maxime@leroys.fr>, hemant.agrawal@nxp.com
Cc: dev@dpdk.org
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260218160453.142311-10-maxime@leroys.fr>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260218160453.142311-10-maxime@leroys.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB10750:EE_|PA4PR04MB9295:EE_
X-MS-Office365-Filtering-Correlation-Id: 904d60e5-fdeb-43c5-270f-08de6fbd4f08
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|19092799006|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVRwUnBCSjdkWVVobnpFM1FxcW4yRjJKTUZ1Vjg5VkNPUUZJUEFwZ3JuSzBD?=
 =?utf-8?B?S1VtQXlQbTR0RXdjS2c4MDl0VURKcTJka0plamJxTXgrNGwwRWFwS2VneHBZ?=
 =?utf-8?B?ZHA4bytTOGlkK3F1d2p4YzRIMExPYWZhZURpUWhITW9zanp6YTQ0SWZxWDhZ?=
 =?utf-8?B?Zmp0aWZ5ZkVuZzB5VXRYN1JMOFdCRFRkdU5EM1VVRnVwVUQxdnIxaXFGY2pN?=
 =?utf-8?B?ZEl1YlBWU08vZ1pwZjJiTmhBS1lOKzdLMkhCZzM4cFRXM2dwSFBDamNYaFk5?=
 =?utf-8?B?Vk9TY1I4anNzZWVjOHRiRGREVGN2c2ZlZkRxc2JVRzVwbCtBWmw0S2pON1px?=
 =?utf-8?B?TTV4UVJsaStFaDlTSFpiUDhNanhSZzlMdndJT005VExxTUNMbjlWQTJFRDRB?=
 =?utf-8?B?SUFiOU4yTWZKMVdaTHovQ0NzQzJzOVhueDFXaWNzN0JjNVJOWFJRR2dhMFhm?=
 =?utf-8?B?NkkwSndBM2taMndXS1A3RFpCcU1LaVZneGhjem12VDkrUGw2ZytyZWYvTi9Z?=
 =?utf-8?B?eWp2NHNENU12aEw3TkFUeXV6K0hkVzVzc2t5Unl2RjlrYW1oalpWUUdUSUZR?=
 =?utf-8?B?UTFSelZtNU1XalRtMHgxbVluLzZSUXo3OEFQeWNUNXpjcnliNzcyNktiVFVZ?=
 =?utf-8?B?SWl2dVNReHVETTlxNEFMc1hFQ0ZFdzJRTVNXRGR5YmRSbnhIUmVVZXFsRm5u?=
 =?utf-8?B?aWFkeWpjZ0lBNXFtc3dRK25OeVpwczlaZlBSRDhrQjhkSUhrTi9Fb0FSVFlE?=
 =?utf-8?B?MzFyTVJzd3JCUWE0OUkrUjVZNnIvUFRxRHRIVEpDaVl2RldWZVJCREdMaCtm?=
 =?utf-8?B?SGRoSjR5YXByNnlBZkZCdktJQ3ZFaTBRTTAxcjVuTTNKdWJocHV3OE8xRmtC?=
 =?utf-8?B?V3hLN0J6YXJJNFJIOEltQ3dEeDFLd3ZxaXBYenZkN3NkTHh1eDZDbmhKMjlx?=
 =?utf-8?B?MkVJREN0N3NjQVBzZkQ0UHNkNHpsTXdNdUgvRHhVcUtjNklGbzUrWTg0MlRR?=
 =?utf-8?B?SUFiVnh1RmJ1cENnemZVZElWM203YkxVdnpPYVpjakh0Q2dLWERaN2pBZHZX?=
 =?utf-8?B?S2hwRmNVTG1pYnVhOVJGYlptWW0wamxmVEpXQW5ESTQ2VDd1SldpcTIyVTdl?=
 =?utf-8?B?RC96R2F6Y2RsNWo3M3VDUU1wTUs4cXFuVDZ3YmRzdWxLN29tclVMTEdoRStG?=
 =?utf-8?B?cmRXMXFDWVNvcGZnYXpCZlg0RVp0Yzg1TDk0ZWhsaDJLQ3FCYUxIYTBmYzI0?=
 =?utf-8?B?eS9DeTVYUjA5cm5ueHhqSW5iYkpLQm9ORlhTWDlsUFRXdm8ybUcycnBwNkdD?=
 =?utf-8?B?OVF6Z0NJZ3F4amExcnRFdnNnRHFCdUxaMHB1K2pLdVkycFRreTMwMUhiQ0c2?=
 =?utf-8?B?Ri9CamljRkRzK1RYMThHRFlYcjBQNVY1NDVaOE9iL2JyQzdQcStqUDJ3SmM0?=
 =?utf-8?B?NVc2ckc1ekVYNk5xNmJIcTlRRzQ2V0lpU0dEMFpxcS9Gd3Zrbmp6MzVJVy9o?=
 =?utf-8?B?bzIyN2swdFlTSm9aSFpkN2cyenFETFVHSDdmRTI4TnVLekNLb3RvbThTcXFu?=
 =?utf-8?B?TmdBSHZ3V3lRVjh6OE45NWZHU3F3djFqZGhESXVwVncwME93bUc4bWxwMVJR?=
 =?utf-8?B?dCs5ZUo0bG1SOCtJckRaUytFcmFWcGxTYlBKeUp6b1hERytyY0UrZUxUaGxh?=
 =?utf-8?B?azVzelRyZHYrUzExcDdiOU44bzQvQ0pOWXJ5SjNWMy96a2poSWxSYjMyTC80?=
 =?utf-8?B?SXRUL1krcHdtSjdhcE9aMlJ4Q1d0Q3Y3bkFQRkZacGJNc0E1SVNQeWJ1dFhH?=
 =?utf-8?B?Q1ZEaFFWeEsrQWdJNnFweUZXaHIwbnJ4ZytNK0hmbS9mb3VnVFl3NW1kN2pt?=
 =?utf-8?B?ajdFMkJrOUl4SUpBcUtld1BjUEFkTWNzZG9PSVpYM0VXcGlzS1VQa1NhMVRX?=
 =?utf-8?B?dVVOZXozNlVaQ2tVMnRXUkl2UHFNVCt4a3ozV0JTL0oxVW05L3F4Ump6ZHht?=
 =?utf-8?B?bWI1Z0M5aUJGc2IwQXRxaGdacTZGYWZsbUJYbHJJSVA5ck10SXpwZ0tzeFJq?=
 =?utf-8?B?SlFsRTI1MFB0cVFDekVkajRSSjVZZUVJWHUrU0xveC90M0dNSFlicjlBVDYx?=
 =?utf-8?Q?P1rE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHViYVAwZWNPWk5meVgwaHkvMjI3VElKUFRWMFNGRURMWFhhVW5iVEVHbWdn?=
 =?utf-8?B?c3R4TGFjRi9hZVI3Qm9mVjF3cldBeFB1eXlYOWtSam45ZEl3WmxnQVlMV3Mv?=
 =?utf-8?B?d0NOZDNjRXY1TmpDUTM4eUFOVlo2S0JzY1dtTWIzREJMTGUyZ1FQbHdjTVJl?=
 =?utf-8?B?N1dEd3RKcXRVMXdjK3JyMFJBWG1WZiszcTB4aG5wcEMxSTF0SmFYRFNEWmFo?=
 =?utf-8?B?ZWc0cTk5ZDNpdHBjZURuK3hCN2V2aEEvZC9MZzBpWmxMS0V4WHNHbm4zQjRi?=
 =?utf-8?B?dFFwTXNWaWtrQ2xQdlh3WDFJbGZ6YTliMldrSzU1YmZFUjZCQ2gySW44cFFl?=
 =?utf-8?B?Q2VRNE1VNXpIRnpJU0JWUWd0cG03Y0R6cnVSQm9yTU5pK1hKcE05WmpRdUl1?=
 =?utf-8?B?MnhDVjVHTzl3Q2RUYThDbEpLU1JSMEs2T085WHFLY0pFQzAyQm5tTTE2cDdE?=
 =?utf-8?B?STdCaXMzdHVyL2ZnbUtiQmI4bjc1Z0ZUVU5waFUvbTdEWEJqT3REQ1NQMmN4?=
 =?utf-8?B?RE8wRjBQMTlJV0gyM0RvZWFTcWtURlNYMVFYWmRsMzdBQ2tTYkFFL0JSMjJ0?=
 =?utf-8?B?VEIvOXlZaXNpNGpGK1Yrb01xWk4wOVUzb2F0aHcxL3dTV0l1RllWc25acjIy?=
 =?utf-8?B?OFZjbjQwd3o4MGs2UXdRRzFaVURYN2cwRDA4SnIxYXcxM2NuaUJJMkZEQVB5?=
 =?utf-8?B?ZFJqOHdjQ2hTaGovRVlsbWFybndRVXhqajhqZTFqSW5zQkZwVVFLdHl6QVNZ?=
 =?utf-8?B?dklNYUpmOFFhMmFqaUtMY2EzQmhZUzdzRVVUcEloLzNUWnlCTWhYaVE5WUxL?=
 =?utf-8?B?a2VaRHZUbnI4S3dxbjNRNkY5NnRzMXVjdU5xVTdMalpvU05zSjRFUTFMeFVS?=
 =?utf-8?B?WUhDOHh3WmhZUFErd2JBMVB0bDhHRHB0SlNKamtPQ0xqWmFVQk5kbWhQSW1Y?=
 =?utf-8?B?MDdIMkVmb2c0bldPK3ZTc1crUkp6cFVGVXB5Y3dObW14aCtSU2g3Z1hnVGM4?=
 =?utf-8?B?YXE2c0N2WUt3dEIxVFA1TWh4TDU5L3kvVDJOZWEwY2kvRGZBdGxLQVA4TWpW?=
 =?utf-8?B?b21TV2Q5RUFUTU90QTlkblk0c00rOElKVnQ3ZjVqZFUxZ3BzbTQ3UkpqSVNv?=
 =?utf-8?B?S3NWWTB4RWJwcGIzTlNSeHcrWnBjcUNDZG9OMkNLeGplV1UvVkxSQVlJMWlv?=
 =?utf-8?B?SWtoRVFpZDhXOGNXY210TFZZaGZJNEJnUVlZNmcrOW9LanNhV3RKQWgxdjZn?=
 =?utf-8?B?eTdTaUVFQVhsaFNxMEVNU2kvVGpUcTN0NURqMlZLSkNmdlJpZXVDS243ZE1s?=
 =?utf-8?B?OWVBRGdwTWpJd0FiSkYrV1granQ0Z09zaTJPc0hHd1IxSjkzK0E5YXRsTzl5?=
 =?utf-8?B?ZXpiU0FFOHp4SDlvaThsWkJxZDYzcUFGcjJDZWpXTnhDQXFMdDIvMnNVeVht?=
 =?utf-8?B?a3R2d2h5V3lVaW5ja3F1YzFKYk13NXJRYnBMeWwxTDM5bVdJY0ZHSGI3ZFpn?=
 =?utf-8?B?cUpycWFMdDNBZTNmVFFEQkFNS3ROY2dyNXlrS3dsK2ZzUWpDbnFWbEowVUoy?=
 =?utf-8?B?K1NUWWV2N1lpa3F0Q0xUNDZDZ2xIOEtHZ1BxQUUrM2tXWHlZbEFlUzdsQ3RW?=
 =?utf-8?B?RjB1c3RaeW1JMFprR3drWHMrODhlS0tGYmhGNHc0c3dIK2NxTUcyaUdQc0VN?=
 =?utf-8?B?WUdVRWlpallYOWovMmtiQlN5Q3BkM3VWdGdLRGN5b0xLeGJZbHkvd2Z4YjlE?=
 =?utf-8?B?QUowYmVtREgwbzRGZkFDOVVKMXEzNFNna0FGUUZmaXordnpQeTYxZUJqYVo2?=
 =?utf-8?B?b3pybVREcTR4M2xVeFdOaGJ6bVQyU1VIam8zTzl5RVRiV3VvU2Ezb1c1V29l?=
 =?utf-8?B?R3B6dnoySlVRNGlyTGdkQXNTZEpRSUZJOWJvUndCeDRHdGJSaDkwS2U4ZlRl?=
 =?utf-8?B?Nm9za0hoV2swMWFVUEFSYmVGd1Q0aDJaSjRFZXB4SHZGdnVuRkkvdTg4ZWF5?=
 =?utf-8?B?a2U5Y0Z3Rk5QbHFSemM1MStER3ZxL2ZBQ25Sd2F0clM1S0tTZE5vY2RheFNx?=
 =?utf-8?B?RFhNQVYreW8wUkQyMGN2R2RZL0xwVi84Y3NUSFpSYUJsVUkwRk9MTXRBczFi?=
 =?utf-8?B?L0hCRUttalFFZ0lVNGVlZlp2NXlvanprZ1E4d1pFZWFKZDRLNkpHOVZWMEQ4?=
 =?utf-8?B?N2hTRmt4QW12a0pHOFAxekE3Z0NzTkc4SmMyRy9TcXdFOUt2OVFjV0dGRUtU?=
 =?utf-8?B?ejNJa1o4Nm9Eczc3a1JySUV0clpHWSs1NDNGVjhic0x0MGhwTnAwUmpBYlFL?=
 =?utf-8?B?MUNsLytUR1RpZmRGeGxoanE1QUVUU1F1RzdwY1QvcUsweVM1eEV4WWJsSUFU?=
 =?utf-8?Q?T15yOd+MmhO9lkH4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904d60e5-fdeb-43c5-270f-08de6fbd4f08
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:46:40.2778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7hLN8LpI5KUPdiM4MNdQHXs1xj3u4aGj7DjiYW5fQVemxP8vg5yTdC5eosscUSQa7Zo4Sc3vI+8B3noNScDmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9295
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>

