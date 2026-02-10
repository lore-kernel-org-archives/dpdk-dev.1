Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F2EB26F7
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEFEF406B6;
	Tue, 10 Feb 2026 19:04:17 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D9F1A40697
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:04:15 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AHsnOL1274626; Tue, 10 Feb 2026 10:04:07 -0800
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021077.outbound.protection.outlook.com [52.101.52.77])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c89g1g0pt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 10:04:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuW5VH5TXTtDoZpau0Y+PEkoPeBnRTij3g7mESvHg+2zRaQBgAfU7H/edkaTxAPXFe1MR/ufKMvR7hp6nAkd2zcOV51vtuOLgcovfem8HxmfzOuC35Hc2vY2svJ4QOK2IzPkOnjLEFBBxEVlYeo23ceaqhhXkBhtAFIh+b0ctiI75LZl5S84lgPUNaAR90w2r8aCZVNEY9XbgiIDV2vMl135bCATGcpyn5xUujOeSpJSo+mSTFQEzWad7TfIXTj7/bZdEvrKNJmEcs+D5rGeX1HBsLFEQ9B5Jat+ObEjBtVY+TDI068cdIo/agBYfodRJTYGRDYe3I+1ojyGrIkcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddf+uTBvuMZNbUiK7WkXTPwmbv4Tz8lIklRcrj9NtUw=;
 b=KLUmkiUm2NQWWN+25oN307vWLm7oV1Tf+wbpvwEOB01ng4eP4Php5ED4zecSA0ozPkxbt8M+5hAqX59W2sXhdklDzIriJ4mranPaKmevWq0j195XEYbaCVeS71lvBYY6zjr9cstKuljHPByedFQ+E/YioY0EUXXbmd2iO6s54azCyKsAsyYx3gQUbJ6gVCW0aO/xu56Mph6K2+L3OI9SpnV6EXGIDf+Wam2svI2EBgO38aTMh8zwMNIVYVbGv6HQhPKHRMNUXhX/FoU+JmFS4rW91tiPV4A0fPqbbAUUSIfQlcrgIpaCSy4dAO/Tt7YRD/0pfDbRuiSD9J+IX3JjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddf+uTBvuMZNbUiK7WkXTPwmbv4Tz8lIklRcrj9NtUw=;
 b=dLDUUzTnpinCPSFUFbkMJyfLk1iFxe8UmqLv+xADOu4Zj/uUH+Vcke9bKsgNNYHCs9qnzZ9fLkHOfLs5NX6RSAt6cxPzV169dbeezr0yXgb2QEkgSnRvnFitpzrup82+fgtOjJbnKwopJTzxgJle75Xm9r+k5LSutQrMo8Qq28c=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO6PR18MB4081.namprd18.prod.outlook.com (2603:10b6:5:346::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 18:04:02 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 18:04:02 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "kai.ji@intel.com" <kai.ji@intel.com>, "pablo.de.lara.guarch@intel.com"
 <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "weid wei.dai@picocom.com"
 <wei.dai@picocom.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Topic: [EXTERNAL] [PATCH] crypto/ipsec_mb: fix clearing snow3g digest
Thread-Index: AQHcidPTJMSJpLGdo0mOfy1/GuANj7V8W3Sw
Date: Tue, 10 Feb 2026 18:04:02 +0000
Message-ID: <CO6PR18MB44843F6D8D644EDBD045B45DD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260120061234.137-1-wei.dai@picocom.com>
In-Reply-To: <20260120061234.137-1-wei.dai@picocom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO6PR18MB4081:EE_
x-ms-office365-filtering-correlation-id: f4171eb4-e46b-4292-b64e-08de68cec605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WmdjbUVwRCs3U3lCWWFxOHZqdWZBM2x1UGNIOG1lNjlUKzAwczJoTmVPR3Q3?=
 =?utf-8?B?UnE5MlVvMXpSRmVBTEl4ZEJQRDVlTXpHS2E1MVlPSllOQU9hR2JWK2RzT012?=
 =?utf-8?B?WVV6QkVDQWord1IxTzJwRDNPdStqbVJkSUh6YXg5THl1bUU5dGF5T0RWSFVX?=
 =?utf-8?B?RXZCSU9SaW9NS0tLelZaR1hLWUdjbGNvM210bzZBVVA1WGlIeFkxTnpZSytC?=
 =?utf-8?B?WTBwUmFrbmhJL3dKTUpTOUlRVS9BM1BIajBIVHRFL08ycnVJRWdrTFdxZmJz?=
 =?utf-8?B?YmJURFZwMUxPUFc2NUk4ajBlQnd4NmJya1Z1NThNRG9PUUdyb1JvdS9JbVNF?=
 =?utf-8?B?TldWT01OOG0vVk9iSnhpeERYcjZOTmZRdGw3TXBqVUhpV1hZNStFejVxSGNY?=
 =?utf-8?B?NndubzRSbFozYVcyL3V5SE9zU0UzNWoxVC8vQzE1bjdYQm5NQ2hDaGx5NUVt?=
 =?utf-8?B?UEZKS1BYMmJaWisxMDhBSGNmNzZHaWpRdGZZMkRGUXhVc095RUNWY2tlQ0Q4?=
 =?utf-8?B?ekdvSnJrTStxZ1JMY1ROUi84YTAyNVRITksvTWxEaW5xQ014aW1tckxqZnNu?=
 =?utf-8?B?Y1ppVjRKYkRrdnBZcVVqT2daQmJLK2dITVVJWVVzelhxWVZxeTJUU1RkRzZO?=
 =?utf-8?B?aXRYN25aaE1HV253ZXJyZXZkOHdoQWdsaXBUQWh3OHN5ZERKNmd3S2duTEZD?=
 =?utf-8?B?d2YyMHpnZjdUWjFhdVBhbHZhOWxkYjdOZExnYmllWU5zZzQ2d3g4KzJlb0lY?=
 =?utf-8?B?NlF4SjJMZHNZWU9zejBDM1pQNGNhTFBWMGlzWTd1QVNEbTJnK0RQOUR4M1Z1?=
 =?utf-8?B?SlU5K00vVW5zMzAvdUc3bUczZ0FZSEZwMk5MaVdKYlpOTmc3U1QrRVdLNml6?=
 =?utf-8?B?L1lkd2VGbE8wd2xqbnFQR0lkN01qc0pwRzBVY2lPSHU4SGJ6TTFqY3lwM1Ra?=
 =?utf-8?B?Sk0wdld2VSszL2k0OHhVKytWRTRvZWFBaGpuQ25yMEo4dklwWXRLR3ArTzFZ?=
 =?utf-8?B?LzdiWnNDY0I5MTNwTTRKOVRMV2dFVDF2WHZaeGNZTTE0dS9saEhoVUVKQkNH?=
 =?utf-8?B?KzRDSEZWVHA4OE9hSkVLci9YVzRVeVpqak5kb2M0ZzB5dzA5a0NhcVFNclEz?=
 =?utf-8?B?UzNpL2xKT3VZd3BJNDdjbjFQS1dqSi82U3BVbEx5MUNrd0R5N0V5bVlVK3FE?=
 =?utf-8?B?RnloUyszQm4yWjk5bVlSSm0vUlN4cXUwcDFiVkQ0eVdCQTU1TEpGeDNqbDUz?=
 =?utf-8?B?dmsvZzcrQjJCRUZXSU1aa3Q5dHRGSEVYQkhLUWtOZkk2QTFlTkdQNzJ3THBO?=
 =?utf-8?B?YmRHaEwxQlRkSThFb2Q2clhlSUtrU0VkYmxoYkpYNjE3UDJ6ZWEvbkJQc1h3?=
 =?utf-8?B?U3Vya0hBQzFieUJrNld0N1R0eFI4OUdka2ZJTGEvMFVCSTBiNytNMjcvbWJD?=
 =?utf-8?B?SVJvM09OZzVXNjFHUG5vM0ZZNDlwOWxCL08vZ3p4aitsa011djcybHVXeVRN?=
 =?utf-8?B?cWxLMUhDeU5aN21TUjVtb3hEdzh1bDEvZjN5MzZzb1NjaHYzTWphY2Vma01a?=
 =?utf-8?B?UHA4VWR6OHJlbGZkV3NJbnRkYXRKY2lDdk5SNDJ1WUp3VHpycGxSbmRuYkx6?=
 =?utf-8?B?ZnlYK1dnVkxUOXRaM1pjRXBBd2pXOXdPT0wveTVVUVNCOCtxL0JrdExuTDlr?=
 =?utf-8?B?TzNzR21pU2I1SmJSUkZaWVFsSTY5dW94akNJV05HUTJTeWIyT2pHQWl6Mlgz?=
 =?utf-8?B?RGhialUxbGVpRWFqdEtZb0QyK1A2aXhRZHlqakVpb0pCV2hqaEc5K3lKWUo2?=
 =?utf-8?B?OWtnYUQ3UDhKalJleWxIeE9JSWNhUnBkMTU3Rnd4bmExcjI5OFVEWmR3eGVU?=
 =?utf-8?B?UzRzWWJiSis0ZkFrQUthdFdYTFhEL1JSQkxPSHV4RVhTcDdwdCt6RVBjNFZi?=
 =?utf-8?B?ckgraXE4MFczYmNiRUtNTjRweHFuK2QxOUdPdXJ3d2hnYlRJVlBNeXhNTThO?=
 =?utf-8?B?UnlkZXBKdHlxbzlmK3dtK0I3L2ZKU1duMHh0Zm9TWElBelFsZmhsbW95Umgr?=
 =?utf-8?B?ek1aQUp1eE5qeXQ3SFRmczdKejRWRUNqNy9ucEE5andERCtWZ2srcDl3Y1Ns?=
 =?utf-8?B?Vnh6WW9FdUkxaURNMmZTQnQwcTdUSi9LT2RnMHZKTXZZbTM5T3ROdFFmNlhs?=
 =?utf-8?Q?QOyRQyaQGcnihT0Cc/tlnx8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1hUU3IrRk42d2IycDJVOHg4Z29OL1VpQXBjWVF4QS9uL3J1YTg0TnVoTGpP?=
 =?utf-8?B?UFY4bzQzdE85U1hkR0VNZGxnRXBDM1VEN1BHNXNQaTJ4bDBCOEpYbC9PdE5P?=
 =?utf-8?B?NDM1OTk5UmZ5KzhDdFJjejh6ajdRQ1ZIZlhmRlFzRTBnZCtJZ1dLWjhQTDNq?=
 =?utf-8?B?WGRuM0xnOHRrbFMxUW5ybFRhQnlGL1BIUERhOFk0Yy9DYTRkd3VrdEtaZ25h?=
 =?utf-8?B?SkZsMkxZaDhnazJlR3R2SDNKcUZYNCtjV2lzMExtazI4SVpaVUtsa1lmN0Zl?=
 =?utf-8?B?ZEZhb2xFZDUvZU9KcFJxQWZOOFNkSWhmNHJOOWg1Qk9aNkVINU1VOVZlOVg3?=
 =?utf-8?B?YWlCUWFUOVNNL1lOeUx1M1lQRzhRbUNRK2hnUUlhVWJ1Vkd4ZExtbXdmT2pV?=
 =?utf-8?B?eVRBSHJYZWZ1eG9NQzlCd2NMQlkzVUZGU3h5bmR3MWE3UEViVzVXalN0aDhB?=
 =?utf-8?B?V1Z1WHVpcmVRbVdlMzZ1NTRDZk9UaU1WQ2dSeERyWVpUYWJBRXo1dk52NEdZ?=
 =?utf-8?B?NmIzc0NjQ2l5T2xaZG1saCtLc1QrNkpIb25TT0I4YW9kKys0TnFSN3dRWURX?=
 =?utf-8?B?cmZBVnE1L1dxUkYxWGR4MVQvRENNcHNhcTY3ditVUEVMQm4yRXpjV0ZQNFR4?=
 =?utf-8?B?NWY1a09MN1ZxTFhwNFBlMnJRZytQR0RUbUd4emNGdlA1ak8xVVM0Wm5BWEZn?=
 =?utf-8?B?R0VTUUoxVE40dnFSSjJTNlIwSmxnREhSR0p5VnBLa2l4YW1OM1VqWGxkTEhE?=
 =?utf-8?B?c3kyaHpNRkR6NTNMNUZiSDVDa2ZTanlrV3RJYmFhNnhQTFFacXlENFpESFh6?=
 =?utf-8?B?a3RZaURQUnFhYUVSa01qSHo4MDJqVFNydnIzVFUxNVJRYjhmUlpFMWxxVFRw?=
 =?utf-8?B?WCszTjlzUUw4M1owZitKWGhQUnNER2dWZHpESy9HVnFBMjl4ZG1DR3ZFL05m?=
 =?utf-8?B?SDFESzBmcFV6bTIzTm9Gb3lWOVFERUJVU2o5cnF2K2o5MHYyRFJjUWhIK2gx?=
 =?utf-8?B?Z0IxcDRpQ2pqVWFMVDdvcGxvT2xpQ1phSURlVnpDOW16aHVxUGppSkNmZFVU?=
 =?utf-8?B?TFM0b1RYK2FNMENuWU9lNjhSNEgwaklmdlVZN2RKK2psdkFnYlRuZjVwUjhm?=
 =?utf-8?B?d2trRnRhRlZNeUU3YlQ1NkpnK29sUW1tcGVIeGRVMm41NHZKVzliQ09LQ3JH?=
 =?utf-8?B?Q2JzS250N1NWZ3NjdmlaUmpTQ29IcEg1NmdSSld4QUlDWWIwcmplZ1JhUjhi?=
 =?utf-8?B?TklXKzVNTjMvUk5Rem9LeXZyaFpydUtTR1dZd3hKc3lETkkrcldWZ1V4aEtP?=
 =?utf-8?B?V2VPL0MvbDU4SVFQTi9YeFNqSFpvdjNYNEJDVzhGUy9taTErT0UrcVI0VjJk?=
 =?utf-8?B?RTNxL2JmVElsZU5KZE51RWVQeTRFVTJMRDljdDkxQ1oyek9uU2NQWDQ5bUtW?=
 =?utf-8?B?WmEwSWhJcVJrdFEvMFphV3lTWlRHOUFQZ0kzMUNIbnpoM3QzNDk2eHVQNWFa?=
 =?utf-8?B?WjkxQnJhM3c1bzl5ODhxRGNaQWNVUkpaU0NpYnhnd01LK1Q5L2xyNlZqWWZy?=
 =?utf-8?B?V01qaXExamhyR2hyUkRveEcvenN2S1l1TDd1YmVoY2Q0aDNydWk0cllpMExk?=
 =?utf-8?B?Ri81N3JvRDRPWlFJVkVoNTJ4VVRCRjVjNUlWa2lYTkorVThiU2JlWm1TOGZv?=
 =?utf-8?B?b214TjBvcmhOMUprenFpVUtKeU9kQ1crUU1Bb2NWUk9EVFFTMnNFQ01UUEU3?=
 =?utf-8?B?T1dCeHhibWpYNEhqRjNEbjhNbmNZUGdTUDZ1dVZmeE9OOEJoTHRadXpXMzBP?=
 =?utf-8?B?dXBJSUwwN0NvQjZaYWZGNGNadVlld2N0UzBTZXBvSnVXakV6THVjcHROT2Fz?=
 =?utf-8?B?ci8yRGFheHdpVlhHOUsxWEo1VElLNHM2ekJzb2lFNFRlT09MMEo0ZGhFWnJh?=
 =?utf-8?B?SXRSWm05VENUNmt5WTU2RVVocmdxKzYwWlNsVlNjY2dSSkZyUzF6SHNhYzdy?=
 =?utf-8?B?QnRhcFllVk9GMGNTa0tlMGErazROZ2dmckhvUkJndDYwaHdCNXVlVkdEQ2tZ?=
 =?utf-8?B?NWlFcFBQTlhPUlBCLzhRQUZtY2U1alJXMmxPTXpiNzRvam1LS0FhSnU0Sk5x?=
 =?utf-8?B?bXdGYTZ1aHJVY2ZYd2NYRCtQZXBOOWwxYzUxT3pKVGdsVTJuZS9QdCtWYktK?=
 =?utf-8?B?SGlYR0VjeVcrLzlxcGdLemdzYU1naE52Q1JXSXRscjVNVDJLazROdElPcnp4?=
 =?utf-8?B?V1MrajA1TVk1Nk4rYVlOdTBNeGZLRUJseksyclY1ZW12ZEswczhkUHNBS2p2?=
 =?utf-8?Q?rdMCM35YWt+ej7y+Dn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4171eb4-e46b-4292-b64e-08de68cec605
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 18:04:02.7885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vg+RsHoLNKdeAcHWcCqixHHlKRBWeMdctkCFvf7kbH5qYMpAE2womJqn3s6axEzsT/eJmTYUfIkEoC2lMXPk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4081
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=698b7316 cx=c_pps
 a=gZV5Ef4gw7eWa1hDQMD07w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=Zc_DtpmQZw8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=MQOVprpMAAAA:8 a=EA0UHxcBiB4p4nxP9JAA:9 a=QEXdDO2ut3YA:10
 a=plcQb93oC-aU43enslkw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE1MSBTYWx0ZWRfX1qWAei6nLucU
 B24jy0JlboefYKyTB2hEpS1sa3NSlqgj2KBlO57B4n1oRsPm8a2XxI2RurhZ2LhfOpWtImrg29H
 PZWd9w1lzcvD1lkLIQxomwKlVdrVfZ0ibsGewAm8d5T6RbkKM6D1wbuE2+/LN2V+lqaQwUgAmv3
 ezRN61QulDJBE26tUrxmtm81kkFro8z0/WJXm00a2iinpd/V2mJPlufuiSbsNUztq6FyD/XJZd+
 A2gTL1IphhgTUk6L5m/CPkJCusw0uDBXTptoQ+/jxLXB4D0Me/11QpUBVhnP8H43T/M3wIzI+Zt
 mZWZtnxoh7hHfUkyvB1PG6RIXzTWRinqooHlHRCHo8B/txo8Q3xMymW/b9f25PnGqjQ5ukwdfXv
 VtX5zqnyjq/KfPKQ4fMMtIfpMRenPVaJ4WUUxP+jh/BcIBZtU1kslX/2SqgSk+JlNIBrJNEsVAT
 TcnB9AUpSoyqckOdzMA==
X-Proofpoint-GUID: NfX_rvgin4P3eGR8H0YX7Us9bMI4Xc-r
X-Proofpoint-ORIG-GUID: NfX_rvgin4P3eGR8H0YX7Us9bMI4Xc-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_02,2026-02-10_02,2025-10-01_01
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

SGkgUGFibG8vS2FpLA0KUGxlYXNlIGFjayBpZiBubyBvYmplY3Rpb24NCg0KDQo+IEZyb206IHdl
aWQgPHdlaS5kYWlAcGljb2NvbS5jb20+DQo+IA0KPiBCZWZvcmUgdGhpcyBwYXRjaCwgdGhlIHNv
ZnR3YXJlIGNyeXB0b19zbm93M2cNCj4gY2xlYXIgdGhlIGVuY3J5cHRlZCBhdXRoIHNub3czZyBk
aWdlc3Qgd2hlbg0KPiB0aGUgZHN0IG1idWYgaXMgc2FtZSBhcyB0aGUgc3JjIG1idWYgaW4gY3J5
cHRvDQo+IG9wLg0KPiANCj4gVGhpcyBidWcgY2FuIGJlIGNoZWNrZWQgYnkgZm9sbG93aW5nIHdh
eSwNCj4gc3RhcnQgYXBwL2RwZGstdGVzdCAtLXZkZXY9Y3J5cHRvX3Nub3czZywNCj4gcnVuIHBk
Y3BfYXV0b3Rlc3QNCj4gdGhlIGNhc2UgZmFpbGVkIHdoZW4gaT00MiBpbg0KPiBydW5fdGVzdF9m
b3Jfb25lX2tub3duX3ZlYygpIGluIHRlc3RfcGRjcC5jLg0KPiBUaGUgY2FzZSBpcyBQRENQIGNv
bnRyb2wgcGxhbmUgYXV0aCBzbm93M2cgZ2VuDQo+ICsgY2lwaGVyIHNub3czZyBlbmMuDQo+IFRo
ZSBjYXNlIGZhaWxlZCBiZWNhdXNlIHRoZSBsYXN0IDQgYnl0ZXMgYXJlDQo+IGNsZWFyZWQgaW4g
bGFzdCBmb3IoKSBsb29wIGluIGxpbmUgMTY3IGluDQo+IHByb2Nlc3Nfc25vdzNnX2NpcGhlcl9v
cCgpIGluIHBtZF9zbm93M2cuYyAuDQo+IA0KPiBGaXhlczogNTIwOGQ2OGQzMGNiICgiY3J5cHRv
L2lwc2VjX21iOiBzdXBwb3J0IHNub3czZyBkaWdlc3QgYXBwZW5kZWQgb3BzIikNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IHdlaWQgPHdlaS5kYWlAcGljb2NvbS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVy
cy9jcnlwdG8vaXBzZWNfbWIvcG1kX3Nub3czZy5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2NyeXB0by9pcHNlY19tYi9wbWRfc25vdzNnLmMNCj4gYi9kcml2ZXJzL2NyeXB0by9pcHNl
Y19tYi9wbWRfc25vdzNnLmMNCj4gaW5kZXggYjNjM2IwNWE4YS4uMzVmZTIzYzE1NyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9jcnlwdG8vaXBzZWNfbWIvcG1kX3Nub3czZy5jDQo+ICsrKyBiL2Ry
aXZlcnMvY3J5cHRvL2lwc2VjX21iL3BtZF9zbm93M2cuYw0KPiBAQCAtMTU3LDcgKzE1Nyw4IEBA
IHByb2Nlc3Nfc25vdzNnX2NpcGhlcl9vcChzdHJ1Y3QgaXBzZWNfbWJfcXAgKnFwLA0KPiBzdHJ1
Y3QgcnRlX2NyeXB0b19vcCAqKm9wcywNCj4gIAlmb3IgKGkgPSAwOyBpIDwgbnVtX29wczsgaSsr
KSB7DQo+ICAJCWlmICgoc2Vzc2lvbi0+b3AgPT0NCj4gSVBTRUNfTUJfT1BfSEFTSF9WRVJJRllf
VEhFTl9ERUNSWVBUIHx8DQo+ICAJCQlzZXNzaW9uLT5vcCA9PQ0KPiBJUFNFQ19NQl9PUF9IQVNI
X0dFTl9USEVOX0VOQ1JZUFQpICYmDQo+IC0JCQkJb3BzW2ldLT5zeW0tPm1fZHN0ICE9IE5VTEwp
IHsNCj4gKwkJCQlvcHNbaV0tPnN5bS0+bV9kc3QgIT0gTlVMTCAmJg0KPiArCQkJCW9wc1tpXS0+
c3ltLT5tX2RzdCAhPSBvcHNbaV0tPnN5bS0+bV9zcmMpIHsNCj4gIAkJCWRpZ2VzdF9hcHBlbmRl
ZFtpXSA9DQo+ICAJCQkJc25vdzNnX2RpZ2VzdF9hcHBlbmRlZF9pbl9zcmMob3BzW2ldKTsNCj4g
IAkJCS8qIENsZWFyIHVuZW5jcnlwdGVkIGRpZ2VzdCBmcm9tDQo+IC0tDQo+IDIuNTEuMC53aW5k
b3dzLjENCg==
