Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B089C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 13:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F1AB402DA;
	Wed,  9 Jul 2025 15:46:07 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 78FD0402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 15:46:06 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C71D77A0281;
 Wed,  9 Jul 2025 09:46:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 09:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1752068765;
 x=1752155165; bh=5dV8/l6kK8YBG1X6JtjlI1CTlQy9bANRnPxeKm3kur4=; b=
 ftgKdbwsqKEkNNpwWrn0sdhVr6fdDgo2R+PWA1d+6yBfBEV6hoPkiek9Mu7/v1W5
 Eikv5coZsiQ563IZUum3EHDK3sFe3AXq0ZBOfx2mLB1iCzikjrOFvl60OOkZydHV
 MB6u9b17XknsFOIsd5x9A/Ul3bX1nOy3LRQOl2IqMwjGbYGi/k0MKuLSLpaYCt2g
 NlNBJlSS4MM+zHlSDrkzezYBNJewicYidwc/3sQY3KX0/FYXhgCUDBvzX7w3mJ9Y
 NSe4i9R6Ml6wZcoELsleon7eek6vVXgitEIDd6V73qc4clY2NYi5NHVxYaRghexe
 vWmvh9OzCSXsGUC8E8rmow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752068765; x=
 1752155165; bh=5dV8/l6kK8YBG1X6JtjlI1CTlQy9bANRnPxeKm3kur4=; b=D
 N30x0gFG34/8jBFoQ9KjgwcQf72kioyATruP7EikmMw1ylPtJIe2+Wb0p5HSPpux
 OmX1Wf+80qDtH8JUuOP1HTQWHo7zxyiPBaYLcNjd0wj6YdeqIam6lXHHkYYPlS14
 pA2kNPxpRnwaK2rKXbiJgGE9x/sh2dJDYmcwur9qHXAJ9rBZgginD55Eh4iDEgCn
 ysD33/yMbXRs2pzMnixwJwiZL+dKwaGlL1OljDF82Oq38znc459bN6b7o/iJANTQ
 qkODwzZ3M1kjJYEw6b+DjLSl0bma7VpRIJIhjWNG7TcIwoswGoEZgA7qjXrcqZTa
 EdS0KGr8lTrWPDKcsZM7g==
X-ME-Sender: <xms:nXJuaLZJLTXj69_AzKpkB33-whFwXan1x-_kcjC_OC6EizalNWFljA>
 <xme:nXJuaFTwHIrPaUiIluFMQQHz_lp38rzQ9pqkKht2YvNV4A349fVnER4eQKPYjh64N
 CvrIkqQ94-wUZ_jvw>
X-ME-Received: <xmr:nXJuaFyM3JbeWCoecMY82w_4Lh-mCHkFV7UKVZhKj7XQRjoWXB8Y4ao5qGio59UX3OjX1FY7cVpeT5QfW1xci1dLew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesih
 hnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehvlhgrughimhhirhdrmhgvughvvggukhhinhesihhnthgvlhdrtghomhdprhgtphhtth
 hopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:nXJuaP14vPyNvlhaFF2t-pc2WIRkC_4lmPyCBIaufvJnQKxaOShdoA>
 <xmx:nXJuaL7fTrnoVj3AeZB5PXvl79wRHp2Fc8oQpBKxlGxDnFLGfkMi-w>
 <xmx:nXJuaKUtA3j1hFTlZPKVvAFDRuH1Rvb2CSA-mRZ6-ELzgDKrOeO85Q>
 <xmx:nXJuaCD7Dm1WJFYFCWekgOzfY1Ug9P9MhYYILFTfJl7S-av26tPKHw>
 <xmx:nXJuaIChByNVE-_q_HaqjJbPKfHDT6h6IU6_NFcpRDOgVPad_nTsiH_a>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 09:46:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v1 1/1] net/iavf: fix order of inclusion in vector code
Date: Wed, 09 Jul 2025 15:46:03 +0200
Message-ID: <23891910.mFnZMskM5D@thomas>
In-Reply-To: <aG5ueFRWP86CUrZa@bricha3-mobl1.ger.corp.intel.com>
References: <552f8241f4f65fce0c8b43797612a97dec5d9ebc.1752066381.git.anatoly.burakov@intel.com>
 <aG5ueFRWP86CUrZa@bricha3-mobl1.ger.corp.intel.com>
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

09/07/2025 15:28, Bruce Richardson:
> On Wed, Jul 09, 2025 at 02:06:29PM +0100, Anatoly Burakov wrote:
> > IAVF driver does not support 16-byte descriptors (because there is no PF
> > that can support a VF using 16-byte descriptor), but if IAVF is built with
> > a flag that enables 16-byte descriptors, this flag is then propagated
> > through the inclusion chain in certain cases, because IAVF includes common
> > vector code before IAVF-specific common code (which in turn includes
> > `iavf_rxtx.h` which disables 16-byte descriptor support).
> > 
> > Fix the inclusion order to include IAVF-specific vector header first, which
> > will fix the compilation error due to correctly disabling 16-byte Rx
> > descriptor support.
> > 
> > Bugzilla ID: 1749
> > 
> > Fixes: 11276ec5e042 ("net/iavf: use common Rx rearm")
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


