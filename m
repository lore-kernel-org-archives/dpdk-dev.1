Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1196BC9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB211427E8;
	Sun, 18 Jan 2026 20:14:24 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id D255740ED3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:21 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso7549167a12.1
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763661;
 x=1769368461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/6wFr2Sgc7uFJeNEdk6mf4ZdAva6iumyB9MC50+o2s=;
 b=IvXrjKAbNXCOwcZ5rTWk1cDZm/WdgfKUwIIvujVZaCICHGyOZKbniOk7Q4UmmCnNdd
 WTxa5pYIvphzrwhmsdF962rgarRp4HGjKDSrMakGAgL1jfrkVccbzfnuh4j3uauRh1E9
 hJglJxlxMm6SZC5BeC1VIA84b9KxySO6gAh7BuLxcsK8g7Pk8edUeLSA3iCw97YPDqOa
 picA7dLdiBjK3PU9R6wvaf4uPHMFnCWTmOSoeyR0y5rPUKDUdLzo1/IxkfuD7Qwo3Vpf
 A87qHr2Q4imkSAN2GV85G3gYcSp3rtw5iA2lLboTlpNoCqdRAtXgwt6SyLwALcEOgwx6
 iP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763661; x=1769368461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H/6wFr2Sgc7uFJeNEdk6mf4ZdAva6iumyB9MC50+o2s=;
 b=Y5lwaFMQAwHK+ga3t0dvnrsAM8M6SiNpmcLGMX9nHKiAoWMj/UN1S1F3MqA3oVy/e0
 hzKa6KAPgvZFP3JPIPvrsU5Tm3Dxnjb9Z/eyDDk7lMTn/qm9oj73bCYZIgCmWiflMzpl
 be/pD5V9q0oFnpICDncDi9/JNrHpyqffhJUvY7gt9gVaD4ojAe/UI98mtdJWbmcFPRcG
 1MRbvMhW2sdQBDT5P2LeIEUW2pXKnwReEq0iKj/2rYMDusE4tuBl8Ts2Z/vooWW0IqMe
 Ga3mtv7LGUiX69T5fNzITq+R+0xCcEBooVDvvofxhrCfWbAkBV633UYnQsNA2l7eKIi4
 pfDQ==
X-Gm-Message-State: AOJu0Yzol+sLG5SFV2shiNoKPdvcVn1SIOucLJ3N6guZBjOTnhfw80qm
 9Or4jMohcJ6pYYQTImRDa4d2GllTBnR+DOsl5uPMn99DhQ8GwXdPUzioFLx+DxbGhUWxGkeB4Oa
 YiKzq
X-Gm-Gg: AY/fxX56YmzNCPPJlLquH01smTLw1YLvvUkN57NJ2k/lZieg7W71ejVESRTtsPseLav
 BBz36FE5p2tszBnAgL4gT9o4o9YrdSfM5aRkrQGro0hPi+4+gLaGdBhpxhqj1PBcs3KQaRrkgR4
 OlZXAjdv+ThSDigRhZpjxjPLN/6byS8xFFJoD+VSsQr0sOUOFYogHA2lYHgob7Ok58GAhVP3cz/
 svUKluALXX3Btn6k9WPLJTPc8ij2K3yUpRYegZqCkDgr0TxAgBPkllsCF/TvhusvGZuSRJTRtm+
 UcMF8f55WMSd0jkj1BwidO6mnjldElDfdXU0AGtemqyicA0LdpG2m/7ved7v4jDzlzjWkemP2Oy
 vxKGxc+c0yL/aDVUsuL9ncUp2MuKQK4Arfy6HVS9G0mp9tnX2N+IC+zH023htUGIpDk/Z6/1BgH
 gJVPP0Wx4zzMbBH8HfK+x4lszcN+KyyzrwBwCzMwAwMQTLd0vC0Q==
X-Received: by 2002:a17:907:6e94:b0:b87:6f58:a847 with SMTP id
 a640c23a62f3a-b8796b7a3c2mr730411266b.45.1768763661405; 
 Sun, 18 Jan 2026 11:14:21 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 34/54] doc: correct style in meson unit tests guide
Date: Sun, 18 Jan 2026 11:10:37 -0800
Message-ID: <20260118191323.241013-35-stephen@networkplumber.org>
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

Correct style issues in the meson unit tests documentation:

- improve awkward passive construction for build steps reference
- normalize list punctuation by removing unnecessary periods

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/meson_ut.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/prog_guide/meson_ut.rst b/doc/guides/prog_guide/meson_ut.rst
index 9bc52a30fc..2740184cde 100644
--- a/doc/guides/prog_guide/meson_ut.rst
+++ b/doc/guides/prog_guide/meson_ut.rst
@@ -6,19 +6,19 @@ Running DPDK Unit Tests with Meson
 
 This section describes how to run test cases with the DPDK meson build system.
 
-Steps to build and install DPDK using meson can be referred
-in :doc:`build-sdk-meson`
+For steps to build and install DPDK using meson, refer to
+:doc:`build-sdk-meson`.
 
 Grouping of test cases
 ----------------------
 
 Test cases have been classified into four different groups.
 
-* Fast tests.
-* Performance tests.
-* Driver tests.
+* Fast tests
+* Performance tests
+* Driver tests
 * Tests which produce lists of objects as output, and therefore that need
-  manual checking.
+  manual checking
 
 These tests can be run using the argument to ``meson test`` as
 ``--suite project_name:label``.
-- 
2.51.0

