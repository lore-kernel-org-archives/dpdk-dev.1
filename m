Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF32C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 10:57:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24BB54025D;
	Mon, 23 Jun 2025 12:57:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 279D74021F;
 Mon, 23 Jun 2025 12:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750676260; x=1782212260;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ijXaGhwClWcw/gVVLq2ksKTJyZ4Mx/S6iG/wfBQIKqk=;
 b=j1qXqfH/dvmvlmNEftkrrETF8kv6ed8YegnCwgWBfJEOSzJgRgqNPaZD
 BNgu1nsVsZuK0NpqPS2A/dqtmlQCSWk20p7T9nLbZwWHbecr9n0Px4O9v
 HvrgWSs6VG7PKbQDjkHhqZacDVc0LieswP6IBtMSofp8U4wzzH4snmFUI
 LAZ7eP+AsyvlrcGskpYIl38Slb6ks5KxVirXFXbRGyl+SDyia7IOjt4CG
 cXbk1boRIeE3E09HgbH+JrOeS7xByGtjdUWT6TQiTs/89h21635VeGXZS
 RhfYN8WR5+zD6ADfNETaISVRIRfSTrLVzvvKCi0dtTytQVphyGbTKn6rW g==;
X-CSE-ConnectionGUID: q/gFEJIUSFKrA2A0NEm2pQ==
X-CSE-MsgGUID: wvI+87XqQeyYr1W1ToCaQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="55512024"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="55512024"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:57:39 -0700
X-CSE-ConnectionGUID: VWn3IpdcSF+HDo+3CrrbpQ==
X-CSE-MsgGUID: MACWujtPRdywF2O8chQ7YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="152085608"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:57:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:57:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 03:57:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+iF7k48BU+lVxHqCBY8tKWYTEhOlE7IlmXJj4pwNRPaka/pOk9p0+sCzQj8zVIYbYh5V+gFFYMDJfgad8VNd3dBMLhnt5dfiG/o3lKg71uyf/T+1NbaPtzFJoj30mfd2S+GoW1B9mTUbZ2cOl2SxW66G76HJcYyGGof4Vo9shRnefG/zDJPUjHsT9+poAZaqMYc5dyTn1u59eE6gAt91/pSeKMixW3jEVTi/n9LaDU76SxSPRLvLwCRZo5t1arqkEGEyxNXEPtUpItA0NjJwlcPId11USDOcd1+fH8/fEOlzIaRV+KrNAx8vA0x4VaQB/HRu6bVcr1w+u4IEg2bCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af+BI1C/pQ6fQRUZ+mDir52Nk5ZOvepa7xJbzj+bzrI=;
 b=FfalyQ6/QP0FEOtc+O4SHC2CIpZIjVK4kFMUAAd+Ix+3xDuSKLx/glvmH1tIwthxNyGMtB6J/kpQzqkm1d55A+or/C1TR2PEoGr1PAaKGRJAflSd4Hfyld4IHUpTfzMKc//WkNmzrEFxq4VtxjiPsRbSHywp+AxwXYK+Z6Aq49LzoHHn97V0+1sz6GjLuSQo4krNa9iTvxgiQe30COr1mjhfjMm1Ilb+7wvor7OYK8F6O/5QRXta2sCFmjKbOwfM02G+5VSk3ISAabd9bgxD5PtBFe8++A7azIu/OHdGxcNq03cff6dTOCWlzErUz8uBbKmuaw1RQpLmRdjvWGBqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DM3PPF195D11F0C.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f0c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 10:57:35 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Mon, 23 Jun 2025
 10:57:35 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix VLAN offload strip flag
