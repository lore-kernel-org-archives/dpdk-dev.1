Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A60C83F1A
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 19:54:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C2D4026D;
	Sun, 20 Jul 2025 21:54:29 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id B1D3640265
 for <dev@dpdk.org>; Sun, 20 Jul 2025 21:54:27 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 1062CEC00AE;
 Sun, 20 Jul 2025 15:54:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 20 Jul 2025 15:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753041267;
 x=1753127667; bh=xCqXI3/14dR2weQFWSN3IL6kBf7UDuz/Zo0N/9stxPc=; b=
 GF6eq5CX3wZzxo67hPtDhD9MEJ04Ne8MTiOFdlqN6YMt1mqRt1nmr1A/ScIPv7/b
 qt3BTXk5+f59IzvxREdqEHghAdXrAlNGnDte2Z8x0YLdYRtR+s644BxuXv2kR4BQ
 rPX/xDTR0rtdzJHklYpAX7gSXzFEMCEVwigDxUOlmcz+0aQb1nw0byEtC8SG5jM1
 Pr0Lfcxjwjzalw2IWLNJsLv+SB2PxwLts47wusJt7PtHamjkn+d8QX/uc698D8SQ
 Fx1ChaurMFsDc0HmdJiDHrDWTJO6XI6YMJhAWFdJIW+hETEr9A0WIznhGFbuxMOq
 fYnfw9JAOK1MOim68HMAWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753041267; x=
 1753127667; bh=xCqXI3/14dR2weQFWSN3IL6kBf7UDuz/Zo0N/9stxPc=; b=I
 dyAprPWV2F8Q8aueDLS3Y5LNo+ZsWeBpAhkArA26dmkQoi0WjN9YXONgiZdf4mNN
 lbgCT3pG6ltyRUzzby0Vm0QJozVqrkxMDXWs5TF4WnCXPqXZwwTYgMfkM8fc38g+
 YztYILc27OdmFELIKzJP+kW2WgHt0heD/MNqJf0jjj1zogmapIfqTr9Vd2Tki2hN
 v9YKnGWEgz9H4w7FAjbI2eoWfeX2c2xf72h1WiVY/ekx17k7g9olbMJRcCjYfvsa
 symGyViK9UsX4juqcpdHXFtVU9YstOO/EQO9TqBHm28pNhygaW7f4oS5FmOBh0hh
 qhjDGzM112Y/BqiMhWG4g==
X-ME-Sender: <xms:ckl9aDK_wsR5DMSHlEObWcDru7n-EFFbVdWVmmjbtlwuwrBVpo7LJA>
 <xme:ckl9aMhnteSuew_SvFU2cX-xNQFwXJX8PdV3drGnqx08Cl6hwthlH4Jc3QLBtGzj1
 nmcL_Km-_RrhMNBcg>
X-ME-Received: <xmr:ckl9aL7GB5RfU3LCCk_NrTuFcK3y1XRD1dXG3-511NmtE4eOG3B0HU6Ve5ULv6hp74ajPZdFbItrwxJVdB-RNU-gXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrgh
 gvsegrrhhmrdgtohhmpdhrtghpthhtohepughhrhhuvhdrthhrihhprghthhhisegrrhhm
 rdgtohhmpdhrtghpthhtohepughouhhgrdhfohhsthgvrhesrghrmhdrtghomhdprhgtph
 htthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehnugesrghrmhdrtghomh
X-ME-Proxy: <xmx:ckl9aMblGKLA7jRISpYEa95e1Sv3KtriWCaxrEdQXDzEjY-Tmg2kYg>
 <xmx:ckl9aI7jMm9sUc3PQBaN7ePgzKj_UsU38_4cOAYiDvaNeOfL-sHUYg>
 <xmx:ckl9aHA0GjFukk3gs_Ye-yu0R0diltnJVud8j5CyXc1yPWbHW65byg>
 <xmx:ckl9aGdNge5S61zfHDZyu-JL75R4tD8spvcrqx6BZ-A2XYF5lNTb4Q>
 <xmx:c0l9aB26sWweWGrORf9-AY5Se3oOcxU2DTGNydNIYNcuUyBK5Qng5bcl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 15:54:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dhruv Tripathi <dhruv.tripathi@arm.com>, Doug Foster <doug.foster@arm.com>
Cc: dev@dpdk.org, nd@arm.com
Subject: Re: [PATCH] doc/linux_gsg: add build instructions for new Arm SoCs
Date: Sun, 20 Jul 2025 21:54:23 +0200
Message-ID: <4444415.ejJDZkT8p0@thomas>
In-Reply-To: <20250516185307.1494231-1-doug.foster@arm.com>
References: <20250516185307.1494231-1-doug.foster@arm.com>
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

16/05/2025 20:53, Doug Foster:
> Add explanation of recent build configuration changes for Arm SoCs and
> instructions for adding a build configuration for a new Arm SoC.
> 
> Signed-off-by: Doug Foster <doug.foster@arm.com>
> Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com>

Reworded a little to make simpler and avoid the word "recent" in a permanent guide.
Applied, thanks.


