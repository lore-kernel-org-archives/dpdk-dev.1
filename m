Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A8C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 14:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D42640668;
	Tue, 22 Jul 2025 16:08:20 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id E18D340668
 for <dev@dpdk.org>; Tue, 22 Jul 2025 16:08:18 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4ab9ba884c6so69237151cf.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753193298;
 x=1753798098; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LTIByl0UjqQH/xIqvh8xz7gayCe6GP/2DHCpWnd1L4=;
 b=rwdHlNpOLNuaFKKC7E8D0dnqZPLp8+hcK0jA8eHE1u8BQXeM/7X0ZIOL80hvfayELM
 MaIN+snBRp4qhOlIzsrYsfaF5DUxEyF4iq43NEK/JNOdd2JoaTGV4wTo9QmQt+H1rucC
 yHSc8v/5I+Ct4nWsW6/H6qnK7rJpw8mXX4euCNpfCSygS7Q7jq77/YQTfMdYV3rt8c0x
 zA4rWwbxozrtFV5ExrHYbfvyY7883jPiwb7XaODUJD3pexXGZJ+s4ZNKxhYkETU6fvOe
 OyGjb6/ongIFSq2hevnMZMab+R5YwSIdjfAEmVSQvFlA+frtMlfXXC1xMM4itg3i0dcw
 Z3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753193298; x=1753798098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LTIByl0UjqQH/xIqvh8xz7gayCe6GP/2DHCpWnd1L4=;
 b=bu1x4U0x/RMs1EozxtTh6fn4oy/9NsGKskyqPSVlE8fp2gndl8pGl9IwIuIXAki5H/
 gwZhgmowIDCiuicy062kH+o4MFTFRdWGmH90PfUXGVBHSTtVx5LEcrgWbdSCzLvExQbe
 WOwFhPuamQLp5G6pB2fCruFZot5FFgi6He0SNie1mQRAxUF1a7vVUqonvmYO/yLbGvcG
 mXn4J9hXTisyjGhfcHd8fYSqHde4A4WAxnyQG6Byc0yTgql/H+acBEQJJmLEs2j+6OwJ
 LadNYvqYX1h8UeExFeIDWNmLUsbzjgtuMfhM9XPxCSxP4ok0jsztRd0lHNx+woIL1tKK
 yTvg==
X-Gm-Message-State: AOJu0YyHJXJmtZpi6Gr/Kgx1eEA4s1G5XSTfbEIPiS38zMIEkhtD/LzL
 mYLP/CXBy4uHzuE5vjaoXYbhxNnhCLN3JV3+YW/YTeqSrRHiEyOfGSfqoTa5j6T9Fwg=
X-Gm-Gg: ASbGncuQVCiGAPQVentF4fS9SmerCR41uU9KVCCQKoytGwOeIB6u2pOpbKmuvUKuUky
 k6RHAO2RXawhyMqkcJ8l/tZlhzX17HBKLJEJ8XvNSVGdOmqZ/H/ZAl8mNtn5haOh2C4PLa4kivD
 x6ulgcyndQYRUIm2EifIwRyLTxowZ6kCESj6c/k5A55SXlRAL3+J+NJKLJsYZoN8vvZomE3LfcO
 bLq5/N0qTphQ7iyXDEj8dlUuKJ4xVIqD2dAuq5lD+2pf+GYXrYKMfjAhwZl5677+x2pp4TQUFGX
 /pTWzpTy7mhRS4bTMiydu+vb9NjAtWCT/Ob2Afw0Z459NRTUG486hRg6I0BSNwfr6+KAGEbIJ/+
 JF3ZRlwIDReuechsyE7Qkb2LVG0vpd1zck702D0pvPC75pUMDHAiOAWeZMvBwIa5fq+og5LYZXp
 ZbE4NCUX9fzA==
X-Google-Smtp-Source: AGHT+IFIUmoCc88gpHJDzpqmUE5Ke25yRc8ToTUjawiJjT9bgWmzdwomE0O8lj0GAhDqLYetDsYcog==
X-Received: by 2002:a05:622a:20a:b0:4ab:40d6:ba26 with SMTP id
 d75a77b69052e-4ae5c3e4cc1mr39658011cf.24.1753193298150; 
 Tue, 22 Jul 2025 07:08:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb4aebcf8sm54625291cf.40.2025.07.22.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 07:08:17 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:08:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] app/testpmd: add flag to enable RSS for single-queue
Message-ID: <20250722070815.620df80d@hermes.local>
In-Reply-To: <20250715125330.2127309-1-bruce.richardson@intel.com>
References: <20250715125330.2127309-1-bruce.richardson@intel.com>
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

On Tue, 15 Jul 2025 12:53:30 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> For testing purposes it can be desirable to enable RSS even when only a
> single queue per port is in use. Add an "enable-rss" flag to testpmd to
> match the existing "disable-rss" flag.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Not sure about this.
It makes no sense to have RSS enabled with single queue.
Maybe you want the hash but no steering?

But the DPDK RSS flag doesn't require driver to produce HASH.

I would even argue that ethdev layer should warn application
trying to do single queue and RSS.
