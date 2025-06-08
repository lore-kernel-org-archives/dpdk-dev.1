Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F68C5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 21:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D0F4402EE;
	Sun,  8 Jun 2025 23:12:22 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 023B94026B
 for <dev@dpdk.org>; Sun,  8 Jun 2025 23:12:20 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 3605911400DF;
 Sun,  8 Jun 2025 17:12:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 08 Jun 2025 17:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749417140;
 x=1749503540; bh=V7r7iDUT/NY5fQkU8cwRVNi2vce7CgMHYG5i631DY80=; b=
 Jimq5DCPmYeAfclkaiHCtzVDzq2IOlbkGUynJAtGZs02wT9v8W2vFXV0VHxqIm5g
 rkK3zuK3n9Fbu6nX9LYJXAeFFUvUsM7+9cCvECY89rSfCheHiWo+1SOmN2i0+RUF
 f/srwh6psHhjooRpc4KfBRb33MbJN4tarCUQzXkP+X/qS+Ssce/VkOvQE1IhrJBX
 LCLj5buIG+pRff72FXNH97Lw143UnET5AIXlRLvKKoOP+Qzc4mcbDHaKfP09eqBK
 nZrEjNDSJaxIRWA9hDMLua1M6KWcBiylgynsMDc61ruDnSOjrLZYhdMVHmGCXh/6
 C8j+JgDnv+K0CYSKVCZklQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749417140; x=
 1749503540; bh=V7r7iDUT/NY5fQkU8cwRVNi2vce7CgMHYG5i631DY80=; b=I
 2sOmx6520gBaazgkK+tn8QTo2+Gyept0hCErr04TP3r7xsp5XvLuQucPucVOzs/R
 EpRxv73DSIN/QgJNQ27mCaixNUtiaIZ+Qnm6zEamjzpwYXE/p2kdzjnntU/y2+mY
 8baho++aTKyaqC/R+QG7IDBBRJzlf3nN3nFZ+7Gj7Alv3sR7njMSs5tHN5iF55ur
 m6PeBlByisstfLw54gW44IVSzo9cKzXFXZ9Lq82ebG4oD4wmf08yf+l+4Cm8yNqf
 YilGsnJak0FqWv89H6XNdQ1xsfDH5I8otn/SsCgXoBdV+Ke07hdz8W6kvXzJu3N9
 h9u2YK+LWVGN4SZGeE94A==
X-ME-Sender: <xms:s_xFaKOpx8TJJan-v1V8zwC7cudwBQoqE8hvjwy_zMpVX3P0yU50NA>
 <xme:s_xFaI_IpS9Mp-d1Zcfb5MQ1i6lF2lu01iFwRIpn2KKceFfybbzZcEh-LmOd6S48G
 LDjhy6XBs-KIwCXUw>
X-ME-Received: <xmr:s_xFaBQ3-xiuvmcLoqBDLfYgSfDOGE7Qinv5jLrO-HKtxVgZROiAJ5KQ5GAt9aBpquvyuCKoLvcV3HsYMyw2P0MyEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekfeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeek
 ueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutg
 gvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrgh
X-ME-Proxy: <xmx:s_xFaKvXxbmmIxJ8qpUBrIWuP8C-PZ32Znhe1gNrurSoYZgRdMhT_Q>
 <xmx:s_xFaCc66DBJdhI--S9WkKbP3_E3Z78holi7Oa9n0uxT5M9R02Gfxg>
 <xmx:s_xFaO1o-mWkp4DGiyQXZWv_2SHAzgk2tunVMdlyuJXusn6iPhqpWw>
 <xmx:s_xFaG8s_RiJfQDvn4F0OMndgWFTFx2tdF4SA9rnporscchc2zilKg>
 <xmx:tPxFaFvuvkMcOc__4IEBOJV-MFCvPbw_vlaH4AtOx_PCVbDvCrOD0H-x>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 17:12:19 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/3] lcore options cleanup
Date: Sun, 08 Jun 2025 23:12:18 +0200
Message-ID: <5697443.hdfAi7Kttb@thomas>
In-Reply-To: <20250527152913.279011-1-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
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

27/05/2025 17:29, Bruce Richardson:
> This patchset performs some basic cleanup of EAL lcore arguments before
> any more serious work is done on them (as discussed in previous patchset
> revisions).
> 
> * mark the old coremask parameter (-c) and service core mask (-s) as
>   deprecated, so they can be dropped in future. Everything should now be
>   done using core lists where possible.
> * consolidate the, previously separate but similar, "-l" and "--lcores"
>   flags into just short and long versions of the same thing. This does
>   not affect the "--lcores" flag at all, but expands the scope of what
>   was possible with "-l".
> * Add documentation of examples of use of the -l/--lcores parameter
> 
> V5: adjust the examples in patch 3, to only use quotes where necessary
>   and explain in a note why they are sometimes used in the examples.
> 
> Bruce Richardson (3):
>   eal: deprecate old coremask-based EAL parameters
>   eal: merge corelist and core mapping options
>   doc: provide examples of using lcores EAL parameter

This first step looks reasonnable,
but we need more acks for the deprecation.

Applied without the first patch deprecating the famous -c option,
pending for a later stage in this release cycle.

Thanks