Thread-Topic: [PATCH] net/iavf: fix VLAN offload strip flag
Thread-Index: AQHb4k/KWaLlhovU7EauUIhT1xReErQQkYIw
Date: Mon, 23 Jun 2025 10:57:35 +0000
Message-ID: <DM3PPF7D18F34A1336D3C63F02230B3C4DF8E79A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DM3PPF195D11F0C:EE_
x-ms-office365-filtering-correlation-id: fa405650-ddff-4b3e-3bcf-08ddb244c2ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?25w88fwrdsdEW5S8n5C/kweyoBTYpwt16nUWfM0lpAHsTkpvwfWvC4Dtv2xM?=
 =?us-ascii?Q?zIZlOn+rsWE5C4iKM95Xj1p0PYEpGsHDgWoQiih2BH7xrzw8unedvBcFJFOg?=
 =?us-ascii?Q?GFyZJREWFd0AaIbd46VKzp928tOPCHIsDNObjCqv7fq8HkIclYN0SNKzqvaG?=
 =?us-ascii?Q?xw9o8sboCHTd8NJHcpNwbz6eWT4a3JwIBpx8DKEpTIxgyDRP5jdKG5yTQMHR?=
 =?us-ascii?Q?sUXJghCSYNtChunoWCB7MftixVahy77odnVL3xxaDCtj4aAvYN6SolW2PyuM?=
 =?us-ascii?Q?xQspQBGS7/WSzdm78CwMulkgJWjip6bOl8G0vbfOTCxE4LA9FxyXcB4Ek36Z?=
 =?us-ascii?Q?hUjAYTrLAQsWBCRcak4GAB+palZrxiqiJie2V4nIUuudp0SS9wpJMPlNpzl7?=
 =?us-ascii?Q?9qqLWf9KtOu4WSN+hPa9SonREHDajtzkgGckxKJY1sn36UbaExnmSP8YPH28?=
 =?us-ascii?Q?5GArJZYTIhgV1jEw6odHG8uFHeUmt5XKIdQ07NWbqMYddcLiocyztZOEbRV0?=
 =?us-ascii?Q?IZIzG6ohPebZHJM0nsz9EOjvCNxBqhQt5fU7bZnrV82HJ7lEUovXh3TC+ele?=
 =?us-ascii?Q?hPh/EcypMvXcKxPMwQSwnaSlW5aZAiEXfSD3cTs7NDUksiFPtvY3YOz2FXGT?=
 =?us-ascii?Q?19bRvvfSx3LKc5RBN1Ucfa/kojO/fGgHZbt4Hk/6uEx3kitDgram8s8Atvox?=
 =?us-ascii?Q?dYSG64p/fZMMcwUzli+Dgil1iJuecrEyauyZ/eT7FVUHOKvx1HF2dXjC/0f9?=
 =?us-ascii?Q?62Usa8KIemkiJvx/e7k4k3AojY/y4Jvr0hEXzPF8PrPoSkw2LyOZ7QTWm1UF?=
 =?us-ascii?Q?k3JYC/IWmPha7kR4FLC/RZfPJr9Gr/o9CLY3Q0E8CclSZUKvHKM6t5H9AV2+?=
 =?us-ascii?Q?ohzuOOnUKA+vcVaexv5yOgPHLNBt5IQqYmuMdPV9blrv0o5CGv3i6A64qlTb?=
 =?us-ascii?Q?nCy/I3Sz7T5C7tfv0wZjb1wmDxMJs+028/4ZDq318pwZE6vOAyI0BnAw3uBD?=
 =?us-ascii?Q?omsCReaDG5cRmq69CqE5IYcCjzAY9V8alA+Rp7Qkrcsi2IyQYflpF2LylPHM?=
 =?us-ascii?Q?SSb77KXOkV1eOuRdLN3IuQX94k2mJ/1mVQcnjbGDAujVJT2DW2BBDlJmw7jp?=
 =?us-ascii?Q?fVnMqKjjsvPTATQvtlG72SKpPbWxUWNTgtcvGB0iM1xaZb/pHhIEAEVTg8ZZ?=
 =?us-ascii?Q?xk3z8D7VbMntZ6ad/uKDQnqJg3zm22iKGl5s63PoVbSdJFPn7UiMFw89ApJ4?=
 =?us-ascii?Q?5WUoa/MCg6BtmibyYIcg64eBkrj7HvytGrah0ISj/o3SBUA9LNxYQdFJv+yw?=
 =?us-ascii?Q?G2/w3uxXoZnjLRV+HjCQI9Hq0hkm9km21Y5Z8VYb042fQViPVrDEk5cfaDt7?=
 =?us-ascii?Q?jakhcj6L9oxtLhZmvCX4WhZ21KLuSYHQ19rj/ZKmYjsMl79YefOhWu7PnCY7?=
 =?us-ascii?Q?2paJERYfKtzMtEO45H1y1s3iPYwvZxN6N/myjRR+lLz73Q7fXFcq2Ompw6c7?=
 =?us-ascii?Q?/y210GOTkf1MDeM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2fu07w8ogGJeKKayTNW9WWpajI81ubiOcbvQs8LArXLViYhfw4nOWmIhEm/A?=
 =?us-ascii?Q?5BAwVYhGJEDRNLkO13NPOJ68u2cFUDgXZMzetiCAcYzRc9CfR88M6PAFMduh?=
 =?us-ascii?Q?XTxZi1VBvYQpspF1KhfyePHiWD4bWc5BRMZjUde8dQDOLQKej5yFNojYrOo9?=
 =?us-ascii?Q?hpt025Wqnb63IlmcoYZ42UtX0FpAX2pG/neJrKKM0qy3ogVjlC23SknToCp6?=
 =?us-ascii?Q?xvKO7SgtsdVjeW2Wrs+VYFgvxyKrmu2kqKGVxWBBNPAql7gPDr9JUsJVkVb4?=
 =?us-ascii?Q?Nty1OjF/n1N+s5eKspmZEQ7RwOxaV7VbS4VCJTpf98dgYzrsAXxCIu1UNRM/?=
 =?us-ascii?Q?RAKByk5nuD9oRIMXlR4W/NXNORHLxM8LzGTTyLZPRmSOvJJT8BjfEHhlVUV6?=
 =?us-ascii?Q?J5ica9Iv+um6ODkwWBbgAx6cQEDFxS/oB+XmmvXmdV6XhMxzPae3nWUOCXAG?=
 =?us-ascii?Q?GHXDOZlyELFcT2XySZUIuSo822Ye5GmEPBSsDwlNDT/7TEBzpYQOVuCQwxAP?=
 =?us-ascii?Q?xycXZaMHMGIlBC4rL2WG/+gTrkJ+U18PcEggAH+f0QOeU7cT+ss0TbEbortF?=
 =?us-ascii?Q?f1IHPErlakn9r+DcdNQSvjIrPS/xKJ3eixXGpWWw0A3uK7E4UALnpXoxHg7u?=
 =?us-ascii?Q?lNPTQeqYDE5VMPKVFrdvHDIZBS1icVU3Um/3Wj1tkFBpbN7k2CaO4LqkFnx1?=
 =?us-ascii?Q?LeJc25Z4t6+q9hKJKvp9FfYw/Yd/n9bDgPHCLVaeWyIsrRqjPcQZ17LLrrfK?=
 =?us-ascii?Q?KA4RwZcUUEi3mrWwF4svsDcyvj5LAiGubQfe45+xAohOSstjJqAAt5giGHI1?=
 =?us-ascii?Q?aO/3LsRO5CU5IBsdwHoCwEZ+cflAbm4XXTigr91A9oZ63GhqBexX4XiGM/Lb?=
 =?us-ascii?Q?zQcFEDd93zgTD5fSK+GLNDZFQpF9iJX6cb6b64InBOHAAEWSk/Wa/UBBbov7?=
 =?us-ascii?Q?Ze1xTf1MDM5u2NOMV7Q+IspToz6ufvOm62MAUqA3BPo/J+mbGDA7J3ETFh4D?=
 =?us-ascii?Q?rI/UU1b8Wm/1OEDzMZyVApNu6/13FeA0EAk48nhQZad00fh7TqSQjW7mW6fV?=
 =?us-ascii?Q?ILGcHIk6zzYOt0tmrArHs4Mtpbo29troszmnJB3BPVpbRUgWwMLMAvLxfIvl?=
 =?us-ascii?Q?CPJvwuMAxQld4+IcNIXRAL7/++v2n3DOf1qpGae2RPKHq1YtPc8plxNOWoj2?=
 =?us-ascii?Q?7q8nEXQV8EQTBh84KcVIeaem4KfdOnKamYsoFx7gXA2PUEO+RwEqM4pTinNm?=
 =?us-ascii?Q?OaMrirFUqYQkV3yDLZtL3ZtOUygKr0LQVImHamHpRdPytNcDUPax0Ua8IQ8j?=
 =?us-ascii?Q?uZZGP3wMGLZtfJmLCvxkQYvXrqPYLkmL1/p0iVyk6fpqKI54VeSiAt3btzWm?=
 =?us-ascii?Q?htMDTFw/ZGEennyPnP6Kc/C8apeelHfLVV0AyqH4io1xLNDaMXqHrZYQWmY6?=
 =?us-ascii?Q?d9jy78C5RR4cKP83Tqnmqab1awMqlY2JMdYb7JrEPbQDX9/J1Q2KvdjTa1dY?=
 =?us-ascii?Q?IWPr4Jjmb5GktEOfxSpv3eYb8faiH2rF+j7BWOyhx0X1flkW5hjy8IfoBOb5?=
 =?us-ascii?Q?F9KXtzP67Zd/YvUKuO4w8Sw9D+JRRh9OJSNGnwNg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa405650-ddff-4b3e-3bcf-08ddb244c2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 10:57:35.5392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp48JV4TWH8tsgkd5kNiJtp9hsbNsDeEkSVyrHztTi/nV9vAfIKGcT6+Yyvhg9lLHIpoHgAgOAJk0Ikw1qEK/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF195D11F0C
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

