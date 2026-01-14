Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5301BD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21B9440E22;
	Wed, 14 Jan 2026 23:25:07 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 7AA5F4027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:05 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so1992205e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429505;
 x=1769034305; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH3oPXHR5tBU3ywnmLwpUhbPjM2w1Rl9MrCfMGf+U0g=;
 b=GHZhC541Z5GWVMlXdrCe4Q0ij/TJekgtzKRnnuSTgaatUD2sKIpBK5EUGVo0du6DES
 sh+3ZxD3sRU9y0T+AmQHOzk9qKJQMVmMF02bauG41WcfpkmTrg5c1wDCFka6e0MAyrBQ
 ThbO99GsPqfkb1Q2sYuy3M5y9d+i+c8TIsYNQGj+lcM8u6e+SG30y455hPkUNaV/Z30A
 aCLkLmkiSeatvjCnTrYiBPZx1s52Pxan623JTRAHSBXpd28liJQ66m1jYrkd+YklS3w7
 9K2AGZr/v+PeUNI3Tdr7dTdetjAha6bCXJYcaPkA1dTl/DeKm5olJWWeQXMccJryqzCG
 FDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429505; x=1769034305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lH3oPXHR5tBU3ywnmLwpUhbPjM2w1Rl9MrCfMGf+U0g=;
 b=jVA2fve+soPptlO9EQHa9CgEF3a+ZmszBw2okfT3KZHvWuSU5lWxyLeudIo95znV4+
 hcLs9Aa+CdtDsUaZR0HLsyAu4ceyfL5vVaBE9rHJ+L9a1TpAB1YKKcF1E06Qd/G8AQk9
 S0Zt3HknkbwFvy9fRcCNaaEdF1TcOOyL5WArO/OTxRQO2AD3gfZsbnRsJqU+B+6nhIZP
 5v+Az/FBUvmjDA6cWYABg3+PWxN1XKUhm4TiqkgAxvH3xbW7T0IcA7a710FXhj40+WrU
 Ym7Mbl25UTEH47qQwbuKze1UABCuFpULZP+LXpdt4T4sktOOrZUozkOcbsL7l5Mw+aps
 J7Uw==
X-Gm-Message-State: AOJu0YwhErWQEaDYOof76WMnyobf4XaZPNsZd/M1H4nowBLcCAAJp4oi
 7/ofixDN9sVmYEqCCpCYYORikKzwlSdSpNz9Wmh3qGufbVTeOKBiakApntiLGYwv3F24uQ0ck2t
 bdkVbUjo=
X-Gm-Gg: AY/fxX63CAU6obmwSTPP+uLZ9xzVzW0hfMCoqWhvv6seUR1tTHRHpstqt1IsKRL1EOb
 3+5YJeNt5THxnPpP8gkM6HUEFuvW0HaqGHsG1KapFCLJsAtizPp6klGElsZA3EENFv2enbYbE1u
 kp7br3omRzJwJk7+N3poWWX2oNOAqkvP1OSOsNfuNN9HowFRuQJCI2yEzYZ1fBzsHke9U+93/R6
 clCQYAo8KCThcwvistQrTb3skrynUiD3lyeol8U5F/0Xf6QS3Np628jd5+mUhPSJpxqfozOVYSJ
 PdJE3zgVjgJGe8I3waA2/aHTLMHIjYeIC2i6iJHthBk03auHIl/RXRddL+AxV2cixTOa6FxlzQo
 lbSyfR586S7ewAqt0dIGkcz8s1GKBC0klfLknbuEPI3HoMy49iTwP0UCpKby6WTdOW7R0DW329Y
 mjUjNeOiq5cgJBidh/clPZLLPYbjB41fTVqfMwATHB65e0HqCwWA==
X-Received: by 2002:a05:600c:3acb:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-47ee3318b47mr35714025e9.3.1768429504965; 
 Wed, 14 Jan 2026 14:25:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
Subject: [PATCH 01/29] examples/timer: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:42 -0800
Message-ID: <20260114222458.87119-2-stephen@networkplumber.org>
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

Address minor issues in timer sample documentation:
- Capitalize "linux" to "Linux"
- Complete incomplete phrase "and also on the main" to
  "and also on the main lcore"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/timer.rst | 45 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/doc/guides/sample_app_ug/timer.rst b/doc/guides/sample_app_ug/timer.rst
