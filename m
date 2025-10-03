Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2064CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 09:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C244028B;
	Fri,  3 Oct 2025 11:17:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A998640262;
 Fri,  3 Oct 2025 11:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759483076; x=1791019076;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=9B0P7Bi5PvJr82T+FiF3zDrh6G2iyT61wEPOkLw1FLA=;
 b=D6+KyLyGor2EsG3+9xYue5hMkBVrbeGbfv1F3SzwlrvPVsqzbVyfdKWh
 LvJdQNodXQQR5czB2Kw4KHzwWIiwxRWMZerabND2Kfd0sKBPNhGAHs00C
 j1AvXTcVC9GpK5F/XwB/6PBSTqlNcAQ8nTMwzdMRf/mAGIeLBGpPpNOcT
 En290x3Z7ntuVTQ8kl8RM4RCdiuFBDc1ZrC/PIjUnWJ6Em4Q5svADAv/k
 wjJuKP0ZDAd2xmHA4rF9+1LzhmaUCBUm2G/LoAgBqL6mw8zMBump7XX6R
 o+D0hR4G7qO9t/L8LIMzw39f/ajUYnM0cfjilvv8XXp/GEQLzRyk3Ofhn g==;
X-CSE-ConnectionGUID: P7YuIhX3Rj+lYn0qp4qaDA==
X-CSE-MsgGUID: RPJ0bFFvTGyLFt9c7Mia5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="73117743"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="73117743"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 02:17:54 -0700
X-CSE-ConnectionGUID: crarxVi6Sb6ZdwI+/z3V2Q==
X-CSE-MsgGUID: ioUnwiSETDmhrlMxVA3ZSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="183534695"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 02:17:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 02:17:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 02:17:53 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 02:17:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra8/0TFXphbSEIQdt/BaSC4LD+eqLVCm51DD2hh9YGNj2rGcUaVXxNrhEOfJCPh4pRz+/Ia6n8vBKzx6qZXrYgO6Sn0RnwjKhusGhayx9DI6/HjKVxHfDo+b56rOf8k4IJ3CnfMIv6iJHGdgpW4iimXnCgJBr8PL5lSjEHmemGRiNRxMFZkRY2cmBLTueb8VcV+vDZXwDI1MwdELQcjh3SdTpIyhijxPGUJ70zWY8yecO4l4xcpM0mfWx12FbkwvReV0RZFwnCg257PaL/b00a9UKzRXa0cYBoBsdn8QDkjkdgvmHLgqAw9GpykjHVw34OdtjeF9fzvh1HWXGdK1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9xTEiGYHe6NLnj7QCyIYrzaYG7cVcaDyg2W7P33J8U=;
 b=Ywa7t4gbLpHzSPGlclSQlM4gHMkabDxX0z08hn94e6UBOjhYKFaUAz3KuOMXXemPMSGW7PbB/2Lcfbtoe6RMYBHeujfJx3/S7+w1SExnNy+UOKz7r42KYS1cTvRR/RHrvdg3fQvwTuDoxPfV/kPFYfX0MQNn+KSP/DFFAj08DhMqNeQB45iFsXOERW1HR4mKOMV2myM/W5UdQfX4KzC+vGzBSmKgKdkM7vRcdmcvhPlZG3lpQ/Jia3beJMwaP9TQty1chAKHNbdCpzlO2V/2p79otuMUFxv1SQW+ekLk5K5xQMwaXH1tyt4KG4wc9r74FmyA8bpL8YXKNiY64NxphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6666.namprd11.prod.outlook.com (2603:10b6:303:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 09:17:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 09:17:41 +0000
Date: Fri, 3 Oct 2025 10:17:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <techboard@dpdk.org>, <nsouthern@linuxfoundation.org>, <probb@iol.unh.edu>
Subject: Minutes of techboard meeting, 2025-10-01
Message-ID: <aN-Use5rigF3tQc9@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: DU2PR04CA0195.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0c8c1d-27e8-4d10-ce08-08de025db425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FAKRMn0K/yZk5keNemgaPIDrXE+QnERorOC4lpc1UW3MLPwk5Lu4N2WoGMAz?=
 =?us-ascii?Q?dQf4N5UWbbhzZgNb3CuXAD91ZczQbwd1s5X61QbmRdaxMrTbvxQ5e5TlQCz0?=
 =?us-ascii?Q?L2d1+Ab4GeDysm6an0X/byD5E4lwjL7FPnO5BRVZCbwaBLQw8xaK9H7+JbZJ?=
 =?us-ascii?Q?AxpiTQbyLIihXwmp2SeJIlqkO8NzSCKaTNXfwZj6xW0HNwokUbDaSCepK4SL?=
 =?us-ascii?Q?4S9DJFYI2+qi6iGSeKnmW6ddlYXFCiNKXxmkMJsKtfHjKxg8LNKZdJ/fmxgQ?=
 =?us-ascii?Q?mBm/VmxuyCHg2sXEHwNcNMwZxtn/w/r8D+ZDmo4d5faywVnJTj05mU6CeMMm?=
 =?us-ascii?Q?mQfmuCv6/kDSdYPSs+sPJVg1Uj/Co2E1zt3fgUL6MFPUMUdScaSPRxvkCotW?=
 =?us-ascii?Q?URumKt+4qP68bZq/Oaf19THXRQqkvP5ur17SgwV7c0bUql3xhCXtbmYklzPb?=
 =?us-ascii?Q?6p3cfTP37YaFLTfZ1d+XsqSDKwQentJ97Cd07XX5OOm54Y/n6QIkReo0oi+i?=
 =?us-ascii?Q?CwZf1zp4lqRT8iNpugtrtg6a0rccVjgEAfMIpCvahK6Tah4q+t90lPqcHyye?=
 =?us-ascii?Q?+Ip4L/pW2KY/wxLSxI6q9DqqSioGXRtvAjMDtUhhz0IbtxX5787PMWlQMAGO?=
 =?us-ascii?Q?BbhhrzvrVb8ILKQuewwMYDq56oHf5yMlfRdDSkLRTEg4v2M/orxZvJb2gm57?=
 =?us-ascii?Q?i1aPhUblYVHjW/CrVIzPVaxnGOc+iBApTU1rJ3j51Gvx9YU9SZ0bzriRDH5i?=
 =?us-ascii?Q?03Hnum3X/eNkYvKhkHSWFnh6kiVGchWa8AYqAZdAucV1XSl/FemVrSiAw429?=
 =?us-ascii?Q?XTufxxoUnV4rKd4t3aM8F8dXNTBeCwcfHA1IWx3pIvk13Qp6+uT8ZPx9nhcq?=
 =?us-ascii?Q?qVAEAJEpTkyR+0wknhIevQb7dbrsBzbIs6s38zuR393+AzQg2PKKd84xnzCf?=
 =?us-ascii?Q?ZUOKDVESNSHt3PxcM0RZpY25t5y1fyLKE4Hz2szDM4ULh/kmtidqNStOKA8o?=
 =?us-ascii?Q?F5AC8EJPrUZfWTKzsbMp3fauxOo3Nygvm0LOkQQ04j/KsgkVQ46CSc05E2iK?=
 =?us-ascii?Q?icbgTdoO9HFv1oASWKGwKVfhXlsL5NjgAD0k//6JYWeMi46a1EOVMNl/nZ/h?=
 =?us-ascii?Q?N1zHnpcFwsP6hQjPA8MZPu8QC48ojpPqPMlAL+8dnfgXw14G8OduNYer0Gle?=
 =?us-ascii?Q?EJ1X39m3S9LjbQefABHOYX21OjPuPnjJVYyMk18r94NvnbgIeD0uSFKL7zXN?=
 =?us-ascii?Q?ZZ3hrdDjWrUsvH26RiyUoRcvZjy0Y4sfql9WDzloQfSYc6KmLVhBSCLsycxB?=
 =?us-ascii?Q?5NQ7ib2ICzVsTrJI1yJuW8PU0NONIZ2xncVCppxvPznx8ExWjGmE3Hks79kc?=
 =?us-ascii?Q?X9UpLl/+v8yqJ9urW8dix5AATgCLdFxYWtZp02bLXjw52zrGWw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/RYQrSdlb8ZGkB5QdsDL0AM7HWLekh94ZDMg5oR4QI+GxmCKL4dRPtb96h6j?=
 =?us-ascii?Q?2Buxl4l1aEadgKVcFMBLcOrNqo8qQl6WSunKjKn8ih+MkpxLAhEQu/hcUAQZ?=
 =?us-ascii?Q?ioUrdIt5iK0TObO7O0tLOcYAdDNVgnAG2DlD/h04PZ5axSzpMI8g1US86ou8?=
 =?us-ascii?Q?deu5KUF9lpkOMzCf6m5QcDMoKqpE5fZsVZAlCkEg34i1ZiKzvJwvP4kPq4P5?=
 =?us-ascii?Q?pWYjWhXbMgmsYsbBjI7BNdWEkzfK57zUJ1PpwTd61O/JM655ZLDCT4QBP+p9?=
 =?us-ascii?Q?cAMqrPTfXXLCZT6qwdm8ZQWdv8G1944xpL34k2uON6b5YEztFxElnfRAiKYm?=
 =?us-ascii?Q?G0TvTh+RQiHpwydqEbuxIxXrm3Z4SaZM/LnC8i9d3/ADKTc1pRn57tmMRFp/?=
 =?us-ascii?Q?lA4JG7X3SXDP1GsmZghCTV3YnVUKk3OlmDVWLLxuaK9nhrPH9VlURasSbaSr?=
 =?us-ascii?Q?QgPDDQ3n2KP8t+XK0ca4sTa+lHwkVMQwvgjmWIt744t+8OVw/mm9nPTRZYEI?=
 =?us-ascii?Q?WmwrxV9BdtY9TTa7KWqnm6SG4aYmYtLU1MMCjZsEeCtKajFBfX7iqtr79Mw4?=
 =?us-ascii?Q?xaQh30akaIyX5fRdinbObsVB+CnjfFFSfCoQkkXw7y+RQC1TsJ9br6uRAOmo?=
 =?us-ascii?Q?ktyRzJUnnkvtq9VHyqRAIT89YCEXMHWA8qf1fe5tU+cgXQvKJuGn5EMNYQqi?=
 =?us-ascii?Q?0ZKII58p0zFZRx1SkrmRWidR43NHMjX51SH3xYtMIt7l3U7eSgtNo5qJyFw6?=
 =?us-ascii?Q?XbzRNoXXjJi39bf3NMSMj/JojpqaVbNvVCmJ6T1QKe/iwkuPhb6fGVms5Rj/?=
 =?us-ascii?Q?Ofv333z+xsuyIvFSu/O9/mgjVgg5eZTNyYpk1ZUTqn3YyTyEBYoBSWsRR3+5?=
 =?us-ascii?Q?XYVwFGKoP/yQy1IH4ca7jpRcjeMJOqgq5PtnvrwwNJqLPvHa94sYSO2wPDzb?=
 =?us-ascii?Q?Sz34BWe1SqF8nYgVrh9x3pKJcMKh5XMgty4fKwiexY47I4wbaRkWfYneG9QF?=
 =?us-ascii?Q?SadsH2yKbv8MzmcKNicBF+iT74nKr3CCUY//e3MaCrgH/kzn0vLmjM2VrHj4?=
 =?us-ascii?Q?P6gIb2OYIWZqkwgQYNFKrhpbPTsu42l+S9DziL/qykZbc3MAUTXzvJQjPngW?=
 =?us-ascii?Q?Rnut1ELlaCM9wAfLE6PnRs+waOwFffr0z04cDrzZaZIMuOPTeEGz4WQtjYhS?=
 =?us-ascii?Q?IfLyofCx00g3K9Mav2KOahN62g+siDWdoAePNDamSsoMKrsnbaqNd/mW1npv?=
 =?us-ascii?Q?QwepACdnG/p3vudYyHz7rNOjO9EQZ3pVvVi/KdoFthHsv0IvSbBn9BEoKMlo?=
 =?us-ascii?Q?Vj5TfPSVZyUuPHUe3IZlEOXW2MLme8c9j0HOsBjxzdwCx7TDKemT6i2qIVsF?=
 =?us-ascii?Q?dyFstn+6LS2pQFWarqqvjd8y+DRuOZ2vKsWC6A77vJMOK+3KO2+FfjZB7aZQ?=
 =?us-ascii?Q?I+19NAVTzEhiKo2XaJLqWLNlekaR7ZVQQIuJD0IlwDgClgbkjjkwVebZFJPn?=
 =?us-ascii?Q?jyrXlgBnAmZIUxbcjw3B6tRBm2wA5UBlVAsbpn/GLILafXo6ne4JLdBQkjOD?=
 =?us-ascii?Q?Dy2ZO5ubzZhCpDc8p76KmWP/Pt3Bc/dNpOkPtKkW/LNwnS16CP7v1bs1Mz4W?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0c8c1d-27e8-4d10-ce08-08de025db425
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 09:17:41.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0y98Ylk6sCUu+TilcqHx5CBhwpxW6VkbjLmbNMvLMJz5Vix20yNHVJLVHT7Kn/qcl0zKF5XEwWeF+9UpR4oFsdDkHUTi1ynvLT5JewOwv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6666
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

TB Members Attending: 7/11
--------------------------
- Bruce
- Thomas
- Kevin
- Konstantin
- Morten
- Jerin
- Maxime

NOTE: The Technical Board meetings take place every second Wednesday at 3 pm UTC
on https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f6-0a28-4165-929e-5a5bcae7efeb
Meetings are public, and DPDK community members are welcome to attend.
Agenda and minutes can be found at http://core.dpdk.org/techboard/minutes
The next meeting will happen on October 15

Agenda
------

* LTS Maintainers,
  - Project is currently short of LTS Maintainers. 
  - Enquiries are ongoing to find additional maintainers. 
  - Volunteers are welcome
  - Mentoring and support from existing maintainers is available for new maintainers

* Use of FAST_FREE and multi-buffer/scattered mbuf flags
  - The flags for enabling fast-free and supporting multi-mbuf packets are
    now documented incompatible
  - Previously they were not defined as incompatible, but that seems to
    have been assumed for some usages.
  - Techboard discussed how best to resolve this incompatibility with
    regards to:
    - ensuring correctness
    - avoiding major churn to DPDK code
    - avoiding churn to end-user code
  - Options discussed:
    1 change definition back to not have the settings incompatible: this
      necessitates checking drivers for correctness
    2 keep as explicitly incompatible and report error if both specified:
      this could break end-user apps, and requires changes to example apps
    3 drop the fast-free flag if multi-segment mbufs are also specified:
      "hides" the issue, but probably minimises changes. Would need to
      decide whether the dropping of flag done in drivers vs ethdev level.
      Pros and cons to both options. Needs clear documenting.
  - No firm decision reached, will discuss more over email.

Recurring item list Discussion
------------------------------

TB reviewed our standard list of recurring items for updates.

* Examples to remove:
  - it was noted that work is being done on DCB functionality, and
    separating it from VMDQ.
  - follow up with patch author (as presumed knowledgable in this area) as
    to whether we need to keep both vmdq and vmdq+dcb sample apps.

* Doc Maintenance:
  - Project had employed a technical writer to help cleanup docs, but this
    contract has now finished
  - Most output patches from the contract have been merged but there is at
    least one set that needs futher update
  - Discussed use of AI for documentation updates
    - for mechanical updates AI may be of help
    - skepticism of usefulness beyond that

* Community Lab:
  - Patrick provided a short update on lab work:
    - DTS Development ongoing
    - Team at UNH has produced some new introductory videos on setting up
      and using DTS.
  - Process has just started on planning for lab priorities for 2026, in
    order to have that in place for end-of-year.

