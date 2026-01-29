Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB7ED61009
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F398402BA;
	Thu, 29 Jan 2026 12:56:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id EB1EB402AF
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769687807; x=1801223807;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=J8p0csISPC34rq4L0GwldQTV9Zj0MhfF3FdHAXCcO+Q=;
 b=epwFjF/95fAZ0fGror8h8MgBtC4jihTuBcLugUbjdR3m54Rg/fIpNNT5
 3zwnyE6kNC9lYg9vuxo3oxe4AJMWOjM9Z1JIwQObwQfK7NNg79R2hCCNB
 R8SmX91PKy1vACSCBGvLwkvi2pDg8RcHTLb9e3I4CIo7TlvR/7X3djTf1
 UFrASvVlHqAqNz15/ahneYcf+pd83mC+yP+m6tEBgkCLIfI2C4VPwKjA7
 YUriOQEoh837JeSKTW6UZ2CC2zKuqvPeuGigbrMS7y2a11hHHQ4RyA4IF
 kGmd+DQi6v92Eos8EhJH3Y36etQ808LVYTy7KTe6gbCoYW0oOfvmgx4zd Q==;
X-CSE-ConnectionGUID: wE7DcTSwQoWkzi/kjfwT3g==
X-CSE-MsgGUID: 463C0CVeRHqMHmk3uB6U2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70828515"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="70828515"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:56:46 -0800
X-CSE-ConnectionGUID: fjAvTzMFReyvlagH84dD+g==
X-CSE-MsgGUID: jYuroYi0QOmicoR926gIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="213433512"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:56:46 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:56:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 03:56:45 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:56:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nyv8WADPbFogCxTAFT+9s4sIn0sAccQ7GCPEsmb1HVgK/IUHnDrANf1U+qmo0DGHe4dE+Q2A32AQtZkywvzX0fo4IN9yAL/nHJSnFRRia02pBKKXfFYYqRH5RBWEW7oVTifXF9sMT67/c3svuFhcT1quzDtw4KZLlyKZ/JcX+goVoMmdkmnmPEkFhOUcBYvhT3f/RJB8Q1+v2CDZi5hGnm9lrnodA4YIqn8MUAHhxPfR/iLP6ZjDr4aIeywHAjp5dDj3bOFuFZPA+z/mDZhCfK+6Zef1vVnTOHNg6oWPuf1WOqAAC/wE/LE+lDtCcdgF7H+GM/c1IDmCA02CRMddig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdJM2KaBrlzkAYQWN4gwPNPXAxZCjB9P/8RlGEL8ybs=;
 b=c9RAI20oBtmNi0zJDT8SZsyH61334V6+GMrLsBl/E+/kdpaqM0+cBa3QgYAKqXNTKjbbVi0mW8m97+B1tDUYiBzy6oKLAoCqkXwGSFjpFfNg3R9Oe/TCfkhHoyjyfBgT/Zkc7qf2FR8TkMOnAWi0EuMWvWWYXYAOQT33ye7d44PHZjYNZh0scEzLgdYTUyyfNt05BlCsnsQ4kPila4lJ04C90nNZ+PAZaJE0pKaQyEccFw/BEuZ/YtF8oxVuh2UHvJ3vptscQXdriUKNILqqGnr1tJ2lzbAC/M+SUj6WhPw9IuXkTqBGQMcaysylvDIac6IGEqbWkFyv7GM7T/Oz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 11:56:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 11:56:37 +0000
