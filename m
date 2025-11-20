Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ACDCF64BF
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 05:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 496DD40267;
	Thu, 20 Nov 2025 06:48:01 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 53D9D40262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 06:48:00 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7bf0ad0cb87so469182b3a.2
 for <dev@dpdk.org>; Wed, 19 Nov 2025 21:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763617679;
 x=1764222479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrtX/xXmHyLjNjN/wZidZI09yePbaRAjs48H9SU1R7o=;
 b=E4MNzmUN8rEOUazugI+89b0ywEOblrkGDbA7c+Vqu0AF94sbq54LJJawMNMtVZeqCI
 qam3bYQ4q6zBHZYvC172E4hnSPzVUzDTWTgYrZBW1GslhWt32e8bizHZFX/KzzzIdQlC
 tFd8KhLZHnf1TBuIvwwdeBtSarT2MRVhZW4uPaJEDTHtPyDWvvfWjVafESMxgU3uvjqX
 p0qbKs2gf6qwkNziiFbYOZKwKyoqK2T3aQk2bPCFNBOCwYlnFe1ExTMg0JIa+za13Twd
 xRTequ5RfC0SGe9vsQnmwWQMkVwtDr7t+9ytrAlE32usPRQ2sERk4qxBouemN1JhCxWH
 hW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763617679; x=1764222479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VrtX/xXmHyLjNjN/wZidZI09yePbaRAjs48H9SU1R7o=;
 b=EjFDaEBdJEMz6QPyK4KnhrCqVuxXK0jwamyoZmRi+hSZTh7LnuyNHKu6VgITN+Ze8p
 1oprJEE8SFqGqU2uuYp8byXd+/BwyWcp7ZzxDh9zsIZ9WYjldAj1Wdv6fA1st0DIKjrr
 H+qqvF2lUWgIBNMAyT8/RNp9UHzOqno0oZqMVeDNHrRkldZAEPspxI2OAH7LZWDqTheL
 jx3qUxMNfB1vhWzo827fJPy+Eotv0HfCufmbSjHbOgbBTUBNoYQ6gCkM8yI0L6uo84y8
 oyNr/x1hek75nKz0yDy+u9giKOju6DM5pRiYW6JnxXRd4HYF7sYNNhoQMCwo/zvGMFq4
 g+Zw==
X-Gm-Message-State: AOJu0YzAAjiSjBXHuIcaKtKY/0agHuuvybB1hY1AUIKQehh4xbqvRAE9
 1lBHHuG3/cRLcByh4AeXSbRCQraIrSFbodS/OI/X6LQsCyg/vus8NXhzyw7eFxEkjRs82p6O4Rw
 z8lLu
X-Gm-Gg: ASbGncs8Bi6Tkzb0TX2PfS1bRG6NiTE4Akip7mqeGRGDh7SYonffX6mukAMgDzq1F5m
 8naoVE6Ma+iGJhWKEKcFhtyIvYbH7vIsbqHXo5PjDF6Jt8OV6rT8eDj7vwxawwBczCLfLlIbkDh
 UYmt+sL2kxBTgyrfsS8FFzHConMUJpJvN/85zYNhZ8X7oxZw78fmqhSVs8s7KwCwBhuydnfOeVD
 G2CQOMHMveYhjfomHQgESP7JyHAbHbZ/VY0Gfvvk2V/ozFy8lMN21L9PLUB9U6WXAZiumGeTo0M
 /5Op9xIC5fdq/b43uTBOZwijlEg417yVCCXMQ4VJeKzAj3rKhWH5IH55KatjgHXA7p10IzdQzwJ
 r6KyorRXkpqH/5Z6jLSEdOqJddXpREQHCFy2QXoBvZKhFPweFjiMK50VT0MBLAB+dS52NEo9qwx
 2HuMMMnTiOH7b7Nmkzojzax7DJqO5KAGR2QelkqQk/fqxPr3WwYlLj
X-Google-Smtp-Source: AGHT+IF0Kwigx1rKmkdqMMdVp2zJyCBnoMdAMteSFgNSN1u5apYqIGKdgJ789bkOw2PyMRP8r2VQwg==
X-Received: by 2002:a05:7022:3889:b0:119:e569:f627 with SMTP id
 a92af1059eb24-11c93893531mr881100c88.32.1763617678963; 
 Wed, 19 Nov 2025 21:47:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93db4a23sm6569684c88.2.2025.11.19.21.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 21:47:58 -0800 (PST)
Date: Wed, 19 Nov 2025 21:47:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH] net/txgbe: fix the missing old mailbox interface calls
Message-ID: <20251119214756.6642de30@phoenix.local>
In-Reply-To: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
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

On Wed, 19 Nov 2025 16:56:24 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> @@ -28,6 +29,9 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
>  	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
>  	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
>  	mac->check_link = txgbe_check_mac_link_aml40;
> +
> +	/* MAILBOX */
> +	mbx->host_interface_command = txgbe_host_interface_command_aml;
>  }

Maybe that comment means something to you, but it seems like something
the next maintainer would not know what it means. Could you explain it more?
