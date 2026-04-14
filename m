Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F66F9D0DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D12640A87;
	Tue, 14 Apr 2026 18:10:36 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id 7E58940A71
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:33 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-46aa216a5edso3351513b6e.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183033;
 x=1776787833; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8QDs6V+fwlf3ZfEYZI5tD0dAd1VWWkV/caeDmdp1XU=;
 b=vWWzIuIi7lJU3Lo7W/F6Jm/yu/gBtpf3CEsNNXINfEJfoDizsV8RX1xLlB4gUhRnSk
 wqmc1zMnJrnT6dX29I+NkxmOB/gxHGdkuG3kR7KpT5+6T09aQP30/s+1KtQZctRjt0By
 h5JwRrd6lB4qxqRH0byzQxm6gwv9lZhICFWjabNUgY0c9ueuTdPoJzhq9fEwm08tNEHU
 t7QCkESfBcdRTj05nemH28rWgzXmOhKnweIUvugPeWbsxO9f8jJOjqfxz818vLbJdhsR
 tPge85uWyFP8ZWHettLNsoietjQ4rqp6D5KTyGqJ4Vcz2/GnrmGdw8Wx3ZqiZr7ow1U6
 FLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183033; x=1776787833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8QDs6V+fwlf3ZfEYZI5tD0dAd1VWWkV/caeDmdp1XU=;
 b=Cqn5GUwJ21r3R7ay8GCnAY8ru5Q8kYIMqEJFvnvHraeEoiT1lxjrb8tMNmUzm3RrgS
 aUP4pkpoi5EpHLQP1xe7DdtzuitLOhujY4dXBih268GPhzhIFrKJJDJUxeL+DPEVuyl7
 yoAb+g9ZhVodOyplGZqyUopNH7rFTpSud6Z4tC6qWmdJK2KbirGJbJM2ylCciVR6pD1U
 Y05bzacvKRgdeyQ8N22Jyak87MjUssdtSkr0JfevSyRO4o1CeAqMmogrt6BnogtXtt6f
 b3r1WA3bQWy+PewNgYXOM+4k/oXx+k4SB7e05UQXM2rCkLcPjv6bVt32uPZx2ZQKvxbe
 9GzA==
X-Gm-Message-State: AOJu0YxSYP6dSG0UA9OUIvMQJDGFQ04TK7BZNilFkXnUp1Hj4jpNgZ4q
 mBfkZP/PS1nxgxH60TG15xnbDSZu5v1QgehThDd5evV1G9yBnvltfCsT127z6Xdl1fCz64rb6qI
 F+opm
X-Gm-Gg: AeBDies2DvjA3W7cmpdW0pJqw2FvfoxGTKtLEahHVpu8POGsMyJp7STiPi/hsSK8Q4m
 7iYHI+7jKHacUw0bSBQCLTHsjdMLfBR7xZVCYIY9wKW68sOfSMIdGakpLhpelIwlx3O+rBcqAJw
 JzO3qW+bAuFTPgt9fZcHhUF7UBe40lqSx05sen5ysDk0vsM0ozshGCHRm7dAnBkAqsjJvXLfCqC
 42gfrnPm90oivAtnQJA5B+rKqIL9QeQdLmwgcOCGN5v6e9gxpX1zFjegiyNRm87AszxnFvK8e3U
 IQBn9/QjDO91G+A8KOxWVkkVzwexKMMrp3cjqolQtBC16mHD/kkMGy9a5gp2lPuJjeQGKTYw5u/
 MjBajdUxqDpPFNeNgwXSCqW58PujXQgBxvfmGLX/q4+h//cqC0b/ZznAbFyDBsk9T68U+/pToke
 pqIy047LSnytor+rCFFnoS6biDHDCHGh6l87QXKlaEvuFahjHgi5uYKQ==
X-Received: by 2002:a05:6808:3447:b0:467:15ad:9de5 with SMTP id
 5614622812f47-4789d03d6b7mr8939349b6e.13.1776183032692; 
 Tue, 14 Apr 2026 09:10:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v22 16/24] net/pcap: reject non-Ethernet interfaces
Date: Tue, 14 Apr 2026 09:08:07 -0700
Message-ID: <20260414161011.756101-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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
index fbd45c18b3..01b26184e6 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -664,6 +664,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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
2.53.0

