Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6D9CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 09:48:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A0BA402B0;
	Thu, 21 May 2026 11:48:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 490F240290
 for <dev@dpdk.org>; Thu, 21 May 2026 11:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779356923; x=1810892923;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=oNMqhsBPTysW2jyZb/hQ/LXtS9v8LEBA1jqyqzkESEc=;
 b=Y7jJTOUv+T1XKEI4XDQSFVAvGfo3vDp8garM4bF+a4GjppuDYfGqA8GN
 glSkmm2CcCQHqh20ccSEwIfXKyRYKQ7Kwk8xXsyGd4Wg8wNA3GuW0mUST
 izsRexvPkc2Zq7DzHq+5XJRW1Qh9DoR3cSehGIqOlZiw+IQ61SAeWukrO
 rDzCBxsxYuXuni4B/2bJjQFhTzKNAiWrQ1DBsCrVM4fAhOWnN1gnDB+pi
 lQHPybZ5TXdu1164lfAd4Wpzf3hlc45ZiJxRpnNkCekzrHS5fJ8aDEM4Z
 wrGeLv86Aeu2HfoSfscesIFFG47RYvpZMa9VLc08tOu7oMP6Y/ZLBzuIu Q==;
X-CSE-ConnectionGUID: wmBVaQM0QnqZ8WbJut9WvA==
X-CSE-MsgGUID: q3liesYsQKO7KGcgS8iHeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90846839"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="90846839"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 02:48:41 -0700
X-CSE-ConnectionGUID: D24QVHy2QGmdA7gYvU3M3w==
X-CSE-MsgGUID: fQdGn9WaTHOZOFI4As5A8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="270834986"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 02:48:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:48:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 02:48:39 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFNNSVuBBXt/JHOLxnShgAtlZ6wLBX4dgPW/83uJ3h+Hs4wGjrdBhsKQwdZqSQI+BABgn4seuejyQ9DmKJFZFr5nbvF7jGkNzanPQwcdjNHhPtTqIqbN1NuOIqiN2OX+eYrre/MMP86v3rggdRftIXUhNtcDoHLHZzeffvutDF9Hs/JWnSDa6T/7Shdmqnr4fA1gfXjigeIhGe/nkeVm/fDISN+YdhpfdJKOBkSYtEID3zRexB/DZAuF4LWb8KnKI84mWENOpwXZvuh6U+XC9c9Ld8DN1hBMwdUmEO2rH9gLEH7/N2I0C3bXzWZXuRrE9CkK8NnGzwS3LoHoZVCMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBQa1A9aR3nned5mSH87D5lQsH+ZWYEMv36iJkAPrcs=;
 b=JrCb/tJwkRRYVMK+a6wP9st8XWL/CnhwzcxB4nPwPxEl8YUsSdMCz/AWzbWX1BKRuZekmF2dCjFHsppsEwTDD+Pe36YxVVg8Ovet6e6Z1Y2vmIeUaveWb9o1bommVIZ33Wgs1zHI3RuFYbAzppHRlm6domIIDeJ7KNEFQi95Eb5s9/mbIGNJoJiLHUxO2PYjtap6B6S0Eap/IE1VpKZIqPqst2f+MvPb1GgoJadX9NO9v7cSoiXnMdlyWnUJRNFi90mr6WAp8N614pHOcfCtVX3wF/G6skIPMa6B9fbV8VoCE3cRN0o3Kw15qM1Swe6nJEazzfz19wIB49dXSEKARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Thu, 21 May
 2026 09:48:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 09:48:31 +0000
