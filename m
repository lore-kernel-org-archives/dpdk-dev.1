Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07102ECD6C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 17:13:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11AB44026A;
	Wed, 11 Feb 2026 18:13:43 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 450CB400D7
 for <dev@dpdk.org>; Wed, 11 Feb 2026 18:13:41 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-483487335c2so29195515e9.2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770830021;
 x=1771434821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKpJXpJArFLNulLgn5bv/XbMpfM1F76YvMnFRQ0nw/8=;
 b=Q8c6Tdrd0DVuszWP54pWDW3OYymN3AWhQ1GVlNFrB9b9YbGdpXtRau7d5lQBRI4c7G
 2zbc7zS0tFYMtd0IizZpZ2CZGwwveSM3pGm1ohizLbPUcw1LwFaV2P2HsqVz5C0n89i0
 DtlpHQsFcUD4tVUQNv2QUyPNwSJzYxijZ5zwcAaaKptwXEa5mLBV6QBaaz5+Z3qKxP9+
 wG+gIPfF33/6mF1oIZjdhjKeDvLZOXxNU9kjLOLcF+XgsLqirb+KyrCaw/0sizls1FnN
 e5+XQNd6hPHKx7RqYwtHN7SQOPEJZXasnNs591RQ3oOm76tv9KFKqQ0PkhMdnnlgO6QA
 KRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770830021; x=1771434821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LKpJXpJArFLNulLgn5bv/XbMpfM1F76YvMnFRQ0nw/8=;
 b=MqcZG0z2xF+QlkaWOntxN3BwIM8zWC7jYZGyTO6076IEwvNy4hl+Tj0uZQo5a0h2FD
 zFVGDu7vvUooLjgusMu9Sa19Z9mLGPjkRXQ+wfmOYXvOykxNqX2Rg1koeuhgifIvZPie
 PK0V9O91fuStGPWBZNn+dG8Q1P9lVValqeroFYofJDaU9z3Cn42Pnqfthlwq76O+Rs53
 S5kSPDaxoE+Ogrmn93q9zTjBfUjaWbx15zWZ+t9bwx6fBtP0LkvkMMuvt0EuzO/qqUfH
 Z9GL4LjVIqMwFVSM+FMyBm4SdFQulFs8mm8mErtBrd6MQyGTj1itt6+AhrSozhI7wsBk
 C7LA==
X-Gm-Message-State: AOJu0Yyq+GD2t5MWXPdfBRF97q+zpeP3UXPh3mBMs9KxCvrNSu7AB3c3
 oIrjXGTCOhT+oYV5e0nAvQ1FGHDknkOgl6aPWhYccsuhIFvd01Q2b4SS8oybzHkN0TCN6dPndA0
 pEvJH
X-Gm-Gg: AZuq6aIUh09irnfFuPgn8ygw3RVGixG1fF0ouQqHQPtn2h61A6HD5wywBaa2slxVHZy
 lug5gv2LDohMPPP3YZtF9Ht64RQHPgQ56Zwbs/cnAe3tvUHTi5pqLIIzliQPfjUnruMiEbkz7um
 I/tE8tPCN0G6o2pWiuedJeVBMUWolJlgGfPgyHJe5uxkHVXiRXTIaUuyvmSXZU3EAVKeKtCkFrH
 f2yFxWDre5p6lKOO9aURLnTYtIi1XLmogT+Dx/yeKvkJ+Xkx9eEBAXseyfvLokX1q4tq2mYbc9k
 CN04SSLwv9NNgiKzyr68W9r8czkc0K02EUXgcTgeIPmZGkbbXA+Ri76V8wvQpKbiKTLrW1S3IIL
 U6oqJlat+7VTsWY83HU2USIrpCn9eMwBQ+gq6cuvsikFmW7UfxweuapipCiz+XdS6PTOAEYdDfE
 ykUJiJib7pBIKLXAbNhF/tWFCXfORy3RMaJAqwgO9Iuly+IgT/ryqL4k5fEmt7T59+
X-Received: by 2002:a05:600c:8710:b0:477:89d5:fdb2 with SMTP id
 5b1f17b1804b1-4835d4e7d5fmr35745825e9.14.1770830020513; 
 Wed, 11 Feb 2026 09:13:40 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d92267bsm75682485e9.0.2026.02.11.09.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 09:13:39 -0800 (PST)
Date: Wed, 11 Feb 2026 09:13:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: add igb_uio support for NBL VF devices
Message-ID: <20260211091333.7392c3b9@phoenix.local>
In-Reply-To: <20260211024029.33810-2-dimon.zhao@nebula-matrix.com>
References: <20260211024029.33810-1-dimon.zhao@nebula-matrix.com>
 <20260211024029.33810-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 10 Feb 2026 18:40:29 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Due to chip design limitations, only VF support
> the igb_uio driver. PF are not compatible.
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>

The patch makes sense, but I would like to see more before merging:
 - more verbose commit message to help users and the next developer 
   works on this. It also should have proper grammar and be a complete sentence.

 - update to the documentation files for this driver.

 - add a release note if needed.

 - does this fix a bug? does it need a Fixes tag.

