Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD956CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 14:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1D28402BC;
	Wed,  3 Jun 2026 16:22:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 26497402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 16:22:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780496528; x=1812032528;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uHsU2pKyWIUPC2JyAUsb9wXf4CvhINl1AHF3VKQtxY0=;
 b=MgRx92kBrb6eiI224CGtrGoV0msDZqaqX5Xdn4Vt6heErmsl+qWx6x8V
 4n7T8P2AykR1z9OpoI7S6jti7ndot1k5LOn5jMZg7Dwd/LInXarD0GYIr
 Fmtf+yHKoLV2AmCDnL18m1rJhDjPfmvOwv9yQmTnj1PsV1BDDCMkFCSYn
 4SlvZ0uPi40jksYIPlz1IKkEGS2thnOmUzDaNwBSd1I9xFGHdZg586Qr1
 2Y/RCx/Xl2xbjbzBQvSx1boTeP63SE/eiAwzjW04ufqY0GiNiajINmtyV
 bdV9qDtuCP8JIUoY2aQmGBr5KvSWgsuyU37mHVvsBbkmzq2llf3gSiTVe Q==;
X-CSE-ConnectionGUID: nMAPmmg/QYa23CzLzvyeeQ==
X-CSE-MsgGUID: /sVKHps2QgyofCLy5kUIaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80342804"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="80342804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 07:22:07 -0700
X-CSE-ConnectionGUID: 83t/qvBaRGasNkLZNR8MLg==
X-CSE-MsgGUID: 76wiVpbATaeoBruZHAEp3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="243192922"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 07:22:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:22:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:22:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz4SQnq3uYSLAhErBq1h775XVwRDSAZO26rN0bgWfaTY5/BobnyEvycI3YnnO7B6ZFO7b6wraEcytT4sLIKI0Iio8xQ3ovhQtoNZhpSqRnxHbDZ55+hNPQS3165wb6l9qEL3X73/xH6nrgW6m5q8bFyfOXWlobY3sJGDly0mdSk3UHRmuIf8HcrxkOF7mOb5i1CbiteDfXSwJDeQXJZJf3bE/Vm8BhSig0nvY6uucHl5dN79Htdie8EfQisKvmJ9FQ77KXb6q2afvZnqYttQbeE4efD+BrR7vd7vpuJOdI55xd8s0TbxM99QisAXkM0H4flRfN87XjtCYmcbIMD7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDueC/SpOn0DTzd9vSnf/lnGd80BrQWE96l9CFvfPWg=;
 b=sZeE5itrchC7OiEl8cykKregf4MPlY+EXAPSJy5KRqSi2wOtlx6Ca0+BTFV3S+FVMalPjMzTuWE5ViZvFdO9TM4eSyqDOCar1mm8hKmffqZaJ1LP8DU/x7FO0u09H5xq93segxUtRvfIC7RdrDQLvaQRo59CDXJ9bFu17CpT43DfTMqLou5FUB3WPpvLpKwNGtsmFkJLsdiPnjGl2IX7PBuWM2aBJl2T+ZLDbBrUgAcs0EsgS7alH4UaO30ITyaSz2fNWLA1y/ndb37gElgIdENQBISGDD8U1P+AigNldXO+aa3SD6XloWGIq+5r+zWKouDuHTgyvg/dnV1vsLTsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:21:59 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 14:21:58 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "mb@smartsharesystems.com" <mb@smartsharesystems.com>
Subject: RE: [PATCH v4 1/2] net/intel: write mbuf for last Tx desc of segment
Thread-Topic: [PATCH v4 1/2] net/intel: write mbuf for last Tx desc of segment
Thread-Index: AQHc8qbbmNmH45B29Eypa5AtREjtxrYs35HA
Date: Wed, 3 Jun 2026 14:21:58 +0000
Message-ID: <IA4PR11MB92781BE2C2A76F38278DF5418E132@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260602154513.1079865-1-bruce.richardson@intel.com>
 <20260602154513.1079865-2-bruce.richardson@intel.com>
