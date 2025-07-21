Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A0C83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 20:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E75B84026C;
	Mon, 21 Jul 2025 22:15:43 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id F06EF4021E;
 Mon, 21 Jul 2025 22:15:42 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id A1697EC02F3;
 Mon, 21 Jul 2025 16:15:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 21 Jul 2025 16:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753128942;
 x=1753215342; bh=eK1RKACUToJXgx6uynwrO7E9e8Vsgw/bZkgrWhoVRhs=; b=
 cV627SHzrxlpuWbS3irGkC2cwcgKFSgjmgSHb7625czd4vVNRhBRy+0OSEaWOvo2
 VWjXmQ/jUJuiT+ZchjDW3MUzHHeLrqziM+X0iJA7Rs/hn3+gU4oB6/YTsM2kj7zs
 SePX1Dz1VMVL5SWLhPox+PJNoO5b+XD7TOnlafdvoZlJMkgFMgWhjrwE+VESWg2g
 uTFXX/4mN35Uy86d3mac1RYNVKq4aIB+vDtpRwB50/2wiH9d1K9NDMnhiWSTYRnh
 RdLShwPSfSq2ipahDWAvwOHvi6cFj4hG4hXOOjKnoqGTSb/BqqR1GQ7i+dSfbyWP
 nR7aRKdTn/OQk2KYWrJ5ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753128942; x=
 1753215342; bh=eK1RKACUToJXgx6uynwrO7E9e8Vsgw/bZkgrWhoVRhs=; b=o
 EBvo74Co/FkEPnSq0dmZKrHJ4ccXw6D3LkLw8j6Hyl6wEr5u41ToL8/wnfAKhG5v
 CLhAaNQquCPHtvDPD0VLnZjER1std2nZYbhv0gvLJF8tFTeJt4IDRmRlDKpdrwSQ
 204KKrvoO5VkFGZ8M2Gh2nrxoTKq9HU2MZUz8JHR2fY17xIm1W99OLggd5+YE2Ax
 cmSd0+gMmGwFLdlrffk2X+GETuAu8/q4HF/2rZPMgQh1lGYe3H6OFjUQousKNKuj
 UdHcdGGbuCEhd6TuIYf02caFRKn01ApobHWXdTFiMM1+CZv7GQpuE9R4sSSUJgJo
 UdVdNf02c7nAa9O2hYQSw==
X-ME-Sender: <xms:7p9-aCyuGjaXExsVTieGWo-Pvs2x8WTvm5DFD6wXmGeC6-ugO5x-pw>
 <xme:7p9-aFuoOWygM9n6Iyk9FHIdXNuFILQHyKqTKTfgyntxrChqWVBaUfQJUQdZduLvC
 6rhd8ICHj-nqXQpSQ>
X-ME-Received: <xmr:7p9-aBt5MDR_mgIyLTI5Ydb2C3Kec4AQv8Y_X-ewL7Hdtu7Hf4HInXxKUSMQYKzgOiN-yCYwLyTPtQaLs8qfzoNSzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedtudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepgedttdeljeejgeffkeekkedtjeevtdehvedtkeeivdeuuedvieduvdel
 veejueejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pehtvggthhgsohgrrhguseguphgukhdrohhrgh
X-ME-Proxy: <xmx:7p9-aCNWIL0ziTcYNZ9uVM78wuz9j7jrocBSUkD-5rpmP4ZmqE0cbw>
 <xmx:7p9-aH2azcCKkzAsQGGxPOmHzUMXeG6KMLaE3gEeFfgW0evs5sKjtg>
 <xmx:7p9-aGOWJKzzSyfWFSL6Qa33C1WZ8ylFc94GuNsCnHV7ca8i46MhmQ>
 <xmx:7p9-aP0DyBW3RmqQ5l3XagGcUtdF4cthSWlzRC3nKvc4DKJ9JXI9Cg>
 <xmx:7p9-aFrFu2A8KGqyMpHbsufuOmPLjZohp6MJ2GvGLutM6kpPz6ELK_bq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:15:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, techboard@dpdk.org
Subject: Re: [PATCH] doc: announce changes in structure alignments for UBSan
Date: Mon, 21 Jul 2025 22:15:40 +0200
Message-ID: <2033074.jZfb76A358@thomas>
In-Reply-To: <20250709124022.4105481-1-david.marchand@redhat.com>
References: <20250709124022.4105481-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

09/07/2025 14:40, David Marchand:
> As part of the effort to limit undefined behaviors in DPDK code, some
> structure alignments revealed not to be accurate enough.
> At the moment two structures have been identified but others may be
> found while running more parts of DPDK with UBSan.
>=20
> Though the calling code can explicitly request alignment,
> we would prefer to put the alignment constraints as part of the
> structure definition itself.
>=20
> Such changes are ABI breakages.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.


