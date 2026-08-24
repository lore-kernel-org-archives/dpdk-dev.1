Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05565C5DF94
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 12:10:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37D8A402BE;
	Mon, 24 Aug 2026 14:10:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2478E4028B;
 Mon, 24 Aug 2026 14:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787573407; x=1819109407;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1fOBwkwL0aeKaPr8bo+pQ0Mi687J998fIWp3IyY2beU=;
 b=mgpJgRzgCto7sJBdCzY1Z53gI1kOhaFIEmVpfWWgMMupQea/HfMTAivK
 LwEBFBlxc9q1r/UXn1bQy/4P93l+41nPUATkFbTTfMSm20pYVwm9+UUet
 5JmDgohCDUHNH76V6xQv+MUOBdRS3Eyw51rLakHuhNF6REcLur6s2D2H3
 XWcDB3azPK3nbkFsR7OtoXmoN16TZHbL0Zce4phJ8Tjv7aUy7wcnQPLjL
 94YdkBc8xtKrf+8w3zOnwCADlR5rB56WbzC6Qw39CKSrDvHHMow6H3rYP
 CKj/tO2/Oxd0AZG9G5IuHejXJR8mGSAX9+8zeyZoT7tfnFQ9wTFIyqgRb w==;
X-CSE-ConnectionGUID: pVOIGGwlRmytEnv7V9eSrQ==
X-CSE-MsgGUID: BqLQ9OnWQzOJaNvqxpqzCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="113554837"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="113554837"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 05:10:06 -0700
X-CSE-ConnectionGUID: 6d/065gARSuPdXsy4uKPdw==
X-CSE-MsgGUID: 0DKZJBQpSsuyz9rkFUP9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="263260349"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 05:10:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 05:10:05 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 05:10:05 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 05:10:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlBScikFvGxLGmnYAbBrXBHOqRDqXXgEX/1AVLST0O3ysOu7ZNL2DRMLNeYcuoXPpskcGnnAJkpp0MM0ja9D/ksxB1fYWItlP0qSyZ5j+qcWS7TPMtZHCKjaW11RkR9M5iAF9E8RlJTK8FjFZ3CeHUFdqheGkdgdYF15jiQR3R4Yc2Ks46fdLANOze8qYd+UtUni0KDYNbBV1lzgE4x1MFk2H8VUrMoQPyxPHVW1aVrmlNG+pI2tRgytog4+++yVZf9ncL6Z++jHVIRHo9OVQJDD90yeBZJyvn2WztXwZJz0AOK5Nsye3fj9uAKFl86ngeRvqiIIY0rNTm2GU3OvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRQktQDQz4OvmiHVlfWfqOw5CtP6gSXaWRI5bXouDjo=;
 b=iRkSGQUMjUsqE+Akya3fuWIvmiNtw7Vt6tr1AvjKO4VAUjeeBzE6dzHDR+hb3ogJg1KmWkSs+O0qPi3DBw0PbuUx2lT5Rd+JqpWnFOdYEfI2oUxc2dwQzJ77FdAKac4jiYjkrplGrUd3HWIhSK9l20wTJHS741GJkQARHRLTi0kde7AETHgBJmzm81rYNvnsgIlpoRu5YEQ9L0magIiBbde4gFWo9c76DcvYgngKaLKDJ50YIBdVb8PiL6zDchRP84IY6bfGb+0S00whBR9XWHeim1FzDbKwBJJMSGMIOYGA2WsNTGsM50X0KYlvHT8wBm9cRkY3HGx0o44738HBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) by
 IA3PR11MB9182.namprd11.prod.outlook.com (2603:10b6:208:579::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:10:04 +0000
Received: from DM4PR11MB6551.namprd11.prod.outlook.com
 ([fe80::b18b:2e84:63b3:38eb]) by DM4PR11MB6551.namprd11.prod.outlook.com
 ([fe80::b18b:2e84:63b3:38eb%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:10:04 +0000
From: "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Loftus, Ciara" <ciara.loftus@intel.com>
Subject: RE: [PATCH v6] net/af_xdp: fix shared UMEM refcount corruption
Thread-Topic: [PATCH v6] net/af_xdp: fix shared UMEM refcount corruption
Thread-Index: AQHdMNgq0WExsMROs0WOfOenU6LvSLaozx0AgARRHvA=
Date: Mon, 24 Aug 2026 12:10:03 +0000
Message-ID: <DM4PR11MB6551D693EEF205F4577735989CA02@DM4PR11MB6551.namprd11.prod.outlook.com>
References: <20260821004435.216833-1-sandeep.penigalapati@intel.com>
 <20260821021607.232149-1-sandeep.penigalapati@intel.com>
 <20260821111052.0985727f@phoenix.local>
In-Reply-To: <20260821111052.0985727f@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6551:EE_|IA3PR11MB9182:EE_
x-ms-office365-filtering-correlation-id: 8880e349-7363-43a2-7fcf-08df01d8a149
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: GEsk8M59a5REn7ert+npAp7CeReK8rp/ONXWu4hcJLo5JedvGbclsdo4qtGFaJQJ6huZMPklxDZqGZTfHgz399ZirYqRLMh/m9zQdkDenXaFnjLWpjHI9udNfR5GxVWgkIQaz+Err6fs6BXU4NKttD49Yrhg3Bbwhpr1+tYfbPNjaFqyzdomiTudLbCAybSQMHiYSwYQFkv4mdEvilwzAqx/sym4/C1Ftpmh9ex/yvQwLYkIuoubnSkLrm5m9mkDT3ijKUx/M/pPUuDjSdodhWiQfgsT6qcuZQDgIyPafUH5gxxE0FiulwD8MW2l/5dl0mj61FC1cwIpU/zudopV0n+U40XXwhJyndeEGgX+U30n8BEcjejW1yU5D5OR7ssRDZueO2QUdwM+m4uXP4KFOCX/UpQ/3NgDrpmC3w7cSwlTqaAlm7skVngeP6sfxIOq7LTD1cEJDcSDhm6yRXP5Fn8AJ6FtCGsWp1DwVTVE7M2nDcrkaRdsoWYh3SokEwuAvaItMMEVn2scDFdh0eBhNcyLEAZqEQbwXxsKynByXF3jvQDIGFu5wjFQZAeumZgNbqHPuOGzFTbkZJKCrNdTQXdzSLC9PDK2+bBZA5P8bbGckr322xXrX2h/ysPksa1v6jeY1rRZMcP+cADx1hGxk7py9R4BOc/Favj2jWX2rSBqydBs6y+Y7z0CFUpbKx9zssxnu+iqteJts7JytoasDNihyB2UpcCISbh7/VbjjeQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6551.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r+m4/55MKjOf2L92rXu21OaKfgG9pcXQyfzkXsKRc06WPfsW6I4UtfII5bFd?=
 =?us-ascii?Q?AzGDoJXLb5N9ouFuu8LFWv/kB+C0F5c/tSEF33ZPPZp9Djf3BYA75HKD+7K7?=
 =?us-ascii?Q?ohn+ZpTieyekciHz5/IBQCmy90crErjsOtGHkE5QZep5bP5T3mdoJOJg1Xmr?=
 =?us-ascii?Q?yw2rnHGjW6wwBVCgWXGPzLQJyn7hm6Ix9MabBcra3tgXx6rW0R47c7Ad00xd?=
 =?us-ascii?Q?rwPSmQXvR7jTfq8kirPYXdnjJAMTVpvQxAro9rQxRQaPG7V/b/6RsEYOYWYo?=
 =?us-ascii?Q?SJdOOyPwfKFTehT3UXDk/tcbdMupxHus/6HLWLBSyJv+56ddUSrCNBSbr6Bx?=
 =?us-ascii?Q?b9/SqWdjzOJfARq3j0PJRFkhD4AkFjN2aHI9kdM0nS502VgvlfbjoPCUuaR3?=
 =?us-ascii?Q?LdWDOMpNaC8L4wWTa6ZMuJJfgOrHYW69Wy7/4G+3QOoc/Y9QW/GFuKocIX7t?=
 =?us-ascii?Q?SH5XfAt7hl/kl4ICAq57AW35eSs32EaqWiJ3Ft1ab7SOVuqXJVkTMk5EPsAa?=
 =?us-ascii?Q?DoLvPjYmZ5Wbdu3ItismzgdVv6HM1uOZ9AY0Cdir4CHq7VoQ7GF+7UvQtWOx?=
 =?us-ascii?Q?U+hBlNj9HOGD4V0xE58+ZufBvrISODH3XEcRq1mKeuJStdVdqxxjCqbBk+0V?=
 =?us-ascii?Q?UQJTzrJREP7+rrZLAe7Vf6LPr3cx4B1eNi7HmmfJdyD5jKKCtWl0dgAHeQ4s?=
 =?us-ascii?Q?HfYnE6Tnuo0/5UljGFxAmv/9SXHbZ5P2y+1iQa27iRepzrE2H9aKj1EWKEJW?=
 =?us-ascii?Q?ZSfnAG/sRocAk7E84ZmyLzDQJCK6vmvEzsX3yvL7andgvekKswWUygZEQgJS?=
 =?us-ascii?Q?3bpVvXFlZCVh0wfShhwxwTqvjUjijX4j9vswsMVlahJMJzpToWgtshG2JtK9?=
 =?us-ascii?Q?ysYdiK4E5PFrTlXFy9f25ttkY4utzILBf1lBlHkWhc21Vg2OukA+SaTiMixu?=
 =?us-ascii?Q?ZJKptmBicxZ5rHKKuXlX2jg4QO0ky0uOleM60+G0NzpyWiIFhXG4A1cVYopW?=
 =?us-ascii?Q?4CjmeZOWQJ7EGAKwyep7+X0USohs2o+zx2l8Ni51eTQ9fPcikMkZg/G1u2s3?=
 =?us-ascii?Q?7+8nr0+vlQyhdPUY8QMFK+jC9GTyIoXGpb5LPds10FHlOEmNSDKFJLgJixfd?=
 =?us-ascii?Q?kRjMvSHoxZHqelvH/BPQNADQPyzOhnr2MDzD5s4/o3yFVhcY0zuxfvbdUZ7w?=
 =?us-ascii?Q?Vzon0L4VFguk5NwfqwWHAKWz5DhtUpeM1Vf7feLRjMaMCOr6JfqlpNZ3Nu4y?=
 =?us-ascii?Q?fUg0DdAMzq24v9xkF4mSiy5EQKSl4Kt4443nfwhxdTbial3kdQSQFV+OIFtq?=
 =?us-ascii?Q?I2jcK94nKapF/+ZzTSSPz155YRDEcIP7FvMErGyyKJFwAH29mRF/woIbZwTz?=
 =?us-ascii?Q?G26L1Hea7X8UB0t2niXDw+u+obTH/JFPbanYlTv1ghEsLngewp2xf2Z5W5oX?=
 =?us-ascii?Q?95bruVronHTQUdazMj4+7QtCtqXaVj5D7ErTx+2I2b8GIZb+n+D0/ftnVJb4?=
 =?us-ascii?Q?1UWU4lj6U34jiZGotV2kfMVya11PHA9O0SctYntC76FCqK3ZTMMk1ru5H4u3?=
 =?us-ascii?Q?1YGSrR5iguighXbBDgqfjSY1O+hVl4XEO7XeaWpdMZTZFiM6wnEMq6YZyoVQ?=
 =?us-ascii?Q?i7KWae/+js6HMHGU2qLhJCDL/UXInYTKOteUGe6DdsYCLxvu48zXLbxACL0w?=
 =?us-ascii?Q?KV2fOIdjEEVs3/vO3jDK6w1njyzzq0NRn5KZaJnS7+yImbuPDbDII5MyrnrF?=
 =?us-ascii?Q?QhsaDbXs8K+95TL2pKFP9wFyXSAhhhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fUVmRdttcuRKCazEvjVQG0fAqpYhXqHylok4i+CrQPB3DygHOfYfFllLhYgt5ObXsfrpCSXKlh4gNpReFZCEaYZWQIxcc84bobWvlQwoc2L+sVxlRQDW5T9/uTAl8slawwc5o42pG1JxChR9M/L1C6Mwm8auuEbrZr3VotAyvyRUZNYerJpAFXf9pZOh/s7MA5mda9ZuUORYzgjrHCkhYKrSQTx9wLnZZ6nBeLiRv8p8+mQqXwy8Np2TyYP7zCuAWIrvziDsYijKqhK+GZe+iAn2jmoF0s1PdzkPid45RLlB59toF9wt8aHypVhVvAcvmNLbLXo4PL41IS5drMc/uA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6551.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8880e349-7363-43a2-7fcf-08df01d8a149
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 12:10:04.0082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3v2EcNK/o43egU6ZSEkUifUTz+BoUaUPZaodAhbtCWe/1Mb5oC/LIN6jEbZZ8hmpkF3D1gdF3B7Bz04bfssvMy1+upIBck/LCyWB+gSNqWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9182
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



>-----Original Message-----
>From: Stephen Hemminger <stephen@networkplumber.org>
>Sent: Friday, August 21, 2026 11:41 PM
>To: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
>Cc: dev@dpdk.org; stable@dpdk.org; Loftus, Ciara <ciara.loftus@intel.com>
>Subject: Re: [PATCH v6] net/af_xdp: fix shared UMEM refcount corruption
>
>On Thu, 20 Aug 2026 22:16:07 -0400
>sandeep.penigalapati@intel.com wrote:
>
>> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
>>
>> Shared UMEM is meant to be shared by a limited number of sockets,
>> governed by the mempool size (max_xsks). When the UMEM was already
>at
>> capacity (refcnt >=3D max_xsks), xdp_umem_configure() returned the UMEM
>> without incrementing its refcount, so the extra socket used it
>> unaccounted for.
>>
>> This missing reference has two consequences. During queue setup the
>> fill-queue reservation is chosen from the refcount, so the sharing
>> socket reserves into its own uninitialised fill queue and crashes. At
>> close, the under-counted refcount reaches zero while the UMEM is still
>> in use, freeing it early and causing a use-after-free.
>>
>> Reject sharing once the UMEM is at capacity by returning NULL. The
>> error is propagated from xsk_configure(), so Rx queue setup fails
>> cleanly with -ENOMEM. This applies the per-mempool socket limit that
>> shared UMEM was always intended to respect.
>>
>> Harden the failure path this makes reachable:
>> - clear rxq->umem and its paired txq->umem when xsk_configure() fails,
>>   and skip queues whose UMEM is not yet set in get_shared_umem(), so a
>>   later scan over the same mempool cannot dereference a NULL or
>>   dangling UMEM;
>> - free the fill-queue mbufs that were allocated but not yet handed to
>>   the fill queue when a sharing socket fails to bind, so it no longer
>>   leaks a burst of mbufs back out of the shared mempool;
>> - propagate the map-insert failures in xsk_configure() instead of
>>   returning success, so a failed xsks_map update no longer leaves the
>>   caller using a deleted socket;
>> - continue past, rather than stop at, a failed queue in eth_dev_close()
>>   so later successful queues and their UMEM references are still
>> freed;
>> - clamp max_xsks to UINT8_MAX so the cap stays within the uint8_t
>>   refcount.
>>
>> Also correct the UMEM refcount memory ordering: release on the shared
>> increment and acquire-release on the final decrement, so the thread
>> that drops the last reference observes all prior users' writes before
>> it frees the UMEM.
>>
>> Document the shared mempool sizing requirement (4096 mbufs per
>socket).
>>
>> Note: on stable branches this is a behaviour change. Shared-UMEM
>> setups that previously appeared to start, until the fill-queue crash
>> or the use-after-free at close, now fail cleanly at Rx queue setup
>> with -ENOMEM.
>>
>> Fixes: 74b46340e2d4 ("net/af_xdp: support shared UMEM")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
>
>I am ok with it as is but AI still has some Info level comments.
>Will take it as is, or you can revise (your choice).

Thanks, Stephen - I'm good with v6 going in as-is.

>
>Trimmed away the noise..
>
>Review of [PATCH v6] net/af_xdp: fix shared UMEM refcount corruption
>
>
>1. The refcount increment does not need release ordering.
>
>	rte_atomic_fetch_add_explicit(&umem->refcnt, 1,
>			rte_memory_order_release);
>
>   rte_memory_order_relaxed is the correct weakest choice here.  The
>   incrementing thread has no prior writes to publish; the UMEM was
>   built by whoever created it, and that publication is already covered
>   by the release store of refcnt =3D 1 at the end of
>   xdp_umem_configure().
>
>   The commit message attributes the guarantee to the wrong operation:
>   "release on the shared increment ... so the thread that drops the
>   last reference observes all prior users' writes" is what the acq_rel
>   on the fetch_sub provides, not the increment.  Worth correcting in
>   the message even if the ordering is left as is; it is harmless but
>   the rationale will outlive the patch in git history.
>
>2. The capacity check and the increment are still not atomic, and
>   rxq->umem is mutated outside internal_list_lock.
>
>   get_shared_umem() releases internal_list_lock before returning, so
>   the load of refcnt in xdp_umem_configure() and the fetch_add that
>   follows are separate steps; two threads configuring queues on the
>   same mempool can both observe refcnt < max_xsks and both increment.
>   Separately, xsk_configure() and eth_dev_close() write rxq->umem
>   without the lock that get_shared_umem() holds when reading it, so a
>   concurrent failure could in principle free a UMEM between the NULL
>   check and the dereference.
>
>   Both are pre-existing and control-path setup is single threaded in
>   practice, so this is a note rather than a request.  A
>   compare-exchange loop on refcnt would make the cap the patch adds
>   actually enforceable if that ever changes.
>
>3. Mbufs already submitted to the fill queue are still lost at
>   out_xsk.
>
>   Once reserve_fill_queue() succeeds, the 2048 mbufs live in rxq->fq.
>   A later failure (map insert, busy-poll config) deletes the socket
>   and takes out_umem, and nothing drains the fill ring, so those mbufs
>   never return to the mempool.  free_fq_bufs is correctly false at
>   that point, so this is not a regression from the patch, and
>   recovering them would mean unwinding the fill ring.  Noting it as a
>   remaining gap rather than something to fix here.

