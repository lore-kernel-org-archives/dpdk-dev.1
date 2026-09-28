Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A104BC9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69DBA40A80;
	Mon, 28 Sep 2026 12:36:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 38B0D40041;
 Mon, 28 Sep 2026 12:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790591797; x=1822127797;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TqSLCL6obUYaPIJwIv2zpvEqkN4T6bgmAPrF0O29ZQo=;
 b=kYplKnty2E2YiqGvV08TdSXxM6gyiz1esylZKAZCGyV9D181eQ+skv1k
 6jUS4dbU7+1vHla/+KrvvPW6CIIK1e8PP1PfJzbry3FmDgyFiMQCMhxsj
 0jcw5f3vMYS4hp3C4ue5r3zlzAa6GGgb+evulcgcNXQXp3TwuRGSkztHC
 fb082viB7JNVyrCPeou5jcgzPObTUx2l3RcNH0NZFNqFebKuKdDxqjVq4
 Kr+BUlMeLnCTk2FxX8DGju4QLjwuB9VeAADEvxYTUI42FHeqtpfpVySc4
 bWOeIEcA/Wt4olE1qIWLhtxIeJdXXvYqP9hBUgUKlZA/JUkOaN7ylCPeS g==;
X-CSE-ConnectionGUID: 1ZgFfXrXTWC6LZVEhX+o6A==
X-CSE-MsgGUID: nROU4rpuTn+fRG3ZVJzr+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101945639"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="101945639"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:36:35 -0700
X-CSE-ConnectionGUID: 6HEpoW/yRYOnTPVGKyb3dA==
X-CSE-MsgGUID: uj42lrtxTLKhs8Bh47lLvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="274245597"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 03:36:35 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:36:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 03:36:34 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 03:36:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zyj+UfiIJqs1cUnaM9nQLNXcHpBGRYm9pHYFqDqPVpjILAt2djxkh84+8ae/HCAAxaQFg0E12gskosd9YhPl167I2QOZ5h97DQMZqONAGjRztOuVVTVbvX67MKCJSQrRsfzf4lHQF15a0xQfjUlsd++OZKvQvO6irBiV+CSj4ClUY6ftck5IvtzaPOi2roPifew8TJzNUpqsyp2w4SDIC9v1ndFiqZOo7GNYu7WnIN3QYG0qU9ktmDjVsIagBZCXjBiTT/sQMlJqxDbo4+XDhdxrk0pi3N3ZtUuW8kKhECah/h+jxHuIK5quv9AYBppbfkNLK5VkhLik/U70r9RDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt4iLa9xCc0Qr1XStOsB906gEhIblSusnM+HV58ET2Y=;
 b=loQQQVQ1quZ+9aeCeXoyBaLSVZUL4goF2cQSAIN7L9/SR3QAMCd6S9hdEdMncsVD2UgYujAi3imFmS9MArlxa9W9w1zg40I4tkIp66w79L5cHmvjFOuH9lP8xFDuTRDIm/OAWkNWDav7w7ywfnDSatY5vyfsdPRsnwlWgbr63/0q1qJTsHYh7iQJY8Ka6/fbM/kJLGNBzErALHnzPbQuFAiuV8yuWI7lf9R07rjAtiK7xSECVSuLR6jSOnAG9mi7t7VcaAY7235+ZWP/v1mK4dQpxgBMdibXzB6usdfRDK5QW8RDG+LsXaOeGQOZ7QxU7VL8RVD68phGfiRHXGIBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:36:27 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0451.014; Mon, 28 Sep 2026
 10:36:27 +0000
