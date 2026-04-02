Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1354AD6AAE9
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 16:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BDE34028F;
	Thu,  2 Apr 2026 18:02:39 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id B01094028E
 for <dev@dpdk.org>; Thu,  2 Apr 2026 18:02:37 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-5062fc5d86aso9561541cf.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775145757;
 x=1775750557; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ti2wnW1Xrb6NHSCmZEyEgUzysIRWU98fxuh1di/tPDw=;
 b=kUZkgFAhUt1X9ekDMgUi28vDFNTP75tj+z4YqkHwCOUYKq6t/G9O3g37NQ30rlmoR1
 cVw0FIn/5XfwSHvfnOAU6mfm62lP6nQ0Oiktk34OEVp52ttLHxKaOESPHSQlszeRdAFv
 N8skWPxgI+gqrdqgbTiqRQT++BULMZZX4yhopDWp5dc++9if0o0SuuyPa4hgwzuxxuAa
 04YgdQ5wcjYPSgaPfXa6XAny91ty4qhdQwev1ztYbcDlLoH99gBJ/dahJD3h/wW7qVn3
 lmtYlMW1vSolU5K+q8+5k+TYmL/N6pLcvQwQhktZ33WDVS+YPn4XJo/arYLlROe/7mH9
 wAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775145757; x=1775750557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ti2wnW1Xrb6NHSCmZEyEgUzysIRWU98fxuh1di/tPDw=;
 b=i1cKjFXHYJYiUlAv+EAIf26K8tCUFXKQ1tZkgpDcatq5BM5q9fjhGGqQmWH/Moky9S
 Mfz85n2RL6Y8dDaFZh7TjLxUAQsF9SAxyRadr26mp8NXLHhwMESi3PovOCndsY4TXx2Y
 7BirfFpWI5dUOg/aUCpyV4+jGberhOXFNpC3hg14/dbd8tnGv/QiZAlUpVNhtjXnrM8v
 RdXVEzdp+Ef79FNIHs3MAF6wgfKP6VPKjoJeF9LDCMReJhtpoiDpDipESVMfAZdvpglC
 mJo+BPZQPxp09kSB9ZLdaVLaBFxOls0+Y66rdUzKsH4hei7acXQQE8Dw6ZtMeWm3PJ+2
 cYzg==
X-Gm-Message-State: AOJu0YzvncQf/WvGyEjSrGreM1+ObSZdh+aM7FmqRjHK1nFnczCWIylk
 DR8zunj27vMMQ6Y1YfMSkj2bfeIIfidzbCktBLWT+wPg2li5lhIFFufM72koo9Wexk3OIXizUP9
 XiVfn
X-Gm-Gg: ATEYQzxWZu7HaHlHbfpK9H5Qhnmi+G9aliMgsJ0iT/hbYzmzMM94I/akttPy6JetVUp
 YwN/5rBr1WVx9run0kaoBqoR3H37atR3DTpTgV8xENnSmnudW3iKWWcGEvdhOkHqt9JcJQ2KrWW
 wJiTjBP139/jAi4yup0VTMx5nH76N8/bham+UVFwmBpZxZbwz1hYk1leJMd7OsQ46FlWKUJdY7A
 LatVbo+5wTwQBPRvUYDpcPldmX9urLs3cr7eFNmZXX54bU+oQLw5LYx6WeA3N7I4tkl1T8fOJ08
 6/nPPqE0tECzRetGSXz7EiDyILvY+Jro2qbQWQyuaGjY1FtYpeRozcIb6p4pnYEJvMu3CY/JpRQ
 bAWYenbMvsXCixGLgMB0XMK8iVWVWIss6xKX/RXgRrZ03DeDhXSMKhBibfCbCzJbrhVwhoCoyrp
 GfyMJn0Fmp3KOwy8+wmofQJ1jbo5OtHomQjhQ=
X-Received: by 2002:a17:90b:4c89:b0:35c:d98:d66f with SMTP id
 98e67ed59e1d1-35dd40db627mr3479029a91.21.1775145368247; 
 Thu, 02 Apr 2026 08:56:08 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe977031sm8376063a91.17.2026.04.02.08.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:56:07 -0700 (PDT)
Date: Thu, 2 Apr 2026 08:55:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: Re: [PATCH 0/5] Support add/remove memory region and get-max-slots
Message-ID: <20260402085559.4531d445@phoenix.local>
In-Reply-To: <20260402073803.3068147-1-pravin.bathija@dell.com>
References: <20260402073803.3068147-1-pravin.bathija@dell.com>
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

On Thu, 2 Apr 2026 07:37:58 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> This is version v8 of the patchset and it incorporates the
> recommendations made by Stephen Hemminger.

It helps reviewers if you use versions, see: 
  https://core.dpdk.org/contribute/
