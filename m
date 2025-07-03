Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12BC77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 16:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B623940267;
	Thu,  3 Jul 2025 18:41:47 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 1F12940264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 18:41:46 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 5547C1D00047;
 Thu,  3 Jul 2025 12:41:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 03 Jul 2025 12:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751560905;
 x=1751647305; bh=hv5m6NNIEb+pwsXLazQ7wEUG8xPqY2YQJizEvBOC85k=; b=
 m+3Pb+Al1E8To2BpC9ibwRWlrKpIMVPfdIioX6C86F60ZCvkXehU+cNiQBMbS6Y+
 kKDWBsUjeYrbg3SeGl6Nbhvn67XQG2UIGIJVrtjZHHaMQZVndykliOVfVzUBtQV4
 3/OqO8Ifcbi+pH/JQP2cfuGzWCxLtLWsXd480e5QKbd9a0D/iR5KgcnJcpzkeoKX
 NdBBfAsVUcG0dL5ZcV+o5BwBKohSr9z19gS1rNeR9ShKdjCaT+2fXJ6Px9aRsCWz
 zU/9DUZUJ6paMqtsK/z81buIzJEqAnJ2nWgehbzbT295wOaCmRzRDkeclqlZwonL
 0KEeimkQU8v72hZ2zOyf3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751560905; x=
 1751647305; bh=hv5m6NNIEb+pwsXLazQ7wEUG8xPqY2YQJizEvBOC85k=; b=b
 Jc/abDoNSU38odWKjgrO/uebJyvDyO9DGjQMu4t8EfrwVjQ8mrhWvE3wV8tYGPVs
 n40FyofztGpNDHmC4FcfOaPjSW3X96NpEq9JdmIEMjYkOl75zsByXbbYvXbNDAH2
 m5r5Gpw9uV6LjouQh29WVq2UbdEvyR16ibyN313/9Ju4kl2HOPkJPPl6sYhCNIqF
 MX9pVxPWkiK0QbPtMB1v/29mavvR9qJilwZbfu7iuBMjVW5mHPXx4/Kex0cmV+Wd
 ZE94I+ORw0hK7Cp66YsS0dkgbVoKmEAhZ0jIVlZasyG72V7dVfwLal6YUeRhfhiv
 G+Sk6reUXCv9lCyVJqlvw==
X-ME-Sender: <xms:yLJmaB9PLdPhgUPzbO_0dmmYEn8EKSQdxxG8aSue1qdi3wAeNSrMSw>
 <xme:yLJmaFum6rnHCTkElzpsRr3m6zvsCqmjEf78MMLL8yl10kwgwd41OKKcMTuaRmR8w
 CUN-uPrQcxbUI0R_A>
X-ME-Received: <xmr:yLJmaPDuojfTbEd_WZt-rT9HWeAluXV7Zxhx3TXSB-rnpCEBQhUJgEHv4o2gxE2AJqXMirXirDO7ED-c5cGehGwxzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdejkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshgthhhnvghiuggvsehqthhirdhquhgrlh
 gtohhmmhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehrvghshhhmrgdrphgrthhtrghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepjhgvrhhi
 nhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhesmh
 grrhhvvghllhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvhgv
 lhhlrdgtohhmpdhrtghpthhtohephigrnhiihhhirhhunhgpudeifeesudeifedrtghomh
X-ME-Proxy: <xmx:yLJmaFfILr3_QGT-wmRUv5AM2ymg22VLiusSXlzQai8JNFyDcU24Kg>
 <xmx:yLJmaGM7YfORahpBJjz-uOENToOw4UCPtwjrND7IDVuuXsZFN1oH6A>
 <xmx:yLJmaHnX6xWsro0SAORZJuoBdRf5fLRGBSG8jN7GUbuhJZhpHaEsQw>
 <xmx:yLJmaAsGKz3EhvAKjOTDpXY-wKH6SACmsG7SLfAJyHyH79NbDEjHSA>
 <xmx:ybJmaBbfKBdDyRQBFq2HognDLNKofDOPpynEm8FNe5p4eaxzv5WX8qC_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 12:41:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Thu, 03 Jul 2025 18:41:41 +0200
Message-ID: <4636913.d4nMDBE73Y@thomas>
In-Reply-To: <IA3PR02MB107716434B37F31DC2949B587E943A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <9741269.mr9Zh2SJbS@thomas>
 <IA3PR02MB107716434B37F31DC2949B587E943A@IA3PR02MB10771.namprd02.prod.outlook.com>
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

