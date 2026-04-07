Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC6EDB7CC
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 08:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB66F40669;
	Tue,  7 Apr 2026 10:06:27 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id DA89B402F1
 for <dev@dpdk.org>; Tue,  7 Apr 2026 10:06:25 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8853E1400286;
 Tue,  7 Apr 2026 04:06:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 07 Apr 2026 04:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1775549185; x=1775635585; bh=MoaxrXHyepqLVXpnx/GaB
 DQmCyTitT670sCsqqHfoeE=; b=NfHrXgy0a4VODAVTO+pRdHYtuEU8CHlX2h0Bk
 0oGHK3duN4z4o5NicN3/U9rFDYQ2/ku7BVVvDYwcsZ3L/mdMV7EDmxWZfES5rcnh
 4C1/pjEggugPUfq4CThQS1h+S93tr6nqMY/s6AzYDjGT35zu5xu60VgK/0ANGhWt
 8cJuNomfpR8Jj6ksh+WZQE+UqnLKaftp0frYWuB9rLhXee6S5QBAqRXYqf7J4eZ2
 YzQK+GgGhvWSRI889J5VJjxYOP+O8MzXpBuJ22x1EhNlAsnOwokOC8stc4D8YZvX
 X3k2CJMbSGaJ52HIpmDgCKICQAX8H2FOjYCCRo9fGJmXxjwzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1775549185; x=1775635585; bh=MoaxrXHyepqLVXpnx/GaBDQmCyTitT670sC
 sqqHfoeE=; b=bSpLDV+tqTji44XcFsS3FxfIBiRgJhF5iOeqZDX3CNVU9rVmB3v
 2ScFyKB4Qh38dixCDkHUNl3PLdcB3Nn3i3XrwOfOxPARwiiNMEySWbOXSTn+IPuq
 ECUO5OSq4n93iWD6xzXHMgkPhUDNVvhEXxqXn1SOECYyHGtv2tOSS60nIjt+7lJr
 t/gzwzQovJ3eNFYQxv0nk/2TZ6TWSoRJQIAy8LMW/5dLwIu3lWbuMGxiFtQ44XcD
 9O1qyRMtwGb4GR9d9pY/B6siiqKPNNRNo95Lk8ojlZRPZCI9ui7haaBShrTrzd/A
 clMYXheI5RQpru1FvCeLJBg8ZacoXYjwzEQ==
X-ME-Sender: <xms:AbvUaQq4V9nVvTICGHUSEco7oszZa5iKNWnA-8kqlwrbxx67xpMVkQ>
 <xme:AbvUaS9FlXBgxC_73TnqxHd3xsAe9ZAutyAABw8rinwFggI8D6KwmjXBGUbVMn5Kr
 sOWfKb163chqyNnMTfpJRg8y1MnFfu9gt-FbSqSyo0e4nH2vLfc>
X-ME-Received: <xmr:AbvUaX-4CaQEuM6ExT6UbJXkA6vocEVkmRYyjNqhh-7b9xJBZrmz59Ye58ZCSKuYduu8IFTFp2qbNTweSQI-3jPNRCO7IZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepvdetgfffvdeuueegfeehkeetfeelhffhtdejfeetjeettdetgfdthedvteet
 heeunecuffhomhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvg
 hvseguphgukhdrohhrghdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshht
 vghmshdrtghomh
X-ME-Proxy: <xmx:AbvUaZtHjaOv7AzxVoEr1AIa1yG8EgVA9sTqVPC_dJNT3SU_c7xI5w>
 <xmx:AbvUaSq1qTLJTGxP8rlloq3BFCksDAFy__mYT6XugwfuezTvV5FPug>
 <xmx:AbvUaeknmKEwlnYB8_5rda5N99ca9isa8CR-gWpMXuAZiQYaYsYHuw>
 <xmx:AbvUaezRNkTLng73uCp7TLXK-ywVJYioDAkWyvcPmdDVzMrI_P805g>
 <xmx:AbvUaSLK79DqOCa0f0wklCDNW5MKBdhU6qmxzRhnj4TrKChbbeLYfDGV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 04:06:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] doc: add link to mbuf layout history
Date: Tue,  7 Apr 2026 10:05:44 +0200
Message-ID: <20260407080544.614206-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.53.0
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

In order to illustrate how mbuf is kept small,
add a link to a page showing the mbuf layout for each version.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/prog_guide/mbuf_lib.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/guides/prog_guide/mbuf_lib.rst b/doc/guides/prog_guide/mbuf_lib.rst
index 382bfbdca4..97f8e72356 100644
--- a/doc/guides/prog_guide/mbuf_lib.rst
+++ b/doc/guides/prog_guide/mbuf_lib.rst
@@ -8,11 +8,12 @@ The Packet (MBuf) library provides the ability to allocate and free buffers (mbu
 that may be used by the DPDK application to store message buffers.
 The message buffers are stored in a mempool, using the :doc:`mempool_lib`.
 
-A rte_mbuf struct generally carries network packet buffers, but it can actually
-be any data (control data, events, ...).
-The rte_mbuf header structure is kept as small as possible and currently uses
-just two cache lines, with the most frequently used fields being on the first
-of the two cache lines.
+A ``struct rte_mbuf`` generally carries network packet buffers,
+but it can actually be any data (control data, events, etc).
+The ``rte_mbuf`` header structure is
+`kept as small as possible <https://doc.dpdk.org/struct/mbuf/history.html>`_
+and currently uses just two 64-byte cache lines,
+with the most frequently used fields being on the first of the two cache lines.
 
 Design of Packet Buffers
 ------------------------
-- 
2.53.0

