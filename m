Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092A4C5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A2040658;
	Fri, 20 Feb 2026 18:06:34 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7029C40649
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:27 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-506bcb23a78so18789271cf.3
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607187;
 x=1772211987; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkIumbna05lhPKYUcpHVHbGErZ/c8U2EYo5DG071w3s=;
 b=nWwPwIzQq23TQcUbrC43oQOofzAjg573Z7YGMcDBTIZM0m3cUl6kOs85qfqqWYpLJw
 U+wAql4x0g2z1cVIejAzEUuyn7xDYU5QWMqY+m3K84ylaSsoWx2FJyKNNjVbMogGLnJQ
 lhP9xDXg5L6hFT/JN/Dkgv2zKjMV1aytJJVUJxs05UpMNBU68VWo5Di35vWcx4SEGM9f
 gHsR8trEPIjZkBTpE62P7Ew72sWtD5laVf1JUiAdsAZXUgNK8SpQijN4EvUX6wLOInt8
 0CL9RK1S7ZRr9jCHwiqCtQnxyzhwKrN7Uj04LbKR+14B40lhy9QELFUztd672lm2eNW+
 kmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607187; x=1772211987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkIumbna05lhPKYUcpHVHbGErZ/c8U2EYo5DG071w3s=;
 b=cfdJuWgn/DSDlwAA0XrGlDWWPQ3a95QH0thqG6SU3fvbgPlByuDsjOIP5qI19gO7Gc
 OtaYUQZRXrrAkFuJjdNExNyQ0/tDiDsRM/l2FRM3bn5qRa/idEqiCXHexQ8juxrMT4YH
 hPmoyhRjsmtACrUDBA67MBqd3aWrhoradwWOWlwSemyJWLyU+94X1msoDUpGq0fKXkWo
 wPqg0C5tlv23lO43iUiNb/50qElaPH5Nj3BFIkXNWPKzFSiA/HhB9ZtaffVvROsjpDWu
 bXoGHKZvY4hOrtjlkD0MnAKvpltxHNq7CWqsEtZbun9y1FXoBI02rqXqCJdVrNBzRxS4
 7m0w==
X-Gm-Message-State: AOJu0YxYGWYtCzGCFv2K6Md65CXQBoeGUFwsfWm2frmMfSRTkMtSXpSz
 xk/AZWuVTWqeRmDIiHfuRZUWt6IBd0IGErmSox9dOWxnf79SBjzQXX1jB4hO5xJSbFBXPtrW2Li
 KClVC
X-Gm-Gg: AZuq6aL+rMrOCue8ai+vrPoSxcnF1DC+62XNZ7ZRwEVYZjUAgnOogCZY2kjOLzKhkwU
 d4YWVQfTZ995IP9p7jQS9tMFTs/HGPM/eoahKwavHE9DpoCyPOs6sgvAfsQ/isj9Yocsx8EMs2v
 F7UBpsl9hy7AptZd2SL6A0q9clwhuJI1Zf4uO4vyFWQSGXJkak6WPirYh2y/mb50ZSiq/LjJb5H
 tRWgpxoS39Bdy6mLGTJAAGmF1ZKz4wgKcrkSspMEzd7oLPA9kL6dxXwkbgvNgX5/gTS9Qk0QHeo
 8RCgiHW0duOrSIpfXMYog2dvr+lAAA01tdbXLQsji5ek8CLebF6CiRz7ZNz0M1arUtsK5PYtYtZ
 Vtse2ikZbezAXQZlXO1PZwfZNTXIeYRIBFEHPCnsjdqzhDCtR5P0KDSLhnqKOTf5TRfMQ8/1eeW
 x4cntlNxwhW3QHO7277rdQTI6UNzr/33s2/Kxuz96zeRWixXgPtegwEv2tHjxemQ==
X-Received: by 2002:ac8:7d8e:0:b0:4ee:168a:9ebb with SMTP id
 d75a77b69052e-5070bc84f7cmr6526171cf.58.1771607186768; 
 Fri, 20 Feb 2026 09:06:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 07/10] net/tap: free IPC reply buffer on queue count
 mismatch
Date: Fri, 20 Feb 2026 09:02:07 -0800
Message-ID: <20260220170614.75560-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

In tap_mp_attach_queues(), if the reply queue count does not match
the number of received file descriptors, the function returns -1
without freeing the reply buffer allocated by rte_mp_request_sync().
Add the missing free().

Bugzilla ID: 1881
Fixes: 9ad43ad8fbee ("net/tap: fix potential IPC buffer overrun")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 974b45ecad..deb1d72382 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2407,6 +2407,7 @@ tap_mp_attach_queues(const char *port_name, struct rte_eth_dev *dev)
 	/* Attach the queues from received file descriptors */
 	if (reply_param->q_count != reply->num_fds) {
 		TAP_LOG(ERR, "Unexpected number of fds received");
+		free(reply);
 		return -1;
 	}
 
-- 
2.51.0

