Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8236CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 17:15:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0428E40267;
	Mon, 18 Aug 2025 19:15:53 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id AF1CE40262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 19:15:51 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so26241175e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755537351;
 x=1756142151; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkN3PqoMjO2EqQbYcg7Jyupb8kkgoN6Fxf+P8lemTts=;
 b=0VmB+37f+603oSpg0Euvks7BU1kFZkYxucME+ez8vQak53lj7J79svRtZs6TFhsi5j
 sxaSkHDBZRMHtYo95nThzpf8MkCRS54ir+2suEenTpvqB/EvjzGMoOIc43J3NlHtqSbe
 /ek57K0N3zwDFqnXQ0vDxtDgwer+y0cK3keRUf0ojV17vSggLL9MY9B6Hh8J1PHYTMS2
 E4Qsf8LwXY5JC9vZeIKYTKdYW/+pWCU9UOKvSkEB4KrQ8FIRV7UMyeU+PAz0pbMPldd+
 JWyDJm1iouv2VszAnBfl42jHmlgg9dWaxnF/Bot3KNaiYNM4BsArv9MVDOdtfGd/DdW4
 w0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755537351; x=1756142151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CkN3PqoMjO2EqQbYcg7Jyupb8kkgoN6Fxf+P8lemTts=;
 b=nFl58XNDXmO+v1gBvgtfQutzTv2UVh8fRzGhTjt6qHfleiPaMDOlTdUxRoMvXQmu9q
 pFEHp/5C5Hj8KMxfLR6ra/kTbazLOJodeUC7KRbnG89vXfQ8M4E+Dm+ugSqhcLeddzW8
 J98hzs5Jhuh07tPC8OPLGVZ36zhZ188nny4cKmH39+efRbZi02JcOAGYFYQ3Nx3qYSq1
 bHNwJv/8KET51DjpC1IVmhxLBWBllanOBsmkjGim3E8JcfcR0j/qMaznY54wtA3nvQMT
 YbjMXskJH44sh+KMNht4jTVur6JWnb+UtHO7Zgd8OS9yvXqwRRbAFNxa85/sBI7rUMol
 Le1w==
X-Gm-Message-State: AOJu0YwwgR/ctNlB2EwPjiYZ4hulC5v+/MTk5a4351htQb10MOEKhZxz
 R5Nld5/9h4b+beyj7JgxyAOmTuZiWFXcv6ep6V8mvsrdwu4UzR2B3VFMxIcb/bcQ+mw=
X-Gm-Gg: ASbGncurHMCtYeuD/poEngUZtto73chr8JXaHeOgT4PbH2gNU2sS/HpIxX1/XtOe73z
 J3WNukDB7gUwtD5WOTFMS5/FkjfCBwg6CwjALc4zbXKRTfL0ORjUQoZx9SRB2kqU19JlWjdpz/z
 K4bAmrPFR44zHKs+SsjrkoTr3uDxXfIYOytQMNOu77KXv5uox03G9x7Q1HFVzoclwAzyUEoPjKH
 msLcimOYfI/npJ3RQa2uFdNRYqjdTzfxIOvkrwM6nLPzRe2fA8qEwYMH3J5FWDqhuQYqHpeDFbt
 E37/VTsSNw5QGerceKALjjaCNgMwwYtZbc7wZzxTKUsPzfz3sBFyeUVDH82Lk7JUm7dKfFd35jl
 eb3g5RWp0UG/pxSiohGI52CojV+g5p/MXgskXofeM/0flykseTPZeaZxGtzKj+OLYN7An3rtEYQ
 U=
X-Google-Smtp-Source: AGHT+IHU9aYA3s0Goef6eQJXpOFOSkB8YdkqsnOXRNjb4HszY2SlReLOace3bd9YPTA/C0zPqUsYUw==
X-Received: by 2002:a05:600c:4746:b0:456:2212:46b8 with SMTP id
 5b1f17b1804b1-45a21868a75mr72579805e9.28.1755537350975; 
 Mon, 18 Aug 2025 10:15:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c6be10esm192510455e9.3.2025.08.18.10.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 10:15:50 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:15:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 9/9] config: enable comma warnings
Message-ID: <20250818101545.3f356917@hermes.local>
In-Reply-To: <aKNWhb3YWogF4iRg@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
 <20250818161815.23611-10-stephen@networkplumber.org>
 <aKNWhb3YWogF4iRg@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 18 Aug 2025 17:36:21 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > diff --git a/drivers/meson.build b/drivers/meson.build
> > index b62880db02..4c08a1dd9d 100644
> > --- a/drivers/meson.build
> > +++ b/drivers/meson.build
> > @@ -59,7 +59,7 @@ default_cflags = machine_args
> >  default_cflags += ['-DALLOW_EXPERIMENTAL_API']
> >  default_cflags += ['-DALLOW_INTERNAL_API']
> >  
> > -warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member']
> > +warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member', '-Wno-comma']  
> 
> Since this patchset has already fixed some drivers, are we at a point where
> we can just disable this warning on a driver-by-driver basis rather than
> globally? That makes it easier to spot where the issues are and easier
> allows incremental improvement.


Would like to get all drivers fixed in final version.
The issue is that several drivers are open coding FOREACH_SAFE macros
and there is other series to address that.
