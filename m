Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEFC282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33CC240279;
	Mon, 10 Mar 2025 16:53:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0DF3C40270
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741622015; x=1773158015;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fMFlortguqdl+9N1ldNglHX6yu2P/SKxq+tHFvtGVcE=;
 b=fMDTBhEec9jqXrVVCG14L35Q81AWnY40HyV99WCO2HXMu9ETR19Oi7B7
 n7TiC/X4YFwf9WWSWIWrV0x/Y6u4R34uUEvPsIDgGC4knBgwzbCLiF5Ez
 GfSOVd40sctAOoP1732gBrHbrATgD6uBzqsN7sPGWTTdUV3zivoDzGIq6
 MlPncHSdpYr63OY1qJyY/uHfZVR9CrLHC0V96cXGsm4yhsPuywz6ibhe2
 In+ZSb6qxqSeoGHp1fZxlfxU/y0SkdsW3vV3MRZkzNmb5g1bJGj3gb/z1
 O7yiTNV7BIFHBv9GL5IUDsWwj8I2YMgSanNUa+QpK5brYeUrA6eNXG8I7 A==;
X-CSE-ConnectionGUID: EMeNBSEdQSSYJpoZDFaX4A==
X-CSE-MsgGUID: Xzjf9ZjvRd6WNEMJl2x3xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54000655"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="54000655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 08:53:34 -0700
X-CSE-ConnectionGUID: vblKivI7S8CnAgHthZHlcw==
X-CSE-MsgGUID: NiPIrp5dSFGEzhkrrBNNbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="120521882"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Mar 2025 08:53:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 08:53:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 08:53:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 08:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4aLI4dV8Ge7GevPznubQzPr/C/ssXZrxHL7MLgdW+oexcseM+KLWP/xzo2NvIQMjRxOHtHGUKK8HDZHUFBw0xZ6iAVh3S357z+lJ0/OON7tiJ2nAieS+owSGmezZh83pC2d4BzIVBURcB43SmVKaF4H7ordgt+qCYxqSGEImpWEG2Z+qI1q2+zvYqT9fYhq3C/Fvp+0sDzBfoUBMeRz9oNNGUiWJlaWxvnypOfKjJx4TylT4PAWshfrdjgad6N1qp9yTn4f6KHDphmU88Jkm3X7ddWTGs3Q6KUIDStiAAnWymWLpb+ie9YlM2PMiuyb2qlPwlFx21BFWkqeYzWU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4PChCrLIHeJfK59x94CtU2IegK+cD8frXNxJA+1Lds=;
 b=oR/VQpRpWW3Z/v2rN8nvdlMdd3c4wWNvPEm2msK9A8XKAX5eG6idImyHNAj3+Sw74pDGQSyD48ZJ4+fXJoCZyaaBigXlTn4LkRke3PtWkw9qraWtqyg1Pz44orpw4AFExKV4WJHXteK3e2hctolg0HfF1Dpjp5rQDiR1oNxbu1Ckl9EP46Sh8vvYkVqj9eR8HC0aC4NyO51DSSue8ogiNezDbrxYSqLk8OUc2pBo0x+tLJBCjTQ3ps0Cwo4BnOArn5u3+ao/8aWh+RVOmUwhTGQKb+0bpxZ9hwe3Ia8Cdq+6ccraSuHAgD/DNM4wNU7YL/ylqesvTmdGBoVP4IZJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:53:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 15:53:31 +0000
Date: Mon, 10 Mar 2025 15:53:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/intel: allow fast-free to empty cache
Message-ID: <Z88K9QPJD5chiPya@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
 <20250310132540.1341258-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FADC@smartserver.smartshare.dk>
 <Z88E30q5IkJvISW5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FADD@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FADD@smartserver.smartshare.dk>
