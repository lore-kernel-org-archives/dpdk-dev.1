Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1741C83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F1B7402DF;
	Wed, 16 Jul 2025 22:36:44 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 979A2400D6
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:36:42 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6fadb9a0325so3162246d6.2
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752698202;
 x=1753303002; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ko3wWLHyFY5V/9bHpzti+JBJ65MUPOBcUgICjksd3sY=;
 b=g5/kxPv81zReq4dKl50fW2EGVnYBQHeHPX7Xa9VVtCfSKPmQKpLznqBqZunf4IEbGK
 rUHXWKI0MxXNigDPXLd20R27nO7uku/fi47qr66+mjHo39nsnkrhd5zPnuVA4/DtWAFB
 3/Jz2lY0uj35xu7NJ8N+uhUuorxl7iYllG5GlZzLRp0JD0m7kugTTy1xQ1iA3MWuTugJ
 kk2e2WWAhXcJtXSsECXf+kKGCsfmJTlP4Y6VpKglCuQNhNBvT9y+tWPj0SdbE1K5KxyL
 BoQvoUxQkUgMj3BrIYJjnHAgb+JcYvnqoqPqm0+VzEVmxJzqaIq5PCrzBAqQR91KRrS8
 KB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752698202; x=1753303002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ko3wWLHyFY5V/9bHpzti+JBJ65MUPOBcUgICjksd3sY=;
 b=dSaQ/NsAKQPVLSfsqcyUbjZF+m6X6wdH3RLJhj81KPZBeiqxzIRNHfe0CWigKie2ft
 0gNOmcWgsySLaMN5kyFa+8iEq3x5ZybdTcPRnzZEF9Esp7evWJnCf+wTPsup607LLnvs
 G0/Fw5jnwF2hpt60bLF1eXrENS113gp6INwqTiA27dM/D/whBrOcpICn2SQ+TE3i5Mxf
 usOZ59IoKOWxan+xPVJq8S92OIl43kWr084u04WHhrUNQfdrg1V1mhKo6ZYRr94JlgB6
 6lVNBh0Q+Wa1jXXI+BwqFx7xjqheapoUGqpTSRDyRt1LjoFNRoPYIzqZ6B/PNjG9xold
 04Bw==
X-Gm-Message-State: AOJu0YxQlRBulCruTs9whWi6zuXdwu/FZvIhBj93A9qzFHBC3mrkP/PQ
 vCNzq05SWR3ronFo6MmCae5Jxa+kQjZocwqkHm5zx/kZOik0jd/jFhGExWroCeCx2t4=
X-Gm-Gg: ASbGncso+TmJOnwFwxtRMD2GgpfaF2nPMtFlyOv/qkCclLOWuhoH81lJGK4vlD/wnVH
 ed1QlrWFryQBvkz5/IFrSqRepUwtKy44BzLL3OZzlS/3Sk2p9WGWpeEP4emNofuHzIpF14TXz0F
 giQmKkydX0BJ26YY6NPS2MAA1T/vKslTKwkbc+f4KXo4oGwBDpD0BwfvpK+5W0UDEU7ZkRFIZel
 MMtna+bJTVX24Q21qUDK8vX+fPwim5BE58TcZQUafV/rBdLZ1h+voUoPoCXTm552YENWkx/QgSj
 HtzVtFvHXOJj5ncYujyhdnhc0RzeRmQ/ZGDrMlGwSweMOErMvsw62oxSlEa0wN9+3ZzTH9Axmtx
 flNuL8xCkBisyaDn9fhu6ZTweGitqho4FFP7U6SRjct9bzfv9X5Yio0dWMv3oBHzgWoJP3FbAnS
 w=
X-Google-Smtp-Source: AGHT+IE41cADTZ2cYuGOorygwRIBEDr7J12Rm6Qew5A53hUG9924jU/MRfBtBwhwzCzWIIFU1QNxLQ==
X-Received: by 2002:a05:6214:5f0b:b0:700:bae3:e1a5 with SMTP id
 6a1803df08f44-704f6a4b45amr64274656d6.19.1752698201733; 
 Wed, 16 Jul 2025 13:36:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d71419sm74783026d6.86.2025.07.16.13.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:36:41 -0700 (PDT)
Date: Wed, 16 Jul 2025 13:36:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 02/14] net/sxe: add ethdev probe and remove
Message-ID: <20250716133638.0247bdea@hermes.local>
In-Reply-To: <20250716082930.83026-2-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-2-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:18 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +
> +#ifndef fallthrough
> +# define fallthrough do {} while (0)
> +#endif
> +

That isn't going to solve compiler warnings.
You need to use better mechanism.
