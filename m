Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82783D65C62
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 15:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8017940275;
	Wed, 17 Dec 2025 16:18:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3AF9D4026C
 for <dev@dpdk.org>; Wed, 17 Dec 2025 16:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765984727; x=1797520727;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j20sndF9lVD2CstzM4reVoG3uVRMn2VvSXE/tclIxtk=;
 b=IP0JoLg3TxDR2+JBru56kt9NJomXZhUaIyDAQU5O4f27eqb7NHeqOUML
 NipmGsk02ojPtWsG/5hpQErDKWgnERc3dvkWv7+xsnjFEc7+RQZS1ag2Q
 vDhh7Ko/aTjysveHznDWv2BGf2fi+Qm5se/FCvQFpcfaz2N0aW0ehNQk9
 c1dSt7sY6JFWV09Q1m7a5DkLkpindU0nL4rHtA03lWJZ7TAY+qngv5keg
 5ssOw8tQA52I43XW+fGghwZBMZbQFRRXm1nqp+dFcMQGbSy5aYi7qEVAT
 jb0Sm1QFbRF7wrwkVYyAbetuYp0evUBKecgQtmSMiU1tl56yo4j19tD4D g==;
X-CSE-ConnectionGUID: tnNtDci2TZKI6W0+y4XsHA==
X-CSE-MsgGUID: TNrW7YutQwCgrIGeM5a9sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="55494591"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="55494591"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:18:46 -0800
X-CSE-ConnectionGUID: WfCDx1j6RyuBky857fqqiA==
X-CSE-MsgGUID: 2CvQLFtZQqCVmJrYC6Ackw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="235745247"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 07:18:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 07:18:45 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 07:18:45 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 07:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgRTARVbzCLR7wj+6yNNwhM1Lvul8nr4Xy+oXG8BfYb4yCgufmLzmoynSlNcxQI4WpIYW70uwbuAnns75nf/ryEcL7Iz39vTWh2yRxm0/tC6ZRtsMb82zyDL/F0e2lku2EZI9vqUGboOIRr4hmFrpiL5oRWIxD30dBukL3B4LkmOPl4cqgXmPsVRv+GKhFQS7VX/g/h9WguV6l4sviCQZsyJ13Q3LMUlapiWxcK3Tlc9vsRK+7ZqV3KkvZcKXFY5gJhLlhsVbL3iRI2w8GMSyxD3NqtxXvg9bo7s0ozoUg0jigjkJmWAcQMW5bvLFVlfRdVTQ+jzVmHBYmgij8ykrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcHDtLf8QrpYVV34qzsBSnvtXWIG+UvTQFjGr5N1E4c=;
 b=o0Mg+7AwTcTxapufJi1ASh9cFA5mRBu0JKi6VNsSpvihkbSfx5BBQ8y/YcZYJ3sAIYoe82IgmYtIjpvmUZfI/s4MBwnxHqQI22heY91NRpWBRVb79Jx9MWtGZFw2u1Hh/tJ7Cw3PmO2nwaQmLQxn6pFUB1xdtJjMdcpQ86Eb+SMuyrZXuUgzFCcXPSSwy97Xt8MQUwK6w3YLRgtYxozfUsZIUquZj0cMsxkCtoVn9DYrVxpT2OKPjqSP50J5huF5lR2pek0HQgGgt8jJDxSuM3/QJM1ujTj5LjvbDZmlQLerWfcaP3IIno10K/uFTspzsHWvmp8Q8c33iFtfufMhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH0PR11MB5831.namprd11.prod.outlook.com
 (2603:10b6:510:14b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:18:43 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:18:42 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/1] net/i40e: unset vector flag when scalar path is chosen
Thread-Topic: [PATCH 1/1] net/i40e: unset vector flag when scalar path is
 chosen
