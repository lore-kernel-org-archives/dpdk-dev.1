Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236AC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:54:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 484C642707;
	Wed, 12 Feb 2025 16:54:57 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id 66837427DA
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:54:55 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id C49961380169;
 Wed, 12 Feb 2025 10:54:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 12 Feb 2025 10:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739375694;
 x=1739462094; bh=VuZKxOYYo3OGH4P6SG4cQkmXhyVYPGcE0Hdr7sT03CU=; b=
 PfmROB23zjiuPTTwMQvJHGmejKmuqWn0pSZvG6S/6xqOri633d1rGe3+YG+vGhMz
 wOYtUJqDEGIYRJIqPhiD7cicSHRdJp8HIfn1htABPhnwr3383xMwqck3rqtCOdPt
 fjPrA57/uxYKrlKYvJuHMbwEXL64CNtuNjLNljNh7eXq/LY31qy9Dpdq8BjoCQba
 L3043bMgixttX9Kg9O7JwFJoP3uA9oOuyCRGsTkGAPCCKoad7TLwo+Q4gV5AVco4
 SCt8erqnT7UYm6YR/enR9dTR5KTYvrCnw+JuGmYaIY6WYS+aFPFFZZaQJFTwjPwV
 YzdVKOP0VOatItVsN2g6Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739375694; x=
 1739462094; bh=VuZKxOYYo3OGH4P6SG4cQkmXhyVYPGcE0Hdr7sT03CU=; b=v
 C3E6jKoUF/OhhqKRC3lQ5D6AGf5Z0kZJeZqOGZK2G2h+Ik6p9qFqfgyRod0yI4r8
 Rg/1YY0SFgZg2Z83PYBjMoEgUg3qZb1G7YWVsYobby7kNEGm9E8Iix0S28tqwxMs
 E74DXD74n1zVuTRWhDAlZdgW/yDPlYHlqhC6DtiQIDQ3XIu1EL4abIKAr/bZoQlY
 YIglzcAPmdIcdcd2jUC/AVfAFDGlM2Y4FrM6UHrOeXqNBWDX73OKQ8f4uoq9Qogs
 IVtbHFvF28UXUIR4H1n01rNsICXxOvFW1XiPObASofBxSuClGn98xsyA+xKPYXHt
 A5rWRxZD0IWAW/vQAsM6A==
X-ME-Sender: <xms:TsSsZxf_7ASywZDeZ63ZQ9S-rW4-xt-2dxPsC2sdrO6QgyTRSDJ59A>
 <xme:TsSsZ_NiQWke4d14ObLcN6yN3zxNi0u-9iVyDFhf4y5WrdlVAa2mVqiwI1SmFq0gN
 Vc34A1QJ7KSyE0GwQ>
X-ME-Received: <xmr:TsSsZ6jLIXlQG9gTMOVa3SDzZBrgFq6xDsQShATexZ4UuK4xItLyXJ640VZIQmNvHMDkqn275smAJeNkXPEMVF-yeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeeftdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinh
 hglhhigidrtghhvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughk
 rdhorhhgpdhrtghpthhtohepjhhohhhnrdhmtghnrghmrghrrgesihhnthgvlhdrtghomh
 dprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:TsSsZ68SIKQkvADEU_8Qhfgu8pIWiLvbMmnNxbLot10XcD8ncsWMTg>
 <xmx:TsSsZ9vyCOpCtBeCoAOHZEnYvM-afRPcLaOVBMwtmS9eXMC3v6lHTw>
 <xmx:TsSsZ5HFyvwlC69SOvEN20Bp0D3PS1DVqyC-n6dENlXkQYOtJeAS3w>
 <xmx:TsSsZ0P2HyLGRmdO5BhXBL4KRqmsiIKMkJ2u78FihVBuQ3cQZaHYng>
 <xmx:TsSsZ3LqssmiSX_KXmvfUO03CipsS-fdLcWn7xoA4ae2iJjoK8OvppHU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 10:54:53 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Lingli Chen <linglix.chen@intel.com>
Cc: dev@dpdk.org, john.mcnamara@intel.com, bruce.richardson@intel.com
Subject: Re: [PATCH V1] doc: add tested Intel platforms two NICs
Date: Wed, 12 Feb 2025 16:54:52 +0100
Message-ID: <1798469.d7IHhHJzqS@thomas>
In-Reply-To: <20241206053928.1640200-1-linglix.chen@intel.com>
References: <20241206053928.1640200-1-linglix.chen@intel.com>
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

06/12/2024 06:39, Lingli Chen:
> Add tested E825-C and I350 NICs to v24.11 release note.
> 
> Signed-off-by: Lingli Chen <linglix.chen@intel.com>

Cc: stable@dpdk.org

Applied after the release, and can be backported, thanks.


