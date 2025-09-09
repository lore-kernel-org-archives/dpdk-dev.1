Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD28CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 13:52:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ECB640281;
	Tue,  9 Sep 2025 15:52:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E44C04026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 15:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757425947; x=1788961947;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Fh3YyOGSKHZPZwIA/Ai6lB6F/H1s7SH25mwYhAKL3Tw=;
 b=iNRKN+G4hYo2ureYxvNxoNzSiBwxeSmQEba/zwiD8Bf/LgP+8wOrfRX9
 JUxIqXZ/9rFU9BJMMch0ZQWkq/gaD+QIKwYRkIOrmlIQT5GePKO07QEEC
 QTSvL1iOX9OjVqpfpxV+fr1KrvGlW3+973YdJfuyjBiQ00FIMmOX+BfLY
 IIAXew3bxp8P7kpj51U++OZmybNNu0V9BhUoxlePtq/x1cH3R9D40m5Ur
 AzXwLAFnXtuu989fs8uDV0gPCi2tu2KI6AoIhTI03bltr4huQFgvZcQT6
 WsA+WRGAzxqUZfAeEb3rIcUaLm5cqbITsEqgDujTzUmPF3b++yBMaym/z Q==;
X-CSE-ConnectionGUID: qdXb5VVIRlq41p4nr6kjbQ==
X-CSE-MsgGUID: fTa8+6nVRx2d76o489NbXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="63346749"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208,217";a="63346749"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 06:52:25 -0700
X-CSE-ConnectionGUID: rHJXnmXHSJynRESODYcTJA==
X-CSE-MsgGUID: t/2JeQnuTXyeegV8x2S9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
 d="scan'208,217";a="172682768"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 06:52:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 06:52:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 06:52:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.52)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 06:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxIbzZCRCmf2NDtb16SkUn5SDVclPObsfUiLrSisDo6inG1lXKLsJ+eAcR//PBG6+nzgS8y+lvaeWnCWrV5HhEyZjJ1+8hdWndE+lcJY6YPz+AzyWyJ8INbLUHZa3hEN7do8qsSQMMnttJ1UllCKhNhGU9xjMOp+FmiuqZ+t7fzf/RleW8Ls8hrCfpKeYoAVgvC/gomvT1hGUva67i6lkly6e64oYHTkDLez5jlL2RYZXwZMK4IrbQcnpIjhWn/bpCpOZGTvqjlexAbU1t/9BVFqYs/1dItcSvtJWlalUbZb3DPadflOIOqrHRQsfMXrTznY08P38jh+sd6AoTNI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REfL18W3A131gcg++hRgxrP8CVf/w/07DjJ8eoQrdac=;
 b=JtiZFGubNgW6zlKbnD64SHxDBJTpeESujDV+8uBGF2VKzobhlSZ037WI+t6joBAqTxwuRVPB7SwmbVhJbgFkdBypwO+/ykHJbIMN0QeNh5tOGxQqZDfpX51ax1UDA3nG/N+FEphMtxLe2B5cxGNBn4M+envYdPU0LJCWZHJxNch8QcaUhsa4cMAXHsH6r8Y0qRrAVHX8fCgmsMnXRAa2v7vGMvuS6Ohk9GAav2MotxhFUmQXQ0oTIM417Mc5zNt4zvfYLF4bOyb1i4ezzyTwKqBXiULlvZ+nWBvSZMAkNzH+B4RixWDaw755tzceEuJ8wUdj7l1fsa8B5U2W4Xl5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by MW6PR11MB8368.namprd11.prod.outlook.com
 (2603:10b6:303:246::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:52:21 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::3e5:a1de:4a96:d1b5%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:52:21 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-09-09
Thread-Topic: DPDK Release Status Meeting 2025-09-09
Thread-Index: AdwhkPBiTeyaa/sLT16QSJ553Qv3dw==
Date: Tue, 9 Sep 2025 13:52:20 +0000
Message-ID: <PH3PPF37F43E35D63FAEEDD064E90D7EDB4FC0FA@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|MW6PR11MB8368:EE_
x-ms-office365-filtering-correlation-id: ac19a77c-8986-4749-d6f7-08ddefa81912
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bCKiIkkknKu5Ae25zLC1zLtL0sq7wkaZ1QFjFd41MB3oM/cS+TWRV6OI/NRe?=
 =?us-ascii?Q?BpZbjhFQcYjMnmiw1gOZjYh3v1SFhDsxldUz2kSK+5jZIAdkH0dJBH5b56Bh?=
 =?us-ascii?Q?/RGRePiyk3tttiUMtlTo3vaILBDZivcqSpL7E1bCQjtOIrRdBt8BAhyoXV4V?=
 =?us-ascii?Q?M8F9r0J1tpQEoSfBsODqusrerH5a8tARwkYNXVxUC2z12dI5xfcgBDkZwUgv?=
 =?us-ascii?Q?EfzNGYQc63D50OdJprVUshIkwo7Dp9KRROl/U0mVh1Ch4NPIzCr3E3GPz7OW?=
 =?us-ascii?Q?hAnuomsV9LbeFwrAjsTCqoksKnM9H2+tT0iabmFf5gS/cKVgV1mVr39gnHLG?=
 =?us-ascii?Q?Gv0TnbvcVn/Ic8GaREWFrLWB9EpwyV9pTlbHNhnPNm2dPaSt/G110InIxB0X?=
 =?us-ascii?Q?DFNPuNZDWCHBMJZKO05yNiS5tM1YbbwWbEo7hi0qoHuFktoNMDuVbwUwfLva?=
 =?us-ascii?Q?JP4PSGC0rkEyTRH4F2h6/sOyVrx/yKvJwBTEh8SF8eBsuY5/q6C7R2fhPvzd?=
 =?us-ascii?Q?BeUB+26w8Jgc8iVa642A4/AbaJDPch/GpcWg42m1rh8X2Ndf77c9V68EUhxk?=
 =?us-ascii?Q?jI9taRzinhX7Q0Pt4dpwrViSKVE6EHIQjkk+0oEl9TigEM++NrqcnagDYIJ2?=
 =?us-ascii?Q?RLOQlmupc4NU4OmrfJerQad8JQkyHM6+VLBPj14Yx4IVDQH0eWJwjsRdqI9U?=
 =?us-ascii?Q?SZHtV+kv28faGLhvDerpu/eHNTsVP6z54Wl1Ta/RVd/uNkiaEIfn7Ag5lNxX?=
 =?us-ascii?Q?/dJ6jwlZkqeT2U4b2PavDdMA+/OE78wEjv6hTcZ1LVvrS/na4th+XWgNrRtM?=
 =?us-ascii?Q?6X7qh+WZfDsS4msoK8oIomSOXOcnzbkR14ZfwRqSIvhdKTRCxCNGoEHeUnz9?=
 =?us-ascii?Q?IJLeb4m7LStVXgA0AGSlElRKZjsDawkg8iCJduG/QVisUBoe5QOYa1HLHHgZ?=
 =?us-ascii?Q?Q9TM91WC2ElzuMxnbTH598VuWcgAwZs8wkPAzYLEUBkCSZNZj/O7A44qPI86?=
 =?us-ascii?Q?OzYmMUVHNK/Lpni2ZLxEMMAA/JpQieHimbKK2Mw+wfNKgRStqxo5XIplNZhG?=
 =?us-ascii?Q?AjAI39r3vtPVAx1UYe4WT9MzoXQJp3hXnTeJwi+wvBX+hgoudIY9lroVHnud?=
 =?us-ascii?Q?dWyo2BQgl4UHwTH/9Tkn3cyOnZ70a9aBJ1lA1/EkOklvGHikcHAzPFyIG11h?=
 =?us-ascii?Q?ZnGl2CnEllN05O0Lw/fg1heBMuze/ObZVQCfP32X8lwyFN/N4RagOX/uD+rE?=
 =?us-ascii?Q?QyyOcN5JmlgrOLU33IdBLzPx6EuE4sEM828IsCuF+ZbBu+O8yUzZq7O7Bv9M?=
 =?us-ascii?Q?dQG77Ka8jCPYkbm4MYPzV7nrNhdPjMoeZIpyow5kPgOCsJIUIJnwGDEeRFHk?=
 =?us-ascii?Q?AZ3HfE+GGpNqds2mOmccC4vQbSfQE9kEnxidI/MMzUUqvwQSMRuSDMeVpMjc?=
 =?us-ascii?Q?4vo3G5MnTZuMPgrETPZy037O/JW9hcFc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Y8aIj+hfu5NyN7klhiJTp4MKUQGXKL9xdElbUBgii1dwNc6/8I6DaORbrDQ?=
 =?us-ascii?Q?FctSwcRs3az5q8yof8NwXY4vMMgbpOFFe4/WaSxoSpGg+oHDKYQ10jLyAG4Q?=
 =?us-ascii?Q?gfs1MZbhozm/I7e2tsFgyB24tyoMGppEmA0LoaKEoVddg1ZC92s6qTKtzRmn?=
 =?us-ascii?Q?32e9SenuFaKtT1ygBR/4vcKnkdWgm1uiMhzt0GwxuW73xsDLoNmr4C7yk5sd?=
 =?us-ascii?Q?WfXtojlcDUJfGqo9/qx63v2gPNk4xkLGbzyMghcjghC1vBKuwansgPWdSZr5?=
 =?us-ascii?Q?pCM0fBcz1DmsUhNjmCX7SYsubgzMUCDbcTP/+mCcCkIk9rWTIvao8rpGJAL2?=
 =?us-ascii?Q?IySWgsxy++VVIv46JvF0WV1XRzRvK42d8wJc0PS/ZvqRsr6H1umMHlUyN1RX?=
 =?us-ascii?Q?+3N4E+F8VAWRftO6fdrOZGgpBCe6VcWuP8f10Ez5blLdpSEFTC+s0Np0md9Y?=
 =?us-ascii?Q?L2IkqWnV4T36fETRF48/Hzm8KujKUlrGPKgMLgtPcHtHRZIdWWO01s19vbhT?=
 =?us-ascii?Q?7JyWrJyS4O+d4U5uSXGJ0hwP7tLmFUbeV5F16DQ/k5eFDQav36+TtLlNZhR4?=
 =?us-ascii?Q?oGLx9quLU4iMxenBSAre9kczGJqSb5rP7HhgD5vG8/SEMH2lMnmnFZ7Mwzuh?=
 =?us-ascii?Q?prZB98AlKF+MaQPyahOKI9X1TvjCUjIWMkcT+XNSRCVMyVbIVYpGeVWcKof3?=
 =?us-ascii?Q?rxgZKoqHnWAwR6XCoe2pqC0sn/vxNXzJAa62k6dBwCE0dhnxiJcKIfwxG/4E?=
 =?us-ascii?Q?Bv0favZfCpvqwop50kkOFujiqFH4EqrAzVc3xzlGQKMLkrF5KBXxyUjBJtmo?=
 =?us-ascii?Q?Wh+6ZHpzGShvHEca2FB675tQ+P+9jOvCZOieGsvgmOlHFHXobjyh12znjWVU?=
 =?us-ascii?Q?vqWkCCmnOaiftvuGaPWFdxeVGET3MAAhEBl9yp1VSqVc70GKkEpw1qCAI17w?=
 =?us-ascii?Q?XV/a82oVBzjahNCAFblxHK0n/pm1MMZ39JiZQBzJZkFI5ek6dQDNBrRi0vUx?=
 =?us-ascii?Q?L+Ot5ZNoSTft7o9xIWrTupKC8rayEU3YxxyEnVsMCAa6M2Mz+t2Od5wLVPrk?=
 =?us-ascii?Q?LmGBvmYy5/fY1sdHZVzF70pj9azCpFG2+x8PnVT9HPVBjy/vAZyrGDU9MSi4?=
 =?us-ascii?Q?wUAgGndA7S3akJjeapn5rbRW8o6U9P4pRJ04iCpmyYnwD3GE7eT663qpr+dL?=
 =?us-ascii?Q?eD1Ql4vERnig5qNLD64b0pzwkWi77awvmKqwn7kb1RMu01KxNLo695Gaw8g3?=
 =?us-ascii?Q?XDmiBjaC+XxcBdvlUoGARB5vphNUM4baPifsCgZpyaEFys0xiK2OseYYRYnv?=
 =?us-ascii?Q?l+NFCYjUa789eEI3CvuPcswr6bvexGQiYfiga8GjE11M8tzC4QIsSizPKzk6?=
 =?us-ascii?Q?sGsyUn8NEYzXuVViFBIn0lpb2KhGjPHMtmp8YBK2OzAqXqpPuukYo3kO2E2C?=
 =?us-ascii?Q?TI++pVJEyl25NHdYNtn/ydBXDnSBpzse/YgZhmBMog0dYD8PSi7rPfH3AltV?=
 =?us-ascii?Q?56tc41e2wodNJajpkHpqDHvjfzKSL1pGHBVqZjawlIz3L71xmNbDG5Ld8YrG?=
 =?us-ascii?Q?oTh8rFuKcPl2dmvdIHeQxgPyuGAIs/1TUM9G/VPN?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D63FAEEDD064E90D7EDB4FC0FAPH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac19a77c-8986-4749-d6f7-08ddefa81912
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 13:52:21.0345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEg3dMpbBL6opjoIKYEpjks1rskBM4l5FVMh4Cd1TVowuWEbtk1dnEHt0NitaUWjsihejySb1OgbFeJFZj1/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8368
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

--_000_PH3PPF37F43E35D63FAEEDD064E90D7EDB4FC0FAPH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-09-09
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
* Release Dates
* Subtrees
* Roadmaps
* LTS
* Defects
* Opens

Participants:
* ARM
* Intel
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 6 October 2025
- PMD features freeze (-rc2): 27 October 2025
- Builtin applications features freeze (-rc3): 3 November 2025
- Release: 19 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Most patches in the current backlog merged to main.
  * Some other fix patches pending.
  * ~40 patches in queue.

* next-net-intel
  * 38 patches applied and awaiting pull to main.
    Hopefully today.
  * ~10 patches still under revision.

* next-net-mlx
  * All merged.
  * More in the backlog.

* next-net-mvl
  * 10 patches in the backlog for merge.

* next-eventdev
  * 10 patches in the backlog for merge.

* next-baseband
  * Very quiet.

* next-virtio
  * 1 series for SPDK.
  * New vhost-user functionality related to memory hot-plug.

* next-crypto
  * No update the week.

* next-dts
  * Some patches merged this week.
  * Some more in review.

* main
  * Merging trees to main.
  * API freeze planned for 6 October 2025


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.3 - Released 2025-08-19
* 23.11.5 - Released 2025-08-25
* 22.11.9 - Released 2025-08-19


See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 25.04 contains DPDK v24.11
  * Ubuntu 24.04 LTS contains DPDK v23.11
  * RHEL 8/9 contains DPDK 23.11

Defects
-------

* Bugzilla links, 'Bugs',  added for hosted projects
  * https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35D63FAEEDD064E90D7EDB4FC0FAPH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-09-09<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 6 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 27 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 3 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 19 N=
ovember 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Most p=
atches in the current backlog merged to main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some o=
ther fix patches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~40 pa=
tches in queue.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 38 pat=
ches applied and awaiting pull to main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; Hopefully today.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~10 pa=
tches still under revision.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * All me=
rged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * More i=
n the backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 10 pat=
ches in the backlog for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 10 pat=
ches in the backlog for merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Very q=
uiet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 1 seri=
es for SPDK.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * New vh=
ost-user functionality related to memory hot-plug.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate the week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches merged this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some m=
ore in review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Mergin=
g trees to main.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * API fr=
eeze planned for 6 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.3 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.5 - Rel=
eased 2025-08-25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.9 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Debian=
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35D63FAEEDD064E90D7EDB4FC0FAPH3PPF37F43E35D_--
