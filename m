Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BECAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 10:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6DDC4025A;
	Wed, 17 Sep 2025 12:06:12 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 67F7140144
 for <dev@dpdk.org>; Wed, 17 Sep 2025 12:06:11 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 1FC66EC02AB;
 Wed, 17 Sep 2025 06:06:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 06:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758103571;
 x=1758189971; bh=jXuQLazk6o1Otg4O1wCVxQB5567VdvAah2tEOvsqXH0=; b=
 rlmA56TxZpnk2XpY7H6p02VBxGxOJK+wdUl6d0PcEnH6smTF+S4rpXRWTHoZCI65
 deWOwLM8X6fq8/Abj1B9J5mPywBseWVBTeACsaXxNSXNysXe8qZQwnq8lXAZYNcI
 N/bS+dpNXJed+08PAALbsqpYR4/H3k4uyb9UAKXiaw10RRph38vowNP2/Xv4QF7R
 XJVhfhA3pl2j72ebRgEA1r/fg1dQmjxpaXRhBEuiPy0eHlm1JMD/TKlhm6ZqUBtE
 2PqNQA6WSRcfgsKOd4ehQwbnfmY6EsC3TuJq4PIlYNLltdoEWZqGJR3OMiFtIzQA
 u6ogG4NUaUV/k3mtekA6Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758103571; x=
 1758189971; bh=jXuQLazk6o1Otg4O1wCVxQB5567VdvAah2tEOvsqXH0=; b=e
 ITo3Uxvp/qRjQagXMUU0rFhQQHul4LmQRTSgDb5er29aAZ5C70q9n1UrRlBS6qur
 6/4C57FOwG4oQN+CnuXa2stHAYEMrrye1oqdIjOKBervmJETkCQNYwc89eoKaDeS
 xqIx7/iz2unMy+N37GnmcopO/b/NpiNWPoxFGRcWLMHJDc04P2r7D1UV5A9feKm/
 oxpSMocJZ/wG2m/tQ7DwP0cE8Zux7L4mbudZNfBu/F+bK9cygePyCgxdIEgJYinj
 xd57aIlhjBnjByUzQS6wKw04zf27g3OFMLNuCRyypeex3KqhUtOEl8F5gR8xmrpn
 m/8Bk89hXj1dmU/eSs4GA==
X-ME-Sender: <xms:EojKaAcCGHXtdH6lENP_UWFYIG8EQZTsgIbOwFEtZHm8YT-ivHDZKg>
 <xme:EojKaAJvuLMoaXbZcwAp0965CJnrOfG21qVu5b8zmO6Va490K7vG3EmKv7Wea3QMO
 NnjDlmuEeJsne5N2g>
X-ME-Received: <xmr:EojKaD1RjELLf3tUTDJvLyx3O-D54EQDD02_Lnk_URAo30hlP5eCiQxyJCPWczV873J1cGnWJHsaaf3nCtOW7mNcWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfedujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpd
 hrtghpthhtohepvggrghhoshhtihhnihesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
 ghgvthgvlhhsohhnsehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukh
 drohhrghdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihguihgrrdgtohhmpdhrtghp
 thhtoheprhgrshhlrghnugesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:EojKaKi_unm_fT-qTiYXA8DcTOK_BFQCsZ9rvYX648c7-jRJiPjZHw>
 <xmx:EojKaEX6gd_dsrPTV_HJXkwlXWrBulK7D9XQByCxBaKpsMOVwosefA>
 <xmx:EojKaJVcQ-VRWodiqyUPNemUh7BAG6HAbdk0IqoFV43PyFVt-bfMwg>
 <xmx:EojKaEhoaEFxXxUe1EB5sG-Y8ogmD_6thIELIXDEem5q9EsSNiHHHw>
 <xmx:E4jKaMkXmJcMBg7GexfY7s4INfcaP6Nmliykkp2Q47jg6o4c-lqKrP8B>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 06:06:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>, Elena Agostini <eagostini@nvidia.com>,
 Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH 9/9] gpu/cuda: support CUDA 13 building
Date: Wed, 17 Sep 2025 12:06:08 +0200
Message-ID: <4771590.kQq0lBPeGt@thomas>
In-Reply-To: <20250915144137.54858-9-getelson@nvidia.com>
References: <20250915144137.54858-1-getelson@nvidia.com>
 <20250915144137.54858-9-getelson@nvidia.com>
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

15/09/2025 16:41, Gregory Etelson:
> From: Bing Zhao <bingz@nvidia.com>
> 
> The API name and prototype have been changed in the new CUDA, this
> commit will ensure the compatibility with different versions.
[...]
>  /* CUDA Driver functions loaded with cuGetProcAddress for versioning */
> +#if defined(CUDA_VERSION) && (CUDA_VERSION >= 13000)
> +static PFN_cuGetErrorString_v6000 pfn_cuGetErrorString;
> +static PFN_cuGetErrorName_v6000 pfn_cuGetErrorName;
> +static PFN_cuPointerSetAttribute_v6000 pfn_cuPointerSetAttribute;
> +static PFN_cuDeviceGetAttribute_v2000 pfn_cuDeviceGetAttribute;
> +static PFN_cuDeviceGetByPCIBusId_v4010 pfn_cuDeviceGetByPCIBusId;
> +static PFN_cuDevicePrimaryCtxRetain_v7000 pfn_cuDevicePrimaryCtxRetain;
> +static PFN_cuDevicePrimaryCtxRelease_v11000 pfn_cuDevicePrimaryCtxRelease;
> +static PFN_cuDeviceTotalMem_v3020 pfn_cuDeviceTotalMem;
> +static PFN_cuDeviceGetName_v2000 pfn_cuDeviceGetName;
> +static PFN_cuCtxGetApiVersion_v3020 pfn_cuCtxGetApiVersion;
> +static PFN_cuCtxSetCurrent_v4000 pfn_cuCtxSetCurrent;
> +static PFN_cuCtxGetCurrent_v4000 pfn_cuCtxGetCurrent;
> +static PFN_cuCtxGetDevice_v2000 pfn_cuCtxGetDevice;
> +static PFN_cuCtxGetExecAffinity_v11040 pfn_cuCtxGetExecAffinity;
> +static PFN_cuMemAlloc_v3020 pfn_cuMemAlloc;
> +static PFN_cuMemFree_v3020 pfn_cuMemFree;
> +static PFN_cuMemHostRegister_v6050 pfn_cuMemHostRegister;
> +static PFN_cuMemHostUnregister_v4000 pfn_cuMemHostUnregister;
> +static PFN_cuMemHostGetDevicePointer_v3020 pfn_cuMemHostGetDevicePointer;
> +static PFN_cuFlushGPUDirectRDMAWrites_v11030 pfn_cuFlushGPUDirectRDMAWrites;
> +#else
>  static PFN_cuGetErrorString pfn_cuGetErrorString;
>  static PFN_cuGetErrorName pfn_cuGetErrorName;

What is the logic here?
The old version keeps its original name, and new versions have a suffix?
Why not use the old version?
What will happen with next versions?



