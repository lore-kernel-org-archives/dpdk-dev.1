Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE8CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A9344067A;
	Wed, 12 Nov 2025 10:13:48 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 6AECA40678
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:13:46 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0B91714001C8;
 Wed, 12 Nov 2025 04:13:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 04:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1762938826; x=1763025226; bh=iuqa5BxSLndV8btOR7mxr
 2rjqkJOMHIPzubCy7ISX4E=; b=C7v3bi/xmVz/EYg0574GjNJ/7IM/kt+xgZ43g
 p2rUB/P7hFVKidvB6ERjVuHnW6oMaPGiHUYEEL+If/UlPEWffu1GrhbOH1/5r5c7
 ani58z1E+jqyvJs77VViF0hBYj05ln6geTDtR15hZiy9I5z1Z8yYMs49FZ5oKVAr
 QZO2MRmQ5DsMnHTmYa4lb7DnWVqvQJych1SEgDWuUiyypNiOfexhSdr7zxMDNX/x
 16SoskhwuNqPsRAxrM1NiUDCbBQ+pSNvEidrmR+bX977R3PIbkZBsnjSi3xx9y94
 UaAAAsbrmq9SkRCnUEOx3+ovhrr9jsha9Ts/yMmxXJiFW6dbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1762938826; x=1763025226; bh=iuqa5BxSLndV8btOR7mxr2rjqkJOMHIPzub
 Cy7ISX4E=; b=PLqWlCxlHkTa2x4ccpYxovNk6iVaKc2DByF3xwfzZ5kXvgqC/u6
 rxGALU0LDv2hNBqGaAQmvGv+MLGUsYhNAAcQJfWXrmg1/Qg9uTEDbJU12Y5Q2kYg
 wkK1cWhWeJJt+vGszqs4V16cEAa8pK6/C19cbvhDqcAcZg8wbIMUtFc0gS9ujI1U
 zl6HP2RgiEvG2zdD3HvmCJpPQmICr/jffiV0AsWyxxpPXxxiR5dSWQAexJDNQWWP
 fNWzxZpHH3zh8S6+f2gZILXM6nDPID/6rS2v7WhlmkkamjKyGcmf2q3m16XA54x/
 01ypl4CfEigKHJQF0ibhTt4Aq4UkVfMJzig==
X-ME-Sender: <xms:yU8UadSxjaAWch9DcCiOyNHqWqvHP2isln9u8OVZAryQisstrrSq8Q>
 <xme:yU8UaW6wGnw5SLvwXz-6zLMPh3_Pw-yPa5j3kyTR3suFrzido1Aac9IlLc8xUXX3b
 YBkcA4VbyEF7oGssa1enwMrZjN9kN5kHgIB2naKPWSe0sxtNWxe6RM>
X-ME-Received: <xmr:yU8Uaaz8GkmhtbIH_qa4szjXN5XuCkmf9GndGdYE1-sFkqvRPEx7uvSQGBJ36lrXk9U8T-5Kf2eFjvtKlHR6ylIL5B6C7og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefieekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedu
 keefleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopehhvghmrghnthdrrghgrhgrfigrlhesnhigphdrtghomhdprhgtphhtthhopehsrggt
 hhhinhdrshgrgigvnhgrsehngihprdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnh
 gvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:yU8UadTdPtmPDTBFwNelr6g14moLTCdejTt2et8SGgYzV2z-Etq_yQ>
 <xmx:yU8UaRX5asAcsXMmnaO5U63xgyrU-GosYXQcrXWsjjHAAljevyLzaA>
 <xmx:yU8Uafb50Ld8n-aAp1EyQgPxyCK4UYwkxZS5lj20DrpfeHvCYWQdEA>
 <xmx:yU8UaX2nlnTyScAxa0aekIMnaGfYskszpil71Up050Van0dBMp-ljQ>
 <xmx:yk8UaWd1xj--Li5EFn9VeJ33I6nGadMFdbODlsuO_ZNJOgxXOkvBGPix>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 04:13:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] license: standardize SPDX tag for 3-Clause BSD
Date: Wed, 12 Nov 2025 10:13:35 +0100
Message-ID: <20251112091335.662991-1-thomas@monjalon.net>
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

Make sure the SPDX tag is used as defined in license/README.
Reduce separator to single space.
Use parenthesis and uppercased "OR" when a second license is applied.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/eventdevs/dpaa.rst             | 2 +-
 drivers/common/dpaax/caamflib/desc/pdcp.h | 2 +-
 drivers/event/dpaa/dpaa_eventdev.c        | 2 +-
 drivers/event/dpaa/dpaa_eventdev.h        | 2 +-
 drivers/net/tap/bpf/tap_rss.c             | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/eventdevs/dpaa.rst b/doc/guides/eventdevs/dpaa.rst
index 33d41fc7c4..8fb1d469dd 100644
--- a/doc/guides/eventdevs/dpaa.rst
+++ b/doc/guides/eventdevs/dpaa.rst
@@ -1,4 +1,4 @@
-.. SPDX-License-Identifier:        BSD-3-Clause
+.. SPDX-License-Identifier: BSD-3-Clause
    Copyright 2017 NXP
 
 NXP DPAA Eventdev Driver
diff --git a/drivers/common/dpaax/caamflib/desc/pdcp.h b/drivers/common/dpaax/caamflib/desc/pdcp.h
index 55159d53f0..460f48c9e3 100644
--- a/drivers/common/dpaax/caamflib/desc/pdcp.h
+++ b/drivers/common/dpaax/caamflib/desc/pdcp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause or GPL-2.0+
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0+)
  * Copyright 2008-2013 Freescale Semiconductor, Inc.
  * Copyright 2019-2025 NXP
  */
diff --git a/drivers/event/dpaa/dpaa_eventdev.c b/drivers/event/dpaa/dpaa_eventdev.c
index 400e0ecd1c..e5d93afca2 100644
--- a/drivers/event/dpaa/dpaa_eventdev.c
+++ b/drivers/event/dpaa/dpaa_eventdev.c
@@ -1,4 +1,4 @@
-/*   SPDX-License-Identifier:        BSD-3-Clause
+/*   SPDX-License-Identifier: BSD-3-Clause
  *   Copyright 2017-2019 NXP
  */
 
diff --git a/drivers/event/dpaa/dpaa_eventdev.h b/drivers/event/dpaa/dpaa_eventdev.h
index 047c9781bd..1794f4cde6 100644
--- a/drivers/event/dpaa/dpaa_eventdev.h
+++ b/drivers/event/dpaa/dpaa_eventdev.h
@@ -1,4 +1,4 @@
-/*   SPDX-License-Identifier:        BSD-3-Clause
+/*   SPDX-License-Identifier: BSD-3-Clause
  *   Copyright 2017 NXP
  */
 
diff --git a/drivers/net/tap/bpf/tap_rss.c b/drivers/net/tap/bpf/tap_rss.c
index 6a1c3761b7..040cd7488c 100644
--- a/drivers/net/tap/bpf/tap_rss.c
+++ b/drivers/net/tap/bpf/tap_rss.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  * Copyright 2017 Mellanox Technologies, Ltd
  */
 
-- 
2.51.0

