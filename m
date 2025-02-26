Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35AC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 11:56:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04F8A4029F;
	Wed, 26 Feb 2025 12:56:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2B4974026C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 12:56:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740571000; x=1772107000;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qMbTFjf2IoLQd6OE8YGZJm8mIUu398aheqF4hmTZKDo=;
 b=Ddv+Vx3Z9+xGUyXA5XcvrUVxqRWWKCAtMQzLvrlhResYRV2JKX8+hqpT
 qlsUM3M44BanXaxSWfPVQGXRCNHyS8JhQ5npb7TQD+hZlAiiw/8mC+/bq
 lUmsSEGco69sFVIkh91nWSiaO+ZGK00I+aS9U58uLvc2awBSPHY7MoTLG
 MDKwDDIv2XBXxPTYQfIXp4ekKXbeOZatmc50DE5jMP1XQyo6l63zQ/i2p
 u2ECavzeofwqsbtVhhYQXKr9v128sqqLWJnq+fWkelSmrYy8Z0SSlsox4
 F3vNKot51c3p+BSDoqeosEhMNA6CkO09snl2Mi7sNZzvyE6UjPFvqTlNF Q==;
X-CSE-ConnectionGUID: FVnuOQdWQQO7gc6BESK4dA==
X-CSE-MsgGUID: cIxHKC52ShSsn8lexkQKmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41288254"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="41288254"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 03:56:39 -0800
X-CSE-ConnectionGUID: TNJE6GVnTRih1ngTHePQKw==
X-CSE-MsgGUID: 19WWfNvTSIaqnBrakpakjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="121617630"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 03:56:39 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 03:56:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 03:56:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 03:56:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+0l0MpWhYwE0UTbCSzkp6jeZFNK+iSSUlXTqqo1RbSVdJFCFpIveL9YzcCQLA2Op0up+6qip/JuJTkKq83NAqEU0ktMT32fFsgh7i0L5OCOXslxhapjnqAUS8SpBgr7YBvuYFxmMZY+UuQ1aDqQiGe4U65EwxF+jJ5Jq0z2R/+nYkhrN0zQGKB8G1uj+0BZR7KQZ0TsuaI0Ou3pSesysx1X5v2HPYjLh05oH4W+9vSTnNQKcXieaytMOSpiv/M73NvYVBtbbvzMBeWrdv0VRbau4TYTh/nUZY+klxz8ZsJy6lvyHZgE+AOYMMfZgfAZzPpoUqM4UqYCZhZmx894oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMbTFjf2IoLQd6OE8YGZJm8mIUu398aheqF4hmTZKDo=;
 b=qbOuagSdpRIwD075fCIdakZdOB533i5i9Yiz+LeNI3a8gX+VUfrL4u2RcOcm1r9srHxici+S6oKNUl6RENQczAkyZOOjdE6AEpX4SrhCOoiCCHE/IHIPURKOek3a6YTpqHdJMCA17oR1wq+UjW7dVfRP6Fi3O4x6eBPn/DHt/d0lwWZhn6YIIg7nknmWp1muX78aC8mdHWxKsX17SvbtyZmyjCM38uXC4QoBqyozZNu7e35hOZVY7TPpnYY77/wqo8imHYhHOsx35jEYBqNM5Pefn4m/PwcWCFZSTTX/Hm/xT0YOcRj90ITEYjRWygWA1f+S9+1yw1vh1RBRQZsItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 11:56:36 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 11:56:36 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [PATCH v5 1/3] cryptodev: add SM4 GCM