Date: Thu, 21 May 2026 10:48:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [RFC PATCH 0/8] remove use of rte_memcpy from net/intel
Message-ID: <ag7U6m4vjuvbsYXL@bricha3-mobl1.ger.corp.intel.com>
References: <20260519160823.1004973-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65883@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65883@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZPR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd79e30-fefe-49eb-80c9-08deb71e1df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|4143699003|6133799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: oCzsDR1evnZs25j7h2MZW0Xw7pojqMrIPQRP6Uf3u6Floaas9FL9m186L5aBJMj7/LrbMUbAlah3+BS+bX3zPB3F36nvtp+O/c0PJhe5bvWwBSh1rOmB7JKtKSSIxnXwRiC+nnBjomFITodTRCqxG8qFkiGgarsG7/W9mZk1A3OTIVqlRvBzdmh2CR5kGRLrh5THNYE+SjKjYzwQrfyT24NU/4mAPZRXScfW06Z8LqOll84EM+psAC34+/+WVqj3pFtBmXOCE4xFPJTfk7VXj+Bqs0DxBWAtXca8W0y2DJVpJykH4fq3SaNqMVPRyQidI0OXHjSyIEstEDPxJJBkln19WodS+A/jX3+p9m2J/HsLoK2hbdMXA7pceix5MEvhhuBa9ER1FdUB9arBRfaZrJirZyCU2UZhdlok3ANtp4sp5HMzr38RFKWGMhOuv1hK0iErvGRK+vZtpnAn9gAWn1z553uY9umHZJrfX3RBd1eRr9NH+XfgEkbnDsdOKIZQ6OJSHEzPx7iTbPDLmiMhUjzQ0t6C+oSwFY/0CPD5cd8CHWs2OHMPxoQAgwew9P+u9EL5Txn/nMmd9Ben6MC5oyGnL6BbQ81XBMtticAqQgOytRIRgDS8OA42rfKRiiQtzvqwOX7wj0OmknejK67kP89gVQ0AYrCcT5bVcFZRW4QN3R/fy4lr9BeCq2g+Y87y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XIMfPHDdzyA9Y0GimqfU1G2pOQqbhdVTgt8deaTGMAUXkPSZ0Ip0oIRBEX?=
 =?iso-8859-1?Q?68Uj4WBU8JNxUoPdFPq9Gx9+laQpTA+ffcU3j99GbhMIryc8WkRZSPcW9t?=
 =?iso-8859-1?Q?OgVIV9fEMS2O1DpfM1DlCsSn22ql/mBvRiDex4ZUZUEju69e5mcTZheVHf?=
 =?iso-8859-1?Q?oe8n/uiQG59SxQ4SI6cm47b5Bg4nrG0l13Hcp32OXREGGbiu+6Yyx5umBX?=
 =?iso-8859-1?Q?ZKzK54r3TXmXMPcfPuq1KvzUmFvhn2OD3SepkWMs8O9sXQPj8QRC4jvpFF?=
 =?iso-8859-1?Q?eMURvC+sFcFaLCyg5pDMjdId86QzKCctaT85ffla7LK7HFVS1305hht4Uv?=
 =?iso-8859-1?Q?1GCSBXlMqeC5ZLdcghhhC9s+HlwhmIm1H/WwzZQxUVm7pCPBmsDe+hvksk?=
 =?iso-8859-1?Q?HfKb+p8mg+hPEAnGx95y1KnAM4ZCkLmAZ9SUzmDxsGERTlRPJaCoWPW2ZR?=
 =?iso-8859-1?Q?mcqyakUWQVJ9KAdUTyjp0SVjWDzCFVk/+NegcmktPYLs8PfLSMkrr8YbrV?=
 =?iso-8859-1?Q?/MMw7nd5b88bPyRXGKGFrvWBEPj6xQ/H0aob5wI90pRLrfxEdEvQ7TANwD?=
 =?iso-8859-1?Q?63ccHKMnlih+91f6h6UnUb35mQHf1+o8+rDdjR5R6Tljp5efJHvEc0QJr/?=
 =?iso-8859-1?Q?Rnv0O3S9YeVsUdXf59RA/VNQVe/7FZmW2SZNj1cX6myq0+YqGem7WkFu7K?=
 =?iso-8859-1?Q?/QfaoG3aJGVevEiuc2Cth20ivmGtG52x0mtdSgyBAdX3ETs4vSD3mS57w6?=
 =?iso-8859-1?Q?fbu7qjpxYNT7Rz9XaxGPyvv/CQmynq45T91ZJ+3WiudvZOHhyIwGEWtuTU?=
 =?iso-8859-1?Q?Rxe6W7oqBdcNAMsL6/Pa2f4ODCSb7oZI3he8C3O43Yz5SE/IwqnzECM/VY?=
 =?iso-8859-1?Q?vW3KBgSLQc+y4nqnlB6Y8e+Tn5j5/hpRGQiyps7cTk1TCgmCIpCy9274ZT?=
 =?iso-8859-1?Q?l3wFHqFIyUGI4LvdPRRCCtYeYUJUqa2IeMLUG9gUmBLcjRzGmbXS4+Erwj?=
 =?iso-8859-1?Q?UTiMWCWMCuhg+Ez89kYPzKuLqLX3p/TYHpcpTOSI3a6nSsmtPfStxDApPu?=
 =?iso-8859-1?Q?OshbtxQ6beyDOhVbEJumQccF2mxMyJJtdQ3M31KcS4cq++700XNQ3DqYDA?=
 =?iso-8859-1?Q?Xtsj8sj4EjMtpHSCiLLVkYTAoBxavxEbrUQ2+rd8ggXI/+bF//nT/EqgOf?=
 =?iso-8859-1?Q?1CiiNd2Wk3HAM9s4GcQ7PQiersPai0NkRAYNYOpy0nw40ARjatAQncLuyx?=
 =?iso-8859-1?Q?3gLTGUqx3wbkkjDRRk+LZMMCbNuhQ8uqPyc/mYbqyTDUi01qihxd+dl/l7?=
 =?iso-8859-1?Q?nv2WoO1TwhCT6TrXjxUbd0yNQuFlZcHcd8mWooa9xkWUn9uZq+bo09XiGm?=
 =?iso-8859-1?Q?DgAEvWnzoAQeEQ4i31oWfGaDSvfUJ7UrdoeZP+zpxqEJTsg52tLL5A95+s?=
 =?iso-8859-1?Q?gf1u9SGJBZBKfUWQbhW6Ihpw2DB+d9kFOc8SDp+7+aEUIvyrd5fLcxU1I0?=
 =?iso-8859-1?Q?2Rb+jHHVpUxeuNVFb34gvflGFVO4HiuhEw4WZcEHYMh7ea3/RoQCYhQ9xA?=
 =?iso-8859-1?Q?FCGkXefajS+3f5BYpvuy4fn2QI3v/Ph7lZZkNvKAKKLLIhe6KD8J1md4Gt?=
 =?iso-8859-1?Q?WwQVfeJ6y1P0OluciEafl92Jmalxn1bNojpahwy6YFnv5gi6J4IlMqYCPr?=
 =?iso-8859-1?Q?aXgqzwMRmq4j7vnRb5JEKn30Kl9bFp0Gx00S8/TYirV+pS5jLp2e/1JcH5?=
 =?iso-8859-1?Q?nwN6HfVGvTabMdKdFv6mqVq3MfBoDP4thizjKEQ5MaoB8hghYKTqZ6MmcW?=
 =?iso-8859-1?Q?N6wPXBUdkRWTZP85uXvpNc0E32FP38g=3D?=
