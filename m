Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572AF606A332
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=S3jMO5tr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BC41406B6;
	Mon,  9 Nov 2026 20:40:27 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id AACE14028F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 20:40:25 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HIvX13525685; Mon, 9 Nov 2026 11:40:24 -0800
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022134.outbound.protection.outlook.com [40.107.209.134])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hujfa8kt3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 11:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9oQEq5Y/B8NAROjUixcGX3snG4QgQgxeXbi/Dv3rqzxaGwlIAwIuoJ/n6OP3SUm1C/PvsJEOm3e5TFaPXAuZ1dxjhuYEc5mgZ3Dqrw0sx7JQk6a0MdvHZDQ75EJ301Wodvca0OKXWUqhCHRP90qoiHIPbW+G4IvA86R7K4rvJDQZNLtWOG1XgiNWtKpSqQ92DJgPljOpRhNGvz4A9/KqBjWGysbVNL8addUuIcRdxyOIHA95NO2WYMWUBCbfQA3ei2NRtyjoy97UJY8PeU+sKC4h3xC3mBDPxJ2FpqYSg38LSe9TlvnB7C1NYreHJcRHJYTUfdG7u77SAXl3GINqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Zm0G8oPrRWNUkl8R/hOQxbIUkGEffzU7lxAiLyI7Hs=;
 b=XrRlJGLbFnA3+c/lBAfP7yudZbjjapF4QMRsW71Wc7fyibLLOfcgjiyVaxei/gaYdLNmmVU1CgY3InKIFDbXZjJABr51DngZzY9sdJ94JP3ZT1uHgW7jGsLN8o6id5INxzjVVmgORt54BTLpmvHUYef5JyRPhY4GJ7Qgnlc+q+L/toJbnbqVE7a7rHlsG5aG0tmVs2B+b1PulQMXguxjhT25WU58Tm9B9XBa+5XubRyDEEjOpMXYTs2EBBeUGb5RzaLnzuAo74XuOmW7l3F9hq+DAKvo3t6+YU00rbouG8MC5MmFB9QlyGr8RpCxiM9/sDrZAMk/b7QhwNIEOi5a5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zm0G8oPrRWNUkl8R/hOQxbIUkGEffzU7lxAiLyI7Hs=;
 b=S3jMO5tr0sRQe2iMjqPKNzKwrj+BtiLaCEO/bfwtBey3x8vUl18mVBtOQs6vMam8XpKJkh+yfvbd+Pvx9C+erK3dP1OhGallxRSW08rntrIjxsMgWu6KMRheCnDNTUo+EXBcoHxU0BBmjDzd1ZJG/waLZ8b7tONmKzZiMCtBrhM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BL1PPF678EF7061.namprd18.prod.outlook.com (2603:10b6:20f:fc04::d9d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 19:40:12 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:40:12 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Thread-Topic: [PATCH v3 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Thread-Index: AQHdW/bcBDrNtZ3GF0WltwZrnHPzMbcmTDTg
Date: Mon, 9 Nov 2026 19:40:12 +0000
Message-ID: <CO6PR18MB448414C6A4B0AC0C2208677FD8732@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261012083506.754857-2-emma.finn@intel.com>
 <20261013093312.817235-1-emma.finn@intel.com>
 <LV2PR11MB604554ED03EC5E9FF1BAFB56819D2@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB604554ED03EC5E9FF1BAFB56819D2@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BL1PPF678EF7061:EE_
x-ms-office365-filtering-correlation-id: b0148dac-5505-4ef5-3fb5-08df3e99455e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|56012099006|261102123227099003|261026121527099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info: jnaBF46VbgpG70hIohYk2zTI3gnLQTB1y2Sbwudcfvo8JsHOR4Lx78EvlYii5eMSsF9MSYzth/kyLUpqRe0qtb+TLceV3XlarMhu9ZLNkctgRJSDkTPZ5/M4TqDKWXPIYBg7xgM/UIaZO/I6aGpQzUIOsuAHnIl/9oJiZFlA/B7cLPZLq3BfFKw1fz8HWJ17eUUYbntBpf8JeC7EzJBU1/8XzcGjLgMxkGKCe+HVcwxmEPjLXJMmKd7XUdLcxz20gN5PhV2aS43UYODe2YvGZtqULDlVJq1sfVAqaI+Kf87C0K3DuwuFwPqab4nUzplGRtWNlPdn2b0LPHm/6bk4650I2yDu+rl3jcSaEKVcZt4E/PH+guCvhKa632tIi6jjc4Wwpkm8IxL+rlPaDludUXxfJcgSqkn/B6AeboTCTSNgf6/ZO4njVmCIVXO2VTV86yv+HwF8ggXcv4SANfNP9zL0mlHXhWzsNNM7btiVlS0CH1rKf4+U8/i/lxVFUhQu6peELhJbQuJp8TyL5eJhHmGCmGxMcC+bVCsc5ZRM6A5PcAD2iJxhp6sB7FxQ5qRtpHQ3Scfw2FrJEUnRaF6xRBvJiz4iq0+LBSL/YvKZugNkO4jJZKSPiEvuXMuoGQdEXC2aPFBQLOEBSGkME++ifIqPbmiTJHE8QIIlwgufkLtaJEUFZuUFXIig5eKrO0lE2jOPG6Dx+54WWcxGPG3e1nkMFE74fH8yU+HE5raxFt4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006)(261102123227099003)(261026121527099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1R0NDdpV2hHWkx1bFpFWEw3V3NQVnBJcnFqWlpBS3lCODBiT2ZSWXJRbEFi?=
 =?utf-8?B?Qk1zcXBkczVlYk8wTzFGNEhKTTFyRlM0WndzNndkdFBSdUhYNUZHQ09hVlkv?=
 =?utf-8?B?UHRKc2UyU2NYbmsyRG1BU0piRzQ4a3VaVW5nakthRi8xN2lpbEFZZW81cDdz?=
 =?utf-8?B?N2dORThzUVNBNlZDSFFmaVF1WWdBcFNvRGFaNCt1R1RnakRHaEVqTlRPZDE1?=
 =?utf-8?B?NUdwNHBrODBjYnNlYUoxQWticjlZWjYweS9xcDdaU1o4WE9sTERUcGtRaUtl?=
 =?utf-8?B?S3FMRjkzSzc2Y0hwMjFRRGlxbVlrU1BrcmxqaWdHL2xMaGh5V1V0RW1EYkZC?=
 =?utf-8?B?OHRGWVhKNWZDUld3TUhpakU4TnUvS0kzeDRHTDZwQ3hYYzBvVGNtc0E4OFIw?=
 =?utf-8?B?NmozbE1vUWllUSsvRU93emFtWUVDa1ZZOGN0RkNuMWgxenM1UjllbDJidXJ6?=
 =?utf-8?B?ZHRreU9JeGhMVnV1Z3NBWWJZSjlvS25MWlkrcDdEQmQrZjFFU3NOMHllOXNq?=
 =?utf-8?B?TW14bllKLzhjcm0xVmsxdzhWQmw1eXlFMXQ4d2xmZ3FlQ0JXRnR3KzZ0b2Fs?=
 =?utf-8?B?NFFEcUYzalM2NWVyVWZaaVpaVEhzM3ZIdTVkSUVwaS9kRlRCYlIrbDVVUGhP?=
 =?utf-8?B?TG9RajFIazJXamQ3MThFOGFwVFp0ekdCb2hxVTMwRjc4S0thdUlDZTF4WWVr?=
 =?utf-8?B?Y2srMTFTTUJteG0vWG1aYVJHQkcrVW4yaFVLZkU3cjZHUVl1cVpOZm53L2Vt?=
 =?utf-8?B?L3BtMU1QU1NMeXFHR2gzWW9oaGErOXkwRlVUZEc1N3EyOUV1R0VPeVg3M2xR?=
 =?utf-8?B?YmZHQnprSzVCZXZCKzNOTFRNRHFtSFNaMWRFRTlKc2ZTS0t6QTBUalJjM0Ny?=
 =?utf-8?B?TTl5d0ZyWUtud1FQcUZqNUpDRm5MSFpCNTE4aysxQnFUU1JPV2oxcnE0NDlV?=
 =?utf-8?B?T3IrUG5kQ3Q1K3l1WXp0ditCRGZSMjlMekxqZWR5VFVpTU9JUlNXbjI5c3g2?=
 =?utf-8?B?RHNLeHdWZU1JUnJDL2NQNmF1U01nQmRmOXA0d1JYMmZYYjY4d21mSllBNjN6?=
 =?utf-8?B?Z015YnhOWmUzb1ZhR09BSkE3Wm4vWFVYV3YvZ0x5K2RVcnJYN0RrMHVaUWhN?=
 =?utf-8?B?V3cwWEZNWVhlVmM3U05XYjB5VUJ2dFpDU0RUU0puSTNSNkxDclhVaWFFUzQ3?=
 =?utf-8?B?ei9FM3ZMZFp6cHRoRXR3WFU5aUkzSVZDWmtlK056VDJ1OVVEY3pWZlRNUjVC?=
 =?utf-8?B?Qm1RYURFekwyWjF2Q1BUL0JjWVNXOGVacFlBcGRvZndRdGQyQ1djMTRNbzZ2?=
 =?utf-8?B?UXRmYWJMTzhXaE9TS2piaXU4QS9WbjAxRjRTR3AyenJyYnhNT0RqWldIZUpG?=
 =?utf-8?B?VnJRS3prUkJtQkh6VHl1VE9CaTY2U005elFIbkRmOVU3Qi9sZUJVSXVUVFg1?=
 =?utf-8?B?NzZtdGRRdlhFVVFFcy9mZThTd1BTTTcyaVh5U2h3eFhrZ2h3MFBIZU1yWWNO?=
 =?utf-8?B?YnFKOEpoK1FJL2FRM1ZDOHJZVU9HUUNWZy9Fd09JZHQwN2UyenRVbW5sZkNO?=
 =?utf-8?B?SHZCSU4rMFBkL3N1clFwUERZSmY3ZC9Ed05tVXBEN1QyQ2RrVnpYRXJzTzlG?=
 =?utf-8?B?b2hQOVRGVHVwTE5sUlBWZm1kcXJ3SUxYUFYraUZYK253dkc3U3BWbm92UC9s?=
 =?utf-8?B?V2ZpVlV1STR2ZUFKMEgvcHNjei9KbmRxcmw1bllOOVZnK25QQWJpRUJvNktF?=
 =?utf-8?B?SitsMXd5RURVbXljbkEzT3FWdG9JRG05WFdKVXFBYWszRWYwaG94L2ppWlR4?=
 =?utf-8?B?enhuekRzVjNnRHdVdGk4ZlZwc1dMbXBzZi9tZEJETExGVkZLRU5pUmQrZ2JS?=
 =?utf-8?B?Nk9KOGZRRHhHNU9nNDd4VWpRK0F3STB5OG9WK2tSeGxYSTR1czdoczl6SHlP?=
 =?utf-8?B?V0hnMHdIYTVlcTB4OS9yUmxxc0RBVkcwK0dJZ29zMUpJL0dqY3VpL1U2OExS?=
 =?utf-8?B?dFJ0VDFTNHRSa2ttSHdXMlpFYmllMTEwVG5NWjFpQlhtRkFKcXRIZElzMUdu?=
 =?utf-8?B?Mkc0aU9iQnZ4WC9vSm9pQ3lGeWExNVQ0ckhIYXhuZXlnRWw0RmZNVHEzdGI5?=
 =?utf-8?B?aGxPVWt6OXZMWm12OUUyQ3BxL3JuWXNOK0ZSTWNrN3ZLWmdHZ0hqVEdHSGcv?=
 =?utf-8?B?bGxLMno5QytISEg2c2FicmxHb1d0WkNwR25OaU9kK0NOTVRROWVnTm0rMTFJ?=
 =?utf-8?B?aEVPZ2wxZnUrUCtwUEU3dlVVVnVFc1ZPMDlTYnE0anZUUVRnd09pSnRVSE4x?=
 =?utf-8?Q?CpRhq4Wn/H+kd2EXn1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hwylr4wOmFxZ4Yw1shsRErbpDAhG/UqQImlikRw43NJ8XqnxblFaxT1RTd5U76Ya+z7CXfzJgL5bhgSepgolOlA24CkqqxjsFkLciNBHA0V+wnv4y1l6qj6FtrHoEGtb8jt/wpzQqGZTpeRWQYNLclxdGr9TzbXoeOBkncmukWSbIF0lxd+Wtv4SZ9G0tuEGsp77UX8Mwhh7I8v1kI0l+cNZ9SsRLrtFH5hZMRh8WiLERI6nCcjOfTCQSQEx9GMT9rtOPv4T8onlzssx43L3EWXXgg4ewR5OgaedIZtB2flvawKcezBioJAUydlZhtX6f1hnHeZ6vpLjyLVYHtGFtw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0148dac-5505-4ef5-3fb5-08df3e99455e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 19:40:12.4476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfcy2FhVmlyNrd8S6L4HZTtaksD4sL84OaoGoslDIPprp3VME0TXt5A5/rc/7g8U37iK+P0a0PynROSiwmpuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF678EF7061
X-Authority-Analysis: v=2.4 cv=Ce+dd7rl c=1 sm=1 tr=0 ts=6af221a7 cx=c_pps
 a=RSKkSjVyZ2Ta+HBtYZh2RQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=HaXPRbBelm8mc9k7bU4A:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: G8l_Xgv8oVdRbtSE1CiI22SU0rHF3vMs
X-Proofpoint-GUID: G8l_Xgv8oVdRbtSE1CiI22SU0rHF3vMs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX4/CZDtBDY/R/
 VL2ipViwuEBXd7yTJOJKJ0cQVU7tOUcOnSnDV8pTk68XxcOLdJbUJ0eTJVQ32FB+yQ61HBHHCwI
 NG8SLiE6z0kXO/8vOApvOf4G40XW+1s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX2FmfkZdxs7Qs
 YuqLlnzXNl+m3T4EbIC0j7C4SgSGHzqEszCnfNEQU4MBK/D1+Yesskf/GzSEQw8Dt7uiv5Yfy0Y
 l0KdLXQ+qhTr/mCt54+VG2M45rbydkMo/cpufKtcO/U9nHb0NIIBDrAuVNaQbTgKV0E78n7HDRc
 K8r5IcfOZkSQdwLdN9eRUq6vldBSm/PgjuMhINs9b4H7qNaEzFjqZdnEX9Ii4jeIJX8MHVc/oAg
 UZnYR2gisnB6l1mv3r4KQNgIs7Kec9ke5Rti6YWvPRPvr+FQg/jnsL9MIAdshw3RPzpu8CG/Fwj
 tAxWEC96kImz3I3rYBXM4aE93tqP3AXutWxF4oW5yNeVNLyoLqmaBwJ8K4DBX17kCl/mhBPQLbC
 rRVlbwgFlFLFCjsLUplkI2lGKspVbmWS4nmAzu2Np3IeJLOJmx2z6zfylZVhK/DGFOfIm6sYV+z
 0RroyiYKODvMtVp1HAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBTZXJpZXMtYWNrZWQtYnk6IEthaSBKaSA8a2FpLmppQGludGVsLmNvbT4NCj4gDQo+IEZyb206
IEVtbWEgRmlubiA8ZW1tYS5maW5uQGludGVsLmNvbT4NCj4gU2VudDogMTMgT2N0b2JlciAyMDI2
IDEwOjMzDQo+IENjOiBkZXZAZHBkay5vcmcgPGRldkBkcGRrLm9yZz47IEZpbm4sIEVtbWEgPGVt
bWEuZmlubkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MyAwLzJdIGNyeXB0by9pcHNl
Y19tYjogQWRkIFNIQTMgYW5kIFNIQUtFIHN1cHBvcnQNCj4gDQo+IEFkZCBTSEEzIGFuZCBTSEFL
RSBhdXRoZW50aWNhdGlvbiBzdXBwb3J0IHRvIHRoZSBBRVNOSV9NQiBQTUQgdXNpbmcNCj4gSVBz
ZWNNQiAzLjAuDQo+IA0KPiBFbW1hIEZpbm4gKDIpOg0KPiAgIGNyeXB0by9pcHNlY19tYjogQWRk
IFNIQTMgc3VwcG9ydC4NCj4gICBjcnlwdG8vaXBzZWNfbWI6IEFkZCBTSEFLRSBzdXBwb3J0Lg0K
PiANCj4gIGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9hZXNuaV9tYi5yc3QgICAgICAgICAgfCAgMTAg
Kw0KPiAgZG9jL2d1aWRlcy9jcnlwdG9kZXZzL2ZlYXR1cmVzL2Flc25pX21iLmluaSB8ICAxMCAr
DQo+ICBkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzExLnJzdCAgICAgIHwgICA2ICsN
Cj4gIGRyaXZlcnMvY3J5cHRvL2lwc2VjX21iL3BtZF9hZXNuaV9tYi5jICAgICAgfCAgMzggKysr
DQo+ICBkcml2ZXJzL2NyeXB0by9pcHNlY19tYi9wbWRfYWVzbmlfbWJfcHJpdi5oIHwgMjYwICsr
KysrKysrKysrKysrKysrKystDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDMxOCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPiANClNlcmllcyBhcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8N
ClRoYW5rcy4NCg==
