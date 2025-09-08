Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73151CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 12:18:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 759FD40156;
	Mon,  8 Sep 2025 14:18:45 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 665884003C
 for <dev@dpdk.org>; Mon,  8 Sep 2025 14:18:43 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id D32621D000CF;
 Mon,  8 Sep 2025 08:18:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 08:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1757333922;
 x=1757420322; bh=VRubRt+zeEm/uQE15Upc1jQQgLt4iF3z3OWfKAKCt8U=; b=
 XzNaNHIwYZfsAaCJ+SEl2HDYx+dhFWml0gz6Q8PMRZGvbFESviVbv6dZQjJ5HZ7G
 gURYplxXbrVRdcIDyfQvZ6W7KTAjjhUovRzmAahe9uzG1a2ri1IqtsfG8Urdkdb5
 whkUIbrCu17LhR19/apuRTivhn00iHNE9n3tzTHRV2MfnlrtjuxyqRZFQBEpINkZ
 eH6pwZcgk6LK8EaYbjG0rK94AhKXYLeAML2+q5TKEDVr+oP0Uqk53/S2ZPyUONK8
 ETeeqdRNHM8rP80osdWLnRAvpPU3w0Q+AELmRULcy4IM+33JBvIDeCCzAlRMjbQA
 RFzezCFia8nNnRpNMpwgXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757333922; x=
 1757420322; bh=VRubRt+zeEm/uQE15Upc1jQQgLt4iF3z3OWfKAKCt8U=; b=U
 fWIaq6zOimmNdNaFhglUB9oN8ScifUITsQjvk80uxGeWAbu0TU9waBAv3oL7wVJt
 pe/P0zhquXE1BPJ9jZAqtgIKyUXjWZjxBZVooUkxghZc7Mpw+Q62nWDJzSnuPnrD
 3xBr0jyLOYTvCtcakolDYaaB6tMeQgtAB/BiahQEbNp2gjJgoRNHVI51ojLX0/QM
 tkqVW6vFvSIBO/S0nMp3zbNzCvXld2tuAj9qLgbgpzGxDnfEmk0psUnrZZ815tu7
 46Rk95ydNzQeel24pOnsyhmAoFPDg9Jm85JVb18TNjrIWQZFw38VwurRnGO7jtkX
 uupIsXJiiR5jfqVdLjgbg==
X-ME-Sender: <xms:osm-aMRBDMk917balfI6vWLweqeuMPft4468w-3Hz7fOwIDc1fwX_w>
 <xme:osm-aPAh_USIWfwshnSU71Tb7sBtGZh9Jun67khNzdyMXU5t9la3TSLlFY4sX-zj1
 AOfsI5V2wPs6vZhvg>
X-ME-Received: <xmr:osm-aLiyGA4LzP8_ohbrEYJxQ7Cn_HjtX5LvXqzBG16TKwBduJvWkPIAJKc0unOHkYTvqNrHnpu8XS1tMz0kyiu_MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkjghfggfgtgesthfuredttd
 dtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgf
 dtgeekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:osm-aINe_rbmSoqOpgXsIj17wuAQRhZJXmRDpBdk_WUiRh-f3WF8-g>
 <xmx:osm-aM441lXpFRl8w0cw9xgB4Uccly7tdy5E-obNE2FAc2JFPS9N1A>
 <xmx:osm-aG3B7e4pmzrR4ZG9LZXBAfIO8ZKKLN6ICw1dlDBeVkpC-b_Anw>
 <xmx:osm-aNY0F8tOEbY8knm6f7ccOD-fpPYNZbsu-FfhZh9EV4IBMRuJaw>
 <xmx:osm-aHTVbUTeOL3uINt0jPhF3-QOskVh8ax_Kzk2CMUvfbq1xIuJd2xw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 08:18:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: Re: [PATCH v2 0/3] fix build with MinGW 13
Date: Mon, 08 Sep 2025 14:18:40 +0200
Message-ID: <8574087.T7Z3S40VBb@thomas>
In-Reply-To: <2379702.ElGaqSPkdT@thomas>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250827151759.1448018-1-thomas@monjalon.net> <2379702.ElGaqSPkdT@thomas>
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

08/09/2025 11:35, Thomas Monjalon:
> 27/08/2025 17:16, Thomas Monjalon:
> > After an upgrade to MinGW version 13 on Arch Linux,
> > some compilation errors appear in PCI, mlx5 and bbdev code.
> > This series fixes them all.
> > 
> > Bruce doesn't see them with MinGW 13.2 on OpenSUSE Tumbleweed,
> > but perhaps just missing some dependencies.
> > 
> > Thomas Monjalon (3):
> >   bus/pci: fix build with MinGW 13
> >   net/mlx5: fix build with MinGW 13
> >   bbdev: wrong fix for MinGW 13
> > 
> > v2: make status_str variable local in bbdev patch
> 
> The patch for bbdev appears to be OK,
> so change the title to "bbdev: fix build with MinGW 13",
> and apply.

Actually no, it cannot be applied because there is a failure in Windows:

..\drivers\bus\pci\windows/pci_netuio.h:10:13: error: redefinition of 'GUID_DEVCLASS_NETUIO'