Thread-Index: AQHcb2aGKQzr1nEYn0qvq2GNIKOIxrUl70GAgAACmuA=
Date: Wed, 17 Dec 2025 15:18:42 +0000
Message-ID: <DM3PPF7D18F34A12F8DA79F7B83D9E2C3E18EABA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251217145436.3217068-1-ciara.loftus@intel.com>
 <20251217145436.3217068-2-ciara.loftus@intel.com>
 <aULHeab_ajR0ikgu@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aULHeab_ajR0ikgu@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH0PR11MB5831:EE_
x-ms-office365-filtering-correlation-id: 91db8cb0-c87a-430e-922c-08de3d7f9099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?xm55GE0qjk2HhH4cJtYZUIdtrjC+snT6IVB+VE9HVMf+qjlWNjCiedsBTEB3?=
 =?us-ascii?Q?yO0Fi4uSOnzbG96KaMfitHiMGrAGaEH6Ln8+3yeW1oQPImgYAXIWsRTXcMKK?=
 =?us-ascii?Q?o+8jbX+d34v/F6YZLZbZzuLbhvD61Tsh0XYtd0/kqti6dxGDK3KfhsbPB8sE?=
 =?us-ascii?Q?NC8yeLKiEGD9Y3ifMRZ4Fi5Xw2jtlylnlz+iLFyHBEeUKKH3/2RjOh9OMpV6?=
 =?us-ascii?Q?YpyK89Ij7Aw7oulqPe8+wR8awD5O1mUc9HQb4dE0QZxk/I3NV7NazLvJBe5o?=
 =?us-ascii?Q?HzOpIF/hmQng1L6Qy690t1rn5ImA++DDXLMA3KAXgH+Ky+AhJ4Ts09baDSOj?=
 =?us-ascii?Q?2A7f5DsPPKEHgANpNXny70lYPNYREwk+k9jehshwNyeehYiuJMrn6jA//HmK?=
 =?us-ascii?Q?Zd0u3xC1V4CfecrFrJPH2tS74tGO9Zx36K0txdrrHUeNx0CaF2lUbSMRsI92?=
 =?us-ascii?Q?iek2wtFGCmVQY4DxGZVxV9H9QQF/ZqXZcPCUb6gcBXbThXRzIanzA9apOKHj?=
 =?us-ascii?Q?NgkwsvtC4Tk2oWM2YQe8LxCFh10yLZuSkcINOzLCHJWUzkt7T/pSg/VYtSAx?=
 =?us-ascii?Q?SIwQcyHP6wv/NpgD/cZt8wD3RR6OkBIJ6/en8AVYA9qm7/XFzToHAiSL4Dmb?=
 =?us-ascii?Q?LOaOuYDNB+94XhV6tXe3BpRSejVxMVnACp1fCTBTsq3xmDgRsW431Tn/R3JQ?=
 =?us-ascii?Q?bCZusyskGaKWmDBECXuLusXzHJ0dDXrpgtyYOHghAZWaGeGCqCeDu8kt8xTj?=
 =?us-ascii?Q?efTeKRyAQ+xgHdtWUr3v1Y6nehvL+e/Dai77y10G9u9lgof+T9PZ4yY+Z399?=
 =?us-ascii?Q?xix3VW2GXKF/SYVB3Nr19TdMJTGe08MllYq3+jpvfCaFskT9hkuwyipzc5Ns?=
 =?us-ascii?Q?mYkovYqtod7Mw03uA7Hx7Eyn9jeDd4V98ik/i5+7/g7cDUt1OVwbIpj/eYYM?=
 =?us-ascii?Q?NHqJhiaztTuU2FAfdVVthOj+Tg1E8QZLJIFEC1HWLWcLHwvea9O4shdoPnup?=
 =?us-ascii?Q?5YWRHR9fNKse0ohC6514NHirNZEckkQLSXQnVtI9si6CmAz0qnXeth8iM1e+?=
 =?us-ascii?Q?leytYtPaEYXlvB6x7mWphbpBoshY5NpXZjoGCue0+Qlr4RY21s2xLzjTjNLK?=
 =?us-ascii?Q?1i1lkYXo4jQXwQgikhlrwLB36g2XVgGlR3UDBKzm3llzOCRwB7SnC3EjKZK5?=
 =?us-ascii?Q?80MnKSP/Wg4Ei8LzRqlFSHRR1ejHVDc6OaJjl8iHNm2EIxVvt+PaN7+qmnBS?=
 =?us-ascii?Q?bScgQTbu8YVAftExg5sBDa54hFe5A9gT/xo0qRIa9sKdXkjOr7Ksuy+SnF8B?=
 =?us-ascii?Q?09a+zjhFxLOe7itifflho3PuXwF3sJhqMTv+gRm1iy8pUCZUwF4SdMOwdPst?=
 =?us-ascii?Q?xJRiNZctZf8aKmL/S6R2QlgPas3WwiOeoI7zlO8hBOHaywvm4B9kI/62E9h6?=
 =?us-ascii?Q?RR4dE43JigaE+DJg0kO+28WYnHIkEnoYHhA1/e+5ocd+D9k/7p49CjrQvOKD?=
 =?us-ascii?Q?7ZwMSVzjTljIXJ7E53uGPqzvwkDwy0w38L/G?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ILgpRYfRXn9clsMGvDrqxYsFm39lb6CSskFdMEy77uMHkzojts4Pt/AO0WZL?=
 =?us-ascii?Q?Lsad7nNRYT8WovBIC+RhzJeMvUhrGTVdsXOs3Yuf6yTLmf2HuX/gLHgyh/fj?=
 =?us-ascii?Q?lDVD9vXE2HwEAvcjANHAnhtAICmLS+bPqJv7hHRYFrct8ZCEI16wFkjr9R6o?=
 =?us-ascii?Q?4Yg609cKYC/X4qiSuLam4nO2rwCSmChh+c+GZdPUV8EuOBEr7BTDGVwhSIQw?=
 =?us-ascii?Q?bEUp/Swpe+KHBLZgdZ6fTAbixYxBDQRvpZmnBPgVdoj3qEr3nzLa9oY78R65?=
 =?us-ascii?Q?vzMlyE84NEtij86GyvonBUSHHGqCcPfgMN4rudrsue3VIInvCUDJGCf5Tqcl?=
 =?us-ascii?Q?J1VOEzv56I02qg+gfaiQPhAiAiZ1pK3K9Q6dexvjX6JECgux8up+ZdKdntrh?=
 =?us-ascii?Q?1UicGp/NTKX4dnRVncBjgvd+0xYPN1Vq7PwSEICLCpdZE8lxGaJWZWWOJVLs?=
 =?us-ascii?Q?V/RV87y/km6vTREqPE+GV8s5f0Jtyjkru2Nwf30veCTdormuZO73DuTVhHtZ?=
 =?us-ascii?Q?FitiXVBZqkogkDxxqVTvR/Ko7rmicFXbJRkdZ7+HwjzS3YL3cYS2l6drY3++?=
 =?us-ascii?Q?rY4IB7sq6XiU2dxGO8Z7xonDXUCGR0Jjq/UI26PH2awM+U3EItLEHYW4xQ75?=
 =?us-ascii?Q?+eaplFrlJhPLhHPI9foF5f3pRcEYOmLTkr1ijz0jVQfx6gmqj/jsaOeRy8fg?=
 =?us-ascii?Q?PKCPGLpkHNcFpX9TO7n/kUeVzdO7FgTrrXp0h0ls6GrnYN3l5jtSIJDjaytV?=
 =?us-ascii?Q?z6FF/8Ki3ryhmmWLIPnAJ/TQfv/AeCVJGSmKj/uHvnfthPFbc+7Nc2yFjmKK?=
 =?us-ascii?Q?kFFnlfP/Qrpr1hc9bNf69LkT4wYq2KQtANxU26ffgG0Th+uPrRJYTLZZ0ZoK?=
 =?us-ascii?Q?8EYjdA1y/iPvyF9v4CVMD1jda7YDhdkNzXzxXFYZdT0yzJiHchrZ7M1K1GNT?=
 =?us-ascii?Q?PKir2gZeM6o9txPsU8QsarxzDtpdb8mBuEbCyQVqN2Jc4W09K4/iHwp8jr2G?=
 =?us-ascii?Q?QBPa4AeSFibVj9byz6S/GTSUNhB1pe6ccyZEKvKAObfuPCvBUjTISUca4jj9?=
 =?us-ascii?Q?V3Afs1ER6GM2EwOi5IItFTFPU6uKhQGWx7T0Fkk5ieEVY6LdGW+pxpcJ51Jm?=
 =?us-ascii?Q?50JCgjXln8P1yyMxCfZCqG1pBk27XWCYowjcAoh95KUoYWg+TeY2/QjqRUwl?=
 =?us-ascii?Q?dRJ3xgqgfFWUY5okFZSA/FTkeDIaRViQQqqN0NAJNcM4dVrNbRdwq2YAAZtH?=
 =?us-ascii?Q?h/Hby5O7jjqoVOj/zLlc7wjSGKKyUk+xtkcTZvMrBOrzv7RR8PRhbTtuCcZa?=
 =?us-ascii?Q?rTPFwJ3+ncYyKcpWidycOHAtOx+tGiUhZiR9+GSE1ii+PU/AjypVaxKXXolw?=
 =?us-ascii?Q?BRcBRO7AcFpLxFWfU3Y/WyrJgonhT1AFst4N+ghLMjqfZbHyagK5WgaZtDC/?=
 =?us-ascii?Q?0UIxHXLVGfuMAuMTQmFfD6vu0l4JqOSztiqsQViSD+HYWij227qeNcESHTU/?=
 =?us-ascii?Q?naWdKU3HNRQUNtJFlMLb2jsMDP6KrsQZ8iCyf5ofYPEwc9nmOJtI71AICXHH?=
 =?us-ascii?Q?Vk9X31ToiXaZDY8vRTfOBdMavCBYdqec/UrTYMdB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91db8cb0-c87a-430e-922c-08de3d7f9099
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 15:18:42.8719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZB8+8UXpigWUPuvR+O/toRm3wbjMtw9n50WkwXTr+3RuDGzmNzREVinx9GG5BaQHjWCS83Lf3eOJlGyLjPVDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
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

