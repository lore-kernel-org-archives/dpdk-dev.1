Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE22C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 09:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F419C40280;
	Sat,  8 Feb 2025 10:28:57 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id B00D740279
 for <dev@dpdk.org>; Sat,  8 Feb 2025 10:28:56 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id B41D41140146;
 Sat,  8 Feb 2025 04:28:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Sat, 08 Feb 2025 04:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1739006935; x=1739093335; bh=2iK2qY/aT0TjJav7pOA5d
 6NCJSoaQpVYfqOLBl3Qy5g=; b=vLPZ4kCwhn/I3lAYRmG0hep72RBoWOSig/3qs
 CZsVpoZZl6OwvQGKu1+ENk1wxAn1DJzQ0mGMgUlQEug/rIJAIvz2Fd+YVPKkqZql
 +6TeU9AXiHjeTjKSKN0Nwee+D/lYSfx+0dtW7xUq72aeqQVyV+cJIDcjtJi6PaKZ
 2cbWW+yyMX/KteIN/rd7gGQ78pHdzuXiA3UP5sUHTtFYJsGnjvRsQ8Q5DBj4itoE
 1ljADpARipteAegu/bRgmaeugtzQWwAK//UdGapzZt6REVkzcNGe0FyvCJ0PpcYP
 vN4LBuFsR2GhAzhuPJVHFC5oOGpp1nG84HOloD5FFMDJlT77w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1739006935; x=1739093335; bh=2iK2qY/aT0TjJav7pOA5d6NCJSoaQpVYfqO
 LBl3Qy5g=; b=vO3U3clr5xhYxTD7c1Wc+PQLF3kVFJn3zU5+J7967C5vZDRjlji
 u56ASKvqq2LaQdkKzC9MTNwbyQAX+632Z8ICB7bnKF8dhs5cpZlAJ0i8sMtUiIlS
 jd/9G0g2lwix3O9PatTiMfMKNRgFTcUDHYyMggApwvR4ZIqF263cqPLjZV/ZNyg6
 krdcYmbqLlI6TIxkv96BY3SqnVluBi+kOrwM79jJ9N8f5ssALWca3JzwrlYEt/mo
 ge4ifVGyjNTctUrEFsDhUVgZFSycI+GOmE8RVvaayj7PEmbRQAcTEZS4uWVrqZdC
 4djX9YshZihXhdEgaw8lyXfyokx1EV3v/qg==
X-ME-Sender: <xms:1yOnZ0qOt4tfzRQGa7NJP9aWBX7yVR6bI9c08M3oF5vMIiXdH30c1Q>
 <xme:1yOnZ6otLAcf95bAOsHzMxypCBGdkKVwE0XdkyX0Bz7GgF8WZxWWioWrTQFsa9O-o
 7ExS1cJ0LmbrER7gg>
X-ME-Received: <xmr:1yOnZ5OF7jr2nF4qK-ipWp7wyHUmsM6DgfcPowqVZql6RwiRyeGOqhoJrxXnVvMQyRCHqq6aOI-YAyszqxQK6wzvqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudekgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
 hfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlh
 honhdrnhgvtheqnecuggftrfgrthhtvghrnhepveevfeevieeihfetudekgeekleeigeff
 ueekveduteeuffeiudevteeiudekfeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgs
 pghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesug
 hpughkrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhhshhesmhgrrhhvvghllhdrtgho
 mhdprhgtphhtthhopehlihhrohhnhhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhope
 hsphhinhhlvghrsegtvghsnhgvthdrtgiipdhrtghpthhtohepuggrvhhiugdrmhgrrhgt
 hhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvmhhuvgeslhhinh
 hugidrmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:1yOnZ75d-EUWJHb1HxoRU3-ypBEvOcyZas7cfUXCpZS2a2XQwjq3_w>
 <xmx:1yOnZz5iZFrR-NW7MpwMVm3QzKVy1vuJVTKEAw-ksCYl-le187KiCA>
 <xmx:1yOnZ7gkEIPEZgeHsD81yClnct8iahX1Vkg9xU4o3Bg6_yAIQUu-vg>
 <xmx:1yOnZ96DGis0My4zpW40Nz7FT7G_CeDgyr9r55Gu-nPa15TN9Sg7lQ>
 <xmx:1yOnZwsarc1v_FWeip23f0YcHdbGPuQqc9ELVkUBjyw-vi-QEXrnM9LH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Feb 2025 04:28:54 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Michael Shamis <michaelsh@marvell.com>, Liron Himi <lironh@marvell.com>,
 Martin Spinler <spinler@cesnet.cz>,
 David Marchand <david.marchand@redhat.com>,
 Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] drivers: allow build with VLAs
Date: Sat,  8 Feb 2025 10:28:38 +0100
Message-ID: <20250208092839.1238770-1-thomas@monjalon.net>
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

The drivers nfb, mvpp2 and mvsam use some variable length arrays
in their code, so the warnings about VLA must be disabled for now,
until removal for MSVC support, as in some other drivers.

The warnings look like below:

nfb_rx.h:156:16: error:
	ISO C90 forbids variable length array 'packets' [-Werror=vla]
  156 |         struct ndp_packet packets[nb_pkts];

mvpp2/mrvl_flow.c:108:9: error:
     ISO C90 forbids variable length array 'zeros' [-Werror=vla]
  108 |         uint8_t zeros[size];

mvsam/rte_mrvl_pmd.c:865:16: error:
	ISO C90 forbids variable length array 'requests_crp' [-Werror=vla]
  865 |         struct sam_cio_op_params requests_crp[nb_ops];

Fixes: 1bf86800f7da ("build: warn on uses of VLA")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/crypto/mvsam/meson.build | 2 ++
 drivers/net/mvpp2/meson.build    | 2 ++
 drivers/net/nfb/meson.build      | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/crypto/mvsam/meson.build b/drivers/crypto/mvsam/meson.build
index bf3c4323de..7fbdfb6ffe 100644
--- a/drivers/crypto/mvsam/meson.build
+++ b/drivers/crypto/mvsam/meson.build
@@ -20,4 +20,6 @@ ext_deps += dep
 
 sources = files('rte_mrvl_pmd.c', 'rte_mrvl_pmd_ops.c')
 
+cflags += no_wvla_cflag
+
 deps += ['bus_vdev', 'common_mvep', 'security']
diff --git a/drivers/net/mvpp2/meson.build b/drivers/net/mvpp2/meson.build
index c7da8cd2e7..396e382128 100644
--- a/drivers/net/mvpp2/meson.build
+++ b/drivers/net/mvpp2/meson.build
@@ -26,4 +26,6 @@ sources = files(
         'mrvl_tm.c',
 )
 
+cflags += no_wvla_cflag
+
 deps += ['cfgfile', 'common_mvep']
diff --git a/drivers/net/nfb/meson.build b/drivers/net/nfb/meson.build
index bb5f66a09a..d7a255c928 100644
--- a/drivers/net/nfb/meson.build
+++ b/drivers/net/nfb/meson.build
@@ -21,3 +21,5 @@ sources = files(
         'nfb_stats.c',
         'nfb_tx.c',
 )
+
+cflags += no_wvla_cflag
-- 
2.47.1

