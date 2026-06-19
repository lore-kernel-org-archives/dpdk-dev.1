Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC24BCD98F6
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 02:09:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D9A54028F;
	Fri, 19 Jun 2026 04:09:10 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 52E0E4027F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 04:09:09 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-139986373b8so1515748c88.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 19:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781834948;
 x=1782439748; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zZX66ZLbiYHHkKJLsvou4ySs94ASGsa1cy85uyCfzY=;
 b=u1AoDz1B62agCqID9C2wDGzp+Ok6xkgzdc04TgbcJ2sdsy+vvLJFAlRRTRREIqKUlv
 6ebuBiDa/j0lLmrmNX+aR6eq4B1Jzr7+A8fhUe43ouZOpwJAKbf/SJMLGnKOn2FnGxAd
 3piPDAREFxDBvctAui0SnKTpb7zjlkEmyQpbb5pB2zxznUsYB53wzf6/fDDEapCC2z5G
 HWegeKibfc8zGSe4zpnPns6lC3pvaa4HwHQTa/1IiKtp5tEsYePx/jQnG5fjgrad9IoQ
 8RKqLTraSTHuBo0jH9Lni8xA+v+Em+cIPH5HwqwqGR4sZnOylCnbHscRZVKE8Vaf8dO4
 pFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781834948; x=1782439748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+zZX66ZLbiYHHkKJLsvou4ySs94ASGsa1cy85uyCfzY=;
 b=e4dqhp3JRjVNFYLwBg7Gkk9tc7xHDsPD5uyZ/vgrNFy+gDZvhalHjqPqeJGsVUsL+H
 NZ3Rmtzs5fMpNXcTEYQh+EPjfBShKqDUTt6KM7wnh32coXcQoswHJH7K2y2LtOld7HUS
 xnh8Rz/llFSYQY+vaiP0CsPyXpUoR4DVX8fmMdslaevFyw1cIq0IPxCvYmg5+RrzK8/1
 mtbfadYTJkeLUP70z66TR7cKU/AzvW48nW3RdTDDjJg8G9ju5pNwuf5/3QZEIsZLPZoI
 FwwSPb2afzAtV2bMIsdNezmI/SyNAW2HA/Llp/W3cwrANgT4NHlA+LTMG5ou8/EuldZS
 QAFg==
X-Gm-Message-State: AOJu0YwutefYmMd6uwfv7hK10Ox1B8HBz2aEdoRayMktEsKt5YAkNPOX
 /iiwHqMuVNBKoVjVu8Yfq2pcb5sNpy1AfG0xbqIJUks87wtOPumnzJrKDNQ5tlYU0BBceoW/FHA
 nlYFg
X-Gm-Gg: AfdE7ck1S5ndTjGj8UCs/w/813Mqx1+JYHTTggVXdz04kEDs1DDmdMK+koJaTF1T+DA
 YbTQ944zL/LTRNTK4+LT8o7YGTkgBx+2XNNtZL+yDK1ZGpe/o6dNgAoSjOjbWjF+03SCN4hh0E8
 SBPczKFgReJGAmAeIcoiBtj2u5Ctk1fLoB8P9cCpT5vRfL681OqJk5/pJMGTGHx4GaoLZ47Y79p
 LhbJg/ZxxW92xzYYFQXQmAgpaoG2zyHBjHqyhiqRO2eHtUQ2g9E+0rrn18uJKerYTq0vLeUvHO0
 4ZT+SYKdFXrXHzw9tnlrqizTT9I2jg6BHjba3QsjXhJnJIU433G61VWTBXV3kMjMUZwenMp3w0M
 Ny3jNKz5mlMai9gr/cbHzHm2SQO6dQZ5x1d5G7/5VZvDv6oudEwkVfenX/HMdEiJMKfAADLGegR
 S4fMXGupgZeqnp+1uvh5YO4mpTh/CCf6EXdQH/UYy7FQJfCPTUVJEUS2RVp8etgHr4
X-Received: by 2002:a05:7022:419c:b0:137:ea00:3f3a with SMTP id
 a92af1059eb24-139a2052281mr1395058c88.9.1781834948128; 
 Thu, 18 Jun 2026 19:09:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a34a05f7sm758713c88.4.2026.06.18.19.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 19:09:07 -0700 (PDT)
Date: Thu, 18 Jun 2026 19:09:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>, Ferruh Yigit
 <ferruh.yigit@amd.com>
Subject: Re: [PATCH v2 1/6] bpf/x86: fix JIT encoding of BPF_JSET with
 immediate
Message-ID: <20260618190905.0491c336@phoenix.local>
In-Reply-To: <20260618210026.430288-2-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260618210026.430288-1-stephen@networkplumber.org>
 <20260618210026.430288-2-stephen@networkplumber.org>
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

On Thu, 18 Jun 2026 13:47:05 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> emit_tst_imm() emits TEST (0xF7 /0) but sized the immediate with
> imm_size(), which can return 1 byte. TEST has no imm8 form; it always
> takes imm32. A small mask like BPF_JSET | BPF_K #0x1 then produced a
> 4-byte instruction the CPU decodes as 7, swallowing the following Jcc
> and crashing.
> 
> Always emit a 32-bit immediate for TEST.
> 
> Bugzilla ID: 1959
> Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Turns out there are two more places with similar bugs (spotted with AI review).
