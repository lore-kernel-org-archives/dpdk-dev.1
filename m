Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34401CA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 08:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09D154027B;
	Thu,  8 Oct 2026 10:01:55 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
 by mails.dpdk.org (Postfix) with ESMTP id E861440274
 for <dev@dpdk.org>; Thu,  8 Oct 2026 10:01:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1lSzjm0UwDEptQgCRGqCR5RY9/9c+MW0+vIaVfnlQSVR30LEZg1Ii36g2kmfCFTV1ejwPpHHhj21y/BWx6y5BZhvlRhq1BtLoQy71T1+Sxyf06GLP8CwIKvTtwRP6UMhAOJ/wnIEbjqQ2c5Sul0MzQSMTwbwfnzf75snpus3Ozf2Ah2u868LYJ+LghOVwJ6eMY5e/aIk+mifImUtcLTdUalX4MfqC2l2/dLlkv2O2kf1HJcfPWVdHovxJtJ0V++g3cMj0+NI0vcbCU1EZdlacG/hjv/NQf9i9nrHsm3TtbcQX8wtmpF73fiUROJRM8Fnb5B5liYVHP7jEjmSOEIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU8GcnhUGABLA9LZVyiaL8ah15xvGWFddo0xQG4kvVs=;
 b=ZFxAgpxC2WJP6mUX0YKRBi8ErqygiNq+Hfv5NSrImFp1Y7H58wq/F4m+S/qu+ugCCUyo/rc5+XGgwYdByGwDgKcw7nqdbY5HhaPQFNEm77aXPRIpjkbR8mhlMc6sTJ8a046GUIDzZnE3CUBNt4qZiYHZ9RJFTzLuS0kzRaxMPP3ruLrWfhYs/8xXjGkdPQ6u/lGZoBKrLzBinXD3AkEWzoT4Kr3skShveZF+9tl0gONUQnnnE0qqBrap2+JtsqQJd6wsJWyMX+vn+pu4D2xdz+pcqNVBG4M0hAKkDP4XANIP4NBUAjSfYiZmiyK3MUUKCbZX4g1aA/rvAOlsw32dAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU8GcnhUGABLA9LZVyiaL8ah15xvGWFddo0xQG4kvVs=;
 b=Oc1uJZ1uz+0DUHAZiq9BKhmi/u+DptwOlib64lt9r5E1BuEAdOHw5fRsmhxdUdHKqYP+L/mvVuWIvEu1Cv3v2lTVCdYVjql6/e3mwm8Q2cutEx+lJHopnK29i+US2TuAJjIUrzv2m0aevOD2iLmxB+2o2cHIrc6NCui4KQjBddaxw4VP5RGsZn0T25oLGsQXDevvR+q/1VVycxMsJSfqCFCj4nncgjlZihB6E+K/CxZkhTmkq26RtSIoFSgHGEn5Za3A+SAK1/ET0iKrqhNt4Z2Cp/FMi13y5Pc2LyHQKbfwgTyf5VM9mUQLfWiVzEjdu6xdy0DcjwapuyKfltWuVw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by PAXPR04MB8911.eurprd04.prod.outlook.com
 (2603:10a6:102:20e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 08:01:52 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 08:01:52 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Thread-Topic: [PATCH v21 00/27] NXP DPAA driver enhancements and fixes
Thread-Index: AQHdVXTh7ITYopKKI0+Aj4AC2jVX0rbwnEuAgAEP0I+AAIl9AIAAEWH/gAASJACAAPJLaQ==
Date: Thu, 8 Oct 2026 08:01:52 +0000
Message-ID: <GV1PR04MB107504086F8EE61E5D3B87BCC89932@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20261005085337.1069213-1-hemant.agrawal@nxp.com>
 <20261006092703.2138929-1-hemant.agrawal@nxp.com>
 <20261006080145.33d89b9b@phoenix.local>
 <GV1PR04MB10750BE973E9EC07CE3A70D5B89942@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <20261007082642.24b92b4d@phoenix.local>
 <PA1PR04MB10770B9B7A3839B5F6EC7BA0F89942@PA1PR04MB10770.eurprd04.prod.outlook.com>
 <20261007103350.3be6cd09@phoenix.local>
In-Reply-To: <20261007103350.3be6cd09@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-08T08:01:52.082Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=1;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|PAXPR04MB8911:EE_
x-ms-office365-filtering-correlation-id: ed005fca-2992-44ef-407a-08df25126994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: 7YBFYXJASh5hus7zhkvwsrl75u4M3udkPIiSDwmYMupz/mm0TE62PVhMRIehuG9xYG5VnV+x1yfZufO7mwvY4vIfQLYQSM7zYAnTTnjpAQWHLhcdz1t1fpTBT8nMVhpJKbCVfqFQUHu7l/zViRiDD2LOXHtGcnlEf7xHqJrcjAwBOUnEQkVZkGUl5CCHc7qOds3su3kODeAmkbXdvQ0Se377gNhm5ep2Z18RU5x4EOTgYeE9OeZvSSONQiJuIJIOGnK/ygjvQXYk2PBlpfgmDuGOWV9dR6O6eaAZ0BENSTqa24/2Pup5dBieRGisQPR5/1STM3gb91vcr4w/eSf8dYyecFZBtdyoVHHnAhg8f7cV7Y87IFyISc38Z6EMUhj+jWsnDyzC8gC65k55ISBv2Q+8fUbK5Oj8hNQpsAU24DQtQsmqRYZ5mhDTe0Fcg6dW07Db2zujmeXd618Eq3d8cSM5rRNCyYdRLECbYWKH76du/lJbmgUjL8VEz6TQmVCBERSBeOkyao5EhWYOxFKUvqOcUD485JlC/fMFVuFaGXPa4CvOQK4fhOlEv/gLqBmFgk8qj0li+14cFUMqKDIjLSMRu4rxHNRCaSMW9zzs7i254lVa3fx9h8ylJd/H61iAMMN3NGv/0k1jBEgHL8GAq+o9p8NBBxu+C+Rm2VoIicGI6vSuwfy1j+yR2/u0Y7IqTYwVLUE4HkQ/CcdJo0FzTOdP74eTnsnVFG8zammCOwM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?dl1kBZmPlpVPJZLv8q4VSUIlcocKOIK2eDOZjHMav15EHAaKEgBMgwoV?=
 =?Windows-1252?Q?18bpv7UFb5luh5xbhXYJYzykTD7M2uYi4MurN8Y3tQKxQfMPThrKkOEK?=
 =?Windows-1252?Q?e5Nb08n8J2TqBOCB31Jw66XtDqprPfV+t1WMKM6prUsU+BW3Cqfneu6G?=
 =?Windows-1252?Q?0c7vGjSr9VZvuavw5YAe9BQk+i9nAbbqr6L0kcf6YhGs2ODJURS5fryG?=
 =?Windows-1252?Q?8KH3c5EEkXm6VdgwexIr33c67dT95O+tgRN1euz5LCxQPbDQjvECrKAg?=
 =?Windows-1252?Q?JiUXRqr3xxCWwo0m0IOQ2aOOAELCDlj53BIytEF2mbhIiFMy2q9TGuiP?=
 =?Windows-1252?Q?W32uhGNKRgpIgTMAQZenbd7MWi8lrdnlvGKsVjkFcvm3caFG1HH6ZmE3?=
 =?Windows-1252?Q?PCLdxYdo+T+ru2ASEhx2C3CIfyaMdz8F1CeAk0mjhBfC81JNXscP9qwH?=
 =?Windows-1252?Q?+A4ng580OmmvpSm0I8UzhArl27jBzW7TRiQaAjhxff1jXWIzdZ6Jaf8j?=
 =?Windows-1252?Q?nNVxCRZ2etKY2dVYAhU7M08UwjneOZBXxJ7cqNA1ZZZukspUAhxyiOfn?=
 =?Windows-1252?Q?1z1241FgRUlIyQQ9eCt4zBOTJB1hUeRS/vZEel9Up5Fb56l23m5eoQt0?=
 =?Windows-1252?Q?wM8VFNhFU2P8Lt+uuP9PG1Jnlp7UdPAk3NR4WXHmWnSp9cnsRJPA3qni?=
 =?Windows-1252?Q?/DJbFg0D1p47G5Y/KnHW41VsJ2w8XdC5sasNtQGlMoykOJwA/RKP+b+E?=
 =?Windows-1252?Q?HGd8XJN+CJUGA1bjkXh5nsmbhdUWSpy/tB3n1/DceVQW8zINHPJqT2OC?=
 =?Windows-1252?Q?zy84nExZQFAm92xG+rfjX06BJS/YBgohgDwMih1cgEzSUQ5D7lysaNoA?=
 =?Windows-1252?Q?ltqdw6DQ8misQVHIvubgwTfEI3oDOe8lLbB+vVNW1sBr2x+7TaaehKpI?=
 =?Windows-1252?Q?9Ai0zrkGCq8jSPqysvPLKXImLVLvNVM77y4vrJB8JG5YIdv6ZmKYxk5J?=
 =?Windows-1252?Q?dp8lDYnGwmbODkjavxnd3CjzcApI/1MpHdQw7rfBbnrOF2oUKkCNLXn1?=
 =?Windows-1252?Q?IQwumjtIeoK/LD92WXISCW0nJH7+eMbamw7SOSehpWNBvC1OCkRWD+PZ?=
 =?Windows-1252?Q?2yxKB+YP5l03A4ISxTzuEEtFYMz5YxRrTNY0IpzAvP5l76OL0fBNbH/A?=
 =?Windows-1252?Q?gFlFa5TUULSm4oMqbXNokBGGgmkLDQa54j4DxVhWSNKeQ0sEFmG2ea2a?=
 =?Windows-1252?Q?n2caq+0qfFwgbtYOvja5dY3BI3KeI4whZDOFOdX81h09I5IRLt+kvPAJ?=
 =?Windows-1252?Q?gyDwFSbGiGLQcviKvOWnaEN1QnTOM14v4qGNU7EcIvj5xk1mAcivuGiC?=
 =?Windows-1252?Q?5+AMSS5ewo8IAPtFMtVnd86myWy3Kbsx1vDFKDtuUTtVfVf0dLHh1q1p?=
 =?Windows-1252?Q?2So7Roriok84yR5YpOgE+G8Wb+ZNxdeKJji8hKOHyFQ34GXc8c8Wz/S7?=
 =?Windows-1252?Q?OZqQFCsHsoAls82l66nod7pbgdXQCQTRrTGhDVeYQxSAFg1Ni7XP3oTu?=
 =?Windows-1252?Q?2wm0Z2MpjMfElqf/7o6kcs/Cs1j6rOkdJW+L7edZwSpx37eHdvc6C9PJ?=
 =?Windows-1252?Q?Fww/PILoAeR0lXFnfOq01PzDIcBkz4aCW8CJYt+VMi0Yy57TZsHfEjLD?=
 =?Windows-1252?Q?4ISme2ogTXJI754/lBn4FESmOEbPIk0o/WxJMux26TSYRKkSTkYSLFho?=
 =?Windows-1252?Q?hAFBH+Mvaw+HYyyEvUmBOq1Yezvs36qRgbWCgCok785FtbnbQxWSW/hb?=
 =?Windows-1252?Q?jR5sQo/pvcWkUl7Aag/akKV/PeOCFTpyNQQFQWrtTxARDBaKxphXTZgi?=
 =?Windows-1252?Q?ndd8xRLP0wmijA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed005fca-2992-44ef-407a-08df25126994
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 08:01:52.0764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nA6VwmEzOBEfoj+SH7a8nR9bPqO8/vnfSXNTk+6cSOoil9cDJF/Py8eOixP6AN+qwkBk9EXyCStlZEkLhiUXjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911
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

=0A=
=0A=
On 07-10-2026 23:03, Stephen Hemminger wrote:=0A=
> On Wed, 7 Oct 2026 16:28:54 +0000=0A=
> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:=0A=
> =0A=
>> On 07-10-2026 20:56, Stephen Hemminger wrote:=0A=
>>> On Wed, 7 Oct 2026 07:24:37 +0000=0A=
>>> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:=0A=
>>>    =0A=
>>>> On 06-10-2026 20:31, Stephen Hemminger wrote:=0A=
>>>>> On Tue,  6 Oct 2026 14:56:36 +0530=0A=
>>>>> Hemant Agrawal <hemant.agrawal@nxp.com> wrote:=0A=
>>>>>       =0A=
>>>>>> This series collects a set of fixes and enhancements for the NXP DPA=
A=0A=
>>>>>> bus, mempool, dma, crypto and net drivers targeting 26.11.=0A=
>>>>>>=0A=
>>>>>> It includes memory-leak and resource-cleanup fixes on the device=0A=
>>>>>> remove/close paths, more robust frame queue and congestion-group=0A=
>>>>>> shutdown, secondary-process safety guards, BPID and cgrid lifecycle=
=0A=
>>>>>> handling, and several new features: offline (O/H) port device suppor=
t,=0A=
>>>>>> enhanced virtual storage profile (VSP) port support, fmcless Rx queu=
e=0A=
>>>>>> configuration via devargs, Rx/Tx taildrop threshold devargs, non=0A=
>>>>>> fmX-macY shared Ethernet naming, and DMA scatter-gather and=0A=
>>>>>> errata-workaround devargs. Documentation and release notes are updat=
ed=0A=
>>>>>> accordingly.=0A=
>>>>>>=0A=
>>>>>> v21:=0A=
>>>>=0A=
>>>> It is becoming a never ending cycles.  Every time we fix, it finds new=
 issues. Can we put a limit to accept it with no errors and minimal warning=
s?=0A=
>>>> I am anyway fixing the following and sending v22.=0A=
>>>=0A=
>>> I won't accept patches with errors or warnings, sorry.=0A=
>>> You can run the same reviews locally.=0A=
>>>    =0A=
>>=0A=
>> Ok. I respect that.  Please check V22. If there are still warnings.=0A=
>> Will you please let me know what all you are running for review. I will =
try the same locally.=0A=
> =0A=
> I use claude with either web gui or desktop app mostly. And the AGENTS.md=
 that is updated=0A=
> by this patch set. Claude is smart enough to read local files. Usually I =
format up a patch series mbox=0A=
> with cover letter and attach that. Though when using CLI you can ask it t=
o look at commits directly.=0A=
> =0A=
> The changes in this patch are mostly about getting CI version to not give=
 low confidence feedback.=0A=
> https://patchwork.dpdk.org/project/dpdk/list/?series=3D39179=0A=
=0A=
Thanks. I have tried using vero-coder wrapper with  "us.antrohipic.claude-o=
pus-5 Model" over your changes in AI review script (I don't have Anthropic =
Key) .=0A=
=0A=
=0A=
Please review V22 -  My report card is saying : =0A=
`v22-review-report.md` =97 27 patches, 0 Errors, 0 Warnings, 2 Info,=0A=
=0A=
=0A=
=0A=
