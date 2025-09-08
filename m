Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B2CA1016
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 07:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B00CB40264;
	Mon,  8 Sep 2025 09:04:47 +0200 (CEST)
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com
 [209.85.167.99]) by mails.dpdk.org (Postfix) with ESMTP id A1E2040264
 for <dev@dpdk.org>; Mon,  8 Sep 2025 09:04:42 +0200 (CEST)
Received: by mail-lf1-f99.google.com with SMTP id
 2adb3069b0e04-55f6507bd53so4230982e87.3
 for <dev@dpdk.org>; Mon, 08 Sep 2025 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1757315082; x=1757919882; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n70Ie4ymQB70BDng/k/l/99LdGND+8LCStHLPAGa/9w=;
 b=jCCTg0qQkkVJjzkc87Kxx6OjS8q5ykD1FoxJf2uElksn+rJNKwbbbH6pNwdmCuPT2T
 KDciALtozwpKPoDjK54wFBMQpSOitLCu2zLol5sx3yu3tosaC+FE87Eu+Czqn8/4eZ7h
 lfoXTMA9zQubhZwXg9KvScblm/Hy2cyBmv2hkKTNDtKbNBkLqXPZMe2Z64G05Dh77B8d
 eA8/Jnqnkd4h0ORawoUYCfCsyBfkuPYlLPnvlYCb8qELb4azMdv+KIQ5uAQpRWIlyl6/
 yvvGxlXUCtlOPg0/9KUv/H1DK6jSJZPog0/nngv2IwNSMLuC7Mgzd2M58ZrZhZeFOazZ
 qrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757315082; x=1757919882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n70Ie4ymQB70BDng/k/l/99LdGND+8LCStHLPAGa/9w=;
 b=tk1KChdvN6vMfP5jKSObmOfdB1ozIBZ1d6vCbrpczYjysR5yUh1nxeXchaPLA6yJfZ
 kA4AnfSK1ObXNqTmHcrk+XuTyeDKIug/iDLTdMuFk3YCbyvtjC6NohCcHPReDr8YzrUE
 fpnTEKnsGcxo6YrIXij8/DMLlL5NUNCZLmpXb4wspQ5eoL4p7up2sPzvQ6CfMxILMTNC
 lXK8/M4tRg3P/NCUsY2L8uLCE4JT19cpnWLRUdeZKVFCtHDTHNgf94Xq3lu+rid3dBS9
 ekQ42GRL9r3hM+f3Q8FUAdMMjNbMMN3qdm+L8yK0fu3+8PM+07Mypn17yGo5IrpYBced
 0JJA==
X-Gm-Message-State: AOJu0YzG508fLv4bOWSJ4z+zMlppk3VxGjEfSmyKKMVwlVCdpWXqvl7D
 64iEykUn5VQ9apwti++nDlqGrDYv3SdLFFI5/JxFU6zCka21CPNoZrrUuWAbmkAlMi0zM3Zo9lb
 jkPSdOl/I83g06PHX+nPJH+fY/8TLHEQ6YnlUBVvWSN0=
X-Gm-Gg: ASbGncuIxy1KSIGUw56MFTIU1YUWHimznf/zFO1dldKfB455puKeMGy+4b/ycjmKsEb
 F3I5nV+RPhIUtjQ/pbTqN7iZzmnD/wC59gV4WwJe/zZnJmu5RJ/PI7vj0RJwupCU1HVlArAt23w
 nYfjjv0uS0ZttDIZyM8BgE9AaqvpjSFB13EBjTyyTldpKNmpv97eyKZg/OZWeYyGcwU7XQ4Cu1T
 e3TCO6IUfubx22Izjmf0NwVmb4PFj0dK7vbzQaJAfnOAcQUkUH1B+5vVTC6vI9fxY3bPZtE9KeJ
 rN1L/sZFJAxqCPxLkx5ayqjiZPCWMyRVKQnvd2PcsQhms1KwaySBwm53FVhSO0Z7guTJSv5zARd
 FceiO0ftgLEaUz21fRwo=
X-Google-Smtp-Source: AGHT+IEFSc4ja0o43ZVsKcvU38o9Z8hdjmyzV1XZln/xXmQxvq2YXjT/zx/b5zZ5/qvNwYS8qncCYjEe6FiT
X-Received: by 2002:a05:6512:3b0c:b0:55f:63ef:b2bc with SMTP id
 2adb3069b0e04-562603a1050mr1893390e87.8.1757315081637; 
 Mon, 08 Sep 2025 00:04:41 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 2adb3069b0e04-5618ea86404sm2705455e87.36.2025.09.08.00.04.41; 
 Mon, 08 Sep 2025 00:04:41 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id E7EF23420D;
 Mon,  8 Sep 2025 09:04:40 +0200 (CEST)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Olivier Matz <olivier.matz@6wind.com>,
 Edwin Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: [V2] net/qede: reduce the optimization level for gcc > 11
Date: Mon,  8 Sep 2025 09:04:13 +0200
Message-Id: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250903113252.2496087-1-thierry.herbelot@6wind.com>
References: <20250903113252.2496087-1-thierry.herbelot@6wind.com>
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

The qede PMD stopped working under Ubuntu-24.04 (using gcc-13) when
compiled with -O3 (default level for all DPDK code). A bug is opened
for this issue (see Link). The same issue is also seen with gcc-12
and gcc-14.

A first workaround is to just disable all optimizations (-O0), which
restores packet Rx with Qlogic NICs. However, the performance impact
is not acceptable (around 50% drop).

A better compromise is to use -O1 for the qede PMD:
- there is some perf impact,
- but the PMD is working as expected (packets are correctly received).

When compiling with both -O2 and -O3 and gcc > 11, there is no packet
reception when using the qede PMD. The root cause could be missing
'volatile' keywords or missing memory barriers in the qede PMD code.

Link: https://bugs.dpdk.org/show_bug.cgi?id=1379
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
V2: be more precise when dropping optimization level (only for gcc > 11)
---
 drivers/net/qede/base/meson.build | 4 ++++
 drivers/net/qede/meson.build      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/qede/base/meson.build b/drivers/net/qede/base/meson.build
index a6dad3ec7bcc..130835cc31b1 100644
--- a/drivers/net/qede/base/meson.build
+++ b/drivers/net/qede/base/meson.build
@@ -55,3 +55,7 @@ foreach flag: error_cflags
         base_cflags += flag
     endif
 endforeach
+# no packet Rx with gcc > 11 with compiling with default -O3 or -O2
+if (cc.get_id() == 'gcc' and cc.version().version_compare('>11.0'))
+    base_cflags += '-O1'
+endif
diff --git a/drivers/net/qede/meson.build b/drivers/net/qede/meson.build
index e1b21d6ff5cd..e4268883ff93 100644
--- a/drivers/net/qede/meson.build
+++ b/drivers/net/qede/meson.build
@@ -22,3 +22,7 @@ sources = files(
 if cc.has_argument('-Wno-format-nonliteral')
     cflags += '-Wno-format-nonliteral'
 endif
+# no packet Rx with gcc > 11 with compiling with default -O3 or -O2
+if (cc.get_id() == 'gcc' and cc.version().version_compare('>11.0'))
+    cflags += '-O1'
+endif
-- 
2.39.2

