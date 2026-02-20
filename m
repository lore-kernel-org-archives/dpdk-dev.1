Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5019C53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E023A4067E;
	Fri, 20 Feb 2026 06:04:27 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7714940655
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:22 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8cb39647a70so158228285a.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563862;
 x=1772168662; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkIumbna05lhPKYUcpHVHbGErZ/c8U2EYo5DG071w3s=;
 b=v3qltVL/oYSqy6eLmkcgxCoSm40gUHVxmZUnQHaGQK5EISYA0gDnC/HtqJhJY7fAfi
 RZZnkJUJXrmbr9nWZ5LOxsN8UnGEG+cFVR1PL4MyevppjCpo7dj9SW6HH7m4ZMxc7ULs
 xIVLPD2aBVU9njRvZI6nwV9jIPeZoK7yLpGR2bZXp4JXzzPaLXidm85aEYHf5H+r7esr
 HeQ1jqLV7dV9FKH5nYaJJbPmYKfmolbRSIoVabupsZjT4P6nbhs6tsjQdUXZAgKC+lQx
 5/QRVkJYh8+LmrqftLpAzGxkmGyZ+ynz6iXhrYaZqzip6nq2+u3pxWllYUPRNCjw3IE1
 gpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563862; x=1772168662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkIumbna05lhPKYUcpHVHbGErZ/c8U2EYo5DG071w3s=;
 b=ROa3gjgrM2U0y7fLn9g8PdBduCv/4BhCCjHADu90DkdUOaBYyZHiRUfZOQNTVbCJwf
 FcKm+PtXmHzE2P/IY9+rNzpetXgRrBaMPLYizQreEDsa+NeWBj9EJ7QPoI8TP4q/K54B
 GusukETL/KZNuQBPpvxzgYmp4v4Hxp2F3E7SGVqegxwcrwCaUIwJvO9Qdk1Q36FQv0Vr
 aiCtSxeTAP+GXSQy13PcNlPTlT+XhdAeEOAk2kKI3uQN7CJJV9im2qMQAEkAvg+AuQAL
 h6AIfJZWLc//yEYSBasvkNK5pMpME6XeJ4++LsKJzU/uSMu9WrRv158PcW8U3ipYf8Qs
 0oMg==
X-Gm-Message-State: AOJu0YwLEW19R7h5Uw89it3bSU32LPW0Cp/ipHVtKjZ+AHhIUBMXA0/i
 NdEeWN1mpN+aTzxPi1HBpTrBOU5xx/RXtFlQH4rbWvWLTvPZ6upayVpoiQB470VGMnkWS3Ez6Rr
 zC+BH
X-Gm-Gg: AZuq6aLq+zuf1WrTUEUN/eXNtEG1J0XFEOWkybGWwECPoc+7eokoPBXga9AGLxeNSVP
 LCL8YBfHl0tTc2Ydu8IDzrXJhXjgI+mSd5U1HMnRcbTAoFZqQ2ESEGWmsMVu1fcRa+FC1sl4NrX
 p45xQR3xZHfGGh+sigfX3gTYRUZfS0OiFaaSu4kTa3S6s/tUhue0J0m4Cv0uKkSxZPPm2ocoCCi
 oFOIyv2vPH1RoZizWVlKfcl/cNbjZCVOlVqkdyEXlO6h8z3l97Wib+oMh5yc6ciHOto6dzAyLMi
 oSEaJDp9R0IAk2n9O76O6BySdOc0u3aFAlVW0waGOGhk+GnAYwGv/cAEkpY0XsO7380KpZvEkN5
 rozXNBc6fRolnlvubyRhAoK9DACF150xbbwkmo6IzsTPk8Ml5e7yC8zYI4sQ8Moz4+nvDwmNQV2
 PVc/BXqhPAY2abtAuYr46Ngj1Qh1GWOr0c/gnDikry+QTDs3nXe5wSfE68FIxwjzlLMngQt/Sp
X-Received: by 2002:a05:620a:410b:b0:8c6:a64e:92b4 with SMTP id
 af79cd13be357-8cb4c039b28mr2487722285a.78.1771563861719; 
 Thu, 19 Feb 2026 21:04:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 08/10] net/tap: free IPC reply buffer on queue count
 mismatch
Date: Thu, 19 Feb 2026 21:02:10 -0800
Message-ID: <20260220050409.1571022-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

