Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBFC36010
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 21:35:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4BA640144;
	Fri,  4 Apr 2025 23:35:23 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id EC7B8400EF
 for <dev@dpdk.org>; Fri,  4 Apr 2025 23:35:21 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-227914acd20so33868725ad.1
 for <dev@dpdk.org>; Fri, 04 Apr 2025 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743802521;
 x=1744407321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJ6Q5K7Mb/yMMPkHDIN5d/B4fC4eR95RovE7Fy2BmS8=;
 b=hGDwljJorDf+L0q52HqQJXsfTNgpE5If3B4Pw1Es20rTc9GBQBqxWmtvCbLchpcB17
 tWtdpEtsQJQRivjeCd+hgGfXvCPR6ot8wzoJarEUEg0p//FdpTGtD/AvsZGsGKXvSVkE
 JHGe7+g5VvbFQPW9DJ+aJkh+FQ8Iop4mS0i6R+wG30vsALWvzYRt8jvo8eqp2GoT9W1A
 B4jxTaAWoZoxAMxRUaiMFY9W0w8+2uwMp7l7B3eDfcjl5PezNmoolV7my1yovS+lJpez
 c6pQKCQgST+ECXl1MBsTWQfOVCX9/5QACNclhehUhYUEQJAAQ7GhU7ZYpYhMAJOjMtdS
 hMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743802521; x=1744407321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJ6Q5K7Mb/yMMPkHDIN5d/B4fC4eR95RovE7Fy2BmS8=;
 b=YLDPRslMM+VcNHnXffZj07+L4hzRwaxxUtPKmDg5ZZM/18Nf+tklFG2b388RsF08BG
 5c20ITRUQlfkps5sJiYcylnXRo6CaUgs9OTh4GnlDlkQmQhsyAvMtSPxseowdR/Zjwgo
 cpWr1gvNPuEzSzdlMbc+MJUAVvfNwL3oZO552/NHApocewZZfW4sHP5vXznBYzv/N+al
 RIGZ+zZsvrDurUKDNpQZdQS6wxAi/cmNzrQ84/2iDmdhw/HPkI2AMqR4HqvZ+c5ayDi+
 VkximeKXLMSuqHY4i8mYTLVLg6axoVDsIlMOc3NCMQ/u4JCanZkqdhW7Y+eNP8J6zkP2
 02+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+qaHBI+kt1LVJNStx+k83RX/or72LfMYOSLLq7HtKknHnYdsCzMX/fwRzcEKrEz95b9U=@dpdk.org
X-Gm-Message-State: AOJu0YwNQAE9tP51tJlcbAVDYaaxzzrCtu8KMO+vhWkyhXlsUVD0aUnc
 4s1xCBcSBEQJuaLMpI31YaTmyg4WAVEuL5ATzJrcuExG6gllFgQ7tnSX1a/Km48=
X-Gm-Gg: ASbGncsgb/XzpN6CAfbiP/MEYPgqzwC06LXVWuq5aeg39UH8/GHcu4eZW/0QmRbXQe2
 gtIrJHYN7XCXx3tUsLwQRMoACZ8HHLImjSV3NtjsmpID/RygH1GPXHNdQJaXk/WJQiA/FPIdd39
 Wd37T4JJLrJLuO1TScafCs7mkHu0qIL54Mkn40hJkj4ILgjtCJZA715T/2Ljh3l3+f2f7iS5GK6
 b57pGn0JpW7q8u3wcNhn+7y+FifCgzm3U/X/g6eTxSFblo7GXaOpPph8ym5c9/DigmAXyahG/M8
 UpKhKTFffirD4q8ho3mmOcISNw1aEx3abAK+yIpjjy/ffCJmgJWUXpWBGchLEZ01YUO5K0GeEo8
 hJSpKi6MPkYwT/TzZLndW
X-Google-Smtp-Source: AGHT+IFdCwy2ROfPxu0o5kqhBzpfmLCy8JA4J6CjGae4MpjeR/0dl5Svh1ZJQRnCphVLKPwhMl/VRA==
X-Received: by 2002:a17:902:e545:b0:223:807f:7f92 with SMTP id
 d9443c01a7336-2297660f147mr94500595ad.20.1743802520941; 
 Fri, 04 Apr 2025 14:35:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc3fd35esm3358312a12.53.2025.04.04.14.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 14:35:20 -0700 (PDT)
Date: Fri, 4 Apr 2025 14:35:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>, <dev@dpdk.org>, Jerin Jacob
 <jerinj@marvell.com>, Nitin Saxena <nsaxena16@gmail.com>
Subject: Re: [PATCH v3 1/2] node: add global node mbuf dynfield
Message-ID: <20250404143518.037d7d6d@hermes.local>
In-Reply-To: <20250404071228.893308-2-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250404071228.893308-1-nsaxena@marvell.com>
 <20250404071228.893308-2-nsaxena@marvell.com>
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

On Fri, 4 Apr 2025 12:42:21 +0530
Nitin Saxena <nsaxena@marvell.com> wrote:

> diff --git a/lib/node/meson.build b/lib/node/meson.build
> index 0bed97a96c..4330d0450b 100644
> --- a/lib/node/meson.build
> +++ b/lib/node/meson.build
> @@ -8,6 +8,7 @@ if is_windows
>  endif
> 
>  sources = files(
> +        'node_mbuf_dynfield.c',
>          'ethdev_ctrl.c',
>          'ethdev_rx.c',
>          'ethdev_tx.c',
> @@ -30,6 +31,7 @@ headers = files(
>          'rte_node_ip4_api.h',
>          'rte_node_ip6_api.h',
>          'rte_node_udp4_input_api.h',
> +        'rte_node_mbuf_dynfield.h'
>  )

Github build is failing or this.

Processing lib/node/meson.build
Error: Missing trailing "," in list at lib/node/meson.build:3
