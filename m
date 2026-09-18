Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDEC982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 14:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DCD74279C;
	Fri, 18 Sep 2026 16:04:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 81F0F40285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 16:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789740243; x=1821276243;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ytipvnps3RGpGYQGAPbM9nfeqP4kA7pjR05qXUO/vBI=;
 b=ZmF1ltTdk6MivM0U5DLzRdXmGQG3NN8+5ALSfh8oS/OyUg1uwEtXslY1
 QgcGYb/0JKF4C54ONCsSL51Gz3TW/GQMN+nT70d4dbWHQDwVwxqjq/so7
 kFBInf6C03T3ksznPcg4AgrKLlDFHsN7przErvbdSjhh5ZqYvsNjMysWV
 sASaI4EMWLywkaIPmLr4YPFCB2pbSzVVTywfJCBPhMEWCmIMCtlWFGvH+
 NgRsrW2Ax2ZLll6982Um4yyCn5tg2OUEwzr3YIP99fEtIsWrKLjuPr4Mo
 FpR1c/9svXX2BV7U9dG4Rp81yCOnkPjg0Nl72Kj0Vz8YpnGaO2Pk9i7R1 g==;
X-CSE-ConnectionGUID: UvPeyWvgS8iBYjtj9vhxDw==
X-CSE-MsgGUID: K5V8LbFIT8u2SHVhDrVYQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101596335"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="101596335"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:04:02 -0700
X-CSE-ConnectionGUID: 6Omx3JSmST6RnIE3zJOFPw==
X-CSE-MsgGUID: Jg31+8dVRPOSu4hQI4o/VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="297880661"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 07:04:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 07:04:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 07:04:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 07:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI2Zra0NhLisYnlrGwC0ey2rX8b22v7LbmkyhdvsZgrVvofKbN5T6S/l7U14Tdb0tAgRO7vHAEfi16YWyttDb6i+a5yzoZtFyHeIaUhBPoxP6J1gvTHG1PqeyEwO/ShcxRpMzhnLRMSTsBbw+hmq6skMIR6adhRy/kT099JZU6jEnK9nmHg2Mx0pzxuB226ErrtRpRCqbtVdq7zzPXKuT3/DfM9kQWaKKhskgmVUJvyaj9Sa1c5JxZVdKtS9N2YhLRFclqGPCsG7Bf5vWKkp6eFeY+JumeVkJcPIEwYWeWvrhshBVbFFdo88ufjZ+QAkYZ/PmzIVet1CH/1LUZSRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCWMokhgFgkmpCtMSZLDPCoLd8PJEHysOa48cO+DZJc=;
 b=EdPRlh42Md3ZDv3/ZrQUBDMW7XwQe7MT0WlG4cfEvPrgjjlxnvMdUg0CSd/uuG7NcvwP9pXJl6mk9TFNQIdps3claBtUf6wxwnPIaEH1lT3gR4BI33YGk2r+VgMuAWffEzNN/1gxQKggTIYyvsxuXlLQbZgIPMR8aXctM2zxF8T+jt9ym0KmY5SMoQHGDc+N98GhKKKHifZOlpSBkCHGJwJmZKVIZEN7SdJAuxEXykmSJtsosLjn8nGaCGDKi8IphzKVMHzUE52E4jI9Z0l7/4Pnps97mIzwqBT5FlDYCkNR07QBGn1SK6py6TBt/CNMalRiEMWimZGPpONQ6PaRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH3PPF73E424DB7.namprd11.prod.outlook.com (2603:10b6:518:1::d2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:03:56 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 14:03:56 +0000
Date: Fri, 18 Sep 2026 15:03:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Radu Nicolau <radu.nicolau@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Qiming Chen
 <chenqiming_huawei@163.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix resource leak on IPsec init fail
Message-ID: <aq1ExyJM8X8qKwxN@bricha3-mobl1.ger.corp.intel.com>
References: <049b6e36e7303a5f5c9ce96a3bcb116fc8c25af6.1789461413.git.anatoly.burakov@intel.com>
 <c0085431-fed9-400d-844f-02fb0d8bc363@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0085431-fed9-400d-844f-02fb0d8bc363@intel.com>
X-ClientProxiedBy: DB8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::37) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH3PPF73E424DB7:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7a7292-4d35-45e2-898b-08df158dadad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HAq3GqSDRb94r3JUL46P8cmmvCPJGqTMk58uNKRGqmCaGbZKXHJ049zetQH8GeCoX3p2G6TSIma88gITIUHnLpkXtWQI4tP+q53xTUeQasenkb/KoyvydtwUz4RJanLyRMwEFFe3VWQkPTgzlVGbAktDwl/YGNjmB6q8nhIVR3USLFrokdQQ+FjQO+axN2org2o8vqUC/GFoIGIQbxqNpp9n1s+qrJGPFmrveiI785A4WOA6F2kVmwyNl/7xbzpWb+tvrnxiE1GisMAwmIAs7AoBJBpW0Y+xNGrLzPiGYBQCPXT56zNyLh3dAcszKJLZw2YMO0V04/SbuQN3zIlF1Z6ORdiPu2RyH0N9cqsQWFqHOggRvMvj8A67omWaX/Q4IyocnTCPywNBSEGvisa6XcdgYKHC54BUNsBspPuhVKrwU0qOV21HYl9o91OvhMLIiUoBH0sRPZJBSVYiTDx3Z/h+7vL4fHw8JMHEjVfdYiYkYLiBtMLfd+37toUg3yXfPse+hZk6KWg10HRUFreFLOADlA5qLTv3JFQvFJUm2p6ZI/EcWEFfd4u46kr1AOG1NFrI38PdgMCUleFV82cNnCG07VHKUV9GLPuICx5YJuYKfaTQJm58MGzcZ5vAIAx8uRzssa+j8a+xycl5M7lqMvdZzbXTw0M7+w0IoJXJnOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZNIOqPbgxoFRj7MTm8YadtdAKWi9EgzscJ9VpBgTaRYFf/aW5goryZJDuos?=
 =?us-ascii?Q?eMfAJw2x1Icnz0XyhPsY/KCIVlQCFE17jKuHQxOqUfZ3zg49/JNg9WtMsLdW?=
 =?us-ascii?Q?fDYKIgqpvG6Ya2+wLwtngduk9AQQeRb9eqJ6TDBC7fs1mbXu1TNBVkQySLKJ?=
 =?us-ascii?Q?SyMSZ6xjuXNxhjHgv746pIb5ATbNodJDxoxT7294eoSqN2MSTzWvIJNMO2UI?=
 =?us-ascii?Q?1wvTY4ezGNaUSbETOVPSGllsucpxvrk5uJUIVIqplZrXxyRFGVXy1UXvuckb?=
 =?us-ascii?Q?LeR3+xbfjABColAbqCUbzDKZNL3n/RJGD++on6MdtLfLNhfT6T9RHQdfSO3h?=
 =?us-ascii?Q?zERWkUSzZgeIgDcloXq26ZGcZ2uep1gFwMBebY/ovPOWJVy6J1MUmOa3YMKH?=
 =?us-ascii?Q?WdG1CXiJbu5MrW3+vL1QdkJhMLmP+RIh+AhQE37OTr03gYgXNY4U1RUqDoEj?=
 =?us-ascii?Q?v9yywZlpJLjDf18YEXJZPM0JcFMFoDcaJ8Wbh9avrWE93D04gN/bdxOQ+yEf?=
 =?us-ascii?Q?vk5yLi7ZvdS0Bd57Jwl4o2oT0TPZKOA6VfZdtNXaAx+p4zmbPCkHsFrqDXnf?=
 =?us-ascii?Q?MujILpFpAdz3mKi4ejP+uiccSnCd1jq2M2jHKw8NiqrNhlbnvKmkD0s5nUXj?=
 =?us-ascii?Q?hnoo3EtcRPx6fhn4B4yJEIQXKNswKSl5pw1WBrSPCCIDid0/nLKJGwOGzTrD?=
 =?us-ascii?Q?84ADl7+nhBK/nzVH/R5k37qUIwW6A2GTX0V47F5aVXKilkoyzRH3IL7DCasE?=
 =?us-ascii?Q?szCbh29Bv2tE2i9CzZzg0tFvAtfagnNcCSNehBOM1KJKYSr9tck2Sl3U6Lg0?=
 =?us-ascii?Q?PtfoWSi5yQLimU8PcZtEv7eE+9qvduUKSyPm/w2gUbXdYO+ZR1/abi2luYds?=
 =?us-ascii?Q?FoZyYWcFhWOmNPLSQDYf8aHzntCXT/N+sgBarzm6dcEApIWN/VQ6u9Ar5IiE?=
 =?us-ascii?Q?nV1RF9SH7/Kcq+9oNSYq6sSnmF5oiV7upR6nSVan5H6QiYR4jdOK5v75YWg3?=
 =?us-ascii?Q?VoD5eP+icMymwMWjrQWFx4JfTPON9/P4kQ1t9hVLRyK9F/sOv2PQi4HDYJF/?=
 =?us-ascii?Q?DoEcc483fAGfLbmyukXXkP0hibrkVe7I5frqnbChbumU8K3itcVHDtXZWFvG?=
 =?us-ascii?Q?A06YbSJwvBw3LxzckBwy9Z0lc5nTF1uGBpnqweGdFffpynQtHNLrOwPTc9b4?=
 =?us-ascii?Q?YNVXcw3+JPaT9Qhd465HBiUel+vWnPuC2UWjCi0mLGwU6bpoXv3xxo5juFjL?=
 =?us-ascii?Q?vW4eb/dG6bbXsYrpWK2jXBHw+SJhSiChJbdVzbtf5ExrrWdydvjfaG1L03nz?=
 =?us-ascii?Q?P95rYd29GuhEil9jid9gHtzfS6G/NypsLoA8/DxlnwVeLyJlG1hVBmKqK3ij?=
 =?us-ascii?Q?7O5QXYVPthMLEaNxtG1txujMK2wq3kJ37MbcJaEUaEQCVPneRbwjT3h01CPN?=
 =?us-ascii?Q?Dwh85P4aKPVqvUQYnM6+HGhJ84+MsksSuE71Ct0/dp9FCgCNog70e/q6pT+n?=
 =?us-ascii?Q?E8Kw8CNatVMGQgrRNfnJe8pKyhQAbCWK36b1ixTQog95PJEdHSyZcwnUeXhD?=
 =?us-ascii?Q?O6X9fz+zasjtwufRwvRjiRR7C992xuFSZI1ycHL3MoyREy1SgJhPR3+6V7zn?=
 =?us-ascii?Q?9OolA5V2RC/I2FroBk6j6Dz6K8O6zRRmNKLFXhPPw2UfpgIAF57MQuS5PDZt?=
 =?us-ascii?Q?ceqyKydvOd4+RyCfgZ/l4NDrNCHRmIKhtv0xlEFhekfIXZQcN61I/WhXiH5d?=
 =?us-ascii?Q?PqaVuZoj/6Xe0ykHkxmDQEOTzBRQl+U=3D?=
