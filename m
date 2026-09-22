Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D7C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AEDA42E65;
	Tue, 22 Sep 2026 21:41:46 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 2BB17402DE
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:43 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1ceb47d53so98472a12.0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790106102;
 x=1790710902; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j2EFhFJpuzStMQnWFUSZcd4CmEGUoML6P3dxUMRlUeE=;
 b=UM+bBp8OKZl4P8eOAjCHx9KWb2w2/Adb2+03BtKA1CFICp0PUg0mSWkIsy4e4HxqEp
 CTMQVaqxZgWEtl2xbXhKvRn95jf1oUc/mHOtE84PhHyHCTK7rSGEzECZtUUF8szVxQTt
 rlHEYj6dTsjZ49D8vMSq09I9mgFy2JXM5Uv0YMAfJSLTVrKPFzXvfl3ftq6qrtL3XXRz
 xgRsoYo8yXI/nGeBIno3cqvxe1DHbwpSf6AIo4CALjp407jx2d17tKwMe6MDjwDVnlm/
 LhZZ4lsJ3tVKDMqOYaVPKcaSyPXNLZjTPgRCZbNaloKvdFtlV3V8dgideAdVB+3msP/Z
 IXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790106102; x=1790710902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j2EFhFJpuzStMQnWFUSZcd4CmEGUoML6P3dxUMRlUeE=;
 b=sI1NKjRxBZ6xfERmLfjj9uSJ6pNWnRYngWhYS0YOkyQ4JaYwC6v5FzLbuhILftG1Rr
 BT1QnJK2EcDCi868avUPZ1oIpvXMHN8FRL85x66x4l3wb4021BCPH94vJQOpOpRxXcbF
 5v0OcuQQK1FdsNGYcDJdibIfrDDLHLkehQUtHO6iH59++BAxD2/2Iruu3CfjzjJXROmN
 gimgkH/EY9he4MdGpNnmZdcEek81NsV+eI7lr6iWsVydde1cEP2Z4SZo7TkHrDoScW76
 rrewRBSFodR522wESDo71mq4FJ0BS+FKKNvBMIieuud3v/sxLj0JJdjkqe3Em9toGASa
 Owjw==
X-Gm-Message-State: AFuF++k0p+6YsyVzOHct+VwXcaTJV2tCAs8aMkaeLQmKoNhptAhOpY58
 YBRWBJPdj6zy2SvuzlZJ2sfyPsI58DYjn177b3/bMj4vb9Gt8lrvEhshzl2atJaPQHD2w0+uV63
 dk8REfWQ=
X-Gm-Gg: AYBFou0Mxxj0MzS+l7bc1N/KzcSLTzT0EV8BjFNlCT01EmgAZ1w4f+LG1MoFHB5pNc2
 d9soNMoOBjwZlNxURdmBro/3GWriA5RYfUAxWMR8VXsHSWUgv/uZz5JmJK90XuR9tYuzL025Vy3
 /xOCi/hrOToptjtTmZMK1QfK8nFx1zuqhZwQNto3Nnw+IvNOZS8ryVORCZg6rQkLczSnVUhq1B6
 1DOwdJgLlNYJ7CcJHxM2bcz4UwmpmdJEE+P7SiE7YWMyLcFIqm9Mge6rsbF/pBTOScWqBFrHuKg
 LEZsus42+bdBaiZoagpA+vxkCwAnYl9aEBoANsGO/Kvcf/ZJpjWiHbmBeq31GMWdcMN8E9PsEsY
 /GjIeobOioXk59oGFrI0J91XgOHLkxTBTMUssHJlipky28e8TEea77MrgyNxnfUx3648U754gdU
 z5gEAQcGB6yF9RIy7FNMHRJ4pAlnAaFsM9Ssc32QuunCLa+nuMy7nXyPRLm1MTg8Wm4fyAN1Az7
 MTtKntg8SlskoHYiTcvM/qIdmTrFOGP6bcKRyhqEKJQiGqN
X-Received: by 2002:a17:90b:1d48:b0:39e:6a7f:6187 with SMTP id
 98e67ed59e1d1-3a07e59574emr271232a91.24.1790106101994; 
 Tue, 22 Sep 2026 12:41:41 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf1cf3sm814881a91.9.2026.09.22.12.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:41:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 1/7] maintainers: update for memif driver
Date: Tue, 22 Sep 2026 12:40:52 -0700
Message-ID: <20260922194138.508919-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922194138.508919-1-stephen@networkplumber.org>
References: <20260922194138.508919-1-stephen@networkplumber.org>
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

Sriram has volunteered to be memif maintainer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c50c52933..56e20d993d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1160,6 +1160,7 @@ F: drivers/net/softnic/
 F: doc/guides/nics/softnic.rst
 
 Memif PMD
+M: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
 M: Jakub Grajciar <jgrajcia@cisco.com>
 F: drivers/net/memif/
 F: doc/guides/nics/memif.rst
-- 
2.53.0