Date: Mon, 28 Sep 2026 11:36:22 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix null dereference on EEPROM write for E610
Message-ID: <arpDJtV7jdiGfdeN@bricha3-mobl1.ger.corp.intel.com>
References: <20260928165054.20913-1-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260928165054.20913-1-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DB9PR06CA0022.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2a7152-32fa-4242-f0a4-08df1d4c5998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +AeaBY+RNsc1UwNcEp7itBkpFmHUA0F46Doc1XQiCu+y0E4vdf5i9MQ66ekH6dBmLhTLlH+ql+OG4RZE2c/x7u7MnELKkmu8LuGVDIGtTEVn1lVVxFewx3DbE8J67/DmEWe4JvEG/K+HnGlrBYY0qOgCXaeLlr/LWXqWxVFErud7sUt5lnjvzLMVpPBvdVGLz+YVDeku27MA1Bsw2jaK9fa1DGqjBoaUJZHOoliCMPy65fEEBF6Kzk9i081d4ne8pu28pK09kUzNJvweTfK/LQMQdIVp6rE3a8ZvuRKpCy4xZE++vRLVDNPKsyqMGcfIwtJ6ECV9wZYDgBsEV/Ho2iyavfyD+TKVrj8Xql4SDRFiBdyXkRTdaQ+ZBYNPF3lfmQP5ZrKGN080PCFfjtR1LUmX88Fd9TQGm15H3YaK/Gj5SVo5lrEXTo1bL/Hv3pLfNR/FW9KQ6J9G13FsfifLWnL4WE/GPGg8gI2TewmgMKOOyUUm+cNRwD4SQM27jtmInApHgfJ+sj5Apa5KGyxxsoQSqrKHUc1ZPLDPgmTNo/PK94xj3q5HIN+q9GvMkrxkraxahM1qc+Vs+Aq6EGhAeI+78IWQjoV2oXV63lAQc/k+l5L1IrXXhzouk6z0Mf25oHXmGK5mlu72nGPo0ZW9+aovrvgXSSvydgQD2BcekqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sU3xwF/Q3IXqhQ6WqNufBqRKeBL55nFhOwoDrj8gDoZNLNA+bQHD+FtdhVdN?=
 =?us-ascii?Q?ipbAmDnR6BoTHuCvOJsu47xXX6rjnEjX4PXDLM1XyljVb6hkxN9qcr+y9syE?=
 =?us-ascii?Q?A6wMaUwbGNB9KUlVjaO9Z/799rfmc7a133yz8ixVSDqc4BwB7Bxu1LRNCTOZ?=
 =?us-ascii?Q?P/qx2znfFOq5DpNd2hUqttD3rKfXrF9orBJWrMpdH5aX/XIdFVs0M2x34KU6?=
 =?us-ascii?Q?dTEDfOdtQ0+41F+GCxT4cBW/32BXfku/76oaiP+FWnM/6bm24uAjMXngkmy9?=
 =?us-ascii?Q?FKlZyDe8/fcUXAdTH0VpFXHpj3m5cMpi6GTdQ5O6LiUw6UYOS7UAPN9Movz6?=
 =?us-ascii?Q?jeG28IyPlSE1hac5zq9WtUPwq0C1Ejw+lc/AAzNqUOWAAtV1wKewaaoD4lqe?=
 =?us-ascii?Q?S6LhLl4vXiek5Vydbma2HMqKDaBa/II1wbgxYvnrKB8ad1c3r2iSeocHl1Mo?=
 =?us-ascii?Q?W1jN0vSLWi4IjP/1+3mZNDxvZMug+QYjy5uQz5PFNFKU/+wR68Tm3bXoP8/n?=
 =?us-ascii?Q?6rhyeDCAABUT2Jjo6+fe51CdF8kQn+C8hDX1kOsCZtlbZiGe3BPQQ4Fp1KB3?=
 =?us-ascii?Q?Gp+NhaIfz8Gx0EHgiZYw/7FHEgkya8NE70vYcK3cCU69198sGrP5C26nLUFI?=
 =?us-ascii?Q?ZmR85qviKO4+USER9CKYI7FZkuqRkoLueVuuf2A937ZL5gMJoB3rTb3Rfwrj?=
 =?us-ascii?Q?a2A61N+CEv6+P2ebgV8s+IFSEGURDu4i6sWQJZ+JkMw8Szp/+etIFc/nVHcV?=
 =?us-ascii?Q?S3UewxtYoqcsyeVWrC8F3HweSc7J2bWeoLpKaNj9EM7K5vOyJc6FtLEwQW3B?=
 =?us-ascii?Q?vglNJsJBO3BoM5cwEWGMs52a6WeqOvVDG7HQ8hJ6kDv+fBzLIEe6+QCusI1l?=
 =?us-ascii?Q?ZNVt85C4enf/Sqv3s1oUVwCEENaUF14OKkw73ivlWhKuvGRizupihXggeOlf?=
 =?us-ascii?Q?RbwVYEG9+ZhSlSya5/PVKn9P2lSigKNzOTC5cg7f6+CiVfjucOBkZheOidpP?=
 =?us-ascii?Q?KXsZZih0p9xl0B0JQptoIVzRIw4HpN3W1izuNxUJ60Y2/lDz4BgY1JMiR4sY?=
 =?us-ascii?Q?IWubXFSuMfU+A1CasAM9yEt+aadZautp6vBwcxa6xNIF5VVK5veUN6okh8NG?=
 =?us-ascii?Q?a0o2BdnF06i29oyygUpQoXeN1+lRV6gKgXSBnmksHVF/UA0ANx1CvMKruEQz?=
 =?us-ascii?Q?FyWIOokxuofKeuNDWVMd7DqiQQp8PA1cDS8OsIaAdGEbaH47e+pn9NdGd3HB?=
 =?us-ascii?Q?IIHsNeOfDqJ89UhL1YC6csu3iAYRUemnlvA8WzK5DAv+QMIrAGxEQFjvQ/cT?=
 =?us-ascii?Q?qi84/vZRQrg8BjWejM+rshFDBMsyRkP/6ljvqu8KjLfNygjjLfQIFfamg4S5?=
 =?us-ascii?Q?OneXTFPDsYm4xYg+KcmWgO1+ZVHK8sIrWJU/mGdojkOfbP/FHZnJ87lYt1TE?=
 =?us-ascii?Q?xCHkCT62NTEzyytII4sSag5mfkCJQPcqs5HeiuDU54QWdkOpx/mqKzU68ylC?=
 =?us-ascii?Q?ZVKTMRKuspV25CLXDmfY4Xsgwg9UTVlJq/JlmJ2deLkCg9mW0CBsBFPRiPZH?=
 =?us-ascii?Q?T8qwdagHT0tu1QDFl/YSxSX63qqz7HKmH8W1Ey1/cfvgeAzJLmMrGclfX32p?=
 =?us-ascii?Q?eVwZg3aeCVuRH7/PV3cMAgZk8+CCixRMWsyiGw5x23YFeWA/eNHYBPAYRRb5?=
 =?us-ascii?Q?zTJRp9m4pmdK6n9/MYeNm7DF/cIeyGFsz2RLpkYm58vuDEk5Ph8EdGVozKBk?=
 =?us-ascii?Q?SI+n1WidBPcaBK3O7wW4is9ySVRP2q4=3D?=
