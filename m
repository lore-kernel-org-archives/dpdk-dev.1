Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB0D29C2A
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 14:01:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4F70402C0;
	Mon, 19 Jan 2026 15:01:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 88B8C40299;
 Mon, 19 Jan 2026 15:01:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768831286; x=1800367286;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+pqdc5p0y/i6zD4RR6vbUAqaM4zFN60ocSXIobhzcpA=;
 b=dAkt+g3pcwWMPizBCga6i7X2KW3HpHaAwfY5lLStWnIzXk2he1FXu47l
 08BreR9j2cT5E0SzWoydth8EJTM1jqKBppK7s2j/sUvj/2V8Ack2mrStl
 2klXatrHeu92UxqJJfMwGbPnuA8DyHe2m/rW//Y2argxFggkDJdOkKcDB
 U/iAPC59dsulF5OQ7tDGjaeWLoibQlxm9puxkSqb8i7jTIBuvKBbaHb5K
 WHheeCuGqXICKvjv+hqVXk4rP7vNIDgfLeR4BhxsBcTdL7sJfl/Nd3dpm
 8T9c+dc+lLT4g0SIIVZ5Q31doM8sMH0nnfeXTx6Ck3uBVuShxZkLfTleA A==;
X-CSE-ConnectionGUID: GKQXjsZISEmrQaQFYDryVw==
X-CSE-MsgGUID: ni1PIk58S5me6IkuFUeyJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="57595283"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="57595283"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 06:01:24 -0800
X-CSE-ConnectionGUID: rYdsE/W1SqKsGPfxstcmKg==
X-CSE-MsgGUID: LYJgjdjqTUGXUJxLrNo4mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; d="scan'208";a="210890131"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2026 06:01:25 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 06:01:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 06:01:23 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 06:01:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMuW/ewL5iCe9wZCO5bgfeTIgq+/JHIv3B0F88jul3J1nEQAANFS9S76pSzVyFbcS7kWyp44SL12YnXRFlR4P/UWJv4M5uMW22A944Xh0KQgcvipCRXnrvu0W5RNd4VV1TD7YGFlMi+Xu1cGn/w6cUakltG8LPm+EEmiOYUK225sFcHqYQt+HKV7jvVInrQ6RESiXt60sxXR2N63DqEkGtMypGY0iF06BzJ3pNJ5uGfmIJhdWGk0dUmzbjws3o+IMytRc533tAwU8uqH5bOpzTeeU/0z5ngluWd6SZRSsVUxfjJiOVO2+R3BkC6obRoAOkSp0Ebu5blrYJbOfXsr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mINv8+3oKg5wx6HXeDQPxUaCZEBz1UE8CUcFiGk6AdU=;
 b=r6lqkEKE4hjrmr/dj/MpD69g3QDdanWHAv1jy8ujZFLBNmlg1OD/gi0Fti0zP1oNBYrT9Zlm9sQVxThFn0qQZdxyKldROB/eLREwoIea4ZtVPJ+k8ug6oOWBy+D1YCORflKBOmTfZg72tF5KBBv7V945U6/q/Jcnbc6IOe9ba0BtkNGt+1cTked5hzcicvQfYF0CS460ZJQG/jvgYfvWkJ1m/mavAhBFXYhpE62djm0XO82LKUHXUILyh/5eLDb0XsAoh21j1nVTg7+CxNQNafEVamP1Lpl41PrhEGvco555qyjg0KQq0ECInH/X0bOH/2n4k+V9OUe26IAxrytaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 14:01:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 14:01:20 +0000
Date: Mon, 19 Jan 2026 14:01:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
Subject: Re: [PATCH 5/6] test: add file-prefix for all fast-tests on Linux
Message-ID: <aW45KyPsARo0AaJ_@bricha3-mobl1.ger.corp.intel.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260118201223.323024-6-stephen@networkplumber.org>
 <e79dc3b56f4044a8be45abc0c9e681cb@huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e79dc3b56f4044a8be45abc0c9e681cb@huawei.com>
