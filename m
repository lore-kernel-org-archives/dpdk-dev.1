Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E3C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 15:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E878A40669;
	Tue, 27 May 2025 17:44:39 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 55D3640662
 for <dev@dpdk.org>; Tue, 27 May 2025 17:44:38 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7c922169051so186019785a.0
 for <dev@dpdk.org>; Tue, 27 May 2025 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748360677;
 x=1748965477; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Na0qGlMC0OF82JB53in3dqbmZE7hjgdok/gVU0zkwJE=;
 b=TcCS29kCZju9NPfsOCAyhsXC564Di55E7MRoaTGqXfuPJ+jN8q0LwNm830bSl6jeee
 VvwN5+CfHTCxpjGSzFNh+pWC020Wqgca4+RPVVUPjFne26A5UEMkFLfATmlQrpKqzNbW
 l+l8bCwsDXrys58BQV6SPRL9M+lA+q9Y9hn/XrrgL3K9GW/G/ENMwWLSDATUU6Ys8TrY
 aiROiWXcyQOpj2oJqy+BV9UhAiMsB4nit1nTMGmAxD2ZlIlv/5IAE6FnRdboJFGktbQf
 mmGmApRoqda6R6YoMm/6XD4QwQemjt7Yy+Yq6dgE3SxEnu3FYYWDq5dYNst7alTqMAUc
 5r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748360677; x=1748965477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Na0qGlMC0OF82JB53in3dqbmZE7hjgdok/gVU0zkwJE=;
 b=V5JN7BL1oOi199dvGTJyzu16SkW/Q2DZMjjZ2Yv6w9bC2tSGmFyUtp78G1dUPG0IWz
 Fy0Zs8C4mas7QAJuIc/GQYCfoFQZEDi0Ovd3Uo5D8+V3y/4VMCIzq+mKhOlxUmBsfkAt
 wCcQVIHleYMKOc2sb9QIaV3qeMw/YM+QMvveWo4H/JZP3AtcRWNQZTv71/ygyDNbiMdo
 knTeCh3FIxiJ0XJA5M1Q2x+5HwwNTujO3C0aH2PgO7S0+1YYkZjcwq/iaYb8RxQaSdKZ
 bdXMiqifiTX8dcX7acKBc4oP3e4qSQkaX/8jEx9zXONbbVK/Miv04vY122RrC1EO7gwE
 QsSg==
X-Gm-Message-State: AOJu0YzF2qVH5r6lqBIWl+N3jAAbxfz7AISpsuQzrHZ+YKFgqKl2jZ/U
 /NiJDOZe0bBrCMHEalJppCDqcyDv/yjm0aIe1e46F1lzobjPNEpRKEcBqYAYNa1KDSU=
X-Gm-Gg: ASbGncvVnJfvO72Bm3WvHNebT80OYeqewDI9aPKyYdT5UvkJVmPZuO0d0aJ6YWCertH
 io4hAz9/WGpQn9HHbirs64/6eU4M6BXqQ9TNwoo9R/dV/cSTEo9cbnMgbv5XdzBmtppMF0VjwXC
 y6EdQUZaoSz+o5ZsrTq5CgH5e60GAAZfFeTHXCJYB39LUauESdyAKYg+vO2C0/AvShTSOvYQNGZ
 OFD5qjmRb5z7PpdT2hxhH+ILNq9cG1/QIzi8Yho/Qu/VzS0F//rYFZ13rqv5YlxhLSC10Lz9ev8
 Y9iQ07h7g5bjPXKvgc1ODUXoJVKcxM8XWg7YvYJMR3Qcgn82PSHrGpTdh8Wkro8/C7DNA2OgPc2
 +G6CSvzF3T5gcal6EAFB+yw0XLVAs
X-Google-Smtp-Source: AGHT+IH2ueeF1t0MqtzX9Tr96BIuU16vcP5ce+chcgX3jkSeRCwq7c3qIzm8eJatwcagdRI2GiyTdQ==
X-Received: by 2002:a05:620a:268c:b0:7c5:592c:c27 with SMTP id
 af79cd13be357-7ceecb7f4fcmr2295944785a.21.1748360677590; 
 Tue, 27 May 2025 08:44:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467bec16sm1748475485a.9.2025.05.27.08.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 08:44:37 -0700 (PDT)
Date: Tue, 27 May 2025 08:44:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: farooq basha <farooq.juturu@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [dpdk-dev] Regarding HQOS with run-to-completion Model
Message-ID: <20250527084433.0233d470@hermes.local>
In-Reply-To: <CA+xuiv0zZ82m9gUM5D73hLVC89si72piuax6jk_a6ZzHuoBzzg@mail.gmail.com>
References: <CA+xuiv2jL934JR_QyLC1M5A+5dGPzw5L0=4RoS98eRjueA+9-g@mail.gmail.com>
 <20250521071845.50d6f9e1@hermes.local>
 <CA+xuiv0gKOp=Ukd=Nd-b=CV3YvA8P+HpR3PiH4h+9Dus9-vK1g@mail.gmail.com>
 <20250522082105.2aa03935@hermes.local>
 <CA+xuiv0zZ82m9gUM5D73hLVC89si72piuax6jk_a6ZzHuoBzzg@mail.gmail.com>
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

On Tue, 27 May 2025 21:09:57 +0530
farooq basha <farooq.juturu@gmail.com> wrote:

> Thanks Stephen.
> 
>              While browsing the DPDK qos code, i figured out that existing
> PIPE-PROFILE cannot be updated or deleted at run time.
> Was there any reason why this limitation ?

My understanding was that the original author did this for a specific
carrier use case, and made restrictions to make it as fast as possible.
If you allowed updates, then locking would be necessary.
