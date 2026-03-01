Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD28FFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5CC40E5A;
	Sun,  1 Mar 2026 03:07:56 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 927F240E34
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:51 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso327505385a.3
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330871;
 x=1772935671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTflRuDnO/3tDNlnk5YsSNfyIxnCgt3uDW6J+9zDEDE=;
 b=UY2EJ6ky149/RyZaGIFmAM0LJAMf3EcLhjP85t2g9XBOeFQM9PGAgPZdnOCClXpuQq
 gVLZsntdUlpFEzjHz/02umchiDRjNWQIHXuTRZiJtSoSM76gssJ8E+pICw3UDs0h6S/B
 BdZIyajeCvUSwhAFRpYJQz39UdzQTiQVPOCMruIS9NMv7EdtJXHR03D7oGkdH+kIL5zq
 J+/MaPpTwuOSl4adw7gf1tgdsPwmnlXREGdypa6lZNIxTaorQfMJDk8v/YYB12tEmU6k
 rH1E8FIXH78LJ+aEWx5z1+5Cg4esyLHZ/OnT63ZaCsa2r8zbIzXgm2pW3iNQxc7sIivN
 LAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330871; x=1772935671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTflRuDnO/3tDNlnk5YsSNfyIxnCgt3uDW6J+9zDEDE=;
 b=KWovrBJHR+3TsaOol/EHjABLdPRVtpw0N/UhVgA/Ofb5HHGXd1oY+p+3jgN/x/fhSH
 vXwg9P5o+V1XWwk6igtML9VkZFUjDKkg8cPWlqXsT9wcNxF7HcSisKWC6b1Y45VIDZrI
 GPMZ/InbCzoFGBm8ot6oy1mckVEwA816bdZUUy+ktxdV8AWu6vjRcmJkaPLsBWJH2rdn
 U8OrAKYLoXGaN7CrDIx1IoR9xEgYrKW5R5Cl8pFjyOawMoscGjfVauFuKybfCFLbp2zY
 S6oq+soEZ7eYHnqLVehLmRC73NkKZg6GGj9SPAdK1LjzBkVoVJzZh7hmHkJYflt2J97m
 Xudg==
X-Gm-Message-State: AOJu0YwQaN9D/sQsjADftdMdLjMOvV++SKCOW+Y+ePHJXF+UwJAwHFRa
 pPMHBOxeoxGrrTv/2l3GzrVHxnX/r92ccwLvo9mRVtHOQhBmtQvIF24fG7FkCp1iH/WCHouP1hA
 u1UdO
X-Gm-Gg: ATEYQzzZ1RUmUbuJCPNre/KlnM/Uaa7kAqIm4sxqZ3gE9BQPJ+bNIWLq2rBgqkSjZnv
 bz9QI9jWT1BViuO96ld6BwMvRrRXlyb9Y16dTqY+L5TpojcXqy2hNdABafQ26l5LTS2QLFvUnU+
 y1xH++HLQMvhQmxBSG6oDkvQMH85oUcZTZLx0anev94IMBSPH0ZjfuVYzhcmdeDbGJLRf+OiyM6
 aBkGw9XKt4KBbaxyGXWy1ONytIpipZrbeMqWxXv9TFnAkgV1pcLWUOV8UZ2JzXl+tNaQsRLSXmq
 wqbKdpm0Ufx4ELG9GiF73QSbLDni2vQolpTUUuzsoaq4DObnRQxr+M5YV4vELN9f6RHYW2qWTHG
 mcDPiQwOcG+i6py2c2Lw7lSNDhyUwoLYOUeGuTYw1n8yTLR/Wm5D0TLoF0tNKBkCdrN8Ok02Q3W
 QgvUH2jXxCRjZiEjlJP2FxH76Gu/zEIMfvxTTKfQtwXGbmaAqemglrlBoBN+9SgvHQU85Ntn5y
X-Received: by 2002:a05:620a:25cb:b0:8c6:f414:3ba8 with SMTP id
 af79cd13be357-8cbc8e03192mr1104916685a.49.1772330870913; 
 Sat, 28 Feb 2026 18:07:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v18 15/23] net/pcap: reject non-Ethernet interfaces
Date: Sat, 28 Feb 2026 18:05:48 -0800
Message-ID: <20260301020726.852401-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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
index f14a7d93dd..1b927b3c35 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -649,6 +649,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

