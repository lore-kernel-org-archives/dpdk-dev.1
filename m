Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C2D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:41:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C0B640664;
	Wed, 28 Jan 2026 19:41:40 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 9F5E140647
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:38 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so2489885e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625698;
 x=1770230498; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=N3NwIM+YEvpQdaXis9hL6URo2zPd14KAyF1UxldRPeKCfxNb/A0zs1gOfQvS0+PnsI
 WeYmHNl80WBVA0HbGF9uBhRerse5itgi+5Rme6qIU7yYopX7Bbh0Q+F8C7r/Q/l6Cn69
 gDCqjp6hR3mAlCmMujsGMf0RCWX76M+64vkxQ7jSyo61cT5iyNLnKQEBZHN4C0NOiUa3
 pmBln+E6BAszdVyHws85MZSBf4V6nWxrjPn/hFFKhKr5r9bVScM8D94Wd0uvOKnueFH4
 AtOnow9cQMeTZZ2v0yPu9nkZu64rbSTUsWxKts2bc3j2cCC9dkQgX8o4TD4ZtkCrwf06
 LegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625698; x=1770230498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc0SNxtM+QDH8mSJW5Fgu6sn+ZqCgG/hn6noA082iQ0=;
 b=OoiMM9WjSRcCKuGnr3jT+kY+YA2tdLSZtCKuDm35yiBikpxbaCWEUo5Up/9EKJK/99
 aeM9lg6dAS7wOtg0wxDS/Zz0XV0VvLiGMSp0UJu3NVMfyh2Vm8o5PIlQUKEXoDaVn22d
 Qp7gKX4qb62DmIri56XAvWne87hEQc6ojYAFDKe9JwjRCDdHNPAhnAXQSSF1hBMI86OA
 DopkOIn0Yyrs5ANKTJcuHjtHPeONw4CkloYqRgFfiSYkCfVyYGpzkTn9qe1c3HFYsox6
 Et2kYDoQy5HW28yi6q4OXnmXzVMg0tYft19jFZJBD7lYhkDlXd+yRJ5b5iswcSsLn06x
 hoFA==
X-Gm-Message-State: AOJu0YxenD4C5nkx4ml6IKn7yzMeaqRkoOtCe/Rx0BlSdAaRdW5ey3uD
 mNg+NKppDnDnrkl6mjO7JK0dPZnXM+2tLA+0ge0Anf6TmJzIY3BTpNCNBeilxnfG6TG5abNxMj0
 CW9G0
X-Gm-Gg: AZuq6aJvmjnj/iPCyaop78D5rLLcUy3bx1KILQCmRol86YXG29zSL9hlAWfqKyKIT4r
 t2wAcG3vJJpJLek/8iPDvqlr2j6BMseNE49VDsNzSITefCABVDGqxYZlg2mPiZVWXTl2YWSDGJi
 uy1ptKnoPpG+2HHOutLH8mXC0QH5tFNdx9whBIOJD3MszLqr4guvSaN+9LMSokLm+1mBqqXn1Lg
 vKzYFr6YvWTJXhdimcSyNLI9QeC/xUF5XVH+I4VZl11zAY7UeUVvTCb3YnURF8RFsxw8QNP2VG3
 QIGfYVAJwt50vC/DtNOi+Fj0f/2OCR3RixV/Zbf6JygROsSP+53lhVWoNQP5uVaa6OA90srVLN5
 BM7HkNEDk2e7UVdw/6WrDcsqYDtDJlcjhX6I2saibmsrjz9rDX6Mp9ubTJictKjak+PtBJagsEp
 KV84DsQOYe6owJr9iBaobFNfadfrYok51ObRZn6rE5mdkMfMlaJw==
X-Received: by 2002:a05:600d:d:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-480f27c7080mr1459415e9.25.1769625698224; 
 Wed, 28 Jan 2026 10:41:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 02/15] doc: update features for PCAP PMD
Date: Wed, 28 Jan 2026 10:40:31 -0800
Message-ID: <20260128184130.445567-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..b0dac3cca7 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Scattered Rx         = Y
+Timestamp offload    = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

