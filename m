Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FA6C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAB07402A7;
	Tue, 21 Jul 2026 14:32:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id CD23540294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 14:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784637119; x=1816173119;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HKhIXBKIlvo77ASZc297fcdvDFzylaUFCjHPLKrwXk4=;
 b=FqU/ywhk0HoWx6Ng0NjySC34otTDwyfiKfwL27NnIn+KWHK7uiAbpNc5
 opas3uLiMmOyZOx6/LWD5utz72RmT7aGAUtkpKn40NpiRggZXV9hmTufX
 /dfM0rn+X0TctElpwv5sUynoCfk9oSAL6WmgXdDsTMJ4OiZTNJWkVXDbY
 rPXB4yp6dmHZDyMMnGEjxGzcq91CXGhCsONmrLYc8KyJeNFjzVTRGrJoX
 SycK/a+UanpOiMRDkpahTs47303sgAQNzpkRpue8A8P7YYpS9+lpegm9n
 fW093urJGlBiC5qQ4Y5A6VP3MYaR1JyhbomUHv2oZ5ny+3n2c1NaDIRro g==;
X-CSE-ConnectionGUID: Eib4hZZzT/yTGIiI0XNXkg==
X-CSE-MsgGUID: pTCqC0vURiafLdCyZHop4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72772963"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="72772963"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 05:31:58 -0700
X-CSE-ConnectionGUID: tg3D8GaIQyma2+ox1U4YBQ==
X-CSE-MsgGUID: HCLi/noMQXCtQ9EsHSP3JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="253386394"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 05:31:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 05:31:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 05:31:57 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 05:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAZ7EyD/dNm+tODMQ/k199NmEbijOmnF6cqFW1TnUQT4O7mJb2X4JcXjdRPc3G+C1rWH8Rk3hIYq/N7lvgLDX06sa1t+P60sDmT/kn25yxvi2dv5j4b9UI24VLBNKy1rbd1XUozrKzmgkwOtbf/Jf2BLYwHITQefgMQhf4/pjnWKH0vw6ida6gA2StGkOKbsMldvOlVSpWC8Y4iU2Uey+S6flJ3ptaY1HszqKcKT+hOncWSUwxFhIwLSQlS1u+y9qyLzyag7wZFdRSiRQ3FybxgMLWHLxI+mR4of0h//PyvOd/kGFEyfrd2CyEr6rwJFxFReyqC8Gf/wdiqaPXkxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3eM2ehsaI5TzWhuZAUvjHOCDYN/SLo8WiNnoWjuV2Q=;
 b=om60mOjMGRexJZeaengTyOTuik0BeWpQEsHTZiMzyhZAaHqIxMUoy/nxfKGWZZ7+ZRukoo5J2DS7aLJJzzKXUkPR1bzquikRzGQnTkL88axzdwA+W290i3UbHwb4kKe07K/zB5b+1KDcX7B3WLvmq1YOU2IiOqCXY41kmTIT4lYPULHOSFFZroqEXXFA1zGr4oJi5182dCjkcXc07F7hKc4UjDdxwqnNgYduBzzZVKKizIlZw15Q2feI70Cw5C1GWxpQPwhVIDTuvOpqG7206pw6VO8vgx0icYs0pmSz4UovCMdPDpJ33gbHGg9bNvORXHMPGr+44zmzf8aBYGxJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM6PR11MB4660.namprd11.prod.outlook.com (2603:10b6:5:2ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 12:31:55 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 12:31:53 +0000
Date: Tue, 21 Jul 2026 13:31:49 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Naga Harish K S V <s.v.naga.harish.k@intel.com>
Subject: Re: [PATCH] test/event_eth_tx_adapter: skip tests if no eventdev
Message-ID: <al9mtTZKpLuFomzl@bricha3-mobl1.ger.corp.intel.com>
References: <20260721115635.2209399-1-bruce.richardson@intel.com>
 <CAJFAV8wu5ZF9gtG55eZKvSz_J-sE4DShoEX=_ZKXWC48+MMG7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8wu5ZF9gtG55eZKvSz_J-sE4DShoEX=_ZKXWC48+MMG7g@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM6PR11MB4660:EE_
X-MS-Office365-Filtering-Correlation-Id: 900578ba-fb27-4c02-b9f1-08dee7240bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MScviiOlTm4LH5oYXstBLzg0xk+P4YtxwwVjuLcdKPWyYYiI5gweeB9Vq0tbVqd0HYY0aqFSW2aZgw8i/Q+nhID0c859mYOU/mJ+xddYFkDByiMiCXGuIvVALSsA7Lmtb6S5XVtDm665m5NuRBjIftv4HG3AJw+C7KqBiJEbGcBgPAiTeRX23buEBL/hQJWrB/U1dUnnlP5XkXGD235XIqazxOdhv8PyR1sv1fGmAjaT9zxWpRPo3Hb87knRjbE2hGZYE04+2VT5el8Bju3vhLUEWm0CoH1Bum0CUNZjnahalw+bnN8mv/6xSFvn146nyYfY3BfrAFtSR5UppNFqY1SV1DFNbJdmO5a7lqoIL9Rwsvs/6ZGc6oug1C+ASGW4dGhXsVLsayK5HvyWK8XcdGTjIk6sadMdO4OV41srtik5KBTA2/8FBbJICups6DJqpWZhgL/uYn/A2ip4SjfStYa00WxfTssF8KwWkY+4ggh8y69OjXZipuHxVWXyWHYucUd1A50NNiX327g2Audt0dddzzRXhq0tA5SwIOl91A40lXbC/fVAAjMdr5aMa8MGVb0y36SLKtB3vAoDzxitAzKMQRZXQQbcXUQEG4exdJeHYYi5wCQ3aLVP39ALaIHYhTnApjZMT53UGk/o6F/l4gNE3OEvxvJA3G/3ZYqi+ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnriRujiZP7W9stDKTc1GWGZEht0r1vViOISydfzJ29Tip0zcm82J/QgWzD+?=
 =?us-ascii?Q?ewNAX13lJ/H96sKdI+HxZOlyuzsZrpAtAikg53ZP4aOjKK0CuwPMef2+IXXG?=
 =?us-ascii?Q?UwjbV/T4FSXTXRa5ltKcJN+E9j95UYJgzKGCagMULQNsX7EIB5ng1SG5AZ6P?=
 =?us-ascii?Q?e6qt2LeuA7bxEIZjBG0Ut1HLzzJvFfINBhCC7XvJTXOBARGzw1RIINnkCP6e?=
 =?us-ascii?Q?nR2Ak9YYkY8hSCypLZsoOLt7lj550M6zqpsq8wyYvNa+R1RPlOnXH4Qw3u+n?=
 =?us-ascii?Q?1P4BlZp4YKtKV7xTnX9TcOep7uuTGy/P2ur3MpuPPECfagN82eOR/aK8HMZU?=
 =?us-ascii?Q?rTeUEG7DDHeR7v01fasiJEtsxpvAuTRYcH4iyV0tqwtaPvJ6s7EYafw26GTz?=
 =?us-ascii?Q?1Rm7TXEDLxKTJg30D7xiSvcBLxDszm5Q5pipqM0oOqc5WRdg5NPKJ7Wspngo?=
 =?us-ascii?Q?P0KHatDOt0O+8lbkjwyImr0T56ygK3hhLAW+x3Bi6g4z5rkogGmGmPdFCGG2?=
 =?us-ascii?Q?hGBTIwYymMM85tMOgU/Nfdwykw9WCqTA+yCFHYEo2VS+gaOLZVpthfz5uPmm?=
 =?us-ascii?Q?uk92XB8pBzw7dHb9PwaCHRjWNc6QERDB/oM6Chttz5NapKywfEmHtvbRDES0?=
 =?us-ascii?Q?aXNGXfT4UlTIT9cU2mEEgEEjOtdOeN0yTNe0IqIWNpfVb48jzlQzLDf/O2y0?=
 =?us-ascii?Q?stl+lZOLUKTxOsdh8g5XdZGgdsmIi0oX5zPPAXg5GCZ5VdhwX/2Rwi+1FDFV?=
 =?us-ascii?Q?hcpbTaMfwC1kbB/GRgQxHkFsnKHX+4Mgk0eut6g4yjeOBgyXMNl3ubXAaBQk?=
 =?us-ascii?Q?nV55dFtM4BwLwjn1jmQLhVGQcPCdrijqxrclULoqDBdOXRYCsV4m7TG3LpiB?=
 =?us-ascii?Q?GbBxS6JJrC287zOeGRKlcOHSrL3LWNTb86GZV4/SYeJ4zFQsi42ttGgZpllI?=
 =?us-ascii?Q?ZT45BhOoD7hj1blpvHJR7kfxByt7dR/aG8oXnTWDq668qbqc+iWc4jyuiOpO?=
 =?us-ascii?Q?CZTFSq31JfvPuRFRwzWJ72EuOvMGatU04REExR4/2UVaF93L3Nw3Dqw8Mn6U?=
 =?us-ascii?Q?b6B1DHBuc5Thqb9hacDP7pTuFANxDM9zm1Jf1DzK/cvSqYpsqnKWQperCTOq?=
 =?us-ascii?Q?gNXSFaz6dCD2pJa5sQGI+tDVhIc4uHEF8ffXZguEHF4QbwanhBDnbX41YRz/?=
 =?us-ascii?Q?Db1rjo7WpSulw5e+2cgFQV3gqUQPizyfEGSqMsRy8JjABe1wkpK7QpUB+OLu?=
 =?us-ascii?Q?kkmRdbypiBELPJVeiIIArFc4NH+oaw1ixrQJENvJZoZTETou5SCTwiAdAj7w?=
 =?us-ascii?Q?KjFFtcBCsfz3fFVY1wXEJ1qTNLwERADGzB2QVmG5c40NT3x3hq7rV0dVYOvK?=
 =?us-ascii?Q?xIWsveiKT9zfWwWB5jhJbndDfl2l97dsG3I0XEloA9YczUTKnBrqIoJg9FXd?=
 =?us-ascii?Q?c6yb1lPXVnGKPTuRXbADVtRcIzAjC4NCLkPRHOzx0Wd20uF9fEguRGxLGS0F?=
 =?us-ascii?Q?SiPPg0aptqmqoGEUtMdbN/DpDlKyU3ydR8+b1RppEraux5t9U3CK/Wz7jp/n?=
 =?us-ascii?Q?UF3q6wE5JsM4RWaaXlvCgtx05Y1Lo7zYkGYv1/jHMMh+VkMDKmnva3Cmhf2e?=
 =?us-ascii?Q?M228awbxomSkG+NTANkyuAUYfZxmKrjeZC93Rr5IM38gLqci/PmhSKwL4SNb?=
 =?us-ascii?Q?xBQ6gjKxvPrKS2hIYnuVJG7dLwIkbZBhpJ5p7FWC2Vb25j5U+kaOfrasf1qn?=
 =?us-ascii?Q?gIJnd6/Cx3/vBY3JcElH2kqddUOURkM=3D?=
X-Exchange-RoutingPolicyChecked: lg2hX2+y7sfxiuOs8jz5U2t8xIyVGtY2L/KaIxpi+8gPh6wwQbHOs+M4htP9GDCov20vCJZ1m5B7HThOnqfJjDKIvyoFX2DP5ndYRfSut6c5+yr2j16oNCEYbwPa5Qv/wSnyo7yqr85FwELjrFAzcN6ZWXX6XgvAq96pjEEGD19tlMD1VI+LaQzEJ6qU3D+/np3tkyhlMw8I7ba4FlBDXYmLCn5G6WIApNAT+1iO4cWVvHie/RFWahdchGtQzGnx5TTkvW1MYowM3n9igZb1yz5pOKZ/uP+ZobwUMVrqi2SfzJ14EenmXajuXfYnXPFwo7ovkkDh82dDaJT4wmqhRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 900578ba-fb27-4c02-b9f1-08dee7240bae
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:31:53.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuDRiav6KM6wTEmuVSQjnHahsEna3t4nYXa6q01xkI78wqUXvADu0YdtIw4OAU/9BwcLTeSt+wQNXEdeHH3l4H4dQpICjv1rhJ3GPhr6Wk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4660
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

On Tue, Jul 21, 2026 at 02:07:23PM +0200, David Marchand wrote:
> On Tue, 21 Jul 2026 at 13:57, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > If there is no eventdev present, and the SW eventdev driver is not
> > available, skip the eth tx adapter tests, rather than failing on event
> > creation.
> >
> > Note: We keep the failure case where we do have the event/sw driver
> > built, but fail to create an instance of it.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  app/test/test_event_eth_tx_adapter.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/app/test/test_event_eth_tx_adapter.c b/app/test/test_event_eth_tx_adapter.c
> > index bec298a8b8..18801028ce 100644
> > --- a/app/test/test_event_eth_tx_adapter.c
> > +++ b/app/test/test_event_eth_tx_adapter.c
> > @@ -202,12 +202,13 @@ deinit_ports(void)
> >  static int
> >  testsuite_setup(void)
> >  {
> > -       const char *vdev_name = "event_sw0";
> > -
> >         int err = init_ports();
> >         TEST_ASSERT(err == 0, "Port initialization failed err %d\n", err);
> >
> > +#ifdef RTE_EVENT_SW
> >         if (rte_event_dev_count() == 0) {
> > +               const char *vdev_name = "event_sw0";
> > +
> >                 printf("Failed to find a valid event device,"
> >                         " testing with event_sw0 device\n");
> >                 err = rte_vdev_init(vdev_name, NULL);
> > @@ -215,6 +216,11 @@ testsuite_setup(void)
> >                         vdev_name, err);
> >                 event_dev_delete = 1;
> >         }
> > +#endif
> > +       if (rte_event_dev_count() == 0) {
> > +               printf("Failed to find a valid event device, skipping test\n");
> > +               return TEST_SKIPPED;
> > +       }
> 
> It seems strange to reevaluate this part here.
> 
> rte_vdev_init succeeded but we still have no eventdev object?
> That should be a failure to me.
>
This is meant to catch the case where we don't have RTE_EVENT_SW. However,
I can rework the change to avoid checking twice in the case we do have it.

/Bruce 