X-ClientProxiedBy: DBBPR09CA0047.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae0d1b5-2cf9-4500-9c1f-08de5763392d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2Z/7CPPaFRiggIWSAFZY/D4+anEQmkDnE7IVof79MLeMfVFIoaSw83zeDp?=
 =?iso-8859-1?Q?PDlCJXp7lmj8U4cJvd92h7LMEuz7oMofvPIDsjpq2tSpvWmvbXWRxJmZE1?=
 =?iso-8859-1?Q?JLjzPiIsjN1euEHmmTD7BRSI2K6zxXoWJb9UM4uBaWpSh244htL38k+Wwl?=
 =?iso-8859-1?Q?OHqC77k2wMTNaSKJzyTnkJE9azZN3rSxXXjMEjL8OsIusWucNlzochCLkN?=
 =?iso-8859-1?Q?8sI135/6TKhERHjqoDI1+5jdOgcOtSVpp+wsMAtTE1JEmOgl8vFTH1ZsTg?=
 =?iso-8859-1?Q?8QDE5T7RBwEzHRxO/rYpGWba0Vxdw2kQaXKF59n1hsoceA/YFD+aL8AZ/S?=
 =?iso-8859-1?Q?nPgxMQsqHGo+JtkVtEVUaNMl8e+gGOCwgL/VHygtkM2EdxsfZpwDX4HSUe?=
 =?iso-8859-1?Q?//EcaUFCwR7mWm+9wTpr5UJ5wbiKvlSenuBm0xBZeQMoPDWSbD3bPiquVP?=
 =?iso-8859-1?Q?N1YZV5IWkgQ/1TjEPa9gsIdww/bv0hf1JNf+d/EwjnOvmnqBACImd9uXen?=
 =?iso-8859-1?Q?QjQ+C0hA5nnl6Id+wrW/wvTDomM58spL3tFhNY76pcX/CK7n9HWpVlon0/?=
 =?iso-8859-1?Q?nLRdimgyPx44CVAsF329tstLkkdKrivSiPRtjbFtvu2H6IZPSF4IJVN/Di?=
 =?iso-8859-1?Q?Kw86JQAJ6cjhtlbU0dGjwqv0Lv8wYZqkTcnyRdIVAL3r91i8/9qrBqdpuT?=
 =?iso-8859-1?Q?wqmDPwH6iiD4AwBZV/U8qZgIDDvLtIIfzIlHAiJpTJvhlCR/bHuCVfeUKn?=
 =?iso-8859-1?Q?xuz/07tnAH9Umwa9binvnkF5S8LPjxKYW/vsocIw1W0tyTdOAFVnYQqAkZ?=
 =?iso-8859-1?Q?LHmbkoiAx5j3iVzf4QFjCwRU4H88CH/lvIw+UzIXcn0wUhwLP2CZzIH0ZK?=
 =?iso-8859-1?Q?F54AlyuYpmOB4fjVROkk/BwW2FuEDFBxpZ6YQD7FMz9KollUMRVlk4JsaY?=
 =?iso-8859-1?Q?Lnslwa7eY2/a0VtzEpsuYqjCiIoEM65OepcC9L9punMAH/3Gs3PGB77hVx?=
 =?iso-8859-1?Q?fsDUEAgGcgh1r8K/gUm6xgSzvnzV8AG2oVpKrTuhmF5tbBUlvs8ovogyJX?=
 =?iso-8859-1?Q?fQmLKmGBGCvVuTOEnfW0dV7O1qBxF4adailPGalRgg41OCW+MD/h2I+89M?=
 =?iso-8859-1?Q?095uHQEC5ysmZPnvpuHdAQ/L7rXrrMwwRHLsbmZElG7xiqatTcMBx0EWhd?=
 =?iso-8859-1?Q?zodJZwPF8zLjXh88eZx1Ypx6um5hI6LNLYZ8A0o81DzCRgOjYsNsgppE7C?=
 =?iso-8859-1?Q?58tgaJtfhTn+lu0Zh4w1ZfDhfDQ8yW5d+14YQpXLJGmAl+iomji6mBCwc2?=
 =?iso-8859-1?Q?Hp7vQTtnfgdyfQy7IE0q7H1JRvQsWmEJV5mh47JxLuYJK7ybgcfrjGq2+k?=
 =?iso-8859-1?Q?tgLauWyJl/VaTeT6RXb4RJj/TQhCwEyF6CIQV1rV1TIlcoIJ2XaFuG1ZzI?=
 =?iso-8859-1?Q?GcT2J2wPw3FI/a2fFi0orHasPppd/Grsd2/zQzw+stEKqXYY+qkt9FkL9K?=
 =?iso-8859-1?Q?5d2jjo5Q2saIpBcGIWMDMJVztoeAsjpExux30UlLkX4G5h+LjTimc7RaxJ?=
 =?iso-8859-1?Q?jatPNEeIidWjttG9TKKhrvEt+wxUmBbb9nwHEHO4Aiac2iQEw5IIaEwM+X?=
 =?iso-8859-1?Q?7SoZ0uoDuCPpA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TzTi+wRpNZoSbSD8Xpi1iSVTAvHwHM+bK63FuPePyM0i4l4p/nKBYTY8Ml?=
 =?iso-8859-1?Q?zkWtUx6z82ajm9n8N6CmtfysCi6mZ7vmosjggmacnYR3qptk127zRKKF8z?=
 =?iso-8859-1?Q?6fxa8hlZ41vHyMrcfVfvwXiCkTK9Lp7rV0y8Z3fsHzmWv65xCES22n6sFz?=
 =?iso-8859-1?Q?0/WmDK8230y9i56IiBnmr+onhiXOtTuIPzC88jyozJrOUzs+ePVKGeNAV8?=
 =?iso-8859-1?Q?XXdVC9619ZTYa9zJzf+5qWI0b8/JdBla2kdNwU1MkeJPwtLmZZtw1uz837?=
 =?iso-8859-1?Q?wxTMrXaJydMqCzXTy2zyccnlrd7Rs8C0R+nyPTQ2HBC1CuVmqfiMTb7kRn?=
 =?iso-8859-1?Q?D0pu9xmYjng/mrk2hEjpCRxJ2AQW34J33MIIkJiUIQzQXeCqHgJYDGcM0E?=
 =?iso-8859-1?Q?Z+SfA4hiPaWfcnYS8Iwe/M7fBpvsB/mjqRt94eW+4/ZyzSFkNOjDpxLlus?=
 =?iso-8859-1?Q?ELF0PH/8gx0mxQcN9O5istawWio+vohp1pjljNIDj9NgQiAVYV+3Rs1lVb?=
 =?iso-8859-1?Q?AIedch8cl/xIpp9p/c6PEmNn9ToSrOgi3COPb+EQs7Vgb6mhPFo840S7zQ?=
 =?iso-8859-1?Q?TB0e9T1zPWrw4DqT8yN04ST+aPXRWwjb+CygSBW8ZN0BdNKaKmctngZDbh?=
 =?iso-8859-1?Q?t1Y+TONOaBe35Msdwzs/MmBL2ohsOYhsrTKxQ2V+H9iilBl/ykHu0duzJo?=
 =?iso-8859-1?Q?R+IvRFglOof39w9SS0X4smdXHU91OHEtRhKGWTuUOLU55Ej+U4Kp4iEUTq?=
 =?iso-8859-1?Q?iAL9CZ9xp9dcKUkV7Hwh7WXXetl2QD4CFTfngob8m86X5GVg9mSf7pPeO6?=
 =?iso-8859-1?Q?GB7zS0xMYV0BOJDXDc6hUpqhV3xbZhzxMvbtjO34aE+5z+kd8FxnwBgRys?=
 =?iso-8859-1?Q?u5u8fGF/4kRwdJe1Mr6NwPrvsk00Zjf4hfA/BlAw0OGEni+GG2g2+OAkmS?=
 =?iso-8859-1?Q?zRiVg7BtMbw8Mq26JszpKlYhsiVmk1LeSLljerS99KGJ4tcKWNgXaMnkOX?=
 =?iso-8859-1?Q?5YU+m3r/HjSyO5Y6nEbrMhQvbGjheKF29EY7bBNdFr6MYGV/Wr3zzgMjlq?=
 =?iso-8859-1?Q?69ZA6o/rJwiuxIyzN4qI6rCRmvl3tQETzqh/p4bp3jHkjL9/n1K8Q2yajq?=
 =?iso-8859-1?Q?f8iL+jTca6mf/AzNXH4gdSqU5RvyUlZZlMVyJnF3AS+/88jFoQEK1wn12f?=
 =?iso-8859-1?Q?TrCVqjE79QmaRe+z6tiFV/9/y58ZiMgobw7vykoZJNiX8SZTEPNH8s5iHo?=
 =?iso-8859-1?Q?1Wxy5bVx43obACbwf5059yDGtNF4U/CN/rZ4sCKke28+kmkGMoRtSNop4p?=
 =?iso-8859-1?Q?1Jt3lREqUIf7cCCy9lQW76l+tBTZX0J1TPuAlacP6ZOuGp5mwCaxBW7EAK?=
 =?iso-8859-1?Q?9tgxCMDy6GexBjlxV47XrXrFJXj/yijxio2bNCx67GZyS66BKUoT+WQsYb?=
 =?iso-8859-1?Q?u9sTVvQ7+T3a1/d5IivwqxS13Z4daVxg6dXQar+P8f7VqO8old1bGWiMXz?=
 =?iso-8859-1?Q?R7eD3OoXNeO3W96EUF2ODIu7t68eqBcu5IHMXpJxSdXpDPXqnbFsTkUM6s?=
 =?iso-8859-1?Q?HD3Y966MIDP6vDy9GeOQDeM0VRLplDWb3gUTAXcKvSHSZJTh+LFmNASczq?=
 =?iso-8859-1?Q?yuSFp0eppYBIKfDJkixofZPOMMwp4QJyBm/VshZFcy2fqjBDvUu1++DBGf?=
 =?iso-8859-1?Q?ZO1L/5dW2PO/1Bz+mvLjCzL2i7JlPOYmD82h5+c53P/N32e9zCHrAQIVNw?=
 =?iso-8859-1?Q?hrmLhmYaCR2aEbEzbVLCGF061JUbBMv/HQoNCAaVrCmWDW+UkGWO7iMLIz?=
 =?iso-8859-1?Q?tVKIvhx47v9mQ9HM/6P4IXodVpnuT9Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae0d1b5-2cf9-4500-9c1f-08de5763392d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:01:20.7995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKM068pEv4KimdihdkRrWHgJztOAjjZX+VTridILWnGN56tttR9pZ3zkLMWTgGBkIi8T+Co0NHvz17vNuCMWlmhieFr2cEJJHo3hyp8X9ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
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

