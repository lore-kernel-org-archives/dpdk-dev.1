Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C58ECD997
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF7D74066A;
	Thu,  5 Feb 2026 22:31:09 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 07A2E4065F;
 Thu,  5 Feb 2026 22:31:09 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id B4016EC04F2;
 Thu,  5 Feb 2026 16:31:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 05 Feb 2026 16:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327068; x=
 1770413468; bh=L9GZV2Aqlx/mCiUxnscwOMHCH9xK1dkzMdhWXoLjyok=; b=h
 nOuYFHbzYu5gXf9whKGrTO4R9nYw1xJhPk6XAEi4XSC94Pqz4JZIPE6Vz+nINq2n
 vSE8nGRJAB+ZM2bft5OJTWXaPqrOidLVfvHXcAdro96oA8GsJg40nsWp+TSk4LA6
 VwZz1XbE7OwKl1ZBooGOcJrTZ46eC+pQrFV2EIb5Dq4SZ8kfx6zFb8wxlA2r11NV
 1leIfbAL9/LuLBak4y3SO9s6oBQnmKecGk8PlUwfhYFgzDzWF31H2dkBH0YNaLka
 mCmJodk2yRz/d1UtqpN4ZbtLM/+HP6/0m5Fueg7S+uoylXuaK4uSVkN1edfmyyPi
 SUoWNSUvLYqWX7q/Yf+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327068; x=1770413468; bh=L
 9GZV2Aqlx/mCiUxnscwOMHCH9xK1dkzMdhWXoLjyok=; b=eXZYEEb/ak3EHiSXo
 S0SuGUeeapknFD5UTLv7lnlxrLD7Fkik+qV0vQXCgmxVtJBnxl5prLM2H30geYz/
 phoPYZuApq7sQBIFHwvukpAKRsNzbzwFBgEGatDQ5SHuurunj0eCGggK4YuhVXCS
 E9+i74uo1j0FzD+xrEySQqSF4g5xjgXyxpupcpxBQ7APqilhCjvLiJP6WWJdNPn2
 3iZrrprdJAYJIItEFzLbch/gLKzsKcoL9B6SA/VcRS/nCc//dBNf/U5t8+mjQ2tu
 u8zm+2EP452f6N+3talPJKBZD5l435Fk3YvTuJ1r8Ns5BWqdgrP/le4BspOFnFCO
 Q4EJw==
X-ME-Sender: <xms:HAyFafK-4XsKqk5rKtHhjGoNuCj8TUQJnJ-c--z0U4PoyluMu_x8dA>
 <xme:HAyFaTQ6VX6-bbBTOfqccrwChMdV9E6ILNGN_vmaPUceWvjgEVIGsMVXZPTXzWvnH
 Cf5kxUBmq0J4s8aV6GP5zgzlDh3Vwve4_Osncbg6NTUEJ7tvsOqHA>
X-ME-Received: <xmr:HAyFafqJV4qtAvHDeYXzqkR7STWaD_56G4NrmsmaYV80v4wHR4ImxJKLN-PDkIT43UaU34iyryY2BqSOW8LTvy-DOfPWrQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegrtghonhholhgvsehrvg
 guhhgrthdrtghomh
X-ME-Proxy: <xmx:HAyFaQoc4-4xgkwPn3GFTKgGnDFUxkrr2p-940mm_oepc5sQAOewIA>
 <xmx:HAyFaRP6BbXbOHzEHMH6h2phSI4JEwldwjJqwdRNZqfLgGxGaOF02g>
 <xmx:HAyFaRya3E6g2MV0rKvxatDFEdfV7PkgpQ0mUzi6mIynKyG4hGCRuA>
 <xmx:HAyFaav7c822g1TCY-znrTYTlVmgFBUay5_R97aBx9FEJDANfUGGvg>
 <xmx:HAyFaQWZyGmpzscbRDIEmF84SpNLNzYHbHH_xKvhRLqzQK6bacYJ-zqR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:31:07 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, stable@dpdk.org,
 Aaron Conole <aconole@redhat.com>
Subject: [PATCH v4 09/11] ci: fix debug build type
Date: Thu,  5 Feb 2026 22:27:41 +0100
Message-ID: <20260205213044.702908-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205213044.702908-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
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

The debug build type was overridden by defining it to
debugoptimized after debug was chosen based on an environment variable.

Fixes: 918b6674b841 ("build: support Undefined Behavior Sanitizer")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 .ci/linux-build.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index 084d9642fc..aac0bd3dc5 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -128,7 +128,6 @@ else
 fi
 OPTS="$OPTS -Dlibdir=lib"
 
-buildtype=debugoptimized
 sanitizer=
 if [ "$ASAN" = "true" ]; then
     sanitizer=${sanitizer:+$sanitizer,}address
-- 
2.52.0

