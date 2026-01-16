Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF0AC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD47442EA0;
	Fri, 16 Jan 2026 22:17:04 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id B2AAF42E97
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:03 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so3837478a12.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598223;
 x=1769203023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7u6l426J1VFyTVR1PqN6EuVDxW0DQpLMCpRXWwg143E=;
 b=G6x/86S7L5NBAUNQya7E18jFG97xC+TSfeXofDYyQ9UHf6wJzjJZW/1TvyGEpKfzB0
 yMbO766g60XK/h9LNBeJYMTgx2DzguDuJkibloo7I8CEKGSphJinQh6ip69l6O6+klFt
 n8PvQ0GVCMwUDpZIBN8RPTZf2HQ6lC/4tbrktlqbDhWNd0fKJbuLfzoqHofNBiRiLdKf
 M7dRQ16wc/+9IznlpsvKjiEB9zakxweebE1kYPdE57uXiOekodZy7BPFESpQDYQGHS3M
 QW2kkTwEMjbjcfTeOpUZ69pFUf0lCMJ1IjcwB8hmqPrwzNasL179F8AS6jez8nDBc08o
 A+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598223; x=1769203023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7u6l426J1VFyTVR1PqN6EuVDxW0DQpLMCpRXWwg143E=;
 b=mRY/tg1dWwFsNHNvs/YNf8jlyuGotIBAyK01dJqOCKtKNwrlVx1N4Ayh2RimELXPRf
 hibAWdIEv8GNeAsKjzuwtS5zbOtheFkS3a4dPWniSpdE4MV/nvpW8wbateuXAfOcGa51
 CIKHq46yd0JpSeRPT8fPkouxvDpNhJWHf+v95YL9L3FqdxupW31CxP7AgguA8ygK7gVb
 urJl39TvYyWNO0tv4vm+O/K3HvhcwWHoryvRSnBlK4r8elgFmVTUfHjSEjM84uc8HY0a
 ifu1/l9JPwKxKFlZ49LfwFHW+d7gERyKKmL7aqmIgaMoVZePsb3kU8wYiq1ZRumk3+WG
 qbFQ==
X-Gm-Message-State: AOJu0YyZL4jISzMsx8ojepZx3IBRS2P7bGFexNBIizhzdxt/8JHSFnW4
 ZP679iGt4gp2cjVRuzNllUQAZICQJfANEWX9EYTYTBvKp51rVTeFKjL18UklaGIyszGNTMIIarr
 KEqFz
X-Gm-Gg: AY/fxX7T/EBXuZwOICizKo7bsMPJhgBnCeKzeRtUWk4LVcZTCHFWMPqdViQfBK2wvMY
 zaD+F4IGfD5oBeFqDZqYQl8iXrybW4Ce4y4mYmkveqYK9gFu6SWgBEDc8qnaxbitVyg0x9KLZtP
 kYHCYA9U12Hp8wLDNiFer8Z6MBILpctK4iW1gPAy+3wVse98tbETMAnc9bIe94K2GfS4ovkSVDz
 /afsjBLaZw+4Z02NBIrmQYZK9FP5QCzwS/tc7M7r+iubhZNv1IFoQxvDj1YH7fjbcC2nG6ev4vc
 5KTbZNJqn6gFBtnXZJgmlWrht6QdJPiz2+1/RfugKUcjKjhpTDfYBT4R55j+EbjLWqtpRC0vX2w
 iqL2okH5AH43Ma+e63v3CXJLL++QS7jr6zjjw4Or9woYFGyJ3nNsNrN1xxY1YmFWlqw1ttCaAXR
 z70/ouTH6oY4fnZejKxE6icrS4RziKyeTtf2ne7YIAY7ULVj094UEhEStnZz1g
X-Received: by 2002:a17:907:c19:b0:b87:1741:a494 with SMTP id
 a640c23a62f3a-b87968f5a60mr277567066b.17.1768598223178; 
 Fri, 16 Jan 2026 13:17:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/11] doc: correct typos in DPDK build guide
Date: Fri, 16 Jan 2026 13:06:19 -0800
Message-ID: <20260116211649.104776-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Fix "a set a" to "a set of" configuration parameters.
Capitalize sentence-initial "an" to "An".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/build_dpdk.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 2a983412dd..ed30e4a5f1 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -100,7 +100,7 @@ to a regular "debug" build, you can either:
 * run ``meson configure -Dbuildtype=debug`` inside the build folder after the initial meson run.
 
 Other options are specific to the DPDK project but can be adjusted similarly.
-The "platform" option specifies a set a configuration parameters that will be used.
+The "platform" option specifies a set of configuration parameters that will be used.
 The valid values are:
 
 * ``-Dplatform=native`` will tailor the configuration to the build machine.
@@ -327,7 +327,7 @@ and the sources for that build are stored in ``$(SRCS-y)``.
    location in the user's home directory. The install location can be set
    using the `--prefix` meson option (default: `/usr/local`).
 
-an equivalent build recipe for a simple DPDK application using meson as a
+An equivalent build recipe for a simple DPDK application using meson as a
 build system is shown below:
 
 .. code-block:: python
-- 
2.51.0

