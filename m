Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26810CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:19:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6688240673;
	Mon, 18 Aug 2025 18:18:44 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 62AAF4066D
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:42 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b9edf36838so2765130f8f.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533922;
 x=1756138722; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wc1/JMhCcPU5sYkPSh2ubDKMwVWU8XTDdNheUiEg44=;
 b=E6MAxCyEHlEtzXdzk29H8Yi0IjrhGLiRrTai2wLIIALI4IWe+43JAMXZevfwDjiB5z
 VltcH4Q46lGMWSrg3BzGzOMSKgb1OhCHm/shCJN8KUemNsGSVP7E2OP+JDTkb+Pwz7ag
 V/DR86jPZiTL4PxVJEubRQuG60MrIlgK2VihzzjRNNX0ceyzd2bBk+sr+C2QHzdtoo3q
 f3/DCNQo7fC5s9zOKIDtIwNaFYMkxBue1esV19Xf3skeLW1ngeGi1+q0yqUrX4PX2Xb8
 cUF9i9RjvRZZSpb6OMRcm9WotjVB/NsSDi6iwdc23TxB8w2eWqS0j9nhY3GNfTwFu7Ke
 Xk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533922; x=1756138722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0wc1/JMhCcPU5sYkPSh2ubDKMwVWU8XTDdNheUiEg44=;
 b=lBuBLIKb5SWZuxfX3U+VS/5u5LYcWPap0C/FYZc8cOTK0UH56L5vdqtIIT9z6ZyGZt
 Txu2CpBTpN+k3NtSDvC2LSEkuL2TggifMyY6HBO6iiMAVRoNYOgQTmdZTcuVQ1j0+hW9
 evDYN8E/+OcY7OqY00wKJEEbiEAqYfnIsUS2CZvkdAiFyQa2FfVC1tDFk49XPklyz0M6
 KsWOz/DOnO/5D9B+7qw9EAOQPPgoEPNPT+bJzdfB52jN+lVkql9zOv81Mt7o08KsCo4o
 1RgTmZovTSIbVahoJk33Ea/98P9pB6P7j6XFLEVdjtxkM4twqkVukieiD3q5FQTrxtNE
 cJeQ==
X-Gm-Message-State: AOJu0YyB+9RGXHMvd6O6sQJK24kfKM1lRNhyph4k0uh1FpErCtHS6g98
 op0y/0S5c8Ln9DL+CpJdSjllPqB99xz9kFudVdbftHb4yoQBw5x7vyb8sfuLOm4/TkhIXIIeu2n
 NajZw
X-Gm-Gg: ASbGnctf1oz7YgkDFY4IU2+ErPwoLwW0gICbyA05EGSf1R9lz8JHYmzLPQXuYqY10xp
 dxR9Vj4cdsxgVokxvoJuXQJctITaxs8UtevShqHlaSWZq3+tLjwrv4CCJE4UjQ+Kst37ZRYXTHd
 f/W7Qj+4SbA7VqxaKG1WqxZW9ixccnxg/0oXWP1MDgygaK9BZKl5AYj9luvhtZibkWj3qfBs9na
 dErWGpjE5g/y5SV04NjYVp6TD1jYIMtVfbyJaa5mJetqXLsvqunNxALRKCme9t/v4uCaYmWwNkL
 JZsbyVQLlQX6zJoQ4u0OQnYIpZLnOhx0M1iM7WH9X9qZ1tbJ6MSCSc6X8Cqtt5XdgTv+tkNLxSs
 2xd5yJ4Wpu0WM7fZk6jhm67iXDrQ9XDwaQHayljb5G4K3Rp7UlWpmNW47krSoHt6ImEbuxIp3
X-Google-Smtp-Source: AGHT+IG/WCPvLDAG3gfYxYT5sGdcNLQDHqt+5vqVsCpLcl5pYa2XH9r8Skns+5i0MY8CNvXCYhQMVQ==
X-Received: by 2002:a05:6000:2410:b0:3b8:f924:183d with SMTP id
 ffacd0b85a97d-3bb690d3b75mr10261263f8f.47.1755533921972; 
 Mon, 18 Aug 2025 09:18:41 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v4 8/9] net/bnxt: remove unnecessary use of comma operator
Date: Mon, 18 Aug 2025 09:18:13 -0700
Message-ID: <20250818161815.23611-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
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

Should use semicolon here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/tf_core/tf_msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/tf_msg.c
index f2d2de859c..645a4b1e66 100644
--- a/drivers/net/bnxt/tf_core/tf_msg.c
+++ b/drivers/net/bnxt/tf_core/tf_msg.c
@@ -385,7 +385,7 @@ tf_msg_session_qcfg(struct tf *tfp)
 	/* Populate the request */
 	req.fw_session_id = tfp_cpu_to_le_32(fw_session_id);
 
-	parms.tf_type = HWRM_TF_SESSION_QCFG,
+	parms.tf_type = HWRM_TF_SESSION_QCFG;
 	parms.req_data = (uint32_t *)&req;
 	parms.req_size = sizeof(req);
 	parms.resp_data = (uint32_t *)&resp;
@@ -1862,7 +1862,7 @@ tf_msg_get_version(struct bnxt *bp,
 	struct tfp_send_msg_parms parms = { 0 };
 
 	/* Populate the request */
-	parms.tf_type = HWRM_TF_VERSION_GET,
+	parms.tf_type = HWRM_TF_VERSION_GET;
 	parms.req_data = (uint32_t *)&req;
 	parms.req_size = sizeof(req);
 	parms.resp_data = (uint32_t *)&resp;
-- 
2.47.2

