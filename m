Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD37FCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 08:31:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB27540150;
	Tue, 30 Sep 2025 10:31:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 88CBA400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 10:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759221078; x=1790757078;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XNOg12cx7m53+Npj62279S1QSi/ZUoRymwOl1ikQRRY=;
 b=LZ2j82DRhYU8XIHhPjRJJw6B2UHmQKjq8/JbbBvDexwtp5IvwDvAWbkj
 MeRg6UemQgp/v3cmPSRBdsw8RCgMdJiO7i3KsHBRsBwP6TgG5YMI/aWyD
 d97oboxva8EEvLKbngEfnbc9g+asZFDoWRDTQg8V6B1hXix1G6/KRsGYo
 3136u1Vb9K+5N8SGUVg6qvBNwMKnGipn83XlMxcDaFg+neX1JN+P6dGmT
 DLp4V1CVMlvAf2loRCqjho4EQ+NDoX8l/1VIv1a5JbgFPJvKSiKbyTqrg
 7L/C2bLRSttwDqqMl34SI1FWiXwCVmVAry9SIbkiKFlWXdeH3b53nRTlG Q==;
X-CSE-ConnectionGUID: I9vbyi+UQXuuA8fFeEqG8w==
X-CSE-MsgGUID: M1GYShlDQHeZ1DiHgxWSqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65293090"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="65293090"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 01:31:16 -0700
X-CSE-ConnectionGUID: 7Pjy7GfLSuOxjsoNwXiXzg==
X-CSE-MsgGUID: Qvmpg554SLiASAO0qJZNxA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 01:31:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 01:31:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 01:31:15 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 01:31:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg1CXDa41zjj93/jX+EBxImkcUpJWFF2yo/ayLyjDMGyWeuxKsKswqKafq4ZauoCe3iT2drBDoLJoxlvncijj8gWXSZs+GPeh+zParcM0wPSRg09l45Qcgy7MC0nDIxrTUzpQrPumHP5PW8xGYR3OkXHQt1icDgeyNebXTrC1aNblnPgbxM6yYlU6kMBhYV+znsld3ejC8X3G4L6rjmRpkMef8e7GBvLHnzzvDrVEjwWM9T9mCTWHJnTNcEojg0xGMGZTrPn7tIP1VxOOqqtOp1DxepLGe5afGY4PeERxADaBmqHo9k7okQdb8Ny+NHAPyk4PdyK1MA9NMgoSoYjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4fErYuNQOwdLkmwZCe4VIOBsGmEDBjL+gMdO7B/sTw=;
 b=oSPDXwtUqJPM+geL47pAo9gmbws3gx20ol1xXBUETVpegGZUX4B7ucuXCCfa/FfvPBZAIgWn19VTB1EyrFkdwDvS3I1akRoY7y5ByKdlZpjEUsOjUddTOKqw48YEH5clIbrTUcK6IZmrjLZdntT34/0z15CiIwX3lPAYDZB9AOELA3kemp8MLCgzzmMv19TlpaYm/yAGait2CzlIqTT9YNNZllXutTQ6tU6/txTJlzEFX2A8ssMoT3oznRvRatii0ptDs5bDl8NVfSHg18Px4Zl2UjXp9k0SIRNl29u8o6/UDN3OLRZzF1CCesFfBiFJe3Tu0Mn8pSV+8HlPMNZBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by CH3PR11MB7249.namprd11.prod.outlook.com
 (2603:10b6:610:146::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:31:13 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::576b:ce1f:299d:677d%4]) with mapi id 15.20.9137.017; Tue, 30 Sep 2025
 08:31:13 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Shukla, Dhananjay" <dhananjay.shukla@intel.com>, "Patel,
 Atul" <atul.patel@intel.com>
Subject: RE: [PATCH v3 3/4] net/intel: add config queue support to vCPF
Thread-Topic: [PATCH v3 3/4] net/intel: add config queue support to vCPF
Thread-Index: AQHcLG0eTTSZzwEpeUW7P41XX21gTLSqNF8AgABYNdCAANhlgIAACy3g
Date: Tue, 30 Sep 2025 08:31:12 +0000
Message-ID: <DM3PPF291EF9BF192839CB6EE1BAD600F219D1AA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-4-praveen.shetty@intel.com>
 <aNqMSu1HDRB8qsvd@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF291EF9BF18F7EF5D14F1ADF7F83EE9D1BA@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
 <aNuLz_WBxYmQFtZW@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNuLz_WBxYmQFtZW@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|CH3PR11MB7249:EE_
