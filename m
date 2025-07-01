Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C9C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 09:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D2C540647;
	Tue,  1 Jul 2025 11:15:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C5DC5400D7;
 Tue,  1 Jul 2025 11:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751361299; x=1782897299;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QDalnTqR4WNdUu/MMOcp0ItA4keUmY54v6EBoVcGq7E=;
 b=S6pOJEYdwblsz7Uye2Q3xhsMzzP8hZSGtQ1VPDwzQlkczAWDuHq6y5Zy
 dWnUkKf9ayfzEuGdagssqcEWM2NNqO98am9hwLH90DufkS4scHNQ16ryq
 HFtp96IrbUi0+BPlc1/gP4aGoHKwTeY5AuE8IyE3vNES91tRs+D3UMqhy
 NIGwe4hN5+LaVj9gnG7cKbG1A0plIISd1VdqQvwc0tIsqjBagwE78W7Wv
 p8UQj++7y7Cl6o+rLga9+C4ArfCCJJW1Mtob5niT1wOrsWfnJXgYPL68e
 QQc5SRlV8uEOYiBX/V6HKd+Cdcdj1chATWoc0oS67MP6rrIqcyxFp3ZMc Q==;
X-CSE-ConnectionGUID: bQO0DQANRse887R33tUA2g==
X-CSE-MsgGUID: li5n5StBTA+KUmUrMppnZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53723014"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="53723014"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 02:14:58 -0700
X-CSE-ConnectionGUID: ehYN/A3MRXGS5VSNw4RGdw==
X-CSE-MsgGUID: UJxgEictSyuwGhIhPO1iww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; d="scan'208";a="184646690"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 02:14:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 02:14:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 02:14:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 02:14:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0s8T5lxo96/j2C4AcpNVOk9ZLS8OSTKC/Qek5NLasuAn4Jff0+VqhhytyBlw+kglHdBVfI1CJINXvzfVVjRHg07omKlRQ44l0MnOQmGsO4w+kGSzGajAcIaOwrSUDDXUX7IgkVaOrhIFDQSc4AKjW0I2+xvevO7YCYd4rVMcu1JC82aHHJuBjuKUWfWpsoqoymij9uV7l36RIzFVLo081I1nUboN8AkRnq0g/V+ACgC6LjCW7kQTnzGjiCMxxir8z+QY6ZtN9+jZNtEAhATeDisZ/dKtZPtN8m3hWawlAvEWrRVS2xYUqVKkjmTIDFujP2kwiyut+XK3whAlC/iPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VM/yMnq5y8KUiFM21kyBtOeHWTMfflPm4UHmtYhVU2Q=;
 b=eka9I32JFuRYJXx6aFl/ytdpRdAw50CK7NEwAkRcMj276yhgGk5utwNoTb4oPQ5xC/46pVvUmR55ASqr8IcT7cq03+T1KvlZjdkw8W4QXM1ZW7WLdaA8xOouibfBAppjNIahJ3yH4cnpamrDkf7W14PIaKnrZueF0RYVr2juLrP/EmY9iU8lfqECrCMDsNeJGGDzSJblkbvDw3FbuUDfTs3yzh4eUpOGm0tZtC/bm55bmOmQBjwhkmcU+WKmCqR1dIdskyKoWKzqIuCdU9CGN6Z0wbiQUgB0ba973EwaCPjvYCEYQW2S85dklqrhBIAYEzaIQXkKg9WBT5ldfs7w3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8965.namprd11.prod.outlook.com (2603:10b6:208:582::16)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 09:14:14 +0000
Received: from IA3PR11MB8965.namprd11.prod.outlook.com
 ([fe80::d6ad:760c:6c44:f9bd]) by IA3PR11MB8965.namprd11.prod.outlook.com
 ([fe80::d6ad:760c:6c44:f9bd%4]) with mapi id 15.20.8835.027; Tue, 1 Jul 2025
 09:14:14 +0000
From: "Wang, YuanX" <yuanx.wang@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/ixgbe: fix sctp mask in flow director
Thread-Topic: [PATCH] net/ixgbe: fix sctp mask in flow director
Thread-Index: AQHb50J90ujsrrtxl0qyMyNTMz0DO7QbbzcAgAGR6UA=
Date: Tue, 1 Jul 2025 09:14:14 +0000
Message-ID: <IA3PR11MB8965098960F5EDA9715DEA898541A@IA3PR11MB8965.namprd11.prod.outlook.com>
References: <20250627085953.286939-1-yuanx.wang@intel.com>
 <aGJUmNRzQU7SARCl@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aGJUmNRzQU7SARCl@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8965:EE_|SN7PR11MB8026:EE_
