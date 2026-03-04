Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A05EDEC03
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 04:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C87C402B3;
	Wed,  4 Mar 2026 05:48:20 +0100 (CET)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id B70C040269
 for <dev@dpdk.org>; Wed,  4 Mar 2026 05:48:17 +0100 (CET)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-35980a994d6so17517388a91.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 20:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772599697; x=1773204497; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rP90+6HXLTgOJYb8Wbh9ebpugBPZL8vzsGmU5JZA5Yk=;
 b=d0mBZzSGpr2avDCOUZ9FO8kT4X1o+rHvCaGrnnG1llp4ldehFFP5WDiNJuGucpjGCM
 CYs1VeQkTrO/er/HywxkjR/AVW+v7OSwpttTdpBtZTS3CXl9qNQNJZldstxU8LlQJ6MT
 ZGpdUwEowz0mLQUByvHPno+FjrLW0tIhqniWvq06+6/tFafPxEsMKOIF2YqZ4v8IJs0q
 Nj/o920O8BFEXpyhnW0GsDmTKSiXX5hgRDwOtzil/nWF2qpNfUtJaXNV3Ruai3TaZX2D
 GIUni8Va/Q+tNTkmOk07f0HjgwMMGwd8I+WJ/4knvD0mZNXwg4jdlBtFZbBoGf3TwhPR
 u+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772599697; x=1773204497;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rP90+6HXLTgOJYb8Wbh9ebpugBPZL8vzsGmU5JZA5Yk=;
 b=d/CsOWZ9UJ2mB3ZTJBewTCuTmWbTPGIUYKVFEGuetizdgPqKGaW5wa5Vn1BCjVRtwC
 XYqFlcsZH4xFcMnPDIcuX88OBvVq73LyqKP3u0Tykr986GSnzVhmQvp3hD8U6uKrud4n
 +rcNxyMtiBQPErUt4fHWWYt0Qck6QyojKYNlFy2CX9lhCx2ahjXq7dmRNTmmW7FytSjK
 y+gKjF8OfBymETUezfyrac3md4LPLuyMxB9NYrSDVicOaiTS/j3+oTkmInFxC5Fogc2T
 4rg29qR9SpnoTTEF59e/CmOoibQE6PhZCiIwC5zA+dATN65liww7vVVUYN7WsIvHLzhE
 4NDw==
X-Gm-Message-State: AOJu0Ywk/+pUCAn3BG33ULE19vATWHgj5YtWCMtPGIUX10XkXyr1eHCI
 y9F+TC1EFYOsKalOnAaagsCchzzLMnLIfh0gsQ67mViXNIX2ig+aYtmy5SAFp2a1yrJGfQaje6I
 /xRQZRH9c68vZ6+qMwjDdR3Ag2g==
X-Received: from pgbca2.prod.google.com ([2002:a05:6a02:682:b0:c6d:cf76:29fd])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a44:b0:38b:dd94:936d with SMTP id
 adf61e73a8af0-3982df061f2mr766792637.21.1772599696732; 
 Tue, 03 Mar 2026 20:48:16 -0800 (PST)
Date: Wed,  4 Mar 2026 04:46:06 +0000
In-Reply-To: <20260304014624.1297874-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260304014624.1297874-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304044606.1339372-1-jtranoleary@google.com>
Subject: Re: [PATCH v3 0/4] net/gve: add flow steering support
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: jtranoleary@google.com
Cc: dev@dpdk.org, joshwash@google.com, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
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

Unfortunately some the changes related to rte_bitmap_scan made CI tests fail. Submitting a v4 with fixes.

