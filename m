Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C04AC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 22:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B0684026C;
	Thu,  5 Jun 2025 00:05:07 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id B4AEE4025D
 for <dev@dpdk.org>; Thu,  5 Jun 2025 00:05:05 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6f0cfbe2042so4513116d6.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749074705;
 x=1749679505; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3KlysHCDfWpe4kRRPjLaIs4l2E0+C7e7hDsaqR9u/o=;
 b=PcBL3WAQt3RMd5rJ+Fv/TSKojwgC49cKuCj5bxbm/bXIjHgogNOkHP4a2+VqrLWdCh
 Lb14rVUaPqXpndKrbe4w2iMAMXX01uVvFOljhmjuRB67ut/DYRmBaYSZyl/0u/kXSnMK
 x18j9+WshxIHnIiT4VxgsNeg5pGz9l5OP8uGC6r8VN8e7B5BmeqBAezb9aT6+5Az1N4s
 4GoCfWfq1Jy3ozc7ZGo3BUxFaWWgdklteuM/ErJa3ptMT9qiFOkUAcvYSG2r8wExYuL7
 76tEg/QAiI+KtVnT2qC34jsFFjypLGh9e/JydcNT0dZuM7g5jUJglNJ34umJdbkJyjPo
 i85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749074705; x=1749679505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3KlysHCDfWpe4kRRPjLaIs4l2E0+C7e7hDsaqR9u/o=;
 b=HiXdv1hy3cEKBOFxO4Iv+EgXp69LjuLLB0VnBYRjsAlaS3X5+Ou+pVvJmO5fM56iAi
 kPe4fd8HOX/UDeeC+4Aht+IToE6sAQAAR1Rb+P9Ljwtgk7JZcu0OcraprCjKXwuhTZCC
 +U6NL2D4Hh8p+1zCxxjg6zq2DrDJipse3UG7tuwfH/9Cv8MriXtxHUY81YEmL8MBWMBx
 DVeHlKqKeh+3Nox/upPwk9zt8MhsWbRNPLlKZwZ26J2x0AbE0K0BZk8M9SpNTQjzr8q4
 dLndRcVKbC4LcG+T2g7FMgKqW+SbLVVf/S2pNvDWaSTiTDUrMO1oGxiqGHimOpXH5BC1
 UVOA==
X-Gm-Message-State: AOJu0YwoVnqMsZcEvq10b+o0HFg4DlZRNXJCGPB2YhZT3NCuDzU5/ibS
 YL4fgFB/2QvRwBouSxIkf7XkWLbTIpqTmVjOMuCcqX7aCVlABg6b4Fo7OaRdV/sh8Pi9EaTNPbP
 aeiVJ
X-Gm-Gg: ASbGnctp4XFbwFR1bPxi5nyo4yZu+6LbeKUDKWTsZ86WQpUxK5T3r1pE25Pm+OCB2JQ
 ewz804bpRnBG8DGzEl3riw//yvLkDYAHIKfLEG4UY4xvJ3Fck/89u6i/PmPrCiJbuYQ4bYvvKt+
 ks3XXifti7lP1vWXBFS+bjV0mYGZekMbayyOPDaHtDHUputGfGiom+G8WN09TSqcuWDVhm/l+JV
 jza/DzUAwhei62Rj2KcP2KyY545qmxuUHykiZNc2r8d3x1nHogVSLGm5jtwNHdD5f0IdFm6rnKa
 K/vfI/GFPg8+DqrUkL4Jy3u1lXPaTRV4Zqn4hK+Ej5wDt2IfHoBVwJgLX3xlU7VM9oQFKR8RTi/
 z3CKhJrRIZao/g7yP5cuTp/ursGLuMO00MIugJp8=
X-Google-Smtp-Source: AGHT+IG1SkiOZyX8dDkEpl4lO/2baNzHugjX8qxkiy/Fe16A2CWedB/ER5HkJ1z4Ha4QwYVZI5HYNQ==
X-Received: by 2002:a05:6214:d0f:b0:6fa:c5f8:67eb with SMTP id
 6a1803df08f44-6faffe245a1mr20009096d6.7.1749074704708; 
 Wed, 04 Jun 2025 15:05:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d4d774sm107044126d6.46.2025.06.04.15.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 15:05:04 -0700 (PDT)
Date: Wed, 4 Jun 2025 15:05:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH] net/tap: do not force inline or unroll
Message-ID: <20250604150500.5f8c799a@hermes.local>
In-Reply-To: <5348112.44csPzL39Z@thomas>
References: <20250424160705.19655-1-stephen@networkplumber.org>
 <5348112.44csPzL39Z@thomas>
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

On Wed, 04 Jun 2025 11:27:18 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 24/04/2025 18:07, Stephen Hemminger:
> > The BPF code in TAP device was using outdated advice on how
> > to write BPF programs. Modern BPF verifier has to do less work
> > if force inlining and unrolling is not done.  
> 
> Why do you keep unroll in IPv6 parsing?
> 
> 

Good catch.
