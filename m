Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F672CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 12:54:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C430402BE;
	Tue,  9 Jun 2026 14:54:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D9DFD4025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 14:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781009649; x=1812545649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9cB/KrDhozcWVM3b+44GsH0Q6SvnuZYBf3Tiju4JyEY=;
 b=dLBPDgVCWDIwT38t0xvjidtKWIES7n1sO0GsZeLLjXISUddUsZWjLE43
 40x+IHb/CPWNNLLcZteFA4zZtpPe2QxelGIQJAxQ27MUj246T7LmcctD+
 uTDvi994NY3FaLj1nCYLzJ/JSngRVxruB9E2bwdYreu7T+7GRYxaaap0x
 icQnUeKNLcTEFuxlHU1BZ1Lbvn0qMgZrkVkLdVVOC5qtQEfII+pIEatsI
 cjnGhiRXyC4Wf/tHQBXAChtYMasF9kU1wP/6PyFMseWTxbGdoJ9iF8RU4
 IWIrlIBhrRMa9RNgHKrsGTDWqwGwoQiYc57a6LdszmUJpowV2GDP9d4eA g==;
X-CSE-ConnectionGUID: XNXtYFcTQxmVjLuA9gZXLQ==
X-CSE-MsgGUID: oW/LAepnR6C66DMdpu/Qlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81953982"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81953982"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 05:54:08 -0700
X-CSE-ConnectionGUID: f6b0Y4R4S3GsZFQ4hVVcnw==
X-CSE-MsgGUID: 7qcjzOl8SkauKS6mtR9FrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="245704560"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 05:54:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 05:54:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 05:54:07 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 05:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLgwWczckcvaZUAp+DGzXfSI269d4kf8hewzJ6aSESgEoBElE7rdGSF1NcSlUqrVRWIABTEBbhpC0D9whQIUBk150yDkpfztd8VTDLwG2dqyg0IBd8KuiPkV8btAwFH+XLmKPhv97PCZyoFoNVjzw5XplKCwtGf7JNqjJJ9bAP2pYGn4Q9slGZLORMVJaxIhLdhPM8l7m8DKF+rdW7F7AYIQls1YoXpCGZQ8LBdH+vYr8jozUy4CjNBR8tr8CYgYGiqefZ9r0kyCc+Jg/q63lBlegxUvLjZkbeggOU18UXkPqLUSHfB3s+Y5LOxOiQiwiAtcW5D2vcEiScvnHY4vLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMxNG9Eh/ApVpVp0jzJQ8USJqF54FOvqdAJ7nlEgPrg=;
 b=RZAJhKS7nMJYsYaZnwQgess+D3TyEED2DWcXMiKEcBgo0h8zdgy1pItDitL1LCVN92kvDhhkHGTDEovO76wJRkAdZ1UWupqpPBK45d/JrmalmRG3dlYyvWcz/6iDNPgAvPPC1qRyW9KmIpJEXaSnmOY0WxTLxgY3sR5PHOEJKgFhe3UPfriR3atZDeeb96iTuNG214lV3G4aMzHjZxsfQfuv4Vum5ZVNxc4nK/Q9cko9p8RKrolIH7bKi/IB2cwneNky+dVULmt6xnYgSNgFv+I9uDne5AiogVJGkYtG6APgEgRq/WsrmsK03fpebG7zm0hsItaFC7+B4AKNi1Jzew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 12:53:59 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:53:58 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/2] net/ice: revert fix link up when starting device
Thread-Topic: [PATCH 1/2] net/ice: revert fix link up when starting device
Thread-Index: AQHc82YhYO4SQRBiik+5WKkz17Yc/LY2Ju+AgAAP8sA=
Date: Tue, 9 Jun 2026 12:53:58 +0000
Message-ID: <IA4PR11MB92781E45BD9F1987BA536DDC8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260603143407.1108527-1-ciara.loftus@intel.com>
 <20260603143407.1108527-2-ciara.loftus@intel.com>
 <aif_MR9pNjdT9S21@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aif_MR9pNjdT9S21@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA1PR11MB5777:EE_
