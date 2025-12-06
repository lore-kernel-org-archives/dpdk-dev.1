Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259BD3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 721504065C;
	Sat,  6 Dec 2025 19:44:34 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id B5BE340395
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:33 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so26011995e9.3
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046673;
 x=1765651473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=AzU5PCHQ1N1WhRHCChTFkhaJKW/iL7Ey3R1kTPJjtE95qYNbGE0vyfxsIPCSWCAQVM
 GEfXlS7YATLZB6OtgwW9Ta4Y6hbky4EKbdOmeWdMOAN8v6EMjAdCYMGrR9esnNz5rHjS
 pbo2nsgxdatUqxKE2gRFoO+kwDwoPXENCef8eslaZz24eGRR+TOEq09gPqhmHWJquVQg
 OFx28pQeOZE3i13P2bop+a8f0Vpq+q/ezdEuDuG2nKR+QxeIfaVCdwQvLCj/PNvMYaav
 yv9B2ZRkiLTAVqm9Q2Uj8SWmyC897w8uP6j9qVvjV1aTN0ClZFtgOTi2lwu7aa3i8h07
 XiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046673; x=1765651473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=qCM85jOrBD2jMLh/KFt7h+AwS5ZkKwOapRhIomfMO+FsvFGJgO9U2fqp5UERrtJd3s
 WsIfhzzZvlCNBtCVgkk+rG/N4xjUdcJtIur+5hV+R7lSvU4p7sH3RiIPZH0AssT6goeB
 Fo8hv+VnSLmgEd52pMxfd6QhgZubg+VkQSRLOhnFkObhw1AyJfSYRcAx+vOqsBlwkrrV
 SjtNWy3yOJG+yt5rrBjFTB9wZ3JoJJhsDsZWCq28Ag984apxiRxLw2ZB1Dil1lltsbkt
 I8NmOmNLzXryyGRqUeXFnoslnY2+4qqR2U43MmCHSRM8ivX05Y8/nwa/kpUXfHwawQaC
 IjsA==
X-Gm-Message-State: AOJu0YxhzvNmOWs/O/sDARC633RhT88QptyLT6iwZUn4lCh/bvnDTFWh
 +/ouy8CaaCABI3q0lnLguf69gJaHWiH4G/ym6QjudR2mA5pmhbUk2h7OJ+/uju7KS5iYlUpxsNS
 iY8xS
X-Gm-Gg: ASbGncvZAegmPobaQpNQDsA77zO4lZO0RccpClrYq6QoWVS4kYTsnJEIcm+eRD2ZGyJ
 tT4dahqIMu8sKnvNRdWr/3Oc6YoLaL8chSIQ71ALTOhvmId3m9japaz74A2xQBCS0cFwNV9PSCN
 ELQsajndp/S9Zbe63B30NtCbhkFB6vFp90pOogw2sS5gI0ddPBY0tqPWRiBVXQbbvFieezNp6lm
 FtmG7yf7OdjucAabspoo5XnfwljcV3j/9axxR6kyPo2sbM6lW6kNPMV+8XmSqkTzsekOBiPnfXO
 2yRT6fZ1xgvMqeGEVoVAwkmNL7UDzFLBT+c6Ma3aO66AU6eaBoW/NpIdahbic2nOL+wGQkFGO0A
 0l8tZWijvtCD9Ao653mgyr7vhXKsALK3W+Qgcnayi61jN92AZssL8zdRqTzQqFOi7E6mX0dZ76E
 omxOSuWUSH+tvRdHLzaD5dsXx8q71DwbZvHetzovQeVfrPd5407Q==
X-Google-Smtp-Source: AGHT+IFrpk8LwLy3eUtjmZPZkxN7c9VJDu7j4g8R+WPxrBBqdVPTumHumT46uWOfF5f4IHD66yoVlg==
X-Received: by 2002:a05:6000:420b:b0:42b:411b:e487 with SMTP id
 ffacd0b85a97d-42f89f0b2c2mr2866386f8f.2.1765046673272; 
 Sat, 06 Dec 2025 10:44:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 09/16] eal: add check for sysfs path overflow
Date: Sat,  6 Dec 2025 10:43:10 -0800
Message-ID: <20251206184410.542725-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