Thread-Topic: [PATCH v5 1/3] cryptodev: add SM4 GCM
Thread-Index: AQHbht2QYCoYBDDmO06129+a9dX31LNZfTDQ
Date: Wed, 26 Feb 2025 11:56:36 +0000
Message-ID: <DM8PR11MB5591DEC64C11C78EA701A86D84C22@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250224165939.717714-1-brian.dooley@intel.com>
In-Reply-To: <20250224165939.717714-1-brian.dooley@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5591:EE_|SJ1PR11MB6083:EE_
x-ms-office365-filtering-correlation-id: b8dab044-899d-4b01-7dbb-08dd565c9f00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+45ylAaRb1CwvwsrgasdepbdMz204NEB5nnvZfd7oZTIiS1ZlMJnTJlOr0EO?=
 =?us-ascii?Q?T/M2YXuzyK6g/gHCs2Jf4d1MiowxxwrWwx6oKotsxyKSYQmY+KBIlpYvcdOX?=
 =?us-ascii?Q?3PIwghYmA+NCY/IIolkWdGEv/8exsPR6ZojVLLtX7AOQbRHp3PA5Au7AqnCP?=
 =?us-ascii?Q?XgTirf5kdr+LubkXirQoqP0yHpo/3d9fnghF1CxIQJ1q0vREpk8enXiH3Wo5?=
 =?us-ascii?Q?gpKR1VUf52ZntooUKSXq3xJmT1W8xW/Gob9tL5ASHL9yNOq8b0uJpIoQaC0h?=
 =?us-ascii?Q?tOBV0ZlZxgyIbtt6fYv0O56T4IbfqwbyIM9gUYKHVXQupAhD1DhY42vqsys6?=
 =?us-ascii?Q?uo8WjLajs7Tz0ndYQIymJ5oejytxd1sNV/UUbZUb10C04noamDGYa59PG68G?=
 =?us-ascii?Q?7wLJRBi8n91n2sMkwly7OGAhM+7+NdrDFfwUSIR5CaESc6UDw8rS1wD2wyQh?=
 =?us-ascii?Q?SGrhSjmabdw/zJ5GoYVtMqnn591yoD13pgF2C/vnpB1gtxnoEM9uJmk++oMI?=
 =?us-ascii?Q?UI5nXpuD2eE9lKuPeef3l9bWeQCDSCqjjI0xbuXK3F+zrbXtt7QuIaNwfa59?=
 =?us-ascii?Q?ZhVVqmZoz6N60ru3RENbB5iMHwMj74E3rrP/PUeP2pBRP0tNBO1gSMDLUgmb?=
 =?us-ascii?Q?OdfrDoDhcHDj/Mt69ak3dxIkCYm052Th9Ablz3wj8fRGURBEvy71Dcm30ToJ?=
 =?us-ascii?Q?18b/4oqdYDPPoASiitkhaTdhNWYlSko1vmtyXngRT76Ak2+hJVWg4EsoHFxX?=
 =?us-ascii?Q?sfbnelb0kSYwi0kBVskQab/CXooNlzcyIcX+j2gKkoLt8avwFWFs87mDQ5NR?=
 =?us-ascii?Q?YV33HhyMkCNUrxnQ2MobvW/DXl+vVaNjCzOSO95kyj6KgEdD01SJZ/jZFNlD?=
 =?us-ascii?Q?/4c6gCExZSDyv+zi15b/5nnHAHsZ0lVC4UDOv0K5RV8toFqyonStDGPHU2MW?=
 =?us-ascii?Q?EseCn9q1QA0cjEur8oz3QlxE8nRIPhb/+fBpV/oWtDAKfrnKCf+8ZkA5s+I/?=
 =?us-ascii?Q?dzloC8fB6ugi7VqvdRnp2hSu2tcbbGQxiNao4qVwlbCQLMqPsqA6RWZL54LA?=
 =?us-ascii?Q?luprAQu30jddVPRL5bWwj/8yQv7MfOz2T846afxbMd/JeNfn4McVm1TIsCZp?=
 =?us-ascii?Q?2GDStpm8vtGqOaGZl+oVhrNPon8Df3HjXq0UM3gYESU9dPskmaqXErbCs6Wd?=
 =?us-ascii?Q?/1NSIQ3u+cAjGKPjb61qElPiEpJ31tt5i7Bi586EuiTShky2uBGJGu4MZqEv?=
 =?us-ascii?Q?6ff7Qmbhtsaopo5g63VcKNNX7ejAXa5aYMHmFPJ75g9ycvyWy2kJq2otc5gf?=
 =?us-ascii?Q?gB6tv6hyItpl5VMTmW5IxR1GSkzAr6gJWxCUIU8MHgt/fGL3Pq3U2JZpKRe8?=
 =?us-ascii?Q?VDzE/yyrjoIc/vIHDbfvqsLXUv4vuqZdxfba4iuNXhnhKAZn957gj2FHJjmV?=
 =?us-ascii?Q?aaqPhCCRXa7TvBhBSuhHRcGQBm7UJhco?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5591.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+V3nfGlESSdX+hYVo2Q5WQrnGTN8l9JslWa4EiNXre+fk78UziD2NnjF6SOQ?=
 =?us-ascii?Q?VNQQ5JY+p8sGfq0ZJ/LaFQv3RRS+gZpZhhwTwYXDH4V0Z1S0MQ3XhGs19MOt?=
 =?us-ascii?Q?pF58mPNiyg3p2iF8Nnq8Y8/t0b0R/yvBke6gI3i3hLVuLBzc8JcXqLqKgqWQ?=
 =?us-ascii?Q?vpNXaXaSf1D9qt/BQKTKzOUxa3kd5tNYpdKw8p8hpO3PGYa9YfYtsF/6ASiD?=
 =?us-ascii?Q?LyYNlR6Ywb48ay4CBjniQIICOBErIij7sAlrd6OAkqH6zkJjl83/vE241q4n?=
 =?us-ascii?Q?EbMsHi1vacdVJTVPC32wSo9Onss7HuYmVGjnsUB7meAthqNd1TQSL0ceXISX?=
 =?us-ascii?Q?OM8YHVCVgjdA2iwjztq6JdQjP3BcvJNSvIDrpr9mhIcgBb2k78CJADeJU/Jn?=
 =?us-ascii?Q?nkAfUTcSLLH2EYKqqQhKc/RooVAVEuAPa1po5KPEQyuRxPZGgRrxO7Xa92Zh?=
 =?us-ascii?Q?Jt374O+7v1Sx5jxXiOiVoz7b/hPU1aMDT4FjIK2hsWj78d4wz8UzKX8FlYha?=
 =?us-ascii?Q?kzQxzhMM3DSJBoK06++L5wvm56fSwYKwhnP/o/LKU9zdtjkO2YDp2mzWUWl6?=
 =?us-ascii?Q?0a4qhbM3WANgRElSDAFShWY0u0A//793T31btTl9EXv38mHKhp+1hqMpd6r3?=
 =?us-ascii?Q?yzpys0M2FC/Xoiq1OAOmeezPNGV1liuRvpI6e6H9mbFG4dzHH4BWRdwbHLpv?=
 =?us-ascii?Q?vBg9+fpM+i8AAJm97r4mqcXKYHl2QhCB7zfJruh/hwWcuLmJ8WouGpC8mZs7?=
 =?us-ascii?Q?zxMEu+tXXd4UiPlzOMHI4hgZkhYOKY/b05QGXlmYj8o62pv6e9DoXgIRw/X5?=
 =?us-ascii?Q?xhWtBGgDSWs/Nr9YhMgPfPYcxqOkm+zxTQ9go24/rAoF/5zjAgaAG96vRi1d?=
 =?us-ascii?Q?+wStctYzSTED3rwEEaw8mUQ4vKsQkAWMIlbg1jBsp+r2zxD8pH51XV4XWHNf?=
 =?us-ascii?Q?kUFBvH8vb7W7iSBFYuxVqwWgJ39J7MtFMsZ3mijbBqeM9ThWGnWYV3wirDLp?=
 =?us-ascii?Q?nOfRMqfOlN4e6DsRCbzks1RGh7XJrOaItc+VsNSQe6/ri2exayI6jl4xBLim?=
 =?us-ascii?Q?vqDpsX7W1U/Od7bOhbkXg1MBvuHP/tAKrq6c1ZENBgwaYGik2CIwx547hk6J?=
 =?us-ascii?Q?U+bEj8uKjRrSmXleu75XemdF8/8N3aSPzAovJ4h/X+R/ixcRoJGHpgerdgcy?=
 =?us-ascii?Q?lZ/w9kke3SWyKyo4kM4zoZUVhDvw1qnkoGLSQerh1tHe+2Yq23nfqTbTF3Bg?=
 =?us-ascii?Q?lKVtWuln2UR/Su5N21WRRrPCmiX308YwXF2bBr7vsViP3DdNeM/7+KR0ohia?=
 =?us-ascii?Q?UJ2csplfyc+Cs4NaXxQXTdYe1xKqyDjFuo22D4Og+HzjIL6CBb+KhifJc9pq?=
 =?us-ascii?Q?N/KooQtSJWISxkXZZxMb7EfPJVoYQHHYOL1IdVG9ncxk6QaP0TmnqTo+lZHR?=
 =?us-ascii?Q?Q6E6HhaxxH3QmFJIMwY8X8WVSlNp7rBiNCwX9gONjLTdTInyt64FjmnVGJa+?=
 =?us-ascii?Q?MRbM06dR94tQlBcwlocAfeTUSU3feRfNeEhzqeFMCzEJgPtESge6KPGGW4io?=
 =?us-ascii?Q?GM61D0w3qU4jrXE3gZ4SfmdxSoN9ZNGPsbcUpw4Sv3zmAFwTSO5ve/bApd04?=
 =?us-ascii?Q?YwHoaUF8RLEuRj9ggyAmZlxGjUmAde9E8bxcx7m7ip7UIQCLZkrdnNH4LpSf?=
 =?us-ascii?Q?w+GDhA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dab044-899d-4b01-7dbb-08dd565c9f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 11:56:36.0564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzQE/gFPMYXg3htld58AuKq93Cx1AW+7t3OEi4f1pcuOG2BdD4lLyo/O3QTigHjPDorHMxILfXazZ+tnYLEdDwstiChgjRPdN061SWPC1ZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
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



> -----Original Message-----
> From: Dooley, Brian <brian.dooley@intel.com>
> Sent: Monday, February 24, 2025 6:00 PM
> To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>
> Cc: dev@dpdk.org; Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pablo
> <pablo.de.lara.guarch@intel.com>; Dooley, Brian <brian.dooley@intel.com>
> Subject: [PATCH v5 1/3] cryptodev: add SM4 GCM
>=20
> Added support for symmetric algorithm SM4 GCM in cryptodev.
>=20
> Signed-off-by: Brian Dooley <brian.dooley@intel.com>

Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