X-ClientProxiedBy: DB3PR08CA0006.eurprd08.prod.outlook.com (2603:10a6:8::19)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff6b9cc-a762-4311-8760-08dd5febb479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+kGZ8dfT6dA5oTaeooO7l8IlOyhwnmUTR1JOh6AuFDrzLBDi22qENzO5QV?=
 =?iso-8859-1?Q?GYOouKH8u/abQXYycbZTBWdXF/9zupVVvDGkkahC02oIZrzU/qhWWtv56N?=
 =?iso-8859-1?Q?uod4qVmMr/UGV8tJzJzUlJ5ACl3tQ8a1N1RDfIYTlUDWIBP3eaNXcSLa40?=
 =?iso-8859-1?Q?+66pSJLvMS7TKHEMdG6ln7y5UVL0Wwb3fLIlijMbUV7yY4gNz83AAHp9bH?=
 =?iso-8859-1?Q?RYfJLQgWMuzOWiUz9zaKKQXALCW2Kop4g1Fj3WFShB02WWAecFizCw74Gw?=
 =?iso-8859-1?Q?w6Z/IDlKZNN/BF7PI8K2GsbJ0w/GAlYLCdCkTEgdz43B0DGEjwdCrBZ/mT?=
 =?iso-8859-1?Q?ZI1m/Qx8crqRCSeZvS3mvyytcmrHaK8pZHZGi+ZBgebz7baZnzuWNIp4s9?=
 =?iso-8859-1?Q?q9JjomsTGVcAjJeVqY9/V/lyucxkMFmqDEH0VS002fqaPA/WYrRB7lAWE+?=
 =?iso-8859-1?Q?G96Zobbd1xKb/mMzPu9BrMBQS87z7sY1qtWKaHqH/pPm5fc/w8pwtAl+ns?=
 =?iso-8859-1?Q?TLSNcu0oduiFNnXrm6Wj9+2Drri+JBkvkBNbeEKMeg3ikxlmM9ygTEt5Ik?=
 =?iso-8859-1?Q?rWlRs+qYQB2yGzHvKs+l45DK5vzjIYAJ0SujZde9JdmfiEuOp4LUP/vGSH?=
 =?iso-8859-1?Q?MNWZubxhUszE/T9NphXmMHiSKV0I2lR9XDTPo5Jnwa3CRsqHW9vVOCON9A?=
 =?iso-8859-1?Q?83C6JnpBVdV83D+Yv0xREGXoPZTCdrkJpudP0AtTskpZCx0AtjO/ez8qJo?=
 =?iso-8859-1?Q?Wd+uqb3ptrR4k+qmpCJJrH21gD4nBECYf+tCk8L5FXmQLMaOiInC8WmoQH?=
 =?iso-8859-1?Q?ZP0sGJnPrDYaMJqf96hBa/McDVzHFH9sz5KkpoXQePDC4HZT3iakwwX6mE?=
 =?iso-8859-1?Q?AR9BHHbyJ5xm7/ejggZziQq175BohUkcQsqApq+IlVvnZZr4hUOviCjbWV?=
 =?iso-8859-1?Q?VFVSQgGS1G8O5hpmHH6oW7grDdnNs/FWobRZvqbJ4Ri6Ul9d8/ZeDdT8SW?=
 =?iso-8859-1?Q?L23OuuAgTUGEBzBNu807OUO9ardVVrfQ7LtXTrCrnVEwg9HG7ZJqCGZ0cz?=
 =?iso-8859-1?Q?ErJkWlZdQCw6X06q6py8OU6hIgUIGqNFglo2mHS17ByEFZUj5kA3+7Xv6O?=
 =?iso-8859-1?Q?LWXwztVH6KnCcbeMk4PzRGb/TLuQnbwdDcohmjxK2mZf3CXsLrNXbQ3Cx4?=
 =?iso-8859-1?Q?1Z70yzGmZ4ssWJbXGLwn1ynQTChUSbf8tW+XxPCBKgiJ+qe+tGDju3n+q5?=
 =?iso-8859-1?Q?WkMrLzRCnna+hOkCCp8E4N34A4rMk3YW/nqDuRmVyNmJQrZCSprgZPi3BS?=
 =?iso-8859-1?Q?QwCUEUuvwkZAQDDvREOkVS01CJBWeovI2sAfeLnTVEby/CVQRlx0xiFkJK?=
 =?iso-8859-1?Q?Vk5hEA1ojNcojF0Bv+MuTFakGca6y9Fw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6XbOoZjmtWVfNjisbHtmOo+2CoC6eeSZJ8yMfuq/mMgIa12LLQzoS8KBiW?=
 =?iso-8859-1?Q?HIPITpYJGgMfkUXZe7s4C+gg3Mg48DEVmQzNuXdx+iFsfuR4iJUo8LJ3W/?=
 =?iso-8859-1?Q?qVBaNseBIeoE7EIkBU+6LJgKqXoSO9bJWLw7c4W6+D6UQod6t4MnOUqDh3?=
 =?iso-8859-1?Q?3K1uL7UCdjFnsWrinhTUwLE2XqzWPfhmES5/sgMq76zV5Aw4J3zl4mxVvi?=
 =?iso-8859-1?Q?s2BlaGkYCsuw7d1TauQ/Ci4O5LlVPOmlKdi0H/47MRCOUDFQLSS3n/O83S?=
 =?iso-8859-1?Q?AxR+BnuBNIGrfjLbxnX6qGxIaWjLpwI3VH/qTzlq3nRtzqJ4WnrD9Igk2A?=
 =?iso-8859-1?Q?Eod/jwApLUq/M4u0XKYwWHSjfnct6v18p2X0y5ayVSLyiTrdf+JdXHUMIL?=
 =?iso-8859-1?Q?S+UUBiyMmQtIAuw73gGPy8n4FBMpYfbTOV3uJoiJhj6knU/tKm1vtV6zYm?=
 =?iso-8859-1?Q?iXo98opSEHRTmO+EjsJUVHa1Z8ePRAl02eif4Qa5C0aNuoAnqTOoJ2E8Rl?=
 =?iso-8859-1?Q?Aq9NBRWf9/dXrJ/sQ6a9lVeI5Vdgsz1WOnj7sTnu2o9o3ayGgPBuE7ZGOO?=
 =?iso-8859-1?Q?PXJ17CrGHmWJqSvHinLv8RQxWgroZ7ijGXzWZc0Ys8cD1c8oyJhnYS+p2m?=
 =?iso-8859-1?Q?kuzKU/xrnkPpUtGsY4uAJ51XPI7ReQsTyODtSjlHB9nQoB2USX27KvX65U?=
 =?iso-8859-1?Q?SHp48YhyygrBKu6sZtzkf66c+ZDc4B174lGwPkBObpJ9w+3eGtG7R+4552?=
 =?iso-8859-1?Q?htBBr5k2zDKB5gonaeA1moHW2fkS4vqGHjyY65xNjTYdT0e84/Tv5olnmM?=
 =?iso-8859-1?Q?zATJPAAQIgifjQTp8J7Hyp0Mqy7wEyeHJoCIvXl9RhsdC01LHj5dTb2VZ1?=
 =?iso-8859-1?Q?7GXT8uPmZPB5fR5dzyqNAjorVqyOIdiB2SWi3evAaOO6DGmvZrjb9EaHFw?=
 =?iso-8859-1?Q?L4e4EdbPYfQay7u2rKHoBCKT66enm/3w23fRfS3geExdqgHTs5tk/us+Nc?=
 =?iso-8859-1?Q?dFxbVkhB6PX+RPJzbfz0OYU9QFPrZF9gTkg5KZWgwW8CGykFj/r4uSzg4f?=
 =?iso-8859-1?Q?VPON7kCyQq8GacVxyzFDtxzcAPDNz+doUKprPB8cwYi07h3J7NolOXcxBX?=
 =?iso-8859-1?Q?qiFy+j3R6iLmUQpNnRhlxcgmudapwckUgJjFvLXuaCFqKBs2lBTYNxEZKx?=
 =?iso-8859-1?Q?DvPWQ3UYflvCpEIj02a7MJ15o8F1djpQTx9eFDgwfWeA0VNLV3+jFEuPgu?=
 =?iso-8859-1?Q?MKC2GSd8LcEGVX9dBCrFUMgPF3A8QCei24H++kiWTcuUdyUT2ztEafV+A0?=
 =?iso-8859-1?Q?+m946UXVCker5QWNddPS8v0BeYfuqoHgMVGqBgBHxFaOjdSDPNPjY32PcD?=
 =?iso-8859-1?Q?1pXr7wQaqNFtLSbsfdE26wX6r0Ek/xcIgSZmId5/4yxuIqwMlVPrHq+DBp?=
 =?iso-8859-1?Q?A6C8mfC4IQvgvl9pE2auWbLRcvSyOwbImqixXXlWsvyOwTO3FF2KR2T9sW?=
 =?iso-8859-1?Q?8H4LTshGh4l//7WE8b50YBkEuMphTCFys0mf2n19zpIXIetDccC1ZnRMOL?=
 =?iso-8859-1?Q?byEF5iW4ukQkCkqVxAHefffS4+uWdqbsISYgZzxovOmjL2HBGhVsP5OcXa?=
 =?iso-8859-1?Q?2JLiwniUVCdMHATBznOlaIUZg85NF8ps6SEbu4MRgSkJ8TJ50zVmxmPw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff6b9cc-a762-4311-8760-08dd5febb479
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:53:30.9192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRgPjU0ejm3zTOYM6qcbJ+2cBsRz52ruxUdf+X6VzEpq1cpap5HMp7kjhzRlolEA1KaEfqJFw9PYvWOP9N4dGUEKO/HcF8eoCvH9/5AeUqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
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

