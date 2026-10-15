Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E277CCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 10:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3214B400EF;
	Thu, 15 Oct 2026 12:42:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 87691400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792060929; x=1823596929;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=EV6eOpNUiGfEsyq3w0RhXTTDGCN4YrMJm0fLa0fLbDE=;
 b=QWEuHm2Dccl8zUdkhDUXlgxwDu+I/MDkYhc/CyxHM0yPbure0Z/gbIat
 4EUqTVj07Smz0XPwRu+Q5vIrfrderyVONInlG+G/oLVEHp7nTHadnHdIE
 s38MGHFZdkoeylpzVj5cgCRL4ZWRAQTbADaAFzW1a24PuwSVF4DMog+dX
 aPV4iM1nOmWTNTNbt10y7m+d/kxYQVdr0UbKONCdh7zKYrUE3aUzKEQ4C
 JsPldE6Z3ZHa2iIWEDQ9ykSGhaQdrUtpX2IBxLTOpHLyaTJTK0+CfIV/C
 wadF9KtoaksaN7CR94Y9RTqo3fEflSSHabv0kpqfsUPuaGQcwLLbe7Dpu A==;
X-CSE-ConnectionGUID: xadA0Ym5RgyEDm5/FCnZcw==
X-CSE-MsgGUID: U/KKLweUQbWQEgNQkXq5/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="726389"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="726389"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:42:08 -0700
X-CSE-ConnectionGUID: RloXmjvvRR+U2VMzedEyqw==
X-CSE-MsgGUID: pwo6w8FvSeOJTrmc0PgpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1746290"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:42:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:42:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 03:42:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5mFfNBkhZeySN68+/e10vI9R7xlvwGnn94OYn83kV9by8YERUttXUDfnF3dVYor0S4ui3O3K6+ZbOIfj7uXlE7nj1qRhOAxlfs3BDaU3LRXZx/yj3rxdEUD9xLchPZyAjEhiQgatwEq8X/TEYs4Rb/M8n0KWIZ6QDikiN9/XJehuYV29GfvqThvgmgGT6ITxtkr6fdIXk4QAf2+khB2Oz33LCkFR+FQxeYPrCQ9BaM3Q5xkHepVR1dz6iloWXZoNsoCobU9geqRRQe2tpeNF/hdYIFfaWjWdzdbM1+jhcDzKeZKcaRQMrQZzGhUBXbF3J5DSeN9pjv0R32gDX7hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8wN1ESKr+JDarcyVitbNATzFSXVdQQmSiEUmaiCz+s=;
 b=BTUmGNR/0fbCcIf8TQhYEmdAlhXbZDKNscV8UEffKfRDfpMi/pUb4aSYJWdGcF6u4noqPftQRA04843qfODE/8GQpig5OPkFo82hJsvb+sKe3AnnZDy5X/+P+KKOTiqe3WfFq71C+onX+83AvbSDnShRwHKxNuz4hdw5CUQk9UIK3eMVw/8/RM8pkxuNoiqDeWemlc/N+WUd7qfoUmQdxh4gKx9fkvyCSYy59to7+rDBH0RfvBH+69JP7BDwFfRzPbxbTzibOkNdvQ3CwOeZpGNt7g5fhBntWvAZzFHXljZ5HjVshOfv/bXB31BUG18x2zzD4uQ5MeI+u9djxb7WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 10:42:03 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 10:42:02 +0000
