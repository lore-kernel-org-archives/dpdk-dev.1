Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1953FD7F92
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 10:58:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 790AE4027F;
	Fri, 27 Feb 2026 11:58:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 04CBA4003C
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772189932; x=1803725932;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y+x5ljMElJR7wKNhSkIssO4xI283szUNCTlgBdYLfJs=;
 b=BVTQzXRL3yOeoxFJTHE+dKZhjFHsxRlhwNKxe9aSqP3s1qPl2glDejuM
 t3I/vph9Q/KUy0/EYys55TnV1SeURavg5Tjo6zuf2BXOcbqPb/4cegK0+
 RVOUGT4Noi65VRUPb8zTbgIiRZRiyfiTPHa6U0a9hqJd50OoQzlzSDuaO
 A5Utoeom+kmlfdlI7Bt8ZJo2daSgPMdHxPaBEjKrMC9JU5BQyk9J0EJJ0
 67iqIdGFheLWWSTlTLjaxORurL1Vki9xe+URr5RhFz4Bnw/EoEmcuAhMj
 G+XgkWGQHJ3rr0MJNeb0mR+8eReJ1kLPFIGWb3Ao0KkjtQcHLZoYHbnj3 A==;
X-CSE-ConnectionGUID: bQvtfJbOT/+HXL1vgJSW3Q==
X-CSE-MsgGUID: mfJx+pbASFWb2w3c52JjQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="90673126"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="90673126"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 02:58:51 -0800
X-CSE-ConnectionGUID: 3ABQlIBKSXa4QJuteZulCA==
X-CSE-MsgGUID: /zTBsydRSkmbyL+x9iOdlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="221490266"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 02:58:50 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 02:58:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 02:58:50 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 02:58:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlQ6FsTdeu5BUskXVmH7NLUzyTT0W+0Vax3wNzuNxh3ElOu5y846U1B1iWyDThEK7Ze0K67+YnttEv+8GNNn02vsLR/tN5/OIcd5aCVh7xPrtqPWlxTMvtT1hAsZb6SKRCOKSGEV4mTibBApkwjXFbGK01mMmptlOa2yvzgmu5yNdW1KVmPIZiaDtRqGNawPokjgHyqTRqlcZuPjgRnceE0NESoiQN05CYzFRzeWGHtQPM16vv9gFn4791wDouGinni6W3xAFB+kIT0fj+Fz7LE7UrvX6++blyQfbcA9MP9bjBxUuDZPyWPxF98Ybil+CbqtZbb6hoFu5urBBafl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diaM66OwEc0HPB1F2ZwiMgCXM/flEK/IwvZyvj0BQLM=;
 b=bYiTAiITXCLaO6ek6Ie9PqZbpz5OtoIVJ0oBbTn9NF3QG91mS/bkqWAr4Iw19CgL2Q0uu8Wsdyrt+lRkoZ6uW/Y1qkg70GtTSwYw5tMYeD/wkeYVydUka4cWJ3X2lJNgCtoeI++D2mb9+DhYv0TdtC0tyyjdeBRk+mzdJuktAE5Ba/452tpxiERquftlH8R3uZ6blq2+GjhAunduOl6DeUR5HVQ9FtAqk92VWymOL0TKE1GyTecNR0nVlCq1W6t4nOGa9pvN46cijT0EXMjEqECPQQSJ0FWIXp34QBSGUBkstlVIEb14W25dNl2/CKdWsEyfay4JCJyLRleoNnhyfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 10:58:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 10:58:46 +0000
