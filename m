Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF6FC19F32
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 10:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF464029E;
	Fri,  7 Mar 2025 11:20:38 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 8F88B40275
 for <dev@dpdk.org>; Fri,  7 Mar 2025 11:20:36 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2175.outbound.protection.outlook.com [104.47.51.175]) by
 mx-outbound11-255.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 07 Mar 2025 10:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRXC9C7SRzqzsnHUpnKsPbnQ+7ApwlDl/QvTuPpYlKiLdstlIWEggfFpNpH9QuJwfXQOIpTPv2w+R3FbSK/OSW02ud8oS3NMUfWbrdgAlXP8Ui6rI8qGI0XRNkig+uBkNK7jK6SRW9pZ87PYMLozvVrto4mF3mvMCgDdRnPc2EKgI4uUuiS3lvWFkFJenE0f5xMPH+uRzCxXhypA72r7tgxizD9VqAklWkoiFI0e3Mpq/bURnYe5FVJ/Du5NXsTAUPi4WTIgKpCAmDfuzH06ACMA+kgGBb7iCe+NsFhJEGzh4L0lJz8b9lckYa9HWs6XaZFdilhm4CDGiSzeb/TtoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLbSxuqMG24SAkjEf90qlYAUEl+n8q5aVm6XLlSxVJc=;
 b=zCV8qfAWsYI3cvEvBQKx36If7kVvwnJEkkKxTRrdaqiXO2rT4I4huue+7sgCojipI7MfuT8BfqzOX1FCEhILDZlBNJXQYVBW4JT8lFKNzldx0r61igLuUuT7WFDEcxA+DUSEgwCYcOGdUMuvbMWXZMloQB4IhDVQJ+OlTfuPNMkO51aiHMs6pgAXhRgmC82F+BuSiKikm8C1AsHqs2Ffd+d7LyV8kEjrE+oYoUB9Xs9GbzjxFZfNqe9VGJNJJ2krYDJWvazDhbq92QUc11kTe4kAjVmeDYRBipWbyWJGJHkOjtslE4ZQgeBq+xfRZj83eLQySymKWTR0geibPmSH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLbSxuqMG24SAkjEf90qlYAUEl+n8q5aVm6XLlSxVJc=;
 b=kWCwYMQrHUis5oIJ/M4vJHEWBpUkF090V89Am0D9ccHfmYoENSS0XGZxgLo7ip1wSXxI+N5vOlKnmH4kqZwEWobFNJ9H5x4CWIsYW/JVAZ9PcYBrLOEcTm4wWoUI03I/5GpneBqOaLeLdaQ3mz6z8P05bIzt2kO9TV32g3NVP94=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by DB9P190MB2012.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 10:20:29 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 10:20:27 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Mykola Kostenok <mko-plv@napatech.com>,
 Christian Koue Muf <ckm@napatech.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, Thomas Monjalon <thomas@monjalon.net>, Uffe
 Jakobsen <uj@napatech.com>
Subject: Re: [PATCH v1 20/32] net/ntnic: add clock init
Thread-Topic: [PATCH v1 20/32] net/ntnic: add clock init
Thread-Index: AQHbg+Np9klpA7jwikmEvnryLTJvpbNk2T+AgAKvlP4=
Date: Fri, 7 Mar 2025 10:20:04 +0000
Message-ID: <VE1P190MB08301A245E9958C21C63D0FA80D52@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
 <20250220220406.3925597-21-sil-plv@napatech.com>
 <CAJFAV8xtMHZfXo3c8vw0LG9-Cg4v8LCKjP8+psm=sJ3XoFzyNw@mail.gmail.com>
