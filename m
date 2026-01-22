Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40363D3EE66
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 14:57:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA76E40278;
	Thu, 22 Jan 2026 15:57:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 94AF84021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 15:57:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769093845; x=1800629845;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vnkc2VHsYcNnmyvCMBDkzijQiCmMkue+mBc4QKncMSc=;
 b=Yii2D7+L+hTn9P5lVmKpE+PDJ8Y2bAMCcKkAnOvbWEaAqIF1wvF0MbQZ
 uM496iSZm9oaxZPyuOtmTM3SD1Jx7RjFci/zNFVbjoccfD6MKVUqxeciQ
 wUkcfaTU+AL7xzJ/gI32Kygb8B0pg41jTZ/O6Tw7g5lMWie41hrkO3myZ
 4NXkusAjZFymF4Eaang3+EH7eBw/jvVUSJ7ri1vyPO3TGAeiw6GsWzMJ7
 b/vp0Ca7kVF6QruECiOOklqFjQIWLRWJPiOI6G2iyo7oR373FjUhu+aNJ
 Ai2QRGbiW6FsLOL78Jv3gjXnJqaV6f8jbmd2RMQT+55EzjfPgmIat27dp w==;
X-CSE-ConnectionGUID: aE0UMfdmTEWcSiIw4h7AEg==
X-CSE-MsgGUID: Oy71bYjUSIG7xg6gUl9XvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="80639521"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="80639521"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 06:57:23 -0800
X-CSE-ConnectionGUID: 3Sh26xM1TxSGkEMqIgxlow==
X-CSE-MsgGUID: XAM7V4/xQX6hEK3k8v73Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; d="scan'208";a="207088577"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 06:57:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 06:57:22 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 06:57:22 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 06:57:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH3f/2o0gj9z/G8hZCrrCZAYOIA3DG1+naQD9MU5fUd7F2L+7C5OLWhYA21zazxv1xYgXvc4xM79YsTY3L8Mj2AbfdJZQMg9iH2CaCWL7P95BncmvSlHcxdLAhpyICkGJ3uSZv1hTok1s8FmNLmQNo3UGnXYrzptV5dVP2YoVngfJDpmezYZBwYm2Vc+L6tqdFi5BPfpeyjMeMJavjYsaSOBhACpG6kZmenLyEfnOV6oAr551GcFc3Vn96Q1LHbiMO/4B23IfN8FK/WI0TVk00U9Yj3JsqRBOIo+Mlf5bBDRdMatBHFgDSqmqzCusrFgtoVhWhZ3nJzbDL6XC79vqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbImchuO87fTU+IUWD+DDYBHeOXrhTqwTtGfnq257Us=;
 b=QJ0Wv2rZP1T5V8vDiwTXKbc+EeWJbwnloQaiQzEnup70HZd7KH9QNEvMnXH7lekbEilDK+4ZtUl4yLpkMiukCxVqAHBdzw48VFOkvjpSP4FduUOF394Hl5uIj76vbsEb/CK09krheXbKwulHQyuYBMpDf494UGDDXtouSgWARAOpYg64CK+XDa3Sq7T50OLOENVJrXBpbl0dseOKChXzik96SC+OUv78SNnRDgGgvezxCxZar82PtENVQQ5jdAVDvF/E7206GozDwsaBUZnt/rwVJAz3dCCSGu1j6UVXR9D25STE+nOFEd8jJ3+INFz/2X0br3YB6yhSKM5NAhamfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5114.namprd11.prod.outlook.com (2603:10b6:806:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Thu, 22 Jan
 2026 14:57:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:57:19 +0000
Date: Thu, 22 Jan 2026 14:57:13 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, <stephen@networkplumber.org>
Subject: Re: [PATCH 3/3] drivers: always enable the null net driver [RFC]
Message-ID: <aXI6yQwW6GAXBacO@bricha3-mobl1.ger.corp.intel.com>
References: <20260122122354.1820368-1-bruce.richardson@intel.com>
 <20260122122354.1820368-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6568E@smartserver.smartshare.dk>
 <aXImy8tDAqFygz_T@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zyEbVUOJsw4ZwN8Zdcrb-C+=tF6gYn0SYm-zOc9Aoy8g@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zyEbVUOJsw4ZwN8Zdcrb-C+=tF6gYn0SYm-zOc9Aoy8g@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0103.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: eaab2920-d9aa-4cda-ccc1-08de59c68a07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18082099003|19132099003; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?VR1oAYb3IW99Rccn6rEgHT+BanaE+1CQV8STEPfr2SsGMK6yH/O5fH0J8W?=
 =?iso-8859-1?Q?q2FZ+FSCOGZFT3X8wEaUS1jJfzoabm7N8plVn2dJUbKdk3XjrbCo6YFTrD?=
 =?iso-8859-1?Q?WIeflc6cRfBM5JVFi1SexhlyK+cVYaY797sPqmyLcpFfcgccGohxe7a4w6?=
 =?iso-8859-1?Q?4VP7Pjpg//z68NWp2E/LUVW0mm65Of+BJK+VLUd/+/0vspk/L1vC1/OfJo?=
 =?iso-8859-1?Q?N78I+//UiRMwIDHKsLjkGZjjGId2oL+z6+keCjpuxYmcSMUMrEoY+YDnWi?=
 =?iso-8859-1?Q?TBZZqUCJ8PwLnfjkSsJ3AIXJDFAvP3iwJN5txFjSbYZ/KXYIHl/v+HfQxV?=
 =?iso-8859-1?Q?xl8pJ17qiuMeUV+GRwP5tGcV2LKtDHNk/p1xvqK8zqGsvOu1Mn341HQmsN?=
 =?iso-8859-1?Q?qJpMBIsb+LsLyyPZ8OjO95iDliZsPOpKVCm9PBJF1A4ByVTdIJclVmL8lh?=
 =?iso-8859-1?Q?dzSmKirR1HgMT8ucireFEwtLGoalvNLhR/q2C7jPOicn/uSs62kxPQeoJ+?=
 =?iso-8859-1?Q?IMJvZtsNokZbpjF2fr3pTm87memD6nxkj8k3gYyrTjg6me7849c9N/+Fjw?=
 =?iso-8859-1?Q?FgNKHus6MW6FXtLeiI9ss6XYJ2IqsEAMv4fYfjZPbABPGkxL2O0Lx3KnAx?=
 =?iso-8859-1?Q?PKd5gAmeON41PG3tszy59aFlRTAC9KMmbmgf1pUf2TgIr/mm/Pzsw8AOxR?=
 =?iso-8859-1?Q?kfafFB/qLuFB1//6AuWC7MZuA46dGmDaO16lUmsC9/nUN1nIPTfTm1A7QI?=
 =?iso-8859-1?Q?+tiSh+lA6iQ7S+l5yUpQ4mVqJAtKgCI54hLFlrje7ElUKrj9v4PZmG2ACW?=
 =?iso-8859-1?Q?f+a40dtpwQ2jRNCkfZ0k1ZK9IdxyDEs6GVC0HZgI8lZpsS9tfXqzVSsNEj?=
 =?iso-8859-1?Q?cOjL3M1a3nSNji625wYY1sKLRc9RyPM9+MqbtdnjxgOFGsn3F40f80PBxu?=
 =?iso-8859-1?Q?C5l5KFL9pfcjULUXfbd0SmV5oHYSoBMkgtjrYM8APVJyr56t5/ZDUSclJi?=
 =?iso-8859-1?Q?TltsXWgKcqS8AKZmm8vF2ARWa5bs2j5GF+z5l7L2vya53VpBDsfVf/jmsX?=
 =?iso-8859-1?Q?tjdzc907fF3dVvb2QeqdcXhhYpr3pJPWhOK8HlHz2Cz/wYhQCa/RsjIcEu?=
 =?iso-8859-1?Q?f5KqpL1kjJyvEOsbPEB4r8IUbtSAVk3cu3BywHadpMm5N4L629tjbLCRy/?=
 =?iso-8859-1?Q?k21MWf9Pq+05Mee0YPfFyUSetqu9nSTZbgbKuhHHyOHpc55uUQd81+5lwO?=
 =?iso-8859-1?Q?Ft+n9KZjm7RyY1rnvhvALijpXSB3b41o8nslA8h1oqd8dvbQfRnUScEK2l?=
 =?iso-8859-1?Q?hLiUDhdFuYENBNwd4uKxKVYynYBBFJjc/BV0BedybjB2A8nfc/miDITex/?=
 =?iso-8859-1?Q?pHF4HURguGg/2GkO8ONPYYNPmVuYMf1fuscp97LDb2msnEr5zY9r07u8wH?=
 =?iso-8859-1?Q?jrDrF6sdAh2qjMKw59N0TOjNk1Ksp9M0+DrSS16I0GEKn6EWsp31VVZR9/?=
 =?iso-8859-1?Q?cQkMP643aVpdITRRC+sLn1jN1VS6XkMZLWQFwsTdW0lVxl42z9TXs7a2SW?=
 =?iso-8859-1?Q?fbu809jpBkhWfGCKn5N2gtNYa0vnNnRHHPlL8wZd7+HK4b9fpX5wKLZwOW?=
 =?iso-8859-1?Q?z5ZX3phl2DhvE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18082099003)(19132099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KDsujAyUHn/RUZ9rYfvf1wacCxsUOIZo9HkTFJiAnnKK694BrCuFOWEnsC?=
 =?iso-8859-1?Q?cONp+BAOAdxgPe/c2Mi7QRgkYX/j9Zgg3fIMGBoO61JTxs8vtn8t6zz/c8?=
 =?iso-8859-1?Q?XmcpbaxOsuBLGXBcV5RtbCqmxrD1n43ieB3dZfzgDVx0lXMaFwQB3QX0k2?=
 =?iso-8859-1?Q?dYXjw1pSxvTKfiZreT1yEAfpqQwbKdpTdX5HgG0dtJRnvN3S42QXH0vctI?=
 =?iso-8859-1?Q?Yub7lNeHk8GWrTCK/VncydgH/1w0JWayDdimhymCK/ldl14GZiywS3E5v6?=
 =?iso-8859-1?Q?06Yy2tO/mSPgwqraZA3pahlbLg4Rx6FGCwhKBL4Blfy9rkb2/cNDyxAHTh?=
 =?iso-8859-1?Q?9/xfuGpUOk3EnnYvynRVy+S2ESxpGJYskUG2XpPVMRrP3HcI26fDJF1THM?=
 =?iso-8859-1?Q?QNlGwfRxd+i2kDeqB800vHXScjg63k3qNUlN83wpomzWXCGst0+BRnhg/u?=
 =?iso-8859-1?Q?PHruQLgxxjftM89t5bh9LIWBuTdnzF7jD3YvltbJPl5gcV7dSa7anrflyk?=
 =?iso-8859-1?Q?LCY8ld9ZMjqMKVzE7cKLhbKlDvUg5fzM7mD251XlISHX5s4Jb5IznFBrIG?=
 =?iso-8859-1?Q?fBEhBKxgDMzfYc7Fm6mOLC+fsVDZ7b7n1jTC2K4gukeKr9eXr3maHEVPaQ?=
 =?iso-8859-1?Q?jdgAsG/zzzQFwvLIhdfbn5UEEHEzyiTOkfS/J97aTB4BtFcCF8P10O3U8V?=
 =?iso-8859-1?Q?KLK3dz0XgDnSKe8yILl/YdI5L1LNyjGKFnDEbR1DdpnIgDOAbIXcvqqn7W?=
 =?iso-8859-1?Q?OzbHMV2CJgel+6f+8vYZ/rXJyNr/7MuJHRoPd21NuVKBRnSdqP5rcU6rRo?=
 =?iso-8859-1?Q?ZMVuH8QXexHLqRfcFlKManhBFrRIdckE6yXC4YHV7UfOEB+xHxHQPC6usP?=
 =?iso-8859-1?Q?ibuXhQE9YhDrrRu0s8lU2+vjEYzHdaEp4XydAuYPaIgF8iqVavFEr5rl0F?=
 =?iso-8859-1?Q?1Tln8CfzhprcmLAsNO7FL5UHp6laVRTAoOPD1lue/KT76rh1rCX3p1mYFI?=
 =?iso-8859-1?Q?20HYlxMGtDsjjeLXETz+/4qiFuefGqONcY2nN75wImMw60hikodQc8wlnD?=
 =?iso-8859-1?Q?OXZQ0kHdFkiZcl3TQZrXsOGohTLPjcVYNuJf8Lz39vTXfEB5OcilbBaHGT?=
 =?iso-8859-1?Q?KuplRftg7Kz4HCp1EnNLfBvf4Koaft1x0m/p5MgJWTWUOZ5YPYUUp5DXza?=
 =?iso-8859-1?Q?6tnNcUI+sHQ+nMJQjoupVbjstHiyVm19m4Z2LDrznoBC7ZmXfoHkbTz9tx?=
 =?iso-8859-1?Q?qFvPeHIA4cXuxYUdbY8LhF4uTXCmpFu4Ds2G6ApO6YBUYxGYN5VFAI4dia?=
 =?iso-8859-1?Q?SvfY/5eLaUosqfOarMpdfCjRYbgSys/accmNxOR5/uHxMWJuFqPZAiMcuy?=
 =?iso-8859-1?Q?mezkGjoy0MhkZLQCnycdf5d2ZQKKTlr+VyYaSr/oIYqWZTzB9lpRiK/Dr1?=
 =?iso-8859-1?Q?sjWitiVaMxP4ErYPAFjeuLySI4fhg2ue4pNU4px2Pz5sxDB6dE6ECS6Ynx?=
 =?iso-8859-1?Q?t68SkmP7z41nBhklMuFsTrd30wT5KZKAoWeFwCYzpLp38X9hztG2ILmH/H?=
 =?iso-8859-1?Q?jHRV12GMqIkf2YyaXmig6EpmCQSZzDHUwKKjA5+W+MZlA4LpYh/TeOVrm3?=
 =?iso-8859-1?Q?DvbPqBpn+GgxUmblxSGHZ7CR3+T7FKgszEsBzfvmiUaY0ieS4dEDpQY1nF?=
 =?iso-8859-1?Q?DC0ZwM20d8AX8XOF6LlwDL5vZihs1+MAW27pZfU0p6AYG/MOUk36mwe0BO?=
 =?iso-8859-1?Q?Iux8SDf/BkcamU6PbN3tJZV6w8Od0u2kwF+Bp88KmrFTmKn8MQ3obFZjzb?=
 =?iso-8859-1?Q?y5omGPWv6howNuJE9Fv/fFoK2PvVj8U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eaab2920-d9aa-4cda-ccc1-08de59c68a07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:57:18.9808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU9Ed2oMetGX9mPwwIzrJDqyRIiMSV533hvYSdPXGelKypAIvhGZ5RCqAZeedAGtgYODVmJEzmYMmON81P8BpXFD84xkSaPpwzTUHkIVabU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5114
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

On Thu, Jan 22, 2026 at 02:47:47PM +0100, David Marchand wrote:
> On Thu, 22 Jan 2026 at 14:32, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Thu, Jan 22, 2026 at 02:13:06PM +0100, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Thursday, 22 January 2026 13.24
> > > >
> > > > Having the net_null driver always available can be convenient and
> > > > allows
> > > > use by unit tests, so add this trivial driver to the always-enable
> > > > list.
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > >
> > > > ---
> > > > I'm not sure if we want this to be always enabled or not, so sending
> > > > this as an RFC. I can see definite advantages to doing so, but I also
> > > > dislike having too many components on the always-enable list.
> > > >
> > > > Since I'm ambivilent myself, including this patch so the community can
> > > > decide.
> > >
> > > I don't think real applications use this.
> > > If they do, they can include it manually.
> > >
> > > My main objection is:
> > > We are setting the wrong precedence if we make stuff like this mandatory for convenience.
> > >
> > > But I agree with the reason you are suggesting it.
> > >
> > > Is there some other way it can be enabled for unit tests?
> > > Maybe the null driver can depend on the unit tests being built?
> > >
> > > I don't mind that the driver is being built.
> > > I just don't want it included by default when statically linking a monolithic application.
> 
> Same, I don't want a driver with almost no maintenance on it (even if
> it is trivial code) to be linked in a final application.
> (it would be a pity to get a CVE because of net/null ;-))
> 
> 
> > >
> > > I'm flexible on this RFC, so it's a very soft NAK from me.
> > > If it can be disabled at build time, I'm OK with it. (But still concerned about setting the wrong precedence.)
> > >
> > Yes, I agree.
> >
> > Why I'm proposing this is because, in order to give me faster rebuilds and
> > because of the hardware I have available to me, I generally set up my
> > builds with "-Denable_drivers=net/intel/*", since that really speeds up my
> > dev-build-test cycle. In doing so, though, I do miss out on having some
> > unit tests available when I run the fast-test suite, which is why I
> > suggested this addition in case there are others who limit the builds to
> > just the hardware they are using.
> 
> Unit tests are mainly run by the CI or DPDK developers, so how about
> putting this addition in the always enabled list under the
> developer_mode check?
> 

Yep could work. Possibly also taking a modified version of Morten's
suggestion about warning about skipped tests, what about just emitting a
warning from meson if we are in developer mode and we haven't the net-null
driver enabled?

/Bruce
