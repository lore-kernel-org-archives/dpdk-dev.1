Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38950C02198
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 20:59:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D10AB40A7D;
	Tue,  4 Feb 2025 21:57:51 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C6C19402EE
 for <dev@dpdk.org>; Tue,  4 Feb 2025 21:57:23 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 3A98B210D0CF; Tue,  4 Feb 2025 12:57:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A98B210D0CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738702642;
 bh=qoVQi9cS5sgnREgnU+YagZgmpgnf/GB1Wpawy3/JFjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nM3sVSksenxkaVeqpsjIRZK3S/IHxjBBluC8zwIro53nvJW3oOT5fQ0hvZn4tf+qu
 wv8PDh6ti3T94jG9enN0roMyLAGQCKMiJYpnrE2NkRNYtmjir6vfObZyem2SG9gBrp
 cs+sjFNxTLUTuoZIKRSpMqqaYnGi6IdUWvRKvpos=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v21 26/27] buildtools: add no_wvla_cflag to directories that
 are not VLA-free
Date: Tue,  4 Feb 2025 12:57:17 -0800
Message-Id: <1738702638-22363-27-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738702638-22363-1-git-send-email-andremue@linux.microsoft.com>
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

