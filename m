Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59550CAC587
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 00:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40AF0402D4;
	Wed, 10 Sep 2025 02:33:25 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 8CFC7402D1
 for <dev@dpdk.org>; Wed, 10 Sep 2025 02:33:23 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45df7cb7f6bso1021185e9.3
 for <dev@dpdk.org>; Tue, 09 Sep 2025 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757464403;
 x=1758069203; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6qOM+6IytWWS3UZGKHdvEWnUEld0jKcM+IrMYjBFiQ=;
 b=qcdeHxvgzptX0T7ht/1OZL1jptNK8a/sIphzSd6E/UlyBIFrMNjlONyhy+0BlquK1H
 H17DBLboA2phnrYEj8O3H2S2y1TVAn4emqRPgLBDJU6IM9XC9u4YVJe/jT3fzUjNs697
 /Lwe2zQCEHDTl5bHr5vFhw0ShXAc1nOnlhKNK2JOxoHEiW2Fxp8Va2zqntXYo/U4+EMU
 0kYiMYqS6sUdSI2JTMaalJNDpWddcNNNA80O9Xn8wh0bSLoB7gepFOhh3BLnxK0K0Bqa
 97LZp3K1Wm0YgGr2EkjLASw4egYPV4hGxEcu7OqL5U5tcjcif7adl75wnuHBYmdvYdw9
 1vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757464403; x=1758069203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6qOM+6IytWWS3UZGKHdvEWnUEld0jKcM+IrMYjBFiQ=;
 b=tMabmCEcLYhHM0dgg5JEDsPFn2GqpnMLy5WqzaVw79tijFB9MqH70VS200BFgQGAi0
 n6u8/swUGAoYEEtQ3Ovq9KHq4Tdp2MI7M/IBeOkaRZz98KIvAKrcVyKcj713B9rAXARU
 TqFRO+KWLmbhBzhdLlPv9Mv+tSwM/dnsmv1pg+asd3+oxyzNj+dEEwPoaWmfgxcifi2d
 nOICllp+ylxoouBocc7R6R49Bqsqyfw3owKb3Z7JOoESH1ZfeQ2HTKPmmdXS0zJj4N24
 TSZLntqc6k8vUYJO1LpatYYvFdBTkFhvFugoKXUwxAI2O/1Mpj13Tuf2JWv8fklv/Bzs
 pytQ==
X-Gm-Message-State: AOJu0Yxbq1zXNBVcW0d2JmBMrdqTBRy3zuVnpvgj5AFZb194JG/YlCuW
 SmLOKK70FKxBpNTJzRgiFKMvycylhJrjwA6kbdZpJDQd8zDay9V7SU/K8Dkr9JoLqgEsqbT5YWo
 7vcSW
X-Gm-Gg: ASbGncvHzX/sRTX0JaryupeXt/loHCQ+mdBiGxmzBkUm4vM8wPW0HmbIJ0hCtKbXEUk
 LDDaz2i65rLJMDwYKuZv4la8I/yhZtCeksS2t6zFrHAmbnJqY/8ILGfD/OdxfYz75AbgH2v99Yb
 lCl2eSxT2Jp4YNk+W8ElxI3rxxN7/T7XG7bRh3bddxKUdXnYFuSutmScfctL3gVOT5kJKGKtJGu
 R/mP2wKZPc5/gE5FLht9u0DuyGHDWZrht9sq1Z5W12QprRIMz4jAIdOzp3ZocezPaO1QevNRUKM
 8Y74n6m4sxWWbq9kXCzizZjvV2wcsBkUJ0WNJBcU2voGLD/rsLsN48aRf2zDGDzT8QHdNBGW2Xv
 H1BsL/fQxjW4xmHrQ4NFr2iTjetdMjNVrdw2nrA2rjUPpphJOCtw4AqlEOS7UFyb3dUI5A7snoI
 Q=
X-Google-Smtp-Source: AGHT+IFIsClFrMZXHZIDkdXfczmkE9Hi6a+gurKey/6ZNNlEOrrwAVcGaHjHV83JcS7XWlMmodqd8w==
X-Received: by 2002:a05:600c:b99:b0:45d:d56c:4ab5 with SMTP id
 5b1f17b1804b1-45df835a952mr3685945e9.5.1757464402982; 
 Tue, 09 Sep 2025 17:33:22 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df679a4c9sm8776555e9.3.2025.09.09.17.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 17:33:22 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:33:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ed Czeck <ed.czeck@atomicrules.com>
Cc: dev@dpdk.org, Shepard Siegel <shepard.siegel@atomicrules.com>, John
 Miller <john.miller@atomicrules.com>
Subject: Re: [PATCH 4/4] net/ark: improve Rx queue recovery after mbuf
 exhaustion
Message-ID: <20250909173316.4105b0d6@hermes.local>
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

> @@ -185,12 +184,12 @@ eth_ark_dev_rx_queue_setup(struct rte_eth_dev *dev,
>  	queue->reserve_q =
>  		rte_zmalloc_socket("Ark_rx_queue mbuf",
>  				   nb_desc * sizeof(struct rte_mbuf *),
> -				   512,
> +				   4096,
>  				   socket_id);
>  	queue->paddress_q =
>  		rte_zmalloc_socket("Ark_rx_queue paddr",
>  				   nb_desc * sizeof(rte_iova_t),
> -				   512,
> +				   4096,
>  				   socket_id);
>  

Not all ARM systems use page size of 4096. Some are larger.
The parameter changed is the alignment value, not the size.
The allocation is taking place on huge pages where the page size
is typically 2 Megabytes or larger. Why is this doing anything useful?
