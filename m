Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E20EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 03:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66CAD402DB;
	Tue, 22 Jul 2025 05:47:14 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 65673402CA
 for <dev@dpdk.org>; Tue, 22 Jul 2025 05:47:13 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ab8403b6daso51777911cf.2
 for <dev@dpdk.org>; Mon, 21 Jul 2025 20:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753156033;
 x=1753760833; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p23ulxcBGbTKZTbPWp+fdnHEceD3rXepQ8kzQiYPeeo=;
 b=eTs39ryNp5M87gXeL/Qz/RUguPR/XqgSFuzXBvbGjO0sAHQyCJiFJVmg6p1hY3yb/F
 VhsCVFY1qimHj+Mvh507txRMsqBgZ3+uy+yGDZcMMB+aIGWDzA0kSh17mIh7W72CMOTo
 Pc+4Y21R4wcMABgf7J1avChyROTFLub4uIeTR8oEaVocqzBn6HyzZ2XVO96B5WTw/d78
 yT0Bt+ri45NyK2uimMz4hm0pSuXGcJUkjc3ADdwWY5DPgxzpV2d5ywSGCqkihJ5Gy6Ji
 cwQak0nFMGQ6nUJdmbt4ZRfrDQClWvJA1fkCs/YOXXsr/UctYnGL8MRh+b+F3JB+mW/7
 q0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753156033; x=1753760833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p23ulxcBGbTKZTbPWp+fdnHEceD3rXepQ8kzQiYPeeo=;
 b=T9FpI3U/Xpa5PwbVTvnJptLXn1R5isYjxH9+IQGh19k47wXXXKUjki1t/cb9FXmfhq
 /T1BN92EHDXSYsnj3NyxxMgSbyOrQ6J6+3GPWOuBQamjt4ND8nJXWmejZa9QIYGMBsVW
 vrtRfVfqupxcbjztWVv64d6GmkeXNqOB/y+OUYTqFisQnTcqJg/qLqluqzG1Glsh6q6f
 M+/kd/KNeSgWZR/9YALMVTJTbpuI952njx4SFl7Dl9DOwrq+92++UwQlugWW6Enfx4BW
 4Qar6lsj3R+sHvtknhpi3huKvL5SJ8HROKwDPBNy5fCggZ/+n4rNBfaYgYbeyRZStWWR
 5QBw==
X-Gm-Message-State: AOJu0YyOChVimvOWs7YpOciy3jN5UhpniTXrep16gIbSo4+bRHhEnwKF
 lYA6hAm7+dQI2ZQRE+SASLuqrOJI+icptzYlu0HQV0VLz08HJwbbyHUPqs8RcLyvAbU=
X-Gm-Gg: ASbGnctZ4wRKtFKH72DBkU/T1zUKv/RnC7Atm3da7Jm5mDqcyIXaPg3ASZGce2emjGL
 tgy/TH6HyFmpnokJijG9zaRPCOD74wXsAPIXRuh3I8Cf8+KsVbWcWtqHvvijuXa+oDf3MiHZbcz
 Z4phBgOxJ+cw7hBHd4KrheFpj0a9CW3LFN2ZuC71lT8zsV93VpJa02W9z0iSU3bEsj/PpQNxaCi
 Qql/mbEW9fzVrnyQwO/JJ1edpbKe+TgMaNwDlAJusRFhqEg+bsdEt25xZ22rEYCfFaKq0C9arir
 JZRcWLKTmjp33BDro5SpkuGpDxeidYV7O5AOmkKMs9ePrkW/1ky8cqgBrgG+NPXpDZG5CPBLBDe
 c/EwZEsQ5p7pxB+76ppxNUBRaIafMLLUAHPtUXYhTKzTVfoxiXua1f+Saizxn3EDGEIx9NBtGJd
 s=
X-Google-Smtp-Source: AGHT+IFlTfho41TqHPUHk71+d+59JFOpbjZhxYWwmk9KEQY4uxJHQ0uncWWfB+cKDvXkkk0Dfa5eBA==
X-Received: by 2002:ac8:5715:0:b0:4ab:b0a0:5b58 with SMTP id
 d75a77b69052e-4abb0a05d15mr277913891cf.46.1753156032740; 
 Mon, 21 Jul 2025 20:47:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4abb49d0513sm49638431cf.33.2025.07.21.20.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 20:47:12 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:47:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: dev@dpdk.org, Jochen Behrens <jochen.behrens@broadcom.com>, Jin Heo
 <jin.heo@broadcom.com>, Guolin Yang <guolin.yang@broadcom.com>, Yong Wang
 <wang.yong19@zte.com.cn>, Shrikrishna Khare <skhare@vmware.com>,
 stable@dpdk.org
Subject: Re: [PATCH net] net/vmxnet3: fix mapping of mempools to queues
Message-ID: <20250721204709.486af8cf@hermes.local>
In-Reply-To: <20250709212905.126851-1-ronak.doshi@broadcom.com>
References: <20250709212905.126851-1-ronak.doshi@broadcom.com>
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

On Wed,  9 Jul 2025 21:29:03 +0000
Ronak Doshi <ronak.doshi@broadcom.com> wrote:

> Index bitmask variable used was uint8_t, too small for bitmask with
> 9 or more queues. This patch changes it to uint16_t for now, to be
> same as in the Vmxnet3_MemoryRegion structure. This way txQueues
> can be lesser than rxQueues and have correct mapping of memory regions.
> 
> Also, the patch fixes memory region check as 16 queues are allowed on
> both RX and TX.
> 
> Fixes: 6a113992060e ("net/vmxnet3: add cmd to register memory region")
> Cc: stable@dpdk.org
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Jochen Behrens <jochen.behrens@broadcom.com>
> ---

Queued to next-net for 25.11
