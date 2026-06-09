Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0E2CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 05:23:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F3A3402AD;
	Tue,  9 Jun 2026 07:23:44 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by mails.dpdk.org (Postfix) with ESMTP id 1B177400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 07:23:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZKfqBKtPB4Bqd1L/vJhOcCaLG4LIfgKC/sXU4W8Abj8qFnp5lKED93dDU2BW+n38sl7ahTpFoRWsiE974tJ0U9T4GO1sTu4fmBPfExizJOc4X1EWmYGTNgB0xlcf79VkDePgvYtn/IaJHhSg3rRS0nZlHwQa4OAg1/5u6bfO2XUnyC2qFFgVhCzxbk0T5VhAhevo/iJryKvwBmhoaPmW0jRKo1/bZgzqKal7/z0XNgGIkVEExQJTL/U9INJK91DT/Ee0RB+GJFYN9g8D4Ky9OTm5h2usMlpy+PrHvRNq9G5fP9UomiKmHaAmFdAdqkSyfqt9CFzLtBdXeCs14dVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0otSU6Of2UPSnudqvLjNWg70MSwHsDyPVJIs0YjPAbY=;
 b=nO/MsHo1fWCFupOUnw/brFPnSTFs3ko6JyjSjbALK7j1UMJLPhhcPFSDPKKIEopCgJ4BR8vk+SqjCnQJEFIiPQ174mbGykjnLmz1Vja3IqXGXFfl/sD9ebFyUm43qUy5STR/tsrM52HNGZ7o+E7EKMIv/zP26JcUo07Blj3QQ8VX0au5hcwW77HvdCUj8YUR2Sx+umaLL6CDYI/MetNkAPotF1X8TIVPy1+fUJMoZXJS4wwWyKl2LAdPjM8i7EE2RecR1lG7ndDJn+q6jCD418e735agk4TSIA54ZYhahr+X3I+p2TYcC2wL6wT07Orul6f1yqz7h+lLkVrVFFO9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0otSU6Of2UPSnudqvLjNWg70MSwHsDyPVJIs0YjPAbY=;
 b=r8pGYo2rUy+kaNp1fg+299z7pqhPX996NwQBWUEIsGQ15k5AG3Dzw6oAJRrd5V44gIokSKYriCtwJxUoMiw5jph3QKOWyWv8SQIGti9kMiVg5u6xBPVj6u/UuIJrjkHXnUppK5GUmlULMyDi10X/VzazNyblX6Uu1XHAcHAFwwRGvUX8YWgUCM48Sg2me6crVCC3UnM69zljqjp/JPZrdBsHjcGJW/dCx25iluflAAO56+raAdeGq7npP+lckb5kRvcC0HlJNApygUNwZ37z2ci9xfglzieemBQycnraDiQPOhJ8citT8LFJiWHAMJAUuz3p+8Xpmjk8jk1WWqjLDQ==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 9 Jun 2026
 05:23:39 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 05:23:39 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Ori Kam <orika@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan
 Azrad <matan@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>
Subject: RE: [PATCH v4] ethdev: support inline calculating masked item value
Thread-Topic: [PATCH v4] ethdev: support inline calculating masked item value
Thread-Index: AQHc8ztrRWrD0dpa1kuhr3GBzIA7grY01VUAgADkXoA=
Date: Tue, 9 Jun 2026 05:23:39 +0000
Message-ID: <BN9PR12MB53381BD8E5B7A7B90718E713D01D2@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260603081941.9049-1-bingz@nvidia.com>
 <20260603092805.9837-1-bingz@nvidia.com>
 <20260608084558.4dd4c07c@phoenix.local>
