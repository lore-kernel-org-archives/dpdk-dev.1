Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93594EC110E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83E7A4025E;
	Mon, 23 Feb 2026 18:21:42 +0100 (CET)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com
 [209.85.160.43]) by mails.dpdk.org (Postfix) with ESMTP id 682B1400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:21:41 +0100 (CET)
Received: by mail-oa1-f43.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso2688207fac.1
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771867300;
 x=1772472100; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TDnxHxb3Yid2oMVtPGFfXwdwVB5hHlreXel38ClvUD8=;
 b=1KTk7FhHBrYq2k/uu0SWMpIIQHmeXtZvLMsL9owQv8CbaYKU6tuFZj3ccex+iVKlqo
 aniwl/lweQl1FMrR43mgX/R9RjEcrGCbrg6/jrUpan7BFhsYRpFq1lFtgVQfaTc3BtcY
 CmD9mZvhqUkmSd68QGuuhP/WOIA5iuzBz8fX+ynlrXX/WqZ+sZ+pWgUzlpHNxSnrT8aw
 sfeYqBy/RR/NBW5akAf+lfFYgtBkCeKS2d2b2s53pe4pmxl2m/4SbQaaWGtDz/04EvQU
 QesdlA8Dq6p3RCma6qlg//LuOkDKHOkykCnky5U0hW/0k+rL5TxMqe7H0ROuzWkrkO7W
 9B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771867300; x=1772472100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDnxHxb3Yid2oMVtPGFfXwdwVB5hHlreXel38ClvUD8=;
 b=ecew/ZZHjLYnz3ygDOnl2ZLBS1V5Qx9zBOL1uXZUt5cPH+x2bd3lI+/qsyPqakCpXe
 wKyd+x34DzuZlA/u4c9lWTps61+PtTxgS6Jc2HM2T0mk/iJxJkFWIb6ZYlxBvTd7V8YN
 NXgWUwBRjtWrz/nPwMl75TNSTcZez7lxqUc2p24/O/8JGEGfAuwn4ZooDYyjyzAzWp18
 l5iFK814uoyquABP2WQgGvXL/qclNida5dbcXcCcaE0pexLnuNBQ/zrsEE2fxUQWVsz3
 fpxXbMxZXLMQzD3/4OsOt9b/KxABMWWkrRxuOX6aZ86fzfcKsx0QfbJJcQ1raGsh0NTg
 OiSg==
X-Gm-Message-State: AOJu0Yz/aMWX6FDvyqsFst/idpBz23Zd9S/8wk6B4ZDr1ZY0g1DAl8lB
 WMKE60bCWj98Oed+1qg3Xr/5KpltN95X5xZA0AU7ZZEZ/xXurkc+Zh8eX2JENy/ZSqR8H9KvDLa
 qss3+
X-Gm-Gg: AZuq6aIHaMS000zacxg5X5TO4spBRl8vYkrBPMMuQQ0Ro6CSGV49iJu3jzNcXDrSqEY
 f/ZFTiSk9zQPWrPwXoxmKsgTKZ1+ImYzyE/7A2Kww9tISi5nQmbFYQzpx3n+hUDqVGql/a0BYR3
 XVqhzoxUPUnWMPf/afMpmtqvgXPWBs5rT8BsZqi9XpW2Se2gEnS6W1Wqldkh0yk/LdjbKckeHbJ
 0ZYgkqGPRqy7ar2zihCv5BrVgbxWIfAhNHQGnguhfB5ZZ0ELqvknBf3dMuLvm9UxsQCCir3nWvL
 8tmtwQRS1BmMPXBwbg+wB8giIyWdzFfKLFy+etFGbDbnSBAagnb0WjOMURI39b+N5l7OCaSwIpQ
 KIXMLyUB7FUihH7ZRAmsN/4qWZ+IMVWh4dKnXIzABZ4pQ9v5xMEwnYz79/cwzvi+anpUFyj+598
 bR5CD/7Vm9ghNkBNwryPVR5zvEthbJ6T4jmhUN2lafoOYiR3A9ZPg87ujfV9VKSMi1EXkguG8x
X-Received: by 2002:a05:6820:3091:b0:663:23a:cafc with SMTP id
 006d021491bc7-679c46160d0mr5693374eaf.67.1771867300536; 
 Mon, 23 Feb 2026 09:21:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c5630827sm6445652eaf.3.2026.02.23.09.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:21:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/vdev_netvsc: block driver in github action
Date: Mon, 23 Feb 2026 09:21:37 -0800
Message-ID: <20260223172137.93558-1-stephen@networkplumber.org>
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

On Hyper-V systems (including Azure-hosted CI), the vdev_netvsc
driver auto-injects itself during vdev bus scan. This interferes
with other tests.

Suppress this by detecting via environment variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vdev_netvsc/vdev_netvsc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..39d52b7541 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -805,6 +805,14 @@ vdev_netvsc_scan_callback(__rte_unused void *arg)
 /** Initialize the custom scan. */
 RTE_INIT(vdev_netvsc_custom_scan_add)
 {
+	/*
+	 * Hack: github actions run on Azure/Hyper-V container and don't
+	 * want any network devices in that environment to get intertwined
+	 * with any tests.
+	 */
+	if (getenv("GITHUB_ACTIONS"))
+		return;
+
 	if (rte_hypervisor_get() == RTE_HYPERVISOR_HYPERV)
 		rte_vdev_add_custom_scan(vdev_netvsc_scan_callback, NULL);
 }
-- 
2.51.0

