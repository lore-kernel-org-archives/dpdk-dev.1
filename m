Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A19BCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 00:33:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B01E4060F;
	Wed, 10 Sep 2025 02:33:39 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 99A0C4060A
 for <dev@dpdk.org>; Wed, 10 Sep 2025 02:33:37 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45cb6180b60so39510435e9.0
 for <dev@dpdk.org>; Tue, 09 Sep 2025 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757464417;
 x=1758069217; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dquti1WJQI4g63nP4iFPpW/fnfO59wX/gFt7zXC/xrg=;
 b=DQuqkyeg20rWfYlfDvDHdzydc/W1EeGYrOmQgHxv6qWF7f8TINo3THZff9ok+6IiWp
 8TIijr12BO8GQiHS8j4AMg6iLWC5iYOKMNigerzjeWVpgR8QebQZ27//UNnc+8M0vC6a
 iHkcGIZdPtMrWjMgfXBeBWCC0x5m10uQoFSu9FpspOQk0QuYkd46/MY7Sagbbnijb5g1
 ZCb9PqsgphS4Zz6uQbWRY1Dc6vk9Di5k66FKm0BsqkRCm7BiTUuzTLEX+NVxcyxFRodg
 uTlj6e7oaxGyBep1FfOJdkSVVXZ452va4D+QFXQV4wXPqWYDLnduX+mxSrZtAis36krg
 P/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757464417; x=1758069217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dquti1WJQI4g63nP4iFPpW/fnfO59wX/gFt7zXC/xrg=;
 b=LJr/1PYOp+zp1f+PU2nyxKQ1qvdVqfQ/Ap73vyT6pA6O5Q+TUPhlC1IADFm/CehuyF
 wAssq13irbCdUceLHq2KlwNXxjTfpaSEgLITq7fN/bkAFysj+mAr/UOhy1jPRuVSNV9Z
 7Tdlo9GF62cTDvZx9ZdOM0dmJfloowYsNzv2s5AsahwGzvns3ddG+EwveOb/MkLVI9iQ
 foc9OAPJLMp1Uo7P4NozFXmLFTCZf21AbZ/gF83fgc5R+LFTV1L4/61mjySkZrje8AfK
 4fwSFEbxerDrXKd7JdQ37wPx3lv+ORyC3srFUB9AUhf18sVcJkp3goXU0A2Qi54f9vX7
 URFg==
X-Gm-Message-State: AOJu0YzaFmyCphrv0q7PvKkD0fEdYUh0Va0IAvi7+oQPREuPaLMxRmrk
 n9L8eomosBJsuR1gB6alwp1/oSalAToYoGwetEqnSu2j+jkjbvK9IvGd8VRpdWK91xHvL+E0O1r
 unMtj
X-Gm-Gg: ASbGncuU7htXFQ400NQtSQQv8mC2YVFpK0Y38WKZAvzJno8OewsnZBDrAQBMV6KZf0y
 d+ihxL3iO+Sk7LZoAwFlxwMh4PkOUMCJkth20Liwhqv95FXdM7mpTyKhdmvLS8SB50hLcQj6Q8D
 Da+FKzG73htJg8q3Dg2AhyH/hl+tPidDybfHPRko+jsRHXvYPf+OPvPgxIn21A75ZGWL0PfJcxL
 gNDD/7tY0CaOPR0RGNIU0b+Ljf5MkxkpFavwgCM12nGi04nNQyLc5CMfPcv4w97HWL1L9K56SIq
 yuZArqTuftMlNKMqREl6TwbnAc1gJ+mSwhogb3xfYUyqT9e0BJYmw4x5Izx3KJhw3Up/ogMFguj
 HGL+rRh3/s55fUf7ro+m5mn3N3jm9h+XzZpxVLeBSmiG2dbCF5EOjt36jLcA1y7jL7VQb6FCIny
 382koBYtDW4Q==
X-Google-Smtp-Source: AGHT+IGTbHZCCmHILH5aDdF8wtkE+86mzgZ9UvNQjJiMAaOzVuupNNnKoWYZ7YMwJXLNdUkzV77bEA==
X-Received: by 2002:a5d:5d13:0:b0:3e7:481d:7a6b with SMTP id
 ffacd0b85a97d-3e7481d7f17mr8553801f8f.10.1757464417234; 
 Tue, 09 Sep 2025 17:33:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df823619csm6095665e9.23.2025.09.09.17.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 17:33:37 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:33:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ed Czeck <ed.czeck@atomicrules.com>
Cc: dev@dpdk.org, Shepard Siegel <shepard.siegel@atomicrules.com>, John
 Miller <john.miller@atomicrules.com>
Subject: Re: [PATCH 4/4] net/ark: improve Rx queue recovery after mbuf
 exhaustion
Message-ID: <20250909173332.17b5fdc7@hermes.local>
In-Reply-To: <20250903212846.268492-4-ed.czeck@atomicrules.com>
References: <20250903212846.268492-1-ed.czeck@atomicrules.com>
 <20250903212846.268492-4-ed.czeck@atomicrules.com>
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

On Wed,  3 Sep 2025 17:28:45 -0400
Ed Czeck <ed.czeck@atomicrules.com> wrote:

> +		if (queue->starvation == 0) {
> +			ARK_PMD_LOG(NOTICE,
> +				       "Could not allocate %u mbufs from pool"
> +				       " for RX queue %u;"
> +				       " %u free buffers remaining in queue\n",
> +				       ARK_RX_MPU_CHUNK, queue->queue_index,
> +				       queue->seed_index - queue->cons_index);
> +			queue->starvation = 1;

Best to not split messages across lines, it makes it harder for users
to search the source.
