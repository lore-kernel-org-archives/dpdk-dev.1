Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB8C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 18:17:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4AB540616;
	Thu, 17 Jul 2025 20:17:20 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3A2DC4060F
 for <dev@dpdk.org>; Thu, 17 Jul 2025 20:17:19 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-236192f8770so9953365ad.0
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752776238;
 x=1753381038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muGHwiSVOaZVQ8X9PWJJSdDqlrerL1OJM76s1SnQ1Yo=;
 b=gQWJ69oYqgX111qB71sseBRiY3/d4uL8VY48N0IyMES4UbBPuHsrn7OQo6UzFivZnd
 lK7rR2zesYzfrPkTUQPHYl5vJnzxBfSOYNcNgajmhaRd9XIJjgJfdI3kcixwjGePp9Dh
 Kk66qcM/VkAEBUrR7uffG/ITpVb80hfTf59+QUcH481pCmMnRxa1Kc638usuQcbM9gtd
 gshdruvMLdbtMdwktxRzHJwilYvjr6lELn8+kg9LWHO658bkmnztwpWHg2uKB7D/26VJ
 epR+ImgBDkkiVt2mr9n61YZmbWd+k8+lq+d8rGMS+5hQZlnDNBXUCgACuJrTsDWao9MQ
 Lf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752776238; x=1753381038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muGHwiSVOaZVQ8X9PWJJSdDqlrerL1OJM76s1SnQ1Yo=;
 b=Z8FG86WGxRBult4FXQIBKJsRMmTI8FyryD9u3FIoG5cSJbJbuJAvuHFcmYatGuQEyH
 B2OULsIoG9DxldiIQUs/B3U3TVUIkhUYSRQKKMLR96U40/A0ga4IQ34pEYs9tfS+Ysb4
 6PjbHQOJ7ICIFHiSLKUYJE8eYoUigP4lh7p8qrAV+8a965Mdpds9AbonCn1SnTYQvi6M
 A/wbtAkFyBQppKM6mm445yxbzZhLucAdGY1JN0F9/S9fEpJjDlj3MFIOBRYhhVuLqkHa
 i+RzEd9jzatXoZUJlv9AHsRGbcujEiHSnOOPwADVPCQUoLmKywk/RNYVTKWbiGY+/OT0
 J7rw==
X-Gm-Message-State: AOJu0Yzf9tER93LSTyqdKr9yTuQ6cye33JyotIbEqFz3SnIcl8izixpT
 +ok8Y2WFEZLXVDkGyLP1LHOTVsNBxf4qKjthPrVwQp3fqKGeQNNsxseZon6CZCb3cwU=
X-Gm-Gg: ASbGncsi5QQ94FLC6k/tZxik6ycYqnoqjD7LfjGNPbXmiTKC6TTOWH9ntnomnvsmnI+
 Xx1K/EnNqOVzV69C1bzHUijEXOKeNWUbOwm6ortCGy6ojtxLFNwiyebMfmsmokFhqYZCZZowAGu
 RCqOQKVsJ1dbuiv/2dq7yW47Smw+/bMUaXXTBWOR1H/bZWVLAujCMgLMPzWuQRwL3NOiIqo5JAW
 UJUKLbao7q2N0jk4WszRDQ3A/FSYBUAGLE7faq+FmcqZ6LskvwXKWiKvQ1VK2q6GYGxngdDa3XI
 meznqA/uaFAx3zuGzQoKGDj3VGBfNwt26f+ujYTHa2qRHEMaeJmqJhnY4oWstXf5tnbL2LsD0BK
 7h1F7rW2g5UqHwowOqdvV2mZljAQgzdZqDAGAnt0DEh2fyHiEqXgSaYiQJYbG/sOxOfLylKIQaO
 U=
X-Google-Smtp-Source: AGHT+IF2yZYWzjP/TLuFt9qNkN4/WiFdGSCav6ab2b2xycOuOhv2nLeQ3P7/2/QqEXlpTi9UvXKn1A==
X-Received: by 2002:a17:902:c948:b0:234:1e11:95a3 with SMTP id
 d9443c01a7336-23e38f7f8efmr10886275ad.13.1752776238355; 
 Thu, 17 Jul 2025 11:17:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de432278csm149855645ad.121.2025.07.17.11.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 11:17:18 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:09:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250717110949.7fae4912@hermes.local>
In-Reply-To: <20250710012021.7698-3-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250710012021.7698-1-liujie5@linkdatatechnology.com>
 <20250710012021.7698-3-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 21:20:10 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +	} else if (rx_batch_alloc_allowed) {
> +		PMD_LOG_DEBUG(INIT, "Rx Burst Bulk Alloc Preconditions are "
> +					"satisfied. Rx Burst Bulk Alloc function "

Log messages should not cross source lines, it makes it harder to find them in the source.
Also, the messages in this code should be written more succinctly. Especially for normal cases.
