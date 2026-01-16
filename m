Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82DFC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B81942EC9;
	Fri, 16 Jan 2026 22:17:15 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 88DD742EC6
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:13 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b86f81d8051so416452966b.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598233;
 x=1769203033; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6rWJ5HnkX1dXcdtwLUbxuQOrkOnb9SbLINhdSmTa1c=;
 b=JA2cLuu4rqlV1pZMe5OeyLPGojH02EtQFvXwA92XmOYj28O16A0j3CZXrf4U2o6zXX
 ijBJMasti/muR3Y41/ObQP297S0Z1UusCPDD5Ni1BamAy6Xf1FFHgwpuEDD/a9olkKI6
 VFLDsHHJu55+tAPCSCxeACfWD6i6IO37CL/vazU/xmhrG113CMRH0espS8lirkF41taG
 mVZA3RNhe1aBJIMZ7LsyP343aT1tgzURp9/+4XiNL7urwIKAsyjcIAPDgos+xYmgimo3
 QkvU93pYq5X64a8k894JnfnKDAd6mqrcMbf9YuKNkgKz6mIctVqSp+YO6qZ6pa+r0Upu
 3FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598233; x=1769203033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W6rWJ5HnkX1dXcdtwLUbxuQOrkOnb9SbLINhdSmTa1c=;
 b=p7f/+QpGhKSXgHgfRPnb4F/pctwMpQwW3N7T9SOKJx1Iy+JS+phSHe3phQZiOwu141
 H0y2iMT1ruTGal4mH6K99Bc20z4cAtE/o9VthNZmapYDYnjJnw+ChhZOs14Uxfk3ShfP
 u0L0s3T5u2Faf8fmag9Aln/gr8DrWvwQG10Qyqm+ef777O7kysIFHIqdPJSEvU1+zvaJ
 WJqGiaS1BFozMoxS9YWp34X5aX/bV0GvGRp/1Nm9vQ1F9XBmovLFMZxUxWtrZ7r2JrbN
 7nZ324Ef+7LPHZRvvpEXE6/1a9jRdp7oaxcCgnNWY50ToRo918UfOvxK3ozfgGNnkQYH
 cWmQ==
X-Gm-Message-State: AOJu0Yxp/Mg/gbZJRczrvuN5Zuf6WVM2stvs/42qmJ5Hwe0mM+DRo/c1
 qtidXt1fZXJyilC/oAvMRl4JrUApk7of7h5JbHrOuaa+hqBWqNcAaRdWGNX940PBcaKXP0lVtJ/
 ScifY
X-Gm-Gg: AY/fxX7nPkSdAxC5AX2fvssVu0riwxY1EkNlrynVv2dMqj3MLFb+M8B9370jGmBkBbB
 tErLJGgiBxGfl+uTU6/0ULl7R7iNION0KG1q+nRkkwQSgEhTtAKVf7idpT8TQvUFubfG078uHiG
 DJ8TxPl4hi+Y2LB3NeVRsF7ILq3+7obXgmZryOTgD0cP6yRsAAa6y0EjiMK2aWnZcl5rlczLZcs
 poI8R+zHL9azOxzNfsgxsHpVwe7vTMjnCbYxa/jAhtdxRG1AWVX5Q6Rl375ZSlYP2IN/1xhHs3C
 lgOKtX9lVl760MBdYCBtrOUueDtaQBTorgwNe12ZXWUoL2Vv/w9gsBiUiFzTR6thc1fIalbV7aO
 cmDhJU3OebvFqssw/bU+BDTHxtSut8Cznrom714kDnyJloqV41exObN7i9YIL58xzXtCtkeUrJG
 o+BZhMzFB75XdxNF6w6oUoZao7HQEFxloGUFKlKgTQsks4JQEyfg==
X-Received: by 2002:a17:907:3e9e:b0:b87:763b:3da6 with SMTP id
 a640c23a62f3a-b8793a1eef5mr368770166b.23.1768598233125; 
 Fri, 16 Jan 2026 13:17:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 09/11] doc: correct grammar and formatting in EAL arguments
Date: Fri, 16 Jan 2026 13:06:25 -0800
Message-ID: <20260116211649.104776-10-stephen@networkplumber.org>
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

Lowercase "Within" mid-sentence.
Use consistent directive case ".. note::" instead of ".. Note::".
Change "in to" to "into" (one word).
Add missing "be" in "will be created".
Use consistent bullet point spacing.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/eal_args.include.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux_gsg/eal_args.include.rst
index 4a3c4d9b5f..a0c17da9b9 100644
--- a/doc/guides/linux_gsg/eal_args.include.rst
+++ b/doc/guides/linux_gsg/eal_args.include.rst
@@ -17,7 +17,7 @@ Lcore-related options
 
        <lcores[@cpus]>[<,lcores[@cpus]>...]
 
-    Lcore and CPU lists are grouped by ``(`` and ``)`` Within the group.
+    Lcore and CPU lists are grouped by ``(`` and ``)`` within the group.
     The ``-`` character is used as a range separator and ``,`` is used as a
     single number separator.
     The grouping ``()`` can be omitted for single element group.
@@ -106,14 +106,14 @@ Device-related options
     Skip probing a PCI device to prevent EAL from using it.
     Multiple -b options are allowed.
 
-.. Note::
+.. note::
     Block list cannot be used with the allow list ``-a`` option.
 
 *   ``-a, --allow <[domain:]bus:devid.func>``
 
-    Add a PCI device in to the list of devices to probe.
+    Add a PCI device into the list of devices to probe.
 
-.. Note::
+.. note::
     Allow list cannot be used with the block list ``-b`` option.
 
 *   ``--vdev <device arguments>``
@@ -223,7 +223,7 @@ Debugging options
 
         --trace-dir=/tmp
 
-    By default, trace output will created at ``home`` directory and parameter
+    By default, trace output will be created at the ``home`` directory and parameter
     must be specified once only.
 
 *   ``--trace-bufsz=<val>``
@@ -266,15 +266,15 @@ Other options
 
     Pool ops name for mbuf to use.
 
-*    ``--telemetry``:
+*   ``--telemetry``:
 
     Enable telemetry (enabled by default).
 
-*    ``--no-telemetry``:
+*   ``--no-telemetry``:
 
     Disable telemetry.
 
-*    ``--force-max-simd-bitwidth=<val>``:
+*   ``--force-max-simd-bitwidth=<val>``:
 
     Specify the maximum SIMD bitwidth size to handle. This limits which vector paths,
     if any, are taken, as any paths taken must use a bitwidth below the max bitwidth limit.
-- 
2.51.0