In-Reply-To: <CAJFAV8xtMHZfXo3c8vw0LG9-Cg4v8LCKjP8+psm=sJ3XoFzyNw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: uk-UA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|DB9P190MB2012:EE_
x-ms-office365-filtering-correlation-id: 0ba81c73-2369-45c9-c4ad-08dd5d61ae43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d3lscGFQLzBvYytNSkRnMmZHRk1jcW1TWWN2Vml3cmoxWXFIWEliTlJyZlZy?=
 =?utf-8?B?cWg5RnBNRExZUW1ZdWM0eDNpTTdsNThmYXJqNW1jY1RwbVdtQWhnVzc2R2FI?=
 =?utf-8?B?RWhWYmN5ckxGWTBGdGhYR0NEUjFhbnV5SDUxTG5Ma3UwNTRBeXQ4SklFKzFz?=
 =?utf-8?B?TlJsd1V3ZDY2SkdvMnVVTWo0WEg4SE82VTJvVWxiMWpDMWZJVlA0Q24rVVJW?=
 =?utf-8?B?ZllIYkJBSkFNdDVmcGNzSEtsUDJOUmtoNDhFSFFTa0xKQk5LdzhtUGtRcWhr?=
 =?utf-8?B?dWd1UGpmYzQ2MXNIdEltR1FETGJqdmpWMXVnRXl2bXBzYnFnUmtHUWludDJC?=
 =?utf-8?B?QnE1S0NjV2pZYTArVzd5Y0hjTXEyc25oT3BtK01RWjJwRXZpT20yWTdPZml4?=
 =?utf-8?B?ajZmYVNLeG03blNkbC9kTHVIQjJBQzkrN1lEM0lkbUxhSk9DaDhvZFBpM1Bs?=
 =?utf-8?B?M1dXbGEycDBqL2tQRDNxNjc0TjR5TWtZMGlVWmtpa2xsNWczTXdVd2JRMlAr?=
 =?utf-8?B?My9QTlhsR05IZnFIVmdmVzdrOHp6akNIc0twWGFnemFCNHNVL25aQ0JLYXBw?=
 =?utf-8?B?WHJiOWpncHZuT3JyOStBNW9HZ0NVMUtEZklTeG9rOFhDUFYvTVhKTlBEMlNp?=
 =?utf-8?B?UXZ1Qm5lMFNEbGxVVnRtRnNKY1diKzgvakEzLzNKYkRIWXBCcmdDMTJTa0tp?=
 =?utf-8?B?WGtZWkorZE53SWVJWmVxR2ZSUHZ1MU5QUGo1Ny92YWFyemRnaEUrRCs2VE1o?=
 =?utf-8?B?OGtFSXFLMm4xWWtiNGlSc0xZY3ovNjQrZzIyTXRIZ3BZZHZjRUllZzVndk5z?=
 =?utf-8?B?UFBIVDlRKzNTb0NNSmc2dWxCMWhoL2xKS2I0WnZ2TTJUM0pBTTJaUnd2YSs2?=
 =?utf-8?B?SW13NmxOb0QrM3MrYXRqVzd2Z3l3L2NkKzVqY0xoc0czZEErdWJWcmpnN1Rq?=
 =?utf-8?B?QUM5RHR4alUySHZ6Yk1GOXErcmhzdjBEL1ZjaUFwMWFXdk9zWFM2Nksydzd6?=
 =?utf-8?B?VzRKNGdvOW1hOEJjN2tWTEFOeGE4YmxRc3ZCSzdTTzJhbjd2cUU0ek9LWlMz?=
 =?utf-8?B?L1owb29uc0pkZzIrZmlqTGRtRUNWRXdjcXFsd0ltTGFJdTdBZ041T2N4VTRJ?=
 =?utf-8?B?Vy9zN2t6a3RvQUNIamdvQTIwbGRkc3FqTG93a2tUUDU3Y2hwb040OHM2SW95?=
 =?utf-8?B?a2pBTmtCU1VubkQza1g1ODZFZE1IbnRGRmZqN3JqUlJ1aFRDbWdVVzY2ODhI?=
 =?utf-8?B?RzNSR1V0djl2M2xKdnpHWjZTKzQ4b1lNdDdXZGZmZFlDM2ZCS3BnWCt2elhL?=
 =?utf-8?B?dGl1RlJUb1l5TmlEbDdsNmhOUTV2WHhZMFFBYTUyZFBJWStPTzdWSUx4V2xB?=
 =?utf-8?B?R0sySC93UVBEOWJoR09GaFo3RjUyZTdDL1BmRnI0TEhmYTF3T21UY1hhWlBu?=
 =?utf-8?B?SGEva2pLU2ZJR3NCcmR4Tk51UTI2YkhzWHBMZGRTOXpDeGlreERCMDRKSm9a?=
 =?utf-8?B?Z1lwdDNMaVdhR2kwczNoaGplTDFHRDJCWW5aNHRSdmt6QTlGZE5Lbi83cUVq?=
 =?utf-8?B?MVp5eTRPMHp2T1diUmhNNVZCWlV1V08rQ1JCVUFTbWg5S1BySVZRMHR5aWox?=
 =?utf-8?B?dzloY1dKRUg3SW82djBjRjNOWWwrcHk3UHJBV2VveDdvVDdBaE9JWmZydU5v?=
 =?utf-8?B?NGxCQUNtN1JCck50OFVzYTBSd1VJclRmandHV1RJK0s1ZUk4Q296VHp2VXFH?=
 =?utf-8?B?WFMwaHorekdndUpYbzU2V2ZKWGJnUUZYWW00Y3dXNGp2ajhtcDlnS0l1NUdt?=
 =?utf-8?B?dlh1U1hhTjNWOTRqeHpXaDJ2c05KV1JlWXlKVUF2VDVzRnpZTmJiWkw5ZkZQ?=
 =?utf-8?B?WmliVWNObzVib1EzOHp1NzFieEwzYndQSUtBRWhpcEhDbzByR1lpWkNTendG?=
 =?utf-8?Q?gZwTrOLmHXY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDlBNTRRc2hObVdYZ0x4ZHh3RVdtR3lRNWdENStRS3hXazB2Um1EWGx4dU9N?=
 =?utf-8?B?a1J3dXZRaUROelM0SzdZWFNBR21tYzZ2dVArdkduY21OSUVrV3hTdVdscDRj?=
 =?utf-8?B?aDBuNHBTZFFyb1lob2x4b1hKMlRIL3l4cURjVG9nYW1ZSUJmemgwdUpOV1Yv?=
 =?utf-8?B?YjBTdUh5Vzc0K1FuaVpjK3ZKbE8xcnBZMUQ2WTRJbXF0ZklGNHVyVnplS0Fj?=
 =?utf-8?B?Z3NtdE5ZM0toaFdoNFBlY0cwQnc3NXVKTHF1QUNUc1ZzcWNnU0huMkJuWG5q?=
 =?utf-8?B?dDFoNUVlMDE2S3ZBdGNJWEgxaExld1lDNU5SVDRNT1pYSzNmdTJ2Z1VPdEtO?=
 =?utf-8?B?ejJwRklRSTBDT1FBWkpmK29LYnptUnQ1ZGZ0dnlkUlpyaFZqN1h4bnJHdXU5?=
 =?utf-8?B?V2VLV05uZFlTMWJXVG1PWjYvNkcwQkxONEdDdFZNOThiNTkxTFpQQml2aTJk?=
 =?utf-8?B?aUR0VnpyaXMyM2VyVjVYMElNa2VJNUgwZXhhaERsdlZpRUJhaHc4YW5uLzFk?=
 =?utf-8?B?RWZiWmcvL3A5S3ZyV2h5NmJPVFBMa1VyNTJlZTNJVXk3MjZMS0hjcVdaWVhx?=
 =?utf-8?B?ajE1UUk0SnJuUUdxL0d1cWpRT2x4d014RHNPM3NCREVZTStRL1ZkcVI4WlhW?=
 =?utf-8?B?ZlcyNUtaVGVNaVk3YXpVdGd5MFRZSlNneW81cDlta1lhT3dmYXNYUTRRbTBE?=
 =?utf-8?B?K0dpTytJUnpqcjF4Z3BxU3V1d3ZvMDJQV3Z6bkd5WmZJNzVKY3Q5WHpyVlo5?=
 =?utf-8?B?dnRTVlpUZVN3eE9XNDlHbFJJNDJ6b01MZElYRzYxb0hsR1NYbTMzbjBVUjl0?=
 =?utf-8?B?Z3Vqbk5JVi9XeHFvc3lXbkg2RlpUYlVXeS8xbm03R3hYZ25lMFpIQ05EZHI3?=
 =?utf-8?B?N0VsNkZtKytqcmlYOEVNRlFqTEVxMDJ0YlIraFc4cG1Ob0l1amNoVzVwdWhK?=
 =?utf-8?B?akJDM1luL00vTllhdC8yQWlXVERtUEtPeHpMYmNUSHhzSVJwd00rZzhYc3Fj?=
 =?utf-8?B?M0UveVRHRzVPc1Jmd01tQVZleHJnU21LSzY2dUNJWlRtaUNmSi9VN1lHNGtn?=
 =?utf-8?B?OFQ1b2NYZ3Nub2tmYTFTYi8zVk52R3FaZTRDNmNZWWkyNW1ucWxwMnJISGQz?=
 =?utf-8?B?ZHZuc3M1N2l5ZDFnZUdlaXZiMC9IWitNMGF3cm9HQ2MxMThQeTZpTDlFY3pq?=
 =?utf-8?B?V3Q5eDNuWUk4TkJZckdjMXZaVE1HYTFHbTVKdUhNa1ZSY1pxWFpvck9CaXhw?=
 =?utf-8?B?bFJ5RC8rQUlxTnNlQk1hN2Vpb2xlbWE3aklra2ZzRkd6aStYa3JHb09lM1h5?=
 =?utf-8?B?WDBFWGg5ek9mLzBScVN0VUhLaWluMzZLcmlpcFVpZTVFdEVOV2dObWZKdVow?=
 =?utf-8?B?djdGditsQXZOU0YrWXpsT2V0WmN4TC9iVFJjS2JXVHB2Tzl6eG9SRXBNMFhM?=
 =?utf-8?B?eFdBVDFJN2dqckl2Q2syVStKbldPL3pQa2cxVVBNbjEyYnRUZTRCdWU1dWx4?=
 =?utf-8?B?a3JDNFpPbU9SOXVYVGQrYmhnc1M1dTJzWDBaMUpIc0grcUdOVEViNUd6NnFL?=
 =?utf-8?B?b1dsNC9JN0llMzE0aE5FQlVLc3NoeTlxQm15U25hNTFqZDZ6U0VvNGZFb0lX?=
 =?utf-8?B?dGx0bGtMUVV5ekhyMm1oZDZHOFdJMjFXbFc3bXIyaEk5cHd4QzJ3NURQb0JD?=
 =?utf-8?B?ek5UdDZ6L1lDM1YzbzYzaUhOclp6akt3aGNlZEZOTkI0MEVLYzBJWEdlUHcv?=
 =?utf-8?B?S0J0NlBXS09USUV1bnQ4d0dWcnpGczN1Wll1ZmVyMTBJUXhJVTNDMTVMb3hO?=
 =?utf-8?B?OGMwRHVrT3NVNHhMRXdFTEQvcUtscUxPaVBLVCtKbTZ6WGpFZG5zb0hCbDFF?=
 =?utf-8?B?bDN4MVd0a21zRUxnQmNNTDFLcFNDNGozcmVnK3JzWTQ5VFRYbnQ0ak9rY05y?=
 =?utf-8?B?cmthZElhWWhQMGtYZnpIK3FrOWhQTFFLSWQ2U1E0aVE5bEUrMzVLdTNrZ0o5?=
 =?utf-8?B?dVpGbHkrT2gzL3FRS3ppSjRlQ3ROZEpOVTJmTGlhVmJ6Q3pEc2J2V3ZkVTNy?=
 =?utf-8?B?RmtEREd1Q0xOWUdFZ2U5UnF1SFRjZDdGdXJiKzRST3dNZnRURDhnRmF0ekhR?=
 =?utf-8?Q?c7at0SuaozCnbTv6niigUwToF?=
