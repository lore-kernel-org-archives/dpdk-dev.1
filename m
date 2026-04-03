Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C523E8536E
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 13:56:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84ECC40296;
	Fri,  3 Apr 2026 15:56:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id DB4314028B;
 Fri,  3 Apr 2026 15:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775224589; x=1806760589;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MKWUq/PQZ93CDpzWvpnnY6Pi6a9495ZUHjqFo8tdkCU=;
 b=hUsGYFuV27KGPOwLk4Gxa5iMCVfLxh37R6bFa4su7IhDRpF36Tuh0kk+
 ySwm3y5ATbu5ExwzzAtl1PDpG3dHVs3uQ8WqlnM35VdXQfk/wLt7Ew5F9
 HUwK7tNKUM/tCmjMAWFRdSZ/lG2Eit9OIMyppokcTvQ/14PIPTJpATaTp
 Jc+DxIwJEokqDa7CLcaDCsTo8pgYgRzGw0xRIk8AUoWcejoYAHxAKOYVu
 v1Etb38qttd2eGmriulIlhlP9jk+8fCh2G5ab8350TbX7GeFkxWZ5dzjk
 +bCGpnukn2vGRjiqQwrc7ac/JsB0x8U/QVN/TeWi5fGmUAb6E97+eEaNc g==;
X-CSE-ConnectionGUID: M36YegXgQNmCjpyt7KmKzA==
X-CSE-MsgGUID: 7Y5nVkWhQzS9MZ0P7kBaUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76349298"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76349298"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 06:56:28 -0700
X-CSE-ConnectionGUID: S0YxXOf2R7mb9VyuzGcvOA==
X-CSE-MsgGUID: RaxiZgCcT46cKXfV6vfzQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="228888612"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 06:56:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:56:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 06:56:27 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 06:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWCmYSf+kY6W+3Kl4RqxzawBZeGngrOECnAJLo9IXsEbtFOLK95kYpOXveFFEDq3MsgBCT0gXTXDU2p0VTcFb1h5Y6iObjNj3u4ce13Gky+h3Y3i1LgqTDwjMkwlD2Ulfa8dyEVyhyeQhW5nq3RF3NJZjBZ7TinkHZ6JbduJWsoPMMbYt5Bgv/Gdm8q1XZbNdxxR72UMJWQ200YjtYEcMUGl0CXQD0qPzvA6pwoH/f6MatGInko1/kFB02A0LYVk1X+Bip1p2MKhap6y8JFllGMksQGGKgGyy63E8VSp40fH5Zm8q7oxtj7UGHdr0antxxFnEdH8GaVBe4aSuiVskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnPoMKyNA1UDmCCXS8oIVKH7dGsmFC2LWk5kqYDiNxg=;
 b=CFCWSK8aDDbmUFHFOtmEBGq5z+favqrkeuxX8f+b3CP2+uFbF2E8jyKY3/puBV5adxjKjKMDhqTkiUfOv4iK88fZl8xp5da4Z2jS8eV6+RS6R6tRwGJD4D78L6z4qJHLrf/eZIOZ+WMmsmkggEHBkMTL56xl+z//ZzScLys04MwY9t7107G04+9QCm1Xd+dT3iWZ5YdFQQSf2z/kQYV8Inl0Ii4nvENqZR52osxtHdzLWXZchMBkqzkKZE4jBj+yAOeVrvAUMGrnmCgWPQAuNY6p5MLPD9R6nc7d5z4M9GSpedXrMhCD6Urd9Mw+AV3lP0mo2fiWTtR2g3BpAfUz1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LVUPR11MB9858.namprd11.prod.outlook.com (2603:10b6:408:38b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 13:56:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 13:56:25 +0000
