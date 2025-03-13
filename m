Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3CC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D0EA402BD;
	Thu, 13 Mar 2025 22:52:09 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id A816440275
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:05 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-223fb0f619dso28744415ad.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902725;
 x=1742507525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjWkTdQd9MfVRfJqngDibwxKy/v3SkwXlQiB4myh1To=;
 b=W0PBTf4L7ozZhs7f0M5LmvgSc38cVKh6PRe7+jXnJylQKYl1vs5uauZK8njy0+kYzg
 PMXjBhc7qfwg3fP5DQyTmQ0vFcc+M9pyBPqIqlGpjIY6b8nu/2cwGws6M/xgdNMsXFDO
 UMdFR0By3p390f3DHovoh68jBfe/aqtWmg2SRUh3WgSqBDeqiyJ7QXqRUPR0LzDw5vtF
 Wo6XAMD42jfakPgzC4h/UPKGMI/de22LDDZj4xveujLvw2tuoUQISM/C7cP3Qn8lg3HY
 qPAzjuIfK7udwKs0EAEk5vF4Za2yNxMpwj0qvY7+9LDi1LS6mXuc4+8JUN4KI9ZpsWA+
 i8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902725; x=1742507525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjWkTdQd9MfVRfJqngDibwxKy/v3SkwXlQiB4myh1To=;
 b=ObKCvbUJk2JEyy+0FhyPF3VyFq3PqLoxoAvei9+g/+LB0Dd68MaSt7htGTyimWrvqO
 NGgOa0HqFQzdqHXHG24OZVdm1iJBZ6H8JP8nncxZ6KOD1jV3eMaYHnn5G3Np94sKeISQ
 It55PVpDlF1XDyQar2LOyuugVjM94HUqXD+8WV9Zqw27J2iux7apjHaYL4yvEhFVKAE6
 quN/NSdbkg8PvtQCr4SPEMLR4YdAYaO32+CLXb1gzMpZYkDz5n/fTspX1uHyr7xxHG1k
 6ud3QD6TmYcpUueSVRmjH4nl0vXJpd4OCvKcOuqS8nJ+P7hevBjjwT9PjbmI7DeXio6K
 7cuQ==
X-Gm-Message-State: AOJu0Ywog+8oJcxvp5TGXjC8hvFz5bTWFwaSKkBU4zX/tZGS5FqwZFt0
 niwjk9sVXO/kUYHQuLuZDul44W4Na/z6KFbtDwdCbE89rBu8Y/sWibKMwi0l2qnvhlYiLzRjhJI
 p
X-Gm-Gg: ASbGncsGWDjdgdW6FltVr47TnQsSr9KPr/p2qS652bhUlxFtjtoTLVb8sEUL903d1tU
 BMZZteg1zUTXBTIRj/ta3VzbtSBfNjyzKXf9AsZV0EzTIi2M7ZeQ0m+ceZEPakgApe/jrcoxKFX
 J11c4RcXeMyVrz9OSTwAbiBO1Ot0PH/xTuEkPUNCcSFdL9IKI2UTYktXJXsZ4sV1xvmR47FlQQe
 5+OV06/2egIS0Lt5GO2HqcoBJ2Abw47yNtsIKFX8d1QjOedGPiyCQRo1oucjgzeQmR8f8wFMG04
 NsRuIeGSdVUv0jBsYS6FQnyDxyIqL9nX4db6tEG5LAILcxbcOC9EzWm8b+lyu4gpuiKiVxMH1zs
 0MeWxL8GiUmT66nqfTrIteg==
X-Google-Smtp-Source: AGHT+IFaf8qKAQD9PekpbwSyNl9wIUmRcmI4EokJ/b9ySo1h6tKKCD53G6jxyhXQSjA3sOesu/48Iw==
X-Received: by 2002:a17:902:e787:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-225e0aeeb64mr2196465ad.42.1741902724766; 
 Thu, 13 Mar 2025 14:52:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 02/10] net/ioring: implement link state
Date: Thu, 13 Mar 2025 14:50:53 -0700
Message-ID: <20250313215151.292944-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313215151.292944-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250313215151.292944-1-stephen@networkplumber.org>
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

