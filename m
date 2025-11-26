Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA87CD1038C
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 08:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D6540DCA;
	Wed, 26 Nov 2025 09:14:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0E98D40BA6
 for <dev@dpdk.org>; Wed, 26 Nov 2025 09:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764144858; x=1795680858;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q3AduXvE4pXTeyR4GWSWJm5/n/3oFoMj5cRxq5hlSXs=;
 b=NpzEKMbkws3sj0wfX++H+O/ojhlVYgfRBwLoNu1CrAGe8XRYxXdUNMcT
 s5jYHE8rLzZMWyaLeUjojcS7eljvZt0a42Mm0RszgRGJ/EOQIhe3qteGk
 E/PuwZHP3u5ZynJ89AUwcJIRcG1dIEmi94InBd6U72j4z3U7Sq4Qp/sql
 flCK1OCM8vem7Qtp3jmm4ANkJxnc/VjhRrMGGIHCfYULOspy0Ln/sEhYc
 PvdqNbrjM0ZtjijNG9gy/BFpzn4u4B6NUX4WCtlVRDPyw0yvC4QNPUpYl
 enStY4HJwJHFYj6+UIYiU8wENLPp696sOtKGnWwLVzREZlDOSzbXtodgT A==;
X-CSE-ConnectionGUID: OF4YCFWAROOBZ9FqV3sLcw==
X-CSE-MsgGUID: Mfj13m83TXeHoBC7Ab+26g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="65882018"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="65882018"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 00:14:17 -0800
X-CSE-ConnectionGUID: 2pSb6GzOT9ipbJYHq0SEnw==
X-CSE-MsgGUID: O1H4b5cwSwOa+PlaKYlB6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="192129891"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 00:14:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 00:14:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 00:14:16 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 00:14:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ex66Cc+zR2usMQ3/3/3a4Ht4qygD60cqpB1dnB1qhXSi6+XIveR88lE0hltNEw5H2lysJaR5iy8/mdsx4Hmej2ZGqRdw9OcDxoKx4UUwU+juFycueDGkfTi2sCpJsplnXRDqTxePGfP8DRaF04dRdXm8tCvR5YmUM+GJJocr9eXLzFGszDLi8MetrmX/kztnmprqQ7MBV1R5HH30f1PThmY633bcUku+g4YRrg2vTntj4n3eCJDgoM7ylnSVkvzXn0GWjFR4VBO006xXIcciyOxplNNYr5rEWYUW7bVdp4MTypXR8n9FpL4WWTx/Kx+maxeHzmUQBC0kjaFoHxsqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3AduXvE4pXTeyR4GWSWJm5/n/3oFoMj5cRxq5hlSXs=;
 b=q0ctnBJjE2DK+B7dlMl88g+btVPjHQj0edf14ICaZ6fpRLenMhzz+Oi1QVuRzmkdwlpHdfmNXaloT+3CraljgrDcNj3SfjxsASKk9L3hlJI7MzCUtQg6m3h1+JGDJicLYRmwRgoiU8G/IddgOxwQQrelZWHvS8pqzh4A5QSbgw2RMZJexSm3otRrQJ+ihxsJ7C6BDieP8ETR/LsceJQVkedMXQZ5bgxrHlwv3Dk7Kqna8TMJeP7e2CDF1jAt/C69mFOQntaNf0ziIlpmmG0iTrUAdT2tuPWGLXQpdmRRyP5xLu0zmsSa/CLASfpydV0WNvSNOvWDlzNHxwBvm/LdnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::806) by BY1PR11MB8031.namprd11.prod.outlook.com
 (2603:10b6:a03:529::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 08:14:09 +0000
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::6fef:19a1:45d0:d051]) by SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::6fef:19a1:45d0:d051%3]) with mapi id 15.20.9343.019; Wed, 26 Nov 2025
 08:14:09 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>
