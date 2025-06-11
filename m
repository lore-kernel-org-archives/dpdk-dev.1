Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BC3C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 11:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 920194060F;
	Wed, 11 Jun 2025 13:45:22 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 3CC00402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 13:45:21 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 5B6C11140214;
 Wed, 11 Jun 2025 07:45:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Wed, 11 Jun 2025 07:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749642320;
 x=1749728720; bh=bAlZq+/dDiW/3j3gtg7kmP6y791zEIVxCpUX6eAsj+A=; b=
 cQOkryDFA8VaC/lqb0ie0l0+0oqKAja++dWlqPKIqUz5xGgNh8baTBifIOz237/C
 jqK0X9mDAOAlX9Bz+Bm3HVTy1+wh1MXrGf2qpgxKXeT6K5YFVOxl2CnvQGYrkPsa
 GmYUJniFfuy0+VdQz1oALGKMEkMDQCGpg/KDBbBPgBnZsS+TmcJjsbtEis03VEhr
 VAmfwcyzKWyVF3u0cFGXRiE6ZTHhV/WZmKgzxhpRqfn0HloCy1EzZdoNYWQwZFPT
 oR0GyStolIUUj/rpDXpmL/lmEaLhaGpYz+D7UTyt1oTOmmYEysTaPlS26nYVHYhB
 HBuAnNG4kCf2+y2SQa5q0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749642320; x=
 1749728720; bh=bAlZq+/dDiW/3j3gtg7kmP6y791zEIVxCpUX6eAsj+A=; b=I
 Don3JQqnD7NtBmCAciMr8rWWcCOWGHyMU+GGCZCpmmS5ikjD9lpnKpWKqp69a9BK
 3ONo628vRPS4NqZVEtpwIUqf179F86oFhVRtCYJ1FY4A2ou/t7/LxE8OEE/nWA8R
 I8tBtML2iKPsOAJk7NfIfEhz5avU08RyVhoiUeyLK3JO9XnAgdKtKsRnsi/20Ygt
 Yu8IB2ZOC1b/JrRV7QDvc5l4mW8CRS2pIrNwlsobnKReu9KxkXf23Cn2H6OEsojS
 0uCvhlprvqOawnsizpYiG9KXDIa2p9vP5jkmGz5iTbrv3zaDrz1Rf/fQIEnc0enI
 1Kc7UGzeo6hePsONOH/1w==
X-ME-Sender: <xms:T2xJaFXV3G-lBfqKOKhlROMW4sRQ-I5j31_RysaqdO1rXEwKb88pNg>
 <xme:T2xJaFlPA7FWGwKcl9LHkPToqU29NSSsC4fM4eO4393-gtiuFnWMbzzl7anquFbfM
 SfZ8civ4wpEb9HJeQ>
X-ME-Received: <xmr:T2xJaBYXH6MmlO8cBvXK5FNu9z0Tbgxl9s3ICZOVASuqMmatuRoxu3_6EGMIOGyEDPlBzVIQSKDQUd6J3kw-j-EWSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhsrg
 igvghnrgduieesghhmrghilhdrtghomhdprhgtphhtthhopehnuggrsghilhhpuhhrrghm
 sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopegtfhhonhhtrghinhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepug
 gvvhesughpughkrdhorhhgpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgt
 ohhm
X-ME-Proxy: <xmx:T2xJaIUEJgStIQ5hQnz39DXz0QflLQW97LSxuu_l6xT62kUJObWFuQ>
 <xmx:T2xJaPkuH6mpYJZe5YBbqKXZ6buVsozbrPtZ-CVsfhi9iB7Vnf_fEQ>
 <xmx:T2xJaFdS7cI0hzn9mS0xeGGg983e-Qhnvau-CUTuKptw9_2_p0EI-A>
 <xmx:T2xJaJHK1wNPkF7Co3n6slVbMUafOq0kECK1TknjVpo6tla92tyXiA>
 <xmx:UGxJaIeq9KLFYHRbOfIPyOzYu9Q7WhHeYyx8DdE5fovUaF0m1sv5HXMJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 07:45:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nitin Saxena <nsaxena16@gmail.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>, dev@dpdk.org, dev@dpdk.org,
 Jerin Jacob <jerinj@marvell.com>
Subject: Re: [PATCH v6 0/2] node: add mbuf dynamic field for nodes
Date: Wed, 11 Jun 2025 13:45:16 +0200
Message-ID: <8151763.UjTJXf6HLC@thomas>
In-Reply-To: <20250428103711.3317231-1-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250428103711.3317231-1-nsaxena@marvell.com>
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

28/04/2025 12:37, Nitin Saxena:
> Currently each rte_node registers separate mbuf dynamic fields for their
> own purpose. This leads to wastage of mbuf space as once mbuf get passed
> a particular node, the registered dynamic field(by that node) is no
> longer used.
> 
> This patch series adds a global/common mbuf dynamic field which is
> reusable by all the nodes(including out-of-tree nodes). This helps to
> repurpose same mbuf dynamic field for other nodes. It contains two types
> of fields: (a) persistent (b) overloadable.
> 
> While persistent fields are those which does not often changes during a
> graph walk such as rx/tx interface, buffer flags etc. Currently there
> are no persistent fields added but they can be added later
> 
> Overloadable fields are those which can be used by two adjacent nodes.
> Same overloadable fields can be repurposed by other two adjacent nodes.
> 
> This patch series also updates ip4/ip6 lookup/rewrite nodes to use
> overlaodable mbuf dynamic fields.
> 
> Changes in v6:
> - Incorporate comments from Pavan
> 
> Changes in v5
> - Rebase on latest main with version.map changes
> - Bring back memzone based node mbuf dynfield for secondary
>   process [Pavan]

Please it needs to be rebased again on top of feature arc that you added.
Thanks


