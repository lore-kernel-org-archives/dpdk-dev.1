Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B973E94623
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:20:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE3C040611;
	Tue, 10 Feb 2026 00:20:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 59B7040611
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679218; x=1802215218;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NmCKSmeWKduLWRvU//zUrkVC6e28sR7DqakdM8pYxSs=;
 b=ChLAcpigQsyIgAn/Wzs3DUGLkbr57DKOOp6Jrh8i0yVraCj37QDofqWI
 xK3erFjukVl5WcexmYwr+wBrl/zJPhTkssdT4WZ7WUm8x4XLmYU0ePHvX
 0zbRAbA9/Vm0HCjM69Y8Ce3MsFeczsqQMz1/IfE8sTeDMne9dHvI+GZc7
 YnmWOxtc8/UFKFjc3W8VEnlJ4NnF68cj6YPF6M2pldy4nTQgt8c8eBnID
 ucmEIUiJmmFChFmjiA+1coGIHScTtfbZreQjX1H2ZGos0TnNzy2kc5qEC
 zEQLskXOkbpiHOQwB2J+ovq9XO0Xdbxwzj+7Jzi8QYiJbaBAoKkFXNV3M w==;
X-CSE-ConnectionGUID: vr9F7+6BTWC/QfUyMeP+IQ==
X-CSE-MsgGUID: mg35TuqWTgmLrlelplqHFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89382926"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89382926"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:20:17 -0800
X-CSE-ConnectionGUID: 3Q7MtJsYQW6ZAk8r8//FYQ==
X-CSE-MsgGUID: idc/RvoPQqqRdeEcLjUv0g==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:20:17 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:20:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:20:17 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:20:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw0m7Ek5R8geWZp0JRpk8NbVk+tYp2cyMdIbtDhKqccXEMrMpoGB9FRdFqzP7rqOC0L7jQ1n9CNBfJvNcHAL1lB5jozqIJfzD+39zcYVCr+cabjGqRbujcSj6CztWftUCJXv0MTNBlxVGrAvAjrGvyk24iRNb/Z/Kz7dGYATDYkVCtzspXA7nk3Bn6XW+ny4jmFhzec/nL0emN+Iatdk+pv6AXDJHUe1XdGrrGv9qQg+VWarVJYdoOvgTjg00snCvYst6neldmR0u2YdHqEABPwfaSCDsb2pxF1WR4uUkKqSZYcdEnwmgVLxawB41EDyoxJ4Vgpueo5og4w/rbWpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlW9NuORuv7dsGLVBraHnlT3dh6a6rxkNK0ciNCaZW8=;
 b=gQc6RPOOEsLyF00hs1yTaC/QPNAPAA7KrN15yxvlUVg+k3cUvbFkPrS6M3ySIOY74NdCW6OdD3kU7kS8n9VPaqEZeoQFpX0lpj0lQiVe0QKh3n9LTiFeUeIUacyc99COHnMHUYMbP1CGQ3QEvpLqFZqbfkdOy5uOjt/WQuOJZiKsC1PPrwd/RP/1B0O8WCCIeraECCk00Ix/tadR0Yd94PNA6sRbPHQjt7/FItSGT/Bax7bVxAAZyLMWKP6W6HpfPru2Agvb8NyyUvWANp2eU52qASP8LYAnL5eExwHxzlOBJ5Y1/aDX6LQcA2ib2DvJGmC96oWV+SISClW4Aq/m/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:20:15 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:20:15 +0000
