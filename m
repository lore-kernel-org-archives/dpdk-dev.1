Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D729CC79FAF
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 18:58:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF1E4402C5;
	Mon,  5 Jan 2026 19:58:24 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 43A734028B
 for <dev@dpdk.org>; Mon,  5 Jan 2026 19:58:23 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so2038695e9.3
 for <dev@dpdk.org>; Mon, 05 Jan 2026 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767639502;
 x=1768244302; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhWZNfT7aMHGgHJ/aZbwgfF00QVc7sf8D/H/7mzybC0=;
 b=nOAMTpGCKKMmM9I5/NVoWOHEztbBg+36p5E/5clnQt7BnP1xWuKeOY/ZJAObYEF8+R
 Gary7U9IW8pXNlOKHUtshqFM7LrWdi+SfmIm+1WFyaf9zxHM4Vhvs97B7ce/tPOzZcuL
 VVBA2XrTDCCYL608ZznEvsgP6pGlVf0t0Hun7CqkjQP8VUxxwE0SulvhPNurjnb3NAaF
 DgMYI0W5H1c3skyQTP1Cx58LAM9i6dm5jQGLLTGuXXyBw71OQcqMRqtSq0D6cvUnabfL
 CDAPVxq4f+VEIlEC4SaNFMGiIz62cqPgwVWz/zyPxJ0WAlZ8EvgpSIiC1nQv9QiORcTg
 ULig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767639502; x=1768244302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xhWZNfT7aMHGgHJ/aZbwgfF00QVc7sf8D/H/7mzybC0=;
 b=dKKHNHUUETfacGJZ6RNTw62+f4lOre/RJ+jPJPpIiv5QOUCsS6ouDERQA5B+ujsN/P
 tOjiyr1mNLJLSPtfCzCeyicgmSY7o0q6IZgNKmGndjhzTUlOdPd6IVIwQGhKuiL5kX5o
 nasZOheuqauUOkD0Q0YIFlGTjZwa4uQoeoPaI/7vsOjtO+Ss/NGZFxULq9JMxD9uoflh
 bWi8dZTlYoDme1mQrD+dAm4PmN2RtmOI3sH3Kgc8eypq8Mnu2PihuK+afiGl36YNb4fd
 PJMLTWFiyy0KOB/AktQ6LL2PUUqMa6K8Yf5JSjm12nvXNswtqUEkjN6Y1XgetqGd/H42
 AEiA==
X-Gm-Message-State: AOJu0YzWZa5h4/XepJP/QRoOZjriy9OOcoe4pNeq9ejzrxZrykCxSj/y
 58OGTFnCp/WyBY+p9Tx20iS3SYrdF1oEN1ZkIayA0wotx4COwiinUKqzr2RGIwP0ZGU=
X-Gm-Gg: AY/fxX6dlI4q5DSoMQQYDmsOPam1WH1A/ycD4ZFVA9hnd0Jpg5MlE+xoRrklViDPOeX
 HS6AcNzfUWwGvlP5uQj4A/gPmc9JvRcGVCxsPUhJAsYssbodfsREBPFp/SvNXXQzf6W/gywV37P
 xgEOxg+0DJuV3rj5aMhF0kIUKcZBULsrTFBOt3UsDqlbGCmYq+DdYQ2z1IfQzB9tDz4i+auIzWB
 marStqQAxTFg4IcqMd4IXPD1mJ8Af80Gevlea/GdV4zy8HvM14UERy/bdgYI6Em1SgARrsDXtsF
 3ilgV52NmJil7k/CF/SbRtaCcnHZYAI6sdhqg1QFhLzC1JefJ/BG4PAFoBjpLWUr01lYkqUntez
 GlFW/kjluHPVfpAZzgHnWqXOowC39e0JM2i+JFx8aCz0Y3ivqeBWPduVKj4QIFmHGv7W9wBkB3X
 Gc9hJtesIqiMQlA4GZ5/LsYQXQ5t3nbSu0zcaltqTp85nmcOCawBx6DdUZlb6kUB0=
X-Google-Smtp-Source: AGHT+IH92UrDwG9VVTrCbRtkgJWPaS28YUfgh1fXEkZTMmFZUiKucsetiuvmiuTwDDemsnJ1T+k+pw==
X-Received: by 2002:a05:600c:1992:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-47d7f0a06d0mr3482305e9.28.1767639502290; 
 Mon, 05 Jan 2026 10:58:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7035f2sm1263135e9.12.2026.01.05.10.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:58:21 -0800 (PST)
Date: Mon, 5 Jan 2026 10:58:16 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ferruh Yigit <ferruh.yigit@amd.com>,
 Kumara Parameshwaran <kumaraparamesh92@gmail.com>
Subject: Re: [PATCH] net/tap: remove log when running without multiprocess
Message-ID: <20260105105816.61d0f1fd@phoenix.local>
In-Reply-To: <CAJFAV8yOrbgZCo6-BFAVt_0SKUZT1nFm29N1RgsBOk1DV6r5GA@mail.gmail.com>
References: <20260105123640.48325-1-david.marchand@redhat.com>
 <CAJFAV8yOrbgZCo6-BFAVt_0SKUZT1nFm29N1RgsBOk1DV6r5GA@mail.gmail.com>
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

On Mon, 5 Jan 2026 13:50:31 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Mon, 5 Jan 2026 at 13:37, David Marchand <david.marchand@redhat.com> wrote:
> >
> > In case DPDK is started with multiprocess disabled (like in OVS), there
> > is no reason to log an error on multiprocess aspects.
> >
> > Note: the only caller of this helper does not check the return value.
> >
> > Fixes: c36ce7099c21 ("net/tap: fix to populate FDs in secondary process")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>  
> 
> I chose to simply silence this warning, though I think something is
> wrong with the sync mechanism.
> Secondary processes should be the one requesting fds, instead of the
> primary process broadcasting to all.
> 
> 

Queued to next-net
