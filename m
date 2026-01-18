Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7937AC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2E0C40E7C;
	Sun, 18 Jan 2026 20:13:57 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 0F78F40FB5
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:56 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b87dba51442so6792366b.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763635;
 x=1769368435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SnyokBrEHqQx20AUepf1ctVvAL1po/tCV2jB9D5ga5w=;
 b=kf8M604GAPGhfx7D7+L2k+bduSmIZW1Jpx4Ynyb2rlZ4AQ4zXYoygcEfX4LjgFEQU9
 uh5qu4x8kofN+JAN98pX8zFAusN3ZFzLlel17CCV8vwfa3XmVLw2L/HsyrK3b2iI/8i3
 6gLdKuzM8nwzn/edbQq7GIvQQe6kfkfFiOUzmjg3fCQUN7RNgoWocF/8rHIXxM9c+AC8
 cz7dUmfVsx8g+q6CjtBb9TMxn++nRDSk9+W+VnQP0HPNH7yRDTfy3eR1jVZFo4FiPZY3
 Dk9Hf9cFoREfDX3WnKjvGo6JtspB4GsdWhOuAXFUnbWHRmqHqNICtQwMdHs+SNhPQ+2D
 5KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763635; x=1769368435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SnyokBrEHqQx20AUepf1ctVvAL1po/tCV2jB9D5ga5w=;
 b=gSEqsLlF2acWYcUUkvWOPfT4bSB44YDz1q5xuK8F5iL7mEVtGFQPU+3Jnb2l3F/m7l
 FOLCkNteqHBR+DbnANZia1DEgIsx/Zu6NCjTeaS167Bmibs8IBGd4CtWEEAUWW5F44W/
 6J1ysEjdiCDr6wFCcwjtM360/nojknUWp+R0Yat4GdXdU4pi+zvb+7OTX40nsPPULfdZ
 2D0gCYDESr9bmgFJQ39aV2KAdrjL/nBj5kFfFefocvPkD3FDX8x+cI89flPMpyhfrvei
 pBdvUXQ7xhlFa8mW+Hm9tZYTA/FYPgCoMaR7OJ6PFprllMcylyVzdtJh/Lvue6cFhI6P
 HCew==
X-Gm-Message-State: AOJu0Yxx+HgXyUy6nQj9JCa4Wu+jQ+9kJhMp6ZUnmJWZfohFWqYvKmn6
 j8wDy0lS4JzXyyDo4BVQJugnb8KtrnJM2pJcEOuO40c+9ALjR+4vDGaGGDKWvrpHLoNMWHvS1Og
 Fcysf
X-Gm-Gg: AY/fxX4+PWbaDvw/ex7cueHQlrJ9kHF9L9WAt+MZxIyQEfV7CbEA9lw3A7z3JJXwrkO
 6+zIoW+YAXtlSnlZZU9nV2XFMLE1FPruJ/pVK7rVP6dW1e9TA6odTrEm79YiAzu197hKvj6QpD5
 ZD1fIZRSJmnwL3Zy84nj54F8WFJlUMBy0LvXAoaGWl+YOZfefBDFtzGp7JxToRwehi9q5OlwqiC
 fmMBHFk6N7BhUYQ3q62/T6Yd9i6t/tf+KmRJ6lVlaVzDNGFLtCXRjalvVJcsiXSZ/StLfNQjUXn
 CFhYjV0K16s31mdtetRH1dZpgiRSc4iXnlDCGDFZZ1rSdDQGHoVZ6gXS+A7Q/7pBSMqyZc9IaPF
 LaKrr7IjyR7jALO5+z3DXPdBD9f2KEC983lFgjoV6V0vQ/pHtrsiE/QJVIwLM5v5JBq4vhKzJ/g
 /8GnNglW57NB8O9sHA1ZcK9pWEAs27eeJhXMi3Dw9TkBHGw/S60g==
X-Received: by 2002:a17:907:3e87:b0:b87:19b3:3d66 with SMTP id
 a640c23a62f3a-b879324d66amr696557366b.60.1768763635546; 
 Sun, 18 Jan 2026 11:13:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 17/54] doc: correct grammar in EAL guide
Date: Sun, 18 Jan 2026 11:10:20 -0800
Message-ID: <20260118191323.241013-18-stephen@networkplumber.org>
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

Correct several documentation issues:
- Change "It consist of calls" to "It consists of calls"
- Add missing comma after "EAL" for proper sentence structure

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/env_abstraction_layer.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index d716895c1d..170c34576d 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -50,7 +50,7 @@ Initialization and Core Launching
 Part of the initialization is done by the start function of glibc.
 A check is also performed at initialization time to ensure that the micro architecture type chosen in the config file is supported by the CPU.
 Then, the main() function is called. The core initialization and launch is done in rte_eal_init() (see the API documentation).
-It consist of calls to the pthread library (more specifically, pthread_self(), pthread_create(), and pthread_setaffinity_np()).
+It consists of calls to the pthread library (more specifically, pthread_self(), pthread_create(), and pthread_setaffinity_np()).
 
 .. _figure_linux_launch:
 
@@ -69,7 +69,7 @@ It consist of calls to the pthread library (more specifically, pthread_self(), p
 Shutdown and Cleanup
 ~~~~~~~~~~~~~~~~~~~~
 
-During the initialization of EAL resources such as hugepage backed memory can be
+During the initialization of EAL, resources such as hugepage backed memory can be
 allocated by core components.  The memory allocated during ``rte_eal_init()``
 can be released by calling the ``rte_eal_cleanup()`` function. Refer to the
 API documentation for details.
-- 
2.51.0

