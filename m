Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A1FE63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 20:25:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A58A540647;
	Sun, 25 Jan 2026 21:24:44 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 1616F402D8
 for <dev@dpdk.org>; Sun, 25 Jan 2026 21:24:40 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so42847455e9.2
 for <dev@dpdk.org>; Sun, 25 Jan 2026 12:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769372679;
 x=1769977479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azWx3Lxj8XOF422TJqOLA8qWkgEFQGUNUOtnoXMwa2M=;
 b=J3pi3qMvxbRr3EaFBoXCtJ2zJll2nErw4R/WD4DKqGMqqBhaoTaZhZPlt5kpwPoMRz
 NqnbbmZa5JkMaYRC3l7xD9WSQAimJOpKZzvvWukvR+obtz61HhtjH+9XsG6V6JCCuaJv
 +YWaDOOaBToTDcuq5BC6MFkBQOIEsvdSYpXhBPFY9fJTRi/PaQPhCUisyWnsKbuSTRa0
 zF804vRIBlTUOWRVkVTxJhuPWfpf9+rgfwKMf06BAfhc+MqagS085gWX3jZ11FgnuzyW
 VpCr9YDW+XQ2D5NEICvysRsO4vS5673zn6kBXaDrnVMFKBjyiJ30nnmY0qPLAm+KXMut
 XHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769372679; x=1769977479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=azWx3Lxj8XOF422TJqOLA8qWkgEFQGUNUOtnoXMwa2M=;
 b=ecgOynUIHG2Vr+/9ajyQOGxGP1mNQ6mK+FBA2tNcwTNRBqSV2sggDC/bgmv70Lt2NY
 /9VCMfMOEyMcT3n/NTG6QFVMiSfN3rIhwwgjVJXiAJ9BxktwA8h/wEdSZe8cswdsmyEj
 Ywk67COQaM1dy86LdrIqvf+lIs3DhH0a+8d+y2sIS/0tTydvUgFW/P5e6+M6DoljYSs7
 U3W9DVT6cB55GUl94oy1I690TZm2G9aXnTLOvsw9OggCVIE7fiJhdzH2Ilh4bJQhrXjE
 OMXtfm7TwHPdxm24+voaE9km4Z/9ANF8v7C6Bq8Bdu9g882nuY8vPmenIOouLe4w9P+N
 6GxQ==
X-Gm-Message-State: AOJu0Yxq0IR8YzecECmaHMTA7FsB07T/1fpFaMPGNMFsLBSsbcp5v5ao
 XPMstvdicWNPqp+DuRg5/k/xFM8lQCeVn+kgpOwVCCuhm48qNiTzH1Mm7D0qXPFHrLeDbHAGK1P
 LYWfZ
X-Gm-Gg: AZuq6aKNQssYnjV6SEcbPkZNq9f5qxqqUiTuTVDn8tGE/a9NQ+ntpxCd0lsCdZPVdTW
 PHjfz9hCqsM4rtfB0LLYBfHRW69+drnK0xbqNzGKoyFT9kSzqVnD3YNdESRGDAbgrA7vngn9JMt
 7TGCNYnCDXOpQxx09BF9HZ4hAfdz/NilQCK55knS3zBONmVY7BgZXWyqUYoKKm7PYav+nDLRutW
 N59JvjDDUCt03pnnRAFoguUHyzHZRH2Khxp1nK/jFxvZWDnFNysQDZcJGlGjVHDYTRMladhPVzW
 Wvp6tFQ1wH/QiyPCVWje//hIkBcbOlGnBBspDIGHjwJ5hiZXKi2yyjo2052xm/EFUUupB56Roup
 IgIoezcdEGe/sGaUYK+1kGNaBy0LHCAlbt0HuztEcGPRnoj0qfEeDQRYqt9a/BT9OCT2QkXDohQ
 tQXXeD+vaG/1SzDXi5UjZ8SxM20XwU/EazS4Z9RzQ78+AnbnyXyg==
X-Received: by 2002:a05:600c:5395:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-4805cd40bcdmr41678905e9.4.1769372679628; 
 Sun, 25 Jan 2026 12:24:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24bedsm23682024f8f.17.2026.01.25.12.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 12:24:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Tetsuya Mukawa <mtetsuyah@gmail.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v7 5/5] net/null: check packet size argument
Date: Sun, 25 Jan 2026 12:23:05 -0800
Message-ID: <20260125202425.532542-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125202425.532542-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260125202425.532542-1-stephen@networkplumber.org>
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

The size argument to the PMD can not be larger than the largest
per-mbuf data segment size; otherwise the logic in eth_null_rx()
would generate an invalid mbuf.

Fixes: 4df90194f2a2 ("net/null: prefer unsigned int")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst | 2 ++
 drivers/net/null/rte_eth_null.c        | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index e59d839164..04d2cfee8a 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -60,6 +60,8 @@ New Features
   * Changed info response to match mbuf limits.
   * Added validation that mbuf pool data size is large enough for
     packet size argument.
+  * Added check that packet size argument is not larger than largest
+    possible mbuf data segment.
 
 
 Removed Items
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 81001d9326..b5b83f1cf0 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -610,14 +610,17 @@ get_packet_size_arg(const char *key __rte_unused,
 {
 	const char *a = value;
 	unsigned int *packet_size = extra_args;
+	unsigned long sz;
 
 	if ((value == NULL) || (extra_args == NULL))
 		return -EINVAL;
 
-	*packet_size = (unsigned int)strtoul(a, NULL, 0);
-	if (*packet_size == UINT_MAX)
-		return -1;
+	errno = 0;
+	sz = strtoul(a, NULL, 0);
+	if (sz > UINT16_MAX || errno != 0)
+		return -EINVAL;
 
+	*packet_size = sz;
 	return 0;
 }
 
-- 
2.51.0

