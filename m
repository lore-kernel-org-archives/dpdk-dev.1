Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E18E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:03:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 954A040B91;
	Tue, 10 Feb 2026 01:02:30 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 1F08D40A76
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:29 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43638a33157so202905f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681749;
 x=1771286549; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CtBeugUaqWdZ3Jlfo/zxhh5QcLRUpG91lNEjAspbo8=;
 b=FRvzdct8UrXFL1TxBg8NajQBg8iy/9byrPbaUQNvraW3M0WuhKD8lnVXAusa8hx4L6
 fwpjL+2CKbX8fghK9H12JVdm3OtXVtw6TvbHnijcGrt/Vkt3RS0RtQslJo4jSfC8nuEA
 GuTewkyKUcoNLrqiyisiGJy4jPaYMLOXcCd8N+vdDkrEimEq+YnjykcrKsKTBYsHoWzx
 F+koORs1xyR56vZ5K7gyE/NZ39KUpDGrCLoISfi1roqgm3k2UWrQognLhWhWZSGsHhGw
 XHgHvWerx3hujS29C9FFZY77MbpB+KiT9tWSdr779dAslzdTFfbdJDJ3VClYIaiBQYiw
 iyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681749; x=1771286549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+CtBeugUaqWdZ3Jlfo/zxhh5QcLRUpG91lNEjAspbo8=;
 b=qTAMny2fwnINddhjJCBNtjjpyd+0qO0SiwR9ENV8hggEJDF/fJoBMn9Bgf3osIr8/q
 nmG2zRyd6gcKp755qXJdU/efSbC9tGEKwayne9w9O+vwQnXekOfzok3b7OcV/eiXV9T6
 Zx7z2rshSd1Mvh+uN1tLX3o6I1m9Qwc/RJRlsEK3eXI/2YiCGO4KeilZc/d+RgACOGX4
 Ie9ZmrLX6zetB0oipWMnuUK3IwwHGUkQHXqkbGuLgUrYR83+CyyFtJ6bhKyKvfHSJDR/
 5EFhnq1/hx0q/qDOXhmPiwTWKdz42QvwSLR9CtVtTrdkp6MmGkyxR/ONSqmFWOZDfbjd
 WeRQ==
X-Gm-Message-State: AOJu0YyQBKO2G1U1A87u3QJo3fkMs/26z0vu5aM9253vFJva8LLn7FHJ
 e91UXXlOPB0M+VagbmhU9jhEl8g5aG8OB9z8erqg0lY/2KjJCgrI+7Ap+IoXf/whWo4CFjc1g8o
 qon1q
X-Gm-Gg: AZuq6aIZBR/1cP4WJ/Ypv0atZHpiOp5nKPlfxQU9krKQ3ViCl8Ca7uWjq1ZRGFvJaJe
 DxIPZhDnCCTcTKN68eRAk9kGqbbPgraiT7c0sPjDzCpXJ3+ZGJKHqqd3qHVq0H65sQaJ0f9oytq
 wR4vuL05S9hQCXp7zmsmxAcOJAoF2QA6HH0BiDfBZ5dtBF50SbVf4R8CXr9Ympbv0S+ypWILHdj
 MG6ZHjq+bJV0jCSs0hLf+6hcWo2z7A5OpRv/oxcUp2I8h0SM6dlJB+9OqIx1hG/OZ37n0OA0/pz
 9n6YrvQhbIseOozDc5GcyDOmNQgZZ4tZtk8zzdyW/uqidVdp0ql50VK0zGOuc8K/vd8nfZiJ0VX
 ZmGPBDAm/LWM69017DxdL1LBhsIvPW5IoEgNH+utNK7SsYqE2nZFsvvIy++J1fgd4q4tPKHZTKh
 YZLM+joGzIs6uH5GmALE+cHHrj22KwbDd2daLegv69hnhZuYS9HZHk/oJvrbje
X-Received: by 2002:a05:6000:18a8:b0:437:6e63:9172 with SMTP id
 ffacd0b85a97d-4376e6396c7mr6837534f8f.4.1770681748710; 
 Mon, 09 Feb 2026 16:02:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:28 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v13 11/16] net/pcap: reject non-Ethernet interfaces
Date: Mon,  9 Feb 2026 16:00:42 -0800
Message-ID: <20260210000201.295839-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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
index 29030544b8..cde9744766 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -654,6 +654,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