x-ms-office365-filtering-correlation-id: e8a6fa81-67e5-4d89-a8bb-08ddb87fa60b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?skYcbzMrOMRdVK/8w00dH2Ll44+3zEU+0y8JORlovJdOzfdo8/C7xOmQgbd8?=
 =?us-ascii?Q?pJWHO072pEDAz0WVU6Aq20nnypKQ+5E8AU7Kkq6HloNRO54444t9X721WmuV?=
 =?us-ascii?Q?4PrFedzsGZqBlz0JaaguBqsUq9H0/hdwVEuql8msNY/U81XR0D+hqrZNSB+K?=
 =?us-ascii?Q?fH1pdlpo87Agn8M9/uGXRHq2LIX5wDeCKjcx9Fjd0VUtGxwlwQPDWkz92QiN?=
 =?us-ascii?Q?Ngm7u8sVaHo2mXGk1VXNIEScGHDlmtgYZhud+HAc483VZChZemh9r47rB3KJ?=
 =?us-ascii?Q?+LHf0fPkUiH+ExW2IZCwvHKZpmqkRzHAK1WaJATKBLP9RU61NKGawagvbaAt?=
 =?us-ascii?Q?r3vTJm1z1Iisc7btpksBvq0Fo+PC/yh5wNF1j1AX550AErPaIV7yE0b/uvYt?=
 =?us-ascii?Q?+TdPYIyKQ6hxNsmPB6FsBK/0+bzACI5gT4ZLBbmVpnty11OtwPp5dmXdLJgd?=
 =?us-ascii?Q?+2ginx28Ugo5JdPSEFMyoVdh5SjlI14ArDQyU85hdvu1v0CVyd8UwVssSu8P?=
 =?us-ascii?Q?5uN+sV0eYw+IIjXSr3jBiw9Wv0i/coHTFbu4qQkG24kCyYbvE7oT+m9I3A1M?=
 =?us-ascii?Q?LOR9QVL7RxDf0rBuzJpgbRwpc+Ulgg0a7ueY+ID7KlzsjTLnYaIhZOeyEKQb?=
 =?us-ascii?Q?aOHejJBsl7HpCgYrryxPXuJs/o/du/gF7FSs7yMm5+1Pf9JESpDNak4Ly2zS?=
 =?us-ascii?Q?dYNHtHqyu41HpH8ct0wxMWfPaaTtg90Qrt/CzbZpXD7f1cyMLkq7teTnAGXa?=
 =?us-ascii?Q?b7Y/LEGZ5as3ET6f39kFQUSFJAihmhiy+lYfkzSvcprouOrCV8KbqW53X6w0?=
 =?us-ascii?Q?13hbkAIVZa+8Heb6IKdvCl9MvXrIcNVFJatZA/MYG1Un4dNQPORhEATSTGa9?=
 =?us-ascii?Q?nXk9aJTTX9qqHC1jzjW9eBQW4vXGSIidsu+CqwY4jhtahFEMTQwFAPYFNmJa?=
 =?us-ascii?Q?TpCr44s+aHeQl5o5STcZpgSQL03LaZuXn03gvtoCKwviU8CA1Zu2SGkZt9HA?=
 =?us-ascii?Q?j5vx5rll1h7yTtkT1hb7E2YRy5Qgg9BTC/sg7NQLTdQE5AAABpBrUo4iTOap?=
 =?us-ascii?Q?49rn3dNfDUOyFAKugwjs9+H3L7o6fIsd9NKPVkf4nLIk1kqyM0XmUOmTS3vd?=
 =?us-ascii?Q?uYWbniaKMpjbf8TAnbb/6QT+8fykTcTrp/Fp5FTqqynqSS7SLEk3jw+JQcpR?=
 =?us-ascii?Q?kx8zI1vvi6pu0jUvdwtvvllTZ0NESsaq7UUIQG6Zd0gfeodECQndjw06ytez?=
 =?us-ascii?Q?2x8JErlrOmky1AVnOStSbC/ufGdqBobWUfWDZOYt2Q07WxTHNccDO6hUZPEf?=
 =?us-ascii?Q?XM/j/ebsCnkIsRK2zB3209bGhItseyMShoSXfw99Zz4PBHvqF1KC0wPI7F7K?=
 =?us-ascii?Q?vma57ETsSS2I+EukZ+/ov7m0OXpuj9pmAYLY+7b2A2doFEDxt31MafXQF59o?=
 =?us-ascii?Q?4elr5EH4yy4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8965.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OQBmBBn4FhxPmqxNQh2GZTHru6jge4OuJPd7VnOvbfqnCOZoEUtS32HFYhFX?=
 =?us-ascii?Q?8VKk2OtAP7TgEi8jmqQOs1Qsz6LuZ2xsCsq6ztijwC5eZCFJ3BZ/W1rxKqX3?=
 =?us-ascii?Q?YoP/9gc7yTJiFOFFMwLc1UenmlzSaNpSrp9G4sRmXKKxckX1jgGDuo2Xxoe/?=
 =?us-ascii?Q?BEx2E4/KwD4QQhgunZyN6i7elhR5FWuR2ls1QKM1WG5Uui8Zk0ObDSfZGoDC?=
 =?us-ascii?Q?UBRaSyjtvfIzo70XEa9DnlprNsIrPjR9WnBE1f27nmjfJASKxGh1wtG04/Py?=
 =?us-ascii?Q?kSYqJ8E9RI3oFK3i5QTERlHXe+sO7PqVdO87NOAixqoHcjaB5N9Zj5FMs/83?=
 =?us-ascii?Q?d1N0f1qlPzZm3EvmrY/S+xEqjUagKFavUERrhMJ63BiHpmaXYjfjUBreOjNN?=
 =?us-ascii?Q?NPHeEy4QnL3qZODnr8jYFanGJbIgYDQeQfS0d0TMo+38G+wY8x8LZGNuZSxL?=
 =?us-ascii?Q?gl4880gbCMC2DHSHUIKe5ie+aybpjJ1Rx7n91lLaQ5NmZ/2OawVR4hL9KW2v?=
 =?us-ascii?Q?fCue21+/0lkiRpgSZ4yKO05SDTuBGPBhRns1vtQ0w27+8N81PduIajWQTbzu?=
 =?us-ascii?Q?3Nk2NFRVqIg6s+aTYgHvVlkEqHukakhYtbEhXXDuAGqrpt7f6i4/vAJxHeyq?=
 =?us-ascii?Q?OjlIMxGxYW3b6R0EARqDDFWcs6g0J/k1D8d4ZfeTqcP08px5BofQwqHtviCa?=
 =?us-ascii?Q?osOh1Ff2cA8SKu1Vzx2T1VD8+s7hkwaGTdKEQ2INz3j6RTK9mafI0Bu58HG+?=
 =?us-ascii?Q?BsEVYtBdqTe4uP2Vpch1poaQfG5xQ3h54MuMbeFwWJijEBrKXaSXu9VnTkf0?=
 =?us-ascii?Q?TAUA5hCvx+dcnexNbjiNKAePwJM2xvhkx7MjEdLZKBlAQ/MtGRxUjUepc3IL?=
 =?us-ascii?Q?djKLqadWbykfYiGXcVDg+cO5LczKkQapk7DQIGlrQM8wZSKFzfTIPTIb3tal?=
 =?us-ascii?Q?CLK0vq0NnOIdMuf5fjt/E4RfREtQyc+Qim89EgxCyn0/wg7V0kICFb6D7hT6?=
 =?us-ascii?Q?ltGMcoZPNxNr1ZmHa377AS+FxSrEsFj6PwLvgpUlbEY7zMfibTDpTrrWJjG9?=
 =?us-ascii?Q?yDmSaWWz7WEfJGgTBS9Wu+Id4ZV48YpDJIkgf6mTlelNztKwDLRMNa2zl7cf?=
 =?us-ascii?Q?s4++4Ro+i2AA8yaufSTfJqf6ylTG+lAMdzr22C9+4WkIExoaf4hr1IqsGW0l?=
 =?us-ascii?Q?QESF52k1fC5k/TPQcdG/yZAzBTV7XOS4pam++62eAQHWCu3BpDtBgGZxsykH?=
 =?us-ascii?Q?kDTNhQNPA3d4/pX3zDtlPu+WVRtcI8fFiC6mCaveVmWQOvTYXY/+eU9Czmoz?=
 =?us-ascii?Q?p7kNsXm9SvtOcVVfLtFV2YKmIIBLQadkeBddt8SmAsOzomx6eOQl1rkZMQ20?=
 =?us-ascii?Q?ded6y+gasfl6z4txlrBLG+WchWrXaH5TXQVr8vSI083nlGy24u2O6PxV60nm?=
 =?us-ascii?Q?RvTvhwK+6jTAHyHmSOUvOMHBQRAQ66VZWoFqPi3+G/V78gxk7oVAlQNsqIL3?=
 =?us-ascii?Q?obxC9HebHR6urqBeqYUdntXm9G6UiqdS0g6mMWp/JUQbqg8CfFHLiEYEFFe5?=
 =?us-ascii?Q?/9bH+iAKQIlmvzFBJHbKvPjnOjPJ5JU0b+sdi2M/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a6fa81-67e5-4d89-a8bb-08ddb87fa60b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 09:14:14.2537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDa5GIX+TPE7DtstSakGDgyc4Ax28Y3yIsPDOu1fOyJTLPcMsIDsQH+oZ9tFNeGdvpOy59qqqJM7WcOjSuY9yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026
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

