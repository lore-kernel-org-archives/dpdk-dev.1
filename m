Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE0C83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 15:28:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB6794028B;
	Thu, 10 Jul 2025 17:28:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F27E3400D6
 for <dev@dpdk.org>; Thu, 10 Jul 2025 17:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752161297; x=1783697297;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i6dpOZEFOJBxkj8a0B0G6Azgn1XXlEEZWcKLtBKPwk8=;
 b=iwUMOU3Iu+QWrWzgJ7fQErgGc3xf0W1cAFZ6zmaHTwc/CSdriIXEtzfK
 Z/WtM+cYqymAEK1cFrGDyXt21oSbQu67Zpvh7N7Vj+Jg289FGL2xZjv7y
 8XiChg3kKjexaghasp8dVfa53xr4cvVW8XPG1B9xyvPLja2BXBbWBjzrr
 jEqfQ2v3ji2Dsm7QsiHgQyKwduayjYqWgsLtWGyFMaOmJcuMJwxQyvJDl
 ljMVqQjLmft56U1V4QZJR2N66GnYolt+JqOptGWBCiexjov/0N/RdwZet
 BnWfmAXqpeYdb66e5PIYd1KRZNsvpmHDbu2kxqpLkRPSZcUk+0Gqt71VJ A==;
X-CSE-ConnectionGUID: u5+XBkgeRxq6fGGaK4zE/w==
X-CSE-MsgGUID: TVLify87QBevYMi53t1j4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="79882841"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="79882841"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 08:28:13 -0700
X-CSE-ConnectionGUID: UsPEOwsTSvOl0JyNOx84mg==
X-CSE-MsgGUID: wzPl7jgcRfeYpMKf5ZrtHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="156467753"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 08:28:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:28:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 08:28:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.77) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:28:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV7OnpwGef7Jzrh+E5uHskRx3VIu3+G9RUqLudXIjHx2qBfzZ/B6OxzPRXDzndrapEgrufp7igRHmCyNueoLivUwzBaI+Vkf510U9Nx0ND72a/BbdkcWrIXAYuNXfI9gA7ayqKJ5bgkyeKzjRQgsqEjgeTIzEEDBMvrnRCs1vNA8M4b65AZBh3FiK0cDtdjohbo8NerTLz0+wLZEIaPDrVaKAhAqVegxEyLyxjzCTu+hqBhx0eYLMmWWqvg2FkixJmwhhqidOWt77i/5Liy3msLF2K3YIvF4On+hnTYzJwUiKH9sN+RLdTHJFluXHkjAZ511zUAKGVXE6nKxGz/Ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSgmrQDJg2GeZG7deb40hGV+0/MpYcMiUYIk1e2rrtE=;
 b=UQOpJ5nks18OYsclA/sxl+04WUuRa36Z4dw3ALWeTMOn6Q5I+hNHDwqSQ9UXhPxWu0nVjHPqOPaRhh3Y44/yfLQwflFxKRAYBz4zNTeJoqyBFjeSUpOMCoVCVyGabZip3/ajTQJGPiriyxQEFz/zzBTLTQIqr6chGEYeaffcBaD2Z/r88mvOQRnXlJZgYw79kjfZlywIsTc85EUYwhSaeT7ooeYKULnJs6JmY5m7NbSTOeRQpXocs9YBv7kvofR3jI/z05dfHWkQI1Q2afo95dT/rsKeT1w6qqQMubI9OyaEPN/5KvI5N+zrgxZStlwfRyStVuMYZItG54emdx5/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 15:27:27 +0000