On Mon, Jan 19, 2026 at 01:06:43PM +0000, Marat Khalili wrote:
> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Sunday 18 January 2026 20:09
> > To: dev@dpdk.org
> > Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org; Bruce Richardson
> > <bruce.richardson@intel.com>; Morten Brørup <mb@smartsharesystems.com>
> > Subject: [PATCH 5/6] test: add file-prefix for all fast-tests on Linux
> > 
> > When running tests in parallel on systems with many cores, multiple test
> > processes collide on the default "rte" file-prefix, causing EAL
> > initialization failures:
> > 
> >   EAL: Cannot allocate memzone list: Device or resource busy
> >   EAL: Cannot init memzone
> > 
> > This occurs because all DPDK tests (including --no-huge tests) use
> > file-backed arrays for memzone tracking. These files are created at
> > /var/run/dpdk/<prefix>/fbarray_memzone and require exclusive locking
> > during initialization. When multiple tests run in parallel with the
> > same file-prefix, they compete for this lock.
> > 
> > The original implementation included --file-prefix for Linux to
> > prevent this collision. This was later removed during test
> > infrastructure refactoring.
> > 
> > Restore the --file-prefix argument for all fast-tests on Linux,
> > regardless of whether they use hugepages. Tests that exercise
> > file-prefix functionality (like eal_flags_file_prefix_autotest)
> > spawn child processes with their own hardcoded prefixes and use
> > get_current_prefix() to verify the parent's resources, so they work
> > correctly regardless of what prefix the parent process uses.
> > 
> > Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/suites/meson.build | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
> > index 1010150eee..38df1cfec2 100644
> > --- a/app/test/suites/meson.build
> > +++ b/app/test/suites/meson.build
> > @@ -85,7 +85,11 @@ foreach suite:test_suites
> >              if nohuge
> >                  test_args += test_no_huge_args
> >              elif not has_hugepage
> > -                continue  #skip this tests
> > +                continue  # skip this tests

Since you are modifying this line, s/tests/test/.

> > +            endif
> > +            if is_linux
> > +                # use unique file-prefix to allow parallel runs
> > +                test_args += ['--file-prefix=' + test_name.underscorify()]
> >              endif
> >              if not asan and get_option('b_sanitize').contains('address')
> >                  continue  # skip this test
> > --
> > 2.51.0
> > 
> 
> Note that in CI systems running multiple builds for different targets or 
> branches there will still be problems. Also, if you have to resubmit, can you 
> move new lines below handling of nohuge and asan.
> 
> With or without points above addressed,
> 
> Acked-by: Marat Khalili <marat.khalili@huawei.com>

