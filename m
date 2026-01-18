Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FCEC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F04DE40E3A;
	Sun, 18 Jan 2026 20:13:50 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 9776640E3A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:48 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b8765b80a52so589231366b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763628;
 x=1769368428; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvMssISqIq5HGciqPwtMlHw1gJ81rr2wH/v9bHS3mvI=;
 b=oH9McXHnEpAddhy4UADpuMZbyjvnDdpWtE85X4sSpJIAzDsD1tR82Wc6G7S82G8Um3
 /doPwFjLdWB8T5prgNTNoGuNIkmteBmGo109aztKaxnE/CMJ8cVFXryeqOcDgMm3bmsD
 YIHhJ7QKRyDsBozaz8KQMPdHk5ZQ3hugvt2wAtH93YgI+BXlJFAKpR0SrPmUn6KMpVW/
 ss/UtXiieevxIyF5Oa/IaFpA6EvxzQOLtM/9F/80pJCq7ay5JwXxOXOZzKoHQjNty1gW
 UpP7BQskl7abYg7c6A0F0XCJy3OwvnX1IDXpDzb1ycQg1XrSMytYxiz3BRlgl5rnWS4I
 9ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763628; x=1769368428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvMssISqIq5HGciqPwtMlHw1gJ81rr2wH/v9bHS3mvI=;
 b=B0uWHJRmF8cD13iEATXwn56cpEvhcytsw/bELcEd/vhI/UlTw49e7nPjG575zDo6nB
 9ryWlvkJ9HolSh8Jz2C3LSOcam4oeTMdKeAkVjXVbAbZVKrNhqMl9xQ2FIKfm6uOaYwz
 BtpyCFsZuxzILTx0z+lrNLTQiC8Ri553Xk0Q+aYKuGy8xS8RxJmFMGIbBJFB2K98t0/o
 QoFzTqt9YmbPsSzng5fgQ2GDfS9+36CvJZc7LgZoqkxZ6CppudqMsGp90jcwWa9Lj8KT
 K+le2ypdyKlWu0c4l75pnsc5RrpEsecBNkNy3A/8bYiW8Z90e2YYcEUG9Y3fj6aIbnAj
 yzxA==
X-Gm-Message-State: AOJu0Ywx6ggIt0SeAFz7ntp7ahun3X5H/LFtKgGoB+Gvr6QYa8Xsl3Z1
 2PDrnWIY0e43An9XTFQHhwM9r1xnMpQ2t2zwP2cFBbL8nX2s/5QzWvl0P5daU5iJ/aqFwsg05DW
 yxC7M
X-Gm-Gg: AY/fxX4/ZoraruZXWi0bpYGQtwrBLQOgEMREQvBSOB/ADvISG3i6+Pwg2BLI06c1GL/
 5DU6dhWrDBc3frejFXOHeIAGktZnyYaxGuUCInYaW6uQF7yM2evSZDgYdKJ3yN+e5GG6bYNZADu
 b/dzJBAGt/i6tRARmHY7wKsF1/IWi7Wn7gaAsmKOrU+ULBdRUhcNappZb0L7aEy5m0MYhy4o8hk
 1cwKhnc9VkoLBC2nWjsu4gR6bFrT1brTIGK4cUl33m3zCV+R+cS3EWQ/TzozKbsJ18stx8HLDP5
 J75YjZnjoIrNlD4R1arXhNwLU+/3E8XSKuEuf/d3IcEp1SgIMU/Q7zsULkg46bdV6LPzHy8OIvo
 pDrn5uj/qhOF5Y7GtmkglMDshyD6Qu28lOeChCMeiFtJAnw2zq87T55Toaith7n1VavAZmRXfdK
 P8V1LB1K/ZTncXZy7yOM+XeYL67wpf5y7DEkWck3rU2EEwkOq/7Q==
X-Received: by 2002:a17:907:7256:b0:b87:2eb8:2b78 with SMTP id
 a640c23a62f3a-b8792d5a73bmr844038566b.18.1768763628085; 
 Sun, 18 Jan 2026 11:13:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 12/54] doc: correct grammar and typos in meson build guide
Date: Sun, 18 Jan 2026 11:10:15 -0800
Message-ID: <20260118191323.241013-13-stephen@networkplumber.org>
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
- Remove extra space after "libdpdk.pc"
- Replace awkward "can be got" with clearer alternatives
- Change typo "are passed used" to "are passed using"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/build-sdk-meson.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/prog_guide/build-sdk-meson.rst b/doc/guides/prog_guide/build-sdk-meson.rst
index fdb5d484fa..84ad64494a 100644
--- a/doc/guides/prog_guide/build-sdk-meson.rst
+++ b/doc/guides/prog_guide/build-sdk-meson.rst
@@ -16,23 +16,23 @@ following set of commands::
 
 This will compile DPDK in the ``build`` subdirectory, and then install the
 resulting libraries, drivers and header files onto the system - generally
-in /usr/local. A package-config file, ``libdpdk.pc``,  for DPDK will also
+in /usr/local. A package-config file, ``libdpdk.pc``, for DPDK will also
 be installed to allow ease of compiling and linking with applications.
 
 After installation, to use DPDK, the necessary CFLAG and LDFLAG variables
-can be got from pkg-config::
+can be obtained from pkg-config::
 
 	pkg-config --cflags libdpdk
 	pkg-config --libs libdpdk
 
-More detail on each of these steps can be got from the following sections.
+More detail on each of these steps can be found in the following sections.
 
 
 Getting the Tools
 ------------------
 
 The ``meson`` tool is used to configure a DPDK build. On most Linux
-distributions this can be got using the local package management system,
+distributions this can be installed using the local package management system,
 e.g. ``dnf install meson`` or ``apt-get install meson``. If meson is not
 available as a suitable package, it can also be installed using the Python
 3 ``pip`` tool, e.g. ``pip3 install meson``. Version 0.57 or later of meson is
@@ -78,7 +78,7 @@ examples to build, are DPDK-specific. To have a list of all options
 available run ``meson configure`` in the build directory.
 
 Examples of adjusting the defaults when doing initial meson configuration.
-Project-specific options are passed used -Doption=value::
+Project-specific options are passed using -Doption=value::
 
 	# build with warnings as errors
 	meson setup --werror werrorbuild
-- 
2.51.0