Date: Thu, 15 Oct 2026 11:41:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk 0/2] Fix dynamic link of driver symbols with pkgconf
Message-ID: <atCt9qNiM4l2x6hT@bricha3-mobl1.ger.corp.intel.com>
References: <20261015100921.2944274-5-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261015100921.2944274-5-rjarry@redhat.com>
X-ClientProxiedBy: DUZPR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ1PR11MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c942d8e-e367-4c46-71e6-08df2aa8f2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8M2uFQKAUDrsAhBOFobg32IqMK1AyRsjpcsAwhqIa3FbnPlqEi57rftM59dI5kzFa+fnVgjr2DV6t8Aggy8AhmiVxBlELnm3iiLDu0vM+PGRN9zZpXWlRdruEsVhv/wtknrVAUQybxYSs5WcvwNXhMq4CrNeS7MQE1QtGcMOrGhy8SA60vHOZAynhr0eKCUQKAcXxsf9qFUfPdnTsXPzbOedHaLmzyWFN594PqeWnwRmUPXG1SjxRECaNHLFmF3CIHVwDM8MbJE8rb5RyWXfa7W76M4XzeaUMuV7oRbByO/AwG439PSs6Rj0E7tAwuL4xEQXvIDt3m2nJUyH5HQi2krVKPBmfJS/rB/hDDZR9Ee1J8FsW4bCydkQTpy5I5KYaf5cqKUqx8PEsCKENB7t1STaFJautx0XxYZzbXa5DaHYNXaGKkiIhm+MJCQvNj9EEmSKoxwnB2bIWq1Z9vagcyrCfr8AQ4Zidx2ASFf+prQ6rBU/KJFhk5ZbHeOblOyrySvRvHUwT6rCWBKkOcw7G/tTSFviv4PvGZOf2mLp+bMvlx/6nekZKcVwHpoyMix67O4Ml5IoTYDLkiq+WkwatLt9R0Vo/a8tcpxm65XhxUrx8D+V10+DvgHVEkHHgaCIqldxy1KkcnReGLqivt8XgR81hHbzDCIwqeHJb0Axewk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+vc0zZi6w2gc9YJ1/oPFKLC+ApWB2BG/9Q9TI7O21ezrw7utzbyVn/EX/ou?=
 =?us-ascii?Q?xIIfBU9DBm3lHNQXHyQEMG5+MsWmeXPCnQOlTaa7gsSMLp2zDwqnsL9LZ7CF?=
 =?us-ascii?Q?gDYiSUTFh9CG8wujnlNDoHUMDRFnMT/XkByvkzIajvP43eCfesJ2LSkHW+ei?=
 =?us-ascii?Q?cDDFyKBb9jW+L0VPDd5HIxYBjZssxAT0sPOgCN9auQEJnoeBvdU2Wr+eGFuA?=
 =?us-ascii?Q?1zoQZ4Lj9mXta/te12c39QzselDpPLyFKCKpS86UxtiWhMc0WuX9MZg03BFh?=
 =?us-ascii?Q?/Om679L0dobHCoF2ejhK1zQOHFWcn8oAN64eGLm/J8SPYpIIDEJsyXWeNnch?=
 =?us-ascii?Q?8iSgQ6HWsG0mOkYVkKchuGuOvV6mQrVuWGEP2FgNAmDY2zpc8rNTAOch8QOf?=
 =?us-ascii?Q?2uSKE2s7uL2W2OSj2bn5G5eOiAAb10IWLWadHXhDzElgttESRk8jMPY7OzUI?=
 =?us-ascii?Q?+oJmxRl3Jf5mFSUJJL8almK3dZQ/q50nnUfXPzovaNlnjiapJ4hcf1kqFyVb?=
 =?us-ascii?Q?uX+Ldcxkr4fHOOqoMGRahB46KBjyWwaobACqp7nt7VKhKd5l6M3zJursOIQl?=
 =?us-ascii?Q?l+AdYsSnoEMKyJ48h42VrbdN53Sj5jBHYQEkKwh7Gi4u39uepMWZL+2DTc9k?=
 =?us-ascii?Q?qXMWfPQS8aXFDDwzE36uRUdGhsXrIMSLPHqUMHwCbn5YuGZ5N0asRm/ALjRY?=
 =?us-ascii?Q?et0ktKE8hMCzTlXSlNym9elz4xhHPTNdnDA+ecqRnejf4QYxX5dvMIGLKxL9?=
 =?us-ascii?Q?1+HYsnHx8gG/9+R8Vmgaj2gKW8C6ccE662fPm/Cim9CwQ540lrAjPjUXCG7R?=
 =?us-ascii?Q?K3/CDIn0m0gBB+ugwmQCZ00EtDaUjO66s8YTgmG0O+wvucZdG4UOfPDPfOa6?=
 =?us-ascii?Q?AaVPy5so7TlX4KN3h/LHDWDak8yJA6uzEd7NYtdxDWBHEPA8L5Umwn4BF4Si?=
 =?us-ascii?Q?LbeZupcAA7qydMFqGzWcE/U3q8bmFjICbyQHeSCR3/gPMYebFqi7ENgYEEzM?=
 =?us-ascii?Q?I2W1s+SE+dKR19w/Jjc1h2vn+IhdC8KXa79QCHg1Yg57pYL0tTxJwE7cQJPj?=
 =?us-ascii?Q?8os5TAQWyR8lrIIxFbR3X/DvYfDMUImXcYJx6SDSVuavuZFSsGqnZefW8gEI?=
 =?us-ascii?Q?kqBQP1nYjqQNqvaiRj7AN7L8u6Cls/Td1Cqx8hTnuPY74iYc6n70ERGbw7sZ?=
 =?us-ascii?Q?DNi2wTsxPS2i/0Ce9NCe/cPveAuhyO2kULmr+vl3+c1m7slG0Pol1TFoWl8e?=
 =?us-ascii?Q?IDieJtsm1tViAUkkCP6k82+6KU/XGm3aXpZ9ePh7l4dmAhYekPmUR72tYBLE?=
 =?us-ascii?Q?7LGqpADcXyRCK7jn/gORuDvhr4ZxyCbV6HTXKgQfzg/yqwxq5rp8BCTBL05l?=
 =?us-ascii?Q?pMxANBEQvVkcNUekLKfDR/f4JsS76eLkx/J815palJhIU42wtMcXmBP/ILa0?=
 =?us-ascii?Q?qCU1KKUit0fuhR7dD2GdlHCV2iPO5g5HI14Zu6wJuDdaKDFivOGmiMX1PJj+?=
 =?us-ascii?Q?J8kV4m706q6XWEn+pefTltmQ1UAs1HfOJubbfTffz20FRCRTREkA0NQ43nky?=
 =?us-ascii?Q?HZUrV1KbVwgjImvdIYITx3xk3iMYTzfyC0U7a0ENaQR1z6fVv33qJ6QxZITV?=
 =?us-ascii?Q?2nQKSKo+w51cyVJlDVRK0SaHqkrPyAKurbmANT+/fLafrtnuI4i67Mn0DH4x?=
 =?us-ascii?Q?wGLbPBojXf6MLw1RsKBg71Y8PdvqjSgW3L2rlE+c17kOf7LRaBx8sWLfSztz?=
 =?us-ascii?Q?3frGS0DErfiQu+DEn08zANp05DURgdc=3D?=