X-Exchange-RoutingPolicyChecked: LXCLq2CoF6UBcAR/Uuh2wzl/XpFtbEHGLzlc09hmVdjHJaJc8OEQvXOeYerS0AtUQK3XNSu9rk315TT3Qj8FWArhZI9RXPULmGvYKH2Pgk3sq9pSPpIiuZZs87cnbNrfNuPuEZ6SMv2hmFhl2/66OSCJCzld0ckhZib4DN9NUKd5u47ElvaUwCzUKkf9fvq+ixkjs4ZA+xEPbtn8xP8S22N6SgvFdVVLYqYPLaR6Za0LImFhTu+4tnmtlUsTQyaWAF5rY9eruDtAlJwq7ETRn/qqw1B4zjA59c/YHsP9LBPbsUVbHqcVqSkDXAKW65VUQ2VGcy8VspGnrqOwnyd4kA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2a7152-32fa-4242-f0a4-08df1d4c5998
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:36:27.0878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRpkBPqboFrJUCvHdqc3RNngUIxrb9ANX+l+yh03qU0GieArLtL0t66nHhmSlsN1yQyT/5xvNcz0D/oWk3HEQzGS1kktxYfRconJyQn/9xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6974
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

On Mon, Sep 28, 2026 at 12:50:54PM -0400, Sandeep Penigalapati wrote:
> E610 does not support EEPROM writes and leaves eeprom.ops.write_buffer
> as NULL. ixgbe_set_eeprom() calls this pointer without checking it,
> causing a NULL pointer dereference when a set-eeprom request is issued
> on an E610 port.
> 
> Check the op for NULL and return -ENOTSUP instead.
> 
> Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 78e19f94c0..c653951858 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -7370,6 +7370,9 @@ ixgbe_set_eeprom(struct rte_eth_dev *dev,
>  
>  	in_eeprom->magic = hw->vendor_id | (hw->device_id << 16);
>  
> +	if (eeprom->ops.write_buffer == NULL)
> +		return -ENOTSUP;
> +
>  	return eeprom->ops.write_buffer(hw,  first, length, data);

Fix looks correct.

However, I think that the check might be better moved up the function. I
would suggest putting this check right after the secondary process check,
and before the arg validation checks. I don't see any point in checking
args for something that we cannot do anyway, so on bad args to E610, I
think ENOTSUP is a better error code than EINVAL, since it's not going to
work even if the args are fixed.

>  }
>  
> -- 
> 2.27.0
> 
