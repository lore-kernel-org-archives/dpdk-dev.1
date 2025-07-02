Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E069EC77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:23:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F34F840E4C;
	Wed,  2 Jul 2025 18:23:37 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 084B84028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:23:36 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d21cecc11fso1181542485a.3
 for <dev@dpdk.org>; Wed, 02 Jul 2025 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751473415; x=1752078215; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kv0nT/LMH8TZkc0O+Vdz3gj2LTBnKtd0PqNx6KlHi0w=;
 b=L8+tEi3KfiDC19hxVW8KhOmJm+bph4I2ySM7RLbnT+rte17VAt0QDOL43VdrSTx+l6
 tz+lyTBjE2Cy4Q7EpEXXcbk7FHA68fquN3exS/TyUsHKqeNR2WMbblc4NGjnHwGBQpmg
 7F6TQRhqmNuag/KPSGhPLk6+UIgAqhIGDPkOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751473415; x=1752078215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kv0nT/LMH8TZkc0O+Vdz3gj2LTBnKtd0PqNx6KlHi0w=;
 b=hXQ99zdDMq9dlWxkyGO0C87FVi4QqVCdEFDLx0AW1IxKL7ka30jpq1jlhEu1E7n+oB
 TXNKhw+3mrz2dYvi4bnQZHA2s05sy7BL6G3s0haLrIyraRbc4M82piB5dw5RjE2BbTm5
 X5Z5x6p37tKwbA0vDil61ACEHY8WVBuHbVkNILlT5Q7oQM7zVaOgwksC0ziGjL+dKyLy
 3HAcIR6QlXxyvxMwCgH0RlBj3gFAfOs/8/NPd0n66d3L7751HwhT27nH2vzxL4uOJiUm
 jfQw78Oz+V7AlyTLDw/IBrtG+JvA65q8q0CdZsd4AWTEu5CWJgjhCiVO+7k+QkyU1B6b
 r7oA==
X-Gm-Message-State: AOJu0YxxD6OqqqvJBkcphChjResN06A+DZECFlg1ffOmhNX7zNp8Y+ZM
 J8NXceyCp050jXzjPnjtD8IQy7wo2vs3ASAZSe+0JboQzqxUHUCcc+yACAEDqjqOrUs=
X-Gm-Gg: ASbGncuiOJ/b8b+IYQgzneG7zFqKfnlO+/wMPXvdFA6KdG2u8yv8rjk8CEvce4VOdZH
 N8hEXgGchVn/0kyQMnbuzY1AASNCZBuhcaqcPrEAettKC7rJ2IR8EUl/BgojgSI1Cx1EulosTME
 hJBfzW6fjQy55AVa4X1Ou+G+OTEmbAAI5Dm388a2YQZRLADtAca5WYluWPTVBop/2YOXI0Nt1KS
 m9B26rpWnSSEqq5HW2+6UsZnoR4I+L6WeNkljrWdl+8IIdCr/tPmfHDeWyPKmpF/EAVIQVP6Ptx
 diAEE3ba/76w0yvrAv29EmqcTGaBhKsJAFxmLpajxL+WhJyvWNHLwmgOmJeBVBma5LYwoDsO
X-Google-Smtp-Source: AGHT+IFh7URO++dGRl0lpvl5rsdiz6tbrczwwrdSpQEPa0dG7g8gznpGcqpMY1JaDmOIwiLw2pWvCg==
X-Received: by 2002:a05:620a:4044:b0:7d4:4596:d69a with SMTP id
 af79cd13be357-7d5d13c1da5mr29709885a.9.1751473414997; 
 Wed, 02 Jul 2025 09:23:34 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316585dsm966947785a.28.2025.07.02.09.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 09:23:34 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 2/4] dts: remove unnecessary testpmd verification
Date: Wed,  2 Jul 2025 12:23:29 -0400
Message-ID: <20250702162331.352313-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702162331.352313-1-dmarx@iol.unh.edu>
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
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

Remove unnecessary verification step in the start method
of TestPmdShell which checks the link status.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 299887dd80..6d75f89969 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1578,13 +1578,6 @@ def start(self, verify: bool = True) -> None:
                 self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
                 raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
 
-            number_of_ports = len(self._app_params.allowed_ports or [])
-            for port_id in range(number_of_ports):
-                if not self.wait_link_status_up(port_id):
-                    raise InteractiveCommandExecutionError(
-                        "Not all ports came up after starting packet forwarding in testpmd."
-                    )
-
     def stop(self, verify: bool = True) -> str:
         """Stop packet forwarding.
 
-- 
2.49.0

