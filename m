Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E9C83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9890640676;
	Tue, 15 Jul 2025 18:17:16 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id CD88840661
 for <dev@dpdk.org>; Tue, 15 Jul 2025 18:17:12 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6fd1b2a57a0so49030276d6.1
 for <dev@dpdk.org>; Tue, 15 Jul 2025 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752596232;
 x=1753201032; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=28qApautpmGsfZHn051KzQbOsxzZSZzrKu6ih+9dZ8Eki2o7JKUM7Z9gqDcN83s/bm
 vNS++1McRn3AUwh5ElNUKS3syU6spj4veByuCfiVWzQMneTXU7lSHOnV5E+gGxTlUO/s
 R6PClnOTalbmgYNO8yoybUu//ZhIsf/sBP29hNv1VOrFiH0v78VtOMXOYUtYEpFrbFRy
 gJnRAtMJ2/pMSPobVyrdB/S5hIcNjcxpoMwiPgz0Xz5r9fpF/0Ps8zf8vf2CEo+zNZGT
 tukuoH0oxZXj5WTj+9F3yuN/goMSJf79LTloNadtf366YJ/aUSnJMzKd2dTBsYbv7KWs
 sxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596232; x=1753201032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3J2o00NtwlaZXeph9ti1CGji1aEcijt9MsgZiLlb1w=;
 b=Bgi4bA6udVf3XMeeM/DYE9zBJf9viNoKUrTuD38xi/chR2A6RqxxNMWQVWSGVO6k+q
 VYhWuuTVduo5ni78B8iWsSV4nmPI8heqCxWcubdSQ4x8niBwcqG31qF1ACTEgkABI9m8
 b3wTkWhVaMOiMFQL/sHuD95l4c5FOMWtWtgtpADU3QwYUasq43vaxnZB+Ct3jmnDYwde
 3/4uqR01umqdNwM1CSZ9ZjL4mgw6Z/UC/z6tI7WMzx4oeuYw/hUq7WG1CBWR6UUPS0sn
 KtIEpDPC+h8mCJ8l3vzOmI0iUw0U5sLhhEgAn2WGzcp8Y7OW/jKuufP3N05GXG54CvIi
 oKzw==
X-Gm-Message-State: AOJu0YymGBCnZXpVfcBy5vivfhswmUgNx85W65W+gXYzefZDM667pwss
 PpN77/A/DuGp8bkHY0zIfyRpBT3/g5hXSG7+duWqwWZOx9S+GFkxe4tBt/kLnmMDEQsWX2kd6Yf
 HQ3oi
X-Gm-Gg: ASbGncsO1uZOaIcF7ND4hrzm9wzfg5ZuEd8WQ7+7GZdFkpKZT2LPt17EdHLZOs40uKO
 mLnYehiTzbKwqEDTxM2jfpQ0REXSr9yadIV7/rSjzb6oqYX5h82WWoaYprWpD2s7EPhYEwZ2TwK
 v8iZRyvmXatuQbi7FU1jVVtyRobl0uV04qlxH97eXEE8F4ng316lEjDHiEfs3nKR7vgtXUjL5hx
 su6rwETKYxBUcZJ2mbEk9H37YliISXDuEELt9OIumT/BJOPTvOy8zQUA0gxEeiNbHkGnFjv1L0B
 wdi/rH0JUZe+ES2aAhWfhrKUuvuG86BMoxehiFrnZtMQJqK8gJbECpuo5frLyX+XeeUsvwuDgzY
 ufajQZhq6frrd5EeRotBQCyxQ/TqmEeuTLpHf1v6KsthHFv71W99INNO5bL/yz8vq6RyiMLf81E
 4q6PJvr3g=
X-Google-Smtp-Source: AGHT+IFjNEFKtRqdqz77urktT5ouUEbJ0EBB8Yzs3j41SYbUDKe4W1mxH7ym+Q/Qm5ay0ulGF6xgeQ==
X-Received: by 2002:ad4:5be2:0:b0:6fa:fdb3:587b with SMTP id
 6a1803df08f44-704f47f0c31mr1083826d6.1.1752596232155; 
 Tue, 15 Jul 2025 09:17:12 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979a8857sm59985106d6.9.2025.07.15.09.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:17:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 06/13] mbuf: add dynamic flag for use by port mirroring
Date: Tue, 15 Jul 2025 09:15:44 -0700
Message-ID: <20250715161700.103209-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715161700.103209-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250715161700.103209-1-stephen@networkplumber.org>
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

Add names for new port mirror fields.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mbuf/rte_mbuf_dyn.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/mbuf/rte_mbuf_dyn.h b/lib/mbuf/rte_mbuf_dyn.h
index 865c90f579..72a31b22b3 100644
--- a/lib/mbuf/rte_mbuf_dyn.h
+++ b/lib/mbuf/rte_mbuf_dyn.h
@@ -327,6 +327,15 @@ int rte_mbuf_dyn_tx_timestamp_register(int *field_offset, uint64_t *tx_flag);
 #define RTE_MBUF_DYNFIELD_IP_REASSEMBLY_NAME "rte_dynfield_ip_reassembly"
 #define RTE_MBUF_DYNFLAG_IP_REASSEMBLY_INCOMPLETE_NAME "rte_dynflag_ip_reassembly_incomplete"
 
+/**
+ * The ethdev port mirror needs some extra packet information that
+ * includes information about the packet before it was copied to the mirror.
+ */
+#define RTE_MBUF_DYNFIELD_MIRROR_ORIGIN "rte_dynfield_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_ORIGIN  "rte_dynflag_mirror_origin"
+#define RTE_MBUF_DYNFLAG_MIRROR_INGRESS "rte_dynflag_mirror_ingress"
+#define RTE_MBUF_DYNFLAG_MIRROR_EGRESS "rte_dynflag_mirror_egress"
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.2

