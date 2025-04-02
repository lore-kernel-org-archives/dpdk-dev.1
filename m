Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F7FC28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 11:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2498D40273;
	Wed,  2 Apr 2025 13:53:29 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 3DFF740261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 13:53:28 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id 5099E1140175;
 Wed,  2 Apr 2025 07:53:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 02 Apr 2025 07:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743594807;
 x=1743681207; bh=7bv8G+Bf/IYOv8I3LnWbOr9YVivrPvM762PZAwSp5jQ=; b=
 FghmHvMcsQUwAUg1Klr22IVjdRqf4XqE84J7kFPM6PjI1g2s32JdhOaVDH6ZrIZs
 MVVVM2kp5ikjQ9ejw181empKzQP/4u2HAiJ4yfRypW89xz8HKSlQRVsQGaHKU/Ad
 CrqWwb3Z4tLcH9MrrdkdZ//QI0CBlFu7S7GkpUOcQ0/Ty3Z0miEjypI1MVSi+9/C
 cVBWu8HeEP1mHLFeg9zF+uOyMBnK9sSjxHDvDZwfN8rjuOzVJaEhnX2seoRPD2FM
 XSx4a/FsusEuLXcKeXvSyjOmI3QffmP/ypM5zWjjHCxEwSDTXw2/2IoheRAKAUhz
 oG2Cn7nTwBOVZPuQY7G+IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743594807; x=
 1743681207; bh=7bv8G+Bf/IYOv8I3LnWbOr9YVivrPvM762PZAwSp5jQ=; b=h
 nyTwRR7UAlYaymyKy/ecYk+4cTVTOmOgTKlxY68JilhoBDTYutnYJhQM6qgHtySO
 ycX2VpgIQIM+OBciO9rRZ5asCpVOgKlMQfaF3y8dt/HOnohnG/4OlpR+/Vd46b/H
 8v1Jl5x2s/FdGdbL1CGYXwfdPVnNlBhiLIhvGPbKwiFAfxxVBO5IuSDoVl2oJpLD
 cDMgkQGJQUuPbm4Y8YpvjGAMvdmOHS4JfLkSNcpsa2w/MqYCDcDYqApmAktS551Z
 PwbvtGwO3p5uFeffisIv2kPmvZmK6MRgCSeBpZuuapRB+qEq8WefK1QnB5bewuRu
 s4b3KrfQA6+NnrSutMbfw==
X-ME-Sender: <xms:NiXtZ6nUgYKt4mvx73RvE77L8OgA6qf_q9HfSJPEEUCbcnDO6MJlqw>
 <xme:NiXtZx1-GRhyf7UatdQWBG15TlPiJaOIigGVoYjkzhFFiY2wykIG2Cf2tYk4A7s9z
 kQtMGPzvzQtW7zWsA>
X-ME-Received: <xmr:NiXtZ4oYRYpxz-fu9NTXJOH8ln7wKl-S9aHa1n67DpRZxKCBT5FupP9Hru8G3Fse8rhd9IZ4_QyXXt2S0FVxryxlqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehieduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhho
 shhofhhtrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhmpdhrtghpthhtohepjhgrshhvihhnuggvrhdrshhinhhghhesihhn
 thgvlhdrtghomh
X-ME-Proxy: <xmx:NiXtZ-nakoPZyrXKrLgyId937xfe8vz3BKJPSY3whF8NZiP0wOqJqg>
 <xmx:NiXtZ41PRA_RMUCyv0BqIaFmtYBZc8yGiESorIMNpcpN-g3epaFSQw>
 <xmx:NiXtZ1spcfwH_s2zI3nVA-dKFUYiqgsA6vSnuSWK2Ql_TpKnDW8qCw>
 <xmx:NiXtZ0Xv16M7tY62l1K6YKhVRfPMlNURI02VgrNNH4Nn9VWFGbqJCA>
 <xmx:NyXtZ-9TyN3I_7j4A-P8FVfVeyp7OcunF50NrLrm1MSCnpIApX_hRVBF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:53:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Subject: Re: [PATCH v6 8/8] eal: rework function versioning macros
Date: Wed, 02 Apr 2025 13:53:23 +0200
Message-ID: <5048875.4XsnlVU6TS@thomas>
In-Reply-To: <20250328105250.3082414-9-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-9-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

28/03/2025 11:52, David Marchand:
> --- a/lib/eal/common/eal_symbol_exports.h
> +++ b/lib/eal/common/eal_symbol_exports.h
> @@ -5,6 +5,8 @@
>  #ifndef EAL_SYMBOL_EXPORTS_H
>  #define EAL_SYMBOL_EXPORTS_H
>  
> +#include <rte_common.h>
> +
>  /* Internal macros for exporting symbols, used by the build system.
>   * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
>   * version this symbol was introduced in.
> @@ -13,4 +15,68 @@
>  #define RTE_EXPORT_INTERNAL_SYMBOL(a)
>  #define RTE_EXPORT_SYMBOL(a)
>  
> +#if !defined(RTE_USE_FUNCTION_VERSIONING) && (defined(RTE_CC_GCC) || defined(RTE_CC_CLANG))
> +#define VERSIONING_WARN RTE_PRAGMA_WARNING(Use of function versioning disabled. \
> +       Is "use_function_versioning=true" in meson.build?)
> +#else
> +#define VERSIONING_WARN
> +#endif

Why no warning for other compilers?
Why not warn at Meson level?

> +
> +/*
> + * Provides backwards compatibility when updating exported functions.

I feel a word is missing. What "provides" it?

> + * When a symbol is exported from a library to provide an API, it also provides a
> + * calling convention (ABI) that is embodied in its name, return type,
> + * arguments, etc.  On occasion that function may need to change to accommodate
> + * new functionality, behavior, etc.  When that occurs, it is desirable to
> + * allow for backwards compatibility for a time with older binaries that are
> + * dynamically linked to the dpdk.
> + */
> +
> +#ifdef RTE_BUILD_SHARED_LIB
> +
> +/*

Why not Doxygen style?

> + * RTE_VERSION_SYMBOL

No need to repeat the macro name here.

> + * Creates a symbol version table entry binding symbol <name>@DPDK_<ver> to the internal

Imperative form is more usual.

> + * function name <name>_v<ver>.
> + */
> +#define RTE_VERSION_SYMBOL(ver, type, name, args) VERSIONING_WARN \
> +__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@DPDK_" RTE_STR(ver)); \
> +__rte_used type name ## _v ## ver args; \
> +type name ## _v ## ver args

This is only GNU style. It should be highlighted both in this file and the commit log.

> +
> +/*
> + * RTE_VERSION_EXPERIMENTAL_SYMBOL
> + * Similar to RTE_VERSION_SYMBOL but for experimental API symbols.
> + * This is mainly used for keeping compatibility for symbols that get promoted to stable ABI.
> + */
> +#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) VERSIONING_WARN \
> +__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL") \
> +__rte_used type name ## _exp args; \
> +type name ## _exp args
> +
> +/*
> + * RTE_DEFAULT_SYMBOL
> + * Creates a symbol version entry instructing the linker to bind references to
> + * symbol <name> to the internal symbol <name>_v<ver>.
> + */
> +#define RTE_DEFAULT_SYMBOL(ver, type, name, args) VERSIONING_WARN \
> +__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) "@@DPDK_" RTE_STR(ver)); \
> +__rte_used type name ## _v ## ver args; \
> +type name ## _v ## ver args

Only 3 macros, that's simple and clean, thank you.