In-Reply-To: <20260602154513.1079865-2-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA0PR11MB4574:EE_
x-ms-office365-filtering-correlation-id: dffde731-af7f-4140-eef4-08dec17b78da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: gvUc7ohtfzjR7KL7psQmq4klYfO46/jOKAwXJ5Q7rf5NE01Rz+lGUm0PUk8MCATj35xx+goHvKDZSSjhVUKfVX7MlM3lziwW2aMJt42F+nvNmRk3Hh+BJ72UzIov6EQIbea3bPKqwUP4yqA6fsynTxT6Iknn8nC7KFyNZH6tVcbJjpdpjeVDjY9RjagX6+ki2a3vmx/pS8bObb5O7/2bmfOlVmZO4X579DM5fS0Soiflq8SQs2EyE5pvoi3NWvgqQygJJe1ZiLUkWohBSJ0DDPBWILnjdNpcFDROhlGJjzTeRPFmIyb/2/9PMSoyS7q7x+c213GLrUMiWilHOkTd/iX2NwXCkTvcf3H3FAZGuzKKVyuLWxXu1BHdIWT6Is3BH+F80ul7GVPtQxmgFciObjuE9sGdikg9k2BGwn3SXX/y2hlAg6iiuoXVBEea9Q1mvA1YvlzEHgvHcMlJy7tOIS/BF7cwQxjLf596uqITluSddNyENQQhCbmabQLp25D5rrWvCEi+6jbFsIoztro4KGUPonSOWxaTAx6p+mMsojbC8CqPQnGPYluqnGCPN+f4k9jZ1gCGbtWuo+m0qbdRCbbeZmyTufmGpPc4sojME56X5qkHeMXGEoAbXW0Rzk7BO1dqSJQK/8ehkxDALPe6wuGbwIJYs+uWmGB98fzEhLxx8bX6bFsmbe1qhII1k/ZQ0G/MuJZNPEzNPpIDeLDdX9EsuUHwZVP0qV/gYbYgjQKzijAJILSxUBrRsgOO21zv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ltZLJZwOOW7PjmejiGADMSt8nlaO1OBW7/bLnTbBKTWwfqLKuW28OIvzbEXm?=
 =?us-ascii?Q?nij0LnL4UFbyliY0UrPw+gaYJnI/rawx1c7y5Q4jTqiwBzszQPIHVi1Mv49s?=
 =?us-ascii?Q?vxlatFAtxMR9LPHVUP1C9kMZZ8EfqeLsy8I+Ak3OfWTuGxbEruMa/7rL8BTJ?=
 =?us-ascii?Q?OKzJ5eovbbBYTNE9RUD+AIKJbxuSPrXP03/GlQ6PZ4Kge1SZY1ezWc82uTsO?=
 =?us-ascii?Q?mwFujIlAtCpQejqYi1q2ozsu5WVbZ6wJVCt7hJaDUSXX2/S9HBWHlITNjmPM?=
 =?us-ascii?Q?Lbnj62y7sFKboUv8NklJHf2pHxNgIz7q5nUc/Yg0Yk76KKRnjkwwZV+G43rf?=
 =?us-ascii?Q?qvYQegSjMjEvT6UcLoPXKuxPwU1kPdYboMseGsBywjITJK/VJVp8Dpzl4BzW?=
 =?us-ascii?Q?/Umw2a6QM7LDCrjNlGiMAJfthEE4UIJMieqgYdtpyMW0iR/vhblY7WU/w38U?=
 =?us-ascii?Q?p8ZVQq3icYt0u/002/EKOLfesHsUCSY473B1IMwYiB3w96/oA27wKJ2tWB2V?=
 =?us-ascii?Q?h3Sljfa1cLe4joUfzwZ3Y0zvktcWYwYM0qlE38Y2RWLaN65tM9xywOxeLgSA?=
 =?us-ascii?Q?renKBzpqs+eEB2jbFe1boxxQwuqQvOLBktVbn/VL5WNNPOQZHCksBrqtrioB?=
 =?us-ascii?Q?ZPsds9mIS0IxZnegb+gc6uObJJuw7GuNYUBy1c1+a8GnH0aYfR+xJtUMXELo?=
 =?us-ascii?Q?ZsegvLMeeTm7xLHIKvVSU7cplQuVz94DuS7tp/Yhs3ZbeyzM1uWcSXujY2ne?=
 =?us-ascii?Q?PzAefyFuBGwGmsw00x4r7dWdImR1b06JEgd3iVZsho8VesBt4vZiyksgh6yk?=
 =?us-ascii?Q?xRJp+NzkFEyrAIqJKNn+cTqQ66LjOudEsnzwmlR74xJasFRSjmCW6r2EW+2i?=
 =?us-ascii?Q?8+mCJKDka5HNg4M0syKXvw1bR7a7VMh18ut37DBM+BucQ519/tPBBqYXLW9P?=
 =?us-ascii?Q?GsE6GQnXuYiw7nTxGrh88Z5v6SYKakpXPx1VPqmdfLd3vzDZLKIlpbu1vNJr?=
 =?us-ascii?Q?wPgTMbP1GGp/u9/o6RSQ1wktdC6Yid5+2rnTmLnN24nbfk+0aIwC09jyNC9Z?=
 =?us-ascii?Q?oHCu13zmV9QWRQjEM0WvfEZmXNDwacAvNPRh5D5tJXwAOIKrhTjgs16KnO2T?=
 =?us-ascii?Q?qxnPynBUDuZ5DWuk73x1SD3ODIW8JYOEkn2VvJAeGBPoEnX8b9cfjTUlZSGs?=
 =?us-ascii?Q?1C2PesBbNkBTUdC0J7xuH7sS9Vo5v6zp2y0vi6tenEeeTjUT7jKnAG7QIkUu?=
 =?us-ascii?Q?CnHKj5wxeWbjpLd15obiv5RfQT6ZnPmxNNaGAqpw3/tXM+DOyNjskdjSMm49?=
 =?us-ascii?Q?Y2owqUXXRpCypgnvkUnlGMhIClVHfjLewWREc/bblL/xToHrLnpDW2W/dTy3?=
 =?us-ascii?Q?p523zqTNz4k2Mj2jjershSDquQV3GAlEhAKeR6M2nfznFeGC/o9y2x9/Jn1/?=
 =?us-ascii?Q?7t3jCAhsMN6peFkV+8sEzrGG2JG0t/Y+l3RPYb2r1YSAkMPfg8JC5UG2+s5l?=
 =?us-ascii?Q?RnkYT6ojUy1eUD2KUUiCDropZUZuZGeDoCgk8R9Iv9jK0tp0iJugjWz5CzFX?=
 =?us-ascii?Q?PZGGGAPUnTfk2knJFlSM//KB0lE3UOF/iHvFCCboYwbvHfcLZZQRrAYayACK?=
 =?us-ascii?Q?igbGJ/RPfkqtg9UWLjTPYk45X7yVp9Tj3fgmOhivecrY8QrzXZ7JVx97U40r?=
 =?us-ascii?Q?IbGnRYNO0de9b3g2Y9HBbSM8gsOqsmOop9O6TqsBTNaQT0tL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OCuWybtmts+cPpZkBEBz9cnY6pk0sRhORco2lsbGjBi6eTXj8PI4tbkeeRKuf9qZHJb72LFZ94on5ClQay5vlkiXYz3FoeQAg0R0lnfWeg1bIwKEhyCO6rTi6qBKeUfyHgoCfhkqTSMLLpoZF8ILaZGkXvReyv/ujf7VhfnSxlkxMS775xXhTFh8Sx0dXCIdSrSbnSRNnRNDxeK5ySbvRDPo2tK3CDVBxrVwx8+bPfI7CkRTnpHm555YSRlqh36JFsCJIXkuIvm/uitpIKNHFVIhLjGu5m0HpuPpkbN/VeCPCd8ctCB6Mzy2v0Op1Lwt4UwudTjdZ0jiK4BEXU29MQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffde731-af7f-4140-eef4-08dec17b78da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 14:21:58.5860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ud0xVHmJV8ljyDJY5QQyrr+aM0P14TF7dZ29je48IYbK4q5NbP1v8LZNSIg/onZuDYBSrzn0HdUOuqIWJgSThw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
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

