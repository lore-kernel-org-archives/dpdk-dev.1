Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F79CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B1E40662;
	Tue, 14 Oct 2025 11:15:59 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 6C37040666;
 Tue, 14 Oct 2025 11:15:58 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 1A6CFEC0256;
 Tue, 14 Oct 2025 05:15:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 05:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760433358; x=
 1760519758; bh=MgJEwu92mqtYHb/0ttAnYeWr+pZmT5JFSTv42eGdA9o=; b=E
 kG/PRNZAckOWNoIRI2uEY0PYkpxg3UjnZEXbUReZZdrXI7/gTx4eDw4vpGQO0VYc
 0Arl2qvY4PYNJt4IHw6aCPf8K6OWuYeAL6OvggO6ODtBVtwRB1og70vHc9XI7D7z
 GAn4Hl5ey5W0OvGDiOjnR+j3sLvO/fPfRZ+ITptvZzkyaNiX7FkEfh7ZcSdHZQoF
 +UTzP6DlDMmQoSQiZI53KYBEH+czJ4EJbbh5quCrPD2W/4yhgAj+b/FYguZPr6J3
 QrCnEHkZuKnmUthUj4tgOc7j7Q8J5HeZZV66GK4VIQndaRH3utCIFmZCY/GvTSet
 adwq5DEqw4GiYbmfoG3rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760433358; x=1760519758; bh=M
 gJEwu92mqtYHb/0ttAnYeWr+pZmT5JFSTv42eGdA9o=; b=PyuHGMuG2pENtIYHE
 ga8Vgv0/GVAXiJxsqriopcAKFgH7Ae3UHv1ue6nJe2IifTm/YwX4a0+rI/k9cueg
 Yb5beFd5jTIQlhNVn54XFUqCCN27qMJMm9hhIBmiMtfpdwwL6dPz78WzQWIIFfYe
 Ci1ZflexkHq5/DUE9MFpMWVJqqM0rLj+9LxfirIhfZoX4g27W0/Q+rFJ/mws+iBS
 ICEv5+x1nUBVAfY+nfrPVRN5Zm3WYBa8ZizxF0s7gq9cT5fPcJP1IQhqzTIDhtH8
 kvbt3GD01auAyWcS8BeUqTTbRn1hcGpOMYZpgs0DqIJ4OLgdAuPQQ/+qvbWhu3Cu
 LcwdQ==
X-ME-Sender: <xms:zRTuaKKsNcj2ohRptRHwCQAbZu-ffbbqV4lM_EIkdILpicN1wm427Q>
 <xme:zRTuaLFmSB2oPtO4V4E7V-P9PfLif0-ibtJ2_8Blc6rxah6pNmJqhPAFk3PvTKAZU
 zL2djRLrezRmx6hSM9ZAUMwszOmutMLJnlKtIMCvYFwufKVGu9utA>
X-ME-Received: <xmr:zRTuaGQHfANgeveJH63nVGGFwi21CqsQpPWAWJQf8KFN_CS3FZcjozfgrxLOsgANUkxDjcd3qCckd0NxAgIQAElFqAijd3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohephhgvmhgrnhhtrdgrgh
 hrrgifrghlsehngihprdgtohhmpdhrtghpthhtohepnhhitgholhgrshdrtghhrghuthhr
 uhesihhnthgvlhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghoqhhuvghlihhnse
 hrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:zRTuaPc-FGqPZJuW81XVAmwdzZ1F6VxlcjAtWMVUtJsE2YLs7FuC4g>
 <xmx:zRTuaNoTqOFcKqp7ZmbbidXMBwDgihWcDiQrDxUO9zHrZRRz35cJdg>
 <xmx:zRTuaI-_S1MISDvsc1La2WMI4Kf0ATKIq4OcdSvbsoTsKB3jj-ZJEw>
 <xmx:zRTuaBfZpIW0DDVjXdmdGuSny_sNEGHX2uMjrk8gxMGFNmEwPfEKhQ>
 <xmx:zhTuaM54DzdrkqoX4CXl20mfX91gfKDhSG5p_QkOWhLiDgGjTZo0I89F>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:15:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v4 3/3] bbdev: fix build with MinGW 13
Date: Tue, 14 Oct 2025 11:14:01 +0200
Message-ID: <20251014091528.936405-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014091528.936405-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20251014091528.936405-1-thomas@monjalon.net>
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

The type of the variable i is also changed to the enum
required by the function rte_bbdev_enqueue_status_str().

Fixes: 353e3639d458 ("bbdev: add queue debug dump")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 lib/bbdev/rte_bbdev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index e0f8c8eb0d..8d6e3ba09b 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -1247,7 +1247,7 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 {
 	struct rte_bbdev_queue_data *q_data;
 	struct rte_bbdev_stats *stats;
-	uint16_t i;
+	enum rte_bbdev_enqueue_status i;
 	struct rte_bbdev *dev = get_dev(dev_id);
 
 	VALID_DEV_OR_RET_ERR(dev, dev_id);
@@ -1264,11 +1264,15 @@ rte_bbdev_queue_ops_dump(uint16_t dev_id, uint16_t queue_id, FILE *f)
 			dev->data->name, queue_id);
 	fprintf(f, "  Last Enqueue Status %s\n",
 			rte_bbdev_enqueue_status_str(q_data->enqueue_status));
-	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++)
+	for (i = 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++) {
+		const char *status_str = rte_bbdev_enqueue_status_str(i);
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
2.51.0

