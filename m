Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39724D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30D2142799;
	Wed, 14 Jan 2026 23:56:09 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id B6443410F2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:06 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso2817095e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431366;
 x=1769036166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CNhL0HurC6dvjc2hb1oRxQCOcv2n26+PiXolU8Fvew=;
 b=cAQdfMO/txsauWy/vDbJcSAt/aeo82pLpVTnRU2a16iMMpfQU8bRdfJh8j7pZ7sL0z
 +ZvDaUs2T3RJeLsS6F18nBw/QVvZLXXOmZO9k6XyXqOYH9VeeTkzuoWIsgWJssaFNdpo
 Gq7XFTtL47HoJ5IFq+jWPU6ZMndaa+xTMzKlo+M11eXCeK7zdVpAWdDjLPshTih7quJU
 XfI3OUsxsEB8t2msEIBz8ud4CpVwOE+IPga7UJKizBWUzlHXVHnUTz6zkD1I39XYeJ5j
 ewwMOV0oGeIPKuzJ5qgJkHbMHue/s29tYoQuBlwSoxfxmGMSugMjQ74UAtj4bh+k+oFq
 SzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431366; x=1769036166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4CNhL0HurC6dvjc2hb1oRxQCOcv2n26+PiXolU8Fvew=;
 b=ShP9k1k5wMSNkU5Oha8Wb51nEDiejYCRl1uULtktQUwsyvmlyHWFPQLOgD3pHn4SNX
 AR5eH8n2AcmaS7EL7z0Aq8KVC+w0faahDtaLA1rGvVBu6hgpjSyD+eUyO0jwQz/1JYwQ
 CHCtD5alO+GVxvY6vq6P1dtdPv8eo/cgmga0I+bR+OxPfgBY76Vcm8K/cJzkvL7bfpgZ
 mT0VXLMXep0poD8V4I80AwvrI13BvAW4LyInewZOsfC7Mme1hiEURUbYQsXQkYABciTN
 BjoilsHCT/JhTlX0nDDSvzrjZj9TlRvTjkVCLkS1xwAKvwsEIjBmbdwOi+eCmTUHc/h5
 C6dA==
X-Gm-Message-State: AOJu0Yyh+r73fSN2TOpQ/m+4SVaT/V3lifRLqlqy4DgTQoL3ekRSQqRY
 rCo5HZYXdwTcn8bCLYdrPrYVjsc5GP0lEVQxW7X7xFJhWm0oKmvSfxjLDknoUAsAVA2lbyB8as6
 WFPifsWw=
X-Gm-Gg: AY/fxX7TbRXxZSQ5zfAHow6IfokQ1Mu3/s4l8AR1j6FD3GphktwqWZW+utykxwoz1g6
 n9hdNq28R9DHRxnqYFkH5pq/0a7MVOp4x92gzT/0UMBB74oiitCKhQOI1xzFK/tNvrTg3gz9w/V
 ZqbY0K0y9LGpVY8Zi0tN/YUIGgJpbp1a65vsCSRC+zWZa05anYaUteRk+m7rst0x2EzuQd2HgTu
 H99ioEiKNbNZy8waduzn9tX1gIi7fvPNQEIjQ/haypJYyGmzH11a7qzQMHUmHMpQDOO8WyPlKLQ
 i86JH1Qsb9irr/+TA+l4P5q6tnLEdM/it44aJs3/55KrCSNqoIScJ3ZzgBuEH5fqBPVRSCEJZ1r
 hdOrDcIlMpxjL+FN/1CzmxRzV4SI8ST/OYDatp5RHrSqF0dXJxgCmvULD/ZjBOoPfjw/O21c7lE
 ydZDcmQ2YXdVGTQ2MJ6Ly9yzbK/5M0c/e8n/dFeTgt8FIR4AHHKRP6zxuJRM8S
X-Received: by 2002:a05:600c:4e4e:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-47ee47bbcebmr38383025e9.2.1768431366330; 
 Wed, 14 Jan 2026 14:56:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 04/11] doc: improve documentation guidelines style
Date: Wed, 14 Jan 2026 14:54:08 -0800
Message-ID: <20260114225555.127448-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
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

Improve readability of the documentation guidelines
- Using active voice throughout
- Converting "should be" constructions to imperative mood
- Fixing minor grammar issues in Doxygen guidance

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/documentation.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index 338254cf30..c6009cbc12 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -39,7 +39,7 @@ The main directories that contain files related to documentation are shown below
        |-- ...
 
 
-The API documentation is built from `Doxygen <http://www.doxygen.nl>`_ comments in the header files.
+Doxygen comments in header files generate the API documentation. These are built from `Doxygen <http://www.doxygen.nl>`_ comments in the header files.
 These files are mainly in the ``lib/*`` directories although some of the Poll Mode Drivers in ``drivers/net``
 are also documented with Doxygen.
 
@@ -84,7 +84,7 @@ added to by the developer.
   The API documentation explains how to use the public DPDK functions.
   The `API index page <https://doc.dpdk.org/api/>`_ shows the generated API documentation with related groups of functions.
 
-  The API documentation should be updated via Doxygen comments when new functions are added.
+  Update API documentation via Doxygen comments when adding new functions.
 
 * **Getting Started Guides**
 
@@ -606,7 +606,7 @@ The following are some guidelines for use of Doxygen in the DPDK API documentati
   It isn't necessary to explicitly name each file since the configuration matches all ``rte_*.h`` files in the directory.
 
 * Use proper capitalization and punctuation in the Doxygen comments since they will become sentences in the documentation.
-  This in particular applies to single line comments, which is the case the is most often forgotten.
+  This applies particularly to single-line comments, which developers most often forget.
 
 * Use ``@`` style Doxygen commands instead of ``\`` style commands.
 
-- 
2.51.0