Subject: RE: DPDK release candidate 25.11-rc3
Thread-Topic: DPDK release candidate 25.11-rc3
Thread-Index: AQHcWRAoGtS3eDY1zUqoUmmyo/5WOrUEps5g
Date: Wed, 26 Nov 2025 08:14:09 +0000
Message-ID: <SJ5PPF04AA7285F4397A2FB0ED95244BF859FDEA@SJ5PPF04AA7285F.namprd11.prod.outlook.com>
References: <2831295.atdPhlSkOF@thomas>
In-Reply-To: <2831295.atdPhlSkOF@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF04AA7285F:EE_|BY1PR11MB8031:EE_
x-ms-office365-filtering-correlation-id: 70159f81-7488-4d23-3ec2-08de2cc3c6c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?THN0OGxLV1RhWkduTDBzZGRuZXVweWRSOTB5MmsycXlHRnJ5WlVWUWhxTWt1?=
 =?utf-8?B?b3BhQk9iZGw5SEVEM3JEbnplb1lhQ2FtZG4wS3kxYUZQemxGZFN3eWtIcnJO?=
 =?utf-8?B?Ny9rdVA4ajJrc250ak1vVk8wSitpWDZSMlRaOUlnc2M0OGFWaURUdTNLL3NX?=
 =?utf-8?B?OUYyMm0vSVlRdWVpNkxxVFpnTUpOK3JmM3lzVmt5VnhFWkhBUkc1bzlzbjhP?=
 =?utf-8?B?SSs5cWlZMFlrb1ZnazJBT2s2akczcmYwNFZjVERyN0NBdjgyd1BjOEgwNWE3?=
 =?utf-8?B?UHVPTDhxWVFLUFZaUTZkSDFvYUc3emZrZEZWbzZNcmovRFRJZmlicFphMTdE?=
 =?utf-8?B?eXUxa2tYVHVlUzdndjdHSXo4MUMxc3EycmZPSEt1cFB5MkIyREQ0R2hGT2tE?=
 =?utf-8?B?QkQ1c2RvQUVnSUJ5Slc3VWJZaFM1QWpZQ1J1c25jK0tOMEErTmQ5bnRjTVp1?=
 =?utf-8?B?R3VISUwxeWhmYk5RbWY5M1FCVWlkVldSazRCZHRJcUdkRGs3Y29SZkpkTkIx?=
 =?utf-8?B?ZzdwSVIxNWViK00wVFljUUEyZWlVeVViMnhMQnRkSmVsdTJRdDUwQ3ROU2dO?=
 =?utf-8?B?V2NmMFdGamQ2SGVYK0FyUFdlZWMyQ2U4S3M1Nll2TEkyNThid3RYSmhWdWhF?=
 =?utf-8?B?M3h3aGU2cEZUMk5vVEI3SjA4THVmTTNDeStEc0JXLzA3RnNtaWUxc2N4b1dk?=
 =?utf-8?B?NlZKclZFUFRibUNTcnl1WHFPamY2by8yUEh2eG4vWEQydTBvOVVpWTAwdXlI?=
 =?utf-8?B?bXRhU1d4OVUvbGNnUU9ubDgzbC9FRXlyQVhXZ0FkOEx1Z3JKU2hnMXVHcnNp?=
 =?utf-8?B?S1VWL1ozSklVYThUc0FKazZEWWpXOE5tbmFsUlB4RHhsVW0zM3Nvbk9yMWtI?=
 =?utf-8?B?ZVNGKytvUHRTSGtTK0Rob2hWU0NqdE1aQ3c2L2lITHJDKzFuUHlEUkQ3SG1i?=
 =?utf-8?B?QkdrWWNEWGdqRzFja2FBcDV1SWhWVVZmK2J0K2NQS2U2di84YmhQS3VrcXdv?=
 =?utf-8?B?dXh3azdYYXQvZmtFRSsrOGxIV2MzVWlTYi9yYnF6QmlmZ1NBS0E4a1RsWm9M?=
 =?utf-8?B?MzlEWVRsaUdKWEduR3oyL29RdGFoaGk5S1BjVFd1aWROUnVySE5JUDV2T3Fl?=
 =?utf-8?B?TDZZTDVvU29ESWhWbndyTk54ZDlLTEVwM0FmZFVrRE5XMXppL3p4N0VoWHg2?=
 =?utf-8?B?R3BsS2xTVko0SnJ6TDY0VldMZ043eGRYWU8xanFHZW9lamdudGE5b1QyZ0Vj?=
 =?utf-8?B?VjE4dlM1RzVDZ3ZIVFhkT3lCVlZrYUVFMEoyVVRLWjkvdWR2Rkt6ckorM3BM?=
 =?utf-8?B?RWhoWmp1SVB5WVhDUDg1YWUyUWNjSEdUa2JpZVQ4T2F4YTJUUURMcnBRMXdL?=
 =?utf-8?B?S0o1dmdSNTNVelRtdGZmdzRZNm8rd2xLclpGR0FWOStBTTRtQ1hzSVlDWXlL?=
 =?utf-8?B?dXl1azVWVmMyYTQwMG82aDNpdGxaU2k5aWFwWU5RQXNpM0JmYVp3eVRYUVl3?=
 =?utf-8?B?VTN5bWRJOW9FYklTYTIvVmFWSi8vblQ1WnVjZWFXcEY1M3FhZ3FwNXUwSHM4?=
 =?utf-8?B?YWlaVlZWMkR1M00vY3dQMys2TGxXbmFnaW5CMEJuZHRXcndzWU1pN3EwV1pY?=
 =?utf-8?B?MDB4TFFUM000dnpFNjB6SU54dVYrdEZrdXhSNG0vLzJUOHM5WldrcE4zYS9J?=
 =?utf-8?B?UTFEOEZuWDVvNmtpOTAydGNvM2lUNTQ3K2NvNmZ1S1VtaTBIR2pnamtWcHRJ?=
 =?utf-8?B?enp0NWxuRUxCQXd4cWI5OWlFWlJWWWNIa0R2bUdFZTFsRXVwSUtUTjA4Y2VK?=
 =?utf-8?B?ZlNMSytOUkdGVjdqUWdQUkhWdkVwdklaWG1Odi9tQmhPc1UrdC9CbU5rbW8v?=
 =?utf-8?B?RHlVanVEdEhnU255TTFqNVNyOXBoZDVscUV1eGMvUkNnTitaN0RzSGs4UDZx?=
 =?utf-8?B?UWJKcFVKQ200NDFTK1UvZzNXMG12VUhEVEUzaDFSeWQ2NjJLSllPV0o5dmF5?=
 =?utf-8?B?b1k2ejZKbkt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF04AA7285F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEdFb3ZrSFV3cXRvT2hCdVQvVDExMnZML08yK1ZDMFNvTCtwUWU2eVdNL0VQ?=
 =?utf-8?B?S2wvSFppa0M2M2F3MVdsT0FyVVJXUDlDNE1PUzJOTEl3Zm40Y2dIZUUyTVRn?=
 =?utf-8?B?cUJ2Z2Z3bmtvSHJpdlV1NStnYWRrc2wyVGllZ1RjK2plaHRUM3dTVU5MTWt3?=
 =?utf-8?B?bTgwcFRmenY4YTZ5YWlFL0tST1lxSXFSTVlsaGI3cnJzM3oxbFJ0MjgwRUVF?=
 =?utf-8?B?TlB6NElQRlYvL0p0SVpRMmZXWUl2Nkx3K09GektlKzZ4aWV2MGw5WnBUWi80?=
 =?utf-8?B?eStobWhPVlhLM2ZkbEx0VklnZ3VScThnWTNJajZEQ1RqYXZXMTFDUDdreFNJ?=
 =?utf-8?B?YitNNFNYYkx6R0pqcFRMM09vR1BsYzkweDhVTEx4OFlaMEtsUHhuR1RHR3Rh?=
 =?utf-8?B?UHNPTzFLcUEvOGczN3FnSmQyQ2cvTlloWm9wMzh2c1k1dndWYUV2cmQwalhl?=
 =?utf-8?B?d2JjaCs2ektkS1NWTUp3Szg5MkE2Y1lkVWtVRDhxbTlOVEhSaWpYa1pyU28y?=
 =?utf-8?B?ZXlHdlVaZm9NYXk0K0tjdTRuUEo3a0NiRXo4bDB4R3daSjIrUVQ3bzBkNzBR?=
 =?utf-8?B?anoyVTZEcmoyRlU1QVFRamVaNDVnbU1nZ045T2xPYWc1eUhmT1dJUGhXUEx6?=
 =?utf-8?B?TFB3U1pYbkFZZXFGVEF6bXhEYzVwOVlkQVNMemM0eWNYVTQ5ckJhUjd6Yy9r?=
 =?utf-8?B?U25rWGhvNHk0UzcwcWJDaUlRemR4SUVVbUE5SFI0c2xzd2dPMnIwbGlxQTBM?=
 =?utf-8?B?S0F2OFE3cVhLeVoyelVsSEhLcnZmT2hnVURuVE55UmRzSUJKVTE0b24zZ1F0?=
 =?utf-8?B?NDJHWjZXcDNENjNZTEJhNnBMT3NZclNKZmhNRVRMekRFZ1ZGZVdhUGt4TWxV?=
 =?utf-8?B?dzBTSmtkd1NTN2Rad1Z6SUxnaGNHUExsenJydEpySHV2aTJiTWV1K1BhZ2Fr?=
 =?utf-8?B?d0ZHWWJ4allBQ1FscDBGRTFXV2g2WXIxMW5sQ2pDZ1MzTmdMWjJuV2Z4OW8v?=
 =?utf-8?B?aEVNbzRjamQvZDBRWnMrYlBqSnRKWFduakFYVnJxRkk5WmV4LzBzMWpTa0FC?=
 =?utf-8?B?Uk9kV2UwckN3azMrTVJhQTV2N2trMUlQYUh6bHdZUG83cDR3bVF4YWt2dk9U?=
 =?utf-8?B?dU1CN0c4NFdLRDJUeTZMcVhyeDVjNGFzQVYxZGdQZDc4bFZSZW56Z0sza1Zo?=
 =?utf-8?B?QmVpemFhTnRGR2VHVTRYWS80bjNiWG8xTkpaL0N6TmdQbERLdFUza096amdH?=
 =?utf-8?B?VEg0NnZXVXVBbFZyWGJzeHlObk93WjR0eG5Xa2dSWWFYS1FpZnpiajJ4bnM3?=
 =?utf-8?B?VGtFY0JMdy9mcHU5UWU3K1oybmhWbVRyZlVhVTRZYllEL0xNZnExRTFBVzRM?=
 =?utf-8?B?VHZIUkRmQndMcm0rc3NYb0dWQzFDM2FZRUhYVjZCN2R6ejRQenA1ZWtWakwy?=
 =?utf-8?B?ZUdvMzZkaGZFNVRPQkh5R1oyRksxZWtRYW1vbDB3cytYNXFpMUZPem9vWUxx?=
 =?utf-8?B?Q2dqcDFTNEZFT0QvcUdVOGs0eWl1SnVQYUZ1VjRXS1hGVU9PWVZNclFkL3lB?=
 =?utf-8?B?YVFOTDk2a3dEYVBsMDFVdDJTV1F1NC95cEVGbEFZVHpJZ2ZFbDlUV2ZkNjRy?=
 =?utf-8?B?VDlNVFk5OURSUGtlTHl5VWF5bU1nNE83YzN2SnJwdUozcERBQ05aclVRclhL?=
 =?utf-8?B?Wk9ySy9IZnAzSDlEd0ZEVWZCVit1d2lqUFNadWVOT2xjeWFMZUNoQ3FwMVRG?=
 =?utf-8?B?SHBNRjZFSlhtSjhvWSt3RmZGNTZGUDQxT1o5ZkJhMHV4TnZKRFhkUjg2L0dt?=
 =?utf-8?B?Tm5sSjl6TC9jYnlRWm9QVWluYTkrd1RUMGZQaTFVREtWVDhTb1lkTDhsUHN2?=
 =?utf-8?B?S2hLSjNkRWdmZlEvYmNNenA1OEVKaERUVk9nRGU2azdUWjMrVGRyMlM2Y0dS?=
 =?utf-8?B?cWJ4OW1VWWltQ0Y4ZGxKOENWVDVxSm81WGZGa3ZzN1hWOS9LdGxPaVgwMTVL?=
 =?utf-8?B?bGZUNlpLZzErcTJOWE1aanV0ak1PSlhSa0dWdGVCZE1pOGNJZ3N2UzU0TnN2?=
 =?utf-8?B?RTBTNkZQcVBYMEFxZnhKNklaUnBNbU1RMlhTRVdsOVQzRCtrMGtoYmtST3N3?=
 =?utf-8?Q?iNZNMNJ3AI0nQtRM3bp3f7Xg4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF04AA7285F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70159f81-7488-4d23-3ec2-08de2cc3c6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 08:14:09.7683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MO8aGKmmcxKG3S3TmCya8cX5vFj3LZzpmF3Gq2qT3qM5Ij3weX9Vb2mXlKmiTyEyzpCJD10aQR0qb7U8O+XmEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
