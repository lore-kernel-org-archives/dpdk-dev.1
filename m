Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A9C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 05:37:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CF594028B;
	Wed, 19 Feb 2025 06:37:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5C63B4025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 06:37:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739943455; x=1771479455;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EFqLoW9rQWO0C6gJQ0XpLD7/3kInbrWQF48tDssH2G8=;
 b=fpekmQ0bbUxqOUs6xA9oYU4x6YYVHlBynhcoyuSXgno6vvp5JuXkofnb
 3+ttfVkSJFoJLXmx/o6CNdv3/GTG/yd/77bzy3YJdKga+Fafq0F5PvTsr
 373b0zhxOW9bNNIH8HP5KeltD3001OzBN2urCL3prfVkOaTZFNQ62Fna6
 AwwB+vL2c8BH5Phx867k/tBgAS3wbmsguzHZVx5QyIoH7X9+pM+sqUYUv
 OCAsA1GiTGmJEDVHo/B7kdn8OAQ9upAQ1M8CWpFc6uyCp3J/HnMnwv4jt
 6hGPfb32vxSWWxd6qiCphtQI27GE0l26hUkRi4RqjN4Pppl5bWPwwC7Bc w==;
X-CSE-ConnectionGUID: 252+pKgTRtuoh1mbjUsidg==
X-CSE-MsgGUID: xfNBazvtQ7GQTBTRid9O/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51306706"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="51306706"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 21:37:34 -0800
X-CSE-ConnectionGUID: KUVx0c8WS/iK65devognDQ==
X-CSE-MsgGUID: 94VUaFZwTumM+DCi5WcoWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="119589077"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 21:37:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 21:37:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 21:37:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 21:37:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRdCX0/RfRZbKbiN0JsFB70Cfl90fj08myIi3oEnWpeR4DYG8NK0T8TWmTgWoxTxYkHJlp/Qf7ycFaO6h5CTRCbfnh4/t/NwtUsDq2wB6atahdV0R5R8NVc0luUi40FIwwyHK/QtXh9csxJ7TsRSGmpq3d/nRK7vUVbpc4EyZMlbEEFroKNS1LQZnlDQNWH/s2aq4m4/iTD+uuR9zlGCdpQVAIjXOWceO2Luk1K6dgYJECsvydDQn6WAsAXJXsDBcAmIj7pzy3N85FCtIvADodBZTMtQohs3RD35UA51hnbh2Ubv/vznPzFKrJLPMM4ecEdkULTFP6TTSH7FGcUTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n08kcespxWe0SXwR8KJiffvhwLrKch77duhbzb1LrhY=;
 b=NhkyHh/zxAiwPk3lKGp0kgD4c+XxFHrG9sS49bYs8HF2ZyJmGv7x6ojKZfS/HR5nMLKl4c4AKCUKsU0cfaJvwuUm8jQRO7Aq+Zz8RuStFD+JST9N72VC+diQbnL7e/1o3z2T6XssHheNo7xjraD1j35BOWSU1N2T/Km/FdBgQMVtku7CJdJf2EKw0sfzHvDLIwdbjloCkPf8inT9l2nqUMmS3Ee1Jp2uxHNpoQ6/U0TJCgalyRcQ/lJES4IZqBjTTuQ01z8quiwEdyamqE6zg1AX042Ah7+qMUPKMKGLrfx9ZQ9mcx9spsp7sDHL6rfkn2EZRIqQCwdBRWijGht7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 05:37:22 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%5]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 05:37:22 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Singh, Aman Deep"
 <aman.deep.singh@intel.com>
Subject: RE: [PATCH v2 2/2] net/intel: add Tx time queue
Thread-Topic: [PATCH v2 2/2] net/intel: add Tx time queue
Thread-Index: AQHbfdu40uHenyskcki9NEKmnOcQibNNSKgAgADa6pA=
Date: Wed, 19 Feb 2025 05:37:22 +0000
Message-ID: <CY8PR11MB7747B81C2648823F7582442BF9C52@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20250207124300.1022523-2-soumyadeep.hore@intel.com>
 <20250212214711.1046777-1-soumyadeep.hore@intel.com>
 <20250212214711.1046777-3-soumyadeep.hore@intel.com>
 <Z7S1QPL0qGCdwuF5@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z7S1QPL0qGCdwuF5@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|IA1PR11MB6540:EE_
