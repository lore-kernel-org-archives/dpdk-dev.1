Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E59C83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 22:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D2D040150;
	Fri, 18 Jul 2025 00:09:31 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id D42A04014F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 00:09:29 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 194857A00F7;
 Thu, 17 Jul 2025 18:09:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 18:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1752790168; x=1752876568; bh=UGKpmCXdFN4Sv5F9Oe4YL
 6zOMAAUIpD0hn6XnUUFcSk=; b=lbQfO/GKCM3DCojOe32sp68yqSZ36lnLnWxUj
 OKQHWdtjN7cJREIT/TL4wg83A5jcIxCgGmxQKpILkQM5MTPvsfyo5i59Kk1WLcNE
 xwKBNe4ypJ65eV1zLRpNqqbFNFXX1Hxu4yzqScKoijLiksSV7plmjKWVypn6OFAu
 u+otjwzF5Zx0GZ5FTbg3JiIYirr+YXHX2lZFUbesHTq6HCxT/jEU3yrGCHH4ipaL
 oF+Q77iMFPMCQBKJKc/sadmQ60EtC4VKGSW/NLyU4a4kwrGgdj77PnLrVmzaGqtX
 Bq/WkI7nO0flJ0lHWzmWLKSHZe1awu/v05L1+FPGQWYcKegOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1752790168; x=1752876568; bh=UGKpmCXdFN4Sv5F9Oe4YL6zOMAAUIpD0hn6
 XnUUFcSk=; b=L/GyKgknxpfIKtfOzaloMvsnNzjvMmH06qCNstrCTO2SxbINuk8
 LVf9sgJEt+f2jCEbOO+Xo2zfAFupvTvsR4JnI8RSzIMhgYuJr00QaQKojlc6XqEl
 /F9g+gE946XblojECcWAjs0XVUK1X3Vf0eeJ0m+qP9gp6M5quxlkxMz3A9SPFG3W
 f7AX3v0W9eIKL334r6e1QxB7rXkeHXwOpveSjx+Argrg4zi1XX7MgN9zegHE44FO
 E6piFmYRvBxNVi5NPHlqKujtPiCdaHfBhcJBLl7FmCd/bkRKvo8f76JsYWc6MrGb
 veUGErvqvrKzwSTShaRCOUSW8YyjpkBCIGA==
X-ME-Sender: <xms:mHR5aEfBm1VU03pK2bGYDyKzz-iXt83GtYspmtifwUftPtl2F3k7Gw>
 <xme:mHR5aBfiGyvqDKf7M9SvwhnxtsOmMRUh4Mtz9Vq8zXGbmHGDnIHTARyxnrImTE5eT
 xDw6WAfUBKm3_mWlg>
X-ME-Received: <xmr:mHR5aGIC1G0dHZ2R2VEGjVeVhM3d_5EGftdg_eeCpQyztq9brHiGRzgNX-ZOrLGHVNuH0qaToKK81BZtx9lpgPqJLcsoVVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
 cuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgr
 lhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdelvdduhedvudduveeuvdevheegud
 elgeeigfejheduhedttdegudffjeeihffgnecuvehluhhsthgvrhfuihiivgeptdenucfr
 rghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnh
 gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:mHR5aAJ74-dH0zytIvegNYjmNlc912Nhl7OGxOFzOKPqjk6ANoNWiQ>
 <xmx:mHR5aAGtrKZ5DWSsBQDNL6VpqLFnC_DedimOjIGGhPn0bb_BvUQpcQ>
 <xmx:mHR5aNmEBRe34298c8QWiESpInOW8sXooz-tOb8FbKe8Vl-i95AD3A>
 <xmx:mHR5aFJzayojCIPe5WdO-x_C1uVuHuNzubobkQX9OCxUXAxcm0DGMg>
 <xmx:mHR5aJfxsBZvMFnvyoZDrhY2hRSkZwyvj0wGlxf4vq3ovGEXfsA0cwIE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Thu, 17 Jul 2025 18:09:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 0/4] rework mlx5 guide
Date: Fri, 18 Jul 2025 00:05:40 +0200
Message-ID: <20250717220912.376503-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

The main mlx5 doc (for net driver) is improved
with better explanations, better organization, better readability,
and will be a better skeleton for future detailed explanations.

Maayan Kashani (1):
  doc: add testpmd command examples in mlx5 guide

Thomas Monjalon (3):
  doc: simplify mlx5 devices lists
  doc: add table styles for guides
  doc: rework mlx5 guide per features

 doc/guides/custom.css                         |   42 +
 doc/guides/nics/features/mlx5.ini             |    1 +
 doc/guides/nics/mlx4.rst                      |    5 +-
 doc/guides/nics/mlx5.rst                      | 4802 +++++++++++------
 doc/guides/platform/mlx5.rst                  |   48 +-
 doc/guides/prog_guide/ethdev/flow_offload.rst |    7 +-
 doc/guides/sample_app_ug/flow_filtering.rst   |    2 +-
 doc/guides/vdpadevs/mlx5.rst                  |   16 +-
 8 files changed, 3334 insertions(+), 1589 deletions(-)

-- 
2.47.1

