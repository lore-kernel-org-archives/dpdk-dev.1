Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CA5CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A006B40661;
	Wed, 24 Sep 2025 16:54:33 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 6D6804065E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:54:32 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B1F437A01DF;
 Wed, 24 Sep 2025 10:54:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Wed, 24 Sep 2025 10:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1758725671;
 x=1758812071; bh=sZL74wvuPJQ8zI8LOr15LrVHZlVLfpzhbFiiyLCW0PY=; b=
 jdx4Q5G3ZccTw1AipZLr3cDLukakOpFRYrIMLEPp4v+SVteHvfryuIo8Th/LUrUi
 P55VtEiKJA4wz+kN+HlQ+rCA8x1tqgj7YuQHGSKaJjMAryyir1QWzeywbIUQDfFN
 oxiZa3D/6M8mS/fJ0kNTnGltZWMQ/xiPXSGPTPRVmNUJ3BMBdh09iaRmOCYXs8hx
 44seWUJN4gdZ2EC2cVE6VpVzKWvE+fqECIha5IkR5ApVngMYN/5/sU5MNVk4kg8u
 yEZk4GpqW04Wg+LKlXxyOMGsE5d/2o6fdpBNxT/AcpEb+ntJK3TxPVGWakYtdzvg
 010ZBEvMTkiURn73r/t8Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758725671; x=
 1758812071; bh=sZL74wvuPJQ8zI8LOr15LrVHZlVLfpzhbFiiyLCW0PY=; b=f
 sV7tM4jboO3+j1ZzgmI2LgvjNb40o2mrW0/3y4DKMctEX/4CKmzan09q2s0bQF7i
 Xr0Ms4KWAi0i+6wCozLvZyBBeUcQ9UnaWhf/zsAX195EciQyRPtdzyfE8F3H4oMr
 cEUxGy+p+hq61C004fj5InwLZQL7NdJSRqmXqygfwTPd93x/UmfUea5L11Ym8hds
 Qt1KNpSICLrVWEGjN11EJgCyS/68NgCwoDjoAl+lpv46KVpHnoiHgIyOU468ObVQ
 41QA6NOtPTF7us7P++krxZIn4XUa/PXrde6jAY2ZySKueE9W1ylZYGaP+P4NuaH9
 3A9X9HD8X3CeVvAjwzyEw==
X-ME-Sender: <xms:JwbUaE-nvU8pUEhjHnPulrIRNcahbmymwGVtbmuTr1fKaOLqNvXyKQ>
 <xme:JwbUaONghpxOjaJv-vsnQYidDiTSGtXm1DxcnXRZ-ThvHIjPYwrjr9vAKFR_sMc5V
 x-6aYJmpPhq7S9PlbaQetbmtruv5FUPEjKf0FPP_ShpLaG_uu9sIQ>
X-ME-Received: <xmr:JwbUaKHvnMDfXnLA5GCn4J3VpHjvlc2HgTu0Lm1zD6RiETIrKdoyF6mq6xvQRAcuZ0UDfpY5YOyXttPytcf7-M5XsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepughrtgeslhhinhhugidrihgsmhdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehskhhorhhisehm
 rghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmih
 gtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgt
 ohhm
X-ME-Proxy: <xmx:JwbUaEQHhYzDkAD4SwW7I47QQbzbl4q4jLB6RY7vcO1HWkGr3kOcSg>
 <xmx:JwbUaPt3FFqRydFcGE4Jk-0ach7SsAWL5OOnfChPtWwY71E6v2Za5A>
 <xmx:JwbUaELZV_vxWQsVB-TfaW37CVzALLa2Q--XS5xneLiGJcLXewcB4Q>
 <xmx:JwbUaMknNL8Wd-sEZbDM-OWJtXpHUFFrFU6Kzm81W_xnNArPmxiROw>
 <xmx:JwbUaDQ2jGvt36humI9PXH5Rxs_Vo75V06mlgyM2YBDrYWlwKeHwgJtE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 10:54:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Christensen <drc@linux.ibm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] [PATCH] trace: force 8 byte alignment when --no-huge
 is used
Date: Wed, 24 Sep 2025 16:54:29 +0200
Message-ID: <16437299.JCcGWNJJiE@thomas>
In-Reply-To: <BY3PR18MB47852312E4B66F4EC22851DCC85EA@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250724000554.114087-1-drc@linux.ibm.com>
 <BY3PR18MB47852312E4B66F4EC22851DCC85EA@BY3PR18MB4785.namprd18.prod.outlook.com>
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

24/07/2025 13:05, Jerin Jacob:
> From: David Christensen <drc@linux.ibm.com>
> > 
> > Current code in eal_trace_init() specifies 8 byte alignment for CTF generation,
> > but fallback code in __rte_trace_mem_per_thread() does not enforce similar
> > requirements when calling malloc(). Modify fallback heap requests to use
> > posix_memalign()
> > Current code in eal_trace_init() specifies 8 byte alignment for CTF generation,
> > but fallback code in __rte_trace_mem_per_thread() does not enforce similar
> > requirements when calling malloc(). Modify fallback heap requests to use
> > posix_memalign() with proper alignment.
> > 
> > Signed-off-by: David Christensen <drc@linux.ibm.com>
> 
> 
> Acked-by: Jerin Jacob <jerinj@marvell.com>
> 
> > Bugzilla-ID: 1715

Applied, thanks.

Note: seems unrelated to --no-huge, so dropped from the title.