Date: Fri, 3 Apr 2026 14:56:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix FDIR VLAN TCI partial mask validation
Message-ID: <ac_HBOeVnBKj0akg@bricha3-mobl1.ger.corp.intel.com>
References: <20260323104345.1667974-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323104345.1667974-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU6P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LVUPR11MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: 58552e13-f61a-45c3-a849-08de9188cb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: G7QjQzAQYgBZIt1hpyBz2UGZzJIK9i+//jVYRXHinHhZtUfQqZGDgRsQDXQFz40ftsilhbNrH8UQ7LWC6tunYZSB2XCbgGft4WQKnIduG7BbtuxOrN7r2NWDyWGZkvb5GwLHxD9JwoOaSty0vXCyb2c2/Io9RZAtm4M7N118TLPffUwsX0VEaJpFHGNLFy63L7jA3keWHLYGPm62NtYy2mwi7Njrdf/z0gPs3cj5KbS2EF2EK92Ndn/C+maZO2n4mSayw0CBs2XV9C0QVJ5uhqgStLr9Pu9z3Ln9zOa8jybZnrbNZ1VORgCotXh0eQRLGmmDRCuHcIetO116uajK0UStO3zIQJcWGN9mi/F+cy/cA+oTuM+/7qVZy4AbdXyb0j7+x3WWGPmrWRXUi5HXd5RyuJc31AN/EF29KB3TMYbz3h/mNudUUTYpwp4y5ZE3tjWt1dBlF0Fr9Vc1c8cGBhOUiuQYFsP+eoISkXsp2HurFseY0pw26A4UlnxQmwtvF0gv+mojmkLlnTQ5Jl3AuHwnG02Mhrz6ljnHnxEFWuI8PGrSq4l9ToT9WW15jFRgNzuASW/UWFQvwJC7tsAB7w89pfYQhRZ/xWLZcaHdDVDzfrylz0Fxsgc69QxDVGjFZlw/rdXHb/Ar2e7l+SKnrkq6GzC4kDqqPpRTmQLcEYiHKeOHUyZUJ1nbTFQw+69vTu4x6GDg+YmO8feUf3kLR4yfjUPIZH2W/WKpXt/lW34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uaORJnZOeRDoP3JYpZglEdnWXzUa1mGgx4/RgtQYqv8XtSvFcpK2HFgNwkzX?=
 =?us-ascii?Q?lZbiQdL2kZuncfEaRvsNYplXqP07fjK1g1ecvBJgY6RwgGFRbtjyT+g6JyIq?=
 =?us-ascii?Q?e84B9x4UB1Ucm7a5F8sl7vb+Kqnr3SlzjGtPZR2kh9QvvSXDaNm+nud6CuZN?=
 =?us-ascii?Q?JIccbmmsh/7mSUHEHxMMybbISs7FE6ihv9108gecRmIN49cw2tN8MfOkHlLJ?=
 =?us-ascii?Q?CpoxD9q226It5JY1zfkprlz8LUsRsiF5AiCjG/uYV3T2GG5iXTmVFAqNK906?=
 =?us-ascii?Q?2Dus+OXqY9ZV1Ey7S4cRA7P5Chylpmsj/cf4st+MMrwBozHVQtUbT3L9cppL?=
 =?us-ascii?Q?Qy0vqPTSnTLF9oX48FgW9majPfMcA7h2Y7DK3ACGQ9n9iTGpGE8wZ25apmFj?=
 =?us-ascii?Q?e8ipSeU+HmCo7cCdFDHwUXB+5dAtYu2wdDYlocNFugIfwSdkjAAbIyPf3yTr?=
 =?us-ascii?Q?+8NHcpjKhUqUe49dqIqb4X5lCKBUArmjYcsHdYfa2YuNYE0mlHRf+esE0jad?=
 =?us-ascii?Q?N0/XGm8LSHfY9UqfHnHXsVG3I6MzEJE5tIN23TB1sithRc1nnNZ8lTXZC9T8?=
 =?us-ascii?Q?44MR6jSda9oEFthb5r29z1LpRKyFdAIagwk65CqGwfJf639rgB1cvLSH2uC8?=
 =?us-ascii?Q?cKQA3NrARnhLatoqJEObKlxuXGToL0CrwLg/m4ZaKMZlecqwf9nVN+ChRZW/?=
 =?us-ascii?Q?xhLhUu2MuELtaqwcL+WwtiZ9fXYkB45THOHcWOdiWu1O0aVp4V6ALlyWRyEJ?=
 =?us-ascii?Q?CZLGC9RCkD+yctTYADNZntyqQbRRTZ81yX6m1Q29uthAeoTcKIfmqaQiiUHJ?=
 =?us-ascii?Q?Wfu6Vgb1W1SWQNGlHVgAEM96A5oa40EhySPyrNXMeZF72y/UaF2mZ3do08Qm?=
 =?us-ascii?Q?oQZqrsJ3LzTLVwaEFIOLsEvpvLNJ/Hwial++L6nDwBU9JhUMsWyVnym1ZI1z?=
 =?us-ascii?Q?qBhIBtRXa7xgtkwHx+M+OiWrbthU5dM8O6Z1tfDoh3/QSy6xuqqE8yWbvbvg?=
 =?us-ascii?Q?H6W/G0PTV9L6dCLshg4y7G0TruDcp1poGLxuuDRTdLTRJuclq3hyfRq8nFIZ?=
 =?us-ascii?Q?l6y0lMoa4k4saZ8N8iXcvn3RFiRliYPhHoofCtnvoOw7OrXqXjFXhzBJpPEd?=
 =?us-ascii?Q?ELWuWYJHE02Y4ktyZ21cKmpcQTezbw/LHw7QgmTIWmIAxvrf2Z02dDRyL2Gu?=
 =?us-ascii?Q?aEG4x1cooQqsZFhpCkfu9zFGxUNA674luDxb/gHYBp91GXNFbxKxJyv7Pc/v?=
 =?us-ascii?Q?6aqMJikqVsXhzhm2iC7sMU28LZ6rIMzCeOoYKm7imhxdoehtq4LzlI7cQqw5?=
 =?us-ascii?Q?cfnnI1IqC60EBB6/1uASGopmxF//ubkVW8jIAcFT2FFKTKDIZ1tvoZnXvn/L?=
 =?us-ascii?Q?IQcYygMq7gLe30R4R77CYq6gp60usj4suUGiGdC6tP9CCJqUYS2ap+Vb0NgV?=
 =?us-ascii?Q?S0kr/9mzP/GISz8+RZItJNxv3z8nHOauYdGmtusUfDMnGCsk6Ef2pTz0XoTJ?=
 =?us-ascii?Q?QPAudrLLW6dKGU1oPiYHdruv7ZSABDGT9bOViNPJTDNBS7dLY2Px4bwI/Rcd?=
 =?us-ascii?Q?9mnGkJZhBrGxge3YgBCc9YcG+h8AnPjeVgPkKg97HUhKLVMGJAI9LwxDzWTE?=
 =?us-ascii?Q?TxzF9BfbkLms9c1l6EfDt1EjKoFMN9oOVI3BKYHBjL1gbX4IXMCLDYWX5DW6?=
 =?us-ascii?Q?kPz3gCGifrZIcSmOynvoabW7PEtr20ASQOjeXSKPrwFPFkgdHi2GIDzex1v0?=
 =?us-ascii?Q?pbX7J0b84um+kD8Y4mrXqhj09w6IVtM=3D?=
