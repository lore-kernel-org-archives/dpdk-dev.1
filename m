Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB6D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F55F40657;
	Sat,  6 Dec 2025 19:44:33 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id F2D2140654
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:31 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so23043835e9.1
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046671;
 x=1765651471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=Yb/FdEHd/Xu4UDPamceQdGWbthW9KeZ+iBm6ySlnc61edMaxPcnMxb2FFtKPI8d4xZ
 bU6CJJSd0a7gElyRVFVo4aknD0qaykyBPBdjkrVYw8fhf3h/T8eQvgzlLn9LuS4Jw+4E
 Q/ehsYEovfeknQVOmB3HXmNYYgMVVuNeNxuyIDN5ybXAVT5+t4xVdwLIQEqQa/JFzkl1
 85elhR2HJnkjqUo8tf93HNGavQ0eIzKH4asU4vwEv5Ukyp3LMyv3DPdCYMMbTuHBUlCk
 yNvAKz8nLrtyqrqhQ8kQ98NF8fTQCJEDKVchDLzifgCOR7W9cp9Bzgzdb0hEwmi7TMiJ
 Fh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046671; x=1765651471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=EHHPcT5LNT8BoZj3c24WItc1EXH9vwhgG/2kvM2hLsYV+tOortJsHLb3IYcq/WMiTl
 umG9y3Y4HFXBk4KYZaEBIpjec9vxqE53/f3hGbtK5p+JsAJ5629682Fxt7MRryydFR9V
 Jm732J2b9rXC4RVjBULUZQ8MfyPKQzenh5Zj5tI/GASERn1mVntKqHI0/Mv86dRizQvy
 ImESZwclwP0ot3r5J1tYFfhNWCZee0EQ21Bu6KRBoJ0s9Pgqbnw3oYuF9b9F0uUI6bNx
 jcxBpoJHpb+WygBDZyW+w3b9qlzMwsCXJWBUgSAzt/NMrlAvxqqe3IU187QV+IEMtge1
 ntQQ==
X-Gm-Message-State: AOJu0Yzf1xCn1NNskNEn6ryRFMNvI+0WkpKiVIPpnWx7gLH5pTaF3P0/
 y6oi+HImQoKQXl9l/moK6bndf+zF1h0TuiyDiS8tYjsFeYriJUGhDegLC5uX0Z3VZtCsZpwuaK3
 /oC8c
X-Gm-Gg: ASbGncvBEGpEVnb0QCb1UV/D6xwGtnG9nWVtMNeZCoydA8SgaqcpANtqxrH0a228+ox
 /ZuCgidkwnFljl2L9IFVF5E2AxCUEOy5HEf+BOvSx7jOE7yrhFvB5FuK9PZC9YNQuOT35Wo4l0Q
 rPboGnmUEaOPPk5KMVGjLrucomRdygN8rsXrO5fds5qSSJAdjSS9idl63mybFApmGKCdHFJACLG
 Tt67DQI15YlICQN5brOUWvHF+p90fNHszEUiLLD9TuWFszYDUp6LtY/zLFxnAOJRIZejea6c6gL
 ipHydvGqSdDFMvPpbWLDysdUYwgQQRiBOOheocMTyLIriLGbu3tJHm9t0xKxvkVpgeDfFFUohDQ
 mzA4fKkqFgSIdREd7GKMhCWYvBSeDRGkgIidn5qgpmXrRGON1/4yvJsDB8QveQk/F39Y6y5DLAz
 JnR/ym/MAKGxKe7lR61rzrDjABTuZiSdnvcoWQsYke+Tf/myDIHA==
X-Google-Smtp-Source: AGHT+IFZDKTO/59L7GICe6CUNVmidh0RKXASE+BoK5HKoXXnnDN+ruKYIDgVLWirHqey2r1dI4ZfEA==
X-Received: by 2002:a05:600c:8b6c:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-47939df17f6mr33548625e9.2.1765046671583; 
 Sat, 06 Dec 2025 10:44:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 08/16] eal: avoid format overflow when handling addresses
Date: Sat,  6 Dec 2025 10:43:09 -0800
Message-ID: <20251206184410.542725-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..2633857db5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,7 +1153,7 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
+#define ADDR_STR			20	/* 16 bytes 64 bit + 0x */
 
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
-- 
2.51.0