Date: Thu, 29 Jan 2026 11:56:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: ensure correct vector flag after reconfiguration
Message-ID: <aXtK8a6kIq-Nw67g@bricha3-mobl1.ger.corp.intel.com>
References: <20260128114110.39253-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1FD838A82E5269AE6F52E8E9EA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1FD838A82E5269AE6F52E8E9EA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB3PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:8:1::21)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: b69661e9-a939-4fb6-86d9-08de5f2d752a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hOy8cAnNXoBHMfLJWWtW9HK1UgZaUqGaD/Uod7gdCv8UHpdXXgl4g5QTpBS6?=
 =?us-ascii?Q?6x3CzLPmBxOvSDhc2mhEsry5PMMaNc5RlFhB7Lu4mDxrWorM5zs7RK6Qi3ae?=
 =?us-ascii?Q?bP5C89iMP3PA0JjagIGsNBmXImoeHlnMmBEGaiictg1kG9I3E78/vpkh/FPs?=
 =?us-ascii?Q?tH1LfwWaoL3V5veNsA2KKQ64140xUF7hFTNVJDYN09d3JC4zaCEzx0fUBZL1?=
 =?us-ascii?Q?iqkwlkSsZ0FutkBUAEgh7/sGruWk44be0wylV6V8Dn3lLtF3ef57w4vsTdAn?=
 =?us-ascii?Q?w3FnG6evekIz6mDefsGkCRfgNJ1dxXCSB7MaNFYX5acU5dnrrJQqjJHpV6Z4?=
 =?us-ascii?Q?woZgD3N7ESien/0HSbNS11caj4zV9SSVGETV4DKC4mcX6T/RXwH7RWhLEIsU?=
 =?us-ascii?Q?n3675xqa6nLZcL/fYnHGserBqMpeVvX0HqVIfOWJA8YXS4qeL/bvAYJLwaGx?=
 =?us-ascii?Q?6Rr0crPCs2Vp3GL2usX95t7AwqdvWtB43XD+iIwuLiTlV5ndAlus189ZP/SZ?=
 =?us-ascii?Q?JDbEckfaWr5N5XNT2P5L1wWCNMSJLmI9jhMNO0ca+CJ9/ADWoasMPlrBib8R?=
 =?us-ascii?Q?ho77O5j33KDx7agvlMIeyOg5Z3c0lR2e6wckPm/9F2PJypRj8ZepxxyirZ2U?=
 =?us-ascii?Q?2sIibF96c3IMF58O5iKk53sRjhSDM9kMIcud4BoJoiqmXtPz0ZRoOK5PqwOF?=
 =?us-ascii?Q?+F1li1umDIQYmhX2HKWHng9IHWUHfVMJbAUPip/1vO6Um+qXufxBf5YT345l?=
 =?us-ascii?Q?nXEr/z2SXWNF+1sjBBQ24EjP9JuD1jEZALP0iLfQf1retBuVMoAd8vB9l3d7?=
 =?us-ascii?Q?65g4NvSeoQWmYuOCO4BtcNldozwnl12FGNHRHL/+Wr79YmZkQJjQDPuWCaGW?=
 =?us-ascii?Q?zhXitPpc0JJnpK7LysrwSwU1tz4MM8p/wMORBzPX/yf21nIf8bOhZIgrRq5T?=
 =?us-ascii?Q?Rfd0pkUkjTZSs8C+nr4wyC+A1FYtRCZIQ4z7W5IYCSZL1PaAOI8SzF2x8wQ2?=
 =?us-ascii?Q?PyVMq5+eK8lBGXvfEuczRCTE0vj/WpADRijI9eBjQ5n9rX+sZrldPLvJumsO?=
 =?us-ascii?Q?3LV9Hn5wqkuy5tuCRM3snnMMxaPuqYTwJkDhB/wh3IQJFyn+onnofvN8reYR?=
 =?us-ascii?Q?6tnWUu7owlgATvZjlzhMlryRP1D6xkjpZmF4ytnFnNnRUw5ivLSVjYnrTbE8?=
 =?us-ascii?Q?ax7/XDH042bx+00wfQCO9/Jz5Xi6oU9zRTlWJb0mwhyT9vDjGD2CUl+toJF0?=
 =?us-ascii?Q?W+jqe2+VeRIRekicDoAtlfaQ/ph0NCm8Os4kclkdliQg29ogtyWn8rn74/l+?=
 =?us-ascii?Q?9u+17zpb1R+ZyI6XuByYnHn3pbpiks/qw6tT7Wq/H6MBZGK9DICyr3iH2h0L?=
 =?us-ascii?Q?CR3STBOuI542Q6/69geo/0hIiKjhvQAEriqjXsMtOvEYfsokJ2Kg9k2wV9fE?=
 =?us-ascii?Q?xL+t2LaOsH/fkk9vC9izbyui5jZWE7XiR3R525epp8GlYguHehPCa1yAEqZ0?=
 =?us-ascii?Q?Oe5q3SzvbaQpc04XGg1p2o0kJWcARhF2TfUW0DtlvFNqLeA2hYcsUrG7HD+/?=
 =?us-ascii?Q?aj5na8DIXbG2ify66X0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyQ7Bi1wi0l8UV9Ehrz5N/lz3F5DpSQvO8I/auqzVfmV9OjtlGLvPiqPpDET?=
 =?us-ascii?Q?Fx21DH10izoESf3lEn14ylfYGk5KpRC+aISc4316RdNuqo7uCwmdQNTSoF3w?=
 =?us-ascii?Q?+UuKVDr75nU0HYgu+eR2yg5PcIxa+EOO1+oh5l6wyXNReWPoJvWbOC0VeeFc?=
 =?us-ascii?Q?4PE+fncfVhjMB5JXxMJWkPtyGQWZ1zVhObAWVAgHzL05je0oCGAn/f4sTXJA?=
 =?us-ascii?Q?mWMHo9Ez6lHlK7NwPOBWEez6kq1z3eoO4X9XblvKLNjv0PoJhTvDj6WLTtOv?=
 =?us-ascii?Q?m/J9TPmCQwc8dJXVbrYY0wjvMSYrVrw5+Uteu+HGUnEEHqmAJ9OpIKVIy0Zz?=
 =?us-ascii?Q?MsuNo+xbfE5nK6Kjwk34dPtNiwIs8NSOvv4gD3C1tUgsRUQ+ekroXzJBDNMo?=
 =?us-ascii?Q?RDzm9snsnKP7JNn7CRflxe4Rl7RbKoCbRy4aBsdplU1omtZuVgeqI+eJ20kk?=
 =?us-ascii?Q?Cicf6BQ7gYcbFx7dRm/pkdkmHqEp6vhupKOjRd6S7smMTrJ8KKf2l1TbH8ca?=
 =?us-ascii?Q?uL0GFWa1C46vGO5h5eHn7/3dQiN0zy1CgOkfJNS38KJfIlYWxUeUnpjQd/Ro?=
 =?us-ascii?Q?WN5QMTdvNY18jZP7HGRNA2eAFNldRqG4NtKCoKemyS3HOsnnPadq1FWNSno8?=
 =?us-ascii?Q?R1Yqx1Yox5xwvSGCcLotHRQCcRl7sJ0jxgaXh6a1FBeBXp0v5Zl97u1jfSZI?=
 =?us-ascii?Q?3K9SkKF7D/kCZJp1LKsjG0xMXl98b1fxOYZcfezBGQxXOJm9pDm4sM4/UuAb?=
 =?us-ascii?Q?9mkYigCXzitdJDYKk2GnQ09xS9ydkgSGnwEgcoql4iDGViM+SrVabgdjFDBZ?=
 =?us-ascii?Q?lOzZxMKraIm2fQFY+z1HMw2Fx3kyMdRV/ScKQkZeQahmSHUfbzVSDIWezlFO?=
 =?us-ascii?Q?1Y+nub1X8wsrTzQf1j+k2ghkB/KsFTELCnPTPcrGsbDBcIhHP9R2kH4rp7TA?=
 =?us-ascii?Q?FuPuOoonLhuqXnyQvVueUl3hrsb6hDagpDwila1NGQcueFp+SkMps+IZnAca?=
 =?us-ascii?Q?YQT1qBG/C83vumtfV9wy8t96nrdvpHArQYkdoWW9n2hj9GOa1XnOBpT67Waw?=
 =?us-ascii?Q?GxO9T310r7yZRaYg0pwXaLXOSfLbt7XhGXHmj9X2tPeEWSbpCqqOIuTWpDih?=
 =?us-ascii?Q?vjM9htvT7RooVHlg1x8E6v4OpspMrKbnTEw5mRNXynrAZbH5VeCQhy84Oz65?=
 =?us-ascii?Q?HBfTBeg59jcax6Of5E5/w9t7K7R6+czgktt2XPMDp1oh3Djez9yquOjFyaCY?=
 =?us-ascii?Q?4wgO0G7P4b827/i6iiZyKrQUB6E/vvxMOW4UY0Cj5DnhnX4i1iAfixDWWXgP?=
 =?us-ascii?Q?W4z/4A2fYdECAV4FLHjAPXihbge9An6XGElnF3TYL7cIRGwzGhMim/BCrEbN?=
 =?us-ascii?Q?hzTkZaDQJwhV5KayNwTCF4q+cecwSg8iwUAOeN37d1bLJ/xkriHEwNcmVrws?=
 =?us-ascii?Q?d3E/mADggPyA+0EAO0psWFl7l9LBFsBYEfuQuax5Zed/hm1suyS9qYOjU8eS?=
 =?us-ascii?Q?kR9szcg3jZRvjvupdgx7Qj1t4WJsI/0FehHz29BZ3fAsHXE2i3s1NM5jxMgM?=
 =?us-ascii?Q?A1DVYNXM3qhZTQ3HLUz65tP3rmzpSx2noMn4c1kGpIB+X/JdU2ulEg21GkEI?=
 =?us-ascii?Q?6mQiDrChGcUyRMQTimUfR3yhC0MQr74HK3ppJkuvFTsHFfOmtm/k/HCE8eRC?=
 =?us-ascii?Q?VAqASvf6cLAmVXxUHdm5mD57MS7pPmGOU9MktD5+slqvrrARgQsFUI859Sdh?=
 =?us-ascii?Q?8HQPM81iXHUQFJvh0lJ4JQh474F9mcE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b69661e9-a939-4fb6-86d9-08de5f2d752a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 11:56:37.8082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PuYMis9D+09+d76jcEPyT9oldQxm+kWnnLJEBxI7bIVXzdoCuwrnm547oaaCjmwTSlJhMEVEbY78bbcBIyWF2dnZIWMvNisDHNhkbgo0Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
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

On Thu, Jan 29, 2026 at 09:42:06AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH] net/ice: ensure correct vector flag after reconfiguration
> > 
> > After configuring the Tx path to be used, the ice driver sets the
> > tx_vec_allowed flag if a vector path is chosen. However, on
> > reconfiguration, the flag is not cleared if a scalar path is chosen,
> > leading to crashes on driver shutdown as the wrong cleanup function
> > would be used in that case. Fix issue, by always setting the flag to
> > true or false explicitly.
> > 
> > Fixes: d3206e40c435 ("net/ice: use common Tx path selection infrastructure")
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Thanks for catching this Bruce.
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
Squashed to original commit on next-net-intel-tree
