Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB571C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:34:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB32040693;
	Tue, 27 May 2025 17:34:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id AC7F740662;
 Tue, 27 May 2025 17:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748360094; x=1779896094;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qbQp/suKquZiDtZIYJmeXPmZH6fFbcNcCzq9kwHcpOU=;
 b=RRY0J+Qa/MHk9ruC2ZTSUqfFV/9UaT3FyFYhWOB5wSwionsDD9FICgO0
 uXKQ003WBCy4tF9kDdKnDLxco1y4jJfTL4y7p7vaHK+hxEa7H1eNOtG44
 gGtr6N/CO00YOagECXVu6PArtIid8UP9fOak4UglxHRl5cROBDCwN6BFU
 gJESptzvMTOlBmcuk6BpZIiR+vw2SGujtD0MF6vUEXru5TARAijx6Rhjb
 VXzLSbrtHjUf91VuLM5U5mTGK7MITfU+Ud0NwYS5L2+xAXl+K/BvjvCIW
 g18FD4ftmgjXhyO9lBpu+hsOwqO3PlMp8HLh2TegbPTe9Kw79zhq4KDgk w==;
X-CSE-ConnectionGUID: OTDcW18xRwSjjQ745zQqOw==
X-CSE-MsgGUID: Sa/D+bWHTZq/LJDH1bqKwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="60986257"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="60986257"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 08:34:52 -0700
X-CSE-ConnectionGUID: 7u9CRw7MTfm3IQdHdmEp7Q==
X-CSE-MsgGUID: 6icjSZ05QpGcXVDKyVCnkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="146733897"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 08:34:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 08:34:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 08:34:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.84)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 08:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouFrMzvncHdwbvvmzYCzmE5XYKinYirFJZjL5fAVm0GfG7i24yYMfIvZsxFqFbHDF4zGAZaFxyGo3IHD0LXLNoUdG+MoRtCpuB5OLCk2JD/etytGLbhZxiq6klnYSpw55zVApBbR4pCMDd32wLwKGY6WY2ir/V8xZ3cXly0lXzA4JHEHqHIadHxJe0eqb1I2cxxKlqr8q3h8VXquCt0P6/ei9sVXjt9tvN8h1aYowcPohxd9BocYPMoqQrbbgmSh/U1e3ke+QZu5ZsQlZj1R4mWQM+G7POuDjuViqmWGfBS3Ga2O8PhiukOvuuw7TphePTBkFz4DCIwRYU/VnKIvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6QPj3kFbluVHg+qa+1CkWtk4BgZ9c5Wr8kezC+Ma70=;
 b=uXHtHp9ZeDsp++kiYCfqIBh+bucaUS8o5F+gEMtUhMo1gxGc1d4b7LVazm6iPYqrRSlSGjz7UqH1z3vk8+GKSYBV77cIbo7KeoaeDhhqeBhEa1vjO5tub2aw4J6IePGW8Fcw1oknwfZexcxrcVHBhKYmnwpTnMknDu75EE2ssIHLqmTFetFK+anp9v3Mx+IWbqthozHXXRBQYJlTXQKQCDKI3uJrJMI4S+iEiekyYD/bM4RftX0ZFa7ojXQPVHPSBiCCklGmkA7x45qpEa7k+cC1mSe6qYq70RhW46oLAxNLqJTCIg/Ht95d6AbPfFRIB4ULmvbwJDSFsyCmGpHnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 15:34:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Tue, 27 May 2025
 15:34:49 +0000
