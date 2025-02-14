Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0A6C02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:22:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAF8040670;
	Fri, 14 Feb 2025 18:21:51 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2F1C940693
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:49 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-220bff984a0so40905895ad.3
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553708;
 x=1740158508; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmS6C67gqT/5w6zHyptHE2BI3maLr1NNKbfa06vuclU=;
 b=zAV4FdmxkjF6Zo6RJT+MF6sVSgVvF/GoBgeUuR95FrTMBxTWcC4TTvMHwmlnt7XORQ
 WxcuO7aX3VCLbdJVhuPJJrnxGlWtWJUnaClTNUQEBqzO2IkVq7b6Y81tpm6TbLfrWLSY
 UD+jJfDMh10fbFw+pDlMnEhUyc3o0TnrSLOfdR71xu88Cnoddz0zA4qjmzm4KrvRnVL1
 b9q78AMfEcbR8kx/U0f2Z/MYAeXqypWVHGsQTa3TGmq6PSe5TkUQQTh16RxCshPxdRs8
 M2xi8qbwdou7r3VJ18a8Pp/3kbPqaJ14dtCJ9uRwJepuqw9AlEqCaJ99iOFHMZEvArUh
 PLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553708; x=1740158508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmS6C67gqT/5w6zHyptHE2BI3maLr1NNKbfa06vuclU=;
 b=W6CxbbednOlIbvpVIxRFv/l0GBWH5Hzp3hQ0skzOCvrYk4tQym2NJR7+FOyDHn+5sw
 GFeOWalj86Us1avSVOnCFrxPYQ9Z/ncT9rvf1JstbNmgGV8UIwbvKOWdGAXModLOt8ah
 QDIuVF4m8ZT0Ia+lTeQxT/LEfvH1JwVUZEUIfj7TWl63M2AVnfIEBAkCP9SbEvpzuAjr
 y1xXRDaVAkxjolxepwC/7EYMLHjXZktZl5FFpPSydkvEHsWF4Aim+GOKSNeny6sdDXkK
 A/Us78AZsVTCoVePDycJEjHpXSL3iEXvq3HyJnRVfELb9t/3uqaha2rRjda7EaJ8MlGa
 sP4Q==
X-Gm-Message-State: AOJu0YysVf6prZVs0k1sB5X4XciNF04BcSnkOJWjFF0d98/YoMOYsDQ/
 cdwlihVQweH2X1FuBMtIqbM4O+fNWhPPRf+1jCKmZXYBmlm76EGikT0sdTR9lYHAPVnZmc2QfCQ
 EsEA=
X-Gm-Gg: ASbGncu/IQoAGq3e+tRS9Jz8N/zy4mJqL7dvbm89+IgLbY8fkeZa3DvCQgsTlZ+q1mp
 KtbHTny0ML+bLjwTT3XIoaPAuiev0umC2swU55fmwoMUqVj3X6FXq/x/cOjeo2yT46APtA2RvbV
 CMdVtFNnUB9SnkOPzPxfwbIgGTu61l5V9aetwfC6IfdqXkV0+aIdu59SJC6FZgDiuHvg6MXp7VA
 1MjOKkR70Uu3gV+ZPe3I5OD0WtBR6e7mq4dWZOfnrfZ/FQIcjynilbs/EhUXW8OHGy51yR0vYom
 7rHwM7dzlUlwype99UyzOFnZkljoevN5a7m1ilA6Q+fxWIRGgL4J7Sh/VUmxHTwwuhY1
X-Google-Smtp-Source: AGHT+IEfM5gTls7GNm08OGIfudfglspr375yFFmhDk4zpYSwf72jWqMpo5WXccOHjKOwokavcb1Wlw==
X-Received: by 2002:a05:6a00:1256:b0:730:91fc:f9c9 with SMTP id
 d2e1a72fcca58-732618b0b1dmr265473b3a.16.1739553708298; 
 Fri, 14 Feb 2025 09:21:48 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, shreyansh.jain@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 3/7] bus/fslmc: fix use after free
Date: Fri, 14 Feb 2025 09:20:11 -0800
Message-ID: <20250214172134.73908-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214172134.73908-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
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

The cleanup loop would deference the dpio_dev after freeing.
Use TAILQ_FOREACH_SAFE to fix that.
Found by building with sanitizer undefined flag.

Fixes: e55d0494ab98 ("bus/fslmc: support secondary process")
Cc: shreyansh.jain@nxp.com
Cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index 2dfcf7a498..6ae15c2054 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -15,7 +15,6 @@
 #include <signal.h>
 #include <pthread.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -27,6 +26,7 @@
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
+#include <rte_queue.h>
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_kvargs.h>
@@ -403,6 +403,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	struct rte_dpaa2_device *obj)
 {
 	struct dpaa2_dpio_dev *dpio_dev = NULL;
+	struct dpaa2_dpio_dev *dpio_tmp;
 	struct vfio_region_info reg_info = { .argsz = sizeof(reg_info)};
 	struct qbman_swp_desc p_des;
 	struct dpio_attr attr;
@@ -588,7 +589,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	rte_free(dpio_dev);
 
 	/* For each element in the list, cleanup */
-	TAILQ_FOREACH(dpio_dev, &dpio_dev_list, next) {
+	TAILQ_FOREACH_SAFE(dpio_dev, &dpio_dev_list, next, dpio_tmp) {
 		if (dpio_dev->dpio) {
 			dpio_disable(dpio_dev->dpio, CMD_PRI_LOW,
 				dpio_dev->token);
-- 
2.47.2

