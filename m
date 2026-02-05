Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1031ECD9A6
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1DA340611;
	Thu,  5 Feb 2026 22:31:01 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 59C9A40658
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:31:00 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 06E24140012F;
 Thu,  5 Feb 2026 16:31:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 16:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327060; x=
 1770413460; bh=4okz/oE6vtEC8FQMt+G0yGZED2j0WWEuPeWHYTzVvFw=; b=H
 8DvVHFxcg6Ud36x0aGXKxtw/a0l8i+SFfOLFFO/Xnq2x4xh3gxpqCz24Y2Zm5cox
 Geon3qXet8u6Rqy1Ua6w5/+SFPGqxzLmYTLdsP3ofqKme6yfvt0s81DLfDHtZcKD
 6oSK3i0x5u7ogmEu1H40MX3xR81NaoCHmxFbf/09SIdGw5RVYrsKK2rezfgg8OvU
 2WRzNGi9H15feEpLCaX4ohKxpxcCpIHPQ9R+cOhCYoUEu/9qlHjNJAAPLNwGnbg0
 iJWC8jmFooM63PAvXuPpj1Tc9guXGcYYHT9sso2TM40WZGdEcWnydH6neDn2B5rG
 QAeATZ6bdPOsQFWEGMTtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327060; x=1770413460; bh=4
 okz/oE6vtEC8FQMt+G0yGZED2j0WWEuPeWHYTzVvFw=; b=NaXtgcbGkIYl1e059
 2eijyoVenWodphHbs3i+QU3yxwTvtXL+WgKIBq+P7z/c/is7X89SIlU0zQVlnNxI
 plGrwrpJ7WU4/NW5j8sTy47JZgcrm0SokI5ZGxPSioleQTA/fgYQmJgPDFyt0iTX
 qMEm5fSnuYmWoxOiIzbKAn4txz34TcrVtuFopBxWWOIbQm6wQhZQM5vq9/5UV4Jk
 G/lj7Gk2vDH1lGsFbXruMchTdorRx1zqE+SJ1psy1P2XfRMdu/ZczZh7fsdckP4U
 VsC4PvCLW7wVA9+QkREYwQtkYl5fWjR7uZ7qqQg3a/5BVTdU+lSaqIG+PnemuID4
 Fvf4w==
X-ME-Sender: <xms:EwyFaYMkR0wYyruT3MzjaX3rtZyYPCYfBMdMc1_gE49C36wnp8HFXg>
 <xme:EwyFaaaLcvaZlSsJv9tWATzNj0FFK54dcJip9LPl901gXnbYSZ7euvDk6ZdwFFaX7
 TJLlGWDpFosf4r7g8WJgBd0eZ0P-JWtY6YQibQb-oHX-Q186W3OEg>
X-ME-Received: <xmr:EwyFaSytLxHzwGp5lscIbo1IcMFJKrKuX8OKF2Yo-Tf5tk8y0geAYW33cxLZZoL1w4nuY4Gv3331zoZ3NYsT3FCCEMApm70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdprhgtphhtthhope
 gthhgvnhgsohigsehnvhhiughirgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhp
 thgrsegrmhgurdgtohhm
X-ME-Proxy: <xmx:EwyFaVIqnw6t28SJ8ooMmRzkiadnWqaHrt2fqi0niSQCKaUAa5envQ>
 <xmx:EwyFacpDdfwZGTIIviAq_C5Sf1OZm7RB8vU6LboGrsqw8V07asGxng>
 <xmx:EwyFaUKDrginJQMOWKa89bMPKyu-vAJIIqX4LtzFziy0SwriQohWgQ>
 <xmx:EwyFaRTsKO7TFPkaHAI0ERhGFMUZ_M_WpY6KZOv5Qmpe27n3BiEpXg>
 <xmx:FAyFacT5lMaxuy94zltYUaxtZ-B-bWIU1RLiX-n8rH6zk2FAJ-JIG94g>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:30:58 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v4 05/11] bus/pci: fix minsize build
Date: Thu,  5 Feb 2026 22:27:37 +0100
Message-ID: <20260205213044.702908-6-thomas@monjalon.net>
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

This error is seen in build of type "minsize":

In function 'pci_vfio_map_resource_secondary':
drivers/bus/pci/linux/pci_vfio.c:1005:28: error:
'maps' may be used uninitialized [-Werror=maybe-uninitialized]
 1005 |                 if (maps[j].addr)

On failure before assigning maps, it was trying to unmap.
The compiler should have detected that the unmap loop is a nop.

The fix is changing the goto destination after unmapping
to allow compiling with "minsize" option.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/bus/pci/linux/pci_vfio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index 242f567ed7..bc5c5c2499 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -968,7 +968,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 
 	ret = pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info);
 	if (ret)
-		goto err_vfio_dev_fd;
+		goto err_vfio_dev;
 
 	/* map BARs */
 	maps = vfio_res->maps;
@@ -1005,6 +1005,7 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 		if (maps[j].addr)
 			pci_unmap_resource(maps[j].addr, maps[j].size);
 	}
+err_vfio_dev:
 	rte_vfio_release_device(rte_pci_get_sysfs_path(),
 			pci_addr, vfio_dev_fd);
 	return -1;
-- 
2.52.0

