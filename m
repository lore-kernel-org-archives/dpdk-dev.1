Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4BDD19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B60F40E12;
	Tue, 27 Jan 2026 00:25:10 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 7C40C402DE
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:25:08 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so57876075e9.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469908;
 x=1770074708; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=3VXkIn/jhWNM7IyshbxVhhULMZqIfWl4GeKz8uNlW0IsqyAIQ62NcS1+H7sHTOYCzl
 +f5x2dy7Bh6N5SqiJvH6gnQXX15NluvbPapQbHzS36v4YfBb43tGIzBI93iff5Q5Pp2/
 QGY8QtVnCzWh64xxxZC3/Z+ETwODJZWfp359ZC8oj4b1COITYzAqJ4Omlk/fhsv9BYuf
 BafT86fcafTgoKEZqrn8dplgtx0E4ciwjf4dCfU7zkBVHvPmZ+6akT8JFgWRoJRsBgpE
 8XI8XGWqGvxwO2NbOXdBnr1PcUiSCGZzGpl63vFfpJpAObptvnU/U/vwrHZAMBTjRYr4
 xKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469908; x=1770074708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=Dg7crbUmvpClAhE1KNTvaI9w8bIJk/5monQAQXYnrZDGY6wBdtYC/xx988fR9cpTLI
 K1CWW4U31pgJdmPNuaibF/GTYxNFeK9SaX869Eca9smPlUJWG1wk3Hr/s9TAru0K/lFm
 2bh/f0KVjAA+LZl1rroHt0DSmIrCgXpX2j9PysNid/9XmJKonWn2fyjhJ22HoMaA7qkG
 aVC4LtZHe4/emxFl0e3WQ5w04+wJDADsRNivRDPQLm8HNaRvXUQ+5CjGYoWHI6mr/oKu
 TkmMfJ1D11JRsdhPSOQViW4DDAEkvik88eVHNl/q7GpjqMo95KnPEPp4ciTlktRPKEHm
 8eFw==
X-Gm-Message-State: AOJu0YxIzez9PurlAFu51IOUimuNKceBkd+lileeWB6MtdSOOz2b56yd
 Yn/htv0e8T7u5vFhqikFDrn63M7qRK9t9tKxvZua0kIGe2InGkT8dhzQsgoo8+KenEQt8qkRBcx
 IWj47
X-Gm-Gg: AZuq6aLWs/Ll0Jn0QKE7zl9GmtkzBaWpxd8v+Ejv+WCDiA61TTUiWfZ3mPjhQAPoRqZ
 Jh5r73i4IOr7cRIkeAWaGEJWscpGEHibpVxFwYdjqefjUCJJGLAYXIflyIPamAdwqax3mVVxOhu
 nDhl0xadVuOiGeIpg2ZEh5PEQgNN9AqfVHGWteGNM+LK5buKfypCbMywXd3BHfe+zk3N10Y5dcb
 mzNrwF+IuLX8RmU69mE2u8KzZ5uVZb+bl/bkpgkG92s1k6Tyii4nZncz0jtMJA+PwlAjekT3EYI
 kFJzl+Sl3q1AT3uLFkH4FZcbRfXu9tkKAtgFZZqRv0xBbWYCb/om4A9TctoPtWysuwFbzg2XXtY
 WYn49pYTqc4JsL0BsK6X4lSnYeiJX4bJLw+osWuHJ76GfI2iSiSd+Qs14gv/zxkfrNOmvfbr+wn
 UYmw5RtPkA7MADsy0teQ91xUWiTd/RliBRXHKHQ1bmmfS2O+cm6A==
X-Received: by 2002:a05:6000:2c01:b0:435:8aa0:a30c with SMTP id
 ffacd0b85a97d-435ca1aa81cmr8918620f8f.48.1769469908150; 
 Mon, 26 Jan 2026 15:25:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:25:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 17/17] lib: enable format overflow warnings
Date: Mon, 26 Jan 2026 15:22:25 -0800
Message-ID: <20260126232428.276534-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

