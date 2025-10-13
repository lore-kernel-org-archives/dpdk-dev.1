Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C971FCCD185
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 21:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB8764042E;
	Mon, 13 Oct 2025 23:20:31 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 3C933402E5
 for <dev@dpdk.org>; Mon, 13 Oct 2025 23:20:30 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 7A5131D00069;
 Mon, 13 Oct 2025 17:20:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 13 Oct 2025 17:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760390429; x=
 1760476829; bh=OPCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=c
 LUvrSWngsJhSoEz+aJo7vOFPX+O9UX3C3jILZuXi6YYLgO+MvbKs+wklM1nSwG/d
 d7+lrKTW0vTF4o07nkdLnGUBQXCZG4H3HQcHEpq0e3NO7BKWu6UewZ8FgB3pdyfr
 G3Ih8tnUrbHxQ7KOuOZ0gzp7Ec6CryW3V0CV2knPcbFdoBZYIONfNe8lDMb1cIWW
 UapJ7xBSOEtnjxhei+05t2p7sVAtZ58sNM2lc3PD8zsgvWcpnjBOm+TurQp9G4aY
 85EHkYpY9z8def3QWzP7jtM1aN+zlX59mmOcQZjbHFQC8Tp4kjLCFxJuiBhb8jVN
 /tKIAT4gtTuopCwdwZ/vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760390429; x=1760476829; bh=O
 PCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=TLjqMU39ovoNRS3hA
 ZBJvBae5MTt+seOOT67NFMCMIXuqCEwb4GnqXriqLlWVRJuZAud/eJM/54VMg7JU
 EgFxSsQiLURTiLSxx3eqDr5wkpuEGKKU1hdYdKdcgO4x2LaPEsULMbRCl2Op5izi
 QQl7c2in+gPrJLQRQdyfLfTrljENCnzM9bu8j91Bj9Wdm0N0cuXNP2XhmO8dITqJ
 1Mn1WbR1hAtkovLBw2+ubGwaUmni/Fs482l3yxytdt5CGbC81USWHVV3s7JuH7lS
 ZHf8+APfslANEU3vwomJNhXfMXkdhfVJN/NYqv5mzBOnF5XBYBFUChQY7rZ/vieo
 JDzFQ==
X-ME-Sender: <xms:HG3taIRtKcGIbq68C_QvwjcK4AZjSkb3si6USwYDNVQn4mgPs2LsbA>
 <xme:HG3taOuStOjhU_JNlEbGSuKLp65UbeSOMnpf2ee91-u5j1FtDmwP5GgT6sFk9gx-t
 9NwJvss4wqXIbyd9Vwg9oG8LzBL27UmzbgkldMsSTI36jFDjbi_jQ>
X-ME-Received: <xmr:HG3taBb4vuGkgMI5EXEKFPQKsBRGRV6y81LnNkfxoHssybHUNIuh9pehDvncZZGZXWp6cns0_6MwDjZPj5iz2dCSc7NdwkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekjeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhhphgvrhgvthiisehnvhhiughirg
 drtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdp
 rhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprh
 gtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtphht
 thhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:HG3taMGm7HCFxPL9T2pz07iCNMb9mGUR8sSTJeIMKdyNcedgqQoPVA>
 <xmx:HG3taNzAQxOFg7V5UxrdLuzGch5QWrAVMYSczyqVaaY3GkOtFQc8Tw>
 <xmx:HG3taGk13InVf5U3xresUdkWKxlu_wSKwygs4kgEekuMmhwDe5Z1iA>
 <xmx:HG3taOniADxWxb87g9oEtxj6XGf1v-rP0R2zh3qtrwQKyBoxAeuk2w>
 <xmx:HW3taE_kIr_k5-gzep7uk_TkDiNVclsM34-bpwTdjAOJGEXERg0cepgl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 17:20:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v4 1/7] doc: explain debug options in mbuf guide
Date: Mon, 13 Oct 2025 23:16:01 +0200
Message-ID: <20251013212019.892032-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013212019.892032-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251013212019.892032-1-thomas@monjalon.net>
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

Mention RTE_LIBRTE_MBUF_DEBUG and RTE_ENABLE_ASSERT
which enable many debug checks in the mbuf library.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/prog_guide/mbuf_lib.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index 4ad2a21f3f..badc0f3501 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -266,8 +266,13 @@ can be found in several of the sample applications, for example, the IPv4 Multic
 Debug
 -----
 
-In debug mode, the functions of the mbuf library perform sanity checks before any operation (such as, buffer corruption,
-bad type, and so on).
+When ``RTE_LIBRTE_MBUF_DEBUG`` is enabled at compilation,
+some major mbuf operations (clone, copy, freeing)
+perform sanity checks (such as buffer corruption, bad type, and so on).
+
+When ``RTE_ENABLE_ASSERT`` is enabled,
+more basic checks are done in many functions.
+
 
 Use Cases
 ---------
-- 
2.51.0

