Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C1C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 818064021E;
	Mon, 21 Jul 2025 11:29:02 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id CB73B4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 11:29:00 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 5B7A0EC0249;
 Mon, 21 Jul 2025 05:29:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 21 Jul 2025 05:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753090140;
 x=1753176540; bh=yJ6AWdmbvKib8CPzgZoEazdt9a4piIsFMV8QXA9hHnU=; b=
 mE7o4NAN1A9hC/VEj3tSChlPPRN2yNXxuc0e+AvZ0TMQwbgAWizijefRZHd72anY
 jDXx4Y1ZtOu9qW3nxqq5bVHInaiinfhQ2FPKLpY1hcJYuQO6cNn/H/ljI9ewihBH
 wM+PkusonNfBbvcEfE0Z6PfOFDgVammblzlSuYOjiakYM0ngMug9nALkuUvlIVUd
 z/c+vlH6oyovSidmxUSTbfCCzYsiJvKAJvgd9kNp0nfQGLZLpHNiP6Hkos04mV2u
 kXVpn0t+GMGfNI4uyM03YHcshHGFYHP4vXG8L9PH0PHmW3yg5QvbTaN3sZ91Arsu
 Z9qirOquLX2OOSAjKlSQIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753090140; x=
 1753176540; bh=yJ6AWdmbvKib8CPzgZoEazdt9a4piIsFMV8QXA9hHnU=; b=U
 ElNUx51MMQISXrRPBhVPnECRSJPQSpe+xLSSkes/wBA5iXZtVXUpYfQYGBobj7LL
 bv5gWXYuwbtrnq0aG93jRrKT6TjgqE5zglUpbIpprk1Ua0IIpbI7szinOoRXPsaC
 W/a09Xx6azEOumitMvUapJjPvE38Sm47BG8oRlphrypdFwnxf7cV2VP7+ffe//C7
 0m60L7YRo2OA6qMFaVDjuFz4OfkpCvkwY4XOm/TbLeURQ/KykHt8Bx6rMbeU75Iw
 AQClz3Tefs5cOIOiu2foh/AYiGgAdMrXoumlM3nt1WLgixI88Bi4ywE38ouNIO1Q
 4Jm8lG8DlV675dOSNgtDg==
X-ME-Sender: <xms:XAh-aPQh91kPFU-UsiaJ_RrjpPv3sV5wLbfDwA4_Co4bWCfUUQPyBQ>
 <xme:XAh-aKZfPxf5gZF5nylI6VomXJctpgFTJs1O7imwNezg9-O7NC02USJVhc9QoZCxh
 s8fu9X7kg5iwancCg>
X-ME-Received: <xmr:XAh-aE3VxKhOt2S_RWiWTic2r3Is1rpEhZGf8OjcUMGYU3cNGkWjiKX_rrnPAfCCyNzguzrfSYbeo2heOj4JN7oTHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejudejvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrihhlihhngidrgihusehinhhtvghlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:XAh-aCUI7FA2W3zovNg8myXmut5__aS0j802FmS0ZxNSGrBngKuIEQ>
 <xmx:XAh-aGU5twRB9wHSdwaRRwhLN2arSav3K_cSBbM8CT6tFTfA5iA75g>
 <xmx:XAh-aJepEYmf1NCR_EI6PPxfvaxqom9mUV52Gp8eE2McHTYjfaLtbg>
 <xmx:XAh-aHVgqI7NZF91MBcDdlmWOuA2r45BXp0T_fUIhPj62of4pGFWvQ>
 <xmx:XAh-aJyAGpZlIZ21q9DPc84WC0N0EEXBRTxMSaPZul1UKiO09RWC7HVN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 05:28:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: hailinx <hailinx.xu@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] net/ice: updated latest recommended matching list
Date: Mon, 21 Jul 2025 11:28:58 +0200
Message-ID: <3165056.CbtlEUcBR6@thomas>
In-Reply-To: <aHomgzA9qaeYdC--@bricha3-mobl1.ger.corp.intel.com>
References: <20250718020008.3364498-1-hailinx.xu@intel.com>
 <aHomgzA9qaeYdC--@bricha3-mobl1.ger.corp.intel.com>
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

18/07/2025 12:48, Bruce Richardson:
> On Fri, Jul 18, 2025 at 10:00:08AM +0800, hailinx wrote:
> > Signed-off-by: hailinx <hailinx.xu@intel.com>
> > ---
> >  doc/guides/nics/ice.rst | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


