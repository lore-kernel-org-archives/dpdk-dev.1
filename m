Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB2CD8CA7
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DA6E402BE;
	Tue,  9 Jun 2026 10:14:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D5813402AD;
 Tue,  9 Jun 2026 10:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780992839; x=1812528839;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/agIawzvNSamdr03gg7V2KNLvvh72/Lki/q9hhRNMo4=;
 b=JJ/dZNf4pnIBDmwEube90XYIIYpXYF8uX0pt5+X9E0fkgkKXUxwhMAkO
 dNHrSO0dkuS++dd0iP7E2OZ3Vz6cqdrp8Cvc/lUIEKGJJzmIA59UA+02u
 YK0ZPoj3wNg5pNz3AARiinTZ4g9j8vb1/I4mqDN7g/WJ5dZiW1//p/j5x
 9b9kvTzEQBoPv4mZgEK/E0EWtQEFS9bmRpuTaqgsyfTPSXk+nI8zMEfG1
 BVfl6R6hj8rOKxyQw9ITSi81Xol750CSD97qFCvUwVwOcomRSzxzezLbC
 GuPwVMfWShLSOmdnQKS+FHY8gjDqP17JtJPwk3+0JHVmBw3/9eAYSYK/9 A==;
X-CSE-ConnectionGUID: y+dSQE2fRMeP0CcLZP/Kfg==
X-CSE-MsgGUID: oZ/fY5BNRYijrgZ0IqKykA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81493525"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="81493525"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:13:58 -0700
X-CSE-ConnectionGUID: 7pE2tKvfTcWu6nA5gEmq9w==
X-CSE-MsgGUID: 0PAAkY/XQeu9Z2PXb9kFnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="245646967"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:13:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:13:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 01:13:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:13:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad+KaY2uaP7WTaqM+95YI7h/OE/xhXmNg2Shtkvjgs7z3237KpOYlJI+W25TegfHeHDuDV6nM1AkLFXflTVIS5jtkIcIltR9iuTeWuj4mAxAVlSQEBxBmGWCJ0pQxqCu/y88YHssJnjLU9JDMSjb8kcTf07pbFHp62gPtpdyMuW8LbKMDtUdJujB7Q9sXfY/cdMXT7X9gPs3/DUIc+MIPmJho34THPXYzS+pp0ApQzlcTBZz6gALkwy7PBK9196PrevHVfPmbCpWpR2+mHx08cRuT6ECuri9wWEbGmmpvhnAZzcrXz+/UBMKL8kI7CuSYour8btt1jgAA5OFxd9oiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otLcrlz3fXPciWf1A4f+H/0N8gKXX2NSKJ4D8l2sx70=;
 b=Ov+8c2gAie47KNq+b+oAOSi02TNMamCPZU0Z6TuxXRirttMaijB2K1terUtMj29MZJTSzfm2kDY4vwna4rIqKx4cvA/25S/zfwODNU9+KBQZ8VVuov2+JjHQKrTIRz5o721oc8LHylDC7p59cs3SRK3v9RVibQfzAAnh0kU2JcOTrhZXA+loOHKpCCnxmh2KVxEYBQMhB261KKGiBzemBLDj91LfetWx21VIPNyHHO8eKRTDHyeR4u6gaoEYguWwfOvVLGl8/FHjDMTRCpo6quEJcdYZ1+c6QjjuZpwdA4JYvkLbBn8deXrmfB/MBOlHpEmo0K08DhsNWtTw+Oa7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA2PR11MB5114.namprd11.prod.outlook.com (2603:10b6:806:114::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:13:54 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:13:54 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix misleading AQ failure logging
Thread-Topic: [PATCH] net/iavf: fix misleading AQ failure logging
Thread-Index: AQHc92pzsKmGe77P80yyRv2HQDurbbY14IRg
Date: Tue, 9 Jun 2026 08:13:54 +0000
Message-ID: <IA4PR11MB9278A4729FF823D93BE849988E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260608171559.355521-1-anurag.mandal@intel.com>
In-Reply-To: <20260608171559.355521-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA2PR11MB5114:EE_
x-ms-office365-filtering-correlation-id: 4c00a142-6096-4451-6044-08dec5ff0c1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 2anlYL77lBBfDf7t2oKeNORvB45dgAyIeKmC8KW1GXPRkqeI67+PMOhxhUoG7VCgX5IiIWROzd7mwP+N7xnAgLZHyuXCRf3Ntrt1qvabANzPiq8LtCDWUekvs3zGzEglwsI/BD9X3qCWF8SSm/OO8lf5RQ3mFp8Ne2aixEixXAYLxZnRdv7WyASNKwqCTeEgPKguiHlc+A5skeb8Q2RNlhtNffp2JxuclzcIjz7/o61LKQ/LHu4YsoaXy7samoP0BCGpO5Ly/3rRFpFuafMl+l3jEi01VKo4WLK2L7r3kK0AmusXocOsZZFq+Wcwv1UArvAAswC0lCSANTzZUYXR2NGECl2C7AaCYWIqVScw4ijPSGx8a5FKZlr+eC2h3q1RN+j2+XYSNIbSxA3BMmrY7MXq32g58yww/39HkFf5Fi/A1wQm77slfgzT2coikX8jdx80l6ujwszw/4SGfJ95972OheqQ65wePuJAt/9sLoC5Y/DTL/xMs3v5u48RqNTC3VVvT+O4JxAK5UeoKOUNupNrd9W/i2yNeVBKSuKPq/SmAH5QiVCNiAj/Lnb+o/pVtaLPOz3I2Bqva1UmQLoa+OR7f6c9zGor1yyW/TONTvdd9lJ7SkWPcQQfBI/bzqo0QFqfw1k32STjVGVXJ0Xgq9BOxz0UCzUqGIp89B7S1RTULNgONtbd7i+Z5Q1WOff3B5+mIysZM6StKMGJ+gNhh5h1FG7VQbrJPs5QUJxQfd3M5x2sbqNrLaXuxmZcgOS1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NvLNs+EawfkhVQ/6Pwfb4Fws0yx9zxQxR9nutgw8aXZpD6aVnw9C4AoJDIA1?=
 =?us-ascii?Q?LItlPMG+xkmZhBmhFHoOTdAeTuKFy8q4eCcmxKt29iWMjzfUgeGZckhZQaet?=
 =?us-ascii?Q?fSBUsOTDY0sRxZ0lBluLIllMMLdYICARh+va9j5TKTUVcy6xy9cOvcxGLCW5?=
 =?us-ascii?Q?STrnwe6c32u/iDnys2Zyw2cGk5fsCQq7HN88MVV/8HnhmMNhGdyuIOJFbh6D?=
 =?us-ascii?Q?dZogySk631tDn9hRuxbEXI65v6b5Bfw4HBai6SLIG6YDi/ca+t+LWRvmGjEX?=
 =?us-ascii?Q?dCG/SPjZ5PXX95u0k3HzPR1YIUW/Kxt8lN4ho68ESTQYUW54ey0KQX6oyXOa?=
 =?us-ascii?Q?DV4IENzNGbSScMQnvrZfLDa4lP5Cc6V16ISoGM/HPk5+pkhV7o3XRhnJszNQ?=
 =?us-ascii?Q?qPA4pCunb/P616W46SrZGKNipZt1qzaZJ7ZwF8BcClT0fPY0eBm8mKrkBW+q?=
 =?us-ascii?Q?ynXgnmnuNSjxylrI9xQ6PtyTfmFfVKeFv+wvAab8qheZ74+ibid4FAt0BCkH?=
 =?us-ascii?Q?wYqKJvbasERY0PxYHqwVqyy3aAi8DbPGaZQuyNJmLmct7eKqYONSHohSqdIl?=
 =?us-ascii?Q?KEb/gDw42Qc01YXB70+DKNxj0Q+q2jt5gdkEHzomm/0Q9d2MaVxeCo71JkPB?=
 =?us-ascii?Q?cRuCAJK8kINGeMeLkrtFSZYghZjU/v33LrxR8c6wEOuI2Z421dsuTY5+kiEU?=
 =?us-ascii?Q?RVExS56qEt4ant1kbATTKaLHbiHADh2vsUVvoGC7jezBJ0CPdQl9wszyJhgg?=
 =?us-ascii?Q?d53Jz/b44yVqc2zGTEfucXITTWH02tvA3XZDR/IQAjtuE95Ap4zD4nRYvHdK?=
 =?us-ascii?Q?URbMYK9uAaqeQY30NB1SNFi1xbBbhBsfxGKFuuu6p4wtQ1oPCqfBJPSAhZ16?=
 =?us-ascii?Q?3j12Kck3MI5iT1c8KTBdUxLCThyK/j8JUoxIX4Ni9iffvhGi4PIjkl8dCO1X?=
 =?us-ascii?Q?7DNcam6dl0I3tTRlZ6tblW1FIiHA8O2f+PJ80DoUWfcdhwNE9bAp0jxpuRgR?=
 =?us-ascii?Q?FW2PCtOaWg7jiyfFulmWG5Q5l3mFuygr57VKpluPDsm25PiVZP/C8RsaLHGo?=
 =?us-ascii?Q?58mnFNhXlCsJVwSdrHlfzZ5/5B+p1sqquP6kxoPBuLBuAzgeF/DIGeutpX/X?=
 =?us-ascii?Q?fE56mjwkXLoeXFxnA5dwqWOCt6kVOZXhSThSOgF2f5xBMFGJaGUUaLBDbc5V?=
 =?us-ascii?Q?XMS8b5eMYQOuEi3zrXVOsM5xhqjRmdoB97LM+0z8pfxVd9q8paqFV+b5gIWu?=
 =?us-ascii?Q?kd3rAqPC0dRq9FGgeW63FcvQpg5ChSeglUDj6EGEyAhM9i0bAWA6ckgdHNMp?=
 =?us-ascii?Q?j3NeqcXYq2E4bCxePwRtJAm657YXxx0vxmM5jgtYLf5Kx7qGPbZEsKba9EtC?=
 =?us-ascii?Q?RE+Eiico4jUUcTYElB5UqqV7c1++0whQFHrD6EB4aoQazZA7NBG+2BgPKX9k?=
 =?us-ascii?Q?6WC005hD4zNrFn4KkovUmzxVMvE7g1tL2UZmt7xS/FPNW+lfJrcxLxcHK59G?=
 =?us-ascii?Q?wY5yDS07F+F6NTAF0psT7V2JrfqNVLY9Jny6ETbIevQR6yv5+gjE49uPFtkO?=
 =?us-ascii?Q?UqDWoLFYx42MqCqdglK+t7uRoUlIV2zCNbQRyFpRf9LQpdkrH5rCxc2yIhxH?=
 =?us-ascii?Q?/H/TrhPXwGJMVJ/BQ66Te/tygOB7md4T8ZK5nrZcW6iRwWLd23J7nEYeKFrL?=
 =?us-ascii?Q?qWgPJsGHMdCCNjUsNZUzegotpGC0TQIxoAH+2k6AZWSiXTwiWPKcZNCW/CBK?=
 =?us-ascii?Q?WFMM40wE5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FSt2R4SrhRf+2htBc0lF9Et6cszAU2mQtxJmUxSOmEq5Oy5xS8bcDeV4a5tuZbt5gLBHaw3JuqfZy66wx10jbDXZXUPK8GGf//F87UIxnmZL1s5TSyrGUis4vSEMvf62r0p1N4caxfV/A9Xlbg9TY2cU26BCmb6ZeQCVO0hRn8S/8FSIY5voi5BfM0y4qkrp0/iltEpLX/ysBT6TlTapY/pX5RTxnHlYwP7O97r9SMHObP39FEoubBr8Ttr8p2VLalpbFyy2f6640zqs5eSh1miF0jRFJRoVyawb/dfjli1/nfjl4Cklr16ZkGJUVYwCb/Y3eOlutH2F7s6kGxaNAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c00a142-6096-4451-6044-08dec5ff0c1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 08:13:54.3149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHBcyc4EexsWvvabYt8xwkpo+sR0HZoDbo9Zk3QXkf1hzEmNUiKsUkBd95tJXxk6n6tzdDWKHmV9X5JRjoOS5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5114
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

> Subject: [PATCH] net/iavf: fix misleading AQ failure logging
>=20
> iavf_handle_virtchnl_msg() drains the admin receive queue in a loop
> until iavf_clean_arq_element() reports that no descriptors are
> pending. When the queue becomes empty, the base driver returns
> IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57), which is the documented
> terminator for the drain loop, and is not an error.
>=20
> The current loop treats every non-IAVF_SUCCESS return as a failure
> and logs it as follows:
>=20
> "Failed to read msg from AdminQ, ret: -57"
>=20
> This message floods the logs on every interrupt cycle and misleads
> the triage during VF reset by chasing a real virtchnl problem
> seeing these spurious -57 AQ failure lines in logs and assumes
> the admin queue is broken, when in fact it has just been drained.
>=20
> This patch fixes the aforesaid issue by treating
> IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message drain as a normal
> loop exit empty-queue condition and avoid logging it as an misleading
> AQ failure.
>=20
> Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 94ccfb5d6e..870d5c1820 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -570,7 +570,15 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
>  	while (pending) {
>  		ret =3D iavf_clean_arq_element(hw, &info, &pending);
>=20
> -		if (ret !=3D IAVF_SUCCESS) {
> +		/*
> +		 * IAVF_ERR_ADMIN_QUEUE_NO_WORK (-57) means AQ is
> empty
> +		 * and is a normal way to terminate the drain loop.
> +		 * Log error only for genuine other failure codes.
> +		 * Incorrect logging like this during VF resets might
> +		 * mislead into chasing a non-existent AQ failure.
> +		 */
> +		if (ret !=3D IAVF_SUCCESS &&
> +		    ret !=3D IAVF_ERR_ADMIN_QUEUE_NO_WORK) {
>  			PMD_DRV_LOG(INFO, "Failed to read msg from
> AdminQ,"
>  				    "ret: %d", ret);
>  			break;
> --

I agree we should suppress the log on ret=3DNO_WORK but I
think we should still break instead of proceeding with the
message handling code. With your changes, in place of the
log:
	IAVF_DRIVER: iavf_handle_virtchnl_msg(): Failed to read msg from AdminQ,re=
t: -57
I now see:
	IAVF_DRIVER: iavf_handle_virtchnl_msg(): Request 0 is not supported yet

I think that's because we enter the message handling code
and arrive at the default case in the switch statement.