X-Exchange-RoutingPolicyChecked: dcwjV9I6SaiN2zVYS3kYAGT7rfmlBnJXOK9FEnfoQ+rn7d/MGcMROA+bvgIYTCa9DdYF+CVRfuLLiRaDbO3dIkWVw5UrAt7knXxswT8Jfgx5XGz8Pb593JvrnbKGEQgqqWGYPSbGwP0ugeqVRIFS6IKmFp/ooYR3gX8eV3i9Ik/EMaXMlUmPJH124NQtn1LtRmfWbP123Kw/0T0BnEgIkolGL4HkRT2FeJur5sv4nV+Z+O7ifxsAKh4TVpyksi9RJ5oXKdaNLylbz0qjtA0d5gfcV+PKRP7R9lBIyonHkLtOlzExqvP8OzhjHyRa5sidhAHRFkapDQH7Z5cfwBn8ZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd79e30-fefe-49eb-80c9-08deb71e1df2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:48:31.4718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+5jmI6U0AjOprZhXO2A0xCRmvRkHcCRZXKiV+fAWicWjmGx9mZX02l5sCjRO8tsBLKw7bb8x1/g49m3dyU4p4dxqwOTm/CiC4mOnPfe5Cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
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

On Tue, May 19, 2026 at 07:57:47PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 19 May 2026 18.06
> > 
> > This RFC proposed to replace all instances of rte_memcpy in Intel
> > (and former-Intel) net drivers with just regular memcpy. This is
> > done on the basis that the memcpy use is not datapath, but is used
> > for flow configuration, virt-channel (to firmware or PF) messaging
> > and other control path functions.
> > 
> 
> Series-acked-by: Morten Brørup <mb@smartsharesystems.com>
> 
Series applied to dpdk-next-net-intel, [including ack from Rosen Xu on the
last patch, received offlist.]

/Bruce
