Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2091D49232
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 14:54:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAF944028E;
	Fri, 12 Dec 2025 15:54:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C7B1740268
 for <dev@dpdk.org>; Fri, 12 Dec 2025 15:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765551245; x=1797087245;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IShMmtcAJE1rFIOYoIxFBIMq6APtdOulf8dq6Fe/rSQ=;
 b=bcJqgAYg0A7cml7M8NIPTgWms44ytToNfwzfwUhwv3t7rO1OitZFTeRL
 lnDfeSHzT6jDJVNLqmsY3zdmuhgTTvxUwG244N/2A2FzoKq58Sk6Kbo/J
 ECSuXjDjqxTSRBtaSlfWS6BCSUKv0GME8aQ8fw5Mj6pBAK7WIfovQeNk6
 BuBI5v8K61nPyNVJ82a+78mXrVTuFCFCFO1Ra0AKjsOoGU0HlH/fe8Ju9
 CgRpB6heVbHZOQ9jLf86msEWU7UwK07cSG1m4FzT5/Xw/FHdEfmBpewqg
 WlzeoLrsfsrWxOHIf7vJdLJY4BjbbBvM9/nvl+0uUFK+zz1/64aSv6HNT w==;
X-CSE-ConnectionGUID: TyaJyPLFRsqQz9gz7AbTbg==
X-CSE-MsgGUID: D9v24efnSUq6KAhwfWbRug==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67712584"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="67712584"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 06:54:03 -0800
X-CSE-ConnectionGUID: SbJAlBjyQXmdSr2NYMQpPA==
X-CSE-MsgGUID: um/zlv3xRc+eiJXfBnK43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="196389167"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 06:54:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 06:54:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 06:54:03 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 06:54:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhgWOuZ9mFNlg0u0zKMP73bfv21lAOH4eFQWFnORRQTJYMrTnlxDh2NVsaM7Brwi3A9AptcF8YHa1jA6nVDxt+mMfygO4DsdT5JgKfHCp0CxXsYYFWZ6DcrCBVXoqes17i3lsqARo+vXucJSFeOFWq9EBP785hMdSmCgZxoPjXkkq1T6SuG9IP9ST0Fl0dU9PBwi7N13YV//qMQdNHjXGcZGtr4rEpMt4RWx2BM1ZNtTjFxKzXH301dxRowd7tw0uShwpdTJ/0YF3wqhcIkIbwWhxZzb1FGrX/28VSfZYbxGV1D9gDKuLKfwDxMXR2xC40CEsa7G1whr94HyyYe3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmvpBtQa1esSDgAi8ReqLEBvyXXumCf1YIlrT5nRitk=;
 b=c4KJi5havt69lLm240Ib5Que/p8Ix8n073xOcPioXvu0dHHP1yC8bs0XdmY6vbqYf1uo8craqmruuiGLBMYEQVdZbCL/XB57/L7YrhGS/0Q3W+tnd8f6G/Ebr88BybdrerNxWXdkFb7YN11OYFwA9f3MV0RDPDCmuMuUclwYHogi5ya3weqgj3TTw/gvrqfnH2VkfePaD39Q1gKX2vDtgaVGnaZqdRP+ENBDmjMsL5w/WXA2c7c+sHgoMDVyG19kjpA4Dg0A1ZHuetJrKFk1cZ7HkPHm2Vjqu8cMYjKF1ZSroShdaRfx9DZp/iRazPJg1OQTIQVV7JA2jyTTwUonoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF7DB70F9CE.namprd11.prod.outlook.com (2603:10b6:518:1::d33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 14:54:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 14:54:00 +0000
Date: Fri, 12 Dec 2025 14:53:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 04/10] net/i40e: use common Tx path selection
 infrastructure
