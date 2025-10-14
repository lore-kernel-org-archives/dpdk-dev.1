Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF290CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:05:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACD9B402DA;
	Tue, 14 Oct 2025 09:05:29 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 172B0402CE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 09:05:28 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 9A7F7EC020E;
 Tue, 14 Oct 2025 03:05:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Tue, 14 Oct 2025 03:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760425527; x=
 1760511927; bh=OPCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=Q
 fInyd0mdNZ8Dovvtc0Jf/FAvFUDSI8HN7lNtp59Kxqfltop3HBtJZI130PJg2rPr
 T12xZr2c3RUm6nA3WByy7yj4Qw7Fcg0hd3v3v7Kj4jwMwuAxEXFhQKUEUv5T4VGu
 X7t+9uBEYnrVQCBhZvRUf2LJplyGfPzA8lW6JU+fq7qnkRX6fCqltguARVbtpSQX
 xwRjQqtFXvbraCY24BY7zbwrWb8G4RtdfJUG8UvkaLBKaUx3co73PPcY28Gf0RsE
 Yc02dRu/sUJkIXMZfMtYtX4Elw7CFEMcGffDrr165eHj6dOD1oyHdCBqt0mihkHs
 9V65NDy3g2wUhaVc8152A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760425527; x=1760511927; bh=O
 PCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=ZUnKfsdiuU6k0HH1g
 ucSm9Dbh+Gihk70EaIsoUQas8WwOF1c50njei1ZKm+HCT/uHPQ2Xt/3s9BGm4tug
 /kgXdPv0O+HlbEKWRPR/PSi4cUSR6ODQvBru2bkPDky0XCdzh0zq+h2Aq5LE+085
 2X/zy2TSBlOUoCREmL3TRndXJHqW5DMo1Ear8YgMaWhz0uKADcEoMU895Pgc33/A
 lV4vJzzdrYjaP0qqV7+ixyVSHwoOWoPRjEFF24fpZ/Jp3O1J+/t2Bb3nAmPgIkG3
 2EN+y+KkraOa/IY3HvGde1cPrMWRvXrQRRSoVC4mn2DQ1LnVe0xBTtdaygtpv4si
 CwDIw==
X-ME-Sender: <xms:N_btaO9Vvk5o39_AV9AaH5iE-QgYDkJMSwjQKivNXqFE8qK_U-sV7w>
 <xme:N_btaHqqjwY3ebsYp_a7J9_Bf_LQqeG6zuCRBPHUXAxGUsEsLoYKaenLI5jJq-VI_
 5sw6wCQesI62v02C63Ma8gsgg8sQQEW_DEmVnaH7Xtm7uBunogh>
X-ME-Received: <xmr:N_btaPl5Bimsj9MpOpK10d5Kw8k3W87LQbN38VhPSFVLFKAWdBgwKK1BEMp4yrXCPRna3uy2LJT7VGSukGGDEWg4XxM4n3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelkeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:N_btaGjmVKCZj9ZcHbBvGNw-ZBNh0x8cxFJOAtptGFujobzNirZSJg>
 <xmx:N_btaPfkymst7mSDMSxVEm_BquyNmUBtoTZIV6110ztBTXxQ_GhNlw>
 <xmx:N_btaOjWuljQOFRc-xGboKhjhATD75eMi9pDoKkJ_gTISmMNCVV4fA>
 <xmx:N_btaPy_91i8wQjzoLxDjor4WLJ54ZgHm3m956AlotaWm7F2uzYLKA>
 <xmx:N_btaCK3dtPKbyg2it22zhaM1LAYEznzR7pR8tlO_kqyahVEJhQ95KhP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 03:05:25 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v5 1/7] doc: explain debug options in mbuf guide
Date: Tue, 14 Oct 2025 08:58:29 +0200
Message-ID: <20251014070517.922137-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014070517.922137-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251014070517.922137-1-thomas@monjalon.net>
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

