Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E55CC9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7B1A42E46;
	Sun, 18 Jan 2026 20:14:39 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id D012742DD4
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:36 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so630286366b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763676;
 x=1769368476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KkY8DgUFTHFE7oBHjVGy1nvZTIFX+Me6KKGyxD0PPM=;
 b=VqtOMffUAKovmuyLMXixtkI5bZQuif5qEqn/cM6Ohj3kB/dizCcqOCRW0XzsGpf2qS
 QHbwbsxAGhKjcz+FCTDBROxpwWAqc7MFo5+F+TPRO6pbOJ+Wg5iue3ZSSdGvN56ggKBd
 ynlofQook6nnZSneAr7U+caZyQywLJaYeXCIRLd+thh0pdLVrIKVTcK8sl3A4iVLWjXx
 Axr30/c3uOMLyoYWjt7zFH+eaaPtCHfFNK/azShTgvQfQWjT6sLBI/KLIpiLBPKSZFYT
 sIzzlF+WrbBIKYZtiuJ5bPSGE/W723G7pBvVMDKluA1ihfy4nQhhenf8rbQzJzPbxLVJ
 qTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763676; x=1769368476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4KkY8DgUFTHFE7oBHjVGy1nvZTIFX+Me6KKGyxD0PPM=;
 b=Ha7PhNO0YqxENMEVbNYIjgCQT7pVQ300t227GxiaC212OR6V4vH/5bm9h+ohWxLe68
 DrMxiIcni5H3RvvqM3dFj5ocZ/Pha/CY30UrgWGmXcu5MKEhzdctPjAl2uEExTZWZ4U+
 TICY+iWTJNmYyOCKSUAZHucM6gzJk4ll4trszUU5RWJchtoxVrav+uCFwKp5/QyA4xyb
 v74bDHfzGU/sjogAlwoJ6KvcgEd98yxlYjANbST+QZYEKSmiIsnuKaV4UHsq0MeXDCJl
 nd3QI+TSWtiMvQbkJX9NAT8iLSXyVNzEdg86BcDaPoYw4P72Kjz2yBdSfSCblTgS2Mqp
 67PA==
X-Gm-Message-State: AOJu0YxjoxlChHeqSHXPr/Evs+VwK+wwESuQtpb/hkVM1oadg/4t5Nia
 4MfsNGgApJJ7wiCig60B9jBJ62umzzZKzDG/Zw3VDh1KhLhmr3RcqinWRM+lcyjd2mbYfiZVamV
 /uHYD
X-Gm-Gg: AY/fxX7k7TsCBH0oeFOrY0Ov8Y2Xs+v1P2m9XeBL5prGATKaCTuJBZ9C1GbnaqX8KiJ
 +o7fjIMrF7KqxOSPrYpMNA7qrDDeKmZOilToMYqi8rhzBsbnNaBNlbbLpPf6n1LxEU3rGas0qzU
 BNbxB0EqizQzOht1pQcvZk0n7HuxIASMFwP9xeal+IxDCyDYgjNFzRpb7zTVgTFmu4ncyyVHVyp
 SYXttxpxrbY6x5FKjeaV3sL2nYjWCaVN6/fQaM5j6CvqRsi07BaZJLjD+yagP4NeHQGCVH1IFv6
 cN2dbLU8lBLWL0Bu86arv3e6iNbsC2VXkPZDiUbjfSw+la/04NlCmlezodfZAsy1C4v19HoQQln
 /EUEy7bf18b6YSHXViuStiXo/oK1ApSMHfzPGVO/INgBOWv9VQG8Qzuobw2zrnta/hIoxC4fgR2
 RRn9gbS88X05VpGmMZ5BRW+DrA2c+WMGng17SVNiu+5Ume/G1GZbrRFjgR27I4
X-Received: by 2002:a17:907:3e10:b0:b87:d09c:1825 with SMTP id
 a640c23a62f3a-b87d09c1ab0mr137189566b.13.1768763676389; 
 Sun, 18 Jan 2026 11:14:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 44/54] doc: correct typos in power management guide
Date: Sun, 18 Jan 2026 11:10:47 -0800
Message-ID: <20260118191323.241013-45-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various typos in the power management documentation:

- fix "users space" to "user space"
- fix "according the" to "according to the"
- fix section title "User Cases" to "Use Cases"
- fix "die's" to "dies" (no apostrophe for plural)

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/power_man.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/guides/prog_guide/power_man.rst b/doc/guides/prog_guide/power_man.rst
index 74039e5786..b4c9271e0b 100644
--- a/doc/guides/prog_guide/power_man.rst
+++ b/doc/guides/prog_guide/power_man.rst
@@ -4,7 +4,7 @@
 Power Management
 ================
 
-The DPDK Power Management feature allows users space applications to save power
+The DPDK Power Management feature allows user space applications to save power
 by dynamically adjusting CPU frequency or entering into different C-States.
 
 *   Adjusting the CPU frequency dynamically according to the utilization of RX queue.
@@ -60,7 +60,7 @@ Core-load Throttling through C-States
 
 Core state can be altered by speculative sleeps whenever the specified lcore has nothing to do.
 In the DPDK, if no packet is received after polling,
-speculative sleeps can be triggered according the strategies defined by the user space application.
+speculative sleeps can be triggered according to the strategies defined by the user space application.
 
 Per-core Turbo Boost
 --------------------
@@ -101,7 +101,7 @@ The main methods exported by power library are for CPU frequency scaling and inc
 
 *   **Disable turbo**: Prompt the kernel to disable Turbo Boost for the specific lcore.
 
-User Cases
+Use Cases
 ----------
 
 The power management mechanism is used to save power when performing L3 forwarding.
@@ -285,7 +285,7 @@ Get Num Pkgs
   Get the number of packages (CPU's) on the system.
 
 Get Num Dies
-  Get the number of die's on a given package.
+  Get the number of dies on a given package.
 
 References
 ----------
-- 
2.51.0

