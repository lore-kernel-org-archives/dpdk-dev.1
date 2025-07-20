Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F58C83F22
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 22:06:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB67140281;
	Mon, 21 Jul 2025 00:06:09 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 951864026D
 for <dev@dpdk.org>; Mon, 21 Jul 2025 00:06:07 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 06076EC011F;
 Sun, 20 Jul 2025 18:06:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 20 Jul 2025 18:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753049167;
 x=1753135567; bh=v0dgc187OuWwiuzIqXQ5i1nKAGZi6Ys3s2DFZ5rmCwU=; b=
 XR6xbbf2A8Q6UHHwa9VBVJZX/nhRIs1WqJt9lZsFgRT5xnqWpWNoc5aT0vFWcU+i
 0xNUoMASbZ8YFekj47rsOAv301EX6jU8AXo+vDzegawhpg0/3HDYLnBCv0XW1Jpf
 pHJCkky19YE4MvMTNg38UfaeGskcQrKxkiEZ33kJtDroGuqNHHsUF078cDnOpjfc
 Mq0z7nXROgTlBhrhvYwILzUIiIYfSAPn+jUa8DLlRZ5W5u7uk5NjSEdo9fAV2svH
 /rW9iDNbbLU4aTCfGwMzpxYQZ3TJpoR4HSttvrjUmPXoOyviTZ2KxdA47fyYGefU
 M9kPvoLImRtWPVduu8N3lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753049167; x=
 1753135567; bh=v0dgc187OuWwiuzIqXQ5i1nKAGZi6Ys3s2DFZ5rmCwU=; b=A
 eTHhOa+1TEas6HI7oO+obIcR+fJXSyAt1zc/9kh9kUjog4YCgUOgD4K1nRfgUPbl
 6tB9tADNyrQs5LnpYxlviXcfId+/G9LVkzjs9QiUS/0QPvJKxZuBcbOFTjP+1zN1
 3PC+tRJeh2n4B2PUnQk/si80dVZIv9ZHNkhDI2KXn3ufp2FQ715RJ+TYgCVr/B2k
 /Bn3JDTStfLTYAjgCxSWqoc1g0BbZZzk52/jDdbA8vXuoQFCCz4a9xLdm1alIRmU
 +F9pNu0CDgjo/TE+K16p9BXwuHgBj9HRGfx43GoyMpsv40/5Z/JMZh7FlVwjqQ1H
 k79UG+mMEyPW3TR57ZNNw==
X-ME-Sender: <xms:Tmh9aD9TQ6xzYvTl8Xz_yTiOIfy6LCUza9N0PeDlTmlpVveEyQMaRA>
 <xme:Tmh9aJW-HREQYA-7flDrMoLauUzqxxrR2YNbqh7yLaRCc15ef4T4MD7eUAbhKDvAZ
 DMHahgf_C_5HAOF-g>
X-ME-Received: <xmr:Tmh9aBD7EZxYYmpC4ViarZpZN7j1MVOxrWpO610MlKGwRs6oE0knwhrZrew2QoFPDwMfFmXnT8h15smQKu4WDM7nsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtdefiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:Tmh9aCxOdiIliM0bGQ193ia2ORPFyCjKt0c75RTLO4LycJz4XRNr2Q>
 <xmx:Tmh9aGBU9Re_OBvWIdt_3lf1_jHZYcNof7kMJjgq9Mt0x8h6-E041g>
 <xmx:Tmh9aHaoJBCHN9H9oMvbVv9I2sAMHpCymq4l3lv07enneS2P9UmJYw>
 <xmx:Tmh9aGg_T3obK_rOJQNFmOA43gzFI3XmFnK_2To0_1PxLqe1mdJshg>
 <xmx:Tmh9aKRjlda7rn_m-ro8kIrz6Nz_cgOxpuNdCxvbK-tA2PTXpzWMkawN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 18:06:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH 2/2] doc: use common description of EAL parameters
Date: Mon, 21 Jul 2025 00:06:03 +0200
Message-ID: <2197647.OBFZWjSADL@thomas>
In-Reply-To: <aHjpTFbdEszzBSGQ@bricha3-mobl1.ger.corp.intel.com>
References: <20250717114604.2285791-1-david.marchand@redhat.com>
 <20250717114604.2285791-2-david.marchand@redhat.com>
 <aHjpTFbdEszzBSGQ@bricha3-mobl1.ger.corp.intel.com>
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

17/07/2025 14:15, Bruce Richardson:
> On Thu, Jul 17, 2025 at 01:46:04PM +0200, David Marchand wrote:
> > Rather than have a subset of the EAL parameters described in the sample
> > apps documentation, prefer referring to the full list.
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Series applied, thanks.