X-Exchange-RoutingPolicyChecked: Kwkzi2j9ZJ09HDgADD7X3uKSZFjBEUxlr1ow21Uonm5ZT0FE8G4TQaekiGbdFK/4mBIhBIq1q11TtQSralSQiHqLauloWhdW4ptCPR+jI0k6uMEqFcT1IzLWkzCpiv0JOT44rYt2dRMC2OIYNWTRjxIK8EepKHxpVQguZuIncKsWAbOguXgaw76xAgWAbewBB/pq2RKBfpbIcFH3htoMCd+QQ1BCoZlB0K05svTHFHFqegRXRze8r+ux8ifaTGqx9zqrHs/mqqKFjukzPybT8Mb9YrOlWx1qEfKRMbGne4XmQLVbSc3biPWAFbOhWebjDLkkm5+izH2uFhaiRSR8uw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7a7292-4d35-45e2-898b-08df158dadad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:03:55.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c85kn6B0bJpLwb9fkPJ0yVuWyf1h6tnJI/ZgXYWoWmZ9MDrR8u4+tuHi7Y59F+VZH1FW6/PxTElxWso1/hBSM/46vGXa25lE2+uztnasZ0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF73E424DB7
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

On Fri, Sep 18, 2026 at 02:59:33PM +0100, Radu Nicolau wrote:
> 
> On 15-Sep-26 9:37 AM, Anatoly Burakov wrote:
> > Currently, during `dev_init`, we try to create a security context. At that
> > point we have already initialized the rte_flow engines, so any subsequent
> > failures must trigger flow engines uninit. However, if we fail to create a
> > security context (or if its initialization fails), we do not uninit the
> > rte_flow engines. Fix the code to do so on failure.
> > 
> > Fixes: 45570d7e4439 ("net/iavf: fix resource leak on probing failure")
> > Cc: chenqiming_huawei@163.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> > 
> Acked-by: Radu Nicolau <radu.nicolau@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce
