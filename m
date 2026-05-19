Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9BACD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 15:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94DCB402C8;
	Tue, 19 May 2026 17:20:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 2675440296
 for <dev@dpdk.org>; Tue, 19 May 2026 17:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779204049; x=1810740049;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=CeevWpAyWrIvWKoW6AHmwncIU9MFdDptM63RHuY3ymQ=;
 b=JFfTrhqKVrJt1vu4OWCqhy063+u3DDxndNE34tzA0gt62Dk2rAwrBseM
 P0xRVGmyW1fMqK2oaTkAwLPvDeK5WXoqci8X3oup0wg9eFNX6DvubqI+/
 biQ4qrtPTlCPv3WyIEYjiCv41H5Kl8kY5c72oKiQnJ4dhJrtNb6KWjgXe
 Wqqg5YCZ1Bjc2efZV/NArMWc9cut+CD+NvEtKCVAnX+W7wTIlOEgJTces
 UgYZKIYfV2Dd/dY4xVDpVSHO6uu5XcA9d8ws8U0FNUXxIzdfDlbewBJeo
 F5StXZvu8iGqJ9o1AXnetX+ly5sSI02ir3rqpsY1IQszKNBkJiaG792sS A==;
X-CSE-ConnectionGUID: LMRFNMp4T6i3I31kab7v5Q==
X-CSE-MsgGUID: LKQwOS1jSy6cBbf3umB8fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80115631"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80115631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 08:20:48 -0700
X-CSE-ConnectionGUID: KpWmLSWETKil4Ii11fU5og==
X-CSE-MsgGUID: W1ln/7imR8mRWMtITiXSqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="241630746"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 08:20:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:20:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 08:20:48 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:20:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGGpX9u54gx0TIa7tG4MaTHNkA0DDOUnEFc5SOmtZtxa+58yaHYr9nMmRH+IhLkI3A0RgmOGdYrHvaisBMldcJ3kaypqN8+AaJH2iNG6EnSIdG/fnk5yiDUSNW4irbGHCO37mwS1vBG/8buuESQi6pWRYbV9uzHhVmdaMeFkdvg9Pl4Aij72VyYLs7Zk0Aoyp7kxZXMilcJRF4In62Ghfb/9/6iXkG95JbPssAXaL2CXLHrrhLX0ec9OEpW8XlKF2jbUHlY2G24SPgC+SGrNRAcbhUl8HlOFZSJWR37cLUR5L4oYQ1GmQviAtHAeAFoNN/E6BcAVK8f7L+6UmlDWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfusX3B/3AS6+8vqvJ7RC6dVmc5SGr/HG7RC30TpbkM=;
 b=cvCf306NBCml7VdEhecJioWH1jrgQMM7CepY/zhsQHx1Ubb7ZA8EhM2BXxH8WmEHiDW4VzXChAzQ57qYNBWJ/DZvoAFZhF6cbkdkNQvXNa3TQGodfhB/fJqzY0QIXtrPba/YyYYo3lkMBJAuRgtveAgf+OJjKkDQ8JIdroIWvGy74GJQLWtNb/5YcqYEmVqBLpPHORKAwITkODeTV3nbNNUJ/T+2Pkuf+rvHJxTKbh04jg4Sqd+NzRxHinL/iBMJYWO5W5qj5Rk++9c3FBlIVFRtwTqHJWljF9/DsgHdWe1e2I+b6u9giCBVVOmMa/ZzwF8REpqLAYxFLCIDFJrXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6826.namprd11.prod.outlook.com (2603:10b6:806:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 15:20:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 15:20:44 +0000
Date: Tue, 19 May 2026 16:20:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <dev@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, <stephen@networkplumber.org>
Subject: Re: [PATCH v1 1/1] net/iavf: fix large VF IRQ mapping
Message-ID: <agx_x9w1YDHR9Wg8@bricha3-mobl1.ger.corp.intel.com>
References: <c50ef6c3d4ecaa7902d325d5e8a7fd4c92c8eeb6.1778076415.git.anatoly.burakov@intel.com>
 <CAJFAV8yNKxSXjmjQ0sM21-6hZDTVrGT9cpZ6aQU_FNTepTP4nw@mail.gmail.com>
 <3b9ba191-f086-4264-8382-653c06772e17@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65861@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65861@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: f73eabec-20aa-4c47-4c43-08deb5ba3225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|3023799003|4143699003|11063799006|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2IGyRDbNWt/Nl6jozccu0wPiMfII1e2AHR0Pm78PvvjdMMi6kek2bcj99HN/9DqhU3DeWSpbQnlREmPiz88Rq7jI33E+irsIgwIF2PzWjTBkBHmOVyHtYoGVycLxDQqOOruWeAEZQmsw/+GI9hCu0d0Dm5JEgu5JA3urvGgOVFpCh7O1quRrfJM4oiY/doJBezEG+RC+QyMkOXQEWu1DLLcApd775IfCpEvoYWedWB2gNXA+X5BuP0QbzcTuhg2FdWqf4KTCZkrjo8tdk+96ZdbvDoCSzNyx1d0bf920YwO0virhNmhjQYzdbX3KsBI08DZQ3WrTVhPPG618yLfz/TBk7SgKeLnlVTHFRl33aRVMr5ACR3kFFvBilSZhIQSGHdZ+N5uqbZhrJx5Z3Ps0jQUpo7l64aIJqLk6Ke6ZLF9zexEJbArrVA4VHDRacrVXForIq/zlsIEvLG55Lk0GnADpC3GOKQxh17gJekD5XFlIcK3uxedMGexIv+oNfHS6ASBq07kpkEJ6m7g+G9xccVZ9EXoe5QKEqopwyZKtAbG0/wOF/XzWBBzRGNy5yBJME+iVwssF9EAzJXJa65t5AbG69MWWH5D47Ts3BNz2VFMTUGpeUEaD9airMfYbfT37rWMlllrfB+usge8yUmJ5IZ+p0Wng/h/VSVLArq6CU/v49dYejvi+wDm/R+BzIy6F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(3023799003)(4143699003)(11063799006)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wDzZr56GTZHKFYjGAcgSi7fpAQztnTFshSKfb9V+5nNGJqrc+n9umFCHwD?=
 =?iso-8859-1?Q?QeYLvH9qFbnSKH5ZFWtfHrYh1RPQNbM8LDiRqeKpDvjsP4BY/D4cPmT7pM?=
 =?iso-8859-1?Q?2ii/rdY85qaWm0nthm17UlGHX9zDK2Fmer5O+KXO8m8cjOXO9XjsPv9Tt/?=
 =?iso-8859-1?Q?3gMZLR6+YQuElLnfGdx1dEgl57fIl1a44yy4U0sT6Li/Latn9aZvKkkXp+?=
 =?iso-8859-1?Q?GqP1XQXYnxCFLhXia57cK7DaP/0QeijVp1mQHpCoH0H2lhQEwX/Xsh1zHz?=
 =?iso-8859-1?Q?DvrIokLYNSv4IRftcsfrSKLT4ShW1xyqeFChNBgfaStcxs9tSUwSHrLy/2?=
 =?iso-8859-1?Q?gPX81UmwEfhR+zeXtV7TI2jASHgKYz/tuHQMrX1+fnwc0ETf4TQudlhw2v?=
 =?iso-8859-1?Q?eBN6Rmy4kDeew1oJW16FHoXMjaJ1+p6/mxRi+x9c3181rexvG8XplRA1oT?=
 =?iso-8859-1?Q?kjSzKiNP0+5K1P7yjbsfH6C/k84tkAt813UYKbKYdju0nUu5PLAM5UFcj7?=
 =?iso-8859-1?Q?8ErU/XtjyxiUOYClHbPBXyiQfC99iH+MUKD5GFBb7zVdi66WDS+NwLiSjc?=
 =?iso-8859-1?Q?5E/evnGFlo4IuogRkVEZr/Uoh+kznh8Wyme1DTz/7/T0T5bs9gOYBwQW+z?=
 =?iso-8859-1?Q?zOchLFm6eo+l8GN7jfJPQyrFDe+1EWSgJR1u/Z6FVAaZAcv0FHHuBFT4Li?=
 =?iso-8859-1?Q?DiDrTWLNlhl/BHOEraBG3+LNnPoUAEYoLOS70OtF6rRA3tg5y8cBG+DF2t?=
 =?iso-8859-1?Q?I2WvpfnDHUkF9YfuTEBhVWSUT2bpomjViN7GqU8FehRj9+nqgA+YFqULxQ?=
 =?iso-8859-1?Q?Ceeu1BAPToJJwuoSiYxQJ7XSf7gt4OqHWd0v8xizkN49fZO1XPVjixkkb9?=
 =?iso-8859-1?Q?7KG++rP+fEJpYiZ7W2oooa2Pc5PI1y58pYR2xEMy5TXKK0cWK6tslNJJ9U?=
 =?iso-8859-1?Q?R0FOgG8V+hNh/jyOd15xiGpUAhH/8TX47Oa21iztODmY7g8z8uIShVSyVk?=
 =?iso-8859-1?Q?SWiuBMiAbtqu85yj/SZvQ2aZMOhxOrqwGA/IZf4d+y4XdWGyfZt+66PWlz?=
 =?iso-8859-1?Q?DGc8D8LauaGd7SAZigUfsYNQpPJ0y5n+UthCan3CT73B8y8oI8op9N9bl9?=
 =?iso-8859-1?Q?uEgF+Tc3bAFFqjMhMM2NcO2LwLuX6WSeWL3CcH2QoU9oZ/XYZzlVKO6N1B?=
 =?iso-8859-1?Q?grROTQE3PMn11PrOUsoJBiykYQB+XWn7NoT9PQo/iB9EwLMhi1WIsG3b2C?=
 =?iso-8859-1?Q?row5zu0MVrlffOavF2ETroFSjYIcp3Jj6ldYUUvHtRjXlPckkt1oFnnC6c?=
 =?iso-8859-1?Q?ZawWbPqL+Xol7BV0Ks34nORZhsO7v+kbDY/uhWxJo+DgzTkca7XhggEry8?=
 =?iso-8859-1?Q?yya2Y4Tl0SbxDCTpVsx4kne9Svbs6W/p62gDWq5JEZZXO0TZdgXwaLl80y?=
 =?iso-8859-1?Q?EvJV+7EugBRsYSvYgh/ahjnI41PI1qGeBaxd2E0qQk/TNwAxhEWnItey2q?=
 =?iso-8859-1?Q?tG0mEkEGVWBWNHzc9yaQDkKWx/HaaajVK5elKzoeGbZ2vAjwAi7/NTTdv6?=
 =?iso-8859-1?Q?a6k75vVBpYj/yIMkcnlzNPvmc1PLTLldz2PXo3QoSmwBl69VInMwY/b2DX?=
 =?iso-8859-1?Q?g4Wy6vsHgyvRx+rvB183LmiZzR9fqJIDuS3xIceToZzg7mkuf0zDT3VpPY?=
 =?iso-8859-1?Q?iAyT1HZfzQJ2187xtowG0ez5LFNzuOdHSBjG+DSZXTfRwfswhEZ4ydwF3/?=
 =?iso-8859-1?Q?TxSjsIVOtkkaAP542/5O33k1lpbqs7/dgnRrBj238ulZ/rgLkyEs9imZYQ?=
 =?iso-8859-1?Q?uRHkUMwROQ2rOeLYVR/H1700yrdEiG0=3D?=
X-Exchange-RoutingPolicyChecked: MwRAlwSXgjRQZb2Jyi4/ut+jKM/bxXlYJwxRnHwXfZqC69ZxFTvvizpvaWNtah/LkegMpxM/bUu+4qmdtBjTYyZlhVdpLasXjmUedRCbJA1+MbIg4sl7i4cnaPNeDMmTzffM3ZnxujsgiolxuGX/lHA0yCCNkFI1d4LDxhEPJGjxRFAUltDq7NHRJe15yRzyF1AGy+DIZ8XH1RD28/OGD4LwWyTTNhCUyI0B9TqrKRQCpOIBj5aRzK/z1TbAK9cti3wAYpCbjOOz4ZO1XmJbjQpizcOmNjrthtktpMFatuDc7KprsvS+9n5qb4rm0TjgDKgpdH25mkm/vDyb2iPMvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f73eabec-20aa-4c47-4c43-08deb5ba3225
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:20:44.5527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA+bQxb10mONX2bl8g88afeszrxcoqkE7z1Gm2aVhrWqI/lcJKKY4GRqxWec2IiLMRCcHxAOpWJCu89Q3Jb/JML7PqKbM9hogmOQka0nKPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6826
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

On Fri, May 08, 2026 at 12:16:01PM +0200, Morten Brørup wrote:
> > From: Morten Brørup
> > Sent: Friday, 8 May 2026 11.16
> > 
> > > From: Burakov, Anatoly [mailto:anatoly.burakov@intel.com]
> > > Sent: Thursday, 7 May 2026 10.09
> > >
> > > On 5/6/2026 5:58 PM, David Marchand wrote:
> > > > On Wed, 6 May 2026 at 16:07, Anatoly Burakov
> > > <anatoly.burakov@intel.com> wrote:
> > > >>
> > > >
> > > > - all those virtchnl list struct have the same elems[1] issue.
> > > > Kernel side did some cleanups some time ago, maybe time for DPDK to
> > > do
> > > > the same...?
> > > >
> > >
> > > Yes, it is indeed time to do the same, but not as part of this
> > > patchset,
> > > and not before the base driver code is updated to do the same. There
> > is
> > > some background work happening on that front already, but there are a
> > > lot of dependencies and moving parts, so we can't just change this
> > > willy
> > > nilly.
> > 
> > Is there a timeline for this fix?
> > 
> > With the performance improved rte_memcpy() patch [1], one of the CI
> > compilers complains about buffer overflows when writing beyond these
> > undersize arrays [2].
> > And I'd like to see the performance improved rte_memcpy() merged in
> > 26.07.
> 
> With v10 of the rte_memcpy() patch [3], I have reverted the removal of the workaround that ignores stringop-overflow warnings in rte_memcpy(), so the patch doesn't depend on fixing the drivers.
> 
> Please take note to remove the workaround from rte_memcpy() when the flex array issue in the drivers - using elems[1] instead of elems[] - has been fixed.
> Not ignoring buffer overflows in rte_memcpy() might help reveal bugs elsewhere.
> 
Actually, I'm more wondering if we really need to use rte_memcpy in our
drivers. Any use of memcpy is likely on the control path, and not
performance critical enough to warrant use of anything but the built-in
memcpy.

/Bruce
