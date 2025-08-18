Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9BCCA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA46740E2B;
	Tue, 19 Aug 2025 01:34:11 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 3AB1540E1E
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:11 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3b9e4106460so3767717f8f.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560051;
 x=1756164851; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXpGrlEX9xqMFN2SQrKUpPz5iwdHl4Wh7S63BZM5WfI=;
 b=dfYH7QDI8luK4ipdtXoYhE48hnpMH4kSJn2PfqzbB3ZYAhiLUgpYhYf9dzyLMhfdhD
 HsxVIFOP82LAERejY7ggSG4l36QPLs01LwduWqFJSMH7UFdVGSkb0vgtSJJvDgesgiht
 0B2OqR8JPEFntxjI1D/65lHbzkivvpF7dLEIZWR+lvuqAdwKyMGPzx5l3muXOM4P3e21
 WLEdezmVmlYhrzGmjA1afP3JGJQutkW8k4GvKOi/XB0+vLPqz/QuFwGQ/Gee9bQXjrTx
 qYIvshbhNOLlWRxnwXamQfzmWOBja8Fcwb/Qu8zwlo5pKpBkJN8FGzaabdh8B8I8LJVq
 yuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560051; x=1756164851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXpGrlEX9xqMFN2SQrKUpPz5iwdHl4Wh7S63BZM5WfI=;
 b=R3WKTkrM3hQGt25MBhWIM3JO+Xc1ixjdU3A/geHjS7IacEUGMnPJFCMchDuuYbcT22
 0kuUmQ69GlAzgX3L6mwZsEqgkcf18ICER+7LuSQAJN+InwQEHFxOkG+/6RujCpOE1X44
 ALw/ZjAkIEhu9pak5IOvZQH64ntxSNfP20Hlindsh5jgPLHH7Y+fZ6SKIQz5yNXqQLf/
 MvYaXpKDZinE4dwDoJ7j9z/z3ksWCFBBCE0qUcQ5qDpBKV30f0Ixf0De4PZ07ASQ8vqL
 eHMo51/WRZpBEl6L4UAsYzQGTHBABtiYAvSLTDdrD5S1ORVY9m4rjYEO1Eg+5Hg8gX8F
 BdMQ==
X-Gm-Message-State: AOJu0YyLek/rgJngWFDuCy5R+aP+r2A/0rwl01LCi/4Y1ZlvLTDS/IhR
 P6iZiBHzNFJyZ+mf4scN98hyDEZ815rND5AV+wUt4zt58zf32ltpG8lmD6xBzh6mYCyzJ+sBxBd
 NBKqh
X-Gm-Gg: ASbGncuiVAqzzva6jOk3Mj90bUW1GAVhAOyx08t9EWXx2kYxcnHjld7KsccMTGruivl
 CThr/GOt3LbN49WI2xmC7K71Jfq+NGehJpfqqyQQ+oV0c1Np7CYp7I0w+CyFMSOOOJeTsFjc1lt
 lvmVXKJoR0Sni6r4f/JZEynjpZni2q9tefJ4EdRJC4M+K+CSEmTRmy+QxyMgQ1jitEdxeVUWhFY
 3TLOn2qqWpZApAUfhlKuD/UmHIPV+G1NgqYN50Hgs33/V2tjb+LCLNQUvafNbicTzBJZbUAQGzG
 y1z3dv2/x/l4sgOgfWJvxRP/NkY4DTpPtXcGQyw7zbBWIgVQmWUVmNgN+tYABdilQ+LmmXuB9HZ
 Jy+kp1hGJASmB048Puc7NtW6SlAFLTvkcg4RRN9ONeggbKecObmRBl4KdHdRB+KTP1jNx7KcCrb
 4AQ3mTSCc=
X-Google-Smtp-Source: AGHT+IHPo4eNQOQ/ePkKwKr4T57pPh5+tW9sjGe/3R7yQsuoRt9VKzUD+BzGDVC1euOmYAdsNPp8BA==
X-Received: by 2002:a05:6000:178a:b0:3b9:1d32:cf4a with SMTP id
 ffacd0b85a97d-3c0ed1f4912mr281772f8f.44.1755560050866; 
 Mon, 18 Aug 2025 16:34:10 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [RFC 38/47] net/softnic: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:49 -0700
Message-ID: <20250818233102.180207-39-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/softnic/rte_eth_softnic_internals.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/softnic/rte_eth_softnic_internals.h b/drivers/net/softnic/rte_eth_softnic_internals.h
index d3975dad10..5b4361bad0 100644
--- a/drivers/net/softnic/rte_eth_softnic_internals.h
+++ b/drivers/net/softnic/rte_eth_softnic_internals.h
@@ -7,7 +7,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
-- 
2.47.2

