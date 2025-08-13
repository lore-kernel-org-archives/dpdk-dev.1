Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B62CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:43:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8999B40657;
	Wed, 13 Aug 2025 16:43:39 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 3B95C40265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:43:38 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b9163ac059so750176f8f.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755096218;
 x=1755701018; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cC1s9srl4bhHpo/l+hcioQRvvpQSfh78aWFJnJXV0yk=;
 b=JQVdVjJrIEVlfnxyHl7svnz8wDvz8pJi/tFpLffVkxjM4GZwzRagnKH71q10Tw/DwG
 rpRw2jdp5E9L0wbcDyhDrQjhiwl9rLkRZJBfmWU1VfFQWo9TIa6T9VCj/MfeyzGhNuM5
 kzmmBbTQlfuuuB4JctMjxg6yxWCTunSXEkoV25noYFaFUGQee2pBwkaPh+ulZir43Z9S
 pMEltEzAmxxhqurCUCFmA5ttEz+GdPOXNDGA8jv1AuuJeQu9R3uDfyUeD/eaNVwQXSw3
 G6cilfAQV0lY914jvb9z3kX+B4biHugx6sKetBF3lJ+j8awTJxTNpMOKOYM9M8L/CB8F
 nQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755096218; x=1755701018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cC1s9srl4bhHpo/l+hcioQRvvpQSfh78aWFJnJXV0yk=;
 b=e53RYcPP+TwGHCCQ1Ty34HzGrp9UfJIAlQ4SAZcz53VoL4GtPMTmjgb2TulTJ8nkGe
 f8oARYRIadIeQWeoiOrMRELwZ9lGYcleYBjsgquioFBWMYtE8o0HTm0w8c9Fk72Gcsh1
 rmKgDUJEag3agwdU2YI0dbFlLJ1pFmqfeXKQjRq4I17HIAGWW7Dbaj4v+5TkdHQeyXrP
 jKLpAsECsER3WNZ3UU5IUBwvWAvDdwa/alwGCr5JS52cs0bOxAVzCK4zv6v5POT2KGmB
 1YPJd4SOfIWVAho1IMjkRokJ6LMOQFP8dU/cGn8+u/VzHm0VGS/5rZqugZMnKe/6YT/S
 VyFQ==
X-Gm-Message-State: AOJu0YyH1xkhBCDd8LhWs1Yw0QHXFWk+IOF9bdOZ8la2ajyIKDIzwmfr
 jTJVPh7KHxZ9yeHZWjKtoIzksCqFZwS64cXb7d5rL207iwUSLUeCBhw3MYV1x2QSji3sMLGstOI
 ktcMh
X-Gm-Gg: ASbGncsoLorHRUFuZBm6Nb6kFseBTpqCPGD2K5FcofHRGbTxc+iicHSGCii36Vjdtb9
 sZ83nJtgZEDhKCwLdNEwKNFsTJHMpBkFT5YLVtfYemsv0XY+CJknRVRIyPJ7sEAEqQ9RMSzLcff
 qxys8PZZZrcv9ZETy07FbNeyPPyEsG4Z1vTa7XQHLWVqa6uardqgRBlhSTaeUvvv28MxQQ9dVJx
 gon7CKWG3nNPgYMCfGjoiwgzwG8zTjObTQ6p8ld8bSH6cYXeC/plzEsag+Ue59gwgpdT1yYjnok
 MMfQMWl+AE82beVolsu1p/FYX6V2xxlQhBU/cOeJ474bouo/WUNShN7/+ip8cIeR1hLfgDr+44R
 V2vTsfrjx1DeSIXLdXKn/ajkcG6STzOOIo2WBX29nzrvKZbyZswFNo/5HUTQB3ScfdbDMTMQFAy
 I=
X-Google-Smtp-Source: AGHT+IFVsd3Hl11Ns1LOLGaCux4f7Wt3i16fP3owXwtfV6ikeDZAxqBwhYyikBQ0VU/UUTCkpPZeDA==
X-Received: by 2002:a05:6000:2909:b0:3b8:d893:5230 with SMTP id
 ffacd0b85a97d-3b917eb573fmr2942412f8f.47.1755096217624; 
 Wed, 13 Aug 2025 07:43:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a586a9bsm4693895e9.18.2025.08.13.07.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:43:37 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:43:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 01/16] net/nbl: add doc and minimum nbl build framework
Message-ID: <20250813074332.1a692f64@hermes.local>
In-Reply-To: <20250813064410.3894506-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 12 Aug 2025 23:43:55 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> add minimum PMD code, doc and build infrastructure for nbl driver.
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
>  .mailmap                         |  4 ++
>  MAINTAINERS                      |  9 ++++
>  doc/guides/nics/features/nbl.ini |  9 ++++
>  doc/guides/nics/index.rst        |  1 +
>  doc/guides/nics/nbl.rst          | 87 ++++++++++++++++++++++++++++++++
>  drivers/net/meson.build          |  1 +
>  drivers/net/nbl/meson.build      | 11 ++++
>  drivers/net/nbl/nbl_ethdev.c     |  3 ++
>  8 files changed, 125 insertions(+)
>  create mode 100644 doc/guides/nics/features/nbl.ini
>  create mode 100644 doc/guides/nics/nbl.rst
>  create mode 100644 drivers/net/nbl/meson.build
>  create mode 100644 drivers/net/nbl/nbl_ethdev.c


Please add an entry in release notes for the new driver as well.
