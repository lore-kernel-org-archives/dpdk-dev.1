Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60036CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BDFD40653;
	Fri, 24 Oct 2025 19:11:32 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5726D40668
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:31 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7a226a0798cso1995774b3a.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325890;
 x=1761930690; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsqg2DEO5aLZDrbDQ/s/Y1HizzhRD6YdWDLGe+Spl9c=;
 b=js1uVN9LLJ/u99t49iuxGSUBvSgZ3uETBCWFaKgoWDtBNfRcmjPncgNzd1a6ned38o
 yGj0xiGzcAeI+t2MQeSErlSuJJhnEiXj2kE7zX3r3Al6RLvk2TVFGr3RcSTp7Bl+3OGb
 Arp7w8D8YRe6fcpwsE8mqYl+2R9ZiuEKaWMkdKpHxxMWTr7b2gXIJrBdVGbTa8m85R/4
 iKoGaNRk6yXtFwUvDPWiq8X4YIHHnSo2ysdJtqUs9YMMN8h/Rj3vbftUNmI0+WKH3cO1
 o/aBBVeKxtE4R+tNu1pcsbkOF/0RTbSAf02EYOO2iXuIf4MAxmQGBOv0W56tipZWuCaK
 Vccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325890; x=1761930690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsqg2DEO5aLZDrbDQ/s/Y1HizzhRD6YdWDLGe+Spl9c=;
 b=fD0LMYLBmEzbuZBGYkhgYNuekmTg/6kZ7E9PHXlapHA+9+x+0W0TawEFY6iiqtMpLA
 E4qANoL8Kj/1lgfW8cOIx8B8DIlqfkcGSSiLJJ6G1kgfwIT49PzcfvGd+WGgVMPUHUz7
 RGGfkMZg+yYX+ck7KsivoVI90yigGNs97gUhn9UgkLaMeLlvfKs3HMservjO1M49/xAI
 lj1AUCq7cc8oKfTk16UbJo34yQoLJ/jiNaAFAlprdTn/XmMvU9bgzsYtRWw/5PgMaW81
 vqyQdyc7NLXSTAhViPHqD/8GQ4OVejPLog7q2ibChj+YRfEFQ/H19LmpEskuvYoC1XXn
 YghA==
X-Gm-Message-State: AOJu0YxfIPOFeV7BGuX2MsmZABprhbzkJvJ2iZpAnlbxo4v/LFUP03fx
 dcB0x4qXC5VCOZmF/2Vr0bBYflYoh3CyA4db0akwwQ66vpFOQQEskxYz7XB1FKpYbxkIUuhW00B
 DwgkO
X-Gm-Gg: ASbGnctIb155aX3ex0DQAptM0DEPduPM0AeVVBgp3pH0ubq/4ZW5DOaN3rLah1RSkd5
 wBMi6G7rzawGaPIWbsg0X+UXFGodUsUYc2JXCLjMA9v71JmrqtJQzTwLWy0GxLJ1rh+BzcQOLG2
 f12hw+JdUbYkiA54AsXPj5eTtdzngrxYIxBkj5AsyoNbTwpFqF1pYWRC9UV0otgG7rcbTj53Qr+
 X1a1P+upKAGbNst03USaZueALiTSYkhSu246jf1PgnUiPhLRwBreb575zYF7ktOaGMg1L+hP2lQ
 /mYUCONrmHmMiol5gCrcagRJVSjIR2Tgsq5EfhfSriuZh9wJAJICAWxIFXjeX/aKDAvrwfmwFUy
 GE4aJtATPrTXU5OxcMgR/M8+QdiTQRHz6VvIL3/hSnlaW6Kj+bHZ8GTmVrox1CyoPobHxRk8ctr
 DxHFptJYh5eQoZaPfQXkxgQyDf+V4AzMLBlPnN17Ee4kq3
X-Google-Smtp-Source: AGHT+IFBxvLct+WpfzUKMFabfIdJ4Zuvr/TZlln6mz6smXPaNPnWy2bn7OHtEirUgxJyzXEcILwGbQ==
X-Received: by 2002:aa7:88c1:0:b0:7a2:7255:5a8 with SMTP id
 d2e1a72fcca58-7a272550b1fmr10278754b3a.7.1761325890434; 
 Fri, 24 Oct 2025 10:11:30 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:30 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:42:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 01/13] net/sxe: add base driver directory and doc
Message-ID: <20251024094239.4d7de2a3@phoenix>
In-Reply-To: <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:05 +0800
liujie5@linkdatatechnology.com wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9357f3a3..b286452143 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2074,3 +2074,9 @@ F: examples/vmdq/
>  F: doc/guides/sample_app_ug/vmdq_forwarding.rst
>  F: examples/vmdq_dcb/
>  F: doc/guides/sample_app_ug/vmdq_dcb_forwarding.rst
> +
> +Linkdata sxe
> +M: Jie Li <lijie@linkdatatechnology.com>
> +F: drivers/net/sxe/
> +F: doc/guides/nics/sxe.rst
> +F: doc/guides/nics/features/sxe*.ini

Maintainers file is kept in alphabetic order in the networking drivers
section.  This should go after "Intel ipn3ke" and before "Marvell cnxk"
