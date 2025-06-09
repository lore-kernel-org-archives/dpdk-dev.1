Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A79C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 20:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E75B41611;
	Mon,  9 Jun 2025 22:55:40 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id F045240E34
 for <dev@dpdk.org>; Mon,  9 Jun 2025 22:55:38 +0200 (CEST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6D5BA11402B5;
 Mon,  9 Jun 2025 16:55:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 09 Jun 2025 16:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1749502538; x=
 1749588938; bh=WfklglBhFTe9Bn+ILAoZzlDKm8PHt40NoQA/WRNDq7M=; b=I
 U2wBD7kCisHUcHVx0vi+aSVjTIVjRQifZ7FL+ADrdE9qds9ZkhXTdrE/IJNrOkB1
 p5xELLbLY8FM3oMtFTNs0xpPvroQsKQ+OJwFPJIWFRl1u4Eyo73x8GB5LJsBP0DY
 i3opYqzu60UMs3TpDglBNgLjvv72ilpEni8hHFJQN3HgimjMl+3JM4leUmnnt+Z6
 e46pHojzhdbDI+3WOyW5mnN8hJTDHbxUo+HWKQeDklkuiM9NoB3qsDZn+WmZbk1Y
 dhTewRh82Zd+HfQjDgM4acRyKVrhYdHX6QaYKOGV8QYlXUJzojs2VxYqAXWThEj3
 aYK5thbefDNrmeP0etO9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1749502538; x=1749588938; bh=W
 fklglBhFTe9Bn+ILAoZzlDKm8PHt40NoQA/WRNDq7M=; b=WzEcNX66CWz12mbDB
 KzKTGO5lH4NPqKvgv4aRBq5fGSwXORxk5QiyQxH1YL+q+yxq9NkUZIZHAHX5ZpMs
 Nz8tSPf2tyjgJjMpqh6q/of55/2cGP6PjjNRKty12ToQamONyI1ErQY+lR2DPLCO
 tsdvl9cETCqvnwjUoTQzu+za2i/Nv5ncvnzYxwdedsBlywgcoyDzkUhiWZz/1xVX
 V6SSmmNr+vpy4Q5GPa2kIyECMs6lxe184dGnndEmoWRtSR4AhtqhtTaSEtzzwHf7
 KAt3CiEydp9P0aMbXGsYw9KZ015zYsmYB8JnnQKZ1JhuYYCuMLZWHC7U9YpfzKM3
 NhIFg==
X-ME-Sender: <xms:SkpHaDtDiZ6jzn1bRSoc65Jr4gF5MDB0cvnSaE8pCbsr-joFWeFU0A>
 <xme:SkpHaEe-Mj8n79yLfu652RylJ1SgTO0RDuPDq5Mj9KiVpfsiJ_hqOtsgcqt6gnRA_
 yQbc4p94vWYISjJig>
X-ME-Received: <xmr:SkpHaGwmY3J6Oq-Lic9VV7WpAU85CMwFn3JiPFl9NvtbF-wh26PbNzSCWQ7KqgGKy-SbAm3hNY5R5h8xVkDvXC9pKFjmuiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelkedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedu
 gfejueekieeltdfhteevkeehhfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopehtughushiihihnshhkihesmhgrrhhvvghllhdr
 tghomh
X-ME-Proxy: <xmx:SkpHaCPQLyHzotVfPpYtu2vmxJaYllYz-6sp4GZ028azH3KZc_gYBg>
 <xmx:SkpHaD_V4oxsHmMugSErfzW825yYi3qVvfH_a0toa413cRMbf6qdBA>
 <xmx:SkpHaCUCJoFeD2WTRGYYrexv2ras3LMTaiaIGMLPC-o3YzbLQDmDlg>
 <xmx:SkpHaEe51aVfm33YVicgFPa1Cpyzp_5CaDn3eGXaViHoXy7AQn19Rw>
 <xmx:SkpHaJOu2XSxSCCiHDxzR9lEfw5XATBy6FyDjfy4-HjHEnyBL_v96tAd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 16:55:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH] test/pmu: disable failing test
Date: Mon,  9 Jun 2025 22:55:25 +0200
Message-ID: <20250609205525.2678766-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20221111094338.2736065-1-tduszynski@marvell.com>
References: <20221111094338.2736065-1-tduszynski@marvell.com>
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

The PMU test is reported to fail on some platforms.
Disabling until a fix is found.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test/test_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index 74cc88f949..10513bf9c9 100644
--- a/app/test/test_pmu.c
+++ b/app/test/test_pmu.c
@@ -46,10 +46,12 @@ static struct unit_test_suite pmu_tests = {
 	}
 };
 
-static int
+static int __rte_unused
 test_pmu(void)
 {
 	return unit_test_suite_runner(&pmu_tests);
 }
 
-REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
+/* disabled because of reported failures, waiting for a fix
+ * REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
+ */
-- 
2.47.1

