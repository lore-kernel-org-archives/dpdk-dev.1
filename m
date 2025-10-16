Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FCACCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 20:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0528B427BD;
	Thu, 16 Oct 2025 22:36:08 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id AF77B427AD
 for <dev@dpdk.org>; Thu, 16 Oct 2025 22:36:06 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 45D23EC021D;
 Thu, 16 Oct 2025 16:36:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 16 Oct 2025 16:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760646966; x=
 1760733366; bh=OPCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=U
 +C4ibJ8mR/oHXZB1FqUkh+5JvcRFKGAh+WGF//f2OKzuECfcQxTtU52Ymk7N6Tho
 Vr8N4sHaWaDzSYlxhS42SazeGEmhgtR7+ZoEWqc9TF/9lTyEXBmzRbVJXj3Wr10g
 4ONvZHJSmr7JW7++G0lG8HdGfwB3ul94yyTKGwMsmspshe+Ow2bCkMl9DSAl43TK
 96WAd2+90rlSFYqzOKmZ2Z+M/ThnyZvVnP2PS60vHN3T0NH4MXlL8+duykXwPiiv
 zLSYBAE2+zIWSbU9eX/m5OPo1e4wH2dznSnXESWUmUH9V0zL89p5DzdCEFrMyhs9
 SwWZtdfAgrfAEhr7OXbPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760646966; x=1760733366; bh=O
 PCTkIemcIvX5KLzOpAqiVUD0gq930iqNCbK44namI4=; b=THH3t+IDtLfJy+RoP
 a/2dqN0BVPHqN9Lbe+vIOUc7e91PpAsqeA/Zfd8ciDnIMZ9/Em7vt3/m0fB6//29
 jsEMx5tNkQK7axes41A940Q5Nk1eR+0YQ8XWW5YjvFG0Bwa0T19lm0nyeNzLag4M
 /xhcA5ijDmy2Zey79d22ko/C8QvjSBvDaib3Keh1iLV2sNRVJjgaqHnpZQIZEymy
 i+pva+phgTG6q87iCl9ICoSHX6MBflT5H33ZbBBfvNg3HWrQhJlwWIH4VwXyuzRs
 Qw1UxB5SnFm8P3DrBiiwRHHnUATW9zk0A2I86nxrRZoXvhufrO7FIgdKuKPkydOt
 8R6Rw==
X-ME-Sender: <xms:NVfxaHLxORRXDZSrsB1TWdQ9zOWvGf6ITFSteivRRLODafh24Q3AzQ>
 <xme:NVfxaEGTrCAt6RHN8CJ_UF6sLIUgdIxiRP8ORLLvb7pGmxX9ZrD-76gFiUbY_YaqP
 mxZF_ywKkrBTWpuxoiVFrfO5YrKrBv33fg_qJHlqlNxgpOcvfUCKw>
X-ME-Received: <xmr:NVfxaLRg7Gl9MyxLfjsP_oF9NY1-Q3XY0i2QReMmdkAYff-lyYsVGJ5if4Pd3AtXSHtefpTxNx5Hbcj-6lAkhNF8PXWAi5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:NVfxaAcm6K1QqWBmsWEH6HBq7LDM8ZkUD08XZ6hiL7X2dTbb52Og5Q>
 <xmx:NVfxaKrVOQe5cvrAFgTNaSH3VuD18tJITdIKCOQMd2U156lUyCoRIA>
 <xmx:NVfxaB8lPFLgUm64Xf4DRFeccH0l5z8LQrTcDtWfksyNYs99Z_GxTA>
 <xmx:NVfxaGd3_42fLNzXMtOitxS-vzsTx0QzT5PLEI8adoD7S4ybfKkUvg>
 <xmx:NlfxaE3COmr3vw7k_ot4nY6ckhicdd6kMmSxM1VNyxc_FZ_X0sCrhydi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:36:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: shperetz@nvidia.com, viacheslavo@nvidia.com, bruce.richardson@intel.com,
 mb@smartsharesystems.com, stephen@networkplumber.org
Subject: [PATCH v7 1/7] doc: explain debug options in mbuf guide
Date: Thu, 16 Oct 2025 22:34:39 +0200
Message-ID: <20251016203557.2554678-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016203557.2554678-1-thomas@monjalon.net>
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20251016203557.2554678-1-thomas@monjalon.net>
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

