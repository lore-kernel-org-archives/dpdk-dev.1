Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D87C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2C534114B;
	Wed, 12 Feb 2025 15:00:32 +0100 (CET)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 2BB3A40E45;
 Wed, 12 Feb 2025 15:00:31 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id C0893138097F;
 Wed, 12 Feb 2025 09:00:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 12 Feb 2025 09:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739368830;
 x=1739455230; bh=iHsKXDFiIgaoJY8yOVdAM5QeaLcf4rQLvIFbH+6og4Q=; b=
 nxibaBBFlbWqy5OqSFwSoOuMtIFXXLkxxMPZ+jkqkKEaJyrfKcBGal2ofAoPuKJT
 IpmaMXW3THZ4urHinP2NnwfPe4BVdsDkZgdUvntif3thsQHYn5tETi3gINJN6dmZ
 qVvhtbKYT6QW0eKE6tSNBw2UeDXlNIKhBX3IjmrUoaBLyn0cR2ESVvKxV3sHuuFd
 792vA+XaojEdeljyQYn/Welhl/HHAZ3+Fq0MbHtuJdYz5bl7qkjSP72kT1rMLgsE
 ifhkStxQfniBBBI9mrYQd5tg7dcLh5QzLJd4avHvhZ6AADV0XTSOtTCioLXrgZ3j
 o+KEmyamGldTS04uxP4ANg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739368830; x=
 1739455230; bh=iHsKXDFiIgaoJY8yOVdAM5QeaLcf4rQLvIFbH+6og4Q=; b=Y
 qHF//XnCgtnAl5GVX9bWaBGtJHz3lu9V/kvXC02Wea9ouGOigSY0FXN+/guWFeRy
 4vTWi0MrwJpLHX6z8K1TJXJ/QqZlvpLfxmtIKCANVMIYDr8Gt7OvCKczhl5JgFw8
 /i89lgbv8B+Lu/8OJ4WrktCL/mJeFh3f1NnpiuTjOe3jtIUvJOPf3qlwq/8Prpjm
 7kXPFlFvngYvTTBBIPrgQhvyXAU47JZbFUHHblhd9fAXas4lHdNpWgpvsBwHsaQN
 cV+FjbPPPG0aRUXm7Mf0/3boIlpLQj1ig6VCfqWrfaOrCThblgmkj8U8SpihRuZY
 JYSqdudPX2yDd8Pe8n3iQ==
X-ME-Sender: <xms:fqmsZxY0zh13xUH_cJYLDNGjlre3WqEXcsCSGcI1ff5pvyi2-qDeEw>
 <xme:fqmsZ4YN1lN13rPA26fjx4MrQpZWzhMqIdKHp6HLqK99gTgSsE3g1fXZcpvzxRBhn
 MlRwOVJHafIdbN1ig>
X-ME-Received: <xmr:fqmsZz9-MqVshp__drYihxkH-NlYgOX0v8GN1oPiPjxPpmFEoDFKmZbq4PA9b3IGQxjLS0vaT1ryhdLH4nwvc4wRsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrih
 gvlhdrohhtihhlihgsihhlihesieifihhnugdrtghomhdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsg
 gvrhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrght
 rdgtohhmpdhrtghpthhtohepughiughivghrrdhprghllhgrrhguseeifihinhgurdgtoh
 hmpdhrtghpthhtohepvggufihinhdrsghrohhsshgvthhtvgesieifihhnugdrtghomhdp
 rhgtphhtthhopeholhhivhhivghrrdhmrghtiiesieifihhnugdrtghomhdprhgtphhtth
 hopehthhhivghrrhihrdhhvghrsggvlhhothesieifihhnugdrtghomhdprhgtphhtthho
 pehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:fqmsZ_rG4_wpIJsBDjZDtdOiwdsavJFrsWcUIoNeTB4LE4W1q8j2vQ>
 <xmx:fqmsZ8oYfMiYtIRcwijGcl1LjdAodr8tnhud0Z7fdDTg_wNM-Z2zaQ>
 <xmx:fqmsZ1SmOmLUBiJgJd7kjsLUtSESgMRS5s1g1EcYTMUcAFhYAA0Wzw>
 <xmx:fqmsZ0rbdSSHg4iLWPPtFMpFlGwi6Od0goRIp9JUGwba0zKLFUf7cQ>
 <xmx:fqmsZz2awAO-Xi5dVNO2hjSKiZKm71JFExoEl_CUJzXNVxoyEpplMf0o>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 09:00:28 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 David Marchand <david.marchand@redhat.com>,
 Didier Pallard <didier.pallard@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Thierry Herbelot <thierry.herbelot@6wind.com>, stable@dpdk.org
Subject: Re: [PATCH 1/1] eal/linux: Remove unused values
Date: Wed, 12 Feb 2025 15:00:27 +0100
Message-ID: <3418821.9LS3J3VOpE@thomas>
In-Reply-To: <20250113171920.1185214-2-ariel.otilibili@6wind.com>
References: <20250112185842.9752-1-otilibil@eurecom.fr>
 <20250113171920.1185214-1-ariel.otilibili@6wind.com>
 <20250113171920.1185214-2-ariel.otilibili@6wind.com>
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

13/01/2025 18:19, Ariel Otilibili:
> Found by static analysis:
> 
> In dev_uev_socket_fd_create(), fd is assigned before a return,
> and not used.
> 
> The same for the variables buf and i in dev_uev_parse().
> 
> Fixes: c2bd9367e18f ("lib: remove direct access to interrupt handle")
> Fixes: 0d0f478d0483 ("eal/linux: add uevent parse and process")
> 
> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com>

Applied, thanks.


