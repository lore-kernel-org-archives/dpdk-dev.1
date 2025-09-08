Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A312BCA1016
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 21:21:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D819F406B6;
	Mon,  8 Sep 2025 23:20:57 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 5936A4067E;
 Mon,  8 Sep 2025 23:20:56 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id CFD27EC0223;
 Mon,  8 Sep 2025 17:20:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 08 Sep 2025 17:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1757366455; x=
 1757452855; bh=DG7znt+fhdJ9LZmmpuVv0bBBkVyY+OhF7khJS8Dahyk=; b=r
 W8WCsJUlGYkyXPmmCpUqyWzi1aEu0vyf0jmu3dB78sYd0NEuUy828c0O/4yx2XlW
 yJH3nW54oo51Jyth1IEEy6IKju2aQM3phVA98ZcxsQNy+rC0fbvkiN8uAhwBUDP/
 rOgUfC12UoCWE1ZUcxK/T3W3tM55oWEpuhIeY5eNoorDppHjZwY6OEwIPXkLdy/r
 C1SPrcBzLbbpumhGojCq8mwi1H5t1ygpTkEo2YzyT8aTHcH2GFA8oc7uCgvJRNWN
 ZioCXrl1/QEM02ZGoWwQPJ2WVKYX4DbX74fy10B5CEDiJCmIioqaJ2I0EdYW6Phq
 gEtRLD8xRNiTFpRpvmMgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1757366455; x=1757452855; bh=D
 G7znt+fhdJ9LZmmpuVv0bBBkVyY+OhF7khJS8Dahyk=; b=We58X9zqCXJFrKteH
 NQq+tshw6bmQuyVs92w/WTMpeVl7KuxjLJ2kD1jFocIOp2vUPV0o2kVZrmCRrLH0
 cTfRnza0FxIUCUw8eiY/kbJWuuyG0e5EVK6Cfan56zGN5lj6H644/IxtiYyz/w7d
 j9q/DkrpDSOLgycQBiuQRDhooc5kEXaJrEx2q+6uyO/Salzuf9cikScgEjmDdwH6
 3xKVEeP7+JtW2OLEYaTCqg4Q6hcA3OOWxnFodMsGXbKFGGQ6XMRp6g+LLV4bayFa
 83WV7sHuvX91raDvYl65vCYTcQo8SXidc4yRrnhsWkQ3BQ/o2JTyMA5tanQh5k4c
 dSTBQ==
X-ME-Sender: <xms:t0i_aPnulzt6p_ulXpmBm67XpeKPb4bNkWRBKwr_Hfq6lpfQXUmz1A>
 <xme:t0i_aAy-KXKCYyh2d0ZdxgNpeIFStNPj9USj3lMrTLOq19eYR23sX4kkw2t7XZeuw
 y1ckC8PS8BHiuMZ1Q>
X-ME-Received: <xmr:t0i_aH_0Ba_4dPFYZJuWgOXA0Dy3rovJhSpZvwxObqVF-5X2YJz0kjvWHvTCChnM-ybFRpygW97zvJFgCHFJGGTEWzFhhhY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepvdejhfdugeehvddtieejieegteeuudfgjeeukeeiledthfetveekhefh
 ieelhfdtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpth
 htohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopehhvghmrghnthdrrghgrh
 grfigrlhesnhigphdrtghomhdprhgtphhtthhopehnihgtohhlrghsrdgthhgruhhtrhhu
 sehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgtohhquhgvlhhinhesrh
 gvughhrghtrdgtohhm
X-ME-Proxy: <xmx:t0i_aMKOCq_62IkWkgd1VZrIyMVUR492jO9paQ7ClIzZwjQtfjfj5w>
 <xmx:t0i_aFeEhr46Ok6l1HfAwxtXGPdMshs4MZ4PFFySGLNxmb3M-gPV5Q>
 <xmx:t0i_aD9S1tIHsq_gPSRjew_i4SzIUR74dFMRUmIJjNBq3pEPpIPwBg>
 <xmx:t0i_aKq9aVYhVjSWjP6ReiBr6WrJDOcGppqYBU8W2--qhRKZMYRroQ>
 <xmx:t0i_aPlVELV42aeMBSTFOFsvKMNdUzA-y0L38gtwjOvrT8UaAUZMPdIs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:20:54 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v3 3/3] bbdev: fix build with MinGW 13
Date: Mon,  8 Sep 2025 23:17:51 +0200
Message-ID: <20250908212034.699713-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908212034.699713-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
 <20250908212034.699713-1-thomas@monjalon.net>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
v2: make status_str variable local
---
 lib/bbdev/rte_bbdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index e0f8c8eb0d..e76124532d 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
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

