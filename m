Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0634CCCF9FA
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 11:53:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E18D5402D7;
	Fri, 31 Oct 2025 12:53:53 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id C25CF40150
 for <dev@dpdk.org>; Fri, 31 Oct 2025 12:53:51 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C2E607A012D;
 Fri, 31 Oct 2025 07:53:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Fri, 31 Oct 2025 07:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1761911630; x=1761998030; bh=j966U/bf4woq8PC151EuE
 NC6qoxpIbBxJzcLbhFDxl0=; b=VYVq4vl7rxdqmmHqJ2dYhcL8BU5x4pHpUuwT5
 BQIHgaekEkkEdGEvCY5NYCiX3PZxXtuQU4iNAh+NaaqpyiCFlN6Br1rjzdXDT6Yj
 jX8u8yA7F3tYjPR3+eAWGZKtBqKgVyRwZeuGUTUe5jRo3T8BvhkV5XA/7w8ZtEzt
 GDtsfsANK9KmPBKWnw7HI2Z4NwMGAMPVfS3VKetICFRbRtBq5NktO40rIBN3Fp/j
 M6t5BGetR+spiWSXqcBjGAC5F4ntwyKiNKsgu1n9hG0ycgLHx2tJswzTGRwPh3Yp
 HHGBKX6ot4wErTAee524CebMQ+uMCn9RNi4fJcLog67vjHYUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761911630; x=1761998030; bh=j966U/bf4woq8PC151EuENC6qoxpIbBxJzc
 LbhFDxl0=; b=APtoTjCTEnRvfDjV52v2oTdK77Gl7KreoGQzRdHFjicKrrhuTcY
 78bRnW7iPbBe9/zWi/+fM+DwMAT+Viypsh5H1iEKwBMVDso6tloP/y5agQBbYbVH
 m+b4OTOte7xaHHtQ/+NHxftQoAoOdLCSpEzTaB2SXTdTf40kwhebV8OzDaHhBCwL
 ddrzSocrsf70mAiDqH9exEP6UQQNuolHfAeQNevcQ50g2ItCfT9aw/vhSGftAs45
 //YmY+yg1ujbgIsiHg0WxVkvIYgly7m5O0kcErrbrbt1HiRGxHm/bY+6gnnUscYH
 6DE+TLzwRXaigT7oNmMcRhjGz85KjfguFNA==
X-ME-Sender: <xms:TqMEaQusOHRI4YrMsqcyCx2m2H33huNWDR-pSPXfBX3kL5ESWq52XQ>
 <xme:TqMEaZwPgkzGZRAIs4URpwklgZksREhse_Gy1ADo8_-msvoyg31pngoJNmxdRBSsw
 swFIoLb4pS3iqyrN1Yz_zcrKGQ3CZR4iij2TgkueyDMjGTFWklg>
X-ME-Received: <xmr:TqMEaejWNShmD9-P8YposOr5OGAknC83G-zOHbSZ-tdMPg-iBjd1AgFsa_z1GZue5nL7TGKY5NrfN5ogLUpwL67RLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieelgedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:TqMEaVCQdKTDLW8BgM7QFv3IYYnEKAe56aHtAijD2ruD6xjSjcjN4w>
 <xmx:TqMEaTtIUl0UBoXfzS80WT-WvV9zVvq0NV6kn2RfTOs7WiNJLM_xAQ>
 <xmx:TqMEaSYMLJEkAR1dnx4Qcq4236WrN5CArCwdY6vpbcKu6Xn9uXxb8g>
 <xmx:TqMEaeXNeXON4gfhx1XVm2sfMKHI41IWNL7lu_1noQQgoFNh406WiQ>
 <xmx:TqMEaa33GrBfTpwTRQcKMcXn7J7rooB-CI9-LV9mYoIsiYINgPPfO3WI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 07:53:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/1] doc: fix note in FreeBSD guide
Date: Fri, 31 Oct 2025 12:53:42 +0100
Message-ID: <20251031115342.4064625-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
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

The note about the prefix of the package pyelftools was not showed
in the documentation output because the syntax was missing a colon,
so it was considered as a simple comment in the source file.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/freebsd_gsg/build_dpdk.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index f98292bf41..a442473ec2 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -18,7 +18,7 @@ The following FreeBSD packages are required to build DPDK:
 * pkgconf
 * py38-pyelftools
 
-.. note:
+.. note::
 
   The specific package for pyelftools is dependent on the version of python in use,
   Python 3.8 being the version at type of writing, hence the ``py38`` prefix.
-- 
2.51.0

