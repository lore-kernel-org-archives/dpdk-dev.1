Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D068C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 015FA40DDC;
	Thu,  6 Aug 2026 07:10:35 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 744A240DD3
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:33 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-cbe3fed2f58so1474595a12.3
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993032;
 x=1786597832; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lapvp/IodBZRVG3QgR46Yu+3jZQ1Mm2TKg938FLk6VM=;
 b=klufY4yz+7H7I6vkrUU70b0hNp/4K4fKYqDdaT0Vy8jH3Kd4KTZBX5M9vlAGHSKKD/
 T0rIiCibHQ9mKmWVBzK9V0Vr9rJowiWv2ekcRKTj3afGme6Fb/+NErI7LglILrzzgSff
 i1tRknOh1BR25RmzzcvrEqMk8a7topQpm+8f5zHMLIeuXIK+nuX99jSOpF3VsKqI6L22
 hGeZ2qM0B87dC3YB9oWnmAEelvwS/AxZcjdSrRX/CUJd/ePCXLQ5KdpiTfv/UgpZkwHL
 dU0mQAM1fqab9ljM3WicuLicGpv3CBBfQdd8ILtMyETvsD5d/Nln16SxBfqlxGOmshif
 wHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993032; x=1786597832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lapvp/IodBZRVG3QgR46Yu+3jZQ1Mm2TKg938FLk6VM=;
 b=lTrfBiWbnQJrpiRVP5vlkU0i8FwyynYBcyNeCLVX6tbrTbflIHfyC1NnKB9HJp26/S
 ckVoDTmSFgR14FTzIZ7fkFl0aiJ0qK4yAr3iD9frMBgoNI0dgaVb+aYOt0mBp1GSF1uc
 Bwvqg+lt+rD7ogTgPfRG4e5JXW/rVg8PPTLsv26J1FeagXjIa8gimngWjhsKVxL+dvRW
 b37e2GKFsQTK7thwhw7qVnjEWIImblG82whLad8oohzTTKmXWr/8R2FEsDgYevluD1nT
 azOcDCKzAipoHT7DNUnekBRD780fGuTb5pbF0iifDI3RNrlPY+cFdHgfnH4Cp22QwvAN
 zVxg==
X-Gm-Message-State: AOJu0YylJvOmcKXEf3ITazOXlVI3FXIRGTYIsV9R974C+4NPZ1dpeunt
 4aC33kB2cnq3vWm8WWdajhxTkgQniIWHPfLS1qytW7dM0SL6xhY7JNTel6s3fc+mYtSOz0moWFZ
 OvPQq4I0=
X-Gm-Gg: AR+sD13AGjA8Mk8gbL1WhLCE+jTyrkDzE5VZK+UkKcd2T+tbFq434tY52DTOAdNc+qY
 yeC+yps62cjFIcgfZFLb94gA2OvE7W/DnjeGBXMDyl/Ka+tsX1GP0DEwjiNAUwTOYLMg2qrMxT+
 FDPySwLploqMtSOSJoDNP9cdxh4cgyxxYDZpnPbt2QDUXni80RCrSxNOKxqaDw682TokRvqY/CA
 XUWUGjt/RZzl+/yDAusVYCJUj4GXh1pWMp9VZ2yIbcua7dtXyp6y0ciP6KVNkA57BrgHhtVItBh
 NJ80WN5wSuyV9LxDCHeESFa1Rci0GigCutCN4NAmfrgtJJap2uEpaf1BYGj6FI/ulPc36Rt7wtv
 kYYFy7HtHirWvTymry/OvNg6WPZZ+XEkXtrXetn52di87cevA6gxRGKkJ7Ny99NxXphvDg/H9PO
 IyAxs7A4MkS1rj2MMKqfe4xuBvjUzmPKFJGN4X3kLYfpxv8/hYnGSELk3JBk8suxvHkDLjEzqHf
 zAmsRcDIHXgnsrPR7jokEsl0Cs=
X-Received: by 2002:a05:6a20:7f86:b0:3bf:9c93:ac44 with SMTP id
 adf61e73a8af0-3cb85ea363cmr10802062637.19.1785993032621; 
 Wed, 05 Aug 2026 22:10:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v4 17/23] examples: include network headers
Date: Wed,  5 Aug 2026 22:09:11 -0700
Message-ID: <20260806051004.166778-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

Don't depend on network protocol headers getting indirectly
included via rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-macsec/main.c | 2 ++
 examples/l3fwd-graph/main.c  | 1 +
 examples/l3fwd/l3fwd.h       | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 059f8a2170..e07769bd57 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -33,9 +33,11 @@
 #include <rte_debug.h>
 #include <rte_ether.h>
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_security.h>
+#include <rte_macsec.h>
 #include <rte_string_fns.h>
 
 static volatile bool force_quit;
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 5f89286dce..79dee4d103 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -36,6 +36,7 @@
 #include <rte_per_lcore.h>
 #include <rte_string_fns.h>
 #include <rte_vect.h>
+#include <rte_ip.h>
 
 #include <cmdline_parse.h>
 #include <cmdline_parse_etheraddr.h>
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..db7b746f59 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -8,6 +8,8 @@
 #include <rte_ethdev.h>
 #include <rte_vect.h>
 #include <rte_acl.h>
+#include <rte_ip.h>
+
 
 #define DO_RFC_1812_CHECKS
 
-- 
2.53.0

