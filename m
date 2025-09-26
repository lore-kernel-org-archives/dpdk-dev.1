Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F462CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 17:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D15BC40698;
	Fri, 26 Sep 2025 19:21:19 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id D63D940647
 for <dev@dpdk.org>; Fri, 26 Sep 2025 19:21:17 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-78e9f48da30so18022626d6.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 10:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758907277;
 x=1759512077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+U8BdqJxxd8B4jJ4DLkygupbQYB3EqsItDwCjzrdFuw=;
 b=e1pPYEjCuiZzk28wxnC6ScjAcrzYY3qJqjbKwWRkhAtXEc+u92wiLHTtLOVxoqzN8p
 TIsvH8qESb0exso6FP4ZgQOGRLY8AAKqRooqBpG75GTSBkiOldbRXj/abYY0jMl/8o7L
 GISi+5DAFiTfvNRiWGGMHxoHNg3YbRgD1v3qRvsXTWUXBxH7jC8FLEjXLYHh8/kPubz8
 lnS6TEeP0xn1jdlhHtYwBnGiq/7P8fJiSt3HGMzhtIOnnjP31SEU/udgRe7BpBp7mwMs
 TGl7ioo6NHdNGlWgMrw4/83toAvH6nljCtLQpO+1iGHQjmQ3wye7cc8QsQ42zxw87cIR
 vTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758907277; x=1759512077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+U8BdqJxxd8B4jJ4DLkygupbQYB3EqsItDwCjzrdFuw=;
 b=HUe1/I5wgHbhJ9H3AyJeMP6fErRe266qs7UzVZWD76WG6+kbYOCFTFGbscUQlcg/Xk
 e1hXhR/dlrYukDqODEkEiLnf36hxnH9Jp2iZ51Seo++SQFLxE3MuYeQYNWmSQAfW736F
 3kAj4qCF16/WK7BuGOkw8+vqCsela6G1zc7S/o+7J50JTRjP4dsGw63DwKNVqpMEf1+x
 hAeZthzea3jcAanNSDE1otx6pflaoDYoztlrxwFhRPFkkbOhx1XG1I2TsJ6VYLXbjzVN
 SY/5YdzHICafk+6Kc/eadc7UvLIPPhgCjYccGgVXvEVWpyWv+gQCjAChp0WIN5/TWQhQ
 ko5w==
X-Gm-Message-State: AOJu0YzsC8fwLFwi7lVlf91/w4W5bo/Pl3YVmChyh6chmI9ZgSXa0b+6
 B9tH9HLkLBPBwWkAAHLiKb+5bRJJ/Ab4lebyacoEmo+MeAwFmMvyuuBNV2O4pmgxjg6bRTkoXuQ
 BZmKFXsM=
X-Gm-Gg: ASbGncv/4mTJJr2jqbXQueVpq70k5l1xfatVWGVdMSoDTnPUlyi2HBEYz0BsBCymhtH
 O6GodzLS5lerUZB9kHd/FyrLnYfNEEAIjzjW1ZUBO3LhdsFHcw7J1qmY/0YBBeIJpnzGbd2/fG2
 fS5yrgAHVZ4MLWcHTgVZflwS88pSNb3TC8yJF8XU7JzU1QvM1YYnGRYucBUM+IX3ZDznbyziI2j
 dsQa0dfDImyy6QbNK07cajRHsB9q7f676GRdKVQZs4lMiqWkqWl4/pmfCYp/HRKP7fINFNB3Ezm
 lD5roFZYiwqi7G8z1UE2dzZr1/jUrmpymjvxvkWEOF36P/jb6rakYMN+aHzUQ74CM/aEhmUI0JD
 D7BozEDjJOxRl8gnaASDhZC5WGGDpOFIiPsexH0sPK8qrQr6iLXtXngFN+e/xtjhCNE1Ht3pN00
 DIam6zNWQkEQ==
X-Google-Smtp-Source: AGHT+IEtpgsPIE6l1eqFhDAs2SiPBCJ10CC/qX3FjIDPCKYD+6fdIMhFYGu2QdEU7otgrSV9WWoMVQ==
X-Received: by 2002:ad4:5dee:0:b0:795:54ab:6785 with SMTP id
 6a1803df08f44-7fc45d03d13mr27088936d6.59.1758907277018; 
 Fri, 26 Sep 2025 10:21:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db11cd26ddsm29693741cf.45.2025.09.26.10.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 10:21:16 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:21:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: longli@microsoft.com, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH 2/2] net/netvsc: rename get_vmbus_device internal function
Message-ID: <20250926102113.52e7b532@hermes.local>
In-Reply-To: <20250926155802.398869-2-stephen@networkplumber.org>
References: <20250926155802.398869-1-stephen@networkplumber.org>
 <20250926155802.398869-2-stephen@networkplumber.org>
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

On Fri, 26 Sep 2025 08:58:01 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> All global functions should use a common prefix. For netvsc all
> globals start with hn_. Rename get_vmbus_device to
> hn_nvs_get_vmbus_device to follow pattern used in this code.
> 
> Fixes: 11c0663c9445 ("net/netvsc: add function to get vmbus device")
> Cc: longli@microsoft.com
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Queued to next-net