Message-ID: <aTwshChc9uYka2B0@bricha3-mobl1.ger.corp.intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
 <20251212110628.1634703-5-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251212110628.1634703-5-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF7DB70F9CE:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adbdfa5-ccf8-4f9f-1c99-08de398e4908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LwhAbAWVD48u41E6S5VX4OG16Nsy37Y+zO8VHXZkXsU6RoJKk5VtJdlregKK?=
 =?us-ascii?Q?/bMkldyqiTNjAbEKAVlfBIqhISMiN+eTu+m9go/w6bXkpAYzsDmpyy17L7r9?=
 =?us-ascii?Q?qyrq8qXvr++f8KzeAg5/6xZbb4+2eNzuX0ex2YcE7AKPy+qAOnPnC+tv6UuZ?=
 =?us-ascii?Q?n1k2Xk4QCa073zIBDrcwXKGZ28qhUx/4l4ipgcBFu6F1cDZQaaI8TFSkt6Nw?=
 =?us-ascii?Q?c7hK9IbDwh8+HgERtJF5/trbvB/Qw78JRecjYsf92tAZuLhw9ZUbyM81w4bS?=
 =?us-ascii?Q?CDvfcLcDXM5CG4T1gzYmOmklVfWW/7qfLibWJa16R9/Wp6juHSUntOQogN57?=
 =?us-ascii?Q?WCqKSS/90DbycqlJybBzl4A9P9MnMBuD8RS2fGTZO+aH20V22Ru+AUFLLeT3?=
 =?us-ascii?Q?SgxGHu0m/qD0/ljIFsFeJCXvj2RFy3wgblAppN/NGqRlsGri2FpIio6e//HR?=
 =?us-ascii?Q?ZjNMt1K/cEvZpTBp99IMcB+eHF5R80fMHsBpNZj8RLnYaXWa81+wGEnvvld4?=
 =?us-ascii?Q?XrsWldN+6Tm2KM42L4L8c93AuEp5SkYSMmaXBzOaC5oB1WmzYix/2yRVoJtR?=
 =?us-ascii?Q?RUAduvy+SKhzi6ltAG992S3uCw/0LuvkunobWp8GECd2tbCqUonbTwCRfOlT?=
 =?us-ascii?Q?0qAVkm2yEX/ephCOMaOxsamjUvr8Jm7Az85bqFKb3PjzXDlotVXLgANjAVIe?=
 =?us-ascii?Q?hq46OfcfgGfk+jI6Z9hxH6ZxoYkBRStBLcNDD7YhL5MHz7KtWbASYQIdYkf4?=
 =?us-ascii?Q?wRyUhCdFNm/rm93e9NfEpZIm/+TzwmvDFfRSDYtOLICoMTtg9s+RWGrCkBTV?=
 =?us-ascii?Q?qJR1537xHyJ7L67UpN5NygFSxBqJUE7wIwMDgZkR++L9sqM9OETKCDSxUSC7?=
 =?us-ascii?Q?41/k6HQue2+7DgSVT7hOmw2CrFz3gkcStfFwNlQ0UEQbIN4myzCFOuJvkImM?=
 =?us-ascii?Q?XphtSSTh3Q0+xPoI21M8MuT/EMENnIRTtzxIUYrHrBorRIvR8JhPvKrpfgcT?=
 =?us-ascii?Q?0XkQ+6FzdRjEKzuEAdIr8U76BQqbnrR0xghPbcpfjIdNV62M+O5Vo1Sar6Yi?=
 =?us-ascii?Q?bhKnZHalcjZ2iiX015Qhg4jI2xQlhOTwSAIlRPBjIBy+A6VY5SkV7W8s+l+O?=
 =?us-ascii?Q?nwXZndu/+9dSoNcz+q78sWicfVvcNIEv8JGmHvgZsEPTO/oLYcq2Nbu/8dfT?=
 =?us-ascii?Q?k4EskCiVI9CXCmZsmOJSFCZLIQ4orBTFVzX+ByD6zzb/bQLIfpmPZ9s1ZVbz?=
 =?us-ascii?Q?+9QZ38oZ3PtGz8fgWNiQS0L5hmhZzuqL5S7wdj5sJXJQdJWeYURH+Kg+iTIM?=
 =?us-ascii?Q?7WLpCPFzKkF59yax5PW68cdku8zxrxC1DaaNlwy+Ue4D30H4jRTeH7w6R2Pr?=
 =?us-ascii?Q?x70D7Jm7JjEYdAsBTjtt0biHbcsaZBqEvJgYVnXLS/b1f8m8heSrHyuOflzO?=
 =?us-ascii?Q?9H2GJmYj1GjlnayK5bY7DL41vZOW55R/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lT8Qt+3ynAdC82EmJnPygEh7gLJeguLyCuzY/muhmIVYk45/8c2SzNVbLt1V?=
 =?us-ascii?Q?+4G7hQ1nh8Ltr0EgfX/vt/GDeMmpnNiv2SYV6YgAC01KBsEQaxtXttDZShVG?=
 =?us-ascii?Q?/AygnR+v+bGP8/wM8h9Jy/XzZJGifUNmxFaAqR+HgrgYRlnfjQADQprC4jUq?=
 =?us-ascii?Q?oZPlcsH4XhT3A6PN9mcTc/Vi0MtNChWh+yy2QchV49IH8dpVVzmK82+Otwh5?=
 =?us-ascii?Q?OCHK/1Bhfi0x/FFRtXdMmoxFVY8A1NGwVGTVHCfq/fVDs5rQVCgy95prekwe?=
 =?us-ascii?Q?qw4uNYq/wTN/wDeLEWupXN1/ZFxMlexPCmCooN3GS9e9moNQu0ymz3yhtuWO?=
 =?us-ascii?Q?UzzJSsCyU2CrZUttoGd/q4XEZWtQmDk3milMm/hC7Wg/wxqMl2rDq4yjzI5/?=
 =?us-ascii?Q?pIC2cYUE/xHnitapQ7anQnhmh4K7WPlfOSgzcziHxZN7wxvRH8RAPy3QhuEe?=
 =?us-ascii?Q?fzwjf7ynUK/ISoYODgLXn8eRbcPWJyWdWwjrNjQF2/AkEy9Lge5ovu5sm8i+?=
 =?us-ascii?Q?Jd+HoimYhvWzyOLb4qVQ2uSNQt8RPFjGRvtcRMg+edaDmR78mHrxA5ntT1Hg?=
 =?us-ascii?Q?3iJgMySUipqnyauNRSQUUi8800TeLi05dmqfGs8y32uXq9fJLnxVA3V/uWKK?=
 =?us-ascii?Q?YX0N7nL4I3jNOyvMY5iArwDKc/tvQMpTJ6IiKkzkEoCGGuFV2Ilk14KqpFOt?=
 =?us-ascii?Q?r0oA9xSX7YT2CNQqW/LGXHcWgCUE94tUaTLXVES9Wa8DC3JGblKA6E55Jv09?=
 =?us-ascii?Q?BQPm9N7+BH6fm2WUqCZtaq6+cHlUcUd6VhFPeK6FHfwsVYbVVbswy1tCyVja?=
 =?us-ascii?Q?rsil8CHyfUc0JPOu/gQd1EEWkyJOfm34fgxFAzPnjZbBU/HMjpVtUts4TOPV?=
 =?us-ascii?Q?s8pYdqA/t9Qa0W2N3YYcfCNizGimcsjkHX0COZviubF3MEBf6ddBTJWWMucI?=
 =?us-ascii?Q?kWwGepXldn5nev+GyXPJFgbaHo00e+1vzxp1KBONhskOCx1kn4TzByXuJsDl?=
 =?us-ascii?Q?7VBHFbBcR3PF8DEKnfKCRudz8lOt8gB5VGKsrBqD00tKMOd5GVB02uFXbKSi?=
 =?us-ascii?Q?i9uLyb7HNmDGOMwBpHeq98MAxItbAInjlrpmlqu3VlJk9pN7No/0k5t5GkQK?=
 =?us-ascii?Q?IB1X2DgEA1V2U74afDYBh6Nu6rVqQz9rZTlK5cOst0E1gN8qA+xc+rVxJVej?=
 =?us-ascii?Q?AoeGkSRPv7562cqXLjw5484S1vuL1f9pzs85UjDdTZJTWFiBVD8JCbyLPORC?=
 =?us-ascii?Q?UunhvqCsmg4FZ6gED10g6cNcuy0Tm6kugxkMTiB6pZm6ottwrS64kqEYFDht?=
 =?us-ascii?Q?O9lsVD9ipjZLnLeneOqT5m4pIn2BGz0pmlmgtYnnVEffza38W941jc2pHeAo?=
 =?us-ascii?Q?RB5T6ZdgZuxZ0UNBKOq3BlX4mELQnqbzDTJKXczuhnHhDNp6R/vp33/Xpkpg?=
 =?us-ascii?Q?me9FhC4Q2QK4EQpFGHIz0+6phWg4sU1X9GBzWpSB6mPGnOmqLG/8/MkuUF6w?=
 =?us-ascii?Q?p09MNmeWJd1syFoPNvtvvNhp9QU8VpCBtkdMBx13pWr8GcLflnj4Wdrr+Xor?=
 =?us-ascii?Q?dHEeX8qVnhi8GZibgdu+ZswQXV5XgDQ7btzQ7To1UwNc/t+igtFWdCkaOfdT?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adbdfa5-ccf8-4f9f-1c99-08de398e4908
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 14:54:00.8201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/FBLFt3Ha23F6px1IwEXjAuGRcOCzXtJNSA3ritisMdRUh3V+mjMVKWbJtexIfVaa87OW2YpqKAbueWjBNw47oG0WNmaocmqhvohzfqY4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7DB70F9CE
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

On Fri, Dec 12, 2025 at 11:06:22AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function. Let the primary process select the Tx path to be used by all
> processes using the given device.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
