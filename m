Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E05FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:51:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F1A40BA5;
	Tue, 10 Mar 2026 03:49:50 +0100 (CET)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47]) by mails.dpdk.org (Postfix) with ESMTP id DC81540BA4
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:45 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7d73be007a1so2626867a34.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110985;
 x=1773715785; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkxVgJnhmQy6SsBFsffX/xocdKVo5XZqNEo7pyihiUw=;
 b=k8Q/RQF/E1RO/yru7FHM+wafz2PORSGuO+u6qRRKlNoNZ/9/T54vbGD6aZxZfMmf/e
 RtfjNxRZfGw69QZKU8KfhBStVLX2iPqYlPioiRm8xs4RTfo/4pBJy0Haacid01ST4KAT
 IyNJ5ClsaM6DfXI89+0L4RfdLQWl+M3XS5LR2mNgQGPOTV6nnnh4mt4HE/kpwd35Xug3
 FeKo62u4CfUoH/JHJtsddBBcF3Cny/y5FseCyc+pHLfg/dAPkc7at5pjTiHO907Jr/3K
 wLwYfjfhqR+0aIjk6abtw30g7gMvUdGYMnsL52VdSfJ98O2Ij3bYVrcn0nuJ9aRg8O+H
 nc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110985; x=1773715785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LkxVgJnhmQy6SsBFsffX/xocdKVo5XZqNEo7pyihiUw=;
 b=bxjoP+TzxAZqB8u/AuL0TN/4dCIJqVWpGSy+XLBYvdPJi1lIAx29EJW7+4p2MAGij4
 msagnySX6fRjr93bhoG6DPr03w+BtByG/RmlmEoCtW9uwUBw5RvdKtCa/al25yS6x1wL
 wcfiFfrMdE7euzPSwNUaFxpvvqmkjv2a9SpecWbRRnguTn0ETIX5HHr2xVFQcGrcSeni
 bWnzUuEPFnussGdMSXZItTkLpOZpyrMHDrf0a+tcWBUatNZ5p6JOSO8ABgojk0DLvJsx
 d1oFfCKxMwIXVTdLZIlOJzl2JCUX+y6Ya4NKZwc9nJ1u189NN9E8tzmZAfNTAvcwdjah
 eIXw==
X-Gm-Message-State: AOJu0YwughQsQg/UHlQ3sScv9NML7HZzhUm3fCw/cGFU/61cMqTgcme/
 r04EIdl4ffnmPBRI6wL7vVoMMD2M7LnMvt/dbPcq7fMZ+q2XLRGpzI71BuzyM2NWyx4WybsYN9o
 7r+55rJY=
X-Gm-Gg: ATEYQzxaQdoXIMUSVqpiqiOLkBep/1WOoS9PVlgugOxzLUV94a5suAN9V7kZSx9/tEw
 4cXrPtZWOwG2H4EYx/NuGCJxnnmjTF36sXcy+9smmNuAJWwieZxdDu0yPqRj30EPPa0rvoHo3/N
 NGHoyix8+UND+fqepswULMWm3hHAs/J69uxIhSwK+/E2hQCv6j0tM/l9PDqLpPLSVzEK86HHXH8
 9m+sGnkdv0ojLq5g0+lRqWw1nrG0OFE7BDWFiv4k1uSyG2QOZye/bCFNXqTCldB87TbZkvlZ77C
 GuTj7HglfOmH3+cuksF8BfP7ee/+7uI17S7aeh+oE616TApT8d/FAB6BzhDZB8S2Jyz2OfntYpX
 scdo3Gx4oi01lQFCpx+Nvb+0uOo92EdIjZ4tuQOea8sERJ/JGwpzWZL1GH4ckVIhc4vahncFOry
 4WOP5ymBax0a597x+77KOuUM3/QXg06P3s
X-Received: by 2002:a05:6830:7305:b0:7d7:4cf3:76e9 with SMTP id
 46e09a7af769-7d74cf37b62mr2678477a34.2.1773110985154; 
 Mon, 09 Mar 2026 19:49:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v19 15/25] net/pcap: reject non-Ethernet interfaces
Date: Mon,  9 Mar 2026 19:47:50 -0700
Message-ID: <20260310024925.476543-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

The pcap PMD sends and receives raw Ethernet frames. If used with
an interface that has a different link type, packets will be malformed.

On FreeBSD and macOS, the loopback interface uses DLT_NULL which expects
a 4-byte address family header instead of an Ethernet header. Sending
Ethernet frames to such interfaces causes kernel warnings like:
  looutput: af=-1 unexpected

Add a check after pcap_activate() to verify the interface uses
DLT_EN10MB (Ethernet) link type and reject others with a clear error.

Fixes: 4c173302c307 ("pcap: add new driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 6b728c6009..b9e828f5a4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -642,6 +642,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		goto error;
 	}
 
+	/*
+	 * Verify interface supports Ethernet link type.
+	 * Loopback on FreeBSD/macOS uses DLT_NULL which expects a 4-byte
+	 * address family header instead of Ethernet, causing kernel warnings.
+	 */
+	if (pcap_datalink(pc) != DLT_EN10MB) {
+		PMD_LOG(ERR, "%s: not Ethernet (link type %d)",
+			iface, pcap_datalink(pc));
+		goto error;
+	}
+
 	if (pcap_setnonblock(pc, 1, errbuf)) {
 		PMD_LOG(ERR, "Couldn't set non-blocking on %s: %s", iface, errbuf);
 		goto error;
-- 
2.51.0

