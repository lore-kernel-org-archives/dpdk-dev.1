Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4FCEDF17E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3593F402C1;
	Fri, 13 Feb 2026 18:25:27 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 38A1A402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:25:26 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so965633f8f.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771003526;
 x=1771608326; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTnkzwEiwxM05mS0BJUad5l0qa4OhA597WDWADVcXuc=;
 b=W86vAXNn0Wj1nJ7wnye3LIA7CEnqKepfQZcQlFT7Eh8NjVBH9KuMZGLAgHD2bOdknf
 lklZ+UgtTfTOimuTLZosQ8tiej8ZQZw2/CI+taPsEGfdXTENyn2+YmvuSTKi93P2QHvi
 coFhWcRuQgrANOOOcYlXwa0ztA4Ly30gNSWiZihGVYDUIJQstXDh/WoIEkd07vEUg6Rq
 JDpg1CSnQ6lCyDuGRTdLS8WIzXossUtubcY+daX5zvnx2jV/cZOzrGn8wO9qjAsioJ8K
 XFR4FnDFfm0cHaFxfqk1Pka6TmnuScRRgGIR7ASGoxEk9Ab3Z/AkpGkUsOGgmYLh/xVZ
 GEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771003526; x=1771608326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rTnkzwEiwxM05mS0BJUad5l0qa4OhA597WDWADVcXuc=;
 b=WyEeJjEQLwxzXnPihrD51YBQzXGVtCixU4NGr9D4GvX3axY0qCF2dbtIok9Zv3nKta
 dMHQuavqh11Ec6Wv9D5Lx8XQ8UiDgYQ3DnmwI5aK298XoZEMuyXd2hGRK5WuHBXEdoUK
 nOZ17L7DBQU6E6SvfOcAbpM453lUQWs7H4yp33weZpr9UhosBcg+YopnFPV7mW10ZcKi
 hdOa65TxrcMjpMiA1CVBV14Nn9WNa7Ke1OvgN/NzHGZBasLU7hQe/9UyeO+Ff4jcqJR5
 10mLmEc7VAEAOcedKSMHS1/C4qs9dLffDAkCB3z/xuEnPXWGkFR8pIqDJ3ZVkvhD5Kz6
 6KXg==
X-Gm-Message-State: AOJu0YyvC4a/P0xWoXeyJXrIUigADX1bmbbKnppyognSBjJlcoccEvgn
 58eju+7vVmvg3CbdwEjGaGhvUoyAQpQNTFQyqtU+P1NprQNWl8D1R4bq/zR+5Xjtr+w=
X-Gm-Gg: AZuq6aK2fYdO/B+OcznPjWcB81gOR4A+1FhgEJSAFo0Yg/4mYXLCbpKPpLJme2KRjum
 /xXGFspmqFbTamA/Zl8HfbphykGW0QsxVJITHKQ+ujrEhdGawwxEfMcNb/ZT4BU2TYrlCNNS2hg
 SYKSOIioMn88lWD5uSdT0X5bZhah94cGiBRZdL/u4sTbq84FFNN1RBGqNw7rh2S7+Uc4Wl1V3up
 sakwDIv1UPC0AEmbvnDXKagi958DdXWl5bnAF1kiex3k1HnIELaknQGKnL5cjB1ZtSveC32NvXG
 oGgcgmQzv5P214S3AJgiEDGx+SCjXIQAJS8B9TAdxa8bf8O6PLYduXG8BCUdYmXkURlb3D8dcv7
 kt4KczsdBroMRmNazV8GRQCRg/3qx4V6fKwJUgm63SQIdc/JVEEg7a1qxyg1mrd512WxJ8w1yw4
 847mXHhZSQOdnn5i2wMq9N2CC5IFirba2eZuadzHpk0dzVWssADWa5NBCCltRevqoh
X-Received: by 2002:a05:6000:2dc6:b0:436:145a:e54f with SMTP id
 ffacd0b85a97d-4379db66af5mr506653f8f.24.1771003525739; 
 Fri, 13 Feb 2026 09:25:25 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad009bsm6881627f8f.39.2026.02.13.09.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:25:25 -0800 (PST)
Date: Fri, 13 Feb 2026 09:25:17 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Selwin Sebastian <selwin.sebastian@amd.com>, Kishore
 Padmanabha <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Jeroen de Borst <jeroendb@google.com>, Joshua
 Washington <joshwash@google.com>, Rosen Xu <rosen.xu@altera.com>
Subject: Re: [PATCH] drivers: disable comma warnings selectively
Message-ID: <20260213092517.4bb136af@phoenix.local>
In-Reply-To: <20260213151559.656837-1-bruce.richardson@intel.com>
References: <20260213151559.656837-1-bruce.richardson@intel.com>
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

On Fri, 13 Feb 2026 15:14:00 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Rather than disabling -Wcomma for all drivers, only disable it on a
> case-by-case basis for drivers that need it disabled. Use a variable to
> do so, to avoid issues with compilers like MSVC that don't support the
> -Wno-comma flag.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Some of those drivers should be easy to fix?

This change would be helped by fixing and introducing FOREACH_SAFE macros.
I started that but it never got anywhere
