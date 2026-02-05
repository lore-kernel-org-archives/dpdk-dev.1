Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1BECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:30:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC6794021F;
	Thu,  5 Feb 2026 22:30:50 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0DFC54021E
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:30:50 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 8D0D1EC0536;
 Thu,  5 Feb 2026 16:30:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 05 Feb 2026 16:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327049; x=
 1770413449; bh=MuYNu4A+SoMVFhnHYoJJyvrOr8OUzp1qMei2xxcR6GM=; b=M
 myxt7ThSWPA3YQuN2pYtGdJV9nFU2AqJ6lNKXvl0mF5kXJh3RNtBvXqtf7qlawhU
 CTSYgnAP5JieR2p9esLjyKPLHiDBu8Ilb3mykzu9GqR7wUtFqh6Bksn2224aVUbQ
 F73W9QIwh3ZWfZebrqRd7cM5kiRlrwhEfyB/atq34TyE12sS2f7+vbvefTub50Gg
 zz9knqAQsFtUZ3cLLiBN3Ceb+aDv/D6C42wNsvsX/r1oOYznaTSdw69zuIaGgg8K
 ZSFa85aMjspQsGSHRUFWcj+Hc6RdnNjsWPJlrRZInAe13UcKaGve2tYLrsvT8M6A
 P/vOjrLTpBq2xcIpGJMiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327049; x=1770413449; bh=M
 uYNu4A+SoMVFhnHYoJJyvrOr8OUzp1qMei2xxcR6GM=; b=s6Q46niEZ4JHu9qFV
 mgeZE5K5n6xZO1qpwCVyXNfviag1ZouIyxe9EtllQqhZjmxO7VVn/tjLJB9HV6T7
 K+dFhTHPtlxf2uTLxhli4N4tJZ7kfiLsMwfSWZkagqLLJYHW9OklKG4oQlSSNizE
 gJK9MZ0bryy+6jcc8h+yg+MAL5Y66Hle3CxmmuYmnjBAtWmgV+SyROcMdy2djDcq
 7slqWdLGFv9bCcipQzCEvnX2htds8pA19m3fvqhJ5EiU1P+f9wGiiuL0ysFgfExD
 qjqJIvXmUdpM7tIjj4dg6JJGlQfAjaCvK0tgxT0mqaMawHAmgpuPmi6vFpu+Jq7o
 /BpyQ==
X-ME-Sender: <xms:CQyFaXIVdx4tSnpu9jlSz6saqxETC6HD00GOVSSEJob-sFZh6mPE9Q>
 <xme:CQyFaXd6u1i1AQ-pZT-K6kwj9TdTD_fo9sGqHm1mibrLIr_-ZKF1ZZtybyRZdOCr8
 6iD2gNxxQHTFe-uXYD4d390H4XMZrmZIycIybluRPdLVmdYdhU>
X-ME-Received: <xmr:CQyFaScYjV5YwYHd5BtR9F2Y00bKm-9iDRztDHXkrNwl42RBYKXdvWt-xzN2sHkCisLOAaVgac7trfnJ3E0KDaVIZiImM6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepheduvdeifffgjeefieefke
 eijefftefhgfeitdeuhfejudevgeefjeeivefghfdunecuffhomhgrihhnpehghhgrrdgt
 ihenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthh
 homhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 gurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:CQyFaSPyTfQYv3kIAfvI5LdXWndvicr0hS8j3f2PRWQc7ehBNGkd5A>
 <xmx:CQyFaRKBSNM_VVhcEpgkk1yew8XxRN7Yy16Cfb-foU83uotxcdlhIg>
 <xmx:CQyFabFpR9r86KbPrts0cx-isIUjRJ7qDtpqL02kWpnAPLeLC_6SaQ>
 <xmx:CQyFaRSET_C1bUP5vVFt4rk6pi5Jehh-yPvv0vy-OEW33k_RRECE5A>
 <xmx:CQyFab_zOfRuWdLthrAvLH7eg8UZdpfC7FieAvdOr5vSDJZRXPClBXSQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:30:48 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: [PATCH v4 00/11] more build tests
Date: Thu,  5 Feb 2026 22:27:32 +0100
Message-ID: <20260205213044.702908-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20210412215339.2439530-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While testing more build types, some errors occur.

v5: add minsize and fix debug build types in GHA
    fix new warnings with minsize and debug builds
v4: fix new warnings with minsize
v3: fix minsize build with GCC
v2: fix init of var buildtype

Thomas Monjalon (11):
  mem: check fbarray name truncation in secondary process
  mem: avoid hugepage path overflow
  argparse: fix minsize build
  mldev: fix minsize build
  bus/pci: fix minsize build
  power/intel_pstate: fix minsize build
  net/bnxt/tf_ulp: fix minsize build
  net/iavf: fix minsize build
  ci: fix debug build type
  devtools: test different build types
  ci: check minsize build type in GHA

 .ci/linux-build.sh                            |  3 ++-
 .github/workflows/build.yml                   |  2 ++
 devtools/test-meson-builds.sh                 |  6 ++++--
 drivers/bus/pci/linux/pci_vfio.c              |  3 ++-
 drivers/net/bnxt/tf_ulp/ulp_utils.h           |  2 ++
 drivers/net/intel/iavf/iavf_ipsec_crypto.c    |  2 +-
 .../power/intel_pstate/intel_pstate_cpufreq.c |  2 +-
 lib/argparse/rte_argparse.c                   |  2 +-
 lib/eal/linux/eal_memalloc.c                  |  7 ++++++-
 lib/eal/linux/eal_memory.c                    | 20 ++++++++++++-------
 lib/mldev/rte_mldev.c                         |  2 +-
 11 files changed, 35 insertions(+), 16 deletions(-)

-- 
2.52.0

