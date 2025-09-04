Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C13FCA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 16:31:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F11C4278F;
	Thu,  4 Sep 2025 18:31:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C2B0D40275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 18:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757003476; x=1788539476;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ou9lrbpBLH49F6fyEY+8ieF2L4fU/0X7X3TJaBUXspQ=;
 b=Z7qoXViSE3pYmakpMMQhheuONiQMbAxbfoZRiVg0aQY4tLiU0nkbWrmk
 UfEeH2OlA3wLbPz6gNrc3oMzf2sHg1bYETcpGOv31JEVXKbznbLSYA6LF
 ozd0jDrPIwZKujg2w51VYY+sZVSL9TpjM3zBISKT7He9l9NBKNlMASs8p
 3GLcU+a25hTEfg9CPE6qSDLyoRCcbvo4C9XBvCzDUQEvMdDctPCB/jvIm
 GZbVnftf2/AP1ECVPbFY672MqtyPcr1jtZLVVsTVIXhBi6QE+JmDgZald
 mSoucA4BE4QxOpYS6HMMY1bXHjMYWvuoVtFQI/4VQb/me/cPBUN/SFoTB A==;
X-CSE-ConnectionGUID: WT+R1ztNTmmThJpBowVK8A==
X-CSE-MsgGUID: zbUjScyNSwWTkjA5OCqO6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63175043"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="63175043"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:31:15 -0700
X-CSE-ConnectionGUID: 4Ij2L9pbSSuZnlE9tsvXow==
X-CSE-MsgGUID: a2fByEPhRM+fd6w7VK4CBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="202868480"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:31:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:31:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:31:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkVEGR3S7sKbKGDCfd8QvXjEkU7OgntPmDcJ/EhOgMACPLvMp6bB40A7CfklsrpwaZBXOvmMK3kUYued+/N0FsE0oGfSrURrTXLh8JWsyZzjLStvO5yfxzu1EFkMWFCyyH0O6GibK5Qh5fbTMGr2ng52T3p5FjVHnjbWgZM8ZZc0Fm8g3QTuGhlGOL72MCQ0nEx13rPSpiGcWHsIbZVo0pITGLG2wENgOCpQx7BlvPAUNGM1o+huXhpY65xZyLmrZGL21z8/K5mJv6R0oESjy0F3GZrt+HNIQCD3ziZ7ukkd+u8BYv+KT7U3mAtLFlPEYzbOilFLPc7YmpPAdCaQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg2JhN3YfeBmlZwQhm4itKdu3fhfwFdQD8u4M6A8j/M=;
 b=WrP3p1bt3aIVTuEl5+Vb8BeG/x3/OmbBhiCylsYHycjmCYDFp6MuJt+CN/JUKIzdQyCZskQ8L6NpfJI+3SC7/Nedxsfp8ZqS4nE2cYCG5eteCd7fGe5lDHAlb/NJdZdLv/9oDQG3LaUFCSw4yfHVgLqMU1SghTdIe0Tv1+BS4zVhtU2PDEwPiFFLvHLl9/3zSF9L7YyuRMn+mcvH/S48Kp4875yxZEItG5kxbFo5cvsmPJKN9tH6lPxZpg0PtqrgeTSM9eN3FKIfa6O7A0eig/XkN0yN+N9z8kQ9LITMcOetKF1Y4vdv9EEjqGsNQqbpxPHJpMC6syFtwwCZu74q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 16:31:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 16:31:05 +0000