X-Exchange-RoutingPolicyChecked: nsC6yJsT567j2IbK3N+EoXTEVZUDUVgyAwLb/QfUh9ts+9iRbLg5qciKK/ANJuHjXYlSltCuJpFD98fIaYj83jb9uKBF0/t4Swj5eORf3Gc38lhNWwEf2F1VYax1U4Ld7uRXdw4akugP9HPrzbza+/0JtngPMpFCap139H122hXkkEh6WIxFmg9ZTq6AXXf4CRQxEkELB0LVoccCXOd4suoIRgYmPp7pYc7COPK7s4qHzQc6NskgFnNmAesGAao9eSreh1ZVkCF5f/9t9KCLA/N2qoELrgfcHwNmyK175ldb/QZVWTTMV5BzuflADneYYiL4+aFUg2x4+KWN5QU13A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c942d8e-e367-4c46-71e6-08df2aa8f2b3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:42:02.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLDKjmj54eOS4uS3y80jMbtzVXitWF16LOtuRZYWfzApmZvKSikOR1EhPOSTBYi8Xtmfxe5bJjEWAwepHM3PBdczT3YMpBWaKvd6AGTR36Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
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

On Thu, Oct 15, 2026 at 12:09:22PM +0200, Robin Jarry wrote:
> When building against dynamic libraries using pkg-config, linking fails
> because symbols exposed by drivers are not found:
> 
> 	/usr/bin/x86_64-linux-gnu-ld.bfd: ....o:(.data.rel.ro+0x148):
> 		undefined reference to `rte_pci_dump'
> 
> That symbol is in librte_bus_pci.so which is *not* listed in the libs
> section of the pkg-config file.
> 
> This series is about fixing this.
> 
While the changes in the two patches are ok, I don't see how they affect
pkg-config. The first patch just renames a variable for clarity, and the
second only affects applications linking using a meson subproject rather
than a .pc file.

/Bruce
