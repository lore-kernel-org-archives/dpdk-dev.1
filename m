Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7845BC982FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 20:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E81CC42E9A;
	Fri, 16 Jan 2026 21:17:56 +0100 (CET)
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65]) by mails.dpdk.org (Postfix) with ESMTP id AAF5142EA3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 21:17:52 +0100 (CET)
Received: by mail-ej1-f65.google.com with SMTP id
 a640c23a62f3a-b876bf5277dso512762466b.0
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768594672;
 x=1769199472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4JEKXsJnsuvF4wlCgf6UWFFm7emZn6xqs58faKAvqI=;
 b=PCtHCAdhehLv/ySpvAu4xOXUZ3W7O81KD1neAUAT275YbGzMQeMLUqikKzQK0jeoV9
 uYzfmdirWsXgj0rcnhzsSnCJI7xw4tihdDw6R4gIx7oUMoZoZ50ykkMchHplD1YI2FDk
 +SpdY0bs7sKQOsWigQ1Q8ssc+fBh7Hq0FW/1keH2xAh/Z06KJtsyGHfnW8NpbdYuab2g
 8rucqoDR/z63kUw/QblHuhFcKVrh6Kaux9bk5pWNPMRKbNUVco7z5N/K/W2tM4pWYodR
 3DA4JVu0h0WhVotFiwmS8diGFl47rLYsoriiXHpVAiQWVe0s+Xq/sRb+igYF54FavVmL
 ieDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768594672; x=1769199472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V4JEKXsJnsuvF4wlCgf6UWFFm7emZn6xqs58faKAvqI=;
 b=AJE0bDa64aveK2MT9x7U4iBgYGAYFDzVYx6gDJZ42qQdHYDT6NqHAtv6701piWRUWR
 Mh7w5F6htLvk+o2iUt69IM/9NJagdCexwyecaYg+zD0bhpPUabPIKqb/5z8Ue1fYsXgo
 /b8jIgbPue/iktRK6dXUp4g5vBEtYw+NYUfSbi5C88Ymkc4ZKC4cLoskOZYLR+FGW0sR
 G/ldV4z8857DsC6z0r6s1jpAIk1TtRfFFdoBzVUwjG7N9ltoTH8Nt8+j+A2UehAKO43F
 wOoUAFk0NrNrWt8EMTTCw0slh5dy+VnZMLR9Ju0FUZTzoaDoYNZwFBDoSkc3b73tjypH
 dsEA==
X-Gm-Message-State: AOJu0YxcDfXcYiNyZNXg4VjGt5JwYIJ1s9DNh1ndsfxNnya0bsI63qcC
 AEvlNhu3NzGx4REdS9yy4RGkRvGRfQ3xm6Z8cIAGInD0T/x1yK7KxCo48Ouiz/5prVvb5ZOTJ70
 /WTquQZQ=
X-Gm-Gg: AY/fxX56sURGgymVxECoe2FG8m2WV81PcHkQIrwSSE2BG1BIDdAHSFSD1VDVLkBUvDp
 h2ZD7zLKBVq1v0Tj0hEhfirTIevGc2xUNpG7AWx7RaTlTxKpP6w5Ah/YTyNBKcVESQr7CIWM5f4
 KWVuJypu+vl8/6okkMjry9uojTEX87ZIbflwZFYL609meczjlvaWl9bVswe3CWzmjYBrj1YENWZ
 SqRyztT7pBQodvI+gbZNAOD/DnJmk42ZY/HzB8UxTGmSkXryVUY2UZFksHMR9QC7y4yNir2sNgq
 obeNR93G9wCePP8lvW/i3kZWfljjxlDal2GSEPuQukfXL49h7x0EtaYtYRuseRfT/QzN+fkQbKF
 Yy/nAoVLnCuKlqmZjzzqqNgmCU9MqLlF+wdPSLeBIsiZgqSlmf5eFnF4+454dznTmEMPNzUula0
 3Q7sXN5xrxePitQKPLdQos2q05Fu7hMwfx8B+hEWlYxDqGwAEO6sVB9vb13geN