> Subject: [PATCH v4 1/2] net/intel: write mbuf for last Tx desc of segment
>=20
> When a single mbuf segment has more data than can be handled by a single
> Tx data descriptor in the TSO case, adjust how the storing of mbufs is
> being done. Rather than putting the mbuf pointer in the first slot for
> that segment, store it in the last slot instead. This guarantees for us
> that the descriptor for which we have desc-done (DD) writeback always
> has a valid mbuf associated with it.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

The fix looks good to me.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx_scalar.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/common/tx_scalar.h
> b/drivers/net/intel/common/tx_scalar.h
> index 9fcd2e4733..7809bd53e8 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -509,7 +509,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>=20
>  			if (txe->mbuf)
>  				rte_pktmbuf_free_seg(txe->mbuf);
> -			txe->mbuf =3D m_seg;
>=20
>  			/* Setup TX Descriptor */
>  			/* Calculate segment length, using IPsec callback if
> provided */
> @@ -528,6 +527,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  					((uint64_t)CI_MAX_DATA_PER_TXD
> << CI_TXD_QW1_TX_BUF_SZ_S) |
>  					((uint64_t)td_tag <<
> CI_TXD_QW1_L2TAG1_S);
>  				write_txd(txd, buf_dma_addr,
> cmd_type_offset_bsz);
> +				txe->mbuf =3D NULL;
>=20
>  				buf_dma_addr +=3D CI_MAX_DATA_PER_TXD;
>  				slen -=3D CI_MAX_DATA_PER_TXD;
> @@ -548,6 +548,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  				((uint64_t)slen <<
> CI_TXD_QW1_TX_BUF_SZ_S) |
>  				((uint64_t)td_tag <<
> CI_TXD_QW1_L2TAG1_S);
>  			write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
> +			txe->mbuf =3D m_seg;
>=20
>  			tx_id =3D txe->next_id;
>  			txe =3D txn;
> --
> 2.53.0

