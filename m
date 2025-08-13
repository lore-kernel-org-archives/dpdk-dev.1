Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770EDC87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9795B40EAB;
	Wed, 13 Aug 2025 17:21:46 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id BF53E40265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:21:44 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so3957300f8f.2
 for <dev@dpdk.org>; Wed, 13 Aug 2025 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755098504;
 x=1755703304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oM9ILyNqf8hRKpJQN9H2UvfEAr/F3zJGCyrnotgeJps=;
 b=L3U/DdGR1rYifo4IgbhImwh1aKrZeNTKP2Mo640BUZXRJ9ghj2isw8Svl+Q7sFKt5r
 rixSuvpl1poXWJ0dxfO3O7pduFUofg6blxjiNjCB9OhdoThRjG4M1NGiXGzY45aloZbM
 SHe/3SzgwugFLOwu2stfeZvI4ZZIPwgzOwCh81/BRLm3Zqx+cDwZ5WEymWJ8SDbgCqzI
 sAoLjpkIzXI/StWpHfooTpc9TYKDEqWHsJU8FZVXNq2C20Yqun5W3p/twx+FN7anQCOU
 COYDVjr40C0dHffZ7zBDwHnjVPEbahJI6C+X94puxYBvp+KAjuAXAeNxbgYMYEOwO+f+
 sb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755098504; x=1755703304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oM9ILyNqf8hRKpJQN9H2UvfEAr/F3zJGCyrnotgeJps=;
 b=UnOL0QWRONCAYw44akxx25CMXwOB7Cztv1GGvFeusLOsXDa8uY8el3emJfzpIGJ1v2
 jNhuUY4NCqwo52Rvd/NRY300hjj4O7HuHyCp+CcbAANx5YDDqVq118kgE3NMNc8nEUzP
 YI0khg6FOdfuUXprrgZShm/5F6NY3j9tqTbHZuN35skzF+3C/Ab08b+UlTl3XiTejwwY
 5RuPYeqOSmElVIURl5Dvk+stjepHKEbjnSUV651JhMUAcGdGFcHwtNCJlYPyci+DbdXp
 0XfkF3Sfdhg5Rg31u3NDg+bXgeGU/ARYa10LuPJrc5Ikaq3Gz7q/3doGVDg2FEnjUvJV
 28XQ==
X-Gm-Message-State: AOJu0Yy0UgdkIUSKp63uuSMkCzNbdjxd+G4KdtiaDRIl0p8porClkWi7
 p/mcve123JkBaO72RPEj6UTwOJ7JyU5IVBquR7gZtAYqbRbMlAxAbYKcm3rMBbIef7g=
X-Gm-Gg: ASbGncsj2RyrYxvmA/2MzGpMt8p26IPM3fMAd0zgTYHwrONaqVC/7xOKzCYcI0/DrOu
 XXoGGrveKmEvtW/MLXyL3Fi43v04p16eV69xn3eOyTaIdOZAtbiMAhbXNCGO9tx9GR/l2SeAbSX
 txCeSjh0/WEQu0CWMTWxD4nu5XCOe7W0PkrtYLLTPuVl5eQDztWSO5EvIbuJAO8ao1d69uYxDZS
 WU6FkJoQNuuiyjUTjLqxlQwUh9pEkqFOB3P7MoRK7TzpdaJB3RD7uaqzKjjDAe6CfK6wu7muvCA
 PLRRkRObC9AVHSJBoBDDGB5uCwJW4ekfXoRkjbqrLaFqN/0FgAJEVgqp+sDirnHuMB8dgA4g66O
 jLrYji4J1r0Z7Py6udp2YCuQjd+cH+0/uQ29OjSO/1I/x9qu0myzYk6eQr+LruY+R6RYRtdkQF2
 Y=
X-Google-Smtp-Source: AGHT+IHhYQHEQOodDxqcmeD5iqTJ0onBscRnpMQ93kRFHNBkm8Nvri5jPE+hiGby9Kwsx0uGi5Addg==
X-Received: by 2002:a05:6000:1a8b:b0:3a5:39ee:2619 with SMTP id
 ffacd0b85a97d-3b917ebb5bamr2431423f8f.47.1755098504267; 
 Wed, 13 Aug 2025 08:21:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0683045sm39501603f8f.41.2025.08.13.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 08:21:44 -0700 (PDT)
Date: Wed, 13 Aug 2025 08:21:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: Re: [PATCH 1/1] ethdev: add link speed 800G
Message-ID: <20250813082140.3627a9a5@hermes.local>
In-Reply-To: <20250812144249.316120-1-thomas@monjalon.net>
References: <20250812144249.316120-1-thomas@monjalon.net>
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

On Tue, 12 Aug 2025 16:42:48 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> There are some devices supporting 800G speed,
> and it is well standardized in IEEE.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Applied to next-net
