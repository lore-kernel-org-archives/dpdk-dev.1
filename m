Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C3EEEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C704406FF;
	Fri, 13 Feb 2026 18:04:01 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 385A3402C1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:59 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so5973685e9.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002239;
 x=1771607039; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mChqG1OxW3IBh6e6dNk7hG7WajjvSzczzD3ZEMC3zw=;
 b=IZ+bMHG20S2FS2jznVRmDzH+J3Xwrtcddpz4CuT2rVrBZ7UwviCfljm1biu9Za+/Iy
 seUfq/xhYGx2Zfb4LaKuoqKSr2IabL6ztHwcLHLPmVUvbS8uFgl2iipVw0WHJao0KOIX
 jWPR+rJZQ0z1ZsiVxcMuFm9FEqtVKy9GAdMGE2E5q7lLES0zKv9YXMjYBL+0R/VT1xpR
 fyA7ANs7sYWd8+waHgt+9KCWRbr7l9jtxCFinQk7L8C5W4ixIGQ1EzK7ahXgikjUevrq
 fGwVEkgIQe7ZjzCBPICoQWlRzjJoM77QGtxGfQuMNXxqJ/4j4cApKC4vGiuw5d+VrZcm
 ES7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002239; x=1771607039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9mChqG1OxW3IBh6e6dNk7hG7WajjvSzczzD3ZEMC3zw=;
 b=IgBixxK8OBQwyA4Y03zuVH7kGpbEZ/uh4pud44ezGFK72lDPGYQTldqfO8JkARnHCw
 aCIT6tHMaGudKdV2gVR7Lr+lDcQ7oWmx7emm2BitjfYBCkpdidqsPHaeY94bupQzbT5X
 q41YcGSG7TBLXfw8uDOa6m6j7W5vUCRfNZefAcV97La4XTNKjFgpovmuYT4zdI6u7qjI
 tIyz2T9eFLWK3EHps3ihZVIsYvO64mVgWx+QxYJ/mEPE7NxJl3pRNjAASy+kRaWjkpJJ
 KYHIkzIoJ7NzifrC1x/U0gOM+JtHqLoqQE3+GQjEuj4iXsAG+BYqZ4v9vd2VVgTmYcvQ
 +q9w==
X-Gm-Message-State: AOJu0YzNjbYFa7x8PZtLc+kB4FUt7aiIp4/TN3LQh2AyHjWHTPqLsKic
 smPIjtydNX7pB0JxhuV73zTXldn2KP3j2Mho24Aidfi0QrJMQ62GSinTiEQFfrl4i7uU7mekn6K
 vxfc7
X-Gm-Gg: AZuq6aJulpipCyldGrIlAqAO9P+t5eJsHp4hwYhmCmWeDEO2H9Yh0ZKVdIyY7MTIbga
 BcF2phf0uUh+I1WndudFzxK+gOU6fhf/K4dcPzEq5bRm+gnXup6u+FQ3HZ5vPPnXxXlNEwq4At/
 XjjVa94qkCntlIojnMvLL+rZI3O6D8VaUlcAxNX/YyRTdsbdWDsSl0cYuYMqrJC48wUV25MBMl0
 JxX/3jOuRnhfUE5LUihfEJIvzHPxC2DKYc9JGvr9DwXJ3KVjqpX9eFF7ZA6i7aWcS+8QqC3nUrw
 ZpZQZ0pMBcGwBCqA6HFwAodW89ENrHmAJ/TTvfghOO6jnoon/+Vhjz2ze4kpVSrSi5BawcekTZE
 8ZDT6vh7fnQLs0Gj9NPJjzPzOy+0rX23iJKqYvzNGXYmDDi0w4hxq9LYYbYBzKgMlbqaYdb6zky
 LqSK6lnr8XwG4ogeXm1fzIUFD2KAa1BpxqeamgxJaw0P1R5+a6pIre6e+OFSTrYg==
X-Received: by 2002:a05:600c:6912:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-4837108fed4mr52837255e9.25.1771002238804; 
 Fri, 13 Feb 2026 09:03:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v15 11/18] net/pcap: reject non-Ethernet interfaces
Date: Fri, 13 Feb 2026 09:01:34 -0800
Message-ID: <20260213170333.40089-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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
index b96bda0fc8..8f44baf2e1 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -669,6 +669,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