> Subject: [PATCH] net/iavf: fix VLAN offload strip flag
>=20
>  For i40e kernel drivers which support either vlan(v1) or vlan(v2)
>  VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
>  side will not change strip flag. To be consistent with dpdk side,
>  explicitly disable strip again.
>=20
> Bugzilla ID:1725
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 48 +++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index b3dacbef84..f93e7bf9ae 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1378,13 +1378,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev
> *dev, uint32_t index)
>  	vf->mac_num--;
>  }
>=20
> +static int
> +iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
> +{
> +	/* For i40e kernel drivers which supports both vlan(v1 & v2)
> VIRTCHNL OP,
> +	 * it will set strip on when setting filter on but dpdk side will not
> +	 * change strip flag. To be consistent with dpdk side, explicitly disab=
le
> +	 * strip again.
> +	 *
> +	 */
> +	struct iavf_adapter *adapter =3D
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;
> +	int err;
> +
> +	if (adapter->hw.mac.type =3D=3D IAVF_MAC_XL710 ||
> +	    adapter->hw.mac.type =3D=3D IAVF_MAC_VF ||
> +	    adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
> +		if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> +			err =3D iavf_disable_vlan_strip(adapter);
> +			if (err)
> +				return -EIO;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int
>  iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int =
on)
>  {
>  	struct iavf_adapter *adapter =3D
>  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
> -	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;
>  	int err;
>=20
>  	if (adapter->closed)
> @@ -1394,7 +1419,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> uint16_t vlan_id, int on)
>  		err =3D iavf_add_del_vlan_v2(adapter, vlan_id, on);
>  		if (err)
>  			return -EIO;
> -		return 0;
> +
> +		return iavf_disable_vlan_strip_ex(dev, on);
>  	}
>=20
>  	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
> @@ -1404,23 +1430,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> uint16_t vlan_id, int on)
>  	if (err)
>  		return -EIO;
>=20
> -	/* For i40e kernel driver which only supports vlan(v1) VIRTCHNL OP,
> -	 * it will set strip on when setting filter on but dpdk side will not
> -	 * change strip flag. To be consistent with dpdk side, disable strip
> -	 * again.
> -	 *
> -	 * For i40e kernel driver which supports vlan v2, dpdk will invoke vlan
> v2
> -	 * related function, so it won't go through here.
> -	 */
> -	if (adapter->hw.mac.type =3D=3D IAVF_MAC_XL710 ||
> -	    adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
> -		if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> -			err =3D iavf_disable_vlan_strip(adapter);
> -			if (err)
> -				return -EIO;
> -		}
> -	}
> -	return 0;
> +	return iavf_disable_vlan_strip_ex(dev, on);
>  }

Hi,

Thanks for the patch. I reproduced the issue it aims to resolve and confirm=
 the patch resolves it.
I noticed when testing that even if the vf command in the iavf_add_del_vlan=
_v2 function fails, the stripping may still be enabled. However, we only re=
-disable it if the iavf_add_del_vlan_v2 function was successful. Perhaps we=
 should make the disabling unconditional or even better make it depend on i=
f the stripping was enabled although I'm not sure if there's a way to check=
 for this.
With test-pmd I use "rx_vlan add all <port_id>" and it fails on adding vlan=
 17 but still triggers the stripping to be enabled.

If you are posting a v2 please check the indentation on the commit message,=
 it looks like there is some unnecessary whitespace.

Thanks,
Ciara

>=20
>  static void
> --
> 2.39.5 (Apple Git-154)

