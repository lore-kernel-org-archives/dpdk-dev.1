Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA47DC83F03
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 13:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F45C4042C;
	Thu,  3 Jul 2025 15:28:02 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 3C62A40264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 15:28:01 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 69F6B7A0173;
 Thu,  3 Jul 2025 09:28:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 03 Jul 2025 09:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751549280;
 x=1751635680; bh=3//RWgAxpaRmdW57wgRD1kMYXzzoCFojS/Iq15oFziY=; b=
 eTdVUeUf0dMrEbOm8OPaS4zJbY9dKDCTbZYYkCeItd7WJK5yQ7KsfAN9DFGsEioH
 T3vnwuN013Js3ihKh6niHI2LsFUTg8vl/cqPMEcapITgwALYIDxjTzImLNTMsmpe
 ufHYVUlMdDYg1ugS/fK43i9H8kNDWV7mMbdF/4pbUonWhbMQyACpflC7U4njLg2I
 HLTb7vHwyKgXD5E4qrvE0LXL6w6z5UgSpu5fJ6SqNJ1Acr37IJCKEyj5Aldlw7Vj
 4hpWAmrT/vwzvjo6uX+rH9PRqp2FQm9zURsiPI2B2HZ9N0ooJ5IemQiHT6/RSMGA
 zhL/SyXWYmRJLZVKjSRHLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751549280; x=
 1751635680; bh=3//RWgAxpaRmdW57wgRD1kMYXzzoCFojS/Iq15oFziY=; b=A
 ctNbGSocFYdHGUZqyUurt9vwOW2eLepZYYhFtA4WG266zo0jNjo3z6ieIawrMBWj
 H8N7CNKyQYepvrsvDG9AkQbvka5LzbtcL5nb7D87+up4VsIYfBcC/YnZJCDAl3VP
 IX1Wuam1gOlH56fV1dui8e4ezkmod+bnGmAjPtplfN2earBsUI6GKl5vbbn9DOj7
 dBhX0wHZLyupbc719R8lpQEeglf8yq7dK1BeMSB1jxRKmd3yfNiKfJpNrfy0VXuI
 2OzpwN0XE/cYa5YGDOAfQnPwlboznNgvgwE7hKrar1FjXOOGzfPng4Xfox7dUNok
 eQYM0Vzx0G5HFR+oH4NNA==
X-ME-Sender: <xms:X4VmaJ3kT06jVJ4VSXgIWPCHFVmx7_kFc8iFDvbSl68ByAWpkbMq_w>
 <xme:X4VmaAGBG06MdYPvhi3HCCQi0Rm1NQ3ll1KYHekTue5Yb0bd0IKpch4FdAWpXtNCM
 Hk71hUcpjrwYQs2nw>
X-ME-Received: <xmr:X4VmaJ4r6bmAUWtdsha2WmFKEX0PRuqLF1_FPbyQ9kfufUrO4Ewx4DZaiZ1p_OEuDm5xJuhac77KDPpCk45P8scjaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdegtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:X4VmaG3yAiT5WDcn5R3cK3LE4RsXVEQEtToU22WPSvUp1pnF-btsGw>
 <xmx:X4VmaMHqzjn2kLkxYUZOMKiKxAUdmqmCltXzgdkGrEaoQMMMJM9GoQ>
 <xmx:X4VmaH_21cxONoU6Tu3-AMiE0zWR3024kcb3dBeuqSNcPLQG9oUUnw>
 <xmx:X4VmaJmfQUQv9Y7RuEGmIgcB5hY6K42Gi-3TMg5_ka6vscfaGzcJdw>
 <xmx:YIVmaHzUo9HndUfZ2Le7sKZshwVqYLJU5nhAhkf-QfjvSAPS5CPGjbds>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 09:27:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Thu, 03 Jul 2025 15:27:57 +0200
Message-ID: <9741269.mr9Zh2SJbS@thomas>
In-Reply-To: <IA3PR02MB10771C80F1E35014C06F8C9A9E940A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <4485771.rnzLaay6km@thomas>
 <IA3PR02MB10771C80F1E35014C06F8C9A9E940A@IA3PR02MB10771.namprd02.prod.outlook.com>
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

Please can you compare which libraries are built before/after your patch?


02/07/2025 21:30, Dylan Schneider:
> Hey Thomas,
> I retried a build when libpcap was absent and was able to reproduce the same errors as you did.
> 
> Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> 
> These Errors are coming from ABI check: dpdk/devtools/check-abi.sh:49
> 
> I see in this function that it is checking for the existence of these libraries, which will be absent when libpcap is absent. Is there a way to have the abi-check skip these libraries if they are not built?
> Or better question: How does the abi-check even know about these libraries if they are never built?
> 
> Thanks!
> Dylan
> 
> 
> ________________________________
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Monday, June 30, 2025 8:28 AM
> To: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> Sorry I did not investigate, but there is probably a different installation of the pcap library.
> 
> I have this in a config file:
> 
> pcaparm=$deps/libpcap/build-aarch64/install # requires big changes in DPDK
> #export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$pcaparm/lib/pkgconfig
> 
> I don't remember what are the big changes required, and why it is disabled.
> 
> Checking Meson, libpcap is indeed not found on aarch64:
> 
>         Run-time dependency libpcap found: NO (tried pkgconfig)
>         Library pcap found: NO
> 
> Can you check whether the error can be related to the absence of libpcap?
> 
> 
> 
> 30/06/2025 15:50, Dylan Schneider:
> > Hey Thomas, just wanted to confirm,  I see the ARM build passing in CI. Is there a reason it would pass there but not on your dev machine?
> >
> >
> > ________________________________
> > From: Dylan Schneider <schneide@qti.qualcomm.com>
> > Sent: Friday, June 27, 2025 11:46 AM
> > To: Thomas Monjalon <thomas@monjalon.net>
> > Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> > Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> >
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> >
> > Hey Thomas,
> > Thanks for the reply.
> > Can you tell me the build command you're using to produce those errors? I have ran the builds on my test machine and cannot reproduce these. Thanks!
> > Dylan
> > ________________________________
> > From: Thomas Monjalon <thomas@monjalon.net>
> > Sent: Friday, June 27, 2025 11:39 AM
> > To: Dylan Schneider <schneide@qti.qualcomm.com>
> > Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> > Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface block
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> >
> > 09/06/2025 23:19, Schneide:
> > > From: Dylan Schneider <schneide@qti.qualcomm.com>
> > >
> > > Allow the user to specify protocol link type when creating pcapng files.
> > > This change is needed to specify the protocol type in the pcapng file,
> > > DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> > > for other protocols to be used on files generated by pcapng.
> > >
> > > Includes a breaking change to rte_pcapng_add_interface to add link_type
> > > parameter. Existing calls to the function have been updated to pass
> > > DLT_EN10MB for the link type argument.
> > >
> > > Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> > > Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> > > Cc: stephen@networkplumber.org
> >
> > I doesn't pass compilation test on my machine:
> >
> > Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> > Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
> >
> >
> >
> >
> 
> 
> 
> 
> 
> 





