Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39312C369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 15:24:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE35F4025E;
	Wed, 23 Apr 2025 17:24:57 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id D6589400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 17:24:55 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso73356095ad.3
 for <dev@dpdk.org>; Wed, 23 Apr 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745421894;
 x=1746026694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kOTDVdsRR0AUv1/Vh847eb8IuHCQ6kesOQYOG2axUM=;
 b=y4uBJBELhQ3DvqapdoLElAajFAQxhweRh9vu+/ZW4ESw2ZAA0ILkBRTkCgw3FHUfm1
 DaW+wPJOwOsB0eQql0uuydISiRFREF6yM9CyqvXBSJWqckTFYxr1MrrKVzduuzEyTPYo
 fV02YQ/aFh2M7pFQ0X+ahM6Wl6TrkWQgvNDa/JbRYszlxVuaqoOr9PB/X21ITJZBBhZ6
 WNH6i9P4ExOj8y+43AG4s83gV71Ti8SxyYk+Bx4/Nnia2UY0QYWw7+RqQbz4OOJwA0yu
 kztrH1YDljkz9EJoFRBVcY5mMi1YcGk6dTYS6xO0n4dzYYHtsD5rwFmc8+P1BsjuYeeH
 hXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745421894; x=1746026694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kOTDVdsRR0AUv1/Vh847eb8IuHCQ6kesOQYOG2axUM=;
 b=dpBDzzpB5F+qtgoInnUjV7bSv39HNZuTxBSlInyzreIT6KMjUF4ISAznkaEDS95zbG
 z3ORI18n3qJBwEyj7yIEnGuJnJHuGU3LDB/MqZzBNJ/wYJeNUQ9dQ2tQJvne0BFQw7Dk
 GZ7jwfA7S9WrqAUcFEIQbr7qF50LGzTQzUPx9xXz3di86PLzll+dC1ARwX0NZ11t6qlq
 CcUnZ7wWZNlOWDRGV+WYhGDHixPfOqUuI++H6DbYY+oee041n6Iye/l43iv3aAsDAxhd
 mkykgc30h7D55WZgyQoxPEadoLBRVjpo0BUXoBu7XkqevlQu6KxWVzLjBYaNa67+WO4q
 rJjg==
X-Gm-Message-State: AOJu0Yyn2hYBKFXJWgbZZrJ51AIa74NmNclB7DgfPtojIDJgo21zT0Eo
 7um5c+en7WP2hYGw+39B6G5Z5hVRAehO7UYFIGulS5OgJ7hujOfM2ty71eeuhec=
X-Gm-Gg: ASbGncuSdIqfxteW8SzHv0GlrGg3xQ6AzPrIIFusau3kVQkQGJAo5zAdWPkbmyahu8s
 yEdSdbzu5e8l6jR1UqHW99HfyOVufsKj4qIa784OewHTU6nxvYELQdS1DF7uXhzRHmFR6PyaeB9
 8UBMfq2s9dkQ/Du1oh3xiWSrFCIlNJaaKCej4ZFfCodEJjpdBVOutbVux2c2LCyXf6ITRQvmIPp
 kl+kyu9xNNKB0XP+UnSuYK2oQH39iOcpLB8p1BC/PJtBOf9HQto0EJQ3H6HcYwfZ1+BIk/r9fW7
 9VfTu2zgV/8RcalajZJVjHIGcDAvPvJ4IilI6yMpSqze38Idv5U45XCGfzLn6qOwwlbaDgPIt+v
 J2MS3duPQfd1Kp2Kp
X-Google-Smtp-Source: AGHT+IGZGQoMaj1ugTuwHxY3cBWqjrvJ8UzyGPcMGf8c2e7zAod6qp+ys0kPGImYVob9p8BAM4gfXg==
X-Received: by 2002:a17:902:ce11:b0:223:5ca1:3b0b with SMTP id
 d9443c01a7336-22c5361105amr332380555ad.40.1745421894512; 
 Wed, 23 Apr 2025 08:24:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb6718sm105321165ad.153.2025.04.23.08.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 08:24:54 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:24:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Cc: <dev@dpdk.org>, <rasland@nvidia.com>, <matan@nvidia.com>,
 <suanmingm@nvidia.com>, <dsosnowski@nvidia.com>
Subject: Re: [PATCH] net/mlx5: mitigate the Tx queue parameter adjustment
Message-ID: <20250423082450.5eb6cdee@hermes.local>
In-Reply-To: <20250423122807.121990-1-viacheslavo@nvidia.com>
References: <20250423122807.121990-1-viacheslavo@nvidia.com>
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

On Wed, 23 Apr 2025 15:28:07 +0300
Viacheslav Ovsiienko <viacheslavo@nvidia.com> wrote:

> +		DRV_LOG(WARNING,
> +			"tso header inline requirements (%u) are not satisfied (%u) on port %u,"
> +			" the Tx queue capacity (%d) may not be guaranteed",
> +			MLX5_MAX_TSO_HEADER, max_inline, priv->dev_data->port_id, desc);

If your messages are so long they can't fit on a single line, then they are too wordy.
Please be more terse.
