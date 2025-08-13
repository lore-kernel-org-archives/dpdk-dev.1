Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2EC87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:29:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2600240EE7;
	Wed, 13 Aug 2025 17:29:09 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 0EC9A40265;
 Wed, 13 Aug 2025 17:29:08 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BA5431400156;
 Wed, 13 Aug 2025 11:29:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 13 Aug 2025 11:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1755098947; x=
 1755185347; bh=rDScchksfXEppDg7G6UQ6vYmkNR2mXDNphAy44CXf/M=; b=R
 qQ/3zLxcW6aP452tcg4sMi1Ag540ArZEAS24HPUrgPTGbd0Nh2t59T0vq+C2qjmh
 30AqZsu9yWaIFdIXBQZNhCN/kVEY0OHyZ34F09jGrkEGBQhwsNSYzJfaeQ0/ed13
 q7VEntXD43CcaD8mv0eRWLSRczGpCfQUFCX4K2IyRWUaBmVtswyb1ztLnkmdA/hG
 /esJmsNuW0Cvu1iHPOiSasvkVbVtWulGq9bejFFvocLYktsFItWQd9yzhwUNFjtP
 gmhqJcIyCV/f+NiC0ExJe6rdwRWxh2fKCMnKaDCqA1v73jbxhBDIPjbuRJtX0SXa
 K2rCyY4wx1SHjqYDLfOHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1755098947; x=1755185347; bh=r
 DScchksfXEppDg7G6UQ6vYmkNR2mXDNphAy44CXf/M=; b=KWxBDbnvol0TW5bFt
 I44Futjbkw43y6DnSZXV+Ilk/2pwN9u25tzYdlcoDO75ulBZPKSXeiCdsrWV7Mug
 w4uSBgr1ZUECpaBGRKYq25msSn0dAaimAb8CfaqE/x1Zg94RIaVPekJ8Q8EnUn52
 +QrFjac7syCwdV36/B/tbvku8nzsATDpfdwBcRkV384Q4xif7rd7Orpp4mr2iPHy
 aVfIVRIkMiM3IXa3W0KevffiWLgfke71iwwVigupHAYt1KS6ZsmjtaX66ajQ5RLB
 Te93mNLA7gzpJet7Svgil9bbBvSn2EcUIZM2P3Nv8bdFbs/0bH98ti+Z6cM2p9Uf
 4WtrA==
X-ME-Sender: <xms:Q6-caFWKJBSbuMPz563A9M1rTm5tvgJIJDgJrlXW4bwQ0VH3nDW7EA>
 <xme:Q6-caK9XHiw5_jfpkgjZJepWl3PHK5jrg5rLW42xBtsktpCMEv-R9yVbv27VHWAZI
 7ebq8i1ZriZDWyNsQ>
X-ME-Received: <xmr:Q6-caBl2M76XtjpaudzLOmr8aIJklwOQSzT0OtB8sXcW28r6r7BIjymdO9dxnS88QthgmBGVM8zAuM0TDXwiNWAFjLr2rms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepnhhitgholhgrshdr
 tghhrghuthhruhesihhnthgvlhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghoqh
 huvghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrhgr
 figrlhesnhigphdrtghomh
X-ME-Proxy: <xmx:Q6-caIVRImjzb0f3VrQHoQOzZw42P3v2Z78OSa1ntlGSZG5ZF7wrsg>
 <xmx:Q6-caOFdFy7rgS5psw3uhsz8hYAY2NQR0yMFsLuq8WuYuoOqv5YsCw>
 <xmx:Q6-caMfbzHz7KOh_dhV9lsi1GHbH4KovlJL4MUyjVHwIc0cxLoj-Ew>
 <xmx:Q6-caHK3HmLVjtsLBh8opLcdy-RkW8kxFwbHK7n7in6kViyGHcnDiQ>
 <xmx:Q6-caAi1yHws6VYo7h8DFIoch3nbLTuP0XqzXPazt5JCmR-DupPag18L>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 11:29:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH 3/3] bbdev: wrong fix for MinGW 13
Date: Wed, 13 Aug 2025 17:25:25 +0200
Message-ID: <20250813152829.457463-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
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

After an upgrade to MinGW version 13, compilation breaks:

In function 'rte_bbdev_queue_ops_dump':
lib/bbdev/rte_bbdev.c:1269:63: error:
	'%s' directive argument is null [-Werror=format-overflow=]
	fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",

The enqueue status string may be null if the index is too high,
because RTE_BBDEV_ENQ_STATUS_SIZE_MAX is defined to include
padding for future enum insertion.
This padding case must be checked
to avoid printing a dump of a non-existing status.

Fixes: 353e3639d458 ("bbdev: add queue debug dump")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 lib/bbdev/rte_bbdev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index e0f8c8eb0d..d662a2b364 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -1248,6 +1248,7 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 	struct rte_bbdev_queue_data *q_data;
 	struct rte_bbdev_stats *stats;
 	uint16_t i;
+	const char *status_str;
 	struct rte_bbdev *dev = get_dev(dev_id);
 
 	VALID_DEV_OR_RET_ERR(dev, dev_id);
@@ -1264,11 +1265,15 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 			dev->data->name, queue_id);
 	fprintf(f, "  Last Enqueue Status %s\n",
 			rte_bbdev_enqueue_status_str(q_data->enqueue_status));
-	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++)
+	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++) {
+		status_str = rte_bbdev_enqueue_status_str(i);
+		if (status_str == NULL)
+			continue;
 		if (q_data->queue_stats.enqueue_status_count[i] > 0)
 			fprintf(f, "  Enqueue Status Counters %s %" PRIu64 "\n",
-					rte_bbdev_enqueue_status_str(i),
+					status_str,
 					q_data->queue_stats.enqueue_status_count[i]);
+	}
 	stats = &dev->data->queues[queue_id].queue_stats;
 
 	fprintf(f, "  Enqueue Count %" PRIu64 " Warning %" PRIu64 " Error %" PRIu64 "\n",
-- 
2.47.1