Received: from BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a]) by BL1PR11MB5461.namprd11.prod.outlook.com
 ([fe80::8d83:7a30:43c4:835a%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 15:27:27 +0000
From: "Pathak, Pravin" <pravin.pathak@intel.com>
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH] maintainers: update for dlb2
Thread-Topic: [PATCH] maintainers: update for dlb2
Thread-Index: AQHb8I78DbkFmQrwzkiakdbVRvnj1bQrfFkA
Date: Thu, 10 Jul 2025 15:27:27 +0000
Message-ID: <BL1PR11MB54613E670B1C84E40455F912F448A@BL1PR11MB5461.namprd11.prod.outlook.com>
References: <20250709050434.1296690-1-tirthendu.sarkar@intel.com>
In-Reply-To: <20250709050434.1296690-1-tirthendu.sarkar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5461:EE_|PH0PR11MB4821:EE_
x-ms-office365-filtering-correlation-id: 078353fc-30ba-451f-01d1-08ddbfc64753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a4/c0SvBgeuWXi8KKB7EH3kGu26MVgoVqx9aIlal14FO+YcB/eRwOZ465y2G?=
 =?us-ascii?Q?Y4P65BJqS1Bfm7YLGbTL6kEi+dzReihwxpHSiENToU74dTVuO+yNRUq3pnUI?=
 =?us-ascii?Q?EiUHS9ABiqMjh/AYXB5prcPS+42NpH5tVDkhSUSsRnffEwKb8xxfjdVGTQ3H?=
 =?us-ascii?Q?6IhmgzUyfEcCr6sVNdpCboWq238NFgw1fgIviUrzp09bdymfcFzdmrfgXKTc?=
 =?us-ascii?Q?2StveRqeSg9Qcsne5dxbyJ4B97v6jHRodShh4ddqFUBcSEAktNZq/gZ3vRt8?=
 =?us-ascii?Q?QMqUij3qoo4/TMxg65ijR2dBlacpyGMFXNFNZzoQzu739TXJFYQK+jWmZSpO?=
 =?us-ascii?Q?m6ycIuIAODL+Q/1QTXB3pTrxGzAHeSIc/sl7mAPGacc4XsDRRBHhCwWcQjkb?=
 =?us-ascii?Q?9IHgvu+/4yXMBz+9bOWlYE9xmmdSjGq3WA71kWrmkLzyz4Kq4g7Qd+hZ4qWb?=
 =?us-ascii?Q?SJXw/Vf+/4YzBiIKfNdfb5hXB+66xxo9VfwsCuzsClz1/9xTZ4RqVArO9mqG?=
 =?us-ascii?Q?xuOjAN2ELtSa8kc1qV4U0zk83wCbfplLRxdY3W71cyyJ9S1kcFkwVMYXzBf6?=
 =?us-ascii?Q?UqgOys6vNHVdx+TFKc518v5XOAOZ3g/Wwu70w82Tpiw6HZ4NGh/EY5Cguo9S?=
 =?us-ascii?Q?ORhQVtgy70p0AP2HDNyC7k4x0WqtDxBfACRKZQGA9YoBLIDBV9svHjQvBRTS?=
 =?us-ascii?Q?3KSsgCMqvIsPNlfmWWM+mZhFOS6nkYoaKHpZKupLQSjfMQ/rbLijI1P74KAa?=
 =?us-ascii?Q?alzT6MljgCSzXeTyrhAFn8mx4iEe01QtFiDposCjRSlS1AMH+NwOROcwHrwk?=
 =?us-ascii?Q?EHuFaX5faTi8SsVkimKwJJ86Ee9/rxWinmvzWwOBjBinWrp7xWr15Cw89g4S?=
 =?us-ascii?Q?5/J7EtHrqx8UoMKiGhwznrI++Twk4iR1lNnQQNtuYBNGrYlLPWeVml9S9qSi?=
 =?us-ascii?Q?jiRF2IzmyS16noHzt+tR5CGcLD7UXM0a3ZKW+BQJFXOOgd8fRtILaHEplHMt?=
 =?us-ascii?Q?HPs5FZmHCL3cJa3/1Nz8CLtfRAvIDPGmXu2HlflAjphTxPxPAQ0OXtkWeMGh?=
 =?us-ascii?Q?SHVLrJ1w54B9XDhJaRdTLOgDLS1Vt9OmqkyEH34Bg5L3Jsdhy1tPL/4u/4rf?=
 =?us-ascii?Q?4fj//ShtsCCM/iBPAmWPY36/0ChgNzW9TfOC0ClbZQTukXDP/xAD4Gxx0T9/?=
 =?us-ascii?Q?C9HZPb3u9jKcrAjjRKAaKoAz1nNXKts6lERVK7hKwXswT4ANscexbRER13D6?=
 =?us-ascii?Q?4AqacAE3UUyhf1/Rpt5lIeuAHJPBadUjhgZ4XAGab6IRhmWhcqpdIiUo/Bbe?=
 =?us-ascii?Q?zySAp0hHzQbbxY+gQHpxZW6F36prryrMFsbEdLtPy6Dy701mKvJ89M6dLvCO?=
 =?us-ascii?Q?C6xCnD71PFNZ0BPd45iW27ZPZKV+TOeRB9yjnU/5K6UhT+Jf8MGE5WTf00tf?=
 =?us-ascii?Q?9yWtkB9ORrPVdNIsGvZU6vwn+0iPtkae/b8Ts8TYCZZ3Jy3vmy0MxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5461.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/AdwikLu1hzCCFFYtfH5SxUOwmS7PZpgDSRnE5R0kH1tBBPc5umZ9fcQ7MNx?=
 =?us-ascii?Q?ADTR+EzgIfuK1lw1h/6+EbNm3MPU3cHouTl2RHwz7guJXhmMWHaKdqIHZT76?=
 =?us-ascii?Q?g0vvjO1Gy8VbgaW3zQZiIw0cq2FC+YrTX1k4X/aETWlKsDUg3qkorU20IcdY?=
 =?us-ascii?Q?zmoNrz8GJbfS7MlZquBjqLbp9FqcSC39tcDWImB2QUbVs1UfSXU58VFXTZWh?=
 =?us-ascii?Q?h59HwhirA2+tq+Eb+fWtJiG1y39bUU1QuYzD6V2gzqPGlNwpenG1R9SgK0NJ?=
 =?us-ascii?Q?PFa53MVjbYFO46xFlhM7RiHAfKE+6EJMhIgkzWR2y7Pk44QsA4zKfvADnwfl?=
 =?us-ascii?Q?inrCWo5+d3XqgMVZvjUAHDPWmJhuGlLvbc8VxGGqvTJEJkfTZW5DWOT5Bz32?=
 =?us-ascii?Q?aFO9zOK+BCrN3rcprgOQYUT8KTQEzf1+RgQCF/bKpcAAVYNr0BMJ+0WPtgcd?=
 =?us-ascii?Q?VmmHFU8A+SFvEQBRrooRxUpRhpAJnfOZ51fjJ6hrSapGTYK0nDJTYL3nwTw5?=
 =?us-ascii?Q?3Qd5A0fAGq0TmaSRiFpVIQsUwwU3OeFkizXLnOCG5dU34OC+DZIBRiLCjmOl?=
 =?us-ascii?Q?GxCM+TZFNY8wG89c46uhRrJGv+bJ83gH+Sj1BEI+Y3tsqHs7m0ceVNAEV+pz?=
 =?us-ascii?Q?sqmMTWsv6nBj7SopOXEs8U/b2cW9XAXeW7/+tuct7a5j1mO5V+SM8wYz615x?=
 =?us-ascii?Q?mJ6NLAcUQJp3OvdRvPb3UO0X/0Bfkgblw1/Hk2CeoVk/yiCpu5y7e+4XLruP?=
 =?us-ascii?Q?Icx/rhm659PtMd1QrNDMKZ3WahdR260z4D2yz8YuJ4v4xXqW8MvhOU50viZr?=
 =?us-ascii?Q?s4FpgL2iALPHWw7Emr8yZBRYBWg8407TQO34KbIx/3Zh7LTVKZLWRCPazPtj?=
 =?us-ascii?Q?hmEOB6Ylh275MiMDCjy2icLc0kxX4G4QKwyc4gUF0lqv9KUlpwTO3sW2WSCJ?=
 =?us-ascii?Q?SCSDTmHlydwih/IzZGOnl35eW20Bjpu2K9uDoYpGJaCCZoVOmZuSrtbpe1RT?=
 =?us-ascii?Q?YSILRiJYqv2GjuZUAtXw5ewfFcPPAyBRWsM634++Ol29FC8lrumZBGkli9kF?=
 =?us-ascii?Q?ybLeAcb2CBfryB4Y+oweWcVBUKHSRSLR9Y/Z3WJ/w3P4wvvz8reijizN2t0O?=
 =?us-ascii?Q?hScvpplvXbZHoLTxmau8KiG8dZIFIz0K8YzcfYhIXmYvR1I1m0ZhaLjF3aXM?=
 =?us-ascii?Q?ByFwg+SvhGJBkCCNVGWB8eOpHWZywfbSTgtlzqx43WweRpO8nHEdCDa2KA3h?=
 =?us-ascii?Q?Bv0B0NDAQanJbRiy21Oidv9Db/5y5C58IqkzYp4tF0WrZKiS1wuMEIVO1wiE?=
 =?us-ascii?Q?F3jOAgau/CRCxhGrbGlz+Dq3lD0WuRrXxZgXIKATr/Cy0A2QSvAsPNqKA5E8?=
 =?us-ascii?Q?+aT7XaEX/eJ2JncvdJN8TPimQQlWTp7+FxDmcfmeOjSnoo4XzJApKkMRJzsL?=
 =?us-ascii?Q?71zEWuT4Rll7hH/vuFT9IAk6Z40u/C2zogJg7SsIJv2diS4Vg2EWqNwuSogW?=
 =?us-ascii?Q?kpkl4sDlrV6jyrJvLlXr8hk4zcZbCR08zmBTGfDC8zFoetdaH496hp4tNmQo?=
 =?us-ascii?Q?CKcxF5LhMIzbUVHi/gWw+ob3q17gBOqqN753P7o7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5461.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078353fc-30ba-451f-01d1-08ddbfc64753
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 15:27:27.7357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggM4K5VHnPez0IU/M/42jg5TA03kaCiv+kfAJNBN95cwTCPx5OfBzRj1YhU3Nk5kCHlJzWChSv0WwiYtzTSq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
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

Acked-by: Pravin Pathak <Pravin.pathak@intel.com>

> -----Original Message-----
> From: Sarkar, Tirthendu <tirthendu.sarkar@intel.com>
> Sent: Wednesday, July 9, 2025 1:05 AM
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Pathak, Pravin
> <pravin.pathak@intel.com>; Sarkar, Tirthendu <tirthendu.sarkar@intel.com>
> Subject: [PATCH] maintainers: update for dlb2
>=20
> Add myself as maintainer for dlb2.
>=20
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9357f3a3..7270475021 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1464,7 +1464,7 @@ M: Pavan Nikhilesh <pbhagavatula@marvell.com>
>  F: drivers/event/octeontx/timvf_*
>=20
>  Intel DLB2
> -M: Pravin Pathak <pravin.pathak@intel.com>
> +M: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
>  F: drivers/event/dlb2/
>  F: doc/guides/eventdevs/dlb2.rst
>=20
> --
> 2.47.1

