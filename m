Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B3EDF17D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:35:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ECB2402C0;
	Fri, 13 Feb 2026 18:35:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 8E4B2402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:35:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771004136; x=1802540136;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=lVagpVWt0dvZhXNvgui5j3VhoB/edcEmxaZtNjaL/7Y=;
 b=a3LfaoXY4jzagNYerRsAA0MDLYlutF23YRj3lwsO6EAyi23KSExgpW6x
 E2TkSqITKSwXEYLVCHaugx1CWbLRubHz2O5HFWleCNcKVVi84IXGkY0Tz
 YfgXN8VAhXDKcMLbiMUrlPdiCaYlzY5AYnfcwAtZAEYsLaysrIa4BABxC
 uCgm5uFYvk0lJ2TlsxJqglqj4XT0pGx3JJkpz/77y11WJnIPn/YKG9/76
 3D/WPUBW5+HSf50mBENNBmDQNeGWrqtILPcPkEuUufdnEoD+qvaNEFYd9
 hhDLz6qFZxn8XeaFCKms0CF9oC0cQkurOWzFN4N6byOnK6YhPztJPHsNP A==;
X-CSE-ConnectionGUID: /inFhfWbS4iDsvEKG6UqwQ==
X-CSE-MsgGUID: 3XXRHaImQuKGoYRIdTfE8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="59761620"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="59761620"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 09:35:34 -0800
X-CSE-ConnectionGUID: t6GbW45ERuCBCi5xSmo2WQ==
X-CSE-MsgGUID: FdyC4lNYR3+ZbP4ZUKvrBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="217520332"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 09:35:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 09:35:34 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 09:35:34 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 09:35:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5y0n2poA1wKp+YYqlJ/8LgokzKfdWQTx6vmomJfJ/uDO27o0pmYwmPDjGzYaWed+jp6XamkU/AkjBpmaPtJsT4a2CL+7tbmQDIrS5msbQXP+YjGa7qBR+wXRE17fL8VifTH3V4PapRovpzj7AsEBu5wFfFgipiVFOVu7KHgP9T/TjJoY6y7fkPA15t8E78kHhusk2+JxZ2Q1k6FnQixji9aYtNsDlTX/qK+R1nP9mVyQxvn+7W7p0Hbt59b32VQb1rIdqdbmS9Xhx3dNAFwOx4xqGDjU6ZKAaAt12dR7Kn40P7ezwJDUEyQbYHR79cZZXe6g0+zVxqDrCFEQgr8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PBJREIfUnQweeChP/SHybKrMRo/2nbDJGZ09E/aM0U=;
 b=QLfzU0NIn7hfZ0JqicPD+KUNzpXAL7t7RtBzao+7vh1XSGrVDry7s/tELmERC4Y8KqOg7x33x5VZIqUsyhfYqW7Fd0UrxZE65gYTbciIY0OjY6aDDg+7hkBl9q0NIk7MICFRJ9am5bZWXZ4r32ZTaUuTmo2FSjEpnUyEy0vi+pr55jjnHVLMGMeiTEbrV6BLCIhez5XmF5hAOl9f7vKmSw/8PBm4yk0HE1UHarVd3ml12AvAEgkc6oGx48TaJp9cxwSZEWXor8ITkT0cYxxRVa7XWgl4O72b+Fvflz91HcOlwLXZEDweahqDv7n84MGyMLNg7ePOxoOOCv2LQJ+P4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MN0PR11MB6085.namprd11.prod.outlook.com (2603:10b6:208:3cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 17:35:32 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 17:35:32 +0000
Date: Fri, 13 Feb 2026 17:35:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Selwin Sebastian <selwin.sebastian@amd.com>, "Kishore
 Padmanabha" <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Jeroen de Borst <jeroendb@google.com>, "Joshua
 Washington" <joshwash@google.com>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH] drivers: disable comma warnings selectively
Message-ID: <aY9g31VOP80Ot49N@bricha3-mobl1.ger.corp.intel.com>
References: <20260213151559.656837-1-bruce.richardson@intel.com>
 <20260213092517.4bb136af@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260213092517.4bb136af@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0297.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::8) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MN0PR11MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a33a16-bedc-44a5-29f8-08de6b264978
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Puc2wfnUf5+NhtsWzQwtZOZ0oXoJza5EW01XIA77WCsZmNrCCmEL3JFT3+U?=
 =?us-ascii?Q?az01kb3UcKt9zSCviLsLSH9KtA02NFd2hDGrm6fRkVypQRpqgNqwYxQLOQaJ?=
 =?us-ascii?Q?LrUK40LknA+TOoYge9q4t2EbNktG/hhpYFl2PC0MKpypBwpgYGLbhvxLv0NZ?=
 =?us-ascii?Q?nCAUSvKJO3EVbqa07h3a9deRvZalX/Q3kkCFR8zDqIzSpU1FhkAo7T7zjgHE?=
 =?us-ascii?Q?88LZFpWF2mR7QA4Kz3888UaDfqG79SU+yAmal3qaulxaEmE7d63V1UayoIjc?=
 =?us-ascii?Q?W5CdcmxUfBn5s3xiM15bMwNFcBwrEU/K6RBcShrJMeXvyBUBjgX2nkKvV5Mc?=
 =?us-ascii?Q?okKZYb4AT0olTPehubN9K+Asx5HAbiw8Htc6bl9vWuqGNm0QgD9wBoK0ofUU?=
 =?us-ascii?Q?TduHOvmBfIpMsTvvSJolH7F1f2objGMEiJK/wZeIQVlCBtnFNHj7AnXAuPmL?=
 =?us-ascii?Q?7fSC2ePtAV4COHxhlq7Ghhy9sxw48Zks0kDSX7hcsxgKdkFgOC5EJoZpIlvJ?=
 =?us-ascii?Q?txjeQDh8U23/GOVAMXmIjAYXwtI5H7Xj+of71ltK1SvjrQBrOrgRin5x8PEm?=
 =?us-ascii?Q?yI09ZTddjeRhZjIC9Lrrn/MyHOrASR0ymwb8HVIXKxPzql+xeXrqPcEErL69?=
 =?us-ascii?Q?BKg0zEmo8n4eVPKts0SKz7sAY9opaeNsTITWvOru747Ol00oaNumlSWjRKz0?=
 =?us-ascii?Q?r1Ey6k/kJTrzQFOCHS4BpQiw2gJbb1npHnTKBriTwiL3paEFEBv2FQzRYPg2?=
 =?us-ascii?Q?YjshF0ZrCswYSWV2CIH4fKoIUaBKvOJYYtiVBkD0uAUChe6uaemhNpOimzLy?=
 =?us-ascii?Q?GGXc/f1ck88XH/OjKm31/WquK3qRbi7HDFMMbkGk7wBQdRg5zQLQFlMaDxTo?=
 =?us-ascii?Q?h7dE11FcMkCvr3YUo8o8IlzpNzk+CRApNvigg4Bbs0Llob5LcVFOPty4UddK?=
 =?us-ascii?Q?yTrVzSVlzf6pKyE6lhv8REiXC8mne0rosECCjurh6C0nMKi0IRW2uSfA185F?=
 =?us-ascii?Q?iuspnvUVlluZsfu3aCi5fBLF4BI5UZPAYB04B0dyR6vwxowOlianowixOImz?=
 =?us-ascii?Q?aMGvuUIQWbK3/Rii82AX4XXgHuGFPvbtFUXJ2hUMNHCDf1T8RgrW5B+hQCcp?=
 =?us-ascii?Q?8FfuHuJspAeom3zvj2bsp3F3NhfHyw+agK+rwa1n8aJQazRFDkoJMe5HaHoS?=
 =?us-ascii?Q?x3H5iYRIcjsSKO/olsaujeffkDl63qwj1avNzXPzYvtJIShl3R9irznw/Vud?=
 =?us-ascii?Q?KKGADiO84BnkNnrp3zKj3lWheld1rR1kp5vWQejdNvZzrKTbwC7lxnNOxHbP?=
 =?us-ascii?Q?lEFn6xWdrFmE1g3x9fhLgc0HYF7Q4rwGEP2Xb/VEX9wiSsyhmfrTALwNHrO8?=
 =?us-ascii?Q?pOhJleGMLDAcMAzCz3BcVAHdxq9tOCWzhtSKaUjDubLdnQwIJhMyMY/qLrf2?=
 =?us-ascii?Q?YyPxPGRCmMXGvTBNWk4bheTVFsR7xR/ekPHEOw/o+vrlB5L3NLpklWCvOMeh?=
 =?us-ascii?Q?fPYlD5X0G/97NlVbsvdAQIEOaiCb1gPgp5y3CjnX2BCXeSvMNmuzrRd31f+S?=
 =?us-ascii?Q?lHNvEM0qsYusejgPuc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWATTpib1KrFhY7+uFm7wYPvMnRGoHBXq+RUC/6GISe4vzHjaqCmsyeWmDzS?=
 =?us-ascii?Q?blNRrxGkiPIFMpGkbmBO+KvLlPMeveQkHIfevwb6JUhICpwN8ygNIJMfcUEB?=
 =?us-ascii?Q?frVElIGTeLc7dhZ1VUH2V/MIqrSmmH7art7iWbeG0Zi80nKKxClKx+SKfHC8?=
 =?us-ascii?Q?t5qFZlK1VT3EICJNZatrrcS4Vwi+qEoU3A2xB39OSDL5a981w3MvVgjTfe5f?=
 =?us-ascii?Q?oSH8tqE8Cb6H9BUD+hmw7bNwBz522FZZkErX3VVfyYnYHqUlpUl0xby1Qir/?=
 =?us-ascii?Q?AWxwN8eVlKOyyYlEDBx4WYlvcu/aqL8iyDyoFZL7pXmNnujuqRDVY4gv6UQH?=
 =?us-ascii?Q?J1XoQDAIq9Lq2T5QdKl3pAevYa5m5ffIQKQ63DOQdOlRMYiMvUUsoDruxV+R?=
 =?us-ascii?Q?igQTjVYPYEUi86nY9E3NGR2uFDajiXy2XWogFIgWTUGJafMTvo+3GHWcvpWY?=
 =?us-ascii?Q?X85WVolMA19SttIAondtXxx1bUUD0Mz8GUjyhGbd43+yOuGvkr6SWHmT8UCA?=
 =?us-ascii?Q?FdgZfJwOCyzs+KSBaSPKyzghXzcutzFr9ahXM8I3m5M2AfTx0PjlLeXEjJqx?=
 =?us-ascii?Q?jqW7yuVbtdPpxJAbwlu/WHK14yBmsrsMuR7nLf090bQxHDKf61O0DtFaHcnI?=
 =?us-ascii?Q?KEGFXHZT3zSvywXl1VDc8aExLfjNQFRCesF7j+SU5TLr02LRXhIbjjZS1Ahh?=
 =?us-ascii?Q?/+v8RVCTa+jjByLo6weVUIfLh6MAJHVPdz0vkhQOp0EbFiYvQo5NeZPt+SPh?=
 =?us-ascii?Q?jgipNWzf6eGIS9LO/p0NFtEowo46YFSgkmHTijftqtkEQcS2h3OQSCMNluXI?=
 =?us-ascii?Q?FGtMSR4ncM9eWwIKQcMMTjjKSm8IaMpQR6kXZJG3XGkrDoh7JjsMQH56gJLJ?=
 =?us-ascii?Q?/krOC38j98ZuOjFTDJZd2lmrcTDcWOWnUfj8Wf99YWk7rcb/40r2Ch+HJCh1?=
 =?us-ascii?Q?KsbEoiBegY4tYAa88s66PggZCuOozsRmddcQrm/7GFIy6nTgVZoUVjbnpRdj?=
 =?us-ascii?Q?GBrBiUJ9vbvAfmNqVIt5l/QywGV97ZGiiZO9iabmCGB2+XuYoShgkIpUWYjS?=
 =?us-ascii?Q?SHmjXDuTZVtOGbPmhIHlo18J3v9GRNI12ug9UwGFPa+VNpqlR+CL2EDVeSBI?=
 =?us-ascii?Q?/NZNrQmhmYr2QcoL18BQWyznchQbUyxIiJO8bPj1bUFZn5kwXfz8siiocBlF?=
 =?us-ascii?Q?Q1wnyO+D0oKikmWoQLL86yH0WaMDIx7hblqJzIy9UsxOWbS5fK4tfhi9pnlp?=
 =?us-ascii?Q?35zNGt5MFz6lCr8cYTr9ongz30VQ5tZqV2vx3uOP7zhtX52tiYEAd0QyAu4o?=
 =?us-ascii?Q?cz/q6J2f5+cGICHL8J7u8DEgqXd91TM6xmvBhUOT3k9l+eMXvMLaGkoH74fM?=
 =?us-ascii?Q?lHDFkLchErSbWSIKbU1wapisVI4WstY01M3clvtxVLykR+GpOQ2e3tx3ag8f?=
 =?us-ascii?Q?tMTCKzQkd2vYZyIsSWhbPbKLZPSS1h/w6XJSJdCeudUev1yHjoRYXm9JnLtH?=
 =?us-ascii?Q?y29vamcLNQ4znSN+N1doAYcG2tzjVo8ujK8aEH4233nq1ZK59fxHc2Sw4Vtv?=
 =?us-ascii?Q?lwLIVJgxetj5fwCHK7IS5RPlW+JW/6rw4x1MoOGhqMlzyozm8zj18VT8myzD?=
 =?us-ascii?Q?VtkME+8s8sxjo26IHN2HmENjAV+1oi/ECa3qIpyemMUt6w+73yVtmqtAhX32?=
 =?us-ascii?Q?cQxGnRswNOb5VrUa6THba6v6N1TEKWKjO33oa+szRL2QzQFROVoIi9N/xqna?=
 =?us-ascii?Q?p10iOrhOl6NXlb9FTjz9hEGObs56H3A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a33a16-bedc-44a5-29f8-08de6b264978
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 17:35:32.0374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgBsjd9R/d2xwcpeZnfJgYaw4j3ZMAGf9N4LvXTlI5ziQtVCPc8K5M1mo7oshZC3vx3kD9kKBboCjPvaLS9jtCMMAt04LQBT0NIsZbU+4F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6085
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

On Fri, Feb 13, 2026 at 09:25:17AM -0800, Stephen Hemminger wrote:
> On Fri, 13 Feb 2026 15:14:00 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > Rather than disabling -Wcomma for all drivers, only disable it on a
> > case-by-case basis for drivers that need it disabled. Use a variable to
> > do so, to avoid issues with compilers like MSVC that don't support the
> > -Wno-comma flag.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Some of those drivers should be easy to fix?
> 
Yep.

Unfortunately there are lots of CI errors with this patch because I forgot
that the Intel driver cleanups are still on next-net-intel tree rather than
main.

For other drivers, I didn't actually take time to investigate fixing these,
I was mainly interested in the scope of the problem and ensuring that any
drivers that are without issues stay that way. It was only after it was
done that I realised how few problems there actually are.

> This change would be helped by fixing and introducing FOREACH_SAFE macros.
> I started that but it never got anywhere

Right. However, it's not a really big blocker here. Quick fixes to remove
the use of comma can be done without a major refactor.

/Bruce
