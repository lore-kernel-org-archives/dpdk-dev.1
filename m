Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B1EC36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 01:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE5040668;
	Thu,  3 Apr 2025 03:44:34 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 889F74014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 03:44:33 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-af28bc68846so386642a12.1
 for <dev@dpdk.org>; Wed, 02 Apr 2025 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743644673;
 x=1744249473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mztFjzyTQzE4vf1GZb3xqcMCsaGVFzaJwpha0VOtFg=;
 b=xAXAZXLRn0GkUKm3pr3aT8/LTi6BukFaH3UJN5pIZ78cNzzhY2DC41zb6qzpNsp65k
 yms0kNSO0cw/F5o9PfvxPXvAxhXD6aow0P/1+jnMvmcbRDq+r08esABjJ0LZdql3bf2i
 YH4YfT97N/p2n04Vh5bC9FRSH81sWHDkZvGxrfui8pA+griqsA4XUb82sNBwPRjBBn7L
 q+cBDV7O2uChW8ki6FJoSpLq0X3WWEFfTjuVaOpkCNvCQ7F5Aj4y2OnceSi0FW80ZiJD
 aZVP7UmztlfqS0u5yMowIXeWuKqtlLggjhHPdVkLF/aEREjQC+meNn6chs4CS4uQQ3yp
 W2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743644673; x=1744249473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mztFjzyTQzE4vf1GZb3xqcMCsaGVFzaJwpha0VOtFg=;
 b=e1INYOMdhFngV3s5o9uFvzJK7i/oxzpHuCEShxbIsW6fW42ikPxEBqpBh/BRrZicoF
 RKx5k+h86i1bHJp/sl56ZyIiI07xx5dtLxphA8Roh3ebTGBnyd0VOxAQAt7SOR4H1dPd
 EyaGic7fHdhJFk4sS8VvPTIKg672kmbCEsX3lsIwV6F1yGPT3bEUSHYLaVOZMJ/2SExz
 DfppKfHq17yeOFD6iLK+WgufROixJKDzPmyq3TP1nfGyR+pkVm1/OrbRPFNZwo6+NULV
 OgiqC05Yp8ARoc8C5e5h11ACL128Fa8RVC84tCftPb9cIr4vKCHz0YVnikFxJR8tUeNz
 X1pw==
X-Gm-Message-State: AOJu0YzK4sRcupnRGim56MF/X0Jwm1B2f63BBB4B4AAXI4zxSmNHtlkQ
 LYs3dCdvi2zKfe2tvkvfJdDi+Nmv5/Gir908t7lNILZgW5ojQGBMiyUwHnXkenY=
X-Gm-Gg: ASbGncvn9/Yv1n3psxHRrinQfSw3DnfmXs/4fnUw054f1pOOov9zBeiMhzqAGMUfACC
 R2WP6MPwLqs7tmQR4IGJcAD4XT2mW5Yiu+PSLnszurgf4VexsQuW6pzKY0cuTc3EZ37FsSMVv2E
 9vTSxVmiIQ7IYc9TEUo3NkjXnCgnOfeWg6amwAxFx8ikh1FatkauljK1ZRkRiKdtVKUdY9JiwCQ
 C826hvWQmx8B/ax0hiO36a/e8mxFMTPcRTwqFfVna9tN3DJP94Xmj0UVnoNf/m5r9NPJFSL6jZQ
 ZF+SsSd8kwuehpta51fi7oHktqerqAY9jNY/XZ39cfGmYMyR6vQrS5notF10UORnzilmBAwNNmD
 bQV0kWeFMttjgV6232RLd
X-Google-Smtp-Source: AGHT+IF/QgEYOxnI2H32D68TQe/5x21rPJZOlUh4BOZZqB3zesjKP2ErHZ20YIAuyB6IUXhgy9i1Sw==
X-Received: by 2002:a17:903:19f0:b0:220:f449:7419 with SMTP id
 d9443c01a7336-2292f949df6mr274038175ad.7.1743644672736; 
 Wed, 02 Apr 2025 18:44:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22978776a2fsm2604475ad.253.2025.04.02.18.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 18:44:32 -0700 (PDT)
Date: Wed, 2 Apr 2025 18:44:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 4/4] net/macb: add necessary docs and update related
 files
Message-ID: <20250402184427.7b8a44e1@hermes.local>
In-Reply-To: <1743577171-119901-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577171-119901-1-git-send-email-liwencheng@phytium.com.cn>
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

On Wed,  2 Apr 2025 06:59:31 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> Added missing documentation in doc/guides/nics,
> mailmap entry, and updated MAINTAINERS file.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>
> ---
>  .mailmap                               |  1 +
>  MAINTAINERS                            |  6 ++++++
>  doc/guides/nics/features/macb.ini      | 27 +++++++++++++++++++++++++++
>  doc/guides/nics/index.rst              |  1 +
>  doc/guides/nics/macb.rst               | 26 ++++++++++++++++++++++++++
>  doc/guides/rel_notes/release_25_03.rst |  5 +++++
>  6 files changed, 66 insertions(+)
>  create mode 100644 doc/guides/nics/features/macb.ini
>  create mode 100644 doc/guides/nics/macb.rst


25.03 is released, need to rebase for 25.07