Date: Fri, 27 Feb 2026 10:58:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/1] net/iavf: remove global adminq response buffer
Message-ID: <aaF44TuE9CMusRA-@bricha3-mobl1.ger.corp.intel.com>
References: <2a3001591642339ecf8f91584c83bf0766e0b66d.1772021348.git.anatoly.burakov@intel.com>
 <ef84dd9e25d0daad648a9b1ba63f8dadf203bdf5.1772102450.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef84dd9e25d0daad648a9b1ba63f8dadf203bdf5.1772102450.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0232.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ba0c30-65f8-46d2-af75-08de75ef2e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: jSaLesKxpK1672tohBF02w7BYeSuZyzAj1HfM2DTlMwjJ5emXhsZc4U+bWslW1c/viGfRYV+WVBrPrHHZwqx2BczGc8IUKuTf2p+Fs93D8aTb670YEDh4ngnDHeIBC0WEA1/qv7bSniSQThbiGsuSb2OyfHsdwEDo9ehqpojXXMwa9uOoTk432QLhC5ZZ4/YKzn+fu4GVfSdpZyjLH/KORYOSMzg+J1XEJGqLwTBUaIyLZRMF/WG73DYVV4kybmLhwHj7Z4f6tjvQCJX2/mCUXObu7oTGh3GDzaaEw0zNpwIdGnjrIahRzcLAnxHIeAAm9Oyu+NcuwWjAsaWkyOXLsRiYo6SGnMkI7hU7lRJu/hWi8qju3SAkhZMQ2Avh9UmQzrR7pWGfB2+QyGJTfUDTwmKQe05l1KZUqa/zEPy4yHXGGoqZZQqf0hwvEBu+yjWgBSqTeN/d+ifdZFrcFwjkpxOOs2IVeVBJ+8JmbVGBC5Am95iTR7SLhYlMk32GlOIBfB8LYAtPUtGSHtV8+zsew8MoQLt7jSmS7TYNYEJgftquPTT7Ltw0NefMeytPraxAYyXu8UdOJOkcrkCjHjCgbFxzKqfhjml0tzXZDOK5+yaj5V7akotviQjAmDtPQp8bgF3LTx8V9hgRXhG8MtqHktghF9dfKdfevw0XCTSGTGGfFXBmIv2xDPaMhTNjyIjXih1+bJqQ4s2zQAfR8+zmumVNM48FLSgdhAvHrPALmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEOwKqXkUgq1k4oxuX6UjFUqfLHKB1jNWX4glKa4L1jUD4DAE0K9ynA0LgA6?=
 =?us-ascii?Q?X7ixrF6PmKAi8hqkh4giZxFjgn/6gKqhTCuv3Zfd2g8LT9xdnLFLcFy5O2QL?=
 =?us-ascii?Q?l9WfgawMZmr5TDB4wyEVQH+QePDBeEf6YmvjL4Bi5boy/P132ai8uB6aRKux?=
 =?us-ascii?Q?uuCgB6YVEgsS5lt9GDc+cwBc0FHgFzP5H0bhPVX/cUt5ZH+vDRFzCXPsWN1K?=
 =?us-ascii?Q?q0mwT2yi0llHccrJDr5gijDaw5vkqwoDGprlI/jOv37vRJlA3NExiw9gYgtN?=
 =?us-ascii?Q?4jqsLO9HzFFtc0FaG263yC4Qp8VA9/9BcKuuuPtlNibVZW3+BpHrDGH14l89?=
 =?us-ascii?Q?BYLEZlGyj8tmTqDjAk/Ovw2lO3k7F0K040xLmLER+LtlrlE/7d0BeQugpwmV?=
 =?us-ascii?Q?cGr7s6azhWPxnWfyuX+gX9Nhk7Hf6Du+ASLQyKoUAwPKWqdhAoMD9z1t/Y41?=
 =?us-ascii?Q?UBRhswhqAKafj+XnaDY0QzS9bW31zN2JftiP7t3jld/duswLBegOrTlL2LEz?=
 =?us-ascii?Q?6+rV10jgEUry2Xo/2aYtTlA5itNU1ey30D7HmcFPiuu2N3OgdgKq97zpOeMg?=
 =?us-ascii?Q?fvNR9KUcT45W5vSfqFMCaioiixGyYypWWhWFLDxDF9lKB8xkL9ZeGOwBTIXV?=
 =?us-ascii?Q?f+t7qZ9i1A5IjkydDlNbf87+r0Bf6SbDzlFC71WniZGltKt3Gt5CduyQPfdM?=
 =?us-ascii?Q?E4dYpE/CcUb24uyBi8yBg4HZxobsHKcazCynpgXMFZZYWa4Q5QHV5KK6vKaD?=
 =?us-ascii?Q?eOTuM/XYDJYSQcfgfbd+SUqkRT46/77dfHgmN+O+NtDPdcRl+bRsihdtRhJR?=
 =?us-ascii?Q?eeV0ciH2iCKCFKPEo6qtOuNvNH0LrGwcnBB/wh28OiTW0LGe8sjqHpxLGrrY?=
 =?us-ascii?Q?+4jxkJG2KBHwD+2QKRcNUxsPVR5rt9OD3zvmYsY9YJh6q4x2M9sPbg+3722n?=
 =?us-ascii?Q?mx0i/h3u7ox0xGRtYrLKHp2LIpjjv7iXX98d7CCfCAEpONRFDQ9nF+oY2Dl3?=
 =?us-ascii?Q?Dgt92y5g9Jaj4RYmlT1bibqqsHTbLnFoH0DY2ebox7noofOhZJRO1AphHSFy?=
 =?us-ascii?Q?sYvWYgCHPDBpGyULetF4zTyP7leeQO2fkNARk8i/AbqOC2LQb/9eHEuomooE?=
 =?us-ascii?Q?QpUjzX2d63BpnCfkVQDsgX9S8BicbtLHGZox5g6SkhO3M/dxmi32us5ma7uR?=
 =?us-ascii?Q?QCxslgua6TGhc6RvaCMWZkenxfxv/PLaBUcFui5O1y8na6oJJLXNb1fPuhSp?=
 =?us-ascii?Q?aviQbt1T71NTpTaC20Ks+T+4dUSSKFk+hVo5LdNaVMiaMvIWf3xk868Iuwbq?=
 =?us-ascii?Q?TjrTUfk4eyEYPjV3Qj7/puEvs0LWEPlXbUk5YLHlsOA6mSpD704EThY8Ki9m?=
 =?us-ascii?Q?sw6KxjcxOZagcenhbBCZ8fFJSPuN4nc3gvU5xSgm9gQPfvU+Sarj1TXEy/MQ?=
 =?us-ascii?Q?prAsja4wd+k3g+JMgDrzmx/eB99mgDgjz6xQkT6xoLCEvz0FjOBwiM48HpGR?=
 =?us-ascii?Q?42gwCRSTSX5WnfuDlAf4dqcE9xJ8tFNZG9D5lhpPMhBcs/4X5f7yHsnX55pl?=
 =?us-ascii?Q?dnRNkV40u2JaMlzh2GEJbZ4MfCerh1QEbKTCyVtMTP6zMxMFJbDo3EHeYG13?=
 =?us-ascii?Q?YAFeTY7rM0DaJZMWzt7Gr/IDmG4j7C9Ek6X3reKFrHLThY5Zqm+n4XT5UxAJ?=
 =?us-ascii?Q?axSFt9aSsPQx3ZptfnaJVSb9M00yc0aAYMEYur8RRrV43vb7knNF8VJd7V7X?=
 =?us-ascii?Q?B6fl457MPrEJTNjoYcqT+fFbLGT/8D4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ba0c30-65f8-46d2-af75-08de75ef2e16
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:58:46.5323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PGF0ML6qvEAuJHSXxQcsW5k6rUlSNGG9O8fwwIKshsj2THcSc0A6n1UxDC7OPEWB93zp+C8YdZeG0To5lLvJIJYbe5hR6Ue7WS2uu2uPSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
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

On Thu, Feb 26, 2026 at 10:41:02AM +0000, Anatoly Burakov wrote:
> In many places where we are calling down into virtchnl, we are using a
> globally allocated adminq response buffer. This is unnecessary, so replace
> with adminq buffers allocated on stack.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

