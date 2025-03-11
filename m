Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F03C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:54:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 601684064C;
	Wed, 12 Mar 2025 00:54:44 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id B0031402D2
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:41 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-219f8263ae0so116106675ad.0
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737281;
 x=1742342081; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjWkTdQd9MfVRfJqngDibwxKy/v3SkwXlQiB4myh1To=;
 b=ydJCpcLbO3Q2xoiu1jlGgH6I1NF4s5/GWFGW0w80Fh7hPKn6GmLoA2hJMwcUVG4d2n
 jUdntAkDvcBkoRGKwXmkKc7Rh+GnpOu2dhYTjxciw6KQ3STRtU/5hG8nRJ6UP9aoxsHV
 HLDClZQ7wTQACdIZZUgG/uBuPe7ztDfKKURD9Vt9c4ACBeaVV3tarH7CjfOYhWvLcAqH
 5AiheoDk+limCef6sOx5si0I0/H5/B+6DkJ9Xu0r0+tsBjQtTwpuKHFzPOi3H5cZlhwI
 lOw8j8/DYXyf28swymNeQgaKfbeNyBMVa41+WmRVfAckRnUkgR+vRwFuUjvIapJvJPfv
 Gp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737281; x=1742342081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjWkTdQd9MfVRfJqngDibwxKy/v3SkwXlQiB4myh1To=;
 b=uUoYu3Ugla284YwtN6OT2KouJMRvsZGfNVvhs/a7A4jy9LlT+nUXlmVkmoTTGPO0hY
 GJxGzI/gq0SlLis1sxobUqtmG4vEMFvnCv8C2W5AY04W3wxmlqLQisFeau1KP+om6q1d
 3zLCfZwfF17cWM6u3rCCfIvPDF5lGIQmzrIP/qRPguCdKFUWDM5VzPfc5qghAOCK7Gon
 NfOuXMRJYmm3yVGpVN+qpYE8qO19p1jQ9R29n4cXvmahD0ZPhd9CNOJe4qSzdFioTeAL
 ZWUrlE/OB8P+saRnpw1q/keuui0WbUZghSwc24PE7UTMYlIwWaFpYC8LdGwy8sbxUeFC
 mApg==
X-Gm-Message-State: AOJu0YyEfeBnH1OSiqVMnNDxvQPPDUo9yA+zn5mrfb9sQnutnTYhRd/r
 zjmHm94pI7lsUd+EYz4x3pxP0jgJAGtKPVwrGrELMbIKKTOWpIEBWMO6VU1XpVNlO/64hThP6nq
 v
X-Gm-Gg: ASbGnctKaievHNnPH8465FGJMDFYMXU8F4vd22PgYJo3XP5rKh0Ln6o0JDzLHMsai3a
 OPZsO00ld9IDCctahjNbab0bUggoijh9wXWKoMUN07ur0dV0DzMGpouMas9HRHWT49B/gQp4dqq
 M30TIKUAPYioi7zhnlgP4pZvtdBBOhbUrjuFJmj5V8O++KYxV2doArYrCbmkkqvgiPlFck/QoLE
 raLep58tiA0KPcX+3+Xi5r4doeedGMljDYoduNTx7lBAWPC8dh8WwvrUzJJ3YLBp5wZVLUooNce
 ifZKmda2xvqWviohQyk4iFdZRHIRFKMA0edAscP+dahMMLwIm7cjBll3VaiLMt7Rhkkl+58Z1UL
 +BrGz9JWItXBYc7v+qx/+kg==
X-Google-Smtp-Source: AGHT+IFu3UngEelBuEbUYjfBmKZehwvVdfbeaLCGqm0TQG+lEZas24/aQmnv7PqfjaM9/fVI/eURXg==
X-Received: by 2002:a17:902:db06:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-22592e2014emr68949625ad.5.1741737280879; 
 Tue, 11 Mar 2025 16:54:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 2/9] net/ioring: implement link state
Date: Tue, 11 Mar 2025 16:51:20 -0700
Message-ID: <20250311235424.172440-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Add hooks to set kernel link up/down and report state.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/ioring.ini |  1 +
 drivers/net/ioring/rte_eth_ioring.c | 84 +++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/doc/guides/nics/features/ioring.ini b/doc/guides/nics/features/ioring.ini
index c4c57caaa4..d4bf70cb4f 100644
--- a/doc/guides/nics/features/ioring.ini
+++ b/doc/guides/nics/features/ioring.ini
@@ -4,6 +4,7 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
 Linux		     = Y
 x86-64               = Y
 Usage doc            = Y
diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index 4d5a5174db..8c89497b1a 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -47,6 +47,53 @@ struct pmd_internals {
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
 };
 
+static int
+eth_dev_change_flags(struct rte_eth_dev *dev, uint16_t flags, uint16_t mask)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return -errno;
+
+	struct ifreq ifr = { };
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+
+	int ret = ioctl(sock, SIOCGIFFLAGS, &ifr);
+	if (ret < 0)
+		goto error;
+
+	/* NB: ifr.ifr_flags is type short */
+	ifr.ifr_flags &= mask;
+	ifr.ifr_flags |= flags;
+
+	ret = ioctl(sock, SIOCSIFFLAGS, &ifr);
+error:
+	close(sock);
+	return (ret < 0) ? -errno : 0;
+}
+
+static int
+eth_dev_get_flags(struct rte_eth_dev *dev, short *flags)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return -errno;
+
+	struct ifreq ifr = { };
+	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
+
+	int ret = ioctl(sock, SIOCGIFFLAGS, &ifr);
+	if (ret == 0)
+		*flags = ifr.ifr_flags;
+
+	close(sock);
+	return (ret < 0) ? -errno : 0;
+}
+
+
 /* Creates a new tap device, name returned in ifr */
 static int
 tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
@@ -103,6 +150,39 @@ tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
 	return -1;
 }
 
+
+static int
+eth_dev_set_link_up(struct rte_eth_dev *dev)
+{
+	return eth_dev_change_flags(dev, IFF_UP, 0);
+}
+
+static int
+eth_dev_set_link_down(struct rte_eth_dev *dev)
+{
+	return eth_dev_change_flags(dev, 0, ~IFF_UP);
+}
+
+static int
+eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
+{
+	struct rte_eth_link *eth_link = &dev->data->dev_link;
+	short flags = 0;
+
+	if (eth_dev_get_flags(dev, &flags) < 0) {
+		PMD_LOG(ERR, "ioctl(SIOCGIFFLAGS): %s", strerror(errno));
+		return -1;
+	}
+
+	*eth_link = (struct rte_eth_link) {
+		.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN,
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_status = (flags & IFF_UP) ? RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN,
+		.link_autoneg = RTE_ETH_LINK_FIXED,
+	};
+	return 0;
+};
+
 static int
 eth_dev_close(struct rte_eth_dev *dev)
 {
@@ -126,8 +206,12 @@ eth_dev_close(struct rte_eth_dev *dev)
 
 static const struct eth_dev_ops ops = {
 	.dev_close		= eth_dev_close,
+	.link_update		= eth_link_update,
+	.dev_set_link_up	= eth_dev_set_link_up,
+	.dev_set_link_down	= eth_dev_set_link_down,
 };
 
+
 static int
 ioring_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
 {
-- 
2.47.2

