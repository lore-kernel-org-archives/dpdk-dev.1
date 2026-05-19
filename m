Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9223CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:58:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E98B402C8;
	Tue, 19 May 2026 16:58:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B874740296;
 Tue, 19 May 2026 16:58:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779202717; x=1810738717;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=C78cVpf0xaNbhJRegH4DQw2W/I5SMIEHocfiv+oGCjY=;
 b=P+jnimraIRhg8EkvPqNPqE3iKDvUwNhg3PJB92+f4Az9PkjUXSjc8BUW
 nA0Zu0eo1gHzvHBDXiJtPRQW+jdyiexwedwh+mQBIfDFqG3qNIxovgC6d
 M2qwQQ9FRah74TUR28ZxNifz1wb8En9vU2s6wzTAPdjFCi2qSAQLKXddi
 b1ptqCo+rcDJ3orsAxQQzwkxUEoPfnEL5nFDhGxYyIkWUpVnWBzqwZRYQ
 Ys8xf49uBNIs03CRxbyznHWr+SDz1QXZX7TyRpL1NiLQfpLDOeEcWi9d+
 IGaWEOrApOMqB5nXkQ7TgGqrBGIt30uug/SMft94wBwjLdc9BCh176wMH Q==;
X-CSE-ConnectionGUID: EY1Lo8IiSS24rC5amCAb2Q==
X-CSE-MsgGUID: ZPcRcXJ7QPea16O82zmJkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91476689"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="91476689"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:58:35 -0700
X-CSE-ConnectionGUID: KzmiZULNTmW0HnG4lALQtw==
X-CSE-MsgGUID: /zPDs54QRnmmo9sUPcsA9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="238954841"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 07:58:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 07:58:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 07:58:35 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 07:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD0ehL+I6YGshrlvn7blEZWjaybrLUFEVbCWwXMS0t3Y3lVco1Z4LLpPfehjnRmE/8GaHWNFxPTWAJqgbNVobxbkwOa8LXXXe/RupnPbpWgzWOK2YpEXuiL/G9Uo097EMOXc4RbVFzMwivI3N1NoxvQql8PlaUwflC5PS69iAj8Oh06VoSf5OT/7rOg0zVcLFVge+8o07mYszSm0XUlxb0qWEG/xyshUSTI7hfeOytLM9anr/sz3s7qjCBcbZDVBmgGAevINLJM1duI22k6qAqrIaPJNAdVPeu8vMf3Dpm/9p53GmdPoP83wf1bjBXgH3A+1oCgtEMHxna55w0r/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js+vSVLmL7F/5bP+41jw/E6s6gt4k8hmbMarhgQiQlc=;
 b=Ab+LNS+a8nPGV2T8feoHyqTgI3ii8Bm2SAIE0piWhDs4WbEjv6UauY5z6hO0UkmsL68owYU3cfhRqVN+tS0H8GflWg5mGtNj7vUap10qFvkI5oQf5pNpDL/8HTcmYaIvurgiCNV9yTeH1N2vqQnUoa/6XirXBOI/2/8fboRPE2/JYxsnHNet1FeVCbG/hfOMLSLZHDiObQOugZgeWfH43BExm7VKoBezzOkXV6Z400JEj7OdnIIWsYuM51zV4mdhc9Fh5pTPnEniirI6C9CQ4Cfv5W5UBNa0q1hU+3J1bggrUIMqolZ+5BqvQAsRujvQAzCEio2pyW5daZ8CtnDrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7913.namprd11.prod.outlook.com (2603:10b6:610:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 14:58:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 14:58:31 +0000
Date: Tue, 19 May 2026 15:58:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix TM node ID validation against configured
 queues
Message-ID: <agx6kiQyvHZJ96ob@bricha3-mobl1.ger.corp.intel.com>
References: <20260505123157.1387791-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260505123157.1387791-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:10:232::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd35009-6835-4194-2f62-08deb5b71757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 814Rpa+55G2g+AMMx5BnNFQ8+4jxMaLtFRHY/x7CLFaa8ZnWmTLUVFGCjvpwg24yp1EsUzgAdVN2bLoPk9pcPJrmTXcDKTbLPv0u/mOQ0rsbjB5Z3jsAxcj27wz+rjrIfOJMYvDl3H6qBHfAmGbSFtH5kWM9n8ImjpF0fPD1H8v0Sgg5kqzYHhCAG/UT4qDejVRQsAakNUJlj+/c9QuDAPpUVul+tvY08GTTSXRNfcxum1/fy2mdHBKxwh2da4VtuX0cE3X1NoHZYEX9INos9RI+Q9sD+g6f9WHaVtb8LtzU8FfFUuiy5cb9spKPKJyvnIWwh5OgPRoDQdO4Ne8JW+h1GOdq0PEApqXEa2Bebe8exYqozjnL610TcHZhMwxCwifO0lgwl9xu8FRy6rd2nT7NaH72W37Xd7E7+xmztE1Df/zgYqf+jB2mKvwdSyTSdqjinEMo12gXm+BkKGUdAFmSm9YVq0VeMYNC/59GRZLbE7eCMdELHCpmQxdHtEqy+NeQ0eBS/sFkCMnUdfufhgL8fqwJK8Z9B5oTGETQTm17IPXiE+xnaqm1gNyla+E6y97AGGMepQmt+aiBNBrbz+oEYPOcSJAOmMvHu9DhzwiQbW/V0Rd3N8NxjglU6F/mVbLA7BPr+r7HZOs7J7bwvD1+GAd3JD+vOT2ANS0pHCJ4n7DsdXVbZ9g4Uv/A+zST
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxZkkK2ZDD8iFsVOZurjUnC9HTAkj9HBvTn8ndTXc1LOKBuboxip+PkOZpP1?=
 =?us-ascii?Q?nNv3qLGoe17OIb1em6DJpzrOj+mhH4eeyX+x5wjEk4Dw/oWOy+8J+mk8YXc0?=
 =?us-ascii?Q?rRS+iNxbGjyPDYDaTgFG2Is6yuQmbb43EkWT7WJ9Q0/q2hUphVoVpUUbvXK6?=
 =?us-ascii?Q?7KA9gOPT0GNeOZlH8kVSp4OeGOhxwBC10w6EV8Ieftt45Dx5cvwhnRJ3N5aY?=
 =?us-ascii?Q?4fjxGuSEwwvFO0N6/Vr9fMVXGTLKfSVesFVTxlCSILUUwv1zReCw90QWvNjg?=
 =?us-ascii?Q?hFg+RiM872LLXkGMODvF1Ul/281pY370pF/Q/wXBCbLsUMuXeBC9oYvdxmlb?=
 =?us-ascii?Q?wRG1faZ2at/EcHPawooDwn8XAOItL8osr1vfFW8hbI7IaWUPpcogmRLy8IGe?=
 =?us-ascii?Q?C9ox7vf9hICc9Ml+oz34YJtPsxkf8x6OfMFx8qyytOJi4x8U9YwqjnPgbNrx?=
 =?us-ascii?Q?BbxztRCV9ZVJH9MAEX+LAm9WuhF4NN8tELu9uf3Uiu33LLLXLLiqoYzeUbsH?=
 =?us-ascii?Q?RmevFxLbWlS0K5YSOx8GQ6lVU9L2fcwKc+vJbHJXpd+40JkAnXTkBAu08nV7?=
 =?us-ascii?Q?L1pWmDxtsdHFB52AeNwQdPOt1SaJx1knGP6JXPMu0l0sUhxssAF6T1GkRY0O?=
 =?us-ascii?Q?10ao1V2I4ifaFA+KemzQdjABXk769y2DtFLOEL775j1n9gBmtjEptgyGRZYb?=
 =?us-ascii?Q?mcH5Q99z+UDrCgD/V7DWg2qbNUQJo0Jox6sv6A2ZJcr8zTOsNtMcnqj9vNC+?=
 =?us-ascii?Q?gSDG6RMJiblkkcMTss/yOOqYrjX2gzAhjrn5CbtdOTMnNxR1iLeB7LH+xzm1?=
 =?us-ascii?Q?TBYhXT33SVqRWSNhIHB2mLYpnfz2jtp/28mAG7jMukaQ2F0vVNhfdVpJVdXJ?=
 =?us-ascii?Q?pB/ycpn27rWHClxeWAztss+tvDOsFks5yLjUYe+Dno6GPkzVhLPCI0T6S/n5?=
 =?us-ascii?Q?4ic7tDtfSE05KTGEvK75S8pTno6oO4hJRHllvOIU3kDjQkBHbcU85zgvbk2t?=
 =?us-ascii?Q?hpZ+TQnnvtpAk655nWLbFDXzd0isEvfVwQMzYo5wk/jW40GQquXfhSftmXvr?=
 =?us-ascii?Q?lhW6IKsd8ACq0rH/fZ0sVj3rHiIRBGiVR/7tmOzuQSNlzAb6nyqoMRt+RwU1?=
 =?us-ascii?Q?CEjY1HRofJFmEAifganFM+VP+eM3gNm83ff6eLG6FDZcjf6M0g39AOppU/03?=
 =?us-ascii?Q?+SQr5K2+FintR/NNFdE32onxLphaoyGzJMJLMIbUnpQ90uoB787OkJ54VPlT?=
 =?us-ascii?Q?XW5vVXPlsReHG3d3yO4ige5sc1QjS2u/kvkZs6Z7EEr+mkPTaCuzO+zeblBv?=
 =?us-ascii?Q?XZSUxQnpDen4oTdNpgVryJDwZFM91H5HXFJ3xBTKfZ3RP7LyvzrhLANep5jX?=
 =?us-ascii?Q?/ZSJEDtU/ADZ2Edi8LpIMsR3WFeaxx7oewxw/opLI1hNcaa3bjuODorwLZ+F?=
 =?us-ascii?Q?InwYgExFNpzFHcuHW9fa2HrQkeahXzcZU/HprBsHKAYaaH7MV8+CUnZL0wkD?=
 =?us-ascii?Q?gsACqfqn7q3M04AwKI/YXq2rVta5gKGvsS+Mz2qxVfk3ra4rXL3Bd7XNI55T?=
 =?us-ascii?Q?q9pePsM6mbIG4yesBr2/YygnYUhHKNXOyWBiYny9yplBTj9nRP8TBHmWib25?=
 =?us-ascii?Q?cPxkpZPrNjvWCo2kupmNljDU5LM6Fh0jYBu1dYE88fdVEi4XZ+L1mxWXU6Dh?=
 =?us-ascii?Q?JQWHeBEDg7b0gG9z3ZEEMqDc3uA+RmHOQPXT8mk1sk2AAeqt8V5Mv8HN0LiR?=
 =?us-ascii?Q?nxLT6AqPnMS3zGYEWRBkQJb4rHy6xCg=3D?=
X-Exchange-RoutingPolicyChecked: DYCiJ06ZYqtHS9tlS8pf4cu70XsfT1Kx/iKzYllq2fLi1XLwXhjjOCTPjR6Td2EEk8ilvOdRod/fqVrV5uCfrfDdT4+nrSH+OSbu40x8BQD/ZHt+SXd8tgPsZC6ptNJBSLzfxtmOR8nyHpFUZv2/O1CBQdRQkE+zj6aHdyOYbk1I9ny/QIQCsAxkgCs97c9fmOjkmN7kpf+22u6bx5HXxCllntVEX2bpOd/Gg9b6wm4r4LlLdNbZV6JWKeOML7OTVZTXsJ4Xjv8WeDQ+ayLRHEF9ufI5YZtf2Ttj1QHw9+YR5npkxZx0cWd+Q06sZDZMcATy724LCQkyChXkHeCDqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd35009-6835-4194-2f62-08deb5b71757
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:58:31.0716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Kp3hZjMQMaadQ9/nSLotRU4yVwciGrLgK5n+s2Zf20/Ei5WghuSukQvEeYNMtetwXnjso2bIqlVeJ2i6Tu2NJyDwFRI7XoXqON15Bv36JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7913
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

On Tue, May 05, 2026 at 12:31:57PM +0000, Ciara Loftus wrote:
> The leaf node ID boundary is checked against the compile-time constant
> `RTE_MAX_QUEUES_PER_PORT` (1024) rather than the number of Tx queues
> configured for the port. The rte_tm specification reserves IDs 0 to
> (N-1) for leaf nodes, where N is the configured queue count, so using
> the constant produces wrong results whenever N is less than 1024. Fix by
> replacing the constant with the runtime queue count.
> 
> Also add an explicit check in the non-leaf validation path that rejects
> IDs in the leaf-reserved range. This condition can be triggered
> two ways: adding a leaf node before its parent chain is complete (the
> node resolves to a non-leaf level), or assigning a leaf-range ID to a
> node intended as non-leaf.
> 
> Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")

I think this fix will cause other issues when we want to use large numbers
of queues. From the commit log for 715d449a965b:

    "If the HW/firmware allows it, allow creating up to 2k child
    nodes per scheduler node. Also expand the number of supported layers to
    the max available, rather than always just having 3 layers.  One
    restriction on this change is that the topology needs to be configured
    and enabled before port queue setup"

The last part is significant - the number of configured queues must be
supported by a scheduler hierarchy with enough nodes at the next,
queue-group level. Therefore, before configuring large numbers of queues we
need to configure a non-default hierarchy. Therefore, when running this
check the value of nb_txq is not known, which is why the original patch
changed the check to RTE_MAX_QUEUES_PER_PORT.

However, you correctly point out in this fix, that that is not according to
the spec for rte_tm. Therefore, I suggest changing the check, if possible:

* if nb_txq == 0 (i.e. no queues configured yet), then keep as-is with
  MAX_QUEUES
* for cases where nb_txq != 0, then use nb_txq.

Does that seem sensible, or any better alternatives you can see?

/Bruce


> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/ice/ice_tm.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
> index ff53f2acfd..7ee4070007 100644
> --- a/drivers/net/intel/ice/ice_tm.c
> +++ b/drivers/net/intel/ice/ice_tm.c
> @@ -88,6 +88,7 @@ ice_node_param_check(uint32_t node_id,
>  		      uint32_t priority, uint32_t weight,
>  		      const struct rte_tm_node_params *params,
>  		      bool is_leaf,
> +		      uint16_t nb_txq,
>  		      struct rte_tm_error *error)
>  {
>  	/* checked all the unsupported parameter */
> @@ -123,6 +124,11 @@ ice_node_param_check(uint32_t node_id,
>  
>  	/* for non-leaf node */
>  	if (!is_leaf) {
> +		if (node_id < nb_txq) {
> +			error->type = RTE_TM_ERROR_TYPE_NODE_ID;
> +			error->message = "node ID is reserved for leaf nodes";
> +			return -EINVAL;
> +		}
>  		if (params->nonleaf.wfq_weight_mode) {
>  			error->type =
>  				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
> @@ -146,7 +152,7 @@ ice_node_param_check(uint32_t node_id,
>  	}
>  
>  	/* for leaf node */
> -	if (node_id >= RTE_MAX_QUEUES_PER_PORT) {
> +	if (node_id >= nb_txq) {
>  		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
>  		error->message = "Node ID out of range for a leaf node.";
>  		return -EINVAL;
> @@ -440,7 +446,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
>  			return -EINVAL;
>  		}
>  
> -		ret = ice_node_param_check(node_id, priority, weight, params, false, error);
> +		ret = ice_node_param_check(node_id, priority, weight, params, false,
> +				dev->data->nb_tx_queues, error);
>  		if (ret)
>  			return ret;
>  
> @@ -479,7 +486,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
>  	}
>  
>  	ret = ice_node_param_check(node_id, priority, weight,
> -			params, level_id == ice_get_leaf_level(pf), error);
> +			params, level_id == ice_get_leaf_level(pf),
> +			dev->data->nb_tx_queues, error);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0
> 