Message-ID: <b17baeb7-be8c-4ca3-ae0d-f6ec16c79590@intel.com>
Date: Mon, 9 Feb 2026 23:20:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 35/35] net/idpf: enable simple Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-36-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-36-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0360.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::28) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b223a9-0711-46d7-3db9-08de6831c7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y016WFoyRFdWSWVySW05QStTeEozeGg2Vm96VTdTTXpTZk5Xb3NCSmJYSjRu?=
 =?utf-8?B?cmxsMXlkanhyR3NHbG40RjFjNHYwWkdmdDZ2T1F2aGpUeUVldFE5SHZpNE9x?=
 =?utf-8?B?ZFJGRzZkVDNSeWtlWHozS2daa28vV01YcHpCRFRiVVdKVDRHVkpXYjFPejE5?=
 =?utf-8?B?K2c3cDJiS1RVTVhiT2Q1MzhGZCtMNTJLVlIyMWQ5Qy9uMHVOZHpNVVZQVXNE?=
 =?utf-8?B?bkJlV0xFUFpVVTVweE45NXpVbTk5Q1V5WXVLMGFIS3FsSmhuVE9OSkMzT2h0?=
 =?utf-8?B?SFJqbWFRdVVwd2FvRm5RNEl2VVA1NHBmYVplSDVleHVveSt6bkhycWVPRkc5?=
 =?utf-8?B?aG00T0UzOTQ3WE94RUF2ODltTnNGZDFNbjVmdEV6cFZqNUwzODZaWjBrY3Bz?=
 =?utf-8?B?c0xReFVtSllBTXR0OHp5OWFJdlVyYkxuUkhWV25JLy9TWWR0QW0wc01rajNF?=
 =?utf-8?B?VHRCQk9BSXhxM09wVUU5ZG5ma0hZSVFLQUZzU2FNdGtYK3I3YzlDSmJpQTNI?=
 =?utf-8?B?eWRCM0tyak9FY3pnbjNJM2VGTnFEdGhQS25aMHNCNUZYSGdtaGJ5bEJBNWc5?=
 =?utf-8?B?bndmekFXdGNuSWNIdXlEbDVkbUgzNmNyZlFMODZWMXpURmZEMFRuY3ZIdXFm?=
 =?utf-8?B?QXlwOU9JVlk4RW52bXNsWGFOVDgrYjJ5dlRYbVQxZEhDNjhqSFRtZlpFcm9l?=
 =?utf-8?B?bElCQlpHRXludFdaNkg1VXNmcFFXN3kzbEE4MDdYcE5ZVzFYTXJYK1p4emVY?=
 =?utf-8?B?YTNOQTlWN3A3alJtcjVYNFhMY0RkY0tEVnFqMmZxQ2ZQMGRneEV6K2k5a0hy?=
 =?utf-8?B?Y1hpVzlaNU9vRk1ab2liMElLS2dRQlo2cU1ZcGhpSms1WUV6OHRHZFpRVGd3?=
 =?utf-8?B?Q3B5QXRMQTd6T1VWZThoV3cvU3RaUFppTHNpUk8rVVMzNHZSNENUd0c0TUlX?=
 =?utf-8?B?VkcwejZZWEtPcXdBVEozNWhWdWFTOFVldEY4aFEzU0VubVVjMDBjR0NGNXh2?=
 =?utf-8?B?K1E0YzlsdXI1azZJaDBjT3ZETkFvU20xY29EcTBCS05yKzRidUM5VEVUeXNS?=
 =?utf-8?B?V3A4SE13TlRXMW1UOThNYTBoUllVY1lpbG9BbDZBb1BVc2NoMTFKN3d1d2Ra?=
 =?utf-8?B?WGFRRllqTnl6QnhQR09oMDN1dmdnWWVqK0VkVG5BVk5ZSkJTTDEvdVlPWVZ6?=
 =?utf-8?B?algxbzdUVVdOZi83N3hSMjVDODZGNTRVblFRa2N1eG53RmlEUUsva3FJbzdN?=
 =?utf-8?B?MjAzM0MwUFBOUXZSVEJPNG05L2xHVXc5Z2JtaUpNQkhTUEMrRFpyaFJLV282?=
 =?utf-8?B?czZuZUFaYmNLZ3cvVGhOc0xJZ0FXWW5qdmFxNEkxQTNDV25uOWQrSVdpTlNp?=
 =?utf-8?B?ajhtNmFFT25ta3BqaVFsZ0kwdmcrSTU0U0lRWllTZUZBLzdoemRwcSsxT1dQ?=
 =?utf-8?B?N0dwYUgwU1JRd0pPSXVuS1JhdGU2MmEvRE0zUnk1Q2tiMWFyekpNOCtqOEZl?=
 =?utf-8?B?V21weFYxaTQxeEkrcWhZWDh0aExVZlBaa2cvd1BUQnBtVnJocldtZmRDNlQ4?=
 =?utf-8?B?QnRWaFpuOFR5Lzh4TGp0ODNnWUo0dk9QSnZhVDhHWThLUnE5cmcvamFRam9Z?=
 =?utf-8?B?QmtpazM2MG1GTHhMamhnSHZlT1duMkVlYXVQZUZYYlNXdzRNTnNSdzU5c3JF?=
 =?utf-8?B?TFJDbVRyZXhNSnhDeUNNcGVZZWNCM3MzYVlHREdpVnlsNXlUNjJWS09Pbmlq?=
 =?utf-8?B?NkxoQzM5TUl2R1F2ZzZORy9lRzFlU3Z4ak82S1NEZ0dNMjJLSDNWc1oxZlQ2?=
 =?utf-8?B?dkd0NUM3ZitsLzdQdzFwU2FFYjBUN2hnRXlPTVFiYXVGNHBBb2JVcUNwbGRa?=
 =?utf-8?B?MEVybXlKSmFoUm1nTVF4aHRrTXR5Ty9zbklHYmdDSFZkaUhiTUdxalBmQ3pB?=
 =?utf-8?B?V2dIOXVQeWU0M2lMRVZrSmZ6VDdlSERmNzRDcWVLUUs3aVhMYmhuazNyb2po?=
 =?utf-8?B?aFBza3dGQ1l1eHY1Wno5cERVSkpRRTFLSmFPMVBwSlA4WkJrY0R0K1BCbG9N?=
 =?utf-8?B?MlovelExVW1POFdhazl5d1hsNWh3ZGNlQTVuUHFNK1ozaHZDZFY2ODV5SXNO?=
 =?utf-8?Q?A2sk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZjeTdmU1NEWVlRMlR2V0hwOXl4YVdEK1BkMWlJc3ZVMVl0Ylh0VGN6ZmpT?=
 =?utf-8?B?eEJQcEwxVGpqT1BNcHI1K2xLdnZJVnFDL1ZrbmZ0RVZaOGRJSzIrTFVIdzFq?=
 =?utf-8?B?bE96RGw4R2NIdDlmaFJ3Q0Q0NXJZOU9QdGdvWTJUMC80bW51RXJVNDYvUllz?=
 =?utf-8?B?UThTM3plSUFFSFh5KzVGYjNESDBMZTdLcWpNSW1nTU5oUkYvaEJpdmZaWlM0?=
 =?utf-8?B?NnFJM0gzZTBXZURtY2FUbHQwakI0MXNuZnhnUnN5UFQzd3RJUFFpSktuT3Az?=
 =?utf-8?B?bU1CUFVTUHJWbUthRGFUZk1idDZTNkxhZFBiMUtDVm8xdGVod3k2aHpYaExY?=
 =?utf-8?B?QUtrVElqWVY4MnlKQ05qLzFaOWVna094UmdpMy9FUmN4YlZCUHdFa1dEZlQr?=
 =?utf-8?B?cjdUb3RjeW5qbE9OMTBLSE5UMnllKzFldS8yWVdsNmhSeGxldkpTVzNNeHI1?=
 =?utf-8?B?cGg2K3h0RVRBbStLQ0NUb09Bem1RTzFYQy9YbklyVG94R25qam9ic2pFYS9J?=
 =?utf-8?B?UzRXQkJoRCt1WHkvSWlFdnFGVENuSHMyQko1UjdBY3VPQ05YWVllMWZtcXV1?=
 =?utf-8?B?MldtMVgxRmx4enFBeGRBOWJoTWZHVHZrcnBEVXlxZ3BtQ1BPRHpWNHhpSU9R?=
 =?utf-8?B?VXVJVGtWd2dDRSs1VDFTWjVPcTNhT2diUGdTTlBUclRJaFpXK2ZSSTgwS3RS?=
 =?utf-8?B?RTRiSTFxL2JxYk04a1UyaXpheUZnenRHSStEd09LMUY4YUlZYm9WR1VCdEJa?=
 =?utf-8?B?QjhCOG9oUzZzbk5IRVpsZENWWHZqNVp3TCttUE45aXV4TUJUaXp1dmw1OU5i?=
 =?utf-8?B?MjBJemNBdk1qd05GdDVad015YW5weUhHd1hOTlVUU2JJOEhtVjFRZ3F2Z1lk?=
 =?utf-8?B?Z085Q1JrRnB2WGVTTmNiSDRydGNwYTZ2TW1iS1FqbFpBYzlScVRGL3A4S0hu?=
 =?utf-8?B?VEpSYnBrakxZSXBGSkRVUWtnVDlvOVo0YU5sU1ZvS2ZRbmVuRHR4UVo0dnFw?=
 =?utf-8?B?ODk2QkRMZGs5eGVYcVBtaVZORnpzQi9aRXJUaEh5OFlrT2lFenlaaXZURmZJ?=
 =?utf-8?B?SHZ4VFFUbDNnaldKUll5eUtnMmZLa3ZSMWtTL3VGV1YvQklSY3VrbnlnSXpU?=
 =?utf-8?B?bDgvU2dDeHkxWXNTL0NHRVhlYnBrcmhEVzZNR2lWYjhoLy9CRndmdk04YS9i?=
 =?utf-8?B?RGJNSnpuZkplNXFvS2dURUloN2tvbHJWWlpFekhUVHNOUzRpVWVMaTFWODJk?=
 =?utf-8?B?Uk1WNjlaMkx4WWNSbEdYbkJnNEpUTU5qNHBRcldUYVJaMXBweE52eUEzSDFt?=
 =?utf-8?B?VnpHVm1EQlkvVm5NY2pEeGxFd1FXYzFZM2Fha1Ywa29DVGtabis3QXpqYkhv?=
 =?utf-8?B?TE8vc2xpTThSZk0zb0Y4eVBWOEx1SEdvcDg2SHBpMmZYdWFxMU9rUXhvOGI0?=
 =?utf-8?B?MGxaYks2L1JEZ1hRaFRWNTB4YXZqN3I0Q0JPQ0FsZGFEeWhBRXoyZHFGS3p4?=
 =?utf-8?B?UEljT09pdHFKQXBxYnhTNVhIZVkzMUZLb1NkS29ZbkozejNhbDNKQ3VRNkZU?=
 =?utf-8?B?a0hpeWs0aUs5aUhlZ1RtbEZ4SDFuTFp6WDJ2MU9rWWZqWGhKdWkvU1Z3MDYv?=
 =?utf-8?B?OEhMVk1Cek1KQ1dJUExTSjJHdlhNcXo2cFBORk1peGlMRjU0aFhiOE1yb1JT?=
 =?utf-8?B?NlJIVUZpZUhXZmJoak81alhEMG1aUVlRY0VlZSsxRkl5a0I5Vm1kMnpmendD?=
 =?utf-8?B?cmUzaDZDTVlVZmVXalVyS1J5UGQ1VkRLUmEzNlRYM3pzWHpIWmZ2TEJ0WnJC?=
 =?utf-8?B?aUpZMEpmT0MyMHpLd1cyNTdLNmVDbDZxM0pyTHozeEhNUDVUZklUZWVTRkEv?=
 =?utf-8?B?TDlwWjlaUFRIRnVvYytOWnF4ZTlSTFo4cXl6endhSlhFeFRHQVdEalNOVWNk?=
 =?utf-8?B?cTRGeG9iYkJqS0FTVVF2Ui9aM2dncWp3WlFieFhiWlFsdnREVXo1YWRQbkhS?=
 =?utf-8?B?TGVUN0YrRnU3bTlsYjdNK3diWUZ4NTJaelNzTzkxSUFNU0ZxWFQ4YkMwY2o2?=
 =?utf-8?B?aWdhUk14Q2ZncUIyUi9oM2UxM05GYVlvTWdNL05KQlJsZXo1UHJsZS9sUDN0?=
 =?utf-8?B?THdMMllJaGlqcURwRGg5dWxDb3lCazY4clowMm9KTWxudXMrb2pLUThCZTJX?=
 =?utf-8?B?REJMOHlEUFJoZjZEREdqLzl4bE9FR1AwV0JmVDlpL1FhVGMzUmVkK3hWUGcr?=
 =?utf-8?B?cUprZWZTTUd2TjFWRU13MXZDYkNSZUdYc1IvS2wraVY4bGlyUGN2RmtoT2VS?=
 =?utf-8?B?b29VNXR5OGhvRFNzLzNhS0d3NW1sUGJhemEyTlByaklET2FOejZIOWg4UlB4?=
 =?utf-8?Q?kSDwWUaxxUQnP6Do=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b223a9-0711-46d7-3db9-08de6831c7e0
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:20:15.1547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXTOemYSfIBJaMEQ+9RDvjFHjmBHLspE4qc3m33VYdfNm55GoX6V8HHp9p32aknwwYZzCJ9BOfUzKpYrj8/k6FvsvQTiG9wfrJ3RqWakooM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
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


