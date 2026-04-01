Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A610FCAC9
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 19:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DDB240A7A;
	Wed,  1 Apr 2026 21:24:13 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 41877402E2
 for <dev@dpdk.org>; Wed,  1 Apr 2026 21:24:12 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so423555e9.2
 for <dev@dpdk.org>; Wed, 01 Apr 2026 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775071452; x=1775676252; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=4hn4lTG6bIpqdBDdMaYOVvDj/xnUR2ax8tCtJd6Fm/E=;
 b=EO34YToFUCcDca+VToSOOrhks+r7EyxxCeZxEYYy7MJGLdV/hMmIg8U3eQ47tZGr+W
 WMMMQQfemx3Ns3crTYtOMNPB1Dnb3+7LQ1yFRhmb2/zVb8tQvaWH/oXEP9nKZIhNSt9A
 scXG9UeQ/+lcYOUNC/n5jPwIz8dHwJQ/TS5V5LoCa00QVVO2KehDtMsbZ4vHUghlYML/
 j5gys+SsZnbH95FahN5VmHXVp3laMKKrRVKJ/Tf1t5zeAwJiWW4N5S0LC7tjHCqLjsr/
 GEj4sN5PX+RasIPWbh3kZV8ztv/2A6GFoVhQn/nKWXs1XGiiZQg03hI6zjWpFiZo5+uG
 t5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071452; x=1775676252;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hn4lTG6bIpqdBDdMaYOVvDj/xnUR2ax8tCtJd6Fm/E=;
 b=F5ZQbXmAtzYb3XZVtn9Ojy3ecWwFenTzOFQEDTWGfpqAoTIXSAruuIew1OmqIEpiWU
 EoPTj1c90lsA2/Wx7mzmUYnxpTng5Ypu7nogcCGkxcLWxELbeBRKnCjiX+oIe8V1JExR
 /ubZ7UY6O77ZzwACsXzPaNiL60nDHq0W7b76XTd6rK5n1j4zHSA8OnL0FgZxl2vwHyIZ
 ESZLm1s+GF7unX+JgR4of7d90yzUp4v9o9iVx4cms0kB41TIzgRFT3C3A/Y35G7JdT7Y
 2m4X5kNxM+2/YyUTwsI4DCPEC8y+7NFqgmpWS19fMUJNloE03f9CyS2Uzz6Rlo20rrxT
 SFlw==
X-Gm-Message-State: AOJu0YzUcu/YcwGyTTpmpGrahUC4m23fdoVydI01CJ+6qRmobB/k9Q97
 wQBctunUzeZbs2U8Z/PPfXsWIRQJ12+EcDJqcZKlilwsy7Rj7s2hVuSQZwLD3W3E
X-Gm-Gg: ATEYQzz8d7ThtD4gou4QM75YX1ADCmMmTgeXF1B9MwgPIlUYAPAS/rmHNduKA1ciCUy
 DKWe5kHVk+Btdb3ONejZ9L708CyJMEsrft9LoDW+iEMA+LpxQoWsg/xieX368RMglYpWPkxT9+/
 x3DQvfsHx/O+sKNW20YsaFvaJPiBmpVNKLNaHBABLWjXNXfixNwM7nf8niAmBILwlcaXQngDPgp
 /nbiBiJsjPezizitGoi5gniOghKm4JLI+aSvPQmCjrKR5lbaeV25pKHetk/xhngk9DqWfl7Vjvi
 MPBRIUF+52mxr+LSQpvmuJoRHYjElUHiSer3bBIxFoH3fwpO0gAuwJzKqe+K1RXWYwXHwxLax9R
 cAhzklx5gAlOOjP2PTNiH/nprVjiqrpAaLLiNXUVO/GKLsiyIcFAztl2KizGaxg9L6vREbt2JRs
 42xTpneaQ5tCGCQ1rm9uOpJeGjkI6DG8JjPFdjuT3Mx0E/cWrHu7NyOfMLcSvBvYeFvS9hUpucP
 AzhDg+nnRIZscpD55LFBXbTBc0+ofI=
X-Received: by 2002:a05:600c:a0d:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48883591733mr88519245e9.14.1775071451425; 
 Wed, 01 Apr 2026 12:24:11 -0700 (PDT)
Received: from localhost.localdomain (83.22.224.212.ipv4.supernova.orange.pl.
 [83.22.224.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887a630901sm79220185e9.0.2026.04.01.12.24.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 12:24:10 -0700 (PDT)
Sender: Staszek Kardach <kardasan@gmail.com>
From: Stanislaw Kardach <stanislaw.kardach@gmail.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH] maintainers: update RISC-V maintainer
Date: Wed,  1 Apr 2026 21:24:00 +0200
Message-ID: <20260401192401.6243-1-stanislaw.kardach@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Change the RISC-V maintainer to Sun Yuechi and remove myself as
I'm unable to properly perform maintainer duties due to time
constraints.

Signed-off-by: Stanislaw Kardach <stanislaw.kardach@gmail.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..eeb55951b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -334,11 +334,10 @@ F: examples/*/*_altivec.*
 F: examples/common/altivec/
 
 RISC-V
-M: Stanisław Kardach <stanislaw.kardach@gmail.com>
+M: Sun Yuechi <sunyuechi@iscas.ac.cn>
 F: config/riscv/
 F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
 F: lib/eal/riscv/
-M: Sun Yuechi <sunyuechi@iscas.ac.cn>
 F: lib/**/*rvv*
 
 Intel x86
-- 
2.50.1 (Apple Git-155)