Date: Tue, 27 May 2025 16:34:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <techboard@dpdk.org>
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
Message-ID: <aDXbkyi1BsVj3M-L@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250527152913.279011-2-bruce.richardson@intel.com>
X-ClientProxiedBy: DU7P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::34) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7a08a3-306f-4b67-efc3-08dd9d3403e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mBA8elAOONv5qYk6sqEF0l9ZyUU2TYiMgJwua0wU4AZ9JxlRt7jwHLBOUcA9?=
 =?us-ascii?Q?DK26Ixo4jItTf+uappCpnNBU2fghBUMsYfcJ2Z0uvSpxiP7aTDIMk2NtKZC/?=
 =?us-ascii?Q?hdemwlZrpZ1/lyqtOZOZJ1XK74+UxehhlHU8h6Xlt6tYsAzNioVQ5fhsz1Bo?=
 =?us-ascii?Q?4XSka8LXV6vFFQzQgWUm6mJNp3WBOJNmSXq2FKzbIu3c8AM7/fncjWLzQaLK?=
 =?us-ascii?Q?0UCkkecsEPUxbgqXHgoPfqD9DkrstK7gSARUbzlWp3q9OW/OoMJBQpSjPdo6?=
 =?us-ascii?Q?KJ2vxVcuValm5cBEmqUW44ajrXS88qRXgVvMezHl+D3XSa+0g2dhgGcJWiIv?=
 =?us-ascii?Q?FZs8Lo0gDc5PoHd4I/A+2BcbQr7BjZKVrq0g8KlAK+NfvK9dK33XbiH+Jf9m?=
 =?us-ascii?Q?GXSnhESf8v22f8IK2FgZEh3sElVM2phW7eD1+o5wTY4IquZmf7kM3vaS+kH9?=
 =?us-ascii?Q?jkz/dqDGW+tLBz82sRLImO7Yon2g3o5ZM7p+XFjajHhydem7zZvoFU5D6hFx?=
 =?us-ascii?Q?059hBfyb8AVUP7nGGSXrZQTVbXP8M3PXYRJfoKyLtmXo3EbfdfbuzJK6WG12?=
 =?us-ascii?Q?01FroDPd6emfZKzzpU6ARF5niKHhmbWuhsqg0mz+75FtGcyPobqJ8/LT4qFz?=
 =?us-ascii?Q?h50kpG4SVZfC8YKREFn4JtM37cv9/H6FKSrY+liW8sFLEMMVHiTFXDW/40Mi?=
 =?us-ascii?Q?4/liRQabOwFWC9OPQePlawW/MAcQr4uxikUrSICFubVMwj6zLaZewYT/04lf?=
 =?us-ascii?Q?yuTkgp4XaH0BUuRLfeXgP8ocVQdRPdg1dGNB9eHxTDIa6qj39rypH9Np+NFI?=
 =?us-ascii?Q?2J/+DmQ2gbZntzL/FaHAAGTD0GWE8BUdjVTFZmr9cPmN6e9xrGfwyNw556rZ?=
 =?us-ascii?Q?Y115OmFfTZOKnKQUV/9qnvUDglYXqjsyGPk0C72JXlPf/VKONu9SQMLNvHkN?=
 =?us-ascii?Q?V1QIrVanyVcPKo4PQqzlzMKg0ywVsikIw7GJffT/R0S9XhGQFQzUgrMSkWMs?=
 =?us-ascii?Q?Qdmind5urN5GFZc37of542nZzcsLhTB9pCdq0RFztepLUrf6MpwmuzjvJQQx?=
 =?us-ascii?Q?izdoUrCD784FgYumECwDy85k4U3CVyzoJ0EeQhcoWV5iRJipfV7Vj6sbwJ4P?=
 =?us-ascii?Q?ecE/BgTIlUvW7fvLL4RnYzQf1D47wBChW2NPhOzHx3ynxOoy657T2Zh7ww0A?=
 =?us-ascii?Q?bLFxykNvGiRN3mS/K2YSYrFJQnog0yQhAr2KHxZ+91ug5eroNAM8nKlVf/Xw?=
 =?us-ascii?Q?J8S3aaMZp1NecUIArm4Cvnb0l+4fjDnJ+EFRPjj3g601T7r+5lc0O++zjZTw?=
 =?us-ascii?Q?Gw2olutfgr1yj0LHMeC+Ff8T4t1X0spaMnvTOxBwAe5/ibu4SDpIV8Geemkk?=
 =?us-ascii?Q?zl3Q7jINL6BXWilRoBjqpE3yk8GHJLbi76m7YmzS8XTlvjuv+ufH/04+gg+i?=
 =?us-ascii?Q?l6hUc9A4Dqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6ET7enUAK8BUEZ4Tbk+7TINmzOD46ycnjcQEwWI4JQF2eHDSnJbq3mlR6UP?=
 =?us-ascii?Q?fWml3SCXM4bmvpknh0s+wK3rUnP99hGYZ1HkeXj0rqsOVu2EiSSVWj4Ks7/1?=
 =?us-ascii?Q?2sbnHdcNzVA2I7YaBYJ4J+dychFZOAgdM409DdVYyauvTzE+bDWXgxZ9H25x?=
 =?us-ascii?Q?ZbjXnvv9Mtio2uMCKQH6+25TOdgSpqk8QYVkvpgP4P1YYewH7J9QR0VMSvtv?=
 =?us-ascii?Q?nT0lAmEh7wrJsFsCDfVppBAXZdY2IkM1fMYfSoNf8HqCdekumH5+DB2dnDga?=
 =?us-ascii?Q?F3wGycddHsOnW7fwieWXSdZxr2yuc8bkN2a4j+rS12iddlpjXViwRuLIALHa?=
 =?us-ascii?Q?tqBTCJoGHCoeBYthlRj9WJ/dDcPtJaFlO3au1y5fqHWoIyFnIsU3h2wawm5g?=
 =?us-ascii?Q?fkIMbsuzqIxNWImREIvlqEArfQ3jstZ/URUmy/Pg1gB4QK20s6YzxP/qw9qD?=
 =?us-ascii?Q?AeQIfVFZqt7YAWxz89PadnW2QoPEhF1A6tAajmGmbk0uaMhndfQpLk8ANlDL?=
 =?us-ascii?Q?vcECZf0mMUXOQobSOpye2UKPpHosGxQBrtF7uKOHh67anumdTPp+Lnp84/HY?=
 =?us-ascii?Q?3VPl/+Yk9jmcwkD6+WiZyCKyJv6sHgkmUPZQLzlqK2WV0/AQJEy+LqGl+FvR?=
 =?us-ascii?Q?4rvZleG7mccJpuqzaPr0eY5bxTHpVrUkCY8ASqe/tqLSkdO9NEGwUt9Vowu5?=
 =?us-ascii?Q?HSOmQeLJOeA5UrVs29GUzGYgD9O4MQe8rLIZXkCpjq24CyNCUJmfrl4MXE9q?=
 =?us-ascii?Q?hEdjIXmFmXoP5bqMTdy4+bScWtUrOk8O854TFtcaOZ308RoaucncvrjLCMjs?=
 =?us-ascii?Q?w4keNMOl7NYf5UiGC1gvsbMGZqkulTbUACcb+0syVeHthqEvqpkgv98FNRiX?=
 =?us-ascii?Q?RneC0I1A1ElG7f1TEYoQOVYeUBrQJHQNyNNOELk1fT+tR9/lwI1/TtJ8ABZB?=
 =?us-ascii?Q?6nVGhw8+lkD2QxS2kJRnVQMQRBYYgAPndVgAof8OZquWp4Cc+qNFLByWpVnX?=
 =?us-ascii?Q?r1ECl5//wgZ1YnQ8gnQs5/oidvRhLy6T+zc6we4e1Z4+y56mV7+mB5uQCTe8?=
 =?us-ascii?Q?PyH9BmUHq9Nuwzf6gCKemZVh08+3RFqdD9A8AOOHJd8HhWDRXw9DHPNhPPXx?=
 =?us-ascii?Q?6SkE55Xnjoo+SAzpt5tQI6oxryu0A7RHYesKPGsaiotqNJpBhVo8X9QDDX3a?=
 =?us-ascii?Q?nDQDFkwztiEZ9pc9W29gPlHPqBY55AGrOw5vLFVhdCG4zlshibbSIf/AYGGQ?=
 =?us-ascii?Q?j6do1y3sMEU2XvDM5xTU5P3HSS7EIMnWAvfdLl1IFkV54SGJYw2/XOtfY/lF?=
 =?us-ascii?Q?Y1PMK09OdOGn0wBMkuOfhlugx3ILz5kW/17kb2j6iAQ2cq3m3SMibZXhJsT0?=
 =?us-ascii?Q?YOMv4xXMUSDAPvg7ROBkoWcBpIVT6l6NC4pHrvI3ERQb18j5FH6qyCZcD/Ef?=
 =?us-ascii?Q?51vOOtM/anHUFLk2aU0/oiGSO5vwB13y/sIv1jd88FvMs/uZokGEYOaDMQ2Q?=
 =?us-ascii?Q?Ahl5Ob4bL+cOPcD9+efnJws86MFzyOl7+Ebn9drS5hDvDQRuSd8FR6CVodOn?=
 =?us-ascii?Q?T/+lr4Vt5hiAdmCnqi8PBJSu6ieOXX02TThKeijfLbdZ+SCo9T6xWvBbIVs7?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7a08a3-306f-4b67-efc3-08dd9d3403e0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:34:48.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR/6duEBHNeU1gt68ScHcg5jhMh8bM1sPtPbWx4dTLpT4f4IOwsRPTIlDA14bmTuKndSRpaxS8UsEeCN8gxU5FZvMpAvnm9kddwIbB2TExM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
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

On Tue, May 27, 2025 at 04:29:11PM +0100, Bruce Richardson wrote:
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
ping for review and ack of this patch. Since it's a deprecation of old
functionality, I believe we need multiple acks.

/Bruce