Hi Bruce,

This patch attempts to resolve the SCTP mismatching on 82599ES.
A sample flow rule is as follows:=20
flow create 0 ingress pattern eth / ipv4 dst is 245.194.135.241 src is 215.=
201.218.98 / sctp  / end actions drop /  end

NIC will pass the packet to host , however we expect the packet to be dropp=
ed.
The reason for this is that ixgbe_parse_fdir_filter_normal() does not chang=
e the SCTP mask, which has a default value of 0.=20
This causes HW to ignore L4 protocol type because the L4P register is set.
(The default value is set by the following patch, called patch_df.=20
 https://patches.dpdk.org/project/dpdk/patch/20250418074309.705337-1-yuanx.=
wang@intel.com/)

However, This patch seems to need to be discard due to another issue.
This scenario is based on patch_df and create 2 rules on 82599ES.
flow create 0 ingress pattern fuzzy thresh is 6 / ipv4 dst is 102.23.130.15=
4 src is 70.247.152.105  / end actions queue index 6 /  end
flow create 0 ingress pattern fuzzy thresh is 4 / ipv4 dst is 193.23.234.17=
 src is 59.247.66.16 / udp dst is 57827 src is 23877  / end actions queue i=
ndex 11 /  end

The second rule creation fails (ixgbe_flow.c line 3168) because the port ma=
sk is different from the first one. The first is 0x0 and the other is 0xfff=
f.
Because of this scenario, I think it would be better to retore the default =
value of port mask to 0xffff. Therefore, we should reconsider the patch_df =
solution.

