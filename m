Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0CDFCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9C3140A4B;
	Thu, 26 Feb 2026 15:34:13 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 8C79A4060C
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:07 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4398f9e3b40so900150f8f.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116447; x=1772721247; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRPH6vpFoQVJz5/wx2skp5qzpIe9crg1cbFFpYMoAFE=;
 b=m+3TLdpzNkXlJJTEBGFk51LEaEgBjlzESJzndyq/8QLdaPH+OUWfYR+sKqmgXXOqN1
 K6K1LmLfSlvMKe0XllVYf8vyauWcrwpPbXA0ppKvh68yqe3ky1DlyPy4wEcdrB1JBaI1
 Wd3QfntLh/2hQ0vDMWmEsO0KGhhhqXnwAYmXFUo4dimlNNp+ZiGleQkyJvJBNCCQvRDd
 5xH/upQgF1JYq/2mRV4R7y5OZKcTLCOwjIPtcU3yW2cWqFg1RapzhqNrzY56OG9pY88w
 zCNdoCuWboy00PchekZ8Ai/WVkdPUgEfVvpjQwq+klUigpsVS7m9nNPDF8EZYjo7SEsa
 hPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116447; x=1772721247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KRPH6vpFoQVJz5/wx2skp5qzpIe9crg1cbFFpYMoAFE=;
 b=mQJvwoP5pIHoW9RHDyaj/HsKcVDDLRwVXcLAJiNdmeSLwMnTJCXc5A/HCxp8N6kpR0
 RSozPLC5wTdxyy3sd8zuB4lCETHI1sh/GDAVu3FJTSt8TNrVGPH2kFFC51GJMync2pRM
 A6Ly5H4phUk+9KjSEjYz4W2xcnuyNewxZNw43CpURc70UehwAQ+r+VcSJ/d88H/mff8x
 57yo9v1zcFv7Bf9nBOLnu8+rHqMrR3pmKc4eFXDrd3SneTIcLlhXMfSQVnOBG+iIaap6
 GVPr+6H+1DVJe+a0sFiUEg10gOtwO229F58HbYCWeWdlM3MbRMg6Mj85kT+PcKKyWARC
 wVAQ==
X-Gm-Message-State: AOJu0Yyxktd/LUJwLLn4/fJMnGFdbp9RMvxnXlpripaQ38Ca6fxc2jZ6
 HXc4AffjmFPeS3Zg/XB0OAeF60IrKaRM6gcISvRmAvnjSXMNb7SyHWFfozD1Fg==
X-Gm-Gg: ATEYQzyGnXLYVM/qXw7iP6a1u40+8P2hdis/2qFrYk/piHAekJeaKU+a8vldeX49u39
 VQtDKYdMGnhEP+i1Y43+JFwFn3YdNrXIAmkxUi7w3TWZOBbUW2GH7NQIfTyQ3YailkMvddTd16+
 A5EMh0C8wCi3QL0LcjxEazrVcWH6gW4Il/huWCEvrJ/5czgR6/1OOHZM21LyhLJEZU6h6mPobia
 gBQw/fof7WdinyxDH/gXB37TKHU2PmHRNrcHSiiPWS5cO2enip5k/j4vEVpYzSQ6p8Y4FF2GlWT
 /qaI0BzC5X74J6GDZ6JIiSUMM0OcdM9owQ3exD5nBNMjkurodjfxYy7R9fSJvu4MAnefZi2R1n0
 DZHLkr/MY0RQbZ0wEg6Lsj0rpQy7wo1ZJdAy3IaxFyHLpFmZNJk0Q02VtRO7JXBr9qY0Cgse4ND
 Ms8Tl5YsqOzUCgw7BBQEP8QPYSIg==
X-Received: by 2002:a05:6000:420c:b0:436:3536:f698 with SMTP id
 ffacd0b85a97d-43997f37caemr4456314f8f.30.1772116446524; 
 Thu, 26 Feb 2026 06:34:06 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:05 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v2 04/17] net/dpaa2: fix resource leak on softparser failure
Date: Thu, 26 Feb 2026 15:33:28 +0100
Message-ID: <20260226143341.282188-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

When soft parser loading or enabling fails during probe, the error
path returns directly instead of going through the init_err label.
This skips dpaa2_dev_close() and leaks all resources allocated during
probe (queues, MAC addresses, extract params).

Fixes: 72ec7a678e70 ("net/dpaa2: add soft parser driver")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 61dcfafff6..3658e24dd2 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3164,7 +3164,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in loading softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 
 		ret = dpaa2_eth_enable_wriop_soft_parser(priv,
@@ -3172,7 +3172,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in enabling softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 	}
 
-- 
2.43.0

