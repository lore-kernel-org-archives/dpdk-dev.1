Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51600C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F95410F2;
	Tue, 17 Jun 2025 16:01:38 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 53C7D410E8
 for <dev@dpdk.org>; Tue, 17 Jun 2025 16:01:38 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d3da67de87so174490185a.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750168897;
 x=1750773697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRZCMKY9L7fcmC4e/vbGH6UUavmrDkEQlKe0tCa0h5k=;
 b=P3Zbgm1ZIahrhmKGkU57pSg1jjwDiuTuR7XSjUtNmOa1BekmUsvC9zFfwP/2dwnKpR
 wx7DMXtE9Fc4DPEMi8i9Nb2X5s7ZuqhDV3qSaftPKW+VX6ah9rWoyaycsJvlueEG4wBY
 04SANTa78ayBe7flUwo3s6oMRcvJO0lul+ui3qDCKtXO/xbrfnVOIcyXqNu3W657E2Ty
 dWLaCYddHhJzDbmfw730jCeKKobtcxB1rP6nECUzGtNg1m7PChTlaiBHG4Iqb9U1i86D
 13BvmhJz/1fLh/Up/YZ84p/s6dkX+Iszb1Z+dqjGZy9M1g5B1Vkw89VOObxBGpOppRIK
 Y1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750168897; x=1750773697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yRZCMKY9L7fcmC4e/vbGH6UUavmrDkEQlKe0tCa0h5k=;
 b=k3GwJqd31y1aIvI4tZbKksJYJh9AHd5PuPAm2wYb1oVFMJEqpEfCxC10TCrBcjsio/
 Q+1+kvCDEY0wgdXkJRJjqrUKweyJaqa4bCRRO9Zv8xBMe2Zd/7lmB4++wqeFqhzNYYD5
 m9zucvBmjYEVlPq9bhbmADQKq3YJh5Gs57YStXWr0FZBYkMdzbNNkjUodc6mhDCbmpUX
 2rQ1c5Dv+VIn9/UyrBYc1HhYUJBsYj7DneRe0PmN/UYRm5xFC/1OIi9cRMhwVhkiiAjm
 jat2+JGSINNEJuqvuZDO0SxvFDsgEaPkZrzwlRKlDPfMD/s3kmdqVjwwoNAUscRKSlpf
 iC2Q==
X-Gm-Message-State: AOJu0YyW0OJ+X8lIwTo+GC1EGk2yGXGGG7MuuAFgCNK/rnvYC7K0TpRG
 X4LvKq+hoZenMEPNIcXWTQsiXYBp1pIECuV4nDBlCVqDHv1rsrjU+VQsIkb/Pgx2MW8=
X-Gm-Gg: ASbGnctqRtkKftd5T1y/IRl9jXE4njTTm+rYjI8XNBhnMMd7Mgqf8sdM7Xtgw97woO6
 xBOE3XsQL5YxfqmvzDXkYcKHtjB2ykW5AByro7N8z4xRSes5JiNMTjnHpjWFkX7w3mg+Xn6cX9B
 dkln2YmEQ7x38Y1hsJIqyr/eNXynDS3oAF9PxhkScQAEcbQhBZQtTMY/AWN2yj9vvoPwjeaOXHH
 K99MXyqqxSaQ1CSBC5s9GwBYEZWuTCZ3DGNsWdGPf9VGDB0FxrSxdFmK+0hutCkq9NAymoBs5gv
 XRt0DBFhHxXUHUDVflc97ERhoJAC8xSJhl6dNr1qJqW6fz8nXi6/TFI3Op2Zb0llc3Sk0vMdq53
 m6LCApb/sa1GVnemGx4qV5zsEVwz6wf+FXhj0et0=
X-Google-Smtp-Source: AGHT+IG3BiHrU2vs/iNmjUoIJMDQTdXbwBR6xFg5vw3PAciUvlyPKn3vmopsBSXbRd/Lk5/dUDN3IQ==
X-Received: by 2002:a05:620a:3184:b0:7cd:1d87:6c79 with SMTP id
 af79cd13be357-7d3c6d02f09mr2047071285a.53.1750168897154; 
 Tue, 17 Jun 2025 07:01:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b8e1f0ecsm649875785a.50.2025.06.17.07.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 07:01:37 -0700 (PDT)
Date: Tue, 17 Jun 2025 07:01:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2 1/5] net/zxdh: fix meson.build issus in compilation
Message-ID: <20250617070133.32770ae1@hermes.local>
In-Reply-To: <20250617020503.3554511-1-wang.junlong1@zte.com.cn>
References: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
 <20250617020503.3554511-1-wang.junlong1@zte.com.cn>
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

On Tue, 17 Jun 2025 10:04:59 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> fix meson.build issus in compilation, which
> caused the inability to compile in the arm64 environment.
> 
> Fixes: 29e89288ff14 ("net/zxdh: add driver skeleton")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>

Typo in commit subject. I can fix that during merge.s/issus/issues/