x-ms-office365-filtering-correlation-id: 63f67e6c-9123-4634-e2be-08dd50a77c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t1pifgBUGoFJuupcIFBMTa1WbgkvJQVBc3ddkvb5ckwz6i3ffuR3IKwh3BdH?=
 =?us-ascii?Q?02MWkakKw2iedqJTQmUaWopgWo7eNSJ0UEwUBXefnY72GMYeJyZHMUMkv0a3?=
 =?us-ascii?Q?jx8MFT2lGv1zPSSyyxNBuFKSyQDO4vxvmEm04OQd9dXggsf/cmjX7Yjhp4S8?=
 =?us-ascii?Q?SaEMCAf9qy8vzSmPi9wawydOFxjCoh6y/tsT/2BpdDMXXpVJ+djoA+IeD+jK?=
 =?us-ascii?Q?vvyP5dYNU8UG9SJurB6IUly+1lIXUoITjBydF1S9qQ05j0cs/HV4p33Y07zU?=
 =?us-ascii?Q?Z98eADgZpwWFb5KsCDNqIKaeVyYpwVx5Dj9w0gqblkJcqifVPG+WOGz7KAdf?=
 =?us-ascii?Q?kJ46ocQ5lI5OAV+vZ8E/MFntzKsCzKMdzIRXLFOe4jcLpX60Z1/ST39DNFyi?=
 =?us-ascii?Q?O+AAVHGI3J8o0cdvmST89SCNYPGSs2uCzHWH0n6icd5oYL6IgJiuawO21hWI?=
 =?us-ascii?Q?nRLCMNpX0UjCmbeN8BTPNCPpdAps0lfQEnrVqssjV2effSqQd8+TkXoDzfVV?=
 =?us-ascii?Q?MK3O7EgNOyUfgyZ6d60k78hcHreMk8ghrXwrHsyU/x36G5eqbPXYQ/swtPHo?=
 =?us-ascii?Q?oA51188eRXJ8T3SecD7pA5jP3Gx+ipghHTYqioLsKXiHBwO3w+752hAHiyMY?=
 =?us-ascii?Q?buXmvOUsrtlqtxpkI0Y2x/odNvH6o+Kf1Hcu77+Qbpcl2IhndiwHfcdOSBEk?=
 =?us-ascii?Q?N5HOtoEeT7/UlfldKxYKZFw8qjHhXAXpOVi1N4672F4LDHA2EV84AwmVHxyt?=
 =?us-ascii?Q?iB/VpAugUuVGWZ/VLmNs4mkhnjjg9iWQt9nETM9Q25nG+3TwGsphBfsSmqvr?=
 =?us-ascii?Q?nL+pJFz8VWz9fvXpuSJYieCZdN53LSbuePCJQbWSdoODe87ulT3vltyeJWFK?=
 =?us-ascii?Q?whJwsjx2hs3zjTJzdL/ewTr6xIkygZgo2TRg7Hpz1bA7Xwd6bO7BzgmktfuR?=
 =?us-ascii?Q?GMZFaUsQYCuisDH5Hg7hIqOpNp+BL+TKjdD5bkCYv3nUS8XkpcTfx62W+vFs?=
 =?us-ascii?Q?tiXsPk4i7pMjO9E7awjtTl7wG02TGa3LM2hyZzXY9m9W/aUkurfOMsyhpam4?=
 =?us-ascii?Q?N0Z9wjsvzyIvgjkcm3QROUcPjGiaSRbKk6WrzX1VzTkBLGiIcdl85uYLzTo+?=
 =?us-ascii?Q?abR80zHdD4XCC/TJ5smU9bbZ0gJTEhMSRd3dAN58QU0J16zQn+39+DIaDLIR?=
 =?us-ascii?Q?sEpQyrHTQifYt6d6VuRtAf6Yo1l3EQws2wgTdHzcU4rwX5PuGAF7nAXC6q5r?=
 =?us-ascii?Q?UH0v7vqw9t/JKGYEOocP34Y3MWmt2Yy0YAd8wrT+fbmSDEcWR0LjIiEj/eKz?=
 =?us-ascii?Q?peu+f8pberOf0wFXFa9OFGSvj1HdijeLozKxNUymXESlkQ6GvAQ1yarSuR45?=
 =?us-ascii?Q?f8JP3yPaoAaGRmLu44C1FnWSsN1AEisP1XtoKelRGIb090XMvk3b5a6MN+QI?=
 =?us-ascii?Q?pVg76Wzv1xKjEGDh7Wdxk9+eJqHCfy+Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OgQn1DYi8iZI2qip0EN1SyalkaZbiqR5AHbd4wx9F71kefRlJDCVKVwitV2n?=
 =?us-ascii?Q?yonNkoR3ieWEQEvfXF31VItel6zUpOadbKjleHhzClvk/d31mMpwF66venRM?=
 =?us-ascii?Q?+VWvEO/o6EVioSuaF0izWtg6768B6BdJqgiBmZe/8QqU3aewDyeGWx3kqQqD?=
 =?us-ascii?Q?86CsGpqPbl2b5TQBpxEqFWl6smtuClN7jzQzGG7lXpV+UDSUJkOG3T3ExwrP?=
 =?us-ascii?Q?UQ8zXvN5dXqQz0LUDmPp0OU6BxaUFJa4GELqe51FEaFgBI48w28myM5y4FmS?=
 =?us-ascii?Q?bwytBkwgzDQPUEuqqd46hCgV4QcySiOasxqV3FP8DdutGzXhv32xBK2y+wow?=
 =?us-ascii?Q?gfDsMMfX44to4WmVaS2XL2D2Ub5G0QuxhzEHN9Tj8r9PztQ7N133Od4PDhUW?=
 =?us-ascii?Q?H6EsTb4zpBL8BkWpOVZ3iLP8EybZH2pPEAmloOpIPBl59QxpznIMWc1evAM2?=
 =?us-ascii?Q?/GnIMrsNU7LfS7oTT+579nQz21p02jVXlrOMLDpX0MPCmCos1fpKIT20oIgx?=
 =?us-ascii?Q?rOfYGI9oMp8XFASVZmoj2wa0fGgCUoknxiapxnQw5RJJJF5WYZg+xNPp3NXO?=
 =?us-ascii?Q?nS7i7Btg6vGsONzDeQnVSyro1iZsqkm7jriJ2R4XFW/GsG0DZJmjxR46Bcvf?=
 =?us-ascii?Q?t7Sw7+jlkIhjgQ+Jej5rL5/KfcvF2QWUukV3QbcmowNAKA702/X4uBm68941?=
 =?us-ascii?Q?pvg9NRhr10Amv1/Ie4ppicT6UKZPBEJUIbBXUlD1KXhvsIX0iC6dqngU5kf4?=
 =?us-ascii?Q?4Bch7rBZz1wzMgt3V+8bM9Ka+5NhKA5hOG4xwLqPD+QDfgc8zYolQv9pf5eA?=
 =?us-ascii?Q?b0GT82VKIupzhz8q4dCddElZn1r5MyGd6kX8t5h4ukMzSdUPIohPtr9YSuZ4?=
 =?us-ascii?Q?UGvwAwZJIdcR6TsJywJb1wTcMpvYpnZkT0/iEuVJRS3j9LS8srL1ZMgKIDXy?=
 =?us-ascii?Q?DTv+XcnKMC19jK2+rjgs5XS9zTW6YMG1UW+NzmB+4dFYSGPatw5hftueMHRC?=
 =?us-ascii?Q?rUkuNGQZWqPtbn17bNsmOJwkELY9WjRyxB0qfqC1fojy+xMuUSW4w1M+S8gP?=
 =?us-ascii?Q?G/CcCFpy+2+e5ZIqTAVMvZLSzfMlQfuu3ENQ5i+0nVOCCF4IwPoGTcLzARW6?=
 =?us-ascii?Q?d1YEfyTl9hYrBgTE5/BvmsQs0cw02Ak4EsOYCEdBLb9U4uhgDE8sDpjAK6g2?=
 =?us-ascii?Q?i2jzvN/h6r8WfnIJTRzL7HEBKM4A3M1qXyfRWV3mk3U3K8ZepkFkNfHAp3QF?=
 =?us-ascii?Q?mScO1Bi9TezxFdrKuMYzt+qgBn1z4kCfc3tTzg6cuUraMTq9wYj9kuqJjfnv?=
 =?us-ascii?Q?mU385P3oXSpBXFPIs4abpoFC+VxhibwqhhgJppqB2IhdrG3kORuQboizQS17?=
 =?us-ascii?Q?Af5zBjNbHi6Kkbf1eXnV6AB+hniVxPbH/FJhDBkZ1Ou6IE2eYyjRoUHHwkCx?=
 =?us-ascii?Q?VJYvigbs9T4PUDPUNxyEBcGiGz+yqjOfM1ePmPp0lCaQ27cGl9fWIuBNumKI?=
 =?us-ascii?Q?ZWL6RisTmiDLUFJW9HbzGsMn3pXkzVA3gakE6p2p+DtARKNTuMwpcBw/SBo5?=
 =?us-ascii?Q?itj64V7xZRe1tOFOEAKO+joJB4ex35Mk1sMmcNa9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f67e6c-9123-4634-e2be-08dd50a77c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 05:37:22.7291 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcS4pVQaB64iU+Xq18WnRKsiietMfQ64Ot4eUXok2dbFwTLpv9mHBbNWnMotO6TT4eVkG0hPZRScChBDKmJ/qnKxKPSB3TL848j13aUsqJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
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

