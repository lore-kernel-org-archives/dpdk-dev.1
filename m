Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC83D35164
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A5984029D;
	Wed,  1 Apr 2026 11:35:14 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 7DB5B400D7;
 Wed,  1 Apr 2026 11:35:12 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id DF42FEC0226;
 Wed,  1 Apr 2026 05:35:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 05:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1775036111; x=1775122511; bh=3spQ1P7xrTXevvnrBvwfV
 IwllI2C4ueGM4O22oFud5U=; b=k5eW6q1d4Z/0VDDNhmNQDl6uthpIYhDA7eF77
 chOYBtWfmmKPEVgApzRqDZuCDo6YtoJgmuq7EY012hvsBHC06HvoyHOAyUa/Eh7v
 JRTxFI2g+F4eMZdYJJrtuz7dwFZvltoyq7FZZRIyMZT5BuMJiw2CX0m1G2RQ9sg/
 oYLVDAgNODEHkJkZ/VPttqLynEa9VgrfegSE536JQhyBobAZ5rK/cNobKl6e2ehw
 nG+ir7Rgx8bAn6ThrP3g/0fYgmeT3Hfztwl1FsLK2Yv6BwqwnPkqlN/1oHu2jMLZ
 SgL7IJUuxcxRdc2GHtBJu33fh+6QMTJiFdwlYpAxobwSnRVTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1775036111; x=1775122511; bh=3spQ1P7xrTXevvnrBvwfVIwllI2C4ueGM4O
 22oFud5U=; b=E/Nz2Mqh+a8saqdbRUJ9M3SbLQCIj1Rubf6mRgqteod2stB8ZWB
 IDdg99+86yu6wLnIVOFyeUChTFNfZtBwPUHFNnQwLsXLTt+t3oXW90qSrwI+XKRR
 d7GGVRZP2AlVe0UCmTA5Ai/RJy78rZ8GCb1r1vCYjffqca4hUk6oyPs0wJUJ2a/D
 nX/b3xSFjGeXF/ks5HtC3YIyfYjWHoiK3U3cUlb4RCmA3cbLzLiqZrU/im0PksUg
 Kk8z+7nwQAvQwYoLVKJZLp+Cf103FNb2/UDEmmTYSxk9XUmZS1IE/Yuscmt4+AWR
 Klyge/9c+UvSvyfXkAuH1tAA1YWewh5AEng==
X-ME-Sender: <xms:z-bMabZzRrrTDqmNzWeQKMr75tEonYkvj3osAdU0emN66B0JMs6LAg>
 <xme:z-bMaVXn7KoLJdiirEBIxZVL41O5HCDCPdyvV5F4WzV2ychuFy7oiBlJB35_-lgPQ
 rSTEX47v9gKp9wL1KQAfmX2vYtEYazC6nxIrGr8tM8tcpVlhD6x8l8>
X-ME-Received: <xmr:z-bMac9TGaVSR80eMRR9aiwLzRkhXjgmd-ECtLH-xbyovbyvNO6Ji3LZlVmpft1M9l2Z-ZYI_JEoa7N66fuJh7QLZcdu8LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfoohhn
 jhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtth
 gvrhhnpeevveefveeiiefhtedukeegkeelieegffeukeevudetueffieduveetiedukeef
 leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthh
 homhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhope
 hsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheprghnrghtohhlhidrsghurhgr
 khhovhesihhnthgvlhdrtghomhdprhgtphhtthhopehsihhvrghprhgrshgrugdrthhumh
 hmrghlrgesrghmugdrtghomhdprhgtphhtthhopehmrghrtghinhigrdhhrghjkhhofihs
 khhisehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiigidrkhhrrghkohifih
 grkhesihhnthgvlhdrtghomhdprhgtphhtthhopehluhhkrghsiiigrdhgohhsihgvfihs
 khhisehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:z-bMaW-tttApmUwtJkkP30OhcaXOCO_P8AYObuCH7zPr1Nr1WqO9yw>
 <xmx:z-bMaURuMQ3547zhuWwwcPJtn9NL6MzshUzH0OULnK9V0ZIhC1nd-w>
 <xmx:z-bMaSd5fDSneOy_9kuC3JwOT5D69FGkCNbxlm7ZNgNHcNlSGUREOg>
 <xmx:z-bMaQB0gffCeuCQoVO30yGniyQkxlww1CbXYp9xt8gvMo-6lGp0Ow>
 <xmx:z-bMaTKrQvjD8WZcaLgNhyhzEEPEs8KJ9MYzvdwv3cqDCLHWin8Y5gtT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 05:35:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Marcin Hajkowski <marcinx.hajkowski@intel.com>,
 Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 Lukasz Gosiewski <lukaszx.gosiewski@intel.com>
Subject: [PATCH] examples/vm_power_manager: fix const discarding
Date: Wed,  1 Apr 2026 11:35:01 +0200
Message-ID: <20260401093502.1420779-1-thomas@monjalon.net>
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

When compiling with GCC 15.2.1, a const qualifier issue
is seen with this warning:

In function 'get_resource_name_from_chn_path':
examples/vm_power_manager/channel_monitor.c:139:16:
error: assignment discards 'const' qualifier from pointer target type
  139 |         substr = strstr(channel_path, CHANNEL_MGR_FIFO_PATTERN_NAME);
      |                ^

The function get_resource_name_from_chn_path is used only once
and call a single function (strstr),
so it can be replaced with a direct call to strstr().

Fixes: 221e7026d521 ("examples/power: add FIFO per core for JSON interface")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 examples/vm_power_manager/channel_monitor.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/examples/vm_power_manager/channel_monitor.c b/examples/vm_power_manager/channel_monitor.c
index 800f733a26..3023e444a4 100644
--- a/examples/vm_power_manager/channel_monitor.c
+++ b/examples/vm_power_manager/channel_monitor.c
@@ -131,16 +131,6 @@ set_policy_mac(struct rte_power_channel_packet *pkt, int idx, char *mac)
 	return 0;
 }
 
-static char*
-get_resource_name_from_chn_path(const char *channel_path)
-{
-	char *substr = NULL;
-
-	substr = strstr(channel_path, CHANNEL_MGR_FIFO_PATTERN_NAME);
-
-	return substr;
-}
-
 static int
 get_resource_id_from_vmname(const char *vm_name)
 {
@@ -1066,8 +1056,8 @@ read_json_packet(struct channel_info *chan_info)
 		root = json_loads(json_data, 0, &error);
 
 		if (root) {
-			resource_name = get_resource_name_from_chn_path(
-				chan_info->channel_path);
+			resource_name = strstr(chan_info->channel_path,
+					CHANNEL_MGR_FIFO_PATTERN_NAME);
 			/*
 			 * Because our data is now in the json
 			 * object, we can overwrite the pkt
-- 
2.53.0