In-Reply-To: <20260608084558.4dd4c07c@phoenix.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|MN2PR12MB4302:EE_
x-ms-office365-filtering-correlation-id: 33c8ecee-af2b-4c88-40cc-08dec5e743ca
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|3023799007|56012099006|18002099003|4143699003|22082099003|11063799006;
x-microsoft-antispam-message-info: Tna/M4ThDx16VGgzk5Oh1gnnb75CarAsBJUatfXEojToc4dWhT2Dsz612GhDOkHOQpu/7r7s8+ijn94zcmxdj3lRdKlDhMwe+Ds7mqSX4v3MwVorxs7TyjoPICbbTEd9jG3mUyCoIDiH8sLAMnGriGXizkgzSYrsrFHWoAg1CFRpZacnGE7M0JCzGgWb8vQ4JYSzRFSgR9ZR4RTTFMwttZS6SUUvHS5GdndQQEsNYrIUt8ENf0aGwfSdTDYkMWf7MtEdP2QNTY+ZAua+tLiq7X8Msmd7+CRexfc3mbXBspuTrU3Cxe9/vhez2atNj0txpsS7XV0QtTtqLlxa13LrxsMiE8glZYNm7b+zMZYpzYiUsROHE2JcqBzTgWxBO3R4sHBAj4aKeab2+nyRbirIqpF2a+s/P1gChq/Jle2cGkMCEwzJ26bfRvb4iC81JsgUo31gJGhN+DgOEtjdWQVg5N2bNTWYGRJpYg5VaBKwMIhvlvmjEnrMOZjz8gYsOLiRDtb6Pp3lhDk4Q7YrBb2xWg+4bRCrv+JJXQQQoxyFmqLRIgmOGpGv9Em3AZuIqu/DU3Aw2p+Q+CuhWBcpmYkgOtf2YSGBpg0oZNiWNt20cv45EhzjYFw3/IGkxOn7AVspgSJWTKRTnEN6W6PgEqFQq9FUnTmis1nFcSEJaeB89vaBGn44Q9YFDvXannk7WqrqRilydtULf23j5ZzpIU7Lrma4OMYo7K91QNQFTiBq3WIWFLq6J6T/LhPGhdPavBDr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(3023799007)(56012099006)(18002099003)(4143699003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hTWesWravhSinkD0CbjccyKvPu+NUOjst7RU8rZ5OHVDrzOFqihLrP+qohs/?=
 =?us-ascii?Q?RnJa8eyYp7y87/2tKIiy+Od9bNEJtCSo1ixIFuI9PrzSZr+/+uap5QyG1m22?=
 =?us-ascii?Q?d8XXWBait/p5Di/aZbUN0LkcL0wduV+imDRsnVh9bxoWq0y8CXr6YUt9ESwF?=
 =?us-ascii?Q?yqUMOJ4+mXInZOWUWV0FawnCk++eoFU4T+SQlaruW+zavDc/HcP5azGPuLot?=
 =?us-ascii?Q?LVSpWm/Je8YHBVWgZRevhZUSkSkX5xN9P7gvT8MnYAM8Yt0NqnuUXuf5p0zH?=
 =?us-ascii?Q?avToChde4aA1e6a5IFqMCEQZp9mbVW+uUyqHRrK8Xay0duui92F+zbMfRNIU?=
 =?us-ascii?Q?Q4o6QiRCRPM7wxCxzeZG/KMDWKf0RQTk11yG1aXU4Isq7aKMU3FKGBqBpKqp?=
 =?us-ascii?Q?k4udoWHZu++AntP/V/KMAkdtPQ/g/LGiFtcqxgJT+KaBGFHzRChCmdZzN5Vs?=
 =?us-ascii?Q?rfqmJy4QVVdzv+jMRI1eukg4QYDb3d5Emt3mhy2ern9HKfbAzLlXjXIqQ9hd?=
 =?us-ascii?Q?+xrnV7I5H86OdgSV5q54J+lOHEfDT/tDXpk8uJR5mdJJttDHkX9ZZalb1Heo?=
 =?us-ascii?Q?tiGTJKWFU5dRopKsaYVDV6ABbes38OofTRQXpOsOtbMiYP4EmP3HJKmywL93?=
 =?us-ascii?Q?mNwAwtol4KykkMGw+MIvEh29lSbekBYfGLYic3M0BQq0ZFST2lNjyI0iRcXA?=
 =?us-ascii?Q?8K8C9HMN1t5YPCq8bcBB0TJT5k5t6eB22nrziBsxDOC9wkKDF4TweM6zrzW6?=
 =?us-ascii?Q?jET+0Rxz974b+dqkhvE6WV2PF2TMzzwuKS8uf+gTgvvJcam3uY9JffEMkjBK?=
 =?us-ascii?Q?71VCweJaRzKw8z5+K7MSO465SlxALgWN8olzxOfQvbCoijLM1WUASlJfB7im?=
 =?us-ascii?Q?igRcz8Sf4ioOVldDh7LjtYTQnchCO5+y3EtDmNPRwcsw149Zl7PxBVlVBkTL?=
 =?us-ascii?Q?/85EjKeWIHpLPPWN0cn/NcIzLkFi7m1OOIVbFEGrQvRVprtjRFHyhmLdZRbS?=
 =?us-ascii?Q?8YLEFKe+5bFlpITgEqWa0J/Qer84nJBLPd+t5odSoDj4TGdYGPceYzlTfQUi?=
 =?us-ascii?Q?6CrDCXf86vw73CJZ8v/8gQAkXkMf2eToQPWooI9kHd3fEo7GRBgu1V0nCaX1?=
 =?us-ascii?Q?cSbK0mPgQHjcSSChNGU9AJuSvnLjH9JP7R5E5cX7WB+T81x7dQ1liTVTycJr?=
 =?us-ascii?Q?bLvEDDoOfZYtfz20Z2b1vyMlojS5eRRoi1BoJrRgvswzEg3/IsV6C+v1Mvl7?=
 =?us-ascii?Q?ecDm8Q/JNeLJ5tN3q+5aMRON+rdm2gwABV/j78o6V6UZ6etWygtOln0SUVr7?=
 =?us-ascii?Q?ZDqss61Ii/7ZHPHAn9sgmQcV3mYbFbM8gc8RHjtThMQvloQuBhbIf7xtmh9s?=
 =?us-ascii?Q?gVeWBY+J/JeDkuzmfRK9+lNaH4RcYLFsc+8iyyFGIaCi8NOr8OtX6ad+jaAz?=
 =?us-ascii?Q?xcTTJZh8xHQ5LQsrHocFk/Tft8tBg2cIBiKPjRaqmvm90Wo1/c/LR8jWWzYT?=
 =?us-ascii?Q?qxcjdJkL8u96/4uwcfwZDJ5Mx1QVwbIV02OpFBiJuoQAWNnUQUQD9j7SZApG?=
 =?us-ascii?Q?+ZintZrp3zZPAJK73ZZVxwlurDXtFv1Zv8+1HZCZ0PePiPjd5lQydQrIRiiG?=
 =?us-ascii?Q?P7n7Ta23eQfRZ7f9fFIExLxQX3nV+5R83CCN0PwizaYdsBcPJXCZne/EUZWZ?=
 =?us-ascii?Q?vkX+3TuA3veYrycnKB6mgu5qixSw6EfljOjKKDphtPloMJLg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c8ecee-af2b-4c88-40cc-08dec5e743ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 05:23:39.8410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sh9BfPhY+J7hc2urE5HlOaxIzTzpMOIlcIih9rZrsCVlRggyOer7T4fDASRXKj0Ek3kHims0KaCMc1Y6kKMolA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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

Hi,

Let me check and update with v5.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, June 8, 2026 11:46 PM
> To: Bing Zhao <bingz@nvidia.com>
> Cc: Slava Ovsiienko <viacheslavo@nvidia.com>; dev@dpdk.org; Raslan
> Darawsheh <rasland@nvidia.com>; Ori Kam <orika@nvidia.com>; Dariusz
> Sosnowski <dsosnowski@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>;
> Matan Azrad <matan@nvidia.com>; NBU-Contact-Thomas Monjalon (EXTERNAL)
> <thomas@monjalon.net>
> Subject: Re: [PATCH v4] ethdev: support inline calculating masked item
> value
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, 3 Jun 2026 12:28:05 +0300
> Bing Zhao <bingz@nvidia.com> wrote:
>=20
> > In the asynchronous API definition and some drivers, the rte_flow_item
> > spec value may not be calculated by the driver due to the reason of
> > speed of light rule insertion rate and sometimes the input parameters
> > will be copied and changed internally.
> >
> > After copying, the spec and last will be protected by the keyword
> > const and cannot be changed in the code itself. And also the driver
> > needs some extra memory to do the calculation and extra conditions to
> > understand the length of each item spec. This is not efficient.
> >
> > To solve the issue and support usage of the following fix, a new OP
> > was introduced to calculate the spec and last values after applying
> > the mask inline.
> >
> > Signed-off-by: Bing Zhao <bingz@nvidia.com>
> > ---
>=20
> More detailed AI review found some things that still need addressing.
>=20
> On Wed,  3 Jun 2026 12:28:05 +0300, Bing Zhao wrote:
> > Subject: [PATCH v4] ethdev: support inline calculating masked item
> > value
>=20
> Error: byte-wise masking corrupts embedded pointers in deep-copy item
> types (RAW, FLEX, GENEVE_OPT).
>=20
> In rte_flow_conv_pattern(), the new mask application runs over the fixed
> item struct:
>=20
>         size_t item_mask_size =3D mask ? rte_flow_conv_item_mask_size(src=
) :
> 0;
>         ...
>         size_t mask_size =3D RTE_MIN(ret, item_mask_size);
>=20
>         for (j =3D 0; j < mask_size; j++)
>                 c_spec[j] &=3D mask[j];
>=20
> item_mask_size is rte_flow_desc_item[type].size, the size of the fixed
> item struct. For RTE_FLOW_ITEM_TYPE_RAW, FLEX, and GENEVE_OPT, that fixed
> struct ends in an embedded pointer that rte_flow_conv_item_spec() has jus=
t
> populated to point at the deep-copied trailing data
> (rte_flow_item_raw.pattern, rte_flow_item_flex.pattern,
> rte_flow_item_geneve_opt.data). Because the masked range covers the whole
> fixed struct, the loop ANDs the bytes of that pointer with the mask's
> corresponding bytes (typically a NULL mask pointer), zeroing or garbling
> it.
>=20
> The converted item's pattern/data pointer is clobbered while the copied
> payload it should reference is left unreachable. A consumer that follows
> conv->pattern then dereferences NULL or a corrupt address. Plain value
> conv->items
> (eth, ipv4, ...) are unaffected; only the deep-copy item types break,
> which is exactly what the test does not exercise.
>=20
> Suggested fix: do not blind-mask the entire fixed struct for items that
> carry an embedded pointer / desc_fn deep copy. Either skip masking when
> rte_flow_desc_item[type].desc_fn !=3D NULL, or mask only the leading plai=
n-
> data region and leave the pointer field (and trailing copied bytes)
> intact.
>=20
> Warning: the new test validates only an ETH pattern, so the
> RAW/FLEX/GENEVE_OPT path above is untested. A RAW item case would have
> surfaced the pointer corruption.
>=20
> Info: the Doxygen block for RTE_FLOW_CONV_OP_PATTERN_MASKED uses @p mask,
> @p spec, @p last, but those are item fields, not parameters of the op; th=
e
> neighboring enum entries only document the @p src / @p dst types.
