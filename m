Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98680CAC5B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 16:54:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C49CC40663;
	Thu, 25 Sep 2025 18:54:32 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id AEBF54065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 18:54:30 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-62f0702ef0dso4853163a12.1
 for <dev@dpdk.org>; Thu, 25 Sep 2025 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758819270;
 x=1759424070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qZ1izHFRA+J9X9+4W/trcoCGZlhOkV8cEaLFDHLlbc=;
 b=mlGw9m5QFjoJ88yqpOnirLi8ZgldWeW/kAXhpPzA047skD62CF2jBxgebSO7bTibZc
 jv1pGQCkq1mwYBZPhslQLgxjb9sdzKB0VZZr/Fz56kTaxAHyxS7SGJQqouZ+gtm+wlFh
 3dEg2NYgLq6sGBZ7HofJZ7EqyB3Xc4RdY+gc7V41TdJZWiO/ikpJ4xAWn8X9TcyvvHa+
 NFDw6qWQHaFoNMw5i2mqlv3if9vmhyrT+9UZIZpfzLSDNHgJKwPkmB/5HHXHddyJX4VI
 9iLHzq8r8NsQv/PAcsIjryZTffnLxjJksn4sdHZyRfVkn+oUw1yHcyuou++Y1bMh+4Sd
 L+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758819270; x=1759424070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qZ1izHFRA+J9X9+4W/trcoCGZlhOkV8cEaLFDHLlbc=;
 b=RRxi3/6QiD3JIwjB9Jz/euFTDrlXq+PRaA/sTeBVlx2a+NFDU12QmIYgR6vEtlTf4n
 gVx+Scgqdy7Vy1ZFL/77JBkEP1DxqtbRXS8Wnfq7OsjLupU1XEXA2CATgsZOJtmN076B
 gCOJ6Ou/aLHPi3dwGml8CzRU0u0joF5s2jZ3fAFJl3emN6VGByy8vErM0SY682Z+cOFx
 aiC3GRxFf2aeVo+G7OMHJ7K2y5qPo49/pUYTz8uUL/XxwNs+iL1ACxprTDnabpD66voH
 m6zV2qznU0zwxS0oZG0VMe+YW82ttP4mDjKHIY7PQvXujh+p5EQ6pCx0f35Zx44L6H7t
 CuuA==
X-Gm-Message-State: AOJu0Yw5R7Kju/W6QPbNqonZleWXKS+T/ZBqQGiZfyzbPTM228f09BR6
 UFW/wVG1TRYDyfPuRwGbxWbBc8sQUvfzidpxN5vSb8vxqV4pViX7UApLj7inEFVG7Ygn4IUnSUT
 0yoXk
X-Gm-Gg: ASbGnctZFJIXTF5NGvenayqLfyba8vE2pKRs0qc4WkHnA85QE8VFn1Dai3vkgkvhVyZ
 wOjGzmGjJ0fu8Tgvg1WJ4+xOeTz+AnDrVKfoPFjj+Ngv2yTrfCs7Dw0N3C5qxXzfzPpajGMF2/5
 qqC9inQhZQDOvYD63opINKOIgAXUasV2MQ+eQZB36j7k+PNZUdyFjW0Eu6E0fTK4yuByMRJMt32
 3ENWFgUQklJ9m9dXj2otct2lWv7tIJ9xL4kvcigfD2rkA3OMBdMmoGd8W9f5t2Q5VmZyiWHCj4s
 WXHp5juUSz9akQvTpoZOb+YzRLfa4mmxMB9LzyNVMYxnu4TGER/Nd1/z8jYXd7kppQj7VO2VeY7
 K0wlhSkQ8EAov/PliMJGQFHGSNCg/WlM2nZj35JUmW1pdCaAlTuh5dsdaUt3dTonplImCb30fxW
 Y=
X-Google-Smtp-Source: AGHT+IFo6J97afj9EeyvYO2PeJdt0/6SQBZtQPi4movxxYDV7PCctOccmrC1EQ5Wncy8c+o7UIBeBw==
X-Received: by 2002:a17:907:5c1:b0:b19:f444:5bc8 with SMTP id
 a640c23a62f3a-b354e605ff9mr357291066b.31.1758819269944; 
 Thu, 25 Sep 2025 09:54:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a3650969sm1459888a12.19.2025.09.25.09.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 09:54:29 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:54:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: Re: [PATCH] net/zxdh: remove unnecessary null free check
Message-ID: <20250925095425.44047425@hermes.local>
In-Reply-To: <20250924202252.472101-1-stephen@networkplumber.org>
References: <20250924202252.472101-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 24 Sep 2025 13:22:52 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Found with coccinell null free script.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Queued to next-net
