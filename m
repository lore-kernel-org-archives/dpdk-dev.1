Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B37D2ECFE
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 01:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B9EC40A6E;
	Tue, 20 Jan 2026 02:58:12 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id CAFDB406FF
 for <dev@dpdk.org>; Tue, 20 Jan 2026 02:58:10 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so1128785266b.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 17:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768874290;
 x=1769479090; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poA124AQvvz2jDUUxGXACxl0gE+AxwtprwNwA4M5HVs=;
 b=bVLHW6I2L/eQJlkp/8F6XrldC7uEdYPjt4IWLK1qBQKvv9IPUigQNnR0KEOjCPtXfy
 o7vWYh7mPBCEVwvAEjW4j5Mc7y/PaX6SZoPjru8PvEjP2rE8NHzo1K4tJIGLzmzRW3yM
 ZAwGzhdFJuq/quyZtn8RxSC/9UOT676z9zpY/d4V1Y7LO9iwQ57IcxIWqp5p8pc/7S2i
 ZZjE/8uNoTNmT06XXlGMUQqwymUHWdfu7zBVuRnD7070C7g+FQW5a5W29K2S31jihBBT
 exyLw0MSv2UNqUHUO/jLBsuvKL6GMUiB6catFQkuLeY5wuaV/mAHN0y5bVZlH/PhAANS
 kjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768874290; x=1769479090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=poA124AQvvz2jDUUxGXACxl0gE+AxwtprwNwA4M5HVs=;
 b=gXRqQsOhm1c3L4b06McOpSvDJmlFpeqwHs5zL1SRj2X9tOatYtAfKTCLkWtwZW+HnV
 bIosatvJD1rdXg45HaBOWMyECETboWaYM916I7bbjj8Hiqrw38BBaunPtsSH/K4v3dCc
 kfHxHX90I6SXiEzOqNhvDg/2Q+k2T1+iKpR8B+UEZ7VoV0fFbPpuKhl793u6dlC6RtTC
 slnvsVbWxGzP7ayUGVL46SeDPhLrWgSp1xPmWkLkceLotZwKUYNAhvh4I9v2cqSl6msI
 ZAMosg0FiJIJyFHfUq5lt+wvWsYOCur+aqDbFGPE5ODn3uD3mYLnsFf59mf3O/Jt4qxi
 SpUg==
X-Gm-Message-State: AOJu0YzNfPTzJUfBa3wmeQuFqMVNndamHGWqRFzhgBVn6DqmwnxMoht/
 Mcg6Ydql+RWs5xBYCUxRjRetaFduwu1ezN4AkyxSpkHS5R9xeD6tZsFbqZPWuSHlzL3Yul5y0Xx
 tMkpz
X-Gm-Gg: AZuq6aKZtfB5OHq1ItwXykoDRcAK+dOS2SiV7NdiQi9Eb9/nQ50XS78P9Defu8drCvN
 bQJi4CK1f5gxPMCfikZsW9XdFbk5YuVVW25ykkZ/e/w8AbQZ0Ek8CDvHzsUxVhM1sUpXZHRUhVY
 ox1TKnsoJs4J1jsMnPha8ArSDcOQ6NOKuRMRHF2Fiq9R8rVMMnhRdpqMAir5jmsJXge/La3wixp
 0IeAnfoXHhKHmY5nFnCsH+4uTAfTs/Zc9TCdsUWTWzdDtLjuJ95kn2zzfIrgAeb6lLH8OYopfFZ
 P5wOQUVlAE9+D0b080p6QXuBwHezoiRMGvsyAh50/oxFCvfqPuZiezgt1vjK1CUXtMIAWmnwUad
 H+2uBxNYs/wWfdMJMVbhtX7DRivmPnKR9uA8lNZiplphU/MyYLjbG/AsXwE2cGSkSzMiHq2jbWD
 S1yP6xV5sYjfSFMz0BQsYRNwlmxlMpgVjzf2DLMwLbNji935UnQg==
X-Received: by 2002:a17:907:1b25:b0:b80:4030:1eca with SMTP id
 a640c23a62f3a-b880023748emr19592366b.2.1768874290401; 
 Mon, 19 Jan 2026 17:58:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879516900csm1342225366b.23.2026.01.19.17.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 17:58:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 3/6] test: fix error handling in ELF load tests
Date: Mon, 19 Jan 2026 17:55:06 -0800
Message-ID: <20260120015759.301155-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120015759.301155-1-stephen@networkplumber.org>
References: <0260118201223.323024-1-stephen@networkplumber.org>
 <20260120015759.301155-1-stephen@networkplumber.org>
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

Address related issues found during review
- Add missing TEST_ASSERT for mempool creation in test_bpf_elf_tx_load
- Initialize port variable in test_bpf_elf_rx_load to avoid undefined
  behavior in cleanup path if null_vdev_setup fails early

Fixes: cf1e03f881af ("test/bpf: add ELF loading")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index a7d56f8d86..0e969f9f13 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3580,6 +3580,7 @@ test_bpf_elf_tx_load(void)
 	mb_pool = rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSIZE,
 					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
 					  SOCKET_ID_ANY);
+	TEST_ASSERT(mb_pool != NULL, "failed to create mempool");
 
 	ret = null_vdev_setup(null_dev, &port, mb_pool);
 	if (ret != 0)
@@ -3664,7 +3665,7 @@ test_bpf_elf_rx_load(void)
 	static const char null_dev[] = "net_null_bpf0";
 	struct rte_mempool *pool = NULL;
 	char *tmpfile = NULL;
-	uint16_t port;
+	uint16_t port = UINT16_MAX;
 	int ret;
 
 	printf("%s start\n", __func__);
-- 
2.51.0