On Wed, Feb 12, 2025 at 09:47:11PM +0000, Soumyadeep Hore wrote:
> Enabling Tx timestamp queue for supporting Tx time based scheduling of=20
> packets.
>=20

Can you provide more details of this feature and how it can be used, how it=
 is enabled/disabled etc.

See also comments inline below.

/Bruce

> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/common/tx.h              |   5 +
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   1 +
>  drivers/net/intel/ice/ice_ethdev.h         |   1 +
>  drivers/net/intel/ice/ice_rxtx.c           | 174 +++++++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx.h           |   5 +
>  5 files changed, 186 insertions(+)
>=20
> diff --git a/drivers/net/intel/common/tx.h=20
> b/drivers/net/intel/common/tx.h index d9cf4474fc..f3777fa9e7 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -35,6 +35,7 @@ struct ci_tx_queue {
>  		volatile struct i40e_tx_desc *i40e_tx_ring;
>  		volatile struct iavf_tx_desc *iavf_tx_ring;
>  		volatile struct ice_tx_desc *ice_tx_ring;
> +		volatile struct ice_ts_desc *ice_tstamp_ring;

This code looks a bit strange to me, can you please check my understanding =
of it is correct.
This is a union, so the time stamp ring here is replacing the whole descrip=
tor ring for the queue? Therefore, we will have some queues which have regu=
lar descriptors and others which have only timestamp descriptors.
Is that correct?

Another minor point is that this union has the elements in alphabetical ord=
er, so ice_ts_desc needs to come before ice_tx_desc.

>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
>  	};
>  	volatile uint8_t *qtx_tail;               /* register address of tail *=
/
> @@ -76,6 +77,10 @@ struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			uint16_t nb_tstamp_desc;	/* number of Timestamp descriptors */
> +			volatile uint8_t *tstamp_tail;	/* value of timestamp tail register */
> +			rte_iova_t tstamp_ring_dma;	/* Timestamp ring DMA address */
> +			uint16_t next_tstamp_id;