On Mon, Mar 10, 2025 at 04:34:23PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 10 March 2025 16.27
> > 
> > On Mon, Mar 10, 2025 at 04:18:35PM +0100, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Monday, 10 March 2025 14.26
> > > >
> > > > When freeing transmitted mbufs, there is no reason to send the
> > freed
> > > > mbufs directly to the ring if the cache is empty - only if it is
> > zero
> > > > size (in which case the cache pointer is NULL). Therefore, remove
> > the
> > > > empty check and only check for a null cache pointer.
> > > >
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > ---
> > > >  drivers/net/intel/common/tx.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/intel/common/tx.h
> > > > b/drivers/net/intel/common/tx.h
> > > > index d9cf4474fc..d361fe64ab 100644
> > > > --- a/drivers/net/intel/common/tx.h
> > > > +++ b/drivers/net/intel/common/tx.h
> > > > @@ -143,7 +143,7 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> > > > ci_desc_done_fn desc_done, bool ctx
> > > >  		void **cache_objs;
> > > >  		struct rte_mempool_cache *cache =
> > > > rte_mempool_default_cache(mp, rte_lcore_id());
> > > >
> > > > -		if (!cache || cache->len == 0)
> > > > +		if (cache == NULL)
> > > >  			goto normal;
> > > >
> > > >  		cache_objs = &cache->objs[cache->len];
> > > > --
> > > > 2.43.0
> > >
> > > Yep, it did look strange.
> > > Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
> > >
> > Thanks for review.
> 
> BTW, I recall other Intel drivers having the same "feature":
> https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/iavf/iavf_rxtx_vec_avx512.c#L1876
> https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/ice/ice_rxtx_vec_avx512.c#L891
> 

With the deduplication work I did earlier this release, this code should
now be shared between ixgbe, i40e, iavf and ice drivers, so we hopefully
can fix all 4 with one change.

