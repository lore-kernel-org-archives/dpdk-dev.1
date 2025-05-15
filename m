Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86400C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 18:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AF8940EDC;
	Thu, 15 May 2025 20:33:32 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id B76A640E03
 for <dev@dpdk.org>; Thu, 15 May 2025 20:33:30 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7c55500d08cso129947185a.0
 for <dev@dpdk.org>; Thu, 15 May 2025 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747334010; x=1747938810; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuI8r0B6cDtcHpfzCvNFTGyqQkLHcqYHPNtEYQld6yA=;
 b=i/McgoSRiTHcNU2Cs81vZP/6ytJc7AZnyPs/aDyab3BLyD/mDlmFbHEp95MA14FvG+
 CfxP9CVY4abdH70yeC+H91sXK2Pqqozgmq0QYOzXWqlvKayUMpDaozSlDHb/E73NZK9E
 fz0aJxsxx/c9FiSP/2GGbf4NEAALKh/AvDHCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747334010; x=1747938810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuI8r0B6cDtcHpfzCvNFTGyqQkLHcqYHPNtEYQld6yA=;
 b=dYzjLNtLlxMWc7O+IKxdvE+k2bqGKV7jdLXro80k4FlPcej15Oi1iJjotOSByCASF9
 wYAZeN7nmLmY1vfP6j7K6aP0K2xrzTm1oUTnKHULJplh5pAn/uRFNHGYkO2wC+WXky2n
 WV1HeHIAxVC1Gy4WCroxXbd3fduBjLxDJbi7LqM5RHYSVKcKMHna5BvhP1auP3FUx4v0
 eEP955uCL9puCVxIsYWHEmfxdJ4aYPjdj/1nRmxtrSU4MVJyD5JJSKUvPDcUjCIW2rs/
 srjrsBVRLF5VqwUUHy8Bnqeot5KiBlccgjykAPnzzWty7xKLgnl7mkQnvoBxv/zbXMTr
 Jyfw==
X-Gm-Message-State: AOJu0Yw0NY6cfyR9hR0BcuXYdU43AXffB3AePLUX66Uo96y3cZ8diX8+
 6RDDdDWsJQ5BdgfNUFkFAjyLgScizOT/G8PevoaOcGLHOQWvRWWlPg6dJWsqas6dOKc=
X-Gm-Gg: ASbGncsFqpvIg7O2ouYU8KCC/NpOUcGfGjwrmLgv8u7+J+ztm8P60qf5tmOLdBi+0lT
 VimeQ7+tmvUtP46JOwXlX90WjPFVuXISlLc8EptTOuhMddyXcMRCv664k2V1OnkX2as2zSTNDy9
 LBHe7T6oeNXth91aKu6520/+dNVmMVvxNFbv/pwrwEx+Y6AypgGAj7dEVRNN4KAxAKCq3ASoajY
 cIFyvJ39jrHEc2t4jrLzMng0Ot6AjZ8LKHGOYxbDRzO9mB9RV8fteExPJhdQr05u+W9/HhEwn+G
 AME7YfT4XNN7YTMcMpK/hYv+HRO8vQmJFerokFi6XF9u/AkI1OFgpdRzo1GZ3Q==
X-Google-Smtp-Source: AGHT+IGm6hiszNUb0tCSpxE/rZ0r2mzsIP8quZrSvPHCgBX6/L3tdyfqskzptcxPwtImQCobFtIscg==
X-Received: by 2002:a05:620a:269a:b0:7c3:cd78:df43 with SMTP id
 af79cd13be357-7cd467adbb2mr67500785a.58.1747334010055; 
 Thu, 15 May 2025 11:33:30 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bc7d1sm18100185a.1.2025.05.15.11.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 11:33:29 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/4] dts: add layer 4 port field to verbose parser
Date: Thu, 15 May 2025 14:33:24 -0400
Message-ID: <20250515183327.191912-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250306214747.579340-1-dmarx@iol.unh.edu>
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
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

Add a field to the TestPmdVerbosePacket text parser
that stores destination port values for TCP/UDP packets.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index bd5f2659bd..e48b2c8ed5 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1271,6 +1271,11 @@ class TestPmdVerbosePacket(TextParser):
     l3_len: int | None = field(default=None, metadata=TextParser.find_int(r"l3_len=(\d+)"))
     #:
     l4_len: int | None = field(default=None, metadata=TextParser.find_int(r"l4_len=(\d+)"))
+    #:
+    l4_dport: int | None = field(
+        default=None,
+        metadata=TextParser.find_int(r"Destination (?:TCP|UDP) port=(\d+)"),
+    )
 
 
 class RxOffloadCapability(Flag):
-- 
2.49.0

