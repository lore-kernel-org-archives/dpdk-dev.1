Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73408D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A2AA40E34;
	Wed, 14 Jan 2026 23:25:12 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 8DDF240E36
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:10 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so3628765e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429510;
 x=1769034310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SYW3oT5V/3le+qvyokCi8QNmQIHWKGR/3RbbPOKAZc=;
 b=hxTRYQ6NiJG5YSXfKe9N+ITVFrqARujY59AJIyIG2Xf2pq25VNoAGxbqn8jUoleOb5
 Hbfy7FYGXNJaCyi7UvolXZb/4ScjTyqunr/Os7vEHDm3ILhNVeXHOIrvBfutlgaajCrm
 eFxpgk/FU6f921F6yMvPGOzyW0sTF/KlznXByh8pCvsEzNfhFOjPh+4FEA9h/WcaFuQY
 Dxk/OuozkkdUwDl2Rfjep2kuePPLBTjyumaAmRnINlJ7KGrM39/xvvsfiTIg9NZKwwHB
 oSHcBNTgeu4g2ktaerDvME2n8f1djCI/cPEAgWD+zlzH5GxMjg7CfrmEee4O7fZi01u/
 jSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429510; x=1769034310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6SYW3oT5V/3le+qvyokCi8QNmQIHWKGR/3RbbPOKAZc=;
 b=Cy5BkHcooTYRCo2aQxGjCq4as+BXmYPrUpyJCY45SRFa9EjLSV6w3qZUxGnqkH0Nvm
 0ykLn8cGIm3wvv1qulpHFFjjRH4ts89Zar3M/XEUELNj5cOxBBNlec/Aqbkqyzfp1sMX
 WG1skUVPDFb0tqTVoEUzCHvUV9bNFwT+Q2qNn+iTTpK7SqTF2kJgX1pH4DK+pD+o96cu
 sZCqJ7f98VvIEHgQW8JVIas40C4qYux4KgfCwDDl52eISFbePxuSkd8cavCygjyI7T0k
 VGlmKoQfPGt3976foBDIEy0Xpv/1PyBg6v/8xJrCnw8Q0bE2obnRHbuOj0GwLAf0JrQe
 Il4Q==
X-Gm-Message-State: AOJu0YyRVipviHTA2gmFh7RBuFifykF2htcXtucHoOb2MtFPOxGooQuN
 EJXJP9KZXWpt3jlZ+/2EhvTnPE64vuzU/X+0yaYluGo3ooxZhomtJdwGKUHZxb8JH/IWG9dLJWG
 Yx3nDG4Y=
X-Gm-Gg: AY/fxX5fhoHwB1KozPLML5A9sAlTG8vxAYWilCVL8sOea5089k6zoO9qF7yhhGSAQ1F
 6qKvbIFkjGJyfFmTleVC5t4uttN+kivv93OBZ1BZZZ4ErCzohu3ag4ETnGuJQMeYKiJKq6FLF/6
 uICJGFEj1PzyC9iHfN4RVbanCqOblHA1Hq2I5csZN60dHQnpwpvR0L8PFj0xXptP34N6udvav86
 D0DLsBd61IyLUcBhZDMR4+0wGJIED0LNhvCjYBejrz/c7UdILRYpVQPhIio1wp98zOsJh3arTV1
 Zz568rfZngWf/k4Fy+xEE58b5l0ryrmxeP+gKE2QuYf4kTY+NdeSodf2xejy2sE29TI1XIL54Yv
 NcYoDplv6dnZmwnfWDEg8wazrzZ8FRBIlspHVC1foEYE+aiBfk9Q59h0kEbnGDZmdMFjNN+Ar61
 1RMImbd/tWNjD1V9qNMATtxsyX2cA1REr98RY7hQChSOSwSw77HQ==
X-Received: by 2002:a05:600d:6450:10b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-47ee3371a2amr40334695e9.24.1768429510106; 
 Wed, 14 Jan 2026 14:25:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 John McNamara <john.mcnamara@intel.com>
Subject: [PATCH 04/29] examples/rxtx_callbacks: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:45 -0800
Message-ID: <20260114222458.87119-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Address issues in RX/TX callbacks sample documentation:
- Rewrite confusing paragraph about hardware timestamping for clarity
- Capitalize "linux" to "Linux"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/rxtx_callbacks.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/doc/guides/sample_app_ug/rxtx_callbacks.rst b/doc/guides/sample_app_ug/rxtx_callbacks.rst
index cd6512508b..7cee5bbf8c 100644
--- a/doc/guides/sample_app_ug/rxtx_callbacks.rst
+++ b/doc/guides/sample_app_ug/rxtx_callbacks.rst
@@ -17,9 +17,8 @@ packets to add a timestamp. A separate callback is applied to all packets
 prior to transmission to calculate the elapsed time in CPU cycles.
 
 If hardware timestamping is supported by the NIC, the sample application will
-also display the average latency.
-The packet was timestamped in hardware
-on top of the latency since the packet was received and processed by the RX
+also display the average latency since the packet was timestamped in hardware,
+in addition to the latency since the packet was received and processed by the RX
 callback.
 
 
@@ -34,7 +33,7 @@ The application is located in the ``rxtx_callbacks`` sub-directory.
 Running the Application
 -----------------------
 
-To run the example in a ``linux`` environment:
+To run the example in a ``Linux`` environment:
 
 .. code-block:: console
 
-- 
2.51.0