X-OriginatorOrg: intel.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTksIDIwMjUg
MTI6NTEgUE0NCj4gVG86IGFubm91bmNlQGRwZGsub3JnDQo+IFN1YmplY3Q6IERQREsgcmVsZWFz
ZSBjYW5kaWRhdGUgMjUuMTEtcmMzDQo+IA0KPiBBIG5ldyBEUERLIHJlbGVhc2UgY2FuZGlkYXRl
IGlzIHJlYWR5IGZvciB0ZXN0aW5nOg0KPiAJaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay90YWcv
P2lkPXYyNS4xMS1yYzMNCj4gDQo+IFRoZXJlIGFyZSA5OCBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNu
YXBzaG90Lg0KPiANCj4gUmVsZWFzZSBub3RlczoNCj4gCWh0dHBzOi8vZG9jLmRwZGsub3JnL2d1
aWRlcy9yZWxfbm90ZXMvcmVsZWFzZV8yNV8xMS5odG1sDQo+IA0KPiBQbGVhc2UgdGVzdCBhbmQg
cmVwb3J0IG5ldyBpc3N1ZXMgb24gaHR0cHM6Ly9idWdzLmRwZGsub3JnDQo+IA0KPiBUaGUgbmV4
dCByZWxlYXNlIGNhbmRpZGF0ZSAoLXJjNCkgaXMgcGxhbm5lZCBmb3IgTW9uZGF5IDI0Lg0KPiBQ
YXRjaGVzIGFuZCByZXZpZXdzIGZvciBleGFtcGxlcywgdG9vbGluZyBhbmQgZG9jdW1lbnRhdGlv
biBhcmUgd2VsY29tZS4NCj4gDQo+IFRoYW5rIHlvdSBldmVyeW9uZQ0KPiANClVwZGF0ZSB0aGUg
dGVzdCBzdGF0dXMgZm9yIEludGVsIHBhcnQuIGRwZGsyNS4xMS1yYzMgYWxsIHZhbGlkYXRpb24g
dGVzdCBkb25lLiBmb3VuZCBvbmUgbmV3IGlzc3VlLg0KDQpOZXcgaXNzdWU6DQogIDEuIGljZV9p
YXZmX3J4X3RpbWVzdGFtcDogdGVzdHBtZCBzdGFydCBwb3J0IGZhaWxlZCAgICAgICAgICAtPiBI
YXMgZml4IHBhdGNoDQoNCiogQnVpbGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQg
dGVzdCB3aXRoIGxhdGVzdCBHQ0MvQ2xhbmcgdmVyc2lvbiBvbiB0aGUgZm9sbG93aW5nIE9TKGFs
bCBwYXNzZWQpDQogIC0gVWJ1bnR1MjUuMDQvVWJ1bnR1MjQuMDQuMw0KICAtIFJIRUw5LjYvUkhF
TDEwDQogIC0gRmVkb3JhNDINCiAgLSBGcmVlQlNEMTQuMw0KICAtIFNVU0UxNS42DQogIC0gT3Bl
bkFub2xpczguMTANCiAgLSBPcGVuRXVsZXIyNC4wNC1TUDINCiAgLSBBenVyZUxpbnV4My4wDQoN
CiogRnVuY3Rpb24gdGVzdHM6IEFsbCB0ZXN0IGRvbmUgYW5kIGZvdW5kIG9uZSBpc3N1ZS4NCiAg
LSBJQ0UtKEU4MTAsIEU4MjUsIEU4MzAsIEUyMTAwKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5j
bHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFj
X2ZpbHRlci9WTEFOL1ZYTEFOL1JTUy9Td2l0Y2gvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cgRGly
ZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3JpcHRv
ciwgZXRjLg0KICAtIGk0MEUtKFhYVjcxMCwgWDcyMikgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGlu
Y2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21h
Y19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0gSVhHQkUtKEU2MTApIFBGL1ZGOiB0
ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2Zm
bG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuIA0KICAtIElHQy0oaTIyNikgUEY6
IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9j
aGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCiAgLSBJR0It
KGkzNTApIFBGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvUlRFX0ZMT1cvVFNPL0p1
bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMu
DQogIC0gSVBzZWM6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1ndy9pcHNl
YyBsaWJyYXJ5IGJhc2ljIHRlc3QgLSBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCiAgLSBWaXJ0
aW86IGJvdGggZnVuY3Rpb24gYW5kIHBlcmZvcm1hbmNlIHRlc3QgYXJlIGNvdmVyZWQuIFN1Y2gg
YXMgUFZQL1ZpcnRpb19sb29wYmFjay92aXJ0aW8tdXNlciBsb29wYmFjay92aXJ0aW8tbmV0IFZN
MlZNIHBlcmYgdGVzdGluZy9WTUFXQVJFIEVTWEkgOS4wLCBldGMuDQogIC0gQ3J5cHRvZGV2OiB0
ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQ3J5cHRvZGV2IEFQSSB0ZXN0aW5nL0NvbXByZXNzRGV2
IElTQS1ML1FBVC9aTElCIFBNRCBUZXN0aW5nL0ZJUFMsIGV0Yy4NCiAgLSBETEI6IHRlc3Qgc2Nl
bmFyaW9zIGluY2x1ZGluZyBETEIyLjAgYW5kIERMQjIuNQ0KICAtIE90aGVyOiB0ZXN0IHNjZW5h
cmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JETUEsIERTQQ0KDQoqIFBlcmZvcm1hbmNl
IHRlc3Q6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KICAtIFRob3VnaHB1dCBQZXJmb3JtYW5j
ZQ0KICAtIENyeXB0b2RldiBMYXRlbmN5DQogIC0gUEYvVkYgTklDIHNpbmdsZSBjb3JlDQogIC0g
WFhWNzEwL0U4MTAvRTIxMDAgTklDIFBlcmZvcm1hbmNlDQoNCg0KUmVnYXJkcywNClh1LCBIYWls
aW4NCg==
