Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B7ED2F7C3
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 08:55:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04F824027D;
	Fri,  5 Dec 2025 09:55:38 +0100 (CET)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE3E40156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 09:55:36 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1928314001E6;
 Fri,  5 Dec 2025 03:55:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 03:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764924936;
 x=1765011336; bh=Kj/8YSDYScvu2OWXBUpvVzfI3/RXfgB218xD6XhQ8r8=; b=
 IAx5zq4pXTT9JdSOzMQ6zGDyBFI26+cJzERnSkpSrxlhjl1JSMzotXOdha9SsCP5
 4dKnyk3AIm6DqT1fI+ATnCmg4fMWY2JxP7fUTHcmLVWW0D8sDbwN1vLi1IViCwXG
 B0ImHN5jNpEtDdnXoHM15wimg7y294zeDKFMgEyOn9J4VxCn0DWGDpuvb1MV+38q
 l8w4J1bF8sq31LxXuWtVU8rmGPAPglJu+yKWqdM3pi9RtGQDP9ilooYIxZ0LR1mo
 WVkeHWdrw2Jv2l6LvsUxDPAnubCdgEiJ+KxCSzuF5C+dbHKY1YTTwFn/7tOXDwXn
 99ze036WCls5t832VcumQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764924936; x=
 1765011336; bh=Kj/8YSDYScvu2OWXBUpvVzfI3/RXfgB218xD6XhQ8r8=; b=o
 v9jJBknBnc9S5kVW770UvN1v5F3/vCUkZ/iz2Kbi9H6uzosmi30BDDa1X/Ey096A
 wAWxUPHXtUr7vDb74YAgVOinIPhEgs3o47I1xYXMgs6rwYstqYrecWAPIl4xA3cz
 xuOBCaAZfdTPvuGWeXePE/JvdXHtoBCJqrHpAdmdlN9Ju+gZJhvVySpCAYUh8m+7
 Yca3lwoHEpAPcvU7v4b0P5zbACRBtPsouh8BsYdj4JxaZEQLLVi0b/aeYqeTrr4i
 Hn+pTdg7fqAhGSEHYZQ9vKbK74gQ5RSL7VveAbhXFcorXt9QrwgBzZB3RXv6FmOo
 NfVsexlCDtDjGpzJ1LsRg==
X-ME-Sender: <xms:B54yaZPSf5XXShRdgg7kT7vQWRTsvHjrYcfkvQdh2qDrx7IrOuNINg>
 <xme:B54yaU4UHRycCrTrcRmSk4Cvo_LLqN5U31Z3Fulp9KHC5TkZ5xbBU-gr7gEeYuF0e
 iFPuRYCTdBEKUg_VK909umvk4Rkj88Va_2T5l0RH9gJA2ZFHhLprw>
X-ME-Received: <xmr:B54yaT0BwcpK1CWra-HAonnXTC6IFYp5SG3TlKEIBu_Jy3d_eXwDDOqD2KhxoJmy6RnvTyguuAcKQMKbZMZl9uRDBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejleehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprh
 gtphhtthhopegvrghgohhsthhinhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehg
 vghtvghlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrd
 horhhgpdhrtghpthhtohepmhhkrghshhgrnhhisehnvhhiughirgdrtghomhdprhgtphht
 thhopehrrghslhgrnhgusehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:B54yaVyW97zhmBeVinkBx1zO1JskbQmJmnzgkb9nFZzqKJ1mtVFlQw>
 <xmx:B54yadsHFZTHJVYuTBnCvSIrqNfIkeJon7Vy2UVIHrpOLOcBKEJkEg>
 <xmx:B54yafyJ1P0vzvi_biBpmDgU8tny3fv7qp9x3Ii9tVRnQfrx2VdL3A>
 <xmx:B54yaYD3PCqgg4Hz2UdRqUnRNh6zYr5quEVb-Y_PN7MqIVTYqWATgA>
 <xmx:CJ4yaVlBm_d7foCNmdBxhKqkFZijbtKoPXg1lhAAeZ0Ny4SzHeCwOCP->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 03:55:34 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>, Elena Agostini <eagostini@nvidia.com>,
 Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, mkashani@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH 9/9] gpu/cuda: support CUDA 13 building
Date: Fri, 05 Dec 2025 09:55:33 +0100
Message-ID: <13930065.uLZWGnKmhe@thomas>
In-Reply-To: <4771590.kQq0lBPeGt@thomas>
References: <20250915144137.54858-1-getelson@nvidia.com>
 <20250915144137.54858-9-getelson@nvidia.com> <4771590.kQq0lBPeGt@thomas>
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

17/09/2025 12:06, Thomas Monjalon:
> 15/09/2025 16:41, Gregory Etelson:
> > From: Bing Zhao <bingz@nvidia.com>
> > 
> > The API name and prototype have been changed in the new CUDA, this
> > commit will ensure the compatibility with different versions.
> [...]
> >  /* CUDA Driver functions loaded with cuGetProcAddress for versioning */
> > +#if defined(CUDA_VERSION) && (CUDA_VERSION >= 13000)
> > +static PFN_cuGetErrorString_v6000 pfn_cuGetErrorString;
> > +static PFN_cuGetErrorName_v6000 pfn_cuGetErrorName;
> > +static PFN_cuPointerSetAttribute_v6000 pfn_cuPointerSetAttribute;
> > +static PFN_cuDeviceGetAttribute_v2000 pfn_cuDeviceGetAttribute;
> > +static PFN_cuDeviceGetByPCIBusId_v4010 pfn_cuDeviceGetByPCIBusId;
> > +static PFN_cuDevicePrimaryCtxRetain_v7000 pfn_cuDevicePrimaryCtxRetain;
> > +static PFN_cuDevicePrimaryCtxRelease_v11000 pfn_cuDevicePrimaryCtxRelease;
> > +static PFN_cuDeviceTotalMem_v3020 pfn_cuDeviceTotalMem;
> > +static PFN_cuDeviceGetName_v2000 pfn_cuDeviceGetName;
> > +static PFN_cuCtxGetApiVersion_v3020 pfn_cuCtxGetApiVersion;
> > +static PFN_cuCtxSetCurrent_v4000 pfn_cuCtxSetCurrent;
> > +static PFN_cuCtxGetCurrent_v4000 pfn_cuCtxGetCurrent;
> > +static PFN_cuCtxGetDevice_v2000 pfn_cuCtxGetDevice;
> > +static PFN_cuCtxGetExecAffinity_v11040 pfn_cuCtxGetExecAffinity;
> > +static PFN_cuMemAlloc_v3020 pfn_cuMemAlloc;
> > +static PFN_cuMemFree_v3020 pfn_cuMemFree;
> > +static PFN_cuMemHostRegister_v6050 pfn_cuMemHostRegister;
> > +static PFN_cuMemHostUnregister_v4000 pfn_cuMemHostUnregister;
> > +static PFN_cuMemHostGetDevicePointer_v3020 pfn_cuMemHostGetDevicePointer;
> > +static PFN_cuFlushGPUDirectRDMAWrites_v11030 pfn_cuFlushGPUDirectRDMAWrites;
> > +#else
> >  static PFN_cuGetErrorString pfn_cuGetErrorString;
> >  static PFN_cuGetErrorName pfn_cuGetErrorName;
> 
> What is the logic here?
> The old version keeps its original name, and new versions have a suffix?
> Why not use the old version?
> What will happen with next versions?

Looks like we cannot do better than this versioning
when using cuGetProcAddress to avoid linking CUDA.

Applied