03/07/2025 18:29, Dylan Schneider:
> I did a clean build on system where libpcap was NOT installed.
> 
> My changes make rte_pcapng lib depend on libpcap (this is for libpcaps DLT_USER Macros).
> So now, in turn, everything that depends on rte_pcapng also depends on libpcap. Dumpcap, rte_graph and rte_pdump all depend on rte_pcapng, so I think we may need to add the libpcap dependency to all of these? We would then need to add the libpcap dependency to any libraries that depend on these, which seems like a slippery slope.  Maybe that's not the best approach though. Can you say whether it is okay to add libpcap dependency to all of these libraries? Or maybe there's a better way to enforce the dependency for DPDK build? Or is it altogether incorrect to have rte_pcapng depend on libpcap in the first place?

The best is to have only rte_pcapng to depend on libpcap, as you did.

If the problem is only in ABI check, this is what we need to fix.
I'm not sure how to fix this.



> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Thursday, July 3, 2025 7:27 AM
> To: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> Please can you compare which libraries are built before/after your patch?
> 
> 
> 02/07/2025 21:30, Dylan Schneider:
> > Hey Thomas,
> > I retried a build when libpcap was absent and was able to reproduce the same errors as you did.
> >
> > Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> >
> > These Errors are coming from ABI check: dpdk/devtools/check-abi.sh:49
> >
> > I see in this function that it is checking for the existence of these libraries, which will be absent when libpcap is absent. Is there a way to have the abi-check skip these libraries if they are not built?
> > Or better question: How does the abi-check even know about these libraries if they are never built?
> >
> > Thanks!
> > Dylan
> >
> >
> > ________________________________
> > From: Thomas Monjalon <thomas@monjalon.net>
> > Sent: Monday, June 30, 2025 8:28 AM
> > To: Dylan Schneider <schneide@qti.qualcomm.com>
> > Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> > Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> >
> > Sorry I did not investigate, but there is probably a different installation of the pcap library.
> >
> > I have this in a config file:
> >
> > pcaparm=$deps/libpcap/build-aarch64/install # requires big changes in DPDK
> > #export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$pcaparm/lib/pkgconfig
> >
> > I don't remember what are the big changes required, and why it is disabled.
> >
> > Checking Meson, libpcap is indeed not found on aarch64:
> >
> >         Run-time dependency libpcap found: NO (tried pkgconfig)
> >         Library pcap found: NO
> >
> > Can you check whether the error can be related to the absence of libpcap?
> >
> >
> >
> > 30/06/2025 15:50, Dylan Schneider:
> > > Hey Thomas, just wanted to confirm,  I see the ARM build passing in CI. Is there a reason it would pass there but not on your dev machine?
> > >
> > >
> > > ________________________________
> > > From: Dylan Schneider <schneide@qti.qualcomm.com>
> > > Sent: Friday, June 27, 2025 11:46 AM
> > > To: Thomas Monjalon <thomas@monjalon.net>
> > > Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> > > Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> > >
> > >
> > > WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> > >
> > > Hey Thomas,
> > > Thanks for the reply.
> > > Can you tell me the build command you're using to produce those errors? I have ran the builds on my test machine and cannot reproduce these. Thanks!
> > > Dylan
> > > ________________________________
> > > From: Thomas Monjalon <thomas@monjalon.net>
> > > Sent: Friday, June 27, 2025 11:39 AM
> > > To: Dylan Schneider <schneide@qti.qualcomm.com>
> > > Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> > > Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> > >
> > > WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> > >
> > > 09/06/2025 23:19, Schneide:
> > > > From: Dylan Schneider <schneide@qti.qualcomm.com>
> > > >
> > > > Allow the user to specify protocol link type when creating pcapng files.
> > > > This change is needed to specify the protocol type in the pcapng file,
> > > > DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> > > > for other protocols to be used on files generated by pcapng.
> > > >
> > > > Includes a breaking change to rte_pcapng_add_interface to add link_type
> > > > parameter. Existing calls to the function have been updated to pass
> > > > DLT_EN10MB for the link type argument.
> > > >
> > > > Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> > > > Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> > > > Cc: stephen@networkplumber.org
> > >
> > > I doesn't pass compilation test on my machine:
> > >
> > > Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > > Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > > Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > > Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-gcc/install