You are adding lots of holes into the structure here, please reorder the fi=
elds to reduce the space used by the structure.
Also, do you need the field tstamp_tail? Since ice_tstamp_ring is replacing=
 ice_tx_ring in the union above, you should be able to just reuse the exist=
ing tail register for this, no?
Similarly for tstamp_ring_dma, can the existing dma address field not be us=
ed.

OVerall, I think rather than expanding out our common tx queue structure, i=
t may be better to have the queue structure hold a pointer to another separ=
ate tx timestamp structure, allocated separately.

Hi Bruce only one Tx ring is available for multiple Tx queues so we need se=
parate DMA and tail.

>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h=20
> b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index 940c6843d9..edd1137114 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1279,6 +1279,7 @@ struct ice_ts_desc {
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
>  #define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
> =20
>  /* Tx Time queue context data
>   *

This base code update, adding a define, should be in the previous patch whe=
re all the other base code defines are added.

> diff --git a/drivers/net/intel/ice/ice_ethdev.h=20
> b/drivers/net/intel/ice/ice_ethdev.h
> index afe8dae497..9649456771 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -299,6 +299,7 @@ struct ice_vsi {
>  	uint8_t enabled_tc; /* The traffic class enabled */
>  	uint8_t vlan_anti_spoof_on; /* The VLAN anti-spoofing enabled */
>  	uint8_t vlan_filter_on; /* The VLAN filter enabled */
> +	uint8_t enabled_txpp;	/* TXPP support enabled */

While I realise that "enabled_txpp" matches the "enabled_tc" variable above=
, it would read better as "txpp_enabled". You could also have it align to t=
he previous two members, perhaps: would it work calling it "txpp_on".

>  	/* information about rss configuration */
>  	u32 rss_key_size;
>  	u32 rss_lut_size;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c=20
> b/drivers/net/intel/ice/ice_rxtx.c
> index 8dd8644b16..f043ae3aa6 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -5,6 +5,7 @@
>  #include <ethdev_driver.h>
>  #include <rte_net.h>
>  #include <rte_vect.h>
> +#include <rte_os_shim.h>
> =20
>  #include "ice_rxtx.h"
>  #include "ice_rxtx_vec_common.h"
> @@ -741,6 +742,87 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t =
rx_queue_id)
>  	return 0;
>  }
> =20
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @ring: The tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be=20
> +initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be=20
> +enabled  */ static int ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena) {
> +	struct ice_vsi *vsi =3D txq->ice_vsi;
> +	struct ice_hw *hw;
> +
> +	hw =3D ICE_VSI_TO_HW(vsi);
> +	txtime_ctx->base =3D txq->tstamp_ring_dma >>=20
> +ICE_TX_CMPLTNQ_CTX_BASE_S;
> +
> +	/* Tx time Queue Length */
> +	txtime_ctx->qlen =3D txq->nb_tstamp_desc;
> +
> +	if (txtime_ena)
> +		txtime_ctx->txtime_ena_q =3D 1;
> +
> +	/* PF number */
> +	txtime_ctx->pf_num =3D hw->pf_id;
> +
> +	switch (vsi->type) {
> +	case ICE_VSI_LB:
> +	case ICE_VSI_CTRL:
> +	case ICE_VSI_ADI:
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type =3D ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;
> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
> +			vsi->type);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure the context is associated with the right VSI */
> +	txtime_ctx->src_vsi =3D ice_get_hw_vsi_num(hw, vsi->idx);
> +
> +
> +	txtime_ctx->ts_res =3D ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	txtime_ctx->drbell_mode_32 =3D ICE_TXTIME_CTX_DRBELL_MODE_32;
> +	txtime_ctx->ts_fetch_prof_id =3D ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp=20
> +descriptors
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors  */ uint16_t=20
> +ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count) {
> +	uint16_t prof =3D ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	uint16_t max_fetch_desc =3D 0;
> +	uint16_t fetch;
> +	uint32_t reg;
> +	uint16_t i;
> +
> +	for (i =3D 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg =3D rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch =3D ((uint32_t)((reg &
> +				E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M)
> +				>> rte_bsf64
> +				(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M)));
> +		max_fetch_desc =3D max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc =3D ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc =3D RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc; }
> +
>  int
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)  {=20
> @@ -829,6 +911,29 @@ ice_tx_queue_start(struct rte_eth_dev *dev,=20
> uint16_t tx_queue_id)
> =20
>  	dev->data->tx_queue_state[tx_queue_id] =3D=20
> RTE_ETH_QUEUE_STATE_STARTED;
> =20
> +	if (txq->ice_tstamp_ring) {

Is this meant to be a check for timestamping enabled? Suggest changing to c=
heck the enabled_txpp variable instead, because this condition will be true=
 for a regular TX ring as well, since the descriptor ring pointer will be n=
on-null. Same comment applied below also.

> +		struct ice_aqc_set_txtime_qgrp *txtime_qg_buf;
> +		u8 txtime_buf_len =3D ice_struct_size(txtime_qg_buf, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx =3D { 0 };
> +
> +		txtime_qg_buf =3D ice_malloc(hw, txtime_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> +				vsi->enabled_txpp);
> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +			    txtime_qg_buf->txtimeqs[0].txtime_ctx,
> +			    ice_txtime_ctx_info);
> +
> +		txq->tstamp_tail =3D hw->hw_addr +
> +					E830_GLQTX_TXTIME_DBELL_LSB(tx_queue_id);
> +
> +		err =3D ice_aq_set_txtimeq(hw, tx_queue_id, 1, txtime_qg_buf,
> +					    txtime_buf_len, NULL);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", er=
r);
> +			return err;
> +		}
> +	}
> +
>  	rte_free(txq_elem);
>  	return 0;
>  }
> @@ -1039,6 +1144,22 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>  		prev =3D i;
>  	}
> =20
> +	if (txq->ice_tstamp_ring) {
> +		size =3D sizeof(struct ice_ts_desc) * txq->nb_tstamp_desc;
> +		for (i =3D 0; i < size; i++)
> +			((volatile char *)txq->ice_tstamp_ring)[i] =3D 0;
> +
> +		prev =3D (uint16_t)(txq->nb_tstamp_desc - 1);
> +		for (i =3D 0; i < txq->nb_tstamp_desc; i++) {
> +			volatile struct ice_ts_desc *tsd =3D &txq->ice_tstamp_ring[i];
> +			tsd->tx_desc_idx_tstamp =3D 0;
> +			prev =3D i;
> +		}
> +
> +		txq->next_tstamp_id =3D 0;
> +		txq->tstamp_tail =3D NULL;
> +	}
> +
>  	txq->tx_next_dd =3D (uint16_t)(txq->tx_rs_thresh - 1);
>  	txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
> =20
> @@ -1501,6 +1622,24 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
> =20
> +	if (vsi->type =3D=3D ICE_VSI_PF && vsi->enabled_txpp) {
> +		const struct rte_memzone *tstamp_z =3D
> +					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
> +					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!tstamp_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for TX");
> +			return -ENOMEM;
> +		}
> +
> +		txq->nb_tstamp_desc =3D
> +				    ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> +							    txq->nb_tx_desc);
> +	} else {
> +		txq->ice_tstamp_ring =3D NULL;
> +	}
> +
>  	ice_reset_tx_queue(txq);
>  	txq->q_set =3D true;
>  	dev->data->tx_queues[queue_idx] =3D txq; @@ -3161,6 +3300,41 @@=20
> ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts=
)
>  		txd->cmd_type_offset_bsz |=3D
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->ice_tstamp_ring) {
> +			volatile struct ice_ts_desc *ts_desc;
> +			volatile struct ice_ts_desc *ice_tstamp_ring;
> +			struct timespec sys_time;
> +			uint16_t next_ts_id =3D txq->next_tstamp_id;
> +			uint64_t ns;
> +			uint32_t tstamp;
> +
> +			clock_gettime(CLOCK_REALTIME, &sys_time);
> +			ns =3D rte_timespec_to_ns(&sys_time);
> +			tstamp =3D ns >> ICE_TXTIME_CTX_RESOLUTION_128NS;
> +
> +			ice_tstamp_ring =3D txq->ice_tstamp_ring;
> +			ts_desc =3D &ice_tstamp_ring[next_ts_id];
> +			ts_desc->tx_desc_idx_tstamp =3D
> +						rte_cpu_to_le_32(((uint32_t)tx_id &
> +						ICE_TXTIME_TX_DESC_IDX_M) |
> +						((uint32_t)tstamp << ICE_TXTIME_STAMP_M));
> +
> +			next_ts_id++;
> +			if (next_ts_id =3D=3D txq->nb_tstamp_desc) {
> +				int fetch =3D txq->nb_tstamp_desc - txq->nb_tx_desc;
> +
> +				for (next_ts_id =3D 0; next_ts_id < fetch; next_ts_id++) {
> +					ts_desc =3D &ice_tstamp_ring[next_ts_id];
> +					ts_desc->tx_desc_idx_tstamp =3D
> +							rte_cpu_to_le_32(((uint32_t)tx_id &
> +							ICE_TXTIME_TX_DESC_IDX_M) |
> +							((uint32_t)tstamp << ICE_TXTIME_STAMP_M));
> +				}
> +			}
> +			txq->next_tstamp_id =3D next_ts_id;
> +			ICE_PCI_REG_WRITE(txq->tstamp_tail, next_ts_id);
> +		}
>  	}
>  end_of_tx:
>  	/* update Tail register */
> diff --git a/drivers/net/intel/ice/ice_rxtx.h=20
> b/drivers/net/intel/ice/ice_rxtx.h
> index f9293ac6f9..651e146e6d 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -29,6 +29,10 @@
>  #define ice_rx_flex_desc ice_32b_rx_flex_desc  #endif
> =20
> +#define ICE_TXTIME_TX_DESC_IDX_M	0x00001fff
> +#define ICE_TXTIME_STAMP_M		12
> +#define ICE_REQ_DESC_MULTIPLE	32
> +
>  #define ICE_SUPPORT_CHAIN_NUM 5
> =20
>  #define ICE_TD_CMD                      ICE_TX_DESC_CMD_EOP
> @@ -293,6 +297,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void=20
> *tx_queue,  int ice_fdir_programming(struct ice_pf *pf, struct=20
> ice_fltr_desc *fdir_desc);  int ice_tx_done_cleanup(void *txq,=20
> uint32_t free_cnt);  int ice_get_monitor_addr(void *rx_queue, struct=20
> rte_power_monitor_cond *pmc);
> +u16 ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count);
> =20
>  #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
>  	int i; \
> --
> 2.43.0
>=20