x-ms-office365-filtering-correlation-id: 98ee5595-0fab-4307-dbbb-08ddfffbb711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?RYTKCPKnIVAMeLtrlvUdGh2ISVkNkTX/w0DV2ifqKaIB1f6DRZMP+wPV62Np?=
 =?us-ascii?Q?Z/p/Pnygc4vYE/8TVMVHqjE/MlpGsftzzprQS6FQd+i8SHYVlzuYKqXfGo8i?=
 =?us-ascii?Q?J+2hlGpcAIC8/8qjTM7FQzygfLtlnnaw384ErReQiRryMsUnqteFsHlwxYuL?=
 =?us-ascii?Q?0o1bJYRGx4tbq7vSaEm61DNrxywscq12L447r041ojc4/NBUVBtq0AGDRIrH?=
 =?us-ascii?Q?2BmBwFcsdWFu6zN64/McqbxDJunnU/kbH3hjQvcQ7CiQlEtmqkJcfQDk8XFB?=
 =?us-ascii?Q?drVUP1RJeAIux4s2ofVN0Z5wB4iMgWUI5cXvXGSgSEeW+uFO9Ca+aVlUPkXu?=
 =?us-ascii?Q?59+JNRpR8YUS5Z6j1iQTQYYbMFjIsf3+z4gavq+064vp20qy002ZNgWAYPmf?=
 =?us-ascii?Q?uMevTE5x9kGsuzpvX9fi+5xPFhi3cZ3RHiejECDddF4HEfcnP1k6JvzhbI22?=
 =?us-ascii?Q?MVhrjbJ8BDKLO5asfK9HbdUA5ENrfp8W3NY5MAi1+j7H8rjInpAts+WsceTs?=
 =?us-ascii?Q?6eexlrRuN6oK+end/L11exj2IMIZ8uTFU81B1vtO3hPGIMRrrMwrvCGAUi2q?=
 =?us-ascii?Q?brykv6FxvsDzmj8+1ahMmR9tObWwTtchJdHQLGjL4CGl84FFClm/HJHpw+HP?=
 =?us-ascii?Q?v6Wy4JXND0rsN/1vwL6B/hg/J6au3/az7d5bvh2E6NuSLw2aDLVVJolX61hz?=
 =?us-ascii?Q?1nPY1451mKrpx7X1Y20EM1MzkM6zP5vXRg8mHyynM2MFTd4ISPww9UYw3rCi?=
 =?us-ascii?Q?nB3EHkTfl2dzS+4eNQ66Dfj6OVpV+d7VKRB+ZeqcLRgwQcUy7ScFk3/ftwCC?=
 =?us-ascii?Q?52vvDUDtrF8SFcO8f1bdcKBpFjXFiKRtZWyPYSsRzaTVXljimF5wfK/RYhFc?=
 =?us-ascii?Q?RRzae7plDy/ynqLQGeshsWlN9bANRV4S2zmwBF8n7tgGSvjy9QJ8kL3MPMd+?=
 =?us-ascii?Q?AFMyCOIejC1MwTReh6/h+e2nwERfOYk6uTzzcMJjKAOSp8+FY0fpfJVcJH/m?=
 =?us-ascii?Q?OZ8vwF523PUN1a4gxN5q+cTha04c0l756JXwma2ijy37j7cWKxTy8VgCqCFl?=
 =?us-ascii?Q?/C7P2AGKP+PqCXTV/pL/4EVfZcFOfpmufrixqh7r9cay88+rwZtHF1ltmvcD?=
 =?us-ascii?Q?kwV6fWK8E8Li+b8rReul73F/5LmIlI9SnvaelgmpbIcnRn73lNITQjNxBPPy?=
 =?us-ascii?Q?5Hl/v/dgclKRL0cewbNR+U2i2axchAYjx/uNlUGGUSeM5QSEz00tcCkveH+2?=
 =?us-ascii?Q?Wh1rHbIs6JAnVe7iFhcqUA/DRBbXbcDYNQ+5hk5sxsbSHN0ZoxT/eToRuJ0E?=
 =?us-ascii?Q?zDUOa52FoxQpoFlEFUbmnbaTeaaqgtdviDdC1jmEDyok3A6hzUiWygqAzhpi?=
 =?us-ascii?Q?/1ZpFMfdGpcw8tiKJ5K8NJVJaEWcjOZioXjKfbB476hSErivJrTgZNorI1XH?=
 =?us-ascii?Q?KAEFKXtwJC0POLvluSoSRg4qygL23U0Q6kSPa+Ziwp/PGalxf+KxmblbYUMn?=
 =?us-ascii?Q?//PsbjF8dKCv9acweXWqtCQ83gWGqtoDpAgw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kSYkcogmLGX5yDR6eqW7fa2wlJNelaNaolQi2cqpG8noyUoLnpmCZF0BFBKh?=
 =?us-ascii?Q?OzRl1pXWjaLKma4cRSkj6ojGoGxHPigqbAlwICFAJCZh2phI4R7o/GW1Cr3h?=
 =?us-ascii?Q?p1Ca5YM4WG7/WasXkYNC8aR7c8pCgMhYyASeNYA/zjT6KC2ejOndMoxNLuy+?=
 =?us-ascii?Q?8qHnCHAtW+X8Qy90fkJPW0jA/YSsveL3t/DNKd1b8EXu2Lei9uqX/k9vXdKP?=
 =?us-ascii?Q?ppZ1h2KC2QfSEIQP6EYdcF1WyVeCVwQhSMCKus/10RH/jKL+0YuoPh8ActZG?=
 =?us-ascii?Q?d9Muz85Aq7sSn9KF2mDRNmmq5MWtUIoMTev9CZ+25ran1s4U2WgL7HUywt+5?=
 =?us-ascii?Q?U3WvjrcH0Bx1+Xain2oQIrLve3BQItwDUEhnfptAPURxDPBhdfJGfc+x6YAm?=
 =?us-ascii?Q?9jnpwbtWD0QAn6gRpqEHTn6QphNk9Gg4Xhtf2/u+a8hPMBv1n+GLp5UzW8L5?=
 =?us-ascii?Q?qubXmXiBhd6Y9L/8ge+yYq9XMmcJVneRiDP+rnG5IrEzx7UP2qL+/hIIyslp?=
 =?us-ascii?Q?LYPHCqUsbz9QBS1xE5YAGs07pj/unEHf+HjMSCCq/nzr8xTj3XJq4xlT4rrV?=
 =?us-ascii?Q?OpxiHGL80peY3LsR1BYzb5P+Eppwf5gyQ4uCvafAJSE9Sb4hh4KNJLLWlQYV?=
 =?us-ascii?Q?KT25UfCk6Dh1gDRps24tASpvwPY/0Yw2tGYuxNjQ+vs73OmAW9QZlJD/eiVz?=
 =?us-ascii?Q?/FRp96XdFx8CG7RUjBUXWE24nhDr0ucqWi8ny9cGVQENucyZzctx9J2WBH1q?=
 =?us-ascii?Q?XJQf1Si/GrnF+IagfgUG2kLi3PWWYshrOSd+T5GpMZ77cpwIEv+2lXzAQFCa?=
 =?us-ascii?Q?P/J9oD+FF39CxBqABAk2LtbeWusgHk/4HE4m8mn1xqPj8f5TIaZ3aGhl7fSA?=
 =?us-ascii?Q?ipMU5XCrYxlfR/d8WJcwW5iED9FXuUS6Z9gj8NpMiE1dyZLpk2w1BvZAXkjJ?=
 =?us-ascii?Q?8J0sJAIK3kdnE+PqpvloDsdO6Pb1YjFABY8e9qK0vT2VNEk10AEp3joOf0LW?=
 =?us-ascii?Q?gIyFeqgXnMFKip3Z+sgR2MyLQTGyEUtNs4jJmqIlL7vHfXWozz9uCtglVBTA?=
 =?us-ascii?Q?/IwLfx0GHWteJZMsF5xwBlXN3+qhSDgad1UPqxL87q18uwSH1g0S2ZddIyKS?=
 =?us-ascii?Q?MTSb/Dc1pm+0m2tcyr7hvRLGu6H9wmwNVxT+LyAlIqVpqRB0QzLLYM1yc4sP?=
 =?us-ascii?Q?N7W6Usk21Dske+934/xJW1djmeyA1M2IejIiDxnesa5HuTtp+2RxwPPuTDtD?=
 =?us-ascii?Q?5xSBSZjaopDyT+kdR/Qfz56Kyt5Lh5T2KRRewLaX3bfqbuRox0XQ6X+YiZPP?=
 =?us-ascii?Q?vkdq12fYPHMPZps76U0BofMva0/nBiKrJti1itRVCGEkcLxafxh+0OLydzYp?=
 =?us-ascii?Q?01wqATX8PeTljyQtiGGdUvJPDEKw5m9aDjHXv6SmYs/55eFDkcjJ3vymOSsB?=
 =?us-ascii?Q?oqF7irxnkr7MXIackC8qMtCsixlHlfjmuq0WTKVttS6e1sVRxti4T7zTaqRg?=
 =?us-ascii?Q?rM8hQ/O+Sm8GsVWpdPMSSjXU+LK7ciGOC/wMsddAaLhloR6XiFZeKYbd0gol?=
 =?us-ascii?Q?8EUyO4MIPz9xAcxY9aWv9fOcidBgvT6sbVlf9Ip0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ee5595-0fab-4307-dbbb-08ddfffbb711
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:31:12.9366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qhsw+ZY3urdfIPjfoNjmrQSqOq6ZSh5ER3MnQa5+NPTABYnSyoRrWBCo+YlcGxsNVj2SeC6I6Nlho5/ajX0ZtOgJ0KeqcmO6NqtwmHqHDcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7249
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

