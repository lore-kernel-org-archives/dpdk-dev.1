Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDC5C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 16:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E08A940275;
	Tue,  1 Apr 2025 18:11:37 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id B907140269
 for <dev@dpdk.org>; Tue,  1 Apr 2025 18:11:36 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 3416F1383968;
 Tue,  1 Apr 2025 12:11:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743523896;
 x=1743610296; bh=jti1wQsXf5mU7m4P3Tqkdd6YFLOpcCohn+5N7kPpAbw=; b=
 d9Kl9P6DTpWE6ln1c+JeoAjt2y76IMOVgTx5fIUQZuqPHAVf/1tOxoigz7xLtt/k
 W7+N39wiz+OW0f6+iRmq1OumAFimoJNiI/9uBRF/1jMGUla+ibn0M8jZzP6Y1wYJ
 F4KkrZULWXX6X3MstmPrUUP+8H8rldmIBLcknOliVFmO3ujANPZDNf0LSzmWTXV0
 rpLECA0gC+c0LEhcjOoUrZ2Teop5JydUYqyJK+M7P3W43dwuqDd8j5+izEsRSG/Y
 JDxNAc4GeXUxewCKyqs7oNTnBSH3EY+PkA7JJa7JHLOmst9LRI8/uzQd6Xv6ftve
 6xkSt2MvDneCNt7ehcG4TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743523896; x=
 1743610296; bh=jti1wQsXf5mU7m4P3Tqkdd6YFLOpcCohn+5N7kPpAbw=; b=j
 AmcGb6xnXjgaixjd+57AlY0lDNLGFMveW6Wq4zvWSxjshYPc1QpvmemlSx+uvXFu
 ii+sKnmwwf2VKfuM4P8n4X9eZQl94U2oWE22BFdNfUuHEoZURTQ9ezeFI/yIf4gM
 h+5mdaN1TP52lxZuqc1YGmKVZWbgCChBbQOQtwAK4AznbYC4I0gieqPtm1yUYC3j
 WImvsHup/rCJGbwDdsMnA2JsbxxxGjecWtMrV4xlxlrNzwugoF1szhVZFtzip1H6
 syK8uPjgIk/CqKvXjdhupH++rUIG55Ar7OGmvpocFmid31/OnzjWvJseT6crqCy5
 yGYNw8OpALy4dSJhyqnwg==
X-ME-Sender: <xms:NxDsZ-ID1-XfCz1sCrkJOXe8qgLOIL7JEYYiTrltXMPsp2Ax_rcPZA>
 <xme:NxDsZ2LPV-KnKl2HwYq7qCuHv97NWXr8cX3dNT5iqbXOlbafZcdU5_OLOjXRBb7FO
 4TopKCoZ39kP3O3VA>
X-ME-Received: <xmr:NxDsZ-uwbWVzhcVHp-_fVVeOc0vadaIEimIHn6Kug-5cAe2SbXrnrFB_5k-2i5t5asGIfkDqfCe8HB26g7g8QtX2EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefvddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhho
 shhofhhtrdgtohhm
X-ME-Proxy: <xmx:NxDsZzbiLuSGejpN2Mk6CUnKYiyU7CdGx-7iTTDYQiQgQ_IuPtNsDg>
 <xmx:NxDsZ1aZPuGd7XglDmy7FBP6dp0ojEsuDW8LUne9Fm7mjQvcmnxfDA>
 <xmx:NxDsZ_ApmZUNWDFfmooR3sSAQ4PlYE1H1r9JEFgEdQdz137KSez-rQ>
 <xmx:NxDsZ7YMwolV4EiInMNhl3bvytZ7O_Pv3wd-KaW63cLvxL4y444FiA>
 <xmx:OBDsZ0U8KH254s-TcbV8Me4Od2YlWgyejPfVGDirRuMTXZWvZQy_Pdnk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 12:11:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com
Subject: Re: [PATCH v6 3/8] buildtools: display version when listing symbols
Date: Tue, 01 Apr 2025 18:11:33 +0200
Message-ID: <19551467.geO5KgaWL5@thomas>
In-Reply-To: <20250328105250.3082414-4-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-4-david.marchand@redhat.com>
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
> Display the version when a symbol was introduced.
> This is needed for scripting the conversion from static to dynamically
> generated version maps.
> It is also useful when listing experimental symbols.

I feel the title needs a bit more context, maybe adding "map"?
buildtools: display version when listing symbols from map
buildtools: display symbols version from map

Do we still need this script after this series?
Should we remove some scripts?