index 7af35d3d67..a1149be6c3 100644
--- a/doc/guides/sample_app_ug/timer.rst
+++ b/doc/guides/sample_app_ug/timer.rst
@@ -4,20 +4,23 @@
 Timer Sample Application
 ========================
 
-The Timer sample application is a simple application that demonstrates the use of a timer in a DPDK application.
-This application prints some messages from different lcores regularly, demonstrating the use of timers.
+Overview
+--------
+
+The Timer sample application demonstrates the use of a timer in a DPDK application.
+This application prints messages from different lcores at regular intervals using timers.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``timer`` sub-directory.
 
 Running the Application
 -----------------------
 
-To run the example in linux environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
@@ -29,12 +32,10 @@ the Environment Abstraction Layer (EAL) options.
 Explanation
 -----------
 
-The following sections provide some explanation of the code.
-
 Initialization and Main Loop
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-In addition to EAL initialization, the timer subsystem must be initialized, by calling the rte_timer_subsystem_init() function.
+In addition to EAL initialization, the timer subsystem must be initialized by calling the ``rte_timer_subsystem_init()`` function.
 
 .. literalinclude:: ../../../examples/timer/main.c
     :language: c
@@ -44,7 +45,7 @@ In addition to EAL initialization, the timer subsystem must be initialized, by c
 
 After timer creation (see the next paragraph), the main loop is
 executed on each worker lcore using the well-known
-rte_eal_remote_launch() and also on the main.
+``rte_eal_remote_launch()`` and also on the main lcore.
 
 .. literalinclude:: ../../../examples/timer/main.c
     :language: c
@@ -61,14 +62,14 @@ The main loop is very simple in this example:
     :dedent: 1
 
 As explained in the comment, it is better to use the TSC register (as it is a per-lcore register) to check if the
-rte_timer_manage() function must be called or not.
+``rte_timer_manage()`` function must be called or not.
 In this example, the resolution of the timer is 10 milliseconds.
 
 Managing Timers
 ~~~~~~~~~~~~~~~
 
-In the main() function, the two timers are initialized.
-This call to rte_timer_init() is necessary before doing any other operation on the timer structure.
+In the ``main()`` function, the two timers are initialized.
+This call to ``rte_timer_init()`` is necessary before doing any other operation on the timer structure.
 
 .. literalinclude:: ../../../examples/timer/main.c
     :language: c
@@ -76,15 +77,15 @@ This call to rte_timer_init() is necessary before doing any other operation on t
     :end-before: >8 End of init timer structures.
     :dedent: 1
 
-Then, the two timers are configured:
+Next, the two timers are configured:
 
-*   The first timer (timer0) is loaded on the main lcore and expires every second.
-    Since the PERIODICAL flag is provided, the timer is reloaded automatically by the timer subsystem.
-    The callback function is timer0_cb().
+*   The first timer (``timer0``) is loaded on the main lcore and expires every second.
+    Since the ``PERIODICAL`` flag is provided, the timer is reloaded automatically by the timer subsystem.
+    The callback function is ``timer0_cb()``.
 
-*   The second timer (timer1) is loaded on the next available lcore every 333 ms.
-    The SINGLE flag means that the timer expires only once and must be reloaded manually if required.
-    The callback function is timer1_cb().
+*   The second timer (``timer1``) is loaded on the next available lcore every 333 ms.
+    The ``SINGLE`` flag means that the timer expires only once and must be reloaded manually if required.
+    The callback function is ``timer1_cb()``.
 
 .. literalinclude:: ../../../examples/timer/main.c
     :language: c
@@ -92,16 +93,16 @@ Then, the two timers are configured:
     :end-before: >8 End of two timers configured.
     :dedent: 1
 
-The callback for the first timer (timer0) only displays a message until a global counter reaches 20 (after 20 seconds).
-In this case, the timer is stopped using the rte_timer_stop() function.
+The callback for the first timer (``timer0``) only displays a message until a global counter reaches 20 (after 20 seconds).
+In this case, the timer is stopped using the ``rte_timer_stop()`` function.
 
 .. literalinclude:: ../../../examples/timer/main.c
     :language: c
     :start-after: timer0 callback. 8<
     :end-before: >8 End of timer0 callback.
 
-The callback for the second timer (timer1) displays a message and reloads the timer on the next lcore, using the
-rte_timer_reset() function:
+The callback for the second timer (``timer1``) displays a message and reloads the timer on the next lcore, using the
+``rte_timer_reset()`` function:
 
 .. literalinclude:: ../../../examples/timer/main.c
     :language: c
-- 
2.51.0

