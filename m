Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CBE83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51BDA4064C;
	Tue, 17 Feb 2026 00:04:59 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 05D0D4067C
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:57 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4359249bbacso3774228f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283096;
 x=1771887896; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkIumbna05lhPKYUcpHVHbGErZ/c8U2EYo5DG071w3s=;
 b=gDzvhdXLF35JQ76WG5VQtx2gCCfMskc7MRvs4hSNGN6AExGgTU6y155NiSk9OWsC8G
 c6fwCHcaEM6avTSmGhZ6lWlDt/Mu+WukQtpwcEBQl7ScNNo+azkBwMj+eXYG/0mjSMoK
 fojk/mN8b6RmnSXAPTrhX+osZNNxlRZT6H3aEtMAzR3rPlR4aqbPokRi9UNFGLFOUZud
 vouAvlFuVZY9axBfrnkyqHjY6HXUh2qsjM6JwYAy3UujRQgEWrdZiguDgNUDyLpl8PTg
 V9tTJhlGUq2hH0zwf0eWfWe0Y9Dl4nzbQ4Su8zvwR26lLC5GSLjGTPExvAkekkA2/BYD
 vVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283096; x=1771887896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkIumbna05lhPKYUcpHVHbGErZ/c8U2EYo5DG071w3s=;
 b=Kylihz/jp9mDjogNuDrmiAjhXSyXXdHvvjpYgh3HSpDWHH+m8YYqjlpkv74fXJRWQr
 7jK83xJ5KVV1gYyEvy+v5YxyVsXCKa0zrzC2o0GutnvkP4z5ol98kV6gLYNXlhcl2p3a
 QPZ+Qs0EEkkCGACis8TS7lH+ze4tfxu0O1gHVMac5FCI0lSnf0tX2wd/khWMZTLeLsCT
 7jLsEdYXbkmNdwPYdzZekJj+MCnBT0xiVmlFftr1wUILGdvnamd/SDCJBRakM8RfTn5G
 9t2YTnoa/XrnrEZit8mRe+1df37CXIAqHj/F+mkk3TUlkyuRN2exJbJii8b0DjW2AxmJ
 b3Rw==
X-Gm-Message-State: AOJu0YxXrgzICRKEfK9NIZ6Skh3qkEPkQOW/kvLraKNbuQ6C7HXBy3kr
 VSTQPBrlZA+wV2uR+dZ+k37WtZ+VT/gHyjrdRF5IoaTH+HRSRTlChYCDCj+gmJ/GeUy6XFbYq7X
 Yk9wVqQI=
X-Gm-Gg: AZuq6aLBt1sQfNorTknIXJJ6H/0WtLZIP2tM8NUYmZgXz473SavbxqOSrmhkOngBOFo
 jJcUA8uNvAhNB/Cq6BAOwBXpzbQqgLfJxhX/FPvBL4s6pXFR5Dr2nvmPoMBnhAqj2DHk9bvCGWt
 e/tGiAkx1Mbucipi58UaAfDWbQSYZrOFZH/7RSoUmDGOgTDE5hrOtIqpUTc2+4W6r62DH5cQB56
 8OntL9LtX23LHiK3PGrqZe9yiKvkeDHGCvaZf64PYOlN+CFp8RmUbKrQd3XnKdu+G1/1EGoUenf
 Ewmc1FgUzhbGo1UQdPbm1b6DCxmEGNZW/FtkPtPQO6YDkjH13Qqxv2GUcTn+KwPQJ601NBM6bBa
 JhT0S2faYPPN5wkPz/87GVHLb1ROE981gZBsWmjBxAEykZiBQVmW9CnLYlqKLf0CFi5Ddt3MbNF
 8SagSdxdvYu8YA6iP0A+0VJD0MynThVPtP9XEDs+DJF21ZaCzeJtHijPaknWkCZA==
X-Received: by 2002:a5d:5f87:0:b0:437:6b6e:d108 with SMTP id
 ffacd0b85a97d-4379d5e38b5mr17241573f8f.8.1771283096602; 
 Mon, 16 Feb 2026 15:04:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 08/11] net/tap: free IPC reply buffer on queue count
 mismatch
Date: Mon, 16 Feb 2026 15:02:32 -0800
Message-ID: <20260216230437.847578-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