x-ms-office365-filtering-correlation-id: 559c642c-bab7-4b84-4fff-08dec6262c5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: Wc3jkTJeFLXwEZWSKSVnln59Y9PquQs6lU8j//CV2kmBfMdDSEoAojVhvg2U1sDYUJqkuZlHHwF9oEHX9erC7YQRGLWzV9w5oOwFcZsJyklwfaqZ/cs+s8YYi/T4p9TVWc2r+l6kvjflDH6VDjr1o3pUbcl1qggQawiwTm5GOfhAIp7UWKz5htzvJ16LRAUqLO1x8ucp9Eg9bUjtUlFvkGz/NltmWWV7LSTlEfEe1m6Vf+8EcuRKTYZqGQU1m3yfiBUT5BtfhinLF1dOGtSNnujNzjWtpXnMKF3l7o9oDuWmhQUJ+uB1a4LR5OkpG6IZi/jqYQS4H1tHT6x3J43OROxv/LofgVOCp4o15rzhdPh8X6g9FrltRGyuLF770V7bsf+iH5A+nGi3Ru8np9LVbMmEI5rI/UmtdupubaSUBYIanRBQm/btaVCA/iyxbznWQwD9E42kejWfdLpiSdwFD+PAiYFhieyItxxznIyvDdt775fX/BJzz1pBgxWH22NbF4LX/I8S4Fzjj1I5gl3D3dNy85Nx7AqOMaTPTePQKiyuqWptLIdriiuubHObgQVuziYKu7vf849I9FuyzttXSoPUoBtgyGoOTEC5pI2tmgarjj+OF5S4/d+aadQy0lRO8E6vwOualdo6A8OeDCFvzHKXVCn2f058OIGs90m1DK9n1TvLkkdNsGOlbwANbiQvfiTeOqhdGkp7TeC8UxM+kkZqa9kMpX4zjG0QcRl4zsJaWOBLyfy/auMZdBcvS6nL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6D+4eKYrxagYU0uS+jpsmG1RSOTNozh8H2FAvzdPb/hjHv5DXEhxNCP69RZE?=
 =?us-ascii?Q?qphAEccfAT8NFmjVY6BKZKO7sGA1qqUDP8babc7vTyz8sJTNOc/OWJEztYud?=
 =?us-ascii?Q?+eMKswv9IGG51YmFWfjTSyfIgobIk6wSjyOM/puh/XsdDhOuAg69ze4oWP+y?=
 =?us-ascii?Q?hCw1CqvhDYwApnMXGAgNOEJ62hxlHRSBVWFobOchGkl51EdqbvWMH4kXXQ31?=
 =?us-ascii?Q?AK+Fg/uHJ6pT4tBwJ3mGzuGSeMsdnO7vLLpS6fM1itqiMwhBL6Y+TUTCh2nG?=
 =?us-ascii?Q?Rnpl7Xo8vCN9pjtkqB8Ty2LLVkvOMHbuiQMirwqBYPhOMzZJqBKztCd1Gq5v?=
 =?us-ascii?Q?dyY9zVPQYNhuusmxIbSNH8qc+nb1+X1J++x+nIh7tbx6pvZ6B3pAnKidgGFs?=
 =?us-ascii?Q?Dlo384uZJHVKTUjP0X1pc1XLqWA0apMwr0tCFrzOis7obbJjUfsW/6N5hBW3?=
 =?us-ascii?Q?20fBny+0KwrTBc1u5kPH+9em97aMmVmhlxHiUa+W6XWGx6MSjJIi9wGsjRX8?=
 =?us-ascii?Q?KgiqZRxubRWqkLoJKZ+ReAqsZBedeCDvftWVccE6NX9OGkZ0+OWcIREN2q4p?=
 =?us-ascii?Q?gdTiyf9eEOCmmWTkPoXLHZcLA+AfRZXNaRdIsdHGqKjQ2Qs96jG0Aoz7n/xS?=
 =?us-ascii?Q?N29kZubqup0fbRzmbqea+FL7gfIXlmpGBWUqqXaPiptrvbgqC3I1uzXj2JGq?=
 =?us-ascii?Q?RDFKJFStweSaMrZSAMzLawAkceT8d5Hh3gsv0FeXYSKRQhYLr04fu+7u292j?=
 =?us-ascii?Q?R9bPObAOuKHuiCF9okLHxXjXvgqAVilSbr0zfWbAKEe+iLJcs0fv/ye3bhbN?=
 =?us-ascii?Q?kUlk4+TiKDeoU4ctSsulMaD4lYme0BzFgMTOXNeQSNZr7nYSoy/OJVIrENuv?=
 =?us-ascii?Q?vcHZDYzWOUsN3/91aH1UpsdJS3mm38j7w+CYIiECRp6EPA5+zr52mygRFua6?=
 =?us-ascii?Q?bzgSWt8QezHKeeL3We0DuxPl67wcJrNlBKzlQU1lLGG5A1JEz/3Be/j2YlPM?=
 =?us-ascii?Q?7y44cuGGjTpqQcvN/FI80uE2XICsP0VQB1DPRQnSExvIFQ+Tc4Hu31sVnEIb?=
 =?us-ascii?Q?R6On9x5PChO0JI2X4ENCGTHEpPbNGfNHT/luHSbsX2ZHcKXhO0uGKjRiYymV?=
 =?us-ascii?Q?+7P5JhvI9yYg9aau0wx7HLXLgHqLCBi6VuoU7GwwNi6yadgg0ObWrvmRr07G?=
 =?us-ascii?Q?FXRefBKpTiSk24OmRRdLFsEhtr6xsav4JOfIZr7fa0/u6J8g9FEROac/obdY?=
 =?us-ascii?Q?aVaSv5hUF1jtyN0fCr820wtHDeoeJu7Gmhi3WaDy44dCOZ5XVQXaCvDiBaQb?=
 =?us-ascii?Q?4bPtrYSUxwsjFFI6T06Qgzwi292teAmst6jP8NodBjFfjGNQMoI07w8CxWs5?=
 =?us-ascii?Q?K0oCnG7CvGKaSQBwOWVVqJA3rUWtmV9GMbHscGlYA8vycpEQLiF/CmgzYSc/?=
 =?us-ascii?Q?4vY4sKeoVApkmL/htUcHojeXfJDbW+fkNquL+2DcwKVQabNaTt4uj/vA1mz2?=
 =?us-ascii?Q?WXej+QnmmGGAwRt0xMPAYet89ROzFlBYcEkcWv/N43nmRMMP9dB5F9+cnYrt?=
 =?us-ascii?Q?2+Dv8cGkHX1njxpE2LO/soNTSjPYA3zb7PKqzIc1fpFnMu8msLkYdOoOagqG?=
 =?us-ascii?Q?vJeZLD2C4UNAbi99NF2kyQHeT9tBC9hbj6cd86pceRZOeNulsn0RAv9LJen6?=
 =?us-ascii?Q?FOUD7pzrwizZRlyzGdilWzpFu3LnYbqlMgOE2CxoK8njGJIz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nBVCnuMyJZvJ1cvgD1eZNgj+LIznyzLUSGneqU7Q59OMjgO3BMUsFJVajf3a2uTh7UmYe+7gCi7JXe0nx8mvz3XPsQ55jX9jQyU0DZ1ZHi98FngLEQDTRkwGoedd+0m+b09ivK2gc/VznsaQ0AfV28iAsoms6Rd1PkGV+sK7/L5hS1nEvUWkVFnVhdI1vICBxjjbmQOCONkKTo/mDPV2EP84auuh0OsJl/9g7Jw583BpR8k7xzaux7VHKB0PaS4cbbWjDAs1GiFZNZvkuSjd5qa5sPkYMy4Iy/ZE5Zoww6j5hzBVi9cMG1Z1j0GiNrxk1oY43rZQVU3yTSZsxm4Xbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559c642c-bab7-4b84-4fff-08dec6262c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 12:53:58.8191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWju0P7GmqRFB/wna1CGvhogLqU6zf7N1d4imeNx+ulbeJNd21LBFTPplQvIi51ihnm8qYcfHUmeAKJ/egjLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
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

> Subject: Re: [PATCH 1/2] net/ice: revert fix link up when starting device
>=20
> On Wed, Jun 03, 2026 at 02:34:06PM +0000, Ciara Loftus wrote:
> > This reverts commit 6c76b76dc64183eb2f24a52b90d4ff9feb4872f4.
> >
> > The reverted commit worked around a potential timing issue where the
> > link could be reported down immediately after the link was enabled
> > during device start. The commit introduced a blocking wait which gave
> > the driver a better chance to read the correct link state before
> > returning from device start. However, since the auto link update flag i=
s
> > set when setting the link up in device start, an adminq notification
> > should arrive once the link is up, which will be handled and correctly
> > set the link status. This means we can remove the delay from device
> > start as it does not need to guarantee link up before returning.
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> Should this revert be marked for backport, or is it safer to keep the LTS=
's
> as they are?

I think it shouldn't be marked for backport.
With this patch we now rely on the adminq link status notification to
correct an incorrect link status read at dev_start. That requires commit
e01265e4a9bf ("net/ice: get link status updates via adminq message")
which was only introduced this year and not present in any LTS.
