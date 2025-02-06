Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F1EC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 20:16:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7754D40EE2;
	Thu,  6 Feb 2025 21:16:11 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 222A4402BC
 for <dev@dpdk.org>; Thu,  6 Feb 2025 21:16:10 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2f83a8afcbbso2157472a91.1
 for <dev@dpdk.org>; Thu, 06 Feb 2025 12:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738872969; x=1739477769; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rKeuCcpwsOewoJRf9URxGh1AJqeZHYTIHzQAF/Y83EI=;
 b=RZ1fKPsYl9oVC/0ZYfcxqF9FXN7eb27Ch380pVwNy3k617AYt1c7IvDmc0im6Ip5D5
 1N/J69XxnSTcIesrtfisD69VVTDHZ8lu0TeNFlxlsZlUtBNLz9QEauVSmsfXDM30xh6Q
 jGiVQ1qAnN/fyql17WlMs5g5L3e8xot00HD2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872969; x=1739477769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rKeuCcpwsOewoJRf9URxGh1AJqeZHYTIHzQAF/Y83EI=;
 b=HQ7hsufqSbYKgvpiNDNI8kQZsu5CJiCVEPRkHZbLvNTKADdquk6ti+BvYsGmxyeXfE
 1UQuDQLtMK/s1vkZWrIUjJpFySfUpHODO8uCnDGSHn+8nAwDgpxMZSGdgxQ3dc770w+J
 554u3qcvjwyGCsdcpCHQYdEeyqxWaC1DgQXmjo1VaDduDPDybY9e/IDfZaogHAAh1Vhj
 xhoGd56HeGVIb8r6Lt2uy34fWnXj83vDLjfrjBjjPq4MrnZCO9hzS34PUMGRMZllMb9M
 eYp7RjBt26gvjWwAy3/mE/OQJqtPLcq/oYg8+6qr+qZhp71JnypWEiC6L+CtqaN+tyvD
 O02Q==
X-Gm-Message-State: AOJu0YyFu8vMc6/NryQXj0XM0M1C2ls9gEJtoU3V03re40JfEw1xtxvh
 UlNqq4a6WXPmZ2ELsilEgFbRjBhM6laeeOPE/mqaAk03vmh6F8iHuwfElp02JzpqyuX6TnEPzE4
 Pae40qlFwiMUaC6lCm9/VHPK62ioDvuu85Y/2gA==
X-Gm-Gg: ASbGncuC8dlNdq2Mt8iesl5+fwElVjNask0ZnTiZrxB7GllbvsVIrksliBNGUWBXXn+
 CiS9e24zkWhTl2LSLwu5IB1PU8g/e+tKWJZre8TFOgZIjhlZtt2u0B7ofNVcrbn11QB8xKpW+XA
 ANArHXyXg6JDRp9jFUveQ5Z3JRuDeijA==
X-Google-Smtp-Source: AGHT+IF6lWBsfKx9oLNABOEV2401m0plHjtptgMBpAkrvErcS1jBzQwNGB97cwcY9QFQ66GATsuLmOKEe72iFJxFzwA=
X-Received: by 2002:a17:90b:48c1:b0:2ee:823e:39c4 with SMTP id
 98e67ed59e1d1-2fa24810d37mr457434a91.7.1738872969335; Thu, 06 Feb 2025
 12:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20250130172624.1450975-2-bruce.richardson@intel.com>
In-Reply-To: <20250130172624.1450975-2-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Feb 2025 15:13:00 -0500
X-Gm-Features: AWEUYZnFD7VuhS49CxWxhYPAHooj0bhSrsOoRG0P3zAIW-Yq7Bt9Oc6qQQsfpl4
Message-ID: <CAJvnSUCj=0RvhbGAc5MTa2QsD_e+vT0i+nFa5L4g1QDnoaq8xg@mail.gmail.com>
Subject: Re: [PATCH] dma/idxd: add device ids for new HW versions
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a5ad3f062d7ee971"
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

--000000000000a5ad3f062d7ee971
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

Triggering a retest due to testbed instability yesterday.

--000000000000a5ad3f062d7ee971
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: iol-intel-Performance<br><br>Triggering a retest due to testbed instability yesterday.</div>

--000000000000a5ad3f062d7ee971--
