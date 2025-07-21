Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B49C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 17:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48BC24026C;
	Mon, 21 Jul 2025 19:26:12 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id F32594021E
 for <dev@dpdk.org>; Mon, 21 Jul 2025 19:26:10 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 65727EC01B5;
 Mon, 21 Jul 2025 13:26:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 21 Jul 2025 13:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753118770;
 x=1753205170; bh=qa8HTbLzeOnzpbxY5cC9F1ShBniDwuxG/G6rvJtF8YY=; b=
 NTthFX/buZ5xOCgdVxCDF/jJKYeGRwQm0msKVepSYY+Q3T7DSpt04R8xnOIDNmHZ
 GUX/4WeofihsxVNHtC82xY3Xvy24G7LneWsxCSuXBSAevnjRNTbXRe17J6nkSx+W
 5Y5l1C4VtU2qmV5O9Is1iHhEt+qalfzk0kL6ejb7+6OQtngualRKVGLYt8YP+9Oi
 +cpVKeW1FOxSMqr+ccktdBkB+jf6FTZcVQDbx9BP1gza4yXOK/qt7XgxVccf6yp1
 Ab6Z+Cm2p8WETXzHGX6OYiwOwuTJxBNhuqn94NABeMjaJ17DAbnRDeS7KcAWgJFH
 29AO/QAlMASXTjvo22nKeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753118770; x=
 1753205170; bh=qa8HTbLzeOnzpbxY5cC9F1ShBniDwuxG/G6rvJtF8YY=; b=C
 wfi1M12l4Kir+8O3tjOuLawmQ+2j92UHyiv4wlHvvOiINejkAQyRnC/WywRio1fJ
 a9F9bukLSK1q99MDVZcNKXCE9/js6QCj0z720f3JPVIF9NHT0PciMgraE+pWMgMH
 G21oWMWJ0EAN6kKG0mKRyX1I1fhkh27x94yfdhT+wN9NOjQP9OpVA+2o1vqQd413
 8UnVaAcr06H17V1aXV9MRmgsJ3JTeQiB2b7Xs8dP7uTqS1uK9ptuyYrj3Zfc5DuX
 OPceBQb7UwApPJKDRmXmZbI+YHey571Es//dLwtX7ZbTSr8DWSuyJu10aT0aWBw3
 sJiGVNyAhEdgm9asUEfWg==
X-ME-Sender: <xms:MXh-aDCmSs0tY4HcrHB7kjeQuIHU2RW8JOXXZMl1Sjvs0twFFRyWlg>
 <xme:MXh-aDKV7CkgeeB0nA4ytMB07khPNW3J0LLFekaBEILNzROgoUtQ5qkyyY0Sel4RQ
 nBEmrlHHz5R2G0UAg>
X-ME-Received: <xmr:MXh-aOlpsP_8CwjtbC7E2-0MAWfYLQvJ-7QaVYb6BqrS8iYjareDWKxyZA9WW-hhoAvYkdU1wwOQXG_sPBdkR63M_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdeikecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplh
 humhgsvghrrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Mnh-aJF2jkL7mDl6acN1nsm2NIR4e2wu-lYOkGT3Ovbwh5tR2-n-2w>
 <xmx:Mnh-aGFFpUlPz6m_mLXkpZmx466tl2yG4M4ty9jJH2yezdyePktSPg>
 <xmx:Mnh-aOMrgVWZSznaKbyNeELkK9BgsAsPCpc6ZjXoflbsktashl7qnw>
 <xmx:Mnh-aNEiQ88tYISgKThW0LW3vnWBc3cQ5p_HZ1ScyIViNGp4RYBJ2g>
 <xmx:Mnh-aNDxDhIsEGw1YzAN6hwmMoy6bcvmiyUR3fEcYWKWa34bOMngadf0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 13:26:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [RFC] doc: change recommendation for installation of tools on
 Fedora
Date: Mon, 21 Jul 2025 19:26:08 +0200
Message-ID: <2256809.C4sosBPzcN@thomas>
In-Reply-To: <20250609030306.17171-1-stephen@networkplumber.org>
References: <20250609030306.17171-1-stephen@networkplumber.org>
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

09/06/2025 05:03, Stephen Hemminger:
> The syntax changed with Fedora 41 and the old command is now:
> $ sudo dnf group install development-tools
> 
> Not sure what is on RHEL 9 or later.
[...]
> -    * For RHEL/Fedora systems these can be installed using ``dnf groupinstall "Development Tools"``
> +    * For RHEL/Fedora systems these can be installed using ``dnf group install development-tools``

The new command works on old Fedora, but not on RHEL.
So I keep the old command for RHEL.

Applied with this change, thanks.