X-Exchange-RoutingPolicyChecked: OUtPMz66FsV2VKOyBXgWHuf7tkA0pqRcWOCT27z8jOA5NrMVrPmuzqn+ocI9WHCkAXHLZMjIU+QssO8fg0Rp1ok026mqPI758xaCiq02laOYAfQRa4h+6nnQnOsTRyXNi8yXWI9mn2pZC9f5/CpvTrE/JM9Z6Iezbe892Fs5/nyt69gYJ3qvfijMcuT/rwj+OzDEYqHTwPJhlFK03ee1KKVqX9EMhZe4xrOZ5HaDyPteQp75LGheqY6SRj6UpNrUooECg/Y8COT4ktXMCOf9gp4+Ki/BHSsrRya3WO1SSYeaN2pXnRKfzxaDkhcFO80ztls4ufErYPKpBPDRbW9njA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58552e13-f61a-45c3-a849-08de9188cb9c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 13:56:25.2154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opemnoGInplgoCTHhVGLWUlFQ7PaIQBXdraLYdGWvItBOxPRUdE7TYbBcFwnN0um9AFfU7b5qqq+mhb+kYKKWFUVnGpZ4jHTY+lWtl3sZSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9858
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

On Mon, Mar 23, 2026 at 10:43:45AM +0000, Ciara Loftus wrote:
> Currently, the i40e flow validation logic accepts some partial VLAN TCI
> masks alongside the full mask, and reports an error for any other value.
> This is broken in two ways.
> 
> First, the error case is not handled correctly. An error is recorded
> however execution continues as normal, and a filter is programmed using
> the invalid mask, silently producing wrong matching behaviour.
> 
> Second, the hardware always compares the full 16-bit TCI field with no
> per-bit masking. Partial masks are therefore not honoured and should not
> be accepted.
> 
> Fix this by accepting only either a wildcard or exact match mask and
> handle the invalid mask cases appropriately.
> 
> Bugzilla ID: 1340
> Fixes: 81aebb47d1 ("net/i40e: fix flow director for eth + VLAN pattern")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_flow.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,

Thanks,
/Bruce
