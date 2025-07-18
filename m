Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484DDC83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 15:18:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C2E2402DB;
	Fri, 18 Jul 2025 17:18:42 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 48B6440144
 for <dev@dpdk.org>; Fri, 18 Jul 2025 17:18:41 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7e2c920058fso313100485a.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752851920;
 x=1753456720; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ioPX7+l4PgYhJh9YG2sG//1ivHOStUPhQkcRGu7FSM=;
 b=I+ZJuTR7a07E5O7hH+5BFdQLNTJGfEYLA2zfnhawCpIVxN/acxo8tsY9MNxXHLOC86
 P8NVtGvo4D6iYYFZo+9W2ZBg4EtCR5XeGcbPtiMsnNVybs+iTf22tH2QNziCabO3T167
 7GXQHdVIqQQ2ItUeCfD9LeLXlaqGN4iNA5YCR4uyEou8LaYUtdgPZBJwzU1prsWSeEH0
 23kDMAJUUHKI6Wwe47G0BOR5ey9JVyG3yhBoyQ4fuKN5uhIk1dmvUhkncZ1rbGVgZUys
 b30vJ7IcShPXmbOuKPipd+7iWu1pqhCJW/v+Sxt99MnZjPwsj1g1fMZ+xraEeGzMFrfU
 GKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752851920; x=1753456720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ioPX7+l4PgYhJh9YG2sG//1ivHOStUPhQkcRGu7FSM=;
 b=B3ZH2o2MR7CYdU8PdqiZoYVPidzGcrbaAk2q5rEwV5HO6RwyZkjjw72bkTDB/Tacvw
 EYj3PHjrmuRaQJ9jrsLngSwTwiwioj8pEuFZQgLCPXPGD9P7GjTfOjHel4XOvMVGfwxr
 /FGldCenXnAZup1hx8SVSe+3d23AOsdV0BxSHbj47c8WxByrw+73GjvO37KFTq333f7V
 RKxc95+A22V1nd4k3tilaGcJXoHb1cwUfDMY7xQAGee4GtjQMXG6vIK0zQQNuxMA7il0
 2knuEIPqQkiW7ImiUkt7JipwYeRhP9pZSjxWarJkuBIp8lhiw+WI9IZmFTOQ0t2fDW+3
 sOvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgwhhQS8vCJdj2VKo7iIfImJ2Bl6+2zkz9+hGNU2lsOFucLS972fEfGWHO2RWt599WDS8=@dpdk.org
X-Gm-Message-State: AOJu0YzXwQQwQ1GdQmQVAVJ5lP/cYIh2TEn3S2fDjwMjKtgGfl7DWVJ2
 oUZszXdKcKK8HP4N6QtvL8w3+BJ/Te3a4QtkgiZ/g+bNqeXfNLQjw5yAq8lf0sIeb7w=
X-Gm-Gg: ASbGncvdkxjmFCK4R445PregVOw1riczCiOM0acN/GuMmGbSE9Vd9ROWvUNR8iB3K4p
 EudVIUbKCOnnQ71KQxDsz0V00ILh3UCLgB652uHD/m6ZzTHn40DYw5n8Bg11w0Flj0212E2IOsB
 pFqC56CpqyJzc+uoSpWTlw2krbjbBPVhWfBXo3VS81XMkKVt/qGIGVkN+EWHvEwoCAy6NzO1zXY
 5r/XgRnqN+xXldYdxmOGs9FUj4/h1jJKev2CM9pa8s9aiDQlaq+cEwSSpKN7jJ9NMjUazIK96Lf
 NalWPtfYrOOnq2/7kFJHab5ifMmPytSjVBQDnW7qafpQes1f2cqk0cKjuWQojYnygqwsFAeOsq2
 xQBl1k3zw3IubfcaSb/OVs5pctJJ4q/sViQ5BOWrxPwDErYbXEsW7JMuSMgfDG2CGsDBKBc7Mid
 c=
X-Google-Smtp-Source: AGHT+IGpaEm3bNfAXkH5O1rSmV4IHauUFcwm563+p8ZwuaIOSBhqzX3/8SQBecfeMqfERlt4Opgz+w==
X-Received: by 2002:a05:620a:1a06:b0:7e3:30ca:4f92 with SMTP id
 af79cd13be357-7e3558d9884mr541334085a.16.1752851919558; 
 Fri, 18 Jul 2025 08:18:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c40130sm95760785a.59.2025.07.18.08.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 08:18:38 -0700 (PDT)
Date: Fri, 18 Jul 2025 08:18:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>
Subject: Re: [PATCH] net/mlx5: document IP fragment matching limitations
Message-ID: <20250718081835.15134b8c@hermes.local>
In-Reply-To: <20250718115156.1220403-1-dsosnowski@nvidia.com>
References: <20250718115156.1220403-1-dsosnowski@nvidia.com>
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

On Fri, 18 Jul 2025 13:51:56 +0200
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> NVIDIA NICs do not support matching on packet headers appearing
> after IP header if the received packet is an IP fragment.
> This patch updates the relevant documentation.
> 
> Bugzilla ID: 1417
> 
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

I suspect that is true of all NIC's because matching later fragments
would require state that would not scale in HW.