Date: Thu, 4 Sep 2025 17:31:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/4] net/i40e: fix vector Rx queue set up logic
Message-ID: <aLm-xbiGNldcFG3S@bricha3-mobl1.ger.corp.intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
 <20250902104859.2100141-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902104859.2100141-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8f86d5-950d-49df-375b-08ddebd0722c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CIw/4pwbqrnNCVX9PxF8MjN7KMpK7dt/rXj1o17sILl8mRaBoyaXUuUrfmM8?=
 =?us-ascii?Q?EEGh58nzVcQX8H8dOr60CMOqT1gX+cuV8e/+2Gbus+BRNWHG+5kuiKIeLB4G?=
 =?us-ascii?Q?4NIInGJ8yBU21VDiSNxZNaCqDF/AmTWADAFqne5pFzl5JIaVbDxSI5KQgfay?=
 =?us-ascii?Q?mylA8CXEDsszEsWi1OU/NtZ/+zULQvwzhpHJp3grLKrlRH0Mnzgc9JxHOkaI?=
 =?us-ascii?Q?c6JhsR5r2qrL0CxzAlP1nPRYZUQMJLbvGk/k2S7cWEDWF9v/hECRQKM2AmsM?=
 =?us-ascii?Q?wN3kIU7v//sCOPpC+ywO/5iA+9SQBecuLzEfttQddZjO2lnkxqtbYTfDLSf+?=
 =?us-ascii?Q?yaWA8/7EYD8SQl6EVOTouOeXxwFo2MZ0DwCO2MN+pTUxKEvodn2FLJEIZNzf?=
 =?us-ascii?Q?d8k1WQ6mBy/vnq2WB6oifC4jItboNJEdPxmy9s40/M57hMFIy6l4RpE9rB9P?=
 =?us-ascii?Q?lIeXVwcUO0+GUrMY6A3lCmT2XlkEO0NI7gwRZid4SjU60zIj6N/TQwBgavxe?=
 =?us-ascii?Q?mth3DBd6vp+MTJPZHv24bIOM4gYgcg6Dxj9010e0/pAeNKIapdYutNUJSGCI?=
 =?us-ascii?Q?HrOp5S+rgm7quFd2KP+bpt5W0bHzCjW+DiC0WMmKLX2pcg/jA39c8334BO2T?=
 =?us-ascii?Q?sQCZbOytkVD4MoEy0stuL5RbJAEZj/4xQzG+DKrH+DKFF3MrXyjJtGWJD0jA?=
 =?us-ascii?Q?kJV2PbG9nR/3nOKzOwysmFUe9PtwpTj+Gfj0WerSq2ALNS77fp9E/Dzr56ko?=
 =?us-ascii?Q?Hdo2NzgMuQe34HHXETtWVRLkurMFAbddte1ZoUXhJaHMZHraaI+qm5JK1eBz?=
 =?us-ascii?Q?Ci6Fnpa/fSL4eXOQ/Z6fGGcJkYJr+d6P9qPu4+XEZtNSUWnzu7lTDsxM4I+U?=
 =?us-ascii?Q?jBBP1arJhY23azXp+HqRDwkYL85hCBKg8Q6wFR0oEg4+uiSPP4W86mfSAop+?=
 =?us-ascii?Q?Kf2G/8ghpXRYBKLha3PK9Q1rUmwtBkCryBhkTjJKhsXhhA0Xj3eTX+38mhNJ?=
 =?us-ascii?Q?4YvNqYtV05T79GStjuwIQL+u09oGNzpvwQV/08Tjn+W0eR7wq4Q+y6+l6Hk1?=
 =?us-ascii?Q?JeSmiMZ9EVUAzcHauEOsiP2DZ+v8lWPwY8MeYh4PmbkUe+FVJ2DVmjwajA7x?=
 =?us-ascii?Q?8qswc6L4P4MfUt8UkY+omlirIpQZamkgVFGR1KWbSdMJOLMYYFcd5mcwxFlp?=
 =?us-ascii?Q?fUiGBqvy2I4Fd33Q1pohpvjm4hfkbIH49Ld9mnGxwM6gyhUiEgaL+qDSL7BQ?=
 =?us-ascii?Q?T8RRc0r4TMeMbyeaOw/MccaovIPnbULHMdytaMafgxQ5IPTvvdAmbc7Qnfps?=
 =?us-ascii?Q?lfY5DBpviaxJud8jNdD5YmYXmDiSRQdF7wkr/0fKuZwxE9AesjmY61VD6Ssi?=
 =?us-ascii?Q?/Nk09w1cgpSnpB5Sl7T9NJIkBAnZ2x/Ec1E7lD+JkCf2N627Qg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tMs+0wvCl2r51w6zXkil/Kn/qLgs+l3kDKDSnwU6/1LbNhGF7HGzNQR7M9Q?=
 =?us-ascii?Q?w+8ayxCcJ0/FHE7Tdb+dvUv9GbGQ6V5fcGsYsMXmVNLMNZC+orBsszHgb4Zn?=
 =?us-ascii?Q?OgwxdXhlrxpTplbjhZccX7zvreaGl5mAvMOkEyeeIdlVbRloRImadpcjQuHi?=
 =?us-ascii?Q?YG5XbTMngZEpAKCd104H3tdOK/szzD2c0EZEfrvyDK8w3yoOETnpURVEmkSQ?=
 =?us-ascii?Q?8tNZQ5iQ6cg2I9uhB2KFYUeskaB5QwK3Ft4xaotOSaJdd3rWtHnsSEhncBMB?=
 =?us-ascii?Q?qRggTH0CPRtCOlL/ApeCRFOO3Vq0P7ko9DhC6hhWjyHC1xoEqyVfifNzuyzZ?=
 =?us-ascii?Q?1Z5t8uMgTab28o12pSWmJhPvzUiX2fnFSDo6HWHswJAV8BcYb2xmDBl85+5e?=
 =?us-ascii?Q?75VinnM0FIek/mMIacKkWXAigLFMK7aA7e2jwedG3nTe9WPe+1DKkxFsmlMa?=
 =?us-ascii?Q?aIUeWKO1zAVyEF3AvVhO6SfxQJ9WyeH3n4G0ZPTcs5+W8CCt/FIdvVuNioP6?=
 =?us-ascii?Q?S/TVVfnaHvfVWGORWFEjv/BMX2sC5skOgnHHscNEcHooemyLnujEu5Or7kiP?=
 =?us-ascii?Q?e5VunyhSHwQbQDOutO/VZZo2nVwC0IBTIrAGBz2juPPCWCnlhmeulmEuN7hK?=
 =?us-ascii?Q?l2TA7R8b38G430pmue8HrvICqwIKxl9akWLRlrevp59hu9VlctjVtwrR85vL?=
 =?us-ascii?Q?1lgPU1IVgkWmkUq6sCoE7G1BPAalyHqqRsep+z/6fOlfgmr3aQ+0c5SVgbjr?=
 =?us-ascii?Q?lRE1hqPzUxOah00Zc4R5OWC8zfY7XrKanS+UYQC8LQYXGobjQocVKGXPJ5AO?=
 =?us-ascii?Q?i8t+wl6iB/KGnoX19DkFudKnwustLZYVOWUJ19jY95RUA81+oFlFPrONyxsl?=
 =?us-ascii?Q?Pb++W5kVuw7NLVgxZZYGOVBVAjRK12TJ74oP/bEUn+TUjOkxVr1OYyahgY30?=
 =?us-ascii?Q?+V1Y+f7Fjczs1KE86RkYQj3DMekPFk5FEicj1caAEFu5z/skpqWZpbwwqgBF?=
 =?us-ascii?Q?+YkY4jIDd4gZ4Z+RIVGLPD/82n9N5qDqTw7AEhDz2a8PHYXiFKR2kNnZw2Xg?=
 =?us-ascii?Q?0E+q8EE7xfXoq7WtgW8Tif43jFyHDOG/Z8w8ak4vZfzRjKx8jQuTZfzpS6Uq?=
 =?us-ascii?Q?kXP7Vjlw0HnwSEgxCQjVxpEwiGnzWkD4woDe40OGh7+FmcRARlOe9uPEE5hK?=
 =?us-ascii?Q?IaGiJR1Ad7IswK9iCdArraf8SHB7pXuqVHh2WBBRqs+TKQRVKKcs9CgdgJdU?=
 =?us-ascii?Q?AApXz+xauI2xLiXnKG0qzsb6THMzWQRB4bUm/3DcNMTIekc0JTfSKHar5nXw?=
 =?us-ascii?Q?vRK8bCmEl/e4jKThkg/b2qQYeszUF22OAgFoiJRqQ9nimRWjkHwPzVOn4gC8?=
 =?us-ascii?Q?bYJ7LrMlrmX1GHsd9wkDL+3oVrwHAvGeXmDmMVN4c4Ou4YNpHM2bDYadCI1V?=
 =?us-ascii?Q?4YUaDRguolmAiBW1QzMHXhXVzDeMkr/XF2JznNPF8YRPNr0zhjD2880fx/rv?=
 =?us-ascii?Q?zvGYj+ZPtJRBncYncRy8ybpVhxR/B0rvbbK/GP4muHqIlnnlLZ4AUt4hjVkC?=
 =?us-ascii?Q?iXzgTeJFehPFR4o0I6iOMGXznYRiBj1bF29ENYQn/E/51mC/C1X8zuWiErp0?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8f86d5-950d-49df-375b-08ddebd0722c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:31:05.8866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLIzgAZ134S4qz+cXoW8aguCScAiw6dRhbksW4ygPE8FNw2JKLQDl/VCbQArmhADSsK5x7fWbAUWur9zg35AAYkX5CuzvGvWqCRS1E8B8Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
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

On Tue, Sep 02, 2025 at 10:48:57AM +0000, Ciara Loftus wrote:
> The logic to set up a vector Rx queue was present in two places, before
> and after the Rx path was selected. In some cases, the rx queue would
> have been set up for vector Rx twice. Another scenario could occur where
> first the queue was set up for vector rx, then the scalar path selected
> but the vector rx setup would still persist. This of course would be
> incorrect behaviour, so it has been fixed by removing the setup logic
> that was before the path select code.
> 
> Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")

I think this code is mostly from an older commit, which is why I'd mark
this instead as:

Fixes: 8e109464c022 ("i40e: allow vector Rx and Tx usage")

> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
