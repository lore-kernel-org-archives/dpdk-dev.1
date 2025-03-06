Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2939C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 21:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED4140E01;
	Thu,  6 Mar 2025 22:47:53 +0100 (CET)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id A6E1340DD1
 for <dev@dpdk.org>; Thu,  6 Mar 2025 22:47:51 +0100 (CET)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-474eca99f9bso14989441cf.3
 for <dev@dpdk.org>; Thu, 06 Mar 2025 13:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741297671; x=1741902471; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4dW8Io1bclbklE+hZPFAt52aE2lP2RppHhdcPFmRNs=;
 b=JYLgJZkFLHbbCq0l/dWU52WfRjmIiJn5b6j1axNrrE+OmDP+600rRoqTyFCq1M1mea
 /tViYWLKejLOkXBBwvMCnwiIvCSQU8n8rI9ZNr/KaOtCgyUJvPNhbj0QvEIcYtVlpuB3
 6RMszpOaOYA+AVHTbB/q8bH/A08eFG821Tr/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741297671; x=1741902471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4dW8Io1bclbklE+hZPFAt52aE2lP2RppHhdcPFmRNs=;
 b=Rr5ZrW1yEp2s70+/zPTkJWb50JsZ66vrWKTXhkg+iyulwjlI9OGDF9SugQ96xWgMnz
 GQrZIRLJLmmx1fVEK9S9kyLP+RIaIbg/mAtW9+A7L6HeDVpyaky0dXqshgrQSMRSTdLi
 BXf4bFiCp5s0bCfPxbdX4ZVgFNMUVOG+CY+gN0nY/JCt01Tgf79T1QRcWE/KF5ye88vG
 8QKYF+VkZ/bInDvz/F9YEk9jIE48uN/g3jyFXX3KKRBAz+GE0YmuaO7cqMYAyln5tvCa
 NiIvTkb3u+POYWzx+p4sfYeNHEZ0Lx0w3u6JunKtPu9co5mu/ITHzpRsp5RpmikyAXpC
 2dww==
X-Gm-Message-State: AOJu0YxcJ1g0aukwLpVD3LEQoVneQvTByhFDnZoDmQlmpZbXmoMTECFj
 ehimDEvsGpE6NbI8RFMkybO3rsqqkhY78fgL/6Ora+SAnIVnqsNRhGYZFlmnrP8=
X-Gm-Gg: ASbGncsVBIUaAgikDt3VzOOA2jMHXr0PudqjCPDEtDof6pYizNlBOJnkU+xbyDn9X33
 Rsu9RVG74csP1Vh81R+klMpV4Gk35HEsDsHX/Bva0YdrRpdI2+aJ/Wv+DwVhnvgOMfISDqQCNMN
 xbk+xDgNGFKMKWj9OqZD8u5mmUon+XOGJDsU2/TX5/Jkfmm9z0Efx/SgA+gDnvNpG48HUuBtCNd
 SjYSvJdLZJtHT81R//9RFFomRcq/hvZQxh+5V8RrHOvjg+anWmGhaHImIIFiWFaJ/7dSQ/8Tkvq
 0lgi+qIyo8xN1uEXC2lV7W27GA3v4/fOFbhabtLIsY6Dy0DrUVPVukXuAkxcjKzAhvzZd1YfXHF
 9Q0kYfZGH
X-Google-Smtp-Source: AGHT+IHkAWIAR/Os4dCJwGw3+fN70EQJpeokCXvw7Ams8cedWkiiFNQBi1qr1fjfZsPzGOpKuaEWSA==
X-Received: by 2002:ac8:5dd2:0:b0:474:fee1:7915 with SMTP id
 d75a77b69052e-476109bef47mr12313671cf.31.1741297671081; 
 Thu, 06 Mar 2025 13:47:51 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751db4ca3fsm11892341cf.70.2025.03.06.13.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 13:47:50 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 1/4] dts: add layer 4 port field to verbose parser
Date: Thu,  6 Mar 2025 16:47:44 -0500
Message-ID: <20250306214747.579340-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
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
---
 dts/framework/remote_session/testpmd_shell.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 1f291fcb68..f99c24bb04 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1278,6 +1278,11 @@ class TestPmdVerbosePacket(TextParser):
     l3_len: int | None = field(default=None, metadata=TextParser.find_int(r"l3_len=(\d+)"))
     #:
     l4_len: int | None = field(default=None, metadata=TextParser.find_int(r"l4_len=(\d+)"))
+    #:
+    l4_dport: int | None = field(
+        default=None,
+        metadata=TextParser.find_int(r"(?:Destination TCP port=|Destination UDP port=)(\d+)"),
+    )
 
 
 class RxOffloadCapability(Flag):
-- 
2.48.1