Content-Type: multipart/alternative;
 boundary="_000_VE1P190MB08301A245E9958C21C63D0FA80D52VE1P190MB0830EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +qilNd1uVdDF+IaxavwUTqIPkneTHJmGx5KmKLXcOpCQx34sbAUICA2v3qW+z1YFUYUjxAHYM2onOLngQt6fz8QLJt/crvX2H+n014aHXh7MYqaYyBxC5ThyVo1bh2Mgv4M0WJc/+qcnrXvCNYtCtLaKNFICo7IXFfTVznjUAtOEIJsw+EVzlQcns6a+o5SIQDssM/2p0t/le0rznIJI+lRbsqlu6P1xXm0pJCT69aY4e7lkZxi9lXNgfGgcGqglwvJbsrJbUNEv/1FxThTmIst630PGMvNkeI+7NY9NMGox94QX0hBAEfLc4h8qt7YvETU99BOKuWgBsU1GoSZqDeaWfZldNbslY6a69CwmYViI6OQGL6Sq4V40il8Hfv2EYKGgVkJXZqNqSEHDkueU10KvSGKIIWtumjCzoAJVabkLm0w9e0hTPUmCouIdshGnO4R5TumxPrXI18Fx9B5WJXjnvHvRiLrer3ZtHLfu49lJ3JhIGysNK3avir0ONePvKyEks/8UkmhFgu0tNoD6Yh98tc5pqa0JAHMondR7U/xANQorM3GG2lXt6kn8xzqfLkv67k0SifiVGd4P3akR/Y1kkyawT5+VbRgO4OhA4dBUFx++UdhHLczU4AOc6i8+aj2btdTzSXGWaG0vcRVT9w==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba81c73-2369-45c9-c4ad-08dd5d61ae43
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 10:20:27.2770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qo8Hwtqoajk20wovksLhRsnx/Z85wfY/0DLQ6wgNAjTAZ5UD1qHiwc1KYL65ulkQRkJqxNoDTl178TbNXpXNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB2012
X-BESS-ID: 1741342831-303071-7667-7082-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.51.175
X-BESS-Parts: H4sIAAAAAAACAzXLMQ6EMAxE0bu4pnCC48RcBW2R2EY0KwpSICHuvinYZvQ10l
 tv8KvDAn3sBMcJS2AKo/ZxNtkaNaqORapV3lQdJXjyrGTo8Ex/v/fv6ynH+PrSdE6mMi
 ujqxnHXCyKGGPNKQz/+QGBBFH4gQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262979 [from 
 cloudscan9-141.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

--_000_VE1P190MB08301A245E9958C21C63D0FA80D52VE1P190MB0830EURP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMDUuMDMuMjAyNSwgMTk6MDMsICJEYXZpZCBNYXJjaGFuZCIgPGRhdmlkLm1hcmNoYW5kQHJl
ZGhhdC5jb20+IHdyb3RlOg0KDQpPbiBUaHUsIEZlYiAyMCwgMjAyNSBhdCAxMTowNuKAr1BNIFNl
cmhpaSBJbGl1c2h5ayA8c2lsLXBsdkBuYXBhdGVjaC5jb20+IHdyb3RlOg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvbnRuaWMvbnRody9jb3JlL2luY2x1ZGUvTlQ0MDBEMTNfVTYyX1NpNTMz
Mi1HTTItUmV2RC0xX1Y1LVJlZ2lzdGVycy5oIGIvZHJpdmVycy9uZXQvbnRuaWMvbnRody9jb3Jl
L2luY2x1ZGUvTlQ0MDBEMTNfVTYyX1NpNTMzMi1HTTItUmV2RC0xX1Y1LVJlZ2lzdGVycy5oDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLmY4NzgyOGZjZmUNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL25ldC9udG5pYy9udGh3L2NvcmUvaW5jbHVk
ZS9OVDQwMEQxM19VNjJfU2k1MzMyLUdNMi1SZXZELTFfVjUtUmVnaXN0ZXJzLmgNCj4gQEAgLTAs
MCArMSw0MjUgQEANCj4gKy8qDQo+ICsgKiBTaTUzMzItR00yIFJldiBEIENvbmZpZ3VyYXRpb24g
UmVnaXN0ZXIgRXhwb3J0IEhlYWRlciBGaWxlDQo+ICsgKg0KPiArICogVGhpcyBmaWxlIHJlcHJl
c2VudHMgYSBzZXJpZXMgb2YgU2t5d29ya3MgU2k1MzMyLUdNMiBSZXYgRA0KPiArICogcmVnaXN0
ZXIgd3JpdGVzIHRoYXQgY2FuIGJlIHBlcmZvcm1lZCB0byBsb2FkIGEgc2luZ2xlIGNvbmZpZ3Vy
YXRpb24NCj4gKyAqIG9uIGEgZGV2aWNlLiBJdCB3YXMgY3JlYXRlZCBieSBhIFNreXdvcmtzIENs
b2NrQnVpbGRlciBQcm8NCj4gKyAqIGV4cG9ydCB0b29sLg0KPiArICoNCg0KVGhpcyBmaWxlIGlz
IG1pc3NpbmcgYSBTUERYIHRhZy4NClBsZWFzZSBzZW5kIGEgZml4IG9yIHdlIHdpbGwgaGF2ZSB0
byByZXZlcnQgdGhpcyBjaGFuZ2UuDQoNClRoZSBmaWxlbmFtZSBhbHNvIGxvb2tzIHN0cmFuZ2Us
IGFzIGl0IGRvZXMgbm90IGZvbGxvdyBzb21lIGtpbmQgb2YNCmltcGxpY2l0IGNvbnZlbnRpb24g
KHdoZW4gSSBjb21wYXJlIHRvIG90aGVyIGZpbGVzIGluIHRoaXMgZHJpdmVyKS4NCkNvdWxkIGl0
IGJlIHJlbmFtZWQ/DQoNCg0KLS0NCkRhdmlkIE1hcmNoYW5kDQpIaSBEYXZpZCwNCldlIHdpbGwg
YWRkIHRoZSBTRFBYIHRvIHRoZSBjdXJyZW50IGZpbGUuIFRoYW5rcyBmb3Igbm90aWNpbmcgaXQu
DQoNClRoZSBjbG9jayBwcm9maWxlcyBhcmUgbmFtZWQgYWNjb3JkaW5nIHRvIG91ciBpbnRlcm5h
bCBkb2N1bWVudGF0aW9uIG9uIHRoZSBQQ0IgKGJvYXJkKSBkZXNpZ24gLSB0aGUgIlV4eCIgaXMg
YWN0dWFsbHkgdGhlIGNvbXBvbmVudCBudW1iZXIgb24gdGhlIGJvYXJkIGRlc2lnbiAtIHRoZSB2
ZXJzaW9uaW5nIGVuc3VyZXMgdGhhdCB3ZSBjYW4gc3VwcG9ydCBtdWx0aXBsZSB2ZXJzaW9ucyBv
ZiB0aGUgY2xvY2sgcHJvZmlsZSBmb3IgZGlmZmVyZW50IFBDQiByZXZpc2lvbnMuDQpJcyBpdCBz
dWl0YWJsZSBmb3IgeW91IHRvIGNoYW5nZSB0aGUgbmFtZSBvZiB0aGUgZmlsZSB0byBhbGwgbG93
ZXJjYXNlIGFuZCByZW1vdmUgZGFzaGVzOg0KTlQ0MDBEMTNfVTYyX1NpNTMzMi1HTTItUmV2RC0x
X1Y1LVJlZ2lzdGVycy5oIC0tLT4gbnQ0MDBkMTNfdTYyX3NpNTMzMl9nbTJfcmV2ZF8xX3Y1X3Jl
Z2lzdGVycy5oDQoNCkJSLA0KU2VyaGlpDQo=

--_000_VE1P190MB08301A245E9958C21C63D0FA80D52VE1P190MB0830EURP_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6bz0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6b2ZmaWNlIiB4
bWxuczp3PSJ1cm46c2NoZW1hcy1taWNyb3NvZnQtY29tOm9mZmljZTp3b3JkIiB4bWxuczptPSJo
dHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL29mZmljZS8yMDA0LzEyL29tbWwiIHhtbG5zPSJo
dHRwOi8vd3d3LnczLm9yZy9UUi9SRUMtaHRtbDQwIj4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPG1l
dGEgbmFtZT0iR2VuZXJhdG9yIiBjb250ZW50PSJNaWNyb3NvZnQgV29yZCAxNSAoZmlsdGVyZWQg
bWVkaXVtKSI+DQo8c3R5bGU+PCEtLQ0KLyogRm9udCBEZWZpbml0aW9ucyAqLw0KQGZvbnQtZmFj
ZQ0KCXtmb250LWZhbWlseToiQ2FtYnJpYSBNYXRoIjsNCglwYW5vc2UtMToyIDQgNSAzIDUgNCA2
IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6Q2FsaWJyaTsNCglwYW5vc2UtMToy
IDE1IDUgMiAyIDIgNCAzIDIgNDt9DQpAZm9udC1mYWNlDQoJe2ZvbnQtZmFtaWx5OkFwdG9zOw0K
CXBhbm9zZS0xOjIgMTEgMCA0IDIgMiAyIDIgMiA0O30NCi8qIFN0eWxlIERlZmluaXRpb25zICov
DQpwLk1zb05vcm1hbCwgbGkuTXNvTm9ybWFsLCBkaXYuTXNvTm9ybWFsDQoJe21hcmdpbjowY207
DQoJZm9udC1zaXplOjEwLjBwdDsNCglmb250LWZhbWlseToiQXB0b3MiLHNhbnMtc2VyaWY7fQ0K
c3Bhbi5FbWFpbFN0eWxlMTkNCgl7bXNvLXN0eWxlLXR5cGU6cGVyc29uYWwtcmVwbHk7DQoJZm9u
dC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7DQoJY29sb3I6d2luZG93dGV4dDt9DQouTXNv
Q2hwRGVmYXVsdA0KCXttc28tc3R5bGUtdHlwZTpleHBvcnQtb25seTsNCglmb250LXNpemU6MTAu
MHB0Ow0KCW1zby1saWdhdHVyZXM6bm9uZTt9DQpAcGFnZSBXb3JkU2VjdGlvbjENCgl7c2l6ZTo2
MTIuMHB0IDc5Mi4wcHQ7DQoJbWFyZ2luOjcyLjBwdCA3Mi4wcHQgNzIuMHB0IDcyLjBwdDt9DQpk
aXYuV29yZFNlY3Rpb24xDQoJe3BhZ2U6V29yZFNlY3Rpb24xO30NCi0tPjwvc3R5bGU+DQo8L2hl
YWQ+DQo8Ym9keSBsYW5nPSJlbi1VQSIgbGluaz0iIzA1NjNDMSIgdmxpbms9IiM5NTRGNzIiIHN0
eWxlPSJ3b3JkLXdyYXA6YnJlYWstd29yZCI+DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEiPg0K
PGRpdiBpZD0ibWFpbC1lZGl0b3ItcmVmZXJlbmNlLW1lc3NhZ2UtY29udGFpbmVyIj4NCjxkaXY+
DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW4tbGVmdDoz
Ni4wcHQiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0Ij5PbiAwNS4wMy4yMDI1LCAxOTow
MywgJnF1b3Q7RGF2aWQgTWFyY2hhbmQmcXVvdDsgJmx0O2RhdmlkLm1hcmNoYW5kQHJlZGhhdC5j
b20mZ3Q7IHdyb3RlOjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCIgc3R5bGU9Im1hcmdpbi1sZWZ0OjM2LjBwdCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxMS4wcHQiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIiBzdHlsZT0ibXNvLW1hcmdpbi10b3AtYWx0OjBjbTttYXJnaW4tcmlnaHQ6MGNt
O21hcmdpbi1ib3R0b206MTIuMHB0O21hcmdpbi1sZWZ0OjM2LjBwdCI+DQo8c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjExLjBwdCI+T24gVGh1LCBGZWIgMjAsIDIwMjUgYXQgMTE6MDY8L3NwYW4+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMS4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDss
c2Fucy1zZXJpZiI+4oCvPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTEuMHB0Ij5QTSBT
ZXJoaWkgSWxpdXNoeWsgJmx0O3NpbC1wbHZAbmFwYXRlY2guY29tJmd0OyB3cm90ZTo8YnI+DQom
Z3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9udG5pYy9udGh3L2NvcmUvaW5jbHVkZS9OVDQw
MEQxM19VNjJfU2k1MzMyLUdNMi1SZXZELTFfVjUtUmVnaXN0ZXJzLmggYi9kcml2ZXJzL25ldC9u
dG5pYy9udGh3L2NvcmUvaW5jbHVkZS9OVDQwMEQxM19VNjJfU2k1MzMyLUdNMi1SZXZELTFfVjUt
UmVnaXN0ZXJzLmg8YnI+DQomZ3Q7IG5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJyPg0KJmd0OyBpbmRl
eCAwMDAwMDAwMDAwLi5mODc4MjhmY2ZlPGJyPg0KJmd0OyAtLS0gL2Rldi9udWxsPGJyPg0KJmd0
OyArKysgYi9kcml2ZXJzL25ldC9udG5pYy9udGh3L2NvcmUvaW5jbHVkZS9OVDQwMEQxM19VNjJf
U2k1MzMyLUdNMi1SZXZELTFfVjUtUmVnaXN0ZXJzLmg8YnI+DQomZ3Q7IEBAIC0wLDAgKzEsNDI1
IEBAPGJyPg0KJmd0OyArLyo8YnI+DQomZ3Q7ICsgKiBTaTUzMzItR00yIFJldiBEIENvbmZpZ3Vy
YXRpb24gUmVnaXN0ZXIgRXhwb3J0IEhlYWRlciBGaWxlPGJyPg0KJmd0OyArICo8YnI+DQomZ3Q7
ICsgKiBUaGlzIGZpbGUgcmVwcmVzZW50cyBhIHNlcmllcyBvZiBTa3l3b3JrcyBTaTUzMzItR00y
IFJldiBEPGJyPg0KJmd0OyArICogcmVnaXN0ZXIgd3JpdGVzIHRoYXQgY2FuIGJlIHBlcmZvcm1l
ZCB0byBsb2FkIGEgc2luZ2xlIGNvbmZpZ3VyYXRpb248YnI+DQomZ3Q7ICsgKiBvbiBhIGRldmlj
ZS4gSXQgd2FzIGNyZWF0ZWQgYnkgYSBTa3l3b3JrcyBDbG9ja0J1aWxkZXIgUHJvPGJyPg0KJmd0
OyArICogZXhwb3J0IHRvb2wuPGJyPg0KJmd0OyArICo8YnI+DQo8YnI+DQpUaGlzIGZpbGUgaXMg
bWlzc2luZyBhIFNQRFggdGFnLjxicj4NClBsZWFzZSBzZW5kIGEgZml4IG9yIHdlIHdpbGwgaGF2
ZSB0byByZXZlcnQgdGhpcyBjaGFuZ2UuPGJyPg0KPGJyPg0KVGhlIGZpbGVuYW1lIGFsc28gbG9v
a3Mgc3RyYW5nZSwgYXMgaXQgZG9lcyBub3QgZm9sbG93IHNvbWUga2luZCBvZjxicj4NCmltcGxp
Y2l0IGNvbnZlbnRpb24gKHdoZW4gSSBjb21wYXJlIHRvIG90aGVyIGZpbGVzIGluIHRoaXMgZHJp
dmVyKS48YnI+DQpDb3VsZCBpdCBiZSByZW5hbWVkPzxicj4NCjxicj4NCjxicj4NCi0tIDxicj4N
CkRhdmlkIE1hcmNoYW5kPC9zcGFuPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXpl
OjExLjBwdCI+PG86cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90
OyxzYW5zLXNlcmlmIj5IaSBEYXZpZCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVv
dDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPldlIHdpbGwgYWRkIHRoZSBTRFBYIHRvIHRoZSBj
dXJyZW50IGZpbGUuIFRoYW5rcyBmb3Igbm90aWNpbmcgaXQuPG86cD48L286cD48L3NwYW4+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpw
Pjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPlRoZSBj
bG9jayBwcm9maWxlcyBhcmUgbmFtZWQgYWNjb3JkaW5nIHRvIG91ciBpbnRlcm5hbCBkb2N1bWVu
dGF0aW9uIG9uIHRoZSBQQ0IgKGJvYXJkKSBkZXNpZ24gLSB0aGUgJnF1b3Q7VXh4JnF1b3Q7IGlz
IGFjdHVhbGx5IHRoZSBjb21wb25lbnQgbnVtYmVyIG9uIHRoZSBib2FyZCBkZXNpZ24gLSB0aGUg
dmVyc2lvbmluZw0KIGVuc3VyZXMgdGhhdCB3ZSBjYW4gc3VwcG9ydCBtdWx0aXBsZSB2ZXJzaW9u
cyBvZiB0aGUgY2xvY2sgcHJvZmlsZSBmb3IgZGlmZmVyZW50IFBDQiByZXZpc2lvbnMuDQo8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYi
PklzIGl0IHN1aXRhYmxlIGZvciB5b3UgdG8gY2hhbmdlIHRoZSBuYW1lIG9mIHRoZSBmaWxlIHRv
IGFsbCBsb3dlcmNhc2UgYW5kIHJlbW92ZSBkYXNoZXM6PG86cD48L286cD48L3NwYW4+PC9wPg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj5OVDQwMEQxM19VNjJfU2k1MzMy
LUdNMi1SZXZELTFfVjUtUmVnaXN0ZXJzLmggLS0tJmd0OyBudDQwMGQxM191NjJfc2k1MzMyX2dt
Ml9yZXZkXzFfdjVfcmVnaXN0ZXJzLmg8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVv
dDtDYWxpYnJpJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQt
ZmFtaWx5OiZxdW90O0NhbGlicmkmcXVvdDssc2Fucy1zZXJpZiI+QlIsPG86cD48L286cD48L3Nw
YW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4w
cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7Q2FsaWJyaSZxdW90OyxzYW5zLXNlcmlmIj5TZXJoaWk8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2
Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_VE1P190MB08301A245E9958C21C63D0FA80D52VE1P190MB0830EURP_--
