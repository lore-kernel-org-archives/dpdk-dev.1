Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776EE6BF2F
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9338840274;
	Fri, 30 Jan 2026 18:10:43 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 8D3894025F;
 Fri, 30 Jan 2026 18:10:42 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9DCBF7A012A;
 Fri, 30 Jan 2026 12:10:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 12:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1769793041; x=1769879441; bh=jmLZBRc8kJ0Y5Y6tWSwvK
 XXY5IGPOcOsxzjRuTwa39w=; b=Iq5TlFzKnxUv1ycxR7Z253si9aCiElz0YqaXz
 GH78vHMLqHGHQDn7oTyefmQEOUZzraggim9EHQP2sy6q6NGW/U8ZoN3/8vNAzBZe
 i27P7UthTJnVsL3nkVcTpteSp2uyukf4QjPnL3wxHPlTJh/OnJ2KB1XnW3wOSJpy
 mjhUV8jBTmwzC9dN1cyGOZJ7hYGOx15lBUu3pKBRqBf5BU0Dn3wBoOBbl3sF97BB
 R21AwtPvV29MKjWv/g6Af/ke5pNR/ImEKq5Hf7dPoEnS+9R80YACHLfYSiif5FcF
 rBTCHoBF+ptlAexOWhIUBIb40bGIz6vEKRM0ig0iRKHKpVIEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1769793041; x=1769879441; bh=jmLZBRc8kJ0Y5Y6tWSwvKXXY5IGPOcOsxzj
 RuTwa39w=; b=Oqwu40veTyNcbSCPfqXGKWjR/6j4OVEQKv2j9Flpaabdh4iX8cE
 df1HDwU0qgMCLXA8CLXqH6a24y6BC5SsE8e32o6pBv6F9Wd86ZSkdDFw2/Lm0b12
 /6DCt7rJNEopDVrSkBgtZvajI30cjQBb3Ae/2ehft3h3Q65xnCa2WM+c9b2KKw7D
 8doVqa7axURlA48jw6GsQOmiSopfWc9gj5bO+PKo05+/XnpbNS0cR9goc4kLzdmR
 TdqItmItITzR3xy5qmUXCqAwx+nXBuJLkJPSG78pToya02P4R9tMLjhtCHvZa6DE
 GqVkTtY4rr7RSKXHu/oOIPz0GUxyfsvVGXg==
X-ME-Sender: <xms:EOZ8aUWtzB9dc0WfJFh6_zuKZXutgy9iYaLfJAHHviRWqEw30fxcUg>
 <xme:EOZ8aTjjnY4w1fTEz3-aNVc3l9vp1i9WtGE61sUGgjLm4xWLQYmqSZXjPdthDAvXS
 vTYnyYMe3GwJ2v6OwlqAU6w7hROzZhnHJQyB-F0nE4OjQZ5QY32aw>
X-ME-Received: <xmr:EOZ8aXaFBqkb3rbHbXESclJM6pcs1tOYvrB_h2PBOALXggXwP0h30TFLRrVUrb8CN972WXHKh-GRxdBipxnqCxk_aFTFfcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeliedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheprhhiiiiiohdruhhnihhp
 ihesghhmrghilhdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhigv
 vheshhhurgifvghirdgtohhmpdhrtghpthhtohepshgvrhhgihhordhgohhniigrlhgvii
 drmhhonhhrohihsehinhhtvghlrdgtohhmpdhrtghpthhtohephhgrrhhrhidrvhgrnhdr
 hhgrrghrvghnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:EOZ8aYrbRC9l1Q54kFGN7_wCEkjI-RLg5CUiRfk3sZWCB9sBwuHMRA>
 <xmx:EOZ8acNRC_hgGa3w0AjMklB-Lquag1w0c5HGYKLnWVbVCrvQiyx0sg>
 <xmx:EOZ8aTpwutBjFnQzsgOs-S6drz_m9MRZHfQ2eIjFlbYZPYPvROpptQ>
 <xmx:EOZ8aRe5YmneXEn2oQ-IejbC6KXpJtZGN-F4aZvV8YuNoD84xwXt6Q>
 <xmx:EeZ8aV9UtWXOydxs4rYiKtwjFccb8idqdvacgLJFHsEdmQ3xXT2bNg_U>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 12:10:39 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Luigi Rizzo <rizzo.unipi@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>
Subject: [PATCH] eal/x86: fix TSC frequency query
Date: Fri, 30 Jan 2026 18:10:26 +0100
Message-ID: <20260130171026.277418-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
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

After getting TSC information from cpuid instruction,
some values must be multiplied and divided.
We must multiply first to get the most accurate value.

Example:
	before: 1000000000 * (23 / 10) = 2 GHz
	after:  1000000000 * 23 / 10 = 2.3 GHz

Bugzilla ID: 1869
Fixes: ad3516bb4ae1 ("eal/x86: implement arch-specific TSC freq query")
Cc: stable@dpdk.org

Reported-by: Luigi Rizzo <rizzo.unipi@gmail.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/eal/x86/rte_cycles.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/x86/rte_cycles.c b/lib/eal/x86/rte_cycles.c
index f147a5231d..e8e805e710 100644
--- a/lib/eal/x86/rte_cycles.c
+++ b/lib/eal/x86/rte_cycles.c
@@ -145,7 +145,7 @@ get_tsc_freq_arch(void)
 
 		/* EBX : TSC/Crystal ratio, ECX : Crystal Hz */
 		if (b && c)
-			return c * (b / a);
+			return (uint64_t)c * b / a;
 	}
 
 #ifdef RTE_TOOLCHAIN_MSVC
-- 
2.52.0