If all mask are formatted as 0xffff, raw IP packet will not match on E610, =
I think it is not appropriate to use port masks as L4P condition. I am cons=
idering using IXGBE_ATR_L4TYPE_MASK.
if (info->mask.dst_port_mask =3D=3D 0 && info->mask.src_port_mask =3D=3D 0)=
=20
    fdirm |=3D IXGBE_FDIRM_L4P;

Do you have any suggestions?
=20
Thanks,
Yuan

> -----Original Message-----
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Monday, June 30, 2025 5:11 PM
> To: Wang, YuanX <yuanx.wang@intel.com>
> Cc: Burakov, Anatoly <anatoly.burakov@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; dev@dpdk.org; stable@dpdk.org
> Subject: Re: [PATCH] net/ixgbe: fix sctp mask in flow director
>=20
> On Fri, Jun 27, 2025 at 04:59:53PM +0800, Yuan Wang wrote:
> > Since the default value of the port mask is set to 0, the port mask
> > does not change in some cases when creating SCTP flow rules, which
> > results in incorrect L4P register configuration.
> >
> > This patch fixes this issue by setting the mask to 0xffff in these case=
s.
> >
> > Fixes: c81daae2383a (net/ixgbe: fix port mask default value in filter)
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
> > ---
> >  drivers/net/intel/ixgbe/ixgbe_flow.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c
> > b/drivers/net/intel/ixgbe/ixgbe_flow.c
> > index 6278646720..9f2e470ad9 100644
> > --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> > +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> > @@ -2161,6 +2161,8 @@ ixgbe_parse_fdir_filter_normal(struct
> rte_eth_dev *dev,
> >  					item, "Not supported by fdir filter");
> >  				return -rte_errno;
> >  			}
> > +			rule->mask.src_port_mask =3D 0xffff;
> > +			rule->mask.dst_port_mask =3D 0xffff;
> >  		}
> >
>=20
> Hi,
>=20
> can you give a quick example of how to demonstrate the issue here, so I c=
an
> test the patch? Presumably without this patch some packets are incorrectl=
y
> classified/filtered based on the rte_flow rules?
>=20
> Thanks,
> /Bruce