> Subject: Re: [PATCH 1/1] net/i40e: unset vector flag when scalar path is
> chosen
>=20
> On Wed, Dec 17, 2025 at 02:54:36PM +0000, Ciara Loftus wrote:
> > The tx_vec_allowed flag should be set to false if a scalar Tx path is
> > chosen.
> >
> > Fixes: 1ff08bb7ad90 ("net/i40e: use common Tx path selection
> infrastructure")
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/i40e/i40e_rxtx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> > index 2db58c6b24..dd859bda4e 100644
> > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > @@ -3631,6 +3631,9 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
> >  			ad->tx_func_type =3D=3D I40E_TX_ALTIVEC ||
> >  			ad->tx_func_type =3D=3D I40E_TX_AVX2)
> >  		dev->recycle_tx_mbufs_reuse =3D
> i40e_recycle_tx_mbufs_reuse_vec;
> > +
> > +	if (i40e_tx_path_infos[ad->tx_func_type].features.simd_width <
> RTE_VECT_SIMD_128)
> > +		ad->tx_vec_allowed =3D false;
> >  }
> >
> Under what circumstances would this be a problem, or under what
> circumstances would we have this situaion?

The circumstances we would have this situation is when the driver
determines that tx vectorisation is allowed but we end up selecting
a scalar path. The result would be "vector_tx" being set for the txq
during tx_queue_start and later during tx_queue_stop, the wrong
path being taken in ci_txq_release_all_mbufs

>=20
> /Bruce
