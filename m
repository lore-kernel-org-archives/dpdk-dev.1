Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBBEC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 596264029E;
	Fri, 14 Mar 2025 14:43:55 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id B4AD1400D5
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:43:54 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1F97911400D4;
 Fri, 14 Mar 2025 09:43:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 14 Mar 2025 09:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1741959834; x=1742046234; bh=8P8Yx8c1ufHfwIfzVG0MI
 fmtlUNjpgFonHS2P/I1ZuQ=; b=Og9HYjaICZi19TU1VlTdXRtVp34rZ2o5xrvVl
 JJQG1c9nsP8uXig/Uu019PNSAMOztIIysaeDWGtJmOa2bym7ti45mrRWSVoOKMRm
 UJXPvaHQBqQkUtMM29CLFzDlB9fHiUMwBxpJ7L4JTzMY2DOjQSiZN5vtAkNP+w3Z
 VTvc7PffuTmHC6AG+aaPPEOxX/G3wat+44gAmiTa1R9htub9vSB2R1PMS3PQbaDW
 mJAQwJAto1+ucFdI+4l6PgzNDaWCuPaNTEqZcJaF5ikYue8FH/wS4VjqrciR8jxN
 6251aI6jWDuc/VdRvVeNZgJFR/nViJ/jXMaR//W6NOr0nAVdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1741959834; x=1742046234; bh=8P8Yx8c1ufHfwIfzVG0MIfmtlUNjpgFonHS
 2P/I1ZuQ=; b=mST5S1rSHD/gU8CoPYpqqLczN4nRUwR3D9utdzhDcifgUo0kBMe
 jHwqOB0RS9GnAvWxMxm3WJ+XGNgyssNF/U+OOYgyiXXBVJqXFvywwFdXXgl3tFwJ
 UtMDCzJI8kC/d7nRXoZq+N6kgPPD8pkxJDiaRWUjlBUpv5T/fdQqAWEoT5IXdRSF
 CmNnDM10USH0vkyY0GE+VFDuWYn5PVWBP2T2LHA9hdsx1j6ysL9+hT1LI4qdabp0
 HyLXYg2+HEU4qJ9KiimWIsDj8EQBoBH6Vb3NrFMWEH6hQ7Vb2zyH0CxhNN27u5mx
 dUvHNqTB5sLV1vOuZjQBIJkcN4hdaLeDwwA==
X-ME-Sender: <xms:mTLUZ83gbZm-AQq-wogMokcdz4kgx4rIORcR0LxPLgSr0azGO3DykQ>
 <xme:mTLUZ3EBs1YYzIAEffZtaPMN1NrwlVu7lCl4gXen7hAx-1ELZaTFUT2jBeFZo5J2z
 8cjVnKUZHYfgQregg>
X-ME-Received: <xmr:mTLUZ057DweLZkMKKuMXE1ezNxFUlBKdFOa94uy0YGWeHlzwEa22kC-9SQFYqqmOhBxAT69MQTgCHZtY6svFnyg0Ug3o5mM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeevveefveeiiefhtedukeegkeelieeg
 ffeukeevudetueffieduveetiedukeefleenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopehprghulhdrshiitgiivghprghnvghksegrrhhm
 rdgtohhmpdhrtghpthhtohepphhrohgssgesihholhdruhhnhhdrvgguuhdprhgtphhtth
 hopehnphhrrghtthgvsehiohhlrdhunhhhrdgvughupdhrtghpthhtoheplhhutggrrdhv
 ihiiiigrrhhrohesrghrmhdrtghomh
X-ME-Proxy: <xmx:mTLUZ10AK3-ZZGThHCZQ81Z_p6TDr_PMPePiiilmho66skvYn71bWg>
 <xmx:mTLUZ_F5ov929Oxmf_A0j-RfrLanRdUT2kO0Ob6Qq-bO7ur92SFuzQ>
 <xmx:mTLUZ-8Nz7r3VVM6SijZoBlJhlzncHmjcYap4lhXPxQkq5ewz7KhHg>
 <xmx:mTLUZ0k6nx3rhk0xBVztWokvwxfYb0Kvc6pc7h9Umk-bk6Cgz7YBLQ>
 <xmx:mjLUZwMTdq1jBizeT2ysSJjEObNlqhuMZQseN5vTGmUBvz7pVXkpenIV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 09:43:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Nicholas Pratte <npratte@iol.unh.edu>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH] dts: fix SPDX tag
Date: Fri, 14 Mar 2025 14:43:46 +0100
Message-ID: <20250314134346.3321517-1-thomas@monjalon.net>
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

The license in the SPDX tag was incomplete.

Fixes: d77a4a27bd24 ("dts: remove node distinction")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 dts/framework/remote_session/dpdk.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index f75ec353ed..d6533cd567 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: BSD-3-C
+# SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2023 PANTHEON.tech s.r.o.
 # Copyright(c) 2023 University of New Hampshire
 # Copyright(c) 2025 Arm Limited
-- 
2.47.1

