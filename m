Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C8D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61AF540677;
	Tue, 13 Jan 2026 21:23:45 +0100 (CET)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51]) by mails.dpdk.org (Postfix) with ESMTP id 6F1CA40684
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:44 +0100 (CET)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b8722834679so327841766b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335824;
 x=1768940624; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=TCGZfletMRZgQqhgnZS9BxamnpRceJtyKMkzSl/NJfzvIjSNXT+TzIa7pbCKCoLijU
 J++sAxsMcVvtyfQlD7+db+3hH9BWuyT4r3wD3Qt6ZciDxWZiWZyjnx8h6MnxNQ0ba8BY
 wfQxOwj5l9rMgS4I0HSBqaNnG1Ne2jlmiw/AoAT26Ka9byf0SqQs2iT0QvrcRAIXmdwp
 l4eL81xNQnB5lJH3l5lrmICtW4WC4Jo4k+wxxROVLfN9x9MItFNzMq3FddKHmi7I8oxp
 n7NknqW8x4c8rlQp6FItPZ/3ssn+AzI+N7nlRFIt+QxOIeVQrU1BbPlMI+hT6lHejZKK
 sP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335824; x=1768940624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JJfbI8F1glCy5wu+Ijoi95wQKbQjQ7c5BdaVZ6BOaNc=;
 b=XCEOizEUpsa6JHQapCrGx0iCfLudB08osBECCzCYmd/XmZWPH6k2lKDUVfcU0EOoF6
 Rm6/9DGaDrUWe7FvNQ0EMy8t5Qfm6oQ3EvwcQM6KAx6qMtmNIguQyiqoR3B3Vk5Kl5xh
 ceOW47N2BI2tnqo5IVOlPQShZ5W/nTWX20m1XixCXoj2rMVx6l8qNWczlobNc/3noIU8
 D/3HG3M8iyy7iB1bx3UIPp4Blw4t7H2++bYFSzEJcEOgLw6Ni7awGssWYjDFT+foFjr4
 DmhFXq59eaGstWar/1rnEEPtfwgG9beLIv0gjY4PpMK8ZE33qGfL7k74ZPjd+28PPE9q
 XudA==
X-Gm-Message-State: AOJu0YzKWie9nNR2R5VDaHX58PosMwoRY/1yJsL6NWQa2cxEzzlF6lDS
 7eY+ogZcxpTQ1wPELYcHi1+29As+832VnNqSqps+rfizNK34+uwSAI1hMzYUR2asHNuza5GvP9Q
 3dVxf
X-Gm-Gg: AY/fxX6ItXhcJ1de71g04lspxfrVZzZI0VLgXFrseEH7JqK03JxG7qKWaUMhRlnKeTq
 bFdFNyWH5a3zH0GYvXv2USmteDUkwk4e/W7eRq63pyCJLP6Tyykxo31qEqWvy40O62gH+fCxIa4
 g4qmFmuZ5hbOEp4H9EJjhr6tDKMPRQfHXMwSsZszk93kBUSk8EUMKXHCjdM5aYz4vbPkAp4dH4N
 UaA9cmNR0evNrlGrxjHjW70VGG9QO4DLi2/ib/vNJAjMLsVR5aQRXRu0/JCDJnblJMBKhJtCEWF
 RRm8SAzZKNiR8vtozYxLAFYlnMuEXgg4B4/E5vEhH+dXOa7kYaHymBzZ/Bks4Hst6WI33rTvHgy
 Q5EMYY0IFYP+12Y/MC7cfFYEASTvYdzS3A4tWuACuI0e/dYY2ElS9v4WxAQPuNyFmHYe3UDFbdE
 0d3KLumg6xtqS/EIKSCFyY/BtH+aUMHl/dyWqc3WPLPGJxKxcPLA==
X-Received: by 2002:a17:907:2d0e:b0:b87:2780:1b36 with SMTP id
 a640c23a62f3a-b8760fe5f00mr29528266b.13.1768335823866; 
 Tue, 13 Jan 2026 12:23:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 05/18] telemetry: check for path overflow
Date: Tue, 13 Jan 2026 12:21:44 -0800
Message-ID: <20260113202329.35190-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

The unix domain socket path is limited, check for overflow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..1d73282ba8 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
 		return -1;
 	}
 	*strchr(data, '\"') = 0;
+	addrs.sun_family = AF_UNIX;
+	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Client path too long\n");
+		return -1;
+	}
 
 	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (fd < 0) {
 		perror("Failed to open socket");
 		return -1;
 	}
-	addrs.sun_family = AF_UNIX;
-	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
 		perror("\nClient connection error\n");
-- 
2.51.0

