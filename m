Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900F0C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:50:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3B8C40BA6;
	Fri, 20 Feb 2026 06:49:04 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0091240A84
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:58 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-5069df1d711so14788961cf.2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566538;
 x=1772171338; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=v03IRWRpR5HzC7OHnnFssYXpxtVIFC34myvJ2Yut6rBjlqEse2lhCTXBBBVuowkGkW
 vNi1gVuDn5cUGQSZYvpo793qJgHASPcGJAeoBCy500AlvJY60o/pPrK91bLsUCK5SFn6
 6TX+fB/H0cYbWWWuHfaJ/ep8ssTvIpkAL+nmytLRWD4D1ge2NBdMT9oUcZXgR1kTqoCg
 k83pPo7w50LFLwczinM0E2zIaUrHs+91lgdDt8q3JWamJb4XxUlj/g/MV8bNfOEfTg0e
 zFpjHbu2quY+nrda9682G4kZu0Vn8zxYpF9b/RBHZUJXqThIO8LbsGYXjvQ09qvY8cuA
 ioTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566538; x=1772171338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7IkUl/0NLxrFpIz53KeZT2r+t1cZtUzoYXS3/PCXg6I=;
 b=qHlXZZLLaencd2JgpyW1/1XZ4oz+Nvml6tLifgM+TqtOwmUI4ulXKp2+s8S51iIhCM
 ul95Pl4Lha1EvHzZjOvkAcA0rh0hXnhfD3FNbV9hV5BZkxwgQuJi47hNGFYpktsajgGh
 K4kFOHwlcdKbShKNIhGRjdHm+5dsdn1SsMOBZI8k9OMK8Db+UfI1F5sgvw33LDM91g3q
 neqvfQwGPd1OdAoi7W1eZ0DTZ/rxmOfSfZECeysYjgWn84D2UmRFYmNh/pFDaeZBlxZt
 kb7JU3qoq5S+g6hzZ/siMUHOax589GTfsfB4k1mm8Q02A8MFM5qXcGyqR4iPLCHc8SMV
 iFAw==
X-Gm-Message-State: AOJu0Yx+0EaxjoFnHFoFye/6tTyNRUvLR/qLt3/F6oswXQXol5si4VwA
 VJK8OlU1xhVQSSVuooCL2v/XTaMGnGTVzHJfVx0Lg1oOe0I77mhUZ5VWnrqLLTJxYWATOAKzfht
 hIplD
X-Gm-Gg: AZuq6aJSDTRxhtwd5J8k6HUTlXjmldA6Mpa76Tk0hszcBX/xad/yyBHvzMLhtFeYgke
 zAMepMx0Boi8mgzX2Uk+qn4AOs1osmyD7W+UPJc2YnaNgvS+o7KTmXd+M1gWn8GpSDSrQgqyyr5
 APIlE2gVn9b3K1oSK+1HMdSW7H5CReiM6jpO1BPY6CTk43d6i8UBvtjlw22WYSOv9Do3wQg3k6h
 H8XUHeIacT6fTnzpgtRX+Whmu18Qr4e53gFSEoiP0WsJcqFyPaXT6yxTDkmb0/J3EfV6OKuKJ3M
 FIs71/X1GgZbs95UXhlxM8tVbg+/nR5DD/niWM7x2DHESWuzVycJIrLjyCYDX9nQtzLuGPEbsKC
 h4IjOOZBZ7EVFmtaERflO3rbd0XRl8ipcI9nn74KWGtqoLoNTuZGTSxbbnmv2/BdCg84F0qwEzi
 OVCgXzStORWTyR+Y7GZ/DpOljTOlwINaFPpSKE69AvfcUGDc3UPtzES8GVt/W7TA==
X-Received: by 2002:a05:622a:151:b0:501:1794:f9e7 with SMTP id
 d75a77b69052e-50702525cacmr4815941cf.31.1771566538378; 
 Thu, 19 Feb 2026 21:48:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: [PATCH v17 19/23] eal/windows: add wrapper for access function
Date: Thu, 19 Feb 2026 21:45:54 -0800
Message-ID: <20260220054834.1632201-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

Like other Posix functions in unistd.h add wrapper
using the Windows equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/windows/include/rte_os_shim.h | 1 +
 lib/eal/windows/include/unistd.h      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index f16b2230c8..44664a5062 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -33,6 +33,7 @@
 #define unlink(path) _unlink(path)
 #define fileno(f) _fileno(f)
 #define isatty(fd) _isatty(fd)
+#define access(path, mode) _access(path, mode)
 
 #define IPVERSION	4
 
diff --git a/lib/eal/windows/include/unistd.h b/lib/eal/windows/include/unistd.h
index 78150c6480..f95888f4e1 100644
--- a/lib/eal/windows/include/unistd.h
+++ b/lib/eal/windows/include/unistd.h
@@ -23,4 +23,11 @@
 #define STDERR_FILENO _fileno(stderr)
 #endif
 
+/* Mode values for the _access() function.  */
+#ifndef F_OK
+#define	F_OK		0	/* test for existence of file */
+#define	W_OK		0x02	/* test for write permission */
+#define	R_OK		0x04	/* test for read permission */
+#endif
+
 #endif /* _UNISTD_H_ */
-- 
2.51.0

