Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07230D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB27B4065C;
	Fri,  5 Dec 2025 21:16:02 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id BEE2940667
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:00 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so30296635e9.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965760;
 x=1765570560; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=iISYBIbXGjOpXkOoA6Iiry9QTEQanZ74YvxH49xLnDbbL4NN1/hO1ToNowZFdgWBb/
 o3NdPlEmd+YUvzzE0rIniVXKVarNx29/xPuNwXxnYQ9ix+TBuQoq9OUFj4zqRGQkkIl+
 etSh/wPfhjW66JlR9woiqvOrNPl+FmuWIbanfQxmagYuoERrXQyTjqALAlJCSQGekHiz
 YCpavuT8IBNQZd8QnvKoi81TiK9izeiqyk/kc7qKzx+yXVKGGCs3I1h6MkpDrFfY5Y79
 XaD+T4Fpgv8PL2o6JKRUp5UYgmoQST8R0sbAhUSEiP1SmXh6ptJQlAN8Vzjlpc2iA+PK
 cvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965760; x=1765570560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=EM8Qcdi7liA9Hm0FNGotrg0KSrBii+kRa1w4zlR0QG/K5ZhYEkYeqKpV23ObaP9GtH
 rYRJNzzdEJF9bxVy+n4YY9aMmzA+j3XVGpKKmXePxYYwOLZrxLu/eE99RdCloThmuD17
 53GIPMEF5QjahwcAp9e8FFVSBazYUaE+zuPqLqAAuGnMzes4wSMnB6dZyOi6T9uD7Kn9
 t5JoumFHcfdwHaDzozzh8363vMstIYIrZ3+shFDShD04c656d/GkMW6Mq1JXSwJmPtmt
 Ny5bmUmzJCUGVNn+0qmOk1cnDjC/80hMYNzZJIyH0q5XYWn0VlX1wQ8PVDDLisjRhxZX
 Hipw==
X-Gm-Message-State: AOJu0Yxy8/KfrRtvnMyExnGr4AtJG4jS7jQEiXO4S+g6lAZvFlaHgZGv
 2K1lCS6rZGCcAFZktS3dcPQP0bEOfkZpayDWRutyVwtHYLjQD/p6twG5DG9cV8KRffVRJU4VY9f
 VnzZw
X-Gm-Gg: ASbGncvPJefvTAsqvCUFNxdE/hUhuJjROCGKKBj74fV333kz931BWFrYZyd44XnyCcR
 ENh5ZH9YUSlgMOSFLC1R+WVeK+Sjxl+dgWrkK0ZtpZvMUHk6cLRPJmPcMdjUpHhdDatFppNJ742
 CYVRAB4psI7JZ+5wlF7pciHFhxivToeuL1BYrZLeQlnh+9zqHX+bpOYU3Bxq024QV8sxMH/J1ZE
 cJXeX1DlnLNg2LdLQ7ioaP9cqYKloV3JtDxqm80ImK9YzxrfXskzxoRav+DaPO0EGJcxDlxMHGD
 AA7nNsVB4jXByKhd0U53SruJWp5K4avdX93flTLGfhOtTA/j4qLkiz5Tm51ATcBHhmkDdEFcrLr
 bCCCE4qF6YPUzur+gU0+gFxDBBYEA0VZIu2fwOKJr02kXtqwWvdIf8FUcLOWLT/wMsE1oXUvO4A
 4rbwj+Exwnvswk7Dw2+VCa11epTpRNaF5fx0+KBWY5WJk/XDa/qQ==
X-Google-Smtp-Source: AGHT+IEMHVhJnRyPtJ/jKfvLNAaBobrmdrSgDETUinADqHg8Wmst5nrfIFTO24QiIh+aY2Vk3Y1T4w==
X-Received: by 2002:a05:600c:1d10:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-47939e23e64mr5570205e9.22.1764965760378; 
 Fri, 05 Dec 2025 12:16:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 09/16] eal: add check for sysfs path overflow
Date: Fri,  5 Dec 2025 12:11:38 -0800
Message-ID: <20251205201537.251131-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

