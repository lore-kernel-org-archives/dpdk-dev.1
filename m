Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D57D25B44
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:00:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4914740655;
	Wed, 28 Jan 2026 13:00:20 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id B6E3B40653
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:00:18 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4255D140015A;
 Wed, 28 Jan 2026 07:00:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 28 Jan 2026 07:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1769601618; x=
 1769688018; bh=hvQWB0LyEHHVct/x79L55HRQSfgVuAj5VRdQyLNuP7M=; b=h
 rBpa4aL7nkELJZbSp+CTyBhUI0D/c4GyeN+Mr32gafazMqAqpIpZ1Y71XHb+h1z8
 7sd2ysSmsZJharJ8B3xVrWy7NUu/yxkYyOJO//TgHg5NosonC8EEEtLEJSlFZXP5
 gxDTDIwhOq2c/qt+Mjm2X8p8Yr0Dqq6pgv/s/1/jnjbLU31qECFIy+khCm3XtR0s
 9NEw7sPiKwPIzH42BiXt4aJ+d6JxM9bCZTVT429puJvl+RPMzHHDXkNknW7R2rT2
 EXkhP064vNnp3KwLPOFddeNJwa/h1Trfgp1HhzLo8u3zWsUCFYppq9OZ2zvTa+YK
 POBQAlA4xK2KxmcLYHI4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769601618; x=1769688018; bh=h
 vQWB0LyEHHVct/x79L55HRQSfgVuAj5VRdQyLNuP7M=; b=PIu6rLcXpzSdlDk4u
 Ff7cZNMHeHmpGoJomKtAXHtOSbuRCiK1Y+j+y1OIPzkELfxPXjqmrI50XaCdXJTj
 jkyQ9KKoKu++IiVIH1NQRzAKF/AjfV3IskGICT0aHNTBxg/++kW7+eQ6tysHxtwd
 Uo8nUlkeoH0jSM6gDHWPYi1/8rtLkuWDNxIbOCgneaBtfKYUcQrmHHXkOUIGGE5p
 YXKuqlqdjwEZnoKFN31UroPqggmNfgEH5cbSgwS1lOjLGiV6PF1zii6QprcWZag9
 1ljR9qF+5ibmVqUahw3qCQ8DimsFTvOtDj7siQBlterfglJnxl66UMR73jDU4lNO
 QrMvw==
X-ME-Sender: <xms:Uvp5aayFB6ZTkMLp3iplzawAdmZrM9rk8pZ_4ZxNEkEIIhU84ynX2A>
 <xme:Uvp5aRvAciSlbPaAntwL4lJxyAGQkuojpZSN8is53XlDmqIVpHRXOq4m66-q6b1Cf
 ySAtmIJDVeE4F5NOcAznL4aFSxFsF8gLakoEkLXFk-G5q1i1cX9nw>
X-ME-Received: <xmr:Uvp5af0gQ6iblUlWZCI53v5jWNcl_KPIJ2pbHoznvsvHVJSo5sjvRLghEOaBqVYglo8-2DbNcDKmPcd--BG85sohZ0hfwKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeffeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 oheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdprhgtphhtthhope
 gthhgvnhgsohigsehnvhhiughirgdrtghomhdprhgtphhtthhopehnihhpuhhnrdhguhhp
 thgrsegrmhgurdgtohhm
X-ME-Proxy: <xmx:Uvp5aU9Aod51NQDdnghUOmmWco2JOB_ckTP0-U3XSpfg-jJ-TjpU-g>
 <xmx:Uvp5aYPuVRgwnaTxozpkSwwvC26jjH_EI58O6k276yFTjg_IVcssDA>
 <xmx:Uvp5aQdqRZH-yiKBQc-46S7SvWJhRT8EhZ3jqSUdJgewuSyBOO_1Cw>
 <xmx:Uvp5afUrWj36bRLdhuR8ceavSLDxeD_PkC4a5KbO2Cq0sc94y7q_PA>
 <xmx:Uvp5aekt5oZ6hlH3SC7cvr06_fBRwwRVdwHhS7k9rjml47fYXC0Vysxu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 07:00:17 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v4 1/4] bus/pci: fix unmap on failure in multi-process
Date: Wed, 28 Jan 2026 12:58:30 +0100
Message-ID: <20260128120005.2777473-2-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128120005.2777473-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260128120005.2777473-1-thomas@monjalon.net>
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
The fix is changing the goto destination after unmapping.

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