On 2/9/2026 4:45 PM, Bruce Richardson wrote:
> The common "simple Tx" function - in some ways a scalar version of the
> vector Tx functions - can be used by the idpf driver as well as i40e and
> ice, so add support for it to the driver.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/idpf/idpf_common_device.h |  2 ++
>   drivers/net/intel/idpf/idpf_common_rxtx.c   | 19 +++++++++++++++
>   drivers/net/intel/idpf/idpf_common_rxtx.h   |  3 +++
>   drivers/net/intel/idpf/idpf_rxtx.c          | 26 ++++++++++++++++++++-
>   4 files changed, 49 insertions(+), 1 deletion(-)
<snip>
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
> index 9420200f6d..f2e202d57d 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -509,6 +509,22 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>   	txq->q_set = true;
>   	dev->data->tx_queues[queue_idx] = txq;
>   
> +	/* Set tx_simple_allowed flag based on queue configuration.
> +	 * For queue 0: explicitly set the flag based on its configuration.
> +	 * For other queues: only set to false if this queue cannot use simple_tx.
> +	 */
> +	if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT)
> +		goto out;
> +
> +	/* for first queue, default to true, disable later if any queue can't meet conditions */
There are no restrictions in which queue order user may call 
rte_eth_tx_queue_setup(). If user called queue_setup() for queue #1 w/o 
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE, and then for queue #0 with 
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE, there could be inconsistencies.
> +	if (queue_idx == 0)
> +		adapter->tx_simple_allowed = true;
> +
> +	if ((txq->offloads != (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)) ||
> +			txq->tx_rs_thresh < IDPF_VPMD_TX_MAX_BURST)
> +		adapter->tx_simple_allowed = false;
> +
> +out:
>   	return 0;
>   
>   err_complq_setup:
<snip>
>   
>   	/* The primary process selects the tx path for all processes. */

-- 
Regards,
Vladimir