On Mon, Sep 29, 2025 at 08:53:13PM +0100, Shetty, Praveen wrote:
>=20
> On Tue, Sep 23, 2025 at 02:54:54PM +0200,  Shetty, Praveen wrote:
> > From: Praveen Shetty <praveen.shetty@intel.com>
> >=20
> > A "configuration queue" is a software term to denote a hardware=20
> > mailbox queue dedicated to NSS programming.
> > While the hardware does not have a construct of a "configuration=20
> > queue", software does to state clearly the distinction between a=20
> > queue software dedicates to regular mailbox processing (e.g. CPChnl=20
> > or
> > Virtchnl) and a queue software dedicates to NSS programming (e.g.=20
> > SEM/LEM rule programming).
> >=20
>=20
> Please provide expansions or clarifications for the acronyms used in the =
commit message, so that the commit log is understandable for those unaware =
of what the NSS is, or what SEM/LEM refers to. As far as I know, these are =
not generally known terms in the industry.
> >> Sure - will address this in v4.
>=20
> Also, you say that the hardware doesn't have a config queue, but software=
 does -  I think that needs a bit of explanation as to what exactly the pat=
ch is doing/implementing? How is software providing a special config queue =
if the facility is not provided by HW.
>=20
> >> From the HW perspective, both mailbox and the config queues are "contr=
ol" queues.
> >> For HW, "opcode" in the queue descriptor is one of the key differentia=
ting factors between mailbox queues and the config queues(operation code is=
 different for mailbox queues and the config queues).
> >> Mailbox queues are used for Virtchnl and the CPChnl communication betw=
een the driver and the FW.
> >> Config queues are used for programming the FXP pipeline(Flexible packe=
t processor).
> >> This patch will request for the queues from the fw using add_queue vir=
tchnl message and configures it as a config queue.
> >> vCPF driver will then use this config queues to program the FXP pipeli=
ne using rte_flow.
> >> will add this information in the v4.
>=20

Please provide more details like this in the revised commit log. Doesn't ne=
ed to be fully this, but maybe a summary of it.
>> Sure, thanks Bruce!

Thanks,
/Bruce
