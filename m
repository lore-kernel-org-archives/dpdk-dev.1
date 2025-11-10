Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03448CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 22:15:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C23F74026D;
	Mon, 10 Nov 2025 23:15:45 +0100 (CET)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id B0EFF4026A
 for <dev@dpdk.org>; Mon, 10 Nov 2025 23:15:44 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9E7D97A0194;
 Mon, 10 Nov 2025 17:15:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 17:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762812943;
 x=1762899343; bh=GlKbxVTHMKoKHEizd1rXVyQtZxBBAyjv0xwhuUUfO/I=; b=
 k9PoTy38J1yRVLG1R8MVH4o0rJFlRtMd7NHaPVPVlF3Um4dYGgU8MDidzEe0wrtI
 VelDxcE45meDUkhBCbp4SR1IvuQ7WZTlRCs9lMG5lqk7cGZkfa2Cc+VYSuvhUmfF
 2XDMhK4CiES/tziwFSWR5wfeCR0M15WyTWMKGJxDFQ0JIOJlJ31gvSMFG2xtegGT
 W8P726EO1yYa+LH+io7YDbgU8o2H43DbW0hvJcsHYtVmFZ6dy+i0wgxx7G7DXB2W
 RON+XrOukC2jEbWigooOQa1AcKqTJDiSbASi2EBJXa549HrrRozwm0MNItqQtUwf
 3N/xnYlSwjy7Jn+4l8eohA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762812943; x=
 1762899343; bh=GlKbxVTHMKoKHEizd1rXVyQtZxBBAyjv0xwhuUUfO/I=; b=a
 W0OnzTRXZWQhKJqqbryExSlSYioHF8+/8O8pBdRQxJop1KVJQX5ORfeY3j2YqyVW
 PPxdtP6+dVqAvaatXnPBBmOcXnsyWY89bjUdQ2HIUNPGrYeVWaQmIS4g9PMmPzui
 sP9qQUk27O5YLkXqbtnhuTF79huJo0W1Z1uaQO2WhJJbyeEJCq6H/t3LNt1VBYK5
 +HQmumMuj8S4TX+eUI6ho70dfl7A1YabuB9mfRfzgmZ8DSvWjOzAQ08ExuxejU/V
 8l9K8tDiDN6RD69k3pW8BcJuz60Vjb/ZL2lcNMtfE7zBAozA7HQZGr6Uhq5m18tf
 JOs83V7EnOMc2EU2L06Rw==
X-ME-Sender: <xms:DmQSaaIhfLpbyJbKTLk9JMenziEtBVIqbL54ah_ARZBq_7jARgvhrw>
 <xme:DmQSacM9t7zkRKankFF--6S0Np1gnAbWgL93jDrk-trALUwhBIiUV_bYVwxhHaU83
 yGu_h3q7IOwy9kAKDRbrf7_QYF3Tk6JtqqhpY18MCLcc1p1bHL4>
X-ME-Received: <xmr:DmQSaanZIHkwxjMkNGQgYo8dEi2ILvCHDawcqzm4Glvao_17P0sEqOIeTYgPmKteV8h_XqI-Fi5fXCj_iEt1IjvM6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrjhhithdrkhhhrghprghruggvsegsrh
 horggutghomhdrtghomhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhl
 uhhmsggvrhdrohhrghdprhgtphhtthhopehmrghnihhshhdrkhhurhhuphessghrohgrug
 gtohhmrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 khhishhhohhrvgdrphgrughmrghnrggshhgrsegsrhhorggutghomhdrtghomhdprhgtph
 htthhopehmihgthhgrvghlrdgsrghutghomhessghrohgruggtohhmrdgtohhmpdhrtghp
 thhtohepshhhuhgrnhhglhhinhdrfigrnhhgsegsrhhorggutghomhdrtghomhdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:DmQSaQ5-v9otkPu2D69oEsQSiiO1-pWYvy6YUWPHYpOYtQta6NsNSQ>
 <xmx:DmQSae39PRvjdkMgwfyUudWF5CF24RYFFHcx0IzvkoWHe1WuMJI-uQ>
 <xmx:DmQSabEp7VyJpIG6DiLZS_UQHOl1CwPI6J4oYEHLO3fkBa8CHJUw3Q>
 <xmx:DmQSadhU2rkxFDhGcBBbRk9pqEIiJqjrihoSJDfrnq2j4ShLMQ26uA>
 <xmx:D2QSaah5-t0FLWBaa5LG_z8KN22ZQalUO6AKtFlGXqEBYxaupkI0N0y3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 17:15:41 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: ajit.khaparde@broadcom.com, Stephen Hemminger <stephen@networkplumber.org>
Cc: Manish Kurup <manish.kurup@broadcom.com>, dev@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Michael Baucom <michael.baucom@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v5 19/57] net/bnxt/tf_ulp: hot upgrade support
Date: Mon, 10 Nov 2025 23:15:40 +0100
Message-ID: <7115847.Bh6DGQjDyp@thomas>
In-Reply-To: <20251110135206.03f1a0be@phoenix>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-20-manish.kurup@broadcom.com>
 <20251110135206.03f1a0be@phoenix>
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

10/11/2025 22:52, Stephen Hemminger:
> After merge to main the build fails because of this patch
> 
> $ meson setup build
> ...
> Has header "bpf/bpf.h" : YES
> Checking for function "xsk_socket__create_shared" with dependencies libxdp, libbpf: YES
> Checking for function "bpf_object__next_program" with dependency libbpf: YES
> Checking for function "bpf_xdp_attach" with dependency libbpf: YES
> Checking for function "xsk_socket__update_xskmap" with dependencies libxdp, libbpf: YES
> Message: drivers/net/af_xdp: Defining dependency "net_af_xdp"
> Message: drivers/net/ark: Defining dependency "net_ark"
> Message: drivers/net/atlantic: Defining dependency "net_atlantic"
> Message: drivers/net/avp: Defining dependency "net_avp"
> Message: drivers/net/axgbe: Defining dependency "net_axgbe"
> Run-time dependency zlib found: YES 1.3.1
> Message: drivers/net/bnx2x: Defining dependency "net_bnx2x"
> Compiler for C supports arguments -DSUPPORT_CFA_HW_P70=1: YES
> drivers/net/bnxt/tf_ulp/meson.build:41:3: ERROR: Option bnxt_tf_template does not exist.
> A full log can be found at /home/shemminger/DPDK/main/build/meson-logs/meson-log.txt

Yes, sorry the merge is only partial.
I was assuming each commit could compile.
It is totally wrong.
Even after the first patch, compilation is broken.
I'm hesitating to reject all.

I propose to make sure the build is fixed after the series,
and keep compilation breakages in the middle of the series,
making git bisect impossible at this point of the tree.
If I do that, I probably won't merge any other bnxt patch for a long time,
waiting for a better process in bnxt management in general.


