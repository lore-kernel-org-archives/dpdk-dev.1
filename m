Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA16C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2484140EDD;
	Tue,  4 Feb 2025 17:23:12 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id AA2C340615
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 80D07210D0CA; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80D07210D0CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686168;
 bh=qoVQi9cS5sgnREgnU+YagZgmpgnf/GB1Wpawy3/JFjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bY3tFchgJ++ZNSn7kYhEU1nj+CQmOh4e8ftSuBaeMrlkzkrK6r7LX6HgfkM0jIo3g
 M7Y3aVQrA2LzFhrNB4MmLm6bQw53WHBZIFY66qrNdAQjpAVP8OxEaR9k+CIO52L1y3
 FJJzonfr7uK7i/haxLGxlCHwM9QXIP/prEWu10+M=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v20 26/27] buildtools: add no_wvla_cflag to directories that
 are not VLA-free
Date: Tue,  4 Feb 2025 08:22:03 -0800
Message-Id: <1738686124-16173-27-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

The no_wvla_cflag is added to meson.build files in directories that
are not yet VLA-free.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/chkincs/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
index ed65105599..49dbc55254 100644
--- a/buildtools/chkincs/meson.build
+++ b/buildtools/chkincs/meson.build
@@ -12,6 +12,7 @@ gen_c_files = generator(gen_c_file_for_header,
         arguments: ['@INPUT@', '@OUTPUT@'])
 
 cflags = machine_args
+cflags += no_wvla_cflag
 
 sources = files('main.c')
 sources += gen_c_files.process(dpdk_chkinc_headers)
-- 
2.47.2.vfs.0.1

