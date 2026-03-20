Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD74610987A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 16:27:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1F5D40654;
	Fri, 20 Mar 2026 17:27:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 64C3E402B2;
 Fri, 20 Mar 2026 17:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774024043; x=1805560043; h=date:from:to:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=iWovEkJq9LJ2bVhwDCHtEllz8GGUaNE96Df1T+i8/Z0=;
 b=OjdPYFu59XVGjmzh85vvMqnUBHISSrtmDw9o0S+BjudTZbZCyQgLltAX
 Z+CeIhzFmWffMj3t07HG49dmn6TH0YcDNDr/BmPXdIH3DPjbeVau7iocB
 oIcX3a5js8ZicWluZDQ3GvBYiQIB/EFv6U05JLlEJZ4L+UsJFRp99olrx
 tV+HHcgayLwITpiiBOxBTU85VHrkUknivji1bDH3K7a6/E/t1e8JkD2Qt
 ZhD6HH0NKlsuwd/ebRLjiBtT5Cbu6TIIbF2z9+lOQnhCTnY2UQwyCaTXE
 feEuLBpzNTojbQck0eD62mpkpFFrcBPQNIYOUpElrPqrYpGr4BDAwHQz2 g==;
X-CSE-ConnectionGUID: T3Wh/2xETUKA2FqfGzIayw==
X-CSE-MsgGUID: RbCXRt7LT96gYZqPKsYfHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75304493"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="75304493"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 09:27:22 -0700
X-CSE-ConnectionGUID: 0+y1EKeBRAKPRA77UDtkAQ==
X-CSE-MsgGUID: 0vt4KLJVQA+B/t35x8GbVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="218669042"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 09:27:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 09:27:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 09:27:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 09:27:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImbiCMCSc4kTC6/Ognx3BQ+Z1oOnPQwsYx9Zlu20ascooWlNNAL2c3RKsid6V7B9lgJfKz9vWZhm9Xk3AN+NJBuVATBA/Ai8fYh7/5bradA0dyYxQmT5KODkWi+/AE/7pAHk9cCjFpxJ16brX0FHRzwLz2l2yC/wQm35qCoX53Jk2vXhz3/LpsjFyAfXpkguA+Reqctiuc48NLKXTZsOBQb2sJdWE0dZ2EvHKwiApy97hz8R3qWZEU7Fo3uO4TuJ5+J39Uz8e47ZfTtPF1pJzIKGPqHTy0v3lOuyu3c1nBuAXuXZRCZ6+Moq1HcKvTH+XBOtKJ8o3au5PEtiajNkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LooH5MXTW2MlDOiGkHeADA+nZ8UovSokZTG2XkR3Tkw=;
 b=nIDcnDjmb+eBT8z1eWOPx4Psa1LjNRNBitAOA9EoBSZvYeoN3cqodhS0LWdj9H2Vrhn4q/JjNk00drb66GAwoGnsjrFqCBRhwP87WTYji70vUueSUx3RP3uDpOcR3CrGF76QWixNBXBgh+pLsmTTGaHlfWLpA/E3Uqmnewo9cnI2k33h4OwG31PIxGZO6YBTd6/6ht0nD3C+wYCevbyWnwA467fXZJka1n4BeB5QSImRglaASovF+Nvfj8zGWMdPYNSyOYJiEGJrcUDBG7fYMcyf/pw0PfSS4bt45dBgsiA1nDfgZ0hrLwJ1dFNorHGxZDLWIR0EUKzR3ziHDYMbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA4PR11MB9443.namprd11.prod.outlook.com (2603:10b6:208:55e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Fri, 20 Mar
 2026 16:27:16 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 16:27:16 +0000
Date: Fri, 20 Mar 2026 16:27:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Minutes of Techboard Meeting 2026-03-18
Message-ID: <ab11X4Jb3Lpht5DA@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA4PR11MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee33105-187a-470c-d8e2-08de869d8cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Ce41i+VbWskeoTvp230D/KqmTjSDBZIbHKNEYLF/9BbyMKf7WApeY2+RRjpgLOVoux+QhJuSVSGA0OCowZEOpXy0GjWEBho4XcNpYDfpZlZc0MiLH1H7I/KoMk94Sj/vh3WOZmpD4Q32m5LMeqxxMUfyYYar8EhfdikmD7YTrfXHPQs/kR7i9HU8Wnv8icwbhsvZsP9BwIB7HtioVycHz34f84E/Fn9nDh7IrP7kxa2QsIcSagald3U5dbBoD9M/DsvUAqWvn0HCF/AV/Q2ASMHDNb+79i4GleKVtPt2CeRqp+HeYbIaVJk8w3E5vZHf23vvdWGxogHicbOwKj3jcd+sFb1rD9d+B1pxEE1bFEHNh6EEXe/hu+gWHgL/6+CscjmagFyVCJPrY+EloVPajYAlG/LvcO6eBIVMti94yU8elWOQSxmysOifRcosRRb05PGHPqudE8j5HYWdlU2BxHOw0zjH2ICNmDnV+5iDrauNOVdmSF9lJyD3mD4xGgkEGx7Ls43gAg7Y4xnOXDQO86zcHnKnkwk2mLIaX+ln2bAJFFt2CeHJN6ad9zJc/SUA6mMaYpiirMf0wncm5VgPgk3TA0KYSm7Uf3wQ1ZzfzIS8/1k8qvTXSMnnWlsUI4GqrgCzRygH65WFUFgcsI/86+8IFDu9WLD5wic8rNuNhyBP8fsh0cij4mg0QVsP7blG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6paoBk+CO01UUwy2O0aWjarDY9YZ20GJSz+BDXGobqNwOgDtVvSRMMaRvU?=
 =?iso-8859-1?Q?CwKo0qrRFQe9l7XFhWjvJ7yPeVUjkIuej6L7gjWbMjjLvBiQNNHYyIcY6G?=
 =?iso-8859-1?Q?VNjx0DO0J7GV1EpejIRaQf2FiXCiqcBEG+UP23vhVxuFVE6EpOtxjm3+9I?=
 =?iso-8859-1?Q?r8EPK23FPGeMo5bN+bad8bywTAkgpbhc17PCtmsc5GGjCa1enSNZaE6voK?=
 =?iso-8859-1?Q?ISy9e5QQMn+N+CH8cE4bkq3yXcHSQHPNeB3EECL93BroGjwWLQSku17rkZ?=
 =?iso-8859-1?Q?yOXHIh5IJ8Et/SZqgXh0mAlCnGBbSY4tz3l2rrY42RqoYszGP9r1LhvOlr?=
 =?iso-8859-1?Q?vxMYRWxoaz+WVOv+oe1ppYK4TjbwAnwQjGIGLT5MEsgOP9YktStaxjeqcH?=
 =?iso-8859-1?Q?2yL0H7tGpskF8fyh7S2ChZqSVOZlMcbGiWI9zg8Giz3fOCUuBmj/On7xBF?=
 =?iso-8859-1?Q?W8jUvWspMA2hBCg55THcrobVYviy62Xg0ea2stg4DM2VAr/MewmRZzfoap?=
 =?iso-8859-1?Q?jNFk4hUTqp/Spr7yR4g1GXmedRjh4OzO2jsKsViluSBeXvnMmX8r0KaSz0?=
 =?iso-8859-1?Q?fDg2/RKQjzG2zh4Ku03Jaf4rygDaewm/RWOa/pRBSeuwm2dmw01I/juV7Z?=
 =?iso-8859-1?Q?jnOeNeZfL0Uh2gS8qq94d0l1y+SGhHDMgRHvAtkbYlT+DZQGYhkX98q74R?=
 =?iso-8859-1?Q?YQypI1VBxr0A4SYrQdyaRWCoPFB7JFszcBSRL5rY2sihFSWqIq4A+eaOan?=
 =?iso-8859-1?Q?39SN8YaJkT4p4B94B/kUheSIahDEI0hHSLfaLULXUPQgfHSk0Z7z+I8VEW?=
 =?iso-8859-1?Q?ofFvVJ1UCAwPrPs9Ho+pod0BBHAtkjv7q+yV3Hq7sxVpCqFyeGOpbXBFPN?=
 =?iso-8859-1?Q?F7f8C5tdjR30FvqGcuSN6H9xElV8kB0qDODgnLs8mxtWj7oczIenWn2cvn?=
 =?iso-8859-1?Q?0Gu8poFIb3UmtvWCqBLPctHRBIEaKRHq+p/IBKnbqK3J5GjhGiXVDOECi4?=
 =?iso-8859-1?Q?FprwWRSdYR7B6P/NrdFxZ9pqsbLpyWHPm9pAQCCVBIdlF504Lz+VsxhokY?=
 =?iso-8859-1?Q?vtUSZXxj39E75wAWIJvclhz4UF0kL35tnmEnuI3DX6FuKm43z+pudPE1kf?=
 =?iso-8859-1?Q?h+jT6SZObaNRWyfCZOtKFslCF4iNrqfS7hFePKXhxdOlkdODUmO/txEj7B?=
 =?iso-8859-1?Q?wl+/28nH7DaEdyzagteLrDEFl2JmQctI3VmAl3HUhQaf1s4ALl81gfz6To?=
 =?iso-8859-1?Q?jJxN0ZczYpE+gcZdjOI7gVTpSZiMwhK/okSQ/tG6cxQZgs6Y/mJgZ9+9hp?=
 =?iso-8859-1?Q?zvZ3tcd7wlunvOZQO+cvumdgLO/qNsVDnNolbLT9b5jjoGmxvK9ZZ4M0dF?=
 =?iso-8859-1?Q?N1ydxbHiuAE3jNjjGPcQ5VuxPHrqIGmQ/butoAWm8y4d3oYFhxwf0Uj4Sr?=
 =?iso-8859-1?Q?nvaB6KteIM+1mxhfmFcj8eazmCDX5osuf6XILXNv02puoijcpRhXUQ6Nbj?=
 =?iso-8859-1?Q?IDYEtetvngAnVNMqjkHHxRLGpk6IJd559HY2Y91ZWvmkBWBSQ+BZV7EaP2?=
 =?iso-8859-1?Q?wward8PN5Ag8Kz6RrYrL1bJsjPN2TJF+/iRHgQN+lb2SCF2nPNoILZzhYh?=
 =?iso-8859-1?Q?F3iCVGH34GcJgb1v6G/SvWmaZQ58NX+/sWUQX+vWqxAbgyIeFL5EL4TRLP?=
 =?iso-8859-1?Q?VTIk6IV/ia29gTvmXQXLOt7U26zFNzZqsKFLBJjVYxhprq4UB5vHSx0Jp/?=
 =?iso-8859-1?Q?oZbUbaxnQ1J5wh0uU9hYLBe6dxPg81a1eUREC3EsaMLYzeDph/CJ7t62SY?=
 =?iso-8859-1?Q?Ou6eS9XvXyK8B5hke1MziPt+2BNYSKo=3D?=
X-Exchange-RoutingPolicyChecked: qrOQ0nvZ5sHjauyuMAQhdk4kp9CE92Swowcs7Ogwoh4VGDGH6xh8dv9Cs/R3OKLMw247ugdwkaClgVf7oKDkJaGWAEt8IT9ltLwqaEkysm7rWf7wUNhNEIKcgfZxjTvqEFD8/CepFcAfw6kGquTDp2KkLg0F7cpA9/U9+jK0DGGoVpU7ptJDSV0U/cPJ6YrQRboXRtSfAiLhIyeLOOh01f9jrtHoWC5RqJ14HnmawK0DZcV9UnaWHOEa6/7dLs7tv41COfWgMKIrYUe2qj8ik9rdfqNHIgQYmvo2fykjj0/Uupp3tO4nQS0EK3HN6M9216vwNwZEktxy4KyZut+kyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee33105-187a-470c-d8e2-08de869d8cc1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:27:16.5669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bw0JouJF3YquZ70/JkdHoNkx2B2pw60/d9Muc0xPTLKwQoJYaD+/9H4TTtUKl1FKiU5e+YJAw0eO8/SXjseIYgzTYzfVMGeSTROF/1YtLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9443
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

Members Attending
=================

Aaron Conole
Bruce Richardson
Hemant Agrawal
Jerin Jacob
Kevin Traynor
Konstantin Ananyev
Morten Brørup
Thomas Monjalon

NOTE
====
The technical board meetings are on every second Wednesday at 3 pm UTC.
Meetings are public. DPDK community members are welcome to attend on Zoom:
https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f6-0a28-4165-929e-5a5bcae7efeb

Minutes of previous meetings: http://core.dpdk.org/techboard/minutes

Items Covered
=============

1. Discussed the schedule for the upcoming DPDK Summit in Stockholm in May
   - Thomas proposed a draft schedule for the two days based on accepted
     talks.
   - Feedback was provided by techboard leading to a few adjustments:
      - TB liked grouping similar talks and themes together
      - Made adjustments so that lightning talks were better grouped and
        placed more towards end of sessions rather than being scattered.
   - Thomas to check with authors for decision on one final pair of talks
     and then forward suggested agenda to LF conference organisers.

2. Handling of security reports
   - There are only two people from Tech board currently assigned to the
     security list to handle security reports.
   - When reports come in, there can be some effort involved in
     communicating expectations and timelines with reporters.
   - Need for more people to be involved in managing this
   - As reports come in, domain experts will be pulled in as necessary.

3. Question on updates to release notes for already-completed releases.
   - Discussion triggered by submitted patch for release note addition for
     25.11 [1]
   - Consensus was that adding new items to release notes is fine
       - Agreed that the additions should really have some small mention
         e.g. in brackets after addition title, indicating the date at
         which the addition was made
       - This could cover case where a late test report comes in using
         other components, such as firmware, which may not have been
         available at time of original release.
   - Any release note changes should be CC'ed to stable for backporting to
     the relevant release branches.
   - Although not relevant yet, some brainstorming done on how to handle
     changes/deletions from released docs:
       - One discussed suggestion was to use strike-out text for removed
         text to make the (dated) removal clearly visible.
       - No decision made, as none necessary, at this point.

4. Discussion on l2fwd-jobstats example and role of examples vs apps
   - Referred to techboard following some discussion of l2fwd-jobstats on
     mailing list [2]
   - jobstats example has characteristics of a stress or performance test,
     not just that of a reference example on how to use an API
   - It was discussed whether or not it could be converted to a test or
     moved to the app folder, but no clear decision reached as most call
     participants were not very familiar with the example
   - Consensus was that, in general, the code in "examples" should be kept
     simple, and should be for the purpose of demonstrating how to use
     libraries and APIs
     - Benchmarking code should be in unit tests or in apps in the "app"
       folder.
     - Biggest exception to this right now is l3fwd, however it cannot be
       moved without breaking lots automated CI and similar systems that
       use it. Little benfit from moving.
   - Bruce to follow-up more on jobstats example, gain more background and
     info on it.

5. Project "wishlist" validation process
   - At a joint techboard-governing board meeting last year, the proposal
     was made to start tracking a "wishlist" for new features in DPDK, to
     encourage a longer-term, more ambitious roadmap for the project.
   - Thomas has now created a new "Product" in the DPDK bugzilla called
     "Wishes" against which feature requests can be raised. This allows
     people to submit feature ideas to the project
   - The Techboard then has the role to review and approve (or reject as
     unsuitable) these suggestions.
   - Consensus was that this new approach was definitely worth trying to
     see how it works out.
     - One request from Kevin, accepted by the board, was that the
       description of new requests should, by default, come populated with 
       a suitable skeleton, or template, description to help guide anyone
       submitting ideas.

6. Maintaining a list of begineer tasks for those new to DPDK
   - The milestone field in DPDK bugzilla is currently unused, so Thomas
     has added a "Beginner Task" milestone there.
   - This allows maintainers, or others doing bug triage, to identify and
     tag bugs which are not serious and yet also relatively easy to fix.
   - This should provide an easy "on-ramp" for those who want to start
     contributing to the project.
     - It was noted that since this is in main DPDK bugzilla, it also can
       be used for DTS issues, providing an easy on-ramp there too.
   - Suggestion was made that this milestone should be added to the new
     "wishes" bugzilla product too, to potentially identify easy new
     feature requests as well as bugs.


[1] https://inbox.dpdk.org/dev/20260317155538.1282864-1-rileyf@linux.ibm.com
[2] https://inbox.dpdk.org/dev/1981390.eGJsNajkDb@thomas/