X-Received: by 2002:a17:907:8692:b0:b87:1b2b:3310 with SMTP id
 a640c23a62f3a-b879388d786mr345047466b.9.1768594672056; 
 Fri, 16 Jan 2026 12:17:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795169f10sm338631466b.26.2026.01.16.12.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 12:17:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 05/12] doc: improve Linux uAPI header documentation
Date: Fri, 16 Jan 2026 12:14:23 -0800
Message-ID: <20260116201738.74578-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116201738.74578-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
 <20260116201738.74578-1-stephen@networkplumber.org>
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

Improve clarity of the Linux uAPI header documentation
- Converting passive voice to active voice
- Simplifying sentence structure
- Making instructions more direct
- Removing redundant wording

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/linux_uapi.rst | 40 ++++++++++++--------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/doc/guides/contributing/linux_uapi.rst b/doc/guides/contributing/linux_uapi.rst
index a1bc0ba604..b28ebc4663 100644
--- a/doc/guides/contributing/linux_uapi.rst
+++ b/doc/guides/contributing/linux_uapi.rst
@@ -7,36 +7,34 @@ Linux uAPI header files
 Rationale
 ---------
 
-The system a DPDK library or driver is built on is not necessarily running the
-same Kernel version than the system that will run it.
-Importing Linux Kernel uAPI headers enable to build features that are not
-supported yet by the build system.
+The build system may run a different kernel version than the deployment target.
+To support features unavailable in the build system's kernel, import Linux kernel uAPI headers.
 
-For example, the build system runs upstream Kernel v5.19 and we would like to
-build a VDUSE application that will use VDUSE_IOTLB_GET_INFO ioctl() introduced
-in Linux Kernel v6.0.
+For example, if the build system runs upstream Kernel v5.19, but you need to build a VDUSE application
+that uses the VDUSE_IOTLB_GET_INFO ioctl introduced in Kernel v6.0, importing the relevant uAPI headers enables this.
+
+The Linux kernel's syscall license exception permits the inclusion of unmodified uAPI header files in such cases.
 
 `Linux Kernel licence exception regarding syscalls
 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/LICENSES/exceptions/Linux-syscall-note>`_
-enable importing unmodified Linux Kernel uAPI header files.
+enables importing unmodified Linux Kernel uAPI header files.
 
 Importing or updating an uAPI header file
 -----------------------------------------
 
-In order to ensure the imported uAPI headers are both unmodified and from a
-released version of the linux Kernel, a helper script is made available and
-MUST be used.
+To ensure that imported uAPI headers are unmodified and sourced from an official Linux
+kernel release, a helper script is provided and must be used.
 Below is an example to import ``linux/vduse.h`` file from Linux ``v6.10``:
 
 .. code-block:: console
 
    devtools/linux-uapi.sh -i linux/vduse.h -u v6.10
 
-Once imported, the header files should be committed without any other change.
-Note that all the imported headers will be updated to the requested version.
+Once imported, commit header files without any modifications. Note that all imported
+headers are updated to match the specified kernel version.
 
-Updating imported headers to a newer released version should only be done on
-a need basis, it can be achieved using the same script:
+Perform updates to a newer released version only when necessary, using
+the same helper script.
 
 .. code-block:: console
 
@@ -44,8 +42,8 @@ a need basis, it can be achieved using the same script:
 
 The commit message should reflect why updating the headers is necessary.
 
-Once committed, user can check headers are valid by using the same Linux
-uAPI script using the check option:
+Once committed, check that headers are valid using the same Linux
+uAPI script with the check option:
 
 .. code-block:: console
 
@@ -60,13 +58,13 @@ Note that all the linux-uapi.sh script options can be combined. For example:
 Header inclusion into library or driver
 ---------------------------------------
 
-The library or driver willing to make use of imported uAPI headers needs to
-explicitly include the header file with ``uapi/`` prefix in C files.
+Libraries or drivers that rely on imported uAPI headers must explicitly include
+the relevant header using the ``uapi/`` prefix in their C source files.
 
 This inclusion must be done before any header external to DPDK is included,
-to prevent inclusion of this system uAPI header in any of those external headers.
+to prevent inclusion of the system uAPI header in any of those external headers.
 
-For example to include VDUSE uAPI:
+For example, to include VDUSE uAPI:
 
 .. code-block:: c
 
-- 
2.51.0

